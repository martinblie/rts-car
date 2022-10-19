with MicroBit.IOsForTasking;
with Microbit.TimeWithRTC1;


package CarObject is
   
   type Dir is
   (Forward, Backward, Stop);
   
   type Pins is record
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
   end record;
   
   protected DirectionLB is
      procedure Set(Dir : Dir);
      function Get return Dir;
   private
      CurrentDirectionLB : Dir := Stop;
   end DirectionLB;
   
   protected DirectionRB is
      procedure Set(Dir : Dir);
      function Get return Dir;
   private
      CurrentDirectionRB : Dir := Stop;
   end DirectionRB;
   
   protected DirectionLF is
      procedure Set(Dir : Dir);
      function Get return Dir;
   private
      CurrentDirectionLF : Dir := Stop;
   end DirectionLF;
   
   protected DirectionRF is
      procedure Set(Dir : Dir);
      function Get return Dir;
   private
      CurrentDirectionRF : Dir := Stop;
   end DirectionRF;
   
   protected SpeedLeft is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value);
      function Get return MicroBit.IOsForTasking.Analog_Value;
   private
      CurrentSpeedLeft : MicroBit.IOsForTasking.Analog_Value := 0;
   end CurrentSpeedLeft;
   
   protected SpeedRight is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value);
      function Get return MicroBit.IOsForTasking.Analog_Value;
   private
      CurrentSpeedRight : MicroBit.IOsForTasking.Analog_Value := 0;
   end CurrentSpeedRight;
   
        
   
  
      
   
      

   
   protected Car is
      procedure SetDirectionHelper(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                                Pin2 : MicroBit.IOsForTasking.Pin_Id;
                                   Dir : Boolean);
      procedure SetDirectionLB(Dir : Boolean);
      procedure SetDirectionRB(Dir : Boolean);
      procedure SetDirectionLF(Dir : Boolean);
      procedure SetDirectionRF(Dir : Boolean);
      function GetDirectionLB return Boolean;
      function GetDirectionRB return Boolean;
      function GetDirectionLF return Boolean;
      function GetDirectionRF return Boolean;
   
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
   private
      -- PINS
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
      --Ultrasonic : MicroBit.IOsForTasking.Pin_Id := 12;
      --IrLeft : MicroBit.IOsForTasking.Pin_Id := 13;
      --IrRight : MicroBit.IOsForTasking.Pin_Id := 14;
      --IrRear : MicroBit.IOsForTasking.Pin_Id := 15;
      -- STATUS
      CurrentSpeedLeft : MicroBit.IOsForTasking.Analog_Value := 0;
      CurrentSpeedRight : MicroBit.IOsForTasking.Analog_Value := 0;
      CurrentDirectionLB : Boolean := True;
      CurrentDirectionRB : Boolean := True;
      CurrentDirectionLF : Boolean := True;
      CurrentDirectionRF : Boolean := True;
      --CurrentServoAngle : Positive range 0 .. 180 := 0;
      --ObstacleDistanceFront : Positive range 0 .. 200 := 100;
      --ObstacleDistanceRear : Positive range 0 .. 30 := 20;
      --ObstacleDistanceLeft : Positive range 0 .. 30 := 20;
      --ObstacleDistanceRight : Positive range 0 .. 30 := 20;
      AccelerationX : Integer := 0;
      AccelerationY : Integer := 0;
      AccelerationZ : Integer := 0;
   end Car;
   
   
   
   
   
        

end CarObject;
