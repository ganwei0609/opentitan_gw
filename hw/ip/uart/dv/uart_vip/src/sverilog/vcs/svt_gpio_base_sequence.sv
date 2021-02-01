//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_BASE_SEQUENCE_SV
`define GUARD_SVT_GPIO_BASE_SEQUENCE_SV

typedef class svt_gpio_sequencer;

// =============================================================================
class svt_gpio_base_sequence extends svt_sequence#(svt_gpio_transaction);

  `svt_xvm_declare_p_sequencer(svt_gpio_sequencer)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_object_utils(svt_gpio_base_sequence)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * Called if the sequence is executing when an INTERRUPT is received
   * on the sequencer's analysis port
   */
  virtual function void write(svt_gpio_transaction interrupts);
  endfunction

  /** Register this sequencer as running so it can get notified of interrupts */
  extern task pre_start();
  extern task post_start();

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence instance
   * 
   * @param name The name of this instance.
   */
  extern function new(string name = "svt_gpio_base_sequence");

endclass

//svt_vcs_lic_vip_protect
`protected
Nf4AdfZ,[+VB?(>7TW5E0a,E2.EgVZcc5GD_(/9/FXNUT=+6^K_<4(AcZ]00.:)3
3Ec?YOR+>=,QXZC9-WI?1C^]SF^PDI,#,c[#()2,,8]]YfQJA-^O)=g[+VfG=0<K
Ta)B=P:bCH:D&+a71J&A#^92TJc)eGH,XE#HME@N,F3.L^;6\ZX?Z30Ue#eHCO>U
.OA0>XI;YT&53H5A8L#?445c-A0D?c=L2A^+Bb&SL_S<9g\P,RO18>F0+4.3g#X@
:.L9)T4J\8cb1NMLVc]Ac<JM(DH2V(JMQacF#MOXE6KKSJ9f6(CcW=E@&;1PbZ=R
[D>GLX@1-KZ?-3N[@g/T<9d).?<A[\eP4_W(1O\ZTfE/J#Q/fH<9gWf,8\S9IR\;
+3gOf6b:@/P(14He>[:1KT+(2d#F[SE@:6cc9N?INX#C#M+cSP8XD2K_KZ(#>c#,
7O[f:-^O-S9W:gP???C-H)e?L4.3Q82=-FZXX,QCDf58S>cP.RLf6e<f2DcTCR)b
VdMH0.HI,BDY<8:LT5R76[KD.@@G7GOE;K^@DI[.3bb4AgY,&1Xc^>8\gFc1a8<1
A1?F)@I>4^T-\Ia(.&@M#c=TDYWbV^BL9RFMU&eHE@^Ad8R/PX/T(eb:fWPFJ<U7
5S+FbgOG:a0cS\FI(YDU]efEbeD,#^+aNISOK]LO8F)gb-R)Wg5HQ-G2F#Idee#]
B1,K0BcQFV_IgJ,\?:,N]Y4fXdZR2P/^O4d<)YdXRWRC/7/?&&1A.Me_IKLN5BD2
IcNPY/&g45V]()QR8ODR-^/>^V>#74-21RMVL[e<7W4[(7I1TL<RUT5aE_ZVS<C@
KB-84,P<+NW=#&2R^e9f[-S.)M@BZ0L0g)LQ/QcQ:;-C<FE[3Ndf+A2EICa8^HFQ
:D=b&^W4]RQROOSR&WcV0S)FEadGVY8]Of&>1f4V^PNM0&,)+UB1^1/V(J<b<_5^
?HNb;P;9>1LHH6,[/&NPO6&DJK29.Qfge1>@NE>J0(_0O)[8>TU,>c/VO$
`endprotected


`endif // GUARD_SVT_GPIO_BASE_SEQUENCE_SV

