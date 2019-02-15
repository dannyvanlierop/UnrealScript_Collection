class Ukill_GFxPurchaseMenu extends Rx_GFxPurchaseMenu;

var PTVehicleBlock GDIVehicleMenuData2[9];
var PTVehicleBlock NodVehicleMenuData2[9];
var private class<Rx_FamilyInfo> OwnedFamilyInfo;
var private class<Rx_Weapon> OwnedSidearm, OwnedExplosive, OwnedItem;
var Rx_CapturableMCT_Fort Fort;//Ukill
var Rx_CapturableMCT_MC MC;//Ukill
var GFxClikWidget VehicleMenuButton2[9];
var Ukill_PT_Vehicle DummyVehicle2;
var Ukill_PT_Pawn DummyPawn2;

/*
function AssignButtonData(GFxClikWidget widget, PTMenuBlock menuData, byte i)
{
	local GFxObject Type;

	//if (i == menuData.ID) {
		widget.SetString("hotkeyLabel", menuData.hotkey);
		widget.SetString("data", "" $ menuData.ID);
		widget.SetString("label", menuData.title);

		//if this is engineer type, display repair bar instead.
		if (menuData.title == "ENGINEER" || menuData.title == "HOTWIRE" || menuData.title == "TECHNICIAN") {
			widget.SetBool("isDamageBar", false);
		}
		//widget.SetString("Group", menuData.Group);
		switch (menuData.BlockType)
		{
			case EPBT_MENU:
				widget.SetString("costLabel", "MENU");
				widget.SetBool("toggle", false);
				break;
			case EPBT_CLASS:
				if (rxPurchaseSystem.GetClassPrices(TeamID, menuData.ID) > 0) {
					widget.SetString("costLabel", "$" $ rxPurchaseSystem.GetClassPrices(TeamID, menuData.ID));
				} else {
					widget.SetString("costLabel", "FREE");
				}
				widget.SetBool("toggle", true);
				break;
			case EPBT_ITEM:
				if (rxPurchaseSystem.GetItemPrices(TeamID, menuData.ID) > 0) {
					widget.SetString("costLabel", "$" $ rxPurchaseSystem.GetItemPrices(TeamID, menuData.ID));
				} else {
					widget.SetString("costLabel", "FREE");
				}
				widget.SetBool("toggle", true);
				break;
			case EPBT_WEAPON:
				if (rxPurchaseSystem.GetWeaponPrices(TeamID, menuData.ID) > 0) {
					widget.SetString("costLabel", "$" $ rxPurchaseSystem.GetWeaponPrices(TeamID, menuData.ID));
				} else {
					widget.SetString("costLabel", "FREE");
				}
				widget.SetBool("toggle", true);
				break;
		}
		//[VEHICLE COUNT]
		Type = widget.GetObject("type");
		Type.GotoAndStopI(menuData.type);
		Type.GetObject("icon").GotoAndStopI(menuData.iconID);

		//the following is the test
		LoadTexture("img://" $ PathName(menuData.PTIconTexture), Type.GetObject("icon"));
		//end test

		if (menuData.title == "VEHICLES" || menuData.title == "CHARACTERS") {
			widget.SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, menuData.title, rxPC));
			if (menuData.title == "VEHICLES") {
				widget.SetString("vehicleCountLabel", "( "$ VehicleCount $ " )");
			}
		} else {
			widget.SetString("sublabel", menuData.desc);
		}
		if (menuData.type == 2) {
			Type.GetObject("DamageBar").GotoAndStopI(menuData.damage + 1);
			Type.GetObject("RangeBar").GotoAndStopI(menuData.range + 1);
			Type.GetObject("RoFBar").GotoAndStopI(menuData.rateOfFire + 1);
			Type.GetObject("MagCapBar").GotoAndStopI(menuData.magCap + 1);
		}

		widget.SetBool("enabled", menuData.bEnable);
		//hide anything that is disabled
		if (!menuData.bEnable) {
			widget.SetBool("visible", menuData.bEnable);
		}

		if (!rxPurchaseSystem.AreSilosCaptured(TeamID)) {
			if (menuData.bSilo) {
				widget.SetBool("enabled", false);
			}
		}
}
*/
function SetSelectedButtonByIndex (int index, optional bool selected = true)
{
	`log("<PT Log> Button Selected Index? " $ Index);
	if (bMainDrawerOpen) {
		if (index < 5) {
			MainMenuGroup.ActionScriptVoid("setSelectedButtonByIndex");
		}
		return;
	}
	if (bClassDrawerOpen) {
		ClassMenuGroup.ActionScriptVoid("setSelectedButtonByIndex");
		return;
	}
	//Ukillweapon
	/**if (bWeaponDrawerOpen) {
		if (index < 9) {
			WeaponMenuGroup.ActionScriptVoid("setSelectedButtonByIndex");
		}
		return;
	}*/
	
	if (bItemDrawerOpen) {
		if (index < 8){
			ItemMenuGroup.ActionScriptVoid("setSelectedButtonByIndex");
		}
		return;
	}
	if (bVehicleDrawerOpen) {
		if (index < 9) {
			VehicleMenuGroup.ActionScriptVoid("setSelectedButtonByIndex");
		}
		return;
	}
}

function RemoveWidgetEvents()
{
	local byte i;

	for (i = 0; i < 9; i ++)
	{

		MainMenuButton[i].RemoveAllEventListeners("CLIK_buttonClick");
		MainMenuButton[i].RemoveAllEventListeners("buttonClick");
		ClassMenuButton[i].RemoveAllEventListeners("CLIK_buttonClick");
		ClassMenuButton[i].RemoveAllEventListeners("buttonClick");
		ItemMenuButton[i].RemoveAllEventListeners("CLIK_buttonClick");
		ItemMenuButton[i].RemoveAllEventListeners("buttonClick");
		//Ukillweapon
		//WeaponMenuButton[i].RemoveAllEventListeners("CLIK_buttonClick");
		//WeaponMenuButton[i].RemoveAllEventListeners("buttonClick");
	}
	for (i = 0; i < 9; i ++)
	{
		VehicleMenuButton2[i].RemoveAllEventListeners("CLIK_buttonClick");
		VehicleMenuButton2[i].RemoveAllEventListeners("buttonClick");
	}
	
	ExitButton.RemoveAllEventListeners("CLIK_buttonClick");
	ExitButton.RemoveAllEventListeners("buttonClick");
	BackButton.RemoveAllEventListeners("CLIK_buttonClick");
	BackButton.RemoveAllEventListeners("buttonClick");
	PurchaseButton.RemoveAllEventListeners("CLIK_buttonClick");
	PurchaseButton.RemoveAllEventListeners("buttonClick");

	EquipSideArmButton.RemoveAllEventListeners("CLIK_buttonClick");
	EquipSideArmButton.RemoveAllEventListeners("buttonClick");
	EquipSideArmList.RemoveAllEventListeners("CLIK_itemClick");
	EquipSideArmList.RemoveAllEventListeners("itemClick");
	EquipExplosivesButton.RemoveAllEventListeners("CLIK_buttonClick");
	EquipExplosivesButton.RemoveAllEventListeners("buttonClick");
	EquipExplosivesList.RemoveAllEventListeners("CLIK_itemClick");
	EquipExplosivesList.RemoveAllEventListeners("itemClick");

	
}
function AddWidgetEvents()
{
	local byte i;

	for (i = 0; i < 10; i ++)
	{
		if (MainMenuButton[i].GetBool("enabled")){
			MainMenuButton[i].AddEventListener('CLIK_buttonClick', OnPTButtonClick);
		}
		if (ClassMenuButton[i].GetBool("enabled")){
			ClassMenuButton[i].AddEventListener('CLIK_buttonClick', OnPTButtonClick);
		}
		if (ItemMenuButton[i].GetBool("enabled")){
			ItemMenuButton[i].AddEventListener('CLIK_buttonClick', OnPTButtonClick);
		}
		//Ukillweapon
		/**if (WeaponMenuButton[i].GetBool("enabled")){
			WeaponMenuButton[i].AddEventListener('CLIK_buttonClick', OnPTButtonClick);
		}*/
	}
	for (i = 0; i < 9; i ++)
	{
		if (VehicleMenuButton2[i].GetBool("enabled")){
			VehicleMenuButton2[i].AddEventListener('CLIK_buttonClick', OnPTButtonClick);
		}
	}

	//bottom drawer 
	ExitButton.AddEventListener('CLIK_buttonClick', OnExitButtonClick);
	BackButton.AddEventListener('CLIK_buttonClick', OnBackButtonClick);
	PurchaseButton.AddEventListener('CLIK_buttonClick', OnPurchaseButtonClick);
	EquipSideArmButton.AddEventListener('CLIK_buttonClick', OnEquipButtonClick);
	EquipSideArmList.AddEventListener('CLIK_itemClick', OnEquipSideArmListItemClick);
	EquipExplosivesButton.AddEventListener('CLIK_buttonClick', OnEquipButtonClick);
	EquipExplosivesList.AddEventListener('CLIK_itemClick', OnExplosivesListItemClick);

}

function SelectMenu(int selectedIndex)
{
	if (selectedIndex != Clamp(selectedIndex, 0, 9) || bIsInTransition) {
		return;
	}
`log("---------------" @ selectedIndex @ "---------------");

	switch (selectedIndex)
	{
		case 0: 
			
			/*if (bMainDrawerOpen) {
				if (GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')) != none) {
					GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')).SetBool("selected", false);
				}

				//check if there is something transitioning, fade out immidietly
				CancelCurrentAnimations();
				//if (EquipmentDrawer.GetInt("currentFrame") != 20 && bEquipmentDrawerOpen) {
				//	EquipmentDrawer.GotoAndPlay("Fade Out");
				//} 

				bIsInTransition = true;								
				MainDrawerFadeOut();
				//EquipmentDrawerFadeOut();
				WeaponDrawerFadeIn();
				BottomWidgetFadeIn(BackTween);
				bIsInTransition = false;
			} else*/ if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[9].ID : NodClassMenuData[9].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;		
		case 1: 
			if (bMainDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIMainMenuData[selectedIndex-1].ID : NodMainMenuData[selectedIndex - 1].ID);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 2: 
			if (bMainDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIMainMenuData[selectedIndex-1].ID : NodMainMenuData[selectedIndex - 1].ID);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 3: 
			if (bMainDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIMainMenuData[selectedIndex-1].ID : NodMainMenuData[selectedIndex - 1].ID);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 4: 
			if (bMainDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIMainMenuData[selectedIndex-1].ID : NodMainMenuData[selectedIndex - 1].ID);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 5: 
			if (bMainDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIMainMenuData[selectedIndex-1].ID : NodMainMenuData[selectedIndex - 1].ID);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 6: 
			if (bMainDrawerOpen) {
				rxPC.PlaySound(SoundCue'RenXPurchaseMenu.Sounds.RenXPTSoundRefill');
				
				//set the current weapon to defaults so we can force perform our loadouts
		
				if (rxPC.CurrentSidearmWeapon == none) {
					//rxPC.CurrentSidearmWeapon = class<Rx_InventoryManager>(rxPC.Pawn.InventoryManagerClass).default.SidearmWeapons[0];
					rxPC.CurrentSidearmWeapon = class'Rx_InventoryManager'.default.SidearmWeapons[0];
				}
				
				//`log("<PT Log> rxPC.CurrentExplosiveWeapon? " $ rxPC.CurrentExplosiveWeapon);
				if (rxPC.CurrentExplosiveWeapon == none) {
					if (rxPC.bJustBaughtEngineer 
					|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Hotwire' 
					|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Technician'){
						rxPC.RemoveAllExplosives();
						//class<Rx_InventoryManager>(rxPC.Pawn.InventoryManagerClass).default.ExplosiveWeapons[0]
						if (TeamID == TEAM_GDI) {
							rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager_GDI_Hotwire'.default.ExplosiveWeapons[0];
						} else {
							rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager_Nod_Technician'.default.ExplosiveWeapons[0];
						}
						//`log("<PT Log> new rxPC.CurrentExplosiveWeapon? " $ rxPC.CurrentExplosiveWeapon);
						rxPC.SetAdvEngineerExplosives(rxPC.CurrentExplosiveWeapon);
					} else if (rxPC.bJustBaughtHavocSakura 
					|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Havoc'
					|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Sakura' ) {
						rxPC.RemoveAllExplosives();
						//rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager'.default.ExplosiveWeapons[0];
						if (TeamID == TEAM_GDI) {
							rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager_GDI_Havoc'.default.ExplosiveWeapons[0];
						} else {
							rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager_Nod_Sakura'.default.ExplosiveWeapons[0];
						}
						//`log("<PT Log> new rxPC.CurrentExplosiveWeapon? " $ rxPC.CurrentExplosiveWeapon);
						rxPC.AddExplosives(rxPC.CurrentExplosiveWeapon);
					}  else {
						rxPC.RemoveAllExplosives();
						rxPC.CurrentExplosiveWeapon = class'Rx_InventoryManager'.default.ExplosiveWeapons[0];
						//`log("<PT Log> new rxPC.CurrentExplosiveWeapon? " $ rxPC.CurrentExplosiveWeapon);
						rxPC.AddExplosives(rxPC.CurrentExplosiveWeapon);
					}
				}

				SetLoadout();
				rxPC.PerformRefill(rxPC);
				rxPC.SwitchWeapon(0);
				ClosePTMenu(false);
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
					ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		/**case 7: 
			if (bMainDrawerOpen) {
				if (GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')) != none) {
					GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')).SetBool("selected", false);
				}

				/check if there is something transitioning, fade out immidietly
				CancelCurrentAnimations();
				if (EquipmentDrawer.GetInt("currentFrame") != 20 && bEquipmentDrawerOpen) {
					EquipmentDrawer.GotoAndPlay("Fade Out");
				} 

				bIsInTransition = true;								
				MainDrawerFadeOut();
				EquipmentDrawerFadeOut();
				WeaponDrawerFadeIn();
				BottomWidgetFadeIn(BackTween);
				bIsInTransition = false;
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
				if (!rxBuildingOwner.AreAircraftDisabled()) {
					ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-2].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
				}
			}
			break;
		*/
		case 7: 
			if (bMainDrawerOpen) {
				if (GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')) != none) {
					GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')).SetBool("selected", false);
				}
				//check if there is something transitioning, fade out immidietly
				CancelCurrentAnimations();
				/**if (EquipmentDrawer.GetInt("currentFrame") != 20 && bEquipmentDrawerOpen) {
					EquipmentDrawer.GotoAndPlay("Fade Out");
				} */
				bIsInTransition = true;
				MainDrawerFadeOut();
				//EquipmentDrawerFadeOut();
				ItemDrawerFadeIn();
				BottomWidgetFadeIn(BackTween);
				bIsInTransition = false;
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {
					ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 8: 
			if (bMainDrawerOpen) { 
				if (GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')) != none) {
					GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')).SetBool("selected", false);
				}
				//check if there is something transitioning, fade out immidietly
				CancelCurrentAnimations();

				bIsInTransition = true;
				MainDrawerFadeOut();
				ClassDrawerFadeIn();
				BottomWidgetFadeIn(BackTween);
				bIsInTransition = false;
			}else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID);
			} else if (bVehicleDrawerOpen) {//Ukill
					ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
		case 9: 
			if (bMainDrawerOpen) {
				if (!rxPurchaseSystem.AreVehiclesDisabled(TeamID, rxPC)) {
					if (GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')) != none) {
						GFxClikWidget(MainMenuGroup.GetObject("selectedButton", class'GFxClikWidget')).SetBool("selected", false);
					}
					//check if there is something transitioning, fade out immidietly
					CancelCurrentAnimations();
				/**	if (EquipmentDrawer.GetInt("currentFrame") != 20 && bEquipmentDrawerOpen) {
						EquipmentDrawer.GotoAndPlay("Fade Out");
					} 
				*/
					bIsInTransition = true;
					rxPC.bIsInPurchaseTerminalVehicleSection = true;
					MainDrawerFadeOut();
					//EquipmentDrawerFadeOut();
					VehicleDrawerFadeIn();
					BottomWidgetFadeIn(BackTween);
					BottomWidgetFadeIn(VehicleInfoTween);
					bIsInTransition = false;
				}
			} else if (bClassDrawerOpen){
				ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[selectedIndex-1].ID : NodClassMenuData[selectedIndex - 1].ID); 
				//ChangeDummyPawnClass(TeamID == TEAM_GDI ? GDIClassMenuData[9].ID : NodClassMenuData[9].ID);
			}else if (bVehicleDrawerOpen) {//Ukill
					ChangeDummyVehicleClass(TeamID == TEAM_GDI ? GDIVehicleMenuData2[selectedIndex-1].ID : NodVehicleMenuData2[selectedIndex - 1].ID);
			}
			break;
	}
	
}

/*function Initialize(LocalPlayer player, Rx_BuildingAttachment_PT PTOwner)
{
	Super.Initialize(player, PTOwner);

	ForEach class'WorldInfo'.static.GetWorldInfo().AllActors (class'Ukill_CapturableMCT_Kismet_Ukill', Ukill)
		break;//Ukill
	ForEach class'WorldInfo'.static.GetWorldInfo().AllActors (class'Ukill_CapturableMCT_Kismet_MC', HealingFacility)
		break;//Ukill


	rxPC						=	Ukill_Controller(GetPC());
	rxHUD						=	Ukill_HUD(rxPC.myHUD);
}*/


function Initialize(LocalPlayer player, Rx_BuildingAttachment_PT PTOwner)
{	
	local byte i; 
	local string WidgetTeamPrefix;
	local array<PTEquipmentBlock> explosiveData;
	local array<PTEquipmentBlock> sidearmData;
	local Rx_InventoryManager rxInv;
	ForEach class'WorldInfo'.static.GetWorldInfo().AllActors (class'Rx_CapturableMCT_Fort', Fort)
		break;//Ukill
	ForEach class'WorldInfo'.static.GetWorldInfo().AllActors (class'Rx_CapturableMCT_MC', MC)
		break;//Ukill


	`log("<PT Log> ------------------ [ Setting up ] ------------------ ");
	Init(player);
	Start();
	Advance(0.0f);

	
	rxPC						=	Ukill_Controller(GetPC());
	rxHUD						=	Rx_HUD(rxPC.myHUD);
	rxBuildingOwner				=   PTOwner;
	rxPRI						=	Rx_PRI(rxPC.PlayerReplicationInfo);

	rxPC.bIsInPurchaseTerminal	=   true;
	rxHUD.bShowHUD              =   false;
	rxHUD.bCrosshairShow        =   false;
	
	//store items here
	rxInv                       =   Rx_InventoryManager(RxPC.Pawn.InvManager);

	// 	[ASSIGN ROOT MC]
	Root                        =   GetVariableObject("_root");

	//ButtonGroup Widget
	MainMenuGroup               =   InitButtonGroupWidget("mainMenu", Root);
	ClassMenuGroup				=	InitButtonGroupWidget("classMenu", Root);
	ItemMenuGroup				=	InitButtonGroupWidget("itemMenu", Root);
	WeaponMenuGroup				=	InitButtonGroupWidget("weaponMenu", Root);
	VehicleMenuGroup			=	InitButtonGroupWidget("vehicleMenu", Root);
	EquipmentMenuGroup          =   InitButtonGroupWidget("equipmentMenu", Root);


	VehicleDrawer				=	GetVariableObject("_root.vehicleDrawer");
	EquipmentDrawer				=	GetVariableObject("_root.equipmentDrawer");
	BottomDrawer				=	GetVariableObject("_root.bottomDrawer");
	MainDrawer					=	GetVariableObject("_root.mainDrawer");
	ClassDrawer					=	GetVariableObject("_root.classDrawer");
	ItemDrawer					=	GetVariableObject("_root.itemDrawer");
	//Ukillweapon
	//WeaponDrawer				=	GetVariableObject("_root.weaponDrawer");

	ExitTween 					=	GetVariableObject("_root.bottomDrawer.exitButton");
	BackTween 					=	GetVariableObject("_root.bottomDrawer.backButton");
	VehicleInfoTween 			=	GetVariableObject("_root.bottomDrawer.vehicleInfoButton");
	CreditsTween 				=	GetVariableObject("_root.bottomDrawer.creditsButton");
	PurchaseTween 				=	GetVariableObject("_root.bottomDrawer.purchaseButton");

	CursorMC                    =   GetVariableObject("_root.CursorMC");

	LastCursorXPosition         =   CursorMC.GetFloat("x");

	WidgetTeamPrefix            =   TeamID == TEAM_GDI? "GDI" : "Nod";

	GetVariableObject("_root.bottomDrawer.exitButton.PTButton").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.bottomDrawer.backButton.PTButton").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.bottomDrawer.vehicleInfoButton.PTButton").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.bottomDrawer.creditsButton.PTButton").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.bottomDrawer.purchaseButton.PTButton").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.equipmentDrawer.tween.equipsidearm").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
	GetVariableObject("_root.equipmentDrawer.tween.equipexplosives").GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);

	//	[ASSIGN EXIT BACK VEHICLE CREDITS PURCHASEBUTTON]
	ExitButton 					=	GFxClikWidget(GetVariableObject("_root.bottomDrawer.exitButton.PTButton."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
	ExitButton.SetString("label", "<b>"$"<font size='14'>Exit [</font>" $ "<font size='10'> Escape </font>" $ "<font size='14'>]</font>"$"</b>");

	BackButton 					=	GFxClikWidget(GetVariableObject("_root.bottomDrawer.backButton.PTButton."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
	BackButton.SetString("label", "<b>"$"<font size='14'>Back [</font>" $ "<font size='10'> Back Space </font>" $ "<font size='14'>]</font>"$"</b>");

	VehicleInfoButton 			=	GFxClikWidget(GetVariableObject("_root.bottomDrawer.vehicleInfoButton.PTButton."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));

	CreditsButton 				=	GFxClikWidget(GetVariableObject("_root.bottomDrawer.creditsButton.PTButton."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
	CreditsButton.SetString("label", "Credits: 0");
	
	PurchaseButton 				=	GFxClikWidget(GetVariableObject("_root.bottomDrawer.purchaseButton.PTButton."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
	PurchaseButton.SetString("label", "<b>"$"<font size='14'>Purchase [</font>" $ "<font size='10'> Enter </font>" $ "<font size='14'>]</font>"$"</b>");




	OwnedFamilyInfo = Rx_Pawn(RxPC.Pawn).GetRxFamilyInfo();

	if (rxInv.SidearmWeapons.Length > 0) {
		OwnedSidearm            =   rxInv.SidearmWeapons[rxInv.SidearmWeapons.Length - 1];
	}
	if (rxInv.ExplosiveWeapons.Length > 0){
		if (OwnedFamilyInfo == class'Rx_FamilyInfo_GDI_Hotwire' || OwnedFamilyInfo == class'Rx_FamilyInfo_Nod_Technician') {
			//OwnedExplosive      = rxInv.PrimaryWeapons[rxInv.PrimaryWeapons.Find(class'Rx_Weapon_ProxyC4')];
			OwnedExplosive      =   rxInv.ExplosiveWeapons[rxInv.ExplosiveWeapons.Length - 1];
		} else {
			OwnedExplosive      =   rxInv.ExplosiveWeapons[rxInv.ExplosiveWeapons.Length - 1];
		}
	}
	if (rxInv.Items.Length > 0){
		OwnedItem               =   rxInv.Items[rxInv.Items.Length - 1];
	}



	`log("<PT Log> rxPC.bJustBaughtEngineer= "$ rxPC.bJustBaughtEngineer);
	`log("<PT Log> rxPC.bJustBaughtHavocSakura= "$ rxPC.bJustBaughtHavocSakura);
	`log("<PT Log> OwnedFamilyInfo= " $ OwnedFamilyInfo);
	`log("");
	`log("<PT Log> OwnedSidearm= " $ OwnedSidearm);
	`log("<PT Log> OwnedExplosive= " $ OwnedExplosive);
	`log("<PT Log> OwnedItem= " $ OwnedItem);
	`log("");


// 	if (rxPC.CurrentSidearmWeapon == none) {
// 		//then use rxinventory defaults
// 		rxPC.CurrentSidearmWeapon = rxInv.SidearmWeapons[rxInv.SidearmWeapons.Length - 1];
// 	}
	`log("<PT Log> rxPC.CurrentSidearmWeapon= " $ rxPC.CurrentSidearmWeapon);

	if (rxPC.CurrentExplosiveWeapon == none) {
		//then set defaults based on class
// 		if (rxPC.bJustBaughtEngineer 
// 		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Hotwire' 
// 		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Technician'){
// 			//rxPC.CurrentExplosiveWeapon = rxInv.PrimaryWeapons[rxInv.PrimaryWeapons.Find(class'Rx_Weapon_ProxyC4')];
// 		} else {
// 			//rxPC.CurrentExplosiveWeapon = rxInv.ExplosiveWeapons[rxInv.ExplosiveWeapons.Length - 1];
// 		}
	}
	`log("<PT Log> rxPC.CurrentExplosiveWeapon= " $ rxPC.CurrentExplosiveWeapon);


	// 	[ASSIGN EQUIPMENT]
	// 	[ASSIGN MAINMENU]
	//  [ASSIGN CHARACTERS]
	// 	[ASSIGN CHATBOX]

	for (i = 0; i < 10; i++) {
		
		GetVariableObject("_root.mainDrawer.tween.btnMenu"$i).GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
		GetVariableObject("_root.classDrawer.tween.btnMenu"$i).GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
		GetVariableObject("_root.itemDrawer.tween.btnMenu"$i).GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);
		//Ukillweapon
		//GetVariableObject("_root.weaponDrawer.tween.btnMenu"$i).GotoAndStopI(TeamID == TEAM_GDI? 1 : 2);

		
			
		MainMenuButton[i] 		= 	GFxClikWidget(GetVariableObject("_root.mainDrawer.tween.btnMenu"$i $"."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));	
		AssignButtonData(MainMenuButton[i], TeamID == TEAM_GDI ? GDIMainMenuData[i] : NodMainMenuData[i], i);
		MainMenuButton[i].SetObject("group", MainMenuGroup);
		//Ukillweapon
		if(i == 9)
		{
			
				MainMenuButton[i].SetBool("enable", false);
				MainMenuButton[i].SetVisible(false);
		}
		
		ClassMenuButton[i] 		=	GFxClikWidget(GetVariableObject("_root.classDrawer.tween.btnMenu"$i $"."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
		ItemMenuButton[i] 		=	GFxClikWidget(GetVariableObject("_root.itemDrawer.tween.btnMenu"$i $"."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));
		//Ukillweapon
		//WeaponMenuButton[i] 	=	GFxClikWidget(GetVariableObject("_root.weaponDrawer.tween.btnMenu"$i $"."$WidgetTeamPrefix $"Button", class'GFxClikWidget'));

		
		
		AssignButtonData(ClassMenuButton[i], TeamID == TEAM_GDI ? GDIClassMenuData[i] : NodClassMenuData[i], i);
		ClassMenuButton[i].SetObject("group", ClassMenuGroup);
		
		//Ukillweapon
		//Enable the first 7 items in weapon menu, disable the rest
		/**if (i < 9) {
			AssignButtonData(WeaponMenuButton[i], TeamID == TEAM_GDI ? GDIWeaponMenuData[i] : NodWeaponMenuData[i], i);
			WeaponMenuButton[i].SetObject("group", WeaponMenuGroup);
		} else {
			WeaponMenuButton[i].SetBool("enable", false);
			WeaponMenuButton[i].SetVisible(false);
		}*/
		
		//Enable the first 8 items in item menu, disable the rest
		if (i < 8) {
			AssignButtonData(ItemMenuButton[i], TeamID == TEAM_GDI ? GDIItemMenuData[i] : NodItemMenuData[i], i);
			ItemMenuButton[i].SetObject("group", ItemMenuGroup);
		} else {
			ItemMenuButton[i].SetBool("enable", false);
			ItemMenuButton[i].SetVisible(false);
		}
	}

	//  [ASSIGN VEHICLES]
	for (i = 0; i < 9; i++) {
		GetVariableObject("_root.vehicleDrawer.tween.btnVehicle"$i).GotoAndStopI(TeamID == TEAM_GDI ? 1 : 2);

		if (TeamID == TEAM_GDI) {
			//hide additional vehicle slot since GDI has less vehicle.
				VehicleMenuButton2[i] = GFxClikWidget(GetVariableObject("_root.vehicleDrawer.tween.btnVehicle" $ i $"." $WidgetTeamPrefix $"Button", class 'GFxClikWidget'));
			if (i == 8) {
				//VehicleMenuButton2[i] = GFxClikWidget(GetVariableObject("_root.vehicleDrawer.tween.btnVehicle8" $"." $WidgetTeamPrefix $"Button", class 'GFxClikWidget'));
				VehicleMenuButton2[i].SetBool("enable", false);
				VehicleMenuButton2[i].SetVisible(false);
				//continue;
			}
			//if(i<8)
			//	VehicleMenuButton2[i] = GFxClikWidget(GetVariableObject("_root.vehicleDrawer.tween.btnVehicle" $ (int(GDIVehicleMenuData2[i].hotkey) - 1) $"." $WidgetTeamPrefix $"Button", class 'GFxClikWidget'));

		} else if (TeamID == TEAM_NOD) {
			VehicleMenuButton2[i] = GFxClikWidget(GetVariableObject("_root.vehicleDrawer.tween.btnVehicle" $ i $"." $WidgetTeamPrefix $"Button", class 'GFxClikWidget'));
		}
 		AssignVehicleData(VehicleMenuButton2[i], TeamID == TEAM_GDI ? GDIVehicleMenuData2[i] : NodVehicleMenuData2[i], i);
 		VehicleMenuButton2[i].SetObject("group", VehicleMenuGroup);

	}
	
	// 	[ASSIGN EQUIPMENU BUTTON] 
	//need to add player's own sidearm and explosives into the list
	//equipment data need to have in def props

	EquipSideArmButton 			=	GFxClikWidget(GetVariableObject("_root.equipmentDrawer.tween.equipsidearm."$WidgetTeamPrefix $"Button", class 'GFxClikWidget'));
	EquipSideArmList 			=	GFxClikWidget(GetVariableObject("_root.equipmentDrawer.tween.equipsidearm."$WidgetTeamPrefix $"EquipmentList", class 'GFxClikWidget'));
	EquipExplosivesButton 		=	GFxClikWidget(GetVariableObject("_root.equipmentDrawer.tween.equipexplosives."$WidgetTeamPrefix $"Button", class 'GFxClikWidget'));
	EquipExplosivesList 		=	GFxClikWidget(GetVariableObject("_root.equipmentDrawer.tween.equipexplosives."$WidgetTeamPrefix $"EquipmentList", class 'GFxClikWidget'));

	explosiveData = TeamID == TEAM_GDI ? GDIEquipmentExplosiveData : NodEquipmentExplosiveData;
	sidearmData = TeamID == TEAM_GDI ? GDIEquipmentSideArmData : NodEquipmentSideArmData;

	if (rxPC.CurrentSidearmWeapon != none) {
		AssignEquipmentData(EquipSideArmButton, EquipSideArmList, sidearmData, rxInv.AvailableSideArmWeapons, rxPC.CurrentSidearmWeapon);
	} else {
		
		AssignEquipmentData(EquipSideArmButton, EquipSideArmList, sidearmData, rxInv.AvailableSidearmWeapons, rxInv.class.default.SidearmWeapons[0]);
	}
	EquipSideArmButton.SetObject("group", EquipmentMenuGroup);

	if (rxPC.bJustBaughtEngineer 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Hotwire' 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Technician'){

			//supposely replace the 1st index, which is the timedc4


// 			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')]);
// 			explosiveData[0] = explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')];
// 			explosiveData[0].bFree = true;
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_TimedC4')]);
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_RemoteC4')]);
			explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')].bFree = true;
// 		explosiveData[0] = explosiveData[explosiveData.Length - 1];
// 		explosiveData[0].bFree = true;
// 		explosiveData.Remove(explosiveData.length - 1, 1);

			//log
				`log("<PT Log>              ====================== ");
			for (i=0; i<explosiveData.Length; i++) {
				`log("<PT Log> Engi explosiveData["$ i $"]= " $ explosiveData[i].title);
			}

	} else if (rxPC.bJustBaughtHavocSakura 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Havoc'
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Sakura' ) {
			
// 			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')]);
// 			explosiveData[0] = explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_RemoteC4')];
// 			explosiveData[0].bFree = true;
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_TimedC4')]);
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')]);
			explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_RemoteC4')].bFree = true;
		}
	
	else {
		
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_RemoteC4')]);
			explosiveData.RemoveItem(explosiveData[explosiveData.Find('WeaponClass', class'Rx_Weapon_ProxyC4')]);

			//log
			`log("<PT Log>              ====================== ");
			for (i=0; i<explosiveData.Length; i++) {
				`log("<PT Log> Norm explosiveData["$ i $"]= " $ explosiveData[i].title);
			}
	}

	if (rxPC.CurrentExplosiveWeapon != none) {
		AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, rxPC.CurrentExplosiveWeapon);
	} else {
		if (rxPC.bJustBaughtEngineer 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Hotwire' 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Technician'){
			//AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxPC.PreviousExplosiveTransactionRecords, rxInv.PrimaryWeapons[rxInv.PrimaryWeapons.Find(class'Rx_Weapon_ProxyC4')]);
			`log("<PT Log> engi rxPC.Pawn.InvManager= " $ rxPC.Pawn.InvManager);
			if (TeamID == TEAM_GDI) {
				AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, class'Rx_InventoryManager_GDI_Hotwire'.default.ExplosiveWeapons[0]);
			} else {
				AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, class'Rx_InventoryManager_Nod_Technician'.default.ExplosiveWeapons[0]);
			}
		} else if (rxPC.bJustBaughtHavocSakura 
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_GDI_Havoc'
		|| Rx_Pawn(rxPC.Pawn).GetRxFamilyInfo() == class'Rx_FamilyInfo_Nod_Sakura' ) {
			//AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxPC.PreviousExplosiveTransactionRecords, class'Rx_InventoryManager'.default.ExplosiveWeapons[0]);
			`log("<PT Log> Hvc/Skr rxPC.Pawn.InvManager= " $ rxPC.Pawn.InvManager);
			if (TeamID == TEAM_GDI) {
				AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, class'Rx_InventoryManager_GDI_Havoc'.default.ExplosiveWeapons[0]);
			} else {
				AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, class'Rx_InventoryManager_Nod_Sakura'.default.ExplosiveWeapons[0]);
			}
		} else {
			`log("<PT Log> norm rxPC.Pawn.InvManager= " $ rxPC.Pawn.InvManager);
			//AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxPC.PreviousExplosiveTransactionRecords, Rx_InventoryManager(rxPC.Pawn.InvManager).default.ExplosiveWeapons[0]);
			AssignEquipmentData(EquipExplosivesButton, EquipExplosivesList, explosiveData , rxInv.AvailableExplosiveWeapons, class'Rx_InventoryManager'.default.ExplosiveWeapons[0]);
		}
	}
	EquipExplosivesButton.SetObject("group", EquipmentMenuGroup);


	bIsInTransition = true;
	BottomWidgetFadeIn(ExitTween);
	BottomWidgetFadeIn(CreditsTween);
	BottomWidgetFadeIn(PurchaseTween);
	MainDrawerFadeIn();
	//EquipmentDrawerFadeIn();
	bIsInTransition = false;;

	
	//  [WIRE EVENTS FOR EQUIPMENT BUTTON]
	RemoveWidgetEvents();
	AddWidgetEvents();

	//set the dummy pawn/vehicle here
	SetupPTDummyActor();
	// 	[SET IGNORE 'E' BUTTON]
}


