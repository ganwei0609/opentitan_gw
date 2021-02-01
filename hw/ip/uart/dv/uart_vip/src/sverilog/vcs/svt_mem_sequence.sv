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

`ifndef GUARD_SVT_MEM_SEQUENCE_SV
`define GUARD_SVT_MEM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_sequence;

// =============================================================================
/**
 * Base class for all SVT mem sequences. Because of the mem nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_mem_sequence extends svt_reactive_sequence#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
   
   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_mem_sequence", string suite_spec = "");

  // =============================================================================

endclass


//svt_vcs_lic_vip_protect
`protected
G1-V:S(MXG/d1Le.ROX9d)2B[&:)TUR)_.)\=)e&3P5N9IWVUKL?((/3POVcT#V-
/Ug;-_Q,R&a[&X4eJ;?3b4Lcg>dQ/JYP,V7&;WO7fBES-&7O[9)]^-Hd/U\)M-QI
X):.=+LgFBfE02IL&b2[GYKRF[CDFKY=I?DZM9NH1NDME<L(I^d48@(L;6(NOEY7
A^;@N-F3IRU1=[?=TZEXJCa;Z5/P,62Za7<caH72:VJ56-(EKDZTDWDaFdg9Fc.\
a@Z8&(eH/P]?(#>G,O:0dM3T#d5-a@bGH1-bJe@7W^PbD,e-+IHc:5NH]V8AJK];
W.ME32Y1#LGEWc+(B^e:Z9g&XT5#\G1F1eZ\07LUNMAGIWRI7X,G3.ReK9f05VXJ
fQI]=XS\9;KbeUL6?1WGASWM:+4T\U(#?$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY

`endif // GUARD_SVT_MEM_SEQUENCE_SV
