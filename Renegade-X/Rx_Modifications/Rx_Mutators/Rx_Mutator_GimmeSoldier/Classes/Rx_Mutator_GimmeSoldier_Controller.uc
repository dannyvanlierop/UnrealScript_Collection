/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will let you change the soldier skin in the Renegade X game  *
*******************************************************************************
* Rx_Mutator_GimmeSoldier_Controller                                          *
******************************************************************************/
 
class Rx_Mutator_GimmeSoldier_Controller extends Rx_Controller;
 
var string team;
var string ReferenceArray[33];
//var array<string> ReferenceArray;
var SkeletalMesh MeshArray[33];
var int GimmieSoldierHelpedTier;

reliable server function GeneralServer(int MeshIndex)
{
    local Rx_Mutator_GimmeSoldier_Controller PC;

	Pawn.Mesh.SetSkeletalMesh(MeshArray[MeshIndex]);
    foreach WorldInfo.AllControllers(class'Rx_Mutator_GimmeSoldier_Controller', PC)
        PC.GeneralClient(Pawn, MeshArray[MeshIndex]);
}	

reliable client function GeneralClient(Pawn P, SkeletalMesh skel) { P.Mesh.SetSkeletalMesh(skel); }
 
exec function GimmeSoldier(string SoldierName)
{
	local int x;

    if (GetTeamNum() == TEAM_GDI) { (team)="GDI";}
    if (GetTeamNum() == TEAM_NOD) { (team)="NOD";}
    if (Pawn != None && Vehicle(Pawn) == None) 
	{
        for (x = 0; x < 34; x++)
        {
			if(SoldierName == ReferenceArray[x])
			{
				GeneralServer(x);
				x = 99;
			}			
        }      
    }
}

exec function GimmeSoldierLoop()
{
local int x;
	
	if (GetTeamNum() == TEAM_GDI) { (team)="GDI";}
    if (GetTeamNum() == TEAM_NOD) { (team)="NOD";}
		
	switch (GimmieSoldierHelpedTier)
	{
		default :
			x=GimmieSoldierHelpedTier;
			if(ReferenceArray[x] == ReferenceArray[x])
			{
				GeneralServer(x);
				break;
			}
		
	}
	GimmieSoldierHelpedTier = GimmieSoldierHelpedTier + 1;
	if(GimmieSoldierHelpedTier <= 34)
		settimer(5,false,'GimmeSoldierLoop');
	else
		GimmieSoldierHelpedTier = 0;
}



