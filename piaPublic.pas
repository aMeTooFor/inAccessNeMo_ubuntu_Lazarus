unit piaPublic;

interface
function getY(x:integer;R:integer;z:integer):integer;
function isover(x:integer):boolean;
var
  beginflag: integer;
  beginflag1: integer;
  beginflag2: integer;
  ar: array[0..3000,0..3000] of integer;
implementation
 function getY(x:integer;R:integer;z:integer):integer;
 begin
    result:=0;
    result:=round(sqrt(r*r-x*x));
    if z<0 then
      result:=(-1)*result;
 end;
 function isover(x:integer):boolean;
 begin
     result:=false;
     if ((x>=0) and (x<=2000)) then
      result:=true;


 end;
end.