function TickHUD() 
{
	local Rx_TeamInfo rxTeamInfo;
	local byte i, j;
	local int data;
	local Rx_Vehicle RxV;

	if (!bMovieIsOpen) {
		return;
	}

	rxTeamInfo = Rx_TeamInfo(rxPRI.Team);

	if (PlayerCredits != rxPRI.GetCredits()){
		PlayerCredits = rxPRI.GetCredits();
		CreditsButton.SetString("label", "Credits: "$int(PlayerCredits));
	}

	if (VehicleCount != rxTeamInfo.GetVehicleCount()){
		VehicleCount = rxTeamInfo.GetVehicleCount();
		
		if (VehicleCount ==  Clamp(VehicleCount, 1, 10)) {
			VehicleInfoButton.GetObject("vehicleCount").SetVisible(true);
			VehicleInfoButton.GetObject("vehicleCount").GotoAndStopI(VehicleCount);

			i = 0;			
			foreach rxPC.WorldInfo.AllPawns(class'Rx_Vehicle', RxV) {
				if (RxV.GetTeamNum() != TeamID || i > VehicleCount) {
					continue;
				} 
				if (TeamID == TEAM_GDI){
					for (j=0; j < rxPurchaseSystem.GDIVehicleClasses.Length; j++) {
						if (RxV.Class != rxPurchaseSystem.GDIVehicleClasses[j]) {
							continue;
						}
						//Ukilltest
						//VehicleInfoButton.GetObject("vehicleCount").GetObject("icon"$i).GotoAndStopI(GDIVehicleMenuData2[j].iconID);
						//the following is the test
						LoadTexture("img://" $ PathName(GDIVehicleMenuData2[j].PTIconTexture), VehicleInfoButton.GetObject("vehicleCount").GetObject("icon"$i));
						//`log("FIRST = "$PathName(GDIVehicleMenuData2[j].PTIconTexture));
						//`log("Second = "$VehicleInfoButton.GetObject("vehicleCount").GetObject("icon"$i));
						//end test

						//Ukill
						//"btnVehicle"$i.GDIButton.icon
						

					}
				} else if (TeamID == TEAM_NOD) {
					for (j=0; j < rxPurchaseSystem.NodVehicleClasses.Length; j++) {
						if (RxV.Class != rxPurchaseSystem.NodVehicleClasses[j]) {
							continue;
						}
						//Ukilltest
						//VehicleInfoButton.GetObject("vehicleCount").GetObject("icon"$i).GotoAndStopI(NodVehicleMenuData2[j].iconID);
						//the following is the test
						LoadTexture("img://" $ PathName(NodVehicleMenuData2[j].PTIconTexture), VehicleInfoButton.GetObject("vehicleCount").GetObject("icon"$i));
						//end test
					}
				}
				i++;
			}
		} else {
			VehicleInfoButton.GetObject("vehicleCount").SetVisible(false);
			if (VehicleCount > 10) {
				`log("<PT Log> WARNING: vehicle exceeding the game vehicle limit");
			}
		}

		VehicleInfoButton.SetString("label", "Vehicles: " $ VehicleCount $" / " $ rxTeamInfo.VehicleLimit);
		MainMenuButton[7].SetString("vehicleCountLabel", "( "$ VehicleCount $ " )");
		//vehicle button number update here
		
	}


	/** Disable for now
	if (!EquipSideArmButton.GetBool("selected")) {
		if (EquipSideArmList.GetBool("visible")) {
			if (TeamID == TEAM_GDI) {
				GetVariableObject("_root.equipmentDrawer.tween.equipsidearm.GDIListArrow").SetVisible(false);
			} else {
				GetVariableObject("_root.equipmentDrawer.tween.equipsidearm.NodListArrow").SetVisible(false);
			}
			EquipSideArmList.SetVisible(false);
		}
	}

	if (!EquipExplosivesButton.GetBool("selected")) {
		if (EquipExplosivesList.GetBool("visible")) {
			if (TeamID == TEAM_GDI) {
				GetVariableObject("_root.equipmentDrawer.tween.equipexplosives.GDIListArrow").SetVisible(false);
			} else {
				GetVariableObject("_root.equipmentDrawer.tween.equipexplosives.NodListArrow").SetVisible(false);
			}
			EquipExplosivesList.SetVisible(false);
		}
	}
*/
	//Pay Class Condition

	if (rxPurchaseSystem.AreHighTierPayClassesDisabled(TeamID)) {
		if (bClassDrawerOpen) {
			//enabled deadeye/BHS when bar/hon is dead (Ukill)
			for (i = 9; i > 3; i--) {
				if (!ClassMenuButton[i].GetBool("enabled")) {
					continue;
				}
				ClassMenuButton[i].SetBool("selected", false);
				ClassMenuButton[i].SetBool("visible", false);
				ClassMenuButton[i].SetBool("enabled", false);
			}
			//enabled deadeye/BHS when bar/hon is dead (Ukill)
			for (i = 0; i < 4; i++) {
				data = int(ClassMenuButton[i].GetString("data"));
 				ClassMenuButton[i].SetBool("enabled", TeamID == TEAM_GDI ? GDIClassMenuData[i].bEnable : NodClassMenuData[i].bEnable);
			}			
		} else if (bMainDrawerOpen) {
			MainMenuButton[7].SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, (TeamID == TEAM_GDI ? GDIMainMenuData[6].title : NodMainMenuData[6].title), rxPC));
			MainMenuButton[7].SetBool("enabled", true);
		}
	} else {
		if (bClassDrawerOpen) {
			for (i = 0; i < 10; i++) {
				data = int(ClassMenuButton[i].GetString("data"));
 				ClassMenuButton[i].SetBool("enabled", TeamID == TEAM_GDI ? GDIClassMenuData[i].bEnable : NodClassMenuData[i].bEnable);
			}
		} else if (bMainDrawerOpen) {
			MainMenuButton[7].SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, (TeamID == TEAM_GDI ? GDIMainMenuData[6].title : NodMainMenuData[6].title), rxPC));
			MainMenuButton[7].SetBool("enabled", true);
		}
	}

	//Vehicle Condition

	if (rxPurchaseSystem.AreVehiclesDisabled(TeamID, rxPC)) {
		if (bVehicleDrawerOpen) {
 			
			for(i=0; i < 9; i++) {
				if (!VehicleMenuButton2[i].GetBool("enabled")) {
					continue;
				}
 				VehicleMenuButton2[i].SetBool("selected", false);
 				VehicleMenuButton2[i].SetBool("enabled", false);
 			}
			SelectBack();
			MainMenuButton[7].SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, (TeamID == TEAM_GDI ? GDIMainMenuData[7].title : NodMainMenuData[7].title), rxPC ));
			MainMenuButton[7].SetBool("selected", false);
			MainMenuButton[7].SetBool("enabled", false);
		} else if (bMainDrawerOpen) {
			MainMenuButton[7].SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, (TeamID == TEAM_GDI ? GDIMainMenuData[7].title : NodMainMenuData[7].title), rxPC));
			MainMenuButton[7].SetBool("selected", false);
			MainMenuButton[7].SetBool("enabled", false);
		}
	} else {
		if (bVehicleDrawerOpen) {
 			for(i=0; i < 9; i++) {
				
				//`log("Team ID = " @ TeamID);
				if(rxPurchaseSystem.AreHighTierVehiclesDisabled(TeamID) && i > 1) //limit to buggies / APCs
				{
					if(!VehicleMenuButton2[i].GetBool("enabled")) 
							continue; 
					//enable bike and wolverine with airdrop (Ukill)
					if (i==6) 
					{
						VehicleMenuButton2[i].SetBool("visible", true);
						VehicleMenuButton2[i].SetBool("enabled", true);
						continue;
					}

						//`log("Parsed through vehicles");
				VehicleMenuButton2[i].SetBool("selected", false);
				VehicleMenuButton2[i].SetBool("visible", false);
				VehicleMenuButton2[i].SetBool("enabled", false);
						
					
				}
				
				data = int(VehicleMenuButton2[i].GetString("data"));
 				VehicleMenuButton2[i].SetBool("enabled", TeamID == TEAM_GDI ? GDIVehicleMenuData2[i].bEnable : NodVehicleMenuData2[i].bEnable);


 				//Ukill
 				//`log("UkillGFXPURCHASE");
 				//`log("Ukill.GetTeamNum() = "$Ukill.GetTeamNum());
 				if (TeamID == TEAM_GDI && TeamID != Fort.GetTeamNum())
 				{
 					if (i>4 && i<9)
 					{
 						VehicleMenuButton2[i].SetBool("selected", false);
 						VehicleMenuButton2[i].SetBool("enabled", false);
 						//`log("in 4-8: "$i);
 					}	
 				}
 				/*if (TeamID == TEAM_GDI && i==8)
 					{
 						VehicleMenuButton2[i].SetBool("selected", false);
						VehicleMenuButton2[i].SetBool("visible", false);
						VehicleMenuButton2[i].SetBool("enabled", false);
 					}*/
 				if (TeamID != TEAM_GDI && TeamID != Fort.GetTeamNum())
 				{
 					if (i>5 && i<9)
 					{
 						VehicleMenuButton2[i].SetBool("selected", false);
 						VehicleMenuButton2[i].SetBool("enabled", false);
 					}
 				}

				if (rxBuildingOwner.AreAircraftDisabled()) {
					if (TeamID == TEAM_GDI) {
						if (GDIVehicleMenuData2[data].bAircraft) {
 							VehicleMenuButton2[i].SetBool("selected", false);
 							VehicleMenuButton2[i].SetBool("enabled", false);
						}
					} else {
						if (NodVehicleMenuData2[data].bAircraft) {
 							VehicleMenuButton2[i].SetBool("selected", false);
 							VehicleMenuButton2[i].SetBool("enabled", false);
						}
					}
				}

 			}
		} else if (bMainDrawerOpen) {
			MainMenuButton[7].SetString("sublabel", rxPurchaseSystem.GetFactoryDescription(TeamID, (TeamID == TEAM_GDI ? GDIMainMenuData[7].title : NodMainMenuData[7].title), rxPC));
			MainMenuButton[7].SetBool("enabled", true);
		}
	}

	//silo condition
	//Ukillweapon
	/*if (!rxPurchaseSystem.AreSilosCaptured(TeamID)) {
		if (bWeaponDrawerOpen) {
			for (i=0; i < 9; i++) {
				data = int(WeaponMenuButton[i].GetString("data"));
				if (TeamID == TEAM_GDI) {
					if (GDIWeaponMenuData[data].bSilo){
						WeaponMenuButton[i].SetBool("selected", false);
						WeaponMenuButton[i].SetBool("enabled", false);
					}
				} else {
					if (NodWeaponMenuData[data].bSilo){
						WeaponMenuButton[i].SetBool("selected", false);
						WeaponMenuButton[i].SetBool("enabled", false);
					}
				}
			}
		}
	} else {
		if (bWeaponDrawerOpen) {
			for (i=0; i < 9; i++) {
				data = int(WeaponMenuButton[i].GetString("data"));
				if (TeamID == TEAM_GDI) {
					if (GDIWeaponMenuData[data].bSilo){
						WeaponMenuButton[i].SetBool("enabled", true);
					}
				} else {
					if (NodWeaponMenuData[i].bSilo){
						WeaponMenuButton[i].SetBool("enabled", true);
					}
				}
			}
		}
	}*/
	
	
	//payment conditions

		if (bClassDrawerOpen) {
			for (i = 0; i < 10; i++) {
				data = int(ClassMenuButton[i].GetString("data"));
				if (TeamID == TEAM_GDI) {
					if (!GDIClassMenuData[i].bEnable) {
						
						continue;
					}
				} else {
					if (!NodClassMenuData[i].bEnable) {
						continue;
					}
				}
				if (ClassMenuButton[i].GetBool("enabled") && PlayerCredits < rxPurchaseSystem.GetClassPrices(TeamID, data)){
					ClassMenuButton[i].SetBool("enabled", false);
				}
			}
		} else if (bVehicleDrawerOpen) 			
			{
				for (i = 0; i < 9; i++) {
					
					if(rxPurchaseSystem.AreHighTierVehiclesDisabled(TeamID) && i > 1 && i!=6)
					{
					if(VehicleMenuButton2[i].GetBool("enabled")) 
						{
						VehicleMenuButton2[i].SetBool("enabled",false); 					
						}
					continue; //No need to parse the info for everything else if it isn't enabled and visible.
					}
					data = int(VehicleMenuButton2[i].GetString("data"));
					if (TeamID == TEAM_GDI) {
						if (!GDIVehicleMenuData2[i].bEnable) {
							continue;
						}
					} else {
						if (!NodVehicleMenuData2[i].bEnable) {
							continue;
						}
					}
					if (rxBuildingOwner.AreAircraftDisabled()) {
						if (TeamID == TEAM_GDI) {
							if (GDIVehicleMenuData2[i].bAircraft) {
								continue;
							}
						} else {
							if (NodVehicleMenuData2[i].bAircraft) {
								continue;
							}
						}
					}
				
				
					if (TeamID == TEAM_GDI) {
						VehicleMenuButton2[i].SetString("costLabel", "$" $ rxPurchaseSystem.GetVehiclePrices(TeamID, GDIVehicleMenuData2[i].ID, rxPurchaseSystem.AirdropAvailable(rxPRI)));
					} else {
						VehicleMenuButton2[i].SetString("costLabel", "$" $ rxPurchaseSystem.GetVehiclePrices(TeamID, NodVehicleMenuData2[i].ID, rxPurchaseSystem.AirdropAvailable(rxPRI)));
					}				
				
					if (PlayerCredits > rxPurchaseSystem.GetVehiclePrices(TeamID, data, rxPurchaseSystem.AirdropAvailable(rxPRI)) ){
						//Ukill
		 				if (TeamID == TEAM_GDI)
		 				{
		 					if (TeamID != Fort.GetTeamNum() && i>4 && i<9)
		 					{
		 						VehicleMenuButton2[i].SetBool("selected", false);
		 						VehicleMenuButton2[i].SetBool("enabled", false);
		 					}else
		 						VehicleMenuButton2[i].SetBool("enabled", true);
		 				}
		 				else if (TeamID == TEAM_Nod)
		 				{
		 					if (TeamID != Fort.GetTeamNum() && i>5 && i<9)
		 					{
		 						VehicleMenuButton2[i].SetBool("selected", false);
		 						VehicleMenuButton2[i].SetBool("enabled", false);
		 					}else
		 						VehicleMenuButton2[i].SetBool("enabled", true);
		 				}
		 				/*if (TeamID == TEAM_GDI && i ==8)
		 				{
		 					VehicleMenuButton2[i].SetBool("selected", false);
		 					VehicleMenuButton2[i].SetBool("enabled", false);
		 					VehicleMenuButton2[i].SetBool("visible", false);
		 				}*/
						
					} else {
						VehicleMenuButton2[i].SetBool("enabled", false);
					}
				}
		}	else if (bItemDrawerOpen) {
			for (i = 0; i < 8; i++) {
				data = int(ItemMenuButton[i].GetString("data"));
				if (TeamID == TEAM_GDI) {
					if (!GDIItemMenuData[i].bEnable) {
						continue;
					}
				} else {
					if (!NodItemMenuData[i].bEnable) {
						continue;
					}
				}
				if (PlayerCredits > rxPurchaseSystem.GetItemPrices(TeamID, data)){
					ItemMenuButton[i].SetBool("enabled", true);
				} else {
					ItemMenuButton[i].SetBool("enabled", false);
				}
				if (i == 2 && TeamID != MC.GetTeamNum())//Ukill
				{
					ItemMenuButton[2].SetBool("selected", false);
					ItemMenuButton[2].SetBool("enabled", false);
				}
			}
		}

}

