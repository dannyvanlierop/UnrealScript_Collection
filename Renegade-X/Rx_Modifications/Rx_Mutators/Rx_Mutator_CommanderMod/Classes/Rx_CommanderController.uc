/*
** Rx_CommanderController
*/

class Rx_CommanderController extends ReplicationInfo;


/** ******************************************
struct CommanderHUD 
{

var Rx_HUD C_HUD ;
var Rx_GfxObject CommanderSymbol ;
var Rx_GfxObject Current_Objective ; 

}
**************************************************** */


struct Commander 
{
var Rx_Pawn CPawn				;
var Rx_HUD_Ext  CHUD			;
var int ControllerTeamIndex		;	
var string C_Objective	;
var int Pid 					; 
var Rx_PRI CPRI 				; 
var string CName 				;
var Rx_Controller Controller	;
var bool Init_Phase				;
var Rx_CObjective  TObjective	;

	structDefaultProperties 
	{
	Init_Phase = true	
	}
};

var repnotify Commander GDI_Commander[3]	;

var repnotify Commander Nod_Commander[3] 	; 

var int TextTimer_Caution, TextTimer_Warning, TextTimer_Update, TextTimer_Announcment;
var int SpamTime_Caution, SpamTime_Warning, SpamTime_Update, SpamTime_Announcment;


//Types of orders commanders can give 
enum CALL_TYPE 
{
	CT_ATTACK,
	CT_DEFEND,
	CT_REPAIR,
	CT_TAKEPOINT
};

var int ControllerTeamIndex		;

var int C_Check_Cycler, C_Check_Timer			;

var SoundCue ElectedSound_GDI 	;

var SoundCue ElectedSound_Nod 	;

var color Warning_Color, Caution_Color, Update_Color, Announcment_Color			;

var Rx_ORI ORI;

/*****************************************************************************************/
/*****************************************************************************************/
/*****************************************************************************************/

replication
{
	if( bNetInitial && Role == ROLE_Authority )
	
		 ElectedSound_GDI,ElectedSound_Nod;
	
	if ( bNetDirty )
		GDI_Commander, Nod_Commander ;

	//if ( !bNetInitial && bNetDirty )
		//RemainingMinute;

	/**if ( bNetInitial )
		 TextTimer_Caution, TextTimer_Warning, TextTimer_Update, TextTimer_Announcment,
		SpamTime_Caution, SpamTime_Warning, SpamTime_Update, SpamTime_Announcment,
		Warning_Color, Caution_Color, Update_Color, Announcment_Color;
*/
}
	




