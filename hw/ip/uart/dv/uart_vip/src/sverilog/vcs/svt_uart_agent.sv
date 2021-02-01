
`ifndef GUARD_SVT_UART_TXRX_AGENT_SV
`define GUARD_SVT_UART_TXRX_AGENT_SV

/** 
 * The svt_uart_agent class encapsulates driver, sequencer, and
 * monitor. The svt_uart_agent can be configured to operate in active mode or
 * passive mode. The user can provide UART sequences to the sequencer.
 * The svt_uart_agent is configured using configuration svt_uart_agent_configuration.
 * The configuration should be provided to the svt_uart_agent in the build phase of
 * the test.  Within the svt_uart_agent, the svt_uart_txrx driver class gets
 * sequences from the sequencer. The driver then drives the UART
 * transactions on the UART port.
 * 
 * The driver and monitor components within svt_uart_agent call
 * callback methods at various phases of execution of the UART transaction. After
 * the UART transaction on the bus is complete, the completed sequence item is provided
 * to the analysis port of the monitor, which can be used by the testbench.
 */

class svt_uart_agent extends svt_agent;
   
/** @cond PRIVATE */
  /** This variable is set, when VIP is configured for first time. It is need for Protocol Analyzer*/ 
  local bit      configure_vip_for_first_time = 0;
  int uart_enable_pa=0;
  string uart_plusarg_value = "";

/** @endcond */
  
  // **********************************************************************************************
  // Public Data Properties
  // **********************************************************************************************
  
  /** UART Driver. 
   *  This class drives the svt_uart_transaction to the VIP.
   */
  svt_uart_txrx driver;
  
  /** UART Agent Monitor.
   *  This class collects data packets for scoreboarding.
   */
  svt_uart_monitor monitor; 
  
  /** UART svt_uart_txrx Sequencer */
  svt_uart_transaction_sequencer sequencer;

  /** Checker rule handle for VIP Protocol Checker rules */
  svt_uart_err_check err_check;
  
  /** UART toggle coverage callback */
  svt_uart_monitor_def_toggle_cov_callback uart_toggle_cov_cb;

  /** UART coverage callback */
  svt_uart_monitor_def_cov_callback        uart_cov_cb;
   
//vcs_lic_vip_protect
`protected
CD2+:41M)Te\c0/8U>]5CJQG__5g,OJIK,W(CRXa5A@_.^94N0Q#6(FE,8\:fC=b
?KF)R;DS3890^2Z16TIdWU.V]L\-^XYBX#6cd^(15g2gSf28<Y)@PJS]?dV^KcJ[
<@FETbfGHXe7:E0FX8+O^XR9&6GRcH<_AU.-32BZ:>&HaD,4Ya+d8]6f#>Z-(\XE
.U=-3d1A#Wd8^\X>DX8J8(=\W>_JU.Q,XA:,XK)9UQF&TUg)7O=];0,NRPCY9SQJ
>6JFX.)A+a;G86TgE.27#-P79&:MeDc6B:-_\^LKcg&N?8=BN)=f+)-#[]?;7>]C
g(HK0WSEQYB[P:AMM:W-AH&AY4gb&#7:ae@f\LL.;LKDg2c)[><\EYXACXW;I(L2
&9:@QYI[dX0f?cQO>.@K6O4EAZg&=:(B?J3/Q=Y&:L1VAbJE5>bYK=WNZ;78A6Y6
bBLMFS=88?e71b??IIa;eKfNfO0=8]_@<C,4.BZ#+OPBNab_80WK.D8@.P]M/eMP
>.,0_IcS(MR)@Z#Nd-e6;>WM_I2OI=./FOM]_[_Q+K^d#5O_=BaUeO<WeEY#5]]Y
7H:GV\IK?07BFD#WJRaQ1(f/[08X2B6G50#EHBV76(F\(VQL\G?SN4bDe\?4a2U3
NRK,E_L@KS(@=1b/b7&QOSI>Pcc,77(e5<6QXBgD?@..-NE1A+F?A&:Y;LDI=T4K
c-\UKW5H1)-4g?Z=1f<KBK\b8Z>VGfK_M,WBGUEH3/YU,>OJd,M1>JZb?\S]5L@_
U9V9L(E+9g^GFHXPMFfI[2)2>V_MA0<O<7#O0\0D/M[?Y=-[P^E&7Vc?A]GaDg_#
C_8RaQ_g0O:Q_],d<1@dO#:adJ0dNCaSa5(-J\@]WV^=IVVZJB^f32:N6/#;P-d(
2N.8KK?4#&]71YMSOU+KP@Nc(eN_Pe?3Ne9_W:BFTCLF(;a74?27#+QgT,YUY,8JT$
`endprotected
 
  // **********************************************************************************************
  // Local Data Properties
  // **********************************************************************************************
  
/** @cond PRIVATE */
  /** 
   * Configuration object for this transactor. 
   * This configuration object is got via uvm_config_db. 
   * This cfg is also written onto when reconfigure_via_task is called.
   */
  local svt_uart_agent_configuration cfg; 
/** @endcond */

`ifndef __SVDOC__
  /** Virtual interface for serial and clock interface of VIP*/
  protected virtual interface svt_uart_if    vif;
`else
  /** Virtual interface for serial and clock interface of VIP*/
  svt_uart_if    vif;