function SetupPTDummyActor()
{
	local vector loc;
	local rotator rot;

	if(DummyPawn2 == None) {
		foreach rxPC.AllActors(class'Rx_PTPlayerSpot', PawnShowcaseSpot) {
			if(PawnShowcaseSpot.TeamNum == rxPC.GetTeamNum()) {
				break;
			}	
		}
		
		loc = PawnShowcaseSpot.location;
		loc.Z += 50;
		rot = PawnShowcaseSpot.Rotation;
		//rot.Yaw += (-16384) * 2; // one1: comment this out to have original pawn rotation
		
		DummyPawn2 = rxPC.Spawn(class'Ukill_PT_Pawn',rxPC,,loc,rot,,true);
		DummyPawn2.bIsInvisible = true;
		DummyPawn2.SetHidden(true); 

		//TODO:Temp placeholder
		DummyPawn2.SetHidden(false);
		DummyPawn2.SetCharacterClassFromInfo(Rx_Pawn(rxPC.Pawn).CurrCharClassInfo);
		DummyPawn2.RefreshAttachedWeapons();
	}

	if (DummyVehicle2 == none) {
		foreach rxPC.AllActors(class'Rx_PTVehicleSpot', VehicleShowcaseSpot) {
			if(VehicleShowcaseSpot.TeamNum == rxPC.GetTeamNum()) {
				break;
			}	
		}
		loc = VehicleShowcaseSpot.location;
		rot = VehicleShowcaseSpot.Rotation;

		DummyVehicle2 = rxPC.Spawn(class'Ukill_PT_Vehicle', rxPC, , loc, rot, , true);
		DummyVehicle2.SetHidden(true); //it was true earlier

		
// 		DummyVehicle.SetHidden(false);
// 			DummyVehicle.SetSkeletalMesh(TeamID == TEAM_GDI 
// 				? class'RenX_Game.Rx_Vehicle_MediumTank'.default.SkeletalMeshForPT 
// 				: class'RenX_Game.Rx_Vehicle_LightTank'.default.SkeletalMeshForPT );
	}
}

