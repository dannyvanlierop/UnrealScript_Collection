/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the DoubleJump function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_DoubleJump_Controller                                            *
******************************************************************************/

class Rx_Mutator_DoubleJump_Controller extends Rx_Controller;

function CheckJumpOrDuck() { 
	if ( Pawn == None ) { return; } 
	if ( bDoubleJump && (bUpdating || ((Rx_Pawn(Pawn) != None) && Rx_Pawn(Pawn).CanDoubleJump())) ) { Rx_Pawn(Pawn).DoDoubleJump( bUpdating ); bDoubleJump = false; }
    else if ( bPressedJump ) { Pawn.DoJump( bUpdating ); } 
	if ( Pawn.Physics != PHYS_Falling && Pawn.bCanCrouch ) { Pawn.ShouldCrouch(bDuck != 0); }
}

defaultProperties
{

}
