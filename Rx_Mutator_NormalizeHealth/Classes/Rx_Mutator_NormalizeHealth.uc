/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*                   This mutator will Normalize Health                        *
*******************************************************************************
* Rx_Mutator_NormalizeHealth                                                  *
******************************************************************************/

class Rx_Mutator_NormalizeHealth extends UTMutator ;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator_NormalizeHealth_Pawn' ; } return true; }
 