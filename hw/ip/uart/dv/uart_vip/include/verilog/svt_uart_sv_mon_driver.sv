// ------------------------------------------------------------------------------------------------
//  nvs_uv_ovm_mon_veri_driver
// ------------------------------------------------------------------------------------------------


//Declare Module
module `NVS_UV_SV_MON_DRIVER (
			     `NVS_UV_SV_PORT_IF                  if_port ,
			     `NVS_UV_SV_MON_IF                   if_mon  , 
			     `NVS_UV_SV_CHK_IF                   if_chk  
                             ); 

  // ------------------------------------------------------------------------------------------------
  // Include .vih files
  // ------------------------------------------------------------------------------------------------
  `ifdef UV_PROTECT
   `include `NVS_UV_LIB_GEN_HP // Updated by Codegensvt
   `include `NVS_UV_LIB_GEN_VIHP // Updated by Codegensvt
  `else
   `include `NVS_UV_LIB_GEN_H // Updated by Codegensvt
   `include `NVS_UV_LIB_GEN_VIH // Updated by Codegensvt
  `endif 

  //----------------------------------------------------------------------------
  // Local Parameter to select the target interface to assign the received value
  // from Verilog Monitor.
  //----------------------------------------------------------------------------
  parameter UV_CROSS_MAP     = 0;
  //----------------------------------------------------------------------------
  //These are intermediate wires to connect RTS/CTS pins of Monitor and Checker.
  //----------------------------------------------------------------------------   
  wire mon_rts;
  wire mon_cts;
  wire chk_rts;
  wire chk_cts;
  reg [4:0]gp;
  //----------------------------------------------------------------------------
  //Bits to capture enable_tx_rx_handshake variable of svt_uart_configuration class.
  //Based on these variable RTS.CTS pins of Monitor and Checker is connected.
  //----------------------------------------------------------------------------   
  bit 	enable_tx_rx_handshake_mon;
  bit 	enable_tx_rx_handshake_chk;
  bit 	cfg_de_polarity;
  bit 	cfg_re_polarity;
  bit 	cfg_enable_rs485;
  
  //----------------------------------------------------------------------------------------------
  // Instantitaing the monitor module
  //----------------------------------------------------------------------------------------------
  `NVS_UV_MONITOR Monitor (
	        .rst (if_port.rst ),
	        .clk (if_port.clk ),
	        .sin (if_port.sin ),
	        .cts (mon_cts ),
	        .dsr (if_port.dsr ),
	        .dtr (if_port.dtr ),
	        .rts (mon_rts ),
	        .sout(if_port.sout),
	        .baudout(if_port.baudout ) 
	        ); // end module nvs_uv_checker

  assign mon_rts = UV_CROSS_MAP ? (enable_tx_rx_handshake_mon ? if_port.cts : if_port.rts) : if_port.rts;
  assign mon_cts = UV_CROSS_MAP ? (enable_tx_rx_handshake_mon ? if_port.rts : if_port.cts) : if_port.cts;

  //------------------------------------------------------------------
  // Variable declaration
  //------------------------------------------------------------------
  reg  do_cfg_called_prev       ;
  reg  do_cfg_called_prev_chk   ;
  reg  do_err_called_prev       ;
  reg  do_cfg_rd_called_prev    ;
  reg  ignore_do_cfg_call       ;
  reg  ignore_do_cfg_call_chk   ;
  reg  ignore_do_pkt_call       ;
  reg  ignore_do_err_call       ;
  reg  ignore_do_cfg_rd_call    ;
  reg  prev_update_trans_u      ;
  reg  prev_update_trans_d      ;
  //------------------------------------------------------------------
  //Variable for collecting Checker rule coverage
  //------------------------------------------------------------------
  reg prev_chk_rule_exe_sig;
  reg prev_chk_rule_error_sig;
  reg prev_chk_rule_log_sig;
  
  reg wait_for_start_detect_d ;
  reg [31:0] intr_cycl_delay_d ;
  reg wait_for_start_detect_u ;
  reg [31:0] intr_cycl_delay_u ;
  //------------------------------------------------------------------
  // This Initial block initializes all the  varibles which are to be
  // mapped on the MASTER Xaction and Xchange intefaces by the  MASTER
  // driver module.
  //------------------------------------------------------------------
  initial
    begin
      do_cfg_called_prev_chk    = 0;
      ignore_do_cfg_call_chk    = 0;
      do_cfg_called_prev        = 0;
      do_err_called_prev        = 0;
      do_cfg_rd_called_prev     = 0;
      ignore_do_cfg_call        = 1;
      ignore_do_err_call        = 1;
      ignore_do_cfg_rd_call     = 1;
      prev_update_trans_u       = 0;
      prev_update_trans_d       = 0;
      prev_chk_rule_exe_sig     = 1'b0;
      prev_chk_rule_error_sig    = 1'b0;
      prev_chk_rule_log_sig      = 1'b0;
        
      wait_for_start_detect_d = 1'b0 ;
      intr_cycl_delay_d = 1'b0 ;
      wait_for_start_detect_u = 1'b0 ;
      intr_cycl_delay_u = 1'b0 ;
    end

  //--------------------------------------------------
  //Open log file for logging Bus Monitor messages.
  //--------------------------------------------------
  reg [31:0] hnd2;
  int bus_no;
  int agent_no;
  
  string file_name;

  //------------------------------------------------------------------------------------------------
  // Task : assign_handle
  //        Pass log file handle to Monitor and Checker
  //------------------------------------------------------------------------------------------------
  task assign_handle;
    begin
      hnd2 = 0;
      	 
      file_name = $psprintf("nvs_uv_bus%0d_mon.log",bus_no);
      hnd2=$fopen(file_name);
      
      Monitor.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
      Checker.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
    end
  endtask // assign_handle
   
   
  // ------------------------------------------------------------------------------------------------
  // do_cfg
  // This always block is executed when the MON Xactor calls its do_cfg task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_mon.call_do_cfg)
    begin: block_do_cfg_caller
      `uart_debug_v2(" do cfg Param - %d Pvalue- %d",if_mon.param, if_mon.pvalue);
      ignore_do_cfg_call = 0;
      if(ignore_do_cfg_call)
        ignore_do_cfg_call = 0;
      else
        begin
          `uart_debug("call_do_cfg");
  	      if(if_mon.param === `UV_ENABLE_TX_RX_HANDSHAKE)
  	        enable_tx_rx_handshake_mon = if_mon.pvalue;
  
          Monitor.do_cfg(if_mon.param,if_mon.pvalue);
          if_mon.do_cfg_called  = ~do_cfg_called_prev;
          do_cfg_called_prev    = ~do_cfg_called_prev;
          `uart_debug("do_cfg_called");
        end
    end // block_do_cfg_caller

`ifdef SVT_UART    
  always @(Checker.rule_error_bit) 
    begin : BLOCK_RULE_ERROR_BIT
      // after receiving error ack, wait for signal rule_error_bit to settle down, 
      // for other errors (if any) coming on same time unit
      #0;
      if_chk.rule_error = Checker.rule_error_bit;
      Checker.rule_error_bit = 'b0;
    end
`endif

  //////////////////////////////////////////////////////////////////////////////////////////////////
  `NVS_UV_CHECKER Checker  (
       .rst (if_port.rst ),
       .clk (if_port.clk ),
       .sin (if_port.sin ),
       .cts (chk_cts ),
       .dsr (if_port.dsr ),
       .dtr (if_port.dtr ),
       .rts (chk_rts ),
       .sout (if_port.sout ),
`ifdef SVT_UART_GPIO                        
       .gpio (gp ), 
`endif
       .baudout (if_port.baudout ) 

      ); // end module nvs_uv_checker

  defparam Checker.UART_DEVICE_TYPE = UV_CROSS_MAP;
  assign chk_rts = UV_CROSS_MAP ? (enable_tx_rx_handshake_chk ? if_port.cts : if_port.rts) : if_port.rts;
  assign chk_cts = UV_CROSS_MAP ? (enable_tx_rx_handshake_chk ? if_port.rts : if_port.cts) : if_port.cts;
`ifdef SVT_UART_GPIO                        
  assign gp[0] = cfg_enable_rs485 ? (cfg_de_polarity ? if_port.gpi0 : ~if_port.gpi0) : if_port.gpi0;
  assign gp[1] = cfg_enable_rs485 ? (cfg_re_polarity ? if_port.gpi1 : ~if_port.gpi1) : if_port.gpi1;
  assign gp[2] = if_port.gpi2; 
  assign gp[3] = if_port.gpi3; 
  assign gp[4] = if_port.gpi4; 
`endif

  // ------------------------------------------------------------------------------------------------
  // do_cfg
  // This always block is executed when the CHK Xactor calls its do_cfg task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_chk.call_do_cfg)
    begin: block_do_cfg_caller_chk
      `uart_debug_v2(" do cfg Param - %d Pvalue- %d",if_chk.param, if_chk.pvalue);
      ignore_do_cfg_call_chk = 0;
      if(ignore_do_cfg_call_chk)
        ignore_do_cfg_call_chk = 0;
      else
        begin
          `uart_debug("call_do_cfg");
  	      if(if_chk.param === `UV_ENABLE_TX_RX_HANDSHAKE)
  	        enable_tx_rx_handshake_chk = if_chk.pvalue;

  	      if(if_chk.param === `SVT_UART_DE_POLARITY)
  	        cfg_de_polarity = if_chk.pvalue;

  	      if(if_chk.param === `SVT_UART_RE_POLARITY)
  	        cfg_re_polarity = if_chk.pvalue;

  	      if(if_chk.param === `SVT_UART_ENABLE_RS485)
  	        cfg_enable_rs485 = if_chk.pvalue;

          Checker.do_cfg(if_chk.param,if_chk.pvalue);
  	 
          if_chk.do_cfg_called  = ~do_cfg_called_prev_chk;
          do_cfg_called_prev_chk    = ~do_cfg_called_prev_chk;
          `uart_debug("do_cfg_called");
        end
    end // block_do_cfg_caller
  
  //event mapping 
  
  always@( Checker.event_start_detected_u ) 
    begin : BLOCK_START_DETECT_U 
      //-------------------------------------------------------------
      // This block is triggered on the event event_start_detected_u
      // from the checker and indicates the sampling of start bit in
      // upstream transaction
      //-------------------------------------------------------------
      begin
        wait_for_start_detect_u = 0;
      end

      // Mapping the triggering of event event_start_detected_u on the
      // checker_interface
      if(UV_CROSS_MAP === 0) begin
        if_chk.event_start_detected_u_trigger ()  ;
      end
      else if(UV_CROSS_MAP === 1) begin
        if_chk.event_start_detected_d_trigger ()  ;
      end
    end
    
  always@( Checker.event_stop_detected_u )
    begin : BLOCK_STOP_DETECT_U
      //--------------------------------------------------------------
      // Merging the always block for calculation of inter-cycle delay
      //--------------------------------------------------------------
      // This block always triggers on triggering of the event
      // event_stop_detected_u. It maps the value of intercycle delay 
      // that is calculated on the monitor interface, for upstream 
      // traffic
      //--------------------------------------------------------------
      // SNPS begin
      // SNPS   if(intr_cycl_delay_u >= 16)
      // SNPS     begin
      // SNPS       if(UV_CROSS_MAP == 0)
      // SNPS         if_mon.intr_cycl_delay_u = (intr_cycl_delay_u - 16);
      // SNPS       else if(UV_CROSS_MAP == 1)
      // SNPS         if_mon.intr_cycl_delay_d = (intr_cycl_delay_u - 16);
      // SNPS     end
      // SNPS   
      // SNPS   wait_for_start_detect_u = 1;
      // SNPS   intr_cycl_delay_u = 0;
      // SNPS end

      // Mapping the triggering of event event_stop_detected_u on the
      // checker_interface
      if(UV_CROSS_MAP === 0) begin
        if_chk.event_stop_detected_u_trigger ()   ;
      end
      else if(UV_CROSS_MAP === 1) begin
        if_chk.event_stop_detected_d_trigger ()   ;
      end
    end
  
  always@(Checker.event_start_detected_d )
    begin : BLOCK_START_DETECT_D
      //----------------------------------------------------------------------
      // This block is triggered on the event event_start_detected_d from the
      // checker and indicates the sampling of start bit in downstream
      // transaction
      //----------------------------------------------------------------------
      begin
        wait_for_start_detect_d = 0;
      end

      // Mapping the triggering of event event_start_detected_d on the
      // checker_interface
      if(UV_CROSS_MAP === 0) begin
        if_chk.event_start_detected_d_trigger ()   ;
      end
      else if(UV_CROSS_MAP === 1) begin
        if_chk.event_start_detected_u_trigger ()   ;
      end
    end
  
  always@(Checker.event_stop_detected_d ) 
    begin : BLOCK_STOP_DETECT_D
      //--------------------------------------------------------------
      // Merging the always block for calculation of inter-cycle delay
      //--------------------------------------------------------------
      // This block always triggers on triggering of the event
      // event_stop_detected_d. It maps the value of intercycle delay 
      // that is calculated on the monitor interface, for downstream 
      // traffic
      //--------------------------------------------------------------
      // SNPS begin
      // SNPS   if(intr_cycl_delay_d >= 16)
      // SNPS     begin
      // SNPS       if(UV_CROSS_MAP == 0)
      // SNPS         if_mon.intr_cycl_delay_d = (intr_cycl_delay_d - 16);
      // SNPS       else if(UV_CROSS_MAP == 1)
      // SNPS         if_mon.intr_cycl_delay_u = (intr_cycl_delay_d - 16);
      // SNPS     end
      // SNPS   
      // SNPS   wait_for_start_detect_d = 1;
      // SNPS   intr_cycl_delay_d = 0;
      // SNPS end

      // Mapping the triggering of event event_stop_detected_d on the
      // checker_interface
      if(UV_CROSS_MAP === 0) begin
        if_chk.event_stop_detected_d_trigger ()   ;
      end
      else if(UV_CROSS_MAP === 1) begin
        if_chk.event_stop_detected_u_trigger ()   ;
      end
    end
  
  always@(Checker.event_xon_detected) 
    begin : BLOCK_XON_DETECT
      if_chk.event_xon_detected_trigger ();
    end
  
  always@(Checker.event_xoff_detected) 
    begin : BLOCK_XOFF_DETECT
      if_chk.event_xoff_detected_trigger ();
    end

  //-----------------------------------------------------------------------------------------------
  // always blocks for coverage specific scenarios
  //-----------------------------------------------------------------------------------------------
    
  // always block to get the obserbed packet_count value from the monitor
  always @ (Checker.end_of_pkt_sent)
    begin : BLOCK_END_OF_PKT
      if_mon.packet_count_sz_sig=Checker.packet_count_size;
      if_mon.end_of_pkt_sent      = ~if_mon.end_of_pkt_sent;
    end

  // always block to get the obserbed delay time of dtr assertion value from the monitor
  always @ (Checker.dtr_asserted)
    begin : BLOCK_DTR_ASSERT
      if_mon.dtr_assert_delay_time_sig=Checker.dtr_assertion_delay;
      if_mon.dtr_asserted      = ~if_mon.dtr_asserted;
    end

  // always block to get the obserbed delay time of sin start value from the monitor
  always @ (Checker.sin_started)
    begin : BLOCK_SIN_START
      if_mon.sin_assert_delay_time_sig=Checker.sin_delay;
      if_mon.sin_started      = ~if_mon.sin_started;
    end

  // always block to get the obserbed delay time of sout start value from the monitor
  always @ (Checker.sout_started)
    begin : BLOCK_SOUT_START
      if_mon.sout_assert_delay_time_sig=Checker.sout_delay;
      if_mon.sout_started      = ~if_mon.sout_started;
    end

  // always block to get the obserbed delay time of dsr assertion value from the monitor
  always @ (Checker.dsr_asserted)
    begin : BLOCK_DSR_ASSERT
      if_mon.dsr_assert_delay_time_sig=Checker.dsr_assertion_delay;
      if_mon.dsr_asserted      = ~if_mon.dsr_asserted;
    end

  // always block to get the obserbed delay time of rts assertion value from the monitor
  always @ (Checker.rts_asserted)
    begin : BLOCK_RTS_ASSERT
      if_mon.rts_deasrt_asrt_delay_time_sig=Checker.rts_deasrt_asrt_delay;
      if_mon.rts_asserted      = ~if_mon.rts_asserted;
    end

  // always block to get the obserbed delay time of cts assertion value from the monitor
  always @ (Checker.cts_asserted)
    begin : BLOCK_CTS_ASSERT
      if_mon.cts_deasrt_asrt_delay_time_sig=Checker.cts_deasrt_asrt_delay;
      if_mon.cts_asserted      = ~if_mon.cts_asserted;
    end

  // always block to get the obserbed delay time between rts assertion and cts assertion value from the monitor
  always @ (Checker.cts_asserted_aftr_rts)
    begin : BLOCK_CTS_ASSERT_AFTER_RTS
      if_mon.rts_cts_delay_sig=Checker.rts_cts_delay;
      if_mon.rts_cts_asserted      = ~if_mon.rts_cts_asserted;
    end

  // always block to get the obserbed delay time between dtr assertion and dsr assertion value from the monitor
  always @ (Checker.dsr_asserted_aftr_dtr)
    begin : BLOCK_DSR_ASSERT_AFTER_DTR
      if_mon.dtr_dsr_delay_sig=Checker.dtr_dsr_delay;
      if_mon.dtr_dsr_asserted      = ~if_mon.dtr_dsr_asserted;
    end

  // always block to get the obserbed payload and parity value from the monitor
  always @ (Checker.chk_data_received_u)
    begin : collect_data_u
      if(UV_CROSS_MAP === 0) 
        begin
          if_mon.payload_sig_u     = Checker.chk_received_data_u;
          if_mon.parity_sig_u      = Checker.chk_received_parity_u;
          if_mon.received_pkt_u    = Checker.chk_received_packet_u;
      
          if_mon.packet_start_time_u = Checker.packet_start_time_u;
          if_mon.packet_end_time_u   = Checker.packet_end_time_u;

          if_mon.payload_rcvd_u    = ~if_mon.payload_rcvd_u;

          if(Checker.parity_error_u)
            if_mon.parity_error_u = 1;
          else
            if_mon.parity_error_u = 0;

          if(Checker.framing_error_u)
            if_mon.framing_error_u = 1;
          else
            if_mon.framing_error_u = 0;
           
          if(Checker.bit_brk_con_u == 1)  
            if_mon.bit_brk_con_u = 1;
          else  
            if_mon.bit_brk_con_u = 0;
           
          begin
            if(intr_cycl_delay_u >= 16)
              if_mon.intr_cycl_delay_u = (intr_cycl_delay_u - 16);
            
            wait_for_start_detect_u = 1;
            intr_cycl_delay_u = 0;
          end

          if (if_mon.update_trans_u === 0) begin
            if_mon.update_trans_u    = 1;
`ifdef UV_ENABLE_DEBUG          
            $display($time," %m : packet debug : upstream transaction : updated, update_trans_u updated on mon interface");
`endif
          end else begin
`ifdef UV_ENABLE_DEBUG          
            $display($time," %m : packet debug : upstream transaction : updated, update_trans_u could not be updated on mon interface");
`endif
          end
          //if_mon.update_trans_u    = ~prev_update_trans_u;
          prev_update_trans_u      = ~prev_update_trans_u;

          if_mon.toggle_u = ~if_mon.toggle_u;
           
          //wait for trans updated signal from xchange interface
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : upstream transaction : Waiting for trans_updated_u on mon interface");
`endif
          //@(if_mon.trans_updated_u);
          wait (if_mon.trans_updated_u === 1);
          if_mon.trans_updated_u = 0;
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : upstream transaction : trans_updated_u received on mon interface");
`endif
        end
      else if(UV_CROSS_MAP === 1)
        begin
          if_mon.payload_sig_d       = Checker.chk_received_data_u;
          if_mon.parity_sig_d        = Checker.chk_received_parity_u;
          if_mon.received_pkt_d      = Checker.chk_received_packet_u;

   	      if_mon.packet_start_time_d = Checker.packet_start_time_u;
   	      if_mon.packet_end_time_d   = Checker.packet_end_time_u;
    
          if_mon.payload_rcvd_d      = ~if_mon.payload_rcvd_d;
    
          if(Checker.framing_error_u)
            if_mon.framing_error_d = 1;
          else
            if_mon.framing_error_d = 0;

          if(Checker.parity_error_u)
            if_mon.parity_error_d = 1;
          else
            if_mon.parity_error_d = 0;

          if(Checker.bit_brk_con_u == 1)  
            if_mon.bit_brk_con_d = 1;
          else  
            if_mon.bit_brk_con_d = 0;
    
          begin
            if(intr_cycl_delay_u >= 16)
              if_mon.intr_cycl_delay_d = (intr_cycl_delay_u - 16);
            
            wait_for_start_detect_u = 1;
            intr_cycl_delay_u = 0;
          end

          //if_mon.update_trans_d      = ~prev_update_trans_d;
          if (if_mon.update_trans_d === 0) begin
            if_mon.update_trans_d = 1;
`ifdef UV_ENABLE_DEBUG          
            $display($time," %m : packet debug : upstream transaction : updated, update_trans_d updated on mon interface");
`endif
          end else begin
`ifdef UV_ENABLE_DEBUG          
            $display($time," %m : packet debug : upstream transaction : updated, update_trans_d could not be updated on mon interface");
`endif
          end
          prev_update_trans_d        = ~prev_update_trans_d;

          if_mon.toggle_d = ~if_mon.toggle_d;
    
          //wait for trans updated signal from xchange interface
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : upstream transaction : Waiting for trans_updated_d on mon interface");
`endif
          wait(if_mon.trans_updated_d === 1);
          if_mon.trans_updated_d = 0;
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : upstream transaction : trans_updated_d received on mon interface");
`endif
        end
    end
  
  // always block to get the obserbed payload and parity value from the monitor downstream
  always @ (Checker.chk_data_received_d)
    begin : collect_data_d
      if(UV_CROSS_MAP == 0)
        begin
          // The transaction is downstream for BFM0
          if_mon.payload_sig_d       = Checker.chk_received_data_d;
          if_mon.parity_sig_d        = Checker.chk_received_parity_d;
          if_mon.received_pkt_d      = Checker.chk_received_packet_d;
	    
     	    if_mon.packet_start_time_d = Checker.packet_start_time_d;
     	    if_mon.packet_end_time_d   = Checker.packet_end_time_d;
	    
          if_mon.payload_rcvd_d      = ~if_mon.payload_rcvd_d;

          if(Checker.framing_error_d)
            if_mon.framing_error_d = 1;
          else
            if_mon.framing_error_d = 0;
	    
          if(Checker.parity_error_d)
            if_mon.parity_error_d = 1;
          else
            if_mon.parity_error_d = 0;
	    
          if(Checker.bit_brk_con_d == 1)  
            if_mon.bit_brk_con_d = 1;
          else  
            if_mon.bit_brk_con_d = 0;
    
          begin
            if(intr_cycl_delay_d >= 16)
              if_mon.intr_cycl_delay_d = (intr_cycl_delay_d - 16);
            
            wait_for_start_detect_d = 1;
            intr_cycl_delay_d = 0;
          end

          //if_mon.update_trans_d      = ~prev_update_trans_d;
          if (if_mon.update_trans_d === 0) begin
            if_mon.update_trans_d = 1;
`ifdef UV_ENABLE_DEBUG
            $display($time," %m : packet debug : downstream transaction : updated, update_trans_d updated on mon interface");
`endif
          end else begin
`ifdef UV_ENABLE_DEBUG
            $display($time," %m : packet debug : downstream transaction : updated, update_trans_d could not be updated on mon interface");
`endif
          end
          prev_update_trans_d        = ~prev_update_trans_d;

          if_mon.toggle_d = ~if_mon.toggle_d;

          //wait for trans updated signal from xchange interface
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : downstream transaction : Waiting for trans_updated_d on mon interface");
`endif
          //@(if_mon.trans_updated_d);
          wait(if_mon.trans_updated_d === 1);
          if_mon.trans_updated_d = 0;
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : downstream transaction : trans_updated_d received on mon interface");
`endif
        end
      else if(UV_CROSS_MAP == 1)
        begin
          // The transaction is upstream for BFM1
          if_mon.payload_sig_u     = Checker.chk_received_data_d;
          if_mon.parity_sig_u      = Checker.chk_received_parity_d;
          if_mon.received_pkt_u    = Checker.chk_received_packet_d;

          if_mon.packet_start_time_u = Checker.packet_start_time_d;
          if_mon.packet_end_time_u   = Checker.packet_end_time_d;
    
          if_mon.payload_rcvd_u    = ~if_mon.payload_rcvd_u;
    
          if(Checker.parity_error_d)
            if_mon.parity_error_u = 1;
          else
            if_mon.parity_error_u = 0;
          
          if(Checker.framing_error_d)
            if_mon.framing_error_u = 1;
          else
            if_mon.framing_error_u = 0;
          
          if(Checker.bit_brk_con_d == 1)  
            if_mon.bit_brk_con_u = 1;
          else  
            if_mon.bit_brk_con_u = 0;
          
          begin
            if(intr_cycl_delay_d >= 16)
              if_mon.intr_cycl_delay_u = (intr_cycl_delay_d - 16);
            
            wait_for_start_detect_d = 1;
            intr_cycl_delay_d = 0;
          end

          //if_mon.update_trans_u    = ~prev_update_trans_u;
          if (if_mon.update_trans_u === 0) begin
            if_mon.update_trans_u = 1;
`ifdef UV_ENABLE_DEBUG
            $display($time," %m : packet debug : downstream transaction : updated, update_trans_u updated on mon interface");
`endif
          end else begin
`ifdef UV_ENABLE_DEBUG
            $display($time," %m : packet debug : downstream transaction : updated, update_trans_u could not be updated on mon interface");
`endif
          end
          prev_update_trans_u      = ~prev_update_trans_u;

          if_mon.toggle_u = ~if_mon.toggle_u;

          //wait for trans updated signal from xchange interface
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : downstream transaction : Waiting for trans_updated_u on mon interface");
`endif
          //@(if_mon.trans_updated_u);
          wait(if_mon.trans_updated_u === 1);
          if_mon.trans_updated_u = 0;
`ifdef UV_ENABLE_DEBUG          
          $display($time," %m : packet debug : downstream transaction : trans_updated_u received on mon interface");
`endif
        end
    end // always @ (Checker.chk_data_received_d)

  always @ (Checker.event_record_start_time_u)
    begin : BLOCK_RECORD_START_TIME_U
      if(UV_CROSS_MAP == 0)
        if_mon.record_packet_start_time_u = ~ if_mon.record_packet_start_time_u;
      else
        if_mon.record_packet_start_time_d = ~ if_mon.record_packet_start_time_d;
    end

  always @ (Checker.event_record_start_time_d)
    begin : BLOCK_RECORD_START_TIME_D
      if(UV_CROSS_MAP == 0)
        if_mon.record_packet_start_time_d = ~ if_mon.record_packet_start_time_d;
      else
        if_mon.record_packet_start_time_u = ~ if_mon.record_packet_start_time_u;
    end
   
  // always block to get the packet recieved by DCE between cts assertion  and deasserion for downstream tx
  always @ (Checker.pkt_rcvd_bfr_cts_deassert)
    begin : BLOCK_PKT_RCVD_AFTR_CTS_DEASSERT
      if_mon.packet_count_bfr_cts_deassert=Checker.packet_count_bfr_cts_deassert;
      if_mon.evnt_packet_count_bfr_cts_deassert      = ~if_mon.evnt_packet_count_bfr_cts_deassert;
    end
  // always block to get the packet recieved by DCE between rts assertion  and deasserion for downstream tx
  always @ (Checker.pkt_rcvd_bfr_rts_deassert)
    begin : BLOCK_PKT_RCVD_BFR_RTS_DEASSERT
      if_mon.packet_count_bfr_rts_deassert=Checker.packet_count_bfr_rts_deassert;
      if_mon.evnt_packet_count_bfr_rts_deassert      = ~if_mon.evnt_packet_count_bfr_rts_deassert;
    end
  //-----------------------------------------------------------------------
  //This always block Collects the Execute rule ID from Vlog Checker module
  //and pass it to the OVM Checker's Virtual interface.
  //-----------------------------------------------------------------------
  always @ (negedge Checker.chk_clock_u or negedge Checker.chk_clock_d)
    begin : BLOCK_DETECT_RULE_EXE_ID
      for(int i=0 ; i < `UV_NVS_MAX_RULE; i ++)
        begin
          if(Checker.rule_exe_cov[i] === 1'b1)
            begin
      	      if_chk.chk_rule_exe_id = i;
      	      if_chk.chk_rule_exe_sig = prev_chk_rule_exe_sig;
      	      prev_chk_rule_exe_sig = ~prev_chk_rule_exe_sig;
      	      
      	      @ (if_chk.chk_exe_id_updated);
      	      
      	      Checker.rule_exe_cov[i] = 1'b0;
            end
        end
    end
  //-----------------------------------------------------------------------
  //This always block Collects the Error rule ID from Vlog Checker module
  //and pass it to the OVM Checker's Virtual interface.
  //-----------------------------------------------------------------------
  always @ (negedge Checker.chk_clock_u or negedge Checker.chk_clock_d)
    begin : BLOCK_DETECT_RULE_ERR_ID
      for(int i=0 ; i < `UV_NVS_MAX_RULE; i ++)
        begin
          if(Checker.rule_error_cov[i] === 1'b1)
            begin
      	      if_chk.chk_rule_error_id = i;
      	      if_chk.chk_rule_error_sig = prev_chk_rule_error_sig;
      	      prev_chk_rule_error_sig = ~prev_chk_rule_error_sig;
      	      
      	      @ (if_chk.chk_error_id_updated);
      	      
      	      Checker.rule_error_cov[i] = 1'b0;
            end
        end
    end // always @ (negedge Checker.chk_clock_u or negedge Checker.chk_clock_d)
  //-----------------------------------------------------------------------
  //This always block Collects the Log rule ID from Vlog Checker module
  //and pass it to the OVM Checker's Virtual interface.
  //-----------------------------------------------------------------------
  always @ (negedge Checker.chk_clock_u or negedge Checker.chk_clock_d)
    begin : BLOCK_DETECT_RULE_LOG_ID
      for(int i=0 ; i < `UV_NVS_MAX_RULE; i ++)
        begin
          if(Checker.rule_log_cov[i] === 1'b1)
            begin
      	      if_chk.chk_rule_log_id = i;
      	      if_chk.chk_rule_log_sig = prev_chk_rule_log_sig;
      	      prev_chk_rule_log_sig = ~prev_chk_rule_log_sig;
      	      
      	      @ (if_chk.chk_log_id_updated);
      	      
      	      Checker.rule_log_cov[i] = 1'b0;
            end
        end
    end // always @ (negedge Checker.chk_clock_u or negedge Checker.chk_clock_d)
   
  //-------------------------------------------------------------------------------
  // This block always triggers on change in dtr and passes its value to the
  // mon interface variable
  //-------------------------------------------------------------------------------
  always @(Checker.dtr)
    begin : BLOCK_DTR
      if_mon.data_term_rdy = Checker.in_dtr;
    end
   
  //-------------------------------------------------------------------------------
  // This block triggers on change in dsr signal and passes its value to the
  // mon interface variable
  //-------------------------------------------------------------------------------
  always @(Checker.dsr)
    begin : BLOCK_DSR
      if_mon.data_set_ready = Checker.in_dsr;
    end
   
  //-------------------------------------------------------------------------------
  // This block always triggers on change in rts signal and passes its value
  // to the mon interface variable
  //-------------------------------------------------------------------------------
  always @(Checker.in_rts)
    begin : BLOCK_IN_RTS
      if_mon.req_to_send = Checker.in_rts;
    end
   
  //-------------------------------------------------------------------------------
  // This block always triggers on change in cts signal and passes its value
  // to the mon interface variable
  //-------------------------------------------------------------------------------
  always @(Checker.in_cts)
    begin : BLOCK_IN_CTS
      if_mon.clear_to_send = Checker.in_cts;
    end
   
  //-------------------------------------------------------------------------------
  // This block triggers always on posedge of clock and sets the mon
  // interface variable if the data transfer is taking place on upstream
  //-------------------------------------------------------------------------------
  always @(posedge if_port.clk)
    begin : BLOCK_U_IN_PROGRESS
      if(Checker.get_packet_u_in_progress)
        if_mon.u_in_progress = 1;
      else
        if_mon.u_in_progress = 0;
    end
   
  //-------------------------------------------------------------------------------
  // This block triggers always on posedge of clock and sets the mon
  // interface variable if the data transfer is taking place on downstream
  //-------------------------------------------------------------------------------
  always @(posedge if_port.clk)
    begin : BLOCK_D_IN_PROGRESS
      if(Checker.get_packet_d_in_progress)
        if_mon.d_in_progress = 1;
	    else
        if_mon.d_in_progress = 0;
    end
  
  //-------------------------------------------------------------------------------
  // This block is always triggered on posedge of baud clock. It calculates
  // the intercycle delay for the upstream and downstream traffic
  //-------------------------------------------------------------------------------
  always@(posedge Checker.baudX16)
    begin : BLOCK_INTR_CYCL_DELAY
      if(wait_for_start_detect_d)
        begin
          intr_cycl_delay_d = intr_cycl_delay_d + 1;
        end
      if(wait_for_start_detect_u)
        begin
          intr_cycl_delay_u = intr_cycl_delay_u + 1;
        end
    end
   
endmodule // nvs_uv_sv_mon_driver

