
`ifndef GUARD_SVT_UART_MONITOR_EVENT_CONTROLLER_SV
`define GUARD_SVT_UART_MONITOR_EVENT_CONTROLLER_SV

typedef class svt_uart_monitor;

/** @cond PRIVATE */

class svt_uart_monitor_event_controller extends svt_event_controller;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Enum to represent event types that this controller supports */
  typedef enum {
    EVENT_100G_PCS_DO_ERR
  } event_type_enum;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Enum value to represent the event type that this instance controls */
  local event_type_enum event_type;

  /** Virtual interface which contains the signals from the BFM */
  `ifndef __SVDOC__
  local virtual interface svt_uart_sv_bfm_if vif_bfm;
  `else
  local svt_uart_sv_bfm_if vif_bfm;
  `endif

  /** Flag that gets set when the virtual interface is valid */
  local bit vif_valid = 0;

  /** Handle to the monitor instance where this event is created */
  local svt_uart_monitor monitor;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new controller instance to watch for one specific event
   *
   * @param monitor Instance name of uart monitor
   * @param event_type event_type enum
   */
  extern function new (svt_uart_monitor monitor, event_type_enum event_type);

  /** Assign the virtual interface to the local property */
  `ifndef __SVDOC__
  extern virtual function void assign_vif(virtual interface svt_uart_sv_bfm_if vif_bfm);
  `else
  extern virtual function void assign_vif(svt_uart_txrx_bfm_if vif_bfm);
  `endif

  /**
   * Virtual method which is called by the svt_controlled_event to initiate the logic
   * that waits for the external condition.
   */
  extern virtual task wait_for_condition(ref `SVT_XVM(object) data);

endclass

/** @endcond */


`protected
6CJ\O#:#-CS8Ha_338=_([6IERMG]XI_04ZX^^YRRH9H.f+c?\R27)ZAa0)VC(\c
\?&]D?R2a3#L;I?)@1NK5@FY:YcY=HE_:#1:VTSUN\(8[W[G7f7ALSW&9@TeeRP#
GV&8UP:X(TQ:UN@6[SFfX,F=K-?Zb65H60b251I_.:d.d47J2+AG&WL/2P?>.FV8
G5KKDOI.d<<:X^Q<()3egW<.DNR6:dMG?13TX+;+=@KU[.#gS5DT\;O<:9Ye6EL0
c0FV:YfM.NZ>;)PVE8=,QTXHU<3K<H=06fS2GU),;K5d3b>EHH\JFDGE>YW_S08M
/+bQ6(g2095F2^\.S_Z^da:?8Yf]D(XD)V0cSe)IXc1GZ2=S>4]?+_5OfWTCR:^S
;5:eON.\?(8AUf0:QcMbA>CDGN5Ag-a)5C6Bdf(L)F#=1P>Hb5BG8>^Jd3IRS02,
230dINQ1T+BAd@H=YZ@#E_Xg>WYMBE#\W[O5OLNB=0?J.GcW9Ue><(ZYHY80V?87
(/RIcYBW&_(?bVBIc4Lf]f#S?4GFcTX0C01,KK1bF_dVJBe0ZG-X?->;)>EgU&a)
K5\?bfdXXOg(N45)^8M5@?KB0^K4HGV<U#T29d[=35<?ecLWT.&,eU/X>W.gd7A,
;JF6]Z9P;LZ^.#I2P(&\bJ7)H\WOF]A_3N_).6_+IAV/DLQc7f[+K)R(MabI?L)X
(:4]/UHLIWP;F1A+fd<]=[)d]N;&H)5G;4HEC1WI2?M)2@\9^4)AE;_&N.1P7X^<
<I]+XH=:DQ:SWQE):W2K3A-@7T_?D1NZR7G=@-ZFJ_:Z>/=R4b4-W=6cfT-XE6[V
6C0^G=RB2@H)I#]4QO=L;LfWgW]e1KBdW7QENLQD1Q.62Og&LfTMKC5W_^4]8YfT
Kg2d3eaQcg&:E1R14US52D\96W676d+VId:HH<gc]W&6H$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_MONITOR_EVENT_CONTROLLER_SV
   


