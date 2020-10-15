/*
** Rx_CommanderMod
*/

class Rx_CommanderMod extends UTMutator ;

var Rx_CommanderController CommandSystem ;



var int i;



function InitMutator(string Options, out string ErrorMessage)
{
	super.InitMutator(Options, ErrorMessage);
	
	
	
	if (Rx_Game(WorldInfo.Game) != None)
	{
	CommandSystem = Rx_Game(WorldInfo.Game).spawn(class'Rx_CommanderController')	;
	CommandSystem.ORI = Rx_Game(WorldInfo.Game).spawn(class'Rx_ORI');
	LogInternal("Spawned Command System");
		//Change out the Default HUD
	Rx_Game(WorldInfo.Game).HudClass = class'Rx_HUD_Ext' ;
	
	}
}

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
	
/**event PreBeginPlay ()

{
//local Rx_VoteMenuHandler RxV;

super.PreBeginPlay();


	
	RxV=Rx_VoteMenuHandler(GetDefaultObject(class'Rx_VoteMenuHandler'));
	RxV.VoteChoiceClasses[6] = class'RenX_CommanderMod.Rx_VoteMenuChoice_Commander' ;
	



}

function bool CheckReplacement(Actor Other)
{
	local Rx_Controller RxC ;

	
	if(Other.IsA('Rx_Controller')) 
	{
		RxC=Rx_Controller(Other);
		
		if( Rx_PlayerInput_Ext(RxC.PlayerInput) == none){
	RxC.InputClass=class'RenX_CommanderMod.Rx_PlayerInput_Ext';	
	RxC.PlayerInput=none; //erase the player input
	RxC.PlayerInput=new(RxC) RxC.InputClass; //create a new player input
	RxC.PlayerInput.InitInputSystem();
		}
	}
	
	
	
	return true;
}

*/

//Handy function for finding the default class object, written by RypeL(In this community anyway). Seriously it's 1 line, yet more useful than some entire mutators
final static function object GetDefaultObject(class ObjClass)
{
	return FindObject(ObjClass.GetPackageName()$".Default__"$ObjClass, ObjClass);
}

/******************************************************************************* 

**********************************************************************************/
