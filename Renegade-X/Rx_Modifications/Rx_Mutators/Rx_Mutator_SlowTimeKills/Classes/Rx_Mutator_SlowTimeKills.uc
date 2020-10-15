/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*   This mutator will add the SlowTimeKill function to the Renegade X game    *
*******************************************************************************
* Rx_Mutator_SlowTimeKills                                                    *
******************************************************************************/

class Rx_Mutator_SlowTimeKills extends Rx_Mutator;

var float SlowTime;
var float RampUpTime;
var float SlowSpeed;

//var Mutator NextMutator;

function bool CheckReplacement(Actor Other)
{
	if(Other.IsA('Rx_TeamInfo')) 
	{	
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_SlowTimeKills_Controller' ; 
	}
	return true;
}

//function bool MutatorIsAllowed() { return (WorldInfo.NetMode == NM_Standalone); }
function bool MutatorIsAllowed() { return UTTeamGame(WorldInfo.Game) != None && Super.MutatorIsAllowed(); } 


function ScoreKill(Controller Killer, Controller Killed)
{
	if ( PlayerController(Killer) != None ) 
	{
		WorldInfo.Game.SetGameSpeed(SlowSpeed); 
		SetTimer(SlowTime, false); 
	}
	
	if ( NextMutator != None ) 
	{
		NextMutator.ScoreKill(Killer,Killed); 
	}
}

function Timer() 
{ 
	GotoState('Rampup'); 
}

state Rampup {
	function Tick(float DeltaTime) {
		local float NewGameSpeed;
		NewGameSpeed = WorldInfo.Game.GameSpeed + DeltaTime/RampUpTime;
		if ( NewGameSpeed >= 1 ) 
		{ 
			WorldInfo.Game.SetGameSpeed(1.0); GotoState(''); 
		} 
		
		else 
		{ 
			WorldInfo.Game.SetGameSpeed(NewGameSpeed); 
		}
	}
}

defaultproperties 
{ 
	RampUpTime=0.1				// Delta Seconds is the time between each frame / ..................
	SlowTime=1.0				// SlowMotionKill Time
	SlowSpeed=0.125				// GameSpeed While SlowTimeKills
}


