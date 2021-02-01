//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_BFM_SV
`define GUARD_SVT_SEQUENCER_BFM_SV

virtual class svt_sequencer_bfm #(type REQ=`SVT_DATA_BASE_TYPE,
                                      type RSP=REQ) extends svt_sequencer#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif

`protected
VW;P=P=cfY/6T1-9c>&9>7#SJY68#L<@?1c392KOJ&d>3T\QX-47&)-TTeCV06RM
,E+CI34EKTbNC9Zf+JU:^c+>42[<c<gGRgCL3(;#?5(J84Vb[-;gf09MSS-R[6&W
eDOWBbA(8+TZ;9KTRO^MRc=)Sg:Z&>;STSbKTAJGGQ=&>WZY3=>ffN9MO$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the parent sequencer.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the sequencer's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// =============================================================================

`protected
&:&DO9+VIKL)MS:K-;;Y)WE.;Lc)?2N.#]JJ+LW3\0558bWY:bU;()cfFL48d=cT
fdIf1d,M5ZK]O+(Ba06Z?UA68a5>\-=B]ZND]#W+>N#F:7g\W1D(;J.ZB7V^UKBH
a6&D>U9-10_]A.76V.;Z\2QYC#HTJC5;1a./^90VdWBZA>4[-6CXYQCD0;1S6FB0
)36?W?>9;YXa.#:,A/MVI?.fM,O[g_X@09-<7gA@1[+^T?BJQaDYS.KP,eU,=H+Y
EO-C^JdE_;Ueed=;^D1?0(=3EB,E:[_]J@R([B4=;5CWb>E:]K6Y0)V6N0IY<89E
;.c4X(H=5VOEb_c&E61g5<+T6XK/Z#?D[Y[aP5B8TAL^??/==BV-M7Kb9JgY\18?
&]O)/#//UDJ1M]):5/f\@bV/Qe_gZX=#A@3L#JV/K:HGaLJXDFe<f07^f5A3bM[T
DbTZ+_[V@b\d60>V[BgOf]X4>f+&P)PIR.SN2QAXN[,3D]3SUA)TPQ<PKFCKcCg_
G2QC7B:dfR:0LXY/E9?.Y;1[PMYQbZ>Q)46[=T:SK9M[;cNYEYXZHfREa-2=.ZWD
7J#Ugb=]d]TbFD/:X54&,?M_We>Z3ANb^Z5e@cW#9+AW>1[7f(bFWN6#/N23SY=\
RU&BUO.XL(U)1Y</QU,[@T]62A0\N\W8N[=f9a97]#.fDZ]AI1=N\FCY)],<8+G(
>6#OBCG7K8Ge&bM/K-Ea1.cXA]bBO,E&RY&&dZZ6>6f-=3K<GYUAOK,,F]E,,YCI
15J]7RZg<COQ,SYPPP#PdFM>AA]R#+H0g;>>H^AD)8LIbBfC=1T/Y&HQ^[8N)=1b
C:1N8?N<W@X16>K>&FMSgc]DC#F3A3FeWRY,]NbTe<-a[(;^O<:MI76.Sg0T@1d5
<@Y]5P@_I)_]U@K3\QK3Oa\USFIaTGC39Y.X;a/gNF:GME/<K<U9YJ9<;ITK&WGL
VEbeK96>=Y.7,R2#]<0g]@\faT97_@.C3TFaL-XGVTJ^-8@-/R0/K;(4U@IXK_6B
MB53+4QKAT4_^UL[Z]+B40//F,EJ6ZVba50\FGd&@S02c.O>5;c\6/bNO?ZJOA,)
ZN(5:U+B&FQ^KLb8f<^N)O/@ePN+.OIP>,XaX=3ZS<DW;?51A]Q?ND[.ZDGbI\K\
NQMCCQ6>LAf:XLH6@X<]AGS+/Q3cZ+&:6LCJ]@38OPc&1J,[FcI3C20M&g?b43S-
3aYH<Q-56CG;L0NFD9/aIKeQM6FE[e]AKd>/MQfR6D:O_W:S=e7Q7UJ-=K=?UJLE
JgYN;G.[9=c:IaL.7R[BN8f@IX9^GFM@86fKO-^MN#U=ZK:S8JWN[YKM3UK26PfD
7dKb9)_9L07M\7a47O731LZ@]Z>3W/Ib\aX0PNQ5@J\)GHCYK5Sb43KTL]#1f]U\
<Q-(]E-W/^R=_&BVedS]V2[^dFS+M=c5c0;^J^.TM@-c8Y-=&Za0\Y+_YRYSg]d5
IPNg)a67+:_3>Z6f_L5)dFfMJ&]#NYV.A--dfKH#L7ZU4/#T[4PBObCGg8OgI8#K
(9M?PQ&;JGE2IU/+RH6#G<<(G9Z4<.0F<#Td[CZ=;SP(ZC<e+XJ2.ZJe6&4>NgHN
);W?(<5Y2@]&;+B2IH@6BO98(e:HQP(R<O;-/;-9H\MVTWdQ[GC9HA1+C&g8Qe:G
cHQBg45bb/dHc##+CgC[O&DH>cTdg<<5>Z:J#O+@MOQFAF(<.@VK4&]>)[_GEG9;
RcOW8E\Xa5^b=UK]DT?aUYU)LWLEX(Md6(6K_&DYK<@-?\\D8R3RIA]]UCF]IG-0
X607e_@N)_T1OI7HdDX4aRME9IRS5\(@;W[\#]E#GP:_656=[]#;/)8CaDY[ZF4Z
aNIG3/C:DI33BadL/]02/A[7SQPR#7#FDZD(;L-V7P?[D0Z2P1Q-YT3L[Z=+\AN-
\#fNFKd]b,?&Y#HA)Y5)^[2-\PLOF,9OY>MSLeC9[<(7gd4cU)[>#66(8g,1]e<V
[QIUAA2:478SKdB\90P4ec;+TJ.aG,QQL5WW18N)J[#41<X=)DGX31.MIc)T1&JA
/;.<T)0YccLZd1D@;eALLdX]N-(W1PeI;#BMF0RfGE;#CZ,7-)a;d8c/Jd:U?CNN
COUOL[f3,DQ4,WU#M18G4)2I-0^+FT=AKFE\L?+/f7JMZg@/_Rc)-?1R+d<^>THE
K>S<J2e;:P?<WQ=27_^B_P&S-gc,4NAHLF[PXC+fSHRNS.ZA.X/.BTVZV&VDQR>K
GIG7dKaM6E-Z\:#?=GLNF2KWa#CP(Q:B2OE0\fNTV<<]A+Sf2c3PF0M>C\f\S6B>
Bb&bEgQ,cZD(4=JDZ<?Z>/_7G&F>T[bSb,TZZ[QDJ29g&,4=GCH^I9&G4+N[[-E:
)d9([Dg+YY.<\dYVMe67[FJU>-#X@P=VGGaNCF,GRS5Z-0,<Q<PH4-2])NJa[0QH
PDS>e(Qa-B+ZY]]WHV(LSVD,PN9@E5\1506;FPf^-d[MA7-(;_?D(2cC(MSFHW&9
0HLA\^^>TKLRYK0.aI/e.CZMbO5-\GcN5UK1@P-727);U_08L4#7R]@9W?2IFJ9]
8]&[E^cfJ[;ZBUBVZHa+B+1R]/=:BR<G2bCcWPR<W?bHALf,WU5T,4H;DQ\?E4OR
23Y^#=?JCJ8RSAELCY#?728T1X)/?#2/a\^,MAB_VA)K8(JP<a.VML=2[&IH>WR)
2H6b_?-X0eJfSVbI:.,<MQFKV=5D.f2X5N+K<)=(:/<fO3RdHc9?2P\1=(BEga/[
.6<Q<5/ed1_8c1OaT+1#-?@dKe6ZV/_@EFUSGHa3(O?>RC=,R)JM^I67Cf8NU2US
D#7S<a)BPJ6IUHKH2<)NL[/D/9&8]3G2_PRc4bQ@:.=W1g>Z>V?1L<fb4IO3)?CH
K#U[T<^#<+A25RQLAX@4?A,]>e.#Zd3(/FBFe86a5&L3(DT\.M-g_66-HUd>D,9D
KFA:A7KZ.@aWSH34PFc10[.fA0?9YZRASSWPeEW)#c1ca8LSTDdLP/H>bHCH>de2
09-L(4Qa=AS6W:GcG+OL-/,,C1MDSYACC?=,R?f#9e>0[Y4IPD8;NB>LE+]f,DGe
eFQH.d&_gg2N6)^eTKH)-\6N=]b(_RB#ZFNL\ceFUaGYB-R&V2@YQd=+CHO/GPL,
Zb=B8&I^.7SW-[UG5UfaaM:R8W&a<81<f?2W?3?KU+F40dCH1=dC<c5BH,&MP72I
-P[G/4I;P8C+1(5@JS7F\GWIQ#SY@Wc=]].FYf1S:NAK6.JDYGga_e5I-=);HM3Y
fI.b54aKf,:AI,]dQ1da]D=d=E4d]9S)IEA[c8L/9Y(#eNLe-a.RP4ZN<I#J1-fC
BbCU=:96[^4D+W)-+7[b78XRdEZF,LWKW(M2?=L7IA>SX6Fb@D+S+ef;WQRYe)M[
,bGeB(K&>RH00>RAI71;^cT1?K<<&=adbg<9259@?F3V^-.27)04_.Ce)#&DO/?&
QFcY&#N,DdZG:SB)84]bLOgV_0\X9B86OUc0239OR^)?4U0ID?DO3Xg3+GT/fUHX
M3R5\24RY;WZC^3R)IX-YC_5#JP>BD\;T5F?=Y:ORLbU#De^(?D+Q9bC5E>9?P76
cb2@dM0FPGL;IXQ&NJ1U(aZH\(7A__M=Of[NIGee8K/@d;:BOZ16#6]:6/c;:@-S
)N)F<M1@GF?.J@RS0a5\#W0KT9>G]Q>\59I?PYFH&Je2#gRTWab&eHQ6++4@?(1(
@XebIH@VA^0EGgTVSbaTGWW5T=&+[+.2)>7+I+MdEPC:;F<F[Z7(N7^G24d^B-U+
<d>T/efKDL)++/6U6QI-fE/-N+&[5_0R_)O9dbOAIR-)fH^#c9LW->GF7:F45L5<
M=KYCUW#^.A[W6;-Qd/G4[RO41e//-3DMKbF+,<S3YVeP,>Ve84c5HAZW@<PE6bZ
BUXJZ[bAOfaP(8?R08@0&.Lf7(5LJZVYBWANIX/X5a\#&0-2Rd1?G4X]bRa[E;5W
LQNUIK(_;7Ea3-2S4B[ETYIESE7>FT5)fd2[/G;KCUN8fHEEL1ZE6ZO\[CQ/b1T:
aIQ.,cfL.,PO5#0ON#]=:.QJ]aMQ>6G^?W/,a;0A#@/N6TA4-9CLgS#2HU5cB66Z
NFKK12^]d.H&R94<;B;[CQ]=H,FVXa1LKV62MP04f-9FT+WN9Gb1c9E;T[,-g28M
=VCgF4dED@1W?EB?QeJf()567\3AD7#>P/&:Fc8e1:Z.D.:TcKP;9\P2F7V5\AE5
?H__>@Pc[NZ[.:[.,B@>IO[:d--N/Y_:U]Q^>Q9_UA.L?Se:f3B@MSFF0[8J@P5W
]0Y=B=+[[#CeZ1OO2<)E0[<IXT/5&Z>_+C#KO&\I_)cS7:OIK4WYabASAH@4ceEH
<gET.JB=>V/68GTTLO7_\8-IH<F4)TIb+@5QVLf+7Te@;Y?I/a[9+3S6c^7>36)-
1Ca]JQRfeJ,XdTcb7U&b(FJ6@<dVPC-/ZSNI0JM^Adf5[H;\-<bC2X)0S+Oa_2P.
ddM#W1\LD9dMN/,)d?(fE62a<g(M2AQRZ0VeAWE5-.B[0Se0)_#R-I:.(GL:.RR2
4_&R&M4>UReda#UKS)b4M=OILEE?Q@#:?JS_RZYJVV>&I80O\&&K9T.d,=0,\H/J
-BTB2?a8Y.-H1\L\?#BPWUJ&b1N/P[b]\JJM&AMB4C.IV@SbAGUZ>TcQ/D3D)[aO
T3.MdJRFC]3(=N^Q&8FFR_;=Y-F8WF88Aa(fBDE(b[5/S(J5153=I(OC(cDe>3..
b&?>9,:B#^\]U[[abGJQ1AfXIQ7X@C4<[_MC&ZC-@,C8.EA<E>TD0UCZ,/fRFY[M
KedVfDJ):QHeGUg9I0+W.I#4AX6\//T[J?&VOd(J][YZc&A-/P8\7FR+?1KV\F.Q
2O5S5+c_Y#=5XQ<\NUY3NQ2,MICQ7We1@Q?9J@Rf)RVYQ;SUJ9DM2F0BF1Ad1_C:
Q^cBHTSHc9&5NF^,dIA23MMa:CZA2[FW;S@(S)HQaH.HR3KM1gALK&]+SC+f4:OI
XJUV7XBA44FQd.WVLV1O7,,Z+QA6P/\.Wcd:VV=a.N?6,CZ7<E5=\BN6R:W.HG5I
;3D=XP[P&(F\_J:\Je;ga=f1K-a2fW7?):fC\aR0Q>QCB.PUI+TFRfGaSUCf6b1d
X<H64&aR/&:#TA=<6aHP2_F3G=3Z&EZUe[6#G3G9Za1_<=cgNXD@4;#CcH=NWOcV
#2/Aa2+DG=R^&f44C_LN=R&=Z3J--fY/:])SAAge/YA=gVIa&F4f;(W@42:Sba6g
YU:MW>>cNY93gf)J+)ZN4(a[0,#4JUYR6CRe>ZRRTA<CO5Ca81UW\A6X?T1GH>0R
Z-@@6QQBG/SW+EO()FG4#[<(3V(03K+85NVfeU_H91DI0O[UH_ZK])<77+T@Wbb0
6Hf;>_XCEF\=2.R^c@VD0a8_?5\3QSf=S9>;15NZF[J0K(9+Q:L/WA2[>_E/]_4B
11N^]F^dA/+1cQ-9U>05-JCVOEMbLcf]X?;B^X4Rf5GZ^<;;G:5_GHQ_@8>CEM@<
LX))d2aX@Z5cX1c(c&g;d8J:\GKPQ.[Y9WTE#RV;@g^]9)gf8:UB_=XeJ->eae^+
\a\NLP1EAFI.Y<.?RG<&J]fG0-OQD4RB_cMQ^9cTO-\e2&VSc(PPY&gPP6^PH[95
[+>gF3a5R/Y6>Bg;OGM+(8&P607[T12Z>@?g4K-\?E\K,6+O@cU+_e6D+Jc+_d^L
<;aJL>GgEefaLOCgZ/KV#J)&-G&)e=(J3]e-7O691ZP[AI,ML&@Zd,F=LKC.g]>c
a#<X/e020R/<.&PB_cS5BaD4PYBOb@9C(bcMX<8=g3W)_=KQDQE9f,8<#R8N^+)7
?d/DBK(]U=\RAT63DI?/-,Q3UA)A@.ef8bb84B<e/I10W)\WK9CAcD@OD+>06QPR
Xf038]b,:W@8?XYME?@V>_>N;)[=H;c+TB#5\58<,;+Z4B0R^7NR>cBGa,EOQa^8
H+DW9C<BQ1C^<3P+O?eAWF+L1C_D7+Z9Q(e;V,GH&O(:g1(_W[XPNII)4/=&T_>f
W[:WXMR6S?>c;X9D<L,)b=)2GP?NaWN#BXHHE;,NV5.4(Z9GGRg4G,^FS4TUgc33
&TG3=P0,dNOHca;R]U>3JE8g-+UH8Tg_@3d5b=1MGW_TP2GcbcGb;#RXKReK6)^P
aOQ?+XeK=I/QCHB\].JdaN,=]OCe-HgUYWaK3M8N3f+a_Lb2TRb#CTX;/^Gg4Vg)
5NLgH+3@A[W0;,L6<gK60bf&YW0>3>d;E/<9H67EOPdV3M,U?J[-SIB>]Rd_Z,Y_
QQ#fcL,A1AA7caZ=6Z)cKd=II#:@E^P0c(<;@dAQ?UA+&Ob378=D&L4-BLY:RNG7
/e[4I?9UPfJLbUPI51eDd80d\d0X\Z5YTd0\g[Y3cYK<D+W7W9+T<&]5^BOQ/4L0
LUdSX>RB;LT>WI@Ub;N8Z;GCNe5(]=;\UT\R2X3C\Ve&?T,d/BBBJ;:@S&/71:cE
Y8++5]RNQ(.f3e=ea98SYZ=,g#1.4ZJ4)1g#XTTXT[&D5;Z#8QV_96MIP@QeKW@L
C=UVKTOG)U2f/g<D/#4N_2XcU0>[W;4,1J()FBAEVbbI/AYJJZ@FOf+_3[&&_PeP
VT>[Q?R.,0@.D/O-b>g.FU2(Y,ee-LA5BFR[EEc9&C_H^M(L.M:]17Xa7>A?:57V
@OWB9PQf6K2>>D@9G-d.24TY2d9K9[9T9Z7.3eVIKY;4-6.]A9a#)&+R(^^/b3C7
<aVZ+L1\KPd=TRY<N3W5YJeQ>V-8FDBRa5SW@&24D)aW;9&4<:(1-3BY-5-)0?5T
=G0NW66/;]]fYZ#\0EY_>JWZ_c?&.JQE@MA#VJYP?W0SIL[RRFFWKF\:R]JN84WC
P7-R7F-=P:,XJ,322a[+7Q+7\-]<eLE(C7J4.bJ/)1e0XJ3D[QfGIfWBRTOX[D[=
1OfR5K21e;Fd>Z0N/OWb=Z?a3^L4JeR.\b5DPb3W8N2L+eG.AKZQVb_<-JdV5Z0-
bMD;NT9SY62YIDEO:RBT:NKT,a]&2A+A4-J6-TX.WAIL^0-/?4fgBaE,E-:V2J#(
dO/FWc/+N4aIU,bPR@X/K;Ca=GNgaR803J/+D4]\V^5=7G#^<XLfNO?I:e-_@cA/
?g#RXFH]@XU)1-QJ-G)[>=bZH>IVT5UK(PLSeXN1>PH+G,#<#[Y9[5.=C(VbaIU-
1T[]R1?_5Q7bd)a(2M,F;Rg=:[LV1a?ReD^2LYc,QT+FHYPQ-6d?R:@/3]:#fg#?
@TJ:?E6c+<2V=TgXO[6a(CVZ>L9M4bb.4[XI\X(/Q--XgQ&2UM?[IU&(L6b-<9U1
SDOe#@3B@:TFG#PWW=,F(B213Xf<G(7&5C/eX>&<O(0AHIb.5,1TL]QSACeUg[KF
V@QN,a2YdP2I8_K[gdK)&3;R[2=[@5SQ@HXQ9\0G\:6Ba72^Jf-49\2I/#fbdL;=
Wc-H]<KG\\,W.]-]=?2R+;6IKB?YT@1F59P]_gS5MP)+/[MaO-,=TIaU4>8+J1/S
dK.\2.1ScETTERD=L6B;/0c>a_O;EJ?B2L@@d1:DXJH;fdKdJW+2P#e1/#OAMV.#
8D1eaX0#RQ>>44HT2SWM@VfTd6.Ngc?@#AIX_=D^13S]LLa,VA?L<=MOPg&).2&+
Z5a/J-TT1@J?<Q42X9C8edMeN@<bT[Ib(YC=R9H7>C=Z/6#1O8f2@V#4bNc;?IL2
VQTNP-\;HMEAANM-d??Q0._BfAR]4Z:VJCTQ7H[7G>34=74S@/OL-86e^c?f1[CU
63eF>^c91(+D:(TLV.T7#;bG3(gUHF>bJDaVK&M8ME5XH(6H;F\[AYKF^,)eW[Y#
)],2(3K)W#gYHa/UL(I&^R;(:a]AZXLN22AG>WZKdEe]EDK]04eb\;?-g;aC[9)R
\6#<,BKDG=@a=0)_gW]OL>N;bLDcF\]MUC/a2N8TKNGFbC1E2Yg:c641G8bQb@[S
IYf-cOPB.IBI]OP+=B]1\YQRYSTW:V:RC]MIV>.aS-XY.gWW(]^b(>[0e#D<Q;N;
6843W4=+J-]0#G#7[7?K\RTRZ;a2?&-g[BX4IF<FG9OQF.bI\_?-\bd-\IOU7;bf
QYPHCaYT=_ZQP9(SH8<5#V[e8E#O=fG7<U/-d<8&2E?)R83Y-7K+VP[H</)/L>ff
XE@U)]XHU<9H,c,[#VU>C<]8\>IgC#@^bYW][+]PE+AH2=EG-\^C32F^T?>(F[GJ
:WHfEDVJG00Re[DDPFJN,a,-:31eGa4MSH(Y6(<JNGcQYN=?+UAWF>ZDJf>;TO?I
)017\VW&EfGNGPW:<QBEV&)PEDW43QDdBg22/100IME?gAJ?4fMHWGeCV8F#:Y+E
;W##XVT\=TS[(7J3VB1M/@F>LK_&(J3BB8[5<DI4-ce3WNB&:LK+)5,HPJX?_cK5
=b<+K3,V:aE-EUfM8C(+4;DM^4_8f]QEZK^,2NI+>H+;De?&T51Fb8NaO9N]#X_^
9T02J\5E(LW;Qg55[A>&Ta=_6=1VVfJXFCR[BYd,_P<FIQH+(cY:R90#__W@3]X8
6(0Xe^-^->5S6:5G0\&)\D0QPB:GVN):_[P&FH<+X,(.B&1-^E\g.1N+4&3+NgcC
=T_=S:UR[NLf#RN7G]BCL0H;^1U>]IL]R\]2Pb:P7;SXe1f>:TW)#)a]9P/,>,b^
V2V8).M^MUZ.@+@5d,/XYG@7ER>A&T.Y/X9O:#^5^b>ALXeJ8HfATW9I/\)7=5AF
ZT:JDZUg7;7U+M/7.[ZVIIaM6/XI?=?;R5&]UC30N1+aO[c4M0=dDd9II$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_sequencer_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_sequencer_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_sequencer_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_SEQUENCER_BFM_SV
