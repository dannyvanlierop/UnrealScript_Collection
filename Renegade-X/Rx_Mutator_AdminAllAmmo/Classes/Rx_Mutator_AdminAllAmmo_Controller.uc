/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminAllAmmo_Controller extends Rx_Controller;

exec function AdminAllAmmo(){
       AdminAllAmmoServer();
}
reliable server function AdminAllAmmoServer(){
	
	if (!PlayerReplicationInfo.bAdmin)
	return;

	if ( (Pawn != None) && (UTInventoryManager(Pawn.InvManager) != None) )
	{
		UTInventoryManager(Pawn.InvManager).AllAmmo(true);
		UTInventoryManager(Pawn.InvManager).bInfiniteAmmo = true;
	}
}