simulated function Tick(float DeltaTime)
{

local Rx_HUD_Ext H;
local bool GDIInGame, GDIRightTeam, NodInGame,NodRightTeam;

//if(!IsTimerActive('TestCall')) SetTimer(5.0,true,'TestCall');
//Reset the cycler variable

if(!IsTimerActive('SpamTimerHandler')) SetTimer(0.1,true,'SpamTimerHandler'); //Make sure these are running at all times
if(!IsTimerActive('EquipCommanders')) SetTimer(1.0,true,'EquipCommanders'); //Make sure commanders are outfitted every half second or so. 

//Only run this part on the server, as some clients are always going to get out of sync




	
if (WorldInfo.NetMode == NM_DedicatedServer || WorldInfo.NetMode == NM_Standalone)
		{
			
			if(C_Check_Timer < 3) //Doesn't need to be done every tick
	
			{
				C_Check_Timer++;
				return;  
			}
			
			else
			{
				
			//Update Objectives if they exist
			if(GDI_Commander[C_Check_Cycler].TObjective != none)
				{
				GDI_Commander[C_Check_Cycler].TObjective.Update();
				if(GDI_Commander[C_Check_Cycler].TObjective != none && GDI_Commander[C_Check_Cycler].TObjective.Update() == false) DeleteObjective(C_Check_Cycler, 0);
				}
			if(Nod_Commander[C_Check_Cycler].TObjective != none) 
				{
				Nod_Commander[C_Check_Cycler].TObjective.Update();
				if(Nod_Commander[C_Check_Cycler].TObjective != none && NOD_Commander[C_Check_Cycler].TObjective.Update() == false) DeleteObjective(C_Check_Cycler, 1);	
				}
			C_Check_Timer = 0;
			}
			
			
		if(C_Check_Cycler > 2)	C_Check_Cycler=0					;
//Add check for if Commander leaves. Called for 2 commanders per 5 ticks as opposed to all 6 at once.





if(GDI_Commander[C_Check_Cycler].CPRI != none && GDI_Commander[C_Check_Cycler].Pid != -1 && !GDI_Commander[C_Check_Cycler].Init_Phase) 
	{
	GDIInGame = CommanderInGame("GDI", C_Check_Cycler);
	GDIRightTeam = CommanderOnRightTeam("GDI", C_Check_Cycler);
	//`log("One of these is off somewhere...... PRI: "$GDI_Commander[C_Check_Cycler].CPRI $"PID: "$GDI_Commander[C_Check_Cycler].Pid $"InitPhase "$GDI_Commander[C_Check_Cycler].Init_Phase);
	//`log (C_Check_Cycler$ "Is in Game "$CommanderInGame("GDI", C_Check_Cycler) $ "And on right team is: "$ CommanderOnRightTeam("GDI", C_Check_Cycler));
	if(GDIInGame==false || GDIRightTeam==false)
		{ 
LogInternal("ERASING COMMANDER"$ C_Check_Cycler)		;
LogInternal("Commander PRI is "$ GDI_Commander[C_Check_Cycler].CPRI)		;
	
	foreach AllActors(class'Rx_HUD_Ext', H)
			{
		
		if(H.PlayerOwner.GetTeamNum() == 0 && (GDIInGame==false || GDIRightTeam==false))	H.CommandText.SetFlashText("GDI", 60, "!!!A GDI commander has left the game!!!",Warning_Color,0, 255, false)	;
	
			}
	EraseCommander("GDI", C_Check_Cycler)	;
	
	
		}
	}
/////////////////////////////////////////////////////////////////////	
////////////////////Check the same for Nod///////////////////////////
/////////////////////////////////////////////////////////////////////

	if(NOD_Commander[C_Check_Cycler].CPRI != none && NOD_Commander[C_Check_Cycler].Pid != -1 && !NOD_Commander[C_Check_Cycler].Init_Phase) 
	{
	NodInGame = CommanderInGame("Nod", C_Check_Cycler);
NodRightTeam = CommanderOnRightTeam("Nod", C_Check_Cycler);

	//`log("Commanders PIDs aren't -1");
	
	if(NodInGame==false || NodRightTeam==false)
		{ 
//`log("ERASING COMMANDER"$ C_Check_Cycler)		;
LogInternal("Commander PRI is "$ NOD_Commander[C_Check_Cycler].CPRI)		;
	foreach AllActors(class'Rx_HUD_Ext', H)
			{
		
		if(H.PlayerOwner.GetTeamNum() == 1 && (NodInGame==false || NodRightTeam==false))	H.CommandText.SetFlashText("Nod", 60, "!!!A Nod commander has left the game!!!",Warning_Color,50, 255, true, 6)	;
	
			}
	EraseCommander("Nod", C_Check_Cycler)	;
	
	
		}
	}
	
if(C_Check_Cycler < 2)C_Check_Cycler+=1		;	
else
C_Check_Cycler=0;	
			
			
			
		}


}




/***************************************************************************************************************
*Function that when called, updates the objective for a team, then sends it to Rx_ORI to actually process targets
*and handle targeting information.
****************************************************************************************************************/

reliable server function Update_Obj (
	int Team,	//0 = GDI, 1=Nod
	int rank, //Same rank 0-2 to define primary/secondary and support commanders  
	int CT,	//Call type. Type of objective being passed: 0:Attack 1:Defend 2:Repair 3:TakePoint
	bool IsWaypointUpdate, //Is this a waypoint being updated? When this is true, there should be no actor or anything else needed. 
	bool IsActualUpdate, //Says whether or not this warrants updating the objective in the objective box, as well as giving the "Primary/Secondary Objective Updated" message
	optional Actor A,	//Actor the main command is directed at.
	optional Actor B, //Actor that is more than likely a building, only used when ItActualUpdate is true.
	optional Vector WP_Coord,	//Coordinates of the waypoint if this is a waypoint update
	optional string A_String, 	//string used as a workaround in multiplayer since the actors designated by the binoculars can't be directly passed to the server.
	optional Vector V_Loc,		//Second workaround for multiplayer, since vehicles have a tendency to get totally out of sync.
	optional int P_ID			//3rd workround for multiplayer. Use the player ID of the pawn's PRI to determine what pawn to draw targets on on all clients. 
	)
