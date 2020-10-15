// *****************************************************************************
//  * * * * * * * * * * * * * * Rx_Mutator_SendString * * * * * * * * * * * * * 
// *****************************************************************************
class Rx_Mutator_SendString extends Rx_Mutator;

function InitMutator(string Options, out string ErrorMessage)
{
	if (Rx_Game(WorldInfo.Game) != None)
	{
	
	}	
super.InitMutator(Options, ErrorMessage);	 	 
}

function bool CheckReplacement(Actor Other) 
{ 
	if(Other.IsA('Rx_TeamInfo')) 
	{
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_SendString_Controller';
	} 
return true; 
} 

DefaultProperties
{
}