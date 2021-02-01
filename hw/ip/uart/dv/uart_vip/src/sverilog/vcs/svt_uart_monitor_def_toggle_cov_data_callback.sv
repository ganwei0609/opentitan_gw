
`ifndef GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
`define GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV

`include "svt_uart_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(uart_svt,uart_monitor_svt,O-2018.09,svt_uart_monitor_def_cov_util)

/** This callback class defines default data and event information that are used
  * to implement the coverage groups. The naming convention uses "def_cov_data"
  * in the class names for easy identification of these classes. This class also
  * includes implementations of the coverage methods that respond to the coverage
  * requests by setting the coverage data and triggering the coverage events.
  * This implementation does not include any coverage groups. The def_cov_data
  * callbacks classes are extended from port monitor callback class.
  */
class svt_uart_monitor_def_toggle_cov_data_callbacks extends svt_uart_monitor_callback;

  /** Configuration object used to sample the toggle coverage. */
  svt_uart_configuration cfg;

  extern function new(svt_uart_configuration cfg, string name = "svt_uart_monitor_def_toggle_cov_data_callbacks");

  /**
   * Callback issued by component to allow callbacks to initiate activities.
   * This callback is used to initiate the the logic for collecting the
   * information regarding the toggling of port signals once the reset is
   * deasserted.
   */
  extern virtual function void startup(`SVT_XVM(component) component);

  /**
   * This task is used to collect information regarding the toggling of port
   * signals DTR and DSR
   */
  extern virtual task recognize_dtr_dsr_samples(svt_uart_configuration cfg);

  /**
   * This task is used to collect information regarding the toggling of port
   * signals RTS and CTS
   */
  extern virtual task recognize_rts_cts_samples(svt_uart_configuration cfg);

  /**
   * This task is used to call the bit_cov function to sample the covergroup for
   * toggle coverage of RTS and CTS signals
   */
  virtual task sample_rts_cts_toggle_bit_cov();
  endtask // sample_rts_cts_toggle_bit_cov

  /* 
   * This task is used to call the bit_cov function to sample the covergroup for
   * toggle coverage of DTR and DSR signals
   */
  virtual task sample_dtr_dsr_toggle_bit_cov();
  endtask // sample_dtr_dsr_toggle_bit_cov

endclass

