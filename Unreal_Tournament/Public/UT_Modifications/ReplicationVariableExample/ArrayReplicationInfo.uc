class ArrayReplicationInfo extends ReplicationInfo;

struct SWrappedArray
{
	var RepNotify int IntArray[16];
};

var RepNotify int IntArray[16];
var RepNotify bool UpdateIntArray;
var RepNotify SWrappedArray WrappedArray;

replication
{
	if (bNetDirty)
		IntArray, UpdateIntArray, WrappedArray;
}

simulated event ReplicatedEvent(Name VarName)
{
	local string Text;
	local int i;

	Text = "";

	if (VarName == 'IntArray')
	{
		for (i = 0; i < ArrayCount(IntArray); ++i)
		{
			Text $= "["$i$"] = "$IntArray[i]$", ";
		}

		`Log(Self$":: Server updated ArrayReplicationInfo.IntArray to ("$Left(Text, Len(Text) - 2)$")");
	}
	else if (VarName == 'WrappedArray')
	{
		for (i = 0; i < ArrayCount(WrappedArray.IntArray); ++i)
		{
			Text $= "["$i$"] = "$WrappedArray.IntArray[i]$", ";
		}

		`Log(Self$":: Server updated ArrayReplicationInfo.WrappedArray.IntArray to ("$Left(Text, Len(Text) - 2)$")");
	}
}

defaultproperties
{
}