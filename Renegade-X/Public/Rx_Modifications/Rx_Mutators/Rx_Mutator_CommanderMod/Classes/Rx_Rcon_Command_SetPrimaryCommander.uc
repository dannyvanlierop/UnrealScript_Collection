/*
** Rx_Rcon_Command_SetPrimaryCommander
*/

class Rx_Rcon_Command_SetPrimaryCommander extends Rx_Rcon_Command;

function string trigger(string parameters)
{
	local Rx_PRI PRI;
	local string error;
	local Rx_CommanderController myCC, CCI;


	
	if (parameters == "")
		return "Error: Too few parameters." @ getSyntax();

	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(parameters, error);
	
	foreach AllActors(class'Rx_CommanderController', CCI) //Get the Command controller.
	{
		myCC = CCI ;
		break;
	}
		
	
	if (PRI == None)
		return error;

	if (Controller(PRI.Owner) == None)
		return "Error: Player has no controller!";

	LogInternal("A commander was Forced");
	myCC.SetCommander(Rx_Controller(PRI.Owner), PRI.Team.TeamIndex, 0);

	return "";
}

function string getHelp(string parameters)
{
	return "Forcibly sets a commander" @ getSyntax();
}