`endif // !`ifndef __SVDOC__  
   
  // **********************************************************************************************
  // Field Macros
  // **********************************************************************************************
  `svt_xvm_component_utils_begin(svt_uart_agent)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end
   
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name="svt_uart_agent", `SVT_XVM(component) parent);

  /**
   * Build Phase
   * Constructs the #driver and #sequencer components if configured as an
   * active component.
   * Costructs the #monitor component if configured as active or passive component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
   
  /**
   * Connect Phase
   * Connects the #driver and #sequencer TLM ports if configured as an active
   * component.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif
   
  /**
   * Extract Phase
   * Close out the XML file if it is enabled
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
`endif
   
  /** 
   * Called when a new configuration is applied to the VIP.
   * This task will drive the new configuration settings to the VIP.
   */
  extern virtual task reconfigure_via_task(svt_configuration cfg);

  /** 
   * This is run phase of the agent.
   * In this phase 'reconfigure_via_task' is called to configure driver, sequencer
   * and monitor.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif
   
endclass : svt_uart_agent

`protected
]O[<?^4I<]9@-CJ/W<a88/gUIS2+D(0I^D?=[U[Q1P7]J:[T>^IK&)C&a\Wcd,]b
:/=b,2Ld@.;]YUfE880H?7U[+?Q6RggE>ODUE]X/#MSA7a/(K7/:3/\8J4^Y]N^P
bG9ZO+D17C.83G8]X_=K\=#G87Ua==EX[ef\cSa7UgbE5Ea\#-UBINdPFb5NCW\[
b\:g5I_H>KbE)8I=7/3#AJ(T+-^&,/Ae>AO.XfHB+WYF],0FbCgfF..?BLNaFEN>
1c=>_=N76Q&.B=6+32dWQ+(T6$
`endprotected


//vcs_lic_vip_protect
`protected
V0U-+K\FAf#K8PQ=F:8&V0fPHX=PE9&+9;^ZG6bN,/ZT+_(J8VW#7(@1b3QBZ5Y@
9f_HB80QX>7SLQ.)E_AP/>3GX2b8J<)f9?\T5YQP2VJaNA:,,bCf?&_)NE^^^G8N
7Y6c1fREMT.;L+f31VICT:,9/.d<\G+=WW0D+Y#.E=)W:6S=WK/c.\^E9#d;_N:V
^O&(IFV-\(D&F_1)<3J&[b1BD^,YAa/^&c[[_=a6;#g1aJ-O.2<FD^KWXSFTb>?2
CODDTgFXO.B6K<9LVU)ZDIJM;=B.D2VR]R0P]4Sc?:T7X8_9(24W<OAd.1:Qg8?g
7a0)KCF(06Y7D?<ASH1-I?EbEeO&H99ff:PFQCR:K.D<(?8E:L]I7IG7F44Bb6?-
<WGN&BBHGTP/3=CgabP(?#(.1MVN&)-ZKZgFLN9HMO29&GP,Z6)1PL_OQAc@?J\;
>Lb\JDD>G7^Q+#LdIQ01&K)bNB5H2/8,[OSSFZ_IgdbS)eXW3Fa4#6F\RYBe^=M9
3>baf^@/Z-D1@6GGTO8.UZ(H>;B<3MSR4GSdCY=6H9G8Y^cWSO&=bF5_?,(LODN\
1QH/+<ZY6@AdR4W]865WT,J<3Y7_1?58Bf,TVga?QOgW.eO8C0M9\[EJSgLU_BO0
X).R-c#@eDT^IF3F.fCQY-YX>FgL,DY=UES:@d@=\YH:1c9K@O;HRW6+.Y\^-WF>
/9@[B(72[+=;#3K,4c+]PcAIaZL=d^&2#,>J2^GeC,Y?T&5&V.P7=)\&2\HDR5:P
/V<KSDgbP)8fZ,H/G(KPTLP/+BV<E)[0b<[+_ee#W-.]^G\,M2]-LI&J7f@A<V?K
G@MD[IE?2.<BOEUK8=g4T5\=J86,00?3W?)#DSa4gR5AAO1E./6/_LAUS6(Y2fUK
]DP6;OQC27XVLcYMZOZ:;<]QYJ;6TVc11a.UMbDZ;F3>CJS>P5]Q6d#+Jg]X6J]L
6&3>:MR2PA5:cGEEG#U\7<HNLHV#+S\Md8BLDGH1bX?IB38bdIO[C?<g7&aOV/a:
YWA]d@+<3-ZLP>,[8>d?a<g?-2.>8?S:EDES)#F^(]3@O_GZD#AQAfT#3cLD@8Y;
cUR(1V-a^f7FHeTLY:dSYW)D\&=4#2),KK0SCa_IT2/JRW/)PR1\/0S^#a#ZECcd
JC8_3Bb7_D_(TbMZ\AF]T)E)-((:^DJO+OM&4(&TZ.PP,8fQK3)@a(2^?E/5>5>a
&=VSbV[/3Mde&9/0Va^ON4HYBccIYbf:TPT7c>eTP;G3ZV8+Q>.CZ=eSS9C6^,_J
b4CWGXZW4.LgOR01PMaO#]4#=7&DC#/N[5@N<Ea8R0ZY^.,/;Y]^;0C7[)9cZ>:-
J.R14=PDW5@L;8f^L)bTEK(T7d^BNZL]8VIPSgG&Qe7I4RafBS?9<WP&ZI874GMH
Qb#.OcLc239EHPFB^BcE_0^0P[9/H)&IffLQW4@<9.#cFa/f^BD/M#M^?A;\a().
[X\/Ne(=O5LS0aHb(1LF<_eL\5;d,:QAN_aIW&_&W(D,]XWH@3L\Ega/@7=/cf0N
>SZIcZgTU(.N83fJ8(HPbC^6A.@]3.^OC[H-Eg7YC+BJG,NbF9PgRFCBc3#P46@K
6_KY=]b0R3M4?;Tf(R#RTYNH<:OB2KEcM).G1&IC>0Zb4J^T[,Y64?a)]9C6ILKU
g5^#ZI^(?+W9VGcVC3CUf_EMK\PCBK\4+O-E-@LC9+L_FS:dMAES;IU4FaP3f<g+
Q);&+UOb]eVI1CGFSgdODAfJ42>MDQD-SO8:gP10?O0(gcZc(XbZ;6,ATE[NNX:,
(e(Y;1=]>fg],^A2B-D,5;G^;WA5ZO?b<BT?\7#CCINO?9USNJM[b(FgcXS^5Q_0
4N(MIbC32W7E2/5.TRACVC.JXTHTR@:d8-GIc@-cCH2N>(],L6;4e@R[f7.V+HH=
;QEQM-7P#4RBR_..B-H<CS=NTJII6eA4;J@Q?-\[DY#:#@33W9<[-PQ,d2?d=HDd
VL]E.:M_<QJL7&ZAMD]NF[ZRXbOZ[F8J,S#[Vb6E@]=DLMW&(BdI\?D>Y;AgbEa?
9afcQ;?bec,/bF7fI^3WND2A-KR;JTKW;-8]#8J@[QL^0\T^&bKW=<]QfS&YWR.)
f6]U_b#He5DVR[(BZ++^bb)c)((I31D26W>98ODP?R;?79D-[F(20DAX\/KR83Ea
>O=G,HH6g4/NO)=O\P3-<a&Jf5)b)>&76D?4X&GF:\R6&]e4&OHURW?J\?#g(#e#
IEN=JM)D,gfA22<?M\-[\-3PF0Q5R7g&+eTZ&ENH<??7II_=7RR,Y?]\,_E@c=F2
M\0]#HM;U[3WM^SI_C4Y2Uf;0@7+1_FI)\;4FfKY3D,KCCaG?M@=g3GW<>1(Kd&@
F0ggW&Vf-;T^O,O46MKg;(4<<;)IBfT[gW6?Fe]V@[VH>,^Jd]@Q=.b4CS^/c9>1
/AcZc?<c6U031_S:C3XXQF9/;=8/bSc0]0)MV3UC>O[EHY9FeADLWLe0[TAO<PeZ
FE2XPA)0YSbD>,>O?eV/=?8@C5A8]+.O;7S=2[Y-S_0STW817\OC+fPMY5J;+R7R
(A[V=HG;0&b5>ZT+Z-)STT-E57W0(MJ>4c<#UGSf9c,=GBa7a5>Vb9aA7:#FW)Gg
)VIR8FfbQ2^7?VK3aE+2X,2A>/YQ)E)3(J_O6DPT0@gW9[2MFB1WZbH&,=5:)\7M
b6NgTJ@-24e1X7V5SH/=&N<PGD<G[6_TO^M<K];Q:WVLZe#R#(GT\IUP^U06JKf9
2<(.NRa_aLTIe+];()0TFZ_#eTKI0P#L4L+<UXP.R[fGTADHQD=3L1RaVJJR(5<W
O<[_:;6B@GG2Nag2ETVg3@CS&ON,[/HX;5RU\R&f/H43Q:>N9@HcXCI_-RR4Zd)^
85;0<(MY.S#_^:FgWET(f^f@@b36eNfHPb20c#NM\2Q93c#0>HWF/B2cJ]:5,7M^
3PO30f[Y0aNZWN,#f&:AbO9Y7=&;&A9@99c4I(A\I(Z_H^0-E+a0bcNP(98:3cR7
7SOZZ?)SL^:,QXdgD54?6K:PU\18MO5#(XF/)JGZ)_;/S8[A1.7U)Jb5CA@^H5=W
;UP:2+JV0T#T2<W_/ZaB@JOF^)[BQOJ]1Zd;Idcd2cRf9WF]YD=0U+D>#UaH6adA
MJN.GTVR\:HMW=@M17[>9c0TXc#gPG_-Y=e6D.gPL8C4g_-3G8U;UaQ9K+9Rgedg
E/39A&D>#/;_WX3HNa#SPC2SAVS7H>3VOG-8e/75INc>I<?b.eH7dR/H6-0#G<G\
\BUCO8[\e\N.d8(=a7+IRZ>Ece7NYP.B:ZV09[V+YD\fF.4UHE99a/T8ZQ1G5@QS
23E?F0c1f;aHW5\=+POHeE9)]&JOHf6SY-9E/O-E?J5V=OH[:g2D)UYZ)>B^(>2A
/-@>[P[>T6>TFONAfa:>1@MWCD&X=[XFDO(YDP0Hd-04#Y96[.AVWQ5[6C8EYf:1
N(Ca6_\QE<K^Y>[1VaIY8\:.HE/1TCV6?>c?1a-L./NPffYVW@89RUD#F^5.DNUW
<7cC(V9ZWU5?HZX]#.LOCMUN/c8?N1BX(2/.@80\4gC[R#[]#KZa6N^DV7f#WO+;
H-==M-T?A5UW7:LKI<a:b-1\4?O(ae(HU&_HeVE[//LPFDWG(REb)<S<5#E4_53J
RSbOMLC0V,=VBMSf97UOUWR]WNC>H[B6-BGX=2,cX=<A6V1K]dA>cF@:E0HLZY)M
[;RD.4P8@F=]>_^N<LC8^=5eF\cT#LZFG0N[248B<;e@0S760M2W2[J2MROdIZ10
78_9JQM_\],+=]gC=0++F7-=2CMGP3SKVT0dK,SE8dEA)CDLL24?GXEe=1/;92.7
P\=6.(UJ,HL>JLHM(R@8a9JMX[S),_MX03SG2F..:\U6B0>_(.1O4P0g>/_/?3NW
>=&f_4RL&1>C>;_3P_X7Gg]JOI>K&KN,]LG;))^;K+f\^U1(FZKE^ZFH^ZZ[&0<V
T[d.de\a:NQTJ#)#JXa_<M/MOB\<)R6,AKTI\C>KMJ)QBJPe](OW))V2cXRf;df<
dCb79OW4G,3f,O>\P^>dQ_3f>J3?UM:00eEFbBJ0Fe3++8?RT?O,G@+;<3<&7JS7
X:J(Q7@Yee^W<d\98YbT:.<-.g[.;MLRHQ;=)0,#T=Q8(M&&DS^eP<E>A)=]#F22
&K9QN/934I3UQU1QeF@,.?;P@c/d+dUXX9C/:/I?a];=)&OD8EJN\[e7[b?.T+8E
0.HSDYX#F^gG.Hd2=2[T<2C.1d0V>X\ZB5Y17TJ.C,1=FfD3RWB&(63F35/KE)EQ
G.@^Y1Z<gMS^-gMXU1F.Bb#BOR\/9>Q,URQ,P1XEMVL,XgfFc)PV&eB?8RLDQ;=?
g00gBTeI\Wa>EF:Y<O^Z0IVRG<0?+>TPfK-DP)@;L8A)B9+\4054Q&cGF-+0aIKQ
OBf;(e==,-0AdQ_gce7HLI44DWd=YE\548[H7UBL&5Kd7)fOA_T1;?-@\U.L.\Y<
PCV8E,-e>&H4f1G#X<G2:1ROJ2fMG;Bg)V)B5cHe\;?eNQAR(I8IFWa<RI37R74+
B,CO21+/+]D=O415La)>^41Ce:?S#_3L+X.Q5U-RGGb\=,=FUd+NY_4e]OG//U)5
0F48G4F:=d2MPPE8ETG83a7[;M/5,LGEYFGJ=,0(g_\75KdOJI(Y>OG\+1\)5K3]
2-I9S1@B\2B);.S&#0WBgWRXF3VE=d2?cN&#:P)]-B<WU[ZN=Z\#f<TO47O7^.gZ
PEP0/5YO#D:X-0Zc=_c5^FS5>3Qd.\3X<#ZEK:JQW\)74CTL>D,Be4:+:M((CX@+
[MZeF9PITZ8JA)FJT4]f#89N9_WgL6O:T&(E^E1?SDY>ZJLS->H;,9Y28;BGDY02
AE6g/]g01[;L[X#HUL<7a9DH>50NAOT61d_.IK@D<-L2>MUQaG\0PLLMGCa?#70#
FI+K2[H:V8OCN7.G3VPcKQHL]B+eeW/c+_RYb36R^)+KO0d3I8TKA/eJ>:8,B2ME
CGQ&85ZSQ4U5YQ&(F&B.BL<L36.#IB\JA[+G_ZcFaL7M<db(;7DI:f.X?:<=cA_S
41cI_Y9V1<P.]#LeA<aT4Yb#ad3-c5d55P,2],?3D\^=0DC3BSDdb79K=(1L1S&H
4X_VcTfYZWHF8[]\T6DJ#Z9L.LSb.8/EPV:/1+U#92>?])(gcbG6E]ULT9@gHDc3
]FPdMBUWR<-bD@Z[5>]Md75#KOBA\;F.1^1d<XEUFE)@e-R@_J>?ETIT29bP8FI=
LEM#GYVDI<1TT/4#>[==>;J;6&)#1]P]@=)N?&J\HWG4Z3@a]WP]&afGRM8]@-(<
)gY4&.E))MF?4?XELT0@R<\_]=>DZb&1:eR^UP>TQ\4b-&RYIP#G^5VL:1-;Q562
A:Bd,NYYb,fJ7,^NA_Z5_XJ^H2a)\/;HLf<[(V8\^<[Y0@J92/?7&)TagW#9S3eL
=BI0^PgG/<L2WNK?I0>ALc5;[W:\b8+6g43G<5I?0X80_Y=>gd8MB]JP=/^[S@QG
K)=.UCJQP:#=eWT:,cfOcXUdX;^BEZKTD4[e[A]6Q93QL#P-]HZ76Xb94QMP6_5f
(g=Z\D5=2c0Q_2)-U,A2)b41eWUHQ@]gJS:&7B>1W_f#ZWCfBVXXAVGPF)R<<Se(
YAXZP4BAeVO^J7PI1bf?>O3A97Y[8K#;^;&7g,2&25[)VEbQde(WV<8_DZ_O9OXA
M(/T#2-3d4D6&]bO8ZEOd\]OaJc-?CQ@0R+1B5=<G3bB#N_H[GB@;EVEP7UB8eOU
IUEg=X[V&S95G:SVE+_G63&T>2f1VY^ebALNKAHJ<<F@ORGB?&W7H:[WZKM@4;IU
M?7IMCD?83&/:4NM,>QULQcF<JZE4YQbZ<B4;]cMT]@Q>P8G:bKF:d-d7>FVBJAE
\CG@R146T,T96Q2@PI73JGR9c&<?7SC>:7g(Y=0)6-cM=>^^_JdOBNP&)R?X8RTD
[Z:09U4NXK?g;2D(.\e4eB4)^_QL>?^(^-FE&dIRYa+F_F0M=bDV6FRM]C>Ge)C?
ZWI,<2J,M=/Z=KFB,,8SB@Qc?Y_(=gX&(HMGY88T<X[>G5RE>\6/7a&0(ZT:ec#6
GS#WYDD6M<P^4J;7C<7DT3E<d36+HI2RD]YSf6I9+d_Qb#M6HD;LIdA@R-:LQ+BY
>:(KY[Ya&BD0Ad,F]ZGg@ddLIRG;#D3##_bdNgbM]3AY70f,d?1RbG,Y9052ZT,)
Sf;0[M0EXQ::)A<ZOE85b(f8@M1_f_D;X4;ZK<(H-)OSFCeHW6#@EVXU,-4T&CdP
UAUVFFT4G\Jg>f=6A^3Q&5HT#G<O575A_-c/2bY0_2X(7FKS=cL&F>,UM=@9]6d^
D/.N()=bU+bSM&\?;1;\N@4L3:1G=..YK,]KJVR^de_2JSDXa>FVfgAR5]GcDCX)
6dDZF/Af5dNSI;5TN^(EKNdW-H2=V>W6.J>c>+6<Md[BNJTSbW7>Z,fA^0STeTYO
dOHRK/G:-5L+MaLgeG;E/HfY94+9F3c6WUHZ)&F=>@1cZ8Q^S1gd)DdP4Pe6UeDc
3@P[5S0B+5\?)G:^=fS+[&(K\W4EG>+&2BJQ_2--D_2dLa4^7#97C&7<9f:SGSNT
NHZO+3#+B<YfY0:Q62a?Zf&[[INN\99a0#,gAKYSPUT9.V7+=A<;cU<.VgN4;7IX
,.d+fAP\A&LD<:)J.O[JO61X8<B,G(U0cD-_8<7,53IWL0]E#J7M)F:dYJ_60XIQ
cUc-@]9?Xg6PJ2>PI7)U(JQcQ[A<FCdBY(gb]R=,:[B3_a)E#g^CO9b7);BK.?d\
BZH&S+2UMW#@8]fR,#S:/bDI&M)=YIW[FVdbY4+9V5:UA/B0f.?afPVMfP5^.Lb<
@_>.>\9eQN5.H[H6J9O8^2ZHbRK=2^\(<-75-V(b1J9\Y4?PDM3;G&T?W7+,R]ZH
@1KaT-bB.:3X]KFTb:e1c?<=_G9,Pb-D35FU\VYJ/NbY[I>8gEb[1==(Ga(UTcUJ
Y4+XVg_S_&[#bQ<G2K9c&U-^2YL?:)GWbYf&5<K1:V;+#(RcH7ODCPdd)F-IX7F9
^OETfcD7:aCSZCYL7#:P,9E3gZ?JH=98A]TCe;g=T22JBHaN0]cC-XBLZa=N=b[1
fK?,#N^(4bC5dT<UHTO6+<3E;0b&1<4I2LJ\W>?-Y0X7^7W23P<Yd]R3.2WT@MCH
JUdD(5YI5SULJ9XQ:PBK1K9914>/NdSVgV?GX04e44/JLBW615_ZBa8[f;cE&T1^
J]4K^C\^be&#=Z.LabDbb/BWF^fP\]Y@(U73VRRFdL]9[632#T,M/QWL]4[b,4#6
C/W_gB\=gabAQ0RdDNC=Z5fR69gc-J>20\fZ@\:0C_@AXgA&]>=\R\FNO2gg&T1[
.VNe=E/Sd.;A7._8-6<;)YTgT8[^8T7a9f46g:YIHV7.5ROHBPM4SLTTO&\>D\Z6
R&aUL)3NUde8#TDM[6WIJG/5]-5ODa?B&.#\&3NUSY3dNK\-eg]1P5bUII)2^)&0
L4RcC\[dD<0cT:cP],Cc,a;gC_S1,J1:95bR:X\6&;=J7F-b2b5FLW#X4Z^>,DYe
WKNSBeF8,428.;NgBE.^V0,E-<282)@=S_HCLDCJ];CMF)S9;GZ;f2?4_XQV;5dc
.;ZK?d3&C2]\3IE>X8&,G8,cTeJ>A&G:W0BGZ2WWb0ZAegU&C7]HF>5N/KMK\4PP
YKd+G8/W#Z+;B:DQ]@GRX,c[LbbJSbS+V=&Y\#fYXY)2PF1dA[a=c^IU?e?WV1@4
cL/0D.-<W_=:/b4@W.c>9+_UZg3Je00X_7/((@,-BY0Pe(0VD@T\P]X?<c])SbSR
SM(c&d+Kf7;M>G3W>5gD;=]))HAg>0O;TdDf5RQCJ:W2KOf,=,H(91NKH]H_cHI(
F5;?,W_1e^):B1(O=@H\<cI;YV4c/3dSIaI_1NLU3].RfP3#BR1\KWT1M=Ggdf#[
a366&81P^,7;R1Q2CB,4?)]O[T99AUVTW@.BfJfPJ,WFX1L)93:0[\QS=0dY2X1O
W7I4A2)D7ee58-24>N9b@gf>6V>X(BDb[?Ab=g9)@D9VcSISW@eB4@9CgaQ:+1_P
=A(U(TSZ]G2U[IQ2#.e5Z0N8-Ga@/ZO,6^Qd(+PON>0O[9OUFd]CV>Q?^U0P.5_=
K>WL5eJ06&BHQXBf7UFR@d[]NX6\b,-6W)Ic]#LY?36M6(^ON:=.#_UM\Y28(4#R
aOQ<OYLWN2L&[&J;3g-T/eDIM))&S^E#Z5D-8:24c@Ha>AGU&YIOQUMP[^/Z&ACT
HQ:J9Ca&\2XSaC=;W2eX0NF9\F&J.c>5O<->f+=S2f4878A3H_aES,e_d4b86d.d
S3A7agbBC]G1IU&4_?,WVVf3cg/<T6dNL/V:YI56EL;\6MXE;V<P3D(4<SB&@MTS
];7;3<PHVHO8WRTA2cTF<RNAdMW?,:e<@N/5SKAcHN4Ag^>_@&/H>S2]VRC8,_ZG
?K];M+c=<WDQQAW>_Dbb7]LSOf3c(bG9@I\X.4X+29\(H:M(O533AP,FYVNYE=a=
Q0G.DD>Sc^.I3E]&b9U.?7[YGI1+B_U<DTcZ=SD;fUPH<>Gg]dA57)f^<2B?S/:&
N;c_FR.X.AbANKfE<[@W=d3/K\=G>eEVbfM7/=6dN(G0e/:A2M^]@YVG62U?B.15
6L\PU5]f50QE#>]79HUG]G13T7C<&3gRA-RFRAB=e5#H0]OQ,V<((56H#c^U\:=F
fLf,=H-(cA\-8L8G]daNbVFXVFcNfF9JATGfb&RG3dDb^V^S_N_gRf.E^RUIdFXP
\_MRTa&6B>@C><#C3<,BSUWXV=HcUdR+IgeC@X>e_A_Z])T+UQfV,SI8(#aFAT9I
_>ZCCGD;GU2OR&XK8AH[VPREJ?RY5K=6PDS3XG96\=KHTE-?+8R.fe910?8C+Y?A
7+)]30/R5V#gEc(2=TXTfA=^cIM\?C<>fVELJPgJ5<UEbe)+7K)?]K.)2EM>/O]T
N-KRKfbL)U:Sfed,@DgX1VOR20=A?g2B1\N)\J/2^[IJB-8g[R?SeF>_Eb47K=MS
ZLf/PV1c?)X?JA;UGXR=>TMS@E9f-97/c3>f,5>>DE/S00L)ROM,/]b6K995eX9A
\^#S]7\QRD9g9B8+,7WPJPW/a\>AQ>L0\CX-B=eV[X)VO=]M:K7O/1daTFCZJcT[
6H:b9XR8YTEQE;U:-.87XLd&,7aX1;5B3f94[9O-@e=@NFNg,:[BGJ\KJBK?<5L?
F+]eJ669aH@6\)EB^e=f.UQ5#1E.,9c)PACPLa[@HQU>Md\K<7-FI-BcJ4Af@ZNO
C<@:E1VN\3[/cNHbM>KH40O1G]a:_]c7W^7_^Mc[)eKZ-[J.LaLW7cONdQ8d-@&M
L6ef+Ug6D[D^JG2g;2Z=GEM=1<De3W3<fW=@#JW(I&JH(B>S2+.SDfE68R]]?VW7
]HH>[EM(eb&1\.gI;9]/1&aVb=+gF/BMebD?e/88^_O<FRGAa]>#VR+O<a[bBP<K
_aY+&C]E1-I^,O8,PE@gW95CPFL>#L?6X]O.9b@]?A#9P<70-NVMPOQWK>DTdP=D
d+WQ,a.]O-6TBH@F&WTfR=+Db#)V:_\[1:4fBN)1G.Ig@<eWa(^\HN37,eWI[56e
1be#?8dAI\:a>(#f7[3JdA6[@beAY=M4G7f18]@F<YX38K(_.N:6XH#YS3<U5,Mb
37&A1X;IVD6X4cg&Dc&B_b@G6=WUQR\W/N^M_fH+Mbf=#IILI,]M@ORQ0K3.8/,W
Z2\W>7-W]6@4PO/33#1g<P/A\Q\\GVIG.842Eb7I-((S0Z\&.[LOc2dc8^(>7^[N
GdWb/D[@M8GE:L5I5Q1@#0>&PbQ_T02FJ5_Rb^AdH>EUTfS;Wd?ReAc-TN/aK08G
b6K?Y:?SIQ/JLATcc<QW+805Q6AF/+b^5Jg_H#JeJgZ/T1BY7+K_;g6)(;WO0_SO
ZCEfCP-W?+MHNIESW.#70_#GRd_(->P>I<cfQ,[;XgaKF)YCD6UU/QM;G.6FKG;d
aL\U;F@>/3:Y,(G>56ISY#?b(]X#eG#(&MeIA6Ld<<=?4@BeMf+L(#+Y.c[4B=21
gL_Q-W;TJR#\4+^bSK.Hf0TaD;H2@9TY4WV?:UQfYeIa&f&@L)(P:J71O8_P\McZ
>bNP7ZS5fUVD(,K;HIV2;M/Ua2=<[WH7_=F\DS(]_Y@OFGB(O)0UZ4ECcE?B=b+_
9Hf;EICdHOZa/(7)-(AHU]4e=?fZ.dDG63VWLIT<V<4LIY.Ff;-\K=/daVBQYKeU
88\c-,1FfKT3f;b5P7HcPA]cW\g1AOd)#5.6J=5[JT3/\Z=A,e8\03]E,;B<<NG4
JHX:_HDSQZ=P46YJ>^03_TbY&>JI[IZ>\E^R_X=J<_++^1^d;VIPP.#)##@V_BIg
fKE_4QMDOW_6B_b7@\<b/c.7f3Z<HFQW#6d/3Y(=\4G6&9d(7K\FW,;NcK)0b.:a
AQHT1KT21[)TV2^9]#[<6G]1#f#5IJN.I+]Zb-O6)/Ac,PDOP0>M46;_Ma3&fA74
9HA)AgF-?I&,2Z(-PS>cg;IT3(C7))7\C#QPGF=YaAcQ0](.O(4@SYV,DQKA4@Ca
)F8.Y71W]2_J4.F1e<RAK;e+-<aS3Y:M.V3@P?B?dM#RBWfQI,8^3THBKRYS5>(T
b0=M\2#(,-,gT&_<58?C51:gP,f(g3e-QI+Xd1@;[5C.F>c6:8@1M0^BG^^+gcbB
TPV]UIMPXPRNYe\;IOIXYD&==fMDB)/EVIF/NBQSP\9HW-UB[4FJX(&(WQPLO9OU
.T(8+#Q(IGKN+U>C9N]?Q\>DJ:Q\Oce6O(-7ZU,^EW@0T=ggS6cGdM^EbP2DCRG>
(6WDBa)I(:WUN99c4OH,MZ36JH;C4G,L-[Ya1eQ273X^G9CHQ)/WcB+RR8@Y;<K@
CF1C,dY,5P6WW[0Fa>B&M?PGe?_SZ9^;<#<)c^^K/BK,a6]?b0=Bc:JOA-IJ:O)<
9G0JCZe]+)M29]PfEV.)#9Q:g]^9P.=GL)VF&g5F5Hf-M,T5ANLC0TXHBJG=MbU7
KMc[Q##KOEPdP=GW3N+4&Z:>;2]Se:VR32VJH6]<&]61RPab45cVfYFe880REaQH
G8Q(GQ4?6\9-fg\VfQgT4f-;2abJcHY864.W4^/7Gg1fC]g;,UD#b:g.bKDg5+]c
&8)3JE?\A2(<<;EY52bH)B;8Q\AX2ZW7a1,/.H\V-6D1UF:(J;a4TGS1:7@XE&f4
(&e5+KY]G6K<<_/<,3IbGF\<X(M5N-Qa.:.7JFGgOVJ;&3V2a+^BCDdYUL(ECZ]W
P/MW=46W[8=a68-b,-@A4;7IH+D)[T-DYS;A?>:P]-P?64/[,X>&-d&KMA&A\2-I
f_4PU.b-+U0J9X5>=&QKRXIH^^03]ScC53.<?I@1:<U^9KX17KX[]LJ:(NZFYM87
>eAD=1.b<U]g;Ngd2]=9RfP?5O5&bRW_Zf8?F;/W#@32)AX,a)08&V,#\R)\a;1J
c?b?Q&<\XJ+KdPScF.?EfH31OC<2V6c,R+0)E16VN#]P;3UI#ZIe&=@@]^Q\SY#G
9+4@34]]X[G=4[dX>a]P?[3F42CYH2.d^(0+QO.[:/C1R.b5C<,:(;QBEA(QLU7(
5f;Pd,@V,Wc/X4WBZLF(d9M#<gNGe:f<:3Yf<IPH@eUH4;TDY3M;\D:eHDLU@>E\
QdG7:MbSUB<T2,E@T;8V>N?J>H\.Pc]G6B5NQ9/4P,A4d3TfeU#FS9EA>U8;W?Fe
dI/?)(&,>LPddW71X7<3&A\1a<]-JEM#2W>9,JQPE99WWNf<26^+,.WE0)9&(?B)
=#7P3Q3OAR<_,PWY:,B;Sda:2S=5-D:K\cLUE<N3.&7A]A2e6a+?FBPV[_GV^<Xc
G+@S:]W)Qd,Y=UD3A^H+IF:KZ+7O+T:NANf:QaH4&Q#NUDG:SN+Idd&d7?M_)]PK
RKCDe?7L)H0>#&4N]W;7RUaNL4O5Xc]<\;TQ>PX_U.E?fD=I0KRc=,F\8aGJRg?G
Seff2NG6(>:5O^7QE0PUW?WJ>[Y\,ec09:4UUWPQ91UH?+_Kf+3Y+H27?JWe<OA=
#;XE1.OJ6bSH)M:)KZQE,.W^;=5S792Yc35b6g7L=cc3)eRc.e?AL+B](0a@[+a,
NX^eJ5ZT<UI_O^Q^\,=J1.G1P0b1d\C(e_D)EG^=35Hg1_3>_cQ[;T\aE8D&e?YB
N<D(Kf&)8SFPG;V5WHVbS@CffHNe)DV_F94Z:d#_GUE1WHF6/9?;9Ff4\LfR)SdJ
W\#.#-[gEcE_@0J8.:fd_SY-/\FOD)&OIP[>0WD@<BSCOJ6LJ:>.CF22]:GV70,(
AT^=/cQ?6KP.8T^K\C]MQ8bZL.E7O5F/+KR-LG?Lfbd9J1a^&bDEI.()7Ta[]GW1
f/059ST,PQE^KYM5&DeM3g#D6);73B]-_Yd.(a30+57gg<Pb-f9=YX]PB\R>.,1(
#9eF=)\J=,ZKD139[LG.4VNAXPeYcT@3e8]7@E#L+Pb2KH^4A+fUEc?[;#7.ZJRX
0dNXA[DJ.N7G8\fb^ESDI>3,JN-#G:;<RF<cX6:;9->:O#E.T<F]K&Z-U7UV1C5,
:7M_Z@VbYBH?WH,H&b,XeW;Sa8=WJ3Zc@3a0?B6aN<G[0/X8\))WU@H=J3WN:b&2
)].B4N^74IcWPJY<JccM/N/2)Yaag7\C_e,C.Q98]Qb##XB^AQXD\TVO3b0)?8_L
6Ae5?@KC,(#W(2=]8),^Va_fO?7fKI8F9]W7]M^RLTZ<+H_L\@9FWFdAR3c^.;^4
fWg6O#^e(XXG@DD#c&]Y=:g/Z31Q6[MEaM02)]eW29^]UfQ8@\=?JBS\RT:KCffC
,4M.-F<6TKT/aK)1,M,T7T0S]-)EgV6U]XR1E0D-bO-ZTa]+aASG^BfPbRea0-_]
U>/g1LTG^_.7Te6353R10G3OBI:)WH?YW:5bSB_<C04Mb<PaD3+([F#Fb4H\;D<K
G#/.Rca>e+MO3-D3:K,T\VcEKJE8g4OZTWOAK>9=]DYMB(aZ?E6YI67L]NHWB,3A
;]<2\DNcR1PgVW[34.:K?WWWXY5=_e#bTDB\B=g#0D9QX_JPGG(+TR\UGDa3:?_C
[<X-GU]Y#&>dAT0O>VP-VRUggZ6])>_eZ^=YTDHVHU=Ie:T-]90fB&<RC+;2-_]7
1RL9WcL;Sb+?RR7g9MXEHRGD\TZ\N7&IA6e(g&2((^KB5<K?R(MVGW;R@UaUMHfG
EMJ9/M3&8WN9W[Ncab?)5^S^9SS84[(BN6,_G51-?CHQA];]/GIUD_GL@=cR0\]^
(([)G]9:2@f=]2OQe2-+F3AE=?8bY\cMCWOgHC(9:+N^6/P1W3UJ-@78B]#[)52b
,@G[f;QT.[9RgaUW55AeM.)=4;_)X^a#eEXOe5._HK]ZZ]dBDTVO5C4;SL&CY7UM
X8b&4PATCVgZC5^ZAgAL;BX\2@WUD,8.c3QI<P7c9A9LQa[U\3]9AcVcV=OX6#:?
]3C00.\2+X/^+JU?K^5FMg.0ESJd&:D4O.>AX4NWIW;Y_d)GLLfY/4Ag1+eLPgFI
KL\4C&[f[Z=IfG?)ZOB=HFCX=geHZ:IVg?<A?)8U9a:JTJ0EYL20L2XA.D8&-K#5
^:=BBe(+P+^I\&9,bDbX&YRg-aZ:Y:PNX86(cP7&5.J&D8?N7<Q;<2&A(f:OPA>U
W]XbHJWF)@CZR?ECebX4,,94O3ZDUc&OT:G9+(fJA_IQT;JFd>+6G:9@a06,N-8c
eD\c\#=Y-T),/M-.G/J1H1^Tb64\OeOOS.?e0#f=:F)T5P6M&-2G&gD7X@EHVQH,
8c1Q1WJ5TCLMT->C:H[c8]H2JO2^O=WFA&3)+-Rf8PH[KFP0+D-\ed[?W)H(3@e)
925A9_SI0;[>N2_>N0ag:3;=\X=FDa?.3B(&d_,W/]]B#;AKb<QHX^RHJM6eOS<a
2EY8&WO+e:^=7Q(-:B-L#X&a,8B=D9W\ZD8_7EYYc]fKX7I=8b;0+MPL0c0GP<W:
?Q)K#5a.;UgFS]Ga<+_-J]07/3QOEEDRH[adQaA#T-F8.6<YZO?>IQRf/?93O76C
GgD7b&d;WT6=(S0F;bBf;P-@/NP@[-\E:C<?c;C:dX?IPdR-VfJ#dMV&38C0<(N_
-927OUT&-=Tf<:DCVY0RX5EXd(c0W5UeLHcg:?g&I(UOG2U,Q/)3CI(&9,@QOfYW
,Q/O.SKf;+eNe_.@b=A)?@]]MA1\ONP1\1RKL\&6_XdR<:a;01MG4NEF[e_:4L.5
YAe#E9GM?NZA3>-cS:^O^C8+_^YV;.+KP/9c7QF>112G>UOOFe;99A@D@(LAK>b7
9f595QTBB4BCD8L0)JT,5F\##[fO=1(QI0?U8)V1J;8ER^VB>TOI36L3QYdB_NQH
;a=]c.2EUH[\Ie+.<IcQ?+M[#VMX1SL\DYCJAVcP?[A#8?&55U&#J&:Z,&XAE=eE
/VA/-/FCADeTPNQ.4S2<2Ld)5T/B#BIgY#3?/UTSBC[8C_eJM-8AT5cK+[W\T4/N
ZbNbGU-IE-A-[-L<c<=\^+(YNQ^e\F:YJT=c:,0+<Q0?<7CZdfL=J/KT9=T&U23I
2&9X?\5_Q#T&+?ZA5/d;5Z\e;b5^EWO/IcBNbc1BT15ZEI[-P\IJG\b.53bO=\,a
GfHR51d)NLIe0NWAbZ#SKFJQb1<:KP;LX=U_cTeUM,K<=69[N(9@A#^E8adeJ#Ta
/&f#U0]NP8eg]C<bEN^1^<ES8Z<M<@fbPRYND+AeBCM;aTPIIb.ANe:+K=A=8bg\
aT(Z:T&O2gQP5OMg1G7TE[SLXf8E1S(8Wd?;2P88;S<#_cXF0C]XNa,Y@,+9_3O;
[?.S-H;EZYf>.WQ&MLMG>_U3<d\2M8K[K:VL_,@@_@WUfIffY-NOG;&XO1=b_617
gJ,J2U)Hff@C9Z:[U\+0UbQ1T6B3I;::[O_\A&#JW,0bV9/+Sda8GJ93YYY=8)/?
<?H\47K]=<:/a=5#<ePOP/H;#?ZcbSJXVBY_OV09[VB;RD9cW,V=>TE)9S8&7]-I
MRG))4N4ES.1F]F5>JLf:dRU.:\3C9/R1NY>13,6004e27&[Z>:NCg<>M;F.5/C]
9)Na_@c7)AH@Z1^\SF.PW9RV0#GaN]SAVe4>MKG)8_?g@I+#Z1&:^1PecW\d>,M+
^GQ-:9J5QF[W7CR?:WM_3@G6V_ZbcU,FV#VNM?5Z?\.,JfMSOEK8.A@\@U@FX4&F
A-NNDa41]V9dI9@NNa>9GG+X+W.XR)L&10)-\Fc6SC\&8ReF_9=NWYJR.ZNXPQ,B
-JQ._1:Z:82&&^;T;]U5fG;#c77GY:f^((9EVdU:+^\,]W,;-10PKf0T2ZCJY2Ye
4Uc@cTV+8P-d^,A]aKPCL3=Af\C+c&A)==,@OTf;]?DO50E?5Rb:,e58,M0K6+G/
^N3?F?8(AUS=PP4\KLBN4@V_F@=S.=NGcZTK2SS2Y\@UY-V&:Se@^GZeUeK\=709
6(.^6a?Qc+:]<^#HF:WM<+f072:J_:Y\\_4U:U+be?>&CM((H//LdKV0\g&9WA4+
]=?O/(32#)RfeNFa</&Ng42cP&b<0dgP^_c07RAP#,WNYXCUcg\7Wf\^D)_f6SIS
D,d]C6I82Ld-L-2XJG<C^J4DcFMI)BG/849=;9PN.4IdSB7E6<gOMH.A26#P):R:
K_ZaL3f-F38>7ccY5#FAL9CA5IRG5IN4.KV)bBOe:eY]B2HE;JfPI+^G)3RBC.Ye
65dTXLDZ82gH1L:NNGbIbRK[AGZA6Q<WX/>.?JU@c<4/bdYY1=,JWeJ;^<FYd.Ya
c\P<<O\e(W;\FJ?Z@)_B<4?^T-EJJRK86RZ^;aC/dCD8:,[We&;^A+dQ<K2]f3fP
@e@^4?ef3+IX5<eB+^YQ[?F9T9K9ADOJB9U>=?C7:ZQ)DGY?XZ.NL]PG1R?ZN^22
ceg>VaPE6WX/5g@2d+9=<=gQP#B?Z:.]HV\^GE[K(OM,3=4G85VJSE0^/-CTC(IQ
TdJY92+>75[aKU(:?8[43R.Sdg5?=eeN1++?C--+2H1+DH?^88QdXJ(XW#I_cdH3
.(K&#Z/+c#68UaHPC;OHXTK<:3U8[:^:?4(0dGDFb,HVd_aI@4W]H7\S[\K;g+BW
OKC)Da2?J?aCNI2J9#aRGbQE>]VXI<Gc<(UEMLVE;XP7:FH.UZW_R8aYBa6DQVg=
S,]^&4Q9b\^R7L+a=GF9S#YGX2C.[-[H.[;a==\Rg?;Q]52U0;:4CYC302G8M+3,
I)BQHcEWBZNO.6gU78/G[d[/KN6T1-P+-5X9W(EIFdQgQNB3[<a-)ga+DLC&@)[a
_>H[Z6UEF2A=X:;ED0?&8a-R0:&\HZ_7g&NFHIIADe50O.Z>)1.0]5\>^P(KQKME
&/2)REQWH8L5Ae.HHUA<]WSDKY9(]&@08:09d(Z/Tc7N/]?+g)>G1e6<Z9FS^AQ&
2Z>cWJMX.\C6H:-Qb?GXfb^-L)/DM\Ed[a-SSW,K?8+J.D8a).&\GN]^H=)K#cIT
_7>L?^J^^Q9TaaK/(7e2H4R-RSQCaK@8+O[f1>Z[SK(]2[]Z#ZM+8OK)CeDedI+N
FeYXf=RgQ[J:BA:gdIJXY4BW<8L_4<(^dF][5I+P<dT\=L3WE1@<IT,.=\L\^a?2
TgC5&VX=FY^/@_Za-&P240?_[J9I4bO24.>OLc46O/ZW=5;(S2DQYTK@0&=aefV6
VJ=#13egQ;,P0Q:U65W)cC,:1NFCRO.KfGWN(L[I<ZRVN&I0CdE:Rb2(<9[AZdV&
48-.Y.Y_QOE/TfAbB_++TJ]^>U/B/-B/U@EQGSfb#6Te2H0_G;e,#W8NQ;;eR502
5ZD6ER=?G(G@b5W.?>C@(.>]0[_K&LOF.b4)>E>LE\R07[M)a=L8SZWNM/ZFMV^B
.fLA-0D[YY\1U.2.ELN_W[_M^]A80KN1NRZd:@/4X:[05W\)A[]^/d?a+O=^]PXE
=PZW&&&[-PBTd4=LT=<PF5D2;#[c1]^;a^740B+Q)3.69W;\T^A/7&8_gcZO/N/f
:12:ACA?\N/19ISH6OeA&cL88TWT8I-R.B82R_gDF1U=[Yd5cA)[81ES\0NJQ#-?
YDXaJBD<_Ge5.A^J7CdJ@XIB\F]R?Y6GX;=CUUB9b(BOTD#FOfFT83G4?e73RU);
3.B;<(f]e?<F03>+_f0RV.?WB;0L)-&b)V5XA(#631VB4bDUNd+TZ7=U(5GG53CX
V@)F54P\\Zg_d0N#19fDYfZ^?>K;]Y<F574J<2(BS(TB:YK>3g/f82?;?TSR]J+O
1QbIBE6EeNa.1:42c0^(HF?ZYH+bP6SA;^U&7V]FV]RWO.Gc@eHQMQ0f43(f(:>E
[\g@:0?-D83GeG.,_0bGAUdaD8TN77N2W9XQ?UKPB5[YaO,b//C-afZ>f)_eERP2
657UPbN,USVe1E5MNKO1^4.B0FV\+:?NV^+1.aH&[D;+7&.PUgUfK6-N7U[B4TNd
V<O?O&:@H5O()42LBFHMEcFZePS&P(dM9[_5M/\2(W.<5EQI.M>L^N2Q8=6XW8Ta
SAMN2[ATX89Z7[Z0PQN:5NFZ3$
`endprotected


`endif // GUARD_SVT_UART_TXRX_AGENT_SV

