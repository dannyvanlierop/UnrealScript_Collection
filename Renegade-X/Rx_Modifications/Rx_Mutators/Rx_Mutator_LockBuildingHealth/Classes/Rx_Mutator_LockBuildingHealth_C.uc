class Rx_Mutator_LockBuildingHealth_C extends Rx_Controller;

var Rx_Building_Team_Internals BuildingInternals;
//var Rx_Building_Internals Rx_BTI;
var bool                    bNoPower;

exec Function AdminToolLockBuildingHealthCheck (){
	
	if ( BuildingInternals.bNoPower == true )
	{
		ClientMessage(" BuildingInternals.bNoPower = true ");
	}
	else
	{
		ClientMessage(" BuildingInternals.bNoPower = false ");
	}
}

exec Function AdminToolLockBuildingHealth (bool Value){
	
	bNoPower = (Value);
	
    foreach class'Engine'.static.GetCurrentWorldInfo().AllActors(class'Rx_Building_Team_Internals', BuildingInternals)
    {
        BuildingInternals.bNoPower = bNoPower;        
    } 
/*	
	HealthLocked = (Value);
	
    foreach class'Engine'.static.GetCurrentWorldInfo().AllActors(class'Rx_Building_Team_Internals', BuildingInternals)
    {
        BuildingInternals.HealthLocked = HealthLocked;        
	} 
*/
}





defaultproperties
{
}

