
`ifndef GUARD_UART_DCE_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_UART_DCE_TRANSACTION_SEQUENCE_COLLECTION_SV

/**
 * @grouphdr Sequences DCE_RANDOM_GENERATION 
 * This group contain random sequence.
 */

/**
 * @grouphdr Sequences DCE_BREAK_COND
 * This group contain break condition sequence.
 */

/**
 * @grouphdr Sequences DCE_SOFTWARE_SEND_XOFF_XON
 * This group contain send XOFF-XON software handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_PKT_GEN
 * This group contain packet generation sequence.
 */

/**
 * @grouphdr Sequences DCE_DRV_DSR
 * This group contain driving the user provided values on DSR pin and controling transmission of packets sequence.
 */

/**
 * @grouphdr Sequences DCE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
 * This group contain configured buffer flush and inter cycle delay with 
 * packet generation sequence.
 */

/**
 * @grouphdr Sequences DCE_HARDWARE_CTS_DELAY_WITH_PKT_GEN
 * This group contain configured cts cycle delay with 
 * packet generation hardware handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_HARDWARE_CTS_DELAY_WITHOUT_PKT_GEN
 * This group contain configured cts cycle delay without 
 * packet generation hardware handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_PRIMITIVE_SEQUENCES - Basic sequences
 * This group contains all primitive level sequences.
 * @groupref DCE_RANDOM_GENERATION
 * @groupref DCE_BREAK_COND
 * @groupref DCE_SOFTWARE_SEND_XOFF_XON
 * @groupref DCE_PKT_GEN
 * @groupref DCE_DRV_DSR
 * @groupref DCE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
 * @groupref DCE_HARDWARE_CTS_DELAY_WITH_PKT_GEN
 * @groupref DCE_HARDWARE_CTS_DELAY_WITHOUT_PKT_GEN
 */

/**
 * @grouphdr Sequences DCE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
 * This group contain configured buffer flush delay with 
 * packet generation and break condtion sequence.
 */

/**
 * @grouphdr Sequences DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN
 * This group contain send XOFF-XON with 
 * packet generation software handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_AND_BUFF_FLUSH_DELAY
 * This group contain send XOFF-XON with packet generation and 
 * configured buffer flush delay software handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_CONFG_BUFF_FLUSH_AND_INTR_CYCLE_DELAYS
 * This group contain send XOFF-XON with packet generation and
 * configured buffer flush and inter cycle delay software handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_HARDWARE_CTS_DELAY_ONLY_AND_BUFF_FLUSH_DELAY_WITH_PKT_GEN
 * This group contain configured cts cycle delay without packet generation and 
 * configured buffer flush delay hardware handshaking sequence.
 */

/**
 * @grouphdr Sequences DCE_COMPLEX_SEQUENCES_OF_SINGLE_TYPE - Complex sequences
 * This group contains all complex level sequences.
 * @groupref DCE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
 * @groupref DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN
 * @groupref DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_AND_BUFF_FLUSH_DELAY
 * @groupref DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_CONFG_BUFF_FLUSH_AND_INTR_CYCLE_DELAYS
 * @groupref DCE_HARDWARE_CTS_DELAY_ONLY_AND_BUFF_FLUSH_DELAY_WITH_PKT_GEN
 */

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not.
 */
typedef class svt_uart_agent;
class svt_uart_dce_base_sequence extends svt_sequence #(svt_uart_transaction);

  /** Factory Registration. */
  `svt_xvm_object_utils(svt_uart_dce_base_sequence)

  /** Parent Sequencer Declaration. */
  `svt_xvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** UART Transaction Instantiation For Response*/
  svt_uart_transaction rsp;

  /** UART Agent Instantiation */
  svt_uart_agent uart_agent;

  /** UART configuration obtained from the sequencer. */
  svt_uart_configuration cfg;

  /** 
   * Constructs a new svt_uart_dce_base_sequence instance 
   * @param name string to name the instance.
   */ 
  extern function new(string name="svt_uart_dce_base_sequence");

  /** Routes messages through the parent sequencer and raises an objection */
  extern virtual task pre_body();

  /** This task gets the configuration handle from the p_sequencer and cast it to the local cfg handle */
  extern virtual task body();

  /** Drop objection */
  extern virtual task post_body();

  /**
   * It will return (1) when is_applicable() called
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_base_sequence

//***********************************************************************
// UART Primitive Sequences
//***********************************************************************

/** 
 * @groupname DCE_RANDOM_GENERATION
 * This sequence generates random DCE transactions.
 */
class svt_uart_dce_random_sequence extends svt_uart_dce_base_sequence;

  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_random_sequence)

  /** 
   * Constructs the svt_uart_dce_random_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name="svt_uart_dce_random_sequence");

  /** Execute the svt_uart_dce_random_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_random_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_random_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_random_sequence::new(string name="svt_uart_dce_random_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_random_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_random_sequence::body();
  bit status;
  super.body();

  /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
  status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
  status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
  `svt_xvm_note("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));

  for (int i=0; i < sequence_length; i++) begin
    `svt_xvm_do(req)
  end
    
  /** 
   * Call get_response only if configuration attribute,
   * enable_put_response is set 1.
   */
  if(cfg.enable_put_response == 1) 
    for (int i=0; i < sequence_length; i++) begin 
      get_response(rsp);
  end
endtask: body

/**
 * @groupname DCE_BREAK_COND
 * This sequence creates a scenario for generating break condition from DCE.
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attribute<br/>
 * 
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized value.
 * 
 * - Execute sequence to generate break condition with packet_count<br/> 
 *   constrained to local_packet_count attribute.
 * . 
 */
class svt_uart_dce_break_cond_sequence extends svt_uart_dce_base_sequence;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #packet_count */
  constraint reasonable_pkt_delay {
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_break_cond_sequence)

  /** 
   * Constructs the svt_uart_dce_break_cond_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_break_cond_sequence");
      
  /** Execute the svt_uart_dce_break_cond_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_break_cond_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_break_cond_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_break_cond_sequence::new(string name = "svt_uart_dce_break_cond_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_break_cond_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_break_cond_sequence::body();
  bit status;
  int local_packet_count;

  super.body();

  `svt_xvm_note("body", "Entered ...");
`ifdef SVT_UVM_TECHNOLOGY
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_packet_count = this.packet_count;

  `svt_xvm_create(req);
  /** Off reasonable constraint */ 
  req.reasonable_packet_count.constraint_mode(0);
  /** Set break condition */ 
  req.break_cond = 1;
  `svt_xvm_rand_send_with(req,{
    packet_count == local_packet_count;
  })

  /** 
   * Call get_response only if configuration attribute,
   * enable_put_response is set 1.
   */
  if(cfg.enable_put_response == 1) begin 
    get_response(rsp);
  end

  `svt_xvm_note("body", "Exiting ...");
endtask: body

/**
 * @groupname DCE_SOFTWARE_SEND_XOFF_XON
 * This sequence creates a scenario to only send xoff and xon packets after<br/>   
 * disabling packet generation from DCE in case of Software Handshaking.
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Execute XOFF generation from DCE<br/>
 * 
 * - Wait for XOFF to appear on bus<br/>
 * 
 * - Execute XON generation from DCE after delay.
 * 
 * - Check for data in between XOFF and XON packet and if data is recieved between them, flash error<br/>
 * .
 */
class svt_uart_dce_soft_handshake_send_xoff_xon_sequence extends svt_uart_dce_base_sequence;

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_soft_handshake_send_xoff_xon_sequence)

  /** 
   * Constructs the svt_uart_dce_soft_handshake_send_xoff_xon_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_soft_handshake_send_xoff_xon_sequence");

  /** Execute the svt_uart_dce_soft_handshake_send_xoff_xon_sequence sequence */
  extern virtual task body();

  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::HARDWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_soft_handshake_send_xoff_xon_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_send_xoff_xon_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_soft_handshake_send_xoff_xon_sequence::new(string name = "svt_uart_dce_soft_handshake_send_xoff_xon_sequence");
  super.new(name);
