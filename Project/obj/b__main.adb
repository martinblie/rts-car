pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;

package body ada_main is

   E105 : Short_Integer; pragma Import (Ada, E105, "ada__tags_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "ada__strings__text_buffers_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__bb__timing_events_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "ada__exceptions_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__soft_links_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "system__exception_table_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "ada__streams_E");
   E168 : Short_Integer; pragma Import (Ada, E168, "system__finalization_root_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "ada__finalization_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "system__storage_pools_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "system__finalization_masters_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__real_time_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "system__pool_global_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "system__tasking__protected_objects_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "system__tasking__protected_objects__multiprocessors_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "system__tasking__restricted__stages_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "hal__gpio_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "hal__i2c_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "hal__spi_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "hal__uart_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "memory_barriers_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "cortex_m__nvic_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "nrf__events_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "nrf__gpio_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "nrf__gpio__tasks_and_events_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "nrf__interrupts_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "nrf__rtc_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "nrf__spi_master_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "nrf__tasks_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "nrf__adc_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "nrf__clock_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "nrf__ppi_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "nrf__timers_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "nrf__twi_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "nrf__uart_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "nrf__device_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "microbit__console_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "microbit__iosfortasking_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "distancesensors_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "microbit__servos_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "microbit__timewithrtc1_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "carobject_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "motorcontroller_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "servocontrol_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "brain_E");

   Sec_Default_Sized_Stacks : array (1 .. 3) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

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
           True, False, False, False, True, True, False, True, 
           False, True, False, False, False, True, False, False, 
           False, False, False, False, False, False, True, False, 
           True, True, True, True, False, True, False, True, 
           True, True, False, True, True, False, False, True, 
           True, True, False, False, False, False, False, False, 
           False, False, True, False, False, True, False, True, 
           False),
         Count => (0, 0, 0, 1, 0, 0, 2, 0, 3, 0),
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
      Binder_Sec_Stacks_Count := 3;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Ada.Strings.Text_Buffers'Elab_Spec;
      E096 := E096 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E094 := E094 + 1;
      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      Ada.Tags'Elab_Body;
      E105 := E105 + 1;
      System.Exception_Table'Elab_Body;
      E045 := E045 + 1;
      E047 := E047 + 1;
      E022 := E022 + 1;
      Ada.Streams'Elab_Spec;
      E161 := E161 + 1;
      System.Finalization_Root'Elab_Spec;
      E168 := E168 + 1;
      Ada.Finalization'Elab_Spec;
      E166 := E166 + 1;
      System.Storage_Pools'Elab_Spec;
      E170 := E170 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E165 := E165 + 1;
      Ada.Real_Time'Elab_Body;
      E006 := E006 + 1;
      System.Pool_Global'Elab_Spec;
      E172 := E172 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E130 := E130 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E138 := E138 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E236 := E236 + 1;
      HAL.GPIO'ELAB_SPEC;
      E163 := E163 + 1;
      HAL.I2C'ELAB_SPEC;
      E195 := E195 + 1;
      HAL.SPI'ELAB_SPEC;
      E188 := E188 + 1;
      HAL.UART'ELAB_SPEC;
      E199 := E199 + 1;
      E227 := E227 + 1;
      E225 := E225 + 1;
      E218 := E218 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E154 := E154 + 1;
      E220 := E220 + 1;
      E222 := E222 + 1;
      E183 := E183 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E186 := E186 + 1;
      E205 := E205 + 1;
      E203 := E203 + 1;
      E246 := E246 + 1;
      E229 := E229 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E190 := E190 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E193 := E193 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E197 := E197 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E144 := E144 + 1;
      Microbit.Console'Elab_Body;
      E250 := E250 + 1;
      Microbit.Iosfortasking'Elab_Spec;
      Microbit.Iosfortasking'Elab_Body;
      E201 := E201 + 1;
      E248 := E248 + 1;
      E241 := E241 + 1;
      Microbit.Timewithrtc1'Elab_Spec;
      Microbit.Timewithrtc1'Elab_Body;
      E243 := E243 + 1;
      Carobject'Elab_Spec;
      E128 := E128 + 1;
      E252 := E252 + 1;
      E254 := E254 + 1;
      Brain'Elab_Spec;
      Brain'Elab_Body;
      E124 := E124 + 1;
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
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\distancesensors.o
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\CarObject.o
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\motorcontroller.o
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\servocontrol.o
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\brain.o
   --   C:\Users\even1\Documents\git-repos\rts-car\Project\obj\main.o
   --   -LC:\Users\even1\Documents\git-repos\rts-car\Project\obj\
   --   -LC:\Users\even1\Documents\git-repos\rts-car\Project\obj\
   --   -LC:\Users\even1\Documents\git-repos\Ada_Drivers_Library\boards\MicroBit_v2\obj\full_lib_Debug\
   --   -LC:\gnat\2021-arm-elf\arm-eabi\lib\gnat\ravenscar-full-nrf52833\adalib\
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
