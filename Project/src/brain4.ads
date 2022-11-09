with Ultrasonic; use Ultrasonic;

package Brain4 is
   
   task DistanceSensorFrontManager with Priority => 1;
   task ObstacleAvoider with Priority => 2;
   
   protected ObstacleDistancePO with Priority => 5 is
      procedure Set(Dist : Distance_cm);
      entry Get(Var : out Distance_cm);
   private
      CurrentObstacleDistanceFront : Distance_cm := 120;
      IsUpdated : Boolean := False;
   end ObstacleDistancePO;
     
     

   

end Brain4;
