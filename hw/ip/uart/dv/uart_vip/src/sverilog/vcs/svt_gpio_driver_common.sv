//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_DRIVER_COMMON_SV

/** @cond PRIVATE */
typedef class svt_gpio_driver;
typedef class svt_gpio_driver_callback;

class svt_gpio_driver_common;

  svt_gpio_driver driver;
  `SVT_XVM(report_object) reporter;
//svt_vcs_lic_vip_protect
`protected
L-><8<NQF=^\/=<5XO@<Hb+^L^g&4aDS;<1-CQcOcD?.I)NSa&N]1(R[Ja:2F535
\1VM2Wf@gWN+Y.:0[agRYMCeGIZ&+I]Z0\>N@7,,7?DBd3A@?QN7X\]Z/CQ-5,<a
/#dT<c/[d6W:D)?(RYC94b>8-T7aCTZ:PU+)I?92SGKBE$
`endprotected


  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Agent configuration */
  protected svt_gpio_configuration m_cfg;
  
`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /** VIP virtual interface */
  protected svt_gpio_vif m_vif;
`endif

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  int unsigned n_iclk_since_dut_reset;
  int unsigned n_iclk_since_dut_unreset;
  int unsigned n_iclk_since_last_interrupt;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new instance of this class
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param xactor Transactor instance that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param driver that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task main();

  /** Initialize driver */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
3T]eEP91OfNW^[_RDB;BUb;J[Z3^,:_IP-XZ58ee4D):>VaT[Ze2&(MfTOe9C)#K
]bLa>C/,WC?Ee-<#,?E=A=U<?I>XV-,Ufd;654-\,PI67K@[O)f<<A&5R46.fPRV
<>Of5F>JDBL=?/\;I,:N]^+JRY-<X&7#G-;V3>[^EfKX-5K?SIaP\d:6KO2eN:C3
_)7&P9CUWM[S;3?a3:<;M=;B=?2VCPLEANK4UgIAJeIJge(4HBK7RW4(DII).XPc
:T172VKd>8UH?P\WC3^+f[cPAU;bRM?BSSRAH2451./<UbJLVHdNe[P=L=[)[2)G
NAV0EJCI543MX@IbH[#-bKedP\MIEd]MV>f&gPHgS)YFGfZDgMe7C(EYCf.&aU;<
C+\)JEYX6;45SOM-(RJR6/6c;b9WCE##CSeLILO5N(MTe\J&YK3bE2S+L6)\b,3R
(VOD+<5YML0:^KU_#1V5\?T(G+,baF_GAY0[DL6Q1:]T]:V?TP;P<Rd0EUd#?aZZ
:D9:cJUE).?OOS#-A&GN@2DVGZ(UQ:\^<.,F^_:_aa>]T[@C,,4Vgc@I<]2<]dS@
2\VJ4[DP0dJ9HD&06QS2W^()_^\7LH/I::ZZSJ9F_Z/S2;9cIO+DD3\D173(0^#^
EAcfEOaLe.,NX8NE?_Z5SMAW^K_C2-V9C;fIMeO03\JdOSJL#edSSEA7e4T=T:M-
b(YIE7+]/MD]53.4Zf0;V3ZcPQ[0ISQ&IT9aPA&eY_?.I:.S-:UF?#U?.(F9W3V+
d=B<fK.:;5fLb723//D<PE[FO(J<D_L\-ELZPU&62fIX&a,^Z6ROcN7KIWS?,37:
5_0CZ,c\bJVLB:f)5<#8^WS9>N(/1-@D_2KM7HSab2,0O<@3X1-(H_#<COa[]b;)
QPEMR4L8O-DIBLO&?_QaeSURWXEJ_4d9K9g63g>_@]X_Z,P8(GCN<fDVcdga,c\9
3#V.AY;V-0f@TZE_R:C_-R/[E9CP61;Y<g,=c<FG45L2DPbYE&1.c/,CDdG0TII.
a;#?+9^#Z=(eAK:?d2@23cTY/),::GR8>_E\9ID6\,GXIQTDB/S_)AVc0BDOb-e;
]B+++/eWT1Y.:F#CMbX3?Q>17C)3?-U7OL)>I,&_:<(=da9&K_7J_b2&UXUO2bGG
XBM8T+5_>T>JA?M))\E&5-d.=U;SQM&B\VE9\_TJ(LMeQ?+?bF@W#T[KgNVHYZaU
PECN,W)8K;d-DfC(7UOUgA8G:9+LJO>+(DNT#8)55#&P@79@YG-LQ[LUMB7DM#X>
[JFV=FB=GC(>ZNIN>)F5JYW<>AGdd3GK[U.K@gDH.11A9e,M6_\OT4bZ#4,T8eWW
RJ+FbHH5ZDbE<GdWULZ@Y@d)1\VJ[YZTI;H_QJ>5+?#Q+.65K-(#9.M-?4a6KGJU
(TEeWAfQH0,f24(3eGJ&I_,TIaJ72LC^T+=87JN8ZeaffR9]_J9/#/JQAI,+0,;e
>KBeWWE4@>2f,1E/c-ac_NW+R5fJ5WKT.YVO?NU.9#J4_VLCP]a\+BMSZ)(.)A?d
E\KYOgb[_ZVKTE?M&]SJ0_9@M\DH/DMgLc)aM+2]e#18MU+c-1CASLY^;ab,++:<
ILJ[Yd=DDQO(I4:N6[8D01L[(8ebWaEJ,]DG\db&WB#fRJ+G?E8(]J)^E^_68J(8
@Pg-JT,g<V)9Y,+9H8f;,eZZTQWL#Z(^0dN0&&AWcaTD8HW;fRV&e6-5(YAN4D.?
dHUTF-/7<]&#PJ93eMZe&[1L/(Rg[9+=f\:()CPbDH&SG5A&N\0A(=0EW/H?]P<P
LTR@;@=VMKV?:K#WHbB[?dL0Z:[L_c.ad1C&f7Cb2?cR#P2K?)M9g>/.SXUVObHf
I-89NY]6+O7P\.ZLOS/B_9)EdE=RSa6B\ZWeNaP#6SH,d<AT]PK0_48W]Qb-ZQN+
OUMU607f&&_]J0>7_V#b\W4+<0&c^QRe2M..Yc3EW:d6=H77T?3V)Ja(ZSd5d^ZV
WN899cD@8^TQ#Me?>,fNdQBRL@;J,JbQU5SB<02?SB((6UPC4A,G,77>I73&Tg/F
Y8/S=:Ff/3&gd09/BY>2_AF.4M252)DO^HA^aWfaBM:JL?4SSS=E&[>\;S<GbQ=a
Hf7SA^905C1./>]L/YZQK\KaH_K<&S64<=>e#EP_-E&6dQGAO75FN9Q-Y6;]I#g3
SD+CL1DU427Z9<<R0gX,)-bEd>4E3DTV?0)URLANN&2VDcM_fCS-V<:^\(I7,AX>
R\,^4U<Ug5.=e,\H6I7T>D0<7T,\^MIMOLZS51#bJ5N[(NXc?dU@2;(R=(aD@0#O
D:e3da\9gK9)dCM0P5gaS7?A7b23eGB()DWbDLL(RFg59^Z_-J<8^)JLV9MI)]N+
J9CTWbQb/C3[b2RW(\UOLCRT-dYLfY8.XP8MZb7:E^>4fMR_ADTQ/bDLGL,eYa=-
/Jb,?M:M,3WbXLH](NB<BcH.4U;LDB9f.8XF;R]M+58_f\V,PPYbK,./&/8([L5;
#?MJMV16W,EQ,WV1_&Fg-M<:+BgRcD8+b.(K=2R4(46eS__Q]27FT+28V&JROVO.
fLYR=A&@_I#E--;6YLL^=V_?bE]d:-J(:#T#I:bGM;M^-;a/,9_7-1=<;-IE#?7R
gI>3;;2IFe?F,@_3aV=I?^_><1=QOU6X[,C^-[?LOeJ=RTCeVV<Y?PDB/D89Gg[[
0.0.?XbLON4XcR7J&(gf^230DAO62AFOg#U)3]?ae;RCa]@S)Q.#d^7+PRC]\cRb
14M5^BK0,9N48=(AV-:ge8ZH9VE&X(<LM?C9K24=KM8V_)NJNWSSH^3H#QXV&T>X
,4]>18aa1Z;EBW),@E:E]b#6&eUYJ\^FVYd._E5]bfQ?#_-U+D6a@Z9;UX1d.1.Y
5e2X_&a1:UW+8/,d[^P@.c0<L<D.U:(.@^A@\I<#b7:YVH+,)6UHIK(XGBRHJ7Q[
/0XN.[g;@C5)Wd63HD8#a<,d71Dc:TIXcfbWTEYETS8MQ6UQ/_]@8Me1a4TFe7Y-
2/3Z@\:U>UL4d&)KJ:WE:?_)c]ONKPG9.2NY)N&,e?3W/\Sb@<O]46P2b(>71GQW
WDC_.[FJ7ggN-+@f[dbG:-N?M:9a-YHbWQ0YAB&I<9SA=(2(@2<bKBO?CIGDWb=B
>6XYL85II\dZ::E<J/ADM4R&cagJ#IAAg/H.L]3&^U\gTE];^J@08^/3=(gDMIHa
d)d9&R@OMWG[M_^/:X.AB\/BY[2eO>CIGYSb:MfUadXTL-DE/H&:]U18/P;B2#X2
d,Taf\X93KC?#bgc4:_D]PRUSe+EX7P@aSNMJYQc=/(-R1ABEF\TZ.^=1Q7.50DS
TPX#f<SfI:3GcI_22K+>PB20.QL@9?4BRK0\B]3@a9gE)2GBF)-@TZB/?(]Q;PN9
NebRgg(:E^&71W(;;eDfQcR,_a_F5GKDO-bGb4_a>g;6>>W885>?)3V]d@0e5HP.
/)TcV<3NMV^HP:(>MA9cP>f@FZ&M[^)@?c++[F0Qd+AH@GaVV/KZZ]>)>>;-:>B7
+K@NfO5c&4+BOGOfL/Q@F=S[KZ(Jc>M9eab6SI<;dAMTf2D7N);.A.ZB@;:-CIa3
(.9[S]VAC\=d2U7>Ye.TC::X@V1G0Z^aYBN:E\I6@&@MOM^QFPMX=AQ;IMENg8M>
)b:4.;g?TBNBHOT;SAd?,U7B;O=cLE6Bd@,M.N-@W)OH+_HV[Q,2][F#)P5TJ?d(
VDe1,E=BM^fPg<37e,a\#N#ZT]cdD@beCX^+&[?G?=[f;[Bb@66_.aK&71GcdA:\
(/bd^:1Z/8^#M\<f:A&SE[=B#:P+@Z;S.FeDZYc4(<(-QY#V3ITfe7NIRY5\:#,c
4YT4a^7\EW29/PZM>UF4U?65ZbcBEB561+_O+P1G3.)/R#f[a[eeX55ISL?T)RaG
O@LI]W#(b=T@,Y5.JFgY[RX0c2WgYFZ3aM(^,=]9YF4I)>2f((>^62@IPBG7+.J:
-J]S0+QY?K=+.F,MCZS4OF>_Q3:B?6:U2FL0(VbYOO0aGTI,;C,CN=aJANJLa=J\
8.d0)WV?DZHX4.H\bgWZ&6a<BP5fKE,5=ZIG6<-.W=ME>7+P_P&e+8Pb-5_8\ZZ@
]];X8_D\[c4OZKcE@a)WZFGNAJ_<#;[EP\/=dfVH3T>>U8#S3V56/((8-S=KP&,G
=ITZgBUP:BMK1Z]Z>5.SeNa9WE]CH0\C^NHbG+dI.JN4_QP(AU[_YRgV;.(Q>.=c
04J8#f]0U1)Y#)6>B<XD4.U<X(F>,,&OV=gb6&;QJRYf11C<:BTQV,/6)J4ZGaa=
b1]]JIJI#LXZ@EE0L9P?W28cH1B<X5^?16/dF\=U)[a7d^eKdB9MIDN[=<]KW>e;
b7@RF&@f;TcVWVaeNbEJaA@9/0B9c02UCRYR^;)bT@-Se:M,_MQ=dNE=:_d52_+f
c.;B4XVLebE?DZP+.5CZB34b&.TFUg):P(Z9[fMD@N9Kd)X(=VGKFg8GGB1(3:^=
b\2[eUJDSOK&WH1dRDA5)K6;6[E?GTO?(a;[J+_2dZg^/4eMAPbcI^&L=7<TVO]:
b\#>cYYVM#-1SC8:4Y4)F]f6GF0QF3B2MRQDEJAV=>Sg1J::U9I9)L8GaWMBLgFD
XF@NU@+ZGO=O.9HDLCXFU<e+8[(+YaPOcC.d,/,<Oa)5/1?05ZTVc)ZH2+4G;?_e
?R:f\1(7I=AAP5RDT?5GdWBKGR)KbSEbOfY6^.06M7_beQVZBGC;Rd&#?L6Zcd3L
LC1>7D_JSV#R\11RY@C6EEY41RW+U):5LNa&FC\4g<)]?gVe/7Yg3F?0;Z>e<dE>
1US5WU96gLTd0LaDV]^,,5BC_F^/=XWZ.FDO:+/2,55B@584BBCGaG=,;JO;7?P:
;&;/]L+#P(^=)#GHS\99?(/GG]^<fE#+I0)8aM^D4:N)NB,3->D.g]RB/\-O3G8#
+Je.1;]H-\F;SE<\Q.78L.FQ#:6(-=X521>9\2RB>cgHRRO>c4PTU7V,VT9?:_cG
0&=eA1\fE^ADZB/0)XYPXC)NZa(KU>WSOb6L]P&:gT,LJY8\YWb\MWX4@KZ+#DA@
E_d0SCQUCT:SB@G45f1D4Fc._;/\bW#OXWKg3cG9F>RT3)_EC\UX?2E)7<KCP^QS
-<L+?fb9(K_VLcH]=P5?9cRH/T0R1,9:NS/8?I/XcULS-_1Rf#@H2WPGSZgI9DdQ
A8&0#?-,^GS+7N8V60d9@^]DPP4fYe5&[2<4S@T&9bBNV_:,T]KTR,D-bCbAgPX2
8aJ6B,(]N+J(E[W4WNDW6R3VBR:[>B]/3301dW[3M48SSgcHH<Pa&((Ic<[1=>G[
-2O8ScAMT9e-JTT7@Mc^^/,.-GGF\C-;0^;eBRVc7^L#3I:;]&[+^OI()U=e)^H>
]_8,=34.,&\B);0+/M<6)B=GcGE7G5GHPE.YHDD?.QR@Z0-2.WHFGJd^0WMFGLO7
8fUa@_0cbZS2:&(S+6fM^?ECE]GX>I;H><a6N#T;IWX<2RU5F^Y;1?D=AZ[[6E<[
:Jf1eOJRX5f7YL\WXN?Bf<HD47>NGHEQ&d2&bCV6<TN[;\^Q1#]cJYO2VP1DZBBO
BI)T;d;)a<)E5MW/Ia)DZa,/F]Q_&_R8TLCHZbRV54^6A3NO&E80#_?ZA1V[2#K9
b(gB.XFNS4MB@JJXc:6RD0QDK#<J.^dNXE.=+e0?N4VX3\2Of+&efF;fd(91X]1<
#7E&-aHS(5J9CR]#gbGO?f;Q6AQWJf2520Wd+8NIcP](cR?)BfW.K-I6Ja7#Ba[3
g/<@K85B6SSEKNB@B1Mg/Ffd6Y;JL^7Y9Y.-MRJe]9@AK>76D\/Q-FIFMdD>SSg8
[=/MNcGFF8[([0IbUAU54+=R7M27H/X03dBEFYP5:+?ERT?6]-G2dW[[g\96@)D1
5Z3VD<P^JJ=Ibc?W#88NgU,cLXFRTI],c;f64K0DOdSOg_W4M>_/4>.C7OYc)@A)
ddM2-fM)af5R;<GU9gg-9(VJ5:KS<V&SJbaPe\EA.2f^.U;AI:8:3Fgf_(HSc/I<
VB_P-#DQ;[D>:Fdc>K6NFP8X#4F23P?62OD+PWYb),cWfG)02AZR9=.bNR5,d9_L
D6Se-6R570XH>L>W#78B.BH+FIFgVBCZ=FL^ZQ.JG.\[=c,a>5XE2OEcDdc3d9JR
/29fE]DG=12cb2GH;^cSH<^QD.GX]215VLG2.dT\1XE?f)JA9R[/U3115H^O,d&U
QS(JYQf.1_R_(2-@Y4ILcVcBR]L@04[\>22T9^UXf,QJT+9ZO-LE)(2c;P)FWDX8
Q\EURIZA>NGZ2JGe8L(6<]^18;:WZ_ZVL0S8J2?b2L4G95AL_-d;/U9Y(HO4E;D_
B_NA<5OTI7+?YDMJ_/ZC0[AL2ZXVc7A#eQ=fC6.dc-4^AQ[Jc@egcSd+EBKVXe/R
:;7gTCAZ2c.O[6?e?/4?Q,F-C,?6eaI0R?.CTA7.RZ_0CER4L-gTJIV@I+&+#)I0
_56IJeL3a@U0@GgTP(T?>9[fbH-+[H,9Db9@g+J(HIHWF^E-g^:Q<-Ja/0g)P9W:
PIN0L?-(5)43RM@Y&g4RP28=>XM-N[dD4=G(+a_e)NGVW#F60GTN4OA^0?RWe8fO
C?C[[/2OU0cP8JAb27+&^RdL4F.IaTVTLS=VV2VR6>AEaVc=9R?@Ag7G+_Y#@_[-
X2fADN5.##@8-H?>V;[;LJFcc3YMCa(O+.cX:#:@g8aPgK4,5,3/QY7GI$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_COMMON_SV
