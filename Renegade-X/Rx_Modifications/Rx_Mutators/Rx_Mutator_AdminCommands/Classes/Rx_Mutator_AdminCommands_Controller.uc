class Rx_Mutator_AdminCommands_Controller extends Rx_Controller;

exec function AdminGiveCredits(int amount){
	AdminGiveCreditsServer(amount);
}

reliable server function AdminGiveCreditsServer(int amount){
	if (!PlayerReplicationInfo.bAdmin) return;	
	Rx_PRI(PlayerReplicationInfo).AddCredits(amount);
	}

exec function AdminGiveVP(float amount){
	AdminGiveVPServer(amount);
}

Reliable server function AdminGiveVPServer(float amount){
	if (!PlayerReplicationInfo.bAdmin) return;

	Rx_PRI(PlayerReplicationInfo).AddVP(amount);
}

exec function AdminGivePromotion(){
	AdminGivePromotionServer();
}

reliable server function AdminGivePromotionServer(){
	if (!PlayerReplicationInfo.bAdmin) return;

	if (Rx_PRI(PlayerReplicationInfo).VRank < ArrayCount(Rx_Game(WorldInfo.Game).default.VPMilestones))
	Rx_PRI(PlayerReplicationInfo).AddVP(Rx_Game(WorldInfo.Game).default.VPMilestones[Rx_PRI(PlayerReplicationInfo).VRank] - Rx_PRI(PlayerReplicationInfo).Veterancy_Points);
}

exec function AdminGod(){
	AdminGodServer();
}

Reliable server function AdminGodServer(){
	if (!PlayerReplicationInfo.bAdmin) return;

	bGodMode = (!bGodMode); ClientMessage("God mode " $ bGodMode);
}

exec function AdminFly(){
	AdminFlyServer();
}

Reliable server function AdminFlyServer(){
	if (!PlayerReplicationInfo.bAdmin) return;

	if ( (Pawn != None) && Pawn.CheatFly() )
	{
		ClientMessage("You feel much lighter");
		bCheatFlying = true;
		Outer.GotoState('PlayerFlying');
	}
}

exec function AdminWalk(){
	AdminWalkServer();
}
Reliable server function AdminWalkServer(){
	if (!PlayerReplicationInfo.bAdmin) return;
	
	if (Pawn != None && Pawn.CheatWalk())
	{
		ClientMessage("Back on 2 feets");
		bCheatFlying = false;
		Restart(false);
	}
	
}

exec function AdminAmphibious(){
	AdminAmphibiousServer();
}

Reliable server function AdminAmphibiousServer(){

	local bool bAmphibiousMode;
	
	if (!PlayerReplicationInfo.bAdmin) return;
	
	if ( Pawn != None )
	{
		if ( Pawn.UnderwaterTime < 1000 )
		{
		
			Pawn.UnderwaterTime = +999999.0;
			bAmphibiousMode=true;
		}
		else
		{
			Pawn.UnderwaterTime = 10.0;
			bAmphibiousMode=false;
		}
		
		ClientMessage("Amphibious mode " $ bAmphibiousMode);
	}		
}

exec function AdminGhost(){
	AdminGhostServer();
}

Reliable server function AdminGhostServer(){
	if (!PlayerReplicationInfo.bAdmin) return;
	
	if ( (Pawn != None) && Pawn.CheatGhost() )
	{
		bCheatFlying = true;
		Outer.GotoState('PlayerFlying');
	}
	else
	{
		bCollideWorld = false;
	}

	ClientMessage("You feel ethereal");
}

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

exec function AdminSetGameSpeed(float T){
       AdminSetGameSpeedServer(T);
}
reliable server function AdminSetGameSpeedServer(float T){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	WorldInfo.Game.SetGameSpeed(T);
}

exec function AdminSetJumpZ(float F){
       AdminSetJumpZServer(F);
}
reliable server function AdminSetJumpZServer(float F){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	Pawn.JumpZ = F;
}

exec function AdminSetGravity(float F){
       AdminSetGravityServer(F);
}
reliable server function AdminSetGravityServer(float F){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	WorldInfo.WorldGravityZ = F;
}

exec function AdminInvisible(bool B){
       AdminInvisibleServer(B);
}
reliable server function AdminInvisibleServer(bool B){
	if (!PlayerReplicationInfo.bAdmin)
	return;
	
	if ( UTPawn(Pawn) != None )
	{
		UTPawn(Pawn).SetInvisible(B);
	}
}


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
