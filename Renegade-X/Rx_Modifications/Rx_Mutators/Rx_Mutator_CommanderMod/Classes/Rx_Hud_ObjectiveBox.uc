/*
** Rx_Hud_ObjectiveBox
*/

class Rx_Hud_ObjectiveBox extends Rx_Hud_Component ; 

var SoundCue OboxTransitionSnd;
var bool UpdateStateFlag;
var int OBoxState;
//ADD OBOX WIDTH/HEIGHT

var float 		Obox_ScaleX, OBox_ScaleY, Obox_WantedScaleX, Obox_WantedScaleY			;
var float 		OBox_Width,  Obox_WantedWidth			;
var float 		OBox_Height, Obox_WantedHeight			;
var float		OBox_Alpha,  Obox_WantedAlpha			;
//Possibly delete this when finished.

//var float 		OBox_LogoAlpha,Obox_LogoWantedAlpha		May come into play later, but for now these are unnecessary

var float		OBox_TitleBackdropAlpha, OBox_WantedTitleBackdropAlpha;
//var float 		OBox_TitleAlpha, OBox_WantedTitleAlpha		; Same as Logo alpha
var float		Objectives_Alpha, Objectives_WantedAlpha	;

var float		OText_X, OText_Y, OText_WantedX, OText_WantedY	;
var float		OText_Scale, OText_WantedScale;
var float		OBox_X, OBox_Y, OBox_WantedX, OBox_WantedY	;
var float		ResScaleX, ResScaleY;

var float		Pos_Increment, Alpha_Increment, Scale_Increment, OText_Scale_Increment;
//The Objective box background
var Texture 	OBox_Backdrop 		;
var Texture		Glow_Backdrop		;


//Icons that are drawn on the objective box
var CanvasIcon 	GDI_Logo 			;
var CanvasIcon 	Nod_Logo 			;

var CanvasIcon  AttackIcon			;
var CanvasIcon	DefendIcon			;
var CanvasIcon	RepairIcon			;
var CanvasIcon	TakePointIcon		;

//Vehicle icons
var CanvasIcon VIcon_MedTank,VIcon_Humvee,VIcon_GDIAPC,VIcon_Mammoth,VIcon_MRLS,VIcon_Orca, VIcon_Tranny; 



//NOD vehicle icons//
var CanvasIcon VIcon_Buggy,VIcon_NODAPC,VIcon_Artillery,VIcon_LightTank,VIcon_FlameTank,VIcon_StealthTank,VIcon_Apache;



//Title handling variables
		
var font		Obox_TitleFont 		;
var LinearColor		Obox_TitleColor		; //Apparently Fontrenderinfo requires linear colors??? The hell?

//Objective strings
struct OBJECTIVE_INFO 
{
var	string 		OText		;
var	color		OColor		;
var	font		OFont		;	
var CanvasIcon 	OIcon		;
	
