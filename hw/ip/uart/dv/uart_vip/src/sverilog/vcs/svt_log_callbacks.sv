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

`ifndef GUARD_SVT_LOG_CALLBACKS_SV
`define GUARD_SVT_LOG_CALLBACKS_SV

// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_callbacks class
/**
 * This class is an extension used by the verification environment to catch the
 * pre_abort() callback before the simulator exits.  In the callback extension,
 * the vmm_env::report() method is called in order to provide context to the
 * events that lead up to the fatal error.
 */
 class svt_log_callbacks extends vmm_log_callbacks;

  /** ENV backpointer that is used used by the pre_abort() method. */
  protected vmm_env env;

  // --------------------------------------------------------------------------
  /** CONSTRUCTOR: Creates a new instance of the svt_log_callbacks class.  */
  extern function new(vmm_env env = null);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is extended to catch situations when the simulator is
   * about to abort after the stop_after_n_errors limit has been reached or
   * a fatal error has been generated.  The only objective is to put out an
   * appropriate Passed/Failed message based on this event.
   */
  extern virtual function void pre_abort(vmm_log log);

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
RU.P/H3)KL+gA.feG33_LG49VRMU2_dcR;&6F82N)V@/5BB[W&-_6(L0)^W;LU6F
UEB\B?L5_6]dT@>[H31gNY_LbNWNe--,&69;UdIBS.-d&BEdMM=PYVY4WB7Z05Ec
8R2WZ_^ZG7J88VOg+1IOT1A/XfUISCT;WI4,LF^E?S6NQ\,,HAa2bIR8YAQHXQ&Y
)&FK+@4F7(2#Y^D#(&7V)ORe.WTE2K1,#D&>KY/+E9/BN]HK>/VPX&IH(cMf#=GV
?Pg9f]V<K#N_T.\0;eSI4IaeMF\dV.SB1\A:LHCGEedY3)]SYcY7ZE\Ce4FQDHJ,
d8STc7GVTUENf:9R7NC>WR/gBbJbgMHBVCN#H7TA_TQ/7U#AafZS3BM_D,@38<<5
6ObD#:H^XY0+ARF53_98X;8ULGLO>N?YDc_R:6(d&fJU&=X3M#@_;0]I-VHK[98U
>I6?S0EK.GXa@J2+8VKYZIf/JKaV&MdbOUd3;ZK63KUG#g6^DX:[c;.Y6_:HIU[Q
gI5[S_S+LeA-(U3AeJWf-0CEL6C]ICU2Zeg&.^15SR+@b7,>0]TRfP<2.6bbV6<]
[XW?]V\cWcZG-/d_+@]L.A<1g\Q0(bD#PK>U]8-?G&P<^5XKH.b7#W&UQQ-YDK2@
G]6[bGFY5CDd3BbO6+R7W7;RGIeb#R[4We7@@X7&^G5SaF>Y.+:B:8)VII7Q=B#2
E8[[#DPM.-]IZSAC[,MSQF&cZSBg2,deN2S]gNW&F;a[f\UV4\F=Q[H8OT>Ng32a
=5_I;OSU3e>53>g-+1d<S:H<>HZ43GDUM><;YXa&(@&PUbC0?<AO6(6+fe_C+UX=
4fJ\,,77UZUBb3K8V@73^VO/V#OQX[QW@GHW6V(0@=NX,,[;>)O5-<^_87U6[Q23
:3/6<RLR4ZR92b)S_[,^@P\^0S2-M9<.L@>f,c^4/4d?__KLS.AD0<,S#f#]3)(c
-[Zg5@JEL4f90$
`endprotected


`endif // GUARD_SVT_LOG_CALLBACKS_SV
