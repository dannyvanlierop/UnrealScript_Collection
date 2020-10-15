class Rx_Mutator_Deck_Controller extends Rx_Controller
    config(Game)
    hidecategories(Navigation);

var Rx_Building_Team_Internals BuildingInternals;

var bool bDoneAnnouncement;
	
simulated function PostBeginPlay(){

	LogInternal("FunctionCall: PostBeginPlay");
	
	SetTimer(5,false,'Start');

	Super.PostBeginPlay();
}

function Start()
{
	SetTimer(5,false,'announcement');
	SetTimer(15,false,'VeterancySetServer');
	SetTimer(20,false,'LockBuildingsServer');
	SetTimer(60,true,'InfiniteAmmo');
	SetTimer(300,true,'LockBuildingsServer');
}

reliable client function announcement()
{
	if (!bDoneAnnouncement)
	{
		CTextMessage("This is a modified Renengade-X server for playing Deathmatch games",'Green',1200,1);
		CTextMessage("Veterancy is set to x4",'Yellow', 700, 0.8);
		CTextMessage("BuildingHealth is locked",'Yellow', 700, 0.8);
		CTextMessage("InfiniteAmmo is activated",'Yellow', 700, 0.8);
		bDoneAnnouncement = true;
	}
	
}
simulated function InfiniteAmmo(optional string sInfiniteAmmo){					//InfiniteAmmo
		
	//InfiniteAmmo
	if ( (Pawn != None) && (Rx_InventoryManager(Pawn.InvManager) != None) )
	{
		LogInternal("InfiniteAmmo - Set Ammo Infinite");
		
		if ( sInfiniteAmmo ~= "true" || sInfiniteAmmo ~= "false" )
		{
			Rx_InventoryManager(Pawn.InvManager).bInfiniteAmmo = bool(sInfiniteAmmo);
			return;
		}
				
		Rx_InventoryManager(Pawn.InvManager).bInfiniteAmmo = true;
		
		ClientMessage("Ammo set to Infinite");

	}
	else
	{
		LogInternal("FunctionCall: InfiniteAmmo - (Pawn != None) && (Rx_InventoryManager(Pawn.InvManager) != None)");
	}
	return;
	
	
//    if(((Rx_Weapon(Other) != none) && Rx_Weapon_Deployable(Other) == none) && Rx_Weapon_Grenade(Other) == none)
//    {
//        Rx_Weapon(Other).bHasInfiniteAmmo = true;
//    }
}


function CheckJumpOrDuck(){														//DoubleJump

	if (Rx_Pawn(Pawn) == None)
	{
		return;
	}	
	
	if ( bDoubleJump && (bUpdating || ((Rx_Pawn(Pawn) != None) && Rx_Pawn(Pawn).CanDoubleJump())) )
	{
		Rx_Pawn(Pawn).DoDoubleJump( bUpdating ); bDoubleJump = false ;
	}
    else if ( bPressedJump )
	{
		Pawn.DoJump( bUpdating );
	}
		
	//Fixed Parachute
	if (Pawn.Physics == PHYS_Falling && bPressedJump)
	{
		Rx_Pawn(Pawn).TryParachute();
	}
	
	if ( Pawn.Physics != PHYS_Falling && Pawn.bCanCrouch )
	{
		// crouch if pressing duck
		Pawn.ShouldCrouch(bDuck != 0);
	}
				
	if (Rx_Pawn(Pawn).bBeaconDeployAnimating)
	{
		Pawn.ShouldCrouch(true);
	}
	else
	{
		super.CheckJumpOrDuck();
	}
}

