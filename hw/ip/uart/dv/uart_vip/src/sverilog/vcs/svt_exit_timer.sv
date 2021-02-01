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

`ifndef GUARD_SVT_EXIT_TIMER_SV
`define GUARD_SVT_EXIT_TIMER_SV

//svt_vipdk_exclude
`ifndef SVT_VMM_TECHNOLOGY
  typedef class svt_voter;
`endif

//svt_vipdk_end_exclude
// =============================================================================
/**
 * This class is provides a timer which also acts as a consensus voter which
 * can force simulation exit when the timer value is reached.
 */
class svt_exit_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Voter class registered with the consensus class that is passed into the
   * constructor.
   */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  local vmm_voter voter;
//svt_vipdk_exclude
`else
  local svt_voter voter;
`endif
//svt_vipdk_end_exclude

  /**
   * Name associated with the timeout value. Used in message display.
   */
  local string timeout_name = "";

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, vmm_voter voter, vmm_log log = null);
//svt_vipdk_exclude
`else
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, svt_voter voter, `SVT_XVM(report_object) reporter = null);
`endif
//svt_vipdk_end_exclude

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. If timer is
   * already active and allow_restart is 1 then the positive_fuse_value and
   * zero_is_infinite fields are used to update the state of the timer and then a
   * restart is initiated. If timer is already active and allow_restart is 0 then a
   * warning is generated and the timer is not restarted.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   * @param zero_is_infinite Indicates whether a positive_fuse_value of zero should
   * be interpreted as an immediate (0) or infinite (1) timeout request.
   * @param allow_restart When set to 1, allow a restart if the timer is already active.
   */
  extern virtual function void start_timer(real positive_fuse_value, string reason = "", bit zero_is_infinite = 1, bit allow_restart = 0);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
,KQ/Y?W(/Z+?^Y=U:b^+68-I-/I99BQ;1QDB3bI()<WaGM:7PO+S-(+@XAd5EE3:
.W>;a,\a+\O7WeXYW_VGJ2agOCM[U^Q^gb=WESG>9Y17N1aS)BG<\g0KBFY-Ha7I
F6NIfYF8d+e))6=^Od6X@H2A&]_HVRe3J4Vf(8[M(/fY5,53VAf5BZQ4C2)f(S5a
ZFC15[E@T+S>/3<OYfG0Ye;_BJT#=8()d_NW5NcA8g3OCD[T5-@E0CLA-a;0K2TG
4c^A:=A]eAa;6-LHaZ(L<aC(4fREK^6V;F4@TSBM0ZI-e2I:dRV+=E40O:8J9=:#
H]AG&;^472US2:PPW#JH=EC_8_86W,.+-=J0(9]LQ]+I536CIfDSH89>Xb3G971P
27LE4#6?[Jf@.g3A[PIG8(W8.&1O@8[Ee(7^J07&FNTW4AO5T=SaaV,g41NA<BLS
UC,M-B&c<=[#D3_9:(JDOJaW2bYX5@A(D8RBB<50F.4HWDc@KUeaEU2#59XN2=KL
N&#RP9SF(b5.]BF6WAe5P4/\,)K_>5cYEeGQEQ+M8D,ePY3KK>MGQUJ))6TWT?C:
(,<g0_Wdd.S:0WDRS\06YBUeC1#&[X868.F4WFWL;D)?e_e7QXQ==c;^dFaTBEJP
]?B-4.85&&V=+3?#DWKBF(NW=cCPY)c?1)M9FI;fXN-(M?\=-Mad2:,&_@6AY7=+
;aE^./T5DAaDQ#eeQ3d@<Q+^cMX]g.+/9SW#;2c#@g97aIg)^IB-e;gEc\X3H,4)
aV?>,F_f1/JAEdb(10W_R5f:bR6O7QTA;:G-_=AbY9RDd6_L&\;<R)Y1_C)UE#?3
D/b.b.b6KSfG)QXICQf@S_STT8]d[H7(3e&:A5JZY@23Wd3N#O<>4Ee2dd&R>N?f
N+D?R6WG@#+\?Mf7e?WLd-CSW>/@cN16Y=?-2W]G]U9Q,RO=?;_?-3=EU<F1M8#=
GJ961#OXM(3>K)(U;4BDKI_fC#RRd7\gSf3HZ\5@+LX\cY_U:@ec<@-B8[X1Y;\8
)3B+=O.;?V.fQ))WTQ8GCU._&WO<];,cB9Wd7dJeI<5Ke1Nb4KT>-).OVJWHDYW2
[V@TH>L#CD>aSg999b/Q#bXCU;=E#K]0G,&7]T#@8ZO2Lb>TY[4PMZ#@X/V5=2M0
)<@+IQHT<@WH^?M(.(U&46\J(0SPEcT8-=(D<VdFW?d8?8IS71U(f1aAT.E(X(>N
9CdL]5#IT)4a[bUecdJc@;4<f8fV3Y^)C.]K962V)7ZQ)H10A_e^4,(1=3gY0Ha3
:J@SPEBeHe7Y#4[JL>:SHd0;[1VE0?C:fcQ0^d^#S>K+>WL-3?W5;LdR)./ORM03
RSWe?=>?5S^^K87F1I:],V6[#OJZ74)07@X<TD\#<>R+RA].<2LE9F,2J.:SQ5ZF
1#.QGJ38HYH=[0]&?=Y81]Q\Dd7F(\+CYTF_]UbW,c]L-5LH=:EbN;T0B]:SMT#d
:]g,U^+LXH8CH_56I&efgVU,/S^EQ@Ybg/aB;[?5DVW0^-Qd^8ga9:>JLfIC):/Q
S#:b2B8^_)M/H:D(,_f1H>5#=WB.D[A[LbJ9],ME)QDLJ(MO<>J-1VN40<F3<K[0
]c:7#;&UgOAD2B2.G#gd/@(gK\>O^>g&SF>GX;QH:[/>3K6YR2>I2@_L\H1A:S;K
PN3)Wa#,?5R0.&X&Q[+e>+6Z4IKJ4D0Y&8U#TZQV]^&b:@&4b+E;DEV)]0bdd15_
,_fAgX7TD9#gbHJUDYYN,^DA5eALe=LZ516V)55B;5H@&5EVL<KVc:D)K1^g>1#W
;TD5b41^bNHAa:R/Q>]58>#7=)1V\,F_MU9/?d4)3?IS7ZdT0@GK<EB:PORd((K+
R,L-28Uf&J\([+X_RXR&)DfO^?2AHCSXDMd#76A+CU;1a:L9ZRM<F7?.)-Zf>>5d
4=7YCcS=\9OWdQ@8+ZOBFc(06R1H[c?KSFS.c3ZQ^9cPSgUA_W#K@-Nf7T^aW,;0
HJX]:/@b5T+V^,]IeS8H#P0/G>(SZD3IgBP3fEa0-[?M4.]g\Z)J\DV]HO.;de\#
V,VMV+?2c/&c\84QaWIUMIcHRQW,FQV,1JKV0+W_TP3[&>a(2H.P5V80-[<S3GN]
+P(XP242L3XI/A+cMd0.-bfeBCOG=D^4Q6dM(2(6NXIKgJE[SY4^)D6.&:-9OI1D
KEQ3^F8,Sg(f.?f:>@(IA0dMO@GP?9ONKM=;UI:Z1@AIN;FRaaB_dQUeDA)1dK):
?D[L5&+:e=0(6>SUO&NS1aR=/aV6PcI0O4PRJVT.&e(8)fM=f&d^F5:3G#)KcSQ@
cX1<AU.-9=SCK@D6E]0Hc?A,aZTcaBZ[f2/ETfDSOGg/.eH<QLOO[:5ZN<ZF4;#D
>M);P8MS#+JJc#Z,S@7=)bR=55_=aB40aF(R\6aN7C,H]f3bE)/f_M\H,Af@O08Z
OG3N/K(0DT]SNcB>;Q:?d+^;\Jg[aW&d(<H+Z0d\cY-.@V]_36P>CC^]7f0Z8a.M
eaR3X>.AXR](3T^4VJ]-^9>-f<F53D,(ag@HT)#6<KPA7I-FV#ZU.d3d:g,^],8C
MDX#.A;.4)@_EUAXDQJ&J+F@;B@eWcROgL)BDR;HO-1VcUP.W4=#]W&G8f,W0;IY
VU#K<4PWg406(_L\4\@84gP3a<8.?I6dJP0B,CJ_UJOaM[Dd+XMW8FcHVfAZ[P+8
K2c&3=DaFePL,HKJ4GQTO@[KPEM#e\Hg:g9MMUbEQg3GETZgdgZR0;f6K3acEa5I
R-,@Y<07V13:fP44B4/?f7cBV2G]F3^OCRKPVeA4Z5[e1TVWbA>JYeQY+ISW^_&R
+^,8JPGS2WIF&fNAFgI:cQ^?U2Q/Db7]bSEQPReV\+;.DD\D.I3C8,,#e>&>F7ID
J2dT3-\J=)S)=KP?)\JG#)a1@M./,5;<<KJ/8<?X>J4JPaUF(g1]><FbJQ-[G:gg
eM,DKbR;g/?E,J>V8>L,Ib<KA&H(^d3Y2.]:9>N;)_ffB)?7V:6/J2?-\Y0Q6BgH
)fdc^^XPO?\05]@NJZC/+/S?MVEEV)<;PCRbI:_J]M-&3)d6KeIe9G,X9\_<c:95
=4g;FA=2-f0ff<Na_C^dUL.)gJ647gVT-6[a75?@,A#P)VZPV-]Hf=H9SZceP\@@
.V+9bVEFeR-d18:^:9?X3^Z8;7;(1SW-Y7aCD7(aHbHQb5TQ=65-.1RcLJJ_U6<W
,=J,=4@8GW^fc(00NS-&P0aA\+gUTX\A-ASHgR+MWRf22-SeY])1RbO<FALXRK1R
P.Y[^=g73#X+P>H]ZZ]HXKgeP]7IC>-[2:Zfag^Xf<#]D1e#b5Ig[)L<Z8>P&+&#
A7Z^N38)@\\JKZ8L+JCM_R[PIYFYVX1/I>5^_bN__^ODe>2Y[MORa<NAI,7eGbTB
d#b0ZW,+-(C0cQ[c<-I<0-Yg>F(]eG3R4B4=/;;3DQXC[+KXRb]):7.DX#4TI(Qc
bB6c>SLMbT)L#+SDFe4e+Q/._?2->H&JGD7aI>)#(153RA:OW[LD3U_54]M3YD[g
FQP>Y/IB[9[6=>Z&2GTB+X(2-I]:fbU:-?RE=;P#6cQY+5P^S>OR:#>.e+34.TcN
4Q)>\a99gdCCF4?.cS4WGH]bZM7OEg2UV5Xf)OG[;Pbfa@68SWd1,ZO#EZQ^4aJQ
fA6;9+g,Q5SE2.?UG-gF6Oc)c,J25#B6>:#?N/I65FAJ@+M]9Q>S/SGd0Y6X:<FT
QV:L4/#+T;&^C-WB[V70]S1b&a@1L8Y#Ee4)Z.dD8R[[>/W;6;I#D,-;7(LP2-;c
3GVe^QbCI-L+,7T<]D;FA_:&EZRb:d;PdT:[fMJeTIP[E$
`endprotected


`endif // GUARD_SVT_EXIT_TIMER_SV
