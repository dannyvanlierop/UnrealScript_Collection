 
class Rx_Mutator_GiveCredits extends UTMutator;

function bool CheckReplacement(Actor Other) {
    if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_GiveCredits_Controller'; } return true; } 

DefaultProperties { 
}
 