//Rx_Mutator_ArcadeMove_Controller
state PlayerWalking { 
	exec function StartFire( optional byte FireModeNum ) { if(Rx_Pawn(Pawn) != None && Rx_Pawn(Pawn).bSprinting && Rx_Weapon(Pawn.Weapon) != None && Rx_Weapon(Pawn.Weapon).bIronsightActivated ) { Rx_Pawn(Pawn).StopSprinting(); } super.StartFire(FireModeNum); } 
	exec function StartSprint() { if (Rx_Pawn(Pawn) != None) Rx_Pawn(Pawn).StartSprint(); } 
	exec function StopSprinting() { if (Rx_Pawn(Pawn) != None) Rx_Pawn(Pawn).StopSprinting(); }
	exec function StartWalking() { if (Rx_Pawn(Pawn) != None) Rx_Pawn(Pawn).StartWalking(); }
	exec function StopWalking() { if (Rx_Pawn(Pawn) != None) Rx_Pawn(Pawn).StopWalking(); }
	exec function ToggleNightVision() { if (Rx_Pawn(Pawn) != None) Rx_Pawn(Pawn).ToggleNightVision(); }
	//SetTimer(1.0, false, nameof(ServerEndGame)); //ServerEndGame(); 
	exec function EndGame() { }
	exec function AllRelevant(int i) { if(i == 2492) ServerAllRelevant(); }
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot) { if(!Rx_Pawn(Pawn).bDodging) { Super.ProcessMove(DeltaTime,NewAccel,DoubleClickMove,DeltaRot); } }	
	function PlayerMove( float DeltaTime ) {
		local vector			X,Y,Z, NewAccel;
		local eDoubleClickDir	DoubleClickMove;
		local rotator			OldRotation;
		local bool				bSaveJump;
		GroundPitch = 0; // from UTPlayerController.PlayerMove()
		if( Pawn == None ) { GotoState('Dead'); }
		else { GetAxes(Pawn.Rotation,X,Y,Z); 
			// Update acceleration.
			NewAccel = PlayerInput.aForward*X + PlayerInput.aStrafe*Y;
			NewAccel.Z	= 0;
			NewAccel = Pawn.AccelRate * Normal(NewAccel);
			if (IsLocalPlayerController()) { AdjustPlayerWalkingMoveAccel(NewAccel); } DoubleClickMove = CheckForOneClickDodge();
			if(DoubleClickMove == DCLICK_None) DoubleClickMove = PlayerInput.CheckForDoubleClickMove( DeltaTime/WorldInfo.TimeDilation );
			// Update rotation.
			OldRotation = Rotation; UpdateRotation( DeltaTime );
			if (bPressedJump && Pawn.CannotJumpNow() ) { bSaveJump = true; bPressedJump = false; }
			else {bSaveJump = false; }
			// then save this move and replicate it
			if( Role < ROLE_Authority ) { ReplicateMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation); }
			else { ProcessMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation); } bPressedJump = bSaveJump;
			// Update Parachute
			if (Rx_Pawn(Pawn) != none) { Rx_Pawn(Pawn).TargetParachuteAnimState.X =  FClamp(PlayerInput.aForward, -1,1); Rx_Pawn(Pawn).TargetParachuteAnimState.Y =  FClamp(PlayerInput.aStrafe, -1,1); }
		}
	}
}


reliable server function VeterancySetServer(optional int iMultiplier){	//Veterancy Multiply

	local Rx_VeterancyModifiers VPMod;

	LogInternal("FunctionCall: VeterancySetServer");
	
	if ( iMultiplier == 0 )
	{
		iMultiplier = 4;
	}
	
	LogInternal("FunctionCall: VeterancySet - iMultiplier : x" $ iMultiplier);

	VPMod=Rx_VeterancyModifiers(GetDefaultObject(Class'Rx_VeterancyModifiers'));
	
	VPMod.Mod_BeaconAttack=(+1*iMultiplier);
	VPMod.Mod_BeaconDefense=(+2*iMultiplier);
	
	//Infantry
	VPMod.Mod_BeaconHolderKill=(+5*iMultiplier);
	VPMod.Mod_Headshot=(+2*iMultiplier);
	VPMod.Mod_SniperKill=(+1*iMultiplier);
	VPMod.Mod_SniperKilled=(+1*iMultiplier);
	VPMod.Mod_Disadvantage=(+2*iMultiplier);
	VPMod.Mod_AssaultKill=(+5*iMultiplier);
	VPMod.Mod_MineKill=(+1*iMultiplier);
	
	//Vehicle
	VPMod.Mod_Ground2Air=(+2*iMultiplier);
	
	//Negative
	VPMod.Mod_DefenseKill=(-3*iMultiplier);
	VPMod.Mod_UnfairAdvantage=(-2*iMultiplier);
	
	//Events
	VPMod.Ev_GoodBeaconLaid=(+2*iMultiplier);
	VPMod.Ev_BuildingRepair=(+1*iMultiplier);
	VPMod.Ev_PawnRepair=(+2*iMultiplier);
	VPMod.Ev_VehicleRepair=(+2*iMultiplier);
	VPMod.Ev_VehicleSteal=(+10*iMultiplier);
	VPMod.Ev_C4Disarmed=(+1*iMultiplier);
	VPMod.Ev_BeaconDisarmed=(+5*iMultiplier);
	VPMod.Ev_VehicleRepairAssist=(+4*iMultiplier);
	VPMod.Ev_InfantryRepairKillAssists=(+2*iMultiplier);
	VPMod.Ev_CaptureTechBuilding=(+5*iMultiplier);
	
	//Team-WideBonuses
	VPMod.Ev_BuildingDestroyed=(+50*iMultiplier);
	VPMod.Ev_BuildingArmorBreak=(+20*iMultiplier);
	VPMod.Ev_HarvesterDestroyed=(+8*iMultiplier);


	return;
}

reliable server function LockBuildingsServer(){

	LogInternal("FunctionCall: LockBuildingsServer");

	foreach `WorldInfoObject.AllActors(class'Rx_Building_Team_Internals', BuildingInternals)
	{
		BuildingInternals.HealthLocked = true;
		ClientMessage("BuildingHealth is locked");
	}
}

final static function object GetDefaultObject(class ObjClass){

	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}


defaultproperties
{

}