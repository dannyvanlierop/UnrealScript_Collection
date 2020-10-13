/*
** Rx_Gametype_Sandbox_v002_Weapon_AdminGun
*/
class Rx_Gametype_Sandbox_v002_Weapon_AdminGun extends Rx_Weapon_RepairGun;

simulated function RepairBuilding(Rx_Building building, float DeltaTime)
{
	if (Rx_Building_Techbuilding(building) == none && building.GetHealth() < building.GetMaxHealth())
	{
		if(Rx_Building_Team_Internals(building.BuildingInternals).bDestroyed)
		{
			if(building.IsA('Rx_Building_Refinery_GDI'))
			Rx_Game(WorldInfo.Game).GetVehicleManager().SetGDIRefDestroyed(false);
			if(building.IsA('Rx_Building_Refinery_Nod'))
			Rx_Game(WorldInfo.Game).GetVehicleManager().SetNodRefDestroyed(false);
			if(building.IsA('Rx_Building_WeaponsFactory'))
			{
				Rx_Game(WorldInfo.Game).GetVehicleManager().bGDIIsUsingAirdrops = false;
			}
			if(building.IsA('Rx_Building_AirTower') ||building.IsA('Rx_Building_AirStrip'))
			{
				Rx_Game(WorldInfo.Game).GetVehicleManager().bNodIsUsingAirdrops = false;
			}
			Rx_Building_Team_Internals(building.BuildingInternals).bDestroyed = false;
			Rx_Building_Team_Internals(building.BuildingInternals).Health = 500;
		}
		Repair(building,DeltaTime);
	}
	else
	{
		if(Rx_CapturableMCT(building) != None && !(Rx_CapturableMCT(building).ScriptGetTeamNum() == Instigator.GetTeamNum() && building.GetHealth() >= building.GetMaxHealth()) )
			Repair(building,DeltaTime);
		else
			bHealing = false;
	}
}

simulated function RepairVehicle(Rx_Vehicle vehicle, float DeltaTime)
{
	vehicle.TakeDamage(10000, Instigator.Controller,Instigator.FlashLocation,Vect(0,0,0), InstantHitDamageTypes[0],,self);
}

simulated function RepairDeployedActor(Rx_Weapon_DeployedActor deployedActor, float DeltaTime)
{
		Rx_Weapon_DeployedBeacon(deployedActor).bCanNotBeDisarmedAnymore = false;
		Repair(deployedActor,DeltaTime,true);
}



defaultproperties
{
    HealAmount=1000000
    InventoryMovieGroup=20
    WeaponIconTexture=Texture2D'RX_WP_RepairGun.UI.T_WeaponIcon_RepairGunAdvanced'

/*
*    WeaponFireWaveForm=ForceFeedbackWaveform'Default__Rx_Gametype_Sandbox_v002_Weapon_AdminGun.ForceFeedbackWaveformShooting1'
*/

    WeaponRange=4000.0
/*
*    begin object name=FirstPersonMesh class=UDKSkeletalMeshComponent
*        Animations=AnimNodeSequence'Default__Rx_Gametype_Sandbox_v002_Weapon_AdminGun.FirstPersonMesh.MeshSequenceA'
*        ReplacementPrimitive=none
*    object end
*/
    // Reference: UDKSkeletalMeshComponent'Default__Rx_Gametype_Sandbox_v002_Weapon_AdminGun.FirstPersonMesh'
    Mesh=FirstPersonMesh
/*
*    begin object name=PickupMesh class=SkeletalMeshComponent
*        ReplacementPrimitive=none
*    object end
*/
    // Reference: SkeletalMeshComponent'Default__Rx_Gametype_Sandbox_v002_Weapon_AdminGun.PickupMesh'
    DroppedPickupMesh=PickupMesh

/*
*    begin object name=PickupMesh class=SkeletalMeshComponent
*        ReplacementPrimitive=none
*   object end
*/
    // Reference: SkeletalMeshComponent'Default__Rx_Gametype_Sandbox_v002_Weapon_AdminGun.PickupMesh'
    PickupFactoryMesh=PickupMesh
}