//vcs_vip_protect 
`protected
aP&]5YD]UP[)#.TXWK#,^(NffF<;fXY@LRGDL;O=B4[PbBM5>a@W3(^d7,@]a0AC
AgTJN1WT^8<]J+03?Lf;4F,M+#_W_Z-J-R_2#H.E4RX\_80YYfPL44HXKSZd&;S>
BC>d/Q0Y)K8FABWUZF_#_LFGU=S&B3,2a@/0Y+aeZWYUNG9XETQ^LV+e1H4b1[f8
NJ0B2.IcYFdGEHS?1+^/&JCIMP2MNW,M7E3;7ELV^K((>^90CQ/6JA=_cYWL8?eE
YC2:26OE>&?1N6>FHK4Y;-#TB,_^NY/b]CCd@d=CV6/R2M&#<+OdO]a&33X9:=?B
4VQZPLOUS\X?IC5<^6fUWIb[J\<7])Z2&b(;7aYYdbSaO=g<dNe5_3Y#MT1L:=@S
[[HP,IZZ/3.6<.(RI:.B#3=eXMTa4[K#6O;d@<PXVN[Yb6:HfHg9+:8-KgK_S3^c
_M6d6aH6W>2=5[Y7>].ENWd^C9AL7R)W26M]9?b7&7.TK:7-Kb,G-Z0,fV7)gEUb
,AVP_[3U\0GT)0CVc#?1<I/TZ@;?JXVH(3g2A)CKRa.OafS:8X0>A<?NHf/JI@4=
\=8)#XYRKW?[M11:^SGNcVdbT8,1&SC/53NRUW-GH&;VB^b7e45=e/.TQad>8NDY
d6T#L)MRa_;?GM(M1[\FQ1WKM1:@^0M-\@8\P2Qbgg8>a.[<ROeLcO])CSMX0D\O
D=7KQLB(agWW.b1-f.YeJB?YVSP+BXPD-R.;^BU3ZZW&Ic8U#TN5N/SfMg)W^V-X
[?;KIM#P909)&,V^_@7E+36Y0aUDV3^c)6_N08:AM/T8.BXFX0F1^DXd<O##4-+B
]F3^2]5Qa#5fKT#:bP5,Q1gC#A32]JA&S-cM1PS^XZ:a8+)bHY@e7=UcZX#;O^Y9
6Y=,_@BQZ7]gY1:KP\d)Ta2/D[O]K2<72.X0NTR/)V9^D@3CB29V_W1\f+6(3G@6
\F/cc+=A]9),:VBf.<RK6D41P;1f_DJAW95:aa=GK:fM]Kcg,LMaY?U=XJ]5,-M(
B)bWaY0CRCCMc7Y&^\M_6\S]<&YDec.2Z)ZCNN@]cYG[F8WT@P[J+ZTK<@/NQ2Rb
aNBJ/eSX]5QBC^6MOVB-NTAZ&eOSSD16KUO)YbHa(1.@>E5XE[IKTeCXH32;cM(g
cAd-&d63^FE<Na]fP(Xa+(+<I^^P<+,:>5b;WUBCP3cUVJED+dD<ZMNaW__5GXJ,
\O[HfP]IUIP4^Pb+XggX61]<GR[3g/e]A?OW]2/KKFBG#g0?^)CILV<Qa5#6VU#H
ERB3_0P.[[aI+(#f]204YTR.\aBH6B.FC2T3Z&79R5D1;<bF50a9,g,[W^A<_c]?
P2[<=>g1QcT&^ZYM7LF.Db:M>MC5W?R-G5Q<4Sa1#b5OCb.@(c)3#,5+\f<A##6(
a8N>0U9LU#/+QNd;GY<,X-b253@b@&e?O),@^RVI33^?9@@^-e1aW<0_<LS.0(9c
^d5+/G=5K/T8F?E3W6HS@Q[dZP\3J=]5@^X-Q(S0N67fC@aYcI9^SVM8?cabd)8=
DI?YR<7VO[/&?0ge6MYfLb&?F@>1CbaCe:DC\-OPF&_L1Ic.#9R>X/?V:RO6F\G]
@/<f^ZF4F_#9?4Z&2.,[fHI+:).,9KcG?_<<2A4(]238/.)AJSQR+O&Ne5]8+>:Q
+O+&.Og6KKcQUL^14:I8gMVWd@AG#g@G9.5@/\<@1[FB4FGO)O?I4:]1aMVDWTKf
.WPAc+^A#<E0MP5X1Y<1DJ#<Q\1_&bB+;4(Z\:+W_>BBWE\Z;FWIBS0?e,>ZJTDD
PfBD(O\TSPaG,1LBE@C_)]#8H9>2L=Pf#:G;?^PMT-JOg:^ESMF9]&IG1WY3T;UH
.5MD\]Y0PZ=/fZCAcF:++=BQ2Q@Ab7dId(JTBQJg:4KP])B(13@ee8@\YST<9Gg8
JWCS+(&aX_&3<fb#Ee->+L/^SaI4&CG__N_W/aUPMH+:63UdY8))K5/[]?aDKRL1
/<N];<>NKT_)9Vf63K8):1:&]-B(FEE8>2\UUg5e.T=KA1M:.S(BJ_=8];Q4B3+=
<e6P,bXa77)MLcRN,2^C+OF4db)TAZ<PX7)Rb^N6RG5Ja+2_B&&#eS)>,.9=285C
acSSeYA[aOFbZ-&IgX)LOG1b:@(Q5;B\0c?K/MV-3?b8+.]fDQb0fK1aGQ3L,A,_
0G_g^_X:-QfJgRO(\N2>KMW1;bgC>7KL^9e92JC:ZS2>DWTNPd;ZIHDUQ14/K7L+
KPAb/78D2:H;B/NEF7&4M(R70d)QEde/,FLY9SVWV/O+Q.\Q&RCI,Y^BXd@,(Rbf
Bca2JQ[+^Y;;.$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_TXRX_MONITOR_DEF_TOGGLE_COV_DATA_CALLBACKS_SV
   
