with CarObject; use CarObject;
with DistanceSensors; use DistanceSensors;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.DisplayRT;
with MicroBit.Console;
with MicroBit.TimeWithRTC1;

procedure Main is
   Distance : Integer := 0;
   NewDistance : Integer;

begin

   loop
      NewDistance := GetDistanceUltrasonic(0,1);
      Microbit.TimeWithRTC1.Delay_Ms(500);
      if NewDistance /= Distance then
       --  MicroBit.DisplayRT.Clear;
       --  MicroBit.DisplayRT.Display(NewDistance'Image);
         Distance := NewDistance;
         MicroBit.Console.Put_Line(NewDistance'Image);
         MicroBit.Console.New_Line;
      end if;
      MicroBit.Console.Put_Line("xxxxxxxxxxxxxx");
         MicroBit.Console.New_Line;
   end loop;




end Main;
