with nrf.Radio;

package Brain2 is
   
   task RecieveData with Priority => 1;
   task Act with Priority => 2;
   
   protected RadioDataPO with Priority => 5 is
      procedure Set(payload : nRF.Radio.Payload_Data);
      entry Get(payload : out nRF.Radio.Payload_Data);
   private
      payloadData : nRF.Radio.Payload_Data;
      isUpdated : Boolean := False;
   end RadioDataPO;
   
   

   

end Brain2;
