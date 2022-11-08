with CarObject; use CarObject;
with DistanceSensors; use DistanceSensors;
with MotorController; use MotorController;
--with Microbit.Console; use MicroBit.Console;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Servos; use MicroBit.Servos;
with Servocontrol; use Servocontrol;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic; use Ultrasonic;
--measure
with Ada.Text_IO; use Ada.Text_IO; -- instead of MicroBit.Console we can also use Ada.Text_IO (in the Serial Ports view) for convenience which use the same API's
with Ada.Execution_Time; use Ada.Execution_Time;
package body Brain is
   task body DistanceSensorFrontManager is
      CurrentDist : Ultrasonic.Distance_cm;
      PrevDist : Integer := 0;
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
         CurrentDist:= Ultrasonic.Read;
         Put_Line("currentdist: " & CurrentDist'Image);
         --CurrentDist := GetDistanceUltrasonic(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
         --if CurrentDist /= PrevDist and CurrentDist /= -1 then
            ObstacleDistanceFront.Set(CurrentDist);
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
   end DistanceSensorFrontManager;
   
   task body ObstacleAvoider is
      HasAvoided : Boolean := False;
      StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(100);
      Dist : Ultrasonic.Distance_cm := 30;
      DistR : Ultrasonic.Distance_cm := 3;
      DistL : Ultrasonic.Distance_cm := 3;
      dir1 : Servo_Set_Point := 5;
      dir2 : Servo_Set_Point := 160;
      dir45R : Servo_Set_Point := 45;
      dir45L : Servo_Set_Point :=135;
      dirF : Servo_Set_Point := 90;
      servoInterval : Time_Span := Milliseconds(300);
      servo1Start : Time;
      servo2Start : Time;
      servo3Start : Time;
   begin
      Set_Analog_Period_Us(20000);
      SetSpeed(pins.PwmLeft, 1023);
      setspeed(pins.PwmRight, 1023);
      SetDirectionAll(Forward);
      StartTime := Ada.Real_Time.Clock;
      Servocontrol.turnServo(dirF);
      servo1Start := Clock;
      servo2Start := servo1Start + servoInterval;
      servo3Start := servo2Start + servoInterval;
      loop
         delay until StartTime;
         ObstacleDistanceFront.Get(Dist);
         StartTime := StartTime + Period;
         --Put_Line("dist: " & dist'Image);
         --delay 0.1;
         if Clock > servo1Start + servoInterval then
            turnServo(dir45R);
            servo1Start := servo1Start + 3*servoInterval;
         end if;
         
         if Clock > servo2Start + servoInterval then
            turnServo(dirF);
            servo2Start := servo2Start + 3*servoInterval;
            end if;
         if Clock > servo3Start + servoInterval then
            turnServo(dir45L);
            servo3Start := servo3Start + 3*servoInterval;
         end if;
         
         if dist < 20 then
            SetDirectionAll(Stop);
            Servocontrol.turnServo(dir1);
            delay 0.5;
            ObstacleDistanceFront.Get(DistR);
            Put_Line("distance R: " & DistR'Image);
            Servocontrol.turnServo(dir2);
            delay 0.5;
            ObstacleDistanceFront.Get(DistL);
            Put_Line("distance L: " & DistL'Image);
            if DistL > DistR then   
               SetDirection(Pins.Dir1RB, Pins.Dir2RB, Forward);
               SetDirection(Pins.Dir1RF, Pins.Dir2RF, Forward);
               SetDirection(Pins.Dir1LB, Pins.Dir2LB, Backward);
               SetDirection(Pins.Dir1LF, Pins.Dir2LF, Backward);
               delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(1000);
               Servocontrol.turnServo(dirF);
            elsif DistR > DistL or DistR = -1 then
               SetDirection(Pins.Dir1RB, Pins.Dir2RB, Backward);
               SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
               SetDirection(Pins.Dir1LB, Pins.Dir2LB, Forward);
               SetDirection(Pins.Dir1LF, Pins.Dir2LF, Forward);
               delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(1000);
               Servocontrol.turnServo(dirF);
               

            end if;
            
               
           -- delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(1200);
            
            --SetDirection(Pins.Dir1RB, Pins.Dir2RB, Forward);
            --SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
            --SetDirection(Pins.Dir1LB, Pins.Dir2LB, Backward);
            --SetDirection(Pins.Dir1LF, Pins.Dir2LF, Forward);
            --delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(800);
            
           
            HasAvoided := True;
         end if;
         if HasAvoided then
            SetDirectionAll(Forward);
         end if;
      end loop;
      
      end ObstacleAvoider;
      
         

   

end Brain;
