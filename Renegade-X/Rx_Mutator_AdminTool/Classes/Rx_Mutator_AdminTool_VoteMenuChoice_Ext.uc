// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu0 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext extends Rx_VoteMenuChoice
	DependsOn (Rx_Mutator_AdminTool_Controller);

var Rx_Controller PlayerOwner;
//var Rx_Mutator_AdminTool_Controller PlayerOwner;					//Holds the CurrentTier choosen

//var Rx_Controller pc;
var Rx_PRI myRx_PRI;
var GameReplicationInfo myGameReplicationInfo;
var Rx_Controller myRx_Controller;									//
var Rx_Mutator_AdminTool_Controller myAdminTool_Controller;			//
var Rx_Mutator_AdminTool_Controller allAdminTool_Controllers;       //

var int CurrentTier;												//Holds the CurrentTier choosen
var int iCurrentTierAvailable;          							//Holds the Max CurrentTier available
							
var int iCurrentView;												//Holds the iCurrentView choosen
var int iCurrentViewAvailable;          							//Holds the Max iCurrentView available
							
var string sModeDescription;										//Holds the Description of choice choosen
var string sModeStatus;												//Holds the Status of choice choosen
							
var int iModeName;													//Holds the Name of choice choosen
var int iModeStatus;                    							//Holds the Status of choice choosen
var int iModeAccessLevel;											//Holds the AccessLevel of choice choosen
							
var int iPageTierAvailable;											//Holds the Description of choice choosen
							
var int iItemsListedPage;											//Holds the Items Listed on 1 page
var int iItemsAvailable;                							//Holds the Status of choice choosen
						
var string ConsoleDisplayText;						
var string ConsoleDisplayTextPlayerName;							//Holds the Items Listed on 1 page
																	//Holds the Status of choice choosen
var string sNameHolder;
var int iKeyHolder;


function GoOtherTier(optional bool bGoBack){	//	False = Go Previous Tier //	True = Go Next Tier


	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (myAdminTool_Controller.bMenuUnlocked)
	{
		myAdminTool_Controller.MenuLockToggle(true);
		
		if (bGoBack)
		{
			CurrentTier=(CurrentTier--); 
		}
		else
		{
			CurrentTier=(CurrentTier++); 
		}
	}
}
function GoOtherView(optional bool bGoBack){	//	False = Go Previous View	//	True = Go Next View


	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (myAdminTool_Controller.bMenuUnlocked)
	{
		myAdminTool_Controller.MenuLockToggle(true);
		
		if (bGoBack)
		{
			iCurrentView=(iCurrentView--); 
		}
		else
		{
			iCurrentView=(iCurrentView++); 
		}
	}
}


final static function object GetDefaultObject(class ObjClass){

	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}


function string GetFooterDetails()
{
	local string ret;
	
	if ( iPageTierAvailable > 1 )
	{
		ret="Page: " $ CurrentTier + 1 $ " of " $ iPageTierAvailable $ "  View: " $ iCurrentView + 1 $ " of " $ iCurrentViewAvailable + 1;
	}
	
	return ret;
}



//		// Reset all Defaults here
//		function Init()
//		{
//		}
//		
//		function KeyPress(byte T)
//		{
//		}
//		
//		function array<string> GetDisplayStrings()
//		{
//		}
//		
//		// return true to kill this submenu
//		function bool GoBack()
//		{
//			return true;
//		}
//		
//		//call to execute vote
//		function Finish()
//		{
//		
//		}
//		
//		//input from console, custom parsing in each subclass
//		function InputFromConsole(string text)
//		{
//		}
//		
//		//Override serialization procedures
//		function string SerializeParam()
//		{
//			return "";
//		}
//		function DeserializeParam(string param)
//		{
//		
//		}
//		
//		
//		//Server side functions
//		function ServerInit(Rx_Controller instigator, string param, int t)
//		{
//		
//		}
//		
//		static function string TeamTypeToString(int type)
//		{
//			return "";
//		}
//		
//		function ServerSecondTick(Rx_Game game)
//		{
//		
//		}
//		
//		function UpdatePlayers(WorldInfo wi)
//		{
//		
//		}
//		
//		function string ComposeTopString()
//		{
//			return "";
//		}
//		
//		/** Syntax: [ key | value [... | key | value ] ] */
//		function string ParametersLogString()
//		{
//			return "";
//		}
//		
//		function int GetTotalVoters(Rx_Game game)
//		{
//			return 0;
//		}
//		
//		// verify whether enough votes for execute
//		function bool CanExecute(Rx_Game game)
//		{
//			return false;
//		}
//		
//		function int GetNeededYesVotes(Rx_Game game)
//		{
//			return 0;
//		}
//		
//		// execute vote
//		function Execute(Rx_Game game)
//		{
//		
//		}
//		
//		function DestroyVote(Rx_Game game)
//		{
//		
//		}
//		
//		function bool CanVote(Rx_Controller p)
//		{
//		
//		}
//		
//		function int PlayerCount(out array<Rx_Controller> arr)
//		{
//		
//		}
//		
//		function PlayerVoteYes(Rx_Controller p)
//		{
//		
//		}
//		
//		function PlayerVoteNo(Rx_Controller p)
//		{
//		
//		}

DefaultProperties
{
	// Need 1/5 of the game to vote yes with 0 no votes to pass. Every no votes requires one more yes vote.
	PercentYesToPass = 0.2f;
	TimeLeft = 3 // seconds
	ToTeam = -1
}
