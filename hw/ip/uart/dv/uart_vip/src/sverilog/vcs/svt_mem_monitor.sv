//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_MONITOR_SV
`define GUARD_SVT_MEM_MONITOR_SV

//typedef class svt_mem_monitor_callback;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT MEM UVM/OVM monitors.
 */
virtual class svt_mem_monitor#(type REQ=svt_mem_transaction) extends svt_monitor#(REQ);

  //`svt_xvm_register_cb(svt_mem_monitor#(REQ), svt_mem_monitor_callback)

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Monitor Configuration */
  local svt_mem_configuration cfg = null;

 /** Monitor Configuration snapshot */
  protected svt_mem_configuration cfg_snapshot = null;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the monitor object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name="svt_mem_monitor");

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the monitor's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the monitor
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the monitor's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_static_cfg

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_dynamic_cfg

`protected
ZRf:.E6Zd0.C-Q;ZWIHB0f25)@@&=&-2d-IbI)BY-)S15\1P]c.O1)+2HSLR4-H[
=Z_0gF?K0,OC0$
`endprotected


  // ---------------------------------------------------------------------------
endclass


// =============================================================================

`protected
e_=&9B.d=/IWF=g0c-(9?KAe_?_@a6XCW?Bee)FF@[U9\;?L6OdG()W4f)\4U;>L
]WP@>99MNf03Z/fU0NB4/^A\f/g]T+@7O=I#/);g-d?/T7d3=.S+11OJ1J/87adc
.3BE[0bLAE+Pb4BWNC?g62&]cZL(\\<E\.SJ,3(cKD&9MF,)M#0BE](:#T].0HbE
QAgCd;R=9#S-RIDF^#ER6DX5.3TME]0Z_(46S1G[5+Cg5_F\IN6[#ND_7\<7.HU/
)2]\/7&c]M7-/$
`endprotected

// -----------------------------------------------------------------------------

