/*
** Rx_CommandMenuHandler
*/

class Rx_CommandMenuHandler extends Rx_VoteMenuHandler; //Extending VotemenuHandler let's us fake that we're just a vote menu to Rx_Controller. Keybind for this will be set in the Extended HUD object.

/** Define all Command submenus.  Code is limited to work with 1-9 choices. / Yosh EDIT: To think I was going to try and make a 3D array is kind of scary.*/
var array<class<Rx_CommandMenuChoice> > CommandMenuChoices;
var Rx_CommanderController CC;
/** Current vote submenu. */
var Rx_CommandMenuChoice CommandChoice;

/** Exit (or go back) string displayed in menu. */
var string ExitString;
var string BackString;

var Rx_Controller PlayerOwner;

// called when vote menu is shown
function Enabled(Rx_Controller p)
{
	local Rx_CommanderController CCON;

	PlayerOwner = p;
	
	CC=Rx_HUD_Ext(p.myHUD).myCC;
	
}
	

// called when alt is pressed
function bool Disabled()
{
	if (CommandChoice != none)
	{
		if (CommandChoice.GoBack())
		{
			CommandChoice = none;
		}

		return false; // do not kill vote menu yet
	}
	else return true; // return true to kill vote menu
}

// called from submenu to close handler
function Terminate()
{
	CommandChoice = none;
	PlayerOwner.DisableVoteMenu();
}

function Display(Canvas c, float HUDCanvasScale, float ConsoleMessagePosX, float ConsoleMessagePosY, Color ConsoleColor)
{
	local int i;
	local array<string> choices;

	if (CommandChoice != none)
	{
		choices = CommandChoice.GetDisplayStrings();
		choices.AddItem("[ALT] " $ BackString);
	}
	else
	{
		for (i = 0; i < CommandMenuChoices.Length; i++)
			choices.AddItem(string(i + 1) $ ": " $ CommandMenuChoices[i].default.MenuDisplayString);

		choices.AddItem("[ALT] " @ ExitString);
	}

	

	DisplayChoices(c, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor, choices);
}

function KeyPress(byte T)
{
	if (CommandChoice == none)
	{
		// select vote submenu first
		
		if (T - 1 >= CommandMenuChoices.Length) return; // wrong key

		CommandChoice = new (self) CommandMenuChoices[T - 1];
		CommandChoice.Handler = self;
		CommandChoice.myCC=CC;
		CommandChoice.LocalTeam=PlayerOwner.GetTeamNum();
		CommandChoice.Init();
	}
	else CommandChoice.KeyPress(T); // forward to submenu
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

	XPos = (ConsoleMessagePosX * HudCanvasScale * c.SizeX) + (((1.0 - HudCanvasScale) / 2.0) * c.SizeX);
    YPos = (ConsoleMessagePosY * HudCanvasScale * c.SizeY) + 20* (((1.0 - HudCanvasScale) / 2.0) * c.SizeY);
    
    c.Font = Font'RenXHud.Font.RadioCommand_Medium';
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

