/*
** Rx_Weapon_CommanderBinoculars
*/

class Rx_Weapon_CommanderBinoculars extends Rx_Weapon_Scoped ; 

///////////////////////////////////////////////////////
////////////////////////ATTACK stuff///////////////////
///////////////////////////////////////////////////////
struct AttackTarget 
{
var Actor AT_Actor;
var class AT_Class;
var Pawn AT_Pawn	;
var string AT_ClassType;

//var float AT_ThreatLevel  // Will add at a later date.			
};

var string RepTarget1, RepTarget2, RepTarget3;
var Vector RepLocation1, RepLocation2, RepLocation3; //These could be arrays....... but that'd make sense
var int RepID1, RepID2, RepID3						;

var AttackTarget A_Target[3]; //Can have up to three ATTACK targets selected at any time
var Actor A_TargetB			;// The speshul happy place where building attack orders are stored, as they actually make primary objectives
var Actor TempTarget		; //Holds the temporary target (Usually a building) for any state.
var Rx_Building AT_Target_Building ; //The final building that we'll be setting as an objective.

//Stuff used from State to state. 

var Vector WAYPOINT, Scanned_V, AT_Target_WayPoint		;
var bool CanSetWaypoint; //Probably only used for Defensive waypoint. Takepoint objective ONLY has a waypoint, so it doesn't really need to check much.
var float ScanPercIncrement, ScanTime, ScanPerc ; //ScanTime probably between 0.1 (Determines how fast we add to the percentage)
var Rx_Building Scanned_B ; // Building being scanned, may need to also use one for attachments


//Types of orders commanders can give (Used sparingly, but helpful where it can be) 
enum CALL_TYPE 
{
	CT_ATTACK,
	CT_DEFEND,
	CT_REPAIR,
	CT_TAKEPOINT
};


var Rx_CommanderController myCC;
var CanvasIcon TempAttackIcon;
var int Objective_To_Set,Target_Distance, OnTarget			; //TODO: Target_Threat ; OnTarget: Special integer used for cycling through multi-targets	
var ParticleSystem BeamEffect								;
var private ParticleSystemComponent Beam;					;
var vector EndLaserLoc, EndTargetLoc						;
var Actor  ObjectiveTarget, NULL_Target						; //NULL_Target is used when simply looking through the binoculars without scanning.
var color Objective_Color, LensColor, C_Attack, C_Defend, C_Repair, C_TakePoint	;
var float MaxDistance										;
var string ObjectiveString, PrevObjectiveString, NextObjectiveString ; //String Attack/Defend/Repair/TakePoint
var name Ostate				; //Name of the state we're going to for the current objective.

///////////////Variables used for drawing the SCANNING text whilst holding down the fire button//////////
var bool ScanningForTargets									;	
var byte SCANNING_Alpha				;
var float SCANNING_Cycler,SCANNING_CyclerMAX, SCANNING_ALPHA_INCREMENT 		;  
var bool bSCANNING_FlashUP									;
//simulated function Moved();
var SoundCue SndScroll										;
var name ClearTargetKey										;
var string OriginalClearTargetKeyCommand					;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////If we're zoomed in, update target distance info, but that's about it/////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////


simulated function PostBeginPlay()
{
	local Rx_CommanderController CCON ; 
	super.PostBeginPlay() ;
	
	foreach AllActors(class'Rx_CommanderController', CCON)
	{
		
		myCC = CCON ;
		
		break;
		
		}
	
	
}

simulated state Active 
{
	
	////////////Keep this consistent, but other things need to change////////////////
	/** simulated event BeginState(Name PrevStateName)
	{
	// And I have no idea how to set Item names by default...
	
		}
	*/
	
	
	/////////Obviously need to modify StartFire. First few lines jacked from the Airstrike code./////
simulated function StartFire(byte FireModeNum)
	{
		if(!IsInstigatorCommander()) 	return; //You ain't my real daddy RE-ADD THIS AFTER TESTING
		
		
		if (Instigator == None || !Instigator.bNoWeaponFiring)
		{
			if (FireModeNum != 0)
			{
				// if not Fire, call global
				global.StartFire(FireModeNum);
				return;
			}

			// make sure this only gets executed on players ever
			if (WorldInfo.NetMode == NM_DedicatedServer ||
				(WorldInfo.NetMode == NM_ListenServer && !bNetOwner))
				return;
	
	//Make sure we're still zoomed.	
	if (GetZoomedState() != ZST_Zoomed)
				return;
	
	//ServerSetScanningTrue()		; //Shouldn't be necessary if it all will be handled in the StScanning state.
	
	
	//Go to the scanning state TODO: Make that state////
	
	if(Objective_To_Set == 0) GotoState('StAttackScan')  ;
	if(Objective_To_Set == 1) GotoState('StDefendScan')  ;
	if(Objective_To_Set == 2) GotoState('StRepairScan')  ;
	if(Objective_To_Set == 3) GotoState('StTakePointScan')  ;
		}
	
	}
/**	 simulated event EndState(Name NextStateName)
	{
			
		
	}
*/
}

/*******************************************************************************************/
/*************************** ATTACK STATE **************************************************/
/*********	The STATE we use for all of our ATTACK objective Scanning **********************/
/*******************************************************************************************/
/*******************************************************************************************/

//Add variable



