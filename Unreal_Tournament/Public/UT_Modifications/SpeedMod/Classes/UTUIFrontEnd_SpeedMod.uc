//=============================================================================
// JumpMod
//
// This mutator allows a server to configure the abilities for players to jump
// around as well as how much boost they receive with each jump.
//
// Contact : bob.chatman@gmail.com
// Website : www.gneu.org
// License : Content is available under Creative Commons Attribution-ShareAlike 
//			 3.0 License.
//=============================================================================

class UTUIFrontEnd_SpeedMod extends UTUIFrontEnd DependsOn( UTMutator_SpeedMod );

var transient UTUISlider  uiGameSpeed;

event SceneActivated( bool bInitialActivation )
{
	Super.SceneActivated( bInitialActivation );

	if ( bInitialActivation )
	{
		uiGameSpeed  = UTUISlider ( FindChild( 'sliSpeed', true ) );

		uiGameSpeed.SliderValue.CurrentValue 		= class'SpeedMod.UTMutator_SpeedMod'.default.iGameSpeed;
		uiGameSpeed.SliderValue.MinValue   		= 25;
		uiGameSpeed.SliderValue.MaxValue   		= 400;
		uiGameSpeed.SliderValue.NudgeValue 		= 1;
		uiGameSpeed.SliderValue.bIntRange 		= true;
		uiGameSpeed.UpdateCaption();
	}
}

/** Sets up the scene's button bar. */
function SetupButtonBar()
{
	ButtonBar.Clear();
	ButtonBar.AppendButton( "<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back );
	ButtonBar.AppendButton( "<Strings:UTGameUI.ButtonCallouts.Accept>", OnButtonBar_Accept );
}

function bool OnButtonBar_Accept( UIScreenObject InButton, int InPlayerIndex )
{

	class'SpeedMod.UTMutator_SpeedMod'.default.iGameSpeed  = uiGameSpeed.GetValue();
    class'SpeedMod.UTMutator_SpeedMod'.static.StaticSaveConfig();

	CloseScene( self );

	return true;
}

function bool OnButtonBar_Back( UIScreenObject InButton, int InPlayerIndex )
{
	CloseScene( self );

	return true;
}
