unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LogInfo(LogFileName,LogInfo:string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i:Integer;
begin
  for i := 0 to 10000 do
  begin
    LogInfo('test.log','≤‚ ‘'+IntToStr(i));
  end;

end;

procedure TForm1.LogInfo(LogFileName, LogInfo: string);
var
  Lst:TStringList;
begin
  Lst := TStringList.Create;
  if FileExists(LogFileName) then
  begin
    Lst.LoadFromFile(LogFileName);
  end;
  Lst.Insert(0,FormatDateTime('yyyy-MM-dd hh:mm:ss.zzz',Now) + '------' + LogInfo);
  Lst.SaveToFile(LogFileName);
  Lst.Free;
end;

end.