simulated state StAttackScan
{

simulated event BeginState (Name PreviousState)
{
//Confirmed, scanning for targets so long as we're in this state.
if(!ScanningForTargets) ScanningForTargets=true;
AT_Target_Building = none;
//Timer for ScanTargets()
SetTimer(0.10,true,'ScanTargets') ;
}



simulated function ScanTargets() //Variant of Update_Range
{

local vector startL, normthing, endL	;
	local rotator ADir					;
	local Actor TheTarget				;
	local int i							;
	local bool InArray					;
	// get aiming direction from our instigator (Assume this is the pawn from what I've read.)
	 ADir = Instigator.GetBaseAimRotation();
	
	TempTarget=none; //Reset TempTarget for this cycle so that ScanBuilding() doesn't continue to increase the scan percentage when targeting nothing.
	
	startL=InstantFireStartTrace(); //Using function out of Rx_weapon to find the end of our weapon, or just our own location
	
	//.......... Yosh need learn math. Working in 3D space is making me twitchy X.x
	
	TheTarget=Trace(endL, normthing, startL + vector(Adir) * MaxDistance, startL, true) ;
	
	 if(TargetIsValid(TheTarget) && !TargetIsBuilding(TheTarget)) 
	 {
		 if(OnTarget > 2) OnTarget = 0;
		
		 //Target is valid, but is it already one of our targets ?
		 for(i=0; i<3;i++)
		 {
			 if(A_Target[i].AT_Actor==TheTarget) 
			 {
			InArray = true ; 
			 break;
			 }
		 }
	
		//Now we know if the target is in our targeting array or not... so if it isn't, add it. If it is, ignore the bastard and push the target # we're setting up a notch
		
		if(!InArray)
			{
			AddTarget(TheTarget, OnTarget);
			switch(OnTarget)
			{
			case 0:
				RepTarget1 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation1=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget1);
				break;
				
				case 1:
				RepTarget2 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation2=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget2);
				break;
				
				case 2:
				RepTarget3 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation3=TheTarget.location; //We need the location if it's a vehicle
				ServerAddTarget (OnTarget, RepTarget3);
				break;
			}
			OnTarget+=1; 
			}
		else
		return; //Target was already in the targeting array, so don't do anything. 

	 }
	 
	 ////////////////////Now, if it IS a building, we add it to the speshul place where only one may enter//////////////////////////
	 if(TargetIsValid(TheTarget) && TargetIsBuilding(TheTarget)) 
	 {
		 
		 //if(AT_Target_Building == Rx_Building(TheTarget)) return;
		 //if(Rx_BuildingAttachment(TheTarget))
		
		//Define if it is truly an attachment or a building or what.
		
		if(Rx_BuildingAttachment(TheTarget) != none) 
		{			
			TheTarget = Rx_BuildingAttachment(TheTarget).OwnerBuilding ; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		if(Rx_Building_Internals(TheTarget) != none) 
		{
			TheTarget = Rx_Building_Internals(TheTarget).BuildingVisuals; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		TempTarget = TheTarget;
		if(!IsTimerActive('ScanBuilding')) SetTimer (ScanTime, true, 'ScanBuilding') ; //may need to edit for attachments.	
		
		
		//Target is valid, but is it already one of our targets ?
		 
		
		

	 }




}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////VALIDATE TARGETS FOR THE ATTACK STATE////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

simulated  function bool TargetIsValid(Actor TActor) 
{
	
local Controller LPC ;

LPC=Rx_Controller(Instigator.Controller);

if (Rx_Building(TActor) != none ||
		(Rx_BuildingAttachment(TActor) != none && Rx_BuildingAttachment_Door(TActor) == none) ||
		Rx_Building_Internals(TActor) != none ||
		(Rx_Vehicle(TActor) != none && Rx_Vehicle(TActor).Health > 0) ||
		(Rx_Pawn(TActor) != none && Rx_Pawn(TActor).Health > 0) ||
		(Rx_Defence(TActor) != none && Rx_Defence(TActor).Health > 0)
		//(Rx_Weapon_DeployedActor(TActor) != none && Rx_Weapon_DeployedActor(TActor).GetHealth() > 0) ||
		//(Rx_CratePickup(TActor) != none && !Rx_CratePickup(TActor).bPickupHidden)
		//Copied the list from the TargetingBox. May add functionality to crates and Beacons, but for now I'm keeping it to infantry and vehicles. Buildings have a seperate set of variables only allowing one of them to be targeted at a time.
		){
		
		if(TActor.GetTeamNum() != LPC.GetTeamNum())
		
		{	
		if(Rx_Pawn_SBH(TActor) != none || Rx_Vehicle_StealthTank(TActor) != none) //The stealth clause 
			{
			if(TActor.GetStateName() == 'Stealthed' || TActor.GetStateName() == 'BeenShot') //May need to add more to this.
				return false; 
				//else return true;
			}
			
		return true; //If you're not a stealth unit, and you made it this far without returning, I know you're just bad. 
		}
		else return false; //You're on my team
		}
	else 
		return false; //You're not a valid target
}

simulated function bool TargetIsBuilding (Actor T) //TODO : Maybe add a clause in for small defense structures
{
	
	if (Rx_Building(T) != none ||
		(Rx_BuildingAttachment(T) != none && Rx_BuildingAttachment_Door(T) == none) ||
		Rx_Building_Internals(T) != none ) return true; 
		else
		return false;
	
	
}


simulated function AddTarget(Actor A, int Onum)
{
local Rx_Pawn RxA;
local Rx_Vehicle RxV;
if(Rx_Pawn(A) != none) //Get pawn's info and add it to the array, including its infantry class since it is a player pawn
	{
	RxA=Rx_Pawn(A);
	
	A_Target[OnTarget].AT_Pawn=RxA ; 	
	A_Target[OnTarget].AT_ClassType=RxA.GetCharacterClassName() ;
	A_Target[OnTarget].AT_Actor=A;
	}
	
if(Rx_Vehicle(A) != none) //Get info relative to vehicles
	{
		RxV=Rx_Vehicle(A);
	
	//A_Target[OnTarget].AT_Pawn=RxV ; 	
	A_Target[OnTarget].AT_ClassType=RxV.GetHumanReadableName(); 
	A_Target[OnTarget].AT_Actor=A;
	}


}

simulated function ScanBuilding () //Uses a class variable instead of a parameter since this uses a timer. 

{


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc < 100)
        {
        ScanPerc+=ScanPercIncrement ;
        }

if(Scanned_B != Rx_Building(TempTarget)) //We're looking at a different building... reset the scanning process
        {
        ScanPerc = 0;
        }


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc >= 100) //On the same building the entire time, and now at 100%; this is definitely being set as a target... or somebody has REALLY bad aim.
{

AT_Target_Building = Rx_Building(TempTarget); //Set the actual building target for this round of scanning.
ScanPerc = 100 ; //Keep this at 100 for drawing purposes.

}

Scanned_B=Rx_Building(TempTarget); //This is the building being scanned. If it changes, we'll know the next time this function is called.

}


simulated function StopFire(byte FireModeNum)
	{
local int Rnk, T_Number, g ;

if(IsInstigatorCommander() ){
Rnk=GetInstigatorCRank() ;
}
		if (FireModeNum != 0)
		{
			global.StopFire(FireModeNum);
			return;
		}

for(g=0;g < 3;g++) 
{
	if(A_Target[g].AT_Actor != none) T_Number++ ;
	
	
	if(Rx_Pawn(A_Target[g].AT_Actor) != none )  // IF the actor is an infantry, we use its player ID to find it correctly later. 
	{ 
	
	switch(g)  
		{
		case 0:
		RepID1 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID1);
		break;
		
		case 1:
		RepID2 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID2);
		break;
		
		case 2:
		RepID3 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID3);
		break;
		}
	}
	
	
	if(Rx_Vehicle(A_Target[g].AT_Actor) != none )  // IF the actor is a vehicle we need its location to find it later.
	{ 
	
	switch(g)  
		{
		case 0:
		RepLocation1 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation1);
		break;
		
		case 1:
		RepLocation2 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation2);
		break;
		
		case 2:
		RepLocation3 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation3);
		break;
		}
	}
}
		
ScanningForTargets=false;

if(AT_Target_Building != none) ServerSetTargets(T_Number, 0, Instigator.GetTeamNum(), Rnk, true, AT_Target_Building) ;
else 
{

if(T_Number > 0) ServerSetTargets(T_Number, 0, Instigator.GetTeamNum(), Rnk, false) ;

}
OnTarget=0;
GotoState('Active') ;

	}



//Be sure to lock scrolling of the objective with the mousewheel while scanning.//

simulated event EndState (Name NextStateName)
{
//Confirmed, scanning for targets so long as we're in this state.
if(ScanningForTargets) ScanningForTargets=false;
ClearTimer('ScanTargets') ;
ClearTimer('ScanBuilding') ;
//AT_Target_Building = none;
//Timer for ScanTargets()

}

}


//////////////////////////////////////////////////////////
///////////////END OF ATTACK STATE////////////////////////
//////////////////////////////////////////////////////////


/*******************************************************************************************/
/****************************** DEFEND STATE ***********************************************/
/*********	The STATE we use for all of our DEFEND objective Scanning **********************/
/*******************************************************************************************/
/*******************************************************************************************/

