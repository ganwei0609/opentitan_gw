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

`ifndef GUARD_SVT_CONFIGURATION_SV
`define GUARD_SVT_CONFIGURATION_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_data_util)

// =============================================================================
/**
 * Base class for all SVT model configuration data descriptor objects. As functionality
 * commonly needed for configuration of SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_configuration extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Used to define the Instance Name of a component to whose constructor this
   * configuration object is passed. Since all SVT VIP components require that a
   * valid configuration object (derived from this class) be passed to their
   * constructor, this value is passed to the call to that constructor's call to
   * <i>super.new()</i> (i.e. as the <b>inst</b> argument to vmm_xactor::new()).<br>
   * Similarly, the <b>stream_id</b> property (which is inherited from vmm_data)
   * of a derived config object is used as the <b>stream_id</b> argument of
   * vmm_xactor::new(), to define the Stream ID of the component being created.
   *
   * <b>Note:</b> After a configuration object (derived from this class) is used to
   * constuct a new SVT component, the values of the <b>inst</b> and <b>stream_id</b>
   * properties must not be changed in the configuration object in use by that component.
   * 
   * @verification_attr
   */
  string inst = `SVT_UNSET_INST_NAME;
`else
  /**
   * Used to in some situations to define the Instance Name of a component
   * prior to its construction. Mainly used in situations where the creating
   * component is creating multiple sub-components where those sub-components
   * do not have obvious names. E.g., an env creating multiple masters could 
   * name them master[0], master[1], etc. But the user may want to name them
   * CPU, CTRLR, etc. Some components therefore use this to support a
   * mechanism for overriding the default names (e.g., master[0], etc.) with
   * more useful testbench provided names (e.g., CPU, etc.).
   * 
   * @verification_attr
   */
  string inst = `SVT_UNSET_INST_NAME;
`endif
  
/** @cond PRIVATE */
  /**
   * Used by all svt_configuration derived 'copy' and 'compare' methods to determine
   * whether contained configuration objects are not copied or compared (NULL), the
   * reference is copied and compared (SHALLOW), or whether the object is copied and
   * compared (DEEP).
   * Since not owned by an individual instance, not copied, compared, etc.,
   * like other svt_transaction properties.
   * 
   * @verification_attr
   */
  static recursive_op_enum contained_cfg_opts = DEEP;
/** @endcond */

/** @cond PRIVATE */
  /**
   * The VIP components provide support for the development of testbenches
   * independent of the availability of the DUT. This is enabled via the
   * 'No DUT' options available on the component. When used, these options
   * result in the random recognition of non-existent input bus traffic. This
   * in turn results in the random completion of transactions initiated by the
   * component, as well as the arrival of random transactions initiated via the
   * bus.
   *
   * The input bus traffic includes randomized values as well as randomized
   * drive and hold delays to demonstrate random legal bus traffic.
   *
   * (Default = 0) When 1, enables the 'No DUT' option to have the component
   * randomly recognize non-existent input bus traffic.
   *
   * This feature can be set directly or via the command line, using the
   * 'no_dut' plusarg (e.g., '+no_dut=1').
   * 
   * @verification_attr
   */
  bit no_dut = 0;

  /**
   * (Default = 100) When the 'No DUT' option is enabled (no_dut == 1), and the
   * component supports transactions arriving via the bus (i.e., as opposed to
   * via an input channel) this number is used to insure that the component
   * limits the number of transactions it auto-generates. If the component
   * can auto-generates multiple types of transactions (e.g., for different data
   * flows), this limit applies to each type of auto-generated transaction.
   *
   * This feature can be set directly or via the command line, using the
   * 'no_dut_xact_limit' plusarg (e.g., '+no_dut_xact_limit=200').
   * 
   * @verification_attr
   */
  int no_dut_xact_limit = 100;
/** @endcond */

  /**
   * (Default = 0) When 1 the model will enable callbacks associated with signal
   * changes (pre_*_drive_cb_exec and post_*_sample_cb_exec).
   *
   * This feature can be set directly or via the command line, using the
   * '+define' plusarg (e.g., '+define+SVT_<model>_ENABLE_SIGNAL_CB').
   * 
   * @verification_attr
   */
  bit enable_signal_callbacks = 0;

/** @cond PRIVATE */
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Used by all svt_sequencer instances to decide if they should report 'Dropping
   * response...sequence not found' messages for exited sequences. Disabled by default.
   * 
   * @verification_attr
   */
  static bit enable_dropping_response_message = 0;
