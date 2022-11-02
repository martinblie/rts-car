with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.Console; use MicroBit.Console;
package body Servocontrol is
   procedure turnServo(dir1 : Servo_Set_Point) 
   is begin
      Put_Line("turn 10 begin");
      Go(0, dir1);
      delay 2.0;
   end turnServo;
   

end Servocontrol;
