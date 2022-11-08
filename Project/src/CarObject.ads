with MicroBit.IOsForTasking;
with Microbit.TimeWithRTC1;
with Ultrasonic;

package CarObject is
<<<<<<< Updated upstream

   type Direction is
     (Forwards,
      Backwards,
      Stop);
     
   protected Car is
      procedure SetDirectionHelper(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                                Pin2 : MicroBit.IOsForTasking.Pin_Id;
                                   Dir : Direction);
      procedure SetDirectionLB(Dir : Direction);
      procedure SetDirectionRB(Dir : Direction);
      procedure SetDirectionLF(Dir : Direction);
      procedure SetDirectionRF(Dir : Direction);
      function GetDirectionLB return Direction;
      function GetDirectionRB return Direction;
      function GetDirectionLF return Direction;
      function GetDirectionRF return Direction;
   
      procedure SetSpeedLeft (Speed : MicroBit.IOsForTasking.Analog_Value);
      procedure SetSpeedRight(Speed : MicroBit.IOsForTasking.Analog_Value);
      function GetSpeedLeft return MicroBit.IOsForTasking.Analog_Value;
      function GetSpeedRight return MicroBit.IOsForTasking.Analog_Value; 
      
      --procedure SetObstacleDistanceFront(Self : in out Car);
      --procedure SetObstacleDistanceRear(Self : in out Car);
      --procedure SetObstacleDistanceLeft(Self : in out Car);
      --procedure SetObstacleDistanceRight(Self : in out Car);
      --procedure GetObstacleDistanceFront(Self : in Car);
      --procedure GetObstacleDistanceRear(Self : in Car);
      --procedure GetObstacleDistanceLeft(Self : in Car);
      --procedure GetObstacleDistanceRight(Self : in Car);
=======
   
   type Dir is
   (Forward, Backward, Stop);
   
   type PinRecord is record
      PwmLeft : MicroBit.IOsForTasking.Pin_Id := 1; --red and pruple
      PwmRight : MicroBit.IOsForTasking.Pin_Id := 10; --green and black
      PwmServo : MicroBit.Servos.Servo_Pin_Id := 0;
      Dir1LB : MicroBit.IOsForTasking.Pin_Id := 3; -- yellow
      Dir2LB : MicroBit.IOsForTasking.Pin_Id := 2; -- orange
      Dir1RB : MicroBit.IOsForTasking.Pin_Id := 15; -- brown
      Dir2RB : MicroBit.IOsForTasking.Pin_Id := 14; -- red
      Dir1LF : MicroBit.IOsForTasking.Pin_Id := 7; -- blue
      Dir2LF : MicroBit.IOsForTasking.Pin_Id := 6; -- green
      Dir1RF : MicroBit.IOsForTasking.Pin_Id := 13; -- orange
      Dir2RF : MicroBit.IOsForTasking.Pin_Id := 12; -- yellow
      Ultrasonic1Trigger : MicroBit.IOsForTasking.Pin_Id := 19; -- orange
      Ultrasonic1Echo : MicroBit.IOsForTasking.Pin_Id := 11; --yellow
      
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
>>>>>>> Stashed changes
   private
      -- PINS
      PwmLeft : MicroBit.IOsForTasking.Pin_Id := 2;
      PwmRight : MicroBit.IOsForTasking.Pin_Id := 3;
      PwmServo : MicroBit.IOsForTasking.Pin_Id := 4;
      Dir1LB : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir2LB : MicroBit.IOsForTasking.Pin_Id := 1;
      Dir1RB : MicroBit.IOsForTasking.Pin_Id := 5;
      Dir2RB : MicroBit.IOsForTasking.Pin_Id := 6;
      Dir1LF : MicroBit.IOsForTasking.Pin_Id := 7;
      Dir2LF : MicroBit.IOsForTasking.Pin_Id := 8;
      Dir1RF : MicroBit.IOsForTasking.Pin_Id := 9;
      Dir2RF : MicroBit.IOsForTasking.Pin_Id := 10;
      Ultrasonic : MicroBit.IOsForTasking.Pin_Id := 11;
      IrLeft : MicroBit.IOsForTasking.Pin_Id := 12;
      IrRight : MicroBit.IOsForTasking.Pin_Id := 13;
      IrRear : MicroBit.IOsForTasking.Pin_Id := 14;
      -- STATUS
      CurrentSpeedLeft : MicroBit.IOsForTasking.Analog_Value := 0;
      CurrentSpeedRight : MicroBit.IOsForTasking.Analog_Value := 0;
<<<<<<< Updated upstream
      CurrentDirectionLB : direction := Stop;
      CurrentDirectionRB : direction := Stop;
      CurrentDirectionLF : direction := Stop;
      CurrentDirectionRF : direction := Stop;
      --CurrentServoAngle : Positive range 0 .. 180 := 0;
      --ObstacleDistanceFront : Positive range 0 .. 200 := 100;
      --ObstacleDistanceRear : Positive range 0 .. 30 := 20;
      --ObstacleDistanceLeft : Positive range 0 .. 30 := 20;
      --ObstacleDistanceRight : Positive range 0 .. 30 := 20;
      AccelerationX : Integer := 0;
      AccelerationY : Integer := 0;
      AccelerationZ : Integer := 0;
   end Car;
=======
   end SpeedRight;
   
   protected ObstacleDistanceFront with Priority => 5 is
      procedure Set(Dist : Ultrasonic.Distance_cm);
      entry Get(Var : out Ultrasonic.Distance_cm);
   private
      CurrentObstacleDistanceFront : Ultrasonic.Distance_cm := 120;
      IsUpdated : Boolean := False;
   end ObstacleDistanceFront;
>>>>>>> Stashed changes
   
   
   
   
   
        

end CarObject;
