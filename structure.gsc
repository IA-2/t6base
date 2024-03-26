initMenu()
{
    self.Menu = spawnStruct();
    self.Hud = spawnStruct();
    self.menu.opened = false;
    self thread menuStructure();
    self thread menuButtons();
}
 
menuButtons()
{
    self endon("disconnect");
    for(;;)
    {
        if(!self.menu.opened)
        {
            if(self AdsButtonPressed() && self meleeButtonPressed())
            {
                self thread openTheMenu();
                wait .2;
            }
        }
        else
        {
            if(self ActionSlotOneButtonPressed())
            {
                self.Scroller--;
                self _scrollUpdate();
                wait .1;
            }
            if(self ActionSlotTwoButtonPressed())
            {
                self.Scroller++;
                self _scrollUpdate();
                wait .1;
            }
            if(self UseButtonPressed())
            {
                self thread [[self.Menu.Func[self.Menu.CurrentMenu][self.Scroller]]](self.Menu.Input[self.Menu.CurrentMenu][self.Scroller]);
                wait .3;
            }
            if(self MeleeButtonPressed())
            {
                if(self.Menu.parent[self.Menu.CurrentMenu] == "Exit")
                {
                    self thread closeTheMenu();
                }
                else
                {
                    self _loadMenu(self.Menu.parent[self.Menu.CurrentMenu]);
                }
                wait .3;
            }
        }
        wait 0.05;
    }
    wait 0.05;
}
 
_loadMenu(menu)
{
    self destroyMenuText();
    self.Menu.CurrentMenu = menu;
    self.Scroller = 0;
    self createMenuText();
    self _scrollUpdate();
    self resizeBG();
}

createMenuText()
{
    for(i=0;i<8;i++)
    {
        self.Hud.Text[i] = createText("default", 1, "LEFT", "CENTER", 160, -94 + (12*i), 0, (1, 1, 1), 1, (0, 0, 0), 0, self.Menu.Text[self.Menu.CurrentMenu][i]);
    }
}

destroyMenuText()
{
    if(isDefined(self.Hud.Text))
    {
        for(i=0;i<self.Hud.Text.size;i++)
        {
            self.Hud.Text[i] destroy();
        }
    }
}
 
_scrollUpdate()
{
    self.hud.scrollbar moveOverTime(0.10);

    if(self.Scroller<0)
        self.Scroller = self.Menu.Text[self.Menu.CurrentMenu].size-1;
    if(self.Scroller>self.Menu.Text[self.Menu.CurrentMenu].size-1)
        self.Scroller = 0;
        
    if(!isDefined(self.menu.text[self.menu.currentmenu][self.scroller-4])||self.menu.text[self.menu.currentmenu].size<=8)
	{
		for(i=0;i<8;i++)
		{
			if(isDefined(self.menu.text[self.menu.currentmenu][i]))
				self.hud.text[i] setText(self.menu.text[self.menu.currentmenu][i]);
			else
				self.hud.text[i] setText("");
		}
		self.Hud.Scrollbar.y = -94+(12*self.scroller);
	}
	else
	{
		if(isDefined(self.menu.text[self.menu.currentmenu][self.scroller+4]))
		{
			desires = 0;
			for(i=self.scroller-4;i<self.scroller+5;i++)
			{
				if(isDefined(self.menu.text[self.menu.currentmenu][i]))
					self.hud.text[desires] setText(self.menu.text[self.menu.currentmenu][i]);
				else
					self.hud.text[desires] setText("");
				desires++;
			}           
			self.Hud.Scrollbar.y = -94+(12*4);
		}
		else
		{
			for(i=0;i<8;i++)
			{
				self.hud.text[i] setText(self.menu.text[self.menu.currentmenu][self.menu.text[self.menu.currentmenu].size+(i-8)]);
			}
			self.Hud.Scrollbar.y = -94+(12*((self.scroller-self.menu.text[self.menu.currentmenu].size)+8));
		}
	}
}
 
createHud()
{
    self.hud.menutitle = createText("objective", 1.1, "CENTER", "CENTER", 250, -110, 0, (1,1,1), 1, (0,0,0), 0, "Menu Name");

    self.hud.background = self createRectangle("TOP", "CENTER", 250, -100, 170, 22, (0,0,0), 0.99, 0, "white");
    self.Hud.Scrollbar = self createRectangle("CENTER","CENTER", 250, -94, 180, 14, (1, 0.2, 0.294), 1, 0, "white");

    self.hud.topbar = self createRectangle("CENTER", "CENTER", 250, -108, 180, 16, (1, 0.2, 0.294), 1, 0, "white");
    self.hud.bottombar = self createRectangle("CENTER", "CENTER", 250, -85, 180, 2, (1, 0.2, 0.294), 1, 0, "white");
}

updateText()
{
    if(isDefined(self.hud.menutitle))
        self.hud.menutitle destroy();

    self.hud.menutitle = createText("objective", 1.1, "CENTER", "CENTER", 250, -110, 0, (1,1,1), 1, (0,0,0), 0, "Menu Name");

    self resizeBG();
}

resizeBG()
{
    //void <hud_element> SetShader(<materialname>,[width],[height])
    size = self.Menu.Text[self.Menu.CurrentMenu].size;
    if(size > 8)
        size = 8;
    self.hud.background setShader("white", 180, 2 + (12 * size));
    self.hud.bottombar.y = -100 + (12 * size);
}

destroyHud()
{
    self.Hud.Background destroy();
    self.Hud.Scrollbar destroy();
    self.hud.topbar destroy();
    self.hud.bottombar destroy();
    self.hud.menutitle destroy();
}