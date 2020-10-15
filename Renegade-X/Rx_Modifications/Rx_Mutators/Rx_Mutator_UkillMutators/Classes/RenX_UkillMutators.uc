/***********************************************************************************************************************************************
 This document is written by Ukill after banging his head against the wall many times trying to learn UnrealScript/Mutators by Trial and Error!
***********************************************************************************************************************************************/

class RenX_UkillMutators extends RX_Mutator;

var Rx_CapturableMCT_MC MC;
var Rx_Building_WeaponsFactory WF;
var Rx_Vehicle_Harvester_GDI Harvester_GDI;


function InitMutator(string options, out string errorMessage)
{
		

		if (Rx_Game(WorldInfo.Game) != None)
		{
			Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Ukill_Pawn';
			Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Ukill_Controller';
			SetTimer(0.5f, false, 'ChangePurchaseSystem' ) ;
		}
		Super.InitMutator(options, errorMessage);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	foreach AllActors(class 'Rx_CapturableMCT_MC',MC)
		break;
	foreach AllActors(class 'Rx_Building_WeaponsFactory',WF)
		break;



	SetTimer(2, true);
}


simulated function Timer()
{
	local Rx_Pawn Player;

	foreach DynamicActors(class 'Rx_Pawn', Player)
	{
		if (Player.GetTeamNum() == MC.GetTeamNum())
		{
			if(Player.HealthMax <= 100)
				Player.HealthMax = Player.HealthMax + 50;
			if (Player.Health+1 <= Player.HealthMax)
				Player.Health++;
			if (Player.HealthMax > 150)
				Player.HealthMax = 150;
			if (Player.Health > Player.HealthMax)
				Player.Health = Player.HealthMax;
		}else if (Player.GetTeamNum() != MC.GetTeamNum() && Player.HealthMax>100)
		{
			Player.HealthMax = 100;
			if (Player.Health > Player.HealthMax)
				Player.Health = Player.HealthMax;
		}
	}
}

function bool CheckReplacement(Actor other)
{
	local Vector loc;
    local Rotator rot;
	local vector v;

	v.X = 700;
	v.Y = 300;
	v.Z = 0;

	if (other.isA('Rx_VehicleManager') && !other.isA('Ukill_VehicleManager')) {
		other.destroy();
	}

	if (other.isA('TS_Vehicle_Titan')) {
		WF.BuildingInternals.BuildingSkeleton.GetSocketWorldLocationAndRotation('Veh_Spawn', loc, rot);
		if(VSize(other.CollisionComponent.GetPosition() - loc) <10){
			other.CollisionComponent.SetRBPosition(other.CollisionComponent.GetPosition()-v);
		}
	}

	return true;
}

simulated function bool ChangePurchaseSystem()
{
	Rx_Game(WorldInfo.Game).PurchaseSystem.Destroy();
	Rx_Game(WorldInfo.Game).PurchaseSystem = spawn(class'Ukill_PurchaseSystem',self,'PurchaseSystem',Location,Rotation);
	Rx_Game(WorldInfo.Game).VehicleManager = spawn(class'Ukill_VehicleManager',self,'VehicleManager',Location,Rotation);
	Rx_Game(WorldInfo.Game).VehicleManager.Initialize(Rx_Game(WorldInfo.Game),
	Rx_Game(WorldInfo.Game).Teams[TEAM_GDI], 
	Rx_Game(WorldInfo.Game).Teams[TEAM_NOD]);
	Rx_Game(WorldInfo.Game).VehicleManager.MessageClass = class'Ukill_Message_VehicleProduced';
	//Rx_Game(WorldInfo.Game).VehicleManager.SpawnInitialHarvesters();
	Rx_Game(WorldInfo.Game).PurchaseSystem.SetVehicleManager(Rx_Game(WorldInfo.Game).VehicleManager);
	
	return true;
}