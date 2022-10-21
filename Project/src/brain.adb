with CarObject; use CarObject;
with DistanceSensors; use DistanceSensors;
with MotorController; use MotorController;
with Microbit.Console;
with Ada.Real_Time; use Ada.Real_Time;
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
   begin
      SetDirectionAll(Forward);
      StartTime := Ada.Real_Time.Clock;
      loop
         delay until StartTime;
         ObstacleDistanceFront.Get(Dist);
         StartTime := StartTime + Period;
         
         if dist < 100 and dist /= -1 then
            SetDirection(Pins.Dir1RB, Pins.Dir2RB, Backward);
            SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
            delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(1200);
            
            SetDirection(Pins.Dir1RB, Pins.Dir2RB, Forward);
            SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
            SetDirection(Pins.Dir1LB, Pins.Dir2LB, Backward);
            SetDirection(Pins.Dir1LF, Pins.Dir2LF, Forward);
            delay until Ada.Real_Time.Clock + Ada.Real_Time.Milliseconds(800);
            
           
            HasAvoided := True;
         end if;
         if HasAvoided then
            SetDirectionAll(Forward);
         end if;
      end loop;
      
      end ObstacleAvoider;
      
         

   

end Brain;
