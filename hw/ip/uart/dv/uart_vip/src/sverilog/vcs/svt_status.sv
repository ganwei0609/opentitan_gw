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

`ifndef GUARD_SVT_STATUS_SV
`define GUARD_SVT_STATUS_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_data_util)

/**
 * This base macro can be used to configure a basic notify, as supported by
 * the underlying technology, avoiding redundant configuration of the notify. This macro
 * must be supplied with all pertinent info, including an indication of the
 * notify type.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

/**
 * This macro can be used to configure a basic notify, as supported by
 * vmm_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
`ifdef SVT_MULTI_SIM_LOCAL_STATIC_VARIABLE_WITH_INITIALIZER_REQUIRES_STATIC_KEYWORD \
    svt_notify typed_notify ; \
    typed_notify = stateclass.get_notify(); \
`else  \
    svt_notify typed_notify = stateclass.get_notify(); \
`endif \
    stateclass.notifyname = typed_notify.configure_named_notify(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname), , notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)

//svt_vcs_lic_vip_protect
`protected
FPf-<T0I+=1.J9)XfA,W6Hc6L+KL5XX&O<MD-J0^1-?SCD,Oc-DK,(1DY#KHUO)C
5EgW7+26H\TUR9_VWYR+8@/V2ZJP5A&[PV,803f\gRYJEL6M8>M^_O(9W@@;#,;E
[)cC8+c=-[^W8S\F?/g@c.A<BG.5/_@\E;O?UG)<FcCaAH:AQPR/I58(62OJVRGL
N=Y\W93QD3Q5BcFB[GdcEaMg6Q=adegD,?gZ1;OSe1Y41&1NSG0YA+G^16VU>728
@>273;gJ731KI_b.bQ[T2-]Rf,].CdJ76&1Z^.S(NL7@?:eIG&?f)QDd=O,e4d(_
NQ&7+0:32e#aSXV)HJ;D3DX(2H+VgAB4I<MB9^EF)ZME??]c:1=+PTc8e9,5eaR:
NS\>>He8(P3LW)\\):6V5H,;@F-5BDSbE4S+>f<[9DfH@Z04#MO<C5aG>@fV+QF/
&JP6X;AE[1OK:E12@4MQ?LR1NPNR2@+N)-b2RBQ<_=MMcZ?MQD1)X+[ZWXc#QI,N
gUX@SF_,MdEbLfZ-N]_-OYYOZG5^ed>df[X]e\=^+HeR6[HT=WHNcHNd?GPBKX>c
daBgDVN<=ARI;_Z>LSe>S^=J-;<2ZP(V+gN?/M+#I@:HOHE?4[;ZLUg[e&-70&NC
A<cQPX)).efQV:dN[S_:Z_:4;O^4S9>\))5>T766JTR0-5_J_(6@/T=N@2eQE,@@
Y]\bRON+5c/6LY1]>/Hec4SXL0?;+.SF4X/:b?FR_;^<6<V<RC]0\S<=V/3HAXUa
G[2PAJC2R#M=fe+1-@bdgWR+d=PA2/&1Z?[_>UgWg/4YR.F8Rc:V0KX:THU0\]E/
IKR/P[/gA>J5\<HcVVR<5Z[0e#-58:MS-cR:V<.LR@KR=HZZ\P2U:3C0RW?5@:<4
(E5@K(I_>9A3_<Z65)Gd5K8VVd6P=^<\<]:SJP^ca;EEVC;R6?3If4JA#-ZeF6ca
PFA6c#VQD.=DJ9ZL#JJKZB)WUg&XH]S)EKeUX@J/1#f&.^@/1[BZ4LBC0W-_VcRY
7)g1dW#+?Z&4bCB#1)+a]bbT08#I@[;WQI5gZ?Q;ec=+4SK@X[6+_C#QG5V^1,.I
-O+.&D+d3BJ;K7+]e4HG:>]P;Y]40)eB(UgRX-=87407&6<JCcYWC8Fa=G)5_US4
7K[V@=R^M.?HYOGW8I\B1?cRMGea]JI4][W?,^YOc^D8+6Eg202?O@(R7Y;[9RE#
S&2#d+Q-J+E@\)/f_Rf-2A2?<4&J+FGLT#JHEbg6GR.U-0;bdUAgWCdYIVVEE2]N
.I9R<L?UI]T3HOW@bW[>Z7[f-)3F3eY@0?O,6U/ESDCGMZXO]bUa=5[#W5?M0\d=
_(f@R=TWa+\NM^D)AbfeEAaR?Jf[JUVA@&NFJI8^(9-WCf51[L?\N>g5#K5XA#=4
^b34(3548b9\P5[HdYQ,4LPO/]-MS(5ca&P6XaV37_U4^9aTE)#aKf=>:(YVVGOP
@8HD7af\c-RWEBfQILP0U;>==^&6LgY;ERTbQ.g8(QZ&_L]OH#4=)+g+:+BOSY2/
aK5.D[^Q?A?.O<S/2W7K=eYcSF=[b.?f6;>OT2IY^Y1]8/MS>1^F\>GD6a&fC.R9
-)3(F]O@8e0JCAE-,@<#N\@Y#e;D=V)J/;HbYcATCHE2b-3#e;Y-gI#?5[.\LQ?/
_S\5E:aV?@/OW6M1G49>ZT/VTF0+AXfZD^VLg(<=O&^1YZW>8PZ.\K0P;.cR5C@V
ADX3I(JC,0P-4(7)b0M7TWIEURQINMAU-1De+<2#\)JTP1b+RV9#B+EZL,3>b@Af
(P?Jbg>AN_U]+T@dGH8d\P/KFTDIea#2:-67#D+>\&@f]F(>\G&:Q[=LT4RHN34I
D?Z-(0[F6gf/gV>8?AKfa)&DI?9BK[[E,4Kf:X,Q1/W3:f?6B(Z[3H?3+QfC4::B
;G,QF)J,e>4CPJ[_SdGPY=[<PA2HWa[H9NMGH)VJ]fEc-U[e:.]d</YaNeg>1N:0
QNMG[)9JX6g4G5)AJ6G76INQ+4&ZRPC\UQP.b(;)0]G_?aE9R^C2OgaGB_X(ZaR5
W6LK&[9V7#YOM:6+4N/2eY+g5gCOQY=I4/]8],[:A8^e)EVeJ7dPO]-KCBJM:5/f
WY#:a]Y0>/Pg5g+a_QP?^NWIR+T/e>;FDf?/M;.)Q45<f0TVA>60Ob5c8SB0@?GY
7D@c[M4E]&(b/<6SWMYZ.^#MgUZb:cRQL2V#M)0)VY[@.SDB[N&U2>#K@M-_9Q[&
DP&S58>)1[ZVM21D^+AVcKCKY(_]0D3N3CN7U#;;3XSQfO;DWG,>U\TS+[N/b_S_
[TZdOJ&N:dbVcg?YFY4Y=9L)PK_)<2b>9]9age>4U>19(BCGC&P79\T1AXZO;7ZE
,([4EX3&?#&UJ[#,>-<HWH4d2#WVU<fAHA-^]U;Y#B<HDXQ-)MGPM6J7ZN>PGOfK
7@+VJ=7_cN0G48]:a)gd-d=B?fJ0KGdNDNK)#\39)8PH=FK^4f/PJ;U]<G[&HU2U
B#eK--P:;<F^RQeDY+]N3R\J+7\;5:IKHYL\#Q\]H-8g6U@93fL=C:=e5<V,Mb&)
H8;AQP^5OO#J_N;9LWegJeV>Gf8P5CMVWNdfDAFK))EgDWS^G6ZZPE_[Z8aaMX-.
ILTIID[Z]c)D8\70+>WOM\.d2Afc(bfeKJ9I^aKc1gaIHgAJ,c7>E/(,DIGL0PKA
GYPc7]/PQZ_5=(M6;@6HHH_&&A6J^95f[9&3R7cgPF^8bY/X-TT#dC6fZ[&RX,VC
4..bE.a\8c&204EcRGDC0AebJPP<L#-(HSag:CE<aGa7_eDHP/PMR,Ge;<FW74RC
21QO\E+_;db-#c<5?U#3?+<#).0NcP4ZLT37^Gd-7[YRPHW(025M]^,6Ef/R^?LC
SgS-).]&P^SbE(-\#g)@M21WW?-9#Bb5(gV5cK?.3A>)VOK#/4_)[8A^9a/_C+N[
).b.B]R-67Q\Ud.L&O4A1]3(2Y;2I?O2J8JQ>DL9N+bQ0_f>#?)#:BN6,2D@[>1<
cRJ^->4^J385MM[?FY;NP4g5O0FNU?:/:d4,RWc2?)G_PF.Y&IccNATV?]/L6#IB
3\F8gZ1&BHD0-O1_gA39=?4@U8MZ[\TAM2dK_MMQK>N?VIM<&E;9?\16gW=#5TO3
OU1V\;H]-L;;dbN]]>@T/Y-XDZ6.6bQ2M96X\3[E2B:)caDAN&g=6K9O4.bad0]H
Q\XQA\06GYBc:+@4DDRfP0#A]_0]]Q6/LWQb]DQJ(c3VgI._UB-d9===808YRe)E
ZZ7C;+AA[2#_0S53f:B6;;BZ_gTV>e\U^CEI]9UJb1fBRCV.O6T#_Ee?0C(OU5/A
?&]Z[UK;0[P>4fS?b^PBfIYb3P&]L85\0T@017f\K^)O(UO;ZQcT9_69.H.D>G1e
TD.Z.XA3E0^REgA;JN_;?A][(JJ<1..eC?]>&I@\e95f:2YDNCMfKJD.Q6R\Od\G
)LI#e.;</)?NID#C)(OgT^XA_eK;IOfdc+C&?N]8K3fgET48THP@6]?SQNcYT(4O
@[L9;XI?g+A&4cC3H:Z(A2^-&LKH4-T<5^5=gg;&(U&BR]D>agK:11.W)GF]B4Kc
0_L]68^(2JD0[SJ3]2d16_LK6]TM0^&B>AO]N&+W?#,@Vf6JFe0ca^+6.IO;:.+O
QD2F?^f@K0,.6,4X4Y[Q+VGCgH><1RZ74dFG[)&M7,<1B;0.>T(\Q,YFIF0[8OE-
,ZeQZML#8OM2JBM(7>[[RFAZ(WL>?-;J/fM=EK>=^>V_EW0c-H,1daK8+&cc6J8R
S-/WS#fOR9>.T4+AJ0NJ)N:HS=>1Tg-+?NL&ZM)R&]cfIf<KFKFZ,,c[7&:)/Jb7
>=##;XbII<IY)>I[E^e(T&RHM-(aK.g4fJ/GAVDP+,?#FL;O3T11CEd\UD]X1P7a
;f^MROMT]6[AF;P.G<[T7B2JSPT4[P0E2#_9e:)aWZeac&]QVOb1A=Ig19b\O\g[
T67[([J&?DV48Be9d.]0J/K-32:I:+^WcHI5.bG55,Bb9A81#cM]))KOV_-D0E7N
=VS>[0PPF@DfC@28aSP6d,JS8T-YJ@8PIN;?@UP[beL-M?cRAc^2e[a89<d.OX7S
G,3eIIGTTJ2E#;NbDcD&,cU.U:3eBa+BSTH0.9N;,Y]TcMF4R,@IaEQf3D(d@RDN
D-e2HL@]I,7L,fM/,;#(VO,+R:1Cd&0[NQY1]Q4JW(0;>b9SITAI.4Z/PZ)Q_TWP
KDDP/U,6Ud</M:HL1:?1]3cagPU#A:EcfO+XcO+#fDZ/7PYI6g@_IY=]>7Xa=?IO
IB2bYdgM>V-,SN/XR^6YeU5D7A,F/;b8d^8G^>AXDD86bF3.?-.4WA#83IfRJW^W
C3JXH3:1GA/Fe,A>LSXG\O92gB0[BZOdFM01+O1@0^\VZK)Z65TdCaX.NG>c>F2)
K;>fF9XSaW4-C3L41&]+b8TCN/HC=,INP\dGa7cS6dASM;g416BOMDeQ>T8^]a^4
5DXSC^IUc-5g0Ub,5.X?bBTC6$
`endprotected


// =============================================================================
/**
 * Base class for all SVT model status data descriptor objects. As functionality
 * commonly needed for status of SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_status extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Used to report the Instance Name of a transactor to this
   * status object is for. The value is set by the transactor to match the 
   * Instance Name given the transactor by the transactor configuration object.
   * 
   */
  string inst = `SVT_UNSET_INST_NAME;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_status)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, in addition
   * to replacing the built-in vmm_notify with an extended svt_notify which
   * includes the same base features.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * status object belongs.
   */
  extern function new(vmm_log log = null, string suite_name = "");
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_status_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_status)
  `svt_data_member_end(svt_status)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Helper method to get a handle to the notify data member, cast to an object
   * of type svt_notify.
   */
  extern virtual function svt_notify get_notify();
