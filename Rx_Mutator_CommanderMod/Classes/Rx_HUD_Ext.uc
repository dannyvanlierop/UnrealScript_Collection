/*
** Rx_HUD_Ext
*/

class Rx_HUD_Ext extends Rx_HUD ; 


var Rx_Hud_ObjectiveBox OBox ; 
var Rx_HUD_ObjectiveVisuals TargetVisuals;
var Rx_CommanderController myCC;
var int ExtraVoteNum;
var name OboxKey, CMenuKey;
var bool bCMenuOpen;


var string CommanderColor, CoCommanderColor,SupportCommanderColor, GDIColor, NodColor, NeutralColor, PrivateFromColor, PrivateToColor, HostColor;


simulated function PostBeginPlay() 
{
local Rx_CommanderController CCON;
local string CBind;
		
		super.PostBeginPlay();
	
	Rx_Controller(PlayerOwner).PlayerInput.SetBind(OboxKey, "CycleOBox") ;
	
	/**
	CBind=Rx_Controller(PlayerOwner).PlayerInput.GetBind(CMenuKey) ;
	`log("0000000000000000000000000000000000" @ CBind);
	Rx_Controller(PlayerOwner).PlayerInput.SetBind(CMenuKey, CBind @ "|" @ "OpenCommandMenu") ;
	*/
	
	SetTimer(2.0, false, 'GetCCTimer');
	
	/**foreach AllActors(class'Rx_CommanderController', CCON)
	{
		myCC = CCON ;
		break;
	}
	*/
}

exec function CycleOBox()
{
	OBox.UpdateStateFlag=true;
	return;
}

/**exec function OpenCommandMenu()
{
local Rx_Controller	PC;
local Rx_PlayerInput PCPI;
	
PC=Rx_Controller(PlayerOwner);
PCPI=Rx_PlayerInput(PC.PlayerInput);


if(PCPI.bCntrlPressed && !PC.IsVoteMenuEnabled())
	{
		// just in case, turn off previous one
	PC.DisableVoteMenu();

	PC.VoteHandler = new (PC) class'Rx_CommandMenuHandler';
	PC.VoteHandler.Enabled(PC);
	
	bCMenuOpen=true;
	}
	
if(PCPI.bCntrlPressed && PC.IsVoteMenuEnabled())
	{
	 just in case, turn off previous one
	PC.DisableVoteMenu();

	bCMenuOpen=false;
	}
	
	
} 
*/
	

function CreateHudCompoenents()
{
	TargetVisuals = New class'Rx_HUD_ObjectiveVisuals'		;
	CommandText = New class'Renx_Game.Rx_HUD_CTextComponent'				;
	OBox = New class 'Rx_Hud_ObjectiveBox' 					;
	TargetingBox = New class'Rx_Hud_TargetingBox'			;
	PlayerNames = New class 'Rx_Hud_PlayerNames'			;

}

function UpdateHudCompoenents(float DeltaTime, Rx_HUD HUD)
{
	TargetVisuals.Update(DeltaTime,HUD) 		;
	CommandText.Update(DeltaTime,HUD) 				;
	OBox.Update(DeltaTime,HUD) 					;
	TargetingBox.Update(DeltaTime,HUD)			;  // Targetting box isn't fully seperated from this class yet so we can't update it here.
	PlayerNames.Update(DeltaTime,HUD)			;
	
//Add vote options here

if(Rx_Controller(PlayerOwner) !=none && Rx_Controller(PlayerOwner).VoteHandler != none) 
{
	if(Rx_Controller(PlayerOwner).VoteHandler.VoteChoiceClasses.Length < (8+ExtraVoteNum))
	{
		Rx_Controller(PlayerOwner).VoteHandler.VoteChoiceClasses.AddItem(class'RenX_CommanderMod.Rx_VoteMenuChoice_Commander'); //1
	}
}
	
	
	}

function DrawHudCompoenents()
{
	TargetVisuals.Draw()		;
	CommandText.Draw()				;
	Obox.Draw()					;
	TargetingBox.Draw()			; // Targeting box isn't fully separatedrated from this class yet so we can't draw it here.
	PlayerNames.Draw()			;
	TargetVisuals.Draw()		;
}









//Create and initialize the HUDMovie.
function CreateHUDMovie()
{
	//Create a STGFxHUD for HudMovie
	HudMovie = new class'Rx_GfxHUD';
	//Set the timing mode to TM_Real - otherwide things get paused in menus
	HudMovie.SetTimingMode(TM_Real);
	//Call HudMovie's Initialise function
	HudMovie.Initialize();
	HudMovie.SetTimingMode(TM_Real);
	HudMovie.SetViewScaleMode(SM_NoBorder);
	HudMovie.SetAlignment(Align_TopLeft);

	HudMovie.RenxHud = self;
}