//string S,	Start of "optional" components. These are "optional" only in that they are only used depending on what type of call it is.
{
	
	local string T_String, ActName;
	
	

	
	//H=Rx_HUD_Ext(GetALocalPlayerController().myHUD) ;
	
	
	switch (Team)
	{
		case 0: 
		T_String="GDI" ;
		break;
		
		case 1: 
		T_String="NOD" ; //Capitalized throughout for consistency
		break;
	}
	
	
	
	//if(Team==0)  //For GDI
	
	//`log("Current Controller is: " $CurrentC $ "Current HUD is: "$GetHUD(CurrentC));
	switch(CT)
		{
		
		
		
		case 0: //CT_ATTACK :
		
			LogInternal("Sending Actor through command controller: "$A@"Building target is"@B);
			//If it is an actual Objective update, send that information to the Obox. In the case of ATTACK, only buildings are counted as being worthy of updating the objective.//
			
			/********************************************
			*Deprecated Functions: Objectives regarding buildings
			*Are no longer handled in this manner
			**********************************************/
			
			/**
				if(IsActualUpdate && B != none) 
				{
				
				ActName = B.GetHumanReadableName() ;
				
				switch(Team)
				{
					case 0:
					GDI_Commander[rank].C_Objective = "Attack the "$ActName$"!" ; //TODO Eventually add support for placing images of the target here.
					break;
					
					case 1:
					NOD_Commander[rank].C_Objective = "Attack the "$ActName$"!" ; //TODO Eventually add support for placing images of the target here.
					break;
				}
				*/
				
				ORI.Update_Markers (T_String, CT, rank, IsWaypointUpdate, IsActualUpdate, A, B, WP_Coord, A_String, V_Loc, P_ID) ;
				//ClientUpdateObjectives(Team,rank,CT,IsWaypointUpdate,IsActualUpdate,A,B,WP_Coord);
			break;
			
		case 1: // CT_DEFEND : 
			
			
			//If it is an actual Objective update, send that information to the Obox. In the case of DEFEND, only buildings are counted as being worthy of updating the objective.//
			
			//Tell Rx_HUD_ObjectiveVisuals to update the location of its defence targets
			
			/** Again, more deprecated functionality, as objectives are not handled in this manner anymore
			if(IsActualUpdate && B != none) 
				{
				
				ActName = B.GetHumanReadableName() ;
					
				
				switch(Team)
				{
					case 0:
					`log("Attempted to create Defensive Objective");
				GDI_Commander[rank].C_Objective = "Defend the "$ActName$"!!!" ; //TODO Eventually add support for placing images of the target here.
				break;
				
					case 1:
				NOD_Commander[rank].C_Objective = "Defend the "$ActName$"!!!" ; //TODO Eventually add support for placing images of the target here.
				break;
				}
				
				}
				*/
				
				ORI.Update_Markers (T_String, CT, rank, IsWaypointUpdate, IsActualUpdate, A, B, WP_Coord, A_String, V_Loc, P_ID) ;
				
				//ClientUpdateObjectives(Team,rank,CT,IsWaypointUpdate,IsActualUpdate,A,B,WP_Coord);
				
			break;
			
		case 2: //CT_REPAIR : //Not finished
			
			//If it is an actual Objective update, send that information to the Obox. In the case of REPAIR, only buildings are counted as being worthy of updating the objective.//
			
			/** Deprecated 
			if(IsActualUpdate && B != none) 
				{
				
				ActName = B.GetHumanReadableName() ;
				
				//Tell Rx_HUD_ObjectiveVisuals to update the location of its repair targets
				
				switch(Team)
				{
					case 0:
				GDI_Commander[rank].C_Objective = "REPAIR THE "$ActName$"!!!" ; //TODO Eventually add support for placing images of the target here.
				break;
				
				case 1:
				NOD_Commander[rank].C_Objective = "REPAIR THE "$ActName$"!!!" ; //TODO Eventually add support for placing images of the target here.
				break;
				}
			}
			*/
			ORI.Update_Markers (T_String, CT, rank, IsWaypointUpdate, IsActualUpdate, A, B, WP_Coord, A_String,V_Loc, P_ID) ;
			//ClientUpdateObjectives(Team,rank,CT,IsWaypointUpdate,IsActualUpdate,A,B,WP_Coord);
			break;
				
		case 3: //CT_TAKEPOINT : //Not finished
		
			//If it is an actual Objective update, send that information to the Obox. TAKEPOINT is set to an objective only if the player holds the fire button down long enough//
			if(IsActualUpdate) 
			{
				
				//if(Rx_CommanderWaypoint(B) !=none) ActName = Rx_CommanderWaypoint(B).NearestSpot ;
				
				
				//Tell Rx_HUD_ObjectiveVisuals to update the location of its neutral waypoint for the team,
				ActName = GetSpottargetLocationInfo(WP_Coord);		
				LogInternal(ActName);
				switch(Team)
				{
					///////////////////////////////////////////////////////////////////////
					//For now, ALWAYS set this as a support objective until further notice
					//It is only still here because I like having the ability to have waypoints
					//as objectives.
					//////////////////////////////////////////////////////////////////////
					case 0:
				GDI_Commander[2].C_Objective = "Take "$ActName ;
				ORI.StoreObjective(T_String,CT,2,GDI_Commander[2].C_Objective);
				break;
				
				case 1:
				NOD_Commander[2].C_Objective = "Take "$ActName ;
				ORI.StoreObjective(T_String,CT,2,NOD_Commander[2].C_Objective);
				break;
				}
				
			
			}
			ORI.Update_Markers (T_String, CT, rank, IsWaypointUpdate, IsActualUpdate, A, B, WP_Coord, A_String, V_Loc, P_ID) ;
			//ClientUpdateObjectives(Team,rank,CT,IsWaypointUpdate,IsActualUpdate,A,B,WP_Coord);
			break;
		}
}
	//Deprecated: No longer are primary objectives controlled in this manner
	/**switch(Team) //Store the objective, assuming it was even set.
	{
		case 0:
	ORI.StoreObjective(T_String,CT,rank,GDI_Commander[rank].C_Objective);
	break;
	
	case 1:
	ORI.StoreObjective(T_String,CT,rank,NOD_Commander[rank].C_Objective);
	break;
	}	
	*/

	
	

	
	



