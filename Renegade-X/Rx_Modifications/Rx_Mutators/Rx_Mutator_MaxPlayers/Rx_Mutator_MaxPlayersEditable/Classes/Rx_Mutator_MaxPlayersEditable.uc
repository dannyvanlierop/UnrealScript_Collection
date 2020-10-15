/******************************************************************************
*  Written by Ukill															  *
*******************************************************************************
* Rx_Mutator_MaxPlayersEditable                                               *
******************************************************************************/
 
class Rx_Mutator_MaxPlayersEditable extends Rx_Mutator;

var int max_players;

function InitMutator(string Options, out string ErrorMessage) {
	max_players=1024;
    WorldInfo.Game.MaxPlayersAllowed = max_players;
    WorldInfo.Game.MaxPlayers = max_players;
    Super.InitMutator(Options, ErrorMessage);
}
 