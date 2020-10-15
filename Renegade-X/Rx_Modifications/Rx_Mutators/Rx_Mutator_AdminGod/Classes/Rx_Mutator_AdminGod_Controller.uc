/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminGod_Controller extends Rx_Controller;

exec function AdminGod(){
	AdminGodServer();
}

Reliable server function AdminGodServer(){
	if (!PlayerReplicationInfo.bAdmin) return;

	bGodMode = (!bGodMode); ClientMessage("God mode " $ bGodMode);
}

