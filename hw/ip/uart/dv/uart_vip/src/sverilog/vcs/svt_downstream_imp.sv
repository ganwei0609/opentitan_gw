//--------------------------------------------------------------------------
// COPYRIGHT (C) 2014-2015 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_DOWNSTREAM_IMP_SV
`define GUARD_SVT_DOWNSTREAM_IMP_SV 

// =============================================================================
/**
 * This class defines a component which can be used to translate input
 * from a downstream 'put' or 'analysis' port. 
 */
class svt_downstream_imp#(type T =`SVT_TRANSACTION_TYPE) extends `SVT_XVM(component);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Queue for next incoming transaction coming in from the downstream provider. */ 
  protected T next_xact_q[$];

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new downstream implementor instance.
   */
  extern function new(string name = "svt_downstream_imp", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the next incoming
   * transaction.
   */
  extern virtual task get_next_xact(ref T next_xact);

  //----------------------------------------------------------------------------
  /**
   * Analysis port 'write' method implementation.
   *
   * @param arg The transaction that is being submitted.
   */
  extern virtual function void write(input T arg); 

  //----------------------------------------------------------------------------
  /**
   * Put port 'put' method implementation. Note that any previous 'put'
   * transaction will not be lost if there has not been an intervening 'get'.
   *
   * @param t The transaction that is being submitted.
   */
  extern virtual task put(T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'try_put' method implementation.
   *
   * @param t The transaction that is being submitted.
   * @return Indicates whether the put was accomplished (1) or not (0).
   */
  extern virtual function bit try_put(input T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'can_put' method implementation.
   *
   * @return Indicates whether a put is safe (1) or will result in a loss of
   * previous values (0).
   */
  extern virtual function bit can_put();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
N>+C=ZFbMBN4G]eRNGV/-/KZ]g.2ZKR36=b\Q]:=#\,:I[@Ag\)S/((.^;G[<CN?
KU:a@J,0Z,f2T>K7;c_;?-)WXE?I+a8a2^&d#b8+5Z1Z9Pb0X,P-8Jeb,6]#AJD7
Df&+,Q:eJ+G\P8a7+d:_S.KB[4OD<0RC7\ARQ7E8[(MJSM@-PS^[Hfa,<OJ,01Qe
<Y1M,&.aSFOJ;]I#Z454K+XRVSLR09L,T8TQ)>Ma9Z>28K7B/_X8#gP[HHQ8N7M-
)3(P8+6N9cN/P=^e=(4[dUe1UF2M&6]8(c;4]6IXWP8b?c;/N:Ef=<7KXQ=/_2d6
I43WX;X9?CKbLT@g9;:.&-=EHA#YNMO<[+D<<5DYde_aTX5W2S?:HGHCA]C;E?;9
a\L)_J3FN9\aQeQX^6_c@O9Z<[39FCQLZBO?2,B8JX-L#]B+<E\=@,aMQB9P[45Q
>0>WPeUDXH^B4K#[]YOYF\GQ-,1D?Oe_JE:R>HSC/AaZ3fWWK:Xg7<fAKK^#,(JU
[3\<aVg-H4KK]H[_.E2<[]K[L).:,-MHbYe;F=<\S0Q&b[f-S0T(JE)^\/^Bb41,
B+,NYT10>[ZE4>1cS6F6Q1/Zc.7#9+5ff3DEXYaH5VX]2?eV(-OHHI5JS2+@KK^[
M2T1\W0#g)dL3:&7I8_XL<H65#aCTAQ3e,Q4+E>/M\B96ITSTT880A4AdD2RK/UZ
2g2[U::=O.Td>]3HN.+B:#g;ccd?aZ>^84Nf_7M#.&7..+KC2EGPB?fV(F<3YY_g
>/56c<IM2EQY?\_NN068c3?B^-3G3^-K@#FZ+FFbCX1)SXgV>Pa><b;2)]MK.Ga[
-ZFDIfO8J3#MOSGg4V1QXKbD5a6.H<4?+b/STNX1^DH@WBE.O[=X4W5U56E5dO[A
F[+;\Q04D\\TF[R4=<1H_WI-^,f4d9b@5@^MgRXQVG=[1)g1d:HJ=)KIaDNZZR&D
c?3[O)DV.41Rg;LWUHa4VXVI))?]BbNMRI#e<dg>8NJME[f31^8/.G(=A4XaW\-a
BPfZdf-4(@V9\Y?T^2R6<.-8FLTF,dO0Xc>9UFLO&7-EYZ_+9&&6bd_^#87@0bS@
eL,&[?dAV@T/DV[_TeP?+R8KG.\0?M?Uc\#9Kc/XP<>:9+4&UQ7.(9.KD-/+&FPL
a9K@B..7YPK17Yd99(F&Re;T.WM:N^DO=J18A52K35g?&EZPBAGC&(OU.UN6ABCI
TV6@ZdWK(0MG4f\MdD+G-FHCVfD/gdb[#b:KN)^)OY,S+HA.YeSAG/1=NXN.EaHA
?E1.cZ]0g(D24VYGHMNHTe;e/#:d,L1EB^#&V<c9:K8)WC@d/EIX3?YVV2W3-5P#
\3,PXaDAK#/g-aYYcKV;5ISa=\34OYK^57E;1Y2#aTgV5c4Q,e5MUF+5/a4WbG=c
@:F<1UZc_3&#0d-UA#eR:6.c[D/BT<e[.?0P@R,RS.BJZ4VfICI^=>b4I<^EXbZ=
?[Cd2Ua^<](BFC/@V/8S(=8/UJGE#+9e<BCUO]01a;_SKD?3DYa7?DHJP]R+@f9?
SUBE]dH22d[213N/&JaL7]b]0&)-3&I\ECdP/8L/SNE^HJ3UC+?2cP;GG-eVbG@U
KS03V4<^K.\N<](2;#@S<95&I7[WD6/B\gKf^-ZNdU9KH:CV7)3JF#):P7TKH\cN
2V<3E5Y(_TC[3KO@68gcUI\:W#daU[JVI2CKW:P02;Kab7=f,A\<6-T(Z>U)8N?X
=.?6C+853(BP5baJ<dQA&=5CO,X<HH7+O7@Nbc:XaH39gW3N2U?XVT4^G)#_3QO&
<5XfS_PM@Jg;W)MK3d.GTR_>2VD]DT5S.)^SMMKaE\U\NeZ_Y^14-HZ^DIN@DW_R
CJ8TJI/Ga373(Mb#3\9[L>Q6ZU-c17>^Q;-,,eHI0;#G=c.IC;a&D1+ag]Y,UB4=
[_3>;B/)_>3;,O1T[YfMVG,\5JDP.^S>5MJP1A\N.aBIP=M^]I,DW(6_C[&b;J[:
-(AW[27fLJ0BJ)_(MfVZ-F(TG-X+?.28Yc12<BN92\5[aL8M_-&RQF71WeZWEX=)
OO.\ZT,#SC:F:(,O(3G\-](T3$
`endprotected


`endif // GUARD_SVT_DOWNSTREAM_IMP_SV
