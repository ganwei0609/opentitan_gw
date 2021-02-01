
`ifndef GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV
`define GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

`include "svt_uart_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(uart_svt,uart_monitor_svt,O-2018.09,svt_uart_monitor_def_cov_util)
  
/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the port
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_uart_monitor_def_toggle_cov_callback extends svt_uart_monitor_def_toggle_cov_data_callbacks; 

  /** toggle coverage class declaration for covering toggling of DTR signal */
  svt_toggle_cov_bit dtr_toggle_cov;
  /** toggle coverage class declaration for covering toggling of DSR signal */
  svt_toggle_cov_bit dsr_toggle_cov;
  /** toggle coverage class declaration for covering toggling of RTS signal */
  svt_toggle_cov_bit rts_toggle_cov;
  /** toggle coverage class declaration for covering toggling of CTS signal */
  svt_toggle_cov_bit cts_toggle_cov;

  // *****************************************************************************
  // Methods
  // *****************************************************************************
  /**
    * CONSTRUCTOR: Create a new svt_uart_monitor_def_toggle_cov_callback instance.
    */
  extern function new(svt_uart_configuration cfg, string name = "svt_uart_monitor_def_toggle_cov_callback");

  /**
   * Set the instance name for covergroups
   */
  extern function void set_inst_name();

  /**
   * This task is used to call the bit_cov function to sample the covergroup for
   * toggle coverage of RTS and CTS signals
   */
  extern virtual task sample_rts_cts_toggle_bit_cov();

  /* 
   * This task is used to call the bit_cov function to sample the covergroup for
   * toggle coverage of DTR and DSR signals
   */
  extern virtual task sample_dtr_dsr_toggle_bit_cov();

endclass

//vcs_vip_protect 
`protected
+R_>)\b+TG^M5ea:L\)J0f97/OO9D:4Q/C0^CDL/LE9X9b9FV(B/((bO=?UOa_S_
K5-ER#13_N&7/:J659XS:8Q_W.1Ha5a8&^66c(V5bG@B5VE@Y<7C373^IFA/PbU\
,0Rd.9+7V\7QF(WAaaF2dcXe;L(PPC0)U(/e60b[A&+0.);,b:D7->5/;AGf6;?P
9._M)M5\,1B])?\7b6#Y(?WF3&gKB\KP1D?Dc@?LOA;B#H]cE(^CR^.C_4T&H]&S
.R?>_f]gY?CXGL]/]<GXQW[@Y@L&>QP]/NK\g2;I_9CHd6ROL1X\NV[2Hg7XPRRH
NA.gX6O)-H?CEZ5/+bYA;aKF9<f?PY+JFA?S@ZE&=RHFV00L-AUDQH+FdCC^/K9b
e_bCB_WY<K?_dT)b+#g,]gd1b[1ZPX8eYLFO1_]ZDWTE:^N@6Q6T[3./(a@/<)A-
Y4B=8LP9=DMd@[eDbWS@7H#+GM>K[/UNPS/DT@CC+H#=91Qf_H?O89+4<[[L5Sf+
Y@ZW52])6EB0fCUM+R.3/d>_BNM?a_FX:5SRFbT)DgVM-ga)8\EAF[2,B8JKW7,e
LSRdU8NK\cR/<H:9-;J.gcaIBI;B.<:TMD^Xb:D1;Ec:ABCegFS\[cf=BJ:+-]P#
-9=-TO<,5:6d6BC,=FN@-;REE[W<fUVD5+[SW<f\53-,=V6-_FMIcSW\8W0cfNKD
<C6+/F^XLO<:Y>f0CdH\ZgLcQ^DKaeEWWJ+?I7ZF6X.Z<QfX6.)I,F3aG4HY4.PB
U\d^LGb_9c:,;HB;#T4.##2(\KTJ9K0<IONMYFfI3Ha9ZK=Wc+/6\R,V5eF6_fKc
_RbD7_&Vb6<SJTI-[=Q0WcS:H&3BA8VdOLD\SN.05;-dF3[?4VDA9&Z^PYUgI;(>
^&Q#-3QSX)9K.CCB[:&OgU1+2P=654dX#CD?2<F<R?6CLT@8ggCHgX;V4A&&_@29
f_a>^JK:dW??U+8[A<g,2WC4;@[I=^<->gKHNBW6//E+2<O;VR=<R<)Mbeb\cXI,
OBX4EbY0b7\T,e;6\/LF73JIU,:7XH2gA+LVENMU-5=@7-7^[e=QG6Z<YCJOG+,W
A4NE3:ecff),/;5YNd2.0U:d9MH?^3[B0@(>UALP3>S4<P3V,,(,^F4)1HU6/6Uc
)UY1[,bcg(,?&#OX\KFaNQf61D57]I4]@7F#a6^G3Y]D)BaE_2\Y#JHUU[c#ZWNd
G8SQG1#b8BJ?BLgBH=[dH,f:J5249<)Q_E9]VADa2a3C/7c)PQJ&OTA]4U5.>CV&
K7F6Ic3;/ZRB2E+_>^Q+H.U5b7>OE[PZZF.d+@525)2Ta<d][UaL,5WY:HO?gOV,
.\IeQeX[4GQ.W[\WS-8)P9=e?dZ:eVV&-Y8\)7.WX<AJZOTW#eSKZ>_HXP_C<<./
d+@@ZK@c#_(fO=O7H5\]eeU8PJI89P7NA<Z5(aCM^aLA)]VCF7cXO_-@ZDQ,DO=#
77bL)4]:#C,RSEf:=96?W3.UL4CX,OB5^=_YS_W_6SKSFa6c+.N;A)+?KC:MWCV2
]F,G1_DeDU>]8b.9@:e+H0/&[5b>UMb920/B<eK,(A&39F]gG9/R>80CfI8HJ74F
d-J,?4E#aCBFU[?_CIe_CXfAYQcgJf037P06#GOPNECWQLOG3\Sbf-1d7Q4Mg==X
:_V+TS&&N-9TLLQNUL,GK>B/PB^NG-;,<\F#?)CX:X77Hgb=L_CAP[aA]IQRIaI\
=U<6cW>G4,C?PYVO#2?SF+.ORNPHA7.b=L>KYcd&Tc#+c=@5Q0&Jc^D61]FRM\YE
Z4:M6CR9egWd&GQ0^.#VJ0MI9;@63c#^BEICDIS2EP):SG;/QCTOLSbHN4-,]8cV
V,g?,QZ;0b\/fMYO36MYODJQN7<&@X61PI/^1V#Z;?I0K?QY0bR@bD/[gV+=3QM_
FeT+?]([?WJ]cZ>53K;48Fd]PVE_-AeJ/fS5D;bI;<V9RA61K&BbVL1-W;B1ISZ-
(QTgX3/F6V#-F+&NdGa3BK/.O:;[^2MVTV<54R<0fA-3_.Oc(89L[AdG#KWUBT\^
7UNbN73d&\0BDea96G,]MM9?QH+DOIAK;98-M3AeHU:IXN]a&:/Cb919F.7L:Jd5
]eA^)FMJa@,9-g1Lf]7QH]\@,2R4?8E=7:@&T1-ATc>QBNEEb4V:#O(@fBKYX->D
B61=KfEB47+6Qa#D]ESIPIBfOMXK<2UbXYad5a\K_O_f/]Da/@CKAO3f4QI.If4f
E)cAVa#;>^+ecBKP3aY8I\+E9WXN?IREd2@>\<SR8b-,:=>1Z&S?FYI)dHMg<=[C
f+CW>B7_18Ub:&CNQW@;900<6.SKH.c]fBV[@9+_TJ19_U_NO9@KFa(0SAOT0+&>
@b=<WSBQW^9<5:3O3.b.gI:VWT\0K#3dHMI#,a1aA>9:@._[W=Q/;7JM^Y-:RKbS
CeHgD^[&N0#Wf#G>;=^I<-V/:[8N9R)DA?(Nf(^S]+Ff^&B(eI0?E\1f,NT.+W0I
OK/>\8[CW9BZO?K\SX(d-68&a,,>OM0I]PEa:-)G:c)5U#ZJZbG;Y^&[U8\PO#FE
+[\N6/_XZ,,CIBU><BG7-@)-?6CM<QY6:D1KQ3e26\B+VD]M8:]9)^&[M$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_CALLBACK_SV

