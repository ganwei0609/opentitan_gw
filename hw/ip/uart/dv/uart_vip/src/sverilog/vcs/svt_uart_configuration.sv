
`ifndef GUARD_SVT_UART_CONFIGURATION_SV
`define GUARD_SVT_UART_CONFIGURATION_SV        

`include "svt_uart_defines.svi"

/**
 * This class contains protocol configuration details like Baud divisor, Data width,
 * Parity type etc.
 * 
 * This class is a base class for svt_uart_agent_configuration class
 */
class svt_uart_configuration extends svt_configuration;

  //****************************************************************************
  // Enumerated Types
  //****************************************************************************
   
  /** 
   * Enum to represent Parity type
   */
  typedef enum bit[2:0] {
    NO_PARITY           = 3'b000, /**< Specifies No-Parity bit generation and detection */
    EVEN_PARITY         = 3'b001, /**< Specifies Event Parity bit generation and detection */
    ODD_PARITY          = 3'b010, /**< Specifies Odd Parity bit generation and detection */
    STICK_HIGH_PARITY   = 3'b011, /**< Specifies Stick High Parity bit generation and detection */
    STICK_LOW_PARITY    = 3'b100  /**< Specifies Stick Low Parity bit generation and detection */
  } parity_type_enum;
   
  /** 
   * Enum to represent number of Number of Stop bits
   */
  typedef enum bit[1:0] {
    ONE_BIT        = 2'b01, /**< Specifies One stop bit generation */
    TWO_BIT        = 2'b10, /**< Specifies Two stop bit generation */
    ONE_FIVE_BIT   = 2'b11  /**< Specifies 1.5 stop bit generation */
  } stop_bit_enum;
   
  /** 
   * Enum to represent data width 
   */
  typedef enum bit[3:0] {
    FIVE_BIT        = 4'b0101, /**< Selects Five bit data width */
    SIX_BIT         = 4'b0110, /**< Selects Six bit data width */
    SEVEN_BIT       = 4'b0111, /**< Selects Seven bit data width */
    EIGHT_BIT       = 4'b1000, /**< Selects Eight bit data width */
    NINE_BIT        = 4'b1001  /**< Selects Nine bit data width */
  } data_width_enum;
   
  /** 
   * Enum to represent Handshaking Type
   */
  typedef enum bit {
    HARDWARE = 1'b0, /**< Perform Hardware Handshaking through RTS/CTS and DTR/DSR pins*/
    SOFTWARE = 1'b1  /**< Perform Software Handshaking through XON/XOFF packet */
  } handshake_type_enum;

  /** 
   * Enum to represent RS485 transfer mode
   */
  typedef enum bit {
    RS485_FULL_DUPLEX = 1'b0, /**< Transfer data using full duplex mode when RS485 mode is enabled*/
    RS485_HALF_DUPLEX = 1'b1  /**< Transfer data using half duplex mode when rs485 mode is enabled*/
  } uart_rs485_transfer_mode_enum;
   
  /**
   @grouphdr hardware_handshake_cfg Hardware Handshaking attributes
   This group contains attributes which are relevant for Hardware Handshaking (Out-Band)
   */

  /**
   @grouphdr software_handshake_cfg Software Handshaking attributes
   This group contains attributes which are relevant for Software Handshaking (In-Band)
   */

  //***********************************************************************************************
  // Public Members
  //***********************************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  /** 
   * If non-NULL, use the synthesizable driver for this agent.
   * The configuration object referenced contains configuration properties
   * specific to the synthesizable transactor and will override
   * equivalent configuration properties in the SVT VIP configuration.
   * 
   * By default, this property is null.
   */
  svt_uart_xtor_configuration hw_xtor_cfg = null;
`endif

  /** 
   * Specify whether both TX/RX handshake is enabled or not. <br/>
   * 
   * This configuration is relevent only when handshake_type is set to HARDWARE.<br/>
   * 
   * - 1'b1 : Handshaking is performed in both  
   *          data transfer directions i.e. DTE <--> DCE <br/>
   *          The hardware connection for RTS and CTS will be as follows <br/>
   * <pre>
   *  ========&nbsp&nbsp&nbsp&nbsp&nbsp========  
   * |&nbsp&nbsp&nbsp&nbsp&nbsp |&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp| 
   * |  D  RTS|---->|CTS  D  | 
   * |  C&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp T  | 
   * |  E  CTS|<----|RTS  E  | 
   * |&nbsp&nbsp&nbsp&nbsp&nbsp |&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp| 
   *  ========&nbsp&nbsp&nbsp&nbsp&nbsp========  
   * </pre>
   * - 1'b0 : Handshaking is performed in single direction <br/>
   *          i.e.  DTE --> DCE data transfer direction <br/>
   *          The hardware connection for RTS and CTS will be as follows <br/>
   * 
   * <pre>
   *  ========&nbsp&nbsp&nbsp&nbsp&nbsp========  
   * |&nbsp&nbsp&nbsp&nbsp&nbsp |&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp| 
   * |  D  RTS|<----|RTS  D  | 
   * |  C&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp T  | 
   * |  E  CTS|---->|CTS  E  | 
   * |&nbsp&nbsp&nbsp&nbsp&nbsp |&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp| 
   *  ========&nbsp&nbsp&nbsp&nbsp&nbsp========  
   * </pre>
   * .
   * Default Value: 1<br/>
   * <b>Configuration Type: </b> Static
   */
  bit enable_tx_rx_handshake = 1'b1;

  /** 
   * Determines if 'driver' puts the response object back to 'sequencer' via put_response.
   * <b>type:</b> Static
   */
  bit enable_put_response = 1;
  
  //------------------------------------------------------------------------------------------------
  /** Randomizable variables */
  //------------------------------------------------------------------------------------------------
  
  /** 
   * Specifiy type of Parity bit generation and detection 
   * 
   * Supported parity types 
   * 
   * - NO_PARITY
   * - EVEN_PARITY
   * - ODD_PARITY
   * - STICK_HIGH_PARITY 
   * - STICK_LOW_PARITY
   * .
   * <b>Configuration Type: </b> Dynamic 
   */
  rand parity_type_enum parity_type = EVEN_PARITY;
  
  /**
   * Specify number of stop bit generation. 
   * 
   * Supported stop bits are 
   * 
   * - ONE_BIT : One stop bit generation
   * - TWO_BIT : Two Stop bits generation
   * - ONE_FIVE_BIT : 1.5 Stop bits generation
   * .
   * <b>Configuration Type: </b> Dynamic
   */
  rand stop_bit_enum stop_bit = TWO_BIT;
  
  /** 
   * Specify data width to be used
   * 
   * Supported values are
   * 
   * - FIVE_BIT  : Five bit data width
   * - SIX_BIT   : Six bit data width 
   * - SEVEN_BIT : Seven bit data width
   * - EIGHT_BIT : Eight bit data width
   * - NINE_BIT  : Nine bit data width
   * .
   * <b>Configuration Type: </b> Dynamic
   */
  rand data_width_enum data_width = EIGHT_BIT;
   
  /**
   * @groupname  hardware_handshake_cfg <br/>
   * Specify whether RTS/CTS handshake is enabled or not.
   * 
   * This configuration is relevent only when handshake_type 
   * is set to HARDWARE. 
   * 
   * - 1 : RTS/CTS handshaking is enabled
   * - 0 : RTS/CTS handshaking is disabled i.e. Value of RTS/CTS pin
   *       is don't care
   * .
   * <b>Configuration Type: </b> Static
   */
  rand bit enable_rts_cts_handshake = 1'b1; 
  
  /**
   * @groupname  hardware_handshake_cfg <br/>
   * Specify whether DTR/DSR handshake is enabled or not.
   * 
   * This configuration is relevent only when handshake_type 
   * is set to HARDWARE. 
   * 
   * - 1 : DTR/DSR handshaking is enabled
   * - 0 : DTR/DSR handshaking is disabled i.e. Value of DTR/DSR pin
   *       is don't care
   * .
   * <b>Configuration Type: </b> Static
   */
  rand bit enable_dtr_dsr_handshake = 1'b1;
   
  /**
   * @groupname  software_handshake_cfg <br/>
   * Specify Data pattern for XON packet
   * 
   * This configuration is relevent only when handshake_type is 
   * set to SOFTWARE. In SOFTWARE handshake type handshaking is performed
   * through XON/XOFF packet, which has unique data pattern. This configuration
   * defines the data pattern for XON packet.
   * 
   * Width of XON data pattern should be set equal to width specified by data_width
   * configuration attribute.
   * 
   * <b>Configuration Type: </b> Dynamic
   */
  rand bit [8:0] data_pattern_xon = 9'd11;
  
  /**
   * @groupname  software_handshake_cfg <br/>
   * Specify Data pattern for XOFF packet
   * 
   * This configuration is relevent only when handshake_type is 
   * set to SOFTWARE. In SOFTWARE handshake type handshaking is performed
   * through XON/XOFF packet, which has unique data pattern. This configuration
   * defines the data pattern for XOFF packet.
   * 
   * Width of XOFF data pattern should be set equal to width specified by data_width
   * configuration attribute.
   * 
   * <b>Configuration Type: </b> Dynamic
   */
  rand bit [8:0] data_pattern_xoff = 9'd13;
  
  /** 
   * @groupname  software_handshake_cfg <br/>
   * Specify Maximum delay allowed between XOFF and XON packet.
   * 
   * This configuration is relevent only when handshake_type is 
   * set to SOFTWARE.
   * 
   * For reasonable constraint please refer to #reasonable_max_delay_to_xon_after_xoff
   * 
   * <b>Configuration Type: </b> Static
   */
  rand bit [31:0] max_delay_to_xon_after_xoff = 9000;
  
  /** 
   * @groupname  software_handshake_cfg <br/>
   * Specify whether DTE will wait for XON packet to start transmission after<br/>
   * power up or not
   * 
   * - 1'b1 : DTE wait for XON pattern from DCE before sending the first <br/>
   *          transaction after power up <br/>
   * - 1'b0 : DTE does not wait for XON pattern from DCE before sending the <br/>
   *          first transaction after power up
   * .
   * 
   * <b>Configuration Type: </b> Static
   */
  rand bit enable_dte_wait_for_xon_after_power_up = 1'b0;
  
  /** 
   * Specify type of handshake used
   * 
   * - HARDWARE : Hardware pins RTS/CTS and DTR/DSR are used to perform
   *              handshaking. However either RTS/CTS, DTR/DSR or both
   *              handshaking can be enabled or disable through 
   *              enable_rts_cts_handshake and enable_dtr_dsr_handshake
   *              attributes
   * 
   * - SOFTWARE : Data packets XON and XOFF are used to perform handshaking.
   *              Attributes data_pattern_xon and data_pattern_xoff are used to
   *              set data patterns for XON and XOFF packets repectively.
   *              In software handshaking status of pins RTS/CTS and DTR/DSR 
   *              are not relevent
   * .
   * 
   * <b>Configuration Type: </b> Static
   */
  rand handshake_type_enum handshake_type = HARDWARE;

  /** 
   * Specify the divisor to divide input/reference clock for generating X16Baud clock<br/>
   * 
   * Input/reference clock is divided by the value specified by baud_divisor, to generate
   * X16Baud clock. Any value between 1 to 65535 is supported.
   * 
   * For reasonable constraint please refer to #reasonable_baud_divisor
   * 
   * <b>Configuration Type: </b> Static
   */
  rand int baud_divisor = 1;
  
  /** 
   * Controls output pin "baudout" of VIP
   * 
   * - 1 : Enable driving of baudout pin i.e. VIP drives its
   *       baud clock to output pin baudout
   * 
   * - 0 : Disable driving of baudout pin i.e. VIP doesn't drives its
   *       baud clock to output pin baudout
   * .
   * 
   * <b>Configuration Type: </b> Static
   */
  rand bit enable_drive_baudout_pin = 0;
  
  /** 
   * Specify the size of receiver buffer(FIFO)
   * 
   * VIP supports reveiver buffer which is used to store the received packet.
   * This variable specify the size of receiver buffer.
   * 
   * For reasonable constraint please refer to #reasonable_receiver_buffer_size
   * 
   * <b>Configuration Type: </b> Static
   */
  rand int receiver_buffer_size = 10;

  /**
   * Enables the fractional baud rate generator to generate the BaudX16
   * clock<br/>
   * - 1 : Enables the fractional baud rate generator
   *
   * - 0 : Disables the fractional baud rate generator
   *
   * .
   *
   * <b>Configuration Type: </b> Static
   */ 
  rand bit enable_fractional_brd = `SVT_UART_ENABLE_FRACTIONAL_BRD_DEFAULT;

  /**
   * This configuration is relevant only when enable_fractional_brd is set to
   * 1
   * 
   * Specifies the fractional part of the divisor value to divide
   * input/reference clock for generating BaudX16 clock<br/>
   *
   * For example, if the value of baud_divisor is 1 and the value of
   * fractional_divisor is 5, then the divisor value will be 1.5
   *
   * For reasonable constraint please refere to #reasonable_fractional_divisor
   *
   * <b>Configuration Type: </b> Static
   */ 
  rand int fractional_divisor = `SVT_UART_FRACTIONAL_DIVISOR_DEFAULT;

  /**
   * This configuration is relevant only when enable_fractional_brd is set to
   * 1
   * 
   * Specifies the number of baudX16 clock cycles over which the value of
   * fractional_divisor holds true
   *
   * The division of input/reference clock is based on the value of 'mult' and
   * 'baud_divisor', where mult is
   * fractional_divisor*fractional_divisor_period.
   * 
   * For each of the 'mult' number of BaudX16 cycles, the reference clock is
   * divided by 'baud_divisor+1', and for each of the
   * 'fractional_divisor_period-mult' number of baudX16 cycles the reference
   * clock is divided by 'baud_divisor'.
   * 
   * For example, if fractional_divisor is 5 and fractional_divisor_period is 16, then mult
   * is 0.5*16, i.e. 8
   *
   * For reasonable constraint please refer to
   * #reasonable_fractional_divisor_period
   *
   * <b>Configuration Type: </b> Static
   */ 
  rand int fractional_divisor_period = `SVT_UART_FRACTIONAL_DIVISOR_PERIOD_DEFAULT;

  /**
   * This configuration is relevant only when enable_fractional_brd is set to
   * 1
   *
   * Specifies the fractional value over which the value of 'mult' (where
   * mult is fractional_divisor*fractional_divisor_period) will be rounded off
   * to the nearest integer
   *
   * For example, if the value of fractional_mult_median is 50, and the value of mult comes
   * out to be 6.51, then mult will be rounded off to 7, as the value of
   * fractional_mult_median will be considered as 0.50. If the value of mult
   * is less than or equal to 6.50, then mult will be rounded off to 6.
   *
   * For reasonable constraint please refer to
   * #reasonable_fractional_mult_median
   *
   * <b>Configuration Type: </b> Static
   */ 
  rand int fractional_mult_median = `SVT_UART_FRACTIONAL_MULT_MEDIAN_DEFAULT;
  
  /**
   * This is the time when the first framing symbol is started and will equal
   * the #start_time attribute.
   */
  real config_start_time;

  /**
   * This is the time when the last symbol of the packet is ended. Last symbol
   * can be the last Header Packet symbol for non-data packet or last DPP symbol
   * for data packet.
   */
  real config_end_time;

  /**
   * This configures the number of baudX16 cycles for which a UART data bit
   * lasts on the bus, which inturn affects the baud rate at which the UART
   * transaction is taking place.
   */
  rand int sample_rate = `SVT_UART_SAMPLE_RATE_DEFAULT;

  /** 
   * This configures the receiver device to resync itself with respect to the data
   * received at each byte. This is to support configurations wherein the
   * receiving and transmitting devices are configured with different
   * sample rates.
   * <b>Configuration Type: </b> Static
   */
  bit resync_rx_at_each_byte = 1;

  /** 
   * This configuration allows receiver buffer to accept 1 more data while receiver model de-assert its RTS/CTS output at middle of last stop bit 
   * Also allows Transmitter to drive next packet if input CTS HIGH is sampled after middle of last stop bit. 
   * For cases where TX samples input CTS HIGH before middle of last stop bit, new packet will not be driven.
   * When disabled , Receiver de-assert RTS/CTS output when its buffer is full and no data is accepted with CTS HIGH(Default).
   * <b>Configuration Type: </b> Static
   * <ul>
   *   <li> <b>Note</b>: Set receiver_buffer_size greater than 1 and handshake_type is 'HARDWARE". 
   * </ul>
   */
  bit allow_autoflow_trigger_rx_buffer = 0;

  /** 
   * Determines whether to enable rs485 associated checker rules. 
   * <b>Configuration Type: </b> Static
   */
  rand bit enable_rs485 = 0;
  /** 
   * Determines whether de signal is active high or active low
   *
   * <b>Configuration Type: </b> Static
   */
  rand bit de_polarity = 1;

  /**
   * Determines whether re signal is active high or active low
   *
   * <b>Configuration Type: </b> Static
   */
  rand bit re_polarity = 1;

  /**
   * The assertion time is the time between the activation of the DE signal
   * and the beginning of the START bit. The value represented is in terms of serial clock cycles
   *
   * <b>Configuration Type: </b> Static
   */
	rand bit [7:0]  de_assertion_delay = 8'h5; 

  /**
   * The de-assertion time is the time between the end of the last stop
   * bit, in a transmitted character, and the de-activation of the DE signal. The value represented is in
   * terms of serial clock cycles.
   *
   * <b>Configuration Type: </b> Static
   */
	rand bit [7:0]  de_deassertion_delay = 8'h5; 

//  /** 
//   * The assertion time is the time between the activation of the RE signal
//   * and the beginning of the START bit. The value represented is in terms of serial clock cycles
//
//   * <b>Configuration Type: </b> Static
//   */
//	rand bit [7:0]  re_assertion_delay = 8'h5; 
//
//  /** 
//   * The de-assertion time is the time between the end of the last stop
//   * bit, in a recieved character, and the de-activation of the RE signal. The value represented is in
//   * terms of serial clock cycles.
//
//   * <b>Configuration Type: </b> Static
//   */
//	rand bit [7:0]  re_deassertion_delay = 8'h5;

  /** 
   * If any transmit transfer is ongoing, then the signal waits until transmit has finished and after the
   * turnaround time counter ('de to re') has elapsed.
   *
   * <b>Configuration Type: </b> Static
   */
	rand bit [15:0] de_to_re_TAT = 8'ha;

  /** 
   * If any receive transfer is ongoing, then the signal waits until receive has finished, and after the
   * turnaround time counter ('re to de') has elapsed
   *
   * <b>Configuration Type: </b> Static
   */
	rand bit [15:0] re_to_de_TAT = 8'ha;

  /** 
   * RS485_FULL_DUPLEX : The full duplex mode supports both transmit and receive transfers simultaneously.
   *                     The user can choose when to transmit or when to receive. 
   *                     Both 're' and 'de' can be simultaneosly asserted or de-asserted at any time.
   *                     No take care of turnaround timing.
   *
   * RS485_HALF_DUPLEX : The half duplex mode supports either transmit or receive transfers at a time 
   *                     but not both simultaneously.
   *                     In this mode, it must be insured that a proper turnaround time is maintained
   *                     while switching from 're' to 'de' or from 'de' to 're'
   *
   * <b>Configuration Type: </b> Static
   */
  rand uart_rs485_transfer_mode_enum uart_rs485_transfer_mode = RS485_FULL_DUPLEX;

  /** 
   * Determines whether to dessert rts/cts before/at middle(sampling point) of last stop bit.
   * 0: rts/cts will dessert at the middle of last stop bit. Applicable for both autoflow and non-autoflow model.
   * 1: rts/cts will dessert at the middle of parity bit. Applicable for autoflow model only.
   * 2: rts/cts will dessert at the middle of start bit. Applicable for both autoflow and non-autoflow model.
   * <b>type:</b> Static
   */
  bit [1:0] deassert_autoflow_hndshk_before_stop_bit = 2'h0;

 /**
   * This Configuration is relevant only when  handshake_type is set to SOFTWARE.</br>
   * Specify the packet count after which the XOFF pattern will be sent</br>
   * NOTE: If it is 0 then VIP will send an xoff pattern when receiver buffer is completely full. 
   */
  rand int pkt_cnt_to_send_xoff_pattern = 0; 

`ifndef __SVDOC__
 /**
   * This Configuration is used for inserting exception in SOFTWARE handshake_type </br>
   * This configuration is valid only when pkt_cnt_to_send_xoff_pattern is non zero and is currently valid for internal varification.
   * We will communicate it to customer later.
   * 0:dte stops transaction at reception of packets equal to receiver_buffer_size
   * 1:dte stops transaction at reception of packets equal to receiver_buffer_size+1
   * 2:dte stops transaction at reception of packets equal to receiver_buffer_size-1
   * NOTE:define SVT_UART_DTE_NEW_SOFTWARE_MODE macro to get this
   * functionality as this logic is part of dte side.
   */
  rand bit [1:0] pkt_cnt_to_send_xoff_pattern_exception = 0; 
  
  /** Port interface */
  svt_uart_vif uart_if;
