class Rx_Mutator_AdminTool_HUD_TargetingBox extends Rx_HUD_TargetingBox;

var private Font LabelFont_PrivateReplace;
var private Font PercentageFont_PrivateReplace;
var private Font DescriptionFont_PrivateReplace;

var private float ScreenEdgePadding_PrivateReplace;
var private float ScreenBottomPadding_PrivateReplace;
var private float MaxTargetBoxSizePctX_PrivateReplace;
var private float MaxTargetBoxSizePctY_PrivateReplace;

var private CanvasIcon BoundingBoxFriendlyTopLeft_PrivateReplace;
var private CanvasIcon BoundingBoxFriendlyTopRight_PrivateReplace;
var private CanvasIcon BoundingBoxFriendlyBottomLeft_PrivateReplace;
var private CanvasIcon BoundingBoxFriendlyBottomRight_PrivateReplace;
var private CanvasIcon BoundingBoxEnemyTopLeft_PrivateReplace;
var private CanvasIcon BoundingBoxEnemyTopRight_PrivateReplace;
var private CanvasIcon BoundingBoxEnemyBottomLeft_PrivateReplace;
var private CanvasIcon BoundingBoxEnemyBottomRight_PrivateReplace;
var private CanvasIcon BoundingBoxNeutralTopLeft_PrivateReplace;
var private CanvasIcon BoundingBoxNeutralTopRight_PrivateReplace;
var private CanvasIcon BoundingBoxNeutralBottomLeft_PrivateReplace;
var private CanvasIcon BoundingBoxNeutralBottomRight_PrivateReplace;

var private CanvasIcon InfoBackdropFriendly_PrivateReplace;
var private CanvasIcon InfoBackdropEnemy_PrivateReplace;
var private CanvasIcon InfoBackdropNeutral_PrivateReplace;
var private CanvasIcon BA_InfoBackdropFriendly_PrivateReplace;
var private CanvasIcon BA_InfoBackdropEnemy_PrivateReplace;

//	var CanvasIcon GDIEnemyIcon;
//	var CanvasIcon GDIFriendlyIcon;
//	var CanvasIcon NodEnemyIcon;
//	var CanvasIcon NodFriendlyIcon;
//	var CanvasIcon NeutralIcon;
//	var CanvasIcon BA_BuildingIcon_GDI_Friendly;
//	var CanvasIcon BA_BuildingIcon_Nod_Friendly;
//	var CanvasIcon BA_BuildingIcon_GDI_Enemy;
//	var CanvasIcon BA_BuildingIcon_Nod_Enemy;


//Veterancy icons 
//	var CanvasIcon Friendly_Recruit;
//	var CanvasIcon Friendly_Veteran;
//	var CanvasIcon Friendly_Elite;
//	var CanvasIcon Friendly_Heroic;
//	var CanvasIcon Enemy_Recruit;
//	var CanvasIcon Enemy_Veteran;
//	var CanvasIcon Enemy_Elite;
//	var CanvasIcon Enemy_Heroic;
//	var CanvasIcon Neutral_Recruit;
//	var CanvasIcon Neutral_Veteran;
//	var CanvasIcon Neutral_Elite;
//	var CanvasIcon Neutral_Heroic;


var float VetLogoXOffset_PrivateReplace ;
var float VetLogoYOffset_PrivateReplace ;

var private CanvasIcon HealthCellGreen_PrivateReplace;
var private CanvasIcon HealthCellYellow_PrivateReplace;
var private CanvasIcon HealthCellRed_PrivateReplace;
var private CanvasIcon ArmorCellBlue_PrivateReplace;
var private CanvasIcon BA_HealthCellIcon_PrivateReplace; //Building Armour specific health bar.
var private CanvasIcon BA_ArmourCellIcon_PrivateReplace; //Building Armour specific Armour bar.
var private CanvasIcon BA_HealthIcon_PrivateReplace;
var private CanvasIcon BA_ArmourIcon_PrivateReplace;

var private CanvasIcon Interact_PrivateReplace;
var private float InteractIconBobAmplitude_PrivateReplace;
var private float InteractIconBobFrequency_PrivateReplace;

//	var Actor TargetedActor;
//	var Vector TargetActorHitLoc;
//	var Box ActualBoundingBox;
//	var String TargetName;
//	var String TargetDescription;
//	var float TargetHealthPercent;
//	var float TargetHealthMaxPercent;
//	var float TargetArmorPercent;
//	var bool bHasArmor;
//	var Vector2D TargetNameTextSize;
//	var Vector2D TargetDescriptionTextSize;

var private int TargetStance_PrivateReplace;

var private float BoundingBoxPadding_PrivateReplace;

var private bool AnchorInfoTop_PrivateReplace; // If true, anchor's the target info above the bounding box, false anchors it below.

var private float BackgroundYOffset_PrivateReplace;
var private float BackgroundXOffset_PrivateReplace;
var private float LogoXOffset_PrivateReplace;
var private float LogoYOffset_PrivateReplace;
var private float InteractXOffset_PrivateReplace;
var private float InteractYOffset_PrivateReplace;
var private float HealthBarXOffset_PrivateReplace;
var private float HealthBarYOffset_PrivateReplace;
var private float HealthBarCellspacing_PrivateReplace;
var private float Armor_YOffset_PrivateReplace;
var private int HealthBarCells_PrivateReplace;
var private float HealthBarRedThreshold_PrivateReplace;
var private float HealthBarYellowThreshold_PrivateReplace;
var private float LabelXOffset_PrivateReplace;
var private float LabelYOffset_PrivateReplace;
var private float PercentXOffset_PrivateReplace;
var private float PercentYOffset_PrivateReplace;
var private float DescriptionXOffset_PrivateReplace;
var private float DescriptionYOffset_PrivateReplace;
//	var float DescriptionXScale;
//	var float DescriptionYScale;
var private float BA_ArmourIconYOffset_PrivateReplace;
var private float BA_HealthIconYOffset_PrivateReplace;

/*Building Armour specific setup for boxes. Will incorporate into code once I don't need to edit them in-game*/
var private float BA_HealthBarXOffset_PrivateReplace ;
var private float BA_HealthBarYOffset_PrivateReplace;
var private float BA_ArmourBarXOffset_PrivateReplace;
var private float BA_ArmourBarYOffset_PrivateReplace;
var private float BA_LabelXOffset_PrivateReplace ;
var private float BA_LabelYOffset_PrivateReplace;
var private float BA_IconsXOffset_PrivateReplace;
var private float BA_IconsYOffset_PrivateReplace;	
var private float BA_PercentXOffset_PrivateReplace;		// 55		// -15
var private float BA_PercentYOffset_PrivateReplace;		// -35		// -15
// Offset_PrivateReplace for target's description
var private float BA_DescriptionXOffset_PrivateReplace;
var private float BA_DescriptionYOffset_PrivateReplace;
var private float BA_BackgroundXOffset_PrivateReplace;
var private float BA_BackgroundYOffset_PrivateReplace;
// Offset_PrivateReplace of team logo
var private float BA_LogoXOffset_PrivateReplace;
var private float BA_LogoYOffset_PrivateReplace;
var private float BA_HealthBarCellspacing_PrivateReplace;
var private float BA_IconToPercentSpacing_PrivateReplace;
var private float BA_ArmourPercentYOffset_PrivateReplace;

var private Box VisualBoundingBox_PrivateReplace;
var private float VisualBoundsCenterX_PrivateReplace;

var private font InteractFont_PrivateReplace;

//	var float TimeSinceNewTarget; // Starts countign when we sucessfully target a new actor
//	var float TimeSinceTargetLost; // Starts counting if the target is not being looked at
//	
//	var const float TargetStickTime; // How long the target stays after we stop looking at it.
//	var const float TargetBoxAnimTime; // How long to scale the target box target animation to.
var float HarvesterProcessToDraw;
var int HarvesterStatus;
var int iTimeSeconds;
	
	
var	const	color	ColorPurple;

function Update(float DeltaTime, Rx_HUD HUD)
{
	super.Update(DeltaTime, HUD);

	TimeSinceNewTarget += DeltaTime;

	UpdateTargetedObject(DeltaTime);

	if (TargetedActor != none)
	{
		UpdateTargetName();
		UpdateTargetHealthPercent();
		UpdateTargetDescription();
		UpdateBoundingBox();
		UpdateTargetStance(TargetedActor);
	}
}

function UpdateTargetedObject (float DeltaTime)
{
	local Actor potentialTarget;

	// Our potential target is the actor we're looking at.
	potentialTarget = GetActorAtScreenCentre();
	// If that's a valid target, then it becomes our target.
	if (IsValidTarget(potentialTarget) && IsTargetInRange(potentialTarget)) {
		SetTarget(potentialTarget);
	}
	// If we're not looking at the targetted building anymore, automatically untarget it.
	else if (TargetedActor != none && IsBuildingComponent(TargetedActor) && !IsPTorMCT(TargetedActor)) {
		TargetedActor = none;
	}
	// If the targeted actor is out of view, or out of range we should untarget it.
	else if (TargetedActor != none && (!IsValidTarget(TargetedActor) || !IsActorInView(TargetedActor,true) || !IsTargetInRange(TargetedActor)) ) {
		if (Rx_Pawn(TargetedActor) != none) {
			Rx_Pawn(TargetedActor).bTargetted = false;
		} else if (Rx_Vehicle(TargetedActor) != none) {
			Rx_Vehicle(TargetedActor).bTargetted = false;
		}
		TargetedActor = none;
	}		
	// If we're here, that means we're not looking at it, but it's still on screen and in range, so start countdown to untarget it
	else {
		TimeSinceTargetLost += DeltaTime;
	}
		

	// If our target has expired, clear it.
	if (TimeSinceTargetLost > TargetStickTime){
		if (Rx_Pawn(TargetedActor) != none) {
			Rx_Pawn(TargetedActor).bTargetted = false;
		} else if (Rx_Vehicle(TargetedActor) != none) {
			Rx_Vehicle(TargetedActor).bTargetted = false;
		}
		TargetedActor = none;	
	}
}

function SetTarget(actor Target)
{
	if (Target != TargetedActor) // We don't already have this actor targeted
	{
		if (Rx_Pawn(TargetedActor) != none) {
			Rx_Pawn(TargetedActor).bTargetted = true;
		} else if (Rx_Vehicle(TargetedActor) != none) {
			Rx_Vehicle(TargetedActor).bTargetted = true;
		}
		TargetedActor = Target;
		TimeSinceNewTarget = 0;
	}
	TimeSinceTargetLost = 0;
}

