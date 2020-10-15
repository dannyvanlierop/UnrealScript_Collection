// *****************************************************************************
// * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenuHandler_Ext_Basic  * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuHandler_Ext extends Rx_VoteMenuHandler
	DependsOn (Rx_Mutator_AdminTool_Controller);

var Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
var Rx_Mutator_AdminTool_Controller allAdminTool_Controllers;

var int XPosMove;
var int YPosMove;

/** Exit (or go back) string displayed in menu. */
//var string ExitString;
//var string BackString;

//var Rx_Controller PlayerOwner;

// called when vote menu is shown
function Enabled(Rx_Controller p)
{
	PlayerOwner = p;
}

// called when alt is pressed
function bool Disabled()
{
	if (VoteChoice != none)
	{
		if (VoteChoice.GoBack())
		{
			VoteChoice = none;
		}

		return false; // do not kill vote menu yet
	}
	else return true; // return true to kill vote menu
}

// called from submenu to close handler
function Terminate()
{
	VoteChoice = none;
	PlayerOwner.DisableVoteMenu();
}

function DisplayChoices(Canvas c, 
	float HUDCanvasScale, 
	float ConsoleMessagePosX, 
	float ConsoleMessagePosY,
	Color ConsoleColor, 
	array<string> choices)
{
	local int Idx, XPos, YPos;
	local float XL, YL;

	//added XPosMove and YPosMove to move the Choices and sort them in columns.
	XPos = (ConsoleMessagePosX * HudCanvasScale * c.SizeX) + (((1.0 - HudCanvasScale) / 2.0) * c.SizeX + XPosMove);
    YPos = (ConsoleMessagePosY * HudCanvasScale * c.SizeY) + 20* (((1.0 - HudCanvasScale) / 2.0) * c.SizeY + YPosMove);
    
    //c.Font = Font'RenXHud.Font.RadioCommand_Medium';
    //c.DrawColor = ConsoleColor;
	
		if ( myAdminTool_Controller.ScreenSizeX > 1900 && myAdminTool_Controller.ScreenSizeX > 1000 )
		{
			c.Font = Font'RenXHud.Font.RadioCommand_Medium'; //class'Engine'.Static.GetMediumFont();
		}
		else
		{
			c.Font = Font'RenXHud.Font.ScoreBoard_Small'; //class'Engine'.Static.GetMediumFont();
			//c.Font = class'Engine'.Static.GetSmallFont(); //class'Engine'.Static.GetMediumFont();
			//c.Font = Font'RenxHud.Font.CTextFont24pt'; //CText_Text=Font'RenxHud.Font.CText_Agency32pt' ;
		}
    
    //Canvas.Font = Font'RenXHud.Font.RadioCommand_Medium'; //class'Engine'.Static.GetMediumFont();
    c.DrawColor = ConsoleColor;
	
    c.TextSize("A", XL, YL);
    YPos -= YL * choices.Length;
    YPos -= YL;

    for (Idx = 0; Idx < choices.Length; Idx++)
    {
    	c.StrLen(choices[Idx], XL, YL);
		c.SetPos(XPos, YPos);
		c.DrawText(choices[Idx], false);
		YPos += YL;
    }
}

static function DisplayOngoingVote(Rx_Controller p, Canvas c, float HUDCanvasScale, Color ConsoleColor)
{
	local int XPos, YPos;
	local float XL, YL;
	local string t;

	if (p.VoteTopString == "") return;

	c.Font = Font'RenXHud.Font.RadioCommand_Medium';
    c.DrawColor = ConsoleColor;
	
    //Canvas.Font = Font'RenXHud.Font.AS_Med'; 
    //Canvas.Font = Font'RenXHud.Font.ScoreBoard_Small'; //Font'RenXHud.Font.AS_small';
    //Canvas.Font = Font'RenxHud.Font.CTextFont12pt'; //CText_Text=Font'RenxHud.Font.CText_Agency32pt' ;äää
    //Canvas.Font = Font'RenXHud.Font.RadioCommand_Medium';
	//Canvas.Font = class'Engine'.Static.GetTinyFont();
	//Canvas.Font = class'Engine'.Static.GetSmallFont();
	//Canvas.Font = class'Engine'.Static.GetMediumFont();
	//Canvas.Font = class'Engine'.Static.GetLargeFont();
	//Canvas.Font = class'Engine'.Static.GetSubtitleFont();
	//Canvas.Font = class'Engine'.Static.GetAdditionalFont();
    //Canvas.Font = class'Engine'.Static.c.DrawColor = ConsoleColor;
    //Canvas.Font = class'Engine'.Static.c.DrawColor=(R=255,G=0,B=128,A=255)

	

	c.TextSize(p.VoteTopString, XL, YL);

	XPos = (c.SizeX / 2) - (XL / 2);
	YPos = 20;

	c.SetPos(XPos, YPos);
	c.DrawText(p.VoteTopString, false);
	YPos += YL;
	c.SetPos(XPos, YPos);
	t = "F1: Yes (" $ string(p.VotesYes) $ ") F2: No (" $ string(p.VotesNo) $ ") - " $ p.YesVotesNeeded $ " Yes votes needed, " $ string(p.VoteTimeLeft) $ " seconds left";
	c.DrawText(t, false);
}


DefaultProperties
{
	ExitString = "Exit"
	BackString = "Back"
}