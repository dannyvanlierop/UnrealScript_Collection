/******************************************************************************
*  Modified by Ukill, this can contain parts of code written by Jessica\Yosh  *
*       This mutator will add the .... function to the Renegade X game        *
*******************************************************************************
* Rx_Mutator__Name                                                            *
******************************************************************************/

class Rx_Mutator__Name extends UTMutator;

function bool CheckReplacement(Actor Other) {
	if(Other.IsA('Rx_TeamInfo')) {
		Rx_Game(WorldInfo.Game).DefaultPawnClass = class'Rx_Mutator__Name_Pawn' ;
		Rx_Game(WorldInfo.Game).PlayerControllerClass = class'Rx_Mutator__Name_Controller' ; 
		HUDType
		CameraClass=class'UDNGame.UDNPlayerCamera'
	}
return true;
}

/* Sampled from a ModifyPlayer definition in a custom mutator */
// If there is another mutator in the chain
if ( NextMutator != None )
// Call this method in the next mutator; pass the same parameters
NextMutator.ModifyPlayer(Other);


/* The following code assumes that you have a variable called myRules representing your rules; see MutMiceMen.uc for an example. */
 
	// Add the rules object to the list of GameRules in the game
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = myRules;
	else
		Level.Game.GameRulesModifiers.AddGameRules(myRules);
		


	myVec = Normal(InstigatedBy.Location - Injured.Location);
	multVec.x = mutInstance.MovementMultiplier * 100; 
	multVec.y = mutInstance.MovementMultiplier * 100; 
	multVec.z = mutInstance.MovementMultiplier * 100;   // scale normalized vector;
	myVec = myVec * multVec;
	Injured.AddVelocity(myVec);



	if ( (Killer != None) && (Killer.Pawn != None) )
		mutInstance.ChangePlayerSize(Killer.Pawn, mutInstance.GetScaleFor(Killer.Pawn));


PostBeginPlay()






























class Rx_Mutator extends UTMutator
	abstract;

/** Gets the next Rx_Mutator in the list (required for Rx_Mutator specific hooks) */
function Rx_Mutator GetNextRxMutator()
{
	local Mutator M;

	for (M = NextMutator; M != None; M = M.NextMutator)
	{
		if (Rx_Mutator(M) != None)
			return Rx_Mutator(M);
	}

	return None;
}

function String GetAdditionalServersettings();
function InitRconCommands();




		
DefaultProperties {
}
 