function bool IsTargetInRange(actor a)
{
	if (IsBuildingComponent(a))
		return true;

	if (GetTargetDistance(a) >= GetWeaponTargetingRange())
			return false;
	else return true;
}

function float GetTargetDistance(actor a)
{
	if (a == none)
		return 0;

	if (IsBuildingComponent(TargetedActor) && !IsPTorMCT(TargetedActor)) // Biuldings are large so their centre is bad to judge range by, use the hit location instead.
		return VSize(RenxHud.PlayerOwner.ViewTarget.Location - TargetActorHitLoc);
	else
		return VSize(RenxHud.PlayerOwner.ViewTarget.Location - a.Location);
}



function bool IsValidTarget (actor potentialTarget)
{
	if (Rx_Building(potentialTarget) != none ||
		(Rx_BuildingAttachment(potentialTarget) != none && Rx_BuildingAttachment_Door(potentialTarget) == none) ||
		Rx_Building_Internals(potentialTarget) != none ||
		(Rx_Vehicle(potentialTarget) != none && Rx_Vehicle(potentialTarget).Health > 0) ||
		(Rx_Weapon_DeployedActor(potentialTarget) != none && Rx_Weapon_DeployedActor(potentialTarget).GetHealth() > 0) ||
		(Rx_Pawn(potentialTarget) != none && Rx_Pawn(potentialTarget).Health > 0)||
		(Rx_DestroyableObstaclePlus(potentialTarget) !=none && Rx_DestroyableObstaclePlus(potentialTarget).bShowHealth && Rx_DestroyableObstaclePlus(potentialTarget).GetHealth() > 0) ||
		(Rx_CratePickup(potentialTarget) != none && !Rx_CratePickup(potentialTarget).bPickupHidden)
		)
	{
		if (IsStealthedEnemyUnit(Pawn(potentialTarget)) ||
			potentialTarget == RenxHud.PlayerOwner.ViewTarget ||
			(Rx_VehicleSeatPawn(RenxHud.PlayerOwner.ViewTarget) != none && potentialTarget == Rx_VehicleSeatPawn(RenxHud.PlayerOwner.ViewTarget).MyVehicle))
		return false;
		else return true;
	}
		
	else return false;
}

function Actor GetActorAtScreenCentre()
{
	return RenxHud.ScreenCentreActor;
}

function UpdateTargetHealthPercent ()
{
	TargetArmorPercent = 0;
	bHasArmor = false;
	
	if (IsTechBuildingComponent(TargetedActor) && !IsPTorMCT(TargetedActor))
	{
		TargetHealthPercent = -1;
		return;
	}
	
	
	
	if (Rx_Pawn(TargetedActor) != none)	//Players
	{
		TargetHealthPercent =  (float(Rx_Pawn(TargetedActor).Health) + float(Rx_Pawn(TargetedActor).Armor)) / max(1,float(Rx_Pawn(TargetedActor).HealthMax) + float(Rx_Pawn(TargetedActor).ArmorMax));
	}
	else if (Pawn(TargetedActor) != none) // Harvester
	{
		TargetHealthPercent =  float(Pawn(TargetedActor).Health) / max(1, float(Pawn(TargetedActor).HealthMax));
	}
	else if (Rx_Weapon_DeployedActor(TargetedActor) != none && !Rx_Weapon_DeployedActor(TargetedActor).bCanNotBeDisarmedAnymore)
	{
		TargetHealthPercent = float(Rx_Weapon_DeployedActor(TargetedActor).GetHealth()) / max(1, float(Rx_Weapon_DeployedActor(TargetedActor).GetMaxHealth()));
	}
	else if (Rx_DestroyableObstaclePlus(TargetedActor) != none)
	{
		TargetHealthPercent = float(Rx_DestroyableObstaclePlus(TargetedActor).GetHealth()) / max(1, float(Rx_DestroyableObstaclePlus(TargetedActor).GetMaxHealth()));
	}
	else if (Rx_BuildingAttachment(TargetedActor) != none && Rx_BuildingAttachment_PT(TargetedActor) == none)
	{
		//Default:
		//TargetHealthPercent = Rx_BuildingAttachment(TargetedActor).getBuildingHealthPct();
		//TargetHealthMaxPercent = Rx_BuildingAttachment(TargetedActor).getBuildingHealthMaxPct();		
		//TargetArmorPercent = Rx_BuildingAttachment(TargetedActor).getBuildingArmorPct();
		
		//Ukill: Added FClamp to Limit the value that can be displayed
		TargetHealthPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingHealthPct(), 0.0f, 1.0f );
		TargetHealthMaxPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingHealthMaxPct(), 0.0f, 1.0f );
		TargetArmorPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingArmorPct(), 0.0f, 1.0f );

		bHasArmor = true;
	}
	else if (Rx_Building(TargetedActor) != none)
	{
		TargetArmorPercent = float(Rx_Building(TargetedActor).GetArmor()) / max(1,float(Rx_Building(TargetedActor).GetMaxArmor()));
		TargetHealthPercent = float(Rx_Building(TargetedActor).GetHealth()) / max(1,float(Rx_Building(TargetedActor).GetTrueMaxHealth()));		
		TargetHealthMaxPercent = 1.0f; //This may need to look at TrueMaxHealth somewhere.. we'll see after testing. 
		
		bHasArmor = true;
	}
	else
		TargetHealthPercent = -1;
		
	if(Rx_Building_Techbuilding(TargetedActor) != None || Rx_CapturableMCT(TargetedActor) != None
		|| (Rx_BuildingAttachment(TargetedActor) != none 
			&& Rx_BuildingAttachment(TargetedActor).OwnerBuilding != None && (Rx_Building_Techbuilding(Rx_BuildingAttachment(TargetedActor).OwnerBuilding.BuildingVisuals) != None || Rx_CapturableMCT(Rx_BuildingAttachment(TargetedActor).OwnerBuilding.BuildingVisuals) != None)) )
	{
		bHasArmor = false;
	}	
		
}

function UpdateTargetName ()
{
	if (RxIfc_TargetedCustomName(TargetedActor) != none)
		TargetName = RxIfc_TargetedCustomName(TargetedActor).GetTargetedName(RenxHud.PlayerOwner);
	else
		TargetName = TargetedActor.GetHumanReadableName();
}

function UpdateTargetDescription ()
{

	local Rx_Mutator_AdminTool_Controller myAdminTool_Controllers;
	local string sHealtlocked,sOtherDescription;
	
	//Default:
	//if (RxIfc_TargetedDescription(TargetedActor) != none)
	//	TargetDescription = RxIfc_TargetedDescription(TargetedActor).GetTargetedDescription(RenxHud.PlayerOwner);
	//else
	//	TargetDescription = "";
		
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controllers) break;
		
	if (RxIfc_TargetedDescription(TargetedActor) != none)
	{		
		sOtherDescription = RxIfc_TargetedDescription(TargetedActor).GetTargetedDescription(RenxHud.PlayerOwner);	
	}

	//Ukill: Add custom messages
	switch (TargetName)
	{
		case "Adv. Guard Tower":
		case "Obelisk of Light":
		case "Weapons Factory":
		case "Refinery":
		case "Nod Refinery":
		case "GDI Refinery":
		case "Power Plant":
		case "Nod Power Plant":
		case "GDI Power Plant":		//	GetAttachmentBuildingHealth(Rx_BuildingAttachment(TargetedActor)))
		case "Hand of Nod":
		case "Barracks":

	
	//rx_building_refinery_gdi_internals
	//rx_building_refinery_gdi_0

	//myAdminTool_Controllers.ClientMessage("TargetName: " $ TargetName);
	//myAdminTool_Controllers.ClientMessage("TargetedActor: " $ TargetedActor);
	//myAdminTool_Controllers.ClientMessage("NewTargetedActor: " $ Mid(TargetedActor,0,Len(TargetedActor)-2));

	//name(Mid(TargetedActor,0,Len(TargetedActor)-2) $ "_internals"

			//for (x = 0; x < 24; x++)
			//{
			//	if ( myAdminTool_Controllers.BuildingNameArray[x] ~= (Mid(TargetedActor,0,Len(TargetedActor)-2) $ "_internals"));
			//	break;
			//}
			
			if ( GetAttachmentBuildingHealthLocked(Rx_Building_Team_Internals(TargetedActor)) ) //Ukill: no idea why this doesnt work
			{
				sHealtlocked = "Health Locked1";
			}
			else if ( Rx_Mutator_AdminTool_BuildingAttachment(TargetedActor).getBuildingHealthLocked() )
			{
				sHealtlocked = "Health Locked2";
			}
			//else if (Rx_Building_Team_Internals(name(Mid(TargetedActor,0,Len(TargetedActor)-2) $ "_internals")).HealthLocked)
			//{
			//	sHealtlocked = "Health Locked4";
			//}			
			else if ( myAdminTool_Controllers.GetBuildingLockStatusServer(23) == "true" )
			{
				sHealtlocked = "Health Locked - is true";
			}
			else if ( myAdminTool_Controllers.GetBuildingLockStatusServer(23) == "false" )
			{
				sHealtlocked = "Health Locked - is false";
			}
			else if ( bool(myAdminTool_Controllers.ModeStatusArray[10]) )
			{
				sHealtlocked = "Health Locked";
			}
		break;
		/// Reset others to none
		case "MCT":
			// Add HP value when armor or health settings out of range
			if ( (int(GetAttachmentBuildingHealth(Rx_BuildingAttachment(TargetedActor))) > (GetAttachmentBuildingTrueMaxHealth(Rx_BuildingAttachment(TargetedActor)))) || ((GetAttachmentBuildingArmor(Rx_BuildingAttachment(TargetedActor))) > (GetAttachmentBuildingMaxArmor(Rx_BuildingAttachment(TargetedActor)))) )
			{
				TargetDescription = "     " $ int(GetAttachmentBuildingHealth(Rx_BuildingAttachment(TargetedActor))) $ " / " $ GetAttachmentBuildingArmor(Rx_BuildingAttachment(TargetedActor)); //Will be added below
			}
			return;
		break;

		//TargetHealthPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingHealthPct(), 0.0f, 1.0f );
		//TargetHealthMaxPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingHealthMaxPct(), 0.0f, 1.0f );
		//TargetArmorPercent = FClamp( Rx_BuildingAttachment(TargetedActor).getBuildingArmorPct(), 0.0f, 1.0f );

		//just listed some for fun 
		case "Silo":			
		case "Electromagnetic Pulse cannon":
		case "Communications Centre":
		case "Airstrip":
		
		default:
			sHealtlocked = "";
	}

	// Dirty combination powerdown/healthlocked description
	if ( sHealtlocked == "" && sOtherDescription != "" )
	{
		TargetDescription = sOtherDescription;
	}	
	else if ( sHealtlocked != "" && sOtherDescription != "" )
	{
		TargetDescription = sHealtlocked $ " & " $ sOtherDescription;
	}
	else if ( sHealtlocked != "" && sOtherDescription == "" )
	{
		TargetDescription = sHealtlocked;
	}
	else
	{
		TargetDescription = " ";	//Purchahe pannel en alles behalve GT]
		//Building Description			
	}
		
}

