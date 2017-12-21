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

procedure TLabelObject.SetDefaultStyles();
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

function TFormObject.Bounds: TRect;
var
  parent: TFormObject;
  pad: TRect;
begin
  Result := Self^.Bounds;

  if (Self^.Position = bpAbsolute) then
    Exit;

  parent := Self^.Parent;
  if (parent <> nil) then
  begin
    Result.Left   := Max(0, parent.Bounds.Left   + Result.Left);
    Result.Top    := Max(0, parent.Bounds.Top    + Result.Top);
    Result.Right  := Max(0, parent.Bounds.Right  + Result.Right);
    Result.Bottom := Max(0, parent.Bounds.Bottom + Result.Bottom);
  end else
  begin
    Result.Left   := Max(0, Result.Left);
    Result.Top    := Max(0, Result.Top);
    Result.Right  := Max(0, SlackGUI.Form.GetWidth  + Result.Right);
    Result.Bottom := Max(0, SlackGUI.Form.GetHeight + Result.Bottom);
  end;
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
    Self.Bounds := ptrSelf.Bounds;
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
    Self.Bounds := ptrSelf.Bounds;
    Self.Bounds.Bottom := Self.Bounds.Top + newHeight-1;
    Self.Position := bpAbsolute;
  end;
end;  