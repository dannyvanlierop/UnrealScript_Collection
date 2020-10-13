/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminAmphibious_Controller extends Rx_Controller;

exec function AdminAmphibious(){
	AdminAmphibiousServer();
}

Reliable server function AdminAmphibiousServer(){

	local bool bAmphibiousMode;
	
	if (!PlayerReplicationInfo.bAdmin) return;
	
	if ( Pawn != None )
	{
		if ( Pawn.UnderwaterTime < 1000 )
		{
		
			Pawn.UnderwaterTime = +999999.0;
			bAmphibiousMode=true;
		}
		else
		{
			Pawn.UnderwaterTime = 10.0;
			bAmphibiousMode=false;
		}
		
		ClientMessage("Amphibious mode " $ bAmphibiousMode);
	}		
}
