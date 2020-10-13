/*
** Rx_Gametype_Sandbox_v002_Building_Refinery_GDI_Internals
*/
class Rx_Gametype_Sandbox_v002_Building_Refinery_GDI_Internals extends Rx_Building_Refinery_GDI_Internals;

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	return;
}
