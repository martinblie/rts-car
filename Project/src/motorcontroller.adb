

package body MotorController is
   procedure SetDirection(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                          Pin2 :MicroBit.IOsForTasking.Pin_Id;
                          Direction : Dir) is
      begin
      if Direction = Forward then
         MicroBit.IOsForTasking.Set(Pin1,True);
         MicroBit.IOsForTasking.Set(Pin2,False);
      elsif
        Direction = Backward then
         MicroBit.IOsForTasking.Set(Pin1,False);
         MicroBit.IOsForTasking.Set(Pin2,True);
      elsif Direction = Stop then
         MicroBit.IOsForTasking.Set(Pin1,False);
         MicroBit.IOsForTasking.Set(Pin2,False);
      end if;
   end SetDirection;
   
   procedure SetSpeed(Pin : MicroBit.IOsForTasking.Pin_Id;
                      Speed : MicroBit.IOsForTasking.Analog_Value) is
   begin
      MicroBit.IOsForTasking.Write(Pin, Speed);
   end SetSpeed;
   
   procedure SetDirectionAll(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1LB, Pins.Dir2LB, Direction);
      SetDirection(Pins.Dir1RB, Pins.Dir2RB, Direction);
      SetDirection(Pins.Dir1LF, Pins.Dir2LF, Direction);
      SetDirection(Pins.Dir1RF, Pins.Dir2RF, Direction);
   end SetDirectionAll;
   
        
      

   

end MotorController;