	structDefaultproperties 
	{
	OText="No Objective Set" 					
	OColor=(R = 255, G = 255, B = 255, A = 140) 
	OFont=Font'RenxHud.Font.AS_small' 			
	OIcon=(Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Interact', U= 0, V = 0, UL = 32, VL = 64) 			
		
	}
};

//Vehicle numbers//

var int VN_Buggy,VN_NAPC,VN_Artillery,VN_LightTank,VN_FlameTank,VN_StealthTank, VN_Apache, VN_NTranny;

var int VN_Humvee,VN_GAPC,VN_MRLS,VN_MediumTank,VN_MammothTank, VN_Orca, VN_GTranny;

//Needed Vehicle Numbers
var int WVN_Buggy,WVN_NAPC,WVN_Artillery,WVN_LightTank,WVN_FlameTank,WVN_StealthTank, WVN_Apache,WVN_NTranny;

var int WVN_Humvee,WVN_GAPC,WVN_MRLS,WVN_MediumTank,WVN_MammothTank, WVN_Orca, WVN_GTranny;

// Specific Infantry Numbers
var int IN_GSnipers, IN_Hotwires, IN_GAT, IN_GIB, IN_GIEB;

var int IN_NSnipers, IN_Technicians, IN_NAT, IN_SBH, IN_NIB, IN_NIEB;

//Wanted Specific Infantry Numbers
var int WIN_GSnipers, WIN_Hotwires, WIN_GAT, WIN_GIB, WIN_GIEB; 

var int WIN_NSnipers, WIN_Technicians, WIN_NAT, WIN_SBH, WIN_NIB, WIN_NIEB; 

//Cyclers to prevent updating numbers every tick
var int Cycler_PawnLocation, Cycler_VehicleType, Cycler_PawnType,Cycler_MiscFunctions, CycleRate;

var OBJECTIVE_INFO	Objective[3]	;

//ffsets
var 	float	 UC_YOffset, UC_XIconIndent, UC_VcompIndent, UC_IconScale; 
var		float 	 IUC_YOffset, IUC_XOffset, IUC_XIndent, IUC_YIndent;


//Types of orders commanders can give 
enum CALL_TYPE 
{
	CT_ATTACK,
	CT_DEFEND,
	CT_REPAIR,
	CT_TAKEPOINT
};
//Objective Fonts
var font 		Obox_AttackFont		;
var font 		Obox_DefendFont		;
var font 		Obox_RepairFont		;
var font 		Obox_TakePointFont	;

//Objective Colours
var color 		Obox_AttackColor	;
var color 		Obox_DefendColor	;
var color 		Obox_RepairColor	;
var color 		Obox_TakePointColor	;

//Offsets for where all things are to drawn (sans the title and logo.)





/////////
var Rx_ORI 		myORI;
var SoundCue 	UpdateSound			; //Sound when obejctive is updated (Purchase sound)

//DELETE(Maybe), just using to pinpoint where the objective box should be in-game.
var float TestX,TestY,TestX2,TestY2, XPerc, YPerc;
var bool TestGlow								;
var string MyTeam 								;


////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////







///////////////////////////////////////////////////////////
//////////////////////Begin Psuedo STATES//////////////////
///////////////////////////////////////////////////////////

	

function Update(float DeltaTime, Rx_HUD HUD) 
{
	local int i;
	local Rx_ORI ORI;
	
	super.Update(DeltaTime, HUD);
	
	
	
	
	if(myORI == none) //Find my ORI
	{
		//Initial set of res scale
		
		ResScaleX= HUD.Canvas.SizeX / 1920.0;
	
		ResScaleY= HUD.Canvas.SizeY / 1080.0;
		
		UpdateStateFlag=true;
		
		foreach RenxHud.PlayerOwner.AllActors(class'Rx_ORI', ORI)
		{
		myORI = ORI ;
		
		break;
		
		}
		
	}
	
if(Cycler_MiscFunctions >= CycleRate/2) 
	{
	
	
/**********************************************************************************************
When updating, check if our objectives match the objectives of our Objective Replication Info
************************************************************************************************/

if(MyTeam == "GDI")
	{
	for(i=0;i<3;i++)
		{
		if(Objective[i].OText != myORI.Objective_GDI[i].OText) 
			{
		Update_Objective(i, myORI.Objective_GDI[i].O_Type, myORI.Objective_GDI[i].OText);
			}
		}


	}

	if(MyTeam == "Nod")
	{
	for(i=0;i<3;i++)
		{
		if(Objective[i].OText != myORI.Objective_NOD[i].OText) 
			{
		Update_Objective(i, myORI.Objective_NOD[i].O_Type, myORI.Objective_NOD[i].OText);
		
			}
		}


	}
	
	//In case of updated resolution
	ResScaleX= HUD.Canvas.SizeX / 1920.0;
	
	ResScaleY= HUD.Canvas.SizeY / 1080.0;
	Cycler_MiscFunctions=0;
	
	}
	
	
	

	
	
	// get out of 0,0 after updating once.
	
	if (OBox_X == 0) {
		Obox_X = RenxHud.Canvas.SizeX*0.65;  //Puts it in between the bottom HUD info and the weapon info box
		OBox_WantedX=RenxHud.Canvas.SizeX*0.65;  //Puts it in between the bottom HUD info and the weapon info box
					}
	if(OBox_Y == 0) {
		OBox_Y=RenxHud.Canvas.SizeY-(OBox_WantedHeight*ResScaleY); //Places it at the bottom of the screen, then up by how tall the box is. 
		OBox_WantedY=RenxHud.Canvas.SizeY-(OBox_WantedHeight*ResScaleY); //Places it at the bottom of the screen, then up by how tall the box is.
	}
	
	//alpha patrol
	if (Obox_Alpha > 255) OBox_Alpha=255 ;
	if (Obox_Alpha < 0) OBox_Alpha=0 ;

	if(OBox_TitleBackdropAlpha > 255) OBox_TitleBackdropAlpha=255 ;
	if(OBox_TitleBackdropAlpha < 0) OBox_TitleBackdropAlpha=0 ;
	
	if(Objectives_Alpha > 255) Objectives_Alpha = 255 ;
	if(Objectives_Alpha < 0) Objectives_Alpha = 0 ;
	
//Transition block//

if(OBox_ScaleX < OBox_WantedScaleX) OBox_ScaleX+=Scale_Increment ; 
if(OBox_ScaleX > OBox_WantedScaleX) OBox_ScaleX-=Scale_Increment ; 
if(abs(Obox_WantedScaleX-OBox_ScaleX) < Scale_Increment) OBox_ScaleX=Obox_WantedScaleX ; 


if(OBox_ScaleY < OBox_WantedScaleY) OBox_ScaleY+=Scale_Increment ; 
if(OBox_ScaleY > OBox_WantedScaleY) OBox_ScaleY-=Scale_Increment ; 
if(abs(Obox_WantedScaleY-OBox_ScaleY) < Scale_Increment) OBox_ScaleY=Obox_WantedScaleY ; 


if(OBox_Height < OBox_WantedHeight) OBox_Height+=Scale_Increment ; 
if(OBox_Height > OBox_WantedHeight) OBox_Height-=Scale_Increment ; 
if(abs(Obox_WantedHeight-OBox_Height) < Scale_Increment) OBox_Height=Obox_WantedHeight ; 


if(OBox_Width < OBox_WantedWidth) OBox_Width+=Scale_Increment ; 
if(OBox_Width > OBox_WantedWidth) OBox_Width-=Scale_Increment ; 
if(abs(Obox_WantedWidth-OBox_Width) < Scale_Increment) OBox_Width=Obox_WantedWidth ; 	

if(OBox_X < OBox_WantedX) OBox_X+=Pos_Increment ; 
if(OBox_X > OBox_WantedX) OBox_X-=Pos_Increment ; 
if(abs(Obox_WantedX-OBox_X) < Pos_Increment) OBox_X=Obox_WantedX ; 


if(OBox_Y < OBox_WantedY) OBox_Y+=Pos_Increment ; 
if(OBox_Y > OBox_WantedY) OBox_Y-=Pos_Increment ; 
if(abs(Obox_WantedY-OBox_Y) < Pos_Increment) OBox_Y=Obox_WantedY ; 

if(OBox_Alpha < OBox_WantedAlpha) OBox_Alpha+=Alpha_Increment ; 
if(OBox_Alpha > OBox_WantedAlpha) OBox_Alpha-=Alpha_Increment ; 
if(abs(Obox_WantedAlpha-OBox_Alpha) < Alpha_Increment) OBox_Alpha=Obox_WantedAlpha ; 

if(Objectives_Alpha < Objectives_WantedAlpha) Objectives_Alpha+=Alpha_Increment ; 
if(Objectives_Alpha > Objectives_WantedAlpha) Objectives_Alpha-=Alpha_Increment ; 
if(abs(Objectives_WantedAlpha-Objectives_Alpha) < Alpha_Increment) Objectives_Alpha=Objectives_WantedAlpha ; 


if(OText_Scale < OText_WantedScale) OText_Scale+=OText_Scale_Increment ; 
if(OText_Scale > OText_WantedScale) OText_Scale-=OText_Scale_Increment ; 
if(abs(OText_WantedScale-OText_Scale) < OText_Scale_Increment) OText_Scale=OText_WantedScale ; 
//End Transition animation Block//

if (OBox_ScaleX < 0.0 ) Obox_ScaleX = OBox_WantedScaleX ;
if (OBox_ScaleY < 0.0 ) Obox_ScaleY = OBox_WantedScaleY ;





//Don't waste CPU on finding these bastards if they aren't even being drawn
	if(OBoxState == 1)
	{
		if(Cycler_PawnType >= CycleRate*5)
		{			
		UpdateInfantryNumbers(); //This is a pretty expensive function as there's more than likely going to be A LOT of pawns in comparison to vehicles
		Cycler_PawnType=0; 
		}
		
		if(Cycler_VehicleType >= CycleRate*4) 
		{
		UpdateVehicleNumbers(); //This is the least expensive, as there aren't usually too many vehicles, and it only is looking for vehicle and type.
		Cycler_VehicleType=0; 
		}
		
		if(Cycler_PawnLocation >=CycleRate*12) 
		{
		UpdateInfantryLocationNum(); //This is ridiculously time consuming and should only be done once per second or 2 to prevent the CPU eating up time every tick doing this.
		Cycler_PawnLocation=0;
		}
	}
	
	if(Cycler_PawnLocation < CycleRate*13) Cycler_PawnLocation++;
	if(Cycler_VehicleType < CycleRate*5) Cycler_VehicleType++;
	if(Cycler_PawnType < CycleRate*6)Cycler_PawnType++;
	if(Cycler_MiscFunctions < CycleRate*3) Cycler_MiscFunctions++;
}	

function UpdateVehicleNumbers()
{
local Rx_Vehicle TempV;
local int TempVN_Humvee,TempVN_GAPC,TempVN_MRLS,TempVN_MediumTank,TempVN_MammothTank,TempVN_Orca, TempVN_GTranny;
local int TempVN_Buggy,TempVN_NAPC,TempVN_Artillery,TempVN_LightTank,TempVN_FlameTank,TempVN_StealthTank, TempVN_Apache,TempVN_NTranny;
local Rx_MapInfo TempMI;

TempMI=Rx_MapInfo(RenxHud.PlayerOwner.WorldInfo.GetMapInfo());

LogInternal("UpdatedVehicles");
//GDI updates
if(MyTeam == "GDI")
	{	


	//Update GDI numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Vehicle', TempV)
		{
		//Check that the Vehicle is on the right team. or neutral
		if(TempV.IsA('Rx_Vehicle_Humvee') && TempV.GetTeamNum()!=1) TempVN_Humvee+=1;
		if(TempV.IsA('Rx_Vehicle_APC_GDI') && TempV.GetTeamNum()!=1) TempVN_GAPC+=1;
		if(TempV.IsA('Rx_Vehicle_MRLS') && TempV.GetTeamNum()!=1) TempVN_MRLS+=1;
		if(TempV.IsA('Rx_Vehicle_MediumTank') && TempV.GetTeamNum()!=1) TempVN_MediumTank+=1;
		if(TempV.IsA('Rx_Vehicle_MammothTank') && TempV.GetTeamNum()!=1) TempVN_MammothTank+=1;
		
		if(TempMI.bAirCraftDisabled) continue;
		if(TempV.IsA('Rx_Vehicle_Orca') && TempV.GetTeamNum()!=1) TempVN_Orca+=1;
		if(TempV.IsA('Rx_Vehicle_Chinook_GDI') && TempV.GetTeamNum()!=1) TempVN_GTranny+=1;
		}

	
	VN_Humvee=TempVN_Humvee;
	VN_GAPC=TempVN_GAPC;
	VN_MRLS=TempVN_MRLS;
	VN_MediumTank=TempVN_MediumTank;
	VN_MammothTank=TempVN_MammothTank;
	VN_Orca=TempVN_Orca;
	VN_GTranny=TempVN_GTranny;
	//End GDI Update
	
	}
	
	if(MyTeam == "Nod")
	{	


	//Nod Vehicle Numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Vehicle', TempV)
		{
		//Check that the Vehicle is on the right team or neutral
		if(TempV.IsA('Rx_Vehicle_Buggy') && TempV.GetTeamNum()!=0) TempVN_Buggy+=1;
		if(TempV.IsA('Rx_Vehicle_APC_NOD') && TempV.GetTeamNum()!=0) TempVN_NAPC+=1;
		if(TempV.IsA('Rx_Vehicle_Artillery') && TempV.GetTeamNum()!=0) TempVN_Artillery+=1;
		if(TempV.IsA('Rx_Vehicle_LightTank') && TempV.GetTeamNum()!=0) TempVN_LightTank+=1;
		if(TempV.IsA('Rx_Vehicle_FlameTank') && TempV.GetTeamNum()!=0) TempVN_FlameTank+=1;
		if(TempV.IsA('Rx_Vehicle_StealthTank') && TempV.GetTeamNum()!=0) TempVN_StealthTank+=1;
		
		if(TempMI.bAirCraftDisabled) continue;
		if(TempV.IsA('Rx_Vehicle_Apache') && TempV.GetTeamNum()!=0) TempVN_Apache+=1;
		if(TempV.IsA('Rx_Vehicle_Chinook_Nod') && TempV.GetTeamNum()!=1) TempVN_NTranny+=1;
		}
		
	VN_Buggy=TempVN_Buggy;
	VN_NAPC=TempVN_NAPC;
	VN_Artillery=TempVN_Artillery;
	VN_LightTank=TempVN_LightTank;
	VN_FlameTank=TempVN_FlameTank;
	VN_StealthTank=TempVN_StealthTank;
	VN_Apache=TempVN_Apache;
	VN_NTranny=TempVN_NTranny;
	//End Nod Update
	
	}
	
	
	
}




function UpdateInfantryNumbers()
{
local Rx_Pawn TempP;
local int TempIN_Hotwires, TempIN_GSnipers, TempIN_GAT, TempIN_GIB, TempIN_GIEB;
local int TempIN_Technicians,TempIN_SBH,TempIN_NAT,TempIN_NIB, TempIN_NIEB, TempIN_NSnipers;

LogInternal("Updated Infantry Numbers");
//GDI updates
if(MyTeam == "GDI")
	{	


	//Update GDI numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Pawn', TempP)
		{
		//Check that the pawn is on the right team and is one of our tracked classes
		if(TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Hotwire' && TempP.GetTeamNum()==0) TempIN_Hotwires+=1;
		if((TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Havoc' || TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Deadeye' ) && TempP.GetTeamNum()==0) TempIN_GSnipers+=1;
		
		//GDI AT infantry : Grenadier, Rocket Soldier, Patch, Gunner, PIC, Mobius
		if((TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Sydney' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Patch' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Gunner' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_RocketSoldier' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Mobius' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Grenadier'
		)
		&& TempP.GetTeamNum()==0) TempIN_GAT+=1;
		
		//Check for GDI players in their own base 
		if(PawninBase(TempP.location, 0) && TempP.GetTeamNum()==0) TempIN_GIB++; 
		
		//GDI Players in Nod Base
		if(PawninBase(TempP.location, 1) && TempP.GetTeamNum()==0) TempIN_GIEB++; 
		
		}	

	
	IN_Hotwires=TempIN_Hotwires;
	IN_GSnipers=TempIN_GSnipers;
	IN_GAT=TempIN_GAT;
	IN_GIB=TempIN_GIB;
	IN_GIEB=TempIN_GIEB;
	
	//End GDI Update
	
	}
	
	if(MyTeam == "Nod")
	{	

//Update Nod numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Pawn', TempP)
		{
		//Check that the pawn is on the right team and is one of our tracked classes
		if(TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_StealthBlackHand' && TempP.GetTeamNum()==1) TempIN_SBH+=1;
		if(TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Technician' && TempP.GetTeamNum()==1) TempIN_Technicians+=1;
		if((TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Sakura' || TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_BlackHandSniper' ) && TempP.GetTeamNum()==1) TempIN_NSnipers+=1;
		
		//Nod AT Infantry: Chem-Trooper, Flame-Trooper, LCG, Raveshaw, Mendoza
		if((TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Raveshaw' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_LaserChainGunner' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_RocketSoldier' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_FlameTrooper' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Mendoza' ||
		TempP.GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_ChemicalTrooper'
		)
		&& TempP.GetTeamNum()==1) TempIN_NAT+=1;
		
		//Check for Nod players in their own base 
		if(PawninBase(TempP.location, 1) && TempP.GetTeamNum()==1) TempIN_NIB++; 
		
		//Nod Players in GDI Base
		if(PawninBase(TempP.location, 0) && TempP.GetTeamNum()==1) TempIN_NIEB++; 
		
		}	

	IN_SBH=TempIN_SBH;
	IN_Technicians=TempIN_Technicians;
	IN_NSnipers=TempIN_NSnipers;
	IN_NAT=TempIN_NAT;
	IN_NIB=TempIN_NIB;
	IN_NIEB=TempIN_NIEB;
	

	
	}
	
	
	
}

function UpdateInfantryLocationNum()
{
local Rx_Pawn TempP;
local int TempIN_GIB, TempIN_GIEB;
local int TempIN_NAT,TempIN_NIB, TempIN_NIEB;

LogInternal("Updated Infantry Locations");
//GDI updates
if(MyTeam == "GDI")
	{	


	//Update GDI numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Pawn', TempP)
		{
		
		//Check for GDI players in their own base 
		if(PawninBase(TempP.location, 0) && TempP.GetTeamNum()==0) TempIN_GIB++; 
		
		//GDI Players in Nod Base
		if(PawninBase(TempP.location, 1) && TempP.GetTeamNum()==0) TempIN_GIEB++; 
		
		}	
	IN_GIB=TempIN_GIB;
	IN_GIEB=TempIN_GIEB;
	
	//End GDI Update
	
	}
	
	if(MyTeam == "Nod")
	{	

//Update Nod numbers
	foreach RenxHud.PlayerOwner.AllActors(class'Rx_Pawn', TempP)
		{
		
		//Check for Nod players in their own base 
		if(PawninBase(TempP.location, 1) && TempP.GetTeamNum()==1) TempIN_NIB++; 
		
		//Nod Players in GDI Base
		if(PawninBase(TempP.location, 0) && TempP.GetTeamNum()==1) TempIN_NIEB++; 
		
		}	
	IN_NIB=TempIN_NIB;
	IN_NIEB=TempIN_NIEB;
	

	
	}
	
	
	
}



function Update_Objective(int rank, int CT, string S) 
{
	local string C_String;
	//Determining what team to use is handled at the Rx_CommanderController level.	
	switch (CT) 
	{
		case 0: //CT_ATTACK:
		Objective[rank].OColor=Obox_AttackColor 			;
		Objective[rank].OFont=Obox_AttackFont 				;
		Objective[rank].OIcon = AttackIcon 					;
		break									;
		
		case 1: //CT_DEFEND:
		Objective[rank].OColor=Obox_DefendColor 			;
		Objective[rank].OFont= Obox_DefendFont 				;
		Objective[rank].OIcon = DefendIcon 					;
		break									;
		
		case 2: //CT_REPAIR:
		Objective[rank].OColor=Obox_RepairColor 			;
		Objective[rank].OFont=Obox_RepairFont				;
		Objective[rank].OIcon = RepairIcon 					;
		break									;
		
		case 3: //CT_TAKEPOINT:
		Objective[rank].OColor=Obox_TakePointColor 			;
		Objective[rank].OFont=Obox_TakePointFont			;
		Objective[rank].OIcon = TakePointIcon 				;
		break									;
		
	}
	
	switch (rank)
	{
		case 0: 
		C_String="Primary" ;
		break;
		
		case 1: 
		C_String="Secondary" ;
		break;
		
		case 2: 
		C_String="Support" ;
		break;
	}
	
	
Objective[rank].OText = S ;
Rx_HUD_Ext(RenxHud).CommandText.SetFlashText(MyTeam, 70, C_String@"Objective Updated",ColorRed,180, 255, false)	; //Only sends the text once
Rx_HUD_Ext(RenxHud).CommandText.SetFlashText(MyTeam, 70, S,ColorGreen,180, 255, true,1)	; //Only sends the text once
RenxHud.PlayerOwner.ClientPlaySound(UpdateSound) ;		
}


function bool DrawObjectiveBox 
(
Rx_HUD HUD,
string Team
)
{
	
local float X, Y;
local CanvasIcon Logo ; //Texture Logo ;

//Set the upper left position of the box
X=OBox_X;
Y=OBox_Y;

//`log("101010100100101101101011Controller Canvas is " $ HUD.Canvas) ;

//`log("----------------------- Canvas SizeX is " $ HUD.Canvas.SizeX $ "Setting ResScaleX to" $ ResScaleX $"%" $ "Percentage is" $ (HUD.Canvas.SizeX / 1920)) ;
//`log("----------------------- Canvas SizeY is " $ HUD.Canvas.SizeY $ "Setting ResScaleY to" $ ResScaleY $"%") ;
//`log("101010100100101101101011Controller Hud is " $ HUD ) ;


HUD.Canvas.SetPOS(X,Y) ; //Get just over the box to draw the logo

switch (Team)
	{
	case "GDI":
	HUD.Canvas.SetDrawColor(255,251,89,OBox_Alpha);
	Logo=GDI_Logo ;//Texture2D'RenxHud.Images.T_Logo_GDI' ;
	break;
	
	case "Nod":
	HUD.Canvas.SetDrawColor(255,0,0,OBox_Alpha) ;
	Logo=Nod_Logo ;//Texture2D'RenxHud.Images.T_Logo_Nod' ;
	break;
	}
	
// Draw backdrop
//`log("Drawing Backdrop") ;
HUD.Canvas.DrawRect((OBox_Width*ResScaleX),(OBox_Height*ResScaleY),OBox_Backdrop) ;
//Reset Position to on top of the rectangle, then draw the Logo.
//`log("Drawing Logo") ;
HUD.Canvas.SetPOS(X,Y) ;
//HUD.Canvas.DrawTile(Logo, 32*ResScaleX, 32*ResScaleY, 0,0,32, 32) ; 

//Draw Logo in the box
HUD.Canvas.DrawIcon(Logo,X,Y+((2*Obox_ScaleY)*ResScaleY),0.03125*OBox_WantedScaleY*ResScaleY) ;//DrawIcon(Logo, 32*ResScaleX, 32*ResScaleY, 0,0,32, 32) ; 
return true;
	
}



//Only to be called in the Draw() function.
simulated function DrawTitle(string TITLE, Rx_HUD HUD) 
{

local float X,Y			 ;
local float RectX,RectY ;
local color OldColor;


Canvas.Font=Obox_TitleFont ;
Canvas.StrLen(TITLE, RectX,RectY) ;

RectX*=Obox_ScaleX ;	
RectY*=Obox_ScaleY ;	
OldColor=Canvas.DrawColor ;


X=OBox_X+(OBox_Width*ResScaleX/4)	;
Y=OBox_Y+((2*Obox_ScaleY)*ResScaleY);

/**
//--------Draw a glowing backdrop for the text.-------------
	Canvas.SetPOS(X-(2*Obox_ScaleX*ResScaleX),Y)	;
	 					
	switch (MyTeam) 
	{
		case "GDI" :
			Canvas.SetDrawColor(255,255,125,OBox_TitleBackdropAlpha)		;
			break;
			
		case "Nod" :
			Canvas.SetDrawColor(255,125,125,OBox_TitleBackdropAlpha)			;
			break;
	}
	
Canvas.DrawRect((RectX+(60*Obox_ScaleX))*ResScaleX,RectY,Glow_Backdrop)		;
*/

//Canvas.DrawColor=Obox_TitleColor ;


Canvas.SetPOS(X,Y) 									;
Canvas.DrawColor=OldColor							;

Canvas.DrawText(TITLE, true,1.0*Obox_ScaleX*ResScaleX, 1.0*Obox_ScaleY*ResScaleY) ;	
	
}



simulated function DrawCommanders(Rx_HUD HUD ,string Team)
{

//Actual X,Y location of the canvas
local float X,Y;

//X and Y values used to place the strings.

//Length X Y of the string
local float  XL;  //XL1,XL2,XL3 ;
local float  YL;  //YL1,YL2,YL3 ;
//local int 	 Linespace ; 
local float TextScale;
local int R ;
local string PrimaryName,SecondaryName,SupportName;



//LineSpace=2*OText_Scale						;

if(MyTeam == "GDI")
{
if (Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[0].CPRI != none) PrimaryName= Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[0].Cname;
if (Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[1].CPRI != none) SecondaryName= Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[1].Cname;
if (Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[2].CPRI != none) SupportName= Rx_HUD_Ext(RenxHud).myCC.GDI_Commander[2].Cname;
}

if(MyTeam == "Nod")
{
if (Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[0].CPRI != none) PrimaryName= Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[0].Cname;
if (Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[1].CPRI != none) SecondaryName= Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[1].Cname;
if (Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[2].CPRI != none) SupportName= Rx_HUD_Ext(RenxHud).myCC.NOD_Commander[2].Cname;
}

X=OBox_X+((4*Obox_ScaleX)*ResScaleX);									;
//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
Y=OBox_Y+((32*Obox_ScaleY)*ResScaleY);

Canvas.SetPos(X,Y) 							;



TextScale=1*OText_Scale					;
//Commander's Objective cycles through all objectives (3 is the number used, as there should be no more than 3 objectives. Should probably be 2, but meh.)


	
	//Adjust string length for the scaling done to text
	
	Canvas.DrawColor=Obox_TakePointColor								;
	Canvas.Font=Font'RenXHud.Font.ScoreBoard_Small'				;
	//Get the length of the full string
	Canvas.StrLen("Commanders:" @ PrimaryName$","@SecondaryName$","@SupportName, XL,YL)				;
	XL*=TextScale  ;
	YL*=TextScale ; 
	//Some icons need to be scaled on a case-by-case basis, since I just found things that looked good, and not all of them were a perfect square and perfect size. Only 3/4 aren't 32x32.
	
	Canvas.DrawColor.A = Objectives_Alpha;
	
	Canvas.SetPos(X,Y)				;

	Canvas.DrawText("Commanders:" @ PrimaryName$","@SecondaryName$","@SupportName, true,(TextScale*ResScaleX), (TextScale*ResScaleY)) ;
	
	}			
	

	

///////////////////////////////////////////////////////////////////////////////
////////////Draws the current composition of vehicles and certain infantry////
//////////////////////////////////////////////////////////////////////////////

simulated function DrawUComp(Rx_HUD HUD ,string Team)
{

//Actual X,Y location of the canvas
local float X,Y;

//X and Y values used to place the strings.

//Length X Y of the string
local float  XL;  //XL1,XL2,XL3 ;
local float  YL;  //YL1,YL2,YL3 ;
//local int 	 Linespace ; 
local float IconScale;
local float TextScale;
local CanvasIcon TempIcon;
local int R, TempNum,TempWNum;
local string TempString		;

local Rx_MapInfo TempMI;

TempMI=Rx_MapInfo(RenxHud.PlayerOwner.WorldInfo.GetMapInfo());

//LineSpace=2*OText_Scale						;



X=OBox_X+((UC_VcompIndent*Obox_ScaleX)*ResScaleX);									;
//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
Y=OBox_Y+((UC_YOffset*Obox_ScaleY)*ResScaleY);


Canvas.SetPos(X,Y) 							;



TextScale=1.0*OText_Scale					;
//Commander's Objective cycles through all objectives (3 is the number used, as there should be no more than 3 objectives. Should probably be 2, but meh.)

if(MyTeam == "GDI") 
{
	
for(R=0;R < 7; R++) //Draw Vehicles
	{
if(R > 4 && TempMI.bAirCraftDisabled) break; //If we're on a non-flying map, don't bother drawing aircraft. 
	
	HUD.Canvas.SetDrawColor(255,251,16,255) 								;
	Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small'						;
	X=OBox_X+((UC_VcompIndent*Obox_ScaleX)*ResScaleX);									
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
	Y=OBox_Y+((UC_YOffset*Obox_ScaleY)*ResScaleY);

	X+=(UC_XIconIndent*R*ResScaleX);
	
Canvas.SetPos(X,Y) 							;
	
	
	//Get the length of the full string
	
	//Some icons need to be scaled on a case-by-case basis, since I just found things that looked good, and not all of them were a perfect square and perfect size. Only 3/4 aren't 32x32.
	
	IconScale = UC_IconScale ; // 128/4 32x32
	
	Canvas.DrawColor.A = Objectives_Alpha;
	
	
	switch(R)
	{
		case 0:
		TempIcon=VIcon_Humvee 	;
		TempNum=VN_Humvee		;
		TempWNum=WVN_Humvee		;
		break;
		
		case 1:
		TempIcon=VIcon_GDIAPC 	;
		TempNum=VN_GAPC			;
		TempWNum=WVN_GAPC		;
		break;
		
		case 2:
		TempIcon=VIcon_MRLS  	;
		TempNum=VN_MRLS			;
		TempWNum=WVN_MRLS		;
		break;
		
		case 3:
		TempIcon=VIcon_MedTank 	;
		TempNum=VN_MediumTank	;
		TempWNum=WVN_MediumTank	;
		break;
		
		case 4:
		TempIcon=VIcon_Mammoth 	;
		TempNum=VN_MammothTank		;
		TempWNum=WVN_MammothTank	;
		break;
		
		case 5:
		TempIcon=VIcon_Orca 	;
		TempNum=VN_Orca		;
		TempWNum=WVN_Orca	;
		break;
		
		case 6:
		TempIcon=VIcon_Tranny 	;
		TempNum=VN_GTranny		;
		TempWNum=WVN_GTranny	;
		break;
	}
	
	
	
//Draw the icons on the top row
	Canvas.DrawIcon(TempIcon,X-((TempIcon.UL/2)*IconScale*ResScaleX),Y-((TempIcon.VL/2)*IconScale*ResScaleY),IconScale*ResScaleX) 	;
	
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)

	//X+=(UC_XIconIndent*R*ResScaleX); 							;
	
	
	Y+=(((TempIcon.VL*IconScale)/2+8)*ResScaleY) ;	//Push the canvas draw position down below the icon
	
	Canvas.StrLen(TempNum $"/"$TempWNum, XL,YL)								;
	XL*=TextScale*ResScaleX															;
	YL*=TextScale*ResScaleY 															; 	
	
	X-=XL/2 																;	
	//	Canvas.SetPos(X-((TempIcon.UL/TestX*IconScale)-XL/2)*ResScaleX,Y)							; //Why 8 is the magic number there... I don't know.
		
		Canvas.SetPos(X,Y)							; //Why 8 is the magic number there... I don't know.
	Canvas.DrawColor.A = 240;
	Canvas.DrawText(TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY)) ;
	}			
	
	//////////////////Draw Infantry///////////////////////
	
	HUD.Canvas.SetDrawColor(255,255,255,255);								;
	Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small'						;
	
	
	
	//Commence drawing GDI column one
	
	for(R=0;R<3;R++)
	{
	
	switch(R)
	{
		case 0 :
		TempString="Snipers:";
		TempNum = IN_GSnipers;
		TempWNum = WIN_GSnipers;
		break; 
		
		case 1 :
		TempString=	"Hotwires:";
		TempNum = IN_Hotwires;
		TempWNum = WIN_Hotwires;
		break; 
		
		case 2 :
		TempString=	"Anti-Tank Infantry:";
		TempNum = IN_GAT;
		TempWNum = WIN_GAT;
		break; 
	}
	//
	
	X=OBox_X+((IUC_XOffset*Obox_ScaleX)*ResScaleX)							;			//						
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
	Y=OBox_Y+((IUC_YOffset*Obox_ScaleY)*ResScaleY);
	
	Canvas.StrLen(TempString, XL,YL)								;
	
	XL*=TextScale*ResScaleX	;
	YL*=TextScale*ResScaleY ;
	
	X-=XL 					;
	
	HUD.Canvas.SetPos(X,Y+(IUC_YIndent*R*ResScaleY)); //Indent us by about 130 to make up for the length of our strings.
	HUD.Canvas.DrawText(TempString@TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY));
	
	/////////////////////////////////////////
	/////////////Draw Column 2////////////// 
	////////////////////////////////////////
	
	X+=XL+(IUC_XIndent*OBox_ScaleX*ResScaleX); //Indent us
	
	switch(R)
	{
		case 0 :
		TempString="In Base:";
		TempNum = IN_GIB;
		TempWNum = WIN_GIB;
		break; 
		
		case 1 :
		TempString=	"In Enemy Base:";
		TempNum = IN_GIEB;
		TempWNum = WIN_GIEB;
		break; 
		
		default :
		TempString=	"";
		TempNum = 0;
		TempWNum = 0;
		break; 
	}
	
	
	Canvas.StrLen(TempString, XL,YL)								;
	
	XL*=TextScale*ResScaleX	;
	YL*=TextScale*ResScaleY ;
	
	X-=XL 	;
	
	HUD.Canvas.SetPos(X,Y+(IUC_YIndent*R*ResScaleY)); //Indent us by about 130 to make up for the length of our strings.
	
	if(TempString != "") HUD.Canvas.DrawText(TempString@TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY));

	}
	
	
	
	
	
}


if(MyTeam == "Nod") 
{
	
for(R=0;R < 8; R++)
	{
if(R > 5 && TempMI.bAirCraftDisabled) break; //If we're on a non-flying map, don't bother drawing aircraft. 
	
	HUD.Canvas.SetDrawColor(255,100,100,255) 								;
	Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small'						;
	X=OBox_X+((UC_VcompIndent*Obox_ScaleX)*ResScaleX);									
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
	Y=OBox_Y+((UC_YOffset*Obox_ScaleY)*ResScaleY);

	X+=(UC_XIconIndent*R*ResScaleX);
	
Canvas.SetPos(X,Y) 							;
	
	
	//Get the length of the full string
	
	//Some icons need to be scaled on a case-by-case basis, since I just found things that looked good, and not all of them were a perfect square and perfect size. Only 3/4 aren't 32x32.
	
	IconScale = UC_IconScale ; // 128/4 32x32
	
	Canvas.DrawColor.A = Objectives_Alpha;
	
	switch(R)
	{
		case 0:
		TempIcon=VIcon_Buggy 	;
		TempNum=VN_Buggy		;
		TempWNum=WVN_Buggy		;
		break;
		
		case 1:
		TempIcon=VIcon_NODAPC 	;
		TempNum=VN_NAPC			;
		TempWNum=WVN_NAPC		;
		break;
		
		case 2:
		TempIcon=VIcon_Artillery  	;
		TempNum=VN_Artillery			;
		TempWNum=WVN_Artillery		;
		break;
		
		case 3:
		TempIcon=VIcon_LightTank 	;
		TempNum=VN_LightTank	;
		TempWNum=WVN_LightTank	;
		break;
		
		case 4:
		TempIcon=VIcon_FlameTank 	;
		TempNum=VN_FlameTank		;
		TempWNum=WVN_FlameTank	;
		break;
		
		case 5:
		TempIcon=VIcon_StealthTank 	;
		TempNum=VN_StealthTank		;
		TempWNum=WVN_StealthTank	;
		break;
		
		case 6:
		TempIcon=VIcon_Apache 	;
		TempNum=VN_Apache		;
		TempWNum=WVN_Apache		;
		break;
		
		case 7:
		TempIcon=VIcon_Tranny 	;
		TempNum=VN_NTranny		;
		TempWNum=WVN_NTranny	;
		break;
	}
	
	
	
	//Draw the icons on the top row
	Canvas.DrawIcon(TempIcon,X-((TempIcon.UL/2)*IconScale*ResScaleX),Y-((TempIcon.VL/2)*IconScale*ResScaleY),IconScale*ResScaleX) 	;
	
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)

	//X+=(UC_XIconIndent*R*ResScaleX); 							;
	
	
	Y+=(((TempIcon.VL*IconScale)/2+8)*ResScaleY) ;	//Push the canvas draw position down below the icon
	
	Canvas.StrLen(TempNum $"/"$TempWNum, XL,YL)								;
	XL*=TextScale*ResScaleX															;
	YL*=TextScale*ResScaleY 															; 	
	
	X-=XL/2 																;	
	//	Canvas.SetPos(X-((TempIcon.UL/TestX*IconScale)-XL/2)*ResScaleX,Y)							; //Why 8 is the magic number there... I don't know.
		
		Canvas.SetPos(X,Y)							; //Why 8 is the magic number there... I don't know.
	Canvas.DrawColor.A = 240;
	Canvas.DrawText(TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY)) ;
	
	}			
	
	//////////////////Draw Infantry///////////////////////
	
	HUD.Canvas.SetDrawColor(255,255,255,255);								;
	Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small'						;
	
	
	
	//Commence drawing Nod column one
	
	for(R=0;R<=3;R++)
	{
	
	switch(R)
	{
		case 0 :
		TempString="Snipers:";
		TempNum = IN_NSnipers;
		TempWNum = WIN_NSnipers;
		break; 
		
		case 1 :
		TempString=	"Technicians:";
		TempNum = IN_Technicians;
		TempWNum = WIN_Technicians;
		break; 
		
		case 2 :
		TempString=	"Anti-Tank Infantry:";
		TempNum = IN_NAT;
		TempWNum = WIN_NAT;
		break; 
		
		case 3 :
		TempString=	"SBH:";
		TempNum = IN_SBH;
		TempWNum = WIN_SBH;
		break; 
	}
	//
	
	X=OBox_X+(((IUC_XOffset+15)*Obox_ScaleX)*ResScaleX)							;			//Add 10 because Nod has 1 extra vehicle. 						
	//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
	Y=OBox_Y+((IUC_YOffset*Obox_ScaleY)*ResScaleY);
	
	Canvas.StrLen(TempString, XL,YL)								;
	
	XL*=TextScale*ResScaleX	;
	YL*=TextScale*ResScaleY ;
	
	X-=XL 					;
	
	HUD.Canvas.SetPos(X,Y+(IUC_YIndent*R*ResScaleY)); //Indent us by about 130 to make up for the length of our strings.
	HUD.Canvas.DrawText(TempString@TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY));
	
	/////////////////////////////////////////
	/////////////Draw Column 2////////////// 
	////////////////////////////////////////
	
	X+=XL+(IUC_XIndent*OBox_ScaleX*ResScaleX); //Indent us
	
	switch(R)
	{
		case 0 :
		TempString="In Base:";
		TempNum = IN_NIB;
		TempWNum = WIN_NIB;
		break; 
		
		case 1 :
		TempString=	"In Enemy Base:";
		TempNum = IN_NIEB;
		TempWNum = WIN_NIEB;
		break; 
		
		default :
		TempString=	"";
		TempNum = 0;
		TempWNum = 0;
		break; 
	}
	
	
	Canvas.StrLen(TempString, XL,YL)								;
	
	XL*=TextScale*ResScaleX	;
	YL*=TextScale*ResScaleY ;
	
	X-=XL 	;
	
	HUD.Canvas.SetPos(X,Y+(IUC_YIndent*R*ResScaleY)); //Indent us by about 130 to make up for the length of our strings.
	
	if(TempString != "") HUD.Canvas.DrawText(TempString@TempNum $"/"$TempWNum, false,(TextScale*ResScaleX), (TextScale*ResScaleY));

	}
	
	
	
}




}
//////////////////////////////////////////
//////END DRAW CALL TO DRAW UNIT COMP/////
/////////////////////////////////////////



