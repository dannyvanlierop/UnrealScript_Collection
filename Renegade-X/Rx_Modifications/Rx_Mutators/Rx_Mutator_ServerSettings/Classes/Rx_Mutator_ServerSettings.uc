/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
* This mutator will set without config the MaxPlayers possible for the server *
*******************************************************************************
* Rx_Mutator_ServerSettings                                                   *
******************************************************************************/

class Rx_Mutator_ServerSettings extends Rx_Mutator config(Game);
function SetServerName(string name) { Game.GameReplicationInfo.ServerName = name; }
defaultproperties { }
 