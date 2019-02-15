/*********************************************************
*
* File: Rx_PlayerInput.uc
* Author: RenegadeX-Team
* Pojekt: Renegade-X UDK <www.renegade-x.com>
*
*
*********************************************************
*  
*********************************************************/
class Rx_Mutator_AdminTool_PlayerInput extends Rx_PlayerInput
	config(Input)
	;


/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_PlayerInput FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
	SetTimer(0.2,false,'init');
}

simulated function PostBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_PlayerInput FunctionCall: PostBeginPlay");
	
	//Super.PostBeginPlay();


}

//function init(){
//
//	LogInternal("Rx_Mutator_AdminTool_PlayerInput FunctionCall: init");
//	
//}


/*
//Our Rx_Pawn
var Rx_Pawn rxp;
var float aBaseYTemp;
var() config bool bThreadedVehReverseSteeringInverted;
var() config bool bClickToGoOutOfADS;
var() config bool bActivateAuthentication;
var() config bool bNoGarbageCollectionOnOpeningPT;

var bool bCntrlPressed;
var bool bAltPressed;
*/


/** one1: added */
//var bool AirstrikeLock;

//var array<string> BannedCommands;

/** one1: added for airstrike support.
 *  capture mouse X and Y movements so we can adjust decal
 *  and airstrike orientation */

 /*
 function PostProcessInput(float DeltaTime)
{
	local Rx_Controller pc;

	super.PostProcessInput(DeltaTime);

	pc = Rx_Controller(Player.Actor);
	if (AirstrikeLock)
	{
		if (aMouseX != 0.f || aMouseY != 0.f)
		{
			//`log("aMouseX=" $ aMouseX $ " aMouseY=" $ aMouseY);
			pc.AdjustAirstrikeRotation(aMouseX, aMouseY);
		}
	}
}
*/

/**
 * Overloaded event PlayerInput.PlayerInput() to set Rx_Pawn movement direction variables before calling parent class's event.
 * 
 *  @param	DeltaTime   (description)
 *  @since              2011-10-13
 *  @author             triggerhippy
 */

 /*
 event PlayerInput( float DeltaTime )
{
	rxp = Rx_Pawn(Pawn);
	
	if (rxp != none) 
	{ 
		if (bWasLeft)
			rxp.setMoveDirection(MD_Left);
		else if (bWasRight)
			rxp.setMoveDirection(MD_Right);			
		else if (bWasBack)
			rxp.setMoveDirection(MD_Backward);
		else if(bWasForward)
			rxp.setMoveDirection(MD_Forward);

		if(self.aBaseX == 0 && self.aBaseY == 0)
			rxp.setMoveDirection(MD_Stationary);
	}
	aBaseYTemp = aBaseY;
	
	super.PlayerInput(DeltaTime);
}
*/

/*
function AdjustMouseSensitivity(float FOVScale)
{
	super.AdjustMouseSensitivity(FOVScale);
	if(Rx_Pawn(Player.Actor.pawn) != None 
		&& Rx_Weapon(Player.Actor.pawn.weapon) != None 
		&& Rx_Weapon(Player.Actor.pawn.weapon).IsIronsightActivated())
	{
		aMouseX			*= Rx_Weapon(Player.Actor.pawn.weapon).GetIronsightMouseSensitivityModifier();
		aMouseY			*= Rx_Weapon(Player.Actor.pawn.weapon).GetIronsightMouseSensitivityModifier();
	}
}
*/


