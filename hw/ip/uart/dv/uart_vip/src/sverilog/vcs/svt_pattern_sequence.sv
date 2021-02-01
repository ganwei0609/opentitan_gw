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

`ifndef GUARD_SVT_PATTERN_SEQUENCE_SV
`define GUARD_SVT_PATTERN_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object that stores a pattern sequence as an array of patterns. This object also provides
 * basic methods for using these array patterns to find pattern sequences in `SVT_DATA_TYPE lists.
 *
 * The match_sequence() and wait_for_match() methods supported by svt_pattern_sequence
 * can be used to match the pattern against any set of `SVT_DATA_TYPE instances, simply by providing an iterator
 * which can scan the set of `SVT_DATA_TYPE instances.
 */
class svt_pattern_sequence;

  // ****************************************************************************
  // Private Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log shared_log = new ( "svt_pattern_sequence", "class" );
`else
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) shared_reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_pattern_sequence.class");
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Log||Reporter instance may be passed in via constructor. 
   */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_log log;
`else
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Patterns which make up the pattern sequence. Each pattern consists of multiple
   * name/value pairs.
   */
  svt_pattern pttrn[];

  /** Identifier associated with this pattern sequence */
  int pttrn_seq_id = -1;

  /** Name associated with this pattern sequence */
  string pttrn_name = "";

  /**
   * Indicates if the svt_pattern_sequence is a subsequence and that the
   * match_sequence() and wait_for_match() calls should therefore limit their actions
   * based on being a subsequence. This includs skipping the detail_match. External
   * clients should set this to 0 to insure normal match_sequence execution.
   */
  bit is_subsequence = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_sequence class.
   *
   * @param pttrn_seq_id Identifier associated with this pattern sequence.
   *
   * @param pttrn_cnt Number of patterns that will be placed in the pattern sequence.
   *
   * @param pttrn_name Name associated with this pattern sequence.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", vmm_log log = null);
`else
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", `SVT_XVM(report_object) reporter = null);
`endif

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
   * @return Returns a newly allocated svt_pattern_sequence instance.
   */
  extern virtual function svt_pattern_sequence allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern_sequence object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern_sequence copy(svt_pattern_sequence to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Resizes the pattern array as indicated, loading up the pattern array with
   * svt_pattern instances.
   *
   * @param new_size Number of patterns to include in the array.
   */
  extern virtual function void safe_resize(int new_size);

  // ---------------------------------------------------------------------------
  /**
   * Copies the sequence of patterns into the provided svt_pattern_sequence.
   *
   * @param to svt_pattern_sequence that the pttrn is copied to.
   *
   * @param first_ix The index at which the copy is to start. Defaults to 0
   * indicating that the copy should start with the first pttrn array element.
   *
   * @param limit_ix The first index AFTER the last element to be copied. Defaults
   * to -1 indicating that the copy should go from first_ix to the end of the
   * current pttrn array.
   */
  extern virtual function void copy_patterns(svt_pattern_sequence to, int first_ix = 0, int limit_ix = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the indicated pattern.
   *
   * @param pttrn_ix Pattern which is to get the new name/value pair.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern virtual function void add_prop(int pttrn_ix, string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is complete
   * and that it can be fully accessed via the iterator `SVT_DATA_ITER_TYPE::next() method.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next match_sequence() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual function void match_sequence(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is still being 
   * generated and that it must rely on the `SVT_DATA_ITER_TYPE::wait_for_next() method
   * to recognize when additional data is available to continue the match.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next wait_for_match() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual task wait_for_match(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method called at the end of the match_sequence() and wait_for_match() pattern match
   * to do additional checks of the original data_match. Can be used by an extended class
   * to impose additional requirements above and beyond the basic pattern match requirements. 
   *
   * @param data_match Queue which includes the data objects that made up the pattern match.
   */
  extern virtual function bit detail_match(`SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for creating a pattern sub-sequence.
   *
   * @param first_pttrn_ix Position where the sub-sequence is to start.
   */
  extern virtual protected function svt_pattern_sequence setup_pattern_sub_sequence(int first_pttrn_ix);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to check for a full sequence match.
   *
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void check_full_match(`SVT_DATA_TYPE data_match[$], int pttrn_ix, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to evaluate whether the previous match against a sub-sequence was successful.
   *
   * @param data_match The current matching data.
   * @param curr_data The current data we are reviewing for a match.
   * @param data_sub_match The data matched within the sub-sequence.
   * @param pttrn_ix The position of the current match.
   */
  extern virtual protected function void process_sub_match(ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, input `SVT_DATA_TYPE curr_data, input `SVT_DATA_TYPE data_sub_match[$]); 

  // ---------------------------------------------------------------------------
  /**
   * Utility method to set things up for a match restart.
   *
   * @param data_iter Iterator that is being used to do the overall scan in search of the pattern sequence.
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param pttrn_match_cnt The patterns within the pattern sequence that have been matched thus far.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void setup_match_restart(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, ref int pttrn_match_cnt, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to get a unique identifier string for the pattern sequence.
   */
  extern virtual protected function string get_pttrn_seq_uniq_id();

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
YCYeBaZ1EV,_AHAYO\B6_VS>fN#GJ5AAU]5\3DI/:C5,PT&)G(,M1(-c)=a<BJNf
cG0&IROfC.KQ=?5BBaSRT._0KMLZ.G6MOX,N+V;IP(U8U1&A@W,,FG)I<b2b0ebM
&Z+<W^fBUG[0^+,(a^XZR[K]PEZCR#D#;LZ-0#37d=N.(0)4#06a#U:S=A@9T?XV
cfcggMd]AgB^[Ud4U:-ANQ]47QF]=,(X9c&4/2O/D?S-+aVG1FK@^NAI9]Z@K+0G
?D_K3MI\A2b2&T&&KVdd;Sf[R4-_:3R&C6D?,K8B-;Z9Re\32DcaV+P8<3E5E^c2
N/7@SLR\R;DbYMeE+RKQ6#G-,K-.CT\YY[e0WI@EZG_)\N7eG/b.d-@f,?ZJ^#14
T@?aE:EG?9J543,=g^7>:]&-H.cR:UHD6D_6@L=2=P2RXLB;\63<)1AY1#6@V3bE
aCAZK\+)2KUI:+V14K5[A3M>?Z.5e;df]34H]GNI6GPU0EG\B#<S@:cCP81ITIZ.
a\8H8G:#/GdON@,F.?@KL3&;>fTS#5I[gJ5]@N#X(UfH;X[Db]Q?0JUC7M[:0eM+
12QD?8TYDN7Y>CZ4^CUcZLYU3M]5:E#TTc4QKC2D^K;4UTK#L:aCI&g(LX0RS:R;
e5d=)PN1CAD8E0/NfYE,_FR.BYGFGU,U1.@C?R_OWS]N1GDI.N(?d9K_)KbgLPK)
CGC(J@b&a.1\G9f\Q,&4,dJXW8NH8&TaaTXL.(:8b<6,C9f>-L?<f8ae6(T7E<?P
FNGL.cZ2dPLVOC).6K##AeU0IV8Z\:(g[HU,K.J9,:AZC^-e_G9.X8,59>3NR7?d
Q#0TP]_@QWA.=fJX6^EV+[R8N/RXOL<62TU>^5/9<UaP]L5g7IM9[Ea3^/65gdUO
N?5D26>b&&2-X[79\Oa\5VS0A)4H\WX^H-_1M:/G#Q=B]+MQ7/8C]>g,/dAAY:22
b-M<6,SX=afDLQ26d2+R+_M=Z)7T>7Ld=L(9E5aIYN?S>E?FY/XY;_IBU:fM-4/#
LVV9RfcI#c?/Ug.O;)#X@=)24dGF5P[B7f]E8,<UgR^>]KHINV4C22/=]NK_/-HP
^f(WD2=(#;/1>6\Y_JEg\&)1FLFE)[d..;gL=\J,_SQW+)=R&g8dU?E>5.=;;\EJ
A+2-JgID9e1@D/:\CG#</7<8g7\>DR-I)P0C[4AAGbIK[ADCSL34Ma69V\ZR^fB/
?1=88(F0ENFF-9/O._Q:;)bY\/@0S-I9RP?L?CBPd>NG<eLFIIR8V5>XTOBXCW9@
<L)4A=5E66cBKQdEL;>#K7RFe=bTT_\V,#)N#:UT?A4.DR_#D:XZK<\7Fa8DQ?]d
5VXU-;IEcR#D#\BJc>b7;Y2Tg>7O-?R,(:E>G^5-Q?:\8X>+c\GVgfc4fEHMK2)c
UgDe(KE.V2R.A\;_GO7O9.BF.X,]ZK02MTU-a7&L9]_Z^C)CQdb9Td5[U5043J^8
Ze&.[<#JD#NUUdD@;@LXF-b9#W]<b0A5G]]>QbI5B-NF6,JP#=bBV?=]@Y.(&8g\
^S&@dRYDH,G)?QD9.J9UF8T\M5=POQ(PUXB9E>3;_U5P<;B-JX4:^2&G8;9+]R\;
HSKOe<2a3cG1?TCC/B3P7^OD;I7@S.OT40@c,6.>RZ_?^CG@aJJD[d<&/)c.2?[I
Q3E2#Y[RE)]6KDBM>dP=MZ==<57:4E/X.>R\FO7ZZSa0[g4TbBKdPQ8JD^1&5;A<
P>IJ&O\&4EbF<FSe=BUBWJO^.O/RV1,I1]dFN,2ER9N1X5K:TDM4-SA0\X>B<.RI
U(UdE\B(<(O@((L:W#(Z3b<L31b,QXD_d&VN=/PT:^W^Tb9ba@@D8QW+&<cO@gM.
6MZd(AWK;4gOP2fG:K#X/#J#4;[&1<M447MHEaa\#MS&eSD<C5H2dM;:HM98@XBb
fOZ+gLf><]AJVQVW5bA_:ZUO=f+F=XFY?:fPNb2N=#1]:bZ^[F<F.,,;L]\(gTaH
V^+&0CRgP[V+1<P^O)c]Q.D5;.YdaHJ\@673fZ52=.d=LRA[:@]c[OK7<,\+VGF9
UK-4g.YcJM150N\0d]^PVH=;?6eX+.dM)dODJ<e&@^[.80d+D)@a9f[__LQF?XOL
L7JKI,0BOLN&.9(6]N9HUTR,E,Hd<Lg3deSZ452PK9[,EG4(A9A[1#M3T[<B..TS
SdF>+H42g2aBLH3+<MQA1<^OgDePZ]&b?A/0Q(ST3(,Qg,NO3ABVc_KD./Hd,6ZJ
[9Q@#<47?J-.J:PQ;ZM>\M<5KFJ16:7dGb.3>GC<O1LY(XbV&Zf9.C1=3.a6YLH6
J2_EgNdO/D]6V]LCdZ8R=.[/9f(HLK)f@Kga<cMC<:B5BFZ,0@1,=,YUV/B&3.T)
/=4@ZQO=1b/;&RKW#HI39Zc?5aYSQgg1bdV,BV9ZPEe6=ZMd\BD^H;?E7Fc=GYEZ
/.GCX<]WPP<NKKPW?JE\5QB^a80d+dZ9T;<4A?3[L<L#CLU2JcQF;4,CI?[Y;=Nd
f<DK;BGCOa42e:^.X]dedcXDGM@_<fHR_Vb97;3UI&JV,2[]Q+#V2?1E95+NRg8F
dZKf>N@IN:]d60@0[5MgV@&.]R6P&5A8H.<H@3&bTCO0#3QP1CLG-KDfM;\AB@D/
AHA2\\.3,#P4=4GGF7\.NKJ,<B.\D6Ac5e2)(#:M@ACE/AH=GE_b53b5>JeJBaIJ
O\MVfX]MTQSOWEGRN]JFOHL&^dOLFB;_,aa1SPEg>:53#VZRE>O9?(7C&_R@bKR@
Q.RP0LbI&F??c3G(;HA.I(00[g\=;J??^Y^+Y.=F]22BYY&P^B8.&EPRXfIBQ-+6
>5,:DKJRH.8&;QMO>AH29R=faZ2Y-8O<Y.M93UFb7<4=Ge1.<FRD+S\)86^:7Y,A
^/W2/XE##7T1c_dE__aVSVbKI94Q8a[MW?1\(W,_L#@]TFN)B6(2&C7VfVfF;8<6
>c;</#TTRef=T-@JZZ&5<D4WD4S6c&g8)=G3Obe[,45#;ePT&e5Z1D[fCTY\[[Td
-Y7eMG:ETM?WSZMaE)ZK+/,7D@NK#:),-4D9W):QH7If2:/@Ogb,842RS\[O#<-2
#O-0;e1J;L_cCcJQVXS?#eIdeCR,9#L=1R0C1NCQ/I6e;)7<E01,IHH[3#Y[/b20
E^A2;]D0Q6cLA+eY5BUXH@dW.&;X5HA7O6P@[K]B2@Z3M1>c\C,)=)FEG#&>/.\Z
db3N2aEB(J7/VZ5+.,cFXTB<N0WG3ZIQ_X6=4Q<Ff^A[90DJ:8+4=J0a1H,HY622
+TDb=3HXEHe\DJa^;EF:Nc?XYa6W:Vg^87,dS6[JH=&?T4:=JV&.JA(d(0HU_F,N
T\1&\[(S^K)OQ81\:fWb.#6<@cd^Y>f<(M00OGYTB-8XR<9NEC+XdN)U]K>VgeGS
:bHJ8cD[c3O:A9.RI6e,?39^9Rc4Z=&,>H6V20B?NE:QZ2.Ad@I]QR;X>IR.(8)8
:CDDc))SS08@-/F<7f,;G8(=RS4W?8@7VLM.#I4[4g#eCC@Q4?^<V?8+5TMTZXa[
\IZ(/GdcR#SB7^I&1J2aE:MLUgfO5U?)-KSS7R]H;RU[[aJ.BOK..-(NHRB[D=,Z
4?^CAWK4gH;dfREU>GLb]F[2&@[R#CS_@IaF7.[51[dJ]@f<L.>ERGSA8UNCU6<B
]V?0CNC=LN9526Q^74f34Sd,TA[W=F(3?DR:HU8#58T2EWF[Ia-/Ze;H\6EWQZ<Z
#=g.M#ZY_+<0HTE/R>Qaa983Y;MScJUg.A2=;7P(,J+N7?d1,1-8:K.+#[B3PKY9
PP87O[FZB1VJM<X)MW]BN?T)_732HDJUTA[OS3FcR1HeQC;cHQCfGM3d--LMW7O5
e7[I=3-<\X4GN[=NXd/R2R5-R9[M?18CPR,0W0F.a/TB,2(@/DbBS0bPFaF<301e
57,5Z:Y@dXH#bK],Q#85O5CI,PgNMGLZ\DaZ<5P@#ON)_W03&6.VaD9JYC;E3JaF
KBS=UdPLEW78bZbDK3[8\^+34)+=X.MCK8\P\WTOXV<,bY&]]D0_\<D:XQf=06-(
B>S:5QXdQIAFCYd9_Y#PO?ZEd#0S2O)8fGc80d5Ma.M?4O(7QU)JZKdfHTJA3Jb/
(@R8K;^W^8cY<e#=GL5ME(],>I6Q-O2HQV1e:</)QKcea&S\L3BN1D)9J5]>aRM2
X?_Nd@cAE;<YLD_.R0ZHD<a9,<6BHP.;UR2957Z7O66PQb:NK6;X6FPR;@H(U4<L
^D)ED[&6<D,_SF_:[(MfYJ@U#D/(Y:LF9e5/I58/ff;=/7N,V<1TC4QX[H9bQ1cZ
(Tdg0d.KMH8YAg?/A.X@b>3a\;2ZF8B_4&QNMV7Da+Q9=J6[SS1@NW@K_E9[dC8c
:7^RDVR#c?gUVgYb>4-Gc^H2M:X[L(LBacHYgL<PF4C<PI(;B^gcB6NIV);<P9.T
A_8/8^Z1S[/UE;eJPUERf((;>8>UCS5fJ<ggY[/6-DL>MeaE4<8V<V[Z_-@E,\RS
?H;&K:INJC^ZVXYL\QZbPZbRN7OF[H:HKUT;aOLPMDJ<Q?8[G]40_NaQ[,(>XO7=
(LX)LU?ZY-^I5\ZeY0R3<Qg4Gc16[1dOIP)G5#O,(a&@92b#e^XNO:2/1L=Fd#,<
d0\^/LMcW)WSM0&A6W1T)R8-5F-A&=H_C&Y^)_[DNG)8/8AO>eA>C.RM,YY(D.=a
H;&J>EBOI\]J>(VA;JbDaS(e26Qg;FPJ[PJ&S4V6;LO?=N:B-98LD3/UTHQ8HX79
RR\3KdW9W):TKW@[;dLQ6MYPJ.Q1f@Jg5<[d+8<1R<(>6(<,SZXCJB5P,F2;Z0P+
:X46G:+UV5452;?5@ZNF2AaJKCT\BA#PU-(JGSWGB).=e-YUQ=<A8-(^Q]c;>IUB
GA;gVV@<R0@@@aNPH3<KKM09.DbP<,,E_08TZX;DH@N+\#NGB)&9:\(^L10,W()8
ARc:WS(?ET#U-afZIR?>__R6b&?TO2SO8=;Z,.R4SCUP[1XPQ4JQS4J4\#+]61=/
MS?egM42K6VFSPS(7[3/aMM9_:6I9bS26/2GJ^7_FL\1PA1=47E->I25)LI-GF^J
1g0aBeP5E91L?(2?JgP0MG2U;H/:bID;3W<HXdP\Q=ge?/6;cYX)g@>Y#E\#:KJ=
I#Y^O\L=b)e_\Tf8:E3(--=\+3#&K4[>F>RB\2YE:7^M_YQ?^B/)V@VU[]-.J026
^R=CaOC:Y]Db#ANWC@-E\b3G-eQKefSgf]4XA4)C;1=.;<bHN,K.c??[U_W,0N+#
\]@7FNaeaD+LOJfK7)O@/)PTQ:[ZH:4W1aP?K?K++3:#^-]_ZOM6^fa+_;cT.eb0
X6]BGPad/NLgZW^VX1ZY(/D\b96@PY&<)fI]04f8ZBC/fCgWRPT]gB</UFDC0@g[
O+ZJRKU@>K34VO)9_#1UOU,d2Z<[5\d_eS22+VJe0U5Y)(GN:KdRc<O6X,2)\ZDe
A,-F.NUEGFA,Y6ZD0MZ,P3(6MWPB#YIF5KdG2-Zf=8[^+?^aKfG5=.TgOd<J&838
Y(7<AF4F^g:W?17F@+&dY4CcN51]4e1g5T=PX<)#6aJIRWT-;S405^HdUQ4?1.9C
WS5^_/#H)C@71@3;A7gdC&0I;F;Zb;P7G-(<T<:Yg,3A??>1]8LOWF<D9MA;V0NQ
];@g#D/I^3\SbP)-6Y>,\]C3XF5#Zg[GId^4C)W2.?SVC7ebaHSU5[/I4H:(G-JW
N0;>:S)S2:157,ae55IS]/_b,9O6=1QRZ<2AQRPJSG?)RL=7RB)X&f=1cR?:TUGP
-:0DfH3<.eWZ7;E7@MCf1D1_8DLYS@[GEH>X0V&0+E(MPW5fV,<>IV[,BPe/7+JI
SU,R-P^f/H-U746LMR(PM9fH]Ha#VKe9Sg3X7.f@LZLBT@F2V[aYVJ;Pf:66:aQ(
:6gOY++dJ)#UF6-XL@gf4Z>=5ZUb#cF:,-A8RH\>X#@2AU>Dd@eg..bd<V1/U]5W
-L\Eg;^&HVa;@N55LS[-c.T?BXUJD)eU;&N6JX)=MD);b,^gQ:SO9dW2G4CMcZ>&
6d;Ae7I7E]M.g?Ff<1MZ#?V16-?HFF<TVNe&WQK\-\a^?BEI3^U.GYN_dCcRBN8>
:H+.SGA;030M]I#=[1MgSRff.F)=T^&7H.:XRF<Da<;<;;HQ=+SPeG26c;fBCS_X
U\8gXY7c&dSO050X&/0.fIeXTgE(/^B054=Q:L6]_96A.EDg.PTUffQ\6Cb+?6e^
&b;B<E#Q#Vg4WV8^PIY&-9PUV3IMAOYC/#5-gG;)&KK<(P.6Lf#L1cD4IAb&U?7#
@D(+_I&JINa9N3?W<LaLXV0fTYeRfWO]UR1);7e2R:;@T;UDP@[9G>A)0K^Wc#W1
U(E@U0YE+:V7Pfg9@0==bBUVZd5RO^VfDaYCc\;2UN)_cCfZ?+4Yf:XK]9QO=(9J
>=0G@Xgb9QP@:M&-#0U#.JTM\1K=+.QP3N=^BX-)>8+bK6V2V-3T7]LgcC)9QM/6
\Z]-(cgT7gY4aI>=L9\]:K8RBOE7J9dW4AI<Ee9Q^L]g87B2U4<2+S,Zf:BLab7e
?J(UKEL-\a1&;8[\O[SVO7b<deQ.0@e>5bMXb3STT.81<054DYIJU_:([Jg.BEK[
UX[O0BLaf9W:#MN_@8ZOQ/O)S/5B9>^_#HOVCDW)1&I-g(+He3^+7e;?(X;DTVXS
=H\e.[;bFTE9+[DAFGOI=>(TM.;0,)EMRO)V2PL->42Ud1>GH)/,?JdP,dH1IBD2
GGE@]H3:WO)cZ=M3PbR/8I,;dAJG&BS#KJ_[+f1]K4Q527\Q;@KB\UfJV./9,adb
KaX)\1UWbJ.VBU53HL]TCQ3T)0WIV)]^3D22e/N?eb:cP2U@DTcY=c_0>P7R,9Z(
NB?Tecb9:X2^C,08Nd:BT&7FW257MWCU;#._)Y9+UEbJ/TA8>#bA+\c00ETdBGR2
(BAR^^3^ABBJB21TTP\P&&7_DZ7XH5fe,0O==Hg:2<aPV_64;M&+G&M-W:BAU1gc
87&[J&P\7^b;5Hc80O60V#M[98B<(+d8[6KX\T5@&(?)[G4T3f#;5B41FHNW:9F<
^+T[-^042^=Wf@5aMOF^F#<01_ageC0eB&0\LY)AFMUG1#]&HaVFF^9N=\8dEA?-
8/D5OKW>Q,T[(caIH)5CZRONDPeO]7>EX,EZYLPS6<Xe90I9:IJ<&(ASVd1TX4FB
U+&CH?NNP(TFD@Gg\73QSITU5VL#3[TTfaec/Zd^PXE@7KL1_/<S,4X^c/@(TD=/
MDG4]_4:]3^14?:P4a#.U-1352K^RXR(?c_G/_<VUCX.TfY;fWH2-G6US<c25BA[
#e#g8X^@_F>[#/2,=.f^VCe;#B>+<S^dF30fC)TQ5DH0YHfTK[fF<fMZCX.O4eAJ
TMeG5aV>2fA7--LFNbZ[VV3aFXV8LY,>E)^.S13-,2OHMd=VGODEVa--D.N?7ZgY
DY8+.V27&D19Q;TZV=#f7e8\3[Z^:0@KGU&BW5\<8UM>d<D8:;3++E_/98FGc^MZ
2CNFKXS444DM31+6XMB=#XIdge?J>bY[6HcORXD2d^<5b+cWcG1-@J_^=,-,_:?P
889^#31SNRB)Z&@,gb/LFf\HL.F\O27Bb#cC-?]>3K3[,?9c_HSa_ZTXN/-4IA>?
]R]Fa07(WfXD::BA])MC79CgLC+PE</I(C6Y-LKGSdV+@QbBX?24<8;JgTXBHA/X
c#]g@Y9ZLHPF7BH5]cK-b926O#C67a;D=-5g8Af>VWNJJNe57Y)f32>c3]2XB8^L
X8_(3;Y6/:KM+^BT-9N.PSX^H[F#T2-KOZNHPU_0=e0I^A#7LE\=,5NUS,@4>.Bg
DQ@g(]PDML1IVcGKcTBc)e61)]>4:b/Nb<FCU_d2B-Q<8(aD=L23VGF_1M2Be2L&
UFGb2#KCg]EJ/IBO1LA/2gUb55cYS/B/?6.5A6QO4-0aHV79)S+XK5AR2:Lf@HO>
P,;1DD=&:M1&e;CCN,U(WZ34Yd=F#76G>FcVaIFW9)T270b?N;aH.HJ5]@(>aLB3
(L<J0QOKK+)UU?C_>2VV0fVbXT0P9dI1L>e1F(:]S?0T2-RX3(,c:Ua6.R=67;<T
12>>(B^(D2(Q=GUBA:YfL,P1MBV\P49Vg#VVb#)ALdgeYN;EG<NbBNf7ET5OZZ)N
+\RR8&A:EX3Gf2@[\Md2gN^D/8B.SD<Y1F)Z,/X9[RLF@eIcK-<64Ca19e,578f?
cNf?dC8:JYN#_0V.3HU3fPfFK]Xed#-XM7]W8]5E5:aAZ>;g],6eK-3d29Z-a5e\
(<b.fY=ce/EIgN[WKX4WDeXg,UGBIO?2EfE2&2LT:aeKOHK>?9/OD+[_[TL/@\c5
,]X4K>-[e/ZafR3\U/Q2HU-I>c&](M6_6/]J=b./Gd(/Ib-5ZH6&dC3,6[&V_#/M
S@;G+bWQ]?WaX.@BDc?S0,HE46f.CXAWNP.M/TUO#W(,X#QYB4#3&2WP3<Oad(f1
K25(5XJ31=M+P[D;&cSI&O=[_A]Tg&C@a[_V/bKO4/3VGI5MP4Qc9WT4JX&R&;^g
I)IU@H0L:8T/b6gcFN2JS^ZWCbd.]g,^(RU-36dN0^9M61:17DKY3;N&J(gGXI18
WYGVH6YeV[X[)O33WY3169[;GBfCf<G@^,Ca#13cXSO;XYT5c279T=G6AdgMFMZ.
a+[D5)WR@@g]LbN0]NbMf4X&]1<D,T<_:CF7e<>-<C36SVV7[>2aD4IRJ/ADY+X@
aIB;4V2.?J)=9NaBU&N1^=4S<0S52<+EbIJ.@Sa^JG(41T\f30]AGSCA98\)Z@EZ
-#[TPR-GA92(\S\RC7Ff],?CEN/GCR/TFG9^UcFF/0@I4^QfS^CUc+[),U]Q.;V[
<(&R3#4ZB@G+NM+9a([9Q<R069gJXc4>(S?.G#>8TQDAVVU9aa#Y7R,ecWXcF;30
(OKUdYGA3U=6Td\MC;-eYM30/2^3TOb+VK?3SH@DI):V;J.X^)KWE:M9,H(Q,QO:
@=b6NIIF(1=IP@PNA;/ZNDJF12[2(<7:3dT:6K(M.+?;9d]H0PB(^Q1LY;?HD7P=
LaG\_^_2?a12,:KPb[:PF.J^HOV[\PQH\J2_g^JU,]&83d7D3SQKS(a(:&CXT8/K
aX/ZcW95(ED/G1;VH4Ub)YW6aS^gTA.Gc:L1^=:ZG,;T:f^<KDEE7fH&2JUJ0(8X
eYA92,6LBM1Tb1NUZ,/0+@VI=MQ(&H=1UDQE.G54EFNR9?fOXI3)P7Y^228G8Y;7
)U3\NG(]L@[-4H-b.0TPg/FVAEG#e<=W\+AJ^#Va/\+\0Q//0>PI9JI+74f9Y7cX
^JIZ82(+_-_^a;\HHB)>H&#FT,0:d6aaMO:4<+Ncc.dDDRIX#2XE4S[<DXXR<?]E
4_L\]IU=4@AMe7EI_(X#a.8574eIREE(HO?cbG?+b6fc;D_+ML6>T03f\.g2g@0[
KDC/.7OKGVJ^[?FKM#0LBa>#H2CN2/_BPE)@D>JSW>B>]XR4C7;2bME-I.N+.IH>
X;EfVQC\c3^[N^\CG:I9X:<L?W^bT=<VXRY(@?6<7RQ55(D\=S>)PWHZ8cc?]FCE
gT,OM9)T:#4\2^DRZaeL;L_8S?S^[OP)ecZ;-HJH=4,MX/<.(Gg+<dR/)YWOWf2C
[?6(+UFf_)Q^_7eK:aaaUH08Nc#<]UG_AP:6R\:6MW]B53AG0Rg:[#3[@a]3ORJ0
P8@fUg71X&0&&(7gLb=K\=<4WT-1B)5\W#6?&N7&&;0fS7NGF/QdUH&L/;L6O@28
<+>5:O:F.FJI<5[HG,7H1dU-\8O]VEaK;.fV4AKbg=7XaH7WI[)&e665N2/J,@ZY
Q8?7[IH6(]0#8)c&&?\&NL\0dU4_X>MIRZ3V2)cb]\>LO<]EL_c-\=.9O(g]OD<,
D]99KUH#6GScg+b76SVP&]^f0GF;V:/fHJI7-@<dc(Mf6?)86QbYKT]>&9BaMFOD
)VA@,G6PE1cZb]RV>+0aC0-7I-[:1=Hag)58g>&Ae;QQM=5X_CY<KS[KE^NI@d0@
Dg_U98&Dbg>RX+:T87@Wg-_4W^?@HABB5Y^I@E/(:RF:DDWL>f06<5?_.NT1JZEI
YUFHaOO.8#E+Mc?]3UAZHLDR:PgPJQJ5./EH6:F_#5\=c:7KVBFa_)1[LUZU^=ZE
1+8L&P^Mg?NZ_S(^S-&)I9HQ-UN/@5.GMaV/Y5Q4MF+HUR\_;H:aYQb/dMbHg[F&
FL(XfH#.8^.(a=[19A0\Y^f=,__9Q+VBFTIF#HK.3-gVbea64I)DTF3d)J4N;-N-
/7eSC(VJ8ERX@LZM;25@R3TCN@B+8HY>2<;/f]Oe35KG94EADg<>.H-Kc_N0GL3^
T)A+U+_fG#,@O07L:\6MX88Q#>>SS.Z1C0U_-1BdUK>ZJQ8#W=.2+X:]A_-J]R;I
:\UKMPD/RF,<);J;&>5:MV9,UeRV2?e0T68MQUB18fF(=dAKLQ@fS2#40ZJ+G&J=
XdY2C2__14WS#2U4^B^bWLSe]+O]I1?:+9c9eZVB(5C(CB(UVTV-X;)\?D-=84c\
X>A0NT4e5W-ZCA)FPM>2B+W8We:OHTV7BgZf(U4>Ua1MB6f>6-(GFc&ZBg&eAF;c
.A[aQ\70fO)_gB=2[BQ;WE1&.K[@8+\.17DBP,]4,H-Q=(>^:\NW]>K:UZ>U6Q>Z
.DI8ZeNL\@WP-WcA>ZedB-c1cgC,VL:N9V2L>gD93A1B.&@#8\&,OG#C6_Vgf,Ng
,U9@MX^-6E#<2Q>QP;O\+^NK.ZO1N0,HLG3273^@@(KR-9+1Q\.6Y\H9J<_bIXb(
;7b-\7L+@W@cQEeY-W8F&H8aQFJcCFB_<S(IF)b2UgS?ISW^YN1fOKH6d+F0G;Le
RIQGGTa)C<0JTM(0/\a>ZV9/(C1BKI/T#_cU?G#XC_U(91cJ8OX1Y[W-#fZF#27A
a)7=)<>I_-V4_c.X#5:X^S/f\26&8R7QQ>#Ta[CD-J=1c9:Hc,B@[W-?\7PSe^PV
M-0UE)>E[Y5^a_A:F3W).dXE<\0_=EB[<A-:/2)T12#-E)66\,c9Ae8430d1#9b0
HK9]XfKN29J-@_/69#CUcIOf@GBKYbB,4;db7CD@L1]V.Y<(f#];,ZNTO+_+e@1f
N[?[DV)a7VBeU,-^V95dE3Yd>X3YZFc3--4^LTL+N\;#bZ[Q>R?(cVD-,e>Z.:gM
E7.O._A>5KYY8ZPbU>4J?d4HX=HFZHQ]]L6P^SD+Z](-E#a#HH7L+QCPb)^B.bDI
1f;(;L<IDLE@(2R0.bP+VSMO^PILHG]3(/\(PYfM#bPEad85244&.=KAY0ZA9D:)
<L;7:1f64=:RLcYD,J8Kb>PIY>db0:\>[(:N5d.J88O@T_<-M>&.-fSRA9,T><]F
G?#TWY2?bHCg^fAG.&6=1MXd<5L[)f>;f?&(bPQHX;eJ=^+VYX)^eF5)bJ,)1VM^
;W?\=PM:CJMYc7&L4#SWD5.K[G[,fZXU)]SBf(3C:^CJ7O:13MI&.K3?c=>2ZDI_
\S#TdC9LYFH+[a3P:?4N.]e3:7P[FeCPIQNbc/RFP+#Fc.d3#20HV3ZXLVYMf:&P
+P=f,#WL1^Z67JOO+SN/O(\Q/9VE4C[)8)J&ZRS4G9B-IF#,)@5-<B@:TRfBe:d8
<7X#dE#LRRa49O8FBP+4YHbZ:U1EHXX,\50#CQ]b4,6?T2GIS44(9QVCN<C)>3(0
#Q/5B6NCB,L4U=T<_&8VGC;,g2^edQ)4IYVAXO6[)=?2@aJG/(Z1/#AMU:(dIJA)
2b/O&M^N:LA70Ug.2bLQe<Q?/M1\CC:#J+8#]#aB;=gF)g\bcBED:N\>cfORW>EI
W&bIM=aD>NT2[U30.2O14]1GE/N4D_DJ@=:gBQcUQ+7AA-HY5R^OD29[@]4(UOf&
7&d<O6XHO;#:I?gUGF6J5UH,-XZbXZO.^^[f7,^5D&#/gC@dIF>)@\\429_EbY;0
.8&N?]S.)56;J#)H;F>J;CC-eF\V,;HQN/2)cJYY,\10O+=d0Z<L2e9fG\c,7V+O
?:Pa(dMHdaH7g^7SO9+T8Q#(_I[J]G\T@.B6+2e>Z&4E\Le3QfAeJOMg?Ld4PUeN
N;ON2Nd7dCMdg=Z^U2+EOgA^N_.:#c6E)QB49/d?0BDF]#FW:6-b8YK(0-FH)b94
f<E?D<0A,e750A1,E:QS)\+T37G;OX?QH=Ld.QV&/:bZ[49D>Xb0J3.(@ZO_;ObF
(c@@K2L_B4L8e<Wa<L=;?gS0f\FLfcE5#UZCZ_R9V03.+KRB3@-DB(F?#(@KDVUW
F5_&,gGWZ#<6T]\]+^?ac7e6Gcb&1+W5R4&3VQOY\?6DKW]_\TdXT)ZPg.IXS,J-
R^]@(HG60A8U(_T.5f(BH(N+73O2Z^\[WBR).D@M+_Q)(I_V:6GI<&89]ge&6\fc
>Y00K(F[W<BcaG,JVB57M71H&WEKYS1aQ9K?cY134[7N4H.ASW9A7UbBZLg\7FDP
7_1J<]g)TbUI5\037=P,#FJ1b1NEZ48Y946AX:cBLEFZ]JI@HBK7PKad;)PMCF@O
2F_@cYNeWW@M=SOQG,UKNC@OI5&ZCTgKZTYfF+T3dA[Q872;IQ1FJf^SMKVGFU&>
Hf+-/^8;&8,OA8&BY-(2#Bg?@CN@/.Z]Q,Af[NSM:Xe<9Y(LHaPe^J3dS)[#Y2]S
ZR?a\A94fG)YX6LP@aePH/E&2,_a<Dd;9V6=VB947E<[C-#DHF)Z^\DT;048#IEE
-aEK=LP858-BJ7VQH&dLE7AUcOVG@(\9-2^;bd^42eIDe2D4>W:]-?:ETTX5R(>F
B;A,O^I&^YWb.gB>)@VO#BII]66CCUM9T]dY@bW,)RaW^SF:71-dUgHON@:7F75T
aWe?D6]XQ2:MCWU0?7EI\f=8?;?)8;ZC;,1bPK[=<YbBd>20ET^@2+M\a4LVW&RT
3VR_\F7cJPRYcAK4g&.fPeN9<26JcRWXc:IVGUCdaD.0[7CC1J31;0:E#PF7Dd5O
:bPcW=ScJSdb&Q^g&-X7)LOe]>Gg_[fV7KWLQc0\Y,Z^L1HdFS:H9S&NJ:).1M[1
,P2\K;+6RfgMD56e1/J7YOC\M7^?cR02b]#S=W\Rgd8M^HVFQLO>MV=TCA[D.-2d
[NNg+Z@fBM[9?fM0HF>RQTfXQS?U38_I>ID8SF,/(XdQ0C+Ldf35=[(cg[F:^OUg
O(8^2GgSU&9/)#e/U((JKAPIDTBTc9QT-E>)AR<AeSUX6?-6^.42ORR7:D.eB820
ILVZG)&8\MR)^T<VH1/\cV+V39:7/eF^0;>]RaS>;K]64f:Q8R07V:&UW6P:(/]D
H?L=,Ie>ISWdfJ77QUX#I+=02gYdTL,)M9e+@:.0@S\]Od,b1C:W2-[RVJKEJ&,+
W\Ge(5IJ#1Q2=WB-D62c0EMDeNSQ<:K:T(-RIBW2R(1c[.&d/Z]I4)RIe,Q1F330
D_cGG>Z@3L<G2OJ,=(U:JR3[>=@+O_ID[UfP(=cF#f8@HMBHU\_AJHfV9=_]+W09
(_HPL->>KN+^?4+?/@TI)Z-2]dD\G4K[=KfE6[5(#_U>VK/JS@2O\CT^(]3LYD1e
[A>@A,7Wb0;e<^-1:Q^YZJYUaK1cZc-I++=7&\:[C?7M+gD)>RC).4DMdTdDWR+1
c-;P#95bKZM;-21Z2HTdRM(YRXSBK&.VX870Z1-Q/PLJ4G8e3[7d<#\;=,<2JG&V
\V[d9,W>ER.\_g@K620gUd@+XeF/8Y[MGSY1T<HWb^#c]UeE86Z:(cRE;#8<B6Yg
W&(_:IGO,3DaTLb;PX2X5V,0]5DF5NSK+MbH,;.QZ2CV-;#E5eSOD7@b\9fHU<?H
:0\2\7,#^1e:(SD+U3HBDRK(gQaUf<LEN.@U/>+HHeZSP;D.Q>X2G@E?>C0EKM;0
CLDbL:5,T13?N6SaX&6;M#cBa;e<<V(I@N@c#6aE<RJfOV;WcO6ZPR0HOWgI1c0L
f7Q^]&=N;P>.4Wb<Q>MW0J2?Z0(086\_<[N;V9M,B:<@H.=?d(/535YAN<M52N5N
T)UV:c-6?=c\5\XOb;PW1\W&ePHU(W)06Y:VD@eIcGWDC3D>-@0f4>:>I4e-5ASQ
(IfEcc(;5Y7fAL-LK\C9LCUXU88T<]b7[GF\/d\a&&/&LJd5SRCUe<.APAX.VHI2
A24TeNGgcY/LcId@T/0)V@OW7[[2[5&V-X^TN)()S8G3&-#VC+7@2KJ,G.;F_@&U
>);1G9Q5+A]:JX;f]H0f&IH0a^LbZPT/Q;BBb7d4::60fSZQ^Z<7B0b?bP)4U7>7
W=9C0++VbD4fK3TE&c_cGdYQgFI2;KZ4K:_2,2D_][Y2I0BHc#BC,gR_cNKI-/&_
Yc&TWGN\/b=^gO@.c#&0JCg9CY9NBT4996PK:c/-/&D<#]3(>C]Z4+SZ8?J5(a(-
_\)?#L21TD/;?N;01gRdBEX81(RFH8ZI5MbFD1I;I\PHW2<LdZDAdE_ZM50Pg6^(
,ZY2Ug]9e+Y/#>^V9K^bdd3=f?&5@6XUAB#\D#IO-6ZK4O56Kc?VJ\MW4d<8VA:^
bcJU,dO0D0>Id0]G],HD+ESQ1DX<c>Ab:ME?=G-TMaA[+R]2GE9;(GXM5I;K;,93
Z:a64X966(((U2LLGOW:()+VJNH[a<\Sg(4V[#3,Q.#W1,B60+3<5G+:4G_AX::K
C;b2\dX<V[B?b/XG4K/HO64+GJ@JQfZD-^)33cL#-,8L0B2Gf#AaIR\[I]SP7F2c
;DF(gGJ(63N/Tab<=98ADUXFa)-Q1:6dNWF+B(JN/[Ea6+B=-LV##2S&,_D-1O>3
[aD-VId,b<8HI\)]PD)M-543/-,R/M+TWC#5U].KcfVf,[9#Wa;&c(H+J@,gN_L0
aA[#-D#-DR\=V/K/:JXX?DBbPSGPPK8dP/H9A7B1VLE)JJ@Sg)Ia-017O_19\NQ@
ef_7fFVC:O3@N,6[VP2Q+_\5BK<[)2^>)C>[4\I4:Vb.QZO?+_((G?#P<GRdM.U-
Rf=GPY\<L<0^_eAVN>e&>R(P5,g+XRE[dbN]X+56C=.U+WKe)H^K@H-a3CS0;;WJ
b/Z7R[7OL[X,g;3+R&caB:<g=E6Pd>MaXW/@+@>GCRC7cZ\QYe4gO1#R2gMC?Y(=
@L(.3>.^B3W0\A^&Q],8Me-O7#6>R0=7e5R54-.=K0JeWJ^W&\0T=3KN(Cb<c3,\
X81)fGf08R4CA/+b1UWTP.UAbL,;_<MJ-c;A9e@1Q/R=g&e)gGcG6PJPC\+@2F+g
Kd0:2<:\\^#[?=bI2c\^.#-P09U1MeF@?0B@/.+Ca+2\K?\2^7[6FfX<I7JOO.KV
gD2/LN2RZA+<Sb?/;8)c5-,9-)/.PQ(V4]b9<KMG[G.@NE\/-9=.O^?c/6^[T?c6
?d?KA^;1Z.>^-U]PP#/)^^-cC02#4>C/Z)+3F&+9)I<cHRM_FD(cdd?SS]1-0Z_Y
</2_I0(^N(cI?0ScacYR)b=/<;TXbWGT)+#1B5=8UVY^9cR=@M<+7SP3)d@.8_Sg
VD-5#+NW(CUFF;>Pc1R?^4,U_#?#GNFd.B7U,@8^=ATC)NC.?<2RfD[V4A)<J@^:
e0T5SaU9b^/NM..D6[)5291>FS/+>O)PE/36^1(EK#OR3VR5[_e;VZd4=eM0\eLI
Z7&VUHS8(JTLWA=I[O4=L#[WK\/e\_)E_VA:1JN22MM0DJYY64^0XXWDPRaM6PV/
,RH3?8579_^bAK8[&dA.O2EPJ)Q]gHEVOW5W6@K0@10I[S866<T5RM.VSU+G3ATL
NH-AP<GQD&M3df>Q8BeRJ>D8H(XbbT#4/+@WfG5PV,cP&\&LdCK10_/S)-0?GT94
]T4b&Rf_KD4+HLJ[;NeW<IG4#=W[]Z]d,@S\UW\S9W22UF]904MN&F]JEO4_\V;d
KSR,&RC8Xc0d4G\JSCeO[:^H<5.M>a0#5K8)7>_aJVd/=/_B?fRQSTVIGb3&D]/=
U,R=TeJ_E8\<PT4/ZJ;A:P5d<_2[I4b-(U&DL]T?#Z:e3eH6N&[c-6bgHIN<?Eg7
f/E1UTY.7F\<,Rd@Y>[W>?-bH0#aI+1=6/NFc@BG]7d20,EaFdQ^XN3=UBHO-?6#
F@)-KBe-SA.4Z=W.dE?J6R<>4YH3I9WcbWIP1GYAPG;>FL[2H7F)&d>4/U5M6^_L
674?BW(G+T\HOVIb5HGFQ+JCFf^@SMMPFEV;PSG-ZLO<-b-,0T;U;8)0[F0a^g^9
EUfNC^7;<UE::1\CX=Y]7(R[0Z9C>:JJU\3f]4;6)RT+RYeN)_(RJZ-BMIQM#(Y1
M\>)5&BY>USQ1(fPN8JSD9;KO(9eK@IKP[9_Kcd.O?U&K-Bd2fL=]0gc]4&WS8M;
UMf0aK4D#^0BM2b3K1V6AJGQ[4T4W.@WFL+.AD<N(P+_:[ZdLK.W?JbfZTgaG06P
=HYJ6G#eR8S]GaJNAMG6/HM9VVe>7Y<NXA=g1ffOfFb<I#T=gK9#9I,-\^1R2=U_
:STaed(3)47]gFOYB/?(R7GYP1E&],g19GY<@KdBD]\Wb&?XSOF/U[&0NG@b7YWL
.Y;2;35IR::A@M;KZccSU00?Q=&H&(CD8f8G^3g:0^B:1QV;e81@R<fDYOAdTCV/
2#SJ,:]ME7#I+#LYGVBSFU</T>_(>,V[&<+1SZ#/))W-/E\8CcLM(BBTKUTWB;E7
Hg)OTKcN.+?2#>@E>5,MCb&4YQ-F=HF04cUQ42=;7N+05fJ\BZVR&<.CDKBBgS):
>5#N3#G?[0e6FdcaN<-YMaCE<b_BEU0Hg_\\.QDAg+f7=Gc&MUT4^K9-J[K.LAc@
gI>-6&@CJK.\N&&bY(QD<O)eg372ULD[GK3::9W>\N72^)I.=0d+=00MF4U\^U3a
]VRaT\-0G&b.LZOMZL2IYbYHD+XLFI.F\(_I<9@19gL60XWD=C<@aJGf60G^V0JP
[F+AO#O]Cc&Q64Q,5MDK4/@(,V8IQbY7P0RP9H5#]57])HN<d<C9c\OB#3?O-HA7
R(J\[Ag:+R,0DUOFAgDRJY^8[EXB-2Q(S9K>.[:YO?8gefK4dB\]V:=+P2RQGUb.
1@Q_7FRPJPDL^bNQ335[4R/8HZ5@J^\>UI#d(NM>)-F7YC5^5]N)3V-f(NOCDKL)
\HDg=?)d@N7N]E[Te1=Z8E<W7+G00_R_+6;853EQ,Q7Rc]e05=\P2g@?&b^4AQ+S
Ab_Y1HH4:b6BEMP)GO]DefPNV#CJ_gIGJIHeIUM^JV&LRd6_R-JSMFF4IfbWaa1@
#9O?\4>0BJCSR>.cc6QZX>06G(W?7#85J9DF[RCX37/>XXf@dIDIOAKY#B0(0-Ib
^F:NL>_YDbJ1KRPXEaD5_b7/6SCVIdb39DGRVO(Ha=AC5=4G#]aOS2:)Q5:+D-?S
A\<6/LX?&70:P>ORcS@9LOc1gEeIRU,b,?E/d4.gaJK:QMM&E0RT]PKc,1Qa2]N0
V4#4U/]0HD6U7d>(N.G2Ld<&R9RN2_DgEW#fS2#\GN,Jc\UPXM)KJ^7X/c1g(c)&
3Y.R3?.0SN:L=6cEQHUI1aPZK-UR@@H8aNIOZI256W?E=ZB655D)S0+35a2-,/DR
EW1g4\+&<>0a(8)g]9#0Rg<RAR:]YL)306=R@D1^6U94@HPaHbTeMKL5GIG9]NP6
IKdS)A\QGbSdV=P@G?(d_\g//-0/3:-=U[bV#S1+.a::\+3^eJY,67O(,3AQZ4RD
RI6^HOYc=TeaXE\DH#UL[09>[(8aWU:I5OH]ZH<)@fJIJcCdc#:CeBH.#Y?gg])0
0,F)9>6EP3bc@;HQ[5G6I#AUaQZ:bf1T5IHE7Bc(^-KdLbUB][_BDJ59;:FPfT:\
N-d2VNG]ZNFg1S<.Dbg?e&QE]+#g-FK@5STEd==KT4@TCSD,SeC)0])AdWKg_T+[
BaU\A,G>BNeM#3\P995^:YC2A=&-(N>C4(<B+J=g_8E2_/QQ#KR&ba<M4NHCeeO,
M7a)\LLLg1c^/C^MWV4eGO]L0J.Z:4fJg448bUE9>=6;R0SMOIDEe@[CGf5Y(b-[
Bf?SL3+;&;>J[:2NBR[8]_D&C343(WNX^@(#A(M5U]JO\ZeS6gQB]aE0QD->I,#?
#QMI:)_WO04Da9[DGOg>,eX+7,8A289DS4NZSS6O]P?1+.<BXXQRCg1]<O#\=SSe
OYVQ1HHCVXJ^YNB7X/f4f>K&WAQ97+TNEFY6Og[(6(Tg.&KQ\]gS]QW-2Sd]GG\T
F?U\;\U=PX]FGWbQN-=0IRCG;M_9(]GRb@D=C:0Ab9FX5>;IdE<M^=017J+]c#;d
/f_^0_f.U_SYDH[OD6T8^X-BN&O]_];H0c8^?+P9a4.&P-f:+VH/6\.5)1<3;1<=
Z[NJ259@NYKU9V(FF2JK6B1Ea>DfNPO&>G,D69OGWb&ECQ_-@M=LQbaEGG+Q85&:
I[,NOKDafU<[#1[<)3GQ@)JSUH(VO4^L&Y2f[#f6DOa.7.AIK^\:@T&B]?[1MN(?
,/O#KXWK]VEX6E)-dY-?U)TgI<,TQ1>dYb.C75.J5[[MM;5A8d_2bO6+N)<bI-cZ
^V<OS-#?=O-6I2,-C=Q8M?/9K+>]A[fD&1=;)ZH;W489Nc1I>RPR[@cITf#1LLab
BW9cgRb9EQ3K>2V-CA)2J?]LN@<dU3GaO8X79@Kg5@^4-KSc.H(SIP8:UYM)WO]a
I_D4XKcX9>ABYK=W4M27NO<TbBM:e>b)53B.KVR(PBDENg)>FT<CMIg<@)))@Y:@
Y[R;Tb#Q<Y_J/Z2?VP;0YP#ab)V7:&UeK\V4/9/@G,Y&&f>#aaBYaUG/d=d:WRf+
aI\B9g0MY(<N)Gc:8:D;0XZe\G.QHQ<34HS\J^aI[[_^ZX.FT:;\&d2PI26f=XIA
3?7-EFH1QGLb4W\7&T1P/dW+6.b5?b3PbJb#E<.C9(KT@T<T_88-<S+/DR0L6FZV
gXJbf1+(0Jc:4G;KbDKaea=;0Pg=?HN-[S7OMQI/TID[<:e^g.TZcdLWWZ;g.9V,
g_NRO[D4R.=Q[-[L0L_FK41N)0VEfY+,<QaI.I6#c::&RDNCANW?32>cW[@Bd\(b
aR>8cVHQ@8b;cNJ>8N66\aD2HSUO@KU07N/?ME)@H3PA3IFH)aIf/\7a<?P@9Ka5
>@7M72&@F\AAa9IJ9VP@I<84b@215S#+4Jg/L(dRL4Y01T4g_39GF&1B4,QG0.WU
T4J?abE7LK=IY;<(.W72@;-NNA[0J@R3S8DQ+5g-4W1&UE4U]B(5=e-4>EMM)@,.
[5f7d5aY5YJ?3[),Yd=c7]EU([W-DgUJ-@@ZA[0QeDZJ--_?a(>R5[Td3-TGNLH+
Lg6?AbGfQ[#VcfKf4Z,VWBM2P3C,+,4)Sc6XQD?1<:(0>>b,P9_F0XGbeaJUS?VL
EN;+eZ_gY5K)QCG;bF6C7b:_AIdFJ2b_(ZY,EQ+6FJA0VTC0#I;-d]UNX^+\cMb2
(WX2::@53HX#N)3g2YIe7_19a]6>X53gXWCcU1dB@UQCM#Meb#@CgF6EUd<SA?d1
+a=<BS@.V0]9E-(B#Td5#cQCUP7HdQ)ND==dZ3(L/-WO33O]g-_LK<?@2/8UWdMD
WY.EEPed^<c/C)PX?^/V,HC1WS:1BR(RX#&LTFSM6eZ\/VV=V7@CPa0XfI,b,HXQ
44MC_8LgY]P5[XF#26/gNQ7+[g[7:b(FKB##N,MMMON<9_2)P=QQFdO2,#If]_D&
=V?AZ[d3=;,_PZ.,Y<PV;6/gF]S4LQFV)^SEICDP#O.)6OKJHG:MZVDGG9M#S:)g
N1=>P]3#O[<fEO\HEgB,c;^2AM_gF,CR._eFCCLgWENSP?^[.N;ZT,<#d[M+.@9+
C2V+QX3b4&.1GdHNGIDb=?1Ud^EPYV4\dY;1LW6;UO>#da^YHW2c8#M<[E^G?(V]
]5d_J@2NZT6PB9TEOagAf&NS3[TGI?2:XHVf9c).V[I/^K[+;=L?A1W:Z.Hd.F0S
J/#H:C2e1BE:O?>C4,[a^;R#C.eYI])O.T<H=e7A[Q@Z>^AV:Pf:=T/+7Q,;XNH(
:?Y+UF61Zd>B,\G/Z8,BaZ@L?RHA2d/AQJ)J[Qe,0g7)WZZ-\+8-c;e1dVB[I?<Q
b1&,e/;.(D;d46N^FE(W@,f.cC=QL/GKI+[GbU96SLKV]:,YP8L-4/[_AL1eM5^=
1OK(3aOVAN0f\_3(UM)T\P58RgZJQ@=3a=(M(\MD&2N?@O/eEH<LSJ-aI/9gdfIZ
+4VS(>1a\6;+YU]g(a>-?cY4WFeTX\A8XSOD?5B]=0g@G21G/7D>>VN]#E?U/;GO
K6^7D=8+1d;GK#&.bCA6W5U9YC#R=7&O.F+Z4[fBe\:ID^OB+[+Id.A>B(32@RU2
[WAUG3C=&619\D.1TW6LXQ3_,W6^V]Bge(f5Sd+.LFDdMV]B@O:\egc&8CB>\U):
9@TJONVKA&ePRGdI:M4aeJIS0B[-W-JHF]Sd,FJLLD5d=5g)_P3,O>b?N8XgJ^2K
&2-4ZACO]:^E-0fH>GH&95V]LIe:-_,TV(MAL-8;1F9^NC]YgWL&H5#\02F[1gBD
4AK@EfV+[7JRIDTRS:@--IV;-GW<N>T,,+8#c@:W2A.IW@58L63,;I,cN?603\Y#
.5#1=e+-L97Z5D:671DX6-3)7X9)@5WYYd)10X.4E^RA<ZPB(9_fS>Mb7af=b060
+I@?5QO4A39]Ya.H=83<1J#@bPC&,@>2eQW]F5GHB+bL>LAGGeOfeTf4Wg8>8ET8
D[+(\5RB;cR5]Z54_\8R@T9f<c8EA^U0<g=?FLSRacV/]K]@D6A45K-U7E?#1SU6
2GF0C5HTRUA5<5I@6c@68HXWX@\9]J07geG>V+4G&fF>>XV#]/MS,:T]=MHfRgSY
5YI+V5ODYd.;[-@2PD//DDc?I/R@A3ICCd@3aOfG.(HUT,3+AGVfIBQaOQMC:[Dc
2H&Lf)-J<,TPfAR1JZJ#MebAB)?O9TJVeS/1E>QRMFf8@b=?DGR@ON,\fIV^b+RQ
+#Z6&.V&^>D_Pg.F29;Yg@d,AfF<LRLHfJE057DR+?3WcFdQN<4.>:0c/0PLaYE[
<dTWJeS15N-)-C?ZC2A;gT\M+(NB5Q5IO5M[+[)ON32dUV5&&46NPNE@5A^>3eY)
5d53f:AeW@,)>A._b75KfF=UE+Pc#5JY6d;N7N\dIVGVILE5c_:8C._UP/&Je)<C
cK#P:-Z2>Y_,4=/?dIfP1(?W7gcRbE]NO6+YP6\4,TO]PWZDHQI#PT1D70X:XfJg
K1V;Z9cB[)K/;;EFF:IWCMSQ4gIQ[MS=MB78^N2WIFg/5H+J8U9/89XL7L/g#DBG
=T&<f-c6.bcE]FSNT.VJ1)V)+Y<7YD+S50Vb7NaJbZ0F[)fD3ZV_\5:EfE:]=10d
6-8E@HC4eV4.gP+YCSbC-E@\N(#CSBSa@OO;F2)<43OeB(f+0@N)<KHde2gHb/,B
TDJ)VADVa0:Wa#SHa5/?4U0.T&(]bB\FXI@aWa6R6[dX^XGA,E:a38UbD#F;d#LW
+c]0]Hf<XS\cS:GBG824dXBGOEc2<+g&LbT>_X<_;H[K<gQ<_MbQF_/>K8aSP,HL
H/)?F,]Z+<#VWH5^bBZDR0d5Jg#L>8A^0UX[DH0J6^.<YE8-N_,R^+aLH+HA6_\O
-O#H0LUOW125\ENIL-F)Ma]IH#]XCDF]cDTB53X(:Bgc0>QX?.7#Xd3CA5T;OA99
99O2b=H;I-dP3A)gRD;fRG0R;0QaL1W33WfX:X1;K9@?K3JK9[__@Jb,JSg^)=-c
(5.aXNWf6]Ed(&TTO@a^.R9a\+G)fEX#N#Y6ZU^A8H]Be_EY0Y(ZK)EA?2WO#6RH
EOL/DW;4-d?+;&b<CV/W,>&,g_P=_7=V(A\(,J:G+NFOgI\N)2FOTHAIX:LN5:.?
c;N)H69Z&R=<9ZbJCG6^\]eU\,cd&<@bQ659U_P(4](#]3f8e#FO.8?GOB0=;dX[
[(3Z7V)WbaQ=N(8>X(,aAYQ8CM@UT3)Z#L(JZ)3P:GD1RXdeZY\<7TKBYJ-f)([c
#A7^//?VHBH3(^7=]ReA<EIP+2)UO/QTaO>FTeQO<,XfR64G.bLV:NX#2,JB8LOb
;)E04,](dPg8g,7JV?5SLOP.(WB.CMN_e,OcHCHX;^YVS_B_#1SA[H57=W8-Jb(@
6S##5;IJQ>d1YD@I4-.0>CX01^88Qbe/Kc.cI1_OF>_5YS?f7=J(YaA]&Mc:J\)f
8_(U+]g2UP1)g:=ZUX^VNZ:<-RLUH71;0I7eZ2-W4PQKECQ1W5U\Qg=@TV90RgF,
=?9EP/[C>TRE:;CW+Q)^<L\1Y4RS:EcFF)V]LS<N-1+@#?KS)I2KEN&[D^Xbc&+O
:3B__M?Kd-??Wec&,EU4-2gE=)R_Q^TG928NY,U2F;e488_?#R=)bI@Qb3G.W25.
<+S_63@9?C]eT.9X\GfPdWCdFd262=.=9Re<UHOeF@[MO@S&Qg_])I20PDcd/X03
?\]X-QMK;+0,Ja>@].U01)dJg6ZF4PIZB1)VP>[a4@=W[e)->;FOW3J.FLeL^N2O
3Q:+B_RO7&#DCI:0]E7=C<UZ@&,TYEFeP:K(.5XZ^AI<XeHKU0a;8426B5(O-:TR
L2J;fASIUAK2ZO)1WW)V>EMJUd^1W(3[JI9])]4,)HA=H,X?(QF9F)B9D+0M>dJZ
W.G.@@4[]a^N.20e7/]W1-e<.O,,6>-80HFBG>1Xd/&>PE489_UNd:[Oe>b.]C3.
OMF;LGL1@D:+4W=8AJ(?5@e/CSCbe_BRb(>)V>c/A)>NCCG&R\+.JDCS(=297@@S
,JT0SABCcYMQQ0TeT[7:7UdS[3N8dE#F99B_5LP\GP30/6R^Z1Z_^_I05MFd@P((
;ELY:a/#_;gXME2MZ1d^b5#J-]b\CCEc?B1R>Uc;M2KQBB:9WA,[Ofdd3ZV+X6A-
;&WZ-R>3-M+7.Z(8BXDGI[;[a.D\1gI^?VOL(2Ke1&9M]ECOLB]fS#\)?7RS&O^<
f^_CAKaADJ@^M(S6)aW4?W+?=CP_D,]I&bKATR7SA>.TaWBH^TQK8:3)[7E4MXeI
gc7@A<W?T)[+Vg,]\=O8[;b&-J?IW;8FLcOO[aC.P6)e@OV_78#+&?LfT1Ge1L3=
82FTG8Q3X:R[M-cN#^P9VYX_^]Q1)6f?#Qd624_a0J11I2\YBCM\RI0RUFIHJ#_e
,2:C#7Z&#c;JH#IWf/K@PREUI#f=:eaTA\O9<)SD_AZ72WYf0LI::FITBH?;UO0\
MKS(S))JC7F_I<3)dW:c81RUPYHLOdgS.K2,3FTLV7U5YMIDSN)/V&Y;Z>H#<Y_4
:?)f6&9?[fM,V5JRH.Dcg,fYQH]KAEMVY2B-A2b#@#=_BX]e3CW5C4g5>3BAbDS<
b5.OZL?2S>)99UO8-MKfAA=K]H/C/6G1TCM51,E@J.Db^GT57Z;cVO>.8[]=LVeZ
R>7a=PP_K&RdWW^ED)e<DQ06M&B<H^>(+POFLV=C1SGdF\MO&#T@,LXR<O&=K&D1
HN5@3gcDXH0XRf046+@Q#Y\/EHVbHK;5f;N6:.6O:K&L?D:/OI[O>c>7aQZ5,,QC
6FG3F-]GP&?Y\[[aJ;<5/B1OQ/=XIQ(KGbPTBO^+cPBP:/c6E]G&WIN09g#G^WWN
]AA4/ETPZM_>->TNHZBYO]ZX:43a]L46d>a1I265RTYeG^TC]Eg&1fR86NG>,<>X
^X/I1FM\RC-Y]&]@Dc]L:T8<@+\,ZLf8NWb4DUgc:9b]G&L_,GC_?8<1>AOD5UeR
#Y1TU<L=W22/-5g8(QQG@:TcA9OZ?eZd<6,-T8\7.T0)?X.RS[?_WE^W#A/9JS\g
7]=3Q.+FQC>.G33U>^5O2K(MI+,@fHT1EL?eA;+0UIM4aWH8K/AVbYg=2ZH#M6LE
8>(4)&-G=6G99NHF31]ZCOR/]7V2R59fQM4[g77XCLEQRI?):7M>C>(R14QQ4NS9
++>-Rb6ZRgQ4b:f6:AJ=.C3IB\ZS80\]3KVQ&[b:_-AR:WOR2(/?UN-\D=fK@@2<
.R0R.^#SDNZU=e#.E+D,#d.#>MJc<de=DLP6_e-_BN(?0M4_RUYVLA,Cd8OGPg#e
;c:O?DK>2IUWW@:b36RZ?=^DB,(KD>2a:.29TgJgP3F2(D6=5^A;eC):;2:AOS,g
LIPe?cdPe@eM>Fgba+<&_3N??ZEW2R6_ROAc?_>1FJO:B]WJ2XA[K[9E&&Z0OH?a
bU?f;[EQ[_e;OY4KUN20YUNHa]g0<JI&C32Sg)MHT,gf70_<Sf>Y&B1.0(5#NK<@
6+d4:U?Yf:]A12R]LXD)G^fUEZ(X[b<=>?J>bJX46KC@?9[1J<3?K&=\:7-3QA(?
Q8B&E,TO:aegB]4ZDZCOSafb3I\e:X78Z,6Y/R9<D;A6,\CPc0(@W(6>dD#7G&>\
96HFfd_GdQI.c-DSeaYWe#SPg<S)PZ.KC1aTf=9TWgfG7>Sa5ES0^?-OP0/\;Cfa
F[a32OEM]=KR&G-eQXIK\\:<#5&@&40f9;c(GQ;=\eOTLeN4VS.)83&0\TM:]S,>
WHB&/,gbBVMDT]=M=Vd,O[g[>:fEeHfCNOb8C^0@[SX<Zg;3T1(#\7c#,cINWbO2
Q)YVUbfWg@f;CUdRMWcSO-_2+2TMAHO@a#LY:V0B-I=?a/>dTS((]/S(0ZO\]AZ?
P_SY<L_;5\AP\KB6V0,?&6D^Y(D(5MH1U9^[SEV6]8C-0D=f)SUW-_eQO8Xb@R#a
S/+f:NPd]4g6>(WLfI:0:M;=4?VZ<Ff=MOHR3d0\>b9g<JZ9f]7Cc@Q@DU:0Xd+,
f/BQba9?g>,.X;I+KL[\<WdDZ5cA5U0#U1,c4FcVA#.eEe3_B<F<N&aLGNS81Kc/
4<DM9\T>AAUF(b=cX)_e[=CGS-WYTXMTHW?b<&[0?DfPPHH_X(4>FU;;BS751/X.
_]D+@@b0P6Md05KbW/CNZ<SHb-]Q5]P[MO]WLX6^9;AGU+;K1DMBMM4bUYCSIZ]V
E8DeQSVA5gGGL>Mff&a1_+JVPD1a/9)a7OTbMQM7J5<FAc?FK[dF\V3;P_7^5SVK
a7GG;F9\U,UR>YIW-cc0FF(5Vg@geVL;?_;<H.6#.e5b(dG#,b^5[XfY;E)&)#-(
7SdZ[c7U@WESX:0gZMg;DV&8GVdOb_<SA::Y)UW4?&9c2_U6cMe=S8c@3D#0U3?+
&3g;BH[VgO9.7ZfC5=&I5Y/)g(QAEU/N?ORHMNDd56U8(bGfGSN05BPdQ-M>1dIg
GVg18a0U\=LGg[T2dOg&O?CfF)WFNW@GL601-FKC&P\b4DFUF?GOSVdG-#G^/4#+
Z_f9]c;HZ&Q.UD[Sb?[,WVLC:F:ATZQ/_dO@WW#C.4aN8CBWfVcA>K:e(//:68OG
.JX=W:56gH_M>@VS[P1B;>?S]Je3;OaJTd6PM2d#I;MPMUR.8^#Y,b@W]AbCS6HR
M6gH>P)aJeO6.HTD@aCgFdR^7T?EM(0PSSX.[)U]3VAVW#J\[P/e99XB6-HA7J2H
_EM4]-;MZ:eYKaFg^UQJQHe5eG.>#,/;7^:K)d]X4UMdBZ8KS(:F&ZCa>/g@-C,[
R;8/G&_EUM>Kb/DFSH\d0;a+=FE&OeQ5X&NK9AZGY]/9->MF+6HR^Z3G;gD7d\cZ
4[Y2M53b=3R:ZV6.CDMU2F__dU7WQTSdCcGf0RF,8c7aAKE-KQZ(0ZJ@H.T.(^;6
Qb.Y9Z1A=6M&/)GEc/)CZd8MKV.&Fe@_c,fG>])3VeCK&CFI4:a+bB2(6#R_X;dE
:/6QFd61-E6a4_Jd,,?68<=/X7A^VM<S5g7C_\95JVJZL1L-Pb8Y>7Ba7>YUOHPW
_<eD0[b[WY5D)dEUQ/NUQ_&1VHXUZN)bTEOM(U7XQbHf1fY7O_Kd\0??18S:Lf)Q
=:4G=UWE#d5D891f7]7f[\e5HfV17IF1;9MIZV]-0CO5Sd?02a,]G@S+,5;WWT[_
@<Q3&3(KHYKcg^0+bK;NE<-LT#9LWQ?&C7[EZWCR&H=?,K54FD2@)X8V][56>S@S
0/g[&VFL=_;)e6KFBD0]ca;G2>]S#@.a4c3@#H]c6^)]MN^[0\VZ2;X;aS\ZdXI&
&/Z>Kb[8ASc?F\,P\)6V/3J=LB#MXe519_C-f-4RCcbP27VN2T0K4PO\.^,GDf0b
9Z?a?&5b<JHIP>c7g=A>BJcYX[[B^3/+/QJ#C<-V]A)ga-G2+.dOVZBM@F/7OZ11
OJD89G670.A4-(>?1)]=gLFNNW?<6=&V8[618^HAb7d1P+&LZ:>Y6X4G&BdIR5</
)()[#2(_+<7J9^aY6c18S=Sc/-Gc7.>7/JWfMeN9WUYWVd6SY5[fe[5C-c[V9JQ8
ERN[Q54eQ(@0a\8&PZ\Y&D^#0;KTTFDf;)Q@.<_U?A\;Leb]gC]Q<SWSbR4T^]=;
)NWA+BQKYP:HLL,dD=L2L6&T3HXRKBDDL<;7DRG]E>YA6#&FBXX:aR>ad2:WHL,Y
FZFT=OF==L9D2<]YYU]:\HOE#f)C<G.c+[[,e3;0bG>/bS[E<V<T0aIb7S<CIR7)
H;8UTXL;aaC41C?&<,8[)b14?c6F)L6/@S5]LVM.LJ^@T<Ga9<IFV9^3_##>cV<-
##=O?NU=GRKWS\FNd+(WfW[P[58b#@#8SWXVMCL=[@?c#S8KNN-.@\HI@ScQ+SQU
bQYA,W7g/)GCIeD?G[DXJ:\T@?)PROQG&Pf]96;=:5,9DRfFDE_=8fa=7;b9XA)\
g0M9.^.g>4_9.\+WeH#W9WL-G:8C/1</)AgAaYB\1Ta2(,FX/R_0H<EET]F[[?21
F=>P&IVG^[g;1@9U^5D\:NTI@/6[1:1I-3=E(-LOf]d37gI,?K#7#aD&Ga/J6\[W
,5>ASEN+7C?O.:<#&b[YXFI]DbVIVF>6V6@gBXd)g>@99.#cB_Y0:^=OR4K0+19V
-KUJ7S:(A?0=0X1YN5E7aC>XV(/.bI3d\-6O=KQ-d0fC&.5MHKBDR3bW[PX.QKM<
D=4PP?ZV#OVU8-W(?:^I;3UHgCK1M2LPY-CP7@R0/,;=--1fBA-Qg#/6TS^FXcXY
6S2UG?3&AD_@;UY0QR8eP_]-.0ICO^,=R^@Q/P4c0T80Z05@5;c?_3<^\6[@^dCK
a;-(RAA#;_VQIM?ATX31fNL75)JCYAFJD7@7RB./#T.H-8M4]>:C&254\N]PefB_
PMMY.9J84=MO[WT[Q<P<4CK3HaUH1F&7M4_L+]&HB[&,=IfbZ636E#Lbf.FHfL_c
.PNS)\\)NF;]Sc\T+]D5.JQJT:F9KC95a(R+ZY<H:B6,F$
`endprotected


`endif // GUARD_SVT_PATTERN_SEQUENCE_SV
