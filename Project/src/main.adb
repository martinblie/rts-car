with CarClass; use CarClass;

procedure Main is
myCar : Car;
begin
   myCar.PwmLeft := 1;
   myCar.PwmRight := 2;
   mycar.Dir1LB := 3;
   myCar. Dir2LB := 4;
   myCar.Dir1RB := 5;
   myCar.Dir2RB := 6;
   myCar.Dir1LF := 7;
   myCar.Dir2LF := 8;
   myCar.Dir1RF := 9;
   myCar.Dir2RF := 10;

   myCar.SetDirectionLB(True);
   myCar.SetSpeedLeft(200);






   null;
end Main;
