program Project1;

uses
  Forms,
  Registry,
  Windows,
  Unit1 in 'Unit1.pas' {Form1};

  
const
  LeftButton = '0';
  RightButton = '1';
  VaueToRead = 'SwapMouseButtons';

{$R *.res}

begin
  //ÇÐ»»Êó±ê×óÓÒ°´¼ü begin
  with TRegistry.Create do
  begin
    try
      if OpenKey('Control Panel/Mouse',False) then
      begin
        if ValueExists(VaueToRead) then
          if ReadString(VaueToRead) = LeftButton then
          begin
            SwapMouseButton(True);
            WriteString(VaueToRead,RightButton);
          end
          else
          begin
            SwapMouseButton(False);
            WriteString(VaueToRead,LeftButton);
          end;
        CloseKey;
      end;
    finally
      Free;
    end;
  end;
  //ÇÐ»»Êó±ê×óÓÒ°´¼ü end

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
