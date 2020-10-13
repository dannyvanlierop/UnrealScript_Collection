class ArrayGameInfo extends GameInfo;

var ArrayReplicationInfo ArrayReplicationInfo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	ArrayReplicationInfo = Spawn(class'ArrayReplicationInfo');

	if (ArrayReplicationInfo != None)
	{
		SetTimer(10.f, true, 'UpdateArrayReplicationInfo');
	}
}

function UpdateArrayReplicationInfo()
{
	local int i;
	local string Text;

	Text = "";

	// Update the int array
	for (i = 0; i < ArrayCount(ArrayReplicationInfo.IntArray); ++i)
	{
		ArrayReplicationInfo.IntArray[i] = RandRange(-32768, 32768);
		Text $= "["$i$"] = "$ArrayReplicationInfo.IntArray[i]$", ";
	}
	ArrayReplicationInfo.UpdateIntArray = !ArrayReplicationInfo.UpdateIntArray;
	//`Log(Self$":: Server updated ArrayReplicationInfo.IntArray to ("$Left(Text, Len(Text) - 2)$")");

	Text = "";
	// Update the wrapped int array
	for (i = 0; i < ArrayCount(ArrayReplicationInfo.WrappedArray.IntArray); ++i)
	{
		ArrayReplicationInfo.WrappedArray.IntArray[i] = RandRange(-32768, 32768);
		Text $= "["$i$"] = "$ArrayReplicationInfo.WrappedArray.IntArray[i]$", ";
	}

	//`Log(Self$":: Server updated ArrayReplicationInfo.WrappedArray.IntArray to ("$Left(Text, Len(Text) - 2)$")");

}

defaultproperties
{
}