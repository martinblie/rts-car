with MotorController; use MotorController;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Servos; use MicroBit.Servos;
with MicroBit.Console; use MicroBit.Console;
with HAL; use HAL;
with MicroBit.Radio;
with Ada.Execution_Time;

package body Brain is

   task body Sense is
      NextRelease : Ada.Real_Time.Time;
      Period : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      Dist : Distance_cm;
   begin
      Set_Analog_Period_Us(20000);
      Ultrasonic.Setup(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
      NextRelease := Clock + Period;
    
      loop
         Dist := Ultrasonic.Read;
         ObstacleDistancePO.Set(Dist);
         delay until NextRelease;
         NextRelease := NextRelease + Period;

      end loop;
   end Sense;
   
   
   task body Recieve is
      RxData : Microbit.Radio.RadioData;
      Period : constant Ada.Real_Time.Time_Span := Milliseconds(5);
      NextRelease : Ada.Real_Time.Time;
   begin
      NextRelease := Clock + Period;
      RxData.Length := 9;
      RxData.Version:= 12;
      RxData.Group := 1;
      RxData.Protocol := 14;

      MicroBit.Radio.Setup(RadioFrequency => 2419,
                  Length => RxData.Length,
                  Version => RxData.Version,
                  Group => RxData.Group,
                  Protocol => RxData.Protocol);

      MicroBit.Radio.StartReceiving;

      loop
         while MicroBit.Radio.DataReady loop
            RXdata := MicroBit.Radio.Receive;
            RadioDataPO.Set(RxData.Payload);
         end loop;
         delay until NextRelease;
         NextRelease := NextRelease + Period;
      end loop;
      
   end Recieve;
   
   
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
   
   
   
   task body Compute is
      NextRelease : Ada.Real_Time.Time;
      Period : constant Ada.Real_Time.Time_Span := Milliseconds(5);
      -- Obstacle avoidance
      Dist : Ultrasonic.Distance_cm := 30;
      DistR : Ultrasonic.Distance_cm := 3;
      DistL : Ultrasonic.Distance_cm := 3;
      ServoInterval1 : Time_Span := Milliseconds(200);
      ServoInterval2 : Time_Span := Milliseconds(700);
      ServoStart1 : Time;
      ServoStart2 : Time;
      RerouteStart : Time;
      RerouteTime : Time_Span := Milliseconds(1000);
      CarState : CarStates := Scan;
      ServoState : ServoStates := Forward;
      PrevServoState : ServoStates := Left45;
      ActuatorValues : ActuatorData;
      -- RADIO CONTROL
      PayloadData : nRF.Radio.Payload_Data;
      SpeedRightFloat : Float;
      SpeedLeftFloat : Float;
      ControllerEnabled : Boolean;
      -- LED
      Led1 : Boolean;
      Led2: Boolean;
      LedTimer : Time;
      LedInterval : Time_Span := Milliseconds(220);
      BlinkCounter : Natural := 0;
      BlinkCounter2 : Natural := 0;
      BlinkCounter3 : Natural := 0;
      HasRepeated : Boolean := False;
   begin
      NextRelease := Clock + Period;
      ServoStart1 := Clock;
      ServoStart2 := Clock;
      LedTimer := Clock;
      loop
         Dist := ObstacleDistancePO.Get;
         PayloadData := RadioDataPO.Get;
         
         ------------------------
         ---- Radio control -----
         ------------------------
         
         if PayloadData(5) = 1 then
            ControllerEnabled := True;
            
         --FORWARD/BACKWARDS
            if PayloadData(1) > 134 then
               SpeedRightFloat := 1023.0 * ((1.0/(255.0-135.0))*(Float((PayloadData(1)))-135.0));
               SpeedLeftFloat := SpeedRightFloat;
               ActuatorValues.DirLF := Forward;
               ActuatorValues.DirRF := Forward;
               ActuatorValues.DirLB := Forward;
               ActuatorValues.DirRB := Forward;
         
            elsif PayloadData(1) < 120 then
               SpeedRightFloat := 1023.0 * ((1.0/(0.0-119.0))*(Float(PayloadData(1))-119.0));
               SpeedLeftFloat := SpeedRightFloat;
               ActuatorValues.DirLF := Backward;
               ActuatorValues.DirRF := Backward;
               ActuatorValues.DirLB := Backward;
               ActuatorValues.DirRB := Backward;
            else
               ActuatorValues.DirLF := Stop;
               ActuatorValues.DirRF := Stop;
               ActuatorValues.DirLB := Stop;
               ActuatorValues.DirRB := Stop;
            end if;
         
            -- LEFT/RIGHT
            if PayloadData(2) > 134 and PayloadData(2) < 196 then
               SpeedRightFloat := SpeedRightFloat *(1.0 + ((-1.0/(195.0-135.0))*(Float(PayloadData(2))-135.0)));
               
            elsif PayloadData(2) >= 196 then
               SpeedRightFloat := SpeedRightFloat *(0.0 + ((1.0/(255.0-196.0))*(Float(PayloadData(2))-196.0)));
               ActuatorValues.DirRF := Backward;
               ActuatorValues.DirRB := Backward;
         
            elsif payloadData(2) < 120 and PayloadData(2) > 60 then
               SpeedLeftFloat := SpeedLeftFloat *(1.0 + ((-1.0/(61.0-119.0))*(Float(PayloadData(2))-119.0)));
               
            elsif PayloadData(2) <= 60 then
               SpeedLeftFloat := SpeedLeftFloat *(0.0 + ((1.0/(0.0-60.0))*(Float(PayloadData(2))-60.0)));
               ActuatorValues.DirLF := Backward;
               ActuatorValues.DirLB := Backward;
         
            end if;
            
            -- STRAFE
            if PayloadData(3) > 170 then
               SpeedLeftFloat := 1023.0;
               SpeedRightFloat := 1023.0;
               if PayloadData(4) > 170 then
                  ActuatorValues.DirLF := Forward;
                  ActuatorValues.DirRF := Stop;
                  ActuatorValues.DirLB := Stop;
                  ActuatorValues.DirRB := Forward;
               elsif PayloadData(4) < 85 then
                  ActuatorValues.DirLF := Stop;
                  ActuatorValues.DirRF := Backward;
                  ActuatorValues.DirLB := Backward;
                  ActuatorValues.DirRB := Stop;
               else
                  ActuatorValues.DirLF := Forward;
                  ActuatorValues.DirRF := Backward;
                  ActuatorValues.DirLB := Backward;
                  ActuatorValues.DirRB := Forward;
               end if;
               
            elsif PayloadData(3) < 85 then
               SpeedLeftFloat := 1023.0;
               SpeedRightFloat := 1023.0;
               if PayloadData(4) > 170 then
                  ActuatorValues.DirLF := Stop;
                  ActuatorValues.DirRF := Forward;
                  ActuatorValues.DirLB := Forward;
                  ActuatorValues.DirRB := Stop;
               elsif PayloadData(4) < 85 then
                  ActuatorValues.DirLF := Backward;
                  ActuatorValues.DirRF := Stop;
                  ActuatorValues.DirLB := Stop;
                  ActuatorValues.DirRB := Backward;
               else
                  ActuatorValues.DirLF := Backward;
                  ActuatorValues.DirRF := Forward;
                  ActuatorValues.DirLB := Forward;
                  ActuatorValues.DirRB := Backward;
               end if;
            else
               if PayloadData(4) > 170 then
                  SpeedLeftFloat := 1023.0;
                  SpeedRightFloat := 1023.0;
                  ActuatorValues.DirLF := Forward;
                  ActuatorValues.DirRF := Forward;
                  ActuatorValues.DirLB := Forward;
                  ActuatorValues.DirRB := Forward;
               elsif PayloadData(4) < 85 then
                  SpeedLeftFloat := 1023.0;
                  SpeedRightFloat := 1023.0;
                  ActuatorValues.DirLF := Backward;
                  ActuatorValues.DirRF := Backward;
                  ActuatorValues.DirLB := Backward;
                  ActuatorValues.DirRB := Backward;
               end if;
            end if;    
            ActuatorValues.PwmLeft := Analog_Value(SpeedLeftFloat);
            ActuatorValues.PwmRight := Analog_Value(SpeedRightFloat);
         else
            ControllerEnabled := False;
         end if;
         
            
         
         
         ------------------------
         -- Obstacle avoidance --
         ------------------------
         
         case CarState is
            when Scan => if Dist < 19 then
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
                     if PrevServoState /= Right75 then
                        if Clock > ServoStart2 + (ServoInterval2/2) then
                           DistL := Dist;
                           ServoStart2 := Clock;
                           PrevServoState := ServoState;
                           ServoState := Right75;
                        end if;
                     else
                        if Clock > ServoStart2 + ServoInterval2 then
                           DistL := Dist;
                           if DistR >= DistL then
                              CarState := RerouteRight;
                              ServoState := Right45;
                           else
                              CarState := RerouteLeft;
                              ServoState := Left45;
                           end if;
                           RerouteStart := Clock;
                        end if;  
                     end if;
                     
                     
                  when Right75 =>
                     if PrevServoState /= Left75 then
                        if Clock > ServoStart2 + (ServoInterval2/2) then
                           DistR := Dist;
                           ServoStart2 := Clock;
                           PrevServoState := ServoState;
                           ServoState := Left75;
                        end if;
                     else
                        if Clock > ServoStart2 + ServoInterval2 then
                           DistR := Dist;
                           if DistR >= DistL then
                              CarState := RerouteRight;
                              ServoState := Right45;
                           else
                              CarState := RerouteLeft;
                              ServoState := Left45;
                           end if;
                           RerouteStart := Clock;
                        end if;  
                     end if;
                     
                  when Right45 =>
                     ServoState := Right75;
                     ServoStart2 := Clock;
                     
                  when Left45 =>
                     ServoState := Left75;
                     ServoStart2 := Clock;
                     
                  when Forward =>
                     if PrevServoState = Left45 then
                        ServoState := Left75;
                        ServoStart2 := Clock;
                     else
                        ServoState := Right75;
                        ServoStart2 := Clock;
                     end if;
                     
               end case;
               
               
            when RerouteLeft..RerouteRight =>
               if Clock > RerouteStart + RerouteTime then
                  CarState := Scan;
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
            when Scan => 
               if not ControllerEnabled then        -- Just drive forward if controller is disabled
                  ActuatorValues.DirLF := Forward;
                  ActuatorValues.DirRF := Forward;
                  ActuatorValues.DirLB := Forward;
                  ActuatorValues.DirRB := Forward;
                  ActuatorValues.PwmLeft  := 1023;
                  ActuatorValues.PwmRight := 1023;
               end if;
            when Calculate =>
               ActuatorValues.DirLF := Stop;
               ActuatorValues.DirRF := Stop;
               ActuatorValues.DirLB := Stop;
               ActuatorValues.DirRB := Stop;
            when RerouteRight =>
               ActuatorValues.DirLF := Forward;
               ActuatorValues.DirRF   := Backward;
               ActuatorValues.DirLB   := Forward;
               ActuatorValues.DirRB   := Backward;
               ActuatorValues.PwmLeft  := 1023;
               ActuatorValues.PwmRight := 1023;
            when RerouteLeft =>
               ActuatorValues.DirLF := Backward;
               ActuatorValues.DirRF   := Forward;
               ActuatorValues.DirLB   := Backward;
               ActuatorValues.DirRB   := Forward;
               ActuatorValues.PwmLeft  := 1023;
               ActuatorValues.PwmRight := 1023;
         end case;
         
         
         -------------------------
         ---------- LED ----------
         -------------------------
         
         if PayloadData(6) = 1 then
            if BlinkCounter <= 3 then
               if Clock < LedTimer + LedInterval then
                  Led1 := True;
                  Led2 := False;
               else
                  Led1 := False;
                  Led2 := True;
                  if Clock > LedTimer + (2*LedInterval) then
                     LedTimer := Clock;
                     BlinkCounter := BlinkCounter + 1;
                  end if;
               end if;
            else
               if BlinkCounter2 <= 4 then
                  if Clock < LedTimer + LedInterval/4 then
                     Led1 := True;
                     Led2 := False;
                  else
                     Led1 := False;
                     Led2 := False;
                     if Clock > LedTimer + (LedInterval/2) then
                        LedTimer := Clock;
                        BlinkCounter2 := BlinkCounter2 + 1;
                     end if;
                  end if;
               else
                  if BlinkCounter3 <= 4 then
                     if Clock < LedTimer + LedInterval/4 then
                        Led1 := False;
                        Led2 := True;
                     else
                        Led1 := False;
                        Led2 := False;
                        if Clock > LedTimer + (LedInterval/2) then
                           LedTimer := Clock;
                           BlinkCounter3 := BlinkCounter3 + 1;
                        end if;
                     end if;
                  else
                     if not HasRepeated then
                        BlinkCounter2 := 0;
                        BlinkCounter3 := 0;
                        LedTimer := Clock;
                        HasRepeated := True;
                     else
                        BlinkCounter := 0;
                        BlinkCounter2 := 0;
                        BlinkCounter3 := 0;
                        LedTimer := Clock;
                        HasRepeated := False;
                     end if;
                  end if;
               end if;
            end if;
         else
            led1 := False;
            led2 := False;
         end if;
         

                  
         ActuatorValues.Led1 := Led1;
         ActuatorValues.Led2 := Led2;            
         ActuatorDataPO.Set(ActuatorValues);
         delay until NextRelease;
         NextRelease := NextRelease + Period;
      end loop;
      
   end Compute;
      
               
   
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
         
         
   task body Act is
      ActuatorValues : ActuatorData;
      Period : constant Ada.Real_Time.Time_Span := Milliseconds(20);
      NextRelease : Ada.Real_Time.Time;
   begin
      NextRelease := Clock + Period;
      loop
         ActuatorValues := ActuatorDataPO.Get;
         SetDirectionRF(ActuatorValues.dirRF);
         SetDirectionLF(ActuatorValues.dirLF);
         SetDirectionLB(ActuatorValues.dirLB);
         SetDirectionRB(ActuatorValues.dirRB);
         SetSpeedLeft(ActuatorValues.PwmLeft);
         SetSpeedRight(ActuatorValues.PwmRight);
         MicroBit.Servos.Go(Pins.PwmServo, ActuatorValues.ServoAngle);
         MicroBit.IOsForTasking.Set(Pins.Led1, ActuatorValues.Led1);
         MicroBit.IOsForTasking.Set(Pins.Led2, ActuatorValues.Led2);
         delay until NextRelease;
         NextRelease := NextRelease + Period;
      end loop;
   end Act;
         
               
               
               
               
                     
                     
               
               

               


end Brain;