//Draws the primary, secondary, and support objectives if the commanders for them are voted
simulated function DrawObjectives(Rx_HUD HUD ,string Team)
{

//Actual X,Y location of the canvas
local float X,Y;

//X and Y values used to place the strings.

//Length X Y of the string
local float  XL;  //XL1,XL2,XL3 ;
local float  YL;  //YL1,YL2,YL3 ;
//local int 	 Linespace ; 
local float IconScale;
local float TextScale;
local Vector2D GlowRadius;
local FontRenderInfo FontInfo;


local int R ;


local string RankStr;

//LineSpace=2*OText_Scale						;



X=OBox_X+((4*Obox_ScaleX)*ResScaleX);									;
//Subtract (Go up) from the bottom of the Canvas by the height of the Objective box, then ADD(Go down) some to start drawing beneath the logo)
if(OBoxState==1)Y=OBox_Y+((48*Obox_ScaleY)*ResScaleY);
else
Y=OBox_Y+((32*Obox_ScaleY)*ResScaleY);

Canvas.SetPos(X,Y) 							;



TextScale=1.4*OText_Scale					;
//Commander's Objective cycles through all objectives (3 is the number used, as there should be no more than 3 objectives. Should probably be 2, but meh.)

for(R=0;R <= 2; R++)
	{
		//If the objective is empty, don't worry about it.
if(Objective[R].OText == "" || Objective[R].OText == "NULL" || Objective[R].OText == "No Objective Set")
	continue; //Continue through the iteration

		switch(R) 
		{
			case 0:
			RankStr ="Primary: " 	;
			break;
			
			case 1:
			RankStr ="Secondary: " 	;
			break;
			
			case 2:
			RankStr ="Support: " 	;
			break;
			
		}

	
	//Adjust string length for the scaling done to text
	
	Canvas.DrawColor=Objective[R].OColor 									;
	Canvas.Font=Objective[R].OFont 											;
	//Get the length of the full string
	Canvas.StrLen(RankStr$" "$Objective[R].Otext, XL,YL)					;
	XL*=TextScale  ;
	YL*=TextScale ; 
	//Some icons need to be scaled on a case-by-case basis, since I just found things that looked good, and not all of them were a perfect square and perfect size. Only 3/4 aren't 32x32.
	
	IconScale = 0.33 ; //normal for 32x32 to be cut to 16x16 or 24x24 for the sake of not being omgWTFHuge
	switch(Objective[R].OIcon) 
	{
		case RepairIcon : 
		IconScale = 0.25;
		Canvas.DrawColor=Obox_TakePointColor ; //white
		break;
		
		case TakePointIcon : 
		IconScale = 0.25;
		break;
		
		case DefendIcon : 
		IconScale = 0.50;
		break;
		
	}
	Canvas.DrawColor.A = Objectives_Alpha;
	Canvas.DrawIcon(Objective[R].OIcon,X,Y,IconScale*TextScale*ResScaleY) 	;
	
	//INCASE  we changed the Draw color for the particular icon
	Canvas.DrawColor=Objective[R].OColor 	;
	Canvas.DrawColor.A = Objectives_Alpha	;
	
	X+=(((Objective[R].OIcon.UL*IconScale*TextScale)+(4*TextScale))*ResScaleX) ;	//Drawing icons doesn't push the drawing position as far as I know, so push the X position to the side to draw our objective text to the right of the icon
	//Move the canvas draw position down by the height of the text + Linespacing
	
	Canvas.SetPos(X,Y)				;
	//Stripped from something else... just to see if it will actually work here.
	FontInfo = Canvas.CreateFontRenderInfo(true);
    FontInfo.bClipText = true;
    FontInfo.bEnableShadow = true;
    FontInfo.GlowInfo.GlowColor = MakeLinearColor(1.0, 0.0, 0.0, 1.0);
    GlowRadius.X=5.0;
    GlowRadius.Y=3.0;
    FontInfo.GlowInfo.bEnableGlow = true;
    FontInfo.GlowInfo.GlowOuterRadius = GlowRadius;	
	//End things that aren't mine at all... and don't seem to have any visible effect
	
	//Don't draw outside of the Obox
	
	//Canvas.ClipX=X+((Obox_Width-5)*ResScaleX); 
	
	
	if(XL <= ((Obox_Width-5)*ResScaleX) || OBoxState == 1)	Canvas.DrawText(RankStr$" "$Objective[R].Otext, true,(TextScale*ResScaleX), (TextScale*ResScaleY),FontInfo) ;
	else
	//String too fat, only draw up to 27 characters + "...", as we're probably using the small box. If not.... why is this string so damn long ?
	Canvas.DrawText(Left(RankStr$" "$Objective[R].Otext,27)$"..." , true,(TextScale*ResScaleX), (TextScale*ResScaleY),FontInfo) ;
	
	
	Y+=((Objective[R].OIcon.VL*IconScale*TextScale+2*Obox_ScaleY)*ResScaleY)				;	
	
	//reset X to make sure the next line isn't indented.
	X-=	(((Objective[R].OIcon.UL*IconScale*TextScale)+(4*TextScale))*ResScaleX) ;
	//Canvas.ClipX=Canvas.SizeX;
	}			
	
}

