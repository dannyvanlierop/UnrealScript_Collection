/******************************************************************************
*  Written by Ukill                                                           *
*******************************************************************************
* Rx_Mutator_AdminGiveVP_Controller                                           *
******************************************************************************/
 
class Rx_Mutator_AdminGiveVP_Controller extends Rx_Controller;

exec function AdminGiveVP(float amount)
{
	AdminGiveVPServer(amount);
}

reliable server function AdminGiveVPServer(float amount)
{
	if ( !PlayerReplicationInfo.bAdmin)
	return;

	Rx_PRI(PlayerReplicationInfo).AddVP(amount);	
}
