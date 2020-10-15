/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminGiveCredits_Controller extends Rx_Controller;

exec function AdminGiveCredits(int amount) 
{
       AdminGiveCreditsServer(amount);
}
 
reliable server function AdminGiveCreditsServer(int amount)
{
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	Rx_PRI(PlayerReplicationInfo).AddCredits(amount);
}
 