function bool InputKey(int ControllerId, name Key, EInputEvent Event, float AmountDepressed = 1.f, bool bGamepad = FALSE)
{
	local Rx_Controller pc;
	local Rx_Mutator_AdminTool_Controller atpc;
	//local Rx_Mutator_AdminTool_Controller myRx_Mutator_AdminTool_Controller;
	local bool bMapVoting;

	pc = Rx_Controller(Player.Actor);
	atpc = Rx_Mutator_AdminTool_Controller(Player.Actor);
	if(WorldInfo.GRI != None && WorldInfo.GRI.bMatchIsOver) {
		bMapVoting = true;	
	}
	
	
	
	if(Rx_Vehicle(Player.Actor.pawn) != None 
			&& Rx_Vehicle(Player.Actor.pawn).IsReversedSteeringInverted() != bThreadedVehReverseSteeringInverted) {
		Rx_Vehicle(Player.Actor.pawn).SetReversedSteeringInverted(bThreadedVehReverseSteeringInverted);
	} 

	//foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myRx_Mutator_AdminTool_Controller)
	//break;
	
    if ( event == ie_pressed ) {
	
	//if(PC.bSuspect) 
		PC.AddToKeyString(string(Key)); 
	
	if( isBannedCommand(GetBind(key))) 
	{
	return true; 
	}
       
	   switch( key ) {												//When in the menu
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
            case 'left':
					atpc.KeyPressed("Left",true);
				break;
            case 'right':
					atpc.KeyPressed("Right",true);
                break;
            case 'up':
					atpc.KeyPressed("Up",true);
				break;
            case 'down':
					atpc.KeyPressed("Down",true);
                break;
            //case 'C':
			//		atpc.KeyPressed("C",true);
            //    break;
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
			case 'X':
				if ( atpc.iAccessByPlayersAdminToolMenu == 1 || PlayerReplicationInfo.bAdmin == true )
				{
					if (bAltPressed || bCntrlPressed)
					{
						atpc.EnableAdminToolMenu();	
						return true;
					}
				}
                break;

			/**Promotion Hard key
			case 'P':
				if (bCntrlPressed)
				{
					pc.EnableVeterancyMenu() ;
					return true;
				}
				break;*/
        }
	}
	else if ( event == ie_released )
	{
		if( isBannedCommand(GetBind(key))) 
	{
	return true; 
	
	}
		
        switch( key ) {								//When in the outside the menu
			case 'leftcontrol':
				bCntrlPressed = false;
                break;
            case 'leftalt':
				bAltPressed = false;
                break;
			case 'Left':
				atpc.KeyPressed("Left",false);
                break;
			case 'Right':
				atpc.KeyPressed("Right",false);
				break;
			case 'Up':
				atpc.KeyPressed("Up",false);
                break;
			case 'Down':
				atpc.KeyPressed("Down",false);
				break;
			//case 'C':
			//	atpc.KeyPressed("C",false);
			//	break;
        }

	}
	return false;
}

/*
exec function SetBind(const out name BindName, string Command)
{
	//Super call
	local KeyBind	NewBind;
	local int		BindIndex;
	
	if (isBannedCommand(Command)) 
	{
		`log("Unbindable command") ; 
		return; 
	}
	
	if ( Left(Command,1) == "\"" && Right(Command,1) == "\"" )
	{
		Command = Mid(Command, 1, Len(Command) - 2);
	}

	for(BindIndex = Bindings.Length-1;BindIndex >= 0;BindIndex--)
	{
		if(Bindings[BindIndex].Name == BindName)
		{
			Bindings[BindIndex].Command = Command;
			// `log("Binding '"@BindName@"' found, setting command '"@Command@"'");
			SaveConfig();
			return;
		}
	}

	// `log("Binding '"@BindName@"' NOT found, adding new binding with command '"@Command@"'");
	NewBind.Name = BindName;
	NewBind.Command = Command;
	Bindings[Bindings.Length] = NewBind;
	SaveConfig();
}
*/

/*
function bool isBannedCommand(coerce string CString)
{
	local int i; 
	for(i=0;i < BannedCommands.Length; i++)
	{
			if(inStr(Caps(CString), Caps(BannedCommands[i]) ) != -1) return true; 
			else
			continue; 
	}
	return false; 
}
*/

defaultproperties
{
/*
	BannedCommands(0) = "PrevViewMode" 
	BannedCommands(1) = "NextViewMode" 
	BannedCommands(2) = "viewmode " 
	BannedCommands(3) = "EnableCheats";
	//BannedCommands(4) = "pktlag";
	//BannedCommands(5) = "pktloss";
	__OnReceivedNativeInputKey__Delegate=Default__Rx_PlayerInput.InputKey
*/
}
