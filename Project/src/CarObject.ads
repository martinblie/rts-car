with MicroBit.IOsForTasking;
with Microbit.TimeWithRTC1;


package CarObject is
   
   type Dir is
   (Forward, Backward, Stop);
   
   type PinRecord is record
      PwmLeft : MicroBit.IOsForTasking.Pin_Id := 1;
      PwmRight : MicroBit.IOsForTasking.Pin_Id := 2;
      PwmServo : MicroBit.IOsForTasking.Pin_Id := 3;
      Dir1LB : MicroBit.IOsForTasking.Pin_Id := 4;
      Dir2LB : MicroBit.IOsForTasking.Pin_Id := 5;
      Dir1RB : MicroBit.IOsForTasking.Pin_Id := 6;
      Dir2RB : MicroBit.IOsForTasking.Pin_Id := 7;
      Dir1LF : MicroBit.IOsForTasking.Pin_Id := 12;
      Dir2LF : MicroBit.IOsForTasking.Pin_Id := 13;
      Dir1RF : MicroBit.IOsForTasking.Pin_Id := 10;
      Dir2RF : MicroBit.IOsForTasking.Pin_Id := 11;
      Ultrasonic1Trigger : MicroBit.IOsForTasking.Pin_Id := 12;
      Ultrasonic1Echo : MicroBit.IOsForTasking.Pin_Id := 13;
   end record;
   Pins : PinRecord;
   
   protected DirectionLB is
      procedure Set(Direction : Dir);
      function Get return Dir;
   private
      CurrentDirectionLB : Dir := Stop;
   end DirectionLB;
   
   protected DirectionRB is
      procedure Set(Direction : Dir);
      function Get return Dir;
   private
      CurrentDirectionRB : Dir := Stop;
   end DirectionRB;
   
   protected DirectionLF is
      procedure Set(Direction : Dir);
      function Get return Dir;
   private
      CurrentDirectionLF : Dir := Stop;
   end DirectionLF;
   
   protected DirectionRF is
      procedure Set(Direction : Dir);
      function Get return Dir;
   private
      CurrentDirectionRF : Dir := Stop;
   end DirectionRF;
   
   protected SpeedLeft is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value);
      function Get return MicroBit.IOsForTasking.Analog_Value;
   private
      CurrentSpeedLeft : MicroBit.IOsForTasking.Analog_Value := 0;
   end SpeedLeft;
   
   protected SpeedRight is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value);
      function Get return MicroBit.IOsForTasking.Analog_Value;
   private
      CurrentSpeedRight : MicroBit.IOsForTasking.Analog_Value := 0;
   end SpeedRight;
   
   protected ObstacleDistanceFront is
      procedure Set(Dist : Integer);
      function Get return Integer;
   private
      CurrentObstacleDistanceFront : Integer;
   end ObstacleDistanceFront;
   
   
  
      
   
      

   
   
   
   
        

end CarObject;
