
`ifndef GUARD_SVT_UART_MONITOR_CALLBACK_SV
`define GUARD_SVT_UART_MONITOR_CALLBACK_SV

/**
 * Monitor callback class contains the callback methods called by the UART
 * Monitor component.
 */
class svt_uart_monitor_callback extends svt_callback;

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  extern function new(string name = "svt_uart_monitor_callback");

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  virtual function void pre_xact_observed_put(svt_uart_monitor monitor,svt_uart_transaction xact, ref bit drop);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction that is put into the analysis port.
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   */
  virtual function void xact_observed_cov(svt_uart_monitor monitor, svt_uart_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Called when transaction start is observed on port
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   */
  virtual function void transaction_started(svt_uart_monitor monitor, svt_uart_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called when transaction end is observed on port
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   */
  virtual function void transaction_ended(svt_uart_monitor monitor, svt_uart_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called before putting a configuration
  *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param cfg A reference to the configuration descriptor object of interest.
   */
  virtual function void config_pre_output_port_put(svt_uart_monitor monitor, svt_uart_configuration cfg);
  endfunction

endclass

`protected
<IR#3C-JC)C]6P,9fQ(\7eB0<,ETBXU\PC-65A_[\VB@6^X/C>J0/)(U8LQU,@N/
&)^dB\1>&Ye]WMEYf?O-:_ed=abU?MQOE?e@6Vb\+YOeTPC(#cFa5[.C[WgT1EA&
P8b<b(+#;\Q4.U6C>;5VKf26.;9eD7O5<.cVCJS9&7TU)9ETXMUf,0AdUH[[1,(^
B.J29XO&K+M\C[1M/]0Q(9/]Hc>9G(Xa@<.,^B1D12fNCLDB=D(/(YU.(3HfUH:PW$
`endprotected


`endif // GUARD_SVT_UART_MONITOR_CALLBACK_SV