`endif
   
  /** 
   * Constraint for valid_ranges <br/>
   * valid_ranges constraints prevent illegal and/or not supported by the Protocol & VIP.
   * These should ONLY be disabled if the parameters covered by them are turned off. 
   * If these are turned off without the constraints being turned off it can lead to problems 
   * during randomization. </br>
   * In situations involving extended classes, issues with name conflicts can arise. 
   * If the extended (e.g., cust_svt_uart_configuration) and base 
   * (e.g., svt_uart_configuration) classes both use the same ‘valid_ranges’ constraint 
   * name, then the ‘valid_ranges’ constraint in the extended class 
   * (e.g., cust_svt_uart_configuration), will override the ‘valid_ranges’ constraint 
   * in the base class (e.g., svt_uart_configuration). Because the valid_ranges constraints 
   * must be retained most of the time, classes extensions should prefix the name of the 
   * constraint block to ensure uniqueness, e.g. “cust_valid_ranges”.
   */
  constraint valid_ranges 
  {
    baud_divisor inside {[`SVT_UART_MIN_BAUD_DIVISOR:`SVT_UART_MAX_BAUD_DIVISOR]};
    receiver_buffer_size inside {[`SVT_UART_MIN_RX_BUFFER_SIZE:`SVT_UART_MAX_RX_BUFFER_SIZE]};
    max_delay_to_xon_after_xoff inside {[`SVT_UART_MAX_DELAY_XON_XOFF_MIN_VAL:`SVT_UART_MAX_DELAY_XON_XOFF_MAX_VAL]};
    fractional_divisor inside {[`SVT_UART_MIN_FRACTIONAL_DIVISOR:`SVT_UART_MAX_FRACTIONAL_DIVISOR]};
    fractional_divisor_period inside {[`SVT_UART_MIN_FRACTIONAL_DIVISOR_PERIOD:`SVT_UART_MAX_FRACTIONAL_DIVISOR_PERIOD]};
    fractional_mult_median inside {[`SVT_UART_MIN_FRACTIONAL_MULT_MEDIAN:`SVT_UART_MAX_FRACTIONAL_MULT_MEDIAN]};
    solve receiver_buffer_size before pkt_cnt_to_send_xoff_pattern;
    pkt_cnt_to_send_xoff_pattern inside {[0:receiver_buffer_size-1]};
    pkt_cnt_to_send_xoff_pattern_exception inside {[0:2]};
    // To constraint the value of data_pattern_xon and data_pattern_xoff to
    // make sure that their value is not equal to 0
    data_pattern_xon != 0;
    data_pattern_xoff != 0;

    sample_rate inside {[`SVT_UART_MIN_SAMPLE_RATE:`SVT_UART_MAX_SAMPLE_RATE]};
    
    data_pattern_xoff != data_pattern_xon;
    // To constraint length of data_pattern_xon and data_pattern_xoff to make
    // sure that it does not cross length specified by the data_width
    (data_width == FIVE_BIT)  -> data_pattern_xon[8:5]  == 4'b0;
    (data_width == FIVE_BIT)  -> data_pattern_xoff[8:5] == 4'b0;
    (data_width == SIX_BIT)   -> data_pattern_xon[8:6]  == 3'b0;
    (data_width == SIX_BIT)   -> data_pattern_xoff[8:6] == 3'b0;
    (data_width == SEVEN_BIT) -> data_pattern_xon[8:7]  == 2'b0;
    (data_width == SEVEN_BIT) -> data_pattern_xoff[8:7] == 2'b0;
    (data_width == EIGHT_BIT) -> data_pattern_xon[8]    == 1'b0;
    (data_width == EIGHT_BIT) -> data_pattern_xoff[8]   == 1'b0;
  }
     
  /** 
   * Reasonable constraint for #baud_divisor
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_baud_divisor 
  {
    baud_divisor inside {[1:10]};
  }
  
  /** 
   * Reasonable constraint for #max_delay_to_xon_after_xoff
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_max_delay_to_xon_after_xoff 
  {
    max_delay_to_xon_after_xoff inside {[2000:99999]};
  }
   
  /** 
   * Reasonable constraint for #receiver_buffer_size
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_receiver_buffer_size 
  {
    receiver_buffer_size inside {[1:16]};
  }

  /** 
   * Reasonable constraint for #fractional_divisor
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_fractional_divisor
  {
    fractional_divisor inside {[1:99]};
  }

  /** 
   * Reasonable constraint for #fractional_divisor_period
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_fractional_divisor_period
  {
    fractional_divisor_period inside {[16:256]};
  }

  /** 
   * Reasonable constraint for #fractional_mult_median
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_fractional_mult_median
  {
    fractional_mult_median inside {[10:90]};
  }

  /** 
   * Reasonable constraint for #sample_rate
   * This constraint is ON by default; reasonable constraints can be
   * enabled/disabled as a block via the #reasonable_constraint_mode method.
   *
   * To see the reasonable constraint code, use the link to the line number
   * below.
   */
  constraint reasonable_sample_rate
  {
    sample_rate == 16;
  }

  //-------------------------------------------------------------------------------------------------
  // new()
  //-------------------------------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_uart_configuration", svt_uart_vif uart_if=null);
   
  //************************************************************************************************
  //   SVT shorthand macros 
  //************************************************************************************************
  `svt_data_member_begin(svt_uart_configuration)
    `ifdef SVT_UVM_TECHNOLOGY
      `svt_field_object(hw_xtor_cfg, `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
    `endif
    `svt_field_enum( parity_type_enum,parity_type           ,`SVT_ALL_ON)
    `svt_field_enum( stop_bit_enum,stop_bit                 ,`SVT_ALL_ON)
    `svt_field_enum( data_width_enum,data_width             ,`SVT_ALL_ON)
    `svt_field_enum( handshake_type_enum,handshake_type     ,`SVT_ALL_ON)
    `svt_field_int ( enable_dtr_dsr_handshake               ,`SVT_ALL_ON)
    `svt_field_int ( enable_rts_cts_handshake               ,`SVT_ALL_ON)
    `svt_field_int ( data_pattern_xon                       ,`SVT_ALL_ON)
    `svt_field_int ( data_pattern_xoff                      ,`SVT_ALL_ON)
    `svt_field_int ( max_delay_to_xon_after_xoff            ,`SVT_ALL_ON)
    `svt_field_int ( enable_dte_wait_for_xon_after_power_up ,`SVT_ALL_ON)
    `svt_field_int ( enable_tx_rx_handshake                 ,`SVT_ALL_ON)
    `svt_field_int ( enable_put_response                    ,`SVT_ALL_ON)      
    `svt_field_int ( baud_divisor                           ,`SVT_ALL_ON)
    `svt_field_int ( receiver_buffer_size                   ,`SVT_ALL_ON)
    `svt_field_int ( enable_drive_baudout_pin               ,`SVT_ALL_ON)
    `svt_field_int ( enable_fractional_brd                  ,`SVT_ALL_ON)
    `svt_field_int ( fractional_divisor                     ,`SVT_ALL_ON)
    `svt_field_int ( fractional_divisor_period              ,`SVT_ALL_ON)
    `svt_field_int ( fractional_mult_median                 ,`SVT_ALL_ON)
    `svt_field_int ( sample_rate                            ,`SVT_ALL_ON)
    `svt_field_int ( resync_rx_at_each_byte                 ,`SVT_ALL_ON)
    `svt_field_int ( allow_autoflow_trigger_rx_buffer       ,`SVT_ALL_ON)
    `svt_field_int ( enable_rs485                           ,`SVT_ALL_ON)
    `svt_field_int ( de_polarity                            ,`SVT_ALL_ON)
    `svt_field_int ( re_polarity                            ,`SVT_ALL_ON)
    `svt_field_int ( de_assertion_delay                     ,`SVT_ALL_ON)
    `svt_field_int ( de_deassertion_delay                   ,`SVT_ALL_ON)
    //`svt_field_int ( re_assertion_delay                     ,`SVT_ALL_ON)
    //`svt_field_int ( re_deassertion_delay                   ,`SVT_ALL_ON)
    `svt_field_int ( de_to_re_TAT                           ,`SVT_ALL_ON)
    `svt_field_int ( re_to_de_TAT                           ,`SVT_ALL_ON)
    `svt_field_enum( uart_rs485_transfer_mode_enum,uart_rs485_transfer_mode       ,`SVT_ALL_ON)
    `svt_field_int ( deassert_autoflow_hndshk_before_stop_bit  ,`SVT_ALL_ON)
    `svt_field_int ( pkt_cnt_to_send_xoff_pattern           ,`SVT_ALL_ON)
    `svt_field_int ( pkt_cnt_to_send_xoff_pattern_exception ,`SVT_ALL_ON)
    // ****************************************************************************
    // XML
    // ****************************************************************************
    `svt_field_real(config_start_time,`SVT_ALL_ON|`SVT_NOPRINT)
    `svt_field_real(config_end_time,`SVT_ALL_ON|`SVT_NOPRINT)
    // ****************************************************************************
  `svt_data_member_end(svt_uart_configuration)

  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
 
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  /** Used to limit a copy to the static configuration members of the object.*/
  extern virtual function void copy_static_data (`SVT_DATA_BASE_TYPE to);

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
   * Method to turn static config param randomization on/off as a block.
   * This method is <b>not implemented</b> in this virtual class.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
   * Assigns a interface to this configuration.
   *
   * @param uart_if Interface for the UART configuration
   */
  extern function void set_uart_if(svt_uart_vif uart_if);
  
  // ---------------------------------------------------------------------------
   /**
   * This method returns a string for use in the XML object block which provides
   * basic information about the object. The transaction extension adds begin
   * and end time information to the object block description provided by the
   * base class.
   *
   * @param uid Optional string indicating the unique identification for the object. If not provided
   * uses the value from "get_uid' of base implementation.
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent.
   * @param channel Optional string indicating an object channel.
   *
   * @return The 'svt_pa_object_data' which will contain the PA object header information.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "",
                                                           string parent_uid = "", string channel = "");
   

endclass : svt_uart_configuration

`protected
J,WW;aW@OY-,L+]-fd)C;)6;P50c36@a&9I8B.D<bJ+<W=W>C;S\-)NG,0JHHJJV
Q,A^64)00a+WPW0H/34<\c@G1WTd#WPH_U6/=?1<QI.Q3Sa?+eT=\gV&eL,MRY.3
-K.SZUf#A8OMBR>-#[4G@NDGQf9c4@<.=KJF.8dU2(MLS4:5RKY1D@+T0c02\Q4X
e#@^CWE0;a7M6dadFX>7M6^Y0VO##2S1Q+ae,6\V:1P]RBe[AdIJ<3Z5V<WXBBH_
.@J>NT=cZPe/PW:2^T499I0N8@5T+g2OT-5,9:#3S\S-)MNI>1(a&X8f0O7cN[&b
BR=[_a#^/_/@,0O^S>cXZJ0WZQ,\6VZD(cS&bBN_:QB?b8f/gX&\O_Y#6]JDCcP(
4#a).>&2#>H1\8W+=0<AE.CKJQ+4CH:1S.\VPUB3b4;2IR4\WObaF.5)R;:B^=KA
d5]29,dN/G-CV+;7&S2YU+CK5$
`endprotected

  
//vcs_vip_protect 
`protected
d.P@-)()][5T2b90E6[1E4SN[QS/8;VUHZ]7>9?XZfC/1UfB(fCP-(H_aZUSMc#?
g\1@OJ7b\-[_2f9>/Xb+9MdA1_H#3DX6+Uc;9)]/0cD19TdX][&g9[/(W@Ia64YW
@.X@]M,\BTAIeUVZ8cf:5PQLD;Y4=)V]0P?A\W\=SU9+]e8M204-C#A1=Rbe,f?T
XP8\BaF2@CcQH@F9/b0XJXK95eR+O^,IEWOdPNcB\HgU9DLa<:f?fUde,adCJ=U+
@40N=XW^KMKb?e2eH/B<_Z[-=._?8T?4.Ce1;6>2.L:F),;(02MM0TZeSaXN_-#b
GX\LSIT8L3(#?UV26)LaKHeJbg-L8ZBgM;E5&Ef&7KX)/J98eK6gNMPU4JE5gIAO
S.VWB/Ga+YLd]N9D#\6&HRcWB5Qeb:PCT[XGPg]8VfFO>-a[]UE5NG3D(Me9-BIU
YIA^ZG?XM1Z;aD#-e3-S1\=7X-4Ec<LbNV9K/f+2RJPGG^-cJa59ceAf+Z[R?/D.
Y=]1A,]/c.=;R.3?Nb=?,<]f.>fF90F^H4X2->5I[+@MT@QOK)(V<(H26X?A6f0W
HZ+f40c]=UM_DPMcLP9gN2c#<[T(f57CA:8/#2^IJL#0345g#IUUQ)V@+7JCcI&-
IKE5<g5)[aJDdLINBB<c-g0H\B^1E[2c49N#f;^a6-Y>61dW+8dDc8G&JA-+J:Z(
@4Hb7E/KSZ_Jg@38GUSaW/:CO+:=M2WDU^^g/?1A:f/EXUUYHQ7QL@?V2d&?SJFT
EQD1RJ=156NGb3ROY]4=TGfW.^]J3eHgX@@=b-+[F_gaXFNfM_3,cC/X4#eg3H:I
3A?cf4:J?CMW>Nf0f.A+Sd6L.1FI=+Q/[(&g#+212f&680O+&M8+@IMHb9aL1Sbc
,]H+ZCgC#QaaZ<B^SeL3P8V]1T,cJZ-2?PQ;)fL(&Z&BJVS:TJJ^BT_bAFBXd2MY
7(S8\.H?aCI-cH)_A;;YLR,2d59ZFAJN<O(N[J18(<M#^c<(G,5R&4C,]H<J@PYN
TOG)5RW\KF>.VPX3HSU[U\I]NTPfO0I\bV(_XJEYe2=a6J\S&]=HDJ?7K.B6>0<-
cS:Q03=T?_(7@1[gX5N.&8[E@U[Z(ROeXVGBPXQUAO\fFB?^5L5ZH#FbYJ(g.bS6
TQC6/G<6<cWDF;SG(<Og0F2./KDRG=Ab+_).M.4=X[PNOe7b8Pb1=A-/@(701/K\
gRc,/;+YV+3:PK53/)7DXS/_>LG9BdPdQd21L-TO&ZAU9&YEI4X847@1U]3_9Dgc
R#VF,.dQWf55=)8T.dd.1fR_)A2Yab+]Ma)M(V@V8.NX-PZX+DICf3\IQ+&0QC#L
_:>[<FCG176e=R,R=P@EFB>UWg_A,_c(4/0S7DN1C7]dX1^XgfZLJE=A:T@H\K<9
>ENOYZO+^6)WCHa-)Og(eKJO9T#U2/S(976?)ZCRV/aXTJ#M5AOOY6ZQ[SI1M\57
aeF4PbN+HAOb=K0cZY;K65b\?JJU=d9d@M0V>IAR)?2,P#gU-,0eDPZ\#P96LA>#
L)YO0EVC326B:;&6]fSe9&5V)Z\,Neg=B^??MZH:/B)3D#85HB\RJ\.K#d0[G6NG
2K3@T#)(VM.QIEI:95<WIQ_T0]gOX9Wa./Fa8^2C&f,\[?:-@G7;>&/gTI4(O:##
O[U<PDBg6(B9b[Z]QA5]-KdF9&JdIc\fPa4#D+<B?JOMb6QBF/YW#C=Z5()5DfT+
c22HVOA(aW2X+(bY?DXNAE8[7@0]P>\@>63;C;LW34/>FF/^2^B@:A-f<gN#A.b/
NR2[,:#gW>&M-5)?g,YPOA7WgD9OQMJO7;6)9GZ4Dd<1?A()aE5e/LbK;[0-JYJY
1Y,<=_;0b[WSB)&)[Y_/8)YWS;VDA=T>9VGR)=OB;4^:g(X5GJ9/R7770gY1\8\e
IDAI9[AO@M2G>#^@>\_1FRS_F=PLOZPKWA&,QU6DO8>BV:c^\9U?.G-U63W7[-Gd
eeF_WL^-3VDEG>/KW1_GY@HNN<F?@X]H)WYU.6@6--2@VN2STKa+L1YFZ]a588&J
AbU;9+LZ#3_(X-]@H1YZf4^,BY1QUBP0Y:&V/##@HR1[a)1@\\[6dE5GPSRed/7R
3Oc).H\ZYW@cUCdfP4.Ng?_JR7fDL;CCRYZWcVBN-:8UKS[M)OCDLN8b:3X#>]=b
W]L2S+1YL9Q\b08D7NLXBEO),/+H:/A-bXe7WM6O\YG]58?(:^12eJW^7.SB/AP<
=B[8SFR6T;S1TDRW1/<8.+-:f1YP)&?P0)4^_4^RGa76WM@]M/<8dX(Tf[+,c(92
EdY+.9A-_[d?O>bBUCgLOf8)5@8-K@_04PS3P]=ad>,F>S2>?O)N&5(T+W5:XA8Q
FD>8Q+51S#&Y:YVQ^YW<6M3/6WGR;S2CSIfD9K+^IOD33;TU0ME&Ub.UVW7D4?C8
6:f8TOg#^(T,8&aV.cT)dMJ\KIgMLVc4?G=QgA#C/KZ4d6^;O_(;2K_.W6FRI:?e
7=@PE-EETS=L]F(a#_\C=g<((+6486+._7F7?&B,g(Zb8XO0JM),+YFK)].UTBZ2
-9[B].&bg1@2_5V]SVZDPLeASF.8);Q]/gW(X?DV&68dQ=CVPfGKGc2Wd?1@gL6U
L=E4O49c[&;9K,U1Qac[@Sbb-H7c0Q2SAPGXV4e7FKGC2@MTHa,dT;>T(\ZT:H7.
MQ?QcFTR-:PN/(gT0f/,2DBL]C_Pc[=4f\QR\W?SE1Te?aBe+E:A+@N=_TB-S/^V
7_?cP.1[8B3#^Hc6;W3#P@.05PWTJc:H#gQ-M7.3Sd5@&Z6&N\6G.2TJgH3EXI#-
H=_]/6feJWf.6A-IMf(&G4](NaD,ZO7Ed/F(,cg<E)Y(d6VU;9XVK42Q+[0ZC(bI
gfS[QBNMaO^?O6(0dI.aYT8fM[/aTYKUC_T2bKAKYKI25>DE=dA/]e?XEASZN@Q1
+G7^a2.I:9-b/7E)SgZ.E3ZN0aO[?EK^bUTE@/AAG/dC4<)D1W&)_[=7];ME.W>K
<2P>>.CQ\aSf>W/fgbDTb8bNN<PQD557:S/V]Te@D=+&..5P+1Mf#-BMH5@AO<E:
L:?^.Y#F@QN=8[5g5S#bB42N)@OBT-,-PVgeb)UOaR@/-,C</>K?Y@QSf7&O(TRK
?\Dcf]X9-UR,^GG2ZX>@S-M<2[T,7_<-GP;-cP^NEKESQ,XaAaX2JPXE+B4GL56U
ZN5#e_=T&N&+UO=/X&G1(JFc(#.-D.FW\FH=6YfCD:XAABOFRL.H2d.XNRN)FB14
[8aC>4K8H96eQX40b4?DIA<D;&Zf@bdDE]6f_aKQN<IN:Jf]&Y0<:Z4g)M/,63Y=
RMaNOQL[CO\GQ6eB=>@dIS0N3\Ca2CcbC64;[4RQcU;GaU9NWB?&,-N2GCaeOAK9
ZdC6^3fg;S(BcS\..YgS2\9WO#,:f;//FPfV8G&LdeP(&RH^:Q.Yb1DQf3c.#+\(
8R7d\UcTN82?>0\FW02DX/M4=9940cRF2#21)9CB^1+[FGHQK()XQJN>A98LV:PR
.LXSQE:?#_2CSU;JA3e15[V/6<)<+MD]3c?Q5BLI/],Qa:5IH80MI4#-\U@QTeAU
;FFP)V8D74#6]a)N]?P#UBFMa#X\[HJ^=WFGF?^#XUb8LE^cd(ZeAa[N6)8Uf@<-
X;-;_J9QT7SP,J)0+C.FW+T8:WMeIcC5U8CESC.e#[+IW>g]GIS,?FQE_;+4Hb;P
QV5(W11[E/b5)5@:344]Z;7I9b8KIXO^c;=:g7Ncf0_3EbS]Q@R=3\I&7N0DM=R>
7;BcBLK&6TOcF&JZ.<DWL8]&J\NcZ7YCVC,BU_AHO\KT2UOM9E(LDZQ+I&X4Ue_5
S(<UO=TVE2D-&a\R7C\C8[e7ZQ3=gRR3Y=3W0fcV7M7:OW8=N9L9<U^)3;GWNS7L
U(2-@)Va,)Ac=Ja-_UcWCaa__W:U7GKR5V#J2)?CLP=:;=L8(I&_@Y(&.UA&N3KU
45.a@b9^,Z^]Bg.?81fg&\S,37]:_S5dSUf21N+T8]1>:[AD)B=\R)@ET[e(e;cY
cO+e.a0^V5<:2^#^9N)K@U,\I;3^&/OE)DH2bNPZ&=.(5D6:)<LRa@X[D=Y@^YUQ
A\G3U^.M9\AZX0^(3;P(.X@,2e=D,X>2SS0dS&9Wa+.#);43;D7QV\>L<fX5cS1S
+ef4-6e+N0.S1g9]M)Y(ZO+Q6DIaVgbAMWUgPH\8Z[cS?Y_(F>D@/3:D..5W+cN3
8/&R1CF;5J6OCHA.ATMd@-6(EOMZ7=);Q53X6-O@L4\b-TH=2<JF6dNI3c)-/S\a
Y9V5FNF23CP<SXQ0T?6K7PXQA1IAWC:Pd,dDZLI=NE:aE2S;GE@QMHT#A_6@A3/:
=c[a8ED_QR1GR[.[XeHK:S\?YZ;(4WL&;]#H<.gV/O=eaBQBb=#??<8#S_JETDTF
FA+HUN1VPc-[\O9aXg^4MS2.:T#/IPG->3eGTK647YO^fQQW[e#J=B^b&8d09C+X
</2[X:1@DZ+bfU<ZOZK0d)?fNUg=B<CKEW+##PeM+8bK;)AI<gbg0W\>Xd]JGdR?
\>F\BZF-4YC\]_:)#AV6R<QJC9W49a#]8Rd28@54[dI98(#a0<1IKIb6G:DXe4B6
dbY@X((a9C2;]V0MUB6##L8HFS-aVBaHa)^T.VdR@U@bWV;<VTJ1H-GTf^91::bP
&>V52L/F^)>DW:;4R3R-0,e#\R6NB+]=HGdFIg:\TVH,/UdHC2_bN_>C18[_b7]3
2II_P=JTG+R95A/&-DaI@_G;,]6+W>@/f1C(YE-AM=W4Q/IPMdVfWf6H_XTO)R9(
3LeU4=7GaJ3]:#G=M;?J2eV46P4D3.,H+^SgJ6.AN?\c4/[M42(GGXE8<=df7\46
T(:f7:3dgZ-AR6fW_KC:cG=7BgTYTdH)ZG)N4b/:+3OH&S,GN<d(KdgRXG48Yc]7
NS.QA=H<ADIOLV2;KB49#gMA_D8b=G8^I:Z1H)A0d_47@@;9bGTC_1FF/aW;PcL(
YD-I-8W.03<P_IOBK9QD5adDb;BEZRE..a+;dW\aGMSXR=,#cB&aaW0>UP?FYGWC
fPZN^V-JLL>?V,cCWNL]\MDXHFMaV-f<300MAg>[d9F(9U[9BRg:b/CQ13Q[(_>X
1X:KS0Z#9S?1C3B@;8J7#WU&BV47IaeD0Z3EY(Ccf=E<Oc;eB3Yf/=e9@]K]9@(Y
_QJBFJ(g.VeFPO9\c</,[)Ng<_#L/gG8_9OCKFBM7Wa>b,acG]D?a&d)R()2CE?2
b,HYN@UdL/AO]SXB3E@.8ZN?[5P7<M9_9#0C(82V)L9aaML3BA?)A4\M0LQ?<fOK
8P5/G8B3EA5T]BVB6L_Mg6.fFN.I1S(,OH.(]PH1REcf@^#KccOKDbe>G->97@3Q
>K#J#::C5fK6._PHGH]5RGgfGQ-XW:=M9(4OX70aZb_<O6C]9ED>OL+4ERK6VL[J
5UCGI,@#f65>^;aS^B=Q@d,2;/^NIDC8X;2I;,W&O]]NDE-V=7#3gP>&-6.1)G^d
OAL[F.;-E56N)H,]27=US,)+GCC),)ZJR<]&-),(@U^eJDIXMOeH-W35V0aNUeZZ
5C/d]H_2S,6VK5UV<NKTQ>Ib&(_17]X=LaeINWS?Ebc5Y5-,AfcHU9,IVBbGNNg5
Wc)[YGdBZ?&I/QYc17KWG[.5VL,FUADP,[O)P&B8\5\UQL#J?B=OBDK;M&5cfI-0
?,;fJZQ\,=-0+NI?^S:G3VYXP;a9@#&db1)dZY-I:g?#]1OIMA8H+6Ng^K\TKWXS
J-8)D9-R=::.?Z#JI,Gf[bDQN,5&X7MT^8e+?S8]BL-S#1OJOUHb(N2#;9S7_8_C
+De3H@C+V4E.Q_6b>OJ2LS+5F6:;IX4()6NDeRK@Zg.&g6]\?IATgVaL3ZE8#K2E
MPY4^U>,YXPRE(4<UHd,A&N.O:;gWC5[AZA+gM@Z]CAEDVF<2Kb)X>PR-]a,T(\Y
VU+&5,1Q5:^2ZVaMKW@917W1U53\RWV.cJXB4;,4bCe/C#_P?X9)B/BZVRMb21;]
D:[TV]^U0IKD?ca)H8B#>CgC0[<[WJdY_YADP^/+\0C4eOG4E6gUS+BZ3^ST59RN
2g#K899H1@X7ICN\<JR\c#38C4.bO--19H#EB;OQRHK7T50>IUK,0A/;E]?(3<)(
&.7R&=3TTJg=</ecYJgNV083JSTN+/X9A-<(<MAUC0XQW5=&<&NVd+SJJE97<.ST
=]JA]Q(VgaQUZ-,ZH0BA_48a#JIT-BNO_;<ULONT<F\_;L;1D,P]dYH?G(>#c2fA
J#c>,7XY)/X#@-.cGJI/eLWaa<8^R2H[2W09>;e3-agDMZ17,bcNFW:]Q.gS3Nc,
M_<]JHeQSeP?_9&?[L=6/70]X6;49^UFH(67U7<(b.=T1e&d7]37X-JLQV@RX)Xf
YKIT-\1_3>/FCF;ZRULNL#1:=4?cF4AW@0HYR^)]?^1.V066fDG2cgE(2[K;;V^#
>04F9.668[P0GV:K)/(L_7F^UO,#.EX8RH6R_\X=RE=O/-+SL2f\C-+6ZV=-@MfO
=+;]?MaL[;XG3?V;@D0bfBK:>?1GfeT)19V\c^_&(0C5B.A,MMYQeKWSgg9[EPR?
W\G\Cd(87-ca_-;.71_PJDI#(b]1H4E-BZ?M9:ULFEdW^:\8=>2eLBVLDd&9TGU2
VSP,7MBURC#GH4Y06e\?I>cdWa;][e.(09X^0cBeBA>VdC@BfE6\1BcW2(<eBb3F
^eVgNgJOEZIK5F1FgR@R&,^_g+:E(R:;S0T=87PZeNI<OSIbPUNJG2SN2<[_dK^<
<34c&@T_Y:174@J-0;2\.247W5+g\aa[FQ(_<53HY99NI&BWN<]a>[LMSWb&+^#c
/7=VIZ<GeCRLQ[=\XI^().?2SJ@VgWD9-BY89&7T/@9TcY4[43Za(^PZF+Q-XJc[
HANKJeY)Db+M\&A5dX/2NVg&91KLDM+IA.@L+<I>4<--bV,1CXZSM04O>[Y2T/]P
C+FLIg,dOX1.(Af=Ea8+M@AIO[/gN(6b?2M3eM/.=SA#_F8L0<Q>D#WG[N@gMY(0
]6gFRI.M?e.34J>=W&WWER4_,K]A[F+@I<-ND9F2NB[H2E:EgN/72Y8CTF0Kgf9Z
a4)cJE@VeURJFY)OJ5/:RM0CQDcNT9N3I_LC=A7bP=VcUQBN1gcFd1eCfP&f;?LO
gYNBdL;_YSUE4[W76_E2^GDQGbAV)6fS[+c3XKL7M@./J_E8?S=UU838<&]_<&d-
fUQgP#@0Ka<?_:U(^YC(=:YTC&EB2:_?<V4[T3fNFf1I5ObASS5I=)AW\]_NH\>:
>;Z)I>4f8?GJ^b6A^V_C=8WO8PV_eL2OYW3Q+L?b.>gVQ,S9;bJMaMVRY(I.B4)?
S4M<J_X3J]QQe[G^^f]G:0_7KEHg)d;9+&=YY-#Ie@G,bJ]9J1R-VLddDWP&4LJH
)=^QNV:cD7<8KJ(S>>W&XKZCJY<Ta^gg)Y:0WDW;Y&=]^-E[/ccTd8J\&eaS3IJ]
[b\^\7\b,ZDF[0c@^S,M(^g:T(=T=1WMLf,58KFPR;f996?YJ7XS?G\1TXWIC[FY
3@N#Mg+f_^UHHRV3R:DXJ65e;/T?8\4SAM_^B1LHAg]N5#GVc\L=A+LVV5NFO5S4
dM&[J6A\R0OZA@6YQWfX?+6SCEW>5&W88<>69YJe2/==VTd>N3.\^c.AV-;g7bEe
a:GU+&g/&3bN[)JOBJMHFd>JQF(LGQN>,>f<XP,P^N?2HKZd7><e,S0,](/d]b2C
U:@RDNJO+-YbD+ffO(#?J,D<N]a#;QJ;O:]cK4G@K6&:O_IT?.@#aEJcWWZFE54W
J_7TF;<HL2[d.]b<H=bgH0.:XN\NeLP\B,WT-2Qd?P2,fe42-,?3bIW2(#\YUV5a
=_SV>=RNKFTES])J@_G1(Z;CXS]PeY++cL]^1#08U&80/W8&W^c;dHQH^]2S,03e
SZQ?ebUg_1:3J:X.==;0Q2gEJ,Z?29I4Pb-3JM#F]8<VJ7H,IG1;[SX?,H;FG7A)
D&)FP#\,Ga)X6&]a>4_C?&P9fQ)FSAd0?N^A)(g6=#EMEA4,_&bgCUPeCX>/&TE,
ARX57gDBPIZW0\M36DGX^T/Gb>)RBT\6d=):>LNGZU0:KB;>Y&Wb#E=b^J&@]GD/
SLCg/6L-,=4:9FY&\+(b1#CX\N5,=.Y0/E=(O..H_L@7()S;;1ZSK[7<_V&=cBRf
[&E_CENOd@E_MGdAKG#JOL/<[/OAWH&<&+<[_,#6F6V^?L^S5TgI(#E>6E<&\ZV9
Ec\.]U9CY7e#g@RTYYfGQ\A4O,3VFPM]+],c@_Q5(b4]I3]?;E3FR0_(P]fcV,P;
Kbe?=YM9dOD^-C<JIQd6[I4dEXd^5=QWA0\2V0Gf7eUcMW6QQ;Jg?dc4SS&]E-T+
^7/F]4#[CfU&U/b@Z6X@:F@E?ZU59e=a3Z/.6Y7/;0CB:2B^;(@F9B2ZcB\[?=MF
1[U7KIS&YJD>QMK?=fCJa3O([EB\D-c>aeb72aS@=VO58>4g2&Y\>N[1K4eN4^]#
<cXRXbMJP6VF]-I92<dG)9:Db9NE^Hd[N?^+.Y<3WZaNO<Q@DdI]T76<)70EJESI
+2#:)#KM>&XJ#gYX.ZX@f34WL:E>KXXGO(CX:##I1-^O#A2b8,DX4#X4(OdTB>2g
?N0E[4\@.W1b\Y\2aZ>C8U;90OW&4T8#.T].ARH7bf/_4gM+R\91c+Hc0,P#gJKS
e6FH(H]&Bg1/aB&^NG8?;FGf>&=,.cO7g.-;?Y5SLEHK]HH9;80d#ETH11#IbR5E
[MTEW-EB9SWGWYP,2QF.T2g;Y([+9;@>UM-_-c&(FG\bZPgG.)YDMW<(DSX5c;,O
;7JRf.RDA?^LB=fLdZNT9ZB#_/,XKLFJ3a)d16EMJCFR@@=7/Ag1EH.0G9_1\_N(
=CFMGB9#Saa>XY5+&b?M4-8#IJ4ZVQD.\^VGP(I/+J&P?f)6aN+).B8DN+SPG(dD
a-=_f2/CZ9TMW.@4db\bCOIMJ^.&-9X6d=9ecV89#[dOe3P#+,A/=H<T]YFO-]W,
=1V,)V=?bD<RX(-eFUKEU^I1_@U8?U8S=(DSeX0P,,_E.Q37R6_,7>10B3f6eKE-
6&<:Aa6VIG/af>Z;TR+7F8D_^)++OPZSIN3bZGTIAA=6OCC1?GOId/bM2dcG;J__
Ug;M,5/Le=Y)KP^B:)TXe^eU]a/d4]1>?010M4a\@gOO)R@L\&B,0[<KW^Mc_<Rf
+c?ODTZ16L#dY0.ZFBS2a\NL+&L&IU)&B\1gSg=BY<0_NX-MU:):GYF>P><4HaY1
PIa@(PN:_;Q3,2/Y.2,aJ<.M=d/=5OFe_DD.Ff]fR&TTd@@G[fO=]K+NKRFOW2AB
b7XHc^S1e(UJ38dO.JTF5W:a7=)d9Q1J-OZED1(&@NQd40d>BTdXa@#c9H4=1,E&
0[(4=YH/T<\_S+.FR0,CJM[\K[@>9&e^+?X/dQUB]&^__QO3E5fbOUM^<NCYMcAc
:KA,?(T927cPSfd_aCVFd=>UMW=gSRK_[KVPf:K_@;)7I<#<5G=.3:_PJCZHK.18
(Ud-efIDBb,Y:^GFF>&5<H:D/[,5f[#PZ_f-.Z:WT]c]-/N5fA).eONNa<-<_L9V
UENPQLPbVFO-Y]+5\5=X/[1_d+J0#3?S8:U,[@5EU/a@fR17+(UAF#B3b0NH[[>2
-\Ta0DH^ce._6?c)@Q#)K,)8O@#FNM1g[WZM47/a<P1;ZE=cO,Z12G(3V-IIU#CA
AFQ5FWc7LO2?4CP-f\J=^XA#D-^[H>TUH:cQ2IG+.7W6P_LUfJGP],>3Rb4TAe.G
?Hc\:ZO4#d]0(EPgQ]aW9]]V)aC73:Q#S6VXV@_5dOS7P9V8[2d5HY;))>+WH(H?
)BD4c2fQC=&(CA]&PIE#0de-c]-XXHX-L+NIMGSNA&=3He:HR5OfO#I5a49Q6CR7
Y[7-M#:V[<N[b8RNI<3U+Q^c36&ZBEAcEV7a^C+0CR3S:1^D?cdZ/ZSD,KecC.e6
&QK+:@R7&-a,JXXEWS\Q=A=1L]+=LEWD=(Z?8gIT8A\8D#RAW12I+ROB?N<^>=YB
=\L-W4<,WZXRC2YS_f^;N7)TX;@V-S\2;HBIQYI,C^<A?W9D5V0@6/OP.a(b]^I2
ETYU;;XUKdLYSK]ZYL1,gFY,1d;,&\bX2?e?FF3F,0HK..bUEM2@A<@:YKE_(dI;
=]^C&E]CG.Dg.B+5CCdJege3(,V=+Z4gMCSXT[3+f&3+D0IS3dS6R@U^N&Z8:6aY
VbNME.QeS7[UY+::;U3f0;?&4HDg8\E3V^=/f/;J5T/eU;50P]&IeM-9X[a/6NJ8
6PY:c9O+eF9#IfE+..CTS=6EK]?,Se#=5;]?THW9LDE5Y\3O26^Vg2&ZT8)(bR[\
Q-;J9e(FCZf,N;fV\X-G&SLUNBU^DcBf2:MCA&c>DHC>A\=US,f_N8D,84KK@_ZV
9G.;a?F0H);dX;1f7[FNQ97YOJb:?MBb8W-2&f,9_/OWYa_b95@U=(bNE>_/H<6P
Uc\-)7,YMKB7;5GUY=N,:HS]ZSOH4Xc8888LI,2NFb7G8ZPEfSRJ9G-O#E3aQ:V+
2EAg8/[=-eIS&M-.7_<@YLd&Ab[IfVN66A]:W.C8eV63_7E_EZLe\,G8PZC7bGCP
cJd8,g>7L4IID1U.^\dae&#WN5D8^\=?[LL;R=fSW;<5.3F#)4_>d#CWd6^MS7VM
9#7FW/Y/:aVD>U-+/S()WK#WLL_<K+.-]JW)HPIe]DbKNNSUNXRGD4QSDKggZTN0
A:g;(PB.Vc0A7\6B9E2]PC1D.1Oc4/P.=#Y)VX+Vaaf+QDQFR76C2DWS760#KJZ8
eS)8d,I^>SM(@OB9C9RNNTXAI?7)EB(XbOGR4(K_LF#+H90EOa#6Ce)Ug<(\,-2]
)H#b04#B(.=50_eQ<_XVe+3fa0)TB;A[gUH^RSQe[5=KL=82KY0V:T.#3b8&N--6
7NJR(;dfW=cQ)c2J),#_:2W+a_f0=O92ACQ8G(;HT/aU2[E5Z?_aD,@:UD(bMMMR
POK&=/\Od[)MR:K:D8A8:UG3-EFTYUUc?PcI;MK[>(gbS7CUJ#T+;IPW@02PMcLZ
WEGd.05^@(g),->Y[@JGBc@)dd@ZO_IMC@12DDcIHXf8SK9O(TEMUK7<KZa29]3a
KDKTX&:=.+_S>N<e42VG3\)GgL]bZ0H#R:C#59;5;&V^L4[a6ZXFX0]QY5bY4YLA
X5M5<\<:#g6V?f;W2UJU1FA-BN;K@ODU#eT=R&V,=25=9P(S@9.FN@OOL[STT&Q<
P#T>JIQBYL]<_d)E9U<:7>1-dRa[>cC01e16LHP32a0KNHQ2g-^1fBA9)4SRffPd
cCD(/W,H(33N5R)5T(DZb=N,[>9J8V:]X=[g9?:#.87g8E.Qf>B>0/^UKLCX@W,J
G+@E,>#f2:M?=dHTM?:KdEGY(d.@8+K985V&f8;KgLM;&gUL<)_g2OS&]=9CI1],
#]7<2A(<1dCP&L&&?\R^5C-1dLEP+L5.SB^de2D<dV8bc_;\Ed@MKC6M@H1.f^\3
JYG1^(2E5F[]Mb&X)KK]#8=LU.cY4-MUM/D_117\X+O+_SVdF-0-E&H\7I_(;7Vc
DLH4/G_&/NJN[>P.R52]^(f=\QdQX^G52g6X><9M>3G3Q^NfbYLHC#Y+B-V_KB(O
b4OfEV<\L9GT]YP4#d3eD)>T^JgCA8IF>X>V.^1(SWI1W8[.2=J;[[R24BOS2b9#
#Z2gC2gK#@.GZ4ZDH@3d_XSAV._IBGB^,J6PfKO7(O?4B8@NNDdc)K/X@#dQ2XRW
@HfD36;._GC.9M/G;:)PN9];3LETfEXJN_YF,)W2H6WKCQ,O2.a]HL#.M5.TUKU5
4+(OZR?3X^-J\]4f/TNaC6f;eS;<=GZT>D3B9D2DOH[HeX]Q5R6Qd16YB0.7,bOJ
-3F6ffXb]/S,7:f4<@UIaX;b^:?.PM)]1Q;#ICC+H2Y?gX97\PUT-M+<\IOb@/&8
+PL6fPX.FWJ,325e6f[#/GN^I>UZQf_bG08AB#8)^+O&AI(8A>VE8gEF=)G>e1ZA
A]NYCC40QJ6YNY>SIY3J8C(\,P2GA8[:SSR,<W<HO=9G[.aI\6.;==-?3,1A8e+X
O:/)9FE_[7+XcADG5\:XN<QN7L@I#gW3d[]<TI0&MYD90>C7PQ)a>-BKHI#&e9OY
gbPg:L4VUIJ=2GXKbXQ>Ug^NOWOQ6R?B(N[/).YL1b=1dVEWXNZBAcdR5@MS0MEI
6M0/ff=d#Z&eTTcBMf/XP_dE0<]^g^OQJJ:Hg4<E4C1J-7IWgD27A9Ic?25;\.Oa
Q2@=^RaUI(W@aZZ\fR1:WcJ@OHO-e8(;\3^(HB1,HT4gWULeUR];)1-gd5;R;GcU
#MS2BK8LBNCJc<PKf7:_GS:?05XZC/L\1g<QDGH6=-7^)A5Y5-TO,abJI;I6X@O?
_G^HcY93F<JFb5.Z>CHZ-HT[#Xf)^\g>BVZ.S44&CM.NbOVVM2VUf_c&(M,\NEX(
Cf1b5NQ,\E6?f3[e29F8.9/BX6CX>:aYA\<>IWR(CWIW@D70A&;TM2@D;,Z3Vf[7
Vc[CafS<g0++/OT.c2f^@=](b9gID1c:-EfDcD@@18bRRKdR3G)P.6V6[52K4S?E
X;M.IWFb?]G]dH5))>:\<.eg4Z:]8DJ2H,31JN_dO8[J28MbM#=:KR1V,3UFCXR.
YRE+SF^,SX>)eTF0JY\S<fSBCYQ)6EV9;X-dE+HEc/\XP+-RSBJ]^d9bBZ-b]R[@
fS@M(Ce7[N_\=ZB<a\g?OJ<aZZf?BHTG;1.&B&4R/>a-EFbM\?b3^KWIQTIUF#;G
W3)a>0U8bJO+V21M>AD=201[g>[^g2=^N9#a,RYN/;f\/4\>3]@6>O]OM[cZ_KO0
d#M4)ZX2982<[BJACfeZg/,ZN?a:eP\JYCN?aW9b<ff?XbW2_LKJ61;E8/C[MWL@
<UN14/ZQacQ6cH=Ae9>9RH1=,;8dC572Z_LGX2M]LN@</FP6E?bSfRdKI)QU3<><
[+<;8^R77:Y,+D]_8:cI,U[AL-M+[J3#P;g/d37&]U)e]/ARNE]#@^6\9PA2J21A
3>?CTSB2Je-cR8Z.Z^fA=I&]gLS]NaH//<c2,BRW5&;Z>B,JSd,73ScaC^-&K4gQ
\R_GSA5JBbCcSXReVRb,g0VY(SNRK2=<+,DVf3::<ACUN)W>2cZMcA;\fc&&+>)b
1;/_@T>S:S;Sa(WQ(dATRO,TIY@G.XRN,O#7:C@5I&-&8/C#>.?S88:UFd_7WJ1>
1Y\I_48d\,TGNE/MfDSF2cEb9MC5P;E)D:(A<2V)F14]BXFLY=J@DB-CBSCS6B\&
PV]Pce@E#4UOX_^W)F[8UR>QUM^g+9@(15ZW75MN?6E9A26T0Lg/BW+/Sa4SLEdF
YV_>KVTAa>fWC/a5<U5H6O]F/J@#]Oc&,+G;S,-7SN2/_J.dRD-(M00+@;-Y7X/T
7LX0T>Ab3_;gG^;f0eJ+>KAD>J0,b/+RDgB9ZdcDSabVC-a[[;aPM3QB/8-bAIE(
-V:6_474=11YK3@LL=e\V0=>O+=S0VR)G:YXaP,gK;0W)a[#bf)9&T^JVD#K)U_3
J6c6aZYV(O(U_gdCT6N8b<Y.>7Mgc_ZCIfHbX)_=R)=(R]]#W3gF7.VG\0ZT=BE/
+-cHQ^fY8EM(fO7R;\9KRHD0HZ?adS@,<UVS_<^S,LPNWcd([LV?dT#aE8.fIA[2
X+140GZ.c-<U#MJeK&F0?b;,BBJE-/38;=#YFFV\GPQ4;g?:&=UI8d]?Q[F]BB,=
V3V89b1TXSU,?I[0T;1VE5WOc?BaYH3C/T?X^eUX.9_:Vaa\e306_SG#c/bE+;^[
EV,/<1_A7STCVf(#/ZN6E<=7M\V2M_LRN38<E9g9;-37I\V;6N+d5=)VaI,I[1QS
S+84+_K@_J_K_LT-Sd.<5f14AN.a^Z>/Z3;=;MdNBW_JCC^SMaDf-8KJCQ,[5@R[
Dba)GQcW@cAU&Q=bEXCg1WTW=9a@@V#,8+<^75Q,VZJCe)fW>7H7a5?DLe+L\RW.
0Fb)+YKTU.XDaW;JY(YaJUf^&RIA83;,9-ZFSBG8b\>UMc2>-5749QE[U4;cYV7V
f_NK.;gJW6<NJA@\E,9KJDOM^]Q_d#EU,Z>YNT\WC&b\FXP/@b@8f\DZ(#8G&N-Z
]#<3E,I)PH;^.<VD?3g61:Y:QSY8U6&7M<#+KTPKY\MU-QB[+.Q^cP)EBYTIeQ_N
3PW3P2>L>PNTJY/@O48<Eff5;_>e)]_GX@VbdWDSQH\LOa(e2f8VKLCX=N5URWf-
+dTENW62:<Mc,a?P>M0&SL//HX1Sd9)HAW8-[--U.PaHB9;=J>=HO^3@O2A(cTb[
RH3,SHFY5RKSZ_;TL0c(NUA;:7[QD=UgL0UgAW7+<R_S2&2[;UNWBd(B_baE^RV3
Ee[1)R@?@XITR85185299#\9;gH<cA(DTUe/aHGPIc8.LLG[G>1]Pdg3)]KJUSYE
@;@ba/f,8G;6KOdV#]FCb[89+PQc])e/Z<Z\J3-H^IL\,^Z:[HVbGW4#JM(J]#@C
C.I[cf84/K76cXb1,.)_MW[0a+=3A,YMJ+2JdaT-f4D3H+N]3QD[._T(UV9:[,N+
XQ25]]36]Tc7U#c^N(a#THf/UF9,>?)6O<EJgZAdZ\Bb/QfG=D^C&1J1aQA7L)3E
5#HH/2_RI<I)\cZ-9&S&dDd)1LeY67a9H#\CGGIA0]S6YO7;TE60Kc(g6B^E9A]E
fd>>FgR-Z>83Ga2cI^K+-G:92L=[>WZ7-=/A6<bEY(gQ^_Q51EA_U:K#R#EU(HYB
GXb.XIe8>HI[_3_VHfGC^S8aaY3->e[H?^<>&XKS@G)Q8@SZ_0[ZNLR6K.U:8[H+
#1gZ4Kd^4#6gHQ1(5#REg]9U@5^<;L4R0T5AY,R3IVOG_F77Gg(=<8L^&@HSFA&1
J_3H74X8ScN6&/0F3FAJ9X0e^da62ET3f.IO+cSTM-<(fB6-g:a#1@R5+L\LTaY8
E#@cfc37,X6]>US=C+Ig-/CLdR=8^aTP/_G>L3M,Q8N-NDEZYNA3L8FVDF0\?FQH
\^dAI>5=8a26<^1P468^IKU<YS&Ca-SccZ:gVXX&JeJ(cPAOU+>=2JQc40HZ[B9-
f@)4RbP>d+E?\A\CI#;SDRBX3cJAL,\\I_fZX;)WMcNde3UJJ?6e(;OM<H;YROP7
+e>9M5>,Me0245S4_ZJ.VI)[VJ:^S01<aJ=&8^^Rc(8c14C+^3X+<WR7YZ2UL2XA
6,FB\\SG,f4\dQ6<9@VEM63T/PUUg]La8>HH4CI2AD.[]MT7MGAC]Le:4U(_b[_.
)=[@18]-KV;[[GeD(I-c5&1IUIe&e>[4-N=R=UV]1OHG>f19#f8;&FR5K]WG^,9I
[7[@7K@c:^&G1fG(@M>bQgJgG-9^E14IV(d4,VYT125L()803JC?)H[DaJ>;f8.0
[YYG.L8X[Vd&1:(K,JO1(?=Y]Mf)d1<HDOX?QA=FaREgCeJcIa6,5IbR#U+:K,[0
gYK8??Zf<C8Q1bJHE?f5W-Rf2CKDge[[MfH-T=#U7SW@<VWCT;0Cf<21EB;=:d_,
0=.J+?LaQBbE+ZY1_BOJ#3.22KMe89B_-T9GN:e5#g]T,^G<=:N]dIB8IeN#-TTg
OWcd)Qef49,5)^GO#LAPQ?V]SGEC&c\WD2\N3]KLP<0W(+W(V+B]&U#_(bdR+L3J
D#8Jd?NH.S5+c=Z:ce\11RN^eMYSAK+)cXEL63ZT\Yb(JYHaFHSDT?7RHR;dE1I4
1H\9I:H5bHgG?4<N,,D(:Y@;MK;3b2[CN#(NaF1b1?146aeg&<U.cCd=J?7W)Y,c
a0(GN)O(,,8IgAW-V#&\e7>#?;R1S-F=W(.06\R4V1ND>Q3aPbJGX7(=?5?R9M:8
_<X<J+8,8#gV,TTW8U3?g2,FUd7\9CIHLaDC6_].AcOO3)XM);cCS<&9a:=U.F<5
0+KQ&cc/5OK&YI_ZX9<\HDgD)8T1NB=/abI#?[_1-?dB.ZY@NEGc@,2QQ^7PeW),
;LD86K9\I_bGRWW+O?L]#OX>.1WT4BA,]9cB#\cPdPI2<;MK[9U=ZOW-1(/CGZ?8
(<^J0UGS&5Q]L4>_D\7U,MVb/F,#HW&P>[?\EdTK-97Q_DXRSQa]5T3O@W.?5B&[
<g@5>HSN[09N-38?H.&+?[d^c))g=F9=>Z4R\_BH,C?=EHRI<gS#&YJM?GJB658B
fT\.\C3:QQY=.4<cf\b@0[M?(:SLL5NRYG/g>WV=gFB80g4.7JZ4gX&V]7TYY2,b
C8f#aI2AG=H9IQ)L]<=?<O]<]W?:C/W]f[/^@HE+0K./L.C;Ke0a.1U&EN1ZZA>>
KG^Lg<4CdE4>KY5OFFG0&^^5@bQ9<E-HaY3Cg5Igb1dYI+a,]YZ^FgLP8NWYK,R4
.RTd^6/.g0E[^OdE.BEI_5eP^2I+VKSD2MKY6#6;-0O.1g;XFZQ8DeZUAMGQ#.;e
UN,[>J679[DXcKE8+NO:US_cAG-1D\6.L4bN9BGXH(FD&^W3/JUQDPX0E]bAFMeA
BB;TEKMAZV^+F)[Z=R]&_ER?,-M9f@:=.N/[/OMQOcQ5F.I0AVTD>+N[028J:5?;
MB-E7ZV6:][LV(9T7eE[Fg[F9I-1]ceQORGf=<:KWAd]1)G;CN@\QK_]M.\He?)e
c8WdN?D]I]P/+5]LWTU<>:Qb)cNYe=ALY_4D(Q8P#2Y/,c#KT2H+bDDP(Q&b[(3=
=22P,fZ#9bYecg#Bf;)]R&YQ0<D.]K5A+4)b-2LXY=X7\baLNaJF]ZUG?#g^JO&+
FZe--FXGP]\\RCGMBOL9D8P2VESDV1C1e[>)E,V[gCc>2G5SG5Q6\OA8&R_YOf.Y
,?DQ9Oa3GUCEWS3FQGNNH>_9FD=XD30@@CS3dU#.F?E?,4EV#?&P4]Ge18H4Y<>f
\M&HD?WA2Zd:L>/Q&+^:R&]N(^][Y;e=0QUDA@:S?4.bIW>bLW6LGf@L9)GTRT@:
B39b)H<0ZYEdgG1TR39M&<B^[TYTf1YWK=f7>V;=7[Wff3GQ(7R+?f:#(IOS=)#D
IO&/IZ/VeO;cCF(1]3<18D<-[C-@Ifa,aO.7D\g]4]aaRU7Q.0CEK>.>1<H>0^2U
:0D^W^-@fO,;^40MWYfcAIcPb_II7_cY\dPD5DLB6bgQ+[+^7ZYL_1#^4SeIASgW
&80YK0/HORBU+V)S)G(BL:gY</:0K=M=cG4d8E7#+BF7]?/AbM[8eFU0aUf1-E2f
cTT56QRV=YXd#P26-)TK0R+HTf<__F):Qg+EO)LPf9D78=-cW&5eQdT,TaL3N(aM
W5FJF9<AX?52\P,@a?c<PRI+AG#_eDB5JHDVIDPb6C,14&g27ONQ7K/3;+;I&fVX
=dB+VS44SV6Y>-gL4[<-SaWFRGe-N;=(JNc@S,DY8#-gUM/&8d(Y)@:/T+=&061B
PCe-#]ET/DfB\8#Q8OXVCA]XOQS)_;QI4[<DS+>D6?_F@8678GNgZ.A@/-8-_8N4
>?J<4.Hb8BGC98Q,>C.JaP(aA4c7F<U5:I1=VLHeFY<EFC>-RR/;AW4-^K0X5?CQ
-T37O0Ic4c#^,&&7UIgN:E(VGgFV_AbNQ4OTQ6,,[-0?P&LE8HDKg0G<1BQD4Tb@
c.H.[/&RbPL8MKcdDU8;7ETR)O55B?\<JD:PMZIJN\=I+bV(Ce?P5WKA2e(NU;/5
0&[-DSS@e.+)J+egPFQ29AJ(NH.=J,OLTN6?>#)(:7Y_Nb7BUXZI)SX@bcA0_f1\
UfZU:_(P-8D,Vg0bBg1Wa?d<cK^]A+J/?C^?56gAS[I;Y,IU+#(4bI;X,.EI)0)A
3MTd1N<d]D@4II):=(@<MVN,.ed=-bc,;D(g]7,L85fI[(F@LfaE=gZYbC@UJ2M^
Ya4UQT7a8_(TM./.^MQ@5^(A8)>=_WFR/6.:\P5Q16]5(:O9W=(HAO^V;SVD>JL(
EM.#[8SfcUecFfT);[R&X#gS\3U^8Y:0^@77@\\-R2S;RN-JbW=Nd9YT8b(,<1?g
0G6VPZ11aBfPW5]T[=<b#CBRN<[Q@EZWa0=X(4CTcDgWSaBO0[gDYXAIcUaC/1Z(
+4-GNIDa]7e+O12O+Db#F/[SdP(/71#EG34N:8_G0SJ9WF^6DE#dR4,5&b@NP18M
]CH0;7DM=DbW^P2&^cTWS5HHS^W[C4B?5,GZ/&\--Y0[/TGF69a.)2bIR<DL>e>e
8.c\WQ1I0U7;/2-_dIU3fWN@U]M?ef^+5O?]@^YO?CUDI;J+<?SN(d,f&5g?,c2;
4Y&.]ZE4?[-B@;&e_:>AeW1C#\P=F5F0V(QT9XPU1_b3NJ)CJ>XZZVd0UGJ(=EaD
#LZVINMf149d,O47b;@G97(<1X:]Bd5;g)S#;E/\8[?UW[YA2cG7^+ZN6<U#@@OT
?IDc@[).\0/#\LKU9SW&9c^<,5(5=98;e#P@6I?,g<4N:)Lg,5,+cAHLV9eF:PM1
@M,I>:QNd1=P&Lc6c+89SLK9>PULfMGe<#.[d:[.OGH(3R==Tf5R9Xfd3[6AS6d6
:V\f<;\c(+NB7C;^\TI@[VM]&S?L-8&V:,]a->Yca?-bW4E_2PeKa>OX&+E;-+RH
,RcgXMQO+S68L\+,_ALVU9F#U2=DJ#XeL0Vc7Y6^D8<Ne_?/[^6/M5,YD(W,&OE3
PR+DS)5RT/2>5]_7g]<=>\,HTX6PIGPMX-39fI#[]f[N,Y2YQO^9FO/(VGg>P11P
&OYdaTTWSRf?79<(B_ZLWNU&F#B6[T>_]7b32E:&/4[6<@9(X.(=6cQ=-Y=)434d
@?:/H\:eOKbDYG@aP^6B/DN/1L?73f3NWd[1fRa[5GPI/_/1&)0NBSH^aAT-?T\\
X-8^&IC_3Q8LYdH[?=_DEHA0EMH,=#^E6eIad+<5d2+/a8+CB9I1_VDRN\5:Fe2f
?<.E5.0/T<?[9>T/(@##Bb^e_N<=V(BH86R4&L0C4ND,g]F@7/[4N@JWSWfE?d3(
e7M0DQ3O_OZE1[GW01Y-PBZfRSH;,c#9f6ASY]A8W^Q6M-CXNGWYS40HWSZV-.]D
207@GL1)g9a1R;deH7PV00\.0Og-TO,X<d?V.Y.aFZb>=9<2.[5[@;<QPHA8PSd2
e5>6&<5JI=Q\:6:<+c&#OCO_^ec0AKg&(;D-&KD4@7G,J3#UYIXJR0R8&1EL1UT2
8ZCHa\7X9&Xe-^)-/OET?_5PKcfPWQe@VIDN7Nc4(<TVER<><gM^:Y+)BWK?3ZA-
TFS.)=VB>7Fgf,#B6(g.8#H7M(VbM[-LLK3<0T;#/=AgKR7M?dNLfGY\AGGf65H]
LPVG02TEK\6+9gO043.+SLS)0).:cDSEFDHB<CV:EPML\,BZ+?0)FXVRV2C1W:C_
^+TGY1.8QNJeUZFVXEJ)aa<:N\Y6=f4X.E;aS@)&eO^F@FVJ@<02A7,+SG]8:0J8
OMV5,#VQ-a(5B=9G:SV3\UW5&QcSSO9&@[C6Qf?@<1M:YJaeKV[Da\HF3Hf(aP<B
T^+(T28H&QKKDVVGUXaS\fOb.X4(\EQb0-DEQN(9-Z)]HE\1@RL>[]N\(E?/]@04
:6YUaO5dO==D?;6[&?G>MQfOf.A4_:&B(_=bIJ0O(S&gS2L/MJ_96<?[PH4U@1.[
bKf_(S[WBQM.AYdAF<EReI)a)2N<aT\;a_MTPdJ#^(Q4K5H-3(Ud];,aX1UMY#ed
Y153b=MbD04/#TI,I^P5A95)6fWb1Ra&))E^-K;f,2+.?G/H#O+2\_Rg8dGFJ6Zf
8L0(2E-WC5=E28O85-T;>f7#,afgEZ5?)LX4(g?Q=d^IfC+<#gB6)\>71TZc)03F
EB)@]IZV6P;KV1#0gIB#[0YL&QeM\Dc<KfVeZ,0Dge)),1e__I3@DH-V^M976IM3
C/6U>A\[\Z0H6(a:WEY;e>OI@O619=Z7BBAaSTLT#M#Y6X&@-)65O^F<9RM-aH=1
KCGbGM+OH34WCeRU1BZ:(D=;e0Rb>=;;b[:EX8[LNEdV;WG8@da=?L<MYMO(R,PJ
@-^QY6S&ScHXB@E\KB&6CQV5^:3LB8BI@]H0E-8]JC010.:.O9a](Q0_/U4<W:b7
C<GBOg[N)G[M<Y-UfQ-J@&dK@.86#8CNM384(7gI[+<4&>ZJ.4fVd/N;4O^^0@Lc
6PFD9cXT-=Q.,4BL\e_\+C[II/-<+.OGN@JfPLaWAdX\_bNJ>W>f<Jd6V^-68Ye\
)&J2gI>69R8a0dIR,X6H76>;M2,[#d5PK(X-f:SgBA1G,=B0:7MbD9<T&KD3;4ER
WU[-VD5#GBVNb#5O>4I1/.0GKI:+4CSC+KZKd5^J^Vc\+K17U8M+IQ,[8T10FROB
26,8U]A<E6-<H/^0IZVg>,KJ6T<@,A?0WY=>RXG@JcK9LE7Q^>Q<M+aa7WT.W)Kd
P6I+D:R(U+M^R^Y<89)5\>>F<8R<790c&SBffTgdE#R9,MJJKDdJSd;LL:PB@g6A
[e)2gc9.-WZ1O.ARg)/:0_:A^M^V4S]fE23/&Da_^5UB0E[?20/=>>]+ZU,[L+R6
EVd>[\[1JKV40dRP93B>Y-PP_f5\^B;[eKY.0JZD?X0GcJ-SN/LH;[Y^YH?<&LEM
UHTS>Y#)VfK.g7U#5L@Cf;2H&Y(1CW5_<],0EFHbOCGD)f0S=]#3LIA\PQ[/Xdf1
<<<?8aBf::2edd>BY9^:O^dMXe0Q6_+-#L?11\#Zc._UfSeI5=_+C#X;>aFSc-^J
62Ne0N[<DTLJg=<1Gfc?a3VZW2#-&6b3RKP)=2^P&W]LLbG#._&&f46TO+fXDIF9
d)>M.a)0bN?O#c8=\Z3^/<9;S<AM1@ZE3NgaG\RdF@f;PY8]dQL7N&8:HfY_V59=
24\4>R6=Y6HC>7#G@gbXE?M[(J>_cOM>d6?F59>]S,;/,50=.@AHM4,6d8B\A:VC
ES)FE9ELHAbP3]d^N]f#]<)XY<>aSVP#=12@c1XCHV,e&H)HQ51GLfWd0]3[ag5)
W.NaQWNJ\VZJ7D5+C(&T&^+PG1RQY2ce<0\LW]<.5e32Fc/3\MG1V1:]GJO/d=N[
\+840(>G-Ea\<9;-?>):+C+15WL_^Zd9b:7=Q\DO)62VZ)K]^,<YYbHX-Gg[5]83
_cX^1YHG]^UaMIG-@<fVO4;P,OC\M>D?LF.-K\63)CT]gE91WgeB&S2M:#cL=fE>
S4?P^/e6P5--\UbSQK?cW:S7b<&C7BMZ7DQC9NN6Cc0/;O/2&[dP&N(PSATc4>]e
I&>F8UN33Z:-0:b363LYcZ[,]FE6S9(169(25_QEX.2?\/Ja16.eC(X?8VCg@AO(
gD_aRc#OYeGHUIS5T=Tf=Ue1<K6EQ7-af6;\.-QY_Ma\#:6=3.Q]4(CT8B?D)C48
M(W:R^#_F<FIPE^IXC/.:X#Y;7HU7RB-A^0-e)9F5Qb)=E[<[BT.._(ON[6bgg.[
I6VCL6c:[TWcH0f68Y&#AH^B91)P>A9.^+GI2T:6V1\N@D#;^,8]Re?^+cbU49>5
.1WHJ5+#LTf6^^a5IXe>8^>00+S>7\F]5\fafa2>)I;&Fe5(+<0KB.b-T_f?Y_cM
=T4103.(&;+8c-f]]:]4[N\d(2d,5f4_Sb+EUdCIg4],MPSa5GZ9)8MYK&^.8E4[
8Y580\O)V_Ff&>9Y;_[SHS8D.FM:(17,:E\BQ]PJ^N?:2=KEM2.fW2U@Ja/92:J;
AK+/a#;<f]c(d+3eO#[+S?=56VU#.CX>cTD[E/<FXN08[^#]S8dTT8GXN:W-LM@7
B@347VSN\VA+6c/IA]/QRN98g-W.I5QY#=0.8-ff\KG0+[U)8&O6Q+YK&2<Y]YQR
H5&YX2D/J..B>&gBQ>[LaBV@H)HEe8>M9]?V5E@Q>=+C9PFYYa=VHC4,1794JgN1
).1??8/;A=JXNA./2K5QgD3R?V-<FZ/=fW4+U13-SOGD\15#M:7f61VWV_?_M=YO
b^P6PM-6E9\PL]C_RKN@0KA]=e_?^>1;]dW4NV7eLU[\a2DGDFP3.D#V5A75_EP:
ZIM]@cO492N)N8WT;KgeC98dJdS;ZF]aA2NGcH]#1-Gc#\Y4C_SS0a1SVS.&Y_U\
eSaC+9BaF4VMDGg_JR9<OPUINRD[AXQY-cEPJ0aB3ePEBF.?;E?PXD&:^&6cXO)U
Q/RLM93IMHdUR[7C7;SPG(&ffa1?=5SY_US):9W47:9MFB#M?LPA5<S.1>[YAF:,
f(;IEAISSTMaFJ\-DU_F+BfJX#\RbXZL?0ec+(fE=Ke2RI_,/+?S&ZaLg5#e9P\Q
fG6\<d9L:V\G/b&If2;89,YR>dP;Y-]D.[50P)LbbEMAFZB.Wdd^c/b_NaAUe-a2
1EPdaF>R>J#I#I92:;[PPW+O-<;;Ob9?(f0@P_cT21+Q1Ed2PNX_,R6e1M2U&:QS
((9WN0;>LT.Cb=Z5--FVLcVD][R7]5S&Uf[f::cX+-+Ua4fGE6/H(=9T&0AUH(Q#
e&J</TaX?&,bT#3R7+ZV>D8X:Ld5XAG)c9.,=[c)2a0QH>e:R/ZDN.4;T7d7LEfL
R3&E2AcM8G5],7VH:C#T5ZKXfQGS6.44RE5F3RCL=.U(;,]V)0&1H/(DC/WfYHCQ
@=)@8Ye]K;(d@,9a&^\,b:(QFT.0F9NbS+=+/>;2=Ub0)df^U0;_BOSJ&[KEb\aO
6/e3RdYM>+]6@BXP0d+VVIYO4#<BB,R>6).7Og;U0Af->PfVg-4NS?Nb+aT+^_.>
-EC/A.3Z)0G51=?ZQAYg=b1:T.O/C1LBXX,;-e:O982<C0]#Ub<[Vc9,b/28BBDc
Se&JXP:bM0+Y(=^7+NZ\g4+CXD_B=cL&R.eUJ?a:/N&=2-[B#_.5F_=3).STICUP
c/4IbE.>E1KAE=3IE@g5TMS)8IQ;2BIZb9cK6g,]+//-g(Q_#=bDID@U&34D@LE)
XYeAX0R9N1=)SeKd=?/Ag[-UE35MUXaXI,9W3(L+V^U+0/5_EY.2-6K_^DfI0+;Z
\-1bDSKDNgbgTJbCN)[;@]MUNISa.@5@-7Mf=Q-bc4a=+#G501gVBB5+Z#JP[1I?
&[OZ>c_.,>SMB<G_Q+_#_;-#g1UEaW-KD_V20M.-5P=QaeXMcB6+<9f.JfYBB2Ga
d2V\DeDWSB?(1#&4dD<_H5BLg,E3U;Md?8IEdCS28_Wgc4^8(G&UJ(T55#;AFf=I
3T.(W2L=#TB)][A@abP^7,_J8-(W)F)=\]ES+D=7H2T2a]@X;R^>bR72aTJ?V;eb
0S_FBfT[TB7HL@8S)OcVJG\IRPgZ:5Yb5XMC9JJ>\dWBNM<L),^eA6<?MVKH-Ee_
B-Ia7R?K5T_5(W-TUBBLWcUe0d[[4WS;EWgcVN1C2YV5IPUa8G\<IQ_7,+7G[fT7
86(AN#,7]T9aK:La@TUY[aVR?-3]#Q]6+I_<@\;E<V?QO&JE@HS7:^XS.Jbd\WK#
<b)fOa=<S-MRaTU,LfL(-^CYL+DUVHUX4:22d[@ZJDLEGG7&I+4>c/aGK37@YI(2
ZOE6Ha,H5QNUP3:a_)3_LX\D]?XM<+OGG5AX9D1L@F^WY#46^&4]MK<gYg.V9+60
QNfT-1LWS6FM&1;\CLKFDLS-.W1X(6?4(725KG+3QE>\+&FKK-^=?7_3,I4gb<-E
>0Rf:XGP722S+GMI0ZH1b:cK6=X+fcdQbbLb1V^BLJL\e.PU-\4?WeIb_T_bJda)
K#U>@a\/F=d<4GN:ZGA-]RI:PU,T5^XLd^=@SB-KW1Q/R0WU;@H3D/R+Y-8N0BZ8
Q^A]?43.bYg>_Tf63;A5fCP9\=B?=WOQ#C+LFJO:8AQY?Q_fce56)cD9KAO.(9OW
PI1,ec\4dIJE/@.(b7&0Q[;5U:egOYA1,dAO5W]<,PWcH69@Lee\@SfS:9g7d(FF
Qc?Ug@87:NTM.MP#,VfEEQOY&#Cf),D[06847-OH;.<-DG6ZETaP.STV=[5J@F13
DETU_W8V+O6:#2;5P6J:TGKL^6KL\-&ZG(,T8>Z.\1EM2+DTd_[L[S=4We7S5_Qb
4;-?cAIMG<K?<98N:I,;;c6WB-QF0(QS3MZWWB&1[P25d?YX#XXQcgXa;VR(a>BD
]NEeQQ77e-3FO-ZO@RA-TM5/1^)]QFfG+f_8f+X>I3gQDb.dSDeS@1@JN:X)5SZU
5(<G&D_9_;6\dRDdKY?^Fg>(gZ-cR^?b-W@4BAHcbHd.IV.W-NEg8NB-(6./\5UW
CcLdY0)VVU,VbP::0[bZER8+BQ9X/#HQH-3e0_BgT3_d+bKd.H3Z:]LDJGa:Y@8f
PP,0dd9/]<?AZC5TVE3CcA[=5/Z,#_AOMY7[Z;AAUAf^DD5],>MHV#E5SD+8S[-D
Q>[-X,=9XW-33TeD<Y40NM<5]K?P7YZU(_gacNfMeH#S7JFdJOYRJ.XG,IgWTK^6
U3F<3#9GZ(a_@\:BK4FTDega-Kg.C@0FP68IQ^fQ@;XJ;AB@46g\(LM-eG4,JUE[
OWaXC,6867Da<H3/S2>)cgZW7XMDQAgOgdH4XZ1g(A^NWbM,F3:d62IRM,-?EcQA
LVN&^A5;3UH&LS4(NRWd^U>GD/5ZA7N,,#dY+JRgXQ(Zb[,Rd;>&C5_L3&/D?/]T
7^g:JR,2Q:NeKMKXe=CcD3-_NCJ-A).1HK#WQ?ZT=6O9R&H0#F3YNWSTF^Q+FRgf
9.Y)Bf+U\H7XE2>B<SM.[1B/.\1;0[^SF+_41aGd8,-WIY_X?]N7eYMIbR]AgJc:
[R^F+O5+aa\Y6B7f0EXB65(=5VT86H,#06G8ERCaP<@7b]&HS>N(=X(NYDU4CAL_
+Q+Q739W^D9&58]X(UTc2VA_\cJB=c(5CK3a.+B3FPG]c;&YU4VK:T<>Lf[Q/e:V
7bM^0<A1;^BQ,J&JJ@XI[])BRB.M;R,QHc-R7)+b71H-4E.5L/RF]:G]dA<.E]C+
IbK/;_S64cNSf,)A9B62eJ<91S9[YHJK>.H3WR_:N^LZ)G/9#bO<OLPF.UBN5S8/
/Tg[W>Z]8AVK4:a_0WT4C3UW/V.\?6@N;dFfTa?(Y-.6EPY8G0WfG4(fOG2-AT37
U+O12g,50J44CY.^1O_9+U:cgbQ7;#A_?#P[+B^Xe)IJNa@@-WaN>D4e+QC+,=>)
1K?3(_\aQH?Ag1XH^A:JT0-4c^=5T<MfeU7T9Bg(_L,Q+HAdYLUfeQ)I/1=]8DfD
.HZF9\R5T2Ia^7.Sg;\4\+5A:@I,+43Y+b0:?5WD8GL#S<#C:-^fGSZE6[GeD(O3
:3V7<1)[WU4^):OXMMP#f]2A7AKS3>+&L<GU\E0_=gc,:WE\(MR+O(5:D@YERRf2
Q3E)E4NSY6e)9+]g0Dg)RF(99QO0_#;WQ,fH8H;M.0^Y0N_+Qf\R[D,?TK@P>,_e
[P?@:8AK9U[9:)g3)(BXb<c\&_21[edK_<M3O_R6LcB=[N^&G1_51#5N6c4efU6C
T#@-?^P5YA]Y9C)X]-2VaCS7<Af0&e35^=6c1g]09,(7/GZL1MM7E9QBg\4Vf))W
ZC[074<2&QV>HeW;]fWK-d+X7Q]9D2;g&+5,fI(ZgNEF46F7?]<+TS&PB=<\#-fU
>Ad0&[ROd;OEQ/+ROSIP-E6BB37>ZZ:5IMe2LQ^&BcI-YOc:VdObV/NBD?B=J.2-
@(P6_PO9G35aTRaS>CDN5AN1<#be>:a4S@=UgJ_\2TYI+Fg(T=;KfPX?^K=aN^[[
-gB)8A8V4XJ)?KSMd.0cY(EXW+J_W8/3;_aO?d,aa>b)EXR6.H4K;G(_H_P)558;
K76&L.6UQY46UJ/TWZZ:F.8;51e[#)#13c2NM/f&Y:H?ZMF0ATT?O_8Q#WNMSL86
:K1O4_IH@P_VY5d^:=)&6/fCDYOe>EaHb7<&IX16C+2DIA;=D.44ST#VWHDbSVg8
2\SN75Af6.8JD\d\T2:=3X7K3[CF#4U0bT<fEN83=P:ARVT56<P8#5?dadX83^NM
90<(M>WN(Ec9AV?5c6Ma_CNFAC#N@b[UW5^-^KJg]Bff/24>2fBbgM)f9MeE@8E5
e4E8J](@HbA&&BcQ5eN;.HALE(Y?3L+[[CCES]:RXJ2/4Lf=S35IN3PADe])0+B,
(ADG_Ta^/GB4P+NKNR5(JH]#IK=8GP:F(^0-,f>ZO1JL_gV-g_7CZH>Q(.N/S2gR
3&\0gVE\Fb+].6eL#ZTZdFc5V=6+(Tfe71.B3H>5be^@.NRKTeU_H@]>K<Y_OaLd
1bLdN[OANR0;;ATP1a37Ca/LPeI@OFV\[aRaZbU/:&45R\9S2\dU3;GYc7?DE&M?
83,UF;LMV^;M,7K<EX?GPR);-CMTRWM(6TGZ#52]<@:f9-AZI0U(E0P--\K#KSb9
]X\e9K#,ZOYU8Za&c-ZN]EbBV=;_g+a6_FTET?V=N/La=-V,UI#+g(#MN\IHKF7L
GDb>:CYFX/32<a4<cRZEF?@JQO#WC\91V?R=-a_DIfAIM=BB+;5(A0\(gBRc[2\N
)G-L[\(26bc-cc^9\DNI+PLG59[;(H@)O:fB7?2\I-_PdTaP6fDBO-@c?.bHIDK#
UL6Ggg9>MG3)A0-Q-IKT3DEH\0EBRQ,_:D_:Q_V^B,N9+&G)W@K0CFT?7,F4@79,
6aKV9NSeZf9,RQfA:^EKde._fbTTL7=R.&C9?WJ_e0@BCF#b7UI89H17DNR..2D:
YO_?(.J,K=bbS./_Q<5-0SX=6d21cUJR9f,<4VJ7))IP1LRNe8QA.FEbc=@12C/J
QDZ?W&-QfWg:\c?05EZQ]?L>IQQ0g[M6bXKA9g>Z)8KBC(SeUD>D?<N5[;</<W(H
C6(#+8QHa[.<PIfLb>.Ef[2KQRW@32(fUOcd4OYVYE+b-d#/G8Z]^H14&+cA^@51
AD\7>^@T9[;=ET3f/RR&]f7O042?9:60S&:V<U?QMZF2:QO@dGXM_<ZJb?>O7(ZU
HN8;:.NW:VcGN#XVB9,R#&9R&gX_dA2Q:FB=H:6+G1(AH4)eHNU^>>HFf=>,.bQL
e9U&B:9#]Y#^cVb0EDW#4WVY@:c/V=M2#\-Z6]C5<60::,MK>a[1:0_4,6WL:@fA
Wa\bE.&RAS97&\;G(G&L[,U-Q<W3MG7K1+7]MUM(5;(1SYIDCg^fbESA903W9OYg
2]1(U?;C@Y<.GH(LXc\P0_>Ye9I_IbUAVJPHSVV9OU2N0./]#U,MHR.KK2[17H,a
(;&2,+2->T/HQ<,IZ@-]4eF1^S-)&Y#IeW:a.-GG\f/@eDHBAa=d<6;8eJQ1<dRc
CE#U;^UBMAO\Vg+J#[KI].4C7X/Z]:7NG9MF#aYO>+EROL=O?PDNTG<SgEH8\N+b
K2_KXC>SLW0Y9RBBN4EKGRG6/71]0<O(_)?NT78H^+@d/EHZS_FFTG,5H/eA7APM
ZH#FJ.J90ZTJ8gd1/gfSVJ2Xe]?8N9W8EB@QJ=<b7B<8).49PRbRbOH^c/N:e?Xa
^I(bb<@G3WSAKY=(,BSIMf[5bJGa9^AYMD8F<H]5KUC_>N476X)^AQU(>N57\<0L
c9/(RXU249K=J#df5CC#)U@_@B<@^KUDe@3QC5ECVS<-WJYC1,?\U<K&FgacG_YW
RLf/7^0>4UQ\)V0CN4;f?HR(LURKD?GbHac?5VU[?71:RgR?8:5GLHN:W@#)9GEe
E[;g&&?9<^M7S3a=\4E?@YG>>S&[^U+[(9QFEFDab0cT/ID1&<W/I);4M51G9F4c
)0Y8O7&A?V-_ETddZJ3#7<7c&@CFCd1#e5_^;fXa=T<e\6N7IYJY=F1G(=-W?)a&
_eOe8#eFO(cB5\:c(Id8#WF(#BI5?TU&CKPUYcWX_3@F45SK_g9=/E3,/b5L)582
/)+GC>Y/?PAdO3P2F,^)DSaYX_f^EKdFY=F2?NJ<9d_VMDQ=>(MBdIF[^)C5O-+O
I8SQH-<?&JZ7bT.D5YJ4\W:41?Gg_F8))G04J#S6LSA+4CP:1gACX4QSVBTKIUb^
,R<P]3[D_\[.3GQ]PSW4-3>#UGcHGN]9@^AI3OV/+g4:_@M+H=EP?B,F];2D#6be
JRJ+bFg]g<Z.,>gg^4HI.?^>aB]P@::3[UC&V#1B4WO>ge&B\/35W7Ab_EA>&FQ1
P,7>LE24.CV8-H?,<7T(>(+A^Z?ZaWaPEBSP#M.0\<fZ]LgO9PL;)&RU[+(PKMaX
[-)+/O[W4Y<2S1B(?L3IE2eG_:T4W:;a>IgAKYV:N.,G@DU\/DdaVPIfJgWN:c<1
J1+MU>#aJ:&Q52,6O]a3NUJ=DS)67,DGdgR4:\^XYcXW9a6^&#K.ZX:C8YQ[gAT,
4;<VM.=U/60B5?)FN0<D^Z&;)]&4.^A8IQd,]OfSf5IO(?W=eD/ECYfHI:0R?BB^
ECWK:WW[bSE4F/+_GC8\Vc&<&7c^3K;))2=M_.-&&V]d9JM>5>C8fTH<aaaFZ768
&]VDJFNU&<I[bO(PA\>aLU[HSFCO4+0>Le;A+0@@Dd)BX4Ue23S_RBPgO4\a;_-(
J9;9Z.H0#B7bX:<R,TGMI2\;cLWQ;0cS#P+&EMFYS3CX(@P8OcOCbG7/^:5ET?6<
P=0K667g(Af>8Q/1EZ)&0J-2UfK9FE,G(PJg#TWF8?Xf)VJ(^#TB\MZ7af.-::)[
S#MG4K<\G+>H6M&]&d544?:5ASXE;;7^K:M38.<YKPP(f(0;.\PX2QF[3Q]<;M02
A[d,4?>HfAGI@-?[7-DF5Mc\MA,Z>gE@[c;Vgg=2E_Y&d\(B#^d;RBR@O&75(_]9
=d_eF;Sc.Y>LHT4C[=.0=5e)gK,))c7()XK9f0>CZd+U0,XK[[JBbb;2]FR/K6&W
54DEHaLH>7>1#52B:<Z7]GLV&fE4(-LMSe2C:1?BYKMF=^M+QDK^&0a/+.<+GRV4
[e=XL7L@+6\[^X.ebU<XQ=fCMMLFY;^-#;BV<30I[QR(N=U\JDIH8P^&WD9(d#(V
ZD@K1-&4S\FcS5/Rc#U4=]I^B4c8#\NUW\>[Sc@.W&C6;#(b8gK>Z6FJQJ2>7a(f
1_c]a3AK7Z=O:@GH>GUMYW([4)+\RbV,;@\50][:K<J_/.L-BJA;?4O1DRUD+2-4
<bO5KODb:B_=9Pd^?aD-T:@H^#_]B-Y81NRC.XIOG86GZcBEB2#WR9G4_KT_S5:M
U)ZON^[5b/f(_ZMJ^Q21E^SF98J</\NX29IB?b(\D\4[TgHcE+?6^CK4)QaVc[YF
R7+#DbAg;6;.CEBWb36TMQRH0HR\2,OG2;#G^Y)1V@:?JT1gKNWQ[F:&?>].dX3.
Ld)[RR=g;PLSe]/^3#:83>M\8M5-[+4aAO:L1GU<RBSE=_YW&(P4-?G>BVU<;CSH
BJb4^\R-L0X9R-\c=^#?0=d^N.=d>8X1?M+IQGfI;4cVa^FGg-5_2ZbF/HZF8Cc<
0X8NP<0L=O<CDC1<fEdaG8F2OMHeC8<0)K@SY,#,7+;[HbXHPG7ASEHe>^FO0Z^N
NXOO&E8>4&QG0\ZPJ=G<NW)OS/(.AFKW/(>S-1N6f#bU.IC#KC_C55PQ?2ba0LR_
,6QJaNSF=LD17D-7=?Of@NHQdKcW1_?M\gLERCMFR=d=Y[?D42(<@8\fE7F#bX0L
RZLPZ>0Hd?N7]]=eg/14(/21_F[=eU63\9[LP7Fb5FE6+Wg98Rb::UT-V-^[3&K>
OgR>=L>=E0YONE7/\Q,ee5?b9RCbEBb.2Pf;Ld,L<4JUEN\&Y6##-HYE(F=H6\D:
0)XO&>JOG8>dV?3;#:;3T;[dHA2Q@PV216eKLLJa\+3c47ATa.SAK9A]?8W+YK\&
a\UbOUg6c5A16^=A5&3gSY:(?gW:^LVN3TMKFBe\RW^+\S4:DD+ED+&M#AB55J1)
51N=(NRO-OXaWZD[>NJ4.;==^c8P.FC4Of;<;6@)R-&_[I33,O:bN(X/feg2J9/f
/Q=1XY0H&X2Z_,>fQ1;I=+dBU^0ERKI))68(_;G)S>Y?@HR-K,IH#fbZ-<gE)e#I
JQa;c5UV#&VRT;V<BG-=VB?a19[e@3[6?;(21ISc;\NZG7KS@^I5PI=#.bH8E95Z
VcNYJQ^&TU7cFaO>RZ3Q^GHgT_MYb#^_+KSg6K3#UIVdW;]K=#;[5XB14AB<\6@a
(b=gNZF/&:d:(14/+=^T81]f1,7PE.c^)9R/B:B#CXdWGU^1#Tg=^bW=Y<gc(W+b
=S=OF@5bOD_+^<(^;>dT&-[^/c<EG(DG7OM5)A2_Q@Wf=+Je]f85ZR^PWM;-0KJB
adAHC+?+Q92C/IU^WDgTL2abc6>S>AMCBS7ceL53AOLFCS5Z[XDY;>_/#=R90e=Z
B<0?]M>(DAe#.7D?EOb#0=]N,]^5E+#gD6/^-ffL#XS)\S7a_-9MAJEX-,+7>1?=
QI&3.X9Y<.)D?007QI=99E;^Z/S-R]e;L9cRF@4,Bc(NS8(6fQ)+8Zc19YU[Q?HV
:1/)6FC(f6^)GJ+X+S>S:b87VF3MLH_.5^O45THA/JSNR=#@./?]#N7IZO\K@_>]
Q:c-1]a-VUbaYSdZ\89/dAcAaPDgDL<O3Cb[UbIFJ+L0TJ;PI?U[9=1=0+M&8H9F
3/\E2(C74/L-#=B(8UE9&7S^f?WaJQ7-Q7daKdMVa&SFR\g7PD]9FCJ9AA4eLDZ2
)<^I;d1<<eeR8(bH(L^=[YecI#J/gDJfHN-;@H-YQWUcTObB2?Y+C.&O6Q0PTRHF
?PWO303aCeOABWI\WA,GcH3-GgEP?2SD>NR\/Mcef4A_BVMUgc26_eE#9^^JX7.V
f^O<MR>+aMJ1)C#LN]9)P0C<>IIF3=?Gd8L7ILNPLN#7=Sbd])Td#,+VI2WbBg^0
)5J2+@O7V>feF\U,=NcUC8ZB7CW&63EF<VfL?6B7)ZSX[TD@Z9=S_\^O\#9DQF1I
B=2MXH9A8gJ?5E/LBR[-J9B<Z+_0.E5WE-OP7SdWIDWB+3Qc=UM0]QH6SR3;aM9:
6N>d>2?09Od.cR83Q6Q>7FI+M/+6>+PKe:Y=-]?ad#Z8KCeeC30AgT#eA_T)P?TG
.e;]+6#U?#;F8PAL<YFN3)@,NQJcVLK(a^@/TN4[F4R_3:.DS:<2X\PJ_PF&=F<T
R8#U/)N-@V2-Z-@CV)]J.(<&bQb>9eFcObN@V]V1WQL_7;VPVMdbD9YbM_L+EeN@
JW&FbA_LOdR[c?Z-bLVccfCbfC,9K&&X,&]2QHY+dHSg8DEegN9ZQL3Y(=YdRD8?
JR3;</KL@5>@?V4>2IT]]#b?3;PFR)-?f=WI2g1+&f/ZW7PLHC(-/,>Pfa.fg[8F
^\@@S5/SNQZP?O4gE7ZR(5J:?(G#SM[D<RR42^<O_FN>=a:H>\<JE(F\YAE8T28[
INPG=AQM(5Ide4>\1F&C_&;e17g1D,,bfX6G&\8ZI4<#47La<E=(.+C>U@1Yf&]0
F?:?W+e8O[-PD),N7ZG._(B39,C:BA-#PB.4cGQHT>b84G\,1^<:7c[9XLC9-&3b
(])>?3&eI+,FZB^7d[ORb\/WLPd:<&/_N5UCQ=XG.DcFA,ab;S.ZCD#UB+V\)38B
MY4IUW?R6Qg;Y[:T&;Nd./Rbf.,GVFUa4e(G>(97b30<17X@X#-;(YI.J,YJU&Cc
BN:DdN4/MI@J+9SXGB([[bH.(dc0PV38U4Qc>8/c)6ga:D.8958_(2R?OZCEO[)f
C9IdT(P(8HOTbL]\YNIAMNYW&e@8#]F5@BcKORUf=7Oa^N\Xd=Q(#fLAbGZJ]2UY
AD&?dOF2,0OPZ3Q;4LWHV:?XM:82KR=.eGE8O-&5JE0f+4Oe&4+[ZV[(I5&&7N71
(.9.eT_6@N<XaI@0:K\cQ&aVLN:<K6<d^FI+UHa:I61WCIaUJ?d,\:f7F0&^Ta8g
Vb)dF#69.ZWP7L/5KQ-KG<762W9]V0W?&4O#ZY<38?YCKQ8[3&HRI_=AO9^b)ZJb
&9QLUUT,>OMUN12gHYAa5DgYe@eN@Q:OF/JY-cK+43.T2.+Q]e[</HURU7;6_>2-
_^4c(=;:@U=b&?S6/Tb:aVX+RDK2HIUC2Dg>V-8FYAV-@J:^b=CXdDHU>(/dCcY>
4ZLJAI,+X+bI:OW2UUN7(]?IB=HX/X2<>Y6=ZBL1#cRV/QZ@PHbRJ6c(Z\W5KVA#
-MaY-(3=]7E#-?JC[F5eZXa.EC.QC-b4+7:<V^FSG5M?MHZga@4YYS^+Kg6D.#BH
3Se-P<P6Qe=TP8L=QQ:K6<S]X(aNZf_;RdK1B6BGcEJ7BZFKS3#8;8[1VR(eOS#O
W@)_+]f6QY.I6#.eAWLGf+\0-XG^IDQJ@J\M&fDS7:GL5\W\,X-fA/c)2?5DbaP=
#]MKF]Dc._R4VU6)MPJAOZVQd\c9)SK<aR^>0S1CH7&;9B<D?VG[U&0###cISVbB
+<TC#G>aP[KG]@Ab>&8OM;K=>UK<N1E3]d=3b<I=#A76<HN(=;g.)E#VF@Tde?8\
<GTe>(&4):H78A3&LTMa\fbE\:&aX:_IACQIVQgN.c7QDd>AS/7VW[;9F1HeIVdR
VQ;)C\T3OZ&NPWVU<86.f\K#ID?^PQ7aZ?F6,b(^B)P]#dQ;V\CK/1Q<SHc5&3IQ
OAce47g2T3GF+^6P_<0SDULB,geN:?86Ug\D/#N0A85daY+9.EO&_COKYF=XOE;I
-NIIa,EB.>&L;XdK)KgJ(E=;/bYcSHB#]U&OF3]0E.cG+3IEEN;e@U6f@8b:;]F8
M0]NO(YJ4U\B9>>9].)Wb6D#WS=36#K8&5PMZ&\^XXON&,J=.c[P6/E68:F\EVE?
Z-G?N<2#g?<.e19GgE^(=gF5L4ZF\1Xg205(NQ80d<QacZbA9R4/9dNYDe)O[Be&
)PF^K<&f^AT5#a@X.#^TU[W6?0bSSZcf;>P2E9\c:2(aAS2+Cd^dRdeD]OE6aB0F
@QQ]\E)a)M8Q_2_X>e&SXdJDd@#g8B=)f.>G\J6I6A3[E_JJ#RZ.bc[e]^@_g=KI
YRO-Qe@QdO+S#O=CYIV/D@5I3-FT@PZ);G?g::bHOF\1ZO8DJ@MU_P;cBKa.H3.O
7QLNO?a=H9_\d&)Y,SfA[ac)]gR5##OXE<Z]NC<)WgaDGZ51bbgD\gMQeeY1b;P#
D:/AC^c.U\U3J=.<SC,H2(RR6Ydb[O#LT7\EU]NSF&:Dc/]KC>7?\X8\;ZM5]e:P
8#GX],DbO]BS_=@Gc_X0MMOARfSD;_cb374^_GUS27H\JQT@,^a,_^).CZ#;,A#@
a)+D3]=dQ=[5dGM/G4QKQ0cI@0Ua[\E],)FMP=6ONW<=K,[OOeFAf;Fb56;UU_Xf
3>UZYCF&#f>CZ_1^R+Lc7DF4&,&^Y)cR_D_IMfVL=GP-\R+[d3=42F+68.?WCZBM
851496@>LV(5Q))bcT1S=RRf-\YI.FXaY=a,LQ0#0:&6_>U]#]7DMd#E&J>#NN6)
A?S1E&&N38=ePLQX7;fXOKF[QSL1=:G(<>E5Y_?]P>82K(Te-,6JC4.7<\14(5&W
ab1,Rf6JI0VT7)\d?9X3e3L>).9f](G/)(:#UI)b@H>#KDC:Na;.COfaRHB66\/<
+d[@=/@&KfB+R]aYE&gg7g/4&[BQ>e5.8)3f2GO;6ceF)NP(O^>\;X_C#PJNKN9f
KT0K;SZI1=K;_=(K4DD=VZLa&0<.1HA=(033.6^;O7LL[SL3SbbC\B0We,IGeg7_
)-AZ+Td.=H2ZbIg->X_?^4GJS>8eDKQf0&Zd+I?;fGKYd\\J\#bLd8(&>VBN;:67
>Ab0X]T9Dd<#LZ53@X3e6\F9T-0a&]_;S;Ve&f/-3,M(&,N:B/F=_Q8Ya5-C#_O-
de_2#X5,EAeG/\fN)XIV_X_-f1XY<H)a_SV7#dK5)/53P?9Jb-==7F(,-SJJF(PE
EWASJ@;:efc7;LHAO_4<F;b?V]aNE+EJ3aU5./BV+)5,_;+[U<dc(+J?c0#6e9?1
,OE)-:@]M]R67:+E6TKf1G_=9_3;>[1T^WIZ:?VXZ=>_/]]B7,I7BE;KW/NNYLF\
#\Rc&ZO5NN7g]A_RZ++f:U.U>^d=,gPHPGMTGBH0IYOG<c,6/QB84[3P>VU.4GbP
[6_<2@.N7JCH[&8S9fU1[8&.=BScG]McW3&_7C)9L\f77SUG.bY,6fb(2YGfM.R)
3KS\<FR3.@KT=KPF9M;bH)Be3;,B_R,C;.VK1(8^#4]AHgVIL#Ag@1^IB-4&+Y\A
Pbe-MQ6NfLWc9eC+_LM92]Jf81?)8NW8GW9+Q:f<egWH>L^V]7Ya>-..TKXT3VgJ
GZ?EXN:0(8Xf3BTDN[8LcHS]WA\b7=L:5#A7+T:X1S_c1:2OLaU7d6;a36@W<>=P
;;5.5OOb^P6Gb;>0PKOPL;TgJE>2N)+KP/&+9-?^+#X[@@KWbe)-VZ]FS85QfPJ>
ZTANB6[8XfK30J3KI&/0&D,O/[<+8CDIC6?Y;@<=QXZR-S0.S.Q^Ge.>ad-(),G>
bOM7#:RZCO)bD(7EMF.XcaD)I8e+C.C7=<9K8#+Z6JLCJcK]TRJ1GWc<_Y?JUE/]
97\Hc\9B&>X<a#b&<aH03&/e(>(_;VU:J0RO/3/A^b/[QQ(U651>8ITP#XVMaY4G
^38@/7U\GO[OH=V4.2NR@<ASTCX2N,Z/cL2+8W&U^O7+,^,D7I+VL:H;3[[&Y.bO
d1MC\KF&ZT8\FOd^O0e6_<7IGfT?D(QO6bEgf,D28EE#gVDBeANg@E3KC(TWc7N0
<U#2&Q>8[I#C?g#A#4Y_):Kf>Y,2RcC[eUbdULHL>b[MVK<WfWgA>:O2Q4G;DOYO
N&A<c/&5MQZQ:T)YU_ANI[5>69LZb;^.bSJRXfg,T[:YgMBT62gRXMR>(L)4R4g&
4#1R-OBVRJRcSC:Q13(Y/:>P30>A@BN:G\F9,CSB1+BX1b[V-0QIH)Ig8+a;5.;E
=&KFaQ62HT/)I\RBSA8Bbc8J7)<:d.QgGPG#@618EWU&JZ6C43T@9U\O+_U)+&G4
YD=PFCQ^I<;/HNFTR@=,S0=F.^G;OUNU1)9]IOHb<_>8_KI7cTL4]Db>Z@R+3+./
:S\>2<G]RJITUg.G.R5Uf:f=5YE\a:aMY9NP)DfZ.9bJBRF)QWB=;R)@:EOeeB#7
FG_&PS;_&OHeb&[,KaDZ\GFI]e#+9a?[@?.+GLaJ;Ja+?#EJ^.>#-[bXHaWa#[M4
-VJIX,cdCVb@W5Ge6;G<:IH.<3)ECO98VW#D\I9>cECB?9@UQ8=69&f^P\GO1QBX
J3JWH;/KQ>RL_[#8f1#W26HcH?&9cC3:.\9;J@T_-HONd=gT)Lb/C\WeX5:A-IaU
#R\bZ;0N&NbP:\67=d9L/RJ0Y]eaF7egeB6FFH+E0^,#^&R=/BWH2McX-FBZMRB?
D4F\P2=]&]W/KTS7#[0a9JZe../GaJfe/6[fg5RW[3c05Z_-\-UXRPAFDf<gC5J,
&cQN3^7X_&?KJNXL9@(PES<]Q=A:NHN#_M0ffPWf],:/4gXcKMPA.c6,+1DC/2[C
[-9WY6Re1GC[J@1\-0HU&ScOb1<g]-@M?9K0?G84[(-G&<S#I[N]\0T+X&:L0P;4
W)+,^6R_&g3ND&VP3[BDHFC<]7+RZgCCOE\dKLU+4,IUV7)3#>Q7<MgC:X3X6E=Q
7\_3.a,\B:-^P^F7TMe2T;J&DW[_&BE\>g^fS1V,?B8+(2(K=M5gPHRZ:[I:\QH>
8fbcIbPKc18SA&HbAa3b/8CNV&GgaP=de^GCQW(5cCMf&F58>TF\K#]\[67@==@H
;/EZ1<YOC/)P3#BX10^?+@9UB80?=2;H>UX4J>7VDW>a+7&ZZ/0d&Ae?1</^(44M
CG?ZCC&N(6,8c40XG+=YQbA(O-[Ca]BadDE.RTIO@#?aH$
`endprotected

  
`endif //  `ifndef GUARD_SVT_UART_CONFIGURATION_SV
    
