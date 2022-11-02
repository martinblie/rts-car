package body CarObject is
   
   
   
   
   
   
   protected body DirectionLB is
      procedure Set(Direction : Dir) is
      begin
         CurrentDirectionLB := Direction;
      end Set;
      function Get return Dir is
      begin
         return CurrentDirectionLB;
      end Get;
   end DirectionLB;
   
   protected body DirectionRB is
      procedure Set(Direction : Dir) is
      begin
         CurrentDirectionRB := Direction;
      end Set;
      function Get return Dir is
      begin
         return CurrentDirectionRB;
      end Get;
   end DirectionRB;
   
   protected body DirectionLF is
      procedure Set(Direction : Dir) is
      begin
         CurrentDirectionLF := Direction;
      end Set;
      function Get return Dir is
      begin
         return CurrentDirectionLF;
      end Get;
   end DirectionLF;
   
   protected body DirectionRF is
      procedure Set(Direction : Dir) is
      begin
         CurrentDirectionRF := Direction;
      end Set;
      function Get return Dir is
      begin
         return CurrentDirectionRF;
      end Get;
   end DirectionRF;
   
   protected body SpeedLeft is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         CurrentSpeedLeft := Speed;
      end Set;
      function Get return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedLeft;
      end Get;
   end SpeedLeft;
   
      
   protected body SpeedRight is
      procedure Set(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         CurrentSpeedRight := Speed;
      end Set;
      function Get return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedRight;
      end Get;
   end SpeedRight;
   
      
   protected body ObstacleDistanceFront is
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
   end ObstacleDistanceFront;
      


   
   
  
   
   
   
   
   
      

end CarObject;