endfunction: new 

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_send_xoff_xon_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_soft_handshake_send_xoff_xon_sequence::body();
  super.body();

  if(cfg.handshake_type == svt_uart_configuration::HARDWARE) begin
    `svt_xvm_error("body", {(is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"," is not compatible with hardware handshake type configuration"});
  end
  else
    begin
      `svt_xvm_note("body", "Entered ...");
      fork
        begin
          `svt_xvm_create(req);
          /** send XOFF data pattern */
          req.send_xoff_data_pattern   = 1;
          /** disable packet generation */
          req.enable_packet_generation = 0;
          `svt_xvm_send(req);
        
          uart_agent.monitor.wait_for_clk_posedge((cfg.max_delay_to_xon_after_xoff*cfg.baud_divisor)-(cfg.max_delay_to_xon_after_xoff/5));

          `svt_xvm_create(req);
          /** send XON data pattern */  
          req.send_xon_data_pattern    = 1;
          /** disable packet generation */
          req.enable_packet_generation = 0;
          `svt_xvm_send(req);
        end 

        begin 
          fork : check_for_invalid_data
            begin
              uart_agent.monitor.EVENT_XOFF_DETECTED.wait_trigger();
              uart_agent.monitor.EVENT_XON_DETECTED.wait_trigger();
              disable check_for_invalid_data;
            end
            begin
              uart_agent.monitor.EVENT_XOFF_DETECTED.wait_trigger();
              uart_agent.monitor.EVENT_RX_START_DETECTED.wait_trigger();
              `svt_xvm_error("body","Data received between XOFF and XON");
              disable check_for_invalid_data;
            end
          join
        end
      join   
      `svt_xvm_note("body", "Exiting ...");
    end
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_send_xoff_xon_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_soft_handshake_send_xoff_xon_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::HARDWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

