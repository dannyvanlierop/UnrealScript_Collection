/*
** Rx_BackWeaponAttachment_CommanderBinoculars
*/

/**********************************************************************
***********************************************************************
*Objectives For use on server (or stand alone client) only. They do not 
*replicate their information to clients, as then one would be allowed to
*view how many of a particular target was on the other team, and several
*other possible issues could arise as well. Instead, the Commander Controller
*Actor simply replicates WHAT objective is active for the team, but gives no 
*inclination as to how close to completion said objective is in most cases. 
*
*Written by Yosh56 aka xBrackishx aka ReclamationFox
*
***********************************************************************
***********************************************************************/

class Rx_CObjective extends Object
abstract; //These should only ever exist on the server

var int CycleMeElmo; // Used to increment time between when passive rewards are divied out (Unless these rewards are on a kill-by-kill basis)
var int ForTeam;
var Rx_TeamInfo myTI;
var byte ObjectiveActual;
var float LivingTime;
var Rx_CommanderController myCC; //Gets set by the CC when an objective is created
var bool bComplete, bInitFailed;


//Completion Awards
var float Complete_Credits,Complete_Points, Complete_CP	;

//"Passive" rewards
var float Passive_Credits, Passive_Points, Passive_CP		; 

//Individual Rewards
var float Individual_Credits, Individual_Points			;

var Rx_TeamInfo ObjTeam;

function Init()
{}

function InitFail()
{
	LogInternal("Objective failed to find targets and initialize"); 
	bInitFailed=true;
	
}

function bool Update()
{}

function DestroyThySelf()
{
	LogInternal("An Objective was completed or removed");
	//Destroy();
	
}

function ApplyPassiveRewards(float P, float C, float C_P)
{

local Rx_PRI PRI;

	myTI.AddRenScore(P); //Add passive score

	foreach myCC.AllActors(class'Rx_PRI', PRI)
	{
	if(PRI.Team.TeamIndex==ForTeam) PRI.AddCredits(C); //Divi out passive credits
	}
	
	//Add Passive CP

}

function GetTeam()
{
	local Rx_TeamInfo TI	;

foreach myCC.AllActors(class'Rx_TeamInfo', TI)

	{
		if(TI.TeamIndex == ForTeam) 

		{
		myTI=TI;
		break;
		}


	}
}


function CompleteObjective()
{
local Rx_PRI PRI;

myTI.AddRenScore(Complete_Points);

foreach myCC.AllActors(class'Rx_PRI', PRI)
{
if(PRI.Team.TeamIndex==ForTeam) PRI.AddCredits(Complete_Credits);
}
bComplete=true ; //Set objective to complete. GG no re.

myCC.SendObjectiveComplete(ForTeam);

//Add in CP reward


}

