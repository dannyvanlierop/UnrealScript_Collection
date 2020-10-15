class Ukill_VehicleManager extends Rx_VehicleManager;

var private UTVehicle               lastSpawnedVehicle2;

function Initialize(GameInfo Game, UTTeamInfo GdiTeamInfo, UTTeamInfo NodTeamInfo)
{
	local Vector loc;//Ukill
	local Rotator rot;//Ukill

   local Rx_Building_VehicleFactory build;
   RGame = Rx_Game(Game);
   if (RGame == none)
   {
	  RGame = Rx_Game(WorldInfo.Game);
	  if (RGame == none)
	  {
		 return;
	  }
   }   
   
  Teams[TEAM_GDI] = GdiTeamInfo;
  Teams[TEAM_NOD] = NodTeamInfo;
  
	if(AirStrip == None) 
	{
		ForEach AllActors(class'Rx_Building_VehicleFactory',build)
		{
			if ( build.Class == class'Rx_Building_Airstrip' )
			{
				AirStrip = Rx_Building_Nod_VehicleFactory(build);
			} else if ( build.Class == class'Rx_Building_WeaponsFactory' || build.Class == class'Rx_Building_WeaponsFactory_Ramps')
			{
				WeaponsFactory = Rx_Building_GDI_VehicleFactory(build);
			} 
		}
	}
	if (RGame.TeamCredits[TEAM_GDI].Refinery == None)
		bGDIRefDestroyed = true;
	if (RGame.TeamCredits[TEAM_NOD].Refinery == None)
		bNodRefDestroyed = true;

	if(WorldInfo.Netmode != NM_Client) {
		AirStrip.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);
		//Ukill
		loc.z+=1000;
		Set_NOD_ProductionPlace(loc, rot);
		WeaponsFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_Spawn', loc, rot);
		Set_GDI_ProductionPlace(loc, rot);
	}
}

function InitVehicle(Rx_Vehicle Veh, byte TeamNum, Rx_Pri Buyer, int VehId, vector SpawnLocation)
{
	local UTVehicle P;
	
	// destroy everything around
	foreach VisibleCollidingActors(class'UTVehicle', P, 250, SpawnLocation, true)
	{
		if (P != Veh)
		{
			P.TakeDamage(10000, none, P.Location, vect(0,0,1), class'UTDmgType_LinkBeam');
		}
	}	
	
	if(Rx_Vehicle_Harvester(Veh) == None) 
	{
		Rx_TeamInfo(Teams[TeamNum]).addVehicle(Veh);
	}	
	
	Veh.TeamBought = TeamNum;
	Veh.lastTeamToUse = TeamNum;
	Veh.SetTeamNum(TeamNum);
	Veh.bTeamLocked=false;
	Veh.DropToGround();

	if (Veh.Mesh != none)
		Veh.Mesh.WakeRigidBody();

	if ( Veh != none && Rx_Vehicle_Harvester(Veh) == None)
	{
		Veh.buyerPri = Buyer;
		if ( Rx_Game(WorldInfo.Game).bReserveVehiclesToBuyer )
			Veh.bReservedToBuyer = true;
		Veh.startUpDriving();
		if (Rx_Bot(Veh.buyerPri.owner) != none )
		{
			Rx_Bot(Veh.buyerPri.owner).BaughtVehicle = Veh;
		}	
	}
	//Ukill
	if(Rx_Vehicle_Harvester(Veh) == None) 
		BroadcastLocalizedTeamMessage(TeamNum,MessageClass,VehId,Buyer);
	else
	{
		if(TeamNum == TEAM_GDI)
			BroadcastLocalizedTeamMessage(TeamNum,MessageClass,8,Buyer);
		else
			BroadcastLocalizedTeamMessage(TeamNum,MessageClass,9,Buyer);
	}	
}

