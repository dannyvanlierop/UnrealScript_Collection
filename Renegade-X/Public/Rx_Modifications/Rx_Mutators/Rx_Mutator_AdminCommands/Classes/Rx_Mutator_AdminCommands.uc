 
class Rx_Mutator_AdminCommands extends UTMutator;

function bool CheckReplacement(Actor Other) {
    if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_AdminCommands_Controller'; } return true; } 

function InitMutator(string Options, out string ErrorMessage) {
    WorldInfo.Game.MaxPlayersAllowed = 60; WorldInfo.Game.MaxPlayers = 60; Super.InitMutator(Options, ErrorMessage); }

DefaultProperties { 
}
 