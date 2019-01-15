object Form1: TForm1
  Left = 329
  Top = 230
  Width = 863
  Height = 525
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 56
    Top = 32
    Width = 353
    Height = 401
    RowCount = 15
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    OnMouseUp = StringGrid1MouseUp
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object DBGrid1: TDBGrid
    Left = 432
    Top = 32
    Width = 401
    Height = 401
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'test1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'test2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'test3'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'test4'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'test5'
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 472
  end
  object Query1: TQuery
    DatabaseName = 'DBDEMOS'
    SessionName = 'Default'
    SQL.Strings = (
      'select * from dbdemeos')
    Left = 432
  end
  object ADOQuery1: TADOQuery
    DataSource = DataSource1
    Parameters = <>
    Left = 392
  end
end