function UpdateBoundingBox()
{
	local array<vector> Vertices;
	local box BBox, BBox2;
	local int i;

	if (IsBuildingComponent(TargetedActor) && !IsPTorMCT(TargetedActor))
	{
		BBox2.Min.X = Canvas.SizeX * 0.4;
		BBox2.Max.X = Canvas.SizeX * 0.6;
		BBox2.Min.Y = Canvas.SizeY * 0.4;
		BBox2.Max.Y = Canvas.SizeY * 0.6;
	}
	else
	{
		if (Rx_BuildingAttachment_PT(TargetedActor) != none)
			BBox = GetPTBoundingBox(Rx_BuildingAttachment_PT(TargetedActor));
		else
			TargetedActor.GetComponentsBoundingBox(BBox);
	
		// Project all 8 corner points of the target onto our canvas
		Vertices.AddItem(Canvas.project(BBox.Min));
		Vertices.AddItem(Canvas.project(BBox.Max));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Max.X, BBox.Max.Y, BBox.Min.Z)));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Max.X, BBox.Min.Y, BBox.Min.Z)));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Min.X, BBox.Min.Y, BBox.Max.Z)));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Min.X, BBox.Max.Y, BBox.Max.Z)));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Min.X, BBox.Max.Y, BBox.Min.Z)));
		Vertices.AddItem(Canvas.project(ReturnVector(BBox.Max.X, BBox.Min.Y, BBox.Max.Z)));
	
		BBox2.Min.X = 9001;
		BBox2.Min.Y = 9001;
	
		// Find extremes of bounding box
		for(i = 0; i < Vertices.Length; i++)
		{
			BBox2.Min.X = fmin(BBox2.Min.X, Vertices[i].X);
			BBox2.Min.Y = fmin(BBox2.Min.Y, Vertices[i].Y);
			BBox2.Max.X = fmax(BBox2.Max.X, Vertices[i].X);
			BBox2.Max.Y = fmax(BBox2.Max.Y, Vertices[i].Y);
		}
	}

	ActualBoundingBox = BBox2;

	VisualBoundingBox_PrivateReplace = ActualBoundingBox;
	VisualBoundingBox_PrivateReplace.Max.X = FClamp ( VisualBoundingBox_PrivateReplace.Max.X ,0 + ScreenEdgePadding_PrivateReplace, Canvas.SizeX - ScreenEdgePadding_PrivateReplace) + BoundingBoxPadding_PrivateReplace;
	VisualBoundingBox_PrivateReplace.Max.Y = FClamp ( VisualBoundingBox_PrivateReplace.Max.Y  ,0 + ScreenEdgePadding_PrivateReplace, Canvas.SizeY - ScreenBottomPadding_PrivateReplace) + BoundingBoxPadding_PrivateReplace;
	VisualBoundingBox_PrivateReplace.Min.X = FClamp ( VisualBoundingBox_PrivateReplace.Min.X ,0 + ScreenEdgePadding_PrivateReplace, Canvas.SizeX - ScreenEdgePadding_PrivateReplace)- BoundingBoxPadding_PrivateReplace ;
	VisualBoundingBox_PrivateReplace.Min.Y = FClamp ( VisualBoundingBox_PrivateReplace.Min.Y  ,0 + ScreenEdgePadding_PrivateReplace, Canvas.SizeY - ScreenBottomPadding_PrivateReplace) - BoundingBoxPadding_PrivateReplace;
	VisualBoundingBox_PrivateReplace = ClampBoundingBox(VisualBoundingBox_PrivateReplace);
	VisualBoundingBox_PrivateReplace = AnimateBoundingBox(VisualBoundingBox_PrivateReplace,(1/TargetBoxAnimTime) * TimeSinceNewTarget);
	VisualBoundsCenterX_PrivateReplace = VisualBoundingBox_PrivateReplace.Min.X + (VisualBoundingBox_PrivateReplace.Max.X - VisualBoundingBox_PrivateReplace.Min.X)/2;	
}

function Box AnimateBoundingBox (Box inBox, float Time)
{
	local vector boxCentre;
	boxCentre = inBox.Max - ((inBox.Max - inBox.Min)/2);

	if(Time < 1 && Time >= 0)
	{
		inBox.Min.X = inBox.Min.X - BoxCentre.X * (1 - Time) / 13;
		inBox.Max.X = inBox.Max.X + BoxCentre.X * (1 - Time) / 13;
		inBox.Min.Y = inBox.Min.Y - BoxCentre.Y * (1 - Time) / 13;
		inBox.Max.Y = inBox.Max.Y + BoxCentre.Y * (1 - Time) / 13;
	}
	return inBox;
}

function Box ClampBoundingBox(Box OriginalBox)
{
	local vector Size, AmmountToShrink;
	Size = OriginalBox.Max - OriginalBox.Min;
	AmmountToShrink.X = Max(Size.X - (MaxTargetBoxSizePctX_PrivateReplace * Canvas.SizeX),0);
	AmmountToShrink.Y = Max(Size.Y - (MaxTargetBoxSizePctY_PrivateReplace * Canvas.SizeY),0);
	OriginalBox.Max -= AmmountToShrink/2;
	OriginalBox.Min += AmmountToShrink/2;
	return OriginalBox;

}

function Box GetPTBoundingBox(Rx_BuildingAttachment_PT PT)
{
	local Box BBox;
	BBox.IsValid = 1;
	Bbox.Max = PT.Location + PT.PTMesh.Bounds.BoxExtent;
	Bbox.Min = PT.Location - PT.PTMesh.Bounds.BoxExtent;
	return BBox;
}

function vector ReturnVector(float X, float Y, float Z)
{
	local vector result;
	result.X = X;
	result.Y = Y;
	result.Z = Z;
	return result;
}

function float GetAttachmentBuildingHealth(Rx_BuildingAttachment BAttachment)
{
	if (BAttachment.OwnerBuilding != none)
	{
		return BAttachment.OwnerBuilding.GetHealth();
	}
}

function Draw()
{
	if (TargetedActor != none && Canvas != None)
	{
		Canvas.DrawColor = ColorWhite;

		DrawBoundingBoxCorners();
		DrawTargetInfo();
	}
}

private function DrawBoundingBoxCorners()
{

	if (TargetStance_PrivateReplace == STANCE_NEUTRAL)
	{
		Canvas.DrawIcon(BoundingBoxNeutralTopLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxNeutralTopRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxNeutralTopRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxNeutralBottomLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxNeutralBottomLeft_PrivateReplace.VL);
		Canvas.DrawIcon(BoundingBoxNeutralBottomRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxNeutralBottomRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxNeutralBottomRight_PrivateReplace.VL);
	}
	else if (TargetStance_PrivateReplace == STANCE_FRIENDLY)
	{
		Canvas.DrawIcon(BoundingBoxFriendlyTopLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxFriendlyTopRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxFriendlyTopRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxFriendlyBottomLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxFriendlyBottomLeft_PrivateReplace.VL);
		Canvas.DrawIcon(BoundingBoxFriendlyBottomRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxFriendlyBottomRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxFriendlyBottomRight_PrivateReplace.VL);
	} 
	else
	{
		Canvas.DrawIcon(BoundingBoxEnemyTopLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxEnemyTopRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxEnemyTopRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Min.Y);
		Canvas.DrawIcon(BoundingBoxEnemyBottomLeft_PrivateReplace,VisualBoundingBox_PrivateReplace.Min.X,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxEnemyBottomLeft_PrivateReplace.VL);
		Canvas.DrawIcon(BoundingBoxEnemyBottomRight_PrivateReplace,VisualBoundingBox_PrivateReplace.Max.X+BoundingBoxEnemyBottomRight_PrivateReplace.UL,VisualBoundingBox_PrivateReplace.Max.Y+BoundingBoxEnemyBottomRight_PrivateReplace.VL);
	}
}

private function DrawTargetInfo()
{
		DrawInfoBackground();	
		DrawTeamLogo();
		DrawHealthBar();
		//DrawProgressBar();
		DrawHealthPercent();
		DrawTargetName();
		if (TargetDescription != "")
			DrawTargetDescription();

		if ( RenxHud.ShowInteractMessage && CanInteract())
			DrawInteractText();
		if ( RenxHud.ShowInteractableIcon && Interactable())
			DrawInteractableIcon();
}

function bool CanInteract()
{
	if (RenxHud.PlayerOwner.Pawn == none || RenxHud.PlayerOwner.Pawn.DrivenVehicle != none)
		return false;

	if (Rx_Vehicle(TargetedActor) != none && Rx_Vehicle_Harvester(TargetedActor) == none)
		return Rx_Vehicle(TargetedActor).ShouldShowUseable(RenxHud.PlayerOwner,0);

	return false;
}

function bool Interactable()
{
	if (RenxHud.PlayerOwner.Pawn == none || RenxHud.PlayerOwner.Pawn.DrivenVehicle != none || UTPlayerController(RenxHud.PlayerOwner) == none)
		return false;

	if (Rx_Vehicle(TargetedActor) != none && Rx_Vehicle_Harvester(TargetedActor) == none)
		return Rx_Vehicle(TargetedActor).CanEnterVehicle(RenxHud.PlayerOwner.Pawn);

	else if (Rx_BuildingAttachment_PT_GDI(TargetedActor) != none && Rx_Controller(RenxHud.PlayerOwner).bCanAccessPT && RenxHud.PlayerOwner.Pawn.GetTeamNum() == TEAM_GDI)
		return true;

	else if (Rx_BuildingAttachment_PT_NOD(TargetedActor) != none && Rx_Controller(RenxHud.PlayerOwner).bCanAccessPT && RenxHud.PlayerOwner.Pawn.GetTeamNum() == TEAM_NOD)
		return true;

	else 
		return false;
}