//Okay, let's work around the Gfx Object and all of its quirks to just keep with modding the HUD
//Handles drawing for log, chat, kill and EVA messages
//Handles drawing for log, chat, kill and EVA messages
function Message( PlayerReplicationInfo PRI, coerce string Msg, name MsgType, optional float LifeTime )
{
	local string cName, fMsg, rMsg;
	local bool bEVA;
	local int CRank;

	Rx_Controller(PlayerOwner).PlayerInput.SetBind(OboxKey, "CycleOBox") ;
	
	CRank=FCommanderRank(PRI)	;
	LogInternal("RANK IS11111111:  "$CRank);
	if (Len(Msg) == 0)
		return;
	
	if ( bMessageBeep )
		PlayerOwner.PlayBeepSound();
 
	// Create Raw and Formatted Chat Messages

	if (PRI != None)
		cName = CleanHTMLMessage(PRI.PlayerName);
	else
		cName = "Host";
	
	if (MsgType == 'Say') {
		if (PRI == None)
			
			fMsg = "<font color='" $HostColor$"'>" $cName$"</font>: <font color='#FFFFFF'>"$CleanHTMLMessage(Msg)$"</font>";
		else if (PRI.Team.GetTeamNum() == TEAM_GDI)
			fMsg = "<font color='" $GDIColor $"'>" $cName $"</font>: " $ CleanHTMLMessage(Msg);	
		else if (PRI.Team.GetTeamNum() == TEAM_NOD)
		
			fMsg = "<font color='" $NodColor $"'>" $cName $"</font>: " $ CleanHTMLMessage(Msg);	
		PublicChatMessageLog $= "\n" $ fMsg;
		rMsg = cName $": "$ Msg;
	}
	else if (MsgType == 'TeamSay') {
		if (PRI.GetTeamNum() == TEAM_GDI)
		{
			switch (CRank)
			{
				case -1:
			fMsg = "<font color='" $GDIColor $"'>" $ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
				break;
				
			case 0:
			if(Left(Caps(msg), 5) == "/RUSH") 
			{
			msg = Right(msg, Len(msg)-5);
			CommandText.SetFlashText(CommandText.MyTeam, 35, msg,TargetVisuals.Caution_Color,180, 255, true,10);
			break;
			}
			
			if(Left(Caps(msg), 2) == "/C") 
			{
			msg = Right(msg, Len(msg)-2);
			CommandText.SetFlashText(CommandText.MyTeam, 100, msg,TargetVisuals.Caution_Color,180, 255, false);
		
			}
			//Support for setting custom objective (till interface is done)
			if(Left(Caps(msg), 8) == "/PRIMARY") 
			{
			msg = Right(msg, Len(msg)-8);
			myCC.ORI.StoreObjective("GDI", 3, CRank, msg);
			break;
			}
			
			fMsg = "<font color='" $CommanderColor $"'>" $"[Commander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
			
			break;
			case 1: fMsg = "<font color='" $CoCommanderColor $"'>" $"[CoCommander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
			break;
			
			case 2: 
			fMsg = "<font color='" $SupportCommanderColor $"'>" $"[S.Commander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
			break;
			
			default:
			fMsg = "<font color='" $GDIColor $"'>" $ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
				break;
			}
			
			PublicChatMessageLog $= "\n" $ fMsg;
			rMsg = cName $": "$ Msg;
		}
		else if (PRI.GetTeamNum() == TEAM_NOD)
		{
				switch (CRank)
			{
				case -1:
			fMsg = "<font color='" $NodColor $"'>" $ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
				break;
				
			case 0:
			//Normal Commander Talk support
			if(Left(Caps(msg), 2) == "/C") 
			{
			msg = Right(msg, Len(msg)-2);
			CommandText.SetFlashText(CommandText.MyTeam, 100, msg,TargetVisuals.Warning_Color,180, 255, false);
			}
			// Rush Support
			if(Left(Caps(msg), 5) == "/RUSH") 
			{
			msg = Right(msg, Len(msg)-5);
			CommandText.SetFlashText(CommandText.MyTeam, 35, msg,TargetVisuals.Warning_Color,180, 255, true,10);
			break;
			}
			
			//Support for setting custom objective (till interface is done) Non-working
			if(Left(Caps(msg), 8) == "/PRIMARY") 
			{
			msg = Right(msg, Len(msg)-8);
			myCC.ORI.StoreObjective("NOD", 3, CRank, msg);
			break;
			}
			
			fMsg = "<font color='" $CommanderColor $"'>" $"[Commander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";			
			
			break;
			case 1: fMsg = "<font color='" $CoCommanderColor $"'>" $"[CoCommander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
			break;
			
			case 2: 
			fMsg = "<font color='" $SupportCommanderColor $"'>" $"[S.Commander]"$ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
			break;
			
			default:
			fMsg = "<font color='" $NodColor $"'>" $ cName $": "$ CleanHTMLMessage(Msg) $"</font>";
				break;
			}
			PublicChatMessageLog $= "\n" $ fMsg;
			rMsg = cName $": "$ Msg;
		}
	}
	else if (MsgType == 'System') {
		if(InStr(Msg, "entered the game") >= 0)
			return;
		fMsg = Msg;
		PublicChatMessageLog $= "\n" $ fMsg;
		rMsg = Msg;
	}
	else if (MsgType == 'PM') {
		if (PRI != None)
			fMsg = "<font color='"$PrivateFromColor$"'>Private from "$cName$": "$CleanHTMLMessage(Msg)$"</font>";
		else
			fMsg = "<font color='"$HostColor$"'>Private from "$cName$": "$CleanHTMLMessage(Msg)$"</font>";
		PrivateChatMessageLog $= "\n" $ fMsg;
		rMsg = "Private from "$ cName $": "$ Msg;
	}
	else if (MsgType == 'PM_Loopback') {
		fMsg = "<font color='"$PrivateToColor$"'>Private to "$cName$": "$CleanHTMLMessage(Msg)$"</font>";
		PrivateChatMessageLog $= "\n" $ fMsg;
		rMsg = "Private to "$ cName $": "$ Msg;
	}
	else
		bEVA = true;

	// Add to currently active GUI
	if (bEVA)
	{
		if (HudMovie != none && HudMovie.bMovieIsOpen)
			HudMovie.AddEVAMessage(Msg);
	}
	else
	{
		if (HudMovie != none && HudMovie.bMovieIsOpen)
			HudMovie.AddChatMessage(fMsg, rMsg);

		if (Scoreboard != none && Scoreboard.bMovieIsOpen) {
			if (PlayerOwner.WorldInfo.GRI.bMatchIsOver) {
				Scoreboard.AddChatMessage(fMsg, rMsg);
			}
		}
		if (RxPauseMenuMovie != none && RxPauseMenuMovie.bMovieIsOpen) {
			if (RxPauseMenuMovie.ChatView != none) {
				RxPauseMenuMovie.ChatView.AddChatMessage(fMsg, rMsg, MsgType=='PM' || MsgType=='PM_Loopback');
			}
		}	
	}
}

