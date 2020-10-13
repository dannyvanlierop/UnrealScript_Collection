class VectorGameInfo extends GameInfo;

var VectorReplicationInfo VectorReplicationInfo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	VectorReplicationInfo = Spawn(class'VectorReplicationInfo');

	if (VectorReplicationInfo != None)
	{
		UpdateVectorReplicationInfo();
		SetTimer(10.f, true, 'UpdateVectorReplicationInfo');
	}
}

function UpdateVectorReplicationInfo()
{
	// Vector test
	VectorReplicationInfo.VectorTest.X = 1048575.f; // Maximum upper range
	VectorReplicationInfo.VectorTest.Y = -1048576.f; // Minimum lower range
	VectorReplicationInfo.VectorTest.Z = 65535.f; //RandRange(VectorReplicationInfo.VectorTest.Y, VectorReplicationInfo.VectorTest.X);
	`Log(Self$":: Server updated VectorReplicationInfo.VectorTest to (X="$VectorReplicationInfo.VectorTest.X$", Y="$VectorReplicationInfo.VectorTest.Y$", Z="$VectorReplicationInfo.VectorTest.Z$")");

	// Vector4 test
	VectorReplicationInfo.Vector4Test.X = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.Vector4Test.Y = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.Vector4Test.Z = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.Vector4Test.W = RandRange(-65536.65536f, 65536.65536f); 
	`Log(Self$":: Server updated VectorReplicationInfo.Vector4Test to (X="$VectorReplicationInfo.Vector4Test.X$", Y="$VectorReplicationInfo.Vector4Test.Y$", Z="$VectorReplicationInfo.Vector4Test.Z$", W="$VectorReplicationInfo.Vector4Test.W$")");

	// Vector2D test
	VectorReplicationInfo.Vector2DTest.X = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.Vector2DTest.Y = RandRange(-65536.65536f, 65536.65536f); 
	`Log(Self$":: Server updated VectorReplicationInfo.Vector2DTest to (X="$VectorReplicationInfo.Vector2DTest.X$", Y="$VectorReplicationInfo.Vector2DTest.Y$")");

	// TwoVectors test
	VectorReplicationInfo.TwoVectorsTest.V1.X = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.TwoVectorsTest.V1.Y = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.TwoVectorsTest.V1.Z = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.TwoVectorsTest.V2.X = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.TwoVectorsTest.V2.Y = RandRange(-65536.65536f, 65536.65536f); 
	VectorReplicationInfo.TwoVectorsTest.V2.Z = RandRange(-65536.65536f, 65536.65536f); 
	`Log(Self$":: Server updated VectorReplicationInfo.TwoVectorsTest to [0]=(X="$VectorReplicationInfo.TwoVectorsTest.V1.X$", Y="$VectorReplicationInfo.TwoVectorsTest.V1.Y$", Z="$VectorReplicationInfo.TwoVectorsTest.V1.Z$"), [1]=X=("$VectorReplicationInfo.TwoVectorsTest.V2.X$", Y="$VectorReplicationInfo.TwoVectorsTest.V2.Y$", Z="$VectorReplicationInfo.TwoVectorsTest.V2.Z$")");
}

defaultproperties
{
}