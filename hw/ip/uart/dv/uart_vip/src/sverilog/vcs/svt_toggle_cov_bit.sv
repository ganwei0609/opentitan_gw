//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_SV
`define GUARD_SVT_TOGGLE_COV_BIT_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Single bit coverage variable used to support coverage of individual or
 * bused signals.
 */
class svt_toggle_cov_bit;

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** The value being covered */
  protected bit bit_val;

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

  covergroup toggle_cov_bit;
    option.per_instance = 1;
    option.goal = 100;
    coverpoint bit_val {
      bins b0_to_b1 = (0 => 1);
      bins b1_to_b0 = (1 => 0);
    }
  endgroup

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit class.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   */
  extern function void bit_cov(bit bit_val);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
T.I8aJVa+U.f4.1,H?HVDIJ+I;g=b5e4I[3gN5^)bA[0V2BFVFfg5(93=1QS]^15
2U8AfaAD3AJ?#9B#MCL=>+/KE7AAGf&MP<[AE)ee9g/;Ua=c(GFX0T3gMW3>L;/>
-7=<HBF<;M_IDT]+;420M^U(XbJ&eRQV&G_?CReCaAJ3A)+&S-V4]&[cFYLLFI=f
Z)RAd1-K#^T,>:+DLg=#0g1S.IC;@>)75RUV)b+2a])=H&Gg0/D0;D,V4I87M1/8
QZWT8S[_)a.S([0^J3gO=>,_[=EZFH2A(B7K-SFL>-I)b&3A2I.N&1GXIb_&_##+
VS3W9.PS^5/a8bT71U8#@4fF1[cQe=-PPf>C^#A1753&U>4J#7ZfScC>ER.SS+\f
EL1Q5CPP8(J?^=J&E_+Q::RG7YA[MILeG<]^T)CNPRC_ZDC0.(+)9135/,F66V<J
cTJ#[dMb_MEMAY=UB(K[A7X-AP874^YKgcLZ;[R^a+eXPV27O)E#<CMFWA\@/YaB
aCW&-_KS.J4V:=7]S^IU9OPI@VY-14g)MV,1bO]Y&#g.NG_3QGQK_eGL7gH\\4CP
-O/S-IG)BD6,>fgbdVTK&LS=IJ4K^WK4][Se?_?/3=[IY:#/5KX:bNM_LbU0T(c1
8@F.O1)M/,ZS\CJCX-(<Q_H/PB2ZK^)c4e;;I50X0Q0cgU)82G\9?cH2:2V/US^Z
B@ZaWRcYa]MWL,(W77V@@T,UPSD426^DTH@B]b1;-R1<L4>W,O/EAa0^_KbC\+Yf
T1Z._CYC1W3;Z1BNdI-MeYEU<4]\PTI:e5R;3_^VO=(/B@XY^C7NO2d-6.D09+)?
@_5_X@8BfM<721&/e7bZH5gKT/]0L2US@$
`endprotected


`endif // GUARD_SVT_TOGGLE_COV_BIT_SV
