unit inAccessNeMo_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Math,
  Spin, ExtDlgs, LCLType, Menus, zstream, TypInfo, Rtti;

type

  { TinAccessNeMo_frm }

  TinAccessNeMo_frm = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button_left: TButton;
    Button_right: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Memo_SaveToTxT: TMemo;
    OpenDialog1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    Panel12: TImage;
    Panel2: TPanel;
    Panel11: TPanel;
    PopupMenu11: TPopupMenu;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Timer1: TTimer;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button_leftClick(Sender: TObject);
    procedure Button_rightClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Panel11MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Panel11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Panel12MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure ScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    Panel1image: TImage; // TGraphic;
    tmpbmp: Tbitmap; // timage;//TGraphic;
    function drawcircle(X: integer; Y: integer; R: integer): integer;
    function drawcircle2(X: integer; Y: integer; R: integer): integer;
    function drawcircle3(X: integer; Y: integer; R: integer): integer;
    function drawcircle4(X: integer; Y: integer; R: integer): integer;
    function drawcircle33(X: integer; Y: integer; R: integer): integer;
    function drawcircle333(X: integer; Y: integer; R: integer): integer;
    function drawsea(): integer;
    function drawseaBlue(): integer;
  end;

var
  inAccessNeMo_frm: TinAccessNeMo_frm;
  frompt, topt: TPoint;

implementation

uses piapublic, msgshow;
  {$R *.lfm}

function UnicodeToASCII(ansi: ansistring): string;
var
  ws: widestring;
  i: integer;
  rs: string;
begin
  ws := ansi;
  for i := 1 to Length(ws) do
  begin
    if pbyte(integer(@ws[i]) + 1)^ = 0 then
      rs := rs + ws[i]
    else
      rs := rs + '&#' + IntToStr(PWord(@ws[i])^) + ';';
  end;
  Result := rs;
end;

function strtoascii(var inputAnsi: string): integer;
  //字符串转换为ascii值,转换值是一个各单独值相加后的结果
var
  Ansitemp, i, OutPutAnsi: integer;    //28436
begin
  OutPutAnsi := 0;
  for i := 0 to Length(inputAnsi) do
  begin
    Ansitemp := Ord(inputAnsi[i]);
    outputansi := OutPutAnsi + Ansitemp;
  end;
  Result := OutPutAnsi;
end;
{ TinAccessNeMo_frm }
//平面「难抵极/尼莫点」近似计算小软件  Version 1.0 作者：三界火宅人-阿莫伽-amogha-vairocana 2021/05/01
//每个按钮可以用右键单击来查看帮助说明
//载入地图
//重载刷新
//描绘海岸线
//左键    右键
//停止描绘
//叠加式载入
//覆盖式载入
//载入海岸线
//保存海岸线
//获取点坐标
//设置圆半径
//以点画圆
//设置离岸距离
//离岸染色
//演示MP4
//说明
procedure TinAccessNeMo_frm.FormShow(Sender: TObject);
begin
  //平面「难抵极/尼莫点」近似计算小软件  Version 1.0 作者：三界火宅人-阿莫伽-amogha-vairocana 2021/05/01
  self.Caption :=
    '平面「难抵极/尼莫点」近似计算小软件  Version 1.0 作者：三界火宅人-阿莫伽-amogha-vairocana 2021/05/01';
end;



procedure TinAccessNeMo_frm.Panel11MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
var
  ii, jj: integer;
begin
  // if 1=2 then

  if piapublic.beginflag = 1 then
  begin
    if piapublic.beginflag1 = 1 then
    begin
      Panel1.Canvas.Pixels[X, Y] := clblue;
      // 证实不连续
      ar[X, Y] := clblue;
      if 1 = 2 then
      begin
        // RzPanel11.Canvas.Brush.Color:=clblue;
        Panel11.Canvas.Pen.Color := clblue;
        topt.X := X;
        topt.Y := Y;
        Panel11.Canvas.LineTo(topt.X, topt.Y);
        for ii := min(frompt.X, topt.X) to max(frompt.X, topt.X) do
          for jj := min(frompt.Y, topt.Y) to max(frompt.Y, topt.Y) do
          begin
            if Panel11.Canvas.Pixels[ii, jj] = clblue then
              ar[ii][jj] := clblue;

          end;
        frompt.X := topt.X;
        frompt.Y := topt.Y;
      end;
    end;
  end;
  if 1 = 2 then

    if piapublic.beginflag2 = 1 then
    begin
      // rzpanel11.Canvas.MoveTo(frompt.x, frompt.y);
      // rzpanel11.Canvas.LineTo(x,y);
      if X >= frompt.X then
      begin
        if Y >= frompt.Y then
        begin

        end
        else
        begin

        end;
      end
      else
      begin
        if Y >= frompt.Y then
        begin

        end
        else
        begin

        end;
      end;
    end;
  // if piapublic.beginflag2 = 1 then

end;

procedure TinAccessNeMo_frm.Panel11MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  ii, jj: integer;
begin
  // timer1.Enabled:=false;
  if piapublic.beginflag = 1 then
  begin
    if Button = mbLeft then
      if piapublic.beginflag2 = 0 then
      begin

        if piapublic.beginflag1 = 0 then
        begin
          piapublic.beginflag1 := 1;
          // timer1.Enabled:=true;
          //self.SpeedButton1.Down := true;

          Panel1.Canvas.Pixels[X, Y] := clblue;
          // 证实不连续
          ar[X, Y] := clblue;
        end
        else
        begin
          piapublic.beginflag1 := 0;
          // timer1.Enabled:=false;
          //self.SpeedButton1.Down := false;
        end;
      end;
    if Button = mbRight then
      if piapublic.beginflag1 = 0 then
      begin

        if piapublic.beginflag2 = 0 then
        begin
          piapublic.beginflag2 := 1;
          //self.SpeedButton2.Down := true;
          frompt.X := X;
          frompt.Y := Y;
          Panel1.Canvas.Pixels[X, Y] := clblue;
          ar[X][Y] := clblue;
          Panel1.Canvas.MoveTo(frompt.X, frompt.Y);

        end
        else
        begin
          // RzLine1.Visible := false;
          piapublic.beginflag2 := 0;
          //self.SpeedButton2.Down := false;
          topt.X := X;
          topt.Y := Y;

          // rzpanel11.Canvas.LineTo(topt.x,topt.y);
          // RzPanel1.Canvas.Pixels[X, Y] := clblue;
          // if 1 = 2 then
          begin
            // RzPanel11.Canvas.Brush.Color:=clblue;
            Panel1.Canvas.Pen.Color := clblue;
            topt.X := X;
            topt.Y := Y;
            Panel1.Canvas.LineTo(topt.X, topt.Y);
            for ii := min(frompt.X, topt.X) to max(frompt.X, topt.X) do
              for jj := min(frompt.Y, topt.Y) to max(frompt.Y, topt.Y) do
              begin
                if Panel1.Canvas.Pixels[ii, jj] = clblue then
                  ar[ii][jj] := clblue;

              end;
            frompt.X := topt.X;
            frompt.Y := topt.Y;
          end;
          // ar[X, Y] := clblue;
        end;
      end;
  end;
  if self.Tag = 111 then
  begin
    self.Caption := IntToStr(X) + ':' + IntToStr(Y);
    self.Panel11.Tag := X;
    self.ScrollBox1.Tag := Y;
  end;
  if piapublic.beginflag = 0 then
    if Button = mbRight then
      PopupMenu11.Popup(X, Y);

  if Button = mbLeft then
  begin
    //if not Button9.ThemeAware then // RzButton9
    begin
      spinEdit1.Text := IntToStr(X);
      spinEdit2.Text := IntToStr(Y);
      //RzButton9.ThemeAware := true;
      screen.Cursor := crArrow;
      Panel1.Canvas.Pixels[X, Y] := clred;
    end;
  end;