function Draw()
{

local int T;
	//Get mah team
	
	T=RenxHud.PlayerOwner.GetTeamNum() ;
	
	switch(T) 
	{
		case 0 : 
		MyTeam = "GDI";
		break;
		
		case 1 :
		MyTeam = "Nod" ;
		break;
	}

	if(UpdateStateFlag) {		
	OBoxChangeState() ;
	UpdateStateFlag=false;
	}
	
switch(OBoxState)
	{
	case 0 : //The box is normal here, so draw just the objective information and title, etc.
	DrawObjectiveBox (RenxHud,MyTeam) 			;
	DrawTitle("Objective Info", RenxHud)		;
	DrawObjectives(RenxHud, MyTeam)				;
	break;
	
	case 1 : //Maximized, so draw everything we can.
	DrawObjectiveBox (RenxHud,MyTeam) 			;
	DrawTitle("Mission Info", RenxHud)			;
	DrawObjectives(RenxHud, MyTeam)				;
	DrawCommanders(RenxHud, MyTeam)				;
	DrawUComp(RenxHud, MyTeam)					;
	
	
	break;
	
	case 2 : //Hidden, so just draw the box
	DrawObjectiveBox (RenxHud,MyTeam) 			;
	//DrawTitle("Objective Info", RenxHud)		;
	//DrawObjectives(RenxHud, MyTeam)				;
	break;
	}

}


