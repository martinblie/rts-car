with CarObject; use CarObject;
with MotorController; use MotorController;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic; use Ultrasonic;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Servos; use MicroBit.Servos;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Servos; use MicroBit.Servos;

package body Brain5 is

   task body Sense is
      StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(50);
      --measure
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 10; -- do 10 measurement and average
   begin
      StartTime := Ada.Real_Time.Clock;
      Ultrasonic.Setup(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
      -- measure
      Elapsed_Stopwatch := Time_Span_Zero;
      Elapsed_CPU := Time_Span_Zero;
      
      loop
         delay until StartTime;
         --measure
         Time_Now_Stopwatch := Clock;
         Time_Now_CPU := Clock;
         --end measure
         StartTime := StartTime + Period;
         --CurrentDist := GetDistanceUltrasonic(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
         --if CurrentDist /= PrevDist and CurrentDist /= -1 then
            ObstacleDistancePO.Set(Ultrasonic.Read);
           --PrevDist := CurrentDist;
           --end if;
          
         --measure
         Elapsed_CPU :=(Clock - Time_Now_CPU);
         Elapsed_Stopwatch := (Clock - Time_Now_Stopwatch);
         --end measure
         
            --Elapsed_CPU := Elapsed_CPU; -- / AmountOfMeasurement;
            --Elapsed_Stopwatch := Elapsed_Stopwatch; --/ AmountOfMeasurement;

            Put_Line ("Average CPU time: " & To_Duration (Elapsed_CPU)'Image & " seconds");
            Put_Line ("Average Stopwatch time: " & To_Duration (Elapsed_Stopwatch)'Image & " seconds");
           
         
         
      end loop;
   end Sense;
   
   protected body ObstacleDistancePO is
      procedure Set(Dist : Distance_cm) is
      begin
         CurrentObstacleDistance := Dist;
         IsUpdated := True;
      end Set;
      entry Get(Var : out Distance_cm)
        when IsUpdated = True is
      begin
         Var := CurrentObstacleDistance;
         IsUpdated := False;
      end Get;
   end ObstacleDistancePO;
   
   
   
   task body Compute is
      StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(100);
      Dist : Ultrasonic.Distance_cm := 30;
      DistR : Ultrasonic.Distance_cm := 3;
      DistL : Ultrasonic.Distance_cm := 3;
      ServoInterval1 : Time_Span := Milliseconds(200);
      ServoInterval2 : Time_Span := Milliseconds(800);
      ServoStart1 : Time;
      ServoStart2 : Time;
      RerouteStart : Time;
      RerouteTime : Time_Span := Milliseconds(2000);
      CarState : CarStates := SelfDriving;
      ServoState : ServoStates := Forward;
      PrevServoState : ServoStates := Left45;
      ActuatorValues : ActuatorData;
   begin
      Set_Analog_Period_Us(20000);
      StartTime := Ada.Real_Time.Clock;
      ServoStart1 := Clock;
      loop
         delay until StartTime;
         ObstacleDistancePO.Get(Dist);
         StartTime := StartTime + Period;

         
         case CarState is
            when SelfDriving => if Dist < 20 then
                  CarState := Calculate;
               end if;
               case ServoState is
                  when Forward =>
                     if Clock > ServoStart1 + ServoInterval1 then
                        if PrevServoState = Left45 then
                           ServoState := Right45;
                        else
                           ServoState := Left45;
                        end if;
                        PrevServoState := ServoState;
                        ServoStart1 := Clock;
                     end if;
                        
                  when Left45 =>
                     if Clock > ServoStart1 + ServoInterval1 then
                        ServoState := Forward;
                        ServoStart1 := Clock;
                     end if;
                        
                  when Right45 =>
                     if Clock > ServoStart1 + ServoInterval1 then
                        ServoState := Forward;
                        ServoStart1 := Clock;
                     end if;
                     
                     when others => ServoState := Forward;
               end case;
              
               
            when Calculate =>
               case ServoState is
                  when Left75 =>
                     if Clock > ServoStart2 + (ServoInterval2/2) then
                        DistL := Dist;
                        ServoStart2 := Clock;
                        ServoState := Right75;
                     end if;
                     
                  when Right75 =>
                     if Clock > ServoStart2 + ServoInterval2 then
                        DistR := Dist;
                        if DistR >= DistL then
                           CarState := RerouteRight;
                        else
                           CarState := RerouteLeft;
                        end if;
                        RerouteStart := Clock;
                        ServoState := Forward;
                     end if;
                     
                  when others =>
                     ServoState := Left75;
                     ServoStart2 := Clock;
               end case;
               
            when RerouteLeft..RerouteRight =>
               if Clock > RerouteStart + RerouteTime then
                  CarState := SelfDriving;
               end if;
         end case;
         
         
         case ServoState is
            when Forward => ActuatorValues.ServoAngle := 90;
            when Right45 => ActuatorValues.ServoAngle := 45;
            when Left45 => ActuatorValues.ServoAngle := 135;
            when Right75 => ActuatorValues.ServoAngle := 5;
            when Left75 => ActuatorValues.ServoAngle := 165;
         end case;
         
         case CarState is
            when SelfDriving => 
               ActuatorValues.DirLF := Forward;
               ActuatorValues.DirRF := Forward;
               ActuatorValues.DirLB := Forward;
               ActuatorValues.DirRB := Forward;
            when Calculate =>
               ActuatorValues.DirLF := Stop;
               ActuatorValues.DirRF := Stop;
               ActuatorValues.DirLB := Stop;
               ActuatorValues.DirRB := Stop;
            when RerouteRight =>
               ActuatorValues.DirLF := Forward;
               ActuatorValues.DirRF := Backward;
               ActuatorValues.DirLB := Forward;
               ActuatorValues.DirRB := Backward;
            when RerouteLeft =>
               ActuatorValues.DirLF := Backward;
               ActuatorValues.DirRF := Forward;
               ActuatorValues.DirLB := Backward;
               ActuatorValues.DirRB := Forward;
         end case;
         
         ActuatorDataPO.Set(ActuatorValues);
      end loop;
      
   end Compute;
      
               
         
         
         
   protected body ActuatorDataPO is
      procedure Set(data : ActuatorData ) is
      begin
         ActuatorValues := data;
         isUpdated := True;
      end Set;
      entry Get(data : out ActuatorData)
        when isUpdated is
      begin
         data := ActuatorValues;
         isUpdated := False;
      end Get;
   end ActuatorDataPO;
         
         
   task body Act is
      ActuatorValues : ActuatorData;
      period : Ada.Real_Time.Time_Span := Milliseconds(200);
      startTime : Ada.Real_Time.Time;
   begin
      startTime := Clock;
      Set_Analog_Period_Us(20000);
      loop
         delay until startTime;
         startTime := startTime + period;
         --Put_Line("Drive loop started");
         ActuatorDataPO.Get(ActuatorValues);
         
         SetDirectionRF(ActuatorValues.dirRF);
         SetDirectionLF(ActuatorValues.dirLF);
         SetDirectionLB(ActuatorValues.dirLB);
         SetDirectionRB(ActuatorValues.dirRB);
         SetSpeed1(ActuatorValues.PwmLeft);
         SetSpeed2(ActuatorValues.PwmRight);
         MicroBit.Servos.Go(Pins.PwmServo, ActuatorValues.ServoAngle);
      end loop;
   end Act;
         
               
               
               
               
                     
                     
               
               

               


end Brain5;
