
class Rx_Mutator_GiveCredits_Controller extends Rx_Controller;

exec function GiveCredits(int amount) 
{
       GiveCreditsServer(amount);
}
 
reliable server function GiveCreditsServer(int amount)
{
	if ( !PlayerReplicationInfo.bAdmin)
	return;
	
	Rx_PRI(PlayerReplicationInfo).AddCredits(amount);
}
 