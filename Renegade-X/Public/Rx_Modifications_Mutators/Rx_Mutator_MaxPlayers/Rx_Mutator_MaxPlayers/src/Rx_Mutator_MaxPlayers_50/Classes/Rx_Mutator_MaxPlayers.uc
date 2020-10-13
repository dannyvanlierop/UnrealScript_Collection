/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*  This mutator will set the MaxPlayers without server config to 56 Players  *
*******************************************************************************
* Rx_Mutator_MaxPlayers                                                       *
******************************************************************************/

class Rx_Mutator_MaxPlayers extends Rx_Mutator;

var int max_players;

function InitMutator(string Options, out string ErrorMessage) {
	WorldInfo.Game.MaxPlayersAllowed = max_players;
	WorldInfo.Game.MaxPlayers = max_players;
	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties 
{ 
    max_players=50
}
 