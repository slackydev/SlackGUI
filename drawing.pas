procedure TCanvas.DrawBitmap(Bounds: TRect; BMP: TBitmap; DrawMode:EFitImageMode); constref;
var
  TMP: TBitmap;
  newW, newH: Int32;
begin
  if DrawMode = fitPerfect then
    self.CopyRect(Bounds, BMP.GetCanvas, [0,0,BMP.GetWidth-1,BMP.GetHeight-1])
  else
  begin
    TMP.Init();
    TMP.Assign(BMP);

    newW := Min(Bounds.Width, BMP.GetWidth);
    newH := Min(Bounds.Height, BMP.GetHeight);
    Bounds := [Bounds.Left, Bounds.Top, Bounds.Left+newW-1, Bounds.Top+newH-1];

    Self.CopyRect(Bounds, TMP.GetCanvas, [0,0, newW-1, newH-1]);
    TMP.Free();
  end;
end;

procedure TCanvas.DrawSolidRect(B:TRect; color:Int32); constref;
begin
  self.GetBrush.SetColor(color);
  self.FillRect(B.Left,B.Top,B.Right,b.Bottom);
end;

procedure TCanvas.DrawBorder(B:TRect; width, color:Int32); constref;
begin
  SlackGUI.Image.GetCanvas.GetPen.SetColor(color);
  SlackGUI.Image.GetCanvas.GetBrush.SetStyle(bsClear);
  for 1 to width do
    SlackGUI.Image.GetCanvas.Rectangle(B.Expand(-1,-1));
end;