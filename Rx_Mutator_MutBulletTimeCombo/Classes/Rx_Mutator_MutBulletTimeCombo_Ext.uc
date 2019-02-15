//class Rx_Mutator_MutBulletTimeCombo_Ext extends Combo;
class Rx_Mutator_MutBulletTimeCombo_Ext extends UTMutator;
 
var float fOrigGameSpeed;
 
/*
This function will get called when right combination is entered.
*/
function StartEffect(Pawn P)
{
     fOrigGameSpeed = Level.Game.GameSpeed;
     Level.Game.SetGameSpeed(0.05);
}
 
 
/*
This function gets called when adrenaline is all gone.
*/
function StopEffect(Pawn P)
{
     Level.Game.SetGameSpeed(fOrigGameSpeed);
}
 
defaultproperties
{
     fOrigGameSpeed = 1.0;
     Duration = 3;
     ExecMessage = "Bullet Time!"
     keys[0] = 1;
     keys[1] = 2;
     keys[2] = 1;
     keys[3] = 2;
}