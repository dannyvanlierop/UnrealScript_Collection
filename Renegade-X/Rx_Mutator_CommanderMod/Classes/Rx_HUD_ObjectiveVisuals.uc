/*
** Rx_HUD_ObjectiveVisuals
*/

class Rx_HUD_ObjectiveVisuals extends Rx_Hud_Component;

//Hopefully the last HUD thing I need to create

 //Everything is an array of 3 for three commanders. Going dynamic would probably be more of a hassle than it's worth, though if I ever change the number of possible commanders this is going to be a bitch



/**struct Target_Array 
{
	var Actor 		T_Attack1 //Need the actors, as we'll need to reference and update their location/stats
	var Actor		T_Attack2
	var Actor 		T_Attack3
	var Actor 		T_Defend1
	var Actor		T_Defend2
	var Actor 		T_Defend3
	var vector 		T_Waypoint //Waypoints don't move on their own, so they just need to be a location
	var vector		T_DWaypoint
};
*/


var int TextTimer_Caution, TextTimer_Warning, TextTimer_Update, TextTimer_Announcment;
var int SpamTime_Caution, SpamTime_Warning, SpamTime_Update, SpamTime_Announcment;
var color Warning_Color, Caution_Color, Update_Color, Announcment_Color			;

struct AgingTarget 
{
	var Actor T_Actor ;
	var string T_Actor_Name;
	var float   T_Age;
	var bool  Oldest;
	var int Pawn_ID;
	var Vector VehLoc;
	var byte KillFlag;
	
};

struct AgingBTarget 
{
	var Rx_Building T_Building ;
	var float   T_Age;
	
};

struct Target_Array 
{
	var AgingTarget 		T_Attack[3]; //Need the actors, as we'll need to reference and update their location/stats
	var AgingTarget 		T_Defend[3];
	var AgingTarget 		T_Repair[3];
	var AgingBTarget B_Attack;
	var AgingBTarget B_Defend;
	var AgingBTarget B_Repair;
	var Rx_BuildingAttachment_MCT B_RepairMCT;
	var vector 		T_Waypoint; //Waypoints don't move on their own, so they just need to be a location
	var vector		T_DWaypoint;
	
	structDefaultProperties
	{
		T_Attack(0)=(T_Actor=none, T_Age=2, Oldest=true)  //Make sure 0 is the default oldest
		T_Defend(0)=(T_Actor=none, T_Age=2, Oldest=true) //Same goes for Defence targets 
		T_Repair(0)=(T_Actor=none, T_Age=2, Oldest=true) //Same goes for Repair targets 
	}
};

var Target_Array GDI_Targets[3], NOD_Targets[3]							;

var byte GDI_AttackUpdated,GDI_DefendUpdated, GDI_RepairUpdated, GDI_WaypointUpdated; 
var byte NOD_AttackUpdated,NOD_DefendUpdated, NOD_RepairUpdated, NOD_WaypointUpdated;
var bool GDI_CommanderUpdated, GDI_CommanderLeft;
var bool NOD_CommanderUpdated, NOD_CommanderLeft;

//var int GDI_A_Cycler, NOD_A_Cycler ;
/////////////////////////////////////////////////////////////////
////////////////////////Visual Aspects///////////////////////////
/////////////////////////////////////////////////////////////////

var 	float		FadeDistance,MaxFullyVisibleTime, AttackT_DecayTime, DistanceFadeModifier, DecayBarSensitivity	; //Distance at which targets begin to start fading away, if any. /Time before Attack Targets disappear

//Icon pulsating movement
var float IconPulse, IconPulseRate, IconPulseMax, IconPulseMin 	;	 
var bool IconPulseFlipped										;	


var 	CanvasIcon	TI_Attack, TI_Defend, TI_Repair, TI_Waypoint		;

var		CanvasIcon	Marker_Attack, Marker_DWaypoint, Marker_Waypoint	;

var 	int 		BuildingTargetZOffset								;

var		string		MyTeam												;

var int Sync_Cycler														; //Used for syncing target age with the age from ORI

var Rx_ORI			myORI 												;
var Rx_CommanderController myCC											;
var int GDICommanderID[3], NODCommanderID[3]									;
/*******************************************************************************************
********************************************************************************************
********************************************************************************************
********************************************************************************************
********************************************************************************************/




