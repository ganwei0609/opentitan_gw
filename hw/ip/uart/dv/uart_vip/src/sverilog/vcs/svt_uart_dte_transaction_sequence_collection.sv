
`ifndef GUARD_UART_DTE_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_UART_DTE_TRANSACTION_SEQUENCE_COLLECTION_SV

/**
 * @grouphdr Sequences DTE_RANDOM_GENERATION 
 * This group contain random sequence.
 */

/**
 * @grouphdr Sequences DTE_BREAK_COND
 * This group contain break condition sequence.
 */

/**
 * @grouphdr Sequences DTE_PKT_GEN
 * This group contain packet generation sequence.
 */

/**
 * @grouphdr Sequences DTE_DRV_DTR
 * This group contain driving the user provided values on DTR pin and controling transmission of packets sequence.
 */

/**
 * @grouphdr Sequences DTE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
 * This group contain configured buffer flush and inter cycle delay with 
 * packet generation sequence.
 */

/**
 * @grouphdr Sequences DTE_HARDWARE_RTS_DELAY_WITH_PKT_GEN
 * This group contain configured rts cycle delay with 
 * packet generation hardware handshaking sequence.
 */

/**
 * @grouphdr Sequences DTE_PRIMITIVE_SEQUENCES - Basic sequences
 * This group contains all primitive level sequences.
 * @groupref DTE_RANDOM_GENERATION
 * @groupref DTE_BREAK_COND
 * @groupref DTE_PKT_GEN
 * @groupref DTE_DRV_DTR
 * @groupref DTE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
 * @groupref DTE_HARDWARE_RTS_DELAY_WITH_PKT_GEN
 */

/**
 * @grouphdr Sequences DTE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
 * This group contain configured buffer flush delay with 
 * packet generation and break condtion sequence.
 */

/**
 * @grouphdr Sequences DTE_INTR_CYCLE_DELAY_WITH_PKT_GEN_AND_BREAK_COND
 * This group contain configured inter cycle delay with 
 * packet generation and break condtion sequence.
 */

/**
 * @grouphdr Sequences DTE_COMPLEX_SEQUENCES_OF_SINGLE_TYPE - Complex sequences
 * This group contains all complex level sequences.
 * @groupref DTE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
 * @groupref DTE_INTR_CYCLE_DELAY_WITH_PKT_GEN_AND_BREAK_COND
 */

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not.
 */
typedef class svt_uart_agent;
class svt_uart_dte_base_sequence extends svt_sequence #(svt_uart_transaction);
  
  /** Factory Registration. */
  `svt_xvm_object_utils(svt_uart_dte_base_sequence)

  /** Parent Sequencer Declaration. */
  `svt_xvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** UART Transaction Instantiation For Response*/
  svt_uart_transaction rsp;

  /** UART Agent Instantiation */
  svt_uart_agent uart_agent;

  /** UART configuration obtained from the sequencer. */
  svt_uart_configuration cfg;

  /** 
   * Constructs a new svt_uart_dte_base_sequence instance 
   * @param name string to name the instance.
   */ 
  extern function new(string name="svt_uart_dte_base_sequence");

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

endclass: svt_uart_dte_base_sequence

//**************************************************************************
// UART Primitive Sequences
//**************************************************************************

/** 
 * @groupname DTE_RANDOM_GENERATION
 * This sequence generates random DTE transactions.
 */
class svt_uart_dte_random_sequence extends svt_uart_dte_base_sequence;

  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dte_random_sequence)

  /** 
   * Constructs the svt_uart_dte_random_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name="svt_uart_dte_random_sequence");
  
  /** Execute the svt_uart_dte_random_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_random_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_random_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_random_sequence::new(string name="svt_uart_dte_random_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_random_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_random_sequence::body();
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
  if(cfg.enable_put_response == 1) begin 
    for (int i=0; i < sequence_length; i++) 
      get_response(rsp);
  end
endtask: body

/**
 * @groupname DTE_BREAK_COND
 * This sequence creates a scenario for generating break condition from DTE.
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attribute<br/>
 * 
 * - Receives value of local attribute of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized value.
 * 
 * - Execute sequence to generate break condition with packet_count<br/> 
 *   constrained to local_packet_count attribute.
 * . 
 */
class svt_uart_dte_break_cond_sequence extends svt_uart_dte_base_sequence;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #packet_count */
  constraint reasonable_pkt_delay {
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dte_break_cond_sequence)
 
  /** 
   * Constructs the svt_uart_dte_break_cond_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_break_cond_sequence");
        
  /** Execute the svt_uart_dte_break_cond_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_break_cond_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_break_cond_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_break_cond_sequence::new(string name = "svt_uart_dte_break_cond_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_break_cond_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_break_cond_sequence::body();
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
 * @groupname DTE_PKT_GEN
 * This sequence creates scenario which inserts inter cycle delay between packets and also transmits these packets<br/> 
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
class svt_uart_dte_packet_sequence extends svt_uart_dte_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay and #packet_count */
  constraint reasonable_pkt_delay {
    inter_cycle_delay inside {[0:200]}; 
    packet_count inside {[1:200]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dte_packet_sequence)

  /** 
   * Constructs the svt_uart_dte_packet_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_packet_sequence");

  /** Execute the svt_uart_dte_packet_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_packet_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_packet_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_packet_sequence::new(string name = "svt_uart_dte_packet_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_packet_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_packet_sequence::body();
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
 * @groupname DTE_DRV_DTR
 * This sequence creates scenario which drives user provided values on DTR pin and also controls transmission of packets<br/> 
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence by controlling generation of packets using enable_packet_generation with driving user specified values on DSR pin<br/> 
 *   using drive_dtr_signal and dtr_signal_value. Value of packet count is constrained to local_packet_count attribute.
 * . 
 */
class svt_uart_dte_drive_dtr_sequence extends svt_uart_dte_base_sequence;

  /** Packet count */
  rand int packet_count = 10;
  
  /** For Controling the driving of DTR pin */
  rand bit drive_dtr_signal = 1'b0;
  
  /** Specifies the value to be assigned to DTR pin */
  rand bit dtr_signal_value = 1'b1;

  /** Controls generation of packets */
  rand bit enable_packet_generation = 1'b1;

  /** Reasonable constraint for #packet_count */
  constraint reasonable_pkt_cnt {
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dte_drive_dtr_sequence)

  /** 
   * Constructs the svt_uart_dte_drive_dtr_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_drive_dtr_sequence");

  /** Execute the svt_uart_dte_drive_dtr_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_drive_dtr_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_drive_dtr_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_drive_dtr_sequence::new(string name = "svt_uart_dte_drive_dtr_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_drive_dtr_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_drive_dtr_sequence::body();
  bit status;
  int local_packet_count;
  bit local_drive_dtr_signal;
  bit local_dtr_signal_value;
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
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "drive_dtr_signal", drive_dtr_signal);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", drive_dtr_signal, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "dtr_signal_value", dtr_signal_value);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", dtr_signal_value, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "enable_packet_generation", enable_packet_generation);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", enable_packet_generation, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
      status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".drive_dtr_signal"}, drive_dtr_signal);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", drive_dtr_signal, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".dtr_signal_value"}, dtr_signal_value);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", dtr_signal_value, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".enable_packet_generation"}, enable_packet_generation);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", enable_packet_generation, status ? "config DB" : "randomization"));
`endif

      local_packet_count             = this.packet_count;
      local_drive_dtr_signal         = this.drive_dtr_signal;
      local_dtr_signal_value         = this.dtr_signal_value;
      local_enable_packet_generation = this.enable_packet_generation;

      `svt_xvm_create(req)
      start_item(req);
      /** Off reasonable constraints */ 
      req.reasonable_packet_count.constraint_mode(0);
      assert(req.randomize() with {
        /** set number of packets to be sent */
        req.packet_count == local_packet_count;
      });
      req.drive_dtr_signal         = local_drive_dtr_signal;
      req.dtr_signal_value         = local_dtr_signal_value;
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
 * @groupname DTE_BUFF_FLUSH_AND_INTR_CYCLE_DELAY_WITH_PKT_GEN
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
 *   buffer flush delay and inter cycle delay are constrained with local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * .
 */
class svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence extends svt_uart_dte_base_sequence;

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
  `svt_xvm_object_utils(svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence)
   
  /** 
   * Constructs the svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence");
      
  /** Execute the svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence::new(string name = "svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence");
  super.new(name);
endfunction: new 

//---------------------------------------------------------------------------------------------
// svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence::body();
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
 * @groupname DTE_HARDWARE_RTS_DELAY_WITH_PKT_GEN
 * This sequence creates scenario which inserts delay on Request To Send (RTS) signal, inter cycle delay<br/>
 * and also transmits packets, in case of Hardware Handshaking
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured RTS signal and inter cycle delay. Values of packet count,<br/> 
 *   rts delay  and inter cycle delay are constrained to local_packet_count, local_delay_rts and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * 
 * - Set and drive Data Terminal Ready (DSR) signal value. 
 * .
 */
class svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence extends svt_uart_dte_base_sequence;

  /** Inter cycle delay */
  rand int inter_cycle_delay = 200;

  /** request to send delay */
  rand int delay_rts = 200;

  /** Packet count */
  rand int packet_count = 10;

  /** Reasonable constraint for #inter_cycle_delay, #delay_rts and #packet_count */
  constraint reasonable_pkt_rts_delay {
    inter_cycle_delay inside {[0:2000]}; 
    delay_rts inside { [0:2000]}; 
    packet_count inside {[1:2000]};
  }

  /** Factory Registration */
  `svt_xvm_object_utils(svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence)

  /** 
   * Constructs the svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence");

  /** Execute the svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence sequence */
  extern virtual task body();
  
  /** 
   * Determines if this sequence can be executed based on the values
   * supplied by cfg object
   * Return 0 if below condition is satisfied:
   * uart_cfg.handshake_type = svt_uart_configuration::SOFTWARE
   */
  extern virtual function bit is_applicable(svt_configuration cfg);

endclass: svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::new(string name = "svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence");
  super.new(name);
endfunction: new      

//---------------------------------------------------------------------------------------------
// svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::body();
  bit status;
  int local_inter_cycle_delay;
  int local_delay_rts;
  int local_packet_count;
  super.body();

  if(cfg.handshake_type == svt_uart_configuration::SOFTWARE ||  cfg.enable_tx_rx_handshake == 1'b1 ) begin
    `svt_xvm_error("body", {(is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"," is not compatible with software handshake type or enable_tx_rx_handshake configuration"});
  end
  else
    begin
      `svt_xvm_note("body", "Entered ...");

`ifdef SVT_UVM_TECHNOLOGY
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "inter_cycle_delay", inter_cycle_delay);
      `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "delay_rts", delay_rts);
      `svt_xvm_debug("body", $sformatf("delay_rts is %0d as a result of %0s.", delay_rts, status ? "config DB" : "randomization"));
      status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "packet_count", packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`elsif SVT_OVM_TECHNOLOGY
      status = m_sequencer.get_config_int({get_type_name(), ".inter_cycle_delay"}, inter_cycle_delay);
      `svt_xvm_debug("body", $sformatf("inter_cycle_delay is %0d as a result of %0s.", inter_cycle_delay, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".delay_rts"}, delay_rts);
      `svt_xvm_debug("body", $sformatf("delay_rts is %0d as a result of %0s.", delay_rts, status ? "config DB" : "randomization"));
      status = m_sequencer.get_config_int({get_type_name(), ".packet_count"}, packet_count);
      `svt_xvm_debug("body", $sformatf("packet_count is %0d as a result of %0s.", packet_count, status ? "config DB" : "randomization"));
`endif

      local_inter_cycle_delay = this.inter_cycle_delay;
      local_delay_rts         = this.delay_rts;
      local_packet_count      = this.packet_count;

      `svt_xvm_create(req)
      start_item(req);
      /** Off reasonable constraints */ 
      req.reasonable_packet_count.constraint_mode(0);
      req.reasonable_inter_cycle_delay.constraint_mode(0);
      req.reasonable_delay_in_rts_assertion.constraint_mode(0);
      assert(req.randomize() with {
        /** set number of packets to be sent */
        req.packet_count      == local_packet_count;
        /** set rts delay to be sent */
        req.delay_rts         == local_delay_rts;
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
// svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::is_applicable()
//---------------------------------------------------------------------------------------------

function bit svt_uart_dte_hard_handshake_delay_rts_packet_gen_sequence::is_applicable(svt_configuration cfg);
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
// DTE Complex Sequences 
//************************************************************************

/** 
 * @groupname DTE_BUFF_FLUSH_DELAY_WITH_BREAK_COND
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
 *   buffer flush delay and inter cycle delay are constrained to local_packet_count, local_buffer_flush_delay and <br/>
 *   local_inter_cycle_delay attributes respectively.
 * 
 * - Execute sequence to generate break condition. Value of packet count is constrained to local_packet_count.
 * .
 */
class svt_uart_dte_buffer_flush_delay_with_break_sequence extends svt_uart_dte_base_sequence;
 
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
  `svt_xvm_object_utils(svt_uart_dte_buffer_flush_delay_with_break_sequence)

  /** 
   * Constructs the svt_uart_dte_buffer_flush_delay_with_break_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_buffer_flush_delay_with_break_sequence");

  /** Execute the svt_uart_dte_buffer_flush_delay_with_break_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_buffer_flush_delay_with_break_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_buffer_flush_delay_with_break_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_buffer_flush_delay_with_break_sequence::new(string name = "svt_uart_dte_buffer_flush_delay_with_break_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_buffer_flush_delay_with_break_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_buffer_flush_delay_with_break_sequence::body();

  svt_uart_dte_buffer_flush_and_inter_cycle_delay_sequence buffer_seq;
  svt_uart_dte_break_cond_sequence                         break_seq;

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
 * @groupname DTE_INTR_CYCLE_DELAY_WITH_PKT_GEN_AND_BREAK_COND
 * This sequence creates scenario which inserts inter cycle delay and also transmits packets.<br/>
 * 
 * Body of the sequence executes following set of commands<br/>
 * 
 * - Declares its local attributes<br/>
 *
 * - Receives value of local attributes of class from config db and if the values are not set through config db, then<br/>
 *   it takes randomized values.
 * 
 * - Execute sequence to generate packets with configured inter cycle delay. Values of packet count and<br/> 
 *   inter cycle delay are constrained to local_packet_count and local_inter_cycle_delay attributes respectively.
 * 
 * - Execute sequence to generate break condition. Value of packet count is constrained to local_packet_count_second_cmd.
 * .
 */
class svt_uart_dte_inter_cycle_delay_with_break_sequence extends svt_uart_dte_base_sequence;

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
  `svt_xvm_object_utils(svt_uart_dte_inter_cycle_delay_with_break_sequence)

  /** 
   * Constructs the svt_uart_dte_inter_cycle_delay_with_break_sequence sequence 
   * @param name string to name the instance.
   */ 
  extern function new(string name = "svt_uart_dte_inter_cycle_delay_with_break_sequence");

  /** Execute the svt_uart_dte_inter_cycle_delay_with_break_sequence sequence */
  extern virtual task body();

endclass: svt_uart_dte_inter_cycle_delay_with_break_sequence

//---------------------------------------------------------------------------------------------
// svt_uart_dte_inter_cycle_delay_with_break_sequence::new()
//---------------------------------------------------------------------------------------------
function svt_uart_dte_inter_cycle_delay_with_break_sequence::new(string name = "svt_uart_dte_inter_cycle_delay_with_break_sequence");
  super.new(name);
endfunction: new

//---------------------------------------------------------------------------------------------
// svt_uart_dte_inter_cycle_delay_with_break_sequence::body()
//---------------------------------------------------------------------------------------------

task svt_uart_dte_inter_cycle_delay_with_break_sequence::body();

  svt_uart_dte_packet_sequence     pkt_seq;
  svt_uart_dte_break_cond_sequence break_seq;

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

  /** generate packets with inter cycle delay */
  `svt_xvm_create(pkt_seq)
  /** Off reasonable constraints */ 
  pkt_seq.reasonable_pkt_delay.constraint_mode(0);
  `svt_xvm_rand_send_with(pkt_seq,{
    /** set number of packets to be sent */
    pkt_seq.packet_count      == local_packet_count;
    /** set inter cycle delay to be sent */
    pkt_seq.inter_cycle_delay == local_inter_cycle_delay;
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

`protected
DU?+g#I<\B;Pdd/VJfgTMg4\]14f=CLU)>46-8IG<;A-Y=#DfW>#,)9;Y@79,-6E
Z@.>9AQ9W)gD/6dC]=>34DBR\1>bcUXf3LT0YBZU.7eZ0eD@cJ)P;4LO._DOL4]&
5d;=Z<Ob#@a.R3:b6F[R^315>J95SD?VAcZF?&ML__\,O_VHa;40(BQVf(2c8)I4
J/9F=\/f9]E7CMP.T[>fL93D.27;V[:7c<f>-A:/9.2XUUc9_2\00?:E?g?4):L]
N<@NCB07=VB7.$
`endprotected


//---------------------------------------------------------------------------------------------
// svt_uart_dte_base_sequence::pre_body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_base_sequence::pre_body();
  raise_phase_objection();
endtask: pre_body

//---------------------------------------------------------------------------------------------
// svt_uart_dte_base_sequence::body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_base_sequence::body();
  svt_configuration get_cfg;
  `svt_note("body", {"Executing ", (is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"});
  p_sequencer.get_cfg(get_cfg);
  if(!$cast(cfg, get_cfg)) begin
    `svt_xvm_fatal("body", "Failed when attempting to cast svt_uart_configuration");
  end
  if(cfg.uart_if==null) begin
    `svt_xvm_fatal("body", " svt_uart_dte_base_sequence virtual interface handle in received configuration is null");

  end
  $cast(uart_agent,p_sequencer.get_parent());
endtask: body

//---------------------------------------------------------------------------------------------
// svt_uart_dte_base_sequence::post_body()
//---------------------------------------------------------------------------------------------
task svt_uart_dte_base_sequence::post_body();
  drop_phase_objection();
endtask: post_body

//---------------------------------------------------------------------------------------------
// svt_uart_dte_base_sequence::is_applicable()
//---------------------------------------------------------------------------------------------
function bit svt_uart_dte_base_sequence::is_applicable(svt_configuration cfg);
  return 1;
endfunction: is_applicable

`endif // GUARD_UART_DTE_TRANSACTION_SEQUENCE_COLLECTION_SV

