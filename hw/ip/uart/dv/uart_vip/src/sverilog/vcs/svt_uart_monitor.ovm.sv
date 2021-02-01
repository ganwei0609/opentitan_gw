
`ifndef GUARD_SVT_UART_MONITOR_UVM_SV
`define GUARD_SVT_UART_MONITOR_UVM_SV

typedef class svt_uart_monitor_callback;
typedef class svt_uart_monitor;
   
`svt_xvm_typedef_cb(svt_uart_monitor,svt_uart_monitor_callback,svt_uart_monitor_callback_pool);
`ifdef SVT_OVM_TECHNOLOGY
  // Typedef of the component callback pool
  `svt_xvm_typedef_cb(svt_monitor,svt_callback,svt_uart_monitor_base_callback_pool);
`endif
   
/**
 * This class is UVM monitor that implements UART monitor
 */
`ifdef SVT_UART_DISABLE_OBJECTIONS
class svt_uart_monitor extends svt_monitor;
`else
class svt_uart_monitor extends svt_monitor_bfm_shell; 
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
   
  /**Analysis Port which collects the data transmitted */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_analysis_port #(svt_uart_transaction ) tx_xact_observed_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_analysis_port #(svt_uart_transaction ) tx_xact_observed_port;
`endif

  /**Analysis Port which collects the data received */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_analysis_port #(svt_uart_transaction ) rx_xact_observed_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_analysis_port #(svt_uart_transaction ) rx_xact_observed_port;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /**
   * Local variable holds the pointer to the txrx implementation common to monitor
   * and driver.
   */
`protected
5E=fd++4,Y-76OSLBO5=\<+=(JWd0<Ee7H09ZA)Z<FRB[+a,BScc-)U9GM;EZaOG
_[)L<gABMW@8?8I[:3DY0cPP2GO#J<3C)=<Q#?_]4ZRV[F>B.]RS^&af)YBfH6#IU$
`endprotected


  /** Monitor Configuration snapshot */
  protected svt_uart_configuration cfg_snapshot = null;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** 
   * Configuration object copy got via config_db operations. 
   * This is a local data class.
   */
  local svt_uart_configuration cfg = null;
  /** @endcond */

  /**
   * Variable to enable Verilog wrapper and SVT agent connection check
   */ 
  bit enable_wrapper_connection_check;
  bit disable_registry_chk;

  // ****************************************************************************
  // EVENTS
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Event triggers when a transaction has completed */
`protected
_TbN?T#?F6#[>?;[22Y32H9_O,.eYP0SN#TfM>NMN\fMI\RS.6.>))D;B;L+dF,=
ISJ/558=6RB4[1DESI>:HL,P6L5RIg#+CZX[LUB&+WKNLUd;@PHVYJD;J$
`endprotected

  /** @endcond */

  /** Event triggers when start bit is detected by the transmitter */
  `SVT_XVM(event) EVENT_TX_START_DETECTED;

  /** Event triggers when start bit is detected by the receiver */
  `SVT_XVM(event) EVENT_RX_START_DETECTED;

  /** Event triggers when stop bit is detected by the transmitter */
  `SVT_XVM(event) EVENT_TX_STOP_DETECTED;

  /** Event triggers when stop bit is detected by the receiver */
  `SVT_XVM(event) EVENT_RX_STOP_DETECTED;

  /** Event triggers when XON data pattern is detected */
  `SVT_XVM(event) EVENT_XON_DETECTED;

  /** Event triggers when XOFF data pattern is detected */
  `SVT_XVM(event) EVENT_XOFF_DETECTED;

  /** Checker Rule Handle for the VIP Protocol checker rules.*/
  svt_uart_err_check err_check;
   
  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_uart_monitor)
  `svt_xvm_register_cb(svt_uart_monitor,svt_uart_monitor_callback)
   
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_uart_monitor", `SVT_XVM(component) parent = null);

  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  /** Method to set common */
`protected
3[9_SDB2YUM6Tad\2FXO;1[M:8HQ]7(,QJ;P6NXSQaTW8,_ad2NZ6)2+^\O[QDXN
1E6D>XNI>#;g<^@CJ@Kf.WH-:eFBV4W&&+LbIA/LG.7deT;N+PSA1:g=F>E4C?a6
g/Nc4b<TIB&gY_Y4/9F)PSgX;GT[V3>\;?=+7_<N[W.dD$
`endprotected


  // ****************************************************************************
  // Configuration Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual task reconfigure_via_task(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** Called by clients wishing to get a copy of the VIP configuration. */
  extern virtual task get_cfg_via_task(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

/** @cond PUBLIC */
//vcs_vip_protect 
`protected
DN+gI9^@E4a@C=?/]g84GZKH7:@YJ@CdJC7KY6S<(\NZID<?K9<\2(AR3EAbCP2F
g;Z;.Td2JTZ9]W(]2^LaAYEa&4N=DDaf\VG/P-B>>[\VWR3M-fVINA8#SZ1R5IU]
@g6NEVNZYOC3e55Fb@C2Cf;.XP=1?JD@#]XZXK<PS.3-;6LRUGJ_V2U^d#N5PKTb
7AG^QE<gPQ/T,J]RC=2(+@_3P]IEK>D?bE+8NEAYc<T9G)(C^F8I]0FRD4[/GE<M
7&ee9.<WT()(/\0W@.R8a1HGZK^RJ//(SY&]a)f4U[[DHM+L,6\+<f7_@#&0C^@K
C+=<(ZMH2E.J>ebY^0NbRMWeLO8c;RS0[^U<Z5;9K>I-==3^?>2a[TX#6L?Y8<#L
-Q?]1=W,U#(]4;&g[;c6U#&<<TU?_NPX.6YTE/e#\<[HWJeAM,T.E4F@5f1SdcfM
ZP=J(Tc22+X<KC)b.Z)>PFUEMgE@A9]1OCdA70.=WFZCOLIINX8X(XBK5\cWRB2]
f,<We5/YdLBaN6/1g?XBce&+BCO[<\.&OeV[=)^J.1&4RZ<Y7YCSK91Ye;^BSGd^
)?ZCDR&EHdN<A\PcQ5:]a_^#RQ95@K<5d+,VU=AMFbFcW>[W//@MB-/U,Q#NA_OB
9/O,U^9YKE21V;)Y>Lb8Rf>@dROe;)<Ld<6#I4DEGefdY?4FI2QaQE]U2O8(Q^KG
ePK+G)C52.Y5398IRfcA(Z<e^(cb8>0cMUU#HE<QZ&T3R0G32PQ+<_Ce;-gFM.B\
bN/ggJM^,bO^D_#I>+I1IQ71V<([0Qc79.?@)O]=0UA?OL=:b&2GLfHaT[GI,b(_
]0&6OOAS\cO26QJ<HB@?0-K?<WDb<3)g6^d?OLG\aNP(A8+;T-L0]&aR/?dO4<8>
^Z]g0?L?V6J,I6Y,Cd@:+g,=-R,9P2F1N=gUS.B3X=:<+EW+NXZXN9[+(cEEcb4d
K;]&<MO^FH,;G[Y=.H_/_eG?L+&?Xd.U[IaHU7A9ffJ7R&:8\5-OD4\X/U/aQUV#
YLX8Z-@?E=07>W?,?a7I<&O>NHNV:2M2S/9D,bfI?K&d^I.(TEHcKC;B?a:PbNW<
H)8GSb=/D6-=_ODe.HA&W4YGWH+<NPM^0HBJLL.3#8E15USZ,,dC9[=-N5^OE]H3
>SKbb&c;6=>ScC?cZNe;IJ_B^UT/1f[G0.V_9WXO1dF&c67#U;QE<P(dSAK+:^J)
Z&HET6&W=)Y^6Gc/Ba\,M0U[[0^45_:ES+@LfUdV)5+BaWKTBMWb:gE-2A\+<Y@/
a.?K0Ug\GHKYPU[K@A((,1=)&(L)QGY;d]3U\(g-CF@SCg<D)IdJANK]@RI&BLRJ
@Ua-1gU&1\5228VeK^HT?,<SK4PR6CY\I[UU2I:ZRg,]H6E@fDPE;#[.>HJ-S6(P
FgG]9F22&NDRaEMJg5NAN+T/)61L;2#(F-Ydfe-N^87;RW+BK[a5Z>^+N@6)5@Wd
L]WXB_&bW,P<BYP5dP>21[ZgWACLPeZBb2881Ta_P9gPL_Z/W7#-ZDGZZ+eS6?a?
T)BIRC1MJ/GbVfADEDDM=9F^]CUZ7^(4M)e=QaA.KDOH\1dDJAJJ6?f2a;;XCceD
..\50UcN3Z]G6VWH=W.\cHEX<_G@>\8c_E44d]>1gVcf/C1cM1Z?PgERO20aIV49
-><;9DJg3^,QB4IHf3NUFI\5R&YZY_+02[+XSJ\gff#S+@<g.?:@V+SHH:@<PBGG
O2JK9f)+A4X3E_(Q\AHdP68SGZ)f;I?UMR&1RbQ8P_&Qc>T/)010_GZ)84+T-YZG
b8d=_#[ObLgS\2[J3Hb95cTYX:JIb1ATd=bSUc9JJ0L)D/Oc-=UbObGJL^ST2U4J
T3f;L#S/G5fJNABWK<7\8ed<(0g2I+YAKb^f]5364+^(TN?=bNe&f8EA^\U6AA&L
)S2)6&K;dPa:H,+d+U,VQA;37K2L9fY1c4J2R3S\N[L?M,=0QU5&bg0/gd6L3f0e
[G4_1,/V0>8:0Ka8_3A_;=LRUI+c[]b@9GF)GX8-1Pc2Q^E4Sa55M=869A&J812#
C3TG+;E,[4Q,W2KPf1RYPHIN7c-WMFPb.[+FA=GdaU^^.A((;^-7W9OL>(229cDe
dCfO//a>X6-Q^(T))-/K/;dYGC>8R/A7:QG.-3=fG@N,2VA\03O1I^-7b)(S93C[
:@/SUN,W_XM2=,RUc5Tda_XD:&-<=LYTOOS5@+2XL3I_Og(:bIDQag@D?+DLOWFC
GP36<+CR3>5=YC/.&L=\&W16BBZM^VI3.J:SaDEUK>Y9aD7Ma^TD44GeM]0WFbVC
<FA_:OTSf1ZL\>3;GQTHO-MWB/72(N(4L0&ZbNd1?b;?eLJVQ3F2&SgJaZ6<V[V@
^58D]O#L-Y[cH.Yb4CUeR/YXaFf:5JVgSFg;VMQBL5+#L@BB;[J\W(Cd-a2F00<4
M3e5E9EOPU@)IGcJ8Y^;eB96Mdf__-dRPc:-;-2[GYNUHR^/d=0-4?]S-AL.E/Ua
IKWV:L^/>I^Cde2@0+_@_5c7FE7^/?<?KB6g&L&+XdF5W7(A8H#aLE[-E&Tf0J@+
AD<JX#V?L2AF4e<.W;+d@;VUYG=)NRW&9ZWMUg?OKNH/M:=EFSOC++0F7<#cB?VU
Z2\EELB33ONeT9]^<<[_68C]B<F:UTU373K-YHSY>TaZSQC;CN-SVE^,##/GMIG8
_2&5[CXZX>J+K3NA8)^#+Ee8Q/b4MK?\(4P+TX=;IPCZG.aY@E_HB3eTF67MP)77
Rd40G7J8YX@:a(Ae][50aX.B_X^[59I0L<CTYeRU;6ZOb:f;#d@1Qfg&\#Q#[\):
]A>X@U^6Dd2](JZULGfJU7:g]Y6323#9B-2U^XKF1:c8FP[&#Yd@cKZE0<KMMJ)9
?.<,<FHTZb?0/#2,fVY&A<U:/M4Q4/Q\V=?D(SVBQJ(Q9-[\b?a>f/)89OfHQ0Z+
6^0\F3cQQ_9)>^5?K#L92cM[C#7E\EacGQ/0/=<W[_1>X\/9,;9GBY8?VRdZ_FQK
,W-&V3OAdA#2BEJF]fR;<E[+,W2IQ>-fYDd_-SUObVeg.L.>&RP6YQL9VeL1.MHX
HUM_U_S4O,@ZF9ORQGf<7:)TN:YFAZFKPg2IF8MO\][eM^(])]fI-:G)FGYKe6?3
R:W+HgF#=bKKH2_,>WWFQ060GGcBYLMX5228b6HdK8\T2&,S)^J5gU=eIgL>UZF[
OOHb]X[QJ1-bC,48?SDdcEZHWCYY>?7g2Z3d?^fYT()632HSIDU7#2ZT9KHTX<aF
A5^BY9^eM,DR1Qd=E[Ya-:[:#U1B=_cT4g./e\f8^]\?Hg46<^?WHS?ZT-LJTJ;.
=PKP-\Zb6@I&CMP.1Rf]JI/1QDd._DfbHN/>OHGUX7)Y^e>+M2T5@VOV2</;>M;0
&d:#KBX=IS)4D)7;@F[c_Le#FfC-:E1Z<e\JU+DY(P=TJ2_dW7#JO9.#]0BF]O=[
/]7LTUEe^D3AFNP+P)6e2Z<e^9UgBT3@5TM[#W2DR.+(bJD.a2dYZ,Ec]?9@^Lc(
DO=>3NPT4?EOQ(#abILAG@@+c1ID0D(cOXZaP4PQ&@;d)g@5H.7Z21d80PR9H6(G
9QM:2<RQOJR1DZJ#-LVd9.I34Qc5>[dZL)8RW;agf#EFIfOUEI?[<3cQ<Ef)5ZXE
^feH1XXf[FOQ67M^GMNC)\XKVMDUNe3]=7KQJW3=0<gX@9JMPHX_C>@SLF>;5Fg8
D0.gJXQLXQR>4#8Sd0f]gB^=&c6YQ7(]T1FASDW8_X#S0G\>Pd0,/K9UCMP[Of\,
_7ff_IE3J4YR03b=cP&33/UIg;=2,7((DYZRS.H4DT<>WI@?<L-Zf/8[[3MK,T#;
Og2:X(S[UTMJ\Y(5GMD#E^HeF^BD;KMVC^SIA9G#U/.&X>CQIV/K+G#FKTRbHC8<
[CG..-F6Dd:_YVD.3;Rb#^CGfN&EXeYa;;)-S^RD=ET,P<2SR&QZ[DI9->8<0YEL
0N2RH5FK2?\/Q3].O@8W#9:PJ/5.3L4/B?=RY.aPA07ee4dX5bg7c?H5P7+ZG[E2
?RWD-Y0d2R(+831GN,J?B(ebOFG([_L.=J;9P:6\CFA5R/Hd>S3=X7Hc_GY<RbKb
,TZ/MP3&5J:0.aZ<T_NE-LBYIbE[>E:PD(\<&3W6G_N2V>f.fT:=FSB46\)U]QcS
e01]KXIMBdfcB.Q[B^OU?F?fBOHX):0I3A]WED-^#<-90J98(dP6-f&ZXKQH:Y)_
Tg++df?-S.([#_Bb[8>DP__>G_QY>]@;TYUEbWJ:cbUI8]T9OdB?(FR1Zg0&+88F
\GG1H970NU/N)H=(Gb+TCNGCORRdcdYWYd]/NO(=313_XH0E,SH95(^H4<3TI]N=
Wb+,a#WQM.>W:eQLL.GOZ-^Q]24VJJ+G+/T@IVVIJRMLMc_F4CH0R^\fe5IW:K<Q
U7=1\b)/Q2=XQA5+3GXL]b+HS;L0YP,@,7F,(-Ug<b479b]\Q=4^;<Tg)YfE;CD)
>\YeZM895<Ac\FIK0,[32K3;S]Wf#g38X]5dP^D_T_M=AT5X@4/cbG&.AGcfV2>G
=f@cRRa,H(N0-/,#CQL:WTL/C]FdD-[?6-G<b0O33A07c+][GMUH#XZL1#8L=+4&
Q>bC003^P0SUc@,<\>D>PIb:HZ]6Y51e,LI,#OT]RDGY.9;99UVU89Nad(]]OL3)
^c@D+Z#3Q6MAI_C2Bb;84RW?)aA-?P)_eWeE/ACcTRG8@:]>BRSF&4df395[4FP<
9f8&)?Wa8XC)^+dJW)H)I<0A.A#D:A(gXUSVZEB^P-?4ZQEWg[048A^XI-7A;QE7
.]YGJU7cD\RWeKD]b]acM)DHI11\K(gAD9IeE,;UfH45,=TbJ3QY\0A?T4dRa?Q:
C,2^<WG_C7:1CRM2;IeG-d1JO2@(:^3R@0(e,a?;D.950S;N>eZ1.=25O+ZVNBJ[
3[63@.c4X#=.O?;;M6(.L(\HJ#1_;eYJ7F>@X9?,6dGID4+^_Wab@BJ6K#3U49F^
57JC;MK;6?CG(9<A_Yb(\b7a;8PbMHS=]#1cWU9Lf+-+/X<3,gWP=(ZC_\:D2I6/
=#dMK2=_b.Q=,PHb@(F_8IK\0<RWQ]#3\3F68UTN,/2Y.QX0,)Z]Dd@7a^V-42_E
_4GfY(/+:?.ZZ++W=>4^&MBY^4T(P>W<XBW-BP#8PF\U,\]6ODU50ALW3#:Q8L\2
KT&/9CQE&3eZQ]OCfZKOK0c022-aTVC&5X]_UMe7CO>M=Q_f]I,(^K+WGPgXM;6_
-QJB_UCKPD&@VO.H&TP?6fR692bNfYeAM@M13IQMDYP8aG8CGU.PHS88APMQ2KU<
N67WfSHPM3e^^F&]<KS:E/-:Q,D/7O/J3_]Kc2XZ2=1<BB/H[NABg8D+cg?7WbbE
-(\?K1BfSgF#L.fS<3HIdZ_abCXa88QP30Sd>UcKeP#S6ANTb4?R?5YG\EUUYAOM
A?21d^3JS888J8@94XP=(S(#)1e/G/-]Z+202ddK^_7)RH60&_OB=+:JN+0:[Zca
DB@HNd82>4M0:4cS(8UJ?QKP^547;.e:[B>QXQcL(#+gJJZN)\O1PJ4K1;7GQEFF
G+fcF//)[U:&,823]91ILOfI4+/SLFIbZ63SX=?eBb_WS]_K[<V;LBNg.9Z]CLV[
B&,6)A)U0-LbU]W<4GaZ&VSNV.K#>CJXCO-5BPCg?AAd7Be#X7VNb)RIA)653\EU
<GWR7_M?\^EH_IL?X6,5.)@5)39T1OLVS7J@C0bHCXS(W\OE?W??4LG-:WHJ=>Q6
Cb7OHY_Z(0acL[^3BRP\3<KZ[WIVTQ#Q@29S6=/=fPZ5S?,b-4.6QEDGE2OW-d(^
4DB\_fR/=5L_d^=9L\THg?E8:@.MZS=CL0[E,fCBK9,]53f#Z3,d:42HD^.71VNR
5Y_&bec3C.;6aaWNAgX_a^NA1C5?MT_3MJZa-3@-+8QI5N63C8C;.<4UJ;;?c<BG
&bEKL#:/4:E<;9?ga)B@TXeSOJN:g-6<g]PfdI10=+c,7OeXC^K).NJA)^692-S&
bg+IG\+,ND>;GYL4Y_?]2PMV2ZJVB3fJf((D.Y,@EcHN58C4/N[.\UEIP2SKLc<K
cQWb9b\BDY30e_96=SWRHa=#]FZ]^)<9)3+DE((3H-W=8XTU&)1(_&:0<#\]K;AL
PcV852<;bU+eg#4K]Hf9d^T4KEDg23\=T_M<8^N=IL&_Q?g]Z#U?#J8G<SJ;_[+C
<_^)-d49:SK-W^M:0Z:)0+OQ@]^S3<Q[FQR_A@86VTI1d5I,d+<][A-WKNReGE#b
a9a=2XgO[6>:LJZ<UXfL4,LWSQ4:OK&I;(OHdb\<_^5bU)AK-XD8Z,9^Q80-^H)G
O8GB>HV^9ARPKW<V=ROB,BdIYOV]+R3VK&_(N^>eC^^[G:(e\KL/B<-N-ddNC&H&
9/\I5;4T4IF+D)d[E6/2A_V6dW1d4G0:f,W:g?<Fd;6d):I+NWM9[,#?:DRWOKD4
,8@^C2MMZd2aZJHN#FM@1C27ecPT<d)1\dUA5_J7RJ&+\\Sb\>cH&>[_)g?P&D1M
XIf_AV4_N3U<U0ac-:D7dA_J5X,_#?b_955Q#=TG1=E_/M:#W+\@F(+.KV&&30bJ
A)E789;E/AUJ=@OEQV06+VMW3R;?U[S2VKCfDDTA5a.MB@EYOII?Q)bNTf^P?7^Y
a.@)-M<(?V[3/4D41#6I3ScXQ?[W6_)_>b=)QL+5RP+[N4]JVaK-)e[d?+NEd@RM
c,e&(>]7eG1+/Bc6N@,V]T1T4g.f_HfP_F@a5R[R+;_b+I\F+@XaN6,\6MZH/5Qa
QEU(1VG86R2=V&W,(AQT@\.S+>ZM9+fQ8)R+]);<dQd-[#1#K^8a_0.8Z9YL:Y?B
LL[RZ9[]fV:[[)IbEd=fW,gN7(W?>9;CG)+,5:(Lc08HbeQ/5\UXc.U0IC]\DE;D
MYg<_2GBNeQ]g36I-fa?gG_d-a1GBgV5K1_D8R/97<f,Y1F=A5bE4+Q9VT?]0@-+
,O[_cWVFB3V7<[#BV)dBde1FA4RH9bH#PBV@552?H4D.D]6_;0L;_EYZc(KT0J8E
>84@,EKES#[WTS3R#9>5=<6K0X^Yb<\IDM9N_CO2A+8]fI7,/#&AGB1bE&C=OVM]
/:-?a4SHAb\7J()1);HZ.5&<MMY2QI?MFWE-SfRO0HXEL44-fQe&g>DA5F4M(1cO
RgAa;C3B7CI#D&]2#NIJe?EF?-@Y>;.Q5Qd/^OTO1g7+3feZ(H:3d3?#7WN]gL_=
?:,O8Z>Qg:]_NgPCMI-QTUJ\G^^;O,735]).ST@ID&8=Z.ALG)IMD.gT\4Gc,cXP
#O_ORP?:=;9/<&Y](2V94H_@#.1W?fL]<98WN+.,42>FGRVfFRDA?1/^I][Q0/Kd
c5.YV\_fQF.K>a]1X3;J^(c:a&/gIM1/G,E9ULWc3^HT&F,A3Nbd9\X]/gTJI:I,
^0/Yd6\I)daY)07ZP4G-S&^>.E\YId^/PKFNGeV6?4CMFaSD7YT47IT:QC.94O1]
F:N?9EaW[-J]181<0gSQF9_ZA4SA:IM1<)WMX_T+6[(WCd5FI<]O3@T+HMV^3P#6
+b]GS?6R3P;^_G<Wg8HA@?-S7HQ69(AdT,W07?);\HD5gcWa4W^3_U+;<(H^B&;=
_4ZTfS2Pd,PAXX#V?U4Te&#PTU&P@ID;Q<NYRR3CLVUZFDLU)#BJ^[162MfO(0<L
?>:;?8(BQX9.3[MI<@UEP?gKRS_a+MIWL.L(F1]Xe.e;6\N#S_g5R>0RVV[;DO9E
b],KIJ;+IBSZ/HdD6eI(AJJf=]b(#N-9?R^I?:.5cPUOa;6>>)M:3)/ObEQaZSef
-P^EBg)93F37ISed@?M_DWDI0FEXcN3V=)VI-aJ/H>gE73I]Ba-PRGdSMKD9c&95
:/MY@G;OWI6b3#QZXf/^_WbAG@[U?ZX:eFO0eLP=ReEN25g:g1@8I,?F/U(RcbVC
W86eb<1BQ+@F^&(C4);;SL_T(>cBa[7.bE(UQ&^#;,aZ^7R//aQ&eB-[B#\@;f0V
N0_g(:PSDAf<PWBLK^0f-9@3BfX.IObR?Y<_])YQ07NK,G]BU#7KQd9,:(bD#F_Z
ZOA.SLB<J#J]aO-[f84P#N^RW1F&:I54KGf7.(WP5c2DCSb55NN_XLV0c(M2?.aU
JI^_P.eSF7_Z_Q786aYQQa37XR=[))TV(J,Q;&Y.X,7:>27O=^ScD=SRH/Yf)&d,
PNY1_g=B[[O93Q?57GO\^dfedV,f(7YE7X/9eI49Ha;.#SUVKH+EE#&=Q<(C3>8F
Vb;MYEL+8AUMF7C649_VI-HRf.<LQ]D+1=L1QU3XW:4P4XO@aU]2&A^O/ZaKJ76\
,7WB_#[(fP1>)59ga@J04X2=62dJLL#3(:&^:T07+W;7N4,1dYe0B#Gd=0d6NWf(
1Xf2U./DW>.CF+\?B@IB>KR62T-f]K?;R?3)1[DZ;d97F$
`endprotected

 
/**
   * Used to insert posedge clock wait cycles
   * 
   * @param count Number of posedge clock cycle wait to be inserted.
   */
  extern task wait_for_clk_posedge(int count=0);


endclass

`protected
PMV-8d#eQ&@G0AD2<T8^Pf14AI/8=\DP.F#(L?H3G]#(R0&L:bO\7)X+DJC;P@BD
5@\8]W)(9@232/f#1Zf3D.?81SNC3VU8&951,^_#J2#J=AX75ZWJEQ9E9GQ-aWe)
3>M+(8(T=L/Y-23K3),DZREcH8_4dL/0Cd<SPU@=T)Z<S7]76c+S4A=RdS+UgO+W
TJWaJ3aQ319-(2Z]C]LJ(JU+F?g[>ac2g:;aF]-N)#V91bM=1a-=5W=fY4Ee1)(.
JCAPX=:9Z/cG>,P:,WA(XdU+1$
`endprotected

  
//vcs_vip_protect 
`protected
LZ_C+9c]M9U]YBK=[M@eM2&HBJd_P1=Od3_+8E7D;#RTKedP\&]c.(AWaHe/fF/0
JEeP3LL\KPde)]/C]0K0TUUO]#b7T6OOK7A5;F[TO@Y(>REEWbK(1K#aD8AgZ\E:
9E&)Ta<5I-8K5APTZMD5R]dHVDBb0E.[?-F4W72+#PZe=C;@f1a,#7+S.b;73U4@
9bL?I-]+R:aKYQLO,K#bU.g4c^>/Qd[CC6?77aJ.[cc1Yd)g1fDXF#_;FHbLZ3T@
T75B)>cKP95EK26444)SEZYC?6Q=fd&6G2=GEY\)V4(.dWeT?)4_Q\6RA57@&ZfV
2;OOKY/\KE]VL/d[)[aUKY.FF0/-8b-U8GY;&Y@S@7g-7VR/XDMNacIAV&TD.ZL8
&7R/G1,@ced2\ETdOg7WZ\V9R)-,(#JTMJ?DC7?_DAf.M_2FTP54]gZ0BEV0b,CG
?OHSTS9I5JObQ1aNKE>21^c#D;3e_bDYK(c<>QJ-LJ)\b26UfBKNOP1GbO#?H+-P
aL5TJ<@f?::N.J)?4H[IO_?Ve(QHC&0B:F]<F;c1J_]N2Y4-@JJ1d3;\0:/T7e94
Pf.dJYRE4NQGFGECY?C57GGPe_&cX+aO(7V4bP^XbEgLB[d7a>_,H+U[1Y9/+H+K
GB-Q0AeeL-cag9/2<1K^7>@0aIcadJUQ)QeZ&GgbgC((ES.6&?eG(a,FNFcB4#Z(
2233G_e429YXZ_VLC1b@;Zcad0S+_Z5FOA>+D=6[&e9G-cW(),M^7I-3EJ,;?MOD
_M#6C0FYN(TB3=&CBbPI.MbYM7b]e4#_CE#?T0cA;,F?[12NC_fXbD-I<>4a-,T9
&&I@__9N8P828f&Pb0=.eLgGS.Q]Y#TEP0,a]D#72IH63f]6cY@PH@/6RWI:P@Q5
4=E/2,1/5JHZIZ<KUe)#T&EIe9g2T2I2)GV80+_E1:H;(@9de+Zb7LT5V.5:T\J3
>48I=:?ZTLT+O+4SY]5gHMY>C/A_)ZSPP/>a-\:X6(#RVIMKJXa#TRc74XCc^<.c
SPg77Ng2BW6JgDJ0,8.>#WZXfD7<d9A)0&>Z=3T8<AYf7;ec(dBRS2F8I;YY\>GC
g>3B\TTcaCE+Q+^5_9;601INa7<HXI(&32F+98L5Q+&&F7)R,2UDWHCc4@>?Z5b7
bMe+b)G;N<R21IBT&-G8a,gN[KHD^FQ:L:7:OTGCU3S1,_#QYU5)3+7Q2O&8)H_;
B0EET<8@)M2LMD4=2H^+[V7P8BXD:=[@?;W9,)6VE;2SQ9DBYU.@WS#>QR>/73,]
(>1D@PcXH^UB6((7M>agVaVbeR:-&75,X@.Z+b\.<G?K2..fA@.ZVT0V;Dga\Qa?
H.6L1<RGX-H:a@&[N=]7:Z:fW.A\[2>]<+3dYB)3_:]>U>KbBDJF#8WA4cc@cg1Y
OCg6NDc2=R&?b-5F&_-BBcBY&c#PEYZ?6XFKg-MJ=);XSN_?gVOWD83:T3+IS251
FKQ:8_G5.0:29V^Ka)NENS&FM(3<IMgYa<4-4Y&c3R9PR#FB@C37-.EN&8DP6_(X
7<bBNcd_F-eF)5^Z?T5G)@d1:DVDgN^U#Z_fP7NIGEE;2DcCW;FKBI&g2=F;RA,_
Q5aOT6Y<8OVe>LA-WA4E.\D7K7e;YOPFYF&W0RIWIZI9?9ECHW954f230F=8a7]+
Of-8M<&9/LC[/&<O;OXH\=O:<HY1:4)3M?5,bMLIU7M=fD&G>8bX&5FYg#RN)6[I
2(_?:L>&IfZV&O(0-aE/O6OY]1:YI]L.#UMOCW4K@fL7<Na7Ve,&e,K9GaEMS6X9
-5e1Y<DF.HaJ;@DHD>/EB@eKV&M5Q^2^4cJEKG>Z&NJgdJ8-ZB=SX.2C_e=WW=D&
A=JBdJca]c_9:BL-DBM,K:\B0K5BDTN>4.SFdT_M=_8g92:0&EIT8+1P0&I;_QL@
bfaT(f9_GT2R40VC9-U9Te^G-]J1XX-1XcQ^=.C&&b)23U+c67(;GRAcKW7)B8YO
,<^K&0A@<9QN;-XVU_L?aAg7(RX#T?H+(^+XAfV=-,;a5P^ED5;JRS2Rbf#a)>X#
TEaM.ea)(Q6?#D\,PD<4OcGZ)IG>O;=^SY5AZc6#EFgeK<9@VGcL.EAE4.3>6R]:
B\>:HNDHVe424f:=Q.XbE<g6)5_G(/,74\B>^@>,F(OE7:/@1f:\ID\^;5F<B_5W
R;cc3Y9:Zgc>;EJE4&TbN8JQIM3^2@/e+=7cA/g.ZGI00NN4GfJM7C83f)c&QYB<
DH^L0Qd5O-N?JL4QC03288:<XZY&3]MdVN4&fQ6U3K/8IXD8M?WV1)AV:NWAB:B.
1M/5:#B4Y)V/bbAAC-L?bHZWAB6I\f)#Ef--@:OEH-,eLbZUd-[M)+AB_\b6L+:Q
N<b)c@>FJI[KUJM7c4fH#CP>(U3g(&E\VR9SQ(+(:R>DIR0-W.BXc,bU[TG[CM/a
LY51.9+J&PKRKc52(@fb9_2J&9H=B;A2G0Q1H<5=+bJ+]Z]AcA^2FV7PNJ(SL)/L
R=IGR/HZ9,,3]=QSMS)EQP3#_3S,B<0F3A3ON4eGB=SV;C_+HNfF,JL:R#+.P-fA
1deRB=U/=OS]^&b.M[::QaH?\8bOgWB3[BbPaR(69K@ZF@b>Y)?X-1A(QU\c^GJH
,K8Le7d;SHcB7:UV>IN=8\[deC;P[<WAJAB-PFIC@@b_^ZQS#173UdRV@IU0?-:K
>Tc^;D(H&,Y&SY+GdVX(@<7[Va1R4ZQ.b2MKgRO-34#G>AC5=/(QRb>],8S7Q?M5
&>Z;X8@]:ZR&BW7-<SHf>T3S6P\)>@9UJ4OAYSAW0J[VFP^MHcc19<N&O<0VMHHA
]4H6HCOWKM(;G-&1Y77)CN=#dUd2b)+[[SQDW>.Kd:ZMS3V)YC.YXBA?W4O2]Z+(
KFUVOPcWgE=INJ2V8)62LQ=H87>8JHI1Y^IS/CA>55N]C@R#PM/>G^F_0L;W>[]F
#d<YR6dPM32f/f)dCP1_S6IG>6HFRA@=6KA-YW.#/(Qf?:[c_)P]WS(:I^WfKQC:
4^4@=Ma0:OSO-U#Hb68BT/.>5G(]WaD?M08?T#:FVMJ,2F(B]))D+PTA.9LGNW8a
K?C#QN/+Q=:I5X/fe57B3V#^b0XMLgJ585JXD5F0Q/QHNE^g2Z0)@810Kd-e]58@
e^(bJSGP5GFB+W\ba[Q3T)2FeAVHYXFC0(YEDJfad>2YJT]fHg/<TDTJ:\O5KX5N
;PC6IUfN=P=9;,G<&X,g@@_e#bf_d[=e5;,9<V,A[=d(YL9UE3U_3PLZQ4VXQ;bU
+4ge++7CcU.:TcLY).4D9.@XW5UKdd[fecY[/IY=5_B\]Ve2OV,=[\E>ae^<Kaf#
RICd7BL,W8<ZJ)TA0;M3H#J8J1W<@&?WB)e=C+38/QRb(;EU=(PZ6BafA=[c,O1M
Q2@.aGV@R@.NT5Q6FQg0T;=b8E5g1K+BfCG=:OdT-E?^E(YAF+2bdI;K0;E\Wf<M
7f]d[-AA]-E<G2D]0MM9Q+9TF:NLT#/^0:T.#G^aX;TbSfJO[1/e94QN^1Z\_^-?
14V1M[8A?MUJ)QM=930bDaVNH4d?eW(W0;+Y2)#X(U2WPDR(U?@I;_>V3[P>F3+U
WaJ^J3.&KgJ3:M^8<H:AK45I:IQ55?VL]\)A[aJQU3a>JfV->-CY.1;V[F9;2DYS
/E4F\D:AC+J\^5USR1Z]Oggc2XAbf==TOe)Z6/8N3@I1#2/QMKA73DELf;-&M7AL
f/b03gC7aIY:NUM:&NGY=>=b<SXBSN<O8&bE15UY8U6SBe=R/J7;GW#(WV(MJb>J
bcCFa.J;_/[X2#>P+M\67H3[)R0.I^2Fe7-Z5.UZ@,3ERYA+FJg8\B#P9Y(,>g?S
ZdaJO>^W;=UF/;.JDRb/>3.&RQdceUC:4K2=64AC<\7Q\a1&D6e?Y-9>gU<@6Y3K
\\K8#1;[[^&UQ5BZA\c^WKSV<4MH@9CXUQ.TfRW#.BDd-;)X[X-7?eKK0[6F0)1J
_W:XA^+g,SQ6HY>,cE0)0DE;1H@dN.WF[BSOX88N7Z;bLT7N]7a<YFT6WfFGP<,;
49M40L_c=I+8/-0-=/d3JGM]XH4DJa(gZ-aDK@Q.01ZW>Eb)/H;c9=L5^D=HEA3\
<CX26;?dfIHGLNJ10/O29Yd2Q.I(@SD9,R5(@_6C3.d[QOKQK0536cTB)2&.YfLE
:[d-O631?D__F\Sa3(V?4D<X-f#_b[1b86c,(]M-WUHfB<,EaRD3I=WJP7ZC2c6&
/FQA,K@^0c#^+dBVd,gZ0X_#R;=I1aMe5#@(fUEL8D]9)(1C-c_f487eLcg5@AdH
(f=.-UP>JEbT-41DJEAf[2\KHbCdK-Ug^Yd+[5J#g>eUW8)Y4f_66#cZ<fTD<#+M
]B;5UXeKW<&>S(@Z-La]<8_2@3J^9<A^K4MW1R?Y,BL<E5TT>Od#73UYS:e39H.a
4a_[A3)=[a#YBT6:6\M@J]JLJE__P9-XXE&dTF=#J-(,UQf##>>G:Y,BQ9A8@MdB
^E0WK-T#.QX&MY?61OWY5?8SE2E_gabW8UOTWM-8(N:N^-gfXHNTFOI3Ec1:>LfL
_J@+9#YN(_M5L#f43,F14Y;U\./LM+M)#+EX0Q&\,KaDJYdR;Q,K9B.d3S\^K<f_
:;eCf74[8G@__Bd8SG++:P#6BgH]a2V&YZ3aeS.Q]9;T2#fd,++8G+Q7PD,NKWEZ
?CHFX#HI3LLe,_:7++Kg:X@,)_-7=25>NMT#&SfWFMG5W\)44?C@?\Eg8>D3J\51
RPL[9;0,Y+&Q75O,#)1(#^/ZZVX2:aWe&\DRW)U@CS.NY5=g3VCMGSCY+\aD4]WQ
MWReVgR\\b8GZ4<&7aL?:Z#>Jc>(Ed^KR=Oa@<;YM4V9W^8ZAHQXFY>+.PFW\=5.
7<Jg)(fI+..FP?d9\H/(9-K]:KZ[UeL-7(\dQ69fBgI7C.X(J6FYM08N6>A1B;eK
>8Be-_GWDR/Kg\5Y13UcJ_IOf^fT1<a9c=T(-EB8A9X8=FXfRd(:L@,>&8UEQKcH
=BIO=aZb3J5\&4O9PGA&\&?E8596GbQGUcX+I0DK:;(ZUK,eHH648BdSTB;e;dPT
+MgM@2:CP/BY>S6,FQ+.7O^0+;dI]eG[Y5O5;<\()gG?>FV,2^)E7,)FURJHe6#Y
,_c@_780;JHHV(cEL78FCFPB(8GW2SHUdT-/GM4O<V9#bO&dYW75b,GfX3:gVAAI
6=G@Y6b=Z37;U.Ad2<O:<9ACZ(COO:Q&TS<)MH^I=Z-&G2JABY7DDVLU6ea1Q:)9
#Zc@_OLW\11?3gX]eLL7#4JX0C_W/c(@\U3Ff^.ZOSN_\d13PFO?).5(97F&Q6J4
K#RgbQ<.4Md5ODZdAV2Ba)g7F0?&(4TOQ>69H8SbdQ_>L4Q(I6>RS>915)4A#:AB
84?WZc]FYJ]\d[EC:PR)^1DR+MNP(9Z=e9I#3.Ka;WRPRSDP81(O\ZB6Oe-8D0-I
FG=^#^N<;78&AfGH/?;-VINb03,WCf,8,-=Ze@:V8RUO)(NA,\2N;=X\/1WI>;0M
[d2UDY)O3K/51D:JX/)5bd\8N^)IJ311@4)P7?@ccgNMNI4.&KXM(>LXGNe^>966
U=gF[fE.S39Sc=ZG,C6;ID/,;GGQGK[8ADE3X.ZSH2B>a5L/ZbNN<6+^<O<LFK>_
QKb(Db&08U18CK0He]2#)TEYCWA/=CKG[^E\ZK/?J_8TK;7C78WUD4#WAL4@RTM>
BPJ>_9?=-Z8<4)HeVCaDGSc6T#RZN84dJTU5QZI93\4=AD;Z([W3D^L8TI@\<Xec
R#=]XabEA0UcFfM0#9b&E^@]2Sd?]ff#B,IJ++gOL2M2KT42&P\?0H+\J,@RY-e_
Fa;/)KdXeNcfKf/NELE=T_4fM7<6e9=Lb1[bDL:bI1#PP9@:,R)&XJaQ8@A(/1\O
SAXd,K?B32@Ed23a:,+EUdFYc?82D\Q#5AYWgGa_XWKNH?L12Xc&G+GRS<4HD6&@
WKJ:NJ,ZZWEY_7+Y<#J&3J]_:OK\,@18OAFO15W]R(=Z&R-EPc^75Z24-V:f=4,b
TNK\UC&Rf^g;<La(Q]D;DMb3^EdLcI:=T-:B&C=DFLJK7\&F]+T5X@-ZWO5=>AWa
6fD_;X##4>6M28e>2\\044b36$
`endprotected

`protected
Ic/c5gALOA08MCBG,_:8D4R\X5&Y8C51-3U.D925CAMBO/(ZGXB<2)VdVLL6I[X#
4-8:b#(/eV\1YEY-KLH[DeR\2$
`endprotected


//vcs_vip_protect
`protected
6=+URV\K]XWZBMZd;Y3&&NPdK4F6]VKd1S.IH#b8NXFK6J_71Q2B1(b_ZCT)VE9Q
.@K?XV1,5OGZA/=P335c9TcO0OWW(DPdg<-8edQW>=HA++T#H]d@cd7^,&)c=Rc,
c>HEGXPc[,JNc)MAPY#_+B8<gY5_/X^(2&#f)Y@3LJS_@X4NeJ,aYEMKf]\[b>I>
HIZbWQbB;)MM5512))E8NO#,?X3Y9/4DSFY=Sd\5).KYCCeAG]1)S<O?JCIHX0fN
)g]&7DGQd9<HHbaP-POgUU^S+8;DAVdTR[a8C9BAF(ARf^Lg73S3O3O/6H3:a59<
(&D_KF@_g/Ff@[X]V;791-9XE0fg4a/<=8K#(3,/0:8MDR?]]@<P?FI8:WN9KPR2
8BA9814FDHW#5PITJQL[S,WNMK#PXH9\#dIS/fS?FOX-DH9KdeT6D.CK?HfVAV?4
\9J,N5CZ0NZUWVO^B]>C9T;D\Q4][fN/Ng^,Uf<JYMf67HgMH7BAc=RQcFe;<.[T
U6<JeDgQb[2:FKE;^GZ^&&bG2I_6LVMD5&IXXTN;Z:3T0N1SP<Kf&f-R[E2OF;98
MMO7f)7<O65N;M@1)FH+IB;&/L\X^L,S5AX[J_ZfFM24].fBVKe?.2A2+9:6QXc/
T[0/;4N_[a<EQR(ge;0IFSSA1WWS=/2gU?.d<f3<6ZK&O+#V]Vd6f<<3-BHVe.<U
=JQV?OBD-@ObQ2Qc(S=A,<\V>bab=PQ:eLDQ5//<#JQc;Y7FQQ_:L1D]d_#X&-]]
9[TM];B&AL>YYH&E;>,S0^K,/&0/:/?,>K95Uf=\b<8HC:eB8]Z7M4B)AJZ=a7C[
I)#(aFL.T3S4X3M[aS-\9-+MZEAE6SXPNI2X&<8;=B6eA]ZYAP4YB6c__a@M1d19
^Q1<U@:^)I[/Ea;W&)4L/.LV5G\.gdL?R]e4GQ1Z9/;E9NGG9KBLGK+4g8V4ZU64
1)LS3YKRBH@-N@BY)^[8/F(LXMVZR]8PJF&&J=[5:R:29.4H?YV)\U8?]PNARa&Q
6KEPB(G375#DeB##ZPEg=)OHM@?JNUTQ_(a2U#+J?PJ12.LBA7RdZ#dG7cG/6fMI
\4975ZMZ0LM)D&QWYUOOQ9/>WSIBe9_b=NgJ;II0[SO=7IG)K973><L;WH;>EH,,
(>T&>/We1MH:))IZg,@;dF\C<9B.5=3)R=d=QW_[Y_<@RU_V1]Mf>WA4J?7Q.>[?
Ge&egL@(:)7_N-OQ=DC3#.a<a)3BLTGJW&dB58CAVBQ=aWBL_N?)2T9dLcYGd9DF
]Eg(J3F^+(-I-4+5N7&1Q0c-3VBLP4LJa)gQE9;XSdB^<d/9d(?VePFQ]4RS?]HT
AL/\G_U6,.D[8?\(Z70f(HWSbRC,]>G45,+S5dK/1U60@\+VWbKN+\N9WW5Q(<T/
CJ=?T3\cON4O7_Z\1MaNQ9TG3/SY,BXQ,5W4;O8IF@5J=gA-;BR.cA^?=:@Z=,SX
#57bGB(R(VDU3QW#G1E0IMcfEGPc,I+O4e<>OPZfXN;FS9FFIbE/8?5]/&YA1J+(
_M_)(RV,bBf\IRF[#.C((bWBO+#<UM^>J(f->EI)BWY?HZL)4GRaeVX&(]a@5eP8
ENUU>7I-3R[ecTTE37OWG;e;X4de0]=D@I6]>Y35[UWbM2;Q2#8cZ6fU780\:23/
^STRS0Y@GZ<W5(RB>DAT,5380T[<SHFT8KeS5g16_>D86a;c[^E]8g<B_HT(^g>Y
T2dKS)9),P:+@7BQFIUL4@I^5e((c7A3=IYfP5a#^b]B&\0CB.QSLZf+70C,QY#)
[-5D-3<5IO=>4)We8e394WV2DV<JcMDQRG(TW#2d^U)RY6TJ,/b<IdB#g6Z.:N?0
GGZ^MMOB29e1;36@0_:V1+S>D0:\I.9Hd)6:cAT]dO:Y+PQP0G#2_V>TG]YVCARG
]?=0GIPR3=IJFT2_1b/Z<0JI9QUA2F:F9?+6KJ50-R_&_+FA>->G:6Mc@f,e1&[O
K.b/0\0P_S>E=4R);/;H[7;)6W0:S3A\G6+(7#70(GXOgSHUVFM&4Hb>5:/@[E&,
8TT0:&Q>?B0S)d-aIfM@O[AK0#\TB<F39)/;2<A9bebZ1c6I&?JAF<;bY5e:/CF#
T))AVB/4W;&He<FD1+P#68@&VgaE[<3B1c3Oe/Q1<\1aSISa0M;:dI6Y8(,U.d8A
g6/3B;a.;C&G)^OBNYG-\ET?;a(0#(d2#ET=7?>/PK<W,H_Z<&QMI.R(OM_Z5N,6
)[-#69Eg#(F=1Ma.^.-ScKIR3BR9f>ZBR,aHHU.fbG0(UJ&T^?cfIW7_86Z9VX2<
Fdaf,H=c3@\3J79LHH=SX;E[)B-\Y-U=CY2d?2c_75Z<]eG4IX7-//B0B;1OTU7(
1baEPXBE,,g<:#gSINI0+GXNg0(N&\fTE>CL=(<Lb:\G/>NCf+V/./F<P-(D7=X/
T+#dOOc-61?LI(\5HWB1L:S0f<E;-(--AS7TZNS-Z>.UgdY+WbAc3PS?K<2Ie[?3
eaS>@Pd9caJ808&f.4TAAL^W,3Q?Q.=#aF\/2&YFX[OEHS[\V_;a7FNfW&7fFZ?:
3]G.?@d^:[b;=I<QF)Lae-cf\NW7J27)_G(3Vf5&?:a+BDN1>\=:7[FTW1f^NFAF
V6PA:Z0N[WIf-QZJM&8L<d?5VaJX<7N2O.D_Yd80.H<[P<#g4M3_&U5<#Jd)>(+>
I#YWUI]/4(\<8G9d(I>AWf[7KeY0NT(\e3[4&@:M-P^N;N)VJ>OK7e#59SbG)aT[
VX^?bEbFLUZb&?1OTHYNO,:_?\Y<7NO2FLA:beUZVcU?cM\QW\=K,<;2=O>O2&Q9
/6JRJ57=H_SK1#Xf,(caI+&\d[X>\2\UBe4;fK_S5TZ/Ya8>a@CX1H[0e1IIPI9=
+Bd4M]0ge@Yb^Yd0,9UeR2>FaE3C=)gPGdBUcYg>DP6&]D]fSUO.)D0#N6(NNFOf
02c9L.adPX_VVP=[#[aN]U7a9V=HR8e+2>F(gPF23_Q@Ac/6UVY=;-BR)DSS6P>d
0#YJ)>=8)QM/Ab&I5E4gU03-0>0ZNMI8-JOQb^HGN@F+Eg6::ER(K(IZaX,2CGE)
a[0UU3dEW+aEd6FX2Y2IVb\3V5A:7CPZOB@e>#N^[+UH9^?(LYFYTVG_6A6a4UGD
9CK-C>@]HQX\.J?SNWF-TLIY:P#3UOfY#b)aP>+.W#5>IKHN#S/:9Nc5P,JXV_6W
YPWR>geC)^c5[:c.H7RZ@cS;^H7P+XT(L+80.QT>cOPde>VA;7<<E2Z[gT?eB5[V
,T^_d2g2&5T\R73:Q0VM\g#REdRf<V@Pd[d<T24D5;N+FM0FO9+ZGTBEO4I\c?&7
P4+KJ0FW7WGK3DUD(2EJSSH78WAYR4&6<)+[a&+J_C00SNG(QU2A.\Jg18BC]\4e
\e>Dfg8D_B;D<@2_Z0NR5@Uc1KIFQ9F&SQL#@HV)ZM[GICOM3RacScf1&FgKPH3N
;[<EI3bUdD#3#c)48Fd6JgO39g.ee\:;T\5\SNDQZ/#BFX@<;G9C:G(>f4,OJ;2e
KBGA5GSJ<gM#8O7[7J/4(SHU>aM8^,K0Z@Y1;:VcR5,R3+)W,GfFD?95L@g=C[S1
)6\R/LPZMZX>HQ@\Ze=(B^#&EP1_C=4g87.1[YIa.#G6Y_6,NQQ8)a;De5\BJ39-
IHD)HDa;BH1f_VV=e_YJb=WfP\GN^E?0PR+PAG&RGTC<+M?FP;7>FG+,\.=7B./O
MVE4^@L8D&]@=-_cM=AS,+:\DDa7F[NVF[LDKddLgXA.:40bXU/2?[_=0=82B9;.
)3(7dQ<gBIe4A1NQGKX)F,EM=M0K60HAZF_&aP0W&(VPU&0dU@(0;W^U\,\XMPU8
5Z^BO8P;)9I8^+GFYe/7WDaS=.6L:^P?#(bL16RS<HbR,^BE3SHf+b1OcGAbQFH9
TaFg_He_IV]e;D-F2B-OE87KO8#8@.[Iffd:Q[;.P8TFAbW.W&ZdC[#XPT,S.Kg<
[=JF?3]RXIEMU>]b,&XS]\DV2Rb3cPf8LM8#YQT6<8)JU=LdHJWcB<P)8,DABKJY
#V]BD?(&dBbP=6MI1?aO/7A+7CX+9caOd-1781CPIBNa)1#:>\P<9?XT\GDUV0a^
04@=Bd;)5d@H;c?56;aQfI05]917G3NEYJ]Pd0-T?Bg.c_Jd<D_KR4>(UV6(W>Bc
TcO,aQ<?40K,O=N>/O4-O0O\NZK=>eIGNIG_DO039PTI+MZa2F1-3M[X?:g/79;7
FEfE5HE6XP]I\F44DdV1\[2Fe2b.ed415<:E2F^U?6;9D[b6>5/aYKf:ZN6_Q7]0
a0E=SMf76DP0g.4g5I&5Y93e)B1<3,YUZ@c,(I4Yf=>S/4E=LSE70W>UTYf0S-7D
a\+21:YY[3\R)_=DCA.I&7NONJ)LBM#.&-C30@::0/IJ3J&<=HeDgD_10ACXF2;/
IPCGFg&?bMM_dQEPe;M+A92fRRIP?>^Q@N+[\T56MN<K609WX&5CEPeVMcW_S9Z]
@&L,e9AeIZ57@7PB.MV+HQ6&FdOS[K@bBH9M^S)J:1.SJ:IfDY4-E>)I.&>gI[@9
?;1#QY(,Q8,Ac=SU>(NNY:A6])]LC#8I)O?8H;P)T&3EdS&P(F#7@L(Tec@_R\^/
)FAc6e--()=egU7#&eA-UN8J^5YZS(OdBV[>WX,daF4..&+fZeEC,RG\:MNDJ^+U
KSA>?(NKZGUW\O^ELCW3+20a^gLK-KPYR\KO/3I5TQDFBc;(_69_@=M?\6//2[A;
@1^NS:H2&[5\F+8>,LfQc(.9<5XRL1663/MfXUEX:9^T/0?#Rc(74.EeaRe:Z4eO
O\H](\1,,)8,X8cY9N@)R;#?(@GD[UCG2U=ILR5&V;]f5fZc]K>@X=cB,LHUZ.#Q
d1W^<;T,3([B>18-YMdMa(G)@/HdADSNG9Q=&&bT5,gd:.[60SQe\1]Q;.QTYL=_
94)SS8UU/O+f15MJeW72[6VdF?L1OK1N3ALNa#?af<N3P&+9)bR=YPVP3@2C6E:0
V27F.[9A@5GS/H1eHDF^<X2g/</P2&CT2XRI(Fa0e^@6:CRUd)N1B90CH>@4:<T-
7]+N.&@H+.4@GJ]X)^fMa#^Ng86_RaT([JNY-FJPP1KA78Rf-;TF;_08bZ]O9O]Q
WG])^@GAL48M+S](FY=0F/@5QRL9YI&a5]?]TY3HAH&XQSS69^&+>d=HR8)5GfE1
[A&)U?G\6f4=;X5H?.e_8T@9b.P16SBd85:LaIB:eWI4Y??BM-9W0+CTH5]aS[/Q
+P;5CJg5dg3<NH+L>age[I<7?:\,L^MD/ZT]2Ug&>I/a1?H<NS^YBda]5LNfI0W/
)c:V5\\Z+:=;N(Ad,(L(9<I2<[[;c&2b?P^>7f.4G4F\R4-<JJg],g9(<UZf2gP.
M5#:Kf]:_SLD#3-GML1>Xd\7)3B9OC<YF)ZR2HAJTRXDgP=gG-]ZQ-97eNV/FJE<
VTKGPcWZ#ba9SYW9DQ,QZ93D:VE;3b<A92Lc4_ZA^+E)\AU4Rd>[J&ebXKJOGR18
U8+G22K.BS-U2a52La-g&)F\^6bMKf-2Z=bc;HWefeaYLPR856KY4;GVPAFVF-QX
TgABb4\cTA7fg?JU@#0L9H&JAe64HH6_Ke[WL+>/f8K2XQSX/H=cg5GQA3+.-\T;
N]YP_V05+V;0:1.#71)=31=<9NM;<[<-TW>]9-a::0CJHege?>eIffHRFF(G=LUG
QWB^?L^MaA:)>>N?ad>(?MW7#.A82A9\;QWNGE5<4;#]5Xb)04ATD;>IA=-5bQ[F
;gXPMNc56DNe#P]b#69L,.\]M>NdQAD.<5A.OS++S<dX&],WG6>g][1Q#IY\U16>
T[)5QH_8J0.NUNUA.M3,);M:UfGKYSH[Wf]4F&ZKT.GTP9Z2/XaJG5,7a40>gJG,
(\&?\eMJGS#6G#64c[K.E#K]1OPD??Fa?#SLd#>9PWBcN3B92d+RX<??^=:@]#,+
RbGG3BFHXDS.Vd-UcYOZ/+O7aQJ.&EW9eYQKb96+9f.eag=/E@ZN[)SfP0K+=709
O8<Z=1.@6-#4VDL0/^dY(<37CA)8(9<O-(-]af)g@IRPH@;;;f#X5@\6gK4/JSG#
J(TAWe@gZ](/CCK2OF9(O/N+Z=d;4F2I0]^X31D@=]M>c.0-0ZHUF#<G)?BUZ[34
F<;.)P/bENY-5.X4D]+Ce6-(X:O8OI:J,a2O\,8A-\HG,/#+&819CDQ\JQFg2#N[
H+IdP-QZ]?8e6e-P[KLO].+Z3ORaMNIEHAe<g)^Ga>^/XGfBY[Od[F-Zb(CDC183
?)ZdU4T@C9EAJ()(Vd^c=>X/>S^9FS<]/7O1XBd]e^JOc#?(4:Z.ZEEHOAb=R5eG
)0e8I9L0(ZTJI0@VX#AL\-KDJ@M>]\MKef/CAPTb11X=B-I/RH6>N-J?U(=S<_#?
A1Q7P8W>DV&EK-_J42Y+Ng+[(8:7VPKMJ06A^Z5D>TZ(_@U#Y+e4;YODYU1ZV5?D
JMAa6Q?\@Ycba6\25F2G4_E6KeUc4BO+VX45:L>/D^bT:IE9EE5WA[),VOP.Y:S^
K>-F69fgb:CJ[DOKAKMY4NTa\f[Q]E,[LE&K?C)JCbAK1ZJAF_1,^]2<+^0.UcXH
W;8U=__T^ID,BGWaDb30:93+2D.#0:4+M^ST7T#0)K3I@R+0d:R&(3F0VN)g]F0?
RBRG-(\():\[e<YRJE<=1aVf<bWGa_U@e,>a&EeDV6-)=:F<CC6X=#)./)#>bEU/
O/5MAd(9eJ@?H[=,<\7C5O2MWgU4VW<B#?6b2N:JTgZM8R>MM.&CAH]@_abK),S2
0M9J6C70g@]YY+=SG_ZLT^302XBA:F?BL?G;c;<:.T8g&T,aXBHe38cM5K7,L;UZ
ZV6bD4ORQ7QeAN9/XV5-.C1.SA-(;0A=cDY@IC47U<eWaB;K/Y=EO2-C#/Y,>9A#
[J:OH.->&),7P@H;<IgO5C&YJdG/KE;06d]f\eP1-=N,98U+KB:RT5GOE4Z>Q\GN
6_ZcIaK]@K9ELDG64)G3ZaD+?F?SA=?_HDP6++9=f@eVg,[Q?)?_5(V2_DV0X=b(
),8^?5H9@(G/UI]:L@U+:f#H[1BY0ZJXO2R8LE@[<)P?D\dO-SM8d0RQ#X-b1b(^
TN=-#RIAP[Y)6)Q[EM72dN#?SACG)X+Qc8/+f<Dg7D9AJ@7GC<a^T.7X/A..YH]F
]0Mc,_A44#YY1L_@[_2ZOFR.Ed(e0YKOT>eD?Q&Q1UC&)WX[DJQ(Je)23eM(UDgV
Lc/V0?,QS?E<2+TC]S?5c;Q-,/-D/LFXUNA<3M]fXYOAb@7g.aI5a>G6Q9DW&f&4
?I^gUGK:5-<5X_NWV^].F21W&SL2U+84O=AaQS[B0;LJC\8@JY6X:WfdT<.8BH9f
F8.cbc5P3=IPcDI(^CHP.69/OD-XQQGQJ<F;):TT-++eK+I?bG;baI/geI@&O?c]
5<UMbUWFK?fc(1:7>B13-1[_;e]ZHO6IJ=,[Cf;@K<[B6LQP=2VL\1g\F]+\GMH:
T9eF/X:dHDf/3]9XNc@B[e_aO,VY:#fAb)^V^JaY;@??ZG<Z3CQIX4M&Be5L:_(\
@#CR75NIfQO[6&YM?NM6Q8]\N[OOQ#(H3QU(W7](&L;9?+)H5X1]A5g&_630e=-1
L-P84PS)\(LeC7>:^E,_SPTg3B0c<6>/UcXC<@1b0O0.gM4]7(ZEe53KJ^]EU_^F
\C#g?FPK]G0.7H^DS:cGVY?=GPATfZ)#0X4YPDgNf9?GV7OG5A7)QV@WVMY]/BdC
)T;S.>D>,LF(PT+G:O)#L3>?_gD#O>7G\5,P3[;=La:ILbF:f@Tf<#-b++#DQ]UU
QLL3X6R(\?64/)7U:N1-/\L;PG68aUV\8PW]O+Hc)f;^&P2ZDG5^EDD#ZIaDTa/A
c80)FL=>W8UX/)#(#^A?_4WJ<f>,XK^9HDd.fQ(?D<4QP(OO7b@SAAPDR^KX/CdZ
_g@Y8-7-bC91g54T0Fa;0FNZbQ36A)=Z@VF>4QK)5-V<Z#R\#d_1=E?MNg8=;YJR
Y8#RfFP:Z(O_.XQT4?2a5Pa>@F=Gf9MCDE,,H4GX,bf:,J/d\ade#VIB&bWE0HDR
NJaY(QS#]<6R0?.9R.P>C4McH=CM-@b-G;2Wb;L#A;g&TJb4C7HSCT]-,dND+NdZ
NHEYP#f/<QO[5,VM]_=g0=fRNYU@6E_/^/\9W)RM7Y4deJRaOe:Y\&VH9SEAH@/U
?aV<9Y.RC_Y:8+.VW62Re(G<Z:I&)9fHGg^HI&=KMX<^^5R640RMU7CC-c@=+:Eg
O:55A)&RR3S8fU0#Z/CDg)B0Z/3<3CT-5KH@/_K.T3RT;M)[dFP;c1U0<//VgRJO
S6BF/=55NJBOfV5N^UY\A2UU(8R#CGe6c02;Y?Q@/;D11S@IcUMWB?cC_@7UX2[:
=)N\6S@S>\AG6?2\bCLEcXDdMTbKU.-Z@THM)dDa&VDB\YQJF&e&3;C<J&X#L:(P
8.W2fYN6e&>(0NRNg=@JH(a139SeBS42K^9g\Pc([K.G#geX/\DGWb[E57Ef>:Z]
fc&D._a9V.bFa>3aN5KJ/gGI#[/Q&gA)N9#adJW\_0J)a:E.,2)4RWN>KD8,7RVg
\A+XbP/@/T=;9Z2,#0M^-IP<&e308EH:VdMAV;2B^b<;HO?,GdKN3,(G,GISQ6#\
<UQXJ?+&CT8K6gEORX04C3=E)d?;J?CBL>K19Hea:J6S3ABE3dEV6O.EYX-Z+a+d
^-(G^S0Q--A&UO-+aN/,I;)=4/T0R0OL[Gc-T&RN:P#L.cB.5I[5JY<_9Y&1@fNf
(Z^FHD5@IZKXI&(\9>#)O6U@-5D2(UR^#JB3O<;]U5Z,L+FJX[SY71&[SeW1]_3f
(9-K1^Z?O2FZHH\B_BN(&d^-cZ__2eadVO:V&f1T8)O#[UA;]9Y^T:7\P#B;?7]U
_?Z(6?Q#O7N&Rd)_Z],?e1?c,e-XIT<9)6RVeABMb9I)f6=AH>_Q@eW59,H5(9BA
\CcT^F5IGQD)Y_,AbYCD?bO_Ob6@>RDUO8(E\V+<FGNGVV)#-ZS,g#0:U=#YC/;&
Ge;^,/F=#<SWgNT(][d[MYCJ[Q4AeO+OO+cH1<>QYA^/\[a9-<E=L/)8P2YR/QSd
4I<Tg3f[+:]c5[JSg14&1IaS<VecM.S)P6VTdAR)S59DLe\+F9.U94;XVY=IH+b;
<()(RPGHHTFH8J4(R0I.6]EUcY];B8#&U:(b)7O<P89;5QR>RCX:)A]4EMCH?CSc
?V4<>(K1a;4H#44#-X4eI7,Tc_BC@T]+:X#RO;1,V]fE(FTNIfQC>^<S.?.VS>6+
&)+a5@RWF9e/)Fa#(-ZeRCHZ+TTF?@7B=+&-KF6VE]F>Y@TW2F^:NJLcRBb3:\NU
5g=)+Pd)VY8>1?VCP-ADcP-Yea#L#6Z8K.BI<394:#cAM?#^]?cN9C0NV:W(1[TB
<WUb\PUQK4R]=0@T]\]E=dTe3/8ZS/c/#),@]#;KU;5.3Y+550&O0@+UeG-T-W98
P-;eLR7AcSLS9eE0a^>OG]A2RN,79?fC4;3=MHfVeN6(&28(;05Eab5e(Z-@JS1>
M32]>2=cA)&WW.BM]eESg+e0[]0CY(6e]NF\A6NgDC;M<^e=FFSgJaQdJ)+;0H1;
>,Vda-gHQgDR=7P;6QL,_3&E]&EB&3J#_)f-;6LL(\;DXe9cJ.B1.JE2O/BBKG-P
QL&/\1c[_eg692c_Ye4<YCRaef8O[;UEd92_fd]_;(=<VB^0MONF-O2e)e0cFW-.
?DCEVaEDf_I-^5HCPSBbCaa)/C-)C-#c7<Q76-F^(54SZDPXIDRe>;N.e.;XZLg,
gDVR@(Qd2P-OcFH[+HE<W4QM9[F(bLW6KA+BZ)V8P@Z@Z,(4d^4IYES=6:>M&1<)
2-g\\=2A3g9C]?GD63Qg(P4A[8B@23[Pd[I,VEU5H/J)K]T_d/A,0f@[e8XZTLaY
^Y,VG;2N>W1fJQPDSRY#BB6X<Uc?_7(gcDS)02QOX0B._cag+0XFV(O@ITf2eDZL
5Z466UKLHL^0eLS8RC2003WY^XN&b0CaaDeDZC.<f?(UfE&a@.#HDXXUY:(+dKU<
IC##<#\[F]R;N&T=.^\Y<\]3LE_BPTWc(bNR[8LGfd;1JCHI>GITT;31eaC?P,H-
QN,8fFCFf(@A[KU;TZFZ+6b-b/&,EcWMZE/6aIWPN<^JYR->@aQ)I@S?87E@]7=B
:(EQ-C2UMS1L#aC+Z_d@E3^DB55Tf)6>cQ\566;FW<Z6DPI^D0+C?LX)\I#ePecP
/54K[CfN]7[XXa+-8CD6I(3I1I5\5U?FA,O)cT5aWZWN2&I=GQ:aZ]gH8?.;-D1F
PW.=R-/,e89=JNW7DeOAXIPE@X/?NbO5VR74BMa#/U<K,;OR./,JBJOS?Q58dI>?
^Y?)\<,]?YFT&,#;FH@E+I2X^>NTTH>L[V]P;PAR]b/MV,WI0KWUb??YTR=9,Q9_
f[VYH9L?gUQ_AJPY7EI+NHg)\;YQ28@0X=5@b<X+[^cV4)=ROEg8f83-,f#>2(Y>
fUA-FMQZRDIYD<4X/P:6JW>aX,\9Jc=Meg/#R^UNZ3F-VJ#])XPeJ\]FBg?W_Qcf
II=f-#>9E]-R94fJ3,f#[.@=[JKdLYVbQ9I3(EH_&b;UYZ#DVO1MM)NQB#V\C;ZH
=A_?EJ[=6R7QHTL9V2)>REM)_<c75^(H+MO1]]J,U77-VIH8[b8>04<bb.5UL=LR
gFEPT779[/+C6cKT7KZE1F0KM;YR,+&IRa@P?ba#6.YXR>P.^+54YT60-05/#0c:
aUH.MH^_UUf#CW#4N0f0.JIa?05-NCPO-73e\.)-&JNIYd0W2>RBDUMTW/];0_^P
T5EcO2HR(&:?A/GVYLX-)M@N004WSRZ3LRbA3?]U#)8WE)YfQ+A63@DO/V-.e-^d
gZ#3=(:6+e3+2M@?6D+(3<eK)43gF2(]\J6IYB9#;@gZEU(A/(g+3>5/+Q#[W+HV
;BW74?J;OSSZ2M8838_W?7Y2dKY:M?Kd)H&g-6[gNCB:d>8KfP=R^QeU;8P>2:RU
:=RO\>(N-2<Zd]A6,6W3\aHJ1:MS&J^H6KV(430&^fbZD;RbZZ/W^;>L^.58eceS
eB184G@CXFGGCG//:DgK3I+[TebEDgbb:ZMI;,g6=9(7aBR@W,Z(Q;N4U8P0R615
;RR@0Gb+S.WebA?V]geg_G)@WRRfO_/cd7HgUS@+N1AT^;>F_BG]G[8D(UV/Ka6)
R;O8)YHP/bcPGf3A5X_Ie]\?YeKY>7&TGJ[7KMY80Z;DJHK@TCD3-37795gbDUgd
B0AQ<+d6(=Z=8)e6ADA?)@?e.\Kd8AI&W;\]4]gK4V6<a[.KNBU&J8<36Y2ONE5E
gQd(6#P6(I&V;(8eWCCDe](c&d8BEJ?f^X_R[gc&AB_c2K4=LR60R>F(/YWg2M7V
/dTN6aRVB(ANHFZ)_5F\+H#0N2Wb?S0?E6?^Rb3\+JE022=.93;OLG94W]0BZJ;O
>G?_O5M8aKb,_=T3JE(^?+5,.,,F&A_fe36GO4U6?WJE1;#:&RgCBF]?0e^3FK=Q
\<-\gZM-3[CbXSa_LDE>P[bX.8M+g[c/:-,83<AVWNb/O+3+4F^-Z6E\0RdZZT&F
\)HN5c94^9F]4C550?Y79\;NH70YeMG>IG3=17>Y3/WO4#XS2MG@UQ.M+g-2gaTC
O8R+8LJ)F\24[Y;H\^6&,;0\7\U4Z=))<P@3SPM]Y(Ua<UFbZM)D8WMJ-ZS([FH:
B0(TUW(#J1(XPV+>bEK4a4_3N,6;5g6\M6>>B0b:PZ\GPT:O6N03O-XGM\-D^RM>
C4ef#f:ZU^)K,-U6?=WEg,1K;g45.37XQ.JA0\)ee,@6?>]58G)M?XAT4dO.R]f;
E7Z;=47O81A3[?NNI,c?)12cY(Hg8R1)V]4LSIG,FbGS-5-@5a_B8R^3^XN,.(D;
8#R8VHQT;U5=OQ@HTA4YXD,RL]00#WP=c?N_d8F<24g1MCWe6A5Q;53GF12Re/1Z
Q9@Q?2FZ)^#=BQJDeSZEF_?O:.EaUDBVcWMF)D&8D(OM<5@=L&Ra])MQXe2311A.
TGDO4MAMF;>EBHC^gM<Y5W+9\?A(ZP>U>EGU2eX?daWY/GF]USM82[P.A]D4#)Qd
IVC=:f;f\D#SceJ==Q.dZE/ge;AZL:L72Of8^]&Re76YF\TTLG+JYI(^F7SSbM38
P0B]f#?/O7XW43)FNNgO>IY\O?8<]5R9UG=?bd(^MWZH#A&D=[GKg+H8FOc8e8+^
H_0(DdV;^PP9T)I](D(LP3N],0490.V7d1_8,2?C[L5HJ4JcGNP8G6;W>S1V;7Bb
\+Ze4X5PG8Cd[4@bZZT8B3P:36/XJKYLePUK(RFFa\,PHE1UH,A),AVB=#)+O[g^
B9E]RU?IfK8(9XOA,NPCHHKbK6I1<\9IY#0/5GI6Na9-9P4[O.[;_OcYZ;f+W=5/
_DBE7#[<5LIgT,4bX(fV]WC<Ib60b(99CDeES=+b>^D^c5X>?.cc8Da#\d&]6(T8
^G0bc:#b\7X0GWGTE:PHY3TPd@gZI1O;6D1MRE[FEf4]#^WU?0C>YAPXd7I>UE?<
b18(B(#b+e)K+T#UWX26,f@0#7bYbd[J2=+6FcDC&B>RVI\dRAe=/dHH\,Oe1=_-
,K..UZN7ae;)Ng8V/04gR2UNJB=?W?SaH:#.GV21>?d3OQ]2:#F5C1@=4bXg9,Z.
Dd<73_CgI&0TVPYC-Y4;3FY((7TdAI/-]&7QE6(S<+<bS^d.SaD3?AI#O7KE2^#H
WY-WVRXG#^U)Oge85&Jd<Y/U[&08HE3-0H63dJ#QJ8b=5c>1Gd#<45C:)Q#Rfce1
geg;A@2@fYO#E791Oe6#J018c?N\b3U&J=d.C7OE5g=b,3ZAW#OHB/a2c,8BfS>S
11+>QFL>A730Naa[4JTRWP=OTF#A[JU5G@2TaFOI>U<Q&VSHbI([F8bPYM5#&8?b
KD4^)@]KM,.Q75CQ+SC^Mc23QD4G#V>?a,)ggUg<&gAE]e6f1M_P_K/LA1\_B;gR
??CJ/Z&K,9K]KR&#Q208W:b]MYW_gPZ)SU1=dPMJ5V_PKA_N:VELKC+d)G&g7Oe=
b6G\8d8G(3E=9f,DC(W4MX7\31FdA9DbY]^(BM>;HNU,R?JII\B1>^D<\N_a@2<,
5N+YVBCOJW7?.-#03DE2H/>A\YLT,NL7[S;B@_@[/Da<///4/)0HT&69(AaGQQS9
<P?<MQPST:T<SD,J_U(g)[\I]WQO3,?\J&D62[6a@LdTM6<1IW#PJ80_T+=W=d.7
B\RR]\GgV<G0CR[Y89=Q221cc[WgAIYUTP\XNE;5Z\?SP\LSKSd9V>.R\8D3(66e
c,@^M1c;G):GJXA7dFUUXdeGJ3SGa/e<[31]LGeP]R/VTbN?GLC2Cd(K:<2ZQG<V
fUGHgB_,TA;8b;+Y7/^-0a3gK:H]U;#gD)AZY(TK-fDJAA(-]E<Y?T,0^_#N>I(,
;F[GH2\d(9f,Y1&/8AP-6;8X7a>DD<C?4ec+=P]9ZT4#D3#&Fg.?61d#H]HC7d-E
d&<,c_K,a:&22)F7D0:;1eNOM7CJNL,(AH95U7e^@C>S35e1_Zd+f(_MVaZ</aV2
S2S@=c?:=3GeLC0@FF7>2>3Ob2MKU:788:JJ/UB1W#WfY[(NPG))X8P2[?e3\?dG
6<H&3H^5b3MHV]f1?<I@:3d;.#2<\R&4ZGDI-V9&)VaD8gO:91OS4U0:PO[Y&Q+4
],f=ZLTgaFW;S4ZH#^W;e>[T-)/SK#0C?O.XaR_JV?eb\R]a)IgMVZeP;gWZV15G
NRL37EH86C9B>OQ@;\>652>U2a>I;4>,>LE84F@TaRP-;E1;P<>,KWAZN/KV<2eT
e?eGVVf(+[Q)@NV3ccG1KG-SFJ,9(PPc9cQ[BO8d>B>IFC=Xb-cVJQ\EdPEZeZTe
aa4:@R_AOgEfdVagTdV#IPC]ZS;@de9dQ8c4=Q1aQGQL(DU39X[c)]/]D+_RQLKQ
X]g=_B9#.9Og26U9QG=UA20U7fI@BeI/0[^U+]:(FXS;Y;4YJ/K0,S.3ddUTPTd<
Y5a7>b0Z^NBKUd7+68OI);[De6F]X]2SEY7cG]gP.P&e(ZC60#&?CN9<J4]ZUG=9
:b>=g5g:QLe8#:@0V>EX8+f?@\MCEBbK[]&G8@UZWL;DZ:W:9U(&=^GQURY=]Q8P
Bd_f<>29D&8:)0?F8W\UF4V)(3==V>d10bAA.:A=d[FISYReX8dVTGf[QBT6AV(K
;;7U(gQ4SPcT\9))N20_MNLVR4^O4J10de?BN&YfYK<&^AfP6PCO-D8<TUZ@<c4e
>ReO#Ha+Y#HJ(CAP+fB1RN0RM=gWT+@U_?O,C=OJHN@]c[B/[g;U?HYHHRNM#1-_
eSD3G[(ARLd_I03);7I>R#c2B#L:?H.-c(S3g;6Qf\#(&P@61E:EZZ]\f6?da)9S
I5&D4:deZ+6N=5cZ7Z2Te3A[b-cb;1S:UUVU7-9X-.(eD=5)\[UH+X#497fOG=C2
Je>I[;.2WN_X_VXE_P19ebBO<HC]CdSUF(>9-7J]GGNHA)eOACD#QW_IcY\c)d3^
_3#>4H@LXN9U,SYMQgfgBL:^M(b(?;@PJ9:273P4+U.#f5D7FKAd(8YITI>O8GZ<
I1UH/F&\+K>0VeA1cB_bI;<]Z:O:IZSfQ1XH03@P)f&<;#<0G(1g#\e>We9@R]2>
FSS[.-Feb\722c\,H+GNe/W4eZJ:.)ZM65E_ANQEPM/8?P(&c:_/EUVa(2b>=;_.
F-&<N[K6UQ)3E93AeEOP(MTG(^W@3U,J67B#K#^DQRgA[Z3W/4gBXc1&QPN9eB8,
BX?-HY[A18YCE03&JZgX-NeY#Zc5-&<b[.c8<Y?(gYb]1KAJg;WZ<)<YW^F:9BID
U)0>gZ@SQ.,FY-51.e#:?C/CW,^0eBPdN\I:b-b>E5=TQJ6cZ[EI)3a&bEP.:;0U
3_]Z,,5E(67a7?Fa21JRP&g1@_H,<f3L)(W@NNU+#QXEZ,/SbH_=<1^a>UD)E&Jg
ZJH@9L02.0VOCaFU8?&^J52DeAGH)R=L+Q<dH,@@^cKM\F&ZcE.e3:DFBI+JHc?X
g(QJ+ZPK]b3VCcR<Z/2]bMb5\;FW/;Cg/AIYS2RG=C-F/aTM1T>4/^.WLCN:Cc:(
VNFXZaW3]:49ccW(8A@[]T6YKT^_A@A[_(6TS(Ke_6e&5UH/SN].I)\?8Jb5XX>B
GD\?bIgFY_W4K06L)@6KBeUY=T<ET6ZW-e)2;>XaL]IIZRU/ZXH/GARHPANA6=&/
V0\:43bPP8&V8ge>?L>RP[P2JV?Kd5?2S.P<SD#B3COb(W)<,ZFf(7&+-&NAgfH#
1J)Y-VD/YEW(1HZE5g@f\;,1)PX;.97IG>ROZ7e9B09ce9>7C<OC_&>(-8O7AbH@
IYbX6S7>WS[KDR&0_P8318-/DXPA_RdBXa_.VZ0f\@D&EU:1Z=RA_0.D\D-Af3fH
:W]CGK7^QV=U;7?;/XU.>L6>E>L9#8VL_(KH88PUFSIEWfBg;TDGeEfL>.:&GX8/
>dZD_7eZ\0[6WB)OcSA9b6UU8dC0PdS&_/K_)27c2787C8V3K[?GNa((.5)(DV58
9V2Nb6&a_C:KV2W\;TcH^J3H]VR5;[<+.E#A??-&cOK9BNYR?9UgFP3T>VILd5:A
74d@2__Xc6cTdSW)C9<267JU_;0?cTL(?3dZFLXA>gM_;d\-6-6HKbc&a?9(8ff;
/>dVQY[@+74T0$
`endprotected

  
//----------------------------------------------------------------------------
task svt_uart_monitor::wait_for_clk_posedge(int count=0);
`protected
/:3^Y&0309]VS,UNT<D/HG-e2,Z;]095;(T#?)11>Q8@+dCdFg@:.)X;aQ+X[WK[
(cGK7MDa<gdPT@^-Y3_=Yb+7g/Vf>_4^g+);eUac#/V)HJBCdT06QFN1V3cUC^RN
a]PC=N,6D/bP*$
`endprotected

endtask


`endif // GUARD_SVT_UART_MONITOR_UVM_SV

