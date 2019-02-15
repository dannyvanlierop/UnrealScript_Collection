/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*         This mutator will disable FallDamage in the Renegade X game         *
*******************************************************************************
* Rx_Mutator_GrowHead                                                          *
******************************************************************************/

Class Rx_Mutator_GrowHead extends UTMutator;

simulated function PostBeginPlay() // Function called after game starts
{
	SetTimer(2, true, 'GrowHead');
	super.PostBeginPlay(); // We don't want to overide PostBeginPlay()
}

simulated function Growhead() // What to do every time ticks
{
//	local UTPawn player; 
    local UTPawn P;	//variable of th "UTPawn" class
							//iterate through non-static actors of the class 'UTPawn'
//    P = UTPawn(P);
    
	foreach DynamicActors(class'Pawn',P)
	{
		if ( P != None ) // is there a player to modify?
		{
			P.SetHeadScale(P.HeadScale+0.4); // add 0.4 tothe player's head scale
			P.GroundSpeed-=30; // Subtract 30 from the player's ground speed
			if((P.HeadScale>=5)||(P.GroundSpeed<100)||(P.Health<50)) // Proper checks
			{
				RestoreDefaults(P)
			}
		}
	}
}


simulated function RestoreDefaults(Pawn P)
{
	P.SetHeadScale(1);
	P.GroundSpeed=440;
}

defaultproperties
{

}
 