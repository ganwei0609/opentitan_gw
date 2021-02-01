
`ifndef GUARD_SVT_UART_XML_WRITER_CALLBACK_XVM_SV
`define GUARD_SVT_UART_XML_WRITER_CALLBACK_XVM_SV

/** @cond PRIVATE */
// =============================================================================
/**
 * The svt_uart_monitor_xml_writer_callback class is extended from the
 * #svt_uart_monitor_callback class in order to write out protocol object 
 * information (using the svt_uart_txrx_xml_writer class).
 */

class svt_uart_monitor_xml_writer_callback extends svt_uart_monitor_callback;
  
// ****************************************************************************
  // Data
  // ****************************************************************************

  /** Writer used to generate XML output for transactions. */
  protected svt_xml_writer xml_writer = null;

  svt_uart_transaction uart_xact; // handle to base class to generate the parent_uid for Parent/Child relationship in PA

  string parent_uid, transaction_uid;

  protected real xact_start_time=0;
  protected real xact_start_time_u=0;
  protected real xact_start_time_d =0;
  protected real config_start_time =0;

  protected real xact_end_time =0;
  protected real xact_end_time_u =0;
  protected real xact_end_time_d =0;
  protected real config_end_time =0;

  string name;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
  `ifdef SVT_VMM_TECHNOLOGY
    extern function new(svt_xml_writer xml_writer);
  `else
    extern function new(svt_xml_writer xml_writer, string name = "svt_uart_monitor_xml_writer_callback");
  `endif
  
   // -----------------------------------------------------------------------------
  /**
   * Called when a transaction starts.
   *
   * @param monitor A reference to the svt_uart_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void new_trans_phase(svt_uart_monitor monitor, svt_uart_transaction xact);

  // -----------------------------------------------------------------------------
  /**
   * Called when method "reconfigure_via_task" is called in VIP agent
   *
   * @param monitor A reference to the svt_uart_monitor component that is
   * issuing this callback.
   * @param cfg A reference to the configuration descriptor object of interest.
   */
  extern virtual function void new_config_phase(svt_uart_monitor monitor, svt_uart_configuration cfg);

  // -----------------------------------------------------------------------------
  /**
   * Called when a transaction ends.
   *
   * @param monitor A reference to the svt_uart_monitor component that is
   * issuing this callback.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void pre_xact_observed_put(svt_uart_monitor monitor, svt_uart_transaction xact, ref bit drop);

  // -----------------------------------------------------------------------------
  /**
   * Called when method "reconfigure_via_task" is called in VIP agent
   *
   * @param monitor A reference to the svt_uart_monitor component that is
   * issuing this callback.
   * @param cfg A reference to the configuration descriptor object of interest.
   */
  extern virtual function void config_pre_output_port_put(svt_uart_monitor monitor, svt_uart_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts.
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_started(svt_uart_monitor monitor, svt_uart_transaction  xact);

  /**
   * Called when a transaction ends.
   *
   * @param monitor A reference to the svt_uart_monitor component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended(svt_uart_monitor monitor, svt_uart_transaction  xact);


endclass : svt_uart_monitor_xml_writer_callback
/** @endcond */

// =============================================================================
`protected
&1=4VJU^]4+e2?2>\_UaG3B]J=.ZHH8ZZ/ebU\Q7@EP?7(H(()&70)BUH&9A5bBZ
34@0_-B8a,PdOWRD^#;)P6FHL1-(g>L<d^QX)E:.+N0Y_bO].Bd,1/Z-XJKUCJ=&
6E:M>G6C1U?8,<:&M7R+&TX(F3=()NWRg#2LB9@/<8=9U.aRd@93[SF9(S/-U=04
cUDXF&?d_4/AC?N^+3>He06XIRR)SO2NdA\g=0Y7,A>VHV^7_5M9DGZ7cX:IT_Ig
[e=RIGB3LUI]>YRS51^Q/1f?B28,>UYJSdA0MB4e(I(33]\T+@L\3>X9MMVN\cZF
88J1I&Kb^P>:\:(7X\G[O@#-J7NH2fJ[f^P.):70>FROb9Q(>C(1f7b3-dKZ.2OJ
0>I6Q6Q#KL9IgC<[8=a71(89M71B]>C(3Ce-(?8F[<_W^).K@^TBcO&W;]4;O]g?
d-69I,AQ,#]K#F8GeZY-:cC9AM/^Z2KB+))Jb.H9M^4>0AfG<Ld-;ZQ4Q_eT_\TF
Z6@>JW+^G;CAOD0(VDbNVTeO)e^X:?.g-?=/0\6>?4&NZR4J.D:4,7MTa5=CXV;3
Q,7fA^&];<-Z@;T=+3HOC3&Q43=I1ObIO#-09[?>\1(>eAB@Ka1EH0dYFNG8I89&
M+Hb&OebA88WcTdZT4WO/LI;81Z@FU9.VBADI/]_QSR^bHET=W(45,eNEWJ,74NT
(&d:_K8N81Q.(QSZFdaN-G4Y@AMSbX=aI(VXY;&:(^a)CA3(VGggP-GK.-J8Q,dG
.9)\_K3^/FV@a+QK3&FC+UNQ)_>_9?:aF=,HP6IC^B-=>b(5)4#34NI3-@<VKV?K
,@H74WO6DcL/O]0Qc91I?\26I0Z)A#(NL4:9\+^XdXLV8YJfU;dKK<T^AT.f(3Y7
R(WO0,#;74gB<+?@0>S;BbVe1.dPB,TFVY/)0dLAN^eg0Q:g5B6GB,e[gIRa@-R,
D&eHc,,K?019J@L310Z7[A;J+H\BWdS4##3Y7,J+<8LDbM8B&ZHGKKbNI3A7Y<c^
4a+8=N?GGEE2YKKIQS.[#S4Cc(g30eZHOA7IA;9d,&Oab@;:Q[,YUA@=&d4:f__B
HO@&L4K--Ia3Ea,=Y5_PX-RH3PbBK=RE<^LO2;3VaV]@NL9&V9/Y^,W=\>K5?LXa
cZR_ZgQR:9H4^D4XZ42FB92TP5=H=:7bQSL9DRXC_?1<JP.I_P4M5Ic8)T@(?Z<H
&351<[:61/KRHg^L2_M/fOEM]96AZR:b)3M]_-(UA/+6edIQgecFNUGNfD08C\/H
]M_:=V^/DcP8c^GEH.QCK)Ra=XOaE_R0V,CBCe_&?K0bW9I/]0DbRE3)D/L)Q5[U
ML&XY(Z5+?Rc3EfP^)2]SgKJ(>&cMF?AeC1KDHT?PfLI,T4L5cYf@8);<7I-Q/9O
3DRH7K4QPH;QNGb2&LJZE6.^NWgJ9=?\OgFLG6aLY?S7>8fMU,-EA;.#eI&KU<6+
(OW2?3WHE2QY:&&5C-AD@H]FVEaP=:4]C4U/L6WX=#<634-CZ7?gD+<H:GDZ]X^Q
eP8THAM2M/N^[NZM]9-DX/:f?VBX/I]I/FLV+fG((<a=_X9+K4A3g<KRWUgdMbf(
NY2EE7,\R[4UTHR80dHRaQbZ9YJ1M\;3]25CIPC&INR7.bJ&V0TAUS2C9Q6=,G7L
0ef_E2d9RA.eV?+Q2WBW:8Zc.+dD=6@BGC-bBX6+VeL#@9NA:9]K5@7<(@:F7@-H
g2B=2<ge^[)aS)LUC92.+S#GgA);??c&>GL@-H9#3HTWJB&d:CWbRbIMfOVbacB]
6\E^ATN._Z,-@]AA7:N#),:EEFY&-.[:3DMY6(Y+UdBR>4Cg\6fa3,IJ^3dBJbY3
OR.;6N9)d>DJYN8GEAAX&(2F(+;b]L4bXXW-?AVAPYY[W_=ca2Z:\VF8]TK4-fB?
>E+Z#ZRZbe:Y@6RKe6^<G)QFOLYEZH(2[BC0X^2JTUa7&<=#=T-M-D9XJcZdY#UN
8.9T68H]9^QE2M-<FB+Ad4@)MQHUcP4O/MS;5/UWL^M=)L9W^;RN&20,a[NGO:,,
faM)DdUEFc7P4)8;D2AW]gA1P_81gUccJM5eS)3++KN<cLf6(\#Ie34A_^WQO;;5
_]EY93O<c_8KXZ_B#2I<&WQH,f5[G8H(_>-Qd+I.QX<c,7fWa>+OD:L)&NMQ\9;b
V1?UNfaJDWT=W:KW4/B]:FMX+63M7J09f6;BM\D2^N5Jd)gcT:;IMJM755W,6\B[
,4&bgCXc3V;g7@@&<)AJEJWc=/]885fL+#F]-SZ;#=>YY1O)P0JXT#_,EWM4G)4]
N[\K<L?4>?(SICQ3^[HT&LeQ/:gEV3aQ#L[fU+8.GRgBC;#GdFBUL6[ZSA1G=M=f
[7FZ<ZD830LQNf_P-aB5B-J;0X>U&d&.MJ-Zb_He]:)gF&cF1.[da2e5.^42DIA8
e2BB&K?Z?<Tc^e/f1Z?bdca-2dEQdf\ERK5BSP)(ef.X6=UN>;(9,.?f9S>GgT^c
F;O:@Dd/BI8VSKO0cS<f9ZMX2EG]Y.eRVb1KV41BB^3UcQ]@T<S>6DTOC<@E5L/^
Q<-Gd64B81gGeB:M0]31^cZeF:<L/ebMQNGK3#>X7EENB5;]67d,&D#^&0T=FdCa
/,U#]Zga_U&3Tc29SO&/-D3aSE0S)]C/#+c\eJ#4M56&H\c/0MeKOcE9SF<#c/H?
WP?BI4[Z-2<5HUE7?FgI3V&=Kc42+A.(W-5T=e(FU1(3\)6O/gY.7HV_a@C9C6B7
gJ/FZ\&L(4F,.E@S[Y0]X0be4+gK=QeAY31+R5LC^cKPX/8-YZ;Q6R>c]ZD)BBd]
8YWYY@a9T56\&34<0ES?RKS(R.)VK::&KM;_.YK<FK(M^>M468<9A[g=G<XgWML=
(CSEKHf8HB1H6?VP-=[0VNc\T,;D\L?a>SJ8GRLQ292#:9H&#-JDFTG=Q:<F]#2e
8G-C+KRDDL\Y75OHXVEf1+U71<=G1gc_:48.C-.34/-6K)M0W_C;3(WIEO/PAZ/>
5:8E3#@BT4??Q91K@-:\24S@AgTdYV1)1_gX4H13bUDdef&(eMVD;#0O2P_.AHLH
ID)@_<B&8d6RT]A5.8U_6Y^Q(IF@Z(EUeYV\eK>JS=(>ZW-@c<].A^02>b37^7QG
Afd^dY#8_Bdfe39M[@10FCOX_6M9)E7V#aAa#?UBH/+.]ND@?>UeEg+3,:AH2]+9
__+-Ke2Ka66;/IPMY>g3DUDS=2PSgGf.&^3/3B(6c8V1P./0[(>B8X1M4W)PI+^_
<S8@Ab)/eOLe\X:TT3bYTN3,97\P62KfO\g32@>7e9[CcM+EZMb\2>1Fg//N<^b2
=8eRWI<Q[Ve9?A_W3L#VWTXQ^E=7/908agc=+/g.8L=7e62;07)RMe6EeQA9^K1<
5J]E[(6?gO&UQ4:.&&5cMfIbHG23]bJRVMJ<V>DBZ(FEd2W;]f4HGD\>LIc-1-f>
FOS#X?BB>Q>XGF0VD,<\#1Yg]E_FbWL8[4]GC[+,O1&Y4-+EU:ged_bP0FY<+RS)
MWAOECd8g)[,GI&Q\.=T_5MNN8,e]O,gG7;/eQJW>9?],RfF2Ta=L+JP,a@(Y>eT
UJ3E7eBMMG:e(QCS>dMINXW49AJ^_?&Uc2@=Y1\,/^A3O<_7M2Z9>]?Q1;S_b33A
;,E[/C_--/SI+\WD+0E5VMHM]WG\DEFIQ;B6(N/5d2U]Ib4]DCH+]?@YG1A;@9X^
fg;8RJ^#AV;R#(5V0H<N^H7G3IQXfB8JFg^C<<?;#+M-V60g16./eg67H2>Ee3J#
??RFACJbeJbMJ4L,8EN]#eP^8TS>a?g&d7#21eZ(MFMAVMLCFS7EZ[#L]8,J,/GM
?0Q5Q6N1&PBUNXNX+3>WC38YU\8W95Ma<$
`endprotected


`endif // GUARD_SVT_UART_XML_WRITER_CALLBACK_XVM_SV
