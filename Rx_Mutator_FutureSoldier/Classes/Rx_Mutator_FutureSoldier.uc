/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will add the FutureSoldier function to the Renegade X game   *
*******************************************************************************
* Rx_Mutator_FutureSoldier                                                    *
******************************************************************************/
 
class Rx_Mutator_FutureSoldier extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_FutureSoldier_Controller'; } return true; }

DefaultProperties { 
}
 