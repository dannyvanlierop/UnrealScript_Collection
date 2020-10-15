// *****************************************************************************
// * * * * * * * * * * * Rx_Mutator_AdminTool_VoteHandler  * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuHandler_Ext_AdminTool extends Rx_Mutator_AdminTool_VoteMenuHandler_Ext;

/** Define all vote submenus. Code is limited to work with 1-9 choices. */
//var array<class<Rx_VoteMenuChoice> > VoteChoiceClasses;
var array<class<Rx_VoteMenuChoice> > AdminToolChoiceClasses;

/** Current vote submenu. */
//var Rx_VoteMenuChoice VoteChoice;
//var Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool VoteChoice;

function Display(Canvas c, float HUDCanvasScale, float ConsoleMessagePosX, float ConsoleMessagePosY, Color ConsoleColor)
{
	local int i;
	local array<string> choices1,choices2,choices3,choices4,choices5,choices6,choices7,choices8;
	//local array<string> ;
	//local array<string> choices3;
	//local array<string> choices4;
	//local array<string> choices5;
	//local array<string> choices6;
	//local array<string> choices7;
	//local array<string> choices8;
	

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;

		
	if (VoteChoice != none)		//AdminTool Submenus
	{
		myAdminTool_Controller.iColumnNumber=1;	choices1 = VoteChoice.GetDisplayStrings();	choices1.AddItem("ALT/CTRL: " $ BackString );
		myAdminTool_Controller.iColumnNumber=2;	choices2 = VoteChoice.GetDisplayStrings();	choices2.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=3;	choices3 = VoteChoice.GetDisplayStrings();	choices3.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=4;	choices4 = VoteChoice.GetDisplayStrings();	choices4.AddItem(" ");	//choices4 = VoteChoice.GetFooterDetails();
		myAdminTool_Controller.iColumnNumber=5;	choices5 = VoteChoice.GetDisplayStrings();	choices5.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=6;	choices6 = VoteChoice.GetDisplayStrings();	choices6.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=7;	choices7 = VoteChoice.GetDisplayStrings();	choices7.AddItem(" ");
		myAdminTool_Controller.iColumnNumber=8;	choices8 = VoteChoice.GetDisplayStrings();	choices8.AddItem(" ");
	}
	else		//AdminTool Main menu
	{
		choices1.AddItem( myAdminTool_Controller.AdminToolCommandText $ ":" );
		choices1.AddItem(" ");
		choices1.AddItem("Select option:");
		choices1.AddItem(" ");
		
		choices1.AddItem("1: " $ AdminToolChoiceClasses[0].default.MenuDisplayString);
		choices1.AddItem("2: " $ AdminToolChoiceClasses[1].default.MenuDisplayString);
		
		//if ( ( myAdminTool_Controller.AdminToolAccessLevelAuthCheckName() ) == "Administrator" ) //Fix Later
		if ( myAdminTool_Controller.PlayerReplicationInfo.bAdmin == true )
		{
			choices1.AddItem("3: " $ AdminToolChoiceClasses[2].default.MenuDisplayString);
			choices1.AddItem("4: " $ AdminToolChoiceClasses[3].default.MenuDisplayString);
		}
		else
		{
			choices1.AddItem(" "); choices1.AddItem(" ");	
		}

		
		//Fill up with empty lines
		for (i = 0; i < (20 - AdminToolChoiceClasses.Length); i++)
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

	//Display choices in columns
	
	//myAdminTool_Controller.ScreenSizeX
	//myAdminTool_Controller.ScreenSizeY
	
	//	0,0000	8,3478		4,1739		2,7826		2,0869		1,6695		1,3913		1,1925
	//	0,0000	230,0007	460,0014	690,0022	920,0249	1150,0449	1380,0043	1610,0629		1920,0000
	//	0,0000	153,3338	306,6676	460,0014	613,3499	766,6966	920,0029	1073,3753		1280,0000
	//	0,0000	122,6671	245,3341	368,0012	490,6800	613,3573	736,0023	858,7002		1024,0000
	//	0,0000	95,8336		191,6673	287,5009	383,3437	479,1854	575,0018	670,8595		800,0000

	


	XPosMove=0;													YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices1);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 8.3478 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices2);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 4.1739 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices3);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 2.7826 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices4);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 2.0869 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices5);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.6695 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices6);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.3913 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices7);
	XPosMove=( myAdminTool_Controller.ScreenSizeX / 1.1925 );	YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices8);		








	
//	XPosMove=0;			YPosMove=8;		DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices1);
//	XPosMove=230;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices2);
//	XPosMove=460;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices3);
//	XPosMove=690;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices4);
//	XPosMove=920;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices5);
//	XPosMove=1150;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices6);
//	XPosMove=1380;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices7);
//	XPosMove=1610;		YPosMove=8;	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices8);		
}


function KeyPress(byte T)
{
	if (VoteChoice == none)
	{
		// select vote submenu first
		if ( T - 1 >= AdminToolChoiceClasses.Length ) return; // wrong key
		
		//enable options above 1 only for administrators
		//if ( T > 1 && ( myAdminTool_Controller.AdminToolAccessLevelAuthCheckName() ) != "Administrator") return;
		if ( T > 2 && myAdminTool_Controller.PlayerReplicationInfo.bAdmin == false )
		return;

		VoteChoice = new (self) AdminToolChoiceClasses[T - 1];
		VoteChoice.Handler = self;
		VoteChoice.Init();
	}
	else VoteChoice.KeyPress(T); // forward to submenu
}

DefaultProperties
{
	AdminToolChoiceClasses(0) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Overview';
	AdminToolChoiceClasses(1) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Help';
	AdminToolChoiceClasses(2) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Commands';
	AdminToolChoiceClasses(3) = class'Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Summary';
}