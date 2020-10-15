/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*         This mutator will disable FallDamage in the Renegade X game         *
*******************************************************************************
* Rx_Mutator_LowGrav                                                          *
******************************************************************************/

Class Rx_Mutator_NoFallDamage extends UTMutator;

var int bMaxFallSpeed;

function InitMutator(string Options, out string ErrorMessage)
{
   	SaveConfig();
	Super.InitMutator(Options, ErrorMessage);
}


function ModifyPlayer(Pawn P)
{
    local UTPawn player;

    player = UTPawn(P);
    
    if ( player != None )
	{
    	P.MaxFallSpeed	*= bMaxFallSpeed;  
		Super.ModifyPlayer(P);
	}
}

defaultproperties
{
bMaxFallSpeed=100
}
 