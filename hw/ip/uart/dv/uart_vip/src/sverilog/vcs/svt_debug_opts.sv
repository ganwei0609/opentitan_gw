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

`ifndef GUARD_SVT_DEBUG_OPTS_SV
`define GUARD_SVT_DEBUG_OPTS_SV

// -------------------------------------------------------------------------
// SVT Debug constants
// -------------------------------------------------------------------------
`define SVT_DEBUG_OPTS_FILENAME "svt_debug.out"
`define SVT_DEBUG_OPTS_TRANSCRIPT_FILENAME "svt_debug.transcript"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_data_util)

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

typedef class svt_debug_opts_carrier;

// =============================================================================
/**
 * The svt_debug_opts class is a singleton class that contains the automated
 * debug options requested by users.  Options are provided through the use of
 * runtime plusarg +svt_debug_opts are used to control the behavior of this feature.
 * 
 * The +svt_debug_opts plusarg accepts a string value with the following format:
 * inst:<string>,type:<string>,feature:<string>,start_time:<longint>,end_time:<longint>,verbosity:<string>
 * 
 * - inst Instance name of the VIP to apply the debug options to.  Regular expressions
 *   can be used to identify multiple VIP instances.  If no value is supplied then the
 *   debug options are applied to all VIP instances.
 * 
 * - type Class type to apply the debug options to.
 * 
 * - feature Sub-feature name to apply the debug options to.  Regular expressions
 *   can be used to identify multiple features.  Suites must define which features to
 *   enable through this option, and implement the controls necessary to honor this.
 * 
 * - start_time Time when the debug verbosity settings are applied.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity is not removed and remains in effect until the end of the
 *   simulation.
 * 
 * - end_time Time when the debug verbosity settings are removed.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity remains in effect until the end of the simulation.
 * 
 * - verbosity Verbosity setting that is applied at the start_time.
 * .
 */
class svt_debug_opts;

  /**
   * Struct to represent debug properties that have been enabled through the auto-debug
   * infrastructure.
   */
  typedef struct {
    string package_name;
    string timeunit_value;
  } package_timeunit_struct;

  /**
   * Struct to represent phase names and start times
   */
  typedef struct {
    string name;
    realtime value;
  } phase_start_time_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Static log instance */
  static vmm_log log = new("svt_debug_opts", "Log for svt_debug_opts");
`else
  /** All messages routed through `SVT_XVM(top) */
  `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_debug_opts_reporter");
`endif

`protected
I?6f5[T9>L-G=CL^&:;Q>5=-&G[XgCF)@(d9_S)4d_b0CV\R]-^d5)A5e)SG@R_\
bWFR2+E;BC\4S.+f(a.LPJ>C=Ve4HTc&@cT@bXeSSMaWNU[cY.bAGW+^]@[S/3#X
SP6:XHTNF1_4,$
`endprotected


  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** Flag that gets set if the +svt_debug_opts switch is supplied */
  local bit enable_debug = 0;

  /** Singleton handle */
  static local svt_debug_opts m_inst = new();

  /** The string supplied via the +svt_debug_opts runtime switch */
  local string plusarg_value;

  /** The string supplied via the +svt_debug_opts_force_cb_types runtime switch */
  local string force_cb_types_plusarg_value;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_inst = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_type = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional feature name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_feature = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional start time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_start_time = 0;

  /** Optional end time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_end_time = -1;

  /** Optional verbosity supplied via the +svt_debug_opts runtime switch */
`ifndef SVT_VMM_TECHNOLOGY
  local int plusarg_verbosity = `SVT_XVM_UC(HIGH);
`else
  local int plusarg_verbosity = vmm_log::DEBUG_SEV;
`endif

  /** Verbosity value saved before the auto-debug features modify this. */
  local int original_verbosity = -1;

  /** File handle for logging auto-debug information */
  local int out_fh;

  /**
   * File handle for logging VIP transcript data when auto-debug is enabled.  Each VIP that
   * is enabled for debug will route all messages into this file.
   */
  local int transcript_fh;

  /**
   * Storage array for debug characteristics associated with each SVT VIP in the simulation
   */
  local svt_debug_vip_descriptor vip_descr[string];

  /**
   * Storage queue for pre-formatted header information
   */
  local string header[$];

  /**
   * Storage queue for timeunits associated with each package
   */
  local package_timeunit_struct package_timeunit[$];

  /**
   * Storage queue for the start time for each phase
   */
  local phase_start_time_struct phase_start_time[$];

  /**
   * Flag which indicates that the header has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME.  The header section of the file contains simulator and
   * simulation mode information, VIP version information, and package timeunits.
   */
  local bit log_global_settings_done = 0;

  /**
   * Flag which indicates that VIP instance data has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. Each VIP intance is recorded, along with whether
   * it is enabled for debug.  All VIP instances that are enabled for debug also list
   * every configuration property that is modified to enable debug features.
   */
  local bit log_instance_info_done = 0;

  /**
   * Flag which indicates that final information has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. This section displays the start time of every phase.
   */
  local bit log_phase_times_done = 0;

  /**
   * List of object types which have been identified as types whose callbacks should
   * be force saved to fsdb when debug_opts enabled.
   */
  static local int force_cb_save_to_fsdb_type[string];

  /**
   * Flag to determine if callback execution should proceed for an individual callback
   */
  local bit is_playback_callback_available[string];

  /**
   * Mailbox to hold pattern data carrier objects associated with callbacks which are
   * used during playback.  The associative array is indexed by a string value
   * representing the callback name.  The callback name supplied is qualified with the
   * full path to the component that owns it, and so it is guaranteed to be unique.
   */
  local mailbox#(svt_debug_opts_carrier) callback_pdc[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the data class.
   * 
   * Note: Should not be called directly.  Clients should instead call the static
   *       get() method to obtain a handle to the singleton.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_debug_opts singleton instance
   */
  extern static function svt_debug_opts get();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the plusarg value supplied via +svt_debug_opts and parses this into
   * internal control properties.
   */
  extern function void parse_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the debug_opts plusarg values supplied via keywords other than
   * +svt_debug_opts, as adjuncts to the +svt_debug_opts options. Only executed
   * if debug_opts have been enabled.
   */
  extern function void parse_secondary_plusargs();

  // ---------------------------------------------------------------------------
  /** 
   * Routine that tests whether the supplied instance name or type name matches the
   * values supplied through the +svt_debug_opts plusarg.  This method returns 0
   * if the supplied inst_name is a sub-component of a component that has been enabled
   * for debug.  The #is_parent_debug_enabled() method can be used to determine if
   * this condition was true.
   * 
   * This method also populates the #vip_descr storage array with the status of this
   * VIP instance.
   *
   * If empty inst_name and type_name values are provided this method returns the
   * an indication of whether debug is enabled for anything in the system.
   *
   * @param inst_name Instance name to check against
   * @param type_name Type name to check against
   * @return 1 if the supplied instance name was enabled for debug
   */
  extern function bit is_debug_enabled(string inst_name, string type_name);

  // ---------------------------------------------------------------------------
  /** 
   * Routine that returns true if the supplied instance name refers to a component
   * that is a sub-component of a component that has been enabled for debug.
   * 
   * @param inst_name Instance name to check against
   * @return 1 if the supplied instance name is a sub-component of a debug enabled component
   */
  extern function bit is_parent_debug_enabled(string inst_name);

  // ---------------------------------------------------------------------------
  /** 
   * Splits the leaf path from the top level instance if the component is enabled
   * for debug.
   * 
   * @param leaf_inst Full path name of a sub-component
   * @param top_level_inst Full path of the top-level component is returned
   * @param leaf_path Leaf path from the top level component is returned
   * @return 1 if the component is a sub-component of a debug enabled component.
   */
  extern function bit split_leaf_path_from_top_level(string leaf_inst, output string top_level_inst, output string leaf_path);

  // ---------------------------------------------------------------------------
  /** 
   * Marks the VIP descriptor entry for this instance as a top level component.
   * 
   * @param inst_name Instance name to update
   */
  extern function void set_top_level_component(string inst_name);

