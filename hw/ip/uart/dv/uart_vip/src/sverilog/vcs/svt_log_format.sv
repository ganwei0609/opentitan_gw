//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_LOG_FORMAT_SV
`define GUARD_SVT_LOG_FORMAT_SV

//svt_vcs_lic_vip_protect
`protected
gDf+YD.,bHa:GJa;fSe#U=^DV&(;b#8-NL#G,1O@@-3>\2EfO.RE5(A4-f-1E]A(
J2.9aNDCMJ_VHH^2I[>._=,Z2ZK?C5D4JN;O;C3S6D[ELgDKX5Wa:c3&&a/:4@N/
7&dFPFdT.b1\>Hf_39bJEd=+DBLK>3c\&G0GEW_ZOP+Zc/KF>Y^]K,(P647RFf=4
gOW]1W/^]1Z[IYbU,D9AC75U3[8-FUY^d4W&gLgULI[1>=D9_<UP1X5a>29R-<-R
6N)8.PU6ZAW7CaL\+e?Y/#]^XSI3eR.F39SC)FVAS/d.QY&WeeN:1;A8CNXA<G=L
6]-32>SC_AX/.L.<SNWYN2EFG>(\CX=I[HNZ<OOQ1B.893&&PgP2\4.VE(??;0A-
#^EJDQE8]IH>^[_bC6NBb3:;FSA\#Zc.M+?<eSD.NY#EIZ^Y25]G5@PY59C&[A1&
Vb0(J6bcI7c<\3^=c.6A=C<[4J,Wa=?=I2)Z#[NYQG&V2]D#N>6614c0g7PIYBW]
aBF>C2NFK_:YTaP2)YV?T9G9U@;,e\]_WLO7@;>A+;29F+YHC;a7^+FSVIg-I^9)
#S&WWVY>IFb[ccb3]I##-WG&TN_#W&#)ZTLXYR./JYBc#=P9f;ZN3FfP/cO\11Z0
6(?Rcf48/N:O[D_@-+8C^AM3a\CQ8?W0LRDafWNN5CHbfO(K=9X65?+KP^]T/FTL
6=[=.S354A;gVJ90&FD)52Ga8_JBY2HgGEd2OCe\EBDBA_=Fg2Qbe.=?68:b69f0
@RWJSXL:G404<47RL>X6=(1U42[=<C5XGY8\RYHS>RW[FN^+:04)a?<c1ZV](\b+
=:3YAB[#2aHV\g:gI2A+WPC#2gX66ZO=BGT,R3MR&KWF8@B12_=>cBcFAbC905]Q
KFEX;_aGGI\X22D(5Bc\gd;8efLeWH(,.cZ7TB;VUTJ?OMW-FJ+12.WD&f.CP.JA
/N];=)[902N,VBc\22<KCC8B632Q-?5FURG_4+W]F81I[YH044H&4M6g8_7bO#YE
^Q3Hg5&]g0\+AIN(716@+/d\cU2d&;gU(2)?)FDR4L-LI9dM#DBM38WRXZ:=8JNU
D+COd@d<VY<+cS4YD,4B]@(d^a)cV?b-IM[5(C12GBIC]KKaZMBeU@3D30HLf>DY
-P=>c4D+A^(<gR4[TH&D>&gAOM34#>_-3e/JX2AR6+.SH,Ad+5?X(UfWO:]BJRfO
8/Sbb\SHac_ZgM5O4GO7>/gA3$
`endprotected


// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_format class
/**
 * This class extension is used by the verification environment to modify the
 * VMM log message format and to add expected error and warning capability to
 * the Pass or Fail calculation.
 * 
 * The message format difference relative to the default vmm_log format is that
 * the first element of each message is the timestamp, which is prefixed by the
 * '@' character. In addition, this modified format supports the ability for the
 * user to choose between the (default) two-line message format, and a
 * single-line message format (which of course results in longer lines. If
 * +single_line_msgs=1 is used on the command line, the custom single-line
 * message format will be used.
 * 
 * There are four accessor methods added to this class to set and get the number
 * of expected errors and warnings. These values, expected_err_cnt and
 * expected_warn_cnt, are used by expected_pass_or_fail() and pass_or_fail()
 * in calculating the Pass or Fail results.
 *
 * The class provides the ability to initialize the expected_err_cnt
 * and expected_warn_cnt values from the command line, via plusargs.
 *
 * If +expected_err_cnt=n is specified on the command line for some integer
 * n, then the expected_err_cnt value is initialized to n. If +expected_warn_cnt=n
 * is specified on the command line for some integer n, then the expected_warn_cnt
 * value is initialized to n.
 *
 * The class also provides an automated mechanism for watching the vmm_log error
 * count and initiating simulator exit if a client specified unexpected_err_cnt_max
 * is exceeded. Note that if used this feature supercedes the vmm
 * stop_after_n_errors feature.
 *
 * The class provides the ability to initialize the unexpected_err_cnt_max
 * value from the command line via plusargs. If +unexpected_err_cnt_max=n is
 * specified on the command line for some integer n, then the
 * +unexpected_err_cnt_max=n value is initialized to n.
 */
class svt_log_format extends vmm_log_format;

  /** Maximum number of 'allowed' fatals for test to still report "Passed". */
  protected int expected_fatal_cnt = 0;

  /** Maximum number of 'allowed' errors for test to still report "Passed". */
  protected int expected_err_cnt = 0;

  /** Maximum number of 'allowed' warnings for test to still report "Passed". */
  protected int expected_warn_cnt = 0;

  /** Maximum number of 'unexpected' errors to be allowed before exit. */
  protected int unexpected_err_cnt_max = 10;

  /** vmm_log that is used by the check_err_cnt_exceeded() method to recognize an error failure. */
  protected vmm_log log = null;

  /**
   * Event to indicate that the expected_err_count has been exceeded and
   * that the simulation should exit. Only supported if watch_expected_err_cnt
   * enabled in the constructor.
   */
  event expected_err_cnt_exceeded;

  // --------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_log_format class.
   *
   */
  extern function new();

  // --------------------------------------------------------------------------
  /**
   * Enables watch of error counts by the svt_log_format instance. Once enabled,
   * class will produce expected_err_cnt_exceeded event if number of errors
   * exceeds (expected_err_cnt + unexpected_err_cnt_max).
   *
   * When this feature is enabled it also bumps up the VMM stop_after_n_errs
   * value to avoid conflicts between the VMM automated exit and this automated
   * exit.
   *
   * @param log vmm_log used by the svt_log_format class to watch the error
   * counts.
   * @param unexpected_err_cnt_max Number of "unexpected" errors that should result
   * in the triggering of the expected_err_cnt_exceeded event. If set to -1 this
   * defers to the current unexpected_err_cnt_max setting, 
   */
  extern virtual function void enable_err_cnt_watch(vmm_log log, int unexpected_err_cnt_max = -1);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to the first line of an output message.
   */
  extern virtual function string format_msg(string name,
                                            string inst,
                                            string msg_typ,
                                            string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                            string fname,
                                            int    line,
`endif
                                            ref string lines[$]);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to continuation lines of an output message.
   */
  extern virtual function string continue_msg(string name,
                                              string inst,
                                              string msg_typ,
                                              string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                              string fname,
                                              int    line,
`endif
                                              ref string lines[$]) ;

  // ---------------------------------------------------------------------------
  /**
   * Method used to check whether this message will cause the number of errors
   * to exceed (expected_err_cnt + unexpected_err_cnt_max) has been exceeded.
   * If log != null and this sum has been exceeded the expected_err_cnt_exceeded
   * event is triggered. A client env, subenv, etc., can catch the event to
   * implement an orderly simulation exit.
   */
  extern virtual function void check_err_cnt_exceeded(string severity);

  // ---------------------------------------------------------------------------
  /**
   * This utility method is provided to make it easy to find out out the
   * current pass/fail situation relative to the 'expected' errors and
   * warnings.
   * @return Indicates pass (1) or fail (0) status of the call.
   */
  extern virtual function bit expected_pass_or_fail(int fatals, int errors, int warnings);

  // ---------------------------------------------------------------------------
  /**
   * This virtual method is extended to add the 'expected' error and warning
   * counts into account in Pass or Fail calculations.
   */
  extern virtual function string pass_or_fail(bit    pass,
                                      string name,
                                      string inst,
                                      int    fatals,
                                      int    errors,
                                      int    warnings,
                                      int    dem_errs,
                                      int    dem_warns);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_fatal_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_err_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected warning count by the number passed in. */
  extern function void incr_expected_warn_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Sets the unexpected error count maximum to new_max. */
  extern function void set_unexpected_err_cnt_max(int new_max);

  // ---------------------------------------------------------------------------
  /** Returns the current expected fatal count (can only be 0 or 1). */
  extern function int get_expected_fatal_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected error count. */
  extern function int get_expected_err_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected warning count. */
  extern function int get_expected_warn_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current unexpected error count maximum. */
  extern function int get_unexpected_err_cnt_max();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
a_2[4@CI@U:/51gV5H+fI;?C51V:FC@RKO?VCX4/.Wfe(Pc8cS6P3(XQ,Z8UMXJ+
N/W2+<FLP@F<^=-CNMU@(P4Q8g/&8/Q\;b8^2VMK9cU=D:M@0g1dcZN@e)#Z-f3Z
Q:-8@e>\aX,#&S2WW1.Q<FWA=KY(2B3aJ&Z=(URbfU5g526_LS@[CKC-PLc7^(2U
):]81ZYF0>7-T5_V=dd@G1(QUX[JS+#O/9TY,T(IJ<@SDWdDA(Y^5RE@&9.)_1+K
E.X?AZbG9:Y/I+C[e_Ue3QZdC2M8R5G:>ZWO+\#aV;)H4AM3//K#D6]1#4D;:>VA
+6dScDS:1_H/?:M84;[Y@Lg3+V8U7Nc+gf_F&gI/C-#YfIEF+0:C5W=FZ7JX.)g6
WAR?;[LP-&L+^4Q4G)4).2)_4P.EHYSN/<_b9_C,XcPLa0))Xgc5LDE3DZ3Q-Q_3
<B?,adB-@SeJU<A>QH7gL@f?2]_D0Ma5T@Ke9fCGa:O)2EF]RbcPeKg(baad&1HW
[DMBXX(E?2]U]Lg6HRH&(\58@PA9O:KZFcDE;:M/5?XB_aQ?GZY[AW<S3><K^K^2
[cXb2OAg5<e,X]F.<<4TR3&TVX[ILA58bJ&8E:Z,LZ<=Z<,bLA:\@ZF3FU;af<R>
-Q1d&::UO6YV0EI?/LG=?f@OcK^QbYN]09b6d<bd/M&<T:CZR;b]QR6UHOW4(W&8
?>d#Lcc1UH+>SR?G=4><?eK<,W6XT.aDb_=^\<d+BAVg;&WHX-/P0BMOODA:?5G3
U[#SNReF(\\=6AfE:D&,U^RBfc8c=PD)a[e29/Df<;cIe@0S9YSD-&P6X5/(<=UY
5CA9#f,9DLMTN[G+>O#)Hd#NRJW.B4UFb3JFBIS37\=2F9M54.P)9^4OWfKEb42R
BBNc_6NNG0EJJ[TdPG#51cBZ_)HQ^;30/^N0EH2.V\D=UC0^HF[ERU#KgPK48,be
GcE99WT,/E7/;,N=3+F6KU[&[a-<(JCJD2>>\BB@16N](?XH2,=V5HVfU(@/JBQ3
I9eS:&B[5\=XIEFbPD6DB<033^&=^7Z7C3^N===dcf+/GX4T.eXNJg#87[AaaF:,
\A^GSf^Q3Z>UVJJ:cf6@H7,YF90F4+\/f8c4\g+7P6b&d#SW]H1VT+gc?4W.Oc45
1^_fW)-d^@@<dT:+SSLfg?KQ7VL\21,:ba1ZFK&fOZ8d=0:FO6J()3@]ZU\d6=g+
+B-?g@ZBR(?3)ISV_@3&OX5&C>I^OLEA6OU8;/b\#U>9P.>\_\SX](;+CeUTSZVY
<X8[1CMN;7H8L74Z_OE:=P[3AM?e@MQ/]><3L8X+a(ab9d_LL#eGU(:L0eW91P-+
X]IH(D8BVZ]AKFI8OgcITJ]S8>g<e8WE2?]cGb\_GJ+KW>)YKMdQ-R.d1OB]0RT2
_KVJ#U]ffVLdP=Z?,cH99^0]a^a_AG__7FHWe_,JF/C/\c1UWQ.]MQ>c^4a@b\JL
FBOX1f16,e[2M&N,2.AcF@E:A5>G6P)>Y=#\]?VA0G:/8aI:[6IScZ5b1\9X0[-)
5GV7H<TN0>D.]GUV,HT_+O2BD\.4ZSWH7V2?50J1?IgC;AFf,\Pa,XCaPVHR#<^/
Y,&X[75I7X<]A1J>6K7KT]QG[;[KUW]5.Mg:43N/S.bLJ;f.)5KHK<+fBMN1M=/6
M(Bd?36.?M:IMN+2c/]26bG5[9[TU[T(<.DGENA,HfDF^5)E]+]78aINB<-[^>]N
B=-RPJCQfaRYY5@KI1=RAEaFbcY8KU#J3>@1W=/^:.5ATRaN43&?TGgBE+,NJbGC
@YL]EM\bU&.N:>I,1B,XU^BPAWT5(&BP9f&M:4TG&#HG4\N;9f:C[T4(>WBeCEOb
K;EZ]^=#S4];(d]:F5OZHLHe:)d),/C?)E_BS9UdeJLI[eDU\(P5@;T3Q;^0P^1d
TD-35\(N^aOQ<ad.;E>@D9Y\d4ef8JZdX>#\O[)VOK8JQA>U9PgUX6K0B/0Be#&H
V.+Hd+12b/C)\=0QJ9].PRPO4NJBa9L]?6c<^=.4)7a@<^;]AL463M9a/=WAd/bG
4e;,aKZ>K[>&;DZV+g57^YK@YC3V)#VPe5P<281-QVc\<Kf,\<VK,04B33JBT;&E
DeSV+3K+&E>_.H^[[.V@WCOaAS#JG5V]S;<1E&_F>:.[&@O14GKT/U-9D+WEKG3R
WY84<MG<Gf[::D?VLG&4aNB9&R17]<YPZ2FI9BVLEMF\(=OdgH1]Kc=Q6Q4_](bT
/TL(N5-UPG7;UP6VVQf@J_e(Sd6-3f&ENW:#_3DO)B9?3IQ>G55P-E06<6cC>Hd/
8Q5/(Cb8AX1d61[)@9g1^9?W]Vc==/OB_R2OX(f##WQ8SIX=M^K0aS/]5^E_TNY=
LW0J\MVg.BO@BR\E:6[J66(VOVG_YI^Q5I+8W?[V&Q2,VG9[A@\Y@]-?+6.9DVXW
U.NZHH2SR)Xa.K&U=a0Kg<J&VcH:6P,A?)3&&3??6+FUbK&9#VKVL,413X\H-<F[
=-_HJT4#;GaY#aVUSb1-6@g0A(g/WW50?^7,;Z^f\?3U2I]R/NZ9^bU-HLB29dc_
)L\dP?(GU0C10KM#.Z[14@[->AH)-1781.\fVeSDCR^:>RA]L(J#4;c^bbQKdM_M
6&07+@:\(gAC@3,N[8V2FPQ36AG[_95BP2&S=fJ/W@==cfCQK[5MS>EAQ4RM2.aR
K?A[</b0A])2d/gb(JM?fNR-&6L,(@3(4\4&DC^TCHR<&I4WV@e::U,8T3^A,b&P
Tf\Na[E6::(CF)O&R(QZ:7O_<cbZA5g]S/\(4)0NK5;cTfJ:J:TN+D/6P+5C]](#
#2fU)abK.7,(c3Y=U[Z&5[>G;OQ:Z-Z+Xa>W>8\,/>E^14/8-dGa/I09_V4Z>c4Y
_^:]Y[&LQ5\g?/,-69ANW(EEc9DVCTKPd9C9XJg>\WW/0;+7X&eX,80[F/-0[eAQ
JLLb)M7EPS6b+43c)R/eAaNI[,A==U@#\eA@LINJ;T\Y8&>84@:g]71a_VH1B(g]
Z87;/Lf0F3TESQ=(W.b)J\TfI0YdID;/7b^gT<)>\gV:V@UH.f@f6(-=4GV.F[Va
S7UZ=.:OZ;1:<9C^W\OGZeQ]F/5)aCU3IWBWCP>S&g&04N6S_YE#g90DQM)1F_WH
1;DVBQ8#5bNH<2^+HP(YgYU75DL=6M,81:<T^A#1eW7.^AYXd4;cF0U>=\YQX5Z3
TMTD:UcDXB]HQUG0E6Ab?K^1^;gYNG\N>SWf1&EC#0?)bM9G5X5:78dQLG.=\bR7
d0PdB(T)NOQf2Eb?K<-<(BSA:D/ABPNN5b?Dbc__8R=:R^=LL9O4ERHc#((>)V,B
^]T\c7_aI\1UH3=?XT@/<0U+\7NZY28D&W(L/W)DT-HSF4P6T:>4&41H6S&I88b<
\ZJF\K(DF1ZAQC+UYIL9(e[XVF++U3MMLKV\,d\U4c3C2<63>^b@0GHc0R/\1W@?
&53JDS\Hbd=JLR+_DD1C@.E2_SXd&N?[0&F.B/#V+cO^);Vc@K:,+H/U8(,f<b9V
8fT8)CM4<[#^&IP&RHK<_BS/b[#1V\)B.ECgCG6T2[#HK0FVN^<L5:bNa5\c<P(]
.2]:&Fgf@e/EdVK#9BW^N)2,g:[a,9c@>G]6>F0Fa=.CI0;OdB9W_S2BI7(-LL.>
/aM&^,)HNeJI0GIb6#D0PB&.g#Z#MP]df(a#T#<D)&>a2AcB?gM+,70VF)A,cUU?
>Q7/9)5d@aN5K/RCReAI2Ufa2+^S7E#B&[RQJ8]/+2#:;.Md2+L7RS7M0V0Qa&S\
K#W1;Ib,UXT_QPN2\IWS,X&aZ)Se?4HVS,FEa=WAJDF+JQ>@\U7J98&XefgBfe;9
a](H-9AIc[A+,]05&:CM6&b&WgMgK?C=_^>Q6caI^@W0PR6S#..JJ..ONJW?WbE+
?I6[\gP6a5NcP5>31[L0.A.=Ce02P/I:=ET5ggF9c8)HDb1I:_f/cLR+&N6@4,#f
9aCCNW4M:f(WLSRWY]NR31e@7=_TDL5P)N9T7T#)]P.)FU3)UJ^8MbRHKJ_[e&d4
GVbL,;\BRN0N(22E1fVDW;]2Xf=(2:<KTNU@7Q^<_f9BX:J+ND4@#eXP=(c&(772
.3BO#4/,E(e.&ZB5a:18K?Y@Tfb#a)D@8;g)-JMJbUP>07f#b3-S[WbSg>b:X>^K
1>bb8,,-B:Y+R_7.8_;)7(.,dH@.C(/[e.P532P.><cD6LI]4I3_XLc=GJ35/MZ5
=_e:GA>dID)1gYY<^/ON=Bb)8WB:DNF1bZ-@Q\>(=e6-\)J[\7;Xe4[[F\Z-W8cL
1@YSZZ2Z:PZ/;4f,?-:/JRBWWNL_OF#B<A9?5N]T\CfGOObJS/IXC4B-:^=+M8(-
dRf7[D=(VU.b-E4;Eg\B]0D8ga);/<,ZUH4c#:P?,-(Y36-:VdcLJb?HH[J+B[IO
K\K<-(BBIM4?1#fHIN&\+T?WE.7@;+L159K8-<&NLK\Y.d=)(XH_,VIDMIQGA_4(
RRd,e+@;H/&?7&f+GNG?UbG\BgIJa23gfVY#gK16OXNTOS@.Hc0B+OG?^&U]^@28
A3:A@\dbM4O@V(E896aKG.KJIXFHb@PH-]<f^DgM/G189Ib@EPVA)HJQc]A0J2,L
[><[7QaGbP;[<KWe.^E0NK6MAFcc4f_gX(F/G3;W9U0,4CS(7UcJD\2LULc@-b6U
R@)W0f79cFg-V0,+Y0a36VN,P6^Oa-D2Y=6J:[PJY@-)(YI_]Qbc1cCT\SIf1d?T
Z]b0,^5J7EfV\8)5+Ef4;Hf#4:2L0C.LH#d>5)VBEb\C/O=XLUdWD<@=8a0U_ALQ
_RM?#WT>M1^_B2ASca/dQ^>&IMJ]:0[R5TIdPV1V1#,@C7Cb2K<J-&2cX0:IC1T9
K48gKc1Q8MFeNc;L90Q=f,bbHYU-<B(I@G3d\4LA1T[>UBACO^:O(\]XJd03-(0C
;A0d6FII([B.T]P_bSK4R:GbK/&<VJB\]D];._,.SK(@=<eBg\4&@ZQBLD7+\<\M
YJKQ8_c5a#dgZXO)UKT,NP;J;K4)5CF-K+>1^.AAHJA-A:[QE)3JF8_JVA-H+ad>
7@QN>SUJ<M78J<6L/Z<NbTa5MFcV,;G[fgJI;:A,4JH[Of8<+H)BJE((_F\YK)M:
]bC@F\_9TU@W5I/E6d?EVF26D+#QGcF2W7W2;MEZG\0Z?gN(0OG,^]#GXT,S([c5
Z&\2\I[#6V4F@@3V,CXTM5c=#:CEfRd<#(eOWUWH460>\YbUg:Z@HA+3NbZ2LM5@
AZ.OHHZ_JL;].>Jf:1_6(@;KZ05DD)Ve(E0c<IOFYUQ3,.MX[J5(Z_?J+-W)XgI1
6LC>78_b>NH9U.c;7GWfLb.CVeBg@b)4^/ROZ6O5gG#@]f=EY+=:7/f4(g?.a1c\
.&<?1MHS32ebEa3B>8_P5<Q05E9F(AU))c\=&g0OQ5F]619]C&f:#S<I(U6TOC6^
EegV/GG0/_6;)&<TD=.,030:[RVMP4F9NB#<?::gXc1)DgZ:57c[f);=\6ZL#)84
SV=_BC66L^K^E>=5+C)XIHccLNCJ?Pcb[a-/Rc@+125d14_MU7LISO\PPE5MeR]d
:1W^.ZU@gOJ8/L8)0H6V15>=W]MH]g2:<&(6Xg,#RYVUA[F\WD\;<IM@L<PKd=V<
AFF.X\>He3Ae+ANgHU>,G)GCYG4]Z4bY2ZCd97AbX17=d,CTU=IEJ8P+ZH]g8.<[
KNM&Ddd8g17K]@?-0,2;7YI3IgX[&R.\/G,N9JIIW3-/VDHf^#[&eR)aOCLNH9@g
45W\&/)@^&W);<\04)V7MXR=I?<+0ZcS^Of>?&_853Z,39BH+E29Y:R:?(aLM4R0
;E0]1W0fOR_]B0[(J&3OV^U3DS+J3g?263)7_BJE<Y@6:1QG38UE@[Y/F1YC8F>-
8Q\SG@\,=14W7U@/UQ[BLH&]Qd=/0XH1#8CHCfL)+7;>E)(,GHWY0YE#O4bf,K2J
O8VKc8R-eIMAG1(f3]2<]H:YdNRI:<^aH?4LD>]ZN2Gg+]03G/PHSE&e[14R?Z3(
?2b?Mfa)A3[&;R2ePa@)=@G<FD]gJBK@.^L;546I@V3,RAWfP1;K(QF5+=2>0#-\
2L;&84X4OPS<\>E,^H>c]+@E=.\GQ8BR.4BN+R[/3E]f71UT0_D7BeNFSO#D/]3J
&6[aGe5Sf0O;2@aE0-V<6,=0^P@?b)QA;P4^6I1cYH_E>1\Q?ZQb8>2.FgM-DQKL
/JG;OMc.9H_Q4Z<T@a)0>_0CT:CL^cQc38ZDJ6@\0Mb]>4(\e152/(cBe\.C@g32
IG&Q_C]OKE-IX.J,LMVggKIP7\F=CWSZ6>.Q?X^T&OHWf)[c8(Uf2@VVQJ/33NDU
\45H;C:fXX.M&U./)C;,P(gXMd4;S4BBNOVZ9.-7/;>NU_^>#_CH\JNfdP#FL;H:
a<]>JR2GZb;#)9^J=FIK>D&O908=QbH-Ic@]#9>ge2?#N52(=6\G(/RL+ZYVcR+X
=72OcB+F3f?7)R3Z^b,F3=8>=GPK.0E.?I76UCT;d5][2PJ^1QH\dVZg7&GR<_f#
B#MV=,TKWXO)[ZXHP(4CLOY)\@3,?)aND)^,1VT,3O]9],CU80b(.eA9.I)a[JG7
7,?,CE>XAR3?fa,05OR2I\1c^dQW\QW.)/3KBK)ZZRM40NF?8+5WJ;e:3>J],8KX
WXE06T,,4eIXBNLKLG<R3L>4[gH5G5=EH3fO)E\56Ncd6RN0B#HS79.G\/0@.IQN
X[2@E+SN#3(.K205^ETJG=Q81]7H3/H78HVY0f_WE?B;P9V9+c/]ceH\A]OMY+)\
GKFMFZ,&VaKTTH?;;.N+Ja8Y^^a#(@Ng30]P_7Y3_A.2H#4(W_\:c6d26UJ[dZ@Q
5Ze;NO:G/-cI]AO:52df\a-=0CYZ^a2OGC[N\++Z.f[If8Qb+<66P_FP[?[d>17@
@=[,M:;&e&QP_CHQV?T8-5VUMGL6P;)I.cO0S4XSD@YXdBTERUVG^b&_[U1FN@/R
/,#aD_L,I,17BeQWZ&96\EDXaZ[B656#HgB:SfWNT@_THU00;5K59=_X=V=FeaWM
EK6]&D7:=J.3]70W-@^B3?cK2/:gUJN^.0CJ448gG(5aM+_T:e^2TE1;5e18N,@^
U)UUaA,+/(K>OXHAFR0,#(c4Q4AFC>=a;g=U_MFHX2CVX9HX@d;fB0VYZ7QZMd._
6(<FH;@/T+YE4W^Z[<J2a<,8G6AYC[3F_?g#HV5M3gG/b2V;DW5D=)(5fPO8HM93
f/YX:TJBM9HMN#@H13/V#-McGATCUWY1&LQ)HBdf/a0)cTXY7;[^7ZcR^RAW7W/=
@NDNYGF@9/b>532ZI.Bbf3@#-^X:_=235Pd8,;TE<ICX[TY89YC3,B[Y7X,/@d6?
49HI(SKdagQ4L3c0YV99>;\21gAae1KC[H68X2PG+F8V3c0Z0-@gf;LgZ;dGf>RZ
0/.YY\>IbT&0:54bL#VYX0JaQP9QKRN(6XG_&e_;?;7V]:?F]cN&FK&D(K<<;RR)
O.&>d<bV,DPL_9.XLZ=5Q)TK,[S]M&RFD44I^^K0+aC83L6KYDS[^J&QV#d&8aTT
&N:\1BOT_QXAegEIU?@K5&I\cJJO\RR89TI<4Fd;@N(U()R]J7R[?EFVFH66HIa#
:8,+U;;I13G,K8LN.P)?4Z3WJaO]HTdfK#+a1.(S5JaRS)ddFaQ/(BYCG/a0G7^c
?/AE3Vf_^/JCM+d^LH,3&[&@5A0HK[:CE&G?&:YE5XZQ5]6FPDb79gVa+VNePOT:
Rf_ALHISI1W+\^PM77=L,3>)C<T+IA.>C=,MB=+\JV#5ac&+G.S[\9c,RRI4HgL.
0Q=)<&#_:I,bP-JRa<fJX&O@7?bB.191M7N.XHc0HT=9,VMb+d0ZH_fg1bC-&/g(
2EYX=)d=Q19-cCPMTe;6W49?::0XF7X=8#)T=5J,Y=UgR@a\]_>a47Hb36/:+L3b
6??O8CZAbJ=__V8T.:X\E)efbS<HT6/2O@)W;Y.dA3K7aB3B>Z;.POP5W#^R<RP1
\PYG_6#g<7Z9.#DCC\/XfZG_]^UIfccK,Nd3U6TX4f]YC,FPKDLOFO@SG:)#_TeS
W(IT@1[=S>[+PcA1IHX-FdSG,gf^:[)/Ff,BP-DG8/J.MN4-,?;c).daTdG3C(Mg
/1U^.Z/_bEXNY5ba)c-+[6c:10[?]WG]eVYBBB^eeTe<9dX]3#NKgUPgAD-:&-2\
HUPEcMP<3FF2C;6fX8<F7@R]\7eU2Z8+0#,\L8^VE/,\V&4](^@D:7f+,VGFEEc>
L8+<96#\\+OYcaWP\29gdHAX.C4f:B;;<b&:<V&KOCT6X/R@+ZB?E]b+<eS<3]FS
\20A6&bUU7C6^LHbHg?Y.N;=a-RQ,E,XP@V>XZ4)c-YXTc9[CJ9g9U=GcXWZ&C:A
]#Y,2@eN,PV?5bE)c99BG9&LV<?YN+<6],K]0e79cTPJ-[C@:&+QRX<#3LdPXTAI
^>^>[IR-7AZWYSPc;\GI=+^:c<T\Q1EeegFTJ+;5Xc07gga5=U[:bD^BMC[8]-6B
87(1JIbcd#I+;-(R4^I9C4gG>7-H69@d(@FOKHE00JBa<HS=I@:/c><_#[3e\?Wb
2F6#5R@@DZR_/ZU-J-PX#,C?,;[OZKIfd@0;.47f(OSPWX[G&DWQNaf89fW]?.)J
U@J]ebMcI=IS]cM/,68IVP5)fG/eX<W<\:^e9M\&G-\<eHfTTZEIO8WTMRKLFTQ1
J31fgT[a><=aQT:gV=WgO)+:9@;7Kg-gWBgV8Ndc;^?/e^A265a=L3MPVdAXY+:g
@b/@<[KIY;La]<?</I14O]C<E<aJ<;MUHD[/1\3,H^D4CQ-7XJ8?=@1Gfd1JbI2H
09cgP@<Ig-L7McMBcEKJ(,4efb7AJB4?/V=7Mc0a6-^A_-_.3RM/Y0aPECQ.542N
]I<D.]XN3eD)agXLc(7\;Z>PF==7Sd/G8/,(LLb.AM2WTSW4^.,Q(DO+M.b2=&U\
6]A(d]SI7YY5D#E-gW+^bN(EbAb@7YW/XeTe+JUI#_0\&8J<.B:IIIaLG61TM@0]
eK]b;aQDJRVKWeIUR:6P?cHVX0+U]VN7[0.=+E&PKLQB[LA_I6aTHZI2S6[.#\T#
O2W_?UQ2ZgHMJ0YG#?PX-FN[RGLefH[.+\4\&bWM82ee:.<,FPU;7bCG;NEA+S<9
CP)>5_QLEMaNM@A8aM<I\4=L<KB]KKRL:#T37KQQ?Z-WC2GJ:,H7SXJW5(2D9H8]
YA,C#).]C?@gdVU6OcTO2Lec8EeS<b9F,XDA#9ES28:.F4PA^B4X@aKWJSQAH+fD
A0R^OcHa>SMZ<Ob0QW5A^ZLW_aENA<(:9J<O^-@UE4GVgJ9#N@/d>^UL3g^QN>N(
7&\bX_[)N&2QC?91KOdTLEa;-Ua55f.AY.089=8@UNFCJ(YEQa88YX;7,^CZd_cA
@I9(\=V^XLK3Q)eIF8>b3>.?X.,QM6OfH30.Q?e(N_NZ(YIV2=V;Fc[.WH+YI^8d
Z/6S;f&<)&CFC@^B3)^B+Q\VfD84\2)RdVWX^9ISNN]eHP?8?:B9gA6^E?<LS<X)
9PCJFD>:0C:6G[=TWV,O)EJ+GR,)RL6+OPBV\;+bTJP]J@]f?@M>a=a5;M9#&6P:
2-SQBDJbU>VJXWaKZ2RHN5Ue<_/#=(b[?g[D,eKaX]_[CQK[M\H,3,=NLF3Wd]b,
GUfPBO3F7d\28bY4G-1ICRBTc0Te-X7[A.@6^8(SYMc1+_.b5AeGI.gR;a-99=NE
[PODO_Cg6TR3[ZDNS0M?Vg+(+@<8-=?6[:?Y=Ag=_Jd2I]U&A,=@^2U;YOZg2FCP
E<>AaI7V];c,-IgU[1cSK7(\DM;H_+@OHLbc.N2QE8<_2-H-^aUe_>4:,a,0#Q>g
9M)9<d_d_Fd]c32:OSSM/\P:+^?>gTFML[a).e8<TB&BS#He&;YXd88^L<;D+Z>6
12\17)U381BL_DHf-,U0ga>UK&?LDAO7N2c>DQ)IP>KdTQ7M7ND=R=J7H>0-0K3R
<L8>X:;.A#@P3L<6_&=H\AY?cR3X.EUJR::+C<G-:XAVW5&\cJZ=KI3Y&R+\Q^;0
GK\QMB--bM&DX/>Rff5\M_\)IG41O>L.H4K@C(QU?.=\&gS4.e\AbY^H.Bd8M4/#
YAF<V&+/;S/892QAA#MR6Z1&J8EfPI\56M,U\d0P(FM^5EG8?B0JYb7V5K],X>BA
/fR+)4_/1XPEd:aU4W(,3KJA[(>V3(>B4K=90KTP\ZJZ(>OcK,]\B9]Z)@gAT6]>
:U+e;_6@H?Q(18e9@Q/bCE?0fIS#S6CK-5QN?ODF<I=A0&R\8F@E_R\2RMTeL->F
>FK9OScH>Ce_=)@UYS?AR#4CF-W)a?UG7,F(R[F00QD3/Tfd61-#V:V>g#,S0FMK
?I_.J6A[8GV9cV6IJAZZ@76_;]d0LdNDdEbCSVK2F[J<C^F)4b29/G1MC,34G4&9
\a7)[IX04gUIM;U]fU2H#;fV\Nf_04K[QJ2EW/TLE]c#_YJPJJ+S?O2:C1O6\:QD
R3[?SBc?g0,H-O.@DHb0a,)IaW3fg:-/MaD+f_O(IYb>9f8/IAg(R.gS&AOCfIAT
.5S[PS)?70NHDHgS(9e6V[X9aZe.&e8A-,1J=RD<2,11,(+/G^N?ZD)H.6gHV<b:
FC?bC(g8\]0\E[NaNTWWU9EeNQH?F\T<AY:dNA#g)Tca3:-X7RgZWJdDR.[;I16T
(46]E=\JUX&/.FWUPVP0=+YM:2cG0/gI>ddEF>DU/J5SF[3>g^N@(IH+3:::Pbc5
4PC;-(dRRONO;C9NRa=HRJ&6XDN/MU+:P_3Q?=UAV8MW=Q&_>RL:6(<).+\#F3I;
>^7^38;3<D]JXfML:>,/aGH(R@^LK;T\H>)9W;<^:OGQV/MRU.7Z_Rc8[Pg.6?(:
M&#;XJ]S(0M(1#13PP?^WBAZ745HO;QTG;X6F_<GUdE=??39N\PNe^>^/aX<c>QO
IgVC&P[Rgb/_Y#^F3-&<HgJOYE_<)J8/O@>a@=BYgXG:>Y/b&e[9)KdCSaV&?b9#
>8L1;S)@db]D.[.0R#5eBW3KAOXMCd](42G7IRM;X.AdXeb6=WEH<ML13F4PP@Q(
1\,O^CGgA.5-H^],Y&Mc9Vfb)Xe&FVP-eWMJ9b[P\,_8V/89a.136UOegY30UOFa
EBJX_>UAL&+7dRE[Gg.3/;DLBJ-0?_2SL#E1)GIXg@.6CA9B><(49N&-@QO>9((2
61O8f[QHOA?a?U;aL+_C)&Qd2D4+@d/Ia#OY.^VHdfX,dRXCYK#a(V6A,eWZ3PSV
JXLYTedEC3Ag=H.4C]?b8DZQ.QZ^I7eO396#>:TaN)8ag+;DRKeJ2U_1LQ;;&W(Q
eMJW80T+b?NJDE+(EOZP3]<L5d1dX?RU5BU//W@a;bN.J@;V#/X9CR.7\QF<>M3L
7@Q;I-:J;M-W(K3JHZ&-^GQ8SGLCR9Z>Z:9+IgGA<<S8BD)L^)..,W0&K_e-Z^F(
F3VYd0ea]:EOHg.D/Q;G_,G.O6B+V=RFZ[JR:A>AHCW#FO:<EK3b&Z5<c>4)cg;6
bXTZ>I3AMZ>XP#Y1#JPW/^G.2$
`endprotected


`endif // GUARD_SVT_LOG_FORMAT_SV
