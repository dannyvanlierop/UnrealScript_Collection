class StructReplicationInfo extends ReplicationInfo;

struct CustomStruct
{
	var string String;
	var float Float;
	var int Int;
};

var RepNotify CustomStruct TestCustomStruct;

replication
{
	if (bNetDirty)
		TestCustomStruct;
}

simulated event ReplicatedEvent(Name VarName)
{
	if (VarName == 'TestCustomStruct')
	{
		`Log(Self$":: ReplicatedEvent():: TestCustomStruct is updated to (String="$TestCustomStruct.String$", Float="$TestCustomStruct.Float$", Int="$TestCustomStruct.Int$")");
	}
}

defaultproperties
{
}