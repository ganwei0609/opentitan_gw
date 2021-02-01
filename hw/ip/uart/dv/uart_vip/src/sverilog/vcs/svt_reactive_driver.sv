//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_REACTIVE_DRIVER_SV
`define GUARD_SVT_REACTIVE_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_cmd_defines)

// =============================================================================
/**
 * Base class for all SVT reactive drivers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_driver#(type REQ=svt_data,
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_driver#(type REQ=`SVT_XVM(sequence_item),
                                   type RSP=REQ,
                                   type RSLT=RSP) extends svt_driver#(RSP,RSLT);
`endif
   
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else
  typedef svt_reactive_driver #(REQ, RSP, RSLT) this_type_reactive_driver;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,REQ,this_type_reactive_driver) req_item_port;
`endif   

/** @cond PRIVATE */
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
   
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************
  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(REQ) req_mbox;
/** @endcond */

  // ****************************************************************************
  // MCD logging properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   *
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, string inst, svt_configuration cfg, string suite_name);

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance, passing the appropriate argument
   * values to the uvm_driver parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the driver object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

`endif

  /** Send a request to the reactive sequencer */
  extern protected function void item_req(REQ req);

`ifndef SVT_VMM_TECHNOLOGY

  /** Impementation of get port of req_item_port. */
  extern task get(output REQ req);

`endif

endclass

// =============================================================================

`protected
C?Ag7<?ADF4ZWeSCT,[@R1]&B#;J^<3RO<9]Igf3]?c7O^<0>A656)YR<X^E-/f:
XcdDOOcPeGMIFZJZXH#S:@67.X+9Ae8KPJ7VECcMQ0U5BK<e60+D:V)I4:Fgb[R#
&P_]X)(BBI[I2XLX5ZT\V1E8>6f9=d>4dS]]U@dY[KPHSG02I]=6ba;-7JM,<;2A
&E^5(0CgQWU:g2M<bMZYCZ#aL?R/#1<)E+B8f7:K(#J<N@CRD5BK^EPG5+[/,JIX
UO.D=I#+cff?_:1?W]1H8Wd>c&C<>0N(Z7<RD38RG>=ENL^.9>?,MGJGN\M-7J=,
FaS1=0Z0KWG:6S9d^8PgARUJ&[URTCZ^dG(P7MXH[1@^^Q+PDN_a//USa.I7DBa@
QXgT10+eQ^_OebR[70:S;VITXWU\3-\(U@TF]L_ON_bZ66PLG)b)LF7T8c3GCN)Z
96bJZCaTBV(\CYJ(0E1BQ#1L>dW+(PQc@96=^aX()4Pf-O9Y-Q=SWW-C1CO.6&<^
1dNXB\2V.b\[,Y3cHFOGbcLL#7g129W=)c]L:Q48(8ZYU0cf255&[&B\C+:+TG8#
9+3N5JQI+)c<VCI]302be?d</&9FWX=;A&C(:I2R79&g>H-AD26#A<6QL>E88:Zc
A_??TAU=0Of)^3:UO..E-Z.A1IT6a)_9OfH5/.\NGAgCZ([7[7(P4XTSVQKSZPE?
M1dIK<#gOe3U3,GPc_O/ZH?O8eFQ+TMO9$
`endprotected


//svt_vcs_lic_vip_protect
`protected
EI<\M-eBJN()@0EfO;\6)=0>VLR2=LfdM5VY7R[WBce<&?gX;2P]6((P<6;E,EPL
&R=a9FYO8;bZ#e]PD=IA7>[P<UNRJ;d#2@&(_ENO]4N;2NI@Z[LP4X<]#+cBDZe[
0(_FW35=B_a,W(BYNB#DJ]6-?4VA>>EUN?=3_0#fa<5Sd45#<BZZ&/)c@MdW.>ZE
4,a^H[G_d2F+2HO_fg-L0bPP<N&RLHF1A_JTC,bB]80\@bU@VbPf#R=d4Cc(]b>8
:(\)9:.M):F3)3:Ue0L#bVf&N[<BR5dXd?:GV=X4P02bB193K9fXLQaCK5:6)43e
KH/D4TKW+-JNIP<g<KKaZdH@b2.Y[BYA6L/4Pa[g=@bMDa+fa/_2W:VHbS\Fd2<S
0(UTS(RK3A1@_.;)T,#dId.XLZ>JFD;Xa3cX/]9P-:BDE4W1PDPDV;@/L>80Db;\
@NO3Vb[Obf3G55ZUf&bZ\S84&c(@I9G#E0\11AFHLJBDD-G.I=48(@UUR\UY5RXQ
]Z9F>]H@C^I5:4&JXbW00.?FS3OGM16YILB-39XTAVU@,fT@,938af66fYA1L>=T
U#ZA/RJY)O9<&CcFX6CT.dQXcAP^f.@XUXCZI=\Q&-Y3,RHWZ.)0(f;6YOa;+NMa
42eEN\Ued]/1N#QHP037YBXLIUNR\b5S7K?TK^Ea+LbW(U]YQLg=<b:>;R^#NIHI
<O3ag3DP:9E0I=G<UHID21QPJgfc;g3bgK+:2>g#L9(.bX,(P&<@U?8#4A2Re(:]
<1ObBIIR_<_],bEV3136[-SYKa6=ILd,_-A9X,d[?5V3LaWEKH0d-G?#UAC,_DJ.
7HY4O#>;6@0\bbd<^5Y51C&Q5C3F6?2,GbWe():+)S_]?0,_CVVZ[8d56S5IMY#U
8_UJ.?dR/U0AaIVT[&=W.VeYM&d-5FT^.aY_2/>,5[T]F$
`endprotected


`endif // GUARD_SVT_REACTIVE_DRIVER_SV
