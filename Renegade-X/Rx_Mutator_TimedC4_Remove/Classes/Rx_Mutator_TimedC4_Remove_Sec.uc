/******************************************************************************
*  Written by Ukill                                                           *
*  Will removes the second Timed C4 from every soldier                        *
*******************************************************************************
* Rx_Mutator_TimedC4_Remove_Sec                                               *
******************************************************************************/

class Rx_Mutator_TimedC4_Remove_Sec extends UTMutator;
 
event PreBeginPlay()
{
	local Rx_Weapon_TimedC4_Multiple C4Mod;

	super.PreBeginPlay();

	C4Mod=Rx_Weapon_TimedC4_Multiple(GetDefaultObject(Class'Rx_Weapon_TimedC4_Multiple')); 
	C4Mod.InitalNumClips=1;
	C4Mod.MaxClips=1;
}

final static function object GetDefaultObject(class ObjClass)
{
	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}

