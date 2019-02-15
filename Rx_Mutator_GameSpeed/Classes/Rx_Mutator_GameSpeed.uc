/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*              This mutator will change the Renegade X gamespeed              *
*******************************************************************************
* Rx_Mutator_GameSpeed                                                        *
******************************************************************************/

class Rx_Mutator_GameSpeed extends UTMutator;

var()	float	GameSpeed;

function InitMutator(string Options, out string ErrorMessage) { WorldInfo.Game.SetGameSpeed(GameSpeed); Super.InitMutator(Options, ErrorMessage); } 

defaultproperties {
	GroupNames[0]="GAMESPEED"
	GameSpeed=0.8				//Default is 0
}
 