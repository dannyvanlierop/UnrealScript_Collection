/*
** Rx_CommandMenuChoice_QuickObjective
*/

class Rx_CommandMenuChoice_QuickObjective extends Rx_CommandMenuChoice;

/**var string MenuDisplayString;
var int LocalTeam, LocalCRank;
var Rx_CommanderController myCC;
var int Tier;


// server side
var int ToTeam; // -1 for both teams, 0 = GDI, 1 = NOD
//var float EndTime;
//var array<Rx_Controller> Yes, No;

//var string TopString;
//var Rx_Controller VoteInstigator;
var bool bPendingDelete;


*/ 
var string HarvesterObjectiveStr	;
var string MainBuildingObjectiveStr	;
var string SiloCaptureObjectiveStr 	;

//Defence Strings
var string DefendBuildingStr, BeaconDefenceObjectiveStr;
	
	
	
	//Elimination Objectives
var string	EliminateTechsStr, EliminateHotwiresStr,EliminateVehiclesStr,EliminateSnipersStr;
	


var int CurrentTier					;


function Init()
{
	
	local Rx_CommanderController TempCC;
	
	foreach myCC.AllActors(class'Rx_CommanderController', TempCC)

	{
		
		myCC=TempCC;
		break;
		


	}
	
	
	
}


function array<string> GetDisplayStrings()
{
	local array<string> ret;

	
switch (LocalTeam)	
{
	case 0: //GDI's Strings 
	
	if (CurrentTier == 0) //Attack Objectives
	{
		ret.AddItem("1. Attack the Hand of Nod" @ MainBuildingObjectiveStr);
		ret.AddItem("2. Attack the Airstrip" @ "" @ "" @ MainBuildingObjectiveStr);
		ret.AddItem("3. Attack the Refinery"@ "" @ "" @ MainBuildingObjectiveStr);
		ret.AddItem("4. Attack the Power Plant" @ MainBuildingObjectiveStr);
		ret.AddItem("5. Attack the Harvester" @ "" @ HarvesterObjectiveStr);
		ret.AddItem("6. Capture the Silo" @ "" @ " "@ "" @ SiloCaptureObjectiveStr);
		
	}
	
	if (CurrentTier == 1) //Defence Objectives
	{
		ret.AddItem("1. Defend the Barracks" @ DefendBuildingStr);
		ret.AddItem("2. Defend the Weapons Factory"@ "" @ "" @ DefendBuildingStr);
		ret.AddItem("3. Defend the Refinery"@ "" @ "" @ DefendBuildingStr);
		ret.AddItem("4. Defend the Power Plant" @ DefendBuildingStr);
		ret.AddItem("5. Defend the Harvester" @ " " @ DefendBuildingStr);
		ret.AddItem("6. Defend Ion Beacons" @ "" @ ""@ "" @ BeaconDefenceObjectiveStr);
		
	}
	
	if (CurrentTier == 2) //Elimination Objectives
	{
		ret.AddItem("1. Eliminate all Technicians"@ "" @ "" @ "" @ "" @ EliminateTechsStr);
		ret.AddItem("2. Destroy all remaining vehicles"@ EliminateVehiclesStr);
		ret.AddItem("3. Eliminate all remaining snipers" @ EliminateSnipersStr);
		//ret.AddItem("2: Co-Commander");
		//ret.AddItem("3: Support Commander");
	
	}
	break;
	
	case 1: //NOD's Strings 
	
	if (CurrentTier == 0) //Attack Objectives
	{
		ret.AddItem("1. Attack the Barracks" @ MainBuildingObjectiveStr);
		ret.AddItem("2. Attack the Weapons Factory"@ "" @ "" @ MainBuildingObjectiveStr);
		ret.AddItem("3. Attack the Refinery"@ "" @ "" @ MainBuildingObjectiveStr);
		ret.AddItem("4. Attack the Power Plant" @ MainBuildingObjectiveStr);
		ret.AddItem("5. Attack the Harvester" @ "" @ HarvesterObjectiveStr);
		ret.AddItem("6. Capture the Silo" @ "" @ "" @ "" @ SiloCaptureObjectiveStr);
		
	}
	
	if (CurrentTier == 1) //Defence Objectives
	{
		ret.AddItem("1. Defend the Hand of Nod" @ DefendBuildingStr);
		ret.AddItem("2. Defend the Airstrip"@ "" @ "" @ DefendBuildingStr);
		ret.AddItem("3. Defend the Refinery"@ "" @ "" @ DefendBuildingStr);
		ret.AddItem("4. Defend the Power Plant" @ DefendBuildingStr);
		ret.AddItem("5. Defend the Harvester" @ "" @ DefendBuildingStr);
		ret.AddItem("6. Defend Nuke Beacon" @ "" @ "" @ "" @ BeaconDefenceObjectiveStr);
		
	}
	
	if (CurrentTier == 2) //Elimination Obejectives
	{
		ret.AddItem("1. Eliminate all Hotwires"@ ""@ "" @ "" @ "" @ EliminateTechsStr);
		ret.AddItem("2. Destroy all remaining vehicles"@ EliminateVehiclesStr);
		ret.AddItem("3. Eliminate all remaining snipers" @ EliminateSnipersStr);
	}
	break;
	
}
	return ret;
}


