class Ukill_Vehicle_Harvester_Nod extends RX_Vehicle_Harvester_Nod notplaceable;

simulated event PostBeginPlay()
{
	local MaterialInstanceConstant Parent;
	local MaterialInstanceConstant Temp;
	
	Super.PostBeginPlay();
	
	Temp = Mesh.CreateAndSetMaterialInstanceConstant(0);
	Parent = MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Harvester_Nod';
	Temp.SetParent(Parent);
}