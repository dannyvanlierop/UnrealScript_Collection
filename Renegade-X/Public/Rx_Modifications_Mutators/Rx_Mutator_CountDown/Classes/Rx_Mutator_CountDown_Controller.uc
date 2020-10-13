// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_CountDown_Controller * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_CountDown_Controller extends Rx_Controller;

//General var


var string RefArrayName [6];						//ReferenceNameArray
var string RefArrayDescription [6];					//ReferenceDescriptionArray

var RepNotify string RefArrayStatus [6];			//ReferenceStatusArray
var RepNotify int RefArrayAccessLevel [6];			//ReferenceAccessLevelArray

var string RefArrayStatusClientSide [6];			//ReferenceStatusArray
var int RefArrayAccessLevelClientSide [6];			//ReferenceAccessLevelArray

var bool OSA;										//OneStepAuthentication
var int ArrayLength;
var bool DebugMode;

//Sandbox var
var array<Actor> SpawnedActors;

var int bHelpedTier;
var int bSpawnTier;
var bool bSpawnMode;
var string bClassName;





var int RepEventCounter;
var repnotify int Count;
var int mode;
var MaterialInstanceConstant	CounterTens, CounterOnes;
var name SecondClamp, TenSecondClamp;
var Rx_Mutator_CountDown_Controller CTRL;




replication
{
//	bNetDirty is true if any replicated properties have been changed by UnrealScript. 
//	This is used as an optimization (no need to check UnrealScript replication conditions, or to check whether properties which are only modified in script have been changed if bNetDirty is false). 
//	Don’t use bNetDirty to manage replication of frequently updated properties!
    if (bNetDirty && (Role==ROLE_Authority))
        RefArrayStatus,RefArrayAccessLevel,Count;
	//bNetOwner && bNetDirty && Role == ROLE_Authority
		
//	bNetInitial remains true until initial replication of all replicated Actor properties is complete.		
//	if (bNetInitial)
//		RefArrayStatus,RefArrayAccessLevel;

//	bNetOwner is true if the top owner of the Actor is the PlayerController owned by the current client.
}

/**
replication
{
	
	/Server->Client properties
	if ( bNetOwner && bNetDirty && Role == ROLE_Authority )
		CurrentAmmoInClip, PrimaryReloading, SecondaryReloading, 
			currentPrimaryReloadTime, currentSecondaryReloadTime;
}
*/

simulated event PreBeginPlay()
{
	if(ROLE == ROLE_Authority)
	{
		for (RepEventCounter = 0; RepEventCounter < ArrayLength ; RepEventCounter++)
		{
			RefArrayStatusClientSide[RepEventCounter]=RefArrayStatus[RepEventCounter];
		}
	}
}

simulated event ReplicatedEvent(name VarName)
{	
	if (VarName == 'Count') {
		Count=(Count);
	}
	else
	{
		super.ReplicatedEvent(VarName);
	}
}

exec function DoCountDown()
{
	ServerCountIt();
}

reliable server function ServerCountIt()
{			
	local Rx_Mutator_CountDown_Controller C;

		foreach WorldInfo.AllControllers(class'Rx_Mutator_CountDown_Controller', C)
		{
			C.Count=(Count);
			C.CountIt();
		}
}

simulated function CountIt()
{
	local int TimeSec, TimeTenSec;
	
	Count--;
	TimeSec = Count % 10;
	TimeTenSec = (Count / 10);
	CounterOnes.SetScalarParameterValue('SecondClamp', Float(TimeSec));
	CounterTens.SetScalarParameterValue('TenSecondClamp', Float(TimeTenSec));
	
	ClientMessage( " TimeTenSecTimeSec: " $ TimeTenSec $ TimeSec);
	SetTimer(2, false, 'ServerCountIt');
}


defaultproperties
{
//Replication
//bOnlyDirtyReplication=true;
//NetUpdateFrequency=8;
//RemoteRole=ROLE_SimulatedProxy
//NetPriority=+1.4
Count=180.0
//General	
//bNoDelete=true;
//bStatic=true;
}