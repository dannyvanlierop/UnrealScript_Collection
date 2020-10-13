/*
** Rx_Gametype_Sandbox_v002_Building_Refinery_Nod_Internals
*/
class Rx_Gametype_Sandbox_v002_Building_Refinery_Nod_Internals extends Rx_Building_Refinery_Nod_Internals;

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	return;
}
