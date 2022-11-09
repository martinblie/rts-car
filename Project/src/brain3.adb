with MicroBit.Radio;
with nRF.Radio;
use MicroBit;
with MicroBit.Console; use MicroBit.Console;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MotorController; use MotorController;
with CarObject; use CarObject;
with MicroBit.Accelerometer;
with LSM303AGR;
with DistanceSensors; use DistanceSensors;
with Helpers; use Helpers;
with MicroBit.Servos;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Brain3 is

   task body RecieveData is
      RxData : Radio.RadioData;
      period : Ada.Real_Time.Time_Span := Milliseconds(50);
      startTime : Ada.Real_Time.Time;
   begin
      Put_Line("Recieve started");
      startTime := Ada.Real_Time.Clock;
      RxData.Length := 8;
      RxData.Version:= 12;
      RxData.Group := 4;
      RxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2481,
                  Length => RxData.Length,
                  Version => RxData.Version,
                  Group => RxData.Group,
                  Protocol => RxData.Protocol);

      Radio.StartReceiving;
      Put_Line(Radio.State);
     -- Put_Line("magnetometer: " & LSM303AGR.Check_Magnetometer_Device_Id'Image);
     -- Put_Line("accel: " & LSM303AGR.Check_Accelerometer_Device_Id'Image);

      loop
         delay until startTime;
         startTime := startTime + period;
         --Put_Line("recieve loop started");
         while Radio.DataReady loop
            RXdata := Radio.Receive;
            
         end loop;
         RadioDataPO.Set(RxData.Payload);
         MagPO.Set(Accelerometer.MagData);
         --Put_Line("magdata: " & Accelerometer.MagData.X'Img & "  " & Accelerometer.MagData.Y'Img &
          --       "  " & Accelerometer.MagData.Z'Img);
            
         ObstacleDistancePO.Set(GetDistanceUltrasonic(Pins.Ultrasonic1Trigger,
                                  Pins.Ultrasonic1Echo));
         --Put_Line("recieve loop ended");
      end loop;
      
   end RecieveData;
   
   
   
   protected body RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data) is
      begin
         payloadData := payload;
         isUpdated := True;
      end Set;
      entry Get(payload : out nRF.Radio.Payload_Data)
        when isUpdated is
      begin
         payload := payloadData;
         isUpdated := False;
      end Get;
   end RadioDataPO;
   
   
   
   protected body MagPO is
      procedure Set(magReading : LSM303AGR.All_Axes_Data ) is
      begin
         magValues := magReading;
         isUpdated := True;
      end Set;
      entry Get(magVals : out LSM303AGR.All_Axes_Data)
        when isUpdated is
      begin
         magVals := magValues;
         isUpdated := False;
      end Get;
   end MagPO;
   
   
   
   protected body ObstacleDistancePO is
      procedure Set(Dist : Integer) is
      begin
         CurrentObstacleDistanceFront := Dist;
         IsUpdated := True;
      end Set;
      entry Get(Var : out Integer)
        when IsUpdated = True is
         begin
            Var := CurrentObstacleDistanceFront;
            IsUpdated := False;
         end Get;
   end ObstacleDistancePO;
   
   task body ProcessRadioData is
      rawMagData : LSM303AGR.All_Axes_Data;
      headingReference : Float;
      liveHeading : Float;
      targetHeading : Float;
      magTargetHeading : Float;
      obstacleDistance : Integer := 300;
      payloadData : nRF.Radio.Payload_Data;
      period : Ada.Real_Time.Time_Span := Milliseconds(100);
      startTime : Ada.Real_Time.Time;
      joystickAngle : Float;
      joystickMagnitude : Float;
      motorFloatLFRB : Float;
      motorFloatLBRF : Float;
      controllerEnabled : Boolean := True;
      isRerouting : Boolean := False;
      rerouteRight : Boolean := False;
      rerouteLeft : Boolean := False;
      actuatorValues : ActuatorData;
      strafeStartTime : Time;
      
   begin
      startTime := Clock;
      loop
         delay until startTime;
         startTime := startTime + period;
         --Put_Line("process data loop started");
         ObstacleDistancePO.Get(obstacleDistance);
         --Put_Line("obstacleDistance: " & obstacleDistance'Image);
         
         if obstacleDistance < 100 and obstacleDistance /= -1 then
            if not isRerouting then
               isRerouting := True;
               controllerEnabled := False;
               MagPO.Get(rawMagData);
               headingReference := Float(rawMagData.Y);
               headingReference := RemapRange(headingReference, -512.0,511.0,-Pi,Pi);
               actuatorValues.dirLF := Stop;
               actuatorValues.dirRF := Stop;
               actuatorValues.dirLB := Stop;
               actuatorValues.dirRB := Stop;
               ActuatorDataPO.Set(actuatorValues);
               ServoSequenceControllerPO.Trigger;
               TargetHeadingPO.get(targetHeading);
               magTargetHeading := AngleAdder(headingReference, targetHeading);
               Put_Line("heading reference: " & headingReference'Image);
               Put_Line("target heading: " & targetHeading'Image);
               motorFloatLFRB := sin((targetHeading) + (Pi/4.0));
               motorFloatLBRF := sin((targetHeading) - (Pi/4.0));
               strafeStartTime := Clock;
            end if;
         end if;
         
         if isRerouting then
            MagPO.Get(rawMagData);
            liveHeading := Float(rawMagData.Y);
            liveHeading := RemapRange(liveHeading, -512.0,511.0,-Pi,Pi);
            Put_Line("live heading: " & liveHeading'Image);
            
            if targetHeading >= 0.0 and not rerouteRight then
               rerouteRight := True;
            end if;
            
            if targetHeading < 0.0 and not rerouteLeft then
               rerouteLeft := True;
            end if;
            
            if rerouteRight then
               if magTargetHeading >= 0.0 then
                  if liveHeading >= magTargetHeading then
                     rerouteRight := False;
                     isRerouting := False;
                  end if;
               else
                  if liveHeading < 0.0 and liveHeading > magTargetHeading then
                     rerouteRight := False;
                     isRerouting := False;
                  end if;
               end if;
            end if;
            
            if rerouteLeft then
               if magTargetHeading < 0.0 then
                  if liveHeading <= magTargetHeading then
                     rerouteLeft := False;
                     isRerouting := False;
                  end if;
               else
                  if liveHeading > 0.0 and liveHeading < magTargetHeading then
                     rerouteLeft := False;
                     isRerouting := False;
                  end if;
               end if;
            end if;

         end if;
         
         
            
      
         if controllerEnabled then
            RadioDataPO.Get(payloadData);
            GetJoystickAngleAndMagnitude(payloadData(2), payloadData(1),
                                         joystickAngle, joystickMagnitude);
            Put_Line("JoystickAngle: " & joystickAngle'Image);
            Put_Line("JoystickMagnitude: " & joystickMagnitude'Image);
         
            motorFloatLFRB := sin(joystickAngle + (Pi/4.0)) * joystickMagnitude;
            motorFloatLBRF := sin(joystickAngle - (Pi/4.0)) * joystickMagnitude;
            Put_Line("motorFloatLFRB: " & motorFloatLFRB'Image);
         
            if payloadData(3) = 1 then
               controllerEnabled := False;
            end if;
         end if;
         
            
         if motorFloatLFRB >= 0.05 then
            actuatorValues.pwmLFRB := Analog_Value(RemapRange(motorFloatLFRB,
                                                  0.05, 1.0, 0.0, 1023.0));
            actuatorValues.dirLF := Forward;
            actuatorValues.dirRB := Forward;
         elsif motorFloatLFRB <= -0.05 then
            actuatorValues.pwmLFRB := Analog_Value(RemapRange(motorFloatLFRB,
                                                  -0.05, -1.0, 0.0, 1023.0));
            actuatorValues.dirLF := Backward;
            actuatorValues.dirRB := Backward;
         else
            actuatorValues.pwmLFRB := 0;
            actuatorValues.dirLF := Stop;
            actuatorValues.dirRB := Stop;
         end if;
            
         if motorFloatLBRF >= 0.05 then
            actuatorValues.pwmLBRF := Analog_Value(RemapRange(motorFloatLBRF,
                                                  0.05, 1.0, 0.0, 1023.0));
            actuatorValues.dirLB := Forward;
            actuatorValues.dirRF := Forward;
         elsif motorFloatLBRF <= -0.05 then
            actuatorValues.pwmLBRF := Analog_Value(RemapRange(motorFloatLBRF,
                                                  -0.05, -1.0, 0.0, 1023.0));
            actuatorValues.dirLB := Backward;
            actuatorValues.dirRF := Backward;
         else
            actuatorValues.pwmLBRF := 0;
            actuatorValues.dirLB := Stop;
            actuatorValues.dirRF := Stop;
         end if;
         
         
         if rerouteRight and Clock > strafeStartTime + Milliseconds(2000) then
            actuatorValues.pwmLFRB := 1023;
            actuatorValues.pwmLBRF := 1023;
            actuatorValues.dirLF := Forward;
            actuatorValues.dirLB := Forward;
            actuatorValues.dirRF := Backward;
            actuatorValues.dirRB := Backward;
         end if;
         
         if rerouteLeft and Clock > strafeStartTime + Milliseconds(2000) then
            actuatorValues.pwmLFRB := 1023;
            actuatorValues.pwmLBRF := 1023;
            actuatorValues.dirLF := Backward;
            actuatorValues.dirLB := Backward;
            actuatorValues.dirRF := Forward;
            actuatorValues.dirRB := Forward;
         end if;
         
         
            
            
            
               
           -- actuatorValues.pwmLFRB := Analog_Value(RemapRange(motorFloatLFRB,
           --                                       -1.0, 1.0, 0.0, 1023.0));

          --  actuatorValues.pwmLBRF := Analog_Value(RemapRange(motorFloatLBRF,
           --                                        -1.0, 1.0, 0.0, 1023.0));
         ActuatorDataPO.Set(actuatorValues);
         --Put_Line("process data loop ended");

               
            
         
      end loop;
   end ProcessRadioData;
   
   
   
            
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
   
   
   protected body ServoSequenceControllerPO is
      procedure Trigger is
      begin
         isTriggered := True;
      end Trigger;
      entry WaitForTrigger
        when isTriggered is
      begin
         isTriggered := False;
      end WaitForTrigger;
   end ServoSequenceControllerPO;
   
   
   protected body TargetHeadingPO is
      procedure Set(data : Float ) is
      begin
         HeadingData := data;
         isUpdated := True;
      end Set;
      entry Get(data : out Float)
        when isUpdated is
      begin
         data := HeadingData;
         isUpdated := False;
      end Get;
   end TargetHeadingPO;
   
   task body ServoSequence is
      period : Ada.Real_Time.Time_Span := Milliseconds(200);
      startTime : Ada.Real_Time.Time;
      leftDistance : Integer;
      rightDistance : Integer;
      leftDistanceFloat : Float;
      rightDistanceFloat : Float;
      relativeObstacleAngle : Float;
      targetHeading : Float;
      servoForward  : Servos.Servo_Set_Point := 90;
      servoRight : Servos.Servo_Set_Point := 110;
      
   begin
      startTime := Clock;
      Servos.Go(Pins.PwmServo, servoForward);
      loop
         delay until startTime;
         startTime := startTime + period;
         --Servos.Go(Pins.PwmServo, 90);
         ServoSequenceControllerPO.WaitForTrigger;
         ObstacleDistancePO.Get(leftDistance);
         Put_Line("leftDistance: " & leftDistance'Image);
         Servos.Go(Pins.PwmServo, servoRight);
         delay until Clock + Milliseconds(100);
         ObstacleDistancePO.Get(rightDistance);
         Put_Line("rightDistance: " & rightDistance'Image);
         Servos.Go(Pins.PwmServo, servoForward);
         leftDistanceFloat := Float(leftDistance);
         rightDistanceFloat := Float(rightDistance);
         if leftDistance /= -1 and rightDistance /= -1 then
            relativeObstacleAngle := AngleSolver(20.0, leftDistanceFloat,
                                                 rightDistanceFloat);
         else
            relativeObstacleAngle := 90.0;
         end if;
         
         if relativeObstacleAngle >= 90.0 then
            targetHeading := Pi - relativeObstacleAngle + Pi/2.0;
         else
            targetHeading := relativeObstacleAngle - Pi/2.0;
         end if;
         
         
         TargetHeadingPO.Set(targetHeading);
      end loop;
   end ServoSequence;
   
           
         
         
      
      
   
   
   task body Drive is
      actuatorValues : ActuatorData;
      period : Ada.Real_Time.Time_Span := Milliseconds(100);
      startTime : Ada.Real_Time.Time;
   begin
      startTime := Clock;
      --Servos.Go(Pins.PwmServo, 90);
      loop
         delay until startTime;
         startTime := startTime + period;
         --Put_Line("Drive loop started");
         ActuatorDataPO.Get(actuatorValues);
         
         SetDirectionRF(actuatorValues.dirRF);
         SetDirectionLF(actuatorValues.dirLF);
         SetDirectionLB(actuatorValues.dirLB);
         SetDirectionRB(actuatorValues.dirRB);
         SetSpeed1(actuatorValues.pwmLFRB);
         SetSpeed2(actuatorValues.pwmLBRF);
         --Put_Line("dirRF: " & actuatorValues.dirRF'Image);
         --Put_Line("dirLF: " & actuatorValues.dirLF'Image);
         --Put_Line("dirLB: " & actuatorValues.dirLB'Image);
         --Put_Line("dirRB: " & actuatorValues.dirRB'Image);
         --Put_Line("pwmLFRB: " & actuatorValues.pwmLFRB'Image);
         --Put_Line("pwmLBRF: " & actuatorValues.pwmLBRF'Image);
         --Put_Line("drive loop ended");
      end loop;
   end Drive;
   
         
      
      


      

end brain3;