reliable server function SetCommander(Rx_Controller PC, int Team, int rank)
{

//rank 0: Commander 
//rank 1: CoCommander
//rank 2: SupportCommander 

local Rx_Pawn P ;
local Rx_HUD_Ext HUD;
P = Rx_Pawn(PC.Pawn) ;


HUD=Rx_HUD_Ext(PC.myHUD)	;

if (rank > 2) return ;

if(Team == 0) 
	{
	GDI_Commander[rank].CPawn = P ;
	GDI_Commander[rank].CHUD = HUD ; 
	GDI_Commander[rank].C_Objective = "NULL" ;
	GDI_Commander[rank].Pid = PC.PlayerReplicationInfo.PlayerID ;
	GDI_Commander[rank].CPRI = Rx_PRI(PC.PlayerReplicationInfo) ;
	GDI_Commander[rank].CName = PC.PlayerReplicationInfo.PlayerName ;
	GDI_Commander[rank].Controller = PC;
	GDI_Commander[rank].Init_Phase = false	;
	

	PC.ClientPlaySound(ElectedSound_GDI) ;
	
//HUD.Obox.Update_Objective(rank, 2, GDI_Commander[rank].C_Objective )  ;
	
	//GDI_Commander[rank].CHUD.AddPostRenderedActor(self) ;
	} 
		
		
if(Team == 1) 
	{
	NOD_Commander[rank].CPawn = P ;
	NOD_Commander[rank].CHUD = HUD ; 
	NOD_Commander[rank].C_Objective = "NULL" ;
	NOD_Commander[rank].Pid = PC.PlayerReplicationInfo.PlayerID  ;
	NOD_Commander[rank].CPRI = Rx_PRI(PC.PlayerReplicationInfo) ;
	NOD_Commander[rank].CName = PC.PlayerReplicationInfo.PlayerName ;
	NOD_Commander[rank].Controller = PC;
	Nod_Commander[rank].Init_Phase = false	;
	
	
	PC.ClientPlaySound(ElectedSound_Nod) ;
	} 
		
		
}
	
