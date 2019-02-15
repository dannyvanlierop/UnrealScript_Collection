class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Kick extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic
	DependsOn (Rx_Mutator_AdminTool_Controller);
	
var int KickID;
var Rx_Controller KickC;

function Init()
{
	// enable console
	Handler.PlayerOwner.ShowVoteMenuConsole("PlayerID to kick: ");
}

function array<string> GetDisplayStrings()
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	local array<string> ret;
	local int i;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'GameReplicationInfo', myGameReplicationInfo) break;
	
	myGameReplicationInfo = Handler.PlayerOwner.WorldInfo.GRI;
	if (myAdminToolController.iColumnNumber == 1)
	{
		for (i = 0; i < myGameReplicationInfo.PRIArray.Length; i++)
		{
			if (myGameReplicationInfo.PRIArray[i].bBot) continue;
			ret.AddItem(string(myGameReplicationInfo.PRIArray[i].PlayerID) $ ": " $ myGameReplicationInfo.PRIArray[i].PlayerName);
		}
	}

	return ret;
}

function InputFromConsole(string text)
{
	local string s;

	s = Right(text, Len(text) - 9);
	KickID = int(s);

	Finish();
}

function string SerializeParam()
{
	return string(KickID);
}

function DeserializeParam(string param)
{
	local Rx_Controller c;
	KickID = int(param);

	foreach VoteInstigator.AllActors(class'Rx_Controller', c)
	{
		if (c.PlayerReplicationInfo.PlayerID == KickID)
		{
			KickC = c;
			break;
		}
	}

	if (KickC == none)
	{
		bPendingDelete = true;
		Rx_Game(VoteInstigator.WorldInfo.Game).DestroyVote(self);
	}
}

function ServerSecondTick(Rx_Game game)
{
	if (KickC == none) game.DestroyVote(self);
	else super.ServerSecondTick(game);
}

function string ComposeTopString()
{
	return super.ComposeTopString() $ " wants to kick " $ KickC.PlayerReplicationInfo.PlayerName;
}

function string ParametersLogString()
{
	if (KickC == None)
		return "";
	return "player" `s `PlayerLog(KickC.PlayerReplicationInfo);
}

function Execute(Rx_Game game)
{
	game.AccessControl.KickPlayer(KickC, "voted to be kicked");
}

DefaultProperties
{
	MenuDisplayString = "Kick Player"
}
