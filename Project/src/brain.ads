with CarObject; use CarObject;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic; use Ultrasonic;
with nRF.Radio;

package Brain5 is
   
   type CarStates is
     (Scan, Calculate, RerouteLeft, RerouteRight);
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
      Led1       : Boolean;
      Led2       : Boolean;
   end record;
   
   

   task Sense with Priority => 1;
   task Recieve with Priority => 4;
   task Compute with Priority => 3;
   task Act with Priority => 2;
   
   protected RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data);
      function Get return nRF.Radio.Payload_Data;
   private
      payloadData : nRF.Radio.Payload_Data;
   end RadioDataPO;
   

   
   protected ObstacleDistancePO is
      procedure Set(Dist : Distance_cm);
      function Get return Distance_cm;
   private
      CurrentObstacleDistance : Distance_cm := 120;
   end ObstacleDistancePO;
   
   

   
   protected ActuatorDataPO is
      procedure Set(data : ActuatorData);
      function Get return ActuatorData;
   private
      ActuatorValues : ActuatorData;
   end ActuatorDataPO;
   
end Brain5;
