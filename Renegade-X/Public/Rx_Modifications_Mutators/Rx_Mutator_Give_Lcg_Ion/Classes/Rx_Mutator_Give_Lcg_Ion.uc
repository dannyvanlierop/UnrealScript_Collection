/*
** This will replace the default weapons, only add it to their current inventory.
*/

class Rx_Mutator_Give_Lcg_Ion extends UTMutator;
 
function bool CheckReplacement(Actor Other)
{
if (Rx_InventoryManager(Other) != None)
	{
	if (Rx_InventoryManager_Nod_LaserChainGunner(Other) != None)
		Rx_InventoryManager(Other).PrimaryWeapons[0] = class'Rx_Weapon_IonCannonBeacon';
	}
	return true;
}
