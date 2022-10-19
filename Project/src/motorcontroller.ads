package MotorController is

   procedure SetDirection(Pin1 : MicroBit.IOsForTasking.Pin_Id,
                          Pin2 :MicroBit.IOsForTasking.Pin_Id,
                          Dir : Dir);
   procedure SetSpeed(Pin : MicroBit.IOsForTasking.Pin_Id,
                     Speed : MicroBit.IOsForTasking.Analog_Value);

end MotorController;
