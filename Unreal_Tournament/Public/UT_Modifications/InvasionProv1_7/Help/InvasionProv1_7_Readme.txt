Name: InvasionPro
Version: 1_7
Author: Shaun Goeppinger aka Iniquitous
Date: 22/11/12
//====================================================================================
// Description
//====================================================================================
InvasionPro is a new game type for Unreal Tournament 2004. It is based on the popular Invasion game type.  For those people accustomed to the Invasion game type, InvasionPro will feel very familiar. InvasionPro takes Invasion to the next level. It addresses dozens of problems inherit to the classic game type and introduces many new and exciting features. InvasionPro’s main new feature is the addition of Bosses and a pet feature. Most of the GUI menus have also been redesigned.

Most things are explained in-game in the configuration menus, just mouse-over the settings for a hint as to what it does,
if in doubt just leave it at default.Amongst many other features and settings are:

* Bosses, these can be spawned either one at a time one after the other or all at once. To set them up add boss lines in the InvasionProSettings.ini file (the boss lines can be empty). The new boss entries will then be available in the in-game boss menu. Give the boss a unique "ID" number and make any other changes to it that you want, such as a name or speed. In the Waves menu check the boss wave box and set any other settings you want for the wave. In the boss ID field put the ID of the boss you created. Separate them by a comma if you want more than one boss. For example 1,2,3

* Pets, can be enabled by the admin. If enabled players will have a new menu during gameplay when the press Esc. Alternatively this can be opened by typing "MenuPet" into the console. There are many pet features and abilities that can be upgraded as the pet levels and earns points by damaging and killing monsters. All of these abilities can be configured in the in-game Invasion Main Menu screen, except for 2 things. The list of "ServerPets" available to players must be set in the .ini file (stock monsters are there by default as examples). And if you want to run the pets in "Tier" mode, you must set up the "TierGroups" properly. (Remember to give the server pets a tier group). Tier Groups allows you to say which pets are available at which level, when pets reach the specified level the player will have the option of swapping it for a new pet from the next level (the previous abilites are kept, only the pet species changes). This allows it so only super strong pets are allowed at the highest levels. For example...

ServerPets=(MonsterName="Pupae",MonsterClassName="SkaarjPack.SkaarjPupae",TierGroup=1)
ServerPets=(MonsterName="Elite Krall",MonsterClassName="SkaarjPack.EliteKrall",TierGroup=2)

In the above lines, the pupae is set to TierGroup 1, and the EliteKrall to TierGroup 2. Until the pets level reached TierGroup 2 the player will not be able to choose the EliteKrall...

TierGroups=(TierGroup=1,MaxLevel=2)
TierGroups=(TierGroup=2,MaxLevel=120)

In the above lines TierGroup 1 (the first level) is until the pet gets to level 2, TierGroup 2 is then available until level 120 and so on.


Bug fixes and updates include:

