with MicroBit.IOsForTasking;
with Microbit.TimeWithRTC1;


package CarClass is
   type Uint is mod 2**32;

   type Car is tagged record
      -- PINS
      PwmLeft : MicroBit.IOsForTasking.Pin_Id := 0;
      PwmRight : MicroBit.IOsForTasking.Pin_Id := 0;
      PwmServo : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir1LB : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir2LB : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir1RB : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir2RB : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir1LF : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir2LF : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir1RF : MicroBit.IOsForTasking.Pin_Id := 0;
      Dir2RF : MicroBit.IOsForTasking.Pin_Id := 0;
      Ultrasonic : MicroBit.IOsForTasking.Pin_Id := 0;
      IrLeft : MicroBit.IOsForTasking.Pin_Id := 0;
      IrRight : MicroBit.IOsForTasking.Pin_Id := 0;
      IrRear : MicroBit.IOsForTasking.Pin_Id := 0;
      -- STATUS
      CurrentSpeedLeft : Positive range 0 .. 1024 := 0;
      CurrentSpeedRight : Positive range 0 .. 1024 := 0;
      CurrentDirectionLB : Boolean := True;
      CurrentDirectionRB : Boolean := True;
      CurrentDirectionLF : Boolean := True;
      CurrentDirectionRF : Boolean := True;
      CurrentServoAngle : Positive range 0 .. 180 := 0;
      ObstacleDistanceFront : Positive range 0 .. 200 := 100;
      ObstacleDistanceRear : Positive range 0 .. 30 := 20;
      ObstacleDistanceLeft : Positive range 0 .. 30 := 20;
      ObstacleDistanceRight : Positive range 0 .. 30 := 20;
      AccelerationX : Integer := 0;
      AccelerationY : Integer := 0;
      AccelerationZ : Integer := 0;
   end record;
   
   procedure SetDirectionHelper(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                                Pin2 : MicroBit.IOsForTasking.Pin_Id;
                                Dir : Boolean);
   
   procedure SetDirectionLB(Self : in out Car; Dir : Boolean);
   procedure SetDirectionRB(Self : in out Car; Dir : Boolean);
   procedure SetDirectionLF(Self : in out Car; Dir : Boolean);
   procedure SetDirectionRF(Self : in out Car; Dir : Boolean);
   function GetDirectionLB(Self : in Car) return Boolean;
   function GetDirectionRB(Self : in Car) return Boolean;
   function GetDirectionLF(Self : in Car) return Boolean;
   function GetDirectionRF(Self : in Car) return Boolean;
   
   procedure SetSpeedLeft(Self : in out Car; Speed : Integer);
   procedure SetSpeedRight(Self : in out Car; Speed : Integer);
   function GetSpeedLeft(Self : in Car) return Integer;
   function GetSpeedRight(Self : in Car) return Integer;
   
   --procedure SetObstacleDistanceFront(Self : in out Car);
   --procedure SetObstacleDistanceRear(Self : in out Car);
   --procedure SetObstacleDistanceLeft(Self : in out Car);
   --procedure SetObstacleDistanceRight(Self : in out Car);
   --procedure GetObstacleDistanceFront(Self : in Car);
   --procedure GetObstacleDistanceRear(Self : in Car);
   --procedure GetObstacleDistanceLeft(Self : in Car);
   --procedure GetObstacleDistanceRight(Self : in Car);
   
   
   
   
   
   
        

end CarClass;
