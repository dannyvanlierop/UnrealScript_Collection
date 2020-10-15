// *****************************************************************************
//  * * * * * * * * * * * * Rx_Mutator_VoteSystemChange * * * * * * * * * * * * * *
// *****************************************************************************
class Rx_Mutator_VoteSystemChange extends UTMutator;

function bool CheckReplacement(Actor Other)
{ 	
	if(Other.IsA('Rx_TeamInfo')) 
	{ 
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_VoteSystemChange_Controller' ; 
	} return true;
}

defaultproperties
{
}





