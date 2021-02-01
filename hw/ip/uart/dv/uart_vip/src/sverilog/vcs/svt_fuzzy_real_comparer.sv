//=======================================================================
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FUZZY_REAL_COMPARER_SV
`define GUARD_SVT_FUZZY_REAL_COMPARER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(comparer) abilities for use with SVT based VIP.
 */
class svt_fuzzy_real_comparer extends `SVT_XVM(comparer);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Data member to control the precision of the fuzzy compare.
   */
  real fuzzy_compare_precision = `SVT_DEFAULT_FUZZY_COMPARE_PRECISION;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_fuzzy_real_comparer class.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Used to compare a real field.
   *
   * @param name Name of the field being compared, used for purposes of storing and printing a miscompare.
   * @param lhs The field value for the object doing the compare.
   * @param rhs The field value for the object being compared.
   * @return Indicates whether the compare was a match (1) or a mismatch (0).
   */
  extern virtual function bit compare_field_real(string name, real lhs, real rhs);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
.&e;K,Z;@6aT+C4DSKJZH<,+db=D6GSOXT]TRZO6(AV/Ec3_)+8A)(_U\FB7D8V:
f)>K^QgJ);JWY_A#96P<5,X&?Tg#DNL\X8]L2>ZFR2..3f&0a^MHgZa,/L4WC62J
T.X#./93;/UNSKf>)I@_S@XP+\IfSY&X&UIO/:4BRc@7WA):;^[2_44^(HRM1L3d
^fY+<?0BTb>^<c3=Y3G6W35CK/;GA407+^UQ)>#.;HMO;Ad6#FSSAf6/Y1\15-U_
[H(?CaF>JWK/e;3U=<ED?2U<R(W=_\-X?U5?Jaf>5^T&&G:g/(R6/6<_#>JAPCO8
7E_:2ET\9DYT4H]O0/-U<=U\037BdPb-JNee1R4,T_G7,W=:g@cDcY]8+-\(C/GV
[X(/P91e>VgD+e63I0/JR]fCM1PE]W71,[R)BAbISZ<<fGI)]+8)<d.Yg)TOMbRM
D:FRK8g=2CKX4^gTOf/f2RB-V[W.3OC24<cOY,8K,&]Vf6G@<ZZ_F8=P?WeP9A0^
4LHKQ:?@D>Ra#b>e4dU>eYgD=O-Jef062FE2Y91S-QB)YQS^XIUD9YfL8HgY:Za>
F=CZ9^#TUB[4-I;cE:IfJK(e:MM=2@@Q=Zb;gD8+<E1;@N@2>HdVAP==:>C>G]D-
O(LG7TgcT6;aUZgb-=OX3?I;)MGY5F+b(5dXE?O(8H(VE9XYP,a6>D;X(e^99?H_
&FG<X22.6P6S^7UJeUb0dgXa16GDHA+dLTSgJFc]Z&ZdLU^6OC\[L-723@?I;V<Y
SL==O=ZHMTY:,a?eWD>BbBZFY-LcZF9+@OaF614^@QbJ&>5_6.=JW),ODaZO_A82
@?KB5-[2,(B+dV)PFZ))?8)?._#U;HcSgO>cW)b&HMDUYKc#0(QBUJ0@_?8bU,DY
8dB)R7-EV3_R@&c-OcZ<G6bGP^f,W6)Ge8[b[RXR;IT@7<Z.LfdC-,+F^WP3\7W9
#\9N,gKcVBe:8Q-Y9N0Q<:#G.Qe,G[gV^J(>AN)PVPL53NZf\W]gCB(XO+#D(P0A
_LFUb(-DV,=N5?F.a,2U8VCQH0N</)K?6A-6Va>#2d7:aU:YU9b=50cgP:\C=T9-
Y4E+;W+,)#1OL7;:R9W^A\edP:LQ<?Ib[OBYN=,b?C2E-_f-bOE7OJ^ff56,@NT@
/a<H>eO(]7(>2cSXE+.W)S,>c0-]9OBS/Q7FORX#]3Z3W15POQ(aS9+4eA+^JC0d
GZ9^U+@P?RU^^]G=M9&;9CNV\B:YKMGDgf1UJC7ZG/1-)N.6LG)bC[+4J$
`endprotected


`endif // GUARD_SVT_FUZZY_REAL_COMPARER_SV
