// *****************************************************************************
//  * * * * * * * * * * * Rx_Mutator_AdminTool_VoteMenu0 * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_AdvancedVotes extends Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic;

/**************************************************************************************************************************************************************************************/
	//  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

replication
{

}

simulated event PreBeginPlay(){

	LogInternal("Rx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_AdvancedVotes FunctionCall: PreBeginPlay");
	
	//Super.PreBeginPlay();
	
}


reliable server function bool AdminCheck()
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	return myAdminToolController.PlayerReplicationInfo.bAdmin;
}

function array<string> GetDisplayStrings(){

	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	local array<string> ret;
	local int v,w,x,y,z;
	local int iPageTier;
	local int iPageTierAvailableRemainder;
	//local string str1;
	local int iStart;
	local int iStop;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	//Set iPageTier to current page number
	iPageTier=(CurrentTier + 1);

	//Check available items minus empty ones
	iItemsAvailable=myAdminToolController.ModeArrayLength;
	for (x = 0; x < iItemsAvailable ; x++)
	{
		if ( myAdminToolController.ModeDescriptionArray[x] == "Empty" )
		{
			iItemsAvailable--;
		}
	}

	//Check available pages, devided by max items for each page, if there is a remainder, add one page more
	iPageTierAvailable = (iItemsAvailable / iItemsListedPage);
	iPageTierAvailableRemainder = iItemsAvailable % iItemsListedPage;
	if (iPageTierAvailableRemainder > 0) { iPageTierAvailable++; }

	//modify this Tier, change it to 1 dynamic tier.
	v=(CurrentTier) * iItemsListedPage;
	w=(v)+iItemsListedPage; x=w;//Pass var test 
	//if ( CurrentTier != 0 ) { v++; } //Only show on the first page 21 items (AdminTool mode0 included)

	//Add keys to change pages
	if ( CurrentTier > 0 && myAdminToolController.bKeyLeftPressed) { GoOtherTier(true); }
	if ( iPageTierAvailable > iPageTier && myAdminToolController.bKeyRightPressed ) { GoOtherTier(); }
	//Skip if ( myAdminToolController.ModeAccessByPlayersArray[x] == 1 && myAdminToolController.ModeDescriptionArray[x] != "Empty" )

	
	//TODO later, make dynamic tiers
	//		0   1	2	3	4
	//	1	20	80	140	200	260
	//	2	20	80	140	200	260
	//	
	//	4	40	100 160 220	280
	//	5	40	100 160 220	280
	//	
	//	7	60	120 180 240	300
	//	8	60	120 180 240	300
	//		0	1	2	3	4
	//
	//	1 + (TierNummer * 60)= Start Collumn 1,2
	//	20 + (TierNummer * 60)= End Collumn 1,2
	//	
	//	21 + (TierNummer * 60)= Start Collumn 4,5
	//	40 + (TierNummer * 60)= End Collumn 4,5
	//	
	//	41 + (TierNummer * 60)= Start Collumn 1,2
	//	60 + (TierNummer * 60)= End Collumn 7,8


	
	if ( CurrentTier == 0 )
	{
		if (myAdminToolController.iColumnNumber == 1 || myAdminToolController.iColumnNumber == 2)
		{
			iStart= 1 + ( CurrentTier * 60 );
			iStop= 20 + ( CurrentTier * 60 );
		}
	
		if (myAdminToolController.iColumnNumber == 4 || myAdminToolController.iColumnNumber == 5)
		{
			iStart= 21 + ( CurrentTier * 60 );
			iStop= 40 + ( CurrentTier * 60 );
		}

		if (myAdminToolController.iColumnNumber == 7 || myAdminToolController.iColumnNumber == 8)
		{
			iStart= 41 + ( CurrentTier * 60 );
			iStop= 60 + ( CurrentTier * 60 );
		}
		if (myAdminToolController.iColumnNumber == 1)
		{
			ret.AddItem(MenuDisplayString $ ":");
			ret.AddItem(" ");
			ret.AddItem("# ModeName:");
			ret.AddItem(" ");
		}
		else if (myAdminToolController.iColumnNumber == 4)
		{
			//ret.AddItem("Page " $ iPageTier $ " of " $ iPageTierAvailable $ " ( Use arrowkey to change page )");	//iPageTierAvailable != 0
			ret.AddItem(" ");
			ret.AddItem("# ModeName:");
			ret.AddItem(" ");
		}
		else if (myAdminToolController.iColumnNumber == 7)
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("# ModeName:");
			ret.AddItem(" ");
		}
		else if (myAdminToolController.iColumnNumber == 2 || myAdminToolController.iColumnNumber == 5 || myAdminToolController.iColumnNumber == 8)
		{
			ret.AddItem(" ");
			ret.AddItem(" ");
			ret.AddItem("AccessLevel (Status)");
			ret.AddItem(" ");
		}
		else
		{	//Add some empty lines to all missed myAdminToolController.iColumnNumber
			for (x = 1; x <= 4 ; x++)
			{
				ret.AddItem(" ");
			}
		}
		
		y = 0;
		
		for ( x = iStart; x <= iStop; x++ )
		{
			if (myAdminToolController.iColumnNumber == 1 || myAdminToolController.iColumnNumber == 4 || myAdminToolController.iColumnNumber == 7 )
			{
				if ( x < iItemsAvailable )
				{
					if ( myAdminToolController.ModeAccessByPlayersArray[x] == 1 && myAdminToolController.ModeDescriptionArray[x] != "Empty"  )
					{
						ret.AddItem( x $ " : " $ myAdminToolController.ModeDescriptionArray[x] );
					}
					else if ( myAdminToolController.ModeAccessByPlayersArray[x] == 0 || myAdminToolController.ModeDescriptionArray[x] == "Empty" )
					{
						y++;
					}
				}
				
				if ( x >= iItemsAvailable )
				{
					y++;
					//ret.AddItem(" ");
				}
				
				if ( x == iStop)
				{
					for ( z = y ; z != 0  ; z-- )
					{
						ret.AddItem(" ");
					}
				}
			}
			else if (myAdminToolController.iColumnNumber == 2 || myAdminToolController.iColumnNumber == 5 || myAdminToolController.iColumnNumber == 8 )
			{
				y = 0;
				
				for ( x = iStart; x <= iStop ; x++ )	
				{
					if ( x < iItemsAvailable )
					{
						if ( myAdminToolController.ModeAccessByPlayersArray[x] == 1 && myAdminToolController.ModeDescriptionArray[x] != "Empty" )
						{
							//	if ( myAdminToolController.ModeStatusArray[x] ~= "true" ) { str1="(Enabled)";}
							//	else if ( myAdminToolController.ModeStatusArray[x] ~= "false" ) { str1="(Disabled)";}
							//		
							//	if ( myAdminToolController.ModeAccessLevelArray[x] <= 1 ) { ret.AddItem( " Nobody  " $ str1 ) ;}
							//	else if ( myAdminToolController.ModeAccessLevelArray[x] == 2 ) { ret.AddItem( " All Users " $ str1 ) ;}
							//	else if ( myAdminToolController.ModeAccessLevelArray[x] == 3 ) { ret.AddItem( " Administrators " $ str1 ) ;}
							//	else if ( myAdminToolController.ModeAccessLevelArray[x] == 4 ) { ret.AddItem( " Developers " $ str1 ) ;}
							//	else if ( myAdminToolController.ModeAccessLevelArray[x] == 5 ) { ret.AddItem( " Admin or Dev " $ str1 ) ;}
							
							if ( myAdminToolController.ModeStatusArray[x] ~= "true" ) { ret.AddItem(" (Enabled)");}
							else if ( myAdminToolController.ModeStatusArray[x] ~= "false" ) { ret.AddItem(" (Disabled)");}
						}
						else if ( myAdminToolController.ModeAccessByPlayersArray[x] == 0 || myAdminToolController.ModeDescriptionArray[x] == "Empty" )
						{
							y++;
						}
					}
				
					if ( x >= iItemsAvailable )
					{
						y++;
						//ret.AddItem(" ");
					}
					
					if ( x == iStop)
					{
						for ( z = y ; z != 0  ; z-- )
						{
							ret.AddItem(" ");
						}
					}					
				}
			}
			else
			{
				ret.AddItem(" ");
			}
		}
		
		ret.AddItem(" ");
	}
	else if ( CurrentTier == 100 )
	{
		if (myAdminToolController.iColumnNumber == 1)
		{	
			y=0;
			
			ret.AddItem("Mode options:");
			ret.AddItem(" ");
			
			//if ( !bool(myAdminToolController.ModeStatusArray[iModeName]) || myAdminToolController.ModeAccessLevelArray[iModeName] != 2 )
			if ( !bool(myAdminToolController.ModeStatusArray[iModeName]) )
			{
				ret.AddItem("1: Enable");
			}
			else if ( AdminCheck() )
			{
				ret.AddItem("1: Enable (Hidden for players)");
			}
			else
			{
				ret.AddItem(" ");
			}

			//if ( bool(myAdminToolController.ModeStatusArray[iModeName]) && myAdminToolController.ModeAccessLevelArray[iModeName] == 2 )
			if ( bool(myAdminToolController.ModeStatusArray[iModeName]) )
			{
				ret.AddItem("2: Disable");
			}
			else if ( AdminCheck() )
			{
				ret.AddItem("2: Disable (Hidden for players)");
			}
			else
			{
				ret.AddItem(" ");
			}
			
			if ( AdminCheck() )
			{
				ret.AddItem("3: Toggle (Hidden for players)");
			}
			else
			{
				ret.AddItem(" ");
			}
			
			y= y + 10;
			for ( z = y ; z != 0  ; z-- )
			{
				ret.AddItem(" ");
			}
		}
	}
	else if ( CurrentTier == 101 )
	{
		if (myAdminToolController.iColumnNumber == 1)
		{	
			y = 0;
			
			//if ( myAdminToolController.AdminToolAccessLevelAuthCheckLevel() == 3 )
			if ( AdminCheck() )
			{
				ret.AddItem("1: None");
			}
			else
			{
				y++;
			}
			
			ret.AddItem("2: All Users");
			
			//if ( myAdminToolController.AdminToolAccessLevelAuthCheckLevel() == 3 )
			if ( AdminCheck() )
			{
				ret.AddItem("3: Administrators");
			}
			else
			{
				y++;
			}
			
			//if ( myAdminToolController.AdminToolAccessLevelAuthCheckLevel() >= 3 )
			if ( AdminCheck() )
			{			
				ret.AddItem("4: Developers");
				ret.AddItem("5: Administrators and Developers");
			}
			else
			{
				y++;
				y++;
			}
			
			y= y + 10;
			for ( z = y ; z != 0  ; z-- )
			{
				ret.AddItem(" ");
			}
		}
	}
	
	
	//Add Footer
	if (myAdminToolController.iColumnNumber == 1)
	{	
		ret.AddItem("ALT/CTRL: Back");
	}
	else if (myAdminToolController.iColumnNumber == 8)
	{	
		ret.AddItem(GetFooterDetails());
	}
	else
	{	
		ret.AddItem(" ");
	}
	
	
	return ret;
}

