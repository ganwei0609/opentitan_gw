//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRANSACTION_REPORT_SV
`define GUARD_SVT_TRANSACTION_REPORT_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_REPORT_TYPE svt_transaction_report
`else
 `define SVT_TRANSACTION_REPORT_TYPE svt_sequence_item_report
`endif

// =============================================================================
/**
 * This class provides testbenches a transaction mechanism for reporting transactions.
 * It reports summary information for individual transactions that are in progress and 
 * accumulates information into a summary report.
 */
`ifndef SVT_OVM_TECHNOLOGY
class `SVT_TRANSACTION_REPORT_TYPE;
`else
// Must be an ovm_object so it can be passed via the set_config() API.
class `SVT_TRANSACTION_REPORT_TYPE extends ovm_object;
   `ovm_object_utils(`SVT_TRANSACTION_REPORT_TYPE)
`endif

//svt_vcs_lic_vip_protect
`protected
Q)ABBa)@/Pg]IA<cQ[.JS6Y_9(?YKJ/?2gF:Sa]>Z2\P.4B@G,a42(7DTR)J-57;
@I4P4766,&_SHHE&We[_Q9N>[+;\N3:+I[=6)LfP0:8XGEd(=]PRcIQA#5+aUg#^
Zb6OX0L+^-C)CH]g_Rb/=QaYaJ&30HVM:[WR[^\;g_VGM9&5beR-@<=YOJ787VOC
UAR?(GB6RG#3_f^fB_bJ>X[9PXRS[=4-+RPF@f=.C^^Z;=>(RgR&/P+@;g\D4VL&
L+=H+g35(?]fK5S/1>#b9QO-_=Y^#=+[gO]OQf#2+8XU@Wd<#R?H?]9P,a+H0/Bf
1&T^I7NBW\HU]DE3W9^X13EeONT:/f7a&E<Y3Rf^;\Ua3>A1^M62+@GRD6#=M+K/
8?@W#W-AD_b^LK0:&NR\?C6KK=&3PFUfcXYSbJ>,-G?NJR-M3;QC],g;OP(g7VGW
5)QRCc:Q]Md/\gO3+Y6fE(@=XYYZXfKXP-LaVD1)1BO5eY(?R]0MZR3B9DM-@?6D
90/.fT[aG=]c,B57RgQd?W794JdR]86-ZTU0DXMa=2?(LWR\F3W^H,-TaAQE=)C8
U4X)_<5@J&Z3MU<K]Sc5=b&ZH1D,F7ILVEe<>>GPWPTJ6?P(O]gEPQ<4-9#1gWe9
HPLKTH#P#GP_&L;?8SS(=T&Z1$
`endprotected


  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static vmm_log log = new("svt_transaction_report", "class");
`else
  /** Shared report object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif
  
  /**
   * Used to store the tabular summary of null group (i.e., summary_group = "")
   * transactions as seen by all of the chosen transactors and monitors.  This
   * feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this
   * report. This is the one summary stored directly in this transaction report
   * instance. Grouped transactions are stored in their own `SVT_TRANSACTION_REPORT_TYPE
   * objects, inside the grouped_xact_summary array.
   */
  protected string                   null_group_xact_summary[$] ;

  /**
   * Used to build up additional labeled tabular summaries of transactions as seen
   * by all of the chosen transactors and monitors.  This feature uses the
   * `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this report. These
   * contained transaction report objects are not provided with labels, and are
   * simply used to manage the strings that go with the labels.
   */
  protected `SVT_TRANSACTION_REPORT_TYPE   group_xact_summary[string] ;

  /**
   * File handles used to create a trace of transactions as seen by all
   * of the chosen transactors and monitors to an individual file. The
   * trace feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to
   * create the individual trace entries.
   */
  protected int                      trace_file[string] ;

  /**
   * File names for the trace files, indexed by the group value. If mapping
   * does not exist for a specific group, then the filename defaults to
   * the name of the group.
   */
  protected string                   trace_filename[string] ;

  /**
   * Indicates whether the header for the trace is present (1) or absent (0).
   */
  protected bit                      trace_header_present[string] ;

  /**
   * Controls the depth of the implementaion display for the the null
   * group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      null_group_impl_display_depth ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * summary group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      summary_impl_display_depth[string] ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * file group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      file_impl_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the null group.
   * Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      null_group_trace_display_depth ;

  /**
   * Controls the depth of the trace display for the the indicated summary
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      summary_trace_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the indicated file
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      file_trace_display_depth[string] ;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name The name of the VIP suite.
   */
  extern function new(string suite_name = "");

  // ---------------------------------------------------------------------------
  /**
   * Create an individual transaction summary, with a header if requested.
   *
   * @param xact Transaction to be displayed.
   * @param reporter Identifies the client reporting the transaction, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern static function string psdisplay_xact(`SVT_TRANSACTION_TYPE xact, string reporter, bit with_header);

  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a queue of transactions.
   *
   * @param xacts Transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_queue(`SVT_TRANSACTION_TYPE xacts[$], string reporter, bit with_header);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a transaction channel.
   *
   * @param chan Channel containing the transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_chan(vmm_channel chan, string reporter, bit with_header);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Generate the appropriate report data for the provided tranaction, placing it
   * in a combined report for later access.
   *
   * @param xact Transaction that is to be added to the report.
   * @param reporter The object that is reporting this transaction.
   * @param summary_group Optional group that allows for the creation of multiple distinct summary reports.
   * @param file_group Optional group that allows for the creation of multiple distinct file reports.
   */
  extern virtual function void record_xact(`SVT_TRANSACTION_TYPE xact, string reporter, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Method to record the implementation queue for a transaction
   *
   * @param xact Transaction whose implementation is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Implementation hierarchy display depth.
   */
  extern protected function void record_xact_impl(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record the trace queue for a transaction
   *
   * @param xact Transaction whose trace is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Trace hierarchy display depth.
   */
  extern protected function void record_xact_trace(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record a message in the file associated with file_group.
   *
   * @param msg The message to be reported.
   * @param file_group Group that identifies the destination file report for the message.
   */
  extern virtual function void record_message(string msg, string file_group);

  // ---------------------------------------------------------------------------
  /** Method to rollup the contents of null_group_xact_summary into a single string */
  extern virtual function string psdisplay_null_group_summary();

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summary report. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a transaction summary and/or
   * file group.
   *
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_impl_display_depth(
    int impl_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a transaction summary and/or
   * file group.
   *
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_trace_display_depth(
    int trace_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /** Used to set the trace_header_present value for a file group. */
  extern virtual function void set_trace_header_present(string file_group, bit trace_header_present_val);

  // ---------------------------------------------------------------------------
  /**
   * Method to retrieve the filename for the indicated file group. If no
   * filename has been specified for the file group, then the original
   * file_group argument is returned. The filename returned by this method
   * is the filename that will be used to setup the output file when the first
   * call is made to record_xact() for the file group.
   *
   * @param file_group File group whose filename is being retrieved.
   * @return String that corresponds to the filename associated with file_group.
   */
  extern virtual function string get_filename(string file_group);

  // ---------------------------------------------------------------------------
  /**
   * Method to set the filename for the indicated file group. Note that if the file has
   * already been opened then the filename will not be associated with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param file_group File group whose filename is being defined.
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_filename(string file_group, string filename);

  // ---------------------------------------------------------------------------
  /**
   * Method which can be used if there is only one file group being handled by
   * the reporter to set the filename associated with that file group. Note that
   * if the file has already been opened then the filename will not be associated
   * with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_lone_filename(string filename);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
XUW5M=#C,T;6[EQ&7[ZEJeRU^BLKbJ:Y;feZ5H0&\Yfe[:1?..R[6(O@H?B3\\?]
X4>U=.F:6>cY+FBdJ]D\SQ1/,5W_@=b7(C9(f]F?=e]^X7[-#?@V0fb0\Hb2?7G1
.W;R[&f5>;dFTA33DVVQVK1.ba_EQ#PT&8]ae,D_T?/&)S]8SWE.4cUKD80=>_T3
I,M-e][Q(75INL@UTT-DW-]be?_U&.WN5URF+aYLf@Q0C2Da0J;&99=/1gIV.)5<
eg/F]E/@;61ZOT?YHLWALQ<@;QWg<ULaD3,]4S:-R-=H#0JLf7NANe0@3@Fg(QVK
baHLKU]::VCcKedDef>9E#Kfg.b@#,U3V/(^)VOWd]e9D3,EB\:VA(M_DW,g&QOg
:DTd>FX9&49_QWg4#V:JX]Dc)AfLTB-^2R[af1.V:71U]5^:9R0?@E;G2?DMH^-4
G_7OO<gATKfBNId0,(;fQZ);,.>;W9+1YPM-eI08,38-07EX]e_6IEK5(F_7]S5_
E=M[=a=;)M3@@[e;KO\UI(fMC5F(X7HG^?[\+7GIYae]+\5IZ#YAJC1CC9b?8:=d
GYDLVJNcA8edJ^1&f=FQB?X(/IGL1>ZKS:\B=5CVEPDa3XUV.<GQ[:g9MgLQ34.[
c6#<bSSWT;Y\]7]RH[P(X57^#KVW(c.=3BRJ1WfT^22FD4daG3QB:8^Y3PYQ=H[c
WJU1(Q95X7@F?(a_DG=>E70?.)KP/^&]?V[gDa<)\6\\a3\Da>-3BOJ.\RO-8AB1
7VZc^2Tb/J.MXRfZ_cBF_AK6;;,F1S2K6>+H52M>/Tbg98=@5ZNO^]>T?5C6]/YZ
_-&V?7G9MEYIKF^7B\;@RL^F>_ae_17E@?H?;@2+A[N[Q9(E_U3)#[W8FVR&KXR]
#8&d<BM?d+/.UdN2Cc2L.cd4Q_=NM?_:7:AgM-2gVe1\MYQ(O7V2TI9K0WSSg_@8
A))99(,=V8-UM4?Q?bSC&d]8a]S88P:-)GO;?A,:,D;R1Y3LYaPMDf^PQC4/5J0H
gGG.<R+Ze+2,9E-[443/F6-P1M#W?geVPO?NBRdBVY#Eb-cBLga6F+UH^\/MbD+V
]1\DH)g[D?SO_0bYBS/-QC?+.NZRc3]0ZCGTWYGU\3+0Qc[A52WL6+I54g;?WM(f
=dLLCC932PfDaJ:a:?[L2g9^I=6VQTd27P\?C85cBcW-KdNM(FI7FK9a;c[<4(RR
bW)CCa29,44F04#RR(<eQC3/H8G^a.(5TM93NO[V&^KJT8<+f8>J2SdY6eg)c8HR
]&W:H85P]9Y#9d?9F3_5b=[AKODZ9C(A<&.OZB8Gf).R[M#WN.(&;]:WgVSAdUT#
]g;:b0a,A=@PF_MCaYC@9QUW:V]@I;0]EFV#/U.,#EG\0V.67ZXOSU=&\DJH/dA\
gJ;J^Ac1X\B_2MF3#T4XKfB2X0,c.WO&XaC<Eb<0S_[26La;PLNZKVAIOHGbW=J/
=W@A0:]fW>JG(A6+,(4+TGV+EVW-NfWXO8FUX.27]BD#),]=EU^,Q8INDg,FWbPG
g?bM7K50a/P+Ug&FX7LI@)R1F85CO]8[(2gVG,:WQ3@C^Q@-G2I0Tg+[gRaX0e#Q
[]cFL3bK3d(),Z]:<#(7>UZB=X?>A(.J;\-W:K6eLY-T)Ie3>dJ_K-2S=;PCP_PZ
8P79<9bKeZ-BL]:&gM6VK?Y0@?>A[LQX\4=#NH:3e_(,HLY@b>g-d;&#I;,6c)74
,FDN;bB]T?dO7VH:2\EdC3:94[9;:?D[M^YVc2FQ.I#Z?),CYQUVAAB[2aL?cXHB
e8(456aXVa-NZTW901Q4c^MYfPKF4(5##F.QF&\Fd&\(O>0.Ie:D3-g>0Q0X5#56
3J9-;F-:H.SF+eA7L.DY9.-KVdc5#M=HPfDL-Q;CK&0T>/eI:eZP2F0R.FAK6=92
cN(DQ8V:ATY]\MZ11)YdC:0:<;LP\dI<&>\46X2)cXE]DJ@D]EG<O3?6KQdN\2K0
8VJ5]A.P5^8M]MQ@WJL+V,R?cI=a:;b^?Y(bD=;9P8[KG][#TATf=1ZIB/ZUfa9W
-GS:HCJ9E0FP4;N]MR,\;-J6>DfaU^8.,dI=Z0HZUN=T-;@D8#4#<?CIX4RD]7c?
Y8Z3&ZSQIb/eRTA(HPU_V#<6L9dM#,/N_QA;6e\F)d^^B?(,.-.;8-DLKD3)RY04
B;a-ged^<J3f[QITOS>FE<C:D@@?(7,0GIg[gUPd6gE:S&C1T?RY@<Q3KYe/N40I
?EOa0QLCI+S_9_fZ2CP[IfU5X/20ce/38.8FOBM0Y(M,cgaBHNE2I_S4/H,FX7KW
g.>>bad:97QZ,#I69;J]c,9SZZ:Ld^./(\@&c^JLa5Z^-ILDYG=(44GIC,cIL8(5
deZfX(IO25X,A6BKc6FV77UX-@_f:\IXMP:RY(cb0+/SLO73,\HN]YQHeR7F0\BO
\UAI?(A_=d<)ES^5\\8;cFC_I=W8>U&IMYV>16HbC;eJ2]aW;GB^OceH&/e<8_+C
G(AWFW^JQNZA^O^.]Nb(4Y;Lb3HT2X7EWIQ9Y2(9LK?Q(2d9XgfE7:&.V@.68,NX
SVI-5VO/d84Y;A\2F8dbF3b;Wc5Gbb[(gX<#:T#6g&L0d#Q2S;=&,aNQM0TL=;SD
<d=RW[4[.OE;E6^E-60c54V@)K_?^b?cRH<A,fb3#Ua@?-4/Dd_DTV=47f]bT7_/
Q(F=1VE=TY^VNAD(Je7W#)Q0AF;8aBL>U<2>4;TGbTO]&?0[c&e16f9eRWV)&B1U
]9g&.DK&:gaU#6H\cP=Aa(4=8W_=WW:-XM\J(7U&>..16;1cH9M8J.Wea63X)J,G
YR9AHgB_UKWA6H_A4gANfZ2/+=U]8<dR[6JT)D.)0/>92V:2&eE)@)\d0e5@8P0I
gD7[XZd)\=#LTQCR^f[H3]PYV7RTb:eWM[HfYH1<gD?]a^fH8X5@S;&U[_7bLgQD
_E)3a^VW5(9Y6eVO9SA9V(PQ)_<f:QgVJPd]a;E38:1U);&ZUXf3bP#_DT/PQZDe
?Q8PL?8V0QDe/3M4)59WP(3GHf3^gRR2gC8@;J.0>XVeAba_#SU6MK8>\H++a]T>
B89;>-,P;:&[b[6<e)B.TO2(K^N#/3HLW?^gISL37:4F7Ze4PF#@UVOY3GaL=Lc2
D]2J+&Q\(,6U3b=8^)cgV0@93e3S.CRQWV1:)G(T-QF)b=A5W--aJV@e<E]4-))9
E=C1\SHO=M2Y72=[XYW^O,f2&QH?7=XeNYUc(_/b8P_>4BF?YM7D99-KJL<TIKV5
9&H@HCC<M,6;e9(GAebS5P2Y\,[B3WG/[.7^a_aSYU5a#S+eVUXBUJROD)W-,KKg
E<6_W<@92D8c@#Kf4eMU2JeVC,ZYC]_Y4fL43dAUg;[MdQ#b9aI>??@7@9.V:ZC]
.#R]:dce?]N&Ne\DfOa]\b89<:/OWRBQC;#4Ta887_N1Cf=G(ZJN<H65S<&6B+G=
8KA+9N;0KY27;9e&05V(WH[&(U:7e^5#:K1-4<cT)g9;:V#8R?A;SDS3&:>V:Bf>
<f)#DJ4[GdMCf>]\7gV<bCZ)R>S690E9NB?IT8K)eL2P?Z9HG(?WbFN4B-/gN<CE
SRQO>G;(N;5X@XIFdB642e]Fe2KM^d:636WLFGa87\L2/-C.X9UI@J\DfMZ<X#<_
[.cN.K;_O2]U#HE>)5-1Q>[?&JEMH4RB-VPBd.7C0Be6S#gfD0[M5IQ170VK\aV_
bF-bH2RZ-]gdD&5([9K2;dH4EXJ=J0=1=cU(=;?COY5aR@][;HH+/FfC;6#Uc?9G
5e4[V.S;EG9e[0T4H3^FF>5K.S[?AY.C2Z93DJ&9D53e:[50><?N5]7X+Z](_d[O
R/=Y#^cPW)a?&0^Z3=^@<WgB+H:21.M(01G#eY-G+XW-W-I-1D1D2_[]I\8(1N/g
d<W-OA9L9/Ra18\<WW)GZASU^275917@LY7N?;^8:USc>Ke1309\b5AC#?3XB>]=
6g.N\3./8AI3Q@][FHE]86aUF3?NA^LQd@]XG6F@OedUDRTNd.Z4I96&==FI?WDM
991G?Z5+?f:<-@OUU/<\:E.g41D;T4g[a1FTVFK0DRM-C1_+e8]\#_&G;&RE>(<P
<eH?ZPR@\:W+]&ALG3NK--^+.2\7M@KbV]KUPSDB\E<XJK;,&;_>4MQ@H;_I5/S#
Z4.K@V_^2XE/3^:O-bHX,dN&Y^Te7N2/J4e+DO)6LD_#35225PRc:)OZ+EW5;O0d
fQea-D_PWZC49B8JQ49IE0J0&_P6^>Eb\N80DIS.d_@_aDOF1J1/3?3?99;B(-,/
UC)F<?1J99?:3gWb__WA:-_I;K:D=QD@1A1K#03DfEKAf9TN1P>VTLa(T.CVd0]f
+YXK55@XZQHMWDO,QLPCRLBTQL2=0/#<?H8#4SM)YF+T(/0D\/,&:[8FZ#G+UcNI
1^L+BR>6/#K((.cB/RA.QGV6D<SbF)3P<BRcDRKL,3UB+/<O24fGMa@F-gD#P80J
cLbSN)?HH?6TM]+XGE&e(30Ra?ZcYAED3GH4a)TZ44G48XQOQTW9N?BW2McBC#=M
_5^A?WMYdGDf2TZVee3^]E.[/N1)DO&9fFe.AVMLa>Uf[Q.P6b4;]C<WbI<^[^I9
58^\.)_IT(.\PB0X96:Tc#D9[CcK&5F_Q28IK#EDO^<)f8QO#]SGM>^FQX62]5/:
?)Y_];#^_&_K(Z8=X\a9/L9LfK:6.BZ6KZR;MV[#/T&M/+O0V,:.-a5gb-c?(LV5
IBXg>0EN535695=^TCeFD[Bf9>@6DL)E74OZ7+@=D4M+M&2_:9HJ)MN-\KXTfYI?
Ug+fH@[=.6FP58J]=8=S.a<>+<Lc(=9.d77fWePfaXb(Ea6-ZM1,NGa0ZX>3U6FR
Bg@51PP^8]=/8&9PNPZ1AA/,6F^3>6S,.?D:_0+&L?Q@DRT0c]=6WIdW2X;G<81I
ED3:d>_#WIC\=NOa8fOG+O.\&^H(4=;^cfX86RcgO,90ZJE.PWSFUeWFT]G.JZSH
\]gGYeWK#\UeM8fNF>(99IdLOeFcd:K.g>H9d)H>[B1-FIa1AfU43LL8/PWcW(AR
CHd_>e?fF_1GI97X;M<_IF63R&H6W56XF9>4:IO<<fULJJUb6RdQ_cd(_9UR.E8@
);G.G:>3g272:@d.G[)7e3^VfPcV+17b:;X]SUSe&DQ#T)RI^\g<4EWVK0BaPEDG
7GQ2CR&YL?/)O^ME^9HOOPSeY[0)AFMQ0<Ca?+I59MZ-?.FA><IQ>MM^5[,HR=RT
:UAg3e,[:f4OK(WEI::fgL11OVA]=g#KWCH>\?.R=a\U_W)b:N8=RRMBbYC@9d56
[--A,XAS_KLO[d32[F^_fZ^2d=g(.aK;>?\SVA/A?=<@-DagI&6L?27ITKX2Q0f#
9SDaI1YcH_fKVaF8f&3S,PVO?f_VU.AIU8W^WYT@Kc+(f2be69L4K(<47]]0Bf(C
G=gC,dG](:&4#[LW=9Ygg<W<(K2GTgU@f.dT<P,S<eF<D,/#+?VJbP#7BC(PNdR@
\Q=Z0C,dJB5\D8][AG4H[9\YERW)VHDE,@Y5;^D;_HH/#4eW0@BY^BJRNE]D4@A>
C-QNHJS2B_<\E6#BYS6</deO\=.L.5BDI>(]G<F+?MXT&E4F?O_^aCeHdCVOLRG[
?=W6)S1AQ6)A@V(8R.R3B@bAZ7/]]CNKB)AcP\D#d@>JdFO\X0R+IZ;SdOUFN+;A
=FH-N[3g-ADA,+AeBeS?&1]7+^B\3\]))@+GF)Z8fId+:C4?^)78bJ1D6XV)+7)[
]:dC+55-1d2_#0f?E88/H89&M0)V+&,0/g7^9(UK5/G4IMKWLTGVg\RT6^9-I(C3
a;Re,PE<Ff(YT2+H>c&9Z5]\X1==Jb/LZ@YQ8,bIK\@ER/Ta39WS9I.ZbM3GIM72
0+Q-]N()<SYTK.K,cX)Id4+L.A)V0DZ3a-N-HON2<O(OYR)51.b;^9BK#EUH+\N1
e[TUWBgY\S@BF<)CNRVZ>?@_d9(gMQf(eK-a\2]ZM=;D;LX+37-.#W1T66ETK?IS
,/0ODUEA\M.R+V=]NW?d4J-Mf3=_Z,HUFRO@FVc31d.b-9QXZV]&B6]Z&2gN\WE\
MDYW#2MI3)&E/A\:A-(-ag+fDcb^HH99-87D_>F:/H(OSJ/ddTU.Z)6A:\^d5QC(
c?JO-J7^eU\COWRV#f:;=M0G<9X4<2GbJQ=PB]>f-&>4c+,Td>1SB5Pc:?M6TLAX
:MHLBOKeaI)Z-CIADS@#2_@AC66dBN]UI3[04YPQ;dY3,fY=FT4(/<)Qf32F-HOf
N#f?M.MReA/b.e1G;2).Z-cY7QW=I[/=:b]68SGSN/_0>0JY=7R)JJeZZO4&JTTO
B4GKc=LS;(3Q0O2]IEC+==JR,PfaXS4)CMD,1KLR8X7f8R@Y,IWT.-7RC5aOS?PK
2KI48]JMg:F7MX5>gbSJW+dNd[aU:F=]QE/;N4[X@\3d(-D8XKg]@L9VP-(2C.SE
59&=O0Y)NX)6>L80EXOBL]VU=g,769<RC#+P-A-LDPW32c^2/_\bJQe&H.KD9Ne8
0dgB-(/_eNQ3F)1c4ZYTB(&F1(L^N]ZgT7OY#1_:KgPU_1;Ue6.]2Wd063O)fYF[
FE4Y7EL:58EUd>OM>GT7D&2#/=5-JVb8+I]a#XR)QRM<IWN<\==..YXDKGe,;IUf
D?](S/;)31<L[G9Yg8gRHZGZ^..L_+?HFFLYQ2+<?EC#]>PS92.HQR3J+374dL^Y
29_-F2?6I/31FE<L,]K1GJ@UgC[CY\L5_Q)=[-E=1RTa?4DFBF@g5dc=T=/+3RUF
&)@IfW\Af^3;>X7.e;>&YeQR&7RVf77^W^AFM[c:IJVSCL\@;=P/IZ#g/IE=?8K?
DY)Z1P.W-gg>;K4L^JONf2A3U3ZD8RQ=e>AJO>[SZ=481M_W,4+)CEY>H.B9Ud1+
>T.,6-<Rb]6[L+D&>2g-1&Qd>\#WH95U7=-+Za\I484J.:d=3E]Ed??g+WWC5g]-
DFXZU808<K87dcGB1dPC?aWVK70:-D;K9:JHZO]ZEV[O@2Y-HC6#HdgLY1\QDW)?
LA-X+(W+fCI#MMN^VS9;W/e+L37e4ZfTTG27W\S&S0FKgB^c;UcHCW;[TBA9bK@G
-,@:[0WG5U?g[CFFOe5:=:GNX37eEZ=dGVGKLE5d@;RSUIO7NIgT^G&6>dZ+(cW\
,9S=@^eF3^.aIM;(^K^M3B,<d[:P:3G9DKc,JGGPTF1Z2HBA?,@0,1T8(Y6ZROE-
4NY@5dcT7N;TA9P\->R]6g^]3-[7#@E#86Zf6(f3a?,VZ_,4.#&7EJ18\3^WB0Wd
gFc[5bSZ[?Y,1V&]g,I6S:^L\#BKKfR1JbU<(_W5.b]0f0[9WX\U@gCZDL_.9GBV
:KWHV7GS_\9b1IcX\U@)@1G2.ONAW8;&&?8?^E>.HWNW:^0EB+4W/ZfAUeM1g7K.
SZ9=_:>T>I26WY9f:d:5XSV8<IgIU&1Z5V8Dc#/YgH.Se>a>\/VB)^XQ@N+g_-EK
L5AcZ9gG2c1MZ&WZN^Z3DZd]B1V+A,Q:N=UdgY,QA<19YDTXg]TPY3+.R)Y/R^,5
(g^,];/.#g&6][6E<2c)YL]2#Y6@18e.SCc/5daL+O)+D>9ZC3PK?KHAF7>NVD3=
L0>^S>=c&RZDf@gcK.0I;,.9IF453+2_J,.C?39AYOA>G.8M^F]R28>?J.ff&XUZ
Kd/4CbWF.S.BQE^<_Y1C,?EfKWTZ3c.(71-&5]^<X5]>P(CcP:G_.AD,T^g8Z(gT
O2PXf96+RAA(#PNWP_eXWYe;^&bGd_Q;50AFRIJ[=R+0_P-0g_R^TAd#Mc8]9K(Y
BR)[1C<.f]gQEZ4V<2gCLY+=1B?HFHL<Mf48QX?_([S(@ZQ:ESC.(+[/W[AI8KPD
JVBC(65^_SB-bN[LY:,K)IKU)>.gL1&(+@-W?87FEf.L&;CFYMW:gJ(RC+NQ,YIT
Q#@bG4P#;F=>@.J?M]Z&)S#dM9YFI<FX,D7EG+Z;>22.CH&N)JJ/1/.G=bME@HXN
7S])8H==/I+3,e4V?N)^MR[[&\QZfX1X.QYfbXW?,7_UJNZf?[K@MA+S/3ZHL5dS
,c)19AJde[5>c8#(PMdR@N@:LN=<<E(>T(;Q37<:cI/5)cE28Kc(fKG,g=<UA8cA
4aeg9Z)BL_,[XL<).:0M5C557/Z9g4+FX,5^+a@#7J(H923,^fWAR/+0?4O[ZT])
F[CKEP_OOJ@KacUY0Y>,A0)K5H\2J/:(,3DQ9e8AM3\\/?]-FN6)YNYULW?^/OKb
]T6]0AODf)T:D,;eC3\a535b(]4RZNC].PP14fbe8#/ccTYZ=#TE)8S0X?#9GXYL
RY802YOffebKb74b2&8,JEZ8Y-RfCJ&JXg7U5@cKBU&8YQcebZ@I730;9T.U,<MV
05A3d/0D=IEb&JfC)YYeX2b9\PIEXf(8CFF@/N0<&<&+I)A4/^P\O-QC9C\(6:CJ
7NH12Z&,W6Y(Q\P<M.U37F8S]TTGf5:L9#[T;_<_eLRVU>:LQgGe,IIAe;d5Y,BE
05F0,Y\-818\JaWG4JN64MHG.UK))99/JMNV:G2>^W<J?fC:b2B4fMeT,L\^.Vd:
AWFM=PXTb??dMa34&V2g0]P746>:eIW6683\Q2f4aD#f^6cDPJCVF[.>+bb=/9d5
(77H)46X<VNUY9>=/8,;Da<BC^HS<^aXST7BcgLU+LKd2Y0K]MTc_b(UXYN#TgMH
,Y9?d[S5Y+#VLO+#OOCU]R_&26TMR3b,-7)^IH71#S_WZ7__d:P,ceP^?4Nd+-N,
QQ_[5A:J3H#M6L]Y=QCc[;#;fdS:X&\b-ea4#^eCa]@&,D,aJI.>.8dD]_Qf0/aJ
/U7#F[I=D,,6\5D&GIZ8W;\f-[EG-T1S(AIG9=d[MNJV6/b;&,GC]9AKHYcacXMY
W-@g,c>dU/VTIfD>BH[ZNT-];?0V8OO2Z+^5J/:QA7?)P<eAg?e=S1IWN8\^EI;g
_?CUWI9NQPXFH<;+G(,E^0+H+bU,@\?KCW#1,(2PZ4L.7N)7f_;2RI7,Md8_)>WN
<fMJON6Z9cPU;_a1>e;<#GR&9VMESe(#fP&/VGNPf)NHTZFL^7(M^8K(e=A>e^:F
PWHcOI^-_I26-VCD40SDVbJ<1Sf^B]C8(E<1:V0E.@R>>(a\/FK]F/<<cU9ed&4Z
ZX7DgA=Zeg;[EKENC&A9R.XRQe=O>R9UP[e1&,U-.6?;\Tc1/&Z)Y9e;[_>1_RIC
ZP@DPO?@b6V]-,L&,N@2TKQ5K4RCKeZ2f8;6HKG9g[U][,<@=JQMIV@?@KJTC_N4
WPJ\Bc/+/;5)ffEG.P;.OEG4C29KLaK;FK,CF9S1LCS8AgAR(ITMA+6>^+703_Gf
&.74QXA=<39S\>7BT4F#F69X)VbYLM2+V645L>K>\9]M<\7fZ6,5Z9ZU[_Z<<1a]
dVHP8TaadTA\2N34<IYOWS<gKf=MC(GOdNHdSCX@;6E6cE@/6g8U[I87WU@DfUVC
(5@g3gec6P(><YWTVVY>dNa>S)d^RL>X>]bE_F^YLLaf66]56=N;FeBXe/,(/<<N
dX9^SVH<P#N#+6g)^^/I.;^JZ7W@/Y1S69^I)L,RO)-e\8G;+G)Z#c#a_U1+N/@f
IN6D5Wg8SAX](?J^c6g6[2+Id;GSSTaYcYZQ/RIPgU8)E[)5B).J+([Vg?#<0LYO
G2FW@V5ENCLNMTMfV3+5gQ)VEgT)I+I@3SFZ&/>#Lg)/aN=P-eLX6@,),cWc25<)
H7BLSQ9BO\a8TBJd:REE23K@,g\M8Q>&2>2g]Q.g@:9D7@2=L#SN&ZC&NJLBR,W&
QTM/2PD+<<D4IfB@_R4MMBA0R3>Y^),TYIZO=4^M?,7&D-(eQM?O:G,[PaZ(KCbf
FMRUE4N;g:_M(P?9Y6R7-)fJOePUGCD>b)YL-0cEKST4RQ7MN/D,=aU-H[_,/.F-
#[EF7-BCOL-:W\Ae-RS4(&^]L[;[&00O(AE,\+WM.TG3G[36N#Lg\]W3Q7Q])DXC
T??1;a&&A2Tg]>(2d)ILFM0P9E7,F4MZ3ABD+f9=d44O.URO9X;N-F]U5(8R;N[\
X8-=9K-+aa1Q<&&1M;)5(DV?ZXH[8d_:7=]H/6Teb&<Wd8&fMb/]K;X7Q0>9@A?d
/QFT@REQ^C8.aQD<]_7W;M>c(5,#^V;M=d].(722dKF-P<b)?9N<5;LE@?)1]P;1
AFa&<+@S,FK;fN8^(IJTd/Sa&dBE)5;d6LE3AP857O<c_+]JbK6dCW,E?VZgB194
UZED/V_BMVUW>71eE_.<;7L3aDY/K/aEDE^;,2(_<cg6d\Q:7GM0@\51MUM.a2YH
X)R(e2OP56D\&_,cL(PaG<AE_A,H_:E(G?H&^&TFN91/LJLS@ZeO)>+/O.O]9NX@
(ff;0bC@OI5X#8O\<LT^0e]>)UOR3P+b_f:IGGc@(PbBCLD\+^Ug&8bY+&HbFWX-
B,G84f;,(2__S/RANQZHKEOTU;4,^-b-TG372@QMZA3.S6/^D\=WMdKTS<XOD(fE
1aJ\XER_>1[L6J@<0;D^BBQdeEg(3@L1LZ.gB)U;Gb>D:@6VT=IDY[AB42e^A(35
U?aYD<<>a,#C=(U,.YY0[#&JEaWadcH[R&Tc(2cH3;Ra6+a=C9<0S7b;9^Y/>Z<U
Fd39\](UZ56W19)Y(O0RMbN;fGFY#K[c6U)B+7\J6V17?fO]JHU)()G>+F-.9G43
4>>1^ALRd5,?JB8g1\&Oaa=<I(6[WP+LZ)Xag;(^PVALUO(M(?1QbS=e)YL8)K2F
0SKTYVZ4_P0)+69NdUF+\NP)FH,H8Rg<K_&aFGJ4YHcWF3R]1^d@JF(0X@US5LL@
bOPbFY@XZSB]dHHTOJ7UXQVKV5+Y<F4;_5G2eOU^L.++c@VZ6^&YUPS,V@SKBc)^
-2LI46MZ9F,Yd.]_Oc_a\.fN?OR?D9H>&>=LO54E.f#CCgEEW6\TP30e3-6FI0L:
>&6&)2I9B8<#OT\AVXTBa0B<,LJfZM_1aB^SZ^H38W4e(UQWID9)SD&(KK12agA:
0,F6ADFbT_^+0.fFIc>]ZZgO/J\2bd670N1;G0#RWb/,JB8Tg+2\08.GO(CaI@-N
BAG^^8]]b@eW+dVNH>5+gMVT4E5GGbQQ2.[Q^QKf9O\Ie\CDU#C7bf@#Y)KI^XF^
f:LU+HL@)4735cX.V.Y7S:eB)g>YaTTgXBa@W5QLbX4Y<WV(F3=#RXcU#V3eCW2&
M.=[9gZ]B,Hd?A+NEM;GWWW+g]GU]bGPER@0UPT\<:#5Z-=]TbAb30_(8NV8c^g0
^#;VLJ6W#K)3[91N)^48a.7(-&S2>f>\3JS,4<7g6D2,R2Y#:N^B].@/O5g[NT._
Vc2[5;S/0AN9:RP?22g2MVf+U##Q/IE/T0=OBa6)QMb4&gSWGN\DT\)IcCO[P+\V
NPbM/_adO#MeIK8Nf+ACd?g0EA8GfRH[O[340cZ^e=[R_La[GgVB@0(WO8,>G5HX
+L)c7XD5NfS&a6PRSZ&Y3?(EgT()3dPGcdT=8M]4>I.MEIBU1.ReHML#JZTX99X0
7[B?9JJKE+BOIfWHb+C.0Q<5C5^09(K5AD/(<.FY&BPQ,A@S:8AQ;>Bg?Z2Z-FJ(
HEOUKFQ]J&7D>)&IGe/XCYC5fdXKEcfSZZ^UPCaZ^;/U^WJ8Q8^4g2AG2M?RJB)R
:aK?bLGaDBR[fDa#47bP3?UT@)<8V2?)-JC.@J3XRGf@24c9\4P,8[6dc[3-/>Y6
ENH:-.]7DGDRdWAU5=9QP0V#?0XF3O#8,FPKZ.23Z3X#1MXbQPOG3L(1_E[W+=Z@
&AK-g6\@EN0+@9AC2-7P]-)O^]_;?J4T;ePR-GagYKWC([K[abK;V27_5@Z=1:U_
-\#c[U^_dR0_Wfb#BEY0]TEBG#ANb#3>L-a:TZ4(Cg&<=f?0-7\b1S?H+9&c0,<.
&XW)LgF>d7SS/W-G&-\EX+=aA_8B6N1Fg>7T4g#\<b4H(YDf4\H=Hb=7OE&HO+P#
&/.C^R_O.WY;0F_DLDXZ0>SB8J,(EbC8Ae),H6R):NX[a9)I\NgGOO42SNF@LP8W
d;1b]Q@MHHYaT>@C<adD)(7?cY>WTCT8bH7O<S+JO-EKPdgT^96-Ad-Y+#U-(:AP
a?)ae9EX=F^HY0a5^S@Y+TU[9HYLaV.EOTZcOK_\]JaPTKK\Y@X+TMI,,ACbGU8Z
7Y_QDOAU?-B294@+O/>5O<5EBHPZ9:fG@[c;UTbD83CN5<VVKK)/^bI,f(]]??bE
ZJ=7AYXe8eE;5:/@1E]eL7bE#=C,>F<K:S+Y14]<NUf3NAAZ>#H+S>YT)LND1g99
;.NN7VOgb:aW]YeUR=>4]A,0FUG::4<JMc;7D9O72W+S6-e,bZNd(PW,=AE(,GEQ
(CBD[:KF8^.g@Pa[2/,H<g(Ub.g3E(ePDC?#;J-[0OK.=XTAa)>]>DUQ[[,05K^?
=ZgHV2UJ\[-_>EfIKTDV&@Z)_f^LAP/=CcIVNL\I9&]+YU6RN/1.+EMG+#26<MG>
b3:.^HF5UGLSH#@52-CRDQ.ESL^7SJ@.b&FXa0QWdSe60.9)]>D.=DXQc)8BS<W)
S^&JHJV;87.f050SdV_LAW4J@3A?Sd_TQ<4(613eQZ>,_/>deH4?GNS5J9R;#)fU
U]AN]ZIY/U?_62O2UVQ_Sd&&8dC=+,G:AMB\UEAV;ASK(bdW&&\4=d)&=IG.eTaJ
PQa#H9Rf0;;8BA6@ETXId:(PV.[#F&R9)D_B9?+X[f=/8[=(;)NP]_J^0dT3AV]D
JO[\1)9\)R_-P\-NWgS^X+?=V]2=U;E2^@33A&f?WGZ-g1G^RXQP08:Ybc>YW9d^
6DEQ=WdaHJIJd->^T\DZDKBCb/5c8OBWA+FXad8<T6<4W#e(J643?c5a?_-X>Y&.
S5/D:?-5SSM#7#.75KU(EB-N5U/B>dOR.5#IgR;Z420EAW&;\9(RI:GbHg=#QPFb
D^A&T3.5I4KT&Y:5)g3ER:18IMg7Z7:<dMC^6;;58(C>X2E&P>K/&O8BAI[7Z4GT
&JZ_X.+8b\J7g4K>Xe-SEBR.[E4GJ1:=#I-DO-X4FcP-KMLf?<XQ3T5MOaJZWXC1
)6R+#aB\RWAJ/]6@-c8>FX3,PY53?0?(9,Y=&F)cRQC0NLDY57Z=d0,BK(.3(>)C
>6LJg7;1XCFg/:C9Cc+AE=7E;P(=GE&C+.#K:OQBcNP+=1U+.NZ,Be;_VWJaSJ+,
MX+0:@2-E4bRS=VZ+Q1ZQUSC>X1F4J9L?X-IPPK0?[B7A5Xf<aD,^UdBMKV3B44(
>4R0IYG00e8^NG+3d)A:>ZC2VcH?g)R<^^Afa?7RB?#D6BGBb#?P=//79^067#]V
2?.acXZ7cTd6/Tf4_E8B0+=O=MRD]cCP]X7:NMHBfZ^)G0XZK56X-07aP(Fdc+<,
a1M6S\=>VT#D+17V[ZMY_eONcWQ)IU1c&2O6@eP\_;Z6#=V#+8-PFX5ZLfB;^bA[
=][eb1IU-NMHc8.[fO[^:SSAEZCEY[=F.RLfZP196I[c_8CXM^6U06b/[8RA/c61
e:P(H7CHA)VHSB<8J+gdaG>T&Y:KI^-:@&@NPBf(X]_D8TONL#gD-+VKT1GgB/14
c0(JARVQG5GUC&4W1-Q:2GH3::+BW#E-bOHL=Z^HP5c67JHA[GY=9)6Oa=b.:DQ[
2dGYJCT(N>PK[8-OE-FT.&;ZX,AM2eNG.C^KW):gd-E-4QVB.#>0S(6_0]7J_)g,
.?=19+9LENE-Q<&+/Y1UT38GKOa,8;Ge)_5]d5Q((gLMY&\LGG,2]bQ&S_4#)Rf9
1YFXD3O,/g^F?Q[GO@6;J2PHOXX\,P)gNM,U?(@))b1UZUd_>L^N:I#f9cF2E_&P
(+[:M8YUHF7GZRe@<-@04SDEeQ+NF,6NX:FZ4>.JX=Xc6eTPC/d_R:(^fO^PZ60V
,7Q)3RDT35QKbYa@5.E.S62]g\GIU[?5fV2bF.ZI85.I185;G0/0>-/-2Q[9R6Ia
Y;O))NV6?5L&A&1d[g47C/@KU28AV,F/-V>FGe1FDP>;8>b[TM3?Ec-ODWH;IRgd
&VXU2&^ePTb+KAOc[fY.M12]?Sa+K@W)AM^YKT^<@<<.C#=8:8K2>4VM@WE>&b-7
7G5WM]YG7<TcKHM#H)\dHSaU18S3]&e1HCRCJ4PS^B39;PK[7:,:aZ20W2^g^f60
U5@d-5+<UK)Q/:M[D((eYd8e,0]7DA24J(2[KWZ2F/UA>T,QPNR1=?_C66BBH;#O
@E68ObQ(PTA6=dP0KROg+(]XZe@;#M<.YWX@M_UM75_#\\N[=aI_6:a+7L?ef<&E
^<b1@-dXW80N)fe=2/7O_^Yd9AB&)I24J;)Ya>?NG=aJ3XQ([W[g([cc3:N#9-]]
MO]<g^^C^W53JLVQN\U&CA^^SB25I>G980)>A/BL:Na,D1-:+2DTYT.),SB/6DZ<
/[H\Wc1CX6#E.7T[UN#5A>CL/Lb5I2E6ccPSCc4+_P5d]Y16:3F<B>48bQWR=?IC
A=Qd)29K(FY]G+FFO6CE:RV^gA17[]Oa+dU.]N0U.>..f\BTLb[4@]I0+ODfedG/
[^GcP0R:H=K+Ue=0^MOHgf0;N/Z(=/QeGT=,EFPfOQI_Oa1E,MRO&g5FZUID9&XH
&G(OXX3U-#=[c)];BEW38P<1Y6^P/@]7]_+)CBC74PfR#M\9SR[CV\I)4>>g2VMU
gRIA:fA&R-?U<94#<S&^JA)g7e_0:TO8XM0g?WSJD)a=]N=Z95gZJN=,=8Kc_4W8
f>a^-RS1)^VO&8X&9/WOF,a=U/EFDV0G5ZBO>d;0)\Z5S6/2JW7LFYMd+:4E^MbX
@S1G\PSWESS@T\9,_=^c21=7dW5>;(WeJ::(Cd>]0M(e(1?^PC1fCQ1,@WSRD/Ya
(Eaa34NAW[9TV6@f#EDNa<.(VeSDP@gd-:F,4<VM7E1;;WQ91#;M3a2_J,I)C/WN
cGf5cWQbX=&<I\(WW.U1S/MQD/&ODD]KX9<XT.g0YPg)AQdXK5WaCeLS9bAeJVY+
RA;6^0>_1V>GO_f630TdQET7DK^=Y?aETYX_H,/W=2Q><0D/KLR6V89@^bVZa#BN
44UHeEIfcV]A[Z_CW<_S&,Mb_C&D[.D4:g.\U[M#[)A&gdK/XcOYTSH_Z?=U]TMC
\=AS//E&D246g;a)W:H),7R_QBI;#BOE,Q29K](_>&:ZR#+E/WaKW6^&[;TG2MJ9
cF2DRg8=fF.C),\5NG]TF)AUNdG,#d/V\>JWDN:8LSEY8^SIf([S7E+91-(eBc+)
UW>_MKU\M5EMQ@;5gCF[=1@>c&5-;KEH>Ja=#?X-=B1ICe^U8EMg_>Nd13Cd9A-d
,W,(B3??5T,I34FVK6Z,/aMW7H](aL?I9A7\MF<_X^XdST[DGW/.bEMO908Sc0XW
F#7#U3Y+)<PQ/35SYT4KEgNUM>Mb,T_9;6D\b]cJJ&CT=^IB\FX/aN&+a]1fY3SE
T6-bAc]V/7d:1=^^VA1C:2D6CJ1,-YA@W7Mb)ZWgg5ML,<1IV5@K=4MP5HHO[#Le
I7-.&]UbI+fRR_gUe_2WOOF1940.)K@T790PK9.DFO@a:(Z_&WGQ;N56V.ADbCJU
8\gI?Q=2\<[TYQ25N?)0SV34>Y\M+A4B(CLN]d./f86L@A-,X_R,=@QNd^ILK1SW
S5=HQ45<])FT^D^[CZ?;J.81ZFGaBeJ)>HVLCDOM-\=-?T92:-eU#0@Q+A36#H/6
Z+B_V-@+M&D7QV8deTfMV0H\@YQ+G#E7;cbF2]Q\;7e/6D,P0?J9,>S1M+\c,B8I
1_-W_NO8O@)JC=f9H1e,6>a.2OP:b(,>K8+JDNN?K07D;D,]2d#,.?G(O<(Y@a1#
a(X2PEL23[8AYD&=U)]V6_Y2QKQ_KT(M/FY_fH3>CK&MKFgg;=3+[U]6/5577:^e
B.<WU85MG>N]OK<5DHU6DLBF#X4+TI/D;K5FQ[@JbO>[Pea1b>8YE7];^cLW=E&L
W.L7JB\/e\C172f(^3>V./G-P+;ZYR<C/GL;;g\>UQW8NMPO_<0YKK.LL(S:+,/5
EQ+U(M0ZKM?FM,9JdN0?F@b2Gf:g#@@=+=,T1NaRW7\&W9N\1&DWT\50d+_4H\Y4
F@C)geZQ3<CAdX;[c]@6d#;(dFT)(UK_X#RJ8SUJOKQ,10Ac?WfL/@SP.a>A:SK0
NB@DTK.51:6+:]KYV1ZMF6eK0CT4[D^6LU4GGa,3[5HA9\RN7EEeFGK3-YXL1L4d
W@QHB]U.GKP9.1,;)U2I7(GS<a/CN7](V9gS^\@/beU9E>/b+E^-1SG8@3V(Y_4P
TA@Q;?cW#XO9B(9d>=K6YE[W,GQHDN#WgI2<G0@^.0F1<]P3(ZD/XGLeM>JaW-/5
d<ATFIZFdW1.EFN[dP\_T6a1BV05DZW1G?NegQPa3@71-UL-=,K9@^bBO_=3fb>9
R#:AGD.Q+]65ZK0+#0HIB-eWY,fDfPJYOVQ>99,IC6dS4=^Q\O@<YMUA9KO])Zg7
;62acTcZ>V;EU](TRT:KC:gS)#C35V,HF3C>f4P8gBRGY7\NS\<cE)MYZbY_9S<Q
G9HT.(N6_[]MIUS4TE.)TM78IVYeFO:1B0_6Y?2^):Sdd=^aY\@@[T0cbQZ\9Ag5
KD;#<B7V^4P#8Z-Y=6XbJCK96Y2D+gMY5V&RII)<,M.,?Q=5b2#Y[HaVd#J&0,H4
\WK46J:K_:DC=2KVgd:PbfC1?VfJcIZHFTeGE(E[X-\O1+W:->G.)9DcJ#M-7BBE
/XeGUNA=/13[H+\OXAEBfF;2<@#e(O4O+c8,ENBWPR4QO@BZG7FDHOI=KGGMAb8G
O?HB;L?2P^B:>,BRMbENB1F[cUY/eYWAI)D&N9F?@4,<8MW<;e0E&c:Y>;[L8^_M
_B2^LD)@@/X;AH)Ida(e.DLV3SW>^Icd0Vd6_4b.ac/1VVIcObf)A0?8:0>Z1\7G
23dS]&D#QZLaCF4,#L+U.LQ@P]?)NaRecZ\0U/1A@MWJ+dW(CgLbO.42VK]V</eC
-CJ0a/JYRg3I/g\C+YfE\K7J)T+MR/ZU)gB@9:_3SJ1=^@<++9M)0cY9;eE#g:Z8
e=bSU6PH#TNB>G2@VBcbI.<g3R0@L91#(PB,\6V=L=@?dM.>TQY=5B.<C\_4JNET
MVVAbA6_KgV(7FHT0U=e,W3a:&;=8>\+.<3<\./S0_Z#]0b@@\Te7bY5\CBU=256
JY>4VHJEV,)LIcBG)J7PQdeec3;dQ9V[A,H3V<.]XSZ]W#B#NTK)Z]9LJ([@67R:
eN-^,RHQQQ;e[N.dXCQ@(23)Rg@,Z_OHd:If;3Q];0U8a96CG?O6-?6XD>C51)_P
1S^@0dBS8e+S20.Bf3=[0bfW>eA56a/)L,YM8P\I@7JW:R6FJ=M25(gg42Xd4Y\M
NV2])fMYG-3c<c<3XfFTd=H<0b#1&N@[Y@9KF]V8-4=(g?^RG^dJ(9<SM_P+)CV5
4864C<9-9RNAe?dBaP\&/2H\ZL,dU=4IUae9(5/H:_b#2Z5WOa=c[3IR3VEEg-PF
62+[IgBP@Z=N7LgGB3PQ&BYEeWKZaX9D_P/gc],Gd+FD:97Pe-^@)T(:CPXb]A4E
LC8U3gLU+aNL:<VL(YKI]PVY6VW_(,1M.O7@_O4O8,>2((8W]/J09(NS;9<L3_-R
4=<<CI_#P(6[^<:]^fXB((P>(1E\NK_8[Xa3.ZBSHJY1J#59_MQP#e<UL9e@1:bS
.D:BT(5(a+0TE52.e&LL>WX^OV2W,9DG_3_G)d[_PP;NFc09J);WEg&]c<#,M?+N
IGa0>P4IH#cYgDY;Va2IA=K>/+AY<E4a:SB@dA35)]KBFE6\1:e7_e.W>a7a]/4M
?gf8_NN63^Sd>A09FPOC[bC4\Fca9d)Lf=S)S7g[8LRI>U[G,VXA+\FS6Z1PfP?M
B?M:5LM<<&abS5_99A0:5bPa9e?Y9_g&2<7f@=IYH13@cNW/?4@=]bI@5#M>.#8&
PEVV7-bC<O&75TYO9B-f5S0SOB0S99[Kd3P+\V8RC^/#^?R4G^OMYX-K7K+M+b(&
+gM6,cgB70,=PH)E?:O&#dV^J86;Ic3D@/d0-1,ea)/)a7R<8@TDYcDE:U\(dZ[L
dMM;B1b][POA7KDT=@-PNe<X_9f4MMJCFFE:Ja4)2Tg^\c),c:_a6EWM#/_VQe2b
b#fL69e@0cgd.fUA]G8:[FOM-IT_/-?9VcBFc3K)e&5GY5+N^Z+O<[XS,G5;eW86
V,HP[NRE@Na?==T6\XFEZg+UCM@&7#XEXOT7aM3GF-#87SES[[C61],8HPUaf>@G
d9C#60A[MRP-LBHQ:==Od7MQZ\O0N0A=2f4V-WaU\6]_AI7#<C:6ONIA_RVd+@2R
I-;D,Df=IdO<E6b1#8Y01Z?&gU\bc4d8A<F>:JTa8HXHd>[QG<8Dd/a@64a_F-W5
3Y55NW.A_#/:G[WC>dHB_2>OQ<aK8_X6?N&b<gX>^;g&C]JZIN_V;8#Y:bD@d:b#
9#W6T.WDUL1M-.f3JX<7(A-KW(GcbB&?gA<b9H/>aW-3fO))G^B39c\Yd>4W2/J,
@MGgJfQSVP5a.XIS7D3ZMY#6W\?07[IN7-=JV:ac]<A,M)dH(^GIYR@5RE42Bc_1
)Kc;Z<T_)eQ(ITfHT[4H8&#7L:)G>4#@ET&:K[8[/J2M\J-#OgLV2eVF9dUg=C\O
eOd71TN_F#IQV&[7NZa&4UL]?eE6-Rd:OOSG^L;dWG<DHRQ9A77044U_;58G<PTR
dQMW)=-]78>6OKLI]5HKNWH2IG.+I(>[M5E:/U4JXfYXTRL6ggWaSD@B)P&KJCe(
3;_[GEO.?IH_<+XNZA(HA9@9Ff1dXTTDKU;QNM^>VFN2RFB.=(d@>H3][aI[cR?K
ZM&^9^/IZP>A64-=TP[2=cF2H/BBcQJ1V]S-9aNe52SfJ?=VJ0G0/EgF01e4b_Z,
8BC^WgI(4\X9W0DHK_7U7<[:a&C9T&01C.-:GLFSOU5c19=U>@&e8W\YDWdaWHf6
6,ZSH=1T?/IUd,);O^]I+NMYW/(H2_:F21OSFE0](K:.7R+LK&OTe54.PM/EUFX0
0I2W/]@Y(^e0JKdc8C8T[?(<1fOV\2X_g&b+beYNDCgBeV\OgH)c9.X_V8KE[R)4
,0EXZg)R>0VU=Rd2UY+.>0.;85R^/-e,H]b;;/&BG413TfGB_IAT<0@_M#^HLI2M
YI9DX]G8W@b6,EY(+G7V>U7YG_ad6^-H.;G/YLK]].UOR657AD:(fP(1YZXID_fC
KJEQG=bNAQEA3#:0/81]K_]1<,I9T#R^SW8V?>ML1Y:UVfa57/I4e]4b>\HeSbMc
Z7)VR04U.a1)):.B6.g)H22a0;<VCU(:C^[M5f-^8b32USC9XJ59c/DeZ>/d3_B1
>L@c6f7V8QM6Z=f[_.OOa^OW39BO^SgRM]/XZdU_AUL.8X_/V0aM]+D\3/-;;;^_
&?.0faBQg&_KFV>)<0\W)g-TMf/SE@>Zf7J,:(G;5Ta4eQaB;SO/6T[f#E?;ObaU
KNVP^S2L+GfGMUFbgZ_OdA^&O,K+5]4V\;-Q@M0#_&C2SRB_8;QOCDFB\/WPS>@)
3:V7G\-LJU?DaM[Kfc^\K5bLZaE1I#LdDV@O@_;Yg69fB7]7VI(=bcbA,f0U6L4H
79be@\5eUY6YETI92Y[,M9Cc1TYa42cO=I-@0A.IPWH\2/]ZPcS]Q\>]C9Nd,16F
@cDV\d_&C5-\8eU_Ug>B=(3=E&((T-77,@;=?[^d@]ZW;P+;K5Cf@F2eE-.@P<8@
bd[4&A/9D&7#d&[:]@)D)1&^>b?.6:;fXI8-38@5MJ@N^>V17)Q=A#)<64458M>?
0EYXR1#9BdN3OSg:EgBb3W?+,^/#(_.ba)L[#85e9_6?OH;KFMdH06<_156WH_7D
5)0SJAT:#:YCU4^\bPH,A3J-;W[G4LTcU5YQR4-)+MdTD;g<HR=BDHO(a8U[@1ZN
HQG8ZObW4=-.Ua]]Qg0149Z2/Y:3PHa9Ga-gTR2G:[NK-GB2W6AQ^PJI;OHL&:@K
HO0=UbCeXe(g+1=NNVF^2PC:_aP#4[3a<(JYEHGX?A+5?[OFL.0)EBAC<PG2053.
3HY0O2-.Q8?S#]LL.:1TX<E?]<DTXg:[:RV)=K5U59Q8+B2EECEO.X8^,.P<&d<_
90e@aWFI>QN23+&5>ga-H7G)Q[/Z=A9)XM?^L@K7N)JV89.8[5A8BRV3Fa6[0HSV
cgJPb:[@.)Jf\c\[VZKK\^Ed?.:<:g,Ia.<C9SBc<>ZFFW3O@dR>]9P3_4X\?5Q]
Y[U<dT[.(_=])AS7QI:7+1bg5R5T=Bf0e.+5O]C9.N#+GHB[e>.g9DMF0.NOdJF,
-Xg:@FdGT,:4(VW-9L>a;f&=\6:&RT=eC<A0B[a+Q;;#YWF;/EQAPO@eH:W.F[AJ
@VgIEL4^)NG@EQTD3S5:?E4AJDE>PO/IM3:(0T\<=<1(E0b-OeMHa57_^Xa=JEM&
O]a+J@@[TG\IG8SG6,K)TE8:);IC8T9_De:_^L_TW@:K8UEMTC03)VbV2V+aP[c3
gW+I/8)/_8HB^5JG^81W72QO.-I-2Q\De:7/KY3TFRW-\X#;;_J?02DD,ADTY,0-
Yb]PS>f.M)6d_1Z8O@c+;-<@,E.ece,(4=J?=O=(:BP6DegO#f<6e,fX^@:U^695
H:,KUIBA?V-5c7Q3]Cb/C?7Bg.R(E7f3,a\[@1]d?YJZ+VEX)c+N3BWFHgDRSKU[
?T?RV;_1U#8SMEe.5?eVCV?XVLFUFNBfDJ1+BG)T+f?>EHOMVV22H(792#?7H:A_
-+U)WZ/gZOJHJK)N)OXKI8:K^HGD@4RR]^g;;e\Q<E>XWcZ+SFR85FSWECc_6a#O
10;Q(U1XEC&8d#f[^-K6/TZOV<80S/5_UK@3I,#@^PN6ZbR59+T/TQGP])D,DD0O
b)-9/4#e?S-[Y3X\UE8PM4(Q>:\CG65SL8^#ddcB/-aMb,/@;;\-Q?AaCRK>8AAB
d-HKWcb?3E(Zf)=QL<g>YDGf0:Mb\YgGaAE[&Ra8\.>HIf4@OV]L8f/,=>IM:_>1
26LK=U,C:,)Q,T>=ZZb<Z/cB/9,=UG[F^SE[[M;ST0cf+(2e2L=eOT:&)-c653@g
e=ZEL@J02e<RJYB\+\MD0X2fXa+U&W8aKHKDUg:GQY1;1b;:1/UKcNZEeZLK.B]H
d,YJMNAU]ZH3eY39gYJb0O;.SA.0)SBTT9bKFNK=g5YgPQ_WM&1^NW5+b0Q6(DN;
9@59ggYJDCd#g(UW0(fIOF&0#[cLU3-7e:J,bcGe0/M@aY5[;;N&D:U\NeCJK:7)
RON08W8>TNDBN]D9/aF_MON=ZJ5J6:dW1=UIA>=FV4ff1=/7OM\b1Je-Y<],(3\:
5ggP9^AS.^E[;_d>>N<YDJ@);gED(IbB9CdR81+Jaa3VFdbA\;G0;#NI<BRbYC;Y
8XOLefI?D0P@Lc5;6g:WT940Y:XM1#C(cLe#[9]Vg@g0J)WD-H&-?@MAUZ&.SJ8+
8a-5cf.d3gPJPKWB?U(-?/>G3Gg5QA0=#cN6S[.MF<97\(4<;4DI\U_-fg]CYd6R
J2,_=(AbeBb9#K=@Q5/ac91R782T^&c_ZGS\/GTA?bW_LQ\a-5bR[#E;\Y:9OQ8g
+3GB=-_/g=T@M09dVC>,E:T:G])S=>&/N<ec?^-E<JKWWK(b26EO>;V6Y^PcI#W_
.+?0&??c(QB)2S5NSTF?dQBf/6aGgPJc2Xe[ea)RENT:?eYSQC#ES8F/^gD5Z-1c
8L?22<T4P@B6&B1^/FSI\D;g0c7@\QLc>@3?&2,]IVPIM]O3[D<&aTXHa80L+bH.
Y&Q@EK-5:)YMe#F\[J=:b9<DW\JDS0S6K6FO9/NFOWVYePU(C+fD5WVYAT+>E&BZ
>Ge(O,C^G67:79DU&JMP1fJO@_^(B@Z6#X&KPIR]-XLTIJC--\D?I8=QfRAg+ZgE
Z-#Dd\:I)b@(T^YRae()f?caC+ZL(EHBL)dIFdGS8@LBAVMLDA2S#N1W9A[U9Q?B
1N\d./[21DAP<Z;-KHJY8X02Va0+\5Mf-^O[_A0I74e2JU#RL/AC-da:bJ^)eH1)
@_@DMZdO2gH\??.VP1Be2XFW8)2KR)?MaYWF9R2J[39TTU-&.N@Z8^9;U^.CUT6=
])YIZY>1:G-#01/YH<6KSQA?C=/GC(Q&QUb@A1@BK<4:Icc?a>VY3NCNdbLaR2X7
S+.IAb&d;P57gB4fY,F..X-&_GP?XE(Ue6OVV+1=\.Y#9G_:^3+R2Jg;VC=JQP[&
&Z]9NEE:#,U>TI+5;CE5<+geH6.^P9_,Fb+&G](#4/HRg(AG)Zd6X]]HHWb2P?PG
4S7\1X@(c6Z.9XN)TZY[CZ_D(.CQYS9<Cd/H/:;cJe&/,-b+fM]HPOR8f+7IYCOS
B^_#W.&V(M.VXI<#A)f]dE&P)-b?8EDBTI>>/@e7V?8O(HT6.=6TDV5PB+V#Wf]\
e],bNe6,0;bW+Z9++6@?5JJB+ON7AIZ99.e3RdbHC&\DIL@O,0C2H3B]5+E=gT)O
BCHZ)a0P9+HXX_F^2FO1eAMBCSJPgI=(UY1b;H=E5VQfIH-:W3UT&MUOBF;05a(U
d24fXNZ)#4a?<&FCKaNVM#cP0P@L;8dCA@+=B4GBbFTFTU,OOHJbZ;W^_<G5X.[7
UF^BU,C0(/<P-QXTK1O15@W4C,0fEP1B4A=<Z0-3/;KdTC;O>eR:N#gc1GfF\ZO<
?3EeU^#aY>MY/S\=BB>?31a\->M&H3KE5.ec5/AX==:I_FQ/FNS+<]PCQf(&a?@M
g_M7>GLgcK<J;SO3#AP\Y59)^UQ]TFc\O_BO6>43<-+M[0)eF[&;P8_@6.=3ZCXW
GZ\J;Z[ZIQZ+0aEAc]DRF8b)+UT)WgHNc\:PWM2/<5L;#XP6=^N[]a\I\,B5D3KQ
PAY.eASe/Y<DFIF&U1LJ-CQLP;#gY:6aV4EY]M3):QZ__Cc/EWgV,>d80PXY6GCc
2e-RJFNZ,1EN&/QN-_aX<GU?U+VY:.M8Z=PX#4-(P<@/=6G&_e[gF@=D&VN@<;C/
O@B:D-dEPeQ@\8Z@Rg/,gP-0d><FY5VIeF&=ZM&Xe.Q1?8Q]VKB^\C#.H<?=TY\d
:CDKZX&-cY8@=;FOL0XeLa-Xc990LP?gUK[G;G\=_E^XR\17;f8eG[S^SYg2B__:
a(E2?D8#DcNAc=)aA>E/NFZ(bVSgH6<\+T\TW+2QVF.N\]2D,5faKff\(TVR@g&>
WLQAR9\EA(,X#2UeMV>:L30BZ#R::;QYbE4AT9O+O6eG-QT,KW2/7R[ZdV\CBGIN
ZWVD)aI(G+BZ3JF_=gB#/[QB/WF:6?=1\R)YB=MJIV?Z)aE.8BOd0>WG;R8(Z-cR
^(XV_eD\SL7WT-#.5cIHND&^A@gM.[c_&BZ5+^9bb7SF/f(fg+gQ14:SJ#0>5T9_
TQ:(;M/c]dc]UH>OQ>g](AHDa#))1PJFc\,L264(0ad7bABbJ>.;JP?^554M;YX8
f-KHYQLHHN\B]+UI4<BHB&I?WUQ\)-EZI:\a4S6D73?=^6aAae(558GP8M+_9bX1
,1_<3ZTQ[#e^c/4@2,d9@ASfKB9^?a^@>C;FV@.WSN_L>86QCL0V.0=f]eK^@?+)
9cYV;>4Ec;,Ve=U4.3O4U<C^;C0KU6D=5=9?,+N58)9.f]D4b@D[U_O7@#_7MD5T
1Je+]_fX@86@44f^^;Q?1\[c\+/:eWb\WA&UdC/J@a3CbfUe&NX-1KYSGIB0T9>C
aT>]g@eC)/^/#Y[C[^DA3fL\FLG2#KY>95;b9=BXOC7]6KDQcB>F81Q=I<=)VV]F
P>>:AId+BZ\4Zf=19M?E#gcFNbO>8@@L.gWdg;T_SD-bLV&Va@([c;I>:JfHV(BX
/5;aBf[32+9I_d>\=?]UeN8a^_eV9C.&NNX66KWDNbDNEN5_1DH8aAe)@:/BR]6[
0/D3Q(4T:4XVVA2R?5b5AR_#&=V8eJE1WSSVRf+W9a5-,V)J^KFG-66U0Og4D>U#
1=SQ2(^RA#^0_:;O@IA(;ZU,Sb7,#,G;?FO+VP7KW4(egKc^:>Ab1K(7-(7GH2^0
(4XYef=7GHHPX631fBc2@C#=V7eK#BT7^],M=c+.:K@F]BQ,K97=7T;Nc1)N?#eK
)c[HM(,94)O:eHU0W>@9B^VYa,^\]IJ8(?4e0M/c51X.T9T2abNc.,\I+;a[\(A9
=L+&)X>D;J:F#c+M#LB2;2PUNR;aVQX2^;(eb<dfP1DZ4\c.X-e5URRZM\c(]T1E
gZgF_a6;J@TCHK.UNXa52-R06Q[FHYO.Z_b0^g+SLNc#8&60@WDGLQY_24HLIL0Y
2C<VXI\HRA[/V0/_R]g=CNV47d=a=ZMQY7^bO0fJ:F^-;gRf<LMP6dMLKJ99-[7J
@[2_AI0TA_6;bK_EQP(G?XUXE=>G>;=^TbG1=Z0Bb8gcPD/Q<#ag6^dHUU;CRNM;
6114,[\(8;W-g9>OZSSSY]^5eZI?AY<_S56#[DD+NZDX3L#,TK-Q<d3G7JWD7K8>
>_NJ6ZRJ+#C7U1d:]R;RT<VaO/11T6KYeB9V_Ib<G9WM-FXL>Q?NHfE_fCDTP9N^
;)+a)GTMC6e#F,S;UX7W;eIS=I1?D[+=&=(,@7#;VVT69eb=60Ka/V=S)fDQC<5]
RaNFbdGY)^N)9N:]5(9RS.^]ALZ[-d8\QgbKLM9E7K-]GNS\KdL.V_WJX_S3E>8R
0Y+P&Y=(0OCgC<Wf,+Q7FIXfE^<=/(e@RS=3O:U.GX9FP0.Y[JBF,9S7T8TB)UO]
BS[1WW8XZ5abTFB>GX3<91M@J4ZC+N-M=;.&@VB\d3FRY_Z1-&A_E\-<;S]1G2OU
AMdGYN_=@G>G,Gf3;>7(KC29eb?a/f5(T)[&H)LE@W[b4\6[-UU7CRG5)S)V0HW&
-RSS624fQ6X@Z=e6WCU-_e0?e9E,4IR-\fM@::9V_1^SO8QRCFTfO<)9HP-/H++Y
QC7bY)a^>LL:&31X2]?A\XaIg0?74^7H0aIf^Cc^1=cKed]MMO7@)8TJC73d&^U@
E=f6cGcNfZR7O/4I9c681=SQT>@RHREF/7+e4XSW3(a@bSO2^PZ^^T;2S\U?W8</
#a#XX;[CcA@9Q>SgB/=XaE3B[1SQ^T?QT@f#VZIgY/gTMY],9Yg3=Ob/H=SE/#Fg
2Z8-6YWBf=@Q,UR-7ceV\T8+VODW>=dbY:LKIAAK/Qb(AbI_a2E1.d>ad)dX<Ad=
>c5J-=5B&OSd;Y?)^g=.MVZE_Z>b5,E:,LP.(=31SS?dNZ3P,V-Kbb+bI+e=9EML
<_^M_f&;]g_aTTM(FgWC>P(BA)Q2^X<P\c/WbX350DQA,R)Zc;8.=fH?a)C.6A6<
0M\1:/+dPAE>e&I6FZ]5SaK)RSNM@\b3SD=H?6CH/GFHF/7_TCFb+T8W2_@VQOK&
&gJSMQd=6.)0>6,g=^3R1O=ZC>f[5#PM.B[(:M,^YL]<aIU=#5#X=KRK/Z]QE(fg
L95G926JUNSUVV.9]b74a.5T54C3>@M]&OBG.[=Oc\e&NfS-NTA\De+3_K:.#BQ-
J\O9g+b_5EK7_R:[/RP@NZF)#T9_:g9F,>@5)?VMCJ6VN+b)L9UO&4@fSJVOMT7_
Df73^+(C=_N4R:0D_0L)VAW@IBQS;PVFC#TId?:SeZ3BF:)8Y)\:]Q2U+^,/WK[M
V;Y\MBKb4X-VD4aZ-8IgZA,W=f_()::QVHQJGQ/FU+YDf(SOMX]CabJ_42(U(S_E
]ZSOeE4a3O<EgLa_FR-Gb+b88(+2:@<OJO#V#?4I[bZ)I>L&P:=;cX?T)#cU<N1,
3dUR5[,A_PJY74_32?5C9RWWGJ_+P3-,,[/3UGaJX9Pa5e7<6b[7@:Y/Y3Je>8T+
O[V)O)<<B^4EV42g_U-NW72b(<a+OKZU?gM#X.O4^dE5G+P^JH?D3]0<cKLUNGNP
]Z8VR-YEBYVE3)13f9+Eb094V>F85C;R.YKXF>IM^gFfD=X5Yf7CB.>GRdK3SeaI
B+Ta\LJJ2(.?#dTAW?d1eYSO@3^&(W31JCb&=>D=IV5OU8Z<KHDAZLfdGRCA\PJA
(+bdA89/Vg[VX0&aZMVLH[]7SLX24JGVSC<3WIN2[2QYLADJFa]34C)<:_M6YCY+
C0b(X.VE4d;;6d+(Z:XG4E\L39e@Rd#ROKLN,X9.8_TZ-V;(C[74T7?RI#fX>DBR
,XAT;Heg5BV++5N1,.cZJf9de9US=AT-W/3A8e]L6)(.+4_2_cXUB/6.[@c(5UX<
RK9M+f7:S>+IF_c)UfBG>UY+cMKV1[W;JNDI]36D)fHf_(cCFU5gP1]&8(&Ne#g6
+NIbK0HMcSd<Vd@_>D#7)MB_DD,9?HUTbLE/-cIN,\a-M@9M44XJe96P;EaZJKLK
W@<UGMOKZZKgU3K,-H;&OZKDB[;_X[CWHY+Hc_ONIP\a4W-dU,_Jg:dJ/7@(A]gf
X8U>T^,I=S:dREPIHe](1B1OAYd/T5;DFZ&W);L:;#+G70/c-]bV@^GBgcYE(_GP
5CC#e^,K(e6BeN:Y@RSg)=3gT\WG1HQRa?/=FH_e5_^X7\(-9E/Q@e2&<8<]/I/>
O0cc2\+3Z^<E1ZM0-B1YOc,.b^g>7NW\8#U\4DaH_/YFY8A#5&8[(2DM_b_Gg42+
g6H.(Mg@#CA;5],G,B7_(4KN@LMX)1G-AZ=XfeV?BEXN=e5,X:)A^\OHS)>edW:M
VZ514HWDR3bgdA<X3#)WO@^O6KBKNTSSVfC_-J9D5ICNLGd3BV@J7,+1/\#K4]<H
d2(Ub)fO9Af<<g0&]ceWF^ZBg+VW#@7IG2?eWZcXfY]H1NNE0E[^7+9]aH\MX8,V
6<_FLg(3PW3KX@?DLXLC8&5QdF5B1CJ8X@aG54L-4M_W1dSMX,Q<;F,SN-[EY40S
;BU:86aF6EMcC<14WLLK,BF2#>EYbUR^BH.5^TWGKV0)WHGDB<8]._75<@3/F+#a
&fR,,b7ebgeWcb_UAVMP>+[Y(g2(:\=K7(JQ++gGM;-21g@7>Y]].J1>MJ<V>]&C
H1f)cMc;&J4aQP?OLE\F(;[&ZUa\8;]@]FgV_N=ILdS&S=^@CSHUX=eFW+Ic-6Ne
O2d@LHP9J#]GWKGM;F2:8GUR+2IR_&F.d@_]e0([>KOK3g9&-R+d.Cc+B;Z=DZF8
6a=\+c-&OOD=.S0_6WOeTC44=Q1Af,LQ?,L//B(SQ641L;e1(X+T=[fNRZF^d@2M
=G>E7TK1LN_EW=1O4<cY:\7&Z.<QQf<g7-J&?UL_1(TJM=/-SJ7;&5D,)gXFW,e:
a&-c<_43R@LeGAAF-0:H0DL>YM3T)DT[Fe]+bC<gU8--ObP1a:?>,QAHK/e7/aNB
+=YF;JHgHX_E[LE?+D_B4d8[@B_?ZK=gH_fcZX=\[7V(d+#3-J_Qe3XA+#c,KW^H
Rbb<=>6Y,TXGeeb5R<J3aE>,Z)DW(W@?CDdF9;B+GF9eG_7cK;K]cbG>-Z]Re/W4
-\;+A<P@[ReVQdA:L[V+WaM_6(QX,J[2R>RT=_Ff895[g\6eE6\=P\0DUfG/YL8[
A23IY[5U-aQ.6YQK(bD.33BYQ-<FCd;dRS/N+J(@O-BCO)9Xa5#UNEaDFKY7#HgD
R6(cVY7-UV+Z?)9I[I5N-R;S/[GO\)&OQFGIVQ^e@7N&:3X\&\6KfagW+ZKL;Ce-
?]Yc,V)(Q8ZSI0\-c]c6V]DDcJc\-L2C#dAJd[@=5;g3T8??<0.8b@fN-.VMB5-+
+4GZJK_&Q7?S0$
`endprotected


`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















