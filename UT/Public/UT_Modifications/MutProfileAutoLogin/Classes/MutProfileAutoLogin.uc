//=============================================================================
// Profile AutoLogin Mutator - Provides profile auto-login when bypassing the
//							   frontend login menus.
//
// Version: v0.3 beta
// Tested: UT3 v1.1 (build 3521)
// Typical commandline usage:
//		?mutator=MutProfileAutoLogin.MutProfileAutoLogin?ProfileName=N00blet?ProfilePassword=pwnt
// Other options:
//	?ProfileAutoLogin=1 will attempt to use built-in auto-login feature first,
//		where -login=<name> -password=<pwd> is specified on the commandline.
//		However, this appears to be broken (thus the reason for this mod!).
//	?ProfileLocalLogin=1 will login locally (not sure how useful this is, but
//		again, I wanted to preserve the option in the underlying code).
//
// Copyright (C) 2007-2008 - Allan "Geist" Campbell.
//=============================================================================
class MutProfileAutoLogin extends UTMutator
	config(MutProfileAutoLogin);

//=============================================================================
function ModifyLogin(out string Portal, out string Options)
{
	local OnlinePlayerInterface PlayerInt;
	local string UserName;
	local string Password;
	local bool bLocalLogin;

	// First try using built-in AutoLogin() method (using -login=... and -password=... commandline switches)
	if( class'GameInfo'.static.GetIntOption( Options, "ProfileAutoLogin", 0 ) != 0 )
	{
		LogInternal("Profile auto-login intiated...");

		PlayerInt = class'UTUIScene'.static.GetPlayerInterface();
		if( ( PlayerInt != None ) && PlayerInt.AutoLogin() )
		{
			LogInternal("MutProfileAutoLogin::ModifyLogin() - Profile auto-login completed.");
			return;
		}
		else
			LogInternal("MutProfileAutoLogin::ModifyLogin() - Profile auto-login failed.");
	}

	// AutoLogin() failed, so fall back to ?profilename=... and ?profilepassword=... commandline var options
	bLocalLogin = class'GameInfo'.static.GetIntOption( Options, "ProfileLocalLogin", 0 ) == 0 ? false : true;
	UserName = class'GameInfo'.static.ParseOption( Options, "ProfileName" );
	Password = class'GameInfo'.static.ParseOption( Options, "ProfilePassword" );
	if( Len( UserName ) > 0 || bLocalLogin )
	{
		if( Len( Password ) > 0 || bLocalLogin )
		{
			LogInternal("MutProfileAutoLogin::ModifyLogin() - Profile auto-login intiated with name '"$UserName$"' bLocalOnly:"@bLocalLogin$"...");

			PlayerInt = class'UTUIScene'.static.GetPlayerInterface();
			if( PlayerInt != None )
			{
				if( PlayerInt.Login( 0, UserName, Password, bLocalLogin ) )
					LogInternal("MutProfileAutoLogin::ModifyLogin() - Profile auto-login completed.");
				else
					LogInternal("MutProfileAutoLogin::ModifyLogin() - Profile auto-login failed.");
			}
			else
				LogInternal("MutProfileAutoLogin::ModifyLogin() - Failed to find player interface.");
		}
		else
			LogInternal("MutProfileAutoLogin::ModifyLogin() - Invalid/missing profile password.");
	}
	else
		LogInternal("MutProfileAutoLogin::ModifyLogin() - Invalid/missing profile username.");

	Super.ModifyLogin( Portal, Options );
}

//=============================================================================

// Decompiled with UE Explorer.
defaultproperties
{
    GroupNames=/* Array type was not detected. */
    Components(0)=SpriteComponent'Default__MutProfileAutoLogin.Sprite'
}