pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;

package body ada_main is

   E137 : Short_Integer; pragma Import (Ada, E137, "ada__text_io_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__tags_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings__text_buffers_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "system__bb__timing_events_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "ada__exceptions_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__soft_links_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "system__exception_table_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "ada__streams_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "system__finalization_root_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "ada__finalization_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "system__storage_pools_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "system__finalization_masters_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ada__real_time_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "system__bb__execution_time_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__pool_global_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__tasking__protected_objects_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__tasking__protected_objects__multiprocessors_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__tasking__restricted__stages_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "hal__gpio_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "hal__i2c_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "hal__spi_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "hal__uart_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "lsm303agr_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "memory_barriers_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "cortex_m__nvic_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "nrf__events_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "nrf__gpio_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "nrf__gpio__tasks_and_events_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "nrf__interrupts_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "nrf__rtc_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "nrf__spi_master_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "nrf__tasks_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "nrf__adc_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "nrf__clock_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "nrf__ppi_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "nrf__timers_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "nrf__twi_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "nrf__uart_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "nrf__device_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "microbit__console_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "microbit__i2c_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "microbit__accelerometer_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "microbit__iosfortasking_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "distancesensors_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "microbit__servos_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "microbit__timehighspeed_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "microbit__timewithrtc1_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "carobject_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "motorcontroller_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "servocontrol_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "ultrasonic_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "brain4_E");

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
           False, True, True, False, True, True, True, True, 
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

      Ada.Text_Io'Elab_Body;
      E137 := E137 + 1;
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
      E172 := E172 + 1;
      System.Finalization_Root'Elab_Spec;
      E179 := E179 + 1;
      Ada.Finalization'Elab_Spec;
      E177 := E177 + 1;
      System.Storage_Pools'Elab_Spec;
      E181 := E181 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E176 := E176 + 1;
      Ada.Real_Time'Elab_Body;
      E133 := E133 + 1;
      System.Bb.Execution_Time'Elab_Body;
      E131 := E131 + 1;
      System.Pool_Global'Elab_Spec;
      E183 := E183 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E141 := E141 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E149 := E149 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E129 := E129 + 1;
      HAL.GPIO'ELAB_SPEC;
      E174 := E174 + 1;
      HAL.I2C'ELAB_SPEC;
      E206 := E206 + 1;
      HAL.SPI'ELAB_SPEC;
      E199 := E199 + 1;
      HAL.UART'ELAB_SPEC;
      E210 := E210 + 1;
      LSM303AGR'ELAB_SPEC;
      LSM303AGR'ELAB_BODY;
      E277 := E277 + 1;
      E238 := E238 + 1;
      E236 := E236 + 1;
      E229 := E229 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E165 := E165 + 1;
      E231 := E231 + 1;
      E233 := E233 + 1;
      E194 := E194 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E197 := E197 + 1;
      E216 := E216 + 1;
      E214 := E214 + 1;
      E252 := E252 + 1;
      E240 := E240 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E201 := E201 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E204 := E204 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E208 := E208 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E155 := E155 + 1;
      Microbit.Console'Elab_Body;
      E260 := E260 + 1;
      E279 := E279 + 1;
      Microbit.Accelerometer'Elab_Body;
      E275 := E275 + 1;
      Microbit.Iosfortasking'Elab_Spec;
      Microbit.Iosfortasking'Elab_Body;
      E212 := E212 + 1;
      E254 := E254 + 1;
      E247 := E247 + 1;
      Microbit.Timehighspeed'Elab_Body;
      E273 := E273 + 1;
      Microbit.Timewithrtc1'Elab_Spec;
      Microbit.Timewithrtc1'Elab_Body;
      E249 := E249 + 1;
      Carobject'Elab_Spec;
      E139 := E139 + 1;
      E256 := E256 + 1;
      E258 := E258 + 1;
      E271 := E271 + 1;
      Brain4'Elab_Spec;
      Brain4'Elab_Body;
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
   --   D:\git-repos\rts-car\Project\obj\distancesensors.o
   --   D:\git-repos\rts-car\Project\obj\CarObject.o
   --   D:\git-repos\rts-car\Project\obj\motorcontroller.o
   --   D:\git-repos\rts-car\Project\obj\servocontrol.o
   --   D:\git-repos\rts-car\Project\obj\ultrasonic.o
   --   D:\git-repos\rts-car\Project\obj\brain4.o
   --   D:\git-repos\rts-car\Project\obj\main.o
   --   -LD:\git-repos\rts-car\Project\obj\
   --   -LD:\git-repos\rts-car\Project\obj\
   --   -LD:\git-repos\Ada_Drivers_Library\boards\MicroBit_v2\obj\full_lib_Debug\
   --   -LD:\gnat\2021-arm-elf\arm-eabi\lib\gnat\ravenscar-full-nrf52833\adalib\
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
