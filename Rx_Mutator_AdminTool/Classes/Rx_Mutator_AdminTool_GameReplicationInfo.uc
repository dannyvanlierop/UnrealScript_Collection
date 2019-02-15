//=============================================================================
// GameReplicationInfo.
// Copyright 1998-2015 Epic Games, Inc. All Rights Reserved.
//
// Every GameInfo creates a GameReplicationInfo, which is always relevant, to replicate
// important game data to clients (as the GameInfo is not replicated).
//=============================================================================
class Rx_Mutator_AdminTool_GameReplicationInfo extends Rx_GRI		//
	config(Game)
//	native(ReplicationInfo)
//	nativereplication
;

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GameReplicationInfo FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GameReplicationInfo FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

	SetTimer(0.2,false,'init');
}

function init(){

	LogInternal("Rx_Mutator_AdminTool_GameReplicationInfo FunctionCall: init");
	
}


defaultproperties
{

}
