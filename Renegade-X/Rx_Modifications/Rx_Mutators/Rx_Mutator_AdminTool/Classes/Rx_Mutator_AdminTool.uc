// *****************************************************************************
//  * * * * * * * * * * * * Rx_Mutator_AdminTool * * * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool extends Rx_Mutator
	DependsOn (Rx_Mutator_AdminTool_Controller);

																						/* Some UseFull Notes */	
		//NOTE: is there a WorldInfo reference.
		//NOTE: if so, is that in an Actor, or in an Object?
		//NOTE: if it's in an Actor, just do foreach AllActors(...) ... 
		//NOTE: if it's in an Object, you could do class'WorldInfo'.static.GetWorldInfo()
		
		//NOTE: A very usefull function to change the default variable in classes.
		//NOTE:
		//NOTE: final static function object GetDefaultObject(class ObjClass)
		//NOTE: {
		//NOTE: 	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
		//NOTE: }
		
		//NOTE: some other ways to set variable's. 
		
		//NOTE: simulated function InitSomeClassNameController(optional bool bIsActor)
		//NOTE: {
		//NOTE: 	//if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'SomeClassName', SomeClassNameVariable) break; }
		//NOTE: 	//else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'SomeClassName', SomeClassNameVariable) break; }
		//NOTE: }
		
		//NOTE: simulated function InitAllSomeClassNameControllers(optional bool bIsActor)
		//NOTE: {
		//NOTE: 	//if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllControllers(class'SomeClassName', SomeClassNameVariable) break; }
		//NOTE: 	//else { foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'SomeClassName', allAdminTool_Controllers) break; }
		//NOTE: }

																						/* General (AdminTool) variables */


//var() Rx_Mutator_AdminTool_CrateType_Nuke myRx_Mutator_AdminTool_CrateType_Nuke;
//var Actor A;

function bool MutatorIsAllowed() //function bool MutatorIsAllowed() { return (WorldInfo.NetMode == NM_Standalone); }
{ 
	return UTTeamGame(WorldInfo.Game) != None && Super.MutatorIsAllowed();
	//return (WorldInfo.NetMode == NM_Standalone);
} 

simulated event PreBeginPlay()
{
	// Call the version of PreBeginPlay in the parent class (important).
	Super.PreBeginPlay();
	
	//The PreBeginPlay() event is the first script function called on the Actor after execution of the Actor's script has begin. 
	//Its name implies it is called before gameplay begins, which is the case if the Actor exists when the game starts up. 
	//If the Actor is spawned during play, this event is still called even though gameplay has already begun. 
	//Very specialized initialization could be performed here, but keep in mind that the Actor's components have not been initialized at this point,
	//and there is no reliable way to ensure that any external object has been initialized either.
	
	// Now do custom PreBeginPlay stuff.
	if ( !MutatorIsAllowed() )
	{
		Destroy();
	}
	
	SetTimer(2, false,'Init');
}

simulated function PostBeginPlay()
{
	// Call the version of PostBeginPlay in the parent class (important).
	Super.PostBeginPlay();
    
	// Start the timer so that fresh data is sent to clients
	
	//Init();
	//The PostBeginPlay() event is called after all other Actors have been initialized, via their PreBeginPlay() events. 
	//This event is generally used to initialize properties, find references to other Actors in the world, 
	//and perform any other general initialization. It is fair to consider this event the script equivalent of a constructor for Actors. 
	//Even so, there are still some things that require using specialized events available in the Actor to initialize. 
	//For instance, initialization having to do with animations and the AnimTree would best be performed in the PostInitAnimTree() event as that is called after the AnimTree is created and initialized. 
	//There are many such events provided for doing this type of specialized initialization. 
	//It is best to search for these first before adding specific initialization functionality to the PostBeginPlay() event.
	
	//foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', AC)
	//foreach AllActors(class 'Rx_Mutator_AdminTool_Controller',AC)
	//	break;
	
	// Now do custom PostBeginPlay stuff.
	//SetTimer(2, true,'Init');
	//foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller)
	//foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) //Get the AdminTool controller.
	
}


