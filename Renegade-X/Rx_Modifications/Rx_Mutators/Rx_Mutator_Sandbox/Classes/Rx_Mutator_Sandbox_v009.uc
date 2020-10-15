/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*      This mutator will add the Sandbox function to the Renegade X game      *
*******************************************************************************
* Rx_Mutator_Sandbox_v009                                                     *
******************************************************************************/

class Rx_Mutator_Sandbox_v009 extends UTMutator;

function bool CheckReplacement(Actor Other) 
{ // if (Rx_Game(WorldInfo.Game) != None)
	if(Other.IsA('Rx_TeamInfo')) { Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_Sandbox_v009_Controller'; } return true; 
} 

DefaultProperties
{

}
 