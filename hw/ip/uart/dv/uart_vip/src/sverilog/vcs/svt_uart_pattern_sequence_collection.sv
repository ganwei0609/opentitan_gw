
`ifndef GUARD_SVT_UART_PATTERN_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_UART_PATTERN_SEQUENCE_COLLECTION_SV

/** Defines for all the pattern sequences */
`define SVT_UART_COV_UTIL_FRAMING_ERR_FOLLOWED_BY_FRAMING_ERR_SEQ 'd1
`define SVT_UART_COV_UTIL_BREAK_FOLLOWED_BY_BREAK_SEQ 'd2

/**
 * Class represents a pattern sequence, which needs to scanned for
 * transmitted transactions.<br>
 * This sequence is used to recognize following sequence in transactions :
 *    - Framing Error -> Framing Error
 *    .
 * <br>This pattern sequence is used as coverpoint in the following covergroups:
 *    - svt_uart_monitor_def_cov_callback::scenario_sequence
 *    .
 */  
class svt_uart_framing_err_followed_by_framing_err_pattern_sequence extends svt_pattern_sequence; 

  extern function new();

endclass

function svt_uart_framing_err_followed_by_framing_err_pattern_sequence::new();
  begin
    super.new(`SVT_UART_COV_UTIL_FRAMING_ERR_FOLLOWED_BY_FRAMING_ERR_SEQ,3, "framing_err_followed_by_framing_err_seq");
    add_prop(0, "direction", svt_uart_transaction::TX);
    add_prop(0, "exception_list.framing_error_exists", 1);
    
    add_prop(1, "direction", svt_uart_transaction::RX);
    pttrn[1].match_min = 0;
    pttrn[1].match_max = 5;
    pttrn[1].gap_pattern = 1;
    
    add_prop(2, "direction", svt_uart_transaction::TX);    
    add_prop(2, "exception_list.framing_error_exists", 1);
    
  end
endfunction

/**
 * Class represents a pattern sequence, which needs to scanned for
 * transmitted transactions.<br>
 * This sequence is used to recognize following sequence in transactions :
 *    - Break -> Break
 *    .
 * <br>This pattern sequence is used as coverpoint in the following covergroups:
 *    - svt_uart_monitor_def_cov_callback::scenario_sequence
 *    .
 */  
class svt_uart_break_followed_by_break_pattern_sequence extends svt_pattern_sequence; 

  extern function new();

endclass

function svt_uart_break_followed_by_break_pattern_sequence::new();
  begin
    super.new(`SVT_UART_COV_UTIL_BREAK_FOLLOWED_BY_BREAK_SEQ, 3, "break_followed_by_break_seq");
    add_prop(0, "direction", svt_uart_transaction::TX);
    add_prop(0, "break_cond", 1);
    
    add_prop(1, "direction", svt_uart_transaction::RX);
    pttrn[1].match_min = 0;
    pttrn[1].match_max = 5;
    pttrn[1].gap_pattern = 1;
    
    add_prop(2, "direction", svt_uart_transaction::TX);    
    add_prop(2, "break_cond", 1);
  end
endfunction

`endif //  `ifndef GUARD_SVT_UART_PATTERN_SEQUENCE_COLLECTION_SV

