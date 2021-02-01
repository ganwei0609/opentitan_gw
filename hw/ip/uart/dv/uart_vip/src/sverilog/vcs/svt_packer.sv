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

`ifndef GUARD_SVT_PACKER_SV
`define GUARD_SVT_PACKER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(packer) abilities for use with SVT based VIP.
 */
class svt_packer extends `SVT_XVM(packer);
   
  // ****************************************************************************
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
   * that provided by the base `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract.
   */
  int special_kind = -1;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_packer class.
   *
   * @param special_kind Initial value for the special_kind field.
   */
  extern function new(int special_kind);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(packer)::physical and `SVT_XVM(packer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
C@7gNeMG6ebMe#;2@eJ^#)KQS)MD:2Y99_4.J17VDf4/#3g2:)P[.(0;<7-]K,.@
B@?<2;>NdL?)TIYf8IQ=O/NPVUPI/EOBbaW]b0SDEcDee=7gV9C:8Mb&-\(1EZKW
b?XeIJ^E+1QCO5<)9a65XE@FSHON)<[4/<7PRe&4Ke0dN@]GLG4)JWKS=,bCN^T,
90aHTc:dK<]g[;A/&Re)3RQ[d468a[]BT4c2SWY1>81MSJ]BJg8,#L[JI]0ZGIGf
1HB1NRXQ1+3A\UIZP9e8#N)38.SSO8@g@K[^5a>N<[SP@S)6UY4RNIR#aUHEE9+F
aN2^-/@c:E@H^>UZ3]Y4W5I:A6U2;+Qe-;9BNH;O1_Q6HKcfE1Sd#8.2&c/XPf\J
A9gU0HRG6XXEKIK>16G/gYfKHF8=/J.12?UR1=FC;DbIeEWe;?[F0^)FX3dO8DWM
Y0fZFVV9Z+#?300cZADe(GOQ0Y1&8T]/eN4D9d6&G>IRGR)T:H\@&^g<W>FVO40)
Hg_]>#QF>8GOARU]&@\<g]3=aZB4_Y1bXdZK.<N]a;N@U68b+RC(FTV;MIJ<DN[Q
(.SMf1D=GV1R\Xg9]WNd/0>TZIbIKMZSDc+,\V_b&c&O8@@cT,J&2AZSJCUV;JgS
FD1X-1aZXNbJ&Q/0MTEfNF=C/T-2MS>,)N\9A+:U,YVL]dAS-e/#H._(D5gL.XNM
aF>CYHU_N<3f_U&C8:2Lf4HVGg<BZ&?b:H@<P=S=7c4eaFg<&(\6dT-69R0W\Z#M
=I&DA6;eL?<TAJFe1PHNB^-]4E74Q9J9b?Lb?46?Y@=E.\<TCIT,\eZT(Sb:MAY;
[1X1d]Yd:.L>M2LSX[^\&A3<a;[TDKKfVU+H>#O:941VgG,gQ9eIN3KGc;D)C#\)
9CD=ZfWF_7M8KG0>.0fFY(0\5R;Ta2C[f\F\#CCc]V/f\Q.K1H]9GP.1AJ1PGE2W
[F=C=HC[S+W@g[Y,MV9g+4HV.(V1)TI+>2SERXT0^:C+b]bX;9PJ=7=VQdZTBTPK
=4(POW1WPFS?8?XA;#T/IT(@8dgQGXE7>$
`endprotected


`endif // GUARD_SVT_PACKER_SV
