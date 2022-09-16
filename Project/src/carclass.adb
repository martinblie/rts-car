package body CarClass is

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
   
   procedure SetDirectionLB(Self : in out Car; Dir : Boolean) is
   begin
      SetDirectionHelper(Dir1LB, Dir2LB, Dir);
      CurrentDirectionLB := Dir;
   end SetDirectionLB;
   
   procedure SetDirectionRB(Self : in out Car; Dir : Boolean) is
   begin
      SetDirectionHelper(Dir1RB, Dir2RB, Dir);
      CurrentDirectionRB := Dir;
   end SetDirectionRB;
   
   procedure SetDirectionLF(Self : in out Car; Dir : Boolean) is
   begin
      SetDirectionHelper(Dir1LF, Dir2LF, Dir);
      CurrentDirectionLF := Dir;
   end SetDirectionLF;
   
   procedure SetDirectionRF(Self : in out Car; Dir : Boolean) is
   begin
      SetDirectionHelper(Dir1RF, Dir2RF, Dir);
      CurrentDirectionRF := Dir;
   end SetDirectionRF;
   
   function GetDirectionLB(Self : in Car) return Boolean is
   begin
      return CurrentDirectionLB;
   end GetDirectionLB;
   
   function GetDirectionRB(Self : in Car) return Boolean is
   begin
      return CurrentDirectionRB;
   end GetDirectionRB;
   
   function GetDirectionLF(Self : in Car) return Boolean is
   begin
      return CurrentDirectionLF;
   end GetDirectionLF;
   
   function GetDirectionRF(Self : in Car) return Boolean is
   begin
      return CurrentDirectionRF;
   end GetDirectionRF;
   
   
   procedure SetSpeedLeft(Self : in out Car; Speed : Integer) is
   begin
      MicroBit.IOs.Set(PwmLeft, Speed);
      CurrentSpeedLeft := Speed;
   end SetSpeedLeft;
   
   procedure SetSpeedRight(Self : in out Car; Speed : Integer) is
   begin
      MicroBit.IOs.Set(PwmRight, Speed);
      CurrentSpeedRight := Speed;
   end SetSpeedRight;
   
   function GetSpeedLeft(Self : in Car) return Integer is
   begin
      return CurrentSpeedLeft;
      end GetSpeedLeft;
   
   function GetSpeedRight(Self : in Car) return Integer is
   begin
      return CurrentSpeedRight;
   end GetSpeedRight;
   
  
   
   
   
   
   
      

end CarClass;
