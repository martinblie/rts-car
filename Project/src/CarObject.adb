package body CarObject is
   protected body Car is
      

      procedure SetDirectionHelper(Pin1 : MicroBit.IOsForTasking.Pin_Id;
                                   Pin2 : MicroBit.IOsForTasking.Pin_Id;
                                   Dir : Boolean) is
      begin
         if Dir = True then
            MicroBit.IOsForTasking.Set(Pin1,True);
            MicroBit.IOsForTasking.Set(Pin2,False);
         else
            MicroBit.IOsForTasking.Set(Pin1,False);
            MicroBit.IOsForTasking.Set(Pin2,True);
         end if;
      end SetDirectionHelper;
   
      procedure SetDirectionLB(Dir : Boolean) is
      begin
         SetDirectionHelper(Dir1LB, Dir2LB, Dir);
         CurrentDirectionLB := Dir;
      end SetDirectionLB;
   
      procedure SetDirectionRB( Dir : Boolean) is
      begin
         SetDirectionHelper(Dir1RB, Dir2RB, Dir);
         CurrentDirectionRB := Dir;
      end SetDirectionRB;
   
      procedure SetDirectionLF(Dir : Boolean) is
      begin
         SetDirectionHelper(Dir1LF, Dir2LF, Dir);
         CurrentDirectionLF := Dir;
      end SetDirectionLF;
   
      procedure SetDirectionRF(Dir : Boolean) is
      begin
         SetDirectionHelper(Dir1RF, Dir2RF, Dir);
         CurrentDirectionRF := Dir;
      end SetDirectionRF;
   
      function GetDirectionLB return Boolean is
      begin
         return CurrentDirectionLB;
      end GetDirectionLB;
   
      function GetDirectionRB return Boolean is
      begin
         return CurrentDirectionRB;
      end GetDirectionRB;
   
      function GetDirectionLF return Boolean is
      begin
         return CurrentDirectionLF;
      end GetDirectionLF;
   
      function GetDirectionRF return Boolean is
      begin
         return CurrentDirectionRF;
      end GetDirectionRF;
   
   
      procedure SetSpeedLeft(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         MicroBit.IOsForTasking.Write(PwmLeft, Speed);
         CurrentSpeedLeft := Speed;
      end SetSpeedLeft;
   
      procedure SetSpeedRight(Speed : MicroBit.IOsForTasking.Analog_Value) is
      begin
         MicroBit.IOsForTasking.Write(PwmRight, Speed);
         CurrentSpeedRight := Speed;
      end SetSpeedRight;
   
      function GetSpeedLeft return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedLeft;
      end GetSpeedLeft;
   
      function GetSpeedRight return MicroBit.IOsForTasking.Analog_Value is
      begin
         return CurrentSpeedRight;
      end GetSpeedRight;
   end Car;
   
   
  
   
   
   
   
   
      

end CarObject;
