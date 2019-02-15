//=============================================================================
// GameInfo.
//
// The GameInfo defines the game being played: the game rules, scoring, what actors
// are allowed to exist in this game type, and who may enter the game.  While the
// GameInfo class is the public interface, much of this functionality is delegated
// to several classes to allow easy modification of specific game components.  These
// classes include GameInfo, AccessControl, Mutator, and BroadcastHandler.
// A GameInfo actor is instantiated when the level is initialized for gameplay (in
// C++ UGameEngine::LoadMap() ).  The class of this GameInfo actor is determined by
// (in order) either the URL ?game=xxx, or the
// DefaultGame entry in the game's .ini file (in the Engine.Engine section), unless
// its a network game in which case the DefaultServerGame entry is used.
// The GameType used can be overridden in the GameInfo script event SetGameType(), called
// on the game class picked by the above process.
//
// Copyright 1998-2015 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class Rx_Mutator_AdminTool_GameInfo extends GameInfo
	config(Game)
	dependson(OnlineSubsystem)
	//native
	;

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GameInfo FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_GameInfo FunctionCall: PostBeginPlay");
	
	Super.PostBeginPlay();


}

function init(){

	LogInternal("Rx_Mutator_AdminTool_GameInfo FunctionCall: init");
	
}

defaultproperties
{

}

