
`ifndef GUARD_SVT_UART_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_UART_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_uart_transaction;
typedef class svt_uart_transaction_exception;

//----------------------------------------------------------------------------
/** Local constants. */
// ---------------------------------------------------------------------------

`ifndef SVT_UART_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_uart_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_uart_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_uart_transaction_exception_list instance.
 */
`define SVT_UART_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

/**
 * This class represents the exception list for a transaction.
 */
class svt_uart_transaction_exception_list extends svt_exception_list#(svt_uart_transaction_exception);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_uart_transaction_exception_list", svt_uart_transaction_exception randomized_exception = null);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_uart_transaction_exception_list)
  `svt_data_member_end(svt_uart_transaction_exception_list)

  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

  /**
   * Performs basic validation of the object contents.  The only supported kind 
   * values are -1 and `SVT_DATA_TYPE::COMPLETE.  Both values result in a COMPLETE 
   * compare.
   */
  extern virtual function bit do_is_valid( bit silent = 1, int kind = -1 );

  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_uart_configuration cfg,svt_uart_transaction xact );

  /**
   * Searches the exception list of the transaction (if it has one), and returns
   * a 1 if there are any exceptions of the specified type, or 0, if none were
   * found.
   * 
   * @param error_kind           The kind of exception to look for.
   * 
   * @return                     Returns 1 if the transaction's exception list  
   *                             has at least one exception of the specified type 
   *                             (taking the specified values of affected_tx_packet 
   *                             and retry_number into account). Returns 0 if it  
   *                             does not, or if the exception list is null.
   */
  extern virtual function bit has_exception( svt_uart_transaction_exception::error_kind_enum error_kind );

  /**
   * HDL Support: Provides <i>read</i> access to the public data members or other
   *              "derived properties" of this class.
   */
  extern virtual function bit get_prop_val( string prop_name, ref bit [1023:0] prop_val, 
                                            input int array_ix, ref `SVT_DATA_TYPE data_obj );

  /** 
   * The svt_uart_transaction_exception class contains a reference, xact, to the transaction the exception
   * is for. The exception_list copy leaves xact pointing to the 'original' transaction, not the copied
   * into transaction.  This function adjusts the xact reference in any transaction exceptions present. 
   *  
   * @param new_inst The svt_uart_transaction that this exception is associated with.
   */ 
  extern virtual function void adjust_xact_reference(svt_uart_transaction new_inst);
     
  /**
   * Searches the exception list of the transaction (if it has one), and removes
   * any exceptions of the specified type.
   * 
   * @param error_kind      The kind of exception to remove.
   * 
   * @return                Provides a handle to the updated exception list. 
   *                        This will be null if all of the exceptions have been
   *                        removed or if the exception list was null when the
   *                        function was called.
   */
  extern virtual function svt_uart_transaction_exception_list remove_exceptions(
    svt_uart_transaction_exception::error_kind_enum error_kind );

endclass

// =============================================================================

`protected
H@9M&-PSDd&)IfKbZO+eCd@ggL=fU&#W/X/9]/Y0PFe@C[Xf;WHe-)1[[NY](LU6
,QSVM?fY/:@\D1X7,;QCNLgYKRA?8:P#[,R.Q;4B,AOM&U[H).gb-gPa&Y?Y<6Cf
8DfMLcOY^ZdBeY,#;Z<L[4MOL\9S?fFVa4BJILJYP#7>>AQQM81XXSCLC>==M72_
(>Gg.&Cf[aLJ/&3C/(60@K80gg,LKYP2.b:P1VE+,T(IP-05VaGJH:2HRISQ;W1S
,Z6A+(-bR^1@PeLgcDbS&EQf5aO0.,.:bFMfG@,##f7;e4B,5@cSWc_PVD,b<g/3
]23[\XK9Z8_8XNR&5EG>dXaaZ2R5HUcfaA_L(7+7FRf:]LECOM\914=QCbac<7cH
:eeZ(#/DcdY^(09U[N;)&OR_E?/\bD:HOK0NI.+-cV.HNQ:H3?.::3;bLf+e[Xb:
<.69fH]NPbG[VEM&;Fe0\FUJGVa6LOC&Y>g5A@XBB9g)1-/(L9XVNW>?Y-X7B+MH
Za@5O#]F<HX5IJ]LN8U_,AK#FMIF4LLP?U+E#:5ZVX9baTHVLVZBde(N+(W.R#MK
5M?(1.-O=^S(\A\/_,M]bH6M0_a,>fV&R>#F5dY7X/A0?Y\5/3);352+Z\D7ZC0;
5Hb?+Ef^>B+a_RHg@2H3X2W?2:gWOQ/(4XKbO<?[:#@63T+0//6?J8J)]?aU>_;S
7gEUM9+3ab&RR31#L+QV1)IV5MbDI?0gf1>9XUZ0)e#U]@KCKHOD)C>BA?=D4SE(U$
`endprotected


//vcs_vip_protect 
`protected
_,??C.;=#&.J:I1:)QO)@2294W^EEgJMdZ1>EPT&;]^^E)@/B([?((IT]O1;QP:E
GWR.d9X-\>Y>Fc-K^W4b>S0JWJD;2<VZ5@X13;MUG++PX2_14Be?J25R,cWP?M7[
.UA;IOVQC\8eDV.WHe2HVbP?C5,HMGY;Wb.8b][H9L1Q#>STD-ZLQT2;G2U,.\PO
W0C.D?6,2?D-^D##4B8cB?)fL&>Kg5@HYG+&(<0LDcBZ;3@S5XJ_S^8#N7QPJAG#
6Z292:H#[IW;OeEXQZf8M?WJBf6-+:.3I)QERGR9GGBMVC)J^U_f:W:XS+/Q;:#]
A[bIbQDTBdJ8P\#/2-@XaaP8A-I2PF^GVEc2:^E#8M\0B(KO)YX5&B1I3Y0CGBG#
KW]/FC8VSOB-AR+1]dXFgbG8T(J[,63JOB.)a0gB>b.RH>#]2ES1^gUPQP=C>P-4
-P<V]+RW]IdSg3d#,O?fT7+J=\]4\V<VY;E]SR-A7f9eN<J#Y1bXdTDBO1DGB#9)
&@f9CX1Wg[44b,(.(Y-:2[(N@.IOGO(BLR>FQ=a>54c2Cg=8V&S6a2)<M[?Bf:2Q
?@-1f+-\b;CBEMO-1]=QUZ3U7+0&N>:N.-gaf11fZ;P;6T;VIFYEEX-)[V4WHWU1
1:^&UBR+PgJ=UELFVQ9O;QS72e6b9P39bWO5LO]<Q\PS=EAg2=:=2XB?#)^eOK\&
d)D/C/ga7JE3))Y3\(_\).7OBDPQbJd:YMY3A-[P#]81Ob4OO6;WW?bVK41HQ#O^
(&>RLL:Pg(ZP68;Z2W6WHIAS(W<G(#P-M_;_V9HdeFA<SM#/,J/?CKK<@W@9e1+1
6-g,a)E4)b@7H-_(W2N^&XV4OJ7\_)2P5MTfGKZ0eF,2K1fA0FdVN@&2fgHH&3?b
TX6M,+b)X^<_BG/TT3dFR(,O\f/8;NA6&]f(D:db<0Vf5^(P,IN?&E1Sc@Q5PRbO
X@dRCd[<&Z4;XO+J;X0<W+Q)=PO^:a2bCIf+S0]HN<Y@V3+@::MQAVL^b[/:gD6I
6DP_7#?^eX:#O@F_/Q0]b;7Q5d:L,5U>S3)(W?2]Bg4:4QW+<]^LOaG;GG-O,PZD
#+YRQO+?,gX7J0KWH5GHgdb\+QL;+)BY_\SN4[)C=X13X,OR[bH@IYGL+cCQ,#<:
:AL3H4D;-Q)_L\(#2K.O4M1J7V(Lgc#a=J^<UcRL80>;=XaR)V81]d#^BK+5P19;
ZQ^_<ZP\5QKDJFK5,L<1\.IfDc6H7P=1ff+c_0_=YAO8b5@dT<[aLdE0SF;X=gEH
=ZF)VI1I>2LEKJWDWa:12aHI.A^BE_Md/Me\X#JW^)ca_-7\AWNcL6)BX[bXZ#:I
b;X,RE]URDg(H7UfYbVNJLMT0E6Z)b.c(-d-//fWTbXAJ:V1ML^N^&^[F0R(Y<(7
F.;/UVDN(VbEA+&0C8f,;dZ#D)M67c/-V)XSB:Z(_96Mc9H/M<&WNLEPRBC[\c1I
Z[LKdS-B+dJ-aC3cBAQY>6a;<L.SA1A2#ADI/c_;2J+WFa[:1F7OC2/->TWc2K6=
MM&NR,E-IOI#M6?Y.bFRY>;d[G6K8I9OIJJ?U01ga_YK9G(REPKbZ2EJ=LD5TE:_
6]_HQ[Z\NOc#RL-C2<>T[>Z0+C6OFIE_H4PJ<Q80]/,&7)&/GZ&6f]?)W+CeRX[5
->FbMbV0(E2@I(a5eHa6P>Of^02J-]D5Z4[\7(fB:E\;OB7O7Ic3^C/8?6&?BTXV
J]eIE=N.2+ZFae\(4If51eF?QF\X99/D,_OBHfIL1IQKQ?IT2\OLWD3(PP[5YKO.
bQ,LbT>gMI&9:E[)Y6:2729QbR<2WEMCG\-Ma2:AJPWJ9W?+>MF_@PT]1&\VY0TP
c]P.9XQOdb7f.@6)[ZU\6gZ>gVD];C2;WYa(dWCe1[PMe9AC56TgE2IN2.Q/a,1\
CXQ3\:\06-cV=C[57f/UDV0J0BUYdH5]]g5<M1J\eZ<-H,>[#U^TL-Z5N3<7eJTF
D.H-YIS#a63:C;b.LKR>=(K:,#R/YcW.Y7+d:#5]dUS>P5DcTQNSZ54g-2b8MS/(
^cYMe=X:;-,=SC5>Hf;+7W4PY8-;X/-5^[AgW9(&E<W-^g-ES;02:NFcNI:GL=R]
b[,=:/0V^_GLCUa^E54V2TPBJL;H4S\Gdb>C[^/HXQQ4-NX@PG1g]Q3We\NcRY2K
Z@ECND/,&O?>4JNY6b-a?7<bKH2&EB]:_H\Ef0K]S5W>0S?5#)C2A6_de8DSD94T
b,V3.0:b1M)D-V6\R,2b7GZ/YBgfM)[6S2gI:Y7H8HDXTA;0F0^I/.P&NZ:>B,+/
><5_69KP9EAZ:XeBHF3NID1W7#gRORe<WQXdAQO/A11Z))g[^MFg\E6S9H)9B5S.
2HL=N[P>ffLJS^,TX7c6<)BIH.5H?5C-5IdLbJHLVb++U71#M:a+Cb>2K?QFA//[
-XL#TeJNbGPf(.[,DPCM-IP]3dbO@Jd.LGTRG@#A]gY>EWTf98S;QV6]Rf6R.1?Q
;H;_H.2>QQ67@HO?-MR3.[Q=J:[26Bg=P-J]VL7@KQGCPfbb:6U137FY5?+Z2S?-
gR(BT67C^/TcP<=MHNc=&79O1Rf/[Y.(f+/IQM&Je>^+]@Ye33@H8gZc]#JL1?L;
de/a8G=256I77(0L8d9=daQOHVTSZb-#RN8NY@B2.@#KFb5f+YT/?b_SS144@BRg
&cOaJ#2\3:LMU5e-6,O\S;1?4JFH:G>I_,S._I/N.HW(d61M:.<eEgTb@&-D-?0e
Z]=UE.PWXORK/#]VPOe8D^^a,;]+.e-f(g+?=(9C29c0B;gX4e.G],V?MV/(0SM1
2CC+[CUJ6C>4.-:363KaJI6SO9b>BIOgQ+a)[BY3IE2H)0MX(U,[.cJPAg@5:(/K
-+=eE-G(U>L4OS-PC1GXf-IF=.&R#RO7[(P06ST)LWDIa+3Q,LE.6>XTHT3(I#gB
5O=fRKD].3=8T2dZa=>NY<fA(Z]DQSPcFZ9(S(,[-9@.74gP[(J51?CD(2:a2G]^
PWBf<T2P91Z3;NQSZ=V1g]G(3F4UCE>?AE<Q=6aP-9LCRNdV@KP<eQ/O#bE=d=M7
O4C=Je7TT(4QfV([L:.aKD8R^IV:bL\(7)Z-H#D=4DP\RW9[MX.4QTOS^:L\3+TH
W-HYQ:,(G2_U[U4_A(3O#KcU,]dL7(aC[@bTC7T#J\1/-eNFG4C<W#/X+]5>9)cP
?eZ]+e3EC,[1>\M>0df(8eTf\b><#QF0IV@>TYS<eMg=H=cQO,DT2eR:?dD2fXK^
aaFTJSRJKAf9,WBKNR@5W@K2-V>2efFJ&K)7G&]L16>b:A3+,.[2OFUZ4cI4gTWK
H>)D)UNE+9UT33eI<RD)I(?,9b-+/RV-JSV(9F#BTXOQA62C07I#01NKU@4RI>Y3
32>\B)O#-AMDRM)&HE=+NG;^1ZVW&^/../aQf>[[GLc&HCI^W+0^?A).3FU-\N8Z
BS-e6d@X0K3B;O=&JNL=KJD4ZD)Vge5\.2GEfUI>CT]6Xe\X[e5PTFg;)XOc4[[c
.^f\G)&B4EUZ.Y156GM\dF91MAf&gIH[60^PIO110X/[/<ZCM6H3c=G:,[KVVg#2
JX97-R:__S)cJ2c9g2.M^gOIZ5ReNX=]LdVSG0e0Lb_K6+/K6GaeHHHBAU4KC_.?
)PA/BH]FK9KGQ6CbdZ?8Bg9&gS/5C1GT^SR.JW(7Xe;I^FCRL_(E;KI/[C/2Oc8A
&a39=E@HCJG9XI?\ffP>QYG^,.TL(O[YFTMa[LFF,KdT0>Y;RD[Pd4e:I(;[XG22
Q[7&Y0NCcRGCWg0-#CP\AAQe,Z2H5QJfKO+X8_FS5JT2C0E1&FUS[b.XH^_GAce(
IP(N9LZ&G]5c,E+<R:Y,4[MR4,Bb.P&>J?f<=aCcH^0)[3Ze_aZKF?_?=>#A_5N\
E3/IIe(G-.A]<#BKA]5Z.G)]I@J15Q17)]MVHQ2cDL0OQVc.=]@7MZ#3GLYIK=?Q
/5W(HOPBZb,-a8FR90WF<YG)VR6\Q>@]NL>;gIJfIAX)&SZ&Q8KC//+=]HAWM/XY
B8AG&\/GU89_5R^Q60@BUL>2A\<9cU1Y13)e\a\ODAYAa.BZ]<O2DgCL.R_6d-@Q
R9[/,B;dY)UfRcYT/gE@ILXM9g8UB<ETYHa&:?1/=S5[<ddQ-6[@ZeV,6=dU8_]N
Y/HAffDY2_CFTE#KLE<@\dJZg+<a@QZRY(eC1dVNCSeYR2ZO;+_5]@E==6Pb3F3+
97B4H(YS>K[TFaFT:EC9&WdT5;G9g5-?/M=LOW@18?)b_G8MFJ6:MFaR_42GBc_f
Z#fg(K).GeaNM^eRK.f8Je+JLKFeR(f]EGE)TV(&=Gaf>JdL#e0-R2.@SL\<;e[F
c+,^2B@6++1_dd?S-4Q<9a:_.f#3MFfe0^0(]?KGZ5\U1b5-^EFK.F<I\?^+I&EF
g;JXgAfR?JQT&gEK^8Ab43HZ+;2:-F@K@<-NB1&Y59fFBTHVeZ0e)OH)f]HdAK@-
S\f<Y:0dGW((<Z]RJC5:9TJ._BT)[]D[OIL2PJ]WD05X5CF[g\-(]RLHIL(?,Hc7
-@+L46@YLV,YYSIOBFfCJI8G.HbcM6V39[<N6E48NDC,-[+F/W.3;GZJA(HE/S^[
>@c5THI_JQ_>YK,8LJKBXfTP,I\J9f-05Pf5cTW5?96gWZNF6\34A.SUg[?5QX,=
PTWbFV2[)MYfg9L9;=L,QTKYV=;-W#&?KRaQXCU#U]T?_+g+H6:@+]6I<QE2]/_e
UcDD4?&.6UIQ<S_30_VOGMG,YaLW&NF?fK94(4<\3X5R(6f-QR0_7#J<c.F0Cf8V
-6AFT[aA)=dR1S1]AVB<<?<^?(ES;+Y/LeED-_HO\-(TX^VNIF5CJU+KE;3UFc@g
cg\FRad]/]@;1IF.12O4GL25S.QN+E1P5B&GSD_H4@,P(3d[J5\?0Jf,I(cWLBb<
0J/OIRF5P/c)ZNNGeTW&31\DRFT,8Q(5M(7;IKgB+Ud9[Y^L\1E0B]8f9/7?a?>B
d2;cHT,9NI49JGH6/g#K0)Q^#KLIA5(:I)TOJBGX@b2#;:KJg3G2_OgQ(QFU<Lg_
QH_:\F9A.>997/#9\KV(W-45IS\<F^[0_b7B)]T86e^XK+Sc:]??c?)+JIT#bM==
9G5IGQ7?\,dF,:F:FL_-Ub,Ba]BXQ>=/\N#B,#&FBRMR0Q9MX]W+3R#R[2+XVOK_
KQ;M<8]Z6QNF&S3?)6K#PQS0Dc[AUQNB[]f>+O6b53+Cb\3T6-HQW&H1R&\+)Uc0
cc]N_4e<bGIe--6-17eC-CB]L5]9RZ-EfK6Gd#?B8/ZfIS]_(J=C8.H<HSA)NLS,
Q550]AT9?,/\gfQEM_)O)LI1@W()7WQf\6:SGJ8A:_b_X?11RQ=<F_AOfCGQ]Ca8
)\4aD;bREAM4<.GZ9,5_BYL&R0WJ=bVCZ>P(;gc_7bNU80M_6[&]#IL;WR&g2eLP
cWW)+\MFI8&JK&CS6;=8SFRgY+TIJ]PBKV0Wb,-LFY&ZA,9L3.^MKLf8)g>:)c5_
e)/Xe1UH6Q7/G+Q4B/af)bdB<-GggTRcQB];1TP)\bC-DJV;>3b>S&FG3=SR_/_6
A^/N/B:GDW0K=f6=T==gZ?3;L>/KA=_P/W^VM/1WJfCPZ1daXPHMaA0]Og4?(?\d
H(MYO>VP?V9F#+@]a#1XH9<D.fMK/NMQL6Mg/b01I].Q?Hb@b-D:Xe6BK5NW.48d
;5#8S8a6O.L[\6=Be[>]E2C+YJ.&FH9:QL2,)8>b\d2_PE5ILdYUBD_E\P,:&T8Q
=e<([agI,4[CKG:TEM9_KeHUNda3_ceM;N@f-<_/8634@eCCZU[1/&L67.:C2BM5
T29KVM9(]&2YHZ\]RDg1,-1DG<TD[.<+_)Z^fH)=TE6.<S^;bS,.L3=\b07@4@^X
AbQf9P99\41?36UC9ANUT/)d-@(Q8&^e];./@;<d:eVU;74J[/5-DOU=RL05O9SZ
@M69EOLJ-],6VEDcEd&g34aRJDBTL6HR9J5E/2BAP=L-7C/4T>dIa<,ID&_9;[LM
]L[PH2VMOg(eV;[B:,9/aBOX.eD8GG_.+XT\R8S\?_Ug4YX@5c<U,<3JDgbEIW@>
P^7>]V,_O@J1JL?[8)9dB8@f87;[?[)\^SDeLN(67=_9W=2:,S>=ZVT[Jf,ZH-W<
JD;#<HMXV2_.<Q1E+dd2>USDHD\60F?[K:_0,5@gIUM,8;YF[\:@bV4WB_)A>.3R
bY#aWfBdDd)4Ea5/+[]=3_B<>8O<&&cV8?2,f(\2]VReE^K:[S#TY\2YTIGTUc7M
f&0(/G@(U_3^eg[d8,2ME3JX1^cI0fXOf<P66<,D.W.#):[S58W<S7GA+>W_0:-.
b\UJFD@HQdZ8]_<d7+P6OdFF;7ca5EX1F6[P7Z:ZSC292;Q]#H8,B?X^OFHGGbVc
(2Na6HDX7Z\K[S^MfT-BISa,Q6H++<_2WC=e#/)IG1=2#M3L^:14D\8_bOZN)(HJ
DP.fdF4YR[9]&FGIL1C,a3JMc>&)g^KJY8b[A^J&9e-fBS_7?I&]5@-=)=O9^F7Z
#eFGeP2XBOA.>=G^+_@=/>?e_)I.@/YI2,Ec2Q4WH&M4@,\\g[e#6aX^C,eAX58c
[DMfX\>Q8IEJ3>d-Xd@M^)#8CKA7;#H&^S=NS68@-P5;-U-C+H-6<ZS7;I(/#)f(
<:Ud8@SLb@S:.?-YS56EB,@dGEMY@<D?-\MF)WaI6F>SR7WFX\c[Qd.MT#,FDZ#_
Q<Q0(2F3G1-PL^]3P6[)_>Z=@-9FGO^74_J/9/]R9@?-/6<XOD<7NUb^IO=RdGV+
eK?H^?8fYEe/_f.a3V]4/4UGc2=\TNO4?KQ]/d-7]?ZbESHK6/29PP<88+A67=G(
fX^@(LX4?+X8CUJIXCIMTePY#74J+EgUNE+K+3<WB?DZbaC1ac4^\WXA3,;FVe)@
cN+]_5#7Q:/GZXb.-97@78?ZNW</O-9/]5_C_;W<_+O<SE;R.0G(>b<BV2^N3->?
_aXCN0^0BU66@F2+bDPW.KKL>]ORWT?@9>2QRKeWbV3=c)71(G?]GGM)7Yb>0L^\
LbG/O@eIeDdAE=BS/^bg#Te.#NLU7,E[aE6_HGg+SMWC0O(PMd1FG#b77PdM77HG
Fg]gOMIQ@dW319R=Lb_g0&X.@N=YbPCT;&@TCU+XZf5:YV&:++=gA<N([5=[9,1E
/Ea>EO&W&,W^GaS5XBR?;NO_N9+O)678b0NJYC@9N\C)JOBF:Jb-<:.?\YU2d6Cg
PK2WS]Tg^D\)[GZ5._\ZPe:/:cSScbbNX19;&J9[WBV,0](@#&4T)=^/5R&STOJD
f8?5PEM62f-f/X7;SMcR4XXYS_#FKIF5B&?J;RCPg\E&F>EB8T6RO[>eRY)1^g8b
:X;X\AAG2B=M4gg1+F^Q[-I;I]gI.,6O>UadL\UEXX+_g##SE+/801f^95?9G@Tb
],/[BJWUS,MdX#4RIEN,^K]JS&U:Gd2L:7JI6?@ZK@]M\5(M^2gcXb_CO9BV7^L@
Vc7I4Kc#806SD@Og2(@O8Ta3@O08J_I8S=L,;,gX_IcW4H;a_;&gQ<=[OA#;f?4_
=gG]@D9_?3N3BO8dd4HO521T4/:?O8c@eQbH5fUGcYeCC6AQaA-.IZ0,;4A&WaJ[
JXg1Ug_,KYRJ.5D.ZbL(I;^aZUOV:ZTAa_F+gReKCXY[1)RISSaL+/6KKET,b20X
DZDJBEVbdgAe(80KY06:UJK9b(##HfMU(KB>B9TE7(FN#D7U+H]Me-(X.\A@A:.6
8.ZLgE8V#]WP+LR;>e)(X+PS\243HET;VW4_<]CZI6YC)Ca)<P,6CIcXUeH5Te-S
aIeGQ/+@d4V#VB@^;dALCWNLD-9@FCJ<c>CDd5/G\7E@O<Q@)0Qeb7QW@e_bA>N6
W.A-1&1&Z3bOYB3OcXP,VL8=N6T8@;;:,_2-N&#;<bAf)Z<.U/gc>c0d8:=[<]&3
B,CeARJ[T;#UgCE:Re)&L?(ec&3#c=K+YBecMO#YFB6RD]WdWNNTdIO7Fg5HU)6F
a@.N1P.#CCKcISA(a9W54d=NJDGO\+OeC\CO@L062fb6H?\YL^DY<UMOAI.Ma7-=
A11c6LR&7Z[]de2#B7E]fY/M))=OS(3HD-6X;>LU1A<gBFQAc:&_WZXP57)][@_6
AdRH&DTYOVc62EW\G[G#<R5AV[4Z/9:MS69I0_1b[NX_K1_AL:cOQdYP)9Xe3KBM
O,VI9DST^_>F1_5TX#+2R&9dC9Y=AD=S@PDV.16V>197XPZKB;JZ]9?E72AW\AHD
K1SX3eW;K_@<N0QCW3SK9@RF.(UBXAQe4_8a@V.X:C^JN[/>UR_^/>-1Y^YM]I@^
DHQ#1)OdXN@74M3Z_-[<4L\>IZ@G[e7(\-S^./GIF0OPB#f3H(1Q@d#dZ.<6-A(B
<DX)W@>.D6#&1g,XgKCRD&=c]Ubd.-OWCA4)L?_c1^JWG-<Q4\XC]^#G\ESc3W\:
dJ1A\#4\:,GXUZD9c&7LV2SR:5J,Sf:\62Hd;=JVNC(/)<GDeBeI&,=a-LCg(GAQ
+=6S6H43@T7(-],?Ia.d7Cc<)D?HN1[8gTJ9e1;C>T.Z,J[<4Q&2>XV,aX4:AJSS
)\,&BJ@V)NeRTKd=[.e<<\VDG=<C&=J-1>O9&XO[)B(OgXTC7EgV6P-Sa4?\9\)Y
5-=;ecS;8.8LeF^Y2DZ5Q-7FW\[6I4XB@b#-1<M+D,D2)GFMM\3(bD.eGXI>=dXB
#XCMY@dL/,C/?[D/NQUB^M3P9=VDY]^^?T-[]?R^7^,LI_E+AS@^[=2e[Gg]+\NO
gOJT6HQeFO=0RedYNR+3:U<ZP\,(DE7UF&)H+aX5+O_6.X]M\_GJfC?H-I3W.M\X
0g>,PS6VU0UR25RX3D\eKJ__6[PQAbf-08G)0e5JL;Q:O#XD.6;,VC]cG1=Q0.AU
W,4HUYQ-_RA_?T=EA]T#@@VDZ5V20+YMF.gUa>2,[2\A;JEX8R\+M.&RR7MAW(aa
?c@/YB4]cB@;AbSDEg,:,Q_7=U1Z]-GKU38HSBR@OVQ4S0Y;_0Ag]RB#;ZII;;T9
U,d<7.0L,]-dF,M_:OQ2fKaN2;5U[145TEfI52EJ[FL_?F5H(ON&;8F]DIQ,]BW0
:=HJ6fGW&?-FE^ag&<12,gCDDIb[A8bP.ARK0>ZD:RdXbI)AJ^^M=a@f@;VeSN#B
Of6O0FX0dRJBd+9_EB8He.]TMgDW3KLaKL2R07DQ>)Y?.DLe1D=1Q.1)Z5@2G3Ea
G(@VNL?bGYU2?B#4_MZUO_M:=-C<XXYbf)-Ha&W\Vb>_R[L[WO?EB=.3T1#5O0Qb
85:ORF,XZTb1,KXd=e)WaDc?<&G2Ma^0?R,Q<PPe=T?#U-<Hd2b)V18T6D7-;1X<
::BZK:2K)[H/JcdbP4-8::Z))He9?O>/fa)#0.+&-UBf+VMCaC[MZU-5C(>]_I@G
64RP9I>3c)ddAd+OG2^JN-1AO9O[7&O4:F0]d^f(OY\8M[&QM=Z@5_FOBY/gQ<6C
4XcR4I2>OI+DBe;bT[^:0:/_6O9A9cOJA]3#fX^57:4(D\?,]LP-_(WE)U)fGO]E
?H]:]9VZ2]Q<gge>V6RHd;;WH5OU5f9TY^>ZWcT&R\,C.KDfZ0O@PgW98OGe+52W
>5[Hf)C9K]GAAL8R^^&#;]B);F#BGcL5>+64J[6U[C(5[77/f(a]FC=EG\0Q(09@
Y2VT(.(:T;&J^9:2UKIOcRdDQ:4(a(aD5F_MT(FIg>NI7^.;6RY>?#+E7C<@.Sfb
Y1g16&6XOD2Z)_W0]H?VK.&>[g:Y]SX=CAGBU9NYf_bcEdKC<DOb#G.-aLcW/^@>
[Ld18H2E1:GN4:8QWGZUG(\W>MIJ9(-cM8NS,-.MXVX6-,-UAW//9D>S/Y_[Ta<,
VTB(01F:8_fZ\0>gJgIe/FFSQaf-Y2.9)R(Z_BZDe05O\RgX>f1JBDbTFE-@-<8=
.PVBZe_9CP<?PQb[>U0O,+K:6f^RP0f/<N:5J1@bRc10\afU9R50?X8c3ZAW:ae<
,aV2=/N4([=+g@9FIGPZQOGFUQDI34K0X:(NeHGC_.>,LXCN[a=FQ=9gdST6\1AC
F)Q?X=O6S-#N9CV#\?ACWMO271eY@NQC=$
`endprotected


`endif // GUARD_SVT_UART_TRANSACTION_EXCEPTION_LIST_SV
