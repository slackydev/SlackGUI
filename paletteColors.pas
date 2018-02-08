const 
  DARK_NEUTRAL = [
    2039583,     // background0 (Dark)
    $1F1A13,     // background1 (Titlebar)
    $2F2A23,     // background2 (most objects)
    $3F3A33,     // background3 (other objects)
    $5F5A44,     // background4 (undefined)
    
    $FFFFFF,     // text1
    $FFFFFF,     // text2
    $777777,     // text3
    
    $FFFF00,     // highlighted1
    $00FFFF,     // highlighted2
    $5F5A44,     // highlighted3
    
    $1F1A13,     // border1
    $AAAAAA,     // border2
    $443F3A      // border3
  ];

  clBackground0 = 0;
  clBackground1 = 1;
  clBackground2 = 2;
  clBackground3 = 3;
  clBackground4 = 4;
  
  clText1 = 5;
  clText2 = 6;
  clText3 = 7;
  
  clHighlighted1 = 8;
  clHighlighted2 = 9;
  clHighlighted3 = 10;
  
  clBorder1 = 11;
  clBorder2 = 12;
  clBorder3 = 13;
  
  {$ifndecl clRed}clRed := $FF; {$endif}
