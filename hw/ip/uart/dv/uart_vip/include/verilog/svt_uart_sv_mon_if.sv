`ifdef UV_OVM_ON_MODEL
import nvs_uart_pkg::*;
`endif

// ------------------------------------------------------------------------------------------------
// Interface nvs_uv_ovm_mon_if
// ------------------------------------------------------------------------------------------------
`ifdef __SVDOC__
typedef class svt_uart_err_check;
`endif
   
//Declare Module
interface `NVS_UV_SV_MON_IF () ;

   //#############################################################
   //#                                                           #
   //#                                                           #
   //#                 XCHANGE IF                                #
   //#                                                           #
   //#                                                           #
   //#############################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for xchange interface
   // ------------------------------------------------------------------------------------------------
   bit  trans_updated_u            ;
   bit  trans_updated_d            ;
   bit  update_trans_u             ;
   bit  update_trans_d             ;

   bit 	record_packet_start_time_u;
   bit 	record_packet_start_time_d;
   

   // ------------------------------------------------------------------------------------------------
   // Variables associated with do_cmd
   // ------------------------------------------------------------------------------------------------
   logic [63:0] address_sig    ; // Variable for the address of the command initiated by the BFM
   bit   [31:0] packet_count_sig ; // Variable for the byte count of the command initiated by the
   // BFM
   logic [8:0] 	payload_sig_u               ;
   logic [8:0] 	payload_sig_d               ;
   logic [12:0] 	received_pkt_u               ;
   logic [12:0] 	received_pkt_d               ;
   logic [31:0] mode_pkt_sz_sig           ;				    
   logic [31:0] 		   packet_count_sz_sig         ;				    
   logic [31:0] 		   dtr_assert_delay_time_sig ;      
   logic [31:0] 		   inter_cycle_delay_sig     ;         
   logic [31:0] 		   delay_rts_sig             ;          
   logic 			   mode_band_sig             ;        
   
   //#############################################################
   //#                                                           #
   //#                                                           #
   //#                 XACTION IF                                #
   //#                                                           #
   //#                                                           #
   //#############################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for xaction interface
   // ------------------------------------------------------------------------------------------------
   bit [31:0] 		   id_mon_xchange_if; 
   // ------------------------------------------------------------------------------------------------
   // Signals releated to do_cfg and do_cfg_rd task
   // ------------------------------------------------------------------------------------------------
   bit 			   call_do_cfg    ; 
   bit 			   call_do_cfg_rd ; 
   bit 			   do_cfg_called  ; 
   bit 			   do_cfg_rd_called; 
   logic [31:0] 		   param          ; 
   logic [511:0] 		   pvalue         ; 
   logic [511:0] 		   pvalue_rd      ; 
   // ------------------------------------------------------------------------------------------------
   // Events
   // ------------------------------------------------------------------------------------------------
   logic 			   end_simulation ; 
   logic 			   master_idle_sig; 
   logic 			   slave_idle_sig ; 
   event 			   event_setup_phase   ;
   event 			   event_access_phase  ;
   event 			   event_transfer_done ;
   
   //#################################################################################################
   //#                                                                                               #
   //#                                                                                               #
   //#                                       EVENT IF                                                #
   //#                                                                                               #
   //#                                                                                               #
   //#################################################################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for event interface
   // ------------------------------------------------------------------------------------------------
   logic 			   trans_updated_event_if   ; // 1bit var
   logic 			   update_trans_event_if    ; // 1bit var
   event 			   event_mon_bfm_idle_event_if ; // Event
   // top file events
   event 			   event_print_perf    ; //Event 
   event 			   event_end_test      ; //Event 
   event 			   event_legend_printed; //Event 
   event 			   event_start_test    ; //Event 
   event 			   event_bus_idle      ; //Event 
  
   logic [31:0] 		   dsr_assert_delay_time_sig ;      
   logic [31:0] 		   sin_assert_delay_time_sig ;      
   logic [31:0] 		   sout_assert_delay_time_sig ;      
   logic [31:0] 		   rts_deasrt_asrt_delay_time_sig ;      
   logic [31:0] 		   cts_deasrt_asrt_delay_time_sig ;      
   logic [31:0] 		   rts_cts_delay_sig ;      
   logic [31:0] 		   dtr_dsr_delay_sig ; 
   logic                	   parity_sig_u;     
   logic  	                   parity_sig_d;     
   logic [31:0] 		   packet_count_bfr_cts_deassert ;      
   logic [31:0] 		   packet_count_bfr_rts_deassert ;      
   bit           dtr_asserted;
   bit           dsr_asserted;
   bit           sin_started;
   bit           sout_started;
   bit           rts_asserted;
   bit           cts_asserted;
   bit           end_of_pkt_sent;
   bit           payload_rcvd_u;
   bit           payload_rcvd_d;
   bit           rts_cts_asserted;
   bit           dtr_dsr_asserted;
   bit           evnt_packet_count_bfr_cts_deassert;
   bit           evnt_packet_count_bfr_rts_deassert;

   bit           bit_brk_con_u;
   bit           if_brk_u;
   bit           bit_brk_con_d;
   bit           if_brk_d;
   bit           data_term_rdy;
   bit           data_set_ready;
   bit           req_to_send;
   bit           clear_to_send;
   bit           start_det;
   bit           u_in_progress;
   bit           d_in_progress;
   bit           framing_error_u; 
   bit           framing_error_d; 
   bit           parity_error_u; 
   bit           parity_error_d; 
   bit           toggle_u;
   bit           toggle_d;

   logic [31:0]     intr_cycl_delay_u;
   logic [31:0]     intr_cycl_delay_d;

   //To Capture Start and End time of Upstream Packet
   real          packet_start_time_u;
   real          packet_end_time_u;
   //To Capture Start and End time of Downstream Packet
   real          packet_start_time_d;
   real          packet_end_time_d;
   

endinterface // nvs_uv_sv_mon_if;

 //------------------------------------------------------------------------------------------------
 // ************************ END OF FILE ********************************
