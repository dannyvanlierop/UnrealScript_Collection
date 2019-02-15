/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminGod extends UTMutator;

function bool CheckReplacement(Actor Other) {
    if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminGod_Controller'; } return true; } 

DefaultProperties { 
}
 