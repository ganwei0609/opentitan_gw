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

`ifndef GUARD_SVT_COMPONENT_BFM_SV
`define GUARD_SVT_COMPONENT_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
HN_7#A1G=8T)+3;/6ZfPA-V<S8JI;b@M\RfZP=ED.T/R9Hf-N@Nc2)]M<3NLc[S:
WH6EZ;GFP3^&/6,Y>S&\K3Xd76KN<D8UP^VeL)EN6^:ONM:Ba4GM3).^]MW8dT6\
F2IG-,=8IccQ+a7(0&SQc3a@(PPEDM4#NPeSZ)d?F.3_24-#J?UB?DX,1\4#F2>E
UNA#<F2[=7\Q-$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_component_bfm extends `SVT_XVM(component);

  // Declare all of the properties and methods for this component
  `SVT_BFM_UTIL_DECL(svt_component_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
7/L:@D7/:Je1Je\N\@G2NPd9<P(cGc,XIG8>b+&)T=:\a\:gKX#V1)b&8+;Ib4bE
[cC7MM9cB=Hg133^FQ#+J@,=b)ES,B-U.&-MA8#A]_QS7DM)FCdcODP\LB9_bN9d
V8T)a:O4edTIWd.,9VgLbIDV09)gQ]g.5#Z5B#Xe12+ZW-J]D_JH5#I(S^?A#FV3
.FB(f2K5a:_,2071+<f(23DV2$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_NO_PARAM_DECL(svt_component_bfm)

`protected
H/\HPd2Z:^-W8D)ZcD=bI?FSK.[NN=7I:?:[G_EU0<=HL+N;89>H3)ZR;X7gBRMD
DD]:JINFJ@DP0CB?]f84NaLfQO;98OeNW-ga1<>6?Z/CE-A[OT?g_J5/.)RNHRBY
0L8G(^<D)K=O)H&0.Y[a.OLf6$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_component_bfm extends svt_component_bfm;
  `uvm_component_utils(svt_uvm_component_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_COMPONENT_BFM_SV
