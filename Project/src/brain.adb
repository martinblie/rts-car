with CarObject; use CarObject;
with DistanceSensors; use DistanceSensors;
with MotorController; use MotorController;
package body Brain is
   task body DistanceSensorFrontManager is
      CurrentDist : Integer;
      PrevDist : Integer;
   begin
      loop
         CurrentDist := GetDistanceUltrasonic(Pins.Ultrasonic1Trigger, Pins.Ultrasonic1Echo);
         if CurrentDist /= PrevDist then
            ObstacleDistanceFront.Set(CurrentDist);
         end if;
      end loop;
   end DistanceSensorFrontManager;
   
   task body ObstacleAvoider is
      HasAvoided : Boolean := False;
   begin
      SetDirectionAll(Forward);
      loop
         if ObstacleDistanceFront.Get < 200 then
            while ObstacleDistanceFront.Get < 200 loop
               SetDirection(Pins.Dir1RB, Pins.Dir2RB, Backward);
               SetDirection(Pins.Dir1RF, Pins.Dir2RF, Backward);
            end loop;
            HasAvoided := True;
         end if;
         if HasAvoided then
            SetDirectionAll(Forward);
         end if;
      end loop;
      
      end ObstacleAvoider;
      
         

   

end Brain;
