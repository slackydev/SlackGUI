procedure TSlackGUI.ApplyStyle(Style: TStyleSet);
begin
  SlackGUI.Image.GetCanvas.GetBrush.SetStyle(bsClear);
  SlackGUI.Image.GetCanvas.GetFont.SetName(Style.FontName);
  SlackGUI.Image.GetCanvas.GetFont.SetColor(Style.FontColor);
  SlackGUI.Image.GetCanvas.GetFont.SetSize(Style.FontSize);
  SlackGUI.Image.GetCanvas.GetFont.SetStyle(Style.FontStyle);
end;

procedure TSlackGUI.RenderBasicBlock(FObject: TFormObject); static;
var
  BGIMG: TBitmap;
  Bounds: TRect;
begin
  with FObject.Styles do
  begin
    Bounds := FObject.Bounds;
    SlackGUI.Image.GetCanvas.DrawSolidRect(Bounds, Background);

    BGIMG := SlackGUI.LoadImage(BackgroundImage);
    if (BGIMG <> nil) then SlackGUI.Image.GetCanvas.DrawBitmap(Bounds, BGIMG, BackgroundImageFit);
    SlackGUI.Image.GetCanvas.DrawBorder(Bounds, BorderSize, BorderColor);
  end;
end;

procedure TSlackGUI.RenderTextAt(FObject: TFormObject; X,Y: Int32); static;
begin
  SlackGUI.ApplyStyle(FObject.Styles);
  SlackGUI.Image.GetCanvas.TextOut(X, Y, TTextObject(FObject)^.Text);
end;

procedure TSlackGUI.RenderText(FObject: TFormObject); static;
begin
  RenderTextAt(FObject, FObject.Bounds.Left, FObject.Bounds.Top);
end;

procedure TSlackGUI.RenderTitlebar(FObject: TFormObject); static;
begin
  SlackGUI.RenderBasicBlock(FObject);
  SlackGUI.RenderTextAt(FObject, FObject.Bounds.Left+15, FObject.Bounds.Top+5);
end;


procedure TSlackGUI.RenderTextButton(FObject: TFormObject); static;
begin
  SlackGUI.RenderBasicBlock(FObject);
  SlackGUI.RenderTextAt(FObject, FObject.Bounds.Left, FObject.Bounds.Top);
end;

procedure TSlackGUI.RenderCheckbox(FObject: TFormObject); static;
var
  Bounds: TRect;
  TextWidth,TextHeight: Int32;
begin
  with FObject.Styles do
  begin
    Bounds := FObject.Bounds;

    SlackGUI.Image.GetCanvas.DrawSolidRect(Bounds, Background);
    SlackGUI.Image.GetCanvas.DrawBorder(Bounds, BorderSize, BorderColor);
    
    if TCheckboxObject(FObject)^.IsChecked then
      SlackGUI.Image.GetCanvas.DrawSolidRect(Bounds.PreExpand(-3), BorderColor);
      
    SlackGUI.ApplyStyle(FObject.Styles);
    SlackGUI.RenderTextAt(FObject, FObject.Bounds.Right+8, FObject.Bounds.Top-2);
  end;
end;

procedure TSlackGUI.RenderLabelBlock(FObject: TFormObject); static;
var
  Bounds: TRect;
  BGIMG: TBitmap;
begin
  with FObject.Styles do
  begin
    SlackGUI.ApplyStyle(FObject.Styles);
    
    Bounds := FObject.Bounds;
    Bounds.Top += SlackGUI.Image.GetCanvas.TextHeight(TTextObject(FObject)^.Text) div 2;
    
    SlackGUI.Image.GetCanvas.DrawSolidRect(Bounds, Background);
    BGIMG := SlackGUI.LoadImage(BackgroundImage);
    if (BGIMG <> nil) then SlackGUI.Image.GetCanvas.DrawBitmap(Bounds, BGIMG, BackgroundImageFit);
    SlackGUI.Image.GetCanvas.DrawBorder(Bounds, BorderSize, BorderColor);
      
    SlackGUI.Image.GetCanvas.TextOut(FObject.Bounds.Left+10, FObject.Bounds.Top, TTextObject(FObject)^.Text);
  end;
end;


// ----------------------------------------------------------------------------
// RUN RENDERING

procedure TSlackGUI.RenderFrom(Obj: TFormObject); static;
var i:Int32;
begin
  Obj^.RenderProc(Obj);
  for i:=0 to High(Obj^.Children) do
    RenderFrom(Obj^.Children[i]);
end;

procedure TSlackGUI.Render(_,Sender:TObject); static;
begin
  if (SlackGUI.ObjectCount <= 0) then Exit;

  if (SlackGUI.FocusObject = nil) then
    SlackGUI.FocusObject := SlackGUI.Objects[0];

  if (SlackGUI.FocusObject^.Typ = otTitlebar) and (TTitlebarObject(SlackGUI.FocusObject)^.IsDragging) then
    Exit;

  SlackGUI.Timer.SetEnabled(False);
  RenderFrom(SlackGUI.Objects[0]);
  SlackGUI.Timer.SetEnabled(True);
end;