function string GetFooterDetails()
{
	return "Page: " $ CurrentTier + 1 $ " of " $ iPageTierAvailable;
}

function bool CheckModeAccessByPlayers(int x){

	local Rx_Mutator_AdminTool_Controller myAdminToolController;
//		simulated function InitMyAdminToolController(optional bool bIsActor)
//		{
//			if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//			else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//		}
//		
//		simulated function InitAllAdminToolControllers(optional bool bIsActor)
//		{
//			//if (bIsActor) { foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			//else { foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break;

	//InitMyAdminToolController(false);
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	if ( myAdminToolController.ModeAccessByPlayersArray[x] == 1 )
	{
		return true;
	}
	return false;
}

function KeyPress(byte T)						//b
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
//		simulated function InitMyAdminToolController(optional bool bIsActor)
//		{
//			if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//			else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//		}
//		
//		simulated function InitAllAdminToolControllers(optional bool bIsActor)
//		{
//			//if (bIsActor) { foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			//else { foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break;

	//InitMyAdminToolController(false);
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	if ( CurrentTier == 0)
	{
		if ( T >=0 || T <= 9 )
		{
			Handler.PlayerOwner.ShowVoteMenuConsole("Select option: " $ T);
		}
	}
	if (CurrentTier == 100)
	{	
		if (T >= 1 && T <= 3)
		{
			if ( !bool(myAdminToolController.ModeStatusArray[iModeName]) && T == 1 )
			{
				iModeStatus = T;
				iModeAccessLevel = 2;
				
				if ( myAdminToolController.ModeAccessByPlayersArray[iModeName] == 0 && !AdminCheck() )
				{
					CurrentTier = 0;
				}
				else
				{
					Finish();
				}
			}		
			
			//When disabled set sefault back to admin
			else if ( bool(myAdminToolController.ModeStatusArray[iModeName]) && T == 2 )
			{
				iModeStatus = T;
				iModeAccessLevel = 3;
				
				if ( myAdminToolController.ModeAccessByPlayersArray[iModeName] == 0 && !AdminCheck() )
				{
					CurrentTier = 0;
				}
				else
				{
					Finish();
				}
			}
			else if ( AdminCheck() && T == 3 ) 
			{
				if ( bool(myAdminToolController.ModeStatusArray[iModeName]) )
				{
					iModeStatus = 1;
				}
				else
				{
					iModeStatus = 2;
				}
				
				CurrentTier = 101;
			}
		}
	}
	else if (CurrentTier == 101)	//Level
	{
		if (T >= 1 && T <= 5 && T != 0)
		{
			iModeAccessLevel = T;
			// enable console
			//Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayText);

				Finish();

		}
	}
}

