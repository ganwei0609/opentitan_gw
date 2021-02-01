
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
\U6TAKM<-@P)g4&bE<Yd^NS>gWNOS(Qg,Y?b5CG:?0GJ;f99RP(J/)C(@9VZ#4<D
XV6V?1S\-WD^X_A:\_]+/<Pd)MV00aW/]U;P+YV).F(d,d,EA?]W97+f\2a((QF/U$
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
M/Eg<6X5>3(&W&7H9<@N/]EK5R[Y7P23APCbNAP6T]Z\d0M\47]Q,)E@b-XVLRM3
@2S-I;BRC3[ag\:2=K_)>0.KLbW21A;.-gaOBaWI^WCS2=^Ae=Qd\1E@J$
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
L,\dNG[B-TVK[,_3D:T=:JLO@_/+/gTFb>X6W-BZ38(_Ra^ORe)P6)[35,,_P@NC
f(4GPeT3g@6g-7AXfYDN5DFBa;2YPTbZ<G..?=WKV-=M?FA[:U=T.05_K)Y?L3e1
AK2b3>gQ,R4IC>/]F[.]AK;f187./ae.>3#OeRCT&,)MD$
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
fG28a\U;V]1cJT_>-G.e/G<JX=Q:TQI./\L15RdW?-)@NPA7W0,[7(,6F+J<Qg)O
eVZM)cHMSLC9e\-aB54_/T:RK,,QET-?Q.:bCXbE1>:gUfXb@]^S;</L3H4W\>N4
^8.S#5gX2IP1_[D#@@D/&P9YZe..H6@R5d#]8)ZKVd):c7I?[1TAL[f^X)CIQS&7
c6Pa4^6Q\0;9)5Y>fed-,]II)cfS/J7(L)FEP&Ee]ZR;XNf36F6Ie_R7(OLZeI3/
O?)Yfb8?^SWBP-XN?6GHMV_FYO<dA^MX3)&Q[8F&8MBbD7b>4PJFO&f+#dHW5LMJ
e8gb4S\+J1/9.f06OSWV5WL3)PO7ab#^/a=MX=c5X3_L-0bLB<]#NaF:(M]SCVMc
g5^RIN0c(#^L0LIa>;F-4fJDY<@b^<&?JB@L)<:\:^IaZ&Zg;D;3d\[[XQc/)AWQ
:4K0OHLW\P+1S_M>S/W.4BbdRIF(;O<>N_I5d99TOD8Z[@F&YX<5C&1a+Za,N5/L
R0X:.A#(N88:UPEHc7&7FC^:,(2G?N+9P__)4aaV9DA/EFYIc(2]Rf@W@7=F=&YT
YW&Q7LG(ee]eNaEHM/)^DaK>AHaRJ6>>\(S]K4Y[8_907A49-00JcD.C-?=eW#)S
d/J3ZaT6c2Z\IDbN0RDW#2([LIc;7_+EF[G[aCN7Z0P(@[?240dQQ4bGS(/<P@?=
JYQfBQ/&_W(CFR8d;?K5XA^1]Pd\(O[JM<&UD60BWKEUcUa^@.BD#3JW/9bHgO]8
0fY20(]1YBbTgaV,3P&>Z(2gI@g]P6a&JVT5[9JMg8-02VIdS:V]UL)8#Q4,a.K3
1L-5<JdY7bF1g-e\PR@F4QZa3.1MGRb?\G)Sg8SK/:UQGJ_^Qe^/C1AFKLXeC3AN
HY+b17PcTRM<.JJ</B?)CI[GPW2#H&1e]g(aYD,2Wb0-L>D5;g77:T?1aTVcVG6Z
OSV=5dB7-Q_]6I\?C.(LL,6N-T\+1MB1DCW9R8[6HX?.N))#K@U8+e@MCf3=VUQc
H8HaA?c4aK<#\0D<K@d.KReE9GcCMF8.L(Z=ZIg4Y=AJNNQ:?@]&b<EKD.G.CH?C
^&LU.Wb>[7&WKg<>WgdLY\/7b>:U];U>V4:c7J8cc^9R/EB.^@//8ZU^?+@aA8FH
NGXH<MS&M/d5_0<?A5g[>X1cNZ]R>S/M8]a]7GAO6gc&E9.=YQ0(#=&&eQ[S-5D=
c9YNZB1#VI+8:4X@[U[[U8bK&CYf.FaZ/e.L(C+0N+2:6,/:T1[<4:OL?/C3(LT[
<<gBb3MULNLC+SGP&&+):[(UCV_W2@CI(#Bb/Q-_.SVS._;]F5?a)9]]RF9+BV-&
9J#XCBVa)-O;]gK&-VNCVDX-cNQa^8@>Re;HSMbW2\f2OM#Xd-Pg.[DUVBQHgG8I
.#e\^?&1G(7gSOEYMD:942NYa^fEbBWJK)L06SMS><+Y-4((S2c[G#>:1&9BN.4c
.EXHUQ19CFW3QcY9T=#(^PCH-##g+=3D/:=MFfROD8a\S;(MJPI.9JfWb5O(?LX.
5@9<T]&<UT3X-eR&\EV,YE@Z4AVUIE4(QX[fNL\J]@SHM.9C(JI>Q=V3/H7HYDFE
/1AG9N=G]H56DW^K(@/1<2E9-)^b9(KITCE_=\D-6:8S2/d\B?9D+#d6\FZ1&a,,
7#MH1I]G_EFGH[^^WcS-+6;-#ID&)75KHQJ/b^-<WXb8>g3H?,,\<7H08>LHc:?>
)11:24c[6-FV/[)WD:I6;>ZYF)K/X4;?eF-MX@Y.8A30)cG&I\[))a.A4+PT6:2@
6Qb4ZRMB.XL6X?3&.0794C-GYJ@B5=V(+E;.](5<]&AF5HBbbTE76/,E]Md,N9]I
eAUKWcF(2d_7EEBdc<+cM1HIMZ#bN0M+6ON>K/\?F:UEUYTT-?@:0d^7,a:X.T6B
ZBI[05=Y,5)U^>cX9NGMMGC.Z&#gL=]OBcZ-LMgb?Sa2MYbg1B9_@aRPab9TdFg#
,4I5</SFL<dYZIa,OFA1>YIT7.f?]8+CC]Q/fMcZS:dJ?3C\[\dHdU0Q:LS0-Z^8
GR+QKC?N0]#:I+(SNM6F-f8\S&NLO.IZ/37]B^L4E#S/F4Eb9TK7^D:JH8I8^E;B
/(J3K\84aJ_]CK[<\1G;ec#@8+SNefSIg7dcYJZY)82P.,BRNQ0fUfXY9S(8H.bU
(C_d28]=W;MP@A>0?(HMTDc[d9#WSc-Z?AA?2+Y<923?5F^[gHc8TO7AP(RBScU0
U7=dXP<1>CC+.)TI::dUWR[W=J5A0adg>:aF>SHbf6:4/Q)V\:+H-R2-1dV?;MgN
ZIOfK-SG>4FX(.DAT[5b_>.D<(4F(b,?\0/7.)b(>R6cPU(Y;_N^B0;BYJ<KNC&K
,ZCf==?=8FJX_Fg/g,FVJ7GB_XKNNJ.UPRRbWUKAVA2E3YL=D/]7((1<d,;4D9#K
I@7BCO>V-b_Q&+46>Df>OfQ,]LRacPIXHJ8VRgQU_dT2<8).9Wd3(6P\fO@W(DgI
_\J^a(E:RI(_QKFdcZ38]MS[P_:OW)T@)aZAU^9F_Z1FTL].^MJaLTI?_5g_Cd+C
=-KJ+3XE6BOe0Z+D0HC_-<R5BNCD,fL53FHVHIH=E8)Z_X?/T;S@#9L4bF6L-HW7
6U__8)F7eHgb\b,V>&54#)b^1dO3]FcH-gR/gG(J?_(B/9-fa-HH)(_WI2W&-WZf
_)WK=Y3a[[9WZ+F7[94E30<;;g@XK-.#;GR5GV+[Cc+T;37-gRLNPMVd^<,.F57#
;_\?XX4U9Z3fB;A+QRJK]RD-D+B#V(Q;11DK&JVEB49##5Kd82@bZ\>\a37WJa\3
]P&H;d^[bZ;<1-f^:?@X\W0WE4gBPXc0:aWVT4RZ^&LQ(/A375&VT3A\9VOfJ6C>
#6P_]H15J^eS@@LNeM0ge,M,]BG6S5D9-QcZD]&g[I@c=aBF]ZF=f4b+:BPe]bE3
RDIBK/W\6PAPNT8/WI9Q58dC>.WZHEDRH011.YAL3QQ3(()PI^M]6WWCVSc(#A>-
bBb68FV:K6#7UQ[R18;)&];BWIY;J-.gL_.SH_Z1/c>AY4X1UT0MN(9VLKgR<R+;
b9I.F>:AFa@L?GQL2_NdK7(1EZIST?,dePGBKGafET.UBSHfe3;&<LY-#JS9AG;A
).PC)_2\FGH+R.);ALJd?DH<O^3&gg+EDO@K6;MSFV4YL4+(LJ2P7E+,O[>LY5P#
>eD<(K_@]7b4_M\45?2[8>UKR\8CSA.gW-7<1fN1=]1K&-E7=[KW\IC1>9Wf/g0F
V6Rc7\&3[g^?QD(Tc1S/E(3U;80YR?RKLNVD9V<I1T@6OF)0beK6J_g4J6aG(bV;
Ld<9M47I4fW/a.JYM_G-YcH:^I1M#_GSQN;f+57KgA=baO8_5+(B7;:@+M>H8>I6
_93+]]f/K;RQY3Z=70IS=HQ+F+5D;]TB3;&0dDI94S9-gFRS(g,(A#:BFUB&dba^
aH:2.cRB?_0&XO7O#VB2C]<>7?=LZ_8cce3fDYXJ@4>9QYdeKR[;(N5Db(]ZZ-P3
6>)KKT2ZR[?.-.D&:ML2@[JIL0Md^SKVBU4_g@[+OLH</Wa)DC+;:]8-Q45/Z31S
:?8:O2Xb1aKM4TfPcg@=)(I]MKO>/db82@EQ=L;9IIFQF#AMZ8;#9[#X#:_=X+_g
&(WZVe1E=.MUUR06DfZ>;ZC;KFQY@5G,?C\\da^-LERUOV5T\YWQV3f6d-4Z77=^
TEI&K^4AS8(WWE<(KgSE6_M\fSMP[UQFI-dBRT#OaC49(J:Gd_H74X-a+b&276aM
]H&8-2Q51b38CRMI#XF_2TOW[-X9PIXK^DLKPF,6K1;J70AYQB^KGCWdN^Rf,J7.
OTUM2T,VXd]b49D._d.75fC._XT&f/=e<QDcEG//1Xa+LK)H89DXNCM-P3be&7Y0
;31B0MN]O3dcXRT7[eA;4#NT?:JB:5[WZUG)/WN/JbA<^S58dV/I./J[+M[]KF&M
/A[/c_=\E2;5HDL?JRB/^5_A\V>>P=9>+V/9A(Q___^)3.OP.M5OZKVTAW29GMG1
RDTL+-Ae=g/V9H&TA:SF/VQWQA;V\>.)_cHVTOeJ.)a>]:aIgUg&XRQXf,P4[FBE
_PE][?RI3gZB;95)\[R5A_eVICO_-@=>.5M;/.5&Vc^4DA9<H=+JMMF\CfU->PFY
4Q6dZ&L@<g?)9S33Vd&W)]T\HT=1d_[ZQQ;1[ILc^eJK[\<+A^<U.>>F,325K5b>
f;/R84db;[gAAB_Z@[.RMX-2^^aRS?\S6P-f<g,R9E1FNUSISe+W69HDX3Y2W\S)
,?AS[ZI+FD7?+d]a?@?U\OAMf<MdL5M:T/9[V3,W]^IG3FMQ<:ee?+e8.^:+&fa5
5+U7b-dGRf1=8S8/:3e9+]7OB)0B.d(GR631Sf8@GWM8PU<K#36?XD^</)MW,e,L
J-Cc]H9;aZ3F1.V[9&ZOdA\W<YKdV2^UC^TS-<)],Y/AF3;__[P[I7N9Wf\gT1DY
aQN-K9(V]OWfW]1[)X.62Pb8\9B+(RgJIc0\2a8cZCG=S:0M/OL?FQ,OK;2#]_1<
gL3,ZOD]WY)(PW:S@(7T;f).G9JF&5Vd:^&+;/&Vf^W:3fL@)5X@/=gK,HgW7J)Z
MeAYa3^R02+XPOKDaGULa<BC;g/F<5_^gdTQ7?T&d3dD:WPC]EI?8@-[TXd>@+HC
W9A,SD23@:)7?J]SGbSWYX,90G.-)WPLQ10SGM_ZZ-7cH?e,3ZZ)A>BV\+VCMPcE
TI;GT83HaA4Gg9N=aGU+D3D?[=P7fD83^f9[JRA@]PA+J2YE-NWA\cA8)O>D/?J3
V7:P[[]>)-C2SG.48Ub7TYUa3F_@9RG7UeG@SVZ[0GbTWD(=1H<Y=dP/(b0=SaPK
=YVI2)R[,Tg9#&F1]Ma7ZAVdaD[dQQZ7eH-a+\0UWI<g\cO+DEUV:AJX)ZO[6\R9
(VcTML=6-G#=<KgRIggc5fL)^,5Lc0PTX;WfA2A5+W&C/9:fOT.Q?7[4E_\SAO;c
2R06+)A(>0X3NGa\DN#3gIP\b:B]GNNd(-WFA+e5B0U?GI+Z1)5WBVB]FO@X/XV#
^16Ze1A[J@<]O=E9Zf?H[@8-D4dgb7O<TDRDVU<QS.DEPF65U3@b6<gJW4QM0W47
O\[-aAALJ]U>:TG@Id]LU^E5)Jg)_]LKH7cg-)-cV+#(6Rde#?>AQE=R10:bJGNa
cPb>HS+ACRBU/N2_.(]@#:?NM;VUg2#4<1L_W3Lfc)F.FP/E@)fdLU>.aN)L,K>D
&D)N\/94,4_N[T@7IMG[06>7PV7:HHO#IU]M+-PT&DH]C:V=QSQGc-90JYGM/b.4
T=<d3DLIZ\EO2&A_Rf@0Nc@ZcRCGG+]TaaCOI<aSb8?HH(ZQ^K^fKUS5[HK?5E8A
W=A[>#5^G-83A[Kd5(S_6@.PRgQO2&164gU:W291U?bXE2&/aLSKVcWJ./c_d[8K
8[WFb\AaD&(TWaP-;PHAMX5Q\OBd1bRY0GA=A]6M-3?9gg69P[=0_VdQ+QB&XL3<
J4<_@S\baIN@:_X^(3;CU#6=?B8]WGJaQcRY@CMD2c=W,]dDbK/FYP_/+PCI4OX5
3&39(\@e@B/,]\^b>98ZD@;5Db=Bf+&CMJS5N)[@2G&&3GFfL(\ZV=d]ZC08ST8,
AUIMRS^B4dM4?HGTgRII>K:9&;JDETP49K.aT5;edME0EVF?&)#3I3Z:ADHR(7cJ
G&gORFP;&:FF7GPW-7L\55&E?)?,QMI?MIUMf1R8KH,5aXX6\HIB)b&L.S^?<>NB
X0Acae(YR8N[]5Rg:/V352S#]I/d:#]U;g(B0bH+>3\.1N&P+4Xb;aX.SBMUZ^]5
d[)^@&MY7GgZNEYO77EeGKb]aO57WRb+:<aY2PR)/8)1=)f6IL7R)dbe2a;Y#IPE
,bV8>8^P2(SdN@#3R1d=8,gB.e6NMg3f/00bCVY=Ed=EU,e9&TPAM^aT]ORYg<\W
95cTJ&Q_/+c]J3@5W,X-IdP_Sf:4Bg?MG<<Z,P-)RISeCA_ac?b[-:8d9<-CI\0W
aL1=0-N]JX0b^O9HW)&_+JI;Me)c+L<530&Ne59#VNUV7M#QYXb\G.g;VGZ/\S;J
GEV:?KT0:J@71J.M6U2013G_A)Yc(>:AZ=RK44SbUT8?7N7\af:a4g(d5A=5)LS6
?W:JSg(PKM^ZINFZN-[<<;\&P4&MdL^1dQ1ge\]Q]#8#;#.;;\R6TYRb-E/>_N0N
?I,ea=S)PDGQE+>F)TUcB@C?]I2BM]I(C3UE&2OU7<.^7KfX[.5Q=+#FL5[:&U4@
C9H]a<&8B95#@aV95eBXDQOKCa5<@U0ZWGa4WK<T\?KL3Ig^2HO9\c8)UHJgJ@=0
\@]8&RR#:_W_[PHU[d@/EGNN46R1F=TWRLZ[A+LbPAeUY5+Z+I=N(JTC0-SOCW@R
O<8<F??LNYd7J8N4R.CMY5K5SI6E-Bgdb,[6[LcOVKMD8+FeC@ANX;75Z3XVN\gT
GMAR>LZ,>DZUDcE,PbR[#AQ@VR)=0,>XJ=gEEH(]XQd<:F89O]<H4VBU]3Q3^+gE
2SVRP2M+=)Weg49@MXHcA>f/3SH&Vf(aSYHG(gI&a2f@@3KYA(9L;1+L.H;YBaQ7
dB6^38]&/cJW?GTW#IT1\V:R>=eH#f\;SK[b5.XcA4:C260T6DZ3OOdbZb:]DI3U
;@-F1.c6:b2-;Y@N]@O;<#^[QBY0+=(6A.<Y)1K2>3:,UefY.]=D[LD80UQ)/e\Z
\@0ge&8T1#6>[8U/Ube>##?V;P-?(XB_VdEPIR#_C0KI4G4:CSOHO&4>H@.F.H[B
E3V4Z,QD;11HaW;a?K@H(U=1@&L#.^4&O5Qd<H@Ya9I(T7WM=XQ=JTU=0,MH:P3Z
^0KE\MPDN2PD6+Re-QW(FgIg3OFX,\DRRKbNgFT?fb8;\<=?SL\Ff6LOR-Z7@9O0
X@CKLG9=]3^^[+cY6[(C>NI-5f]R8BXe>L[eDD54\A:+\5QEP4.50_\1PR+:3Pe3
8RdRI0V[b(a)#cK8,U4WI_X,T:Rb7Q6?b4_]VagTbL.H?6=:GdgWe9G?<#:8)2WW
LE>-_DJC_3FA/2(@+S3g(>=,#eHL,P0_JgR9N?M)THB9SP+5(+c3c#T+<WIYJgg?
3HI/CP:TKLcE-[W\RaF0KU89W.4TPb@86I#,Td,(3=LGYAA64;,2QJ_Z2OVG-X@A
(EHI,@?EYT\J^+.)I(gQF+?[.EL:d:e3egV>_((6Bb3KZ.L[)VdV<_A>)3FMK@Pc
/Ag,6c2:Q#5+P0DRJ4b(8+IE+\5U#/Jeb1c2ca+D@8dBHJSW:7fT<0EY+O>?:S<4
cF#-0F+a++M_.Dc<ZQcGU+.@X^_Z2U7cTDZ)aU7C-e4AO5Jg&0>D]X\_=6F1FJ\6
2VE1@_+gc(;eI9H/B(]5FK&,3LCZ\MCI-5BGDH9M@X<#:6+f/+D]K\Kc=37&^R.R
,C+b;?NA7;+;f-Z9GB&4ee.I[=+4Iac]<gbG/E9d+.4;b.SJeZ>BUN1\3^&G-I<+
a/OSU<?3d3+X>+O\BC_D82R97K3<M^3U=1)dPRTU<L0a:WaHRM?],;/J9_\)^&<M
LS>f+PF>D0:DXEL[XOR<EXZN2PUaOR[\.OX,#(;/dLfE5gE0N^7N&?KB-CJBg;,G
EI0+DHa=3VYQ7#^QQEc(6V&FSdP3bZP\Y38).YAS-VW6a0f3bM[EK75G1e[Z3J+T
;R&>2Y9+6EK<?#gTO)>g)b[-_3.U;fO2?+@2:7CHEVKBNDBWJ6VYO>be,^1LV0BL
=8A2Ec-WAK7[8I_\d#FNF;\SY;O#J--.ea@TW@M77EaRVXN?5.6e>23bTH16_S7N
JLDUPF4TeE.9>c?NJ;T1EEe<[BIW>[a@a43eWM_Y;B.RaG+c_DDM+S3TEV/2#NM(
^23+#[)7dB:)+,D&F,BA^.\+6gMDP[>8<6U4V-SfbA#JAMf]HYBOVXWQ7GXg5EOB
XX#>WafN^ObO^W9P]._,aAa5JK\Z0=A#9[IIP5P,TZNL<e7;4GaLDD8gK\eY<X,D
&-WLIf.(9RLDSC=58\Xdb9OI0J2+.]g?+VZYE>b>a&@Y/g:@a6gR?C:+:Z5gS,JG
=ZUJ(UC/_W9bF.UXTOP^[)5eGaRF\M<e=YEfX\OK,X9TMGbG4M41H=dO=Wf]QGA<
WL\DYKcT+2Hg9PdH4cNGAcZ+=?[?-+_cf;E<W0J3JC7L7eZPQE.]TCc\-H5[[Df1
.ccgK(6<2N>8JXX53)J?fd(;c/Ke9\K8G3PHVYS;0HKLJH;^HH6UY(&K>dGTOKa-
(2S4S3Od2>NN,a>XcN1A>&T(]S(GS.2RcBD3TK_HbEMO?NFX87(\)X&([+&G3(gN
OJ;GX:0LUc3130X/TQK6;Z:[D]XJ)J_1,QICFX3)gM9eGTOA82TX1GTW4cB9DT?[
QL)LHI77-T_Ee4IbI=Y6WC8f,)2T]TEML8e3@Ae_C@9eF$
`endprotected

 
/**
   * Used to insert posedge clock wait cycles
   * 
   * @param count Number of posedge clock cycle wait to be inserted.
   */
  extern task wait_for_clk_posedge(int count=0);


endclass

`protected
G7,;ec[QISg=W&D8@XH3Xc.-dI^FYaKIG/L+aCL-F&PCZ?O2Jda50)YO9NJ/AYD5
^42@QD:<g=UGIQG1JDA9OW9#BFUX6+cV6S0(8cVff<PX5c2HK5IREG#2e1J-^bO&
#I5e1VdS#L<f_K=143R.#dYbTSL5/<2&A.Kef?420PFTPM+/MMCZ^IeCg-O4QWP2
D]X#S.ZG,aL.H]@)#^INa(fdT0WbVWA=+eAPa-LCM>J<Ve&QBJEQg>-b3)=<f.Ka
4]G]IEYAbI7/dSBUcg6=a#fd1$
`endprotected

  
//vcs_vip_protect 
`protected
EHf)^2T,=XR1I^AUFbBY2<SQ7UT@B_&24FPS?MA/-Y,3Df6B91V#&(1935&RHf>>
W[3SJ>B_NAG.#Q5NVB291HB9N?B=>gdF_0Xf[?+LVcb-?P.RYP8f1]V&P_#Y3g-6
A@I=AW+#B4#-.^&KAe+D/_[^WY>X?#&2T:XL[8N(agEC_;]M=H?COe=6=@C23efF
R=bVFL,TX0XL)JYKSF:A9SZ]A6QQ#/bfHAg,9:gSG:,Qe0e(J;CC,>4P62?<NO>2
5JG4YFg-]U<L7RZP4cK(A;W-aPLR&>[Qf9\AX(NY@-,,SARfePb;,(39_J,Q-0N:
32F17Q/ea4X)[LV9>AdT0^d8<_2d4J:W7)cK>fg-@1B[3&a1CI4F/#N(__^O[]UW
>G_72B.eH)U6E,b[\B)K]H_S<W_ccS3_<L5CUZV^:/KcGFbf]FP#BK?_#SFb<b0V
<=/29OG\@Td,._8+(0AQAA^E6C0d,d59Q.=F=0223=(XY<=:-RU1?:\[O+Ma);=B
(@Ia;3V83gYdgR1B.GHVQ.Z3e5QeBX06(OG6G:@F5=d\0JLAK5fRKbKBd<UPWG)@
#QcEY#dX<(f^,.:A.J(RS+PbNeM]AGP.P__-daVL4+bYNZ8cDF;_Q^B)#QWFO?CE
Qbf>^)aY.6_^28KO]\bOJ<=8:[X:\Yd.?HW>?]7Je9+5C9GZgK5IRGH0X=>b)@/>
K^74@b-b(C>aIV009ZgZYPRTc02[0@HNaXIb(P_TI@38DRX5eA=T9Y:(_2L[&U09
cP)/d]0FL?S0\Pb^bPTK]Z[.cL)LO/c#O(HD&7;5HR7_D&Lg3e-[121P4.e8U]-7
Q:2J@Z9M,@6TPe,HR\NE3;#,9OK\g&+JK;:GC;/8ZQIS]=E2F).LG53F[@:O=;1c
49e7F(7V^K=EVL+)QJ2Zc&c5S/Q&?VN^CV-X(/5.fH,C\SA)V)SIID^X\faAaW,4
5)(#4-PGF;78/K+.9;#2\AJFW-0R2Bb<9IRgN5F[L^.I+X?>5E1Q=JAI:.JQEOJb
.gN_Za.);I8ZQA;>+<>8>W2@YaP#EeT)#OcR_VGY&<NM,fD660LIHL8PA)&#+Lf=
1T+=TI9(7O_,[;fJB8I[V][^RPE8WdJG@?,I1^PMV3)-dCT5#]U1f0gbR<8bQ.,W
\LKV+Gd[MQQ5:@+gRG^G#K-2N2K0VfHRNc8eP;I1O,+CN^@TS:YT=,bgGNa.66Q.
2)#0D4KU_fDf^ead#5?LN(3?FL_6+.->L[BSKT(,FX#Ha66F?;53@Yb+b-7.98N>
S),@N-cKZK\[M?R<MWeWQ0&3KgP<RB\cGKG+bMgQ.?FI0&g8M91RTY+WLQcN\bf4
_[=\0c7)\Q)0#RD;C3E1dK@&KSKL<D2T5_c\IJN1K+[c/Q7RIKX=F8A5XJON54F.
E8<W3fSK++AC.SI,G(?7L7b:SL/D6ef6.6W^Ic0cR^JS(RQZMSL3J?Q.XCRN67LH
KeLR?&@a@].dK,NFLaV[:#Z;@,ZWa3c[A5/)A>0Sb28,G?TZYC<A+2S3Fg(NcWK<
_ac-_S4AE3XGI.7UP4fI=7=F(Y@58J(#c7W>D_a4]d1[&g[^(:VZJIUZBCB?1]cM
?fc.NG\:-?@9F&1ZK@=cA^Q9Q&^;Z1&#,^bUHLK<ZRQK(H^M[DF]b^1c0J5KgJ65
KdNY5T0aNg[d^@#W=]0/K+M:Xa\9d=R4/_YWR99cYGLdVJ9bf:>I9;dTOb&A+JK]
8F]=PFG;5D/S=e)1eM^X#W]OTgD4TRbfCP?62(M1gW_f^-gcW8J:(Y=LUR08\Jf[
-J,T?7bIJ>b#L3_)0JIe(Y3b<b,#2LbfdOVP,[,0JJ535ZF.2IOEBa^;R^Gbd+\D
A+I2&@A6W,/YQNTQTd;>STLSNY1IAcLfV4RP(ZQ\#:^?Mf_bC[5Md4_J/F.?gOUC
MNB/P7a0XSI2:7C?Q62E0)G6Wd,O[<[(<@N/F;7G7H39<GPd_1F:XPa(UV6]Be)S
<:/CKV[@<bWY1T?^c[YF.21A]F;_gY+CX,4AaZKPa=WAE+f4#L:eT(?^Z^a]CPYK
@(&gC6L6Vc9.K0^0=)+MeBSH?X1J(,Z<)_\\KD2cLX#(Lb1[Z+>eL#?OG<[#FNe)
)0SU?/.G=D5A&_,1_Be7PMa5[G-R]-3;K#,@.(3^BDK+<>#[:(E1TCE2W#cCDO;5
SdK^:aA2P6N-W6F=Le8>9)#[S9<d\.US/7]._RWD9N_;FX0dfA7,#J)+4.YOL8I?
]B8;=@d=gFXRR]eX<,aO(^BJ_LVV=VA97e[0VXJXXReV.]2W@fFYe5RDBc-2^>_&
R_/?+F@V4M-I:&RVI^UbJDE.b74gL&GAaaC<gW06bUeXW5ZJg.TWdFc]KDA/>DF:
B-/M4^2L(&M<KMZC[CDOM)6Qc6C3\2__.@>5K?;?RND]fUW_cZ_@BEVQ7F;?(CFM
^c:+,Jd^94=gL.KUeAJ)T6bV=DA3LZXe0Y:R=5,81gaJTR8@8G9I3Yc3gU&OXBRJ
bb[?>9aT?VE&[R;A]dccC[6^FZ&(G#cAT+@@c54E0-ZH/,J37E@1F2?ZF&[g4MNJ
11AY8>c4f54Wf4V+::\N/+JFTA=ZHE[1M3YD^a6542I<Y:CXNZXKc7\0ZF9M5>bU
]8ER]e)&GQ51,KW?U&1c;BNQM<\-K[&\b2O6[(YfMX0]GF_-O1Q9>U3J6\[)?RI2
N:HO(ED026BNKG=O5)@YS(EZCT-FXP17_Ke6f:.XbN]gW5BcI,PZQP_W2K&S,EaL
SbJ\>U8\c9B[(D1RgagFEOHZ@>0OK3?H);6JM13#V=#M;f4^D;<ReD_N,B:8--\4
F>Z#Kc2;1=4;W6KA)+/1G&2Jd@6fG2RE8eb8CP/J<_66R]E(F7>[AF/)=FY0_<@A
J>2>D+>ZBI#NJfNA[:&b)#U;/]2f4K,DSeUJcd@;KSX&a30\eSAYfP?1[XW_ZCS?
\K2+(?S;a)C=GXNG(TB?1=CU8>#.X@eJa?/WL7IegQ5[CAa+a;7L:RE()=UIR3^c
E_II#D4-L\VaR@J9SR,TT;?:VMP@38X4e^EABUaS2U4.M46KR&YNU+9DLJMR6Yd]
67c9(WeSPTK7N36\Ugc@X1.Wf(XG6CQW,WFJAUG.1;2E@[87M<=;Z\BA8\D[2T3T
Ic(QNJQG><e5X.M4Td:fPD8f:ZU\?(;]V,dJO+&I=PQN(/,X(7YCYB?;,T@?gg:f
3)N7:;C3eVC#+J>XEb1X-FLNBU#.\Y4/ZR4F[JHE&07XEY_&=g.590Z>W+4[/19^
6F3W/0a?CUTBgIEcTXNELDKL(Q;bU\#K\[-<[\8Y]_dUA2T6aTA>Y^D6B5Ce.JVO
R#25=]g+_0>U(-@#1Yb#>A>5E>+GAe@5U=Z/7?LaWGZPOgEg8TWTeDE)G;OcgbUM
e@<=IL^MS,1)6aPQQELcBNI(NK/FU#I60FFJUQ]2OX\baI,(U3YI_A&9E8;POeV[
#44Ab34^,?8E7M#0<bG+>-cD)g3,_:,9ISODQKOWP7APSFH4gf3;&6&=bP73B_f&
Gg:(A_da&+Y^\OR7\^-\fRYSgKXR?),8U.b]KKD5Pae^PJ9_(&AW2V1L-,CF9GER
4))e(5UQ7?R1_O-CZYAXC/:-:-Q4^C+#Ba\&HD17ZF8?\TVC_>M.N.Q,fV515L>0
4\TM;A(WG3[JP\Uf1K21cOI=K/1^=TC@S?EM35WPQUOf+PC(5ZU)b-4>S_UOG(3Q
?e481M=b-QcXbL)8;&&fN+;HZ4J-,;\DcDGXB@78-:]UBFM/#.AHe1\+eOfR_+HA
6d2X^PZ0\PML?[F<GS1\f#^L/?HJR(+P>8:/]c?;;b17e\603aDgcUad>=Zf+,M5
>O644#G41,OWKcf&V@Z\S?g.O9-AbS_4GX#X8Z+AH8g)TbP_LbCWb/Dd^.ET:RV]
?V0SRSDHgXC^6+CL^WNOTd><-U2:(8>B+.Y;.@C2:GST4WW#?:Qb.,?G(06GM;,^
aD7>4I4dV7AENJ_;TY3+XDH9UQZ;ROU(3<MS<1[SQdGOHea_E?>VM-UXW8[(1M^B
\L(ME#4-=XT[Ng;5\EDDbE7O2Z<>XVD3WF,8&WILB/W3O,5bXD.OW29FRNO5[B0U
P/H9N/YA2-4)K:\M;.T>f;P@JZ?[/8TcJ9U]CS/)?09_B>S#,0(>HTb]8fE9X7PB
1QI&U^X[gXHB^F^XQ]PdgD3O9Q?c@E<?5?MS3eD5PAeAY.]\91.+Z>M=U6FX?E37
_\<V><^IP5(G)9/-^Y:7TXd>6)fD#V^L7HMJJ=c]N/g@eUCgB-^31AA\8JfX=:@A
AF.6LQ[ZQEF5[>bf07A9d0BLKK7;B//a:#225U(@0#/_BL2B70a40(8BD+A6CKYE
I\g;(?d<5=<H8Cc1W&O,VAfNSR8R:)[Ze&VX+D;P1+=P744]1N]_WH;.-J298gD/
]5g#DP(1]aM-\28R2c9Df[8D(cc,I>b)8/dR.gCDF7R98Q]3/9@a-0I&#ALI4VHg
bMfg8bTfc?I2,=#[@NB)Z&&C@=Q013>f\4@M7,39YN)S6SFZc6Pa[(1@SPfQZRVT
0]HC6Wa#^aVZO.)Yec]S;J_?SCJZRb1b^=A@O8,+@#M_7U-Rc1[#35-c(ER.MS42
Q7KCUGA1(-40c:W^P29)7UA-f@dRfH\#+<;,d^ZT=U1G^V1:Wg)OBM^g[c(/2FTg
8__+ON17Y5Fd&HgO)KICN1DBc7E#)?30c&4:ffC)LAT(YfaCS#8&H\c+_-\-/Nd)
TDcf[ICP+@;D8>[33.ZPR9X#-(OY3gQ??[Ia49V8e(JZ\MX#C#G^b#^B;1Q0KYbT
R-6MGTT/@d9RDV+(VcXaW3a8[BbEG_+O+c[YbIOOM8-W&gZN_?7CFHMWIJC0?/-?
J:7QJc>]gN\3CY&FSN[7>HWT_T3]NM)>H./9C\+1ZBTe^CJV#^G[0]+C99/[1FaE
AHA0LeL_\5G161]L;#)KZ)Id7]L-OcHM-SIYg:G6]^+C.CD7HX[T:4>Y/C^MBaO(
5G0NL=GJ.-5bHE6CI1[YaR+BFgYX7USCV)?(/fEW.[8\ZHg-Q=OWb=H(J-S2B[@]
).Q7DN36#/2#Z[&B_7IAbWd,OW0gbYTb.8\7+J;THSW#T#c,]FF/]65>?:-X1bO8
9a.F,L<+DMNc))]=QP^(ZBMWf&P4BZN>bCJ(#+1].1=OFJ944075FR=(_T.-QT_(
-bJM6\\Q7aX@BJY&Z@GF<d/@]ce;7>M2VeZXc2:@]5c2>X.Pf&^(:QK-J#:#d]AC
/T^6])LbRMUJNFd0;S.#T:=>>6H0=HcF:>=AKTFJgKX+]Y,[Z3)ef<dV/R56d?@T
.Y)3V]IdM_#3fR:^C_6eEW@FK@=/(K?/TM:35^NIf>N<2&+1ZOJaM-+OBQIHIX9g
4Qb[?FKd7_6fPAWC?NdM@(Z)cg&K>1_a(e5S;;dNRKY]WG2Ee8L.R2#]YOL10HTK
Og3KNROVZYB-WET4@ZcU-I,F23PSdJ(JJ&+G(,J_K.NgXEDZN)+AJSEU;+]H.1PD
+EdL[Z:R/C+g/_6d>05#ga_V^RG7f9&S].2IB@c.O<cH1MWgcIE/e0E#b,:;2/&A
;.?B2e95J=FHWGgRd8?-:>#AWF<WCTTF9&@PNBQbA:CJ\fb]@:7eJ3G/]RIE_#.=
gQfLWO\>LEHff)a0[9>U19EN[.d?RGGG>SA?(dD&MN][,KL]D]?Q+U#^>Af/(O;5
JCY+9JU.;:CTN.+d)?(?\QCGJ?FAMCA)=1cH>&,2=#I1TDYJEe7g/XeXaD+fR1(A
(LaVOA(HOUbe&&Z5K;E[2^U5F4d)^+3>6gS.7JHR<Pg_Og@N^B(+.0<&ORK57.]O
;=]d4<N,CVNKg;1gSMWC@@5#GN)LYQ0XH_>bL,ZGAC4gdMQ2-;J7L#M:X5@QG=H5
V6QB2EI7)(f#;1cB\SL+?K&UUf<MX0<Y5d8#36:b/I7WOe>B.202ZI27XdOPX+f+
MPf;196[cNI\IJ.Q(7WD;/ZX\H.<LY,2>dU@3Z1H,/KcKH99,VXCbd6@.EA,[,B-
:.]Y)SX@+Y5gV/KT,EY.M[:I0ZPIT1G3(:(Q10fD.Ka#7__WTA>_XPOAT]TE:[X;
CGP4c12=>5)RRD=E4ZQ,=A:I6$
`endprotected

`protected
6PW<P;6.cMEUc[b-6cR;_gEZ)b]-5[=5E+J7)VHL@,SKXG8:Q5@=+)&T[de?27c\
T5N\O-VfA0ZAV\-[-7,b_#EZ2$
`endprotected


//vcs_vip_protect
`protected
6e23L6YXfJGGBI@g=,C.8RI4\.SB#aIDANF@PdT;GX;;;+&7eI8T4(NX8[S3&#<S
W>0XgcFU1E7eJYO#@DK?.d=;M=LY<QDWK/<Ve-75J://WNF\^5W5(AV6e#C#MT>F
0X2^9X8F4>aRTf,5@E7#6gID<aH?+56:70e3]Y]15^[Ne(?=/)ZS>7DP5DUT.6D/
bM,5UXNUDDR3Fa_\<^^@f.??K.]c0&L>aAZcf^5[-_I:ZGadPP:+WNJ[RSXL5S3)
J-9C1dX,U;)>bW0Ob09G@^KgB[2X:KA-KBfRN+a&.Eb;_WJ@168.48]ARI88SdbF
.[5)K<Q>aIJ,)D/1LGWgVH(.:)B=R3]g8;Z,U57U@7-5S:^[H]fNF6+\VdD7:FK.
JBC2e=/A9AcKI8_AK+b5C7HfVb[PZ-2RbF(AJ0CgDA+8a]JE]M3EMZ#N=7<AEMQ_
)2e-EE()gXK#,YSRWB3HW7]0,G:X/_K62K;KP<FI\#QTdE]ePITfW9GN0>GAKgX3
]PWf:Z[3Z9+Q3c8P(J\Z174.T<^e(F6D1,X0TM?/(]f.7U2[TB6eb1Y1[T_TeC5A
XMU]_1A#c5d66KJg44V73QAJ6=c0A6S@)dcXgQ.L;[LTK8AA.\2YAX2UJd_LX5#C
:?PgLCN<3_HY3Q858NQ(>NF7N?DdW3G\=>PZ:3=QcFE(UO.S^D@35dBcKc@X(WA:
>T4Kf\D0@bS]V,B8B3B4<@04aVB4_;2]BdgN._U3g).H(GI6[XF#XG[CDYKd0IF>
6EK@/L>N;,=-M[f3B6::4TBR?<TOEN?2-bB[0@DH7AU_c).KKGa44)(J?cG7@#M+
,IT8dT>=dU,,5?^Y@W#R:LNcA,0LOAQH3OQ(S_fXVI;>@::</77G:0Y=OfJD(WVE
OHRX3ONG(^&f[+257W/8F0fOE^;.beeC;;53M.ETB_6^Y4UH26Z/,^YZe4U:#UY(
RHfAXH4?(I5GHgOPg>&4BF4UD]XP?7+f7IO<2M&^J2C<YYQ]W7#Z.G3Hgg:(YRP?
BXRV0;-H0=A/MCJ]5M/E?)56Q+H0IF3<M)Q/H,QSZfbVMQN?/6@9(HT-d@Q,+)E&
/9O6J57)]#b-Lb2&VY7ME?;aR7#7V66_68N>7=DS132>35MF-5O2E;d2,,[<]HEU
R:\Y0J9XD69TKV/)7/ZPWUP+-36PMbSAV)fWcUQ,+a?+UZaLD?-KMJR?;aU^_9-S
RI>[B=TNZJb.^6HT63C\FV2d)_+0e4EEUV9)>2@K+dWHA_Xa;K?<eLBc>T8@d9G?
.-,8D[\CCW^+O0@&.U-e1Q,#P[JgL?Y9b+&N^d>F)b1\P-DEE,\K.,2=.7826(Q7
a/??aH_db#cOE)R[+BIBYb-1a6HHA4Y;<0?Dg)aBe&?<b_[8aTESP-98?O93/J9^
ZgJA\ON0.ZY0-R1#XUbIMW)[5DaAC=:/[,Y:&c<<I-X#VD4L4+bfaB7.\9gFH]>V
/24Rd&2+Z9(SaX#2S,[/[4Y20a&0;8(2R(.#.8E2F;CV9IYE#KTZKY?(@0KT?J1b
[^4XUf]#3XaJC-SaA))?++e3RSb4:8Vb@>.+5Y,HJCMYXY@]Qcf?55JNHA[WK+)>
TQb/JDHE-fD6QNO7/2-/.E:)J6678a1-ebaX2M(/JgM))2dGJ78NX.O:g(KZ_<:9
VLb:a<QcPABS6)&#HGVH-U8\P\df(M[M8;9@<N88IL_:&[dH<QO9M=>gG3H]UZ_I
+dVBX3MPRU5M(2NFB#5f?+f(_DQVbEM^T(NAKSV^XDC--09>PVDCKOZ+a1AS0[8f
dO_^>a[02[YU33SVCCRa.F5bV]dD2TGdN,FV^OFD@\=a8AT#1)K46-1<>\#>Q_V7
KSM_>T9X&(ZdY9<^,41c\1P@DSaG_BL.a(6BS,U;TQWK^<NMK);eeE8<?L[K0+(8
5WeV[gH1#N6[_-S),E[CH4bP2+GD:.1P?4=3Z+Q&[=c)GE:2O>_1X@]0)cdNMWIG
4[SA=Cc\I9D)@\O^EO3\3ZF_U-LXQDY4_9E&<NU?4_5;3T^KP[TTK_VRcCMB/3=4
;O\IW(,TOP5KKR2>I>P^Sg^9c[EB:?eA7S;>]BG3-I:\,5^H3T-L_:,>f@+D47RQ
^W:+Z.9-F#;@\HCU(0dB;TcGK5)V>7QWZS2Z(e6)Y>LYUT<9\)L^FeJ6W4OPg6D4
D;dU5dUT/;HIKK.9](P059X#+W420Fg:;RC7Ubg9TD&CI(EJB8eM=dTE3baQVe#P
a6&E7^Sf8;M_Cb?Tdb6[Rc^J9#Y93?.OP6Z<^8Cb)?a/J9XWdAf/:#A7YM3\9F(D
JF-W.MFP6g9C=H)K\-PYA2GO6.;dX6&5H=AEIB@,DIeL^^Q=]GK32OH;W<5,g[a4
H\Z#cY?.:=TX95PQ)I<\[bR>^7[JE\@,@aFe7HfN:Y&6,f.e3RO..=:0YY.32CS+
T2(VRP/>JU24S_MVBd]_XDP)FD0Z(@5(A@fa15^MBAb<.(I#9I+.#99T)))^@#Rf
1#LH76JC,&XcQa4EY1P3Q91,)P7?]a#^<7O=;fDdf5^=D1W]NR3EFbBUQ(NUF/4W
<L:Kb,KF+16Q6dH\8g9HCK-BW(GaSQPNcKX/F\@B7&b1Q61-?A_=6OPW3PJa,W&B
+M9;F0IL&HFTC7\NNAa:0E4REPY4,cRY?V-YO:E8RDAB?ddI82de;PW;;1E(R&bS
e077&SVC3/464@f9JO6R[<WY^22(C:^Q\RV-(#SV@)9W.#a+Nd/a/OUa@WDTBL\H
Fg]#7LI<9GQ#dN(4cO4=WT/;-VY;6A(4X6Y9WgS=K^97JL:fNF\;ATV8(]aVQMMT
4.X4<(d70>ZVI>J]]e@a3.Q?a;HYgY@9<LfC?g4I>FcT3.=4XgGPX7>d8Pd:SCfL
/24K187VS/-cK0+<W5@T6:,K,7\Cd90@N;H?+[^c&+_3V.bGg^RJd1SfC3R]^W(1
&_M;4dL:ND5BNY-Sg.+Ce:e>OWXGKed7OaPN7>Aa;YSZ\#/H(a?BcX45GfRbM99@
\2Ea/VVL^cH4RYKId:d6a5J8>R-G4WU3O2PVY;GdXA.Q(BZ/Y3T@O\/>5FDN3#HK
S;J-gLDe>?++H70RL5G3H4a<d.^ZDYN?TBY5aM.De4J)JR7WaHWYZ[^&EA6^@e#3
D_Kb9#@eD0M@cV_#H/:TYdg\;<-D7Y3N[>6>/Y.>T#@+g.Ed,:H=SNFLO\QRWV#a
K3.SP.Y#d94<aV9]K(-5W0VO,4I=:?J:OY7[;M[ME0AKT]F77a:AXJO))SU;ZLMN
/E>4F1cMWPIX9;/SVN)EPIYLPX.6HQXdA.c_&FVZ?eW=NbG_HX=OSV49_&Lb:1C8
N-BgO(cX.bF,&_I[S^[7=9JKDeJ03L]C4O5H>:+5_g[56CJ<?Z;/V>X[9G9Rdb^O
N)F8\@?@d/V-F\fP7DCHZ#CUAWeHgdFT18XG060)#Ef--0eH;@\_BU^EcUT5,8SP
_J\1<Ud-4P<]ORAWDIK+ELHYfbEYRXUVf->)KPJR#O6T>X>g+YWOVMU#4R,;fBW,
SG;?Q>MER2#95(SP>10\4QHJN;T8<]3#=EM?7g[;_2IbEG?GPeBO4)Fg34f39O7=
@D-5\ba,V.0,#^O-ND)_)L7fMHT,&U=<3XMC&Yf6/L]EG>1;P#O4dfV44#J[FJ=C
Y>6FK^T+=5<&4:0^(TW]^aRe5IQ7Y[;:=1+N=T\XVQfI5]^a^N_W:YgU,1FVM1OJ
6de.;Y+.>&R(<Zdd0>Y?O:.&96-T^WVXNFAgF.AK/DL\.T.7b]LcSTf:C&(3>&cP
FG1GI85Le<V6FBCf1Q9N.1FQE4H@KVfFC8e\6I1JeEF+TT>Ag_5TUSCQ8>ETTTAO
5c@@1TLb7:C(RXMTR()EX1g?aSJ.=WaNP]05[-2GVJg0QB3ZbA>V]A#G1J[@]P?#
6(NZLWKdGg)7NJH#7eBY.2S3[a)1JZ_;)>b^Nd>9:OID.PIQI0:_X0?GcMeP)[BG
S:T3C534?K@C+0?Td)\,48Va.6=XQ:;,<(;4VEC>=NSd(F#2F3O;?,ac9YW1g3D/
N4SL(PO.W:HJ72#17[6S3WE&AJZRZ/L4f)IV4-XLD\#9</1R)FUTeCWP@[,WW>J5
2fUDgQd)JJ7f:IYN+=,R;P<a,D-7+PW+D(7VJVcRJCg7PeXgBN[RGPb#NJ[IZG)L
Q7Q/b:T?OXS;=ZLGR[eb:1Q+TH-b&a#/LeIBM/JRbR[HbJ)=Z-&RD<_(],c8))UV
M\?_WH7>0,@)aca?E:4E6MGbFA@RBXOGLW66b&UX/IC9(eX+HXW7R@b/eGNDB^aC
\,+A,UgQQYL)=P>L.Nf6Ibf8@Mg(2/aARY;J,_CWDRP31:UEGbdQ-F;bH+g;8?]:
N/cbK1Y#JM,?1)Gd-Xg;=MYe9MI7afZE[AKF:0eAZU0+W_=AP]SW/^M2Z#ePdddJ
,KG.714FF1LgGNdI@W0W181OLJ)I[.-eWV7E]8E58QXE:,OVf3LA/&G7gSQKDK(R
?eg\OS#d[;V#PMZNO&3]H/Z-VT(c\^fbM=(\50SO&[^^\RH&e0Y[S.;-)GW>U>9c
d3OBg>LeAU/cTH4(]D=8fPdbV<;(ICAQ^,\]P<DP]XL]]R]YNfS+eG#VCQL_Ze0+
#[Y21[GO,g=UD)3,^]?[QJ.UP0V7PPYK1^Z+See,LBf+933a.M=eQ44Y9PQ<@M<W
gLIZ#.aKZF=_@Y3[Z(D4RI:f?>1&Qg0+C1FF49^]Y3TLCf.cIW\g2;[))U,A/PGO
SK?J3)^2+e<J5NEX4I8WC2T#JdSe2=BT;M:SfG^\NR,APLg4DB[3Q#)AD1Y:@TYJ
),#.[f)\T.9&,1.QQY<MP7]C.\,5XR=Q;Q[DHYX.^Q+8N+\9I52G8QZa:LC#Q4^]
8+(f3GN=MGd/Y[MOZ?RVO2?bT(G9P:D/)Z]7U5dZQ9?BXK_1@\BJC-AEI&1]F9NC
dI+=^]F2NaB@f@Y;C\>).3S1R4Z16,4FWcg<[<<IHP2R9.L(8:IEU?/=M9S\G2FU
N>Q9^^CeLG8(<T/WP6)?<HVc,^4POA8>Y1ZdAH=RBg6eVL[K0:(9^._DTU35J9;/
Uc>@FV(ZLa1Ae.eb5+aQ\5S5MDe\>d4_CQ_#6f;7-HC]-WgSMQITfO[4d)E):BIT
_WCdPagD;[(+X(/HT7OW4)AdS6/SA[MR^F-KPDC?9B3Z6NG.)0Reb5C:?M/5#eS,
>/R9<@\YA(b_P#Z2[637VDU\_#4adZ&gAQT\Qaf^[G:WePPWYc5QX)fcML(^IEP;
J&K_7MQ0S3R@DV@b1Z+0I<=6A::U+,YFD9-MgM\,U\)2)a)D9,UEJCSfVPH33=40
JJVCP0?YF/V<:4IQMWQQK4IR/THMa40KE&4D4CcHXLUUU\V1XN(HY^6J]BJ.J7>:
]a0F,.I,?1+54b1F[/RNBFHGa5S97Y\R=b.YJ97TI[&0NVP/[O[.8IL@D56bS385
?(DL@^HWHY^g<2+][R\M5/VHOcDPYWS(:d]^.6@Uc;EdHT]?<+fE._N7_C;T&0W5
RZI1[d;?DaI)3:Mf:fGPJL<K-,=LCO#@\#&D[)K\;&8W7>ZRXLaW:gEODaEPT0d8
DNF60B@K5J;(P+bY@C8+S8aP\U?Hb1:1#Q&S?/;gQW?6RC7cLf0HgfUV1(STCT)7
DC<LZ;-5fLJ:G(9]5(^/0P_<<.3G1<K66WKUQF&,1QU9=bZde[1T44\^0./R,#V1
QAX96Q/@#N?-L-Y=K1+,\eY3bgK5&B?2A^.[a?^BeaQ-D.-\5=(S)d&WX6&7M/\-
TDEe1YVH3UG03gHUU\[0W.N5[?FC/24Q_ce&W0ONB9@#C=1+9GF6K=+1.f_cK]^g
REHKBINZX@+.;=><@#TaPWLK]5ZCHa/4Q3:T,)8TSUA]2fO<d?a;<IQE2DK[H(BT
/gV:6UQ,Q;JOaIbEcZ,NLK:AQWN_bedG0IZYG^<#2D1+K-#gH\9-(>2;Y1<Q2)_A
S4?PS46b&H@DCIa#7H,W,,fB0;A77GI,81eZ?JF#])=)GD6B5g)UVaf<+I\W<K5:
0NK>Y1a/O472EQ[eV1]M&@FBUJDXgT4N(^I2cX6e7b;1@[-\B<X<g5BA(V3PIGg;
Sc3AWLZC(\?T4B-^H_-MR-4D\D?[a+C6=fP80\F/g(-&#NH6B@3aWO^g?(7\)-5e
T.AbPO)U&G/<g=:YHB&:-QTYTY0Ga:&SCKBSTQGRACWG@,B739aMS=;.PTHbcKb#
O(6_dZUg/-ALZJSdIM2;2LX]SZ@KO/]BA5RSfg75O#J+-4H/1)XXB0=d(cG_\I@,
5O-A==G1D69P51^e5;_GFKTS3=fRU#U0#Sf5M(,9QP9OB@6D)GL4OWI(Zc#0b7,E
0\a+\5H,4(-0^.W2=+DDe(cGN9QOgGg#f3Q8EK=[IJGA.V49:D0FC0NR9D@6OY48
J\?e@=HgCZOD8Y=//CdS(d-<X79\:T:a@-/B=TP3A;LYW2<-A#W]P&CcHYGBB.Wg
+]I(<^2)Z=UdKDag/A\V[UZN(g]4I.U/F:da/WYQT=+>,4C]</ZcW)=H_K;ZTVQ4
0LePD,N_dCSMHD?NMQGd8_E687BL:MQ+-<Z?27;:Nc;G8dG(OeP:<H[EaWKO^B,6
&He)N3bEgV6[/2.g<7b>gXE35F&SYFLEH^@BTI[6^5fI(0DJc(JT8[\2g<[_V0#/
Y9D4Y;L1AZb_D9Z=g<e<<84ZNcWAS5\&20gf\[9L^C+2V&KGcRg1PU9V0g<<YZaE
@RJZ/eN&:+.9NZLO0XJeJYR\_R[M^4SX_:,SD)V(BFa);,6@eRIIBbJK44JQ6KW-
W_[_@H>2WMCH9V<3((Ubg#^>Cf9E.VN.X]eB0Dc&E4COY=SfDR>NRS1/b9I>DE=>
Y5:@c>eHOOO(X,W(RI<YQF-eR?\BAc,<\d#V_1/c-)<0ZO3DSP@V@X^d=-KOZe@G
JQFVD\)</ESgD[cLN8d>8Q12_2SO:b3Za0BLX5AJM[:c+K46S2[JV.eUNKQ4@,K3
;XG/Q[MJ#,GdT]KAM4/8L+^F?\J4/-2/,PY&OD80]CWFaS,Y^>6LG+4(/P2,1T.L
#[&PU:BJA>Le&C;A=;_d\NV,^SQ.YLWN[O[b/\5L^@G#e3B/<6?I&eYAL?H>7bPe
gDYa1[W9[)-B1gI)AX,X0FCW&]TWH]6VM7(96&8KVI,5QN1V<970ONHGLOa\NTF:
/50,5>?S]bbUfQK:R7J+-8KbMEI#FLLD05bK/#;8=X(;AGY(4N.;Z?Fe6-S/[BV?
W^ME?,b1LA8G=_4eL6?fFMNaUaBWePfRE^bYeDeK,#,7/QZb=>TE-:POI:ZEA^^+
e>3BR>>Q+F#F<8;b=T6.gI85^9OI5G^Pe<Q3dP/U.Y2W6Z39A@:>8MHHQ(P//Mf;
@O71UI]_C45JNZ4>Q2<N/NKFcVF\?@EFAVeEUH3RNU8=K_V#[>=,B^-VZ]S4b0b[
(B-X4/B[?0+JbefD,MGHUFT0@HU7,6N?B\_g0SW:I+aa#GWJP>cI]GP.eI4VH(RN
QIM_I=)=J&J3H+b^HEM1Q#aOPIL;6G6Ic6NB20S3O5;,_Z.Y3I<9(TFB;:VK40Mf
N@Ac@X=M)08ScaB)9f0/I:6ROf0Z?67IRD^d7gfPWOd33J[TI\<&-MC,\a2VE;W&
)dc-L9f)J-O5>[QCBKQ]f+9@]79^=J@Vf_)37\L28A7S:_#d8IQZ6Q\:D^=,Q;FU
>L?^5McW9/<0fc43g7\7L>0G:V12f:^,a-7XLI@:T29C3ZP8Aa,066d\\WE+;-;P
.JTS:>Ae2J[KT/e2M;5P54-)&ILV+.X2aQV:9(UT,#dKU?QLE,SC.&FOdZ@Kd[U7
ZP6YB7_9]B_#dDf_-.R>DWXSTDB/+YB56+CMW;;+Q+f^KOJHg(IHbDA3Cf\D<eG/
B-9ZGJPIf>_6ESA8@>G1DZBK<PMf18d1>,FP?:dfFa#//9&a5d-C98HKd5QTC,P:
8#YIb=7X=R6BVP))DWI:O3I&BJC.5OH&V>O&P/&\Wg<WI1a0b]9[K;/NbM2H_]NK
07f\JYTdL3RP0=EUTT\)Q;&Od;VYVBOH>4(g+VD&==DD(ILag2:6cE2GVE1K_;I9
b0+Rc+>P#Mb&:-@B10/e=J0(\@LX^/fW1/YX/WER,@<\4JZ>Qa1S(2F0Zd&N-:MU
P]IE7YLM@V^N<[/.?HAD._[)G3;E)#_4D4J#e5a[9]5[V-W@T7=+&_C>;78/c>N\
RK3>dH(0+I+VK[,?3DQK42D\)/-]:]<ALMUG>E[XQF)&N?dSCBEg\WN]^U3^G6YW
?I?DNOI.5_7HNcOd-(=VRg(4?_GS:U]eX#JKbR>d?NT6\B\E8I(YfFFUF5GW4-^Z
a/JF.,ECV>X3^b+bWM.f^@@^#LZ0dbBE?V;J57YAJI5SMUFXE=)U6QSe#KNNXeFG
B0?:;BL+(2JZ@H>Y<.Lb(Y</)1CC3@W;H&P\.])e80M??0DUL[6Q4>>C?E1IHE6O
03JMDa#M7@e2L@>9C:F,8K7#bHSL3BRYL1MO9dTFD+Gd80Q=G[,NdZ/N#1,>)55_
6[(e1.3.DBaXFZ[;1[3Raa+W[40F,0,HQ&,114]^UIM#I(D//d+H8/1CPB;2_U;2
\9OFB:LJ:Hg^-E(Kd>B=g5[/2VH<K>L8f=b>e;RQ/gY<E=<d)[#J_FJD&];81(T#
M_X&YCX/I-S6ITM]XCg_HQ>;.3aCPB2b])M73NWa8+=BONNXLG+O4/9fVN:IN2AZ
UPQP];O(AKT/]-2c4K0(#X3(/YWF(EE0X.-S3FVL_@cN<?NVfH1[5U;QdR<9)>;S
ELX78\:YIL7/IB(a?QI/POH8K=8g,d9ZXN[0#@0J/?=HUK=,cGCI:IdW/:6MQ.dg
-<=RIA1SP74a2CIE6S=R0[2T0c1DfEOV[I(,7f1]L4I6a2c_bfg4QfB=I_bcH->?
g]VE#E<Ra.+WaC7=:JT([Vd/YJ2YXW.TN-9CUM&Y?P3RJ0M/#SP.J9:\.>Xg/fTe
^,Jg=&b8NXLOYX;2B+dO:#/Q,?/@PB+a7LfPU><+U-S>O5@#G:F.a33G.cdaN;;.
ZD;g;L/00Y.R8BOfR#,@g^#@,--9b8adM>Z?:eJGYYOB/DSDI1BG4<2D)>M.KA@5
M_XJGNIM>@\#C.gKaRF?#Q[D5]D1V3=^DG@M/R9Q/a7d7+?L[>VMQN)?-=,1RTF1
Q,>)9MSSRNT7\^DI03M)C=)&#;.6G3+Ab5TF,OH.9e9L17SF,ZX.7J@IdG(gf@UG
U[,99&.WQ+f+/SM2^E=\Wbaf+&BEPBT>R-dL>Pf2QP&IP^7;.Y.481]7Z[29RD-\
V3ZRJ-Y:8G)+Y(6I6;I,SQbSPZ0ZMc?_=\#;\?LS@((Og(@ZJ:+9gQbQMbSQU?1I
<JT]M_D/cc)..8/9>d[\9(@0[R\KIAgQN:,1=2L82#)cGU^>W/eGOBG_A/[BBa]?
8SMefY&ZIEZd)AKO_S7L01IT)F-fY+;NTLSgI18Y))N2eN_1I&<INAS@:B,/aO_J
Z)b=O@Dd]J#-gN]Y?F;X/,)V:.8SD;0&(-:FK(>+N+G+2)N842-]gEP_KJ.85RUY
d;I+0L#0gC19cH-c4>PQZBKVIN3<?c_ZBfUWI2Le:I57gVUQ]2.4L.cPLWA-+F9V
[=E@L5)WB2I1?+C:#N9[^,=S0c4TA4\=aOOZ8H)\4Y+_R#_J=_b>BOPcf)f]CY\9
eH#:7fS1:g:>8,=@-d-]J7^4@_K<ZeF>c0[d.@XM(PU]GS+Fg42+/7VQ[YWgQ&e-
JFS&8Ad\+:IERLVBJZQa&B4fIU62#9,cU^1.>XdA,#5UOKDX-Ac?TQ&T/cH]=+Lg
_](XI:)RK=dMQMQA@-a\UI#aX(E((M#=fffBO:YI84(:F04]83CX2cX&.6[d8b,+
]a,M/>9>4Y_Y??E@YT5[FgOU#?J>[T+Q2Y/AURW+7Qe?1B_BAXd6^IHT,ILLbZV9
E5;V&eO9OK5g<27gMI])(OW;cK67[IO[()TLAS:6TS.NbM49J)CBaVeU-UNZRRX4
MO7,O:d,d6,LFb@dd_QT+KXV&A9X^L99AOW/PPB#1G[a>[1=gFdd<EaS4VdGCP]2
^e@&4D4XW,d+S<^WX\\eDG/D?YK\D0L3B_RY0bab^#:#.KCP/bQO]^fH9&9U74\\
-(W&AU7O)78S\AG6U:f)dN]@6fJe=N+]]TV##>VQ15/MY.R]9.EUgf@.C43>G-1#
GK0:VUHUY=;)1Z^O<1Kd>25W&D^Ec933+cG3R<cg;ERa=.,?:@gfLaTgVP)8.[8G
GQc4,\R(e;K&+feJ,;gW^AU?.2gQa\RD^><)P1VZGA;0[UDd9AO]JIQYMSH31JO1
PBC\baKFACTM&29\aSXIS]G;C/1PXff8C_P76aOG&YcGGWb>IfRcXPYa[1A[Dc;(
)]b+e0dGJ)U##(2EAQSg@VaV]GF(V@9J=UMc?U[8BM;bd/&Ad>,>;.KY:&?R+0A#
e]Bc67fSJa\_#1O+#;IV?ZA_Z/.UfE+.aEfYQYOSDe(K2D6<&O-d&A3VG&(BD8+b
VaNC=gCL#7A-G/LW<ZcUVTG@^0\ddcBFfcc#-E_=0H#\3g2aN=;(#DS&)0[4HF_:
\#PL?;<&(G:4<YPX6\+CX:#T05XE#F/AO58#5ZL.#KCX@.>2GO\7APKQZCN&,B:4
a?)1PbZBUX;@D/R.057RLHe(TZdFDV]TA(EV)SSW_\GNM53V>a=G8\dG4.#G>8dK
DX?YV0O1:a9<_T]#=+YEV<.J(H[6U^:MU04c;,CF+EYSc+WR17f3XT;Pg0LIMRJV
Re:-,+M&d3RS;&:@T-W5.\DfQ.bd+VF6?SbAO,+4W#]8#VY(0T/F@[9^T(VZJ:18
#KWW5G3>+C.>17QCUH0:(C1Se+@(AQ^,KEcF_Ha-KUI\GX>ea8#gO5P,#P8W=][3
B_F[CeF5R#:+SbBV/-@EIKd:KU<77B+,);I0;W#K<\(/f(>A)IS;+09KZ^(@/XEI
QW0L0BR@@,[\e_ddS5&HQ1P:a;=/#FUS#K\e^4P-bUG3<Y?)7]cAY&F9DT/2]<&_
e>G58C7\ZEH]4+b1W:0YKKB6R/G>)U,:(U)F=>f-CN,:YES5Q0W_dM>1RgQ?,Xd[
2Y]5fF5bYL/eWM1;+b&P+I^TeU(/W?;Yd[WD]US32#,3[MSK96#F]O[.<4[cd6g5
GZ6g;4SHY#X#76adQ>#a]fgT_84#MGEI6Tb-gOHW>B99\5_+L5XFUYMED_VV+N)D
dW=DV>XMf@Ia(6RBK:=ES.8#FEfOISBQVcU(=E.:)G)J_/UZ]MN28QMSPS)6aA][
ZYec@>^:@-:(,#2I=ZW@(Z]WSR:,HZT?,Y&^SNS@)-b:U#+:J?g<\I;FP.(BS4aF
GCS8=E?e#cSHJ0J7HR&1JH=KN)(.P=BH7\V>LE6+TMJN[WYc^g.+:M5,gJc[DP77
W(d.4TC1W6^N-1QGEc26#Zd441f>F5\5+=LUR?:O6F9^.C\Y\gf@V[>[]YV=a[cQ
E>\2W/,J/6\7X?\_/7M3:3(\U[PCLZF3=Og0\8NEVBR9)N95W[@<6Bdc3d8]WQ?@
&F1eKD@IP)D->?(DZ-7A9LE+(P1AE0OAKTH#&&0/@2c#LB[R>NL[6Qb=@42)0#>5
T,W1XQ/_=Cb;N7LSbUL[&QL>9@#Xc9XeDTE/d@ZUFN6+7KIWK<VN27D4dX&8Jd0O
gIRUJMfQO<,PAa(Y3PF53XTYN?R>SfW&QQgT70B9cFW;8(;6AEAZdF-1)]68U7ef
DBQ70SP1PM\CdWST/DC3TX/=Dc[E#a9[G/G.[@A0DWAM/S-61cW4K[)M]1+dbMXg
G\Y5Z8(<J.,DGeG87aT2?b38>bf+..a/)Q/8\+HMV;,_7.W1NQD85(AdRKJ9=-F<
1UVV;PMO1><U></S@M^K>U9dSF(J,SbINW;F98B3O,X7(9)&>M:YACD<_C8f2NId
+28f.fY3#1[cH+Z7)YDU:SZ:GN.;5\-B3;Q@dLB4V4H&H9&6a1]G.GWAa@J4SJ)Z
),\I--]cg;dV4UFc8<L&J;.3d:>g8c;+bG53AM]3@=RH?RDa80AZb>=M3#Z1NRMY
U4U1+[A+Jg&Y=^.AfML1OPUUK-[7KF9U7TL0^-N1-RdKU\a/LSGa:gZTQB=(0^AT
@SgE5ZX>6W&A?5)QV3eEQ[]I&.G8<Sd>c2fLAH<Y7)fWH:/3,C&(^A\\Y5_R?;He
.S>gD99-2CO&,BQRZ9H=3<06ZL-\JgcQHN;U>+D-c;/56eLA>ZWGR5C@>[_T:e+e
HD#0PA?Q5+6XX=&?:RO;]K(,+=R+.+9,BcHe;+M>=_.U4&fQN-Ud/:>g]5_WM8cU
<gZW\8WfO&NDd_61?O8<7J0X:Eg^03DGYRQR2UgdcgEgJ[^+^/^JNa/3a7Fd2^AP
=+CdIH&9N^MI#]M<=O[A[I@R,#KB#d<^EPWSH79MNH<CS_eKMU^3e@2B:HR7Og+I
W?7AU]HO;UZK7?).dd;CV=/W<\6Q7..#4>GJQJ+5YY,[1^:b/:RNU>RCR6Og,C:H
EY.\>[aD<+N)D2XNTP6:^.^9)A1?CQD7<9YG(J-,Y#Tf@3WeO4bG85[.PK1)AC-/
.#VMHefFZTVQ;M8]Be:)D^]ZMXg386b?e7;e5C7U705c9BMZB1H10Z\=[]\HZ<7\
VgT83M>W:^<&<PG29g_]B8I-UAQI8(#W&H@=>Y;WI#Z+2RT]Z+BMQ(A#:\\OM?6L
3W(B.aeeWc^.9=I0\U=#eNFT2a)VEKN5O[36e6ZEa-Z?O#c2cXbEe,BX\1B67^1M
]E;N6M2PE3eV)B=5ER5IVUa>NHXRG#U70:Cb,0FQ2#LgP]9cID4e\XdF:(?UDP0I
PEZ<@9@QH540R;>9/&?1;9J^9b#(aY:I:OB07[\JD<V)_L_?F0,[3c:XS8/e>-.f
VX3DTPFOP^7(Z,J.^?YZO>>K-&A;7_879>.UEI56H\2/e1P.VU+>L]I-/B/N55^\
KMeL<CJ26)Z\-I9[(7aT-fCC-GJ9V#3U.WM)3U,B,O/ZG],0:@]65JgZBge&=>fQ
?f/8]AX:F0fH?e&.8[4e6O+CA>7bD?WQ18dMVF4aR7P<M4DNHa5e.P:8-ZMG)\&4
?UF56[Z[FF4+gT+KJT02]E8YJNEN^ee;]-AI;8NO5=EeG4a(5VKH:/dU0./M7A7T
24U9(GC,415HV?:7Q/b#IbG>XV]b2PKEO.=R#I8gG351/P)-Y-T#/F7FO2^(1b+_
5S^3[3WPV7/#fX<&H#IQ];J)?cdD-c=Lb^+6=AC^X<bDQ8OH]S&W^49.(HUQd=1H
5L=b<_C,8QA66]/HX#Y(^+YD]8?).AU@70\QReABFG@FVO3UC+8PTF64Rff_EYPc
BHUN:GVb26+QfY\FFC]N#Y<cfa-NU;E9f98/ZcDPfS++fT]EZDGN3f&cgZ.L^J@/
LTK\Z\g.3.<Ef<KJI6X<A+[XeH0KdF6g)9)X,10=DNDL1Y=PKBH8AYR=?1EP0:5a
3_.SfR.8dS4DA])>c/WO1b4+]f?^&3bbN8^.e])ICTLU8<Q,Y#O=2FA:@RPK@+RT
F)ML.dJVHF12bO=F&ITO_FRGM/\_fbe&fbSJ#+H(Sa,RW36_E1N&]-]T1)Hc0RO;
DS@]M9G>J:7d^;8P[E44,00(-NPXfNFWO:S<F>;HZ9S.CDT/d1g(AD<\=<=X&T+a
Y3Bb:E@A2QPeeg\,3_:YFV:;=.?@fAU?gY-R>PQa>DR89dXAN(J>-\P4Vc>GdM=:
3:+W&GaXIL65X10=N&NJf(=<9<?;bRP29]GQ_S;+:T2UGOfML(f)Y@INKEP4YY[R
^d0P,A/@(6GUR(La&b5fDG6b4=L]f(e362IM2/\HZ5DB_T;L\R;_,T6MX@CWLZ[4
a4]1YZ]_?+V&[I3Z-E@feM^+E2Bc@.OR+R5QR6fO_^M^<a,A-ZVE999bV7?XM4KB
;[:<3YVc.SV4T4,::Q]+TaOaXH^BgCbGR6R=/_BGC\R4.G<W6Y7H<Yc@0O]+/9PX
0ENJEbA(O)SVgeE?5<=db^;[BOG9a(eO4a@-MNXf;VI81gI@@OgI)15K50DPSKJ5
L>-PUfN+WHEFC<<T@3ZT?<C.C&5Ka8M)gQWU[^d+PeeN18#O/9^_^1PA0PaCgCGb
-XZ9=O8-cW3M)\#,fI514<U1>@M3N<PZg[.LRN/WE4/B6_e[#_?T2[b[-f-;OP;P
U=WWW)&9Q,VW8)I3Q,98YbTe)84FI(3UfdW]gdKe_4M>8(:d?MaA<871GQFM4/;\
gQCM]Z5X5<4@1XH.b.:(MQ.IKRd>T7<=-H[?1C;7BL&>9H?O2We^(VS@-eIL;&:<
Wg(g:Ndb9USeZ_\g83dO#:CfV+CKGe)6,-_G?DPLJB&Z8#NKM_L1L)P+C?/A4<?_
QHZC[W69g?DG++79QdUJ+:L&E-V7<UcSI@LCF;gfa:gUTaLI/I;)L+-@gS4/f84@
I7^&/d9?)_XcK^U89=2#]K5BaSU9f/WQVf3_@?(5YId/aF@A4PQb<Lb-0L_-[#8_
M,V)X[caAAU@75cW,g,#M?P.0E=[>,P,a+ZW6AN2bI^=8<Va:dJZc<TZ<F4C[&:c
].,-C^9-W\&LQ4e\62?W5XBdYOTV_P9OH34B@X9f0P\CS6CgJU-dQZ2cJD?_g,R6
17g?NdTE,F9Y@OI7\;K]I?AB:f&5b>E?F\SN;.4&A>US=?7=#25d9^43#WO?<Q,g
;M[4OK0(OQ_Uff4C4/56H_K[T[393EIKM)8<ZSGa3UbP_0dU.8dU9((,5V9C/e8-
;3QTSPUL5\URIJF\?;+COILW^_HH+Fb\B-C@>E]R)03bN87N_>E2FYcV@CV,UW/;
UR:=\M)5gDX8MZBb8JZc3NM9EN5O@ZJ2aYKXLBYGS5FB(&I_3)TP[f=/J2gW(O(@
?MTCSZ&BWFUePJ#KPd>:@<?VMEMSN:).2C#0&<>A50M.64D]BR\c9f,6>E]e2eLB
M=Gc:O@gX[&JP4R/,S]@_JQ<,?]UXE&5cFMQX<:3_/aVSO1:&;3)BLQ:\KA@2,+Q
B^K=fSFZ9+.9fNfa<;aBP6M3273)Tf[55=eLA(:+AMIVQ/Kd2;\\QV.9g/V5S#M-
g7=/dedb+:CQ6=G^c;L2=,RgT;2@)WZ?R48=<V)\]#fIFAb0.P>dH;:C&[AVQ1_S
]0^;.PJ/KB3=BZB4M3c:#e&GK.eMIdT8P&V3DP;=ZTD?K?e3@NdSd6PB3d_1GG_B
HMYE&Z>6/T\:9]O]VeMLEXULIWTcAgaTB,W30-<VR4H+,:_ZHD?QL29T8b2QeC>a
C+cX&NXe.?Z#HZI:;)S1fS/dH@0XWE&YbN42aY5eR^<69_6:MWQ<@dY)TXQF4Bdf
XXGA4;+[/\L5HEFOJfQ_M]\+TIP4gJ]&5Ff;:S0T\e?KE1EQ<ZV2g-J6_CB1P&^)
3VJ/_b01MTMQ4BFVfC/=;N9RN:eQ@8DRaOONd0@0GES\7;5G;V_:,_A+HDU\R>;^
db+?19+ZP4a9LU=,MfC-FV7BaQ53QPBaN8)0)A/5<W)J97L3c_0,-2HPgNRZ8-O6
(F(K^GK<#T#HBVg)[E;C54XD@N)W#9F0>_2,M-MWWdaL_[fH1/B0WI+N8PT7<Abc
d>Q)#<:Y6eI4AMXZ?TA>TF#Lc-B#f]/g[03F#CC)+6/7&R3;B/2VB9?+BYP>F4)K
-67NT6_)9?O[d.W+G1X.3A?KQ6\a/0,b,?VeY8c&fGUB&=4-04,&+UTKc5ef8NZ8
d6Z-1:8:U3>[0$
`endprotected

  
//----------------------------------------------------------------------------
task svt_uart_monitor::wait_for_clk_posedge(int count=0);
`protected
23Fd\<?f7L+<d6\)dIKV:QdI4?8ORW,5DF__[PW1J;71\aWJ1YRX2);JVZ\.gGD)
)7H98_KeAgCbY#,(=PVS.(eX,FLg6N74C9##L(/ESWGd\\4065&0=L83ZUEG6/L=
CQMY35D;55Rb*$
`endprotected

endtask


`endif // GUARD_SVT_UART_MONITOR_UVM_SV

