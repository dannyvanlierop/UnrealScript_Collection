//=============================================================================
// GameReplicationInfo.
// Copyright 1998-2015 Epic Games, Inc. All Rights Reserved.
//
// Every GameInfo creates a GameReplicationInfo, which is always relevant, to replicate
// important game data to clients (as the GameInfo is not replicated).
//=============================================================================
class Rx_Mutator_AdminTool_UTGameReplicationInfo extends UTGameReplicationInfo;

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_UTGameReplicationInfo FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_UTGameReplicationInfo FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();

}

function init(){

	LogInternal("Rx_Mutator_AdminTool_UTGameReplicationInfo FunctionCall: init");

}

defaultproperties
{

}