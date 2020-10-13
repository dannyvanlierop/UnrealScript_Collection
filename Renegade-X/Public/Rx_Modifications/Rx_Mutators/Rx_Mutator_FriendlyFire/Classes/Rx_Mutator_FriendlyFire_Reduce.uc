/*
**  by Ukill, supported by google :).
**  this mutator will add the ............. function to the Renegade X game
*/

class Rx_Mutator_FriendlyFire_Reduce extends UTMutator;

var float FriendlyFireScale;

function bool MutatorIsAllowed()
{
    return UTTeamGame(WorldInfo.Game) != None && Super.MutatorIsAllowed();
}

function InitMutator(string Options, out string ErrorMessage)
{
    UTTeamGame(WorldInfo.Game).FriendlyFireScale = FriendlyFireScale;
    super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
   FriendlyFireScale=5.00000
   GroupNames(0)=FRIENDLYFIRE
}
