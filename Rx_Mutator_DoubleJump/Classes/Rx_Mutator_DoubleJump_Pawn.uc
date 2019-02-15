/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the DoubleJump function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_DoubleJump_Pawn                                                  *
******************************************************************************/

class Rx_Mutator_DoubleJump_Pawn extends Rx_Pawn;

var RepNotify Bool DoubleJumpMode;
var bool canDJ ;

replication
{
    if(bNetDirty)
        DoubleJumpMode;
}

exec function DoubleJumpModeCheck()
{
    if (DoubleJumpMode) 
	{ 
		ClientMessage("TestMode activated"); 
	}
    else 
	{ 
		ClientMessage("TestMode deactivated"); 
	}
}

function DoubleJumpModeToggleSet() 
{
	if (DoubleJumpMode)
	{
		DoubleJumpMode=false;
	}  
	else
	{
		DoubleJumpMode=true;
	}
}

exec function DoubleJumpModeToggle() 
{
	ServerToggleDoubleJumpMode();
}

reliable server function ServerToggleDoubleJumpMode()
{
	local Rx_Mutator_DoubleJump_Controller C;
	
	if (PlayerReplicationInfo.bAdmin)
	{	
		foreach WorldInfo.AllControllers(class'Rx_Mutator_DoubleJump_Controller', C)
		{
		DoubleJumpModeToggleSet();
		DoubleJumpModeCheck();
		}
	}
    else
    {
        C.ClientMessage("First login as admin",,1); 
    }
}	//Only ever do admin checks on the actual server. 

function bool DoJump( bool bUpdating ) { canDJ=true; 
	if(JumpZ < default.JumpZ) JumpZ = default.JumpZ; CurrentHopStamina = 1;
	if(Abs(Velocity.Z) < DoubleJumpThreshold) LogInternal("In doublejump threshhold");
	if ( !bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() ) {
		if ( Rx_Controller(Controller) != None ) Rx_Controller(Controller).bDoubleJump = true; 
			LogInternal("222222222222222222222222DJump N Node Single:" $ Rx_Controller(Controller).bDoubleJump); 
			DoDoubleJump(bUpdating); MultiJumpRemaining -= 1; 
			return true; 
		}
	if (bJumpCapable && !bIsCrouched && !bWantsToCrouch && (Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider)) {
		if ( Physics == PHYS_Spider ) Velocity = JumpZ * Floor; 
		else if ( Physics == PHYS_Ladder ) Velocity.Z = 0;
		else if ( bIsWalking ) Velocity.Z = Default.JumpZ;
		else Velocity.Z = JumpZ; 
		if (Base != None && !Base.bWorldGeometry && Base.Velocity.Z > 0.f) { 
			if ( (WorldInfo.WorldGravityZ != WorldInfo.DefaultGravityZ) && (GetGravityZ() == WorldInfo.WorldGravityZ) ) { Velocity.Z += Base.Velocity.Z * sqrt(GetGravityZ()/WorldInfo.DefaultGravityZ); }
			else { Velocity.Z += Base.Velocity.Z; } }
		SetPhysics(PHYS_Falling); bReadyToDoubleJump = true; canDJ = CanDoubleJump(); 
		LogInternal("SingleJump _ VarbUpdating:" $ bUpdating); bDodging = false;
		canDJ = (!bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() ); 
		LogInternal("CanDJ0000000000NormalJump:" $ canDJ) ;
		if ( !bUpdating ) PlayJumpingSound(); return true; 
	} return false;
}

simulated function DoDoubleJump( bool bUpdating ) 
{ 
    if (DoubleJumpMode) {
	if ( !bIsCrouched && !bWantsToCrouch ) { if ( !IsLocallyControlled() || AIController(Controller) != None ) { MultiJumpRemaining -= 1; } 
		Velocity.Z = JumpZ + MultiJumpBoost; LogInternal("01010101110101DoneDid A Double Jump"); RX_InventoryManager(InvManager).OwnerEvent('MultiJump'); SetPhysics(PHYS_Falling); BaseEyeHeight = DoubleJumpEyeHeight; 
		if (!bUpdating) { SoundGroupClass.Static.PlayDoubleJumpSound(self); } 
	} 
	}
}

function bool CanDoubleJump() { return ( (MultiJumpRemaining > 0) && (Physics == PHYS_Falling) && (bReadyToDoubleJump || (UTBot(Controller) != None)) ); }

function bool CanMultiJump() { return ( MaxMultiJump > 0 ); }

DefaultProperties
{
	DoubleJumpMode=true;
	MaxMultiJump=1				// default is 0
	MultiJumpRemaining=0		// default is 0
	JumpZ=500					// default is 320
	MaxJumpHeight=150			// something less than 49
}
 