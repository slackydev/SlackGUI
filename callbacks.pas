// ----------------------------------------------------------------------------
// GENERIC
procedure TSlackGUI.OnMouseDown(Sender: TFormObject; Button: TMouseButton; Shift: TShiftState; X,Y: Int32); static;
begin
  if (Button = mbLeft) then Sender^.__IsHolding := True;
  if (@Sender^.OnMouseDown <> nil) then Sender^.OnMouseDown(Sender, Button, Shift, X,Y);
end;

procedure TSlackGUI.OnMouseUp(Sender: TFormObject; Button: TMouseButton; Shift: TShiftState; X,Y: Int32); static;
begin
  if (Sender^.__IsHolding) and (Button = mbLeft) then
  begin
    Sender^.__IsHolding := False;
    if (@Sender^.__OnClick <> nil) then Sender^.__OnClick(Sender);
  end;

  if (@Sender^.OnMouseUp <> nil) then Sender^.OnMouseUp(Sender, Button, Shift, X,Y);
end;

procedure TSlackGUI.OnMouseMove(Sender: TFormObject; Shift: TShiftState; X,Y: Int32); static;
begin
  if (@Sender^.OnMouseMove <> nil) then Sender^.OnMouseMove(Sender, Shift, X,Y);
end;

procedure TSlackGUI.OnKeyDown(Sender: TFormObject; Key: Word; Shift: TShiftState); static;
begin
  if (@Sender^.OnKeyDown <> nil) then Sender^.OnKeyDown(Sender, Key, Shift);
end;

procedure TSlackGUI.OnKeyUp(Sender: TFormObject; Key: Word; Shift: TShiftState); static;
begin
  if (@Sender^.OnKeyUp <> nil) then Sender^.OnKeyUp(Sender, Key, Shift);
end;

procedure TSlackGUI.OnMouseEnter(Sender: TFormObject); static;
begin
  if (@Sender^.OnMouseEnter <> nil) then Sender^.OnMouseEnter(Sender);
end;

procedure TSlackGUI.OnMouseLeave(Sender: TFormObject); static;
begin
  if (@Sender^.OnMouseLeave <> nil) then Sender^.OnMouseLeave(Sender);
end;

procedure TSlackGUI.OnClick(Sender: TFormObject); static;
begin
  if (@Sender^.OnClick <> nil) then Sender^.OnClick(Sender);
end;


// ----------------------------------------------------------------------------
// BUTTON
procedure TSlackGUI.OnButtonEnter(Sender: TFormObject); static;
begin
  Swap(Sender^.Styles, Sender^.Styles2);
  if (@Sender^.OnMouseEnter <> nil) then Sender^.OnMouseEnter(Sender);
end;

procedure TSlackGUI.OnButtonLeave(Sender: TFormObject); static;
begin
  Swap(Sender^.Styles, Sender^.Styles2);
  if (@Sender^.OnMouseLeave <> nil) then Sender^.OnMouseLeave(Sender);
end;


// ----------------------------------------------------------------------------
// CHECKBOX
procedure TSlackGUI.OnCheckboxEnter(Sender: TFormObject); static;
begin
  Swap(Sender^.Styles, Sender^.Styles2);
  if (@Sender^.OnMouseEnter <> nil) then Sender^.OnMouseEnter(Sender);
end;

procedure TSlackGUI.OnCheckboxLeave(Sender: TFormObject); static;
begin
  Swap(Sender^.Styles, Sender^.Styles2);
  if (@Sender^.OnMouseLeave <> nil) then Sender^.OnMouseLeave(Sender);
end;

procedure TSlackGUI.OnCheckboxClick(Sender: TFormObject); static;
begin
  TCheckboxObject(Sender)^.IsChecked := not TCheckboxObject(Sender)^.IsChecked;
  if (@Sender^.OnClick <> nil) then Sender^.OnClick(Sender);
end;


// ----------------------------------------------------------------------------
// TITLEBAR
procedure TSlackGUI.OnDragWindowStart(Sender: TFormObject; Button: TMouseButton; Shift: TShiftState; X,Y: Int32); static;
begin
  TTitlebarObject(Sender)^.IsDragging := True;
  TTitlebarObject(Sender)^.DragStartX := X;
  TTitlebarObject(Sender)^.DragStartY := Y;

  if (@Sender^.OnMouseUp <> nil) then Sender^.OnMouseUp(Sender, Button, Shift, X,Y);
end;

procedure TSlackGUI.OnDragWindow(Sender: TFormObject; Shift: TShiftState; X,Y: Int32); static;
var
  R: TRect;
begin
  with TTitlebarObject(Sender)^ do
    if IsDragging then
    begin
      R := SlackGUI.Form.GetBoundsRect;
      R.Left   += X-DragStartX;
      R.Top    += Y-DragStartY;
      R.Right  += X-DragStartX;
      R.Bottom += Y-DragStartY;
      SlackGUI.Form.SetBoundsRect(R);
    end;

  if (@Sender^.OnMouseMove <> nil) then Sender^.OnMouseMove(Sender, Shift, X,Y);
end;

procedure TSlackGUI.OnDragWindowStop(Sender: TFormObject; Button: TMouseButton; Shift: TShiftState; X,Y: Int32); static;
begin
  TTitlebarObject(Sender)^.IsDragging := False;
  TTitlebarObject(Sender)^.DragStartX := 0;
  TTitlebarObject(Sender)^.DragStartY := 0;

  if (@Sender^.OnMouseUp <> nil) then Sender^.OnMouseUp(Sender, Button, Shift, X,Y);
end;