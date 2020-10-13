Name: U1MonsterSwapperv1
Version: 1
Author: Shaun Goeppinger aka Iniquitous
Date: 25/03/2012
//=======================================================
//Description
//=======================================================
This mutator allows you to specify which monsters spawn
in place of other ones in the Unreal 1 Mod game type.

My MonsterSwapperv2 mutator was used as a base to work on.

//=======================================================
//Installation
//=======================================================

.u files go in the Sytem folder
.ucl files go in the System folder
.ini files go in the System folder

Although the mutator should automatically add itself to the ServerPackages,
the line is as follows:

ServerPackages=U1MonsterSwapperv1

The mutator class name is as follows:

U1MonsterSwapperv1.MutMSwap

Select the mutator from the in game mutator menu list.

Remember that if you choose to spawn a custom monster then 
for online play you must add that monsters ServerPackage 
line to the UT2004.ini file.

//=======================================================
//Configuration
//=======================================================

In the mutator config window choose a monster to configure
from the drop down menu. Then from the drop down
menus choose which monsters to spawn instead. The monster
to spawn instead defaults to the monster class in question. 

Don't forget to now set a spawn chance for each monster.

In the ini file you can add as many monster lines as you wish. I have
named them in such a way that you can copy and pase monster lines directly
from the Satoremonsterpack.ini etc..

//=======================================================
//Credits
//=======================================================

Me! www.unreal.shaungoeppinger.com

If you like this mutator please consider making a small donation.

    http://www.unreal.shaungoeppinger.com/donate.html

Thank you