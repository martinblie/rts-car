with CarObject; use CarObject;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
package MotorController is

   procedure SetDirection(Pin1 : Pin_Id;
                          Pin2 :Pin_Id;
                          Direction : Dir);
   procedure SetSpeed(Pin : Pin_Id;
                      Speed : Analog_Value);
   procedure SetSpeedLeft(Speed : Analog_Value);
   procedure SetSpeedRight(Speed : Analog_Value);

   procedure SetDirectionAll(Direction : Dir);

   procedure SetDirectionLB(Direction : Dir);
   procedure SetDirectionLF(Direction : Dir);
   procedure SetDirectionRB(Direction : Dir);
   procedure SetDirectionRF(Direction : Dir);

end MotorController;
