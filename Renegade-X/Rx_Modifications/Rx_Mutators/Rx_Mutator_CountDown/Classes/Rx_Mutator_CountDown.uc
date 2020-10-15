// *****************************************************************************
//  * * * * * * * * * * * * Rx_Mutator_CountDown * * * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_CountDown extends Rx_Mutator;

function bool CheckReplacement(Actor Other)
{ 	
	if(Other.IsA('Rx_TeamInfo')) 
	{ 
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_CountDown_Controller' ; 
	} return true;
}

defaultproperties
{
}





