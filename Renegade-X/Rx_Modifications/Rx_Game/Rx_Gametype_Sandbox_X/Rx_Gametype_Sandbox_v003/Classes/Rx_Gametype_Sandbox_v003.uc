/**
 * Rx_Gametype_Sandbox_v003
 *
 * */
class Rx_Gametype_Sandbox_v003 extends Rx_Game;

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
	PlayerControllerClass	   = class'Rx_Gametype_Sandbox_v003_Controller'
}