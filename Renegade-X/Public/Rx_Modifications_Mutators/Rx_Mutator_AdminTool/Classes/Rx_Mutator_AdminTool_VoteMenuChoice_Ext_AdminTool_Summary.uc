// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu9 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Summary extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;

/********************************************************************************************/
// VARIABLES DECLERATION IS DONE IN CLASS Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool
/********************************************************************************************/

/*****************************************************************************/
//  *  //  *  //  *  //  Displaying the VoteMenu  //  *  //  *  //  *  //  * //
/*****************************************************************************/
function array<string> GetDisplayStrings()
{
	local array<string> ret;
	local int v,w,x;
	local int iColumnNumber;
	local int iPageTier;
	local int iPageTierAvailableRemainder;

	iCurrentViewAvailable=1;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	//Workaround to add stuff to columns.
	iColumnNumber=( myAdminTool_Controller.iColumnNumber );
	
	//Set iPageTier to current page number
	iPageTier=(CurrentTier + 1);
	
	//Check available items minus empty ones
	iItemsAvailable=myAdminTool_Controller.ModeArrayLength;
	for (x = 0; x < myAdminTool_Controller.ModeArrayLength ; x++)
	{
		if ( myAdminTool_Controller.ModeDescriptionArray[x] == "Empty" )
		{
			iItemsAvailable--;
		}
	}
	
	//Check available pages, devided by max items for each page, if there is a remainder, add one page more
	iPageTierAvailable = (iItemsAvailable / iItemsListedPage);
	iPageTierAvailableRemainder = iItemsAvailable % iItemsListedPage;
	if (iPageTierAvailableRemainder > 0) { iPageTierAvailable++; }
	
	//modify this Tier, change it to 1 dynamic tier.
	v=(CurrentTier) * iItemsListedPage;
	w=(v)+iItemsListedPage;
	if ( CurrentTier != 0 ) { v++; } //Only show on the first page 21 items (AdminTool mode0 included)
	
	//Add keys to change views
	if ( iCurrentView > 0 && myAdminTool_Controller.bKeyLeftPressed) { GoOtherView(true); }
	if ( iCurrentView >= 0 && iCurrentView < iCurrentViewAvailable && myAdminTool_Controller.bKeyRightPressed ) { GoOtherView(); }
	
	//Add keys to change pages
	if ( CurrentTier > 0 && myAdminTool_Controller.bKeyUpPressed) { GoOtherTier(true); }
	if ( iPageTierAvailable > iPageTier && myAdminTool_Controller.bKeyDownPressed ) { GoOtherTier(); }
		
	if ( CurrentTier >= 0)	
	{
		if ( iCurrentView == 0 )			
		{
			if (iColumnNumber == 1)
			{
				ret.AddItem(MenuDisplayString $ ": ");
				ret.AddItem(" ");
				ret.AddItem("Number: ");
			}
			else if (iColumnNumber == 2) { ret.AddItem("Name: ") ; }	
			else if (iColumnNumber == 3) { ret.AddItem("Status: ") ; }
			else if (iColumnNumber == 4)
			{
				ret.AddItem( "Page: " $ CurrentTier + 1 $ " of " $ iPageTierAvailable $ "  View: " $ iCurrentView + 1 $ " of " $ iCurrentViewAvailable + 1); // ret.AddItem("Page " $ iPageTier $ " of " $ iPageTierAvailable $ " ( Use arrowkey to change page )");	//iPageTierAvailable != 0
				ret.AddItem(" ");
				ret.AddItem("AccessLevel: ") ;
			}
			else if (iColumnNumber == 5) { ret.AddItem("AccessByPlayers: ") ; }
			else if (iColumnNumber == 6) { ret.AddItem("SchedulerTimerValue: ") ; }
			else if (iColumnNumber == 7) { ret.AddItem("CustomSetValue: ") ; }
			else if (iColumnNumber == 8) { ret.AddItem(" ") ; }
		}
		else if ( iCurrentView == 1 )
		{
			if (iColumnNumber == 1) { ret.AddItem(MenuDisplayString $ ": ") ; }	
			if (iColumnNumber == 1) { ret.AddItem(" ") ; }	
			if (iColumnNumber == 1) { ret.AddItem("DefaultValue: ") ; }	
			else if (iColumnNumber == 2) { ret.AddItem(" ") ; }	
			else if (iColumnNumber == 3) { ret.AddItem("VoteValue: ") ; }
			else if (iColumnNumber == 4)
			{
				ret.AddItem( "Page: " $ CurrentTier + 1$ " of " $ iPageTierAvailable $ "  View: " $ iCurrentView + 1 $ " of " $ iCurrentViewAvailable + 1); // ret.AddItem("Page " $ iPageTier $ " of " $ iPageTierAvailable $ " ( Use arrowkey to change page )");	//iPageTierAvailable != 0
				ret.AddItem(" ");
				ret.AddItem(" ") ;
			}
			else if (iColumnNumber == 5) { ret.AddItem("MinValue: ") ; }
			else if (iColumnNumber == 6) { ret.AddItem(" ") ; }
			else if (iColumnNumber == 7) { ret.AddItem("MaxValue: ") ; }
			else if (iColumnNumber == 8) { ret.AddItem(" ") ; }		
		}
	
		ret.AddItem(" "); //Add empty line between items and Header (All iColumns)

		for (x = v; x <= w ; x++)
		{
			if ( x > iItemsAvailable )	//Skip empty items
			{
				ret.AddItem(" ");;
			}
			else
			{
				if ( iCurrentView == 0 )
				{
					if ( iColumnNumber == 1 )
					{
						ret.AddItem( x $ " : " $ myAdminTool_Controller.ModeNameArray[x] );
					}
					else if ( iColumnNumber == 2 )
					{
						ret.AddItem( myAdminTool_Controller.ModeDescriptionArray[x] );
					}
					else if ( iColumnNumber == 3 )
					{ 
						if ( myAdminTool_Controller.ModeStatusArray[x] ~= "true" ) { ret.AddItem( "Enabled" ) ;}
						if ( myAdminTool_Controller.ModeStatusArray[x] ~= "false" ) { ret.AddItem( "Disabled" ) ;}
					}
					else if ( iColumnNumber == 4 )
					{
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] <= 1 ) { ret.AddItem( "(" $ myAdminTool_Controller.ModeAccessLevelArray[x] $ ") Nobody ") ;}
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == 2 ) { ret.AddItem( "(" $ myAdminTool_Controller.ModeAccessLevelArray[x] $ ") All Users ") ;}
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == 3 ) { ret.AddItem( "(" $ myAdminTool_Controller.ModeAccessLevelArray[x] $ ") Administrators ") ;}
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == 4 ) { ret.AddItem( "(" $ myAdminTool_Controller.ModeAccessLevelArray[x] $ ") Developers ") ;}
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == 5 ) { ret.AddItem( "(" $ myAdminTool_Controller.ModeAccessLevelArray[x] $ ") Admin or Dev ") ;}
					}
					else if ( iColumnNumber == 5 )
					{
						if ( myAdminTool_Controller.ModeAccessByPlayersArray[x] == 0 ) { ret.AddItem( "Denied" ) ;}
						if ( myAdminTool_Controller.ModeAccessByPlayersArray[x] == 1 ) { ret.AddItem( "Allowed" ) ;}
					}
					else if ( iColumnNumber == 6 )
					{
						if ( myAdminTool_Controller.ModeSchedulerTimerValueArray[x] <= 0 )
						{
							ret.AddItem(" Disabled ");
						}
						else
						{
							ret.AddItem( string(myAdminTool_Controller.ModeSchedulerTimerValueArray[x]) );
						}
					}
					else if ( iColumnNumber == 7 )
					{
						if ( myAdminTool_Controller.ModeAutoSetCustomValueArray[x] == "" )
						{
							ret.AddItem(" ");
						}
						else
						{
							ret.AddItem( myAdminTool_Controller.ModeAutoSetCustomValueArray[x] );
						}
					}
					else if ( iColumnNumber == 8 )
					{
						ret.AddItem(" ");
					}
				}
				else if ( iCurrentView == 1 )
				{
					if ( iColumnNumber == 1 )		//SetDefault
					{
						if ( myAdminTool_Controller.ModeAutoSetDefaultValueArray[x] == "" )
						{
							ret.AddItem( x $ " : " $ " ");
						}
						else
						{
							ret.AddItem( x $ " : " $ myAdminTool_Controller.ModeAutoSetDefaultValueArray[x] );
						}
					}
					else if ( iColumnNumber == 2 )
					{
						ret.AddItem(" ");
					}
					else if ( iColumnNumber == 3 )		//SetVote
					{
						if ( myAdminTool_Controller.ModeAutoSetVoteValueArray[x] == "" )
						{
							ret.AddItem(" ");
						}
						else
						{
							ret.AddItem( myAdminTool_Controller.ModeAutoSetVoteValueArray[x] );
						}
					}
					else if ( iColumnNumber == 4 )
					{
						ret.AddItem(" ");
					}
					else if ( iColumnNumber == 5 )		//SetMin
					{
						if ( myAdminTool_Controller.ModeAutoSetMinValueArray[x] == "" )
						{
							ret.AddItem(" ");
						}
						else
						{
							ret.AddItem( myAdminTool_Controller.ModeAutoSetMinValueArray[x] );
						}
					}
					else if ( iColumnNumber == 6 )
					{
						ret.AddItem(" ");
					}
					else if ( iColumnNumber == 7 )		//SetMax
					{
						if ( myAdminTool_Controller.ModeAutoSetMaxValueArray[x] == "" )
						{
							ret.AddItem(" ");
						}
						else
						{
							ret.AddItem( myAdminTool_Controller.ModeAutoSetMaxValueArray[x] );
						}
					}
					else if ( iColumnNumber == 8 )
					{
						ret.AddItem(" ");
					}
				}
			}
		}
		
		if ( CurrentTier != 0 ){ ret.AddItem(" ");; } // add a blank line to pages that have 20 items instead of 21.
	}	
	return ret;
}

