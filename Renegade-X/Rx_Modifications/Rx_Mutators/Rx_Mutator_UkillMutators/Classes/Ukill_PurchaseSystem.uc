class Ukill_PurchaseSystem extends Rx_PurchaseSystem;

//var const array<class<Rx_Vehicle> >     GDIVehicleClasses2;
//var const array<class<Rx_Vehicle> >     NodVehicleClasses2;

/*simulated function class<Rx_Vehicle> GetVehicleClass(byte teamID, int VehicleID)
{
	if (teamID == TEAM_GDI)
	{
		return GDIVehicleClasses2[VehicleID];
	} 
	else
	{
		return NodVehicleClasses2[VehicleID];
	}
}
*/

function PurchaseCharacter(Rx_Controller Buyer, int TeamID, int CharID)
{
	if (AreHighTierPayClassesDisabled(TeamID) && CharID > 8)
	{
		return; // if the appropriate building is destroyed tehy cannot buy anything > 10
	}

	if (FFloor(Rx_PRI(Buyer.PlayerReplicationInfo).GetCredits()) >= GetClassPrices(TeamID,CharID) )
	{
		Rx_PRI(Buyer.PlayerReplicationInfo).RemoveCredits(GetClassPrices(TeamID,CharID));
		
		if(CharID < 5) Rx_PRI(Buyer.PlayerReplicationInfo).SetChar(GetFamilyClass(TeamID,CharID),Buyer.Pawn, true); //Free class
		else
		Rx_PRI(Buyer.PlayerReplicationInfo).SetChar(GetFamilyClass(TeamID,CharID),Buyer.Pawn, false); //Not a free class
		
		`LogRxPub("GAME" `s "Purchase;" `s "character" `s Rx_PRI(Buyer.PlayerReplicationInfo).CharClassInfo.name `s "by" `s `PlayerLog(Buyer.PlayerReplicationInfo));
		Rx_PRI(Buyer.PlayerReplicationInfo).SetIsSpy(false); // if spy, after new char should be gone
		
	}
}

function bool PurchaseVehicle(Rx_PRI Buyer, int TeamID, int VehicleID )
{

	if (FFloor(Buyer.GetCredits()) >= GetVehiclePrices(TeamID,VehicleID,AirdropAvailable(Buyer)) && !AreVehiclesDisabled(TeamID, Controller(Buyer.Owner)) )
	{
		
		if(AreHighTierVehiclesDisabled(TeamID) && VehicleID > 1 && VehicleID != 6) return false; //Limit airdrops to APCs and Humvees/Buggies. 
		
		if(VehicleManager.QueueVehicle(GetVehicleClass(TeamID,VehicleID),Buyer,VehicleID))
		{
			Buyer.RemoveCredits(GetVehiclePrices(TeamID,VehicleID,AirdropAvailable(Buyer)));
			
			if(Buyer.AirdropCounter > 0)
			{
				Buyer.AirdropCounter++;
				if(WorldInfo.NetMode == NM_Standalone)
					Buyer.LastAirdropTime = Worldinfo.TimeSeconds;
			}
			return true;
		} 
		else 
		{
			if(Rx_Controller(Buyer.Owner) != None)
				Rx_Controller(Buyer.Owner).clientmessage("You have reached the queue limit, vehicle not added to the queue!", 'Vehicle');
			return false;
		}
		Buyer.SetVehicleIsStolen(false);
		Buyer.SetVehicleIsFromCrate (false);
	}
	return false;
}

simulated function int GetVehiclePrices(byte teamID, int VehicleID, bool bViaAirdrop)
{
	local float Multiplier;
	Multiplier = 1.0;
	
	if (PowerPlants[teamID] != None && PowerPlants[teamID].IsDestroyed()) 
	{
		Multiplier = 1.5; // if powerplant is dead then everything costs [REDACTED] 1 and a half times as much
	}
	
	if(bViaAirdrop)
		Multiplier *= 2.0;

	if (teamID == TEAM_GDI) //Ukill
	{
		if (VehicleID == 5)
			return 1000 * Multiplier;
		else if (VehicleID == 6)
		{
			if(bViaAirdrop)
				return 1500;
			else
				return 1000;
		}
		else if (VehicleID == 7)
			return 1500 * Multiplier;
		else if (VehicleID == 8)
			return 1000 * Multiplier;
		else
			return GDIVehiclePrices[VehicleID] * Multiplier;
			
	} 
	else
	{
		if (VehicleID == 6)
		{
			if(bViaAirdrop)
				return 1200;
			else
				return 800;
		}
		else if (VehicleID == 7)
			return 800 * Multiplier;
		else if (VehicleID == 8)
			return 1200 * Multiplier;
		else
			return NodVehiclePrices[VehicleID] * Multiplier;
	}
}

DefaultProperties
{
	GDIVehicleClasses[0]   = class'RenX_UkillMutators.Ukill_Vehicle_Humvee'
	GDIVehicleClasses[1]   = class'RenX_UkillMutators.Ukill_Vehicle_APC_GDI'
	GDIVehicleClasses[2]   = class'RenX_UkillMutators.Ukill_Vehicle_MRLS'
	GDIVehicleClasses[3]   = class'RenX_UkillMutators.Ukill_Vehicle_MediumTank'
	GDIVehicleClasses[4]   = class'RenX_UkillMutators.Ukill_Vehicle_MammothTank'
	GDIVehicleClasses[5]   = class'RenX_UkillMutators.Ukill_Vehicle_HoverMRLS' //Ukill
	GDIVehicleClasses[6]   = class'RenX_UkillMutators.Ukill_Vehicle_Wolverine' //Ukill
	GDIVehicleClasses[7]   = class'RenX_UkillMutators.Ukill_Vehicle_Titan' //Ukill
	//GDIVehicleClasses[8]   = class'RenX_Game.TS_Vehicle_Titan' //Ukill

	NodVehicleClasses[0]   = class'RenX_UkillMutators.Ukill_Vehicle_Buggy'
	NodVehicleClasses[1]   = class'RenX_UkillMutators.Ukill_Vehicle_APC_Nod'
	NodVehicleClasses[2]   = class'RenX_UkillMutators.Ukill_Vehicle_Artillery'
	NodVehicleClasses[3]   = class'RenX_UkillMutators.Ukill_Vehicle_FlameTank'
	NodVehicleClasses[4]   = class'RenX_UkillMutators.Ukill_Vehicle_LightTank'
	NodVehicleClasses[5]   = class'RenX_UkillMutators.Ukill_Vehicle_StealthTank'
	NodVehicleClasses[6]   = class'RenX_UkillMutators.Ukill_Vehicle_ReconBike' //Ukill
	NodVehicleClasses[7]   = class'RenX_UkillMutators.Ukill_TS_Vehicle_Buggy' //Ukill
	NodVehicleClasses[8]   = class'RenX_UkillMutators.Ukill_Vehicle_TickTank' //Ukill
}