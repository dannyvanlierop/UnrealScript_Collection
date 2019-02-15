// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu9 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
//class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Help extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;
	//DependsOn (Rx_Mutator_AdminTool_Controller);
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Help extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;

/********************************************************************************************/
// VARIABLES DECLERATION IS DONE IN CLASS Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool
/********************************************************************************************/

/*****************************************************************************/
//  *  //  *  //  *  //  Displaying the VoteMenu  //  *  //  *  //  *  //  * //
/*****************************************************************************/
function array<string> GetDisplayStrings()
{
	local array<string> ret;
	local int u,v,x,y;


	iCurrentTierAvailable=33;


	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	// CurrentTier 9 and below
	//if ( CurrentTier <= 9 && 9 > CurrentTier && myAdminTool_Controller.bKeyDownPressed ) { GoOtherTier(); }
	//if ( CurrentTier > 0 && myAdminTool_Controller.bKeyUpPressed) { GoOtherTier(true); }
	
	// CurrentTier 10 and above
	if ( ( myAdminTool_Controller.bKeyDownPressed || myAdminTool_Controller.bKeyRightPressed ) && CurrentTier >= 10 && iCurrentTierAvailable > CurrentTier) { GoOtherTier(); }
	if ( ( myAdminTool_Controller.bKeyUpPressed || myAdminTool_Controller.bKeyLeftPressed ) && CurrentTier > 10 && CurrentTier != 10 ) { GoOtherTier(true); }
	

	if ( CurrentTier == 0 )
	{	
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ ": ");
			ret.AddItem(" ");
			ret.AddItem("Select option: (Typ the number, followed by the Enter key)");
			ret.AddItem(" ");
			
			y=1; u=0;
			
			for (x = 0; x <= 19 ; x++)
			{
				if ( x == 0 || myAdminTool_Controller.ModeDescriptionArray[x] != "Empty" && myAdminTool_Controller.ModeAccessByPlayersArray[x] != 0 && x < myAdminTool_Controller.ModeArrayLength )
				{
					ret.AddItem( y $": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
				}
				else
				{
					u++;
				}
				
				if ( x == 19)
				{
					for ( v = ( u + 1 ) ; v != 0  ; v-- )
					{
						ret.AddItem(" ");
					}
				}
				
				y++;
			}
		}		
		else if ( myAdminTool_Controller.iColumnNumber == 3 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			
			y=21; u=0;
			
			for (x = 20; x <= 39 ; x++)
			{
				if ( myAdminTool_Controller.ModeDescriptionArray[x] != "Empty" && myAdminTool_Controller.ModeAccessByPlayersArray[x] != 0 && x < myAdminTool_Controller.ModeArrayLength )
				{
					ret.AddItem( y $": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
				}
				else
				{
					u++;
				}
				
				if ( x == 39)
				{
					for ( v = ( u + 1 ) ; v != 0  ; v-- )
					{
						ret.AddItem(" ");
					}
				}
				
				y++;
			}
		}	
		else if ( myAdminTool_Controller.iColumnNumber == 5 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			
			y=41; u=0;
			
			for (x = 40; x <= 59 ; x++)
			{
				if ( myAdminTool_Controller.ModeDescriptionArray[x] != "Empty" && myAdminTool_Controller.ModeAccessByPlayersArray[x] != 0 && x < myAdminTool_Controller.ModeArrayLength )
				{
					ret.AddItem( y $": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
				}
				else
				{
					u++;
				}
				
				if ( x == 59)
				{
					for ( v = ( u + 1 ) ; v != 0  ; v-- )
					{
						ret.AddItem(" ");
					}
				}
				
				y++;
			}
		}	
		else if ( myAdminTool_Controller.iColumnNumber == 7 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			
			y=61; u=0;
			
			for (x = 60; x <= 79 ; x++)
			{
				if ( myAdminTool_Controller.ModeDescriptionArray[x] != "Empty" && myAdminTool_Controller.ModeAccessByPlayersArray[x] != 0 && x < myAdminTool_Controller.ModeArrayLength )
				{
					ret.AddItem( y $": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
				}
				else
				{
					u++;
				}
				
				if ( x == 79)
				{
					for ( v = ( u + 1 ) ; v != 0  ; v-- )
					{
						ret.AddItem(" ");
					}
				}
				
				y++;
			}
		}
	}		
	else if ( CurrentTier == 10 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - AdminTool" );
			ret.AddItem(" ");
			ret.AddItem("Admintool is used to enable/disable modes, set Access for certain users to the modes, also it is possible to set DefaultValue's that can be timed so this will keep (re)set the mode setting while the game is running.");
			ret.AddItem("It add one extra value to the normal votemenu, in there will be advanced votes. Minimal resolution required for now is 1920x1080");
			ret.AddItem("There is a seperate AdminToolMenu added to the default menu that will not use the vote system, in there will be options like help and summary, and options only available for Administrators");
			ret.AddItem(" ");
			ret.AddItem("Console command and Parameters:");
			ret.AddItem(" ");
			ret.AddItem("Admintool info ");
			ret.AddItem("Admintool {True|False}");
			ret.AddItem(" ");
			ret.AddItem("Admintool {ModeName|SetAll} {Status} {AccessLevel} ");
			ret.AddItem("Admintool {ModeName|SetAll} {AccessLevel} ");
			ret.AddItem("Admintool {ModeName|SetAll} {Status}");
			ret.AddItem("Admintool {ModeName|SetAll} {Visible | Hidden} ");
			ret.AddItem(" ");
			ret.AddItem("Admintool {ModeName|SetAll} SetTimer {Value}");
			ret.AddItem("Admintool {ModeName|SetAll} SetDefault {Value}");
			ret.AddItem("Admintool {ModeName|SetAll} SetMin {Value}");
			ret.AddItem("Admintool {ModeName|SetAll} SetMax {Value}");
			ret.AddItem(" ");
			ret.AddItem("For questions and idea's you can send me a pmsg on the Renegade-x.com forum, have fun!!    [CT] Ukill aka Ukilleddanny.nl");
			ret.AddItem("Special credits go to !!! -> Schmitzenbergh <- !!! and !!! -> FFFreak9999 <- !!!");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
		if ( myAdminTool_Controller.iColumnNumber == 3 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Goal: ");
			ret.AddItem(" ");
			ret.AddItem("Show Summary of modes");
			ret.AddItem("Enable/Disable AdminTool");
			ret.AddItem(" ");
			ret.AddItem("Set Status and AccessLevel of modes:");
			ret.AddItem("Who can access a mode options");
			ret.AddItem("Is there access to the mode options");
			ret.AddItem("Is the mode available in votemenu");
			ret.AddItem("Is the menu available for players");
			ret.AddItem(" ");
			ret.AddItem("Set the mode Trigger Timer");
			ret.AddItem("Set used value for when Timer gets triggerd");
			ret.AddItem("Minimal value that can be set as default or vote value");
			ret.AddItem("Maximal value that can be set as default or vote value");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
		if ( myAdminTool_Controller.iColumnNumber == 5 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Value's:");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("True = AdminTool Enabled, False = AdminTool Disabled ");
			ret.AddItem(" ");
			ret.AddItem("AccessLevel and Status be swapped");
			ret.AddItem("0=None, 1=None, 2=All Users, 3=Administrators, 4=Developers, 5=Administrators and Developers");
			ret.AddItem("True=Enabled, False=Disabled");
			ret.AddItem("Hidden, Visible"  );
			ret.AddItem("Hidden, Visible"  );
			ret.AddItem(" ");
			ret.AddItem("SetTimerValue(int)(string)");
			ret.AddItem("SetDefaultValue (string)");
			ret.AddItem("SetMinValue (string)");
			ret.AddItem("SetMaxValue (string)");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 11 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - GimmeSpawn" );
			ret.AddItem(" ");
			ret.AddItem("When this mode is enables it is possible to spawn items in single/multiplayergames. From the list below you could choose a {ItemName}, and run the command: GimmeSpawn {ItemName} ");
			ret.AddItem("Single items can be disabled by the administrator, also the time between spawns can be changed");
			ret.AddItem("");
			ret.AddItem(" ");
			ret.AddItem("Console command and Parameters: ");
			ret.AddItem("GimmeSpawn {SpawnName} ");
			ret.AddItem(" ");
			ret.AddItem("GroupName:");
			ret.AddItem("Rx_Vehicle_");
			ret.AddItem(" ");
			ret.AddItem("TS_Vehicle_");
			ret.AddItem("Rx_Weapon_Deployed");
			ret.AddItem("Rx_Weapon_");
			ret.AddItem("Rx_Defence");
			ret.AddItem("Rx_Projectile");
			ret.AddItem(" ");
			ret.AddItem("¹Disabled by default ");
			ret.AddItem("²Not available, not added to the user friendly GimmeSpawn mutator or removed from source. ");
			ret.AddItem(" ");
			ret.AddItem("I did put the groupname in here for informational purpose, u dont need to add it in the console ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
		else if ( myAdminTool_Controller.iColumnNumber == 2 )
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("ItemName: ");
			ret.AddItem(" ");
			ret.AddItem("A10, Apache, APC_GDI, APC_Nod, Buggy, Bus¹, C130¹, Chinook_GDI, Chinook_Nod, FlameTank, Harvester_GDI², Harvester_Nod², Hovercraft_GDI, Humvee, LightTank, MammothTank, MediumTank, Orca, StealthTank");
			ret.AddItem(" ");
			ret.AddItem("HoverMRLS, ReconBike, TickTank, Titan, Wolverine, TeslaTank²");
			ret.AddItem("Buggy, IonCannonBeacon, NukeBeacon, ProxyC4, RemoteC4, TimedC4");
			ret.AddItem("CrateNuke ");
			ret.AddItem("GunEmplacement(not mannable), RocketEmplacement(not mannable), Turret(Nod aligned), SAM Site(Nod aligned), GuardTower(GDI aligned), AATower(GDI aligned)");
			ret.AddItem("Grenade, MissileLauncher, SeekingRocket², SmokeGrenade, EMPGrenade, Rocket_AGT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 12 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - GimmeWeapon" );
			ret.AddItem(" ");
			ret.AddItem("Some bla bla");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: GimmeWeapon {WeaponName} ");
			ret.AddItem(" ");
			ret.AddItem("ItemName: ");
			ret.AddItem(" ");
			ret.AddItem("AutoRifle_GDI, AutoRifle_Nod, Airstrike_GDI, Airstrike_Nod, ATMine, Carbine, Carbine_Silencer, Chaingun_GDI, Chaingun_Nod, ChemicalThrower, EMPGrenade_Rechargeable, FlakCannon, FlameThrower");
			ret.AddItem("Grenade, GrenadeLauncher, Grenade_Rechargeable, HeavyPistol, IonCannonBeacon, LaserChaingun, LaserRifle, NukeBeacon, MarksmanRifle_GDI, MarksmanRifle_Nod");
			ret.AddItem("Pistol, ProxyC4, Railgun, RamjetRifle, RemoteC4, RepairGun, RepairGunAdvanced, RepairTool, PersonalIonCannon, SMG_GDI, SMG_Nod, SMG_Silenced_GDI, SMG_Silenced_Nod");
			ret.AddItem("SmokeGrenade_Rechargeable, SniperRifle_GDI, SniperRifle_Nod, TacticalRifle, TiberiumAutoRifle, TiberiumFlechetteRifle, TimedC4, TimedC4_Multiple, VoltAutoRifle_GDI, VoltAutoRifle_Nod");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 13 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - GimmeSkin" );
			ret.AddItem(" ");
			ret.AddItem("Some bla bla");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: GimmeSkin {SkinName} ");
			ret.AddItem(" ");
			ret.AddItem("GDI Skins: ");
			ret.AddItem(" ");
			ret.AddItem("GDI_Deadeye, GDI_Engineer, GDI_FutureSoldier, GDI_FutureSoldier_Old, GDI_Grenadier, GDI_Gunner, GDI_Havoc, GDI_Hotwire");
			ret.AddItem("GDI_McFarland, GDI_Mobius, GDI_Officer, GDI_Patch, GDI_RocketSoldier, GDI_Shotgunner, GDI_Soldier, GDI_Sydney ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Nod Skins: ");
			ret.AddItem("Nod_BlackHandSniper, Nod_ChemicalTrooper, Nod_Engineer, Nod_FlameTrooper, Nod_FutureSoldier, Nod_LaserChainGunner, Nod_Mendoza, Nod_Officer");
			ret.AddItem("Nod_Ravenshaw, Nod_RocketSoldier, Nod_Sakura, Nod_Shotgunner, Nod_Soldier, Nod_Soldier_Green, Nod_StealthBlackHand, Nod_Technician");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Nod Skins: ");
			ret.AddItem("UT_Crowd_Robot");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");ret.AddItem(" ");;
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 14 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Infinite Ammo" );
			ret.AddItem(" ");
			ret.AddItem("This will give you Infinite Ammo ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem("This option will use the DefaultValue that is set");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 15 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Normalize Health" );
			ret.AddItem(" ");
			ret.AddItem("This option will auto heal every soldier");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 16 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Friendly Fire" );
			ret.AddItem(" ");
			ret.AddItem("With this option enabled, you will be able to give damage team-mates");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 17 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Nuke/Ion" );
			ret.AddItem(" ");
			ret.AddItem("With this option it is Possible to nuke/ion a player in game");
			ret.AddItem("It will on have....to the current player, and not harm buldings");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: Nuke {PlayerName}");
			ret.AddItem(" ");
			ret.AddItem("Command: Ion {PlayerName}");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 18 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - NukeAll/IonAll" );
			ret.AddItem(" ");
			ret.AddItem("With this option it is Possible to nuke/ion every player in game at once");
			ret.AddItem("It will on have....to all the player/bots ingame, and not harm buldings");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: NukeAll {NoArguments!}");
			ret.AddItem(" ");
			ret.AddItem("Command: IonAll {NoArguments!}");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 19 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - FutureSoldier" );
			ret.AddItem(" ");
			ret.AddItem("This option will give the futuresoldier skin to a soldier");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: FutureSoldier");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 20 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - LockBuildings" );
			ret.AddItem(" ");
			ret.AddItem("This option will lock the buildinghealth, so it is possible to play against each other without having worries that buildings get destroyed");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: LockBuildings {true/false}");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 21 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - WeaponDrop" );
			ret.AddItem(" ");
			ret.AddItem("This option will activate weapondrop in game");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 22 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - DoublJump" );
			ret.AddItem(" ");
			ret.AddItem("With this option turned on Players are able to do a jumo while already jumping");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 23 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - LowGravity" );
			ret.AddItem(" ");
			ret.AddItem("With this option you can set the Gravity of the game");
			ret.AddItem("It will have effect on all the objects in game");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 24 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - HighGameSpeed" );
			ret.AddItem(" ");
			ret.AddItem("With this option you can set the gamespeed of the game");
			ret.AddItem("It will have effect on all the objects in game");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 25 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - SlowTimeKills" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 26 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Sudden Death" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 27 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - Veterancy Multiplyer" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 28 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - GodMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 29 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - InvisibleMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 30 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - GhostMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 31 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - AmphibiousMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 32 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - FlyMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
		}
	}
	else if ( CurrentTier == 33 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ " - " $ (CurrentTier - 9) $ " - SBHFixMode" );
			ret.AddItem(" ");
			ret.AddItem(" TODO - CREATE CONTENT");
			ret.AddItem("SBH will have weapons when he has not");
			ret.AddItem("SBH wont be able to spawn or pickup a (1k soldier) weapon ");
			ret.AddItem(" ");
			ret.AddItem("Command: None");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem( "ARROWKEY: Previous <-" );
		}
	}
	return ret;
}


