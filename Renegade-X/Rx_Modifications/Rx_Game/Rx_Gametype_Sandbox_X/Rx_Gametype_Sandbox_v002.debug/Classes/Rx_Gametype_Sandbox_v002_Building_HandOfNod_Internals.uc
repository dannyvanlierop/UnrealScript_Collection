/*
** Rx_Gametype_Sandbox_v002_Building_HandOfNod_Internals
*/
class Rx_Gametype_Sandbox_v002_Building_HandOfNod_Internals extends Rx_Building_HandOfNod_Internals;

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	return;
}
