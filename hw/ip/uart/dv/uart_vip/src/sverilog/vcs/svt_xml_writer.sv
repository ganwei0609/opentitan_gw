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

`ifndef GUARD_SVT_XML_WRITER_SV
`define GUARD_SVT_XML_WRITER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class which can be used to open and manage the interaction with an XML file
 * for use with the Protocol Analyzer.
 */
class svt_xml_writer;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  
  typedef enum {
    FSDB = `SVT_WRITER_FORMAT_FSDB,
    FSDB_PERF_ANALYSIS = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS,
    XML  = `SVT_WRITER_FORMAT_XML,
    BOTH = `SVT_WRITER_FORMAT_XML_N_FSDB
  } format_type_enum;

`ifdef SVT_VMM_TECHNOLOGY
  /** Built-in shared log instance that will be used by the XML writer instance. */
  vmm_log log;
`else
  /** Built-in shared reporter instance that will be used by the XML writer instance. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** VIP Writer instance to create FSDB or XML */
  protected svt_vip_writer vip_writer;   

  /** Handle to the file that is being written to. */
  protected int file;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit begin_pa_xml_done = 0;

  /** Flag to indicate whether we have executed the 'begin' for the xml. */
  protected bit end_pa_xml_done = 0;

  /** Additional controls that clients can register and access during generation. */
  protected int client_control[string];

  /** Holds the uid for the current object.
   * Added to support backward compatibility.
   */
  string object_uid;

  /**
   * Register active writer when created, the string value is the 
   * component the writer is associated.
   */
  static svt_xml_writer active_writers[string];

  /**
   * Register active configuration, provides a way to cache cfg handles when the request 
   * to save a cfg occurs before the creation of the writer. The writer creation then accesses 
   * this cache to obtain a handle to the cfg and insure it is written into XML/FSDB.
   */
  static `SVT_DATA_TYPE active_cfgs[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_xml_writer class.
   *
   * @param prot_name The protocol associated with the object.  
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   * @param file_ext Optional file extension.  Only required for suites that support
   * PA with multiple sub-protocols.
   * @param suite_name Optional string associated with suite name of the protocol. For
   * suites with multiple sub protocol this value indentifies the suite_name for the
   * protocol. For single suite protocol this field should be empty.
   * For example in case of ddr family of protocol where the protocol name is ddr3_svt
   * the suite_name field value should carry "ddr_svt" and the prot_name filed value
   * should be ddr3_svt.
   * @param format_type Optional file dump format. 'FSDB' (the default) writes out data
   * in FSDB format, 'FSDB_PERF_ANALYSIS' writes out data in FSDB format optimized for
   * Performance Analyzer, 'XML' writes out data in XML format, 'BOTH' writes out data
   * in both XML and FSDB format.
   */
  extern function new(string prot_name, string inst_name, string version = "", string file_ext = "", string suite_name = "", format_type_enum format_type = FSDB);

  // ****************************************************************************
  // Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Get a handle to the file that is being written to. */
  extern function int get_file();

  // ---------------------------------------------------------------------------
  /**
   * Registers a client control with the XML writer.
   *
   * @param name The control being registered.
   * @param value The value being registered with the control. Must be >= 0.
   */
  extern function void register_client_control(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Retrieves a client control value from the XML writer.
   *
   * @param name The control being retrieved.
   * @return The value associated with the control. If control not found, returns -1.
   */
  extern function int get_client_control(string name);

  // ****************************************************************************
  // Protocol Analyzer Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method opens the file and writes out the XML header.
   *
   * @param prot_name The protocol associated with the object.
   * @param inst_name The instance identifier for the object initiating the write.
   * @param version The version for the object, typically the suite version.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit begin_pa_xml(string prot_name, string inst_name, string version = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes out the XML trailer and closes the file.
   *
   * @return Indicates success (1) or failure (0) of the request.
   */
  extern virtual function bit end_pa_xml();
 
  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML header to the file.
   *
   * @param block_name The name of the block being opened.
   * @param block_text Text to be inserted as part of the block 'open' statement.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_open(string block_name, string block_text = "", string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the XML trailer to the indicated XML file.
   *
   * @param block_name The name of the block being closed.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_block_close(string block_name, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object begin information to the file.
   *
   * @param object_type The object type.
   * @param object_uid The unique indentification value required for relationship handling.
   * @param parent_object_uid The parent unique indentification value required for parent child relation.
   * @param channel The channel of object. 
   * @param start_time The start time of the object.
   * @param end_time The end time of the object. Added to support backward compatibility. 
   * @param status The object status.
   * @param time_unit The time unit used during the simulation.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin( string object_type, string object_uid, string parent_object_uid, string channel, realtime start_time, realtime end_time, string status, string time_unit = "" );

  // ---------------------------------------------------------------------------
  /**
   * This method writes the object end information to the file.
   *
   * @param object_uid The unique identification value of the object.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_close(string object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes child references to the file.
   *
   * @param object_uid The current object uid.
   * @param child_object_uid Child object uid.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_child_reference(string object_uid, string child_object_uid);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a one field record out to the indicated XML file.
   *
   * @param record_name The name given to the record.
   * @param field_name The name of the one field in the record.
   * @param field_value The value of the one field of the record.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_one_field_record(string record_name, string field_name, string field_value, string prefix);

  // ---------------------------------------------------------------------------
  /**
   * This method calls the 'svt_vip_writer' API to add the interface path into FSDB.
   *
   * @param if_paths String array contains all the interface path.
   *
   */
  extern function void add_if_paths(string if_paths[]);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a name/value pair to the indicated XML file.
   * This method is added to set the filed name and field value to the
   * current object to be written to XML. This method is used only for backward
   * compatibility where some clients directly called the field value writing.
   * This methods needs to be removed once all the clients moved to new writer methods.
   *
   * @param name Name to be saved for the property.
   * @param value Value to be saved for the property.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_name_value(string name, string value, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name/value pair to XML/FSDB, the value will always be in bit vector
   * converted to right data type and written out to XML/FSDB accordingly.
   *
   * @param object_uid The unique identification of the object.
   * @param name The name of the field to be written out.
   * @param value The value to be written out.
   * @param expected_value The expected value of the field
   * @param typ The data type of the field value
   * @param is_expected The bit indicates expected value is present or not
   * @param bit_width Width of the field, in bits. Only applicable to fields with
   *        typ svt_pattern_data::BITVEC. 0 indicates "not set".
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_value(string object_uid, string name, bit [1023:0] value, bit [1023:0] expected_value, input svt_pattern_data::type_enum typ, bit is_expected=0, int unsigned bit_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * This method writes field name and an a string representation of associated value to the indicated XML/FSDB file.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param name Name of the filed.
   * @param arr_val The filed value.
   * @param arr_exp_val The expected value of the field.
   * @param is_expected The bit indicates expected value present or not.
   * @param prefix The prefix to be written in the begining
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_field_name_string_value(string object_uid, string name, string arr_val, string arr_exp_val, bit is_expected=0, string prefix);

  // --------------------------------------------------------------------------------
  /**
   * This method is added to retrieve the uid from the PA XML header string.
   * This should be used only for backward compatibility and not to be used by any 
   * new VIPs adding PA support or any update made by the existing VIPs.
   *
   * @param object_block_desc PA XML header block.
   *
   * @return The string which is unique ID of the object.
   */  
  extern local function string get_uid_from_object_block_desc(string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes object begin block to XML file.
   * This method is added only to support backward compatibility for existing
   * VIPs, shouldn't be used by any new VIPs tor existing VIPs updatingPA XML support.
   *
   * @param object_uid Unique id of the object for which the name value to be written.
   * @param object_block_desc String holds the PA object begin XML data.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_object_begin_block(string object_uid, string object_block_desc);

  // ---------------------------------------------------------------------------
  /**
   * This method writes a comment to the indicated XML file.
   * This method is deprecated shouldn't be used in new implementation.
   * Added to support backward compatibiltiy.
   *
   * @param comment Comment to be saved to the file.
   * @param prefix String to be placed at the beginning of the output.
   *
   * @return Indicates success (1) or failure (0) of the write.
   */
  extern virtual function bit write_pa_comment(string comment, string prefix = "");

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #begin_pa_xml_done value.
   *
   * @return Indicates current #begin_pa_xml_done value.
   */
  extern function bit get_begin_pa_xml_done();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the #end_pa_xml_done value.
   *
   * @return Indicates current #end_pa_xml_done value.
   */
  extern function bit get_end_pa_xml_done();

  // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the predecessor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the predecessor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object whose predecessor object is to be specified.
   * @param predecessor_object_uid
   *          The uid of the predecessor object.
   * @param predecessor_writer
   *          The "svt_xml_writer" instance with which the predecessor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_predecessor( string object_uid,
                                                      string predecessor_object_uid, 
                                                      svt_xml_writer predecessor_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the successor object 
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the successor data 
   * to indicated XML/FSDB. 
   *
   * @param object_uid
   *          The uid of the object to which a successor object is to be added.
   * @param successor_object_uid
   *          The uid of the successor object.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successor( string object_uid,
                                                    string successor_object_uid,
                                                    svt_xml_writer successor_writer = null );

  // ----------------------------------------------------------------------------
  /** 
   * This is a wrapper API provided for clients to capture the set of successor object's
   * information inside XML/FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the set of successor data 
   * to indicated XML/FSDB.
   * @param object_uid
   *          The uid of the object to which a successor objects are to be added.
   * @param successor_object_uids
   *          The uids of the successor objects.
   * @param successor_writer
   *          The "svt_xml_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successors( string object_uid,
                                                     string successor_object_uids[], 
                                                     svt_xml_writer successor_writer = null );

 // ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the identical object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose identical object is to be specified.
   * @param target_object_uid
   *          The uid of the identical object.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_identical_relation( string source_object_uid,
                                                      string target_object_uid, 
                                                      svt_xml_writer target_writer = null );

// ----------------------------------------------------------------------------
  /**
   * This is a wrapper API provided for clients to capture the identical object 
   * relation inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose identical object is to be specified.
   * @param target_object_uids
   *          Set of uids of the identical objects.
   * @param target_writer
   *          The "svt_xml_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_identical_relations( string source_object_uid,
                                                       string target_object_uids[], 
                                                       svt_xml_writer target_writer = null );


  // ----------------------------------------------------------------------------
  /** 
   * Retrive 'writer' instance for the given full hierarchical name. If the writer not found for
   * given full hierarchical name try if any 'writer' associated for 'parent hierarchical name', 
   * if found retrive writer and register 'parent' writer to given full hierarchical name 
   * to enahance performance for subsequent retrivals.
   *
   * @param inst_name
   *          The full hierarchical name for the required 'writer'.
   * @return The associated writer, if writer not found returns null.
   */
  extern function svt_xml_writer get_active_writer( string inst_name );

  // ----------------------------------------------------------------------------
  /**
   * Method used to get the format type of the writer.
   *
   * @return The format type associated with the writer.
   */ 
  extern function format_type_enum get_format_type();
  
  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a scope attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @param scope_name The name of the stream for which the attribute needs to be added.
   *                    If the stream name is empty then the scope attribute will be added to the 
   *                    'parent' scope. The defalut stream name will be empty.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_scope_attribute(string attr_name, string attr_value, string scope_name = "");

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a stream attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_stream_attribute(string attr_name, string attr_value);

endclass
/** @endcond */

// =============================================================================

`protected
f7FG-DI9fL=a?gZGbLN,+ee2GB645K9g3=L[HFXD[fd.AV8#fTM>3)+/WQOTPTLR
=C22+gEVg=>a#\&4P_>H+N-#/<Q^?]aZK-H7+L,7GR1>dgD1\GKTY16[B&XT#AAR
J1#=&NF]MI3PEIa5VR=[Y/fE8NOX?&Y5@1WcdO_\4O(;@.D)R[:S98]&C^);NK0[
:NC_I7/;,>H:1\C:VZFJd2K3;&/O4J>cKe^<e0>Q&]abWgdE1?QJe3[N>6AEV6ZR
EHLCeJ#1;bZ\;<&DR(NgS3O=2ZFX8X#0GFT25d.Q]8Gaa;PTSbKP(7E3eFY->LRJ
Z+<UgPL8O:OH9#N\^7E27:?YWHDVe)0VV@FX1+DNP_0/fMIR/;1U/RCT6HgL/T?P
#RYRU?U)P(D5E;OB.HB=<O35LLIWQ[ATUQ3\JK-8fUUXS=ASAJe_H@AJb92ZBW8O
N2Z9-,7aXG6VLHUUYM=+ISOGU>#V4d-Rd0dSS>[RX[=NOM:8(eV6RL5>Q&]EH]DT
/PVW&L_cL]AaY0HaL,78+ZRT_RO?CK6_0e[KB@@=>fA&V-@UOf-+T;=<U1@(8PNZ
&VG5a#O]+>M5B8T_2POY7^&94DV(?_/KaS:),.Q#fLb\.[YC.J_X6G+Af>3[F5-H
?2aK-B9TJQadQGg6a-T+IQR9]2=/5d1BX#:cNe?Q_FDZfBTMAbVK)=Oc.(5EaJ2/
?dWZ+=fFbIa?QO9,d?c2fQc\Z><:+)FZYOdSPE&PH?-ae9RV1MK8Wg-QN/J[6>=B
YR365<>S9+FdZCT]))]=[2[O/QJRbOfd&DHR4&0UUJL<2c8&AP]gF>R9EG5U2[??
)T_23[(;GR35WY,DKB13D2BP-/5gF6AH#N2EcgSJFC-FGP,MJ.=O^<MHAN(O7b6)
WRT;R7L06O[dD#JFe=Z4H/Zg]5C17;AALf4^QCe@OBPP<?(NDMD\+N4K_TKR#CI#
PJI0+CTDG_>)g=f[bJ]UISOef9V[5C+OR?\ETVHT8V1U.)U09X><ZBb0dVf4GCA3
OIKU5N+(1_STLMZH#L?KWP4A0aBB?W9EDKOB/a8>74.<&<)#_cg-fcV8[4f,RZ/g
D2JdU94e(4L,5c=,YWQ5B_KYX9CV,NIb.Tc_N80W(707BU;X3EX@17Yb,QVC>3_;
GeC>dS+J2GU#Q1@PP.F)M6\SMTQ+_3N9E>1N3UKUGYbUFO,2e\P8#;3CH9d>ZeVe
.YG@DV->gFfHXd4^_DE[GN2=/A3TH+M._&dcL91+3.JTNYG[Rb;gA.0]3[8e6XN2
1&4(SMSS]b>1>[-Ua574Sa61VUCFMM9[0<UI>X\GcU&N[0B__Ac;^1(1CJVJ3AYF
BHdR6@_CBBfN[ITET_Tg#(.XYR-2J518PBAGTMf13+WK,R_VcCH+Ef4_Bc#N^3W/
2#(=/dBD@TPD03,CNT[gA6FX8TU59^>BJ2\5/YAK@JO=cC8Cd@Z_)<8YMHVd,[^8
Y-A>\TQYF(5E_c?=63I;2^H@fJ#4>;U4#WT_RX.6D8W/?@ddTLPQY9V[CR59LAJe
=Z+N)?1WOebVdaPX_H:CJ9RFFI6/S03cNQS+Ue2;5?A.>N\O&ZX@>=^Qb).#Kf;]
YW2.e2JeL?>VF<ddf[6H.8E<>M-g70@77JSQG-T_3OUZ-:N5:67Ye6fdQ_aVW_CX
&60^I9;S#BFJBbRfT.c5<:D+a+E=-M\b]JB<K[@9K[bUc\2V?T=;G/V9URC4,_\f
EEa?ECK48JX-?+CR(HE,/.L-[X45SOI/21Id<5R)D]8\BHZegTc<(9K=JOb]8\2:
fc+\gffg@a^b=;?c[@.\17gRe-GeU/5&?^=aH?)9cMZ/[10ZX(8V3SC_IFfdH0DS
.JdJB,A^AVcgJT^;-42D<[Xf]K37YE8X<U-7[A<9_M8QdO]]^CJ05D=4C33D<92]
HMb4S9XCVM5KOM8b;5g&+BC_&BdAB]S(H?6g]EHfSD\ZZ5=/^/A7:0Jd\YO-NRSH
CQ,J+5A-FdT=IU-9/<8O?J@fCP_8aHZIY+:23U/DFHQJG(f([7Hd9INZXCd[6gX-
N-U\LO/XD[cd>9R5>O[^G4,2U&DaV9E-_/,50<M1HK-,.L,P^&GGfZL8:M?cg=T0
2g0,L25)bZ#P2P1T=NSR]f<YU-+-/)ggFHX;^)=-IZ2+D:ZQ/c&]E3dG&W<aH8(O
6EO<_2PFf-1<([T&]XM\/dI07cAFe7-,FebIfY]a(9^(8HV,fR[YJ/E8:W4BY@NN
d6/J7EHE\,e5;?^KWW5GJ2WY,W#?C7)HS<K)JSY]@8F_1BH2RDDZ(8KO8bc[Je]\
/OdFJZ[+SbACT2:5RcP?-\#eB]98Y-LFYZ,R,D<-14dBH1T\]@<;4L:6W3[F+LV6
&],0(M^OK8/>+eRP[c)HE<RF[+P?O?a1.a_.W/7gT=-992LUYKT=>Ce-4<6)Q,=X
1#7>fV[(&V>]<4f(5C=DZdS6JL?2g#gdCD\XFD@CVB81I4S\Ie0MM@4dFCEYgDd#
ML6GF:W\Y--R1G,U2GBe#6ae,?2C(AW(bT,K8LZ3#eY#&S^#:)UB&VI9_WX;f,I+
ML32[/PPVV1#X+a#83N=_XKf(FSY1YfNdZ-(SM;aYEgYaK-MSKN.1CSK.JJ^&.]#
U<Yf+IIOCfZ<BA0=W\d]fXUcNSaBF=J#6^9a#aAUH,,NH9\4(A+2TEMcGe3+=N[6
[d=7@,fL]EEH0G]X,[??O/[6NL?^#8L<,,+gB)6cZ0DcQ=ZL8JYfMa/T,CIcALXS
Qb[\ZN^52e]#\a2a\RT[<fG\(3S@2KJ>?@TSD8dbR1;H>K5fZgf,HO4H,>+f(E5Q
;FJQCQWa/U[ZZ^TL;B3?EV]S11>S_\DMbf+K[4&[O@?e2bF>[\OTH2(BK<aeVFWa
Y^]=LO_&2TXV_(=-9=A<RZ_BafF4.HM)#F@MK-USf_<6?K.I1e,M;9;87d>d[Md&
DS>fXLfa855.OS9cMb+bYNS3dTdD>Z/4A4C;DGO32HP^N+[&[YUQ/6bNe./\H6e#
;4f,@2/A[8+3;)KHU6\bX\+A;g\N^AV;C+dKKJ,)N#<[#)Sb6;+8(U,)+?;^\[D[
^TIFRCcd76:)WV/aT=Q,^OXK_2BJgWJ^>:87O\Q<fc;?E3J#UDV4X4dO+3HM>Y33
f0^JND-BbL61OVB&ADEe7838(+Sd5P^W\X8EB]H0N4G@&#8#+dBa[J^JGQ;M&C1I
<1+ZR;#[Q+#@L4_AeXSW[N)RUR\J3YF+?A@>5f>?EaIS0J3N8AK?ET22F;]WKYK)
?H7Q#8C.1Of&:MQ8(e>;Ra(de4FF/7IE\IbNf01eGD(#NGKf9e9VdI5<1MH6<6[;
<YFf[Gg2Y9bH&-e@?D=KHT4e+YPL&O@EWIP(DWWJL&)IHUIV/9LTaB(;+-82D7WJ
-b7O<J>((Z0DRdFIA05J/_H8H].b?F&#b>Ke>>GX-0+9A1Q\=&Q&D:?\8d)c.1Y2
E,:a(LYT^6fGPW-\<McAJ6V].Q.HLIX<a@L)734Q<ADgHcE)g6WK7dIFK;7.5VHe
fI-GL2#M=HKT6c>A1(/\17WCeR&MU(53:fb,3F)5?RF3;13V+55=cA/:RR&;;#gI
<6\Ra&d)+>^AX<A2+3-V>TK1#7[^[+_T/@@Y(&d14[LTEO3c^LICCg0IfTe7OQ1X
UH15[.2Y[@4R].@6:<];#OfNG8@8Q:&_bT_Ye?07FG0=#fOQ0XSKdBeH/HgcON):
KYM]:=)IU]4B.[X&1gZZA98<0UV5/7WLfRA.RIaHZ&/6M/5-[GMWA1FB6#bJV,=a
G>WKFT;9MFc-OKa2_7caX2H0S<8(AVb>8_.P_e5_[0c6/J@G]GI=2Od]bg(ENG[L
b+9If/)XACLNOeIFPE3aX9VEZ6-baQ1eL)fScWR2_GPY4-K>O73@\_[[STANgG)U
FK>085/CIAcX_<JY9.W^a2HRS&>)gHP+O96#cgA#I89N@-8UW10aTBI:._E+(a[M
ORNg@faH^/\&M;g+5<e/dYgd/cC1?TY0>\\LMN#81.XBVZ7)U=#O+c/V_S@c0eEN
eI1KaL<cAdeKU;7E9.VJ_MWY<UVeG+,IHI+D=7aO66\RE(1b1gRRSa1=.e)]gQ[,
&R[#3HgIVV>4^4HdPF#ZG=BPc63Sd5g=G]b+17R3Ug8QdZ(W3IRVOg72>G>6JYW,
:.CM4EC2dfUV-[AN:-(\)+@-O4K-Y>Fga]b/b4TAS-GJ<?df;4Rb8\19@8^]b5#8
04aA:)[349eXGgWQ:P6VD<:bZaX7,\77=>^B8W_<=aa0GI<RE;N+]gZL/H?]G&)/
76S)?VfP/Ie\>f@78Z(;^M@]?(CO^<I2)]KRG\L^]2Y]B3_37P(DBG\<_-)_Pae9
#DfLa()aPUTW,>QUR1<Hg[#?f4KYSD_Ud@#@f:7\2R?:F7482a#TPb3FR493J4dU
d_9X-G/K(X?Cd0)gX\SXPWc0V8a63#MLffOPG^ea4+5\GQbE0FSY=3)0,1(F3AN3
fX37]B&WK.OgTfg09[JDPYPEPO;AFRVB#06e&61<.L\PVKQJ(=fM/CaK;1^e^.DC
-&3X1f#_aHa?RG8M]cL3LfMEE\-f96gNB:S.I&daFFd3><4?TW^\7U4[YA:X.3L/
\Q.FR9K[L#ASEMcI;=B^)@&AZB00a<7a;VT#?<WD)SP.SdYBF(b_W]_[eT#31-U?
;-6<TV]95]&bHQB:L#&-,6/P]2.gHT](J^JZ3PeZ5VZIBT;A)C;87V?^,WPC#CVZ
S1c0BOS\NM/R1KJ9+4DFKK0Q>5#2:<b7\)5b)7(ZWa-?00N6_@g8KWYY<09fbJS9
0G#0-b27.\7Q@V#B3f0R]34ZBFbTVE]CcE2\KODLGc@Y@#;U?R@W#c?=GAI^6YTJ
NSe;&Q@^>Q<&AC/=8()S6;gFH5<c3X2M&2M1Y\eXe_6(JgAP?MUV;M,0^X:F6?^R
M0S7XC@cTS&.J79.5\[ed.AdQD43O^^X(RR])Z0S<MT0CC2be=_g:b4@MfVe\\;d
.S^C^W4GFQc59&D77J_NWY:fA&Tf1U([_Ra]E<X9(WD>H+51b,W.gVKU6;.WYYVV
DC;LX\)-O[P-087>#Y(K<C+<>VXO47d63X7H3<Cb9N4Y,W-VT[41ZQ1.1Y-/>9Q-
T;>Yg9P)4&U4[7:Y(,?eScMc@D.RQ1\_E?<JXXC;R>?U<Y4C10BGG12g?_XJ^(7d
5#9f+6bK26FI1)+^PL_CNQ#8_A<7E-?@WYUV-)9GGBGdE8:JeYNC)g_4GbF;\P&e
NgdbOMXJfTEfRY,XaTS6MT&T6U;gENHeAdOIACg4#2W(8\:ISG&.R9g-&5ZA1UAU
cR_,:NCH:[M9Od)F3W2<8-QJ\4bBU#G;X2b4&XHE164<DI)dO=Q><>L5b_F4NE_A
.77A0E;4dd_D9R)0,^\T:NSC/0@JEAJ+6/=.T#WPB].BZF)/?F_PA?MN_5MbJ.BG
3bT:dI:04X^[>2);:7)^91N-I/ZJ9T&Aa-OJ/5,P=/:Z6.CR9C[#K2@]?]#d7&]C
cGFJBP.(cYZW@9U\MeOYPT3ae#0TZ0:)Ea<W8K1aS.)XRE[3)BKQWK-4F@M56eG(
._.aWC^CJ18cA)VMDc8e/g<QcO2WKWeN>.>,8N;1D#MA062#787CDgK[)&8[8Z9[
f/R_?1@OaZY8@c9NZb#eQ]&X.>_SEZe:W;:L3R4I8Z85dd<.b/f(+1JN@/ZOMD:_
#-/80,=D;5cU)04\-/XMOIV3-.(EJFLA;B)>,40<gcKdIG_PIZ7+R[g[V;<A?NEJ
6d42R]HNGVFc4-cP=/R2g6<38,]2EY/06Oc-0cB:a_e^/H#Fd?LbeG:&E@T[Pb\:
WEK[e1F/>SF6Y1)8V^IIfVJAf3O+-FQ^D[)6]@a22d,]WCZ^+e(:Yg1;IH78@7<Q
(KK]Q:;:C;HDf&(I<UaXN[e@d,EI0TLgFgKVd1=R2#5?/0D&:6K#O=C7HOPSMTD<
ELPU:0NZ>9e9HMQB8;JNIc,aHb3,-_@[2RdMKg=1CF<R+ee1Cd&_T+95#Qa,,_?T
c,3c&P#fG=J.Rdf:S:A(76T&7\8MTMeX,2=F5.UDG1<.b\&/:;^<Rf2d7;\cdM8N
B\N#W<FP>1X))ONeDa1/8cWN8MK8^&>YEHJ)(2Nd8P<KGAA[XMc.LLDdGH<XO]-Z
+/).;6N8A5SR:F<J\_3E49CGKS>O9G>R[)3VG69D^Q2C/DDXOR4Y77;2U:\U;Z#_
Be4PFCA7A7b4402<Q#R)WJU^(H:>1[MC_-U=&\+0ec)7_OGg@P\KTb&c<D@5=/RF
;aB43S#WgA2MbSR#TH1>@MW)TE;c#eWX[aEAd>YT08XA>dE80TXgbD6D)ZHNb-^@
Jc59XY[H7@?;6&_P_D2:66]34.bWNO,_GFeK^EaU6=gCGD9g^/APM7_@@C8S2^\,
-a8,M&29PddFE]?-A1PR&-7K4a3fH&T(Z[Z.42H]Oddb]^eFM]GD>7\;T4R,9gSG
f?B-9/<M@M[1ABg=/E7:@d<ZS1;_W2\Ke?=4J^O.ZC2W66.,UbZ5(@A?4(3,XdW,
N1TUeK&1T#=V4KQNQ86UE2#AWJHG\VT?/Ag(\+1+7>)2=484_5,cJc:b-0[>1LVE
1)VDa(=505PI(f)LE>A[U<TJHY&A8eGR.8adZC@A),<L</G#2Ja^YK2&CW>J5L&3
9-:HJ4^&Q&cb(-@R(SXA3_cG;]>0/=>R-T7]^11[QRcK6024>,I+NJ9[9W5AB].C
Ld6e5RD5AcEHG=^V1)6:<NOZ9>CgO8:6(8@34;fPD1VCGH6L#)M4Q6Z_e+0+9>XO
PC^I98G^9/8?EbKa;--<Ef/CO485Y@JJ@5KRZ.<N>N^XU^V:W9W,MJ0ZOM&Z=N,&
^<X+^&8ASPPMO&3.;EU;QeGbOg8:Q_/@[E4bO3@<B#+YT\XL#L5aQBPJ47I-1ZcY
c/PYSLY/16=(,fG6/\203R7]U>VA<DDNBOf<(@d_?YSMCBA(3V(HV+3]O;<E<fV4
DOC3Zc<X,f\.a(V)QR(>I>/_&#5Y@1=\5\4cc9X)PWHSf2F8EHCBaKdJ36Xf5@P4
@9<2,/:QSB=0X\R#U;D=LD9#IaV;gK7Yg=>8;,-:ZZR-Pd^MP#K>=WbSJSce6P^D
2_eWeNfA9>d-Ac8/7XdY4S<>L?4+/Q3C)NDSCV\)ZQ]OQ>8gYHWe:dIG-JXZ+ELJ
K;#g#NI@LNXVWe^=2>_BaZM.OL;78=T_Z:7C@0M,ZUUZ\-4X8B#Y7&B(5f2B-4L?
H_,]#3DRXBcDACG4=\73;Lg0g4<.V-7118@IHT&1QFBC)]A=K?MIAU[]-Gg(4O<0
I^QYY&.D)e\?,=;_VBPa]gZCD,SD(3<C@^J#3L0U#]2f7g0X4_C86K5\/=/K#aL3
&7^H,S@#04PRJc8\OSbW^8]ZGZ^XN\0N8^JG>S<[P4+><Kc21+/X9(Q#],NfM+W]
NONO[J:]=\WJ3I2XK.:05.VYI<1,291S#D]&_2WXXH<2bPBX;22-)WMP54K4Aa_/
;aN^S^+,.XWd/SR>)A;1aC0WA:DddW^d^I5.V18/cN4LOc<W^7_P;]d-(3-F.\@O
@N5\GXQ3<97D.U0804=RW_?/IE@UJW7:/_VKHG1a?V:bCBFB=]]&GK.JaARaH@]P
Ud/4e@&R(KB829HU-&>+FgO3]Sc8/E:gGYeK6)#21@[f7#bFd:KdOE[PZ\bS13[I
4=CJ_>HbD?F[[+_1bP_L.c_YIagaOe;;&2CM93RdB@]Pga5>+(6[_c:<RIG_AT67
Cf/Zc#D]&VJ1OIY1Xf15<<[5fVf7aQ\)HLGY9],e0M+ECYS:-#-\-JZM_Z657BOS
C,^O<(@7TVgM@9798.\ZUBRGRBdXPYW^M-LJ6b._Zb=L861R/P:NfHZ7RJAR54D/
N3+&>aPe+C?0A\9X=X(YRZ@[I>-E7eSXE(LSY.)FOXEE\>(A-9GZ>c)<3VJ_cB^L
ONY\MX(0?>JCE,8B1@c@[4C2d5bA0eVO@4-aH>#QK75_)b//74Q+MS]#UFID3EP=
[K9V34ZTf,OFe222a&/+\3WXX#;eH4X,OJ#6F0TB09?F+9XDQD14MaD?#1I-1KRN
1&#&GD3Ea0>(YTD<SP4QE.&B:CTBTGB2MNW(#H\N<cM#SeSdQN]6bT:B+G[Te+]3
[6;VX.K\C1WTKW/_FH,U2LSf\K<aeT6P#,31HZ;c^eA?f?[VFI&6MBEYU@P?DJUF
1Y7NGA=Dg@Q6@W/OC8-;QH.)=dMf3#SdGdRg:O:D#cGF+b+7N.),<]?E)<VA9aA+
7+3AWbab#7;)J.LCH&BUO/RBQ(2QSJfD9#1L<f,W0b=Q[B[OGWVO8eb;#UFYd>=9
Q,5JYOPFd@P9GAfg2:f0J1R0LCSf?HRff<>5\+]G75HbNTKV\EEY:3d7T?DE,Y8U
[E7O#\,S[CT\TW;I@H;LFCAG-79,TGK/gHFc3G,L:f1gDA@2\[+bNP)7\bS33-2M
HGa[34/0X_1F8052,E3N6K)2NK\EA.G0280KKaI3FAZ\Y?^(+]dA]/[cJ8;#B0c&
aPA1-4b]SF>@e6?[QEe93._<YA4V0?TcPAZ+I)5/H-67D?LD7-CG0ECL/?+ZONFW
1Ya00W/03,\TMN8-fI\[[\IZT>PL&+<ZA1CW5GX\W(BD\[^BBcYI?R^dO5UEYK1J
fC),ESb;[(+ReI1<eHc>0N:+QNN;K;c]XKW\S0fed1O0Mf1I7/gM;N5X@L&CTUB-
:>9TD&ae^a?K;@7(Ff;M2UK+WFZTJ]2QTWV@a>FQ&U0E#>H<OYI=]35/=e?Vb]&R
Z2OQDA2ILB9>a8W\+-TcdF1:58?&dHJbRKSP_Q(^0#K/FKTRM/H9)3-V=C_O_cWE
0T2)27Q?B<=#a>4]#<H5a?(.IJFP#T>ccJH/K4b+8fZ.I5b[RdQEK/f+8>QG[G.0
#KCfTV9c9H^O]2La;OdIO\6CU<RBdL0JbO7\3]/<Z.M=&,bDDF(<&F]RCL&PRD^=
cN#8FaeS=-2V4PS3P-8BMCfb&INeP7Q?J[MfPP@Q+(\B=8]S<b\/)D14Q\)3NV7\
KKP3F27HAYc6B+cAfTAL&J;B_;b)/bGR1^J?,eHK8M8-(LW(U)-7WMXZ6)V219ZG
,X;>gdS#UQ>;dLL6I1c-4H_F/?[\_-H)(&Q^YBG?2E_^S7>#^V,H@5=e?DX6e\A=
J5(RMH+[<;,1bcWNPN<M#=USKC;G_(-<A+_].VXK(#;?4e/V3YDORH>VLW?.;1WB
75gR+\cT-Fb3&/_QSUcSb>d_.4=(&I>f,PEdSV:64TTF9U(C<KJ45Y=?8N<X8d4I
,f=608O[=a^Z+&1e,I[633ZNJ[<Xe,.5<dXK<_LDFX6a?]c)>6NcM7P(TKE,6=@?
e,_dT.6+C7aSaH_ZIGXSE<a?@7(g4G:CRNO]I_>?6/[8DR02B79N?/IaA+[c(KYc
]P>AaJ56@^NEC_FU+C&;)/(P7H@KXE=_YXfS;4^2Z=EM<5?__BG?7H1V;ETQRAQ:
\)69;QK)_VLb0ME^82S4_+#9#J3BSB)VcdB>U-@eO)#L7HV1M,d-dQXgK\Y.=f7c
&SDQ5FTR&)[<a<?KBdBP\V\1Q0G..d(X7H^^3c=b3I/)X\1I-4LKNS)LVcMOg69=
e[@//N.)__>)g)N-O5,,IUXId#PZQZAZ__,CZ[@BT(<:]>5W+9+8b#_E\G/X.aLS
GWSE](<BB@fO+c5+][20M[+M.(;<Y0D-&fW(Y&A.<e;)4[a-AG&MMC@]DTE1I]_1
a)Z[I6e:/?I<+K#][N)cd3GFN&S>;^RT)((TEb^04=f+ZaJJN6&Z^bD@6H5Z@:YD
;-4/X_:QF<Y>F],7]K;&MM#G4^IZ@=89R\ZY_<b#,D3O;Q[>,7Ra@Pf1YZcH,.7a
4A;:N>DON1AY26+,XR_K[9\,:S\DA>C;@DX?8(HeQI-5GOA@DWMXZJX.aJ8_Z19O
;Dc)R4,FBJM)F6&E1G@N,QI29VdMPIN,>&8R@.:S27&c@-AbDgF(;.a3GYJ&1R)K
,QYIBdH3E[8W^J@Z/O]Xa+aZMLc\FKN&a&8EW@(?@cH=#_7dIS:(R/=.[U7_97U:
gF=Yd@Z562QAGI0,QRE3dVgG;-EXHZN6E102@Z@6\g_R/AWg6P81).<UEY]@cAE:
/4N_cOLg=.GEE:U-C:LJ0L&VZ5;F@?CXIFNeWHN7NY]g]3?+._/H\CD3?DLa()1Z
B_9]QbI>KHW]H9(()HDA>d29?AS3e)bcGX0I<c<^TdL5,Va<ITCcHNF)+.MG<WS_
R1[0W+YW@8F^RQYIF680N4<O>b8)>#e)f5Q8dS]#H/c@ZX,f8SBIL,fFZ#,&8BSf
)B\4_DO1[2C7Wd+?Wd>DD,Q^]V79X?b;JW#O)^]@NX5URDJ>7_Y42I-#76D\F+R_
Y/cBe\Z0LZ.1bSCX]O]ULc,N;>.[0Jg,8eN-GS:0K?>INTcdab?AJ6:GO:&=CcA2
U#.:H)(5RWafc1f]TZQ_#CSD:7O5&<I^:=++G&Z1ac03@X2_LED:RGU14DXR6,RW
g8Qg<PIK92-EWDg\URV;QdO/B]0g70)AJBIcD]-.A?]3?8F&([NE4EVPa_IS:4.2
Q;=<-JgC6QPcC7I39LGP+KJ:>.bL6<#b\(A9<]CSU&2Z(KM/9P;9R>\IVP24C8]U
d#B21H(=/Xf_.AQ\Ogba]gZ)X00-N[:2,fVBLO&APCgTVXH^b<a;Q]#&C@Y;JaTU
WP2EcNKW;f]ATPFC,C3@I@K>8AOU8cB<5@:Y.WQGO?D[2F6^(,U&CK14;Y+?XE0@
^aQI2VF7Oac@5]8DSeUZKS#2IcN^B8OTDcf\bV.S<Lf8cc5WJ4,Z=YZ&f_IW\CAd
aWDg:_<dPZ&UJJD&S(FU(YUc6FK67<]2KM^MOEOE-H#T>bGTG4H43D[Lb3\_D^B(
b]U,C#S<+=O0e4AX=_c:L_@2c4O&8RT_KR.(Y01N69WOU>IGB=OD^RK:GRFdW)(<
cZQ:/e,QQJ.>923IQ+VJ2FHERDN>+bB[:fL86f_gU)ZE;UAXX/?4RM]K?b2;PPWT
Y<7JZFG7g)K6g5=;VU\Z+]2:AfAU@K7Oa<9,LFG+#V:G_/=:=OC<ZZ\&]Cd8U11V
QSO+D<@LG/-O^7aMCVBe;DBV=b(3@J(eCH(,_[=ZD&#0E1e&ZeeG.WGg+K)dHU@F
H:0[SD^aG=MbCB0E)Ab?R0H9Y6SD?RJ\G:MD;NM>)Q.Z#:Ua/K=S<Y&&F]F9^LNA
F._G;X(Za2bc^\B;VU9;=9V:WJEgcJK-&:S);R][ARD@&30d=N=(;2C6.Ua#K)AW
eA,+]-EV#D<ZK8c/Tc_;M)H[N,G8;<]^9;;X^K5bbg.c]/a@?fX#f5XKQ-1B>YX:
FQ5&BX>Wc&)N13J^0ac1C_[FSa80d?GXA?=ZU-8M,]=,[=MAWRcK?RBCfEM#N0dR
J>?E;:#F\eH3Ma@ZBL4GW8\8FMG0<XE-JZT8H]W+QaW#4ZXKW7=0C7)J,.\cf#/@
U^gZ0[MWO/ZC#>I]^B9^?1&K04#_0LG+f14=UJBF)8[WRZ,TRI.QB/B_7Q;,f[<\
_;2aRTd8>)38/QAJE)W@R1V^[@ER>gB\6^-Y8-IcHIeV+1cO@GT8dLB5(^(G-<;2
KM#KF,?U[BcAeaf3^&AUCRZ:B6.>:EV3Q/2abU^J4)JfQT;[P\/+&?bHDB>;UNO0
M?e,Q2f/-K8c4)c[FEC(^fN\1,.46]]JH@MM7c5e_HW?d1A_(a2Ra0bf^5b_/KTT
&O4G)RW55#UT6JH5\V1FH?/LdI:6HLJEQYdD)b_]:9fXBKO/:-R?LMO+,=Y#f-a_
0P..P.U].7gM_]0,2Ra(b>(Qe8_VcDOWM^3)ZQ3TX\+Y>Kd(1B.bG)4B19c.<a^W
]5TN[].L7Z6Zb.JJE75K8YJZ5K3@ZcSBI33g;\-eQag8PZ.:G^_EZO=B4RgcQLZ3
\](X3<K[/b?-K@2=6:SH7O:I=e&[fbF3>V,Nc)d/LQSY_GY,IG77CV><-4LQ1X=^
0c)cOM-^Vggg&8EORTL=E>-@__a,<?W8JPGOKUL@EaFZ[;(Z>8+3L(Ob(V9Qe8L9
D[75e:8)[JGL3e[7;VBQe+--(R>]Z.bTT?XX13CPIaB;?V=\LO9J2)2KUbU=a^NP
-T2L?J8VgeMTe,AJH38.S4YY.,a^HF3Z^a8>LHF;]_da)P;]L/]MdJLM#WXE/7R>
_D@@)XFOD@1b6W58;^VRWaNPe^KANe@L++>L-/E.5f]X..@\O.FVAB^LdH/^3RcB
?99[I<+-1Ld[32:_F3#3>N3VZ9VG^+28(Z#d0.0LMRD91,5ad^;bUKMUKGOb=B\X
0)R;B&3GZAK\-@4OIc9MZZadb4LGJ+HeBU1eA)CV.dWO..=eN/D]a#cdV<aI:[N1
,-c.^,-XcT3O]aQf@YMfG,,eVOb:4BMcK1d:WZD3^.X;&9S8LDB05&7D-;@.afVN
>DH()L08N^)-I31c1A+eQ[.[O;QU:P=4-P,Q:RAHC3;OC<.](&2+a)[0W+==F>W0
.><NA@\=R+<--4C,ONg/#0dH.>fX8EcC?FeY<\0W,K5>^S<,5PdM>c:S+H-02=f?
O.\-IcZ02(FeN@2cQIJ-F_UCe3gO8J/EfVPBG9LQ-Td^8(RJ3J^Zg//\KVRF+;EX
gcZ^VE/K&]Je7/E:_C]H/8G-_0P09G0E0JM1c60>TO8C]Y:6<VJ3A3BI4P5G(,&B
9HEM^Q451HgU@Y7/>^=:VP]N9>^G,<_.ag\#CePL0MdUcX[K+/(HBVOI;[W,Vg;U
M<OeMQfU7>P+_BdB@BE6_a,J^#Yd2?8D7]>4b[47YfWG@U[D-@TKC#E,d0dF;VW^
O5(5_F5;=.=LS<cS3E45KUH/;0B]:1dAVHc2T@DH8ZCSaT,-UCH1KNH)J(@<>?D<
XQ[3(A:b6AW#45(^EV9ZNa@R>.,gM)_F:NX3N\61W=>-U=/9USU.2e31)@:e2J6T
=,D\2/E3L:e:A1AFf(BAb&Uf[abHZX2/g.7/[7?ZYKED5+@D;EQ5SUBF;>6.Z[(3
V=^b>P#>>,?LI.E=CcYGGgC;,/X(:/3<:g6b(23?&C;A\=9MI38YY+<a5EP+0Y+:
^RGVAJfb5+61P^98,?:Z:::5,8L/6\04DGG864DPeM2TFJ+^;P3^F-XPMD6[aS9U
BB_Y[fK_<+]NC=SY2ZTU^W,43[#B,EK=H^.13>@I65;[:E9dT+J[)=e819K6[GP;
+^.,MI0L4KX-C8V42AD[\feM3Z3ecA5F6N<Y5[+5X+R>e3I,2f-(<6U>FF/,N5,+
+b(f907#W:_>LZMLVZ@X&V=6-U=7C&W]LM_;ZSd6cZ6XG\ecKMbT_4WMA2[42=bX
5,1=Kb6WTHg-UYbBLA[Ye9634fUMISYdWf=L7F@=J+=Yg0->RcMBgWCUH-\=T+XH
,B1aA;TVDaL(N,cW+C\)U&C>7>3[=4.^FTd+4F^87:bY_\U+2?_2P]X]bT^BG<c,
+E,6>J#^(\1TDJ-=T\He8(O2g3S6(cO94)3UTe<88Q4Mc+8GeQP<+7<H)f/,D7]_
(&K974F&=bR8VNc13;W7B4=]<<KXL-SGUA5@2Z[UH)f4S#Yb=B[N6?VEZ(9Q>B&c
36Z/&L=R_Z+agL9,]]K9M&gKcK\bG4W=O,-8N(eKZ^G9,BZ.<,2WO@>\gF_N/bS&
::;F-<\R4(G@fP/J@IK8K6K[@>beL4;?21@.6)Zf;/HMP+VP1H#g-OLd;SR0-6]T
FCE3b=FYY15Q<]Xc4,Bg^SK,EU6PfOTFa<\Lb3NHg/3[6RP;F5^3<d]ARdQFZ:Xb
b;NPTZ4?R2LS2d,fgYZG[IZER^Odf[GCa1T]65SO8NLP8?-5;HdLNXbgDN7F_eO+
/0R]^=[,A&Y><D,[7>8X^=L>66UE(O>7TT0/]D5;6C@4G><1eZVUE&S7-PFU^F41
X6,H,6=TY\\[+=HJTS;U5KfAN<bOY1WI88&e_V6b)7HFL8@6UaR<;_+EJD\4DaXE
51SP=^Of=/g<&Qg2IN&0eK4Q\-Cb/f1G8<?IWeHE_HS:L-GAE\B]>5\ET]\W,&UD
9^&IS/-ZG[;_Z^Gc+6N,&S//W;J<NJDU#.4ZYWa<W5&H0SG1LT[=[JBM/U]G4CL@
<(c4PBA^\dO>eER]NS1[&YENg3U=,_JWfW4,eP)c]CSb:a@aVB-C?YbbOJ6f5?OD
F#IO&39PU@Y/>DbSSF5b2<6U4.dW255:6dOf=/gDQ)N.EYG&dcD9&4A7B0aeIbX3
b)5C.CH0#\I9=+f/,F,O3HY<M1JHC(,U1B=F)]1Z6.6dM/TGe+Sg^(39FN]0eY8H
U>NSK_B)TKJXCQ[9N<J(FG^L(7/OUf6T06cW4fN1RS^7K(05J8V+-@C.Ab#K=F@_
05QKa8,_>0THG]&[GHIG_WJ,YG1-HY1JE_L1#PKOFC5X,B]FU=VN/&>PHI),I3CI
;1KPc:T]@EMX96>Be:?YJA2:<_XY2.:8?W7P]GNT)EGR-\R8EDb^+0YUH_<8Qg2R
\2U)_@X1LUJ(1+=bPaP8@<UB;8(bR7e<0J-GH^?dYXVM\eSWeKQ1F\_&2R=ZI2HY
gO\MO\I=F]F(O)6>f=NWWL>[G<,UYU@<4LQI>]Z=ZC6<Y36?>=P,_]=[HPf7dc^2
C,<gDg2RVR[_ME]V&7U:0dD7R<<MZA1>6RL]WL&<(U=@S>Dd6?Q]/19Q.ZWdK,OM
;]]5W,I7dZB^d@L8S9LP;/Z^BCQ:e,AS>EA@1ZF,T\@Y-P@./4E?00;1d_DUI/RQ
Y(M.[;HR^6_&eYJ,B(##JQCEd\=g4(8K@6<5CG^7<D\g0\/H]1JbR(S1aG@.<O)5
abe?2G@8<aTO9;+gbRN<\JJ^T7cYHG0?a;aU+,(M-cFF>/V+T@Q^,@OZ716IG-d)
b+gPYT)Y46C[BYY&^?c(I?D?7IN(dN;E7]0UUaC6B?+C/;2VHJBOT_P\R[YPa2D=
#CNgTKZK5gT26ZN29JGYKI;7>?B:;U;-#&MD5:(;=7;ENA7A+@.I(^;Y1IDJ]PR5
Wd@]W.IQ:L[^P7NLO+^Sc,Jb9E7fK@dA5HT<QLO/#PWIT\aF;X+GPQ&1?2+(Z7X)
JgC:dga8I#JX+?FeRAX>G<#SQXAKeEN&7OH\JX_+M(R2CG+O@/8V)Z:dA<H;gdAX
O]?e192.(C1@?_Qga\9OD4;GLe(L=a?.VB:EJ-XA=1C4b>bU<S1:NQ0>UJb59[H<
:U;17WY_AV5/KRY2aNC_T)W&e><dK@0W>$
`endprotected


`endif // GUARD_SVT_XML_WRITER_SV



