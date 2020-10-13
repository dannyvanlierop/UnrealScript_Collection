/*
** Rx_CommandMenuChoice
*/

class Rx_CommandMenuChoice extends Object
	abstract;

var Rx_CommandMenuHandler Handler;
var string MenuDisplayString;
var int LocalTeam, LocalCRank;
var Rx_CommanderController myCC;
var int Tier;


// server side
var int ToTeam; // -1 for both teams, 0 = GDI, 1 = NOD
//var float EndTime;
//var array<Rx_Controller> Yes, No;

//var string TopString;
//var Rx_Controller VoteInstigator;
var bool bPendingDelete;

// configurable

/** (From 0 to 255) seconds for vote time. */
//var byte TimeLeft;

/** (From 0.0 to 1.0) of YES votes needed to perform action. */
//var float PercForExec;
/** (From 0.0 to 1.0) of NO votes needed to immediatelly destroy ongoing vote. */
//var float PercForDestroy;

// At least this % of participating players need to have voted yes for the vote to pass.
//var float PercentYesToPass;




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
	//Handler.PlayerOwner.SendVote(self.Class, SerializeParam(), ToTeam);
	Handler.Terminate();
}

// input from console, custom parsing in each subclass
function InputFromConsole(string text)
{
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





