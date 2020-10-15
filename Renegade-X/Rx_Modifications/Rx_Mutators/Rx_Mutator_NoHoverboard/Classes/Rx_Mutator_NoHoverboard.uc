/*
**  by Ukill, supported by google :).
**  this mutator will add the ............. function to the Renegade X game
*/

class Rx_Mutator_NoHoverboard extends UTMutator;

function InitMutator(string Options, out string ErrorMessage)
{
	if ( UTGame(WorldInfo.Game) != None )
	{
		UTGame(WorldInfo.Game).bAllowHoverboard = false;
	}
	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
	GroupNames[0]="HOVERBOARD"
}
