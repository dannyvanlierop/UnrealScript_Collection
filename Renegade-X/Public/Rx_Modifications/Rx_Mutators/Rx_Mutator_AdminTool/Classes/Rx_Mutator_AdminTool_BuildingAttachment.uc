class Rx_Mutator_AdminTool_BuildingAttachment extends Rx_BuildingAttachment;

simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	
	SetTimer(2, false,'Init');
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	LogInternal("Rx_Mutator_AdminTool_BuildingAttachment FunctionCall: PostBeginPlay");

}

simulated function string GetHumanReadableName()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return OwnerBuilding.BuildingVisuals.GetHumanReadableName();
	}
	else return super.GetHumanReadableName();
}

simulated function float getBuildingHealthPct()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		if(OwnerBuilding.GetMaxArmor() <= 0) return float(OwnerBuilding.BuildingVisuals.GetHealth()) / float(OwnerBuilding.BuildingVisuals.GetMaxHealth());	
			
		if(OwnerBuilding.GetMaxArmor() > 0) return float(OwnerBuilding.BuildingVisuals.GetHealth()) / float(OwnerBuilding.BuildingVisuals.GetTrueMaxHealth()); //Used to visually display a full bar. 
	
	}
	else return -1;
}

simulated function float getBuildingHealthMaxPct()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
			if(OwnerBuilding.GetMaxArmor() <= 0) return float(OwnerBuilding.BuildingVisuals.GetMaxHealth() - OwnerBuilding.BuildingVisuals.GetMaxArmor()) / float(OwnerBuilding.BuildingVisuals.GetMaxHealth());	
			
			if(OwnerBuilding.GetMaxArmor() > 0) return 1.0f ; //Used to visually display a full bar. 
	}
	else return -1;
}

simulated function float getBuildingArmorPct()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return float(OwnerBuilding.BuildingVisuals.GetArmor()) / float(OwnerBuilding.BuildingVisuals.GetMaxArmor());
	}
	else return -1;
}


simulated function int getBuildingHealth()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return OwnerBuilding.BuildingVisuals.GetHealth();	
	}
	else return -1;
}

simulated function int getBuildingMaxHealth()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return OwnerBuilding.BuildingVisuals.GetMaxHealth();	
	}
	else return -1;
}

simulated function int getBuildingArmor()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return float(OwnerBuilding.BuildingVisuals.GetArmor()) / float(OwnerBuilding.BuildingVisuals.GetMaxArmor());
	}
	else return -1;
}

simulated function int getBuildingMaxArmor()
{
	if (OwnerBuilding != none && OwnerBuilding.BuildingVisuals != none)
	{
		return OwnerBuilding.BuildingVisuals.GetMaxArmor();
	}
	else return -1;
}

simulated function bool getBuildingHealthLocked(){

	local Rx_Building_Team_Internals myRx_Building_Team_Internals;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Building_Team_Internals',myRx_Building_Team_Internals) break;

	if (myRx_Building_Team_Internals != none)
	{
		return myRx_Building_Team_Internals.HealthLocked;
	}
	else return false;
}





















defaultproperties
{

}
