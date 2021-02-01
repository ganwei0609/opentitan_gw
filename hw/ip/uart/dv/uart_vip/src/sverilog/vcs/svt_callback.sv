//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CALLBACK_SOURCE_SV
`define GUARD_SVT_CALLBACK_SOURCE_SV

`ifndef SVT_VMM_TECHNOLOGY
class svt_callback extends `SVT_XVM(callback);

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new callback instance, passing the appropriate argument
   * values to the `SVT_XVM(callback) parent class.
   *
   * @param name Instance name
   */
  extern function new(string suite_name="", string name = "svt_callback");

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    return "svt_callback";
  endfunction  

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to initiate activities.
   * This callback is issued during the start_of_simulation phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void startup(`SVT_XVM(component) component);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to finalize activities.
   * This callback is issued during the extract phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void extract(`SVT_XVM(component) component);

endclass
`endif

`ifdef SVT_UVM_TECHNOLOGY
typedef svt_callback svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
typedef svt_callback svt_ovm_callback;
`endif

typedef enum {SVT_APPEND, SVT_PREPEND} svt_apprepend;

`ifdef SVT_UVM_TECHNOLOGY
class svt_callbacks#(type T=int, CB=int) extends uvm_callbacks#(T,CB);
endclass
`else
class svt_callbacks#(type T=int, CB=int);

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log;
`endif

  static function void add(T obj, CB cb, svt_apprepend ordering=SVT_APPEND);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot add a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot add a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
`ifdef SVT_OVM_2_1_1_3
      cbs.`SVT_ADD_CB(obj, cb, (ordering == SVT_APPEND) ? OVM_APPEND : OVM_PREPEND);
`else
      cbs.`SVT_ADD_CB(obj, cb, ordering == SVT_APPEND);
`endif
    end
`else
    if (ordering == SVT_APPEND) obj.append_callback(cb);
    else obj.prepend_callback(cb);
`endif
  endfunction

  static function void delete(T obj, CB cb);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot delete a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot delete a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
      cbs.`SVT_DELETE_CB(obj, cb);
    end
`else
    obj.unregister_callback(cb);
`endif
  endfunction
endclass
`endif

   
// =============================================================================

//svt_vcs_lic_vip_protect
`protected
.g?X&66eb0@74O8^aN:<]]5+>V;,XMI#WMMW7=8N6Y9GMKJ>[VMJ1(0L?9W]7MK)
?cLJ,]/Q/=S3>ZdV9Q91b9B:>9G:;LE?CHGNS+7>?U5:JL.&RX[ZcX&N@f+]GcQa
@N585GPD)W?65XLDI3KQZID3MKMN.dRA])ZLLSgBXIT[O@YB9ORIcMK1O>8D4TH3
6R5]TZ,J/V;BEGf7aADBdW8gb;P_;HIZ(\A@6Lbfa(&fJCGTKLEf2TNcSV?5:V?1
CC4(8f]#b>MNb^YIDS]=>6_D7_O/+0GG<C.#aXU>F-b-9Ba3V:3.9\_8:6f^2^E>
8/Zf\KO6^)+W(FXI++49#<@2Z1&.JgQM7[B6F+L3cVH+Ba-<XMd..K;IPOf\4#eZ
L\-(Q(+BW48+@7,d;IZE?1<MTLQ&b,?7?c0L=F=CS4>SER0;]cdN^BbJX&[P#[fF
U>cIB-1Z=VgIH<=Qf77^J-XYCO#K:I:)0VRf/.KBOJ;9L//Z+?6ZSL2SVZ<]4dIF
+[bZ50MXI^)>J_]VA\)3):[T9RJ<K\<Pb)(;BYQbS(B9UdV=O++e8BVa>9Yb89/+
Q;Uc&;@O1Y\:ed4[3Dd7O5PZe,.(Y\-HBB,3)gI\;98JQ\)AY&?,W(_U91);F6P4
g&:DMd2bHV)&S;La5/Q&0f-_9d8^->FDH6<NCb751UfA<G-LOIA/34g&5=P7<HEK
<,53C(gL:eUZ=GI^GEUc)K(e&Q;LV#4cZ)Q(&L92057\g8QY]ASZ.=_HK6DaI>M=
e^Dg,.RSQ=+W3BE:RUC0gC/66g^/)CGc3\]+-3ffECMY1?RDT@4>?Q@)J&fP+9#>
BQDJKb^),64;g=[dRV^@64U3?#==#>LRRR+e+5gGFcCLXMR_,U;Q#-+P<&)+D:[e
-N-AfQ4@Z[+UJZ8/<d-I,Gb[+U-fS5-;9$
`endprotected


`endif // GUARD_SVT_CALLBACK_SOURCE_SV
