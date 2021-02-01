//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
`define GUARD_SVT_DYNAMIC_MS_SCENARIO_SV

// =============================================================================
/**
 * This class defines a set of basic capabilities which can be used to implement
 * simple scenarios for distinct transaction types which can be enabled, disabled,
 * and in general controlled dynamically.
 */
`ifdef SVT_PRE_VMM_11
virtual class svt_dynamic_ms_scenario;
`else
virtual class svt_dynamic_ms_scenario extends vmm_ms_scenario;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new dynamic multi-stream scenario.
   */
`ifdef SVT_PRE_VMM_11
  extern function new();
`else
  extern function new(`VMM_SCENARIO parent = null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Function used to check whether the scenario is supported in the current
   * situation. This may be based on the configuration, the status, or even
   * possibly just an enabled/disabled bit. Weights, etc., to enable/disable
   * randomization must be modified within this call.
   *
   * @return Indicates whether the scenario is enabled (1) or disabled (0).
   */
  virtual function bit adjust_weights_per_cfg();
    adjust_weights_per_cfg = 0;
  endfunction

  // ---------------------------------------------------------------------------
endclass
  
// =============================================================================

//svt_vcs_lic_vip_protect
`protected
4O^I=[BY=5Da2MX;2W:be<^bKZTFa<LW#;bEA=d[eVYQ8M)S2=,V6(@c+c04g]C&
,CRL>7>/DTfJS1>6PM>)d^F<0<Va=OKC2ZdSDM4^Qg)5<[0Z[)<>+STR.055<e(4
)O&?.2:>3?ZMaO[BHIaQc2MIA+adHNV0Sf3ORLG-MaXYV(WaL+Y)?MYEUe?I[_>b
N3HDg3Z84XC0,3NFA@VIXU]>dff72AN?e+;__8SANUE.N]^gS=(A@#cQDR)Tg)c&
N#.6;^8A>.d0=X/d1=fWY\,FHO&fF16e(H(DF=>g,+^>:&[GLDe+Pc3A)C^O3H78
W1\FZ/#CCgGaPTW=-7[=;Y)F6J&3K<N\g[<a#^LRV.FVOKV18A3C_IR#Q<S-:(9Z
1Y8M-HE/9G?6@;LY5_SceWK>G04B_RG20]W/eFPB22MOX9.UMIbM)KD0FXA.)WO,
T:&FRNYGfBP[aTW\71H_0^A0@V[>O.<HSBC22+Y]C4a3XK#3GMKTGSO)K?@fe\(O
0->5Lg=JRM[TWQE,RQI9S957Je&dW-NH]VgL<QLO[gN)WQAA8g5B;9=NB7ILg6]0
,UY-QPS#0(Yc<8O=+\/2SB576$
`endprotected


`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