/**
 * @groupname DCE_PKT_GEN
 * This sequence creates scenario which inserts inter cycle delay between packets and also transmits these packets<br/> 
 * in case of Software Handshaking.
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 * 
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count, inter cycle delay<br/> 
 *   are constrained to local_packet_count, local_inter_cycle_delay attributes respectively.
 * . 
 */
class svt_uart_dce_packet_sequence extends svt_uart_dce_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay and #packet_count */
  constraint reasonable_hndshk_pkt {
    inter_cycle_delay inside {[0:200]}; 
    packet_count inside {[1:200]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_packet_sequence)

  /** 
   * Constructs the svt_uart_dce_packet_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_packet_sequence");
       
  /** Execute the svt_uart_dce_packet_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_packet_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_packet_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_packet_sequence::new(string name = "svt_uart_dce_packet_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_packet_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_packet_sequence::body();
  bit status;
  int local_inter_cycle_delay;
  int local_packet_count;

  super.body();

    `svt_xvm_note("body", "Entered ...");
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
    `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
    status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
    `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
    status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
    `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
    status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
    `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

    local_inter_cycle_delay = this.inter_cycle_delay;
    local_packet_count      = this.packet_count;
    `svt_xvm_create(req)
    start_item(req);
    /** Off reasonable constraints */ 
    req.reasonable_packet_count.constraint_mode(0);
    req.reasonable_inter_cycle_delay.constraint_mode(0);
    assert(req.randomize() with {
      /** set number of packets to be sent */
      req.packet_count      == local_packet_count;
      /** set inter cycle delay to be sent */
      req.inter_cycle_delay == local_inter_cycle_delay;
    });
    finish_item(req);

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(cfg.enable_put_response == 1) begin 
      get_response(rsp);
    end
    `svt_xvm_note("body", "Exiting ...");
endtask: body

/**
 * @groupname DCE_DRV_DSR
 * This sequence creates scenario which drives user provided values on DSR pin and also controls transmission of packets<br/> 
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence by controlling generation of packets using enable_packet_generation with driving user specified values on DSR pin<br/> 
 *   using drive_dsr_signal and dsr_signal_value. Value of packet count is constrained to local_packet_count attribute.
 * . 
 */
class svt_uart_dce_drive_dsr_sequence extends svt_uart_dce_base_sequence;

  /** Packet count */
  rand int packet_count = 10;
  
  /** For Controling the driving of DSR pin */
  rand bit drive_dsr_signal = 0;
  
  /** Specifies the value to be assigned to DSR pin */
  rand bit dsr_signal_value = 0;
  
  /** Controls generation of packets */
  rand bit enable_packet_generation = 1'b1;

  /** Reasonable constraint for #inter_cycle_delay and #packet_count */
  constraint reasonable_pkt_cnt {
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_drive_dsr_sequence)

  /** 
   * Constructs the svt_uart_dce_drive_dsr_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_drive_dsr_sequence");

  /** Execute the svt_uart_dce_drive_dsr_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_drive_dsr_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_drive_dsr_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_drive_dsr_sequence::new(string name = "svt_uart_dce_drive_dsr_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_drive_dsr_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_drive_dsr_sequence::body();
  bit status;
  int local_packet_count;
  bit local_drive_dsr_signal;
  bit local_dsr_signal_value;
  bit local_enable_packet_generation;

  super.body();
 
  if(cfg.handshake_type == svt_uart_configuration::SOFTWARE ) begin
    `svt_xvm_error("body", {(is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"," is not compatible with software handshake type configuration"});
  end
  else
    begin
      `svt_xvm_note("body", "Entered ...");

`ifdef SVT_UVM_TECHNOLOGY
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "drive_dsr_signal", drive_dsr_signal);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", drive_dsr_signal, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "dsr_signal_value", dsr_signal_value);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", dsr_signal_value, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "enable_packet_generation", enable_packet_generation);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", enable_packet_generation, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
      status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".drive_dsr_signal"}, drive_dsr_signal);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", drive_dsr_signal, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".dsr_signal_value"}, dsr_signal_value);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", dsr_signal_value, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".enable_packet_generation"}, enable_packet_generation);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", enable_packet_generation, status ? "config DB" : "randomization"));
