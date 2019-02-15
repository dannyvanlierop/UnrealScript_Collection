// *****************************************************************************
// * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic  * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic extends Rx_Mutator_AdminTool_VoteMenuHandler_Ext;

/** Define all vote submenus. Code is limited to work with 1-9 choices. */
//var array<class<Rx_VoteMenuChoice> > VoteChoiceClasses;

/** Current vote submenu. */
//var Rx_VoteMenuChoice VoteChoice;
//var Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic VoteChoice

//VoteChoice = class'Rx_VoteMenuChoice'
function Display(Canvas c, float HUDCanvasScale, float ConsoleMessagePosX, float ConsoleMessagePosY, Color ConsoleColor){

	local array<string> choices1;
	local array<string> choices2;
	local array<string> choices3;
	local array<string> choices4;
	local array<string> choices5;
	local array<string> choices6;
	local array<string> choices7;
	local array<string> choices8;
	
	local int i;
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (VoteChoice != none)
	{
		myAdminTool_Controller.iColumnNumber=1;	choices1 = VoteChoice.GetDisplayStrings();	//choices1.AddItem("ALT/CTRL: " $ BackString);
		myAdminTool_Controller.iColumnNumber=2;	choices2 = VoteChoice.GetDisplayStrings();	//choices2.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=3;	choices3 = VoteChoice.GetDisplayStrings();	//choices3.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=4;	choices4 = VoteChoice.GetDisplayStrings();	//choices4.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=5;	choices5 = VoteChoice.GetDisplayStrings();	//choices5.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=6;	choices6 = VoteChoice.GetDisplayStrings();	//choices6.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=7;	choices7 = VoteChoice.GetDisplayStrings();	//choices7.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=8;	choices8 = VoteChoice.GetDisplayStrings();	//choices8.AAddItem(" ");
	}
	else
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			choices1.AddItem( myAdminTool_Controller.AdminToolCommandText $ ":" );
			choices1.AddItem(" ");
			choices1.AddItem("Select option:");
			choices1.AddItem(" ");
		}
		else			///Vote Submenu
		{
			choices1.AddItem( myAdminTool_Controller.VoteCommandText $ ":" );
			choices1.AddItem(" ");
			choices1.AddItem("Select option:");
			choices1.AddItem(" ");
		}
		
		for (i = 0; i < 9; i++)
		{
			//if ( i == 8 && myAdminTool_Controller.ModeAccessByPlayersArray[0] == 0 )
			if ( i == 8 && myAdminTool_Controller.iAccessByPlayersVoteMenuExtension == 0 )
			{
				if ( myAdminTool_Controller.PlayerReplicationInfo.bAdmin == false )
				{
					choices1.AddItem(" ");
				}
				else
				{
					choices1.AddItem(string(i + 1) $ ": " $ VoteChoiceClasses[i].default.MenuDisplayString $ " (Visible for Admins)" );
				}
			}
			else
			{
				choices1.AddItem(string(i + 1) $ ": " $ VoteChoiceClasses[i].default.MenuDisplayString);
			}
		}
		
		//Fill up with empty lines
		for (i = 0; i < (20 - 9); i++)
		{
			choices1.AddItem(" ");
		}
		
		choices1.AddItem(" "); choices1.AddItem("ALT/CTRL: " $ ExitString);
		choices2.AddItem(" "); choices2.AddItem(" ");
		choices3.AddItem(" "); choices3.AddItem(" ");
		choices4.AddItem(" "); choices4.AddItem(" ");
		choices5.AddItem(" "); choices5.AddItem(" ");
		choices6.AddItem(" "); choices6.AddItem(" ");
		choices7.AddItem(" "); choices7.AddItem(" ");
		choices8.AddItem(" "); choices8.AddItem(" ");
	}

	XPosMove=0;													YPosMove=8; DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices1);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 8.3478 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices2);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 4.1739 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices3);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 2.7826 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices4);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 2.0869 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices5);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.6695 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices6);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.3913 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices7);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.1925 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices8);
}


function KeyPress(byte T)
{
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (VoteChoice == none)
	{
		// select vote submenu first
		if (T - 1 >= VoteChoiceClasses.Length)
		{
			return; // wrong key
		}
		
		//if ( T == 9 && myAdminTool_Controller.ModeAccessByPlayersArray[0] == 0 && myAdminTool_Controller.AdminToolAccessLevelAuth(3) == false )
		//{
		//	return;
		//}

		//if ( T == 9 && myAdminTool_Controller.ModeAccessByPlayersArray[0] == 0 && myAdminTool_Controller.PlayerReplicationInfo.bAdmin == false )
		if ( T == 9 && myAdminTool_Controller.iAccessByPlayersVoteMenuExtension == 0 && myAdminTool_Controller.PlayerReplicationInfo.bAdmin == false )
		{
			return; // wrong key
		}
		
		if( T-1 >= 0 && T-1 < 3 ) 
		{
			if(!PlayerOwner.CanVoteMapChange() )  
			{
			PlayerOwner.CTextMessage("You have entered a ChangeMap/Surrender Vote too recently",'Orange',80);
			return;
			}
		}
		
		VoteChoice = new (self) VoteChoiceClasses[T - 1];
		VoteChoice.Handler = self;
		VoteChoice.Init();
	}
	else VoteChoice.KeyPress(T); // forward to submenu
}

DefaultProperties
{
	VoteChoiceClasses(0) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_RestartMap'
	VoteChoiceClasses(1) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_ChangeMap'
	VoteChoiceClasses(2) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Surrender'
	VoteChoiceClasses(3) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_AddBots'
	VoteChoiceClasses(4) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_RemoveBots'
	VoteChoiceClasses(5) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Kick'
	VoteChoiceClasses(6) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Survey'
	VoteChoiceClasses(7) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_MineBan'
	VoteChoiceClasses(8) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_AdvancedVotes'
}