simulated state StDefendScan
{

simulated event BeginState (Name PreviousState)
{
CanSetWaypoint=true;
//Confirmed, scanning for targets so long as we're in this state.
if(!ScanningForTargets) ScanningForTargets=true;
AT_Target_Building = none;
//Timer for ScanTargets()
SetTimer(0.10,true,'ScanTargets') ;
}



simulated function ScanTargets() //Variant of Update_Range
{

local vector startL, normthing, endL	;
	local rotator ADir					;
	local Actor TheTarget				;
	local int i							;
	local bool InArray					;
	// get aiming direction from our instigator (Assume this is the pawn from what I've read.)
	 ADir = Instigator.GetBaseAimRotation();
	
	TempTarget=none; //Reset TempTarget for this cycle so that ScanBuilding() doesn't continue to increase the scan percentage when targeting nothing.
	
	startL=InstantFireStartTrace(); //Using function out of Rx_weapon to find the end of our weapon, or just our own location
	
	//.......... Yosh need learn math. Working in 3D space is making me twitchy X.x
	
	TheTarget=Trace(endL, normthing, startL + vector(Adir) * MaxDistance, startL, true) ;
	
	 if(TargetIsValid(TheTarget) && !TargetIsBuilding(TheTarget)) 
	 {
		 if(OnTarget > 2) OnTarget = 0;
		 
		 //Target is valid, but is it already one of our targets ?
		 for(i=0; i<3;i++)
		 {
			 if(A_Target[i].AT_Actor==TheTarget) 
			 {
			InArray = true ; 
			 break;
			 }
		 }
	
		//Now we know if the target is in our targeting array or not... so if it isn't, add it. If it is, ignore the bastard and push the target # we're setting up a notch
		
		if(!InArray)
			{
			AddTarget(TheTarget, OnTarget);
			
			switch(OnTarget)
			{
			case 0:
				RepTarget1 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation1=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget1);
				break;
				
				case 1:
				RepTarget2 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation2=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget2);
				break;
				
				case 2:
				RepTarget3 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation3=TheTarget.location; //We need the location if it's a vehicle
				ServerAddTarget (OnTarget, RepTarget3);
				break;
			}
			CanSetWaypoint=false; //We're no longer setting a waypoint
			OnTarget+=1; 
			}
		else
		return; //Target was already in the targeting array, so don't do anything. 

	 }
	 
	 ////////////////////Now, if it IS a building, we add it to the speshul place where only one may enter//////////////////////////
	 if(TargetIsValid(TheTarget) && TargetIsBuilding(TheTarget)) 
	 {
		 
		 //if(AT_Target_Building == Rx_Building(TheTarget)) return;
		 //if(Rx_BuildingAttachment(TheTarget))
		
		//Define if it is truly an attachment or a building or what.
		
		if(Rx_BuildingAttachment(TheTarget) != none) 
		{			
			TheTarget = Rx_BuildingAttachment(TheTarget).OwnerBuilding ; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		if(Rx_Building_Internals(TheTarget) != none) 
		{
			TheTarget = Rx_Building_Internals(TheTarget).BuildingVisuals; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		TempTarget = TheTarget;
		if(!IsTimerActive('ScanBuilding')) SetTimer (ScanTime, true, 'ScanBuilding') ; //may need to edit for attachments.	
		
		
	
		
		

	 }

	//We hit nothing, so just use a vector waypoint so long as we didn't just hit air
	if(!TargetIsValid(TheTarget) && Target_Distance != 0 && CanSetWaypoint) 
	{
	WAYPOINT=endL ;
	ServerUpdateWPCoord(endL);
	}
	//However, once we HAVE a target, disable the Waypoint updating, as we're obviously setting targets.
	if(!CanSetWaypoint) 
	{
		Waypoint.X=0; //Remove the waypoint if we can no longer set it.
		Waypoint.Y=0;
		Waypoint.Z=0;
	}


}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////VALIDATE TARGETS FOR THE DEFEND STATE////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

simulated  function bool TargetIsValid(Actor TActor) 
{
	
local Controller LPC ;

LPC=Rx_Controller(Instigator.Controller);

if (Rx_Building(TActor) != none ||
		(Rx_BuildingAttachment(TActor) != none && Rx_BuildingAttachment_Door(TActor) == none) ||
		Rx_Building_Internals(TActor) != none ||
		(Rx_Vehicle(TActor) != none && Rx_Vehicle(TActor).Health > 0) ||
		(Rx_Pawn(TActor) != none && Rx_Pawn(TActor).Health > 0)
		//(Rx_Weapon_DeployedActor(TActor) != none && Rx_Weapon_DeployedActor(TActor).GetHealth() > 0) ||
		//(Rx_CratePickup(TActor) != none && !Rx_CratePickup(TActor).bPickupHidden)
		//Copied the list from the TargetingBox. May add functionality to crates and Beacons, but for now I'm keeping it to infantry and vehicles. Buildings have a seperate set of variables only allowing one of them to be targeted at a time.
		){
		
		if(TActor.GetTeamNum() == LPC.GetTeamNum())
		
		{	
		return true; //On our team and they're a valid target, so good to go 
		}
		else return false; //You're a bad person... depending on what view you take
		}
	else 
		return false; //You're not a valid target
}

simulated function bool TargetIsBuilding (Actor T) //TODO : Maybe add a clause in for small defence structures
{
	
	if (Rx_Building(T) != none ||
		(Rx_BuildingAttachment(T) != none && Rx_BuildingAttachment_Door(T) == none) ||
		Rx_Building_Internals(T) != none ) return true; 
		else
		return false;
	
	
}


simulated function AddTarget(Actor A, int Onum)
{
local Rx_Pawn RxA;
local Rx_Vehicle RxV;
if(Rx_Pawn(A) != none) //Get pawn's info and add it to the array, including its infantry class since it is a player pawn
	{
	RxA=Rx_Pawn(A);
	
	A_Target[OnTarget].AT_Pawn=RxA ; 	
	A_Target[OnTarget].AT_ClassType=RxA.GetCharacterClassName() ;
	A_Target[OnTarget].AT_Actor=A;
	//Maybe add health for defence. Will be drawn anyway once they're actually targeted... maybe
	}
	
if(Rx_Vehicle(A) != none) //Get info relative to vehicles
	{
		RxV=Rx_Vehicle(A);
	
	//A_Target[OnTarget].AT_Pawn=RxV ; 	
	A_Target[OnTarget].AT_ClassType=RxV.GetHumanReadableName(); 
	A_Target[OnTarget].AT_Actor=A;
	//Maybe add health for defence. Will be drawn anyway once they're actually targeted
	}


}

simulated function ScanBuilding () //Uses a class variable instead of a parameter since this uses a timer. 

{


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc < 100)
        {
        ScanPerc+=ScanPercIncrement ;
        }

if(Scanned_B != Rx_Building(TempTarget)) //We're looking at a different building... reset the scanning process
        {
        ScanPerc = 0;
        }


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc >= 100) //On the same building the entire time, and now at 100%; this is definitely being set as a target... or somebody has REALLY bad aim.
{

AT_Target_Building = Rx_Building(TempTarget); //Set the actual building target for this round of scanning.
ScanPerc = 100 ; //Keep this at 100 for drawing purposes.

}

Scanned_B=Rx_Building(TempTarget); //This is the building being scanned. If it changes, we'll know the next time this function is called.

}


simulated function StopFire(byte FireModeNum)
	{
local int Rnk, T_Number, g ;

if(IsInstigatorCommander() ){
Rnk=GetInstigatorCRank() ;
}
		if (FireModeNum != 0)
		{
			global.StopFire(FireModeNum);
			return;
		}

for(g=0;g < 3;g++) 
{
	if(A_Target[g].AT_Actor != none) T_Number++ ;
	
	
	
	if(Rx_Pawn(A_Target[g].AT_Actor) != none )  // IF the actor is an infantry, we use its player ID to find it correctly later. 
	{ 
	
	switch(g)  
		{
		case 0:
		RepID1 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID1);
		break;
		
		case 1:
		RepID2 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID2);
		break;
		
		case 2:
		RepID3 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID3);
		break;
		}
	}
	
	
	if(Rx_Vehicle(A_Target[g].AT_Actor) != none )  // IF the actor is a vehicle we need its location to find it later.
	{ 
	
	switch(g)  
		{
		case 0:
		RepLocation1 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation1);
		break;
		
		case 1:
		RepLocation2 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation2);
		break;
		
		case 2:
		RepLocation3 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation3);
		break;
		}
	}
}
		
