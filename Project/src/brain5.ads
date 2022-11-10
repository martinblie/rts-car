with CarObject; use CarObject;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic; use Ultrasonic;

package Brain5 is
   
   type CarStates is
     (SelfDriving, Calculate, RerouteLeft, RerouteRight);
   type ServoStates is
     (Forward, Left45, Right45, Left75, Right75);
   
   type ActuatorData is record
      PwmLeft    : Analog_Value := 1023;
      PwmRight   : Analog_Value := 1023;
      ServoAngle : Servo_Set_Point;
      DirLF      : Dir;
      DirRF      : Dir;
      DirLB      : Dir;
      DirRB      : Dir;
   end record;
   
   

   task Sense with Priority => 1;
   task Compute with Priority => 2;
   task Act with Priority => 3;
   
   protected ObstacleDistancePO is
      procedure Set(Dist : Distance_cm);
      entry Get(Var : out Distance_cm);
   private
      CurrentObstacleDistance : Distance_cm := 120;
      IsUpdated : Boolean := False;
   end ObstacleDistancePO;
   
   
   protected ActuatorDataPO is
      procedure Set(data : ActuatorData);
      entry Get(data : out ActuatorData);
   private
      ActuatorValues : ActuatorData;
      isUpdated : Boolean := False;
   end ActuatorDataPO;
   
end Brain5;
