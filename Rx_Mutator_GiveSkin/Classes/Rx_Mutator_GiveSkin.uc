/******************************************************************************
* This mutator will let you change the soldier skin in the Renegade X game    *
* Contributions : Ukill, Schmitzenbergh										  *
*******************************************************************************
* Rx_Mutator_GiveSkin                                                  *
******************************************************************************/
 
class Rx_Mutator_GiveSkin extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_GiveSkin_Controller'; } return true; }

DefaultProperties { 
}
 