class Rx_VehicleManagerLongerHarvRespawnDelay extends Rx_VehicleManager;


simulated function PostBeginPlay()
{	

	super.PostBeginPlay();
	SetTimer(1.0,false,'init');	
}

function init()
{
    local Vector loc;
    local Rotator rot;		

	
	Initialize(Rx_Game(Worldinfo.Game), Rx_Game(Worldinfo.Game).Teams[TEAM_GDI], Rx_Game(Worldinfo.Game).Teams[TEAM_NOD]);
	Rx_Game(Worldinfo.Game).VehicleManager = Self;
	Rx_Game(Worldinfo.Game).PurchaseSystem.SetVehicleManager(self);	
	
	AirStrip.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_DropOff', loc, rot);
	Set_NOD_ProductionPlace(loc, rot);	
	
	WeaponsFactory.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_Spawn', loc, rot);
	Set_GDI_ProductionPlace(loc, rot);
}

function QueueHarvester(byte team)
{
	if(Worldinfo.Timeseconds > 20) // so that the inital spawn of the harvesters is not delayed
	{
		if(team == TEAM_GDI)
		{
			SetTimer(15.0,false,'QueueGDIHarvester');
		}
		else if(team == TEAM_NOD)
		{
			SetTimer(15.0,false,'QueueNodHarvester');
		}
	}
	else{
		super.QueueHarvester(team);
	}
}

function QueueGDIHarvester()
{
	super.QueueHarvester(TEAM_GDI);
}

function QueueNodHarvester()
{
	super.QueueHarvester(TEAM_NOD);		
}