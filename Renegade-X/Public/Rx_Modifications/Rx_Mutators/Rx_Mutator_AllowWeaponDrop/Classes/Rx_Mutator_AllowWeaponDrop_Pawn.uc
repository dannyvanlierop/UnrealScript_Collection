/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the weapondrop function to the Renegade X game     *
*******************************************************************************
* Rx_Mutator_AllowWeaponDrop_Pawn                                             *
******************************************************************************/

class Rx_Mutator_AllowWeaponDrop_Pawn extends Rx_Pawn; // YOSH : Weirdly add weapon drops. I have to go around the normal DropFrom function to get around the automatic 'false' given to Rx_Weapons

function RemoteDropFrom(vector StartLocation, vector StartVelocity, Rx_Weapon Weap) { 
	local DroppedPickup P;
	LogInternal("Start function RemoteDropFrom");
	if(InvManager != None ) { InvManager.RemoveFromInventory(Weap); }
	if( Weap.DroppedPickupClass == None || Weap.DroppedPickupMesh == None ) { Weap.Destroy(); return; }		// if cannot spawn a pickup, then destroy and quit
	Weap.GotoState('Inactive');																				// Become inactive
	Weap.ForceEndFire();																					// Stop Firing
	Weap.DetachWeapon();																					// Detach weapon components from instigator
	
	P = Spawn(Weap.DroppedPickupClass,,, StartLocation); if( P == None ) { Weap.Destroy(); return; }		//The rest of the super function
	P.SetPhysics(PHYS_Falling);
	P.Inventory	= Weap;
	P.InventoryClass = Weap.class;
	P.Velocity = StartVelocity;
	P.Instigator = self;
	P.SetPickupMesh(Weap.DroppedPickupMesh);
	P.SetPickupParticles(Weap.DroppedPickupParticles);
	GotoState('');
}

function bool Died(Controller Killer, class<DamageType> damageType, vector HitLocation) { 
	LogInternal("Start function bool died"); 
	if (Weapon != none) RemoteDropFrom(Location, Velocity, Rx_Weapon(Weapon)) ;
	super.Died(Killer, damageType, HitLocation); return true;
}

DefaultProperties { 
}
 