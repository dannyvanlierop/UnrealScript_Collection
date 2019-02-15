/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminGhost_Controller extends Rx_Controller;

exec function AdminGhost(){
	AdminGhostServer();
}

Reliable server function AdminGhostServer(){
	if (!PlayerReplicationInfo.bAdmin) return;
	
	if ( (Pawn != None) && Pawn.CheatGhost() )
	{
		bCheatFlying = true;
		Outer.GotoState('PlayerFlying');
	}
	else
	{
		bCollideWorld = false;
	}

	ClientMessage("You feel ethereal");
}
