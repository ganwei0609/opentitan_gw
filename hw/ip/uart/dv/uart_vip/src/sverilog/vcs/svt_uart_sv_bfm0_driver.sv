
`ifdef SVT_UART
//import svt_uart_uvm_pkg::*;
`else
import nvs_uart_pkg::*;
`endif

// ------------------------------------------------------------------------------------------------
// module nvs_uv_sv_bfm0_driver
// ------------------------------------------------------------------------------------------------
//Declare Module
module `NVS_UV_SV_BFM0_DRIVER ( `NVS_UV_SV_PORT_IF  port_if,
				// For passing Bfm0 transaction information 
				`NVS_UV_SV_BFM_IF   if_bfm0,
				`NVS_UV_SV_MON_IF   if_bfm0_mon,
				`NVS_UV_SV_CHK_IF   if_bfm0_chk
				);
   
`ifdef UV_PROTECT
 `include `NVS_UV_LIB_GEN_VIHP // Updated by Codegensvt
`else
 `include `NVS_UV_LIB_GEN_VIH // Updated by Codegensvt
`endif
   
  //--------------------------------------------------------------------------------------
  // Bfm0 Xaction interface signals
  //--------------------------------------------------------------------------------------
  bit	do_cmd_called_prev;
  bit	do_cfg_called_prev;
  bit	do_err_called_prev;
  bit	do_pkt_called_prev;
  bit	ignore_do_cmd_call;
  bit 	ignore_do_cfg_call;
  bit 	ignore_do_err_call;
  bit 	ignore_do_pkt_call;
  bit 	Bfm0_idle_sig_prev;
  bit  do_cfg_called_prev_chk;
  bit  ignore_do_cfg_call_chk;
  bit  disable_registry_chk=0;
  wire sclo_Bfm00 ;
  wire sdao_Bfm00 ;

  bit 	enable_tx_rx_handshake = 1'b0;

  parameter SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK = 1;

  //--------------------------------------------------------------------------------------
  // Initialize vaiables
  //--------------------------------------------------------------------------------------
  initial
    begin
      do_cmd_called_prev                            = 1'b0;
      do_cfg_called_prev                            = 1'b0;
      do_cfg_called_prev_chk                        = 1'b0;
      ignore_do_cfg_call_chk                        = 1'b0;
      do_err_called_prev                            = 1'b0;		
      do_pkt_called_prev                            = 1'b0;
    end
  
  defparam Bfm0.UV_DEVICE_TYPE = `UV_DTE;
  defparam Bfm0_Monitor.Checker.UV_DEVICE_TYPE = `UV_DTE;
  defparam Bfm0.UV_NVS_INST_NAME = "DTE BFM";
  
  `NVS_UV_BFM  Bfm0 (
 	      .rst (port_if.rst  ),	      //Reset
	      .clk (port_if.clk  ),        //clock input
	      .sin (port_if.sin  ),        // serial input
	      .cts (port_if.cts  ),        // clear to send
	      .dsr (port_if.dsr  ),        // data set ready		
	      .dtr (port_if.dtr  ),        // data terminal ready
	      .rts (port_if.rts  ),        // request to send
	      .sout(port_if.sout ),        // serial output
	      .baudout(port_if.baudout ) 
	      ); // end module nvs_uv_bfm
  
  `NVS_UV_SV_MON_DRIVER #(.UV_CROSS_MAP(0)) Bfm0_Monitor (
	 		       port_if        ,
	 		       if_bfm0_mon        , 
	 		       if_bfm0_chk          
	 		       );

  initial begin
    if(!($value$plusargs("svt_uart_disable_registry_chk=%0b",disable_registry_chk)))
      disable_registry_chk = 1'b0;
    if(SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK == 1 && disable_registry_chk==0) begin
      if(if_bfm0.is_wrapper_registered())
        begin
          print_fatal("svt_uart_sv_bfm0_driver","Multiple registry for DTE wrapper. Please check that a single DTE verilog wrapper (svt_uart_bfm_wrapper) is connected to an SVT agent (svt_uart_agent) in the testbench");
        end
      
      if_bfm0.register_wrapper();
      // SVT Agent does its registry in connection phase. With #1, we are
      // allowing 'connect phase' to get over before we check the SVT
      // registry for DTE module instance
      #1;
      if(!if_bfm0.is_svt_registered())
        begin
          print_fatal("svt_uart_sv_bfm0_driver","DTE SVT Component registry not found. Please check that an SVT Agent (svt_uart_agent) is connected to a Verilog module (svt_uart_bfm_wrapper) in the testbench");
        end
    end
  end
             
  //--------------------------------------------------
  //Open log file for logging BFM0 Monitor messages.
  //--------------------------------------------------
  reg [31:0] hnd2;
  int bus_no;
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
      if(if_bfm0.enable_traffic_log === 1'b1) begin
        
        file_name = $psprintf("%s.uart_svt.log", if_bfm0.full_name);
        hnd2=$fopen(file_name);
        
        Bfm0_Monitor.Monitor.enable_traffic_log = 1'b1;
`protected
c7KB95cABO(G\4d3]bZ2N=W5dQ5)EGaNGO^U4XQTL/>a,^&>Y=b]()6J@@/;JIE&
4d-bEKEF[^H;[/HgTWa#9L6P43[JI)O]/b4Ca?DGc+1]dJ@GNMJ1-(0@SZ2ZPH4A
KS>UcHb_/XP=C?aN;d;#3GE&8OH#_@-Ta0g&/=0&0R<8R)SUEf3G-#\PJ>9?=MGI
5[O.KT/a=-S)0/>U=L68LYd\>B1[]0Q&+.Ce5d^eXCK8E$
`endprotected

        
        Bfm0_Monitor.Monitor.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
        Bfm0_Monitor.Checker.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
        Bfm0.do_cfg(`UV_MODE_FILE_HANDLE,hnd2);
      end
    end

  
  // ------------------------------------------------------------------------------------------------
  // do_cmd
  // This always block is executed when the Bfm0 Xactor calls its do_cmd task and maps the
  // Command, address and byte count on the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm0.call_do_cmd)
    begin: block_do_cmd_caller
      `uart_debug_v1(" do cmd Command - %d", if_bfm0.cmd);
      ignore_do_cmd_call = 0;
      if(ignore_do_cmd_call)
        ignore_do_cmd_call = 0;
      else
        begin
          `uart_debug("call_do_cmd");
          Bfm0.do_cmd(if_bfm0.packet_count);
          if_bfm0.do_cmd_called  = ~if_bfm0.do_cmd_called;
          `uart_debug("do_cmd_called");
        end
    end // block_do_cmd_caller
  // ------------------------------------------------------------------------------------------------
  // do_cfg
  // This always block is executed when the Bfm0 Xactor calls its do_cfg task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm0.call_do_cfg)
    begin: block_do_cfg_caller
      `uart_debug_v2(" do cfg Param - %d Pvalue- %d",if_bfm0.param, if_bfm0.pvalue);
      ignore_do_cfg_call = 0;
      if(ignore_do_cfg_call)
        ignore_do_cfg_call = 0;
      else
        begin
          if(if_bfm0.param === `UV_ENABLE_TX_RX_HANDSHAKE)
           enable_tx_rx_handshake = if_bfm0.pvalue;
`ifdef SNPS_UART_DEBUG
          if (if_bfm0.param == `SVT_UART_BAUD_DIVISOR)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_BAUD_DIVISOR %0d",if_bfm0.pvalue);
          if (if_bfm0.param == `SVT_UART_ENABLE_FRACTIONAL_BRD)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_ENABLE_FRACTIONAL_BRD %0d",if_bfm0.pvalue);
          if (if_bfm0.param == `SVT_UART_FRACTIONAL_DIVISOR)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_DIVISOR %0d",if_bfm0.pvalue);
          if (if_bfm0.param == `SVT_UART_FRACTIONAL_DIVISOR_PERIOD)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_DIVISOR_PERIOD %0d",if_bfm0.pvalue);
          if (if_bfm0.param == `SVT_UART_FRACTIONAL_MULT_MEDIAN)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_FRACTIONAL_MULT_MEDIAN %0d",if_bfm0.pvalue);
          if (if_bfm0.param == `SVT_UART_SAMPLE_RATE)
            $display($time," SNPS UART DEBUG :%m: SVT_UART_SAMPLE_RATE %0d",if_bfm0.pvalue);
`endif

            Bfm0.do_cfg(if_bfm0.param,if_bfm0.pvalue);
            if_bfm0.do_cfg_called  = ~if_bfm0.do_cfg_called;
            `uart_debug("do_cfg_called");
        end
    end // block_do_cfg_caller

  // ------------------------------------------------------------------------------------------------
  // do_pkt
  // This always block is executed when the Bfm0 Xactor calls its do_pkt task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm0.call_do_pkt)
    begin: block_do_pkt_caller
      `uart_debug_v2(" do pkt Index - %d Data- %d",if_bfm0.index, if_bfm0.data);
      ignore_do_pkt_call = 0;
      if(ignore_do_pkt_call)
        ignore_do_pkt_call = 0;
      else
        begin
          `uart_debug("call_do_pkt");
          Bfm0.do_pkt(if_bfm0.index,if_bfm0.data);
          if_bfm0.do_pkt_called  = ~do_pkt_called_prev;
          do_pkt_called_prev          = ~do_pkt_called_prev;
          `uart_debug("do_pkt_called");
        end
    end // block_do_pkt_caller
  // ------------------------------------------------------------------------------------------------
  // do_err
  // This always block is executed when the Bfm0 Xactor calls its do_err task and maps the
  // parameters onto the bfm_xaction_if interface.
  // ------------------------------------------------------------------------------------------------
  always @(if_bfm0.call_do_err)
    begin: block_do_err_caller
      `uart_debug_v2(" do err No - %d Pvalue- %d",if_bfm0.err, if_bfm0.value);
      ignore_do_err_call = 0;
      if(ignore_do_err_call)
        ignore_do_err_call = 0;
      else
        begin
          `uart_debug("call_do_err");
          Bfm0.do_err(if_bfm0.err,if_bfm0.value);
          if_bfm0.do_err_called  = ~do_err_called_prev;
          do_err_called_prev          = ~do_err_called_prev;
          `uart_debug("do_err_called");
        end
    end // block_do_err_caller
  
  //--------------------------------------------------------------------------------------
  // Always block
  // Description : This always block captures the events of the Verilog 
  // Bfm0 and passes it to the event interface to be used in the directed
  // test cases   
  //--------------------------------------------------------------------------------------
  always@ ( Bfm0.event_trans_over         ) begin 
     if_bfm0.event_trans_over_trigger ;
  end
  always@ ( Bfm0.event_rts_asserted       ) begin 
     if_bfm0.event_rts_asserted_trigger  ;       
  end
  always@ ( Bfm0.event_dsr_detected       ) begin 
     if_bfm0.event_dsr_detected_trigger   ;      
  end
  always@ ( Bfm0.event_bfm_idle           ) begin 
     if_bfm0.event_bfm_idle_trigger       ;     
  end
  always@ ( Bfm0.event_bfm_data_send      ) begin 
     if_bfm0.event_bfm_data_send_trigger   ;     
  end
  always@ ( Bfm0.event_start_pkt_send     ) begin 
     if_bfm0.event_start_pkt_send_trigger ;      
  end
  always@ ( Bfm0.event_start_pkt_received ) begin 
     if_bfm0.event_start_pkt_received_trigger  ; 
  end
  always@ ( Bfm0.event_bfm_data_received  ) begin 
     if_bfm0.event_bfm_data_received_trigger   ; 
  end
  always@ ( Bfm0.event_pkt_received_over  ) begin 
     if_bfm0.event_pkt_received_over_trigger  ;  
  end
  always@ ( Bfm0.event_pkt_send_over      ) begin 
     if_bfm0.event_pkt_send_over_trigger       ; 
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
  initial
    begin
      i = 0 ;
      prev_update_trans = 1'b0;
      prev_update_trans_rcv = 1'b0;
      xchg_mutex = new(1);
      xchg_mutex1 = new(1);
    end
  always @(Bfm0.event_pkt_send_over  )
    begin
      xchg_mutex.get();
      
      if_bfm0.payload_sig    = Bfm0.usr_bfm_data_send ; 
      if_bfm0.parity_sig_tx  = Bfm0.usr_bfm_parity_sent ;
      if_bfm0.packet_tx      = Bfm0.transmit_packet ;

      wait_for_xact_ack  ();
      xchg_mutex.put(); 
    end
  always@(Bfm0.event_pkt_received_over)
    begin
      xchg_mutex.get();

      if_bfm0.payload_sig      = Bfm0.usr_bfm_data_received ;
      if_bfm0.parity_sig_rx    = Bfm0.usr_bfm_received_parity ;
      if_bfm0.packet_rx        = Bfm0.received_packet ;

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
      if_bfm0.update_trans      = ~prev_update_trans;
      prev_update_trans         = ~prev_update_trans;

      `uart_debug( "MST_DRIVER waiting for Trans_updated from Xactor");

      //wait for trans updated signal from xchange interface
      @(if_bfm0.trans_updated);

      `uart_debug( "MST_DRIVER : count_updated rcvd from Xactor");
    end
  endtask // wait_for_count_ack
  
  
  //-------------------------------------------------------------------------------------------
  // wait_for_count_ack_rcv
  // This task informs xactor of new tr and waits for xactor acknowledgement from recieve side.
  //--------------------------------------------------------------------------------------------
  task wait_for_xact_ack_rcv();
    begin
      //Drive update_trans of xchange interface
      if_bfm0.update_trans_rcv      = ~prev_update_trans_rcv;
      prev_update_trans_rcv         = ~prev_update_trans_rcv;

      `uart_debug( "MST_DRIVER waiting for Trans_updated from Xactor");

      //wait for trans updated signal from xchange interface
      @(if_bfm0.trans_updated_rcv);

      `uart_debug( "MST_DRIVER : count_updated rcvd from Xactor");
    end
  endtask // wait_for_count_ack
      
endmodule 