`ifdef SVT_FSDB_ENABLE
  // ----------------------------------------------------------------------------
  /**
   * Creates a new svt_vip_writer and sets it up for use by this VIP instance.
   *
   * @param instance_name The name of the instance with which the writer is associated.
   *
   * @param protocol_name The name of the protocol with which the objects being written
   * are associated.
   *
   * @param protocol_version The version of the protocol.
   *
   * @param suite_name The name of the suite with which the protocol is associated.
   * This is only required for suites that support PA-style extension definitions
   * with multiple sub-protocols.
   *
   * @return The svt_vip_writer which has been created and registered with this VIP instance.
   */
  extern function svt_vip_writer create_writer(string instance_name, string protocol_name, string protocol_version, 
                                        string suite_name = "");

  // ---------------------------------------------------------------------------
  /** 
   * Creates an instance of the VIP writer and adds it to the VIP descriptor entry
   * 
   * @param inst_name Instance name to update
   * @param writer Writer class to be set
   */
  extern function void set_writer(string inst_name, svt_vip_writer writer);
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Returns the VIP writer reference for the supplied instance
   * 
   * @param inst_name Instance name to update
   */
  extern function svt_vip_writer get_writer(string inst_name);

  // ---------------------------------------------------------------------------
  /**
   * Routine that tests whether the supplied feature name matches the value
   * supplied through the +svt_debug_opts plusarg.
   * 
   * @param feature Instance name to check against
   * @return 1 if the supplied feature name was matched
   */
  extern function bit is_feature_match(string feature);

  // ---------------------------------------------------------------------------
  /**
   * Obtains the start_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Start time value obtained
   */
  extern function longint get_start_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the end_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return End time value obtained
   */
  extern function longint get_end_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the verbosity value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Verbosity value obtained
   */
  extern function int get_verbosity();

  /**
   * Obtains the file handle for the transcript file that contains VIP messages.
   * 
   * @return file handle
   */
  extern function int get_transcript_fh();

  // ---------------------------------------------------------------------------
  /**
   * Sets the global reporter to the debug verbosity
   */
  extern function void start_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Restores the global reporter's original verboisity
   */
  extern function void end_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Records a line of header information.  The following data is pushed to this method:
   * - Methodology and simulator information
   * - SVT and VIP version information
   * .
   * 
   * @param line Single line of formatted header information
   */
  extern function void record_header_line(string line);

  // ---------------------------------------------------------------------------
  /**
   * Records the timeunits that have been compiled for each package
   * 
   * @param package_name Name of the package for the supplied timeunit value
   * @param timeunit_value Timeunit value for the supplied package name
   */
  extern function void record_package_timeunit(string package_name, string timeunit_value);

  // ---------------------------------------------------------------------------
  /**
   * Stores the debug feature that is enabled through the auto-debug utility
   * 
   * @param inst Instance name that the debug property is associated with
   * @param prop_name Property name being recorded
   * @param prop_val Property value being recorded, expressed as a 1024 bit quantity.
   * @param status Status that indicates whether the feature was succesfully enabled
   */
  extern function void record_debug_property(string inst, string prop_name, bit [1023:0] prop_val, bit status);

  // ---------------------------------------------------------------------------
  /**
   * Records the start time for each phase
   * 
   * @param name Full context for the phase
   */
  extern function void record_phase_start_time(string name);

  // ---------------------------------------------------------------------------
  /** Logs the recorded general header information */
  extern function void log_global_settings();

  // ---------------------------------------------------------------------------
  /** Logs the recorded VIP header information */
  extern function void log_instance_info();

  // ---------------------------------------------------------------------------
  /** Logs the last debug information and closes the file handle */
  extern function void log_phase_times();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * This method can be used in VMM when the main hierarchy has been established and the file handles, etc.,
   * have been propagated, but new log objects are added to the mix. This basically just propagates the settings.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param new_log The log object to be updated.
   */
  extern function void propagate_messaging(string inst_name, string type_name, vmm_log new_log);
`else
  //----------------------------------------------------------------------------
  /**
   * Used to update the reporter messaging to go to a log file based on the debug_opts verbosity settings.
   *
   * @param set_reporter The report object to be updated with the new verbosity.
   */
  extern function void set_messaging(`SVT_XVM(report_object) set_reporter);

  //----------------------------------------------------------------------------
  /**
   * Used to restore reporter messaging to its original verbosity, and to redirect it to the display.
   *
   * @param restore_reporter The report object to be updated.
   * @param restore_verbosity The verbosity which is to be restored.
   */
  extern function void restore_messaging(`SVT_XVM(report_object) restore_reporter, int restore_verbosity);

  //----------------------------------------------------------------------------
  /**
   * Used to track the debug_opts start/end settings and update the messaging as needed.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param track_reporter The report object to be updated at the start and end times.
   * @param original_verbosity Verbosity value saved prior to modification by the auto-debug features.
   * Ignored if the start time has not occurred yet.
   */
  extern function void track_messaging(string inst_name, string type_name, `SVT_XVM(report_object) track_reporter, int original_verbosity);
`endif

  //----------------------------------------------------------------------------
  /**
   * Records various aspects of the VIP in the FSDB as scope attributes
   * 
   * @param inst Hierarchical name to the VIP instance
   * @param if_path Path to the interface instance
   */
  extern function void record_vip_info(string inst, string if_path);

  //----------------------------------------------------------------------------
  /**
   * Function used to add a callback method name or a list of object types to the
   * list of types identified as types whose callbacks should be force saved to
   * fsdb when debug_opts enabled.
   * 
   * @param add_type Callback method name or object type to be force logged
   */
  extern static function void add_force_cb_save_to_fsdb_type(string add_type);

  //----------------------------------------------------------------------------
  /**
   * Function used to see if any of the specified callback method names or object
   * types as callback arguments that have been identified as being needed to be
   * force saved to fsdb when debug_opts enabled.
   * 
   * @param cb_name Callback method name to force logging for
   * @param obj_type Queue of object types to force logging for
   */
  extern static function bit has_force_cb_save_to_fsdb_type(string cb_name, string obj_type[$] = '{});

  //----------------------------------------------------------------------------
  /**
   * Enables callback playback for the supplied callback name.  When playback for
   * a callback is not enabled the get_playback_callback_data_carrier() method will
   * return in zero time with a null reference for the pattern data carrier.
   * 
   * @param cb_name Full path to the callback in question
   */
  extern function void set_is_playback_callback_available(string cb_name);

  //----------------------------------------------------------------------------
  /**
   * Task used to obtain the patten data carrier object associated with a specific
   * callback name.  During playback these values are supplied via the
   * Playback Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   * @param pdc Pattern Data Carrier object associated with the latest callback execution
   */
  extern task get_playback_callback_data_carrier(string cb_name, output svt_debug_opts_carrier pdc);

  //----------------------------------------------------------------------------
  /**
   * Task used to push the pattern data carrier associated with a specific callback
   * name to the mailbox.  During playback these are are supplied by the Playback
   * Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   * @param pdc Pattern Data Carrier object associated with the latest callback execution
   */
  extern task put_playback_callback_data_carrier(string cb_name, svt_debug_opts_carrier pdc);

`protected
<K4>46;)f56(EYD(Le;eQ#Ua_\A#CDM:TQMfW/7]Sb_7OgQcKX[(1)U1NKRCAHI1
</aAEVQ>fK+40\?D,C5e>]GfXBB,e3,)(27aO\R)EBY1XP\>;2SI+@a^O@7:2;dB
B/e+7Q@5XFST#c;/)AJ0]QD[a)eR.HU.^R#72PHdAYUMZK&0C=#:1IIK([;5ZI(Q
Y:HM=\A0a-](./JD);8W)^WYK]3A>J)2DBFI7RS[WJZ5;g[__87@CfW>N&1@+E7W
[33V]O,UEC+(.$
`endprotected


endclass: svt_debug_opts

`protected
&fHJfeV=>8VSCIIbF>C#4Ic=UCF:W0)fg8LO^S,1H[6L.RG/JbR^5)Z46g0Nf^PJ
Od.Bc;999BRZ(]<_7e)-<afO/:1XNN>=E^V&^3H7H.N#P.Z)eZ/[=R]5^WcMSIP6
Q+YWPFYe-L?1D//1GP/4\4(;0PgZ.:aG#(\[OW^WL4GU[5ZA90G<M8^:FMPFI)G:
d@gUE[HCSXU#,X352WQ[D)P=G9)g],=<(f>4(dX-[B<24dL]4)\SeKMBCSF9<B7^
ROFV=\+;K4V:EJFZQ<>X:;>-UEfGL=)bL[(X[=ac+:P6X1[N2&_b1\4WUGJ@]__V
<EM86<IfP]\\XHVY,LdI=KNKGD.dC7IO:[;?Sb9.gQZ\e8M20SNZ=d]D,13I&;RJ
:QU=/9QNVeUY:6S/Q6C]3M-D0JJ>TPb/Lg\M0./[,Q?Q@^HC=g;U0>O@>:V.?Z+F
Ce[OdAS;Z6^UA?S2[_,g>.9e;Y7e6b]&6>MdH=FT#N#PY+5EVC9[e-e>&:Ja.c7D
XI?[LK/L:^W)]S]8[f[)+6U;O>Ie#e>M)+4<DYG0FZ)-9D^X+_92b@:V]J3d?.:R
8UC@=T2V_47Q8&)eg-b/(KM<[VSWK)E0J4^L>b+^)53JbD;a/aH2(MPc)?-CNAZg
]Z2d[/L2Y?F5&Tb-)P>bT6@^YS]ZNW/AASP\:P<6MMDN\XfM301gB@GIG0VT_=74
H_9UK=C6?P3W)-5^;,a>4/]BZ:@7R?CEfECDSML8EB=RB0f1aIgbOBJ/4XS&g[=N
T_K#@aL=9MV_Kb9.d45/]D/=+?2R@&E1VA,d=2U4cFH,8ffIQTZTBD#/AfNZddER
9@5?.QP9>,S5U59Z5N>54Q6_,M2T,=X6,SOC657IdSHZP(B/&JW753f.,8Oc;4H9
N?)IB8/30_Ic<5cUSLgP;X-Y;<X4I:)_?JU:OL_-:GU46KZMHKCS;HQQS:R)VWeJ
.77>92EM@,=>4FD4;IYfQ,Y]c4\f,Y+/>+VeO-E8\EIT&aO&8+48(9;@@.I:4S&d
,ZZB.?@dZ7HJ)fgF;Hf]?DLJ^\P^B2,\M3GH;WeEH1TLQ^e?O+F(YRdZ&WMUSWYG
^8DY.\&+1,Ad91fT<])gLD8;]7G+>;:E/^@P^B?,PBVNFG/G\8OFZ[Y9A@=W4BE^
9P-c41?],@^;IDXdGWVQT-^HK/FdY<?;:B2/:^#+03B>[@P8UcP5O]==K?2-#V5V
_IPXedFCW:0+C))=\-TR5V]7;Hd9U4&ZR;-]JRF6E0E//P3>CPDX5-,g=@3WYVUJ
@gRLfC;7Qb:6c)K\B4O&0L=DJ]#@L5a0W5aEgK]+JK,,AT_.?@_dP<7V.aIIZTKU
K3fGcV72HH:\#>W.53@K)].H/IQD@>MMTf=UU=K7XR5gdE)HUb[:_N>Ta&D\\\2)
2\A0RUEe;:0TCX/(9/4903&6d+LZ/&[XU&eZafJ_^?&.ZZK86NXCOMI<,FK\G<S4
<@1C]d?0ceHC0SfIZ=U@;B9<FOEZAM7-aEH#.SZGFAEN6/ac-7A=5(S<Q6a619D<
8XE^/:/XcB]<OR4U^..,c;D0(cBQ[IF<5;W;9C2:[UET745\WCL^c#3DOaZC]M]0
VAY/P)YT_ZU4+5[]=c@A-=XXTY@H>\VUFOb3-].X8/^1gI3(XF.KF?G+_O3[8V4R
d@FR@S7^a0;Ic:78)fW]_+JfC3U4OM2dE]7@#PLZ:4=VBZ82&GdI54+V[O;XUM(G
c_04BcUCBc_TeU5A;I@T)FLRAE@_+].Va7^:H<&,22He&cR^=0[F\gP\TWFE^.e=
N)QgG<,Lb01>\)]VaN(IbXTUP&1^gUT>&.\YI<AS@CS[dV6FV(WSe[8+0+\\cRfg
M8<HN,_)4._158Ocf=(Q:@E4gC)8VMXQ7dM4:7;&O@H0?6B91,_C9<0egTYUPZ_G
95_)bdJ81RN@/cbOB^I;Hb135?6cU5)84[RbOUD-FWO[bO3O#>5KV=HL;=2g1P0(
Z8CN;ZCBG^@081.aTNI^?M&IEU2P9UaJO/CQ)?+9;B3aLGWJf]\OG;TM,V8^Z6Ob
<fdG>bRP18fTYB,GS:)Tg#_E<0aU69,Y7a3JU::dY+2_.(bP\.DSZC7I];K3c[,g
+)N:fXY)GY0D/-8N,3KPS#.4G6L,-TSEYPcHBM,cOdZNSbNbNN\,9Y?_<,(?Fd:0
97fA@16@M=0SQM9g@RbZ<1_E:f+,R+&fN_NY5#I_-\X>>L61]e]MeSGD=BASWJNg
2ROb=b,4KJ=g_\RW:I+Ug:Z<0IOL;,e^?WKJbL:1f^dRd]H?3QV8L=;[[U.VTgH6
S\c[[bJ\6K_5g8;7/Dc05MV\6OPU][OVY(4>=SX\=bJ5R&<.,F-&O09>9F/D<#60
Ub#:Z7OWWOONL)N^BM;ENMa/JAL2&3J3L4VNJ0L:386XO92_:-<_g^Uf179BP7Xf
\6U(,:S=V=dS&ZVM<T[be>.Y/=T,EJNGaC:0<e,#?=[MHbXDDcYU_0)BWaNVJA=]
-\c>3PKb-7;JY-.O+1LTb1<H(9A22(.W7WG[>=:M44@O+)&G.8?eXS/dQ)<S.LFf
b4eS^QLeE[_FWD94.L##a\+2K@>MRa+WPWgYZ8V;4D?@#bW;WJP/\Q-#ZCL1-#27
U+#LOAO]1L@.dJQ3(8VHA+QbB3())20_^8c4+4WdG,eTK2e\cJe@#?U-1=XJH3[I
OfC98\;<IW:P5X5X>JMVcU>3Nae4]DV9K3JVR;?7[MQ<+ZWN_R9R-XA5XV+Ge<(N
aGgM_cAN_CNNfR?&^cQ/2:-@L>Z:B9#JW^XW?5H456YZ70)_Af&/D,S\&+M,=#BV
a9P78?UUFbO:/AJ;PUP^OPCAVTgDd5G66f6b8T=P>7LXQ)F8U53TF6(V8:,>OC9I
89MF4-3e7EQPHH,;VFV]\V(B503@ZM@IL1fO]g.dM7AH5cXFe#dXeOI[::]>eCT^
.CPB_H/+6-Z2HMGaT7gD99)\U#.(,G_J\c2+1S_89.[@(]I_\(8:@Rd@]S7_&&06
5WTJ=/MdILSPV<I56#99YN[I-2\J-FG1GbVHZNeN6&YJQLSaTY<gdMVUU1WPR5=N
d3(V4P?9>_;OE;GU??>KGU&@LLWHc5E.Gc[>SD92NOD[:C#FR:IZcKOVHOH:V(9<
6;T&MaD?FZd\^G<K&Y&.O@+;6](8c+]Wd;;0b2&HTg8@T3,G5@W)&&YTEaa0JFaE
GQ/+f9abOZBB7JN5?6\8XH+^V[0;;FT+d,G_d1\I5]JT-S/.64D;YSeF4Q)g7&LQ
.GPf;MeF.;\2L2LW]]\g[2IU0>UB8Ub,Q>?B/R9K/1E59VBMV^9,S;)V/_1MG8TO
JZN?4=?,)Y(+]NLESFMZ?Ked[76,]FN2.H7]TC.b),2DKH-ANGP1KPG?2OMKE068
;IBY&@N0Y)28UgF11-1\RZ6.T\c>bD#DX>O39:UT)H7TY1ZY8O0:WT>UQ.f4gS:c
Uc+^#RW/)fOEO#Z8(\<PM+=&Y@MeX+]4ED=1A2HIX9?=A_5\FQ7?/,4>dC5(<C\]
)8:D(aB04gfc9WbR22RH6<I46J/Y4O?ORX8S-gTe4IVV_E=eN@ZJR]G[D3>?2ZRH
FQC2N>]I#:\=\\U_eeA>a]?.8S,(M:@G]Y+A0-6@.,&;QW:5JO3R6]2N(CDSM?C\
RDSGcd.QGfN/5GGfMR6G(+TH]0BGY^^Z4\@),dfSFTXgYZ#TEP:3Q)TV+TUZK)C]
L@,&Q2)EEbdYfeeKZHZfgOaG^,PA?1<P0]-4)Ka;WNbe,L]9T;AXAU9UFadNX=#]
6>,VVD:g]W0F56/8L8GKGM4:\,,P[M5ad\+FSJX<O-,H?;6[PS2T1:+P#KYV-CdW
2#-&H_a^WVPd=[\W^+fBYfDf?0)3^<.P8^1&K[_.:d2fJI<O/1G-QFR0Ad\\GI)[
G76AA9M]MeT?6]?]cIUJOeLHHKK>MHHAIBBS#VLc=@;W^LPL\=L<8FHKc&E]VK0(
UM6Rg3;H(6UFFZU=T@HaBZa_d5=_g.IBVMIU,\.;^g\Y.L7G:ULQ4&?FSOM&Fg8F
e,N7W)&A@)8N\F71?N]1K=RA^-+MJ<S^WGU2ZROe]0BXe--fTH<Ff6I7M(8.I@\8
@R@G^ZG+Wg/b<\9:Q0)VPf(7LN0=;Y;^49GU3ebO9&O@@-FHZ@-0]-BP:>BV<,]X
L.(0AHNQ1(#NT^FNJ5b+cafHDUaXd7L4Q.gbW@G)fHA;;U>Y:(:B]4?GRc(4ELIC
R@BYb>SKX66<:2D0NE;VEU2V9]fEQEHL.5LXGPYCNH)^[6K)TQ24QFE&7c=HW9,O
;Wb8-e-;RVHY)JZ#<Qf+-XN2,&V:I,d=fa6I>,#2,A-:a4-MD0WH,AAa69g5#&1C
F<ZF>ROA=@8#b:()bFMJJC:2Aa).\@]H+SA316HC9OEA^0AeD@=8Q.>KJ-J5\CO+
5Z5OD&@>Z#-=1&I)@U5UEG_<bTA.78JW1B1bM55)23@)+g1QcEWD6=0+:1R:&,\0
3.f(PbX/2LPI<?>(M-_,6S96+#Hf>_&6W^DgST85#?O=OC0?ZeQ8MS:/+HO<bZO>
3=5(cI^4QQF;\.P#4/:56SNG[\Da6GC0J4b9;__c&IMD0WfFE;I.LX9XaS4_I9H,
^KT;IS4P^D;<HPV=DR,J5dHc<(Xe7H5d6bRX<+aLV<_X=aL>Z3^Q:K5;0dJ-OY>)
dce<JW?_bE@A[]cUW&<cN/KHfV_QeJ<-eHe@X=e,C+bF#?9ae0)B^-:d0/H,CBW5
5b3TU<Rcb,d51CS;aQYY2;8551EfH8V9&+[(-9JA_TSM=e^d/9U)_J=_XC2KI0=]
2-\B+)@LXZQH5eD)\EcH#>J8ERUL0>_8(6EL0Z?[:a3WGD9XU^9L;=9E^>\3H5c_
Fe0G5Mc/>\5;Ed29DW)Lb5_R&Qfd;97=)UfTJ1_d<?g7&#=eE=9]>CWKQ2g12+b/
(ZTINOM52_PQ^&I.dET[8.-?6IeG;11Y#[@MUDb&[.WU7B(IMN)aaB-22\+O=bX2
H8AfGPFe#A],G)=5Ug-\II<UICFNXXC\gAJ[9L/:Eb\BY3:-)45NZR+[MFU;MKLM
-],WW@JOT-FV<&@Da5bN/aY8M),--8AAZe<9WW[KO7\)1?<f81_)&)XB8X_f7DRA
RQ<86G;T+MV)1^8EET4UDDM]7?>#1VN.S:O9\CGOEI\#B4Fbc^C+Q)-X[:O?FXag
FYNFHB;Q4I7=DW1UYQ\MbY)a2CL.PH;L1FS#-,A^/:/RRbgJA^-5:#G:V:?G)B]?
,FCC3EMbBK@BFb8YeY-#=Y?Lg.J61L;KAPL]g)^(9XK#GW/<><Fa_<a0&C,LD/_M
VH6VK1B3N5cS\Ab<Qa0L38OXFG#bZ;@;]6&&?Y>6cPJ>4T8^66XVIYT#K.^cU+()
@b5H)AefMYTLCCZ=_&84K.<RT<ACA-1-&1)X(7TU\3NZSJ)2[^IH+MC/ZGbNF&ZD
UDFKO.4<+\ed.GRA<_dE,?J4RW9(UNb.-[PL8KBG+c8TFReKKCOP[N#:@b#5Y<MV
4ZVA[S]a<IB>HFTQNL(:0AN;&OcfUFGS)@K31)8-]+PQ#OBJX;[2/;3YD_PM>I3.
NG:;=<POQ;(JFJ;A#3Q?B)FAXYSbH^A_f0E2\TY7N]dF</G25]J>X69;Y;O[[g)(
-a,cL+7d^IN=KII<^VOEH^G5_)D\GHA4Q:c)TK_:R8[3OZSM)(_<\HYK96-.fU&M
MEE^.RS/1F^5F=@BVe1I:dYC:OY;?Q1,V6)=+K[0H_fB]:G4QYSF:I3^5T[AEE[N
@Ef#32fJYX8O5H/cVIP(3I<MRg#V)3D4@._eL&#TU/e?NI2eBc9X:QE^@E?e[;Q&
gCE(,5c_+Je&Gfb[>&G>ZR?A(E/^V-FXfc_XYRG0^#6?(IRG7)7XQ(RG\\[E88.H
-ET>01(0;T7g@H#09<O/)(TT2KeGM2fTEHW?D,H^MY?2cNDcX4B5fTY2?GH;G=,e
TaC<:bDBfRdb?>38K;QR)];aDW,\=5KS4^^0M3,7=;>08KcZ,)g.S<11)HQI50f@
8+4ZDJ=0K\/B]d+_-bRZ1/.&dY8+8_C9TRMaFYGbW_S?C,JS_M_\8_CcPN9Qd&Y^
-<41/_PLI<M[XNX-L:;6ZRZ(cGAPQ5f)e8],)aLBg1JBO,BUf>CKfb97f00S:@fN
M1d.[C1-)+WSg[1_)c\3)8QUY;6BCRIJMP8L/[Q6]@]7#T9g+\NcI0^=<b-<+3O[
:?2=-(@dXHIB[FgVcb:?MOBOQF]^4.68Pd8gN=1LT;C75BM7#7XdLg76Z>G/gHP&
J1#@/U2LG9eJ3,BD2)4W8UJG0?\9KUGWF7U[L,3N1EHC)-f724\YGSTe1OME@,(S
EG;/4BVA?HR=5g>Cb3f2Q;1MIB38FQV=FY:-0G2@M7=^8C?>5GCXV1EN_SJ1XA/)
N(@\EM4WX;dE6&/N):I@JCGS;33V4KJ4A&-4OVcYe,4CCOddVEYI.b71P[=NQ.=7
RF5.424IDOUb7g71ebcV)d?T_&((,/4J-VUE)=eA@3>(g#[A-@U/KH:E^F]6XU,.
]Z]e[\FS?4\W[HZ[<ebRJVZ3f.&8FE+VR3(95bd2.,=@1SK\<LO;]N;ZDC[C<WTO
.GP;Za/4KFbUNI3LY2Q?/;+YcdT5(S8H;E]a_XF&PWcD-WVb-[d>K4VLI7A?XP?H
g1V<KFN7&N\F<eTMKF3U@B<:;g#T+JGeY:=T:M2fZXb4;/XXLL^?5=gF,(TWSY:T
E&5:A/OG4^JDaM<g)AU1X98+bJ]OTfYL7fTE83A=&eR;c0eT4))24,UIf&III+<R
WJK[Y^U?e#330D37?_dc4I@=[a^MEVVBQ>@bLPY--L(3KLgO/d_[V;/^;:c10/X?
(/?SIJ@M:51&42]P7UQ:JG1REU&HXJ9ee,f_>9>c<bFGYeKWLf17)^]P<3CI<EU#
-M)C?gE&Ng)OdX(6HPM3)g7&EfD.K7=8B/N15g#gH)d3>8&9[_-SId.5GV5+X;7(
\&9^F7V.(1UPE[A/^b0O^;+fg4C+e)CRRacVZf>L.D+EG)4dTf92+.[:E(<8E1DS
;4<cafa=:ISeB?&V7,A5JDgG-:OPg@T)4PD8b;7AR&E<2Eg5T?T\JdSZ[OHP;,]A
J71HWO_IS,V_=J,X8L;8(Ma5)cF3+cU5J&-&5Mc[/D6UQ3_B#DfC1-@(cX\6VgHO
&W62OM@26UQQ3)B6_-[f2?W.5Jd8XP2,^aJY-74LBML:2PGC<-03NO:Q+IZdaDd\
0H3.N,GQd,+/4+a9g@&(g.0D4Xc\3V8_J1=2W/8?@O[4D8^.41BL\#)[<K5NLE;G
U^G(aJ@0PcCQ(d;9g5M9SXLU:UI[0[SVVb+6N<T>d8a+T+Yfd\2gf676^3JVPD5;
AOPcA\fX\O7.8[_.9GTP]Y.;H+H7,2d&>Y-EO(ePVP3]/+?.D#(NN8JO;3I@-H)[
PN8MZ7Z864IBN7?78I-f7MAV6a.EI,6V/9\^-#N=ZKK90AdTN#Y/a@gS_1/A<Sc2
0C@Ce.:<#P#7#H;/_-X/G+Z33OK\+7-X7,)>HFc)KDRCM7>Mc+gEGGOJFZWC>3KK
YE6YOg)2Uf/1Y,9J51Y/;B^S2,:YLg9<Ycg>Qc(4(7W.IU\/HCD3<3gEJJA[45&N
/bZZGb,4PA)gW#c2G.>R]9MP3K_[LKAXH[QF_>M0H<.=8XTX9I;?;A>I]WS]NQ:T
9GFRRV9.5S.?]dDfD-dEI+U@-B;S?[UHa_MZZ[dc8MC5cXMDG@5PC]U50a?5OG:=
UN8#T584QD>5.T=WW>2GLaed)0T=&YKa0T2LS4A=I[FXFWB>B,W=eH9DSU:<,Wc6
KdXT,,2;0VW(T;<Fab#8YMAZMAF&X/B=)9-c36.);<,EE/V#SEAC4I<V&PIgZKB7
[e;JVYU@6QB#,N4]bC7Y,\=J-0.NPU_I4T5@QG:\]OcA]#9eK^-QG+\=)GC.,:T^
a9#LH/ccX\g]W8)FS8cb(C]\P;a#Yb/]P<GDHGR+;F<SZUH.R8N3XcFaF]?W[:ON
./Z@]9DG7FEF.<TC3?/e5KU.eN4L..ELc+_;Y>Cb[S>4Eb7)DPHCe[PLCVb&P_Rd
,ZH.L-Ba[+a(7GMPM8b2TSX8?@8-^Cb<+ddOgC1-#LL<\M6f^?@_a22aAULC)709
fQMX-GK.4ML+\-QGIUaV0/KH9b<WP@#3?aIZD2-L/<,J2?;.=Mc\]EeLc;ORYXGF
L,B<U<3=e1X^5^AH1_Y6d>:(8+g?L6<J;8bgU1@P-ZG&#]=JJfE0<f-N]MP3gf1e
G8-G_b&7[]#G#SN:7P>79MYDQ0TEAO^Z0]W#K2d,U)H+?bd5P/PV3,]J^aWL:W=C
ENcc-&@(VZJa6E^#d992,#dROKQ<^g/Wc\M&EKX<_+)()ZE8_I(FZ,d0L;RDM/&A
@5_E7LV3Z[Ze[G_.U<-cD1J@F-I;\DgV\Q9W[PU[#X#XNF3G_)eS7^M]+c#K<U,F
;V@9LB2-g3;4g1?_#T>Pa>Pd7BRK=;J/II-AFgS3Q5gd)=,-]ISfQ(KV2[JKeM?f
9+R?Bc>IffMMcZECE[/DKJL^V/Q[;^fXQaU:;I:9#[bH=IEPA+1?T8+,JLK\?24+
PE+SOg0-bg_55L8Z)^6g8fT[5Z6PD_=Y<)?9cEadVETbJc,GWBR:QGR>Wg9ea1TK
a4?Q\.LY/G)gHO<P4:YQNVMNI+WD_L./;bDT6?UE8=aL.L>=IeWfbRL96T]:C]6S
:U,<7>K?F>=a8A#98K_ENP(^c?U;(aa^.+A5N-e99.:TPZRe5)#4aO_>1#MYa?Y/
]@7GJKc2-4E8MdHgY=[f9bKLJ0gbe#U+>^g)\UF[&]N:LIeUR(0)E2.4ZRO8@DU)
PFDR6-W]PVTfNd[RfIP0Ya<MZ[X-U1Sd\<)>UXVE)G>Kd&I5(d.,JKGR+_g1K.3d
fKcW/1&9.0C>DXYX+P^(>SY8TQ/WAHdbWN^2BA,<(92LM:HLFG/:[\RXSaFI?JP-
\7GOWdXS7A^cK;\G+^4WNa_2Y^WB7;FfJRgMN3F,9TJ,-?#2B8Ubb,@8I5]2KJ):
5=HP/b,2K2PL?16M5YQROIO?FTSf]?>HC#UOO?eR7[&Yc55g27D&)C4Z^e51<Z^C
)=6<g>YPL:@MR4MB/GLAC?RR6f?P(U#=?;>NA]\9AB(ZFP@6X3_RRadg7dAO/3F2
._J97(c<+.1F##ZP+CO]FV]+F+1Fa1/#>5L^EOL<88I6KLOWc=OB=C&9AZYF9UT?
O=-edX]=BT3QaS[1d^X5VFHMK.08bf&2KDO&IWA[E/?@#]3L\Vb4G@_U@,3YbHHP
4D:+Lb1UE:+42(aFZPX_:6,:/X:QV[aaCS2dMS=K0G.6<(-L^VUJ),.@e0bK3_[9
+BVM4&FLYf[RU7K5M[58EVY._c.eaOWB&A8.NF-I@DB([.HB-&_Wa/_@^)_=LG[X
]F-?##dR+fb:/WMCLQd&68A=LL^V+YDfN(1Z:67Fa^FP@[FW]\RMR[&?7>3;6A?@
UgNLaA<UH#7PedL2g-F1//(_@NX1#QbNb,5)U\Tc0XW>V.gHY_?G;eS(L9.[=]gf
bT-&7UP_SO=.(0,b.QK(OZ7X[TZTBNI:QS6:f1_.FdA\g8]S][b>S-WRgHN2\,CL
<V]WQg<fe=#N.4RMcKS5&6#TO4f+UO8:/]+PN.E:Bf\&[d9(]d,6?H(Jc:\_56/J
D>8MG]B_9030/<a<_7X&YM#W9;VC/HLWfA^TSPCVbG_bN-V(?T7^3L&Z1(I83_X)
TQ6LfMYBG1fIRP^YU?Y42b-FA\KS2e<S_-X,8f97B\EgD_3=?AGE5=-9,]He)67d
HXAN)V-;[.W<;.BDQ[OSEO5ASd@F>Z#A4#&DUMF-QVRYS2UO8f>XZ).GQaY:=/ef
NC0gIW@E4HR8<33DHW9eVCD^-gSGHB]3Pa1W5G)-/D1=CN2,g6S(WN_+L#^98P#4
P]TN,44b\IU4Pf)]?b3U74,(fP-OOH,&K&Y:0P-1>SK(<U##XLSMH[9VE-D]Y\E>
^<d;]45KJaUXO-=g:(C:3g_7^<8JB2IgeHR[>S2J>\L0cAF<W:RSGISS&4A9C?65
AIPXIK\Y\0-2/G-+dIdUR/0D,@N=R,S?(,M/M-2eYO;7UP7BJIUE&@&?LOZ1T_g0
aI.FS[<PXJe5@O+RKCU+VN1^1:?@9Q1^2#.E/Z-/TM0ZBFWZWcLFF)FG=(>ER7E;
H02RCGdUd-?\627ZXYRaZ\K.H=6O8QQ,2HSCP-DVP+Lg2+QHYJJ/T19YQYUI,YGc
-+a(-c<XN8NE)98EEWNKF#H\02HS</aC@/dX[;Y^I/X^0SZ8bC3b_AFa<(+\=,+A
dg@_,eSHTDJdY0S]\d1+QSQR^9VeX9IK:M=gb-XcK8bL3)E##7HJHEVRL>;E0Y5+
VV:bA24F,>&_\_\8Y<=g\(^[NcRXf^//B:-K-;^\I6Y==E;W+^D,)/FK.TVf0gIF
V7_4)O37P^#G=P_KWIW3Bgf?7F;OTAAXc,U.\?/8P&+]SA=BdWFC6#)8fKQ^bJS0
=#923]f91\2L)66_Od?,.gdAcNQ81B^eATY5aDVBI>Jb3B8Bf@^_#4,<+LUU6G+C
cQ-CcaKD_MbM4P20<=D(WGUcK\YI1<84H/:cKdK#8_F/Ac??PTaXECUL2IN)7@B-
;Y(.dM9L+>]3FS&L>\7=R;F9^JEQMJ-165e)^(GN.KBcNF19e&]6=/M,YDUQg)M>
c2?Fd@G0=IGE1I\>SVD=GSL#85<VMTE-HCO0QdJWW-B65UR;?S2ZNLA8IGLU?/TX
A=Q:&_N.e9SZ,9agG<bETW:W<Zd??Eb9dJN&=gRe:X+fO/+d,,M:&F#.BcU63\\=
c>H>8Y1PSV=S##?2c+C\&O60>LL5fO9Cf#>)3<\XJg/6.f,c:e6N&R\OY/,]\M(/
Z1MVgf9X+UM0_\ZSE)ZWb16/R#a])V=6Y>?@,_/CUKPPf]A((3E5+ALH<c.gMYUQ
>O14Of=GW\&dETRg\d=;[_d^gT4T139O44KX#>@TMN_ULKbA0KWHK0/<CQE5VI>Y
SR9@T77N)b]3TXZb4;U/,fVCd?EF/6:3G#5ANZGZUIX6L+6=5GP/1_C)F6#L5+:S
CP:,1M^UQc67JU8bWJ#94<9,=_eGF5)<S24PSCI;K[]W?0WI+X=f@OC>/-73DUI2
DX6X[P[)>QcO)5O_f5JMFKGT3@X/.VY./Nc[H@#X->VV&QfVTgI.-B#:BF-#K]gQ
Ne4,f92+L2<VBc4S?+-RQD96CIGB2^edB[Yc4TIa&HAU5EWcO6C;K#/B\@)FZ;g3
914:MW6TQG-Q[P;efQZWb/ESbJ6&V_PDY1U4(&^XBN;OIF&)3EH<(9#cCDP?NbP@
Q>92(FV1GARAg+LK>:O4Ef,:.;&6[5=0;#P?XXVgI;3@J9+f+#C?C8RRCB3G2Ug]
&8(,N>TDB)T3D>\6CM5@-G?Ad-Oc?>LCU(.Q@f771#e4eT7f;S_f9=2g::]<M4&N
gR^Z0HK@KdW4<Rf4@Q=/F&0XAFQ:NfKOU65S]cWd,]#R1\Aa@#ZQ26QM_C:K2(2(
VACaI]ZF2>e]5+)2E5/4c,.cf@N]_d@-C&VGEM;U[FTYR80g3FGDW6((^A5c)R(K
d6_XLC(,YJD#YQ_J>\TJWKEOa5&U64UCVJU-IG^g?^B9W6d_QXfH3]H]N+X&XGaQ
e/[4N=_]I=G(gMZ+NHHMZ)?_A2(M-c;3[WKY-4a-C]O?AE<CW\[T>?TA7G2)O;R.
\23:@Ad,\8_AEF);IBE(RYg3T=eQdKM0<3L7[+H9::P/bAA^/(U[OTGc9W+8<f6+
ZG64H;Rg<E7^g05G;R_e?1B3[3GRX,)VO^4:NO/^,(c;Z^TNgV-;<B5d5-c](C71
:+b]F,6acZJa:MJO;]ga3J@GMR;GdVQ8;.7Db)RLSJ7L\VAZCW,:f]/(DNEE1K&b
JG66)dHQXa0=BI@GB.I8\HFeE4.M^bW(?3F^bMU_Z76M]Q6>eR7<=M(]CX,@-NYZ
I6CD]#]BgY35._a=Nf87[cL9AfF.^:g6;DK<E1-7.56(GM\?-F8-]bW@Jc13@ZWC
)XaW?6L.<>VP0eTZ&#_GZ].3WVGg)P4bB#eL1SH^Z9DT4f/&5(bR8Ve3DORd630D
&5\BB&c+2BI9U?Ic;9E8,=962Lb/J#aK-CXE.,\9]dI(4CD_1L0A@V4\a(O(_M#G
2d02@K.Z5_\[:AE]eEAKTR3KPR\@34Y&VPY_#Lb[Ca;AR:G9663-.HR,J(J0.Eb:
S++>29WBPXZ<c&a^DR8N;?,HaB,EOOfEV]g6E.WOL50@<JJd>S5)>^D6Y#QPQ]:g
8a<:,/E<LN@L7UeVd>aaIc@GZ4GV@KB0KGC<(\L[/+Q+1BV7P/+V\N5aS&J\V;4\
<3WR,;_1Gc7>B5;?O1DZ[6#9da3f(bgb^QXK-SV6==<#B.+-X/b:?CZC=CY8RG6F
Kd(9;Rbc?P#aAMc76#,&-/A3Y&5=,]X0IUWc?#?S-B:_ZST]TF[XXG6PG@@]F:[9
TO3c6,,.CJLdeeP20KU:@1+<2Cdb5-dODLb]2\,GN(;,c/<PaaN]F<NgD10<cL:.
^L@Y6+5XCb712C4=gVQKE]1.?;0C71U.cb&R[BDYD>8F)5W^RZ1G-W\=Z6.WHO::
QRHO0//N_bJ)9<@\D.52Z@U]TNJVXVCYG4Q(7E2(=\RaWXMQ#Oe,AJebV/_2Q7D[
eQ_S[eH^5WC1U8_e]HL.4UIJ&Z&7GAObW^D_;Of-dKZUeZ[Q.c0]00Eab)N^gSf6
WH071DB8.PfOO\^3,E3bE;G2,3J,/+GO1QKNMc&ZB#+.V5C)CCG+aY</aEbAW/1;
BUZaN^99]d.Fa/MG_UYUD/fF/V1?4)4L4ab0A;R5QS@<[O_64f^5,0C^4^A.T<8V
f:Z64I[Uf5Z]-MT@A]P,UXH)H-LeBd.8QH.1&YGAd8a<IV6.XHc:4P>?K/SN6(df
baFWRVI=<6IT+6Y-WBZ--<9d6&V><B2.H8DBBY[I-[1ZF\/<dI4@B5fa.81,A7?)
8Q9_Rc^bC^YbLMF]43^eZ9af#Q:,F^E+8@ge.aZ-JYHR]90Lg8ag(W22F:NIe;FV
fNAT(N]:bf,HbB5c/9<-0IK7L(MJ-=+R0#eWLP@]@6GedU7(K)Z@Ya7.Ugf<J>=2
c(\53CXHQPX9E3[I[HR:RU]TI@923.174I6WV6?5f//U:Gg8</_GJ1&D_c12W\MO
&a>@Y:BReAON:#TBD_VRe(3_^9JJ;;6fW6d0J/6S<:MVQJfJI9U2FPZ_J>^T]WfG
GNa-G[#3+gI]5:^gNNKY#(-=48O1]>@/.1;.>dMa49<eOV[F@/,-<>_P^W/M7#ID
]4T<@TD\X4O^aFXeZ&3);IDaZSTRQWX^C.[R/g)R7],K5Cb[8IAOQ_J-=TX<7=F_
aXP\RN.@[cEA/bdg_/3\,UOFKTEC/1>TSZ(31J<,J\R35DZ:;H#I?bZ7S/ANW_S(
Ve5KS>A+:eVG/=<#6X;_I:8HDK[L-_c5L0IJJB,Z:01f,TZLW4V;J;1A?Y4MK+[(
ND(dZ7^JBaJd^+7IAG:&US5fO;P(._&>WGF8/6P_IT-6TEfMFKA4=IfY-Cg6J_-D
/Ie=\CI=;)Kf+,5fJdUfN:cS69&&]E:c<?>aK:Z^Wa@O:eTU4^>.5=>b&[HE1W&\
EMe0e^2^MQLbD7LT.Eb881V-E&YCf>,bZ^SR;.VJ[9Y_:4Y6If5,DgH;IM-dCc][
7&a^B^90AfKcS3b[]=bFD35HZYROPYe=1YA7]UV>,H/D9NHd.2Z9b>b?3CP7:A5I
H+R#^S1^OaT2gXD.<@7O7L\:RM1^H./c#ND/_0caBaW+HYG+#;BCVSJAT6N6(^A>
AgeU+SaGON^-8_Ib<PUR1[B2#IfR--5@]cEHVILE2(J\1PM1AH4GF_X9Rd@(3#;1
a4SZbO&4#88Q,@/FYe?,B5;[E4C6FMK0Vd&F1^@d@4gI?E<RBZO-9VO51&4ZT47E
;9_&PK)_eUEa^3;J(-gXFJ2^Ea2f6R,d^45Hd\Z<^#eE^CYM;9KgQFJ8bXQP]2T+
=aOEEA7=Y49gQEWQEQ]GGWU1A?FUOd365Q4W<_V\/+M8e<dF8BD-CMa+<G>D,]>G
Fb(@Q:gRF@QdC=KWBJFCf^F17dU>bPA<R;&JV^JB=LEa&YE8.7ZAYETa]0<DKV(S
H)[L&aGf-Y[KS4Q_aL8e:_Pf,86T<G2YN.0V5G9BN,.FgT&X9>\ZZLR6CEIC00:7
RS\I<^4V>-K=d+VS\2)G]9gcA0X22e_@[0FJe<?<V/3U8N8Tb>Hf(DTH]0^Hc[G\
>=,6I4dO5Ib:OfDd5JgS4F>?S&0U)P][dDK\8\2RG5RDL7+(18OSEFZ64N:2I\1.
85Tb5D<(R&(_>1><U^Fd=6NB-Aa[cW7H)X>/GFRA-=;^MF=;CEJ(Z^BdS_cT??RP
53JI194Zf:_9.45e-16]8KLBb\UAES<Xb6+(X>e0YAKR=\1U^a_)?a7>-[)P/a<+
<T1eY)8TN_J]4-e:./=_PCUeH?Qg8+DM)1:a9SUIP3>;2#)Y0\B^MCb,a0LEE;FH
&K;_L<R:E57fDQ=_]VAI#)Vf.A;OMb3(K_4+f,HT5QE2_NX^BQ5=[^J?D@7ZgEM#
LO8UKA8B19e892?(Z)f9,W-dT.<7#1-D3\H#CIUNdVB3YWe(KeCA\K4_]32Q:]Nb
e#1UgPYMd4H8EGd6O++AGSUdbQAY_6ba(>e9OMH#3I.>8]+f-c?CcUIKd0I;dE/@
1f_Rf4<M38G1T3WNBM-d?L-@Cg^SY(E(T(D@O1#XJ&#e\-Ee0J8J^R=]4OF@,R8T
;TM_2We##M.=_SF6RZA]49Te>7^@1D=1&UdB<OdfB9,WXeJD(#D]#8I#<)dfCTP<
\^YBLNY17VG2?;/bGO-3a-e3HA<M(0-&E(LYDCO;S/c\R]([AE(<+I<@(X50I(2&
eFUV2;+P#)J(fD(3gX(YK>?NSCDX+0E^PDQZQaf<AT:2-cda3-H+?]C=7H4X[J2J
Y-ATI0HB8-66R>2<VI^XAaQLS:TLY@+<+.9Q3[B=G^47/3ef3UV?\L7M0F[4eU?)
V)F8BdO6MQFTOF6fQfX/;Ob6/11?IW>;9Z#VcEA+]4/a20Z.eJccM[?<3&(1DD))
@_&^#C?dJ06);91G+dYW<JNSQOb&cPA_,>B35Q1X[^H.d]._If>YEZ6eE4&\Q.GL
BbTbY)_+,7LCB&FWR<KU+:7ZaC,09=d,>1Q9PXP2/4f704F(R_[IKWS6^1JAdP6]
:d]fM_/J>:)L_d=K1YH-Pc+.+NeC7[W:gG2VVH.S?WXKA#/9Y<ZFd8O^1RDYT;<@
7L+Vc<?0#Q=]5S^?+@K1@WUf+:+0?H9de]#fPI)&ZK)XBAO&HL#c:7J++5BW\S>F
Y]S@VDY?5@-6;g@\gYJ4ZYEAOANbTa7QK24cT:<2NUTLUBE^7-:,7C6GF<F[(?Pd
QVMQ-OF2CX])ac?,X,e[E]ATL>2&3D;8YHcV8(5J[<F>99=CY(VR7YJIQU76L2]V
c<>]0W)fMPgJ\T6,X/8eS.1YDWYa9:,PGE.X=0#fG[>@63LL)Pc0@J^64)Wc&f^P
.R0c-]1\I9I?PHTP-1ST41..P_\/@59PVZP[f=Y_g=8-aQEgN1]P9c)c:1\@geBF
FA1g,PU-Ca4fC)7KTJ=7T2>E6>IW/H&XJ?bU?aEFf0g>[TEC#K1IR#fH4DZ,6G\@
8;)PfKYGB74[V;J==)b\/T=G60#WYEbN<ceOID-)0J.DHS6LEL3+9HOL7:9^#F^@
Y;(#1d++)=@CL#GE1FB-U)MO?Z(I4A;g\6g&ZQ.SQDVUI,+(:)HG3Ig3e#CUCW43
bdTE24)d,L#)ERL/R>c34J93e>/AA2@YA9-fR3Re0Xc_)]dYdD^AF^XU?V1_38:d
+aUeO,?=_U]2NcWUJIPfG^bHE97(4UC/GQ7G2.LdMMTf3aX25N/K,FNAU?3Cb=C<
O895&]N5\[0KB]SO[GOVC)bGT;\H;B-21/YN:T>R]1IKU)BI60MG6g_J<BI/EA)-
G_c@cfa/H5e-E.fbOc[+Y83Y5YC@/X9B0]fCdKJ_TF_>2H;f#53c=X#0W3Ya>TDF
HKS18>DJ<E6gbI>Xg?aHO]DR[^=3D@<&4IONT+?\1P[#7JGCLH/NL9BN:9F//[1B
=DNRc6?UU.:g9\@3@35C++.cM@0TV.?-HB/dW=84FDGf>P382-HJ5J1:eHX;e@WY
/PcFZ39](g/&9(_+YB>GcHV>1P,_B;-OK8d#U&5)<?14&#I:RR0[3,5_cGS:8[7J
[6&2>5,HPMR,Z<O8XNMJ4c@[9XL:<A5&&dJ:.,1D(8Wbc5+#cXeF7^DT91:&R_9g
]5BeRZ0823/5bTREJT>b_ed4Sc?5cDF\?+?7c:#WGLW8SUVD@U43;^)3ZF]@Z8c-
#gNP4a-FHX>e>_>43K+3c/c@VUYS>L.eAX#[;K#TS;KL;bRD5BI??MOM9A-Z1gV)
a+,XKG03&Y_A-QT@d<134dN?HRHa4OBK+K(N^V[c3b0V:fe8@FBO&X-8DBE>8.>?
ZOF16SYC@dWc#Wf&Q=f#6g<7e,P?FE+^F[O.1ZPbf_(7TS2S;@A=,Pe#;.<d_(7.
GJ[#SOIP[\>BCNQH4/QPNW0a7R1#5dV,=KTTTdPM(&[DJ,D?Ta^Cd0c3FN);MSI&
(@.]B>41A#FRK\F;=YX2#L)[3a?FJK5a^9S^9@V=;BFV4f-OT3</(gT^.b&>+3U6
62;8SOUG>W\X+32c<>V,4846bB1YJXWcAZ)BJJI_AY<Q?[._7YT3(H&c?2HCSPDJ
eU4J+CTOM/]VNe,LN^EJ[)B:NgP<[;WSE_Q[b7KG3XdF@6_WO2c[T&C9cg<-3;^g
8ggB4?>90+,CTMJc&f58QU4EAI=^e^fNFWfV&,49KE0ER,M)8a<aR>8N:0VE&d,[
])?..8+C2?;W]B/\fK#_FBb_DWeNHR[HU]3RY]O#^&<KY_TBbPe#cc\O)G99g]+5
3I&V+.AA+40K(aa(Y(AB7C>/=)C]?bJc)IF+)9C]0@F9\COXfV2WIIJR\]a@J\DB
L/2T#4<5A^YBTY(W(_XM>KbVF(_I4.PF,:DE7_KSI?.R<UDX>]3a&W\A=,_gS<]-
A+fVGR&(@cDDBLRe23[S2(F]TMEEF??A&K?DgG,^]<S+bP7I511UA+d;&cHCL[Z]
=3_?5JU-C5Ha#UWER])9IAG)X7aR?H+aC4N+B(1P>]J+8aAD]B(</HHZOOJLZcc3
,1M4M0QA(4EH;Gc6=?OO)N8TVK,E42@]WOE@7Q+EDXgB][dDRND/-g>bCN<\JHDG
&Gd3A.Cd?a+_/O9cD_=gTOM(Y-U+NR)2?ObeA]N_#FcDX2b0FcgS.Nc@Cd,-U(^R
NP][&(5MR3[b.A7S5:P,MU3=D,G8ZKd^V/eg_:.)ef>8BWDL_Ba@/e5,dV2Sc.<7
O9WYIP^N(>;P?(K2BdL5DY_fb0Z;_]1DFV7NX,cGB5&H63[]^=[IEGEbb)^Sg2<X
<e(UKXAYG&>>A,\P@G7)DT]EO\TH_A:b\YOS]?E;PJ3eY_?dA6JE3S@f^@OX)A2G
U^HY]4)@0]?V0_L,g1J([G0gI^VS8LXNLTY;/OJ1f^,AV\YCfQG/c7SM[55MTF/4
aQ81B93F>84TF].BO;EMf9IYcAJ?28>(fZONdMda=TSHCP]=2_?QY?E&TR-WJ(V-
Q19/6g7FYD)e8QY=YQ/LY9APVb#=Wb?,Oe_Mf/PP+WaWAX)@3ULIWO26P;(]:e]:
:W=L7M7T1K7c3K9B.U@9#^+B97779JJdL)W-.7@#b))Q#87GgIUg,91f#_(a[<]J
9ABcIZf)=>8,J57b&-V?LUeP^S9cMAIXPgAR=I^RU@?EJaK7KR(SA:L9K]V(&DM-
7/B2F+):34:L&eBJ97@Q^Ze1-+)eQ-PeeDKTfOJTZM4fcMeZS3f\BM_6B85NVX(B
/KU3Qd?@8NW093gV.8MT#PFH+I86b\\HUWP^T,QCZ4<7UKQ]=.QdU>EUdFM+/JK^
Z+^@6,O;Q_/eMXD)\d#SUY6UI[/;0>UR.A_WcbfF/?:Cc=^SR,_MZOA(GID]O4^d
1R@:Rd/C2:KYZN25J7:/E-W/0CU<aJW<;F,<QG3aJ?SWA0bF2F0eO0a4ZH#;9WOb
H:/bP5C5X7=2g;_W3VTH\;=T/(PL[80R14F(Q16e;SCM#7/ATdVEU[E-)>NN6f=C
]bLVR&]-IGecW99(9dF<\Ya[ddCGgZA/3O+YT0A?MScIM8QZ,@FP0[SKPY#1eY6R
Q[.1((=E3QA1T)GdA@gGU8FC9VVI:I3#RU.P,c@TV5PA?R(<5aK))aA_K;1N)\+H
SD:eEO1.L\5@gcD;4CGY7VJ^]+MHH(K0US=1/[F<]/#2@S9((bD2;?W2Y9g07.C.
HHTGQ-V.HR.Y(B5VXebGTPa#W4,D>&EE6>KNATQ[F(5?UJWPW\;/RT6g#\11W@/+
^6AVPZX(/GSW#H;F;W6M,=,I9^Df+4W=f&51N:ac1N_-=#JKMfDAF+&#J^0@&+g:
_GWRd)d1TW>9,M_/;d^V[DE:P\8QOD2-)WR2f)+.3g_e<\SKc.9N42eU,_VC;FHN
A^9X5<gCaK^EebUg\I;X0==<Le.7WMH4c+=8W#,H5,G__g>TgNDI7M7^B0,?L\<3
.4,BG(3>Z:ZCN+bb-@f,4DUXG#ZBf)&&We-[BL7gC:/]CV_GU^AU(bd;C)AcPH.M
&@#R0b.O(de,7BO:d\/BgUeH>Og9L#XT<UYLS4@7+.<Bff5UD;cP_I[0@(MN)g2:
_c#;:^g-3bVg<R[:/\[/L59(B[RG6V[//8YM,P&@QS_CKZ66R2-Vc2&+J-),f2=^
.3I2E1X0NH9G#TF\4/P)G@E0&3DKcCc8BcMHdZWF)AR]T<X7QOLM?EWNN2c=gf=b
P\J5&C-M.8V=FBF1:^<Lc#\<A>#5PQHBLb:(3Da2eZ-JKfKL9VVce[/P3ZV<,5^\
E^c9NJb;NAE3Y)[g]]WFYaCA=H((Kf1?A_6OOBDZE+FTKSc)1B<VXbP(a9-XK=a2
bX>g/gSYDSA@#,9ZEgFR\QO9D8_TDHId8I[6a-E]gI;<1681J<_)UdAD1/2;RC7]
50[SG4[.g+B>FDa55,K\2H5Z1-W4SARQU/:I3(<eb<H65H46J+>&/XE4[[8g]L56
cLIPH+c&U2f1L6,)DcTacZ3#<L(;O7fMBEM,:eBf[(>T,S3IcIZ;bBT&0_cWbV7W
GTO[ZX,22R_P4aNc<aTfC+A[f_.b6<1N+RaW9LXFa5UF@PFZ0=ETb)fFX>AAF[3;
42RSF.](\L(dJO:G9fCJH_FcS((J_>4TN4TPc<A>9L>I\a.+9L9-XF+Qd7/VG9IW
Q5BDVG3X=VV:D2#^7IN\O9Z:V8)C(O/9BT#TG3[ga_@<<),&OaeRA98W(^g)EZ(X
,RR\(PJ\P/=\CY9,K14,XL.+)YJ<b_VQD\QID:\8<6AO]SBTCV;9D>&2R1K;[N,c
cJ)3_?eSQ1Z-,5Kggf81>W)@KP6E_DPV@T<7cLU<-)NLP7ZTgg0/RJ2@_5XNTT@6
FF@fWP1gc8&J^ObGS-&;Ra)8<JM_4?FZ7BCafM)9,Ce:.P<a/L/].IDO0eO@A2F8
O?Ic?SZ?c&JIc4&>7;WcZ9=-(<:QN1SI325f2#<b,OeITOXODEac]#CHFVM,R+Qg
6=OX0\NY7g;98NG:YB_6QDHcNa>F0=G,/E\ZU4?TN\T2X>AJ<(EeeS0,CAQg3AT8
cST-?aCE]bBbQY\Ng\?#5NIK@QE2OM^[O+61I=<V]>P(?#=g,IYSN>S@/;-W83+(
NZ?)?\FM+1-LN&6[B^0<2I)cc-2;?8IZ]K@+8^FL5bbO3e.[+.>M1\_U1ZO2\SPX
9f[8@4b85;dKEB##COU4^X0dS^_&;=b=U3D6N.3F]b9,3Q@[><dZ6#ZSdACV3a]O
B_0(GQ]VOfgP7b[c7)CV;:\&&K<3,P@/eG=,]6]3<<6Pf1;FWQ;(6W\\N76ZbEd+
98LZ6L;R]JOS2D&ZecNN<M8F7b^b)H[08bT/WM-(J)KO(5\=2-B_U_R\70.0fAc<
[W6XY04XL]L&J@W&J.2OJF5T;e9B,+45[d:I(e87NYS((2caBJT1D-e:7JA&#Ce-
IgC9\CZIgC8H\6[KaUe@Y^(M\M/B[?eaQ?LPCfe<;]:F)cBg?/)Z.1=aZ<B)+7(_
OF45-ID#9De5AaZX9<dDR:ISL0X^_3JO2]T5\#g(>aNNcL3ebAKO=VUgT;#HHC-=
ISF0d1/U.QK,c.dM5X++/)UX(dZ)Tb[:@^Z>P;3Y=b0]K9>XM:fD5^G8L]R.\2@e
&2F6ADU_+A-@1T3E0X3a&&>]N\)J_()]8&WYfge4N0]+dYf(.HXDLfbN@O<T5\Yb
5-\e^A7fCG>,TXLJYR26B;O<f2FUVYY&MSJXJ(WP4Y6L=><>5La4aI_<eW#/1fR^
UWHOQZHe[+g;19^[g_N2F5.\;+D4Oe27b9AZC<D40Ce#[)JP6M#>,g76.LY(&=SF
6De_C.+CA;&0gP,315)?dd=^MM]aeE#g)_0[Xd/7Wecd6FN(Re+fS[.W2H&FWF.S
N86OKN-^eZPJ/ASg5)?e243fP_HCHPT[ZeJYEY)58XD-S5CRcI_,6-F28ga#6LU.
7JE[0Ed&.1A]B:[<WF=#Z[ER(ZKXa9A3>,]IK+gEJB=V,BNg@Y5eMb.O,4LYO)7C
b-bRO5&?,_:+>A[Y/Q[ABX.IY3J,?.b)fg#^)D;Z)&3/XI?fE-f&V-=5+C:@12,;
ME2b(F<fFAB+AaaSHETdT/bRbO>aT\842F58P#dJ+-?R\&8ObITOB5HQM_Y@TBI7
;_LOC7Yb==ZE&7B_SeD_\5MPPY](I/ZY_93V,(;:b)=]S:O/37272)YV[f(LVN,L
7:;RLb@AB;^M[HZ=@/c2Z^+6R#<#8fJX,(7VbQ:[OXJFQU?AOW,J)f(_X210EB+(
AZFTBfcRN5P6f(,^8E/]@6+H4SegN&<@>M3:MNdHO?-9^.E\A_^XD@\J2JSb2VF<
a:YJSUCT:8;e57@W4;2=]W#U]@CeRBObD-ORJFb8\W0HT>.gQ^3P?X2fBY4?G-cV
QdN(Uc15&=ZUQ)[f08TR(Vf?7TL/#[BB=6;cCTc@H2W&X,_(4)Z9IQ^Q:M-a8>-d
GG]=L,C&VR7HD<7@LKB&QD;K\Pc47ca:86=NeB2,ffB(\/g,#&c^g&K]:F]J8DT0
42#c?HL-1+Z9&3#PQUa\MBC8:^f>(8ANd7,7@\-G:)S;QA>VJQ1H\QE>>K&?65TI
CC/?Tg(3FGaa\]JegM4FM?Te>fN]-;-(Z39+J;a)OQFd?V18Z:@3/ZO7&Na6g+[[
;W+P_QQYOAU_\H@L@V<.cSS[0^g9?IBNgI)9NRO12,@[U_8_UVBV_+OJ3#f3V&C0
V+R+?DSQ>2S#4cd-Re#a(-cf,ec8LW8Y(2==3YR8;E.@>0A(Aa+H009(5..&E:D<
D<.;6GUT\f&EYYMP8@_:\8N^+K(GSG>KbHJ7BgC?+=b49>BHOQ&dQ0P,H9+9eUa9
NNS8Bc#KRQ7,#1:)RE0_d+0[I;;U9-F(fUVC6MR2X\MG[_L@E2B?IJHBU5.OJ6Yd
MX/3X^Y_G2YPgXe#VJ69c]QT\6Rc@)DUJI(5g8>A/_?)1gT[&#-2SY,I_g0[1>a_
J&VEETfS=2ePZIR03:7KH/7W\D)^8;MH#0PJGCKS]>4GJ3IS.^&5V]B(<XBada[=
b=cN_[L[L(OQ_)N&JbWe@8W/T/TRC_>MP6YXXeSX:M,CAEA7+M4c>\9,Ked=\3BA
]5GM=[P9.4?,BW+EQPf=0]8H@-a(@LGRWVQ\bHY9SPL0AHN@=B)[L+_fc]EZUJ\V
(YbXT)LKV&P1,,)HSK:<-68KSB(gg6<736Md\[MD;Y.,WE1<SBc2&RH9ZE+PG9_I
<,R1AEB.BFdeG-K:<VV0?2F:2T,Wdg@d7Cg;(]B_aSROE8+;T7dH.MKfW]J\P>:1
ONb\/J:ZdHd.RQT&eX7WgON^ELO#Y_ZRXX#Fa;GeVNN?]IMeAR49MON,,2P[FVY_
R@1>)0D+1)QK;<X+&?f0=KPYXJ1QTc&)JM1V7(81P;06E<^&+#C^VFfFIZ8JH^O0
P@=acLD:dR]a\8LMFCG)cWb._2FNAcVGIEL[+60c\Y>N]1-S:FF)USg_:.;LRKF.
PHgS8^NUJg1VeCY=(RcX?Hg\PH.N.T6TXI<P+B+d;c=eb5[f(R7PC&=<KSPKO-WQ
>[D3e8gC(\Yd#ffUaEe9FOeX&8geCCPb#3<Pa16-_JAZ6S2W\cM31#-8J:QfJ(DN
B0OKG:Za.82^4b;[X6F6JXVD^]bF_\3L(eb&[f0=^_c^O)GcZ9/(YA>+K;Cf7<b+
(U+3SQPOaPg>+A@#<)O;&@[gD4TcfO(XObEYa+?WMC+18B059eQJKD@4,>bcg8C.
LK@)LFCA4H)BA8(?dY@0LY(;a+d@[<TZINYWWM]OH^WV3aJfA..\I)T@_>Cb.(NA
47c>F/^IgOS&/)aI:,M^UXFZgUL)O0P4XVf4A#d#Y67Y/MQgX)@PKW&24:(7H;3U
Y[e=:31ZdVUQL:,a8beR,W:+\<3\Hca^Z3&#LIdWJ8=>F.I,/OfW1W359\9[[AI5
[]MLVT2R+ceLRH]Z^H:H7LO#0N^\N(;IO,Ze4MQ7B1C6OcE:S(C<LHTRFb6(_NfU
ZdDX602Ge,fb&L<F)NNbY4,EN,E[468O]8,JVId?1SP2[c?8\g)@[I<>YSO121>B
[.7F[_QT#:6a)e_#ISa\I/I#;NR_LJU.WT?#8ZJ#Q;@,2_LGLdc&#96gHHdf8)dT
/eHf)9F9B^(bROTB:DeZ0H2M&]T3K;3b7b(NFM]PRL]]:aUP2_T<Ld/^/LF(8ENN
SVZD]L#2g_BDD3RBe2K=AOZ5W@7X]H#E#MI\a3e)V78NJN8@gIQF4;B(@HPRB5S@
?+.QD]fCF1;PZ;XJF1:\4ESV[Q+2XFG>7\JPYd#bIJ,+I)A]4O4N#9f)GJ_0?4<5
Q5XL#R=_eLP(FeELFR)]M6F/QV4YTVO0\_WB3<0&0L\/9..5-GT,+abG8Cca7:9>
N<NfbS]13-E:BBZ8U/:VVYSOAP6?J<&WUO<=LS.^S&5PP2^F-X]E83M]NGD,g792
\XBA8Q&e:>H/H2=_WXI(QH<M33WFTQ(N8_T-5C-4I9X-DOg(c,Q,gaD7:8WX6AJM
Tc1\Eg?RO_?^1X[QUM7G.\\61@B-CB6L,U0.QE#JTA2(9WVMd_0Y1df;YTUS;,62
0cH7V\JJM<5G41C3@[\0)N3/_@__gZ,F:JEeCG4KZEX\-X^?1>.dOM\6Ie]3(g)e
Q>0DR&e4,52\.Z6cX@O.2\@4V#b=-8VQJbZ1G16MV?L?g&Ae]32f3A+W.)++O5N;
/7dAE[S]VE6aZc2Pb\>OF9c7g@EgZ[;f].d_=PF=P<_dR&1BgNM[\<7f)7W.+J9#
VAPDOKQ5+K+=9L4,4?G9YGTYQVJ0KcaAC9b24.=.R#&(:LHHY+9MAB2bG8aL;QRY
R51Jd;ecb8X_]:J-0]_(>GRL[aZWa(B#1fR\WJK^B+8eg]H\Oae:P]&H26M/f)[N
-FM#SB-09(Xc:)&Oe29f6#=gZ(R.<YOLcA4\/@?3&4c]U[PN_DM5ZE2\HVD>YFM#
)G0fJ]C(cO=]AZgUFeZc?=AP@ceOFH]ZL-aV&beM;8^NN<c+BAN[-ZRVTJ,gO.e/
4dR8:eHHTUfO?A);4,#UOgEc4JU1(DU&Y-2S+Y^1XXP6TESQ1QKP\1]0.5+IBd&Q
@bHIUN;\EScLR+6C1K9J,I+DS]<O5M)PVLeK759C^MPgG\(<U]J.A>a9Ca9_[ZaW
?W]V&A-J8X,_>OU[7IbE/d/5#LHegBa4L/;L1ZT0fQ+Y6bccB1[Va_OgL@(CXHOC
7R6O0+]><UIP)^#\HCdb\-2#)HF[B^.V;HXCU4Da-.Q&g(fS=b4R:dg>N(CAY(QJ
WIK]2d/HT_FY24\:.S+^R94FY7>,\Td(#,L33S[T+[,VK+MUQGQ;MOSMZfa)2YVR
>dK:Ob]Y3GX91BICRYFa8g&(,.MaM_gNIHCL#Nf6@_(cS=<BBUb@R=KAGL<#aN/@
KbHSAV#0b)X]1ZLS^5R7d+-<&P-:_ON34c\?N-]]+:(PO,E)X;IJY]-@YY-@^=b+
b,+;3-SaC;W8G9N.4b=KRcf#C9H7cc^Q6XUJYHL)#9HS3NMZg3d(ZeMD.b<f8SZZ
,L,^XZd,Q_F]?J3gZ0?e52Q)Y9?.@-B2O;BRU-6;[gGGQCO2SY)+:F.;3,)fKB0G
X=)2@)WIC#X\\0__Cf?UV--H&<+ZWK@><Md-D7=NMM0^d>H<ZcgFNO1[D/VW8G6>
R/GAJ4b[cD<aC<e0L^XYLgR1^7</+g30fLg-43\OAB+9eb^4P/aW=S)_9H2R.d[)
&&+<X=R/#4\L[FX02SYQg^^faK,f76S\E[EY5VAQI<SJ>.@@@/-=KbC?Q]D#LZ.W
.GJ@a[IcOZ;,^)CA)0Ag:NLUcM7T7YU85Ya7YB<Q^TB#=>gdNT#C16RIRe[5E#,+
dJM74FRe,a<:V2=IDM;9MHcI7N02XAfV9g3JaQ\>dC()[FAE_Q?>OOO=D(^59.YZ
5eeO>+W&gT2U6>K<d;F3@E3gP[g=OeTSY+Ua8Z+8<A(\GWdZVb>+:eGg6;R4LeIB
)CF+?fJ/-HBZb]-7fJKW?#JCE:P?XL/9f)ZH[,_;],aMbT/N))f3KLcK9P;IU+](
I_\I]fN\LM8eV94BWA/e_R05.YK48cedA]A<#bZ@D>8\(U?Re1BD&0GT4MW<UBCX
e8Y21\[L<gdXP<;R1JZ,:@YfJ9A::;FBKK#;YfLDGK;K-)P;[6\>?ASZ?TRH(?dN
VMbNN#Sc5_VF8g?<(g11JNA.[?A2AaQVd#YZV_QA,Ie2<Z)S>5EWDaZI]e#L<V&Y
gV=7@,N0E#U.c9@fM6->g_\4T(FP348bAU;/J9/&K1-R;HIB2R[94TQAcd:R:&<g
+G+bW,1N9;-OIOC2MHWP)@C\P4>QJJ@N4;(@#[J?39FD53U#>-(E<GIC]#NMI=\a
[E#Fd^1<<aY[UP4)dZU]PS=PSJ7B_gNQ-&>V]8P(ac_16J]ZV6O7L4/=UX^WQ9BA
?b:_6ZI=)BG6=eVXO=?:^^1CHKBQ2cYcf9Z-8&4S\dQ.&gN<0\;S3ggZ+>/GO/Y+
196_4VK=4CD0ZGZE/0^])WIRa/f4:3C,^,F6>]_NZ9Xge3^KeD)VT#\LZ--D9<O(
B,<VJa@04Q[QP_1U<G-AB9Sd#^>+NF,>BYNY86,,8+GKSPg\eATEaDG8+O-^fV+W
Z-cIIg@(PK>+d_I3Q?N]P>#CVGeZQ^fL9E19FK@0FG^3;e7YRD<CQ7(L^40MT6.A
OQa;^_cWe6S#.Kg(8\Y#g+[-&SAJ2VQ:^2=>SF6,A=IcRFW6\76KBE]MNE)LXfd)
N&M-T#a[A44FR.CPe;?7:I52/S,2/=X:>(aJ[N#f:,N6+e;B;<W-DgY[CU:0M95Y
f-YSAQ(6C#^3Vb4E1ddI_.MDA3FCUeKZ/4EL;g::dHbSU9Z>6:0\2ZQE#G;5a=KL
R8c,&G=Z7+BWMB[07=Ba)UK\9gM\>8LJK=,gT-.b42F1MMK@J_VT>V@>S6EVSGe?
J\NUc(A,4L6HMKd<PI,P5+@DM\EK+.d)DD(-8a(f5Zc3LfS]Wd5Yc89IQG>E4aX.
57dU(P@7\c\E4eHPA4Dd:W8ZdaLfS7aE]FS#--2f>@d7\69W]=7)1W(/b9:/;1AH
=Z4F4(8PaH)8a7]TA_dS+WTDbS#2a11]?^gQ3E6f-<H07W5RFS>25HX_4-RK.8Z9
ad9Z/)9K/I])1cI&;OA72g<TM6KIV.]JLDXODf;gKDZNgc9.GTK\]:&A1TgOT)&_
1#U4aEcZ#d,4+AE652:XAYZ]gEJJNZ48]-\;AD.?3)K@a;561NP;XDcIaeEb)e1^
a2<;(._9\V[>L[#>8Y::2BXP\MC82KD,9G(\LO#J^DD7U[+W0fQa;I<#2X.W+2-<
YV?Q]eFE\4Jed)gOZ=eBC[7^<b8Y\1)IR8TY-_cP\S=WU1e58+<K8=\/08FT[/Ld
U1@1g<P\_>b1(S>U1-[M4XH/L2=d8@/KW\cIW.-<-/-/G0CKWQ\I(B1?^Xc(OD[d
?&+ME@KfdMB/V^/]L/c9FGe\RQZB?[<c21ACVPg70c9??F3#(\NQVHgBJ[><Y:CR
_-@bC@cD]UB^D\#XB9D->:6ITCKd^)O)=(U[J2;\&Y7;HLb3XZ0WB7G[gCU:\dC^
N401Ug3=a@]&BG7M,?J)[NRB1K^ed<?:@df(cdU?E4J:U[/HM]S=,)KFa_Qf5^2)
+DVFd8?IO[fPN3V\3TVX=?GFH<G6AXaIf(=HaSf(\>YgEcH]J/88f&HB)=#8cBe#
MgQPF,;8HL3I3VcA8-0Kg7a-fb56+/NE(#TN7O#6I[;:@\6]W4A&S#LY><a<8I@4
>fW-MCO>FNKW+PS2+.5UBAT]WHW\H-IZ:538#VMDO6cC^2K_=I>0N,#R?c1=5fV,
39P.VA5I,3)MJ4OVa&M4fSMBRG15+c[Z#46g0H7\5AE:A<KGI,g_:2I9TOV&H)^Q
WG1D?UfZ:R]:LaJ,Od)I2^D4cE>Eg)3cU8GX[QZ>ZBG/35H:QBIGGWO8(>g9acQN
b+=7]=K6#NcKN1VNC)1aTd[c(V#?407dVJZP]Q&203eHc:Dg>_PCgf?AM&_6=S[7
Ob)6?8aC??W^)_<VVF>_gb:R.ILggb[@->#Ngd^A1gU-PM^a2\GGL\\SMCc,&Obe
+E9Ra_EgEcY=H62Qb:6WQddYETbaZ2D.B2-2#IZg,gW/##B/K.g&,]ff):WDO\8@
8:>2:1K?XH\aE(9IPgbeIG+FBZ9Q/\<^#),ULLT6BHec]<AJFbUCI2LK_&BZ_X>[
4&b>8<II9NM-I87N=N6>UK8dbF]RdJ9\3QRO7\9Jdc05,1\S[D/XU)VV1?@,OG7&
8T1bERdZ+NJdR&L@KYAO/AK3BX6HL9Gfb^cX^LO&X?dcPG77(/+a:2W_L286g[gW
([;GIQee[BM)bJI,>_#GU-)V2E\::P]d51(&>&+Y1[H=,g[gE+5NfOC3(dRNJ_HE
Z,+dB\Z^U?ZB\B>WXaAE0bY[E0[PS=.V/9XIZ4Q:GO4KAPP5Oe)4^6V43C<C8L+4
L]XK8Le4@LOA)_8X/ZgR1W:g[M;I^/CAAFIcRSWH&>X1-\KLeHg&ICTY)<a.6W+S
.:B7HQ+(cbG;[G(4UVG@[U5Z<LNS2e9\H:UZdP^P6Z(U@L3J<5DO\\Y7V?.;e&fR
I]\IU)\FJKS12Tc:)).,:+93,/Z<^_R&0378NM;DaXO-bR6L92KC&RBEJ:#Q3fbD
X-CS)LMM0L>]JDLSL)XZH/=LZg(I_;H\T+beQPL>COFX&8DbFe-O+G#YbGDKM4R9
CT<-R,H1Q?P,#)#><LO;>P899J;W]&Qga[?]=N0e<7?;QTH]L<9[&Z;[8Ed]2FS)
DPPWG36N_O\1P2,Oca]JLJUGNA+Q[T4SR#YZZEENHE=FBc<R??ON([XcUC1ME6J=
ZGZFDJCb[XF9RASY\fGcG6f?H^0T:OcO5D-fX]/5^)GUe6-OYg\QfQ2CH7f7>g)E
/U3//VC1?N)V=B_g40^\]#@51fQgeB[(K?Cg_)4,I7eGP27)TE>_M>8T6K(U-DI4
fbT-D,9<SY\M]MYKfVW3V4-8&?KEe0BRVacf#.-W:2?DGLI=dUBZS]Wg^E6K<cM&
WV@VHQ3KUdDf,=ZKg_Q<X2/>WU9S7?0IURNQ)=b,CU]V\f#E5CNTF?37H,[;fYK>
5HUN-S:--@32TG+PW;G/a]Xc1eb3[We,M[eCPC;-._5[0XZ&=[>9^JaB:+1VY=RF
DQ\78<dX0#O^HCVZaE:^/-NE+\IKHR6\433eP/=W<EcTdUU?-gE<D]=d=>,2(X3^
Z+aR9fCS)a;g&cO&=MU[Fa6a>,W?=+,B,TT3/YJHEUad@_CZJGW1Hf>@.5\,N--4
XC=b@@_ZT=^\A9g@.BK;OJIL?-=6g#8H6?7O?3&E(Q6.f]V6N311GJ5AZWg4,4_2
XZKZWI1\C[V>GJJ3A_;5O,[gaT.N-CC)00,>#?F&9C9ZTINR#YQ<IC=7&F<3YEd0
8_K[R3U1<[>#S;)BTLG^7g^-.=Igc90>&(O\HO9?5W?2S77=W<@U=-&.7a.[2b+\
Z:BIAO[2,@:BP0f;R?>-)#fc4-EVLQ..Kf#8U?[aT)F@(:<&\See3L)>]/,H+=HA
Ad4[UM7M\SZbfR6AHK>MI6<GH/_NS5VU<U?I)gdQAA#OF&9HF_EG\0=_f\,:+YKD
bH/S;AAD7TC^^db39ND@_F-E:\#dFX56J;5e\ed9\_TDV<OD.T[.D1+;YE-S/R]D
8c5K4L]JSfFSP<N163<F=C;K25/YbGNKTT4ccZdc-+M@7U?dJ#bFAKWQ6U5a8Ud1
>J.?CN\D1&=?Y[6PDA=4JJO3eGdLNa;S=f+N#3NT)e_U>BPMbJbfS[EFeab)0D?)
+SO6/U1[NedKg>K1BJd,?LA0Oba<+4C]C3,7FQ7/_#I+_=@]e>.HK)7bU)U67K8+
de+[Q;,@I4/TU[K)F+cS8E15##Dc94O(<^Q[&>+NSK;D4<2Q^]H5c)0NL7CeI/S@
8aNba2;0K#5P+Y3S_+>#0/WUQ+[WFG5e0dWH<FJ^,?fV7:9_E6<_<1g>Z172IT_B
5#5,Y2>,^Ydca[WgGC<6\Y=7YB+BSO.A[bbKHT>PO3&@U7Jg+/2gcJ#Ua\,8Ne=f
BB,b<8B=/AMEOG-X82/C9OV#U;]K>c69dQ&?2U>,>/LYU=]9#1YEGD-(/KK@CJHU
a4FMHQOESeLb8VPQgER=dSOQc)20:FA)&AbPEK=gT&#+UJ+D+<(_4@)g&\_]V]]I
6[1eL\;UAHc_Lc_c+fJ2G<Z\cDaQCXUMWMIY^<XTV1g++<Q\R,_HW@T#M_?+CAE#
Y<_KSdLF)4W,(\e-d9TE;XXZ;IYASXg#ST;:_L4Z8R-)1?cAEceH6_/;=/)EaL0X
CTF-;1SOFWdMFPfKb^B60958(Fe7+_,5.E2JCT//D-XQ5D5@ODYK<_R3E@=PP0KW
E8TV_c@H;K@]M\#a;2LNK^JS2[YJ##_SE@(/c2JA[7.ZN(aIfLM._AUBa^4GY\>Y
5MBT\59UKg\DfS<?M)JS[,\EUD9;&ZTdXNKYR23XRcF+Lc>OSEA\gZ<9\NdPP1_A
F:B,-/F?UZCRgNEd(2MP=>#Yb\9[NV9]\g[c&2eVN7/L2JAg/F,RcUaWPaKT-UX2
GZM?Z<D@f9ff=A]Z9-]I]B37dS>H[08Hf5L7BH?XOF3[<.=9E&X.&:.+.QbIge[R
[+ZYDLB&O(J:H8(M(:N+;&2M+2BQ0e]W/:OF:eQN@2_V@L&K1_S>EWD3@.KY+>cP
VW-UA3geQKOEZL=I9CQF;&FG#WKFD.-EE4KQ_Vd,4Je8-T?:90g9\SY<NE9ZMM<S
RMIH-/<a4B<8A(@-#D-OVN)=Kg]>513f9>@P[EDe?WS[X?Cbb_WG.45f03JVfKV&
6VR94I@?TZ)W:WdM+#-;_D2H+HHXB@QLe1P>MaCW&>UA,]8+@2[2&+b2O(.NGBT.
()CXCcX/55g_46d-bOc_BW=fH709IZY\L+N:LOd.J-SAH$
`endprotected


`endif // GUARD_SVT_DEBUG_OPTS_SV