function Actor SpawnVehicle(Rx_VehicleManager.VQueueElement VehToSpawn, optional byte TeamNum = -1)
{

	local Rx_Vehicle Veh;
	local Vector SpawnLocation;
	local Ukill_Chinook_Airdrop AirdropingChinook;
	local vector TempLoc;
   
	if (TeamNum < 0)
		TeamNum = VehToSpawn.Buyer.GetTeamNum();
	  
	//set the correct harvester vehicle id (Ukill)
	if (VehToSpawn.VehClass == class'Rx_Vehicle_Harvester_Nod' ||
	 VehToSpawn.VehClass == class'Rx_Vehicle_Harvester_GDI' ||
	 VehToSpawn.VehClass == class'Ukill_Vehicle_Harvester_Nod' ||
	 VehToSpawn.VehClass == class'Ukill_Vehicle_Harvester_GDI')
	{
		if (TeamNum == TEAM_GDI)
		{
			VehToSpawn.VehicleID = 8;
			VehToSpawn.VehClass = class'RenX_UkillMutators.Ukill_Vehicle_Harvester_GDI';
		}
		else
		{
			VehToSpawn.VehicleID = 9;
			VehToSpawn.VehClass = class'RenX_UkillMutators.Ukill_Vehicle_Harvester_Nod';
		}
	}
	  
	switch(TeamNum)
	{
		case TEAM_NOD: // buy for NOD
			if(bNodIsUsingAirdrops)
			{
				TempLoc = NOD_ProductionPlace.L;
				TempLoc.Z -= 500;
				AirdropingChinook = Spawn(class'Ukill_Chinook_Airdrop', , , TempLoc, NOD_ProductionPlace.R, , false);
				AirdropingChinook.initialize(VehToSpawn.Buyer,VehToSpawn.VehicleID, TeamNum);			
			}
			else
			{
				Veh = Spawn(VehToSpawn.VehClass,,, NOD_ProductionPlace.L,NOD_ProductionPlace.R,,true);			
				SpawnLocation = NOD_ProductionPlace.L;
			}
		break;
		case TEAM_GDI: // buy for GDI
			if(bGDIIsUsingAirdrops)
			{
				TempLoc =  GDI_ProductionPlace.L + vector(GDI_ProductionPlace.R) * 950;
				TempLoc.Z -= 500;
				AirdropingChinook = Spawn(class'Ukill_Chinook_Airdrop', , , TempLoc, GDI_ProductionPlace.R, , false);
				AirdropingChinook.initialize(VehToSpawn.Buyer,VehToSpawn.VehicleID, TeamNum);			
			}
			else
			{
				Veh = Spawn(VehToSpawn.VehClass,,,GDI_ProductionPlace.L,GDI_ProductionPlace.R,,true);
				SpawnLocation = GDI_ProductionPlace.L;
			}
		break;
	}
  
  	if (AirdropingChinook != none  )
  	{
  		if(VehToSpawn.Buyer != None) 
		{
			`LogRxPub("GAME" `s "Purchase;" `s "vehicle" `s VehToSpawn.VehClass.name `s "by" `s `PlayerLog(VehToSpawn.Buyer));
			if (Rx_Controller(VehToSpawn.Buyer.Owner) != None)
				Rx_Controller(VehToSpawn.Buyer.Owner).clientmessage("Your vehicle is being delivered!", 'Vehicle');
		}
		else
			`LogRxPub("GAME" `s "Spawn;" `s "vehicle" `s class'Rx_Game'.static.GetTeamName(TeamNum) $ "," $ VehToSpawn.VehClass.name);
			
		return AirdropingChinook;	
  	}
  
	if (Veh != none  )
	{
		lastSpawnedVehicle2 = Veh;
		//Veh.PlaySpawnEffect();
     
		if(VehToSpawn.Buyer != None) 
		{
			`LogRxPub("GAME" `s "Purchase;" `s "vehicle" `s VehToSpawn.VehClass.name `s "by" `s `PlayerLog(VehToSpawn.Buyer));
			if (Rx_Controller(VehToSpawn.Buyer.Owner) != None)
				Rx_Controller(VehToSpawn.Buyer.Owner).clientmessage("Your vehicle '"$veh.GetHumanReadableName()$"' is ready!", 'Vehicle');
		}
		else
			`LogRxPub("GAME" `s "Spawn;" `s "vehicle" `s class'Rx_Game'.static.GetTeamName(TeamNum) $ "," $ VehToSpawn.VehClass.name);
     
		InitVehicle(Veh,TeamNum,VehToSpawn.Buyer,VehToSpawn.VehicleID,SpawnLocation);
		return Veh;
	}
	else if (Veh != none && Rx_Vehicle_Harvester(Veh) != None) 
	{
		Veh.DropToGround(); 
	}

	return None;
}

DefaultProperties {
	MessageClass = class'RenX_UkillMutators.Ukill_Message_VehicleProduced'
	NodHarvesterClass = class'RenX_UkillMutators.Ukill_Vehicle_Harvester_Nod'
	GDIHarvesterClass = class'RenX_UkillMutators.Ukill_Vehicle_Harvester_GDI'
}