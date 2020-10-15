/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will add the InfiniteAmmo function to the Renegade X game    *
*******************************************************************************
* Rx_Mutator_InfiniteAmmo                                                     *
******************************************************************************/

class Rx_Mutator_InfiniteAmmo extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if (Rx_Weapon(Other) != None && Rx_Weapon_Deployable(Other) == None && Rx_Weapon_Grenade(Other) == None) Rx_Weapon(Other).bHasInfiniteAmmo = true;
	return true;
}
 