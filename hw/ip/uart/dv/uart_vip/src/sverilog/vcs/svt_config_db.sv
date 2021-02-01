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

`ifndef GUARD_SVT_CONFIG_DB_SV
`define GUARD_SVT_CONFIG_DB_SV

/**
 * Methodology independent configuration database that can be used to share
 * integer values.
 */
class svt_config_int_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_int(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      int val;
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      get = contxt.get_config_int(variable, val);
      if (get) value = T'(val);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * string values.
 */
class svt_config_string_db;

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            string value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(string)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_string(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout string value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(string)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      return contxt.get_config_string(variable, value);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * object values.
 */
class svt_config_object_db#(type T = int);

   /** Matches the uvm_config_db 'set' signature, but provides support of OVM as well. */
   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_object(scope, variable, value, 0);
`endif
   endfunction

   /**
    * Alternative to 'set' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'get_from_parent' method.
    */
   extern static function void set_for_child(`SVT_XVM(component) contxt,
                                             string scope = "",
                                             string variable,
                                             T value);

   /** Matches the uvm_config_db 'get' signature, but provides support of OVM as well. */
   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_OVM_TECHNOLOGY
      ovm_object obj;
`endif
      if (contxt == null) contxt = `SVT_XVM(root)::get();
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (scope != "") variable = {scope, ".", variable};
      if (!contxt.get_config_object(variable, obj, 0)) return 0;
      if (obj == null) return 0;
      if (!$cast(value, obj)) begin
         ovm_object_wrapper wobj = T::get_type();
         // Watch out for objects (e.g., svt_ovm_object_wrapper) that don't support get_type very well...
         if (wobj != null) begin
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), wobj.get_type_name()));
         end else begin
           // Just go to the object directly to get the type.
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), $typename(T)));
         end
         return 0;
      end
      return 1;
`endif
   endfunction

   /**
    * Alternative to 'get' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'set_to_child' method.
    *
    * The 'use_fallback' argument can be used to establish the generic
    * 'get' method as a fallback, in the case where the 'get_from_parent'
    * processing doesn't find the object as expected.
    */
   extern static function bit get_from_parent(`SVT_XVM(component) contxt,
                                              string scope = "",
                                              string variable,
                                              inout T value,
                                              input bit use_fallback = 0);

endclass

