/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the Dev NukeAll function to the Renegade X game    *
*              Be warned, all players can use this feature                    *
*******************************************************************************
* Rx_Mutator_DevStuff_Controller                                               *
******************************************************************************/
 
class Rx_Mutator_DevStuff_Controller extends Rx_Controller;

exec function FutureSoldier() {
	if (Pawn != None && Vehicle(Pawn) == None) {
		if (Worldinfo.NetMode == NM_Standalone) {
			if (GetTeamNum() == TEAM_GDI) Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
			else Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE'); }
		else FutureSoldierServer(); }
}

reliable server function FutureSoldierServer() 
{
	local Rx_Controller PC;

	if (GetTeamNum() == TEAM_GDI) {
		Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
		foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
			PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE'); }
	else {
		Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
		foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
			PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE'); }
}


exec function Nuke(string PlayerName) { NukeServer(PlayerName); }
exec function NukeAll() { NukeAllServer(); }

reliable server function NukeServer(string PlayerName) {
	local Rx_Weapon_DevNuke Beacon;
	local Rx_PRI PRI;

	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

	if (PRI != None && Controller(PRI.Owner) != None) 
	{ 
		Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevNuke',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; 
	}
}

reliable server function NukeAllServer() {
	local Rx_Weapon_DevNuke Beacon;
	local Rx_Controller C;

	foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
		Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevNuke',,, C.Pawn.Location, C.Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; 
		} 
}
 
 DefaultProperties 
{ 

}
 