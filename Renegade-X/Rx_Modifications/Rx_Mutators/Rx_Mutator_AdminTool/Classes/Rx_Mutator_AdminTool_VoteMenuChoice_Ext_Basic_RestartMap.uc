class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_RestartMap extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic;

function Init()
{
	Finish();
}

function string ComposeTopString()
{
	return super.ComposeTopString() $ " wants to restart the map";
}

function Execute(Rx_Game game)
{
	game.WorldInfo.ServerTravel("?Restart",game.GetTravelType());
}

DefaultProperties
{
	MenuDisplayString = "Restart Map"
}
