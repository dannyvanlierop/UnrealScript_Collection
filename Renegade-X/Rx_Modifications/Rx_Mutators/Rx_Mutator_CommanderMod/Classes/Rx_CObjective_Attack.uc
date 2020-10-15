/*
** Rx_CObjective_Attack
*/

class Rx_CObjective_Attack extends Rx_CObjective;

var Rx_Building Target_Building;
var array<Rx_Building_TechBuilding>  Target_TechBuildings; //Separated since there can be more than one of these.
var Rx_Vehicle	Target_Vehicle; //99.9% of the time this is just to hold the Harvester
var byte KillFlag; //0 Destroy Building 1: Capture Building (Special case for tech buildings) 2: Harvester
var int CycleMeElmo; // Used to increment time between when rewards are divied out


function Init()
{
local int i;
local Rx_Building BLDG	;
local Rx_Building_TechBuilding TBLDG;
local Rx_Vehicle Vi;
local class<Rx_Vehicle>  RXV	;
local array < class<Rx_Building> > BLDGType; //Could be HON.. or HON with ramps... you get the idea. NO SUPPORT FOR MULTIPLE REAL BUILDINGS


if(ForTeam==0) // GDI
	{
	
	switch(ObjectiveActual) //What objectives am I going to be looking for ?
		{
		case 0:
		BLDGType.AddItem(class'Rx_Building_HandOfNod');
		BLDGType.AddItem(class'Rx_Building_HandOfNod_Ramps');
		break;
		
		case 1:
		BLDGType.AddItem(class'Rx_Building_AirTower');
		BLDGType.AddItem(class'Rx_Building_AirTower_Ramps');
		break;
		
		case 2:
		BLDGType.AddItem(class'Rx_Building_Refinery_Nod');
		BLDGType.AddItem(class'Rx_Building_Refinery_Nod_Ramps');
		break;
		
		case 3:
		BLDGType.AddItem(class'Rx_Building_PowerPlant_Nod');
		BLDGType.AddItem(class'Rx_Building_PowerPlant_Nod_Ramps');
		break;
		
		case 4:
		RXV=class'Rx_Vehicle_Harvester_Nod';
		break;
		
		case 5:
		BLDGType.AddItem(class'Rx_Building_Silo');
		break;
		
		}
		
		//Don't look for a building for the harvester objective
	if(ObjectiveActual <= 3) //Special cases for the Silo (And other tech buildings maybe) and harv. 
		foreach myCC.AllActors(class'Rx_Building', BLDG)
		{	
		
			for(i=0;i<BLDGType.Length;i++) //iterate through our possible choices
			{
			LogInternal("Building class is : " @ BLDG.class);
			if(BLDG.class==BLDGType[i]) 
				{
			LogInternal("Found Building");
			Target_Building=BLDG;
			break;
				}
			}
		}
	else
	if(ObjectiveActual == 4)
	{
	
	foreach myCC.AllActors(class'Rx_Vehicle', Vi)
		{	
	if(Vi.class == RXV) 
			{
			Target_Vehicle=Vi;
			break;
			}
		}
	}
	else
	if(ObjectiveActual == 5)
	{
	foreach myCC.AllActors(class'Rx_Building_TechBuilding', TBLDG)
		{	
		
			for(i=0;i<BLDGType.Length;i++) //iterate through our possible choices for silos
			{
			LogInternal("Building class is : " @ TBLDG.class);
			if(TBLDG.class==BLDGType[i]) 
				{
			LogInternal("Found a silo");
			if(Rx_Building_Silo(TBLDG) !=none && Rx_Building_Silo(TBLDG).ScriptGetTeamNum() != ForTeam)
			{
			Target_TechBuildings.AddItem(TBLDG);
			//Could be multiple silos, so we don't just break here.
			//break;	
			}
			else
			continue;
			
				}
			}
		}
	if(Target_TechBuildings.Length == 0) InitFail();
	}	
	}
	/******************************************************************
	****************NOD Initialization*********************************
	******************************************************************/
	
	if(ForTeam==1) // NOD
	{
	
	switch(ObjectiveActual) //What objectives am I going to be looking for ?
		{
		case 0:
		BLDGType.AddItem(class'Rx_Building_Barracks');
		BLDGType.AddItem(class'Rx_Building_Barracks_Ramps');
		break;
		
		case 1:
		BLDGType.AddItem(class'Rx_Building_WeaponsFactory');
		BLDGType.AddItem(class'Rx_Building_WeaponsFactory_Ramps');
		break;
		
		case 2:
		BLDGType.AddItem(class'Rx_Building_Refinery_GDI');
		BLDGType.AddItem(class'Rx_Building_Refinery_GDI_Ramps');
		break;
		
		case 3:
		BLDGType.AddItem(class'Rx_Building_PowerPlant_GDI');
		BLDGType.AddItem(class'Rx_Building_PowerPlant_GDI_Ramps');
		break;
		
		case 4:
		RXV=class'Rx_Vehicle_Harvester_GDI';
		break;
		
		case 5:
		BLDGType.AddItem(class'Rx_Building_Silo');
		break;
		
		}
		//Don't look for a building for the harvester objective
	if(ObjectiveActual <= 3) //Special cases for the Silo (And other tech buildings maybe) and harv. 
		foreach myCC.AllActors(class'Rx_Building', BLDG)
		{	
		
			for(i=0;i<BLDGType.Length;i++) //iterate through our possible choices
			{
			LogInternal("Building class is : " @ BLDG.class);
			if(BLDG.class==BLDGType[i]) 
				{
			LogInternal("Found Building");
			Target_Building=BLDG;
			break;
				}
			}
		}
	else
	if(ObjectiveActual == 4)
	{
	
	foreach myCC.AllActors(class'Rx_Vehicle', Vi)
		{	
	if(Vi.class == RXV) 
			{
			Target_Vehicle=Vi;
			break;
			}
		}
	}
	else
	if(ObjectiveActual == 5)
		{
	foreach myCC.AllActors(class'Rx_Building_TechBuilding', TBLDG)
			{	
		
			for(i=0;i<BLDGType.Length;i++) //iterate through our possible choices for silos
				{
			LogInternal("Building class is : " @ TBLDG.class);
			if(TBLDG.class==BLDGType[i]) 
					{
			LogInternal("Found a silo");
			if(Rx_Building_Silo(TBLDG) !=none && Rx_Building_Silo(TBLDG).ScriptGetTeamNum() != ForTeam)
			{
			Target_TechBuildings.AddItem(TBLDG);
			//Could be multiple silos, so we don't just break here.
			//break;	
			}
			else
			continue;
			
					}
				}
			}
	if(Target_TechBuildings.Length == 0) InitFail();
		}	

	}

}


