var __WRITE_STRING: string;
procedure _Write(str: String); override;
begin
  __WRITE_STRING += str;
end;

procedure _WriteLn; override;
begin
  client.WriteLn(__WRITE_STRING);
  __WRITE_STRING := '';
end;