ScanningForTargets=false;

if(AT_Target_Building != none) ServerSetTargets(T_Number, 1, Instigator.GetTeamNum(), Rnk, true, AT_Target_Building) ;
else 
if(T_Number > 0) ServerSetTargets(T_Number, 1, Instigator.GetTeamNum(), Rnk, false) ;
else
if(WAYPOINT.X !=0 && WAYPOINT.Y !=0 && CanSetWaypoint) ServerSetWaypoint(WAYPOINT, 1, Instigator.GetTeamNum(), Rnk, true) ; //DEFENSE and TAKEPOINT can set waypoints


OnTarget=0;
GotoState('Active') ;

	}



//Be sure to lock scrolling of the objective with the mousewheel while scanning.//

simulated event EndState (Name NextStateName)
{
//Confirmed, scanning for targets so long as we're in this state.
if(ScanningForTargets) ScanningForTargets=false;
ClearTimer('ScanTargets') ;
ClearTimer('ScanBuilding') ;
//AT_Target_Building = none;
//Timer for ScanTargets()

}

}


//////////////////////////////////////////////////////////
///////////////END OF DEFEND STATE////////////////////////
//////////////////////////////////////////////////////////

/*******************************************************************************************/
/****************************** REPAIR STATE ***********************************************/
/*********	The STATE we use for all of our REPAIR objective Scanning **********************/
/*******************************************************************************************/
/*******************************************************************************************/

simulated state StRepairScan
{

simulated event BeginState (Name PreviousState)
{
//Confirmed, scanning for targets so long as we're in this state.
if(!ScanningForTargets) ScanningForTargets=true;
AT_Target_Building = none;
//Timer for ScanTargets()
SetTimer(0.10,true,'ScanTargets') ;
}



simulated function ScanTargets() //Variant of Update_Range
{

local vector startL, normthing, endL	;
	local rotator ADir					;
	local Actor TheTarget				;
	local int i							;
	local bool InArray					;
	// get aiming direction from our instigator (Assume this is the pawn from what I've read.)
	 ADir = Instigator.GetBaseAimRotation();
	
	TempTarget=none; //Reset TempTarget for this cycle so that ScanBuilding() doesn't continue to increase the scan percentage when targeting nothing.
	
	startL=InstantFireStartTrace(); //Using function out of Rx_weapon to find the end of our weapon, or just our own location
	
	//.......... Yosh need learn math. Working in 3D space is making me twitchy X.x
	
	TheTarget=Trace(endL, normthing, startL + vector(Adir) * MaxDistance, startL, true) ;
	
	 if(TargetIsValid(TheTarget) && !TargetIsBuilding(TheTarget)) 
	 {
		 if(OnTarget > 2) OnTarget = 0;
		 
		 //Target is valid, but is it already one of our targets ?
		 for(i=0; i<3;i++)
		 {
			 if(A_Target[i].AT_Actor==TheTarget) 
			 {
			InArray = true ; 
			 break;
			 }
		 }
	
		//Now we know if the target is in our targeting array or not... so if it isn't, add it. If it is, ignore the bastard and push the target # we're setting up a notch
		
		if(!InArray)
			{
			AddTarget(TheTarget, OnTarget);
			switch(OnTarget)
			{
			case 0:
				RepTarget1 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation1=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget1);
				break;
				
				case 1:
				RepTarget2 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation2=TheTarget.location;
				ServerAddTarget (OnTarget, RepTarget2);
				break;
				
				case 2:
				RepTarget3 = string(TheTarget.name);
				//if(Rx_Vehicle(TheTarget) != none) RepLocation3=TheTarget.location; //We need the location if it's a vehicle
				ServerAddTarget (OnTarget, RepTarget3);
				break;
			}
			OnTarget+=1; 
			}
		else
		return; //Target was already in the targeting array, so don't do anything. 

	 }
	 
	 ////////////////////Now, if it IS a building, we add it to the speshul place where only one may enter//////////////////////////
	 if(TargetIsValid(TheTarget) && TargetIsBuilding(TheTarget)) 
	 {
		 
		 //if(AT_Target_Building == Rx_Building(TheTarget)) return;
		 //if(Rx_BuildingAttachment(TheTarget))
		
		//Define if it is truly an attachment or a building or what.
		
		if(Rx_BuildingAttachment(TheTarget) != none) 
		{			
			TheTarget = Rx_BuildingAttachment(TheTarget).OwnerBuilding ; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		if(Rx_Building_Internals(TheTarget) != none) 
		{
			TheTarget = Rx_Building_Internals(TheTarget).BuildingVisuals; //Set the target to an actual building for our sake
			if(Rx_Building(TheTarget) == AT_Target_Building) return;
		}
		
		TempTarget = TheTarget;
		if(!IsTimerActive('ScanBuilding')) SetTimer (ScanTime, true, 'ScanBuilding') ; //may need to edit for attachments.	
		
		
	
		
		

	 }

	
		
	



}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////VALIDATE TARGETS FOR THE REPAIR STATE////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

simulated  function bool TargetIsValid(Actor TActor) 
{
	
local Controller LPC ;

LPC=Rx_Controller(Instigator.Controller);

if (Rx_Building(TActor) != none ||
		(Rx_BuildingAttachment(TActor) != none && Rx_BuildingAttachment_Door(TActor) == none) ||
		Rx_Building_Internals(TActor) != none ||
		(Rx_Vehicle(TActor) != none && Rx_Vehicle(TActor).Health > 0 && Rx_Vehicle(TActor).Health < Rx_Vehicle(TActor).HealthMax) ||
		(Rx_Pawn(TActor) != none && Rx_Pawn(TActor).Health > 0 && Rx_Pawn(TActor).Health < Rx_Pawn(TActor).HealthMax)
		//(Rx_Weapon_DeployedActor(TActor) != none && Rx_Weapon_DeployedActor(TActor).GetHealth() > 0) ||
		//(Rx_CratePickup(TActor) != none && !Rx_CratePickup(TActor).bPickupHidden)
		//Copied the list from the TargetingBox. May add functionality to crates and Beacons, but for now I'm keeping it to infantry and vehicles. Buildings have a separate set of variables only allowing one of them to be targeted at a time.
		){
		
		if(TActor.GetTeamNum() == LPC.GetTeamNum())
		
		{	
		return true; //On our team and they're a valid target, so good to go 
		}
		else return false; //You're a bad person... depending on what view you take
		}
	else 
		return false; //You're not a valid target
}

simulated function bool TargetIsBuilding (Actor T) //TODO : Maybe add a clause in for small defence structures
{
	
	if (Rx_Building(T) != none ||
		(Rx_BuildingAttachment(T) != none && Rx_BuildingAttachment_Door(T) == none) ||
		Rx_Building_Internals(T) != none ) return true; 
		else
		return false;
	
	
}


simulated function AddTarget(Actor A, int Onum)
{
local Rx_Pawn RxA;
local Rx_Vehicle RxV;
if(Rx_Pawn(A) != none) //Get pawn's info and add it to the array, including its infantry class since it is a player pawn
	{
	RxA=Rx_Pawn(A);
	
	A_Target[OnTarget].AT_Pawn=RxA ; 	
	A_Target[OnTarget].AT_ClassType=RxA.GetCharacterClassName() ;
	A_Target[OnTarget].AT_Actor=A;
	//Maybe add health for defence. Will be drawn anyway once they're actually targeted
	}
	
if(Rx_Vehicle(A) != none) //Get info relative to vehicles
	{
		RxV=Rx_Vehicle(A);
	
	//A_Target[OnTarget].AT_Pawn=RxV ; 	
	A_Target[OnTarget].AT_ClassType=RxV.GetHumanReadableName(); 
	A_Target[OnTarget].AT_Actor=A;
	//Maybe add health for defence. Will be drawn anyway once they're actually targeted
	}


}

simulated function ScanBuilding () //Uses a class variable instead of a parameter since this uses a timer. 

{


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc < 100 && Rx_Building(TempTarget).GetHealth() < Rx_Building(TempTarget).GetMaxHealth())
        {
        ScanPerc+=ScanPercIncrement ;
        }

if(Scanned_B != Rx_Building(TempTarget)) //We're looking at a different building... reset the scanning process
        {
        ScanPerc = 0;
        }


if(Scanned_B == Rx_Building(TempTarget) && ScanPerc >= 100) //On the same building the entire time, and now at 100%; this is definitely being set as a target... or somebody has REALLY bad aim.
{

AT_Target_Building = Rx_Building(TempTarget); //Set the actual building target for this round of scanning.
ScanPerc = 100 ; //Keep this at 100 for drawing purposes.

}

Scanned_B=Rx_Building(TempTarget); //This is the building being scanned. If it changes, we'll know the next time this function is called.

}


