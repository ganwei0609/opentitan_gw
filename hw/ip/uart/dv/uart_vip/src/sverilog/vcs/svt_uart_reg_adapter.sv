
`ifndef GUARD_SVT_UART_REG_ADAPTER_SV
`define GUARD_SVT_UART_REG_ADAPTER_SV

class svt_uart_reg_adapter extends uvm_reg_adapter;
  
  /**uart_svt_transaction**/
  svt_uart_transaction uart_reg_trans;

  // ****************************************************************************
  `uvm_object_utils_begin(svt_uart_reg_adapter)
    `uvm_field_object(uart_reg_trans, UVM_ALL_ON);
  `uvm_object_utils_end
  //-----------------------------------------------------------------------------
  
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name= "svt_uart_reg_adapter");

  /** Convert a UVM RAL transaction into an AHB transaction */
  extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  
  /** Convert AHB transaction back to into a UVM RAL transaction */
  extern virtual function void bus2reg(uvm_sequence_item bus_item,
                                ref uvm_reg_bus_op rw);
endclass

   function svt_uart_reg_adapter::new(string name = "svt_uart_reg_adapter");
      super.new(name);
      
      /**
       * If the bus protocol supports byte lane enables 
       * (i.e., it is possible to read or write individual bytes in a multibyte bus), 
       * the supports_byte_enable class property should be set to TRUE in the constructor.
       */
      supports_byte_enable = 1;
      
      /**
       * The provides_responses class property should be set to TRUE if the bus driver returns responses,
       * e.g., the result of a read operation, in a separate response descriptor:
       */
      provides_responses = 1;
     `uvm_info("svt_uart_reg_adapter", "Constructed", UVM_LOW);
   endfunction
  
   // -----------------------------------------------------------------------------
   function uvm_sequence_item svt_uart_reg_adapter::reg2bus(const ref uvm_reg_bus_op rw);
     uart_reg_trans = svt_uart_transaction::type_id::create("uart_reg_trans");
     uart_reg_trans.direction = (rw.kind == UVM_READ) ? svt_uart_transaction::RX : svt_uart_transaction::TX;
     uart_reg_trans.packet_count = rw.n_bits/8;
     uart_reg_trans.enable_packet_generation = (rw.kind == UVM_READ) ? 1'b0 : 1'b1;
     uart_reg_trans.payload = new[rw.n_bits/8];
     uart_reg_trans.payload[0] = rw.data[8:0];
       `uvm_info("adapter_reg2bus", $sformatf("WRITE: payload = %0d ", uart_reg_trans.payload[0]),UVM_LOW);
     return uart_reg_trans;
   endfunction: reg2bus

   // -----------------------------------------------------------------------------
    function void svt_uart_reg_adapter::bus2reg(uvm_sequence_item bus_item,
                              ref uvm_reg_bus_op rw);
     svt_uart_transaction bus_trans; 
     if(!$cast(bus_trans, bus_item))begin
       `uvm_fatal("BUS2REG", "bus_item is not correct type");
     end
     rw.kind = (bus_trans.direction==svt_uart_transaction::RX) ?  UVM_READ : UVM_WRITE;
     rw.data[7:0] = 2;
     rw.status = UVM_IS_OK;
       `uvm_info("adapter_bus2reg", $sformatf("RX: rw.data = %0d", rw.data ),UVM_LOW);
   endfunction: bus2reg

`endif // GUARD_SVT_UART_REG_ADAPTER_SV


 
