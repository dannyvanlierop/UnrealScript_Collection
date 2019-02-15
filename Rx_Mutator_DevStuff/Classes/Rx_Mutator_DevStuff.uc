/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the Dev NukeAll function to the Renegade X game    *
*              BE WARNED, ALL PLAYERS CAN USE THIS FEATURE !!!!!!             *
*******************************************************************************
* Rx_Mutator_DevStuff                                                          *
******************************************************************************/
 
class Rx_Mutator_DevStuff extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_DevStuff_Controller'; } return true; } 

DefaultProperties { 
}
 