/*
** Rx_Attachment_CommanderBinoculars
*/

class Rx_Attachment_CommanderBinoculars extends Rx_WeaponAttachment
	abstract;

var private ParticleSystemComponent Beam;


//Copied from Airstrike attachment. 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////TODO: See about getting animations corrected so people aren't just standing there with beams coming out of their chest/////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


simulated function SpawnBeam(vector TargetLoc)
{
	local vector start;

	// do not spawn beam for local player, because we did that already
	if (Instigator.IsLocallyControlled()) return;

	// get starting point of beam
	if (!Mesh.GetSocketWorldLocationAndRotation('MuzzleFlashSocket', start, , 0))
		start = Instigator.Location;

    Beam = WorldInfo.MyEmitterPool.SpawnEmitter(class<Rx_Weapon_CommanderBinoculars>(WeaponClass).default.BeamEffect, start);
    Beam.SetVectorParameter('BeamEnd', TargetLoc);
	Beam.SetDepthPriorityGroup(SDPG_World);
}

simulated function DestroyBeam()
{
	if (Beam != none)
		Beam.ResetToDefaults();
}

