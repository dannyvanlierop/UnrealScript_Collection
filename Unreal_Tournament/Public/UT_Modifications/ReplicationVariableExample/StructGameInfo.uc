class StructGameInfo extends GameInfo;

var StructReplicationInfo StructReplicationInfo;
var const String Alphabet[26];

function PostBeginPlay()
{
	Super.PostBeginPlay();

	StructReplicationInfo = Spawn(class'StructReplicationInfo');

	if (StructReplicationInfo != None)
	{
		SetTimer(10.f, true, 'UpdateStructReplicationInfo');
	}
}

function UpdateStructReplicationInfo()
{
	local PlayerController PlayerController;
	local int i;
	local string Text;

	if (WorldInfo != None)
	{
		ForEach WorldInfo.AllControllers(class'PlayerController', PlayerController)
		{
			if (FRand() < 0.5f)
			{
				for (i = 0; i < 32; ++i)
				{
					Text $= Alphabet[Rand(26)];
				}

				StructReplicationInfo.TestCustomStruct.String = Text;
				StructReplicationInfo.TestCustomStruct.Float = RandRange(-32768.f, 32768.f);
				StructReplicationInfo.TestCustomStruct.Int = RandRange(32768, 32768);
				`Log(Self$":: Server updated StructReplicationInfo.TestCustomStruct to (String="$StructReplicationInfo.TestCustomStruct.String$", Float="$StructReplicationInfo.TestCustomStruct.Float$", Int="$StructReplicationInfo.TestCustomStruct.Int$")");
			}
			else
			{
				StructReplicationInfo.TestCustomStruct.String = Text;
				StructReplicationInfo.TestCustomStruct.Float = RandRange(-32768.f, 32768.f);
				StructReplicationInfo.TestCustomStruct.Int = 64;
				`Log(Self$":: Server updated StructReplicationInfo.TestCustomStruct to (String="$StructReplicationInfo.TestCustomStruct.String$", Float="$StructReplicationInfo.TestCustomStruct.Float$", Int="$StructReplicationInfo.TestCustomStruct.Int$")");
			}

			break;
		}
	}
}

defaultproperties
{
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