unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ShellAPI;

{$R *.dfm}

procedure ToRecycle(AHandle:THandle;AFileName:string);
var
  SHFileOpStruct:TShFileOpStruct;
begin
  with ShFileOpStruct do
  begin
    Wnd:=AHandle;
    wFunc:=FO_DELETE;
    pFrom:=PChar(AFileName);
    fFlags:=FOF_ALLOWUNDO;
  end;
  SHFileOperation(SHFileOpStruct);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  SF:TSHFileOpStruct;
  fname:string;
begin//单个
  fname:='C:\Users\Test-YLL\Desktop\新建文本文档.txt';
  SF.Wnd:=0;
  SF.wFunc:=FO_DELETE;
  SF.pFrom:=PChar(fname);
  SF.pTo:='';
  sf.fFlags:=FOF_ALLOWUNDO;
  SHFileOperation(SF);

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  SF:TSHFileOpStruct;
  fname:string;
begin//多个
  fname:='C:\Users\Test-YLL\Desktop\测试2.txt'#0'C:\Users\Test-YLL\Desktop\测试.txt';
  SF.Wnd:=0;
  SF.wFunc:=FO_DELETE;
  SF.pFrom:=PChar(fname);
  SF.pTo:='';
  sf.fFlags:=FOF_ALLOWUNDO;
  SHFileOperation(SF);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ToRecycle(0,'C:\Users\Test-YLL\Desktop\新建文本文档.txt');
end;

end.
