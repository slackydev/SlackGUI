procedure InheritStyles(This, Parent: TFormObject);
begin
  case This^.Typ of
    otNone:       This.SetDefaultStyles(); 
    otTitlebar:   TTitlebarObject(This).SetDefaultStyles();
    otText:       TTextObject(This).SetDefaultStyles(); 
    otButton:     TButtonObject(This).SetDefaultStyles(); 
    otCheckbox:   TCheckboxObject(This).SetDefaultStyles(); 
    otRadios:     This.SetDefaultStyles(); 
    otBlock:      TBlockObject(This).SetDefaultStyles();
    otInputField: This.SetDefaultStyles();
    otInputBox:   This.SetDefaultStyles();
  end;
  
  (*
  while (Parent <> nil) and (Parent^.Typ <> This^.Typ) do
    Parent := Parent^.Parent;
  
  if (Parent <> nil) then
  begin
    This^.Styles.Background  := Parent^.Styles.Background;
    This^.Styles.BorderColor := Parent^.Styles.BorderColor;
    This^.Styles.BorderSize  := Parent^.Styles.BorderSize;
    This^.Styles.FontStyle := Parent^.Styles.FontStyle;
    This^.Styles.FontColor := Parent^.Styles.FontColor;
    This^.Styles.FontSize  := Parent^.Styles.FontSize;
    This^.Styles.FontName  := Parent^.Styles.FontName;
    This^.Styles.TextWrap  := Parent^.Styles.TextWrap;
    This^.Styles.Overflow  := Parent^.Styles.Overflow;
    This^.Styles.Align     := Parent^.Styles.Align;
  end else
    {load object dependant default styleset}
  *)
end;

procedure DefaultCallbacks(This: TFormObject);
begin
  This^.__OnMouseDown := @TSlackGUI.OnMouseDown;
  This^.__OnMouseMove := @TSlackGUI.OnMouseMove;
  This^.__OnMouseUp   := @TSlackGUI.OnMouseUp;
  This^.__OnKeyDown   := @TSlackGUI.OnKeyDown;
  This^.__OnKeyUp     := @TSlackGUI.OnKeyUp;
  This^.__OnKeyPress  := @TSlackGUI.OnKeyPress;
  This^.__OnMouseEnter:= @TSlackGUI.OnMouseEnter;
  This^.__OnMouseLeave:= @TSlackGUI.OnMouseLeave;
  This^.__OnClick     := @TSlackGUI.OnClick;
end;

function FormObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TFormObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);
end;

function TitlebarObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TTitlebarObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otTitlebar;
  Result^.IsVisible := True;

  DefaultCallbacks(Result);
  Result^.__OnMouseDown := @TSlackGUI.OnDragWindowStart;
  Result^.__OnMouseMove := @TSlackGUI.OnDragWindow;
  Result^.__OnMouseUp   := @TSlackGUI.OnDragWindowStop;
end;

function TextObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TTextObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otText;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);
end;

function BlockObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TBlockObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otBlock;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);
end;

function ButtonObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TButtonObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otButton;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);

  Result^.__OnMouseEnter:= @TSlackGUI.OnButtonEnter;
  Result^.__OnMouseLeave:= @TSlackGUI.OnButtonLeave;
end;

function CheckBoxObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TCheckBoxObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otCheckbox;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);

  Result^.__OnMouseEnter:= @TSlackGUI.OnCheckboxEnter;
  Result^.__OnMouseLeave:= @TSlackGUI.OnCheckboxLeave;
  Result^.__OnClick     := @TSlackGUI.OnCheckboxClick;
end;

function InputFieldObject(Name: String; Bounds: TRect=[]; Parent: TFormObject=nil): TFormObject;
begin
  Result := AllocMem(SizeOf(TInputFieldObjectRec));
  Result^.Name   := Name;
  Result^.Bounds := Bounds;
  Result^.Parent := Parent;
  Result^.Typ    := otInputField;
  Result^.IsVisible := True;

  InheritStyles(Result, Parent);
  DefaultCallbacks(Result);

  Result^.__OnKeyPress := @TSlackGUI.OnInputFieldPressKey;
end;
