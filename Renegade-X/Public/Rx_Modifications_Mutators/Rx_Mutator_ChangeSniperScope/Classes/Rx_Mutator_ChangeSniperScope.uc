/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*       This mutator will add the .... function to the Renegade X game        *
*******************************************************************************
* Rx_Mutator_ChangeSniperScope                                                            *
******************************************************************************/

class Rx_Mutator_ChangeSniperScope extends UTMutator;
 
event PreBeginPlay()
{
	local Rx_Weapon_Scoped ScopedMod;
	local Rx_Weapon_RamjetRifle RamjetMod;
	super.PreBeginPlay();

	ScopedMod=Rx_Weapon_Scoped(GetDefaultObject(Class'Rx_Weapon_Scoped')); 
    ScopedMod.ZoomedRate = 160.0;
    ScopedMod.ZoomedFOVIncrement = 80;
    ScopedMod.ZoomedFOVMin = 100.0; // Lower is more zoomed;
    ScopedMod.ZoomedFOVMax = 250.0; // Higher is less zoomed    ZoomedRate = 60.0;
    ScopedMod.ZoomedFOVIncrement = 15;
    ScopedMod.ZoomedFOVMin = 1.0; // Lower is more zoomed;
    ScopedMod.ZoomedFOVMax = 250.0; // Higher is less zoomed;
	ScopedMod.HudMaterial=Material'RX_WP_Binoculars.Materials.M_BinocularScope';
	
	RamjetMod=Rx_Weapon_RamjetRifle(GetDefaultObject(Class'Rx_Weapon_RamjetRifle')); 
	RamjetMod.HudMaterial=Material'RX_WP_Binoculars.Materials.M_BinocularScope';
}

final static function object GetDefaultObject(class ObjClass)
{
	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}	


