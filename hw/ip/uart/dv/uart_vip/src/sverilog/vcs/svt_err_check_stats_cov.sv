//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ERR_CHECK_STATS_COV_SV
`define GUARD_SVT_ERR_CHECK_STATS_COV_SV

/**
 * This macro declares a class by the name <suiteprefix>_err_check_stats_cov_<statsname>.
 * 'suiteprefix' should be the suite prefix (e.g., 'svt_pcie') or a more specific component
 * prefix (e.g., 'svt_pcie_tl'). 'statsname' should to the check_id_str value assigned to
 * the stats instance by the developer.
 *
 * The resulting class is extended from the svt_err_check_stats_cov.sv class.
 *
 * This class includes its own base class covergroup definition, as well as "allocate",
 * "copy", "sample_status", and "set_unique_id" methods, which pertain to the "status" covergroup.
 *
 * It relies on an additional "override" strategy which involves a call to
 * svt_err_check_stats::register_cov_override. This call establishes an object wrapper for the 
 * svt_err_check_stats_cov class extension so that it can be used to create the new class type
 * coverage is added to the svt_err_check_stats instance.
 * 
 * Usage of the "override" method:
 *
 * 1. User creates the svt_err_check_stats class instance. 
 * 2. Calls the "register_check" method for the check.
 * 3. Call the svt_err_check_stats::register_cov_override method with an object wrapper for the svt_err_check_stats_cov class
 *    instance which provides the overide.
 *
 * Note that the override should normally be done by using the SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE
 * macro. 
 */
`define SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL(suiteprefix,statsname) \
  class suiteprefix``_err_check_stats_cov_``statsname extends svt_err_check_stats_cov; \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    `vmm_typename(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
`endif \
  \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    covergroup status; \
      option.per_instance = 1; \
      option.goal = 100; \
      pass : coverpoint status_bit iff (enable_pass_cov) { \
        bins pass = {1}; \
`ifdef SVT_MULTI_SIM_IGNORE_BINS \
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
        ignore_bins pass_i = {(enable_pass_cov == 1'b0) ? 1'b1 : 1'b0}; \
`endif \
`else \
        ignore_bins pass_i = {1} iff (!enable_pass_cov); \
`endif \
      } \
      fail : coverpoint !status_bit iff (enable_fail_cov) { \
        bins fail = {1}; \
`ifdef SVT_MULTI_SIM_IGNORE_BINS \
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
        ignore_bins fail_i = {(enable_fail_cov == 1'b0) ? 1'b1 : 1'b0}; \
`endif \
`else \
        ignore_bins fail_i = {1} iff (!enable_fail_cov); \
`endif \
      } \
    endgroup \
