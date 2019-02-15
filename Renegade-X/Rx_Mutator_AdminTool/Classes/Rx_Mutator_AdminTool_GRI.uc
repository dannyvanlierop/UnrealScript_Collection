class Rx_Mutator_AdminTool_GRI extends Rx_GRI;

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

//`define MapVoteMaxSize 9
//	var() class<GameReplicationInfo> GameReplicationInfoClass;
//	var GameReplicationInfo GameReplicationInfo;

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GRI FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GRI FunctionCall: PostBeginPlay");
	
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

	LogInternal("Rx_Mutator_AdminTool_GRI FunctionCall: init");
	
}

simulated event Timer()
{
	super(GameReplicationInfo).Timer();
	
	if ( (WorldInfo.Game == None) || WorldInfo.Game.MatchIsInProgress() )
	{
		ElapsedTime--;
	}
	if ( WorldInfo.NetMode == NM_Client )
	{
		// sync remaining time with server once a minute
		if ( RemainingMinute != 0 )
		{
			RemainingTime = RemainingMinute;
			RemainingMinute = 0;
		}
	}
	if ( (RemainingTime > 0) && !bStopCountDown )
	{
		//RemainingTime--;
		RemainingTime++;
		if ( WorldInfo.NetMode != NM_Client )
		{
			if ( RemainingTime % 60 == 0 )
			{
				RemainingMinute = RemainingTime;
			}
		}
	}

	SetTimer(WorldInfo.TimeDilation, true);
}

defaultproperties
{
	GameClass   = class'Rx_Mutator_AdminTool_Game'
	//bStopCountDown = true

}
