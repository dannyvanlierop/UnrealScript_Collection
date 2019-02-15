//=============================================================================
// HeadsExplodeRules - Here all the magic is done.
// For easy understanding I've put comments into the code, so that
// the beginners can learn something they might find useful.
// by dP^Dude
//=============================================================================
//class HeadsExplodeRules extends GameRules;
class HeadsExplodeRules extends GameInfo;

var MutHeadExplo HeadsExplodeMutator; // used in MutHeadExplo

// The following variables are set in the defaultproperties for easy changing.
var() float HeadScaleAmount;
var() float HeadIncSize;
var() float HeadScaleMaxAmount;
var() float KillHeadShrinkReward;

// The Tick function is executed every frame and Delta is the number of seconds
// that have passed since the last call.
function Tick(float Delta)
{
    // Variables used to access other classes in this script.
    local Controller C;
    local Actor A;

    // I want the script to affect every Controller (Player & Bot) in the game.
    for (C = Level.ControllerList; C != none; C = C.NextController)
    {
        // To prevent errors I check if the controller pawn isn't none.
        if ( C.Pawn != none)
        {
            // Some things I've logged to debug my code, because there was a
            // major bug in it. I didn't delete them for you might find them
            // useful.
            /*
            log("Time: "$Level.TimeSeconds);
            log("Name: "$C.PlayerReplicationInfo.PlayerName);
            log("HeadScale before: "$C.Pawn.HeadScale);
            */

            // If the head size of the player or bot has reached or passed a set
            // amount I want him to explode.
            if ( C.Pawn.HeadScale >= HeadScaleMaxAmount )
            {
                // First reset his head size to the default amount (HeadScaleAmount).
                C.Pawn.SetHeadScale(HeadScaleAmount);

                // I also spawn a Redeemer explosion at his position with sound
                // and the graphic effects.
                C.Pawn.Spawn(class'xEffects.RedeemerExplosion');
                C.Pawn.PlaySound(sound'WeaponSounds.BExplosion3',,150*TransientSoundVolume);
                C.Pawn.PlaySound(sound'WeaponSounds.redeemer_explosionsound',,150*TransientSoundVolume);
                C.Pawn.PlaySound(sound'WeaponSounds.redeemer_explosionsound',,150*TransientSoundVolume);
                C.Pawn.PlaySound(sound'WeaponSounds.redeemer_explosionsound',,150*TransientSoundVolume);
                C.Pawn.PlaySound(sound'WeaponSounds.redeemer_explosionsound',,150*TransientSoundVolume);

                // This creates the blast radius around the player (and kills
                // him also). The damage type is set to Redeemer so the death
                // message will be the same as if he and the others were blown
                // away with a Redeemer. It's important to set the location to
                // the one of the exploding player or it won't create the blast
                // around him.
                HurtRadius(500, 2000, class'DamTypeRedeemer', 200000, C.Pawn.Location);
            }
            // If the players head size just reached a dangerous size I want to
            // warn him. So I display a message on his HUD. Therefore I made a
            // class that extends the LocalMessage (see HeadExplodeMessage.uc).
            else if ( (C.Pawn.HeadScale >= (HeadScaleMaxAmount-1) ) && (C.Pawn.HeadScale < (HeadScaleMaxAmount) ) )
            {
                // This sends the message I've done in HeadExplodeMessage to the
                // players HUD.
                C.Pawn.ReceiveLocalizedMessage(class'HeadExplodeMessage',0,Pawn(A).PlayerReplicationInfo);
                // This lets the head grow smooth, because of the multiplication
                // with Delta. The head size still grows by HeadIncSize every
                // second this way.
                C.Pawn.SetHeadScale(C.Pawn.HeadScale+HeadIncSize*Delta);
            }
            // If none of the two conditions were true the players head size must
            // be lower than HeadScaleMaxAmount-1 and we just increase the head
            // size like above, but without a message.
	 	    else { C.Pawn.SetHeadScale(C.Pawn.HeadScale+HeadIncSize*Delta); }

            /*
            log("Time: "$Level.TimeSeconds);
            log("Name: "$C.PlayerReplicationInfo.PlayerName);
            log("HeadScale after: "$C.Pawn.HeadScale);
            */
        }

    }
}

// To reward people for killing others I've to call the ScoreKill function.
// Where I can add bonuses for kills.
function ScoreKill(Controller Killer, Controller Killed)
{
	if ( (Killer != none) && (Killer.Pawn != none) )
	{
	   // A kill decreases the head size by KillHeadShrinkReward. But the size
	   // doesn't drop below the default value (HeadScaleAmount).
	   if ( (Killer.Pawn.HeadScale-KillHeadShrinkReward) < HeadScaleAmount )
	       { Killer.Pawn.SetHeadScale(HeadScaleAmount); }
	   else
	       { Killer.Pawn.SetHeadScale(Killer.Pawn.HeadScale-KillHeadShrinkReward); }

       // An extra reward if the player is on a spree. But the size doesn't drop
       // below the default value (HeadScaleAmount).
       if ( (UnrealPawn(Killer.Pawn) != none) && (UnrealPawn(Killer.Pawn).Spree > 4) && ((Killer.Pawn.HeadScale-KillHeadShrinkReward*4) >= HeadScaleAmount) )
	       { Killer.Pawn.SetHeadScale(Killer.Pawn.HeadScale-KillHeadShrinkReward*4); }
	   else
	       { Killer.Pawn.SetHeadScale(Killer.Pawn.HeadScale-KillHeadShrinkReward); }

	   // An extra reward if the player has multi kills. But the size doesn't
       // drop below the default value (HeadScaleAmount).
	   if ( (UnrealPlayer(Killer).MultiKillLevel > 0) && ((Killer.Pawn.HeadScale-KillHeadShrinkReward*4) >= HeadScaleAmount) )
	       { Killer.Pawn.SetHeadScale(Killer.Pawn.HeadScale-KillHeadShrinkReward*4); }
	   else
	       { Killer.Pawn.SetHeadScale(Killer.Pawn.HeadScale-KillHeadShrinkReward); }
	}

    // If there are other mutators that affect the ScoreKill function I call
    // them when my script is done.
	if ( NextGameRules != none )
	   { NextGameRules.ScoreKill(Killer,Killed); }
}

// if the player gets killed before his head explodes his head has to be resized
// to the default vaule (HeadScaleAmount).
function Killed( Controller Killer, Controller Killed, Pawn KilledPawn, class<DamageType> damageType )
{
    // Reset to the defaul head size.
    if ( Killed != none )
	   { Killed.Pawn.SetHeadScale(HeadScaleAmount); }
}

// Here I define all the variables that are used in the script. This makes it
// easier to change them and balance the stuff without going through the whole
// script. And you can use them in other scripts also. (See HeadShrinkPill.uc)
defaultproperties
{
    HeadScaleAmount=1.0         // my default head size
    HeadIncSize=0.25            // the amount the head grows per second
    HeadScaleMaxAmount=8.0      // the size that must be reached to let the head explode
    KillHeadShrinkReward=0.5    // the size that the head shrinks when the player does something
}
