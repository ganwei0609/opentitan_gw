
class svt_uart_txrx_callback extends svt_callback;
  
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the <b>svt_xactor_callbacks</b> parent class.
   *
   * @param name Identifies the callback instance.
   */
  extern function new(string name = "svt_uart_txrx_callback");
  
  /**
   * Callback issued after pulling a transaction descriptor out of its input 
   * TLM port, but before acting on the transaction descriptor in any way.
   *
   * @param component A reference to the component object issuing this callback. User's
   * callback implementation can use this to access the public data and/or methods of
   * the transactor.
   * 
   * @param xact A reference to the transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the transactor to discard the transaction descriptor without further action.
   */
  virtual function void post_seq_item_get(svt_uart_txrx component,svt_uart_transaction xact, ref bit drop);
  endfunction
  
endclass

`protected
&G6E7M4?OF+J8HC181^TCK<dd;(>[<WE9d34/5QH:H<:<=OCOB9V()3eO_;YbJ^.
+&:;N6/9TT;&LO:<0+TVNgDN:.4M,88BE-6VVMaBT&+-@I_^\X]E23Hd-fU&SeaS
TYg?8__R_3G1e3A,\9OPJ1X&E-VFGE1dI)V(JY)Ef-P2_2b@aBE&@],AN;=0N_8?
Zg^,+[J/IR2-8&X4P(:6.\@M)YVQ=3P7?Y#>K5\:JaTd?I3ReH7P@-,AI$
`endprotected

