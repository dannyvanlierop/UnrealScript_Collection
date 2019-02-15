// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu9 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
//class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Help extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;
	//DependsOn (Rx_Mutator_AdminTool_Controller);
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Overview extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;

/********************************************************************************************/
// VARIABLES DECLERATION IS DONE IN CLASS Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool
/********************************************************************************************/

/*****************************************************************************/
//  *  //  *  //  *  //  Displaying the VoteMenu  //  *  //  *  //  *  //  * //
/*****************************************************************************/
function array<string> GetDisplayStrings()
{
	local array<string> ret;
	local int u;	//items available
	local int w;	//Holder accesslevels
	local int x;	//for loops
	local int y;	//Placed items			Starts both at
	local int z;	//


	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) 
	break;
	
	if ( myAdminTool_Controller == None )
	return ret;
	
	if ( CurrentTier == 0 )
	{	
		if ( myAdminTool_Controller.iColumnNumber == 1 || myAdminTool_Controller.iColumnNumber == 2)
		{
			u = 0;
			
			//for ( x = 1; x <= myAdminTool_Controller.ModeArrayLength; x++ )
			for ( x = 1; x < myAdminTool_Controller.ModeArrayLength; x++ )
			{
				if ( myAdminTool_Controller.ModeSchedulerTimerValueArray[x] > 0)
				{
					u++;
				}
			}	
			
			//First we add the content of the first collumn
			if ( myAdminTool_Controller.iColumnNumber == 1 )
			{
				ret.AddItem(MenuDisplayString $ ": ");
				ret.AddItem(" ");
				ret.AddItem("Automatic Tasks: (" $ u $ " Modes)");
			}
			else
			{
				ret.AddItem(" ");
				ret.AddItem(" ");
				ret.AddItem(" ");
			}
			
			ret.AddItem(" ");
			
			if ( myAdminTool_Controller.iColumnNumber == 1 )
			{
				y = 0;
				for ( x = 1; x < myAdminTool_Controller.ModeArrayLength && y < 20 ; x++ )///// <=
				{
					if ( myAdminTool_Controller.ModeSchedulerTimerValueArray[x] > 0)
					{
						ret.AddItem( x $ ": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
						y++;
					}
				}
				ret.AddItem(" ");y++;
				if ( myAdminTool_Controller.PlayerReplicationInfo.bAdmin )
				{
					ret.AddItem("Other: (" $ u $ ")");y++;
					ret.AddItem(" ");y++;
					for ( x = 1; ( x < myAdminTool_Controller.ModeArrayLength ) && ( y < 20 ) ; x++ )///// <=
					{
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] <= 1 && myAdminTool_Controller.ModeDescriptionArray[x] != "Empty")
						{
							ret.AddItem( x $ ": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
							y++;
						}
					}
				}
					
				for ( x = y; x < 20 ; x++ )
				{
					ret.AddItem(" ");
				}
			}
		}
		else if ( myAdminTool_Controller.iColumnNumber >= 3 && myAdminTool_Controller.iColumnNumber <= 8 )
		{
			if ( myAdminTool_Controller.iColumnNumber == 3 || myAdminTool_Controller.iColumnNumber == 4 ){ w = 2; z = 0;}
			if ( myAdminTool_Controller.iColumnNumber == 5 || myAdminTool_Controller.iColumnNumber == 6 ){ w = 3; z = 5;}
			if ( myAdminTool_Controller.iColumnNumber == 7 || myAdminTool_Controller.iColumnNumber == 8 ){ w = 4; z = 5;}
			if ( myAdminTool_Controller.iColumnNumber == 3 || myAdminTool_Controller.iColumnNumber == 5 || myAdminTool_Controller.iColumnNumber == 7 )
			{
				u = 0;
				
				for (x = 1; x < myAdminTool_Controller.ModeArrayLength ; x++)///// <=
				{
					//if ( myAdminTool_Controller.ModeAccessLevelArray[x] == w)
					if ( myAdminTool_Controller.ModeAccessLevelArray[x] == w  && myAdminTool_Controller.ModeSchedulerTimerValueArray[x] == 0 )
					{
						u++;
					}
				}
				
				if ( z != 0 )
				{
					for (x = 1; x < myAdminTool_Controller.ModeArrayLength ; x++)///// <=
					{
						//if ( myAdminTool_Controller.ModeAccessLevelArray[x] == z)
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == z && myAdminTool_Controller.ModeSchedulerTimerValueArray[x] == 0 )
						{
							u++;
						}
					}
				}
			}
			
			ret.AddItem(" ");
			ret.AddItem(" ");
			
			if ( myAdminTool_Controller.iColumnNumber == 3 )
			{
				ret.AddItem("All Users: (" $ u $ " Modes)");
			}
			else if ( myAdminTool_Controller.iColumnNumber == 5 )
			{
				if ( myAdminTool_Controller.PlayerReplicationInfo.bAdmin )
				{
					ret.AddItem("Administrators: (" $ u $ "Modes)");
				}
				else
				{
					ret.AddItem(" ");
				}
			}
			else if ( myAdminTool_Controller.iColumnNumber == 7)
			{
				if ( myAdminTool_Controller.PlayerReplicationInfo.bAdmin || myAdminTool_Controller.bIsDev )
				{
					ret.AddItem("Developers: (" $ u $ " Modes)");
				}
				else
				{
					ret.AddItem(" ");
				}
			}
			else
			{
				ret.AddItem(" ");			
			}
			
			ret.AddItem(" ");
			
			if ( myAdminTool_Controller.iColumnNumber == 3 || ( myAdminTool_Controller.iColumnNumber == 5 && myAdminTool_Controller.PlayerReplicationInfo.bAdmin ) ||  ( myAdminTool_Controller.iColumnNumber == 7 && myAdminTool_Controller.PlayerReplicationInfo.bAdmin || myAdminTool_Controller.bIsDev ) )
			{
				y = 0;
				for (x = 1; x < myAdminTool_Controller.ModeArrayLength && y < 20 ; x++)///// <=
				{
					//if ( myAdminTool_Controller.ModeAccessLevelArray[x] == w )
					if ( myAdminTool_Controller.ModeAccessLevelArray[x] == w && myAdminTool_Controller.ModeSchedulerTimerValueArray[x] == 0 )
					{
						ret.AddItem( x $ ": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
						y++;
					}
				}
				
				if ( z != 0 )
				{
					for (x = 1; x < myAdminTool_Controller.ModeArrayLength && y < 20 ; x++)///// <=
					{
						//if ( myAdminTool_Controller.ModeAccessLevelArray[x] == z )
						if ( myAdminTool_Controller.ModeAccessLevelArray[x] == z && myAdminTool_Controller.ModeSchedulerTimerValueArray[x] == 0 )
						{
							ret.AddItem( x $ ": " $ myAdminTool_Controller.ModeDescriptionArray[x]);
							y++;
						}
					}
					z = 0;
				}
				
				
				for ( x = y; x < 20 ; x++ )
				{
					ret.AddItem(" ");				
				}
			}
		}
	}