simulated function StopFire(byte FireModeNum)
	{
local int Rnk, T_Number, g ;

if(IsInstigatorCommander() ){
Rnk=GetInstigatorCRank() ;
}
		if (FireModeNum != 0)
		{
			global.StopFire(FireModeNum);
			return;
		}

for(g=0;g < 3;g++)
{
	if(A_Target[g].AT_Actor != none) T_Number++ ; //Get how many targets are actually set


	if(Rx_Pawn(A_Target[g].AT_Actor) != none )  // IF the actor is an infantry, we use its player ID to find it correctly later. 
	{ 
	
	switch(g)  
		{
		case 0:
		RepID1 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID1);
		break;
		
		case 1:
		RepID2 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID2);
		break;
		
		case 2:
		RepID3 = Rx_Pawn(A_Target[g].AT_Actor).PlayerReplicationInfo.PlayerID; 
		ServerUpdatePID(g , RepID3);
		break;
		}
	}
	
	
	if(Rx_Vehicle(A_Target[g].AT_Actor) != none )  // IF the actor is a vehicle we need its location to find it later.
	{ 
	
	switch(g)  
		{
		case 0:
		RepLocation1 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation1);
		break;
		
		case 1:
		RepLocation2 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation2);
		break;
		
		case 2:
		RepLocation3 = A_Target[g].AT_Actor.location; 
		ServerUpdateVLoc(g , RepLocation3);
		break;
		}
	}
}
		
ScanningForTargets=false;

if(AT_Target_Building != none) ServerSetTargets(T_Number, 2, Instigator.GetTeamNum(), Rnk, true, AT_Target_Building) ;
else 
if(T_Number > 0) ServerSetTargets(T_Number, 2, Instigator.GetTeamNum(), Rnk, false) ;



OnTarget=0;
GotoState('Active') ;

	}



//Be sure to lock scrolling of the objective with the mousewheel while scanning.//

simulated event EndState (Name NextStateName)
{
//Confirmed, scanning for targets so long as we're in this state.
if(ScanningForTargets) ScanningForTargets=false;
ClearTimer('ScanTargets') ;
ClearTimer('ScanBuilding') ;
//AT_Target_Building = none;
//Timer for ScanTargets()

}

}


//////////////////////////////////////////////////////////
///////////////END OF REPAIR STATE////////////////////////
//////////////////////////////////////////////////////////


/*******************************************************************************************/
/****************************** TAKEPOINT STATE ***********************************************/
/*********	The STATE we use for all of our TAKEPOINT objective Scanning **********************/
/*******************************************************************************************/
/*******************************************************************************************/

simulated state StTakePointScan
{

simulated event BeginState (Name PreviousState)
{
//Confirmed, scanning for targets so long as we're in this state.
if(!ScanningForTargets) ScanningForTargets=true;
AT_Target_Building = none;
//Timer for ScanTargets()
SetTimer(0.10,true,'ScanTargets') ;
}



simulated function ScanTargets() //Variant of Update_Range
	{

	local vector startL, normthing, endL;
	local rotator ADir					;
	local Actor TheTarget				;
	// get aiming direction from our instigator (Assume this is the pawn from what I've read.)
	 ADir = Instigator.GetBaseAimRotation();
	
	TempTarget=none; //Reset TempTarget for this cycle so that ScanBuilding() doesn't continue to increase the scan percentage when targeting nothing.
	
	startL=InstantFireStartTrace(); //Using function out of Rx_weapon to find the end of our weapon, or just our own location
	
	//.......... Yosh need learn math. Working in 3D space is making me twitchy X.x
	
	TheTarget=Trace(endL, normthing, startL + vector(Adir) * MaxDistance, startL, true) ;
	
	 	
		TempTarget = TheTarget; //This is mostly meaningless here

		//Just use a vector waypoint so long as we didn't just hit air
	if(Target_Distance != 0) WAYPOINT=endL ;
	
	ServerUpdateWPCoord(endL);
	
	/////////////Modified ScanBuilding///////////////////
		if(Scanned_V == WAYPOINT && ScanPerc < 100)
        {
        ScanPerc+=ScanPercIncrement*4 ;
        }

	if(Scanned_V != WAYPOINT) //We're looking at a different point... reset the scanning process
        {
        ScanPerc = 0;
        }


if(Scanned_V == WAYPOINT && ScanPerc >= 100) //On the same point the entire time, set it as the objective point
{

AT_Target_WayPoint = Scanned_V; //Set the actual Vector target for this round of scanning.
ScanPerc = 100 ; //Keep this at 100 for drawing purposes.

}

Scanned_V=WAYPOINT; //This is the point being scanned. If it changes, we'll know the next time this function is called.
		

	}














///////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////NO TARGETS NEED VALIDATION IN TAKEPOINT STATE////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////





simulated function StopFire(byte FireModeNum)
	{
local int Rnk ;

if(IsInstigatorCommander() ){
Rnk=GetInstigatorCRank() ;
}
		if (FireModeNum != 0)
		{
			global.StopFire(FireModeNum);
			return;
		}
		
ScanningForTargets=false;

if(WAYPOINT.X !=0 && WAYPOINT.Y !=0 && WAYPOINT.Z !=0 && AT_Target_WayPoint.X == 0 && AT_Target_WayPoint.Y==0 && AT_Target_WayPoint.Z==0) ServerSetWaypoint(WAYPOINT, 3, Instigator.GetTeamNum(), Rnk, false) ; //DEFENSE and TAKEPOINT can set waypoints
else
if(WAYPOINT.X !=0 && WAYPOINT.Y !=0 && WAYPOINT.Z !=0 && (AT_Target_WayPoint.X != 0 || AT_Target_WayPoint.Y != 0 || AT_Target_WayPoint.Z !=0)) ServerSetWaypoint(WAYPOINT, 3, Instigator.GetTeamNum(), Rnk, true) ; //DEFENSE and TAKEPOINT can set waypoints


OnTarget=0; //Shouldn't have changed in TakePoint state, but just in case

GotoState('Active') ;

	}



//Be sure to lock scrolling of the objective with the mousewheel while scanning.//

simulated event EndState (Name NextStateName)
{
//Confirmed, scanning for targets so long as we're in this state.
if(ScanningForTargets) ScanningForTargets=false;
if(IsTimerActive('ScanTargets')) ClearTimer('ScanTargets') ;
if(IsTimerActive('ScanBuilding')) ClearTimer('ScanBuilding') ;
AT_Target_WayPoint.X=0;
AT_Target_WayPoint.Y=0;
AT_Target_WayPoint.Z=0;
//AT_Target_Building = none;
//Timer for ScanTargets()

}

}


