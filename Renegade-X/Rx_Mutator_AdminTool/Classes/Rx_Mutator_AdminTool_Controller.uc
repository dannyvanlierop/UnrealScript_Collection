// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_AdminTool_Controller * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_Controller extends Rx_Controller
	//config (myAdminTool_Controller)
;
//class Rx_Mutator_AdminTool_Controller extends Rx_Controller Config(myAdminTool_Controller);

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
	//CustomTimeDilation=+1.0
	//CustomGravityScaling
																								/* General (AdminTool) variables */
var bool DebugMode;																				// Bool that will produces more Debug message when set to "True", default this one is set on false.
var int DebugLevel;																				//
var int iCurrentAccessLevel;																	//
																								//
																								/* Replication configuration variables */	// Global Counter
var repnotify int CounterGlobal;																// Time since level began game, is not affected by pause and time dilation, replicated.
var int CounterLocalDifference;																	// 
																								//
																								/* Replication configuration variables */	// Local counter
//var int AdminTaskCounter;																		// This will count the AdminTask cycles.
var int iLastAnnouncement;																		// Check if announcement did already find place
var int iAdminTaskTimerValue;																	//
																								//
																								/* Admintool Mode Array configuration variables */
var int ModeArrayLength;																		// Array index length
var string ModeNameArray [30];																	// Array to store all the "Mode"-Names				Static mode names. Simplyfied: mode1, mode2, mode3, etc..
var string ModeDescriptionArray [30];															// Array to store all the "Mode"-Description		Description about the mode in 1 word. Futuresoldier, Sandbox, NukeALll, etc...
var RepNotify string ModeStatusArray [30];														// Array to store all the "Mode"-Status				Status of the mode can be "true"(on)/"false"(off), but it is a string!!!(it represents if some mode is available by any user)
var RepNotify int ModeAccessLevelArray [30];													// Array to store all the "Mode"-AccessLevel		Who do have access to the mode, accesslevels are 1="None" 2="All Users", 3="Administrators", 4="Developers", 5="Administrators or Developers".
var int iAccessByPlayersVoteMenuExtension;														// Integer for 
var int iAccessByPlayersAdminToolMenu;															// Integer for 
var RepNotify int ModeAccessByPlayersArray [30];												// Array to store all the "Mode"-AccessByPlayers	Can players see the modes.
var RepNotify int ModeSchedulerTimerValueArray [30];											// Array to store all the "Mode"-TimerValue			Value of the timer
var string ModeStatusChoiceArray [3];															// Array to store all the "Mode"-StatusChoice		Enable, Disable, Toggle
																								//
var RepNotify string ModeAutoSetVoteValueArray[30];												// Array to store all the "Mode"-Status				Status of the mode can be "true"(on)/"false"(off), but it is a string!!!
var string ModeAutoSetDefaultValueArray[30];													// Array to store all the 
var RepNotify string ModeAutoSetCustomValueArray [30];											// Array to store all the 
var string ModeAutoSetMinValueArray[30];														// Array to store all the 
var string ModeAutoSetMaxValueArray[30];														// Array to store all the 
var string ModeAutoSetProcedureArray[30];														// Array to store all the 
var int ModeAutoSetTimerArray[30];																// Array to store all the 
																								//
																								/* Sandbox configuration variables */
var array<Actor> SpawnedActors;																	// Array to store all the Spawned actors.
var int iNextSpawnTime;
var int iSpawnWaitTime;																			// Integer that is responsable for the time between spawns.
var int iSpawnItemsAmount;																								//
																								/* Sandbox Variables to Probhit people typing wrong ClassNames */
var int ClassItemPreFixArrayLength;																// Integer for the ItemPrefix array length.
var int ClassItemNameArrayLength;																// Integer for the ItemName array length.
var int ClassItemDescriptionArrayLength;														// Integer for the ItemDescription array length.
var string SandboxItemPreFixArray[6];															// Array to store all SandboxItem PreFix's.
var string SandboxItemNameArray[42];															// Array to store all SandboxItem Name's.
var string SandboxItemDescriptionArray[42];														// Array to store all SandboxItem Description's.
																								//
																								/* GimmeWeapon */
var string GimmeWeaponItemNameArray[46];														// Array to store all the "Weapon"-Names.
																								//
																								/* GimmeSkin */
var string team;																				//
var string SkinItemNameArray[33];																// Array to store all the "Skin"-Names.
var SkeletalMesh SkinMeshNameArray[33];															// Array to store all the "Mesh"-Names.
										
																								/* VoteMenu */
//var Rx_VoteMenuHandler VoteHandler;															//	
var Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic Handler;                                     //
var Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic VoteMenuHandler_Ext_Basic;                   //
                                                                                                //
//var Rx_VoteMenuChoice VoteChoice;                                                             //
var Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic VoteChoice;                                   //
var Rx_Mutator_AdminTool_VoteMenuHandler_Ext_AdminTool VoteMenuHandler_Ext_AdminTool;           //
                                                                                                //
var Rx_Mutator_AdminTool_Controller myAdminTool_Controller;                                     //
                                                                                                //
var int iColumnNumber;                                                                          // Integer for 
var int ScreenSizeX;		                                                                    // Integer for 
var int ScreenSizeY;                                                                            // Integer for 
var string AdminToolCommandText;	                                                            // string for
var bool bAdminToolMenuEnabled;                                                                 // Bool that
var bool bMenuUnlocked;                                                                         // Bool that
var string sSelectedMode;                                                                       // string for
                                                                                                //
																								/* Key-Input */
var bool bKeyLeftPressed;																		// Bool for
var bool bKeyRightPressed;                                                                      // Bool for
var bool bKeyUpPressed;                                                                         // Bool for
var bool bKeyDownPressed;                                                                       // Bool for
//var bool bKeyCPressed;                                                                        //
																								/* UkillSendText */
var string sUkillSendTextText;																	// string for
var int iUkillSendTextColor;                                                                    // Integer for 
var int iUkillSendTextCount;                                                                    // Integer for 
var int iUkillSendTextRepeat;                                                                   // Integer for 
var int iUkillSendTextTime;                                                                     // Integer for 
var float fUkillSendTextDelay;                                                                  // float for
var float fUkillSendTextSize;                                                                   // float for

var string BuildingNameArray[24];
var string BuildingNameAliasArray[24];
var string BuildingHealthLockedArray[24];

var int iHarvestProcess;

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  Init  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
simulated event PreBeginPlay(){
	
	local Rx_Mutator_AdminTool_Controller C;
	local int x;
	
	LogInternal("Rx_Mutator_AdminTool_Controller FunctionCall: PreBeginPlay");
	
	//		Super.PreBeginPlay();
	//		 When removing this value all players will be reset when a new player joins the game.
	//		SetTimer( WorldInfo.TimeDilation , true, 'ReplicateModeInformation');
	
	//		Simulated :
	//		Marks the function as valid for execution on clients if the actor containing it was replicated to that client and the local role of that client is either ROLE_SimulatedProxy or ROLE_DumbProxy.
	//		Note: The modifier simulated does not imply any kind of replication or even broadcast! Also, 
	//		this modifier is not inherited when overriding functions - every super function call evaluates that super function's simulated modifier separately, 
	//		potentially breaking the chain of super calls on clients!
	//		The keyword simulated is used as a modifier for functions and states whose code should be executable even if the context object is an Actor with Role <= ROLE_SimulatedProxy

	LogInternal("Rx_Mutator_AdminTool_Controller FunctionCall: ServerInit");
	
	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
	{
		for (x = 0; x < ModeArrayLength ; x++)
		{
			ModeNameArray[x] = C.ModeNameArray[x];
			ModeDescriptionArray[x] = C.ModeDescriptionArray[x];
			ModeStatusArray[x] = C.ModeStatusArray[x];
			ModeAccessLevelArray[x] = C.ModeAccessLevelArray[x];
			ModeAccessByPlayersArray[x] = C.ModeAccessByPlayersArray[x];
			ModeSchedulerTimerValueArray[x] = C.ModeSchedulerTimerValueArray[x];
			ModeAutoSetVoteValueArray[x] = C.ModeAutoSetVoteValueArray[x];
			ModeAutoSetDefaultValueArray[x] = C.ModeAutoSetDefaultValueArray[x];
			ModeAutoSetCustomValueArray[x] = C.ModeAutoSetCustomValueArray[x];
			ModeAutoSetMinValueArray[x] = C.ModeAutoSetMinValueArray[x];
			ModeAutoSetMaxValueArray[x] = C.ModeAutoSetMaxValueArray[x];
			ModeAutoSetProcedureArray[x] = C.ModeAutoSetProcedureArray[x];
			ModeAutoSetTimerArray[x] = C.ModeAutoSetTimerArray[x];
			BuildingNameArray[x] = C.BuildingNameArray[x];
			BuildingNameAliasArray[x] = C.BuildingNameAliasArray[x];
			BuildingHealthLockedArray[x] =	C.BuildingHealthLockedArray[x];
			
		}
	}
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_Controller FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

	CounterLocalDifference = WorldInfo.RealTimeSeconds;					//Save the Global counter difference when the player join the game for the first time, also usefull to create a local timervalue
	LogInternal("Rx_Mutator_AdminTool_Controller PostBeginPlay: Set CounterLocalDifference - Player joined " $ CounterLocalDifference $ " seconds after game started");
	
	CounterServer();
}
	
/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  REPLICATION  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
replication{
	// Server->Client properties
    if ( bNetDirty && (Role == ROLE_Authority))
        CounterGlobal,ModeAccessByPlayersArray,ModeAccessLevelArray,ModeSchedulerTimerValueArray,ModeAutoSetCustomValueArray,ModeAutoSetVoteValueArray,ModeStatusArray,iAccessByPlayersVoteMenuExtension,iAccessByPlayersAdminToolMenu;

	// Client->Server properties
	// if ( bNetDirty && (Role < ROLE_Authority))
	
	//ROLE_None 			No role at all.
	//ROLE_SimulatedProxy 	Locally simulated proxy of this actor.
	//ROLE_AutonomousProxy	Locally autonomous proxy of this actor.
	//ROLE_Authority		Authoritative control over the actor.

	//bNetDirty is true if any replicated properties have been changed by UnrealScript, don’t use bNetDirty to manage replication of frequently updated properties!
	//bNetInitial remains true until initial replication of all replicated Actor properties is complete.		
	//bNetOwner is true if the top owner of the Actor is the PlayerController owned by the current client.
}
simulated event ReplicatedDataBinding ( name VarName ){
	//Called when a variable is replicated that has the 'databinding' keyword. 
	//@param	VarName	the name of the variable that was replicated.
}
simulated event ReplicatedEvent(name VarName){							//Called when a variable with the property flag "RepNotify" is replicated	//server variables/ ClientStuff

																		//LogInternal("FunctionCall: ReplicatedEvent - VarName: " $ VarName );
	
	if ( VarName == 'CounterGlobal' ) {	; }								//LogInternal("FunctionCall: ReplicatedEvent - " $ VarName $ "CounterGlobal: " $ CounterGlobal );
	else if ( VarName == 'iAccessByPlayersVoteMenuExtension' ){ ; }		//LogInternal("FunctionCall: ReplicatedEvent - " $ VarName $ "CounterGlobal: " $ CounterGlobal );
	else if ( VarName == 'iAccessByPlayersAdminToolMenu' ) { ; }		//LogInternal("FunctionCall: ReplicatedEvent - " $ VarName $ "CounterGlobal: " $ CounterGlobal );
	else if (VarName == 'ModeStatusArray' || VarName == 'ModeAccessLevelArray' || VarName == 'ModeAccessByPlayersArray' || VarName == 'ModeSchedulerTimerValueArray' || VarName == 'ModeAutoSetVoteValueArray' || VarName == 'ModeAutoSetCustomValueArray' ){ ; }
	else { super.ReplicatedEvent(VarName); }
}
/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  Events  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
event LocalPlayer GetLP(optional LocalPlayer LocPlay){

	/**
	* Helper function to get the owning local player for actor
	*
	* @return The LocalPlayer corresponding to the LocalPlayerOwnerIndex that owns this actor
	*/
 
	local Engine Eng;
	local int LocalPlayerOwnerIndex;
	
	LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocPlay);
	if(LocalPlayerOwnerIndex == INDEX_NONE)
	{
		LocalPlayerOwnerIndex = 0;
	}

	Eng = class'Engine'.static.GetEngine();

	//If it is an INDEX_NONE, try the default player
	if (LocalPlayerOwnerIndex < 0)
	{
		LocalPlayerOwnerIndex = 0;
	}
	//If it is completely invalid return none
	else if  (LocalPlayerOwnerIndex >= Eng.GamePlayers.Length)
	{
		return none;
	}
	return  Eng.GamePlayers[LocalPlayerOwnerIndex];
}
event PlayerController GetPC(){

	/**
	* Helper function to get the owning player controller for this actor
	*
	* @return The PlayerController corresponding to the LocalPlayerOwnerIndex that owns this actor
	*/
 
	local LocalPlayer LocalPlayerOwner;

	LocalPlayerOwner = GetLP();
	if (LocalPlayerOwner == none)
	{
		return none;
	}
	return LocalPlayerOwner.Actor;
}

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  Counter  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
reliable server function CounterServer(){

	local int iCounterLocal;
	local int iElapsedTime;

	local GameReplicationInfo myGameReplicationInfo;
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'GameReplicationInfo',myGameReplicationInfo)
	{
		iElapsedTime = myGameReplicationInfo.ElapsedTime;									//Save & Lock ElapsedTime in iElapsedTime
		break;
	}

	if ( CounterGlobal == iElapsedTime )
	{
		SetTimer( 0.1, false, 'CounterServer');												//Reset when counter dont need an update yet
		return;
	}

	if ( CounterGlobal !=  iElapsedTime )
	{
		if ( ( iElapsedTime - CounterGlobal ) > 1 )
		{
																							//LogInternal("FunctionCall: CounterServer (" $ CounterGlobal - CounterLocalDifference $ ") - Too Late!!");
		}
		CounterGlobal = iElapsedTime;
		iCounterLocal = CounterGlobal - CounterLocalDifference;
		iCurrentAccessLevel = AdminToolAccessLevelAuthCheckLevel();
		//ServerInit();
		
		if ( iCounterLocal != 99991 )														//99991 is set for modes that only need one time activation
		{																					//LogInternal("FunctionCall: CounterServer (" $ CounterGlobal - CounterLocalDifference $ ") - Run AdminTask");
			AdmintTask();																	//Counter is updated, check if there are tasks to run
			//AdmintTaskSetServer();
			//CheckHarvesterServer();
		}
		
		Announcement(iCounterLocal,iCurrentAccessLevel);

		SetTimer( 1, false, 'CounterServer');
		return;
	}
	
	return;
}

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  Announcement  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
reliable client function Announcement(int iCounterLocal, int iAccessLevel){

	local array<int> iAccessType;															// 1 = timed, 2 = All User, 3 = Special Permission
	local array<bool> bDoAnnounceMode;
	local int x,iAnnouncementCounter;
	local string str1;

	if ( iLastAnnouncement == iCounterLocal )
	{
		return;
	}
																							//LogInternal("FunctionCall: Announcement - iCounterLocal: " $ iCounterLocal $ " iAccessLevel: " $ iAccessLevel);
	if ( iCounterLocal == 10 )
	{																						//LogInternal("FunctionCall: Announcement - " $ CounterGlobal - CounterLocalDifference $ " Main");
		CTextMessage("This is a modified Renengade-X server running Ukill's AdminTool",'Blue',300,1.1);
	}

	if ( iCounterLocal == 10 || iCounterLocal % 300 == 0 )
	{
		for ( x = 1; x < ModeArrayLength; x++)
		{																					
			if ( ( ModeSchedulerTimerValueArray[x] > 0 ) || ( ModeStatusArray[x] ~= "true" && 2 == ModeAccessLevelArray[x] ) )
			{																				// if timer is set for mode || if mode is enabled and access is all users
				bDoAnnounceMode[x] = true;													
				iAccessType[x] = 1;															//LogInternal("FunctionCall: Announcement - " $bDoAnnounceMode[x] $ " - " $ CounterGlobal - CounterLocalDifference $ " enabled and access is all users " $ x); }
			}
			
			if ( iAccessLevel != 2 && ModeStatusArray[x] ~= "true" && iAccessLevel == ModeAccessLevelArray[x] )	// if mode is enabled and access is same as userlevel
			{																				//LogInternal("FunctionCall: Announcement - " $bDoAnnounceMode[x] $ " - " $ CounterGlobal - CounterLocalDifference $ " enabled and access is same as userlvel " $ x);
				bDoAnnounceMode[x] = true;
				iAccessType[x] = iAccessLevel;
			}
			
			if ( ModeDescriptionArray[x] ~= "Empty" )										// disable listing empty modes			
			{																				//LogInternal("FunctionCall: Announcement - " $bDoAnnounceMode[x] $ " - " $ CounterGlobal - CounterLocalDifference $ " disable listing empty modes " $ x);
				bDoAnnounceMode[x] = false;
				iAccessType[x] = 0;
			}
		}

		for ( x = 1; x < ModeArrayLength; x++)
		{
			if ( bDoAnnounceMode[x] )
			{
				iAnnouncementCounter++;
			}
		}
		
		if ( iAnnouncementCounter > 0 )
		{
			CTextMessage("Info: " $ iAnnouncementCounter $ " modes are enabled",'White', 200, 0.8);
		}
		
		if ( iAnnouncementCounter < 3 )
		{
			for ( x = 1; x < ModeArrayLength; x++)
			{
				if ( bDoAnnounceMode[x] )
				{
					str1 = "Mode" $ x $ " - " $ ModeDescriptionArray[x] $ " is enabled ";	
					
					switch ( iAccessType[x] )
					{
						case 1:
							str1 = str1 $ "Timed/Automatic"; break;
						case 2:
							str1 = str1 $ "for All Users"; break;
						case 3:
							str1 = str1 $ "for Administrators"; break;
						case 4:
							str1 = str1 $ "for Developers"; break;
					}
					
					CTextMessage(str1 ,'Green', 250, 0.75);
				}
			}
		}
		else
		{
			CTextMessage("view the admintool menu ( Ctrl+X ) for details" ,'Green', 200, 0.75);
		}
	}
}



//exec function ShowBuildingStatus(optional bool bServer)
//{
//	ShowBuildingStatusServer();
//}
//
//reliable server function ShowBuildingStatusServer()
//{
//	local Rx_Mutator_AdminTool_Controller C;
//	local Actor A;
//	local int x;
//
//	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C) 
//	{
//		foreach AllActors(class'Actor', A)
//		{
//			for (x = 0; x < ArrayCount(BuildingNameArray); x++)
//			{
//				if ( A.IsA( name(BuildingNameArray[x]) ) )
//				{
//					ClientMessage("Server: " $ BuildingNameArray[x] $ "  " $ Rx_Building_Team_Internals(A).HealthLocked );
//	
//					if ( Rx_Building_Team_Internals(A).HealthLocked == true )
//					{
//						C.BuildingHealthLockedArray[x] = "true";
//					}
//					else
//					{
//						C.BuildingHealthLockedArray[x] = "false";
//					}
//				}
//			}
//		}
//	}
//}
//
//exec function ShowBuildingStatus2(optional bool bServer)
//{
//	ShowBuildingStatusServer2();
//}
//
//reliable server function ShowBuildingStatusServer2()
//{
//	local int x;
//
//	for (x = 0; x < ArrayCount(BuildingNameArray); x++)
//	{
//		ClientMessage("LokaalArray: " $ BuildingHealthLockedArray[x] );
//	}
//}

exec function GetBuildingLockStatus(int i)
{
	GetBuildingLockStatusServer(i);
}

reliable server function string GetBuildingLockStatusServer(int i)
{
	local Rx_Mutator_AdminTool_Controller C;

	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C) 
	{
		return C.BuildingHealthLockedArray[i];
	}
}





