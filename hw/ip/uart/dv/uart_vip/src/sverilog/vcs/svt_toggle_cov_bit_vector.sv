//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
`define GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class used to support toggle coverage for multi-bit buses. Provides this
 * support by bundling together multiple individual svt_toggle_cov_bit instances.
 */
class svt_toggle_cov_bit_vector#(int SIZE = 64);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Coverage instances for the individual bits. */
  svt_toggle_cov_bit cov_bit[SIZE]; 

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
/** @cond SV_ONLY */
  /** Built-in shared log instance that will be used to report issues. */
  static vmm_log log = new("svt_toggle_cov_bit_vector", "Common log for svt_toggle_cov_bit_vector");
/** @endcond */
`else
  /** Route all messages originating from toggle cov objects through `SVT_XVM(top). */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit_vector class.
   *
   * @param name The name for the cover bit vector, used as the prefix for the cov_bit covergroups.
   * @param actual_size The actual number of bits that are to be covered.
   */
  extern function new(string name, int unsigned actual_size = SIZE);

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   *
   * @param bit_val The new value associated with the bit.
   * @param ix The index of the bit to be covered.
   */
  extern function void bit_cov(bit bit_val, int ix = 0);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
KV^T7FFF)V-_4SWV.UfEHADCdXae?T)>T5#cQ9RC]M=O4aB@9X@g-(ALC^-JQ:Ef
_eG\V4B[Ue^G&/H])<6#3?/W/K2F)a?CYJ37NG1ZcAba3W-J;Nf4<0^^fR)F>35@
#&-ZF9O[Q5[W_3?051Ug;a?]\-&8ZQM4-TW\P_eXBC?WaHK<bceHd7QIG&B8<<9)
7[?b95@N^2dUHd\[NXEW\2ATMC=&eGZE@9G[MU^]=SS1O3Ff_Ja_A</@V#_]>&bP
FdX3@#9C]NUag0C,A)^&-8J#L5VNPF/TZ(IC2DJJD4F[6,I.1O8@-)]Qg\AbH3Zc
5QGd&dT>5<8L-UUQ?]=Q_,R9LQaZC3=[K>PCI2\:^6bdG+cRQGIgNHWPc?\6F&dg
]:,7_&GA\[;[UH8\?05V9=K>?1)0>0MHRY7_?>c--a0H(PT3&UN&:-QT#&0]<>5\
3;6d]0:BKa^@F,K8-?\c4QG&:VG60[7_F;c,VB4_)6eA<,UYCAWHFdHe);aD;88?
3T9MYA<J(<2_#>708SAS@SJ1d7dMG^/Jc7L-MUI^.e4J0R_GB+g_I^S]TH2cKT7=
dKdKKS)M2\g_J9&FZfZ<&#bdf3OK]Ic6^2G[daD&90F=?+/QM\b)=0F=CY.,6Egb
1=U;A6]G/MdZ7f5^48I>\N1<IB>+GN<X]J\bA9SeB;)e8R475PPbQc]A_U:#)9A_
^.7<D)Z0d[cQ?[5eEVY8V[9\_7&(EGMcgL8?C#^/=>^&cDUgD\fa7Xa<0g<VOa6>
6\)0<-^/a7AU/YFfJCCZ(c:=OJ2#7(9P/F8G69&<T8@CE._@1X4O,<ZVa)O.K=\;
X/NB[4:[#N;V[SI_UA.8+OfMM,J_TaA1V:8^MSPFT]?SZPaQ^7^dAFMU=DA(O\c(
OD-;=<<9L9:QYUF;F40A12T=S<>4Q70QI:IDR-/:9BKdgJFF11M0J\Q?,8/CB[aJ
MN^]0/46PF3.M4.^7SL,NBQU;gKLJ-VOTJ,EE9&]e-^8_XRP.6.Y/Q+GR-;@eJ3[
^_dM#D406+S/<VJMVP+)LMR-U+-cSH2OJ:f3@5Ie64<@(([;V1X8dYP=)1RFOaV&
-#(_LMQ_XXL^;0S-fARg),T24S4-[>6Ed^9R]R?d5@UJ[.&O.>E\R+FPM<[HP69H
@;a:[&]J03.GO.T7^g)K<a)L(I4ZXLUR>bH9C0[/ZZ^AaZdMfU\HdgS7Hf\2.BBW
D(V:&W8>=)7HC9_KLP5IA,cf3E^W<PLVBc9W^BgRJ(,6.WY)]]3_U&&22(A+,U9-
[aMC,A?<HZ^I-K8:7^RD.S^E\Df>O[,g+?8^C&0H3)dE@LT7P=M-Z+SV2<@5Z-D&
9d5SaL;K>Z;=]B(PfIXPJ1b]GgMZ)4fg3T1EB=D;Yb11a3AL^HNH976@af#[L<,7
4A9._2>?#^W)(0:<T0WK^L#=U=XTLV_JM\dQ<UQSb);\QI8R95\S3&@dE&2V:?U.
.GH6fCZDTSd<R&X);;D.6I1INB&4.T[UV;X8gS63.R(9\;]6[gUK2Bd.8?&XCP@1
4Pd/7()O;gbeUgRHW:f1GY#<&P&L<;P7J9Y/cVLdbeY7<(VY;_OW>f0e#X5N/F.U
)Y6C50<;=2#1;AG;,b[2ET;HJO+,cgBZPL^VFBR&UTgR?#:<F7]]S,X#)c>.Hc:1
@18;PUJ_[\@[SNYO=&Na=HUC4DW=Rb@_S(32ZG\(+a\1NF>@0U8M(W8X#Ef4\^bQ
g4BBN;@S)YO4XNRTQR9QeaQP>cg6@?,HOH=AT\UPP=LZ4\5L&EKGY?6K5X+^6>04
21)FeW@04f,_:fV)E[-FQI^D^b[KXb2^]^>PM82TW</J+W61S-Z3U(_Hf0URT;6U
3FH5SV,HO0VL@Wa@BI_9<B]R<HW[DE(c;+C93\P)d<>[UKaLD,BYQK?LG703NOD+
cO+JTJa+7J,<4<?bQ>XdE8#H(\X.U2NQCI-8-_CaI#cG9ZWK_HNG6L+.>2ZK?^Z=
?FXX->9G],+YZ_YYYJ7,CTd@YFX/UC_N<ZAg/Hf1SM+[M+_edccg3LfK7E0XT_A/
c7[fcSaT,:F5<A??U#>01<4QE;F/,@1K8dV&RD4GUBEA:2bN&;Q\7RAL8NC1WgY]
GI5]a>Ga_0R7ePAa^J,K+B_S_B6ZW+1[SV??D[Z5?3&[_Xcc3,AG0VN)W#aSDSK7
g7C9,-0WK;4cOR-T2@?8DX56#J&&CZW_0]+.#XLU0]=2JbQHZLW@@1\Q<E+KKDB(
WbHf&e<JA1<SQ/V+<6Y.8U=@.AHO1X9Gg;e1K+D43XGT0T9/Yfbf^\+U93M/@6B[
TJ:Nf[F)aS88ad5ZfP;R[)acN81(NN5P9Y.?GWfT1XbQLdI^N\7T6S7><(WG>M[X
?3EHCc@8.<b/<;BEgRAg?GX.\S4FUYWM[R>GK:e_+WB&=1RF=9XMSYPH7bS/b4>T
e0QdIbf:b8gDaL\eO.@VdA:VdV:UPP1/:1W4TL]5I^A<d4E5/.2,G6/Y6@@.E;VC
;7_Sd=YKH/1e@WT>;dR+d6F\?c/PB-(:@A3Q03&S)BI+O:V@]:?7UF(aDf.;\Vd;
<B&<d\DXJ&=15M\4\R75bWL#2d@+UdC?]IXJOED^3-\997a#465)E()CVPaY5=:A
R[BIKM-#-A54MdG+MJO_ec<I\]Ea6fafgC2Wf;U2IJ[ZgR]+I+V_@=5<0NX51ePb
>WJ2=GFU#BE.0(P;K#@Mgg-aG8R<eWMKaSW/]aO>D-Q<FSb24AUW=3IPaR4>]LE\
Q\6,g-We#WIgD;^NT66Ob4BY/^4B616#T:SPNC0I/f8<-\BKN2XO5:<EUg9#(E9f
dG;70BHBDcDg.$
`endprotected


`endif // GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
