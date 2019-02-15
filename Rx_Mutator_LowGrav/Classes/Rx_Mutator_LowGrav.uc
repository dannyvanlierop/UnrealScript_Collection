/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*  This mutator will set the default Renegade X game gravity setting to -500  *
*******************************************************************************
* Rx_Mutator_LowGrav                                                          *
******************************************************************************/

class Rx_Mutator_LowGrav extends UTMutator;

var() float GravityZ;

function InitMutator(string Options, out string ErrorMessage) {
	WorldInfo.WorldGravityZ = GravityZ;
	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties {
	GroupNames[0]="GRAVITY"
	GravityZ=-500.0
}
 