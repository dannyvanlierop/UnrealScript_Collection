class Rx_Mutator_AdminTool_PRI extends Rx_PRI;		//Werkend
 
/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_PRI FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_PRI FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

}

function init(){

	LogInternal("Rx_Mutator_AdminTool_PRI FunctionCall: init");
	
}

defaultproperties
{

}