pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is


   GNAT_Version : constant String :=
                    "GNAT Version: Community 2021 (20210519-103)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   procedure main;
   pragma Export (C, main, "main");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  gnat%s
   --  interfaces.nrf52%s
   --  interfaces.nrf52.clock%s
   --  interfaces.nrf52.uart%s
   --  system.bb%s
   --  system.bb.board_parameters%s
   --  system.bb.cpu_specific%s
   --  system.bb.mcu_parameters%s
   --  system.bb.parameters%s
   --  system.exceptions%s
   --  system.img_int%s
   --  system.machine_code%s
   --  machine_code%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.secondary_stack%s
   --  system.secondary_stack%b
   --  gnat.debug_utilities%s
   --  gnat.debug_utilities%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.text_io%s
   --  system.text_io%b
   --  system.io%s
   --  system.io%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  interfaces.nrf52.rtc%s
   --  system.img_uns%s
   --  system.img_util%s
   --  system.img_util%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.exn_lli%s
   --  system.traceback%s
   --  system.traceback%b
   --  ada.strings.utf_encoding%s
   --  ada.strings.utf_encoding.wide_strings%s
   --  ada.strings.utf_encoding.wide_strings%b
   --  ada.strings.utf_encoding.wide_wide_strings%s
   --  ada.strings.utf_encoding.wide_wide_strings%b
   --  ada.tags%s
   --  ada.strings.text_buffers%s
   --  ada.strings.text_buffers%b
   --  ada.strings.text_buffers.utils%s
   --  ada.strings.text_buffers.utils%b
   --  system.bb.cpu_primitives%s
   --  system.bb.cpu_primitives.context_switch_trigger%s
   --  system.bb.cpu_primitives.context_switch_trigger%b
   --  system.bb.interrupts%s
   --  system.bb.protection%s
   --  system.multiprocessors%s
   --  system.bb.time%s
   --  system.bb.board_support%s
   --  system.bb.board_support%b
   --  system.bb.threads%s
   --  system.bb.threads.queues%s
   --  system.bb.threads.queues%b
   --  system.multiprocessors.spin_locks%s
   --  system.multiprocessors.spin_locks%b
   --  system.multiprocessors.fair_locks%s
   --  system.os_interface%s
   --  system.put_images%s
   --  system.put_images%b
   --  system.bb.timing_events%s
   --  system.bb.timing_events%b
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.task_primitives%s
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  ada.strings.utf_encoding%b
   --  ada.tags%b
   --  system.bb.cpu_primitives%b
   --  system.bb.interrupts%b
   --  system.bb.protection%b
   --  system.bb.threads%b
   --  system.bb.time%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  system.memory%s
   --  system.memory%b
   --  system.multiprocessors%b
   --  system.multiprocessors.fair_locks%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.task_primitives.operations%b
   --  system.tasking%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.assertions%s
   --  ada.assertions%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.arith_64%s
   --  system.arith_64%b
   --  system.fat_flt%s
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.img_fixed_64%s
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.stream_attributes%s
   --  system.stream_attributes.xdr%s
   --  system.stream_attributes.xdr%b
   --  system.stream_attributes%b
   --  system.assertions%s
   --  system.assertions%b
   --  system.bb.execution_time%s
   --  system.bb.execution_time%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  ada.task_identification%s
   --  ada.task_identification%b
   --  ada.execution_time%s
   --  ada.execution_time%b
   --  system.interrupts%s
   --  system.interrupts%b
   --  ada.interrupts%s
   --  ada.interrupts%b
   --  ada.interrupts.names%s
   --  cortex_m%s
   --  cortex_m_svd%s
   --  hal%s
   --  cortex_m_svd.debug%s
   --  nrf_svd%s
   --  nrf_svd.aar%s
   --  nrf_svd.ccm%s
   --  nrf_svd.clock%s
   --  nrf_svd.ecb%s
   --  nrf_svd.ficr%s
   --  nrf_svd.gpio%s
   --  nrf_svd.gpiote%s
   --  nrf_svd.power%s
   --  nrf_svd.ppi%s
   --  nrf_svd.qdec%s
   --  nrf_svd.radio%s
   --  nrf_svd.rng%s
   --  nrf_svd.rtc%s
   --  nrf_svd.saadc%s
   --  nrf_svd.spi%s
   --  nrf_svd.temp%s
   --  nrf_svd.timer%s
   --  nrf_svd.twi%s
   --  nrf_svd.uart%s
   --  nrf_svd.wdt%s
   --  hal.gpio%s
   --  hal.i2c%s
   --  hal.spi%s
   --  hal.uart%s
   --  memory_barriers%s
   --  memory_barriers%b
   --  cortex_m.nvic%s
   --  cortex_m.nvic%b
   --  nrf%s
   --  nrf.events%s
   --  nrf.events%b
   --  nrf.gpio%s
   --  nrf.gpio%b
   --  nrf.gpio.tasks_and_events%s
   --  nrf.gpio.tasks_and_events%b
   --  nrf.interrupts%s
   --  nrf.interrupts%b
   --  nrf.rtc%s
   --  nrf.rtc%b
   --  nrf.spi_master%s
   --  nrf.spi_master%b
   --  nrf.tasks%s
   --  nrf.tasks%b
   --  nrf.adc%s
   --  nrf.adc%b
   --  nrf.clock%s
   --  nrf.clock%b
   --  nrf.ppi%s
   --  nrf.ppi%b
   --  nrf.timers%s
   --  nrf.timers%b
   --  nrf.twi%s
   --  nrf.twi%b
   --  nrf.uart%s
   --  nrf.uart%b
   --  nrf.device%s
   --  nrf.device%b
   --  microbit%s
   --  microbit.iosfortasking%s
   --  microbit.iosfortasking%b
<<<<<<< Updated upstream
=======
   --  distancesensors%s
   --  distancesensors%b
   --  microbit.servos%s
   --  microbit.servos%b
   --  microbit.timehighspeed%s
   --  microbit.timehighspeed%b
>>>>>>> Stashed changes
   --  microbit.timewithrtc1%s
   --  microbit.timewithrtc1%b
   --  servocontrol%s
   --  servocontrol%b
   --  ultrasonic%s
   --  ultrasonic%b
   --  carobject%s
   --  carobject%b
<<<<<<< Updated upstream
=======
   --  motorcontroller%s
   --  motorcontroller%b
   --  brain%s
   --  brain%b
>>>>>>> Stashed changes
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
