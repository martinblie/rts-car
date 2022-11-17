with CarObject; use CarObject;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic; use Ultrasonic;
with nRF.Radio;

package CalculateExecutionTime is

   task CalculateExecution with Priority => 1;
   
    type CarStates is
     (Scan, Calculate, RerouteLeft, RerouteRight);
   type ServoStates is
     (Forward, Left45, Right45, Left75, Right75);
   
   
   
   type ActuatorData is record
      PwmLeft    : Analog_Value := 1023;
      PwmRight   : Analog_Value := 1023;
      ServoAngle : Servo_Set_Point := 130;
      DirLF      : Dir := Forward;
      DirRF      : Dir := Forward;
      DirLB      : Dir := Backward;
      DirRB      : Dir := Stop;
      Led1       : Boolean := True;
      Led2       : Boolean := False;
   end record;
   
   protected ObstacleDistancePO is
      procedure Set(Dist : Distance_cm);
      function Get return Distance_cm;
   private
      CurrentObstacleDistance : Distance_cm := 120;
   end ObstacleDistancePO;
   
   protected RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data);
      function Get return nRF.Radio.Payload_Data;
   private
      payloadData : nRF.Radio.Payload_Data;
   end RadioDataPO;
   
   protected ActuatorDataPO is
      procedure Set(data : ActuatorData);
      function Get return ActuatorData;
   private
      ActuatorValues : ActuatorData;
   end ActuatorDataPO;

end CalculateExecutionTime;
