/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*      This mutator will add the Sandbox function to the Renegade X game      *
*******************************************************************************
* Rx_Mutator_Sandbox_v009_Controller                                          *
******************************************************************************/

class Rx_Mutator_Sandbox_v009_Controller extends Rx_Controller;
/* config(RxSandbox); var config int ActorSpawnLimit; */

//var bool bSandbox;
var array<Actor> SpawnedActors;
var bool bSpawnModeDisabled;
var int iSpawnWaitTime;

// Variables to Probhit people typing wrong ClassNames
var int ClassItemPreFixArrayLength;
var int ClassItemNameArrayLength;
var int ClassItemDescriptionArrayLength;
var string ClassItemPreFix[5];
var string ClassItemName[42];
var string ClassItemDescription[42];

// default this is set on false if no true is given as optoinal parameter
simulated function SandboxTierSet(optional bool bValue) { if ( bValue != true ) { bValue=false; } bSpawnModeDisabled = (bValue); }

// Slow down the spawn displays the downcounter messages or spawn a item
simulated function SandboxTier ( string ClassName )
{

	if ( bSpawnModeDisabled && iSpawnWaitTime >= 1 )
	{
		ClientMessage("Sandbox Message: SpawnMode Disabled, You need to wait at least " $ iSpawnWaitTime $ " seconds before respawn."); iSpawnWaitTime--;
		settimer(1,false,'SandboxTier');
	}
	else if (bSpawnModeDisabled && iSpawnWaitTime == 0)
	{
		SandboxTierSet();
		ClientMessage("Sandbox Message: SpawnMode Reactivated, you can spawn again.");
	}
	else 
	{
		ServerSandboxSpawn(ClassName);
		SandboxTierSet(true);
		iSpawnWaitTime=8;
		SetTimer(iSpawnWaitTime, false, 'SandboxTierSet');
		ClientMessage("Sandbox Message: SpawnMode Activated");	
	}
}

// jump to downcounter
exec function SandboxSpawn ( string ClassName )
{
	SandboxSpawnInputCheck(ClassName);
}


// Check if the input of the users is active/exists
simulated function SandboxSpawnInputCheck(string ClassName)
{
	local int x;
	local string Str1;
	local string Str2;
	local string Str3;

	for (x = 0; x < 34; x++)
	{
		if( ClassName ~= ClassItemName[x] )
		{
			// First filter the disabled items
			if ( x == 14 || x == 16)
			{
				// ClassItemName[14]="C130";
				// ClassItemName[16]="Bus";
				ClientMessage("Sandbox Message: The item you choose is disabled by the server administrator");
				return;
			}
			
			// Set the first part of the Classname in Str1
			Str1="renx_game.";
			
			// Set the Second part of the Classname in Str2
			if ( x >= 0 && x <= 23 )
			{
				Str2=ClassItemPreFix[0];
			}
			else if ( x >= 24 && x <= 29 )
			{
				Str2=ClassItemPreFix[1];
			}
			else if ( x >= 30 && x <= 35 )
			{
				Str2=ClassItemPreFix[2];
			}
			else if ( x >= 36 && x <= 40 )
			{
				Str2=ClassItemPreFix[3];
			}	
			else if ( x == 41 )
			{
				Str2=ClassItemPreFix[4];
			}
			
			// Set the Second part of the Classname in Str3
			Str3=ClassItemName[x];
		}
	}
	
	// Pass the ClassName to spawn the object
	if ( Str2 != "" )
	{	// Combine the collected strings to one complete class string
		ClassName=Str1 $ Str2 $ Str3;
		SandboxTier(ClassName);
		
	}
	else 
	{
		// If Str2 is emtpty, the user did not give a available itemname.
		ClientMessage("Sandbox Message: The item you choose is not found, try again?");
		//Maybe add later help/Item-list
	}
}



// destroys all object spawned by user
exec function SandboxKillOwned(optional string ClassName)
{
	ServerSandboxKillOwned(ClassName);
}

