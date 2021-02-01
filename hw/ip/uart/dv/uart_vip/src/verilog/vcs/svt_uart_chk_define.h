//--------------------------------------------------------------------
// STATE MACHINE DEFINES
//--------------------------------------------------------------------
// Upstream idle state define
//--------------------------------------------------------------------
`define		UV_CHK_U_IDLE_STATE 		      	3'b000
//--------------------------------------------------------------------
// Upstream handshake state define
//--------------------------------------------------------------------
`define		UV_CHK_U_HAND_DET_STATE		        3'b001
//--------------------------------------------------------------------
// Upsteam start detect state define
//--------------------------------------------------------------------
`define		UV_CHK_U_START_DET_STATE  		3'b010
//--------------------------------------------------------------------
// Upstream receive data state define
//--------------------------------------------------------------------
`define		UV_CHK_U_RECE_DATA_STATE  		3'b011
//--------------------------------------------------------------------
// Downstream idle state define
//--------------------------------------------------------------------
`define		UV_CHK_D_IDLE_STATE 		      	3'b100
//--------------------------------------------------------------------
// Downstream handshake state define 
//--------------------------------------------------------------------
`define		UV_CHK_D_HAND_DET_STATE		        3'b101
//--------------------------------------------------------------------
// Downstream start data state define
//--------------------------------------------------------------------
`define		UV_CHK_D_START_DET_STATE  		3'b110
//--------------------------------------------------------------------
// Downstream receive data state define
//--------------------------------------------------------------------
`define		UV_CHK_D_RECE_DATA_STATE  		3'b111
//--------------------------------------------------------------------
// 
//--------------------------------------------------------------------
`define		UV_CHK_RTS_DETECTED			1001
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_DTR_NOT_DETECTED			1002
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_DTR_DETECTED			1003
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_START_DETECTED			1004
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_START_NOT_DETECTED		1005
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_DATA  				1006
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_STOP_DETECTED			1007
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_STOP_NOT_DETECTED		1008
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_PARITY				1009
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_DTR_DEASS			1010
//--------------------------------------------------------------------
//
//--------------------------------------------------------------------
`define		UV_CHK_RTS_DEASS			1011
//--------------------------------------------------------------------
// Checker rule Upstream invalid stop bits define
//--------------------------------------------------------------------
`define		UV_CHK_INVAL_STOP_BITS_U                5000
//--------------------------------------------------------------------
// Checker rule Downstream invalid stop bits define
//--------------------------------------------------------------------
`define		UV_CHK_INVAL_STOP_BITS_D                5001
//--------------------------------------------------------------------
// Checker rule invalid divisor define
//--------------------------------------------------------------------
`define		UV_CHK_INVAL_DIVISOR		        5002
//--------------------------------------------------------------------
// Checker rule Upstream parity mismatch define
//--------------------------------------------------------------------
`define		UV_CHK_PARITY_MISMATCH_U	 	5003
//--------------------------------------------------------------------
// Checker rule Downstream parity mismatch define
//--------------------------------------------------------------------
`define		UV_CHK_PARITY_MISMATCH_D	 	5004
//--------------------------------------------------------------------
// Checker rule Downstream dtr not idle define
//--------------------------------------------------------------------
`define		UV_CHK_CTS_BEFORE_RTS		        5005
//--------------------------------------------------------------------
// Checker rule Downstream sout not idle define
//--------------------------------------------------------------------
`define		UV_CHK_SOUT_BY_DTE_BEFORE_HNDSHK		        5006
//--------------------------------------------------------------------
// Checker rule Upstream dtr not idle define
//--------------------------------------------------------------------
`define		UV_CHK_RTS_BEFORE_DTR		        5007
//--------------------------------------------------------------------
// Checker rule Upstream sout not idle define
//--------------------------------------------------------------------
`define		UV_CHK_CTS_BEFORE_DSR		        5008
//--------------------------------------------------------------------
// Checker rule Upstream start timeout define
//--------------------------------------------------------------------
`define		UV_CHK_SIN_BY_DCE_BEFORE_DSR		        5009
//--------------------------------------------------------------------
// Checker rule Downstream start timeout define
//--------------------------------------------------------------------
`define		UV_CHK_SIN_BY_DCE_BEFORE_DTR		        5010
//--------------------------------------------------------------------
// Checker rule Upstream break detected define
//--------------------------------------------------------------------
`define		UV_CHK_BRK_DET_U	                5011
//--------------------------------------------------------------------
//Checker rule Downstream break detected define
//--------------------------------------------------------------------
`define		UV_CHK_BRK_DET_D	                5012
//--------------------------------------------------------------------
//Checker rule Upstream XOFF not detected define
//--------------------------------------------------------------------
`define		UV_CHK_XON_NOT_TRANS_U	                5016
//--------------------------------------------------------------------
//Checker rule Downstream invalid transaction between XOFF and XON define
//--------------------------------------------------------------------
`define		UV_CHK_INVAL_TRANS_BET_OFF_ON_D		5018
//--------------------------------------------------------------------
//Checker rule RTS Asserted before DSR
//--------------------------------------------------------------------
`define		UV_CHK_RTS_BEFORE_DSR             	5019
//--------------------------------------------------------------------
//Checker rule DTR Deasserted by DTE during RTS/CTS handshake
//--------------------------------------------------------------------
`define		UV_CHK_DTR_DEASSERT_DURING_HNDSHK 	5020
//--------------------------------------------------------------------
//Checker rule DSR Deasserted by DTE during RTS/CTS handshake
//--------------------------------------------------------------------
`define		UV_CHK_DSR_DEASSERT_DURING_HNDSHK 	5021
//--------------------------------------------------------------------
//Checker rule RTS Deasserted by DTE before RTS/CTS handshake could complete
//--------------------------------------------------------------------
`define		UV_CHK_RTS_DEASSERT_DURING_HNDSHK 	5022
//--------------------------------------------------------------------
//Checker rule CTS Asserted before DTR
//--------------------------------------------------------------------
`define		UV_CHK_CTS_BEFORE_DTR             	5023
//--------------------------------------------------------------------
//Checker rule SOUT Asserted before DSR
//--------------------------------------------------------------------
`define		UV_CHK_SOUT_BY_DTE_BEFORE_DSR     	5024
//--------------------------------------------------------------------
//Checker rule SOUT Asserted before DTR
//--------------------------------------------------------------------
`define		UV_CHK_SOUT_BY_DTE_BEFORE_DTR     	5025
//--------------------------------------------------------------------
//Checker rule DTR Deasserted during Downstream transfer
//--------------------------------------------------------------------
`define		UV_CHK_DTR_DEASSERT_DURING_DATA_D 	5026
//--------------------------------------------------------------------
//Checker rule  DSR Deasserted during Downstream transfer
//--------------------------------------------------------------------
`define		UV_CHK_DSR_DEASSERT_DURING_DATA_D 	5027
//--------------------------------------------------------------------
//Checker rule DTR Deasserted during Upstream transfer
//--------------------------------------------------------------------
`define		UV_CHK_DTR_DEASSERT_DURING_DATA_U 	5028
//--------------------------------------------------------------------
//Checker rule DSR Deasserted during Upstream transfer
//--------------------------------------------------------------------
`define		UV_CHK_DSR_DEASSERT_DURING_DATA_U 	5029
//--------------------------------------------------------------------
//Checker rule XOFF Detected with Invalid Parity
//--------------------------------------------------------------------
`define		UV_XOFF_WITH_INVAL_PARITY 	        5030
//--------------------------------------------------------------------
//Checker rule XON Detected with Invalid Parity
//--------------------------------------------------------------------
`define		UV_XON_WITH_INVAL_PARITY 	        5031
//--------------------------------------------------------------------
//Checker rule SIN not Idle when CTS is de-asserted
//--------------------------------------------------------------------
`define		UV_SIN_NOT_IDLE_WHN_CTS_HIGH            5032
//--------------------------------------------------------------------
//Checker rule SOUT not Idle when CTS is de-asserted
//--------------------------------------------------------------------
`define		UV_SOUT_NOT_IDLE_WHN_CTS_HIGH           5033
//--------------------------------------------------------------------
//Checker rule : False start bit detected on Upstream
//--------------------------------------------------------------------
`define		UV_FALSE_START_U                        5034
//--------------------------------------------------------------------
//Checker rule : False start bit detected on Downstream
//--------------------------------------------------------------------
`define		UV_FALSE_START_D                        5035
//--------------------------------------------------------------------
//Checker rule : x or z detected on re,de or rs485 gpio pin 
//--------------------------------------------------------------------
`define	  UV_RS485_DE_RE_RS485_PIN_CANNOT_BE_X_OR_Z     5036	
//--------------------------------------------------------------------
//Checker rule : Derivation on re de detected when rs485 pin is off 
//--------------------------------------------------------------------
`define	  UV_RS485_NO_RE_DE_IF_RS485_PIN_OFF          	5037
//--------------------------------------------------------------------
//Checker rule : Both re and de asserted high when mode is Half Duplex 
//--------------------------------------------------------------------
`define	  UV_RS485_DE_RE_BOTH_NOT_HIGH_HALF_DUPLEX_CHK	5038
//--------------------------------------------------------------------
//Checker rule : SIN and SOUT not Idle when re and de are de-asserted
//--------------------------------------------------------------------
`define	  UV_RS485_NO_DERIVE_SOUT_SIN_IF_DE_RE_OFF    	5039
//--------------------------------------------------------------------
//Checker rule : SOUT not Idle when de is de-asserted
//--------------------------------------------------------------------
`define	  UV_RS485_NO_DERIVE_SOUT_IF_DE_OFF             5040	
//--------------------------------------------------------------------
//Checker rule : SIN not Idle when re is de-asserted
//--------------------------------------------------------------------
`define	  UV_RS485_NO_DERIVE_SIN_IF_RE_OFF              5041	
//--------------------------------------------------------------------
//Checker rule : de assertion timing delay violated 
//--------------------------------------------------------------------
`define	  UV_RS485_DE_ASSERTION                         5042	
//--------------------------------------------------------------------
//Checker rule : de deassertion timing delay violated
//--------------------------------------------------------------------
`define	  UV_RS485_DE_DEASSERTION                       5043	
//--------------------------------------------------------------------
//Checker rule : de to re turnaround timing delay violated
//--------------------------------------------------------------------
`define	  UV_RS485_DE_TO_RE_TURNAROUND                  5044	
//--------------------------------------------------------------------
//Checker rule : re to de turnaround timing dealy violated
//--------------------------------------------------------------------
`define	  UV_RS485_RE_TO_DE_TURNAROUND                  5045	
//--------------------------------------------------------------------
//Checker rule : z or x on rts not expected
//--------------------------------------------------------------------
`define	  UV_CHK_Z_X_ON_RTS                             5046	
//--------------------------------------------------------------------
//Checker rule : z or x on cts not expected
//--------------------------------------------------------------------
`define	  UV_CHK_Z_X_ON_CTS                             5047	
//--------------------------------------------------------------------
//Checker rule : z or x on dtr not expected
//--------------------------------------------------------------------
`define	  UV_CHK_Z_X_ON_DTR                             5048	
//--------------------------------------------------------------------
//Checker rule : z or x on dsr not expected
//--------------------------------------------------------------------
`define	  UV_CHK_Z_X_ON_DSR                             5049	