`endif

  // ****************************************************************************
  // UVM/OVM/VMM Methods
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
2DABS9WR80];Y]QCZSUIP@V39JW+fd^44@WV9_?V;:DKd2E<Lg=53([<RQF)82_W
#0Q8IfP25dOaMT:VBf04@<5MR)B:Q;J@HLF5QZgQ)QR0Tg(JXD,cfCb^>Y=5b4#)
N7:VC^>Q/N0a8(-A2TY(eC[(;9a(D1&<3c25OdKPb6^ZI4RJ=[_N7Ga2DN^<G4<^
<_;e/V[c,]>]+eVTHO36>1\\=D6=b<-5\9N//0]Y=PP/Pe4\._LA7^_\6-_<Ze#E
e9B(:]):bTT]f64EDE.ObgbA/H5aF5FZNK\59^P=_W-Z8PH8<C,00>C)UP10#;;8
<H5(\g1MYH(@J(Z>]-KK)RdTRK=)fdLG486GNf77K1&bMN#=W1,/g[9@VQ]3;N[T
92[VE5BE=#T&ZE.=7NL/GO3DWINQ-D8KA^^F1_&:__76?LVAQXCKO,87A.F::#AN
dFN^+CZ.9F(e5BcPQ<^gRYPga##5N+@-8BIP[T^I.S19[M:4MY3AgJ?J^T);W=DZ
_7IBNa-68WS\P3BKQ5-,41I4IO&a)7B_-NZ@;NK2f90dO<PF^NHaZ>8_f=_\YeLH
^3Ce)W5e\W>S19[S-J3Xd>Z667>6<=<OZY]cN@Mg+eZFK>LJFDTA_MQM0b2daD2[
f6=@0T1Se+IY1XgbQa]2F:]YW+0W+J1:JF0@YRCaE/?,-<,KS@_9)e2UXM,RQ]Q5
#gY=b7Z?d^UGcd6GGFQ]YCQOJDC_\ZIc0;>U;5]I0Z3=cF[.3#]2DQ-(I?<39DL,
Zc6)3M10KB;^J.MWUDb_K^e.4-)?A-U.CH9#XO6e36a,EX1M0\Q>WB+g2VWQB;#;
I,6-VQN^,cN&^3DV8A2E7<-PC)Q.<P+HDZNX)#a=F_TTT3J]-g/0dB:ZJYAQf=5U
,5Y:.2C>5/QDg>T\4>,YEe0^9>D]\C=b[RFBMdJL@CdT^.gQDcFfS.ZGSBaA_N1X
cZ\T937FU[==[,P=Q<\.FTL/TQWCRa(R7^GIW)[2+(8J=VNg6J=M,C\OdQ9D?7O2
RB)[FTKMQZBOL(^,f[VfS5THFf+03a]OFdMV:;XE@^+7I/Z@9(,IBXYPJY5)J&85
_4dSPb]M?UKaQ]/fHX(2O>P0C?T3dRD/04#^Jf+^IA#Zd?^A]38/,I(TV_CH>721
X1a,58JX>7RNg.4gFO:@=W=0QaT63MH(KX\a1@->c<45\Sce1@WEL,)6I[4,Ge7[
.;.d,,Pf]Cb3U9+g:MO-D(AW,L&\]Ac8.e.A[bJcR[VX&Q1;/GBfFNA5DMOKRg>a
8\1FE#c:M.TV,^/Z8X<CZNSC-53L>\P=-#AEdg7R8EC<6?<=F]2LePPMHM(L52\e
W+&5F2b2#=5_TIbVBVCU(_\IUgFQPbJ>KLKV]I]LG55-S#dCQLWTK[GPF63M\YC)
U156(N.;Lg2#EcZdVCW#TZ\0Ic3H,=7ac,JgRNRcHOB\AJb<O?_RG<7>P1M=S5+)
,f-8a=B964)\3P=1@A_&e6b4R[)(_B[4W2QA.F08;0_\EQ--g9/MXE(SWM;g;[I;
ad/eZ,3PKBUX.&bB]eZH9GB76/#B)a6BUd4^4b9\0Z@3>K=P<M-+-XF^K4Pa2O3I
U:C#RD=Sc[24L#,\Wb4=E+@BD.[Z1bBC\Z2-291#g6[Q#8X+>-U,\<#E&RB4>dKB
MP?^Y&/1N->c>(]GgaHg2NT#0QWZRJC&-I(GKV<aGQg^AK4Z_HZ6OKE=O:;L;TF+
9_]8(]U>>e3(:YC@W.L^8K.@N/TK19:?.HT<7HZ1@E/LgJ2IgI-1ffKSO1UGGBSY
N8)Cg[C9T5?[RO1RT=TTC/;)UCT6SXGdSIA4V8D_P)NgM3\ecbO\H/OI;9.d^36I
YX^EE2TGBBVJ,D;6/ST3@Vf#Z+J5,BZHg9Y4WMU0bMFZDC0QX+d\9&P3?\@<DeMQ
ge6W.8RHef^058Yf6C+VM[5(QEO?Qda9ef3-gUF4-G3AL)74^/EDAa9.8P>;C[FH
&fGQD<@41N#AKX4544;NI<(V+S&Xd-g3?OGO-+-??#F1]Fc3MN:G4MgG/5#c-\CA
YQX+D7G&=Y8_3N17B(1B.DTaP?c1F:9637;g=Zf5\+I(g(9-(X\[Q,,M[Z)ND-bE
_I1MKB[6S@YI[01/R_O2>^#<@>U&Dd.__<DcbHP0IZ.5=KgcV;.N<6+PE8.E,@DC
1g9I#13XNFMW,Y=#S/2fKC9&5(bVWWY9;(BH3]R]Fg;G:+<\&E-3P\[CW<G2-10N
8,Vg-[@[+OMB3BQQK,-/Z9Q90)RXL<8gafHe2?d]ec1@CG7,794gG,7;NY6X>Z;G
a)<fc.JGaSf8LAO/aGRaNR@05@1JeQ0HH_4^2VRO7)JZNf./RB\_6N(42c.GM2D\
N#/-U8)SZC0IGXJ?DH.5&SX0GA8OJV@.I[LgBZ3b1+E?/G_R4XO@QK(^6D?>[=I=
,]#P,/,=33W_Y)MHg;<^ZDERgP^/QaS.:4WH?R,5RJGZe1-7&PP>Q\BPM#=MB(,>
1U(4(QE=D+)\/QFN/4,^#9=1;X2]+b_E^7Q<F?@d\,a@RWRD=31.BH+H-D)4IgQf
+1-^/]2G[M=Q4&0b^1ZX]_DZb5W+^FRA4CJG#_S-(^VN);[6B;?AB7dRe?NU_=f>
=]7HFTA(A(GIEd[/YD?eNLNd1EP\7ec.((NE^S2)9G3a@f[T;S9WJ(L8TV1;N(<4
+0fCNaROX7GdDN+IeU)B/4@1.>W^WB>.WOUcN6>e/MT9(:-b3A]9[17EA9LN[f=J
04baG3Cg[ZK2?99AD^<GAeH0f3FG+8dJM9(cdC4bf+30C6THV==05+=:F7TKEUg&
98cD#F^d7Cd3a5M^JSZ50&&Rg95F&GXQG5)3baG2S]&]K9cOP/+Y#=38RfZS6<=E
>DAPQ@&aF,<J1PL#)#4T(S\^<V[,1fWCG5P0S2][76,1C=WW7[eWfCG[3;b&R?f.
1^b57/)Ed[G\[8aFSd>B+CX:agNQB,TUZS<e@CSE3M5?(ZQ0)F1_[^_&8agf<I^4
N9b6G63/B-G-@H1Yd[YG=Y+#I=[AAUd9[0B-S.H)bgTfa<_L#<Pa1@1c3PRFDC38
0XUBC-UVMWCXeH62Vdc0M1BRZ,3AY90WYY[W;#E3?f/O8:+eLRRM8V5a?M0QSZZ+
Ef.c@V_D;E)bV=g^41NPK(E6Sb(,Z+L8YV;FgW8[+&)6[HV/>6C5<fNW5;\&EEYc
)WM0KcCG;6O+f01#\B]J^fGSJMI2J])V_X=/6=37D?#<67=&;fZ42(M+(9\XPd6(
#LP1087//VKfPL/B@3I\Fb:E10OdNBOLe==;5,5g(;+A=af?Z-CcL[8,Y=HF;O38
AVUY/G<Z]]QJe+Y,/,[.;4<#[GgDUDVf0=SX&Q4[O9]I4ME\IJ<PW/;=C+O6c8[b
YWG)(cFHWV6MD;-AUHF,PJ+\&8/[OMRE\,A.O7b^cMRM>IN?[TJ<Sc8g5[:>eVJN
+:S83<0[aLYf+gT[.KG^f-VLS2VY[IF>0(H2PS&)89B#0RRV]/)I;M2b:[b0[T4V
7<AN+,YfJUZIFY_,7Y#JHJ)&Y7dB?/-),;Z:6R8CGAVc1\1\0=LUg94)0XD;6@FO
YH)UK[+N8+P&3cHOGC,4<d_5^T;\=7(488?b4f]KI,-TcF_4e8f(fK<KNa&\)9)_
M3;=X;b>>dC:.E>28=e#NU-TNP[?N2451+->W8b5(_AA+g)Tg[L_c]9#4a]SKU>;
PJU-Z6G?We&S:OKHC>.=4NIO<X3SD>3K89QaY5NIW+LO(O)d49RLX(NT_M@5dVd7
HI:3MgTVEgAYc_^Y(>HGIae4?(8Ye9dY5=>_,1fJ45>[9:=MJ-R)W>a2,8?65U#^
>V:IQA10]0fR^I;Zb5?g7(+bG#^RAc->UV&X3#a/66gAdO4M-E;&&8VZb+[;IbN?
cG+5RCK/^SH_@Qe0YQ])gS3&HH?f#6IePFM)4H=9WA7@//;+PS;+V(9b)We;PC;c
<IN;@eIDCd6FUR)E:,c8?#I:Laa?FUfWcW3dOLI?=060>[0RMVeM;a0S2Pf,I=@<
ZSI&O)=dX9-383/.OK/a7>-a_6[>?5e^&,Y^f27RD_M8Hc8_?^GF?R1R<MP=&#@F
G?CR>B=[a1.&a7LSQXSLa:HT43FVb]f(#).JL+[WL:41E+#b[>3a]05M18C7JF:1
gRMF;TOEgITaM/;JF\c:?2Be^O16;S7LEaU9BEN5IU0X=N4e96W]=e4Sd:?HH6a4
#=Ug4#B;P[H2,>:IbT?;#FKbW1<);I0F6\Z3UeIUZQ^[(ZC=5+P.^&])GBaCK(MX
fCHfZ2S:.AT\T,.I-U6aD0F\-dC#4COTAHBfJA7dPF9&)3BeRSabRcY[^]g#JX=M
V)g5^AOYIKT2#Y.ebAe=X-D#<&T_?G]GI\dUD[@&M+/O;09;MBS]V6#TC?Ac[[>M
c5>QT\9ac/:KEGg7TbR^1M50Y^&7TA75R+bf\G/>bA;V-1KWJT;c8:][BW;]U&[H
((dR7AUVc9XA.M)ZaL-D3H[S:Q>2HWU(,QTGKM\<=E>&J[@H]Vd<TH\@3_X,KB>6
JK0]&WS\?>9:Q&&b7H.6Pe<M6&>,Y4D(N6EBM#U.b)b:,OH+0)fDYSWHRAF]K2IU
;Y3QAS?_TTd,/4X-?F9c4F2d/_W5NJ0H\LY)_?EPATY1D)]g.=(.\b.M)6gI2\63
(FdK/B]OIYaGH6J,7OZJK?BIdP>Pd.V577Fa/I#A=H8N<QTf\BXM\(:M9AAMN0IA
(1(6_,&PX3)gIP]&7C:I\_0?]DU8PeV_2?<:8@.gEeSOK\KZ6O5K[=5[>[W2C4+)
e=8dU&X_?>_OKP\F=Y\I.T+[_5_g>9dMJ]8,fX_L4Q>;:R^J=5@2[TZg>YaWf??9
61N<:&_H]Yb<2_HPIVK=^aYY_^T=9XbSg?fZ-cb>7)A\CRZU-[-&B9.QQ/ND3I9V
/eDc8WC/C:R_NNNdCHH)gX8M=+MLJ:[8VC4gaA5U-9\ZZT\9I?^\AW1\5G^G=bSc
+6W&B&R:2+CG4@,a9\/<NW:Y;#6=#cf;_1Yd;Z59WDC/\0GRR-C?g_FTbAQ\)JDA
24-A+N,#-(&.TJB^6CP-G?20g:BEVU)E@R\&0aST>2YH1<7)W?L>X^&GBb9>2]]U
#5:G]G1Ub.8dG5_G7/dCd3a8a3\U.Q2IRR.U@BIRM:CPII#S^:RWca\&4,6A0bWN
]#.3d_XV[ET,<-,OaMJ(G:SH6(a_B0H#2?>QQC\3NN&3F.,G;@8UK+3>f)LBeGJS
.4EM+,GabBB4ISE3PC>b.Pc1RUR+-8NUG5NL8ggU-K>5GgG&0;4X:4TXc^c=fFQf
gKa=)J)Z09_L5K&S:-M>bMPLE93gXKS/,,:0_,Y_JME@eBB\c)Wc8L-9c5d?.J8&
d_RC&^@X7F^9cZe:F5a^8-8:UH]2?VJ&JS#1VL>Z_>g0Xa,D&)@GQB/)](H6^+fQ
>_7fc[=>.X_QOU-Ub9bR>7_09<+^3C,]9](c7cg==LU#HVBf58HZI1.IE3)J0?d-
^PSKI:>c:T5#c2+IGf5)JK&c_7K<K[G(]>4NUY,9bE)0F8C?SP>&JLHg0=bQY\&D
+3Fcb^]V7c,RT+;-.VeE7/Z0D7#+R.IY2YZ+KDVIc>.23O4W<V]WP.Y;cJG<;FSG
5,-0@J+;IDM/P[F<e@b]b.e=OdZ)gJM=.V9?J&efY#SXX\F.(0D@C:RT4Ye=d2R2
Y(ReGHcD23,/K_ROcb?3O3/.Zb-Wg;GN<OZW,f(,9&P?E2gX5.6YbGX@GaJQ-W/>
7e34UN@/dADUA26TcScV9.E=,5QDZIe6Y5BY+L=A6F,4A@C<@PK1/B1f-E7H1ac5
P@R2A7S^J\&4NN([XC?[S298W;4?.+0TJB8K@dP<BZJd/Q:(.a_T<9cY./6<f@-e
/)b\fYE#FLCH?&SJ:g)Kc.:+#gOF=d9C?+@K&/#W_L4JSXDXBZ0>g#B@..B5YZ#@
g^H.1X]W-f73EdG[PMYcRB=9E7K\8SYdA52fVC.aDN(<gB,VDV9QK/6=3(A\E3BB
NWKMf?VTDQ^+#BS9@F<GA]JTIB+R?b+,EYcBP3D:If;E<eG8E4\J3^.@[L\@H5f3
TAWd1VZf^8O0e:FN<E5M(A7ge6TIN&)_d41Da)@3g>W?>J+9;K+1H7PZ12@gC\De
e2\Le1)T-.GB=aK9CPA3)/HF6UYg=+G3H:.N?#G2e_J2If(86/6Z5+^[5,EC)W^1
Ra>X<(8.,g9_9<0^^HH)DK)<M>Q2BSF_F354:cdZT1(&B?IJ;I;K\&F?Z\B^X7b?
M[\Ta#c:^^>AgO23)LTa+#K,BJHPBe2K#1WEGS]VKd>>VaZ<?J6UT9Td;=4dfA:@
eG@G]NCS/O3M2H#ZE/M]JQROK)+Pg#E:^@GL(=?U4d]Ig2^81a?Aa;\,&2@N(abY
RLH+[UObGb)DSE0dK=/[2OH(I]@N@\a:JV7aVbAeEV2]#PAfB5CX0>.Lb]^D8SQP
(-VW8GH0Tg]KF.Y@S7d[YI(FDU75Q^0+B.G;-f+<>.RF/J#SRdc#?XJ,34a?,#QW
]D.0M?MJIZCRTV1XQcYQ6N0UB6ZSbO[6RGJVTg\eZ/FJ[WZ(5T/C_<VOO0e&3&Wa
<7eB14bU#FS-2L5/)]e[\3A5S4O\Z:<(+<B65cVMNI,L#ef/a8S,BQ&:N6T1SH+Z
929:;NS7#XWCc=X[2?8cR,E518a6^Y[bc:A&<SFTFM79]G27<(7QGHK)3E:cD#f0
(P6Pb[\]^f;-(L(.b2:?FW7D96:C4=>25c&b=[YdNK2/QTLM;e1,[c-(g9\b=KFc
#&=3]\MT\[<ACOd=?E_H/_M:7E3,.V]D_=bZ[cRE6/BMZJU#T=dH>G;=PdD30d,9
Y3Y2_5O7f_E<AH.ac/_a^gX4-->AAcG)D.P27Ug#X^X?PM&Y)bgXLge7SP,4NCEd
.2:S,.GDR6/d3(5MU=7,(bT72Z4>=&UV9(Ed1&6D&WLPI7;/O8aBF?a\I(OS>^2A
YGG@RBT7T:dL=&A1b7D?0dO0/4=:M-.79_#-R_7NJ-J3RN(XgW^@3L>\H[=cJP)O
(?(eR2BA:dJ[I&)O+#KTYL10+5/HTS3VXVEGC@c\=W#M5<Qc-:,M5d9-7(5]afdf
5-4.2[@/^O78>Y6SeZ3T,fJ6L+JUYQNQ@LeC-B5gQ-a(L?e@B5)F/b=?A7]EX=Z,
-(CBD&I,CMZ)ZaB@IY-JF\&XKG<<H/Y&K8@QNdXLS4Ybc_>6BSQ[<L(T8M7/_..3
W72.Y:[g^]H98V,X8.-LK5cMIW)-NZEW<60fPe=?bFP.-(-O[UZ#W>FR@gY:dY::
bUTX@baCdJ7_VKT>:WBP+5cM6$
`endprotected


  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
