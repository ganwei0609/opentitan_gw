//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_CARRIER_SV
`define GUARD_SVT_DEBUG_OPTS_CARRIER_SV

// SVDOC unable to refer to class scoped structs
`ifndef __SVDOC__
/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'before' callback
 * execution logging.  The macro should be called before the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals - Queue of primitive values which must be presented in the argument order
 */
`define SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields='{},objtypes='{},objvals='{},primvals='{}) \
  svt_debug_opts_carrier pdc = null; \
  svt_debug_opts_carrier post_cb_pdc = null; \
  bit debug_enabled_w_user_cb = 0; \
  if (is_debug_enabled() \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
    || svt_debug_opts::get_enable_callback_playback() \
`endif \
  ) begin \
    debug_enabled_w_user_cb = has_user_cb(); \
    if (debug_enabled_w_user_cb || svt_debug_opts::has_force_cb_save_to_fsdb_type(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), objtypes) || svt_debug_opts::get_enable_callback_playback()) begin \
`ifdef SVT_VMM_TECHNOLOGY \
      pdc = new(null, get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
`else \
      pdc = new(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
`endif \
      if (!svt_debug_opts::get_enable_callback_playback()) begin \
        void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".before"})); \
      end \
    end \
  end

/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'after' callback
 * execution logging.  The macro should be called after the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops='{},primvals=default_lhs) \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
  if (svt_debug_opts::get_enable_callback_playback()) begin \
    if (pdc != null) begin \
      pdc.update_object_prop_vals({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname)}, post_cb_pdc); \
      if (post_cb_pdc != null) begin \
        bit[1023:0] val; \
        if (post_cb_pdc.get_primitive_vals(pdc, primprops, val)) begin \
          bit[1023:0] default_lhs; \
          primvals = val; \
        end \
      end \
    end \
  end \
  else if (debug_enabled_w_user_cb) \
`else \
  if (debug_enabled_w_user_cb) \
`endif \
    void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".after"}, ,primprops));

/**
 * This macro can be used by internal cb_exec methods to resolve some design issues
 * that block logging and playback.  This macro can be used to record internal events
 * that the VIP recognizes, but which aren't made available to the testbench through
 * an existing callback.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals_pre - Queue of primitive values which must be presented in the argument order
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals_post -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_INTERNAL_EVENT(cbname,fields='{},objtypes='{},objvals='{},primvals_pre='{},primprops='{},primvals_post=default_lhs) \
 `SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields,objtypes,objvals,primvals_pre); \
 `SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops,primvals_post)
`endif

/**
 * This macro needs to be called by all classes that do callback
 * logging in order to support logging. It should be called within
 * the class declaration, so that the method is available
 * to all cb_exec methods which are implemented within the class.
 *
 * T -- The component type that the callbacks are registered with.
 * CB -- The callback type that is registered with the component.
 * compinst -- The component instance which the callbacks will be
 * directed through, and which contains a valid 'is_user_cb' (i.e.,
 * typically inherited from the SVT component classes) implementation.
 */
`define SVT_DEBUG_OPTS_CARRIER_CB_UTIL(T,CB,compinst) \
  function bit has_user_cb(); \
`ifdef SVT_VMM_TECHNOLOGY \
    for (int i = 0; (!has_user_cb && (i < compinst.callbacks.size())); i++) begin \
      svt_xactor_callback svt_cb; \
      if ($cast(svt_cb, compinst.callbacks[i])) \
        has_user_cb = compinst.is_user_cb(svt_cb.get_name()); \
      else \
        /* Its not a SNPS callback, so must be a user callback. */ \
        has_user_cb = 1; \
    end \
`elsif SVT_UVM_TECHNOLOGY \
    uvm_callback_iter#(T, CB) cb_iter = new(compinst); \
    CB cb = cb_iter.first(); \
    has_user_cb = 0; \
    while (!has_user_cb && (cb != null)) begin \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
      cb = cb_iter.next(); \
    end \
`elsif SVT_OVM_TECHNOLOGY \
    ovm_callbacks#(T, CB) cbs = ovm_callbacks #(T,CB)::get_global_cbs(); \
    ovm_queue#(CB) cbq = cbs.get(compinst); \
    has_user_cb = 0; \
    for (int i = 0; !has_user_cb && (cbq != null) && (i < cbq.size()); i++) begin \
      CB cb = cbq.get(i); \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
    end \
