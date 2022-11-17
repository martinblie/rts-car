with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Servos; use MicroBit.Servos;


package Utils is
   
   type Dir is
   (Forward, Backward, Stop);
   
   type PinRecord is record
      PwmLeft            : Pin_Id       := 10; --red/purple
      PwmRight           : Pin_Id       := 1; -- green/black
      PwmServo           : Servo_Pin_Id := 0;
      Dir1LB             : Pin_Id       := 15; -- blue
      Dir2LB             : Pin_Id       := 16; -- green
      Dir1RB             : Pin_Id       := 4; -- orange
      Dir2RB             : Pin_Id       := 5; -- yellow
      Dir1LF             : Pin_Id       := 13; -- yellow
      Dir2LF             : Pin_Id       := 14; -- orange
      Dir1RF             : Pin_Id       := 6; -- brown
      Dir2RF             : Pin_Id       := 7; -- red
      Ultrasonic1Trigger : Pin_Id       := 9; -- orange
      Ultrasonic1Echo    : Pin_Id       := 8; --yellow
      Led1               : Pin_Id       := 2;
      Led2               : Pin_Id       := 19;
   end record;
   Pins : PinRecord;
   
   

   
  
      
   
      

   
   
   
   
        

end Utils;
