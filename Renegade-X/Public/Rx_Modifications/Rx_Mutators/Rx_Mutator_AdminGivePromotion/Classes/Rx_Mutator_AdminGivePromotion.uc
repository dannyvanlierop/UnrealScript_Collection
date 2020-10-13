/******************************************************************************
*  Written by Ukill                                                           *
*******************************************************************************
* Rx_Mutator_AdminGivePromotion                                                      *
******************************************************************************/
 
class Rx_Mutator_AdminGivePromotion extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminGivePromotion_Controller'; } return true; } 

DefaultProperties { 
}
 