function KeyPress(byte T)
{
	switch (LocalTeam)
	{
		case 0:
	if (CurrentTier == 0)
		{
		// accept 1-6
		if (T > 0 && T <= 6)
			{
			switch (T)
			{
				case 1:
				myCC.RecieveObjective(LocalTeam,0, "Attack the Hand of Nod", class'Rx_CObjective_Attack', 0); //Objective Actual list : 
				break;
				case 2:
				myCC.RecieveObjective(LocalTeam,0, "Attack the Airstrip", class'Rx_CObjective_Attack', 1); //Objective Actual list :
				break;
				case 3:
				//Send objective for attack Refinery
				myCC.RecieveObjective(LocalTeam,0, "Attack the Refinery", class'Rx_CObjective_Attack', 2);
				break;
				case 4:
				myCC.RecieveObjective(LocalTeam,0, "Attack the Power Plant", class'Rx_CObjective_Attack', 3);
				break;
				case 5:
				myCC.RecieveObjective(LocalTeam,0, "Destroy The Harvester", class'Rx_CObjective_Attack', 4);
				break;
				case 6:
				myCC.RecieveObjective(LocalTeam,0, "Capture the Silo", class'Rx_CObjective_Attack', 5);
				LogInternal("Unfinished Function");
				break;
				}
			}
		}
			if (CurrentTier == 1)
		{
		// accept 1-6
		if (T > 0 && T <= 6)
			{
			switch (T)
			{
				case 1:
				//Send objective for Defend BAR
				break;
				case 2:
				//Send objective for Defend WF
				break;
				case 3:
				//Send objective for Defend Refinery
				break;
				case 4:
				//Send objective for Defend PP
				break;
				case 5:
				//Send objective for Defend Harvester
				break;
				case 6:
				//Send objective defend beacons
				break;
				}
			}
			
		}
		
			if (CurrentTier == 2)
		{
		// accept 1-3
		if (T > 0 && T <= 3)
			{
			switch (T)
			{
				case 1:
				//Send objective for Eliminate Techs
				break;
				case 2:
				//Send objective for Eliminate Vehicles
				break;
				case 3:
				//Send Objective for Eliminate Snipers
				break;
				}
			}
			
		}
		
			case 1:  ////////////NOD//////////
	if (CurrentTier == 0)
		{
		// accept 1-6
		if (T > 0 && T <= 6)
			{
			switch (T)
			{
				case 1:
				//Send objective for attack Bar
				break;
				case 2:
				//Send objective for attack WF
				break;
				case 3:
				//Send objective for attack Refinery
				break;
				case 4:
				//Send objective for attack PP
				break;
				case 5:
				//Send objective for attack Harvester
				break;
				case 6:
				//Send objective for Capture Silo 
				break;
				}
			}
		}
			if (CurrentTier == 1)
		{
		// accept 1-6
		if (T > 0 && T <= 6)
			{
			switch (T)
			{
				case 1:
				//Send objective for Defend HON
				break;
				case 2:
				//Send objective for Defend Strip
				break;
				case 3:
				//Send objective for Defend Refinery
				break;
				case 4:
				//Send objective for Defend PP
				break;
				case 5:
				//Send objective for Defend Harvester
				break;
				case 6:
				//Send objective defend nuke beacons
				break;
				}
			}
			
		}
		
			if (CurrentTier == 2)
		{
		// accept 1-3
		if (T > 0 && T <= 3)
			{
			switch (T)
			{
				case 1:
				//Send objective for Eliminate Hotties
				break;
				case 2:
				//Send objective for Eliminate Vehicles
				break;
				case 3:
				//Send Objective for Eliminate Sniper
				break;
				}
			}
			
		}
			
	}
}
	



function bool GoBack()
{
	// return true to kill this submenu
	return true;
}

// call to execute vote
function Finish()
{
	//Handler.PlayerOwner.SendVote(self.Class, SerializeParam(), ToTeam);
	Handler.Terminate();
}

// input from console, custom parsing in each subclass
function InputFromConsole(string text)
{
}

static function string TeamTypeToString(int type)
{
	switch (type)
	{
	case -1:
		return "Global";
	case 0:
		return "GDI";
	case 1:
		return "Nod";
	}
	return "";
}