function ChangeDummyPawnClass(int classNum) 
{
    local class<Rx_FamilyInfo> rxCharInfo;   
	
	if (TeamID == TEAM_GDI) 
	{
	 	rxCharInfo = rxPurchaseSystem.GDIInfantryClasses[classNum];	
	} else 
	{
		rxCharInfo = rxPurchaseSystem.NodInfantryClasses[classNum];	
	}
	DummyPawn2.SetHidden(false);
	DummyPawn2.SetCharacterClassFromInfo(rxCharInfo);
	DummyPawn2.RefreshAttachedWeapons();
}

function ChangeDummyVehicleClass (int classNum) 
{
	local class<Rx_Vehicle> vehicleClass;
		
	if (DummyVehicle2 == None) 
	{
		DummyVehicle2 = rxPC.Spawn(class'Ukill_PT_Vehicle', rxPC, , VehicleShowcaseSpot.Location, VehicleShowcaseSpot.Rotation, , true);
	}
	
 	DummyVehicle2.SetHidden(false);
	if(rxPC.GetTeamNum() == TEAM_GDI) {
	 	vehicleClass = class'Ukill_PurchaseSystem'.default.GDIVehicleClasses[classNum];	
	} else {
		vehicleClass = class'Ukill_PurchaseSystem'.default.NodVehicleClasses[classNum];	
	}	

	DummyVehicle2.SetSkeletalMesh(vehicleClass.default.SkeletalMeshForPT);
	switch (vehicleClass)
	{
		case class'Ukill_Vehicle_Humvee':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Humvee_New');
			break;
		case class'Ukill_TS_Vehicle_Buggy':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_Buggy');
			break;
		case class'Ukill_Vehicle_APC_GDI':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_GDI_APC');
			break;
		case class'Ukill_Vehicle_APC_Nod':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Nod_APC');
			break;
		case class'Ukill_Vehicle_Artillery':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Artillery');
			break;
		case class'Ukill_Vehicle_Buggy':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Buggy');
			break;
		case class'Ukill_Vehicle_FlameTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_FlameTank');
			break;
		case class'Ukill_Vehicle_HoverMRLS':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_HoverMRLS');
			break;
		case class'Ukill_Vehicle_LightTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_LightTank');
			break;
		case class'Ukill_Vehicle_MammothTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_MammothTank');
			break;
		case class'Ukill_Vehicle_MediumTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_MediumTank');
			break;
		case class'Ukill_Vehicle_MRLS':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_MRLS');
			break;
		case class'Ukill_Vehicle_ReconBike':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Bike');
			break;
		case class'Ukill_Vehicle_StealthTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_StealthTank_New');
			break;
		case class'Ukill_Vehicle_TickTank':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_TickTank');
			break;
		case class'Ukill_Vehicle_Titan':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Titan_Reborn');
			break;
		case class'Ukill_Vehicle_Wolverine':
			DummyVehicle2.SetMaterial(MaterialInstanceConstant'RX_ENV_Ukill.VehicleMaterials.MI_VH_Wolverine_Reborn');
			break;
		default:
			break;
	}
}

