//class Rx_GFxHud extends GFxMoviePlayer;
class Rx_Mutator_AdminTool_GFxHud extends GFxMoviePlayer;

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GFxHud FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GFxHud FunctionCall: PostBeginPlay");
	
	//Super.PostBeginPlay();

	//SetTimer(0.2,false,'init');
}


defaultproperties
{

}