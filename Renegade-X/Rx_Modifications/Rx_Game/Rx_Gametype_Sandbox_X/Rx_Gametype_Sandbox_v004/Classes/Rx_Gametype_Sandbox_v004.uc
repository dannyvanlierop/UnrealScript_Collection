/**
 * Rx_Gametype_Sandbox_v004
 *
 * */
class Rx_Gametype_Sandbox_v004 extends Rx_Game;

/*
	config(RxSandbox);
var config int ActorSpawnLimit;
*/

var bool bSandbox;


function ToggleSandboxMode()
{
	bSandbox = !bSandbox;
}

DefaultProperties
{
	PlayerControllerClass	   = class'Rx_Gametype_Sandbox_v004_Controller'
}


event InitGame( string Options, out string ErrorMessage )
{	
	if (WorldInfo.GetmapName() != "None")
	{
		AddMutator("Rx_Gametype_Sandbox_v004_InfiniteAmmo.Rx_Gametype_Sandbox_v004_InfiniteAmmo");
		BaseMutator.InitMutator(Options, ErrorMessage);
	}
}

