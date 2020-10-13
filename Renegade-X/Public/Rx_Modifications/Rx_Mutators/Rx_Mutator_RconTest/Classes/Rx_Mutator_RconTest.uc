 
class Rx_Mutator_RconTest extends Rx_Mutator;

var Rx_Rcon_Commands_Container RconCommands;


var Rx_GameEngine GE;

function bool CheckReplacement(Actor Other)
{
	if(Other.IsA('Rx_TeamInfo'))
	{
		LogInternal("Set PlayerControllerClass");
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_RconTest_Controller';
		
		if (RconCommands == None)
		{
			RconCommands = new class'Rx_Rcon_Commands_Container_Ext';
			RconCommands.InitRconCommands();
		}
		
	}

	return true;
}

function InitMutator(string Options, out string ErrorMessage)
{
	Super.InitMutator(Options, ErrorMessage);
	

}

function InitRconCommands()
{
	Super.InitRconCommands();
}



DefaultProperties { 
}
 