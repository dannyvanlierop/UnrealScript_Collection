/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminSetGameSpeed_Controller extends Rx_Controller;

exec function AdminSetGameSpeed(float T){
       AdminSetGameSpeedServer(T);
}

reliable server function AdminSetGameSpeedServer(float T){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	WorldInfo.Game.SetGameSpeed(T);
}
