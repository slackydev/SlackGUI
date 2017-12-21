type
  EFormObjectType = (otNone, otTitlebar, otText, otButton, otCheckbox, otRadios, otLabel, otInputArea);
  EFitImageMode   = (fitNone, fitPerfect, fitOverflow);
  EBoundsPosition = (bpAbsolute, bpRelative);

  TFormObject = ^TFormObjectRec;

  TMouseEvt     = procedure(Sender: TFormObject; Button: TMouseButton; Shift: TShiftState; X,Y: Int32);
  TMouseMoveEvt = procedure(Sender: TFormObject; Shift: TShiftState; X,Y: Int32);
  TKeyEvt       = procedure(Sender: TFormObject; Key: Word; Shift: TShiftState);
  TNotifyEvt    = procedure(Sender: TFormObject);

  TStyleSet = packed record
    Background: TColor;
    BackgroundImage: ShortString;
    BackgroundImageFit: EFitImageMode;
    
    BorderColor: TColor;
    BorderSize: Int32;

    FontStyle: TFontStyles;
    FontColor: TColor;
    FontSize:  Int32;
    FontName:  ShortString;

    TextWrap: Boolean;
    Overflow: Boolean;

    Align: TAlign;
  end;

  TFormObjectRec = record
    Index: Int32;
    Typ: EFormObjectType;
    Parent: TFormObject;
    Children: array of TFormObject;

    Name: String;
    Bounds: TRect;
    Position: EBoundsPosition;
    Styles, Styles2, Styles3: TStyleSet;

    RenderProc:  procedure(obj: TFormObject);

    __IsHolding: Boolean;
    __OnMouseDown,  OnMouseDown: TMouseEvt;
    __OnMouseUp,    OnMouseUp:   TMouseEvt;
    __OnMouseMove,  OnMouseMove: TMouseMoveEvt;
    __OnKeyDown,    OnKeyDown:   TKeyEvt;
    __OnKeyUp,      OnKeyUp:     TKeyEvt;

    __OnMouseEnter, OnMouseEnter: TNotifyEvt;
    __OnMouseLeave, OnMouseLeave: TNotifyEvt;
    __OnClick, OnClick: TNotifyEvt;
  end;

  TTextObject = ^TTextObjectRec;
  TTextObjectRec = record(TFormObjectRec)
    Text: String;
  end;
  
  TTitlebarObject = ^TTitlebarObjectRec;
  TTitlebarObjectRec = record(TTextObjectRec)
    IsDragging: Boolean;
    DragStartX, DragStartY: Int32;
  end;

  TButtonObject = ^TButtonObjectRec;
  TButtonObjectRec = record(TTextObjectRec)
    IsDown: Boolean;
  end;
  
  TCheckBoxObject = ^TCheckBoxObjectRec;
  TCheckBoxObjectRec = record(TTextObjectRec)
    IsChecked: Boolean;
  end;

  TLabelObject    = ^TLabelObjectRec;
  TLabelObjectRec = type TTextObjectRec;

  


function Rect(Left,Top,Right,Bottom: Int32): TRect;
begin
  Result := [Left,Top,Right,Bottom];
end;

function TRect.Width: Int32; constref;
begin
  Result := Self.Right-Self.Left+1;
end;

function TRect.Height: Int32; constref;
begin
  Result := Self.Bottom-Self.Top+1;
end;

function TRect.Expand(W,H: Int32): TRect;
begin
  Result := Self;
  Self := [Left-W,Top-H,Right+W,Bottom+H];
end;

function TRect.Expand(Z: Int32): TRect; overload;
begin
  Result := Self;
  Self := [Left-Z,Top-Z,Right+Z,Bottom+Z];
end;

function TRect.PreExpand(W,H: Int32): TRect;
begin
  Self := [Left-W,Top-H,Right+W,Bottom+H];
  Result := Self;
end;

function TRect.PreExpand(Z: Int32): TRect; overload;
begin
  Self := [Left-Z,Top-Z,Right+Z,Bottom+Z];
  Result := Self;
end;
