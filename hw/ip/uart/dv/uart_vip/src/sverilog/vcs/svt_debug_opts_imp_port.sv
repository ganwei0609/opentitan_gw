//=======================================================================
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
`define GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV

// =============================================================================
// This file defines ports which are used to help intercept and record sequence
// items as they are going through a publicly accessible component port.
// =============================================================================

/**
 * Macro used to create simple imp ports. Used when there is just one imp port of
 * the given type on a component and suffixes are not necessary.
 */
`define SVT_DEBUG_OPTS_IMP_PORT(PTYPE,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp)#(T, IMP))

/**
 * Macro used to create imp ports for exports with suffixes. Used when there are multiple
 * imp ports of the same type on a component and the suffix is used to differentiate them.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_SFX(PTYPE,SFX,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp``SFX)#(T, IMP))

/**
 * Macro used to define the common fields in the imp port intercept objects.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_INTERCEPT_DECL(PTYPE,IMP,ETYPE) \
  /** Object used to intercept and log sequence items going through the report when enabled. */ \
  local svt_debug_opts_intercept_``PTYPE#(T,IMP,ETYPE) m_intercept;

`protected
\_:8R?AQN8;fI_/;I=3D.-<E-SK0/T8dZ4Jb2bD60C6+Z+QeSJ:Z.)6Q^TK[^/O.
)[G&.0ba>,dM3(a9J??>]#]?0/\HWO9:d4<e\F0eeX7LAS5^/BMU&b):2ZU&^J2Q
I8-]8ILPH:)cYTTO<4/;+IY@Gb4/gZ;^TdA]2PMQ<1F><FfLLc&YOEHY+QT,fY/6
?FOQ=Y(2.I&1S;S_D\gg3d:2Ja^>g)\K_6HA4HVEPWFK-]F3K@,#f/T2H+X?SQXY
-8[f1XJ?IOd=H?GA_,-F2fd-,0?WQb@/2gUfX+S2,a[gJ-@I7]W\1G_N+ZC_X?J/
ISJOODM\-&Y(?5Q)9FIG;LYdG2V2+)WC9$
`endprotected


class svt_debug_opts_blocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_put_port)#(T);
`protected
FH^O<^2S51MBeI)]eWCJ^X9QJMTg>0-5cYXW-L#?1R+58TR4D,JW3)8SU@f.^aW?
9RAD-.80JPUI72&JJCE13.3;>[P+PN+PSEdc_d#.Q2FP&Q34d1PKXI?HWQ8NQAeQ
7W@-Jf0)@+Ub8;A[B^L:JJBTefJF[7S6K-J2?A5VOWb8:C5]().V@P.eLX4QP(=H
JB@OeHX/AGUT&AIHM_@TZ;BT3$
`endprotected

endclass

