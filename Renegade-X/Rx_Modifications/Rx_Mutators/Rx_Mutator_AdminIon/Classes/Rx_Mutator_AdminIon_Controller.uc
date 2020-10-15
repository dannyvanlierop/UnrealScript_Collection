/******************************* Written by Ukill *******************************/
class Rx_Mutator_AdminIon_Controller extends Rx_Controller;

exec function AdminIon(string PlayerName) { AdminIonServer(PlayerName); }

reliable server function AdminIonServer(string PlayerName) {
	local Rx_Weapon_DevIon Beacon;
	local Rx_PRI PRI;

	if ( !PlayerReplicationInfo.bAdmin)
	return;
	
	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);
	if (PRI != None && Controller(PRI.Owner) != None) { 
		Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevIon',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; }
}

exec function AdminIonAll() { AdminIonAllServer(); }

reliable server function AdminIonAllServer() {
	local Rx_Weapon_DevIon Beacon;
	local Rx_Controller C;

	if ( !PlayerReplicationInfo.bAdmin)
	return;
	
	foreach WorldInfo.AllControllers(class'Rx_Controller', C) { 
		Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevIon',,, C.Pawn.Location, C.Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; 
	} 
}
