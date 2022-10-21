with MicroBit.IOsForTasking;
with Microbit.TimeWithRTC1;


package CarObject is
   
   type Dir is
   (Forward, Backward, Stop);
   
   type PinRecord is record
      PwmLeft : MicroBit.IOsForTasking.Pin_Id := 1;
      PwmRight : MicroBit.IOsForTasking.Pin_Id;
      PwmServo : MicroBit.IOsForTasking.Pin_Id;
      Dir1LB : MicroBit.IOsForTasking.Pin_Id := 14; -- black
      Dir2LB : MicroBit.IOsForTasking.Pin_Id := 15; -- white
      Dir1RB : MicroBit.IOsForTasking.Pin_Id := 2; -- red
      Dir2RB : MicroBit.IOsForTasking.Pin_Id := 3; -- brown
      Dir1LF : MicroBit.IOsForTasking.Pin_Id := 12; -- grey
      Dir2LF : MicroBit.IOsForTasking.Pin_Id := 13; -- purple
      Dir1RF : MicroBit.IOsForTasking.Pin_Id := 6; -- yellow
      Dir2RF : MicroBit.IOsForTasking.Pin_Id := 7; -- orange
      Ultrasonic1Trigger : MicroBit.IOsForTasking.Pin_Id := 10;
      Ultrasonic1Echo : MicroBit.IOsForTasking.Pin_Id := 11;
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
   
   protected ObstacleDistanceFront with Priority => 5 is
      procedure Set(Dist : Integer);
      entry Get(Var : out Integer);
   private
      CurrentObstacleDistanceFront : Integer := 120;
      IsUpdated : Boolean := False;
   end ObstacleDistanceFront;
   
   
  
      
   
      

   
   
   
   
        

end CarObject;
