/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*       This mutator will add the .... function to the Renegade X game        *
*******************************************************************************
* Rx_Mutator_LowPlayersDisableSW                                            *
******************************************************************************/

class Rx_Mutator_LowPlayersDisableSW_Controller extends Rx_Controller;

var int cnt;

exec function CountPlayers ()
{
	local Rx_PRI PRI;
	local Rx_Mutator_LowPlayersDisableSW_Controller C4Mod;
//	local string error;
//	local Rx_Weapon_DeployedBeacon beacon;	

	cnt=0;
	foreach DynamicActors(class'Rx_PRI', PRI)
	{
		cnt = cnt++;
	}

	super.PreBeginPlay();

	C4Mod=Rx_PurchaseSystem(GetDefaultObject(Class'Rx_PurchaseSystem')); 
	C4Mod.GDIItemPrices[0] = 9999;
	C4Mod.NodItemPrices[0] = 9999;

}



/*
	if (parameters == "")
		return "Error: Too few parameters." @ getSyntax();

	PRI = Rx_Game(`WorldInfoObject.Game).ParsePlayer(parameters, error);
	
	if (PRI == None)
		return error;

	if (Controller(PRI.Owner) != None)
		foreach `WorldInfoObject.AllActors(class'Rx_Weapon_DeployedBeacon', beacon)
			if (beacon.InstigatorController == Controller(PRI.Owner))
				beacon.Destroy();

	return "";
*/


/*
function PurchaseIonCannonBeacon(Rx_Controller Buyer)
{
	`log("WARNING: Deprecated Function");
//	Rx_PRI(Buyer.PlayerReplicationInfo).RemoveCredits(1000);
//	Rx_InventoryManager(Buyer.Pawn.InvManager).AddWeaponOfClass(class'Rx_Weapon_IonCannonBeacon',CLASS_ITEM);	
	ClientMessage("Not enough players : " $ cnt);
}
*/
/*
function PurchaseNukeBeacon(Rx_Controller Buyer)
{
	`log("WARNING: Deprecated Function");
//	Rx_PRI(Buyer.PlayerReplicationInfo).RemoveCredits(1000);
//	Rx_InventoryManager(Buyer.Pawn.InvManager).AddWeaponOfClass(class'Rx_Weapon_NukeBeacon',CLASS_ITEM);
	ClientMessage("Not enough players : " $ cnt);
}

//GDIItemClasses[0]  = class'Rx_Weapon_IonCannonBeacon'
//NodItemClasses[0]  = class'Rx_Weapon_NukeBeacon'
*/