function bool CheckReplacement(Actor Other){

//	local bool bModeStatus;
//	local Actor A;

	if(Other.IsA('Rx_TeamInfo')) 
	{
						//Rx_Game(WorldInfo.Game).AutoTestManagerClass = class'Engine.AutoTestManager';
						//Rx_Game(WorldInfo.Game).AccessControlClass = class'Engine.AccessControl';
						//Rx_Game(WorldInfo.Game).AccessControlClass = class'Rx_AccessControl'
						//Rx_Game(WorldInfo.Game).BroadcastHandler = class'';

		Rx_Game(WorldInfo.Game).BroadcastHandlerClass = class'Rx_Mutator_AdminTool_BroadcastHandler';						//Rx_Game(WorldInfo.Game).BroadcastHandlerClass = class'Engine.BroadcastHandler'; //Rx_Game(WorldInfo.Game).BroadcastHandlerClass = class'Rx_BroadcastHandler'

						//Rx_Game(WorldInfo.Game).AccessControl = class'';
						//Rx_Game(WorldInfo.Game).CommanderControllerClass = class'Rx_CommanderController'
						//Rx_Game(WorldInfo.Game).DeathMessageClass = class'Rx_DeathMessage'		

		Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator_AdminTool_Pawn';										//Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Pawn'

						//Rx_Game(WorldInfo.Game).GameInterface = class'';
						//Rx_Game(WorldInfo.Game).GameMessageClass = class'';

		Rx_Game(WorldInfo.Game).GameReplicationInfoClass = class'Rx_Mutator_AdminTool_GRI';									//Rx_Game(WorldInfo.Game).GameReplicationInfoClass   = class'Rx_GRI'
		
		Rx_Game(WorldInfo.Game).HudClass = class'Rx_Mutator_AdminTool_HUD';													//Rx_Game(WorldInfo.Game).HudClass = = class'Rx_HUD'

						//Rx_Game(WorldInfo.Game).MyAutoTestManager = class'';
						//Rx_Game(WorldInfo.Game).ObjectiveReplicationClass  = class'Rx_Mutator_AdminTool_ORI'
						//Rx_Game(WorldInfo.Game).OnlineSub = class'';
						//Rx_Game(WorldInfo.Game).OnlineStatsWriteClass = class'';
						//Rx_Game(WorldInfo.Game).OnlineGameSettingsClass = class'';

		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminTool_Controller';								//Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Controller'

		Rx_Game(WorldInfo.Game).PlayerReplicationInfoClass = class'Rx_Mutator_AdminTool_PRI';								//Rx_Game(WorldInfo.Game).PlayerReplicationInfoClass = class'Rx_PRI'

						//Rx_Game(WorldInfo.Game).PurchaseSystemClass = class'Rx_PurchaseSystem'
						//Rx_Game(WorldInfo.Game).VehicleManagerClass = class'Rx_VehicleManager'
						//Rx_Game(WorldInfo.Game).VictoryMessageClass = class'Rx_VictoryMessage'
	}

	//if (other.isA('Rx_HUD_TargetingBox') && !other.isA('Rx_Mutator_AdminTool_HUD_TargetingBox')) {
	//	other.destroy();
	//}
	
	//if (other.isA('Rx_Building_AdvancedGuardTower') && !other.isA('Rx_Mutator_AdminTool_Building_AdvancedGuardTower')) {
	//	other.destroy();	
	//}
	
	//Rx_Game(WorldInfo.Game).bUndrivenVehicleDamage = true
	
	return true;
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
/* ReplaceWith()
 * Call this function to replace an actor Other with an actor of aClass.
 * @note: doesn't destroy the original; can return false from CheckReplacement() to do that
 */
function bool ReplaceWith(actor Other, string aClassName)
{
	local Actor A;
	local class<Actor> aClass;
	local PickupFactory OldFactory, NewFactory;

	if ( aClassName == "" )
		return true;

	aClass = class<Actor>(DynamicLoadObject(aClassName, class'Class'));
	if ( aClass != None )
	{
		A = Spawn(aClass,Other.Owner,,Other.Location, Other.Rotation);
		if (A != None)
		{
			OldFactory = PickupFactory(Other);
			NewFactory = PickupFactory(A);
			if (OldFactory != None && NewFactory != None)
			{
				OldFactory.ReplacementFactory = NewFactory;
				NewFactory.OriginalFactory = OldFactory;
			}
		}
	}
	return ( A != None );
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


function Init()					// A.IsA( name(BuildingNameArray[x])
{
	local Rx_Mutator_AdminTool_Game myRx_Mutator_AdminTool_Game;
	local Rx_Mutator_AdminTool_GameInfo myRx_Mutator_AdminTool_GameInfo;
	local Rx_Mutator_AdminTool_BuildingAttachment myRx_Mutator_AdminTool_BuildingAttachment;

	//	local Rx_Mutator_AdminTool_GameReplicationInfo myRx_Mutator_AdminTool_GameReplicationInfo;
	//	local Rx_Mutator_AdminTool_ORI myRx_Mutator_AdminTool_ORI;
	//	local Rx_Mutator_AdminTool_ReplicationInfo myRx_Mutator_AdminTool_ReplicationInfo;
	//	local Rx_Mutator_AdminTool_UTGameReplicationInfo myRx_Mutator_AdminTool_UTGameReplicationInfo;

	LogInternal("Rx_Mutator_AdminTool____ FunctionCall: Init");
	
	if ( class'Rx_Mutator_AdminTool_Game' != None && myRx_Mutator_AdminTool_Game == None) { myRx_Mutator_AdminTool_Game=spawn(class'Rx_Mutator_AdminTool_Game',self); }
	if ( class'Rx_Mutator_AdminTool_GameInfo' != None && myRx_Mutator_AdminTool_GameInfo == None) { myRx_Mutator_AdminTool_GameInfo=spawn(class'Rx_Mutator_AdminTool_GameInfo',self); }
	if ( class'Rx_Mutator_AdminTool_BuildingAttachment' != None && myRx_Mutator_AdminTool_BuildingAttachment == None) { myRx_Mutator_AdminTool_BuildingAttachment=spawn(class'Rx_Mutator_AdminTool_BuildingAttachment',self); }

	if (  myRx_Mutator_AdminTool_Game == None || myRx_Mutator_AdminTool_GameInfo == None || myRx_Mutator_AdminTool_BuildingAttachment == None )
	{
		LogInternal("Rx_Mutator_AdminTool____ FunctionCall: Init - myRx_Mutator_AdminTool_Game || myRx_Mutator_AdminTool_GameInfo, Not Found!!!");
		SetTimer(2, false,'Init');
	}
	return;
}

function InitMutator(string Options, out string ErrorMessage)
{
	if (Rx_Game(WorldInfo.Game) != None)
	{
		//SetTimer(0.5f, false, 'ChangePurchaseSystem' ) ;
	}
	Super.InitMutator(options, errorMessage);	
}

	
/*****************************************************************************/
//   *  //  *  //  *  //  *  //    Rcon  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/
//Rcon initialization

function InitRconCommands()
{
	// Call the version of InitMutator in the parent class (important).
	Super.InitRconCommands();
	
		LogInternal("Run InitRconCommands");

		(`RxEngineObject).AddRCONCommand(class'Rx_Rcon_Command_Team3');
}

/*****************************************************************************/
// *  //  *  //  *  //  *  // ModifyPlayer //  *  //  *  //  *  //  *  //  * //  
/*****************************************************************************/

function ModifyPlayer(Pawn Other)
{
	//We need to always check for accessed none errors.
	//This is saying "if the next mutator in the chain is not equal to none (if it exists),
	//then call modifyplayer() in that mutator, and pass the correct variable on to it.
	
	//When this function is called by the GameInfo class, it passes a variable into the "Other"
	//property of this function, this variable must be of type "Pawn".
	//So here we check that this "Other" is not equal to none, incase the player is destroyed/killed for some reason.
	//It's good practise to check things exist before you try to access or change them.
	
	if(Other != None)
	{
		//Now we can access the variables about the player like this
		//Other.SomeVariable = OurNewValue;
	}
	
	if ( NextMutator != None )
	{
		//This gives other mutators in the list, the chance to use this function.
		//if you don't give them this chance then the modifyplayer() chain will be broken and
		//any mutators that are added after this one will not be able to use this function.
		NextMutator.ModifyPlayer(Other);
	}
}



/*****************************************************************************/
//  *  //  *  //  *  //  *  //  Other  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/

//var Mutator NextMutator;								//

//function bool MutatorIsAllowed() { return (WorldInfo.NetMode == NM_Standalone); }
//function bool MutatorIsAllowed()
//{
//	return UTTeamGame(WorldInfo.Game) != None && Super.MutatorIsAllowed();
//} 

defaultproperties
{

}
