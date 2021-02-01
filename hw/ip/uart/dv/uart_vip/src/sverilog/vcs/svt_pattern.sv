//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_SV
`define GUARD_SVT_PATTERN_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object for describing patterns as name/value pairs along with
 * match characteristics. In addition to the name/value information this includes
 *  - match_min and match_max
 *    - Used to define whether the match should repeat
 *    - Typical matches:
 *      - If match_min == 1 and match_max == 1 then the match must occur once and
 *        only once
 *      - If match_min == 0 and match == n for some positive n then the match
 *        is expected to occur for "up to n" contiguous instances.
 *      .
 *    .
 *  - positive_match (pattern_data)
 *    - Stored with each name/value pair this indicates whether the individual
 *      name/value pair defines a match or mismatch request.
 *    .
 *  - positive_match (pattern)
 *    - Stored with the pattern, indicating whether the overall pattern defines
 *      a match or mismatch request.
 *    .
 *  - gap_pattern
 *    - Patterns can sometimes need to describe non-contiguous sequences. In
 *      these situations the non-contiguous nature of the match must be
 *      described by defining the gaps between the desired match elements.
 *      Each gap is itself stored as a pattern, but with the gap_pattern flag
 *      set. When set to true the pattern is used to do the match, but is not
 *      stored in the match results.
 *    .
 *  .
 */
class svt_pattern;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Pattern contents, consisting of multiple name/value pairs, stored as a svt_pattern_data. */
  svt_pattern_data contents[$];

  /** The minimum number of times this pattern must match. */
  int match_min = 1;

  /** The maximum number of times this pattern must match. */
  int match_max = 1;

  /** Indicates whether this is part of the basic pattern or part of a gap within the pattern. */
  bit gap_pattern = 0;

  /**
   * Indicates whether the pattern should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /**
   * Flag that indicates that the pattern values have been populated.
   */
  bit populated = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern class.
   *
   * @param gap_pattern Indicates if this is part of the pattern or a gap within the pattern.
   *
   * @param match_min The minimum number of times this pattern must match.
   *
   * @param match_max The maximum number of times this pattern must match.
   *
   * @param positive_match Indicates whether entire pattern match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern function new(bit gap_pattern = 0, int match_min = 1, int match_max = 1, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Displays the contents of the object to a string. Each line of the
   * generated output is preceded by <i>prefix</i>.
   *
   * @param prefix String which specifies a prefix to put at the beginning of
   * each line of output.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of same type.
   *
   * @return Returns a newly allocated svt_pattern instance.
   */
  extern virtual function svt_pattern allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern copy(svt_pattern to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   * 
   * @param typ Type portion of the new name/value pair.
   * 
   * @param owner Class name where the property is defined
   * 
   * @param display_control Controls whether the property should be displayed
   * in all RELEVANT display situations, or if it should only be displayed
   * in COMPLETE display situations.
   * 
   * @param display_how Controls whether this pattern is displayed, and if so
   * whether it should be displayed via reference or deep display.
   * 
   * @param ownership_how Indicates what type of relationship exists between this
   * object and the containing object, and therefore how the various operations
   * should function relative to this contained object.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                        string owner = "", svt_pattern_data::display_control_enum display_control = svt_pattern_data::REL_DISP,
                                        svt_pattern_data::how_enum display_how = svt_pattern_data::REF, svt_pattern_data::how_enum ownership_how = svt_pattern_data::DEEP);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bit name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_bit_prop(string name, bit value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bitvec name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param field_width Field bit width used by common data class operations. 0 indicates "not set".
   */
  extern virtual function void add_bitvec_prop(string name, bit [1023:0] value, int unsigned field_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an int name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_int_prop(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a real name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_real_prop(string name, real value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a string name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_string_prop(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern specifically for adding information about display
   * properties.
   *
   * @param name Name portion of the new attribute.
   * @param title Title portion of the attribute.
   * @param width Witdh of the attribute.
   *
   * @param alignment Type portion of the new name/value pair.
   */
  extern virtual function void add_disp_prop(string name, string title, int width, 
                                             svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                             svt_pattern_data::align_enum alignment = svt_pattern_data::LEFT);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy(svt_pattern src_pttrn, string name);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern,
   * but with a new value.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   * @param value Value to be placed in the property data.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy_w_value(svt_pattern src_pttrn, string name, bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method provided to simplify trimming a pattern down based on a
   * specific keyword.
   *
   * @param keyword The keyword to look for.
   * @param keyword_match Indicates whether the elements left in the pattern
   * should be those that match (1) or do not match (0) the keyword.
   */
  extern virtual function void keyword_filter(string keyword, bit keyword_match);

  // ---------------------------------------------------------------------------
  /**
   * Finds the indicated pattern data.
   *
   * @param name Name attribute of the pattern data element to find.
   *
   * @return Requested pattern data instance.
   */
  extern virtual function svt_pattern_data find_pattern_data(string name);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The real value.
   */
  extern virtual function void set_real_val(string name, int array_ix = 0, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The string value.
   */
  extern virtual function void set_string_val(string name, int array_ix = 0, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(string name, int array_ix = 0, bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
N2bL&:Z>d\L6JN9>dF_9;cb2>:fQ,POfL;QFF9H79=TPZK)KE3442(]>@f<6Q76/
,AD>_G4WTF-_b2<R/Tf^;5.W;S6=&@[WG-.FBFN709X+ZU@<LGXA#aP7GdG#R^^4
#G/-eWfI\;=Z<d#-VDW-[/1V#+1ZFZdI.PNRE@F<;BOWQK7QSKV/=#BM&<#^<6;F
dfeB>Je&(+KedgJ1SA2,FWeRa7M]?IJ?TE?KHb]<?;3@?J@Zf9dEa40VRJe.7fOc
5eJQ]D9TIQ;-WM)O&(JO3(T\DRB^JPOeHA2\ZKUgf?DMf&+=>L>FWNY6adMZS]RY
4W9RQ-H^/Y@2CR2/TSe,VG;?UeQ?d]=CI^cXGB[(C.CgUXK2b55?SM89>E4W]X_#
D7SY20PPG>9_LdDgZ+Rd1UEFg&4Pg2:C6^_f,R0aW(K[2eE/,8L7aeg62[9GC64e
PG7MH1-3K&U[BW:YX#V3ZV3DM=cQ/eDY0TA=[.HS<4^NVN;9@b2[>5O5d#N&DKe>
>[0^c\6PfLQQ=4JJ<I2=IBN2b&[g7BeBPd]A6.:aC0>_aH82_#^(6)PY+1?,@0Ub
bSb&DN/G.PC_=_VB?>&M2KE//90XH.,c(FCfHeT<TgV7IZ(L>aNbHRT=IV,7b/JB
#=;75MRIQMed^^KbC/7g6)f;ROVTO2Q/MbV5[=?VN(eaVNK&R@4W),dY\9TW>IWc
6_P;DKY^MZdC+E@^SQ46S,/7\/I-;2YBFC+>IEPaVeYN5EQD=A-M9CCQL#,6-)KJ
Hg&P_M:[;:+IB\H(+FL>T0dTG\[fM[-BHFQ9,A1Q>E_T]OZB:H_(JE]eMF0H_6E1
F.3F^aSgYF-[Z^?J\&O^E6G19PI5,)<>,[dCX(1d5>2Y9FOUG^dfB(<=UF?J.5#)
3-U)2FS\-=U/FUQ+;d,QE&3M,1;N&?9;643=GaY6FGBVM6SM@FMYVI73d^C4DZN=
Y5S&d7(ffB86RM]NE8(X;L.\+:OX>]JTW:JL(GcbMK^4X0#[##+OH4:#+^?^XP=N
;?)Z_>FVW3X(&0EZgH(0+T[>7WH).bLbV#1e[3#B>9(LLE4+ZNeUR+2/?e0^R^eS
?V#[)C?WI]c/B1,OSaC:-5_<a.T-E3=>4aDRfZ3Tc/<WS1[/P^,25&;8GU_(6Y<X
PJ7M,A>K3\3:^P;@&1P;:ONV6Y;>Nc4,.)a2FE3\[J8LH\d/+0Dc_3Zf?f?+-<Q>
bY2Q&R=G&[EYR:\fG(;dINg5(]b-L]Z9ODY:N<MZW>T;H15)I/60I(W@=/9bGLHg
G-O<=G4:0]JW_7]]SQC29S)O_?gd38##A((6MT2dJQ@9E8f=S_2D?SF+&D\_T.Hg
XF43M1+L/=-^&8E3+&7G38S&(#V[O&9[@&1.K3BeJ]Z+-Q..-:Ud-2:cB02Qa\)S
B:H85HU&O>dYW[\bf?D.H8IgW>fY7)c4Y+QKaEYG=>>gYQ,<aZ]B0V\VF&Z_.([e
a@&\+<86>/)=e/6+,DcgGOD4AZ/Q2[WM86:SDHeZ3M15d=M<]@VbVdDf^DYZAIBd
8PP0[^99[9P:HR5H\T&RQ=<\dU:;^6I7G5SL@^Rc__C(__(FFZ6[([WWQKcXG=aI
RPSg_/f.bNRS?XBa+19M_/QVefB+g+^MW+QYWA)^2>EV+]26#?1ATP)gg,_a0^0(
^?-MUMNF_;Ne7e/;99=:aBT2f_Zc<gGLH>R,Z,#HYI\\S6<DM2?80B/W?ORVUGWF
.QEd.H#&>H7&N2OA,@_4-CEfUJg^]+\[>(YH;)+(Y+I&Ff9?KV@\@dTN/)ZMa>4A
7]G9K79-fAPPU=UQf)-ZOQOL8f+(H7Z0aNBUME?Y_a+e80H:+3MLC3FEabR?=&HF
R,c33YUUW?G+VYP0]Z2<LV1fWX8E>Ub))>.)P4SCG.WI3-#a.:?X?5J?3UU\=[90
RPTA-FfgP4^NJUb>-FBVCX#\MgAO\I6T/AH_)[gNNU=5@cKMDL#&P,3P8g1[(cMB
P7^0Mb22KUE.]@@-c-BLJV23C=OVPc8YKJ#KOW@UL5,YXQ\I(^2<FBRDD;P:ZC?_
>dZb[2KMO]e4DLM0F0cWKZD1>DH]>F\gY6TFXAT.UUL-<:?V=2X2c7CA1VX3]H5#
GgaD84F@bUYWZNE[VO7KJBH>#+;[JX3QS)WXNA7/,@J-+FZe>HXd>Q6O]aU#Q)LT
7CCYJYY,K5f96B:K\;[(DPgFZLFP=4<aOC:eIZYb8,_MVGd5C&^.&cJTMNe?b6]C
--G\]0WZ+<Q27YX.3(7#CZLIPc@>9Vd7>01<aW+L+&V6I<Z,P@M&;a=@K^PLT86I
OZRXbRCK]dHR_BD)JW/B8D^bP&372=7JG/=BLJGZ=(0QR9>&4;/W)G)<NG6T9P3R
M&QeT\/E:I)f[W5T4b#J_X0d,<cH<7&C<D_QM-2<54XB3#(9CU_B4,;+J.^DS=b2
1@BLS.f.=AgC3^TEK1(,WM/;YIZ)b\-QW)H;X1YL8#YI(^5:_&E\9&f9:1GJCUAc
EdT-3KPV8P3)^EOHW.K<IN\(^[_I9-6g2T;/JRXY@O0db:N+GATc>3P=NIX=U)L/
U7I>(#Q;IJRIgFX.T3#=D4-=bF_<a=a:-?2UT6TQ4<&G5/3?E<M(3e_bE<74K+Ae
d.\GKQJ#P8b)+bCL/@eJ#\^Tf+7eH@KH#1K<?5.EOGU=e(+MZ&]D1[DB>E,=V&)_
GNBY,CZ6.RIT09N@>#KS37&K<&fV,c:ced#W:d<<g-6059[f4cgIbI&RLP\VQ&PT
Ug7Zaa\[Y0<FR/^8UHP7@f\;AAc32Y0@7P#[IHTBbVA\1NZBP0<N?(@<\)9)EGW&
;;KQW4M7?+K(GNB@JRd7=6Jg:Y@(b3\X9-GT)g1+N]Bg_+LHH7V\g6g)e&aQb-^F
MI(BXI(CPf]H]FF&.^)\P8)AK;4O/^[EeNcIeL>?>a,Z#Q06JZ__5U?NW)&A:<aW
UKGNL0e+9<:\Ed[@=99\H=E::Ya<Ja41]ZEI:d.XQTa)+/H,JK1a5c9GBaN1>IG+
:#[NDc7T2BPU5D3f#NaV=0<OQYGFa3^>OfUV)e.dG;\7SaaS5RI8)ME;#\00XT>-
D,EAAfRJ\?L8PU_aQ_M8Qd.T6bCb@=G4M7_&#0T>8-PT3]P59gaZaAX)Vg#-KLM^
adcIWI;,eTVR7@>15]@7/eHXe:LV2#-A-K/I10_S:V3\V)<-eNKb:1ZWa>U^W@F;
cB4XXL=>R6b1FFCP]IZ02B));=@5\SQH?K;dLQ\dB/T1a1S7<-RWZ]P-V)\RU(J?
d\I[Y6(X(Cb5N(f[/dL>P#<GSNf[2:b:#L+Z4_EJeN]eO57ZcU@=-(24g3Fd1^5:
:K_1[NI3B\+8]3?2OSY2YENS]RX7Id06bD3EG3PX\a6f5gfB5<=.[)@VRb;;A,OJ
7;d=G[YTQc@cKE.Z\N2^0CWMZ1c:dK@Y^Ma-^FE_XD@L<N<PCcc8?ZeGPd>-/O@]
U;K)<IcV;cYPV7ET>^4BP.6c@P<_C\0K)/BFO=c]V(2&4UP&AUZ[K.FK/V@7#7#c
,9#eAZZ2>IK7WL+@&@+J]Z)_Z@J9JQ[P5PZf,6N#EUW.,:ceWf>b.9eTK1SQWZe-
BQ&WCbGcg9RLa+IeD/+N-f:_=?Hc/#TL<F(bI=T77[Y#V+e_)G]T\=-b<e]^Y,c[
VPHWeVU/7\C6g?UV9<b6#&1G^KG;706a^X\EPXHFg:(9PM?QE@(2DW#:ee((1#6G
.[^8f9C]-MS:=3aZIBd>X0WU&_HA/F;]3EMYE)Z>:9eZ^:YZ-8HS@O-?#IgZ2GV7
3+B\OV))YU(,U)ZZ_MOSeWIJ?)J#]#)\:M_(=EH2Y[Kb,HBWg88SE7<&,A\X3=97
OWW9gX[?+)GECU4OYKAd@H>BCN:2VB@bZaP/\+9<)]bNK^Y:=2eb^9ZCYN0-D>6S
<,:KH+]R.:GIC[7,?3^BL1+TA?eYY]Q@M;7JbE+e-@O3:MML:Q.=f.d+T4MTIa;]
VNR6^JL;EH+K3E./,SW&e+V?BD9:D(]5f5T2Gd+ZG8_>Vd>.811H28b_<U;GgK#d
=]F:Wc.WGA=2F1/S)@->+N4P,HVP:M14XBEPTcGN1^>W<H>4@PSd\7RZ>)_Q\,]U
_+OJ@>d>-5@&S&9@g<K@&^-45[1K7J<,cK/8MJM(&dFL0+ZgH#bbH+DM<BT;e;E[
LNGVfO5ZV\8G__AR9QaFRYVY&/1&6ILS(.P#&c5\HfdSE=P.I,[-TJEY4bIfVQc[
=.K>]DgdJ^EPX\NH<#_@IeR.I6J7J0-FP^-aYc&8XD:5)WP66Q<5OR[WRHgB.T[4
B<IVZeTC)XE33.,DFZDG0U(N[,AR#088ZKH4BX>JV9I_RRY5GC4cHf#\43aFP)X3
@Db3P;G>M.LIUC\XEX:E3V/<1DR=eTP7dL0=INVd-</aA8Zac+2c7CEW<@S_d6R6
[d]JD_JN.,2B+TA_aVE>5?Y(f@X\OX(4SN)+1^:\70]F.0DS;/J27<]:OJ1+5aT=
78#RXQHcS^86RQHOH=^5/#.16XF&,-#J3M>QSPZCIVY:?>9^b4QEBZAVYSgV>7Y]
)LJ2#R2G^NTN3/WF0>Baf2CW=a0<]1fbW(G(;XS[QZY,J@Y7K[7J#:C^F8^dVX#N
8ALZ+[?AR\@gV@5A1aF859GY#1YC?3:O?B386<@TCb;:,DK/-J?,HceQVc>&g/c6
J4DK6C&2eU\_f6BB2e(_9b?\O_D:.DWBb+-YXXDB)a^6+PV5#)KOR[0BIQ2fSO&/
W:08RK&b6U/5cR8K2=0<X1ZW;;e8CGCAa0-)cMHR7]RRg7fJ[[CA5_RC&:M1QBE]
2J^_6c#;92:&&ZSE=,O_QJ9dR&gCF@@Ng/[X^MF?;,&S1ee6PLYg>aW.]S4,8W&.
;f_;=G7>(<5.S#V_Qd#<\NG6WGgD9P(TA79ZY?5X\)&7^F:aB6-,-#@0)V[1BYaR
]E@6eOI4Y4A1.J[,(:c+cbK9R+X1ZJ2[V0SECD?/E-9L563^;7^P8MG_YHd6TXa-
B=eUa0&U)6SaCZJE3;SGV5=:^cS\]?YS98C1_.I1c7+R)6C?D=X_2(,2D8<bS/Jb
V](E/49EL8)>cW>Aceg(.TS5WW[f>0.M03DDZP=S^@aMDRD(VU;0\6N/@NLMAbW(
bZZ2g&6<+MQHMgBaOPUV9eWV1@U;+[+D+6X<=(1ZG2.4)9g6HfNLF+LW1AJJ0;b7
6K?X2L]eaK#R3<5J<dPA/VRAI6EYUBL75Ca36DZ<X?DI_X&<d@TE/gY421>E^e=/
f:\&Af3=&c6)VMVFBP?_^\OW14C(Fg5&C\_\0Ya(1c;CVe))(#cVGN+C5BL(VJG3
b;UM=g1WfJ&>^SC.[1+f-W3<@-OQJ9MA[-21:0>1aJW>NOVS4C7.CP)HN8_;VfD]
RW8J=De,87O)XTP<,#B.e?;T_1]75fVT7cM1I1)_7DM+/PRdJR(e4<bQ1eS?XV>4
_I<CBV^\aZX0DSWV>+#J5VT06A,UC2WXC0)JC^<IF:X(fSEeQV4f^&KVU]Oa@Y#=
CG)COXcUe<H2OMW=PYRVZHYOf.\M0FC_1SRI09e;0MI@OEbQ2(8P@aFdH,GIf^f7
-Y&T;4,I?K[D]>EKRC>81I/JP9@0d?ad=]e97-1)^Q:KFGT--<?FT82QBIdJe9<O
WP^Y8gde9&QX\Ld/:>JMJ\3F>E?_f8(c-XcJ\6fJ&J4F^cLY5Q62&QU09.T7cBe.
0WYYME=\S<1(dOOd0(8P#?N0eE_>S+1gD&?5dHP8##H@MNb_7>e)JgDTbg:d1Y7^
eYCT7A:bMfGFg+5#5B[G#@OM1D-F#DE1?bcg.\U8-LaaET=H2L)Q[aUMJ=_O3G>,
e[U4?&##OX+08#WR,0PH[?M2);NI8&>Ba@AZ>),>dAX=H:F235E<]a.:-NF[2\UF
.UG4eV[\83?3AB.]\AWfJXaJb4-I)MLDDS].aW7\4F7bD+]=?[FGgSCg3;BC7ODe
>4I]M]B28H8\N)c0I\WCdEEZZQ?/Q7dH;Z(GP[8#^T;090W^X7]DNFeV50Kd;fY(
59cRdbN-[c@1K66e6S>_(+:/.TF9MMdWM4\B_,E6bV0-Q#WV)^.HEXYc9G=KFXDX
?7]Y)2#b#b3a=-^fF-P3QaY36QF5fTA&bTb61]W)X&d3-/B-;;Y-TYW-H1G=cg[/
4Z[_d8@]][-7LgCe5?RZ/;A_gDJMITXIM2KJ:OL8\,EF1[e9V.=d9P6:8b?>ERcU
SGY/5_<_e8d6-<OB\-_N;T))NbBM<J@R6U0/&QX1_()@YRYM;ce4b:.W,OY3PWCM
3a1WP0+9CI>#7Y0]D+QKW>_#Q#075gc]a5E[AWgVcL8G<S@Q>ZS2d2#8S<WaJ#?Z
E_]f1:\I(FKY+;NUa8b7R:@ASd/fV9R4_PM7(L4SHSMH4L33IDb5JR-d46FJEY7\
2dZ#(4GV7K.-f8SgO>HO1c=aB+ZD-XgM@#\dg29(&\6B13?BQ@[NV]LMdLDFC+WB
Ee_=/82<9+3gU2/GJZHG.RdBgUd:Y]22D<YS=bP=F@X,T2N43d5bQ4edBcGZBSTW
B)0[P6XBUK-NbP+_@cBdbK^?JAJU]U\C)AQLH-=GH&IGQb<+BKV&H26OQIR0eJaW
ZVK)9C7;YU7fXJ4J\FNVZ/Q,@DFA;5PdZeI>H4K1b&\KA&Y@#VMCC>7a#H\a-.Ed
LD?cFO]_FWULL..7[HRWS5+J+7H5b]aCV8##3_TFUZ[J@ZadC9:L[^<)C>.JJJ+@
C,=f0M)1:1f]G5TaH8JXBX-]0>]5PK5W)MR\R/eVDc?_X.2E4L(WXTZA-K:J3E]:
EYX-INdJM5#I/C6M=MAVFJZ1;0R>\-H#UPg497.cKLJ&(L?W7M3cAZ/34\@DSC_E
<.NG4OcTHBZ2efNUS[H4F73Q^ZJG/SOI:g_2IZH:VaZU+-gV_8Q\6b&5dfEA9=SC
N)>M&CB#gG,/-PEJf(TKP+DcV#6DPCT&LJ[W4?)^C;[A2/NMeE(\]C>>I]S:[A2-
Nb6S)HC>>g71be/BJ)9##H74g;6d9F)SR-]#YH2O9I6_,^LFbKJbJRg#a<GK4C9#
]a>04^S@MMMLLPU0_8R3gZD27<=C#YQJ/Q9HI_8><QFW@7ST08d-Y57KWS@/X8B.
^T4,<8CE1SYca\;:,eSE8L:Z7a4e5_FZY@4TO8[)&ITfRA(E,fK&g)A5eSZeOZC)
X_<=P/1<:7,#4EAMUZ_d1WV\15E>g9;S?7;4UVQHB/6^L#LPYT_Hg-Ha]aER=9&A
cL]5gM<X,gVC#\NY.<X2C;L^/2<6EE]\TK.DH&:CL9W6c?M.4RN-:2,S:MSN-?+P
8L1P-OY61,-]HLM&eHFf3\4#ESC#O4-c:/^&#/g/4KW^4+g@P4S76QUgP8.Q/>>c
d,YJ=1LQ=W1D_UecZQ=_+c<_-LCH4O[VJSgJPD/W:7Q6LOETI:1I.,)?Z?/ATT=U
NQUEN;De-H_dfTZGK\@L-88#B]fEY-;CCBcHD>HaBdSVB1L<A@/QTF]c<4.b8-XK
KI8]ObXSdTYAe0V9/QRA&BJ83);5&@a?FW\YK;JHgOd,f2MTOKR@2?&T\,9TAL]L
cRg^cbATW41^^WPM84V:UOG<6&:aAONAR<XA.8g#Q:03_g9a\Qd7(+U2<-#,A45=
7,L:?R)7,1Q+AJ<G?/-2P+R/U86DO,A7>C&?F5Y4^_I;+/=(>4=<([<aLCGQ7f6b
2S<515:C80SY,a<4(NMaa+d8dY1A=bHVA(ZE8(dB)+^6:eHBT-T&=32bTQ1;RP4Q
d6]A9<8H-@ARVIOSH/9:WS32=PDO:3YXU=?4H:@?J]Ud1[_#&3+U:7?4d4#P00>E
_DK3_<8b9#\H[X);=IX0&@H[e[#B=5])I.4HN=N/;DNB6dC3NU>g7>YH6d53A_,:
\OF\Z5X.gH#9])CMHd1;-L:EUQSU^0Md\^<BI6[\&X5S/4Z=LOW31K@YOa?_245d
dN#7K1PA7Q#XEU_X(^7?_Te]dP(L#L(b^G;C1a&B@V7c1:BHVH<W3dJ4cI.--g@G
2XgJ1fC3>VYK1/&P@2:CG-\O;KI\;@.:9/KNPQ^XQfLLcb^[XO)@6^0a@]45UJU7
HI/>;de80:EBaWfSZ^-W67?)Q-APBSWR<5<]OQ,A>L>_.NDHD60)7G=3[93dOgAf
FE=GT@bUY>&(H]Rae8W9;L=e-bLe_4QEHQ+KA>]&M-Z[aFK2W8]J>>M<V;7?)P7g
Zc@Mf?=cfOWL[3<R9N=G)^>,4@2(,9E#^C^\\37HM&P&aaZ,APJ+5IP4Z/gC&#U1
@8?8A0MF)_OCYc@;>EEP(T5<K6T>0L:-BS1a#K_DKSeKJNSE>20OW+VTSa[JSb+g
P85Y(d=^[,g>>,J@^H5@/f3YI_(X#]FDTKE)A)R>/J_7&BB(0HHaVf;H>:H@?O-+
R1_>)1KWSPG5E(G&Q8\9QF^d+2aH>_;27>5<-BD@,a00PC]c_9V?c+d4WT5f[.dO
g:?0NgZ9WCc:B7[aU\K_>.cUC9d#;GNVS6bgB[GW5K4,ReKOOS_NLHV+W0PDe;=M
-e;><,O.eJ2YDceDXGSD)FB,RS8Ba__0M9&3DDaM@d1X4d5=B?GN[[(&5FRW9bRE
>/3b-eI0dA0f8249(Z8DMGaB0g8H-fA.b>OW)E=#:bZc0<2BMC:cB5EYZeU.FSPA
-b-KLJ#@O#g49PgRS:UN>V6AOY)J#Kd?W\>4=H783L<dH8U_1IGd(55Se1+;X-Lb
U_0JCXda;0bQQQZ^&MfOGO8a3Z<KFKVIcULTL)R4\f,>U/-KN[,=+0G(OXd@6c>)
15abbWES0A177C2FVfZQR-HIfg1H8e&043e;QeIOS_B]eN,TW4aWgE_V_bUTXN65
(B;KYTfS4RXI84b87+ME8\LU\FBN+H]XKM(5B3O+:V4d\d)NWd7GWBJ9YQT\JJJ)
NYBB^e3/4RSX&aUS5DO>:d+8-=EC>L9JQ,K;L+&3>ML&^G7EPXEQZ@)0VK#D\W6=
Ib?14DM#<3g4,b2.c>^S+4]T_#=J=6e?42SK;O5HW65?2FLf,G&6(><3C5=ce3/?
@eV>ac<I9:a-HYH&JZ:-@LNBO?)=N@JLcL5)7;Y0]KE\5@I7\a67a&c]aT-3I2WE
M>BKc]+#.Z]T^E648RCZIdA.5a.]V^Q0OK3g9c8?-,JPV-baNZTUaTX@K@5EeH5,
[5g5PM8D5GO@]@:#-@Xa[ITE0^1G:5#R:.MI2S,QcEd5A#dY;PPE?P3B@c?WE?aS
9Vf(DN/#Y?E:I4\<RRV#:cf7A:L,Qe,5)\1[-BGdR,9aTF+I#TdXa_b;&\G<F9F0
2PfE<S+;D;26+S:KBBE\;O<R;I=O[6X3Wb077D57J6V?85O;U?.?)?4-D6-VUf-8
O4^<.>-dFe>J54Ng<+U]Fac#Y8)Y,:QC0(7^23RZN99=.EUPC9AVd3V:FT.b.&a+
JG_M/b,:#=\0Kb&JdUcdVY1DGf0?bSJfD,9_WDc\84G&TEJ1eI6NV?_)=-^?Ccg.
[D)S]-<3OQLV.IW^N=gB^[;PeFNe&KI/1O,:Wf]SB84U]J(G<,8bBcDX42CaAHUe
=DYTC1C9HM/Z/_[NJdHE@MK<(dJQT:JO(IN^g7D2,JV0+FL].VN;>Y(&)g2P7gR4
/R4a+b6C45;.\(O2?QGDS/_H)&NCV@V[.NR7fB3=4)L6/ZTGW82B34T5,CCZ?QW.
&N]VU4C0,,g7H)QT42&[&I#>Y<E1B^NgZQL8L(\B#Q@VaO_&;J=eF?Q+ASYED:Q)
NcG]V-5A[\Y]?H;G060ceE<#+S;,_L;^NY],>S&96\;V-EL6Y.1YQ+6MD[d.J\+4
9.f>c;]Yc39&c]V/0DZceV#3Z26-BJ25:YZgV7eH#A6)43bG.F+:.JW=b]VgcY8R
TQFZ^A8B(W?XMD/b7J+C^]QK+J_M_Q9[7_2W[&XVeRP)Z@:.B[LeA^F?aE#&/1Q:
8?7dJ7.Ga^fF(:&g[G[6V]&&F:I8/_Y1+MSWF3ZAd<d&@<^;BLTS\JN\273B->)?
_;:-&b=<0>]^D[OS/:(d\MSW_b-a8J_A\/I_=dIOSE=5X2^JfgZJ#c+V,YF3WeR?
-HAM[dG&8f^)+H/?e>4X_85PRKP.NgCTOK_=)YIYR?eU95:M?7B]GBV7KX3ggS>e
fV-I1/2PL,O55GPc[2CZ<<RHG,Y\KI6Rc^]Aa6_f,P:7D2STVTG#(3H=2KH.OKWS
T_I<7Z:bC]?c^]-/VRPMN9IE7+a\F+]LS1\0\2-^fSU+#3U:U(?9S[/3;J1A7:NP
5Aa<;5+ccV@;3W47a=Q?SYdP(6>c#WJVC?>&RLI/6<d)+/JLK(J_0cMdB/:eRfZ=
]<)0\?#/>@UCY]WSRE];?dEU/_RFP#=U&0(@Ya+e1J10M9^1Ma#WIH?,^I0+1)OI
@UE?B8@g3D.,/.BHWE0;[,E:VPe(+;LCTQC(4FcZQ\^0e:PB5c.C>SWFc.1;AZcO
1Y)21P45HW4g\f(AY3e?/]T\acSHE7MM\VZ(RgKVb1E64\//>cL&X3aUORFJ05g<
G0AY-_c)QN1W7A4S@GL6LB5LVa.^-6cYNU2&QLG1g82J=^90_V2.b-6QK#CD47[3
C+)G\@C(BdVOb.8@-=5OAOeZ]TX[8#RGDY&<5IIf7Q\U7gb9M(dRCAIBM(gK^e9&
#C#T/6g>&)FC@FR]b9U,D^W)1dg:[#+];6^eO^<3)?6a2-FQ>IIPQ#I)##4fC]&>
O/YW3Q_MO>=\N:0KgXK@9LgO>[bL,OJ@R&I_c8BOWCBYNOLH[8?2f6?YI[^8&&g@
CQ]9<=bc#6X(J./6OP+1F:B8@f^@/J27B:)&9\-^__3c1PP<]aB#f<.U3W?VFBUV
N.7-PJ+F5:6XZM>=L-g@\&Rd<<,P5DF;_WG5-+aF;e=YW]8D-WB^)\^X,[K/2Q5W
eP3g_U@IK;fN>8<Y5ccaf]9,[.8P=N5#^3I/MF>\E,X:O)]a25PZW>5N3;BX[KR1
RJ:&9NSeT4cUI21)OCMH:578XZK]WXg4(RBeHNab/A/704G5XCc&c0JI/g.D6dd.
+//cgPPJYA;[W_D@O#ZI)2MM^QL<fU?.aOgH9^44CRCBE9W^;d#-NYc4X@bcJSX5
5CK1RO=HXX___2L<^,b=H[aVTc1]c\_2c.Nd&)G/AXd.d;Y:IU=J=1I^ZYU\3U7\
]EPCXd=,J^SC/9Ad]:,BPR\C82a^@SbVg4C&Ra+Jeg+2+^:&DT]4=>[=5cMNCFO>
bM2+JU\6@F+[D0FNR-KPT3G<=0[49+111(3A=<Fa.g8X_#PHb54V.P^QPR2)b1RG
L<L9>FI7BU,fLb_HX]9TB]QJE,INNdKa4+UNCB18Y+8J3=(/3#0R6/-L@;KIW?8J
c:,K&0O5L]4F@JL4Md?=UQ)V-gcL8YA6>VR)6b458c5T9[Q&9R_F?UR7W_)fa.>B
NSa?:aO[E@QX4078FgW(D_>0.E-QM4].f47#C+)9O+&E<3C(NP:JQJ)P)fabe9:\
K9(#^6+F=(T9.Y[a3J33)^Hb9I\PI=#g8WJaW)ag^D]Gf\A#a9U+C&FRH^I/^LRM
ZS(,)GTC\cLS?\;fN;09RJK).=0])cDD?,M&GZd\OM#0WHJA3C]:YL9,TVU/.3<0
8;2E>\?=a#)[4e=3U=]TgVHP7gE\2KH;cbDe7WWGZA7fZ/3D;GAI8U;deTC1-1^L
c<6\cb.gcD4cU?c1E4&->#:Lf&T[=.Jee8J?;6=5,fab/BC/AKVPG67IMDL0ec8e
1J+L.@X0(L\>FGULX74d;D1.Y.U5JR?bYa:EN5J?)V7O9(YKBOGIR@LJBM#JFQV:
1+V(5WRW<0We,Q+@AVc:eTc/3I=U2\#HM6159\O4:bFJ5\3aB3[Y[97G7/;FPILN
3YZ^/CWSLBZXO_gLY3[#/IQL]^QA[\<OX1CMSAcJ9VOI1:#].G[O@\eI[,CVScX@
JU-f1@M)BD97cbSN>FX0XKL7@dX(&+e^9^_?4APg7H2SM@LBD]g/]^/2J(EIY20(
J2^DgX=9+XXFOU2bCI^c89@OX&WZ&=5K\J-&Ma_CLH+QEb88W,XGLRB_ZW&PJaWJ
F_Z;T?+?X-1Gb120.8#XLA0^-I=#aL+R(,UK&@GLQV<XbBT-(0\1QD3P0PaEgg]D
T4Z0Ta95_b97ZabcO[.C/GcLT>4H:([92>;Mc)^:@6_W6cJ/?,d52eH=9C,B2)_J
C:aW\9D-MO;Z/5(/+LWA]a222d8C\#9,DC2]Y8g0:74ZeVWE3B7[FP_Ub/W?/,RX
.8dQZF8Ra?:CM#QY+EWCS=&=M7KA5IPU(&POK5V.F@g4Q><H=I]_^8_7Z30Gb@?0
g_8Y_#(b.A)ZS\&5@8;.0?Af\FeVQD8eL^g?8A:M7(^,,3R?A><K,_)A(,LCGaJ1
M.e+N14E.a;4@eIL8WSW1[D1Ud[#,dA4?8PJ)@b3FVS?3.),(R/.F@C9M#;3T7O6
](0-XI:=a9=PO-D>0f?&;Z80C,;)KH;Z?[@a/,d<a-.4)I=B.Z3Aa\[:1>Og34^d
^D>;)U]:e4W78b>9?LcDO=8+NU[XDFaY>.^-H.U-I51ceYa\d&ZKMS-DC&G\S_XO
JBAE&]V6^F@E#<e4\-8ER_,Z?,5GGKgH<R&[KdI&ZH[,9?-\a&6:/Z31)Y\_+.2b
T?Z3SO:+^69N9JQ(fa(8O#.-==caXJP35X2GQaUNW\P1F6^HbE03[Q.W?-6T<C@@
Y;GGE?(^Q\>Z:Q+Bb115cM24SN:&;&;:OW[E)H#A^3J>VV]<I\\<W#O>0S9]+/_\
WSZ;OKJ0DGcaYEUK68aQGNFBWN8IUFM,4=AH[:bFIN/-P\KA1KK3=61]32WQ+HU3
1(#8@3Y-ab)68c#,(e6.U6J8,1Z)b18R2>A<_Y>Q3^@7fU(<1:TP8QU8A)MU:>S.
B5X#c]M\LCNKA3,RA.c?c\).DTV9Y9bV^O^e^S1^D(2_7aX;Q(<6,.\5NC.&J\FS
:Z#7ge0egR>H0?e&gb)Zd<GR9JFe/?2J1Oc;IIbeebF7<61fB3R\#_e#aV9MadN.
f>RZ8&PQ,3e6HR9=Q]:MO1<;PNQK9.bge2fQa]a78GM^aL:W8\M3?GLHNX<?&HWB
;KdA43,AA951RgAV>0YS4]:_XU,U55@&dXZ[PS,3._2<c:Q^ETK#3BK-,#c)5HDF
[W_4?DGH<;/X.#=8_]?VP@e1,8&QQVDgEgc=HW\I+WX[P1J0B-SLE@<#LQ5g-FY4
E]?-Sda=;D\724+K>JH7=9XH-/]=FTE[1^LGb<#gNTef;+<=@>3R6;O9\?RU:]0.
#I)AgN:60R;R]904GTU34V.82.QCCFfS[^;++KV954^&aE(^I:A>JNf7dU&,-/5P
FTQ\_,DLNV_3:W[\KT324<#]dd3c&PU27EMI#&5/SUFP&66^_XSIg6D:H>JYT@5F
5,GE\]5ba8]RTP?8cf@TXCf](=EN_S_3IKG+HY.7UJ&Gg862BH#XV=/5D:a[L\IP
\T4.6R9bUI<EK.\65(TB\TAKN/PIBEUOT[/2_fFBA0/6_b]QT(L<2VCg\>B\aO;;
JK,;9e<TES2bb5_g_+Kb?4M(-3;C(fJ3\Y0B=-;45JT1E14?95PUg9=ZC4f3SCX)
^7_W3eGF3Q#ECIg?UVMSYB<[\P9?AC1RU0cA_Jg8.A-C?,ID81BAI^J5G-21ZRYb
W62,M,IMHNJeJ5c&KYV)#Z/XP0,WgZ3SC-R8fH;df<fFe64Lg:=M\Vb+M\#1<O<U
:;ec#Na6RNL8D&e3BSZN=^B+#/UBLc/BU-UX]gcGP[fP2<BB:?@ZbYNR.5;(3S(&
5?bTJY0</7:^:IP94FE2eH+G##SGK(^I]QDNfRY3#ZF,4(4aXX6=c,g_2d3,N=8H
P-&MKKDF;Q7OK#L,7&A7bB0R4H(YL-Sd:g(;eXB1W8baSB/@MIVGYXF+9R-:[^.P
T8V_,ID[c1[I:g(:d7NcCX_B2?HF0-PQQCZE_R6e#J4N?W]Nea+H-]0FdfNM;QPH
Vd[g,]@Bc#@MYHT9&gd3UW1F0M/;fZ4P,^4/Se<JH?,6ORK@6)]8,@@GRC55/87N
7A\FDPJTMO?]FH32XHBAXW-aF7&1>JYD2#R\b.AL2J0C;X#92EGFD34Jb[Y7&KEO
>La1TeB,TGd)[aF@4[^-NYT0E_YTfO+^V0RZV)911O2\EeX@<J9>;Df[19[^XZS2V$
`endprotected


`endif // GUARD_SVT_PATTERN_SV
