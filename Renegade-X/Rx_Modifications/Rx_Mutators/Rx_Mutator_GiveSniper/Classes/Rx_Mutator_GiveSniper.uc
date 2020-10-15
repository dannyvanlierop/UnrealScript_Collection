/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator can be triggered with the mutate command. This gives the     *
*  player a sniper rifle when they type "Mutate Sniper" into the commandline. *
*******************************************************************************
* Rx_Mutator_GiveSniper                                                       *
******************************************************************************/

class Rx_Mutator_GiveSniper extends UTMutator;

function Mutate(string MutateString, PlayerController Sender) {
	local Rx_InventoryManager InvManager;
	local class<Rx_Weapon> WeaponClass;

	WeaponClass = class'Rx_Weapon_SniperRifle_Nod';
	InvManager = Rx_InventoryManager(Sender.Pawn.InvManager);

    if (MutateString ~= "sniper" && InvManager != none) { 
		if (InvManager.PrimaryWeapons.Find(WeaponClass) < 0) InvManager.PrimaryWeapons.AddItem(WeaponClass); // Make sure it isn't in there already. 
		if(InvManager.FindInventoryType(WeaponClass) != None) { InvManager.SetCurrentWeapon(Rx_Weapon(InvManager.FindInventoryType(WeaponClass))); } 
		else { InvManager.SetCurrentWeapon(Rx_Weapon(InvManager.CreateInventory(WeaponClass, false))); } 
		Rx_Pawn(Owner).RefreshBackWeapons(); }
	Super.Mutate(MutateString, Sender);
}

DefaultProperties { 
}
 