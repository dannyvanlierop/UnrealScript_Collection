// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_VoteSystemChange_Controller * * * * * * * * * * * *
// *****************************************************************************
//class Rx_Controller extends UTPlayerController;
class Rx_Mutator_VoteSystemChange_Controller extends Rx_Controller;

function EnableVoteMenu(bool donate)
{
	// just in case, turn off previous one
	DisableVoteMenu();

	if (!donate && WorldInfo.TimeSeconds < NextVoteTime)
	{
		ClientMessage("You must wait"@ int(NextVoteTime - WorldInfo.TimeSeconds) @"more seconds before you can start another vote.");
		return;
	}
	if (donate) VoteHandler = new (self) class'Rx_CreditDonationHandler';
	else VoteHandler = new (self) class'Rx_VoteMenuHandler_Ext';
	VoteHandler.Enabled(self);
}

defaultproperties
{

}





