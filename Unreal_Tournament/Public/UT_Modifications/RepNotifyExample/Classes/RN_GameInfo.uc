class RN_GameInfo extends GameInfo;

var RN_ExampleReplicationInfo ExampleReplicationInfo;
var const String Alphabet[26];

/**
 * PostBeginPlay is executed after the GameInfo is created on the server
 *
 * Network: Dedicated/Listen Server
 */
function PostBeginPlay()
{
	Super.PostBeginPlay();

	// Create the example replication info
	ExampleReplicationInfo = Spawn(class'RN_ExampleReplicationInfo');

	// Start the timer so that fresh data is sent to clients
	if (ExampleReplicationInfo != None)
	{
		SetTimer(10.f, true, 'UpdateExampleReplicationInfo');
	}
}

/**
 * Updates the example replication info and sends the new data to the client
 *
 * Network: Dedicated/Listen Server
 */
function UpdateExampleReplicationInfo()
{
	local int Index, i;
	local String Text;
	local Vector V;
	local Rotator R;
	local Color C;
	local Controller Controller;

	if (ExampleReplicationInfo == None || WorldInfo == None)
	{
		return;
	}

	// Ensure that we have players connected
	ForEach WorldInfo.AllControllers(class'Controller', Controller)
	{
		Index = int(RandRange(0.f, 7.f));

		switch (Index)
		{
		case 0: // int		
			ExampleReplicationInfo.IntExample = int(RandRange(-32768, 32768));
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating int with "$ExampleReplicationInfo.IntExample$".");
			break;

		case 1: // byte 
			ExampleReplicationInfo.ByteExample = byte(RandRange(0, 255));
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating byte with "$ExampleReplicationInfo.ByteExample$".");
			break;

		case 2: // float
			ExampleReplicationInfo.FloatExample = RandRange(-1234.5678, 1234.5678);
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating float with "$ExampleReplicationInfo.FloatExample$".");
			break;

		case 3: // string
			for (i = 0; i < 32; ++i)
			{
				Text $= Alphabet[Rand(26)];
			}
			ExampleReplicationInfo.StringExample = Text;
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating string with "$ExampleReplicationInfo.StringExample$".");
			break;

		case 4: // vector
			V.X = RandRange(-1234.5678, 1234.5678);
			V.Y = RandRange(-1234.5678, 1234.5678);
			V.Z = RandRange(-1234.5678, 1234.5678);
			ExampleReplicationInfo.VectorExample = V;
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating vector with (X="$V.X$", Y="$V.Y$", Z="$V.Z$")");
			break;

		case 5: // rotator
			R.Pitch = Rand(65535);
			R.Yaw = Rand(65535);
			R.Roll = Rand(65535);
			ExampleReplicationInfo.RotatorExample = R;
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating rotator with (Pitch="$R.Pitch$", Yaw="$R.Yaw$", Roll="$R.Roll$")");
			break;

		case 6: // color
			C.R = Rand(255);
			C.G = Rand(255);
			C.B = Rand(255);
			C.A = Rand(255);
			ExampleReplicationInfo.ColorExample = C;
			`Log(Self$":: UpdateExampleReplicationInfo():: Updating color with (R="$C.R$", G="$C.G$", B="$C.B$", A="$C.A$")");
			break;
		}

		break;
	}
}

defaultproperties
{
	PlayerControllerClass=class'RN_PlayerController'
	Alphabet(0)="A"
	Alphabet(1)="B"
	Alphabet(2)="C"
	Alphabet(3)="D"
	Alphabet(4)="E"
	Alphabet(5)="F"
	Alphabet(6)="G"
	Alphabet(7)="H"
	Alphabet(8)="I"
	Alphabet(9)="J"
	Alphabet(10)="K"
	Alphabet(11)="L"
	Alphabet(12)="M"
	Alphabet(13)="N"
	Alphabet(14)="O"
	Alphabet(15)="P"
	Alphabet(16)="Q"
	Alphabet(17)="R"
	Alphabet(18)="S"
	Alphabet(19)="T"
	Alphabet(20)="U"
	Alphabet(21)="V"
	Alphabet(22)="W"
	Alphabet(23)="X"
	Alphabet(24)="Y"
	Alphabet(25)="Z"
}