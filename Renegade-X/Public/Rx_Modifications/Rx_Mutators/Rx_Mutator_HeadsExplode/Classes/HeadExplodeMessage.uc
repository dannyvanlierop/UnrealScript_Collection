//=============================================================================
// HeadExplodeMessage - A warning for all those big heads.
// It is pretty simple to set up a message with just plain text.
// by dP^Dude
//=============================================================================
class HeadExplodeMessage extends LocalMessage;

// The whole stuff is always the same for the GetString function.
//static function string GetString( optional int switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
//{
//    // This is the actual message that will be displayed.
//    return "Danger! Your head has reached a critical mass!";
//}

defaultproperties
{
	bFadeMessage=True
	bIsUnique=True
	FontSize=-1
	bBeep=False
    Lifetime=1.0                    // how many seconds the message is displayed
	bIsConsoleMessage=False

    DrawColor=(R=255,G=0,B=0,A=200) // R=Red, G=Green, B=Blue, A=Alpha
    DrawPivot=DP_MiddleMiddle
    StackMode=SM_None
    PosX=0.5                        // X-Position on the screen
    PosY=0.08                       // Y-Position on the screen
}

