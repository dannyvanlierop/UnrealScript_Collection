/*
** Rx_Gametype_Sandbox_v002_Controller
**
*/
class Rx_Gametype_Sandbox_v002_Controller extends Rx_Controller;

var array<Actor> SpawnedActors;
var bool bSpawnDisabled;

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

	if (bSpawnDisabled)
	{
		
		ClientMessage("You need to wait 2 seconds between spawning");
	}
	else
	{
		bSpawnDisabled = true;
		SetTimer(2.0, false, 'ReEnableSpawn');
		ServerSandboxSpawn(ClassName);	
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
		if(ClassName != "")
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

	LogInternal("Fabricate " $ ClassName);
	NewClass = class<actor>( DynamicLoadObject( ClassName, class'Class' ) );
	if( NewClass!=None )
	{
		if(NewClass == class'Renx_Game.Rx_weapon_DeployedBeacon')
		{
			foreach SpawnedActors(A)
			{
				if(A.IsA('Rx_Weapon_DeployedBeacon'))
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
	}
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
