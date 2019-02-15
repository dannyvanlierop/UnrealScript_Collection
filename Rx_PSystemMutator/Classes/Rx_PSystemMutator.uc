class Rx_PSystemMutator extends UTMutator ;

//Basically just used to get us an 'Other' that points to the Actor I'm looking for (That being the PurchaseSystem in this case.)

function bool CheckReplacement(Actor Other) {

// Stores the current Rx_PurchaseSystem, whether it be the new or old one. This is honestly pointless with the way I have it now. 
local  Rx_PurchaseSystem PSystem ;

if(Other.class == class'Rx_PurchaseSystem') {

PSystem = Rx_Game(WorldInfo.Game).PurchaseSystem ;

//Set the timer to replace the Purchase systems; in reality this may be totally unnecessary and field testing will see. 
//Still the timer needs to be before Rx_GRI looks for the  Purchase System

SetTimer(0.1f, false, 'ChangePurchaseSystem' ) ;

// return false for CheckReplacement means it will be deleting 'Other' in this case. Other being the old Purchase system.
// At least that's how I've come to see it working, and it checks out.

return false;
}

return true ; 
}

//--------

simulated function bool ChangePurchaseSystem() {

//----------------------------------------------
//The Vehicle Manager piggy-backs A LOT off of the Purchase system, so therefore needs to be updated 
//----------------------------------------------

local  Rx_PurchaseSystem PSystem ;

local Rx_VehicleManager VM;

//Set the new purchase system to Rx_Game's Purchase system
Rx_Game(WorldInfo.Game).PurchaseSystem = spawn(class'Rx_PurchaseSystem_MOD',self,'PurchaseSystem',Location,Rotation) ;

//Set the Vehicle Manager back right
VM = Rx_Game(WorldInfo.Game).VehicleManager;


PSystem = Rx_Game(WorldInfo.Game).PurchaseSystem ;


PSystem.SetVehicleManager(VM);
return true;
}