class Rx_Vehicle_SmarterHarvesterController extends Rx_Vehicle_HarvesterController;


simulated function PostBeginPlay()
{	
	local Rx_Vehicle_Harvester Harv;
	
	super.PostBeginPlay();
	
	foreach AllActors( class'Rx_Vehicle_Harvester', Harv ) {
		if(harv.controller == None && harv.LastAttackBroadCastTime == 0)
		{
			SetTeam(harv.TeamNum);
			Possess(harv.DummyDriver,true);
			harv_vehicle = harv;
			harv.LastAttackBroadCastTime = 1;
			break;
		}	
	}	
}

state ScriptedMove
{
	ignores SeePlayer, SeeMonster, HearNoise, NotifyHitWall;

	event PoppedState()
	{
		Super(ScriptedMove).PoppedState();
		if (Pawn != None)
		{
			StopMovement();
		}
	}

Begin:
	// while we have a valid pawn and move target, and
	// we haven't reached the target yet
	while (Pawn != None &&
		   ScriptedMoveTarget != None &&
		   !Pawn.ReachedDestination(ScriptedMoveTarget))
	{
		// check to see if it is directly reachable
		if (ActorReachable(ScriptedMoveTarget))
		{
			// then move directly to the actor
			MoveToward(ScriptedMoveTarget, ScriptedFocus);
		}
		else
		{
			// attempt to find a path to the target
			MoveTarget = FindPathToward(ScriptedMoveTarget, false);
			if (MoveTarget != None)
			{
				// move to the first node on the path
				MoveToward(MoveTarget, ScriptedFocus);
			}
			else
			{
				// abort the move
				`warn("Failed to find path to"@ScriptedMoveTarget);
				Sleep(3.0);
				GoTo('Begin');
				//ScriptedMoveTarget = None;
			}
		}
	}
	// return to the previous state
	PopState();
}