private function DrawInteractText()
{
	local float X,Y, Xlen,Ylen;
	local string Text,bindKey;
	
	bindKey = Caps(UDKPlayerInput(RenxHud.PlayerOwner.PlayerInput).GetUDKBindNameFromCommand("GBA_Use"));
	
	if (Vehicle(TargetedActor) != none)
		Text = ("Press [ " $ bindKey $ " ] to enter " $ Vehicle(TargetedActor).GetHumanReadableName());
	else if (Rx_BuildingAttachment_PT(TargetedActor) != none)
		Text = ("Press [ " $ bindKey $ " ] to enter Purchase Terminal");

	Canvas.Font = InteractFont_PrivateReplace;
	Canvas.TextSize(Text,Xlen,Ylen);

	X = VisualBoundsCenterX_PrivateReplace + InteractXOffset_PrivateReplace - (Xlen/2);

	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + InteractYOffset_PrivateReplace - Ylen;
	else
		Y = VisualBoundingBox_PrivateReplace.Min.Y - Interact_PrivateReplace.VL - Ylen;

	if (RenxHud.ShowInteractableIcon)
		Y -= Interact_PrivateReplace.VL;
	else
		Y -= 10;

	Canvas.DrawColor = ColorGreen;
	Canvas.SetPos(X,Y,0);
	Canvas.DrawText(Text);
}

private function DrawInteractableIcon()
{
	local float X,Y;
	X = VisualBoundsCenterX_PrivateReplace + InteractXOffset_PrivateReplace - (Interact_PrivateReplace.UL/2);

	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + InteractYOffset_PrivateReplace - Interact_PrivateReplace.VL;
	else
		Y = VisualBoundingBox_PrivateReplace.Min.Y - Interact_PrivateReplace.VL;

	Y += Sin(class'WorldInfo'.static.GetWorldInfo().TimeSeconds * InteractIconBobFrequency_PrivateReplace) * InteractIconBobAmplitude_PrivateReplace;

	Canvas.SetDrawColor(255,255,255,255);
	Canvas.DrawIcon(Interact_PrivateReplace,X,Y);
}


function ProccessToDrawIncrease()
{
	if (HarvesterProcessToDraw < 20)
	{
		HarvesterProcessToDraw = HarvesterProcessToDraw + 0.04;
		class'WorldInfo'.static.GetWorldInfo().SetTimer(1,false,'ProccessToDrawIncrease');
	}
	else
	{
		HarvesterStatus = 2;
	}
}

function ProccessToDrawDecrease()
{
	if (HarvesterProcessToDraw > 0)
	{
		HarvesterProcessToDraw = HarvesterProcessToDraw - 0.04;
		class'WorldInfo'.static.GetWorldInfo().SetTimer(1,false,'ProccessToDrawIncrease');
	}
	else
	{
		HarvesterStatus = 6;
	}
}



private function DrawHealthBar()
{
	local int i;
	local CanvasIcon HealthCell;
	local color HealthBlendColour;
	local int HealthBarsToDraw;
	local int HealthFillupBarsToDraw;
	local int ArmorBarsToDraw;
	local int BarsToDraw,iStartTime;

	local float X, Y;
	local float ArmorHealthPercentTemp;
	local Actor A;
	local string str1;
	
	//local Rx_Vehicle_Harvester Harv;
	
	if (TargetHealthPercent != -1)
	{
		
		if(bHasArmor)
		{
			ArmorHealthPercentTemp = Rx_GRI(RenxHud.WorldInfo.Gri).buildingArmorPercentage / 100.0;		
		}
		
		if(ArmorHealthPercentTemp > 0) //We have armour enabled
		{
			HealthCell = BA_HealthCellIcon_PrivateReplace;
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace*TargetHealthMaxPercent)
				HealthBlendColour = ColorRed; //Go full red...tard. 
		//HealthCell = HealthCellRed_PrivateReplace;
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace*TargetHealthMaxPercent)
					HealthBlendColour = ColorYellow; //Go yeller
			//HealthCell = HealthCellYellow_PrivateReplace;
			else 
			HealthBlendColour = ColorGreen; //Go environmentally friendly. 	
			//HealthCell = HealthCellGreen_PrivateReplace;
			
				
					HealthBarsToDraw = RoundUp(TargetHealthPercent * float(HealthBarCells_PrivateReplace) );
					ArmorBarsToDraw = RoundUp(TargetArmorPercent * float(HealthBarCells_PrivateReplace) );//ArmorBarsToDraw = RoundUp(TargetArmorPercent*ArmorHealthPercentTemp * float(HealthBarCells_PrivateReplace) );
					HealthFillupBarsToDraw = RoundUp(TargetHealthMaxPercent * float(HealthBarCells_PrivateReplace)) - HealthBarsToDraw; 
					 
			
				X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace + BA_IconsXOffset_PrivateReplace;
		
				if (AnchorInfoTop_PrivateReplace)
					Y = VisualBoundingBox_PrivateReplace.Min.Y + BA_HealthBarYOffset_PrivateReplace;
				else
					Y = VisualBoundingBox_PrivateReplace.Max.Y + BA_HealthBarYOffset_PrivateReplace;
			
			if (TargetHealthPercent > 0) //Don't bother drawing anything if it's already dead  
			{
				
			 
				//Draw Armour Over Health... maybe ? 
				
				
				
				Canvas.DrawColor = ColorBlue ;//ColorWhite;
				//Canvas.DrawColor.A=210; //Let health show through armour bar slightly so we can still see if it is red/green health
					HealthCell = BA_ArmourCellIcon_PrivateReplace;			
				for (i = 0; i < ArmorBarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y); 
					X += BA_HealthBarCellspacing_PrivateReplace;
				}
				
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthBarCells_PrivateReplace - (HealthBarsToDraw + HealthFillupBarsToDraw + ArmorBarsToDraw); i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y,1.4);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}	
				
				//DRaw health under armour 
				//Again, Health Offset_PrivateReplaces are now used for Armour, and vice versa!!!!!!!!!
				
				X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace;
				Y+=BA_ArmourBarYOffset_PrivateReplace;
				
				for (i = 0; i < HealthBarsToDraw; i++)
				{
					Canvas.DrawColor=HealthBlendColour;
					Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}
				
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthFillupBarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}			


				
				//		/////////////////////////////////////////////////////////////////////////////////////////////
				//		
				//		//DRaw status under health
				//		//Again, Health Offset_PrivateReplaces are now used for Armour, and vice versa!!!!!!!!!
				//		
				//		X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace;
				//		Y+=BA_ArmourBarYOffset_PrivateReplace;
				//		
				//		for (i = 0; i < ProgressBarsToDraw; i++)
				//		{
				//			Canvas.DrawColor=HealthBlendColour;
				//			Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace);
				//			X += BA_HealthBarCellspacing_PrivateReplace + BA_HealthBarCellspacing_PrivateReplace;
				//		}
				//		
				//		Canvas.DrawColor = ColorGreyedOut;
				//		for (i = 0; i < HealthFillupBarsToDraw; i++)
				//		{
				//			Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace+BA_ArmourBarYOffset_PrivateReplace);
				//			X += BA_HealthBarCellspacing_PrivateReplace + BA_HealthBarCellspacing_PrivateReplace;
				//		}		
                //		
				//		////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
			}
		}
		else
		{
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace)
			{
				HealthCell = HealthCellRed_PrivateReplace;
			}
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace)
			{
				HealthCell = HealthCellYellow_PrivateReplace;
			}
			else 
			{
				HealthCell = HealthCellGreen_PrivateReplace;
			}
	
			BarsToDraw = RoundUp(TargetHealthPercent * float(HealthBarCells_PrivateReplace) );

		
			X = VisualBoundsCenterX_PrivateReplace + HealthBarXOffset_PrivateReplace;
	
	 		if (AnchorInfoTop_PrivateReplace)
			{
				Y = VisualBoundingBox_PrivateReplace.Min.Y + HealthBarYOffset_PrivateReplace;
			}
			else
			{
				Y = VisualBoundingBox_PrivateReplace.Max.Y + HealthBarYOffset_PrivateReplace;
			}
			
			if (TargetHealthPercent > 0) //Don't bother drawing anything if it's already dead  													////DONT  GO OVER 100 HERE
			{
				for (i = 0; i < BarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y);
					X += HealthBarCellspacing_PrivateReplace;
				}
				
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthBarCells_PrivateReplace - BarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y);
					X += HealthBarCellspacing_PrivateReplace;
				}
				
				
				
				//Ukill: add value for harvester
				
				
				//	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controllers) break; ( bool(myAdminTool_Controllers.iHarvestProcess) )
				Canvas.DrawColor = ColorBlue;
				//Canvas.DrawColor = ColorRed;
				//Canvas.DrawColor = ColorGreen;
				
				
				foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Actor', A)
				{	
					if ( A == None )
					return;

					if ( A.IsA('Rx_Vehicle_Harvester_GDI') )
					//if (InStr(A,"Rx_Vehicle_Harvester_GDI") >= 0)
					
					//A.IsA( name(BuildingNameArray[x]) ) && A != None )
					//if (InStr(A,"Rx_Vehicle_Harvester_GDI") >= 0)
					{
						//str1 = ( "  Status: ");
						//if (Rx_Vehicle_Harvester(A).bPlayOpeningAnim){ str1 = str1 $ " Open "; };
						//if (Rx_Vehicle_Harvester(A).bPlayClosingAnim){ str1= str1 $ " Close "; };
						//if (Rx_Vehicle_Harvester(A).bPlayHarvestingAnim){ str1= str1 $ " Harvest " ; };
						//if (Rx_Vehicle_Harvester(A).bTurningToDock){ str1= str1 $ " Turning "; };
						//if (HarvesterStatus > 0){ str1= str1 $ " Status: " $ HarvesterStatus; };
						//if (HarvesterProcessToDraw > 0){ str1= str1 $ " Process: " $ HarvesterProcessToDraw * 5; };
					
						switch (HarvesterStatus)
						{
							case 0: //Default
									if (Rx_Vehicle_Harvester(A).bPlayHarvestingAnim)
									{
										if ( iStartTime == 0 )
										{
											iStartTime = class'WorldInfo'.static.GetWorldInfo().RealTimeSeconds;
											HarvesterStatus = 1;
											
										}
									}	
								break;
						
							case 1: //Havesting
								ProccessToDrawIncrease();
								break;
								
							case 2: //BackToRef
									if ( Rx_Vehicle_Harvester(A).bPlayClosingAnim )
									{
										HarvesterProcessToDraw = 20.0f;
										HarvesterStatus = 3;
									}
								break;
								
							case 3: //TurningFrontRef
									if ( Rx_Vehicle_Harvester(A).bTurningToDock )
									{
										HarvesterStatus = 4;
									}	
								break;
								
							case 4: //TurningFrontRefStopped
									if ( !Rx_Vehicle_Harvester(A).bTurningToDock )
									{
										HarvesterStatus = 5;
									}
								break;
								
							case 5: //HarvesterDump
									ProccessToDrawDecrease();
								break;
								
							case 6: //HarvesterDumpEnd

									if ( Rx_Vehicle_Harvester(A).bPlayClosingAnim )
									{
										HarvesterProcessToDraw = 0.0f;
										iStartTime = 0;
										HarvesterStatus = 0;
									}
								break;
						}

						//if ( iStartTime > 0 && HarvesterProcessToDraw < 20 )
						//{
						//	HarvesterProcessToDraw = HarvesterProcessToDraw + 1.0f;
						//	
						//}

					
						
						//if (Rx_Vehicle_Harvester(A).bPlayClosingAnim && bDockTriggered)
						//{
						//	if (!Rx_Vehicle_Harvester(A).bTurningToDock)
						//	{
						//		HarvesterProcessToDraw = 0.0f;
						//		iStartTime = 0;
						//		HarvesterStatus = ;
						//	}
						//}					
					}

					//While (Rx_Vehicle_Harvester(A).bPlayHarvestingAnim) //Pause until this function returns true
					//Sleep(0.0);

					if (InStr(A,"Rx_Building_Refinery_GDI") >= 0)
					{
						//if ( Rx_Vehicle_HarvesterController(A).IsTurningToDock() )
						//{
						//	HarvesterProcessToDraw = 0;
						//}
					}
					//sleep(refinery.HarvesterHarvestTime);
					
				}
	//if(Rx_Vehicle_HarvesterController(Pawn(Other).Controller) != None && Rx_Vehicle_HarvesterController(Pawn(Other).Controller).IsTurningToDock()) 
		
				for (i = 0; i < HarvesterProcessToDraw && i < 20; i++)
				{//HarvesterProcessToDraw
					Canvas.DrawIcon(ArmorCellBlue_PrivateReplace,X-120,Y+5);
					X += HealthBarCellspacing_PrivateReplace;
				}	

				
				
				
				
				
				
				