`endif \
  endfunction \
 \
  function string get_debug_opts_full_name(); \
    get_debug_opts_full_name = compinst.`SVT_DATA_GET_OBJECT_HIERNAME(); \
  endfunction \
 \
  function bit is_debug_enabled(); \
    is_debug_enabled = compinst.get_is_debug_enabled(); \
  endfunction

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_debug_opts_carrier is used to intercept and manage whether the baseline
 * pattern data carrier functionality is actually utilized. 
 */
class svt_debug_opts_carrier extends svt_pattern_data_carrier;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param obj_class_type Class type values which must be provided (in order) for all of the object fields
   * provided in the field_desc.
   */
  extern function new(vmm_log log = null, string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param name Instance name for this object
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param prop_obj Object to assign to the OBJECT properties, expressed as `SVT_DATA_TYPE instances.
   * @param prop_val Values to assign to the primitive property, expressed as a 1024 bit quantities.
   */
  extern function new(string name = "svt_debug_opts_carrier_inst", string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_debug_opts_carrier)
  `svt_data_member_end(svt_debug_opts_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file. This implementation is mainly here to intercept the request and
   * pass it along or discard it, depending on whether debug opts are enabled.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK
  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update any object references
   * with the data that is recorded after a callback executes.  The callback is
   * uniquely identified using the full hiearchical path.
   *
   * @param cb_name Full path to the callback that is being played back.
   * @param post_cb_pdc Pattern Data Carrier object associated with the callback
   */
  extern task update_object_prop_vals(string cb_name, output svt_debug_opts_carrier post_cb_pdc);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update ref arguments on callbacks.
   * The pattern data carrier object that is recorded prior to callback execution
   * must be supplied because the pattern data carrier object that is obtained
   * post-callback execution are string values, and so the original property type
   * is not available in the post-execution pattern data carrier object.
   * 
   * @param pdc Pattern data carrier object recorded prior to callback execution
   * @param name Property name to be obtained
   * @param size Number of bits needed to encode the return value
   */
  extern function bit[1023:0] get_primitive_val(svt_debug_opts_carrier pdc, string name, output int size);

  /**
   * Returns a queue of prop_val elements 
   */
  extern function bit get_primitive_vals(svt_debug_opts_carrier pdc, svt_pattern_data::get_set_struct prim_props[$] = '{}, output bit[1023:0] prim_vals);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`protected
]D1WCc.&_:CQ.\bTQHE;2O(R(:2-a8eHPQW<C</6ZZS(4XPN:,(65)I#R?)<BQO<
AQ3GBB3[CeEJ?dJF7MdOWCKGYa[Q=>@V;63CNU&D(D,YHP@^T[2&:[AMUFIDgMWd
##TSJa^<;.MBRHEb[@=4Yf1.]#3#^]BYK>YLBd02&,D_aW(W-3MTW+E;O4QWRCfZ
J,-#A7(/fMNMI5>WJN9]U,d9]SP(-7dOM5S&(:4Q][6VNdBaM6)3<CEFW,=8ZY,T
&C2:G[,9DW9d-:_FYEd=BHAK4;Fe#Qb+G\[H.1Sec7DgE9TfQg3e=EQ?&(,643(:
QGKM0A0)]&Ug+d8B-/>eVaUUQ\N]5J)A;^HTSL(,gC=Gacc<0<3JN<FU[C4^E3eC
5V,YXR@ZS^c3Nf<\I#_V8_(&g\W\E0YX1\2a[RZPSfI4NR^682]]QF8S-5HD\Tc0
4H&F9=EL@Y6OKR\0SeGdA^5ZKKH,[^3=.Q4J)CZ^c>906-).]R-dN\4e+OWMY@=_
SH7(?Y1DXHLL3S43PW8c@.QT-TfWF8P=HVWCD@0-(B8D>cfe=@X_&FRRaJ^E9.,\
K.?b4aeg9JLaY(8_+QO#Z=OAZ.Be/=W1Ja/.>]6YcK&GH,&e.CO.E^>\9@V6;TCK
O\7QT8;#YN92C;W)4YEE_ATKW8R>ebg2A3f?@OPV,_\T65E6@PTBJd@;Mbf0dc1@
T++\=;Q2a++1+4cNBR\<#84#.7Zd@NY<^5[-5M/PR]=SJ3)9J/D>5Y2+aH\1;JbY
O,@a^Y\>6f_.V7ZK5M(GSgM7I?D8E8Rf^UO=;.H4b\UVdD7TJC9XUR4B],7c,2WD
#SXAeCB&O()>:DE\5Y6LgD3==O+V/VA_P]FcHG0CV<,1NHRX4(WA]_67N@WY=K<G
9f/SEOJYPQ]FI4YbD_HYI0I)4YedGV>CLdMQ1QaE@.S#/=BGH2+..(VEVA9ZKV#f
?FLgM^#6Q@=b6d3S4JBX7UNd&_,79@Z[V1BQ[F?aEI&)^>;RW5,;J9K^/<95>[2<
50;H5&Z1/.1QP83-f)/[?;HN=2a7?AAQ+<#H[]14e[L9eEPLDZXZY7R6B=S2Z0\,
_<Z^6c0g,XXD,HEFHXHc61=RLS8@ZPNfAZ:#YOGSNS^=JGAS\-gdg<LgXPceKV\a
OE:W1>]6#UY]Q0,2WOV@J9?c3+^EfEVP9E6)(40M<a:X&_#LF/9b3A9Va?fd(e?H
=5H>B3T4D(>G[7HAU.2\.7#Q#N3TI+KA05L-C(/:3L@LfLF\[VKIXg@aNQCbZ;5-
X:CC0V:a0Cc&d7_@[a0KYK<,cC.1TA6ZJdcdEX^:d+aS)9Ab6SE4FeQX/_cDEUB7
,?=@#PL4&D1U)9^O^X&75L6OG.b/)(Q<NA8[WV/^a]#X-W4MSAOG>e8[D/<Q42AP
7Q#Q;0Z)&;SYgCd<42O6^^aCFT+B-RLbO7+26dX>T09D@S&.a\:KNR@gaMUUH\Mf
Y@O==Q@BAL^T9)OWJf^Ie2c7S/S;2Z#SUd&2:c,#1?JVN.+Q+10O,#4[ZT7Y+54)
K/a.Gf/8.>S:0X&dJ1+WF?a](aW]@\8T;YFWA\P2S;+c-J&gZ0d0GL>,(0-Q;&>8
7=_#AOA3F@-,;CY_3&f?b602?4?Eb,gM#YSPDSR..2LL&0VNNb4/g@aZ=:[g_:NF
C\P5RK)b+c1SO<?fM;Vg<ea]V;VF0XF,K=Q674RQS-g[3@&E@0Q=WY6SOEIB8D-/
0A:5Ld\[XS@UV]J/KR7X]?Z/TNA2[SUZY8)-JNa:X_B(EXK^Sg./Y(3[^56X]JeH
#V)&V8MR]6Kd2+A-D?/@.TcCI4/N>V7#&LdZ>:A>Y+3LX]V@37ZC;>3;MJf&_B33
P4Z@ccIPY2If<aXfeI#@ZU#cSFaM4C^4N&F4cd6C>(+3\IOOIeW<\6gV2]c>bE^:
O=\d[7HQA=[E&^cGH?19f<Y9Y?;[gT4QX[:&(#JI-^\I\39YRM3C3<#3Q^64\2:g
J)F<bR9YH]c.cc3?R>5P=B2>-SY.4V.;:f:c:B#Q[&b32QL9Y[)9OH\S9\Z425L5
N@35VK4/NDOMFN,Q?_^0Y=P_^E2.a>:44^B,\-XH;E).&61]Z9P90<EQ+Aa@@RbF
HXQ)0?#.5._@/eH.&:,ceZXL5;gKdBPE]PgFZ<1OgSdHQXIQ&\[bW(K>F4a;4.BN
GJ4aA&CC;4^:7O(\e8We]L-f]JEXGF=QNY&@NLLTY#4/5QA.F@2S,#>1:9(<.SM7
Z_fX_RO<:<3AGW(A1]9)E4.,-JK+bTD<2<SI8#^/OXcZ^2G8H-]SRM.8MJ-SC;a]
TE,0P8TR;T#RHbI12M,JDYBC;Q9_IZQag(KJG98QL?=03ObZcJSUW)>,JAEIX_:;
#OMJ^?Zfd:@e1-3Q8?IA/MYXg=aAMX#50;3USJf5UdJb-)VTeJ(]QY@.C+UBWHPf
3,9OP0O#9]-.bMAKcH3Ig/ZBKRDUB;..-EfL:;F-5>db[PF]\NdGC+>-FW29)YfE
.&M+5V0^O0RQeRKEBK0C/G)(QV[2K&ZdB&S#WfT5SY3\G]Y7d=,_c8+<V.0>X5D]
XJ+&X_XWF9#Y[H-,#R]3J415gO+.T:4L+1VDUIO>.9\I<H.e3M.J+VbY]0gZ/ROe
LE_8c>8K-0]/f..,P&TWGD?[+)^&YBA>/V>P4N?4WgPa)VY]bSMUFLWU@^I@V,H8
2GGCM76M2MCY,3W81)H5M\Rg\8C)V]G.:;4VcSQ]<?2JVMd&YfP9.@<=VgPd=&WJ
C:O-.+CU/geAe;J=+]//AFb/(]D;SH0-7&-:VKAQ1)^X^L/f[/[^JG\6LccF<geL
8PG4?S800^TVJ:.KGRV?VBEYI7T>(MQdC+Df<QMLW@9T,+,?=_Y2dO:UR><24c?d
@[LD@\Lf-.:+0(AL(,0TYZ9f5K;XC\=gO512fKb+C#c.VFbZ[7\GV)1?]=MX&2IK
4\R^3Y[F4_<.bR\EMPH;]=:<?]1-YaggIfR9.SJeN^R)[>D<][I]DNIO[>S16#b]
_]04@F[4(=7DWH10./P>^d^O+HRQ+86Ce6UNVb-P&4J[RWJ)\C_G7.QMX+E9.fPM
UD\@RT5?I+a]cbON,T-[eQ;g)YOb@&K4#D99K@aVXY5@I@gbO/+OC7be@:[fIT48
aTbF^#b(E^FL/--bdV:B4N7a;^2_Ncdg-?/Le/dFA3AUF?F.:PO439H((PD&?9BH
LLOGa6D]S^L.2]9G9F:&M[GMaQ;T([Z16M?F[UNAB>-EXJf6DJ_FdMfd+>2BdL6^
?d9I)SJBfSFI@8>>440Yf9KG.eC[&HCV/=23d][f7KO94M&dDgA;KH-0cT>XL=\L
&aDOa9AdZ3WFK@?2LYWVE[b^C>ZD^b]?XM&]I71M,e2I\P(L\5:+#RD6af:.R2&P
5_TYAEJ[^Ce4MfUM3^L30M\@cDab/JgdV?\GIfL9S)TBF<Kf:&-a_7SaYQVSJ.Se
Ka=#?Y>9;YBT(=HY;03XT&9Y6g@#>GD1Jc-<X)>EU@EN@DTbHC3:>PBBPT9DV@dO
eQS.(+d,-(ZX5b#\V\LM(6&H.d^gI2@2@D;cfSb[[bY(-1-ega#c_II-V9,XE@>c
JZY>=)DQ=gZIW4;5^?<B?0aeBgfaX>7KR68MA-.@8R\K]dcQ-(K#QS6MA0KeR6B>
_cG3b13&OYgg9Jf6JIZJ,+G&#B_b,FUd5HT4_EFfaP?.cf^SD84aT9HJY)c3NTDT
U]?_O3@>0[<&HNWUKHeM,+8;[<AHE+7MEUOPbGY)]I43SK5UY)7Pb.Q.P,L,S,,-
JX\VAV@HYg<ZQY;)BN#B,gARd?#4C6V]c#Ve..C5#H4SYI/:Q<a-A/ad\S?>@.5H
ZA^W8KCP1&b0Q1DVY9WDag[&9)#9ZegM,gV<2d.=BJ@[K-fW1T8X.I^:f5RLdL[A
R@3g&]9&<QJ.=_._C[@B1FZGg8PG/N53\)@238-HgOU9(J;4S]NNT3A^<),/8.JF
XC3&cPDfA1KMWBHV]XTXU=&W5I@GHQ>NCg<@;+X_KG[D:^A_,/D-F95YY].MS7=6
I^;Ib1CXJG#J>2EJA=eU<eWWaV[LXEU1ZK1M?a-@??;\_H_Be[>6Q;]FAK)AI7H=
eN/UT,GQ]F9/7_cW+<F/eAY5[RSa@.0a>F]H+gG30L\WZ.(V+4L8JJO(2c>KO-6,
-LZ:Y]J;E(5HOd]\9R:P+MBVO?c-BM[f3#.(.#@0S(Qe)8<&E70U)9ILM2.e;K?^
d>+HSeC=:)[Q[>efRL]dMIU8)L,([>CCM=4D/&MZ5?@#:WD[]IPZLN\F-5UIY(82
>B(Z8YQ&(:/SU:;L@6-G+YNWK[N4EIg4]@_:^0XG72K/a#Q<(9<aMA.eS@e<DR41
._U55H:[b--IQ6O>gQ(Q1d3RN)(F_9aM3&;5:(_^-BL0C+#JeYJ2L(bIE+08HQLa
03UB[/6B;DYbW73B0>YHH)Nf.L+ON=R5Yf?.(Y@1/VMW8e6VY9>2=dc@9#36X<AZ
=f2)O+<X8^WVGA1ZL21;KbFZ)KP-)5KHHCRWQ#L+Z[6PRX\LAJY.5SQW/>N5UI^/
4YZ00CM00\f\U)^3+9B9^A)1@.AT=Q@N.(/1cgf>&Ug:5;a.+B3X.b,WAIL6EM5W
9gXRX/6-HJ=.F20T1gIH+U9ZWG^NS2E34fE&>J,<-#Q9b8M54O2.B-<c@X?]K.?;
&_b][V_WaOZe]@\2UOW>=D,3H[M5S=MCJ61gP^^J)TdZP649U:HbI1)NO#.MHe,O
/:^BRLJZPNVK;T2MGC8L5.bc:U8_@bOf#@&AOA7fRP5;IZHCdPEdZTG@EK-O06;Q
TZ-gKEZ3U;@2a=e97^dcgJ_5/f9b2C6L.-)aYg6<c7JgQNR##0MB&_I(.I;cIB<W
Z>;(5]T_(J62<DM\>c:81>ga;VHbD0;]g=HWcXI.V\A4ae:XL57VbbLNZ]#M11F(
#8X2ZWaUG:7N;\ZOF^DeA&e5D,R]]agD1;;O46_=I#UeEYgJJA;JG5BM(e9Z6bFd
M=]JR+[&79#9bJ/X.QTII>-:EPO(^8fH2Y62?Yf=A,V,W=2T=M/X]-CKY_f?LY=J
S[NNL#a3I44BO&72cHMIfZ\AW-9B49\2Q&=1,d[B:K@KM<ECK,I&86>T69IVA,J)
B3S6&UMRb7ZEC)SZ-DAgM+P,J>RXCZ4Y17T]0dTVcGa@S;e60Db?<)/aZgO>F:1;
?-+E(HSL7Fd@982XM:6;<IV:GLV[C[LI8K[B_d^ZPQD)Y8OSR;f.2T_HSg-U\5:.
A:_Ie9@W)HD,GG6<-X[N2d[-Ne#[ID#K@3O+CCB\MdG<751D)bZ;7G9BX1OLY#,X
VZ;9^,-4G><?VLNVI7L?)821V9G=,406RFI7PeJ?I@;X(X=@c-YWDNN-WdK<JERd
)S;[<2>VXV11<K?@dJ?OD5bPAV4CPHZKB]?XA+IXa/&83VNgW/1dAQe^Nbd/^EN(
OO34.=]D>a55c7^If@6g=0ce3Ee2NC@K^.H7NfJ2^B7W-PLgb-#RNFdFMU29N3EP
=35=3X6DUg5.Ybb;3-Pe@SGWa<B#1P9P>W2JNXRKg)R)aBN]AQR9Wb;+/8W;?WaB
@,JL]A]Adg4)b3X))(U=^E=VU=RU6PJC8@#+G,<E#IGJGJ+-HN]cbQ+5ECR.RVd4
K)R.H4I:VD]M4,WKfUYNN_NJY6[08S0ZY\(aPBL[Qc[-_,]60HJd2JdF^DP^57Y2
\&a4TQNB/d5LNM;LR]47Z5-,e&;1UU\__&XL>(DXPZC\F4V[2UW/T8D@GAIBJf)?
E-,6/HM_]+,=GF+4X_N#<=1:<=@E=GJA1L6gY9D_V+^E+KG\@F(<dSM:?H6-P7KJ
97KE]T,I8=#Q8U9>6WVBd3X3COSQSHc(QFeR)XT/&IVFD=4+d<,>/FL>_VIZ9FDH
M2KO_3#]e13E:feS((GcXMUR1^dTHdACWRb;5Zg48bY&SEMaVQ/DY^9XX2TaeaU#
XY=O[ZO\2Z/T>J&W4?@3&T&@a-RHR36G-,QaU_Ngg:E[TAHHUdV+dNf(PgQ#)dbG
a]^W#[/HR-G^#W5Nd>2RTE1fM+/\4,[2M0XV/FWNOa.[=>>e\PF+fG(.L>bS.//;
G_1#J4IS]9^fa[,ge]61NNYW#OLX3X?0T5K#NdWafT>T^]J=F?EbH=4N/+G79SPG
cVJ8YRCM:/9>,FH&H(7./\\Mab_,.0/C&-FOS5PDR9O8Qg^>aDd6Ue1]W7G_>6^:
+#U=gX:a&83&b]eUAg[S5N)C95R)E2U2&2^HHIC2K/@K<D^460V_^BO&,)<?WbaA
+c:-bYQ4.6](23094>>c?V\V?E;f4OaUK;EG#+Y3:g5\3QBJ+X_=8:b>G\^#,>(K
ae5=XS^gUBJ6.@X1(9WYS);<B#.Q=BONd+N>=5R?TfB=,&CG/-C]^d=b0I/#@He5
:aRS5KAFAc0#</S579-2I[e0V0=4^F?FTI;gX8J_#e>cB,<4=UZPP^^N&#+4VR>f
c&-&-D2>&-aT(6.dH]M,KGg90Z2UB<c2=1QFR@L9>4JA@<4GU=G6GY4[e/GFgcF)
)[Fd&1E@-Z7Wb&ZI+DYBcgcP(aHBOc@g<[20Z<VLe]Z)WM=:ff75(^(N.YNDV,6H
#H9>Cg_U:.FME=DdY[5SdA#Cbf,KU[//\>VQ)R:_OT\#e4R?[KeX4gJ-53\CHN#^
?-X#1?[>NH#f.5=&F[3OQ_PMW<LOD#_GWF3A?G>dBe[A-_ZOPS\0d457@);CZRWZ
Ce58Jcg\S_PN>N6_U)1W^MG[Fa4+e-SMJ57dCO;&MgH6]SAfHaYZZULRI.5]-Y\;
\6M_MeV7aQ.BBC/H[HdALaDaE2aJ:WE5-0[IBc26NJR+>@M,@M/MH[BT)G5<c>=Q
[0SH@eX:04NaY6e+\82.TY[c]HN,]8/Qf4(;d^&K0De4I+b;L9-CcdM9-b#N<.^g
?g[.G>;R#AO(F9.VC67>RKDKRQf/VR,9b4F4ScT.d[,:E6.5e;0PJQA&A6Y&/Q<J
-NSYD6[8?.UJ6]Rd7aZA9SdW@;DXVVJA>K]LfQ2]R,7Z7-bS85EEHf1cgDg7S6Z.
Eb0([gGIM=73TK-0a0&&DJXP/)5a@#NH0?fF^E^.XJ4C/a99bPVfgBgd(.+]bYa9
4MC4RMN5V1DBQYXaNUP5JW)g&WSPTN\ZgW>1bVV5,MBZGPJ0e3_=Zd#bRG0Y8?+d
b];+8&>IPW<3]#?6&UQDUd7<)g.IgM,J?P,^3?XSUH0+E-EW<K;[@5;B]9Vgeg0P
BVa>2e?S;5bfT4X:Od]:+.@HPG:[/LPZ<\(=VI^#5R^Ya/=8VRHL\.H8ea;(8Da.
BG:@S6H353C.IHcOP\bB03DK(AG&J+.09]?-3@JVY?f-M@g<<8d1I8gAKBR=b6U(
&/]>F@>B&4>[?O)]2g2+.<;3NX595_4#aX/ZNK(,dI/gG=H74/34JL9Z;3(X#2Fe
59:Ub\GY8Rca>c;(E]NI<-NJRb3?LH]5BN[,^-+_Z>IJJP0dRfZQE,1J2.VPdX9c
+WJY6#=I^L&1E+6g81@Y@BWZEYgc@6V;18J>W+H^-7LU.(9?&>@6M5b^FC1e7-?C
=N4>?4PUe,9,;T9R;S)[<bKT6I\1#b28c=5bAG<BN4@<)/0eg=ICcb&62KVb\(-O
Z_aK2K_-5S;(+8Q<A@.IH9gK4QD(_@)>K^?,(5S/?;XC5EY>9Z;J)RYD1b8VSd5;
S,7IK.VT?C1K-KIK_99;RMG(==@8g4=eF+1LEX;@4)d7T08)5;c:>Z=_c+I\_R7U
d\3#,^W..gDEE[JBSLeV]J4?X?+D^dGXb#EI14]IVD2SXY7>&5K8^]6L)BAQ/3:Z
[KBDd7R]G2QV0Z9A=OK3TW^O&a]1=fZ>Q#AYbf1aeIC0XR_?Z20XVE1.D_CU:&D[
ea;MYXW7>WVg(Q500b:-T;>1I\P+N:15/Xf<c8/170WcLH:]=Qb+[3Ta;JaAKeO1
+LEA=61,S8\X+N[[LAFH+6;?d3?>?A\T:AMM=R76^,WGZ0(/dNQ>;><@,F=7R?YK
8e@^@N4@DfZ/I[BZfe&X[fP&FI#T.4<Qf:d2We+<gFD=?FU2@V\W-NM=.Jf?MACe
I1892WL^RBFQ(gg0.^E>GfVN_=KON3DF4b<K69X+O:/?HV=Xg]:L(WVC@c#N_#CR
If;V2PPR+(b,&J\:2<54B?I,++5+d&;4P\B<UGY+[01,a)KY_#V>PSQY814+J6?^
>d26@(=J@/Z9(Z)HE2<#&QYSOTFE.2477d5_FSdNAEN;>M5TBND=&WFd._HB=FPb
]LB[fAK7fUP(G?-f58e0?IGY+5HO>T<;5IQ5L@(QT9WO^6P-:70J)7<81?G3:LY,
+5B&M29(>D\-90W@OF,^\A4ZcK8L>4HNG-X>C:a7MWYb+9=WAP@9HRa?bL0f[QYW
1\E>PUbcF7aH16)=f+YLQcd:@ef7FK2Z3VI-PWId8CILRL=G+W_K#d[4B2A>K-6]
R)gEM#AI-<KKXgMO)_cXG\)0:1>&;AWT?f/dR?4/gWF:S(bUT>8g.dQ/U<PN)N2@
;JBKC\E>MC50=1UR00^#^@)V4.5P34[ZeOO//dEPNaQ)#GBA[72ATeBcQG]0DK]b
BO=@eJY0dD).N[f_bfS-;O=E_?^&dgE<R_b:Z6dMS@ZDe55CdZMR5fOE,76&?8UM
<aUR3Ge[55Ha:U#&&Of_H>7f&JLKFT9AbRZO4=/B+W6b#X9AUR\B8:AG7WKL/&FV
0&_EcC[?WX61=K9A[-E#3<=6:]B9P[>=AR-R;XR(+GgdK]7cD=7BWZTIE(PB>)c5
F:Uc(1.XI6?Q5&,>[DKXLW#c0D_LC8@\^#9GW=[L.-S@d+?78-,+=)3c8Q;;A9Cf
W(/CI<I6fcEHFS3?#3f279I/P16?;G#?XW-P0fDF0]eN=[aZ=4ZQ1cR@f2LdFY&)
_Y3PTWbN5U792[4gB=H+6E;?V6ZKR+Ke)?7=JR@\_,L><W:IZ7XB5G7YL^Z3L9D5
Z5=G#H.-()]N\6YbD=E2QQaQdA4P;c;FUD#5N/975I#?1R2>#Zf.U7Nb6fG8WYFg
21aYN17#V9B2^Q;A=c6)^B9S\4,,<4#-7WC80&dPUP]9G8>RF&NEKTI#I80)__TH
8FXZ[fJc>>Z;2KLdFFA3A5)ZRXg/fS-@-:Qg(.M9/)#<Q5]g9)Tc>M0B4\egAZ8>
bWB?bH8=0T4+(&VBP6/)C6d9d/5X@@beI;07ReK^aeW&+Z)&SAM^26#C0+F]>H-4
C:3>V8LC7-04(J&S5I4XOXO97;Q&-=V-51BAD/81M5]^O#>\T:6TF3PJP_757E+B
L8<eK:Z?5A.>)MSP9AF-QD/>1C-PX7I.A_9;:.g)+d@6P@d=QN9@N?T^SWEQ\6^G
XD-?f<LLBgV4T?^RbKJ[]\?P6FIW8fOO^+V06VG>XJ9U_EAW7c,1B((Ee@eELP6@
X,2VCG=U0BWc4WKaY)=e^c5BBQY,.3RN9H3:adYe6+^?BPQe[Q[-XdeH^e\_&<c9
G#K4(H3b1Nc0_?RZadM=@)LSe9LWTH)IBH?PD_g6[[6OIP)XM2,5I75#<>J1(\dO
HFRWf309O\+=c?2,LO>C(L2N#eE\=0gE9<_A(W_LF>8IP3b._^8=?3PS,Ic7QIOX
G<#Z49V-I#S^+8O5M1PEUK55S]^>Q1;c+UHPKfAUTZ0>G@)TYB5?HNX_75ZV_&.J
H9dGB>bEYWIU(L\WWeAO)>SdCaWYdT3O5^Y8IQb_D-AZ+VEH+?F;_7@0VS#T.=P:
)_HJdCXC9/EE5-?[bV+N^BOR/6agSc/g\b8U(^(@bTb03U4dC#[<ENe&PTH2(D0L
.K8gK.7AZC4ILWGOR1b?9FB]?b5^Z4)ddNM,T_.d;1OZc<U,M=1S,_KT3TE?NUa#
:fg#U1PdT;GIeWD=RF4IDIGL=-2.-LebKJ?SAF]X>AJ69JDC&Y4ZI5<a@;4T)-4N
;1\V48(PA:1_4b-&?g\172PS_;S=4b/g1>Qgf_IBWc0/\L63^fJW4Odf,J2.CB[I
8UB/KG?eb[ZJO;77NI>eIZZ[eS?Be](>V@EC^^J\3,WeF^3=:KO7_(_)gEEDDGF9
UR2E1bEN0e(MV.?W;2QR]DXS0/-=3S]AN>6&+>LcH-U<V&_QCR?L.98_JaUb<EfE
GP:7RL/N5\5NSE1:dSNS8e@gRQBL>QF2TfGaD-U^6UeZ=>;Tc0NcbG#PfBb]&a^F
Cd;?-=ALSQ,8cOM[^;9c5dSaH@8cY(WKIe8UXY]U6KS>=#E^#E=&S3FFWMY(VFAF
PTKP\Wf>gVI#]9ROcA0M@CVXc[&UMcd281g0gD.\:1-:H42(RS/^Q:dEE&2,e=-^
M,\8YRO+FC.<ccWE??-_-#G>AdA@DFe8]OaU^TP)I^0I#0^14).a1D5?VP.W:4Zf
57\-SR2&8<UH7a-/KQEf[CMJI^VU-P-/A+78Z#:[1ZEIF$
`endprotected


`endif // GUARD_SVT_DEBUG_OPTS_CARRIER_SV
