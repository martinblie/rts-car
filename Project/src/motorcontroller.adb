

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
   
   procedure SetSpeedLeft(Speed : Analog_Value) is
   begin
      SetSpeed(Pins.PwmLeft, Speed);
   end SetSpeedLeft;
   
   procedure SetSpeedRight(Speed : Analog_Value) is
   begin
      SetSpeed(Pins.PwmRight, Speed);
   end SetSpeedRight;
   
   
   
   procedure SetDirectionAll(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1LB, Pins.Dir2LB, Direction);
      SetDirection(Pins.Dir1RB, Pins.Dir2RB, Direction);
      SetDirection(Pins.Dir1LF, Pins.Dir2LF, Direction);
      SetDirection(Pins.Dir1RF, Pins.Dir2RF, Direction);
   end SetDirectionAll;
   
   
   procedure SetDirectionLB(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1LB, Pins.Dir2LB, Direction);
   end SetDirectionLB;
   
   procedure SetDirectionLF(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1LF, Pins.Dir2LF, Direction);
   end SetDirectionLF;
   
   procedure SetDirectionRB(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1RB, Pins.Dir2RB, Direction);
   end SetDirectionRB;
   
   procedure SetDirectionRF(Direction : Dir) is
   begin
      SetDirection(Pins.Dir1RF, Pins.Dir2RF, Direction);
   end SetDirectionRF;
   
   
        
      

   

end MotorController;