`endif

      local_packet_count             = this.packet_count;
      local_drive_dsr_signal         = this.drive_dsr_signal;
      local_dsr_signal_value         = this.dsr_signal_value;
      local_enable_packet_generation = this.enable_packet_generation;

      `svt_xvm_create(req)
      start_item(req);
      /** Off reasonable constraints */ 
      req.reasonable_packet_count.constraint_mode(0);
      assert(req.randomize() with {
        /** set number of packets to be sent */
        req.packet_count == local_packet_count;
      });
      req.drive_dsr_signal         = local_drive_dsr_signal;
      req.dsr_signal_value         = local_dsr_signal_value;
      req.enable_packet_generation = local_enable_packet_generation;

      finish_item(req);

      /** 
       * Call get_response only if configuration attribute,
       * enable_put_response is set 1.
       */
      if(cfg.enable_put_response == 1) begin 
        get_response(rsp);
      end
      `svt_xvm_note("body", "Exiting ...");
    end
endtask: body

/** 
 * @groupname DCE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
 * This sequence creates scenario which inserts buffer flush delay, inter cycle delay and also transmits packets.<br/>
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 * 
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence extends svt_uart_dce_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Buffer flush delay */
  rand int buffer_flush_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay, #buffer_flush_delay and #packet_count */
  constraint reasonable_pkt_delay {
    inter_cycle_delay inside {[0:2000]}; 
    buffer_flush_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence)

  /** 
   * Constructs the svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence");

  /** Execute the svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence::new(string name = "svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence");
  super.new(name);
endfunction: new      

//---------------------------------------------------------------------------------------------
// svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence::body();
  bit status;
  int local_inter_cycle_delay;
  int local_buffer_flush_delay;
  int local_packet_count;

  super.body();

  `svt_xvm_note("body", "Entered ...");
