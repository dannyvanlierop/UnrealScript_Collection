class RN_PlayerController extends PlayerController;

/**
 * Returns an instance of Example Replication Info
 *
 * Network: Dedicated/Listen Server
 */
function RN_ExampleReplicationInfo GetExampleReplicationInfoInstance()
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ForEach DynamicActors(class'RN_ExampleReplicationInfo', ExampleReplicationInfo)
	{
		return ExampleReplicationInfo;
	}
}

/**
 * RPC to update the int
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateInt(int I)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateInt:: Updating int with "$I$".");
		ExampleReplicationInfo.IntExample = I;
		ExampleReplicationInfo.ReplicatedEvent('IntExample');
	}
}

/**
 * RPC to update the byte
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateByte(byte B)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateByte:: Updating byte with "$B$".");
		ExampleReplicationInfo.ByteExample = B;
		ExampleReplicationInfo.ReplicatedEvent('ByteExample');
	}
}

/**
 * RPC to update the float
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateFloat(float F)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateFloat:: Updating float with "$F$".");
		ExampleReplicationInfo.FloatExample = F;
		ExampleReplicationInfo.ReplicatedEvent('FloatExample');
	}
}

/** 
 * RPC to update the string
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateString(string S)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateString:: Updating string with "$S$".");
		ExampleReplicationInfo.StringExample = S;
		ExampleReplicationInfo.ReplicatedEvent('StringExample');
	}
}

/**
 * RPC to update the vector
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateVector(Vector V)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateVector:: Updating vector with (X="$V.X$", Y="$V.Y$", Z="$V.Z$").");
		ExampleReplicationInfo.VectorExample = V;
		ExampleReplicationInfo.ReplicatedEvent('VectorExample');
	}
}

/**
 * RPC to update the rotator
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateRotator(Rotator R)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateRotator:: Updating rotator with (Pitch="$R.Pitch$", Yaw="$R.Yaw$", Roll="$R.Roll$").");
		ExampleReplicationInfo.RotatorExample = R;
		ExampleReplicationInfo.ReplicatedEvent('RotatorExample');
	}
}

/**
 * RPC to update the color
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerUpdateColor(Color C)
{
	local RN_ExampleReplicationInfo ExampleReplicationInfo;

	ExampleReplicationInfo = GetExampleReplicationInfoInstance();

	if (ExampleReplicationInfo != None)
	{
		`Log(Self$":: ServerUpdateColor:: Updating color with (R="$C.R$", G="$C.G$", B="$C.B$", A="$C.A$").");
		ExampleReplicationInfo.ColorExample = C;
		ExampleReplicationInfo.ReplicatedEvent('ColorExample');
	}
}

/**
 * Allows the player controller update the int
 *
 * Network: Local
 */
exec function UpdateInt(int I)
{
	if (Role < Role_Authority)
	{
		ServerUpdateInt(I);
	}
}

/**
 * Allows the player controller update the byte
 *
 * Network: Local
 */
exec function UpdateByte(byte B)
{
	if (Role < Role_Authority)
	{
		ServerUpdateByte(B);
	}
}

/**
 * Allows the player controller update the float
 *
 * Network: Local
 */
exec function UpdateFloat(float F)
{
	if (Role < Role_Authority)
	{
		ServerUpdateFloat(F);
	}
}

/**
 * Allows the player controller update the string
 *
 * Network: Local
 */
exec function UpdateString(string S)
{
	if (Role < Role_Authority)
	{
		ServerUpdateString(S);
	}
}

/**
 * Allows the player controller update the vector
 *
 * Network: Local
 */
exec function UpdateVector(float X, float Y, float Z)
{
	local Vector V;

	if (Role < Role_Authority)
	{
		V.X = X;
		V.Y = Y;
		V.Z = Z;
		ServerUpdateVector(V);
	}
}

/**
 * Allows the player controller update the rotator
 *
 * Network: Local
 */
exec function UpdateRotator(int Pitch, int Yaw, int Roll)
{
	local Rotator R;

	if (Role < Role_Authority)
	{
		R.Pitch = Pitch;
		R.Yaw = Yaw;
		R.Roll = Roll;
		ServerUpdateRotator(R);
	}
}

/**
 * Allows the player controller update the color
 *
 * Network: Local
 */
exec function UpdateColor(int R, int G, int B, int A)
{
	local Color C;

	if (Role < Role_Authority)
	{
		C.R = R;
		C.G = G;
		C.B = B;
		C.A = A;
		ServerUpdateColor(C);
	}
}

defaultproperties
{
}