/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the weapondrop function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_AllowWeaponDrop                                                  *
******************************************************************************/

class Rx_Mutator_AllowWeaponDrop extends UTMutator;

function bool CheckReplacement(Actor Other) { if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator_AllowWeaponDrop_Pawn'; } return true; }

DefaultProperties {
} 
 