//svt_vcs_lic_vip_protect
`protected
eIf(.N)P1#6MG(:+VF-YC\&YU+4419/bWC/V7OB,R3,fUWcNB/@L7(:6NBX;^2L=
8/eD5>/KMb4Lb7NZ4ZAK(#NAUKdcMQc&(_FB0-@QS^B^O#G\)Z;OP_FN?NBfa9A<
gg)WS8&7e6-b:+>473F^6(49,>-VJb2<CR?AYN^76-89T\>_X-J\(^IgC3V&@SDS
bJ^,8DA:g:J#Q#Q1H)B2?C55e&++S^ONc6;5S,/E_?8+G?@&[DY2)[1\<\@g,V;C
_HX&F:L#T<(VL<23(7ggC9V<R+M)92U5)6V[WDH2DBA2]d_:LLJIe9-MFJc5Y+X:
TO<[)NIC7cQ5.7H(6X>/d<>MdW7a-R@WT=O/_,+SKEN.G1:UVJcC18PW^J>Z#d6S
)RPY[VcJ6QXPg1bPMB++OXY=D&#3]8/CQd2>POXC?T:VTW04MdgVQ/R(:f0YdS;(
\-geWFI_OQ\QUCI??R3=YLf5e1=#XIA8.1dNC,f2H<CZ6P=a7H]fN<XVT1B.MW3F
78(,/.4OKg\6/:9+0X\#K>Y##-YDdJS&=5P62-O]Ta)JF\-W))ZS[dVT)M&S:7cb
\^N9af2EJ9[U7FSdM,WWZ.:.TU/aY(XB]^BM/DD69+1H_HPY,3/bVR8-0b#f[E)\
4J_bAb0e/@^Q\-KcC^TMUe)8Z;/TC+8<,b36c5M?GBa@_98)^EL[--@;),HbQF7R
fK\2^EAM=P?F(+XY_aYKLIPA2@d^<6+ZHU7O&Kdf0,/M@Ud-P-b/VK#Z_JYO_X??
SdWS?EM_;_.:6?U=[>.?5#\/K<:_9d?NPf,eZQ3WYHW#ZY>E+?PO_P7-D,<2f]6d
GN#2THZ<?Z[6bQBYCYHIbHH><#Y(/^T6f5:LM9QYRC8e14C>Y(H2G4XE=6/F.BVF
N>KUb?W#5@R+1ASX.LHWHOEGIC0Og^84LM+:<+#J5\C>Z45Eb?9ZB>T;UePGF,@]
U0PN[)He\V7774R<:;Se^e3bOZ/B[HHSd=SfG6/X.>-a\f6-gHA]#(J6#:@McF.8
353.CYE9bbeLO[1@T2P0#gL7AA7ALB+4f4DAc4\8<U41VQ>YOH?50<C4#Le1bN@<
B:4TAMLI=\>W_8D:VH6bW9fW<b0-#[T5eX8Cb1B.8N+I=]65I@5&2E^)S6bPG_gg
X6S6/GJc@O1=P/F[+7.aLTZ9)5K43^JQ;Y&5<9-\E#MFZgN?KSfB=LMM_(B7-TF(
M9DBf(S\d(QPEFVL9e-NABV>:[_N;S&T8b7bO:a.5Y3V@&7>/\c9YFR52^VE/<Nf
BQ,GFfV]-.Ke;;QJ<N#?2IeMTSL3:HD=A.90TTN\<]44UL&_/HdME4b3Yg.;U+cV
,OeQ08a,&<4+MO5H>UNM;1MbXLSCcL@B&G3)\OP+cJ^0)C6Y/^b\?e<@)IdGADfB
YM-f#d;f]YU^3XI^^VaF+C/5]+FGL5D-?M:2FZQV[YZKX1Yg(SG@I,R88M]_OYa&
dRfPEL;_,C]NF.(fE==?5G&@?:JPIe[AQVMc#L&IDb.@N;,U:D=F8B?J/d<=K6A4
-IPDYc]<64gD&LT-baJ>S?A^8@PLV&Na>]B_E-E&=C4Y#IHTc-(dF13H6#fcHNO/
C_[-O)C_,QICB1g9NR,A\B^eIWXVDHIOBg4)X9JeR,C@CaQ5HLHR/?a^-D)57\IT
3O>Z4>GEOH4L)]^)CTRQ4Q:,70g&.U>ed=dW^^P>(6MTafOa/-,D\UTOe\G/FJHW
B+CgaJ?#7YT8LRb;1T7MI:Z93fGN4#L;>_N]WHBP#@PF9T-;C/Wb5d+1V.(GeM8.
Ec,d>[7UE:@_POaH4.FKWYSd^KWPP:&5<H:O+0M4:.0CB6EJ.(AP\bg,B\RG+?a:
]g]YHINV_&,Kf2-?(\ZA;S6IafS9_0UQ_WPK3DK,C,@A<;#P_49FQ0JD5-86g:@9
B>Mg-RBgZeJX]:EJXFb7S,aDK7_8A8)gXL6C_.YWa?PPT#gY\7WE7e/+X_QXNMH:
PRf>)QgSE.GZSWC<;&[2\_39Y9BYM&BDH?OP.F__<>c/_HKNeE?^TD;2<^,3Vb.G
S]_4Jg((<4>V<5d)@egL4[-7E>?c8I_1gFA=R36H4TF3S-MCB?)M\;#;MBNP0E&)
\O,01BX@0IfZ14KAPeb[4RcX;>.\_B+8bHfA<a_aZFBZ=:U2JJ>RH7V+I=_,c[bT
Y7QfJ+V<JES>4/FO>f70fR)5KI)]fA.a)a&<&^+dfM:SP_,Y76e:QF9<V-1W+#cM
3D_EJ?^Y]ZR+2V<6B:8BK&T17K5NH:[@2f@G5\6f^cAUVDcCJ(HNI)S<J:LbCN5,
^c:XdCd]WNE(:_2?NBAb9M=<.WYAW.>bg[03(N:;JMd&FgMYce++8B]&)[1&U=(6
:O0SGY+9&FSM6@HZ>5OgR,g-[^8;eI/ccZGBP#=M4/J[=LXN.2=Zd]RWJUaA-(83
N@\X;<:5eT7f.8D@O7Q<9F;@3K@(g=E9+YNbVOdBTP62)G0Z]KAD+3<eFb=bG6J)
cOW&b53Qfgga6G&7T:I^dXU7a@]A,P;/[0]N&LeKYDf;SP+.(UL&F,/2<fRT@7EE
ZKHKK3bPZM?0&NB<-//7H\7b:>\9;3T=_D(=:<+6P.U4bPYWc3+8XU0b3<(VXf/]
g[1Jd=_,_I8FW&B:5P/X?8=gc&V+AKL0f.)EI9^1[[^dW/BDaBHN8D5g(0AM:V=J
-]GdM#\+^YXKg7G5?+fKQK:RNe8/A^TeV\)-3+WL-\MO9abb>[_FcO-2D7?+9,aC
UT:CTKTA&gfb8/7d-Uc5>Z)bb)ZN=OWR?\#e>A&JI,,5U>4):GY8Hf.D_D<T7L.2
.E?I-8-a1;(MLWR3gS;6F4Gd\Y66._C\MV1:04>;H[,,C9//0\J]_cD]X3H^DR;c
BWNcfDG0;1KL6;Ge]3#&B8)0^[T?RX-a5:/(^U(WN/SZQI=)/7[X(734S][:4ACE
<a7E)<Cg@<eT6eb^M+eR\dMg5WgWf&Q?7>[#N[]_.T/b#g3WWV#f):>Q;eaJ]^=0
-RLgU@9bAaT=YQZM-0SbI&8H,=UU7BSGPbZT:AZBV0T\/DI-[7X[_K_(T:P+A>^:
Ze1_/gc/^RIU7Zc\.X/>-a#]_1A4RX_^Ka202=EZ^TM/L6@\DP+EL:JH5WFU#BMF
Ra2T[W<2VN;=-OM^FE7SVH6)IZU0\dDV@HK(;@8E/[0d@/&]O]2Q(\/1BZ8ZDeN>
H;HdKEJAO09NI-A0Z3Y>2(=FGJ&@58WaY=.a?bK-G;7:<A_\1I0dY=),;Od<-a1I
]Le3<[]):PQ(DNaJ:OY)9P8X]VgZ62GS+F\FQ=->U=#NM.:f(X6.GF&(#;@f(;ZX
RJ>NgG31>67W74AS6(NTP0M7I&?gL16VY4Oe^\ZYFPT(I_+;S(.6/@#5F0W;OTQ\
L8@bcO2;ME.V?&aD4V93;G2dgG?cb2DX_V59.Ib=aI<?3C^JBJ62WB4A<4>K;gc<
X:D;dDbAA(0N4dMM1(c):7&W,R>9)^31R?SMEV8FD5L//\(25dAcFBdCS1DW8+b-
5\(4OCF@=+7_Q\O.#WW<;QL^F>];8I#<6GIW-UAILLS/B$
`endprotected


`endif // GUARD_SVT_MEM_MONITOR_SV
