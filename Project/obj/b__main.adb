pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;

package body ada_main is

   E061 : Short_Integer; pragma Import (Ada, E061, "ada__tags_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings__text_buffers_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "system__bb__timing_events_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "ada__exceptions_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__soft_links_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "system__exception_table_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "ada__streams_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "system__finalization_root_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "ada__finalization_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "system__storage_pools_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "system__finalization_masters_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ada__real_time_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "system__bb__execution_time_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "system__pool_global_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__tasking__protected_objects_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "system__tasking__protected_objects__multiprocessors_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__tasking__restricted__stages_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "hal__gpio_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "hal__i2c_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "hal__spi_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "hal__uart_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "lsm303agr_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "memory_barriers_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "cortex_m__nvic_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "nrf__events_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "nrf__gpio_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "nrf__gpio__tasks_and_events_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "nrf__interrupts_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "nrf__rtc_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "nrf__spi_master_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "nrf__tasks_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "nrf__clock_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "nrf__ppi_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "nrf__timers_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "nrf__twi_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "nrf__uart_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "nrf__device_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "microbit__console_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "microbit__i2c_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "microbit__accelerometer_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "microbit__timehighspeed_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "microbit__timewithrtc1_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "nrf__adc_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "microbit__iosfortasking_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "microbit__servos_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "carobject_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "motorcontroller_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "ultrasonic_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "brain5_E");

   Sec_Default_Sized_Stacks : array (1 .. 4) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := 0;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, True, True, False, False, False, False, True, 
           False, False, False, False, False, False, False, False, 
           True, True, True, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, True, True, False, False, True, True, 
           False, False, False, True, False, False, False, False, 
           True, False, True, True, False, False, False, False, 
           True, True, True, True, True, False, False, True, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, True, True, False, True, False, 
           False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, False, False, True, True, False, False, 
           False, False, False, True, True, True, True, False, 
           False, False, False, True, True, False, True, True, 
           False, True, True, False, True, True, False, True, 
           False, False, False, False, False, True, False, False, 
           True, False, False, False, True, True, False, False, 
           False, True, False, False, False, True, False, False, 
           False, False, False, False, False, False, True, False, 
           True, True, True, True, False, True, False, True, 
           True, True, False, True, True, False, False, True, 
           True, True, False, False, False, False, False, False, 
           False, False, True, False, False, True, False, True, 
           False),
         Count => (0, 0, 0, 1, 0, 0, 3, 0, 3, 0),
         Unknown => (False, False, False, False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 4;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Ada.Strings.Text_Buffers'Elab_Spec;
      E005 := E005 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E059 := E059 + 1;
      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      Ada.Tags'Elab_Body;
      E061 := E061 + 1;
      System.Exception_Table'Elab_Body;
      E096 := E096 + 1;
      E098 := E098 + 1;
      E012 := E012 + 1;
      Ada.Streams'Elab_Spec;
      E170 := E170 + 1;
      System.Finalization_Root'Elab_Spec;
      E177 := E177 + 1;
      Ada.Finalization'Elab_Spec;
      E175 := E175 + 1;
      System.Storage_Pools'Elab_Spec;
      E179 := E179 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E174 := E174 + 1;
      Ada.Real_Time'Elab_Body;
      E133 := E133 + 1;
      System.Bb.Execution_Time'Elab_Body;
      E131 := E131 + 1;
      System.Pool_Global'Elab_Spec;
      E181 := E181 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E139 := E139 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E147 := E147 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E129 := E129 + 1;
      HAL.GPIO'ELAB_SPEC;
      E172 := E172 + 1;
      HAL.I2C'ELAB_SPEC;
      E204 := E204 + 1;
      HAL.SPI'ELAB_SPEC;
      E197 := E197 + 1;
      HAL.UART'ELAB_SPEC;
      E208 := E208 + 1;
      LSM303AGR'ELAB_SPEC;
      LSM303AGR'ELAB_BODY;
      E269 := E269 + 1;
      E238 := E238 + 1;
      E236 := E236 + 1;
      E229 := E229 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E163 := E163 + 1;
      E231 := E231 + 1;
      E233 := E233 + 1;
      E192 := E192 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E195 := E195 + 1;
      E216 := E216 + 1;
      E252 := E252 + 1;
      E240 := E240 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E199 := E199 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E202 := E202 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E206 := E206 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E153 := E153 + 1;
      Microbit.Console'Elab_Body;
      E214 := E214 + 1;
      E271 := E271 + 1;
      Microbit.Accelerometer'Elab_Body;
      E267 := E267 + 1;
      Microbit.Timehighspeed'Elab_Body;
      E265 := E265 + 1;
      Microbit.Timewithrtc1'Elab_Spec;
      Microbit.Timewithrtc1'Elab_Body;
      E249 := E249 + 1;
      E212 := E212 + 1;
      Microbit.Iosfortasking'Elab_Spec;
      Microbit.Iosfortasking'Elab_Body;
      E210 := E210 + 1;
      E247 := E247 + 1;
      Carobject'Elab_Spec;
      E137 := E137 + 1;
      E254 := E254 + 1;
      E263 := E263 + 1;
      Brain5'Elab_Spec;
      Brain5'Elab_Body;
      E122 := E122 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   C:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\CarObject.o
   --   C:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\motorcontroller.o
   --   C:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\ultrasonic.o
   --   C:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\brain5.o
   --   C:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\main.o
   --   -LC:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\
   --   -LC:\Users\Martinsen\Documents\git-repos\rts-car\Project\obj\
   --   -LC:\Users\Martinsen\Documents\git-repos\Ada_Drivers_Library\boards\MicroBit_v2\obj\full_lib_Debug\
   --   -LC:\gnat\2021-arm-elf\arm-eabi\lib\gnat\ravenscar-full-nrf52833\adalib\
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