function string GetColouredName(PlayerReplicationInfo PRI)
{
	if (PRI.GetTeamNum() == TEAM_GDI)
		return "<font color='" $GDIColor $"'>" $CleanHTMLMessage(PRI.PlayerName)$"</font>";
	else if (PRI.GetTeamNum() == TEAM_NOD)
		return "<font color='" $NodColor$"'>" $CleanHTMLMessage(PRI.PlayerName)$"</font>";
	else return CleanHTMLMessage(PRI.PlayerName);
}

function string GetTeamColour(byte TeamIndex)
{
	if (TeamIndex == 0)
		return GDIColor;
	else if (TeamIndex == 1)
		return NodColor;
	else
		return NeutralColor;
}

function string CleanHTMLMessage(string msg)
{
	msg = Repl(msg, "<", "&lt;");
	msg = Repl(msg, ">", "&gt;");
	msg = Repl(msg, "\\", "&#92;");
	return msg;
}
function int FCommanderRank(PlayerReplicationInfo CPRI) 
{
	local Rx_CommanderController CCON ; 
local int i, rank; //Assuming they are a commander, return which rank they are
rank=-1;

if(CPRI == none) return -1; 

if (myCC == none) 
foreach AllActors(class'Rx_CommanderController', CCON)
	{
		
		myCC = CCON ;
		break;
	}

// `log("Made it to the statement");
for(i=0;i<3;i++)
	{
if(CPRI.PlayerID == myCC.GDI_Commander[i].Pid || CPRI.PlayerID == myCC.NOD_Commander[i].Pid) 
		{	
	rank = i;
	break;
		}
	}	
	return rank;
}

function GetCCTimer()
{
	local Rx_CommanderController CCON;  
	
	if (myCC == none) 
foreach AllActors(class'Rx_CommanderController', CCON)
	{
		
		myCC = CCON ;
		break;
	}
}