/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  AdmintTask  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
function AdmintTask(){

	if ( iAdminTaskTimerValue != 0 )
	{
		AdmintTaskSetServer();
	}	
}
reliable server function AdmintTaskSetServer(optional int iModeSet, optional int iTypeSet){

	local string str;
	local int x;

	//iModeSet	// 0 = AdminTaskValue (SetCustomValue)	// 1 = SetByVote (SetVoteValue)	// 2 = Reset to default (SetDefaultValue)
	
	for (x = 1; x < ModeArrayLength ; x++)
	{
		
		if ( iModeSet > 0 ) { x=iModeSet; }
		
		if  ( ( ( ModeSchedulerTimerValueArray[x] > 0 ) &&  bool(ModeStatusArray[x]) && ( ( CounterGlobal - CounterLocalDifference ) % ModeSchedulerTimerValueArray[x] ) == 0 ) || ( iModeSet > 0 ) )
		{
			if ( iTypeSet == 1)
			{ 
				//Set (SetCustomValue) to (SetVoteValue) so AdminTask keeps setting this value
				ModeAutoSetCustomValueArray[x] = ModeAutoSetVoteValueArray[x];
				str=ModeAutoSetVoteValueArray[x];
				
				LogInternal( "AdminTask(" $ ( CounterGlobal - CounterLocalDifference ) $ "): " $ ModeDescriptionArray[x] $ " - Set VoteValue:" $ ModeAutoSetVoteValueArray[x] $ " By task");
			}
			else if ( iTypeSet == 2)
			{
				str=ModeAutoSetDefaultValueArray[x];
				LogInternal( "AdminTask(" $ ( CounterGlobal - CounterLocalDifference ) $ "): " $ ModeDescriptionArray[x] $ " - Set DefaultValue:" $ ModeAutoSetDefaultValueArray[x] $ " By task");
			}

			//99991 is set for modes that only need one time activation
			else if ( ModeSchedulerTimerValueArray[x] != 99991 && ModeSchedulerTimerValueArray[x] > 0 )
			{
				str=ModeAutoSetCustomValueArray[x];
				LogInternal( "AdminTask(" $ ( CounterGlobal - CounterLocalDifference ) $ "): " $ ModeDescriptionArray[x] $ " - Set CustomValue:" $ ModeAutoSetCustomValueArray[x] $ " By task");
			}

			switch( x )
			{
				case 1:
					GimmeSpawnServer(str);
					if (ModeStatusArray[x] ~= "false")
					{
						GimmeSpawnKillAllServer();
					}					
					break;
				case 2:
					ServerGimme(str,true); break;
				case 3:
					GimmeSkinServer(int(str),true,true); break;
				case 4:
					InfiniteAmmo(bool(str)); break;
				case 5:
					NormalizeHealth(int(str),false); break;   ///sting convert to 1
				case 6:
					FriendlyFireSetServer(float(str),true,true); break;
				case 7:
					break;
				case 8:
					break;
				case 9:
					GimmeSkinServer(int(str),true,true); break;
				case 10:
					LockBuildingsServer(bool(str),true,true); break;
				case 11:
					break;
				case 13:
					GravitySetServer(float(str),true,true);	break;
				case 14:
					GameSpeedSetServer(float(str),true,true); break;
				case 15:
					break;
				case 16:
					SuddenDeathServer(bool(str),true,true); break;
				case 17:
					VeterancySetServer(int(str),true,true); break;
				case 18:
					GodModeServer(str,true,true); break;
				case 19:
					InvisibleModeServer(str,true,true); break;
				case 20:
					GhostModeServer(str,true,true); break;
				case 21:
					AmphibiousModeServer(str,true,true); break;
				case 22:
					FlyModeServer(str,true,true); break;
				case 23:
					break;
				case 24:
					UkillSoundShowServer(int(str),true,true); break;
					break;
				case 25:
					break;
				case 26:
					break;
				case 27:
					break;
				case 28:
					break;
				case 29:
					break;
				case 30:
					break;
			}


			//Reset timer when a repeat is not wanted
			if ( Mid(ModeAutoSetProcedureArray[x],0,1) == "0" )
			{
				LogInternal("FunctionCall: AdmintTaskSetServer - Reset timer: " $ ModeDescriptionArray[x]);
				ModeSchedulerTimerValueArray[x]=0;
			}

			if ( iTypeSet == 1)
			{
				CTextMessage( ModeDescriptionArray[x] $" is enabled",'Green',200);
				//ClientPlaySound(SoundCue'rx_ukill.robsounds.Ba_Dum_Tss_Cue');
			}
			else if ( iTypeSet == 2)
			{
				CTextMessage( ModeDescriptionArray[x] $" is disabled set and to default",'green',200);
			}
			
			
			//Do only set one mode
			if ( iModeSet > 0 )
			{
				iModeSet = 0;
				x=ModeArrayLength;
			}
		}
	}
}	

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  AdminTool  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
exec function AdminTool(string sToggleName, optional string sStatus, optional string iAccessLevel){

	AdminToolServer(sToggleName,sStatus,iAccessLevel);

}
reliable server function AdminToolServer (string sToggleName, optional string sStatus, optional string iAccessLevel, optional bool bSkipAuthentication){

	local Rx_Mutator_AdminTool_Controller C;
	local int x,y;
	local string sStatusOut,iAccessLevelOut,sLogString;

	
	sLogString = "FunctionCall: AdminToolServer - ";
	
	if ( sToggleName != "" ) { sLogString = sLogString $ "Parameters: " $ sToggleName; }
	if ( sStatus != "" ) { sLogString = sLogString $ " " $ sStatus; }
	if ( iAccessLevel != "" ) { sLogString = sLogString $ " " $ iAccessLevel; }

	LogInternal( sLogString $ " by " $ (PlayerReplicationInfo.PlayerName) );
	
	if ( PlayerReplicationInfo.bAdmin || bSkipAuthentication )
	{
	
	}
	else
	{
		LogInternal( sLogString $ "  by  " $ (PlayerReplicationInfo.PlayerName) $ " FAILED!!" );
		return;
	}
	
	//Covert all strings to lowercase
	sStatus=Locs(sStatus); sToggleName=Locs(sToggleName); iAccessLevel=Locs(iAccessLevel);

	if ( sToggleName == "setall" ) 
	{
		if ( sStatus ~= "setall" ) { return; };  //Prevent endless loops

		for (x = 1; x < ModeArrayLength ; x++)
		{
			AdminToolServer( ModeNameArray[x], sStatus, iAccessLevel);
			LogInternal( "SetAll - " $ ModeNameArray[x] $ " " $ sStatus $ " " $ iAccessLevel  );
		}
	}
	else if (	sStatus == "status" ||
				sStatus == "setstatus" ||
				sStatus == "access" ||
				sStatus == "accesslevel" ||
				sStatus == "setaccesslevel" ||
				//	sStatus == "visible" ||
				sStatus == "setvisible" ||
				//	sStatus == "hidden" ||
				sStatus == "sethidden" ||
				sStatus == "timer" ||
				sStatus == "settimer" ||
				sStatus == "default" ||
				sStatus == "setdefault" ||
				sStatus == "custom" ||
				sStatus == "setcustom" ||
				sStatus == "vote" ||
				sStatus == "setvote" ||
				sStatus == "min" ||
				sStatus == "setmin" ||
				sStatus == "max" ||
				sStatus == "setmax" ||
				sStatus == "on" ||
				sStatus == "true" && Mid(sToggleName,0,4) != "mode" ||
				sStatus == "off" ||
				sStatus == "false" && Mid(sToggleName,0,4) != "mode" )
	{	
		for (x = 1; x < ModeArrayLength ; x++)
		{
			if( sToggleName ~= ModeNameArray[x] )
			{
				foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C) 
				{
					switch (sStatus)
					{
						case "on":
						case "true": 
											C.ModeStatusArray[0]="true"; break;
						case "off":							
						case "false":
											C.ModeStatusArray[0]="false"; break;
						case "votemenu":
											if (sStatus ~= "visible") { sStatus = "1"; } else { sStatus = "0"; }; C.iAccessByPlayersVoteMenuExtension = int(sStatus);
						case "adminmenu":
											if (sStatus ~= "visible") { sStatus = "1"; } else { sStatus = "0"; }; C.iAccessByPlayersAdminToolMenu =  int(sStatus); break;
						case "info":
											break;
						case "status":
						case "setstatus":
											C.ModeStatusArray[x] = (iAccessLevel); break;							
						case "visible":							
						case "setvisible":
											C.ModeAccessByPlayersArray[x] = 1; break;
						case "hidden":							
						case "sethidden":
											C.ModeAccessByPlayersArray[x] = 0; break;
						case "access":	
						case "accesslevel":							
						case "setaccesslevel":
											C.ModeAccessLevelArray[x] = int(iAccessLevel); break;
						case "timer":							
						case "settimer":
											C.ModeSchedulerTimerValueArray[x] = int(iAccessLevel); break;
						case "default":							
						case "setdefault":
											C.ModeAutoSetDefaultValueArray[x] = (iAccessLevel); break;
						case "custom":							
						case "setcustom":
											C.ModeAutoSetCustomValueArray[x] = (iAccessLevel); break;
						case "vote":							
						case "setvote":
											C.ModeAutoSetVoteValueArray[x] = (iAccessLevel); break;
						case "min":							
						case "setmin":
											C.ModeAutoSetMinValueArray[x] = (iAccessLevel); break;
						case "max":
						case "setmax":
											C.ModeAutoSetMaxValueArray[x] = (iAccessLevel); break;
						default:
											break;
					}
				}
			}
		}
	}
	else	// Cleanup Later Cleanup Later Cleanup Later Cleanup Later Cleanup Later Cleanup Later Cleanup Later Cleanup Later
	{
		for (x = 0; x < ModeArrayLength ; x++)
		{
			if (ModeNameArray[x] != sToggleName) 
			{
				y=y++;
				if (y == ModeArrayLength) 
				{
					sToggleName="";
					sStatus="";
					iAccessLevel="";
	
					return;
				}
			}
		}
	
		if ( Len(sStatus) == 1 && Len(iAccessLevel) == 0 )
		{
			iAccessLevel=(sStatus);
			sStatus="Skip";
		}
		else if ( Len(iAccessLevel) > Len(sStatus) && ( iAccessLevel == "true" || iAccessLevel == "false" )  )
		{
			sStatusOut=(iAccessLevel);
			(iAccessLevelOut)=(sStatus);
			iAccessLevel=(iAccessLevelOut);
			sStatus=(sStatusOut);
		}
	
		if ( Len(iAccessLevel) == 0 && Len(sStatus) == 0 || "true" == sStatus || "false" == sStatus )
		{
			LogInternal("FunctionCall: AdminTool - Run - Set sToggleName:" $ sToggleName $ " sStatus:" $ sStatus );
			AdminToolServer(sToggleName, "setstatus", sStatus);
		}
	
		if ( Len(iAccessLevel) == 1 && int(iAccessLevel) != 0 && int(iAccessLevel) > 0 && int(iAccessLevel) < 6)
		{
			LogInternal("FunctionCall: AdminTool - Run - Set sToggleName:" $ sToggleName $ " sStatus:" $ sStatus );
			AdminToolServer(sToggleName, "setaccesslevel", iAccessLevel);
		}
		
		if (sStatus ~= "visible" || sStatus ~= "hidden")
		{
			if (sStatus ~= "visible")
			{
				AdminToolServer(sToggleName,"setvisible");
			}
			else
			{
				AdminToolServer(sToggleName,"sethidden");
			}
		}
	}
	return;
}

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  Authentication  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/
reliable server function int AdminToolAccessLevelAuthCheckLevel(){

	local int iMaxLevelAccepted;
	local int x;

	if ( bool(ModeStatusArray[0]) )
	{
		for (x = 1; x <= 4 ; x++)
		{
			if (AdminToolAccessLevelAuth(x))
			{
				iMaxLevelAccepted=(x);
			}
		}
		return iMaxLevelAccepted;
	}
}
reliable server function bool AdminToolAccessLevelAuth(int iAccessLevel, optional bool bSkipAuthentication){
	
	if ( WorldInfo.NetMode == NM_Standalone || bSkipAuthentication )	// a botmatch or single player game, no authentiaction needed
	{
		return true;
	}
	else if ( bool(ModeStatusArray[0]) )
	{
		//PlayerReplicationInfo.PlayerName != ""
		switch (iAccessLevel)
		{
			case 1: if (PlayerReplicationInfo.PlayerName == "" && !bIsPlayer) return true; break;
			case 2: if (PlayerReplicationInfo.PlayerName != "") return true; break;			
			case 3:	if (PlayerReplicationInfo.bAdmin && PlayerReplicationInfo.PlayerName != "") return true; break;			
			case 4: if (PlayerReplicationInfo.PlayerName != "" && bIsDev) return true; break;			
			case 5:	if (PlayerReplicationInfo.bAdmin || bIsDev) return true; break;
			case 0: break;
		}
	}
	return false;
}
reliable server function string AdminToolAccessLevelAuthCheckName(optional int iReturnLevelName){

	local int iMaxLevelAccepted;
	local string iMaxLevelAcceptedName;
	local int x;

	if ( bool(ModeStatusArray[0]) )
	{
		if (iReturnLevelName < 1)
		{
			for (x = 1; x <= 4 ; x++)
			{
				if (AdminToolAccessLevelAuth(x))
				{
					iMaxLevelAccepted=(x);
				}
			}
		}
		else
		{
			iMaxLevelAccepted=(iReturnLevelName);
		}

		switch (iMaxLevelAccepted)
		{
			case 1: iMaxLevelAcceptedName="None"; break;
			case 2: iMaxLevelAcceptedName="Player"; break;
			case 3: iMaxLevelAcceptedName="Administrator"; break;
			case 4: iMaxLevelAcceptedName="Developer"; break;
		}
		return iMaxLevelAcceptedName;
	}
}








/**************************************************************************************************************************************************************************************/
//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  MODE DEFINITIONS //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

//a mode that wont be used, it will need admin rights or a local (bot)match.
/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode0   //  *  //  *  //  *  //  *  //  *  //
/*****************************************************************************/
exec function UkillChange(string sSetting, optional string sValue, optional string sBuildingName){

	if  (sValue ~= "help")
	{
		ClientMessage("Options: MineLimit, VehicleLimit, GoalScore, TimeLimit, bMatchHasBegun, bMatchIsOver, ServerName, RemainingMinute, RemainingTime, ElapsedTime");
		ClientMessage("StopCountDown, CreditsSilo, CreditsRefinery, AirdropCooldownTime, Health, HealthLocked, HealthMax, BA_HealthMax, TrueHealthMax, Armor");
		ClientMessage("LowHPWarnLevel, RepairedHPLevel, RepairedArmorLevel, SavedDmg, HealPointsScale, HDamagePointsScale, ADamagePointsScale, Destroyed_Score");
		ClientMessage("ArmorResetTime, bCanArmorBreak, bDestroyed, bBuildingRecoverable, bCanPlayRepaired");
	}
	else
	{
		UkillChangeServer(sSetting,sValue,sBuildingName);
	}
}
reliable server function UkillChangeServer(string sSetting, optional string sValue, optional string sBuildingName){

	local Actor A;

	local Rx_Game myRx_Game;
	local Rx_TeamInfo myRx_TeamInfo;
	local GameReplicationInfo myGameReplicationInfo;

	local Rx_Building_Refinery Refinery;
	local Rx_Building_Silo_Internals Silo;
	local Rx_PurchaseSystem PurchaseSystem;

	
	local string sOldValue;
	local bool bFailed,bBuildingNameInserted;
	local int i,x;
	
	//local Rx_Building_Team_Internals BuildingInternals;
	//local WorldInfo ThisWorld;
	//local UTMapInfo myUTMapInfo;
	//local Rx_MapInfo myRx_MapInfo;
	
	if ( !PlayerReplicationInfo.bAdmin)
	{
		LogInternal( "FunctionCall UkillChangeServer - by  " $ (PlayerReplicationInfo.PlayerName) $ " FAILED!!" );
		return;
	}
	
	//Covert all strings to lowercase
	sSetting=Locs(sSetting); sValue=Locs(sValue); sBuildingName=Locs(sBuildingName);
		
	//ThisWorld = GetPC().WorldInfo; //myRx_MapInfo = Rx_MapInfo(ThisWorld.GetMapInfo()); //myUTMapInfo = UTMapInfo(WorldInfo.GetMapInfo()); //myRx_MapInfo = Rx_MapInfo(WorldInfo.GetMapInfo());
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_TeamInfo',myRx_TeamInfo) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Game',myRx_Game) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'GameReplicationInfo',myGameReplicationInfo) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Building_Refinery',Refinery) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Building_Silo_Internals',Silo) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_PurchaseSystem',PurchaseSystem) break;
	
	LogInternal( "FunctionCall UkillChangeServer - ArrayCount(BuildingNameArray) " $ ArrayCount(BuildingNameArray) );

	//Check if a correct buildingname is inserted
	bBuildingNameInserted = false;
	for (i = 0; i < ArrayCount(BuildingNameArray); i++)
	{
		if ( sBuildingName == BuildingNameArray[i] || InStr( BuildingNameAliasArray[i], sBuildingName) >= 0 )
		{
			x=i;
			bBuildingNameInserted = true;
			LogInternal( x $ ": " $ BuildingNameArray[i] $ " Found!!! ");
			break;
		}
	}
	
	if (bBuildingNameInserted)
	{
		foreach AllActors(class'Actor', A)
		{
			//Filter if buildingname is inserted, otherwise dont.
			if ( A.IsA( name(BuildingNameArray[x]) ) && A != None )
			{
				switch (sSetting)
				{
					//Complete
					/*****************************************************************************/
					//  *  //  *  //      Rx_Building_Internals      //  *  //  *  // 
					/*****************************************************************************/
					//Health, HealthLocked, HealthMax, BA_HealthMax, TrueHealthMax, Armor, LowHPWarnLevel, RepairedHPLevel, RepairedArmorLevel, SavedDmg, HealPointsScale, HDamagePointsScale, ADamagePointsScale, Destroyed_Score, ArmorResetTime, bCanArmorBreak, bDestroyed, bBuildingRecoverable, bCanPlayRepaired
					//An other way to change the building var: //foreach `WorldInfoObject.AllActors(class'Rx_Building_Team_Internals', BuildingInternals
					
					//Bools
					case "healthlocked":					sOldValue = string(Rx_Building_Team_Internals(A).HealthLocked);						Rx_Building_Team_Internals(A).HealthLocked = bool(sValue); break;			//bool - Can this building be damaged?. Default: false
					case "bcanarmorbreak":					sOldValue = string(Rx_Building_Team_Internals(A).bCanArmorBreak);					Rx_Building_Team_Internals(A).bCanArmorBreak = bool(sValue); break;			//bool. Default: true
					case "bdestroyed":						sOldValue = string(Rx_Building_Team_Internals(A).bDestroyed);						if ( bool(sValue) )
																																				{
																																					Rx_Building_Team_Internals(A).PlayDestructionAnimation();
																																				}
																																				Rx_Building_Team_Internals(A).bDestroyed = bool(sValue); break;				//repnotify bool - true if Building is destroyed
	
					case "bbuildingrecoverable":			sOldValue = string(Rx_Building_Team_Internals(A).bBuildingRecoverable); 			Rx_Building_Team_Internals(A).bBuildingRecoverable = bool(sValue); break;	//bool - Building Recoverable. Default: false
					case "bcanplayrepaired":				sOldValue = string(Rx_Building_Team_Internals(A).bCanPlayRepaired);					Rx_Building_Team_Internals(A).bCanPlayRepaired = bool(sValue); break; 		//bool - Repair building.
					case "bnopower":						sOldValue = string(Rx_Building_Team_Internals(A).bNoPower);							Rx_Building_Team_Internals(A).bNoPower = bool(sValue); break; 				//bool - Repair building.
					case "binitialdamagelod":				sOldValue = string(Rx_Building_Team_Internals(A).bInitialDamageLod);				Rx_Building_Team_Internals(A).bInitialDamageLod = bool(sValue); break;		//bool - Default: true
					
					//Ints
					case "teamid":							sOldValue = string(Rx_Building_Team_Internals(A).TeamID);							if (sValue ~= "gdi") { Rx_Building_Team_Internals(A).TeamID = 0; break; } 
																																				else if (sValue ~= "nod") { Rx_Building_Team_Internals(A).TeamID = 1; break; } 
																																				else { Rx_Building_Team_Internals(A).TeamID = 2; break; }					// building belongs to team with this TeamID (normally 0 -> GDI, 1-> Nod) TEAM_GDI, TEAM_NOD, TEAM_UNOWNED
					case "health":							sOldValue = string(Rx_Building_Team_Internals(A).Health);							Rx_Building_Team_Internals(A).Health = int(sValue); break;					//int - Starting/Current health of the building Default: 4000
					case "healthmax":						sOldValue = string(Rx_Building_Team_Internals(A).HealthMax);						Rx_Building_Team_Internals(A).HealthMax = int(sValue); break;				//int - Maximum health of the building. Default: 4000
					case "ba_healthmax":					sOldValue = string(Rx_Building_Team_Internals(A).BA_HealthMax);						Rx_Building_Team_Internals(A).BA_HealthMax = int(sValue); break;			//int - Changes to this as max health when building armour is enabled. Default: 4800
					case "truehealthmax":					sOldValue = string(Rx_Building_Team_Internals(A).TrueHealthMax);					Rx_Building_Team_Internals(A).TrueHealthMax = int(sValue); break;			//int - Max Health minus Armor value
					case "armor":							sOldValue = string(Rx_Building_Team_Internals(A).Armor);							Rx_Building_Team_Internals(A).Armor = int(sValue); break;					//int - Maximum health of the building
					case "lowhpwarnLevel":					sOldValue = string(Rx_Building_Team_Internals(A).LowHPWarnLevel);					Rx_Building_Team_Internals(A).LowHPWarnLevel = int(sValue); break;			//int - under this health-lvl lowHP warnings will be send (critical)
					case "repairedhplevel":					sOldValue = string(Rx_Building_Team_Internals(A).RepairedHPLevel);					Rx_Building_Team_Internals(A).RepairedHPLevel = int(sValue); break;			//int - Repaired message will not play if the building didn't fall below this level of health. Default: 3400 // 85%
					case "repairedarmorlevel":				sOldValue = string(Rx_Building_Team_Internals(A).RepairedArmorLevel);				Rx_Building_Team_Internals(A).RepairedArmorLevel = int(sValue); break;		//int - Same but for armour. Default: 1200
					case "damagelodlevel":					sOldValue = string(Rx_Building_Team_Internals(A).DamageLodLevel);					Rx_Building_Team_Internals(A).DamageLodLevel = int(sValue); break;			//int - Default: 1
					
					//Floats
					case "saveddmg":						sOldValue = string(Rx_Building_Team_Internals(A).SavedDmg);							Rx_Building_Team_Internals(A).SavedDmg = float(sValue); break;				//float - Since infantry weapons will do fractions of damage it is added here and once it is greater than 1 point of damage it is applied to health
					case "destroyed_score":					sOldValue = string(Rx_Building_Team_Internals(A).Destroyed_Score);					Rx_Building_Team_Internals(A).Destroyed_Score = float(sValue); break;		//float - Total points given when the building is destroyed. 1/2 is given to the player that destroyed it, whilst the other is just added to the team score. . Default:
					case "messagewaittime":					sOldValue = string(Rx_Building_Team_Internals(A).MessageWaitTime);					Rx_Building_Team_Internals(A).MessageWaitTime = float(sValue); break;		//float
					case "armorresettime":					sOldValue = string(Rx_Building_Team_Internals(A).ArmorResetTime);					Rx_Building_Team_Internals(A).ArmorResetTime = float(sValue); break;		//float
					case "lastbuildingrepairedmessagetime": sOldValue = string(Rx_Building_Team_Internals(A).LastBuildingRepairedMessageTime);	Rx_Building_Team_Internals(A).LastBuildingRepairedMessageTime = float(sValue); break; //float
					
					//Constants
					//case "healpointsscale":																									Rx_Building_Team_Internals(A).HealPointsScale = float(sValue); break;		//const float	 - How many points per healed HP
					//case "hdamagepointsscale":																								Rx_Building_Team_Internals(A).HDamagePointsScale = float(sValue); break;	//const float - How many points per damaged HP
					//case "adamagepointsscale":																								Rx_Building_Team_Internals(A).ADamagePointsScale = float(sValue); break;	//const float - How many points per damaged Armor
	
					/*****************************************************************************/
					//  *  //  *  //      Rx_Building_Refinery_Internals     //  *  //  *  // 
					/*****************************************************************************/							
					case "playidleanimrefinery": 			sOldValue = string(Rx_Building_Refinery_Internals(A).PlayIdleAnim);					Rx_Building_Refinery_Internals(A).PlayIdleAnim=bool(sValue); break;
	
					default: bFailed = true;
				}
			}
		}
	}
	else
	{
		switch (sSetting)
		{
			/*****************************************************************************/	
			//  *  //  *  //      Rx_Game - Limits    //  *  //  *  //  *  // 
			/*****************************************************************************/
			//case "initialcredits":				sOldValue = string(myRx_Game.InitialCredits);								myRx_Game.InitialCredits=int(sValue); SaveClassConfig("Rx_Game");break;									//		
			
			//Complete
			/*****************************************************************************/	
			//  *  //  *  //      Rx_TeamInfo - Limits    //  *  //  *  //  *  // 
			/*****************************************************************************/
			case "minecount":					sOldValue = string(myRx_TeamInfo.mineCount);								myRx_TeamInfo.mineCount=int(sValue); break;									//
			case "minelimit":					sOldValue = string(myRx_TeamInfo.mineLimit);								myRx_TeamInfo.mineLimit=int(sValue); break;									//
	
			case "vehiclecount":				sOldValue = string(myRx_TeamInfo.vehicleCount);								myRx_TeamInfo.vehicleCount=int(sValue); break;								//
			case "vehicleLimit":				sOldValue = string(myRx_TeamInfo.VehicleLimit);								myRx_TeamInfo.VehicleLimit=int(sValue); break;								//
			
			// TeamColors
			// TeamNames
			// LastAttackTime					// to warn every 30sec for attacks on team
			// LastAirstrikeTime
	
			//Complete
			/*****************************************************************************/
			//  *  //  *  //      GameReplicationInfo - Clock/GameTime     //  *  //  *  //
			/*****************************************************************************/
			case "goalscore":					sOldValue = string(myGameReplicationInfo.GoalScore);						myGameReplicationInfo.GoalScore=int(sValue); break;							// Replicates scoring goal for this match
			case "timelimit":					sOldValue = string(myGameReplicationInfo.TimeLimit);						myGameReplicationInfo.TimeLimit=int(sValue); break;							// Replicates time limit for this match
			
			case "remainingtime":				sOldValue = string(myGameReplicationInfo.RemainingTime);					myGameReplicationInfo.RemainingTime=int(sValue); break;						//GameReplicationInfo - Tested - Change remainingtime, 64 is one minute. - Used for counting down time in time limited games
			case "elapsedtime":					sOldValue = string(myGameReplicationInfo.ElapsedTime);						myGameReplicationInfo.ElapsedTime=int(sValue); break;						//GameReplicationInfo - Tested - Change remainingtime, 64 is one minute. - Used for counting down time in time limited games
			case "stopcountDown":				sOldValue = string(myGameReplicationInfo.bStopCountDown);					myGameReplicationInfo.bStopCountDown=bool(sValue); break;					//GameReplicationInfo - Tested - can reset every second					 - Used for counting down time in time limited games
			
			
			case "bmatchhasbegun":				sOldValue = string(myGameReplicationInfo.bMatchHasBegun);					myGameReplicationInfo.bMatchHasBegun=bool(sValue); break;					// Match is in progress (replicated)
			case "bmatchisover":				sOldValue = string(myGameReplicationInfo.bMatchIsOver);						myGameReplicationInfo.bMatchIsOver=bool(sValue); break;						// Match is over (replicated)
			
			case "servername":					sOldValue = myGameReplicationInfo.ServerName;								myGameReplicationInfo.ServerName=(sValue); break;							// Name of the server, i.e.: Bob's Server.

			/*****************************************************************************/
			//  *  //  *  //      Rx_Building_Silo_Internals      //  *  //  *  // 
			/*****************************************************************************/
			case "creditssilo": 			sOldValue = string(Silo.CreditsGain); 											Silo.CreditsGain=float(sValue); break;
		
			/*****************************************************************************/		
			//  *  //  *  //      Rx_Building_Refinery     //  *  //  *  // 		
			/*****************************************************************************/		
			case "harvesterunloadtime": 		sOldValue = string(Refinery.HarvesterUnloadTime);							Refinery.HarvesterUnloadTime=float(sValue); break;							// Default: HarvesterUnloadTime = 10.0f
			case "HarvesterHarvesttime": 		sOldValue = string(Refinery.HarvesterHarvestTime);							Refinery.HarvesterHarvestTime=float(sValue); break;                         // Default: HarvesterHarvestTime = 15.0f
			case "Harvestercreditdump": 		sOldValue = string(Refinery.HarvesterCreditDump);							Refinery.HarvesterCreditDump=float(sValue); break;                          // Default: HarvesterCreditDump = 300.0f
			case "credittickrate": 				sOldValue = string(Refinery.CreditTickRate);								Refinery.CreditTickRate=float(sValue); break;                               // Default: CreditTickRate = 1.0f
			case "creditsrefinery": 			sOldValue = string(Refinery.CreditsPerTick);								Refinery.CreditsPerTick=float(sValue); break;                               // Default: CreditsPerTick = 2.0f
			
			//Privates
			//var private repnotify bool bDocking;																																				// Default: bDocking = false
			//var private Rx_Vehicle_HarvesterController DockedHarvester;                                                                                                                       //
			//var private float CreditsToDump;                                                                                                                                                  // Default: CreditsToDump = 0
			//var private float CreditTickTimer;                                                                                                                                                // Default: CreditTickTimer = 0
			
			//Functions
			//StartHarvesterUnloading()
			//HarvesterFinishedUnloading()
			//GiveTeamCredits(float Credits)
			//HarvesterDocked(Rx_Vehicle_HarvesterController HarvesterController)

			/*****************************************************************************/
			//  *  //  *  //      GameInfo - Limits    //  *  //  *  //  *  // 
			/*****************************************************************************/
			//bTeamGame		MaxSpectators		MaxPlayers	GoalScore	MaxLives	TimeLimit
			
			/*****************************************************************************/
			//  *  //  *  //      Rx_MapInfo - Limits    //  *  //  *  //  *  // 
			/*****************************************************************************/
			//bAircraftDisabled		HarvesterHarvestTimeMultiplier		NumCratesToBeActive
		
			/*****************************************************************************/
			//  *  //  *  //      Rx_PurchaseSystem     //  *  //  *  // 
			/*****************************************************************************/
			case "airdropcooldownTime": sOldValue = string(PurchaseSystem.AirdropCooldownTime); PurchaseSystem.AirdropCooldownTime=int(sValue); break;

			default: bFailed = true;
		}
	}

	if (bFailed)
	{
		ClientMessage("UkillChange - Setting not found");
	}
	else
	{
		ClientMessage("UkillChange " $ sSetting $ " - from " $ sOldValue $ " to " $ sValue );
	}
}
	