// destroys all object spawned by user
reliable server function ServerSandboxKillOwned(optional string ClassName)
{
	local Actor A;

	foreach SpawnedActors(A)
	{
		if(ClassName == "")
		A.Destroy();
		else if(A.IsA(name(ClassName)))
		A.Destroy();
	}


}
// Spawn the className at user  position
reliable server function ServerSandboxSpawn (string ClassName)
{
	local class<actor> NewClass;
	local vector SpawnLoc;
	local Actor A;
	local bool bBeaconExist;
	local int i;

	NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
	if( NewClass!=None )
	{
		if(NewClass == class'Renx_Game.Rx_weapon_DeployedBeacon')
		{
			for(i = 0;i < SpawnedActors.Length;i++)
			{
				if(SpawnedActors[i].IsA('Rx_Weapon_DeployedBeacon'))
				bBeaconExist = true;
			}
			if(bBeaconExist)
			{
				ClientMessage("Spawning Beacon Failed! You already have a beacon spawned");
				return;
			}
			
		}
		if ( Pawn != None )
			SpawnLoc = Pawn.Location;
		else
			SpawnLoc = Location;
		A = Spawn( NewClass,self,,SpawnLoc + 72 * Vector(Rotation) + vect(0,0,1) * 15 );
		SpawnedActors.additem(A);
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


exec function Feign()
{
	UTPawn(Pawn).FeignDeath();
}


exec function Gimme(string Weapon)
{
	ServerGimme(Weapon);
}

reliable server function Weapon ServerGimme( String WeaponClassStr )
{
	local Weapon		Weap;
	local class<Weapon> WeaponClass;

	WeaponClass = class<Weapon>(DynamicLoadObject(WeaponClassStr, class'Class'));
	Weap		= Weapon(Pawn.FindInventoryType(WeaponClass));
	if( Weap != None )
	{
		return Weap;
	}
	return Weapon(Pawn.CreateInventory( WeaponClass ));
}

DefaultProperties
{
	bSpawnModeDisabled = false;

	ClassItemPreFixArrayLength = 5;
	ClassItemPreFix[0]="Rx_Vehicle_";			//0-23
	ClassItemPreFix[1]="Rx_Weapon_Deployed";	//24-29
	ClassItemPreFix[2]="Rx_Defence_";			//30-35
	ClassItemPreFix[3]="Rx_Projectile_";		//36-40
	ClassItemPreFix[4]="Rx_Weapon_";			//41
	
	ClassItemNameArrayLength = 42;
	
	// ClassNamePrefix Rx_Vehicle_
	ClassItemName[0]="Humvee";
	ClassItemName[1]="Buggy";
	ClassItemName[2]="APC_GDI";
	ClassItemName[3]="APC_Nod";
	ClassItemName[4]="LightTank";
	ClassItemName[5]="MediumTank";
	ClassItemName[6]="FlameTank";
	ClassItemName[7]="StealthTank";
	ClassItemName[8]="MammothTank";
	ClassItemName[9]="Chinook_GDI";
	ClassItemName[10]="Chinook_Nod";
	ClassItemName[11]="Orca";
	ClassItemName[12]="Apache";
	ClassItemName[13]="A10";
	ClassItemName[14]="C130";
	ClassItemName[15]="Hovercraft_GDI";
	ClassItemName[16]="Bus";
	ClassItemName[17]="Wolverine";
	ClassItemName[18]="HoverMRLS";
	ClassItemName[19]="Titan";
	ClassItemName[20]="Buggy";
	ClassItemName[21]="ReconBike";
	ClassItemName[22]="TickTank";
	ClassItemName[23]="APB_Vehicle_TeslaTank";
	
	// ClassNamePrefix Rx_Weapon_Deployed
	ClassItemName[24]="ProxyC4";
	ClassItemName[25]="RemoteC4";
	ClassItemName[26]="TimedC4";*/
	ClassItemName[27]="ATMine";
	ClassItemName[28]="IonCannonBeacon";
	ClassItemName[29]="NukeBeacon";
	
	// ClassNamePrefix Rx_Defence_
	ClassItemName[30]="GunEmplacement";
	ClassItemName[31]="RocketEmplacement";
	ClassItemName[32]="Turret";
	ClassItemName[33]="SAM_Site";
	ClassItemName[34]="GuardTower";
	ClassItemName[35]="AATower";
	
	// ClassNamePrefix Rx_Projectile_
	ClassItemName[36]="Grenade";
	ClassItemName[37]="MissileLauncher";
	ClassItemName[38]="SmokeGrenade";
	ClassItemName[39]="EMPGrenade";
	ClassItemName[40]="Rocket_AGT";
	
	// ClassNamePrefix Rx_Weapon_
	ClassItemName[41]="CrateNuke";
	
	ClassItemDescriptionArrayLength = 42;
	ClassItemDescription[0]=" ";
	ClassItemDescription[1]=" ";
	ClassItemDescription[2]=" ";
	ClassItemDescription[3]=" ";
	ClassItemDescription[4]=" ";
	ClassItemDescription[5]=" ";
	ClassItemDescription[6]=" ";
	ClassItemDescription[7]=" ";
	ClassItemDescription[8]=" ";
	ClassItemDescription[9]=" ";
	ClassItemDescription[10]=" ";
	ClassItemDescription[11]=" ";
	ClassItemDescription[12]=" ";
	ClassItemDescription[13]=" ";
	ClassItemDescription[14]=" ";
	ClassItemDescription[15]=" ";
	ClassItemDescription[16]=" ";
	ClassItemDescription[17]=" ";
	ClassItemDescription[18]=" ";
	ClassItemDescription[19]=" ";
	ClassItemDescription[20]=" ";
	ClassItemDescription[21]=" ";
	ClassItemDescription[22]=" ";
	ClassItemDescription[23]=" ";
	ClassItemDescription[24]=" ";
	ClassItemDescription[25]=" ";
	ClassItemDescription[26]=" ";
	ClassItemDescription[27]=" ";
	ClassItemDescription[28]=" ";
	ClassItemDescription[29]=" ";
	ClassItemDescription[30]="(not mannable)";
	ClassItemDescription[31]="(not mannable)";
	ClassItemDescription[32]="(Nod aligned)";
	ClassItemDescription[33]="(Nod aligned)";
	ClassItemDescription[34]="(GDI aligned)";
	ClassItemDescription[35]="(GDI aligned)";
	ClassItemDescription[36]=" ";
	ClassItemDescription[37]=" ";
	ClassItemDescription[38]=" ";
	ClassItemDescription[39]=" ";
	ClassItemDescription[40]=" ";
	ClassItemDescription[41]="(faster NukeBeacon)";
}


 