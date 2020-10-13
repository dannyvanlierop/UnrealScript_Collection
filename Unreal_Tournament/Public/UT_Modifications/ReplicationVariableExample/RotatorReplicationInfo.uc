class RotatorReplicationInfo extends ReplicationInfo;

var RepNotify Rotator RotatorTest;
var RepNotify TPOV TPOVTest;

replication
{
	if (bNetDirty)
		RotatorTest, TPOVTest;
}

simulated event ReplicatedEvent(Name VarName)
{
	switch (VarName)
	{
	case 'RotatorTest':
		`Log(Self$":: ReplicatedEvent():: RotatorTest is updated to (Pitch="$RotatorTest.Pitch$", Yaw="$RotatorTest.Yaw$", Roll="$RotatorTest.Roll$")");
		break;

	case 'TPOVTest':
		`Log(Self$":: ReplicatedEvent():: TPOVTest is updated to [Location]=(X="$TPOVTest.Location.X$", Y="$TPOVTest.Location.Y$", Z="$TPOVTest.Location.Z$"), [Rotation]=(Pitch="$TPOVTest.Rotation.Pitch$", Yaw="$TPOVTest.Rotation.Yaw$", Roll="$TPOVTest.Rotation.Roll$"), [FOV]="$TPOVTest.FOV);
		break;

	default:
		break;
	}
}

defaultproperties
{
}