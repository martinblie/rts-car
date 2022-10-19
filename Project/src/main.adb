with CarObject; use CarObject;
with MicroBit.IOsForTasking;
with MicroBit.TimeWithRTC1; use MicroBit.TimeWithRTC1;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console;

procedure Main is
   Dir : Boolean := True;
   Timer : Ada.Real_Time.Time;
begin
   loop
    Timer := Ada.Real_Time.Clock;



   Car.SetDirectionLB(Dir);
   Car.SetDirectionRB(Dir);
   Car.SetDirectionLF(Dir);
      Car.SetDirectionRF(Dir);

      delay 1.0;
      delay until Timer + Ada.Real_Time.Milliseconds(1000);
      Dir := not Dir;
      MicroBit.Console.Put_Line("hello");
      MicroBit.Console.New_Line;




   --myCar.SetSpeedLeft(200);



  end loop;






end Main;
