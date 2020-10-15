class Rx_Mutator_AdminTool_WorldInfo extends WorldInfo;

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_WorldInfo FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_WorldInfo FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

	SetTimer(0.2,false,'init');
}

function init(){

	LogInternal("Rx_Mutator_AdminTool_WorldInfo FunctionCall: init");
	
}

defaultproperties
{

}