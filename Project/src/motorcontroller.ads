with CarObject; use CarObject;
with MicroBit.IOsForTasking;
package MotorController is

   procedure SetDirection(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                          Pin2 :MicroBit.IOsForTasking.Pin_Id;
                          Direction : Dir);
   procedure SetSpeed(Pin : MicroBit.IOsForTasking.Pin_Id;
                      Speed : MicroBit.IOsForTasking.Analog_Value);
   procedure SetDirectionAll(Direction : Dir);

end MotorController;