`ifdef SVT_UVM_TECHNOLOGY
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "buffer_flush_delay", buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".buffer_flush_delay"}, buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_inter_cycle_delay  = this.inter_cycle_delay;
  local_buffer_flush_delay = this.buffer_flush_delay;
  local_packet_count       = this.packet_count;

  `svt_xvm_create(req)
  start_item(req);
  /** Off resonable constraints */ 
  req.reasonable_packet_count.constraint_mode(0);
  req.reasonable_inter_cycle_delay.constraint_mode(0);
  req.reasonable_delay_to_flush_buffer.constraint_mode(0);
  assert(req.randomize() with {
    /** set number of packets to be sent */
    req.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    req.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    req.buffer_flush_delay == local_buffer_flush_delay;
  });
  finish_item(req);

  /** 
   * Call get_response only if configuration attribute,
   * enable_put_response is set 1.
   */
  if(cfg.enable_put_response == 1) begin 
    get_response(rsp);
  end
  `svt_xvm_note("body", "Exiting ...");
endtask: body

/** 
 * @groupname DCE_HARDWARE_CTS_DELAY_WITH_PKT_GEN
 * This sequence creates scenario which inserts delay on Clear To Send (CTS) signal, inter cycle delay<br/>
 * and also transmits packets, in case of Hardware Handshaking
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured CTS signal and inter cycle delay. Values of packet count,<br/> 
 *   cts delay  and inter cycle delay are constrained to local_packet_count, local_delay_cts and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence extends svt_uart_dce_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** clear to send delay */
  rand int delay_cts = 200;

  /** Packet count */
  rand int packet_count = 10;


  /** Reasonable constraint for #inter_cycle_delay, #delay_cts and #packet_count */
  constraint reasonable_pkt_hndshk_delay {
    inter_cycle_delay inside {[0:2000]}; 
    delay_cts inside { [0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence)

  /** 
   * Constructs the svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence");

  /** Execute the svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence sequence */
  extern virtual task body();
  
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::SOFTWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::new(string name = "svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence");
  super.new(name);
endfunction: new  

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::body();
  bit status;
  int local_inter_cycle_delay;
  int local_delay_cts;
  int local_packet_count;

  super.body();

  if(cfg.handshake_type == svt_uart_configuration::SOFTWARE) begin
    `svt_xvm_error("body", {(is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"," is not compatible with software handshake type configuration"});
  end
  else
    begin
      `svt_xvm_note("body", "Entered ...");
`ifdef SVT_UVM_TECHNOLOGY
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
      `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "delay_cts", delay_cts);
      `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
      status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
      `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".delay_cts"}, delay_cts);
      `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

      local_inter_cycle_delay = this.inter_cycle_delay;
      local_delay_cts         = this.delay_cts;
      local_packet_count      = this.packet_count;

      `svt_xvm_create(req)
      start_item(req);
      /** Off reasonable constraints */ 
      req.reasonable_packet_count.constraint_mode(0);
      req.reasonable_inter_cycle_delay.constraint_mode(0);
      req.reasonable_delay_in_cts_assertion.constraint_mode(0);
      assert(req.randomize() with {
        /** set number of packets to be sent */
        req.packet_count      == local_packet_count;
        /** set cts delay to be sent */
        req.delay_cts         == local_delay_cts;
        /** set inter cycle delay to be sent */
        req.inter_cycle_delay == local_inter_cycle_delay;
      });
      finish_item(req);

      /** 
       * Call get_response only if configuration attribute,
       * enable_put_response is set 1.
       */
      if(cfg.enable_put_response == 1) begin 
        get_response(rsp);
      end
      `svt_xvm_note("body", "Exiting ...");
    end
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_hard_handshake_delay_cts_packet_gen_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::SOFTWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

/** 
 * @groupname DCE_HARDWARE_CTS_DELAY_WITHOUT_PKT_GEN
 * This sequence creates scenario which inserts delay on Clear To Send by disabling packet generation from DCE,<br/>
 * in case of Hardware Handshaking 
 *   
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured CTS signal delay. Values of cts delay<br/> 
 *   is constrained to local_delay_cts attribute. 
 * .
 */
class svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence extends svt_uart_dce_base_sequence;
 
  /** clear to send delay */
  rand int delay_cts = 200;

  /** Reasonable constraint for #delay_cts */
  constraint reasonable_delay_cts {
    delay_cts inside {[0:2000]}; 
  } 

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence)

  /** 
   * Constructs the svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence");

  /** Execute the svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence sequence */
  extern virtual task body();
  
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::SOFTWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::new(string name = "svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence");
  super.new(name);
endfunction: new 

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::body();
  bit status;
  int local_delay_cts;

  super.body();

  if(cfg.handshake_type == svt_uart_configuration::SOFTWARE) begin
    `svt_xvm_error("body", {(is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"," is not compatible with software handshake type configuration"});
  end
  else
    begin
      `svt_xvm_note("body", "Entered ...");
`ifdef SVT_UVM_TECHNOLOGY
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "delay_cts", delay_cts);
      `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
      status = m_sequencer.get_config_int({get_type_name(), ".delay_cts"}, delay_cts);
      `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
`endif

      local_delay_cts = this.delay_cts;

      `svt_xvm_create(req)
      start_item(req);
      /** Off reasonable constraints */ 
      req.reasonable_delay_in_cts_assertion.constraint_mode(0);
      assert(req.randomize() with {
        /** set cts delay to be sent */
        req.delay_cts == local_delay_cts;
      });

      /** 
       * Set value of
       * packet generation enable/disable
       */ 
      req.enable_packet_generation = 0;
      finish_item(req);

      /** 
       * Call get_response only if configuration attribute,
       * enable_put_response is set 1.
       */
      if(cfg.enable_put_response == 1) begin 
        get_response(rsp);
      end
      `svt_xvm_note("body", "Exiting ...");
    end
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::SOFTWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

//***********************************************************************
// DCE Complex Sequences 
//************************************************************************

/** 
 * @groupname DCE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
 * This sequence creates scenario which inserts buffer flush and inter cycle delay and also transmits packets.<br/>
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and<br/>
 *   local_inter_cycle_delay attributes respectively.
 * 
 * - Execute sequence to generate break condition. Value of packet count is constrained to local_packet_count attribute.
 * .
 */
class svt_uart_dce_buffer_flush_delay_with_break_sequence extends svt_uart_dce_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Buffer flush delay */
  rand int buffer_flush_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay, #buffer_flush_delay, #packet_count */
  constraint reasonable_pkt_delay {
    inter_cycle_delay inside {[0:2000]}; 
    buffer_flush_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_buffer_flush_delay_with_break_sequence)

  /** 
   * Constructs the svt_uart_dce_buffer_flush_delay_with_break_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_buffer_flush_delay_with_break_sequence");
  
  /** Execute the svt_uart_dce_buffer_flush_delay_with_break_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dce_buffer_flush_delay_with_break_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_buffer_flush_delay_with_break_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_buffer_flush_delay_with_break_sequence::new(string name = "svt_uart_dce_buffer_flush_delay_with_break_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_buffer_flush_delay_with_break_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_buffer_flush_delay_with_break_sequence::body();

  svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence buffer_seq;
  svt_uart_dce_break_cond_sequence                         break_seq;

  bit status;
  int local_inter_cycle_delay;
  int local_buffer_flush_delay;
  int local_packet_count; 

  super.body();

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("body", "Entered ...", UVM_DEBUG);
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "buffer_flush_delay", buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("body", "Entered ...", OVM_DEBUG);
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".buffer_flush_delay"}, buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_inter_cycle_delay  = this.inter_cycle_delay;
  local_buffer_flush_delay = this.buffer_flush_delay;
  local_packet_count       = this.packet_count;

  /** generate packets with buffer flush delay */
  `svt_xvm_create(buffer_seq)
  /** Off reasonable constraints */ 
  buffer_seq.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(buffer_seq,{
    /** set number of packets to be sent */
    buffer_seq.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    buffer_seq.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    buffer_seq.buffer_flush_delay == local_buffer_flush_delay;
  })

  /** generate break condition */
  `svt_xvm_create(break_seq)
  /** Off reasonable constraints */ 
  break_seq.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(break_seq,{
    break_seq.packet_count == local_packet_count;
  })

  `svt_xvm_note("body", "Exiting ...");
endtask: body

/** 
 * @groupname DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN
 * This sequence creates scenario which inserts inter cycle delay and also transmits XON and XOFF packet,<br/>
 * in case of Software Handshaking. 
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count and<br/> 
 *   inter cycle delay are constrained to local_inter_cycle_delay and local_inter_cycle_delay attributes respectively.
 *   
 * - Execute XON and XOFF sequence, which verifies that DTE must not send any packet in between XOFF and XON packet.<br/>
 * 
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count and inter cycle delay<br/> 
 *   are constrained to local_inter_cycle_delay and local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence extends svt_uart_dce_base_sequence;
  
  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay and #packet_count */
  constraint reasonable_pkt_delay {
    inter_cycle_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence)

  /** 
   * Constructs the svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence");
 
  /** Execute the svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence sequence */
  extern virtual task body();
  
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::HARDWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::new(string name = "svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::body();

  svt_uart_dce_packet_sequence                       pkt_seq;
  svt_uart_dce_soft_handshake_send_xoff_xon_sequence xoff_xon_seq;

  bit status;
  int local_inter_cycle_delay;
  int local_packet_count;

  super.body();

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("body", "Entered ...", UVM_DEBUG);
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("body", "Entered ...", OVM_DEBUG);
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_inter_cycle_delay = this.inter_cycle_delay;
  local_packet_count      = this.packet_count;

  /** generate packets  */
  `svt_xvm_create(pkt_seq)
  /** Off reasonable constraints */ 
  pkt_seq.reasonable_hndshk_pkt.constraint_mode(0);
  `svt_xvm_rand_send_with(pkt_seq,{
    /** set number of packets to be sent */
    pkt_seq.packet_count      == local_packet_count;
    /** set inter cycle delay to be sent */
    pkt_seq.inter_cycle_delay == local_inter_cycle_delay;
  })

  /** prioritized xoff and xon */
  `svt_xvm_create(xoff_xon_seq)
  `svt_xvm_send(xoff_xon_seq)
  
  /** generate packets  */
  `svt_xvm_create(pkt_seq)
  /** Off reasonable constraints */ 
  pkt_seq.reasonable_hndshk_pkt.constraint_mode(0);
  `svt_xvm_rand_send_with(pkt_seq,{
    /** set number of packets to be sent */
    pkt_seq.packet_count      == local_packet_count;
    /** set inter cycle delay to be sent */
    pkt_seq.inter_cycle_delay == local_inter_cycle_delay;
  })

  `svt_xvm_note("body", "Exiting ...");
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_soft_handshake_packet_with_xoff_xon_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::HARDWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

/** 
 * @groupname DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_AND_BUFF_FLUSH_DELAY
 * This sequence creates scenario which inserts buffer flush delay and also transmits XON and XOFF packet,<br/>
 * in case of Software Handshaking. 
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * 
 * - Execute XON and XOFF sequence, which verifies that DTE must not send any packet in between XOFF and XON packet.<br/>
 * 
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count and inter cycle delay<br/> 
 *   are constrained to local_packet_count and local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence extends svt_uart_dce_base_sequence;
  
  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Buffer flush delay */
  rand int buffer_flush_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay, #buffer_flush_delay and #packet_count */
  constraint reasonable_pkt_hndshk_delay {
    inter_cycle_delay inside {[0:2000]}; 
    buffer_flush_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence)

  /** 
   * Constructs the svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence");
  
  /** Execute the svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence sequence */
  extern virtual task body();
 
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::HARDWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence
      
//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence::new(string name = "svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence:: body();

  svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence buffer_seq;
  svt_uart_dce_soft_handshake_send_xoff_xon_sequence       xoff_xon_seq;
  svt_uart_dce_packet_sequence                             pkt_seq;

  bit status;
  int local_inter_cycle_delay;
  int local_buffer_flush_delay;
  int local_packet_count;

  super.body();

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("body", "Entered ...", UVM_DEBUG);
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "buffer_flush_delay", buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("body", "Entered ...", OVM_DEBUG);
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".buffer_flush_delay"}, buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_inter_cycle_delay  = this.inter_cycle_delay;
  local_buffer_flush_delay = this.buffer_flush_delay;
  local_packet_count       = this.packet_count;

  /** generate packets with buffer flush delay */
  `svt_xvm_create(buffer_seq)
  /** Off reasonable constraints */ 
  buffer_seq.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(buffer_seq,{
    /** set number of packets to be sent */
    buffer_seq.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    buffer_seq.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    buffer_seq.buffer_flush_delay == local_buffer_flush_delay;
  })

  /** prioritized xoff and xon data pattern  before sending packets*/
  `svt_xvm_create(xoff_xon_seq)
  `svt_xvm_send(xoff_xon_seq)
  
  /** generate packets  */
  `svt_xvm_create(pkt_seq)
  /** Off reasonable constraints */ 
  pkt_seq.reasonable_hndshk_pkt.constraint_mode(0);
  `svt_xvm_rand_send_with(pkt_seq,{
    /** set number of packets to be sent */
    pkt_seq.packet_count      == local_packet_count;
    /** set inter cycle delay to be sent */
    pkt_seq.inter_cycle_delay == local_inter_cycle_delay;
  })

  `svt_xvm_note("body", "Exiting ...");
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_soft_handshake_buffer_flush_with_xoff_xon_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::HARDWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

/** 
 * @groupname DCE_SOFTWARE_SEND_XOFF_XON_WITH_PKT_GEN_CONFG_BUFF_FLUSH_AND_INTR_CYCLE_DELAYS
 * This sequence creates scenario which inserts buffer flush and inter cycle delay and also transmits XON and XOFF packets,<br/>
 * in case of Software Handshaking. 
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 *
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count and<br/> 
 *   inter cycle delay are constrained with local_packet_count and local_inter_cycle_delay attributes respectively.
 * 
 * - Execute XON and XOFF sequence, which verifies that DTE must not send any packet in between XOFF and XON packet.<br/>
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence extends svt_uart_dce_base_sequence;
 
  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Buffer flush delay */
  rand int buffer_flush_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay, #buffer_flush_delay and #packet_count */
  constraint reasonable_pkt_delay {
    inter_cycle_delay inside {[0:2000]}; 
    buffer_flush_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence)
   
  /** 
   * Constructs the svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence");
 
  /** Execute the svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence sequence */
  extern virtual task body();
  
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::HARDWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::new(string name = "svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::body();

  svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence buffer_seq1;
  svt_uart_dce_packet_sequence                             pkt_seq;
  svt_uart_dce_soft_handshake_send_xoff_xon_sequence       xoff_xon_seq;
  svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence buffer_seq3;

  bit status;
  int local_inter_cycle_delay;
  int local_buffer_flush_delay;
  int local_packet_count;

  super.body();

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("body", "Entered ...", UVM_DEBUG);
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "buffer_flush_delay", buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("body", "Entered ...", OVM_DEBUG);
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".buffer_flush_delay"}, buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delayis %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

  local_inter_cycle_delay  = this.inter_cycle_delay;
  local_buffer_flush_delay = this.buffer_flush_delay;
  local_packet_count       = this.packet_count;

  /** generate packets with buffer flush delay */
  `svt_xvm_create(buffer_seq1)
  /** Off reasonable constraints */ 
  buffer_seq1.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(buffer_seq1,{
    /** set number of packets to be sent */
    buffer_seq1.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    buffer_seq1.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    buffer_seq1.buffer_flush_delay == local_buffer_flush_delay;
  })

  /** generate packets  */
  `svt_xvm_create(pkt_seq)
  /** Off reasonable constraints */ 
  pkt_seq.reasonable_hndshk_pkt.constraint_mode(0);
  `svt_xvm_rand_send_with(pkt_seq,{
    /** set number of packets to be sent */
    pkt_seq.packet_count      == local_packet_count;
    /** set inter cycle delay to be sent */
    pkt_seq.inter_cycle_delay == local_inter_cycle_delay;
  })

  /** prioritized xoff and xon data pattern before sending packets */
  `svt_xvm_create(xoff_xon_seq)
  `svt_xvm_send(xoff_xon_seq)
  
  /** generate packets with buffer flush delay */
  `svt_xvm_create(buffer_seq3)
  /** Off reasonable constraints */ 
  buffer_seq3.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(buffer_seq3,{
    /** set number of packets to be sent */
    buffer_seq3.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    buffer_seq3.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    buffer_seq3.buffer_flush_delay == local_buffer_flush_delay;
  })

  `svt_xvm_note("body", "Exiting ...");
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_soft_handshake_packet_transaction_with_xoff_xon_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::HARDWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

/** 
 * @groupname DCE_HARDWARE_CTS_DELAY_ONLY_AND_BUFF_FLUSH_DELAY_WITH_PKT_GEN
 * This sequence creates scenario which inserts delay on Clear To Send by disabling packet generation from DCE,<br/>
 * inserts buffer flush and inter cycle delay and also transmits packets,in case of Hardware Handshaking. 
 *   
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence with configured CTS signal delay. Values of cts delay<br/> 
 *   is constrained to local_delay_cts. 
 * 
 * - Execute sequence to generate packets with configured buffer flush and inter cycle delay. Values of packet count,<br/> 
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay respectively.
 * .
 */
class svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence extends svt_uart_dce_base_sequence;

  /** clear to send delay */
  rand int delay_cts = 200;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Buffer flush delay */
  rand int buffer_flush_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #delay_cts, #inter_cycle_delay, #packet_count and #buffer_flush_delay */
  constraint reasonable_pkt_hndshk_delay_cts {
    delay_cts inside {[0:2000]}; 
    inter_cycle_delay inside {[0:2000]}; 
    buffer_flush_delay inside {[0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence)

  /** 
   * Constructs the svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence");
  
  /** Execute the svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence sequence */
  extern virtual task body();
 
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::SOFTWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::new(string name = "svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::body();

  svt_uart_dce_hard_handshake_delay_cts_without_packet_gen_sequence cts_seq;
  svt_uart_dce_buffer_flush_and_inter_cycle_delay_sequence          buffer_seq;

  bit status;
  int local_delay_cts;
  int local_inter_cycle_delay;
  int local_buffer_flush_delay;
  int local_packet_count;

  super.body();
 
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("body", "Entered ...", UVM_DEBUG);
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "buffer_flush_delay", buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
  status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "delay_cts", delay_cts);
  `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("body", "Entered ...", OVM_DEBUG);
  status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
  `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".buffer_flush_delay"}, buffer_flush_delay);
  `svt_xvm_debug("body", $sformatf("buffer_flush_delay is %0d as a result of %0s.", buffer_flush_delay, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
  `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
  status = m_sequencer.get_config_int({get_type_name(), ".delay_cts"}, delay_cts);
  `svt_xvm_debug("body", $sformatf("delay_cts is %0d as a result of %0s.", delay_cts, status ? "config DB" : "randomization"));
`endif

  local_delay_cts          = this.delay_cts;
  local_inter_cycle_delay  = this.inter_cycle_delay;
  local_buffer_flush_delay = this.buffer_flush_delay;
  local_packet_count       = this.packet_count;

  /** generate handshaking delay on cts  without packets */
  `svt_xvm_create(cts_seq)
  /** Off reasonable constraints */ 
  cts_seq.reasonable_delay_cts.constraint_mode(0);
  `svt_xvm_rand_send_with(cts_seq,{
    /** set cts delay to be sent */
    cts_seq.delay_cts == local_delay_cts;
  });

  /** generate packets with buffer flush delay */
  `svt_xvm_create(buffer_seq)
  /** Off reasonable constraints */ 
  buffer_seq.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(buffer_seq,{
    /** set number of packets to be sent */
    buffer_seq.packet_count       == local_packet_count;
    /** set inter cycle delay to be sent */
    buffer_seq.inter_cycle_delay  == local_inter_cycle_delay;
    /** set buffer flush delay to be sent */
    buffer_seq.buffer_flush_delay == local_buffer_flush_delay;
  })

  `svt_xvm_note("body", "Exiting ...");
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_hardware_handshake_delay_on_cts_without_packets_and_buffer_flush_delay_sequence::is_applicable(svt_configuration cfg);
  svt_uart_configuration uart_cfg;
  if(!$cast(uart_cfg, cfg)) begin
    `svt_xvm_fatal("body", "Unable to cast cfg to svt_uart_configuration type");
  end
  if(uart_cfg.handshake_type == svt_uart_configuration::SOFTWARE) 
    return 0;
  else
    return 1;
endfunction: is_applicable

`protected
\-]?MW@2B8NWS4f+L(Ld^BH<CQNLb@FgG,X2X9DV4QKgWO:FU>0\,)C4=)CX9e]7
SQQ?2UG0[=WFD8a8f&VRN#X_e&Ab_V,FdZ8-fE#TfDQT1bKJ&P,9LJ)Cf-1aV\8[
P;cTfd6ZA]aO7525,G4WbAUI0(9fLR\-3T^PX:;0[>3K)A\;#GQP.PS8,O+]#L+c
^e49gc?#P)N2NB.UB?PYCRB:b)[c[HIF/;&dJ>0+A=G4W4YJ\ARB_<W],dU1C<01
^&SQdVRUTR)2.$
`endprotected


//---------------------------------------------------------------------------------------------
// svt_uart_dce_base_sequence::pre_body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_base_sequence::pre_body();
  raise_phase_objection();
endtask: pre_body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_base_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_base_sequence::body();
  svt_configuration get_cfg;
  `svt_note("body", {"Executing ", (is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"});
  p_sequencer.get_cfg(get_cfg);
  if(!$cast(cfg, get_cfg)) begin
    `svt_xvm_fatal("body", "Failed when attempting to cast svt_uart_configuration");
  end
  if(cfg.uart_if==null) begin
    `svt_xvm_fatal("body", " svt_uart_dce_base_sequence virtual interface handle in received configuration is null");
  end
  void'($cast(uart_agent,p_sequencer.get_parent()));
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_base_sequence::post_body()
//---------------------------------------------------------------------------------------------
task svt_uart_dce_base_sequence::post_body();
  drop_phase_objection();
endtask: post_body

//---------------------------------------------------------------------------------------------
// svt_uart_dce_base_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dce_base_sequence::is_applicable(svt_configuration cfg);
  return 1;
endfunction: is_applicable

`endif // GUARD_UART_DCE_TRANSACTION_SEQUENCE_COLLECTION_SV
