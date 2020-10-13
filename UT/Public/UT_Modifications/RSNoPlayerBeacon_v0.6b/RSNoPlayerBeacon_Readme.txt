=============================================================================
 RSNoPlayerBeacon (alias No Tags mutator)
 March 21, 2014
 Version: 0.6b
 ----------------------------------------------------------------------------
 Description:
 -----------
 A mutator which will remove the player beacon in any gametype
=============================================================================
 Name: RSNoPlayerBeacon
 Friendly Name: No Player Beacon
 Compatiblity: NOT TESTED (works in 2.1, could be lower)
 Version: 0.6 Beta
 Size: ~ 173 KB
 Comment: /
 Credits: Epic Games, mauz (Idea)
-----------------------------------------------------------------------------
 Coded by RattleSN4K3
 Mail: RattleSN4K3@googlemail.com
=============================================================================

Description:
--------------------------------------------------------
This mutator will remove the player beacons which are shown above a player's
head. This beacons are also known as Tags. Pro players / duelers like to have
this beacons off.

This mutator also adds the ability to remove such beacons from team players as
well. In addition you can remove the beacons of any vehicle in the game. This
includes removing its healthbar. If you drive that vehicle the health bar on
the lower right corner is still visible.

This mutator also includes removing the beacons of Nodes in the Warfare gametype.
With the default configuration, it will keep the special nodes called Key nodes.
These are rendered throught the map even if the node is behind walls. But this
mutator also removes these key node beacons if you are insight of it.

With the default configuration, every beacon will be removed. The Orb beacon in
the Warfare game type is kept and won't be hidden by this mutator.

You can also enable the option to show the player named under the player's
crosshair.



Features:
--------------------------------------------------------
- Disables player beacons (alias Tags) for every player
- Disables Titan beacons
- Disables Vehicle beacons
- Disables Warfare Node beacons
- Beacons can be disabled separately
- Works with all stock game types and support for custom game types
- Configurable via ini file (config)
- Configurable via UI scene (in mutator selection)
- Configurable via WebAdmin
- Full net support
- Full compatibility to any mutators (like UTComp)
  * the Pawn class needs to derive from UTPawn (will work if the function 'DrawPlayerBeacon' is not modified that much)
- No replacement of Pawn, PlayerController classes (or anything)
- Works for instant action and online games
- Spectator support (important for SpectatorUI mutator by WGH)



Installation:
--------------------------------------------------------
- Copy the content of the archive into this directory:
  .\My Games\Unreal Tournament 3\UTGame\

Manually:
- Copy the Config file "UTRSNoPlayerBeacon.ini" into your config folder
  .\My Games\Unreal Tournament 3\UTGame\Config
- Copy the script file "RSNoPlayerBeacon.u" into your Script folder
  .\My Games\Unreal Tournament 3\UTGame\Published\CookedPC\Script
- Copy the localization file "RSNoPlayerBeacon.int" into your Localization folder
  .\My Games\Unreal Tournament 3\UTGame\Published\CookedPC\Localization



Uninstallation:
--------------------------------------------------------
- Delete the Config file "UTRSNoPlayerBeacon.ini"
- Delete the script file "RSNoPlayerBeacon.u"
- Delete the localization file "RSNoPlayerBeacon.int"



Usage:
--------------------------------------------------------
- Method 1:
  - Start the game
  - Add the mutator "No Player Beacon"
  - Configure the mutator
  - Enjoy.
- Method 2:
  - add this line to the commannd line arguments:
    ?mutator=RSNoPlayerBeacon.NoPlayerBeaconMutator
- Method 3:
  - Open the WedAdmin
  - Navigate to the following address
    /ServerAdmin/current/change
  - Enable "No Player Beacon"
  - Click "Change game"
  - After the reload, the mutator will be active.



Configuration:
--------------------------------------------------------
You can either change values of the ini file, open the configure menu in your
mutator selection or goto the WebAdmin section "/ServerAdmin/settings/mutators"
once a game is started, select "No Player Beacon" out of the selectionbox and 
wait until a new page is generated. This page allows you to change values
on-the-fly.

The webadmin interface is only available for LAN/online games not Instant-Action.

Section:
[NoPlayerBeaconConfig NoPlayerBeaconConfig]

- DisableAllBeacons={true|false}
  Whether to disable all beacon of any player, vehicle or node. If this variable
  is set to true, every other Hide-variables will be ignored. As the Hide-variables
  are split into normal and team-based games, some custom game types could be a
  problem. If you want to get rid of all beacons in any case, also set this variable
  to true.
  (Default: false)

- GuaranteedMode={true|false}
  The guaranteed mode will disable the beacons every single tick. If some beacons
  will popup up eventually, you should set enable this mode. If guaranteed mode is
  set to false, the script will run in 'performance mode' and the beacons are only
  checked every 250ms.
  (Default: false)

- EnablePlayerName={true|false}
  Whether to enable showing the player name under the crosshair
  (Default: true)

- PlayerNameFriendlyOnly={true|false}
  Whether to show the names for friendly players only
  (Default: true)

- SkipSpectator={true|false}
  Whether to ignore spectator from removing the player beacons. Enabling this will
  add support for mutator SpectatorUI.
  (Default: true)

