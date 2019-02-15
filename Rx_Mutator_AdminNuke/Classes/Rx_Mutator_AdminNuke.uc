/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminNuke extends UTMutator;

function bool CheckReplacement(Actor Other) {
    if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminNuke_Controller'; } return true; } 

DefaultProperties { 
}
 