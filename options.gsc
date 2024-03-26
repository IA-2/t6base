menuStructure()
{
    self addMenu("main", "Main Menu", "Exit");
    self add_option("main", "Self Menu", ::_loadMenu, "sm");

    self addMenu("sm", "Self Menu", "main");
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
    self add_option("sm", "Disconnect", ::disconnect);
}