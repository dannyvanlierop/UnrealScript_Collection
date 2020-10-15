/******************************************************************************
*  Written by Ukill                                                           *
*******************************************************************************
* Rx_Mutator_AdminGiveVP                                                      *
******************************************************************************/
 
class Rx_Mutator_AdminGiveVP extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminGiveVP_Controller'; } return true; } 

DefaultProperties { 
}
 