- HideTeamPlayerBeacons={true|false}
  Whether to hide the player beacon in team-based games
  (Default: true)

- HideEnemyPlayerBeacons={true|false}
  Whether to hide the player beacons of enemies in Deathmatch and so
  (Default: true)

- HideTeamVehicleBeacons={true|false}
  Whether to hide the vehicle beacon in team-based games
  (Default: true)

- HideEnemyVehicleBeacons={true|false}
  Whether to hide the vehicle beacons in in Deathmatch and so
  (Default: true)

- HideTeamTitanBeacons={true|false}
  Whether to hide the Titan beacon in team-based games
  (Default: true)

- HideEnemyTitanBeacons={true|false}
  Whether to hide the Titan beacons in in Deathmatch and so
  (Default: true)

- ShowMessages={true|false}
  Whether to show message clientsided when configuration changes are made. If you
  make any changes in the WebAdmin configuration tab, the changes will be send to
  all clients. You can disable that message by settings this value to false.
  (Default: true)

- ShowInitialMessage={true|false}
  Whether to show a initial message containing all settings. This message will be
  sent to any connecting clients. There is no delay. The message can still be seen
  in the console. This message contains a basic string of all removed beacons.
  (Default: true)

- HideNodeBeacons={true|false}
  Whether to hide the Warfare Node beacons.
  (Default: true)

- KeepKeyNodeBeacons={true|false}
  Whether to keep the Key nodes in Wafare if the other beacons are removed. Key nodes
  are special in Warfare. The key nodes are also rendered behind walls. So you can
  remove normal nodes but keep these special key nodes to keep the player informed.
  Once the players arrives these key nodes and is insight of it, the key node beacon
  will be removed. If he looses the sight, the beacon gets visible again.
  (Default: true)

- HideBetrayalBeacons={true|false}
  Whether to hide the Betrayal beacons.
  (Default: true)

- KeepBetrayalRogueBeacons={true|false}
  Whether to keep the Rogue beacons in Betrayal if the other beacons are removed.
  (Default: true)

- KeepBetrayalTeamBeacons={true|false}
  Whether to keep the Team beacons in Betrayal if the other beacons are removed.
  (Default: true)

- HideGreedBeacons={true|false}
  Whether to hide the Greed beacons.
  (Default: true)

- KeepGreedCoinHolderOnlyBeacons={true|false}
  Whether to keep only the beacons of Coin holders in Greed if the other beacons
  are removed.
  (Default: true)

- KeepGreedTeamBeacons={GKT_None|GKT_Team|GKT_Enemy}
  Whether to keep the beacons in Greed of your teammates or the enemy team if
  the other beacons are removed.
  (Default: GKT_Team)

Default config:
----------------------------
[NoPlayerBeaconConfig NoPlayerBeaconConfig]
DisableAllBeacons=False
GuaranteedMode=False
EnablePlayerName=True
PlayerNameFriendlyOnly=True
HideTeamPlayerBeacons=True
HideEnemyPlayerBeacons=True
HideTeamVehicleBeacons=True
HideEnemyVehicleBeacons=True
HideTeamTitanBeacons=True
HideEnemyTitanBeacons=True
ShowMessages=True
ShowInitialMessage=True
HideNodeBeacons=True
KeepKeyNodeBeacons=True
HideBetrayalBeacons=True
KeepBetrayalRogueBeacons=True
KeepBetrayalTeamBeacons=True
HideGreedBeacons=True
KeepGreedCoinHolderOnlyBeacons=True
KeepGreedTeamBeacons=GKT_Team
SkipSpectator=True



Known issues:
--------------------------------------------------------
- None



Changelog:
--------------------------------------------------------
v0.2
- Added: Check for vehicles
- Added: Configurable variable for disabling beacons for vehicles
- Fixed: TeamBeacon still visible (if player was in vehicle)

v0.3
- Completely rewritten code
- Fixed: Beacons were shown again if TalkingIcon mutator is used
- Fixed: Beacons may be visible again if player switches team

v0.4
- Fixed: Missing simulated specifier for inventory

v0.5
- Added: Warfare node beacon removal
- Added: Separate Titan beacon removal
- Added: Betrayal beacon conditional removal
- Added: Greed beacon conditional removal
- Added: Guaranteed mode which ensures that every beacon will be removed
- Added: Basic WebAdmin configuration page for this mutator
- Added: Post Save update for saved settings in WebAdmin which
         dynamically updates any Pawn/Titan/Vehicle/Node
- Added: Mutator config scene
- Added: Message sent to clients when settings are changed
- Added: Player names for hidden beacons
- Added: Localization
- Changed: Moved inventory code to replication class
- Changed: Optimized removal code
- Fixed: Enter symbols were not shown for vehicles if bDisableVehicleBeacons is set
- Fixed: Lock symbols were not shown for vehicles if bDisableVehicleBeacons is set
- Fixed: Minor issues

v0.6
- Added: Support for SpectatorUI (see SkipSpectator)
- Fixed: Removed some debug code



FUTURE FEATURES / TODO::
--------------------------------------------------------
- None