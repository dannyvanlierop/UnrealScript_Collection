class VectorReplicationInfo extends ReplicationInfo;

struct AlwaysRepVector
{
	var int I;
	var Vector V;
};

// Test vector replication
var RepNotify Vector VectorTest;
// Test vector4 replication
var RepNotify Vector4 Vector4Test;
// Test Vector2D replication
var RepNotify Vector2D Vector2DTest;
// Test Two vectors replication
var RepNotify TwoVectors TwoVectorsTest;

replication
{
	if (bNetDirty)
		VectorTest, Vector4Test, Vector2DTest, TwoVectorsTest;
}

simulated event ReplicatedEvent(Name VarName)
{
	switch (VarName)
	{
	case 'VectorTest':
		`Log(Self$":: VectorTest updated to (X="$VectorTest.X$", Y="$VectorTest.Y$", Z="$VectorTest.Z$")");
		break;

	case 'Vector4Test':
		`Log(Self$":: Vector4Test updated to (X="$Vector4Test.X$", Y="$Vector4Test.Y$", Z="$Vector4Test.Z$", W="$Vector4Test.W$")");
		break;

	case 'Vector2DTest':
		`Log(Self$":: Vector2DTest updated to (X="$Vector2DTest.X$", Y="$Vector2DTest.Y$")");
		break;

	case 'TwoVectorsTest':
		`Log(Self$":: TwoVectorsTest updated to [0]=(X="$TwoVectorsTest.V1.X$", Y="$TwoVectorsTest.V1.Y$", Z="$TwoVectorsTest.V1.Z$"), [1]=(X="$TwoVectorsTest.V2.X$", Y="$TwoVectorsTest.V2.Y$", Z="$TwoVectorsTest.V2.Z$")");
		break;

	default:
		break;
	}
}

defaultproperties
{
}