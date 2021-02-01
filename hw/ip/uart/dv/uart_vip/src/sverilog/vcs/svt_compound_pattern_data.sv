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

`ifndef GUARD_SVT_COMPOUND_PATTERN_DATA_SV
`define GUARD_SVT_COMPOUND_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object for storing an set of name/value pairs.
 */
class svt_compound_pattern_data extends svt_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The compound set of pattern data. */
  svt_pattern_data compound_contents[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_compound_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
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
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a pattern data instance to the compound pattern data instance.
   *
   * @param pd The pattern data instance to be added.
   */
  extern virtual function void add_pattern_data(svt_pattern_data pd);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple pattern data instances to the compound pattern data instance.
   *
   * @param pdq Queue of pattern data instances to be added.
   */
  extern virtual function void add_multiple_pattern_data(svt_pattern_data pdq[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to delate a pattern data instance, or all pattern data instances, from
   * the compound pattern data instance.
   *
   * @param pd The pattern data instance to be deleted. If null, deletes all pattern
   * data instances.
   */
  extern virtual function void delete_pattern_data(svt_pattern_data pd = null);

  // ---------------------------------------------------------------------------
  /**
   * Extensible method for getting the compound contents.
   */
  extern virtual function void get_compound_contents(ref svt_pattern_data compound_contents[$]);

  // ---------------------------------------------------------------------------
  /**
   * Copies this pattern data instance.
   *
   * @param to Optional copy destination.
   *
   * @return The copy.
   */
  extern virtual function svt_pattern_data copy(svt_pattern_data to = null);
  
  // ---------------------------------------------------------------------------
  /**
   * Returns a simple string description of the pattern.
   *
   * @return The simple string description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   * @param value The real value.
   */
  extern virtual function void set_real_array_val(int array_ix, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   * @param value The string value.
   */
  extern virtual function void set_string_array_val(int array_ix, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_array_val(int array_ix, bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
]=T7D?[;W8/FWS>(&W&KJRg+R_bK)acd7GF-JL1F08F]K\cV9Kdb2(^)d(M+AL7)
0fBa#WK+PA2f^TYBI1+F<MaKMGT/O@1VWaM3Z9EPg,63L01PC6IS\3e6CU&RMSDU
2WOA@X6N#R(&KM@/AUbA>cE60A)aMI(7&&BLfXHT,>4>@;0+U3QBFcDF,:1>B@8e
AGK.[bX.:2H<,@)5>T:FL@ZW\)WEfDKS_:F)G.?H=>[@_L>TN:YN:C_Ud]M:MbO+
Ja3@YdL&QE..?X<?,AU\P-DT,(._0O:BfHE[eKFYYGbbFTK#;4\P\F5N9b39VOU=
_O1P_.1HWgV5P/fMOQ=7U7@DG=HAVg)c&Ae5[G:aL4;\50A10:5IO\R(NWDE.=R7
T5#AC5ZS_;T.SBEd-R\,6fKP77g&b\_2JL@0D:^&/)HaPHRd#\N(gKfAC^9f8+dL
IZC7D<]6S#LYSg:WD]OZd,fU^^e4JYH88CfRP&__T[f?L)eL_BLPae0f3+LHDI8B
IV6d;4P=F9;E9I]AH6Y<ACcJC>@/.R,@UUUOKWaW0?e>[15FaEDJEJYG20#ATW2O
25&f?E.+1H/F5b9cG;F@G09QG-<eD^F-:OF2a.dNMI#&\-@015ZU3H;<6-0c>g+?
d:c9\JS&B;SD.;H7F_L+\dY?Tb[(3>\Q9K_.NeKX/8X<KR2(6[54/-UZE)N;NO[c
(XCbAHT]B\/OM@=MQ)@5Rd+b=R.1cf05T>IPgf9ZJ_<)Ug/aVb0ZYI2e7T@WEJ^#
=#5Q=8UPYVA4,X@c-9T+1?2.9GQ[)V)YV/V@8[G&;#DZ=,Q(WJb9gLKL-5b39+7K
-9WgFHeUUJbLOIgea07ZA]fBGSIXfJ/AB7J7a\5(K20#4T2,VK2@A2CGZgVUcE(S
.eSHM<9];;f<81[V5?ER-J>6T05D]H9D+^U-WZVZ\MVgTbL1KERA<6bM82&Z[[[4
9cZ(Z7^A.Ub/_P;BI\1W-0HNKF]gZV?]?W)[0_7:5B63ZY0WXB\GB)JaJF?MfQ:f
+>/0g[?)9da@_H>dP>A+O>_Va9[(#e+)8?:TR#_5//?R6cKfCHcCc]f\OQ\3>aLM
.#H#\9RdZ:cVY+Vc=4H.G?@g0\2@c-W:>CP8>AJ\;45Jg[^O8+:bN+eSGJ-M#dD@
]YGAF+a]6.RJ,6b_0G_[WZ=cX8E[L5,Q,9?G<)Ve3G.84Kcg_PISc<)T[W1BBB^)
I,/#fgO4#f^)XQ5\+9>=E\RCZEOP8J79G8KY^OGF]aN@?;JJML0S5G(Ua;@1Pf6Z
fbO.;^>T29KB;GdTUUbHDKAT:CJ-N++Q&2VQNBOE)gFCQH]M,,Y</R.5\fRBWI/.
IUS2Tg_FWM=,W+?&_?,[_g1X\569-(B^QcX(&b)@CX8+&>)<2\J<5]VK9-^cP8DL
253K&CRU<T1Jc,3>/?#VIE\gegbXL5cXV7VKg&>T4VH^X&EaAI9PcN:aY/E_7E@B
cGFWe?/,36ME:BGI=L+:BfAY^Y+J\3PP#[#VbMg/dCU=XNC009N^3U+bI.@Cg?NF
fO:SBF;+CD??L\T#&CP9S(0TVf)?/;O,LUW[Jd3A1?3J>7<JI^<,Q^PS6d=#b)66
]?A29TB#H\O>O9B>^RDXHA:2<agC-:cD-5TG(?N3a]_4Q;E4HN30\gZ.@8J90-fa
G?c>&=J:_=S)>)BH:MaP[:^)-d3?#:/4>O)dM[-^Q6(BMc5O;7CU]M?\@#:=KF;>
E@PL;B4;dUa0>Ve>ZE)(Q@QMB)TE1Y#P11cT^<N:-[be4Da@C#B??PNRb..]UZ(F
W5JM]CdC8/NO_cfUREY;P^L&V(PWI)EA.CZU8C@:F[eB9Q?bc/^Fae)9eJVc04K=
Z74Hba@:+X9RE3[__:eY8Mg(?[/2]gF4^Y@(]U]I\dOLN\YfY?WZ3da;Q.)AfC@[
H2ZbXU08Y(W.5IcD?IWd1AFdR5V=d4@7fE.#<9X#2@:DD21:6NH8(.H2FWI:;N/E
?>aFFL60,af51&74_SP?XMSB_SbZX:d:XJ]PZA8gRZ9D#)FJ/\G((aIYH\)cZ\YS
#SOT<HE#Z0Mdb0(2+/(/Oc;,=X.@:(YYKID(A\K08Kb5VgB/&.gMTX#08g&73T6T
QG9aADT(PK(>a_F+H4e)]Rc<+LcKLB4DWZ98Ta^QP_7AYI#b<bDQ&G_fS(T5#\,N
5&KdC+]T^X=7D@9+J7fYAA\>bGM8S7c8HC4BYU0VA3VRK_I?O2-ea1[HgUF2Y&>9
cJ\d>F8LY:T#0X52U+@+W0OOA?4,PBS>76&27U9GC5Tdg<V=[B3GRK3.?59,8LLC
\R1JTL2Wd>.4bLYOXC,RHP[ecMICbPO(?19J>+,eV(9MD[+C(YCFIB[P<,LO6E,J
JDC-\)6dbP_FNEF]24(dIP\@c&5#CI5FQ1ESC]5.;MJ=NVJ-b5D?(eIeBV#;K7b^
/D<?7[]3,.6[>VaD3+,Ig@e#::T4:gUJg>XWS>e.5PAP+]3:Db0DB;.2e^T;D;/5
1,g/VDCeM]/fZ+bUUK^8DV,T3@]U[9LO:NPe69I,Y&4EGJ[B+2R)e5D,ON>:O[VS
2MJ=7J(O\U\g7\FM-+E8=L-3KQKB&B3a0c==Weag637Q[QN0:bNO4T2#?AXLZ3XA
\T=Z^T>HC,-Pf\O7JS4OJJdZ@<S>6O8Q(W;cH?XdaUQa4\X4^bUUcRIECH=K,-CI
[A#11\JU[JB[aeOS?D,D[[S5OSR2c)66N&,JCg/W/^1>9@IdKWSfLg-B^b/V^GPT
HBEU+27)?=D]dF,[IU^E6QgY3F6SR#GNPaE_O=0(#b?BC6b4OB+fDb#G#SgUfHgc
HQYeLU#E>I?>P\8ZV4=R768b\bg&)7G)POgX#J;K^FTD9K;FLK=KQZJ&_+cZAXGg
<-.N39<?MQM1A2eS\WaA@VE-bQBX=+_M>B2_gDK#aZeTKIBGZfg-M,MAPCW:#4)C
(TE7Ec42>A3=/#gC.O83R7H8Pg>0.KCVef\TFZPQ?.fQT&(&_1b))KCe\/Gf&HK<
K1eFCTETG#2YfI](6+aAZ1?8BefX7Hge;QbGX_-\K^S?YFP5IgVDIMT/AScH0+4b
P+#U._RaFJ>?R]F/[E7OQM2P3DVg7BZTd-<D:O(6/E4?b0Q[YGAeZED#<&AC1dA,
SB2@ZT?4JI6U.@W,?JGH+3[bC-<:,Zf70E#:.P.geL9e9KZ]-MS^)ACc+X=L-QM8
6eZX&c0M.1K(8cAP[0W,L?H&A.V#&6_HWKfE&SUe6O=+T(E?JKZA>d/L<KH@7gDF
g-QYU3O?LfA^f@cBRCI#PS#HR_?S16UAcfN4)\+C=2gW_LfFK2?c&WKN16)2;^EM
-WMg^_(I5O8\_=QW]-F<EUg_gT/3d_6a]U9/EW@56Q^)M09YKcJf&UC?@6X=.Cgc
YI9+f#aG[LN:LJFR)VS\V6O>-H[Of(EeK:4,YQ/0)-YEaAA,.eL;AMK@R,H6&UD5
^-0/ce+VaC]cPfM,?8>PZ]BU5_.9/6VY<S<Q9;@ZYO.GU&IF:(gR0D<>)_6<IDVY
40;WK=K6d3U3?9I&F_)6.gSPH);DEH]>N:HA1Sd^=OMJWGC27\T>KbdQ\LREV71f
0I+L+]/f&cXCJLQ9ZB<RJ(N5GTFQRcRN#Z7WBD@)-=2/cDO;M2[A<M-KP&36+9eN
DJE;U29dAKcMR9fYL+W4RHVdOgI:1HW-\b8@g75<IUfER=LY?(0LePW>46/B?J5I
Fd),g5FNA)KG1M^F8MXJ3C@32#aT6/gX@I^H0F);I0THS5[g=eV]QMb#_YHZ]R+b
7ZDRE-&EXW,WaM6bK)YP4,<(\bKX868QEJFeDC8(=5F\eY0J8:=KBT?GJ>CETa\_
?X.e.2/d_+ERK+;c6)FN6U83+<S51#.AXb\aHN:M3QH509=P?c^:3X+<+?)LL+9X
TCD6ZK8:\,J[-&TSIBg^)DFM[@U9W^e^NWBa.HE^bH27#Q)TQgGeBL;.@+:Hc#=M
0ET2GGEX)Z3LTEKVO-2ZA]QKTBU,D1Pe-TL.?\P&Bd2,dK,]_9U7[RWYH&/FJE-D
Z8;OPHKX-,\3UUH?R)d@@8U^CIUf.C3@@N0/:DPG@KLKI\S3@.PX&B=M_\A2_N-R
E&;[RUXPH.OR2PccQD#\Q0&C6+\CSFGSNH9R-CCDZ==XRA5OT:=#9R4=H@F)f<M#
G<]dL7d4RJ37#24:&;,XdZQT#:-JN1::(Z^:W-+:@T]_5>Y[.2M<5\CL73J?5I\[
<O3@5f0NF@=[[\a6eUK:;BAW@6+9O]VV+cTH(,C:2[NGJ<cTV5H?d=,\2)YE<SKL
XM-P73;.2=QV7_]Me:#E-39TX<OY&)EcAD90Z_7PP9OR+Yf-,6N^703D/bU4IKB>
FOC/8S]]HH[(9MTLI1Ia@3A3OEgFM,+XXZ^A6(6;Xg)cVI,\;-dJbCOUA?D6Ya7,
/[Z4Z4A6K<HLXVNgfeA-C[4L&a2647J4aCT,@[B\PK4/cF>#-ZLKe]^(FFQ7SBEX
2,03HeD]_=f4[a(+[IZE363)d_b_TZbBUH?/02O)NIBV1IBK:4_N,P3.SWZ^dDd\
)^KGH]b4M]9_Q#.Z4)#2N+,D42M@[,UV4J:Yd/S1Hf2gF5>+Ib&#:YV?gP6W@fWc
fLNMWYO54]dMa;Rb6,[2DPMPL;9SUP;a#?LWP,A5a7N3>.QbH;6#GQ,(+g?6YfNY
D6aGOIY^bPeQ+c;WL4CN]c=/S^T?Pf4CP[,4NgB^,;ZYP4UI_9(Sb#1OWU1Xf]>)
d&HeQfHd\XE@WST,XaKPC4c3D&F-BPN:;6=aM0LfF>F&@\Z\(ME;9U+1H-+:DVUf
a);,C3I=Y[Y3>_Eg1#3,@Q:VBW=,:VDT^HGKPM>e^]Cc0^CRE@?M5QK]OHJZRU\C
-g\4OH<cb>CB0eQ5.T2g;9Da8I89>c4T;Q[.dIXe8H][eMTU:<Jf3ITbQP--.07:
P7Yd082bNUOF.&B5@Xc9+BA7X1>ZM.<:>WU1C@QUQ_FZKXHA#N5H)M(NE?PTY?Z@
#A@L/#Q7:.(\#YV;(0:8I[d#&EFeBOQ:?^dH?YWR^OE68&c2FMU=;29HM4cT/;OG
/L>fAYXRLA<CN#Td]c-b?>EC&P@XRLAOd7^KHSb2UX;=X95F7;G(cKV>&#ZUMgfJ
U)4,FGZE@P&,5Z5]E5gRe-E;He<QWeD,>9.R=^g;[]B?1d:<H6G]Aa_1f#^E/O6a
3N@K0][bMf0C?dK51Y7#DM7.SIc@9Tc1:56cgJ_5AN9>-3E64E[gPSJ+1EZ;96+g
X^P4aOXV;)4L(V37MPYe+MODa0B>:3WK8:AdJ)J1UPLW>=8(G,]OGLB:<LKN).4P
g^KYZN5N_LZL.NH.N5&&=SGO\V+L;2P\3BaRRO^CGQ\W><O]3?JTZHS&(MEN,A^V
:ML]=(=4F9>F7ZC:U?78bUM_76XTO:FD0,X@D(UYDU62,BP\JZWE0WQ=/N5^Vc3S
VaNR2G2P(\-HD_732D=1SGK.d<C7KIN=<EPUXae_B<cbE@.QP:d#&cR<g\R[gF)7
cE,(dPJ@c\Zd>8?QcH&?7a\S)GT<.f4V=FAB4R.SFU>)H/7Qg(bG.3DMIY4IRH5]
Ub3T>f92b,?U/c?L9D.T.NeA&JJMK@K7=ZU\ZP?<.CIaK5b\<2QV[(aX56fTdV(<
c_B:#HfGDHZ@U;P<<B(4SQ_K\DO)&1<R4cB:JT+Q-G3M4=B64+Oc=V.31\XI<4Q_
e9M.\Ff2@KX6=XIK9_Sg^/H4aIEE-5DD\gBHa-RA;7)<gMY-Z_<Z<)DHB>aSWJ<W
7C96)eM[H1P;>-Sd.EPGEH@@DF\;VGQ07)g[DKTPVCDUGFGS^L^F-\C(<T(L_^U#
YY-8Ea4+UgQQ1>4d#-NQ?NSSH,[Y7<?gAEKY[#BN.g^.-WS@SEg2_YZ.#LUS7+/&
N78A(2ZY@7X?[(&.dEBVFD4(H=FK()ZdG7;QG8YQA6@T8T6U:04&SCLAg^:<)#)D
+I^d2^Q?aO:d;?WQF=WFVBQ#+(^5f8Be4)3_ML=@M)\)DbW?-Y)?485@])a=M&Wg
ZR2>Ea#6DgEOYVXI:K:1H9;Q#WNf47EQR_bW:YNNdL0LUa<,;+7[>,GPA0X>&VcK
HSS0PR:HX7H1#Yd@1d^8?U>UH5?4:&8/+d,#e.<f1<,3V79Z]?WWW0MGD5_O1S)1
d@^.C9F@_S3GVf5O.\_+?PDIK&#6:<FV_AA>S)Z[MFCXZKF?C3:@I@e]_YO-<A+D
WMK7fR>(_fIZX_L&M8F7WB_8;>aW.Db?NS,e]8T(N;I5.V81^-[8X8Q4;Xbf^e.Q
:QQJ_DUb7&Z=HUJg7WBI]DGE0WO0/:ebP^8<5b55J>?<b=ZR,O31Ke8-:Lc14DPO
A1SeA:@)Sf<OE(DPL.MU45c.A94dAITe0f6+DcP4E[W3QE<)=\^LY^SK=1FZ=6:1
B-+4fQe:KYC@)MFF,@E)(>Y,4[Bae)5eT=)eP2E\+MPI3aGb4X8M9a^[=A?,^<_I
:T4OKcG85<I:30>^bT]DG<I=RQS6--D25B&Tg&];1X3:\T2b(,\LN7B=b1;\/0TW
\Y8H3ISM0[d1/>_Z4=/BHST>-UK=JSI>=+d18eQP^Ja+F#Me)DGa&cI9I@N9F^W_
AI/3IXPN)_V[M__(>/,AZ-N7PXEP&ObX)[GMEgC(IZ3VIBH;REbHQ&,<+Y:1@VLH
K\b8SB-XBQ@DO@_O@F7M\(@>3be,:C2SK71/1<9Y:J&HZ]bT7L5G4CSM9E4BPBTM
YKD141ZCG),=2OFQ<H(SUC\:@V#5JFbDD#b&4)M/]b6c3FR+R#-+CFAE]EgB2S-3
<+/H8I2XfHgVBJ8,T=Tfc7NR/g+.L1)E-(A8B/DLa?J1OTN+^;25:OQ(C;1,A-,f
/L4&\#WRC.4496f;I9Cf44U.K-FRSddMA:AZU3,?).^=,3W?WNQMa/0<0=_T>f&D
(JQf9bc)4RI)HG_U?CBGIXTK_WQe;L>5LF>5SS5>4&8ELK4D8egP@;EAK,A,U.4X
\D3@-]0+)#U_U2W1&X>e7NL2DDM/a7\eD)&+HME=V=#\fcW3[)Ha\12813;d&(E&
;ZaK?(b.,4KRX[3>KDZ[gSW:6a@S;HJ@1#[I[+@2eNCYX=HJTWP?gOLQIBA5S)eD
]T<Pg8gZ-K)9:O3-0YZDfX:&L3EfUZ6_deEM@KR]\=GdGUT]Ccf2(.?bQQB:c<AF
BgGag.5Q>(WEZ^4;8__V+dcAJUEYaVN#45YBf[MH/6N4AC3BIK@]V+Z.?Bb90cW4
dC>Mb7RG8>G?H=,?BKdZFQ5-geQ\b6IT/V[]8J;3J=C-#X(P;,W?JGb#TM1Y#+Ba
2WUfVNC?O9UH-GZJVLVK\-9A8VWJQ/^bH)O[/=JQOVS[(1eEe]E]3SfdGeW]AIED
Y2D0aYYAKQ/V:KX#76g^@c7<^&>]C>+]<:9[2B0d^]7_N4K9LI(LL+^8XX32CH^N
H@J^\I#Ed+D<<H_0eA.^L&UJ=@K/-7cK3c@;6]O?ST0L<J/1R4.WZ,9(?PHOf>L<
&EV6YVZ&f5f/=80U:8O?\J7ZJRg6+S.H#gD[2#dMNOa,M&aM3?[f>g=5+P+C-bOW
K_fU6C-FR0I&;Z6FNcY,L9>KG+X8Pd.46Z]VQKVc>8UZ-_5;6Nb&)5>RPSM#2c-T
KCNUg@OKa3LBHK5]1NC53MMG3F@15Bd=O(NO/XA,JaH.&U#=K(1RQ2Gc@K]TK:1(
)Z6B/@bEBIC.1@FaA<UJ(Y/+_a<QgE)KgMEHUKNUa2,&V((XM[fS;4_33OZ0cF@1
fA.egRA>UA(Qf-(aTNM@2T#/&5NKYa#SK^(RERUdGJ,=A[eUT-d<[G[9d+<<:G<L
W^cW1)0aJ;6^1DIG731()\(GAUQ[6&a.L/b9<W)ZIR1SA?J]Ia9)b9CN#?9FJg&7
9D2H5>FMTdG^dM@)Z(4#DBGc62RUdVa<>&a6QeLT39_gP4EC>6E57OZ>LN=;X;8U
E@?JIAMR]&SNaRL;(N835L2+W4I<GC@8Q7c)UMG\(A+NHd=T<D+5;/3\0K6EaQg5
A@Eaa9Ob/aCX2f/?[(FQGdX;68O:1ZI\@&\Og.B^49f9@IcNH&;bgK2g7f)S:Y\L
-B@K]OXTU<)Za)6#DS(W#RHY1CR(9b0.;)SZ6TMHMZGON\<f4O(XT<2GUYYTTGLe
a3:&K55SS3_-SUAKNQ],g0DV+U+c(JSE=/-RD(EHBfL#\#A3FN>,SLL.GO64;1_G
T1(F/RG(GLJZM1B=g,(?Q63(J\M^-JQ@?E[J0^,,_6g:,(NPbY=?9e+2;QD2cWU0
-FA=0>)=KVOF&F3;Q&XB19YV.I8KWEH,CHJ@,/HaTR--a55_VS#JaffQEF=XcQ(O
Z.I#M2=X,C,AfE-aRK2CW?QL+b(G5XX9I,0[=?L+\QEZP,K#f@_)1(9F,=B<gK4G
O<19fL:J6(&WW[.E23f=fH)=G9H_S.0?[8J\6]/FbP,8<E3#LT-T(E._NBc[TKYM
ZRJK=[+BTd-QQ_:Ea3JMP<Id\,dGJeU8a4EGU1MTRI:3.a5^&[IM/ed8-gNRG,@M
(@)<EH-c>@a_dN@]P;6A=)O5=_b0T\D(3Y-ZTT=-8Q9O)Z_<HBbH(/X##&b-AaH@
b_SJG5[N,K60+&N.4Q91U9+FO;S\VJ[0>O38\D_?A[M7J/C(ZQVM-0#7_;<HRZ#b
aL6DFJW8755:H66D.8Fce+XG<\:.U>F\Z:^I&.&U+U<0bA2f+?fC\+8Z0^9fM_O)
_3\c0>P;&-c@f0G2]6aZO]SdLPDJZgPD=$
`endprotected


`endif // GUARD_SVT_COMPOUND_PATTERN_DATA_SV
