// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
`define SVT_UART_GLOBAL_TIMEOUT 100ms
`define UART_GLOBAL_DRAINTIME 10us

import svt_uvm_pkg::*;

class uart_env extends cip_base_env #(.CFG_T               (uart_env_cfg),
                                      .COV_T               (uart_env_cov),
                                      .VIRTUAL_SEQUENCER_T (uart_virtual_sequencer),
                                      .SCOREBOARD_T        (uart_scoreboard));
  `uvm_component_utils(uart_env)

  uart_agent              m_uart_agent;
  svt_uart_vif        	  dce_vif;
  svt_uart_agent_configuration dce_cfg;
  svt_uart_agent dce_agent;

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    int build_ok = 1;
    super.build_phase(phase);
    `uvm_info("build_phase", $sformatf("full name %0s",	get_full_name()), UVM_NONE);
	$display("this's verbosity level is %0d", this.get_report_verbosity_level());
	this.set_report_verbosity_level_hier(UVM_DEBUG);
	`uvm_info("wgan_debug", $sformatf("path = %s\n", get_full_name()), UVM_HIGH);
	
    m_uart_agent = uart_agent::type_id::create("m_uart_agent", this);
    uvm_config_db#(uart_agent_cfg)::set(this, "m_uart_agent*", "cfg", cfg.m_uart_agent_cfg);
	
    if (!uvm_config_db#(svt_uart_agent_configuration)::get(this,"","dce_cfg",this.dce_cfg) || (this.dce_cfg == null)) begin
      `uvm_fatal("build_phase", "'dce_cfg' is null. A svt_uart_agent_configuration object must be set using the UVM configuration infrastructure.");
    end
    else begin
      `uvm_info("build_phase",$sformatf("***************Agent Configuration**************\n%0s",
					this.dce_cfg.sprint()), UVM_LOW);
    /** Get the DCE BFM Port Interface to factory */
      if (uvm_config_db#(svt_uart_vif)::get(this, "", "dce_vif", dce_vif)) begin
        if(dce_vif == null) begin
        `uvm_fatal("build_phase", "'dce_vif' is null. A svt_uart_if interface must be set using the UVM configuration infrastructure.");
        end else begin
          `uvm_info("build_phase", "Applying the DCE virtual interface received through the config db to the configuration.", UVM_HIGH);
          dce_cfg.set_uart_if(dce_vif);
        end
      end else begin 
        if (dce_cfg.uart_if == null) begin
          `uvm_fatal("build_phase", "A DCE virtual interface was not received either through the config db, or through the configuration object for the master.");
          build_ok = 0;
        end
      end // else: !if(uvm_config_db#(svt_uart_vif)::get(this, "", "dce_vif", dce_vif))
    end // else: !if(!uvm_config_db#(cust_svt_uart_agent_configuration)::get(this, "", "dce_cfg", this.dce_cfg) ||...
    
    if (build_ok) begin
      /** Apply the configuration to the agents */
      uvm_config_db#(svt_uart_agent_configuration)::set(this, "dce_agent", "cfg", dce_cfg);
      
      /** Construct the agents */
      dce_agent = svt_uart_agent::type_id::create("dce_agent",this);
      
      /** Construct the virtual sequencer */
      //sequencer = uart_virtual_sequencer::type_id::create("dce_sequencer", this);
	end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (cfg.en_scb) begin
      m_uart_agent.monitor.tx_analysis_port.connect(scoreboard.uart_tx_fifo.analysis_export);
      m_uart_agent.monitor.rx_analysis_port.connect(scoreboard.uart_rx_fifo.analysis_export);
    end
    if (cfg.dce_cfg.is_active) begin
      virtual_sequencer.uart_sequencer_h = m_uart_agent.sequencer;
    end
    if (cfg.m_uart_agent_cfg.is_active) begin
      virtual_sequencer.dce_sequencer = dce_agent.sequencer;
    end	
	
	$display("this's verbosity level is %0d", this.get_report_verbosity_level());
	this.set_report_verbosity_level_hier(UVM_DEBUG);
	`uvm_info("wgan_debug", $sformatf("path = %s\n", get_full_name()), UVM_HIGH);
  endfunction

endclass
