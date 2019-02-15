/*
** Rx_PUGController
*/

class Rx_PUGController extends UTMutator
	config(PUGController);
	
var config bool SwapOnStartup, bRandomSides;

var int Team0_Team, Team1_Team;	
	
var config array<string> S_Team_0 ;
var config array<string> S_Team_1;

var config string Commander0;
var config string Commander1; 
var Rx_CommanderController myCC;
//Used for team swapping
//var array<int> Temp_S_Team_0 ;
//var array<int> Temp_S_Team_1;

//By default, team 0 is GDI and Team 1 is Nod

/** Obligatory Stuff so that the PUG Controller can run without the C-Mod's main components*/
function bool CheckReplacement(Actor Other)
{
	if(Other.IsA('Rx_Rcon_Commands_Container') && Other.class !=class'Rx_Rcon_Commands_Container_CM')
	{
	if (Rx_Game(WorldInfo.Game) != None && Rx_Rcon_Commands_Container_CM(Rx_Game(WorldInfo.Game).RconCommands) == none )
		{
			LogInternal("Attempted to setup RCon Container") ;
		Rx_Game(WorldInfo.Game).RconCommands.Destroy();
		SetTimer(0.2,false,'NewRcon');
		
		
		
		}
	}
	
	
	
	return true;

	}

reliable server function NewRcon()
{
	
	Rx_Game(WorldInfo.Game).RconCommands = Spawn(class'Rx_Rcon_Commands_Container_CM');
	Rx_Game(WorldInfo.Game).RconCommands.InitRconCommands();
	LogInternal(Rx_Rcon_Commands_Container_CM(Rx_Game(WorldInfo.Game).RconCommands));
}	


event PostBeginPlay()
{
local int TeamSeed;
super.PostBeginPlay();
if(SwapOnStartup) 
	{
	LogInternal("Teams Will Be Swapped in 10 seconds");
	SetTimer(20.0, false, 'SwapTeams');
	
	}
	
	if(bRandomSides) 
	{
	LogInternal("Sides chosen at random");
	TeamSeed=rand(10); 
	if(TeamSeed > 4) SwapTeams(false);
	
	}
}
function LockTeams() //Take whatever teams are now and save them to the configuration file. 
{

local int i, MaxP, TempID;
local string TempName ;
local Rx_PRI PRI;
MaxP=Rx_Game(Worldinfo.Game).MaxPlayers;

S_Team_1.Length=0;
S_Team_0.Length=0;


foreach AllActors(class'Rx_PRI', PRI)
{
	if(PRI.bBot) continue;
	
	if(PRI.Team.TeamIndex == 0) 
	{
		TempName=PRI.PlayerName;
		S_Team_0.AddItem(TempName);
	}
	else
	{
	TempName=PRI.PlayerName;
	S_Team_1.AddItem(TempName);
	}
	
	
}
SaveConfig();

}

function bool isOnTeamZero(Rx_PRI PPRI)
{
	local Rx_PRI myPRI;
	local int i;
	
	for(i=0; i<S_Team_0.Length; i++)
	{
		if(PPRI.PlayerName == S_Team_0[i]) return true;
		
	}
	return false;
}

function bool isOnTeamOne(Rx_PRI PPRI)
{
	local Rx_PRI myPRI;
	local int i;
	
	
	for(i=0; i<S_Team_1.Length; i++)
	{
		if(PPRI.PlayerName == S_Team_1[i]) return true;
		
	}
	return false;
}

function ForceTeams()
{
	local Rx_PRI PRI;
	local int i;
	
	//If CC isn't set, then find it and set it.
	if(myCC == none) GetCC(); 
	
	for(i=0;i<S_Team_0.Length;i++)//ReCreate Team 0
	{
		if(S_Team_0[i] != "") 
			
		{
		foreach AllActors(class'Rx_PRI',PRI)
			{
			if(!isOnTeamZero(PRI)) continue;
			
			if(PRI != none && PRI.Team.TeamIndex != Team0_Team)
				{
				ChangePlayerTeam(Team0_Team,PRI);
				if(PRI.PlayerName == Commander0 && GetCC() ) myCC.SetCommander(Rx_Controller(PRI.Owner), Team0_Team, 0);
				}
			}	
		}		
	}
	
	for(i=0;i<S_Team_1.Length;i++)//ReCreate Team 1
	{
		if(S_Team_1[i] != "") 
			
		{
		foreach AllActors(class'Rx_PRI',PRI)
			{
				if(!isOnTeamOne(PRI)) continue;
			if(PRI != none && PRI.Team.TeamIndex != Team1_Team) ChangePlayerTeam(Team1_Team,PRI);
			if(PRI.PlayerName == Commander1 && GetCC() ) myCC.SetCommander(Rx_Controller(PRI.Owner), Team1_Team, 0);
			}
		}	
	}	
}

function ChangePlayerTeam(int TN, Rx_PRI PRI)
{
	local int credits;
	credits = PRI.GetCredits();
	Rx_Game(WorldInfo.Game).SetTeam(Controller(PRI.Owner), Rx_Game(WorldInfo.Game).Teams[TN], true);
	if (Controller(PRI.Owner).Pawn != None)
		Controller(PRI.Owner).Pawn.Destroy();
	PRI.SetCredits(credits);	
}


function SwapTeams(optional bool AutoForce = true)
{
	
	local string TempC0, TempC1;
	
	TempC0=Commander0;
	TempC1=Commander1;
	
	if(Team0_Team == 0) Team0_Team=1;
	else
	Team0_Team=0;
	
	if(Team1_Team == 0) Team1_Team=1;
	else
	Team1_Team=0;

Commander0 = TempC1;
Commander1 = TempC0;

//Force Update teams after swapping 
if(AutoForce) ForceTeams();


	/**)for(i=0;i<S_Team_0.Length;i++)  //God this is ugly, but save the teams that you know now, then remake them on the other team to swap them out. 
	{
		Temp_S_Team_0[i].AddItem(S_Team_0[i]);
	}
	
	for(i=0;i<S_Team_1.Length;i++) 
	{
		Temp_S_Team_1[i].AddItem(S_Team_1[i]);
	}
*/
	
}

function bool GetCC() 
{
	local Rx_CommanderController CCI;
	foreach AllActors(class'Rx_CommanderController', CCI) //Get the Command controller.
	{
		myCC = CCI ;
		return true;
		//break;
	}
	return false;
}


