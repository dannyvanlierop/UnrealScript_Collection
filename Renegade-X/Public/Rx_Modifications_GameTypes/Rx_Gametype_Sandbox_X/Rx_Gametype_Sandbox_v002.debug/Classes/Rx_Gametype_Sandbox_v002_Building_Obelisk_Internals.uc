/*
** Rx_Gametype_Sandbox_v002_Building_Obelisk_Internals
*/
class Rx_Gametype_Sandbox_v002_Building_Obelisk_Internals extends Rx_Building_Obelisk_Internals;

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	return;
}
