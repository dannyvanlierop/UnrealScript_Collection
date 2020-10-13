class RN_ExampleReplicationInfo extends ReplicationInfo;

var RepNotify int IntExample;
var RepNotify byte ByteExample;
var RepNotify float FloatExample;
var RepNotify String StringExample;
var RepNotify Vector VectorExample;
var RepNotify Rotator RotatorExample;
var RepNotify Color ColorExample;

replication
{
	// Replicate when dirty
	if (bNetDirty)
		IntExample, ByteExample, FloatExample, StringExample, VectorExample, RotatorExample, ColorExample;
}

/**
 * PostBeginPlay is executed after the RN_ExampleReplicationInfo is created
 *
 * Network: All
 */
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == Role_Authority)
	{
		`Log(Self$":: PostBeginPlay():: Executed on the server.");
	}
	else
	{
		`Log(Self$":: PostBeginPlay():: Executed on the client.");
	}
}

/**
 * ReplicatedEvent is called when a variable with the RepNotify property flag is updated
 *
 * Network: All
 */
simulated event ReplicatedEvent(name VarName)
{
	local String Text;

	if (Role == Role_Authority)
	{
		Text = "Server";
	}
	else
	{
		Text = "Client";
	}

	switch (VarName)
	{
	case 'IntExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: IntExample is now "$IntExample$".");
		break;

	case 'ByteExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: ByteExample is now "$ByteExample$".");
		break;

	case 'FloatExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: FloatExample is now "$FloatExample$".");
		break;

	case 'StringExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: StringExample is now '"$StringExample$"'.");
		break;

	case 'VectorExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: VectorExample is now (X="$VectorExample.X$", Y="$VectorExample.Y$", Z="$VectorExample.Z$").");
		break;

	case 'RotatorExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: RotatorExample is now (Pitch="$RotatorExample.Pitch$", Yaw="$RotatorExample.Yaw$", Roll="$RotatorExample.Roll$").");
		break;

	case 'ColorExample':
		`Log(Self$":: ReplicatedEvent():: "$Text$":: ColorExample is now (R="$ColorExample.R$", G="$ColorExample.G$", B="$ColorExample.B$", A="$ColorExample.A$").");
		break;
	}
}

defaultproperties
{
}