//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
`define GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV

// =============================================================================
/**
 * This class implements a multi-stream scenario election class which avoids
 * disabled scenarios. It is designed to be used with svt_dynamic_ms_scenario
 * instances.
 */
`ifdef SVT_PRE_VMM_11
class svt_dynamic_ms_scenario_election;
`else
class svt_dynamic_ms_scenario_election extends vmm_ms_scenario_election;
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Flags indicating whether the scenario_sets have been enabled/disabled, populated
   * in pre_randomize().
   */
  bit scenario_set_enabled[$];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /**
   * Constraint that causes select to be chosen randomly while insuring that
   * the selected scenario is enabled.
   */
  constraint random_next
  {
    foreach (scenario_set_enabled[scen_ix]) {
`ifndef SVT_PRE_VMM_11
      (scen_ix != select) ||
`endif
      (scenario_set_enabled[scen_ix] != 0);
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: In addition to constructing the objects, controls whether
   * the randomization relies on the VMM 'round_robin' constraint to choose
   * the next scenario, or if it simply picks a random next scenario.
   *
   * @param use_round_robin Indicates whether the next scenario should be chosen
   * via round_robin (1) or purely via randomization (0). Defaults to 1 since that
   * is the VMM default.
   */
  extern function new(bit use_round_robin = 1);

  // ---------------------------------------------------------------------------
  /** Setup scenario_set_enabled for use by randomization and post_randomize. */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
  /** Watch out for disabled scenarios. Move forward to an enabled one. */
  extern function void post_randomize();

  // ---------------------------------------------------------------------------
endclass
  
// =============================================================================

//svt_vcs_lic_vip_protect
`protected
CVL_#@He?/ZW5-KJVcI8fHTY\G#_@6V3,N/QHPV0@TUE+1TH3YBS((_GWZYge&:T
;<(_fAW.Q-HZIKa?T\@=#^G_L1I@[[;2R8GDSM9-HCPNS&:f6)80Td6FAbc,?DW8
Se,P?fcUM6)]>3e>_Uf>@9,g=SGWFKa[5@]-(AP)d;c;JFG<;82eBQg1@8G:>\\O
MUeRP-_[,W<6WABO=3_/+2OLe#4b>X+PM\UD:>4_V=_SMa82ZU&()Y.3b0Z1@VS&
HGD,EbZ-V:0Wg^4,VWU^E5\eRaN?YISBB;Sd5[ZHQ\9^8@[0I&33.M3+,H(ac@\Z
d;9W#>a6M)AK)&CJY60(7/M@3L,M&O_7ICR,INWd<<^P?^#ODf0&f(B\PFZ,1]93
MKW_P(6gOOU1#eOEZe^+E^Q&EX@JW:,\ZHIWIELfPd1Y(/;))O@_D\\:3@[PBFS=
+-?;62gWa;?0]-6a#@d)[d;1P+(VW?MS4OHMMBQSV9fN08RY-5XX=T3,A#gG7(F&
g,cU;TS8g/cdg/eHI-0Y6^45W\BYg,@B9DG<8Q>HCK8ZC?Y-Z1F^ICc?AH+@JUe8
gK[aNIc51f=TKTgHg@Nd<@[aWf@66dWVE<Z^\P[B/US)2g(H/)a:C^WYcS2Ud470
<WD2]CbL?5R6d.0YP=VI(dcW^PNK<d5&..>1O,2I_YcY@SYZ&8NGO8aH?Vb>a.D7
CNR?]=Lf&cd,:/>G^I2??gYe-R9A4&\<[PbUUT/7-.=N5CR7FCY@GB1#M]2?>,Eg
W&aFYA4;E\\+-U)-[7CdF0dX9BK?VG;-[<.3ULf14:V-)FV5(ZZ/@gbM7Pa[ZdXb
0_6J(_N^aSDN+,XI)<eFaZ3a,9<A@J_#A&P/SV,NNY.(LUMEK0RaE3S,gA4a9-=B
GVYZ++VB&X)MFK,JJ10f4]:)7<fF552_D0&MO^9dX\5)8/J3TY@.+6ANZA?\dLg?
Af6]_30Wb12HXMF7RJ&_85)bD,OXD6=DGf/X@L\NUe>8B/TC?WSNcdd1DK[8GaP&
T\ZSY;_OKe[=;=NE,<FT9/a4TUGTNVMP+56:dQ5RGW&[6+ea(02VE\f:#;;/GaZD
1)W](8ZBJ+DE\\RJ7K2KV=<@EP6?-1OfL1)FQ#T6Z2ITf#?].:F_;F;Ia9G[d<-&
RfS-<33JYN9Z;-^BREDPcQ3g]8\(C=FD^K<Y[d<?EKNX>K9KN[e,UTL;CXdS1;3N
G^1A;W=dFQ\=W0fSRCTNfa]3\a[:dC.?KB3G[N@cAZ(6O8g6abSHdI0NI&@IKA)G
JG/X#0I3.f.T<QYR=CLdUH^2RN]cCW]LCM[\<VB.2+B/B(U7^G310IUQO+K\PfEd
MD\/C,)-D;EUTORK(cCeOY]AcFFQ#(1O0a9FT22L92JCI,0X\UEYEYL@\Q5#&(GP
5MVK(,BCgfGWGLHANDO>S]R_K-6[b+e4N:\G1ITI68-]^71C2;YPb7YL83>2G1VQ
bc,)(>=4IF&/J(Z[T?QabaI=RX4HC,ee3SB)L4FSGX\aM-CFe<dE+S,Cc,7\I#TT
YUV6/,CL\8D5]1fU3YF+H9?AT]3d3?MW4F.2QSF><(:Hc=XR;DP2NaE;AK##2G^^
/WB(T>M^K&)gN^>a^DBOFWa8Ec6f_-PEEOF+SH@SD-e<dSb9>MbA[N4R18V.?:^:
V7eWcHHGBYc?(=S9CZWZf=0(Q#ZN4Z#8IXN\[B/PebcBB.>]^OKX54+.c)]+VV#F
d[:DRA:\MCU<<Bbd5=F+a,,,5e05UUeB=W?,]cUP]CI-Jf+a6T]VbB-P=3[)9&IS
.&0G9L:a=7T.Y@[7cT]UVU2L5#=:fYf6MJRaGN?7IPO)(051W@9g0UW)GZ_./.G)
J=1)VF^P>+Pg9Q99)YL=^XXfZ.X:gY#PJ(9^O,P=9O#-\Y=HZL&(<<a@,\?8Pc?\
0>Q<QW<QbI9S?F>I840PS:(V&@UJDSZHH,\f&IS<B.R^AE<d/[dTaWe/8c77O5M7
-#7(a.YKVO2..Z/cWTJ?I+K@Z0aZ(SKa_Q+&:AMIg#+\N^f\@>QEbYP4BZYg5NA@
c=e;K?+=+UJf)c4S1f9bG>C>)+fJ6DLf5S)-9gDUZcYC@PHG>d=LP2CT2^RM5Z96
bSR_(HY>V2B1R,K92&53&CZ#eZ,AY:HA/3+[ZN@c_..E1ZC&:\X(C-Q=VH[)(;Q/
/_0V6K9d^<BUH;Xd:5,gM#W)3^Gg+3B=T]:Fg92Z&1RF>\)MG^ZZ:+G0^5:8?H=X
F?9C#V)M\acEHWQ=c4EQXBc=YLX75ALZIXS&F<MLQC;Ve[.5JL9N:a)M2L;AXLKL
8VWfZ>ZA(II_/F@c/>[cG+L/L&U]QM@<_4TF\Q(?\c5(5(,g]^N6B^f8Q8J:JT\R
&c]W]T+I9KSJ[M371&/G<#+IU]:3c]\K9&?#60aD_[(UNAdfY(D/C:ecIE.SHO=L
A5N6C,JE>09V?L>1KLV<)K(a@c3K>8:M]2Y05JIBD4>8cc1<GFX=?>.SMV3.[DK8
&d7g?_H(8E[N57T&T(3@fKM7bP0?B)8e_T3T93FK]5+_bf=[2N;??#1]YdSBW[5#
4d2Z93S/BHbT_gLD1GEfB97>(JR,BJNc:&bM;OJMb[6C?(WNDFLC_Ie#4#Q]JX?]
X3[L&/_AI;<ED9MG0R/6N0O5cA=-\-AD1?X1]9(P9J7]d3&_E9;_?Z=YKcWQ/Y.5
RZA3b54GQ\YFgR3=DC<-/GN0BT>P=QKZSW]E]Q;@F1?Acb/KVP3=HLANC?94WQKf
9^6eBVD/FHM77c=-f:fFVLaAVLD<B-MHM1T]f>&0-GXI4?Z-/T.5D2ER\&+G>_cd
TF8;EP^XR8@V8U6:T@P)XTBT3;Z0>T6RCUJRfbKBF2Q31bB;?,Z_:4_^8#a[K#,X
YLZV/23SIb309/cIN(]IWEd\Z&Tc[K\FfNKJ[7>3E6OMR#=GNMB9.#IDYV4CAM-:
W9DISf[&,RUMYH\PW;1JZ7N1@4LGO?3Y>)fZA6AU-,M?2.MX:LdP5&ML=56F;Je>
KRcUE[<X,0>#?MIIBMK8S;E9LUG8Y[Z0I.K#LR9116ZNId,.[<:Xd4&L_>U@SdW\
F65E&:56g&.;-W3PVESD/4;WFZ;Ng>F7IQ?-Z(Ja?S]E@c^7=/B]edZ^M0&_a4;-
ICK\&]6FW5C^?;]HI:9&BGeFF6<X4[Jd+OR/#(a<eM0)T634>A<fbGd;<d&0gdI_
N^ALX3B@DX@J9KG&@JC==3^N4KM5UNSQM+5^Y.FO/g@5MP(-,Ea[P3+9F][)#EP0
B3Ja5JK#f-0@a2.3S;:&b;G..;\Z+Z:_K\PPIZU2Yf\&?BME[K51#g;D+-R,f6R4
QKRE,=9?SfJS(6C4C>=.:S9GSVbA-,9)T(5N0)JF:gRdX8Fd0CUDC5S^E._bUHG<
_RX]-.=7R53O>I9;MWOB)XPa)F72<?64]35U;MFf/J3=[H&b07?0(>acUFgB3=:9
02-J]8Z3C++3+^.[3eBHc;fXELHMMB&3JR)bV/X0Y.bS:H9DOQEH9VcTSfeR>E;L
\+RS6L0;Y=(E5@,W^LESJRQd@a_MM;aC0M/91d@_L&,?,PKO9eC&(a]I1=4PCI?f
=gW9b:LO(.GKIRcZ19P/W26?bUQ<.#BNE5KLaL]8?L0=B=0T4UF1f;aXLA24g?H?
V75,]>(ZF,T):;KB;b)g7@[=1<G@O8b;aeT[a>b6NO-;EL=04QR80O;A8MdLYTa.
LZIX=Ea7A@_0(P@XU@^&&bRZb-5>[cULMKAL-@CJBdY44&ZY&>ZJK^Rd@)MGE2D-
7]DX/1-1#6cD^=J@<b1[[d\_C)EI2e?#]SA>b^1&#?+^BXe8Z^_7R1S6M;&8D3B[
JRTd_C8FdM-M-(M^(1&AE2gG0c[?D.?dZ>,W,,:M:eO.>Ke-Jb).Dc2aDFHKXY@Y
KBa0XP-YYM\?(4#F9Ec@TST(O&eLW;][9=49I)T[3=c_T@[F[c#E_]/WGK<<(=/\
PX5,NH)8aZVH&U)QAZP]<Y_[5#CKd\#]:&GaH328BD[@-9AF(=4KP[+6DUHK+efS
7>T6#EeGRO\B;EI/,]0a<KJN@6_L_?U@0EPB./VU.Te5BI]P-EUA3>SeUAV[1=;8
f,2d0=-B.93Y-X:[:3.a&;3.N&E<<:U#G^&K#F7=,-bKTdH/ac)I/[5=\NB^HLM,
/79CW9U9KBfH2T<?1Ve)A2LF#M3/KHcZ:$
`endprotected


`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