function bool FilterButtonInput(int ControllerId, name ButtonName, EInputEvent InputEvent)
{



// 	/** @shahman:temp hack to do a check whether the drawer is playing animation. slightly dirty. */
// 	if ( (MainDrawer.GetInt("currentFrame") != 20 && bMainDrawerOpen) 
// 		|| (VehicleDrawer.GetInt("currentFrame") != 20 && bVehicleDrawerOpen) 
// 		|| (WeaponDrawer.GetInt("currentFrame") != 20 && bWeaponDrawerOpen) 
// 		|| (ItemDrawer.GetInt("currentFrame") != 20 && bItemDrawerOpen) 
// 		|| (EquipmentDrawer.GetInt("currentFrame") != 20 && bEquipmentDrawerOpen) 
// 		|| (ClassDrawer.GetInt("currentFrame") != 20 && bClassDrawerOpen) ) {
// 		return false;
// 		}

	if (InputEvent == EInputEvent.IE_Pressed) {
		`log("<PT Log> ------------------ [ FilterButtonInput ] ------------------ ");
		`log("<PT Log> Button Pressed? " $ ButtonName);
	}
	switch (ButtonName) 
	{
		case 'Escape':
			if (InputEvent == EInputEvent.IE_Pressed) {
				PlaySoundFromTheme('buttonClick', 'default'); //TODO
				SetLoadout();
				ClosePTMenu(false);
			}
			break;
		case 'Enter':
			if (InputEvent == EInputEvent.IE_Pressed) {
				PlaySoundFromTheme('buttonClick', 'default'); //TODO
				SelectPurchase();
			}
			break;
		case 'BackSpace':
			if (InputEvent == EInputEvent.IE_Pressed) {
				PlaySoundFromTheme('buttonClick', 'default'); //TODO
				SelectBack();
			}
			break;
		case 'One':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[0].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(0);
					SelectPurchase();
				} else if ((bMainDrawerOpen && MainMenuButton[0].GetBool("enabled") ) 
					|| (bClassDrawerOpen && ClassMenuButton[0].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[0].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[0].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(0);
					//SelectMenu(1);
					SelectPurchase();
				}
			}
			break;
		case 'Two':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[1].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					if (TeamID == TEAM_GDI) {
						SetSelectedButtonByIndex(1);
					} else {
						SetSelectedButtonByIndex(1);
					}
					SelectPurchase();
				} else if ((bMainDrawerOpen && MainMenuButton[1].GetBool("enabled") ) 
					|| (bClassDrawerOpen && ClassMenuButton[1].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[1].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[1].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(1);
					//SelectMenu(2);
					SelectPurchase();
				}
			}
			break;
		case 'Three':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[2].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					if (TeamID == TEAM_GDI) {
						SetSelectedButtonByIndex(2);
					} else {
						SetSelectedButtonByIndex(2);
					}
					SelectPurchase();
				} else if ((bMainDrawerOpen && MainMenuButton[2].GetBool("enabled") ) 
					|| (bClassDrawerOpen && ClassMenuButton[2].GetBool("enabled")) 
					|| (bVehicleDrawerOpen && VehicleMenuButton2[2].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[2].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[2].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(2);
					//SelectMenu(3);
					SelectPurchase();
				}
			}
			break;
		case 'Four':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[3].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					if (TeamID == TEAM_GDI) {
						SetSelectedButtonByIndex(3);
					} else {
						SetSelectedButtonByIndex(3);
					}
					SelectPurchase();
				} else if ((bMainDrawerOpen && MainMenuButton[3].GetBool("enabled") ) 
					|| (bClassDrawerOpen && ClassMenuButton[3].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[3].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[3].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(3);
					//SelectMenu(4);
					SelectPurchase();
				}
			}
			break;
		case 'Five':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[4].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					if (TeamID == TEAM_GDI) {
						SetSelectedButtonByIndex(4);
					} else {
						SetSelectedButtonByIndex(4);
					}
					SelectPurchase();
				} else if ((bClassDrawerOpen && ClassMenuButton[4].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[4].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[4].GetBool("enabled"))) {
					SetSelectedButtonByIndex(4);
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					//SelectMenu(5);
					SelectPurchase();
				} else if(bMainDrawerOpen && MainMenuButton[4].GetBool("enabled") ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(4);
					SelectPurchase();
				}
			}
			break;
			
		case 'E'://engi
