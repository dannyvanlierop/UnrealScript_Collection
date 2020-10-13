//=============================================================================
// HeadShrinkPill - Shrinks your head. I think. +lol+
// by dP^Dude
//=============================================================================
class HeadShrinkPill extends AdrenalinePickup;

var() float HeadShrinkAmount;

auto state Pickup
{
    function Touch( actor Other )
    {
        local Pawn P;
        local float R;
        P = Pawn(Other);
        // This sets R to the value I set in HeadsExplodeRules in the default
        // value to HeadScaleAmount (the default head size).
        R = class'HeadsExplodeRules'.default.HeadScaleAmount;

        // If the player picks up a 'Head Shrinker Pill' I don't want to shrink
        // the head below my default value or disappear completely.
        if (ValidTouch(Other))
    	{
            if ( (P.HeadScale-HeadShrinkAmount) < R )
                { P.SetHeadScale(R); }
            else
                { P.SetHeadScale(P.HeadScale-HeadShrinkAmount); }
            AnnouncePickup(P);  // announce the pickup
            SetRespawn();       // let it respawn after RespawnTime is over
        }
    }
}

defaultproperties
{
    PickupMessage="Head Shrinker Pill"
    HeadShrinkAmount=0.75   // the amount the head shrinks with every pickup
    RespawnTime=30.000000   // time to respawn the pills
}
