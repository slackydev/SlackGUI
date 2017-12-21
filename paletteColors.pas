const 
  DARK_NEUTRAL = [         
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
  
  clBackground1 = 0;
  clBackground2 = 1;
  clBackground3 = 2;
  clBackground4 = 3;
  
  clText1 = 4;
  clText2 = 5;
  clText3 = 6;
  
  clHighlighted1 = 7;
  clHighlighted2 = 8;
  clHighlighted3 = 9;
  
  clBorder1 = 10;
  clBorder2 = 11;
  clBorder3 = 12;
  
  {$ifndef clRed}clRed := $FF; {$endif}