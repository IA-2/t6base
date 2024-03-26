#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
 
init()
{
    precacheshader("white");
    level thread onPlayerConnect();
    if(!isDefined(level.overflowfix))
    {
        level.overflowfix = true;
        level thread overflowfix();
    }
}
 
onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        if(player isHost())
        {
            player thread initMenu();
        }
    }
}
 
onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(self.first)
        {
            if(self isHost())
            {
                self freezecontrols(false);
                self iprintln("Press [{+speed_throw}] + [{+melee}] to Open Menu");
            }
        }
        self.first = false;
    }
}