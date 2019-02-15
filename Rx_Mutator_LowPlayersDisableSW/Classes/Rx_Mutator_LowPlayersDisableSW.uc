/******************************************************************************
*  This mutator will function to the Renegade X game
* Contrubutions : Ukill
*******************************************************************************
* Rx_Mutator_LowPlayersDisableSW                                                            *
******************************************************************************/

class Rx_Mutator_LowPlayersDisableSW extends UTMutator;

event PreBeginPlay()
{
	super.PreBeginPlay();
	
	local Rx_PRI PRI;
	local Rx_PurchaseSystem C4Mod;
	local int cnt;
//	local string error;
//	local Rx_Weapon_DeployedBeacon beacon;	

	cnt=0;
	foreach DynamicActors(class'Rx_PRI', PRI)
	{
		cnt = cnt++;
	}

	C4Mod=Rx_PurchaseSystem(GetDefaultObject(Class'Rx_PurchaseSystem')); 
	C4Mod.GDIItemPrices[0] = 9999;
	C4Mod.NodItemPrices[0] = 9999;
}

final static function object GetDefaultObject(class ObjClass)
{
	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}

DefaultProperties
{
}
