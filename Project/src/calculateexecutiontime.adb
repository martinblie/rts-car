with MotorController; use MotorController;
with Ultrasonic; use Ultrasonic;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Servos; use MicroBit.Servos;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;
with HAL; use HAL;
with MicroBit.IOsForTasking;
with MicroBit.Radio;

-- SENSE                                 T = 20
-- WORST CASE CPU = 0.008514404 @ 100cm, 0.00360174 @ 20cm
-- AVERAGE (1000 samples) = 0.006096840

-- RECIEVE
-- WORST CASE CPU = 0.000030518          T = 8
-- WORST CASE STOPWATCH = 0.000061035
--AVERAGE CPU (1000 samples) = 0.000005722
--AVERAGE STOPWATCH = 0.000013351

-- COMPUTE
-- WORST CASE CPU = 0.000061035 , 0.000091553    T = 10
-- WORST CASE STOPWATCH = 0.000091553, 0.000091553
--AVERAGE CPU (1000 samples) = 0.000031471, 0.000046730
--AVERAGE STOPWATCH = 0.000039101, 0.000052049

-- ACT
-- WORST CASE CPU = 0.000396729             T = 12
-- WORST CASE STOPWATCH = 0.000396729
--AVERAGE CPU (1000 samples) = 0.000081062
--AVERAGE STOPWATCH = 0.000088692



package body CalculateExecutionTime is

   task body CalculateExecution is
    StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(300);
      -- put task variables here

      Dist : Distance_cm;
      tog : Boolean := True;
      --measurement variables
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      Worst_Elapsed_CPU : Time_Span;
      Worst_Elapsed_Stopwatch : Time_Span;
      AmountOfMeasurement: Integer := 1; -- 1000 for average, 1 for worst case
   begin
      StartTime := Ada.Real_Time.Clock;
      -- Put task setup stuff here
      Ultrasonic.Setup(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
      --RadioDataPO.Set((110,50,127,50,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
      --ObstacleDistancePO.Set(9);
      -- measurement setup stuff
      Worst_Elapsed_CPU := Time_Span_Zero;
      Worst_Elapsed_Stopwatch := Time_Span_Zero;
      loop
         delay until StartTime;
         StartTime := StartTime + Period;
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;
            -- put task looping code here
            --Dist := Ultrasonic.Read;
            ObstacleDistancePO.Set(Ultrasonic.Read);
            
            -- measurement looping code
            Elapsed_CPU := (Clock - Time_Now_CPU);
            Elapsed_Stopwatch := (Clock - Time_Now_Stopwatch);
            
            if Elapsed_CPU > Worst_Elapsed_CPU then
            Worst_Elapsed_CPU := Elapsed_CPU;
         end if;
         
         if Elapsed_Stopwatch > Worst_Elapsed_Stopwatch then
            Worst_Elapsed_Stopwatch := Elapsed_Stopwatch;
            end if;
        
            --MicroBit.IOsForTasking.Set(12, tog);
            --tog := not tog;
              
            
         end loop;
         
         
         

         

         --Put_Line ("Average CPU time: " & To_Duration (Elapsed_CPU)'Image & " seconds");
         --Put_Line ("Average Stopwatch time: " & To_Duration (Elapsed_Stopwatch)'Image & " seconds");
         Put_Line ("Worst CPU time: " & To_Duration (Worst_Elapsed_CPU)'Image & " seconds");
         --Put_Line ("Worst Stopwatch time: " & To_Duration (Worst_Elapsed_Stopwatch)'Image & " seconds");
         --Put_Line("x: " & RadioDataPO.Get(1)'Img);
           
         
         
      end loop;
   end CalculateExecution;
   
   
   protected body ObstacleDistancePO is
      procedure Set(Dist : Distance_cm) is
      begin
         CurrentObstacleDistance := Dist;
      end Set;
      function Get return Distance_cm is
      begin
         return CurrentObstacleDistance;
      end Get;
   end ObstacleDistancePO;
   
   protected body RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data) is
      begin
         payloadData := payload;
      end Set;
      function Get return nRF.Radio.Payload_Data is
      begin
         return payloadData;
      end Get;
   end RadioDataPO;
   
   protected body ActuatorDataPO is
      procedure Set(data : ActuatorData ) is
      begin
         ActuatorValues := data;
      end Set;
      function Get return ActuatorData is
      begin
         return ActuatorValues;
        end Get;
     end ActuatorDataPO;

end CalculateExecutionTime;
