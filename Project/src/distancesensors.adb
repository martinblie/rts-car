with Ada.Real_Time; use Ada.Real_Time;

package body DistanceSensors is
   
 --  procedure IoIsr is
  --    TimerStart : Ada.Real_Time.Time;
 --  begin
 --     TimerStart := Ada.Real_Time.Clock;
      

   function GetDistanceUltrasonic(TriggerPin : Pin_Id;
                                   EchoPin : Pin_Id) return Integer is
      TimerStart : Ada.Real_Time.Time;
      Timer2Start : Ada.Real_Time.Time;
      EchoLength : Duration;
      DistanceInMm : Integer;
      Tog : Boolean;
      
      begin
      --nRF.GPIO.Tasks_And_Events.Enable_Event(0,EchoPin,Falling_Edge);
      Set(TriggerPin, True);
      TimerStart := Ada.Real_Time.Clock;
      delay until (Ada.Real_Time.Clock + Ada.Real_Time.Microseconds(10));
      Set(TriggerPin, False);
      Timer2Start := Ada.Real_Time.Clock;
      
      Tog := Set(EchoPin);
      
      while Tog = Set(EchoPin) loop
         if Ada.Real_Time.Clock > (Timer2Start + Ada.Real_Time.Milliseconds(5)) then
            return -1;
         end if;
      end loop;
      
      Timer2Start := Ada.Real_Time.Clock;
      
      
      while Set(EchoPin) = False loop
         if Ada.Real_Time.Clock > (Timer2Start + Ada.Real_Time.Milliseconds(5)) then
            return -1;
         end if;
         
      end loop;
      
      if Set(EchoPin) = True then
        TimerStart := Ada.Real_Time.Clock;
         while Set(EchoPin) = True loop
            if Ada.Real_Time.Clock > (TimerStart + Ada.Real_Time.Milliseconds(5)) then
               return -1;
            end if;
         end loop;
         
            
      EchoLength := Ada.Real_Time.To_Duration(Ada.Real_Time.Clock - TimerStart);
         DistanceInMm := Integer((Float(EchoLength)/5.8)*1000000.0);
        -- DistanceInMm := Integer((Float(EchoLength)*340.0/2.0))*10000000;
         return DistanceInMm;
      end if;
      return -1;
      
      
   end GetDistanceUltrasonic;
   
   
      
      
      
      
   
   

end DistanceSensors;
