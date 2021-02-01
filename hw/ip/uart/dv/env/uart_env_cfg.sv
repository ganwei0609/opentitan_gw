// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
class uart_env_cfg extends cip_base_env_cfg #(.RAL_T(uart_reg_block));

  // ext component cfgs
  rand uart_agent_cfg   m_uart_agent_cfg;
  svt_uart_agent_configuration dce_cfg;
  
  // during break error, DUT will trigger additional frame/parity errors, which mon doesn't catch
  // disable parity/frame check in this period
  bit  disable_scb_rx_parity_check;
  bit  disable_scb_rx_frame_check;

  `uvm_object_utils_begin(uart_env_cfg)
    `uvm_field_object(m_uart_agent_cfg, UVM_DEFAULT)
  `uvm_object_utils_end

  `uvm_object_new

  virtual function void initialize(bit [TL_AW-1:0] csr_base_addr = '1);
    super.initialize(csr_base_addr);
    // create uart agent config obj
    m_uart_agent_cfg = uart_agent_cfg::type_id::create("m_uart_agent_cfg");
    // set num_interrupts & num_alerts which will be used to create coverage and more
    num_interrupts = ral.intr_state.get_n_used_bits();
    // only support 1 outstanding TL item
    m_tl_agent_cfg.max_outstanding_req = 1;
	
    dce_cfg = svt_uart_agent_configuration::type_id::create("dce_cfg");
    dce_cfg.is_active                     = 1;
	dce_cfg.enable_dtr_dsr_handshake                     = 0;
	dce_cfg.enable_rts_cts_handshake                     = 0;    
	dce_cfg.enable_tx_rx_handshake                     = 0; 
	dce_cfg.enable_tx_rx_handshake                     = 0; 
	dce_cfg.stop_bit                     = svt_uart_agent_configuration::ONE_BIT; 
	dce_cfg.parity_type                     = svt_uart_agent_configuration::NO_PARITY; 
	//clk = 25M
	//baud = 9600
	//Divisor value = 25*10^6 / (16 * 9600) = 162.76
	
	dce_cfg.baud_divisor				= 	162;
	dce_cfg.fractional_divisor					= 0.76;
	dce_cfg.fractional_divisor_period			= 16;
	
	
    `uvm_info("build_phase", $sformatf("initialize full name %0s",	get_full_name()), UVM_NONE);
	
    /** Set DCE configuration in environment */
    //uvm_config_db#(svt_uart_agent_configuration)::set(this,"env.dce_cfg","dce_cfg",dce_cfg);
    uvm_config_db#(svt_uart_agent_configuration)::set(null,"uvm_test_top.env","dce_cfg",dce_cfg);
       
	
  endfunction

  // uart doesn't have reset pin. When reset occurs/clears,
  // need to call reset function in uart_agent_cfg
  virtual function void reset_asserted();
    super.reset_asserted();
    m_uart_agent_cfg.reset_asserted();
  endfunction

  virtual function void reset_deasserted();
    super.reset_deasserted();
    m_uart_agent_cfg.reset_deasserted();
  endfunction
endclass
