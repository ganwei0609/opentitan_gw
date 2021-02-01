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

`ifndef GUARD_SVT_XACTOR_CALLBACK_SV
`define GUARD_SVT_XACTOR_CALLBACK_SV

typedef class svt_xactor;

// =============================================================================
/**
 * Provides a layer of insulation between the vmm_xactor_callbacks
 * class and the callback facade classes used by SVT models. All callbacks in SVT
 * model components should be extended from this class.
 * 
 * At this time, this class does not add any additional functionality to
 * vmm_xactor_callbacks, but it is anticipated that in the future new
 * functionality (e.g. support for record/playback) <i>will</i> be added.
 */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
virtual class svt_xactor_callback extends vmm_xactor_callbacks;
//svt_vipdk_exclude
`elsif SVT_OVM_TECHNOLOGY
class svt_xactor_callback extends svt_callback; // OVM cannot handle this being virtual
`else
virtual class svt_xactor_callback extends svt_callback;
`endif
//svt_vipdk_end_exclude

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * A pointer to the transactor with which this class is associated, only valid
   * once 'start' has been called. 
   */
  protected svt_xactor xactor = null;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the vmm_xactor_callbacks parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name="", string name = "svt_callback");
//svt_vipdk_exclude
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor callback instance, passing the appropriate
   * argument values to the ovm/uvm_callback parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor callback
   * object belongs.
   * 
   * @param name Identifies the callback instance.
   */
  extern function new(string suite_name = "", string name = "svt_xactor_callback_inst"); 
`endif
//svt_vipdk_end_exclude

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Method implemented to provide access to the callback type name.
   *
   * @return The type name for the callback class.
   */
  extern virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();

//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to initiate activities.
   * This callback is issued during svt_xactor::main() so that any processes
   * initiated by this callback will be torn down if svt_xactor::reset_xactor()
   * is called. This method sets the svt_xactor_callback::xactor data member.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void start(svt_xactor xactor);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to allow callbacks to suspend activities.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   */
  extern virtual function void stop(svt_xactor xactor);

  // ---------------------------------------------------------------------------
  /**
   * Provides access to an svt_notify instance, or in the case of the vmm_xactor
   * notify field, the handle to the transactor. In the latter case the transactor
   * can be used to access the associated vmm_notify instance stored in notify.
   * The extended class can use this method to setup a reliance on the notify
   * instance.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   *
   * @param name Name identifying the svt_notify if provide, or identifying
   * the transactor if the inform_notify is being issued for the 'notify' field on
   * the transactor.
   *
   * @param notify The svt_notify instance that is being provided for use. This
   * field is set to null if the inform_notify is being issued for the 'notify'
   * field on the transactor.
   */
  extern virtual function void inform_notify(svt_xactor xactor, string name, svt_notify notify);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by transactor to pull together current functional coverage information.
   *
   * @param xactor A reference to the transactor object issuing this callback.
   * @param prefix Prefix that should be included in each line of the returned 'report' string.
   * @param kind The kind of report being requested. -1 reserved for 'generic' report.
   * @param met_goals Indicates status relative to current coverage goals.
   * @param report Short textual report describing coverage status.
   */
  extern virtual function void report_cov(svt_xactor xactor, string prefix, int kind, ref bit met_goals, ref string report);

  // ---------------------------------------------------------------------------
endclass