function bool Update() //returns whether this objective is even relevant anymore. If false, it is 'destroyed'
{

local int P_mult, i;
local int BHealth;

if(bInitFailed) return false;

//Monitor building health to determine when rewards are applicable
if(Target_Building != none && KillFlag==0)
	{
	BHealth=Target_Building.GetHealth();
	if(BHealth <= Target_Building.HealthMax*0.9 ) CycleMeElmo++; //Controls Passive reward for killing Buildings
	
	if(BHealth<=0 && !bComplete) 
		{
		CompleteObjective();
		bComplete=true; //Building destroyed; this objective was completed
		}
	}
	
if(CycleMeElmo >= 10) 
{

if(BHealth <= Target_Building.HealthMax*0.90 && BHealth > Target_Building.HealthMax*0.75) P_Mult=1;

if(BHealth <= Target_Building.HealthMax*0.75 && BHealth > Target_Building.HealthMax*0.50) P_Mult=2;

if(BHealth <= Target_Building.HealthMax*0.50 && BHealth > Target_Building.HealthMax*0.25) P_Mult=3;

if(BHealth <= Target_Building.HealthMax*0.25 && BHealth > 0) P_Mult=4;

ApplyPassiveRewards(0,Passive_Credits*P_Mult, 0); //Buildings give passive credit rewards based on amount of damage increments

CycleMeElmo=0	;
	
}

/////END Building destroy variant//////

//////Start Harvester destruction variant///////////

	if(ObjectiveActual==4) {
	if(Target_Vehicle.Health<=0 || Rx_Vehicle_Harvester(Target_Vehicle)==none) //Harv dead 
		{
	//Special_Case for Harv rewards
	Complete_Credits=50;
	Complete_Points=100;
	Complete_CP=5;
	if(!bComplete) CompleteObjective();
	
		}
	}
	//////////////Tech building capture variant////////////////
	if(Target_TechBuildings.Length > 0) 
		{
			for(i=0;i<Target_TechBuildings.Length;i++)
			{
		if(Target_TechBuildings[i].ScriptGetTeamNum() == ForTeam) //If it belongs to this team now, it was completed. Only 1 silo is necessary to take to complete this objective.
				{
				Complete_Credits=0;
				Complete_Points=50;
				Complete_CP=5;
				if(!bComplete) CompleteObjective();
				bComplete=true; 	
				}
		
			}
		}
	
return true;

}
	


