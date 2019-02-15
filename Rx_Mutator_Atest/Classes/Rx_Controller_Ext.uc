/**
 * RxController
 *
 * */
class Rx_Controller_Ext extends Rx_Controller;

/******************** Driving *******************/
state PlayerDriving
{
	/** Sprinting System */
	exec function StartSprint()
	{
		if (Rx_Vehicle(Pawn) != None)
		{
			if (bHoldSprint)
			{
				bHoldSprint = false;
				StopSprinting();
				return;
			}

			Rx_Vehicle(Pawn).StartSprint();

			if ( WorldInfo.TimeSeconds - LastSprintTime < PlayerInput.DoubleClickTime )
				bHoldSprint = true;

			LastSprintTime = WorldInfo.TimeSeconds;
		}
	}

	exec function StopSprinting()
	{
		if (Rx_Vehicle(Pawn) != None && bHoldSprint == false)
			Rx_Vehicle(Pawn).StopSprinting();
	}

	simulated function EndState(Name NextStateName)
	{
		bHoldSprint = false;
		Super.EndState(NextStateName);
	}
}

state Dead
{
	ignores SeePlayer, HearNoise, KilledBy, NextWeapon, PrevWeapon;

	exec function SwitchWeapon(byte T){}
	exec function ToggleMelee() {}
	exec function StartFire( optional byte FireModeNum )
	{
		if ( bFrozen )
		{
			if ( !IsTimerActive() || GetTimerCount() > MinRespawnDelay )
				bFrozen = false;
			return;
		}
		if ( PlayerReplicationInfo.bOutOfLives )
			ServerSpectate();
		else
			super.StartFire( FireModeNum );
	}

	function Timer()
	{
		if (!bFrozen)
			return;

		// force garbage collection while dead, to avoid GC during gameplay
		if ( (WorldInfo.NetMode == NM_Client) || (WorldInfo.NetMode == NM_Standalone) )
		{
			WorldInfo.ForceGarbageCollection();
		}
		bFrozen = false;
		bUsePhysicsRotation = false;
		bPressedJump = false;
	}

	reliable client event ClientSetViewTarget( Actor A, optional ViewTargetTransitionParams TransitionParams )
	{
		if( A == None )
		{
			ServerVerifyViewTarget();
			return;
		}
		// don't force view to self while dead (since server may be doing it having destroyed the pawn)
		if ( A == self )
			return;
		SetViewTarget( A, TransitionParams );
	}

	/** one: added. */
	simulated event GetPlayerViewPoint( out vector POVLocation, out Rotator POVRotation )
	{
		local vector HitLocation, HitNormal, off;
		local Actor a;
		local rotator rot;

		super.GetPlayerViewPoint(POVLocation, POVRotation);

		off = POVLocation;
		off.Z += DeathCameraOffset.Z;
		rot = POVRotation;
		rot.Pitch = 0;
		off -= vector(rot) * DeathCameraOffset.X;
		a = Trace(HitLocation, HitNormal, off, POVLocation, true);
		if (a == none) HitLocation = off;

		POVLocation = HitLocation - (0.1f * (HitLocation - POVLocation));
	}

	function FindGoodView()
	{
		local vector cameraLoc;
		local rotator cameraRot, ViewRotation, RealRotation;
		local int tries, besttry;
		local float bestdist, newdist, RealCameraScale;
		local int startYaw;
		local UTPawn P;
		
		if(LastKiller != None && LastKiller.Pawn != None)
		{
			SetRotation(rotator(LastKiller.Pawn.location - ViewTarget.Location));
			ClientSetRotation(rotation);
		}			

		if ( UTVehicle(ViewTarget) != None )
		{
			if (Pawn!=none)
			{
				Pawn.SetDesiredRotation(Rotation);
			}
			bUsePhysicsRotation = false;
			return;
		}

		ViewRotation = Rotation;
		RealRotation = ViewRotation;
		ViewRotation.Pitch = 56000;
		SetRotation(ViewRotation);
		P = UTPawn(ViewTarget);
		if ( P != None )
		{
			RealCameraScale = P.CurrentCameraScale;
			P.CurrentCameraScale = P.CameraScale;
		}

		// use current rotation if possible
		CalcViewActor = None;
		cameraLoc = ViewTarget.Location;
		GetPlayerViewPoint( cameraLoc, cameraRot );
		if ( P != None )
		{
			newdist = VSize(cameraLoc - ViewTarget.Location);
			if (newdist < P.CylinderComponent.CollisionRadius + P.CylinderComponent.CollisionHeight )
			{
				// find alternate camera rotation
				tries = 0;
				besttry = 0;
				bestdist = 0.0;
				startYaw = ViewRotation.Yaw;

				for (tries=1; tries<16; tries++)
				{
					CalcViewActor = None;
					cameraLoc = ViewTarget.Location;
					ViewRotation.Yaw += 4096;
					SetRotation(ViewRotation);
					GetPlayerViewPoint( cameraLoc, cameraRot );
					newdist = VSize(cameraLoc - ViewTarget.Location);
					if (newdist > bestdist)
					{
						bestdist = newdist;
						besttry = tries;
					}
				}
				ViewRotation.Yaw = startYaw + besttry * 4096;
			}
			P.CurrentCameraScale = RealCameraScale;
		}
		SetRotation(RealRotation);
		if (Pawn!=none)
		{
			Pawn.SetDesiredRotation(MakeRotator(ViewRotation.Pitch, ViewRotation.Yaw, 0));
		}
		bUsePhysicsRotation = false;
	}

	function PlayerMove(float DeltaTime)
	{
		local vector X,Y,Z;
		local rotator DeltaRot, ViewRotation;

		//if ( !bFrozen )
		//{
			if ( bPressedJump )
			{
				StartFire( 0 );
				bPressedJump = false;
			}
			GetAxes(Rotation,X,Y,Z);
			// Update view rotation.
			ViewRotation = Rotation;
			// Calculate Delta to be applied on ViewRotation
			DeltaRot.Yaw	= PlayerInput.aTurn;
			DeltaRot.Pitch	= PlayerInput.aLookUp;
			ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
			SetRotation(ViewRotation);
			if ( Role < ROLE_Authority ) // then save this move and replicate it
					ReplicateMove(DeltaTime, vect(0,0,0), DCLICK_None, rot(0,0,0));
		//}
		//else 
		if ( !IsTimerActive() || GetTimerCount() > MinRespawnDelay )
		{
			bFrozen = false;
		}

		ViewShake(DeltaTime);
	}

	function BeginState(Name PreviousStateName)
	{
		local UTWeaponLocker WL;
		local UTWeaponPickupFactory WF;

		if(Vet_Menu != none) 
		{
		DestroyOldVetMenu(); //Kill Vet menu on death 
		}
		
		LastAutoObjective = None;
		if ( Pawn(Viewtarget) != None )
		{
			Super(UtPlayerController).SetBehindView(true);
		}

		/** one1: modified */
		//Super.BeginState(PreviousStateName);
		if ( (Pawn != None) && (Pawn.Controller == self) )
			Pawn.Controller = None;
		Pawn = None;
		FOVAngle = DesiredFOV;
		Enemy = None;
		bFrozen = true;
		bPressedJump = false;
		FindGoodView();
		MinRespawnDelay = CalcNewMinRespawnDelay();
	    SetTimer(MinRespawnDelay, false);

	    //set timer for respawn hud counter (nBab)
		if(WorldInfo.NetMode != NM_DedicatedServer)
		{
			SetTimer(1,true,'setRespawnUiCounter');
			Rx_HUD(myHUD).HudMovie.setRespawnCounter(MinRespawnDelay);	
		}

		CleanOutSavedMoves();

		if ( LocalPlayer(Player) != None )
		{
			ForEach WorldInfo.AllNavigationPoints(class'UTWeaponLocker',WL)
				WL.NotifyLocalPlayerDead(self);
			ForEach WorldInfo.AllNavigationPoints(class'UTWeaponPickupFactory',WF)
				WF.NotifyLocalPlayerDead(self);
		}

		if (Role == ROLE_Authority && UTGame(WorldInfo.Game) != None && UTGame(WorldInfo.Game).ForceRespawn())
		{
			SetTimer(MinRespawnDelay, true, 'DoForcedRespawn');
		}
	}

	//set the respawn hud counter (nBab)
	function setRespawnUiCounter()
	{
		//if the main timer is running
		if (GetTimerCount() != -1)
		{
			Rx_HUD(myHUD).HudMovie.setRespawnCounter( int(MinRespawnDelay - FFloor(GetTimerCount())) );
		}
		else
		{
			Rx_HUD(myHUD).HudMovie.setRespawnCounter(0);
		}
	}

	/** forces player to respawn if it is enabled */
	function DoForcedRespawn()
	{
		if (PlayerReplicationInfo.bOnlySpectator)
		{
			ClearTimer('DoForcedRespawn');
		}
		else
		{
			ServerRestartPlayer();
		}
	}

	function EndState(name NextStateName)
	{
		bUsePhysicsRotation = false;
		Super.EndState(NextStateName);
		SetBehindView(false);
		StopViewShaking();
		ClearTimer('DoForcedRespawn');
	}

Begin:
    Sleep(5.0);
	if ( (ViewTarget == None) || (ViewTarget == self) || (VSize(ViewTarget.Velocity) < 1.0) )
	{
		Sleep(1.0);
		if (myHUD != None)
		{
			//@FIXME: disabled temporarily for E3 due to scoreboard stealing input
			//myHUD.SetShowScores(true);
		}
	}
	else
		Goto('Begin');
}

/** Gradually increases with time till MaxRespawnDelay is reached */
function float CalcNewMinRespawnDelay()
{

	MinRespawnDelay = default.MinRespawnDelay + (WorldInfo.TimeSeconds/TimeSecondsTillMaxRespawnTime * (default.MaxRespawnDelay - default.MinRespawnDelay));
	
	if(MinRespawnDelay < default.MinRespawnDelay)
		MinRespawnDelay = default.MinRespawnDelay;
	else if(MinRespawnDelay > default.MaxRespawnDelay)
		MinRespawnDelay = default.MaxRespawnDelay;	
		
	return MinRespawnDelay;	
}

function UpdateRotation( float DeltaTime )
{
	local rotator DeltaRot;

	// if free aim dont rotate view
	if (bIsFreeView)
	{
		DeltaRot.Yaw	= PlayerInput.aTurn;
		DeltaRot.Pitch	= PlayerInput.aMouseY;
		FreeAimRot += DeltaRot;
		
		ViewShake( deltaTime );

		if (Pawn != none)
			Pawn.FaceRotation(Pawn.Rotation + DeltaRot, DeltaTime);
	}
	else
		super.UpdateRotation(DeltaTime);
}