end;

procedure TinAccessNeMo_frm.Panel12MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
var
  tt: TPoint;
  MousePos: TPoint;
begin
  if ((beginflag mod 2) = 1) then
  begin

    //Winapi.Windows.GetCursorpos(tt);
    // RzPanel1.Canvas.Pixels[tt.X, tt.Y] := clblue;
    // 证实不连续
    // 获取鼠标屏幕坐标
    MousePos := Mouse.CursorPos;
    //Label1.Caption := 'X坐标: ' + IntToStr(MousePos.X);
    //Label2.Caption := 'Y坐标: ' + IntToStr(MousePos.Y);
    //tt := MousePos;
    tt := panel12.ScreenToControl(MousePos);
    ar[tt.X, tt.Y] := clblue;
    panel12.Canvas.Pixels[tt.X, tt.Y] := clblue;
  end;
end;

procedure TinAccessNeMo_frm.ScrollBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if piapublic.beginflag = 1 then
  begin
    if Button = mbLeft then
    begin

      if piapublic.beginflag1 = 0 then
        piapublic.beginflag1 := 1
      else
        piapublic.beginflag1 := 0;
    end;
    if Button = mbRight then
    begin

      if piapublic.beginflag2 = 0 then
        piapublic.beginflag2 := 1
      else
        piapublic.beginflag2 := 0;
    end;
  end;
end;

procedure TinAccessNeMo_frm.Timer1Timer(Sender: TObject);
var
  tt: TPoint;
  MousePos: TPoint;
begin
  //Winapi.Windows.GetCursorpos(tt);
  // RzPanel1.Canvas.Pixels[tt.X, tt.Y] := clblue;
  // 证实不连续
  // 获取鼠标屏幕坐标
  MousePos := Mouse.CursorPos;
  //Label1.Caption := 'X坐标: ' + IntToStr(MousePos.X);
  //Label2.Caption := 'Y坐标: ' + IntToStr(MousePos.Y);
  tt := MousePos;
  ar[tt.X, tt.Y] := clblue;
end;


function TinAccessNeMo_frm.drawcircle(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if Panel1image.Canvas.Pixels[X, Y] <> clblack then
    Panel1image.Canvas.Pixels[X, Y] := cc;
  Panel1image.Canvas.Brush.Color := cc;
  Panel1image.Canvas.Brush.Style := bsSolid;

  for i := 1 to R do
  begin
    for j := (-1) * i to i do
    begin
      k := piapublic.getY(j, i, 1);
      for jj := (-1) * k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then

          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      for jj := k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      k := piapublic.getY(j, i, -1);
      for jj := k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      for jj := (-1) * k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
    end;
  end;

end;

function TinAccessNeMo_frm.drawcircle2(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if Panel1image.Canvas.Pixels[X, Y] <> clblack then
    Panel1image.Canvas.Pixels[X, Y] := cc;
  Panel1image.Canvas.Brush.Color := cc;
  Panel1image.Canvas.Brush.Style := bsSolid;

  // for i := 1 to R do
  i := R;
  begin
    for j := (-1) * i to i do
    begin
      k := piapublic.getY(j, i, 1);
      for jj := (-1) * k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then

          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      for jj := k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      k := piapublic.getY(j, i, -1);
      for jj := k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
      for jj := (-1) * k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + k] = cc) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y + k] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + k] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + k] := cc;
      end;
    end;
  end;

end;

function TinAccessNeMo_frm.drawcircle3(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if Panel1image.Canvas.Pixels[X, Y] <> clblack then
    Panel1image.Canvas.Pixels[X, Y] := cc;
  Panel1image.Canvas.Brush.Color := cc;
  Panel1image.Canvas.Brush.Style := bsSolid;

  i := R;
  begin
    for j := (-1) * i to i do
    begin
      k := piapublic.getY(j, i, 1);
      for jj := (-1) * k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] <> clblack then

          Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
      end;
      for jj := k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
      end;
      k := piapublic.getY(j, i, -1);
      for jj := k to 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
      end;
      for jj := (-1) * k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] = clblack then
          continue;
        if Panel1image.Canvas.Pixels[X + j, Y + jj] <> clblack then
          Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
      end;
    end;
  end;

end;