DefaultProperties
{
/*arrayvariable[index] = value					Specify 1 item*/
//The default data for a dynamic array can either be specified per element, similar to static arrays, or for the entire array at once. The per-element syntax is identical to that of static arrays:

	//Set the name references
	ReferenceArray[0] = "GDI_Soldier";
    ReferenceArray[1] = "GDI_Shotgunner";
    ReferenceArray[2] = "GDI_Engineer";	
    ReferenceArray[3] = "GDI_Officer";
    ReferenceArray[4] = "GDI_Grenadier";
    ReferenceArray[5] = "GDI_RocketSoldier";
    ReferenceArray[6] = "GDI_McFarland";
    ReferenceArray[7] = "GDI_Deadeye";
    ReferenceArray[8] = "GDI_Gunner";
    ReferenceArray[9] = "GDI_Patch";
    ReferenceArray[10] = "GDI_Havoc";
    ReferenceArray[11] = "GDI_Sydney";
    ReferenceArray[12] = "GDI_Mobius";
    ReferenceArray[13] = "GDI_Hotwire";
    ReferenceArray[14] = "Nod_Soldier";
    ReferenceArray[15] = "Nod_Shotgunner";
    ReferenceArray[16] = "Nod_FlameTrooper";
    ReferenceArray[17] = "Nod_Engineer";
    ReferenceArray[18] = "Nod_Officer";
    ReferenceArray[19] = "Nod_RocketSoldier";
    ReferenceArray[20] = "Nod_ChemicalTrooper";
    ReferenceArray[21] = "Nod_BlackHandSniper";
    ReferenceArray[22] = "Nod_StealthBlackHand";
    ReferenceArray[23] = "Nod_LaserChainGunner";
    ReferenceArray[24] = "Nod_Sakura";
    ReferenceArray[25] = "Nod_Ravenshaw";
    ReferenceArray[26] = "Nod_Mendoza";
    ReferenceArray[27] = "Nod_Technician";
    ReferenceArray[28] = "Nod_FutureSoldier";
    ReferenceArray[29] = "GDI_FutureSoldier";
    ReferenceArray[30] = "GDI_FutureSoldier_Old";
	ReferenceArray[31] = "Nod_Soldier_Green";
	ReferenceArray[32] = "UT_Crowd_Robot";	 

	//Set the Meshes according to the referenceArray
	MeshArray[0] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier';
	MeshArray[1] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Shotgunner';
	MeshArray[2] =  SkeletalMesh'rx_ch_engineer.Mesh.SK_CH_Engineer_GDI';
	MeshArray[3] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_Officer_New';
	MeshArray[4] =  SkeletalMesh'rx_ch_gdi_soldier.Mesh.SK_CH_GDI_Grenadier';
	MeshArray[5] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_RocketSoldier';
	MeshArray[6] =  SkeletalMesh'rx_ch_gdi_officer.Mesh.SK_CH_McFarland';
	MeshArray[7] =  SkeletalMesh'rx_ch_gdi_deadeye.Mesh.SK_CH_Deadeye';
	MeshArray[8] =  SkeletalMesh'RX_CH_GDI_Gunner.Mesh.SK_CH_Gunner_NewRig';
	MeshArray[9] =  SkeletalMesh'rx_ch_gdi_patch.Mesh.SK_CH_Patch';
	MeshArray[10] = SkeletalMesh'RX_CH_GDI_Havoc.Mesh.SK_CH_Havoc';
	MeshArray[11] = SkeletalMesh'rx_ch_gdi_sydney.Mesh.SK_CH_Sydney';
	MeshArray[12] = SkeletalMesh'rx_ch_gdi_mobius.Mesh.SK_CH_Mobius_New';
	MeshArray[13] = SkeletalMesh'rx_ch_gdi_hotwire.Mesh.SK_CH_Hotwire_New';
	MeshArray[14] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier';
	MeshArray[15] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Black';
	MeshArray[16] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Red';
	MeshArray[17] = SkeletalMesh'rx_ch_engineer.Mesh.SK_CH_Engineer_Nod';
	MeshArray[18] = SkeletalMesh'rx_ch_nod_officer.Mesh.SK_CH_Officer_Nod';
	MeshArray[19] = SkeletalMesh'rx_ch_nod_officer.Mesh.SK_CH_RocketOfficer_Nod';
	MeshArray[20] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_ChemicalTrooper';
	MeshArray[21] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_BlackHandSniper';
	MeshArray[22] = SkeletalMesh'RX_CH_Nod_SBH.Mesh.SK_CH_StealthBlackHand';
	MeshArray[23] = SkeletalMesh'RX_CH_Nod_BHS.Mesh.SK_CH_LaserChainGunner';
	MeshArray[24] = SkeletalMesh'RX_CH_Nod_Sakura.Mesh.SK_CH_Sakura';
	MeshArray[25] = SkeletalMesh'RX_CH_Nod_Raveshaw.Mesh.SK_CH_Raveshaw';
	MeshArray[26] = SkeletalMesh'RX_CH_Nod_Mendoza.Mesh.SK_CH_Mendoza';
	MeshArray[27] = SkeletalMesh'RX_CH_Technician.Meshes.SK_CH_Technician';
	MeshArray[28] = SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE';
	MeshArray[29] = SkeletalMesh'ts_ch_gdi_soldier.Mesh.SK_CH_GDI_Soldier';
	MeshArray[30] = SkeletalMesh'ts_ch_nod_soldier.Mesh.SK_CH_Nod_Soldier_TE';
	MeshArray[31] = SkeletalMesh'RX_CH_Nod_Soldier.Mesh.SK_CH_Nod_Soldier_Green'
	MeshArray[32] = SkeletalMesh'utexamplecrowd.Mesh.SK_Crowd_Robot';
}
 