/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminInvisible_Controller extends Rx_Controller;

exec function AdminInvisible(bool B){
       AdminInvisibleServer(B);
}
reliable server function AdminInvisibleServer(bool B){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	if ( UTPawn(Pawn) != None )
	{
		UTPawn(Pawn).SetInvisible(B);
	}
}
