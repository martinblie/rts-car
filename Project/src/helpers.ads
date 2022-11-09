with HAL; use HAL;

package Helpers is
   
   type MagnitudeValue is delta 0.001 range 0.0..1.0;

   function RemapRange(input : Float; inputMin : Float; inputMax : Float;
                       outputMin : Float; outputMax : Float) return Float;
   

   
   procedure GetJoystickAngleAndMagnitude(xAxis : UInt8;
                                         yAxis : UInt8;
                                         angle : out Float;
                                         magnitude : out Float);
   
   function AngleSolver(ServoAngle : Float;
                        leftDist : Float; rightDist : Float) return Float;
   
   function AngleAdder(angle1 : Float; angle2 : Float) return Float;
   
   function AngleSubtracter(angle1 : Float; angle2 : Float) return Float;
   
     

end Helpers;
