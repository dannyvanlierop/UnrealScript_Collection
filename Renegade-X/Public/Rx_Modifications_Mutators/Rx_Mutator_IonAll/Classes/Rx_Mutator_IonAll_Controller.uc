/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*    This mutator will add the Dev IonAll function to the Renegade X game    *
*              Be warned, all players can use this feature                    *
*******************************************************************************
* Rx_Mutator_IonAll_Controller                                               *
******************************************************************************/
 
class Rx_Mutator_IonAll_Controller extends Rx_Controller;

exec function Ion(string PlayerName)
{
	IonServer(PlayerName);
}

exec function IonAll(optional string sParameter)
{
	IonAllServer(sParameter);
}

reliable server function IonServer(string PlayerName)
{
	local Rx_Weapon_DevIon Ion;
	local Rx_PRI PRI;

	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

	if (PRI != None && Controller(PRI.Owner) != None) 
	{ 
		Ion = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevIon',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
		Ion.TeamNum = TEAM_UNOWNED; 
	}
}

reliable server function IonAllServer(optional string sParameter)
{
	local Rx_Weapon_DevIon Ion;
	local Rx_Controller C;

	if ( Len(sParameter) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}
	else
	{
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			Ion = C.Pawn.Spawn(class'Rx_Weapon_DevIon',,, C.Pawn.Location, C.Pawn.Rotation);
			Ion.TeamNum = TEAM_UNOWNED; 
		} 
	}
}

exec function Nuke(string PlayerName)
{
	NukeServer(PlayerName);
}
exec function NukeAll(optional string sParameter)
{
	NukeAllServer(sParameter);
}

reliable server function NukeServer(string PlayerName)
{
	local Rx_Weapon_DevNuke Beacon;
	local Rx_PRI PRI;

	PRI = Rx_Game(WorldInfo.Game).ParsePlayer(PlayerName);

	if (PRI != None && Controller(PRI.Owner) != None) 
	{ 
		Beacon = Controller(PRI.Owner).Pawn.Spawn(class'Rx_Weapon_DevNuke',,, Controller(PRI.Owner).Pawn.Location, Controller(PRI.Owner).Pawn.Rotation);
		Beacon.TeamNum = TEAM_UNOWNED; 
	}
}

reliable server function NukeAllServer(optional string sParameter)
{
	local Rx_Weapon_DevNuke Beacon;
	local Rx_Controller C;
	
	ClientMessage( "sParameter: " $ sParameter );
	
	if ( Len(sParameter) > 0)
	{
		ClientMessage( "Too many parameters!" );
		return;
	}	
	else 
	{
		foreach WorldInfo.AllControllers(class'Rx_Controller', C) 
		{ 
			Beacon = C.Pawn.Spawn(class'Rx_Weapon_DevNuke',,, C.Pawn.Location, C.Pawn.Rotation);
			Beacon.TeamNum = TEAM_UNOWNED; 
		} 
	}
}
