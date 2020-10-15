class Rx_Mutator_AdminTool_Game extends Rx_Game
	config(RenegadeX);
/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/


/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  REPLICATION  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  INIT  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_Game FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_Game FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

	SetTimer(0.2,false,'init');
	
	/*
	* PostBeginPlay is executed after the GameInfo is created on the server
	*
	* Network: Dedicated/Listen Server
	*/
	// bypassing UTGameReplicationInfo's Timer function 
	// so it doesn't do the countdown
	//simulated function Timer()
	//{
	//	
	//}
}

function init(){

	LogInternal("Rx_Mutator_AdminTool_Game FunctionCall: init");
	
}



exec function SetInitialCredits(int iValue)
{
	SetInitialCreditsServer(iValue);
}

reliable server function SetInitialCreditsServer(int iValue)
{
	InitialCredits = iValue;
	SaveConfig();
	class'WorldInfo'.static.GetWorldInfo().SaveConfig();
	//class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break;
}


event InitGame( string Options, out string ErrorMessage )
{	
	//local int MapIndex;
	
	if(Rx_MapInfo(WorldInfo.GetMapInfo()).bIsDeathmatchMap)
	{
		if(TimeLimit != 10)
			CnCModeTimeLimit = TimeLimit;
		TimeLimit = 10;
		bSpawnInTeamArea = false;
	} else if(CnCModeTimeLimit > 0 && CnCModeTimeLimit != TimeLimit)
	{
		TimeLimit = CnCModeTimeLimit;
	}

	if (WorldInfo.NetMode == NM_Standalone)
		TeamMode = 4;

	super.InitGame(Options, ErrorMessage);
	TeamFactions[TEAM_GDI] = "GDI";
	TeamFactions[TEAM_NOD] = "Nod";
	DesiredPlayerCount = 1;
	bCanPlayEvaBuildingUnderAttackGDI = true;
	bCanPlayEvaBuildingUnderAttackNOD = true;

	if (Role == ROLE_Authority )
	{
		FindRefineries(); // Find the refineries so we can give players credits
	}
	GDIBotCount = GetIntOption( Options, "GDIBotCount",0);
	
	NODBotCount = GetIntOption( Options, "NODBotCount",0);
	AdjustedDifficulty = 5;
	GDIDifficulty = GetIntOption( Options, "GDIDifficulty",4);
	NODDifficulty = GetIntOption( Options, "NODDifficulty",4);
	GDIDifficulty += 3;
	NODDifficulty += 3;
	
	if (WorldInfo.NetMode == NM_DedicatedServer) //Static limits on-line
	{
		MineLimit = Rx_MapInfo(WorldInfo.GetMapInfo()).MineLimit;
		VehicleLimit= Rx_MapInfo(WorldInfo.GetMapInfo()).VehicleLimit;
	}
	else if(WorldInfo.NetMode == NM_Standalone)
	{
		MineLimit = GetIntOption( Options, "MineLimit", MineLimit);
		VehicleLimit = GetIntOption( Options, "VehicleLimit", VehicleLimit);
		//AddInitialBots();	
	}

	InitialCredits = GetIntOption(Options, "StartingCredits", InitialCredits);
	PlayerTeam = GetIntOption( Options, "Team",0);
	GDIAttackingValue = GetIntOption( Options, "GDIAttackingStrengh",0.7);
	NodAttackingValue = GetIntOption( Options, "NodAttackingStrengh",0.7);
	//Port = GetIntOption( Options, "PORT",7777);
	Port = `GamePort;
	//GamePassword = ParseOption( Options, "GamePassword");
	

	// Initialize the maplist manager
	InitializeMapListManager();

	//adding fort mutator (nBab)
	if (WorldInfo.GetmapName() == "Fort")
	{
		AddMutator("RenX_nBabMutators.Fort");
		BaseMutator.InitMutator(Options, ErrorMessage);
	}
}



defaultproperties
{
//	GameClass   = class'Rx_Mutator_AdminTool_Game'
	//bStopCountDown = true

}