function TinAccessNeMo_frm.drawcircle4(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if ar[X, Y] <> clblue then
  begin
    ar[X, Y] := cc;
    //Panel12.Canvas.Pixels[X, Y] := cc;
  end;
  // Panel12.Canvas.Brush.Color := cc;
  // Panel12.Canvas.Brush.Style := bsSolid;

  //application.ProcessMessages;
  i := R;
  begin
    for j := 0 to i do
    begin
      k := piapublic.getY(j, i, 1);
      if (j > k) then
        break;
      for jj := k downto 0 do
      begin
        // if (ar[X + j, Y + jj] = cc) then
        // break;
        if (j > jj) then
          break;

        if isover(X + j) and isover(Y - jj) then
          if ar[X + j, Y - jj] <> clblue then
          begin
            ar[X + j, Y - jj] := cc;
            // Panel12.Canvas.Pixels[X + j, Y - jj] := cc;
          end;
        if isover(X + jj) and isover(Y - j) then
          if ar[X + jj, Y - j] <> clblue then
          begin
            ar[X + jj, Y - j] := cc;
            // Panel12.Canvas.Pixels[X + jj, Y - j] := cc;
          end;

        if isover(X + j) and isover(Y + jj) then
          if ar[X + j, Y + jj] <> clblue then
          begin
            ar[X + j, Y + jj] := cc;
            //  Panel12.Canvas.Pixels[X + j, Y + jj] := cc;
          end;
        if isover(X + jj) and isover(Y + j) then
          if ar[X + jj, Y + j] <> clblue then
          begin
            ar[X + jj, Y + j] := cc;
            // Panel12.Canvas.Pixels[X + jj, Y + j] := cc;
          end;

        if isover(X - j) and isover(Y - jj) then
          if ar[X - j, Y - jj] <> clblue then
          begin
            ar[X - j, Y - jj] := cc;
            // Panel12.Canvas.Pixels[X - j, Y - jj] := cc;
          end;
        if isover(X - jj) and isover(Y - j) then
          if ar[X - jj, Y - j] <> clblue then
          begin
            ar[X - jj, Y - j] := cc;
            // Panel12.Canvas.Pixels[X - jj, Y - j] := cc;
          end;
        if isover(X - j) and isover(Y + jj) then
          if ar[X - j, Y + jj] <> clblue then
          begin
            ar[X - j, Y + jj] := cc;
            //Panel12.Canvas.Pixels[X - j, Y + jj] := cc;
          end;
        if isover(X - jj) and isover(Y + j) then
          if ar[X - jj, Y + j] <> clblue then
          begin
            ar[X - jj, Y + j] := cc;
            //Panel12.Canvas.Pixels[X - jj, Y + j] := cc;
          end;

      end;

    end;
  end;

end;

function TinAccessNeMo_frm.drawcircle33(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if Panel1image.Canvas.Pixels[X, Y] <> clblue then
    Panel1image.Canvas.Pixels[X, Y] := cc;
  Panel1image.Canvas.Brush.Color := cc;
  Panel1image.Canvas.Brush.Style := bsSolid;

  i := R;
  begin
    for j := 0 to i do
    begin
      k := piapublic.getY(j, i, 1);
      if (j > k) then
        break;
      for jj := k downto 0 do
      begin
        if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
          break;
        if (j > jj) then
          break;
        if Panel1image.Canvas.Pixels[X + j, Y - jj] <> clblue then
          Panel1image.Canvas.Pixels[X + j, Y - jj] := cc;
        if Panel1image.Canvas.Pixels[X + jj, Y - j] <> clblue then
          Panel1image.Canvas.Pixels[X + jj, Y - j] := cc;

        if Panel1image.Canvas.Pixels[X + j, Y + jj] <> clblue then
          Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
        if Panel1image.Canvas.Pixels[X + jj, Y + j] <> clblue then
          Panel1image.Canvas.Pixels[X + jj, Y + j] := cc;

        if Panel1image.Canvas.Pixels[X - j, Y - jj] <> clblue then
          Panel1image.Canvas.Pixels[X - j, Y - jj] := cc;
        if Panel1image.Canvas.Pixels[X - jj, Y - j] <> clblue then
          Panel1image.Canvas.Pixels[X - jj, Y - j] := cc;

        if Panel1image.Canvas.Pixels[X - j, Y + jj] <> clblue then
          Panel1image.Canvas.Pixels[X - j, Y + jj] := cc;
        if Panel1image.Canvas.Pixels[X - jj, Y + j] <> clblue then
          Panel1image.Canvas.Pixels[X - jj, Y + j] := cc;

      end;

    end;
  end;

end;

function TinAccessNeMo_frm.drawcircle333(X: integer; Y: integer; R: integer): integer;
var
  z, i, j, k, jj: integer;
  cc: integer;
begin

  cc := clred;
  if Panel1image.Canvas.Pixels[X, Y] <> clblue then
  begin
    Panel1image.Canvas.Pixels[X, Y] := cc;
    if isover(X) and isover(Y) then
      ar[X, Y] := cc;
  end;
  Panel1image.Canvas.Brush.Color := cc;
  Panel1image.Canvas.Brush.Style := bsSolid;

  i := R;
  begin
    for j := 0 to i do
    begin
      k := piapublic.getY(j, i, 1);
      if (j > k) then
        break;
      for jj := k downto 0 do
      begin
        // if (Panel1image.Canvas.Pixels[X + j, Y + jj] = cc) then
        if isover(X + j) and isover(Y + jj) then
          if (ar[X + j, Y + jj] = cc) then
            break;
        if (j > jj) then
          break;
        if isover(X + j) and isover(Y - jj) then
          if ar[X + j, Y - jj] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X + j, Y - jj] := cc;
            ar[X + j, Y - jj] := cc;
          end;
        if isover(X + jj) and isover(Y - j) then
          if ar[X + jj, Y - j] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X + jj, Y - j] := cc;
            ar[X + jj, Y - j] := cc;
          end;
        if isover(X + j) and isover(Y + jj) then
          if ar[X + j, Y + jj] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X + j, Y + jj] := cc;
            ar[X + j, Y + jj] := cc;
          end;
        if isover(X + jj) and isover(Y + j) then
          if ar[X + jj, Y + j] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X + jj, Y + j] := cc;
            ar[X + jj, Y + j] := cc;
          end;

        if isover(X - j) and isover(Y - jj) then
          if ar[X - j, Y - jj] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X - j, Y - jj] := cc;
            ar[X - j, Y - jj] := cc;
          end;
        if isover(X - jj) and isover(Y - j) then
          if Panel1image.Canvas.Pixels[X - jj, Y - j] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X - jj, Y - j] := cc;
            ar[X - jj, Y - j] := cc;
          end;
        if isover(X - j) and isover(Y + jj) then
          if ar[X - j, Y + jj] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X - j, Y + jj] := cc;
            ar[X - j, Y + jj] := cc;
          end;
        if isover(X - jj) and isover(Y + j) then
          if ar[X - jj, Y + j] <> clblue then
          begin
            Panel1image.Canvas.Pixels[X - jj, Y + j] := cc;
            ar[X - jj, Y + j] := cc;
          end;

      end;

    end;
  end;

