//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SVC_ERR_CHECK_STATS_SV
`define GUARD_SVT_SVC_ERR_CHECK_STATS_SV

// =============================================================================
/**
 * Error Check Statistics Class extension for SVC interface 
 */
class svt_svc_err_check_stats extends svt_err_check_stats;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Handle to associated svc_msg_mgr */
  svt_svc_message_manager svc_msg_mgr;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_svc_err_check_stats)
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_err_check_stats instance, passing the appropriate
   *             argument values to the svt_data parent class.
   *
   * @param suite_name Passed in by transactor, to identify the model suite.
   *
   * @param check_id_str Unique string identifier.
   *
   * @param group The group to which the check belongs.
   *
   * @param sub_group The sub-group to which the check belongs.
   *
   * @param description Text description of the check.
   *
   * @param reference (Optional) Text to reference protocol spec requirement
   *        associated with the check.
   *
   * @param default_fail_effect (Optional: Default = ERROR) Sets the default handling
   *        of a failed check.
   *
   * @param filter_after_count (Optional) Sets the number of fails before automatic
   *        filtering is applied.
   *
   * @param is_enabled (Optional) The default enabled setting for the check.
   */
  extern function new(string suite_name="", string check_id_str="",
                      string group="", string sub_group="", string description="",
                      string reference = "", svt_err_check_stats::fail_effect_enum default_fail_effect = svt_err_check_stats::ERROR,
                      int filter_after_count = 0, 
                      bit is_enabled = 1);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_svc_err_check_stats)
  `svt_data_member_end(svt_svc_err_check_stats)

  // ---------------------------------------------------------------------------
  /** Returns a string giving the name of the class. */
  extern virtual function string get_class_name();

  // ---------------------------------------------------------------------------
  /**
   * Registers a PASSED check with this class. As long as the pass has not been
   * filtered, this method produces log output with information about the check,
   * and the fact that it has PASSED.
   *
   * @param override_pass_effect (Optional: Default=DEFAULT) Allows the pass
   *                             to be overridden for this particular pass.
   *                             Most values correspond to the corresponding message
   *                             levels. The exceptions are
   *                             - IGNORE - No message is generated.
   *                             - EXPECTED - The message is generated as verbose.
   *                             .    
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_pass(svt_err_check_stats::fail_effect_enum override_pass_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Registers a FAILED check with this class.  As long as the failure has not 
   * been filtered, this method produces log output with information about the 
   * check, and the fact that it has FAILED, along with a message (if specified).
   *
   * @param message               (Optional) Additional output that will be 
   *                              printed along with the basic failure message.
   *
   * @param override_fail_effect  (Optional: Default=DEFAULT) Allows the failure
   *                              to be overridden for this particular failure.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_fail(string message = "", 
                                             svt_err_check_stats::fail_effect_enum override_fail_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  // ---------------------------------------------------------------------------
  
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
?E6JCQYDT0<@gS&6XTeg82U\[:B#+^B3_J1eb1,4Q,7==X3Ug8&g1(?@Jg+<Ef3)
0VJJReP4@M(MJ8]V;[).9e2^OE1O>2Y[(f20#a0+742X/Mf=HI5G4Nc)44^Z@Saa
>;_Vf2[O>=,F4^cCLgN8/K\+Z\Q/DUgP_dJ\QK#5DL\HQC#5@d8UT6?_a>X0g/1@
<DF>V-9XbAeU4e#DfIHN(g5N_R-3IN#[S,_D5cY4;#TU(Cf)]U@bB6+PR>YOc6JH
DeP=>R]K[;d>DTK1VXBG#]f3P3+RB[DTATQ3B^&[E.QX5;>Kb0<&YRPBHa4IKFOY
VE@T]beRZ7(;\G,POLL<\N(3SE^2fB2dP()D;V6:,[V>D.M(WMUW;1[XF@IW4(:7
<C:T7?D\>dK6O&3,\BSBcED(L9ZVB3G>&M:?S0B\c<#VGdA3_CIJMR&0W0I8VJ_U
R/Y?/\<[GHME=PIWbW6Z7A?3-78D^>#M_>GS2G5OeIfYdDIN=7R^VE<HEJD>:;+:
)7eH&Yf^TJ3_/:4&>XQ8(+?d11EM[_\6eH0T1KG8];Ad3Ag;JOQc6PP:X[1A^:E4
:J\^C^#Z&D-HG1<CEdHe)T_J-(7Fg.2#/aeE\(XP:Te;T??/#0>gSR7<N=G&SP11
B.R^QRC+)GKG3WTWV=;4VBa].D);[Z#M78(DRE=>g,bPLA[^271T<5aP45C:;84M
&U2LJ/0+5=&4E/b=eXEH.JRT97?<)]bKfOR(90PU<0b)]9[5(?e3/_8/#MO7Ib8@
KAXT_.X1#<.YH;/b>C7KcZcQ3SY1QZ>W.cL>WQBRc;E3EgH1=M:g:,9d(QVEE^/(
.H&ZW,?L3)^BZbec]bXI+WbQ+I7LMK5KV<aVd-,WU8La[\<e+>:8]D_QVe==\]9Q
MS7&\RT[8b:[OR?;4\SgY;<5a]99UJ#T>SHP1A^_(MG84KUI]B99@W:J@/C;-5[H
AgS0M-DcU;;H1P7:#M_QG0&+c2>K2CFKLK?dY)Z[DWR)@O1/HZKQUTYR>\SX.0,X
IIYT_D0V+/3]bUd\G3GNVW&XA#]2^N+5NADG:.OI[A,Q;#DMY6..(#^Ga/dMf.8Q
4dDRXGe-S/1)=##;,dDCZGCWSbS8#&<Y@7FZH_9IWAG6:A:9J/3f@W6=D_O>TID,
4G.,c:9XL5cSA..Ta;@48Ag+Y>-a7NEA=bMdY1F&7:?eBPO=[]E5T#:0:OWZRFMU
7(:b:&#NUf+(1YJ@VDf<<HB>Y[[YQ,,#6MSOTd8d(4?RBKL^,?,XHF)Ee^&XXJQ2
#X6[O21;KeQ]?S/gHK]Le4)(.(=6DBNQ5JB(c^A5,\P=7M0c9]PS]b7<L,6^LAR9
JcHJbabU;)]0UbbE5<(A9Y[8[Q(G7-dSNC^X[+F0afJ3D23=aEMSMI9SV-5@_U=H
1.[]Vb#c([X8-X=c/feH,;/f<>Ta-+bb;B:e=N&A97#[B/]a_8L@.GPS3+PLdQA@
J+5eC26>\T3bR4dg86J4Y2EIcQ@7-d:M4MJX9V+.Y.T6bOF)4FUBbaTO81JEcURa
gBd-UVDJW;<<KS5,c@,3.O)^)F34<:IYb1]5BFD;/7X^Z\a?VCba,8#Ld<?E0/9W
.SU7Q:cP488,;<^6DG>T5EdX=O-,CSP>2]9_O&EU=NQ#6)ACa/#H]:]E(M[g>E<e
#5\E2A<@./dOLf/25C@7.YCT0HMQc8G@K20eIeL=R(A>W2PAedVPE+DSd;BCH_D]
5fag)/<a[70^g/=YXNc:MSf&E<=BVY/(1c5ZRK<d#e+8eLdT)g8F(KK#gd/8g)<8
S<gQO,MG-3Y[=_fd;4]4b0DJKVB5RDEED_f;,.+(DZ3GB<@/\7(3#SF7S?(WN#R+
QOc+;be(^LAQ<F<Y8;#XL8:9Z/bIM]];35U/>_S4XHV]C,V#:D?/1?e4^MC>c#1L
@RXDgRNe5.=6AQF4\H3ZY?;2TTgVLLJ7RU>c&=]=,@93&LEL+IR>+B,[90a]03X?
@^#O1\e4TgW.Q;?&UfHE]1;)L+5Ig&Gg[):;E<W[1B#4MRUBa\>Y&R\LGCS@_<9A
b4/@41:ISeF[gQ6@g.6ISg<E_IfaS2#_QM8+;e0?<^G5^R8M2)KOZ&0;KN&U9&XO
^?<#[K.cS_)a0\E[?@GM(U(2ZK2N.)6-dfR194&#^,MIR1Fag[TY74/(DF;eM:F9
)WWKEEP^R?[=OPbW<,1Q4TdU[)Ta_Z1GB]?cXS\Y9=X:_1NN(Y4(]@0.DDHcFN#E
7J.>I#=83M5&E>7DJ[#;5eLJ/=\,)?=ZS1#9g+56:5GVTP1E^=S=_ZY38XT90/MC
:=7dcZWbZQ/=_S0A^4UIN8+=+4;QLHR)MMJEGJS?SC88g3/<3>>>^U5c5d&,<P)[
<RHB&X0C+YI&I\39[SV/<CXM1C_QLFg5B5MdgZD7-cg]J#^EDNU.52O8@IB/OOZf
3MNFK><8)+14B]HXW2:ag@ZSTAQcE[VO[-b22^X\&,d@KV>Q)[AbYZ\[e\L7e-eT
]8d//H]3HSN(RO7E@Q88V=)+64/(I>DD),b7[E=>f<J,,1P77ag39(MBT/IESW<V
ZAKC5=U8RSb(0#WV>(UM=f)7T72;#_A_Z96KK00O>=NaI&:2JOKd5\A&QaJA-f;)
:d)RQ1:(@Re;.^S2Z-a#gVJf83W[afAf\YM[Od6[QNF=9FM:\EabEKg&W\cNUPNJ
Q0D_cY4_Pa^=H_fVNfd3\AR,KgecO=U-YKd[WU>:aUbdMcLM=&(-ad4ZfJ:#H(_,
Z?/c)_[L3HHQJMc23F:<_^NX]5+YU&cW&&1C[B-O[#G\#+g&SK055[>NF7g0@EXI
=X:&6gd.cBW(_2&b5JZ,&V62-_@]MLg]-8B@AV)Y,@+<(=M579FISD_KYM&5<K[I
@6CSL;4^=R-.(;J)QgA;\#4^]0O6Z#YAH-7TaT7Z>VBBP546C(5;(6S&c.B1&1Ld
91aWA3Q+1HUE0Y,adf/HPcbC1GL=Q.1SdBVa1)8N3WC)-YUX:+B_+_/4KOFM[b[-
Q??c+]Y9a?52fV8B_/2T@BbC5$
`endprotected


`endif // GUARD_SVT_SVC_ERR_CHECK_STATS_SV