// About choices while you in an VoteMenu at some "CurrentTier"
function KeyPress(byte T)
{
	if (CurrentTier >= 0 && CurrentTier <=9)
	{
		if (T >= 1 && T <= 9)
		{
			Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayText $ T);
		}
	}	
	else if (CurrentTier >= 10)
	{

	}
}

// About
function InputFromConsole(string text)
{
	local string s;
	local int i, x, y;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;

	y=myAdminTool_Controller.ModeArrayLength + 1;
	
	for (x = 0; x <= myAdminTool_Controller.ModeArrayLength ; x++)
	{
		if ( myAdminTool_Controller.ModeDescriptionArray[x] == "Empty" )
		{
			y--;
		}
	}

	s = Right(text, Len(text) - 8);
	i = Min(int(s), y); // do not go over y 

	if ( CurrentTier <= 9 ) { i=i+9; }

	CurrentTier=i;
}

function bool GoBack()
{
	switch (CurrentTier)
	{
		case 0:
			return true; // kill this submenu
			
		default:
			if (CurrentTier > 1)
			{
				CurrentTier = 0;
				return false;
			}
	
			CurrentTier = 0;
			return false;
	}
}


/*****************************************************************************/
//  *  //  *  //  *  //  *  //  Other  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/

DefaultProperties
{
	MenuDisplayString = "Help"
	ConsoleDisplayText = "Select option: "
}