function InputFromConsole(string text){			//a

	local Rx_Mutator_AdminTool_Controller myAdminToolController;
//		simulated function InitMyAdminToolController(optional bool bIsActor)
//		{
//			if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//			else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//		}
//		
//		simulated function InitAllAdminToolControllers(optional bool bIsActor)
//		{
//			//if (bIsActor) { foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			//else { foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break;

	//InitMyAdminToolController(false);
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	iModeName = int(Right(text, 2));

	if ( iModeName <= 0 || myAdminToolController.ModeAccessByPlayersArray[iModeName] == 0 || iModeName > myAdminToolController.ModeArrayLength )
	{
		myAdminToolController.CTextMessage( iModeName $" is a wrong value",'Red',80);
		Handler.Terminate();
		return;
	}
		
	CurrentTier = 100;

}

function bool GoBack()
{
	switch (CurrentTier)
	{
		case 0:
			return true; // kill this submenu
			
		default:
			if (CurrentTier > 1)
			{
				CurrentTier = 0;
				return false;
			}
	
			// enable console
			//Handler.PlayerOwner.ShowVoteMenuConsole(ConsoleDisplayText);
			
			CurrentTier = 0;
			return false;
	}
}

//What is serialization?
//Serialization is the process of making the object's state persistent. That means the state of the object is converted into a stream of bytes and stored in a file. 
//In the same way, we can use the deserialization to bring back the object's state from bytes. This is one of the important concepts in Java programming because serialization is mostly used in networking programming. 
//The objects that need to be transmitted hrough the network have to be converted into bytes. For that purpose, every class or interface must implement the Serializable interface. It is a marker interface without any methods.

