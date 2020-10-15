/*
** Rx_Gametype_Sandbox_v004_Controller
*/
class Rx_Gametype_Sandbox_v004_Controller extends Rx_Controller;

var array<Actor> SpawnedActors;
var bool bSpawnDisabled;
var int HelpedTier;

exec function SandboxHelp()
{
	if(HelpedTier == 0)
	{
		HelpUpSandbox();
	}
	
}

simulated function HelpUpSandbox()
{
	switch (HelpedTier)
	{
		case 0:
		ClientMessage("The Sandbox command occurs if you open the console, and type 'SandboxSpawn' or 'Gimme' and input the class of the object");
		ClientMessage("Gimme will give you weapons. SandboxSpawn summons an object of your choice");
		ClientMessage("Before you do so, however, please turn on sandbox mode with vote system");
		break;

		case 1:
		ClientMessage("Normal Vehicle is spawned by following SandboxSpawn with 'Renx_Game.Rx_Vehicle_' and type the vehicle name");
		ClientMessage("List : Humvee, Buggy, APC_GDI. APC_Nod, MediumTank, LightTank, FlameTank, StealthTank, MammothTank, MRLS, Artillery");
		ClientMessage("List : Chinook_GDI, Chinook_Nod, Orca, Apache, Hovercraft_GDI, A10, C130");
		break;

		case 2:
		ClientMessage("TibSun Vehicle is spawned by following SandboxSpawn with 'Renx_Game.TS_Vehicle_' and type the vehicle name with no space");
		ClientMessage("List : HoverMRLS, Buggy, Wolverine, Titan, ReconBike, TickTank");
		break;

		case 3:
		ClientMessage("Tesla tank is spawned by following SandboxSpawn with 'Renx_Game.APB_Vehicle_TeslaTank'");
		break;

		case 4:
		ClientMessage("Weapon is given by following 'Gimme' with 'Renx_Game.Rx_Weapon_' and type the weapon name");
		ClientMessage("Example : RepairGunAdvanced, LaserGun, RamjetRifle, SniperRifle_GDI, AutoRifle_GDI, VoltAutoRifle_Nod, MarksmanRifle_Nod");
		break;

		case 5:
		ClientMessage("Beacon, C4 and other deployables can be placed by typing 'Renx_Game.Rx_Weapon_Deployable_' with the following");
		ClientMessage("List : ProxyC4, TimedC4, NukeBeacon, IonCannonBeacon");
		ClientMessage("Frag Grenades can also be spawned by typing 'Renx_Game.Rx_Projectile_Grenade'. Other types are available as well");
		break;

		case 6:
		ClientMessage("Example : To spawn A10, type 'sandboxspawn Renx_Game.Rx_vehicle_A10");
		break;

		case 7:
		ClientMessage("More info can be obtained from other player or Handepsilon himself. Thank you for using Sandbox Mod");
		break;
	}
	
	HelpedTier = HelpedTier + 1;
	if(HelpedTier <= 7)
	settimer(5,false,'HelpUpSandbox');
	else
	HelpedTier = 0;
}

exec function SandboxSpawn ( string ClassName )
{
/*
	local int i;

	for(i = 0; i<SpawnedActors.length; i++)
	{
		if(SpawnedActors[i] == None)
		SpawnedActors.remove(i, 1);
	}
*/

	if (!Rx_Gametype_Sandbox_v004(WorldInfo.Game).bSandbox)
	{
		bSpawnDisabled = true;
		SetTimer(2.0, false, 'ReEnableSpawn');
		ServerSandboxSpawn(ClassName);	
	}
	else if (bSpawnDisabled)
	{
		ClientMessage("You need to wait 2 seconds between spawning");
	}
	else
	{
		ClientMessage("Game is not currently in Sandbox mode. Please activate it with the voting system");
	}
}

simulated function ReEnableSpawn()
{
	bSpawnDisabled = false;
}

exec function SandboxKillOwned(optional string ClassName)
{
	ServerSandboxKillOwned(ClassName);
}

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