end;

function TinAccessNeMo_frm.drawsea(): integer;
var
  i, j: integer;
begin
  Result := 0;
  for i := 0 to 3000 do
  begin

    for j := 0 to 3000 do
    begin
      // ar[i][j]:=strtoint(qq[j]);
      if ar[i][j] <> 0 then
        // Panel1image.Canvas.Pixels[i, j] := ar[i][j];
        Panel12.Canvas.Pixels[i, j] := ar[i][j];
    end;

  end;

  Result := 1;
end;

function TinAccessNeMo_frm.drawseaBlue(): integer;
var
  i, j: integer;
begin
  Result := 0;
  for i := 0 to 3000 do
  begin

    for j := 0 to 3000 do
    begin
      // ar[i][j]:=strtoint(qq[j]);
      if ar[i][j] = clblue then
        Panel1.Canvas.Pixels[i, j] := ar[i][j];
      if ar[i][j] = clred then
        ar[i][j] := 0;
    end;

  end;

  Result := 1;
end;


procedure TinAccessNeMo_frm.Button1Click(Sender: TObject);
//#36733#20837#22320#22270 //载入地图  RzButton5
// if self.OpenDialog1.Execute then
var
  ii, jj: integer;
begin
  // if self.OpenDialog1.Execute then
  if self.OpenPictureDialog1.Execute then
  begin
    try
      //self.Panel11.Align := alnone;
      //Image1.Align:=alnone;

      //Image1.Left := 0;
      //Image1.top := 0;
      //Panel12.Picture.Bitmap.AlphaFormat := afPremultiplied;

      Panel12.Picture.LoadFromFile(self.OpenPictureDialog1.FileName);
      // A TImage may hold a bitmap, icon, PNG, GIF or JPEG image.

      if tmpbmp <> nil then
        tmpbmp.FreeImage;
      // tmpbmp:=Tbitmap.Create;
      // tmpbmp.Assign(Panel12.Picture.Graphic);
      Image1.Picture.Bitmap.Assign(Panel12.Picture.Graphic);


      Panel1image := Image1;
      //Panel11.Width := Image1.Width;
      //Panel11.Height := Image1.Height;

      //Panel11.Width :=
      //  min(max(Panel11.Width, ScrollBox1.ClientWidth), 3000);
      //Panel11.Height :=
      //  min(max(Panel11.Height, ScrollBox1.ClientHeight), 3000);
      for ii := 0 to 3000 do
        for jj := 0 to 3000 do
          ar[ii][jj] := 0;
    except
      ShowMessage('不支持的图片格式');
    end;
  end;
end;

