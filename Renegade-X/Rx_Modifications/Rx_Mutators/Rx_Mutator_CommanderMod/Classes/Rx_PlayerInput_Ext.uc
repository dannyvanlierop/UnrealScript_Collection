/*
** Rx_PlayerInput_Ext
*/

class Rx_PlayerInput_Ext extends Rx_PlayerInput config(Input);

//Simply adds 'O' as the button for transitioning the Objective box

function bool InputKey(int ControllerId, name Key, EInputEvent Event, float AmountDepressed = 1.f, bool bGamepad = FALSE)
{
	local Rx_Controller pc;
	local bool bMapVoting;

	pc = Rx_Controller(Player.Actor);
	if(WorldInfo.GRI != None && WorldInfo.GRI.bMatchIsOver) {
		bMapVoting = true;	
	}
	
	if(Rx_Vehicle(Player.Actor.pawn) != None 
			&& Rx_Vehicle(Player.Actor.pawn).IsReversedSteeringInverted() != bThreadedVehReverseSteeringInverted) {
		Rx_Vehicle(Player.Actor.pawn).SetReversedSteeringInverted(bThreadedVehReverseSteeringInverted);
	} 

    if ( event == ie_pressed ) {
        switch( key ) {
			case 'leftcontrol':
				/** one1: added */
				if (pc.IsVoteMenuEnabled())
					pc.DisableVoteMenu();
				else
					bCntrlPressed = true;
                break;
            case 'leftalt':
				/** one1: added */
				if (pc.IsVoteMenuEnabled())
					pc.DisableVoteMenu();
				else
					bAltPressed = true;
                break;
			case 'one':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(20);
				} else if (bAltPressed) {
					pc.RadioCommand(10);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(0);
				}
                break;
            case 'two':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(21);
				} else if (bAltPressed) {
					pc.RadioCommand(11);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(1);
				}
                break;
			case 'three':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(22);
				} else if (bAltPressed) {
					pc.RadioCommand(12);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(2);
				}
                break;
            case 'four':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(23);
				} else if (bAltPressed) {
					pc.RadioCommand(13);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(3);
				}
                break;
			case 'five':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(24);
				} else if (bAltPressed) {
					pc.RadioCommand(14);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(4);
				}
                break;
            case 'six':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(25);
				} else if (bAltPressed) {
					pc.RadioCommand(15);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(5);
				}
                break;
			case 'seven':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(26);
				} else if (bAltPressed) {
					pc.RadioCommand(16);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(6);
				}
                break;
            case 'eight':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(27);
				} else if (bAltPressed) {
					pc.RadioCommand(17);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(7);
				}
                break;
			case 'nine':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(28);
				} else if (bAltPressed) {
					pc.RadioCommand(18);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(8);
				}
                break;
            case 'zero':
				if (bCntrlPressed && bAltPressed) {
					pc.RadioCommand(29);
				} else if (bAltPressed) {
					pc.RadioCommand(19);
				} else if (bCntrlPressed || bMapVoting) {
					pc.RadioCommand(9);
				}
                break;
				/** one1: added */
			case 'V':
				if (bAltPressed || bCntrlPressed)
				{
					pc.EnableVoteMenu(false);
					return true;
				}
				else if(Rx_Vehicle(Player.Actor.pawn) != None)
				{
					Rx_Vehicle(Player.Actor.pawn).ToggleTurretRotation();
				}
                break;
            case 'N':
				if (bAltPressed || bCntrlPressed)
				{
					pc.EnableVoteMenu(true);
					return true;
				}
				break;
			//Add support for objective box transitioning
			case 'O':
				
				Rx_HUD_Ext(pc.myHud).OBox.UpdateStateFlag=true;
				
				break;
        }
	}
	else if ( event == ie_released ) {
        switch( key ) {
			case 'leftcontrol':
				bCntrlPressed = false;
                break;
            case 'leftalt':
				bAltPressed = false;
                break;
        }

	}
	return false;
}