simulated function OboxChangeState() {
	
switch (OBoxState) 
{
///////////////////////////////MAXIMIZED/////////////////////////////////
	case 0: 
		OBox_WantedScaleX=4	;
		OBox_WantedScaleY=4	;

		OBox_WantedHeight=default.OBox_Height*OBox_WantedScaleY		;
		OBox_WantedWidth=default.OBox_Width*OBox_WantedScaleX		;

		OBox_WantedX=RenxHud.Canvas.SizeX/4;  //Puts it in between the bottom HUD info and the weapon info box
		OBox_WantedY=(RenxHud.Canvas.SizeY-(OBox_WantedHeight*ResScaleY))/4; //Places it at the bottom of the screen, then up by how tall the box is.
	
//OBox_WantedTitleAlpha = 128				;
		Obox_WantedAlpha	  = 100				;

		OBox_WantedTitleBackdropAlpha =	70		;
		Objectives_WantedAlpha = 180			;
	
		OText_WantedScale = 2					;

		/**
		Obox_AttackFont		=	Font'RenxHud.Font.RadioCommand_Medium' ;
		Obox_DefendFont		=	Font'RenxHud.Font.RadioCommand_Medium'	;
		Obox_RepairFont		=	Font'RenxHud.Font.RadioCommand_Medium'	;
		Obox_TakePointFont	=	Font'RenxHud.Font.RadioCommand_Medium';
		*/
		Obox_TitleFont=	Font'UI_Fonts.Fonts.UI_Fonts_FoldOb18'			;
		
		OBoxState = 1							;
		
			
		break; 
		
///////////////////////// HIDDEN/////////////////////////////////////////
	case 1:  
		OBox_WantedScaleX=0.5									;
		OBox_WantedScaleY=0.5									;

		OBox_WantedHeight=default.OBox_Height*OBox_WantedScaleY		;
		OBox_WantedWidth=default.OBox_Width*OBox_WantedScaleX			;

		OBox_WantedX=RenxHud.Canvas.SizeX;  //Puts it at the bottom of the screen
		OBox_WantedY=RenxHud.Canvas.SizeY; //Bottom right of the screen

//OBox_WantedTitleAlpha = 128				;
		Obox_WantedAlpha	  = 0				;

		OBox_WantedTitleBackdropAlpha =	0		;
		Objectives_WantedAlpha = 0			;
	
		OText_WantedScale = 1					;

/**	Come back to this later
Obox_AttackFont		=	Font'RenXHud.Font.ScoreBoard_Small'  	;
Obox_DefendFont		=	Font'RenXHud.Font.ScoreBoard_Small'		;
Obox_RepairFont		=	Font'RenXHud.Font.ScoreBoard_Small'		;
Obox_TakePointFont	=	Font'RenXHud.Font.ScoreBoard_Small'		;
Obox_TitleFont=	Font'RenxHud.Font.RadioCommand_Medium'			;
*/
		OBoxState = 2							;
		break;
		
///////////////////////////////////////NORMAL////////////////////////////////////////////
	case 2: 
	
	OBox_WantedScaleX=1		;
	OBox_WantedScaleY=1		;

	OBox_WantedHeight=default.OBox_Height*OBox_WantedScaleY		;
	OBox_WantedWidth=default.OBox_Width*OBox_WantedScaleX			;

	OBox_WantedX=RenxHud.Canvas.SizeX*0.65;  //Puts it in between the bottom HUD info and the weapon info box
	OBox_WantedY=RenxHud.Canvas.SizeY-(OBox_WantedHeight*ResScaleY); //Places it at the bottom of the screen, then up by how tall the box is.

//OBox_WantedTitleAlpha = 128				;
	Obox_WantedAlpha	  = 60			;

	OBox_WantedTitleBackdropAlpha =	60		;
	Objectives_WantedAlpha = 255			;
	
	OText_WantedScale = 1					;
	
	OBoxState = 0							;
		break;
}

	RenxHud.PlayerOwner.ClientPlaySound(OboxTransitionSnd) ;


} 