// 			if (InputEvent == EInputEvent.IE_Pressed) {
// 				if(bMainDrawerOpen && MainMenuButton[4].GetBool("enabled") ) {
// 					PlaySoundFromTheme('buttonClick', 'default'); //TODO
// 					SetSelectedButtonByIndex(4);
// 					SelectPurchase();
// 				}
// 			}
			break;
			//break;
		case 'R'://refill
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bMainDrawerOpen && MainMenuButton[5].GetBool("enabled") ) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SelectMenu(6);
				}
			}
			break;
		/**case 'W'://weap
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bMainDrawerOpen && MainMenuButton[6].GetBool("enabled") ) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SelectMenu(7);
				}
			}
			break;
		*/
		case 'Q'://item
			if (InputEvent == EInputEvent.IE_Pressed) {
				 if ((bMainDrawerOpen && MainMenuButton[8].GetBool("enabled") ) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SelectMenu(7);
				}
			}
			break;
		case 'C'://char
			if (InputEvent == EInputEvent.IE_Pressed) {
				 if ((bMainDrawerOpen && MainMenuButton[6].GetBool("enabled") ) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SelectMenu(8);
				}
			}
			break;
		case 'V'://veh
			if (InputEvent == EInputEvent.IE_Pressed) {
				 if ((bMainDrawerOpen && MainMenuButton[7].GetBool("enabled") ) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SelectMenu(9);
				}
			}
			break;
		case 'Six':
			if (InputEvent == EInputEvent.IE_Pressed) {

				if ((bVehicleDrawerOpen && VehicleMenuButton2[5].GetBool("enabled")) ) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					if (TeamID == TEAM_GDI) {
						SetSelectedButtonByIndex(5);//Ukill
					} else {
						SetSelectedButtonByIndex(5);
					}
					SelectPurchase();
				} else if ( (bClassDrawerOpen && ClassMenuButton[5].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[5].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[5].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(5);
					SelectPurchase();
				} 
			}
			break;
		case 'Seven':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[6].GetBool("enabled")) ) {
					//if (!rxBuildingOwner.AreAircraftDisabled()) {//Ukill
						PlaySoundFromTheme('buttonClick', 'default'); //TODO
						if (TeamID == TEAM_GDI) {
							SetSelectedButtonByIndex(6);//Ukill
						} else {
							SetSelectedButtonByIndex(6);
						}
						SelectPurchase();
					//}
				} else if ((bClassDrawerOpen && ClassMenuButton[6].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[6].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[6].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(6);
					SelectPurchase();
				} 
			}
			break;
		case 'Eight':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[7].GetBool("enabled")) ) {
					//if (!rxBuildingOwner.AreAircraftDisabled()) {//Ukill
						PlaySoundFromTheme('buttonClick', 'default'); //TODO
						if (TeamID == TEAM_GDI) {
							SetSelectedButtonByIndex(7);//Ukill
						} else {
							SetSelectedButtonByIndex(7);
						}
						SelectPurchase();
					//}
				} else if ((bClassDrawerOpen && ClassMenuButton[7].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[7].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[7].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(7);
					SelectPurchase();
				}
			}
			break;
		case 'Nine':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bVehicleDrawerOpen && VehicleMenuButton2[7].GetBool("enabled")) ) {//Ukill
						PlaySoundFromTheme('buttonClick', 'default'); //TODO
						if (TeamID == TEAM_GDI) {							
						} else {
							SetSelectedButtonByIndex(8);
						}
						SelectPurchase();
				}else if ((bClassDrawerOpen && ClassMenuButton[8].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[8].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[8].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(8);
					SelectPurchase();
				}
			}
			break;
		case 'Zero':
			if (InputEvent == EInputEvent.IE_Pressed) {
				if ((bClassDrawerOpen && ClassMenuButton[9].GetBool("enabled")) 
					//|| (bWeaponDrawerOpen && WeaponMenuButton[9].GetBool("enabled")) 
					|| (bItemDrawerOpen && ItemMenuButton[9].GetBool("enabled"))) {
					PlaySoundFromTheme('buttonClick', 'default'); //TODO
					SetSelectedButtonByIndex(9);
					SelectPurchase();
				}
			}
			break;
		case 'RightMouseButton': 
			if (InputEvent == EInputEvent.IE_Pressed) {
				rxPC.PlaySound(SoundCue'RenXPurchaseMenu.Sounds.RenXPTSoundTest2_Cue'); //TODO
				LastCursorXPosition = CursorMC.GetFloat("x");
			}
			
			if (DummyPawn != none) {
				//last - current
				MouseRotationIncrement = LastCursorXPosition - CursorMC.GetFloat("x");
				//difference used on rotation
				RotateDummyPawn(DummyPawn.Rotation.Yaw + ( MouseRotationIncrement * 128 ) );
				//then last = current
				LastCursorXPosition = CursorMC.GetFloat("x");
			}
			break;
		case 'LeftMouseButton': 
			//will be used for char rotation, along with left and right arrow
			break;
		case 'Left':
			/* one1: Added. Left arrow keys rotate character. */
			if (DummyPawn != none) {
				RotateDummyPawn(DummyPawn.Rotation.Yaw + RotationIncrement);
			}
			break;
		case 'Right':
			/* one1: Added. right arrow keys rotate character. */
			if (DummyPawn != none) {
				RotateDummyPawn(DummyPawn.Rotation.Yaw - RotationIncrement);
			}
			break;
		case 'F1':
			if (InputEvent == EInputEvent.IE_Pressed) {
				rxPC.PlaySound(SoundCue'RenXPurchaseMenu.Sounds.RenXPTSoundTest2_Cue');
				//CycleEquipmentButton(EquipSideArmButton, EquipSideArmList, TeamID == TEAM_GDI ? GDIEquipmentSideArmData : NodEquipmentSideArmData);
			}
			break;
		case 'F2':
			if (InputEvent == EInputEvent.IE_Pressed) {
				rxPC.PlaySound(SoundCue'RenXPurchaseMenu.Sounds.RenXPTSoundTest2_Cue');
				//CycleEquipmentButton(EquipExplosivesButton, EquipExplosivesList, TeamID == TEAM_GDI ? GDIEquipmentExplosiveData : NodEquipmentExplosiveData);
			}
			break;

		default:
			//`log("ControllerId: "$ControllerId $", ButtonName: "$ButtonName $", InputEvent: "$InputEvent);
			//break;
			return false;
	}

	return false;
}

