// *****************************************************************************
//  * * * * * * * * * * Rx_Mutator_SendString_Controller * * * * * * * * * * * *
// *****************************************************************************
class Rx_Mutator_SendString_Controller extends Rx_Controller;
 
exec function SendString(string value) 
{
	ServerSendString(value);
}

reliable server function ServerSendString(string value)
{
	local Rx_Mutator_SendString_Controller C;
	
	if (PlayerReplicationInfo.bAdmin)
	
	foreach WorldInfo.AllControllers(class'Rx_Mutator_SendString_Controller', C)
	{
		C.ServerSendStringNow(value);
	}
    else
    {
        ClientMessage("First login as admin",,1); 
    }
}	//Only ever do admin checks on the actual server. 

function ServerSendStringNow(string value)
{	// Check TestMode

		ClientMessage(value); 
}

DefaultProperties
{
}