//////////////////////////////////////////////////////////
///////////////END OF TakePoint STATE////////////////////////
//////////////////////////////////////////////////////////






/*****************************************************
* SERVER FUNCTIONS TO PUSH OUT TARGETS/WAYPOINTS 
******************************************************/

reliable server function ServerAddTarget (int Notirank, string Trg)
{
	
	switch(Notirank) 
	{
		case 0: 
		RepTarget1 = Trg;
		//RepLocation1=L;
		LogInternal("Server updated Target Rep1 with "$ Trg @ RepLocation1.X @ RepLocation1.Y @ RepLocation1.Z);
		break;
		
		case 1:
		RepTarget2 = Trg;
		//RepLocation2=L;
		LogInternal("Server updated Target Rep2 with "$ Trg @ RepLocation2);
		break;
		
		case 2: 
		RepTarget3 = Trg;
		//RepLocation3=L;
		LogInternal("Server updated Target Rep3 with "$ Trg @ RepLocation3);
		break;
		
		
	}
	LogInternal("Server logged Targets");
}


reliable server function ServerUpdateVLoc (int Notirank, Vector L)
{
	
	switch(Notirank) 
	{
		case 0: 
		RepLocation1=L;
		LogInternal("Server updated Target RepL1 with "@ RepLocation1.X @ RepLocation1.Y @ RepLocation1.Z);
		break;
		
		case 1:
		RepLocation2=L;
		LogInternal("Server updated Target RepL2 with " @ RepLocation2.X);
		break;
		
		case 2: 
		RepLocation3=L;
		LogInternal("Server updated Target RepL3 with "$RepLocation3.X);
		break;
		
		
	}
	LogInternal("Server logged Targets");
}

reliable server function ServerUpdatePID (int Notirank, int ID)
{
	
	switch(Notirank) 
	{
		case 0: 
		RepID1=ID;
		LogInternal("Server updated Target Rep1ID with "$ RepID1);
		break;
		
		case 1:
		RepID2=ID;
		LogInternal("Server updated Target Rep2ID with "$ RepID2);
		break;
		
		case 2: 
		RepID3=ID;
		LogInternal("Server updated Target Rep3ID with "$ RepID3);
		break;
		
		
	}
	
}


reliable server function ServerSetTargets(int TargetNum, int CT, int TeamI, int rank, bool isUpdate, optional Actor A)
{
local int i ;



//Send this target to the Commander Controller to have its information dispersed
for(i=0; i <= TargetNum-1;i++)
{

switch (i)
		{
			case 0 :
			myCC.Update_Obj(TeamI, rank, CT, false,false ,A_Target[i].AT_Actor,,,RepTarget1,RepLocation1,RepID1); 
			LogInternal("NOCS CC IS00000000000000000000000 "$myCC@"ACtor name is:"@RepTarget1 @RepLocation1.X@RepLocation1.Y@"ID if Pawn: "@ RepID1);
			break;
			case 1:
			myCC.Update_Obj(TeamI, rank, CT, false,false ,A_Target[i].AT_Actor,,,RepTarget2,RepLocation2, RepID2); 
			LogInternal("NOCS CC IS00000000000000000000000 "$myCC@"ACtor name is:"@RepTarget2 @RepLocation2.X@RepLocation2.Y @ RepID2);
			break;
			case 2:
				myCC.Update_Obj(TeamI, rank, CT, false,false ,A_Target[i].AT_Actor,,,RepTarget3,RepLocation3, RepID3); 
				LogInternal("NOCS CC IS00000000000000000000000 "$myCC@"ACtor name is:"@RepTarget3 @RepLocation3.X@RepLocation3.Y @ RepID3);
			break;
		}

// (Commander's Team, Commander's rank, Type of call this is (attack/defend etc), isWaypointUpdate, is Objective update, Vechile/Pawn Actor this is directed at, Building Actor if this is a building objective update)


}
//Fuck this target; clear it.
TimedClearofTargets();


if(isUpdate) myCC.Update_Obj(TeamI, rank, CT,false, true,,A); //Call a building update  (Skipping attack target actors)if this is an actual update. CommanderController knows how to handle the calls distinctly
	
}

/**simulated function ClientTagTargets(int TargetNum)
{
	
	for(i=0; i <= TargetNum-1;i++)
	{
		switch (i)
		{
			case 0 :
			RepTarget1 = string(A_Target[i].AT_Actor.name) ;
			break;
			case 1:
			RepTarget2 =string(A_Target[i].AT_Actor.name)
			break;
			case 2:
			RepTarget3 =string(A_Target[i].AT_Actor.name)
			break;
		}
		
		
	}
	
}
*/

unreliable client function TimedClearofTargets()
{
if(!IsTimerActive('WipeTargets')) SetTimer(2.0f, false, 'WipeTargets');	

	
}

reliable server function ServerWipeTargets()
{
	RepTarget1="" ;
	RepTarget2="" ;
	RepTarget3="" ;
	
	RepLocation1.X=0 ;
	RepLocation1.Y=0 ;
	RepLocation1.Z=0 ;
	
	RepLocation2.X=0 ;
	RepLocation2.Y=0 ;
	RepLocation2.Z=0 ;
	
	RepLocation3.X=0 ;
	RepLocation3.Y=0 ;
	RepLocation3.Z=0 ;
	
	RepID1=0;
	RepID2=0;
	RepID3=0;
}




simulated function WipeTargets()
{
	local int Num;
	for(Num=0;Num<3;Num++)
	{
A_Target[Num].AT_Actor = none	;
A_Target[Num].AT_Class = none;
A_Target[Num].AT_Pawn = none;
A_Target[Num].AT_ClassType= "";
	}
	RepTarget1="" ;
	RepTarget2="" ;
	RepTarget3="" ;
	
	RepLocation1.X=0 ;
	RepLocation1.Y=0 ;
	RepLocation1.Z=0 ;
	
	RepLocation2.X=0 ;
	RepLocation2.Y=0 ;
	RepLocation2.Z=0 ;
	
	RepLocation3.X=0 ;
	RepLocation3.Y=0 ;
	RepLocation3.Z=0 ;
	
	RepID1=0;
	RepID2=0;
	RepID3=0;
	
	ServerWipeTargets();
}

reliable server function ServerSetWaypoint(Vector WP, int CT, int TeamI, int rank,bool isUpdate)
{
	LogInternal("Nocs CC is 11111111111111111111111111111111111111111111"$myCC);
myCC.Update_Obj(TeamI, rank, CT, true, isUpdate,,,WP); //Updates the waypoint for the commander controller (Defence or TakePoint) 	

WAYPOINT.X = 0 ; //Reset the waypoint
WAYPOINT.Y = 0 ; //Reset the waypoint
WAYPOINT.Z = 0 ; //Reset the waypoint
}

unreliable server function ServerUpdateWPCoord(Vector WPC)
{
WAYPOINT.X = WPC.X;
WAYPOINT.Y = WPC.Y;
WAYPOINT.Z = WPC.Z;	
	
}

