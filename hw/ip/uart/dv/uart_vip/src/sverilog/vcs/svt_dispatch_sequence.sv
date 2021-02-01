//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DISPATCH_SEQUENCE_SV
`define GUARD_SVT_DISPATCH_SEQUENCE_SV

// =============================================================================
/**
 * Sequence used to queue up and dispatch seqeunce items. This sequence supports
 * two basic use models, controlled by the #continuous_dispatch field.
 *
 * - continuous dispatch -- This basically loads the sequence into the provided
 *   sequencer, where it runs for the entire session. The client simply keeps a
 *   handle to the svt_dispatch_sequence, and calls dispatch() whenever they
 *   wish to send a transaction.
 * - non-continuous dispatch -- In this mode the sequence must be loaded and
 *   run on the sequencer with every use. This can be rather laborious, so
 *   the continuous dispatch is strongly recommended. 
 * .
 *
 * The client can initially create a 'non-continuous' svt_dispatch_sequence, but
 * once continuous_dispatch gets set to '1', the svt_dispatch_sequence will
 * continue to be a continuous sequence until it is deleted. It is not possible
 * move back and forth between continuous and non-continuous dispatch with an
 * individual svt_dispatch_sequence instance. 
 */
class svt_dispatch_sequence#(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  /**
   * Factory Registration. 
   */
  `svt_xvm_object_param_utils(svt_dispatch_sequence#(REQ,RSP))

  // ---------------------------------------------------------------------------
  // Public Data
  // ---------------------------------------------------------------------------

  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(`SVT_XVM(sequencer)#(REQ))

  /** All messages originating from data objects are routed through `SVT_XVM(root) */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

  // ---------------------------------------------------------------------------
  // Local Data
  // ---------------------------------------------------------------------------

  /** Sequencer the continuous dispatch uses to send requests. */
  local `SVT_XVM(sequencer)#(REQ) continuous_seqr = null;

  /** Next transaction to be dispatched. */
  local REQ req = null;
   
  /** Indicates whether the dispatch process is continuous. */
  local bit continuous_dispatch = 0;

  // ---------------------------------------------------------------------------
  // Methods
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_dispatch_sequence class.
   *
   * @param name The sequence name.
   */
  extern function new(string name = "svt_dispatch_sequence");

  // ---------------------------------------------------------------------------
  /**
   * Method used to dispatch the request on the sequencer. The dispatch sequence
   * can move from 'single' dispatch to 'continuous' dispatch between calls.
   * It can also move between sequencers between calls while using 'single'
   * dispatch, or when moving from 'single' dispatch to 'continuous' dispatch.
   * But once 'continuous' dispatch is established, attempting to move back to
   * 'single' dispatch, or changing the sequencer, will result in a fatal error.
   *
   * @param seqr Sequencer the request is to be dispatched on.
   * @param req Request that is to be dispatched.
   * @param continuous_dispatch Indicates whether the dispatch process should be continuous.
   */
  extern virtual task dispatch(`SVT_XVM(sequencer)#(REQ) seqr, REQ req, bit continuous_dispatch = 1);

  // ---------------------------------------------------------------------------
  //
  // NOTE: This sequence should not raise/drop objections. So pre/post not
  //       implemented "by design".
  //
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Sequence body() implemeentation, basically sends 'req' on the sequencer.
   */
  extern virtual task body();

  // ---------------------------------------------------------------------------
  /**
   * Method used to create a forever loop to take care of the dispatch.
   */
  extern virtual task send_forever();

  // ---------------------------------------------------------------------------
  /**
   * Method used to do a single dispatch.
   */
  extern virtual task send_one();

  // ---------------------------------------------------------------------------
  /**
   * No-op which can be used to avoid clogging things up with responses and response messages.
   */
  extern virtual function void response_handler(`SVT_XVM(sequence_item) response);
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
F0eG@R.HTD1/gL]4CfC22cTYTTG5;MV97GR6c_;)E2Q@@aQ;-T&3.(/[5L-7]Vgb
XB2Mg7A_g]20fdM=d#U8F(Bc03&b#A[JGef61TO++UV(<88H0eRQTeNAdEEVeQ>a
C,8<&WUB&PU@g3T.c,F)3[c36U;6d89Cd85a_fa=TM1[F0J4?,T68+3bCDad&eN.
,aENf3SL/VTg+HVI?M8RPP&cBAeS<2MN9I4#1>-_]DEA&=)[04GO;\()#XJ+(M4[
2[CYR-:>bMYB;)S3XW<UL+;0@2XP1=Lec^d8c21GSb8ZBb-1eS91&X..JE_3.I+@
&,ES0eN:X<0K[?;]@1U.U[3Z16T\JHIc+;=;S>Z1,2DR\>g4Z-7MHQR4271BCd&\
XW<VgVe@X^C&<NIOHMF>feX8gA/&\\L<?H??09KKW69dc=E36(fEQ:A6Q/+bWF(@
=6(f6LR+<GT_WLT;,E.e8:[8QE@^RV39(S/RO_K[7&K]TX(AfBV]GM^;cA2U5.-3
Gg7AaXbZPAd:,&S-A6@e5F=(W(bP#HKL\&Q)H,I+BKe7:?gf>[=G4H19[&<393NN
Q:CEW@:B6&_G>F\W:[DS3YV,@?(29U<YF/A,<f#J&<Z::E>_+D_&g+_EE74>[-Q6
SDNTdOQ3?]U/+(=@/AL:5F@,(3W5=93+f/BU/Y_e;)O&#4&S-e)30&YYSP:2>?\T
Z:Ig(HH2[NJ&K&ROW6YX-+ce39XK9+GXT[R?Zb;#X+P5D^&0+e5;EYCZP2(FIB\_
.9[a2MBURNC7+.eYcYJ9GB]SQWWADRRaaG,cS:+.ISR7BDOR?W1RBM^+L4=WYaBH
W^c1L2<+4YO+]KDSL#4JMeGLNMN<=.;Oa),3E)L@)1/g5OM/3a+JZefVA\<PJ[Mc
U9ZT<:(#+K?/=HaOETc2P\+QM62LT5&^28Z/]9>+?JaZM4V+7WKTg,39LTE,PgI:
0)#NX;3BM/HBB>7?+FI/Vb>>Z.6,?_d\f2aT8@d2)BNAbNSM->43aKI5[EGL]:=X
./>TRMf6f+_)d6JHaI#14Cb[/NY;[H;W6;eg@Sc&+@;_D+T]D6?LY@OH#E3:,UOb
?6]D]Zd8@dY;UX,JQeYN=_d+R38I]MX.>U/M;_4(9Q_+b0@g+D+.3OfL\>.FMW3R
_cGX_MF]D3\ALX)#MBEZHgb8:#W8V:9/)aWGdeb]c1Y=\3eg6<^)&470d]EfQ@@G
E5M5cJE@\&3V&SE+EZ60,Jde/7c5T-[dK^8g90NNaN@.[,W4V4M6PYJCDSV+4Z6Q
@]ZT6)5c2F^;/FFfMZ#E95#M..7(O^a),b\3H]3TU\:0cN:228GK?d-+QHTKAc2B
W=5K_d^M0BR/+GT[X@-8bP\JU)3B+WMU?D7bg9Z9\\b+TT\dc6XRKB9:9]Gg3\OQ
dN84b8KAfFYDc+EG;1RYa@ULPRO\eMQJVE4]6&?\(AZ_.JUC]d#TgBEZV/R-DOcG
/S+Ec4/;D1c[;[=N?HY1[LE+BJD4@-=@Y;2e6D0&6E&d#c=0-X\\VZ/\@c)@UbFB
:e<_5+M)SNeXA.#1e?SgU4>?M+DD&?WKgMHV24P.QP\#&X:R.EPI70INb5]_&+\Z
,M;PeI,YJCT=2I=Be3GGM,U<[S;G<:[U=fN>ED(>ddc7S&LO\d>,>#-(O^-33T]Y
ZVCZ4;M1eAdLXgI)MK8&ag8KL/,]:Jd[fc<-82]^2R/:319b3geT>;\OYg\A;2\8
[06_D(MQD;=2+FGRXO&21G+YKSA@@@1d])?0YBO]8AR0G-agX,;Fd7?95(UdVa9b
ZMPS_2;L<OTKe37eg9aK5,?De/1WA,;GK+XGUG6TEBD,3:VXC1L[RC8/,Vf3KfaU
Af[\NXg[N9Af+0JDT9C?gRQ#DUN>,L\(FMZ-H3J0X0PFK\AM)PMQHAXSA#&M/TRN
=]Pa8CIc]7:XM;O;E@_(Z2[9cT9/8>>I0O@P;2@Q@2g7]ROK#6E-F1C0W@eD:d2:
D)O;:+\N/5V1J@0A4E;cM>6V@dU:1CJXTONMg8a.&>+0P;LK=c?cbD&M4<gO-GYF
f[cUQ4ff98P2OPP=()7_6NfS=1afRUaV;S<X^8NCNNd\)5.\LcVaN5;=3eIF9dVQ
^cRWLTR\R0H_E><_bJWE8\I+X?dTeYZIYBV38PCfH(Z<;P9M./D[>C=DNU_5Ud5g
fNf9K80</I-JGf<#UZe_,)[?<1>4)GUUI9\S[&cBeJbadaSK6,c(_8_Gg#5?UYGb
T9DW:604\J1ENdg;Kb.65XY5c27Y^(+??;#K6f/[Z@M:EMObLZ?4TK.-^-7\?\S+
341g@)OT^;_eA\U]<DO(CX4e,OB.f:[\gWI^b]aP6TT@5g0[95E/g<:/4Z9V+(4W
Xd-T4Cc.-8^E<f.CQ6OVOgC#1U+EfYg#2G6&..O?9f;AR1^HQa+R7G6NW+).NUM(
I@:&:;B1?d7F1XG=fF.gHWDcCXBK4@\O?F_V1KJ[a[7d1X1IX8H05;PC>.P&R6-G
R.D-\+X=EWF9<7#R.>W,H2V^X=>c;9?:@b-Q2Z5E)4?C#5,7>=IAJG?1V\cE#ITf
[QBTK#=aaYcU^M[T^^C-^55A-O=IUO](F.UBR1<-]6@]@@/G8NXAgZ4&-A^1^JZ=
Ye\#,94JR]bWYU_DXHVDGa,1/02;#O?Ca/\dbJ+?e(P#DdHHDd@K_BZYfcMf\]7W
V&f:8]-N9,cU,?^#3FW(&O-8Z<MARXMVSF,EP9DRU/IbNI=+4;GERTC^FIDKLC(,
[?-[JF8CQ3<6C9ES<_RNPM>V@VcPbL=MI>YQF77>@@(c>#_EQ02(#M4A^LEQ=<.S
;LQZCF3X<0+G]<7;CDZZF6S^-E445)gKXab(##F5c+J;0T[ZP9[P5AUW6F;>g3#Q
dLdJAQ=g,dJK-&M5[UO?c^?5\D./XJVd6[T[<..fXMOa>bd.LC_6@V]J9[,X4U^S
)8CYGEQU8TMbR9^S+6;]#-TOK,YW2KUa96-CBR4bHC7TgT/H&NMF9;G[J-Me(;<:
5^VU[O>>C9g7@5+bPHSg@72f]WE7^@:LPO\gb,LfDIJ(faR;T:LT6:BQ>QE,Q30d
geHDGQM2?1cb_5OD[NO:9N6OBO9G,\@5)N]WKI7WJPJ1J@>Kd[?:>5UAN)fd+^#M
e]AOUIYUXZ2cB9)./=S90;6IGJC5RD4B]Y+72LOF0cAG8YMM.bYY_7T@V.;,F#NC
KF4+2Fb0La5R900K4cQ1]ZU4\OENbPPV53]QN?2C<EH3U[6GQ:4I/CIIEaEJENZg
[KSC[UO9?VQL/P[O<)_7cBZ6#:EDSQWA@1]GS7_;HZL6ZYe]TE\2L,7.dT:LS=-1
9EC6]Qg5aedESFZUI:A<R[Y)A^PY4d,U;A5eFf\I3P5PdG+D+I,Y=<(>JPXH#,C+
46b7Ma//3f\,KBgJJ^CYNWNO[Z<HEQ8:=H^6c0F;6L7Cb:&0RC&B?J,5_:K/3Ve8
(G[fWO/bKMMc<Pa7V(MM[84(Jd_)Te_<?Xe-LN(W)WbA_fFLfS\>HB?W4Rc@9Z6:
K?C\c[H<2;.7_A/e>=GQ#^)>LJQf=ZCS7g,4?S]J49-ba<4G=]@=(122LS#)BS/a
Gd;[-\g+:Q0W4UY:bUaT8O(6Ba<CD.))4JEN?af,c7=g9;BRgKZXT#)Q:Iab4;YV
;I+1F.NNGI39Pg-+7f-,?L\gS(I1YZZ80L;AY8K0V=<P->A>gYaW-cDHP^L38\d@
YP0\.D)2A<D5HfYI3bB4IXH-Y2_4<T&MRK#f[D=7@]2^L:FE>\UOcbEbY/F6,L9E
OD5PI3<PR&-a;UR5ACbT63T2LJDR&Z]2;,Y8f+Y;Z-fVB<L\?4/7OI&9=b+8/0@X
++d/-K@Nd:Fa/K5,IP/N@;2&W6:=9b/=Df/H[MG@FKV/Hd=<d=<^H^?Q+I2BCLU:
\T/NBWM8MU0f3D8+:8Wg@-_@S/_=^QNI1O7ec913]V8G@U4FI]O_G)H[9LA..>Ig
(WGFEP;Tf7c<I,fWR,:5&IT#-._;RQO/M\S1D./-BMD])]7YBgAf)JFBDZE]>Yec
5-@J-#H_<GDG]H(\9=@C#d]+WOM0&,X#A6Q9H&4;K=2?>RCH10Hb7DH[PK0JKEXQ
]54ZCGcOF9PZAPLFB2O:#P7>SV)7<,WB4^:NF9cEU@73Z8Cb..bE^0#/U]GG:=ME
L.02YNSf5852&E)#<2T&OTU6&^gQ9Z6UUc[WKZg(MbO,BR3HTC)&O;_82FJ>7C1,
4Z)5]/F@ZT)0RK6bOHK]F?MBNaYb>#He:D\GSV9,BDdaG:N.KLcB15NM;:;P#\U5
OX)?a>Q.D_XX&c6[e]cXLSGRE-gJ#:/&,]2Pab;RE(G_N;0,.?;(UMPBV_:/._QN
49L:d#YO@+.?2Ta^@IA5:112:1#34BQ\.RHK@PGd0U-DJb2eAV5J=O+9U5U&=(UI
/8HgE-DGH#7?)$
`endprotected


`endif // GUARD_SVT_DISPATCH_SEQUENCE_SV
