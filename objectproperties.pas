// ----------------------------------------------------------------------------
// Object defaults
procedure TFormObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground3];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder1];
  Self^.Styles.BorderSize  := 4;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText1];
  Self^.Styles.FontSize  := 10;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
end;  

procedure TTitlebarObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground1];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder1];
  Self^.Styles.BorderSize  := 0;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText1];
  Self^.Styles.FontSize  := 12;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
end; 

procedure TTextObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground2];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder1];
  Self^.Styles.BorderSize  := 0;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText1];
  Self^.Styles.FontSize  := 10;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
end;

procedure TButtonObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground1];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder2];
  Self^.Styles.BorderSize  := 2;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText2];
  Self^.Styles.FontSize  := 10;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
  Self^.Styles.Padding     := [6,3,6,5];
  
  Self^.Styles2 := Self^.Styles;
  Self^.Styles2.BorderSize  := 2;
  Self^.Styles2.Background  := SlackGUI.Palette[clBackground2];
  Self^.Styles2.BorderColor := SlackGUI.Palette[clHighlighted1];
  
  Self^.Styles3 := Self^.Styles2;
  Self^.Styles3.Background := SlackGUI.Palette[clBackground3];
end; 

procedure TCheckboxObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground1];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder2];
  Self^.Styles.BorderSize  := 1;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText2];
  Self^.Styles.FontSize  := 10;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
  
  Self^.Styles2 := Self^.Styles;
  Self^.Styles2.BorderColor := SlackGUI.Palette[clHighlighted1];
end;

procedure TBlockObject.SetDefaultStyles();
begin
  Self^.Styles.Background  := SlackGUI.Palette[clBackground3];
  Self^.Styles.BorderColor := SlackGUI.Palette[clBorder1];
  Self^.Styles.BorderSize  := 4;
  Self^.Styles.FontStyle := [fsBold];
  Self^.Styles.FontColor := SlackGUI.Palette[clText1];
  Self^.Styles.FontSize  := 10;
  Self^.Styles.FontName  := 'Tahoma';
  //Self^.Styles.TextWrap  := True;
  //Self^.Styles.Overflow  := False;
  //Self^.Styles.Align     := al;
end;


// ----------------------------------------------------------------------------
// Object properties

function TFormObject.Styles: TStyleSet;
begin
  Result := Self^.Styles;
end;

function TFormObject.Bounds(AddPadding: Boolean = True): TRect;
var
  parent: TFormObject;
  p,b: TRect;
begin
  Result := Self^.Bounds;
  parent := Self^.Parent;
  
  if (Self^.Position = bpRelative) then
  begin
    if (parent <> nil) then
    begin
      if (Result.Left< 0) then Result.Left := Max(0, parent.Bounds.Right  + Result.Left)
      else                     Result.Left := Max(0, parent.Bounds.Left   + Result.Left);
      if (Result.Top < 0) then Result.Top  := Max(0, parent.Bounds.Bottom + Result.Top)
      else                     Result.Top  := Max(0, parent.Bounds.Top    + Result.Top);

      if (Result.Right  <= 0) then Result.Right  := Max(0, parent.Bounds.Right  + Result.Right)
      else                         Result.Right  := Max(0, parent.Bounds.Left   + Result.Right);
      if (Result.Bottom <= 0) then Result.Bottom := Max(0, parent.Bounds.Bottom + Result.Bottom)
      else                         Result.Bottom := Max(0, parent.Bounds.Top    + Result.Bottom);
    end else
    begin
      Result.Left   := Max(0, Result.Left);
      Result.Top    := Max(0, Result.Top);
      Result.Right  := Max(0, SlackGUI.Form.GetWidth  + Result.Right);
      Result.Bottom := Max(0, SlackGUI.Form.GetHeight + Result.Bottom);
    end;
  end else if (Self^.Position = bpInherited) then
  begin
    //WriteLn parent.Bounds;
    if (parent <> nil) then
    begin
      Result.Left   := Max(0, parent.Bounds.Left + Result.Left);
      Result.Top    := Max(0, parent.Bounds.Top  + Result.Top);
      Result.Right  := Max(0, parent.Bounds.Left + Result.Right);
      Result.Bottom := Max(0, parent.Bounds.Top  + Result.Bottom);
    end else
    begin
      Result.Left   := Max(0, Result.Left);
      Result.Top    := Max(0, Result.Top);
      Result.Right  := Max(0, Result.Right);
      Result.Bottom := Max(0, Result.Bottom);
    end;
  end;
  
  if (parent <> nil) and AddPadding then
  begin
    b := parent.Bounds;
    p := parent^.Styles.Padding;
    
    Result.Left   += p.Left;
    Result.Top    += p.Top;
    Result.Right  += p.Right;
    Result.Bottom += p.Bottom;
    
    if Result.Right  > b.Right - p.Right  then Result.Right  := b.Right-p.Right;
    if Result.Bottom > b.Bottom- p.Bottom then Result.Bottom := b.Bottom-p.Bottom;
  end;
end; 

procedure TFormObject.RecomputeSize(InternalSize: TSize2D);
var
  B,Pad: TRect;
begin
  B   := Self.Bounds;
  Pad := Self^.Styles.Padding;
  if (B.Left + InternalSize.Wid + Pad.Left + Pad.Right > B.Right) then 
    Self^.SetWidth(InternalSize.Wid + Pad.Left + Pad.Right);
  if (B.Top  + InternalSize.Hei + Pad.Top + Pad.Bottom > B.Bottom) then 
    Self^.SetHeight(InternalSize.Hei + Pad.Top + Pad.Bottom);
end;


// ----------------------------------------------------------------------------
// Record

procedure TFormObjectRec.SetWidth(newWidth: Int32);
var
  ptrSelf: TFormObject;
begin
  if (Self.Position = bpAbsolute) then
    Self.Bounds.Right := Self.Bounds.Left + newWidth-1
  else
  begin
    ptrSelf := @Self;
    Self.Bounds := ptrSelf.Bounds(False);
    Self.Bounds.Right := Self.Bounds.Left + newWidth-1;
    Self.Position := bpAbsolute;
  end;
end;

procedure TFormObjectRec.SetHeight(newHeight: Int32);
var
  ptrSelf: TFormObject;
begin
  if (Self.Position = bpAbsolute) then
    Self.Bounds.Bottom := Self.Bounds.Top + newHeight-1
  else
  begin
    ptrSelf := @Self;
    Self.Bounds := ptrSelf.Bounds(False);
    Self.Bounds.Bottom := Self.Bounds.Top + newHeight-1;
    Self.Position := bpAbsolute;
  end;
end;
