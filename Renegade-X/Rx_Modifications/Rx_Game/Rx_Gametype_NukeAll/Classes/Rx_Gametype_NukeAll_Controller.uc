/**
 * Rx_Gametype_NukeAll_Controller
 *
 * */
class Rx_Gametype_NukeAll_Controller extends Rx_Controller;

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
