with MicroBit.Accelerometer; use MicroBit.Accelerometer;
with LSM303AGR; use LSM303AGR;

package Magnetometer is
   
   type MagDataArray is array(1..10) of
   
   function GetAverage return All_Axes_Data;

   

end Magnetometer;
