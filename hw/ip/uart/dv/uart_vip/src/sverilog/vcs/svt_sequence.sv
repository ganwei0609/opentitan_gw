//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCE_SV
`define GUARD_SVT_SEQUENCE_SV

typedef class svt_sequence;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
virtual class svt_sequence #(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequence class then an objection will be raised when the
   * pre_body() is called and dropped when the post_body() method is called.
   * Can be set explicitley or via a bit-type configuration entry named
   * "<seq-type-name>.manage_objection" or implicitly by setting the sequencer
   * manage_objection value to something other than the sequencer default value
   * of 1.
   *
   * For backwards compatibility reasons the sequence default value is '0' while
   * the sequencer default value is '1'. So by default the sequencer will manage
   * objections, but the sequence will not.
   *
   * This does not, however, reflect what happens if any client VIP or testbench
   * sets the manage_objection value on the sequence or the sequencer.
   *
   * If the manage_objection value is set locally, then it replaces the default.
   * It can, however, be overridden by configuration settings.
   *
   * If a manage_objection value is provided for the sequence in the configuration
   * then it will replace the locally specified value.
   *
   * If a manage_objection value is provided for the sequencer in the configuration
   * and there was not a manage_objection value provided for the sequence in the
   * configuration then the sequencer setting will replace the locally specified
   * value. 
   *
   * If a non-default value (i.e., 0) is set on the sequencer, it will be propagated
   * into the configuration to be accessed by the sequence. This will force the
   * manage_objection value of '0' for all svt_sequence sequences on the sequencer.
   * This will have no impact on sequences which have a manage_objection value
   * provided for them in the configuration, but should override the manage_objection
   * value in all other situations.
   */
  bit manage_objection = 0;

  /** All messages originating from data objects are routed through this reporter  */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /**
   * Identifies the product suite with which a derivative class is associated. Can be
   * accessed through 'get_suite_name()', but cannot be altered after object creation.
   */
/** @cond SV_ONLY */
  protected string  suite_name = "";
/** @endcond */

`protected
65Z8@:]bC49e(eX75+6A[Z[eW>Z@+eL]V[/H]0G0^^KH>A841X?25)^06>#>gUS0
4OUE/I[&^_-UUUc_7T,337^G@cDJ5#UR-=4HO72Y+b6BD8@T^/<O5R^0O$
`endprotected


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_sequence", string suite_name="");

//svt_vcs_lic_vip_protect
`protected
3JUUf?_VH_MM8@b+2GXI1157(2?1KIEfaPY_CfFIZ-2e23=a-?()-(B4O,#d&M)1
4ZOB[^(ZO307+SVVF(Y-U7<gC0XJ>2H;M7ZaLM=^2fESZ<c?>+08Nd2F?.7-IXSJ
8BZC+,_]R8J/[S9=5VPGc@@-^TZa\A)?MG-9R4Zb(TFV:;^Pb,]_IH>eOf/11[ad
P4Z\&OPM-W0;b?(O55^O\4,ObB_T=XBbEee=(,L3M]I;R\TM(SMXY0Gc3YD=\J4U
C,1I=ETD#I4Q@cH@6#IUc.5MLLF?Q/X3UOa?.^cB\;@TYSdB[Q>HefGb7X>)dT#G
d84=@DB5T\[7UaX_N[9.4B3:G>,F16PO]FVET>f\\3=0ANJ_I/X+]6(B22.dV9<C
GP\Ef2E5@+Y^O0J7?@N>S2=Xb-=9@VU90]:Y7D-?370;H8U-_\D:S=5MM9S\CFRA
gP0[+b)ZN7:3.QJ,:TdXZ3=,^8MgbPgQ/VTZgFg,\AC<_P:e=LGgC?5MI$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
]a3.64:3g\/S:W82f8=9W[<D[<[FbN\_JZ#VVVDWH_B[XZ@_(eQ=0)Y,S.)@H>]U
4V>@/(;#<,:9/@8.C5I3V]F-P522Fe2]<4URcZR^3<3\G]98=X.:.a6N,/TLO3[K
E[P44YUH88EADE<<TE>;fLF-1$
`endprotected

  
  // ---------------------------------------------------------------------------
  /**
   * Returns the phase name that this sequence is executing in. If the sequence
   * is not configured as the default sequence for a phase then this method
   * returns a null string.  This can be used to retrieve information from the
   * configuration database like this:
   * 
   * void'(`SVT_XVM(config_db) #(int unsigned)::get(m_sequencer, 
   *                                          get_phase_name(),
   *                                          "default_sequence.sequence_length",
   *                                          sequence_length));
   * 
   */
  extern function string get_phase_name();

  // ---------------------------------------------------------------------------
  /**
   * Raise the objection for the current run-time phase
   */
  extern function void raise_phase_objection();

  // ---------------------------------------------------------------------------
  /**
   * Drop the previously-raised objection for the run-time phase
   */
  extern function void drop_phase_objection();

  // ---------------------------------------------------------------------------
  /** callback implementation to raise an objection */
  extern virtual task pre_body();

  // ---------------------------------------------------------------------------
  /** callback implementation to drop an objection */
  extern virtual task post_body();

//svt_vcs_lic_vip_protect
`protected
&DL<>/Jge=D2T\5NCL-]TCBgdeR&DZNZf\S[A4&O?a1^<b17S56F5(e0eAH5<6dO
N+/YC2fP9F</AJ6g9aQZZ2:eMF6cO8Bd:MCW0CLC08CN56dN(A\1,)&OOWeNag4.
+NAZ.[Xe]BO:L)6YIJ\-]IF\/[Xe]2>N;dPE[_fNE?>XE+L^D1aEC3:1D:L[HP0d
()f_8I.8\&B7B?6G@>(/0c_O/JG_UW\_b3,>DU3<8^9YPeaMMSDJP+Cb-f3P\>_I
FbG])0EOD@5f0+FV[F2DP\Q=I4VHObT-3JGfRTU(X&-C+U4IJe+QgA)-N-SC6FQY
DMg6^EPR2<XYRJ(0dbee[X=D@]YUVPK;ETcPM/SQ6UGcZ.8D8@CA[E+?O).OCgCO
#DU)&Se];WC+CE:^;&.IFV+S^STf^E6_gSbIF<aKg=BD.,1BOCT:@>5OLT<R@=dQ
)M]O1U[29(I].L2&JA6[]#/[OY?0:_TP2+e4N]cT?-H#7,USa(O@E?MbTW5>GZQ^
H5<JQ@31EI068Ve\R/TKZf,]KPD58Y_Tc;e2d0:A4;CJ3gb2d90Q1V8QbBPg>.Y?
LfJM1D9PN;XbD9RF<A;@:0YJDRX-+?g:f:\N\^e6f7&.PW[5>a5]D1O[S^aC.^NQ
GTR7)H9<<H,D@_.1,(@6;F@@V,aY-6B?)Y+9g<OXRLgQc&J5X:B4//=SC,RM,EO.
B5bD23AW:U1eTb=F+Y:EEG::.OgL:A87L[:UVg)?\X6YI/4aP,FLXaQ?+A3OY6EV
E41FgK&\JLFc6.2YDe<BfNa&0WS3:KG,cb[2;:(AK)IN&PI])IJTU]0J0#NHT;>R
R]51]8#3L?-7c1)MXEP=^GF_=X8OS3GLOGc7ZD&0b>W?g8;a(U+RU50JN$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Obtains the starting_phase property from the uvm_sequence_base class.
   */
  extern function uvm_phase svt_get_starting_phase();
`endif
    
  // ---------------------------------------------------------------------------
  /**
   * Determines if this sequence can reasonably be expected to function correctly
   * on the supplied cfg object.
   * 
   * @param cfg The svt_configuration to examine for supportability.
   * @param silent Indicates whether issues with the configuration should be reported.
   *
   * @return Returns '1' if sequence is supported by the configuration, '0' otherwise.
   */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method to get the do_not_randomize value for the sequence.
   *
   * @return The current do_not_randomize setting.
   */
  extern virtual function bit get_do_not_randomize();
`endif

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to start a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_start(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to finish a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_finish(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);
`endif

  // =============================================================================

`ifdef SVT_OVM_TECHNOLOGY
  local ovm_objection m_raised;
`endif
endclass


`protected
+UCgf=PWU(UJAZSKa@K?^/bA-KKIQE=GdMUg(Zdcb@EC?TK=:?+T2).OUKF3caN,
g:TFaL.T]U5;(acKGI05M42^-KIJE&T-0\Kc>F9V]-:>Yfe3Gf&Lbf-(Z,A(Q1KA
=F4CKG?(7&>\0-RQ>WGEg((L;.-;+SKSc-)GIPER9S#AU:^.1c2;.UKYT=?9fFDg
+W[Tg]&PNTWaXg8-5HRU25.I2,IAI,g.eF^NY;&f3]JTL)?9[6f\?=A;\SEPK+6B
+MBCF6;L:gTP,]Zdg:,4T7bae@eHWA^J;d#:[-PEATJ^&-7eed2gUJX:)Z)aBC+G
PTYCEE_#JX=A_6f.I3/MC(Z,XLX8bI)/H0c.4.>N@)?1caUER_]BB-d32@_H#0W5
/,3YEJ4(Q55Z<QdQfS+WfESGNU3\-1Pg_Ic5e3AS<7PI0>,,#UZ:H3+g=8M0ED@U
4<E>HVPb:AID7:gTNB9EZ&gR>_dTH+[=_fg6<?:4-J:B;7fAUWG415KZW:M&Z9NC
>TcZ:G+R/RKQ.?(<(NXD_\@LfY]^(+EL0/f1^.Bb+/eU=[E9E>Z-b?<\-N+1.,Ga
&.;f)L6LMQe,FR@87e+9cQ69,A/aM-0#MH>1\U/&QZ15I9c4HY?AL)F:IMX7E3.O
\V-f-8CH-T8g_--;R]WIZ&UZ8>,Ab28.F1eUDK,)SD=g7#HMgY.ANT#=Y_:OU6_G
[^16_&]VGUg_A5_VU/48U>5aUIS.GPZY/(K64G\1I29U.37bT5V&_9W#g[e:S?L&
J(WeI[]d0eGV87JaT8I)N&\X8bWV^a(6@.9UBLX5b]af)LJM?]?J-IE[S2P1VT7I
8N6a;R29Ea:.63OH@@e3Ha1::#W405_#9/7R;]^/FZD<3<Y-RD.A.c_QJ2Bg[b+K
#(#B--D1D-=Sd\(aF8@4W///R8@?9\Q8<$
`endprotected


//svt_vcs_lic_vip_protect
`protected
RXPDd67M4^RR59dNd2<Ubed)JCC>N?CC5ffbN0#Gf4D;g7F[-+=@.(G;KgQN@TMK
@.20=(51U_FCHGSXMGS..>3_48b)dLP^RfdZ^3PH2+)SaE6d6-3R\RWET1dO7<K0
LZ.:1_c=P0gH&L?S9dJDG?T5IgNYEF]4Q04J_[M&e=Z5)[(7-RP=G3eT#+Ie(3TD
H.DEB5PLIJYQ[^JQ(\aH\WN?S\0_Q9^.KABb=cO:IcA&b@9A+P7)^FU.e.UY5@XB
_MQe)9&B]VI:QD,6_+H.F:.3+S3QAOZg\.cS/DSSU;FK>d,7QX6OMH:EBgcK6e-Y
F<:)Z#.=2A:-T=R(L,@2H,5_U/:FT58@(Z[A[MFF>9X.,:aS]K.]\I5RQ-?eQ-;f
6;2T>OS8R0WL?JA5?=X;X^G>YO:21&FL:-6U0<:SAS6EMNYJ>1YY9@#d_)D/K:Nf
IbD6X@)9b@Y524Kg4;D.0+NVQ;=gP1_XT(^K=PM7/;<cKRMGW9T07OPUD_]5,3@Y
GM;>d]ZQY;Pc9B7R0c4;cP@M2C30YR\7719;c3SVQ?ORS[=YYJ?<@.4P>DS7f[93
,c5Q&1UE7bAc2[7+-<6D[+O_(>bOda0[4V-G5WaG/;FZ.MY7C]KYFCCK+:+CX],[
K_ZC1a>:A&;FH[V.0DXbZG.aC(-5-dE)-e?9f8e_K7ICJ-6R;/B+4^4_BGgXC0K8
RW&d1Z:P.3Jdf2aL8+B7P2MDAEN@8.b3<TC;,+g9X/@ONB-;IA9&3^Je#12FULNJ
]RKXEc3>BZ5AV2)NaY-+G/F&a4:,@/TLZPe5.Dc=/S)<(<9912VY(\d)Hcb)cS88
D.0b+IP8[\5#KQ1;=#\:V^Y+Pe</<HE:7L1KN<ZPIY)T+4DX?b9)TBH\Y]-;_:\C
\aK[FARW=fD4D\XOF<X=3Q0I[b-@X=aTEOTOGI^]4+aP]G1&bT5=6YWUL314YSAD
aCT_H92/D65UT(K)<R5;^<f#,L>(]C-A8a#[.f4V9UV\RDCJTP,RQ+J@(QaH&+[F
V#D^2ZUMcGa2C<UaR@K3b)6C\Y0I7NJ??7RIYd,RP-,C(_Tb-QO5QTd:Hf>c[ZFR
[<a6+]+HOY\\11,^8R@55YB@.E5DaR/4;+(+?4CRIcEZA=W_b,:c>8XDVaBU:dRW
?Z#7NM_5P&7VYdCC=X>gRS@Kd8+a>@b(a\SddcdZC)OUcW).KFR3=8;YHR3L^4d#
>,,.&7EAHRT.QP.bH@N/)#E^UHR-M;\6QC&(&&-0EQAX8#(_cKB5eQ1D<8bGF\#6
A^JYR\-cRYPRaOP(d2)H]=]7MELG>c>O9fNYZ[:aVI6SNe>Q5BQJ3CDC])BW6:?B
?<J:M-)U]e3e(;g2/O.cILVXRe2(g?3]7OEH<X&;:2#2@a-4277?))1D;?fRIC7_
0=SXTCaJD:^MV4?g<g5cUW?=KKSOS:O/ee]L1V]7\;Ke&-64H@9d\UBa6aBI9,^N
_HA^&-7?=CV0V0,_6?;L-<b<H)6)MeVJFC[N_7[)#LH&=;JK1#@LACN024E0KM80
dNO/bPL=&TZ\4]EG\&cC<SgCXIDE:#YSWP[FU7H<e6b70JJ^/IbHCPIC<POGKHE7
b82>bPdUY=[gQJ><HC_f[9SKX9;:GI\7?ZH<8_5XZ?PeA\c2+1)FA,U9;XbAP;Re
S/+I-Jaa)PH)R24Mg2DLW-E@b_d1(a;,gWTAd_fN4;_6TW3_Qd020bXQMHQWb5U4
0,3+a\K9YXHfN](6GL(OdbDT)/F3^gM>+b-ffKbDUK@27NV_g.U&W8QT[b?C?Z7B
D@:/]d(G^<.cUV1gJ]&_@;\Ud)6VS#bD,^JA1ZVHXI_5D0R=:GB:XE+cA\-b_D@P
P3P]G_9:TS:Hg^5JQA,(UB<T_K]1]UW4[A-+8@-W2]E>17YSa\WHaFQ(A/L,AEH>
;e.^M-2I/,aS<J0_\R@-@MNU,Td[E&eL\#K=#9>_C/XHL0,]B[g]&(3\ggE4JR?+
g:2_^08]5c)#M.RBeTE#T0[e@F2I5#8-5]?)/f=\_Z=Y(1bDb(9)DJSCP+PRAL2a
_c-A;Rc1-;fR4bE)J6M)+=DA]1>Y56?#M,Q/:QUd]aR7E@T:S/gYA2OJbSO/:B+>
AcXC)A<7cVCa]T2OS\deW\1)fV(3NGVAP<3B#F8aLg(=;(/GdXI_1QfY\0E2CD^g
<9=6WZbCbL9:fDg;c\+13DK?#4f4/,9N?Wfd[?.K1GRO-5.\@@NH[?1_-3[V/#>[
^4;53PG8)gR:P&eC.M[gMK5#+X3(.KTD@5X6K=[-IPM\T:bTdP[E6677YbZ:U;Y)
6_.@>NA]6KJV[02_-CG>b1?NGCE;^f#)>-De=F6EJ]S.(HSgGA6=e<I>c/bJ;[UA
EGHbU0F6VQfBb?f9;#2^;cPKH8aVH:/9[P]W_E.L@C/OY&?0Ve0/U;1,TNa?\JN3
_8b6\>K+Q,1HOf;FNa@EXKR..OUVCW6dM\8S35T6WGULZR(E1X/BgS?G),^cAZd)
:19:;b/Y<I]7NE].(Kf0L]c]1Da+bRIeMa<B&dC]=VE^;L>bG8KTAQTLU(FgaAP)
.I(<AH.UW0b^M;G)gAWFd^U>]KHL5-ZYWg?^bdZ[eN^D8S3^FE2@64TI8b7;HO=@
OW[>A<F/&fKN#8@#QUBV.Fg\Y(eB;V).I8;e#<6BXDg1)YSL4&[be1A(/]_A805d
R8E2\<eWGO8N_B5[0EBMdD\#B;]XW=;3J\>:PFL]D/SN-N96ER2d:)171cAZeLUE
+>L+0I(eYgJ)OQ3585ZP@Y<A@bI>+T?8[6WLK\&bSIA/+4a_TD4X[Tca\WJ4gYNa
d5\]]UH6:.fR:^P/JO3E.V>f+,T/F^[DT3U7b9_(1[T)Y>C(LJ0,d&d3-LVW3CD-
bD6FaEH#O0QZ3<#/:_IS6-:86,d#P?&W7J4+Y.(f0T=Yg&\Mc>GW?[^YP)E;E\0Z
3^:K]:V2c9EGf>7#(NaW-eF79?ZW?fHg4Y[aI1SQC>SgRVU3?Q28d8Y:.,7Q6aJH
KG]#MZZW_C-dJc,P<CdWd3&6OYFfdAb=HI@J-<MIB[]He\3<KTNAL6HU<K3U?Te0
:XI&+8-cIXN4O):)bK@Qe@JGYLOR6+X]d/#Kb7B@<?:7;H4@W5Z2UH7g55A107==
2Q@X#,5U2f>dT?Ze8Y)P@e4;.f)?=_W/DD:.)8=RUb@BYc7W2H2^4V0:3;B1[Q_J
B8FU__R=T10Y<I0+,WUWJS^IL;W8NB-UcE<XYDe?+fQ\IEBZ+&6c\_f4>0Y&LJQI
DKgY>V4F40D[MLOWJL^QPZ<^gCZdf&^S):SOEEfG_bf(;Se9Fe@AIg\0b6W45V=0
]S=A<IO[19CT4@bNCAe9eY7N\0[EMg[>Ye(g5QZ+TdV)a6&\7D9;:6[1d@AP6L?>
Lf?b;Y\-#3Y@2:e59IBF:SI^gA]Ob-AN;+bNaS0W9OBBG:19(8._bE6PMM/,Vb<N
Se4]PD<T9R,QJ-e2B+V72S>C[;a]bI87L-#CJc.J<1YD)W(4QHGgMIKUSJWBO2.F
ObdV/XKb.)-]e<_4Q1VTF,Z;KeCB<)XR+H7);WgU>\CWYZa5-bZ<L59:78BY[^WH
9Lb]^7-#_=2XL>[[B,+2Tdf+FA)I=:BJcd6Xc2>g<[Ya?J<,6Dc.0dcZB&G7.K+a
eCP/aaPRZ[56VVEM&/S=fO5SU7[1B&H)D:3U:aSD]OIO:VbY&E:L0[;Gee]&Ha)J
G:YA;M&(/SNX<NRXPd_aLAB8NQ:QK<4gEZA[T3:;a9(_8O]C;=NSc:+KD3e0^)-Z
L;+C0SCKb4cZ&1cf/Z4MVMZDCD>-W0b^3A;E?\IQ#YD72J1^WE]L/UFZ+E4-7YFD
493CefTPE?b1:g^B-RNTVY\<Qe/5]f_]])XQH3<,-^>S2-L#A(^W.BO1P;7[XLCY
,CGaR5^EFE2--V_.IDZ\97^#?-H1b;8abD.UF?8dWS;UeI88I-[7_N.,5YYdP)a<
c[FXS]d4WYJMWc\62abGaY,;f.;[?)XDgQZ)0e3A/R4EWE:<&Lf&4)?XBMS&G^8&
I5a+PJ4J+egY:D8EWQ^P:=c1)E+=.N]USTaOC@Na--;GI8+TF)f<;K5@J1(@,1B6
XO?]F=]J4c9/fB<R6N#>4.Pg^NeM)(AA&<fOFe/E1Vb.FBOaRW7Q.A7e/\.;X]0K
+P<M@^(181J0.J4a;9CF^TcN<2aA;=:)H7#N/NK=)@#.CSa<T17)#]CNNOcMcV1U
f0_[5A)P@.5,7F_gP<58bGQDcXREK;A(b[G:)2L;E262G\9Y6Ba):Tg;Y:M2[NX@
^6V]CV=OVUNV=J)ITMHb_7(RN,N91AdM<BC2JgEFbGPIGK,c7f\,_@U_&:bFDEPI
+6QK]T3@;3)KI^VY\-Zbd/1;Pg<AS<F-W;6V7\/D[e\K,B6GF-gf6QDOUSSJR)D3
Y[R9d8G.WAe.:2TYMDO>R6VIR_edYUF^F&1IU_I0EE:b+/E1VI]7QVZa.e?8c7:e
b;.UF2CbBHP=EP#6QH]JA(H[gc#>00&L.gQU_LJ,:DSffJ,a883D7L&9ca3B69d5
E3e0[PEH73:@N(&14C;1&bVOSM7/R]BHb<\1LfBR8dGXA2N-+70MZIBb&D;G3>HH
cdM8TR33I[-(fI+OFNdd;_FX+Jg;.L+DIRAfg<F61F0RV>Q=T,9K^@]7<XGbB=_g
U#A^Q\Vb4J,IOVMC)0b)8dCT?V7>TYC/B)^b/(fL8^G_4f7[-3RcMT0019,ZZV34
?6BBIGOK3g<K:;gW_GAPQegK@0Z93YGe+5MfGAN1^Yd#b4UZC@Z1cX(De49G3QV7
S]IgX_CC\74-Q]=IdXJ;a\;[<Qb?P>U?30Ig?3ef#R;@<SC@.H28>EWBA0:?>BbA
9QRLU>W<BPX=]+J-DQ93(4?8Q:g-#S^J;+?;>-I.5B>-CSIA_@F.]^gDZ>EL[E-=
RZ-R_/)UTFP#9AeRbLcQ3#,Y1b#K:VB,3O?3U)/L+YXOD&/B<g?XFM?6CQ+P]Xg^
Z:8)Y+Ic5P6Y](+_[(P):+d&(egNF64Y\:aZ0;5;KAcY<+d\ZJ#bAMSd]D_-.#22
f.Ke.[^V4R^Z\;SYaQ.MU-MIW4WKDO]2R3FKI>/dbS8-)QGF4eObgV-QDV9&cN_3
TY;P>G7CbVT5Z0Ce?NX=IS8BOOJABW72O@NV.KHO[^=V>?K1IJYAL0F:.+W-3=>M
E+HD.PVRO[K:TG+)CSD?Wg<2(@GWZ-MJ6GQBOI?;1,QZ-f^8B2c(P6\PZc;06M0?
T-]4P9ZZcT8@?-S)WODgY=2eE7AK@Q(]73AY,eHc+RJX<ObGc<0&T;X1WGJA)0GX
T>DWK]+?g3=G>WG<C=VcXg>cIK4;FMP-ER=M1]O?0KQ3>9OC725Da/VF&^e8.0FA
HCHUTgX1HUe@gG4_LNgQ#<GA+Z\PP;>X+/b\4<F]eAJPZ[Ef-<\^XNHfbV_R(<ZG
JR/ITP+-[W2B?A&S\+:(-eV03X+G,Xd8\QK29S&PE._=1a=fOc1Nc>KI@>LWK4.b
V9&KLKYW1_NG/@E14P;X+SWN,J10/eSHBNQBIaICEY9#4WU_CVD@ZVb90-HbSZ@[
IA&3&Z)Ha7bg8_+BSb-/MNb]cN28R7LSJC6@P]D&>[L)ZIGAD8<+X_bA_@F>F::b
A/,aH3f0eVUHZS:XSP=WgGQ6:f3.4K##<-^-^5FT5;Z2g<G&PN9f8.\^&_;:OVg^
/VF2PO)@Fg0Yd;Nb60KOVU+dIbdX8RH2R<RQPZ5gJ)+2QB:8)XYZ[.Q[0R>R5[/]
b/T1UIT>1),2WD___<R#E-9;^]:@)C02Z;U9H.PW+3^_:-d^+Ia]3/V&1EMR?9Q;
6Z7]XF4]9:_G;eD6L@ba5Z9Fa&UYA-+T2>ABQ//46Xg>T#bF#0HKY^M,P=<J]I79
1@;X+=IVSBNfX-gXFIfWT(FN0-&.3(9T&-MKeaO,3<Y1fC@@O0@>J.O8;]df1.[e
ID93^9V-O4\cH1_<6@(:;^LJH+BE.:-VEL6UPH>?:IS2Z]+O8bE[.ZdXLB\L:7UF
gg&gX+Wdc,.6QKPUZV>B[We/+eSY.W--]B_\OHAH>\:AJM(S,AYf6eaJWU3\BP5g
&X0\Y/EJL]=Tg5KBN)I\SIZR4ZYJ1O.)SOY<&Q<@A&D.S7_=.JC8&8U2(FQWOc+L
/g>A_HDP:69N-[6&e\gQQf1=WZ#;\JB@2J6L_=(SGC]JMBJYD-5(-T7_50gaSPb+
(M5H)#d11g(:c&J+;)^&MD.82V#;TO7/IC25(0gf2>[2[<R-/.g9V(S.T/fCJP#a
\[EM>P#)L(9W]TO-TK)8^FTc6,B=_NLZ3^YFN?=ad\0GU8V@cb-Z8;U41V^O-bba
[NKBgJ&UZL)_,d]LSgVfLW6J4)IRd5EZgc<XM+Q^[R4M2EC0+]-JD(dRgSVMfNF2
:NX^_8#<:2?4I6&2V+VWG5=O;KfTO>3Q)I,ET[/I,dM9HHS;#8,MC/.-:6LeK43Y
A--,RC+)YZYRg@[G07-42<7\gS3129\Z+D2,<^5[OV?(BYJ8/(P#OP,+ZE:Q->G]
9U7R:7RA=(Y7R6D_/ALVR?A[#O62[@B,+E#C1=MIOLI(G$
`endprotected


`endif // GUARD_SVT_SEQUENCE_SV
