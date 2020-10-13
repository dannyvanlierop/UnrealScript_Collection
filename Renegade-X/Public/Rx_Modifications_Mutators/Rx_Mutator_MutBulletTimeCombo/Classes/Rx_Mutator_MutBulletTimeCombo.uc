class Rx_Mutator_MutBulletTimeCombo extends Rx_Mutator;
 
var Player NotifyPlayer[32];
 
function Timer()
{
     local int i;
 
     for(i = 0; i < 32; i++)
     {
          if(NotifyPlayer[i] != None)
          {
               NotifyPlayer[i].ClientReceiveCombo("Rx_Mutator_MutBulletTimeCombo.Rx_Mutator_MutBulletTimeCombo_Ext");
               NotifyPlayer[i] = None;
          }
 
     }
}
 
function bool IsRelevant(Actor Other, out byte bSuperRelevant)
{
     local int i;
 
     if(Player(Other) != None)
     {
          for(i=0; i<16; i++)
	  {
	       if (Player(Other).ComboNameList[i] ~= "Rx_Mutator_MutBulletTimeCombo.Rx_Mutator_MutBulletTimeCombo_Ext")
                    break;
               else if(Player(Other).ComboNameList[i] == "")
               {
                    Player(Other).ComboNameList[i] = "Rx_Mutator_MutBulletTimeCombo.Rx_Mutator_MutBulletTimeCombo_Ext";
		    break;
               }
          }
          for(i = 0; i < 32; i++)
          {
               if(NotifyPlayer[i] == None)
               {
                    NotifyPlayer[i] = Player(Other);
                    SetTimer(0.5, false);
                    break;
               }
          }
     }
     if(NextMutator != None)
          return NextMutator.IsRelevant(Other, bSuperRelevant);
     else
          return true;
}
 
defaultproperties
{
    FriendlyName = "Bullet Time Combo"
    Description = "Adds the bullet time combo (UDUD). The combo slows all gameplay down, but allows players aim to be more accurate, as seen in the Matrix trilogies."
}