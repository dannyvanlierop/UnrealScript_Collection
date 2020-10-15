// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_AdminTool_Controller * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_Pawn extends Rx_Pawn;

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

													/* General (AdminTool) variables */


													/* DoubleJump configuration variables */
var bool canDJ ;
													/* NormalizeHealth configuration variables */
//var float DefGroundSpeed ;
//var AnimNodeBlendBySpeed SpeedConNode;
	
/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  REPLICATION  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *********  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
//		simulated event PreBeginPlay(){
//		
//			LogInternal("Rx_Mutator_AdminTool_Pawn FunctionCall: PreBeginPlay");
//			
//			//Super.PreBeginPlay();
//			
//			SetTimer(0.2,false,'init');
//		}
//		
//		simulated function PostBeginPlay()
//		{
//			LogInternal("Rx_Mutator_AdminTool_Pawn FunctionCall: PostBeginPlay");
//			
//			Super.PostBeginPlay();
//			
//			//The PostBeginPlay() event is called after all other Actors have been initialized, via their PreBeginPlay() events. 
//			//This event is generally used to initialize properties, find references to other Actors in the world, 
//			//and perform any other general initialization. It is fair to consider this event the script equivalent of a constructor for Actors. 
//			//Even so, there are still some things that require using specialized events available in the Actor to initialize. 
//			//For instance, initialization having to do with animations and the AnimTree would best be performed in the PostInitAnimTree() event as that is called after the AnimTree is created and initialized. 
//			//There are many such events provided for doing this type of specialized initialization. 
//			//It is best to search for these first before adding specific initialization functionality to the PostBeginPlay() event.
//		}


/*****************************************************************************/
//  *  //  *  //  *  //   ***************************   //  *  //  *  //  *  //
/*****************************************************************************/

function init(){

	LogInternal("Rx_Mutator_AdminTool_Pawn FunctionCall: init");
	

}


/*
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
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

*/


/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode11  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//WeaponDrop
function RemoteDropFrom(vector StartLocation, vector StartVelocity, Rx_Weapon Weap)
{
	//YOSH:Weirdly add weapon drops. I have to go around the normal DropFrom function to get around the automatic 'false' given to Rx_Weapons
	
	local DroppedPickup P;
	local int iMode;
	local Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
	
	foreach AllActors(class 'Rx_Mutator_AdminTool_Controller',myAdminTool_Controller)
	break;
	
	
	//LogInternal("FunctionCall: RemoteDropFrom");
	//LogInternal("FunctionCall: RemoteDropFrom - Input - StartLocation:" $ StartLocation $ "StartVelocity:" $ StartVelocity "Weap:" $ Weap);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=11;	//DONT CHANGE - Used for Authentication Check	 //
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//if ( AC.ModeAccessLevelArray[11] == 1 || AC.ModeStatusArray[11] == "false" )
	if ( myAdminTool_Controller == None )
	return;
	
	if ( !bool(myAdminTool_Controller.ModeStatusArray[iMode]))
	{
		return;
	}		
	
	if(InvManager != None )
	{
		InvManager.RemoveFromInventory(Weap);
	}
	
	// if cannot spawn a pickup, then destroy and quit
	if( Weap.DroppedPickupClass == None || Weap.DroppedPickupMesh == None )
	{
		Weap.Destroy();
		return;
	}
	
	//From UTWeapon DropFrom
	
	// Become inactive
	Weap.GotoState('Inactive');
	
	// Stop Firing
	Weap.ForceEndFire();
	// Detach weapon components from instigator
	Weap.DetachWeapon();
	
	//The rest of the super function
	P = Spawn(Weap.DroppedPickupClass,,, StartLocation);
	if( P == None )
	{
		Weap.Destroy();
		return;
	}
	
	P.SetPhysics(PHYS_Falling);
	P.Inventory	= Weap;
	P.InventoryClass = Weap.class;
	P.Velocity = StartVelocity;
	P.Instigator = self;
	P.SetPickupMesh(Weap.DroppedPickupMesh);
	P.SetPickupParticles(Weap.DroppedPickupParticles);
	
	GotoState('');
	
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	//LogInternal("FunctionCall: Died");
	//LogInternal("FunctionCall: Died - Input - Killer:" $ Killer $ "damageType:" $ damageType "HitLocation:" $ HitLocation);
	
	// if( Rx_Game(WorldInfo.Game).bAllowWeaponDrop == true) {
	if (Weapon != none)
	{
		RemoteDropFrom(Location, Velocity, Rx_Weapon(Weapon));
	}
	//}
	super.Died(Killer, damageType, HitLocation); return true;
}



