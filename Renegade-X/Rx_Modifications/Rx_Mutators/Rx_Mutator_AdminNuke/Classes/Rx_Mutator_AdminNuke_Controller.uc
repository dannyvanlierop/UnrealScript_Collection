/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminNuke_Controller extends Rx_Controller;

exec function AdminNuke(string PlayerName) { AdminNukeServer(PlayerName); }

reliable server function AdminNukeServer(string PlayerName) {
	local Rx_Weapon_DevNuke Beacon;
	local Rx_PRI PRI;

	if ( !PlayerReplicationInfo.bAdmin)
	return;
	
	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);
	if (PRI != None && Controller(PRI.Owner) != None) { 
		Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevNuke',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; }
}

exec function AdminNukeAll() { AdminNukeAllServer(); }

reliable server function AdminNukeAllServer() {
	local Rx_Weapon_DevNuke Beacon;
	local Rx_Controller C;

	if ( !PlayerReplicationInfo.bAdmin)
	return;
	
	foreach WorldInfo.AllControllers(class'Rx_Controller', C) { 
		Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevNuke',,, C.Pawn.Location, C.Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; 
	} 
}