//svt_vcs_lic_vip_protect
`protected
Q.8V>X)X4-CA9.XF)FKO#F3=EOQ<W2-6T]C]:TBYAa4d#.:(dK@L,(gOK_D0-Fa;
UT=UHMD.O/b&J=cE-R#E[?/LVCTEbF)3@[gJ]E\70^2G)U67BdKbT_#S/IBf\?+c
.e23Ld,9g3M=C\c)WKU?DIM4Oaf-P\<4934TW-P198#5#A7\NN>dD2VfgB.0]OV\
d;f)EY1GFFR(E&]Y:GI^051Q[C#6]VA)7LZ1)dV[LOZKT=;N43.P1UJZCRfQI=ce
]Z]d>0dI[J[(L._XB(I/C,31LEe.Je2aTU?47/@ZYX2(b)_SH^;Z08]T,6>9E9]@
7J_12K-gOTA^QbYV>\]KCF63DI89H]GX_Y3QZ&Y:.I+]<bLbH4J#].XYVF.6cfb.
58T=Ad+R:8S?>>O^A4bUR_(HgP40;,BdYbME[K:#/#[VbS75J6U-S/9bJ4?M=-aT
6MQg7HB(MQ(Y,6_3:NbSF+aD)?1&=E7\H.;/:E7E@CI9XF--1L3E3:)K5QV=H8T#
0EcU([S(VI6b\KL7@0EEW6;<YS:4E?N]+[U+&=M_\.c5PVI&@\WdgdT+f+ID4U5a
:#f5QP<U]?3/(.g&\\baX1T?XAC@WD6LaMR0X:\-XT9V1I>2)M^M3HGfM+30b8QO
I_<a@&f.JWP[^1c]M4K9Kd^6ZbO(f2=X5&7#/75IO[f8JI[X#A1\0_<TUcD=_c-+
]R@g?O1f=a[)5Sb)-4>e)]c?:_\P]cNG,9d^II.cVTRZZX;d2\d601ELMOOe9RY)
N_UNJ5BL1.0C9/25/S_)bISZ6;^A(Yf59]6(aB&e_\_5,I/cGB.W#PfZMKb\gg22
d<JERf4cD775IaW<cPg75B4-7UYH1US<Pg]?32CL.;[\=)cgCEKJ;HR:8e0Sg9f#
a/Y._65>E\e3Ze-gI76WQ34UIWXN;\8-A6-(QGK;6H#cB\CN[(\9f-HY,J(2KA5+
R)@#@B?,D52[=Be;Hc3Pdc^Xg8B[@ANfa.U:V+3>:_2A#;&QBT(&[41_G30U]dZ-
&eG^_55>&^H>88FF<#fERM3d,8e3@1a,W\Y2G.BEMY?Z5RR8V9^#_YZUW5(/.[O[
-</E;cNPC@3IKY#VUD1(VbH-6@PO5MTBWYA>63<LBdS-UgU0]RJZ)\D)-Nbc?EWS
+=4QYS+1F0M6&OSSeZf,KYMa2<<,T3KdYT][^CR;C.=N;?LMVS:d4Yc+IZ:eIHM1
REJ3CDQ7:>],>\_(Hg<D\]AOP7@0M(fbE0@\ZPJJ_(O6e-C.]HEgbfGJc-:^4aG/
8=Y9)_X\4FBfCNY&851>]4D[CTT9V_Z[&f\ab;^La\U>NH+UafP5HM:RbU7bC]_V
Y^fS9:J]DG<L/^+9MOdFD6d2g4D0ER[UJdT3A\NbSbECUESS6bPPKEKc:ed3F7AR
64^H4G_BCKG?78BH..J003\bdBW8[D24WWcN<L7QHa^=IEeS54.F6\B8?)d]3)(b
2=dT(RL/&LYXP#><MY\N]JVf[/M[J^f=OEGdeZf1=5Z]NPNB)Y6CUW0F94d=[E5\
/]CJ#PH-0D)>@@R1L.&]?Md[g/I)@@7)4]gU:-]Zc21-ISZRaB\OI;6GWF,2T-FZ
Aa:BPMCd:&eaL)cSBA,F;ND[CR^=SWa3)P]>G4+9NY6Mb?;LA?T\,F&@,5AT>aK9
7+^d1LDgOX8HE7cC4.)LMRd7(Zb6:FC:99_ae[#LPb\WZ:M^<>VXI=X)1H(L@4[,
8:@I>U\f2K&]1?[M7f9][g.Q(2;;=QN_I&0RfX+0c<216MM<gL>A@6@MM:2;KS;8
cVBI_R7cf,I@[Fd;:^Vb^XI#;Y4cWL#=U/5<[^Q<LBBg5,GQd4@5TePS#R8=NJ-3
3)@+FMS4];/?M1.8]Q\K4:@.I#,U@VBG,RGPZCaAA[5T4QB@6e(;#K\;V1S+8:aC
1bL5EF5GII]J[X^)9-_K1<LRB/_/4QP<^S-T_U0C>=KOX3V6MWAgIW8KTa5S[_]9
REgg-47\IXb@\W&d^9N[(J9CM=If1\OSI#BE8ZW4>6;OE$
`endprotected


/**
 * Methodology independent configuration database that can be used to share
 * virtual interface values.
 */
class svt_config_vif_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      if (contxt == null) contxt = ovm_root::get();
      wobj = new({contxt.get_full_name(), ".", scope, ".", variable});
      wobj.val = value;
      contxt.set_config_object(scope, variable, wobj, 0);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      value = null;
      if (!svt_config_object_db#(svt_ovm_object_wrapper#(T))::get(contxt,
                                                                  scope,
                                                                  variable,
                                                                  wobj))
         return 0;
      if (wobj == null) return 0;
      if (wobj.val == null) return 0;
      value = wobj.val;
      return 1;
`endif
   endfunction
endclass


`endif // GUARD_SVT_CONFIG_DB_SV
