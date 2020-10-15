// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu0 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext;

function Init()
{
}

function KeyPress(byte T)
{
}

function array<string> GetDisplayStrings()
{
}

function bool GoBack()
{
	// return true to kill this submenu
	return true;
}

// call to execute vote
function Finish()
{
	Handler.PlayerOwner.SendVote(self.Class, SerializeParam(), ToTeam);
	Handler.Terminate();
}

// input from console, custom parsing in each subclass
function InputFromConsole(string text)
{
}

/** Override serialization procedures. */

function string SerializeParam()
{
	return "";
}

function DeserializeParam(string param)
{
}

/** Server side functions. */

function ServerInit(Rx_Controller instigator, string param, int t)
{
	local string params;

	//		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Cal1led;" `s TeamTypeToString(t) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminTool_Controller.ModeDescriptionArray[iModeName] `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) `s params);
	//	else
	//		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Cal1led;" `s TeamTypeToString(t) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminTool_Controller.ModeDescriptionArray[iModeName] `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) );

	
	ToTeam = t;
	VoteInstigator = instigator;
	DeserializeParam(param);
	TopString = ComposeTopString();
	EndTime = instigator.WorldInfo.TimeSeconds + TimeLeft;
	
	// Log vote called.
	params = ParametersLogString();
	if (params != "")
		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Called;" `s TeamTypeToString(t) `s mid(class,46) `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) `s params);
	else
		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Called;" `s TeamTypeToString(t) `s mid(class,46) `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) );

	// update on players
	UpdatePlayers(instigator.WorldInfo);
}

static function string TeamTypeToString(int type)
{
	switch (type)
	{
	case -1:
		return "Global";
	case 0:
		return "GDI";
	case 1:
		return "Nod";
	}
	return "";
}

function ServerSecondTick(Rx_Game game)
{
	local byte nt;

	nt = byte(EndTime - game.WorldInfo.TimeSeconds);
	if (nt < TimeLeft)
	{
		// update time
		TimeLeft = nt;

		UpdatePlayers(game.WorldInfo);

		if (nt == 0)
		{
			// todo: finish vote
			if (CanExecute(game))
			{
				game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s mid(class,46) `s "pass" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
				Execute(game);
			}
			else
				game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s mid(class,46) `s "fail" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
			game.DestroyVote(self);

			//	game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminTool_Controller.ModeDescriptionArray[iModeName] `s "pass" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
			//	game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminTool_Controller.ModeDescriptionArray[iModeName] `s "fail" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
		}
	}
}

function UpdatePlayers(WorldInfo wi)
{
	local Rx_Controller rxc;

	if (bPendingDelete) return;

	foreach wi.AllActors(class'Rx_Controller', rxc)
	{
		if (ToTeam == -1 || rxc.PlayerReplicationInfo.Team.TeamIndex == ToTeam)
		{
			rxc.VoteTopString = TopString;
			rxc.VoteTimeLeft = TimeLeft;
			rxc.VotesYes = PlayerCount(Yes);
			rxc.VotesNo = PlayerCount(No);
			rxc.YesVotesNeeded = GetNeededYesVotes(Rx_Game(wi.Game));
			rxc.VotersTotal = GetTotalVoters(Rx_Game(wi.Game));
		}
	}
}

function string ComposeTopString()
{
	return VoteInstigator.PlayerReplicationInfo.PlayerName;
}

/** Syntax: [ key | value [... | key | value ] ] */
function string ParametersLogString()
{
	return "";
}

function int GetTotalVoters(Rx_Game game)
{
	local Rx_Controller rxc;
	local int count;

	if (ToTeam == -1) return game.NumPlayers;
	else
	{
		count = 0;

		foreach game.AllActors(class'Rx_Controller', rxc)
		{
			if (rxc.PlayerReplicationInfo.Team.TeamIndex == ToTeam)
				count++;
		}

		return count;
	}
}

// verify whether enough votes for execute
function bool CanExecute(Rx_Game game)
{
	// If enough players have votes yes.
	if ( PlayerCount(Yes) >= GetNeededYesVotes(game))
	{
		return true;
	}
	else return false;
}

function int GetNeededYesVotes(Rx_Game game)
{
	if (ToTeam == -1)
		return int(float(game.NumPlayers) * PercentYesToPass) + PlayerCount(No) + 1;
	else
		return int(float(game.NumPlayers) * PercentYesToPass * 0.5) + PlayerCount(No) + 1;
}

// execute vote
function Execute(Rx_Game game)
{
	`log("vote would be executed!");
}

function DestroyVote(Rx_Game game)
{
	local Rx_Controller rxc;

	TopString = "";

	// dispatch empty string so vote is not displayed on top anymore
	foreach game.AllActors(class'Rx_Controller', rxc)
	{
		if (ToTeam == -1 || rxc.PlayerReplicationInfo.Team.TeamIndex == ToTeam)
		{
			rxc.VoteTopString = "";
		}
	}
}

function bool CanVote(Rx_Controller p)
{
	local int i;

	// if not on right team, don't allow to vote
	if (ToTeam != -1 && p.PlayerReplicationInfo.Team.TeamIndex != ToTeam) return false;

	// Remove player's previous vote
	for (i = 0; i < Yes.Length; i++)
	{
		if (Yes[i] == p)
		{
			Yes.RemoveItem(Yes[i]);
			break;
		}
	}

	for (i = 0; i < No.Length; i++)
	{
		if (No[i] == p)
		{
			No.RemoveItem(No[i]);
			break;
		}
	}

	return true;
}

function int PlayerCount(out array<Rx_Controller> arr)
{
	local int i, t;

	t = 0;
	for (i = 0; i < arr.Length; i++)
		if (arr[i] != none) t++;

	return t;
}

function PlayerVoteYes(Rx_Controller p)
{
	if (!CanVote(p)) return;

	Yes.AddItem(p);
	UpdatePlayers(p.WorldInfo);
}

function PlayerVoteNo(Rx_Controller p)
{
	if (!CanVote(p)) return;

	No.AddItem(p);
	UpdatePlayers(p.WorldInfo);
}

DefaultProperties
{

}