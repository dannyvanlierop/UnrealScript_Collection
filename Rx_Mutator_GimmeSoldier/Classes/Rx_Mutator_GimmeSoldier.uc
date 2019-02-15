/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will let you change the soldier skin in the Renegade X game  *
*******************************************************************************
* Rx_Mutator_GimmeSoldier                                                    *
******************************************************************************/
 
class Rx_Mutator_GimmeSoldier extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_GimmeSoldier_Controller'; } return true; }

DefaultProperties { 
}
 