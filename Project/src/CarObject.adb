package body CarObject is
   protected body Car is
      

      procedure SetDirectionHelper(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                                   Pin2 : MicroBit.IOsForTasking.Pin_Id;
                                   Dir : Direction) is
      begin
         if Dir = Forwards then
            MicroBit.IOsForTasking.Set(Pin1,True);
            MicroBit.IOsForTasking.Set(Pin2,False);
         elsif Dir = Backwards then
            MicroBit.IOsForTasking.Set(Pin1,False);
            MicroBit.IOsForTasking.Set(Pin2,True);
         else
            MicroBit.IOsForTasking.Set(Pin1,False);
            MicroBit.IOsForTasking.Set(Pin2,False);
         end if;
      end SetDirectionHelper;
   
      procedure SetDirectionLB(Dir : Direction) is
      begin
         SetDirectionHelper(Dir1LB, Dir2LB, Dir);
         CurrentDirectionLB := Dir;
      end SetDirectionLB;
   
      procedure SetDirectionRB( Dir : Direction) is
      begin
         SetDirectionHelper(Dir1RB, Dir2RB, Dir);
         CurrentDirectionRB := Dir;
      end SetDirectionRB;
   
      procedure SetDirectionLF(Dir : Direction) is
      begin
         SetDirectionHelper(Dir1LF, Dir2LF, Dir);
         CurrentDirectionLF := Dir;
      end SetDirectionLF;
   
      procedure SetDirectionRF(Dir : Direction) is
      begin
         SetDirectionHelper(Dir1RF, Dir2RF, Dir);
         CurrentDirectionRF := Dir;
      end SetDirectionRF;
   
      function GetDirectionLB return Direction is
      begin
         return CurrentDirectionLB;
      end GetDirectionLB;
   
      function GetDirectionRB return Direction is
      begin
         return CurrentDirectionRB;
      end GetDirectionRB;
   
      function GetDirectionLF return Direction is
      begin
         return CurrentDirectionLF;
      end GetDirectionLF;
   
      function GetDirectionRF return Direction is
      begin
         return CurrentDirectionRF;
      end GetDirectionRF;
   
   
      procedure SetSpeedLeft(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         MicroBit.IOsForTasking.Write(PwmLeft, Speed);
         CurrentSpeedLeft := Speed;
      end SetSpeedLeft;
   
      procedure SetSpeedRight(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         MicroBit.IOsForTasking.Write(PwmRight, Speed);
         CurrentSpeedRight := Speed;
      end SetSpeedRight;
   
      function GetSpeedLeft return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedLeft;
      end GetSpeedLeft;
   
<<<<<<< Updated upstream
      function GetSpeedRight return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedRight;
      end GetSpeedRight;
   end Car;
=======
      
   protected body ObstacleDistanceFront is
      procedure Set(Dist : Ultrasonic.Distance_cm) is
      begin
         CurrentObstacleDistanceFront := Dist;
         IsUpdated := True;
      end Set;
      entry Get(Var : out Ultrasonic.Distance_cm)
        when IsUpdated = True is
         begin
            Var := CurrentObstacleDistanceFront;
            IsUpdated := False;
         end Get;
   end ObstacleDistanceFront;
      


>>>>>>> Stashed changes
   
   
  
   
   
   
   
   
      

end CarObject;
