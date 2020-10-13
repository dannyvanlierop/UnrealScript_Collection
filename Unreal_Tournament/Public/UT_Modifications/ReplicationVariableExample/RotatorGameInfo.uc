class RotatorGameInfo extends GameInfo;

var RotatorReplicationInfo RotatorReplicationInfo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	RotatorReplicationInfo = Spawn(class'RotatorReplicationInfo');

	if (RotatorReplicationInfo != None)
	{
		UpdateRotatorReplicationInfo();
		SetTimer(10.f, true, 'UpdateRotatorReplicationInfo');
	}
}

function UpdateRotatorReplicationInfo()
{
	// Rotator test	
	RotatorReplicationInfo.RotatorTest.Pitch = RandRange(-65536,65536);
	RotatorReplicationInfo.RotatorTest.Yaw = RandRange(-65536,65536);
	RotatorReplicationInfo.RotatorTest.Roll = RandRange(-65536,65536);
	`Log(Self$":: Server updated RotatorReplicationInfo.RotatorTest to (Pitch="$RotatorReplicationInfo.RotatorTest.Pitch$", Yaw="$RotatorReplicationInfo.RotatorTest.Yaw$", Roll="$RotatorReplicationInfo.RotatorTest.Roll$")");

	// TPOV test
	RotatorReplicationInfo.TPOVTest.Location.X = 0.f;
	RotatorReplicationInfo.TPOVTest.Location.Y = 0.f;
	RotatorReplicationInfo.TPOVTest.Location.Z = 0.f;
	RotatorReplicationInfo.TPOVTest.Rotation.Pitch = RandRange(-65536,65536);
	RotatorReplicationInfo.TPOVTest.Rotation.Yaw = -RandRange(-65536,65536);
	RotatorReplicationInfo.TPOVTest.Rotation.Roll = RandRange(-65536,65536);
	`Log(Self$":: Server updated RotatorReplicationInfo.TPOVTest to (Pitch="$RotatorReplicationInfo.TPOVTest.Rotation.Pitch$", Yaw="$RotatorReplicationInfo.TPOVTest.Rotation.Yaw$", Roll="$RotatorReplicationInfo.TPOVTest.Rotation.Roll$")");
}

defaultproperties
{
}