/** This class extends the nonblocking_put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_put_port)#(T);
`protected
1/OG4b3NdKe#DFXW&]C20CT:Oe_(CQB7;<Z60BSeUY5Z,Z0<O]3c/)dQXGX,dQ2X
PV4RY+Y^PE-;WG0LLXQYYfH\#_=@^1ReKY1X9;RNN:[bFRaG2:7VJ=1O51Z.eG@R
_F/P[/ea6CEP-@b57LI0g@+Iea[FBKbT#W?aQ@@0@fd=<FVW;BRAgN\6EF6><@Tg
&Ae9OIA2bNO[/[Y.R/OI7a+I6$
`endprotected

endclass

/** This class extends the put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(put_port)#(T);
`protected
9Ud8O;)Ec43Zd?EFI<7SBM)B.:c#&3T[c[3K>_\UWO7[;@ZYNT(51)//ICC=5.g=
DGM#e9g^JK[IQU4<aFd9W-<10W#4.B,GF/O\[L#UIgP;_272#gE@;(H\/4T>Z\7K
_0bUPf7_ePJ,85>g0g9.Z+5KH6C@gF3QC\@=)dLUL(5-IZIc55ZI<KDbI&^&C__M
PcY@YZ=/eHR,*$
`endprotected

endclass

/** This class extends the blocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_port)#(T);
`protected
57#2e49J4]P.YT.b3BTOd6#7Z[-faD&-1KEHa_JH@46GFe1TP,>P&)6G+>O3_d]+
.78]gdW&Sc0(##VMJ]?bJ_OO4IKYI3-&Y;O@WQMW\@dW+a\6U17C:A\A:3E)UaTZ
;58<O,<EBJ2E5E\J=b<O\Z5MfLNSUB8U?>cC+EQ/;C)_SUH&()9LOd76Y>g>3BD(
CRSA,L-D<E41)SQM>>Y_\B5M3$
`endprotected

endclass

/** This class extends the nonblocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_port)#(T);
`protected
K?-@YU[da5bO>UF1[4R1Ud-I>/D)^Ha7Zg7]X24SK5L[4Y:9HY1b,)@E16K/f?F4
B&E9+65\eUfB/3/0S/SCL0#UI:6RVY^2?G@=gR>dTQR6g;b1K+:VQ8PG)69OBRf/
:(4f[XZdb/><9\N;?6<HcLT:b9L[W#E\;0B8PR/IUOf/dKK[OQ(0eX]F[X5+PJ(.
UM)@)PUc+9eF(I#70D5_S/T:6$
`endprotected

endclass

/** This class extends the get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_port)#(T);
`protected
SJ>)W7ZY7\aVed5aVNB6K#XSM76>D5:UgPG8(W^WMc>3P4,UY.@)6)PQ:P6,>^.[
_RV&6<dL<dE5Ha8(0N,(7FYZPJEaBU1IQ[)d1@+42NAeXgA<\?,7H@UHE:>^]4&G
BSTJ7CeT?_0I0-bT0>Ae\,)#\^-X[=;V14;9@c_LcDC&)@O+L(=,TJ(PE-?c-\>T
[PGZ7L1?S6\I*$
`endprotected

endclass

/** This class extends the blocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_peek_port)#(T);
`protected
F@LZ;g5)F5PZ)\#P_JZ=1]<b15=NYP-7/9UDL=JJ]0K=,<&U/(Fg))9=U]Z/32OB
S,#Q7I@7dY_.C,7>PPKUU..0.T9@?PaD&Q4#3V_2E(5H[<PXD9^A-83?R^f#0I4H
#=]-^//.I4.^K_Fb7EG9QMUX\U20<W#NRK;XL-AHPYRWeLU-LW=]M68D@HE,N\\H
bfD@L,W8PVLH6[V=JBDWa/UX4$
`endprotected

endclass

/** This class extends the nonblocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_peek_port)#(T);
`protected
BN7-8M/YSZDH5;)&2]1-OQ9eMgUC[DaSMYVF\__-F:UJ043M)dH\1)U&==I2:A3C
:2.,O8H>;Z3Y3f4RaY;O(0MZQ#M+DVD6Gg@X0IbHJ6-4,]1e?-O8VCf-8ceEI.EF
eR6#PWFQIG^B[+C?N/A<[c6&/3O+II_G)=YC00HK]R9(S=g;52YJS_MZG,@MfVRQ
Z=1b1U1c9W]X><2CM,B7[c6&7$
`endprotected

endclass

/** This class extends the peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(peek_port)#(T);
`protected
YYVO?;dJ,(:W<c6M#gGGN#H&24;DS3N0<4bRT>;]4Z\6d-89SL>N-)\/]3[NaRS-
I_/62=b&;UG6MHE)4D9V@e&EOXZBaCbXK[)+H=1ZASB8,eaKYQ5MM#Q@;6a]9Ab\
XNZ?XY>N_R\6[@BKB9(1dF+#SGa[SB^8Y@E6E#,e\;=1]=2=A.d]>A8DK?C>7N,f
N9?-_SZb?OI6+$
`endprotected

endclass

/** This class extends the blocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_peek_port)#(T);
`protected
HRTTQ7D;/>f#YaK4MU=]3S5895.1#-TdL4_W_YJA5_M&KP/Q][@Q+)Eg?82<g-\H
Vg2,]/H23B,5V.5^S[4aROYM=g#c>e>;^M<01FbS>OY3M_R_S@D34JAbL2?-IS9#
9\->_F05#)bbP2S>0QT&cb/21J.)C/6_4=3JZR:97-VfZ\(-&#(S83@dOQQTHZD[
3JI-DE8ZE1K+RbLQe=;ISJ/28$
`endprotected

endclass

/** This class extends the nonblocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_peek_port)#(T);
`protected
4YA,G>eK@M41c1+Q&Ja^4Y/3,)<V_EA2bEP;6YU//9U?^<dA#TaR7)&IdaLB3X=I
+B]I\?bH0Ec(dPQBP6(AML<OAg^D+2P;:)9I\[>Fc-cS[>:][7Kb6>1_#Hb(g68g
^/YD0J:YH:<8@.&/X0Z9PYX62/9@^.EfE/\f9G1.^2EUd_G;+Q<;B8##N9eSDKeU
)#YFZ[N>ZcfI95#X+04>S=0G^ZQR],BZ;$
`endprotected

endclass

/** This class extends the get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_peek_port)#(T);
`protected
@H7a;F#6<ZO^\+fLb27M(:-/[G4g+fD&PF<OV#+c1A9N/LNgb=L8,)<5(]FCXAXH
P<-BV9#925;a>2^^>fPcTFWe/f9J]J@.SLa\De?Qd\=ceTED_I]WM1JcBeM^(eN2
ac/;:GAT00,_FNTV)_:W<39L&U)g13;A=37/Yc/=K.R^=E[Mc6)aF/PLI-S20/4N
+3K[QT9[4>:_/$
`endprotected

endclass

/** This class extends the analysis port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_analysis_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(analysis_port)#(T);
`protected
.R5=^X?YAOICZ0HF2+#BY:/d6;I5WHZHITOfB/(V:NH:fP=42GR[0)N7A9Q/GSb4
/[ABPb;eIHT@INPb(V-KK<J+KaKCD2[.^Z?J^b/I>3^;_WK1gfO.@\-(.ED33D0S
D_)J5)OYEK0\S4&MM:;6gVB0/023f4(@b70D]\(.,_\f,^L(;W;DB+NU0_;Pf0?\
)7f9d<LVUJ5&P,egI+8K7#Wed=)\V6/06;R^;e9Cg@3L1<HbS.I7-e.e6\0Q4G4F
A-O2HM[9N/MWK7;;U+-.SLU=A2),G[7?W[fOLeT2_G39a)]T#H(94+Q)ECIA+KO&
B.-QbHKPa<,/gLWYI_T7C3XVXPP(2D_&F(^De<3]S/L9F$
`endprotected

endclass

`endif // GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
