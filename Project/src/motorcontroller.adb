with CarObject use CarObject;

package body MotorController is
   procedure SetDirection(Pin1 : MicroBit.IOsForTasking.Pin_Id,
                          Pin2 :MicroBit.IOsForTasking.Pin_Id,
                          Dir : Dir) is
      begin
      if Dir = Forward then
         MicroBit.IOsForTasking.Set(Pin1,True);
         MicroBit.IOsForTasking.Set(Pin2,False);
      elsif
        Dir = Backward then
         MicroBit.IOsForTasking.Set(Pin1,False);
         MicroBit.IOsForTasking.Set(Pin2,True);
      else
         MicroBit.IOsForTasking.Set(Pin1,False);
         MicroBit.IOsForTasking.Set(Pin2,False);
      end if;
   end SetDirection;
   
   procedure SetSpeed(Pin : MicroBit.IOsForTasking.Pin_Id,
                      Speed : MicroBit.IOsForTasking.Analog_Value) is
   begin
      MicroBit.IOsForTasking.Write(Pin, Speed);
   end SetSpeed;
   
                      
      
      

   

end MotorController;
