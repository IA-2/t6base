addMenu(menu,title,parent)
{
    self.menu.text[menu] = [];
    self.Menu.title[menu] = title;
    self.Menu.parent[menu] = parent;
}

add_option(menu,text,func,input)
{
    index = self.menu.text[menu].size;
    self.Menu.Text[menu][index] = text;
    self.Menu.Func[menu][index] = func;
    self.Menu.Input[menu][index] = input;
}

createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
    textElem = CreateFontString( font, fontscale );
    textElem setPoint( align, relative, x, y );
    textElem.sort = sort;
    textElem.type = "text";
    textElem setText(text);
    textElem.color = color;
    textElem.alpha = alpha;
    textElem.glowColor = glowColor;
    textElem.glowAlpha = glowAlpha;
    textElem.hideWhenInMenu = true;
    textElem.foreground = true;
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, alpha, sorting, shadero)
{
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    if ( !level.splitScreen )
    {
        barElemBG.x = -2;
        barElemBG.y = -2;
    }
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.color = color;
    if(isDefined(alpha))
        barElemBG.alpha = alpha;
    else
        barElemBG.alpha = 1;
    barElemBG setShader( shadero, width , height );
    barElemBG.hidden = false;
    barElemBG.sort = sorting;
    barElemBG setPoint(align,relative,x,y);
    return barElemBG;
}

openTheMenu()
{
    self.Menu.Opened = true;
    self thread createHud();
    self _loadMenu("main");
}

closeTheMenu()
{
    self.Menu.Opened = false;
    self thread destroyMenuText();
    self thread destroyHud();
}

isInMenu()
{
    if(isDefined(self.menu.opened))
        return true;
    return false;
}

//menu functions
null()
{
	self iprintlnbold("This function has not been built yet.");
}

disconnect()
{
    ExitLevel(false);
}