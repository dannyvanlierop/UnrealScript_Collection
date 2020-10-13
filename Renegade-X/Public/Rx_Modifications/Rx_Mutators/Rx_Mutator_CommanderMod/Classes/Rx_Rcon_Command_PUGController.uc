/*
** Rx_Rcon_Command_PUGController
*/

class Rx_Rcon_Command_PUGController extends Rx_Rcon_Command;

function string trigger(string parameters)
{
	local Rx_PRI PRI;
	//local string error;
	local Rx_PUGController PCon, PConI;

foreach AllActors(class'Rx_PUGController', PConI) //Get the PUG Controller thing
	{
		PCon = PConI ;
		break;
	}
	
	if (parameters == "")
		return "Error: Too few parameters." @ getSyntax();

	if(Caps(parameters) == "LOCKTEAMS") 
	{
	PCon.LockTeams();		
	return "Teams Have Been Saved In Config For Next Start-up." ;
	}
	
	if(Caps(parameters) == "FORCETEAMS") 
	{
	PCon.ForceTeams();		
	return "Teams Have Been Forced" ;
	}
	
	if(Caps(parameters) == "SWAPTEAMS") 
	{
	PCon.SwapTeams();		
	return "Teams Have Been Swapped" ;
	}
	return "";
}

function string getHelp(string parameters)
{
	return "Stores, locks and swaps teams for competitive matches" @ getSyntax();
}

