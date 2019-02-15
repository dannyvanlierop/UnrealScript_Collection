// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Commands * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool_Commands extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool;

/********************************************************************************************/
// VARIABLES DECLERATION IS DONE IN CLASS Rx_Mutator_AdminTool_VoteMenuChoice_Ext_AdminTool
/********************************************************************************************/

/*****************************************************************************/
//  *  //  *  //  *  //  Displaying the VoteMenu  //  *  //  *  //  *  //  * //
/*****************************************************************************/
function array<string> GetDisplayStrings()
{
	////local Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
	local UTTeamInfo Team;
	local Rx_PRI PRI;
	
	local array<string> ret;
	local float credits;
	local int i;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_PRI', PRI)
	//foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller)
	//foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) //Get the AdminTool controller.
	{
		PRI = Rx_Game(`WorldInfoObject.Game).ParsePlayer(sNameHolder, sNameHolder);
		break;
	}

	if (CurrentTier == 0 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ ":");
			ret.AddItem(" ");
			ret.AddItem("Select option:");
			ret.AddItem(" ");
			ret.AddItem("1: Change Teams");
			ret.AddItem("2: CancelVote");
			//Fill up with empty lines
			for (i = 0; i < 5; i++)
			{
				ret.AddItem(" ");
			}
			ret.AddItem("9: Other");
			//Fill up with empty lines
			for (i = 0; i < 13; i++)
			{
				ret.AddItem(" ");
			}
		}
	}
	else if ( CurrentTier == 100 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ ":");
			ret.AddItem(" ");
			ret.AddItem("Select option:");
			ret.AddItem(" ");
			ret.AddItem("1: Team");
			ret.AddItem("2: Team2");
			ret.AddItem("3: SwapTeams");
			for (i = 0; i < 18; i++)
			{
				ret.AddItem(" ");
			}
		}
	}
	else if ( CurrentTier == 101 )		//Team
	{
		if (sNameHolder == "")
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Too few parameters.");
			return ret;
		}

		PRI = Rx_Game(`WorldInfoObject.Game).ParsePlayer(sNameHolder, sNameHolder);
		
		if (PRI == None)
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Player has no replicationinfo!");
			return ret;
		}
	
		if (Controller(PRI.Owner) == None)
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Player has no controller!");
			return ret;
		}
	
		// Hey, maybe there'll be more than 2 teams in the future. -shrugs-
		if (PRI.GetTeamNum() + 1 >= ArrayCount(Rx_Game(`WorldInfoObject.Game).Teams))
		{
			Team = Rx_Game(`WorldInfoObject.Game).Teams[0];
		}
		else
		{
			Team = Rx_Game(`WorldInfoObject.Game).Teams[PRI.GetTeamNum() + 1];
		}
	
		Rx_Game(`WorldInfoObject.Game).SetTeam(Controller(PRI.Owner), Team, true);
		if (Controller(PRI.Owner).Pawn != None)
		{
			Controller(PRI.Owner).Pawn.Destroy();
		}
		
		myAdminTool_Controller.ClientMessage("Succeed");
		
		CurrentTier=100;
		
		return ret;
	}
	else if ( CurrentTier == 102 )		//Team2
	{
		if (sNameHolder == "")
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Too few parameters.");
			return ret;
		}
		if (PRI == None)
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Player has no replicationinfo!");
			return ret;
		}
	
		if (Controller(PRI.Owner) == None)
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("Error: Player has no controller!");
			return ret;
		}
	
		// Hey, maybe there'll be more than 2 teams in the future. -shrugs-
		if (PRI.GetTeamNum() + 1 == ArrayCount(Rx_Game(`WorldInfoObject.Game).Teams))
		{
			Team = Rx_Game(`WorldInfoObject.Game).Teams[0];
		}
		else
		{
			Team = Rx_Game(`WorldInfoObject.Game).Teams[PRI.GetTeamNum() + 1];
		}
	
		credits = PRI.GetCredits();
		Rx_Game(`WorldInfoObject.Game).SetTeam(Controller(PRI.Owner), Team, true);
		
		if (Controller(PRI.Owner).Pawn != None)
		{
			Controller(PRI.Owner).Pawn.Destroy();
			PRI.SetCredits(credits);
		}
		
		myAdminTool_Controller.ClientMessage("Succeed");
		
		CurrentTier=100;
		
		return ret;
	}
	else if ( CurrentTier == 103 )		//SwapTeams
	{
		if (sNameHolder ~= "swap" )
		{
			Rx_Game(`WorldInfoObject.Game).SwapTeams();
		}
		else
		{
			CurrentTier=100;
			myAdminTool_Controller.ClientMessage("SwapTeams failed, input name needs to be 'swap'");

			return ret;
		}
		
		CurrentTier=100;
		myAdminTool_Controller.ClientMessage("Succeed");
				
		return ret;
	}
	else if ( CurrentTier == 200 )
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem("1: Cancelvote Global"); //Forces the current vote to cancel.
			ret.AddItem("2: Cancelvote GDI");
			ret.AddItem("3: Cancelvote Nod");			
		}	
	}
	else if ( CurrentTier == 900 )		//SpectateMode
	{
		if ( myAdminTool_Controller.iColumnNumber == 1 )
		{
			ret.AddItem(MenuDisplayString $ ":");
			ret.AddItem(" ");
			ret.AddItem("Select option:");
			ret.AddItem(" ");
			ret.AddItem("1: SpectateMode");
			ret.AddItem("2: NormalMode");
			for (i = 0; i < 20; i++)
			{
				ret.AddItem(" ");
			}
		}
	}
	else if ( CurrentTier == 901 )		//SpectateMode
	{
		myAdminTool_Controller.ClientMessage("Check 1");
		if (sNameHolder == "")
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Too few parameters.");
			return ret;
		}

		myAdminTool_Controller.ClientMessage("Check 2");
		PRI = Rx_Game(`WorldInfoObject.Game).ParsePlayer(sNameHolder, sNameHolder);
		
		myAdminTool_Controller.ClientMessage("Check 3");
		if (PRI == None)
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Player has no replicationinfo!");
			return ret;
		}
	
		myAdminTool_Controller.ClientMessage("Check 4");
		if (Controller(PRI.Owner) == None)
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Player has no controller!");
			return ret;
		}
	
		myAdminTool_Controller.ClientMessage("Check 5");
		if (Controller(PRI.Owner).Pawn != None)
		{
			Controller(PRI.Owner).Pawn.KilledBy(None);
			Controller(PRI.Owner).GoToState('Spectating');
		}
		
		myAdminTool_Controller.ClientMessage("Check 6");
		if (PRI.Team != None)
		{
			PRI.Team.RemoveFromTeam(Controller(PRI.Owner));
		}
	
		myAdminTool_Controller.ClientMessage("Check 7");
		if (Rx_Controller(PRI.Owner) != None)
		{
			Rx_Controller(PRI.Owner).BindVehicle(None);
		}
		
		myAdminTool_Controller.ClientMessage("Check 8");
		PRI.DestroyATMines();
		PRI.DestroyRemoteC4();
		
		myAdminTool_Controller.ClientMessage("Succeed");
		
		CurrentTier=900;
		
		return ret;
	}
	else if ( CurrentTier == 902 )		//NormalMode
	{
		if (sNameHolder == "")
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Too few parameters.");
			return ret;
		}

		PRI = Rx_Game(`WorldInfoObject.Game).ParsePlayer(sNameHolder, sNameHolder);
		
		if (PRI == None)
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Player has no replicationinfo!");
			return ret;
		}
	
		if (Controller(PRI.Owner) == None)
		{
			CurrentTier=900;
			myAdminTool_Controller.ClientMessage("Error: Player has no controller!");
			return ret;
		}
	
		if (Controller(PRI.Owner).Pawn != None)
		{
			Controller(PRI.Owner).Pawn.KilledBy(None);
		}
		
		Controller(PRI.Owner).Reset();
		
		if (Rx_Game(`WorldInfoObject.Game).Teams[1].Size >= Rx_Game(`WorldInfoObject.Game).Teams[0].Size)
		{
			Rx_Game(`WorldInfoObject.Game).Teams[0].AddToTeam(Controller(PRI.Owner));
		}
		else
		{
			Rx_Game(`WorldInfoObject.Game).Teams[1].AddToTeam(Controller(PRI.Owner));
			Controller(PRI.Owner).GotoState('Dead');
		}
		
		myAdminTool_Controller.ClientMessage("Succeed");
		
		CurrentTier=900;
		
		return ret;
	}
	return ret;
}

function KeyPress(byte T)
{

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (CurrentTier == 0)
	{
		if ( T >= 1 && T <= 2 )
		{
			CurrentTier= ( T * 100 );
		}
		else if ( T == 9 )//Others
		{
			CurrentTier= ( T * 100 );
			iKeyHolder=(T);
		}
		
	}
	else if (CurrentTier == 100)	//Status
	{
		myAdminTool_Controller.CTextMessage(sNameHolder,'Green',80);
			
		if ( T >= 1 && T <= 3 )
		{
			//Team	//Team2 //SwapTeams
			iKeyHolder=(T);
			Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayTextPlayerName);
		}
	}
	else if (CurrentTier == 200)
	{
		if ( T == 1 )
		{
			//CancelVote Global
			if (Rx_Game(`WorldInfoObject.Game).GlobalVote != None)
			{
				`LogRxObject("VOTE" `s "Cancelled;" `s "Global" `s Rx_Game(`WorldInfoObject.Game).GlobalVote.Class);
				Rx_Game(`WorldInfoObject.Game).DestroyVote(Rx_Game(`WorldInfoObject.Game).GlobalVote);
				return;
			}
			else
			{
				myAdminTool_Controller.ClientMessage("Error: No Global Vote in progress");
				return;
			}
		}
		else if ( T == 2 )
		{
			//CancelVote GDI
			if (Rx_Game(`WorldInfoObject.Game).GDIVote != None)
			{
				`LogRxObject("VOTE" `s "Cancelled;" `s "GDI" `s Rx_Game(`WorldInfoObject.Game).GDIVote.Class);
				Rx_Game(`WorldInfoObject.Game).DestroyVote(Rx_Game(`WorldInfoObject.Game).GDIVote);
				return;
			}
			else
			{
				myAdminTool_Controller.ClientMessage("Error: No GDI Vote in progress");
				return;
			}
		}
		else if ( T == 3 )
		{
			//CancelVote Nod
			if (Rx_Game(`WorldInfoObject.Game).NodVote != None)
			{
				`LogRxObject("VOTE" `s "Cancelled;" `s "Nod" `s Rx_Game(`WorldInfoObject.Game).NodVote.Class);
				Rx_Game(`WorldInfoObject.Game).DestroyVote(Rx_Game(`WorldInfoObject.Game).NodVote);
				return;
			}
			else
			{
				myAdminTool_Controller.ClientMessage("Error: No Nod Vote in progress");
				return;
			}
		}
	}
	else if (CurrentTier == 900)	//Status
	{
		myAdminTool_Controller.CTextMessage(sNameHolder,'Green',80);
			
		if ( T >= 1 && T <= 2 )
		{
			iKeyHolder=(T);
			Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayTextPlayerName);
		}
	}
}

function InputFromConsole(string text)
{
	local string str1;
	local int x;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break;
	
	if (text == "")
	{
		myAdminTool_Controller.CTextMessage( "wrong value",'Red',80);
		Handler.Terminate();
		return;
	}	
	
	//Remove prefix without : from string
	str1=Mid(text,(InStr(text, ":")));

	//Remove : from string
	str1=Repl(str1, ":", "");
	
	//Remove All leading spaces from string str1
	if ( Left(str1,1) == " " ) { for (x = 0; x > -1 &&  Left(str1,1) == " " ; x++) { if ( Left(str1,1) == " " ) { str1=Mid(str1,1); } } }
	
	//Remove All ending spaces from string str1
	if ( Right(str1,1) == " " ) { for (x = 0; Right(str1,1) == " "; x++) { if ( Right(str1,1) == " " ) { str1=Mid(str1,0,Len(str1)-1); } } }	
	
	//Find any spaces
	//str1=Repl(str1, " ", "");
	
	myAdminTool_Controller.ClientMessage("ConsoleInput:" $ str1);
	sNameHolder=(str1);
	
	myAdminTool_Controller.ClientMessage("CurrentTier:" $ CurrentTier);
	CurrentTier = ( CurrentTier + iKeyHolder );	
	myAdminTool_Controller.ClientMessage("CurrentTier:" $ CurrentTier);
}

function bool GoBack()
{
	switch (CurrentTier)
	{
		case 0:
			return true; // kill this submenu
		
		default:
			if (CurrentTier > 0)
			{
				CurrentTier = 0;
				return false;
			}
	}
}

function string SerializeParam()
{

}

function DeserializeParam(string param)
{

}

function string ComposeTopString()
{

}

function string ParametersLogString()
{

}

function Execute(Rx_Game game)
{

}

DefaultProperties
{
	MenuDisplayString = "Commands"
	//ConsoleDisplayText = "Text to display as prefix in console"
	
	
	ConsoleDisplayTextPlayerName="Select playername or unique part: ";
}