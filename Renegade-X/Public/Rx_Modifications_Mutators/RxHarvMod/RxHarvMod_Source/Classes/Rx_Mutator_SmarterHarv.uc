class Rx_Mutator_SmarterHarv extends UTMutator;

event PreBeginPlay()
{
	local Rx_Defence_GunEmplacement GunEmplacement;
	local Rx_Defence_RocketEmplacement RocketEmplacement;
	
	super.PreBeginPlay();
	
	GunEmplacement = Rx_Defence_GunEmplacement(GetDefaultObject(Class'Rx_Defence_GunEmplacement'));
	GunEmplacement.RespawnTime = 125;		
	
	RocketEmplacement = Rx_Defence_RocketEmplacement(GetDefaultObject(Class'Rx_Defence_RocketEmplacement'));
	RocketEmplacement.RespawnTime = 125;	
}

function bool CheckReplacement(Actor Other)
{
	
	if (Other.IsA('Rx_Vehicle_HarvesterController') && !Other.IsA('Rx_Vehicle_SmarterHarvesterController'))
	{
		ReplaceWith(Other, "RxHarvMod.Rx_Vehicle_SmarterHarvesterController"); 
		return false; // return false to not keep the old Controller
	}	
	
	if (Other.IsA('Rx_VehicleManager') && !Other.IsA('Rx_VehicleManagerLongerHarvRespawnDelay'))
	{
		ReplaceWith(Other, "RxHarvMod.Rx_VehicleManagerLongerHarvRespawnDelay"); 
		return false; // return false to not keep the old VehicleManager
	}
	
	return true;
}

final static function object GetDefaultObject(class ObjClass)
{
	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}

defaultproperties
{

}