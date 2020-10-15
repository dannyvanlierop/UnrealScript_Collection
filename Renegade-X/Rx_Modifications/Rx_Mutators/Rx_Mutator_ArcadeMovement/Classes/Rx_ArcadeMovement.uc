/*
** Rx_ArcadeMovement
*/

class Rx_ArcadeMovement extends UTMutator ;


function bool CheckReplacement(Actor Other) {


local Rx_Game RxGC ;


if(Other.IsA('Rx_TeamInfo')) {


RxGC = Rx_Game(WorldInfo.Game) ;
Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Pawn_Ext' ;
Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Controller_Ext' ;


Rx_Game(WorldInfo.Game).bAllowWeaponDrop = true ; 


}

return true;
}
