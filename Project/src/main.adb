with CarObject; use CarObject;
with MicroBit.IOsForTasking;

procedure Main is
begin
  loop


      Car.SetDirectionLB(False);
      Car.SetSpeedLeft(150);

      MicroBit.IOsForTasking.Set(14,False);
  end loop;






end Main;
