class Rx_Mutator_AdminTool_ReplicationInfo extends ReplicationInfo;		//Werkend

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_ReplicationInfo FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_ReplicationInfo FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();


}

function init(){

	LogInternal("Rx_Mutator_AdminTool_ReplicationInfo FunctionCall: init");
	
}

defaultproperties
{

}