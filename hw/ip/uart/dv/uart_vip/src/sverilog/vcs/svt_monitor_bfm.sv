//=======================================================================
// COPYRIGHT (C) 2010-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MONITOR_BFM_SV
`define GUARD_SVT_MONITOR_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
4UD106XUW:G,\gCf9F50^c/PeOP?ZO@U:X0-b35c_CTM<2\c\P\+6)TP.D3\=L.b
\Q_?J;=)EJ,G]5g-OR_UH(D^Zdg8E)^bT7=>f=+R3B0@f\8O1Dg\f^,G7>c_G73S
KF>HXOH7)>A61EKPF=41[\fB.c+S^4UcK#5dZ9N)d?00&^^E]>_SJMG<A\L776c<
D57#1TKEQI)6+$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_monitor_bfm extends `SVT_XVM(monitor);

  // Declare all of the properties and methods for this monitor
  `SVT_BFM_UTIL_DECL(svt_monitor_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
@7JWQW6RXb^&4<7686R/cRWX5@0G[LN3N5&=;)MC(bb?\e+RX;f1))]V2M+?/TU.
1?S:\2@X^f5-UgLG@@K@2bW2P0M3:@SFI8[3]291?M8R^1NLUcUfJSTb5.O[-KS2
-Za:PK(0-2OLU.2(<CRH^a8H.I3>>[0Kc=X)2UF-?+FN:)8IE4TS&-Z66]C3L?2P
[,7cOT5K]\)L.$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_monitor_bfm)

`protected
5LO3IN6IM7X^@C]CO^W2+f4D[@Id8_#Y^ME[#d1Ib+#-OS)KHcI)6)(]L>_MbH\W
Yd=6AMUS?<C?Z8CNTMg=I51/@=>XC;+<N-RY1H&V^ED16T16d=78VC&@ICM;M.A.
6-Y25XOB7[6@e<GXP?O[9Z1/4$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_monitor_bfm extends svt_monitor_bfm;
  `uvm_component_utils(svt_uvm_monitor_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_MONITOR_BFM_SV
