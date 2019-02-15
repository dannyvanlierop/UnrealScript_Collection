class Rx_Mutator_LockBuildingHealth extends Rx_Mutator;

function bool CheckReplacement(Actor Other)
{ 	
	if(Other.IsA('Rx_TeamInfo')) 
	{ 
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_LockBuildingHealth_C'; 
	} return true;
}


defaultproperties
{
}

