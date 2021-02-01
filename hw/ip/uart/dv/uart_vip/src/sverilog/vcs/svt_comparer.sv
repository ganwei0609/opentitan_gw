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

`ifndef GUARD_SVT_COMPARER_SV
`define GUARD_SVT_COMPARER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(comparer) abilities for use with SVT based VIP.
 */
class svt_comparer extends `SVT_XVM(comparer);

  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Special kind which can be used by clients to convey kind information beyond
   * that provided by the base `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract.
   */
  int special_kind = -1;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_comparer class.
   *
   * @param special_kind Initial value for the special_kind field.
   * @param physical Used to initialize the physical field in the comparer.
   * @param abstract Used to initialize the abstract field in the comparer.
   */
  extern function new(int special_kind, bit physical = 1, bit abstract = 0);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
78L0EB1^Ie-g1eB2W.NdfA3D.MW(Wg.\W:)Q?B_2>J9CB-D^^fTb-(GUE8L<B5fF
#X2#&-(LG1I5,[C=B2@D_V3K=&:YVPWg,L3,?e4)7U&Y]&K/a5:1KLD38c)Z;S,S
P[J7:Q#?ZI0Z0P1HP,?JJ,1R_YgfdNW@>),11(X\<[XXCfQ_eJ:6OBbQL\MdFSFU
@ST9E;LH\A1Yf<:,^YPN;P+5+)b)]e>47<2)BAO+C9IB5J7_[#d#I+GcCW>?Ha7a
<,NW=@<L\8+0_=O:E0bS+G;Q013]I/+#dGO&g#TV<]FYJ9e2H#K:8aCYa)-XgL>d
04Of)PP0A=gS3TSPH4HQ[<Of.<a,_0ZKK)[EO?1EQ>Pa.UMMD8T>HLffg^@V]Z/[
b3aQ(0?L5I>BOB\97WBLXF,OZN?VdSR@:Z,I&Wb07KTV4[B2;dN<b]@+(eYR\DO\
LT[7fHF>6Ua+&c3HXS08;fT+J\_7AAEPP?8W95//6f>V(6YFe6D7[S3;=DSHA</+
Wc/(?7Q7:PPO]O8G+8J3dR35P5:26U)[?VV8+K=,O>42<Ga/5(OZJb+YCE6bL79;
?@O9UPB5W;?WVAI>g=;?,b]?0-O^RbGXES,<>=>+U=&KC;bR_JA04Y=<,bJ.9NC)
Wed_@.7c&JSZ;]3b7Q0MW_<5T??X-VEa.WE&,PIJ-[\M1^ZcK=RO095bL-,2V[F8
)5H)_MfA>5Z^,B?3YH-?]aJXXQSR,F?CV?2_A3&M&&Q_M<57A&,g+[NI6Vf:5gb0
8aW/8+;6F-SKgVc483)]?,gGgMTL>Y=6:,N_0OJV-O3:M,#45EB,^^[LRSVMD-0O
/CHYcXe[R\8I@)09,&@9=GAgW-7WcI]1;SYU6&a(b=5L=Ee:)Ee:DW=&._78dP.;
Vg>9Yc\B^1d-,^)Me<d)<;Ua)F1f[:+_R:EGC.gT)YU?R1cDRMe-V1--eJa+^N3V
b5]+Y\O47,6ZYe^K(b@#/0#^@/Y]WZT:KU&UaffcJ@AP/#@_PNJ1f\,1?aQ]/EFB
+,HPd62.6aR(L8O^Z/QA4@e/HGO7^b<0?_(NcT1)FU?3Ub;SQ6X<FKC5:2E3P#T/
Z3WE2[O.e],0gc];:?=X]NTV4QDH?Agg,X.27+)e#&SB@)?(R6F?UR7-5#T]RVC<
1QY4+[ENWT\0ZEAa@PTXBcCUcIU\\APg5.^]T[/3TKEB8d86c?.;(49MTM@S?Q_4
UV?-@9C3aba8BMgS7P\9?T.U6Vg)&0@bK\d=-N)5dUU&PPOV0+,K,X-.6ab@Me)5
.@)fCa(#V&QNUMI62G5WY[4dGX2I5W_65f(0^WNZef0VK_]0Q)Z:;\I-XUUI3eX;
eD+Od.;A81cc24@X#<8^GS[D+:M1ESXU3P/ce0-\c/@DILS\]=#+-;=BJ/GFT#<L
C@AG9JDfR]T\@B0R]D,c]M-7P3_G_dF@YCO,N)_CM5HO<&gZ?<+MN4&#f0N?FNcg
A66:=Id2225Ob&B6BNgZ/V/JQS=RPVOg97Q4IG\>-/C/^IUg3L;O,K3-DHU6;E_/
,<159J@+2Ab5g<L_L<;TH7D?U/CfY]KNd44BO6e(#8?.+=#GMWWSJ8BS\TXVA6>,
Q822HNgX(^A)g-G?28Zd(5X,=5e?OQU4fCcRF-acZeX^ac&I)V4@RF7e,)GK?e]6
IgZJ1e9<?7#Y\/VK(O.Ed5@+c9\^TH81&;bQ&^gDK<IV8R\GN8GJ(3,8VGb_Q\4=
8B3.&TE2MQ(<cA^Tg>E4f\N1ULN?OPYE^D44ag50cdfg1eQ\H]eC/,SGHa(MXQ0(V$
`endprotected


`endif // GUARD_SVT_COMPARER_SV
