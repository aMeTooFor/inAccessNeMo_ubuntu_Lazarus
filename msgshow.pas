unit msgshow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TshowMSG }

  TshowMSG = class(TForm)
     Memo1: TMemo;
  private

  public
     procedure init(filename:string);
     procedure initshow(sss:string);
  end;

var
  showMSG: TshowMSG;

implementation

{$R *.lfm}

{ TshowMSG }

procedure TshowMSG.init(filename: string);
begin
  memo1.Lines.Clear;
   //showmessage(filename);
  if FileExists(filename) then
    memo1.Lines.LoadFromFile(filename);
  application.ProcessMessages;
  self.ShowModal;
end;

procedure TshowMSG.initshow(sss: string);
begin
   memo1.Lines.Clear;
   memo1.Lines.Text:=sss;
   self.ShowModal;
end;

end.

