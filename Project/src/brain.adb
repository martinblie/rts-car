with CarObject; use CarObject;
with DistanceSensors; use DistanceSensors;
with MotorController; use MotorController;
with Microbit.Console;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Servos; use MicroBit.Servos;
with Servocontrol;
package body Brain is
   task body DistanceSensorFrontManager is
      CurrentDist : Integer;
      PrevDist : Integer := 0;
      StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(50);
   begin
      StartTime := Ada.Real_Time.Clock;
      loop
         delay until StartTime;
         StartTime := StartTime + Period;
         CurrentDist := GetDistanceUltrasonic(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
         if CurrentDist /= PrevDist and CurrentDist /= -1 then
            ObstacleDistanceFront.Set(CurrentDist);
            PrevDist := CurrentDist;
         end if;
         
         
      end loop;
   end DistanceSensorFrontManager;
   
   task body ObstacleAvoider is
      HasAvoided : Boolean := False;
      StartTime : Ada.Real_Time.Time;
      Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(50);
      Dist : Integer := 0;
      DistL : integer := 0;
      DistR : Integer := 0;
      dir1 : Servo_Set_Point := 5;
      dir2 : Servo_Set_Point := 155;
      dirF : Servo_Set_Point := 90;
   begin
      SetDirectionAll(Forward);
      StartTime := Ada.Real_Time.Clock;
      loop
         delay until StartTime;
         ObstacleDistanceFront.Get(Dist);
         StartTime := StartTime + Period;
         
         if dist < 100 and dist /= -1 then
            SetDirectionAll(Stop);
            Servocontrol.turnServo(dir1);
            ObstacleDistanceFront.Get(DistL);
            Servocontrol.turnServo(dir2);
            ObstacleDistanceFront.Get(DistR);
            if DistL > DistR then   
               SetDirection(Pins.Dir1RB, Pins.Dir2RB, Backward);
               SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
               SetDirection(Pins.Dir1LB, Pins.Dir2LB, Forward);
               SetDirection(Pins.Dir1LF, Pins.Dir2LF, Forward);
               delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(800);
               Servocontrol.turnServo(dirF);
            else
               SetDirection(Pins.Dir1RB, Pins.Dir2RB, Forward);
               SetDirection(Pins.Dir1RF, Pins.Dir2RF, Forward);
               SetDirection(Pins.Dir1LB, Pins.Dir2LB, Backward);
               SetDirection(Pins.Dir1LF, Pins.Dir2LF, Backward);
               delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(800);
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
