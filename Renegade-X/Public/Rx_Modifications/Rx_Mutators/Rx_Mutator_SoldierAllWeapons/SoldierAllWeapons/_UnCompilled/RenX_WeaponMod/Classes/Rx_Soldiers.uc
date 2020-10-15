/*************************************************************************************
* This will not replace the default weapons, only add it to their current inventory. *
**************************************************************************************/

class Rx_Soldiers extends UTMutator;
 
function bool CheckReplacement(Actor Other)
{
	
/***********************************
* Rx_InventoryManager              *
* Rx_InventoryManager_Adv_GDI      *
* Rx_InventoryManager_Adv_NOD      *
* NAME - Rx_InventoryManager_Basic *
***********************************/

/***************
* Gdi SOLDIERS *
***************/

	if (Other.IsA('Rx_InventoryManager_GDI_Deadeye'))
	{
		Rx_InventoryManager_GDI_Deadeye(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun'; 
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Engineer'))
	{
		Rx_InventoryManager_GDI_Engineer(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun'; 
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Grenadier'))
	{
		Rx_InventoryManager_GDI_Grenadier(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Gunner'))
	{
		Rx_InventoryManager_GDI_Gunner(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Havoc'))
	{
		Rx_InventoryManager_GDI_Havoc(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Hotwire'))
	{
		Rx_InventoryManager_GDI_Hotwire(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Marksman'))
	{
		Rx_InventoryManager_GDI_Marksman(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_McFarland'))
	{
		Rx_InventoryManager_GDI_McFarland(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
		Rx_InventoryManager_GDI_McFarland(Other).SecondaryWeapons[1] = class'Rx_Weapon_Grenade_Rechargeable';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Mobius'))
	{
		Rx_InventoryManager_GDI_Mobius(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Officer'))
	{
		Rx_InventoryManager_GDI_Officer(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
		Rx_InventoryManager_GDI_Officer(Other).SecondaryWeapons[1] = class'Rx_Weapon_Grenade_Rechargeable';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_Patch'))
	{
		Rx_InventoryManager_GDI_Patch(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_GDI_RocketSoldier'))
	{
		Rx_InventoryManager_GDI_RocketSoldier(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

	
	if (Other.IsA('Rx_InventoryManager_GDI_Shotgunner'))
	{
		Rx_InventoryManager_GDI_Shotgunner(Other).SecondaryWeapons[0] = class'Rx_Weapon_Grenade_Rechargeable';
	}


	if (Other.IsA('Rx_InventoryManager_GDI_Soldier'))
	{
		Rx_InventoryManager_GDI_Soldier(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
		Rx_InventoryManager_GDI_Soldier(Other).SecondaryWeapons[1] = class'Rx_Weapon_Grenade_Rechargeable';
	}
    
	if (Other.IsA('Rx_InventoryManager_GDI_Sydney'))
	{
		Rx_InventoryManager_GDI_Sydney(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}


/***************
* Nod SOLDIERS *
***************/
	
    if (Other.IsA('Rx_InventoryManager_Nod_BlackHandSniper'))
	{
		Rx_InventoryManager_Nod_BlackHandSniper(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_ChemicalTrooper'))
	{
		Rx_InventoryManager_Nod_ChemicalTrooper(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Engineer'))
	{
		Rx_InventoryManager_Nod_Engineer(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_FlameTrooper'))
	{
		Rx_InventoryManager_Nod_FlameTrooper(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_LaserChainGunner'))
	{
		Rx_InventoryManager_Nod_LaserChainGunner(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Marksman'))
	{
		Rx_InventoryManager_Nod_Marksman(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Mendoza'))
	{
		Rx_InventoryManager_Nod_Mendoza(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Officer'))
	{
		Rx_InventoryManager_Nod_Officer(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
		Rx_InventoryManager_Nod_Officer(Other).SecondaryWeapons[1] = class'Rx_Weapon_Grenade_Rechargeable';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Raveshaw'))
	{
		Rx_InventoryManager_Nod_Raveshaw(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_RocketSoldier'))
	{
		Rx_InventoryManager_Nod_RocketSoldier(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

    if (Other.IsA('Rx_InventoryManager_Nod_Sakura'))
	{
		Rx_InventoryManager_Nod_Sakura(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}


	if (Other.IsA('Rx_InventoryManager_Nod_Shotgunner'))
	{
		Rx_InventoryManager_Nod_Shotgunner(Other).SecondaryWeapons[0] = class'Rx_Weapon_Grenade_Rechargeable';
	}


	if (Other.IsA('Rx_InventoryManager_Nod_Soldier'))
	{
		Rx_InventoryManager_Nod_Soldier(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
		Rx_InventoryManager_Nod_Soldier(Other).SecondaryWeapons[1] = class'Rx_Weapon_Grenade_Rechargeable';
	}
    
	if (Other.IsA('Rx_InventoryManager_Nod_StealthBlackHand'))
	{
		Rx_InventoryManager_Nod_StealthBlackHand(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}
    
	if (Other.IsA('Rx_InventoryManager_Nod_Technician'))
	{
		Rx_InventoryManager_Nod_Technician(Other).SecondaryWeapons[0] = class'Rx_Weapon_Shotgun';
	}

	return true;
}

