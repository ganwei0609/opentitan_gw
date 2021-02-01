
`ifndef GUARD_SVT_UART_TRANSACTION_SV
`define GUARD_SVT_UART_TRANSACTION_SV

`include "svt_uart_defines.svi"

typedef class svt_uart_transaction_exception_list;

/**
 * This class represents data transaction for UART VIP and used 
 * by the svt_uart_agent.
 * 
 * This class contains attributes of the transaction like packet count,
 * break condition, payload etc, which is used by sequencer to construct
 * the transaction object to be sent as stimulus. 
 * It also provides the timing information 
 * of the transaction , that is, delays to assert RTS/CTS signals and 
 * inter cycle delay between two packets.
 * 
 * This class is also used directly by monitor to construct the response object.
 * Monitor constructs the response object for each packet it samples by
 * updating attributes received_packet[0] and received_parity[0] and write
 * every response object on corresponding analysis ports which can be used by
 * subscribers.
 */
class  svt_uart_transaction extends  `SVT_TRANSACTION_TYPE;

  //****************************************************************************
  // Enumerated Type
  //****************************************************************************
  
  /**
   * Enum to represent data transfer direction
   */
  typedef enum bit
    {
      TX = 1'b0,
      RX = 1'b1
    } direction_enum ;

  /**
   * @grouphdr hardware_handshake Hardware Handshaking attributes
   * This group contains attributes which are relevant for Hardware Handshaking (Out-Band)
   */
  
  /**
   * @grouphdr software_handshake Software Handshaking attributes
   * This group contains attributes which are relevant for Software Handshaking (In-Band)
   */

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Object used to hold exceptions for a transaction */
  svt_uart_transaction_exception_list exception_list = null;

  /** 
   * This is svt_uart_configuration handle which has the current cfg active in the environment 
   */
  svt_uart_configuration cfg = null;
  
  /** 
   * This attribute controls the packet generation by VIP driver.<br/>
   * If this is set to 0, then VIP will not generate any packet on bus.<br/> 
   * This is relevent for both HARDWARE and SOFTWARE handshaking.<br/> 
   * 
   * - 1'b1 : Enables request packet Generation i.e. Driver will generate<br/>
   *          the packet
   * - 1'b0 : Disables request packet Generation i.e. Driver will not generate<br/> 
   *          the packet
   * .
   * Default Value: 1<br/>
   */
  bit enable_packet_generation = 1'b1;
  
  /** 
   * @groupname  software_handshake <br/>
   * 
   * Setting this variable to one tells DCE to transmits the XON pattern <br/> 
   * on the bus on high-priority i.e. DCE holds the transmition of the <br/> 
   * current packets available in the transmitter buffer, to transmit XON <br/> 
   * pattern on bus.
   *
   * Relevent only for SOFTWARE handshaking. Not relevent for agents configured <br/>
   * as DTE.
   * 
   * Default Value: 0 <br/>
   */
  bit send_xon_data_pattern = 1'b0;
  
  /** 
   * @groupname  software_handshake <br/>
   * 
   * Setting this variable to one tells DCE to transmits the XOFF pattern <br/>
   * on the bus on high-priority i.e. DCE holds the transmition of the <br/>
   * current packets available in the transmitter buffer, to transmit XOFF <br/>
   * pattern on bus.
   *
   * Relevent only for SOFTWARE handshaking. Not relevent for agents configured <br/>
   * as DTE.
   * 
   * Default Value: 0 <br/>
   */
  bit send_xoff_data_pattern = 1'b0;
  
  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Controls the driving of DTR pin of the agent configured as DTE. <br/>
   * 
   * Relevent only for HARDWARE handshaking. Not relevent for agents configured <br/>
   * as DCE, as DTR is input pin of DCE.
   * 
   * - 1'b0 : Do not drive the DTR port <br/>
   * - 1'b1 : Drives the DTR pin with the value specified by variable dtr_signal_value<br/> 
   * .
   * 
   * Default Value: 0 <br/>
   */
  bit drive_dtr_signal = 1'b0;
  
  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Controls the driving of DSR pin of the agent configured as DCE. <br/>
   * 
   * Relevent only for HARDWARE handshaking. Not relevent for agents configured <br/>
   * as DTE, as DSR is input pin of DTE.
   * 
   * - 1'b0 : Do not drive the DSR port <br/>
   * - 1'b1 : Drives the DSR pin with the value specified by variable dsr_signal_value<br/> 
   * .
   * 
   * Default Value: 0 <br/>
   */
  bit drive_dsr_signal = 1'b0;
  
  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Specifies the value to be assigned to DTR pin when drive_dtr_signal is set to 1'b1.<br/> 
   * 
   * - Relevent only when Handshaking type is HARDWARE and variable drive_dtr_signal is 1<br/> 
   * - Not relevent for agents configured as DCE<br/> 
   * .
   * 
   * Default Value: 0 <br/>
   */
  bit dtr_signal_value = 1'b0;
  
  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Specifies the value to be assigned to DSR pin when drive_dsr_signal is set to 1'b1.<br/>
   * 
   * - Relevent only when Handshaking type is HARDWARE and variable drive_dsr_signal is 1<br/>
   * - Not relevent for agents configured as DTE<br/>
   * .
   * 
   * Default Value: 0 <br/>
   */
  bit dsr_signal_value = 1'b0;
     
  /** 
   * Controls the break generation by VIP.<br/>
   * 
   * Setting this variable to 1, instruct the VIP to generate break condition<br/> 
   * on bus i.e. Hold the output data pin low for one packet length.<br/> 
   * 
   * If this variable is set to 1 and packet_count is set to 5(say), then VIP<br/> 
   * will generate the break condition 5 packet times.<br/> 
   * 
   * Default Value: 0 <br/>
   */
  bit break_cond = 1'b0;
  
  /** 
   * Stores the packet(s) received from bus.<br/>
   * 
   * Used by the monitor to construct the response object for analysis port(rx_xact_observed_port).</br>
   * Monitor receives one packet at a time from the bus and construct the response object, so in this case
   * only 0th location is valid i.e. received_packet[0].
   * 
   * Used to construct the response object, hence read only for user.
   * 
   * Default Value: 0
   */
  bit [12:0] received_packet[];
  
  /** 
   * Stores the packet(s) transmitted on bus.<br/>
   * 
   * Used by the monitor to construct the response object for analysis port(tx_xact_observed_port).</br> 
   * Monitor receives one packet at a time from the bus and construct the response object, so in this case
   * only 0th location is valid i.e. transmitted_packet[0].
   * 
   * Driver uses this property to observe what sequence is drived on the bus by the sequencer. Driver collects all the
   * packets from the bus as specified by the 'packet_count' property.</br> 
   * In this case size of the array will be equal to 'packet_count' i.e. 'transmitted_packet' will hold the packets for
   * number of packets specified by the packet_count property.
   * 
   * Used to construct the response object, hence read only for user.
   * 
   * Default Value: 0
   */
  bit [12:0] transmitted_packet[];
  
  /** 
   * Stores the parity bit extracted from received packet(s).<br/>
   * 
   * Used by the monitor to construct the response object. Monitor receives
   * one packet at a time from the bus and construct the response object, so in this case
   * only 0th location is valid i.e. received_parity[0].
   * 
   * Driver uses this property to put response back to the sequence. Driver collects all the
   * packets from the bus as specified by the 'packet_count' property and puts the response object
   * back on the sequence. In this case size of the array will be equal to 'packet_count' 
   * i.e. 'received_parity' will hold the parity bits for number of packets specified by the packet_count 
   * property.
   * 
   * Used to construct the response object, hence read only for user.
   * 
   * Default Value: 0
   */
  bit received_parity[];

  /** 
   * Specifies the direction of transmission of data.<br/> 
   * 
   * Used to construct the response object.<br/> 
   * Hence read only for user.
   * 
   * Default Value: TX
   */ 
  direction_enum direction = TX; 

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  
  /** 
   * Specify the number of packets to be transmitted on bus.<br/> 
   * 
   * If this variable is set to 10 (say), then VIP will drive the 10 packets<br/> 
   * on bus. Other attributes settings remains same for all the 10 packets.<br/> 
   * 
   * For reasonable constraint please refer to #reasonable_packet_count
   */
  rand int packet_count = 10   ;
  
  /**
   * Store user data to be driven onto the bus<br/> 
   * 
   * Array size is constraint to the packet_count value i.e. payload<br/> 
   * will hold the data for number of packets specified by packet_count.<br/> 
   * 
   * Width of payload is 9, as maximum data width supported is 9.<br/> 
   * However if data width is set to lower value say 6, then only lower<br/> 
   * 6 bits of payload is used.<br/> 
   * 
   * For valid_range constraint please refer to #valid_range
   */
  rand  bit [8:0] payload[]     ;
  
  /** 
   * Specify the delay between two consecutive packets.<br/>
   * 
   * This delay is with reference to baudX16 clock. Delay is inserted<br/>
   * after the packet transmission.<br/>
   *
   * A single baud clock cycle (1 bit duration) consists of 16 baudX16 cycles,
   * so the value of delay must be provided im multiples of 16.
   * Ex : To insert an inter-cycle delay of 1 baud clock, the value provided
   * must be 16. Similarly, to insert a delay of 2 baud clocks, the value
   * provided will be 32.
   * If the value provided is in between 16 and 31, the value of delay inserted
   * will be 1.
   * 
   * For reasonable constraint please refer to #reasonable_inter_cycle_delay
   */
  rand  int inter_cycle_delay = 200;
  
  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Specify the delay to assert rts pin.<br/>
   * 
   * This delay is with reference to baudX16 clock. Delay insertion is started<br/>
   * when condition to assert RTS pin is detected.<br/>
   * Configuration of delay_rts is not valid when enable_tx_rx_handshake is 1. 
   * 
   * For reasonable constraint please refer to #reasonable_delay_in_rts_assertion
   */
  rand  int delay_rts = 200;

  /** 
   * @groupname  hardware_handshake <br/>
   * 
   * Specify the delay to assert cts pin.<br/>
   * 
   * This delay is with reference to baudX16 clock. Delay insertion is started<br/>
   * when condition to assert CTS pin is detected.<br/>
   * Configuration of delay_cts is not valid when enable_tx_rx_handshake is 1.
   * 
   * For reasonable constraint please refer to #reasonable_delay_in_cts_assertion
   */
  rand  int delay_cts = 200;
  
  /** 
   * Specify the delay to flush the receiver buffer (FIFO) when buffer gets full.<br/>
   * 
   * This delay is with reference to baudX16 clock.<br/>
   * 
   * For reasonable constraint please refer to #reasonable_delay_to_flush_buffer
   */
  rand  int buffer_flush_delay = 200   ;

  /**
   * Temporary variable used to hold onto the XML writer currently being used for XML generation.
   * Only valid within call to save_prop_vals_to_xml().
   */
   svt_xml_writer active_writer = null;

  /** 
   * valid_ranges constraints prevent illegal and/or not supported by the 
   * Protocol & VIP.
   * These should ONLY be disabled if the parameters covered by them are 
   * turned off. If these are turned off without the constraints being 
   * turned off it can lead to problems during randomization. </br>
   * In situations involving extended classes, issues with name conflicts
   * can arise. If the extended (e.g., cust_svt_uart_transaction) 
   * and base (e.g., svt_uart_transaction) classes both use the same 
   * valid_ranges’ constraint name, then the ‘valid_ranges’ constraint 
   * in the extended class (e.g., cust_svt_uart_transaction), will 
   * override the ‘valid_ranges’ constraint in the base class (e.g., 
   * svt_uart_transaction). Because the valid_ranges constraints 
   * must be retained most of the time, classes extensions should prefix
   * the name of the constraint block to ensure uniqueness, e.g. 
   * “cust_valid_ranges”.
   */
  constraint valid_ranges {
    solve packet_count before payload;
    packet_count  inside {[1:2000]};
    payload.size()==   packet_count;
    inter_cycle_delay  inside {[0:2000]};
    delay_cts          inside {[0:2000]};
    delay_rts          inside {[0:2000]};
    buffer_flush_delay inside {[0:2000]};

    (cfg.handshake_type == svt_uart_configuration::SOFTWARE) -> foreach(payload[i]) {
      (cfg.data_width == svt_uart_configuration::FIVE_BIT)  -> payload[i][4:0] != cfg.data_pattern_xon[4:0];
      (cfg.data_width == svt_uart_configuration::FIVE_BIT)  -> payload[i][4:0] != cfg.data_pattern_xoff[4:0];
      (cfg.data_width == svt_uart_configuration::SIX_BIT)   -> payload[i][5:0] != cfg.data_pattern_xon[5:0];
      (cfg.data_width == svt_uart_configuration::SIX_BIT)   -> payload[i][5:0] != cfg.data_pattern_xoff[5:0];
      (cfg.data_width == svt_uart_configuration::SEVEN_BIT) -> payload[i][6:0] != cfg.data_pattern_xon[6:0];
      (cfg.data_width == svt_uart_configuration::SEVEN_BIT) -> payload[i][6:0] != cfg.data_pattern_xoff[6:0];
      (cfg.data_width == svt_uart_configuration::EIGHT_BIT) -> payload[i][7:0] != cfg.data_pattern_xon[7:0];
      (cfg.data_width == svt_uart_configuration::EIGHT_BIT) -> payload[i][7:0] != cfg.data_pattern_xoff[7:0];
      (cfg.data_width == svt_uart_configuration::NINE_BIT)  -> payload[i][8:0] != cfg.data_pattern_xon[8:0];
      (cfg.data_width == svt_uart_configuration::NINE_BIT)  -> payload[i][8:0] != cfg.data_pattern_xoff[8:0];
    }
    
  }

  /** 
   * Reasonable constraint for #inter_cycle_delay                       
   *								                      
   * This constraint is ON by default; reasonable constraints can be enabled/disabled 
   * as a block via the #reasonable_constraint_mode method.                           
   *                                                                                  
   * To see the reasonable constraint code, use the link to the line number below.    
   */
  constraint reasonable_inter_cycle_delay {
    inter_cycle_delay     inside {[0:200]}; 
  } 

  /**
   * Reasonable constraint for #delay_rts                       
   *                         
   * This constraint is ON by default; reasonable constraints can be enabled/disabled 
   * as a block via the #reasonable_constraint_mode method.                           
   *                                                                                  
   * To see the reasonable constraint code, use the link to the line number below.    
   */
  constraint reasonable_delay_in_rts_assertion {
    delay_rts  inside { [0:200]}; 
  } 

  /**
   * Reasonable constraint for #delay_cts                       
   *                      
   * This constraint is ON by default; reasonable constraints can be enabled/disabled 
   * as a block via the #reasonable_constraint_mode method.                           
   *                                                                                  
   * To see the reasonable constraint code, use the link to the line number below.    
   */
  constraint reasonable_delay_in_cts_assertion {
    delay_cts  inside { [0:200]}; 
  } 
     
  /**
   * Reasonable constraint for #buffer_flush_delay                       
   *                      
   * This constraint is ON by default; reasonable constraints can be enabled/disabled 
   * as a block via the #reasonable_constraint_mode method.                           
   *                                                                                  
   * To see the reasonable constraint code, use the link to the line number below.    
   */
  constraint reasonable_delay_to_flush_buffer {
    buffer_flush_delay  inside { [0: 1000]}; 
  } 

  /** 
   * Reasonable constraint for #packet_count                       
   *                      
   * This constraint is ON by default; reasonable constraints can be enabled/disabled 
   * as a block via the #reasonable_constraint_mode method.                           
   *                                                                                  
   * To see the reasonable constraint code, use the link to the line number below.    
   */
  constraint reasonable_packet_count {
    packet_count inside {[1:30]};
  }

  // **********************************************************************************************
  //   SVT shorthand macros 
  // **********************************************************************************************
  `svt_data_member_begin(svt_uart_transaction)
    `svt_field_int (packet_count             , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_array_int (payload            , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_object(exception_list         , `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOMPARE|`SVT_UVM_NOPACK,  `SVT_HOW_DEEP)
    `svt_field_object(cfg                    , `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NORECORD|`SVT_NOPRINT,`SVT_HOW_REFCOPY)
    `svt_field_int (inter_cycle_delay        , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (delay_rts                , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (delay_cts                , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (buffer_flush_delay       , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (enable_packet_generation , `SVT_ALL_ON|`SVT_DEC|`SVT_NOPRINT)
    `svt_field_int (send_xoff_data_pattern   , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (send_xon_data_pattern    , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (drive_dtr_signal         , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (drive_dsr_signal         , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (dtr_signal_value         , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (dsr_signal_value         , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int (break_cond               , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_array_int (received_packet    , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_array_int (transmitted_packet , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_array_int (received_parity    , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_enum(direction_enum,direction , `SVT_ALL_ON)
  `svt_data_member_end(svt_uart_transaction)

  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_uart_transaction");

  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  /**
   * Extend the UVM/OVM copy routine to cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer Policy object for doing comparison
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);

  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
	 
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. Only supported
   * kind value is `SVT_TRANSACTION_BASE_TYPE::COMPLETE, which results in verification that the non-static
   * data members are all valid. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
   * The pre_randomize function is used to fetch cfg handle from the sequencer
   */
  extern function void pre_randomize();

 /**
   * This method writes the property values to the indicated XML/FSDB format.
   * This method relies on the allocate_xml_pattern() method to obtain the
   * pattern for the property values to be saved. Therefore the preferred mechanism
   * for altering the format is to overload the allocate_xml_pattern() to define
   * a different pattern.
   *
   * @param writer Object which takes care of the basic write operations.
   * @param object_block_desc String that is placed in the 'object' block created for
   * the data object. If not specified method relies on get_pa_obj_data() method
   * to get 'svt_pa_object_data' which will contain the object header information.
   * @param prefix String to be placed at the beginning of each line in the file.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit save_prop_vals_to_xml(svt_xml_writer writer, string object_block_desc = "", string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object begin information in to indicated XML/FSDB file.
   * This method relies on the 'get_pa_obj_data()'method to obtain the
   * object information. Therefore the preferred mechanism for altering the format is to 
   * overload the get_pa_obj_data() to change default object begin information.
   *
   * @param writer Object which takes care of the basic write operations.
   * 
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit save_object_begin(svt_xml_writer writer);

 // ---------------------------------------------------------------------------
  /**
   * This method writes the property values to the indicated file using the XML
   * format. This method relies on the allocate_xml_pattern() method to obtain the
   * pattern for the property values to be saved. Therefore the preferred mechanism
   * for altering the format is to overload the allocate_xml_pattern() to define
   * a different pattern.
   *
   * @param writer Object which takes care of the basic write operations.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit save_object_data(svt_xml_writer writer, string prefix = "");

 // ---------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */ 

  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "",
                                                             string parent_uid = "", string channel = "");

   // ---------------------------------------------------------------------------
  /**
   * This method can be used to obtain a unique identifier for a data object.
   *
   * @return Unique identifier for the object.
   */
  extern virtual function string get_uid();

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is normally set to the corresponding field name, the svt_pattern_data::value
   * is normally set to 0. For fields which are displayed but not owned, the
   * method puts the current value in for svt_pattern_data::value.
   *
   * @return An svt_pattern instance containing entries for all of the fields
   * required for XML output of the data object.
   */
  extern virtual function svt_pattern allocate_xml_pattern();

endclass : svt_uart_transaction

`protected
]f<:Ta3M9&\E)DC+O31VOU;O1KV1@D_gYFP/[HfB6/gH2aaMdKc?&)OP3_YY7NE+
XBWfF4gcb;e<aKE1EdgF7>&W3,O/R/W5JZ)3I.5#NSd<VI>2RSHJ5PI8/f:T@HNV
4=&7/,H,cJDe0(BWKUV0YZG=^QSPYQQ<bBM@P3ag3<K^8Hc)8/3__?NFR@[8M3,M
WS-9CMdO3>-UZ89R-.>84F[S7Da_6_Z1fH;R2:E4-/HQ>R#QQ?7?\;cY_W:6JGdUS$
`endprotected


//vcs_vip_protect 
`protected
ed:ZS9B9W5C8:BB5&]I6&81M8>IXYL=>.54/eeXL?)T&1e1-=g;]0(f:L^Z[B-)b
:-Ce8XV]+;9JPN)L\LPeT3DBQ_W6V@AOPCC#bS.</1_U>_WI<935A\6WdaV?\UJ&
aLL4BWQ;QVS5Z3g^M1Kc^MB=),dER=&OX#eLWa7M+N8c,IAYXg3LU_ILPZZ-LKfE
X5WZAV(:+(/IS-;JQZZK(TBY\&>[@HZgN:9.E4P<a33e3MH4(UCL<^&2Hg^++?ID
Q1PQ7G9N_VXf^+ETP/676BdE+0bLO?+Jgf,&[;,Tc91;70GI5RB[RV=+Q_A)_/f#
^(.F_US&QHI=WL,58;<Q8c2dXW8f5DL;g83R0WN6FDL:8(YYT62?7<#L-b;STc\,
>505g-ES4&5af/b&D,7?S8b9[]CbZb+CcUa4IO,PGGVQET1E)8_6^a74?R?G/,\e
-3#ZJ/NHC=c-dR#?BdD9HSA&>@=7;])cK[;D_8a-[.58U91LRYHc/>VDa/,RC7?X
F[bNQJZMJ:IW8#X2Wf9JV/#>]cV/;>R49&T=;JFO(<MVSV[Df\6<6-g,O&=@fb?5
#fO2,_K=09Z?BT-B_5=B+PXI;?&;Y](,+gg&A4KFP3@5?MVdI\F&bF7&C?,)5YgX
/);@JL\,;P0[C^8F]SUS@K(=fT[/(D0]<VgYC<0T^\T#VOUf\FTId0&AXJ1QDcN2
&1IdFZg(fJ#+/5J8[73UH@X(\Z66?73B4=fUdaNW:^=f^P62F#BY(&KMW6K#RF-X
<>4?U.e&N7POPK]6SbcI55D.XUNP<2YbZI-4:4,dLBdF9-H>71URWb_Y1L>(#Q1X
6-d,]P-;2TC0[M.:2@Ba7Zc/O+;FaHd1\4TdE7DBb.Z2B[G4R69&gcae=W1K@R9[
d40gAE+Of)S5+@2KV;[Y</72&11_9K1C-;,MKFCZ88,b4C0QgG^1_?=B?K9HR(Vg
[e[a-g0]J&6+SQ[N0ABI\+g#GHGa-K,&DcB7+cLE0VN&f9@B2bJ3@a4KS@RS&/F/
[7+O=7.9TM59D6]^V96I.-5Q3E2/ZEN617d]_OD#FQNb#<#:JPEGAEK4#Zd,/N&6
BeZL9DFIAW&5f7;S<&?_7Qg5>3,:)0Q[ZJSe#[V?8EWY@c.>Xc.e5:.,1OPeX[Q>
X:/.G=]0E&^I9#/(K+(7@5;Xf6aQ)5.)dQO#IcTQ<E+998Q&8Lbe[7dPM=EA.cLW
X82CF#AKG;fbR?NZA@-YUGDdZ8KFX.=2.V0Ic0bNae.2K:NSRL,@)SF1W39M;-K7
LP<Z&3YQ>#WXRMGOQ=9Y3,<Y@bd92HPO5]Tc8g_>3E8T++7\:BBDM8R&20@@:NdQ
TGNP6g6QVc3GY1@LW+Ke6fceMW:c>;fg)\c8P?#dZYBBQEY0Q0^GdJN^GZ0V/W@[
QK[W/+-^g1Qb=9J&.2?fH4<6(VU[MO_:QURaJ-.-_V&9POPFB;ISg#1BJa58>S4-
Af&=F?1aE>^Z2\L8DS/IT^L@0dN&\ZU_1M]OFJ,;:>.gLQZ.SPQRA6[3f^/HFD\^
Q=LO:QG/Ge44DU)/]@1:9L:Kg[E^Pd\/9O,PD,?K#2H65V[7&W]:0dUUFQ#G<DDO
XY71]8bfYM(LJC]]6F<2889OKDJW.[EM^g+0VEM2[Z:7TNZ:,3:[Ka-@)]FEI(a>
DX^.^FY,,a1]U,OV3bMbJXgI\8BDa[.A\)I0gT5\A,VB5&HWd-1Z\0T5^Y^882?X
BWFBAFMEe,2Iba^62Be<6[#7AaN4fD7aHS3Q:L0BCJZ\c#EOLKK^_@A5+QH;)d7_
Y4:d8cDD=]&2X?R,8__2cD564DKJ/X<gJ_QL]A<T.->U5X.L.[>b_H=<B@[I]MeJ
<F/)0<;TK_#DQ950D3GOD23_-1Be3._(/LM[F,1cCWAQQ..<_<-T\GM-GPRb9W4Y
O36ON+T&6,dU;_d_X@D8R9]>P)_B>DO8>&A>c=?.gdIE)-3E#0:+E^RD)S??&5e<
\WWQCg].aH=^bNNJ\.,ddc7-DJ]eJ<NS.P#7<.#=D;/TM_/fQ1[5:QgWL=cab9S.
cMA37ZOH+M@Qfce9MUf9BEcXR?3P:^<NE:gde93KKFg0U8AU&S7T<)E[/;C?4H36
TP36DTaAVZKMfg[P-9H;@;OQJ9.+>#]ZYEY?];XbU1F=T45:W97V>U9M_T.JcU9L
=;;fG2egK8O.#X^H66/&;4P=6:1.<,4+JVUX?Kc&M[/7AMAN(_Dg)9e>[X:M1[4#
gV.H-P[I?8<S_&+4#Mb4,fcef#V48MN8B[VI,N1;2[N4X[AKDX835&g-S>Q57S1Q
-f\KWM7?Ke](]A]C-@MW0=D,6:;@.R&FYbXE/D-<SfZbHMRNEW3N4PENJ2e23d6X
8[Bc#R6NfID[43#7eb6#DU1Tg_SaK1ZB)B@_Uc,;G\AMUVB&UO2&,^4[Z@AMI8&I
70MGe1].I@6Q1ZESVf20OHZ&2_@54)OUI]?23I9UE.f3cg2\NG&SZSE><1e1QM43
ZHL+OO^QH>5?;Oe(J;a)1_VP@-?Y3P1H>?SDK2/@4_&fG[8cT8ZfS]^<7dZZeVB@
R,VUOR&\671WHU=T@?+E+2L;^NZVef(-H([X21Ga9^CQ8@&4He.V+aM/HLcVeW^-
#D]+1?S>P^>08d7<,9L2#9Fc?V_H..B<K:X.ag)KO+aLefFV2SeeNSL?L^(ef-8[
PE)ITg>bDeT.1-c9?0g1-fdPKR[WK^?L&PIO62bFUGJMM(SG=AFb,2[F\=8KW350
JUg(Q>\E<8QQAHSC3(UWcEUce&PMFZ?)YfVJZfb9Vc9]BEcRCGK6X,e<\dF0Ja8+
\1Y-0U,O_X3?_6f?)f7^06-GH5I,5R23B-?@/GC>SfW;D;eP6aM<E2QH->]3HW#A
UeKVNDZI7<AIb3X;_8Ve@CSXDB7<.D>I@+S9UB\ceV5EJ:-#.;8Z;ILS&\d4E#,J
@SD+U3bX40#^F78Z;Z0<P(]Z9?R>M-,2T6]J(MdMVdU+.JAR(+SBfMeZT.?f?Gg=
K:ef7=\9N2^P(:QK\B)27(Y5R\MLU3FF?g#==VIGH1+&9+\P]eHI/d&G.Z96Y--M
PIP6d9adX9S?9]&f5DC8R4a#X8,I7SGS1>94-=f0dJa/9:_#]0R3#Ja&B7@IX)?L
L#:3ScCX0f,W&WdQARPP[\CdJc0VUc60>1GQ64(U-Q3W5V-0UCU=OY>ce[_4?eM^
AeaT(1>7g#X/L)P4<0Ue#Z[96A&Md0.5@6Ig_37/Rg\YN]QaRd08+X=>3.X@CTc@
b/#bH36I_-CN+U&?33a[SbdO1@-KDW0U>0fO4:,?Z@DGG-E60H04V=J\L7._2Ra[
(7?]EX5])2;.+S,N(<+RUJEA-O35\OX]EgHYF(BDY;NbPQ_2Kg;:&6E;;J=5gNQ2
+\##\BODJ0;AJA6+P(\XYg<(WJY->JRg==c4\AaSJW1?aRQ]JMV<5_&D>=(29(@P
GZRTT\WEc-7,NIY_Xc#D:^H^&>UPOHFS_e&6IKFW5]X]?E;Ed_IUYBG24)7aQQPb
BAGOYB0LJJ#S@37TQbW>_a3+3^C86@OM[JK52g-cFQebRS_M0Z)-6LS-BfVV^LJg
IV9U\@3a10M1\#E1;L#;,K;-P<_0&UJNM^4QRZYSBaTB,.[D\R7?+C0aMSfY+VQ(
gEYA4SBgX-g^Y(f(1+T;EL/e+1B3a8cKeV<+3C_gY+7&/&^4fC9@aUVE0@+IE\f.
8R7FE2<GId]M&6Q6E_<e58gINTBbdb-:P21SHH;]]Q#g7R.#4-J;<::N,;Y:.S71
O=KYe=)2GX\;Qd+RB0S5;]JgHcI6Ue>\;92\KH&Da&3GYEYROZ+J\b&RV#Q_#?)4
_:U4)/1/L.T9#68<_4E?9KB:U)BDD^Z\I4TWe\I?cDA[4_I83C,[9RNZ3MT[WaM=
NWT;bHb;d]3OK:3VXTNI<VVLL=A=[@&b^TF&WRVVEUZ21WC1gCPZ@)V0BN79CI9\
c8]0J/]CNI&/bV@[X]#?RX\I)#.M3_&F7YS>^F[F[L6-_/?-5Ad[b;ULQ@(.V?f]
&S^UI255R)Oa<N>KU,#[5&B5TDM#IH=6,d38R)<B<:[5J^N6-KS):8KF>H=/EZO:
B5Na3V?0FdOEOE0J5;OD+=9f9LZN.a2HI6:f02EbM2M^#83LW6=,YJ^QL/7+2V[E
=BA_WJ_Ye;O<:b2a+Dd;<),S;,=5e4N?>3<#J.:=_#54C],[47WfEM1d#6cWQYMW
N^J_9WDLBV_(O/VCRF(U-S9G1+UHX2a-00JRNQ_CMU=aL803>9(3HJC]:TSaI78.
4W))g&+8+5?);./)BJ0F)<fTTT3Q60V\Id2e:O:F[WJF]QaG/2COH?AMPQ2=,Z4+
0Rf+FF>[bP/ZdFN1NK#E9^Y#&>>U/Z9-dDVEf)<?ZOM6c^@4M#U#e6^F=KMJ.)II
Q7V0RHUY<D:)_76^GOI_;[LSMbcO^??gC,<DCF0SW/+eSDd/ZB>;dF@d,(c:K#YA
O+@,G).6Kb2:-+-[K/Y7@L<Yd2Eb[;Ya_^K+S0cGFbWg+Y&,BAJEafW_LNdQZc:\
-KS.Y:bc0gdQ683d\U&@UHaZK-UDH-2ZEKbC/K0&-)4c75ZGVF#M]4]d,L=eaQEB
P0g,>^&WXW4:#HF0)dE[;<+4>N]9M?aNH3<Zeb)8WAW2b0Z.T\B7SLZ#Q_8R1A<,
)G.(R_^=a5C3ZGM],\M-0&.SP@14H;G]fd-6gD:V/FD)R449=^I4VS_A^=:7f(UN
IQUAW->]F6FcH0GL72)TVT;@DB#N\Q4a?/JC&U+RL=WGS6[W?>_O40@f:e6T7g_J
EH;PSHSG3]cX#@-6e..A--aGe36]^G>EVY0CM8GH:[\XTd9Y3?6JD]EFYH.>OZXV
H[5=#3Y-3U.YJ1N75c2A47T;;[R-KMG2;97U\J\?DAJIC81M@^&ET70[2U:FVC(A
g/]Vad,[X#[g6SHeWS+.;SY^UD]4/CcU8(VfT(EB:T^R\TS)>TM_c,<(cXf2-UZA
aO4]fS\R?+)<,XG^/>faKfUgTCGZ^:,FNK#cT,?+QD+N.[N+&,b_-2^WUPPg:](8
?KHaD8RB)-H1UcL0AOJe;W_#B[YP7WJe&8D(V:D)()7I<1b^GJVdA1^TO(N>-51V
f8DL(C-A0(#E^&CU6J[M?E]S@#d/RSJC][G/V12T=[f]1cfPL\,K.PZ0&Q+PGU,?
H#O3,NY(a3:\I,D>GQ:3Ze1W6XB#0N_F8BLN=8V51QFc4dDAXgXJ;=:3AZCabI/:
P_67-<J4aKVB4G-:SEJId96CQN29+9N4=BDTKgRZeF2QGY@T16,V74[<G-C^^7]C
>9bg#gY2e-bS\L67]-MTB+9\5:>?G4/103VP,#-(C&-)I5E-_#;.-FHed4?^,HZ=
HW5D@FD^SQ_V2/JfQ,VO-MLM@:&/\#<-W=0D)PgV=J\++aB_&SA#?a&Y-K7SA]L1
,M7D[9<&UHaWCU8]V[058Zfe&R\KTK0647K:QET#EgQdKJO:\8XXb_I17=R@CPIf
TCbKaeMcA9BOC@[fK#=84^3B^8\GMFJFUHA_BL9bVf\^3)O(=KJ7O\SP>PY]ggRZ
dX#DGVZ[@MG)5V-@XSbF\?HOULL?5X@5[9\dI\>?JM)_;1H88-N&QcNe0S[Y29JH
YZMCSf>2\.+^LPBB0IWZ:/CEZAN5QY/[;PacPc_(GDVQPA([DZGA]_(F@d].<XMT
:2+13<9.M(2=Q0S?Q_OQ2Xd.GK>=4TQ6OF@dbN\9YM-2fM9Y>9eOZZAdNPJPX3[b
)6>W=W5:2#FVQ;g3\b7#.d^]]3FB?].,[_R3^AF>2PTSfJDJ>/gIZ,Nc;505(#Of
AM1P7@U7G>&,CPc6\NfM)]S028UM&c\\X_AZP7&HK4B)5-EKR,P6CQNFCG[5XP6[
37M6I4b&Hb;bLRFN&3(B.W)S?NQ_9,=11QVKXCR^\eU-a_<<E.3fe^I0\3e,0CPO
gI>Y8OB-ORaK/dNZ55)e>A&Egc1]Q/J3-dL;0HAa5B6aY_JI))a2&O#aNM_../eP
UT3cFJM\UNPM^NU.O:7H6:9a:JR697^SP/,HO)0L?W>g^X]>bZWHg:9VFd8U3.SY
G@4b]Q7J.3?VI,WFJ(b2@gX9[OWeD8=I^M:fSG7=6\9)F:AJd<4NM&PR37KKP=3d
.BgP,DB[-@Tf7&Rd0PEaFLQZIIS.aK>(JFJ&O_0725;:Qa<K@@J>F[+DIPJRHXb,
+;9I4,fT#:a/9K2XM,R#c7L<(R:](J:@+a;9DSNC5]M8._;SA7fbT\g22D3L&BCO
bS2B=#1]Xb,HX>_0OF2QdN)Ug\4c;.BO9-XDfK^aWFTK/VO0GW.4)EFUA7:e&5U[
5;U6\5@JIZ:fL:SGYDAe14ZRE:gIOL^8aI<cX:ZWe8B6C_HS^V@1Zd^gZ6ZI=:6?
5Xb<fY//F_QVI.T);J8aEY(O;D@76Z^QRPVaHdg&7MK?_?<,--c7:;e],W^[1KNY
W0MW4a:_Va_\8e]]5aE:F72a[RS><?8\62dS3Q:NACUL)G.OK5VNFFa4)S00C#_3
J1DE-@RdJC6?QY)ERXX4(R^76G/+c(9TLYR5]N6FNZg.Y?].F2T8QFN-GX:?5P5P
gMYWWGO7]44N2[R#(@AZGVWc1HJY=b034SA9L82XR4b;K9+=B;LX_cUXGOV[5_VJ
(fb1M.))O8+B4fK<+Q.SEb^\)&+UXHT57JZCX;)-C:fD-=IbW@97]Eb/;.e^C(R-
cX0\)5#(Bc@@bGM6?Q>,RQ;TeTQWaM]Q(H62g7ONb8cM#)?7V?2@.PI3-ZMdUNUL
^X<)MEfM(3([K#]ADQ)/c^37C.^BY.Hae6dJE.K^BY?N)9=dB]SL,PI8WY(BF=6G
@FM?#277SVD5X2B;=\UTV3BCa26-T-8bXWZT#J74?)-AUJRTJ50S=.FF,KH<Wg_E
C4fa1da)]FBeZ#>UO2X69fM_#efR6;1[9bWDYA1Zg2]7(gOHQg&,:O<c[-1:P:L2
W85S#9II?FWD9aM^Fb9_a7)<Q62b]R,e5bZOK#8@Pg@VO3^e]cA8W-MZ[^?\AU@3
60E&P.#a2>B,-PI#-HU7BC/Nc@&BO+2/_K^RcQ,c;^dA3-IYOR6LaB<FI9KF)@.H
2g3_C9B(1^ZIc4T(^BgIOY-AMDea]/b^?;Oa&WP\3,TM7+/OQO.bgQd#bEWXI+@M
452I;VWX_X/1H@b0T.e5(-AH][M9Oe5bYWW&B&QU?#(#IO0)((fVRAf2LYXYFK3;
+H:-J[eV5BfEIL4cR>(/g+C9#bIaEJL7c9M?_/V-/QQRf(X@@df_[GcT<9F)L-HH
E]a?KUU0C&H&#I=V.;OgKWc&N0YR]4;UWIEY(EL<af2[>+G)U;;O@4]IWC37U\ST
NIFYP;]A=9cG<M89<Y75D(_)b-Y-88#QO5cOHcUe-JdAT48^KH4daV\J]\M3bb&D
GM)#:99<]GFOCB@dc).8AYeW,CBML,E4Kf;=MW@V3T+4UKd2X@&<<I?G[GHeG377
e.C)DbHJJH;=U3B&5-#RN7WJX3bB?=2#3=2<G8Y)92MP4V>V<g;(NAG&^V)N[\><
F(=3B/#)X:J)F]D)JNY<//cNKMQU)<0Pd20,UH)\P,Ta:9/b.PAIUFcN+K_a]E\F
\7/4J@<3A\de1#YJHJQ50b)M=I30cFE]/5:bEP5D<EXBReO)e3OQR6fcf7KDDQgd
@a82NbdP<5.H6BG>X8I6)465:<DDa,->C>;5S/6NS47V:JHe2I0H:[PYeEBB2ReR
dF?YSY)R_RY^IL\4]&;fH^OP?(>8V;2:Z6E>QA\Ydc:5@GD36G/2GP_HU+-fBU?2
0YT;W_?NYFYJJdSVad?4<M26[[WTRYdW3JG-75de@ac>;#JT[7Z)X0Ccbf9e;;A#
g?5MaM+10UU?@SSeCJb05M<]fA==6R5563T7#3gV]Ye/0+#_V4+F\Z0_BDd8#3A0
25R0@5J^fYXcaA4I>W^aX+3.L-e[J^(C[cG,N#Q>V256Oe;gad#d-[?K@eOB:-.@
B-?G5MScA3FQUE3Q&-aQ4A)3HI4<1_<W@Z07Ua\M,OGE_/NPNMIJ9aE2^0S/J&_\
cV,3)CF^>0,B#OH_c@Q#cJ#UeZ&;)[,LcR?(COT\cXa:aC(2#Q1_DNX+@.-0/aYf
\fLZ1#(a7[gb-#f3C-H=IObKI)KPC3PSUYDfG&K2U=T=^YS?J^=\A^S^84,^d=RX
KbH@[@8&,8G9FeOHJ3>KdEBd+AXL]\DCZ@B4=X?J66JERPU:<Rc:EVL,P46FP_7P
LdUUPRPG7gR0TFB^\F=]^@A992,,-=aV.cKX\VKZB[J<_N+=9UE):RF6[^X&fA69
5f?PC(56LENadM9^^6DcX_541V_.5R-]NUY:C\A<V^WZ#N5THW3@7f(TUPD<2V+e
-/N2KSc9GAR9F50C##063Bf[\E07#<)4EV9#-d(_NLFRdNZaM.J#5CTLa)1F)2=?
JF[YSY6+f(ZV2@1-IG9E[\KU@0(?6c,R&C8=8^d<>]:O.KCY.#MYOZ:SSQUEA,EB
QH@&4BU)U9G\BC6g?bVE>TfLGB:G^L6MOZ.^VZ-b5&D;@L+>Z2Sa97gU7W&/-276
\Jd9.4-M6[gHKEbM1-KEWNGXb0WEO<Qc6O&?WUd8P-?f)805LOHc^S=[+1OUAYNJ
G?RcZEKEge(N6;f&#IeG=^<:eHGaQVU4_3<aT;I#3E[\A;7=+_Wd>9fb7gUP2aWR
T4<TRRN,Y-[+3[2DY7(1SMVaA-M;<E/5dHd0Y9ONGP7_R30g&b#[EZe?EFM#QY,T
HMg6Tc]WSGZ(\\gKPT3gSQ9M;:e9D;KZ^d(=M_U?fA<@@-]8NFI3&EE>V)B<,N^[
\L#]7>g/a+EM.:>]aOfCgOg3Y+TU55[3P(Q/_GJRW5eUKYAEMD-@GV5&BLGEg<D.
:&ZE33\YUN<fASQO--;:SaV7=4]bgdY&6X9NHPVUU[3-_?[NW2Rf.bH8)OU8N#7,
K/6V(S-(SceI8g8RI6[88T[HVg_0Q\aN.JDDb5Z_^)>Z\YJ:a74S.9c9cdT4/DR7
6:UMXgGWacdD&4&.[@LNKF=LI;R.0&Y:K56;-1/de>HJg+2#:QA[67aZ)&HK4Z:d
410WL+gT4<UM5@25TEb[MKOZGRCE.O=X@2K[IXc:<B^E(F[;DBB/,Se\WX5_PI^-
+8b^,c&X4@]?1Na?O^I>LYJB[N.@(<e4eK8#49DB.KE@GVLd(;2J)F7_W(&@-8gd
.PPO0aP6aaOE[)2E_N3fFDO6JWT.;#bD-g#5MN6@a^A_]&<W+14(XX(:5B^SeI5>
6E^ERB.(acM6X_Q1E1F44G(g[]M3;;94H(g4F&O+DW=1Me+].P2V@?B_.S&WMN>>
8f-1D\QCG;]e>g[,VdEX=DLAd:)=[Y4DLOKIGI\MOQ:QR\UcCf-8,@,TC=FeebA8
X8cM&ARC6ZH^DD=M&<92\<48d>5C9_X1QO<<V0#R#G1+JK?VOWW+VAcDN=7)D=f-
REMLVBdUP;0:Q/YT,\J?^.3XP[@>6+M#R4NDD/@82JI.X^^Bf/EL2SB;@C?DGRcK
IXLb,bcB+JHP1RYA8UL?=^SfXJ=fGKI@?K\;BeJ9@9DfHY91@9<cP1g25H.Q3Nd@
_<GOU,AC/g/=PfC&&;Zfcc/_H5]UJCNT30=;:?-,70@&(.W0-FaJb?G,0e:4@(A/
.:WQAS(F8^(Z)7.0:X3T4#/6fJ60<YeT]S]],dgfUeX9d-7N/S8[a6N[IC?bcZ##
.]8&_Jc\[;)?ObQN7TJC[)3F3JIQZ2PU,^)Jcc=<_PJ_eOEM27R8#)M(3GXBQ.:I
5d9X0MXZISec&KAR<J53gMUYg@W\Bd[O=H>I(Z;dIG^7d>:+P&]]Z,:+G43Q3]G^
LKQ#aQ./W&J\=/0:^Q+bMc3@LBNDg\V:W4=67Y=4)):E#c&K&&I]2EH5]B\D3aY&
ff?2:LLfP?IEO_eZBMP88XX883TWH+dX(TfUgIHca_5d7@AUb&RK-/V]Oe[T26..
WH24Aa47N<GbZ4G0UD:A&WUHOd2A/]9LV<,S0,.JY:8<#2XI6[DS8+-C1UMMCOeY
E_KZ@&,@\?\.gI8\WeDc;cTTG2_1,LJE@PIc((2NN<BZ^>O-3U@Y@-WZGf07TX+V
Y?+7YYU1_&X[^EPBF=,f6HfG)_cb4eD^B;XV^45OLca7SS_2A>DCPU\J<dX@O#7F
f0DZY0J^Q1O?VQ[M.&]7;28E5BBf798L17Ygb=^T-,Q.DgUFJ2e+g+I(FA>UQU,[
[:V)(#]0QHZaGcX]#J8c0W8C?<)AP7S)&G/77O)=Fd.5Y&OC4<DN]F4U^ZQ6@=<G
5[(+Ea^<X#c1??ANZdM2II,:JaCC7?7P?WCI3b08@TDGQ1+,d:TI]A5aOM-<R/^R
L6Hd::P@bB9VI#MX&=[\XTRQ.90dMe0AZ&RW.]\.04TZ4MSZ3)XEFdNXEg&O=B[G
&\@,\FI28#0TPX?bE/329F]KOSd4^=?A&B]CZ,gWXSf]fH;cfC:-IQ@H8?RB>6:W
M0eKZdaVGYEN,#P+-/Dg=O(OX^WJG;5-O4I_2(GK2WJadWX^3TOU,L&#-TC8[0UX
8M<M;Ebde7&BAK0Q-T[d3D(8/[gHT4ORbO\aaOcQUHgQaQ]A\D0##_1^-f9fQFLG
W->e;BV<HgUQ@_F\c_44@R1K=U<(;B7ff=MKMO1#?gPXSf_B\QcDY9]NJTAF<M/b
0B7Z.TXSP+g@?5eb..S83<Jaf,g]RO;YVF.YFC<)L0)<7XOK:5WS9_gd>DV,W+3^
M4&@H=V5#aA:&A\:fXPBQK6acNH]cSIR4TWG]K4fD#Ad-8NVZ)1,EVMEZNc(ZQ-e
g3HWU4@31HG[FPO8>YT8C^?N[NWS:^bgZM.QN.a[@<//##J,fU\aCL>>2CD0)FEI
edf#L0IP11:N-;IA+2fG_61O(+F\22WFP7+KJ+D2QB2][6C^=KD59-8a4+1C,<3A
Ja1]]6,/ZVHQ3EDW3YV_34b;X50g>9/(C>BBFd?_8;BQ27DKGZVE;CHI80)Eg==e
AX[GUMWU.6D]5H\Lb4I4BV<U_@QP&dJ&cX@e7.gMXa;8M\=_aSM_H1D4G?WCeU?C
W2(H:363-D&8gP9D:><Z5SX,+D.T_FQMVXe1-9D,H,8Q8S^1UQU1P6c]VH9g/>E7
bEeG,.9)E>YHYU6I>d3@c/]5RWB76+<D(E36Td,cIE4JZ,XbN=)1RgRD5Z,<aTd5
DS8Z&ZBVUeY/#Hf>(-HM.?.4E_[__1Nb=R]>T7.\[Y)c+>A,c,LbG9T)V=^aKg\T
VWf&;MT\X_Ba<^W2/&CWB);@1;)I3W>4.0aJd62<3;TF)]FQf&&8P_YY4E^GE&);
?\1BR?0KN?)6NI,MScOE;OEU]CA2=10V:<aV/SZ4\c=(H6dK,Pc[8ACU9<HRbEf2
N/,d_,\L87B+e03Na8;[N=NC<RUC,^6C8<7LD.5F9TA@M?=LZVK&_G?G5^,UgT3_
Q/,@2)KSHJ8+LE(P-M#KN\HE);_IJ/YZ1153MB8IDB6@04X:V+9-.6E[f8;dUF5f
BaA^PU1;[5AP8+S3:+BU]>:E+)[-]ec_)>V9eANY>6(YDa=L].\#B-]bH5Sd>)c&
</eS,9CJ/7B;1?K3H>S]&_I.3^:5GgTPG,aX&2@H_WN_RF#,3NTZ#NZdP/\Q02Cb
@fD13T6F,MLAA@8Ne)FDP4aA?G;O0&C0@QS=,+6Gdc@gFY2/9/2Ef=UPG3(GMNS.
+I0BIJ)Y3Z9]W)JKL&ce(=<Jb1,PHEV:fV_L.P;#aH^d4)[Df@X<gH@MFH36;P40
=aHI;D4KX[eAW8b+(#e9Y;B(@40ZKHFgLNG&3G=+>de?I:KVYgRFYCgae\)N=Bfa
TUd_@JZAUJM(9/=1d1BDaEaR1Q[\J).\)6d:,83XIFbT2@/b.eRSd)SB66:2S(>/
<[FVQWU.1F.S13bIDMgdL03:KH:C)(\UHRgR;+;M)Z/gA9\H4,.@8BUP5O2WFC1M
UUH/D1T@NONX]]24QBYULNXS1f;HVNe.AFXS)f@(5J:2[c&Z\L()&E>A#GJNEH(E
0)C9F<0V=+U>-Bf?0E-HIO+NU=Y<<2&UYg<\@Y2[769).PBDXMBD[^g&Z^R:2W?I
]Wd,9HB_aZ=[&5dU/bEDW(YP1_22UAae#TNI1.],c2aN?bL#6c.aLZ::]SWM+^0I
XRVfYdQT>,RQg.]O&3[a1S7M-&M.:;fZ<R^@4NCc6P;41ZX6:)BIO[d3;8HQ-K#B
\_^HOa8;<.,0=@e2Me.E)UDH,],:P,HDWgc-]g:4fZFg>A&[gD8=6B2<T&?a(T6&
0D+LGLI1/a5<M3;IW-BV0Z/a-WM2WdPQ5S1:O6bU.MMHVPQQ&TGd@E<&KK];S-:(
JS403B:4\G2^QN^ZN93I0KO+FIU,aSSXeI/7G(1I@bKCMcOaVMDe3cg,SNM[f34O
K@e09J-GI@JN&#M9^>aQb;HB1dQ4B3DT&X:c-3GYb_+14[BdTF<CLB??U9IK#F#(
V60F(VJ;/G^OGQF8I;9;1/2Y57LT)GUJFfHZ?E9OWLEdOH5eT0?5&FJNC@<)IbbC
<)1VOZ:F^>(001f]Xd3T.8U7L>UVgQ1LCO\+@CU6g&+4YKGeP<LI@Cg-^Y1f_5]N
E\^BA:Db)RAZ[\EV(>[G6\U[26VT7bAJ7bdRP&28M)N[^1S?M(CAV6]gR](8ZQRb
8e7.BK@\N\1A#Q/Kd(5H@3=D-@,bG\4N5bJO(G,BQD+V:d6Gb,<>HQQ)>2MDe?[7
9H(/G=VST663;R@RC^@<SXGH(T/eJ)=.c4WNAW-<KD#\5A00783W;5#:&YfKS7.F
HCZBD.2c0=X<G[-d<<ZCdXeag=J)EDHT_R74J1#D9e7PHb<M?4bS<;_QRaVVEWW-
Y4P7,X,_314\C?F?@e&)E7?4O9818V?F0g1Y::T,T^fWLa\1U1=ea3DI-#:A(V.P
\XX6M5VZeD6-Jf\5cAg8\QT7,OQTR5_G_/bCVIe,0>&Q;>47SVMWGW)WUd.:/;58
B@E/?Z65TUF-7TB0\:KS&dJ9F:3\RZA))HB@7#0P2Qf9UFg77)Y\b\HG9e2WX)>/
PHFRS1)_d^\5;:AM?HBc#?Wg3,;653<V)QI3e2DCN3V7g,H>N,Q8QN1N>&YPaO-.
F3]^&\]2<ODAc&/?KXb#Z\7Q_Fe:>(8If1H_M3#XbY5:OJEb\R7/DOYf)N;+G=?W
eO6facJM745gVZNd_gMI]I+0YV:<RF_aO6/Oe(A,FE#aRb&/c[fFR^JPJ88:+.[A
P#Vd(ZZ2EPM/D].[?WBYW02LeDTfLHXHDZLeOUL(R<]f6#:bLQ617QaT:8)-,Z0O
L(14LSHX,V>Q3bHB^c[4@+\_TP\9I?>SFBcHB702C&g:9I,Pc&N>BCIOLTIWK9=V
#YHgcKSE>)E[GD)<efD_CX3LD5Sd:6=?W]?7gRD]_=U=CGc<.Z<VM>:g4Q7F(&)_
^IE>\L6B\6Q,T6b<)E0OB3O=#=>Ud?@e<7I7=AZ7ddIf#42CQ]g:5e<VF/d)?W-B
;3M+R/^8[&__=_L20D/4?E.JVXF<IL)\8^-9B__d.Z/VN.]_]-C[G8MDe><EIO(L
ALAE_\?/R5HFJ\?Pb4Ob;10.Y]?9dXC:[#[I5fegKPF@JBEO;[FegN.I>,7#^5JQ
C_\TIJQA__;.31:CSfU0F^X0=3<13Kc._+fFK&U:aJ57HW8X@.1-d:9eN/_UZ52K
WZOdX;K47HHeeFB1),T],9M6X,UId1[;OTIOVAG7Y@P6,X2#HbN<8J<Z_>ECDP;U
.#b@O7C>A(,=W2R388eJOS?W&NT7d#FHCGQU:fT=@Ab/+TDVYbYEDL^fR7;>fD)3
+8e6Vb&(762?ZbR8>IbW+UQ=4_;H;1TQ_98N)AUSAH70fS[g:g1;-W7H9ReP^<I#
LNE2R2gY#TR6+WO9O.L1?/(=\I1ROA6^P)9.EL,K@5N;AN/EF2^&@\PJ#(IF3#1X
VMfJ)^J^5FO8<3\DIg/86.OOaIcb1QNVE#6@V_JZAY5d#2S4RG55Aeg-be&Be+#D
/6UKZN77cQ]1.O_Vbg/JRd9@CSNc=#W&?XF68V:3^Z]413-R>8HBG@/].O+T(J>Y
R3>:\F]+Bc[)E2@16OI@bc^;a[FWDM;fb(W)9DXZ6d,_ZEM1R0@]#&XdHT?N;#Q2
]XL@RC5CgM77-e+2Kf-=>Z_;E#-\K.c=R:B+U0ecWY1#9F#+[O2USMS154NG;dBM
aJD2O7a1L=ZW#(\1DINY6RaSRP[fg1]I]?+=4^=2VJ]9F&:C[:Z_JH<9+&8R==,g
]YV87HdB.NWe]XG3?[6POc7L4Wb20GXRL29W(NSU3DVRPKf4@VX<Q&c,9N?aA;3K
A&Ac^A&c7#EPE<(+JJ=[CD;JD-RB_:DKT-?EaA_)+?Z./7JCa4N)4:A&>aM9/S1g
<6Lc:,)26XK,L12VUCM8E]/47Nb;/Ie)-FaDX),EYK.07b@US]A48O\5dIX+bWJ>
W<EY@7]]&bTZRXXB@g\M3R\E4Q,eD4+,:0L\W7&.J]a1e_[2MYZd/56:TA&([=?;
\_1PMZEKBM6<OJ26-MM]V;SL]^II]KU(@ZVM.]UV&+KZ1H]RE-0;8:?AIeAQ6T\f
g^>8\CNEDHBXHO\##?40A2e?Y;C008L5\DRXaF5N&76)+MNBX:-&R+IQB(H5KTGd
9fbV#C\5XH0DFT-<B\g,OXYXQ9:d<=4Pf+fF<1\6f2W-^VLD>0.?WO+L56VE3-SR
XDNOO-HUS@=PQ/\GGY<eLQ.JA\0a3C7Qb1T@7C8]@NR+HMZC+/4K4,YXBeW6S3WH
c8Zfa4T7+eQR9Y@Z45d^<+0SFg<KRQ+_b;4+3K-HdWF0YBVVZ2gf.9FGETJQQCQ:
gMT:8O2bM1eAJPa/A;/=fcf0;YQ+ZD6fa6=e[ID&>PWO5P.+XH8Z7B^FOY]:HDe&
^fA:cF]e;3_/SJ(Tc]5XQOC1N]Xe?Ua?>F^Jc)>M72DS-QDM+[-ZA22^]YO5VWX=
Xc:1=7W0TWF/XOe1T@4T2\S#^/T[/M/=87)3MK>VAQP;fAI9]Wb>YP9fKRH7N2;2
N>g-N=FC;]4baZKgNaB3b\W3T)c\^L+:FX:=8Ld^2+:-1-K=<MEWL9bAQCJ,S]/_
cYKNQDXH.gQ7>GNNGI-PDM>98f^H7D9J5=a&0V7_UB&g5>RVS/UH/M-?9eTF,)cX
ZcX]?O@8bb<@TDL+486#6b)f;PF)A+5cR;g4X9bcDG5,U6b+,;>0)VJBKIRKPEWb
TI+_5R:5,b?7/=Le/+W,K_&g+^N@Q,9/BbB>+,AC@TU9be+,:g;F9@:PZ63d2LI<
?ZAg,=S9TK(b,0K)X/35NGER>b4D837;g_]I-A>?9H_5]N4BW=9<aB)E6GfD^&d5
JfU=:7f-&9:PU:H([OAJ\gNP6ec<O\T-3L=>C40<N?GD_8EF:^W781Le21[RI@76
&O:I-D>@F1e<eM@\,0J.9_[IfHBTQMP=dIK-]-1HT\(Y=-5HZ6UBQO+aE,3/eRLE
G)_#H0R\d^(E<5a^Y+>F6?]7&/a8Z.f>d8f\#2W<08=OK;dKQdBQP^Jc2aM<N6D=
Nd>/S?3>IGTdA#M85U5,FM/WTaZ]R\4-3YMS:;\8f5:KgC.T2).X0;:N8gdbf3@4
;]HR:4DZEQE,XLVZ&D4UA^8A4,7&0K[,Q)9INAL71b?W7V5^0g4bA(b#/Zc_RH;f
I=g8ZY3X&SI&;f&+_4&BFg(^f@S]M.QbE2#MW0T&Jc-BCZ4FRgc31PG:EY0_0R6Q
d;J+aJEfV&;bK6M><CHN&)AZbKJ0Y.ge5ReX4fX_(N#UPBX.J@3H&:8+]D\BXe.F
]b,?LJ^2FdA)MQT,OHJ7&UY.8]8JD,Z+#^E7@>:D?^#5#/ZggOgegW-/FF5#]AIW
]Z2a_QLaTgE>CX<@4acFLGNfHN@((&,_?PP:<>SH92dKGBGMHWITcaGYe:,Q[7Bg
=5=BC/#/f#P:EW;cg5+E8#,/MIbB&OI8_S#9LM4O,8RZ=/g^+5DE\/A^B6?5:Hfd
17?eW4,aY&(ff-BF/O9ca,&@[]/Z+QLR0GbP/8UK]B(><),A1NVNH^W=3MUD(:O\
>T>Z7#J,c&Lf38&<[:7>DMB\DI.=FV/DRSNAHY@ZQd(eP=ZT66:6YU]d2,.+&P;@
.gT,@e^FbE6V(BNA;]R^[QWeW,<H/GM.;;T8d,VH6B[\(EX+2]]Y2O)bPIYJ\c-U
^E<BP[&gY2/]U<)YT1+\>7E#LTHLWF25e>2P.;gQTZ1K7GL946_ZCU6Z:.5D4bSE
Y<=43f\?AZ(b?8JLB;3.E(KXMB.VXD5Fg5>b@6/.H:95fO6+G&5&WRG1E/6/2B\B
B-V.R;Hf6([2G(+;CEI6).-5_U>Tg^I>Nc,UI]fS_PE_\+JH51>G6-P-DS,dYA+?
EXC;3E9NCVa)&44gF0\LeaAKHfM+.S7H)=Y8(3.cC3DN^\W:ZPRUU]UMAbNS.N;^
RQU-(V7^P9BR\+-=6gWc1<R7_QM1Wb3=1M9Z;Kgf95K(QeHQ&;Q;#eOX=-^46/(M
7#H;&6HW[9U\UTJ<6U/Z^Z([,S0F/_7TMJGD(.]?RQe+.BTV&E.@XB)-Y[S>W0;<
T5MH]e@GaZYP)gKE9ZP:GN;e8BcfNV4\27&6+W@D1C<TeO+OAgU52+6(#RBBIJMT
O.A,>/]:=2BAW?7@Y:bVTU9Ya2XL2,LdC?8d)1K6_\D[VL/01=)3ER?G&G2ZSc^B
7a-9)N.=2,Pfg+7(C97MZCK?JPaU<,PYbI67X17H,0&IU9)f\.XDG:aF,>KO]ga?
MEE>OL8?bC>\Q,[MB(>1I:7+Q#<Yf+VJ>N<Kc-H,W.,bOQ7QVLQ\D_,L)gJ2K<)>
0NSVa0:0\]<-d]FKc<C.aT]#8T#4-/JB4443@Y>bB&2N>DVH\65Db-;<P]Y,bUD/
KK1#N6T1B.R_)aWD9eGSYAB0GI;^cI;AI0\>S/@V;+U1;LAYVcHHQ-.+5\N+b3)Z
DESM5JO:2B?Q^NWM2Cb_1FAPM,b77B=1Z:J80f=6F/Y9;J,3?UTU;/]ePgS2fcWf
1/K7OQ,(g88VCETVbI6EM.HbL3HB_LX_#M->DB^?M^f#FOGS6cT4FB?#@]]S)Le,
QE+RWK9._eH79H1AH6CEWM95S[TORI\:F(7E+eR^A388I4I^./Mce?.TI1[6Edd?
XKac;PfT1C9\WDC3g7G@bQ75:-,[QPU9&^K_d^ITA58PU0O[.ILYgP8V-_JcV,@?
FaD0-cWVACVbJ.\NfV<;B?)<7_S)GOI;N1JB=Oe];QP+HgJZg4BCMN2UZ<7;\cEQ
CB?LI,8:/7SP3V<_9C&fb;I.B@0e<]+/?Hd77L)?6W90N0>>OcA:46#=1:<?C>PN
6d-T=.R#MP4,f/N8e7Scb#JW+12MSUAU=L7DB]/.1df6,f2+)5LY:+fJ2+90a:UF
H7Y]FN/;IE](W>R;M^HEL0NR\U0@8Zb,04\,(XA>#-MJKG,:d)?SE,VA67Cbgb@O
YKQN^[8KUId5@BX??JdOAJNgGb.aWc(_[5-e7O3OXfb&01F;AA?_c5U6HJ3C>BT\
]FA)JIZaLDe86O0=^8G2XM?@\R))?&_]SeA@E73P1GIB#]>63UV1NPSf0,FNIH;d
UK)00=B0f>^>;/CKg@Q],<bM^C?.>Q2a.7_7C]gO8R0:X#6O51ZF0Kff^)7X<ReJ
[N/,]7e<=/TaKLUc]GC[HHTR:8XdQ#b[g8#KS1KeW@N;J=P^6;IR+Zd<>8eG;7P:
aIPWcLU0+7S3a@2UN:eK)5a1e?)O.[RHYIW?5J/Y#UDB<QB2#.-RN._QN&=TWVaf
:8dFQSRe_(U0aDbAI@:Ia)TXJ4KN.=4(<g,;NR;#cQ89A0]ZN@SEeQ6G@9CD5+-E
J\_f.&MFPUC.FQ.)gN7g/95D,:KE?NKfOV_0YQ.X(Q=.f.,BcVYVYCJ8b2U3]G/-
A^,e]HJN5#QX,fNAcZMU4Y)_38Z2QL&5:&U-:N2=B::]J6Q6-XH[dH-:eOYQ4b/=
J/>HG0A#1La#.,@1G;#7F;KF?ZBHOBA=L[Fe+U(ON+H_f&^b9V((:Y<MA3f,>^1P
N6GR&_f-T#<gf.];13C<G0e/Y760Je_F[]M<=AHJN8730KLL1C75+J+2MC#R)2SZ
E[5?3bGYOA:Xb?X:KO:^a\A?@dbD_5Y@gVdfL.F9G>R>bb0&G6VffK\T:XeE8/Z(
>K9@VIX(?_&dOfPV-WYOW@+MEG9?8-=UD>?[^YcBMB[@VLcNbd5dcRf+N349/#,,
;]N<B0e/a8cYTbB3UU@XVL?9Icg>g7^e[eYG4B5#NIdGK]//+1VC,7e<gJ9^^]81
O7cC^aTaFE=)b.YMd[,LH>]3M7OK]Pd6-PPJGTg-J>?RUBMFX/J^&X3.?YgKH)PU
=PS3?AD?DKAOH]_HD3DZD7JXCLgA/33=@3;@UUOX?<]Y[::3\cScbe4EFSRSE70&
S._Q=/Z1YQFOR)C[?V.IKR+eKKCe=3.Pd0JG&I-A,eH8bC^fPV+Y676>DZf@a\3F
#D>57H^WI43b\\Ug82\:-Kd9[E.NP9ZVe_=5f8Yb)V;6FVD#6A0dbagS[AMR:)I@
WY>W6C:/,C#]Ba25Y_WW-U_5fA+La\4aE<&S41.=-TQ-(I;e@U^;H\_gR-O&#Z]^
/E[\)3;b3@&9<Pc#DRe#Q<bH71g#)UYG#YJD3c7a9J[2Lf;HT+-\dID+(d_Cca:,
<YC1b4?Z]D8HcFY_1\BbQfTN9accg.[7CgWf6agLR:SXPOe#dfMA9Aa53C@<;M[P
+d/1N)Wb.c[V;9((cL9\NgL;;XP;DPLaQE17#MS=EZL#I.>e,AOeLYRMU<QYDXQH
QV5DK^@(54L\H#W4<G?I9(PU3ZL^6R0S\=Q#\4=W6_M/88\,c?IX0A6-&#-NW([;
^/.2WSE:<Q<^4S5/?Q<?7:I1WJBe^5HL>=AP4\5D:CG8:d_1:_-9d,eDS9[=(#T6
N[O=7&<#],DB-)Y^,S1bQEVQ)]KBb52G=SfWHC3:R2aGRF_=_Y945+7OD6YB2J3@
VdP<>?I:KMPVKDJ2XC<2C/H/]HHf/L<G:IK>UVRaL^\FbH-BT8df;M/U@9H.FVFZ
T&Z&(.H&fLM/K&c>d2;=U.g6=_+/S9fCfUIYe@eD3(&Z9R3OTQ4eO+V3c&>d=C]^
=a?(@7^<3ZM-Z;2CU-P/;K,H9U_c?+TX3Y/KUUN_/&:_;bW^NBMSHTdEV(=.65>H
\9L5G6G_SQ/H,P_R-K4COO&1CeHVGfM@/C&4T#MU>:;Re5U\N(-HDE8R<GCT#(:;
5g;.>\5:P_S[Z=@IPV,+I-QHG=P];O]3e?PZe4?ES&0@ebGffU7C:?a70Z@7\a/#
?5\5N5Lb(.,-P1:H].F00ReO,9W(MN#_:bXF9M?=+TaeVWRR,bP(2I+E/cF@?<eB
[0AgDF_/6U<,FKOX]\c@I-#21A;&.(YDYI6R.9<.F8DK8,/OG3L1B_?eeMXA0Kg0
1bbX[,S<b:I<GcXHW#?)NM78<GV<+V0&64H>e82K#OB6@0?_686UIE^FF<&DY=MM
WH=S,W)<X\.=5RUF^)IaMX/D91>^9&M:13Q]EfPBEUI#]+)dL/WI\L_8<#cD_58N
3BS-;f#6\@N<==.g6Q?[RW+b+eNRH6X-#>O:H_eCGe29KH):77QZdTR;#-AD7E>T
GJN6A^,MBPN(-><SHU_efZSI&=/SYG.G&8;F>5WA#e[_P&_OIV2&IGH@b/g(597_
I+9OX1C4<;d^[<U+B9f(48R>DPA>;:gEOK=I0MQ([A@UbKD6UO5>fQ,=,YGAg?&M
[0@H,=[^&L6RV4fB.ORJWIO<DZ4Z32c\P7TSK?FUC,g5H-.DRL-UJFcbd,2:..NV
dIN;IFD5;AOg&gA;&gIVBdL@CLV38]>D_NDSF4KTY;7dd^#3KSKe5IS]B:@;:TH_
Y++OM7gUY1=IIeQ9+&d1.[]DIF7d]Q539Y74g)HT#64_US#OeA_@d;7d(IHH3QaG
DH4LM?f/T:Q.;((C<H]RJB]ZRJd6CC68B^I_;H+13VP3]=4(N/,TDZ:H;f,1>0H1
RGA4GP_aL-e.AB[:c4?eH7@I\a3HU2AcM#T>4<7W^\dZ0VSg1FD6A7-O,O#GD+S3
,18A4UL-FQT;9=5J0EaEKVG]&g4HTK]dO(9Ifgg1R,cA)0EI?=F2dW]Wd]>f/\KV
[Bg_:e3[)B(+_,-]2OO.8c(eJ0_GXX_,?f.\TA7;36Zg#]D6Z=90BRUO/I@bPW?I
?&@(#bF=cVBR-C(ES5F0_g1W9F?#Ha:)2LBC&S^Z6aE3&UY>Eb<GVY,_1?cR5FeG
W=S&^SW.Q+5O<+d(D5XLE-^3YSY\?FB^H^7g8KfEEM@(4NO4WMMP>eE<^cPbg^9d
(@INaeHNf)A9IZK>>4_1>(YMT2<4@FUW/S056,8=6)D11Kg1T;;O+P-d4:EZ8FZB
bBZ=-J\6F)D4,9C\^+6URI<=XNM^O1>#_RN[eO_]Dc^,@GI5][/._KSZ(+TQ(]c5
3MY,#Rde7Q,bN4YRG4Aa.))R9f_T0+RB)DLGa+KW8CWWUaE0^Q5J.^\)#:P3fQ#D
I1-6(4GbT3PZe#^TCG/-U,YMABWZgR\BHd6V0=?J5FORfM/1#X&U/?dG43FAIB/5
/&1E;HId42?TTNPHY+3MW^P4HC,4#cVBTaU.>]D=R4TKc3;&7:FX^=Cd4&/fKARX
0<8CG8Y)@7f[7G,@33[G;f&H?_2RaQ2]:^T#Hd][2TJ5CV>;?D)0,cQ8B@5#>b3M
1PG-KK]a69=X=Nf,JS/G0SZOCMEIGF[P@b.4@[8_dMI=6N(f20RYW??&DZV?F.3[
T7_?/N#\F7>B8.Qa94=>JDGT4fFD&UCMXf0DJOeYX?8:#8RJ9;A7fXLU_e[FO>]T
0)L-#Y;,Jg]>+(SbKC3g1fE&bPHK:ga7M^+a6XI-D,5=1N#/DW(/PZfcB6Y+aA#3
D:661=SQ//;MY=OIbe.PgEY&NUObG\MNLH@F-<&Yc\X8VddQF51<34,E=4Oa1S,.
@^,KdBc3Q)P,_U/)YBR^#+5ZE4GE2XR8F6fc&8035]&:XW+C(e_eW;80fG02Gb;O
B+FM92Bd]:+BZY[-e29X7;6b_a37KHf9Wf+b]S(IbJHXPH#\??,;eTNL\>-D.D4D
=.MY8[O+11N1X5QVRK:LK6+F]N#VQdZM=;c=AQFFG(_-MXX,/KGG:4SECOBT((_H
4RQAW9/;S7,gC6]239@6d=9RG)U:Y/(eD)DGX8@e;_c;LIIeb5KDd>d;eH(XLJ)B
].B><-D6X?&CO7GW1APR7FPT5R,T#OAY\C]g9,Za(B(P5LO]@.,ZeR4)<.8T;)/,
aUGFK/f55\gAD)O3PFQ1Y\c>^gGaK&#&O/?^9]\FVKD9_gZ3TCNcgK=I<2P3Y5L1
/^b3FUdf4VU(M?I(]^X3;/gYC,1:bR7^5=67@W3RG4QA\IK=f5BEU3XX4)NX\)E1
MDJe4=+>VB0=gNZ5=FXf,]2IRXH=c[IPPD+8C\(=<[/V;[4RSCYSZc?_gK@PL<B;
C5-MF()23Y8VC(Xee:4:KMJS<be,>=G@>(_SKWXPFETENS3OP2_gVA@WG5AI376@
3N\WWgQ3f4@.Z-)N+Y.c@37D1,Nb1PP6RgLUa>e\D+R\J9U79GV.U,ebG>\F8<;#
^Q#6Z1]9797_@DR3D8ARDT<]4)/VQHa4>:,0U5.\FDT1[Ma1f)<>2[4-CY;QBg60
TWQ/TF)S1&]C0U[_/G8+1XO=,[J@_Ca<(EI(6HH<DRUJ7D#L16)CD]5Ue8>:J0d3
e/:b2SZ8^dB?Ud4WLXgGCR7SQG+c>)E3b[K@QXC4N\CSWf#U35VP#)2eNYD,9RS0
U9)9L&MO6&H@N0HT;[)/)6ZKNdVRC][0/gdB74d<DagfUbFDCK2_=>eQJ[]+=)SG
:HOELDG[W)BUFEE2<:WYL=G(+Ag0K&(9b,>8+8NS+[c(W>4aFBN78?>e/Y7>>9DQ
GL1&AId6TE=)N/@XC3DBe6YVUL>[,T6BO.;_a8cdA&04g8_1f<,EUER4)<8/EeNW
-;P?[^-2A2<.P4_gZJ<CS2,aTJ9S+_2Z,+a,^NDU8=/LZ+L7FWgKR^eRK4OKADNT
9Ld8C/#C_BP\IB,JT2dH2RH<23fcMKd4I4@-J5^K?FUYH)U_S(A7>@[QNb+2,/QY
=S;>CP\E;HG1FMR,IURdGB[J,e,?Mc626\O-[@SaOS?=ZTB@5/YYf<;8,WSL&UR:
f2ZE2@c9?D&T35N?J.-3;E.c/d#M:5XP<JT]&9\QJ)WTZ.3Y;@NRfE?WW&b>&JB>
10?]_OdPAQ01X4136_R?@gEA5#+_LX2Wb)<gP#(T4HNNW2e[#FFA>Be6e(YR2ce&
eOVR_N)^e,f1ZYVbD5@8\gMHedWQ&IJb6YB>U/TbZ#FR:29L#37,DQIRPBI.F][B
<9[#0[M6O_AXc1JOV\0a56g3=9&U6PfbC1\9Yf7Q>1;:+)5#[<F6IK5/F)F1>bN5
OS=Aad=9-c^40)<>DS.5Ca0c/Ve?DO>39AB9He;LL=+7f4640Q.I,C)J<)2T@CJX
^Y2YRE7deOAS?[G8047/a>@;If,:S&>e<\<XOfb>O1&@/7#&[L,I):?ZXC\LX1?>
UB><4G_>]gdA_/edPC7EU9\1)5@YHT]dL15:Ka@;Fc\5B^4V:7H_&)AM)9_\S8?>
++.5\Y@e7XRM_1>@5BO4ZEfHQFXeJ.+4[e+J0G0A@:e9+4IYUI#7Y660WR6IgX.T
E]?V\dF>#F_dCR8#g[P#G#G[:a5V7><((0+@OB+@?/@Y\URcXde?8aeY(+eS(3?c
TJKNaD/)E/)(B67(&9SN0RFd398Z\?+d^(d/T^NPB+KUFM=fU3cJf?PgCVKHW^(2
<O\:J<.LM^<Jf[UA5KO(S#4E+<bbH4WV9Q43:D5FKg_g/5C:@V59N.g7dD@6=;7f
V&dJ8PaaF?FB=d3=S.)0c,KfXd]Q)a5CDNXEJ(;Y8?b6?4NSZG\18b>;b5f1;O7S
\CIEJfKC+6MP)4,AS9LBGKg0_1MXL[C881_&_=9:<^890WbGb,VgdU-4::#.DDJ&
M2YUQAMUQ)/0)RcTEX1BHa_=)53fVSB7eg6U>Qb;52KM?7]ZEZ)48I1eQV0fFRKX
?X]ACLZYF[J-J_(Ra-(&=JB8IdUT4UDJDcKC_14R1<b_NDZRTbfLUQ<.L^cG.O,f
?0G+MWSD&_;@aeD&VM13F5BcAPfgTA_,:F1Y_M92XT>;])34N>d+MLA&OJb@^K;Y
&L(5@YLLN:Q9SBb1bWKYb9.\IC:,PGWa+R,MI&Y\5]YNZ3a(B[1]8d3b0TfLJGf?
0+VI[PWG9IV<Z^MEaQDENG(Y@eeSB-0-VN]2VR9B=35Q]#I;X3b<gfeISXP/ccLF
5HT2REgU,6g<L-X36Y&:V2QZ)#3;&.&&4cRD_XV3:aJ5E++@P.=_KXU<MFQX1LY2
A<7Y#I8H?^\d=I,Wg[Wa5/g>K[622[_,D\,U<V,<I8W(H.)>McVdA9fd4,ILPaeI
P=37eJb_=]^X7#1B9MN^:K@dL^.6U+\Ifb6(OFQBg-STUg1b]9_1HHg1CTXQ2e^#
,M2WECE];_#W);\75e+=A:39.OXVB5A26J+<a-Pa6E/JBGWLA.9=X_BWPPR:4g6:
D/Yf@J+55K@@T.O9.0/Y8<\0EY6]PE4712=IKO+.82/2K_>)U:1,aA(EfCV?TJQ?
S7&B@9S0&Dg2b/SZg1&,\Yc6eG70,Gg8a_K22;g7O2a)WJ#50,OTg:F7W>>0fNYa
TDC;b;=:]IW_f.c54?6Pc0;2?A2[,LcLP6)\5,YBJDX4-_N<TQ,3?FEN7g0LTMPC
S>@6\,]XZRW5=?aWPDM:?569RSVP\#C9V6/=IeeY(V.:TPWfcTe,RT9:T3B9+1:9
:J\1VG<5YRb_5,;fM6N;_LFR?SNCVXe9,4^]T)K((/)5b6RT+^AQa4Y@9-F4U>-?
JU12(H++69:AXC3#cW[eL9J:F2,,08Pdd)3IAdB,65b=S4[f;=V)a;>IdIaN^5Ha
+bG@_-[f?W:&0XEXc6[^/&JHAF;bT3aR>>9SEA=1.1DE:2g.C\UPOgf\DcA6\C?>
6OT)GK9;EJ)N[.IG_gOOf+UKfV6ZBYPda/+6(DHB&G3-gVf/<C>+7_PeW&;:2Ub4
UK^LY?/]G+95Y7/7@)+@.PL.41Z3a22\]D9)g(S<3fJ[+5;?70Q9<[4Q&9>5#EbR
\f7;+TQ7J=G,M./M:CgT^+JfI1DZ\>8LF#OMZG7P0>QAFR1Y:8?H6bVO_3e0LECE
&R0;G#gQ]#1.1_LaJec#[CK^-+#A,JGH>ZY.TgbMQ2<R:(1e,Q#6I27Lg\B1/E<1
-gaHg/8I[0bRB&&.I0AS8#0;R2/\@+-HUBfU1?DXD&f0O77,/Nf4:_Q/dE8(4:a0
b]X[a@R\5c?1FbQ=NX6[[#+0=LDC1_C1+.dNQ^<C^^7^1JQ/E&+8?XK9M\2BI\HA
TA<a2=94Q^8M6Z1^M<;c.I=Z3(WG(AeU/&R?7,(WB(+J@?bOA9LcaNZA>,XHY?HO
X(RfbS?O?7>.V8U2UG<eTE;R9551LMEN+1SIX&)R33#Q[0=S2)2,R;(77QSBDCc>
JG0C^:8[DS2N@5.4/6PEYJ=)CX]?^Q>X3Qd.bgFeR@RHJU]M)ML_-5]WVA__77=1
3E.RHP3_gZ<I9C@5X=_?7G#G2PQ1P3H0/TBE[g/)>F(-#,&6-T&^#\2c/&cSWR8U
KB=e/c[?bTTI<8SMMcH]:0ARZd+\(dBe6gIKdOL@YF6aG^U<[b@NAC<FV&;2U>e)
5S/F^G;XI(4O9d<e>8,GPM&eZJ(&FA\G\)L3OfdcQGI2CYRF@+dI=1@ZgK8L=6.1
;N..0NILTQZHP#:<F&]A@,_ZM05@NBW_D^_P(aN21GX_b;42#?/5+B_O54NRg3cR
?[HdU)DA1/#ZDWTYLKAV^a?2g<5WHb-O<Q)O@e/F//52/fb[FDQ;P7Y]7]_&)\Fa
c#IReXLFBQF#KT^GD#5&.B?22$
`endprotected

// --------------------------------------------------------------------------------------------------
// pre_randomize
// --------------------------------------------------------------------------------------------------
function void svt_uart_transaction::pre_randomize();
`ifndef SVT_UART_UNIT_TEST  
  super.pre_randomize();
	`protected
QdOcMK4)4\Cc^],SbA,O)d__[b:BZ[cA4.Y3P_^4dX@c3ZL[VUbJ2)ENVH^R9/ZI
aPV1IQ]JI8U)6;#.d4IR-EH?AJQe(Uf6Sb4?PB^TK&8?6Se&:NR(>4bH==^M#.)5
F)gDBBgKNe\g=dPG]\_Gg>;f?73-3gZM=$
`endprotected

`endif   
endfunction
`protected
U2GLgU/#0X=G-cC==.4\JO@UE+:=5N/ZE3NPX]UBD?CQ55Wba;H?/)UKBP[W=DB.
5ST[3]JD.3VdHUI:4B\FS/8/ZT2<(@7,cKO5MZ.LC4T)TXT,=[F[=+G_;DgH9B>@
05YgFEPg<bVBOP87S]cf0&45PbIVWeE)SM\=0bLCcO@SA^\\5dNUI[?DK&-;HV@S
aG\@&?@1]<c@A-+(M=JL[Ue<Se6/:e@4A=U#aaV<?,c&ZbeS@#D+Lg[3R]_+9-)V
cM)9I88R1UOVRV.\aPHIeJc0Y[P?M(S:2c497g))LM]1L;EY)fMWLcWU5=-3G5:a
PFJX#J8CFF2W.I)060_2PaH\(23,U-2@d6Y;M,#C?EK_J@T?0dNGWGaP\e3.BKDb
M7FZ,;OYW/+],&8XdQ9YJF8gfC/^Z<1;B_dEBT0(8^]:&J-RULZg2/)>F79/=W4=
-@\&,NL2DIEc:EA5FdFdTaJLK1--e\a[N5YHGU[D3,7?K;L?M)R:[95FC][S3+eI
7.EQ7_11,MV:+NRbCbLC^KR@88&a+<-\3:b&F73V3@TIT5gXb+c9^Q79,TT;aH&I
^#+ZNPdJeK&[>M,?>(H:e[g[^:)<fCP4<+;BD#]EV3NP<C?;K@d31AIgdeL)geb^
>KdB1;B<R-@BEWI-^>)GdXJ4Pb+&<SSe;PZ_2FWe#-RV5#W?WL/TN,F_M6U\BYM>
X?M24)=H(&X@aXe0N.NM.7^;Sc.gCfKO]GQAIW<[&)A+3IEf7TBP^H8,+18/MZRP
TQeSP+D-T]QfYG1?>EYMe?^TJbW/88#<Z--/_Hfa.M.3(?dX30I^eT^6?</=(9==
5DVX9P);#e_T5TF1Y9@3f/]N7)CC.E3c>K7,c_1]DULVD/^QKD9Pg9QaTcH,C1+[
dNPdf66&gH\Gg#;=>dWG5ZdH9g0AR8QXJgADT_2_S,X=O2:-P(fR282ZN4+Y(-&D
B(_[)_&>^Ufb.:_Dg>1F]]S/CZJVOE.QFb2A@<YN<SRgMY?(Q2bEQA1WJPMQ]4Y>
@(EQb]_L8=b3IEKT4GH&]V48J]YKNa<e-YDFIUedRC-)Td\AD;g):EJ[0_W[gYcS
H1;WR^[0>-2_1V@>A30e1,VcY<NXB7GJNB>6M/58++S6N2U:TUJEdM=TDO@VH_7E
-d6J7VXWZ&7GC-@U@9<]Q3PgC&YFY#,\0H?-X^K-/&8W65R5\ZX\U6L+KX+R,9.>
.+9OJV=3;2>.Le,@_\CMJG06BS>BUYZ1[MUD5cXbU61QP_I[+KQC,BECfdP^,M=,
D(;U\X6M\X(e+1Haa^gAW7,CX[/d0/30YGU\GQ0=eT=TXAgS7N_<:54@A[,/Y-b_
Tb4+U.VATc&V/3e]<QKdQEFaBB@99DS?J3ZB8,4(0^6:\S8:gdb_7@<_T@g/J-M#
=<[_?>BX[=?9,)a\]93SR)^H/AA46111cK)Y2YGg^,G&SI59J&2FI&A)XA7SZU_<
8JT.X=.A=QA+2[@JT3Y](4B//FQ+3IVV1P[K9OK((?P^1&AL@d=L2&)gdd/UP:U<
ScVLL=S-^I>4,TRaDHYTc5WF:KeD5e0U^2L\CR_J&)Lfb=;T)7C?P<M3Z2gAOJED
<S(TJAB5bE9CEFIK]ZeB2ELYQ>V4\T.PCbgBV32Q[^f;/\XY/1(Q@AM3L$
`endprotected

  `SVT_SEQUENCER_DECL(svt_uart_transaction, svt_uart_configuration)
`protected
IT4/HeeAS;/++_+X=8AC+>IE@c>8I,ReZO9WN>T1aCOb>B=7#B4D-)>_I,N8AGcY
0fg.0M#<a)-\^-.)WdMO09?V7WeYHIdF.U&SC;X/4<W-3<;L-EH-[]A4_]44=>#E
N?g1bFV9IYHKXca?UB@EWCcU/dXaVL/LJeV:1(?:GC;CgMNZgN?VOg3IWcTc.Ea0Q$
`endprotected


`endif // GUARD_SVT_UART_TRANSACTION_SV


    