/** The following is defined in all methodologies for backwards compatibility purposes. */
typedef svt_xactor_callback svt_xactor_callbacks;

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
\;bL/OfcZfa4\Y)a++5cY/A-+eUT/\=H:8Q2R+)IeT?R-/FVV7:K7([J_E]WZ@e/
,A)e441AL4<&>W9e4\T8R@_c=[?+\<BO,8MgHLR9f4TIMIBN<38+7dS\T5:_=E?)
.WHT6/gP[=[+L3FXF)<N34gO/g5AAeT6.QX0TKB]:?CRff<U6<]/HUYP-3#/^+(:
AB(4<X=YH1U7Xc.S3>./];dQ97gG[9\=73B^(^GE#Q)LW[W,BGHTU<R57<E#0RLP
M)VR.NGLMFI^F^bB5P),a)5RZ,6-).<C7;1(0VC3gCK9,3<EZ7_-[[[f-9QG@;T+
PX?XO(>OTgA-:ZOZG(g(^Xc30KMc?fE:S@a>5Q1H#T9J+M>,7;b+U/<c\,;9ZDV,
S7/(5(d#+TENLPO6O,147:7R(U3;YYV<^N2OEd&+A89dXVJTQ<D?A>:fH2:6E9W5
+TT/@S:HF]Jfa=A51<AO(@(/G&KW0=PQ?RgfTA.-#24:A4fdVB(&Ug92OKJ6K+]g
d<Z&Y]WIY.K-7@XLU7&2U:>?ET9;d2aPPFN/VGKF1Y?3X_>dU[T.](_(YN66EZ+W
V_Jd2X(=;g3Xf<F9bZ51OdJ2&1^6P.\+4@&4\/TK=,#JVUW6U#FKH/:#gW8IKc&U
eA+Gf=Jg/gRdZ>e#g@_dH3eVG.YYgcFY8Z&Y_W2K/K=.FBHa^FX)+:=4YR+(\V_V
C?&^<_JZ3@?6_=+&+f:F2cN>/b&17G_aI^(=Y0/PHHU]g_BJ_c=)4Y:g;<>-7]9X
<##]V;gZB3<.&dJ7[]Jba.?:1>&ASY&H5MGIdS(Bb1[c)AE&/dc2KcZ3FX:B:4/[
7XK=E(^BPFBcYNNg_ee9UG#N.#5@/Ycb\ZJHC8d;LC?/M_M(6/6ICRCgJZYED&4N
H&]SH4^_d0[G&[+GNZSV1Y2[._AJZHF.CbG:05GVe^/F@;O]-84^A=Y-<6)D5Hf-
&4&UJK+E146.>+G,/dgK1?+R:#?WJ4f4_\<=CgU-SYHUY&:4-1Td9;&I3I\))a]:
ZP#B\SF?2]-0g:4\Y;Z@^,_4DZX65?@10+TXBNDPKR4T@3BK)X12C<Ic96a[aMa)
81f5.UKS0.Rd3/T=NIX1+CJJ4BT(-dPONMY6K/R#;;-fY;M_<6U\#VT[PTaY;10g
,@J>bER^FQG[98K-J:AF@IIJ.e[8MC4_05)#S/80[4IVDFCW)+g>#72^G2J//8fX
9^Qf(4R+7FcQ..FO?QL/cQU2c0?HQ/;7@TPN_BUT;W9eeIa.Z221RS6GX:2S_F=a
K>PI)]\,(NbPMB20\ee8R#]F.VT+Q(ZFf&>c.:>G@g+4D;)gE-Yg9fD+R=K2557b
+^X-_V/<G5(YV3>;N:\a55&f\UUQ9SI(A8YI?,D,BKgB/[MX^@AV^JH)B1L0dgK0
S>-_+V/KcU1PNBfPFDE+T6L=b?gP\>T=LgH?ELJ9#U\F@7;Q)6T&^JL;&dEC9UK5
fN0D^NbUg0a=IE;8D@-CcS/#5ab6._/5/)VPL<<2cVOK:BR\D6-:(Nb&VH(0eA]N
WK82,BA6A?Jc_8cebUEb].C?SL;(bfZSf2SDG.)[M8aZ\WcUJU++UeL\JEOb0N=V
.W?;QY)/d5HRD08W\:gQ?gP&Fge?W29[9EMC]6eL\R?#7WV=7IbJB?Sa?Ia)IDYX
LES?a/Z0EO7BP<G(:gS_4[CcVd<SW;Zbc:c)G_/3aA-Y12H1A1GCe1_Q?,P:-D)A
WTcSCDJ:G>Yc<01.DfU<6[ZR[=7SYH]E795=6Qf=;S[5=9R&#PW20:,7692O&eBg
JM4eH_6Vd\8BD#A<dVMCNcC3eT(b,:NRNV;L>EgRRGS>eRg>C/]^+VMYf_5SY^?B
+8^;XeM//J1A//N@BW>\[=VbGIO>SPg;/6X\+(Oc[LZY?VJHK.K\a:>gKE\CVbCZ
.)Ng0M91O8#FX9DSL-B0;QW5=Y?2KZ)YBF>+&IV//56>?3X(]BfH;[F\J+&XCFdG
M.63@@?Q4ME[0@C,A3@e]4.USaUJ[/JQ_A),DP,.GURGHU:,XBD;&)fP4#\g:&NE
;@(20/)3I.U:N_?26[WT)R<2:)\ADc.[H8-4&d;\1UegWfB_G,#3>Q5MOJ<BS_;>
&G(I+Mf;d:-8VPgOA(2eTDeO1&/8dLHNOKL9@EG9D]V_CbFQ&fGLQY>#Y/]HFMfO
c@[.S,J52:<_WY(D<98#5D;F<4PeKZEgQbL-Q,aQIAT]-ffeU>L]N@+PI0I+>bG6
<4?TdV3dYM=EVD\).=26_5>W\/dCRVa7G\DV)G4::gM2F7]D-89RR6BRF;b(U@11
E(_;cX]AH@8.#N3[bc:&CfJ=&+NIg:NW:J&AY?R_>0c^Bcb54DW1aTAb2GK.^<gH
_=7-RGR+UY&NO7;H&EJFIa3dCD>fU01FKL)R6&?X.7CO\;O4<[=BZc/S:<I/7)IN
KR0F@eJ9g5dB<+_I^7OAD.W+:-D<BcTY.[cKG&TV)c9S)YG+ba-=32^2K6J(gCg@
FB:S=bNO_6f3JBW8EY^.TLW+2$
`endprotected


`endif // GUARD_SVT_XACTOR_CALLBACK_SV









