// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_AdminTool_Controller * * * * * * * * * * * *
// Written by Ukill, Supported by ...........................................
// *****************************************************************************
class Rx_Mutator_AdminTool_HUD extends Rx_HUD;

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  VARIABLES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

														/* AdminToolSummary */
//var bool bToggleAdminToolSummary;						//
//var Rx_GFxAdminToolSummary AdminToolSummaryMovie;		//GFx movie used for AdminToolSummary
                                                        

/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  REPLICATION  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

//		simulated function PostBeginPlay(){
//		
//			LogInternal("FunctionCall: PostBeginPlay");
//			
//			Super.PostBeginPlay();
//			
//			SetTimer( 0.2, false, 'init');
//		}


/**************************************************************************************************************************************************************************************/
   //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //      HUD      //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/

function DisplayRadioCommands()
{
	local int Idx, XPos, YPos;
	local float XL, YL;
	local array<String> AvailableRadioCommands;
	local Rx_Mutator_AdminTool_Controller myAdminTool_Controller;
	local Rx_Mutator_AdminTool_Controller AdminTool_Controller;
	local Rx_Controller pc;
	local string s;
	local bool bDrawingMapVotes;
	//local int iAccessLevel;
	
	myAdminTool_Controller = Rx_Mutator_AdminTool_Controller(PlayerOwner);
	pc = Rx_Controller(PlayerOwner);
	
	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', AdminTool_Controller) 	break;
	//iAccessLevel = AdminTool_Controller.AdminToolAccessLevelAuthCheckLevel();

	AdminTool_Controller.ScreenSizeX = Canvas.SizeX;
	
	bDrawingMapVotes = false;
	if(UTGRI != None && UTGRI.bMatchIsOver) {
		//TODO: Draw cleanup
// 		bDrawingMapVotes = true;
// 		RxGRI = Rx_GRI(UTGRI);
// 		for (i=0; i<RxGRI.MapVotesSize && RxGRI.MapVoteList[i] != ""; ++i)
// 		{
// 			s = i+1@". "@RxGRI.MapVoteList[i]@"("@RxGRI.MapVotes[i]@")";
// 			AvailableRadioCommands.AddItem(s);
// 		}
	} else {

		//calling the function in rx_gfxhud to display the vote in flash (nBab)
		//old line:
		//class'Rx_VoteMenuHandler'.static.DisplayOngoingVote(pc, Canvas, HUDCanvasScale, ConsoleColor);
		HudMovie.showVote(pc.VoteTopString,pc.VotesYes,pc.VotesNo,pc.YesVotesNeeded,pc.VoteTimeLeft);



		if (pc.VoteHandler != none)
		{
			/* one1: display vote related stuff only. */
			pc.VoteHandler.Display(Canvas, HUDCanvasScale, ConsoleMessagePosX, ConsoleMessagePosY, ConsoleColor);
			return;
		}

		if ( !Rx_PlayerInput(PlayerOwner.PlayerInput).bAltPressed && !Rx_PlayerInput(PlayerOwner.PlayerInput).bCntrlPressed)
			return;
		else if(Rx_PlayerInput(PlayerOwner.PlayerInput).bAltPressed && Rx_PlayerInput(PlayerOwner.PlayerInput).bCntrlPressed){
			s = "1. "@pc.RadioCommandsText[20];
			AvailableRadioCommands.AddItem(s);
			s = "2. "@pc.RadioCommandsText[21];
			AvailableRadioCommands.AddItem(s);
			s = "3. "@pc.RadioCommandsText[22];
			AvailableRadioCommands.AddItem(s);
			s = "4. "@pc.RadioCommandsText[23];
			AvailableRadioCommands.AddItem(s);
			s = "5. "@pc.RadioCommandsText[24];
			AvailableRadioCommands.AddItem(s);
			s = "6. "@pc.RadioCommandsText[25];
			AvailableRadioCommands.AddItem(s);
			s = "7. "@pc.RadioCommandsText[26];
			AvailableRadioCommands.AddItem(s);
			s = "8. "@pc.RadioCommandsText[27];
			AvailableRadioCommands.AddItem(s);
			s = "9. "@pc.RadioCommandsText[28];
			AvailableRadioCommands.AddItem(s);
			s = "0. "@pc.RadioCommandsText[29];
			AvailableRadioCommands.AddItem(s);
			s = "V: "@pc.VoteCommandText;
			AvailableRadioCommands.AddItem(s);
			s = "N: "@pc.DonateCommandText;
			AvailableRadioCommands.AddItem(s);
			
			//Add a empty line to seperate the admintool from the original options
			AvailableRadioCommands.AddItem(" ");
			
			if ( myAdminTool_Controller.iAccessByPlayersAdminToolMenu == 1 )
			{
				s = "X: "@myAdminTool_Controller.AdminToolCommandText;
			}
			else if ( pc.PlayerReplicationInfo.bAdmin == true )
			{
			s = "X: "@myAdminTool_Controller.AdminToolCommandText $ " (Hidden for players)";
			}
			else
			{
				s = " ";
			}
		
			AvailableRadioCommands.AddItem(s);	
			
		} else if (Rx_PlayerInput(PlayerOwner.PlayerInput).bCntrlPressed) {
			s = "1. "@pc.RadioCommandsText[0];
			AvailableRadioCommands.AddItem(s);
			s = "2. "@pc.RadioCommandsText[1];
			AvailableRadioCommands.AddItem(s);
			s = "3. "@pc.RadioCommandsText[2];
			AvailableRadioCommands.AddItem(s);
			s = "4. "@pc.RadioCommandsText[3];
			AvailableRadioCommands.AddItem(s);
			s = "5. "@pc.RadioCommandsText[4];
			AvailableRadioCommands.AddItem(s);
			s = "6. "@pc.RadioCommandsText[5];
			AvailableRadioCommands.AddItem(s);
			s = "7. "@pc.RadioCommandsText[6];
			AvailableRadioCommands.AddItem(s);
			s = "8. "@pc.RadioCommandsText[7];
			AvailableRadioCommands.AddItem(s);
			s = "9. "@pc.RadioCommandsText[8];
			AvailableRadioCommands.AddItem(s);
			s = "0. "@pc.RadioCommandsText[9];	
			AvailableRadioCommands.AddItem(s);
			s = "V: "@pc.VoteCommandText;
			AvailableRadioCommands.AddItem(s);
			s = "N: "@pc.DonateCommandText;
			AvailableRadioCommands.AddItem(s);
			
			//Add a empty line to seperate the admintool from the original options
			AvailableRadioCommands.AddItem(" ");
			
			if ( myAdminTool_Controller.iAccessByPlayersAdminToolMenu == 1 )
			{
				s = "X: "@myAdminTool_Controller.AdminToolCommandText;
			}
			else if ( pc.PlayerReplicationInfo.bAdmin == true )
			{
			s = "X: "@myAdminTool_Controller.AdminToolCommandText $ " (Hidden for players)";
			}
			else
			{
				s = " ";
			}
		
			AvailableRadioCommands.AddItem(s);	
			
		} else if (Rx_PlayerInput(PlayerOwner.PlayerInput).bAltPressed) {
			s = "1. "@pc.RadioCommandsText[10];
			AvailableRadioCommands.AddItem(s);
			s = "2. "@pc.RadioCommandsText[11];
			AvailableRadioCommands.AddItem(s);
			s = "3. "@pc.RadioCommandsText[12];
			AvailableRadioCommands.AddItem(s);
			s = "4. "@pc.RadioCommandsText[13];
			AvailableRadioCommands.AddItem(s);
			s = "5. "@pc.RadioCommandsText[14];
			AvailableRadioCommands.AddItem(s);
			s = "6. "@pc.RadioCommandsText[15];
			AvailableRadioCommands.AddItem(s);
			s = "7. "@pc.RadioCommandsText[16];
			AvailableRadioCommands.AddItem(s);
			s = "8. "@pc.RadioCommandsText[17];
			AvailableRadioCommands.AddItem(s);
			s = "9. "@pc.RadioCommandsText[18];
			AvailableRadioCommands.AddItem(s);
			s = "0. "@pc.RadioCommandsText[19];
			AvailableRadioCommands.AddItem(s);
			s = "V: "@pc.VoteCommandText;
			AvailableRadioCommands.AddItem(s);
			s = "N: "@pc.DonateCommandText;
			AvailableRadioCommands.AddItem(s);
			
			//Add a empty line to seperate the admintool from the original options
			AvailableRadioCommands.AddItem(" ");
			
			//Add the admintool menu option
			if ( myAdminTool_Controller.iAccessByPlayersAdminToolMenu == 1 )
			{
				s = "X: "@myAdminTool_Controller.AdminToolCommandText;
			}
			else if ( pc.PlayerReplicationInfo.bAdmin == true )
			{
			s = "X: "@myAdminTool_Controller.AdminToolCommandText $ " (Hidden for players)";
			}
			else
			{
				s = " ";
			}

			AvailableRadioCommands.AddItem(s);			
		}
	}

    XPos = (ConsoleMessagePosX * HudCanvasScale * Canvas.SizeX) + (((1.0 - HudCanvasScale) / 2.0) * Canvas.SizeX);
    YPos = (ConsoleMessagePosY * HudCanvasScale * Canvas.SizeY) + 20* (((1.0 - HudCanvasScale) / 2.0) * Canvas.SizeY);

	

//&& myAdminTool_Controller.ScreenSizeX > 1000 

		if ( myAdminTool_Controller.ScreenSizeX > 1900 )
		{
			Canvas.Font = Font'RenXHud.Font.RadioCommand_Medium'; //class'Engine'.Static.GetMediumFont();
		}
		else
		{
			Canvas.Font = class'Engine'.Static.GetSmallFont(); //class'Engine'.Static.GetMediumFont();
		}
    
    //Canvas.Font = Font'RenXHud.Font.RadioCommand_Medium'; //class'Engine'.Static.GetMediumFont();
    Canvas.DrawColor = ConsoleColor;

    Canvas.TextSize ("A", XL, YL);
    YPos -= YL * AvailableRadioCommands.Length; // DP_LowerLeft
    YPos -= YL; // Room for typing prompt

	if(bDrawingMapVotes) {
		XPos -= 30;	
	}

    for (Idx = 0; Idx < AvailableRadioCommands.Length; Idx++)
    {
    	Canvas.StrLen( AvailableRadioCommands[Idx], XL, YL );
		Canvas.SetPos( XPos, YPos );
		if(bDrawingMapVotes) {
			Canvas.DrawText( AvailableRadioCommands[Idx], false, 0.8, 0.8 );
		} else {
			Canvas.DrawText( AvailableRadioCommands[Idx], false );
		}
		YPos += YL;
    }
}