ret.AddItem(" ");
return ret;
}
		
		


//			myAdminTool_Controller.ModeNameArray[x]
//			myAdminTool_Controller.ModeDescriptionArray[x]
//			myAdminTool_Controller.ModeStatusArray[x]
//			myAdminTool_Controller.ModeAccessLevelArray[x]
//			myAdminTool_Controller.ModeAccessByPlayersArray[x]
//			myAdminTool_Controller.ModeSchedulerTimerValueArray[x]
//			myAdminTool_Controller.ModeAutoSetDefaultValueArray[x]
//			myAdminTool_Controller.ModeAutoSetMinValueArray[x]
//			myAdminTool_Controller.ModeAutoSetMaxValueArray[x]
//			myAdminTool_Controller.ModeSchedulerTimerValueArray[x]
//			myAdminTool_Controller.ModeSchedulerTimerValueArray[x]	
			
			
			
// About choices while you in an VoteMenu at some "CurrentTier"
function KeyPress(byte T)
{

}

// About
function InputFromConsole(string text)
{

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


function string GetFooterDetails()
{
	local string ret;
	
	if ( iPageTierAvailable > 1 )
	{
		ret="Page: " $ CurrentTier + 1 $ " of " $ iPageTierAvailable $ "  View: " $ iCurrentView + 1 $ " of " $ iCurrentViewAvailable + 1;
	}
	
	return ret;
}
/*****************************************************************************/
//  *  //  *  //  *  //  *  //  Other  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/

DefaultProperties
{
	MenuDisplayString = "Overview"
	//ConsoleDisplayText = "blablaSelect option: "
}