procedure TinAccessNeMo_frm.Button1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  amogha, vairocana: string;
begin // (mbLeft, mbRight, mbMiddle);
  // if Button=mbLeft   then
  begin
    // www1Click(Sender);

  end;
  if Button = mbRight then
  begin
    // amogha:=  '【'+TRzButton(Sender).Caption+'】的说明：';
    // amogha:=amogha+#13#10+ memo1.Lines[tcontrol(Sender).Tag];
    amogha := stringreplace(Memo1.Lines[TControl(Sender).Tag], '@',
      #13#10, [rfReplaceAll]);
    vairocana := '【' + TButton(Sender).Caption + '】的说明：';
    if TButton(Sender).Tag = 12 then
      vairocana := '【左键/右键】的说明：';
    // showmessage(amogha);
    application.MessageBox(PChar(amogha), PChar(vairocana), MB_OK);
  end;
end;

procedure TinAccessNeMo_frm.Button11Click(Sender: TObject);
//#31163#23736#26579#33394   //离岸染色    RzButton2
var
  wx, wy, X, Y: integer;
  rree: TRect;
  oldcc, R: integer;
  www: tmemorystream;
begin
  wx := 2000;
  wy := 2000;
  R := StrToInt(spinEdit4.Text);
  oldcc := Panel12.Canvas.Brush.Color;
  Panel12.Canvas.Brush.Color := clred;
  Button11.Caption := '离岸染色...0%';
  application.ProcessMessages;


  for X := 0 to wx do
    for Y := 0 to wy do
    begin
      if ar[X, Y] = clblue then
      begin
        // drawcircle(X, Y, 30);
        // drawcircle3(X, Y, 30);
        // RzPanel1.Canvas.Ellipse(X - 15, Y - 15, X + 15, Y + 15);
        drawcircle4(X, Y, R);
        //application.ProcessMessages;
      end;
      //application.ProcessMessages;
    end;
  application.ProcessMessages;

  //application.ProcessMessages;
  //www := tmemorystream.Create;
  //www.Position := 0;
  //Panel12.Picture.Bitmap.SaveToStream(www);
  //www.Position := 0;
  //Image1.Picture.Bitmap.LoadFromStream(www);
  //application.ProcessMessages;

  //Panel1image:= Image1;


  for X := 0 to wx do
  begin
    for Y := 0 to wy do
    begin
      if ar[X, Y] = clred then
        if Panel12.Canvas.Pixels[X, Y] <> clred then      ///
        begin
          Panel12.Canvas.Pixels[X, Y] := clred;
          //application.ProcessMessages;
        end;
    end;
    if ((x mod 20) = 0) then
    begin
      Button11.Caption := '离岸染色...' + Format('%.0f%%', [(x / wx) * 100]);
      // 先乘以100再格式化
      application.ProcessMessages;
    end;
  end;
  //  application.ProcessMessages;
  //    www.Position := 0;
  //Image1.Picture.Bitmap.SaveToStream(www);
  //www.Position := 0;
  //Panel12.Picture.Bitmap.LoadFromStream(www);
  //www.Free;
  //Panel12.Canvas.Brush.Color := oldcc;
  application.ProcessMessages;
  Button11.Caption := '离岸染色';
end;

procedure TinAccessNeMo_frm.Button10Click(Sender: TObject);
var
  www1: TMemoryStream;
begin

  if not FileExists('说明.txt') then
  begin
    Memo_SaveToTxT.Lines.SaveToFile('说明.txt');
  end;
  if FileExists('说明.txt') then
  begin
    //ShellExecute(self.Handle, 'open', '说明.txt', '', nil, SW_SHOWNORMAL);
    //.('gedit  说明.txt');
    //Memo_SaveToTxT.Lines.Clear;
    //Memo_SaveToTxT.Lines.LoadFromFile('说明.txt');
    //Memo_SaveToTxT.
    //msgshow.showMSG:=msgshow.TshowMSG.Create();
    // msgshow.showMSG.init('说明.txt');
    //ExtractFilePath(application.filename)+ '说明.txt';
    //application.ShellExecute('gedit  说明.txt');
    //paramstr(
    //self.MEMO3.lines.LoadFromFile('说明.txt');
    //self.MEMO3.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + '说明.txt');
    // showmessage(ParamStr(0));
    // showmessage(ExtractFilePath(ParamStr(0)));
    //  showmessage(ExtractFilePath(ParamStr(0)) + '说明.txt');
    msgshow.showMSG.init(ExtractFilePath(ParamStr(0)) + '说明.txt');

  end
  else
    ShowMessage('找不到说明文件');
end;

procedure TinAccessNeMo_frm.Button12Click(Sender: TObject);
//#28436#31034'MP4'  //演示MP4
var
  www: string;
begin
  www := extractfilepath(ParamStr(0)) + '演示.mp4';
  // ShellExecute(0, nil, PChar(www), '', '', SW_SHOWNORMAL);
  ShowMessage('演示视频所在目录路径为：' + #13#10 + www +
    #13#10 + '你可以用视频播放器打开观看如何操作的');
end;

procedure TinAccessNeMo_frm.Button2Click(Sender: TObject);
//#37325#36733#21047#26032  //重载刷新
//N1Click(Sender: TObject);
var
  bbb: Tbitmap;
begin
  try
    if OpenPictureDialog1.FileName <> '' then
    begin
      //Panel11.Align := alnone;
      //Panel12.Align:=alnone;
      //// Panel1image1.Left := 0;
      //// Panel1image1.top := 0;
      //Panel1image2.Left := 0;
      //Panel1image2.top := 0;
      //Image1.Picture.Bitmap.AlphaFormat := afPremultiplied;

      Image1.Picture.LoadFromFile(self.OpenPictureDialog1.FileName);
      // A TImage may hold a bitmap, icon, PNG, GIF or JPEG image.

      if tmpbmp <> nil then
        tmpbmp.FreeImage;
      // tmpbmp:=Tbitmap.Create;
      // tmpbmp.Assign(Image1.Picture.Graphic);
      Panel12.Picture.Bitmap.Assign(Image1.Picture.Graphic);


      Panel1image := Panel12;
      //Panel11.Width := Panel12.Width;
      //Panel11.Height := Panel12.Height;

      //Panel11.Width :=
      //  min(max(Panel1image1.Width, ScrollBox1.ClientWidth), 3000);
      //Panel11.Height :=
      //  min(max(Panel1image1.Height, ScrollBox1.ClientHeight), 3000);
    end;
    if OpenPictureDialog1.FileName = '' then
    begin

      bbb := Tbitmap.Create;
      //bbb.Width := ScrollBox1.ClientWidth;
      //bbb.Height := ScrollBox1.ClientHeight;
      bbb.SetSize(ScrollBox1.Width, ScrollBox1.Height);
      Panel12.Picture.Bitmap.Assign(bbb);


      Panel1image := Panel12;
      //Panel11.Width := Ranel12.Width;
      //Panel11.Height := Panel12.Height;

      //Panel11.Width :=
      //  min(max(Panel1image1.Width, ScrollBox1.ClientWidth), 3000);
      //Panel11.Height :=
      //  min(max(Panel1image1.Height, ScrollBox1.ClientHeight), 3000);
      bbb.Free;

    end;
    // drawsea();
    drawseaBlue();

  except
    ShowMessage('不支持的图片格式');
  end;
end;

procedure TinAccessNeMo_frm.Button3Click(Sender: TObject);
begin
  //#25551#32472#28023#23736#32447  ???  // 描绘海岸线   RzButton6????
  ShowMessage(
    '将鼠标移到要描绘海岸线的任一点，按下键盘的Enter即可开始，移动鼠标，可以记录下鼠标移动的路径，作为海岸线的坐标，再按下键盘的Enter即可结束描绘海岸线。保存下来，到时要用到');
end;

procedure TinAccessNeMo_frm.Button4Click(Sender: TObject);
begin
  //#20572#27490#25551#32472  //停止描绘 RzButton1
end;

procedure TinAccessNeMo_frm.Button5Click(Sender: TObject);
//#36733#20837#28023#23736#32447   //载入海岸线     RzButton7
var
  i, j: integer;
  www, qq: TStringList;
  sss: string;
  LInput: TFileStream;
  LUnZip: TDecompressionStream;
  LOutput: tmemorystream;
begin
  //#35206#30422#24335#36733#20837    覆盖式载入   RzRadioButton2.Checked
  //#21472#21152#24335#36733#20837    叠加式载入   RzRadioButton1.Checked
  // self.SaveDialog1.FileName:='海岸线'+formatdatetime('yyyymmddhhmmss',now());
  if self.OpenDialog1.Execute then
  begin
    try
      www := TStringList.Create;
      qq := TStringList.Create;

      LInput := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
      LInput.Position := 0;
      LOutput := tmemorystream.Create;
      LOutput.Position := 0;
      LUnZip := TDecompressionStream.Create(LInput);

      { Decompress data. }
      LOutput.CopyFrom(LUnZip, 0);
      LOutput.Position := 0;
      { Free the streams. }
      LUnZip.Free;
      LInput.Free;
      www.LoadFromStream(LOutput);
      LOutput.Free;

      // www.LoadFromFile(OpenDialog1.FileName);
      if RadioButton1.Checked then  //叠加式载入   RzRadioButton1.Checked
      begin
        for i := 0 to www.Count - 2 do
        begin
          sss := www[i];
          qq.Clear;
          qq.DelimitedText := sss;
          qq.Delimiter := ',';
          for j := 0 to qq.Count - 2 do
          begin
            if StrToInt(qq[j]) <> 0 then
              //叠加式载入  仅此不同  覆盖式载入
              ar[i][j] := StrToInt(qq[j]);

          end;

        end;
      end;
      if RadioButton2.Checked then   //覆盖式载入   RzRadioButton2.Checked
      begin
        try
          //self.Panel11.Align := alnone;
          //Panel11.Left := 0;
          //Panel11.top := 0;
          //Image1.Left := 0;
          //Image1.top := 0;
          ////////Panel12.Picture.Bitmap.AlphaFormat := afPremultiplied;

          Panel12.Picture.LoadFromFile(self.OpenPictureDialog1.FileName);
          // A TImage may hold a bitmap, icon, PNG, GIF or JPEG image.

          if tmpbmp <> nil then
            tmpbmp.FreeImage;

          Image1.Picture.Bitmap.Assign(Panel12.Picture.Graphic);


          Panel1image := Image1;
          //Panel11.Width := Image1.Width;
          //Panel11.Height := Image1.Height;
        except
          ShowMessage('不支持的图片格式');
        end;
        for i := 0 to www.Count - 2 do
        begin
          sss := www[i];
          qq.Clear;
          qq.DelimitedText := sss;
          qq.Delimiter := ',';
          for j := 0 to qq.Count - 2 do
          begin
            ar[i][j] := StrToInt(qq[j]);

          end;

        end;
      end;
      www.Free;
      qq.Free;
      drawsea();
      application.MessageBox(PChar('载入成功'),
        PChar('载入海岸线成功'), MB_OK);
    except
      application.MessageBox(PChar('载入失败'),
        PChar('载入海岸线失败'), MB_OK);

    end;

  end;
end;

procedure TinAccessNeMo_frm.Button6Click(Sender: TObject);
//#20445#23384#28023#23736#32447  //保存海岸线   RzButton8
var
  i, j: integer;
  www: TStringList;
  sss: string;
  LOutput: TFileStream;
  LZip: TCompressionStream;
  //LZip: Tcustomzlibstream;
  LInput: tmemorystream;
begin
  self.SaveDialog1.FileName := '海岸线' + formatdatetime('yyyymmddhhmmss', now());
  if self.SaveDialog1.Execute then
  begin
    www := TStringList.Create;
    // memo1.Lines.SaveToFile(SaveDialog1.FileName);
    for i := 0 to 3000 do
    begin
      sss := '';
      for j := 0 to 3000 do
      begin
        sss := sss + IntToStr(ar[i][j]) + ',';

      end;
      www.Add(sss);
    end;
    // www.SaveToFile(SaveDialog1.FileName);
    { Create the Input, Output, and Compressed streams. }
    LInput := tmemorystream.Create;
    www.SaveToStream(LInput);
    LInput.Position := 0;
    // LInput := TFileStream.Create(Edit1.Text, fmOpenRead);

    LOutput := TFileStream.Create(SaveDialog1.FileName, fmCreate);
    LOutput.Position := 0;
    // LZip := TCompressionStream.Create(LOutput);
    //   LZip := Tcustomzlibstream.Create(LOutput);
    LZip := TCompressionStream.Create(cldefault, LOutput);
    //  LUnZip := TDecompressionStream.Create(LInput);

    { Compress data. }
    LZip.CopyFrom(LInput, LInput.Size);

    { Free the streams. }
    LZip.Free;
    LInput.Free;
    LOutput.Free;

    www.Free;
    application.MessageBox(PChar('保存成功'), PChar('保存海岸线'), MB_OK);

  end;
end;

procedure TinAccessNeMo_frm.Button7Click(Sender: TObject);
begin
  //#33719#21462#28857#22352#26631  //获取点坐标  RzButton9
  ShowMessage('将鼠标移到要获取点的坐标处，按下键盘的Ctrl+Enter即可');
end;

procedure TinAccessNeMo_frm.Button8Click(Sender: TObject);
//#20197#28857#30011#22278   //以点画圆  RzButton10
var
  X, Y, R, i, j: integer;
  cc: integer;
  oldcc: integer;
begin
  oldcc := Panel1image.Canvas.Brush.Color;
  Panel1image.Canvas.Brush.Color := clred;
  X := StrToInt(spinEdit1.Text);
  Y := StrToInt(spinEdit2.Text);
  R := StrToInt(spinEdit3.Text);
  drawcircle4(X, Y, R);
  Panel12.Canvas.Brush.Color := oldcc;
  for i := X - R to X + R do
    for j := Y - R to Y + R do
    begin
      if ar[i, j] = clred then
      begin
        Panel12.Canvas.Pixels[i, j] := clred;
      end;
    end;
end;

procedure TinAccessNeMo_frm.Button_leftClick(Sender: TObject);
begin
  //原代码中  RZbutton1
  piapublic.beginflag := 1;
  piapublic.beginflag1 := 0;
  piapublic.beginflag2 := 0;
end;

procedure TinAccessNeMo_frm.Button_rightClick(Sender: TObject);
begin
  //原代码中  RZbutton2
  piapublic.beginflag := 0;
end;

procedure TinAccessNeMo_frm.Edit1Click(Sender: TObject);
begin
  //showmessage(inttostr(pos(edit1.Text,'#')));
  if pos(edit1.Text, '#') >= 0 then
    edit1.Text := Utf8Decode(edit1.Text);
  //showmessage(edit1.text);
end;

procedure TinAccessNeMo_frm.FormCreate(Sender: TObject);
begin
  piapublic.beginflag := 0;
end;

procedure TinAccessNeMo_frm.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  tt: TPoint;
  MousePos: TPoint;
begin

  if Key = word(#13) then // #13 是回车键的ASCII码
  begin
    if ssCtrl in Shift then
    begin
      // 获取鼠标屏幕坐标
      MousePos := Mouse.CursorPos;
      tt := panel12.ScreenToControl(MousePos);
      spinedit1.Value := (tt.X);
      spinedit2.Value := (tt.y);
      //tt := MousePos;
      //ar[tt.X, tt.Y] := clblue;
    end
    else
    begin
      beginflag := beginflag + 1;
      Key := word(#0); // 可选：阻止回车键的默认行为
    end;
  end;
end;

procedure TinAccessNeMo_frm.FormKeyPress(Sender: TObject; var Key: char);
begin
  //   if Key = (#13) then // #13 是回车键的ASCII码
  //begin
  //  //ShowMessage('您按下了回车键！');
  //  beginflag := beginflag + 1;
  //  Key := (#0); // 可选：阻止回车键的默认行为
  //end;
end;

procedure TinAccessNeMo_frm.FormKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

end;

procedure TinAccessNeMo_frm.FormResize(Sender: TObject);
var
  bbb: Tbitmap;
begin
  //if 1=2 then
  //if Panel12.Picture.Graphic = nil then
  if self.OpenPictureDialog1.FileName = '' then
  begin
    bbb := Tbitmap.Create;
    bbb.Width := ScrollBox1.ClientWidth;
    bbb.Height := ScrollBox1.ClientHeight;
    //self.Panel11.Align := alnone;
    // Panel11.Left := 0;
    // Panel11.top := 0;
    Panel12.Picture.Bitmap.Assign(bbb);

    //Panel12.Align:=alclient;
    Panel1image := Panel12;
    //Panel11.Width := Panel12.Width;
    //Panel11.Height := Panel12.Height;

    //Panel11.Width := min(max(Panel11.Width, ScrollBox1.ClientWidth), 3000);
    //Panel11.Height :=
    //  min(max(Panel11.Height, ScrollBox1.ClientHeight), 3000);
    //  application.ProcessMessages;
    //Panel1image2.Align:=alnone;
    bbb.Free;
  end;

end;
//
//function HexToStr(str: string): string;
//
//  function HexToInt(hex: string): integer;
//  var
//    i: integer;
//
//    function Ncf(num, f: integer): integer;
//    var
//      i: integer;
//    begin
//      Result := 1;
//      if f = 0 then exit;
//      for i := 1 to f do
//        Result := Result * num;
//    end;
//
//    function HexCharToInt(HexToken: char): integer;
//    begin
//      if HexToken > #97 then
//        HexToken := Chr(Ord(HexToken) - 32);
//      Result := 0;
//      if (HexToken > #47) and (HexToken < #58) then { chars 0....9 }
//        Result := Ord(HexToken) - 48
//      else if (HexToken > #64) and (HexToken < #71) then { chars A....F }
//        Result := Ord(HexToken) - 65 + 10;
//    end;
//
//  begin
//    Result := 0;
//    hex := AnsiUpperCase(trim(hex));
//    if hex = '' then
//      exit;
//    for i := 1 to length(hex) do
//      Result := Result + HexCharToInt(hex[i]) * ncf(16, length(hex) - i);
//  end;
//
//var
//  s, t: string;
//  i, j: integer;
//  p: pchar;
//begin
//  s := '';
//  i := 1;
//  while i < length(str) do
//  begin
//    t := str[i] + str[i + 1];
//    s := s + chr(hextoint(t));
//    i := i + 2;
//  end;
//  Result := s;
//end;
///procedure TinAccessNeMo_frm.Label2Click(Sender: TObject);
///        #28436#31034'MP4'
//1、从 dfm 中读取类似字符串'#23334'
//2、去掉 # 号，变成'23334'
//3、利用 StrToInt ，把字符串转化为整型
//4、把整型数的两个低位字节强制转化为字符型(Delphi 的 string 类型是基于 AnsiChar，一个汉字是两个 AnsiChar)。就ok了！
//var
//  vSourceDFM: TStringList;
//  FileStreamReadi, FileStreamwritei: TFileStream;


//  wwwform:tform;
//begin
//try
//vSourceDFM:=TStringList.Create ;
//vSourceDFM.LoadFromFile('/media/w/data/piaMain.dfm',TEncoding.UTF8);
//vSourceDFM.SaveToFile('/media/w/data/piaMain.TXT',TEncoding.ANSI);
//finally
//vSourceDFM.Free;
//end;
//#28436#31034'MP4'
//var
//  s, ss: ansistring;
//begin
//  s := '演';
//  ss := '$28436$31034';

//  edit1.Text := IntToStr(strtoascii(s));//                 UnicodeToASCII(ss);
//  //edit1.text:=HexToAscii(ss);
//end;

// Label2.Caption:=Edit1.Text;

//begin
//  Label2.Caption:=Edit1.Text;
//end;


//UniCode转汉字（\u 格式）、汉字转UniCode（\u 格式）

//1、UniCode转汉字

//function UnicodeToChinese(sStr: string): string;
//var
//  i: Integer;
//  index: Integer;
//  temp, top, last: string;
//begin
//  index := 1;
//  while index >= 0 do
//  begin
//    index := Pos('\u', sStr) - 1;
//    if index < 0 then         //非 unicode编码不转换 ,自动过滤
//    begin
//      last := sStr;
//      Result := Result + last;
//      Exit;
//    end;
//    top := Copy(sStr, 1, index); // 取出 编码字符前的 非 unic 编码的字符，如数字
//    temp := Copy(sStr, index + 1, 6); // 取出编码，包括 \u,如\u4e3f
//    Delete(temp, 1, 2);
//    Delete(sStr, 1, index + 6);
//    Result := Result + top + WideChar(StrToInt('$' + temp));
//  end;
//end;

//2、汉字转UniCode

//function ChineseToUniCode(sStr: string): string;     //汉字的 UniCode 编码范围是: $4E00..$9FA5     作者：滔Roy
//var
//  w:Word;
//  hz:WideString;
//  i:Integer;
//  s:string;
//begin
//  hz:=sStr;
//  for i:=1 to Length(hz) do begin
//    w := Ord(hz[i]);
//    s:=IntToHex(w, 4);
//    Result := Result +'\u'+ LowerCase(s);
//  end;
//end;

//3、示例:

//var
//  s,s1,s2 : string;
//begin
//  s1 := '滔Roy';
//  s2 := '\u6ed4\u0052\u006f\u0079';

//  s:=ChineseToUniCode(s1);  {汉字到 UniCode 编码}
//  s:=UnicodeToChinese(s2);  { UniCode 编码到汉字}
//end;

//var
//  FileStream: TFileStream;
// Reader: TReader;
//begin
//  FileStream := TFileStream.Create('Form1.DFM', fmOpenRead);
//  try
//    Reader := TReader.Create(FileStream, 4096);
//    try
//      Form1 := TForm1.Create(Application);
//      Form1.LoadFromFile('Form1.DFM');
//    finally
//      Reader.Free;
//    end;
//  finally
//    FileStream.Free;
//  end;
//end;

//var
//  FileStream: TFileStream;
//  Writer: TWriter;
//begin
//  FileStream := TFileStream.Create('Form1.DFM', fmCreate);
//  try
//    Writer := TWriter.Create(FileStream, 4096);
//    try
//      Form1.SaveToFile('Form1.DFM');
//    finally
//      Writer.Free;
//    end;
//  finally
//    FileStream.Free;
//  end;
//end;                                        le('/media/w/data/piaMain.dfm',
//                                            ('/media/w/data/piaMain.TXT',TE



//FileStreamReadi := TFileStream.Create('/media/w/data/piaMain.dfm', fmOpenRead);
//try
//  readi := TReader.Create(FileStreamReadi, 4096);
//  try           TinAccessNeMo_frm.LoadFromFile('/media/w/data/piaMain.dfm');
//      wwwform:= TForm.Create(Application);
//     wwwform.LoadFromFile('/media/w/data/piaMain.dfm');
//    FileStreamwritei := TFileStream.Create('/media/w/data/piaMain.TXT', fmCreate);
//    try
//      Writei := TWriter.Create(FileStreamwritei, 4096);
//      try
//        wwwform.SaveToFile('/media/w/data/piaMain.TXT');
//      finally
//        Writei.Free;
//      end;
//    finally
//      FileStreamwritei.Free;
//    end;
//  finally
//    readi.Free;
//  end;
//finally
//  wwwform.Free;
//  FileStreamReadi.Free;
//end;
// Label2.Caption:=utf8decode(Edit1.Text);
//Label2.Caption:=ansitoutf8(Edit1.Text);
//  Label2.Caption:=utf8encode(Edit1.Text);




//LRSStream:=TMemoryStream.Create;
//LFMStream:=TMemoryStream.Create;

//      LRSStream.LoadFromFile('/media/w/data/piaMain.dfm');
//      LRSObjectBinaryToText(LRSStream,LFMStream);
//      LFMStream.Position:=0;
//      LFMStream.SaveToFile('/media/w/data/piaMain.TXT');   //#28436#31034

//   #28436#31034'MP4'
//   SetOrdProp(self,FindPropInfo(self,'Caption'),$28436 );

//      var
//        rc: TRttiContext;
//        v: TValue;
//        rm: TRttiMethod;
//        rt: TRttiType;
//        rp: TRttiProperty;
//         readi: TReader;
//         writei :TWriter;
//         ws: WideString;
//       //  ws:string;
//         www:pchar;

//  MyInteger: Integer;
//  LowByte: Byte;
//  HighByte: Byte;

//  c1: widechar;

//c2: widechar;

//i: integer;

//s: widestring;
//UnicodeStr: WideString;
//AnsiStr: AnsiString;
//      begin
//        //取Btn2的属性Name 和Caption
//        //分步
//        rt := TRttiContext.Create.GetType(self.Label3.ClassType);
//        rp := rt.GetProperty('Name');
//        v := rp.GetValue(self.Label3);
//        ShowMessage(v.AsString);
//       // 修改属性

////rt.GetProperty('Caption').SetValue(Button1,'New');

//// p.SetValue(Button1, TValue.FromOrdinal(TypeInfo(TAlign), Ord(alLeft)));
//rt.GetProperty('Caption').SetValue(Label3,#28436#31034);  //   //   #28436#31034'MP4'
//ShowMessage(  rt.GetProperty('Caption').GetValue(self.Label3).AsString);
//        //合并一步
//       ShowMessage(  rt.GetProperty('Caption').GetValue(self.Label2).AsString);


//       if ws='' then exit;
//  {$IFDEF FPC_BIG_ENDIAN}
//  WriteWordsReversed(PWord(@ws[1]),length(ws));
//  {$ELSE}
//  Write(ws[1],length(ws)*2);
//  {$ENDIF}
// ws:='演'; //unicode编码转换，演正是，unicode转ansi  28436
// www:='            ';
//www:= PWord(@ws[1]);
// ShowMessage(ord(char(pchar(PWord(@ws[1])))));
//  ShowMessage(  IntToStr(ord(ws[1]))+'::'+IntToStr(ord(ws[2]))); //230  188



//    MyInteger := 28436; // 示例整数
//LowByte := hiword(MyInteger);                    //MyInteger and $FF; // 使用位与操作获取低8位
//ShowMessage(  IntToStr(LowByte));
// HighByte := (MyInteger shr 24) and $FF; // 右移24位后与$FF进行位与操作获取高8位
// ShowMessage(  IntToStr(HighByte));

// AnsiStr := '演';
// AnsiStr := AnsiString(UnicodeStr); // 直接转换
//// ShowMessage(  AnsiStr);
//ShowMessage( chr (ord(AnsiStr[1]))+'::'+chr(ord(AnsiStr[2]))); //230  188


//ShowMessage(inttostr(strtoint( '$'+IntToStr(ord(ws[1]))+''+IntToStr(ord(ws[2])))));
//  end;



//procedure TinAccessNeMo_frm.Label2Click(Sender: TObject);
//var
//   AnsiStr:string;
//   ws: WideString;
//   Buffer: Pointer;
//   SourceBuf: PChar;
//  begin
//      AnsiStr := '演';  //unicode编码转换，演正是，unicode转ansi  28436
//      ws:= '演';  //unicode编码转换，演正是，unicode转ansi  28436
//      Buffer:= Pointer(@ws[1]);//ws[1];
//      GetMem(Buffer,length(ws)*2);
//      SourceBuf:=@Buffer;
//      AnsiStr:=ansistring(ws);
//      Buffer:= Pointer(@AnsiStr[1]);//ws[1];    $C3    $A6     195  166    #$C3#$A6
//      GetMem(Buffer,length(AnsiStr)*2);
//      SourceBuf:=@Buffer;
// ShowMessage( inttostr( strtoint('$6F'))+'::'+inttostr(strtoint('$14'))   );   //111  20
// ShowMessage( inttostr( strtoint('$6F14')))   ;   //28436
// ShowMessage( chr(111)+'::'+chr(20));



function chineseCharToInt10(const w: string): integer;
var
  i, len: integer;
  cur: integer;
  ws: widestring;
begin
  Result := 0;
  ws := widestring(w);
  len := Length(ws);
  i := 1;
  while i <= len do
  begin
    cur := Ord(ws[i]);
    Result := Result + cur;
    Inc(i);
  end;

end;


function Int10TochineseChar(int10: string): string;
var
  i, len: integer;
  ws: widestring;
begin
  ws := '';
  i := 1;
  len := Length(int10);
  while i < len do
  begin
    ws := ws + widechar(StrToInt(int10));
    i := i + 4;
  end;
  Result := ansistring(ws);
end;
procedure TinAccessNeMo_frm.Label2Click(Sender: TObject);
begin
 // ShowMessage(IntToStr(StrToInt('$' + str_Unicode('演')))); //6F14
 // ShowMessage(Unicode_str(inttohex(28436))); //演

   ShowMessage(IntToStr(chineseCharToInt10('演'))); //28436
  ShowMessage(Int10TochineseChar('28436')); //演

end;

end.
