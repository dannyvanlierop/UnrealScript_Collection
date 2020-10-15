/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the DoubleJump function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_DoubleJump                                                       *
******************************************************************************/

class Rx_Mutator_HardJump extends UTMutator;

function ModifyPlayer(Pawn Other)
{
	local UTPawn P;

	P = UTPawn(Other);
	if (P != None)
	{
		P.bCanDoubleJump=false;
		P.MaxMultiJump=0;
		P.MultiJumpRemaining=0;
		P.MaxMultiDodge=0;
		P.MultiDodgeRemaining=0;

		P.JumpZ=322.0;		//322.0  (what is it?)
		P.DodgeSpeed=400.0;	//600.0
		P.DodgeSpeedZ=195.0;	//295.0
		P.MaxJumpHeight=49.0;	//49.0

		P.DodgeResetTime=3.00;
		P.AirControl=+0.0;
		P.DefaultAirControl=+0.0;
	}
	Super.ModifyPlayer(Other);
}

defaultproperties
{
	Description="Makes the game less acrobatic"
}