function ClosePTMenu(bool unload)
{
	super.ClosePTMenu(unload);
	if (DummyVehicle2 != none) {
		DummyVehicle2.SetHidden(true);
		DummyVehicle2.Destroy();
	}
	if (DummyPawn2 != none) {
		DummyPawn2.SetHidden(true);
		DummyPawn2.Destroy();
	}
	Rx_HUD(GetPC().myHUD).SetVisible(true);
}

DefaultProperties
{
	MovieInfo                       =   SwfMovie'UkillPurchaseMenu.RenxPurchaseMenu'

	GDIVehicleMenuData2(0) 			= (BlockType=EPBT_VEHICLE, id=0, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_Humvee', iconID=9,  hotkey="1",title="HUMVEE",								desc="<font size='10'>-.50 Calibre Machine Gun\n-Light Armour\n-Fast Attack Scout\n-Driver + Passenger</font>",				cost="350")
	GDIVehicleMenuData2(1) 			= (BlockType=EPBT_VEHICLE, id=1, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_APC', iconID=7,  hotkey="2",title="ARMOURED PERSONNEL CARRIER",			desc="<font size='10'>-M134 Minigun\n-Heavy Armour\n-Troop Transport\n-Driver + 4 Passengers</font>",						cost="500")
	GDIVehicleMenuData2(2) 			= (BlockType=EPBT_VEHICLE, id=2, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_MRLS', iconID=12, hotkey="3",title="MOBILE ROCKET LAUNCHER SYSTEM",		desc="<font size='10'>-M269 Missiles\n-Light Armour\n-Long Range Ballistics\n-Driver + Passenger</font>",					cost="450")
	GDIVehicleMenuData2(3) 			= (BlockType=EPBT_VEHICLE, id=3, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_MediumTank', iconID=11, hotkey="4",title="MEDIUM TANK",							desc="<font size='10'>-105mm Cannon\n-Heavy Armour\n-Main Battle Tank\n-Driver + Passenger</font>",							cost="800")
	GDIVehicleMenuData2(4) 			= (BlockType=EPBT_VEHICLE, id=4, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_MammothTank', iconID=10, hotkey="5",title="MAMMOTH TANK",						desc="<font size='10'>-2x 120mm Cannons\n-4x Tusk Missiles\n-Heavy Armour\n-Heavy Battle Tank\n-Driver + Passenger</font>",	cost="1500")
	GDIVehicleMenuData2(5) 			= (BlockType=EPBT_VEHICLE, id=5, PTIconTexture=Texture2D'UkillPurchaseMenu.hovermrls_2', iconID=75, hotkey="6",title="HOVER MRLS",				desc="<font size='10'>-M269 Missiles\n-Light Armour\n-Long Range Ballistics\n-Driver + Passenger</font>",					cost="1000")
	GDIVehicleMenuData2(6) 			= (BlockType=EPBT_VEHICLE, id=6, PTIconTexture=Texture2D'UkillPurchaseMenu.wolverine_2', iconID=76, hotkey="7",title="WOLVERINE",						desc="<font size='10'>-2x M134 Miniguns\n-Anti-Infantry\n-Heavy Armour\n-Driver Only</font>",		cost="1000")
	GDIVehicleMenuData2(7) 			= (BlockType=EPBT_VEHICLE, id=7, PTIconTexture=Texture2D'UkillPurchaseMenu.titan_2', iconID=77, hotkey="8",title="TITAN",							desc="<font size='10'>-120mm Cannon\n-Heavy Armour\n-Heavy Battle Walker\n-Driver + Passenger</font>",							cost="1500")
	GDIVehicleMenuData2(8) 			= (BlockType=EPBT_VEHICLE, id=8, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_GDI_MediumTank', iconID=77, hotkey="9",title="TITAN",							desc="<font size='10'>-105mm Cannon\n-Heavy Armour\n-Main Battle Tank\n-Driver + Passenger</font>",							cost="1500")

	NodVehicleMenuData2(0)			= (BlockType=EPBT_VEHICLE, id=0, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_Buggy', iconID=20, hotkey="1", title="BUGGY", 						desc="<font size='10'>-.50 Calibre Machine Gun\n-Light Armour\n-Fast Attack Scout\n-Driver + Passenger</font>", 		 cost="350")
	NodVehicleMenuData2(1)			= (BlockType=EPBT_VEHICLE, id=1, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_APC', iconID=18, hotkey="2", title="ARMOURED PERSONNEL CARRIER", desc="<font size='10'>-M134 Minigun\n-Heavy Armour\n-Troop Transport\n-Driver + 4 Passengers</font>", 					 cost="500")
	NodVehicleMenuData2(2)			= (BlockType=EPBT_VEHICLE, id=2, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_Artillery', iconID=19, hotkey="3", title="MOBILE ARTILLERY", 			desc="<font size='10'>\n-155mm Howitzer\n-Light Armour\n-Long Range Ballistics\n-Driver + Passenger</font>", 			 cost="450")
	NodVehicleMenuData2(3)			= (BlockType=EPBT_VEHICLE, id=3, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_FlameTank', iconID=21, hotkey="4", title="FLAME TANK", 				desc="<font size='10'>\n-2x Flame Throwers\n-Heavy Armour\n-Close Range Suppressor\n-Driver + Passenger</font>", 		 cost="800")
	NodVehicleMenuData2(4)			= (BlockType=EPBT_VEHICLE, id=4, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_LightTank', iconID=22, hotkey="5", title="LIGHT TANK", 				desc="<font size='10'>\n-75mm Cannon\n-Heavy Armour\n-Main Battle Tank\n-Driver + Passenger</font>", 					 cost="600")
	NodVehicleMenuData2(5)			= (BlockType=EPBT_VEHICLE, id=5, PTIconTexture=Texture2D'RenXPurchaseMenu.T_Icon_Veh_Nod_StealthTank', iconID=23, hotkey="6", title="STEALTH TANK", 				desc="<font size='10'>-2x TOW Missiles\n-Heavy Armour\n-Guerilla Combat Vehicle\n-Active Camouflage\n-Drive Only</font>", cost="900")
	NodVehicleMenuData2(6)			= (BlockType=EPBT_VEHICLE, id=6, PTIconTexture=Texture2D'UkillPurchaseMenu.bike_2', iconID=78, hotkey="7", title="RECON BIKE", 		desc="<font size='10'>\n-2x Dragon TOW Launchers\n-Light Armour\n-Fast Attack Scout\n-Driver Only</font>", 				 cost="1000")
	NodVehicleMenuData2(7)			= (BlockType=EPBT_VEHICLE, id=7, PTIconTexture=Texture2D'UkillPurchaseMenu.buggy_2', iconID=79, hotkey="8", title="BUGGY", 					desc="<font size='10'>-Raider Cannon\n-Heavy Armour\n-Anti-Infantry/Air Scout\n-Driver + Passenger</font>", 	 cost="1000")
	NodVehicleMenuData2(8)			= (BlockType=EPBT_VEHICLE, id=8, PTIconTexture=Texture2D'UkillPurchaseMenu.ticktank_2', iconID=80, hotkey="9", title="TICK TANK", 					desc="<font size='10'>-90mm APDS Cannon\n-Heavy Armour \n-Increased Defence When Deployed  \n-Driver + Passenger</font>", 	 cost="1500")
}