//function LocalizedMessage
//(
//	class<LocalMessage>		InMessageClass,
//	PlayerReplicationInfo	RelatedPRI_1,
//	PlayerReplicationInfo	RelatedPRI_2,
//	string					CriticalString,
//	int						Switch,
//	float					Position,
//	float					LifeTime,
//	int						FontSize,
//	color					DrawColor,
//	optional object			OptionalObject
//)
//{
//	super.LocalizedMessage(InMessageClass,RelatedPRI_1,RelatedPRI_2,CriticalString,Switch,Position,LifeTime,FontSize,DrawColor,OptionalObject);
//
//	if (HudMovie == none || !HudMovie.bMovieIsOpen)
//		return;
//
//   //PlayerOwner.ClientMessage("ClassType: "$InMessageClass $" | Message: "$CriticalString);
//	if (InMessageClass == class'Rx_DeathMessage')
//	{
//		if (RelatedPRI_1 == none)
//		{
//			if (switch == 1)    // Suicide
//			{
//				AddKillMessage(RelatedPRI_2, RelatedPRI_2);
//				if (RelatedPRI_2 == PlayerOwner.PlayerReplicationInfo)
//					AddDeathMessage(RelatedPRI_2, class<DamageType>(OptionalObject));
//			}
//			else   // Died
//			{
//				AddKillMessage(None, RelatedPRI_2);
//				if (RelatedPRI_2 == PlayerOwner.PlayerReplicationInfo)
//					AddDeathMessage(None, class<DamageType>(OptionalObject));
//			}
//		}
//		else
//		{
//			AddKillMessage(RelatedPRI_1, RelatedPRI_2);
//			if (RelatedPRI_2 == PlayerOwner.PlayerReplicationInfo)
//				AddDeathMessage(RelatedPRI_1, class<DamageType>(OptionalObject));
//		}
//	}
//	else if (InMessageClass == class'Rx_Message_Vehicle')
//	{
//		HudMovie.AddEVAMessage(CriticalString);
//	}
//	else if (InMessageClass == class'Rx_Message_Buildings')
//	{
//		if (Switch == 0)
//			AddBuildingKillMessage(RelatedPRI_1, Rx_Building_Team_Internals(OptionalObject));
//	}
//	else if (InMessageClass == class'Rx_Message_TechBuilding')
//	{
//		switch (Switch)
//		{
//		case class'Rx_Building_TechBuilding_Internals'.const.GDI_CAPTURED:
//			AddTechBuildingCaptureMessage(RelatedPRI_1, Rx_Building_Team_Internals(OptionalObject), TEAM_GDI);
//			break;
//		case class'Rx_Building_TechBuilding_Internals'.const.NOD_CAPTURED:
//			AddTechBuildingCaptureMessage(RelatedPRI_1, Rx_Building_Team_Internals(OptionalObject), TEAM_Nod);
//			break;
//		case class'Rx_Building_TechBuilding_Internals'.const.GDI_LOST:
//			AddTechBuildingLostMessage(RelatedPRI_1, Rx_Building_Team_Internals(OptionalObject), TEAM_GDI);
//			break;
//		case class'Rx_Building_TechBuilding_Internals'.const.NOD_LOST:
//			AddTechBuildingLostMessage(RelatedPRI_1, Rx_Building_Team_Internals(OptionalObject), TEAM_Nod);
//			break;
//		}
//	}
//	else if (InMessageClass == class'Rx_CratePickup'.default.MessageClass)
//	{ 
//		HudMovie.AddEVAMessage(CriticalString);
//	} 
//	else if (InMessageClass == class'Rx_Message_Deployed')
//	{
//		if (Switch == -1)
//			AddDeployedMessage(RelatedPRI_1, class<Rx_Weapon_DeployedBeacon>(OptionalObject));
//		else
//			AddDisarmedMessage(RelatedPRI_1, class<Rx_Weapon_DeployedBeacon>(OptionalObject), Switch);
//	}
//	else if (InMessageClass == class'GameMessage')
//	{
//		switch (switch)
//		{
//		case 1: // Player Connected
//			AddTeamJoinMessage(RelatedPRI_1, UTTeamInfo(RelatedPRI_1.Team));   // Team join messages don't get sent for connected players, so emulate one.
//			// FALLTHRU
//		case 2: // Name Change
//		case 4: // Player Disconnected
//			Message(None, class'GameMessage'.static.GetString(Switch, (RelatedPRI_1 == PlayerOwner.PlayerReplicationInfo), RelatedPRI_1, RelatedPRI_2, OptionalObject), 'System');
//			break;
//		case 3: // Team Change
//			AddTeamJoinMessage(RelatedPRI_1, UTTeamInfo(OptionalObject));
//			break;
//		}
//	}
//
//}





/*****************************************************************************/
 //  *  //  *  //  *  //      TestArea    //  *  //  *  //  *  //  *  //  *  //  
/*****************************************************************************/

//		sssimulated function InitMyAdminToolController(optional bool bIsActor){
//		ss
//		ss	if (bIsActor) { foreach Rx_Game(`WorldInfoObject.Game).AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break; }
//		ss	else { foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'Rx_Mutator_AdminTool_Controller', myAdminTool_Controller) break; }
//		ss}


/**************************************************************************************************************************************************************************************/
  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  DEFAULT PROPERTIES  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //  *  //
/**************************************************************************************************************************************************************************************/


defaultproperties
{
	TargetingBoxClass = class'Rx_Mutator_AdminTool_HUD_TargetingBox';
}