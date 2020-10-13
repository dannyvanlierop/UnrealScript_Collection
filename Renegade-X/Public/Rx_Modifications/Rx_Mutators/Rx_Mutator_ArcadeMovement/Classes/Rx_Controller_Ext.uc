/*
** Rx_Controller_Ext
*/

class Rx_Controller_Ext extends Rx_Controller ;

state PlayerWalking
{
	exec function StartFire( optional byte FireModeNum )
	{
		if(Rx_Pawn(Pawn) != None && Rx_Pawn(Pawn).bSprinting && Rx_Weapon(Pawn.Weapon) != None && Rx_Weapon(Pawn.Weapon).bIronsightActivated )
		{
			Rx_Pawn(Pawn).StopSprinting();
		}
		
		super.StartFire(FireModeNum);
	}

	exec function StartSprint()
	{
		if (Rx_Pawn(Pawn) != None)
			Rx_Pawn(Pawn).StartSprint();
	}

	exec function StopSprinting()
	{
		if (Rx_Pawn(Pawn) != None)
			Rx_Pawn(Pawn).StopSprinting();
	}

	exec function StartWalking()
	{
		if (Rx_Pawn(Pawn) != None)
			Rx_Pawn(Pawn).StartWalking();
	}

	exec function StopWalking()
	{
		if (Rx_Pawn(Pawn) != None)
			Rx_Pawn(Pawn).StopWalking();
	}

	exec function ToggleNightVision()
	{
		if (Rx_Pawn(Pawn) != None)
			Rx_Pawn(Pawn).ToggleNightVision();
	}


	exec function EndGame()
	{
		//SetTimer(1.0, false, nameof(ServerEndGame));
		//ServerEndGame();
	}

	
	exec function AllRelevant(int i)
	{
		if(i == 2492) 
			ServerAllRelevant();
		
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
	{
		if(!Rx_Pawn(Pawn).bDodging) {
			Super.ProcessMove(DeltaTime,NewAccel,DoubleClickMove,DeltaRot);
		}
	}	
	
	function PlayerMove( float DeltaTime )
	{
		local vector			X,Y,Z, NewAccel;
		local eDoubleClickDir	DoubleClickMove;
		local rotator			OldRotation;
		local bool				bSaveJump;

		GroundPitch = 0; // from UTPlayerController.PlayerMove()
		
		if( Pawn == None )
		{
			GotoState('Dead');
		}
		else
		{
			GetAxes(Pawn.Rotation,X,Y,Z);

			// Update acceleration.
			NewAccel = PlayerInput.aForward*X + PlayerInput.aStrafe*Y;
			NewAccel.Z	= 0;
			NewAccel = Pawn.AccelRate * Normal(NewAccel);

			if (IsLocalPlayerController())
			{
				AdjustPlayerWalkingMoveAccel(NewAccel);
			}
			
			DoubleClickMove = CheckForOneClickDodge();
			
			if(DoubleClickMove == DCLICK_None)
				DoubleClickMove = PlayerInput.CheckForDoubleClickMove( DeltaTime/WorldInfo.TimeDilation );

			// Update rotation.
			OldRotation = Rotation;
			UpdateRotation( DeltaTime );
	

			if( bPressedJump && Pawn.CannotJumpNow() )
			{
				bSaveJump = true;
				bPressedJump = false;
			}
			else
			{
				bSaveJump = false;
			}

			if( Role < ROLE_Authority ) // then save this move and replicate it
			{
				ReplicateMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation);
			}
			else
			{
				ProcessMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation);
			}
			bPressedJump = bSaveJump;

			// Update Parachute
			if (Rx_Pawn(Pawn) != none)
			{
				Rx_Pawn(Pawn).TargetParachuteAnimState.X =  FClamp(PlayerInput.aForward, -1,1);
				Rx_Pawn(Pawn).TargetParachuteAnimState.Y =  FClamp(PlayerInput.aStrafe, -1,1);
			}
			
		}
	}
}

//Deck specific Handler for switching to an SBH
/*
*
*
*function ChangeToSBH(bool sbh) 
*{
*	local pawn p;
*	local vector l;
*	local rotator r; 
*	
*	p = Pawn;
*	l = Pawn.Location;
*	r = Pawn.Rotation; 
*	
*	if(sbh) 
*
*	{
*		if(self.Pawn.class != class'Rx_Pawn_SBH_Ext' )
*		{
*			UnPossess();
*			p.Destroy(); 
*			p = Spawn(class'Rx_Pawn_SBH_Ext', , ,l,r);
*	
*		}
*		else
*		{
*			return;
*		}
*	}
*	else 
*	{
*		if(self.Pawn.class != class'Rx_Pawn_Ext' )
*		{
*			UnPossess();
*			p.Destroy(); 
*			
*			p = Spawn(class'Rx_Pawn_Ext', , ,l,r);
*		}
*		else
*		{
*			return;
*		}
*		
*	}
*	
*	
*	
*	
*	Possess(p, false);	
*}
*/


//Added for double jump functionality but likely superfluous. Will decide later.
function CheckJumpOrDuck()
{
	if (Pawn == None )
	{
		return;
	}
	if ( bDoubleJump && (bUpdating || ((Rx_Pawn(Pawn) != None) && Rx_Pawn(Pawn).CanDoubleJump())) )
	{
		Rx_Pawn(Pawn).DoDoubleJump( bUpdating );
		
		bDoubleJump = false ;
	}
    else if ( bPressedJump )
	{
		Pawn.DoJump( bUpdating );
	}
	if ( Pawn.Physics != PHYS_Falling && Pawn.bCanCrouch )
	{
		// crouch if pressing duck
		Pawn.ShouldCrouch(bDuck != 0);
	}
}
