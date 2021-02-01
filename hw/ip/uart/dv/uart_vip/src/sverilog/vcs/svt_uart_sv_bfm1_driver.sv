`ifdef UV_OVM_ON_MODEL
import nvs_uart_pkg::*;
`else
 `ifdef UV_DTE_DUT
import nvs_uart_pkg::*;
`endif
`endif

//Declare Module
module `NVS_UV_SV_BFM1_DRIVER ( `NVS_UV_SV_PORT_IF   port_if,
			      // For passing bfm1 transaction information 
			      `NVS_UV_SV_BFM_IF   if_bfm1,
			      `NVS_UV_SV_MON_IF   if_bfm1_mon,
			      `NVS_UV_SV_CHK_IF   if_bfm1_chk
			      );

`ifdef UV_PROTECT
 `include `NVS_UV_LIB_GEN_VIHP // Updated by Codegensvt
`else
 `include `NVS_UV_LIB_GEN_VIH // Updated by Codegensvt
`endif
   
  //--------------------------------------------------------------------------------------
  // bfm1 Xaction interface signals
  //--------------------------------------------------------------------------------------
  bit	do_cmd_called_prev;
  bit	do_cfg_called_prev;
  bit	do_err_called_prev;
  bit	do_pkt_called_prev;
  bit	ignore_do_cmd_call;
  bit	ignore_do_cfg_call;
  bit	ignore_do_err_call;
  bit	ignore_do_pkt_call;
  bit	bfm1_idle_sig_prev;
  bit do_cfg_called_prev_chk   ;
  bit ignore_do_cfg_call_chk   ;
  bit	enable_tx_rx_handshake= 1'b0;
  bit disable_registry_chk=0;
  
  parameter SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK = 1;

  //--------------------------------------------------------------------------------------
  // Initial Block 
  //--------------------------------------------------------------------------------------
  initial
    begin
      do_cmd_called_prev      = 1'b0;
      do_cfg_called_prev      = 1'b0;
      do_err_called_prev      = 1'b0;	
      do_pkt_called_prev      = 1'b0;
      do_cfg_called_prev_chk  = 0;
      if_bfm1.is_dce          = 1;
    end

  defparam Bfm1.UV_DEVICE_TYPE=`UV_DCE;
  defparam Bfm1_Monitor.Checker.UV_DEVICE_TYPE=`UV_DCE;
  defparam Bfm1.UV_NVS_INST_NAME        = "DCE BFM";
  
  `NVS_UV_BFM  Bfm1 (
                    .rst (port_if.rst),
                    .clk (port_if.clk),
                    .rts (port_if.rts),
                    .sout(port_if.sout),
                    .dsr (port_if.dsr),
                    .cts (port_if.cts),
                    .sin (port_if.sin),
                    .dtr (port_if.dtr),
                    .baudout(port_if.baudout ) 
                  ); // end module nvs_uv_bfm
  
  `NVS_UV_SV_MON_DRIVER #(.UV_CROSS_MAP(1)) Bfm1_Monitor (
	 		       port_if        ,
	 		       if_bfm1_mon         , 
	 		       if_bfm1_chk          
	 		       );

  initial begin
    if(!($value$plusargs("svt_uart_disable_registry_chk=%0b",disable_registry_chk)))
       disable_registry_chk = 1'b0;
    if(SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK == 1 && disable_registry_chk==0) begin
      if(if_bfm1.is_wrapper_registered()) 
        begin
          print_fatal("svt_uart_sv_bfm1_driver","Multiple registry for DCE wrapper. Please check that a single DCE verilog wrapper (svt_uart_bfm_wrapper) is connected to an SVT agent (svt_uart_agent) in the testbench.");
        end
      
      if_bfm1.register_wrapper();
      // SVT Agent does its registry in connection phase. With #1, we are
      // allowing 'connect phase' to get over before we check the SVT
      // registry for DCE module instance
      #1;
      if(!if_bfm1.is_svt_registered())
        begin
          print_fatal("svt_uart_sv_bfm1_driver","DCE SVT Component registry not found. Please check that an SVT Agent (svt_uart_agent) is connected to a verilog module (svt_uart_bfm_wrapper) in the testbench.");
        end
    end
  end
             
  //--------------------------------------------------
  //Open log file for logging BFM1 Monitor messages.
  //--------------------------------------------------
  reg [31:0] hnd2;
  int bus_no = 0;
  int agent_no;
  
  string file_name;
  //------------------------------------------------------------------------------------------------
  // Task : assign_handle
  //        Pass log file handle to BFM and Monitor
  //------------------------------------------------------------------------------------------------
  initial
    begin
      #1;
      hnd2 = 0;

      if(if_bfm1.enable_traffic_log === 1'b1) begin
        file_name = $psprintf("%s.uart_svt.log",if_bfm1.full_name);
        hnd2=$fopen(file_name);
       
        Bfm1_Monitor.Monitor.enable_traffic_log = 1'b1;
`protected
TSa,F[N:.ScLYZ]65NX>0e)I=bb8A1-FDJBG>4)Oe\Cc8\ADgc5<0),TP@QE\UME
I++eaT\ZCaFPOA^bdA[D_gEf^fLD0/g-#@DCC=Lc<c@E9E/.NM=/#cYNdfFGUb/g
_<Ae?QJWTUU43X1TYX&;If_M3<;#\_GJ<O@UGIH9<4MEO[3g=Bb+.2S^#CH(5c9M
BD2I2DBc1?<UJ5N15H\.&.cHCPA022OZd=1;3_C^XBDEE$
`endprotected

              
        Bfm1_Monitor.Monitor.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
        Bfm1_Monitor.Checker.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
        Bfm1.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
      end
    end
  
  // ------------------------------------------------------------------------------------------------
  // do_cmd
  // This always block is executed when the bfm1 Xactor calls its do_cmd task and maps the
  // Command, address and byte count on the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm1.call_do_cmd)
    begin: block_do_cmd_caller
      `uart_debug_v1(" do cmd Command - %d", if_bfm1.cmd);
      ignore_do_cmd_call = 0;
      if(ignore_do_cmd_call)
        ignore_do_cmd_call = 0;
      else
        begin
           `uart_debug("call_do_cmd");
           Bfm1.do_cmd(
                       if_bfm1.packet_count);
           if_bfm1.do_cmd_called  = ~if_bfm1.do_cmd_called;
           `uart_debug("do_cmd_called");
        end
    end // block_do_cmd_caller
  // ------------------------------------------------------------------------------------------------
  // do_cfg
  // This always block is executed when the bfm1 Xactor calls its do_cfg task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm1.call_do_cfg)
    begin: block_do_cfg_caller
      `uart_debug_v2(" do cfg Param - %d Pvalue- %d",if_bfm1.param, if_bfm1.pvalue);
      ignore_do_cfg_call = 0;
      if(ignore_do_cfg_call)
        ignore_do_cfg_call = 0;
      else
        begin
          if(if_bfm1.param === `UV_ENABLE_TX_RX_HANDSHAKE)
            enable_tx_rx_handshake = if_bfm1.pvalue;
