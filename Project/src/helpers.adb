with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;
with System.Libm_Single;
with MicroBit.Console; use MicroBit.Console;

package body Helpers is

   function RemapRange(input : Float; inputMin : Float; inputMax : Float;
                       outputMin : Float; outputMax : Float) return Float is
      slope : Float;
   begin
      slope := (outputMax - outputMin) / (inputMax - inputMin);
      return outputMin + (slope * (input - inputMin));
   end RemapRange;
   

   
   
   
   procedure GetJoystickAngleAndMagnitude(xAxis : UInt8;
                                              yAxis : UInt8;
                                              angle : out Float;
                                              magnitude : out Float) is
      xValue : Float;
      yValue : Float;
   begin
      xValue := Float(xAxis);
      yValue := Float(yAxis);
      xValue := RemapRange(xValue, 0.0, 255.0, -1.0, 1.0);
      yValue := RemapRange(yValue, 0.0, 255.0, -1.0, 1.0);
      Put_Line("xValueREMAPPED: " & xValue'Image);
      Put_Line("yValueREMAPPED: " & yValue'Image);
      angle := System.Libm_Single.Atan2(yValue, xValue);
      magnitude := Sqrt((xValue*xValue) + (yValue*yValue));
      if magnitude > 1.0 then
         magnitude := 1.0;
      end if;
      
   end GetJoystickAngleAndMagnitude;
   
   function AngleSolver(ServoAngle : Float;
                        leftDist : Float; rightDist : Float) return Float is
      
      servoRadians : Float;
      oppositeDist : Float;
      leftAngle : Float;
   begin
      servoRadians := (ServoAngle * Pi) / 180.0;
      oppositeDist := Sqrt((rightDist*rightDist) + (leftDist*leftDist)
                           - (2.0 * leftDist * rightDist * Cos(ServoRadians)));
      
      leftAngle := Arccos((Sin(servoRadians) * rightDist) / leftDist);
      return leftAngle;
   end AngleSolver;
   
   function AngleAdder(angle1 : Float; angle2 : Float) return Float is
      sum : Float;
   begin
      sum := angle1 + angle2;
      if sum <= Pi then
         return sum;
      else
         return -Pi + (Pi - (sum));
      end if;
   end AngleAdder;
   
   function AngleSubtracter(angle1 : Float; angle2 : Float) return Float is
      sum : Float;
   begin
      sum := angle1 - angle2;
      if sum >= -Pi then
         return sum;
      else
         return Pi - ((sum) - Pi);
      end if;
   end AngleSubtracter;
   

         
   
      
      
      

end Helpers;
