/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*       This mutator will add the .... function to the Renegade X game        *
*******************************************************************************
* Rx_Mutator_GDI_Shotgunner                                                   *
******************************************************************************/

class Rx_Mutator_GDI_Shotgunner extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) {
		Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator_GDI_Shotgunner_Pawn' ;
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator_GDI_Shotgunner_Controller' ;
		Rx_Game(WorldInfo.Game).InventoryManagerClass=class'Rx_Mutator_GDI_Shotgunner_InventoryManager'
		Rx_Game(WorldInfo.Game).PlayerReplicationInfoClass=class'Rx_Mutator_GDI_Shotgunner_PRI'
	
	}
return true;
}

DefaultProperties {
}
 