function string SerializeParam()				//1	Client
{

	return string(iModeStatus) $ "\n" $ string(iModeName) $ "\n" $ string(iModeAccessLevel);
}

function DeserializeParam(string param)			//1
{
	local int i;

	i = InStr(param, "\n");
	iModeStatus = int(Left(param, i));
	
	param = Right(param, Len(param) - i - 1);
	i = InStr(param, "\n");
	iModeName = int(Left(param, i));
	
	param = Right(param, Len(param) - i - 1);
	iModeAccessLevel = int(param);
}

/** Server side functions. */

function ServerInit(Rx_Controller instigator, string param, int t)
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	local string params;
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	ToTeam = t;
	VoteInstigator = instigator;
	DeserializeParam(param);
	TopString = ComposeTopString();
	EndTime = instigator.WorldInfo.TimeSeconds + TimeLeft;
	
	// Log vote called.
	params = ParametersLogString();
	if (params != "")
		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Cal1led;" `s TeamTypeToString(t) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminToolController.ModeDescriptionArray[iModeName] `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) `s params);
	else
		Rx_Game(instigator.WorldInfo.Game).RxLog("VOTE"`s "Cal1led;" `s TeamTypeToString(t) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminToolController.ModeDescriptionArray[iModeName] `s "by" `s `PlayerLog(instigator.PlayerReplicationInfo) );

	// update on players
	UpdatePlayers(instigator.WorldInfo);
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

function ServerSecondTick(Rx_Game game)
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	local byte nt;
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
	
	nt = byte(EndTime - game.WorldInfo.TimeSeconds);
	if (nt < TimeLeft)
	{
		// update time
		TimeLeft = nt;

		UpdatePlayers(game.WorldInfo);

		if (nt == 0)
		{
			// todo: finish vote
			if (CanExecute(game))
			{
				//game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s class `s "pass" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
				game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminToolController.ModeDescriptionArray[iModeName] `s "pass" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
				Execute(game);
			}
			else
				//game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s class `s "fail" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
				game.RxLog("VOTE" `s "Results;" `s TeamTypeToString(ToTeam) `s sModeStatus $ " - Mode" $ iModeName $ " - " $ myAdminToolController.ModeDescriptionArray[iModeName] `s "fail" `s "Yes="$PlayerCount(Yes) `s "No="$PlayerCount(No) );
				
			game.DestroyVote(self);
		}
	}
}

