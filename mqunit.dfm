object fMQ: TfMQ
  Left = 0
  Top = 0
  Caption = 'MQ API'
  ClientHeight = 677
  ClientWidth = 1548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = MyInit
  PixelsPerInch = 120
  TextHeight = 17
  object btnConnect: TButton
    Left = 335
    Top = 15
    Width = 304
    Height = 35
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Connect to Qmgr'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object edQMN: TEdit
    Left = 32
    Top = 9
    Width = 273
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Queue Manager Name'
  end
  object edCH: TEdit
    Left = 659
    Top = 15
    Width = 221
    Height = 36
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'Connection Handle'
  end
  object lbEvents: TListBox
    Left = 32
    Top = 324
    Width = 1486
    Height = 336
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Lucida Console'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 3
  end
  object edQUNM: TEdit
    Left = 32
    Top = 75
    Width = 273
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'Queue Name'
  end
  object btnOpen: TButton
    Left = 335
    Top = 80
    Width = 305
    Height = 33
    Caption = 'Open Queue'
    TabOrder = 5
    OnClick = btnOpenClick
  end
  object edObjH: TEdit
    Left = 656
    Top = 80
    Width = 225
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'Object Handle'
  end
  object Timer1: TTimer
    Left = 920
    Top = 16
  end
end
