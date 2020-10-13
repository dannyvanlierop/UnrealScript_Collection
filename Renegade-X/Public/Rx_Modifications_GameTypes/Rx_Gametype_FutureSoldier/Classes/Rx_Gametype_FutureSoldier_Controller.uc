/**
 * Rx_Gametype_FutureSoldier_Controller
 *
 * */
class Rx_Gametype_FutureSoldier_Controller extends Rx_Controller;

/*
**function SetIsDev(bool in_is_dev)
**{
**	bIsDev = in_is_dev;
**	`LogRx("PLAYER" `s "Dev;" `s `PlayerLog(PlayerReplicationInfo) `s string(in_is_dev));
**}
**
**function SetRank(int in_rank)
**{
**	ladder_rank = in_rank;
**	`LogRx("PLAYER" `s "Rank;" `s `PlayerLog(PlayerReplicationInfo) `s string(in_rank));
**}
*/

exec function FutureSoldier()
{
	if (Pawn != None && Vehicle(Pawn) == None)
	{
		if (Worldinfo.NetMode == NM_Standalone)
		{
			if (GetTeamNum() == TEAM_GDI)
				Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
			else
				Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
		}
		else
			FutureSoldierServer();
	}
}

reliable server function FutureSoldierServer()
{
	local Rx_Controller PC;
/*	if (bIsDev)
 *	{
 */
		if (GetTeamNum() == TEAM_GDI)
		{
			Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
			foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
				PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
		}
		else
		{
			Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
			foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
				PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
		}
/*
 *	}
 */
}

reliable client function FutureSoldierClient(Pawn P, SkeletalMesh skel)
{
	P.Mesh.SetSkeletalMesh(skel);
}
