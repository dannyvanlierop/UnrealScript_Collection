/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*     This mutator will add a TweakMenu function to the Renegade X game       *
*******************************************************************************
* UTUIFrontEnd_PlayerTweakMenu                                                *
******************************************************************************/

class PlayerTweakMutator extends Mutator
	config(PlayerTweak);

var config float Speed;
var config float JumpHeight;
var config int StartHealth;
var config int MaxHealth;

function ModifyPlayer(Pawn Other)
{
	Other.GroundSpeed *= (Speed/100);
	Other.JumpZ *= (JumpHeight/100);
	Other.Health = StartHealth;
	Other.HealthMax = MaxHealth;
	
	Super.ModifyPlayer(Other);
}

DefaultProperties
{
}