class CTSRPC_PlayerController extends PlayerController;

/**
 * Exec function which allows the client to send text to the server
 *
 * Network: Client
 */
exec function SendTextToServer(String TextToSend)
{
	// If the role of the player controller is not authoritive
	// Text is not empty
	if (Role < Role_Authority && TextToSend != "")
	{
		`Log(Self$":: Client wants to send '"$TextToSend$"' to the server.");
		ServerReceiveText(TextToSend);
	}
}

/**
 * Server function which receives text from the client
 *
 * Network: Dedicated/Listen Server
 */
reliable server function ServerReceiveText(String ReceivedText)
{
	// If the role of the player controller is authoritive
	// Text is not empty
	if (Role == Role_Authority && ReceivedText != "")
	{
		`Log(Self$":: Server received text, '"$ReceivedText$"'.");
	}
}

defaultproperties
{
}