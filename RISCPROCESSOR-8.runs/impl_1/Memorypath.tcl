# 
# Report generation script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config  -ruleid {10}  -id {Place 30-568}  -suppress 
set_msg_config  -ruleid {11}  -id {Place 46-29}  -string {{WARNING: [Place 46-29] place_design is not in timing mode. Skip physical synthesis in placer}}  -suppress 
set_msg_config  -ruleid {12}  -id {Constraints 18-5210}  -string {{WARNING: [Constraints 18-5210] No constraint will be written out.}}  -suppress 
set_msg_config  -ruleid {13}  -id {Vivado 12-1017}  -string {{WARNING: [Vivado 12-1017] Problems encountered:
1. Failed to delete one or more files in run directory C:/Users/bup48/Documents/VivadoProjects/RISCPROCESSOR-8/RISCPROCESSOR-8.runs/synth_1}}  -suppress 
set_msg_config  -ruleid {14}  -id {Power 33-232}  -string {{WARNING: [Power 33-232] No user defined clocks were found in the design!
Resolution: Please specify clocks using create_clock/create_generated_clock for sequential elements. For pure combinatorial circuits, please specify a virtual clock, otherwise the vectorless estimation might be inaccurate}}  -suppress 
set_msg_config  -ruleid {15}  -id {Timing 38-313}  -suppress 
set_msg_config  -ruleid {4}  -id {Synth 8-85}  -suppress 
set_msg_config  -ruleid {5}  -id {Synth 8-6026}  -string {{WARNING: [Synth 8-6026] Ignoring keep related attribute (keep/mark_debug/dont_touch) applied on memory [C:/Users/bup48/Downloads/data_memory.v:11]}}  -suppress 
set_msg_config  -ruleid {6}  -id {Vivado 12-584}  -string {{WARNING: [Vivado 12-584] No ports matched 'mclk'. [C:/Users/bup48/Downloads/nexys4_ddr.xdc:2]}}  -suppress 
set_msg_config  -ruleid {7}  -id {Vivado 12-584}  -string {{WARNING: [Vivado 12-584] No ports matched 'mclk'. [C:/Users/bup48/Downloads/nexys4_ddr.xdc:3]}}  -suppress 
set_msg_config  -ruleid {8}  -id {Synth 8-6014}  -string {{WARNING: [Synth 8-6014] Unused sequential element uut/SSEG_CA_reg was removed.  [C:/Users/bup48/Downloads/master.v:162]}}  -suppress 
set_msg_config  -ruleid {9}  -id {Synth 8-6014}  -suppress 

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param power.BramSDPPropagationFix 1
  set_param power.enableUnconnectedCarry8PinPower 1
  set_param power.enableCarry8RouteBelPower 1
  set_param power.enableLutRouteBelPower 1
  create_project -in_memory -part xczu7ev-ffvc1156-2-e
  set_property board_part xilinx.com:zcu106:part0:2.2 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/bup48/Documents/VivadoProjects/RISCPROCESSOR-8/RISCPROCESSOR-8.cache/wt [current_project]
  set_property parent.project_path C:/Users/bup48/Documents/VivadoProjects/RISCPROCESSOR-8/RISCPROCESSOR-8.xpr [current_project]
  set_property ip_output_repo C:/Users/bup48/Documents/VivadoProjects/RISCPROCESSOR-8/RISCPROCESSOR-8.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet C:/Users/bup48/Documents/VivadoProjects/RISCPROCESSOR-8/RISCPROCESSOR-8.runs/synth_1/Memorypath.dcp
  link_design -top Memorypath -part xczu7ev-ffvc1156-2-e
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Memorypath_opt.dcp
  create_report "impl_1_opt_report_drc_0" "report_drc -file Memorypath_drc_opted.rpt -pb Memorypath_drc_opted.pb -rpx Memorypath_drc_opted.rpx"
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  if { [llength [get_debug_cores -quiet] ] > 0 }  { 
    implement_debug_core 
  } 
  place_design 
  write_checkpoint -force Memorypath_placed.dcp
  create_report "impl_1_place_report_io_0" "report_io -file Memorypath_io_placed.rpt"
  create_report "impl_1_place_report_utilization_0" "report_utilization -file Memorypath_utilization_placed.rpt -pb Memorypath_utilization_placed.pb"
  create_report "impl_1_place_report_control_sets_0" "report_control_sets -verbose -file Memorypath_control_sets_placed.rpt"
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Memorypath_routed.dcp
  create_report "impl_1_route_report_drc_0" "report_drc -file Memorypath_drc_routed.rpt -pb Memorypath_drc_routed.pb -rpx Memorypath_drc_routed.rpx"
  create_report "impl_1_route_report_methodology_0" "report_methodology -file Memorypath_methodology_drc_routed.rpt -pb Memorypath_methodology_drc_routed.pb -rpx Memorypath_methodology_drc_routed.rpx"
  create_report "impl_1_route_report_power_0" "report_power -file Memorypath_power_routed.rpt -pb Memorypath_power_summary_routed.pb -rpx Memorypath_power_routed.rpx"
  create_report "impl_1_route_report_route_status_0" "report_route_status -file Memorypath_route_status.rpt -pb Memorypath_route_status.pb"
  create_report "impl_1_route_report_timing_summary_0" "report_timing_summary -max_paths 10 -file Memorypath_timing_summary_routed.rpt -pb Memorypath_timing_summary_routed.pb -rpx Memorypath_timing_summary_routed.rpx -warn_on_violation "
  create_report "impl_1_route_report_incremental_reuse_0" "report_incremental_reuse -file Memorypath_incremental_reuse_routed.rpt"
  create_report "impl_1_route_report_clock_utilization_0" "report_clock_utilization -file Memorypath_clock_utilization_routed.rpt"
  create_report "impl_1_route_report_bus_skew_0" "report_bus_skew -warn_on_violation -file Memorypath_bus_skew_routed.rpt -pb Memorypath_bus_skew_routed.pb -rpx Memorypath_bus_skew_routed.rpx"
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force Memorypath_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

