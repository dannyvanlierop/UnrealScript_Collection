/*
** Rx_VoteMenuChoice_Commander
*/

class Rx_VoteMenuChoice_Commander extends Rx_VoteMenuChoice;

var SoundCue IonTestSnd			;
var SoundCue ElectedSound		;
var int ComID, CandidateRank	;
var string ComName				;
var Rx_Controller ComC			;
var string HR_Teamname			;
var Rx_CommanderController CC 	;
var int CurrentTier				;
var bool VotingIn				;

function Init()
{
	// enable console
	ToTeam = Handler.PlayerOwner.PlayerReplicationInfo.Team.TeamIndex;
	
}


function array<string> GetDisplayStrings()
{
	local array<string> ret;

	if (CurrentTier == 0)
	{
		ret.AddItem("1: Vote IN");
		ret.AddItem("2: Vote OUT");
		
	}
	else if (CurrentTier == 1)
	{
		ret.AddItem("1: Primary Commander");
		ret.AddItem("2: [Disabled]");
		ret.AddItem("3: [Disabled]");
		//ret.AddItem("2: Co-Commander");
		//ret.AddItem("3: Support Commander");
	}

	return ret;
}

function KeyPress(byte T)
{
	if (CurrentTier == 0)
	{
		// accept 1, 2
		if (T == 1 || T == 2)
		{
			switch (T)
			{
				case 1:
				VotingIn = true;
				break;
				case 2:
				VotingIn = false; 
				break;
			}
			
			CurrentTier = 1;

			
		}
	}
	else if (CurrentTier == 1)
	{
		// accept 1,2 3
		//if (T >= 1 && T <= 3)
			//Accept 1 until control groups are built in
		if (T == 1)
		{
			switch (T)
			{
			case 1:
			CandidateRank = 0;
			break;
			/**case 2:
			CandidateRank = 1;
			break;
			case 3:
			CandidateRank = 2;
			break;
			*/
			}
			if(VotingIn) 
			{
				Handler.PlayerOwner.ShowVoteMenuConsole("PlayerID or name of Commander candidate : ");
				CurrentTier=2;
			}
			else
			Finish();
			// enable console
			

			
		}
	}
}

function InputFromConsole(string text)
{
	local string Pname;
	local Rx_PRI P_PRI;

	
	Pname = Right(text, Len(text) - 33);
	
	LogInternal("Playername was" $ Pname) ;
	
	//Parse player name from string. Thankfully someone else already wrote a function to parse names =D
	
	P_PRI= Handler.PlayerOwner.ParsePlayer(Pname);

	Pname = P_PRI.PlayerName;
	
	if(P_PRI == None)
	{
	LogInternal("Failed to find player PRI, terminating vote.");
	Handler.Terminate();
	}
	
	else
	{
		LogInternal("Setting ComName to"@Pname);
	ComName=Pname	;
	
	ComID=FindPlayerIDfromName(Pname);
		
	Finish();
	}
}

function bool GoBack()
{
	switch (CurrentTier)
	{
	case 0:
		return true; // kill this submenu
	case 1:
		CurrentTier = 0;
		return false;
	case 2:
		CurrentTier = 1;
		// enable console
		Handler.PlayerOwner.ShowVoteMenuConsole("PlayerID or name of Commander candidate : ");
		return false;
	}
}


function string SerializeParam()
{

LogInternal("000000000000000Serialize returning " $ ComName);
return string(ComID) $ "\n" $ string(CandidateRank) $"\n" $ string(VotingIn);

}

function DeserializeParam(string param)
{
	local Rx_Controller c;
	local int i;
	//Fancy work with strings stolen from AddBots
	

	i = InStr(param, "\n");
	LogInternal(ComID);
	ComID = int(Left(param, i));
		LogInternal("COMID: "@ComID);
	param = Right(param, Len(param) - i - 1);
	i = InStr(param, "\n");
	CandidateRank = int(Left(param, i));
	LogInternal("Rank: "@CandidateRank);
	param = Right(param, Len(param) - i - 1);
	VotingIn = bool(param);
	LogInternal("VoteIn: "@VotingIn);
	

	if(ComID !=0){
	foreach VoteInstigator.AllActors(class'Rx_Controller', c)
		{
		if (c.PlayerReplicationInfo.PlayerID == ComID)
			{
			ComC = c;
			break;
			}
		}
	
	if (ComC == none)
		{
		bPendingDelete = true;
		Rx_Game(VoteInstigator.WorldInfo.Game).DestroyVote(self);
		}
	}
}

function Finish()
{
	LogInternal("Sending vote with Class:"@self.Class @"Serialized Parameter: "@SerializeParam() @ "To Team: " @ToTeam);
	Handler.PlayerOwner.SendVote(self.Class, SerializeParam(), ToTeam);
	Handler.Terminate();
}



function int FindPlayerIDfromName (string Pname)
{
local Rx_PRI LPRI;
local int P_ID, i;
local GameReplicationInfo LGRI;

LGRI = Handler.PlayerOwner.WorldInfo.GRI ;


for (i=0;i < LGRI.PRIArray.Length;i++)
	{
	
		
		LPRI=Rx_PRI(LGRI.PRIArray[i]);
		
		LogInternal(LPRI);
		
		if (LPRI.PlayerName == Pname)
		{
			LogInternal(LPRI.PlayerName);
			P_ID = LPRI.PlayerID ;
	LogInternal("000000000000000 Player ID found as" @ P_ID)	;	
			return P_ID;
			break;
		}
	
	}
	if(P_ID == 0) return -8008;
}


function string ComposeTopString()
{

local string C_String;
switch (CandidateRank)
	{
		case 0: 
		C_String="Primary " ;
		break;
		
		case 1: 
		C_String="Co-" ;
		break;
		
		case 2: 
		C_String="Support " ;
		break;
	}

//Is it for GDI or Nod?
if(ToTeam == 0) HR_Teamname ="GDI";
	else
	HR_Teamname ="Nod" ;
	
	
LogInternal("0112121121221212 Composing Top string 11111111");
if(VotingIn) return super.ComposeTopString() $ " wants to vote " $ ComC.PlayerReplicationInfo.PlayerName $ " for " $ HR_Teamname @ C_String$"Commander" ;
else
return super.ComposeTopString() $ " wants to vote  OUT" @ HR_Teamname $"'s" @ C_String$"Commander" ;	
}

function ServerSecondTick(Rx_Game game)
{
	if(VotingIn)
		{
	if (ComC == none) 
			{
		LogInternal("Commander Controller not set to anything, destroying vote.");
	game.DestroyVote(self);
	
			}

	else super.ServerSecondTick(game);
		}
		else
	super.ServerSecondTick(game);
}





function Execute(Rx_Game game)
{

local Rx_Controller CON ;
local Rx_CommanderController CCON;
LogInternal("0112121121221212 Attempting to execute");




// Find the Command controller

foreach game.AllActors(class'Rx_CommanderController', CCON)
	{
		
		CC = CCON ;
		
		LogInternal("CC for end of vote was " @CC);
		
		break;
		
	}

//Find applicable player controllers
	if(VotingIn) 
	{
foreach game.AllActors(class'Rx_Controller', CON)
	{
	if(CON.PlayerReplicationInfo.Team.TeamIndex == ToTeam && CON.PlayerReplicationInfo.PlayerID == ComID)
		{
			LogInternal("Voting In is: "@VotingIn);
		CC.SetCommander(CON, ToTeam, CandidateRank) ;	
		}
	
	}
	}
	else
	CC.EraseCommander(HR_Teamname, CandidateRank);	
}