/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode12  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//DoubleJump
function bool DoJump( bool bUpdating )
{
	//local int iMode;
	//local Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
	//
	//foreach AllActors(class 'Rx_Mutator_AdminTool_Controller',myAdminTool_Controller)
	//break;
	
	//LogInternal("FunctionCall: DoJump");
	//LogInternal("FunctionCall: DoJump - Input - bUpdating:" $ bUpdating);

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	//iMode=12;	//DONT CHANGE - Used for Authentication Check	 //
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//if ( !bool(myAdminTool_Controller.ModeStatusArray[iMode]) )
	//{
	//	return false;
	//}

	
	//Fixed Double jump for RenX and that crappy anti-bunnyhop adding a different variable for jumping. Also using the Jump from UTPawn
	
	// This extra jump allows a jumping or dodging pawn to jump again mid-air
	// (via thrusters). The pawn must be within +/- DoubleJumpThreshold velocity units of the
	// apex of the jump to do this special move.
	
	canDJ=true;

	if(JumpZ < default.JumpZ) JumpZ = default.JumpZ; CurrentHopStamina = 1;
	if(Abs(Velocity.Z) < DoubleJumpThreshold) /* LogInternal("In doublejump threshhold")*/;
	//NOT BEING CALLED  [ !bUpdating && ]
	if ( !bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() )
	{
		if ( Rx_Controller(Controller) != None ) Rx_Controller(Controller).bDoubleJump = true; 
			//LogInternal("222222222222222222222222DJump N Node Single:" $ Rx_Controller(Controller).bDoubleJump); 
			DoDoubleJump(bUpdating); MultiJumpRemaining -= 1; 
			return true; 
		}
	if (bJumpCapable && !bIsCrouched && !bWantsToCrouch && (Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider))
	{
		if ( Physics == PHYS_Spider ) Velocity = JumpZ * Floor; 
		else if ( Physics == PHYS_Ladder ) Velocity.Z = 0;
		else if ( bIsWalking ) Velocity.Z = Default.JumpZ;
		else Velocity.Z = JumpZ; 
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
		SetPhysics(PHYS_Falling); bReadyToDoubleJump = true; canDJ = CanDoubleJump(); 
		//LogInternal("SingleJump _ VarbUpdating:" $ bUpdating); bDodging = false;
		canDJ = (!bUpdating && CanDoubleJump() && (Abs(Velocity.Z) < DoubleJumpThreshold) && IsLocallyControlled() ); 
		//LogInternal("CanDJ0000000000NormalJump:" $ canDJ) ;

		if ( !bUpdating ) PlayJumpingSound();
		return true; 
	}
	return false;
}

simulated function DoDoubleJump( bool bUpdating )
{
	local int iMode;
	local Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
	
	//LogInternal("FunctionCall: DoDoubleJump");
	//LogInternal("FunctionCall: DoDoubleJump - Input - bUpdating:" $ bUpdating);

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller)
	//foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller)
	//foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) //Get the AdminTool controller.	
	//foreach AllActors(class 'Rx_Mutator_AdminTool_Controller',myAdminTool_Controller)
	break;

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=12;	//DONT CHANGE - Used for Authentication Check	 //AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode]
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */
	
	if ( myAdminTool_Controller != None && !bIsCrouched && !bWantsToCrouch && myAdminTool_Controller.AdminToolAccessLevelAuth(myAdminTool_Controller.ModeAccessLevelArray[iMode]) && bool(myAdminTool_Controller.ModeStatusArray[iMode]) )
	{
		if ( !IsLocallyControlled() || AIController(Controller) != None )
		{
			MultiJumpRemaining -= 1;
		} 
		
		Velocity.Z = JumpZ + MultiJumpBoost; 
		//LogInternal("01010101110101DoneDid A Double Jump"); RX_InventoryManager(InvManager).OwnerEvent('MultiJump'); 
		SetPhysics(PHYS_Falling); BaseEyeHeight = DoubleJumpEyeHeight; 
		
		if (!bUpdating)
		{
			SoundGroupClass.Static.PlayDoubleJumpSound(self);
		} 
	}
	return;
}

function bool CanDoubleJump()
{
	//LogInternal("FunctionCall: CanDoubleJump");
	
	return ( (MultiJumpRemaining > 0) && (Physics == PHYS_Falling) && (bReadyToDoubleJump || (UTBot(Controller) != None)) );
}

function bool CanMultiJump()
{
	//LogInternal("FunctionCall: CanMultiJump");
	
	return ( MaxMultiJump > 0 );
}



/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode15  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//SlowTimeKills
/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode15  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/


		
/**************************************************************************************************************************************************************************************/
  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  DEFAULT PROPERTIES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

DefaultProperties
{
	//DoubleJump Variables
	MaxMultiJump=1				// default is 0
	MultiJumpRemaining=1		// default is 0
	JumpZ=320					// default is 320
	MultiJumpBoost=100
	MaxJumpHeight=100			// something less than 49
	MaxJumpZ=488.0
	
	
	
	//	DefGroundSpeed=465.0
	
    // Reference: SkeletalMeshComponent'Default__Rx_Pawn_Ext.ParachuteMeshComponent'
    //	ParachuteMesh=ParachuteMeshComponent
    //	bDodgeCapable=true
    //	
    //	SprintSpeed=600.0
    //	WalkingSpeed=100.0
    //	RunningSpeed=465.0
    //	LightEnvironment=DynamicLightEnvironmentComponent'Default__Rx_Pawn_Ext.MyLightEnvironment'
    //	DoubleJumpThreshold=120.0
    //	SuperHealthMax=300
    //	FallingDamageWaveForm=ForceFeedbackWaveform'Default__Rx_Pawn_Ext.ForceFeedbackWaveformFall'
    //	JumpBootCharge=1
    //	begin object name=GooDeath
    //	    ReplacementPrimitive=none
    //	object end
    //	// Reference: ParticleSystemComponent'Default__Rx_Pawn_Ext.GooDeath'
    //	BioBurnAway=GooDeath
    //	bCanDoubleJump=true
    //	bEnableFootPlacement=true
    //	MaxDoubleJumpHeight=500.0
    //	MultiJumpRemaining=1
    //	MaxMultiJump=1
    //	
    //	ArmsMesh=FirstPersonArms2
    //	bForceMaxAccel=true
    //	GroundSpeed=465.0
    //	WaterSpeed=280.0
    //	AccelRate=2500.0
    //	JumpZ=488.0
    //	OutofWaterZ=500.0
    //	MaxFallSpeed=100000000.0
  
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}