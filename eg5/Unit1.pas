unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, DBTables, ADODB;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Query1: TQuery;
    ADOQuery1: TADOQuery;
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,FoldNo,FCurrNo:Integer;
begin//��shift����ѡ
  {if Button = mbLeft then
  begin
    if not (ssShift in Shift) then
    begin
      FoldNo:=StringGrid1.Row;
    end;

    if ssShift in  Shift then
    begin
      FCurrNo:=StringGrid1.Row;

      if FoldNo < FCurrNo then
      begin
        for i := FoldNo to FCurrNo do
        begin
          //StringGrid1
        end;
      end
      else
      begin
        for i := FCurrNo to FoldNo do
        begin
          //StringGrid1
        end;
      end;

    end;

  end;}

end;

procedure TForm1.FormShow(Sender: TObject);
var
  i,j:Integer;
begin
  {with StringGrid1 do
    begin
      Cells[1,0] := 'Column 1';
      Cells[2,0] := 'Column 2';
      Cells[3,0] := 'Column 3';
      Cells[4,0] := 'Column 4';
      Cells[0,1] := 'Row 1';
      Cells[1,1] := 'Object';
      Cells[2,1] := 'Pascal';
      Cells[3,1] := 'is';
      Cells[4,1] := 'excellent';
      Cells[0,2] := 'Row 2';
      Cells[1,2] := 'Delphi';
      Cells[2,2] := 'is';
      Cells[4,2] := 'RAD';
    end;
  end;}

  with StringGrid1 do
  begin
      Cells[1,0] := 'Column 1';
      Cells[2,0] := 'Column 2';
      Cells[3,0] := 'Column 3';
      Cells[4,0] := 'Column 4';

      for i := 0 to 10 do
      begin
        Cells[0,i] := 'Row'+IntToStr(i);
        Cells[1,i] := 'Object';
        Cells[2,i] := 'Pascal';
        Cells[3,i] := 'is';
        Cells[4,i] := 'excellent';
      end;
  end;

  {with dbgrid1 do
  begin
    DataSource.DataSet.Insert;
    //datasource.dataset.append;//�����
    //datasource.dataset.fieldbyname('test1').Value:='xxx';//��ֵ
    columns.Grid.Fields[0].value:='';
    DataSource.DataSet.Post;
  end; }

end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
{var i :integer;
begin
  if gdSelected in State then Exit;
//�����ͷ������ͱ�����ɫ��
    for i :=0 to (Sender as TDBGrid).Columns.Count-1 do
    begin
      (Sender as TDBGrid).Columns[i].Title.Font.Name :='����'; //����
      (Sender as TDBGrid).Columns[i].Title.Font.Size :=9; //�����С
      (Sender as TDBGrid).Columns[i].Title.Font.Color :=$000000ff; //������ɫ(��ɫ)
      (Sender as TDBGrid).Columns[i].Title.Color :=$0000ff00; //����ɫ(��ɫ)
    end;
//���иı����񱳾�ɫ��
  if Query1.RecNo mod 2 = 0 then
    (Sender as TDBGrid).Canvas.Brush.Color := clInfoBk //���屳����ɫ
  else
    (Sender as TDBGrid).Canvas.Brush.Color := RGB(191, 255, 223); //���屳����ɫ
//���������ߵ���ɫ��
    DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  with (Sender as TDBGrid).Canvas do //�� cell �ı߿�
  begin
    Pen.Color := $00ff0000; //���廭����ɫ(��ɫ)
    MoveTo(Rect.Left, Rect.Bottom); //���ʶ�λ
    LineTo(Rect.Right, Rect.Bottom); //����ɫ�ĺ���
    Pen.Color := $0000ff00; //���廭����ɫ(��ɫ)
    MoveTo(Rect.Right, Rect.Top); //���ʶ�λ
    LineTo(Rect.Right, Rect.Bottom); //����ɫ������
  end;
end;}
var i:integer;
begin
  if gdSelected in State then Exit;  //���иı����񱳾�ɫ�� 
    if adoQuery1.RecNo mod 2 = 0 then
      (Sender as TDBGrid).Canvas.Brush.Color := clinfobk //���屳����ɫ
  else
    (Sender as TDBGrid).Canvas.Brush.Color := RGB(191, 255, 223);  //���屳����ɫ
  //���������ߵ���ɫ��
  DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  with (Sender as TDBGrid).Canvas do //�� cell �ı߿�
  begin
    Pen.Color := $00ff0000; //���廭����ɫ(��ɫ)
    MoveTo(Rect.Left, Rect.Bottom); //���ʶ�λ
    LineTo(Rect.Right, Rect.Bottom); //����ɫ�ĺ���
    Pen.Color := clbtnface; //���廭����ɫ(��ɫ)
    MoveTo(Rect.Right, Rect.Top); //���ʶ�λ
    LineTo(Rect.Right, Rect.Bottom); //����ɫ
  end;
end; 

end.
