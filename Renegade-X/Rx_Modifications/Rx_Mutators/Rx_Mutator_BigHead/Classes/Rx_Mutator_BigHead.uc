/*
**  by Ukill, supported by google :).
**  this mutator will add the ............. function to the Renegade X game
*/

class Rx_Mutator_BigHead extends UTMutator;

/* called by GameInfo.RestartPlayer()
	change the players jumpz, etc. here
*/
function ModifyPlayer(Pawn P)
{
	if ( UTPawn(P) != None )
	{
		UTPawn(P).SetBigHead();
	}
	Super.ModifyPlayer(P);
}

defaultproperties
{
	GroupNames[0]="BIGHEAD"
}