function string GetCommanderName(string Team, int rank) 
{
	switch (Team) 
	{
		case "GDI": 
		return GDI_Commander[rank].CName ;
		break;
		
		case "Nod":
		return Nod_Commander[rank].CName ;
		break;
	
	default: 
	return "NULL" ;
	break;
	}
	
}
	
simulated function bool CommanderInGame(string Team, int rank)

{
	
	//Look in the game replication info to see if the commander's PRI is still around
	switch (Team)
	{
	case ("GDI"):
	//`log ("GRI found PRI: " $(Rx_Game(WorldInfo.Game).FindPlayerByID(GDI_Commander[rank].Pid)));
		if(Rx_Game(WorldInfo.Game).FindPlayerByID(GDI_Commander[rank].Pid) != GDI_Commander[rank].CPRI)
			{
			return false;
			}
		else
		return true;
		
		break;
	
	case ("Nod"):
	
		if(Rx_Game(WorldInfo.Game).FindPlayerByID(NOD_Commander[rank].Pid) != NOD_Commander[rank].CPRI)
			return false;
		else
			return true;
			break;
	default: 
	
	return true;
	break;
	}
	
	
	//foreach AllActors(class'Rx_Controller', PN) {
		
		
		
}
	
simulated function bool CommanderOnRightTeam(string Team, int rank) 
{
	
	//Look in the game replication info to see if the commander's PRI still has him on the right team
	switch (Team)
	{
	case ("GDI"):
	//`log ("GRI found PRI: " $(Rx_Game(WorldInfo.Game).FindPlayerByID(GDI_Commander[rank].Pid)));
		if(Rx_Game(WorldInfo.Game).FindPlayerByID(GDI_Commander[rank].Pid).Team.TeamIndex == 0)
			{
			return true;
			}
		else
		return false;
		
		break;
	
	case ("Nod"):
	
		if(Rx_Game(WorldInfo.Game).FindPlayerByID(NOD_Commander[rank].Pid).Team.TeamIndex == 1)
			return true;
		else
			return false;
			break;
	default: 
	
	return true;
	break;
	}
	
}

unreliable server function SendTargetsClear(int OType, int rank, int ITeam)
{
	
	ORI.EraseTargets(OType,rank,ITeam);
	
}