//		HealthCellGreen_PrivateReplace;
//		HealthCellYellow_PrivateReplace;
//		HealthCellRed_PrivateReplace;
//		ArmorCellBlue_PrivateReplace;
//		
//		BA_HealthBarCellspacing_PrivateReplace
//		
//		BA_ArmourCellIcon_PrivateReplace;
//		BA_HealthIcon_PrivateReplace;
//		BA_ArmourIcon_PrivateReplace;
				
				
				
				
				
				//Canvas.DrawColor = ColorGreen;
				//Canvas.SetPos(X,Y+10);
				//Canvas.DrawColor = ColorPurple;

				//Canvas.DrawText(str1);
	//	local Rx_Mutator_AdminTool_Controller myAdminTool_Controllers;
	//local string sHealtlocked,sOtherDescription;
	//
	////Default:
	////if (RxIfc_TargetedDescription(TargetedActor) != none)
	////	TargetDescription = RxIfc_TargetedDescription(TargetedActor).GetTargetedDescription(RenxHud.PlayerOwner);
	////else
	////	TargetDescription = "";
	//	
	//foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controllers) break;			
				
				//		foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Actor', A)
				//		{	
				//			if ( A == None )
				//			return;
				//			
				//			if (InStr(A,"Rx_Vehicle_Harvester_GDI_0") >= 0)
				//			{
				//				//while( Rx_Vehicle_Harvester(A).bPlayHarvestingAnim && HarvesterProcessToDraw < 1.01 )
				//				//{
				//				//	HarvesterProcessToDraw = HarvesterProcessToDraw + 0.01;
				//				//}
				//			    //
				//				//if ( Rx_Vehicle_Harvester(A).bTurningToDock && HarvesterProcessToDraw > 0)
				//				//{
				//				//	HarvesterProcessToDraw = 0;
				//				//}					
				//			
				//				//if ( Rx_Vehicle_Harvester(A).bPlayOpeningAnim )
				//				//{
				//				//	HarvesterProcessToDraw = 1;
				//				//}
				//				//else if ( Rx_Vehicle_Harvester(A).bPlayHarvestingAnim )
				//				//{
				//				//	HarvesterProcessToDraw = 10;
				//				//}					
                //		    
				//			}
				//			
				//			//HarvesterProcessToDraw
				//			for (i = 0; i < BarsToDraw; i++)
				//			{
				//				Canvas.DrawIcon(HealthCell,X-120,Y+5);
				//				X += HealthBarCellspacing_PrivateReplace;
				//			}
				//		}
				
				//iHarvestProcess
				//Canvas.DrawText(BarsToDraw);
				
				//iHarvestProcess
				//Canvas.DrawText("Some test");
				
				
				
				
								//Canvas.DrawColor = ColorBlue;
				//Canvas.DrawColor = ColorBlue;
				//Canvas.DrawColor = ColorRed;
				//Canvas.DrawColor = ColorYellow;
				//Canvas.DrawColor = ColorGreen;
				//Canvas.Font = LabelFont_PrivateReplace;
				//Canvas.SetPos(X-200,Y+10,0);
				//Canvas.DrawText("(Destroyed)");
				
			}
		}

		if (TargetHealthPercent <= 0)
		{
			Canvas.DrawColor = ColorGreen; 
		if(ArmorHealthPercentTemp > 0)	X = VisualBoundsCenterX_PrivateReplace + BA_LabelXOffset_PrivateReplace;
		else
		X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace;
			Canvas.Font = LabelFont_PrivateReplace;
			Canvas.SetPos(X,Y,0);
			Canvas.DrawText("(Destroyed)");
		}	
		
	}

}

/*
private function DrawProgressBar()
{
	local int i;
	local CanvasIcon HealthCell;
	local color HealthBlendColour;
	local int HealthBarsToDraw;
	local int HealthFillupBarsToDraw;
	local int ArmorBarsToDraw;
	local int BarsToDraw;
	local float X, Y;
	local float ArmorHealthPercentTemp;
	
	if (TargetHealthPercent != -1)
	{
		
		if(bHasArmor)
		{
			ArmorHealthPercentTemp = Rx_GRI(RenxHud.WorldInfo.Gri).buildingArmorPercentage / 100.0;		
		}
		
		if(ArmorHealthPercentTemp > 0) //We have armour enabled
		{
			HealthCell = BA_HealthCellIcon_PrivateReplace;
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace*TargetHealthMaxPercent)
				HealthBlendColour = ColorRed; //Go full red...tard. 
		//HealthCell = HealthCellRed_PrivateReplace;
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace*TargetHealthMaxPercent)
					HealthBlendColour = ColorYellow; //Go yeller
			//HealthCell = HealthCellYellow_PrivateReplace;
			else 
			HealthBlendColour = ColorGreen; //Go environmentally friendly. 	
			//HealthCell = HealthCellGreen_PrivateReplace;
			
				
					HealthBarsToDraw = RoundUp(TargetHealthPercent * float(HealthBarCells_PrivateReplace) );
					ArmorBarsToDraw = RoundUp(TargetArmorPercent * float(HealthBarCells_PrivateReplace) );//ArmorBarsToDraw = RoundUp(TargetArmorPercent*ArmorHealthPercentTemp * float(HealthBarCells_PrivateReplace) );
					HealthFillupBarsToDraw = RoundUp(TargetHealthMaxPercent * float(HealthBarCells_PrivateReplace)) - HealthBarsToDraw; 
					 
			
				X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace + BA_IconsXOffset_PrivateReplace;
		
				if (AnchorInfoTop_PrivateReplace)
					Y = VisualBoundingBox_PrivateReplace.Min.Y+11 + BA_HealthBarYOffset_PrivateReplace;
				else
					Y = VisualBoundingBox_PrivateReplace.Max.Y+11 + BA_HealthBarYOffset_PrivateReplace;
			
			if (TargetHealthPercent > 0) //Don't bother drawing anything if it's already dead  
			{
				
			 
				//Draw Armour Over Health... maybe ? 
				
				
				
				Canvas.DrawColor = ColorBlue ;//ColorWhite;
				//Canvas.DrawColor.A=210; //Let health show through armour bar slightly so we can still see if it is red/green health
					HealthCell = BA_ArmourCellIcon_PrivateReplace;			
				for (i = 0; i < ArmorBarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+11); 
					X += BA_HealthBarCellspacing_PrivateReplace;
				}
				
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthBarCells_PrivateReplace - (HealthBarsToDraw + HealthFillupBarsToDraw + ArmorBarsToDraw); i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+11,1.4);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}	
				
				//DRaw health under armour 
				//Again, Health Offset_PrivateReplaces are now used for Armour, and vice versa!!!!!!!!!
				
				X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace;
				Y+=BA_ArmourBarYOffset_PrivateReplace;
				
				for (i = 0; i < HealthBarsToDraw; i++)
				{
					Canvas.DrawColor=HealthBlendColour;
					Canvas.DrawIcon(HealthCell,X,Y+11+BA_ArmourBarYOffset_PrivateReplace);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}
				
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthFillupBarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+11+BA_ArmourBarYOffset_PrivateReplace);
					X += BA_HealthBarCellspacing_PrivateReplace;
				}			




				
				//		/////////////////////////////////////////////////////////////////////////////////////////////
				//		
				//		//DRaw status under health
				//		//Again, Health Offset_PrivateReplaces are now used for Armour, and vice versa!!!!!!!!!
				//		
				//		X = VisualBoundsCenterX_PrivateReplace + BA_HealthBarXOffset_PrivateReplace;
				//		Y+=BA_ArmourBarYOffset_PrivateReplace;
				//		
				//		for (i = 0; i < ProgressBarsToDraw; i++)
				//		{
				//			Canvas.DrawColor=HealthBlendColour;
				//			Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace);
				//			X += BA_HealthBarCellspacing_PrivateReplace + BA_HealthBarCellspacing_PrivateReplace;
				//		}
				//		
				//		Canvas.DrawColor = ColorGreyedOut;
				//		for (i = 0; i < HealthFillupBarsToDraw; i++)
				//		{
				//			Canvas.DrawIcon(HealthCell,X,Y+BA_ArmourBarYOffset_PrivateReplace+BA_ArmourBarYOffset_PrivateReplace);
				//			X += BA_HealthBarCellspacing_PrivateReplace + BA_HealthBarCellspacing_PrivateReplace;
				//		}		
                //		
				//		////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
			}
		}
		else
		{
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace)
			{
				HealthCell = HealthCellRed_PrivateReplace;
			}
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace)
			{
				HealthCell = HealthCellYellow_PrivateReplace;
			}
			else 
			{
				HealthCell = HealthCellGreen_PrivateReplace;
			}
	
			BarsToDraw = RoundUp(TargetHealthPercent * float(HealthBarCells_PrivateReplace) );
		
			X = VisualBoundsCenterX_PrivateReplace + HealthBarXOffset_PrivateReplace;
	
	 		if (AnchorInfoTop_PrivateReplace)
			{
				Y = VisualBoundingBox_PrivateReplace.Min.Y+11 + HealthBarYOffset_PrivateReplace;
			}
			else
			{
				Y = VisualBoundingBox_PrivateReplace.Max.Y+11 + HealthBarYOffset_PrivateReplace;
			}
			
			if (TargetHealthPercent > 0) //Don't bother drawing anything if it's already dead  													////DONT  GO OVER 1000 HERE
			{
				for (i = 0; i < BarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+11);
					X += HealthBarCellspacing_PrivateReplace;
				}
		
				Canvas.DrawColor = ColorGreyedOut;
				for (i = 0; i < HealthBarCells_PrivateReplace - BarsToDraw; i++)
				{
					Canvas.DrawIcon(HealthCell,X,Y+11);
					X += HealthBarCellspacing_PrivateReplace;
				}
			}
		}

		if (TargetHealthPercent <= 0)
		{
			Canvas.DrawColor = ColorGreen; 
		if(ArmorHealthPercentTemp > 0)	X = VisualBoundsCenterX_PrivateReplace + BA_LabelXOffset_PrivateReplace;
		else
		X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace;
			Canvas.Font = LabelFont_PrivateReplace;
			Canvas.SetPos(X,Y+11,0);
			Canvas.DrawText("(Destroyed)");
		}	
		
	}

}
*/