function bool GoBack()
{
	switch (CurrentTier)
	{
		case 0:
			return true; // kill this submenu
			
		default:
			if (CurrentTier > 1)
			{
				CurrentTier = 0;
				return false;
			}
	
			CurrentTier = 0;
			return false;
	}
}


/*****************************************************************************/
//  *  //  *  //  *  //  *  //  Other  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/

function KeyPress(byte T)
{

}

function InputFromConsole(string sText)
{

}

function Finish()
{

}

function string SerializeParam()
{

}

function DeserializeParam(string param)
{

}

function string ComposeTopString()
{

}

function string ParametersLogString()
{

}

function Execute(Rx_Game game)
{

}

// Server side functions. 
function ServerInit(Rx_Controller instigator, string param, int t)
{

}


static function string TeamTypeToString(int type)
{

}

function ServerSecondTick(Rx_Game game)
{

}

function UpdatePlayers(WorldInfo wi)
{

}

function int GetTotalVoters(Rx_Game game)
{

}

// verify whether enough votes for execute
function bool CanExecute(Rx_Game game)
{

}

function int GetNeededYesVotes(Rx_Game game)
{

}

function DestroyVote(Rx_Game game)
{

}

function bool CanVote(Rx_Controller p)
{

}

function int PlayerCount(out array<Rx_Controller> arr)
{

}

function PlayerVoteYes(Rx_Controller p)
{

}

function PlayerVoteNo(Rx_Controller p)
{

}


DefaultProperties
{
	MenuDisplayString = "Summary"
	ConsoleDisplayText = "AdminTool Mode"
	iItemsListedPage=20;
}