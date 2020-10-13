/*
** Rx_Gametype_Sandbox_v002_IndestructibleStructures
*/
class Rx_Gametype_Sandbox_v002_IndestructibleStructures extends Rx_Mutator;



function bool CheckReplacement (Actor Other)
{

	
	if(Other.IsA('Rx_Building'))
	{
		Rx_Building(Other).HealthMax = 9000000;
		Rx_Building(Other).Health = 9000000;
	}
	


	return True;
}
