class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_Survey extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic;

//var string ConsoleDisplayText;
//var int CurrentTier;

var string SurveyText;


function Init()
{
	Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayText);
}

function InputFromConsole(string text)
{
	SurveyText = Right(text, Len(text) - 6);
	CurrentTier = 1;
}

function array<string> GetDisplayStrings()
{
	local array<string> ret;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (CurrentTier == 1)
	{		
		if (myAdminTool_Controller.iColumnNumber == 1)
		{	
			ret.AddItem("1: Among All");
			ret.AddItem("2: Only Team");
		}
	}

	return ret;
}

function KeyPress(byte T)
{
	if (CurrentTier == 1)
	{
		// accept 1, 2
		if (T == 1 || T == 2)
		{
			if (T == 2)
				ToTeam = Handler.PlayerOwner.PlayerReplicationInfo.Team.TeamIndex;
			Finish();
		}
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
		Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayText);
		return false;
	}
}

function string SerializeParam()
{
	return SurveyText;
}

function DeserializeParam(string param)
{
	SurveyText = param;
}

function string ComposeTopString()
{
	return super.ComposeTopString() $ ": " $ SurveyText;
}

function string ParametersLogString()
{
	return "text" `s SurveyText;
}

function Execute(Rx_Game game)
{
	// do nothing
}

DefaultProperties
{
	TimeLeft = 30 // seconds
	MenuDisplayString = "Survey"
	ConsoleDisplayText = "Survey text: "
}
