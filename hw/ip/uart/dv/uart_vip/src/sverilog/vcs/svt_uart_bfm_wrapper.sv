// Module svt_uart_bfm_wrapper
// ------------------------------------------------------------------------------------------------
module svt_uart_bfm_wrapper (svt_uart_if port_if);

   //Parameter to specify Device type i.e. DTE or DCE
   parameter UV_DEVICE_TYPE = `SVT_UART_DTE;
   parameter SVT_UART_DEVICE_TYPE = UV_DEVICE_TYPE;
   parameter SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK = 1;
   
   // Generate block is required because internally we have separate modules for DTE & DCE
   generate

      // User will configure the parameter UV_DEVICE_TYPE while creating wrapper instance
      if(SVT_UART_DEVICE_TYPE === `SVT_UART_DTE) begin : dte
	 
	 // Make DTE BFM Instance
	 `SVT_UART_DTE_WRAPPER #(.SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK(SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK)) bfm0 (port_if,port_if.bfm_if,port_if.bfm_mon_if,port_if.bfm_chk_if);
	 
      end else begin : dce

	 // Make DCE BFM Instance
	 `SVT_UART_DCE_WRAPPER #(.SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK(SVT_UART_ENABLE_WRAPPER_CONNECTION_CHECK)) bfm1 (port_if,port_if.bfm_if,port_if.bfm_mon_if,port_if.bfm_chk_if);
	 
      end // block: dce
   endgenerate
   
endmodule // svt_uart_bfm_wrapper

