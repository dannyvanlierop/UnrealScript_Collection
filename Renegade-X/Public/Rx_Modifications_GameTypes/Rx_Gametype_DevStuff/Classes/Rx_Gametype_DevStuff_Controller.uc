/*
** Rx_Gametype_DevStuff_Controller
*/

class Rx_Gametype_DevStuff_Controller extends Rx_Controller;

/**********
* DevNuke *
**********/

exec function Nuke(string PlayerName)
{
	NukeServer(PlayerName);
}

reliable server function NukeServer(string PlayerName)
{
	local Rx_Weapon_DevNuke Beacon;
	local Rx_PRI PRI;

		PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

		if (PRI != None && Controller(PRI.Owner) != None)
		{
			Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevNuke',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED;
		}
}

exec function NukeAll()
{
	NukeAllServer();
}

reliable server function NukeAllServer()
{
	local Rx_Weapon_DevNuke Beacon;
	local Rx_Controller C;
		foreach WorldInfo.AllControllers(class'Rx_Controller', C)
		{
			Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevNuke',,, C.Pawn.Location, C.Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED;
	}
}


/****************
* FutureSoldier *
****************/

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
 