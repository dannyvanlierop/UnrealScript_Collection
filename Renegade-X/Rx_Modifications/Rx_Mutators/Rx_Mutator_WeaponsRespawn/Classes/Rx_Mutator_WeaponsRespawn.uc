/*
**  By Ukill, supported by google :).
**  this mutator will add the ............. function to the Renegade X game
*/

class Rx_Mutator_WeaponsRespawn extends UTMutator;

function InitMutator(string Options, out string ErrorMessage)
{
	UTGame(WorldInfo.Game).bWeaponStay = false;
	super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
	GroupNames[0]="WEAPONRESPAWN"
}