/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode1   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GimmeSpawn ( string ClassName ){									// spawns object for user

	LogInternal("FunctionCall: GimmeSpawn - Input - ClassName:" $ ClassName);
	
	GimmeSpawnServer(ClassName);
}
reliable server function GimmeSpawnServer (string ClassName, optional bool bSkipAuthentication, optional bool bDoResetMode){	// Spawn the className at user  position

	local class<actor> NewClass;
	local vector SpawnLoc;
	local Actor A;
	local string Str1,Str2,Str3;
	//local bool bBeaconExist;
	//local int i;
	local int iMode,x,SandboxItemNameArrayLength,iSpawnItemsAmountBefore;

	LogInternal("FunctionCall: GimmeSpawnServer");
	LogInternal("FunctionCall: GimmeSpawnServer - INPUT - ClassName:" $ ClassName $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);	
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=1;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
	}
	else
	{
		return;
	}
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( iNextSpawnTime > CounterGlobal )
	{
		iNextSpawnTime=iNextSpawnTime+3; //Add some extra seconds, some people never learn ;)
		
		ClientMessage("Sandbox Message: SpawnMode Disabled, You need to wait at least " $ ( iNextSpawnTime - CounterGlobal ) $ "  seconds before respawn.");
		return;
	}
	
	// Set the first part of the Classname in Str1
	Str1="renx_game.";

	SandboxItemNameArrayLength = ArrayCount(SandboxItemNameArray);
	
	LogInternal("Found " $ SandboxItemNameArrayLength $ " items");
			
	for (x = 0; x < SandboxItemNameArrayLength ; x++)
	{
		if( ClassName ~= SandboxItemNameArray[x] )
		{
			// First filter the disabled items
			if ( x >= 13 && x <= 16 )	// SandboxItemNameArray[14]="C130";		// SandboxItemNameArray[16]="Bus";
			{
				ClientMessage("Sandbox Message: The item " $ SandboxItemNameArray[x] $ " is disabled by the server administrator");
				return;
			}
			
			// Set the Second part of the Classname in Str2
			else if ( x >= 0 && x <= 16 )
			{
				Str2=SandboxItemPreFixArray[0];
			}
			else if ( x >= 17 && x <= 23 )
			{
				Str2=SandboxItemPreFixArray[1];
			}
			else if ( x >= 24 && x <= 29 )
			{
				Str2=SandboxItemPreFixArray[2];
			}
			else if ( x >= 30 && x <= 35 )
			{
				Str2=SandboxItemPreFixArray[3];
			}
			else if ( x >= 36 && x <= 40 )
			{
				Str2=SandboxItemPreFixArray[4];
			}	
			else if ( x == 41 )
			{
				Str2=SandboxItemPreFixArray[5];
			}
			
			// Set the Second part of the Classname in Str3
			Str3=SandboxItemNameArray[x];
		}
	}
	
	if ( Str2 != "" )
	{	// Combine the collected strings to one complete class string
		//ClassName=Str1 $ Str2 $ Str3;
		ClassName = (Str1 $ Str2 $ Str3);
		LogInternal("ClassNameAfter: " $ ClassName);
		
	}
	else 
	{
		// If Str2 is emtpty, the user did not give a available itemname.
		ClientMessage("Sandbox Message: The item " $ Str1 $ Str2 $ Str3 $ " is not found, try again?");
		//Maybe add later help/Item-list
	}

	NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
	
	if ( NewClass == None )
	{
		NewClass = class<actor>( DynamicLoadObject( ClassName$"_Content", class'Class' ) );
	}	
	
	if( NewClass!=None )
	{
		if ( Pawn != None )
		{
			SpawnLoc = Pawn.Location;
		}
		else
		{
			SpawnLoc = Location;
		}

		//			if(NewClass == class'Renx_Game.Rx_weapon_DeployedBeacon')
		//			{
		//				// FIX LATER - FIX LATER - FIX LATER - FIX LATER
		//				for(i = 0;i < SpawnedActors.Length;i++)
		//				{
		//					if(SpawnedActors[i].IsA('Rx_Weapon_DeployedBeacon'))
		//					bBeaconExist = true;
		//				}
		//				if(bBeaconExist)
		//				{
		//					ClientMessage("Spawning Beacon Failed! You already have a beacon spawned");
		//					return;
		//				}			
		//			}
		
		//Check if there is a pawn			
		
		iSpawnItemsAmountBefore = iSpawnItemsAmount;
		
		// FIX LATER - FIX LATER - FIX LATER - FIX LATER
		//A = Spawn( NewClass,self,,SpawnLoc + 72 * Vector(Rotation) + vect(0,0,1) * 15 );
		
		A = Spawn( NewClass,self,,SpawnLoc + 72 * Vector(Rotation) + vect(200,200,15) );
		
		if ( A == None )
		{
			ClientMessage("Something did go wrong, maybe you need to keep more distance to other objects");
			return;
		}
		
		SpawnedActors.additem(A);
		
		iSpawnItemsAmount = 0;
		foreach SpawnedActors(A)
		{
			iSpawnItemsAmount++;
			LogInternal("Test2");
		}
		
		LogInternal("Found iSpawnItemsAmount: " $ iSpawnItemsAmount);
		
		if ( iSpawnItemsAmountBefore < iSpawnItemsAmount )
		{
			iNextSpawnTime = CounterGlobal + iSpawnWaitTime;
			
		}
		
		LogInternal("iNextSpawnTime: " $ iNextSpawnTime $ " CounterGlobal: " $ CounterGlobal);
		
		if ( A != None )
		{
			if(A.IsA('Rx_Weapon_DeployedActor'))
			{
				Rx_Weapon_DeployedActor(A).InstigatorController = self;
				Rx_Weapon_DeployedActor(A).TeamNum = GetTeamNum();	
			}
			else if(A.IsA('UTVehicle'))
			{
				UTVehicle(A).SetTeamNum(GetTeamNum());
			}
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function ShowSpawnedActors(){

	ShowSpawnedActorsServer();
}
reliable server function ShowSpawnedActorsServer(){

	local int i,x;
    local Actor A;
	
	LogInternal("ShowSpawnedActorsServer"); LogInternal(" ");

	LogInternal(" ");
	LogInternal("Part1:");
	
    for (i = 0; i < SpawnedActors.Length; i++)
    {
        LogInternal( "Actors " $ i $ ": " $ SpawnedActors[i]);
    }
	
	LogInternal(" ");
	LogInternal("Part2:"); 

	foreach SpawnedActors(A)
    {
		LogInternal( "1 Actors Name: " $ A.Name);
        LogInternal( "2 Actors Tag: " $ A.Tag);
		LogInternal( "3 Actors InitialState: " $ A.InitialState);
		LogInternal( "4 Actors CreationTime: " $ A.CreationTime);
    } 

	LogInternal(" ");
	LogInternal("Part3:"); 
		
	LogInternal("SpawnedActors.Length: " $ SpawnedActors.Length);

	foreach SpawnedActors(A)
	{
		LogInternal("Item" $ x++ $ ": " $ A);
	}
}
exec function GimmeSpawnKillOwned(optional string ClassName){					// destroys all object spawned by user

	LogInternal("FunctionCall: GimmeSpawnKillOwned");
	LogInternal("FunctionCall: GimmeSpawnKillOwned - Input - ClassName:" $ ClassName);
	
	GimmeSpawnKillOwnedServer(ClassName);
}
reliable server function GimmeSpawnKillOwnedServer(optional string ClassName){	// destroys all object spawned by user

	local Actor A;

	LogInternal("FunctionCall: GimmeSpawnKillOwnedServer");
	LogInternal("FunctionCall: GimmeSpawnKillOwnedServer - Input - ClassName:" $ ClassName);
	
	//allactors
	foreach SpawnedActors(A)
	{
		if(ClassName == "")
		A.Destroy();
		else if(A.IsA(name(ClassName)))
		A.Destroy();
	}
}
exec function GimmeSpawnKillAll(optional string ClassName){					// destroys all object spawned by user

	LogInternal("FunctionCall: GimmeSpawnKillAll");
	LogInternal("FunctionCall: GimmeSpawnKillAll - Input - ClassName:" $ ClassName);
	
	GimmeSpawnKillAllServer(ClassName);
}
reliable server function GimmeSpawnKillAllServer(optional string ClassName){	// destroys all object spawned by user

	local Rx_Mutator_AdminTool_Controller C;
	local int iMode;

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=0;	//DONT CHANGE - Used for Authentication Check	 //
	if ( AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode]) && (bool(ModeStatusArray[iMode])) )
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
		
	LogInternal("FunctionCall: GimmeSpawnKillAllServer");
	LogInternal("FunctionCall: GimmeSpawnKillAllServer - Input - ClassName:" $ ClassName);
	
	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
	{
		C.GimmeSpawnKillOwnedServer(ClassName);
	}
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode2   //  *  //  *  //  *  //  *  //  *  //  
/****************************************************************************/
exec function GimmeWeapon( string WeaponName){

	LogInternal("FunctionCall: GimmeWeapon");
	LogInternal("FunctionCall: GimmeWeapon - Input - Weapon:" $ WeaponName);
	
	WeaponName="renx_game.Rx_Weapon_" $ WeaponName;
	LogInternal("FunctionCall: GimmeWeapon - Modified - Weapon:" $ WeaponName);
	
	ServerGimme(WeaponName);
}
reliable server function Weapon ServerGimme( String WeaponClassStr, optional bool bSkipAuthentication, optional bool bDoResetMode ){

	local Weapon Weap;
	local class<Weapon> WeaponClass;
	local int iMode;

	LogInternal("FunctionCall: ServerGimme");
	LogInternal("FunctionCall: ServerGimme - Input - WeaponClassStr:" $ WeaponClassStr);

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=2;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { return None; } //Escape while ModeStatus is False.

	//if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode )
	//{
	//	if (bSkipAuthentication)
	//	{
	//		Weap None;
	//	}
	//	else
	//	{
	//		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" );
	//		return;
	//	} 
	//} 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		LogInternal("FunctionCall: ServerGimme - Access check - Accepted");
		
		WeaponClass = class<Weapon>(DynamicLoadObject(WeaponClassStr, class'Class'));
		Weap		= Weapon(Pawn.FindInventoryType(WeaponClass));
		
		if( Weap != None )
		{
			return Weap;
		}
		
		return Weapon(Pawn.CreateInventory( WeaponClass ));
	}

	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode3   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GimmeSkin(string sSoldierName){

	local int iMeshIndex;

	LogInternal("FunctionCall: GimmeSkin");
	LogInternal("FunctionCall: GimmeSkin - Input - sSoldierName:" $ sSoldierName );
	
    if (GetTeamNum() == TEAM_GDI) { (team)="GDI";}
    if (GetTeamNum() == TEAM_NOD) { (team)="NOD";}
    if (Pawn != None && Vehicle(Pawn) == None) 
	{
        for (iMeshIndex = 0; iMeshIndex < 34; iMeshIndex++)
        {
			if(sSoldierName == SkinItemNameArray[iMeshIndex])
			{
				GimmeSkinServer(iMeshIndex);
				iMeshIndex = 99;
			}			
        }      
    }
}
reliable server function GimmeSkinServer(int iMeshIndex, optional bool bSkipAuthentication, optional bool bDoResetMode){

    local Rx_Mutator_AdminTool_Controller PC;
	local int iMode;

	LogInternal("FunctionCall: GimmeSkinServer");
	LogInternal("FunctionCall: GimmeSkinServer - INPUT - iMeshIndex:" $ iMeshIndex $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);	

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=3;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{	
		LogInternal("FunctionCall: GimmeSkinServer - Access check - Accepted");
		
		Pawn.Mesh.SetSkeletalMesh(SkinMeshNameArray[iMeshIndex]);
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', PC)
			PC.GimmeSkinClient(Pawn, SkinMeshNameArray[iMeshIndex]);
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}	
reliable client function GimmeSkinClient(Pawn P, SkeletalMesh skel){

	LogInternal("FunctionCall: GimmeSkinClient");

	P.Mesh.SetSkeletalMesh(skel);
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode4  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
function InfiniteAmmo(bool bStatus){

	InfiniteAmmoSim(bStatus);
	
}
simulated function InfiniteAmmoSim(bool bStatus){

	local Rx_Weapon Weap;
	local int iAmmoCount;	    
	
	ForEach Rx_InventoryManager(Pawn.InvManager).InventoryActors(class'Rx_Weapon', Weap)
	{
		if (Weap != None)
		{

		}
			
		if(Rx_InventoryManager(Pawn.InvManager) != none)
		{
			if ( bStatus )
			{
				if ( Pawn != None )
				{
					iAmmoCount = ( Rx_Weapon_Reloadable(Pawn.weapon).ClipSize * Rx_Weapon_Reloadable(Pawn.weapon).InitalNumClips ) - Rx_Weapon_Reloadable(Pawn.weapon).CurrentAmmoInClipClientside;
					Rx_Weapon_Reloadable(Pawn.weapon).AmmoCount = iAmmoCount;
					Rx_Weapon_Reloadable(Pawn.weapon).ClientAmmoCount = iAmmoCount;
				}
			}
		}				
	}			

	InfiniteAmmoClient(bStatus);
	InfiniteAmmoServer(bStatus);	
}
reliable client function InfiniteAmmoClient(bool bStatus){

	local Rx_Weapon Weap;
	local int iAmmoCount;	    
	
	ForEach Rx_InventoryManager(Pawn.InvManager).InventoryActors(class'Rx_Weapon', Weap)
	{
		if (Weap != None)
		{

		}
			
		if(Rx_InventoryManager(Pawn.InvManager) != none)
		{
			if ( bStatus )
			{
				if ( Pawn != None )
				{
					iAmmoCount = ( Rx_Weapon_Reloadable(Pawn.weapon).ClipSize * Rx_Weapon_Reloadable(Pawn.weapon).InitalNumClips ) - Rx_Weapon_Reloadable(Pawn.weapon).CurrentAmmoInClipClientside;
					Rx_Weapon_Reloadable(Pawn.weapon).AmmoCount = iAmmoCount;
					Rx_Weapon_Reloadable(Pawn.weapon).ClientAmmoCount = iAmmoCount;
				}
			}
		}				
	}			

}
reliable server function InfiniteAmmoServer(bool bStatus){

	local Rx_Weapon Weap;
	local int iAmmoCount;	    
	
	ForEach Rx_InventoryManager(Pawn.InvManager).InventoryActors(class'Rx_Weapon', Weap)
	{
		if (Weap != None)
		{

		}
			
		if(Rx_InventoryManager(Pawn.InvManager) != none)
		{
			if ( bStatus )
			{
				if ( Pawn != None )
				{
					iAmmoCount = ( Rx_Weapon_Reloadable(Pawn.weapon).ClipSize * Rx_Weapon_Reloadable(Pawn.weapon).InitalNumClips ) - Rx_Weapon_Reloadable(Pawn.weapon).CurrentAmmoInClipClientside;
					Rx_Weapon_Reloadable(Pawn.weapon).AmmoCount = iAmmoCount;
					Rx_Weapon_Reloadable(Pawn.weapon).ClientAmmoCount = iAmmoCount;
				}
			}
		}				
	}			
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode5   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
simulated function NormalizeHealth(optional int iHealthIncreaseValue, optional bool bSkipAuthentication){

	local Rx_Pawn PlayerPawn;
	local int x,iMode;

	iMode=5; if ( !bool(ModeStatusArray[iMode]) || !AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode]) && !bSkipAuthentication  ) { return; }
	
	if (iHealthIncreaseValue == 0)
	{
		iHealthIncreaseValue = int(ModeAutoSetDefaultValueArray[iMode]);
	}

	if ( PlayerPawn != None )
	{
		foreach DynamicActors(class 'Rx_Pawn', PlayerPawn)
		{
			for (x = 1; x <= iHealthIncreaseValue; x++)
			{
				if ( PlayerPawn.Health + 1 <= PlayerPawn.HealthMax )
				{
					PlayerPawn.Health=( PlayerPawn.Health++ );
				}
				else
				{
					x= iHealthIncreaseValue + 1;
				}
			}
		}
	}
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode6   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function FriendlyFireSet (float fFriendlyFireScaleNewValue){				//FriendlyFire

	LogInternal("FunctionCall: FriendlyFireSet");
	LogInternal("FunctionCall: FriendlyFireSet - Input - fFriendlyFireScaleNewValue:" $ fFriendlyFireScaleNewValue);
	
	FriendlyFireSetServer(fFriendlyFireScaleNewValue);
}
reliable server function FriendlyFireSetServer(float fFriendlyFireScaleNewValue, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local Rx_Mutator_AdminTool_Controller C;
	local float fFriendlyFireScaleOldValue;
	local int iMode;

	LogInternal("FunctionCall: FriendlyFireSetServer");
	LogInternal("FunctionCall: FriendlyFireSetServer - INPUT - fFriendlyFireScaleNewValue:" $ fFriendlyFireScaleNewValue $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);	
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=6;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( fFriendlyFireScaleNewValue < float(ModeAutoSetMinValueArray[iMode]) || fFriendlyFireScaleNewValue > float(ModeAutoSetMaxValueArray[iMode]) )
	{
		ClientMessage( "Value " $ fFriendlyFireScaleNewValue $ " is out of range: " $ ModeAutoSetMinValueArray[iMode] $ " ~ " $ ModeAutoSetMaxValueArray[iMode] );
		return;
	}	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		fFriendlyFireScaleOldValue = UTTeamGame(WorldInfo.Game).FriendlyFireScale;
		UTTeamGame(WorldInfo.Game).FriendlyFireScale = fFriendlyFireScaleNewValue;
		
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
		{
			ClientMessage("FriendlyFireScaleValue is set by " $ PlayerReplicationInfo.PlayerName $ " from " $ fFriendlyFireScaleOldValue $ " to " $ fFriendlyFireScaleNewValue );
			LogInternal("FunctionCall: FriendlyFireSetServer - Modified - by " $ PlayerReplicationInfo.PlayerName $ " from fFriendlyFireScaleOldValue:" $ fFriendlyFireScaleOldValue $ " to fFriendlyFireScaleNewValue:" $ fFriendlyFireScaleNewValue);
		}		
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode7   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function Nuke(string PlayerName){											//Nuke

	LogInternal("FunctionCall: Nuke");
	LogInternal("FunctionCall: Nuke - Input - PlayerName:" $ PlayerName);
	
	NukeServer(PlayerName);
}
reliable server function NukeServer(string PlayerName, optional string sSkipAuthentication){

	local Rx_Weapon_DevNuke Beacon;
	local Rx_PRI PRI;
	local int iMode;
	
	LogInternal("FunctionCall: NukeServer");
	LogInternal("FunctionCall: NukeServer - Input - PlayerName:" $ PlayerName);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=7;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	

	//Add some continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{

		PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

		if (PRI != None && Controller(PRI.Owner) != None) 
		{ 
			Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevNuke',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED; 
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function Ion(string PlayerName){										//Ion

	LogInternal("FunctionCall: Ion");
	LogInternal("FunctionCall: Ion - Input - PlayerName:" $ PlayerName);
	
	IonServer(PlayerName);
}
reliable server function IonServer(string PlayerName, optional string sSkipAuthentication){

	local Rx_Weapon_DevIon Beacon;
	local Rx_PRI PRI;
	local int iMode;
	
	LogInternal("FunctionCall: IonServer");
	LogInternal("FunctionCall: IonServer - INPUT - PlayerName:" $ PlayerName $ " sSkipAuthentication:" $ sSkipAuthentication);	

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=7;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add some continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{

		PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

		if (PRI != None && Controller(PRI.Owner) != None) 
		{ 
			Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevIon',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED; 
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode8   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function NukeAll(optional string sSkipAuthentication){						//NukeAll

	LogInternal("FunctionCall: NukeAll");
	LogInternal("FunctionCall: NukeAll - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
	
	NukeAllServer(sSkipAuthentication);
}
reliable server function NukeAllServer(optional string sSkipAuthentication){

	local Rx_Weapon_DevNuke Beacon;
	local Rx_Mutator_AdminTool_Controller C;
	local int iMode;

	LogInternal("FunctionCall: NukeAllServer");
	LogInternal("FunctionCall: NukeAllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C) 
		{ 
			Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevNuke',,, C.Pawn.Location, C.Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED; 
		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function IonAll(optional string sSkipAuthentication){						//IonAll

	LogInternal("FunctionCall: IonAll");
	LogInternal("FunctionCall: IonAll - INPUT - sSkipAuthentication:" $ sSkipAuthentication);
	
	IonAllServer(sSkipAuthentication);
} 
reliable server function IonAllServer(optional string sSkipAuthentication){

	local Rx_Weapon_DevIon Beacon;
	local Rx_Mutator_AdminTool_Controller C;
	local int iMode;

	LogInternal("FunctionCall: IonAllServer");
	LogInternal("FunctionCall: IonAllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication);

	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add some continuous access for Developers, i think they like Ions Too!!
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C) 
		{ 
			Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevIon',,, C.Pawn.Location, C.Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED; 
		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function RemoteC4All(optional string sSkipAuthentication){					//RemoteC4

	LogInternal("FunctionCall: RemoteC4All");
	LogInternal("FunctionCall: RemoteC4All - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
	
	RemoteC4AllServer(sSkipAuthentication);
}
reliable server function RemoteC4AllServer(optional string sSkipAuthentication){

	local int iMode;
	local Rotator spawnRotation;
	local Vector spawnLocation;
	local Rx_Controller C;
	local Rx_Pawn Recipient;
	local Rx_PRI RecipientPRI;
	local Rx_CratePickup CratePickup;
	local Rx_Weapon_DeployedRemoteC4 RemoteC4;
	
	LogInternal("FunctionCall: RemoteC4AllServer");
	LogInternal("FunctionCall: RemoteC4AllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Pawn', Recipient) { Recipient = (Recipient); break; }
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_PRI', RecipientPRI) { RecipientPRI = (RecipientPRI); break; }
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_CratePickup', CratePickup) { CratePickup = (CratePickup); break; }
		
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			Recipient.GetActorEyesViewPoint(spawnLocation,spawnRotation);
			//RemoteC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedRemoteC4',,, C.Pawn.Location, C.Pawn.Rotation);
			//RemoteC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedRemoteC4',,, C.Pawn.Location, C.Pawn.Rotation + rot(16384,-16384,0));
			RemoteC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedRemoteC4',,, C.Pawn.Location + vect(0.0,0.0,60.0), C.Pawn.Rotation + rot(16384,-16384,0));
																						//vect(Z,X,Y)
			RemoteC4.Landed(vect(0,0,1),Recipient);
			RemoteC4.InstigatorController = Recipient.Controller;
			RemoteC4.SetDamageAll(true);
			//RemoteC4.TeamNum = Recipient.GetTeamNum();
			RemoteC4.TeamNum = TEAM_UNOWNED; 
		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function TimedC4All(optional string sSkipAuthentication){					//TimedC4

	LogInternal("FunctionCall: TimedC4All");
	LogInternal("FunctionCall: TimedC4All - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
	
	TimedC4AllServer(sSkipAuthentication);
}
reliable server function TimedC4AllServer(optional string sSkipAuthentication){

	local int iMode;
	local Rotator spawnRotation;
	local Vector spawnLocation;
	local Rx_Controller C;
	local Rx_Pawn Recipient;
	local Rx_PRI RecipientPRI;
	local Rx_CratePickup CratePickup;
	local Rx_Weapon_DeployedC4 DeployedC4;
	local Rx_Weapon_DeployedTimedC4 DeployedTimedC4;

	LogInternal("FunctionCall: TimedC4AllServer");
	LogInternal("FunctionCall: TimedC4AllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
	
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Pawn', Recipient) { Recipient = (Recipient); break; }
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_PRI', RecipientPRI) { RecipientPRI = (RecipientPRI); break; }
		foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_CratePickup', CratePickup) { CratePickup = (CratePickup); break; }
		foreach WorldInfo.AllActors(class'Rx_Weapon_DeployedC4', DeployedC4) { break; } 
		foreach WorldInfo.AllActors(class'Rx_Weapon_DeployedTimedC4', DeployedTimedC4) { DeployedTimedC4 = (DeployedTimedC4); break; }
		
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{
			
			//To The World
			//DeployedTimedC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedTimedC4',,, C.Pawn.Location, C.Pawn.Rotation);
			//DeployedTimedC4.TeamNum = TEAM_UNOWNED;
			//DeployedTimedC4.SetTimer(2.0f, false, 'Explosion');
			
			//Attached to user
			Recipient.GetActorEyesViewPoint(spawnLocation,spawnRotation);
			DeployedTimedC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedTimedC4',,, C.Pawn.Location + vect(0.0,0.0,60.0), C.Pawn.Rotation + rot(16384,-16384,0));
			DeployedTimedC4.Landed(vect(0,0,1),Recipient);
			DeployedTimedC4.InstigatorController = Recipient.Controller;
			DeployedTimedC4.SetDamageAll(true);
			DeployedTimedC4.TeamNum = Recipient.GetTeamNum();
			
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
reliable server function ProxyC4AllServer(optional string sSkipAuthentication){

	local Rx_Weapon_DeployedProxyC4 ProxyC4;
	local Rx_Controller C;
	local int iMode;

	LogInternal("FunctionCall: ProxyC4AllServer");
	LogInternal("FunctionCall: ProxyC4AllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			ProxyC4 = C.Pawn.Spawn(class'Rx_Weapon_DeployedProxyC4',,, C.Pawn.Location, C.Pawn.Rotation);
			ProxyC4.TeamNum = TEAM_UNOWNED; 
		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function ATMineAll(optional string sSkipAuthentication){					//ATMineAll

	LogInternal("FunctionCall: ATMineAll");
	LogInternal("FunctionCall: ATMineAll - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
	
	ATMineAllServer(sSkipAuthentication);
}
reliable server function ATMineAllServer(optional string sSkipAuthentication){

	local Rx_Weapon_DeployedATMine ATMine;
	local Rx_Controller C;
	local int iMode;

	LogInternal("FunctionCall: ATMineAllServer");
	LogInternal("FunctionCall: ATMineAllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			ATMine = C.Pawn.Spawn(class'Rx_Weapon_DeployedATMine',,, C.Pawn.Location, C.Pawn.Rotation);
			ATMine.TeamNum = TEAM_UNOWNED; 
		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
exec function AbductAll(optional string sSkipAuthentication){					//AbductAll

	LogInternal("FunctionCall: AbductAll");
	LogInternal("FunctionCall: AbductAll - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
	
	AbductAllServer(sSkipAuthentication);
}
reliable server function AbductAllServer(optional string sSkipAuthentication){

	local Rx_AlienAbductionBeam Abduct;
	local Rx_Controller C;
	local int iMode;
	
	local Rx_Pawn Recipient;
	local Rx_PRI RecipientPRI;
	local Rx_CratePickup CratePickup;
	foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Pawn', Recipient) { Recipient = (Recipient); break; }
	foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_AlienAbductionBeam', Abduct) { Abduct = (Abduct); break; }
	foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_PRI', RecipientPRI) { RecipientPRI = (RecipientPRI); break; }
	foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_CratePickup', CratePickup) { CratePickup = (CratePickup); break; }

	LogInternal("FunctionCall: AbductAllServer");
	LogInternal("FunctionCall: AbductAllServer - INPUT - sSkipAuthentication:" $ sSkipAuthentication );
		
	//Add some check for admins like me xD, now i search for new fools to test my foolproof
	if ( sSkipAuthentication ~= "True" ||  sSkipAuthentication ~= "False" || Len(sSkipAuthentication) < 1 )
	{
	}
	else if (  Len(sSkipAuthentication) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=8;	//DONT CHANGE - Used for Authentication Check	 //
	if (!bool(ModeStatusArray[iMode])) { if (bool(sSkipAuthentication)) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : This Mode is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (bool(sSkipAuthentication)) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			//CratePickup.Spawn(class'Rx_AlienAbductionBeam',,,Recipient.Location);
			Abduct = C.Pawn.Spawn(class'Rx_AlienAbductionBeam',,, C.Pawn.Location, C.Pawn.Rotation);
			Abduct.SetTarget(Recipient);  
			//DeployedTimedC4.Landed(vect(0,0,1),Recipient);
			//DeployedTimedC4.InstigatorController = Recipient.Controller;
			//DeployedTimedC4.SetDamageAll(true);
			//DeployedTimedC4.TeamNum = Recipient.GetTeamNum();

		} 
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode9   //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function FutureSoldier(){													//FutureSoldier	//I could disable this option because it also exist in GimmeSkin, for now keep it, maybe remove it later

	LogInternal("FunctionCall: FutureSoldier");
	
	if (Pawn != None && Vehicle(Pawn) == None)
	{
		if (Worldinfo.NetMode == NM_Standalone) 
		{
			if (GetTeamNum() == TEAM_GDI) Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
			else Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE'); 
		}
		else FutureSoldierServer(); 
	}
}
reliable server function FutureSoldierServer(){

	local Rx_Mutator_AdminTool_Controller PC;
	local int iMode;
	local bool bSkipAuthentication;
	local bool bDoResetMode;
	
	bSkipAuthentication=true;
	bDoResetMode=false;

	LogInternal("FunctionCall: FutureSoldierServer");
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=9;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	//Add fix continuous access for Developers
	if ( (bIsDev) || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		if (GetTeamNum() == TEAM_GDI) 
		{
			Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
			foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', PC)
				PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE'); 
		}
		else 
		{
			Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
			foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', PC)
				PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE'); 
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
reliable client function FutureSoldierClient(Pawn P, SkeletalMesh skel){

	LogInternal("FunctionCall: FutureSoldierClient");
	
	P.Mesh.SetSkeletalMesh(skel); 
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode10  //  *  //  *  //  *  //  *  //  *  //
/*****************************************************************************/
exec function LockBuildings(bool bStatus){										//LockBuildings

	//LogInternal("FunctionCall: LockBuildings");
	
	LockBuildingsServer(bStatus);
}
reliable server function LockBuildingsServer(bool bBuildingLockStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local Rx_Building_Team_Internals BuildingInternals;
	local int iMode;
	
	LogInternal("FunctionCall: LockBuildingsServer");
	LogInternal("FunctionCall: LockBuildingsServer - INPUT - bBuildingLockStatus:" $ bBuildingLockStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	//	iMode=10;	//DONT CHANGE - Used for Authentication Check	 //
	//	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
		iMode=10; if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	

	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		foreach `WorldInfoObject.AllActors(class'Rx_Building_Team_Internals', BuildingInternals)
		
		BuildingInternals.HealthLocked = bBuildingLockStatus;
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}

		
		
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode11  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//Weapondrop	//Configured in Pawn class

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode12  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
function CheckJumpOrDuck(){														//DoubleJump

	local int iMode;
 
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=12;	//DONT CHANGE - Used for Authentication Check	 //
	//if ( !bool(ModeStatusArray[iMode]) || !AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode]) && !bSkipAuthentication  ) { return; }
	//if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	


	if (Rx_Pawn(Pawn) == None)
	{
		return;
	}	
	
	if ( !bool(ModeStatusArray[iMode]) )
	{
		super.CheckJumpOrDuck();
	}
	
	if ( bDoubleJump && (bUpdating || ((Rx_Pawn(Pawn) != None) && Rx_Pawn(Pawn).CanDoubleJump())) )
	{
		Rx_Pawn(Pawn).DoDoubleJump( bUpdating ); bDoubleJump = false ;
	}
	else if ( bPressedJump )
	{
		Pawn.DoJump( bUpdating );
	}
		
	if ( Rx_Pawn(Pawn) != none && Pawn.Physics == PHYS_Falling && bPressedJump)
	{
		Rx_Pawn(Pawn).TryParachute();
	}
	
	if ( Rx_Pawn(Pawn) != none && Pawn.Physics != PHYS_Falling && Pawn.bCanCrouch )
	{
		// crouch if pressing duck
		Pawn.ShouldCrouch(bDuck != 0);
	}
				
	if (Rx_Pawn(Pawn) != none && Rx_Pawn(Pawn).bBeaconDeployAnimating)
	{
		Pawn.ShouldCrouch(true);
	}
	else
	{
		super.CheckJumpOrDuck();
	}
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode13  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GravitySet(float fGravitySetNewValue){							//GravitySet (LowGravity)		//Note: DefaultGravityZ, WorldGravityZ, GlobalGravityZ

	local int iMode;
	iMode=13;
	
	LogInternal("FunctionCall: GravitySet");
	LogInternal("FunctionCall: GravitySet - Input - fGravitySetNewValue:" $ fGravitySetNewValue);
	
	if ( ( fGravitySetNewValue > float(ModeAutoSetMinValueArray[iMode]) ) || ( fGravitySetNewValue < float(ModeAutoSetMaxValueArray[iMode]) ) )
	{
		ClientMessage("Error: NewGravity " $ fGravitySetNewValue $ " is out of range, allowed range ( " $ ModeAutoSetMinValueArray[iMode] $ " ~ " $ ModeAutoSetMaxValueArray[iMode] $ " )");
	}
	else
	{
		GravitySetServer(fGravitySetNewValue);
	}
}
reliable server function GravitySetServer(float fGravitySetNewValue, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local Rx_Mutator_AdminTool_Controller C;
	local float fGravityGetOldValue;
	local int iMode;

	LogInternal("FunctionCall: GravitySetServer");
	LogInternal("FunctionCall: GravitySetServer - INPUT - fGravitySetNewValue:" $ fGravitySetNewValue $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=13;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{
		fGravityGetOldValue = WorldInfo.WorldGravityZ;
		WorldInfo.WorldGravityZ = fGravitySetNewValue;
		
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
		{
			ClientMessage("GravityValue is set by " $ PlayerReplicationInfo.PlayerName $ " from " $ fGravityGetOldValue $ " to " $ fGravitySetNewValue );
			LogInternal("FunctionCall: GravitySetServer - Modified - by " $ PlayerReplicationInfo.PlayerName $ " from GravityGetOldValue:" $ fGravityGetOldValue $ " to GravitySetNewValue:" $ fGravitySetNewValue);
		}
		
		//class'Rx_Mutator_AdminTool.Rx_Mutator_AdminTool_Controller'.static.StaticSaveConfig();
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode14  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GameSpeedSet (float fGameSpeedSetNewValue){						//GameSpeedSet (HighGameSpeed)

	local int iMode;
	iMode=14;
	
	LogInternal("FunctionCall: GameSpeedSet");
	LogInternal("FunctionCall: GameSpeedSet - Input - fGameSpeedSetNewValue:" $ fGameSpeedSetNewValue);

	if ( fGameSpeedSetNewValue < float(ModeAutoSetMinValueArray[iMode]) || fGameSpeedSetNewValue > float(ModeAutoSetMaxValueArray[iMode]) )
	{
		ClientMessage("Error: NewGameSpeed " $ fGameSpeedSetNewValue $ " is out of range, allowed range ( " $ ModeAutoSetMinValueArray[iMode] $ " ~ " $ ModeAutoSetMaxValueArray[iMode] $ " )");
	}
	
	GameSpeedSetServer(fGameSpeedSetNewValue);
}
reliable server function GameSpeedSetServer(float fGameSpeedSetNewValue, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local Rx_Mutator_AdminTool_Controller C;
	local float fGameSpeedGetOldValue;
	local int iMode;
	
	LogInternal("FunctionCall: GameSpeedSetServer");
	LogInternal("FunctionCall: GameSpeedSetServer - INPUT - fGameSpeedSetNewValue:" $ fGameSpeedSetNewValue $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=14;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )	
	{	
		foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
		{
			fGameSpeedGetOldValue = WorldInfo.Game.GameSpeed;
	
			WorldInfo.Game.SetGameSpeed(fGameSpeedSetNewValue);
			
			ClientMessage("GameSpeed is set by " $ PlayerReplicationInfo.PlayerName $ " from " $ fGameSpeedGetOldValue $ " to " $ fGameSpeedSetNewValue );
			LogInternal("FunctionCall: GameSpeedSetServer - Modified - by " $ PlayerReplicationInfo.PlayerName $ " from fGameSpeedGetOldValue:" $ fGameSpeedGetOldValue $ " to fGameSpeedSetNewValue:" $ fGameSpeedSetNewValue);
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode15  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//SlowTimeKills	//The variables of this mode are defined in this class	//The Functions are definded in the Rx_Mutator_Admintools class.  //Removed cause its not useable online

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode16  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//TODO - add other defences buildings and  Check Announcement
exec function SuddenDeath (bool bSuddenDeathStatus){							//SuddenDeath (BaseDefencesStatus)		//BaseDefencesOffline - SuddenDeath //is enough to disable defences

	LogInternal("FunctionCall: DefencesAIControl");

	SuddenDeathServer(bSuddenDeathStatus);
}
reliable server function SuddenDeathServer (bool bSuddenDeathStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local Actor A;
	local int iMode;

	LogInternal("FunctionCall: SuddenDeathServer");
	LogInternal("FunctionCall: SuddenDeathServer - bSuddenDeathStatus:" $ bSuddenDeathStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	iMode=16; if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode )
	{
		if (!bSkipAuthentication)
		{
			return;
		}
	}
	
	//Rx_Building_Team_Internals(BuildingInternals).bNoPower
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		foreach AllActors(class'Actor', A)
		{
			if ( A == None )
			return;
			
			if (Rx_Defence(A) != None && Rx_Building_Obelisk_Internals(A) == None && Rx_Building_AdvancedGuardTower_Internals(A) == None)
			{
				Rx_Defence(A).bAIControl = (!bSuddenDeathStatus);
			}

			if ((Rx_Building_Obelisk_Internals(A) != None || Rx_Building_AdvancedGuardTower_Internals(A) != None))
			{
				if ( bSuddenDeathStatus )
				{
					LogInternal("FunctionCall: SuddenDeathServer - Disable power " $ A );
					Rx_Building_Team_Internals(A).PowerLost();
				}
				else
				{
					LogInternal("FunctionCall: SuddenDeathServer - Enable power " $ A );
					Rx_Building_Team_Internals(A).PowerRestore();
				}
			}
		}
		
		SetTimer(2.0f, false, 'SuddenDeathAnnouncement');
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
function SuddenDeathAnnouncement (){ 

	local Rx_Mutator_AdminTool_Controller C;
	local Actor A;
	
	LogInternal("FunctionCall: SuddenDeathAnnouncement");

	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
	{
		foreach AllActors(class'Actor', A)
		{	
			if ( GetTeamNum() == 0 && Rx_Building_AdvancedGuardTower_Internals(A) != None )
			{
				if (Rx_Building_Team_Internals(A).bNoPower)
				{
					C.ClientPlaySound(SoundCue'RX_Artic_033.Sounds.CABAL_DEF_OFF_Cue');
				}
				else
				{
					C.ClientPlaySound(SoundCue'RX_Artic_033.Sounds.CABAL_DEF_ON_Cue');
				}
				return;
			}
			
			if ( GetTeamNum() == 1 &&  Rx_Building_Obelisk_Internals(A) != None )
			{
				if (Rx_Building_Team_Internals(A).bNoPower)
				{
					C.ClientPlaySound(SoundCue'RX_Artic_033.Sounds.EVA_DEF_OFF_Cue');
				}
				else
				{
					C.ClientPlaySound(SoundCue'RX_Artic_033.Sounds.EVA_DEF_ON_Cue');
				}
				return;	
			}
		}
		return;
	}
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode17  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function VeterancySet (string iMultiplier){								//Veterancy Multiply

	local Rx_VeterancyModifiers VPMod;
	
	LogInternal("FunctionCall: VeterancySet");
	LogInternal("FunctionCall: VeterancySet - Input - iMultiplier:" $ iMultiplier );
	
	VPMod=Rx_VeterancyModifiers(GetDefaultObject(Class'Rx_VeterancyModifiers'));
	
	if (iMultiplier ~= "info")
	{
		LogInternal("FunctionCall: VeterancySet - Info");
		
		ClientMessage(VPMod.Mod_BeaconAttack);
		ClientMessage(VPMod.Mod_BeaconDefense);				
		
		//Infantry
		ClientMessage(VPMod.Mod_BeaconHolderKill);		
		ClientMessage(VPMod.Mod_Headshot);
		ClientMessage(VPMod.Mod_SniperKill);
		ClientMessage(VPMod.Mod_SniperKilled);
		ClientMessage(VPMod.Mod_Disadvantage);
		ClientMessage(VPMod.Mod_AssaultKill);
		ClientMessage(VPMod.Mod_MineKill);
		
		//Vehicle
		ClientMessage(VPMod.Mod_Ground2Air);
		
		//Negative
		ClientMessage(VPMod.Mod_DefenseKill);
		ClientMessage(VPMod.Mod_UnfairAdvantage);
		
		//Events
		ClientMessage(VPMod.Ev_GoodBeaconLaid);
		ClientMessage(VPMod.Ev_BuildingRepair);
		ClientMessage(VPMod.Ev_PawnRepair);
		ClientMessage(VPMod.Ev_VehicleRepair);
		ClientMessage(VPMod.Ev_VehicleSteal);
		ClientMessage(VPMod.Ev_C4Disarmed);
		ClientMessage(VPMod.Ev_BeaconDisarmed);
		ClientMessage(VPMod.Ev_VehicleRepairAssist);
		ClientMessage(VPMod.Ev_InfantryRepairKillAssists);
		ClientMessage(VPMod.Ev_CaptureTechBuilding);
		
		//Team-WideBonuses
		ClientMessage(VPMod.Ev_BuildingDestroyed);
		ClientMessage(VPMod.Ev_BuildingArmorBreak);
		ClientMessage(VPMod.Ev_HarvesterDestroyed);
		
		return;
	}
	VeterancySetServer(int(iMultiplier));
}
reliable server function VeterancySetServer(int iMultiplier, optional bool bSkipAuthentication, optional bool bDoResetMode){	//Veterancy Multiply

	local Rx_VeterancyModifiers VPMod;
	local int iMode;

	LogInternal("FunctionCall: VeterancySetServer");
	LogInternal("FunctionCall: VeterancySetServer - iMultiplier:" $ iMultiplier $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=17;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		LogInternal("FunctionCall: VeterancySet - Access check - Accepted");
	
		LogInternal("FunctionCall: VeterancySet - iMultiplier : x" $ iMultiplier);
		
		
		VPMod=Rx_VeterancyModifiers(GetDefaultObject(Class'Rx_VeterancyModifiers'));
		LogInternal("FunctionCall: VeterancySet - VPMod:" $ VPMod);
		
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
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode18  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GodMode(){														//GodMode

	LogInternal("FunctionCall: GodMode");
	GodModeServer();
}
reliable server function GodModeServer(optional string sGodModeStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: GodModeServer");
	LogInternal("FunctionCall: GodModeServer - INPUT - sGodModeStatus:" $ sGodModeStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=18;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{	
		if ( sGodModeStatus ~= "true" || sGodModeStatus ~= "false" )
		{
			bGodMode = bool(sGodModeStatus);
			ClientMessage("God mode " $ bGodMode);
		}
		else 
		{
			bGodMode = (!bGodMode);
			ClientMessage("God mode " $ !bGodMode);
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode19  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function InvisibleMode(){													//InvisibleMode

	LogInternal("FunctionCall: InvisibleMode");
	
	InvisibleModeServer();
}
reliable server function InvisibleModeServer(optional string sInvisibleModeStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: InvisibleModeServer");
	LogInternal("FunctionCall: InvisibleModeServer - INPUT - sInvisibleModeStatus:" $ sInvisibleModeStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);

	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=19;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		if ( sInvisibleModeStatus ~= "true" || sInvisibleModeStatus ~= "false" )
		{
			if ( UTPawn(Pawn) != None )
			{
				UTPawn(Pawn).SetInvisible(bool(sInvisibleModeStatus));
				//Mesh.CastShadow = false;
				//Mesh.bCastDynamicShadow = false;
				//ReattachMesh();
				//PawnShadowMode			
				ClientMessage("InvisibleMode mode " $ bool(sInvisibleModeStatus));
			}
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}
function tempnote(){
/*
UTPawn


simulated function SetInvisible(bool bNowInvisible)
{
	bIsInvisible = bNowInvisible;

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		if (bIsInvisible)
		{
			Mesh.CastShadow = false;
			Mesh.bCastDynamicShadow = false;
			ReattachMesh();
		}
		else
		{
			UpdateShadowSettings(!class'Engine'.static.IsSplitScreen() && class'UTPlayerController'.default.PawnShadowMode == SHADOW_All);
		}
	}
}


*/

}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode20  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function GhostMode(){														//GhostMode

//GhostMode

//
// !!!!!!!!!!!!!!! Later disable weapons for players that use this mode, and only dead can people bring back to normal mode.
//

//UnderWaterTime = -1.0;
//SetCollision(false, false);
//bCollideWorld = false;
//SetPushesRigidBodies(false);

	LogInternal("FunctionCall: GhostMode");
	GhostModeServer();
}
reliable server function GhostModeServer(optional string sGhostModeStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: GhostModeServer");
	LogInternal("FunctionCall: GhostModeServer - INPUT - sGhostModeStatus:" $ sGhostModeStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=20;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		//	if ( (Pawn != None) && Pawn.CheatGhost() )
		if ( Pawn != None )
		{
			if ( sGhostModeStatus ~= "true" || sGhostModeStatus ~= "false" )
			{
				//UnderWaterTime = -1.0;
				SetCollision(!bool(sGhostModeStatus), !bool(sGhostModeStatus));
				//SetPushesRigidBodies(!bool(sGhostModeStatus));
	
				bCheatFlying = bool(sGhostModeStatus);
				bCollideWorld = !bool(sGhostModeStatus);
				ClientMessage("Ghost mode " $ bGodMode);
			}
			else 
			{
				bCheatFlying = (!bCheatFlying);
				bCollideWorld = (!bCollideWorld);
				ClientMessage("Ghost mode " $ !bGodMode);
			}
			
			ClientMessage("You feel " $ bCheatFlying $ " ethereal");
			
			if (bCheatFlying)
			{
				Outer.GotoState('PlayerFlying');
			}
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode21  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function AmphibiousMode(){													//AmphibiousMode

	LogInternal("FunctionCall: AmphibiousMode");
	AmphibiousModeServer();
}
reliable server function AmphibiousModeServer(optional string sAmphibiousModeStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: AmphibiousModeServer");
	LogInternal("FunctionCall: AmphibiousModeServer - INPUT - sAmphibiousModeStatus:" $ sAmphibiousModeStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);

	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=21;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	
	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		if ( Pawn != None )
		{
			if ( sAmphibiousModeStatus ~= "true" )
			{
				Pawn.UnderwaterTime = +999999.0;
			}
			else if ( sAmphibiousModeStatus ~= "false" )
			{
				Pawn.UnderwaterTime = 10.0;
			}
			else
			{
				if ( Pawn.UnderwaterTime < 1000)
				{
					Pawn.UnderwaterTime = +999999.0;
				}
				else
				{
					Pawn.UnderwaterTime = 10.0;
				}
			}
		}	
		
		if ( Pawn.UnderwaterTime > 10 )
		{
			ClientMessage("You feel like a fish");
		}
		else if ( Pawn.UnderwaterTime == 10 )
		{
			ClientMessage("Welcome back mermaid");
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode22  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function FlyMode(){														//FlyMode

	LogInternal("FunctionCall: SetFly");
	FlyModeServer();
}
reliable server function FlyModeServer(optional string sFlyModeStatus, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: FlyModeServer");
	LogInternal("FunctionCall: FlyModeServer - INPUT - sFlyModeStatus:" $ sFlyModeStatus $ " bSkipAuthentication:" $ bSkipAuthentication $ " bDoResetMode:" $ bDoResetMode);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=22;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	

	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
	{
		//if ( (Pawn != None) && Pawn.CheatFly() )
		if (Pawn != None)
		{
			if ( sFlyModeStatus ~= "true" || sFlyModeStatus ~= "false" )
			{
				bCheatFlying = bool(sFlyModeStatus);
			}
			else
			{
				bCheatFlying = (!bCheatFlying);
				Outer.GotoState('PlayerFlying');
			}
			
			if ( bCheatFlying )
			{
				ClientMessage("You feel much lighter");
			}
			else
			{
				ClientMessage("Welcome back superman");
			}
			
			
		}
	}
	else
	{
		ClientMessage( PlayerReplicationInfo.PlayerName $ " : Authenticate Failed!, You are authenticated as:" $ AdminToolAccessLevelAuthCheckName() $ ". You need to be " $ AdminToolAccessLevelAuthCheckName(ModeAccessLevelArray[iMode]) $ ". Try to toggle the option by vote, or ask the server administrator to enable this option for you" );
	}
	return;
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode23  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function SBHFixMode(){														//SBHFixMode

	LogInternal("FunctionCall: SBHFixMode");
	FlyModeServer();
}
reliable server function SBHFixModeServer(optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	//local Pawn P;
	//local weapon W;
	local Rx_Weapon Weap;
	local Rx_InventoryManager myRx_InventoryManager;
	
	LogInternal("FunctionCall: SBHFixModeServer");
	LogInternal("FunctionCall: SBHFixModeServer - bSkipAuthentication:" $ bSkipAuthentication);
	
	foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_InventoryManager', myRx_InventoryManager) break;
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=23;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (!bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	

	
	ForEach Rx_InventoryManager(Pawn.InvManager).InventoryActors(class'Rx_Weapon', Weap)
	{
		if (Weap != None)
		{

		}
			
		if(Rx_InventoryManager(Pawn.InvManager) != none)
		{
			if ( Pawn != None )
			{
				//iAmmoCount = ( Rx_Weapon_Reloadable(Pawn.weapon).ClipSize * Rx_Weapon_Reloadable(Pawn.weapon).InitalNumClips ) - Rx_Weapon_Reloadable(Pawn.weapon).CurrentAmmoInClipClientside;
				//Rx_Weapon_Reloadable(Pawn.weapon).AmmoCount = iAmmoCount;
				//Rx_Weapon_Reloadable(Pawn.weapon).ClientAmmoCount = iAmmoCount;
				
				//myRx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_LaserRifle', CLASS_PRIMARY);
				//myRx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_SMG_Nod', CLASS_SIDEARM);
				//myRx_InventoryManager(InvManager).AddWeaponOfClass(class'Rx_Weapon_TimedC4', CLASS_EXPLOSIVE);
				//myRx_InventoryManager(InvManager).SetWeaponsForPawn();
			}
		}				
	}			
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //    Mode24  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
exec function UkillSendText(string sText ){

	UkillSendTextServer(sText);

}
exec function UkillSendTextShow(){

	UkillSendTextServerShow();

}
exec function UkillSendTextShowSetText(string sText){
	
	UkillSendTextServerSet("Text", sText);

}
exec function UkillSendTextShowSetColor(int iColor){
	
	UkillSendTextServerSet("Color", string(iColor));

}
exec function UkillSendTextShowSetTime(int iTime){
	
	UkillSendTextServerSet("Time", string(iTime));

}
exec function UkillSendTextShowSetSize(float fSize){
	
	UkillSendTextServerSet("Size", string(fSize));

}
exec function UkillSendTextShowSetDelay(float fDelay){
	
	UkillSendTextServerSet("Delay", string(fDelay));

}
exec function UkillSendTextShowSetRepeat(int iRepeat){
	
	UkillSendTextServerSet("Repeat", string(iRepeat));

}
function name UkillSendTextReturnColorName(int iColor){

	local name nReturnValue;

	switch (iColor)
	{
		case 1:
			nReturnValue = 'Orange'; break;		
		case 2:
			nReturnValue = 'Yellow'; break;
		case 3:
			nReturnValue = 'Pink'; break;
		case 4:
			nReturnValue = 'LightGreen'; break;
		case 5:
			nReturnValue = 'Green'; break;
		case 6:
			nReturnValue = 'Red'; break;
		case 7:
			nReturnValue = 'White'; break;
		case 8:
			nReturnValue = 'Blue'; break;
		case 9:
			nReturnValue = 'LightBlue'; break;
	}
	
	return nReturnValue;
}
function int UkillSendTextReturnColorNumber(name nColor){

	local int iReturnValue;

	switch (nColor)
	{
		case 'Orange':
			iReturnValue = 1; break;		
		case 'Yellow':
			iReturnValue = 2; break;		
		case 'Pink':
			iReturnValue = 3; break;		
		case 'LightGreen':
			iReturnValue = 4; break;		
		case 'Green':
			iReturnValue = 5; break;		
		case 'Red':
			iReturnValue = 6; break;		
		case 'White':
			iReturnValue = 7; break;		
		case 'Blue':
			iReturnValue = 8; break;		
		case 'LightBlue':
			iReturnValue = 9; break;
	}

	return iReturnValue;
}
reliable server function UkillSendTextServer(string sText){

	local Rx_Mutator_AdminTool_Controller C;
	local string str1;
	
	if ( !bool(ModeStatusArray[24]) || !AdminToolAccessLevelAuth(3) )
	Return;

	if ( Mid(sText,0,5) ~= "Timer")
	{
		str1 = string(iUkillSendTextRepeat) $ " - " $ Mid(sUkillSendTextText,6);
	}
	else
	{
		str1 = sUkillSendTextText;
	}
	
	
	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', C)
	{
		C.CTextMessage(str1 ,UkillSendTextReturnColorName(iUkillSendTextColor), iUkillSendTextTime, fUkillSendTextSize);
	}
}
reliable server function UkillSendTextServerSet(string sType, string sValue){

	if ( !bool(ModeStatusArray[24]) || !AdminToolAccessLevelAuth(3) )
	Return;
	
	switch (sType)
	{
		case "Size":
			fUkillSendTextSize = float(sValue); break;		
		case "Time":
			iUkillSendTextTime = int (sValue); break;		
		case "Text":
			sUkillSendTextText = sValue; break;		
		case "Color":
			iUkillSendTextColor = int (sValue); break;
		case "Delay":
			fUkillSendTextDelay = float (sValue); break;
		case "Repeat":
			iUkillSendTextRepeat = int (sValue); break;

	}
}
reliable server function UkillSendTextServerShow(){

	if ( !bool(ModeStatusArray[24]) || !AdminToolAccessLevelAuth(3) )
	Return;

	LogInternal("FunctionCall UkillSendTextServerSet - iUkillSendTextColor:" $ iUkillSendTextColor );
	
	if ( iUkillSendTextColor == 9 )
	{
		iUkillSendTextColor = 1;
	}
	else 
	{
		iUkillSendTextColor = iUkillSendTextColor++;	
	}

	if ( iUkillSendTextRepeat > 0)
	{
		iUkillSendTextCount = iUkillSendTextRepeat--;
		SetTimer(fUkillSendTextDelay, false, 'UkillSendTextServerShow');
	}
	
	UkillSendTextServer(sUkillSendTextText);

}
exec function UkillSoundShow(optional int iSoundNumber){						//SMode

	LogInternal("FunctionCall: UkillSoundShow");
	UkillSoundShowServer(iSoundNumber);
}
reliable server function UkillSoundShowServer(optional int iSoundNumber, optional bool bSkipAuthentication, optional bool bDoResetMode){

	local int iMode;
	
	LogInternal("FunctionCall: UkillSoundShowServer");
	LogInternal("FunctionCall: UkillSoundShowServer - bSkipAuthentication:" $ bSkipAuthentication);
	
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	
	iMode=24;	//DONT CHANGE - Used for Authentication Check	 //
	if ( !bool(ModeStatusArray[iMode] ) && !bDoResetMode ) { if (bSkipAuthentication) { return; } else { ClientMessage( PlayerReplicationInfo.PlayerName $ " : Mode" $ iMode $ " - " $ ModeDescriptionArray[iMode] $ "is disabled" ); return; } } 	//Escape while ModeStatus is False.
	/*  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  */	

	//Fix SetTimer value for when its not set right
	if ( ModeSchedulerTimerValueArray[iMode] != 0 && ModeSchedulerTimerValueArray[iMode] != 1 )
	{
		ModeSchedulerTimerValueArray[iMode] = 1;
	}
	
	
	
	switch( iSoundNumber )
	{
		case 1:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.Applause_001_Cue');
			break;
		case 2:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.LooneyTunes_ThatsAllFolks_Cue');
			break;
		case 3:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.DrumRoll_001_Cue');
			break;
		case 4:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.EpicSaxGuy_Cue');
			break;
		case 5:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.GetLow_Cue');
			break;
		case 6:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.SC_Bus_Fire_Looping_Cue');
			break;
		case 7:
			ClientPlaySound(SoundCue'Rx_Ukill.Sounds.ThisIsSparta_Cue');
			break;
	}
//SoundCue'RX_Artic_033.Sounds.EVA_1_MIN_Cue'
//SoundCue'RX_Artic_033.Sounds.EVA_2_MINS_Cue'
//SoundCue'RX_Artic_033.Sounds.CABAL_1_MIN_Cue'
//SoundCue'RX_Artic_033.Sounds.CABAL_2_MIN_Cue'

	return;
//	if ( bSkipAuthentication || (AdminToolAccessLevelAuth(ModeAccessLevelArray[iMode])) && (bool(ModeStatusArray[iMode])) )
//	{
//		ClientMessage( "Counter:" $ Counter $ " SomeTestMode - AutoSetValue:" $ ModeAutoSetVoteValueArray[iMode] );
//	}
//}
//
//
//						if ( iStartCounter == 0 )
//						{
//							iStartCounter=AdminTaskCounter;
//						}
//										
//						if ( ( ModeSchedulerTimerValueArray[24] != 0 || ModeSchedulerTimerValueArray[24] != 15 ) && ( iStartCounter % 15 ) == 0 )
//						{
//							ModeSchedulerTimerValueArray[24] = 15;
//						}
//
//						
//						LogInternal("iStartCounter:" $ iStartCounter);
//						
//						if ( (iStartCounter + 60) > AdminTaskCounter)
//						{
//							if ( iStartCounter == AdminTaskCounter || ( iStartCounter + 15 ) == AdminTaskCounter || ( iStartCounter + 30 ) == AdminTaskCounter || ( iStartCounter + 45 ) == AdminTaskCounter )
//							{
//								switch( iStartCounter )
//								{
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.ThisIsSparta_Cue');
//									case 15:
//										ClientPlaySound(SoundCue'Rx_Ukill.Sounds.DrumRoll_001_Cue');
//										break;
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.EpicSaxGuy_Cue');
//									case 30:
//										ClientPlaySound(SoundCue'Rx_Ukill.Sounds.DrumRoll_001_Cue'); GiveVP(100); 
//										break;
//									case 45:
//										ClientPlaySound(SoundCue'Rx_Ukill.Sounds.DrumRoll_001_Cue'); GiveVP(200);
//										break;
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.GetLow_Cue');
//									case 60:
//										GiveVP(350);
//										iStartCounter=0; ModeSchedulerTimerValueArray[24] = 0;
//										break;
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.SC_Bus_Fire_Looping_Cue');
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.Applause_001_Cue');
//										//ClientPlaySound(SoundCue'Rx_Ukill.Sounds.LooneyTunes_ThatsAllFolks_Cue');
//								}
//							}
//						}

}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //  UseFull  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/
final static function object GetDefaultObject(class ObjClass){

	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}
simulated function AdminToolInfo() {

	local int x;
	local string Msg;

	LogInternal("FunctionCall: AdminToolInfo");
	
	if ((ModeStatusArray[0]) == "true" )
	{
		ClientMessage(" ");
		ClientMessage("----------------------------------------------------------------------");
		ClientMessage("-------------------------- AdminToolInfo -----------------------------");
		ClientMessage("----------------------------------------------------------------------");
		ClientMessage(" ");
		ClientMessage("AccessLevel 0 for None");
		ClientMessage("AccessLevel 1 for All Users");
		ClientMessage("AccessLevel 2 for Administrators");
		ClientMessage("AccessLevel 3 for Developers");
		ClientMessage("AccessLevel 4 for Administrators and Developers");
		ClientMessage(" ");
		ClientMessage("-----------------------------| Mode 0/9 |-----------------------------");
		ClientMessage(" ");
		ClientMessage("  An item is disabled when the Status is set to false");
		ClientMessage("  Players can only toggle the AccessLevel by vote");
		ClientMessage(" ");
		ClientMessage("----------------------------------------------------------------------");
		ClientMessage(" Name:  AccessLevel: Status:  Description:");	
		ClientMessage(" ");

		for (x = 0; x < 10 ; x++)
		{
			Msg = " " $ ModeNameArray[x] $ "         " $ ModeAccessLevelArray[x] $ "           " $ ModeStatusArray[x] $ "     " $ ModeDescriptionArray[x];
			ClientMessage(Msg);
		}

		ClientMessage(" ");
		ClientMessage(" ");
		ClientMessage("----------------------------| Mode 10/19 |----------------------------");
		ClientMessage(" ");
		ClientMessage("  An item is disabled when the AccessLevel is set to 1");
		ClientMessage("  Players can only toggle the Status by vote");
		ClientMessage(" ");
		ClientMessage("----------------------------------------------------------------------");
		ClientMessage(" Name:    AccessLevel:  Status:  Description:");	
		ClientMessage(" ");
		
		for (x = 10; x < ModeArrayLength ; x++)
		{
			Msg = " " $ ModeNameArray[x] $ "          " $ ModeAccessLevelArray[x] $ "            " $ ModeStatusArray[x] $ "      " $ ModeDescriptionArray[x];
			ClientMessage(Msg);
		}
		
		ClientMessage(" ");
	}
}	

/*****************************************************************************/	// Execute a console command in the context of the current level and game engine.
 //  *  //  *  //  *     VoteMenu   *  //  *  //  *  //  *  //  *  //	//		function string ConsoleCommand(string Command, optional bool bWriteToLog = true);
/*****************************************************************************/
exec function Select(string text){ VoteSpecificConsoleCommand(text); } 			//Added for vote console command ConsoleCommand
exec function Mode(string text){ VoteSpecificConsoleCommand(text); } 			//Added for vote console command ConsoleCommand
function EnableVoteMenu(bool donate){

	// just in case, turn off previous one
	DisableVoteMenu();

	if (!donate)
	{
		if (!DebugMode)
		{
			if ( WorldInfo.TimeSeconds < NextVoteTime )
			{
				ClientMessage("You must wait"@ int(NextVoteTime - WorldInfo.TimeSeconds) @"more seconds before you can start another vote.");
				return;
			}
		}
	}
	if (donate) VoteHandler = new (self) class'Rx_CreditDonationHandler';
	else VoteHandler = new (self) class'Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic';		//Change the default Votehandler (for extending the existing vote menu)
	VoteHandler.Enabled(self);
}
function bool IsVoteMenuEnabled(){												/** one1: Returns true if vote menu is enabled. */

	if (VoteHandler != none) return true;
	else return false;
}
function bool IsAdminToolMenuEnabled(){

	if (bAdminToolMenuEnabled)
	{
		return true;
	}
	return false;
}
function DisableVoteMenu(){

	if (VoteHandler != none)
	{
		if (VoteHandler.Disabled())
			VoteHandler = none;
	}
}
function DisableAdminToolMenu(){												/** one1: Disables vote menu or go back 1 step. */

	bAdminToolMenuEnabled=false;
}
function EnableAdminToolMenu(){

	// just in case, turn off previous one
	DisableVoteMenu();
	DisableAdminToolMenu();

	VoteHandler = new (self) class'Rx_Mutator_AdminTool_VoteMenuHandler_Ext_AdminTool';		//add a new Votehandler2 (things that dont need to use the votesystem)
	
	bAdminToolMenuEnabled=true;
	VoteHandler.Enabled(self);
}
exec function SwitchWeapon(byte T){												/** one1: Overriden so that vote menu can get key input. */

	if (VoteHandler != none) {
		VoteHandler.KeyPress(T);
	}
	//else if (VoteHandler_Ext_AdminTool != none) {
	//	VoteHandler.KeyPress(T);
	//} 
	else if(Vet_Menu != none && !Vet_Menu.bPeeling)
	{
	Vet_Menu.ParseInput(T);
	//`log("Vet input" @ T);
	}
	else 
	if(bTauntMenuOpen) 
	{
		if(T <= class<Rx_FamilyInfo>(Rx_PRI(PlayerReplicationInfo).CharClassInfo).default.PawnVoiceClass.default.TauntSounds.Length)
			PlayTaunt(T-1);
	}
	else if(!Rx_PlayerInput(PlayerInput).bAltPressed && !Rx_PlayerInput(PlayerInput).bCntrlPressed && Rx_Weapon(Pawn.Weapon).InventoryGroup != T) {
	super.SwitchWeapon(T);
	}
}
function SendVote(class<Rx_VoteMenuChoice> VoteChoiceClass, string param, int t){	/** one1: Called from VoteMenuChoice objects, when vote is ready to be sent to server. */
	ServerVote(VoteChoiceClass, param, t);
}
reliable server function ServerVote(class<Rx_VoteMenuChoice> VoteChoiceClass, string param, int t){	/** Replicate vote to server. */

	local Rx_Game g;
	
	if (bServerMutedText)
	{
		ClientMessage("Vote rejected - you are muted from chat, including starting votes.");
		return;
	}
	
	if (!DebugMode)
	{
		if( (GetTeamNum() == 0 && (WorldInfo.TimeSeconds <  Rx_Game(WorldInfo.Game).NextChangeMapTime_GDI)) ||(GetTeamNum() == 1 && (WorldInfo.TimeSeconds <  Rx_Game(WorldInfo.Game).NextChangeMapTime_Nod)))	//NextChangeMapTime)
		{
			
			if(
			string(VoteChoiceClass) == "Rx_VoteMenuChoice_Surrender" ||
			string(VoteChoiceClass) == "Rx_VoteMenuChoice_ChangeMap" ||
			string(VoteChoiceClass) == "Rx_VoteMenuChoice_RestartMap")
				{
				
				//UpdateMapOrSurrenderCooldown();
				if(GetTeamNum() == 0) CTextMessage("Map-related Vote Rejected: Team has started one too recently" @ "[" $ (WorldInfo.TimeSeconds <  Rx_Game(WorldInfo.Game).NextChangeMapTime_GDI) $ "]",,120);
				else
				CTextMessage("Map-related Vote Rejected: Team Cooldown in Effect for" @ "[" $ (WorldInfo.TimeSeconds <  Rx_Game(WorldInfo.Game).NextChangeMapTime_Nod) $ "s]",,120);
		
				return;
				}
		}

		if (WorldInfo.TimeSeconds < NextVoteTime)
		{
			ClientMessage("Vote rejected - you've started one too recently.");
			return;
		}
	}
	
	//if(VoteChoiceClass == class'Rx_VoteMenuChoice_Surrender' && !CanSurrender()) 
	if(VoteChoiceClass == class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Surrender' && !CanSurrender()) 
	{
		CTextMessage("Surrender unlocks in " $ string(Rx_Game(Worldinfo.Game).SurrenderDisabledTime - Worldinfo.GRI.ElapsedTime) $ " seconds",'White', 45);
		return; 	
	}
	
	g = Rx_Game(WorldInfo.Game);
	if (g.GlobalVote != none)
	{
		// report that vote is already in progress...
		return;
	}
	
	if (t == -1)
	{
		// global vote
		if (g.GDIVote != none || g.NODVote != none)
		{
			// report, GDI or NOD vote already in progress
			return;
		}

		g.GlobalVote = new (self) VoteChoiceClass;
		g.GlobalVote.ServerInit(self, param, t);
		
	if(isMapRelatedVote(VoteChoiceClass) )	
	{
		UpdateMapOrSurrenderCooldown();
		if(GetTeamNum() == 0 ) Rx_Game(WorldInfo.Game).NextChangeMapTime_GDI = WorldInfo.TimeSeconds+Rx_Game(WorldInfo.Game).VoteTeamCooldown_GDI;
		else
		Rx_Game(WorldInfo.Game).NextChangeMapTime_Nod = WorldInfo.TimeSeconds+Rx_Game(WorldInfo.Game).VoteTeamCooldown_Nod;
	}	
		UpdateVoteCooldown();
	}
	else if (t == 0)
	{
		if (g.GDIVote != none)
		{
			// report, GDI vote already in progress
			return;
		}

		g.GDIVote = new (self) VoteChoiceClass;
		g.GDIVote.ServerInit(self, param, t);
		
		if(isMapRelatedVote(VoteChoiceClass) )	
		{
		UpdateMapOrSurrenderCooldown();
		Rx_Game(WorldInfo.Game).NextChangeMapTime_GDI = WorldInfo.TimeSeconds+Rx_Game(WorldInfo.Game).VoteTeamCooldown_GDI;
		}
		UpdateVoteCooldown();
	}
	else if (t == 1)
	{
		if (g.NODVote != none)
		{
			// report, NOD vote already in progress
			return;
		}

		g.NODVote = new (self) VoteChoiceClass;
		g.NODVote.ServerInit(self, param, t);
		if(isMapRelatedVote(VoteChoiceClass) )
		{
			Rx_Game(WorldInfo.Game).NextChangeMapTime_Nod = WorldInfo.TimeSeconds+Rx_Game(WorldInfo.Game).VoteTeamCooldown_Nod;
			UpdateMapOrSurrenderCooldown();
		}	
	
		UpdateVoteCooldown();
	}
}
function ShowVoteMenuConsole(string preappendtext){								/** one1: Console input for vote choices. */

	local Console PlayerConsole;
	local LocalPlayer LP;

	LP = LocalPlayer( Player );
	
	if( ( LP != None ) && ( LP.ViewportClient.ViewportConsole != None ) )
	{
		if ( Left(preappendtext,5) ~= "admin" )
		{
			PlayerConsole = LocalPlayer( Player ).ViewportClient.ViewportConsole;
			PlayerConsole.StartTyping(preappendtext);
			PlayerConsole.ConsoleCommand(preappendtext);
		}	
		else
		{
			PlayerConsole = LocalPlayer( Player ).ViewportClient.ViewportConsole;
			PlayerConsole.StartTyping(preappendtext);
		}
	}
}
event PlayerTick( float DeltaTime ){

	super.PlayerTick(DeltaTime);

	///** one1: added this here, else console gets closed in single tick. */
	//if (HowMuchCreditsString != "")
	//{
	//	ShowVoteMenuConsole(HowMuchCreditsString);
	//	HowMuchCreditsString = "";
	//}
	
	/** Ukill: added this here, else console gets closed in single tick. */
	if (sSelectedMode != "")
	{	
		ShowVoteMenuConsole(sSelectedMode);
		sSelectedMode = "";
	}	
}

/*****************************************************************************/
 //  *  //  *  //  *  //   KeyPressed  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
function MenuLockToggle(optional bool bUnlockAfter){

	bMenuUnlocked=(!bMenuUnlocked);
	
	if ( bUnlockAfter == true )
	{
		SetTimer(0.15, false, 'MenuLockToggle');
	}
}
function KeyPressed(string sKeyName, bool bIsPressed){

	switch( sKeyName )
	{
		case "Left":
			bKeyLeftPressed=(bIsPressed);
			break;
		case "Right":
			bKeyRightPressed=(bIsPressed);
			break;
		case "Up":
			bKeyUpPressed=(bIsPressed);
			break;
		case "Down":
			bKeyDownPressed=(bIsPressed);
			break;
		//case "C":
		//	bKeyCPressed=(bIsPressed);
		//	break;
	}
}
function bool IsKeyPressed(string sKeyName){

	switch( sKeyName )
	{
		case "Left":
			return bKeyLeftPressed;
			break;
		case "Right":
			return bKeyRightPressed;
			break;
		case "Up":
			return bKeyUpPressed;
			break;
		case "Down":
			return bKeyDownPressed;
			break;
		//case "C":
		//	return bKeyCPressed;
		//	break;
	}
}

/*****************************************************************************/
 //  *  //  *  //  *  //   None Fixes  //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/
//
//exec function DrawGameHud()
//{
//         Canvas.SetPos(Canvas.ClipX/2,Canvas.ClipY/2);
//         Canvas.SetDrawColor(255,255,255,255);
//         Canvas.Font = class'Engine'.static.GetMediumFont();
//         Canvas.DrawText("My Custom Text");
//}
//





exec function CheckHarvester()
{
	CheckHarvesterServer();
}

reliable server function CheckHarvesterServer()
{
	local Actor A;
	local string str1;
	
	//local Rx_Vehicle_Harvester myRx_Vehicle_Harvester;	
	//foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Vehicle_Harvester',myRx_Vehicle_Harvester) break;
	
	foreach AllActors(class'Actor', A)
	{	
		if ( A == None )
		return;
		
		if (InStr(A,"Rx_Vehicle_Harvester_GDI_0") >= 0)
		{		
			str1 = ( A $ ": ");
			if (Rx_Vehicle_Harvester(A).bPlayOpeningAnim){ str1 = str1 $ " Opening "; };
			if (Rx_Vehicle_Harvester(A).bPlayClosingAnim){ str1= str1 $ " Closing "; };
			if (Rx_Vehicle_Harvester(A).bPlayHarvestingAnim){ str1= str1 $ " Harvesting "; };
			if (Rx_Vehicle_Harvester(A).bTurningToDock){ str1= str1 $ " TurningToDock "; };
			
			ClientMessage(str1);
		}
	}
}
//(Rx_Building_Team_Internals(A).SavedDmg);

//int InStr ( coerce string S, coerce string t )


//	Rx_Vehicle_Harvester_GDI_0
//	Rx_Vehicle_Harvester_Nod_0
//	Rx_Vehicle_HarvesterController_0
//	Rx_Vehicle_HarvesterController_1



exec function CheckActor(string sActorName)
{
	CheckActorServer(sActorName);
}

reliable server function CheckActorServer(string sActorName)
{
	local Actor A;
	
	foreach AllActors(class'Actor', A)
	{	
		if ( A == None )
		return;
		
		if (InStr(A,sActorName) >= 0)
		{		
			ClientMessage(A);
		}
	}
}













/**************************************************************************************************************************************************************************************/
  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  DEFAULT PROPERTIES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

defaultproperties 
{
	
	InputClass=class'Rx_Mutator_AdminTool.Rx_Mutator_AdminTool_PlayerInput'

	VoteCommandText = "Vote Menu"
	//DonateCommandText = "Donate"
	AdminToolCommandText = "Advanced Options"
	bMenuUnlocked=true;
	
/* AdminTool variables */
	CounterGlobal=0.0									// Counter starts at 0
	
	DebugMode=false;										// This produces more verbose messagse	//Later add levels to debugmode instead of true and false
	DebugLevel=0;

	sUkillSendTextText = "Welcome"
	iUkillSendTextColor = 1;
	iUkillSendTextCount = 0;
	iUkillSendTextTime = 29;
	fUkillSendTextSize = 0.6;
	fUkillSendTextDelay = 1.0;
	iUkillSendTextRepeat = 9;

//	ClientMessage("Options: MineLimit, VehicleLimit, GoalScore, TimeLimit, bMatchHasBegun, bMatchIsOver, ServerName, RemainingMinute, RemainingTime, ElapsedTime");
//	ClientMessage("StopCountDown, CreditsSilo, CreditsRefinery, AirdropCooldownTime, Health, HealthLocked, HealthMax, BA_HealthMax, TrueHealthMax, Armor");
//	ClientMessage("LowHPWarnLevel, RepairedHPLevel, RepairedArmorLevel, SavedDmg, HealPointsScale, HDamagePointsScale, ADamagePointsScale, Destroyed_Score");
//	ClientMessage("ArmorResetTime, bCanArmorBreak, bDestroyed, bBuildingRecoverable, bCanPlayRepaired");

	BuildingNameArray[0]="rx_capturablemct_mc_internals";					
	BuildingNameArray[1]="rx_capturablemct_internals_kismet";             
	BuildingNameArray[2]="rx_capturablemct_internals";                    
	BuildingNameArray[3]="rx_capturablemct_fort_internals";               
	BuildingNameArray[4]="rx_building_weaponsfactory_internals";          
	BuildingNameArray[5]="rx_building_techbuilding_internals_nosilo";     
	BuildingNameArray[6]="rx_building_techbuilding_internals";            
	BuildingNameArray[7]="rx_building_team_internals";                    
	BuildingNameArray[8]="rx_building_silo_internals";                    
	BuildingNameArray[9]="rx_building_refinery_nod_internals";            
	BuildingNameArray[10]="rx_building_refinery_internals";               
	BuildingNameArray[11]="rx_building_refinery_gdi_internals";           
	BuildingNameArray[12]="rx_building_powerplant_nod_internals";         
	BuildingNameArray[13]="rx_building_powerplant_internals";             
	BuildingNameArray[14]="rx_building_powerplant_gdi_internals";         
	BuildingNameArray[15]="rx_building_obelisk_internals";                
	BuildingNameArray[16]="rx_building_internals";                        
	BuildingNameArray[17]="rx_building_handofnod_internals";              
	BuildingNameArray[18]="rx_building_emp_internals";                    
	BuildingNameArray[19]="rx_building_commcentre_internals";             
	BuildingNameArray[20]="rx_building_barracks_internals";               
	BuildingNameArray[21]="rx_building_airTower_internals";               
	BuildingNameArray[22]="rx_building_airStrip_internals";               
	BuildingNameArray[23]="rx_building_advancedguardtower_internals";     
	
	BuildingNameAliasArray[0] ="capturablemct_mc";			
	BuildingNameAliasArray[1] ="capturablemct_kismet";
	BuildingNameAliasArray[2] ="capturablemct";
	BuildingNameAliasArray[3] ="capturablemct_fort";
	BuildingNameAliasArray[4] ="weaponsfactory,wf";
	BuildingNameAliasArray[5] ="techbuilding_nosilo";
	BuildingNameAliasArray[6] ="techbuilding";
	BuildingNameAliasArray[7] ="team";
	BuildingNameAliasArray[8] ="silo";
	BuildingNameAliasArray[9] ="refinery_nod,ref_nod";
	BuildingNameAliasArray[10]="refinery,ref_all";
	BuildingNameAliasArray[11]="refinery_gdi,ref_gdi";
	BuildingNameAliasArray[12]="powerplant_nod,pp_nod";
	BuildingNameAliasArray[13]="powerplant,pp_all";
	BuildingNameAliasArray[14]="powerplant_gdi,pp_gdi";
	BuildingNameAliasArray[15]="obelisk,obe";
	BuildingNameAliasArray[16]="internals";
	BuildingNameAliasArray[17]="handofnod,hon";
	BuildingNameAliasArray[18]="emp";
	BuildingNameAliasArray[19]="commcentre,coms";
	BuildingNameAliasArray[20]="barracks,bar";
	BuildingNameAliasArray[21]="airtower,tower";
	BuildingNameAliasArray[22]="airstrip,strip";
	BuildingNameAliasArray[23]="advancedguardtower,agt";

//		ClientMessage("Options: MineLimit, VehicleLimit, GoalScore, TimeLimit, bMatchHasBegun, bMatchIsOver, ServerName, RemainingMinute, RemainingTime, ElapsedTime");
//		ClientMessage("StopCountDown, CreditsSilo, CreditsRefinery, AirdropCooldownTime, Health, HealthLocked, HealthMax, BA_HealthMax, TrueHealthMax, Armor");
//		ClientMessage("LowHPWarnLevel, RepairedHPLevel, RepairedArmorLevel, SavedDmg, HealPointsScale, HDamagePointsScale, ADamagePointsScale, Destroyed_Score");
//		ClientMessage("ArmorResetTime, bCanArmorBreak, bDestroyed, bBuildingRecoverable, bCanPlayRepaired");


	BuildingHealthLockedArray[0] = "false";
	BuildingHealthLockedArray[1] = "false";
	BuildingHealthLockedArray[2] = "false";
	BuildingHealthLockedArray[3] = "false";
	BuildingHealthLockedArray[4] = "false";
	BuildingHealthLockedArray[5] = "false";
	BuildingHealthLockedArray[6] = "false";
	BuildingHealthLockedArray[7] = "false";
	BuildingHealthLockedArray[8] = "false";
	BuildingHealthLockedArray[9] = "false";
	BuildingHealthLockedArray[10]= "false";
	BuildingHealthLockedArray[11]= "false";
	BuildingHealthLockedArray[12]= "false";
	BuildingHealthLockedArray[13]= "false";
	BuildingHealthLockedArray[14]= "false";
	BuildingHealthLockedArray[15]= "false";
	BuildingHealthLockedArray[16]= "false";
	BuildingHealthLockedArray[17]= "false";
	BuildingHealthLockedArray[18]= "false";
	BuildingHealthLockedArray[19]= "false";
	BuildingHealthLockedArray[20]= "false";
	BuildingHealthLockedArray[21]= "false";
	BuildingHealthLockedArray[22]= "false";
	BuildingHealthLockedArray[23]= "false";
	
/////////////////////////////	
/* Mode "Toggle Settings" */
////////////////////////////

	//General:
	ModeArrayLength=30; 

	//ModeName
	//The static name of some mode
	ModeNameArray[0]="mode0";		//AllModes				[0]="All modes";
	ModeNameArray[1]="mode1";		//GimmeSpawn            [1]="GimmeSpawn";								
	ModeNameArray[2]="mode2";		//GimmeWeapon           [2]="GimmeWeapon";
	ModeNameArray[3]="mode3";		//GimmeSkin             [3]="GimmeSkin";
	ModeNameArray[4]="mode4";		//Empty                 [4]="Infinite Ammo";
	ModeNameArray[5]="mode5";		//Empty                 [5]="Normalize Health";
	ModeNameArray[6]="mode6";		//Empty                 [6]="Friendly Fire";	
	ModeNameArray[7]="mode7";		//Nuke                  [7]="Nuke";
	ModeNameArray[8]="mode8";		//NukeAll               [8]="NukeAll";
	ModeNameArray[9]="mode9";		//FutureSoldier         [9]="FutureSoldier";
	ModeNameArray[10]="mode10";		//LockBuildings         [10]="Lockbuildings";
	ModeNameArray[11]="mode11";		//Empty                 [11]="WeaponDrop";
	ModeNameArray[12]="mode12";		//Empty                 [12]="DoubleJump";
	ModeNameArray[13]="mode13";		//Empty                 [13]="Low Gravity";
	ModeNameArray[14]="mode14";		//Empty                 [14]="High GameSpeed";		
	ModeNameArray[15]="mode15";		//Empty                 [15]="SlowTimeKills";
	ModeNameArray[16]="mode16";		//Empty                 [16]="Sudden Death";		
	ModeNameArray[17]="mode17";		//Empty                 [17]="Veterancy Multiply";
	ModeNameArray[18]="mode18";		//Empty                 	
	ModeNameArray[19]="mode19";		//Empty
	ModeNameArray[20]="mode20";		//Empty	
	ModeNameArray[21]="mode21";		//Empty
	ModeNameArray[22]="mode22";		//Empty
	ModeNameArray[23]="mode23";		//Empty
	ModeNameArray[24]="mode24";		//Empty
	ModeNameArray[25]="mode25";		//Empty
	ModeNameArray[26]="mode26";		//Empty
	ModeNameArray[27]="mode27";		//Empty
	ModeNameArray[28]="mode28";		//Empty
	ModeNameArray[29]="mode29";		//Empty	
		
	//ModeDescription
	//The firendly name of some mode					"Empty" will disable the mode; ModeAccessByPlayersArray is used to deny access to disabled functions by players.
	ModeDescriptionArray[0]="Admin Tool";				//Admintool (General)
	ModeDescriptionArray[1]="Gimme Sandboxspawn";				//GimmeSpawn
	ModeDescriptionArray[2]="Gimme Weaponspawn";				//GimmeWeapon
	ModeDescriptionArray[3]="Gimme Skin";				//GimmeSkin
	ModeDescriptionArray[4]="Infinite Ammo";			//InfiniteAmmo
	ModeDescriptionArray[5]="Regenerate Health";         //NormalizeHealth
	ModeDescriptionArray[6]="Friendly Fire";	        //FriendlyFire				//Check rockets-hitscanweapons
	ModeDescriptionArray[7]="Nuke";                     //NukeAndIon
	ModeDescriptionArray[8]="NukeAll";                  //NukeAllAndIonAll
	ModeDescriptionArray[9]="FutureSoldier";            //FutureSoldier
	ModeDescriptionArray[10]="Lock Buildings";          //Lockedbuildings
	ModeDescriptionArray[11]="Weapon Drop";              //WeaponDrop
	ModeDescriptionArray[12]="Double Jump";              //DoublJump
	ModeDescriptionArray[13]="Low Gravity";             //LowGravity
	ModeDescriptionArray[14]="High GameSpeed";			//HighGameSpeed				//Conflicts SlowTimeKills
	ModeDescriptionArray[15]="SlowTimeKills";           //SlowTimeKills				//Conflicts GameSpeed
	ModeDescriptionArray[16]="Sudden Death";				//SuddenDeath
	ModeDescriptionArray[17]="Veterancy Multiply x2";	//Veterancy
	ModeDescriptionArray[18]="GodMode";					//GodMode
	ModeDescriptionArray[19]="InvisibleMode";			//InvisibleMode
	ModeDescriptionArray[20]="GhostMode";				//GhostMode
	ModeDescriptionArray[21]="AmphibiousMode";			//AmphibiousMode
	ModeDescriptionArray[22]="FlyMode";					//FlyMode
	ModeDescriptionArray[23]="SBHFixMode";				//SBHFixMode
	ModeDescriptionArray[24]="Ukill TestMode";
	ModeDescriptionArray[25]="Empty";
	ModeDescriptionArray[26]="Empty";
	ModeDescriptionArray[27]="Empty";					//DONT PUT "Empty" STATES INBETWEEN ENABLED ONES!!!!
	ModeDescriptionArray[28]="Empty";
	ModeDescriptionArray[29]="Empty";
	
	//ModeChoiceDescription
	//Options that can be done with a mode status
	ModeStatusChoiceArray[0]="Enable";
	ModeStatusChoiceArray[1]="Disable";
	ModeStatusChoiceArray[2]="Toggle";
	
	//ModeStatus; 
	//Can be used if Authentication succeed.	true = Enabled or false = Disabled
	ModeStatusArray[0]="true"; 					//Admintool (General)
	ModeStatusArray[1]="false";	                //GimmeSpawn
	ModeStatusArray[2]="false";	                //GimmeWeapon
	ModeStatusArray[3]="false";	                //GimmeSkin
	ModeStatusArray[4]="false";	                //InfiniteAmmo
	ModeStatusArray[5]="false"; 	           	//NormalizeHealth
	ModeStatusArray[6]="false"; 	            //FriendlyFire				//Check rockets-hitscanweapons
	ModeStatusArray[7]="false"; 	           	//NukeAndIon
	ModeStatusArray[8]="false"; 	           	//NukeAllAndIonAll
	ModeStatusArray[9]="false"; 	            //FutureSoldier
	ModeStatusArray[10]="true";	           		//Lockedbuildings
	ModeStatusArray[11]="false";	            //WeaponDrop
	ModeStatusArray[12]="false";	            //DoublJump
	ModeStatusArray[13]="false";	            //LowGravity
	ModeStatusArray[14]="false";	            //HighGameSpeed				//Conflicts SlowTimeKills
	ModeStatusArray[15]="false";	            //SlowTimeKills				//Conflicts GameSpeed
	ModeStatusArray[16]="true";	           	//SuddenDeath
	ModeStatusArray[17]="false";	           	//Veterancy
	ModeStatusArray[18]="false";				//GodMode
	ModeStatusArray[19]="false";	            //InvisibleMode
	ModeStatusArray[20]="false";	            //GhostMode
	ModeStatusArray[21]="false";	            //AmphibiousMode
	ModeStatusArray[22]="false";				//FlyMode
	ModeStatusArray[23]="false";	            //SBHFixMode
	ModeStatusArray[24]="false";				
	ModeStatusArray[25]="false";	
	ModeStatusArray[26]="false";	
	ModeStatusArray[27]="false";	
	ModeStatusArray[28]="false";	
	ModeStatusArray[29]="false";
	
	//ModeAccessLevel; 
	//who can use some mode:					0="None",1="None" 2="All Users", 3="Administrators", 4="Developers", 5="Administrators or Developers"
	ModeAccessLevelArray[0]=3; 					//Admintool (General)
	ModeAccessLevelArray[1]=2;                  //GimmeSpawn
	ModeAccessLevelArray[2]=1;	                //GimmeWeapon
	ModeAccessLevelArray[3]=1;                  //GimmeSkin
	ModeAccessLevelArray[4]=1;	 //VoteAbility  //InfiniteAmmo
	ModeAccessLevelArray[5]=1;   //Admin-Only   //NormalizeHealth
	ModeAccessLevelArray[6]=1;                  //FriendlyFire				//Check rockets-hitscanweapons
	ModeAccessLevelArray[7]=1;                  //NukeAndIon
	ModeAccessLevelArray[8]=1;                  //NukeAllAndIonAll
	ModeAccessLevelArray[9]=1;	//Admin-only                  //FutureSoldier
	ModeAccessLevelArray[10]=1; //VoteAbility   //Lockedbuildings
	ModeAccessLevelArray[11]=1;                 //WeaponDrop
	ModeAccessLevelArray[12]=1;                 //DoublJump
	ModeAccessLevelArray[13]=1;                 //LowGravity
	ModeAccessLevelArray[14]=1;                 //HighGameSpeed				//Conflicts SlowTimeKills
	ModeAccessLevelArray[15]=1;                 //SlowTimeKills				//Conflicts GameSpeed
	ModeAccessLevelArray[16]=1;                 //SuddenDeath
	ModeAccessLevelArray[17]=1;                 //Veterancy
	ModeAccessLevelArray[18]=1;					//GodMode
	ModeAccessLevelArray[19]=1;                 //InvisibleMode
	ModeAccessLevelArray[20]=1;                 //GhostMode
	ModeAccessLevelArray[21]=1;                 //AmphibiousMode
	ModeAccessLevelArray[22]=1;                 //FlyMode
	ModeAccessLevelArray[23]=1;					//SBHFixMode
	ModeAccessLevelArray[24]=1;                 
	ModeAccessLevelArray[25]=1;
	ModeAccessLevelArray[26]=1;
	ModeAccessLevelArray[27]=1;
	ModeAccessLevelArray[28]=1;
	ModeAccessLevelArray[29]=1;

	
	//ModeAccessByPlayersArray;
	//is the mode visible for all players ( VoteMenu and HelpMenu )? 		0="Disabled", 1="Enabled"
	
	iAccessByPlayersVoteMenuExtension=1;
	iAccessByPlayersAdminToolMenu=1;
	ModeAccessByPlayersArray[0]=0;				//VoteMenu ???
	
	ModeAccessByPlayersArray[1]=0;              //GimmeSpawn
	ModeAccessByPlayersArray[2]=0;              //GimmeWeapon
	ModeAccessByPlayersArray[3]=0;	            //GimmeSkin
	ModeAccessByPlayersArray[4]=1;	            //InfiniteAmmo
	ModeAccessByPlayersArray[5]=1;              //NormalizeHealth
	ModeAccessByPlayersArray[6]=0;	            //FriendlyFire				//Check rockets-hitscanweapons
	ModeAccessByPlayersArray[7]=0;              //NukeAndIon
	ModeAccessByPlayersArray[8]=0;              //NukeAllAndIonAll
	ModeAccessByPlayersArray[9]=0;	            //FutureSoldier
	ModeAccessByPlayersArray[10]=1;             //Lockedbuildings
	ModeAccessByPlayersArray[11]=0;             //WeaponDrop
	ModeAccessByPlayersArray[12]=0;             //DoublJump
	ModeAccessByPlayersArray[13]=0;             //LowGravity
	ModeAccessByPlayersArray[14]=0;             //HighGameSpeed				//Conflicts SlowTimeKills
	ModeAccessByPlayersArray[15]=0;             //SlowTimeKills				//Conflicts GameSpeed
	ModeAccessByPlayersArray[16]=1;             //SuddenDeath
	ModeAccessByPlayersArray[17]=1;             //Veterancy
	ModeAccessByPlayersArray[18]=0;				//GodMode
	ModeAccessByPlayersArray[19]=0;             //InvisibleMode
	ModeAccessByPlayersArray[20]=0;				//GhostMode
	ModeAccessByPlayersArray[21]=0;				//AmphibiousMode
	ModeAccessByPlayersArray[22]=0;				//FlyMode
	ModeAccessByPlayersArray[23]=0;				//SBHFixMode
	ModeAccessByPlayersArray[24]=0;								
	ModeAccessByPlayersArray[25]=0;								
	ModeAccessByPlayersArray[26]=0;								
	ModeAccessByPlayersArray[27]=0;								
	ModeAccessByPlayersArray[28]=0;								
	ModeAccessByPlayersArray[29]=0;
	
	
	// TIMER CURRENT VALUE
	//Value 0 will disable the timer / AutoTask for some mode
	iAdminTaskTimerValue=1;
	ModeSchedulerTimerValueArray[0]=15;			//Admintool (General) ReplicationTimer AdminTask
	ModeSchedulerTimerValueArray[1]=0;          //GimmeSpawn
	ModeSchedulerTimerValueArray[2]=0;          //GimmeWeapon
	ModeSchedulerTimerValueArray[3]=0;	        //GimmeSkin
	ModeSchedulerTimerValueArray[4]=0; 			//InfiniteAmmo (every other value then 0 will be set to 60)
	ModeSchedulerTimerValueArray[5]=0;          //NormalizeHealth
	ModeSchedulerTimerValueArray[6]=0;	        //FriendlyFire				//Check rockets-hitscanweapons
	ModeSchedulerTimerValueArray[7]=0;          //NukeAndIon
	ModeSchedulerTimerValueArray[8]=0;          //NukeAllAndIonAll
	ModeSchedulerTimerValueArray[9]=0;	        //FutureSoldier
	ModeSchedulerTimerValueArray[10]=60;        //Lockedbuildings
	ModeSchedulerTimerValueArray[11]=0;         //WeaponDrop
	ModeSchedulerTimerValueArray[12]=0;         //DoublJump
	ModeSchedulerTimerValueArray[13]=0;         //LowGravity
	ModeSchedulerTimerValueArray[14]=0;         //HighGameSpeed				//Conflicts SlowTimeKills
	ModeSchedulerTimerValueArray[15]=0;         //SlowTimeKills				//Conflicts GameSpeed
	ModeSchedulerTimerValueArray[16]=60;        //SuddenDeath
	ModeSchedulerTimerValueArray[17]=0;        //Veterancy
	ModeSchedulerTimerValueArray[18]=0;			//GodMode
	ModeSchedulerTimerValueArray[19]=0;	        //InvisibleMode
	ModeSchedulerTimerValueArray[20]=0;			//GhostMode
	ModeSchedulerTimerValueArray[21]=0;         //AmphibiousMode
	ModeSchedulerTimerValueArray[22]=0;         //FlyMode
	ModeSchedulerTimerValueArray[23]=0;         //SBHFixMode
	ModeSchedulerTimerValueArray[24]=0;         
	ModeSchedulerTimerValueArray[25]=0;
	ModeSchedulerTimerValueArray[26]=0;
	ModeSchedulerTimerValueArray[27]=0;
	ModeSchedulerTimerValueArray[28]=0;
	ModeSchedulerTimerValueArray[29]=0;

	// What to do when mode gets triggerd by vote or autotask
	
	// 	Only run task
	//	000 = Default			(only run)
	
	// 	What to do before autotask task runs...						Filter:
	//	100 = Timer				(Set Timer)							Mid(ModeAutoSetProcedureArray[x],0,1) == 1
	// 	000 = Timer				(Reset Timer)	
	//	010 = Status			(Set Status)						Mid(ModeAutoSetProcedureArray[x],1,1) == 1
	//	001 = AccessLevel		(Set Access Level)					Mid(ModeAutoSetProcedureArray[x],2,1) == 1


	
	ModeAutoSetProcedureArray[0]="000";		//Admintool (General)
	ModeAutoSetProcedureArray[1]="011";		//GimmeSpawn
	ModeAutoSetProcedureArray[2]="011";		//GimmeWeapon
	ModeAutoSetProcedureArray[3]="011";		//GimmeSkin
	ModeAutoSetProcedureArray[4]="111";		//InfiniteAmmo
	ModeAutoSetProcedureArray[5]="111";		//NormalizeHealth
	ModeAutoSetProcedureArray[6]="111";		//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetProcedureArray[7]="000";		//NukeAndIon
	ModeAutoSetProcedureArray[8]="000";		//NukeAllAndIonAll
	ModeAutoSetProcedureArray[9]="011";		//FutureSoldier
	ModeAutoSetProcedureArray[10]="110";	//Lockedbuildings
	ModeAutoSetProcedureArray[11]="111";	//WeaponDrop
	ModeAutoSetProcedureArray[12]="111";	//DoubleJump
	ModeAutoSetProcedureArray[13]="111";	//LowGravity
	ModeAutoSetProcedureArray[14]="111";	//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetProcedureArray[15]="111";	//SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetProcedureArray[16]="110";	//SuddenDeath
	ModeAutoSetProcedureArray[17]="110";	//Veterancy
	ModeAutoSetProcedureArray[18]="000";	//GodMode
	ModeAutoSetProcedureArray[19]="000";	//InvisibleMode
	ModeAutoSetProcedureArray[20]="000";	//GhostMode
	ModeAutoSetProcedureArray[21]="000";	//AmphibiousMode
	ModeAutoSetProcedureArray[22]="000";	//FlyMode
	ModeAutoSetProcedureArray[23]="000";	//SBHFixMode
	ModeAutoSetProcedureArray[24]="000";	//UkillFunMode                                    
	ModeAutoSetProcedureArray[25]="000";
	ModeAutoSetProcedureArray[26]="000";
	ModeAutoSetProcedureArray[27]="000";
	ModeAutoSetProcedureArray[28]="000";
	ModeAutoSetProcedureArray[29]="000";

	//99991 is set for modes that only need one time activation, and dont need any user interaction after activated
	// VALUE USED WHEN THE ModeSchedulerTimerValueArray NEEDS TO BE SET BY SERVER, VOTE OR TASK
	// WHEN VALUE'S CHANGED BELOW, CHANGE ALSO ABOVE VALUE ->	ModeAutoSetProcedureArray[X] TO 100
	ModeAutoSetTimerArray[0]=15;			//Admintool (General)
	ModeAutoSetTimerArray[1]=0;  	        //GimmeSpawn
	ModeAutoSetTimerArray[2]=0;  	        //GimmeWeapon
	ModeAutoSetTimerArray[3]=0;		        //GimmeSkin
	ModeAutoSetTimerArray[4]=45; 		    //InfiniteAmmo
	ModeAutoSetTimerArray[5]=1;  	        //NormalizeHealth
	ModeAutoSetTimerArray[6]=99991;		    //FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetTimerArray[7]=0;  	        //NukeAndIon
	ModeAutoSetTimerArray[8]=0;  	        //NukeAllAndIonAll
	ModeAutoSetTimerArray[9]=0;		        //FutureSoldier
	ModeAutoSetTimerArray[10]=60; 	        //Lockedbuildings
	ModeAutoSetTimerArray[11]=99991; 	    //WeaponDrop
	ModeAutoSetTimerArray[12]=99991; 	    //DoubleJump
	ModeAutoSetTimerArray[13]=99991; 	    //LowGravity
	ModeAutoSetTimerArray[14]=99991; 	    //HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetTimerArray[15]=99991; 	    //SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetTimerArray[16]=60; 	        //SuddenDeath
	ModeAutoSetTimerArray[17]=600; 	        //Veterancy
	ModeAutoSetTimerArray[18]=0;		    //GodMode
	ModeAutoSetTimerArray[19]=0;		    //InvisibleMode
	ModeAutoSetTimerArray[20]=0;		    //GhostMode
	ModeAutoSetTimerArray[21]=0; 	        //AmphibiousMode
	ModeAutoSetTimerArray[22]=0; 	        //FlyMode
	ModeAutoSetTimerArray[23]=99991; 	    //SBHFixMode
	ModeAutoSetTimerArray[24]=0; 	        //UkillFunMode                                    
	ModeAutoSetTimerArray[25]=0;	                                      
	ModeAutoSetTimerArray[26]=0;	
	ModeAutoSetTimerArray[27]=0;	
	ModeAutoSetTimerArray[28]=0;	
	ModeAutoSetTimerArray[29]=0;	
	
	
	// This settings will be set when modes get a reset or when switched off
	ModeAutoSetDefaultValueArray[0]="";						//Admintool (General)
	ModeAutoSetDefaultValueArray[1]="";             		//GimmeSpawn
	ModeAutoSetDefaultValueArray[2]="";            			//GimmeWeapon
	ModeAutoSetDefaultValueArray[3]="";	            		//GimmeSkin
	ModeAutoSetDefaultValueArray[4]="false";	           	//InfiniteAmmo
	ModeAutoSetDefaultValueArray[5]="0";	            	//NormalizeHealth
	ModeAutoSetDefaultValueArray[6]="0" 					//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetDefaultValueArray[7]="";	            		//NukeAndIon
	ModeAutoSetDefaultValueArray[8]="";	            		//NukeAllAndIonAll
	ModeAutoSetDefaultValueArray[9]="31";	            	//FutureSoldier
	ModeAutoSetDefaultValueArray[10]="false";           	//Lockedbuildings
	ModeAutoSetDefaultValueArray[11]="true";	            //WeaponDrop
	ModeAutoSetDefaultValueArray[12]="";	            	//DoubleJump
	ModeAutoSetDefaultValueArray[13]="-250";				//LowGravity
	ModeAutoSetDefaultValueArray[14]="1";					//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetDefaultValueArray[15]="false";	            //SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetDefaultValueArray[16]="false";           	//SuddenDeath
	ModeAutoSetDefaultValueArray[17]="1";            		//Veterancy
	ModeAutoSetDefaultValueArray[18]="false";				//GodMode
	ModeAutoSetDefaultValueArray[19]="false";	            //InvisibleMode
	ModeAutoSetDefaultValueArray[20]="false";	            //GhostMode
	ModeAutoSetDefaultValueArray[21]="false";				//AmphibiousMode
	ModeAutoSetDefaultValueArray[22]="false";               //FlyMode
	ModeAutoSetDefaultValueArray[23]="false";               //SBHFixMode
	ModeAutoSetDefaultValueArray[24]="1";                   //UkillFunMode                                    
	ModeAutoSetDefaultValueArray[25]="";                                                  
	ModeAutoSetDefaultValueArray[26]="";
	ModeAutoSetDefaultValueArray[27]="";
	ModeAutoSetDefaultValueArray[28]="";
	ModeAutoSetDefaultValueArray[29]="";

	// This settings will be set when a custom value is set, this will, be used later, to activate customised vote's.
	ModeAutoSetCustomValueArray[0]="";										//Admintool (General)
	ModeAutoSetCustomValueArray[1]="TimedC4";                           	//GimmeSpawn
	ModeAutoSetCustomValueArray[2]="renx_game.Rx_Weapon_RepairTool";    	//GimmeWeapon
	ModeAutoSetCustomValueArray[3]="31";                                	//GimmeSkin
	ModeAutoSetCustomValueArray[4]="true";                              	//InfiniteAmmo
	ModeAutoSetCustomValueArray[5]="1";                                 	//NormalizeHealth
	ModeAutoSetCustomValueArray[6]="1";                                 	//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetCustomValueArray[7]="";                                  	//NukeAndIon
	ModeAutoSetCustomValueArray[8]="";                                  	//NukeAllAndIonAll
	ModeAutoSetCustomValueArray[9]="31";                                	//FutureSoldier
	ModeAutoSetCustomValueArray[10]="true";                             	//Lockedbuildings
	ModeAutoSetCustomValueArray[11]="true";                             	//WeaponDrop
	ModeAutoSetCustomValueArray[12]="";                                 	//DoubleJump
	ModeAutoSetCustomValueArray[13]="-250";                             	//LowGravity
	ModeAutoSetCustomValueArray[14]="1.25";                             	//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetCustomValueArray[15]="true";                             	//SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetCustomValueArray[16]="true";                             	//SuddenDeath
	ModeAutoSetCustomValueArray[17]="2";                                	//Veterancy
	ModeAutoSetCustomValueArray[18]="true";                             	//GodMode
	ModeAutoSetCustomValueArray[19]="true";                             	//InvisibleMode
	ModeAutoSetCustomValueArray[20]="true";                             	//GhostMode
	ModeAutoSetCustomValueArray[21]="true";                             	//AmphibiousMode
	ModeAutoSetCustomValueArray[22]="true";                             	//FlyMode
	ModeAutoSetCustomValueArray[23]="true";                             	//SBHFixMode
	ModeAutoSetCustomValueArray[24]="";                                 	//UkillFunMode                                    
	ModeAutoSetCustomValueArray[25]="";
	ModeAutoSetCustomValueArray[26]="";
	ModeAutoSetCustomValueArray[27]="";
	ModeAutoSetCustomValueArray[28]="";
	ModeAutoSetCustomValueArray[29]="";

	// This settings will be set when some mode gets activated by vote.
	ModeAutoSetVoteValueArray[0]="";										//Admintool (General)
	ModeAutoSetVoteValueArray[1]="TimedC4";             					//GimmeSpawn
	ModeAutoSetVoteValueArray[2]="renx_game.Rx_Weapon_RepairTool";			//GimmeWeapon
	ModeAutoSetVoteValueArray[3]="31";	            						//GimmeSkin
	ModeAutoSetVoteValueArray[4]="true";	           						//InfiniteAmmo
	ModeAutoSetVoteValueArray[5]="1";	            						//NormalizeHealth
	ModeAutoSetVoteValueArray[6]="1" 										//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetVoteValueArray[7]="";	            						//NukeAndIon
	ModeAutoSetVoteValueArray[8]="";	            						//NukeAllAndIonAll
	ModeAutoSetVoteValueArray[9]="31";	            						//FutureSoldier
	ModeAutoSetVoteValueArray[10]="true";           						//Lockedbuildings
	ModeAutoSetVoteValueArray[11]="true";	            					//WeaponDrop
	ModeAutoSetVoteValueArray[12]="";	            						//DoubleJump
	ModeAutoSetVoteValueArray[13]="-250";									//LowGravity
	ModeAutoSetVoteValueArray[14]="1.25";									//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetVoteValueArray[15]="";	            						//SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetVoteValueArray[16]="true";           						//SuddenDeath
	ModeAutoSetVoteValueArray[17]="2";            							//Veterancy
	ModeAutoSetVoteValueArray[18]="false";									//GodMode
	ModeAutoSetVoteValueArray[19]="false";									//InvisibleMode
	ModeAutoSetVoteValueArray[20]="false";									//GhostMode
	ModeAutoSetVoteValueArray[21]="false";									//AmphibiousMode
	ModeAutoSetVoteValueArray[22]="false";									//FlyMode
	ModeAutoSetVoteValueArray[23]="false";									//SBHFixMode
	ModeAutoSetVoteValueArray[24]="";										//UkillFunMode 
	ModeAutoSetVoteValueArray[25]="";                                                  
	ModeAutoSetVoteValueArray[26]="";
	ModeAutoSetVoteValueArray[27]="";
	ModeAutoSetVoteValueArray[28]="";
	ModeAutoSetVoteValueArray[29]="";

	// This settings will used to check if the ModeAutoSetCustomValue is in wanted range
	ModeAutoSetMinValueArray[0]=""; 										//Admintool (General)
	ModeAutoSetMinValueArray[1]=""; 										//GimmeSpawn
	ModeAutoSetMinValueArray[2]=""; 										//GimmeWeapon
	ModeAutoSetMinValueArray[3]="1"; 										//GimmeSkin
	ModeAutoSetMinValueArray[4]="false"; 									//InfiniteAmmo
	ModeAutoSetMinValueArray[5]="1"; 										//NormalizeHealth
	ModeAutoSetMinValueArray[6]="0"; 										//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetMinValueArray[7]="false"; 									//NukeAndIon
	ModeAutoSetMinValueArray[8]="false"; 									//NukeAllAndIonAll
	ModeAutoSetMinValueArray[9]="false";									//FutureSoldier
	ModeAutoSetMinValueArray[10]="false";									//Lockedbuildings
	ModeAutoSetMinValueArray[11]="";										//WeaponDrop
	ModeAutoSetMinValueArray[12]="";										//DoubleJump
	ModeAutoSetMinValueArray[13]="-1";										//LowGravity
	ModeAutoSetMinValueArray[14]="0.1";										//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetMinValueArray[15]="false";									//SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetMinValueArray[16]="false";									//SuddenDeath
	ModeAutoSetMinValueArray[17]="1";										//Veterancy
	ModeAutoSetMinValueArray[18]="false";									//GodMode
	ModeAutoSetMinValueArray[19]="false";									//InvisibleMode
	ModeAutoSetMinValueArray[20]="false";									//GhostMode
	ModeAutoSetMinValueArray[21]="false";									//AmphibiousMode
	ModeAutoSetMinValueArray[22]="false";									//FlyMode
	ModeAutoSetMinValueArray[23]="false";									//SBHFixMode
	ModeAutoSetMinValueArray[24]="0";										//UkillFunMode
	ModeAutoSetMinValueArray[25]="";
	ModeAutoSetMinValueArray[26]="";
	ModeAutoSetMinValueArray[27]="";
	ModeAutoSetMinValueArray[28]="";
	ModeAutoSetMinValueArray[29]="";

	// This settings will used to check if the ModeAutoSetCustomValue is in wanted range
	ModeAutoSetMaxValueArray[0]=""; 										//Admintool (General)
	ModeAutoSetMaxValueArray[1]=""; 										//GimmeSpawn
	ModeAutoSetMaxValueArray[2]=""; 										//GimmeWeapon
	ModeAutoSetMaxValueArray[3]="32"; 										//GimmeSkin
	ModeAutoSetMaxValueArray[4]="true";										//InfiniteAmmo
	ModeAutoSetMaxValueArray[5]="200"; 										//NormalizeHealth
	ModeAutoSetMaxValueArray[6]="9999"; 									//FriendlyFire				//Check rockets-hitscanweapons
	ModeAutoSetMaxValueArray[7]=""; 										//NukeAndIon
	ModeAutoSetMaxValueArray[8]=""; 										//NukeAllAndIonAll
	ModeAutoSetMaxValueArray[9]="true";										//FutureSoldier
	ModeAutoSetMaxValueArray[10]="true";									//Lockedbuildings
	ModeAutoSetMaxValueArray[11]="true";									//WeaponDrop
	ModeAutoSetMaxValueArray[12]="true";									//DoubleJump
	ModeAutoSetMaxValueArray[13]="-2000";									//LowGravity
	ModeAutoSetMaxValueArray[14]="5";										//HighGameSpeed				//Conflicts SlowTimeKills
	ModeAutoSetMaxValueArray[15]="true";									//SlowTimeKills				//Conflicts GameSpeed
	ModeAutoSetMaxValueArray[16]="true";									//SuddenDeath
	ModeAutoSetMaxValueArray[17]="64";										//Veterancy
	ModeAutoSetMaxValueArray[18]="true";									//GodMode
	ModeAutoSetMaxValueArray[19]="true";									//InvisibleMode
	ModeAutoSetMaxValueArray[20]="true";									//GhostMode
	ModeAutoSetMaxValueArray[21]="true";									//AmphibiousMode
	ModeAutoSetMaxValueArray[22]="true";									//FlyMode
	ModeAutoSetMaxValueArray[23]="true";									//SBHFixMode
	ModeAutoSetMaxValueArray[24]="1";										//UkillFunMode
	ModeAutoSetMaxValueArray[25]="";
	ModeAutoSetMaxValueArray[26]="";
	ModeAutoSetMaxValueArray[27]="";
	ModeAutoSetMaxValueArray[28]="";
	ModeAutoSetMaxValueArray[29]="";

	
/////////////////////////////
/* Sandbox Spawn variables */
/////////////////////////////

	iSpawnWaitTime = 10;
	
	ClassItemPreFixArrayLength = 5;
	SandboxItemPreFixArray[0]="Rx_Vehicle_";			//0-16
	SandboxItemPreFixArray[1]="Ts_Vehicle_";			//17-23
	SandboxItemPreFixArray[2]="Rx_Weapon_Deployed";		//24-29
	SandboxItemPreFixArray[3]="Rx_Defence_";			//30-35
	SandboxItemPreFixArray[4]="Rx_Projectile_";			//36-40
	SandboxItemPreFixArray[5]="Rx_Weapon_";				//41
	
	ClassItemNameArrayLength = 42;
	// ClassNamePrefix Rx_Vehicle_
	SandboxItemNameArray[0]="Humvee";
	SandboxItemNameArray[1]="Buggy";
	SandboxItemNameArray[2]="APC_GDI";
	SandboxItemNameArray[3]="APC_Nod";
	SandboxItemNameArray[4]="LightTank";
	SandboxItemNameArray[5]="MediumTank";
	SandboxItemNameArray[6]="FlameTank";
	SandboxItemNameArray[7]="StealthTank";
	SandboxItemNameArray[8]="MammothTank";
	SandboxItemNameArray[9]="Chinook_GDI";
	SandboxItemNameArray[10]="Chinook_Nod";
	SandboxItemNameArray[11]="Orca";
	SandboxItemNameArray[12]="Apache";
	SandboxItemNameArray[13]="A10";
	SandboxItemNameArray[14]="C130";
	SandboxItemNameArray[15]="Hovercraft_GDI";
	SandboxItemNameArray[16]="Bus";
	
	// ClassNamePrefix Ts_Vehicle_
	SandboxItemNameArray[17]="Wolverine";
	SandboxItemNameArray[18]="HoverMRLS";
	SandboxItemNameArray[19]="Titan";
	SandboxItemNameArray[20]="Buggy";
	SandboxItemNameArray[21]="ReconBike";
	SandboxItemNameArray[22]="TickTank";
	SandboxItemNameArray[23]="APB_Vehicle_TeslaTank";
	
	// ClassNamePrefix Rx_Weapon_Deployed
	SandboxItemNameArray[24]="ProxyC4";
	SandboxItemNameArray[25]="RemoteC4";
	SandboxItemNameArray[26]="TimedC4";
	SandboxItemNameArray[27]="ATMine";
	SandboxItemNameArray[28]="IonCannonBeacon";
	SandboxItemNameArray[29]="NukeBeacon";
	
	// ClassNamePrefix Rx_Defence_
	SandboxItemNameArray[30]="GunEmplacement";
	SandboxItemNameArray[31]="RocketEmplacement";
	SandboxItemNameArray[32]="Turret";
	SandboxItemNameArray[33]="SAM_Site";
	SandboxItemNameArray[34]="GuardTower";
	SandboxItemNameArray[35]="AATower";
	
	// ClassNamePrefix Rx_Projectile_
	SandboxItemNameArray[36]="Grenade";
	SandboxItemNameArray[37]="MissileLauncher";
	SandboxItemNameArray[38]="SmokeGrenade";
	SandboxItemNameArray[39]="EMPGrenade";
	SandboxItemNameArray[40]="Rocket_AGT";
	
	// ClassNamePrefix Rx_Weapon_
	SandboxItemNameArray[41]="CrateNuke";
	
	ClassItemDescriptionArrayLength = 42;
	SandboxItemDescriptionArray[0]=" ";
	SandboxItemDescriptionArray[1]=" ";
	SandboxItemDescriptionArray[2]=" ";
	SandboxItemDescriptionArray[3]=" ";
	SandboxItemDescriptionArray[4]=" ";
	SandboxItemDescriptionArray[5]=" ";
	SandboxItemDescriptionArray[6]=" ";
	SandboxItemDescriptionArray[7]=" ";
	SandboxItemDescriptionArray[8]=" ";
	SandboxItemDescriptionArray[9]=" ";
	SandboxItemDescriptionArray[10]=" ";
	SandboxItemDescriptionArray[11]=" ";
	SandboxItemDescriptionArray[12]=" ";
	SandboxItemDescriptionArray[13]=" ";
	SandboxItemDescriptionArray[14]=" ";
	SandboxItemDescriptionArray[15]=" ";
	SandboxItemDescriptionArray[16]=" ";
	SandboxItemDescriptionArray[17]=" ";
	SandboxItemDescriptionArray[18]=" ";
	SandboxItemDescriptionArray[19]=" ";
	SandboxItemDescriptionArray[20]=" ";
	SandboxItemDescriptionArray[21]=" ";
	SandboxItemDescriptionArray[22]=" ";
	SandboxItemDescriptionArray[23]=" ";
	SandboxItemDescriptionArray[24]=" ";
	SandboxItemDescriptionArray[25]=" ";
	SandboxItemDescriptionArray[26]=" ";
	SandboxItemDescriptionArray[27]=" ";
	SandboxItemDescriptionArray[28]=" ";
	SandboxItemDescriptionArray[29]=" ";
	SandboxItemDescriptionArray[30]="(not mannable)";
	SandboxItemDescriptionArray[31]="(not mannable)";
	SandboxItemDescriptionArray[32]="(Nod aligned)";
	SandboxItemDescriptionArray[33]="(Nod aligned)";
	SandboxItemDescriptionArray[34]="(GDI aligned)";
	SandboxItemDescriptionArray[35]="(GDI aligned)";
	SandboxItemDescriptionArray[36]=" ";
	SandboxItemDescriptionArray[37]=" ";
	SandboxItemDescriptionArray[38]=" ";
	SandboxItemDescriptionArray[39]=" ";
	SandboxItemDescriptionArray[40]=" ";
	SandboxItemDescriptionArray[41]="(faster NukeBeacon)";

/////////////////////////////
/* GimmeWeapon variables */
/////////////////////////////

	GimmeWeaponItemNameArray[0]="AutoRifle_GDI";
	GimmeWeaponItemNameArray[1]="AutoRifle_Nod";
	GimmeWeaponItemNameArray[2]="Airstrike_GDI";
	GimmeWeaponItemNameArray[3]="Airstrike_Nod";
	GimmeWeaponItemNameArray[4]="ATMine";
	GimmeWeaponItemNameArray[5]="Carbine";
	GimmeWeaponItemNameArray[6]="Carbine_Silencer";
	GimmeWeaponItemNameArray[7]="Chaingun_GDI";
	GimmeWeaponItemNameArray[8]="Chaingun_Nod";
	GimmeWeaponItemNameArray[9]="ChemicalThrower";
	GimmeWeaponItemNameArray[10]="EMPGrenade_Rechargeable";
	GimmeWeaponItemNameArray[11]="FlakCannon";
	GimmeWeaponItemNameArray[12]="FlameThrower";
	GimmeWeaponItemNameArray[13]="Grenade";
	GimmeWeaponItemNameArray[14]="GrenadeLauncher";
	GimmeWeaponItemNameArray[15]="Grenade_Rechargeable";
	GimmeWeaponItemNameArray[16]="HeavyPistol";
	GimmeWeaponItemNameArray[17]="IonCannonBeacon";
	GimmeWeaponItemNameArray[18]="LaserChaingun";
	GimmeWeaponItemNameArray[19]="LaserRifle";
	GimmeWeaponItemNameArray[20]="NukeBeacon";
	GimmeWeaponItemNameArray[21]="MarksmanRifle_GDI";
	GimmeWeaponItemNameArray[22]="MarksmanRifle_Nod";
	GimmeWeaponItemNameArray[23]="Pistol";
	GimmeWeaponItemNameArray[24]="ProxyC4";
	GimmeWeaponItemNameArray[25]="Railgun";
	GimmeWeaponItemNameArray[26]="RamjetRifle";
	GimmeWeaponItemNameArray[27]="RemoteC4";
	GimmeWeaponItemNameArray[28]="RepairGun";
	GimmeWeaponItemNameArray[29]="RepairGunAdvanced";
	GimmeWeaponItemNameArray[30]="RepairTool";
	GimmeWeaponItemNameArray[31]="PersonalIonCannon";
	GimmeWeaponItemNameArray[32]="SMG_GDI";
	GimmeWeaponItemNameArray[33]="SMG_Nod";
	GimmeWeaponItemNameArray[34]="SMG_Silenced_GDI";
	GimmeWeaponItemNameArray[35]="SMG_Silenced_Nod";
	GimmeWeaponItemNameArray[36]="SmokeGrenade_Rechargeable";
	GimmeWeaponItemNameArray[37]="SniperRifle_GDI";
	GimmeWeaponItemNameArray[38]="SniperRifle_Nod";
	GimmeWeaponItemNameArray[39]="TacticalRifle";
	GimmeWeaponItemNameArray[40]="TiberiumAutoRifle";
	GimmeWeaponItemNameArray[41]="TiberiumFlechetteRifle";
	GimmeWeaponItemNameArray[42]="TimedC4";
	GimmeWeaponItemNameArray[43]="TimedC4_Multiple";
	GimmeWeaponItemNameArray[44]="VoltAutoRifle_GDI";
	GimmeWeaponItemNameArray[45]="VoltAutoRifle_Nod";

/////////////////////////////
/* GimmeSkin variables */
/////////////////////////////
	
	/*arrayvariable[index] = value					Specify 1 item*/
//The default data for a dynamic array can either be specified per element, similar to static arrays, or for the entire array at once. The per-element syntax is identical to that of static arrays:

	//Set the name references
	SkinItemNameArray[0] = "GDI_Soldier";
    SkinItemNameArray[1] = "GDI_Shotgunner";
    SkinItemNameArray[2] = "GDI_Engineer";	
    SkinItemNameArray[3] = "GDI_Officer";
    SkinItemNameArray[4] = "GDI_Grenadier";
    SkinItemNameArray[5] = "GDI_RocketSoldier";
    SkinItemNameArray[6] = "GDI_McFarland";
    SkinItemNameArray[7] = "GDI_Deadeye";
    SkinItemNameArray[8] = "GDI_Gunner";
    SkinItemNameArray[9] = "GDI_Patch";
    SkinItemNameArray[10] = "GDI_Havoc";
    SkinItemNameArray[11] = "GDI_Sydney";
    SkinItemNameArray[12] = "GDI_Mobius";
    SkinItemNameArray[13] = "GDI_Hotwire";
    SkinItemNameArray[14] = "Nod_Soldier";
    SkinItemNameArray[15] = "Nod_Shotgunner";
    SkinItemNameArray[16] = "Nod_FlameTrooper";
    SkinItemNameArray[17] = "Nod_Engineer";
    SkinItemNameArray[18] = "Nod_Officer";
    SkinItemNameArray[19] = "Nod_RocketSoldier";
    SkinItemNameArray[20] = "Nod_ChemicalTrooper";
    SkinItemNameArray[21] = "Nod_BlackHandSniper";
    SkinItemNameArray[22] = "Nod_StealthBlackHand";
    SkinItemNameArray[23] = "Nod_LaserChainGunner";
    SkinItemNameArray[24] = "Nod_Sakura";
    SkinItemNameArray[25] = "Nod_Ravenshaw";
    SkinItemNameArray[26] = "Nod_Mendoza";
    SkinItemNameArray[27] = "Nod_Technician";
    SkinItemNameArray[28] = "Nod_FutureSoldier";
    SkinItemNameArray[29] = "GDI_FutureSoldier";
    SkinItemNameArray[30] = "GDI_FutureSoldier_Old";
	SkinItemNameArray[31] = "Nod_Soldier_Green";
	SkinItemNameArray[32] = "UT_Crowd_Robot";	 

	//Set the Meshes according to the SkinItemNameArray
	SkinMeshNameArray[0] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier';
	SkinMeshNameArray[1] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Shotgunner';
	SkinMeshNameArray[2] =  SkeletalMesh'rx_ch_engineer.Mesh.SK_CH_Engineer_GDI';
	SkinMeshNameArray[3] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_Officer_New';
	SkinMeshNameArray[4] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Grenadier';
	SkinMeshNameArray[5] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_RocketSoldier';
	SkinMeshNameArray[6] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_McFarland';
	SkinMeshNameArray[7] =  SkeletalMesh'rx_ch_gdi_deadeye.Mesh.SK_CH_Deadeye';
	SkinMeshNameArray[8] =  SkeletalMesh'RX_CH_GDI_Gunner.Mesh.SK_CH_Gunner_NewRig';
	SkinMeshNameArray[9] =  SkeletalMesh'rx_ch_gdi_patch.Mesh.SK_CH_Patch';
	SkinMeshNameArray[10] = SkeletalMesh'RX_CH_GDI_Havoc.Mesh.SK_CH_Havoc';
	SkinMeshNameArray[11] = SkeletalMesh'rx_ch_gdi_sydney.Mesh.SK_CH_Sydney';
	SkinMeshNameArray[12] = SkeletalMesh'rx_ch_gdi_mobius.Mesh.SK_CH_Mobius_New';
	SkinMeshNameArray[13] = SkeletalMesh'rx_ch_gdi_hotwire.Mesh.SK_CH_Hotwire_New';
	SkinMeshNameArray[14] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier';
	SkinMeshNameArray[15] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Black';
	SkinMeshNameArray[16] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Red';
	SkinMeshNameArray[17] = SkeletalMesh'rx_ch_engineer.Mesh.SK_CH_Engineer_Nod';
	SkinMeshNameArray[18] = SkeletalMesh'rx_ch_nod_officer.Mesh.SK_CH_Officer_Nod';
	SkinMeshNameArray[19] = SkeletalMesh'rx_ch_nod_officer.Mesh.SK_CH_RocketOfficer_Nod';
	SkinMeshNameArray[20] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_ChemicalTrooper';
	SkinMeshNameArray[21] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_BlackHandSniper';
	SkinMeshNameArray[22] = SkeletalMesh'RX_CH_Nod_SBH.Mesh.SK_CH_StealthBlackHand';
	SkinMeshNameArray[23] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_LaserChainGunner';
	SkinMeshNameArray[24] = SkeletalMesh'RX_CH_Nod_Sakura.Mesh.SK_CH_Sakura';
	SkinMeshNameArray[25] = SkeletalMesh'RX_CH_Nod_Raveshaw.Mesh.SK_CH_Raveshaw';
	SkinMeshNameArray[26] = SkeletalMesh'RX_CH_Nod_Mendoza.Mesh.SK_CH_Mendoza';
	SkinMeshNameArray[27] = SkeletalMesh'RX_CH_Technician.Meshes.SK_CH_Technician';
	SkinMeshNameArray[28] = SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE';
	SkinMeshNameArray[29] = SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier';
	SkinMeshNameArray[30] = SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE';
	SkinMeshNameArray[31] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Green'
	SkinMeshNameArray[32] = SkeletalMesh'utexamplecrowd.Mesh.SK_Crowd_Robot';
	
////////////////////////////////
/*  SlowTimeKills variables   */
////////////////////////////////

	//	fSlowTime=0.250;							//Float to store the GameSpeedValue when player do a SlowTimeKill.
	//	fRampUpTime=0.2;							//Delta Seconds is the time between each frame / ..................
	//	fSlowSpeed=0.175;							//GameSpeed While SlowTimeKills

}