exec reliable client function ClearTargets()
{
	local int CRank, TeamI;
		local Rx_Controller LPC;
		LogInternal("Clear Targets Function Ran");
		LogInternal("Is Commander: " @ IsInstigatorCommander());
		LogInternal("Weapon Zoomed: "@ GetZoomedState()); 
if(IsInstigatorCommander() && GetZoomedState() == ZST_Zoomed) 
	{
		LogInternal("LOG: Clear Target function knows it is zoomed and instigator is commander");
	
		LPC=Rx_Controller(Instigator.Controller);
			
			TeamI=LPC.GetTeamNum();
			
			CRank = GetInstigatorCRank();
			
			ServerClearTargets(Objective_To_Set, CRank, TeamI);
				LogInternal("LOG: "@CRank @ Objective_To_Set @ TeamI);
	}
	
	
}

unreliable server function ServerClearTargets(int OType, int ComRank,int ITeam)
{
	LogInternal("LogL "@Otype @ ComRank @ ITeam);				
	myCC.SendTargetsClear(OType, ComRank, ITeam);
	
	
}


simulated function StartZoom(UTPlayerController PC)
{
	super.StartZoom(PC) ;
	
	//Original command is GBA_Use
	//Rememeber what "E" should be

OriginalClearTargetKeyCommand=Rx_Controller(Instigator.Controller).PlayerInput.GetBind(ClearTargetKey);	
	
	Rx_Controller(Instigator.Controller).PlayerInput.SetBind(ClearTargetKey, "GBA_Use | ClearTargets") ;
	
	if (WorldInfo.NetMode == NM_DedicatedServer ||
		(WorldInfo.NetMode == NM_ListenServer && !bNetOwner))
		return;
		
	SetTimer(0.25, true, 'UpdateRange') ;
	
}

simulated function EndZoom(UTPlayerController PC)
{
		super.EndZoom(PC) ;
		
	if (WorldInfo.NetMode == NM_DedicatedServer ||
		(WorldInfo.NetMode == NM_ListenServer && !bNetOwner))
		return;
		
		Rx_Controller(Instigator.Controller).PlayerInput.SetBind(ClearTargetKey, "GBA_Use") ;
		//Rx_Controller(Instigator.Controller).PlayerInput.SetBind(ClearTargetKey, OriginalClearTargetKeyCommand) ;
		
		
		Objective_To_Set=0;
		
	ClearTimer('UpdateRange') ;
}


simulated function UpdateRange()
{
	
	local vector startL, normthing, endL;
	local rotator ADir					;
	local Actor Actor_Discard			;
	// get aiming direction from our instigator (Assume this is the pawn from what I've read.)
	 ADir = Instigator.GetBaseAimRotation();
	
	startL=InstantFireStartTrace(); //Using function out of Rx_weapon to find the end of our weapon, or just our own location
	
	//.......... Yosh need learn math. Working in 3D space is making me twitchy X.x
	
	Actor_Discard=Trace(endL, normthing, startL + vector(Adir) * MaxDistance, startL, true) ;
	
	if(Actor_Discard == none) 
	{
	Target_Distance = 0 ; 	
	return;	
	}
	
	Target_Distance = round(VSize(endL-startL)/52.5) ; 
	
	NULL_Target = Actor_Discard;	
	
}


////////////////////////////////Update the info of the objective to set//////////////////////

simulated function UpdateOInfo() 
{
	
	switch(Objective_To_Set)
	
	{
		case(0):
		Objective_Color = C_Attack	; //Red/blue
		
		PrevObjectiveString ="Take Point";
		ObjectiveString = "Attack"	;
		NextObjectiveString = "Defend";
		Ostate = 'StAttackScan'   	;	
		break;
		
		case(1):
		Objective_Color = C_Defend	; // Green/blue
		PrevObjectiveString ="Attack";
		ObjectiveString = "Defend"	;
		NextObjectiveString = "Repair";
		Ostate = 'StDefendScan'		;
		break;
		
		case(2):
		Objective_Color = C_Repair	; // Orange
		PrevObjectiveString ="Defend";
		ObjectiveString = "Repair" 	;
		NextObjectiveString = "Take Point";
		Ostate='StRepairScan'		;
		break;
		
		case(3):
		Objective_Color = C_TakePoint 	;//White
		PrevObjectiveString ="Repair";
		ObjectiveString = "Take Point"  ;
		NextObjectiveString = "Attack";
		Ostate='StPointScan'			;
		break;
		
	}
	return;
}