reliable server function EraseCommander (string Team, int rank){ //Set to server function as it will simply replicate the change to all clients. Trying to have all clients perform this ends up with ineffective results.
	
	LogInternal("Erase Commander Ran: " @Team @rank);
switch (Team)
	{
	case "GDI":
	GDI_Commander[rank].CPawn = none ;
	GDI_Commander[rank].CHUD = none ; 
	GDI_Commander[rank].C_Objective = "" ;
	GDI_Commander[rank].Pid = -1 ;
	GDI_Commander[rank].CPRI = none ;
	GDI_Commander[rank].CName = "NULL" ;
	GDI_Commander[rank].Controller = none;
	break;

	case "Nod":
	
	Nod_Commander[rank].CPawn = none ;
	Nod_Commander[rank].CHUD = none ; 
	Nod_Commander[rank].C_Objective = "" ;
	Nod_Commander[rank].Pid = -1 ;
	Nod_Commander[rank].CPRI = none ;
	Nod_Commander[rank].CName = "NULL" ;
	Nod_Commander[rank].Controller = none;
	break;
	
	}
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

//Function jacked from CheatManager and edited to be used here. 
function Rx_Weapon CCGiveWeapon( String WeaponClassStr, Pawn CPawn )
{
	Local Rx_Weapon		Weap;
	local class<Rx_Weapon> WeaponClass;

	WeaponClass = class<Rx_Weapon>(DynamicLoadObject(WeaponClassStr, class'Class')); //soooo class is a class... called class. Funny.
	Weap		= Rx_Weapon(CPawn.FindInventoryType(WeaponClass));
	if( Weap != None )
	{
		return Weap;
	}
	return Rx_Weapon(CPawn.CreateInventory( WeaponClass ));
}



function EquipCommanders () 
{
local Rx_Controller LPC ;
local Rx_InventoryManager IM;
local int i ;
foreach WorldInfo.AllControllers(class'Rx_Controller', LPC)
	{
	for(i=0;i<3;i++)
		{
	  
	  if(LPC.PlayerReplicationInfo.PlayerID == GDI_Commander[i].Pid && Rx_Vehicle(LPC.Pawn) == none && Rx_VehicleSeatPawn(LPC.Pawn)==none && LPC.Pawn.Health > 0)
			{
				//Add binoculars GDI				
				IM=Rx_InventoryManager(LPC.Pawn.invmanager);
				if(IM.FindInventoryType(class'Renx_CommanderMod.Rx_Weapon_CommanderBinoculars_GDI') == none)
				{
				LogInternal("Player found without binoculars");
				CCGiveWeapon("Renx_CommanderMod.Rx_Weapon_CommanderBinoculars_GDI", LPC.Pawn);
						LogInternal("Attempted to add Binoculars");
				}
			}
	  if(LPC.PlayerReplicationInfo.PlayerID == NOD_Commander[i].Pid && Rx_Vehicle(LPC.Pawn) == none && Rx_VehicleSeatPawn(LPC.Pawn)==none && LPC.Pawn.Health > 0)
			{
				//Add binoculars NOD				
				IM=Rx_InventoryManager(LPC.Pawn.invmanager);
				if(IM.FindInventoryType(class'Renx_CommanderMod.Rx_Weapon_CommanderBinoculars_Nod') == none)
				{
				LogInternal("Player found without binoculars");
				CCGiveWeapon("Renx_CommanderMod.Rx_Weapon_CommanderBinoculars_Nod", LPC.Pawn);
						LogInternal("Attempted to add Binoculars");
				}
				
			}
		}
	}

}

function TestCall()
{
	local HUD Hudds;
	foreach AllActors(class'HUD', Hudds)
	{
		LogInternal("HUDS ARE:"$ Hudds$ "If any.");
		
	}
	

	
//`log("CommanderController still exists on SERVER/n CheckCycler ="$C_Check_Cycler$" /n GDI Command Registered in Game:"$CommanderInGame("GDI", C_Check_Cycler)$" /n GDI command on right team"$ CommanderOnRightTeam("GDI", C_Check_Cycler)$ "GDI_Commander PRI: "$GDI_Commander[0].CPRI);
	return;
}

simulated function HUD GetHUD(Rx_Controller C)
{
	return C.myHUD;
}

//Jacked from Rx_Controller for finding the nearest spot target. It also makes the string grammatically correct with 'the'
simulated function string GetSpottargetLocationInfo(Vector WaypointTarget) 
{
	local string LocationInfo;
	local RxIfc_SpotMarker SpotMarker;
	local Actor TempActor;
	local float NearestSpotDist;
	local RxIfc_SpotMarker NearestSpotMarker;
	local float DistToSpot;	
	
	LogInternal("STarted looking for nearest spot marker");
	foreach AllActors(class'Actor',TempActor,class'RxIfc_SpotMarker') {
		SpotMarker = RxIfc_SpotMarker(TempActor);
		DistToSpot = VSize(TempActor.location - WaypointTarget);
		if(NearestSpotDist == 0.0 || DistToSpot < NearestSpotDist) {
			NearestSpotDist = DistToSpot;	
			NearestSpotMarker = SpotMarker;
		}
	}
	
	LocationInfo = NearestSpotMarker.GetSpotName();	
	LogInternal("Got marker"@LocationInfo);
	//Correct the string grammatically before returning it
	if(Left(LocationInfo, 3) != "The" && Left(LocationInfo, 3) != "the") LocationInfo="the"@LocationInfo; 
	
	return LocationInfo;
}


/**********************************************************************************
* Rewarded objective handling information
*
* Includes information to create objective classes on the server, and to force the objective update. 
*
*
*
***********************************************************************************/

function RecieveObjective(int TeamI,int CRank, string ObjString, class<Rx_CObjective> ObjType, byte SubO)
{
LogInternal("Team:"@ TeamI @ "Rank:" @ CRank @ ObjString @ "Obj_Class:");
ServerSendObjective(TeamI, CRank, ObjString,ObjType, SubO); //push to server counterpart. At no other point does the client even need to process anything regarding this information. They'll get what they need replicated.
	
}


reliable server function ServerSendObjective(int TeamI,int CRank, string ObjString, class<Rx_CObjective> CObj, byte SubO)
{

LogInternal("Team:"@ TeamI @ "Rank:" @ CRank @ ObjString @ "Obj_Class:" @ "SubOb:" @ SubO);

switch(TeamI)

	{
		
	case 0: //GDI
	GDI_Commander[CRank].TObjective = new(self) CObj; // So apparently just using class<Rx_CObjective> doesn't work for this... so switch it is.
	GDI_Commander[CRank].TObjective.myCC=self;
	GDI_Commander[CRank].C_Objective = ObjString;
		
	
		switch(CObj)
		{
		case class'Rx_CObjective_Attack':
		ORI.StoreObjective("GDI",0,CRank,GDI_Commander[CRank].C_Objective);
		break;
		}
		
	GDI_Commander[CRank].TObjective.ForTeam=TeamI						;
	GDI_Commander[CRank].TObjective.ObjectiveActual=SubO				;
	
	GDI_Commander[CRank].TObjective.Init()						;
	GDI_Commander[CRank].TObjective.GetTeam()						;
	
	break;
		
	case 1: //Nod
	
	NOD_Commander[CRank].TObjective = new(self) CObj;
	NOD_Commander[CRank].TObjective.myCC=self;
	NOD_Commander[CRank].C_Objective = ObjString;
	switch(CObj)
		{
		case class'Rx_CObjective_Attack':
		ORI.StoreObjective("NOD",0,CRank,NOD_Commander[CRank].C_Objective);
		break;
		}
	
	NOD_Commander[CRank].TObjective.ForTeam=TeamI								;
	NOD_Commander[CRank].TObjective.ObjectiveActual=SubO						;
	NOD_Commander[CRank].TObjective.Init()										;
	NOD_Commander[CRank].TObjective.GetTeam()										;
	
	break;
	
	
	}
	
}


function SendObjectiveComplete(int TeamI)
{
	local int i;
	//Look for objectives that are completed (On server only; the only thing the client will need is the replicated update that the objective was completed)
	if(WorldInfo.NetMode == NM_DedicatedServer || WorldInfo.NetMode == NM_Standalone)
	{
	if(TeamI == 0)
	{
		for(i=0;i<3;i++)
		{
		if(GDI_Commander[i].TObjective != none && GDI_Commander[i].TObjective.bComplete) 
			{
			//GDI_Commander[i].TObjective.CompleteObjective();
			GDI_Commander[i].TObjective.DestroyThyself();
			GDI_Commander[i].C_Objective = "Completed";
			ORI.StoreObjective("GDI",3,i,GDI_Commander[i].C_Objective);
			GDI_Commander[i].TObjective=none;
			}
		}
		
	}
	
	if(TeamI == 1)
	{
		for(i=0;i<3;i++)
		{
		if(Nod_Commander[i].TObjective != none && Nod_Commander[i].TObjective.bComplete) 
			{
			//Nod_Commander[i].TObjective.CompleteObjective();
			Nod_Commander[i].TObjective.DestroyThyself();
			Nod_Commander[i].C_Objective = "Completed";
			ORI.StoreObjective("NOD",3,i,NOD_Commander[i].C_Objective);
			Nod_Commander[i].TObjective=none;
			}
		}
		
	}
	
	}
	
}

function DeleteObjective(int CRank, int TeamI)
{
	
	if(TeamI==0){
	GDI_Commander[CRank].TObjective.DestroyThyself();
			GDI_Commander[CRank].C_Objective = "NULL";
			GDI_Commander[CRank].TObjective=none;
	}
	else
	{
	NOD_Commander[CRank].TObjective.DestroyThyself();
			NOD_Commander[CRank].C_Objective = "NULL";
			NOD_Commander[CRank].TObjective=none;
	}
	
}