function bool PawninBase (Vector PLoc, int TEAMI)
{
	local string LocationInfo;
	local RxIfc_SpotMarker SpotMarker;
	local Actor TempActor;
	local float NearestSpotDist;
	local RxIfc_SpotMarker NearestSpotMarker;
	local float DistToSpot;	
	
	if(Renxhud.PlayerOwner.Pawn != none)
	{
		
	foreach Renxhud.PlayerOwner.Pawn.AllActors(class'Actor',TempActor,class'RxIfc_SpotMarker') {
		SpotMarker = RxIfc_SpotMarker(TempActor);
		DistToSpot = VSize(TempActor.location - PLoc);
		if(NearestSpotDist == 0.0 || DistToSpot < NearestSpotDist) {
			
			if(SpotMarker.GetSpotName() == "Refinery" || SpotMarker.GetSpotName() == "Power Plant") continue; //Ignore refinery/PP since they aren't differentiated by GDI/Nod on spot markers
			
			NearestSpotDist = DistToSpot;	
			NearestSpotMarker = SpotMarker;
		}
	}
	
	LocationInfo = NearestSpotMarker.GetSpotName();	
	
	switch(TEAMI)
	{
	case 0: 
	if(Caps(LocationInfo)=="WEAPONS FACTORY" || Caps(LocationInfo) == "BARRACKS" || CAPS(LocationInfo) == "ADV. GUARD TOWER") return true;
	break;
	
	case 1: 
	if(Caps(LocationInfo)=="AIRSTRIP" || Caps(LocationInfo) == "HAND OF NOD" || Caps(LocationInfo) == "OBELISK OF LIGHT") return true;
	break;
	}
	}
	
	return false;
	
	
	
}


