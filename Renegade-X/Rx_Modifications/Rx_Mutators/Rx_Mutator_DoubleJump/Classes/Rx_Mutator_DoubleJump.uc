/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the DoubleJump function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_DoubleJump                                                       *
******************************************************************************/

class Rx_Mutator_DoubleJump extends UTMutator;


function InitMutator(string Options, out string ErrorMessage)
{
	if (Rx_Game(WorldInfo.Game) != None)
	{
	
	}	
super.InitMutator(Options, ErrorMessage);	 	 
}

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) {
		Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator_DoubleJump_Pawn' ;
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_DoubleJump_Controller' ; 
	}
return true;
}

DefaultProperties {
}
 