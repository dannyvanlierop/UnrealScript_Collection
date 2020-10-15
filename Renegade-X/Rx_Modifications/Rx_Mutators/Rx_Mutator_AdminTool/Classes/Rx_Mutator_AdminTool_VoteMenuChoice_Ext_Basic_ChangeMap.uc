class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_ChangeMap extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic;

function Init()
{
	Finish();
}

function string ComposeTopString()
{
	return super.ComposeTopString() $ " wants to change the map";
}

function Execute(Rx_Game game)
{
	game.EndRxGame("triggered", 255);
}

DefaultProperties
{
	MenuDisplayString = "Change Map"
}