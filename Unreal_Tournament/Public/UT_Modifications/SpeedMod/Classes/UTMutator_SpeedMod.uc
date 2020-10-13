//=============================================================================
// JumpMod
//
// This mutator allows a server to configure the abilities for players to jump
// around as well as how much boost they receive with each jump.
//
// Contact : bob.chatman@gmail.com
// Website : www.gneu.org
// License : Content is available under Creative Commons Attribution-ShareAlike 
//			 3.0 License.
//=============================================================================

Class UTMutator_SpeedMod extends UTMutator Config( SpeedMod );

// Two configurable values
var config int iGameSpeed;

function InitMutator(string Options, out string ErrorMessage)
{
	if (iGameSpeed < 25 || iGameSpeed > 400)
		iGameSpeed = 100;

	WorldInfo.Game.SetGameSpeed(iGameSpeed / 100.0f);

	Super.InitMutator(Options, ErrorMessage);
}

