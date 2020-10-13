//=============================================================================
// MutHeadExplo - Heads Explode, that's always fun!
// The mutator for a not so boring gameplay!
// This class is the one that manages the other classes of the mutator.
// by dP^Dude
//=============================================================================
class MutHeadExplo extends Mutator;

// This is called immediately after the game has begun and adds the new game
// rules that are used in the game with the use of the mutator.
function PostBeginPlay()
{
	local HeadsExplodeRules G;
    G = Spawn(class'HeadsExplodeRules');
	G.HeadsExplodeMutator = self;

	if ( Level.Game.GameRulesModifiers == None )
	   { Level.Game.GameRulesModifiers = G; }
	else
	   { Level.Game.GameRulesModifiers.AddGameRules(G); }

	Super.PostBeginPlay();
}

// This function is used to replace every adrenaline pill with the new 'Head Shrink Pills'
// which are found in HeadShrinkPill.uc.
function bool CheckReplacement( Actor Other, out byte bSuperRelevant )
{
	bSuperRelevant = 0;
    if ( string(Other.Class) == "XPickups.AdrenalinePickup" )
        { ReplaceWith( Other, "DudeMut.HeadShrinkPill"); }
	else
        { return true; }
}

defaultproperties
{
    IconMaterialName="MutatorArt.nosym"
    ConfigMenuClassName=""
    // It's the same group like the Big Head mutator so there won't be any
    // problems, because you can use only one of the two at a time.
    GroupName="BigHead"
    FriendlyName="Heads Explode" // name of the mutator
    Description="Your head grows and grows AND GROWS..."
}

