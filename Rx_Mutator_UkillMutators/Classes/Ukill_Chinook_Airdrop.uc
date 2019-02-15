class Ukill_Chinook_Airdrop extends Rx_Chinook_Airdrop;

simulated function class<Rx_Vehicle> GetVehicleClass()
{
	if (TeamNum == TEAM_GDI)
	{
		if (VehicleID == 8)
			return class'Ukill_VehicleManager'.default.GDIHarvesterClass;
		else
			return class'Ukill_PurchaseSystem'.default.GDIVehicleClasses[VehicleID];
	}
	else
	{
		if (VehicleID == 9)
			return class'Ukill_VehicleManager'.default.NodHarvesterClass;
		else
			return class'Ukill_PurchaseSystem'.default.NodVehicleClasses[VehicleID];
	}
}

//set chinook camo
simulated event PostBeginPlay()
{
	local MaterialInstanceConstant Parent;
	local MaterialInstanceConstant Temp;

	Super.PostBeginPlay();

	Temp = Mesh.CreateAndSetMaterialInstanceConstant(0);
	if (TeamNum == TEAM_GDI)
		Parent = MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Chinook_GDI';
	else
		Parent = MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Chinook_Nod';
	Temp.SetParent(Parent);
	Temp.SetScalarParameterValue('Camo_Offset_Seed', FRand());
	Temp.SetScalarParameterValue('Camo_Scale_Seed', (FRand() % 0.4) + 0.8);
}

				
				