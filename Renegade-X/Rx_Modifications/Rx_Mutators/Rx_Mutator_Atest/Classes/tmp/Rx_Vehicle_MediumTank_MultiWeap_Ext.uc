/*********************************************************
*
* File: RxVehicle_MediumTank.uc
* Author: RenegadeX-Team
* Pojekt: Renegade-X UDK <www.renegade-x.com>
*
* Desc:
*
*
* ConfigFile:
*
*********************************************************
*
*********************************************************/
class Rx_Vehicle_MediumTank_MultiWeap_Ext extends Rx_Vehicle_MediumTank
    placeable;
	
var int missleBayToggle;

/** Firing sounds */
var() AudioComponent FiringAmbient;
var() SoundCue FiringStopSound;





//================================================
// COPIED from RxVehicle_MammothTank
// Attribute of a multi weapon vehicle, this code correctly identifies 
// the propper firing socket
//================================================
simulated function vector GetEffectLocation(int SeatIndex)
{

    local vector SocketLocation;
   local name FireTriggerTag;

    if ( Seats[SeatIndex].GunSocket.Length <= 0 )
        return Location;

   //`Log("GetEffectLocation called",, '_Mammoth_Debug');

   FireTriggerTag = Seats[SeatIndex].GunSocket[GetBarrelIndex(SeatIndex)];

   Mesh.GetSocketWorldLocationAndRotation(FireTriggerTag, SocketLocation);

    //if (Weapon.CurrentFireMode == 0)
    //   ShotCount = ShotCounts >= 255 ? 0 : ShotCounts + 1;
   //  else
   //     AltShotCounts = AltShotCounts >= 255 ? 0 : AltShotCounts + 1;
    return SocketLocation;
}

// special for mammoth
simulated event GetBarrelLocationAndRotation(int SeatIndex, out vector SocketLocation, optional out rotator SocketRotation)
{
    if (Seats[SeatIndex].GunSocket.Length > 0)
    {
        Mesh.GetSocketWorldLocationAndRotation(Seats[SeatIndex].GunSocket[GetBarrelIndex(SeatIndex)], SocketLocation, SocketRotation);
    }
    else
    {
        SocketLocation = Location;
        SocketRotation = Rotation;
    }
}

simulated function int GetBarrelIndex(int SeatIndex)
{
    local int OldBarrelIndex;
    
    OldBarrelIndex = super.GetBarrelIndex(SeatIndex);
    if (Weapon == none)
        return OldBarrelIndex;

    return (Weapon.CurrentFireMode == 0 ? OldBarrelIndex % 1 : (OldBarrelIndex % 1) + 1);
}

simulated function VehicleWeaponFireEffects(vector HitLocation, int SeatIndex)
{
//    local Name FireTriggerTag;
	
	Super.VehicleWeaponFireEffects(HitLocation, SeatIndex);

//	FireTriggerTag = Seats[SeatIndex].GunSocket[GetBarrelIndex(SeatIndex)];
	
	if (Weapon.CurrentFireMode == 1)
	{
		if (!FiringAmbient.bWasPlaying)
		{
			FiringAmbient.Play();
			VehicleEvent('AltGun');
		}
	}
}

simulated function VehicleWeaponFired( bool bViaReplication, vector HitLocation, int SeatIndex )
{
    if(SeatIndex == 0) {
        super.VehicleWeaponFired(bViaReplication,HitLocation,SeatIndex);
    }
}

simulated function VehicleWeaponStoppedFiring( bool bViaReplication, int SeatIndex )
{
    if(SeatIndex == 0) {
        super.VehicleWeaponStoppedFiring(bViaReplication,SeatIndex);
    }
    
    // Trigger any vehicle Firing Effects
    if ( WorldInfo.NetMode != NM_DedicatedServer )
    {
        if (Role == ROLE_Authority || bViaReplication || WorldInfo.NetMode == NM_Client)
        {
            VehicleEvent('STOP_AltGun');
        }

    }
	
	if (Weapon.CurrentFireMode == 1)
	{
		PlaySound(FiringStopSound, TRUE, FALSE, FALSE, Location, FALSE);
		FiringAmbient.Stop();
	}
}



DefaultProperties
{

	bSecondaryFireTogglesFirstPerson=false
	
	missleBayToggle = 1;

//========================================================\\
//*********** Vehicle Seats & Weapon Properties **********\\
//========================================================\\


    Seats(0)={(GunClass=class'Rx_Vehicle_MediumTank_Weapon_MultiWeap_Ext',
                GunSocket=("Fire01", "MGFireSocket"),
                TurretControls=(TurretPitch,TurretRotate),
                GunPivotPoints=(MainTurretYaw,MainTurretPitch),
                CameraTag=CamView3P,
                CameraBaseOffset=(Z=20),
                CameraOffset=-460,
                SeatIconPos=(X=0.5,Y=0.33),
                MuzzleFlashLightClass=class'Rx_Light_Tank_MuzzleFlash_Ext'
                )}

//========================================================\\
//********* Vehicle Material & Effect Properties *********\\
//========================================================\\

	VehicleEffects(9)=(EffectStartTag="AltGun",EffectEndTag="STOP_AltGun",bRestartRunning=false,EffectTemplate=ParticleSystem'RX_VH_APC_GDI.Effects.P_MuzzleFlash_50Cal_Looping',EffectSocket="MGFireSocket")
	
//========================================================\\
//*************** Vehicle Audio Properties ***************\\
//========================================================\\
	
	Begin Object Class=AudioComponent name=FiringmbientSoundComponent
        bShouldRemainActiveIfDropped=true
        bStopWhenOwnerDestroyed=true
		SoundCue=SoundCue'RX_VH_MediumTank.Sounds.SC_MediumTank_MG'
//        SoundCue=SoundCue'RX_VH_Orca.Sounds.SC_Orca_Gun_Looping'
    End Object
    FiringAmbient=FiringmbientSoundComponent
    Components.Add(FiringmbientSoundComponent)
    
    FiringStopSound=SoundCue'RX_VH_MediumTank.Sounds.SC_MediumTank_MG_Stop'
}
