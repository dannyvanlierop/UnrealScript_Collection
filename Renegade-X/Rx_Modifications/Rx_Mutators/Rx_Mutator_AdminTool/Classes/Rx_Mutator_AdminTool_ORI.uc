class Rx_Mutator_AdminTool_ORI extends Rx_ORI;

//var int LastAirdropTime;
//var float T_StartTime;
//var float T_EndTime;


/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_ORI FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_ORI FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();


}

function init(){

	LogInternal("Rx_Mutator_AdminTool_ORI FunctionCall: init");
	
}

defaultproperties
{

}

