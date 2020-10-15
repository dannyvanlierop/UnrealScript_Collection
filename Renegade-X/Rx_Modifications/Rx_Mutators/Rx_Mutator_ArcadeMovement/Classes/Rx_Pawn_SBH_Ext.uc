/*
** Rx_Pawn_SBH_Ext
*/

class Rx_Pawn_SBH_Ext extends Rx_Pawn_SBH ;

var bool canDJ ;
var float DefGroundSpeed ;
var AnimNodeBlendBySpeed SpeedConNode;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) {
	
	Super.PostInitAnimTree(SkelComp) ;
	
	if (SkelComp == Mesh)
	{
		
		ForEach SkelComp.AllAnimNodes(class'AnimNodeBlendBySpeed', SpeedConNode)
    {
    SpeedConNode.Constraints[0]=0 ;
	SpeedConNode.Constraints[1]=200 ;
	SpeedConNode.Constraints[2]=470 ;
	SpeedConNode.Constraints[3]=550 ;
	
	SetTimer(0.5, false, 'NormalizeHealth' ) ;
    }
		
}
}
//Fixed Double jump for RenX and that crappy anti-bunnyhop adding a different variable for jumping. Also using the Jump from UTPawn

function bool DoJump( bool bUpdating )
{
	// This extra jump allows a jumping or dodging pawn to jump again mid-air
	// (via thrusters). The pawn must be within +/- DoubleJumpThreshold velocity units of the
	// apex of the jump to do this special move.
	canDJ=true ;
	
	if(JumpZ < default.JumpZ) JumpZ = default.JumpZ ;
	
	CurrentHopStamina = 1 ;

	if(Abs(Velocity.Z) < DoubleJumpThreshold) LogInternal("In doublejump threshhold") ;
	//NOT BEING CALLED  [ !bUpdating && ]
	if ( !bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() ) 
	{
		
		if ( Rx_Controller(Controller) != None )
			Rx_Controller(Controller).bDoubleJump = true;
		LogInternal("222222222222222222222222DJump N Node Single:" $ Rx_Controller(Controller).bDoubleJump);
		DoDoubleJump(bUpdating);
		MultiJumpRemaining -= 1;
		return true;
	}

	if (bJumpCapable && !bIsCrouched && !bWantsToCrouch && (Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider))
	{
		if ( Physics == PHYS_Spider )
			Velocity = JumpZ * Floor;
		else if ( Physics == PHYS_Ladder )
			Velocity.Z = 0;
		else if ( bIsWalking )
			Velocity.Z = Default.JumpZ;
		else
			Velocity.Z = JumpZ;
		if (Base != None && !Base.bWorldGeometry && Base.Velocity.Z > 0.f)
		{
			if ( (WorldInfo.WorldGravityZ != WorldInfo.DefaultGravityZ) && (GetGravityZ() == WorldInfo.WorldGravityZ) )
			{
				Velocity.Z += Base.Velocity.Z * sqrt(GetGravityZ()/WorldInfo.DefaultGravityZ);
			}
			else
			{
				Velocity.Z += Base.Velocity.Z;
			}
		}
		SetPhysics(PHYS_Falling);		
		bReadyToDoubleJump = true;
		canDJ = CanDoubleJump() ;
		 
		LogInternal("SingleJump _ VarbUpdating:" $ bUpdating)		;
		bDodging = false;
		canDJ = (!bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() );
		
		LogInternal("CanDJ0000000000NormalJump:" $ canDJ) ;
		
		if ( !bUpdating )
		    PlayJumpingSound();
		return true;
	}
	return false;
}

simulated function DoDoubleJump( bool bUpdating )
{
	if ( !bIsCrouched && !bWantsToCrouch )
	{
		if ( !IsLocallyControlled() || AIController(Controller) != None )
		{
			MultiJumpRemaining -= 1;
		}
		
		Velocity.Z = JumpZ + MultiJumpBoost;
		LogInternal("01010101110101DoneDid A Double Jump");
		RX_InventoryManager(InvManager).OwnerEvent('MultiJump');
		
		SetPhysics(PHYS_Falling);
		BaseEyeHeight = DoubleJumpEyeHeight;		
		
		if (!bUpdating)
		{
			SoundGroupClass.Static.PlayDoubleJumpSound(self);
		}
	}
	
}


function bool CanDoubleJump()
{
	return ( (MultiJumpRemaining > 0) && (Physics == PHYS_Falling) && (bReadyToDoubleJump || (UTBot(Controller) != None)) );
}


function bool CanMultiJump()
{
	return ( MaxMultiJump > 0 );
}
	
simulated event Destroyed()
{
  Super.Destroyed();
  
  SpeedConNode = None;

}

//Obviously the function to normalize health to 200 across the board

simulated function bool NormalizeHealth () 
{
	
	healthmax = 200 ;
	health = 200 ; 
	
	//Added this specifically to fix the SBH not having a weapon. Why does he get an SMG?? Eh, reasons.
	if(Weapon == none)	
	{
	
	Rx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_LaserRifle', CLASS_PRIMARY);
	Rx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_SMG_Nod', CLASS_SIDEARM);
	Rx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_TimedC4', CLASS_EXPLOSIVE);
	
	}		
	
	return true; 
}

