// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
`include "uart_reset_if.svi"


class uart_virtual_sequencer extends cip_base_virtual_sequencer #(.CFG_T(uart_env_cfg),
                                                                  .COV_T(uart_env_cov));
  `uvm_component_utils(uart_virtual_sequencer)

  uart_sequencer  uart_sequencer_h;
  svt_uart_transaction_sequencer dce_sequencer;
  typedef virtual uart_reset_if.uart_reset_modport UART_RESET_MP;
  UART_RESET_MP reset_mp;

  `uvm_component_new
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    `uvm_info("build_phase", $sformatf("full_name = %s", get_full_name()), UVM_LOW)

    super.build_phase(phase);

    if (!uvm_config_db#(UART_RESET_MP)::get(this, "", "reset_mp", reset_mp)) begin
      `uvm_fatal("build_phase", "An uart_reset_modport must be set using the config db.");
    end

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction

  virtual task reset_phase(uvm_phase phase);
    `uvm_info("reset_phase", "Entered...", UVM_LOW)
    `uvm_info("reset_phase", $sformatf("Entered...  full_name = %s", get_full_name()), UVM_LOW)
    super.reset_phase(phase);
	phase.raise_objection(this);
    reset_mp.reset = 1'b0;
	
    @(posedge reset_mp.clk);
    reset_mp.reset = 1'b1;
    @(posedge reset_mp.clk);
    reset_mp.reset = 1'b0;
	
    `uvm_info("reset_phase", "Exiting...", UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass
