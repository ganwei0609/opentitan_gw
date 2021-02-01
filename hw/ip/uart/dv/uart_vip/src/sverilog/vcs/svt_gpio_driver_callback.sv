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

`ifndef GUARD_SVT_GPIO_DRIVER_CALLBACK_SV
`define GUARD_SVT_GPIO_DRIVER_CALLBACK_SV

typedef class svt_gpio_driver;

/**
 *  Additional protocol-specific callbacks
 */
class svt_gpio_driver_callback extends svt_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_gpio_driver_callback");
`endif

  /** 
   * Called after the traaction has been received from the sequencer, before its execution
   * begins.
   * 
   * @param driver A reference to the svt_gpio_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the descriptor for the transaction that is about to start.
   *             Modifying the transaction descriptor will modify the transaction that will be executed.
   * 
   * @param drop If set, the transaction will not be executed.
   */
  virtual task post_input_in_get(svt_gpio_driver       driver,
                                 svt_gpio_transaction  xact,
                                 ref bit               drop);
  endtask

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after completing a transaction or detecting an interrupt condition,
   * just prior to placing the transaction in the analysis port.
   *
   * @param driver A reference to the component object issuing this callback.
   * @param xact   A reference to the complete svt_gpio_transaction descriptor or interrupt
   *               The transaction must not be modified.
   */
  virtual function void pre_observed_out_put(svt_gpio_driver driver,
                                             svt_gpio_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /** 
   * Coverage callback method called after a transaction has completed or interrupt condition detected.
   * 
   * @param driver A reference to the svt_gpio_driver component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param xact A reference to the descriptor for the completed transaction or interrupt.
   *             The transaction must not be modified.
   */
  virtual function void observed_out_cov(svt_gpio_driver driver,
                                         svt_gpio_transaction xact);
  endfunction
endclass

//svt_vcs_lic_vip_protect
`protected
DGCG\GJD<gPX(U6.>Cca1<6KA>90?-/,DCQcN/M1DE2TK]96V(,J)(##Kd;Z@^M)
LGL&c<.C6=>&_Oc5RW[8bUBb/a:)6V38A?#Z(-MZ(&ON9]TMA^3RMJ<M5BLd:\L\
RAVOQM-P=VLQEJ]+WJfT5.>WeEdOJ7e/LbAg^^U/7>J&:\E2M?FfIe<83\)&c<4P
CZcB?Ud+@YUMg^\#@6;Wa898NNSQ)/,V7NaHW;eLZ_>RH-cd(@&0[7XUPOU@7W##
_ALI9L2:J..1c5:5d#O?.:K\R0e48&?>_IT30==XD.c[]I,3JG+aI;&JEG/=-<&E
Z@APC#dS;Z\KGH;eeYT,V0V?75P\ULD^fCc4&T6HY;E9H_4-gMg@MfWH3>3faT5A
b5N,[)<D]G)R]S3H?LXWOf17b_gfD6F7A-6[<@?0-GfGHLH+b50gOc3>=I[YB;>=
M7FM,8&)R5bLA_VaE\&;<7(g<;3e<:_??@I85Q_966C/eA?=<0c/-<;K0IOYKI03
7,_AFSIRHe1D31<B,&bY<U(g4$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_CALLBACK_SV