simulated function Update(float DeltaTime, Rx_HUD HUD) 
{
	local int T, i, j;
	local Rx_ORI ORI;
	local Rx_Pawn TPawn;
	local float DistToV,NearestVDist;
	local Rx_Vehicle Temp_V, Temp_NearestV;
	local Rx_CommanderController CC;
	local Rx_BuildingAttachment_MCT TempMCT;
	
	
	super.Update(DeltaTime, HUD);
		
	//Get mah team
	T=RenxHud.PlayerOwner.GetTeamNum() ;
	
	if(myORI == none) //Find my ORI
	{
		foreach RenxHud.PlayerOwner.AllActors(class'Rx_ORI', ORI)
		{
		myORI = ORI ;
		
		break;
		
		}
		
		
	}
	
	if(myCC == none) //Find my CC
	{
		foreach RenxHud.PlayerOwner.AllActors(class'Rx_CommanderController', CC)
		{
		myCC = CC ;
		
		break;
		
		}
		
		
	}
	
	
	
	
	ControlPulse();
	
	if(Sync_Cycler >= 5) 
	{
		
		switch(T) 
	{
		case 0 : 
		MyTeam = "GDI";
		break;
		
		case 1 :
		MyTeam = "NOD" ;
		break;
	}
		
		
		SpamTimerHandler(); //Update our spam timers as well
		SyncAges(); //Crank up the Age sync 
		Sync_Cycler=0;
	}
	
	
for (i=0;i<3;i++) //Sync targets if they aren't already
		{
			if(myCC.GDI_Commander[i].CPRI == none && myCC.NOD_Commander[i].CPRI == none) continue; //if neither team even has a commander in these slots, don't bother updating them.
			
for (j=0;j<3;j++)				
			{
	
	//DERP, these need to be reset for every iteration, otherwise everything ends up all kinds of jacked up.
	DistToV=0;
	NearestVDist=0;
	Temp_V=none; 
	Temp_NearestV=none;
				
							
					if(GDI_Targets[i].T_Attack[j].T_Actor_Name != myORI.GDI_Targets[i].T_Attack[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					
					GDI_Targets[i].T_Attack[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					GDI_Targets[i].T_Attack[j].Pawn_ID = myORI.GDI_Targets[i].T_Attack[j].Pawn_ID;
					//Set vehicle related stuff
					GDI_Targets[i].T_Attack[j].VehLoc.X = myORI.GDI_Targets[i].T_Attack[j].VehLoc.X ;
					GDI_Targets[i].T_Attack[j].VehLoc.Y = myORI.GDI_Targets[i].T_Attack[j].VehLoc.Y ;
					GDI_Targets[i].T_Attack[j].VehLoc.Z = myORI.GDI_Targets[i].T_Attack[j].VehLoc.Z ;
					//////////////////////////////
					
					if(GDI_Targets[i].T_Attack[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == GDI_Targets[i].T_Attack[j].Pawn_ID)
						{
							GDI_Targets[i].T_Attack[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(GDI_Targets[i].T_Attack[j].VehLoc.X !=0 && GDI_Targets[i].T_Attack[j].VehLoc.Y !=0 && GDI_Targets[i].T_Attack[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD");
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(GDI_Targets[i].T_Attack[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
							
							if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						}					
							
					}
						GDI_Targets[i].T_Attack[j].T_Actor=Temp_NearestV;
				}
					GDI_Targets[i].T_Attack[j].T_Actor_Name = myORI.GDI_Targets[i].T_Attack[j].T_Actor_Name;
					GDI_Targets[i].T_Attack[j].T_Age = myORI.GDI_Targets[i].T_Attack[j].T_Age;
					GDI_Targets[i].T_Attack[j].KillFlag = myORI.GDI_Targets[i].T_Attack[j].KillFlag;
					GDI_AttackUpdated=GDI_Targets[i].T_Attack[j].KillFlag+1;
					}		
					
					if(NOD_Targets[i].T_Attack[j].T_Actor_Name != myORI.NOD_Targets[i].T_Attack[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					LogInternal("Kill Flag at visuals"@myORI.NOD_Targets[i].T_Attack[j].KillFlag);
					NOD_Targets[i].T_Attack[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					NOD_Targets[i].T_Attack[j].Pawn_ID = myORI.NOD_Targets[i].T_Attack[j].Pawn_ID;
					//Set vehicle related stuff
					NOD_Targets[i].T_Attack[j].VehLoc.X = myORI.NOD_Targets[i].T_Attack[j].VehLoc.X ;
					NOD_Targets[i].T_Attack[j].VehLoc.Y = myORI.NOD_Targets[i].T_Attack[j].VehLoc.Y ;
					NOD_Targets[i].T_Attack[j].VehLoc.Z = myORI.NOD_Targets[i].T_Attack[j].VehLoc.Z ;
					//////////////////////////////
					
					if(NOD_Targets[i].T_Attack[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == NOD_Targets[i].T_Attack[j].Pawn_ID)
						{
							NOD_Targets[i].T_Attack[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(NOD_Targets[i].T_Attack[j].VehLoc.X !=0 && NOD_Targets[i].T_Attack[j].VehLoc.Y !=0 && NOD_Targets[i].T_Attack[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD. V Loc X: " @ NOD_Targets[i].T_Attack[j].VehLoc.X);
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(NOD_Targets[i].T_Attack[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
						
						if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						
						}					
							
					}
						NOD_Targets[i].T_Attack[j].T_Actor=Temp_NearestV;
				}
					NOD_Targets[i].T_Attack[j].T_Actor_Name = myORI.NOD_Targets[i].T_Attack[j].T_Actor_Name;
					NOD_Targets[i].T_Attack[j].T_Age = myORI.NOD_Targets[i].T_Attack[j].T_Age;
					NOD_Targets[i].T_Attack[j].KillFlag = myORI.NOD_Targets[i].T_Attack[j].KillFlag;
					
					NOD_AttackUpdated=NOD_Targets[i].T_Attack[j].KillFlag+1;
					}		
					
					/////////////////////////////////////////////////////////
					///////////////////Check Defence////////////////////////
					////////////////////////////////////////////////////////

				if(GDI_Targets[i].T_Defend[j].T_Actor_Name != myORI.GDI_Targets[i].T_Defend[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					
					GDI_Targets[i].T_Defend[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					GDI_Targets[i].T_Defend[j].Pawn_ID = myORI.GDI_Targets[i].T_Defend[j].Pawn_ID;
					//Set vehicle related stuff
					GDI_Targets[i].T_Defend[j].VehLoc.X = myORI.GDI_Targets[i].T_Defend[j].VehLoc.X ;
					GDI_Targets[i].T_Defend[j].VehLoc.Y = myORI.GDI_Targets[i].T_Defend[j].VehLoc.Y ;
					GDI_Targets[i].T_Defend[j].VehLoc.Z = myORI.GDI_Targets[i].T_Defend[j].VehLoc.Z ;
					//////////////////////////////
					
					if(GDI_Targets[i].T_Defend[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == GDI_Targets[i].T_Defend[j].Pawn_ID)
						{
							GDI_Targets[i].T_Defend[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(GDI_Targets[i].T_Defend[j].VehLoc.X !=0 && GDI_Targets[i].T_Defend[j].VehLoc.Y !=0 && GDI_Targets[i].T_Defend[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD");
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(GDI_Targets[i].T_Defend[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
						
						if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						}					
							
					}
						GDI_Targets[i].T_Defend[j].T_Actor=Temp_NearestV;
				}
					GDI_Targets[i].T_Defend[j].T_Actor_Name = myORI.GDI_Targets[i].T_Defend[j].T_Actor_Name;
					GDI_Targets[i].T_Defend[j].T_Age = myORI.GDI_Targets[i].T_Defend[j].T_Age;
					GDI_Targets[i].T_Defend[j].KillFlag = myORI.GDI_Targets[i].T_Defend[j].KillFlag;
					GDI_DefendUpdated=GDI_Targets[i].T_Defend[j].KillFlag+1;
					}		
					
					if(NOD_Targets[i].T_Defend[j].T_Actor_Name != myORI.NOD_Targets[i].T_Defend[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					
					NOD_Targets[i].T_Defend[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					NOD_Targets[i].T_Defend[j].Pawn_ID = myORI.NOD_Targets[i].T_Defend[j].Pawn_ID;
					//Set vehicle related stuff
					NOD_Targets[i].T_Defend[j].VehLoc.X = myORI.NOD_Targets[i].T_Defend[j].VehLoc.X ;
					NOD_Targets[i].T_Defend[j].VehLoc.Y = myORI.NOD_Targets[i].T_Defend[j].VehLoc.Y ;
					NOD_Targets[i].T_Defend[j].VehLoc.Z = myORI.NOD_Targets[i].T_Defend[j].VehLoc.Z ;
					//////////////////////////////
					
					if(NOD_Targets[i].T_Defend[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == NOD_Targets[i].T_Defend[j].Pawn_ID)
						{
							NOD_Targets[i].T_Defend[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(NOD_Targets[i].T_Defend[j].VehLoc.X !=0 && NOD_Targets[i].T_Defend[j].VehLoc.Y !=0 && NOD_Targets[i].T_Defend[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD");
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(NOD_Targets[i].T_Defend[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
						
						if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						
						}					
							
					}
						NOD_Targets[i].T_Defend[j].T_Actor=Temp_NearestV;
				}
					NOD_Targets[i].T_Defend[j].T_Actor_Name = myORI.NOD_Targets[i].T_Defend[j].T_Actor_Name;
					NOD_Targets[i].T_Defend[j].T_Age = myORI.NOD_Targets[i].T_Defend[j].T_Age;
					NOD_Targets[i].T_Defend[j].KillFlag = myORI.NOD_Targets[i].T_Defend[j].KillFlag;
					NOD_DefendUpdated=NOD_Targets[i].T_Defend[j].KillFlag+1;
					}		
					
					//////////////////////////////////////////////
					///////Check Repair targets //////////////////
					//////////////////////////////////////////////
					if(GDI_Targets[i].T_Repair[j].T_Actor_Name != myORI.GDI_Targets[i].T_Repair[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					GDI_Targets[i].T_Repair[j].T_Actor_Name = myORI.GDI_Targets[i].T_Repair[j].T_Actor_Name;
					GDI_Targets[i].T_Repair[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					GDI_Targets[i].T_Repair[j].Pawn_ID = myORI.GDI_Targets[i].T_Repair[j].Pawn_ID;
					//Set vehicle related stuff
					GDI_Targets[i].T_Repair[j].VehLoc.X = myORI.GDI_Targets[i].T_Repair[j].VehLoc.X ;
					GDI_Targets[i].T_Repair[j].VehLoc.Y = myORI.GDI_Targets[i].T_Repair[j].VehLoc.Y ;
					GDI_Targets[i].T_Repair[j].VehLoc.Z = myORI.GDI_Targets[i].T_Repair[j].VehLoc.Z ;
					//////////////////////////////
					
					if(GDI_Targets[i].T_Repair[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == GDI_Targets[i].T_Repair[j].Pawn_ID)
						{
							GDI_Targets[i].T_Repair[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(GDI_Targets[i].T_Repair[j].VehLoc.X !=0 && GDI_Targets[i].T_Repair[j].VehLoc.Y !=0 && GDI_Targets[i].T_Repair[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD");
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(GDI_Targets[i].T_Repair[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
						
						if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						
						}					
							
					}
						GDI_Targets[i].T_Repair[j].T_Actor=Temp_NearestV;
				}
					
					GDI_Targets[i].T_Repair[j].T_Age = myORI.GDI_Targets[i].T_Repair[j].T_Age;
					GDI_Targets[i].T_Repair[j].KillFlag = myORI.GDI_Targets[i].T_Repair[j].KillFlag;
					GDI_RepairUpdated=GDI_Targets[i].T_Repair[j].KillFlag+1;
					}		
					
					if(NOD_Targets[i].T_Repair[j].T_Actor_Name != myORI.NOD_Targets[i].T_Repair[j].T_Actor_Name) //Are Our Actors(names) out of sync?
				
					{
					NOD_Targets[i].T_Repair[j].T_Actor_Name = myORI.NOD_Targets[i].T_Repair[j].T_Actor_Name;
					NOD_Targets[i].T_Repair[j].T_Actor = none; //Reset the Actor initially. If it is being reset, then it will just remain 'none'
					NOD_Targets[i].T_Repair[j].Pawn_ID = myORI.NOD_Targets[i].T_Repair[j].Pawn_ID;
					//Set vehicle related stuff
					NOD_Targets[i].T_Repair[j].VehLoc.X = myORI.NOD_Targets[i].T_Repair[j].VehLoc.X ;
					NOD_Targets[i].T_Repair[j].VehLoc.Y = myORI.NOD_Targets[i].T_Repair[j].VehLoc.Y ;
					NOD_Targets[i].T_Repair[j].VehLoc.Z = myORI.NOD_Targets[i].T_Repair[j].VehLoc.Z ;
					//////////////////////////////
					
					if(NOD_Targets[i].T_Repair[j].Pawn_ID !=0) 
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Pawn', TPawn)
					{
						if(TPawn.PlayerReplicationInfo != none && TPawn.PlayerReplicationInfo.PlayerID == NOD_Targets[i].T_Repair[j].Pawn_ID)
						{
							NOD_Targets[i].T_Repair[j].T_Actor = TPawn;
							break;
						}
						
					}
					
					
					if(NOD_Targets[i].T_Repair[j].VehLoc.X !=0 && NOD_Targets[i].T_Repair[j].VehLoc.Y !=0 && NOD_Targets[i].T_Repair[j].VehLoc.Z !=0) 
				{
					LogInternal("Attempting to Locate vehicle for HUD");
					foreach RenXHud.PlayerOwner.Pawn.AllActors(class'Rx_Vehicle', Temp_V)
					{
					
						DistToV = VSize(NOD_Targets[i].T_Repair[j].VehLoc-Temp_V.location);
						LogInternal("DTV="@DistToV);
						if(NearestVDist == 0.0 || DistToV < NearestVDist)
						{
						NearestVDist = DistToV;
						Temp_NearestV = Temp_V;
						LogInternal(Temp_NearestV);
						
						if(NearestVDist == 0.0) 	//if it's still 0.0 we are literally on top of the vehicle and it isn't moving
							{
							break;
							}
						
						}					
							
					}
						NOD_Targets[i].T_Repair[j].T_Actor=Temp_NearestV;
				}
					
					NOD_Targets[i].T_Repair[j].T_Age = myORI.NOD_Targets[i].T_Repair[j].T_Age;
					NOD_Targets[i].T_Repair[j].KillFlag = myORI.NOD_Targets[i].T_Repair[j].KillFlag;
					NOD_RepairUpdated=NOD_Targets[i].T_Repair[j].KillFlag+1;
					}		
					
				
					
			} // END OF "J" iteration
			
			///////Check Waypoints ////////////////// Only necessary to iterate with i, as opposed to wasting time iterating through i and j. Reason: There's only 1 waypoint and 1 defensive waypoint per Target array
				if(GDI_Targets[i].T_Waypoint.X != myORI.GDI_Targets[i].T_Waypoint.X ||
				GDI_Targets[i].T_Waypoint.Y != myORI.GDI_Targets[i].T_Waypoint.Y ||
				GDI_Targets[i].T_Waypoint.Z != myORI.GDI_Targets[i].T_Waypoint.Z
				) //Are Our points out of sync?
					
				{
				GDI_Targets[i].T_Waypoint.X = myORI.GDI_Targets[i].T_Waypoint.X;
				GDI_Targets[i].T_Waypoint.Y = myORI.GDI_Targets[i].T_Waypoint.Y;
				GDI_Targets[i].T_Waypoint.Z = myORI.GDI_Targets[i].T_Waypoint.Z;
				if(
				GDI_Targets[i].T_Waypoint.X == 0 &&
				GDI_Targets[i].T_Waypoint.Y == 0 &&
				GDI_Targets[i].T_Waypoint.Z == 0 
				) 
					{
					if(MyTeam=="GDI") PlayWaypointUpdateMessage("GDI", 0);
					}
				else
					if(MyTeam=="GDI") PlayWaypointUpdateMessage("GDI", 1); //1 for update, 0 for removal
				
				}		
					
				///////Check Waypoints NOD//////////////////
				if(NOD_Targets[i].T_Waypoint.X != myORI.NOD_Targets[i].T_Waypoint.X ||
				NOD_Targets[i].T_Waypoint.Y != myORI.NOD_Targets[i].T_Waypoint.Y ||
				NOD_Targets[i].T_Waypoint.Z != myORI.NOD_Targets[i].T_Waypoint.Z
				) //Are Our points out of sync?
					
				{
				NOD_Targets[i].T_Waypoint.X = myORI.NOD_Targets[i].T_Waypoint.X;
				NOD_Targets[i].T_Waypoint.Y = myORI.NOD_Targets[i].T_Waypoint.Y;
				NOD_Targets[i].T_Waypoint.Z = myORI.NOD_Targets[i].T_Waypoint.Z;
								
				if(
				NOD_Targets[i].T_Waypoint.X == 0 &&
				NOD_Targets[i].T_Waypoint.Y == 0 &&
				NOD_Targets[i].T_Waypoint.Z == 0 
				) 
					{
					if(MyTeam=="NOD") PlayWaypointUpdateMessage("NOD", 0);
					}
				else
					if(MyTeam=="NOD") PlayWaypointUpdateMessage("NOD", 1); //1 for update, 0 for removal
				}

				///////Check Defensive Waypoints ////////////////// Only necessary to iterate with i, as opposed to wasting time iterating through i and j. Reason: There's only 1 waypoint and 1 defensive waypoint per Target array
				if(GDI_Targets[i].T_DWaypoint.X != myORI.GDI_Targets[i].T_DWaypoint.X ||
				GDI_Targets[i].T_DWaypoint.Y != myORI.GDI_Targets[i].T_DWaypoint.Y ||
				GDI_Targets[i].T_DWaypoint.Z != myORI.GDI_Targets[i].T_DWaypoint.Z
				) //Are Our points out of sync?
					
				{
				GDI_Targets[i].T_DWaypoint.X = myORI.GDI_Targets[i].T_DWaypoint.X;
				GDI_Targets[i].T_DWaypoint.Y = myORI.GDI_Targets[i].T_DWaypoint.Y;
				GDI_Targets[i].T_DWaypoint.Z = myORI.GDI_Targets[i].T_DWaypoint.Z;
				
				if(
				GDI_Targets[i].T_DWaypoint.X == 0 &&
				GDI_Targets[i].T_DWaypoint.Y == 0 &&
				GDI_Targets[i].T_DWaypoint.Z == 0 
				) 
					{
					if(MyTeam=="GDI") PlayDWaypointUpdateMessage("GDI", 0);
					}
				else
					if(MyTeam=="GDI") PlayDWaypointUpdateMessage("GDI", 1); //1 for update, 0 for removal
				
				
				}		
					
					///////Check Defensive Waypoints NOD//////////////////
				if(NOD_Targets[i].T_DWaypoint.X != myORI.NOD_Targets[i].T_DWaypoint.X ||
				NOD_Targets[i].T_DWaypoint.Y != myORI.NOD_Targets[i].T_DWaypoint.Y ||
				NOD_Targets[i].T_DWaypoint.Z != myORI.NOD_Targets[i].T_DWaypoint.Z
				) //Are Our points out of sync?
					
				{
				NOD_Targets[i].T_DWaypoint.X = myORI.NOD_Targets[i].T_DWaypoint.X;
				NOD_Targets[i].T_DWaypoint.Y = myORI.NOD_Targets[i].T_DWaypoint.Y;
				NOD_Targets[i].T_DWaypoint.Z = myORI.NOD_Targets[i].T_DWaypoint.Z;
				if(
				NOD_Targets[i].T_DWaypoint.X == 0 &&
				NOD_Targets[i].T_DWaypoint.Y == 0 &&
				NOD_Targets[i].T_DWaypoint.Z == 0 
				) 
					{
					if(MyTeam=="NOD") PlayDWaypointUpdateMessage("NOD", 0);
					}
				else
					if(MyTeam=="NOD") PlayDWaypointUpdateMessage("NOD", 1); //1 for update, 0 for removal
				}		
				
				///////////////////////////////////////////////////////////
				///////////////Update Building Targets////////////////////
				//////////////////////////////////////////////////////////
				if(GDI_Targets[i].B_Attack.T_Building != myORI.GDI_Targets[i].B_Attack.T_Building) GDI_Targets[i].B_Attack.T_Building = myORI.GDI_Targets[i].B_Attack.T_Building;  //Just keep these up to date, as they don't need to say when the update here. Objective updates already handle that.
				if(GDI_Targets[i].B_Defend.T_Building != myORI.GDI_Targets[i].B_Defend.T_Building) GDI_Targets[i].B_Defend.T_Building = myORI.GDI_Targets[i].B_Defend.T_Building;
				if(GDI_Targets[i].B_Repair.T_Building != myORI.GDI_Targets[i].B_Repair.T_Building) 
				{
					GDI_Targets[i].B_Repair.T_Building = myORI.GDI_Targets[i].B_Repair.T_Building;
					
					//Set the MCT, as repair icon should be drawn on the MCT 
					if(GDI_Targets[i].B_Repair.T_Building != none)
					{
					foreach RenxHud.PlayerOwner.Pawn.AllActors(class'Rx_BuildingAttachment_MCT', TempMCT)
					{
						LogInternal("MCT is: " @ TempMCT);
					if(TempMCT.OwnerBuilding.BuildingVisuals == GDI_Targets[i].B_Repair.T_Building)
						{
							
					GDI_Targets[i].B_RepairMCT = TempMCT;
					break;
						}
						
					}
					}
				
				}
				if(NOD_Targets[i].B_Attack.T_Building != myORI.NOD_Targets[i].B_Attack.T_Building) NOD_Targets[i].B_Attack.T_Building = myORI.NOD_Targets[i].B_Attack.T_Building;  //Just keep these up to date, as they don't need to say when the update here. Objective updates already handle that.
				if(NOD_Targets[i].B_Defend.T_Building != myORI.NOD_Targets[i].B_Defend.T_Building) NOD_Targets[i].B_Defend.T_Building = myORI.NOD_Targets[i].B_Defend.T_Building;
				if(NOD_Targets[i].B_Repair.T_Building != myORI.NOD_Targets[i].B_Repair.T_Building) 
				{
					NOD_Targets[i].B_Repair.T_Building = myORI.NOD_Targets[i].B_Repair.T_Building;
					//Find our target's MCT
					if(NOD_Targets[i].B_Repair.T_Building != none)
					{
					foreach RenxHud.PlayerOwner.Pawn.AllActors(class'Rx_BuildingAttachment_MCT', TempMCT)
					{
					if(TempMCT.OwnerBuilding.BuildingVisuals == NOD_Targets[i].B_Repair.T_Building)
						{
					NOD_Targets[i].B_RepairMCT = TempMCT;
					break;
						}
					}
					}
				}
				//////////////////////////////////////////////////////////
				//////////////END BUILDING UPDATES////////////////////////
				//////////////////////////////////////////////////////////
				
				//Update Commander Functions//
				
				//Commander Changes//
				if((GDICommanderID[i] != myCC.GDI_Commander[i].Pid) && myCC.GDI_Commander[i].Pid !=-1)
					{
					GDI_CommanderUpdated=true; 
					GDICommanderID[i] = myCC.GDI_Commander[i].Pid;
					}
				//Commander Leaves//
				if((GDICommanderID[i] != myCC.GDI_Commander[i].Pid) && myCC.GDI_Commander[i].Pid == -1)
					{
					GDI_CommanderLeft=true; 
					GDICommanderID[i] = myCC.GDI_Commander[i].Pid;
					}
				
				//NOD Commander Changes//
				if((NODCommanderID[i] != myCC.NOD_Commander[i].Pid) && myCC.NOD_Commander[i].Pid !=-1)
					{
					NOD_CommanderUpdated=true; 
					NODCommanderID[i] = myCC.NOD_Commander[i].Pid;
					}
					//NOD Commander Leaves//
				if((NODCommanderID[i] != myCC.NOD_Commander[i].Pid) && myCC.NOD_Commander[i].Pid == -1)
					{
					NOD_CommanderLeft=true; 
					NODCommanderID[i] = myCC.NOD_Commander[i].Pid;
					}
					
					if(GDI_CommanderUpdated) //These use 'i' to determine which rank was changed, so they're part of the statement.
						{
						if(MyTeam == "GDI") PlayCommanderUpdateMessage("GDI",i);
						GDI_CommanderUpdated=false;
						}
					
					
					if(NOD_CommanderUpdated) //These use 'i' to determine which rank was changed, so they're part of the statement.
						{
						if(MyTeam == "NOD") PlayCommanderUpdateMessage("NOD",i);
						NOD_CommanderUpdated=false;
						}
		}
	
	
	
//TickTargetAges(); //simulate ticking target ages client-side, though the server is the definitive answer in when targets decay and what's oldest. Client-side is purely for the visual aspects
//UpdateTargetAgeNod();
//UpdateTargetAgeGDI();
//FilterDeadTargets();
//These is wasteful to perform client-side on TWO separate objects.

	if(GDI_AttackUpdated > 0) 
	{
		if(MyTeam == "GDI") PlayAttackUpdateMessage("GDI", GDI_AttackUpdated);
		GDI_AttackUpdated=0;
	}
	
	if(GDI_DefendUpdated > 0) 
	{
		if(MyTeam == "GDI") PlayDefenceUpdateMessage("GDI", GDI_DefendUpdated);
		GDI_DefendUpdated=0;
	}
	
	if(GDI_RepairUpdated > 0) 
	{
		if(MyTeam == "GDI") PlayRepairUpdateMessage("GDI", GDI_RepairUpdated);
		GDI_RepairUpdated=0;
	}

	if(GDI_CommanderLeft) 
	{
	if(MyTeam == "GDI") PlayCommanderLeftMessage("GDI");
	GDI_CommanderLeft=false;
	}
	

	//////Waypoints coming soon/////////
	
	
	if(NOD_AttackUpdated > 0) 
	{
	if(MyTeam == "NOD")	PlayAttackUpdateMessage("NOD", NOD_AttackUpdated);
		NOD_AttackUpdated=0;
	}
	
	if(NOD_DefendUpdated > 0) 
	{
	if(MyTeam == "NOD")	PlayDefenceUpdateMessage("NOD", NOD_DefendUpdated);
		NOD_DefendUpdated=0;
	}
	
	if(NOD_RepairUpdated > 0) 
	{
	if(MyTeam == "NOD")	PlayRepairUpdateMessage("NOD", NOD_RepairUpdated);
		NOD_RepairUpdated=0;
	}
	
					
	if(NOD_CommanderLeft) //These use 'i' to determine which rank was changed, so they're part of the statement.
	{
	if(MyTeam == "NOD") PlayCommanderLeftMessage("NOD");
	NOD_CommanderLeft=false;
	}
	
	Sync_Cycler++;
	
}



simulated function SyncAges()
{
local	int i,j;
	
	for (i=0;i<3;i++) //Sync targets if they aren't already
		{
		if(myCC.GDI_Commander[i].CPRI == none && myCC.NOD_Commander[i].CPRI == none) continue; //if neither team even has a commander in these slots, don't bother wasting time iterating through them.
for (j=0;j<3;j++)				
			{
GDI_Targets[i].T_Attack[j].T_Age = myORI.GDI_Targets[i].T_Attack[j].T_Age;
GDI_Targets[i].T_Defend[j].T_Age = myORI.GDI_Targets[i].T_Defend[j].T_Age;
GDI_Targets[i].T_Repair[j].T_Age = myORI.GDI_Targets[i].T_Repair[j].T_Age;

NOD_Targets[i].T_Attack[j].T_Age = myORI.NOD_Targets[i].T_Attack[j].T_Age;
NOD_Targets[i].T_Defend[j].T_Age = myORI.NOD_Targets[i].T_Defend[j].T_Age;
NOD_Targets[i].T_Repair[j].T_Age = myORI.NOD_Targets[i].T_Repair[j].T_Age;

			}
		}
}
/***********************************************************
************************************************************
*Functions used to actually draw targets
*DrawAttackT(), DrawDefendT(), DrawRepairT(), DrawWaypoint()
************************************************************
************************************************************/

simulated function DrawAttackT()
{
local Rx_HUD HUD ;
local Vector AttackVector, MidscreenVector;
local int i,j;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha, and how transparent are we willing to get.
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Attack;
IconScale=1.0; //Special case for the Attack icon because it is wtfHUGE and bright as the sun.
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha=100; //Attack icon isn't quite as bright as most

HUD.Canvas.SetPos(0,0);

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Draw Attack targets (Not including buildings)
	for (i=0; i<3; i++)
		{
			if(myCC.GDI_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			
			for(j=0;j<3;j++)
			{
				
			if(GDI_Targets[i].T_Attack[j].T_Actor != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Attack[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Attack[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].T_Attack[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				AttackVector=HUD.Canvas.Project(GDI_Targets[i].T_Attack[j].T_Actor.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-AttackVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
		
				HUD.Canvas.DrawIcon(MyIcon,AttackVector.X-((MyIcon.UL/2)*IconScale),AttackVector.Y-((MyIcon.VL/2)*IconScale),IconScale);
				
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/6)*IconScale), AttackVector.y-MyIcon.VL/2*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("["$ j+1 $"]" ,true,IconScale,IconScale);
				
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Attack[j].T_Age*80)-50,0);
				
				//Draw the target's decay bar
				
				
				
			//Draw the target's decay bar
				
				//Set our color for the box
				HUD.Canvas.DrawColor.R=0;
				HUD.Canvas.DrawColor.G=0;
				HUD.Canvas.DrawColor.B=0;
				
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/4)*IconScale), AttackVector.y-(MyIcon.VL/4)*IconScale); //Set position to draw the bar 
				//HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/2)*IconScale), AttackVector.y-(MyIcon.VL*IconScale)); //Set position back to draw the box that will contain it. 
				HUD.Canvas.DrawBox(MyIcon.UL/2*IconScale,3*(HUD.Canvas.SizeY/1080)) ;
				
			
				//Set our color for the bar
				HUD.Canvas.DrawColor.R=255;
				HUD.Canvas.DrawColor.G=64;
				HUD.Canvas.DrawColor.B=64;
				//MyIcon.UL/2*IconScale
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/4)*IconScale), AttackVector.y-(MyIcon.VL/4)*IconScale); //Set position to draw the bar 
				//HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/2)*IconScale), AttackVector.y-(MyIcon.VL*IconScale)); //Set position to draw the bar 
				HUD.Canvas.DrawBox( (MyIcon.UL/2-((GDI_Targets[i].T_Attack[j].T_Age/DecayBarSensitivity/AttackT_DecayTime)*(MyIcon.UL/2*IconScale))),3*(HUD.Canvas.SizeY/1080)) ;//
				
				
				//Reset to non-blending white
				HUD.Canvas.SetDrawColor(255,255,255,255);
				
				//HUD.Canvas.DrawIcon(TI_Attack,AttackVector.X-32,AttackVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}		
			}
		
		}
		break;
	
	case "NOD":
	//Draw Attack targets (Not including buildings)
	for (i=0; i<3; i++)
		{
			if(myCC.NOD_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			for(j=0;j<3;j++)
			{
			if(NOD_Targets[i].T_Attack[j].T_Actor != none)
				
				//if(Rx_Pawn(NOD_Targets[i].T_Attack[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Attack[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].T_Attack[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				AttackVector=HUD.Canvas.Project(NOD_Targets[i].T_Attack[j].T_Actor.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-AttackVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
		
				HUD.Canvas.DrawIcon(MyIcon,AttackVector.X-((MyIcon.UL/2)*IconScale),AttackVector.Y-((MyIcon.VL/2)*IconScale),IconScale);
				
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/6)*IconScale), AttackVector.y-MyIcon.VL/2*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("["$ j+1 $"]" ,true,IconScale,IconScale);
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Attack[j].T_Age*80)-50,0);
				
				//Draw the target's decay bar
				
				//Set our color for the box
				HUD.Canvas.DrawColor.R=0;
				HUD.Canvas.DrawColor.G=0;
				HUD.Canvas.DrawColor.B=0;
				
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/4)*IconScale), AttackVector.y-(MyIcon.VL/4)*IconScale); //Set position to draw the bar 
				//HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/2)*IconScale), AttackVector.y-(MyIcon.VL*IconScale)); //Set position back to draw the box that will contain it. 
				HUD.Canvas.DrawBox(MyIcon.UL/2*IconScale,3*(HUD.Canvas.SizeY/1080)) ;
				
			
				//Set our color for the bar
				HUD.Canvas.DrawColor.R=255;
				HUD.Canvas.DrawColor.G=64;
				HUD.Canvas.DrawColor.B=64;
				//MyIcon.UL/2*IconScale
				HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/4)*IconScale), AttackVector.y-(MyIcon.VL/4)*IconScale); //Set position to draw the bar 
				//HUD.Canvas.SetPos(AttackVector.x-((MyIcon.UL/2)*IconScale), AttackVector.y-(MyIcon.VL*IconScale)); //Set position to draw the bar 
				HUD.Canvas.DrawBox( (MyIcon.UL/2-((NOD_Targets[i].T_Attack[j].T_Age/DecayBarSensitivity/AttackT_DecayTime)*(MyIcon.UL/2*IconScale))),3*(HUD.Canvas.SizeY/1080)) ;//
				
				
				//Reset to non-blending white
				HUD.Canvas.SetDrawColor(255,255,255,255);
				//HUD.Canvas.DrawIcon(TI_Attack,AttackVector.X-32,AttackVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				}		
			}
		
		}
		break;
	
	}
}
	

	
simulated function DrawDefendT()
{
local Rx_HUD HUD ;
local Vector DefendVector, MidscreenVector;
local int i,j;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Defend;
IconScale=1.0; 
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha=100; 

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Draw Defend targets (Not including buildings)
	for (i=0; i<3; i++)
		{
			if(myCC.GDI_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			for(j=0;j<3;j++) 
			{
				
			if(GDI_Targets[i].T_Defend[j].T_Actor != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Defend[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].T_Defend[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				DefendVector=HUD.Canvas.Project(GDI_Targets[i].T_Defend[j].T_Actor.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-DefendVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(DefendVector.x, DefendVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Defend[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,DefendVector.X-((MyIcon.UL/2)*IconScale),DefendVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Defend,DefendVector.X-32,DefendVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}		
			}
		
		}
		break;
	
	case "NOD":
	//Draw Defend targets (Not including buildings)
	for (i=0; i<3; i++) 
		{
			if(myCC.NOD_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			for(j=0;j<3;j++)
			{
				//don't bother if the target is behind us
				
				
			if(NOD_Targets[i].T_Defend[j].T_Actor != none)
				//if(Rx_Pawn(NOD_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Defend[j].T_Actor)
				{
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,Nod_Targets[i].T_Defend[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
				DefendVector=HUD.Canvas.Project(NOD_Targets[i].T_Defend[j].T_Actor.location) ;
				HUD.Canvas.SetPos(DefendVector.x, DefendVector.y);
				//Insert functionality for fading with distance
				DistanceFade = abs(round(Vsize(MidscreenVector-DefendVector)))/(MidscreenVector.X); 
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255)); //Don't draw an alpha over 255, but decrease it the closer we get to the center of the screen.
				//`log("DistanceFade = "$DistanceFade);
				HUD.Canvas.DrawIcon(MyIcon,DefendVector.X-((MyIcon.UL/2)*IconScale),DefendVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				
				//HUD.Canvas.DrawIcon(TI_Defend,DefendVector.X-32,DefendVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				}		
			}
		
		}
		break;
	
	}
}
	
	
	
	
	
simulated function DrawRepairT()
{
local Rx_HUD HUD ;
local Vector RepairVector, MidscreenVector;
local int i,j;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Repair;
IconScale=0.33*IconPulse; //Special case for the repair icon because it is wtfHUGE and bright as the sun.
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha = 140; //Repair icon is bright as shit.

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Draw Repair targets (Not including buildings)
	for (i=0; i<3; i++)
		{
			if(myCC.GDI_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			
			for(j=0;j<3;j++)
			{
				
			if(GDI_Targets[i].T_Repair[j].T_Actor != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].T_Repair[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				RepairVector=HUD.Canvas.Project(GDI_Targets[i].T_Repair[j].T_Actor.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-RepairVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(RepairVector.x, RepairVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,RepairVector.X-((MyIcon.UL/2)*IconScale),RepairVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}		
			}
		
		}
		break;
	
	case "NOD":
	//Draw Repair targets (Not including buildings)
	for (i=0; i<3; i++)
		{
			if(myCC.NOD_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
			for(j=0;j<3;j++)
			{
				//don't bother if the target is behind us
				
				
			if(NOD_Targets[i].T_Repair[j].T_Actor != none)
				//if(Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor)
				{
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,Nod_Targets[i].T_Repair[j].T_Actor.location) < -0.5;
				if(!bIsBehindMe) 
					{
				RepairVector=HUD.Canvas.Project(NOD_Targets[i].T_Repair[j].T_Actor.location) ;
				HUD.Canvas.SetPos(RepairVector.x, RepairVector.y);
				//Insert functionality for fading with distance
				DistanceFade = abs(round(Vsize(MidscreenVector-RepairVector)))/(MidscreenVector.X); 
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255)); //Don't draw an alpha over 255, but decrease it the closer we get to the center of the screen.
				//`log("DistanceFade = "$DistanceFade);
				HUD.Canvas.DrawIcon(MyIcon,RepairVector.X-((MyIcon.UL/2)*IconScale),RepairVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				}		
			}
		
		}
		break;
	
	}
}		


simulated function DrawWayPoints()
{
local Rx_HUD HUD ;
local Vector WayPointVector, MidscreenVector;
local int i;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Defend;
IconScale=1.0; 
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha=100; 

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	
	for (i=0; i<3; i++)
		{
			if(myCC.GDI_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
				//Draw Defence Waypoint first 			
				
			if(GDI_Targets[i].T_DWaypoint.X != 0 && GDI_Targets[i].T_DWaypoint.Y != 0 && GDI_Targets[i].T_DWaypoint.Z != 0 )
				
				//if(Rx_Pawn(GDI_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Defend[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].T_DWaypoint) < -0.5;
				if(!bIsBehindMe) 
					{
					
				WayPointVector=HUD.Canvas.Project(GDI_Targets[i].T_DWaypoint) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-WayPointVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(WayPointVector.x, WayPointVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Defend[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,WayPointVector.X-((MyIcon.UL/2)*IconScale),WayPointVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				HUD.Canvas.SetPos(WayPointVector.x-MyIcon.UL/4*IconScale, WayPointVector.y-MyIcon.VL/4*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Defend [" $ round(VSize(RenxHud.PlayerOwner.Pawn.location - GDI_Targets[i].T_DWaypoint)/52.5)$"m]" ,true,IconScale,IconScale);
				//HUD.Canvas.DrawIcon(TI_Defend,WayPointVector.X-32,WayPointVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}		
				
					//Draw Waypoints second 			
				
			if(GDI_Targets[i].T_Waypoint.X != 0 && GDI_Targets[i].T_Waypoint.Y != 0 && GDI_Targets[i].T_Waypoint.Z != 0 )
				
				//if(Rx_Pawn(GDI_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Defend[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].T_Waypoint) < -0.5;
				if(!bIsBehindMe) 
					{
					
				WayPointVector=HUD.Canvas.Project(GDI_Targets[i].T_Waypoint) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-WayPointVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(WayPointVector.x, WayPointVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Defend[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,WayPointVector.X-((MyIcon.UL/2)*IconScale),WayPointVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				HUD.Canvas.SetPos(WayPointVector.x-MyIcon.UL/4*IconScale, WayPointVector.y-MyIcon.VL/4*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Take [" $ round(VSize(RenxHud.PlayerOwner.Pawn.location - GDI_Targets[i].T_Waypoint)/52.5)$"m]" ,true,IconScale,IconScale);
				//HUD.Canvas.DrawIcon(TI_Defend,WayPointVector.X-32,WayPointVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}
				
			
			}
		
		
		break;
	
	case "NOD":
	for (i=0; i<3; i++)
		{
			if(myCC.NOD_Commander[i].CPRI == none) continue; //Not even a commander... ignore this and don't waste time on it.
				//Draw Defence Waypoint first 			
				
			if(NOD_Targets[i].T_DWaypoint.X != 0 && NOD_Targets[i].T_DWaypoint.Y != 0 && NOD_Targets[i].T_DWaypoint.Z != 0 )
				
				//if(Rx_Pawn(NOD_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Defend[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].T_DWaypoint) < -0.5;
				if(!bIsBehindMe) 
					{
					
				WayPointVector=HUD.Canvas.Project(NOD_Targets[i].T_DWaypoint) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-WayPointVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(WayPointVector.x, WayPointVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Defend[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,WayPointVector.X-((MyIcon.UL/2)*IconScale),WayPointVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				HUD.Canvas.SetPos(WayPointVector.x-MyIcon.UL/4*IconScale, WayPointVector.y-MyIcon.VL/4*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Defend [" $ round(VSize(RenxHud.PlayerOwner.Pawn.location - NOD_Targets[i].T_DWaypoint)/52.5)$"m]" ,true,IconScale,IconScale);
				//HUD.Canvas.DrawIcon(TI_Defend,WayPointVector.X-32,WayPointVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}		
				
					//Draw Waypoints second 			
				
			if(NOD_Targets[i].T_Waypoint.X != 0 && NOD_Targets[i].T_Waypoint.Y != 0 && NOD_Targets[i].T_Waypoint.Z != 0 )
				
				//if(Rx_Pawn(NOD_Targets[i].T_Defend[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Defend[j].T_Actor)
				{
					
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].T_Waypoint) < -0.5;
				if(!bIsBehindMe) 
					{
					
				WayPointVector=HUD.Canvas.Project(NOD_Targets[i].T_Waypoint) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-WayPointVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(WayPointVector.x, WayPointVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Defend[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,WayPointVector.X-((MyIcon.UL/2)*IconScale),WayPointVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				HUD.Canvas.SetPos(WayPointVector.x-MyIcon.UL/4*IconScale, WayPointVector.y-MyIcon.VL/4*IconScale-8);
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Take [" $ round(VSize(RenxHud.PlayerOwner.Pawn.location - NOD_Targets[i].T_Waypoint)/52.5)$"m]",true,IconScale,IconScale);
				//HUD.Canvas.DrawIcon(TI_Defend,WayPointVector.X-32,WayPointVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
					}
				
				}
				
			
			}
			
		break;
	
	}
}
	


simulated function DrawBuildingAttackTargets()
{
local Rx_HUD HUD ;
local Vector TargetVector, ModdedTargetVector, MidscreenVector;
local int i;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Attack;
IconScale=0.9*IconPulse; //Special case for the repair icon because it is wtfHUGE and bright as the sun.
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha = 100; //Repair icon is bright as shit.

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Setup for drawing ATTACK
	for (i=0; i<3; i++)
		{
				
				//Setup for drawing ATTACK
			if(GDI_Targets[i].B_Attack.T_Building != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor)
				{
					
					
					
				//Find the building's MCT
				
				/** USE FOR REPAIRS, but for defence/Attack test with just using the building location.
				foreach PlayerOwner.WorldInfo.AllActors(class'Rx_BuildingAttachment_MCT', MCT_i)
				{
					if(MCT_i.OwnerBuilding == GDI_Targets[i].B_Attack.T_Building)
					{
					BMCT==MCT_i;
					break;
					}
				}
				*/
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].B_Attack.T_Building.location) < -0.5;
				if(!bIsBehindMe) 
					{
				ModdedTargetVector = GDI_Targets[i].B_Attack.T_Building.location;
				ModdedTargetVector.Z += BuildingTargetZOffset;
				TargetVector=HUD.Canvas.Project(ModdedTargetVector) ;
				//(Draw the target higher than the center of the building so it is more visible)
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-(16*IconScale)); //last bit is for 8 point font.
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Attack" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location - GDI_Targets[i].B_Attack.T_Building.location)/52.5)$"m]",true,IconScale,IconScale);
					}
				
				}		
			
		
		}
		break;
	
	case "NOD":
	//Setup for drawing ATTACK
	for (i=0; i<3; i++)
		{
			
				
				//Setup for drawing ATTACK
			if(NOD_Targets[i].B_Attack.T_Building != none)
				
				//if(Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor)
				{
					
					
				
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].B_Attack.T_Building.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				ModdedTargetVector = NOD_Targets[i].B_Attack.T_Building.location;
				ModdedTargetVector.Z += BuildingTargetZOffset;
				TargetVector=HUD.Canvas.Project(ModdedTargetVector) ;
				
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-(16*IconScale));
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Attack" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location-NOD_Targets[i].B_Attack.T_Building.location)/52.5)$"m]",true,IconScale,IconScale);
					}
				
				}		
			
		
		}
		break;
	
	}
}		


simulated function DrawBuildingDefendTargets()
{
local Rx_HUD HUD ;
local Vector TargetVector, MidscreenVector;
local int i;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Defend;
IconScale=0.9*IconPulse; //Special case for the repair icon because it is wtfHUGE and bright as the sun.
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha = 100; //Repair icon is bright as shit.

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Setup for drawing Defend
	for (i=0; i<3; i++)
		{
			
				
				//Setup for drawing Defend
			if(GDI_Targets[i].B_Defend.T_Building != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor)
				{
					
					
					
				//Find the building's MCT
				
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].B_Defend.T_Building.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				TargetVector=HUD.Canvas.Project(GDI_Targets[i].B_Defend.T_Building.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-(16*IconScale)); //last bit is for 8 point font.
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Defend" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location-GDI_Targets[i].B_Defend.T_Building.location)/52.5)$"m]",true,IconScale,IconScale);
					}
				
				}		
			
		
		}
		break;
	
	case "NOD":
	//Setup for drawing Defend
	for (i=0; i<3; i++)
		{
			
				
				//Setup for drawing Defend
			if(NOD_Targets[i].B_Defend.T_Building != none)
				
				//if(Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor)
				{
					
					
				//Find the building's MCT
				
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].B_Defend.T_Building.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				TargetVector=HUD.Canvas.Project(NOD_Targets[i].B_Defend.T_Building.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-(16*IconScale));
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Defend" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location-NOD_Targets[i].B_Defend.T_Building.location)/52.5)$"m]",true,IconScale,IconScale);
					}
				
				}		
			
		
		}
		break;
	
	}
}		


simulated function DrawBuildingRepairTargets()
{
local Rx_HUD HUD ;
local Vector TargetVector, MidscreenVector;
local int i;
local bool bIsBehindMe; //Handy thing I didn't come up with for finding orientation. Yosh can't take credit for that math stuff in Rx_Utils
local CanvasIcon MyIcon;
local float IconScale, DistanceFade, MinFadeAlpha; //Distance from crosshair for drawing alpha
// ResScaleX, ResScaleY
HUD=RenxHud; 
MyIcon = TI_Repair;
IconScale=0.5*IconPulse; //Special case for the repair icon because it is wtfHUGE and bright as the sun.
MidscreenVector.X=HUD.Canvas.SizeX/2;
MidscreenVector.Y=HUD.Canvas.SizeY/2;

MinFadeAlpha = 100; //Repair icon is bright as shit.

switch (MyTeam) //We're pretty self sufficient, so we can just use our own variables
	{
	case "GDI":
	//Setup for drawing Repair
	for (i=0; i<3; i++)
		{
			
				
				//Setup for drawing Repair
			if(GDI_Targets[i].B_Repair.T_Building != none && GDI_Targets[i].B_RepairMCT != none)
				
				//if(Rx_Pawn(GDI_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(GDI_Targets[i].T_Repair[j].T_Actor)
				{
					
					
					
				//Find the building's MCT
				
			
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,GDI_Targets[i].B_RepairMCT.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				TargetVector=HUD.Canvas.Project(GDI_Targets[i].B_RepairMCT.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(GDI_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-16); //last bit is for 8 point font. Repair thing is just huge apparenty?
				
				HUD.Canvas.DrawText("Repair" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location-GDI_Targets[i].B_RepairMCT.location)/52.5)$"m]",true,1,1);
					}
				
				}		
			
		
		}
		break;
	
	case "NOD":
	//Setup for drawing Repair
	for (i=0; i<3; i++)
		{
			
				
				//Setup for drawing Repair
			if(NOD_Targets[i].B_Repair.T_Building != none && NOD_Targets[i].B_RepairMCT != none)
				
				//if(Rx_Pawn(NOD_Targets[i].T_Repair[j].T_Actor).Health > 0 || Rx_Vehicle(NOD_Targets[i].T_Repair[j].T_Actor)
				{
					
					
					
				//Find the building's MCT
				
				
				
				bIsBehindMe = class'Rx_Utils'.static.OrientationOfLocAndRotToBLocation(RenxHud.PlayerOwner.ViewTarget.Location,RenxHud.PlayerOwner.Rotation,NOD_Targets[i].B_RepairMCT.location) < -0.5;
				if(!bIsBehindMe) 
					{
					
				TargetVector=HUD.Canvas.Project(NOD_Targets[i].B_RepairMCT.location) ;
				DistanceFade = abs(round(Vsize(MidscreenVector-TargetVector)))/(MidscreenVector.X) ; //Distance from the center of the screen.. Divided by the horizontal length of the screen, as it is USUALLY more than the vertical length
				HUD.Canvas.SetPos(TargetVector.x, TargetVector.y);
				//Insert functionality for fading with distance/ Scrap, fade is based on proximity of crosshair to target.
				HUD.Canvas.DrawColor.A=Fmax(MinFadeAlpha, Fmin(255*DistanceFade*DistanceFadeModifier,255));
				//HUD.Canvas.DrawColor.A=Fmax(255-(NOD_Targets[i].T_Repair[j].T_Age*80)-50,0);
				HUD.Canvas.DrawIcon(MyIcon,TargetVector.X-((MyIcon.UL/2)*IconScale),TargetVector.Y-((MyIcon.UL/2)*IconScale),IconScale);
				//HUD.Canvas.DrawIcon(TI_Repair,RepairVector.X-32,RepairVector.Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
				HUD.Canvas.SetPos(TargetVector.x-MyIcon.UL/4*IconScale, TargetVector.y-MyIcon.VL/4*IconScale-16); //last bit is for 8 point font.
				HUD.Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small';
				HUD.Canvas.DrawText("Repair" @ "["$ round(VSize(RenxHud.PlayerOwner.Pawn.location-NOD_Targets[i].B_RepairMCT.location)/52.5)$"m]",true,1,1);
					}
				
				}		
			
		
		}
		break;
	
	}
}		



	
	
/******************************************************
* Functions to handle Target Ages/Deaths... reasons to override or erase them
******************************************************/

simulated function FilterDeadTargets()
{

local int i, j;
//Clear GDI dead targets 
for (i=0; i<3; i++)
		{
			for(j=0;j<3;j++)
			{
			//Attack Targets
			if(GDI_Targets[i].T_Attack[j].T_Actor != none) 
				if( (Rx_Pawn(GDI_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Pawn(GDI_Targets[i].T_Attack[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(GDI_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Vehicle(GDI_Targets[i].T_Attack[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
				GDI_Targets[i].T_Attack[j].T_Actor = none;
				GDI_Targets[i].T_Attack[j].T_Age=0;
				GDI_Targets[i].T_Attack[j].Oldest=false;
				GDI_Targets[i].T_Attack[j].Pawn_ID=0;
				GDI_Targets[i].T_Attack[j].T_Actor_Name="";
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
			//Attack Targets
			if(NOD_Targets[i].T_Attack[j].T_Actor != none) 
				if( (Rx_Pawn(NOD_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Pawn(NOD_Targets[i].T_Attack[j].T_Actor).Health <= 0) || 
				(Rx_Vehicle(NOD_Targets[i].T_Attack[j].T_Actor)!=none && Rx_Vehicle(NOD_Targets[i].T_Attack[j].T_Actor).Health <= 0))
				{
					LogInternal("A target has been reset") ;
				//reset this target
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
	if(NOD_Targets[T].T_Attack[U].T_Age < 99999999999 && NOD_Targets[T].T_Attack[U].T_Actor !=none) NOD_Targets[T].T_Attack[U].T_Age+=1 ;		
	
	//Defense Targets
	if(GDI_Targets[T].T_Defend[U].T_Age < 99999999999 && GDI_Targets[T].T_Defend[U].T_Actor !=none) GDI_Targets[T].T_Defend[U].T_Age+=1 ;		
	if(NOD_Targets[T].T_Defend[U].T_Age < 99999999999 && NOD_Targets[T].T_Defend[U].T_Actor !=none) NOD_Targets[T].T_Defend[U].T_Age+=1 ;		

	//Repair targets
	if(GDI_Targets[T].T_Repair[U].T_Age < 99999999999 && GDI_Targets[T].T_Repair[U].T_Actor !=none) GDI_Targets[T].T_Repair[U].T_Age+=1 ;		
	if(NOD_Targets[T].T_Repair[U].T_Age < 99999999999 && NOD_Targets[T].T_Repair[U].T_Actor !=none) NOD_Targets[T].T_Repair[U].T_Age+=1 ;	

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




simulated function PlayAttackUpdateMessage(string T_String, byte UByte)
{
	if(TextTimer_Warning == 0) 
			{
				
				switch(UByte)//1: Updated 2: Removed 3: Destroyed 4: Decayed 
				{
					case 1:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Attack Targets Updated",Warning_Color,255, 255, false)	; //Only sends the text once
					TextTimer_Warning = SpamTime_Warning ; //Stops being able to flood the flashing text in the middle of the screen with messages.
					break;
					
					case 2:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Attack Target Removed",Warning_Color,255, 255, false)	; //Only sends the text once
					TextTimer_Warning = SpamTime_Warning ; //Stops being able to flood the flashing text in the middle of the screen with messages.
					break;
					
					case 3:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Attack Target Eliminated",Warning_Color,255, 255, false)	; //Only sends the text once
					//Because what's better than a mega boink? A mega boink, and a mega beep. 
					break;
					
					case 4:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Attack Target Decayed",Warning_Color,255, 255, false)	; //Only sends the text once
					TextTimer_Warning = SpamTime_Warning/4 ; //Stops being able to flood the flashing text in the middle of the screen with messages.
					break;
				}
				
				
			}
}

simulated function PlayDefenceUpdateMessage(string T_String, byte UByte)
{
	if(TextTimer_Caution == 0) 
			{
				switch(UByte)//1: Updated 2: Removed 3: Destroyed 4: Decayed 
				{
					case 1:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Targets Updated",Caution_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 2:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Target Removed",Caution_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 3:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Target Destroyed",Caution_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 4:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Target Decayed",Caution_Color,255, 255, false)	; //Only sends the text once
					break;
				}	

				TextTimer_Caution = SpamTime_Caution ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
}

simulated function PlayRepairUpdateMessage(string T_String, byte UByte)
{
	if(TextTimer_Update == 0) 
			{
				switch(UByte)//1: Updated 2: Removed 3: Destroyed 4: Decayed 
				{
					case 1:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Repair Targets Updated",Update_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 2:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Repair Target Removed",Update_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 3:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Repair Target Eliminated",Update_Color,255, 255, false)	; //Only sends the text once
					break;
					
					case 4:
					RenxHud.CommandText.SetFlashText(T_String, 70, "Repair Target Decayed",Update_Color,255, 255, false)	; //Only sends the text once
					break;
				}	
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
}

simulated function PlayWaypointUpdateMessage(string T_String, byte UByte)
{
	if(TextTimer_Update == 0) 
			{
				switch(Ubyte)
				
				{
				case 0: 
				RenxHud.CommandText.SetFlashText(T_String, 70, "Waypoint Removed",Update_Color,255, 255, false)	; //Only sends the text once
				break;
				
				case 1: 
				RenxHud.CommandText.SetFlashText(T_String, 70, "Waypoint Updated",Update_Color,255, 255, false)	; //Only sends the text once
				break;
					
				}
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
}

simulated function PlayDWaypointUpdateMessage(string T_String, byte UByte)
{
	if(TextTimer_Update == 0) 
			{
				switch(Ubyte)
				
				{
				case 0: 
				RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Waypoint Removed",Update_Color,255, 255, false)	; //Only sends the text once
				break;
				
				case 1: 
				RenxHud.CommandText.SetFlashText(T_String, 70, "Defensive Waypoint Updated",Update_Color,255, 255, false)	; //Only sends the text once
				break;
					
				}
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
}

simulated function PlayCommanderLeftMessage(string T_String)
{
	if(TextTimer_Update == 0) 
			{
				RenxHud.CommandText.SetFlashText(T_String, 60, "!!!A" @T_String@ "commander has left the game!!!",Warning_Color,128, 255, false)	; //Only sends the text once
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
}

simulated function PlayCommanderUpdateMessage(string T_String, int rank)
{
	if(T_String == "GDI")
	{
	
	if(TextTimer_Update == 0) 
			{
					switch(rank)
					{
					case 0:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.GDI_Commander[rank].CName$" is now" @T_String$ "'s COMMANDER",Update_Color,50, 255, true, 3)	;
					break;
		
					case 1:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.GDI_Commander[rank].CName$" is now " @T_String$ "'s CO-COMMANDER",Update_Color,50, 255, true, 3)	;
					break;
			
					case 2:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.GDI_Commander[rank].CName$" is now " @T_String$ "'s SUPPORT commander",Update_Color,50, 255, true, 3)	;
					break;
					}
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
	}
	
	if(T_String == "NOD")
	
	if(TextTimer_Update == 0) 
			{
					switch(rank)
					{
					case 0:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.NOD_Commander[rank].CName$" is now" @T_String$ "'s COMMANDER",Update_Color,50, 255, true, 3)	;
					break;
		
					case 1:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.NOD_Commander[rank].CName$" is now " @T_String$ "'s CO-COMMANDER",Update_Color,50, 255, true, 3)	;
					break;
			
					case 2:
					RenxHud.CommandText.SetFlashText(T_String, 15, myCC.NOD_Commander[rank].CName$" is now " @T_String$ "'s SUPPORT commander",Update_Color,50, 255, true, 3)	;
					break;
					}
				TextTimer_Update = SpamTime_Update ; //Stops being able to flood the flashing text in the middle of the screen with messages.
			}
	
}

simulated function ControlPulse()
{
	if(!IconPulseFlipped) IconPulse+=IconPulseRate;
	if(IconPulseFlipped) IconPulse-=IconPulseRate;

	if(IconPulse >= IconPulseMax) IconPulseFlipped = true ;
	if(IconPulse <= IconPulseMin) IconPulseFlipped = false; 
	
	
}


//My actual Draw Call
function Draw()
{
RenxHud.Canvas.SetDrawColor(255,255,255,255); //We don't blend around these parts (Alpha blending may occur in functions)
DrawAttackT();
DrawDefendT();
DrawRepairT();
DrawWayPoints();
DrawBuildingAttackTargets();
DrawBuildingDefendTargets();
DrawBuildingRepairTargets();
}

simulated function SpamTimerHandler ()
{
if(TextTimer_Caution > 0) TextTimer_Caution-- ;
if(TextTimer_Warning > 0 ) TextTimer_Warning-- ;
if(TextTimer_Update > 0 ) TextTimer_Update-- ;
if(TextTimer_Announcment > 0 ) TextTimer_Announcment-- ;	

if(TextTimer_Caution < 0) TextTimer_Caution=0 ;
if(TextTimer_Warning < 0 ) TextTimer_Warning=0 ;
if(TextTimer_Update < 0 ) TextTimer_Update=0 ;
if(TextTimer_Announcment < 0 ) TextTimer_Announcment=0 ;	
	
}



////////////Functions to find out if our player is a commander////////////////
simulated function bool IsInstigatorCommander() 
{
local int i, myPID;

if(RenxHud.PlayerOwner != none) myPID = Renxhud.PlayerOwner.PlayerReplicationInfo.PlayerID ;
LogInternal("MyPID is: "@ myPID);
	LogInternal("myCC GDI PID" @ myCC.GDI_Commander[i].Pid);
	LogInternal("myCC NOD PID" @ myCC.NOD_Commander[i].Pid);
for(i=0;i<=2;i++)
	{	
if(myPID == myCC.GDI_Commander[i].Pid || myPID == myCC.Nod_Commander[i].Pid)
		{
return true;
break;
		}
	}
return false;
}

simulated function int GetInstigatorCRank()
{
local int i, myPID;

if(RenxHud.PlayerOwner != none) myPID = RenxHud.PlayerOwner.PlayerReplicationInfo.PlayerID ;
	
for(i=0;i<=2;i++)
	{// There are 3 commanders until there aren't	
if(myPID == myCC.GDI_Commander[i].Pid || myPID == myCC.Nod_Commander[i].Pid)
		{
		return i;
		break;
		}
	
	}
return -1; //Not a commander at all	
}

