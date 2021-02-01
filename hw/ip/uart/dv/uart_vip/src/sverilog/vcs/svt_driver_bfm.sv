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

`ifndef GUARD_SVT_DRIVER_BFM_SV
`define GUARD_SVT_DRIVER_BFM_SV

`include "VmtDefines.inc"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_xactor_bfm_if_util)
`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_bfm_util)

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

`protected
7/?@\V&]9L@bFRKN8#@7#6C+?^X]]4=<<E<1&ZN9>XeC=&)aGE3-&)EP9B<(GPJB
J@fg1[2,6IB[LV.EcO\66HF3>3AR=M@cEZ6=1VUaUN:L]0^MNOG2]=)1+]ZAM7]@
4T/30A7PKN(ITXKKCN>@:4HABN.[4gPSMGHg-b5T/>fZ4AK@RHIS.DbME62<JSO9
7;0P^SSa+_GI*$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT agents.
 */
class svt_driver_bfm#(type REQ=`SVT_XVM(sequence_item),
                      type RSP=REQ) extends `SVT_XVM(driver)#(REQ,RSP);

  // Declare all of the properties and methods for this driver
  `SVT_BFM_UTIL_DECL(svt_driver_bfm)

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL

endclass

`protected
+./(HYd8-+PYRcZ?[4KTL2DCK;?5E@3RAgLfKf5GQ@@#KLM6\:Ad.)+6J/7Xb[A4
>Z/Z)<[SPFOa2d]UT>FR/ZaV)E4Sg#8RCP6/M,b8QU_,LTW4Pf&N?)bOG\g/G4J]
\+J:(^eO#L.ED,c13G2M#\gad/(ePLIFWP(BF^OIaP&Af6@/KA&S/A)#G<Y\N<bd
M8L\\M)E4B6E,$
`endprotected


`SVT_BFM_UTIL_REPORT_CATCHER_PARAM_DECL(svt_driver_bfm)

`protected
Wc8(GJ5;@]d9\&(E,J@;[@aO+]aW29OYIFW(Y6JAEB:ZX2/^K#K?1)812?YI1Q2A
[-K[M?1SU0F22M1#dM]a7;S6UU]a.+2=a=J&b+W\?9KS/1O7AG#,[P3C2&4E,c#/
RR=][e>Y9Ig20$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_driver_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_driver_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_driver_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_DRIVER_BFM_SV