function DrawHealthPercent()
{
	local float X,Y; //,f1,f2;
	local int iHealthPercent;
	
	//Also draws the health / armour icon if building armour is enabled.
	
	if(TargetHealthPercent <= 0)
		return;
	
	
		if (TargetNameTextSize.X - 4 < PercentXOffset_PrivateReplace)
		{
			X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace + PercentXOffset_PrivateReplace;
		}
		else
		{
			X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace + TargetNameTextSize.X;
		}
		
		if(TargetNameTextSize.X > 85) 
		{
			X += 18;
		}
	


	if (TargetHealthPercent != -1)
	{

		if (AnchorInfoTop_PrivateReplace)
			Y = VisualBoundingBox_PrivateReplace.Min.Y + PercentYOffset_PrivateReplace;
		else
			Y = VisualBoundingBox_PrivateReplace.Max.Y + PercentYOffset_PrivateReplace;
	
			
		if(bHasArmor)
		{	
	
		//Begin Align for building with armour 
		
			X = VisualBoundsCenterX_PrivateReplace + BA_PercentXOffset_PrivateReplace; //Screw what you were doing... we are here. 
		
		if (AnchorInfoTop_PrivateReplace)
			Y = VisualBoundingBox_PrivateReplace.Min.Y + BA_PercentYOffset_PrivateReplace;
		else
			Y = VisualBoundingBox_PrivateReplace.Max.Y + BA_PercentYOffset_PrivateReplace;
		
		//End align for building with armour
		
			
			Canvas.DrawColor = ColorBlue;	 
			Canvas.Font = PercentageFont_PrivateReplace;
			Canvas.SetPos(X-12,Y,0);
			
			Canvas.DrawColor = ColorWhite;	 //don't blend
			Canvas.DrawIcon(BA_ArmourIcon_PrivateReplace,X,Y+BA_HealthIconYOffset_PrivateReplace); //Draw armour icon, remember all Armour/Health Offset_PrivateReplaces are swapped
	
			X+=BA_IconToPercentSpacing_PrivateReplace; 
			
			Canvas.SetPos(X,Y,0);
			
					
			Canvas.DrawText(int(TargetArmorPercent*100) );// $ "%");
			
			//Canvas.StrLen(int((TargetHealthPercent/TargetHealthMaxPercent)*100) $ "%",f1,f2);
			//Canvas.SetPos(Canvas.CurX + f1,Y,0);
			
			/**if(int(TargetArmorPercent*10) <= 2)
				Canvas.DrawColor = ColorRed;
			else if(int(TargetArmorPercent*10) <= 5)
				Canvas.DrawColor = ColorYellow;	
			else */
			
			
			//Health under armour
			
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace*TargetHealthMaxPercent)
				Canvas.DrawColor = ColorRed;
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace*TargetHealthMaxPercent)
				Canvas.DrawColor = ColorYellow;
			else 
				Canvas.DrawColor = ColorGreen;
			
			Canvas.DrawIcon(BA_HealthIcon_PrivateReplace,X-BA_IconToPercentSpacing_PrivateReplace,Y+BA_ArmourIconYOffset_PrivateReplace);
			
			
			if(int((TargetHealthPercent/TargetHealthMaxPercent)*10) <= 2)
				Canvas.DrawColor = ColorRed;
			else if(int((TargetHealthPercent/TargetHealthMaxPercent)*10) <= 5)
				Canvas.DrawColor = ColorYellow;	
			else 
				Canvas.DrawColor = ColorGreen;		
			
			Canvas.SetPos(X,Y+BA_ArmourBarYOffset_PrivateReplace+BA_ArmourPercentYOffset_PrivateReplace,0);
			
			
			Canvas.DrawText(int((TargetHealthPercent/TargetHealthMaxPercent)*100)); //$ "%");
			
			
		} 
		else
		{
			if (TargetHealthPercent < HealthBarRedThreshold_PrivateReplace)
				Canvas.DrawColor = ColorRed;
			else if (TargetHealthPercent < HealthBarYellowThreshold_PrivateReplace)
				Canvas.DrawColor = ColorYellow;
			else 
				Canvas.DrawColor = ColorGreen;
	
			iHealthPercent = int(TargetHealthPercent * 100);
	
			Canvas.Font = PercentageFont_PrivateReplace;
			Canvas.SetPos(X,Y,0);
			Canvas.DrawText(iHealthPercent $ "%");
		}	
		
		/** Debug Info:
		Canvas.SetPos(X,Y+20,0);
		Canvas.DrawText(Rx_GRI(RenxHud.WorldInfo.Gri).buildingArmorPercentage $ "%");
		Canvas.DrawText(TargetHealthPercent $ "%");
		Canvas.DrawText(TargetHealthMaxPercent $ "%");
		Canvas.DrawText(TargetArmorPercent $ "%");
		Canvas.DrawText(ArmorHealthPercentTemp $ "%");
		Canvas.DrawText(Rx_Building(TargetedActor).GetHealth());
		Canvas.DrawText(Rx_Building(TargetedActor).GetMaxHealth());
		Canvas.DrawText(Rx_Building(TargetedActor).GetArmor());
		Canvas.DrawText(Rx_Building(TargetedActor).GetMaxArmor());
		*/
		
	}
}

private function int RoundUp(float f)
{
	local float Result;

	Result = int(f);

	if(f - Result > 0.0)
		Result += 1.0;

	return Result;
}

private function DrawTargetName()
{
	local float X,Y;
	if(!bHasArmor)
	{
		X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace;
	
	
	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + LabelYOffset_PrivateReplace;
		else
		Y = VisualBoundingBox_PrivateReplace.Max.Y + LabelYOffset_PrivateReplace;
	
	}
	else if(bHasArmor)
		{
			X = VisualBoundsCenterX_PrivateReplace + BA_LabelXOffset_PrivateReplace;
			
			if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + BA_LabelYOffset_PrivateReplace;
		else
		Y = VisualBoundingBox_PrivateReplace.Max.Y + BA_LabelYOffset_PrivateReplace;
		}
		
	if (TargetStance_PrivateReplace == STANCE_NEUTRAL)
		Canvas.DrawColor = ColorBlue;
	else if (TargetStance_PrivateReplace == STANCE_FRIENDLY)
		Canvas.DrawColor = ColorGreen;
	else
		Canvas.DrawColor = ColorRed;
	Canvas.Font = LabelFont_PrivateReplace;
	Canvas.SetPos(X,Y,0);
	Canvas.DrawText(TargetName);
	Canvas.TextSize(TargetName,TargetNameTextSize.X,TargetNameTextSize.Y);
}

private function DrawTargetDescription()
{
	local float X,Y;
	//X = VisualBoundsCenterX_PrivateReplace + DescriptionXOffset_PrivateReplace;

	if(!bHasArmor)
	{
	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + DescriptionYOffset_PrivateReplace;
	else
		Y = VisualBoundingBox_PrivateReplace.Max.Y + DescriptionYOffset_PrivateReplace;
	}
	else if(bHasArmor)
	{
	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + BA_DescriptionYOffset_PrivateReplace;
	else
		Y = VisualBoundingBox_PrivateReplace.Max.Y + BA_DescriptionYOffset_PrivateReplace;	
		
	}
	
	
	
	if (TargetStance_PrivateReplace == STANCE_NEUTRAL)
		Canvas.DrawColor = ColorBlue;
	else if (TargetStance_PrivateReplace == STANCE_FRIENDLY)
		Canvas.DrawColor = ColorGreen;
	else
		Canvas.DrawColor = ColorRed;
	Canvas.Font = DescriptionFont_PrivateReplace;
	Canvas.TextSize(TargetDescription, TargetDescriptionTextSize.X, TargetDescriptionTextSize.Y, DescriptionXScale, DescriptionYScale);
	X = VisualBoundsCenterX_PrivateReplace - TargetDescriptionTextSize.X/2;
	Canvas.SetPos(X,Y,0);
	Canvas.DrawText(TargetDescription,,DescriptionXScale,DescriptionYScale);
}

function bool TargetedHasVeterancy()
{
	return TargetedActor != None && (Rx_Pawn(TargetedActor) != none || Rx_Vehicle(TargetedActor) != none);
}