//Rx: VOTEResults;GlobalRx_Mutator_AdminTool_VoteMenuChoice_Ext_Basic_AdvancedVotespassYes=1No=0
//str = "Status" `s sModeStatus `s "Mode" `s iModeName `s "AccessLevel" `s iModeAccessLevel;
//		str = super.ComposeTopString() $ " wants to " $ sModeStatus $ " " $ sModeName;

function Finish()
{
	LogInternal("Sending vote with Class:"@self.Class @"Serialized Parameter: "@SerializeParam() @ "To Team: " @ToTeam);
	Handler.PlayerOwner.SendVote(self.Class, SerializeParam(), ToTeam);
	Handler.Terminate();
}


function string ComposeTopString()				//2
{
	local Rx_Mutator_AdminTool_Controller myAdminToolController;
	local string str;
	//local string sModeStatus;
	local string sModeName;
//	local string sAccessLevel;

	
//		simulated function InitMyAdminToolController(optional bool bIsActor)
//		{
//			if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//			else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break; }
//		}
//		
//		simulated function InitAllAdminToolControllers(optional bool bIsActor)
//		{
//			//if (bIsActor) { foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			//else { foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break; }
//			foreach class'WorldInfo'.static.GetWorldInfo().AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers) break;

	//InitMyAdminToolController(false);
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminToolController) break;
		
	switch (iModeStatus)
	{
	case 1:
		sModeStatus = "enable";
		break;
	case 2:
		sModeStatus = "disable";
		break;
	case 3:
		sModeStatus = "toggle";
		break;
	//case 3:
	//	sModeStatus = "toggle";
	//	break;
	}

	sModeName=myAdminToolController.ModeDescriptionArray[iModeName];


	//		switch (iModeAccessLevel)
	//		{
	//		case 0:
	//			sAccessLevel = "NULL"; //1
	//			break;
	//		case 1:
	//			sAccessLevel = "None"; //1
	//			break;
	//		case 2:
	//			sAccessLevel = "All Users"; //2
	//			break;
	//		case 3:
	//			sAccessLevel = "Administrators"; //3
	//			break;
	//		case 4:
	//			sAccessLevel = "Developers"; //4
	//			break;
	//		case 5:
	//			sAccessLevel = "Administrators and Developers"; //5
	//			break;
	//		}

	
	//sModeStatus
	//str = super.ComposeTopString() $ " wants to " $ sModeStatus $ " " $ sModeName;
	
	//if ( iModeStatus == 1 || iModeStatus == 3 )
	//{
	//	str = super.ComposeTopString() $ " wants to " $ sModeStatus $ " " $ sModeName $ " for " $ sAccessLevel $ " ";
	//}
    //
	//if ( iModeStatus == 2)
	//{
	//	str = super.ComposeTopString() $ " wants to " $ sModeStatus $ " " $ sModeName;
	//}	
	
	str = super.ComposeTopString() $ " wants to " $ sModeStatus $ " " $ sModeName;
	
	//str = super.ComposeTopString() $ " wants to enable " $ sModeName $ " for " $ sAccessLevel $ " ";
	return str;
}

