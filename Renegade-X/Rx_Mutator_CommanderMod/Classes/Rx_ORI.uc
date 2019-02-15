/*
** Rx_ORI
*/

//MAY not need this, but may come in handy to update players that have just joined.

class Rx_ORI extends ReplicationInfo ;

//var Rx_HUD_Ext LHUD;

/***********************************
Both team's target information
**************************************/
struct AgingTarget 
{
	var Actor T_Actor ;
	var string T_Actor_Name;
	var float   T_Age;
	var bool  Oldest;
	var int Pawn_ID;
	var Vector VehLoc;
	var byte KillFlag; //0 Updated 1: Removed 2: Destroyed 3: Decayed 
	var byte LastKillFlag; //Set when Kill Flag is set, however this one only resets when the Kill flag has been removed. 
	var bool RemoveFlag; //Special Case for removal done by keybind.
};

struct AgingBTarget 
{
	var Rx_Building T_Building ;
	var float   T_Age;
	
};

struct Target_Array //used by the server (and to tell clients when things have changed)
{
	var AgingTarget 		T_Attack[3]; //Need the server actors, as we'll need to reference and update their location/stats
	var AgingTarget 		T_Defend[3];
	var AgingTarget 		T_Repair[3];
	var AgingBTarget B_Attack;
	var AgingBTarget B_Defend;
	var AgingBTarget B_Repair;
	var vector 		T_Waypoint; //Waypoints don't move on their own, so they just need to be a location
	var vector		T_DWaypoint;
	
	structDefaultProperties
	{
		T_Attack(0)=(T_Actor=none, T_Age=2, Oldest=true)  //Make sure 0 is the default oldest
		T_Defend(0)=(T_Actor=none, T_Age=2, Oldest=true) //Same goes for Defence targets 
		T_Repair(0)=(T_Actor=none, T_Age=2, Oldest=true) //Same goes for Repair targets 
	}
};

struct Local_TargetInfo 
{
	var AgingTarget 		T_Attack[3]; //Used by clients to draw targets locally. Only used for vehicles and pawns, as they differ from client to client. e.g, what is Rx_Pawn_0 to one is Rx_Pawn_12 to some other guy.
	var AgingTarget 		T_Defend[3];
	var AgingTarget 		T_Repair[3];
};

var Local_TargetInfo GDI_LocalInfo[3], NOD_LocalInfo[3]			; 

var repnotify Target_Array GDI_Targets[3], NOD_Targets[3]		;

var int TickFilter												;

var float AttackT_DecayTime, BuildingT_DecayTime, WayPointZOffset;

/**********************************************************
Both team's objective information
**********************************************************/
struct OBJECTIVE_INFO 
{
var	string 		OText		;
var int			O_Type		;
	
	structDefaultproperties 
	{
	OText="No Objective Set" 					
	O_Type=0
		
	}
};


var repnotify OBJECTIVE_INFO	Objective_GDI[3], Objective_NOD[3];

replication 
{
//if( bNetInitial && Role == ROLE_Authority )
	
if (bNetDirty && Role == ROLE_Authority)
GDI_Targets, NOD_Targets, Objective_GDI, Objective_NOD;

}


simulated function Tick(float DeltaTime)
{
	super.Tick(DeltaTime);

TickFilter++;


FilterDeadTargets(); //This sets all the kill flags to 0, so it needs to come 1st.

if(TickFilter >=4) 
{
TickTargetAges();
UpdateTargetAgeNod();
UpdateTargetAgeGDI();
}

	
if(TickFilter >=5) TickFilter=0;
	
	
}


reliable server function StoreObjective(string TeamS, int CT, int rank, string Obj)
{
	
	switch(TeamS)
	{
		case "GDI":
		Objective_GDI[rank].OText=Obj ;
		Objective_GDI[rank].O_Type=CT ;
		break;
		
		case "NOD":
		Objective_NOD[rank].OText=Obj ;
		Objective_NOD[rank].O_Type=CT ;
		break;
			
	}
	LogInternal(TeamS@"Objective Stored");
}

