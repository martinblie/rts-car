with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.Console; use MicroBit.Console;
package body Servocontrol is
   procedure turnServo(dir1 : Servo_Set_Point) 
   is begin
      Go(0, dir1);
   end turnServo;
   

end Servocontrol;