>B[PI8L^]=K+c7I@6eZK9W&.&<f+:)5]Q<^;0>(1^,BPFg?INQ9b/(CeK7?X1Z.Y
fYNN^M0[0?@6+F8#@>^K1&F,Z.O9^>7I#J<Z_QWG//?=36),BT:>/8f)H1IC,A\0
38N]@<S)c(&;SJ1NR=5K\ML9+;=/0>Z_1b]NO3GG4/QbR:(JG\[(?B.b1I]E5d^f
\,B[>EV?&A.AUDfd_R=ag3O4P>=-&<.dS^gWa/,d;+9a;FcZ[M(2_X8,H=\]14U]
dT[FeG8Qd8JF90MOWZZ1>IH<CP.6E5M(<5g:Gc/bTRaW9/E5U0;G^Ee]P<Vb5^@)
ZP(_=eUZA&</SQ#,D6#f6[2XUV[4#W0:6VY[JWE0VQ02+F4NE4RGZeP/B+0F#bGa
?_:8@dM\5=TI;Z4D69FX1,g2LG3(>N940Ae<1cG(dM78NS39[gXB:g>P2f#K?B<J
;:_,A_C4_P7]KDX<>M&L4gU/E>CBa_N=_//F>TXTC]:,_(E(R+Wg6#9K#6g,Q-M/
NfB\MESY(1+8gZg_Pe+5cc-;d2A9.&_D6?P?8P9\\XeVP#fLA?&F[[SM68PN-g;d
/IDU9M_6_I6A0f;a@?D#g,^/WgBE8Fce,C,SIWGaYdJZR(0V,9JLF(U:@OZ--TfF
O;ABF)J/FATcebc9d;dGFA8WDIA\cObD6K@;3Da71dFC^Z@4L^(_f9:Xa_C?12A_
JdG?6Q.a5]9g2CVb;=?G.P+H&c;ENP/#a9W^^HD+)&D8C.f3(VK4@R2]ZZ]gZ#RU
CXIZ9(@cG6U5<]CVF1<VAbN5[gaUf:c7:4(@EDFE.70YJfD@,ZdQHL/4))#bbX.+
d,A2:.&?cdI2Og[J/+Z,@)Y(ILH.FKAeW:Ic^JO1QKY+L^0d:MKT)PdEU)1X69Q;
K:6dY@cg0WJQc1S[H@1MK]E^W[Zb4#>J^Oe_X^S^>)_e9Z)WSf58PEgc;fUJ+652
V>?K_]e_7eC&=HH2Ye_S/&XB<RCDgc#D.)VL>H4TDU_V-P)4(29QQ67JN]6?e4#F
C4+>/3NB6SJ/&95\B?Z?J5M(JgNZE/dD,#HZG<G)<Td,fK)B79-Uf;/K#d<)#+A;
87&GINL0B8a(??>Pd2@IS0-;KF/XNIgMXGg-F?5_YBNa<=E46c->25a>#U,A7[=1
EI1RHD&]2Cf7dVOAV9L,4^2e-[K)V;))@7\_)I;,/+?+U?b6HA-5Z8/HS)L&]W&C
;T;b(TaR[AAOZ5Fe?HHddAP=Q?3fW3,+OYB/#QE[9Y+DTL[fUR<)B(+,,O[HL&5O
LLL6=(^c2:7,TGE_8M.[f>XM2@[]W171f/OGP_/62(LC[&TW_)5D==]G8W;dSV/g
bN-&eGdX^O+=IeXY3)[<L:D/TBX1_EJ?30A]BY=C@A;&#C\:_=5<L>-\#Ub4g/IJ
NB@N3=E6&JeIff^\9K)&TA;KSA0]0FH_E&b=:FL1Mc@-?f;KQM^VK;-ZIJFH(a_J
0CRL+?</Y9U-XN^Kb@9+9e_1WAP_=M6C@a10g@(T,FZ#+bZT<)S2ZNYLXXF#c(<V
#))D@Jc<YA;1+_+/#;X0XC4O6=SCZ#EGO[,=TY@_V?324BMD\RO=57M@6Vd_Q<^<
B<[G[cRE5?SVd@ZbOIb=L6V_Q@BVc1@#6B2Jc1<U5/.]c1GV@A:6BZQbDV?NG)(:
U.6c7Q.dg=>Y=;;Fe@J=,O_CE=Ld/H+M)d(0SEEF[F9cR[82CBP1(.1/P<-V_RIN
TJ,-;\UC.?@gM?9Tb3-[DZ1P.+?\B4GG3#geC(a^Y0gA5c^6WD#CO<QD@M@bF=W.
K7/HN6#K5G014M:I3>gKBQ.c0>XcP(3fgdEYE4Y9Tb8[Y(W_B,Of4C[NGH+=C;?O
Q(]V>>c8PT7cD47C#M+X1@-XP=QGKX?b@aN?8c:#L6(3>_218\4C7HeTFXg7a>,J
ALfbbWP9F1Z.^>>&^f6HcU+)N^B[&^XLUICf^0JF1M8?O8b[/-DA>[&bKI6N+fdX
<<M3f@I^b>/AB=OH;UCbS,SW=Z-<QV8E+X?6DPLgNg[L/WB\e9XQM)CT(cc4\5e8
+@^?e_gPaQ6(NR4^UC&^F8:ea2a9]KDbQ0[2_Cg_V-TN^]XBcNePVc,.9SU;[+^P
]<+dX\WM]\]D_cJ/G@Q=,/AC0OYCMFJ(V;S.3?FMSW]S]_XLd1J;35)?8OLDN07)
70[H85e4?.f#LK;F@4WL_<a@S7_Z2I=R[:2faA;)5@4cD:VM6Zd3LI78L&./;J&2
7IW3E5&dEX4@DSNAT7-&?S7S]J)\a]9/J@L_GB6fJP5,+8TA;0V8<ZW+2Z5:,gJ/
MOD>GdFHb6KP[)(S/;5S<OgXT;D-0B02:K3W)6FY^]&@-\\/RA/d^&>g7IR4c1)?
ZM)3\C:^6WI6>N6fBTJ6F&\eTZ5YHgN6#_30.FAOT>RbJUb9VF_PCZ-KV\9</J<[
SQT#eTY/^AMc,U1Q0->&=dB]OY)ZBQ?2U9EUK@WgcHTMRQ_+^cZ8CLU?]C(#AVKK
g1@D=R#WURKKK^7XWeA/=ON?M9\S^,<fVIY>cCCfP.MAc?L-H+FWZ=JDD/-==fF\
54fY:WR2=;K)&[g34NaY-A2T\:?H18I-V56fOW7C[OCP<aBZC<7_QR<:XKCJCQTR
4^4@J475).N6X6_)\):4_eEHbV\&RYIS62afHR<L33LY@aVW(;TCdeQgJ/6G3/dK
9TF=Sf/5Fc+Aag+?;T5G(YLVZ&P2:8ge6W@MN92G&7M1g.OC;#\4FS=X,#.8dcGD
1eTKZZ2f_1VV(/4#5d&2Sa3]0CVI1#></CR0V7\.^(cFJPBCI37RceeKd-YZ/IYD
)U&>]AWeF=2VCP)4I8UO+6;V3Y./?M-M]e]@gK9:C6+?:f)fPUH[fZ>=,M<[>([^
0,#38Z??@?1PdKIPe<]VPGW0INKTJB>0\\9[g(K,/^LW[NNAb#cN/I6a/IASYf/S
D+_cF3_ZfHacc1AIW]+^=c]Pd-f6TcLGH?CZM8;5L,29FX0eCgb;T,S,P0P,9GC4
a),HfEA.#a,AKFcOaN>UOGE+N=fDGA;9AMbP<A;Q?S<V6]E1b18M>(>5CBG5@Z[X
<<V^IO\7J50L2\6fW8Wb7Wc(>))e7D=c1&/-7(2CG>&2SB4CKQ:/-7cPb<MYE;HT
AS+3VGf+(fVZb1CD]P;Ace#cI/ZK;17NVbaL^,VT>g)g#Y,ea^V_Q?=Xf;K;181J
V^3:MUdbgFWg)bRd(J,R(63T1>eO9U=9Y90cI+]9e6FBGKWC5NG7TQE_VNb;D-a/
=(bN6C6HTY-+7FW+-aa9\LW/AFdSR(gC9I.KQR_VaJcY3P19F4IfaRBZg4.^g]0?
H2W/V[RKMD#XWBI.g8a<I3C.U#->9(R5WKW43[RP/-+0NQ2]c;cb)ebI4b1a](aJ
79Y3882CeZU]2HQbRRJ&T.fb:,K>[9gQ,FV8ff0N;P_;>d5fG=VD-a4OH\dRZMB^
T-Q=GNL;M1^S/BS@7PLN;c#e<Z[4\cS-36JD>Uf0M\)Q&Z[+1#]JO4<dU?#\IW^O
(fN#_SH7U>&22R03#N70](cX(:7;,2a,1JL=<Z?0.9=\ag1W70HR43HdPJO3:T\1
Ra5BS=8\C05/<(>7T;30BeL_]b2Md,7@1:PJ6@./:JDEcSSHd2?HMT=<&:F<Ug&:
&0/SKO?J10G4;:bW:Feb0I;S;N3U3/-R<8[NYbXJ_f@B9Q,HX#_;fTcE^MC3Ya3&
-MB3@d2<([4A1T(I8?2Y;d1AFK=e62LbBPT]6L8f<_.N=egYN=-Bf[]_>1d:XAWC
L2VB<5-1<X=IP\V:4R^DV&\@F/CJJ)3M<]4I-bSZ+BI<cQQJM]a5,B[<TRfJ8U/.
@^dfBN@<A(3T_V5+;4XbYf5\;3?eB\3]H(L_>Efa2GbKC@S.[VJ=S;HO5]e/VLB\
O/f)70bA\Z;cUU(WQHEcDUO2]CJ]Z7Q@3P54Yd+[eB[GUQ.ZK0+9Sc1J_RCd8\H6
[d=gC<TUC2LC1]=7Yd)#HZKH7.Oc>I_G&G+N-G97I0WU.(ON]3HZ94[Q(WL;DU9U
Yaa56Fb?@(1QT;H]c@+47T1_]K@[QA/M.aU?#68M<IMPeG>+<29QYeZ>Ue/3EcIE
P9^=R#fU/V&Pb:C+WeO.DYR2N\&CaSCJVUX\Ed@PI?L7,]-#(PQbAAUU)26&P?KE
)&.:]?,9LPG1A2<edUJGN2UDCVBMG#0CL-\]@6O_:Z[?:+8.RWDBYb<SIU1SbWb2
NA4S-2/7KGGR&H#IP:ET:Wf9@5H&7_aZ>e,<7L+]CIK2XXMO.BDY]L,e\K]J)4]N
52AdW-2=[<,VTS-7W8JXI0#Z1-)JHE?D=J8cN2:Zf,6I<R_5/FR,3BHXJY6,5EH&
\T9fJ??eTR.V\0-cEXK96+&fDeP47aKCW?JB1E<N-C?K:PJ+XVdU9#,VZ8Xf7#b)
;07P9_67=UT1G;/>Bb83eRLbZ4J-CJ#+L5-_]I?KLW2_TFO;_#4a?R3T;=a,;d:H
W6B5cbJWad,R/.0H.ODP@+g/GQ0G#MWM7>N^bDYEGX8TI[\^aX5>d)@#XW0@+&1@
g;3[d+>7WZ(JF(>XI0[B&\H/I(g?b.1d^cT0AVVFS4&V#fg5#Z>.Jfe:3WWRUF0f
J2BT:&1]9^?I1C#.59[//X+6gGZBJAE(+dW2d5/b7/3(TWRP#5E62ZJ;=W[b;B+g
CH;-^eX(8@HOWZU(EfQ[WDMV44[VYY(UEO5)(46G.=XV6MO#Ie(Z<;1<1&GK=aHI
bdYdZ1bOU0daR?d>-6(09@GQ>YMZ;DO1L4&OM3WSNQWY.30+KX]_&R:g.^Cd?-g1
E=M6#V0R@(+R^1A6e@GE.AVS,R(989L7(6+Qb]TWd?-J:Ya2F3fY=V#c0D?<K^>E
E6;TfVZ3_FL782=RA\VMEb4SR=0?0e;g&(f>+[[1a1V9:+FM&I@>9R/+.HXe]3SS
1I?+ae/fAK(]T]MH&BB+\Oa_eXa(:5_A^f534&_B>)GTA7I+WU2)Ib]52&R(;Ye?
S6))(^H]b??d2-7D20>-@]#1K8c_d7SH3HdPEL-9PS(N4A.Z><FBcN6#3HAFEUg9
dG>]+C]&5HdO;9VG;]HPNAU[Lf@K6fSW,LDge3=Fc+=MJYN9R:#]<\F_A_D7\4bJ
2-TR;D:3a2Y-XRA]&MH@SXc^P>6H#Xc<^._b2<G6]dcaeG#E5]P)+/OG7(+<@I6g
VfHA^DS@I4dH@B,)C42P2GKfH>/2C7,.E7<bCB_gW\B?1I7E#^DUg()CU6/)52BR
b4;@4A2e<^bAS>NbfSO-./K8(G=QHAY-gFS@,^IDNOa:J0QfG;5ZQ2WV#)g()],L
?><NC#:29,6/A3_K52Z=B&P=4WbUdcXa@6K=:;#^;RWB,<@6VY@U/,2=Gd9/F8W]
g-(AO0@Mc2WIL^R47/S1]Td,HHEBD/:5f.?JC61U0L3VTb9W,2?.K^a#-88LX-#J
f7a>dBBAK8[\bDED=0bc7UPJ]WB9DdaYIHe@&S5]GFbP8Pfg1J_^B2F1>(I6C6BS
B8YTX2R]7]dE5KV8BVAOU<(:WUXU&XU<9JN7N\C&74^O6+-DZQdQc2-P(5geEY^;
(g^bFXM@W027ED:GE/DZ9-:aS/H_dWG;<8SN4[?bB3KJAb:MX4OT4#_f=IK>,Ra^
SDT1:WMDK:6\OHMU<F6R?0W+PIEPMEfKWW\V:=G0S?&/9A,#=(K:S;;_K;J,CVYF
OVW<[GcO<GBX6@0AOW9f8GTe^/c]/I<JX0JS.\P36I(.0c8D83.07R;DaN@#(3\O
ZMXY+b>_(U\<3/[<)YI:S[NW6_BU>RK2&/_eOB95dPBbTX;GT(>YP\9F2?<]HaV/
^c=-MR89S2V5BO=OJe+K^N-I8D-NZ4gE2=8Tb79f+:6&>LI)bgg\f>I(]4@L,D9O
>]G#?3DA1?:f;5DA:@4@b&+08)WcMb4PEbcE3V.[\:cM=PROU/7J384@GXHHGQWL
8_^R.:Vf[9&T=W?[@E9NPa0QZVddQ:@)?3]/fY)-^D4W59/3gcE].H3dC5=WCA?D
?ABfbJVR4C1D/NTVWL9<SC#)\4:07\1C@b<44_5T\K(9)@5;[M=WH;;HYXcYVg6b
_AF,VB(&M-H?Q7GDcOZHc9=23d:ebW-Lf&^>b4[5M\>:=2fN-4.)Y@F((8_KLY6P
YQ1[[;]/I2JC\:.W[V/UN<TMNT1VAEVJP>>;JVfYE/J78bC4O0)[_MN@G(#03a,4
HHMTee7E74^W,DXBI@9U)db?++0f3CN/1&ADMTS:?P9G7K.&>fKX[Ig:g40K5SLO
0GM>aMLMF9L2GPd2]b2[^/e5I5ee+^LQ]-&SKbV5)BX51L8Mf)O=]d+:2G<E16+\
RRL>OGcJ36D1d6#BHXQB0O1,dBE6cHb1eT-DX6>J\1&\];ONM-6,BPJ8gd2VZLc>
=DY[T6gKc+8[61Y0(fRBTNF5)>[-S[BCDf6(;P,598\U3J-.CK00eK(+^ABN0eQ.
L>69+<+f)VIZ@]<OH=Y2C>1E.?D9YQGdTcQEGaSE>=XcZ]0S<08+TI?A#IBHf324
6Xa;4C^62_./:K1;>Dc3KIg:D.YG-4[]IIA\G?FZ-O)R4fS-/AT2,L6gNgc[BJ:?
JNgeW]#YCMXe^&VdKYQ)Igg--4&K+B_FR0ZHHgVODS-R;/J8]SWD(&,C=C^W=]D?
P4/>d<(Z?;3^[^)IMC]96bbID6]:dENU4C,#Q#E1WKESaC-C^IULR3Hd7COGYE=?
.)HN]M0/dd?F8K]g4/BO#.IUfG>F0FRb3\(<EV@D/<0=)F(T?0Z4SX4e#aP_+ZSD
:A.Y<Q=>?T^P#2QB]&aDFL1H&O4;L3OV@\O4A.e16P6.2(+:)=7Z-e@?=[@D>e,3
GT>BDKKDJI.A7?06/(M3efC<c8RSYWKQYC5_-0ePSa5=[a#B?e\K5NS6\Md9/7JE
+ACZS\P<QUI,E+_1\=+WUXZTGP.51IX,cCB:e(4J::\@3cGKK=<gQB+:a1NEFd8-
U;Dd8&Z<VDfOZ@;-]HUS\JCIQ+d.RQ8D3:d6Qb7G]b6B<&NgfIG&b]cUL?9MKHT/
5)^d^Z;PCXY3W4?MS\#B3O@W57T^=@9Wd?)&OC@Y.B@>[)P2)2N<94+L=Q<e;HD.
C2D;QKT:(<Fe_749-,b:.=;1J]7WP;,aGB@T^<AgJH_;KQ1_BCbF@;,,^S<JM]4f
d28^L3\V(^C+N,.AVSeOS9bI2W?gc==S(:,3;A\X^e\Q8BY1#C8,C@O4&(X;\E?.
I-U&DB@/PD-3g8H-I10R35gT9G?<\UVK3W:+4D<0NM?ZW[O9WFD13+N3O/=4AKCK
(fD(@?WcNWQgA\U2bKOAfE3@b-?A&3ecd)9ZBBBG<<+VQ?e[0Agc8QL4?Q<HV.4B
G2H&<+2C^T9ETaa3O?92e,)J/Y/KB#TDZ43eXd<dG+7)SH8g>8f(#BT(\CM<E^R;
S_B[F\[5PAP;QH,K=QS.&<SA38KbWO_:#3?NHOW\I^eGL96=?D-@66O>&:BN:C43
\K:B_>,+Z4\B/b4&-=C&+<\R\=Sc\5HbVYH_L,-2]&H-0N\_FfG?Y]PCa@d0a8E3
.87DBOKZS6WDD1I[WV#XXX]+gXOdCd<4[.-EQ#+C61D[?8KdT[)[#e,<YOVR8=PH
LLg\=Q1+]V:3B2C?bc1.gCSd2Q4^ISZ#N@M-R(R<4UIe,0I9Q0-/eCUId#6,JE(P
.,W+-J+QE.XgA3bT?.A^GdKK4]QfL(V(6gHa&=WZ,D49^PcFE7OeKE]V.\_W1NG.
a8ASC;/+X[@Va.G&3?/25)FM&eg;,+e-D9R//GGP#ZJ)C3BE.=,T6[DKM/20>aL^
aBbb)3EKc3.P2QNTSI1K7RIMB4J9MAQ0dBIf5051aFScWSW\P@BO1;1VEYNSFJ0K
IDAaKDB/I(f+adVX]QN)_&M#A6=B],g^:]FBEB]0_?4ce8(6.7f2YF]OIV,?-f-f
6g;BJB,Z@TRP[25b5J23>E?>J=^\#EUa)Y^I8#,b1;;T(G(PZ)Q@\SBEN4D;R_P0
bQ9<OOO6aT[]59.=Z\U,FL5/DG3)N8[#.2H<gXaF2NRbX/;R\>Qe=^/.BG=)ZXJb
RMONS?8=d?c24U/d[c2@=#EaL?/Vd6:FT0RB9S:DbeD87Tc6AS.G/M\9_^-(K7T9
9a+dAV^TRVdU)@[,^2P6S8<]@]L+;\ZD?d/1B]=CMWfegD8b-5aBeYXJ0a:aSV@_
JRGFF-N8Ta6X1QBJ?PeFP0MXT6g&7])7)B/6_6=f,WEXY+/SPJJOdE=Y;>Q;;&#0
Sa8YR2d(YSCe6.&+3JWY-162J8,Q?)SYb^G][T6_VBD-EBLW5)dGL80Q5@;1<V)J
M#+)3&PK+GG=9bVd]IF.7-\6d6;GS3VK/&9C8?2L0B:<S>\_b+e4dX+VYKfQLDLc
KA3A6.368580e8EFL<;VYODeaU@J]@N3#_BDR+=+(E@-ZPVbI]#.DWYbM=NgR&39
:9DXI7#Eg\-dPAVgY&+H#,.6Se6VMRX-=?g29OR\/6U<==EADY\-+(V>52YMS;B@
FQDbI>9K\>J#f/=E,>.YXNM;0?Y3bAC=f\N?gQ^<_6QV,?EQU-:O4.?fU88RFU;C
W[V/3Ub_?a&;21#bYD\XF.-@=ZDH7B_\S^fOBH[Y5O47STHU1ObI#;S2.ZCND17a
:;>KbEP]_<-APARgb&#5]EF)5G=RFSJecM\ZF#2<0:LK6O5I3345Ge4?EfPOcQ&W
29Q7B<WH6B<CJ&:T868W7PWT82TA[H=9fMb?B;[.FRf:FLZ9HN<(:2C48DEdGdU:
<)8Q/dD@C49CII[c1&0&A_P?+?J4NEX?YE\cfK]XbRNAMHC>)2UB&Eb&@=GGF>R=
ICU>X4M\BMC;#J35B+P=GSeK65>]H/H17SObN/PG>@?,&V[)a:aGT:)88RCIR8De
&dSEHWSJ<&FZf-QXdMEVA37W]X6ed]b6-DM>gQbES&D5D6)(F<98W.b0c08:ASC_
Q-=:>=H1;<2^4ZdIW687],45#U\V>.U2L1??;=L/GN(_FaNX&<^LAC7_,@5L8XWa
eBU6BL.47^2YEGeDIa8LS5.8,\E&eEEfW,U,E&;6b[+DK3Y408;8I\<W(g-?)/5\
>>N/#]#//W)R\0eO5BfG,OSB?1(+7:KLJg3N4a[)<X9>(5L_f>&I_9GYGQ\JM[;#
9N]DF-^S,52dD5#fOVdFfg/@d\)5JR-MGdU2b5]8L35_JIQZfI:0PXc7_]8RW,K6
Bg(^@=\X.TZ2UD,#eMT[V<]0Eb=RI&=WE.@7)ZGcAB]_.JH51;)?6G.-;Z#]47&@
a::8:T.)?/\1cTGB3b>#L+cMR83WLRaQ^:c8HOTNA=_=\5g(:OXd@20B/MJR^)\C
-TfH5Z#61NAg(H7VEH,?BGd9&H>KRfW#cI_\7aPA-Q,.92J\IUY2<T:RbI.&]a=Q
AP5b.6/cC4NA\:L:U6S<+D05ONT56X0C4M29@4?[9E/S_M@&-C6Y_K,#5PXKY[35
F);+6(5?)UMe?&&JEPC54KW2>SID^e7N[^bLO(S48NG+8OLWY9ZC>:)eaZ@RF>c)
Kg]\.NM6GV>P2G:B^3)N9+eY<VHM-E]N<C=2U)g>P6V\1>)OWC]#S3ZV&E;YVC;J
54^#A+&QV)_<S9HVN.0O93\8&?([X4Ka_;WA5?K@/<<T\Ub)bY+4AD,/OQ29.a<8
Q49CNL;Gb+=gR2DdHc50f,H<RCHM],PV9a]W(D3Xe:KH&.a5X(<MaVfLT6M+(GHa
GH/]@Mc\[cD4Qa7LL=Y8OYK?;>4NP2\+TBa/4@#bd:eV10HHB5d&J<W4J(Mf)_75
.@g#(N&&D@2<NIceN])QST,J,I4g=Hac0bX0[cW.-ZdVSK#,/gPeXOdOg,8aMA0?
->YW5PPB:F.H7.gbF-e.g\e:GC_)b?)9-&[28X2C?7;SI#Y;@G&e1L@(,?_R^)/I
ZGgB0V0J_1b5(BVW+SVY1Y<2>c#CXMT@\4d8S.LS+EdRK=/U^8RXN7M((:4?7dM-
0O1E;8#7X5YP4.TMPG<_(6aPL_aX1(#(<1N\\&-W)BcGO3c,E4=?JZXYY5VL=SaR
GbIb,98_-@7Y)<[1]DD+ZfU.E.BBS&JST2H<baS5eG6O6>[V<dZ@P6:33QQ2EW5>
4bJcFH5KdU>B241ZXB@DfF9DHcX/Z:fU96)LWQ#7f8PX+6XZX2<Q+V6NE:+-89#-
7A3]?IfE@Y42<bYT=MTSE.HB8@R+a]#LMa[A,<:7^_IG)5IJ6H:51MaO^<LHO721
e@Ya.P.&BZEe0fgC-/SE?8&,F8(L6010e#7AO;5D&F#A-Acc4SR7.O+/e36dX@;[
<e0T@?X+a&N&.2-O,c+G-F1OGF@[CAZb_g:\MI[=_8Zb>S.W5WaBA\W0OS#c=K,W
&/eg5f08AT)?8T9,,>R^2KSJ(fF--H0OC4ONO8T>c9S90#1/IP]I]e)d<Xd&WZ/@
e&V6ZV5#:&44\aOI@/dFRfB:CBPWD5I7O&XISYB&N]4BD0UY+&716a:K:-\5B[Yd
BGDcW3T_Mc2],1:V_S:9-2=0RZ53)O0?FUfgeQM4#BaY<ZGMA^723IeDY,UFSKHR
g.9\E@c.]<:]+$
`endprotected


`endif // GUARD_SVT_STATUS_SV
