/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminSetGravity_Controller extends Rx_Controller;

exec function AdminSetGravity(float F){
       AdminSetGravityServer(F);
}
reliable server function AdminSetGravityServer(float F){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	WorldInfo.WorldGravityZ = F;
}