`ifdef SVT_UART_DCE_NEW_BEHV 
//--------------------------------------------------------------------
//Checker rule : Data on sin not expected in half duplex hardware handshaking mode
//--------------------------------------------------------------------
`define	  UV_NO_SIN_DRIVE_IN_HALF_DUPLEX                5050	
`endif
//--------------------------------------------------------------------
//Checker rule : re assertion timing delay violated
//--------------------------------------------------------------------
//`define	  UV_RS485_RE_ASSERTION                         5046	
//--------------------------------------------------------------------
//Checker rule : re deassertion timing delay violated
//--------------------------------------------------------------------
//`define	  UV_RS485_RE_DEASSERTION                       5047	
//--------------------------------------------------------------------

`define SVT_UART_CHK_BRK_DET_U                              `UV_CHK_BRK_DET_U
`define SVT_UART_CHK_PARITY_MISMATCH_D                      `UV_CHK_PARITY_MISMATCH_D
`define SVT_UART_CHK_INVAL_STOP_BITS_D                      `UV_CHK_INVAL_STOP_BITS_D
`define SVT_UART_CHK_BRK_DET_D                              `UV_CHK_BRK_DET_D
`define SVT_UART_CHK_INVAL_STOP_BITS_U                      `UV_CHK_INVAL_STOP_BITS_U
`define SVT_UART_CHK_PARITY_MISMATCH_U                      `UV_CHK_PARITY_MISMATCH_U
`define SVT_UART_CHK_CTS_BEFORE_RTS                         `UV_CHK_CTS_BEFORE_RTS
`define SVT_UART_CHK_SOUT_BY_DTE_BEFORE_HNDSHK              `UV_CHK_SOUT_BY_DTE_BEFORE_HNDSHK
`define SVT_UART_CHK_RTS_BEFORE_DTR                         `UV_CHK_RTS_BEFORE_DTR
`define SVT_UART_CHK_CTS_BEFORE_DSR                         `UV_CHK_CTS_BEFORE_DSR
`define SVT_UART_CHK_SIN_BY_DCE_BEFORE_DSR                  `UV_CHK_SIN_BY_DCE_BEFORE_DSR
`define SVT_UART_CHK_SIN_BY_DCE_BEFORE_DTR                  `UV_CHK_SIN_BY_DCE_BEFORE_DTR
`define SVT_UART_CHK_XON_NOT_TRANS_U                        `UV_CHK_XON_NOT_TRANS_U
`define SVT_UART_CHK_INVAL_TRANS_BET_OFF_ON_D               `UV_CHK_INVAL_TRANS_BET_OFF_ON_D
`define SVT_UART_CHK_RTS_BEFORE_DSR                         `UV_CHK_RTS_BEFORE_DSR
`define SVT_UART_CHK_DTR_DEASSERT_DURING_HNDSHK             `UV_CHK_DTR_DEASSERT_DURING_HNDSHK
`define SVT_UART_CHK_DSR_DEASSERT_DURING_HNDSHK             `UV_CHK_DSR_DEASSERT_DURING_HNDSHK
`define SVT_UART_CHK_RTS_DEASSERT_DURING_HNDSHK             `UV_CHK_RTS_DEASSERT_DURING_HNDSHK
`define SVT_UART_CHK_CTS_BEFORE_DTR                         `UV_CHK_CTS_BEFORE_DTR
`define SVT_UART_CHK_SOUT_BY_DTE_BEFORE_DSR                 `UV_CHK_SOUT_BY_DTE_BEFORE_DSR
`define SVT_UART_CHK_SOUT_BY_DTE_BEFORE_DTR                 `UV_CHK_SOUT_BY_DTE_BEFORE_DTR
`define SVT_UART_CHK_DTR_DEASSERT_DURING_DATA_D             `UV_CHK_DTR_DEASSERT_DURING_DATA_D
`define SVT_UART_CHK_DSR_DEASSERT_DURING_DATA_D             `UV_CHK_DSR_DEASSERT_DURING_DATA_D
`define SVT_UART_CHK_DTR_DEASSERT_DURING_DATA_U             `UV_CHK_DTR_DEASSERT_DURING_DATA_U
`define SVT_UART_CHK_DSR_DEASSERT_DURING_DATA_U             `UV_CHK_DSR_DEASSERT_DURING_DATA_U
`define SVT_UART_XOFF_WITH_INVAL_PARITY                     `UV_XOFF_WITH_INVAL_PARITY
`define SVT_UART_XON_WITH_INVAL_PARITY                      `UV_XON_WITH_INVAL_PARITY
`define SVT_UART_SIN_NOT_IDLE_WHN_CTS_HIGH                  `UV_SIN_NOT_IDLE_WHN_CTS_HIGH
`define SVT_UART_SOUT_NOT_IDLE_WHN_CTS_HIGH                 `UV_SOUT_NOT_IDLE_WHN_CTS_HIGH
`define SVT_UART_FALSE_START_U                              `UV_FALSE_START_U
`define SVT_UART_FALSE_START_D                              `UV_FALSE_START_D
`define	SVT_UART_RS485_DE_RE_RS485_PIN_CANNOT_BE_X_OR_Z     `UV_RS485_DE_RE_RS485_PIN_CANNOT_BE_X_OR_Z   
`define	SVT_UART_RS485_NO_RE_DE_IF_RS485_PIN_OFF          	`UV_RS485_NO_RE_DE_IF_RS485_PIN_OFF          
`define	SVT_UART_RS485_DE_RE_BOTH_NOT_HIGH_HALF_DUPLEX_CHK	`UV_RS485_DE_RE_BOTH_NOT_HIGH_HALF_DUPLEX_CHK
`define	SVT_UART_RS485_NO_DERIVE_SOUT_SIN_IF_DE_RE_OFF    	`UV_RS485_NO_DERIVE_SOUT_SIN_IF_DE_RE_OFF    
`define	SVT_UART_RS485_NO_DERIVE_SOUT_IF_DE_OFF             `UV_RS485_NO_DERIVE_SOUT_IF_DE_OFF           
`define	SVT_UART_RS485_NO_DERIVE_SIN_IF_RE_OFF              `UV_RS485_NO_DERIVE_SIN_IF_RE_OFF            
`define	SVT_UART_RS485_DE_ASSERTION                         `UV_RS485_DE_ASSERTION                       
`define	SVT_UART_RS485_DE_DEASSERTION                       `UV_RS485_DE_DEASSERTION                     
`define	SVT_UART_RS485_DE_TO_RE_TURNAROUND                  `UV_RS485_DE_TO_RE_TURNAROUND                
`define	SVT_UART_RS485_RE_TO_DE_TURNAROUND                  `UV_RS485_RE_TO_DE_TURNAROUND                
`define	SVT_UART_CHK_Z_X_ON_RTS                             `UV_CHK_Z_X_ON_RTS                
`define	SVT_UART_CHK_Z_X_ON_CTS                             `UV_CHK_Z_X_ON_CTS                
`define	SVT_UART_CHK_Z_X_ON_DTR                             `UV_CHK_Z_X_ON_DTR                
`define	SVT_UART_CHK_Z_X_ON_DSR                             `UV_CHK_Z_X_ON_DSR                
`ifdef SVT_UART_DCE_NEW_BEHV 
`define	SVT_UART_NO_SIN_DRIVE_IN_HALF_DUPLEX                `UV_NO_SIN_DRIVE_IN_HALF_DUPLEX                
`endif
//`define	SVT_UART_RS485_RE_ASSERTION                         `UV_RS485_RE_ASSERTION                       
//`define	SVT_UART_RS485_RE_DEASSERTION                       `UV_RS485_RE_DEASSERTION                     

//vcs_vip_protect 
`protected
L3aM4[1<adfZIB+&5>.#f.SW1TaK#&]ggP4C77If]^[]9/:RaWF04(I-UE_3(=e^
:\CcN6MCII2Z*$
`endprotected





//*************************************END OF FILE*******************************************