`endif \
  \
    extern function new(string name = ""); \
`ifndef SVT_VMM_TECHNOLOGY \
    `svt_xvm_object_utils(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
  \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    extern virtual function suiteprefix``_err_check_stats_cov_``statsname allocate(); \
  \
    extern virtual function suiteprefix``_err_check_stats_cov_``statsname copy(); \
`endif \
`endif \
  \
    extern virtual function void sample_status(bit status_bit, string message = ""); \
  \
    extern virtual function void set_unique_id(string unique_id); \
  \
    extern static function void override(string inst_path); \
  \
    extern static function void direct_override(svt_err_check_stats stats); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    `vmm_class_factory(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
`endif \
  endclass \
  \
  function suiteprefix``_err_check_stats_cov_``statsname::new(string name = ""); \
    super.new(name, 0); \
    /* If client has disabled pass/fail coverage, then don't create the covergroup */ \
    if ((svt_err_check_stats_cov::initial_enable_pass_cov != 0) || (svt_err_check_stats_cov::initial_enable_fail_cov != 0)) begin \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
      status = new(); \
`ifdef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
      /* NOTE: Some older versions of Incisive (i.e., prior to 12.10.005) require the goal to */ \
      /*       be a constant if it is set in the covergroup definition. So set it here instead. */ \
      status.option.goal = 50*(enable_pass_cov+enable_fail_cov); \
`endif \
`endif \
`ifndef SVT_MULTI_SIM_COVERAGE_IFF_SHAPING \
      shape_cov(); \
`endif \
    end \
  \
  endfunction \
  \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
  function suiteprefix``_err_check_stats_cov_``statsname suiteprefix``_err_check_stats_cov_``statsname::allocate(); \
    allocate = new(this.get_object_name()); \
  endfunction \
  \
  function suiteprefix``_err_check_stats_cov_``statsname suiteprefix``_err_check_stats_cov_``statsname::copy(); \
    copy = new(this.get_object_name()); \
    copy.set_enable_pass_cov(this.enable_pass_cov); \
    copy.set_enable_fail_cov(this.enable_fail_cov); \
  endfunction \
  \
`endif \
`endif \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::sample_status(bit status_bit, string message = ""); \
    this.status_bit = status_bit; \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    status.sample(); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::set_unique_id(string unique_id); \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    /* Make sure the unique_id doesn't have any spaces in it -- otherwise get warnings */ \
    `SVT_DATA_UTIL_REPLACE_PATTERN(unique_id," ", "_"); \
    status.set_inst_name({unique_id,"_status"}); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::override(string inst_path); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    /* Set initial pass/fail cov values to 0, since VMM is going to create a dummy instance and we don't want a dummy covergroup */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 0; \
    svt_err_check_stats_cov::override_with_new(inst_path, suiteprefix``_err_check_stats_cov_``statsname::this_type(),shared_log); \
    svt_err_check_stats_cov::override_with_copy(inst_path, suiteprefix``_err_check_stats_cov_``statsname::this_type(),shared_log); \
    /* Restore the initial pass/fail cov values to their favored defaults */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 1; \
`endif \
`else \
    svt_err_check_stats_cov::type_id::set_inst_override(suiteprefix``_err_check_stats_cov_``statsname::get_type(),inst_path); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::direct_override(svt_err_check_stats stats); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    suiteprefix``_err_check_stats_cov_``statsname factory = null; \
    /* Set initial pass/fail cov values to 0, since VMM is going to create a dummy instance and we don't want a dummy covergroup */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 0; \
    factory = new(); \
    stats.register_cov_override(factory); \
    /* Restore the initial pass/fail cov values to their favored defaults */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 1; \
`endif \
`else \
    stats.register_cov_override(suiteprefix``_err_check_stats_cov_``statsname::get_type()); \
`endif \
  endfunction

/**
 * This macro is provided for backwards compatibility. Clients should now use the
 * SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL macro to avoid class name conflicts.
 */
`define SVT_ERR_CHECK_STATS_COV_EXTENDED_CLASS_DECL(statsname) \
  `SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL(svt,statsname)

/**
 * Macro that can be used to setup the class override for a specific svt_err_check_stats
 * class instance, identified by statsname, to use the corredponding coverage class defined
 * using the SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL macro. Note that this macro
 * relies on the statsname being used for both the 'check_id_str' provided to the original
 * svt_err_check_stats constructor, as well as the name given to the svt_err_check_stats
 * instance in the local scope.
 */
`define SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE(suiteprefix,statsname) \
  suiteprefix``_err_check_stats_cov_``statsname::direct_override(statsname);

/**
 * This macro is provided for backwards compatibility. Clients should now use the
 * SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE macro to avoid class name conflicts.
 */
`define SVT_ERR_CHECK_STATS_COV_EXTENDED_CLASS_OVERRIDE(statsname) \
  `SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE(svt,statsname)

/** @cond SV_ONLY */
// =============================================================================

/**
 * This class defines the covergroup for the svt_err_check_stats instance. 
 */

`ifdef SVT_VMM_TECHNOLOGY
`ifdef SVT_PRE_VMM_12
class svt_err_check_stats_cov;
`else
class svt_err_check_stats_cov extends vmm_object;
`endif
`else
class svt_err_check_stats_cov extends `SVT_XVM(object);
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Value used to initialize the enable_fail_cov field when the next cov instance is created. */
  static bit initial_enable_fail_cov = 1;

  /** Value used to initialize the enable_pass_cov field when the next cov instance is created. */
  static bit initial_enable_pass_cov = 0;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** The value being covered */
  protected bit status_bit;

  /** Enables the "fail" bins of the status covergroup */
  protected bit enable_fail_cov = svt_err_check_stats_cov::initial_enable_fail_cov;

  /** Enables the "pass" bins of the status covergroup */
  protected bit enable_pass_cov = svt_err_check_stats_cov::initial_enable_pass_cov;

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  /** Shared log for use across all svt_err_check_stats_cov classes. */
  static vmm_log shared_log = new("svt_err_check_stats_cov", "class");
`endif
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_MULTI_SIM_COVERGROUP_NULL_CHECK
  /** Indicates whether the status covergroup was created */
  local bit status_created = 0;
`endif

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

  /** 
   * Covergroup which would indicate the pass and fail hits for a particular svt_err_check_stats.
   */
  covergroup status;
    option.per_instance = 1;
    option.goal = 100;
    pass : coverpoint status_bit iff (enable_pass_cov) {
      bins pass = {1};
`ifdef SVT_MULTI_SIM_IGNORE_BINS
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS
      ignore_bins pass_i = {(enable_pass_cov == 1'b0) ? 1'b1 : 1'b0};
`endif
`else
      ignore_bins pass_i = {1} iff (!enable_pass_cov);
`endif
    }
    fail : coverpoint !status_bit iff (enable_fail_cov) {
      bins fail = {1};
`ifdef SVT_MULTI_SIM_IGNORE_BINS
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS
      ignore_bins fail_i = {(enable_fail_cov == 1'b0) ? 1'b1 : 1'b0};
`endif
`else
      ignore_bins fail_i = {1} iff (!enable_fail_cov);
`endif
    }
  endgroup

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_err_check_stats_cov class.
   *
   * @param name name given to this instance.
   * @param enable_covergroup Qualifier whether to create the covergroup or not.
   */
  extern function new(string name = "", bit enable_covergroup = 1);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  `svt_xvm_object_utils(svt_err_check_stats_cov)
`endif

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  // ---------------------------------------------------------------------------
  /**
   * Method to allocate a new svt_err_check_stats_cov instance.
   * Needed to support the vmm_object factory subsystem.
   */
  extern virtual function svt_err_check_stats_cov allocate();

  // ---------------------------------------------------------------------------
  /**
   * Method to allocate a new svt_err_check_stats_cov instance.
   * Needed to support the vmm_object factory subsystem.
   */
  extern virtual function svt_err_check_stats_cov copy();
`endif
`endif

  // ---------------------------------------------------------------------------
  /**
   * Method to update the sample value for the covergroup.
   *
   * It sets the "status_bit" field. 
   * It calls the sample method for the "status" covergroup if the "status" covergroup 
   * has been created. 
   *
   * @param status_bit Sampling bit for the covergroup.
   * @param message Optional string which may be used in extended classes to differentiate
   * 'fail' cases. Ignored by the base class implementation.
   */
  extern virtual function void sample_status(bit status_bit, string message = "");  

  // ---------------------------------------------------------------------------
  /**
   * Sets the "enable_pass_cov" bit for the "status" covergroup. 
   *
   * @param enable_pass_cov Bit indicating to enable "pass" bins  
   * 
   */
  extern virtual function void set_enable_pass_cov(bit enable_pass_cov);

  // ---------------------------------------------------------------------------
  /**
   * Sets the "enable_fail_cov" bit for the "status" covergroup. 
   *
   * @param enable_fail_cov Bit indicating to enable "fail" bins  
   * 
   */
  extern virtual function void set_enable_fail_cov(bit enable_fail_cov);

`ifndef SVT_MULTI_SIM_COVERAGE_IFF_SHAPING
  extern virtual function void shape_cov();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Method to set the instance name for any covergroup contained in this class, 
   * based on the unique_id provided as a representation of the associated check. 
   *
   * It sets the instance of the "status" covergroup to {unique_id,"_status"} if the 
   * "status" covergroup has been created.
   *
   * @param unique_id Unique identifier for the covergroup.
   */
  extern virtual function void set_unique_id(string unique_id);  

`ifdef SVT_VMM_TECHNOLOGY 
`ifndef SVT_PRE_VMM_12
  `vmm_class_factory(svt_err_check_stats_cov)
`endif
`endif

endclass

/** @endcond */
//svt_vcs_lic_vip_protect
`protected
10_-S?_W&1IC9]e])83B?N1_)^AT9ZQO47AF_a48RNC/Wf_?adRO&(9(PAH39Z.<
THEPNQN3X(@8<B,MA),7X1a836;&LB,SF+TP=]MZ7@]Z9WO_RCLFS.C4FB1#4G,U
;[;#+;6JT/VEHH0/>;2V,@.c;?&+QX0c8c&YK0ODA_4-(e.9[Z#6HY),dgTA5)(T
7NL#KL673a,3V_1?3Pg,.U\+Ea#a\+W5?5YIB:+VL>:6M1bUDV2?e<Z4Q\D:ad3(
#;SHc?CY=?0g\Z#YM#X9#Z.G:Q;-VC:=UQ^7^C/EQL+R/HNJ?LZ06f8b\E9F9G[d
7\9YU6?(TKX)3CD)18K0Z6U..cBAE/IME6V<CUPY34Ec]SVHb-WL5D.Z1@@6df:\
^\5-Y,G+6TFSG^U=)=7A(:A<5HVNL_J<eMU(W77EWe/d=Mg/7VOUPRdb7^1_B9__
DO\13\+P2X;E0M:M70L&NQE(7,S#UY6POc3G0@SaLb,eA11KD@^B]K&4<eH]5d^T
eLPVGa\g7XV=17f?aVV&b5J@70)I3\]ZU4(K+^?^H:,YFZ#VJIPSM<eM3:C#g;CH
a>g_F.eFb96904Eg.H2e:WC#d=OE)-D-aR:KX6[7U5J9VaXe=2PY;&3J9ZFc<_CR
=/^=&I6)#FP_MP=>6Q]PQ&I_df@0B[X7-e]?D8#G)>NO/5O9DH0:WSgbE\>KOH1&
F]eB,&PTHV@<N:ZF&_K:Ef6[O-G?c)1EaBI8JJSDC<Y?Q65H4J@J.TRY3b1=g@.:
I/:4)aa9[@#^a?JBV)ON4=:@E38H4f[9g?)gfDeG;cP:QTI1Z0]>0?JM@<P>0&>O
Xa.QS65R^I6E-D73DJLH1:TUfK6f,,Q@4.S>4XfHTX(S/M9)T(J\]?/BTbI)9??d
/d]G]A,<;>)a/1TgV2cKFAY,B=]:,RK[[=QC/>HfdHMG7F2/;L,1U],;E-O.RGYA
O(;6Q?LL2/ORC;FX]#.VZV;:Z<F#OBNUF1[:ABdfeC#gf@:,8<eW?gc_]]Eg7G67
d9-(LEQAbg>&WS(#I7O\db=_92:=d6_0\K=dSVCI#DS^gIcUF:e86X8GMf/#O+A3
XARd^XcS8.UY@Dg0\]K4+5fF[K3AaSc#g3/)JA)7,ALBJA#UHe(6,/CXeG9=(.58
\8BVfMegO^\[\O+=VeYXPa(5)D2cY]P>S_fFe5=SV2UeKXC2f[(E#g+).Kc9@NRU
f69>=6[@RG5]T26eM/WJdYHMKLaf@1/#J9&,TbTQE\B@bc,W2X:@_Y_G87PXZG:b
=7Nf7QVH[&DH@Y(2Mc/SX9]=L+7,.Z4F/\49;CX9aMKa:@Z-CFN)XbKc#[bR?E+U
?8XM3M3G\9@61XH_Z()gFAYJ7BROa6]HBZ-cbf/g;>Y+QQbW\AEUW1d#9;1(d<Z@
bTfW3\QSNe>,Gg0Df)VJ\[Ma;-F&02QQ1a)HWNUV_OHb[dEXBJ6)<M3a,Lf87KSB
c;)Ea?#^+\Da2H=XccF74_.__#-,\)1VeA//N_1A:g=fT0IJ_<LdG06/M5Cg>Add
MFS[^NJ3:,a4I@7<4=H,BMY/Q<W/PaI>1P-8P2X7UJFF=Cb=\M\/8fSU7=Vbfd95
[>:c?(4;/O6A=PS2L8&@c;dXUd>dU3:U@U+F1LF#<GM.(\/Yc#LFDO<Q?Y,0/1BK
5]IgMF:?=>@DTMYbV+##NMC44D5TCM4L;7).AZ(aDHg[5OKBNG#],67Sg4TF(.25
3Q/H+2O8LaO\G9?;FbeB8@VA/@[c:A7P_1WQTf/,c:a_N)b5(bSbU.=d+1X_>2.6
5:c&N;QD0E-8479RUYDAVEZ1Z</9[)(W:\Lc4PHTI[bT\R=JJ_^dY:=5a^V0W]G<
=IR[2;9-F+<-2F,f([&#c6d,cgRLf&1IMZDfM0L?&Q>ICWV)/.-RS)7N:[f\YdXS
_=J<NZXVbT4@?B,5g;/BTfQ&WEO6N<1+FW[YM-Hba@=Z]ME21E829CPTYN25#8-G
P6J+XL#)6gN.PZ:D6A\0,]d1UI4/G(XQB;?J\b+[VJcbDBY]ZHe>GFA1&REPHF83
O/I08,70fGI3WbHJD:bE@_/&61U&NKH_G#=(Y-BU-FQ_0RZd)R1C7Z)8]>]36N+Y
5:@G4603NTWQ9[@T2HZ+R,[+;f\S5^JC4&\aGAM6#9Ee6Q1Y?X//a.#Kd0)IGYDI
TAJbG1X6L0:Z-CaB;Wb2dEO??^BDEV4;_OA^3-Fc+7Xa]P@4a60g?7HK?AU_9(^Y
)3IaDK,OO7HM1^Y_67gH)J4V(aI=4b93FH0X9G14SA2CLHLYb>dKH=7FJ\gO/M_<
:&/J2gGS[8g[-9X[fMA@HP\=Nd8_.&.)4(FXNYQ0\==4I[MRCEZ//,_UO(7(P@XX
IQfB=D?C<8&6MDaGB/S=Lg=:Q[ML.=)-Q]<.4=RA)[CD+\/=,_E+[;AeRNDTBX)6
=;C7AI=FVMFD2/3S0HGI:PEFV-G?NYJBbF+MBB/C:7IYX<PP2&D&g?IRLeIc2)J<
Qc_QO9Y4+HAPQXMZ2AB;LB=:#dUb5Q&VW2ETaM4ffFde4PcVb?\=d#YH7<F2Rf(,
5U<H)OQeQ6c)>606\PM^PTg3QGUH&A6V)U(@XTEVJEF?(7232HTWR8QK)cX+Y:F4
[4:<9P7]NRKccB^ZfO24O@2Fc[XggL(951SL:b/7.2DF63DRJBWDIX8O4L4P1>9c
<X>3&ID>F-e?T+9Lg7[EXAN^bA<9DL>0a22c=0&F7a)Z(O0Hd>8aG):\>C78:H&-
4YC7M+E1#W:e=G0@d9NHE?2-4L8]IT.@g(H4H97<EJ]9e7[5cS@+BB+T.JAB]:^8
T@4)2_:fT5fT>:8.4S5DG:<.RCKQ(1ca-&)[HDNe&N<NFH;3-U)Q-0(C#,F+X/cC
5(8^,;LJ<[AJ[d8F5H@SY=G\S)1XH][+@83bU=;]\MQfPP]#[]+@?.a.-;E:FG<3
-P(.Za8216QF?,@^1U1C_K=XXL4Q\]9e:]9_D#^X,LYZ+Fb8I]a^_K?S+1.0>Ud)
9C#&QG3e;L&2_A@7QcLU2KJcZW@.>f;A_;2MW5Mdd#R:D7L=AG)PaUT+[2/LFL@6
Z&FE2aB1;N\e2_],]7?V7B-KVQ7-ZU>=J67PfLSB.N;U8Q.<-(PQ\gWA@T66\+0_
2I?+L9@<[GV@7+7d4g5Aef+-_R1AgJE-^>2:(J&FLR/P2)Ja)=&;:f(10&-F(T.K
>+-I:ZVXPc+);/=,=@AIBA6XMKLc:I^=_e+Y+BROQ7]<Y5GP.DNL-]NaMZ0_[C]e
RQ:\AC1BQWHUNIA+1I3]g#P577D8P@)ZT#ZZ=MZD53YR;+KSH5H[D&X:?=GU/]G@
;N4dRS<fNHQaXH_+KNCg3b@7,XW>OL_\=[LX>PS_ZCLA9YDDL.R/O86E09F3XL=9
aS]HZG-ABDJ;P4LXg&/?^SYQgQ1_<La-7I2(T79GZ0<G5Gg>dTbDQ\gT;]FW#7XZ
LA1N4E[0aQd/4^;J#U1ZM#FO_aL2b&Eb+=TGc3O+L-FWe(/T+Q[Md[0Kbc;HT>\3
Qc;W-g8f9S[BEe<7QdR9D[@0ID+SI::G5&GR\e;EN6.J:>8DCEMP4<\^WZ:WF0BF
+T7+<S5)VQ-G4H4M>10)RX,MU;@J6c0-TAb;^e,;_T25H6Z.2OZ5,QBbES9<4C9S
T\6X9gY_W8aE[cgO4C]/]97LN79cL]?UUU?2O9?Z]fZg7P/c@6[RBO(@<8&Z@.Ce
2)M7E^98-:,6WLJ#(Z0SR467@&&ERKK:7EdZ3T:R/#<G0^JNE@a@R8gaMI#>W8G6
FF?;=F9\g/,-eKB)N/cO7/7+3<]J21U&)]c]/&@45ZUa44+gf?H2[4>7@P_+8Gg8
&+HUEMT_:L?Xe\,L0]E6=-35?UF<NFO_aIBB#@FIA2&a<417(dS67)G==UL..c9X
NC^&aK)A^8+9V--NETc3SMWSI2+/8KT)MVL.,OcGD(0Le2.@9S0]V,\5H64:/^,Q
;X(df[Zeg>5Of4T6PQ^7EC?ZFBNIJSVL<),KRARJBb#I81A,e7B^0TORQOXTbfd8
LDIE0?\J?:#f\Od&>de;4dO&a<BRZ(1M&.@SZFDcQ@MdG-f/UW;\K0X[+N2\1=dC
V7J1L60#EN>D]EYT#=aHO?ODUC83G<F)gW&0+ac1SJ5]W2_LcSUYENY:eU.Ma<aG
0OCD>?-/3ARU>C7HBR@b&af=^4CaYDQXFT:)G_.#a5HQ7[c<ffgH+14c)V_aR;9.
1+X9E_BPLQ+1+M[::UQf@<U[L>=WgECF=9;K&&BG#NV8K4ZK(GXcF7#^?.0IK-T;
:cWO7,OR.R<ZF5RK4Df,-,WGO4.@C(a<Q+WZG1<dL#AL9<A.RX#-Y6MWaaXM\NSM
b9YcQ],OJW[RcBIBbSg(597?@FWKG@_d])6;Rge;@63EJbKb-ANQb;2FCK&fSGF&
U?SE]_;eY?[Q9=[./;WMeM7?5$
`endprotected

`endif // GUARD_SVT_ERR_CHECK_STATS_COV_SV