private function DrawTeamLogo()
{
	local float X,Y;
	local byte VRank, StanceToDraw; //0:FRIENDLY, 1: ENEMY, 2: NEUTRAL
 	
	if(Rx_Pawn(TargetedActor) != none ) VRank = Rx_Pawn(TargetedActor).VRank; 
	else
	if(Rx_Vehicle(TargetedActor) != none ) VRank = Rx_Vehicle(TargetedActor).VRank; 
	
	if(bHasArmor)
	{
			
			X = VisualBoundsCenterX_PrivateReplace + BA_LogoXOffset_PrivateReplace - BA_BuildingIcon_GDI_Friendly.UL;
			
		if (AnchorInfoTop_PrivateReplace)
			Y = VisualBoundingBox_PrivateReplace.Min.Y + BA_LogoYOffset_PrivateReplace;
		else
			Y = VisualBoundingBox_PrivateReplace.Max.Y + BA_LogoYOffset_PrivateReplace;
		Canvas.DrawColor.A=200;
		if (TargetStance_PrivateReplace == STANCE_ENEMY && TargetedActor.GetTeamNum() == TEAM_NOD)
			Canvas.DrawIcon(BA_BuildingIcon_Nod_Enemy,X,Y);
		else if (TargetStance_PrivateReplace == STANCE_ENEMY && TargetedActor.GetTeamNum() == TEAM_GDI)
			Canvas.DrawIcon(BA_BuildingIcon_GDI_Enemy,X,Y);
		else if (TargetStance_PrivateReplace == STANCE_FRIENDLY && TargetedActor.GetTeamNum() == TEAM_NOD)
		{
			// spy addition, spy should have same boundingbox+icon
			if (Rx_Pawn(TargetedActor) != none && Rx_Pawn(TargetedActor).isSpy())
			{
				if(TargetedActor.GetTeamNum() == RenxHud.PlayerOwner.GetTeamNum())
					Canvas.DrawIcon(BA_BuildingIcon_Nod_Friendly,X,Y);
				else
					Canvas.DrawIcon(BA_BuildingIcon_GDI_Friendly,X,Y);
			}
			else
				Canvas.DrawIcon(BA_BuildingIcon_Nod_Friendly,X,Y);
		}
		
		else if (TargetStance_PrivateReplace == STANCE_FRIENDLY && TargetedActor.GetTeamNum() == TEAM_GDI)
		
		{
			// spy addition, spy should have same boundingbox+icon
			if (Rx_Pawn(TargetedActor) != none && Rx_Pawn(TargetedActor).isSpy())
			{
				if(TargetedActor.GetTeamNum() == RenxHud.PlayerOwner.GetTeamNum())
					Canvas.DrawIcon(GDIFriendlyIcon,X,Y);
				else
					Canvas.DrawIcon(NodFriendlyIcon,X,Y);
			}
			else
				Canvas.DrawIcon(BA_BuildingIcon_GDI_Friendly,X,Y);	
		}
	}
	else if(!bHasArmor)
	{
		X = VisualBoundsCenterX_PrivateReplace + LogoXOffset_PrivateReplace - NeutralIcon.UL;
		if (AnchorInfoTop_PrivateReplace)
			Y = VisualBoundingBox_PrivateReplace.Min.Y + LogoYOffset_PrivateReplace;
		else
			Y = VisualBoundingBox_PrivateReplace.Max.Y + LogoYOffset_PrivateReplace;
		
		if (TargetStance_PrivateReplace == STANCE_ENEMY && TargetedActor.GetTeamNum() == TEAM_NOD)
		{
		Canvas.DrawIcon(NodEnemyIcon,X,Y);	
		StanceToDraw=1;
		}
			
		else if (TargetStance_PrivateReplace == STANCE_ENEMY && TargetedActor.GetTeamNum() == TEAM_GDI)
		{
			Canvas.DrawIcon(GDIEnemyIcon,X,Y);
			StanceToDraw=1;
		}
			
		else if (TargetStance_PrivateReplace == STANCE_FRIENDLY && TargetedActor.GetTeamNum() == TEAM_NOD)
		{
			// spy addition, spy should have same boundingbox+icon
			if (Rx_Pawn(TargetedActor) != none && Rx_Pawn(TargetedActor).isSpy())
			{
				if(TargetedActor.GetTeamNum() == RenxHud.PlayerOwner.GetTeamNum())
				{
					Canvas.DrawIcon(NodFriendlyIcon,X,Y);
					StanceToDraw=0;
				}
					
				else
				{
					Canvas.DrawIcon(GDIFriendlyIcon,X,Y);
					StanceToDraw=0;
				}
					
			}
			else
			{
					Canvas.DrawIcon(NodFriendlyIcon,X,Y);
					StanceToDraw=0;
			}
			
		}
		else if (TargetStance_PrivateReplace == STANCE_FRIENDLY && TargetedActor.GetTeamNum() == TEAM_GDI)
		{
			// spy addition, spy should have same boundingbox+icon
			if (Rx_Pawn(TargetedActor) != none && Rx_Pawn(TargetedActor).isSpy())
			{
				if(TargetedActor.GetTeamNum() == RenxHud.PlayerOwner.GetTeamNum())
				{
					Canvas.DrawIcon(GDIFriendlyIcon,X,Y);
					StanceToDraw=0;
				}
				else
				{
					Canvas.DrawIcon(NodFriendlyIcon,X,Y);
					StanceToDraw=0;
				}
					
			}
			else
			{
				Canvas.DrawIcon(GDIFriendlyIcon,X,Y);
				StanceToDraw=0;
			}
				
		}
		else
		{
			Canvas.DrawIcon(NeutralIcon,X,Y);
			StanceToDraw=2;
		}
			
		//Draw veteran icon placeholder 
	if(TargetedHasVeterancy())
	{
		
		Y+=VetLogoYOffset_PrivateReplace;
		if (TargetNameTextSize.X - 4 < VetLogoXOffset_PrivateReplace)
		{
			X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace + PercentXOffset_PrivateReplace - 42 ;
			//X+=VetLogoXOffset_PrivateReplace; 
		}
		else
		{
			X = VisualBoundsCenterX_PrivateReplace + LabelXOffset_PrivateReplace + TargetNameTextSize.X - 42;
			//X+= TargetNameTextSize.X + 14;
		}
		
		if(TargetNameTextSize.X > 85) 
		{
			X += 18;
		}
		
		if(StanceToDraw == 0) 
		{
			switch (VRank)
			{
				case 0: 
				Canvas.DrawIcon(Friendly_Recruit, X, Y);
				break;
				case 1: 
				Canvas.DrawIcon(Friendly_Veteran, X, Y);
				break;
				case 2: 
				Canvas.DrawIcon(Friendly_Elite, X, Y);
				break;
				case 3: 
				Canvas.DrawIcon(Friendly_Heroic, X, Y);
				break;
			}
		}
		else 
		if(StanceToDraw == 1) 
		{
			switch (VRank)
			{
				case 0: 
				Canvas.DrawIcon(Enemy_Recruit, X, Y);
				break;
				case 1: 
				Canvas.DrawIcon(Enemy_Veteran, X, Y);
				break;
				case 2: 
				Canvas.DrawIcon(Enemy_Elite, X, Y);
				break;
				case 3: 
				Canvas.DrawIcon(Enemy_Heroic, X, Y);
				break;
			}
		}
		else 
		{
			switch (VRank)
			{
				case 0: 
				Canvas.DrawIcon(Neutral_Recruit, X, Y);
				break;
				case 1: 
				Canvas.DrawIcon(Neutral_Veteran, X, Y);
				break;
				case 2: 
				Canvas.DrawIcon(Neutral_Elite, X, Y);
				break;
				case 3: 
				Canvas.DrawIcon(Neutral_Heroic, X, Y);
				break;
			}
		}
	}
		//Building Armour enabled, and building targeted. 
	}	
}



private function DrawInfoBackground()
{
	local float X,Y;
	local CanvasIcon Icon;

	X = VisualBoundsCenterX_PrivateReplace - InfoBackdropNeutral_PrivateReplace.UL/2 + BackgroundXOffset_PrivateReplace;

	if (AnchorInfoTop_PrivateReplace)
		Y = VisualBoundingBox_PrivateReplace.Min.Y + BackgroundYOffset_PrivateReplace;
	else
		Y = VisualBoundingBox_PrivateReplace.Max.Y + BackgroundYOffset_PrivateReplace;

	if(!bHasArmor)
	{
	if (TargetStance_PrivateReplace == STANCE_NEUTRAL)
		Icon = InfoBackdropNeutral_PrivateReplace;
	else if (TargetStance_PrivateReplace == STANCE_FRIENDLY)
		Icon = InfoBackdropFriendly_PrivateReplace;
	else
		Icon = InfoBackdropEnemy_PrivateReplace;
	}
	
	else if(bHasArmor)
	
	{
		
	if (TargetStance_PrivateReplace == STANCE_NEUTRAL)
		Icon = BA_InfoBackdropFriendly_PrivateReplace;
	else if (TargetStance_PrivateReplace == STANCE_FRIENDLY)
		Icon = BA_InfoBackdropFriendly_PrivateReplace;
	else
		Icon = BA_InfoBackdropEnemy_PrivateReplace;
		
	}
	
	if (TargetDescription == "")
		Canvas.DrawIcon(Icon,X,Y);
	else
	{
		Canvas.SetPos(X,Y);
		if (TargetedHasVeterancy())
			Canvas.DrawTileStretched(Icon.Texture, Abs(Icon.UL) + Friendly_Veteran.UL + 10, Abs(Icon.VL) * 1.25, Icon.U, Icon.V, Icon.UL, Icon.VL,, true, true);
		else
			Canvas.DrawTileStretched(Icon.Texture, Abs(Icon.UL), Abs(Icon.VL) * 1.25, Icon.U, Icon.V, Icon.UL, Icon.VL,, true, true);
	}
}

private function UpdateTargetStance(Actor inActor)
{
	if (Rx_Pawn(inActor) != none && Rx_Pawn(inActor).isSpy()) // spies always show friendly
		TargetStance_PrivateReplace = STANCE_FRIENDLY;
	else
		TargetStance_PrivateReplace = GetStance(inActor);
}

function int GetAttachmentBuildingMaxHealth(Rx_BuildingAttachment BAttachment){

	if (BAttachment.OwnerBuilding != none)
	{
		return BAttachment.OwnerBuilding.GetMaxHealth();
	}
}
function int GetAttachmentBuildingTrueMaxHealth(Rx_BuildingAttachment BAttachment){

	if (BAttachment.OwnerBuilding != none)
	{
		return BAttachment.OwnerBuilding.GetTrueMaxHealth();
	}
}
function int GetAttachmentBuildingArmor(Rx_BuildingAttachment BAttachment){

	if (BAttachment.OwnerBuilding != none)
	{
		return BAttachment.OwnerBuilding.GetArmor();
	}
}
function int GetAttachmentBuildingMaxArmor(Rx_BuildingAttachment BAttachment){

	if (BAttachment.OwnerBuilding != none)
	{
		return BAttachment.OwnerBuilding.GetMaxArmor();
	}
}
function bool GetAttachmentBuildingbNoPower(Rx_Building_Team_Internals BAttachment){

	if (BAttachment != none)
	{
		return BAttachment.bNoPower;
	}
}
function bool GetAttachmentBuildingHealthLocked(Rx_Building_Team_Internals BAttachment){

	if (BAttachment != none)
	{
		return BAttachment.HealthLocked;
	}

}




















