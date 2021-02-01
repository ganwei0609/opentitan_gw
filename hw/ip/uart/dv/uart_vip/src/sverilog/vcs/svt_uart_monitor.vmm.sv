
`ifndef GUARD_SVT_UART_MONITOR_VMM_SV
`define GUARD_SVT_UART_MONITOR_VMM_SV

// =============================================================================
/**
 * This class is txrx extention of the port monitor to add a response request
 * port.
 */
class svt_uart_monitor extends svt_uart_txrx_port_monitor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_uart_txrx_port_monitor, svt_uart_transaction) response_request_port;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Common features of uart txrx components */
  protected svt_uart_txrx_common txrx_common;


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_uart_txrx_port_configuration cfg, vmm_object parent = null);


  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

//vcs_lic_vip_protect
`protected
b>F;<1RW/YS.Q9G#@aa;cfUD=5(4?F46U2-@N\Y#93XLOaKKd6DH1(Wd:GQ]cYNJ
KG?4=AGUdDZffG^X_>J&5B7g&DRG32P6B]E)BG>Y&&QeX_H0B;D4UKV&3c1^,K8@
&#cAIJA+DRX;>_5,]&Q-N^)A3bN-XWgSXM-;D@SQ]2;;;QFN:a3TS6+XR8OIAZ^[
I09ZcWX)OQd.Q)a=MP(OKD57IME;GRbE(_-M7WX[KEJg+1ZP6)W>AD(A/d1-W/3L
^f5E[@1=&DM]I?3Md_>A;XN5,7-UDaB>D+3:8X7#,<]@74>0b]TB7gR&>X36DPbV
L[^P?@5P[544IW=8Ja[@M(O.@)M:&:EX]WK[6_C0I.0@f4-;5D&b?WAN&S7G\Ea[
7:0SA>7SK48cT^+2\7J<7]@;41TW+]]SKW:75,N3AQDI;SXL0C>1]g:5BF2-<Wf3
.K>&-cVS#0EOLM=T1BYd?R]Bb+aNC]cID1.8XaF&g2:+98.IJ7I:aXA]DJ+8XLJ6
UK_-P[EL[MAT>>Z+=HVH(3MB,-(dP1YZJ+:cC04O+UBG2QG==,6(:B=]W;)20eN[
]C#W7?RC69I[/HL0Z]L=;VJ590V+^ODKE=Ngc>-,;Z6T?3#G7-bU_8^BYLIPZ@)#
#C)@&2Q@b&1Q2bLY#9H@G8J^JM.9+JTZB235Sf6I)b:1S<4IO\,:A_>&7FV0H4V?
Rc\&];1/NgLB3e[/AGVDbIbRGBcQ=1LP3DR#b0Pd2]X_^]Q@XMVC&297<4/K?WOY
ZHMJ^@TELRBYgE?8GL3_B6&#7L@WP0g-GT5dg0/Kf/VVQQb(^4CdZUEO1UO,f7cA
X1b14^KPdTP,1WP+6=3VV[GPeM5/O^&&Z]4(^TW/YLNN>gN0+5gGMe+Ug?F>Y[@C
gB3>_WGfQ[b:>(4]D9=0U?Pa[@cB+BVO=Xf1)^c)GG=<)(,L6Q&=6.?+b?5P0B1U
,1(&X(OR[.PZcIUC.X6;E>0ec>=U#@&CQe/+BfS#e0P>H\ZO>f1aJ,H?.?@7<&H>
WO&L[B&33F4?M=COWaP^:J0.GL(Ka;2=dE&BcdF7=45F8YWeF\\Hc.6ZJ>\7-A,,
Y3H#5=FU9a+AgBggN5;aa3U]AX84-Jaf7cg/,8O:fY?f&F8QB5UaJ9^3RWXHPK0f
g0IJ;2DD)?CFYB(G7>+b<XILYb&2ALWW7-BRSB_7KLAESCgbDF<X4D18fF;d:)RF
#96KfSI)ZfYG6A[_](WcF0)+;WQDSJRU&RXXR9[HSYTd?I,VFH.9)-FJ<gW_W8P5
[:G28G^-HfgQJLJH40()@c?f(#Ff:PUBZ\GRI(YPTAGb&2&HH#@LYF]]YEU6IFKM
Mc/:5^0U4MJ-^VfJ.2c9Z6L6YfQ=RbbWEI/(O<8L&M92-=B>1R?[QPb;C[P=J+@G
c^a&;AU\HU3OAA7G_DdcYZ,VE7+^[+^STV=J69;(1[K[E\aVCD..e^&e1@d/)62\Q$
`endprotected

// -----------------------------------------------------------------------------
// task svt_uart_monitor::protocol_specific_task ();
//   ADD PROTOCOL SPECIFIC TASK IMPLEMENTATIONS HERE
// endtask

`endif // GUARD_SVT_UART_MONITOR_VMM_SV


//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