////////////////////////////////////////////////////////////////////////////////
//////////////////CUSTOMIZE OUR OVERLAY WITH POINTLESS SHIT/////////////////////
////////////////////////////////////////////////////////////////////////////////
simulated function DrawZoomedOverlay( HUD H )
{
    local float ScaleX, ScaleY, StartX, TextL, TextH, TextL2,Obj_Scale	;								;
	local vector At_HUD_Target[3], AT_HUD_WAYPOINT;
	local int i;
	
    bDisplayCrosshair = false			;

    ScaleY = H.Canvas.SizeY/768.0		;
    ScaleX = ScaleY						;
    StartX = (H.Canvas.SizeX - (1024 * ScaleX)) / 2;
	
	Obj_Scale = 1.0 ; //Scale for the objective texts
	
	//Draw a translucent rectangle beneath the HUD Overlay to simulate lense color.
	H.Canvas.SetPos(0,0)									;
		
	H.Canvas.DrawColor=LensColor							;
	H.Canvas.DrawRect(H.Canvas.SizeX,H.Canvas.SizeY)		;
    
	//Draw targets on targets
	H.Canvas.SetDrawColor(255,255,255,255);
	
	for (i=0; i<3; i++ )
	{
		if(A_Target[i].AT_Actor != none) {
			At_HUD_Target[i]=H.Canvas.Project(A_Target[i].AT_Actor.location) ;
			H.Canvas.SetPos(At_HUD_Target[i].x, At_HUD_Target[i].y);
			H.Canvas.DrawIcon(TempAttackIcon,At_HUD_Target[i].X-32,At_HUD_Target[i].Y-32); //Icon is 64x64; needs to be drawn at half of that to hit sit dead center of the target.
		}		
	
		if(WAYPOINT.X !=0 && WAYPOINT.Y !=0 && WAYPOINT.Z != 0 && CanSetWaypoint)
		{
		AT_HUD_WAYPOINT=H.Canvas.Project(WAYPOINT) ;	
		H.Canvas.SetPos(AT_HUD_WAYPOINT.x, AT_HUD_WAYPOINT.y);
		H.Canvas.DrawIcon(TempAttackIcon,AT_HUD_WAYPOINT.X-32,AT_HUD_WAYPOINT.Y-32);
		}
	}
	
	// Draw sidebars
    H.Canvas.SetDrawColor(0,0,0)				;
    H.Canvas.SetPos(0,0)						;
    H.Canvas.DrawRect(StartX, H.Canvas.sizeY)	;
    H.Canvas.SetPos(H.Canvas.SizeX - StartX,0)	;
    H.Canvas.DrawRect(StartX, H.Canvas.sizeY)	;
	
	//Draws the distance to the target in pseudo meters in the middle top of the binoculars. Why? 'Cuz Yosh feels like having unnecessary shit drawn on his binoculars
	
	H.Canvas.Font=Font'RenxHud.Font.RadioCommand_Medium' ;
	H.Canvas.StrLen(Target_Distance$"m",TextL,TextH);
	//TextH unnecessary here, but needed to export the output of StrLen somewhere
	
	H.Canvas.SetDrawColor(255,64,64,255);
	H.Canvas.SetPos(
	H.Canvas.SizeX/2-(TextL/2*ScaleX),
	H.Canvas.SizeY/2-(175*ScaleY)
	);
	
	H.Canvas.DrawText(Target_Distance$"m",true,1,1) ;
	
	
		
	
	
	//Reset the color
	//H.Canvas.SetDrawColor(0,0,0,255);
	
    // Draw the crosshair
    if (HudMaterial != none)
    {
		
        H.Canvas.SetPos(StartX, 0);
        H.Canvas.DrawMaterialTile(HudMaterial, 1024 * ScaleX, 1024 * ScaleY);
    }
    else 
    {
        // For backwards compatibility
        H.Canvas.SetPos(StartX, 0);
        H.Canvas.DrawTile(HudTexture, 1024 * ScaleX, 768 * ScaleY, 0, 0, 1024, 768);
    }
	
	
	/////////DRAW SCANNING///////////////
	//These positions are done sloppily, but... meh
	if(ScanningForTargets)
	{
	UpdateScanFlashVars();
	H.Canvas.SetPos(
	H.Canvas.SizeX/2-25*ScaleX,
	H.Canvas.SizeY/2+30*ScaleY) ;
	H.Canvas.SetDrawColor(255,64,64,255);
	H.Canvas.DrawColor.A=SCANNING_ALPHA;
	H.Canvas.DrawText("Scanning",true,1,1) ;
	
	//Draw our scanned percentage underneath Scanning. Draw it green if it's at 100%
	H.Canvas.SetPos(
	H.Canvas.SizeX/2-15*ScaleX,
	H.Canvas.SizeY/2+50*ScaleY) ;
	//Don't Flash
	H.Canvas.DrawColor.A=255;
	if(ScanPerc == 100) H.Canvas.SetDrawColor(0,255,0,255);
	H.Canvas.DrawText(round(ScanPerc)$"%",true,1,1) ;
	
	}
	
	////////////////////////////////////////
	//Draw the objective trying to be set//
	///////////////////////////////////////
	

	
	
	UpdateOInfo() ; //Call to update the state of the objective being set	
	
H.Canvas.DrawColor=Objective_Color ; 	
H.Canvas.StrLen("<-" @ ObjectiveString @ "->", TextL2,TextH)	;

	


	
//Upper prev objective??
Obj_Scale=0.66;
H.Canvas.StrLen("<" @ PrevObjectiveString @ ">", TextL2,TextH)	;
H.Canvas.SetPos(
	H.Canvas.SizeX/2-(TextL2/2*Obj_Scale*ScaleX),
	H.Canvas.SizeY/2-((125+TextH/2)*ScaleY)
	);
	
H.Canvas.DrawColor.A=200;
H.Canvas.DrawText("<" @ PrevObjectiveString @ ">",true,Obj_Scale,Obj_Scale) ;



//Middle text	
H.Canvas.StrLen("<-" @ ObjectiveString @ "->", TextL2,TextH)	;
Obj_Scale=1.0;
H.Canvas.SetPos(
	H.Canvas.SizeX/2-(TextL2/2*Obj_Scale*ScaleX),
	H.Canvas.SizeY/2-(125*ScaleY)
	);
	
	H.Canvas.DrawColor.A=255;
H.Canvas.DrawText("<" @ ObjectiveString @ ">",true,Obj_Scale,Obj_Scale) ;


//Lower next objective
H.Canvas.StrLen("<" @ NextObjectiveString @ ">", TextL2,TextH)	;
Obj_Scale=0.66;
H.Canvas.SetPos(
	H.Canvas.SizeX/2-(TextL2/2*Obj_Scale*ScaleX),
	H.Canvas.SizeY/2-((125-TextH-3)*ScaleY)
	);

H.Canvas.DrawColor.A=200;	
H.Canvas.DrawText("<" @ NextObjectiveString @ ">",true,Obj_Scale,Obj_Scale) ;

	H.Canvas.DrawColor.A=255;
////////////////////End Drawing objective///////////////

//Draw Debug line

H.Canvas.SetPos(0,0) ;
H.Canvas.DrawText("OnTarget= "$OnTarget) ;






}

/////////////////////////////////////////////////////////////
/////////Updates Variables to make SCANNING flash////////////
/////////////////////////////////////////////////////////////

simulated function UpdateScanFlashVars()
{

//Block of statements to make the text just flash back and forth

//If less than zero, make it 0
			

//if Cycler is over 0 and not flipped, it should increment down
if(SCANNING_Cycler > 0 && !bSCANNING_FlashUP) {
	//`log("Trying to Increment down") ; 
	SCANNING_Cycler-=SCANNING_ALPHA_INCREMENT 			; 
}
//If we are flipped and beneath the Max time for the current text, increment back up
if(SCANNING_Cycler < SCANNING_CyclerMAX && bSCANNING_FlashUP){

//`log("Trying to Increment UP") ; 
	SCANNING_Cycler+=SCANNING_ALPHA_INCREMENT	;
}
//If we go over the max time, flip us back around and beep
if(SCANNING_Cycler >= SCANNING_CyclerMAX) {
	bSCANNING_FlashUP = false ;
	}
//Run It back 
if(SCANNING_Cycler <= 0)
	{ 	
	bSCANNING_FlashUP = true 	;
	}					

	
SCANNING_ALPHA=round(255/((SCANNING_CyclerMAX-SCANNING_Cycler+1)/2))					;
}


/////////////////////////////////////////////////////////////
//Functions used to override mouse-wheel switching weapons.///
/////////////////////////////////////////////////////////////

simulated function bool DoOverridePrevWeapon()
{
    if (GetZoomedState() != ZST_NotZoomed)
    {
		if(!ScanningForTargets){
		//Increment objective
        if(Objective_To_Set > 0) Objective_To_Set--				;
		else
		Objective_To_Set=3							;
		}
		Rx_Controller(Instigator.Controller).ClientPlaySound(SndScroll) ;
		StartZoom(UTPlayerController(Instigator.Controller));
        return true;
    }
    return super.DoOverridePrevWeapon();
}

simulated function bool DoOverrideNextWeapon()
{
    if (GetZoomedState() != ZST_NotZoomed)
    {
		if(!ScanningForTargets){
		//increment Objective
		if(Objective_To_Set < 3)
        Objective_To_Set++									;
        else
		Objective_To_Set=0;
		}
		Rx_Controller(Instigator.Controller).ClientPlaySound(SndScroll) ;
        StartZoom(UTPlayerController(Instigator.Controller));
        return true;
    }
    return false;
}

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

//May remove this, or consider moving the beam to spawn at the root point of the mesh.
simulated function SpawnBeam()
{
	local vector start;

	// Get starting point of beam
	if (!SkeletalMeshComponent(Mesh).GetSocketWorldLocationAndRotation('MuzzleFlashSocket', start))
		start = Instigator.Location;

    Beam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamEffect, start);
    Beam.SetVectorParameter('BeamEnd', WAYPOINT);
	Beam.SetDepthPriorityGroup(SDPG_Foreground);
}





/**********************************************************
***********************************************************
*Miscellaneous, but necessary functions
***********************************************************
***********************************************************/

simulated function String GetHumanReadableName()
{
	return "Command Binoculars";
}

simulated function String GetItemName( string FullName )
{
	return "Commander Binoculars" ;
}

simulated function bool IsInstigatorCommander() 
{
local int i, myPID;

if(Instigator != none) myPID = Instigator.Controller.PlayerReplicationInfo.PlayerID ;
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

if(Instigator != none) myPID = Instigator.Controller.PlayerReplicationInfo.PlayerID ;
	
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


