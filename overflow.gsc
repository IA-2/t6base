//overflow
overflowfix()
{
    level endon("game_ended");
    level endon("host_migration_begin");
    test = level createServerFontString("objective", 1);
    test.alpha = 0;
    test setText("xTUL");
    while(true)
    {
        level waittill("clear_strings");
        test clearalltextafterhudelem();
        level.strings = [];
        foreach(player in level.players)
        {
            if(player isInMenu())
            {
                player updateText();
                player addMenu(self.menu.currentmenu);
            }
        }
    }
}