`endif
/** @endcond */

/** @cond PRIVATE */
  /**
   * Field which reflects whether PA features are to be auto-enabled. This field, along
   * with the #pa_format_type field, is set based on processing the 'svt_enable_pa' plusarg.
   *
   * The initial value is '-1', indicating that the VIP has not checked for the plusarg.
   * Once the check has occurred, the value is set to either 0 (plusarg not found) or
   * 1 (plusarg found).
   *
   * @verification_attr
   */
  static int enable_pa = -1;

  /**
   * Field which reflects the output type to be used when the PA output is auto-enabled.
   *
   * This field, along with the #enable_pa field, is set based on processing the
   * 'svt_enable_pa' plusarg.
   *
   * This field is not initialized resulting in the default being the
   * svt_xml_writer::format_type_enum element which has a value of '0' will be. If the
   * svt_enable_pa plusarg is provided with no argument, this default will be used.
   *
   * The svt_enable_pa plusarg should only be provided with valid svt_xml_writer::format_type_enum
   * values (e.g., '+svt_enable_pa=FSDB'). If an invalid value is provided then the
   * default value is retained.
   * 
   * @verification_attr
   */
  static svt_xml_writer::format_type_enum enable_pa_format_type;

  /**
   * Field which reflects whether coverage features are to be auto-enabled. This field
   * is set based on processing the 'svt_enable_cov' plusarg.
   *
   * The initial value is '-1', indicating that the VIP has not checked for the plusarg.
   * Once the check has occurred, the value is set to either 0 (plusarg not found) or
   * 1 (plusarg found).
   *
   * @verification_attr
   */
  static int enable_cov = -1;
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_configuration)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_configuration class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log=null, string suite_name="");
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_configuration class.
   *
   * @param name Instance name of this object.
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name="svt_configuration_inst", string suite_name="");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_configuration)
  `svt_data_member_end(svt_configuration)

  //----------------------------------------------------------------------------
  /* Method to turn static config param randomization on/off as a block.
   * This method is <b>not implemented</b> in this virtual class.
   */
  extern virtual function int static_rand_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the static data members of the object.
   */
  extern virtual function void copy_static_data (`SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ****************************************************************************
  // UVM/OVM/VMM Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy via copy_static_data/copy_dynamic_data */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation based on the
   * requested byte_size kind.
   *
   * @param kind This int indicates the type of byte_size being requested.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  // ---------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested.
   */
  extern virtual function int unsigned do_byte_pack(ref logic[7:0] bytes[],
                                                    input int unsigned offset = 0,
                                                    input int kind   = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Unpacks len bytes of the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[],
                                                      input int unsigned    offset = 0,
                                                      input int             len    = -1,
                                                      input int             kind   = -1);
`else
  //----------------------------------------------------------------------------
  /**
   * Pack the fields in the configuration base class.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the fields in the configuration base class.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Provide string values for contained_cfg_opts.
   * 
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates the same pattern as allocate_pattern(), minus the
   * elements which include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   *
   * @return An svt_pattern instance containing entries for the data fields which
   * do not include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   */
  extern virtual function svt_pattern allocate_static_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates the same pattern as allocate_pattern(), minus the
   * elements which do not include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   *
   * @return An svt_pattern instance containing entries for the data fields which
   * include the `SVT_DATA_UTIL_DYNAMIC_KEYWORD keyword.
   */
  extern virtual function svt_pattern allocate_dynamic_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method scans the sub-object hierarchy looking for sub-configurations.
   * It returns an associative array of the objects, indexed by the paths to the
   * sub-objects.
   * 
   * @param sub_cfgs An svt_configuration associative array with entries for all
   * of the svt_configration sub-objects, indexed by the sub-object field names.
   */
  extern virtual function void find_sub_configurations(ref svt_configuration sub_cfgs[string]);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to debug.
   * 
   * Regular expressions are used to identify debug features that will be enabled.
   * If these expressions identify properties that should not be enabled for debug,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to debug
   */
  extern virtual function svt_pattern allocate_debug_feature_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and enables debug options.
   * 
   * This method should be called by the top level component in extended suites,
   * immediately after the configuration is received for the first time.  It is also
   * called automatically when the reconfigure method is called.
   * 
   * @param inst Instance name of the component that is enabled for debug
   * @param path Optional argument to provide the hierarchical path to this object
   */
  extern function void enable_debug_options(string inst, string path = "");

  // ---------------------------------------------------------------------------
  /**
   * This method sets up the fields indicating whether PA support should be enabled automatically.
   */
  extern virtual function void setup_pa_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * This method sets up the field indicating whether coverage support should be enabled automatically.
   */
  extern virtual function void setup_cov_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to PA.
   * 
   * Regular expressions are used to identify PA features that will be enabled.
   * If these expressions identify properties that should not be enabled for PA,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to PA.
   */
  extern virtual function svt_pattern allocate_pa_feature_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to enabling coverage.
   * 
   * Regular expressions are used to identify coverage which will be enabled.
   * If these expressions identify properties that should not be enabled for coverage,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to enabling coverage.
   */
  extern virtual function svt_pattern allocate_cov_enable_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and automatically enables PA options
   * if #enable_pa set to '1' based on the svt_enable_pa plusarg.
   * 
   * This method is called automatically when the reconfigure or enable_debug_opts method
   * is called on any of the top level components.
   
   */
  extern function void enable_pa_options(bit enable_debug_opts = 0);

  // ---------------------------------------------------------------------------
  /**
   * Parses the configuration object using patterns and automatically enables coverage
   * if #enable_cov set to '1' based on the svt_enable_cov plusarg.
   * 
   * This method is called automatically when the reconfigure method is called on any of
   * the top level components.
   */
  extern function void enable_cov_options();

  // ---------------------------------------------------------------------------
  /**
   * Checks the PA related flags 'enable_xml_gen' and returns '1'
   * if any of the 'enable_.*xml_gen' is set.
   * 
   * Clients can override this function if requeried to be.
   */
  extern virtual function bit is_pa_enabled();

  // -----------------------------------------------------------------------------
  /**
   * Record the configuration information inside FSDB if writer is available, if the writer
   * is not available at this time then register the data, when the writer is created the
   * data can be written out into FSDB.
   *
   * @param inst_name Instance name of the component that is enabled for debug
   */
  extern function void record_cfg_info(string inst_name);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the suite. This is
   * checked against `SVT_XVM_UC(MAX_PACKER_BYTES) when the configuration class is
   * constructed to make sure the provied value is sufficient for the extended suite.
   *
   * The default implementation just returns `SVT_XVM_UC(MAX_PACKER_BYTES) value.
   * Individual suites extend this method to indicate any specific requirements they
   * may have.
   * 
   * Note:
   * This method should only be implemented by suites that require packing/unpacking
   * operations for normal operation, and if the default size defined in the UVM/OVM
   * base class library is not sufficient.  In this situation the VIP developer knows
   * that the user must provide a larger value on the command line through the use of of
   * the `SVT_XVM_UC(MAX_PACKER_BYTES) macro, and so this check should be performed in
   * the constructor of the configuration object.
   * 
   * Not all suites require packing/unpacking operations for normal operation.  If a VIP
   * developer determines that packing/unpacking is not required for normal operation of
   * the VIP then this method should not be implemented (and the check should not be
   * performed).  However, if a larger value for `SVT_XVM_UC(MAX_PACKER_BYTES) is
   * required to complete pack/unpack operations for specific transactions then these
   * operations will fail if the user attempts this.  In this situation the VIP developer
   * should determine what minimum `SVT_XVM_UC(MAX_PACKER_BYTES) is required and should
   * implement the get_packer_max_bytes_required() method in the extended transaction
   * class instead.  This will cause the check to only be performed if the user attempts
   * to pack or unpack the transaction class, and so the user will only need to provide
   * `SVT_XVM_UC(MAX_PACKER_BYTES) value on the command line if they need to perform the
   * pack/unpack operations.
   */
  extern virtual function int get_packer_max_bytes_required();

  // -----------------------------------------------------------------------------
  /**
   * This method checks the packer max bytes value required by the suite. This
   * involves checking the value provided by get_packer_max_bytes_required() against
   * `SVT_XVM_UC(MAX_PACKER_BYTES). It also includes checking `SVT_XVM_UC(MAX_PACKER_BYTES)
   * against the `SVT_XVM(pack_bitstream_t) size to make sure that the define
   * is consistent with the buffer storage which has been allocated.
   * 
   * If the user is using multi-step compilation and has failed to specify
   * `SVT_XVM_UC(PACKER_MAX_BYTES) on the command line then it can lead to a
   * compile time failure about an unrecognized macro. This method isprovided
   * in unencrypted form to simplify the recognition of this situation. This
   * situation can be resolved by adding an appropriate `SVT_XVM_UC(MAX_PACKER_BYTES)
   * value on the appropriate command line.
   */
  extern function void check_packer_max_bytes();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
HI#PM[H1b9H>9[g]V^X^bONGRceR6JWI&9V#:^B(BT73-0>_D;d@5(:NaT1>5KWd
D3O@[@Z&S^A)VJ_EQDUYVcZ^62LJ+5J1\cVY[JRX9<<F8N2]I4P9&_e:gI7A#\Ng
I4X=([.AcD\B\e,PF8(;TcWUXZfa8891P2UB1,_Ugc5JOKIK8BI-;[R:R.70[LG(
S_,b6PPM7c;M]^S.<C/)58WQ5&H#d@AA(_4;]N;,O+f0G9&((a8,&0A>>[E)[,:d
;45+WUSKb55b0C131b//6/GWdKQ8M-]2K:<0?>..^4E_1Ge@W\2M4<IM=?Zg^L+S
(;_MI5##9<J]95C7?I.=fbUgH,XGIKOT]fg4@SR76/H?7Wa0@f22-&17eQ2;ec2C
JO]-YQMf<W3E33W^+\Jf^JK?/A+<X5<e2Jf1#4R]00DE18B(aK#@WDPc.D1cH(a,
].Af4bPN7>9&c=F]g?I79]P?T)We;X((:c42)8;<1#8F=>P/PO(ALQ9db<efT9G;
(_FLE76<\ZT7Kg-COPO+Q#H&-8Ea[3@/fMLA7=7HFb6g3Q,@,fVA6;J9aK5IY;OS
GAB[aN;F3d@OL;=-P_^XddW3OVgA99[ZL2N1,&4Z==H2C.ee-NJIVFKHc87e_4Cd
4::E[/.cB/EVEg\1@9GWIQ4>8eb-:W7=1KD-cDN&U>UgLe>Q,UcL5+cAA7TJ;,XL
?ee8@#/]8MFQcUQD,/50#,DXA-10/MFf4XF<\&,S.=AW_44/Ac_AV\>C76c:5aA0
?49;I2X@G&e7/aY&\_N?:(geS,A<>;<b:BY-6#FNB89^Ef9,3.aVO-cCR6?d6J#Z
MDHXRdLN?S^(=[^(6VY(?&)79N276LVaEKN+Kc#+_O8IS([UGWJ]//=bE;4U3(I_
ARFc<=YcZ0\P=3-#9fge:9_@\?eC7+cO2^+>=5?\D1(0V-5D(a0e6R0+bD/43O?T
W>64(-:=4>:@_QHbB9S=JEAg/78F:5^];4gAT5<4/JJfeD7=>,>:PRO1^0);&9=W
?DU1SM^.c1G7FW7Nd,H+3T7?]T2g:[\5K,g):A-(a7g(@RZ<;X;BXfY[_,U=f^(>
3;BfI=e8-[LK7f:>9&/c^KcdeZMQA[g)fI[+-aOG_E9>/=EW@<V#/P9JA+bPR5#a
JZ=.X#aAS>[]bWe/JI#DNT/AT??:Y7a4a6@&RHO]U7\@.&1](&NT=;]6-7U7W8Wc
(95OK)W@>ADM#FM1H&e+=ELaSKD/]+UUZ:7R-?TIK85/Be1T)C240W46MY1=GW&=
[&b4cc.O-<+H4DeFb\AB[21J0b7;&<Gb=V9b+E.BbK^gJAB,IN6V6QE(8HO<R]Ma
X6X=,\L4e+#E)D_D9g/(AAc0S9L/Q?E11?ddRT@EBGV^Q#Yea21@P&KYYVO-5GNG
B^->@DUWJg\9CO(1M1RB3gOM_,M(c_7d8Ka(Q5D>/XL+D5UeYOK1e,ZI<VRb=LPA
K)A<IYeTI@<AAa/U/C=EI>V=&b2,K,f:G+5a>2LI/NcW+:DEF+RU;;ZA.&2;/5R9
W23=TRaFW^^8ac>aYSP(A@\-&7E&BJ5A9A&0.=@O#[3(+_&3+E?c)Ib<+_M5Ke_U
=_bK;Y.a@9L4RJ7^/GV(:D)N?4--_(c5[g8PT\5=];:5DIXVJdE6^?HfNJ;=.<Xc
[JVHf:g+Igg]WVEXKCOb@[2dMHQ:P/_dG;[;NQ?NF\b<46?@50O,Xe&?ISZg\9E&
18T52NQKYK=#8(L_,\Dga9;.,Gg_#-g^Qc^8VB4_J74/U,9K0RQR<f/6D,;@d.+=
V=9;VB;#EfO-1TOMR#\d_N9;?TQS]FU,33E\M1S)=N,:Y?CNC)D9LQ9R^7VD\P7A
IgG8VKOCDa:0/3QOHd@P87R>dWQG,=H>#RUFI00S]B7_/+,QbW:U(HfL-<UG:3XP
71-GKINQ8E,8>VNf1V_E#_2IB@T+8cM?J-A29R<5D)@P(U,EL4(-9H8^AZ;.UXd[
VK&YeK656A+-BeL:R_3F5\\fWd(8?S6MKGN980Hd4SB@6J9DNHI-68DEH8+CBP+.
IQKP1JgNBgEG1YU?09L@3G.Q+)]U-7aO_P6DSI?NXRTT[e=[Y\V6E<LHP.RLG)@e
ZgR#AgFW/#?^g8I8bEJ+9?>\g[38f]^M2&P&,OHN=:#-f#?/NeC_8Oe=fbSe7YQ+
VO\P/ZU^=dKN:LAFI3P[9EdQKMJeJ2+UYT>=FF]RJHN9B2EKS/D;(BQe,_?V-W=#
SDgF^,E7;SSbIQR]_W&f(K7W8H=ag0IJ\V(/\f4/B<U9C$
`endprotected


//vcs_vip_protect
`protected
-M[9ddX.g6G>_,<X^+(@_cB4#NdTK5\f8ZH/=0+^]+3R5/3e@I1J2(fGaR&FN+f#
edQ:4S&aGX=Y]fNR@E\=>QV<[fD+I2aOZf2Pg4D[<C?YD-J/]/XU]=b7+8cD@[[-
(.37-BNORZPGY5VQ:E[/d^fR@_eWdgL?,cU5J6(<3VgMXQ))0<L0.9Q<DULE-X)=
P4.C<P+WcE9<@+\[aEZFX2ECL.6D7_EY9AS;agI=J065B^>E])_dS:[GI3?SO5G[
LFBc93.N,VC55UJ==PMD]SZ@N2FR>D=#4_T8_ag9AT2deW8@DK6-gUB4XD#G)H,:
(S@6_<]RafSDNUDYYaIf[_+c+0/:Ud6LRPWEU(^</^6\WK\TdgA58(\AHU-aZ8bc
Gf<<EZ##dSc@_A6]=I78J2,CEY)HAaI2_S9LA)P;c3+SDcdK?IG9SJ314]7SFGYd
MV,1R+1g_T15[F@_0L?Fc;R=5.,,_H>eGH8R9#Ff1HPE@@Z#]d&\O.6JIWA:>HER
82)FW]c3fdG+?6-;J<AZF4eXLISS7AU-1;G5VM7-)WQ;NP1LG0[aRe)0<Y9dbf[C
KeN3@fXa[PfPKUgKFN\=[AY+UWT+KecaNKWG=1G]Z7aTL@B+J@S87FCac\d.>.-O
ONR#daaP;N2T;\/J@NEL2C#//6<:8CbgIK]WM-KX5bWeALXFV9e\3,;>;C5g^/U(
0N9AA-+2.^O(+6?XI3EV[7OE[V1DN7PO(ec^CY^.Y3GNT)b]V0f]A8:_.Fa(FMKP
CV:3]2P=eY8SgXJJ:5-W/GSEa1;P>ADg<@bD,Ze5T)f7CGFU,8CfM;+a5O=^MGXW
c?C(-8R<Uc7\XH\9:746HEX4YALNC<d]0a>D:fP1BY1.K13HFC1+eITFBgR1G;4,
FGC;:OR0E+31@@./Hb:328PD;6B8e5YLgCd&fE5>8\<^1JRUcW0^bf37QbW[V>dK
](=:>b?W/\F.1T8SaK#BNJ@28&O8X^5_HI=F8a^7&J]0)IYE1cddTXeMD?Z-1S=3
J>9fOg\)IFG6F[/Z=O75?5CK8\bV@0;b-F2C1F8Nb_(=7.d+KM1.XeVKS2a,UG8V
T05=RPC].gV8=S8G[f4<2RId&2KU,&-dS[8<^/@EQ6WTdc\0R[PVg2-2fABd/#XM
ZYLLH#2,Hf[S@LH@:5DOIbY:V&W>=]MZ^3.=3/[c\e=;.KKHeI-IQGSG+]\P(c#Y
1@?+gMKP4)_?2;QC)NQMLQJ&3LBY#W0UbE>c2X2J/RN>-[AdBS]<V+C6B[B082RZ
GD(Hb?#JU>B&4RXUQ&2SM(e&<KfDLYT,]P>ZE/7P=Qbb<QQ@.BY>:97?W=e3T/9=
22<TU+BFI(0aL0Q;(NUWUGCI^O??\=#?0VJJfQ#/VI=.ERS>7<0?bNNHG+gP-.,d
^NJU61ggE:RJ0=Ya[,^2(Xd:#c\ZAT+e3cDG)@I=[(K5aA8)4@G+C<JGa\4.7NZL
0O]?0edS?:0RbWF-)039ZeM\=P^0V4SO;+6ZP;a_bUb<GYOd;Q09_7CY:1T_D9)Z
336O=[MQPG6A:A9IG(aQ7LJPG_XYR45?TW@=G]VQ\Z8KB5d-&a),S/QBXGX/PX5N
RTAOHH8e.#L,QgDH1EgQC/D>XB(]<6dL@V@>YK4fN6G.7+/g>bdSDR3@HMSdJ<50
X)(cXf<E2W?]I3\TOc0I-XQC:=XdA/:IAT[:>(aK7B7,SdLM-cD()POI_^?)(7@A
&EXRcC-L28:UT-<UA70TKY-I-J;A8F>Q19\@[=:WC&AbW<-:?/;8d5;gF=F,N^Z_
)2MWdX^eA8\dT=T\_U3egTV.G5Rd5PCM(1e^>V[fg.>Ha7Za119fOG9N7agc^+?c
H>@Q^]:dL)6NdEK4B[BXgOaQ_JCZ5^4b-O:ZL>+N4>UgM)_b+1I#^@TRaT8@(CJb
)TGbD2N4MMU0H.DVFgM\P2P7OJ5XR3aT_^Me(L5_VKXMd7Z/HMG4b7&@0LV4QWN6
LPc&R?M=b@GI(K7WbEXAQ:_[YL[):MRI(NeOP-6WEP>DcVJT2<O[63aDU]^T@GeE
.^75(>QL?9Y@/Y].G.[I7+\F&L^Hf,g@V0ALA,ZKM.\OU^Db_T_L,)dZ+./bIg@6
1VQL],/E@fZg<QTMV?0Mfd4=XdcO_7MNUR,H#c#aX,6XYRPUS7Y+074g=cG>?NB?
CG0&gF/[[525W0Q.@3(1.8]3>F&#3\ZN^+_egS;]#;)/9:W+^9EVAP8]?^C:7T9a
H#d4ZLD#15dLW>Hf,;O\bA:LN7IATAE2:7\>ag=MfFR&3c?I?+DDXH?X^+3TW_+;
GA=K9adMfV3cKN\4+[(dY^aPU<E_^LVN4,UY=FZ,^);>FAVfYUB0FAC/[9X?,.VE
E,a4,bLGcA9/?e1+9G:L51S;J_/UNDMO?O+991#C888@7)K1WM2HYgC3VOS]IgU@
Ta+JXWW=Nca1_)19?NHa,dG0fPB]g<_,fcSJ5<0CZ(0K;d-7_Y=E4:dcXECcJ5;4
)PeZ:d+DADJM.gYRJTPf]Z>MR<5GagB/E))_dE(cK[6=;YI3dNXCQ,T+#1]^LB+a
eP9Q;TLA7:g,V4gK1WU^)<+S9<XO=d7?SX8)UO\A;Ke@EO#QRd.]<GUU4fRg8XXR
=ARYSDQJeJXVT&J7L=Zg54U8K@F+-/7&4CZdIU[-X0CJ(H\=UOP^PJ<M]GS)SL?-
3]Q1RM9[-&a1b?#>OCRgSW3;99ZV@.]PgP>5?BCF_HQG+#@_/D9:g:U.0PgY)OF)
>e9-XH&_7-0]][2ObK;#=D8+^.46a.2UN(1MB<eJffS,(\/LAeb1LOAY?[;c?ZQ8
K&H&-F@QQIJ\^IEeHRZGV+5B8dZ^7\?L1Zd8ZSX0cM]TTQ)KP>I.&P355L^Sg440
43F9L&ad8C1b/PV?B/@O+QS[SCF?RPY()OO@_)KH5TTfZ5VG5+[6[+BK6V:N&;Ye
Q6R@7a+&^A^gV,AB/N+X=<4H\M@<9Na+#X5fV@-_Ic2Q7)^=V9J[G9eGY;6]<#4E
B+_X<_=NJ-FfS4J>GX9[2V[_MVF/E_F4WY6RU1/EPH[)b9QW#[.+Ee:cGZ4L;DDc
TH,P<f_&b5:I=()DJ^CIQ814ae\B&QaGIR_M?6N;a7MF8M)_\LZS/#VGXGG30b#f
IdIKf7YRU?^3NL&LX8A[#2&]/&gaJe1K<NTUI.I=>K,4PQIa8^)dF+aW_\3X4KZJ
O5,CKA0c&f#>g^_]].O)>FYKY[_(IZFFWaA;H4GaIFUOMTPPI^VKE(8I#Z#.f:==
.0J=9gMNaM1V2Md&0MS8d:M:cBKMQXA]gDBKfSFU>=NaOB\B?+,=&@L@IO0R/H_:
]dN&_CB-GGK52?FB]EI?UfB=ISU]XK)\4P&YWU0-W(e;[gOQWf+@&X151DMMX&AR
-<bb]&8K[fFC[cFI/HT1F\9SJ0@;G8gc:_PNaY,C;@0++/#9J2M;5:2A-2>KR?(.
^?a&fADWJN?=S=P).#D=SPdYM8\15SLI8Z8ReMe+_B-1=f<Y(ZF4]e&dXa:W2GI?
3^P=PVH]LdGbbYE?-Y<JaGO^7Fea.B5Yb&B47A,#1N;bF+\]8R]&Xf+#W>L.dbM6
[[>23Y2S6V1?YcXEd53-I/.94Q&MZdXdTL6b<3H3/M[O@@g.(G79GX+4gQ9N&6S)
4IY4L-HHbY8Z-f5Sb>@V/9&YY[PdS<g[]OVXZ?UHN-.[)e4f+HC06H#H1Z#YI\cG
68.b3B2U(ZaGZe+KBg)J_AS(.C6;Sd,D-]GdO/4X?)VS.I/0Y<e>>-<]-eIEGd<O
N]A7Mfa1?>C(+(K^bAGU,GA3QUX-Y8)_=\L.>C;U6M8_P2J;?Z]/2a?6RVOPV==N
7BTTMVO@>U,@>[123TBC11\dU;>I?Y)\]e[4X/NL[0A40,>A49KFN3\YNTe\QM-,
]TaQXgY(YPT7+]Y:9\V,Z6K+DO?W)WSV14\8]H8E8U4.S(PKVEUQZ\cd&XM\XBgZ
AdcY0JL7@8BBGN@RI3,W5;M(VM&&U5cM8@1J7B^5Jf.RZf7;U8#?0g1#8aK7M&A4
Wf+#2-X=YH,F;3,\\E(?SRBYR]U4T=W>DKIHUJ-)b2MUUO2<8EeWe.:.G5W[0-Q.
]VSU[/f#S]A^e?NFZ_]f4e:d7ISXHaLH[=ZO:^#Q?=f]e4\d7P6TEcW-2)^Y)Id;
WI+XcMV2(#<>;ad(c5OQeM>;T+_Y9SZd307Jb0@B3(R<H0.gU1\5UXME(&88DHaG
]+LWBJ6LW-2Ic7\;9@e/XQIfbNC)cUcO=R&R[C]I</NXY)d5I/#LbI^M.7^08F-X
9:AP2#a=X&UdNEN6LGQ\OO1.YR1<ffA2;JRE]dOI]L-_W?,[e/C=fZ0EII+da[,+
-ff,E6Fg<D0L(5L\a_^PR>K>SRZ-?c9V.bcU[AD)GV5,_QBB1#cDbW,>b8E=fIN;
g_=G<-;>0V20C8a2cgGB]ZdT]Kdc+6,VCW>F0<]-0Z:T9XeUO#c@V79N5(Qc>\K)
\e)HKXC<R>UEEXWc0ZGc_^V9P=<+/HRK038481BRDA8EEB>)fBV<&C1<UJ.G/)PY
TKK8Ca;F/2<U8CKd4B^3Tc]E2b&D&YNVTbYE=,]E02]<308G?KGM5=WV0.a.D<X7
/[]Hc#A,c;K@M9c+>YM5=[3F.^Q+&>F;80Ad,BA8LU,=eP1\C9L.?&F++,F6Y48Z
P#2Q5/Mab<TL[GBa(.a,g.5)U)d&B2Z#2E2ROV<H[\24W9IbN<Sa_5H-;<7=CM<4
P2,\:@/@0U@SfQ?YNK&;=MWLK5a>+/F-0gYOATCE_X^DAY>fgC6@LO3cI1[#M.HO
V(OfcTHe,f+#=bY>.@>c[7a_IQ3/#-:O=bcV8A7@?SQJJT3+b7>fK4bfCMBGKW\Y
bA&J>:#a1.&D-gS)>c3.F8-ad&FDW[#VCZ4(fbBTXFSY9[Z3]Y306c20C?H,7AII
gLe)f04_-T4WC0@Z(.7V(>[HdG[T]9eL\&(b-8N7[@0?>Wac74DZ=FE_&<Z@bK0O
Z,3eP(-Ud(fG7\\R]b,+eWA/73R4<eW?JXABHRNgG&N(-<<]LDXYVB:bd<97JW68
BTa0B,<LPB&T]IT.WdOFQHDJB.V7GT2[GXNe?D6(;VMH+^^]V2TB>J7SF<2beb>0
a6P&O0J\<7T<AQ@IeFe3](3RQc9Ue<TSRZ3X#\-[X_F\9XCT5e=-B=2g_UWJ0=L]
E.WZ[;0O,g(cVfV+AN,=B:R^>8:F2a&^<N/aZDd&I4Y1ST4:^U.VIVIA[C4?;WVF
7A47cW#;C?O16cgf2X9X8-DT@0<9@29+?@,RH8_.H/K[FEF2,>I8Y?VEH@D@P>-#
DB^UGE]@E_S>U/<9R\24d:.&N2?4UO^_HE<<G4,/e6GKX6MEY#<g8H=BB-ceBWVK
8d7YNfNE6:(K+gBXeJKaBF2a#CD;^g6X3_G1XDB7Oc;gd>GY/>VC(-^KD[;W(/Hg
C(g#bDE;eFK/0AX:?(@7J(b2SUAJOB11TMUJV=0_5ZX7E?B/-O6N#c#dO4LSNZ9J
7OfN;+(G#5QS3Y\?^XM9IPFg1:XD1#DECZO#9.V&C7@H/^1GgT&13dW-D0CeK.]X
cH[I_QKeg<:TBgUe6;L+#_#6fD0NWbC))UMV)SAAB[@fT#WQ^+#]fc9_GB-ScY\V
10I7B5XZf#a-8C,9>+eY=KLgBR@A,<FK/fP4;LGWS.Q]dZ3=976,SJ6W?fQUVg3>
,2J4,ZNCAZZCdbg=3;YfcL;RC&/_2-@-We.M\0Y=U-7&G-2EEN)1\X19Bc1XM+=)
<7V8D@#2FH4+9.BE&I/,.Icb/eY9A,8^SH=_06,=)=8M1^?+4/-Z<E7Cb1bCT^CK
3=\H&]36F&#_++g=eF8#UT00X_b3-Q/g,-eH1=.-0K.W,/8I:7T:N?2F,SNZN6GU
H>F>f^T&;3fLePL_61K58H[R&P6L(;8C_04U5ZJ;:BBKT).]_Y)[)2I69HaO.GJ@
Z>:7ZN>Dd->Y\a5N>@[fQ/65eTe\>2,B51C>Q50)a+a]-)HJ]aQ/KR^=b:P9RBIb
14L0[KDdfX8G6a:,5@/0K\[/8?L>L]Q)55T.KX05A/=36a@DI6OCCL#:UBg0\FU;
+EJAB0[:feb/BCEQX0F=c5-9O53U&7V2]PY+VLbDOUJ5.(8d7BM>KE<&9/J-9[(R
KR+.d4M7Y)c#NTV;6KA/&NS=\&&P3be+<)HY^#.c8#)3TU_3-6C7#[W.1+e^SP?_
VV9<BN#XF2UA/Nd(FM#Ee-,fB3\cH0/b-e#KI^T)8KQG;;4_&gVLXRM10^L@ZSb)
>^-?07dbKXaa5[LBP\bZ__Q7Eg/82IVO&6;=MP)6<d_S9L=DT?S3\[3T04,(B<O-
?_T>+)9[8+1ReL[b+-;ZSB7O;YbTAeDQ0&SW:,X^Q+[;2Z+\JSQea&88(KQB:-g0
-47&W5fVWOgF=6PdF(VC,P;JLUf?QQYW]\BU_1T5bU#W-db]ae@gX9\-)[37^&?W
d4b,EOJa]R@;0[(J/O.GcE+_)(7-9(HXbMA7)f=F7#LH&Q.+@+(RI9_O[KF3AKT+
25c?ORd]G@1ReIIO6F85<Y<WX[2/e+eV0eL=9?FHF6?gM)Z0CEa@gdA;_d0?9Mb0
Og?abb,O)/ABZI,e^SV_[GV0LY=QaXRSU;O-/Jg;TDd97?B>7ZF67O[M?Bg76&a2
YXDFU(RM\_]2IS:>PX2@7OVge/\a#V[&>fH1+UYQ8Y<=UUKg?/QY[[D.L5f^eJNO
@;F6<Wb0U3@<,D=S-RCB06<@\EUc<:a+<c8IL6/CG9(G^&IL68KKCVYOL1ODdZ<3
Hd>C(0UZ1PXdN[DQg8fUK3=cc)A&gAC=N&)F\T-d]CUUXM\3U;(PUYP-d/2[&[>d
ALfG=M8fJZ^K]5HLAXGB.-4VVWDWA;?FDcI7R5-][>c)P+IXC7TS&@VJWFYBL=77
;W:E40eVZ6;OL#)P8?)E?20S;^A077<b1HT.M_F7R9IOH]0Q@JT^Wc,CdRFEWSUP
6@e[a+7e)T-VN>bMG)+)?[aS(>I-.cZS^J]L]f8_DF2G0NWT7.MgP0Mg.8-8L02b
(;KAD0624LL(dOF49gO?W5<?\.b86bILZg+P&aI9SB,OA8AZ2D=7(S_^J>bX0c=/
V@^KTBZ=M+Q1R)M)[;77DPae1QB?B)R2Q[F+JUc&_RAaA45+Q&PJ3:6P#\+_IKA]
Y/?J8Q;5O?TK.BE,I0TIa=HD.->F7VH,F.c>9+4IB>0b9NaW139H/;&9P;=f;gU\
Qc9;<U_YI-60VaXK,DQG)DWdA2GGZf(I&R(E4]\.EC-?>F0MQT-gT+_@Z)K3KH-W
X;JfR)[;fO#R@_ZO#gR[d&EaE2ZU+U?;(LP0RQ&b^)ZQ\QC7,Jd]34-&&e6WQ??.
@VRc)Q52-+AV[/#IddfU@YGdGNb#<Ie#gc&I2<7-<.:0b&b,IP3[UF[9>1_cJ9eY
]OTU(\JHZ+;RJ0UOWA,f?RW\66]TUNc^UPL-<?BLbg]+9D]Oc;1O>&&C25=/FfM0
C^=6HOa_)4[^MTb-IWNJ=\87fW9/WV/_##WHR^R10FL8^+N-=#D96EL6)LSdKF0U
BOY\d336-UaeL5P[Af&&AIfDJI+1RVT.-b=X3E;:d,E,0g0/]f\e<2O[NNe]4:^[
JMMMcA>>^VM-TK2faX6e)^IF:O+V<DQb74APC:aSO7G,ZP^a=QZ9(TPT:]_+SE-N
J0GbK;C.JCKI2)VRf_12AG-7VFS[gDGE2,:1W>5P+NTdNe0+3(IaJR:BA2(;H[TZ
&/?eJU=93>JDJ,&7:&Z)WPcI2E/#b245bZ5Ja^)#M#ZBJbeS;1RBI,P7]?E3&2ZI
e#T^,4(cQ.>9dS5W&S4X[]#f?Oa-R;93HP?:e(+(Y)@ML@24K^C])&EGDAUfbGB3
4dFa6[33aU.S3S0@aY><a)7gZ1?P-X/IH)1^M5MR8<XdVMYDVKA_POKG2cXgR,3^
]/\?\+DM_]<0T@##FH.ZGP]-#7G0SZ>\S99J=Y:88;eXc0AZS.VV(SBgJ0+1K,:E
Ec<3=ed8E2UbF=&If=,WWR42[UA=I\D)VJU>9(F2OU+A8/FGC],,,cS#DR]L5g2f
G?d<TDN;->.ZN[F1R-BKQOVM9)>0)WA__(LAgHgc]cKTK77=L#:1,,.<,I68b)F@
V;4SRQ=;3>]5Y8@=:VYZ(R=Y>+OJPa;FC\86cJKWLD9?MZB7Z#@SRQ[2<:AUEHLZ
Cc-#DS.RX2;O,4+Y6c;N&#EH,XdAWeaL;IDCIPTDQP7PE<S.d2D+;#4T-)T4_D4>
cQKB0dET,2-QDIcCKSB&+^F\82;1EBg[_TKE3;c?:,=5@FIEN<H/Zd-MFc9GIIEO
K0-1c&AS>_YI5HEH[#=6GNI3)4N:O&f)J:QW99PRFHD^=BD96:fWLXa^2+Y)I]_b
FT6a&<U#XRR;a(YFSQ,0d\2?)S&@VIL2TKSG=-#(P[JFG/TP-c+^Z+gG24KV4]/B
eP9MXY:C:UH>0+EFgV3d.^JN&1>[-6@#)WQ0P1FfVSC-]U>M_NZb(O)[0#^6\A>5
ZV2.4]JUf74IP\75aZ9\WKdC&IMR^FDQM8KSYU(gTQ7K4/#_<KIE]^RU(_QAaFGb
-O6dYKGM3FgfSA^Z(J8&=F(dcE1BGReOebOVBJ0ga6e,V2bU0:FEZ<DNd]K@Q6=b
g4G;D-]?1GZ-LLg0?[G>/4020T&18b:VSH+.7PEGIT?8VD>.0?8V00)@eC74\;Vf
<c7M2P(VVcUKVf6O)@J.(KOKEJHe7R)?8a#GPNJSXNL:\@^LUI;QeBWJH0\18.K)
A:RT0=(?ZURC7R=5UDK:O=;AVK<0.c.WfXN=\e_M7;WcGFffg)6UP\/faLQSH\NK
V7O(>?Ka)^OZB\9]JN_(bY6Q;-IO.SH-T)4)-.F2RA,JUUCKS\L[K]BU.>V<KgAE
0#\XB)&][O492f6-)[X\<d;5ORUNFeCS_:KPO_\_bN\V&H#VG]>^V^6YA)?98=-)
+29-+dWCR7]>DY,.Sa/&>UabWHZ2CI<G^7SA+&00LfH#+V4f^O]d;+RKc3a_3X>d
(X.F#MP.+59A9eA_:AQ[FR1KgB<Z6()]/S-@>/cgNNDYYSafA?7EWTe;c:M4,II>
^4.6XE,.P,7L3-(,>O+Ee@c(3UHJ-]4][dN5e)KZ?R++;W(I30Rb#7;];;,<[0SI
?c68-@([Mg)-6UKXc_Y;CK7-)PU7C/@=F_E\ga1O?WB?d]:fN0+2M,W([BJGL2W6
0=&U=P6Z=#1S8GJY[(-8O?0.F&DN]B:GN,7b5=C7)B];G&U3DLZ4T_GF3I^L,L@&
?[?,KaALaSc7NbEH19I(c/F=9_=[/JXF26GgZHE?PF:d^=c=B25FM?&OL3:JX?-d
>PW]gVL4R?JYfC@\V-L:8[eD--J;B8VU#X7<^[7G.-N2KA:H[Gb42J[LR.E-WUDS
c_E>.[aG]DYQcH@LMK.&Q57F&_;X.KP2K76S(FY@6LDT.+dTPBM?AL88-a<7bINL
DUII\9<)OA2V40<:I@)]8[J::])-4@FIfLW>O.RPM8M7YcR)(KAH)3OU5&,::(6g
eTd9U,B3cU2fa9=CKbS>W^TOU7_S(fVfVVY6A2#T.N7Xe:7B>/XXW>dE(7AVNZP4
M]::TVVBE;LMS,(R.5g,1d@e+\N8HA,A\RX)aRgFO+:S5159TKZ<\]dgF,0Z=Hg(
dUg_.+YcFP8.AbY7VAU#_4T-ZRfBTCbZQ[>e#B4;G7<QW.TP6,-E_FICHDLA8FY#
_:\OWMO/3]-BgdYYHZ-B9dM>/]A6@>IB2N-#;:-0_FD6V+T;B](I,VZT<H73bYcL
-IB^XO,&:++ba-CPDU^T&,1TYa+)RVW>C0(>S3NUGZa^ce22H[?dKF7)c:DO]6Vd
IccO[R-a8dKR/O866C77V.XZMIXSFV>LY<V<QX,^0-;4?0]]>BL1.;6Z3F2ZEZcL
G=CA;X:OP87(Wa;C8,B>bS0_1SX.0=6V]Zab^BY&Q>dbdO5#F<FR3=UA)Q)eQYM/
4QG?>Og#>=U0<UM<>VSV[10=/,DE7g(_Gc?8JG^KH3>D68>a,0Yc7aKbTf3B+B/9
f7V;&999=\HJ3F7=];8ggCHRM&fXK2U6E0.2ONEf;X:6+O#Z2+-H@dUP.e-<?,cc
A@W3:X^8M9c&A[UKGJIb/+_/TY>E]665JfEL:-MCOBR-P[^[>ba)P<)S?/G]1Z^Y
3=2PY5#cVU&9=B(&<)#/Y4)[QRM<.E?/gIVJ4dILR8g?3UQ@^<g/:TO6BD(=?((;
3^^R.<76@0Q6A3D&D#;6O7Oa7:A9T,8U=EdDPe<G4Q[EggI\S^X/(=cR<53E]?3T
75+L7\fG0R@=P/QBcf8:>FPMSG20[-(K=1QONa?_Y9O;db<WT56e^KG?4(&>I3\P
g>269];G8..(TZE^0aSb1@#27aa[]dJ<JbFH/EH_P+g(IgV@<f#O:O&N-9K3@GC<
<G\-QZ#Te&D#D2K=\1?<T&;VV_2@AT)<7+0/FWP4c=B9W\d]8SXW@E1#^BIg#C4b
eM=&SI8&Wc[,G]V:LbLV_/(a\J0T7-Tab_43<U(b6:+AV/]2.-LO.eN6a(-RWFS-
O_TT&_WA++a-;QG6CaaTV/FLc7d6BBC-JbXeT7Q6:+gA>X8HSFID?.=GHRK,&87B
MW_<B6<fFU5(K^,ENf^9d5-33b&M5(^_@CA.Qb^eHA\^X5O9A9B#Td9Oe\<W[UW8
[>&R)]<_2?<#<QB.K^,;CQPGXe2\Y8<^W(R/H72D9MC<;e_/W])d<eR.6=7Q)P;G
5S=-ZPT/,X3TW2Y>Vc?Y:RM0Z9=+,bPQ7?5aC(>H2=W&F.;[/-/c(I[@\2/_I0/9
-eHW7eY?J+_?QC\_=_=FSY_;E01A[WS@O-.T9PTC,JN=U5(6W.La#2QG]WX;#DM2
+eMKA?GV37KH85[d;,gOXfI?698@1P&9=bcLJEZH&Y_?Y)UI0083^T=1bD5aB(6]
QY@YK)85e@T/((]23Z\8:?C733IR+_V<e)N(N(5_/Y=563MaW7R2R[d-R73^>Q]7
.)2M(d>NO=9-PWD0ZI66YT;dZG,6X=YJVQfW;:K>NRSKU(BB@E[)1)Y??cHBN3?Y
aO@CD=Jd()P>LdT(C,I;VL.^_/=#?M0>0=#a9,7IWHXD:gZY8Y@X9QA;7.:\0:E)
Z>^A0]De>+OKZDVe+fSF?GfXC2_W6dL+2J]TFeAY]C9:f?#23:7E]^9@GGD&6:9E
0?XKSZ(S-e[430)a#,YB2XPU/IX08D4D9EWCL<VRUbP95fFNd/;HBOe6ENA?Qc,g
@4U,BHEbZHaWWc:aSE;=;JF_KeGCK5W6e?.U(&L/HSU:5@QV1W38WGG]LC8La-<#
OK1:JXZ#3Z]CJa8Nd.F#+CR[>&.O>gJKKVJU<a2Z:Z8ZU::;f=T,=b083GTOR-a1
d7#RgDbIXV2U,/FHc0UOI;[8.DVFUJ;f&UF&5g::OHgZP:g1ZZcBV#W:dNMEN2)I
aU4S.Z77^ecdT)bB0eI^2\c11J;:<Qb^Ig)KN23T2W?@SR;9+&cV.C\]E2.gP6UH
&TI7RIKZROIgdag6)=AO+NOQDC5-7R\Y6:d3&FZW,,b=5R;AD^:b:01\X=QIc<SV
3:W^A^FNb:QAa6aH52G>F^_7IEPIAG?J7>BS;f._#ea_=Y)cC>OeHRW1]YgPP1M&
J8M66QCY9;=1aAHUBNM5JI&aE#QbQ<XFYL;XL;4&Q>K39JJ.E@^=(^84PWb2-O&<
e?W3BFa4Rf955B=L@XW).O)#bG&N3><4[+VNF3ZTFPQe-\J_=W5LNLXT3bdWM3O2
#1(O730>D6^00\]/,.81:+H8X.<5SHT[]dVW+g#6Rf1_#?gYaW9McSO[C#b4PUG2
?6V^D:;W_^7TEdQPa6.P>OY>YKW_Y:JSLNK)abBV669&R?PgaC\F?:ZA.bGe9B-U
gQACQ)<HI0baH.RN)2@-=gQ-:X;?<30P7+Eb4.eaJ]&HE3/^\.aY@-\1\E)UT9b8
-_A0P&QJ@K<Zf+,T9Oa5]50BG<RaY_<bBEBbZg=ZT<LfPE]V;39+\3EWCAAd;^Q9
\\f-DaWC80-FJ4WX,H.O>:\W5ARSE]<(1:.R8MF-)5D)Q6Cg80;L?R@S1#b,3/;=
M,DY3<M>ReX,-)B50](;_KCBPdOEE:K0^[G4=RAB&N>RH\1]-TY+ZIQf>A)A);]N
JP-KX-CNdU1\#Y#QcGV/L(KfQK_Qg2CHO-U?#Pd[_,B)(4=+CU@&cS71[??SW#B\
?&&#X]G+XDQ)fNd+OLHYUAFW()XCB^eWM01O68efc?_1\.E,dAM?Ec^4^#PSa,\8
[V]M+@6@J+D0+,\?c)fDM9_\6?DMR#P^1-SJ/SWe,dg&5N^b\EKJA3gNF3F5B(F>
@.g3,S=1JSc1#FgAd)UEd6YEMAV=d;D+H??6:&^9)Q.]dgSO;Ce]7\3Z\0V5QTAQ
H&dET1V@NRR-d-JBg\AUPTOcB+CdRC3;YXK4RI12b0,:OT5P&eINAFN?[90DX40[
(1eTc@6e7gGYC?cb4_b-ee2__fLJ:BeX?@-ATcPW9-bMEV&gF#VJSXbKQ61,O]@-
ZS_[CO6<D>O=0;N.>G.\=Bg;fY=DM&N.X<\3?/(G3G97A#eVP;W7Q_11Zb4E:[_a
c:I=c?a)4JXF)^OScEGA)61@-D\c4c&=V=E5IL6ED\M9P:/X&D]J_:L-D8YNY=H7
F208NdJg-101>c]Z\/F=NJJ;E?P[[1ZD3g)A&J]MQ_J<60,AcZR?)IMUKb)Q?=\b
KL+b?>FPebH=1Vd(STR@[?JLcW9)fY00<5[F<O-(>L=\[L,bDTL-@HW.=dREdES2
T.c^]bY&H(0^1R]d<Tab_>a2,XHU.RW.\HQT6UUW6(e]fB9D7[XPd\FI=1Q,;>RN
3Z(QIefAY)M5/.Y#-4&7#-gUP6XKEL,,]V_bO?Z1HF&RdGcA)EA??NG#/FFQ<7:@
2Y.Wc:9&FD.0eQ\cKK7D]^\=bE-[NILDL(28P[b_(4[1(_DcA^8I(b(ca\Y(Y+4C
J=OS1.S^(+0(.(4bgKO)>LAC+&QfOH<<]P[_83/YKf<a(O=Teg_T1>Vd&Z,33<bY
Ngd&37.R4e\bSLF.d&YNVP:^L:ZaKXLN9eA;5&R],_a2_GS-IW@TH(NL0YS&F_@(
(:0T\3)eO6U,TW3fRPEg9RD>&TFcX-Qa\O.04&?0=7XXW4fD6aNP<Hb[U:5H,CZb
AWP^_OFE;d]#D/#6&.7e8)SR6g6S>/A4bQaHY?)e+@8_I1VAHCPC^89TBVB@\f@5
PTX#[c/M.EX;:K1S/M:,EGg]MfaJS=ag4@U-6G3KA(I[3GaZcKg\(QC_2S&TFS7G
=F#G##Q07ab;R;:7.IH7RD#gLIc;&:gGXQW2b;\7(e-1LM,eUM@0M5Y7RH#U_:QM
CFN,K45FNb\F^XPY_@FO/[8N6,<<U<&;O(QD43E;<6f7fK&?I1FY#OR.Hg^BfOIa
+:B85M+KFH9;GRbD40X?;QH,VM-V\]dZOKT<,/fTa,F>?;gIg2SSR7aEUHLG)CUg
eeAG?K5RNd+^Cg?O[QLSCQb<5C&N#5HVAXU0dbB)/EIR=[?Vc-?^8@RgSN9S#T8R
5?Q6T32I,HC4M2Yc31TL^0gL-NQ0fYQf\bA48&RE4Qg7gV@X1Y-b\HNKDP?Rd_=]
F>TGX/Z/;7:H4V=ZYOS3CXL[N)Ya<1@e#8[.W@MBRQ#;eB4;\b(_^6>FU_#HK,DX
<H@Z)6V3ZBd3^RdH=GY<?Y7-/NM\0/QLS4/D9]EU8HK1^?N[R@EZeR_^cNDXTA&I
V9M?^,#7,EbH:BWD3PcP07L#&07a5#_.NHSX\#V2JL2>U?G:[C=B#H0Q#2AK#2J)
>V<9G0aU9.aaFAeQ(\<#FR,0;BgCa:]gD=W#dH;>.88(>V^JJg+SE).2e,?1Vg-U
>/2ba#,+CSJaI7.DE5:KGJ9VOEP]ff..RDOaIcUYM(&MRP4ZH^5MZ6.LA1Pd@8.A
\J90WQ3PDe>B6^V;&F^>-L;FTYT#+6F60^;7.H_PXG::I1NV3]RF(.X&.YY?U=gT
3Fe(HcNG5OJ258\WT1L/E(3B:I]ad>f&7Dg]N/2ff5?c)R)\H\7E55d>WM=E-2<7
cX2_c>8A[3O-&YFdI+_8#?V/2e92>DIb\JK:fP2g6fZ:[[G<,V?1-F<0c05f9e-L
Q5dgPgM?EUbQ-K=6(_8B[#aA(J?\^2<fabZb7aH@Z.)#dc<P^C?R&V)fZ[/MP^c.
L^6CN][+J#0/LQ_B/^&MRHR;,]9Td+DEQP=:5)CPH^?-4VbI(d[],a@(ed2=?W:D
=8/8>P1J0@0XHZ\9T^2C6Yd0ZWMa8LG5HP/Jf5fW?dY[7OJ<HT9//_;@/0,WCEFL
\YY[gWfgW6W_UAF&2VPWT9898a1BMd#\FT6dS9)L_UQI?=>f\ZUXF;#JN:Ra;W(A
f[fL[5R?JG#L6Y6Q-X/C^(DaE-I]47e-JE/K=6:cL-]&M4B3PGS4Zcf#a;^BM[e<
BM[QCLf7/fOJP(8>dT3.K_-^Cg(8/BQ:S?Q.RUIDdX:2Vf?PYO-f=4=-/RFWTbEV
<9TCA[cTIU.CCB,6/@[BI14Hb2GeD(.+/b0?&712Egb(N)CfW&gS^C=:Ua7T.50_
FTZDC?H9Y2SOLX#+Q?6#_H<Ze,C3_<4)R:K6W#>8DOT./>WLHA)KCY,KH7[3?,)^
=g#:>O=EG+.H:Va#O3cb\_G_89XG5P<Kc_N<#KgXU5S8[<SZ=50UL.:Mb@b/[8W5
Y>cPOS3UB4H^T^G<\@1.)T@e-#4,1KTf2OV@W)BLca<A?Q<cNP7/=462H(6c0Y-T
;9#+\Y=SCI]2?PZ.2\RVgE/3KQId@,Q_f:NAYg^2-^(XJe90LFb)2g;>S_daE7+P
3995UPP:U;d)K]RAV)e\_1O@+[.2FJVB@Ua(YGY<b3F=?BJCEXDTRaK[/A,;NKAM
I4[,9?AS?[-7c,_^](?gV3H]H,cXLSEGZBE^@Y]<Kf2RIQ5+H,FA+(Ud1/JL[RN6
_aOA=Pa=N6+22;(/[M^X3V>\MY6f[eaHQ-15D9H>;]GLZ7(..eQF?Y0]^/_G]KWA
9GDfV_^ZP#/HP#AYea34e)_D6QD],S&#E&Fb\DBAb1,<<VD^Z3+ZBGO&L>MR#][8
^>FP\8P9BS>9V+<;&/^7T>&LcDIQJA<Z\G#59@df&U28<-dMU#,&NdKb^)0N#?TD
DH?6-RTLSeYHRNg@TAA#LZIf/fc2R;+#@7M+:FfC/Mf6VW9TBY^-.K-.MM-]b)VD
?G&2?SF)gH)]N=SN7673LCGXJ<,7+47LT-YCd>.^.62G;BHJ[1e@U7HE3YXOJ[ff
&D\ME>97QdXfO-7TdCRV1ddGg(]d9QN0cf:T)/8gRD5cEdP>S#9:6VOONaA,N):@
@8GYaKVG\CbXMc@M9K(710,Y8Lb^?OZT&I[BMX/XP@7UL9QY)cCI5HI4&&A-D@@S
T4-SV-_]<-7gCGQ:,0?4cbIY4TE/?(Ea0R6032RYJ](3.HTXEN-?2LP4a9[FS01&
JDeDQJ8_TQ(B,;.)?9J/5=eJ3IeQKZaS64D&Q<^D_Y==8GgLZX@R5afY0F&D];@.
,FJ;[@E/;]TPEB9MY,D/E?LTALI=/@]A\(_\egf=aPKNGQ,4V>D78L_Z1)O<LEa8
[AdFMPMLaECX3fa#aIY1===0Pg+Xg<W(7@>JGAQJE\]U&:UJ/>G?Qc,6MC8?1:5M
UY;L\;LVN-bL5ACZ\d;Bf@Gfe^K0Sb3C]EY.b+B/D[&9X7[/C#fE,bKS)(T.B8Uc
e?c+\EY_7JZ+f28+a&eW9RP4\R3FH;(;=_E^=gTLC#W@N\Bd<a4;2GLPRJGdRK_J
DZ752RZL#0<fAKg1?.J>[0&X0)=<HH6W^W5_N+3c@[CQ)f>1DLU71PX]3S>@A]O;
.2+SZG^\LKdIb:+@TfE(LDB,7:K\6-IG5X>E+<]I4C))S[O,=GOU#R_PE7LdT2GD
La#,Yg1V.+(d6S6(;e>:]YH.E20/3[]1aYPT2;V(+;/6N@R.E8YeBFgc0?3O:+:a
1Xe?gU\IZ\0YIWM5-_Ad9?1G(f@F7QGL4Y)(^S+U[]H_3e59ENc3e+eZ5dc0VM)&
TK)T?dBUcHV2.2R=R[.+GJ.H]ARRHEZQGOF=#.9K][.7W<J,Y2>#U;Q[B4D(bGJ6
B\AZ0eS)6M2/\TV023J;a+L@;g1B#_-@+3XF;e:&=/e4d6KDXRM,)WME@X]cf(=.
Ba21FBX:b=\]9.1?ZIMCCS=C\ACQR9/=4RR&aI/;1X@3GV<QJYJCTb:,@]ENgRMZ
:I:Oa[^E?^Z9dGM7?&)^d(dPU6[aG=W\B@1285#O[Fe[@]\Y8f<X1;/O5;AI^c59
RReV0^=TEUN=@eSBIMGM>_K34_]>X=W=8f_@N.\gPLCLHgWHD((9OQVRK<.4fUSC
:NK:EA(W#M_RgB5\;9@;7cI3c;&IGJ9+_QW3&^/-G2Z992_Z);O6_/K-3]DH,(U:
D_K3I^@c0f1(#=H4>Rb^O^D]6)aQDNR4VVO0VOdAUb+HeKN[FU?fbI8X1?JFM;,L
UEEPL5.O7/^_;f>\KDP;P<]YTNSc>D6]Ab7_DD23R;_)9@;ecN/@EJQB(DVFU7HK
ZG(4I5.J6WU@e^OK657_^&&2G?XY6P?V14E7-^12=7U_JU63d/UX=#Q);;MgH<eD
+S>9WJ9DWK77TA>2-D0Y.DfE^\Y<fM#:E<T-T9(OYIX(Ag2M;geC&T<&=QOQ1[RY
+<e[eK;ARH>\fZ1A>Y\J/f;Db-:[.(9QEHZ4bZK-fE8O,N8KIAT\5R6>DN&#G(Z\
C/<\Gd2/(=FH5YN^^2E-/842802\\@><+Ae;C=-=D,cKNfFcH[Gb;I^LH8C7^<3I
#Qb57H?+QLW(9KOAIHA]W@FF-IXcFESKA)(Z:BgL.Q.->=)VKUZ-MO[.U?>Z>bdb
XIE1X7#Ge84g_V5#F.DLP-bg4b7:=HSCO:<=:b#e>ecC]7;VF0,]N4F#(=4OVbgJ
F6Mf&9H2?P+9B7RD+:4W>=Yb>DD^@U-:X(KX1O?D>2Y)]PgBLST#^>Uef9MS@V+R
d0AZ/-GFTa,18TSZ))#7AK=B=g-YKRPCAS[bGJGUbR)+((-BP9>5g9(BY\RE2cZ]
3@+)?2_Q7K6)e&dX@/+2_E1?]VPO_M4D+Ef7Q;]<bH.#3ZDF-F+MEKDfY1A7Me#I
CY@^^AfQdE\If#>S0?gYcC:]A:ZD7JV&Q>;Y<12T\E2]J__VN.+P4\FHA;ANH?X9
A(-+X]L<Ob85CXfB_JF##Z<MaI-6b/Fg5[U\E-UK5,-&CIc9gTRL=H(FfU4>ELQF
7]MOgf0R0QE&._#eJ35\eR+5W+KDN\3<++YUT7(TLU][AAYNBKQ,1ab^=Gb_-,R+
@Q_MAQ2>=IMOLM]A##FGL-W]AM:T9F/RM)IK+/A58K_MU;D^+S+XW?.((APW-OcU
IZ:X=JQ^da1VSN<eQea<\3;I[H)<e]X5T[=WDAP3];5H=7\V?-J;@+AEV(>7KEa;
7Q?e2#<Y0D(V<>272YB-MC-CAg@/g-0X2+&;H([?1O&H&LT<=?6HACa,XR@/-a2Y
13D_bC=01XJ1gb)-e>.XC8)Vf<FV?6K8C?3X2R,GYU5V7(O+U.eSE(P+1e\7I-J_
CCRQ4K#]?_VUIDTfK?2RGR]T<[6F9Q[2GF5D9VHZ;XcH8b)UCETS<NE1)c7ESBR?
JdbdJ2>55#\.9^=J^M#cRO6@CU[6()&^/JLX@HD5HKUBO60cST_RR75cGFDU-Aa3
0eb[a(Af/df-fS9>.f/fSD^G@&GBGg_DH&Q2,K0eIQ.&EgfGW#,gQ<.ZZ5>&7+He
025:L0LAcdb6(R&^-V,7_HDe<#+RS1;aM#(UWfc>@?SPZ:6?B(WX9_V<.16fVD@I
;Heg3cMS1G[&\>KBWTH=S&/a5A?F0L(FWJEGK<L=1^RS(SbNJ7>;H._BG#d\\ARH
77fIMI\f.c,PH/=/>P-9BP[2ER3.JUO^F^FaL2RLdSJLM:90@;RTXeHU@W30V8W+
3A>#gY66PRX;QUe5)T6d@48cB?WU>WF:2M(;DD&)4BK@@Tbc0PR<7_,Jb_0aIG1>
<+]A9#7P=:bFP?2[463;F>-ETN5D[LXIUf:_3?N;<3=Ua68YK>B)eD3Y8N?SQ:b4
A8cN#SY4-ZR_EK?5[=WeQgJcS6N(Cb\#O(4I]-64cGdU_-#beVV.F]+ee?TY(3C:
+T\=H;LMF-0)P,]FeVF]+;&:;435/b(E0[DIdHDBO_YW@]H]g23cH);:8Cb6>fVg
eD/QBU+W#](FGWXQ,:Yd)Ff=UbY.6X0K:QF?)#N;c&fEQE&B@9P/#[9D-Egf3TP&
-[&8Pc_?PE23>:;Ya-N3aSB?c2G-5D\^Me&f1(^0T4b-]\TV0Y/LAN-fI_g.N1WQ
<7If,1K&[4SM=La0f5_,@J0+#0O5/#8KK3/BWN43e;\S#,dQ4Zb3^[U9@0,=]S9L
:cN2PJ3U0f\QQ#X&3^D8)aC2\^V,76+ZL.JMG]0d_@If<71MM,9G4Q+OeC+)]c(Z
Y[<.V&#7G(-9;<J\2UT0&4,F^TSSKd+3a27EUA)U-4VJP:KK)C9.+R/A4f-H=,+Q
2H,Q(MC_MVT/)G)a_]TfGY(HbO)A4YAPdbd:_&6-5SP-2>bG.>J3KVYg9NHYEC<A
AM7#030@ML2H\8[:_4a-UV1)-.-5EAQADFH\8:7E#D\4c_U?Ld).1H.A>,XE_#VQ
Sf;9QN6U.VZ(?Da9e4gHbM(N0&b3U5TWE^PO>+?(]+93?:Bda>6BKd^@<=S>b[0\
I4aDZM0J47\a;]LW7gADV3VEfD7D?gL\dO\=2MS>>QFVFg?EE^VZE4Le6:T4^e90
K]HL1U34gWegR;JP+db+R:Xfga2W]KVNcBHJGa>VXa546XQIY?L5R-JP7d-3gd/A
Lb-HW:><<8eF]+\>BaAI6HJU/d=OC=R#gI[JQcS\>Z)EFM2^EB<H)EHF.HLgRPCP
V\N:PM@&6&2g(AM>#K_K?#1e+e5fV;B:H5Q+-1_a(G5b:,);?,@J-H)f2?Y@aR9Q
KQ]__b@F0.R#cZ15>EET?^K4[5;)><3E^,PPYI?.S\L#0;._JW(^06JQ#IOdZ.G<
E/CS,dNa[YCZ?JDKRgA=R2@Kfb;9M#KR)QTX1dT518NH+7H/)_]_GO&?CZfb/[15
c8G#V7ObGOfS6_^RcJ)X3CLX5-3/1./LMOeUGUYM>UH1EL^)PPWH)A?H.>W[>cHK
=FG#_C);0e(?#)cef<O2Y#A^C5?SKJ,a5=,aGf;eaW,Y9)Gc(VcJ^KQNb.Z7d2>>
,A4T]L1+/KD1AUZYTH\/H8Y9@)=5gYD9V@Y&9_1OZ_(V&>5YgN@82N[4RQK@_77S
-:T0)HXM8YK1eGPDg,f1,OHBHM@8?IGO>f7-dF:f[.c^.ag&&-8^QaWa,eg@8CZ5
0YZ-Z8&WeJ6\&T3D5TfRP0_ATebTN[41,REX4BfCO2#0b?D=DVALI4UDTDB#AeH#
MW&)5&#+M@3G_d1g0L4eT^QKQPTYcFPDN@(IA>Z^N6P#<-#RRA10([I_(3_LSa^-
Md8e.cXb155>RTF2I0c]\A?T6KO:H+;SRY+ILW;.Hc>YVUQcHXL3NQY2CFP=IdL5
eCHD)Z=cL=3e:e9:/d5YOV>O8f:L_Je=Qb-aLgH.T<_[^.@W5+C0I-^NOD9;17ZE
UIb)@843473TABUbJ/Y]d6PX6d.a1R-]@6;XCKJ-M,_FQZPK]MGVMcWX>)?F0ffX
SLB<?_ag7Z32<ATeg4g3Ve^UV)EbgD6QZZR?Rf<F\WL3#;OX5L,CTG_2gFcLJJYO
+6Ye@gbW=JEdBOI0924?1Fe[GXLAd;SOS0FHfOe7;g]#\2J@bD)f/_E099Yd)P)V
S<QU(fb=7#IT?:[:^GI3&#>:B7P<SD66;g;/Z_ZO8?1@TK>8PD71G7C=M@E74VE^
IHIVgTJ0(;2>./5W46CT1.L9J0.\C>c=d(3@;._1UN/cZd07DdG0)N>>N8M,\M(=
+QCf]<0O/_/g/S962^54HKU\UYCNR)&[>JSK<CW5:.DZSHB>RP.:c#63b256E_.?
cd>:8>+O_J(7d4IXFXCY)Gg83FfDE3KV7\8RZ(9;<F;\CgLB_+9UaZ5(\a_bLBXH
/GHNd6Lc<E.BJe+W]eE3NJCIE/FQ=8K4^B6HER]NV-a+?8CKT+[:<d#R&H=XK(/]
H1/FP.TOT(,DGS^/P)4:?E@)TG(EAC:C1MN>/;\0:_7F2,<RX0S41a42H\>O#RO@
8FYG71FE6:^82B4Ve71@E8)1gAU4EW;3c/70b4JJ^02;.D(g(3WQ1AT,6>R2L&V8
c)aV<f1c3X85CTbb+Fe:HKF-a26?80W+C<+e<\QZLO-/SW_2@;I^VA?&KYXA&F6K
Fb8U];1X<;a\@=8SC4FfLOW_UR@7UdW^)/R5Y)bT#/L^AG5>Ne=IA);#:(4B:IaT
,5gf3VIN0GV;<J_RIffU_ecI3->^-SJHJRX5LEC<F^1@EbG@?YT:_:UD?Y#WW^A4
KLUEH,6RF.Za)IH>K/:U0FUbF,A58?()TC\615OW0Y&;J;Fd>GHU,QL.J];FUVc(
Tg0#1;:167UbQ.d4JgO;X<EPDA0OT-8fe&>>^DO<^P]dRD37-AgT=TA/X,Z1H71+
1\.MKEHXJ8f(-]I2?QRd2D9DTf,AAHF)[8eL@P(dfIS^bICQ<TRELUWXe_T7A=7\
.KM>#5>\9ZT+-B>FS=:e6Nc?&KPE<RAU0\6X=Ic?aEEX>?87>g-V0MRNAMNLYKY0
6NA?0VdeT-Pe_4EfgOCR(AG5RRcP:KB+,281eCT<DeNe]f7_JHAS7:gZCS1T74)G
7377;N^&][G=#J?Y<\+L(S-[T^Qg&)aOQ8W_c<#g/_#N_-(aDE&c4LD4@;_>WO_=
2A(RQX;6&OP^-VA4(C)=E&,D0)2\>C4?aUL-)&W)?g,2W&YDWC6MDEHAX&J_gM;&
8X5A)AC;_HVIEQ_NIVc73aQ7_<(8DTg@:7F>d@.<S)f<7\F4d3V][[LK&(R45[cT
[/GaK^O@Xd^,a<I5,&1/9DMaC.X.e&fC3Z[.R)_^80SL4G5?G\?_,@#Ug2)(WNG7
EXF#G.X_1F<9X&ZbEXN1JP^?B_#BVc1<QHK#XGAb,U5:YJ&;_2g5:C8ZW8XD65T?
W+]9)IfDJ/A5e+-9N,Tb3&GNH>B0d5@_+)]DD/:PPe)<Ffg=+&I.>RV4RYW_#G=5
]#5ZS>+C<f[8>B+[D]^9_9fV8R_T/.agG;R.D&<7X[CU8Ea+Mf<T\A.08S-[IBWb
+b/E5)Vg)T&,Y9OD7<0K<5Z:=<=/>A=C]WS\CGFV@#T6,YO)>gC#.>EH2:]WH[MA
(#gH_2d-3,QVI;gI[AADT[#2UG/S2</.7Q1Q#_0b./4=KARMcDSU\O4=<]2ag.T7
>-_&CLW)RLYTEU3AS\^282&.@gUC.g2G.-B1@4KPU?X8WI:(g8JNE&U&1)N+Kf;J
G+R/5XGd(=5LPIV3NQ)P;FG9?ELO#RZ[>-.U]/#WOfY?A?XV#1Qe.;3\UWc/PJDC
F<G]Qcf0JVT&1EI//_@\\>D\));5Z,G.X3Q/8+91^])0>g3#V,SGA?[06)6YW\7K
9G_2.9IGXA=NB.#g90[HfNYY3Y<9SV7_[]T1)&ZI[3;>>RA#:#FA+eE4Y42X)/8a
DfSID>bbff38D4P9Hc]^=a;O)=[3A]9/VHf[IM&GZe;Y98<LUOK8/b3DBSBTgJ#W
:;:E37cf._Z1OPEF\1F)IeAGH:Y&JZKJ1;A;FWL8Z]feaJPDeZ5XGX)b6MFAa1aN
MPaB9P,OLVK](\@(dE8F\J)&V:]PAU#;cN&#ZGDddZ@IP,]MdR,>+JZe?0^6^#>0
,;.W.J.\<V?Y<Z-;]&Z0>/QA3g>(H/-O&KXRTb^.BF@Z/]_UgCVI4;cXO@=(J-#V
563-(dVW<L9bfcP)[7_/ea-L++C7Vg8MUR&4fRR2.N3KFH5B&Z4>fBS=f:Jf]#]_
7g-_gU?6d1>ZVU1KE+YffEC<TCA\OOO4]VcU:/I:JeJ=N4gZ\M[e1VBA:)N//BH-
M-(a?9FUXgTW(7O,eA&SR6gIge((I)7Fa],dX9W6,=XB(OHCHb9_JAW,<W>SASZ/
M_S[_5_-K9dP;@@,T)([JOV7K^P[N;9=W?90M.(dIAT+@^^HO[U^@((+A9fY;MYf
1)C>b,/.L98RS8?B>/@(C4X(8G&JaICJBVT:6I(M1&7aKN7E+a;6EQ+O,RHYNg2S
A_G&1;RCE<O4;OH26OcQZfP,ICdNIJJCbAMXCg2-d0)]7XS0FWL(3NF:[fU#^f<f
2Ad#b9c=6#@LO6Lb,<DDPRbgY,6J?\3>7&D5NZSKP)eV715C,Z07Q\2fN;N-OX:V
2gaAGXNXX;=ORb@X4Z]PJf04cZLZZI=b4&Wa-3,c:#cR8BC:(U7SN=R0Ka2FIBU&
^1IVVK)_cB+52R[I1U=)U[Da+3[cH_Y;d2Q>\a3NF#Y5@Qbc<PfdDK(,VB,0VETS
E-U0RS)62De+&D#+>?][A7A+a]9H^>f8R&H#/c:H,1IGS<^13EIYJ?&-d3YT26ZK
8:Q:f#7Y=B:KUU.d\&+5SJb]Z)&H;O@:_BJ.Zf319MI/+acCaO&R+<ad\&cSYIEU
9<ME)6cNZ]152?YdGb>)3E(5U,XF3<&(\#)KK[09AP&.XF4&f(.L.G+ZWN/#0K\I
Z7#YIX<R5,S^)5+e,T@XD1.IYg]DFg1X,(PQTB_ILcY8SV3QJ7@fE90,4A:6]H^D
^P[6+fM5TV0bDPKEDHfIFY5(bPPA:^:0TOV7R[?g:4NJU[.gWV?8aXd9Y+,P7IJ?
3LINB(8X<;QSL,LL:.dU9[IJKTWW8M.J^2IQ4/998#b]V2>;IS]ceY-OL_;1)cLL
a9d+\:0@S5\4/;(&;H#\S>FCRe8\7b6bT7IUHYab/,_:BJS:8&bK5RTc0:,(<8R[
\ZWSCggaZc80&gQ+XcfBa#c@f\\S]XKc/:U4OBAe=,E&GNff#g(S=/B?H((TXX6C
O;?T/&GIaF43HH;#K-R(D<Ye&..=&).9IdN[]^KNBX#I3dU:C>IYX;](4?(9RK1+
_0524S3EXWDXeFYe82I8@C,U]VKL/4Of-a.[M9L^ZQ##a#TK@VLEIRGWTGMC>KLJ
c[c2\\S<YR[.:79\44A&7-M:-gW/]^RY-&YJ<,>;T[D8Y-T&Y??1-D25LFVG\]e=
V[=J<,6P08#6c(AT,IWP0Ud:(MGM.gBfC<=B[Y;D2@_13XA4.455Sg9f0(5eE0-_
XYMV&/2J<4MVa\BHf1-D)DX+9[]Fb:I1A7I=HWW[80B]5.ge9SGCTGYMRV:dW=b5
+cTEgOGESD8@+(MLb;XMHCF0X>^:A:A&3UC)9IGX299J0_b],4<1U)UORJD+R[V6
3[K@^(V78(JAPPX]N7+N=)7_#1O_C7#R\<S5^(,6Q0E+QB,51L?PF27/UP@AM3^Y
-.8G(]/AIDBXWRU6+1JXTI)6T;L[\QeS56cE@G.V&.MMX/W+@8FWC4^.a9BEe>^K
-^]ET;Y,F.6Y8&dDY-\OXZ1Q8,+@55)4OJ<<Nf7a<8&Nc2g3c6B#IR8eMH7T^gS/
@?@]JeHfc[-5a61#L8:bPDP&U>/&T8AI38YEcF-&O\)\FGSCYP7E<<&cLB(Y>_?@
9WKFLEAC]KD?<M8@E;FE)KJ50Oa@,)#0E-d.I-64>DdG;cJ==696\#+6U0#5M-WK
Ncg(6V26:dP+g>307S(beKZ^+&gY&KE6?\IL(R[fFA_7]M=^CJcI@A-U?\7LbQ9>
(FE>ZV?#J:D[GgE4=AaSJIM]2Bc@D8R-=X4/>B1V^QDKbg,cJ00P1C6Y.DUWG[L)
\(R192Fa78Oa=]C8<P(<=F2Oe95XHPTYHA7Uf,SBLNZD-AcCZXU[IbTDV7QOG[AA
]X.I<5aN/^,-\&&</cC69IO?AVdT@46edLE]:MO2ENYF]Ac07[R0+OMYCG#G;2aL
B256254BAPVZ;48T+_PdeM:FZ,8=QNTC1d4_(7:?R:=S.\AW&=D?=\&X^YW;_/N^
NXa5S4ZTcP<(Q(g;e?@Cb.312cL#]CC1V8_WQ)^TT@(C.bTQ9>XK2gEJZIK0H4[6
G6>KW7NgM.HYfO5-M8R17,)aU>>R2XUCRC,SQQPcQIAB)=-O(WVOY?X.4,0H^gNO
&?V0SfT7RfK)6<PPd:.>A;\D;;AdVG)K8dQ>J@DB2C5>4JKf8HV5^)163.EXeAa9
J46&RI@;]Z]UeNeLebIUb-NfYc.UDM)a0U2g]T\>^99G]]&cG&U4F6EU<]S^,Q=N
&[@I9DPbA;IM9fV&3/2(\\2M:(@6_.+6A.\,7aOGHP8/H;=-1X?<M)>3eUbdKfH-
B8,)HBQ?:_BB?ZQAE+Uf-8WPaZ7&<aMV<Gg^6-Q[N5.)-6_IYeA3G;.TV\:9YB\^
UQ@F9?f>YYC];\PTbW@;@V>MSHXQ<L&,Ae\4\J,ML0>/FC(39,Bb>KYd9/J#LRbD
,ef=1J?E?S-D<2SdG6a\ERK-V;,D?HK0/AO>bE^6Ga32c>^9+.4PW)TV56?3DRQ\
e(-)bIg&@^NCL5NH58OB7\\AbNcae>@U3Z2WL7R?B7eIJ1G&)<fXT3JV5df\M.93
daVTK(U3W>RX1W2B7a4f1GDgGJASJbF9G0LI@C91eNZ])\35SIR=06YAW1KKMBN3
b-+8\;>UMUABQ:/W5IO:Jb^@,CJ-4K\I/c>7[8J?VTYV;^a#bMaL#1(_;UFA4[Mg
MH[_RP+0SQ-R/d->_ITT3fJc7N[Z\Rcgc-FY8L/+NG;_W,#ge<aK9M<6[Y0;B7B3
Y?I/:e9HGXC1-78-a&SF<AYV\1f(8+T+QBS,Sb8X7bcg_-@B>\CN_7IJQXVH/?6=
PSK;=_1(ETONVX,Be>_]U\UVG_65V_FR=Og.KUQ_C1Y+XR=P0JPP\_N(Ff]3efFB
,.4B2ESZO9bd/WU&@)#&L\U@2<_J3FEVHQ;XIc+MG#FUU,2M0&ga(0EXLA:8P^+G
]WHFCGQ/O<d(;QSa?62L3E+0VWVAG;:D]@XXc_gNgeKT/PT/<0IN5U[06Y:5A.OS
6/#RX=\)<&9EJ9RN<QIdAZ9BT-;VB5.X7.A34R.>VR978-AYA=QP8X[5cfQ-dDg<
)L0dC<DR@>L?C6;04Pg9MEg8fL^BdN)]^eP,8,7H-e&9bZdDVK+CG8U=ZH;2@;W(
OZBdZ^MH_c#.B]aVH-TA4]^IY].,V=RYA<DSHa9]YQY-5RKR.8GE[7?f+#d+00\G
FW[&32c?>VdMSP/9FeeP2K-A@ePZYR6:b;NK?6D,fL<1T>I/K<X\fY&>L?#]J]<(
W1a,,+9Y6:O,fSR[5eKO<,U5bNRE2^JPU,M[R-8ILJP>QGa0SF]Z:;5Q@9gW_?@2
;a@2[]-4C.Ff(aH#H2:A4@KGJR_f4CXLF9HfC&+54BJ?&FO)@/Q-7DPVa?CaZQ-T
=@:VSB.E4D\d217S[X#bYSBS/3O.+b,2H2C03Z[dE(80K0a8G_#M9]Pg+KK>SA]F
1J(X,H8Fb76e9WBQ]NQAfM>d^\Qf.LZf7,W\CL74aL-OIA4/,]BZ;ZgKV.d:;Y:Y
/Nf4O(JBSZ?=]8@5DWE(7WeVF[NR\26O39?-5,Jb:G.TcJEYaQ.M_/,.Q54L.d[\
6U21ER)\ZBS+Xd^=LZ.68C9I?E-8+MGP4TCPDU0E<@50,V+,a;ZCLZOQda0+??JO
8K=dWIMg],b32GSRe2]D>D52/SYb<G42g4V,a2Y-38RMI]CCBP-=&E:(EDQ4#G?-
GOF4V-Og4HbJcQ>QePO3[U0IDfbI<4.edRNB,DO6VMM(TAL\F)S5U0)#a#(8<IFV
56FaL-DFa?\80<[[=Eg6HP[.&XK&P:OV5\.+JM-9bJfUORQ<fDY;3K_UDL;0_9f[
EXY@:FBgU+P>D#P:((?=?DH-7PCX#MX\Aa6@N1P7@4[,Z]4TY@1<Mc?>^fU.H<>5
C#YH8)Z++IX@Y(([e+.?3/L52FIO3L_Da],;F]bR@QK]D<N2A_8G1#)\Hd:YDC&J
-aQB]>/R2=]/RG5Gd<N^&[@)10A=,X/^#dfLID5bXQA)96gH77A@g4_YU7_LHV,D
PE?+7QYP]JaBW(Hc,A_[F\J0W0KCEPJB\A_81ZU:5\4:_g?TN3QcM.dM>3DI(1F(
gH-.175F]+HHV[WIA.1cEc92)<,/E:EaK4YH_:O\O4bV8\-f>)N-C/R<ZVJIgQ<N
(<>05agZR1<A/6EO3KCKA7-eB@E4<VV3Z(,F)gWV)I>Ke:D5JV\6L@ZMbN<U6)bf
W5eCO2,DCec/2AL)aa[VHR+-M4JMLO\0/.N?LMfP/@]E)Wb#;X<GL1(SO/O\N48#
@^DOd2fb.K/_4>(O?CDVT)S3.70HD5:a/bcaBd..A7>:W@9WEL1XWBd3FB0JC53?
<ZVPeL>f4I<0Gc\9Sb<;#[RWB4O0<WLZ25819Y=U?37&<XPX?33@DDHM.K/C2<X=
988e;MCU&B?),+Z(([HZUXK\;LG7NB,FFA@8)e=+SQEAV;]N4JQ>IV2L=b(a_gZB
,W05\KEKRZW&=GEeEALa@+@c()X5#O^9F3CW;8@9X,TWa1EG+1ETQSfb6c2b;SML
)NdQ[QVT544;C0-gEcg;WU65Mg^0:^>V)IA)gOXKcJWd&8\OGJdGg.H^VR/B2/Y0
BQNU1W>L=]W:E85Z9YI>W9@9dCE=QE2FGHbFEY4K\A1GI@D[-6X<(@>.L7\-aWRA
EfAeD2.E#&bI^9P>>;<[6B,7-+R<EI4e^FB61F(<Ke[/TQE&5I[dGVNLC#\UJJRb
:[dXVD\;cQD=UWEQ,A4>=6SX7VSVM8e7EYJ0dV6JU57.A04f-U79+dFN0TP.K9/R
8(==#5P(Cb]8ONTeFKYeegK;]aXSO+&T#Vf2X&Ee2,PTeK._0a(=&DVO(7\7@MPA
&XN;&-@V6#SUG1K\FgJ<VH-QO@-O>:.1@a_2B.cAIP^M?7Mg:AdP:EV/T)M0I/8a
gFZYAa\>G7YH6.AbAdHE6]^I1Z4WM)f:HEIPL7?+a>425Q@RRGf#J2cXePB.5H;U
AcVD1CaMgg.gc0-0OcJP8_E_E,d8Tc3Z0ZZc;,[S>BYV\#_6_T99(XHYXZ#7J4>C
9Bg04E84GWQV8BKB3<4B>06;c:5@f>IR1_c1OISKYF:[b/f,7IUY69DTL@JBU]\b
OG0ZFLT(f-b8(@+4=84e,KEbM&TQYSHV4X:Uc2+WKH&?B;:&2]:MO589+4cKZQSI
La-)G.TJL/PD#X6b;a\;ZJ;0_XP0+b==F_gBeaFa\TX]9Z51=P5)R]V@^VFN.92V
H6N1Z8F.B3>DJ5.HQIKb4FFR56,XS#]&M^80]^P>/UM57UWU:e0BWgN_&RGfNI96
fAQ.CSGF2B@;4A^RB7?eM1B:36bGd2P<N0#A@S__b\I;O(<01\TN=FMgQCWa]+-K
\,[0MTX4TX])Q<(^4/COC&Y)SHU89eXXUYZO50=&b1V)W9@J4]Cf2X0_D):>c>cD
QX30)^b;-#0=::6.@M.H0:?M7HFd#-7728QM#=+&D01Q.LM@&1:G-+eL@)g:ae/U
4?c(D0ET+L_6I40V9?&@KcPTfFOa+Ng67M^:Q3IZLdO[G&X_0>cdH@HbG:=XRV;.
g0C>^0FEL6WTe?4.48VgCH#I56Oa+FX@b]1FbALON8;fK+Va:<NYR/9D@=R\0_I@
#.B+KMTdOcZF+Ec^/Cd6\A/_:OG?6YWV.d9H)4MTXQ93MFBHd:8O:[+c#MgE698]
QfId<K5G:GO<298_J2cQ6HS11X5JSV\.&Fe>=Y_>/LZ=@F&5D1M9?fc<Y&Va<N:D
-_L^QSgZ>EU@5Yg19>?XXS6XR#3^3CZ48_^]Q6)^0gA&>WDKJBW4M[]8.G(]3JY(
;DMSQN.1I)UXZcF\.Z\77J]P\_T:Le5Q-BT,PZL7YIAdD3GTS:(KRWM+H_Q4;MGG
Rg_H-9:2KFb(70_-6@@N#/20aDZC76,@]Q8NCc_,2[?JGg=H#O[]L_9eSSUL6Z?(
DGH9Ea<]@):DMZ_IT+ZgIGA6YO?Z+MI0#e8&#XR-cWf@5JHOJ5=TAF(::M-[-_MS
XQ(RN0M5H<DU&K&ANd,b(0=UU9\T7CEB+VfX4,bJN(6S[b-W?VR2VQ.UQ4PXdG9a
a=F?Wb#QUS9EZ(AHeTc(>GLT\E?EDMc\,bFNWJ.,H;?)D4=e3(EJdHZg,5(7U<^5
9)g/,J8LfWcA3SKLD&U6WYY<ZNC1KHeYB6\[)CMBaJ=]]LZ6cFQ_WA9R6UUAPES7
AHL?\(<33T9KNI0G-^N;<,I]S/b91REBC9)0a7ZH-TUgOa6>05DI;7c,8ZBb=R(c
Bc@H[USEd_[9LY)g[F,7PVdD#^ITJO-K5_M@<M(3\&DJ&Q[?>;HfH[CcDZE-(Og1
ge.(NKeBF3\NPAfG14.PVb.:\7++D94H_[ZdT,D9@S&WP:IQ7FUe0YK)bZbTDZ\5
@H\OI+)H>bg\@ZI0BC=QZ6(<BI;P6PZBC#<WZMT)ETK.FgUHS0T:9H4G/;1gN_^c
CCKEWE4dCg[;e5V0F;.f0Pb->f;FK^=HZJ#.A4FUV8]/IC8Y(#g8,E@/26T(TWU>
CKG[Y:&@(Z&&JJWPPCOEAYabS]&+=ETX6O957_9#_#S\S#e(&g>QJP-#<-(:D5-<
Lf36aVK1V1_(L\?)2ZPbVRQf8eNSc^O3&_I+W8#XW=5,C2/@Z16eH&&M791>QLBM
Y[9QR1\/=7TUBT=3)<;,^gV^6\[Rd((09=0/H,<b:T@aC4:c;Cg6V,eX[e2L)EQ[
E@HcgdM8SE[0TN5Zb=4E4#?N<S-P,/D9YI+)AI,()GaMO5c@]((e;e7UU-N\F\G^
++&4DcN4;8D<T;YEEe@;DVe?NaM^4+Sd.@aZ].&A_AJ5L?L@RC<+9XC8-5B_,+?A
&\,L@)UT9:34S52Kd8J\A<J1d(5LZ=gZ2X)bcH\B<AaL4,-(U)8bYF]gbH^C_]UC
-50EFJJN1,1f-I#.^X4g@9^I:JYY#4HRSfd;g,Z<E3?HVJL))A4:ZcO^Y^V@\(<c
O\c-<R3A+cBA&QT>b^P/6YL@T,B7EJO^6eJQF[7P99DGKQL@F,,b2f2bb3&6[1bf
;f/B?D@b/(,:SD+@]\M?3ZR+OLe4?EfDJa(9GN4(aMdY)X[4.f&N)>Wg)E+I.,/Y
Z@^LT07M@DeQ#H7ZWL4QS>V_OR7Z4L>0J&[^.DcC/5=6ZD9WdK4SB(T.8\8#NL5[
#\&c21QRST2-5ON.H[6ZPGP#F)V;;DCZ0WcXQPe(U9BXRSR0269dPUUfAOM;X@D<
WJ[&ZFO2gROI#,eMUd3e6D)SWY#EdRBJV.bMce&b))MbH@##P,4d;E@:e3d6/9RN
ANJb\T-.(K,)3[9-INC&a=#Fc@8dI2)[LU4B3?&d8O<e.gUdd-UEG@LWHUe\Z]GY
f-C:<BDUI&EHbMNSP>&./M>&RQdLF<5_=O@.S2<L^@WS^dM-_g24#^@K@AYCUPT@
PgbDF6e3Rc&:GN1MB1(_2=WKcIW32T)IPQN^<7N(Pe(V;Z0T^@J(MU<f<W0E&[=_
O(LE=K-E[WF,)A(5b-A16C=M2KE\,b>b/gMM7Tc9NG]KdK\b]>F1RJKU8]51&.=[
1L9,F-D1WZ]T#E4bPPF8dCNR(4RGCG34])E^@-R0K3NdO/0/28+dSdc4e]Hfc\8X
>c);^EC)3)BRSL88JLgXgF]a.7VP?>N(N4H>HJ;E&\OF4BT@URSK.)Q&+L(LD/D]
LOMED+,IBa9B8C?Q(_LRcA6CI.7QR2YQ.?FP;d[#gV^4EL5#a^9f5c-^@cb,:.dU
RJ-UU.B;gHdG7WW\1TaPRV8E1.GZZ26,2I&0Ng8/HE]?38:&WIC4[P-5C)>SP7EW
:0CM[_D?;/O;(U2UQGcU+Ra-MU/QR;@5+H<_/C6b?=Q_X.8g]0;=X#feD=3XccE?
;)9dK,OfS6K>dCO:7:O<XOa+VV9IPQ[QN;)2-fG;C@WVbYD5_2d:Q>KNJ>86fWFL
43@e?)HBH;7<G+6NW+GU(Qd]9V1L0H10NXJ3De:LWAE27PRE+?QAcS8c1I-71>_D
#GTZ:7)D=fR?&1[O#8D48ZfFBYP/)M,Sb63UOMU&J/OZ\d\V234[>#XXZQ6N.c_I
W5KX+U&S^0X^,JdU&DXAP#8\IUaMedF_C8-[(VNAUX@Wg.DWW(D,.aLED&f830b:
,K@<fdf:Y<JK/>:J/74VffDIF)FdG@0D72[\HQN;Gc=I\\(PDB2f/UEYB<E8T1E^
I47BF]0@Q\b-ZNLM:QKZeC_QVQQ\26B/VLV&P0Z4NE#PX][OE.Y/Xa3(agOFQNNT
Re)P7RJOI1_ODP;b)@Nd,8)9WMeb0bD[?b6Z[0CCRJTN08HQ=;)Kc.OB?+9>GWMO
<EeZD0BaTDYU_).#MdWVHK?LVCf0Ab(_CW\Ua</@56Ica,90(KR+VUZHL;e]T@0S
QTHG0@U]2J0d<Z3Bf\c&B=OL7+S2e,_4.&(45=[;G4EW6g4JWJCEWPfEKcg6;FGF
+/#??&4f9/;/[#be]G2/I8B<0#BeGI3LXCC6O>D>CKNF91a]B:&1?M?]C]\JMD/3
GXGXeY-N]R1ZTNF^@WX_^+S(1KD,d0IAI/,]^?G.ZSfC-8KET;SeRdPVUMU&WYZ1
9OcU4,B26,LT9<UHN0QSUGU?8+-\#g@EEF)\P+@0:]]Aa4FUCT/ND>R:Q8+?8?BD
7#;Ve5gUa1YYELOSD+MO6,EIY)^Ea)ERHbWD4-HM[4W<LcIbNdK,__Q[BZQ5@CY1
G;\0&<dYV3W-9&F-E;@,9QSH3H^ZHX^,f@&FBSeQY8:)K]@,=e-0LG(BK>92Y3ZG
8HDf>>fYXL:)ZW<Sd;\I[@U?/d?d:HHabQgcV6+cX[1WM4.7;DC=BN(_c]S^cTSM
PCKg:D3@4QNe_^A72S6@/F(24>>8eV6aF>cIQ02<YTEI0EfASPEdCg82UL=3@]4/
ZO5E(J?X&8KH_bFA[)2aA3UOGQXY?VG(ET;HHA&=Z#efaTaG^.gPB4/])ed;J+\N
(?4OGG_4_IT4=EJQg[KYY&,PO#BKA3))^N#J.-OPg4Pa;=&Q]GPJXgd8WOFPdA++
@AbF7JX5EBC5G):CgA66)&9L)^[[>0_;1D:NK))e]R8X2bFMY@O;[KTa-V01fUWT
+J\X;]^cd2Z9^5cR>86JZQReDY64YB8;N]Ob,;b\OPMIBTLT6JI#_?SPeL55=OW1
Nb?WRb5cKcaS=54[W6ZM=#4LSL)?=S3X_1X2AAgZU)Y,EN^4IA[;5L&+=^5dBEHN
\._MH^>M:N2FgRK^HB&CS</X,\B5JIEcM2OH@9)-K;X]PNa-]>U&52&QBR(NI5&)
J?aV7G:688MK+NF?WXQ=45Dg=b[F6g+SW)7T6S_eEb>5(&5:L_0P2f7f:_5^G][:
4GG(>\P(UXa14>H]IC)DJ#P2Ad@6Q:90N;6A2Lb,GSP0+ON#<?>M4,Nf>(;:QD#a
+H_L#-&VP[?>XS_88#6fI>^2C)@.?_]d.[G(V8?=.;30be^E4e;W)Fe=-CR\D:^_
@.a;0]#XTb#OJC].NG4<H]C9C1\T55(,(8ML_bBfF;b//1N]9<,SgU4NZP9\D6#3
-H0H0T&=]A7^):\>XFBQTFfO4[(XI#3.P9:X-;.8@f6V,+EP?E712RdG7cRHI@,J
H6_-8)4N(88,7Df\QDM7&3.cKCE?f+X3b)LROY8D9YS[P,b,X14V=AZEJ,GcH)3]
R-<?/))>>Y>TU#GS<EN/&O^?M0C(H;MQ[NI<I);YM>#SS@YdEPXTF[DeJ&a2:<H2
+>>(Dg3Y5&aTK)YcHP2HQ3\C1YcZb\KaQJK8K07LU2eE.,GJH0TdSdXT3U4LbWN:
J:9=KH+&<T\<]RSgZeLWfdUQ<0e]Qc.KRX>5\IBW/K;X,ZOC@7C-5-P9f:]/F=G\
O4>/1/NWf)7GYH:Qa#NSJdHMadF#I^BG1S]TTV0NP:E]&DQRI0S&&B<=\&49N[Yg
J_ZURAO(CSMV^]VXFaO(SF<1J#:(-Z)M^WEQ[X?+f60EEfHbfYU?9(J.Xb<^Ee>c
=4+WI7OS=/2C(gDP?LITF_UUA&XIJK1.LYJ7@,BS/K[E>JI]_g[&?N_GJ&#MCaO0
cFAY9J:\:X;,<Uf&&Zg9<a?K=VbKCD26B-=UI18f9Rd&0=10<0:F9C+\fJ4H\:;4
AC?98)eS8Ee=Id?BcI/.^-;,M<b#5PWff+8U.7V.(P09Ve(LUO5/<MgL>c7>[93a
WAW?MMK5MCC\P(3cWFdFC,H.KQEg(FgI5f^UY:69A<0/B@^&_^TFaI@DA:8\+IUI
M53#BfY]K\.]F4JXX2<-@PPU3W,7[,7&5#1a\Xc^gJG9UMcH5NA-9O>9^ge/R\7L
N;MedE_/WX?aQRf>Yg[Q&:MDD3AUBN227,X?FA,VVE_Va:JV@&5Y>TN#S./g;1HC
WVd+M+C)]&(#\=g\G3HU1MHS_I86LLO@WH+78IG/K+B@?L4.GT]86[LO[&][^QRc
2^)Yf:->[^,1<L1@5@W=^BIF9PY_YU(?25TW](XDIM03J6@V\[^&3YTKXZ,Y2V-c
4d/Ma@W_-6_4[<4gTdg3(.[L<(c_86Y&=/TA]F.JD7.22Z8LJe<J1>5Adb)Y+QO(
4B++<6-g3_3#;[8Ge7e9Ka/7&[684Yed_IAVZ2\Z97bSc6]0#QDJT;?^H@PD/g(d
YED/KbRa;YGQ\[C3FdM[5?>N.FH2I4&1A-S-^WXH#O4]:R+@@.):11#7-DB,+O82
BG#Z07/QF7H&H>(adWB_H#QER=Y3)WR#3XDbL<X&EWeJRO+L=LY;_J1>9V,8KG_L
86>JdRIEI^,6JIN?FNFaLA3^YMBS](6<0A>Y,@OP=.?,S/127SI\\)P\DU7/BOU:
V6R_<ESR<a-SZ,(K<1(YM\eP/41\<4WJ7=2^[^_:-OV_F&,V+1<d@#3E/:@DZA6g
+3(2K&f#dBT82_3?88;bD85U0gaUNW&M?4_=g(ecd9&:2_Rd+TSDCAVQg#(b)Y@#
e.dETYG/25[X\K3<C:Wg@CCLE_C+=]^7VRD#3U3_\J<+=d;S>>QH:I4SW]T__2NV
e7WV3>GSa)LYeG&8#/];7Yd1[V29?0#UGJC(]SIR@USf8V@EVTR_,B]AU?Of]CgA
e4KXIEBd+,.3B@Z0Zf]1Y]5N^O6P#&8=(,91_^g:&&:3?B_#K_#?Q+GZI/c>K6@A
LFNe[_@3D+B32D^A(62^&^.+b+6C_d,D0Dd?a\8S>4N8F1U02._#7XG#FgJdaUQG
B2WLSB_73BX9=B2;V^aZ.=@K[J_g_99R@LXVg54?d>fO;6S?^V&#^Ua>NNOMVH;L
J+WWGR8N=<d?U]A<c^KBL(NALe3G9?OH+88TD^V,U:8<c374DL+YGRA:3<<;SZB7
[Ke8H4d3cJBX^;4A)AcEO=d/&(UWQA9f4fADV?S>9;9ZF:>:/@Le9@.Pb,8g7.A:
TB9T0Q671<_5<4IG=EYVP;d;@V:H[U2)_5,F=Q6OZC/)>J?W,b1O5-X]Je_A7@\9
#+_F=K9ZAZRJ=I;T#12#3:eG,\]4+-/?BASSARbEALMV(#1I<0?MMMFKN(944(73
ML[&Z?Mba5dcc<_bT?-:Pd3F,+J,&daJ]]/K[N1?1PL9O43g0;RI5[a=;^T_->Ag
fMP;a3;F2?e=Sc;0ZMSbSFGAODVK>@8L,Pc.JFd<8,&=e?G[G_[?V^&\g_S,S;@7
4dAT\59(NT/HK8fgF)J[\agCE5DKf:R];\#F;:I30HNFFc)3:3ad50WF46;(<=2+
\ZR9;ZS\/8J5#+LU+eSAP.\ZE]R3e,8C.X:NW^47D\bG1CLW)LM8L1B-,aafJV6I
fB(GceVHfI.6]@VQ+;0^@L_;JV[@eV949^E<RH;M#^]eX1?:U=7,C=2>,M3AOd)E
AcGA]Z>8Xc7LI9Sa>Y<;cIRU>gY_^9+-M#?BBaNBN+02a>GI?)>N6OG50&[8)g4/
(W4FPe#U>[#cI.M/B-MN.aHV_(a/I79A=\WaZOe?YU?GG__bTS+ETP:G\eW<].]=
J=CNbcF()J2P<59;M;RV0YJN64:+R>UAMKg<;/:_K@/D^JWdI67YX?P>?9N@\AA3
#FWA8L/K0AWE+F/\U+YJ(X#Ue_.P8ZI4I478ZV,B(D01,\IWDD<(WY.CYI3APBCV
c)R>S),=ZfHXeYg5f>5,TbaR]T15:KHST:CIYW?.Xg91;9HIR.,FD5#G):gcW\IH
G>U6[dLBBO>>?W:(UE#+7?\8;WagZ62Q;T&=+,EN27D=d(Df,eG#<\4/,f^+R]EM
3b2aH9:eeCIcFAL.6;E=eWY-gXaLVKHF<6DbP>EdF^.YF9b0#\aJX\;?^-OM4g8a
9+d6U=E^ODBS+KNY]01#5:.DH#3SJ^6T&>8,?L-L\]5K9E<-OL7]42K\9^+<#LS@
Fb1Q8I?M?/M3<NJ11UQDMA(^a9Ne1QB2^);ESQ3:KJ(5Qa+S=YQHU(5XbESHbS1f
SR<(aC5T@=#39#3,P)F694gT.g8BaVMROCPaOSaf/UKM@@,^&TJO_)_T)5\0/ZgL
E,?44LPL^\L>OLO-A/eScC/QSLGgLH.RdKI)L5fM2D50)R)Y(A4V6U_1fNFf(:dS
T?\<9,2)I)H3S/AdUM4;ZPG\31CfD5Q9X2:@:#Df(MCTNSF.=A]/D];I>QBI:(KJ
9OHB51aF+B\49>U-PV:O<g75.[F/ScF#D.5C(.BXCUa\c;C-3EXXf[NJA&Y^25VR
3U:<3KD-L:FKYBVNS^(<&K.XB=,]8O0+-gSGN.YI7:#O48&3=^K@7bN8#RaSWHDX
#;;==N0[X06)0ZAW=5Oc##GVed2L.FOca+4dR;:)9#2J2g69Sgf.cHJ6YVDC<48c
U+OQ@O:[GBYGcVB4A+I2W;</@/ACeH+#1<=E=4:0[V6;/+Zb67OR=84_@gc6dc1^
>.5e6U#bPB49-HL.4<B(VZYFbF_+9Q+=JVgG&V7JL7#4=U1:@O=&a1V^H(Je#bLN
RaN@G7g#1b>Ud=SdIFTPS1T)1GWE4ZP^3=R04e>FfEc\fSIKb3UF<_J6Zae5OO@c
<d>-eW>GGM2We3/,LWZb4MJ[CZX+4I)@U4dY96]ZRb&[D-K&8U9PFS<gT,VQ_]=M
MO516QQCVP6OZ.]@Z?\O78:cO.8,5(<FOMY2@BFE0M-.2;>U@_O)-]+gf5YQN5.W
60a(UgQ##__4=\Y3&]IO:NRc#aNMAE&=Y,=)OF9?L7@^;.278/.Ob=b3^W)C-XX:
:XEc()3.KWZ[ed6A:U020VgH5fFF/-GB;MH+_AR1#U9(bZ9?>W?ARPJ[_MB2<BMa
O=YDZPI@D<BGgOK[9ZHc@^\_+VHe+Z=9A65,2Oa80FN(9WP4I/O(.DcJ#6]SOC(K
[L4Tc>F#U.#,<61:Ue+&7YY_#A9@>PQ:cUNT_DD,b<)P].#<KT3_aKOA\CeXaa:=
Y)8e=f05a+Ed_1@ePGSXHJ@UV@WGU&W;ZHTfL7S9KQW5;NAD(.dYDUYM3@:.>29_
WPC]P:#JCRREFDQ2J9.3K0;?c\c#K1^<9;?:KJ,QM>24FTFK[6e&[O8-\KX;e;#O
)AXE/cI@RFFRD\Wb:8:ad-22:XeAD&e6eVHR>@6F9[;4F$
`endprotected


`ifndef SVT_VMM_TECHNOLOGY
//------------------------------------------------------------------------------
/**
 * NOTE: This method is left unprotected in order to expose the PACKER_MAX_BYTES macro.
 *       This ensures that the proper macro name is identified when the macro has
 *       not been specified in a multi-step compile situation.
 */
function void svt_configuration::check_packer_max_bytes();
  if (`SVT_PACKER_MAX_BYTES < get_packer_max_bytes_required())
    `svt_fatal("check_packer_max_bytes", $sformatf("%0s_PACKER_MAX_BYTES set to %0d, but %0d bytes required by the %0s suite. Unable to continue.",
                                `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), `SVT_PACKER_MAX_BYTES, get_packer_max_bytes_required(), get_suite_name()));
  else begin
    `SVT_XVM(pack_bitstream_t) bitstream;
    int bitstream_bytes = $bits(bitstream)/`SVT_DATA_UTIL_BITS_PER_BYTE;
    if (bitstream_bytes != `SVT_PACKER_MAX_BYTES)
      `svt_fatal("check_packer_max_bytes", $sformatf("%0s_PACKER_MAX_BYTES set to %0d but %0s_pack_bitstream_t only contains %0d bytes. This indicates the %0s package was not compiled with the same %0s_PACKER_MAX_BYTES setting as the %0s suite. Unable to continue.",
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), `SVT_PACKER_MAX_BYTES,
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD), bitstream_bytes,
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC),
                                  `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_DATA_METHODOLOGY_KEYWORD_UC), get_suite_name()));
  end
endfunction
`endif

// =============================================================================

`endif // GUARD_SVT_CONFIGURATION_SV
