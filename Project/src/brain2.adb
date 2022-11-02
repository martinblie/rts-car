with MicroBit.Radio;
with nRF.Radio;
use MicroBit;
with MicroBit.Console; use MicroBit.Console;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;

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
   begin
      Put_Line("Act started");
      startTime := Ada.Real_Time.Clock;
      loop
         delay until startTime;
         startTime := startTime + period;
         RadioDataPO.Get(payloadData);
         Put_Line("Ostrich Received D1: " & UInt8'Image(payloadData(1)));
         Put_Line(" D2: " & UInt8'Image(payloadData(2)));
         Put_Line(" D3: " & UInt8'Image(payloadData(3)));
         Put_Line(" D4: " & UInt8'Image(payloadData(4)));
      end loop;
      
   end Act;
   
      
      
        
      

end Brain2;
