/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*                   This mutator will Normalize Health                        *
*******************************************************************************
* Rx_Mutator_NormalizeHealth_Pawn                                             *
******************************************************************************/

class Rx_Mutator_NormalizeHealth_Pawn extends Rx_Pawn ;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) {
	Super.PostInitAnimTree(SkelComp) ;
	if (SkelComp == Mesh) { SetTimer(0.5, false, 'NormalizeHealth' ) ; 	}
}

simulated function bool NormalizeHealth () {
	healthmax = 200 ;
	health = 200 ; 
	return true; 
}
 