function string ParametersLogString()			//3
{

	local string str;
	
	switch (iModeStatus)
	{
	case 1:
		sModeStatus = "Enable status";
		break;
	case 2:
		sModeStatus = "Disable status";
		break;
	case 3:
		sModeStatus = "Toggle status";
		break;
	}
	
	if ( iModeStatus == 1 || iModeStatus == 3 )
	{
		str = "Status" `s sModeStatus `s "Mode" `s iModeName `s "AccessLevel" `s iModeAccessLevel;
	}
	else if ( iModeStatus == 2)
	{
		str = "Status" `s sModeStatus `s "Mode" `s iModeName;
	}
	
	
	return str;
}

function Execute(Rx_Game game)					//4
{

	local string sModeName;
	local string sAccessLevel;
	

	
	switch (iModeStatus)
	{
	case 1:
		sModeStatus = "true";
		break;
	case 2:
		sModeStatus = "false";
		break;
	case 3:
		sModeStatus = "";
		break;
	}
	
	//iModeName=iModeName+9;
	sModeName="mode" $ iModeName; //eliable server function AdminToolServer (string sToggleName, optional string sStatus, optional string iAccessLevel
	sAccessLevel=string(iModeAccessLevel);
	
	////	foreach WorldInfo.AllControllers(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers)
	foreach game.AllActors(class'Rx_Mutator_AdminTool_Controller', allAdminTool_Controllers)
	break;

	if ( int(Mid(allAdminTool_Controllers.ModeAutoSetProcedureArray[iModeName],1,1)) == 1 )
	{
		//allAdminTool_Controllers.ServerAdminToolStatus(sModeName, sModeStatus, true, true);
		allAdminTool_Controllers.AdminToolServer(sModeName,"SetStatus",sModeStatus, true);
		//allAdminTool_Controllers.LogInternal(sModeName $ " SetStatus " $ sModeStatus);
	}
	
	//Set all back to admin as default
	if ( int(Mid(allAdminTool_Controllers.ModeAutoSetProcedureArray[iModeName],0,1)) == 1 )
	{
		if ( allAdminTool_Controllers.ModeSchedulerTimerValueArray[iModeName] != 0 || iModeStatus == 2 )
		{
			//allAdminTool_Controllers.ServerAdminToolSetTimer(sModeName,0,true,true);
			allAdminTool_Controllers.AdminToolServer(sModeName,"SetTimer","0", true);
			//allAdminTool_Controllers.LogInternal(sModeName $ " SetTimer 0");
		}
		else
		{
			//allAdminTool_Controllers.ServerAdminToolSetTimer(sModeName,allAdminTool_Controllers.ModeAutoSetTimerArray[iModeName],true,true);
			allAdminTool_Controllers.AdminToolServer(sModeName,"SetTimer",string(allAdminTool_Controllers.ModeAutoSetTimerArray[iModeName]), true);
			//allAdminTool_Controllers.LogInternal(sModeName $ " SetTimer " $ string(allAdminTool_Controllers.ModeAutoSetTimerArray[iModeName]));
		}
	}

	if ( int(Mid(allAdminTool_Controllers.ModeAutoSetProcedureArray[iModeName],2,1)) == 1 )
	{
		//allAdminTool_Controllers.ServerAdminToolAccessLevel(sModeName, sAccessLevel, true, true);
		allAdminTool_Controllers.AdminToolServer(sModeName,"SetAccessLevel",sAccessLevel, true);
		//allAdminTool_Controllers.LogInternal(sModeName $ " SetAccessLevel " $ sAccessLevel);
	}
	
	allAdminTool_Controllers.AdmintTaskSetServer(iModeName, iModeStatus);
}

/*****************************************************************************/
//  *  //  *  //  *  //  *  //  Other  //  *  //  *  //  *  //  *  //  *   //  
/*****************************************************************************/

DefaultProperties
{
	MenuDisplayString = "Extended votes"
	//ConsoleDisplayText = "Text to display as prefix in console"
	iItemsListedPage=60;
}