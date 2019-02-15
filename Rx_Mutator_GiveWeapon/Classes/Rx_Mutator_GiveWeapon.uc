/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator can be triggered with the mutate command. This gives the    *
*    player a weapon when they type "Mutate (weapon)" into the commandline.   *
*******************************************************************************
* Rx_Mutator_GiveWeapon                                                       *
******************************************************************************/

class Rx_Mutator_GiveWeapon extends UTMutator;

function Mutate(string MutateString, PlayerController Sender) { 
	local Rx_InventoryManager InvManager;
	local class<Rx_Weapon> WeaponClass;

	InvManager = Rx_InventoryManager(Sender.Pawn.InvManager);

    /// WeaponSetup
    if ( InvManager != none) { 
        if (MutateString ~= "AutoRifle_GDI") { WeaponClass = class'Rx_Weapon_AutoRifle_GDI'; }
        else if (MutateString ~= "AutoRifle_Nod") { WeaponClass = class'Rx_Weapon_AutoRifle_Nod'; }
        else if (MutateString ~= "Airstrike_GDI") { WeaponClass = class'Rx_Weapon_Airstrike_GDI'; }
        else if (MutateString ~= "Airstrike_Nod") { WeaponClass = class'Rx_Weapon_Airstrike_Nod'; }
        else if (MutateString ~= "ATMine") { WeaponClass = class'Rx_Weapon_ATMine'; }
        else if (MutateString ~= "Carbine") { WeaponClass = class'Rx_Weapon_Carbine'; }
        else if (MutateString ~= "Carbine_Silencer") { WeaponClass = class'Rx_Weapon_Carbine_Silencer'; }
        else if (MutateString ~= "Chaingun_GDI") { WeaponClass = class'Rx_Weapon_Chaingun_GDI'; }
        else if (MutateString ~= "Chaingun_Nod") { WeaponClass = class'Rx_Weapon_Chaingun_Nod'; }
        else if (MutateString ~= "ChemicalThrower") { WeaponClass = class'Rx_Weapon_ChemicalThrower'; }
        else if (MutateString ~= "EMPGrenade_Rechargeable") { WeaponClass = class'Rx_Weapon_EMPGrenade_Rechargeable'; }
        else if (MutateString ~= "FlakCannon") { WeaponClass = class'Rx_Weapon_FlakCannon'; }
        else if (MutateString ~= "FlameThrower") { WeaponClass = class'Rx_Weapon_FlameThrower'; }
        else if (MutateString ~= "Grenade") { WeaponClass = class'Rx_Weapon_Grenade'; }
        else if (MutateString ~= "GrenadeLauncher") { WeaponClass = class'Rx_Weapon_GrenadeLauncher'; }
        else if (MutateString ~= "Grenade_Rechargeable") { WeaponClass = class'Rx_Weapon_Grenade_Rechargeable'; }
        else if (MutateString ~= "HeavyPistol") { WeaponClass = class'Rx_Weapon_HeavyPistol'; }
        else if (MutateString ~= "IonCannonBeacon") { WeaponClass = class'Rx_Weapon_IonCannonBeacon'; }
        else if (MutateString ~= "LaserChaingun") { WeaponClass = class'Rx_Weapon_LaserChaingun'; }
        else if (MutateString ~= "LaserRifle") { WeaponClass = class'Rx_Weapon_LaserRifle'; }
        else if (MutateString ~= "NukeBeacon") { WeaponClass = class'Rx_Weapon_NukeBeacon'; }
        else if (MutateString ~= "MarksmanRifle_GDI") { WeaponClass = class'Rx_Weapon_MarksmanRifle_GDI'; }
        else if (MutateString ~= "MarksmanRifle_Nod") { WeaponClass = class'Rx_Weapon_MarksmanRifle_Nod'; }
        else if (MutateString ~= "Pistol") { WeaponClass = class'Rx_Weapon_Pistol'; }
        else if (MutateString ~= "ProxyC4") { WeaponClass = class'Rx_Weapon_ProxyC4'; }
        else if (MutateString ~= "Railgun") { WeaponClass = class'Rx_Weapon_Railgun'; }
        else if (MutateString ~= "RamjetRifle") { WeaponClass = class'Rx_Weapon_RamjetRifle'; }
        else if (MutateString ~= "RemoteC4") { WeaponClass = class'Rx_Weapon_RemoteC4'; }
        else if (MutateString ~= "RepairGun") { WeaponClass = class'Rx_Weapon_RepairGun'; }
        else if (MutateString ~= "RepairGunAdvanced") { WeaponClass = class'Rx_Weapon_RepairGunAdvanced'; }
        else if (MutateString ~= "RepairTool") { WeaponClass = class'Rx_Weapon_RepairTool'; }
        else if (MutateString ~= "PersonalIonCannon") { WeaponClass = class'Rx_Weapon_PersonalIonCannon'; }
        else if (MutateString ~= "SMG_GDI") { WeaponClass = class'Rx_Weapon_SMG_GDI'; }
        else if (MutateString ~= "SMG_NOD") { WeaponClass = class'Rx_Weapon_SMG_Nod'; }
        else if (MutateString ~= "SMG_Silenced_GDI") { WeaponClass = class'Rx_Weapon_SMG_Silenced_GDI'; }
        else if (MutateString ~= "SMG_Silenced_NOD") { WeaponClass = class'Rx_Weapon_SMG_Silenced_Nod'; }
        else if (MutateString ~= "SmokeGrenade_Rechargeable") { WeaponClass = class'Rx_Weapon_SmokeGrenade_Rechargeable'; }
        else if (MutateString ~= "SniperRifle_GDI") { WeaponClass = class'Rx_Weapon_SniperRifle_GDI'; }
        else if (MutateString ~= "SniperRifle_Nod") { WeaponClass = class'Rx_Weapon_SniperRifle_Nod'; }
        else if (MutateString ~= "TacticalRifle") { WeaponClass = class'Rx_Weapon_TacticalRifle'; }
        else if (MutateString ~= "TiberiumAutoRifle") { WeaponClass = class'Rx_Weapon_TiberiumAutoRifle'; }
        else if (MutateString ~= "TiberiumFlechetteRifle") { WeaponClass = class'Rx_Weapon_TiberiumFlechetteRifle'; }
        else if (MutateString ~= "TimedC4") { WeaponClass = class'Rx_Weapon_TimedC4'; }
        else if (MutateString ~= "TimedC4_Multiple") { WeaponClass = class'Rx_Weapon_TimedC4_Multiple'; }
        else if (MutateString ~= "VoltAutoRifle_Nod") { WeaponClass = class'Rx_Weapon_VoltAutoRifle_Nod'; }
        else if (MutateString ~= "VoltAutoRifle_GDI") { WeaponClass = class'Rx_Weapon_VoltAutoRifle_GDI'; }
//        else { ClientMessage("Unknown"); }
    }
    if (InvManager != none)	{
		if (InvManager.PrimaryWeapons.Find(WeaponClass) < 0) InvManager.PrimaryWeapons.AddItem(WeaponClass); // Make sure it isn't in there already.
		if (InvManager.FindInventoryType(WeaponClass) != None) { InvManager.SetCurrentWeapon(Rx_Weapon(InvManager.FindInventoryType(WeaponClass))); }
		else { InvManager.SetCurrentWeapon(Rx_Weapon(InvManager.CreateInventory(WeaponClass, false))); }
		Rx_Pawn(Owner).RefreshBackWeapons(); }    
    Super.Mutate(MutateString, Sender); }

DefaultProperties { 
}
 