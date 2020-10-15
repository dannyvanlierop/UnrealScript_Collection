/******************************************************************************
*  Written by Ukill                                                           *
*******************************************************************************
* Rx_Mutator_AdminGivePromotion_Controller                                           *
******************************************************************************/
 
class Rx_Mutator_AdminGivePromotion_Controller extends Rx_Controller;

exec function AdminGivePromotion()
{
	AdminGivePromotionServer();
}

reliable server function AdminGivePromotionServer()
{
	if ( !PlayerReplicationInfo.bAdmin)
	return;

	if (Rx_PRI(PlayerReplicationInfo).VRank < ArrayCount(Rx_Game(WorldInfo.Game).default.VPMilestones))
		Rx_PRI(PlayerReplicationInfo).AddVP(Rx_Game(WorldInfo.Game).default.VPMilestones[Rx_PRI(PlayerReplicationInfo).VRank] - Rx_PRI(PlayerReplicationInfo).Veterancy_Points);
}
