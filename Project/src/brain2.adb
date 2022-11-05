with MicroBit.Radio;
with nRF.Radio;
use MicroBit;
with MicroBit.Console; use MicroBit.Console;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MotorController; use MotorController;
with CarObject; use CarObject;

package body Brain2 is

   task body RecieveData is
      RxData : Radio.RadioData;
      period : Ada.Real_Time.Time_Span := Milliseconds(40);
      startTime : Ada.Real_Time.Time;
   begin
      Put_Line("Recieve started");
      startTime := Ada.Real_Time.Clock;
      RxData.Length := 8;
      RxData.Version:= 12;
      RxData.Group := 1;
      RxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2407,
                  Length => RxData.Length,
                  Version => RxData.Version,
                  Group => RxData.Group,
                  Protocol => RxData.Protocol);

      Radio.StartReceiving;
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode

      loop
         delay until startTime;
         startTime := startTime + period;
         --  --check if some data received and if so print it. Note that the framebuffer can max contain x messages (currently set to 4).
         --important! Sometimes data received contains junk since we dont do any package verification and radio transmission is noisy!
         while Radio.DataReady loop
            RXdata := Radio.Receive;
            RadioDataPO.Set(RxData.Payload);
         end loop;
      end loop;
      
   end RecieveData;
   
   protected body RadioDataPO is
      procedure Set(payload : nRF.Radio.Payload_Data) is
      begin
         payloadData := payload;
         isUpdated := True;
      end Set;
      
      entry Get(payload : out nRF.Radio.Payload_Data)
        when isUpdated is
      begin
         payload := payloadData;
         isUpdated := False;
      end Get;
   end RadioDataPO;
   
   task body Act is
      payloadData : nRF.Radio.Payload_Data;
      period : Ada.Real_Time.Time_Span := Milliseconds(50);
      startTime : Ada.Real_Time.Time;
      speedRight : Float := 0.0;
      speedLeft : Float := 0.0;
      direction : Dir;
   begin
      Put_Line("Act started");
      startTime := Ada.Real_Time.Clock;
      Set_Analog_Period_Us(20000);
      loop
         delay until startTime;
         startTime := startTime + period;
         RadioDataPO.Get(payloadData);
         Put_Line("D1: " & UInt8'Image(payloadData(1)));
         Put_Line(" D2: " & UInt8'Image(payloadData(2)));
         Put_Line(" D3: " & UInt8'Image(payloadData(3)));
         Put_Line(" D4: " & UInt8'Image(payloadData(4)));
         
        
         
         --FORWARD/BACKWARDS
         if payloadData(1) > 134 then
            speedRight := 1022.0 * ((1.0/(255.0-135.0))*(Float((payloadData(1)))-135.0));
            speedLeft := 1022.0 * ((1.0/(255.0-134.0))*(Float((payloadData(1)))-134.0));
            direction := Forward;
         
         elsif payloadData(1) < 120 then
               speedRight := 1022.0 * ((1.0/(0.0-121.0))*(Float(payloadData(1))-121.0));
               speedLeft := 1022.0 * ((1.0/(0.0-121.0))*(Float(payloadData(1))-121.0));
            direction := Backward;
         else
            direction := Stop;
         end if;
         
          -- LEFT/RIGHT
         if payloadData(2) > 134 then
            speedLeft := speedLeft *(1.0 + ((-1.0/(255.0-135.0))*(Float(payloadData(2))-135.0)));
         
         elsif payloadData(2) < 120 then
            speedRight := speedRight *(1.0 + ((-1.0/(0.0-119.0))*(Float(payloadData(2))-119.0)));

         end if;
         
         if payloadData(3) = 1 then
            
        
               
         
         SetSpeed(Pins.PwmLeft, Analog_Value(speedLeft));
         SetSpeed(Pins.PwmRight, Analog_Value(speedRight));
         SetDirectionAll(direction);
         Put_Line("lefspeed: " & speedLeft'Image);
         Put_Line("rightSpeed" & speedRight'Image);
         Put_Line("dir" & direction'Image);
               
               
         
        
         
                  
                                 
                                   
      end loop;
      
   end Act;
   
      
      
        
      

end Brain2;
