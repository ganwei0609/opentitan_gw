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
fDQ.=0YNRKCc>I.;USKF>_7BJRG43-Q>?(9J831[YU\N>aBP>L4K4(S]P;?A[X6O
4S>QZR#b0fdQ7gE&1]3eIHFMeaXC(5Ld)=\59eOMAG#g(T0\WbeeaJ:H@Z9SAW\b
07JW[D2:>_/9Q2bJI;/cK@YS.HY097V_Rf\Q,/JD4dU^)JabT/GXOY/DHI/g+5?[
?62H=-D0=PL[e1<S@KP=G&++/Z48<I^,P/8/+fBEU_8D(X.:7@EEQ.1)Cg,H9.bM
=_Y@PA=XCG3M7HN=I)>_c0Dbg1BeLJ\G8-2cCACRVGUYUYT/KLVR<3DBZd8QM65?
[J;WdSLYU/YH?8GJ8=1GXdK4J6&A>GY1)H-aB_P&d#7@:FP^\1@afHf]?faIfVg;
DT^6=IP1JH<[6.Z#YWO1NAM/5,c@E5BKQ[cZX-V\V\Y0P[V(cSUaFVgDB/R1CIdO
7b:=:U9S6[((P>O2D^COJ0)O9[V@Y2aD\9APVNdXSUfJC:12.SJ51<?UcaL_NXQW
[A:M+OFT:7?d2^9/JLYc.H6>3:4)c1F^PPf[dO(Z?WNS3b5=ATI#5<a[G#&J])A6
YS=V_)T_VT<,P^B_N[J(MbZJ6JYgd.#;IC16?6=cPb+0:ca,.Ye:O]\N>XR9Y@\\
ZfKO@84+Y3=IXEDW^Pg^-WZJ1$
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
B>ePf9(5]_Ag<7.03)ZX1PFQG7K[/fLG=Z__43N,cY&M3fM,<8=N,(&#7U&QTEQ0
+,1\cO\WJ(Xaf>@7X8^,NF#?YcJ@,]#X@;VIW^R/DW3VD0gb9B4\@Q7,C^/O2=\^
FeefWcQ)EVGY6[ab+:RC(.fK8c@GC(/T@&O+ICbgMMM5dKE[[>)YFP?<b-NJ<dd]
^?NG#FH4X5NV#L@#U.K,ZJJ#R8ZL9H:/.B+&dT[KCKd>@EA2abA&f4L:AWIBCdU5
[#3AXg;GG^_(gA1c1>Y,50&9QM&_L&U//C8/NU\Ig;:gCRg9.L]H#QNPd<6SDVY]
ZP/,[ed=O^?C90+WC3:7G;TED=Y5MQ1/3g-J0g6L(:NOcC&S2gFM95RMBM:/]EJ(
GdWGR:4&-&QU#e(:0W8S]G[51.eM_)]D;=7cON8/>&bU^9O;^B#LZGZ6Ib-aF]55
(6;I;>19ZEM;=_8UQB=<+YG[(./-I=fc-[S^0],NWUIE;6>^=aHD@PI.;P8+6bg_
_b+R]\2W_>a@E:#A/84dMbL>[OQ9SY;=LaW(SNPS:eITF2F0O=)U;He]@e#E5OPH
JUZE>V&ZE73SP>)@Q<[B&d+IX[X@7VAAWX7fIe6=Q_:M>3R6K\=BDg[:GCD.e)PA
eS(338LBES#(f+<:N3+g3K7_:E:7[DMYU_WTY#AIC;f>?&c0DW_c>CH1KbI,bYDa
F-WOR/aG4QH5XB9&c5=0KWF1NS)<.9cM:_=7g?dMaFNLAV]?Z8LcA9Y[NSJN9DHN
MUQ0NO:9WbX#gT=DXLe/KH2N6Ce[F6AH>DXH1fFZPR?B_I5.]R9DF\>dP(NOWVDZ
2Ab]D=1B2)Ne4G:LVcNdOKFbZ8UGG0\A\g>^&;FO&O#I[ID>YAS5Z:N,DMTgZ=@-
/KL6+W),PKCUeC.d>7=A+d2FXE=X1ceKQIC)E@U8aR;0T\WNG=H)#VgdRK+(_aZO
0(Z;gXO)Yf7VODMEH+IT2><RBQRXd)gX+V&6PV-g=Vd?87A_XWQ-85(OWB@8(E[F
eaIAS[c,B0X9IQKF^g5.#=f3-ZcZ0N\H,H1a19:U0>R+4_+:&gT>:T:-)fKZ+ac.
J5)\eOQN&XZ1#7e#UC=e4H?6@;&6:7BJC9B--Ve\L>Q0.1S3QY_NAO^aaNP?+ab2
P[dZ.27CSfd;2HDS]TP;EQDf2gd,+6CG\5A:H;F1:6VU/>4W/>FVe1#T6d[Ag&GI
Z?7)6df^5IEGCFg-6]JVS0PDHfTUeO.6C3WJ5P;c.)?@LU80<Q,(;?+BfMWWL8)Z
OQTL[^S0=3TK,BEU>Q^O72H_I_/F+V/5,)D/W[1),geAYd+<&L\I?f0<SQYcRY:U
ZRV=b?WHLaCbg=Y9Rc\\0P<:<6aa<\1+->44d2EOZW](XAXM[Y-J=:HR.=].U6a&
.ScYg9fS]G9SXO_X5d+:J[>YgHf:](291DJ==6S><]>-VdVP2Y+M8/.(]&(0KR#^
FeS>_D4eX3#-^HgaOU)I@V-/4=<VS6aK,J?)Zbc.NeHSR4.N3KUX@75QfXRBBGfL
dCPTVK//^L:+8;T89CXF[eAX(Z][c?A_&1]A^f9=GG\C\cbNc8XV<)ZAe-F+L35@
DX^]+DZDXI\dGA4[X<Z>.;R@NND&#9eVC:<g8<OTWCKYDBR<d7:UANc7HNRJW_]G
Z;S>27)b=c0GW]?Og\SHG4;\T_=XM6[gLNFG@7Y1Ce,02D\I8ab=&CP^f@4(,=Z+
Ib?+gHB:bF3B<ZcX@AO#CE@86_^I-Ja08QMW0Z=LK<ag0^+?2/)B46Of(,g(?G0(
RULd6FP8cS1/YL.+1[S9ZP[T7\QS<Y+SQg5eE.AY9.7AM43Xe>dU^d#G)&7YQEbV
)bWR;:1f3ML_WC5/ZfEG50UGVG<)&g0;478/)6=:;1W&2SDbb6IXH.1.c.H\8&9d
P51LWPa]TKKZ_g.M->OFYF;-N]6DF,SV]O&;7bc<(2O8F,ZCPe;.GC65e9I)N1(:
bEWZSYc^?[_1X<3++5N,@&6UTGL0(IgS5<0<3S+O)Q+Z2R[MV+Tb2Q;.g:2KAF(V
\U_X;B\8AGVY]W)eR72#+b#:YNHSF,S[I#YNb9X9<2Vfc.>;&Q[;156B[LMgSANf
1>+LPTOHbW325IRBW]=]B30gDYeg;PB#A3<?7=8E(0f&_7CWNWPEeX-gWJ/7b[3I
6GPV.[J30C-QZ92;FbHF5[8P@IcCPbCcYJ#NS&5]3V#DAQDHX3gI?dX/HQg:5Icb
WW+fAHd7HZT5.(HgIEde6.NCeX@IOaTCcRW5ZfdLLC@X:U8@51>KE&Y7MVbHC>R#
CMPZ1U#1>A;JD@&(fa:T(:.:,bCKJ;@V,@MX5XEeX(XHN^&^J),Qa-W9#L\0#MP8
RZ;OeJ2R?]X=VEIa+c&aPNT]4OTTL8RK03_:^URQa5=Xf;Y0>PA)F^C7.gX)]=A#
;6=Z=MWBb_aN;0b\C7C/Obea7FfX5;Z-#R\PI>D+a5gI>A98?fW1CNJNZfdZ-\)G
K13\,4_OTTY8XF9)e<@S[#=c#ZG3](WUdA\228JW,J_DH\H=XE.]=b:1^fLBKae#
3GCE6GKA6>1)fTfCALdCcJ(WDYVLT@J_SI]A6],9d=XAB[9J?Sc.1&J@\KK9(G.#
V0S+48@OYaNe[EWHI)3OU2MFW.E\]=N+&=aF0CJF3]:,K22MX8Y?-Xc^R:VD]4]P
L06B[TW\g493^N653.D?[gGU-VS>4.[:QWKQC9?RA\:8f&C+6V2cJ2Xa[,5T.^R:
X/S6.@)6S[04eY0Q/ac=/X=XfT9K^X?K#<DcEd@C54D^<4C=3f6aI^[3C---<0ga
=HZN&K_>_d[.a&)f)FU/e,)Ue89&X&K[bWGdT@C-U/(>2-/e<2/JGAB@bGbCO:?)
YC&-)NJQ_baPYCXBNZ)5SGXR0.X=F76&?#ZHKF<IF^a4D5TQb(19HG(53@@T7]>M
-X/JVZZBO0K^9g0]AC8-c]=9PDg]a[\AM5ge8UX2X?9YS3?;5#FK)N<NU0COV?1:
+0<d,]^LH5ZW+dLEJeM=\4[cg8ZQ&(7C+8?[/?FB@#f_TBCTN<356a(>cDdP9W@a
<G3,8a7:K4PGP-]7X:C@1)>M[d7,5-f&Nd?XHNcLIUZbO+#:UcN1Q/23(CEOe^48
?A0E8E0O6U.L<^D_#O^6-X]Ye@cLd[:CH?RH6KV?NfT#4ff]gGI^DI0fT2E1BYa2
W5W]-Q#f<3gAI]0OeZ)LFFNaaD/[<Oe\3.9T+CbY)9,b3fFQ^_-d#dS]:W[9[HL+
(GA9:@5OPAf_C/EGW2/R1F.]Ac7F-_dJ#a-b0Qb2TD]PK1bD6e(/&HaJ(5Y;-DB/
cB?=<N3S4aCd(1VeSWK38Z4VCe.XPCM_#9>XXVMWE#QW&A(T(U8@[(aHD@6A+V+/
Yg0QJE=KWVZb.(E+I,/a=:cN1?B&NJfJI5R/A1U[W-BfNcGZMB<6AcgY,<\8C]+5
_A/W[M68<?7Q75TVKC5^1fLI&D2f(a/T>5Db42MI.A@+@0TPD[J<c3217==AA>.P
\D98#Y-+72W+G:5KYLB]37>&(IETd^AA0U.TG5b3C(g-(=JN]S.7).=Y^EfBd+\(
92U3\IY6JG&6PLF@gdBB14-G.E3AGSa(?3Lf/U4<fHE^&N9e((;BO9_S94)9/H=W
GA<HbEE]@\I^?7EHFDF>.&N8bd,YP4:cf]W]M?6#0.6#:5QE<PAd&E/??=R6=Z]P
1Y3OQ)WUCJ;G4&D_)KOD)9MSJN67,9a4ITX06M8K]]&fgF9NJ0d]WX\fNR4>aJ#A
D3,F4WY>X7Q>cYH2@Ha@T_<+@O&),VU]H[gO-.g3,O:=7#5[1PYVe69^@WIP]^R5
S@2]1+VL.1J[]=@[/:^Le(O18[;C^eK^8JTQ(Z8XK@3dR:bg?SP<Q+^/((A?KYeR
I81>XG2Y]>c=bY1G75&@Kea1YHX>J1]ec@+HKdFL&/.XfdZA21d]=66HZE7B;a4F
XPC8,eSJC&(YG[.aEfXR[M.2IZ9d]ZJeN(^#VY:a3N))ZeS#_dfR)<&&OM8&]HE^
-=E)c:b<(1c8cZb;>Z@-M2E,S./=(<N+X-a<UW&7E_CeXOLI26C.g9HeA<^-9FWQ
O6e7Z,\T?<Fe.)Kb(-5MUUNe/>M4K>TKPJFKbOP#&(XQ^L1bG5B-28HeIe<GYf]W
Wd)SBQ@.,(3[9>BM+^Q=T5F;U0&e2Y[\Q9XE\N[AYI.K>1J#CB-=T&A>)/S(YK[f
;?1/O]_NY;5EWW\b]Q/VGNH1CYB^bN>SPD3#M?F<TT>.dBXWZ9eJEQd<_V^e:4,C
_JW7A&_X/,&E&DHBB&RK.(Q]QY1a\Y,_H[5cP4=NKMK4Q-Z8V6G,SLZIM[:J+]_4
0?gd])<:e824?37:5OM><:dP1/)#A[,;L5(e8e9V2-HUO@>M7UE=XG#LD@I2+Z7a
AKRJ,F-^#K3ZP^J?T>:&2D16cL?8\#P1TUXWPG:O1)_-[O\JZ7DOK&e[gTaDUE?Y
E.#AD?\L-3M-^#)P,1U_/K[R+.8gNMG,7eJ:G4?67,6L9)2_dEJ^DZ\I61F,5GM2
K;?FHfU9)H<Bf]REJVF3)QA+PT1H;(K38JZF#fZ&)CDgHYe<24f.9BT>+/)@S=Pe
3.LERDaT\G8IHO)/W+?]SB?TGD2.)?QC7<)M=4K)U4Y58);<;60#^EZQ5T8:d_?.
K1<SePd74&#-[RY&TS/#9(/2_3UV/5/PL9DUfT=6a\)b88Qb=9&V-G(6E;3a\9&K
3@]YR+5UK1#_[,R=7>#.V,ZUGU[]VJD[3@6.LaX_62RG7_=C<=?AMC>PB(b>1;OH
R6W<3KDQdDH().TO[;gU;9TXEMg/P+LJ5<3g71La8f@)#5-T7N=e8Gd3R)K\V&9W
KS<H3-GZ_d#TgC^8D^9SD2A;ZU+a-57&)D2O4@)#V9c;)1d)gJAUB[CO6:+VDaNR
L.FdA.-R7?0@:W5O^aDN;e1Z&-@<e?+8:gfPg1@0&TI=DaZMTT0K/0bfI^6:GXK3
&7N57gZES#@L_0YJ7d=I[YVSKI<BUSGEKd(26J8C[]GXZS9<EP>6,4e61aaeC,c9
,YX)89]L.^)Sb4:-gCGc>-5ZFaMGPM2gS0-.BSb1RXNXMAPM\bObYSc:T7;71;A3
R;?;H5b#\7\,4DB7,NA]7cX4ECf5.<gbbK)&NS&R]eWfNMZ?#^_9U/,Q=._H>dNF
/,;b3bM#V^\@(E1@-UefBL<CCc9(CAS:_=/CH8GP[QBNQa?,)9DaO-e_Y]e#A,SO
/YQ,]+T)]E&@BEL^23PNO?CIg]f5A928M[B(d_ReN)XJA&_)4eV2@#dG+57=G31+
26L;^=)dA(b31dZg/3M[;\O\>:^JeZI1)-_JJGK#E\4RQ&^:e]\bGV^YA74T2Gd#
FcYecb/L7QX/(PWC^P=PM]E<?XV8-K2G;<GKdgT<a(Q]5Vg]K30E0K.47SNJ<Gg(
:?^T6_b&-KESISZ-AEPO8(:<b&Z,gf=^B::?99XOf)5TY^ZOK[#7:gd-,00U2c3F
FNIgJJ[IWH^J8^(=Z^QA<QE1g\P&C(L[CFEK-fA9Y;QA2D)WWW396/I]>,TGXFRO
T8UAde>/A),49SI&MGKTDO5UXV6#X8>.eB7GJAY.gOdKQ,5WUX#d#1-M]^+EFUXX
-/4@,ab#4T=fKV2cS(0[d^B7.76X=?;=c_W.8)]OG209\Z7\Y#WU,C1/P-0JQ]bF
:],?TbT<PQbD6+^?8_?3WH,,11HgOf2D4B^K3ZDFJ]Z/_7G>GQ/2FFb,T&da[c(6
-,:[fO6.]WC<@--_5DAg=)b\3g.e_]D&L;7+@N;3:RN5?<E5CD+^2/8JPMWHAH:9
8e:\WUPPFcbPDMGO:ReFC4e3X.PUG;AIT3LV>,0f[,G]O),7YU_QW,KAQgCMSag(
>0-_Kg\ed0a5-P5Y03d8FJOI5O+JPS8+EPZMd\3L-0U-;NPF??37+..?AP,Dc@T&
ONWcYVA76+XLE)/[)+OM(ccZ)UaZYb77V_J,@6=gU.(1^G_\F#,gN_TY3OPN(_-O
+DUTI:+Z.KN<:D(=PJ3A(YXI?N;AQJ+PAX(Z86BA.KTBWX5Bc#bSK\+&(.g#]N_U
9f:O#6gS>1Z3<Ta4EV>)Q8=6B/Tf[P\Ef>&ROF]TB5,V4][<+H8Y\M6]DR]Y6O@N
?dY;YJ\FbUVC5PI]8KW0ICAFW4K1g?c]-/^.e4@I5E.E2+=<fD^P2M85UZG_C&b+
GVOYGXCS.-Q08)e]b6AB2&6f8O9;5]=HD)FG2^VM;Y^OZZ6=W/;DPPP[C]N&TN0D
3CP#=dQQV1,I7c6#:dR0&7NX],L3GHH.ab\IA)V;:7J/Nc9<+RO(dXCIW(S4(9L4
efK(.GIY=NS>N;//1I&D9FHYU6^-g829C&N;e,b^F80e3dALIgMGg52a:23C9+@0
-<,DNTA+7]BR.f;&.8A;^BV:(M<GB004:T@:5X=g?JM)(ER]R;d,Y9@QP:H6fbE#
-,^;J>)4W=+Y6S<b1<Ja>:D9&a8E=@Y64W)XHQ,_L7K&<C=Dg>T;]T5DJ+#NBQQN
cPI)94VaN/OG9+WS7]b5H?U)##3K?e>W_XVC893f+I04;)>/&[6F>-;A?I/F2IL:
;>P)(@<6Rc5Od?W/VUXF>J-1VT/X\F_Z5Sf4M<U#D@01DQ&:4I2a5g@,KKa:[>GA
I6dKDNfQb=ZHb@M#XB/9>MgZ=bd]PY-/ZW<=:d&IA&,9,JY+;7P[E_A+NH3W\])8
I:=#:;3YB[e7W=_1^RGd87/58B\:PG;c8V[HU85f0N@LQLUM;)BdEe1\C-0Q+IcZ
06I+b>a[a5_OMOR6#BcL77Y:(_6KDaB^/KG[:cH]QKZ,YJ.IX/R&+GG]DgHTQV7G
SfaC?LD4:N@DR9&7/S.OdbOTKL\Fa?F5_KWX=7ABIQ)6SX@2d0A].=g9OZPI?8e]
\[L,NdT6GC5c@=BP^9E]@MM^RI;FaA#BD)]5>d5cg&?IA44TZe1BQGG=:-c])EG1
N,M\a[UOY5F)?c^&#L-?D\>9F;L_BIL=+Z2c)+Sb@.=c;D3W6Ne/dV[BG7-Z\77Q
c-DJLO5g5@&X/1E[]7]^()MS,R3IGD(H4SGGd,(QJ]DB?:cKG?M_ce^[a6U@+5\A
.)_JP5PH]8DF/#78O]FZ8UP)E;.LN)b,D#K4SAd:K;=Z\a2:UC.7[RCNdC#HU=:8
c0W[]9?ae(;1[POe&[EF],WGVM(Xb?OL:W^P=O3;2/a)Q.cHKFMc8YY81B@O+g>^
F2H]>[1bP2:57LKTOR^P9QTe6OdZ+O_:@6SU]>\e8WY39g)9QbP_C0<?RPgXKgJc
#[]ZG6/Ed?#6/ZTC),f?M_Y9Q]/a.,8O^5ZK.JBNX(OLY/0FYC.H-BJZab.,_[+S
(S8-bL^WK,4/>CU:F5fUDRNIRPF\0.YGG5K?Z)acbWI<\S>>f:eQ:WZJ@ge/B]3O
+4MagYV,@@IKNN0cPK)M==f6MN\bEWRUAD+PND-);(3[/,&7+eD?[[M6=(#g;:5E
\G1+S9KdZ:)]2@W4[M>E^W>8)GAXUN;TY3Ng+#7S;,#,XAT-#@5M/E3R@WIL^V4=
BKf7M3^QJUVGFN/cB4,R-WG:05YfI0e4EfN2C0Q02&@b@]^V=T\Y4?a?PcZgSM&E
S2(X]6B=7]>LY[adL:EO[/@2-,U#A?GV9EMMCJ;d?H&DSTXRIb)6;C&9T?_#9:FN
FT,G><JZeV^3O5MbXAJN/N>UWb:D+fIRW7=Yc]O7^/74&S9E_::6g3>YB,8;+(FN
Y/[::55#JC>W,X]M_L3K+a0VWc68g3>#_0S7bUdDgU?O+&F:7,+:>65\gI9@Y+fg
QNXD2XA#e3ZdZF08C:Wbc(JXYS<(R+J)86.;I1>@ADMddffED0MfBY//,#OP5[<?
2>60HX9GCTU5W21V]fX6\-NJIFbL+0GLWbZ#\^I?cSQ7(PKWU,MdST7LJ^V<2U8\
e3)1F54=G35_c?K--R49DccQQ-0Jd/@9LV1gAKN.@T0A]bAaKF&-M8)J.;CPP)bQ
3>U7H4X6HA)_&5cE\MFDBTU<;9HI_NEXf1EA?=gYa1E^\d0FW9&EO,c38B4.eN+#
0a)WU2g\1H<L.9VB\_b;9N4/G7A,K[NIS+L028S>D6I#d/4WfKbII_CMVSJ<^O(5
5\,(XZ=#a:H350(dA<bRV(9X&=a-gO5UM(eS1U\>UFb56J=6QNVdNV#>6]NTZ=\C
;&e>E;Kd\:GA6YAg7?e5<2P_N2JbBLBU/YS:&5QW]]]\e]U]=/5C?P&+?F_/3CU1
AV]I9E6c)aFE/dHA3):).&?@9/H>2^,;0&]bScDN>AH5cB+H;,><E6KQSYG7K/;X
^B,QfB1b^aa(>5T/PFH[D8b>B[S50CPIT?IcX#H0M_g;KT@4UbJF25>-6;AN/?_g
)\(O=f+)4@Pf5I.V0dc58-81O&8Be2+GAaCOAbV0(IQgfOXc_5;4eC3B][>QCZ6(
G12KH;9&0d/YFU@Gg/d)#eFeW\FMVL>=1GO2\0^_@)J.]_;c=A\U4-]1^L=&2:_a
64HG5d]06+2864T<4g^[I6]JR7M3\+=EPWN28CP1Y8b0M,P\g(+#@RI=Y,A4U6YI
9&]QB]M\R9(QfPWT60(bN1#6ECGe>Z44/::WH<8D\J=UT6C7A3@cVC;5WE;#DL9a
4L7(Z,ZH]:9,:+X[WC0Rb;UB:GRG=P1Ge7LD-HHFfOg5[cUQ(LL6U4[:Q^W+g0T#
M<@<5b98Q-DMQYe\#>:@AG,,8BJ-U?4:(2H=MJK@a[W7V)HOdBa=+H^HbE->TLBe
]3O3Z&gcDEW@7RHUg[K\e<^Z@#1#XC=d5]b:<bSGAQWg/bWI(R;7L]T7LVR\8KES
L,>]YS3T@9^KSN559M<G;dK8PHM;9X:5Q:cfN-KH0.fL8J<D4KcD9UIR27cQRfaE
]Q&)T<O.7,f<<;J?T;F6;;LgQ.HY&:,S_68BJFcMP0,6+3ESfaZ4J=HaFK]5-#FR
CI18W]P,YV#-9-Z/OeOaJLN);TR;?>^H[BVOJ[\aD9ZWG^[H.F40c^:7c7RZ[e>a
ARULDI[NY[O^#<5O#Q.XYIWJMW^X?=(?<9:)O9RXa>&^eDC+C92-V]L.FV^4gaIM
B8A>cB(L=7FV186C1X5D7Z2>g+)OKLe.I#97<F4R-D\0eF0(a6B\Lab,XcG<PY;K
^-V9b2JB2aZT6I@_),g5IW5-=bQHIbOV]gZ#cQ3[0#+OC13-gef#.Y1U7]>RVE,#
ZRV)<]WMHF)6Y7;T+AL?LR-YbZG&)=3#QL,9e.bTX5#5_5VeKHX51+<S(/^0a69V
;JYef^^R_QIDCe1CQ:T-Mg&FVUG1R9g,J3(?=,/_E.f?\_C979eIA-ZH\-)Z8/W&
T<O^@,PRAMGfQH+R]H3/,#a+N@IW7/.>[Zd#:@C_aGZ(K62P=XBDB,[J4UH]dYY@
G3(<aAb=e1,_?cB4?e_(]D^/4/DW1caYARNLB=B/YfK8^O)f(WX-7ab)KUIIZC,H
b\Qe)QfIO-OJ455LDM&2cC4RfV0HJ8N2\==JI,T963W@gS18-R?F)P8a-VKASPLe
6ABfC,HV/g87D:BGL(fD=b+J).NSIT@f=WI73ZFD]CVY9Y_#Q.1RJ>GZO0./5I&#
-.050#J93IT-dOIb\Q<IHF>aTK<S<P->&#</8WQSW9^gAe=KD9beHANgU37ZNgSO
@3[UQP1A6SCAGTY0[\3/S]P)2H2f=CYY56HVW:&>/<?MbRLJSeIb4;4G@/LHfPV,
\ZO#U+<H9>6?90F&2B)ea@b]YOK<D[-?,Kd,.Bc1?INE44:0)06DJ[P2[4@:J=OP
9=0Y,NY,cZP@X<Mc[\38TEda5>1HI:SUQ>Vf0B\(XJBQ1W2a-^A+#]>H)J?[\dNY
Q8D::=F\YT[Rb@>:?L+eM@4cZFg@[[c&,1B;Qe/-c4?8Z4?(AWgMNUAJA+-7GAGb
T<Q)H;<M[VRCWJ?^\#:B0_CRW?TE4]3U_fFB0HAVV^+[@B&V0FG\Q][Ta0-S7(+I
G4g59A<#<)Y?B4HdD/g#M\I@-0@L9e:ENfTM6)(:^#9EGS=.D-GYJP0-#G._ed5D
8AL_MdT7;5E_\9QWYM:JV/>FHaXI]dDK?1=(QM_b:N_dP5>;9OX9X3/INGT+4P0S
YC-W38cLA22ZT>TDM2e_OLO5_;eM2127?L,^7/Y+b?^-O>a#-XW\g4]8Q,T084Ee
:4+;L+U1/dQDG\UWM)V)KS7&6HM,K&_C7HJ2]+KNfH0S>bbGf?_>]bM7b&]O=;aU
,fUd_3\TZ\3[@G>>fBQ3CMRe,dLW#<A_+->C<WQgG_0M>9TL5<g#-9aDg]dFTW;E
,2FNZ&3&d[&@;\>5D-NL5/Ke67DM^4LC7RBaD[AAf06PNR1])DNe86X1&bGR;g1=
R9PBPEIP6]Q?S-DM21-<&;L7<CZIQ7DGC:7EQ?C=B?QU4QdQD>5+3Q69BML;Cc[;
M(E(,CR2@4#:L\O\[E<;U;6]4R_1RVZ:&935U(eA4X=#/ZdQ@UI@,WZ82dG:@IE_
I64H02OH#MfZ[GB<56QQ<8g\IXUJ86^Q#@2@S6ER#,?G6/JHI((J?O/&D<M&f-=K
\(53APIf02>P4Nf,g^BgHCL+-BeJINS&Z?g=QI<dFNX^>J>O:</7GK>?;#[,D@1Z
GWKS&JD5,8+/f0f:fIH22LMM[2Z8N38;:CKbQ.\=L,OD03Z\LaHb(?Bg_@O9AdPV
-g^0c&G\ggD5PGM#?ec8[U.V#;dWc&<LP+0Z;I.FZ/KC@U:gdX9WQ,-\]0a+>bN[
U@ZVg=d(VQO7GKB_Z1F3J.?[,HC<ecfe#cCD-_F=ec>Ucg4d8^433_.U>2UbL]TO
F<>YQK6MAU\3bY=&0TL>+E>G(<260[./^(/e5RL]I+Jb];P+71,b5RfJQJ5HGdOE
R9R]#6#CN5I4^CaX/+9ZD^T^HHU5ZY6KHNCdWSDAcV6W@QdG@6J0SX5b5N^IB>a<
@1J(]A#aAdT,KR4\TUM^6e=G:8<2/37-_WU+=SB_<<\bRdGT#ZDYITJ7B&>a;PNK
Z^cE^:]F?]R[L_I)JEWZKE(M2N4/+TKH=MEYC@eZ5J@^FL2P#.eNb_fdcD[8Q]Qf
Fee)4H=?<0bb8VA.(L_GVW3GN@1C>8B^W^fH=5;M082V)ADLJ[@b7VD:CA?==[f1
._Xg<Y-OR_6EI[9;1IJ)1:EAdOW?g^fcW)<Hb-I.HD__)8/F;99V_Pa<MI,PVb^U
KXSG01JA]?;/8Q3JUC5(V/1F.TS[XN_V&\dbF.7&/T,A[TX,WS@J@]H1O>S5VV59
]S,@K1B,JP.?_8T6X98]MZPR,g-B+V21,Bd@caF<\SG8?8Q:(<A]fgXO](:(/<BZ
ACC1R+>5Q?GDS)@JXBA=0;.@#-U/G_HN_B=:TeO/5=gG\Zc3Bg?PYEab7B4?f?LI
b5]:b6=9aW4Zg@<dGQNS)L15>=9CCO8+&c[87#KLb\GHg(>\d9Z9aEge6+E;(<=/
1P&R2)V_fGB5/Q-c3#fOQ?D?]5C/faJF;-Z-f2dSMJ4KfAOe<NVO=P7?AOHS5/dV
[9F82A,5bT4?.a9Wg;Vb1_cI&cSe.&=I:23X0df\e@e3HSE+YTO8/.\28B0W-g2X
);N;_:e3U+c0D^YHNJA+6,MaV?#0:_^IZII3K=KZVLY+#ADdb]TE7,A(5(Q;>B/G
QL84c,1>?ZG@T,,Fb(2D?e]5fb4/ObB)cAN=?(;6UC;771^)RO]A/PLZab_U_Mb0
c-K@#afX,DDY9Z4MO2+OB/@U[U\R0^P&bT@N7V5F@Fc.(\#dSV8bG-Xd3b+&e)1O
/1YO,@+Nc82FZd;gL[eGa;4OeK^6@2bPFBaYS,V6RWZ_JZ3J&DcQ\,f-#>PA5E\b
OR]^(5@#Q\,1U>PF4:J&3MeIJ6-5T(?dVQG^T4.+<X#1_ECcO+J>XQ54MMW?b>aa
O[ZHSQ8V=Kf_T9eMF2<IDY^Y;M1+E-fb#L/Og.O-J35S0LO+-GG8OaOBaTFTBE&[
Z@bV5AM&&BS+RRP?b(+.3YReN071c8N8c;cd-6A>?#S;BFcJe9IUHWMB3LQeJK:,
CM^0eZUJ&g1.CU;cgFRBJc88)A?DNGJQ3H&/b&8>_5;.eQU+g^NOEY=f=VgNdKb+
gb3gF>A9OQ0\F[+9:4;\G@A+PW[N3UU5VXLH1=-Y<WZ2]/N@#SFVcM2g2)dZSe#;
-PJ>G#13a3#EFWT=6Y?&L76#\ZO6NWB76RHdSgSPNA_RX.3BF(L=HCF2]C7BQ7:A
MI1dO6=IV\&YeS7O+BMfQM+K/Z.E\6(J&M_Tb+IYYTFY]=F;;/7+?@UJFb4?LXRe
F>#=I9SHQE>1-KW7cC]4^KMMP\dAd/WO_430LcKHHH75?c+8RX+4:P3cB1&dSX_Z
-9BXDGO_F:BYgdA/:1_4;V5^V8+aGH;T3;X,>BeEW,YF(1aS0g7XYTBGE8\=<QDN
IM:]G5ZLEMQ=)WMM,Z:aLHWE+U64M#TZ>DU5A[2\S<&4X.G+aaVW3H=,K@6LXg3+
?&\+5<Y0./J]#=HGQKLN]^>((;,,[S<=);(-SJ@:DN\<bXVT@S)^U2bV=:cCK?Vf
:W#]?/9,JQ1O2_.3CCI61d2F)1dKXE+SD1Q1]9EGD#>_&cbc@I<CB<9MKcHCMMJ)
90<gTM8OV>4.W?:e<@0E-FPBeI?@QU;Wac-]WfH.;Z@^EIVbYgC8Jd9JX14LNZ(C
<_X0KMAD]9(bOJC-9&BE8NRY?5U;[)32a=EC1LNS=2:^B+5[1D-1Z(8>_Sd\.A@A
]:#Hd+H0g=c08MT+PB,8CFNI>]LRL(,(H]S19/)TTba[=9JI+=0KEBS/B_9<9e<f
:P9)^T6dG40P(:HL]&-5;/<Y.,FWMQR0-)^[D9K\e7VAC5[6^_KQe?2+=]X;b=.S
62/fK^9(FI:;C_BDK91T)]YCW1MNF^IAS,)^U\,]BK8KQ<UYS;d8(eK::U&N,]2=
Q+?EY:\QVXD.KJ\BE6Lb7.1ecEe+=6,S:-C,S=@P+H+4d+4N;+@#M&bW#X8F&?,W
&\?127DbP,Qa[f#XgbZ)NH&.NP\\H&@CgF9KRSG4cReYFF75HQQ]#.W(9RU^]?)_
P>?-RW5;G9-/.UTO3&SMZ6)O^^1NY-?K?PAL]9)4b&a,R1;/>TU[/K@#.V.C#PJ7
.@7(1?:X@:1bHe6,(Ee)4+=J4/FagXcV_+509E>JQMdR0-Je2H:.AB.b>RT0Y4T]
^:+)g;Z<F\\:-+Q^+G#dSGb6X)XM/\D_(2.)^\)Y_c<SFJ6Qd^ZWTMME]YGA](.8
A&E^:T#B(d2&>QG_]gc86TJ_NC-f)AIN<D:]S/SeU61+6fZ@f7OU,OAUW9ODLI6J
UId:3@3cO\2>?KZ_FD#(?H:^MUdB#dC\V:.FVC-b@HTWO6XP+gFb6f#:,45g)-O1
#_HMZZQO38Qecc#P-3CcR90bTT8LBTU#>f.GFDc,P0a:A8,]\\Q)OVKX#XP-XG1K
aZ;/>CP(8N^-[[5)bNUFL?]>]-bL+&fZe1IeZ@]V;[f(5#Cg:3O<DZ\c7KXJ9<92
6HVI4MHK7Z9-S4],b]DRN_:6/,X_RgU4>+]_c]@B6-FH7fRADbGJP5?aI8K6SY[@
ZRAb159,\2PaceB3IX:4]XC[E\cQ;bQRaVGUSSTSe0Z@;V.&YcM27UHg<TI^cJG4
M.XC+1&Z2XeP2HKc/Z0U3(dQK(5.(/EbS\D.MESKQVB0(<aTD(F7PcNR)=H38LN&
04?b=XAO4L&HK([M+1Pcc_+X-g:3:J<.=#O&7^^)OTeLX5a@)=8U=X,a/OS?Z9YH
AV6+,E=^9M-G\^1Rc\=?\RQW3[XbTFB?&4WaTNK2_HJ_XWZ-\?4U,2]G^ZH,beV9
[EQ40TfR8<[B&Fd&8S?/d2X?+HWW&C:\_Q[XVNHgRb=546L7Pa25[=]QgJB4H?,P
.g;=M/JJO)bd?&2:ce08KWRH1e#U6@Y=:+8N72:c0/O\46@De[0BAe[TO6[I1JQf
Q:\6GdIaN/9ZZ[5b+bKCIbPVZO6I4]?1@V0S=OS@&4/O5g1?g&_^24e8SLMQ^5@D
U7PWXD@g[(CdGISZ6W..ELZY+Jf4L>6C>IJ]0>-=c))VZ(TH\8B1&3TC92:^OSKK
9U\RN(YL)b^AJ&QJ(L7KQ,F2YRZ=Ye1-ec0<N@aM3T[6f\\Xe0Z]1c&ccAJ/^I>5
NJ76(,.#1Ra@.1SY&=?(d-L3dKb4WcODTVLaf[J:4M(I5K,AY&c+HYLQO0g(<U&/
7LCPFN8+ZXV8aYVX]A?5a3XPK]=ZFLNeHNH&YV\_@2X.[Z<C#ZP93G3B+=VP9E[,
9^3-[O_10b_PJ:b:6,P3JTY/70WE??_JS=HO_U@g/Mf9GUTS1YRXa[C=TW9^U34S
=TH7C>^=OJL+XQWTE<fNgB;JN<J7TTZ#=aUK2^H^7^&.Wb>_ZP&TNR;]?7I=4fWC
)Z]G-Q95cGdAS[/_LV\GLa#WXZMNPPF\Y\(2-#,(KIL^;J_@Te93O#,QUfUQGb?F
B4#?()V<KcD#20F=.+D(9Z^.5?@e2#a9S8OFDgBYBd^56=P1&,]@>1P:eIOTWaf[
L&_K<g+EGgFBP99))C#9>a5X)[.P1>Q^@Y7-M>L,XP8MY+?2ZUXa@W4I6G0D6=01
7JIS=)W1)d)_(ZU:8FP.[KE\NYEg#Z2HSGD0D?)<,>:7db52FYZ:?AbgS7+PaP-A
?K7/b#Pa6f_=bZ.3]SWQ-WDc4@9;?/]\YD852:H(,9_-3T+fG\4]ND=OQJSRHLCJ
5G^G34L;R-AACXKHEc@9/;]V(?gC<gCcB-Y4E0)Y[28@dPRI/#c6Q30WU+9;;7)7
A==QUgZ]QN(,3fV@6LM\2)?/<J@-41Oa1T&FWaMD=[PKI3G2JK-g:-7AD+]B^Ua8
3>,BXa.KN/?YTZ?ZaEb?I8fQ8OCd9AV\P-<?N1##0A7LB/;bFJ#6-08a;2J/ZbM8
-IB[_NfK:)-0aWV/fSE<)@b1(^QP::ec:@SHbe(>O=G)9<X)gf.E8=>;:@J8KV<B
6#()J0?A0.BRXe<,K]3fE46(eE3.RYfGO]6I5NZX)@2X@FGQ8IP:#1TQg;U^f[<4
-fRI<Kbb#8Q5+9KOQ8M4GGV1>:G.QO#@e;b0ETd&_ZDI?GI?gg<_-^WISI^#@F:U
&S#3b3e1Q]QWe@:\BF#L3H0R:dS]8NA1(NZ:H4D=S9d#/4U@ZMXe_X7a/;A7=F:)
E;EYC;+_15M;BT]V@QOMY++IG9K6\>S,^?L=O=SbQHEe-J3ad#AeW6KEBf.F/=-T
5^@0+G9R1ENJ5L4\2_J:#)ME/a#>d,W\DD59JNSCaDK=VZH+SV?(B--89^TM^OU&
_H/,^>bM]4AK-3R)8ZHK64/_C0RCKZ<3<daTQJ(,57NJMaS7([M@EP47DFY]?F?L
e:8;ETE+ARa_NcCC]CbS[]LZUFW5B3VI?X3Mb[X\92J;UW/M<PU#P\,.LXVY;V#>
aS[CPIb;OSRe>_@O?g[_XUH[O4>N+.N=G,1c:-:=c\/@.<aHIW_S^-(Wa\0UP/AQ
X>3D)FLMM#&[H/b0a]93E0IcW/@IHad2dOKD78_6Wc#XK<4E4M07[_JK:(dS,\gI
:-CH(a>?Z]c6JK(E?E]82RF#Ge0/aNQ-]FJSARRaBg=5P.7B_GBgO)0bO.a&:,R>
(&E5K_1fR\V?HHa;117-:-XYGb^eY[#/AZG/#/[A93W&:DS[26IAI9^6K3=CJ;P_
ZEg3.>=]bdK3H2-LDJ8DeCFc(DPGI8H?TSCO-@-1#9]/e-<d0W6KWRLX&\f5^/FH
-[BLVY,CV/387;;3;NgR<G37)f-&)3B,.+T+XS>Q(cC&9f/eZV]UNgH^dNKf6@(X
-fCC-RM\MGR6TFV-F[JO+FO&eW:9Ie;BIS&X@</=YA?<3)_g#g6e[NNUJ>N6^^V0
9K[__DW&DZ]?M,CeAIgCARV9Ja<B69#8L_KBXb#57,KK#L>NED+.CV[TC[4&fFGO
A(SL:?V-6)gbD+GB@7)#@G^[0dI68gU_5+W29Q406GLT<e]b:9YdW=ZAD_3UV_<G
7(LgZ89.?MKgg^URU@DZf4fUbO:f]BIN3NA1cgLP=ZbUD1QHgVa78PZ\^g8ZbDWR
;Kd-F6a=V=BN[_\.0;6XgT49R5.b9^:gN#8)&SdEgE81@eMa]B352).=OHP#G.Y-
9V0YZ@QL0KNV(N0-Z<3_Tb3T(ON#TP/LePDPP&L-<K0/f=R<]AC,\D>6MBU\a^P>
(D7FC>:W3@1:Ya[3YA_?[9B73#C&.2F=eQ,T]=AQ]K3K;6)@MIK,8f)<N8QHdECG
?:V]7=L9KT@9MHbcaV8QPY-01QNX2\\=&f)3JfEMg_U33fb?T-f1eT<FUN][SD9g
IOeNOIcMEPb9K.2FFAD]&c?.(5Z9)4B_A-,M@Me@Gf=0D_C7P69):B.b\HFR=HY,
/B0E(;D[O,],#d(G]^)+<.3M18e(b4G9[?HR>RRZX3)MVF?G+0T1)<6^=S,=NOJ?
3=KI+6.cIJ_9.?-E_TaQ()7#gSK)g-OX^R\T.V>V(W@NdTbf09AXF+&/4gC6#\0(
W<#0f7&_d_d6N>cBc@:QLMfQS8Hf_12&Nf=?PPLf<AFO.0&4/I?&K@4IRX=L]AOf
<+c(ZPLFda,(K-@8O4ES2gF05IJFf7\d.V=H5P:5f@PY,,=@:dDbR-AX:(L@1B3B
bFVE5fbXgg<.5ad#XJ2-&BMOC;c&HEfO4,.<-@(),N+#gAa8_?eg[&LHKD3AUY3U
e9U=W<^EW48S1;Z.<5<+<+VIL\Y2G6W8[,VX0SWW]&E(f0\<7K@G>[MMYDLS6BS4
gf3M/[X]GIR8#HVINGXN[K4(1O_>(e;=bd4N_#S(V-D)XZeU#EWRK45-3-M^HcK;
#Y/:FDL#^I4MMa[LO@19F3c@\gTU)1J#[_.eID-2Z\FT9>&eQGc8Qb6ZbTKcG9LC
,NQQaN:#\CW<C&?Z,/)UX^H+N@LA)a#1ga1EL(1IR+OJ,FS3]A8fXCT?&-7XFC.a
]8X49RC-U2-MK9L7-eTZ;E:dNF<:N/J[EJ\@+]5Q=@N&eWSH&U>EFM;f,CbBDC\#
^bBG<>[@&VK._)[+HA4NK#2(;:Lf,QQSXPT1QQ8\dAB+eOFWdAK@7G)^=91H;-EE
.YDR?33;cZ=FI(H#cF\1XHA/9^,7;b43e>,1L)/((=Q>.2=Ng=TfMP=NHCW=7.;I
>Q9a7=4T#0BDD51+abZ8>V@E=N&G\.-<TYLKD4Z6PKb6cGO0><:F+:_3#A_O7g?4
3,#0]_Y1R(VSaD=G5>F(JaO1VJAa9Z8P5T?\:c)J86TcdSX.0Z1O?WAe(M8gPe7#
EGf?4=W?\ZL?KdBC2.XSLSWTdO4NG]:fEH#T1CJW2e\YDK>PG):?WYT4V.A0SIPI
dSCD<YY_e&3FW1668/D:VD:?Sc[DET54B8064R>?(fgCN1UGSC_]5F6D0ZLG,IQ<
J9GKU&fB;2;(OS+:A)N3a,H\T\,=A>ON;(b+SO#(T@2:;5/IOF\YCg)+>dCYbA/V
=47fg3OK\&[)O+(&6PZD?X0Y=5[6JW>4#>T6O?E&ffBZ&CVBQf<gHfUD#:MH&)Ca
77dK<#A(WM^7&0GI;JYGV\S>:fFGXXE(0YQ]T>IDRXNb4SFY_G1_EEdEfZ?-R_J,
?MX8V@KeHXg3UEMTXEB9QaOVdEH7?_AYJJ_MYXH](AZ8QK[B)Se?5KZ+9V(Za[,G
Z;YU7@#0g>.^Nd/U]F.MZL3-O>A9eMcN2[?)f5eVC>F92GI>MNfJHBCJ]STZHG@@
YAg5I<-0X^??98B=>(@[dcLf?T9:K,Y@SB5-Q([=/?6#^aB@SW8FGE-Z,3;7DU1a
2N#/+6XS-R#YYeAOBJI(85\9G5[0^VLUE:WF=9OR_7Pb&4CV82GWcC\N<_;Qg^,A
C_T9;6/\-ZPA;B+_M>1R^#_@O>ZQ\T?G:,1f8+-L^:PR@WCYM7^3c92/)dD/f1B_
T1N0a:@,BU#&-:M2GF:EIMda.4&bB:A(g4#cY1)3:gC#_>T(@J/dWUKV48T:eUX]
PFPcJV.Z]]ST(gY^PXVIeF<7F@.4Z_QC,1FHZ+)@1T8T&C054S9DAL(HIR<Og=F?
&<MPGQQU71GeQ\\U3&K=HMBUeUc5e&M9JgSbWT#dJf((?dDaQVXAP2cW._-Z_?7.
7aZ<<C#/H7#5,]^H^BY)?#P9K[bT5_A?]VeJf#g6J->fQ0+W8B2bOJH1\IZQcEWF
b#2[@L+C]f+d[:LH,eW12EP0P=T?>Z18A0,-+3E?^FALH[XUR=/EOH,96T1L:5;\
B;KDV)<A8dWYBJ)3L;:V/KB^VM,cefZc/X4aO3:O#W&810WY52?9)QASe@aS#HBC
KMIDR)LLaFbTY[S/T;&HHHb(G4d)O9.I(AI3ZL^L=+/\e6DR#aT:e&eIM,\4L;2d
Q03X\\9>/;Uf1dH=eUC(4(Nb5<&E2fdW3P)O+f-X<G<,TQZFa7OFBc3\e_c]K>UP
<_M-JM_8NWSZ@ae&6)<a,ES17?YNEAEYE53_Kae-<T5G6YKA&+]WDRD9XT,:9We,
>F(Qg;+YOS,F;K7,3NH[da__/2[__O/8W.Hb1eH&YY?W:dKRZ3UX6FW9\;(Fc7._
@O4g,ETDH&EB<43L60APPU_-W_L8K[WVAZ4dCba2K(0=3G<d[W5.f]E#:d-@BX[6
I;^VNK,(#0/P#)(CZ+-UfJHU,UM:0)00F/5?aV^G^;>g2R,@VMcYU[DCIUWR#0>?
6G1Eb@@dQ^S2T?>I]UXaJ<8Nb;R6gO0:-3F6bK\Q/QN+fG0#IX^D.AVe)3Ne<&IU
9_KP/[LQ\===WJN8G8LAb^U#dS2(9YgfdNADUdcV1XYRK0.bDVQDU1bO4[@M0NL,
W1@GB2QD&c0:S/O<52<IP8D0>b?Y)LEb3d6X@T1g[YT-\.=BI5.[^bF]U+PD;[)G
#C9,+Z45dP/_2dbFN^O#FV17+cf:)\]48/R]4H\97^BL6f:C4HEG:04,[K8F.4Y2
;#A&#IHXIR\PRN/BH0b=ed2DWK7/<,.EO>HB:LFTYPSDX8HDMY\E_-A407>:c.O=
(0R_?CWa,#3Df96,fGY[c@B)Df+M:;]JHDg9@[PfKZUQ13:K3,cNN.b9:+#SeQ-G
9XNPbQ?GVCQW=F:ZQ)I\8R;;/4;f_fc4(3[1LZ5<#NI((X+]#F>,A;ID/):U(F_#
12ZMAL<Jf]_BCUFG38JM/9cGPLUdC@7V<U&&V0<64bFSCe/3b\9@MeGA]CPTcK59
)7A,SCVDCDJR>94_,V4+_2W)-KAX2@NRaX?_#4&70-+CKR\,M)R/XIIBde+fNXVf
&8EdWd,KS0OdFXJCKW;#7WTH=a24@d>(6C?(TRK#-&@&@\/6KNG0>g#5&^dBRDZV
&&4FCYZ3/HU,LB-@b7#6e^4_X,a?&9J2IB.^)ZEM#M:LA7-&4.a/g<7Ld(#6C341
B(/b^?-=&B&COcS5?3+/0QeME/92QL1eV2E1-3;3LAB_JG?ef7Q.W5O-T7B8=G56
MgZ+dF7EZ#]eZA>WO?:\<\9]/;1>VEYARg\(PaA08Q@T(3b?9)CV:E/&Ne@7:<;a
YWFgU#[[=bFY;d+.^aWg_=:gb\JEQ62d;&<[7\=YDFdQcf.7RN&D2^>4&_40g/gU
1_2N;E62^UGF.PUf>fe=O.SFRBHAggXHX?5BPGeLJ0YM>&U>bH##c(EZN\85._^R
<?97ObTN,-N_S@3T(U12.\<9>MF++.d)@,8[YANHN92\EKa69JH8d8:<I)AgQWZb
[^WGEINQ?ZeEZE9VN4QbVEZCIcb,cM&-/8@K,>McZRa5_=7UcHg-^76DWM6V]_)@
G:f2R(XX;?N^X3_A^=?^<12P_(PUE_f+IV:2JbU-IFbC[<CLVPDR8K]Ga9]/EZ53
ZF[CC=#0e;#&E6I/+9KG8B2H)e6ET(g(XB?JaLeCg45>G2<2,#XO=fB8XA;<a;X7
(WTLfV9H:BJ5Y0fYa=2,aJWMF+V+K:V/1@7e]+.F0,UL5NVF.AUPY([B1#5=/;X[
B<fI&P>_+dA@bU.e8c6-Ee&3CIH?;g)USO_6c>K-AA@-&^(L;X]C7a26dKT,IH7#
;MFC[,P@NL8D-0,<XTXXddF-O:J7>]7gaRD55Ug7efD0+MQD/Fa2c#0V9Qc^JIK1
,9cP4C+5EQ_U?(2VX2D3]^S1EgW\>?\R5/J.EdY+e.8B;7EFC#.(GG7#)N/&Pg1:
N?C_-VHY(Q;QJ6d)M1f.)c[]=E0\JM-?S8@OYGdF7f=Q#X-:bVJ@QS.FNZN7YVbD
X(PIU0KEI]MAP)^aP0L?VZZH7Z,Y8>T\HNc(:+[,W+Xd3@RE64KG9CbcJON6f)4&
4@?E3X<aYfT+N]+E7cBg<&;X:,WPc@JK,bgM1)UIe[0SfH(^]ES>;QGZ;]O2Kc;.
FWe1]&BZW[T[<g&Zf\+Y02R#RWO22/GZ7<,(?A@@L23aFFWYW49,(#g?ICM^=GKO
^\H0aY5.\1c1#K+W&5Bdd0_QA+aTcG:[@DXE:9bS6D/D:WB+2YL<_SbYc3)5EEMg
_c3J;<Kc;@17G,1YJ.e58dBZS,R>9@IZFNA_f:0,T/(H+LS_>SBZ/de);b?S9;Z=
J0[:40MMUJG(^ScNIH8F)Q5:9N]6.ZJD-V0V7DBbQDK@:;#.fIJGH@4T#a4YR8MM
)]&aR?+8&a<7@S&H+D&M)40faf-?OM93H?R\8\)-X-cb^CW[g,ZHE?\PW9&cR8C)
KcK_P(=5QGDWNc1=)Q9XF]6\0QDM146;(1eXH7C;ee\aI&IAa.FHZ#E=R5-bM4PX
+PaK3X^53>F5SXU@NbBf[YD:^0,cC+[ePH@(WIQ--SG(7:g3Da=ZVI^g(:gXS\GP
d(5Y89cXJ7K^A]-/L5fZJ@fBR_cZ(Q/K:<1PVQ63XKF4C9FT2Eg3UK3N)&4:DY:O
ZEGDg)&#Cc+A&BTg+#+50RH;3QPUaf5[V\&B+D_,&+AE3d[MPV5J,bSca](5U&Y)
DJY_QR1^:cdH_2>D:I^#_1bF87B]9[FB\R>?;7+Z<?HR=(G:@gF8#<FdH_Z>dX.>
HRc&cXDOQQ09;U=X5-6O6<e8a>4F;,O=8bUfFNAbYV+B&UbRg8]9HH2T>H]Y\]GG
0cR<=W_[M-?&A(7>0;cG[I5@M-cTF\?,JPH,L3J]K#IMW4W;UF:@Ic-OAI3^(67[
\X0K<9g19[=W=E(NCADg:BDH(A1VF?6ABb>R)^gQ#VaOBJ;=;P6<,BJL#;:->aJc
J_I?NGC?Df(CGCP+bPQID-:XB1KA4#)9EHA)Q.K&\S#>\T+eMZ]=36)S;CcHd)&-
c6/D0F4[#5L+I6T_@M@R4\W80>(K/\YVG:&Z_19X3K&4=FM9>SB3)CZY0CC11?F#
FR+9/:DB9H:0G/c2fIR0cNER,\(RDJU]&CDVU7/68a;N,-2;DaZJ3I341EagbUc1
ZQ:-N2\J#=N\68Lb5]eZQF<VK/GD0OVA6VM84bTBI3?2KZ(D@J\XKQY)BT8]cYX[
V[<A/<3)J#\?HfV(?f8._W<DL4V;8b4gaW=@c3]2[5DIK\K:7cR4.=?]<>>)BYXO
O-1AVd<5ILd/X1Fa.b4g/>2eH9IBK5T>)U&=(d<12F0+4P(RbXLgASbV,,,VB_C^
KDa+8(P3?G5EYa84_U-PN\a/cQ\U/QL2MIfT\4-ba4-P\E_=@L5fZ[LKIcI;e540
B,A]9=^FbK?_CROSL0N4c9EB0VL.LA,34OBPDeF?0RgM]HNfS,Xg8_+Ia:-?aecT
C/(gD[FAK<N+>4;8X)5;XP/14ZP?g4,70F8U712^b3_.>WL6YHE-D>\.K,@Z+11Z
a_F7559W4d0VFO\#O+.-cAW@:fB;1GEM^>\dM7G.LH2(_@_;DCOW-;7\1c9X2g)b
3)-YaK^YGJ[IS<KaZ=BQe)54HBa[Z>aGU[cO.2@dJeDL=3bEdK6IVIdB;/>>M#1_
TPT1VGQF,\bA#(E?07I#JKXaE>_QOV]Ea@0Z6UG?3gQa-B>;aA;\G2K<&e6LD.>g
H,\.=f<F(J+D]Z7cfMNLZe\<&]Vd#W:58&VFN?PU+-E<G6GPXA]T(g#(d09fce-a
N)JEN;6/Dg5\1];77B1)L]Hd=@@+++.fW)74G8fReFa3=ZHI2ba8ea\H:,R(3\.]
J6?(O7V[8)VL+0M1U9M\&F.91KZ:0g7^T^gH_)YSJO)9SBfZ7#QDMY\W_ec<B7WB
b(Rc5,B7]:_)bB=_S((_+IY/(f6G]d)U;V@\C5&Y3TF7VdXNJP^e]W_0;A\TZ4=#
K5Y-3AJ;<;H5b]Vg)_M@/G+AFD?Ff+GXe#[QdR9[3M,5B.5#G+fDU10\aEa^.(LE
P+YbN=GCP.LNLg:7_]bGDF8>J<8a?U\);.gU.d)9DT#P:V,b+0?_M^&A1]c^da;=
S(,OJLR9DQUCYf@&@K>fe7A1^f7AH]]F&),a\Y]CV(Cd6[:SPe;?a6\[T/M1PK9]
\cfK#e<8<TgS@09S\aY6;5g:c#2E7Q=b4)=7_#=80ADb>VCEX^CK=IOa(c(EYa)M
1N\UK56DF^TgI.1HWf)5>fd,9.[&A7:WA-8edZ@CeG:\4dYF0(3.#<G(LWK4>/gc
FK(EE)Z3;3aJF@0fIHHNS\,YILURN8/=G/X?5D[XY3b+LOJNF_gSP7PdDY9#O/f_
bJX9P?.+GD=CW[9OPe,N0eUGM3A?dZ_5&,,BW4^2?d9R/Z78F1ZY0Wd=)YEX=8L6
^Yac)E)LT)fV\E,,Y^-PV64IfaMD1dXCc&Q_(/.E2,2;6@WE;TI03-\66W:X(/+X
^JRFB@+f2>HYB_4G&WQYSS=NELCNNY[>W#(I0?)3EOI/GRVJ[B=,;AD\JHQV99^F
;9YMIDf@N?:V9R<YRPG5BV>UdN@;FK6cM#Q)f#0e>SN+&W&H9dM2GRKFSY:.HE^G
XgOcF2;5BZ-O.(ERa/QG./2ZFa:+H4.@=g&>PV25UWCeRd1M(gBf16IF/Y9cY36d
7CD^FJc@D2CV@Ad6C,F5Y2_<<\REPQNCSO>^0A<,MdeE#d)FB>/C#33ZI4^22BKc
:6a)O>e691G/./-LFaR;LH9(ISFP@^b,Y0D6AG=7&;R<ZUUZF(=bB/cM;_9W^b>E
&44d4AKfLYCD=Ya7U:PH[=Scb55Q?2b.7FRCDRH>UN&,<QBd[aM0E-J.97cY5;f6
&7Q&f8a?D,NT4^\5ef5HC-+W8:B-c&:MFM+=<,2G4>/_#T[[M4RaX1fa>MFYa0&F
(7IDgQCFY5WU?_)g+P]d.;6O&G;_dD[c&]EU-A5]V:&aSL;JRU:]U&DS6:c<4GT0
1V0E?b&b4ZMF/]>5,5UO/W-:,Bf0Id8=^:H3&^ZA8?-_B),ZJ-&a?4M5QOMS+C,X
H?U+;&S]D_:bIG#^NZMB/\PN(8G#OON0:b>6PJ;Y?/P8J3;PFU.;O9(FJBI9)1CM
-V\0a6C.#gPeI=cT;S2gM?;E>D57HJ7#;YO6DP+I1YY])-Y&KY<OU5ZYa@6TFF2N
3Z]C6+68K]c+UN>g+>^5@]<^5U+@9McXO[^;db,+\6>C&H7FfI@MAd8<@=O4?[.b
:b@+>)I]0.W>=eN+9S/QFS_c[Sf#=5XT+WGL,O7728S/3JFXX+1&gZ5E2UOeS>N6
5-+P=?5Ya:e&-1G2-.VJZPFZOVaA?KBJ<@V<NDT,+ZEEZ[SKW/WKTfeeQ\\P4/>T
G+FKCF@OeO<10N5ITDD^?XX>]d[P9f(fY(66-eZa1S60Y8NU1)-TD[aWD^b:#IS&
I4?a?>5gN^\(]@:G.FA=LNe]E#X9(5<9Eb-e)6[&\3Q,5ANM\.J,2]<)XcCbC?<T
\H-d(f<10&>9d@aB7a/a.8XD/H-SF(>.;\e;Y,bYJR)(\c#&9+a]#?9?[f&PUCaZ
P-COc/9JKI:4O<R[XP3TW680#5,H8g/a3Y=aJ]3PUc69VP2?K\U.66:EWg4[9dc?
-J87c:5.a22JGL<,ELVXD]=3Zd/@>>1c/OO4UG1Z]\+2GU\Qb5-?NZH#JYPDX4^O
-11HeHFGeWU77C-UDL@^aC]Q#\8eE</T[->C4>>?TeRN?DEZ.d\ZB>[aTfEW3#D5
\:<@O=e#=XG+4G4=HKgFCH]U^3(-K_./9VB&?I5<&d:FQFFNVB3]a,62_J/(-]DC
V(SFM,<_MV7PI7Na(XE7RTIe-(EU#-.955M@2ZYY0K^f.5VX]c]Z&f<L+aE5:bN[
>_>AKLdTC;\N#@S,QVPW_aV&?5<BNP:9L6af?@HQ<]ZQAc)@(TPXS].U:[?>=SJF
R1AJL#=I8Z1UJ?OF?Me@J&LH7AR7<,9=F(6Yf-=b>9K)0-\LX8Ua41<5;Y(BFJBd
)d#T&GJFUP#M/MB1XA2\BW+RV295P?R(9X6a1GbPb>3Q3DOEE(-VZ^?QK.\cJZ4M
&_R6OUVVC;a<C/F:Q5.S&FbW&WAAYQ?,:3&+6aaBA0CM/:WD(9L>+ZEF;dY;fdY>
OR]^dcd814ZYVT07Sg?1A0)gaC\R>a/+N25?K:(,M)@H28RMZ:U/Af)3?ZcIJX77
^ULa>8eY^ND<-FYH(<6;O,:MEGPN,<?+L6491.VU(1XUZ]_,;2R?PW0XLF4fPJ=C
bS4?FbU1PDA,P]d3N]9A9E5QPNT[IA^b3BL9<P6JR9b:>TU+TLgaZYeI75+Ce:9Q
JTG.4PgILJUY<CE&A[=;:HW==.4MX1&Y_7(E]73HPLBRf)gb^)O_BP79\5F6_TPI
_0IQ3?3a_Nf2U4(DF2]BAA^+O8&Z\;_6,_LW&I:X;FP:@@X.IL8WN;<PDAWQOFJ@
M6+9JRWS>QC_FB84XR5c5Uf/2Q<UR4>>VRg8),\?ZSKV553aLID^Oa()T;.,W28e
LLU2(g3GeY7Ib(gBaZee,MK77b;8.2@ZF.XMJ/B4Mf/XYZeNQN6#/bC3[OK)QMJO
_>R^ZX;;^WTX=dC:8d5<;5WERSB/<2BTYEZSG5;D&0)I.W\.K/<ZN>2D-YOc#\)+
080e@GgJLQ_-(IFZ]L&A,J)egZQ].7Oa?-/b.YLa?(Z&.4([J/C?Z#O;S8K=F#4?
/1X7SR,R,6P3C+@&&7^#1OXZU^[FR)YA48L[5_#1d/B8gWJ^^+21(XSgH>0CSeK/
6J-RG)O9MfS+#f+,T>))J)VcPGT>:^eCZ1G38(>U@DRK2D7I+RZ;=)MH03C(NS@f
g05Sf/87+a0^3ICC/W6f5+Fg@EaN9[Z&+1?AbcCM)LD-d,HH1P///T+20ODB;Qa^
NDbc-YM8Qg-]&3gRGB(-b2[EXAVB,Z2UK:K@gOdE^6K^_CF3)^X>DBcV(#^VT]Q.
T<946)EZ/I:C-4=g41d4(7W<?W1R]?g=F,G,<d25,B0eF^?OTG=fPU,YX?;Y,eWb
3Z(fW+Dg2MD1ZPHQ]C_(7_\^?cK;>:^XFFU6N]^&-[<,P8Y0Q1Q@K1=6b<-[&.B&
,]_^CRJ7,C:AJF\]a,X-@dY#_J@d9;cG2X<Ge;KH;6YYc9I&SI9IA<Pf/J8&IJ4G
4J?ef.]FP7eLaX.E7f>JZ[7MdLI?Q.)&((:1&N3>4K?O:43PaS=O_F-d-VG-(Ag[
<^]2,WQ(+D2T<TIHMXW6U_PA7=M4D/6NX@H_dR0@05ce&Pcd:6F;TS]>S#SWRETM
9@ART#d1a\agQ1eb2?NEAZ\^+N+XB9\HGXa70UMe;./:ad05GCH,EFG0[]VXT89_
FdM/e8^:<d07+A-AIRY:B1#K(_.,#NA:e3ZCIX\geR=W7#fVO\bWRBbc2@>T2[&=
0ac_b-H@WAE)Y,Ye0Jff<9;G[g5Qd?dFN:.+-H@Ng[KATWD6GI8>POWgXaN43O9<
0WRXT<59L[J\AP[2_8?LILcS;Ig:Z8<U^CU(_MFdMFF+F0F0FUCDdbT?fN[3^-?8
L.(F6VT,4L7ZPWI]2Se9A,Cfbg=.AVa8])]e^Oe@6&M?ST/4)0R)EP/(O#)^Ye1;
a9ARSb=Y@B5f@5?K:.N9JV5[:B-AY7F]\e>O<Rdf36>aNCV]561N8O[WCeQU/LWX
RXd??OM0KXGR&gE>g_8WfC>cR-I0Xa/b8.AHRC?U?IK]Ia4&XT96\L4\U=4XE<63
57XB@-.bA5f)?CD[\.-2OWeA02//e#&/@>c6D+,H:H(=4+ZFIaOY[[;5fUY;JI,?
7M(\1:9J)b[^\b&DNfBKUK\B0D.,4>c(H0IHDb#FTG0Z:bS=M9@g,#@^,KbQ:_=_
TC-2gU+@N^^E2(6g_&daEYJLLc#MI-QD_+WYJ[68O4[2)E(RLFWLeADcb>[YC^V.
>W2)_Y)-97(8_4:570d-BW.-5]B.+IH]fg7MS7PJ(a)X[NW]+&1SFALbP25P0IWf
97=M=KfRW-,[Q.;Wb_dBIXFXJaa0<g,J;(\KadI\9K.YXGMMW(<]eLNdYf:Gg)JW
-Zccc\^J9;(]aY?C;DR,HLaCd^1/9&RQ]Fgf<T..XJ=H(FHVEMSCR5:@9RY[f,V.
eZP<,ZLfGPc=d=GO-JPg9WQCLQ[2aOVZIF;TAD07gKcG\9^?6HR:+O<)YE6_U3?F
c2\+D6B,Pe6eHBR_VWge\(g<6W;1O0HD#G]EaSCe2_/b0X&O1F?)JX&00QY>+.Y#
Dg_^I7WJWgCX=LXXE_2\6F.Q.6&:,YNV;cf6SPG2H85F[;fId8#dI=XAR,BN^Y?H
;/H?4cIJ7YS@QQd+1WM3E+f8Y]QI#RL_]2YS&CWB7AAKaH;LfV,R0L/@VRfL<fUM
-8BS2<3HW;GDb[O7NbH2H-]@YLYe?]a3ccQg,.@)Bb7-F]&2?E5]3gH\]:^,LB@e
G+Q_-,)QdLf?N:eBSB3Pe]8af2XO57WJO):;cgg9U0NFFWMC7KT,1^c\/3AD8?9Z
^Q\Q#ge_E173]bJOKfZ>c^LP[CEZ)4(OS8P+SD2XMC2U;9M[ORZ7.M-?<N]/[Ja[
]g3dC[=^X_-W,^NEK(A\-0d[AT5]G)-/5W>4H^LM0^20.(H_a6XY2C-3GVI\.[a&
bLRKFNTbJfUdX0\@YT58S>d2FU0-=0Y3@?0ZHX<[/D_Tb4<0OVMC^gNXfFXNHD]b
3A/dL?JO0P.gg8#UMbL1P[4&O)BO^UTdNSJ.eBUPH/cEdg5=c)MIDN^Y=N2bC1R2
?&&72Y<O,\I62ZgTUCbY:,\1Yc6<FJcY52fF8^,)7CXIRXAN&NX.JYD7;-1RW4:I
Fd,@8a[Nb#aW;_T)d)6GA?7U8LP_;Z&8)_U^cIP0D2gIgO-J)N1\03SZ:8b@IL##
cQEcJdQS)BVCTV5@YbZCH7d(9I@B7US\Z=DH\G^>W8N@@E+E[DG;G[a[ZfQ>1+^Z
b]Z7)F3@PHXP84L^QT5^\R1XOEd8)(=UaGZM_5BU66;HI@Mead]<#bDKH0[eaQZ+
>2INPSa]S-T3/daXN@eU(Q8LDWWJGFP]@BE.C@\6;KAaP-bD53Eg8b1Og)\=#18-
eWf+LV-63FWHIK]VS;.ET.0YC)fEbcff-15VUG(:<#faP\/1GHC1cAK>S#[IF72=
D;84C=cOC.T4]0Z?^MF=0+MPc9\,I_)F>6XfeHcS+^_g(-0\Pa:,&?0]g[0&)Z2;
YV@0QTL,?SYC3OO&:WdLNM;cBS;0/Z#fKe[eHFEgFTXW^EI-O@F_-<ONU@^T8.0#
H)-c1B#]RR/Y797+:]^e/,g03BO^&P?:H/8S3T+7dA@]4K2#W):a2R/>T^2e[>FR
dK]dFK5gC2UUd=?6H+R]JgNcD=d=1d8A0H+2>.G3K.ceX4HP@PMe6][UWa)0H\>e
V3]3:_AfCAGU0$
`endprotected


`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















