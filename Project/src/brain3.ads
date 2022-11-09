with nRF.Radio;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with LSM303AGR;
with CarObject; use CarObject;

package brain3 is
   
   type ActuatorData is record
      pwmLFRB : Analog_Value;
      pwmLBRF : Analog_Value;
      dirLF : Dir;
      dirRF : Dir;
      dirLB : Dir;
      dirRB : Dir;
   end record;
   
      
   

   task RecieveData with Priority => 1;
   task ProcessRadioData with Priority => 2;
   task ServoSequence with Priority => 4;
   task Drive with Priority => 3;
   
   protected RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data);
      entry Get(payload : out nRF.Radio.Payload_Data);
   private
      payloadData : nRF.Radio.Payload_Data;
      isUpdated : Boolean := False;
   end RadioDataPO;
   
   protected MagPO is
      procedure Set(magReading : LSM303AGR.All_Axes_Data);
      entry Get(magVals : out LSM303AGR.All_Axes_Data);
   private
      magValues : LSM303AGR.All_Axes_Data;
      isUpdated : Boolean := False;
   end MagPO;
   
   protected ObstacleDistancePO is
      procedure Set(Dist : Integer);
      entry Get(Var : out Integer);
   private
      CurrentObstacleDistanceFront : Integer := 120;
      IsUpdated : Boolean := False;
   end ObstacleDistancePO;
   
   protected ActuatorDataPO is
      procedure Set(data : ActuatorData);
      entry Get(data : out ActuatorData);
   private
      ActuatorValues : ActuatorData;
      isUpdated : Boolean := False;
   end ActuatorDataPO;
   
   protected ServoSequenceControllerPO is
      procedure Trigger;
      entry WaitForTrigger;
   private
      isTriggered : Boolean := False;
   end ServoSequenceControllerPO;
   
   
   protected TargetHeadingPO is
      procedure Set(data : Float );
      entry Get(data : out Float);
   private
      HeadingData : Float;
      isUpdated : Boolean;
   end TargetHeadingPO;
   
   
   
   

end brain3;
