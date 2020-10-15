Official Harvester and Gunemplacement Mutator V1.0 by RypeL from Renegade X Team

Why:
A Patcher for Renegade X is still under development but a mutator is another way to fix some issues and so we want to try this out and hopefully this fixes most of the freezing Harvester issues.   


How to install:

1) Move the RxHarvMod.u into the Renegade X\UDKGame\CookedPC folder
2) add "?mutator=RxHarvMod.Rx_Mutator_SmarterHarv" to the starting command of your server. So it should look something like this: "udk server CNC-Walls_Flying?game=RenX_Game.Rx_Game?mutator=RxHarvMod.Rx_Mutator_SmarterHarv"


I added the Sourcecode in case someone wants to see how it was done and how a mutator for Renegade X can look like.


The mutator includes the following changes:

- The harvester should be less likely to stop moving completly like it did mostly at the GDI Refinary on Walls. 
  If it still freezes you can try pushing it back on its path (like with a Medium Tank) and it should start moving again. We will replace some pathnodes on Walls in the next 
  regular Renegade X update to hopefully completely fix the issue on Walls.  
- Harverster respawntime increased by 15 seconds
- Whiteout Gunemplacements respawntime increased by 30 seconds 