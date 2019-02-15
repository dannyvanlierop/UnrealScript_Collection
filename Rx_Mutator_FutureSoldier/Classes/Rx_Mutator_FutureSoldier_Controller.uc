/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will add the FutureSoldier function to the Renegade X game   *
*******************************************************************************
* Rx_Mutator_FutureSoldier_Controller                                         *
******************************************************************************/

class Rx_Mutator_FutureSoldier_Controller extends Rx_Controller;

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
	if (bIsDev == false)
	{
		if(PlayerReplicationInfo.bAdmin)
		{		
			if (GetTeamNum() == TEAM_GDI) {
				Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE');
				foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
					PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier_TE'); }
			else {
				Pawn.Mesh.SetSkeletalMesh(SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE');
				foreach WorldInfo.AllControllers(class'Rx_Controller', PC)
					PC.FutureSoldierClient(Pawn, SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE'); }
		}
	}
}

reliable client function FutureSoldierClient(Pawn P, SkeletalMesh skel) { P.Mesh.SetSkeletalMesh(skel); }

DefaultProperties 
{ 
	bIsDev = false
}
 