DefaultProperties
{
	ColorPurple=(R=102,G=0,B=102,A=200)

	// Doesn't let the targeting box get closer than this from the top, or sides of the screen.
	ScreenEdgePadding_PrivateReplace = 50
	// Doesn't let the targeting box get closer than this from the bottom of the screen.
	ScreenBottomPadding_PrivateReplace = 200
	// How many pixels larger than the actual bounding box to make the drawn bounding box.
	BoundingBoxPadding_PrivateReplace = 15


	TargetStickTime = 3.0f
	TargetBoxAnimTime = 0.1f

	// Max screen size (percentage) that the target box is allowed to be.
	MaxTargetBoxSizePctX_PrivateReplace =0.5
	MaxTargetBoxSizePctY_PrivateReplace =0.5

	// If true, anchor's the target info above the bounding box, false anchors it below.
	AnchorInfoTop_PrivateReplace = true
	// Y Offset_PrivateReplace of background image
	BackgroundXOffset_PrivateReplace = -3
	BackgroundYOffset_PrivateReplace = -55

	// Offset_PrivateReplace of team logo
	LogoXOffset_PrivateReplace = -41
	LogoYOffset_PrivateReplace = -55
	// Offset_PrivateReplace of the interaction symbol
	InteractXOffset_PrivateReplace = 0
	InteractYOffset_PrivateReplace = -30
	// Offset_PrivateReplace of healthbar
	HealthBarXOffset_PrivateReplace = -64
	HealthBarYOffset_PrivateReplace = -24
	// Spacing how far over to draw each health bar cell
	HealthBarCellspacing_PrivateReplace = 6;
	// How many cells to draw at full health
	HealthBarCells_PrivateReplace = 20
	// When the health is below this (out of 1) does it draw red.
	HealthBarRedThreshold_PrivateReplace = 0.2
	// When the health is below this (out of 1) does it draw yellow.
	HealthBarYellowThreshold_PrivateReplace = 0.5

	// Offset_PrivateReplace for target's name
	LabelXOffset_PrivateReplace = -58
	LabelYOffset_PrivateReplace = -35

	// Offset_PrivateReplace for the health percentage display
	PercentXOffset_PrivateReplace = 96		// 55		// -15
	PercentYOffset_PrivateReplace = -35		// -35		// -15

	// Offset_PrivateReplace for target's description
	DescriptionXOffset_PrivateReplace = -58
	DescriptionYOffset_PrivateReplace = -12

	DescriptionXScale=1
	DescriptionYScale=0.9

	LabelFont_PrivateReplace = Font'RenXTargetSystem.T_TargetSystemLabel'
	PercentageFont_PrivateReplace = Font'RenXTargetSystem.T_TargetSystemPercentage'
	DescriptionFont_PrivateReplace = Font'RenXTargetSystem.T_TargetSystemLabel'

	BoundingBoxNeutralTopLeft_PrivateReplace =    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_BoundingCorner', U= 0, V = 0, UL = 32, VL=32)
	BoundingBoxNeutralTopRight_PrivateReplace=    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_BoundingCorner', U= 32, V = 0, UL = -32, VL=0)
	BoundingBoxNeutralBottomLeft_PrivateReplace=  (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_BoundingCorner', U= 0, V = 32, UL = 0, VL=-32)
	BoundingBoxNeutralBottomRight_PrivateReplace= (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_BoundingCorner', U= -32, V = -32, UL = -32, VL=-32)

	BoundingBoxFriendlyTopLeft_PrivateReplace =    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_BoundingCorner', U= 0, V = 0, UL = 32, VL=32)
	BoundingBoxFriendlyTopRight_PrivateReplace=    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_BoundingCorner', U= 32, V = 0, UL = -32, VL=0)
	BoundingBoxFriendlyBottomLeft_PrivateReplace=  (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_BoundingCorner', U= 0, V = 32, UL = 0, VL=-32)
	BoundingBoxFriendlyBottomRight_PrivateReplace= (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_BoundingCorner', U= -32, V = -32, UL = -32, VL=-32)

	BoundingBoxEnemyTopLeft_PrivateReplace =    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_BoundingCorner', U= 0, V = 0, UL = 32, VL=32)
	BoundingBoxEnemyTopRight_PrivateReplace=    (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_BoundingCorner', U= 32, V = 0, UL = -32, VL=0)
	BoundingBoxEnemyBottomLeft_PrivateReplace=  (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_BoundingCorner', U= 0, V = 32, UL = 0, VL=-32)
	BoundingBoxEnemyBottomRight_PrivateReplace= (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_BoundingCorner', U= -32, V = -32, UL = -32, VL=-32)

	InfoBackdropFriendly_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_BackDrop', U= 0, V = 0, UL = 256, VL = 64)
	InfoBackdropEnemy_PrivateReplace    = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_BackDrop', U= 0, V = 0, UL = 256, VL = 64)
	InfoBackdropNeutral_PrivateReplace  = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_BackDrop', U= 0, V = 0, UL = 256, VL = 64)

	GDIEnemyIcon = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_GDI', U= 0, V = 0, UL = 64, VL = 64)
	GDIFriendlyIcon= (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_GDI', U= 0, V = 0, UL = 64, VL = 64)
	NodEnemyIcon = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_Nod', U= 0, V = 0, UL = 64, VL = 64)
	NodFriendlyIcon = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_Nod', U= 0, V = 0, UL = 64, VL = 64)
	NeutralIcon = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_Empty', U= 0, V = 0, UL = 64, VL = 64)
	
	Friendly_Recruit = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_Recruit', U= 0, V = 0, UL = 64, VL = 64)
	Friendly_Veteran = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_Veteran', U= 0, V = 0, UL = 64, VL = 64)
	Friendly_Elite = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_Elite', U= 0, V = 0, UL = 64, VL = 64)
	Friendly_Heroic = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Friendly_Heroic', U= 0, V = 0, UL = 64, VL = 64)
	
	Enemy_Recruit = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_Recruit', U= 0, V = 0, UL = 64, VL = 64)
	Enemy_Veteran = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_Veteran', U= 0, V = 0, UL = 64, VL = 64)
	Enemy_Elite = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_Elite', U= 0, V = 0, UL = 64, VL = 64)
	Enemy_Heroic = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Enemy_Heroic', U= 0, V = 0, UL = 64, VL = 64)
	
	Neutral_Recruit = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_Recruit', U= 0, V = 0, UL = 64, VL = 64)
	Neutral_Veteran = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_Veteran', U= 0, V = 0, UL = 64, VL = 64)
	Neutral_Elite = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_Elite', U= 0, V = 0, UL = 64, VL = 64)
	Neutral_Heroic = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_Neutral_Heroic', U= 0, V = 0, UL = 64, VL = 64)
	
	HealthCellGreen_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_HealthBar_Single_Green', U= 0, V = 0, UL = 16, VL = 16)
	HealthCellYellow_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_HealthBar_Single_Yellow', U= 0, V = 0, UL = 16, VL = 16)
	HealthCellRed_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_TargetSystem_HealthBar_Single_Red', U= 0, V = 0, UL = 16, VL = 16)
	ArmorCellBlue_PrivateReplace = (Texture = Texture2D'renxtargetsystem.T_TargetSystem_ArmorBar_Single_Blue', U= 0, V = 0, UL = 16, VL = 16)
	Interact_PrivateReplace = (Texture = Texture2D'renxtargetsystem.T_TargetSystem_Interact', U= 0, V = 0, UL = 32, VL = 64)
	
//Building Armour specific Icons (If it really doesn't look right with the larger health cells.)
BA_HealthCellIcon_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Bar_Health', U= 0, V = 0, UL = 16, VL = 16)
BA_ArmourCellIcon_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Bar_Armour', U= 0, V = 0, UL = 16, VL = 16)
BA_HealthIcon_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Icon_Health', U= 0, V = 0, UL = 32, VL = 32)
BA_ArmourIcon_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Icon_Armour', U= 0, V = 0, UL = 32, VL = 32)	

BA_BuildingIcon_GDI_Friendly = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Logo_GDI_Friendly', U= 0, V = 0, UL = 64, VL = 64)	
BA_BuildingIcon_Nod_Friendly = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Logo_Nod_Friendly', U= 0, V = 0, UL = 64, VL = 64)	

BA_BuildingIcon_GDI_Enemy = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Logo_GDI_Enemy', U= 0, V = 0, UL = 64, VL = 64)	
BA_BuildingIcon_Nod_Enemy = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Logo_Nod_Enemy', U= 0, V = 0, UL = 64, VL = 64)	

BA_InfoBackdropFriendly_PrivateReplace = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Backdrop_Friendly', U= 0, V = 0, UL = 256, VL = 64)
BA_InfoBackdropEnemy_PrivateReplace    = (Texture = Texture2D'RenXTargetSystem.T_HUD_Targetting_Building_Backdrop_Enemy', U= 0, V = 0, UL = 256, VL = 64)


//IMPORTANT!!! SWAP ALL "HEALTH" AND "ARMOUR" Offset_PrivateReplaceS. Armour was originally drawn beneath health. 

BA_HealthBarXOffset_PrivateReplace = -32
BA_HealthBarYOffset_PrivateReplace = -32

BA_ArmourBarXOffset_PrivateReplace= -64
BA_ArmourBarYOffset_PrivateReplace = 5

BA_LabelXOffset_PrivateReplace = -50
BA_LabelYOffset_PrivateReplace = -46
BA_IconsXOffset_PrivateReplace = 0
BA_IconsYOffset_PrivateReplace = 0 	
BA_PercentXOffset_PrivateReplace = -64		// 55		// -15
BA_PercentYOffset_PrivateReplace = -34		// -35		// -15
// Offset_PrivateReplace for target's description
BA_DescriptionXOffset_PrivateReplace = -58
BA_DescriptionYOffset_PrivateReplace = -12

BA_BackgroundXOffset_PrivateReplace = -3
BA_BackgroundYOffset_PrivateReplace = -55
// Offset_PrivateReplace of team logo
BA_LogoXOffset_PrivateReplace = -41
BA_LogoYOffset_PrivateReplace = -55

BA_HealthBarCellspacing_PrivateReplace = 4
BA_IconToPercentSpacing_PrivateReplace = 20
BA_ArmourIconYOffset_PrivateReplace = 4
BA_HealthIconYOffset_PrivateReplace = -7 
BA_ArmourPercentYOffset_PrivateReplace = 8
//End Building armour specific variables. Will likely undo these once it is confirmed that nothing needs to be moved around anymore
	InteractFont_PrivateReplace = Font'RenXHud.Font.PlayerName'

	InteractIconBobAmplitude_PrivateReplace = 5.0f;
	InteractIconBobFrequency_PrivateReplace = 4.0f;

VetLogoXOffset_PrivateReplace = 100
VetLogoYOffset_PrivateReplace = -4
	

}