* Online Player Names and Health displaying correctly
* Game end early if QuickStart enabled fixed
* Boss squad feature added
* Boss spawning options added
* Support for 2D Monsters has been added so they can properly previewed
* A new "Wave Copy & Paste" (in the wave menu) feature has been created to make editing waves easier
* Server Pets
* Simplified wave ending rules, admin decides if it's strictly the wave duration or monster count
* monsters spawned by other monsters will inherit their masters controller (will not work for all monsters, it's due to the spawning code used). If a friendly monsters
spawns another and it is not friendly the problem is in the way it was spawned. To fix it the monster that does the spawning needs re-coding. Change the spawn call
from Spawn(class'SomeMonster',,,,SomeLocation,SomeRotation); to Spawn(class'SomeMonsters',MonsterThatIsCallingThisFunction,,,SomeLocation,SomeRotation); (the instigator/owner needs to be set);
* Webadmin support added
* Boss timer and boss name on HUD changed and can be disabled in HUD menu
* Boss health bar feature added for monsters within radar range (can be disabled in HUD menu)
* Boss Names and Friendly Monsters names will appear above the monsters in question (can be disabled in HUD menu)
* Complete redesign of HUD menu and Main Menu to make it much simpler and user friendly


//====================================================================================
// upgrading From Previous Versions
//====================================================================================

If you are upgrading from an older version you can't simply copy and paste all of your old ini settings as some of them will result in errors. You will need to change the Waves and Bosses lines.

The Boss lines no longer use OverTimeDamagePerSec or bSpawned. A boss line should look like this:

Bosses=(bSetup=False,BossID=10,BossName=,BossMonsterName=,BossHealth=0,BossScoreAward=0,BossDamageMultiplier=0.000000,BossGroundSpeed=0.000000,BossAirSpeed=0.000000,BossWaterSpeed=0.000000,BossJumpZ=0.000000,BossGibMultiplier=0.000000,BossGibSizeMultiplier=0.000000,NewDrawScale=0.000000,NewCollisionHeight=0.000000,NewCollisionRadius=0.000000,NewPrePivot=(X=0.000000,Y=0.000000,Z=0.000000),WarningSound=)

As for the waves lines some new values have been added. A wave line should look like this:

Waves=(bBossWave=False,bBossesSpawnTogether=False,BossID="0",FallbackBossID=0,BossTimeLimit=0,BossOverTimeDamage=0,WaveName="Wave 10",WaveDrawColour=(B=255,G=0,R=0,A=255),WaveDuration=90,WaveDifficulty=1.140000,WaveMaxMonsters=25,MaxMonsters=8,MaxLives=1,Monsters[0]="Krall",Monsters[1]="Brute",Monsters[2]="Skaarj",Monsters[3]="Elite Krall",Monsters[4]="Ice Skaarj",Monsters[5]="None",Monsters[6]="None",Monsters[7]="None",Monsters[8]="None",Monsters[9]="None",Monsters[10]="None",Monsters[11]="None",Monsters[12]="None",Monsters[13]="None",Monsters[14]="None",Monsters[15]="None",Monsters[16]="None",Monsters[17]="None",Monsters[18]="None",Monsters[19]="None",Monsters[20]="None",Monsters[21]="None",Monsters[22]="None",Monsters[23]="None",Monsters[24]="None",Monsters[25]="None",Monsters[26]="None",Monsters[27]="None",Monsters[28]="None",Monsters[29]="None",WaveFallbackMonster="Pupae")

//====================================================================================
// Installation
//====================================================================================

.u files go in the System folder (InvasionProv1_7.u)
.ucl files go in the System folder (InvasionProv1_7.ucl)
.ini files go in the System folder (InvasionProSettings.ini)
.utx files go in the Textures folder (InvasionProTexturesv1_4.utx)

//====================================================================================
// Configuration
//====================================================================================

Just about everything can now be configured in-game using the various GUI menu screens.

When adding new monsters you need to add them to the .ini file first. You only need to add
the following to make the monster appear in the in-game menus where you can then edit it if you wish.

MonsterTable=(MonsterName="Pupae",MonsterClassName="SkaarjPack.SkaarjPupae")

In the game type game rules screen you will see some new menu options which can be accessed
by clicking the corresponding button.

To get there load up UT2004>Instant Action>InvasionPro(Gametype)>Game Rules Tab.

The InvasionPro Settings button opens a new config menu which lists most of the game options.
The Wave Configuration button allows you to edit the waves.
The Invaders button allows you to edit monster default settings.
The Boss Configuration button allows you to create boss monsters.
The Monster Stats button is just for fun but does tell you some things about your monsters.

All of the config options come with hints that tell you what they do. A lot of the options
are also available in the WebAdmin page.

In-game press Esc to open the "Mid-Game Menu". On this screen there is 2 new buttons which
open more options. The "InvasionPro Hud" button allows the player to customize their hud.
The "Pet Menu" button will exist if the server has bPetMode=true. If it is false this button
will not be available. This button allows the player to select a pet that they can level up
according to the server pet rules.

The last 2 menus can also be accessed by typing a command in game. 

To open the hud menu you can type:

"SetHud" or "MenuHud" (into the console without the quotation marks)

To open the pet menu you can type:

"MenuPet" (into the console without the quotation marks)

These can also be assigned to key binds.


//====================================================================================
// Incompatible Mutators
//====================================================================================

The following mutators are not compatible and will be denied by Invasion Pro, but their features are
usually already built in so they are not needed anyway.

* XGame.MutRegen (Regen built into InvasionPro for players and monsters)
* SatoreMonsterPackv120.mutsatoreMonsterPack (InvasionPro has its own monster and wave options)
* SatoreMonsterPackv120.mutSMPMonsterConfig (InvasionPro has its own monster and wave options)
* MonsterManager_1_8.MutMonsterManager (InvasionPro has its own monster and wave options)
* MonsterDamageConfig.MutMonsterDamage (InvasionPro has its own monster options)
* MonsterDamageConfigv2.MutMonsterDamage (InvasionPro has its own monster options)
* DruidsMonsterMover102.MutMonsterMover (InvasionPro has its own monster monitoring feature)
* MutAerialView (InvasionPro has its own third person aiming feature)
* MutBossWaves (InvasionPro has its own boss waves feature)

Other version of these mutators (and other mutators), whilst will load ok may cause InvasionPro not to work properly.
Disable all mutators that are not compatible!

//====================================================================================
// Credits
//====================================================================================

Shaun Goeppinger me@shaungoeppinger.com www.unreal.shaungoeppinger.com