reliable server function Update_Markers (
string TeamS, //String of what team we're updating these for. The object keeps track of GDI/Nod targets, but only displays the targets that correspond with the 
int CT, //Type of call getting passed down. 0:Attack 1: Defend 2: Repair 3: Waypoint
int rank, //Whether to update Commander/CoCommander or Support Targets
bool isWaypointUpdate, // If we're looking to update a waypoint. If this is true, and CT is equal to 1, we'll update the defensive waypoint.
bool isBuildingUpdate, //If this is a building being targeted
optional Actor A,	//Actor we'll be marking
optional Actor B, //Actor that is more than likely a building, only used for specific instances
optional Vector WP_Coord, //Coordinates of the waypoint if this is a waypoint update
optional string A_String,	
optional Vector V_Loc,		//Second workaround for multiplayer, since vehicles have a tendency to get totally out of sync.
optional int P_ID			//3rd workround for multiplayer. Use the player ID of the pawn's PRI to determine what pawn to draw targets on on all clients. 	
)
{
local int i;
local bool Penetrated; //Used to tell if the updated target was able to just find an open spot.
local bool TryString;
local Pawn Converted_A, TempA;
local Rx_Vehicle Temp_V, Temp_NearestV;
local float DistToV, NearestVDist;
local name Converted_N ;
local Vector Temp_VVector;

NearestVDist=0.0;
Penetrated = false;
TryString = true ;
	//if(TeamS != MyTeam) EDIT : KEEP consistent just in case we switch teams. Won't have to refresh anything 
	
	
	//Alrighty... let's try to keep this civil
	
	if(P_ID != 0)  //There was more than likely a pawn given to us, so let's find it
	{
		
		LogInternal("Trying to convert PID to local Pawn");
		
		foreach AllActors(class'Pawn', TempA)
		{
			if(TempA.PlayerReplicationInfo != none && TempA.PlayerReplicationInfo.PlayerID == P_ID)
			{
			
			Converted_A=TempA;
			LogInternal(" Converted Player ID into Pawn : " $TempA);
			break;
			}	
		}
		
	}
	
	if(V_Loc.X != 0 && V_Loc.Y != 0 && V_Loc.Z !=0) //We likely received a vehicle, so convert it to a vehicle.
	{
		
		LogInternal("Trying to convert Vehicle location to local Vehicle Actor");
		
		foreach AllActors(class'Rx_Vehicle', Temp_V)
		{
			DistToV = VSize(V_Loc-Temp_V.location);
			LogInternal(Temp_V @"Is" @ DistToV @ "Away from established target." @ "Nearest V distance is: " @NearestVDist);
			if(NearestVDist == 0.0f || DistToV < NearestVDist)
			{
				
				LogInternal("New Closest Vehicle" @ Temp_V);
				NearestVDist = DistToV;
				Temp_NearestV = Temp_V;
				
				if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
				{
				LogInternal("Assuming if this is 0.0 away, then this is the the target");
				break;
				}
				
			}
		
		}	
		
			Converted_A=Temp_NearestV;
			LogInternal(" Converted Vehicle location into Vehicle : " $Converted_A);
			
	}	
		
		
	
	
	
	/**if(A == none)
	TryString=true;
	
	
	if(TryString) 
	{
		`log("Trying to convert string to name to Actor");
		Converted_N=name(A_String);
		`log(Converted_N);
		
		foreach AllActors(class'Pawn', TempA)
		{
			if(TempA.PlayerReplicationInfo.PlayerID == Converted_N)
			{
			
			Converted_A=TempA;
			`log( " Converted Converted name in to actor : " $TempA);
			break;
			}	
		}
		
		
	}
	*/
	switch (CT) 
	{
		case 0:
		
		///////////////////////////Attack section for GDI/////////////////////////
		//If it's for GDI, update GDI attack markers
		if(TeamS == "GDI") 
		{
		//Find an open attack marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(GDI_Targets[rank].T_Attack[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) GDI_Targets[rank].T_Attack[i].T_Actor = A ; //unoccupied, so take it
					else
					{
						
					GDI_Targets[rank].T_Attack[i].KillFlag=0;
					GDI_Targets[rank].T_Attack[i].T_Actor = Converted_A ;	
					GDI_Targets[rank].T_Attack[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						
						GDI_Targets[rank].T_Attack[i].VehLoc=V_Loc;
						
						GDI_LocalInfo[rank].T_Attack[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Attack[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Attack[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					GDI_Targets[rank].T_Attack[i].KillFlag=0;
					GDI_Targets[rank].T_Attack[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Attack[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Attack[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Attack[i].VehLoc.Z = 0;
					
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.Z = 0;
					
					}
				
					GDI_Targets[rank].T_Attack[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Attack[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(GDI_Targets[rank].T_Attack[i].T_Actor != none && GDI_Targets[rank].T_Attack[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) GDI_Targets[rank].T_Attack[i].T_Actor = A ; //GTFO
					else
					{
					GDI_Targets[rank].T_Attack[i].KillFlag=0;
					GDI_Targets[rank].T_Attack[i].T_Actor = Converted_A ; 
					GDI_Targets[rank].T_Attack[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						GDI_Targets[rank].T_Attack[i].VehLoc=V_Loc;
						GDI_LocalInfo[rank].T_Attack[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Attack[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Attack[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					
					GDI_Targets[rank].T_Attack[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Attack[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Attack[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Attack[i].VehLoc.Z = 0;
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Attack[i].VehLoc.Z = 0;
					
					}
				
				GDI_Targets[rank].T_Attack[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Attack[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeGDI();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				GDI_Targets[rank].B_Attack.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this
				GDI_Targets[rank].B_Attack.T_Age=0;
			}
			
			
			
		}
		
		///////////////////////////Attack section for NOD/////////////////////////
		//If it's for NOD, update NOD attack markers
		if(TeamS == "NOD") 
		{
		//Find an open attack marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(NOD_Targets[rank].T_Attack[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) NOD_Targets[rank].T_Attack[i].T_Actor = A ; //unoccupied, so take it
					else
					{
					NOD_Targets[rank].T_Attack[i].KillFlag=0;
					NOD_Targets[rank].T_Attack[i].T_Actor = Converted_A ;	
					NOD_Targets[rank].T_Attack[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Attack[i].VehLoc=V_Loc;
						
						NOD_LocalInfo[rank].T_Attack[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Attack[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Attack[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Attack[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Attack[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Attack[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Attack[i].VehLoc.Z = 0;
					
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.Z = 0;
					
					}
				
					NOD_Targets[rank].T_Attack[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Attack[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(NOD_Targets[rank].T_Attack[i].T_Actor != none && NOD_Targets[rank].T_Attack[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) NOD_Targets[rank].T_Attack[i].T_Actor = A ; //GTFO
					else
					{
					NOD_Targets[rank].T_Attack[i].KillFlag=0;
					NOD_Targets[rank].T_Attack[i].T_Actor = Converted_A ; 
					NOD_Targets[rank].T_Attack[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Attack[i].VehLoc=V_Loc;
						NOD_LocalInfo[rank].T_Attack[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Attack[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Attack[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Attack[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Attack[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Attack[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Attack[i].VehLoc.Z = 0;
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Attack[i].VehLoc.Z = 0;
					
					}
				
				NOD_Targets[rank].T_Attack[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Attack[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeNOD();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				NOD_Targets[rank].B_Attack.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this. We just need to know which building
				NOD_Targets[rank].B_Attack.T_Age=0;
			}
			
		}
		break;
		
		
		case 1: // Defence update 
		
		///////////////////////////Defend section for GDI/////////////////////////
		//If it's for GDI, update GDI Defend markers
		if(TeamS == "GDI") 
		{
			
		if(isWaypointUpdate)
			{
			//Set defensive waypoint if that's what this is
			GDI_Targets[rank].T_DWaypoint.X = WP_Coord.X ;
			GDI_Targets[rank].T_DWaypoint.Y = WP_Coord.Y ;
			GDI_Targets[rank].T_DWaypoint.Z = WP_Coord.Z+WayPointZOffset; //Add 100 so it's not sitting on the ground
			}		
			
			//Find an open Defend marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(GDI_Targets[rank].T_Defend[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) GDI_Targets[rank].T_Defend[i].T_Actor = A ; //unoccupied, so take it
					else
					{
					GDI_Targets[rank].T_Defend[i].KillFlag=0;
					GDI_Targets[rank].T_Defend[i].T_Actor = Converted_A ;	
					GDI_Targets[rank].T_Defend[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						GDI_Targets[rank].T_Defend[i].VehLoc=V_Loc;
						
						GDI_LocalInfo[rank].T_Defend[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Defend[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Defend[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					GDI_Targets[rank].T_Defend[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Defend[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Defend[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Defend[i].VehLoc.Z = 0;
					
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.Z = 0;
					
					}
				
					GDI_Targets[rank].T_Defend[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Defend[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(GDI_Targets[rank].T_Defend[i].T_Actor != none && GDI_Targets[rank].T_Defend[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) GDI_Targets[rank].T_Defend[i].T_Actor = A ; //GTFO
					else
					{
					GDI_Targets[rank].T_Defend[i].KillFlag=0;
					GDI_Targets[rank].T_Defend[i].T_Actor = Converted_A ; 
					GDI_Targets[rank].T_Defend[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						GDI_Targets[rank].T_Defend[i].VehLoc=V_Loc;
						GDI_LocalInfo[rank].T_Defend[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Defend[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Defend[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					GDI_Targets[rank].T_Defend[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Defend[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Defend[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Defend[i].VehLoc.Z = 0;
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Defend[i].VehLoc.Z = 0;
					
					}
				
				GDI_Targets[rank].T_Defend[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Defend[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeGDI();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				GDI_Targets[rank].B_Defend.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this but tell what building to draw at
				GDI_Targets[rank].B_Defend.T_Age=0;
			}
			
			
			
			
		}
		
		///////////////////////////Defend section for NOD/////////////////////////
		//If it's for NOD, update NOD Defend markers
		if(TeamS == "NOD") 
		{
			
		if(isWaypointUpdate)
			{
			//Set defensive waypoint if that's what this is
			NOD_Targets[rank].T_DWaypoint.X = WP_Coord.X ;
			NOD_Targets[rank].T_DWaypoint.Y = WP_Coord.Y ;
			NOD_Targets[rank].T_DWaypoint.Z = WP_Coord.Z+WayPointZOffset; //Add 100 so it's not sitting on the ground
			}		
			
			//Find an open Defend marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(NOD_Targets[rank].T_Defend[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) NOD_Targets[rank].T_Defend[i].T_Actor = A ; //unoccupied, so take it
					else
					{
					NOD_Targets[rank].T_Defend[i].KillFlag=0;
					NOD_Targets[rank].T_Defend[i].T_Actor = Converted_A ;	
					NOD_Targets[rank].T_Defend[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Defend[i].VehLoc=V_Loc;
						
						NOD_LocalInfo[rank].T_Defend[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Defend[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Defend[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Defend[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Defend[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Defend[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Defend[i].VehLoc.Z = 0;
					
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.Z = 0;
					
					}
				
					NOD_Targets[rank].T_Defend[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Defend[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(NOD_Targets[rank].T_Defend[i].T_Actor != none && NOD_Targets[rank].T_Defend[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) NOD_Targets[rank].T_Defend[i].T_Actor = A ; //GTFO
					else
					{
					NOD_Targets[rank].T_Defend[i].KillFlag=0;
					NOD_Targets[rank].T_Defend[i].T_Actor = Converted_A ; 
					NOD_Targets[rank].T_Defend[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Defend[i].VehLoc=V_Loc;
						NOD_LocalInfo[rank].T_Defend[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Defend[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Defend[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Defend[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Defend[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Defend[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Defend[i].VehLoc.Z = 0;
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Defend[i].VehLoc.Z = 0;
					
					}
				
				NOD_Targets[rank].T_Defend[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Defend[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeNOD();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				NOD_Targets[rank].B_Defend.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this but tell what building to draw at
				NOD_Targets[rank].B_Defend.T_Age=0;
			}
			
		}
		
		
		break;
		
		case 2:
	///////////////////////////Repair section for GDI/////////////////////////
		//If it's for GDI, update GDI Repair markers
		if(TeamS == "GDI") 
		{
		//Find an open Repair marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(GDI_Targets[rank].T_Repair[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) GDI_Targets[rank].T_Repair[i].T_Actor = A ; //unoccupied, so take it
					else
					{
					GDI_Targets[rank].T_Repair[i].KillFlag=0;
					GDI_Targets[rank].T_Repair[i].T_Actor = Converted_A ;	
					GDI_Targets[rank].T_Repair[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						GDI_Targets[rank].T_Repair[i].VehLoc=V_Loc;
						
						GDI_LocalInfo[rank].T_Repair[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Repair[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Repair[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					GDI_Targets[rank].T_Repair[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Repair[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Repair[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Repair[i].VehLoc.Z = 0;
					
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.Z = 0;
					
					}
				
					GDI_Targets[rank].T_Repair[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Repair[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(GDI_Targets[rank].T_Repair[i].T_Actor != none && GDI_Targets[rank].T_Repair[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) GDI_Targets[rank].T_Repair[i].T_Actor = A ; //GTFO
					else
					{
					GDI_Targets[rank].T_Repair[i].KillFlag=0;
					GDI_Targets[rank].T_Repair[i].T_Actor = Converted_A ; 
					GDI_Targets[rank].T_Repair[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						GDI_Targets[rank].T_Repair[i].VehLoc=V_Loc;
						GDI_LocalInfo[rank].T_Repair[i].VehLoc=V_Loc;
						GDI_Targets[rank].T_Repair[i].Pawn_ID=0;
						GDI_LocalInfo[rank].T_Repair[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					GDI_Targets[rank].T_Repair[i].Pawn_ID=P_ID;
					GDI_LocalInfo[rank].T_Repair[i].Pawn_ID=P_ID;	
					
					GDI_Targets[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_Targets[rank].T_Repair[i].VehLoc.Y = 0;
					GDI_Targets[rank].T_Repair[i].VehLoc.Z = 0;
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.Y = 0;
					GDI_LocalInfo[rank].T_Repair[i].VehLoc.Z = 0;
					
					}
				
				GDI_Targets[rank].T_Repair[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					GDI_Targets[rank].T_Repair[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeGDI();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				GDI_Targets[rank].B_Repair.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this
				GDI_Targets[rank].B_Repair.T_Age=0;
			}
			
			
			
		}
		
		///////////////////////////Repair section for NOD/////////////////////////
		//If it's for NOD, update NOD Repair markers
		if(TeamS == "NOD") 
		{
		//Find an open Repair marker spot and put it there. If you can't find one, override the oldest
		if(!isBuildingUpdate)
			{
				LogInternal("--------Recieved Actor as target: "$A $Converted_A);
				if(A == none && Converted_A == none) return;
				for (i=0;i<3;i++) //Initially, just see if there's an open spot
				{
				
				if(NOD_Targets[rank].T_Repair[i].T_Actor == none) //Is there nothing here?
				
					{
					if(!TryString) NOD_Targets[rank].T_Repair[i].T_Actor = A ; //unoccupied, so take it
					else
					{
					NOD_Targets[rank].T_Repair[i].KillFlag=0;
					NOD_Targets[rank].T_Repair[i].T_Actor = Converted_A ;	
					NOD_Targets[rank].T_Repair[i].T_Actor_Name = string (Converted_A.name);
					}
			//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Repair[i].VehLoc=V_Loc;
						
						NOD_LocalInfo[rank].T_Repair[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Repair[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Repair[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Repair[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Repair[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Repair[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Repair[i].VehLoc.Z = 0;
					
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.Z = 0;
					
					}
				
					NOD_Targets[rank].T_Repair[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Repair[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					break;
					}		
				}
				
				//I didn't make it in, so get hostile
			if(!Penetrated) 
				{
					for (i=0;i<3;i++) //Find the oldest then, and kick his ass.
					{
				
					if(NOD_Targets[rank].T_Repair[i].T_Actor != none && NOD_Targets[rank].T_Repair[i].Oldest==true) //You old? GTFO
				
						{
							
					if(!TryString) NOD_Targets[rank].T_Repair[i].T_Actor = A ; //GTFO
					else
					{
					NOD_Targets[rank].T_Repair[i].KillFlag=0;
					NOD_Targets[rank].T_Repair[i].T_Actor = Converted_A ; 
					NOD_Targets[rank].T_Repair[i].T_Actor_Name = string (Converted_A.name);
					}
					
				//Set server and local vehicle info to be used.
					if(Rx_Vehicle(Converted_A) != none)  
					{
						NOD_Targets[rank].T_Repair[i].VehLoc=V_Loc;
						NOD_LocalInfo[rank].T_Repair[i].VehLoc=V_Loc;
						NOD_Targets[rank].T_Repair[i].Pawn_ID=0;
						NOD_LocalInfo[rank].T_Repair[i].Pawn_ID=0; //Make sure PID is really 0 since this is a vehicle
					}
					
					if(Rx_Pawn(Converted_A) != none) 
					{
					NOD_Targets[rank].T_Repair[i].Pawn_ID=P_ID;
					NOD_LocalInfo[rank].T_Repair[i].Pawn_ID=P_ID;	
					
					NOD_Targets[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_Targets[rank].T_Repair[i].VehLoc.Y = 0;
					NOD_Targets[rank].T_Repair[i].VehLoc.Z = 0;
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.X = 0; //Delete any possible values from VehLoc
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.Y = 0;
					NOD_LocalInfo[rank].T_Repair[i].VehLoc.Z = 0;
					
					}
				
				NOD_Targets[rank].T_Repair[i].T_Age = i*0.0001 ; //set its age (Use i so initial setting of 3 targets will all have staggered values, with the 1st target run across being counted as the oldest)
					NOD_Targets[rank].T_Repair[i].Oldest = false ; //Not the Oldest until proven
					Penetrated = true;
					UpdateTargetAgeNOD();	//Force an update call here, otherwise when this statement reiterates, nothing will be the Oldest.
					break;
						}		
					}
				}			
			}
			
			if(isBuildingUpdate) 
			{
				NOD_Targets[rank].B_Repair.T_Building=Rx_Building(B); //Can't really think of needing to do much more with this
				NOD_Targets[rank].B_Repair.T_Age=0;
			}
			
		}
		break;
	
		case 3:
		///////////////////////////TakePoint section for GDI/////////////////////////
		//If it's for GDI, update GDI Waypoint///
		if(TeamS == "GDI") 
		{
					
			if(isWaypointUpdate)
			{
			//Set defensive waypoint if that's what this is
			GDI_Targets[rank].T_Waypoint.X = WP_Coord.X ;
			GDI_Targets[rank].T_Waypoint.Y = WP_Coord.Y ;
			GDI_Targets[rank].T_Waypoint.Z = WP_Coord.Z+WayPointZOffset ;
			}
			
			
		}
		
		///////////////////////////TakePoint section for NOD/////////////////////////
		//If it's for NOD, update NOD Waypoint////
		if(TeamS == "NOD") 
		{
		
		
		if(isWaypointUpdate)
			{
			LogInternal("Setting Waypoint in ORI ");
			//Set defensive waypoint if that's what this is
			NOD_Targets[rank].T_Waypoint.X = WP_Coord.X ;
			NOD_Targets[rank].T_Waypoint.Y = WP_Coord.Y ;
			NOD_Targets[rank].T_Waypoint.Z = WP_Coord.Z+WayPointZOffset ;
			}
		
		
	
		}
	break;
	
	default:
	return;
	}
}


/******************************************************
* Functions to handle Target Ages/Deaths... reasons to override or erase them
******************************************************/

reliable server function EraseTargets(int OType, int rank, int ITeam)
{

local int U;

if(ITeam==0) //GDI
{
	switch(OType)
	{
	case 0: 
		for(U=0;U<3;U++)
		{
		//reset Attack targets
				GDI_Targets[rank].T_Attack[U].KillFlag=1;				//0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[rank].T_Attack[U].T_Actor = none;
				GDI_Targets[rank].T_Attack[U].T_Age=0;
				GDI_Targets[rank].T_Attack[U].Oldest=false;
				GDI_Targets[rank].T_Attack[U].Pawn_ID=0;
				GDI_Targets[rank].T_Attack[U].T_Actor_Name="";
				GDI_Targets[rank].T_Attack[U].RemoveFlag=true;
				GDI_Targets[rank].T_Attack[U].VehLoc.X=0;
				GDI_Targets[rank].T_Attack[U].VehLoc.Y=0;
				GDI_Targets[rank].T_Attack[U].VehLoc.Z=0;
		}
		break;
	
	case 1: 
		for(U=0;U<3;U++)
		{
		//reset Defend targets 
				GDI_Targets[rank].T_Defend[U].KillFlag=1; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[rank].T_Defend[U].T_Actor = none;
				GDI_Targets[rank].T_Defend[U].T_Age=0;
				GDI_Targets[rank].T_Defend[U].Oldest=false;
				GDI_Targets[rank].T_Defend[U].Pawn_ID=0;
				GDI_Targets[rank].T_Defend[U].T_Actor_Name="";
				GDI_Targets[rank].T_Defend[U].RemoveFlag=true;
				GDI_Targets[rank].T_Defend[U].VehLoc.X=0;
				GDI_Targets[rank].T_Defend[U].VehLoc.Y=0;
				GDI_Targets[rank].T_Defend[U].VehLoc.Z=0;
		//Add functionality for D-waypoint.
			GDI_Targets[rank].T_DWaypoint.X =0 ;
			GDI_Targets[rank].T_DWaypoint.Y = 0 ;
			GDI_Targets[rank].T_DWaypoint.Z = 0 ;
			
		
		}
		break;
	case 2: 
		for(U=0;U<3;U++)
		{
		//reset Defend targets 
				GDI_Targets[rank].T_Repair[U].KillFlag=1; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[rank].T_Repair[U].T_Actor = none;
				GDI_Targets[rank].T_Repair[U].T_Age=0;
				GDI_Targets[rank].T_Repair[U].Oldest=false;
				GDI_Targets[rank].T_Repair[U].Pawn_ID=0;
				GDI_Targets[rank].T_Repair[U].T_Actor_Name="";
				GDI_Targets[rank].T_Repair[U].RemoveFlag=true;
				GDI_Targets[rank].T_Repair[U].VehLoc.X=0;
				GDI_Targets[rank].T_Repair[U].VehLoc.Y=0;
				GDI_Targets[rank].T_Repair[U].VehLoc.Z=0;
		}
		break;
		
		case 3: 
		for(U=0;U<3;U++)
		{
		//reset waypoint
		//Waypoints don't use killflags, they just look to see if it's 0,0,0 and if so assume it was removed.
			GDI_Targets[rank].T_Waypoint.X =0 ;
			GDI_Targets[rank].T_Waypoint.Y = 0 ;
			GDI_Targets[rank].T_Waypoint.Z = 0 ;
		
		}
		break;
	
	}
	
	
}


if(ITeam==1) //NOD	

{
	switch(OType)
	{
	case 0: 
		for(U=0;U<3;U++)
		{
		//reset Attack targets
				NOD_Targets[rank].T_Attack[U].KillFlag=1;
				NOD_Targets[rank].T_Attack[U].T_Actor = none;
				NOD_Targets[rank].T_Attack[U].T_Age=0;
				NOD_Targets[rank].T_Attack[U].Oldest=false;
				NOD_Targets[rank].T_Attack[U].Pawn_ID=0;
				NOD_Targets[rank].T_Attack[U].T_Actor_Name="";
				NOD_Targets[rank].T_Attack[U].RemoveFlag=true;
				LogInternal("KillFlag in function:"@NOD_Targets[rank].T_Attack[U].KillFlag);
				NOD_Targets[rank].T_Attack[U].VehLoc.X=0;
				NOD_Targets[rank].T_Attack[U].VehLoc.Y=0;
				NOD_Targets[rank].T_Attack[U].VehLoc.Z=0;
		}
		break;
	
	case 1: 
		for(U=0;U<3;U++)
		{
		//reset Defend targets 
				NOD_Targets[rank].T_Defend[U].KillFlag=1;
				NOD_Targets[rank].T_Defend[U].T_Actor = none;
				NOD_Targets[rank].T_Defend[U].T_Age=0;
				NOD_Targets[rank].T_Defend[U].Oldest=false;
				NOD_Targets[rank].T_Defend[U].Pawn_ID=0;
				NOD_Targets[rank].T_Defend[U].T_Actor_Name="";
				NOD_Targets[rank].T_Defend[U].RemoveFlag=true;
				NOD_Targets[rank].T_Defend[U].VehLoc.X=0;
				NOD_Targets[rank].T_Defend[U].VehLoc.Y=0;
				NOD_Targets[rank].T_Defend[U].VehLoc.Z=0;
		//Add functionality for D-waypoint.
		NOD_Targets[rank].T_DWaypoint.X =0 ;
		NOD_Targets[rank].T_DWaypoint.Y = 0 ;
		NOD_Targets[rank].T_DWaypoint.Z = 0 ;
		}
		break;
	case 2: 
		for(U=0;U<3;U++)
		{
		//reset Repair targets 
				NOD_Targets[rank].T_Repair[U].KillFlag=1;
				NOD_Targets[rank].T_Repair[U].T_Actor = none;
				NOD_Targets[rank].T_Repair[U].T_Age=0;
				NOD_Targets[rank].T_Repair[U].Oldest=false;
				NOD_Targets[rank].T_Repair[U].Pawn_ID=0;
				NOD_Targets[rank].T_Repair[U].T_Actor_Name="";
				NOD_Targets[rank].T_Repair[U].RemoveFlag=true;
				NOD_Targets[rank].T_Repair[U].VehLoc.X=0;
				NOD_Targets[rank].T_Repair[U].VehLoc.Y=0;
				NOD_Targets[rank].T_Repair[U].VehLoc.Z=0;
		}
		break;
		
		case 3: 
		for(U=0;U<3;U++)
		{
		//reset Take Waypoint targets 
				NOD_Targets[rank].T_Waypoint.X =0 ;
			NOD_Targets[rank].T_Waypoint.Y = 0 ;
			NOD_Targets[rank].T_Waypoint.Z = 0 ;
		
		}
		break;
	
	}
	
	
}

	
	
	
}




simulated function FilterDeadTargets()
{

local int i, j;
//Clear GDI dead targets 
for (i=0; i<3; i++)
		{
			for(j=0;j<3;j++)
			{
				/**
				//Kill flags all start at zero
			if(GDI_Targets[i].T_Attack[j].KillFlag !=0 && GDI_Targets[i].T_Attack[j].KillFlag !=1) GDI_Targets[i].T_Attack[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
			//Kill flags all start at zero
			if(GDI_Targets[i].T_Defend[j].KillFlag !=0 && GDI_Targets[i].T_Defend[j].KillFlag !=1) GDI_Targets[i].T_Defend[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 	
			//Kill flags all start at zero
			if(GDI_Targets[i].T_Repair[j].KillFlag !=0 && GDI_Targets[i].T_Repair[j].KillFlag !=1) GDI_Targets[i].T_Repair[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 	
				
				//Erasing/Removing targets (KillFlag 1) is done through a key, and therefore is not called in the normal course of the Actor's Tick and such. By the time the KillFlag is read by ObjectiveVisuals, it is already 0 again if we don't make a second flag that makes it wait to remove a KillFlag of 1 till next frame.
				if(!GDI_Targets[i].T_Attack[j].RemoveFlag) GDI_Targets[i].T_Attack[j].KillFlag=0;
				if(!GDI_Targets[i].T_Defend[j].RemoveFlag) GDI_Targets[i].T_Defend[j].KillFlag=0;
				if(!GDI_Targets[i].T_Repair[j].RemoveFlag) GDI_Targets[i].T_Repair[j].KillFlag=0;
				
				if(GDI_Targets[i].T_Attack[j].RemoveFlag) GDI_Targets[i].T_Attack[j].RemoveFlag=false;
				if(GDI_Targets[i].T_Defend[j].RemoveFlag) GDI_Targets[i].T_Defend[j].RemoveFlag=false;
				if(GDI_Targets[i].T_Repair[j].RemoveFlag) GDI_Targets[i].T_Repair[j].RemoveFlag=false;
				*/
				
			//Attack Targets
			
			
			if(GDI_Targets[i].T_Attack[j].T_Actor != none) 
				if( (Rx_Pawn(GDI_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Pawn(GDI_Targets[i].T_Attack[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(GDI_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Vehicle(GDI_Targets[i].T_Attack[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				GDI_Targets[i].T_Attack[j].KillFlag=2;
				GDI_Targets[i].T_Attack[j].T_Actor = none;
				GDI_Targets[i].T_Attack[j].T_Age=0;
				GDI_Targets[i].T_Attack[j].Oldest=false;
				GDI_Targets[i].T_Attack[j].Pawn_ID=0;
				GDI_Targets[i].T_Attack[j].T_Actor_Name="";
				 //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[i].T_Attack[j].VehLoc.X=0;
				GDI_Targets[i].T_Attack[j].VehLoc.Y=0;
				GDI_Targets[i].T_Attack[j].VehLoc.Z=0;
				}
				
			//Defence Targets
			//Defend Targets
			if(GDI_Targets[i].T_Defend[j].T_Actor != none) 
				if( (Rx_Pawn(GDI_Targets[i].T_Defend[j].T_Actor)!=none && Rx_Pawn(GDI_Targets[i].T_Defend[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(GDI_Targets[i].T_Defend[j].T_Actor)!=none && Rx_Vehicle(GDI_Targets[i].T_Defend[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				GDI_Targets[i].T_Defend[j].KillFlag=2; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[i].T_Defend[j].T_Actor = none;
				GDI_Targets[i].T_Defend[j].T_Age=0;
				GDI_Targets[i].T_Defend[j].Oldest=false;
				GDI_Targets[i].T_Defend[j].Pawn_ID=0;
				GDI_Targets[i].T_Defend[j].T_Actor_Name="";
				GDI_Targets[i].T_Defend[j].VehLoc.X=0;
				GDI_Targets[i].T_Defend[j].VehLoc.Y=0;
				GDI_Targets[i].T_Defend[j].VehLoc.Z=0;
				}
			
			//Repair Targets
			if(GDI_Targets[i].T_Repair[j].T_Actor != none) 
				if( (Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor)!=none && Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor)!=none && Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				GDI_Targets[i].T_Repair[j].KillFlag=2; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				GDI_Targets[i].T_Repair[j].T_Actor = none;
				GDI_Targets[i].T_Repair[j].T_Age=0;
				GDI_Targets[i].T_Repair[j].Oldest=false;
				GDI_Targets[i].T_Repair[j].Pawn_ID=0;
				GDI_Targets[i].T_Repair[j].T_Actor_Name="";
				GDI_Targets[i].T_Repair[j].VehLoc.X=0;
				GDI_Targets[i].T_Repair[j].VehLoc.Y=0;
				GDI_Targets[i].T_Repair[j].VehLoc.Z=0;
				}
			
			}
		
		}	

//Clear Nod dead targets

for (i=0; i<3; i++)
		{
			for(j=0;j<3;j++)
			{
				/**
				//Kill flags all start at zero
			if(NOD_Targets[i].T_Attack[j].KillFlag !=0 && NOD_Targets[i].T_Attack[j].KillFlag !=1) NOD_Targets[i].T_Attack[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
			//Kill flags all start at zero
			if(NOD_Targets[i].T_Defend[j].KillFlag !=0 && NOD_Targets[i].T_Defend[j].KillFlag !=1) NOD_Targets[i].T_Defend[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 	
			//Kill flags all start at zero
			if(NOD_Targets[i].T_Repair[j].KillFlag !=0 && NOD_Targets[i].T_Repair[j].KillFlag !=1) NOD_Targets[i].T_Repair[j].KillFlag=0; //0: Updated 1: Removed 2: Destroyed 3: Decayed 	
				
				//Erasing/Removing targets (KillFlag 1) is done through a key, and therefore is not called in the normal course of the Actor's Tick and such. By the time the KillFlag is read by ObjectiveVisuals, it is already 0 again if we don't make a second flag that makes it wait to remove a KillFlag of 1 till next frame.
				if(!NOD_Targets[i].T_Attack[j].RemoveFlag) NOD_Targets[i].T_Attack[j].KillFlag=0;
				if(!NOD_Targets[i].T_Defend[j].RemoveFlag) NOD_Targets[i].T_Defend[j].KillFlag=0;
				if(!NOD_Targets[i].T_Repair[j].RemoveFlag) NOD_Targets[i].T_Repair[j].KillFlag=0;
				
				if(NOD_Targets[i].T_Attack[j].RemoveFlag) NOD_Targets[i].T_Attack[j].RemoveFlag=false;
				if(NOD_Targets[i].T_Defend[j].RemoveFlag) NOD_Targets[i].T_Defend[j].RemoveFlag=false;
				if(NOD_Targets[i].T_Repair[j].RemoveFlag) NOD_Targets[i].T_Repair[j].RemoveFlag=false;
				
				*/
			//Attack Targets
			if(NOD_Targets[i].T_Attack[j].T_Actor != none) 
				if( (Rx_Pawn(NOD_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Pawn(NOD_Targets[i].T_Attack[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(NOD_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Vehicle(NOD_Targets[i].T_Attack[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				NOD_Targets[i].T_Attack[j].KillFlag=2; //0: Updated 1: Removed 2: Destroyed 3: Decayed 
				NOD_Targets[i].T_Attack[j].T_Actor = none;
				NOD_Targets[i].T_Attack[j].T_Age=0;
				NOD_Targets[i].T_Attack[j].Oldest=false;
				NOD_Targets[i].T_Attack[j].Pawn_ID=0;
				NOD_Targets[i].T_Attack[j].T_Actor_Name="";
				
				NOD_Targets[i].T_Attack[j].VehLoc.X=0;
				NOD_Targets[i].T_Attack[j].VehLoc.Y=0;
				NOD_Targets[i].T_Attack[j].VehLoc.Z=0;
				}
				
			//Defence Targets
			//Defend Targets
			if(NOD_Targets[i].T_Defend[j].T_Actor != none) 
				if( (Rx_Pawn(NOD_Targets[i].T_Defend[j].T_Actor)!=none && Rx_Pawn(NOD_Targets[i].T_Defend[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(NOD_Targets[i].T_Defend[j].T_Actor)!=none && Rx_Vehicle(NOD_Targets[i].T_Defend[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				NOD_Targets[i].T_Defend[j].KillFlag=2; //0: Updated 1: Removed 2: Destroyed 3: Decayed 4: Repaired
				NOD_Targets[i].T_Defend[j].T_Actor = none;
				NOD_Targets[i].T_Defend[j].T_Age=0;
				NOD_Targets[i].T_Defend[j].Oldest=false;
				NOD_Targets[i].T_Defend[j].Pawn_ID=0;
				NOD_Targets[i].T_Defend[j].T_Actor_Name="";
				NOD_Targets[i].T_Defend[j].VehLoc.X=0;
				NOD_Targets[i].T_Defend[j].VehLoc.Y=0;
				NOD_Targets[i].T_Defend[j].VehLoc.Z=0;
				}
			
			//Repair Targets
			if(NOD_Targets[i].T_Repair[j].T_Actor != none) 
				if( (Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor)!=none && Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor)!=none && Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				NOD_Targets[i].T_Repair[j].KillFlag=2; //0: Updated 1: Removed 2: Destroyed 3: Decayed 4: Repaired
				NOD_Targets[i].T_Repair[j].T_Actor = none;
				NOD_Targets[i].T_Repair[j].T_Age=0;
				NOD_Targets[i].T_Repair[j].Oldest=false;
				NOD_Targets[i].T_Repair[j].Pawn_ID=0;
				NOD_Targets[i].T_Repair[j].T_Actor_Name="";
				NOD_Targets[i].T_Repair[j].VehLoc.X=0;
				NOD_Targets[i].T_Repair[j].VehLoc.Y=0;
				NOD_Targets[i].T_Repair[j].VehLoc.Z=0;
				}
			}
		
		}	
	
}



simulated function UpdateTargetAgeGDI()
{
local int T,U;

//Full variant
for(T=0;T<3;T++) //Find who's oldest... 
	{
	for(U=0;U<3;U++) 
		{
		//GDI//
		
		//Attack Targets 
		if(GDI_Targets[T].T_Attack[U].T_Age == MaxofThree(GDI_Targets[T].T_Attack[0].T_Age, GDI_Targets[T].T_Attack[1].T_Age, GDI_Targets[T].T_Attack[2].T_Age)) GDI_Targets[T].T_Attack[U].Oldest=true ;		
		else
		GDI_Targets[T].T_Attack[U].Oldest=false ;
		
		//Defence Targets
		if(GDI_Targets[T].T_Defend[U].T_Age == MaxofThree(GDI_Targets[T].T_Defend[0].T_Age, GDI_Targets[T].T_Defend[1].T_Age, GDI_Targets[T].T_Defend[2].T_Age)) GDI_Targets[T].T_Defend[U].Oldest=true ;		
		else
		GDI_Targets[T].T_Defend[U].Oldest=false ;
	
		//Repair Targets
		if(GDI_Targets[T].T_Repair[U].T_Age == MaxofThree(GDI_Targets[T].T_Repair[0].T_Age, GDI_Targets[T].T_Repair[1].T_Age, GDI_Targets[T].T_Repair[2].T_Age)) GDI_Targets[T].T_Repair[U].Oldest=true ;		
		else
		GDI_Targets[T].T_Repair[U].Oldest=false ;
	
		
		}
	}	

}

simulated function UpdateTargetAgeNod()
{
local int T,U;

//Full variant
for(T=0;T<3;T++) //Find who's oldest... 
	{
	for(U=0;U<3;U++) 
		{
	
		//NOD//
		//Attack Targets 
		if(NOD_Targets[T].T_Attack[U].T_Age == MaxofThree(NOD_Targets[T].T_Attack[0].T_Age, NOD_Targets[T].T_Attack[1].T_Age, NOD_Targets[T].T_Attack[2].T_Age)) NOD_Targets[T].T_Attack[U].Oldest=true ;		
		else
		NOD_Targets[T].T_Attack[U].Oldest=false ;
		
		//Defence Targets
		if(NOD_Targets[T].T_Defend[U].T_Age == MaxofThree(NOD_Targets[T].T_Defend[0].T_Age, NOD_Targets[T].T_Defend[1].T_Age, NOD_Targets[T].T_Defend[2].T_Age)) NOD_Targets[T].T_Defend[U].Oldest=true ;		
		else
		NOD_Targets[T].T_Defend[U].Oldest=false ;
	
		//Repair Targets
		if(NOD_Targets[T].T_Repair[U].T_Age == MaxofThree(NOD_Targets[T].T_Repair[0].T_Age, NOD_Targets[T].T_Repair[1].T_Age, NOD_Targets[T].T_Repair[2].T_Age)) NOD_Targets[T].T_Repair[U].Oldest=true ;		
		else
		NOD_Targets[T].T_Repair[U].Oldest=false ;

		}
	}
}


simulated function TickTargetAges()
{
local int T,U;
	//Update all target's age... kinda like the function suggests. Also, on the off chance that these numbers somehow end up ginormous, keep them from breaking buffers.
for(T=0;T<3;T++) 
{
	for(U=0;U<3;U++)
		{
	//Attack Targets 
	if(GDI_Targets[T].T_Attack[U].T_Age < 99999999999 && GDI_Targets[T].T_Attack[U].T_Actor !=none) GDI_Targets[T].T_Attack[U].T_Age+=1 ;	
	if(GDI_Targets[T].B_Attack.T_Age < 99999999999 && GDI_Targets[T].B_Attack.T_Building !=none) GDI_Targets[T].B_Attack.T_Age+=0.001 ;		
	
	
	if(NOD_Targets[T].T_Attack[U].T_Age < 99999999999 && NOD_Targets[T].T_Attack[U].T_Actor !=none) NOD_Targets[T].T_Attack[U].T_Age+=1 ;		
	if(NOD_Targets[T].B_Attack.T_Age < 99999999999 && NOD_Targets[T].B_Attack.T_Building !=none) NOD_Targets[T].B_Attack.T_Age+=0.001 ;		
	
		//////////////////////////////////////////////////////////////////////////////////
		/////////Special case for attack targets. They eventually decay(+Stealthed attack targets decay when re-stealthing)//////////////////
		/////////////////////////////////////////////////////////////////////////////////
	if(GDI_Targets[T].T_Attack[U].T_Age >=AttackT_DecayTime && GDI_Targets[T].T_Attack[U].T_Actor !=none) 
				{
					//reset this target
				GDI_Targets[T].T_Attack[U].KillFlag=3; //0: Updated 1: Removed 2: Destroyed 3: Decayed 4: Repaired
				GDI_Targets[T].T_Attack[U].T_Actor = none;
				GDI_Targets[T].T_Attack[U].T_Age=0;
				GDI_Targets[T].T_Attack[U].Oldest=false;
				GDI_Targets[T].T_Attack[U].Pawn_ID=0;
				GDI_Targets[T].T_Attack[U].T_Actor_Name="";
				GDI_Targets[T].T_Attack[U].VehLoc.X=0;
				GDI_Targets[T].T_Attack[U].VehLoc.Y=0;
				GDI_Targets[T].T_Attack[U].VehLoc.Z=0;
				//RenxHud.CommText.SetFlashText(T_String, 20, "Attack Target Decayed",Warning_Color,50, 255, false)	; //Only sends the text once
				}		
				//Stealth Clause//
				if(Rx_Pawn_SBH(GDI_Targets[T].T_Attack[U].T_Actor) != none || Rx_Vehicle_StealthTank(GDI_Targets[T].T_Attack[U].T_Actor) != none) //The stealth clause 
			{
			if(GDI_Targets[T].T_Attack[U].T_Actor.GetStateName() == 'Stealthed' || GDI_Targets[T].T_Attack[U].T_Actor.GetStateName() == 'BeenShot') //May need to add more to this.
				{
					//reset this target, as it has re-stealthed
				GDI_Targets[T].T_Attack[U].KillFlag=3; //0: Updated 1: Removed 2: Destroyed 3: Decayed 4: Repaired
				GDI_Targets[T].T_Attack[U].T_Actor = none;
				GDI_Targets[T].T_Attack[U].T_Age=0;
				GDI_Targets[T].T_Attack[U].Oldest=false;
				GDI_Targets[T].T_Attack[U].T_Actor_Name="";
				GDI_Targets[T].T_Attack[U].Pawn_ID=0;
				GDI_Targets[T].T_Attack[U].VehLoc.X=0;
				GDI_Targets[T].T_Attack[U].VehLoc.Y=0;
				GDI_Targets[T].T_Attack[U].VehLoc.Z=0;
				} 
				//else return true;
			}
				
	if(NOD_Targets[T].T_Attack[U].T_Age >=AttackT_DecayTime && NOD_Targets[T].T_Attack[U].T_Actor !=none) 	
					{
					//reset this target
				NOD_Targets[T].T_Attack[U].T_Actor = none;
				NOD_Targets[T].T_Attack[U].T_Age=0;
				NOD_Targets[T].T_Attack[U].Oldest=false;
				NOD_Targets[T].T_Attack[U].Pawn_ID=0;
				NOD_Targets[T].T_Attack[U].T_Actor_Name="";
				NOD_Targets[T].T_Attack[U].KillFlag=3; //0: Updated 1: Removed 2: Destroyed 3: Decayed 4: Repaired
				NOD_Targets[T].T_Attack[U].VehLoc.X=0;
				NOD_Targets[T].T_Attack[U].VehLoc.Y=0;
				NOD_Targets[T].T_Attack[U].VehLoc.Z=0;
				//RenxHud.CommText.SetFlashText(T_String, 20, "Attack Target Decayed",Warning_Color,50, 255, false)	; //Only sends the text once
				}		
				//Stealth Clause//
				if(Rx_Pawn_SBH(NOD_Targets[T].T_Attack[U].T_Actor) != none || Rx_Vehicle_StealthTank(NOD_Targets[T].T_Attack[U].T_Actor) != none) //The stealth clause 
			{
			if(NOD_Targets[T].T_Attack[U].T_Actor.GetStateName() == 'Stealthed' || NOD_Targets[T].T_Attack[U].T_Actor.GetStateName() == 'BeenShot') //May need to add more to this.
				{
					//reset this target, as it has re-stealthed
				NOD_Targets[T].T_Attack[U].T_Actor = none;
				NOD_Targets[T].T_Attack[U].T_Age=0;
				NOD_Targets[T].T_Attack[U].Oldest=false;
				NOD_Targets[T].T_Attack[U].T_Actor_Name="";
				NOD_Targets[T].T_Attack[U].Pawn_ID=0;
				NOD_Targets[T].T_Attack[U].VehLoc.X=0;
				NOD_Targets[T].T_Attack[U].VehLoc.Y=0;
				NOD_Targets[T].T_Attack[U].VehLoc.Z=0;
				} 
				//else return true;
			}
	
	//Defense Targets
	if(GDI_Targets[T].T_Defend[U].T_Age < 99999999999 && GDI_Targets[T].T_Defend[U].T_Actor !=none) GDI_Targets[T].T_Defend[U].T_Age+=0.010 ;	
	if(GDI_Targets[T].B_Defend.T_Age < 99999999999 && GDI_Targets[T].B_Defend.T_Building !=none) GDI_Targets[T].B_Defend.T_Age+=0.010 ;	
	
	/*****************************************
	*If Nod steals this unit, remove it as a defensive target 
	*******************************************/
	
	if(GDI_Targets[T].T_Defend[U].T_Actor != none && GDI_Targets[T].T_Defend[U].T_Actor.GetTeamNum() == 1)
				{	
				//reset this target, as it has been stolen
				GDI_Targets[T].T_Defend[U].T_Actor = none;
				GDI_Targets[T].T_Defend[U].T_Age=0;
				GDI_Targets[T].T_Defend[U].Oldest=false;
				GDI_Targets[T].T_Defend[U].Pawn_ID=0;
				GDI_Targets[T].T_Defend[U].T_Actor_Name="";
				GDI_Targets[T].T_Defend[U].VehLoc.X=0;
				GDI_Targets[T].T_Defend[U].VehLoc.Y=0;
				GDI_Targets[T].T_Defend[U].VehLoc.Z=0;
				} 
	
	
	
	if(NOD_Targets[T].T_Defend[U].T_Age < 99999999999 && NOD_Targets[T].T_Defend[U].T_Actor !=none) NOD_Targets[T].T_Defend[U].T_Age+=0.010 ;		
	if(NOD_Targets[T].B_Defend.T_Age < 99999999999 && NOD_Targets[T].B_Defend.T_Building !=none) NOD_Targets[T].B_Defend.T_Age+=0.010 ;	
		
		
	/*****************************************
	*If GDI steals this unit, remove it as a defensive target. 
	*******************************************/
	
	if(NOD_Targets[T].T_Defend[U].T_Actor != none && NOD_Targets[T].T_Defend[U].T_Actor.GetTeamNum() != 1)
				{	
					//reset this target, as it has been stolen
				NOD_Targets[T].T_Defend[U].T_Actor = none;
				NOD_Targets[T].T_Defend[U].T_Age=0;
				NOD_Targets[T].T_Defend[U].Oldest=false;
				NOD_Targets[T].T_Defend[U].Pawn_ID=0;
				NOD_Targets[T].T_Defend[U].T_Actor_Name="";
				NOD_Targets[T].T_Defend[U].VehLoc.X=0;
				NOD_Targets[T].T_Defend[U].VehLoc.Y=0;
				NOD_Targets[T].T_Defend[U].VehLoc.Z=0;
				} 
	
		
	//Repair targets
	if(GDI_Targets[T].T_Repair[U].T_Age < 99999999999 && GDI_Targets[T].T_Repair[U].T_Actor !=none) GDI_Targets[T].T_Repair[U].T_Age+=0.010 ;
	if(GDI_Targets[T].B_Repair.T_Age < 99999999999 && GDI_Targets[T].B_Repair.T_Building !=none) GDI_Targets[T].B_Repair.T_Age+=0.010 ;	
	/*****************************************
	*If Nod steals this unit, remove it as a Repair target EDIT: to avoid exploitation of repair target points, the unit also is removed as a repair target if it goes neutral
	*******************************************/
	
	if(GDI_Targets[T].T_Repair[U].T_Actor != none && GDI_Targets[T].T_Repair[U].T_Actor.GetTeamNum() != 1)
				{	
					//reset this target, as it has been stolen
				GDI_Targets[T].T_Repair[U].T_Actor = none;
				GDI_Targets[T].T_Repair[U].T_Age=0;
				GDI_Targets[T].T_Repair[U].Oldest=false;
				GDI_Targets[T].T_Repair[U].Pawn_ID=0;
				GDI_Targets[T].T_Repair[U].T_Actor_Name="";
				GDI_Targets[T].T_Repair[U].VehLoc.X=0;
				GDI_Targets[T].T_Repair[U].VehLoc.Y=0;
				GDI_Targets[T].T_Repair[U].VehLoc.Z=0;
				} 
		
		
		
	if(NOD_Targets[T].T_Repair[U].T_Age < 99999999999 && NOD_Targets[T].T_Repair[U].T_Actor !=none) NOD_Targets[T].T_Repair[U].T_Age+=0.010 ;	
	if(NOD_Targets[T].B_Repair.T_Age < 99999999999 && NOD_Targets[T].B_Repair.T_Building !=none) NOD_Targets[T].B_Repair.T_Age+=0.010 ;	
	
	
	/*****************************************
	*If GDI steals this unit, remove it as a Repair target
	*******************************************/
	
	if(NOD_Targets[T].T_Repair[U].T_Actor != none && NOD_Targets[T].T_Repair[U].T_Actor.GetTeamNum() == 0)
				{	
					//reset this target, as it has been stolen
				NOD_Targets[T].T_Repair[U].T_Actor = none;
				NOD_Targets[T].T_Repair[U].T_Age=0;
				NOD_Targets[T].T_Repair[U].Oldest=false;
				NOD_Targets[T].T_Repair[U].Pawn_ID=0;
				NOD_Targets[T].T_Repair[U].T_Actor_Name="";
				NOD_Targets[T].T_Repair[U].VehLoc.X=0;
				NOD_Targets[T].T_Repair[U].VehLoc.Y=0;
				NOD_Targets[T].T_Repair[U].VehLoc.Z=0;
				} 
	
	
	//////////////////////////////////////////////////////////////////////////////////
	///////////////////////Building Objectives all decay. ////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	if(GDI_Targets[T].B_Attack.T_Age >=BuildingT_DecayTime*2 && GDI_Targets[T].B_Attack.T_Building !=none) //Attack Targets decay at half the speed for buildings
	{
				//reset this target
				GDI_Targets[T].B_Attack.T_Building = none;
				GDI_Targets[T].B_Attack.T_Age=0;	
	}
	
	if(NOD_Targets[T].B_Attack.T_Age >=BuildingT_DecayTime*2 && NOD_Targets[T].B_Attack.T_Building !=none) 
	{
				//reset this target
				NOD_Targets[T].B_Attack.T_Building = none;
				NOD_Targets[T].B_Attack.T_Age=0;	
	}
	
	
	if(GDI_Targets[T].B_Defend.T_Age >=BuildingT_DecayTime && GDI_Targets[T].B_Defend.T_Building !=none) 
	{
				//reset this target
				GDI_Targets[T].B_Defend.T_Building = none;
				GDI_Targets[T].B_Defend.T_Age=0;	
	}
	
	if(NOD_Targets[T].B_Defend.T_Age >=BuildingT_DecayTime && NOD_Targets[T].B_Defend.T_Building !=none) 
	{
				//reset this target
				NOD_Targets[T].B_Defend.T_Building = none;
				NOD_Targets[T].B_Defend.T_Age=0;	
	}
	
	if(GDI_Targets[T].B_Repair.T_Age >=BuildingT_DecayTime && GDI_Targets[T].B_Repair.T_Building !=none) 
	{
				//reset this target
				GDI_Targets[T].B_Repair.T_Building = none;
				GDI_Targets[T].B_Repair.T_Age=0;	
	}
	
	if(NOD_Targets[T].B_Repair.T_Age >=BuildingT_DecayTime && NOD_Targets[T].B_Repair.T_Building !=none) 
	{
				//reset this target
				NOD_Targets[T].B_Repair.T_Building = none;
				NOD_Targets[T].B_Repair.T_Age=0;	
	}
	//////////////////////////////////////////////////////////////////////////
	/////////////END BUILDING OBJECTIVES//////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	
	
		}	
	
	}
}


simulated function float MaxofThree(float X, float Y, float Z)

{
if(X >= Fmax(Y,Z)) return X;
else
if(Y >= Fmax(X,Z)) return Y;
else
return Z;
	
}