`ifdef SNPS_UART_DEBUG
          if (if_bfm1.param == `SVT_UART_BAUD_DIVISOR)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_BAUD_DIVISOR %0d",if_bfm1.pvalue);
          if (if_bfm1.param == `SVT_UART_ENABLE_FRACTIONAL_BRD)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_ENABLE_FRACTIONAL_BRD %0d",if_bfm1.pvalue);
          if (if_bfm1.param == `SVT_UART_FRACTIONAL_DIVISOR)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_DIVISOR %0d",if_bfm1.pvalue);
          if (if_bfm1.param == `SVT_UART_FRACTIONAL_DIVISOR_PERIOD)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_DIVISOR_PERIOD %0d",if_bfm1.pvalue);
          if (if_bfm1.param == `SVT_UART_FRACTIONAL_MULT_MEDIAN)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_MULT_MEDIAN %0d",if_bfm1.pvalue);
          if (if_bfm1.param == `SVT_UART_SAMPLE_RATE)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_SAMPLE_RATE %0d",if_bfm1.pvalue);
`endif

          Bfm1.do_cfg(if_bfm1.param,if_bfm1.pvalue);
          if_bfm1.do_cfg_called  = ~if_bfm1.do_cfg_called;
          `uart_debug("do_cfg_called");
        end
    end // block_do_cfg_caller

  // ------------------------------------------------------------------------------------------------
  // do_pkt
  // This always block is executed when the bfm1 Xactor calls its do_pkt task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm1.call_do_pkt)
    begin: block_do_pkt_caller
      `uart_debug_v2(" do pkt Index - %d Data- %d",if_bfm1.index, if_bfm1.data);
      ignore_do_pkt_call = 0;
      if(ignore_do_pkt_call)
        ignore_do_pkt_call = 0;
      else
        begin
          `uart_debug("call_do_pkt");
          Bfm1.do_pkt(if_bfm1.index,if_bfm1.data);
          if_bfm1.do_pkt_called  = ~do_pkt_called_prev;
          do_pkt_called_prev          = ~do_pkt_called_prev;
          `uart_debug("do_pkt_called");
        end
    end // block_do_pkt_caller
  // ------------------------------------------------------------------------------------------------
  // do_err
  // This always block is executed when the bfm1 Xactor calls its do_err task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm1.call_do_err)
    begin: block_do_err_caller
      `uart_debug_v2(" do err No - %d Pvalue- %d",if_bfm1.err, if_bfm1.value);
      ignore_do_err_call = 0;
      if(ignore_do_err_call)
        ignore_do_err_call = 0;
      else
        begin
           `uart_debug("call_do_err");
           Bfm1.do_err(if_bfm1.err,if_bfm1.value);
           if_bfm1.do_err_called  = ~do_err_called_prev;
           do_err_called_prev          = ~do_err_called_prev;
           `uart_debug("do_err_called");
        end
    end // block_do_err_caller
  
  //--------------------------------------------------------------------------------------
  // Always block
  // Description : This always block captures the events of the Verilog 
  // bfm1 and passes it to the event interface to be used in the directed
  // test cases   
  //--------------------------------------------------------------------------------------
  always@ ( Bfm1.event_trans_over         ) 
    begin : TRIGGER_TRANS_OVER
       if_bfm1.event_trans_over_trigger ;
    end
  always@ ( Bfm1.event_rts_asserted       ) 
    begin : TRIGGER_RTS_ASSERT
       if_bfm1.event_rts_asserted_trigger  ;       
    end
  always@ ( Bfm1.event_dsr_detected       ) 
    begin : TRIGGER_DSR_DET
       if_bfm1.event_dsr_detected_trigger   ;      
    end
  always@ ( Bfm1.event_bfm_idle           ) 
    begin : TRIGGER_BFM_IDLE
       if_bfm1.event_bfm_idle_trigger       ;     
    end
  always@ ( Bfm1.event_bfm_data_send      ) 
    begin : TRIGGER_BFM_DATA_SEND
       if_bfm1.event_bfm_data_send_trigger   ;     
    end
  always@ ( Bfm1.event_start_pkt_send     ) 
    begin : TRIGGER_START_PKT_SEND
       if_bfm1.event_start_pkt_send_trigger ;      
    end
  always@ ( Bfm1.event_start_pkt_received ) 
    begin : TRIGGER_START_PKT_RCVD
       if_bfm1.event_start_pkt_received_trigger  ; 
    end
  always@ ( Bfm1.event_bfm_data_received  ) 
    begin : TRIGGER_BFM_DATA_RCVD
       if_bfm1.event_bfm_data_received_trigger   ; 
    end
  always@ ( Bfm1.event_pkt_received_over  ) 
    begin : TRIGGER_PKT_RCVD_OVER
       if_bfm1.event_pkt_received_over_trigger  ;  
    end
  always@ ( Bfm1.event_pkt_send_over      ) 
    begin : TRIGGER_PKT_SEND_OVER
       if_bfm1.event_pkt_send_over_trigger       ; 
    end
  
  //---------------------------------------------------------------------
  //             LOGIC FOR SCOREBOAD
  //---------------------------------------------------------------------

  bit prev_update_trans;
  bit prev_update_trans_rcv;
  int i;
  semaphore xchg_mutex;
  semaphore xchg_mutex1;
  // This initial block assigns a single key to the semaphore xchg_mutex
  initial begin
    i = 0 ;
    prev_update_trans = 1'b0;
    prev_update_trans_rcv = 1'b0;
    xchg_mutex = new(1);
    xchg_mutex1 = new(1);
  end
  
  always @(Bfm1.event_pkt_send_over  )  
    begin : SB_PKT_SEND_OVER
      xchg_mutex.get();

      if_bfm1.payload_sig     = Bfm1.usr_bfm_data_send ;
      if_bfm1.parity_sig_tx   = Bfm1.usr_bfm_parity_sent ;
      if_bfm1.packet_tx       = Bfm1.transmit_packet ;
      
      wait_for_xact_ack  ();
      xchg_mutex.put(); 
    end
  
  always@(Bfm1.event_pkt_received_over) 
    begin : SB_PKT_RCVD_OVER
      xchg_mutex.get();

      if_bfm1.payload_sig    = Bfm1.usr_bfm_data_received ;
      if_bfm1.parity_sig_rx  = Bfm1.usr_bfm_received_parity ;
      if_bfm1.packet_rx      = Bfm1.received_packet ;
      
      wait_for_xact_ack_rcv  ();
      xchg_mutex.put(); 
    end
  
  //----------------------------------------------------------------------
  // wait_for_count_ack
  // This task informs xactor of new tr and waits for xactor acknowledgement.
  //----------------------------------------------------------------------
  task wait_for_xact_ack();
    begin
      //Drive update_trans of xchange interface
      if_bfm1.update_trans      = ~prev_update_trans;
      prev_update_trans         = ~prev_update_trans;
	
      `uart_debug( "MST_DRIVER waiting for Trans_updated from Xactor");

      //wait for trans updated signal from xchange interface
      @(if_bfm1.trans_updated);
	
      `uart_debug( "MST_DRIVER : count_updated rcvd from Xactor");
    end
  endtask // wait_for_xact_ack
  
  //-------------------------------------------------------------------------------------------
  // wait_for_count_ack_rcv
  // This task informs xactor of new tr and waits for xactor acknowledgement from recieve side.
  //--------------------------------------------------------------------------------------------
  task wait_for_xact_ack_rcv();
    begin
      //Drive update_trans of xchange interface
      if_bfm1.update_trans_rcv      = ~prev_update_trans_rcv;
      prev_update_trans_rcv         = ~prev_update_trans_rcv;
	
      `uart_debug( "MST_DRIVER waiting for Trans_updated from Xactor");
	
      //wait for trans updated signal from xchange interface
      @(if_bfm1.trans_updated_rcv);
	
      `uart_debug( "MST_DRIVER : count_updated rcvd from Xactor");
    end
  endtask // wait_for_xact_ack_rcv

endmodule // nvs_ahb_sv_bfm1_driver

