//=======================================================================
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SVC_MESSAGE_MANAGER_SV
`define GUARD_SVT_SVC_MESSAGE_MANAGER_SV

`ifndef __SVDOC__
// SVDOC can't handle this many parameters to a macro...

/**
 * This macro basically just deals with the optional id value and then redirects things to the svt_message_manager macro.
 * This macro basically just drops the optional id value if it is encountered. It also only passes along the 0th arg and
 * the first 19 of 20 'other' args if no optional id value is encountered.
 */
`define SVT_SVC_MESSAGE_MANAGER_REPORT_MESSAGE(dbglvl,id_or_format,format_or_arg0=0,arg1=0,arg2=0,arg3=0,arg4=0,arg5=0,arg6=0,arg7=0,arg8=0,arg9=0,arg10=0,arg11=0,arg12=0,arg13=0,arg14=0,arg15=0,arg16=0,arg17=0,arg18=0,arg19=0,arg20=0) \
  do begin \
    bit has_obj_id; \
    has_obj_id = !svt_message_manager::is_string_var($typename(id_or_format)); \
    if (has_obj_id) begin \
      int message_id; \
      string f_or_arg0_str; \
      message_id = id_or_format; \
      f_or_arg0_str = $sformatf("%0s", format_or_arg0); \
      /* No SVC clients current rely on this feature, and its expensive, so skip it */ \
      /* If and when clients need it, they should just call sformatf at the source */ \
      /* svt_message_manager::replace_percent_m(f_or_arg0_str, DISPLAY_NAME); */ \
      `SVT_MESSAGE_MANAGER_REPORT_ID_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,f_or_arg0_str,message_id,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20); \
    end else begin \
      string id_or_f_str; \
      id_or_f_str = $sformatf("%0s", id_or_format); \
      /* No SVC clients current rely on this feature, and its expensive, so skip it */ \
      /* If and when clients need it, they should just call sformatf at the source */ \
      /* svt_message_manager::replace_percent_m(id_or_f_str, DISPLAY_NAME); */ \
`ifdef QUESTA \
      /* Questa works way too hard to try and look for format mismatches during compilation, etc. For */ \
      /* example it appears to assume 'has_obj_id' is '0', and execute the compile checking as if all */ \
      /* messages are non-ID messages. Which means ID messages are checked relative to the non-ID block. */ \
      /* This results in the ID 'format' argument being processed as the second $sformatf field. For some */ \
      /* reason Questa actually sees the argument placeholders (e.g., %0d) in this second $sformatf field, */ \
      /* and complains if there aren't subsequent arguments for all of the format argument placeholders. */ \
      /* To get past this we send the 'format_or_arg0' value into the macro selectively based */ \
      /* on the 'has_obj_id' setting. This is enough to get Questa to skip the type checking. */ \
      `SVT_MESSAGE_MANAGER_REPORT_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,id_or_f_str,(has_obj_id)?0:format_or_arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19); \
`else \
      `SVT_MESSAGE_MANAGER_REPORT_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,id_or_f_str,format_or_arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19); \
`endif \
    end \
  end while (0)

`endif

`define SVT_SVC_MESSAGE_MANAGER_LOG_ERR           0  // ERROR - big problem.
`define SVT_SVC_MESSAGE_MANAGER_LOG_WARN          1  // WARNINGS - some kind of problem.
`define SVT_SVC_MESSAGE_MANAGER_LOG_NOTE          2  // Notice - something that may be an issue, but not illegal
`define SVT_SVC_MESSAGE_MANAGER_LOG_INFO          3  // Informational
`define SVT_SVC_MESSAGE_MANAGER_LOG_TRANSACT      4  // Transaction level
`define SVT_SVC_MESSAGE_MANAGER_LOG_FRAME         5  // Frame level messages
`define SVT_SVC_MESSAGE_MANAGER_LOG_DWORD         6  // DWORD / PRIM debug-level messages
`define SVT_SVC_MESSAGE_MANAGER_LOG_DEBUG         7  // debug-level messages

`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_TIMESTAMP   32'h0000_0100 /* Don't display the timestamp */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_LOG_LEVEL   32'h0000_0200 /* Don't display the Log Level */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_PREFIX      32'h0000_0300 /* Neither Timestamp nor Log Level are displayed */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_NEWLINE     32'h0000_0400 /* Neither Timestamp nor Log Level are displayed */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_TRANSACTION    32'h0000_0800 /* This is a transaction msglog, write to trace file, ignoring log level */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_START_BUFFER   32'h0000_2000 /* Start Buffered Message */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_FLUSH_BUFFER   32'h0000_4000 /* Flush Buffered Message */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_MASK           32'h0000_FF00

`define SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME "shared_svc_msg_mgr"

`ifndef SVT_INCLUDE_SVC_MESSAGING
`define SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
`endif

`ifdef SVT_SVC_MESSAGE_MANAGER_USE_SVC_MESSAGING_EXCLUSIVELY
`define SVT_SVC_MESSAGE_MANAGER_USE_SVC_FOR_LINE_OPT
`endif

// Unset the macro if enabled for unit testing so that the additional methods
// are tested
`ifdef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
`undef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
`endif

// =============================================================================
/**
 * This class provides access to the methodology specific reporting facility.
 * The class provides SVC specific interpretations of the reporting capabilities,
 * and provides support for SVC specific methods.
 */
class svt_svc_message_manager extends svt_message_manager;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Used to build up messages across report_message calls. */
  protected string buffered_message = "";

  /** Used to watch for client_verbosity (i.e., without OPT bits) conflicts between buffered messages. */
  protected int buffered_client_verbosity = -1;

  /** Used to watch for client_severity conflicts between buffered messages. */
  protected int buffered_client_severity = -1;

  /** Used to watch for message_id conflicts between buffered messages. */
  protected int buffered_message_id = -1;

  /** Retains the source filename for buffered messages. */
  protected string buffered_filename = "";

  /** Retains the source line number for buffered messages. */
  protected int buffered_line = 0;

  /**
   * Used to indicate that the manager is currently buffering a message. Note that we cannot rely on
   * the len method on the buffered_message field as we may be buffering but currently have an empty
   * message.
   */
  protected bit buffer_is_active = 0;

  /**
   * Indicates whether we are at the beginning of a new line in the output. This is initialized to 0 to
   * that the first line of any output buffer appears on the same line as the prefix.
   */
  protected bit buffered_line_begin = 0;

  /** Flag to indicate whether or not to extract method from SVC message
   * string.  This can be set by individual titles in extensions of 
   * this class.
   */
`ifdef SVT_SVC_MESSAGE_MANAGER_EXTRACT_MESSAGE_ID
  protected bit svc_message_manager_extract_message_id = 1;
`else
  protected bit svc_message_manager_extract_message_id = 0;
`endif
  

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Static default svt_svc_message_manager which can be used when no preferred svt_svc_message_manager is
   * available.
   */
`ifdef SVT_VMM_TECHNOLOGY
  static svt_svc_message_manager shared_svc_msg_mgr = new(`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME);
`else
  static svt_svc_message_manager shared_svc_msg_mgr = new(`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME, `SVT_XVM(root)::get());
`endif

  /**
   * Identifies svt_svc_message_manager which has an active message buffered. Message managers setting
   * up their own buffers must make sure active buffers are cleared before initiating their own buffer
   * activities.
   */
  static svt_svc_message_manager active_svc_msg_mgr = null;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new SVC Message Manager instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param log The log associated with this message manager resource.
   */
  extern function new(string name = "", vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new SVC Message Manager instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param reporter The reporter associated with this message manager resource.
   */
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to report information to the transcript.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void report_message(int client_verbosity, int client_severity, string message, int message_id = -1,
                                              string filename = "", int line = 0);

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
  //----------------------------------------------------------------------------
  /**
   * Method used to get the current client specified verbosity level. Useful for controlling output generation.
   *
   * @return The current client specified verbosity level associated with this message manager.
   */
  extern virtual function int get_client_verbosity_level();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to get the current client specified verbosity via a local message manager.
   * 
   * If the supplied message manager is non-null then this method obtains the verbosity
   * level through that. If the supplied message manager is null then a message
   * manager is first obtained using find_message_manager, and then the verbosity level is
   * obtained through that.
   * 
   * The message manager that is used is returned through the provided msg_mgr argument, which
   * is a ref argument. This can then be used to update the local reference so that the lookup
   * does not need to be performed again.
   *
   * @param msg_mgr Reference to the local message manager
   * @param pref_mgr_id ID of the preferred message manager
   * @param def_mgr_id ID of the default message manager
   * @return The current client specified verbosity level associated with the local message manager.
   */
  extern static function int localized_get_client_verbosity_level(ref svt_svc_message_manager msg_mgr, input string pref_mgr_id, string def_mgr_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to convert from client technology verbosity/severity to methodology verbosity/severity.
   *
   * @param client_verbosity Client specified verbosity value that is to be converted.
   * @param client_severity Client specified severity value that is to be converted.
   * @param methodology_verbosity The methodology verbosity value corresponding to the client provided technology verbosity.
   * @param methodology_severity The methodology severity value corresponding to the client provided technology severity.
   * @param include_prefix Indicates whether the resulting message should include a prefix.
   * @param include_newline Indicates whether the resulting message should be preceded by a carriage return.
   */
  extern virtual function void get_methodology_verbosity(int client_verbosity, int client_severity,
                                                         ref int methodology_verbosity, ref int methodology_severity,
                                                         ref bit include_prefix, ref bit include_newline);

  //----------------------------------------------------------------------------
  /**
   * Method used to convert from methodology verbosity/severity to client technology verbosity/severity.
   *
   * @param methodology_verbosity Methodology verbosity value that is to be converted.
   * @param methodology_severity Methodology severity value that is to be converted.
   * @param client_verbosity The client verbosity value corresponding to the methodology verbosity.
   * @param client_severity The client severity value corresponding to the methodology severity.
   */
  extern virtual function void get_client_verbosity(int methodology_verbosity, int methodology_severity, ref int client_verbosity, ref int client_severity);

  //----------------------------------------------------------------------------
  /**
   * Method used to remove client specific text or add methodology specific text to an 'in process' display message.
   *
   * @param client_message Client provided message which is to be converted to a methodology message.
   *
   * @return Message after it has been converted to the current methodology.
   */
  extern virtual function string get_methodology_message(string client_message);

  //----------------------------------------------------------------------------
  /**
   * Method used to remove client specific text or add methodology specific text to an 'in process' display message,
   * and also to pull out the messageID if provided in the message.
   *
   * @param client_message Client provided message which is to be converted to a methodology message.
   * @param message_id The ID extracted from the client message.
   * @param message The final message extracted from the client message.
   */
  extern virtual function void get_methodology_id_and_message(string client_message, ref string message_id, ref string message);

  //----------------------------------------------------------------------------
  /** Utility used to flush the current buffer contents. */
  extern virtual function void flush_buffer();

  //----------------------------------------------------------------------------
  /**
   * Method used to push a message to the transcript immediately.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void flush_message(int client_verbosity, int client_severity, string message, int message_id,
                                             string filename = "", int line = 0);

  //----------------------------------------------------------------------------
  /**
   * Utility method that can be used to decide if the client verbosity can be supported.
   *
   * @param client_verbosity Client specified verbosity value that is to be evaluated.
   *
   * @return Indicates whether the client_verbosity corresponds to a support verbosity level (1) or not (0).
   */
  extern static function bit is_supported_client_verbosity(int client_verbosity);

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
  //----------------------------------------------------------------------------
  /**
   * Method used to redirect a message back to the $msglog utility.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   */
  extern virtual function void msglog(int client_verbosity, string message, int message_id = -1);
`endif

  // ---------------------------------------------------------------------------

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
_+X4:.3T2+^SZ=0U.P?KSf:@^e@ECYJLAC\3\,E5Mfa46Ybf32P8((1QZGY(T+V:
?\Q(6B).DE\4Q]S&.92J16PgK2HOd4[Xf/V;T\VbNEG:DaI9d1F./6W^T>(a6,a=
fIa[&(G+?CEc_)X)eVCg9&XLGaYQ9aA?0?EgFB(^G7\6R4++N3?.9R3b.TMT>G]B
[9NT/=g5Gf7>/0<5)1=/8UD:Y?;T53JgYbC9,FfA^ZE[&bO9bB7b,^<H9AIW8.bH
[..Q3HbTV76^A_4V=)#[;J,_/[>VP0c4RX[BS+(\K4We]\Z\W6LIc#d@\6B3&S)>
KJ&L.4<Q.ON^Z@@XHL?49cW,HS/7,\gd5WZVQ5L>ZDa;PH^5/e41+MK\9?A]@XD9
QF?#RS<-(-^#N&A?8ZBfMMS/ScP02f:9HLZT0b3=.89IRD])HO^C_^#?(JD:2GQY
d(ZA[T2^DAR/&Xd907dGLbZ^(#dF;WY_O;E2;W\G]<X@ZL@EV&06RYgY)Z8-g8CP
UcbVQ(Sg_>d74<[BT6=TSP^c3E^_0[6/=99=G,H-[,IJYWN_(AV?#33D]N@C#]cT
:>2eNAM2VgF17&(16PZc5fTa<bR&&9K#)I(G10RU&DQ@2#XBMZ4XbI:&GUb;9UUF
D;AR:NI=NUTHY9)_?[GV=Q[X>CK;OPNSd0D6#RKDR<^FG)@2C-7c58:29T7BVg)D
N_T;=+WPQ@QJ1VC9FK_Ef&GeC41bf25I+^H,D7([4C7b#(^(FOac(;=>IXc2@7M/
7#<N=L^EU]_3V91]aQ#a.e/d@eTTNODVE#7RM/9g3#)1c>^&cM1@91+bH1<9PA^6
O#g6\@@O50(43aP9J\I2=;#TY@Od4Pb,QU,e[5<:]f+TCH90WC:KLRTBPI(.V;UC
ST6bb8Qg7E</IdL9Z0KC]>9HYeg[N)\(e7X]GE?43?7a_V\5BR.PO_+Vf,AReTPJ
8\ME)&:<JA089WbH1+QJd#M6TCLHCLY^[\9IDGdRVG>0XQ]?ZZRTbWFKa#G:Td4>
U<-;FR<?YT?0:SJKU4Q/NQERdC:_/&Yb7^W<e3G><14:4,bd3eI\cgU79WW1JW4f
KRScST_5PC9HYQ[449.+=\7S3L#=#&FS6L4HT9&(4A4PH4U8N@L)JaZ[P6UA+B=#
CL5V9,WN6_52G;3P[SL:KRR/ZSbSKc[.K]@3AR&e&#(D_>C#&bX3,A(GdRL\<bE1
K?Md#W5;+=Y//L=;@,P3&RD2\EBbaUQIM@B-JeGOJKbQ@DBFD-.;AbD);ISb8S3X
PA.)S39&?/]8B1W3=Mg78DEJe<Q,@8[Pg/:JFY864MD.BO&-L5/AUZ7MIN+<?A1H
F13;M.M6RISe+Q?(SDVX7,__,W#L^UaTgZBHK\,WGTfbNI+F[]g9_X2b\_S,11OU
W>D57-b1S3VOX7]1LeSTbA@I;O[f1NE_V8/FTCVE\S9IQ_4F93a&]_;^W<]L45c\
)95(TX>4[9,OK=cF<84&HIM#<CY/>::NNO1-PF,:[c(UZI>BRP^7P]\AU&?9MC;A
);I2.d6Z1\[PEM3I=)g=E72OgP3K=#.He^2D?&^MCI4@c>JNID#@-.&AWd7:P=]A
b2)fONB9dIeO0).e/=b5d4UN?4aPa_(cC<[B\+,=1JDMA&[?\N+W[8-ZIB]G0_e/
#(G=OaK0AF_FDBc5K4I\A\<414bH.PP<c,#<JF)-L[41:7^=6+g-;]6e16bZ08ef
HU?SNbOQ.D5[O&XU(e[-J+>3T_>PDA7QJ&<WTKR)gIK.PJ9]A/fN;eU0d^b<M:]:
(?SUO8L<IH]R?Yc:D,a,&U8X5O,3>gDA7IPJC3NU_?fg,.c(cTZQGL<E+ALbe3c=
:C9cf)BS/JU?B,aL.e>E;XMeEB)#V?G(]>:[:bSI4,>AbE&K#8Oa/@SWQR.0[:-C
2>BZ8>+Wg@ABO)?ZH>X_FXeK<&G/@Ng+07Uf0M>1Rc::0^Z5F_gC5fLXZf;[#0P3
078E6Kf^^AV8\C>dA3+MZSeEVQ-R/R?/VNe6b#,QE9@OKg2Q8BLcOH.\9;:]ID4:
D?0NIc5Lc;g?<.N+U&ZWPO4e\#V5^@Je(#&9A)aTJ93HZfg4ZaAP2,K(A@0==AVR
Mdf&O\WJCE<K]eWWUGN;\JTI[DD]fQ8d9#K3Of75/YHeK9)>=+[JEA6fE#dAF\.G
cB<U[eC_@UZOeLDI/H->D4\66EG4BbVG\[G]MTKLH#>]g8ceFc@F4@Z/9PZ##V0W
bZ(\<JLY5b4_KTSNB00OOOZ.VQ3e]W?E3fCRFON:B<TW/JO\3ILZZbA9T>J)-R3G
&/JZEUC..\&V>+^V1#HX\MO>B]<Q.bEc4&9ZaCU0JL_1.,6T90NE;.<KMabCN(IF
AV<.:(GJg[5,/.</]\K90JOO34Td_8#L^NB>>bT@UDZ9RPX[=4>?S?McR_[?HR/L
[XXLS-MaR2)S_e@N[_1U6VWgBE#7.)C(+-,O,\]]-b(_R4TfC(BF?K:Qg+,T_Yab
A6A;1PM/VB^(@&RR##&BaJT=1QT06WATZ\2bCFTB<VZFZ)I5L(.c36YXIX^27CC\
9^YFL&GaPVc(4M2<-VTS-Z#O=OTA>]__0CGVM]^e1_Z#MP1HFCMB-#Bdd(<+3,e,
Na5-A]+WG:K?S8H[U\bQN4;6B?g_M+,c[946>cdRdM27fX0-4dPLZ=FL,9N5OYIS
#WX#HbO2&D0e]JOWCFf/H/0S#J\Y37(f>R;d,V0HEEE:(CP#\:bHa]CYN>CcZMb\
WFCfHJ@>WVRB:9;+W,LCF_#K>27(fF5M8F0,XReGHEWSQ>E]^81;/EOe4d(#EY3+
BT81]V62ACV8.6;^6XfLK(TaR#0.N308(B8U+(M=IJf+.GFUNMO1,O7V;^@0\LQQ
4f<YK#LcZG1L35e.E99C#JJ:]O_)R,5=V[Ic6ec>QRRNTT@:b5+L/f/NZXQ([\Z-
fWG4Ua?6>g/D_2]QKZ8(?LB8V3V(\<Qe9eQ3LS89=eK.M@?0+O0SIJ_]3:.7:982
1Q->YPd0_I&a(MLM2D,1DH(ac<c+6]?dUP4cde5,EW9M(dWKSg38dg_;2DeF]\&5
R5JI)KPIOgIdF1e;1+aU,8##D+fc:T<)f<>f74U<Z;V\75KB<VG,f3Yc;,IPaaYV
S4@HJ@@;31SI\V:>SC@XZG+fUC)dgc6O)BU9a\?W/#.Y]f(:caP^77IeWJ(>bX__
^+XBc681^RdWQD.6(gK6bQ;:<CL.Z\f+P)(RN;5N))EAWPQ_IHQI6_c8cN8ZDB)0
HP8K;Q<?V(dg>WPOF<SMILC7bE@?dTP9=K/NW<)+#6_I2C80-PGbf+ONDT@;/OWO
=KD+JZa8=C)[2TMQ+A.#OBM;(Kg2\9=]Q6)T1]NdfRa1LKV@L#(XP:YXIOG.aM:;
+aXXLJ<Bd(T]dNX\JYT9+dVLPQ0FC.OQG8-YJ1bbbZVURV89UD0F8.H28Hf6O@5V
&LE.[51[WcJ&RSJ)6M>WJ74L&.W8Z[D5M/JH#f-VV&3>M/RFBI\B(C_J9/1AGJF;
fJECCA8TU3NDd:&3OCMT3JQ=>A,dd-H[\WUDaV#R?<X]dUDZ2CP?:LJ0DH0GOHF0
JHa^gPK4>J#)Z^S6cF,\<SDBL3-WN?;JVXS:ZW;b7C?-_(+535fVMHG[++,A+R?N
\NDGXC>XREFaV54JMWC#^BQDM<=YUZ8LQE2BSAJEJ?e#S@2DI59+64U(S\fC.[V6
Ke7_/8MD1\]ZC-#cLQ<+0K\O0D98N0a3g=NDZ#Y29FDfIR]dCgJ:9AWP2@;dg]H]
BVET+)1^LRL>@,_+g=[SY=f@HZ-a>PaKJ]IPY:8(a5J+,]=:&Rc#0(E-BOHe[2K4
^V35aI1a7QI2/^8D;g>_^L]A,2^8)6^?L0HVY>]:+<OYSM78SCPENJIE&ZM7Z_:S
@BaN&SK1=@J\1T-_0,Q]=&f:bM]5f:MQ44O=:J),:LQcH]-;6]gVYaIFAIA^+S](
I-SRV+PWTV^A4=a<9+N/AP/ca_)gXQR1cU,GVQ8@N1G6..7Q5a2H82@L4_2+)9Q/
47#XGJ.5P^7g47DT6LDcDaYE0gHKU/-MUU5;+aT<:M7g0DHSH(QP0.B+/D#ZY\7?
_1ITcWbC95JHNW>,9U,L_;+N&L@ROK5?N8<2Q+aDD-g7S27GGA1MLK&F/+f2&8P,
=5c4gQ,\gF1fBaJ=(S[f9_8Tc&Z<4-cCJBUga2_,gFTEdR4<7SeT4(W3=&?>)-WF
?:CPONc986&Z#3(B+3S8,6SQ6O-Aba6-QL)V6;4,H,[BUA^ZQ)UQ?<?ENT,J,+,>
-f@WRdLWaM@V39E4[L/PS2IdQ/UPN#[:>>dVTKQbR14e25/9=d4A0fA<]AP:f66A
LSSU2^+XHHX<J-FW+e+@0a^0[B<.B/93bE;)PA4GA_+QT_a6X>^K/Jec+@J>fO&F
7])ANJ6d<_/c76=,BdJW.U:CeDXP@M\60-^2E<52GF]=N/_2WSTLQFH,PB1^/:-]
2f/21Y+f-BU4F#TC7_cUX@&[W680aYZ\?M<V1]35YdTG4Za?N\SOdPUQ4fC79a02
<Ve@T0^aIGQX:7-JLK06LcGS@fEEfZ#^QQKac74Of@9I<XO2g/b07G:JRL&9MdOc
.\UDg,YX<C&]PR3_++B>\>d)-Yd8#[bY=7#4+6/3>\,ZII@HK23?EbB(CO?V__&]
FLJM:dEU1=,F?60c,NRTEeWe:MFK#a--SG&O>[VVdeg&CJ(H9G(e)\T:W#WfZZ+5
C>DU&2?8U.3,O(6A4<65>;^6;YW_[.\d.J(<PF8>8Q6T1=-^36^<G[NZAK1M_^V@
&bDfZ6gHULO[E28]&e7KA-43CfBR^T)_]UOOE0(-419M9M>/#b-TWG0MT;H+[>NW
2W)5G(RX>\?(6.U&X(E?=g_VB^JAHZS_]\&A^BaUgPF=]?-J0=;G>I55.K70a+:f
IN;?1A^gHJF8HTUK,;XT=bOKM6JbEUaR,B9]I/TQ(]Q]V>fcWV6ZIe59/Q[OYa:+
:g7O#aJEDC?d=#>0W<UZ<>K3Da<ZH(d?XO>L,XD/^0cd=TfE@.5CJdM)9S[S6SYX
aNB(aXKX4e3N:&;SSb_&.5BbUS_da]Ka,+(]Q+TJ(QQ7+ABVP653TeUE3c9Kf]YZ
^XH6_3P/48dQ.)DJO[?9f2/Z,d/G:_@LEL(/f_8L#0G(2WI<YdR\dSEVefXC[4/W
.QR1(712)=YPLP^>J)/-?BET7OG<#@?TM>3&,ScT.BHdeTI71;UT\.X87\(LB_IW
]b^2=S<6NI8aZ<g#N@>##CQaIaDWGREB=M#M1cCCPQ]N/A2UcH@;\86ZS7M-B2CK
EKXBD44MKd\=_;K1eR8@=^0>]V^8dX4]1P#H3T#V3?Xc\(46D<eB^I2af.aJeg]Q
(M>KeJgJ]?UYRF:.5A6HC-AMWLO99=JJ;/=gS&X,1WX_gA79\UN9CN@IMOb;,Q2W
\+6+O[\bg^.<;.2ZeX<d0/[fXK08Oc=5gB:3DBZRS@,G0JQb(U6?g7W5H46:\Pe_
DTd3b[PX<IV,RYeIFMP,0S]R-C.42G9,.4R33[V>PZ3QF-_G(J+C5WaDL_R+(Q2)
1SaJ@?6/QEN#R0XGYbIM9<XW-E\.]+S@&&7LK9)C\4;#fWD:H9QNC)Y]4@dF(;1;
()PeE_fHY;1SOEMNadX<BZHEVE8D.](@P-Y5Y[X(WRM)TDG&IF1<G1=Y>6##6?[S
J6_f^V>2&Y1F)bbKNC[bd?=#8UVLX7.,MX(T-903BS<8JM\_PV3Xdg3#BDLcGcVI
@0dE-S\L7,[R0B^+LN2Q)3YU=fB3aY=N>dK4^;OEN>HCSE4R1_6-RW6,JHcG7HT6
OROHb5X-/:N(4[>0CA6fT:JUJ@GfHJeZPeO:>024>M#]8CEfaUa1\YMIc_6NCG,\
2UP<&1[X/]_\J\a)8LfA=;K2b?(2W\TGV)<=\-&S<XQbFZ55#&2B.R_c_W;6UDd:
\C<NKS0V?2;FQ_aSaXEe\@V^)9R7S(Wa0-IR](L-EHD)/EC38#&W<RCc-/(55O\_
7=?94We;X?JZG&H12g<Vg3?\5I6BE[Z[7/aLAEB7S;aL7Q8IBcgg05g#T@R5M=Nf
^O)Vf1g3M):>=7A8N(dgM.72#?KX\F&JcaYO#M&VB@5QbQ.&8Ag@=D)T+6VTXA5A
X58[&RO]BG\A?g\5(BW,DQT1-.1@Vg+(QGI)f@,g=APX_O,?>4CBHLCO.2VN2.]E
L=XIB>MK<N.0:@L-cZP8/e?b8<B>68,16@5.R@Qc[>gHBF<SH2RTT@Cb7+C?TQ85
#X@:A;+eQXMC53H#bXO7\[=2).K-F;(QHY3\Q:4a3T/1SYf/Fg<6_L9C-6.SR^-G
70Z<Y+XIB5e&Qcb_@,+2[5A/b5b_PRPg6:E[G>)L:J#@#[c)a+_a&(b>dM5H>:;A
VU@fL]1&NS(deAB9VcH]f<AfQHec#cMc@[-K,9+R(fQKFHOP3Oc(OB,a8bZZU@cF
.]YQ:][PcIgQ1(<M.39@a<47AC[PPSK\AH,e(_fWXBH8Yf(J]B0SQ,_f:dK?U8&6
IJGgg7\10:QP3Z>Y5[6#4OB8QCe4R+MIGH=<PF_8H3AWPS_Fgf_IWVfV-RHVPXET
Hd99^IQC9>Dd\:gNL6Y=T=bHX=]2E0CNVJ8&WY=/)A(6/gM=1?_cEKDY#g/>^?e+
5\MOYNX09CT>8,KaZ6G^BAQIOaI<[<2Vd>V4eA/V?7UX,9;^6P?Z/)2O)T;4a]5Z
bKMJ03?@]64Z?bcMfB-;07=#N0B_74]fVF,T4(?_042@4dF7AIS=Sa(c/0,[a&7K
:[&f+P23bD;F[;M7^((g>.1^_edX0>G9DT)/I=^gU=aY?IMa6eR2,aJ=\X,;/bGJ
ZaJ1+J4SV[b1=+UZWB,+&K<Q@/\_J.gBIN[YJ\]0YJ9d+FBGB;U>LSQ.3R110=.g
e-;RbOR:;I7E:5,K[A3=XUOb7:W^^D;eEI?J_3;aNJDfA2,W10XeG&<-VSZ0ZD3A
g:)B&W2GJ,.HU4./&e(1;8W#,.@=(A#1+d6d6GUO<X_aV;YMD&]H0D6[/(d@F/>>
@KFe:QA(>^\8egH,4ZfYA[<\C0>^aRQU14#be4^G<Y&@a#6U=>0N6&R_4f\)edW_
D_V)S94PY+JP][g\8-ND]=88E);b5)8WVK4E^-<]:-U8\)3K;Z[g]1YM.P3?;9SF
E]F#bK4>N(G-dG=YP8#dZEGg,&H,<^>O\<a>;KTWU+>F38TeTVZ<?QJ_3?RZD;SW
be6J>X6^ff)N7?Y6Yb0[4Wc.FE3MH,BA^N2#&6GdXKO&2ZbTRSXC;EU0HY\#EGMf
W@,1J^RJYSMd1]DTOW5M,cL6N;:@ab1b#<@0GM.eT<NC,>aHT-1?ZJ?[TefS\fS&
9DYW?+CJ-EY:6fO.ZGA:?3K^2M0>b12Z)E;2+4VJKBO671+_#T@E_^S-/>PFR,;Q
EEPC(Ke?&<IB/+\d2.a8e[eM/>\AKTC5#-M6YGQY8_L,cEV^5T/TV2HA)<1J7DB7
5\CgK_6A/a4\H,/f1cP+Da#-1JANH0Ta@21H-Lgf7/cZ-2LV+R/eTS3HOE:D;M8f
)fBfNH69@PNPZDL7&<gf?CB)=MG.PEQ20IH/R@DY@@UJF<3N.+e8eFCa.aY<OO;X
L[^<b,M:YW+^\23YDNL=ec8V<b.^B/ICAO[AJZ3PDc,JbC1^X\;<888Y4FHS33,2
Sff<0\dbJ,[@38?>eZ_8WfW\GG?W=V@1e=Eb+]4.R;UBgGI?0K,G:9O/83V,HICO
=D3(;IeLWDb)IS-LX(Uf<5()?IVODA)654?)d(&B?AT@F9&ZI+0\<IH:IMBQT?\J
;U=a[X;dEU+F[0gY+VUR?[(c\g-1?FYLZ[,LKdfNDCS_Jd-N.OISW/M=HH5K],FQ
8@=08.Hb3]R5O2L]W^M<cLZZf7<++;RD0[,._WKFTV,IO8>>@c4/fb^F)TQeUQ-a
+CNCL->Y?01TdSR#LACR(K?^;)6aV:J^TgR\0Oa[Z:,P#QQ9>dM^9\[=ZCKJLbX6
8X7?-/XA?Pff3Y;8c.c4eWE]6#^A?YJ+RQIFYS;\)0/g]W(PP6Ie;1F)7.dGCW7M
CI8<)U_g=)V;d1F7@TG1=E2D8dVaOJNPDMJRB1;=,d\UZ\(Z?De(XFB9]N4)Rg#=
<@cg/S+S6(68,:>/AKT7BIU&7.]D[g5#d88?W1J,6_Yc7U^6OWO?;Q]RdPdg;f/f
2@AFdeEXE+6O9AL_C7[1OgZ?9g.\/-)8&D3aC==fdPdC)\I:G#?_W[VM8//7c:_U
=RGV:MfWVQa9K]>8[:>?/S8Z1H/,/ea0EW[/8Db6KM<IS>LA=I4=L2F]]]-?86?5
L#Uf\F17N4A3Ja5@S50D<T+CP0R-_Wa+4&d)Q3,JEC4\LDGE9I/a#7>P96].)4b]
(VRB)<WNHf\)A0)_:DBFNR25.\b-H[&S-0K/Z_=_F,2.IBg^-0;5aS?BABg_Fc.-
c7YFNPE@7WOgO@[D1ZNc;;F3>OfRETW]7=6.MBM.Ye5d7?CddSNAV2;X83;a8.V&
0_JOKZgeQ&[2[_,MNJS@+C+f]08+VSOYN?(>.Q-4XQHa?W+6QNfMd]ZR;?Vf4Q\0
^aKRF6Y8T8?RF_1I=SQ5-ad=ZK-,J^RAV,^U5A?V@CX=7fMF-VF=>39Aa_NYdJ^K
_L&-01EL2I4I;)5BCPJ\]Z6:aF/VXF.3J6EPJ?b81c/eWCRXDa6@BL,NHL=c]=G@
+VR^fBg1])H(bgZX+&eBPASM@VXb/7G/L,>Z+9<EMT(1JCc91>,>RBS:F9<21(UO
f/DZSMX]1_=b+K(QKTG^F[aUZQ@\@NPY6S.Z9:<JJ5dUcFZEF\#/Z].)?+bbg&=W
H[R)V6,b[/CC)PB0<BDQ#ZFI)QQ#K-SC+Q_/U8SM6N/7F/3_/Bd?_FJdgCJC9HXN
/6Z<V[U7AC.@KIeR-]MG7-c5;S)3.X0NQ+IT1TD-O<C52_BC@SD.;f:545ECdA6+
Ng8)[fPZ\C05U9_-,8945cB1.\.gG<bYI5D,g]I[JO3C@9C9Lg<HW\H?A.9U:F@J
P@[USK^V/43K_d2LIP:^?2Gad>M6/>5cSN+P@:<[M/W6:;#XRU-XY.XdA,f[DfS8
c3KT1SI9Q217:L4\5)_MV7PC5YSfb6><G3]YG47Ta50IJ1X_1RSD2LE3<BGVCg&F
QY.4R\8dGdYg./9,/L:G0]^?KY:W+BJ_Wg,6_-HO4VFED5-Ve\c,C@_<gD?)M1E4
H\a-OT^b2)+IKL^PfC(eFgI#/d:D[fZN]6;CD]C]D4K.\KH9//L<B347C72#RV68
^PB\\3.:SM^FD;g3.c>(ZfSf&fITTLIFR\1HRc6g3I+#A+MB-dT_2Z8Y>+2&U3U(
EY4Z57-.4YHLF<I<5?,LNXebU#[/9VZ(-,/6^G^(@3>@d>c-DM;CV=R0RI@OJ-D&
-(^,ADeH=KY0NSf&7[T4=E3R^gIag@-U0,_OCPSHJg@&2[^c>@8+a\,D43.(4]<8
cIAE8MQ;?^+VNAR>A+F_<=(L<XB>dfXg3XV5_eW1]Xa8/@a250-2f>JCV2[?5=-C
RaV=^)H3K6-308,R9MW]<E@J>?94V,S\])_G6O:YG:]XX-5)GU7Sg(S.R0?HAHJb
Z)Z>&H2NCIJENPTR57W8+f0OP0<+AY(A15]>c\R7:^F87RLJ>IP;\+G4dY>BL/W3
YTQLC<^/AW3DDY5R-W^Z4+7_Sf/[9/bIA&^\5JO=I>XPNF:+#.Lc^](+DLR)<ePe
fA]3D29M6;W9gHdbEQF[K;cZ,;D5L]Y[WEN=7M=KWXE#(T#SGB<U&E#NC;a@DO,[
S?4E__M\)IT+Ad]MJ&Z10VUC08ED-Q;H&7/BJ<PXJ5e(:,77bbIJ@^[(FN&Ff9HT
?GI:V03HWH#D7)fPPSXfWL)GMGVID:9J7aTMd48#f5PP0<#P67.I76NGA,,9^b@=
6<=2L)\QBV9Z@PN90BH;#\@)+L)cH#ODSd+_;GaY.UNM=A(eAFW-Q31?YZLI&FK/
5f2[A@b?VI9_]\8^Y(FeHEG43W,9c8,YCYdd.ScIE\g#(U2=JE2,KB4EHWP52HUR
JB\B>DMF\ANH^REfKb=_;R(D=[_3eM&1,#b@0<A(V2V\dCA[7(E85]5:V)2fEOgH
W.IOcH)&AF@PGGE8AI.EX3G:Rac>F?-GVY>0c&K2#,1@_=\@EH0AQ:I(R.-Ka0B;
ZgTAf_4EQ[F4?76_7YG\V\b7BV?X4UXde/C]72R3Bb1@Re1[L:8C]g]9/c:PSE]V
AcRMe-?PT+4G:^&8NWHIBT#..][JHH=N3^Hg78?.&U#G>_,WRYD0RX\J0Zd9/,<Q
FH\3NC>\N/_AgIE<gP>A9LN.[V7Nc]<QXCOWGQQ.Y&Y(WP.?7GB?[RDdO&[TH<5@
Vggf.6O5\^gG1T-8H.;8]=L8T(+WP?Xd4I\2U.3_?ED[;&5]#0U[(/.3;J104P.:
a4e@,1^&>N,6A^FN/QcW,g5GI7c0:)d)JU]Aa>cd+7>9\KULCANQ,99.2AVO(#B^
FCQMTL+G7e;];9HO:gR?)e;X8D[Q7a.He/45<dgb?.dbY+J;KH;HM.P;XJ5BZOZ.
I/:C3,Q/]+]7[3cfQ&B92L]9BCC4MG>XZ?.[R-[6_SK0<Sg5dE2^^eW&Jg\3+50+
bT/R\;cMc&f(XbF8(W=OC)O1-=@aA=C778d0R3(C/O3#R9AB2f)(:>#KT5^/DQNG
F2Lga7=ZZ-J(,-?+[C2XM\GM1-gaQ\8DZ<]1GgcLLGR3D(]MV@XZ+S^HA23d_N&L
:X85afW+/U:Z\0PJ&F=R[E)^0+g>Gd3fY(I2IL-e.3LF1(E;bBM?_4#9]PB_FD=8
RXDQ>bZG4S#I5aG<+SDN6P4B[bAQD6RW:Mga>E>A,^(f?-Y\1]#N,a6S6E(G>,K1
c_E3UYI7/JObbVK\XW;GPOPVM2;XaId@7E.)cK&+4S9^V((d;ELQd07ZQg<T)_aC
HA8]5^&?7dOF8^dV2E-<Q+._KBEQ#FM2.Odc#7W(KT?E565\g1U<bQ,f2XPA#U2N
.9DKZ::LcPVM)<E3/98SYXYdI<=Y[.NcJ0?7@gMQNC6eP#G+D#D]A:Y=UGLODQ9(
1dIYMG(&0R.1DdUH<c?A_^5_LC]TON[;SZX:4(A-Pa.-E-55[_H]6I7#]f#Q5?;Q
g6aW42-,?c1PH;3VKD\^^VCD#C]?D6P9XTB5O-0GW<e(Re+=Y8]]OM^Q:P9[fC01
BG(Z^<gMQUcfI.J]EC4J;c<SQ09<eY-#FbgY:6f29eLBVc.>TJBQE#:(-,N<#/d9
>E8ff4PM0c+0c4fa1>]e.V[IOM3A_=@0VZI-=9V\]Mf)HM_A41Z0>YEP[E>&LH_>
=cFGQP-<#:&d#[Oc2/AK[@[YZY[RIM6^aG.FW=^&L/EVAG&5C0-I(>R31\f196)W
\.Z&8:XZV7FO^4^S<R:c[7I_X2a@Q,44+8_#GdZHZ?Ha&L<HY+e7;(R_Fg(bA6/d
//[\=W@C..U=fT1,#L0C^20B0CP&2>Eg?H=a(PBN&4,)0^/CDFB.eKC4?10.eM@K
,GBE<Gd54NeI;?43=f^(381F)-ND5g@UNDC+RVT6^OOQK+1I0eJ3gb[J]VJGX:,_
->Jc.3<O#eFFSFP-f?P/a@^1S8fU1/;1=3LT3RAf;H14eK.=(1F_6H<6Ia6::3<F
1,[SVFT=f^990I^0=(I(@?ZQBL&7-L#<cKC6T-DF=fYKSF:QT3+>b6Ec.]T>V^OC
+>e^eMfW.L:@Tc^<2;@IE8_KVAAD9[-)<f8_)TV184&a#DgY;W@CV6Xe^I)3K6g^
(3:27Z&2<U.@CV2)dVN)E5>9S&.JW(>AQJa_BVSD^YC:-=Z>UeMJP,]2)@P?T[RT
NK9CJLEPQ[/#IMAOYf_@4g-@1aVY//b\2@P,M8GXaO_@B>V(N+9.55R77gN<++NQ
@&]X(Q]aD#(9eJPf6TN+aCd#>-PEUM3_26TNY2.4&X<f3F/V@6&KI[aC@##F2(N^
P62N;bOR;_][86(H.5F>LH?a=e6=P?^><3#@8Q+VBMR(:aYR;HY80WV1VK7=H+U5
=LE1G+,BPV1AQ=PA^Sc(H45XM<?e0UEVJ:E>Ke_TLT<fFXPZF]^DSZWbBX-TQP?@
S\=QIe1F)]/IeLCfeDES4/CYE[OJ+YE87Q\&C2Q^1E)&@?c<()#YVc86T_<CXJ[c
Z=gd:WN?Sf-32O2_?FYA]K&<e?]fOLcE@C#^IA)@)J\]<9K5XeY(Y\A5+?#2HfMg
>GAKK/P9KeWWQXQdb.R6DDYK_Q:W@gJLYH&^b7Z6CeJR@Y:XT:ScN]M=R=KRd>S,
^]IL=Kc3UK9)1GX?MTc=-DC266]^VU.7<A=QU:&[1CA[A#0<P^K&S:UL0NWeL_EK
^YfIgQE^)Qd-fMMA+F4@=WeK]+#N/P\Ta#]P_F_739[Q^\NQ4MR.P/N^bCH2(Xa]
8f52DC4ME3eF?RM:gCG@GC6S,(YY;ZS+X;7.gLOL2<ZHRRF:L;K0aF+.)+4S[\KA
:f-bf@cN;Ye[a,\SW+/03T>&_b^+eT,,P9_H-QR,P2OY4[@PR,8J0<D0eI8P/8ZC
-UD=OD7O@]&H<eUT_N@+Ma,gOSFV(#dc,RF408W/H4PaA,VQFSfYQg6VAG98\c@S
825?87YQ#e&H-8a,@Ud\[Y]?8Fa:)1J2dXe(W#5/4M(,fY-=,eYQ)2EAa+AaF@gU
\X9_M@2CMP9RW\BY5A\eT-&Nd?O(N<>.BOaI;JPJ2KE1Ea]6B2db6P]:9N(d4Ee<
=Yc\W7]FLcE1>ZMKAF.W=ecIg;;<R:g;b&bL>QNV-L/1R>ZPAK<=J>47gKKbfLK,
b.[Z+^C(D1G?H#:<+d88gIfK\7@A@H(B:38>_NHXTZ<E:EJ]W:;@+/_(Pg<BCWSb
)2M(f>(L,:A-4E&Z/^BdKfN]HY1F6UG:S^U5-XJ[(5b5\8Bf&C7IZY6YBA_OgcJ1
&#M,P0X3#d2+#U_LH.2]#J[V.LZ#<NS?:+L<fWD]E;c(<Wa0@\D6O.<H5>cZ6PP<
-U@N]DY4E:6d?3XP@QKCa/VP>fKbKdCSJ[\SdME=>e^OU=aHYXX\c@K5YBSf5gc8
9=XU4HIN<03.BN6Q/_Eg>/AX],Z&,;L<cb1#B3gHKafMae6IYSIZ:R[619M0_V&[
g654PCDP3,AH3#34:&cLCD,cYQ8.?N4d9_KOAQ9PSEGg&Y0K9;X5g=\HMHB=PcWd
Z4?,_gA3<VAOZPCeOVc>ND1Ef<3X2CB9H7+FD.-20>\U0IO(;SHFM&4?&5R:TEJ<
(?_44]CN<dK0#^54O4B(CXc^0VXWKFX78b(;?6:gN#/+CWF-Ge.^PMUXNa(-P=6b
D4e5?=1Z/J(<@9MRIMf)X1-B8GD>F.YLc7FBdNP442eF,Q:)cJ#a-8-54C>e5VT_
8VF(K71ITd,ZC9=A@^a+4:d_7fLZXZ+1bGK3=1_@OTJ\dgJ([J0\][;e/PA<HNMH
)_IHHA_//-.QBc;C4e498MAcT._04L<_f-M6EWTOE+JKNS:\+M,679M/:RZ&Y_XO
\UDd=HU2H65c=BW2#UY9Y/U&L:LAIJ88IWRHffT.&I@X]85)36e:EN+;_)D@9<7K
cQg^C#f[aI@6VU1<_V#?Y8^:T6G?WJ>3Q3=IN73<dH;BW/;1W6M]aZOIT>NZJ2:(
f4[@3g/#HH,&/#KM;gWQCLC9fS&d9\aAGNYHc@^(4FW@g;SS[M.O=;beceJb7D4X
C6370d2LcTI20](OO]e+Z_\)?2GH]S-PdI0@9;56@78]/(A<QK-UZNB/Mb@J#Ge>
Q[M)211HA7?[FX&>.NIbE)#T;D)SU)L:gVPH#E_b_7DLB4+8_UA]IWf>>3TA_[22
+/e3:-]NU;&FF@N48];0&XGJUIR7PCKHAFF?<ecL6SI\AP<7AK<Pd]+AXd^T29K5
Q?].T8JaM>Ld(BC=;Qc(BNHP+LJ#,M(ef+&C&:EA1.DK1-X)#\DK+H\;AW-(aEH@
5MVb,D#eL>^LHOEcLg?.>I2S,ada:SW-NWEUgdZ&+7a34F_[/4dXH7?gK(L;QT7d
2&8\Z_&cW\<[S-UGKc@JDb^X_SZ\TZ26g:TO5<JecZ_^GB0Bg6@#\9/[JKQQcD]Z
O/^,gYCcSYU^P.e9b1<YLgMf.,gZI84I17]cSXLaQL_YIgN2?@56-;QX/(]&L8bM
L10BBE&NFM3e@f>2(CJAc=gZ;(:Jca.THPYJ&IDFP=-Da=,M1;FJJ/fF-G-NLH:U
8&U1/@15?S+3[CG_b,+f^-,OW8D.4;2P331HN6^</U6+M[AJ=@FgNERP0+cBEV&B
BQK//eAX/H^Ef^VgO#e][DPc6(<>4CZSB;PI[7T-N2?L]F/gHMWKc=D^HDH79@Hc
C,<>d.K:<(EbY6_b.R;/R1aFCMIFZJb+IeE0ccd?0ZJC&N+KLAPDPF<NMBOV.?0O
4NM6EgPSBGc-([31g@LdIQ=E&-<535L,B55.0EMOLQMPDNa)cGJ+4#.I;Z?Z.cHQ
AFCP^Z=M+ge[479L9A<91,D(OVZgC(8POUK&e4N9OO]UJCY=ROcZQO-UEZJ7,DPJ
BDI<LFNe]RO^@SS+8^e]WG?>4>WNHMF22;L&/(&A7H(F?>7)>>;,X:=:S#H&dQOR
<VUA;Q,(+5,<Tg953P[bG8AC>AW[D_0^f8H-VQ6J=[;#4=[0U5E@GODJ5HNTZeU=
(M\H_^G?f1G\LBC8)=b0^^M66K/c,H^QaZF:-<X/_S8E-(Gb=a=D5Y4.>H?^MUbW
,^5M6M0CO_DS\,]3d<T1,-4(;3@L0c<R&Ya<-f>Mg7WM#Y=._(/RgH@E]g;)DYAg
&]?Z^ZQPB&H\95H=ZG47/<[SHD/ADQ\G1,-M.XAJ&/\5MXD+@d:JK9Qb9&L(3S8V
aAPYZ&,XFX,>#0R/P,4aD/RP_WOM]HCWW.R6.(Cg.#L?&7Kgfa\L@cBM)(<AAF3>
=(&ZHO]/e0F-JC_F(EEAQD31D/_HVb[M@R6-53,QFGUfU[50]Y8N_(?E<?9KbW?7
&=R#-EK-EL3>Y.L&]fWWESSe.+<EKIa>a+YF/FZ2^N]LfbT/Y+TUUF/JdE6fOf\C
N]E;8.PbAYM.057NDGe+IZRD5M?/F\\c..(1((&+6H].4CC65>b1M.)b<3PS)4A/
YeG<^W_?g@Q3&L&S_F=6?.=D)KGXLU-9Af2SU0MZ<1&5,gd8W/bNbKHS@-5)Kg)e
=LVH[M>g5NS6g+PQ4W\BgbU?U-3P2JC]G-#,&[GK9^;GL-DA(+8?@JAN9cZd&ICU
_9BdFS8Mc9G)L=Z?QX.c57I/S\a^K]K]QAV[1TOU8NM7F&;Q7/Q[,NJIb(Ld8,:L
=2.WaTLR]><Sc]IOWa[ZX6_^@SLCB2N.C#;QU/)?Q<(0(+3-ZWd7JY)9_dH4gM=V
+Ygfg:MIac>DZESJZ3PF);)STg5G#Q20b[gBL>3[Tc+6[TVB;G5BBT[:Q-eUM9+@
5I.MZ?:RK5#AOH6547JSW2g)2VF5I-3JP@<EaAL?:3UJ,;Z5=>)ESPBUY.WP0a^^
0>J2YcOY[G5QFG6JRJE/12CW6TdHNcFb8&68aEEIDTd;cQ:HAVP-V#[2@,9Ob:g<
3R(124<]egO)K?H1JRN:KI@f)M7.=>aLfP)=\&0#)ALd[66UE\2;#9f9;gX7;WQ4
b4E1WJHbE,;YFZ?SWW\7+@;#]^K7a#Y+ZWK/#XSD9K.3Z@CN8.^#1Wcb,;8-=@LL
3O9C^6IVEf5[6[YRE9.W1;_,92S,A^(EI[&HFBNT(=_F45U@Oc[P/,P,O<4K,gg/
5_(L1MC0@eb#_J.^0V-[(5P=Z.W_7@U,YGJ@(U^PW2FP34=T.I&bP#BG8L9T;S<7
&9)df-X@_0:]FY=Z8<d9FU>\\N;23&1\+#Wc85N#OLecFJ5717:WZDBODa(b&f,X
JS9@Hf.BfAQMX&B21WK3,XZ80_QTGT54a#[?KK09M&NANcf,7dOFA6K:CP0KLAJe
>1VHDM@d4PNY0g@:T.9+cAD22K>f;C[1E[;&F4H&?MV7]S0#V<QH1A8)EcP]HT+<
K,PX<W=PKIW,C;[H.=X7T(W1;PTK^RdAP.VNJ\5X7P#<;K;bWag;/L7E[4^OKD88
C,Y=LaUEA:F=PK+N@,)_H2Kf^?fUZ:O_/D&)\a)N[@(H.M[=HWR.4EW<7-3)KXa7
dA/cDZ]=X^Q>]T)8bfbZZW@J20McRI>A>XI6M;+3]TaS7(-V&J5<fW7L-CRV6cC;
I0gJE1Z0[K45R&&2\-TVFb&-+d9R2a9QKa=HNS9U<XV=:_@Z2aVE>^MJb&;P/aZM
O9B,9?+2P8\d_QBeGC+-G]05b/eIS/2)F4V5QDFJ/eYP@0QRC:.IE5cA52^T<RAU
E_HE>#4Y.YQcHf;Z17+fe_Ne477?).\_27L-ZZS/P5Y47fK12<e67[;/73O>\XZ&
Ze<cR4K\Q0-W5CIGHHA(QB\#BJ<N=cV/?F,B6ePfV[CAR24W,BbV-NNYX07deD&3
13KN0W2\H1b/XB8L^.bDada>aC=/(f??[J.?C(),=RRIS]+)@VdL81:8d0H1,WG4
aL<b\NYXP+4XZM(4f0^YHVUL4aI.-#\eQDWV.C82BJWLN64ZAQ)PR&Y9D-bS^RI0
U,FMcfE[SWV(<QZcV1=)GG/ANA2e9KHHS>8SFH)IT<e?UM3/?c6REUIQ+01>-8DR
9HLL_MFKMM[&.X9:bX6NE1YO]HGOMRB8T8[>FYZ/4;eVd9PAGe49a3W7Jf7,c=GX
U:7Ye#bELTW8;V+6:K\Y>b^^3](Y]WSOH/^G8R3\G;6Q\EVAcOgWNK0;<EbaQbO+
^2U^=PS6M&O(;)g=M3(Lg0M&4]I-;gZ5<gNQ1-Ca=TfT5M:@>KERT(e5Y9E:NNA8
>W)?H]#^@T<G6A5Y;N4>_bT?CCA.Kg.UXR(8<OgC<Y)W;bB([QEPZB+Z.JG8R8FW
Le4UEA/4fb^L+E4J-IaOJ[YY^XQ92f=9TJX/d(0+2Kg[/H718/Q:+<J0@M:.TWg(
\G?Td1VIgd1,7&)KT,6Ud?OeIK3QC93WeYK[9>T\JO6J/XOFFI#M?gZbMI7SY/fC
bI8Gd[LDQ/6,/.TPIR;T8]FQ:]^N9cf75I@&^36QN)O@?IXga_;E&(0=@\U[))@W
fTOF9+QQcZEI5(^e0AE\b?bCA5MC1YC#^5-;-<ca9a?b1K,:C,VK6Ea<d7GT1=@a
A#\BgC1[(c8XW3/R\IO]>d2<YJ6f<-#HNQ4gEHR(P2cG4U>b;XW.:a]QEdJZBG1H
X&#B.\fU//SS)RR>?4[/4CXEE;[1O]P2aTFJLQ5[;Z_Y7Y:Z-.B54:cGM9e):EMU
848Q;Q57T5[,A6Y>9J/7W\Wc.N:]SUBY)_OKT:K=#@8WY2?=^[G>eB8VS?5eDg+]
WeVOC8[4-8+XC)SN3Z.O>EKDN);RL6AXR8>8#Ff7+>\-QT0\&FdObIFZ7^2M1@Le
HTB,.V=13^]5PSJP\12]eGN&=\-7.).PII>D^QS;-H/4V[QJQ2ag0UTI?UBdTG)d
S-QY)U8<OZ0JZ^eBA^\d=D@SI2UV+c=9M>0)5cD8D]7(H5>d&G\T@:XTd^e^A@XN
O9=X+C(aXIE-fFK[4Z0g1<Tc[9C9YK5M)X3_HJ+G.^Ie6\9.U],gGb,8(dN-dY+8
CC;PQTL)6H3I3WGN,:bI<\Z0d#Q^Z(8+#\H/:[)7ZS8X5g[V_25#d<81Q>6[]/2;
50gD]LMYT/#ONU/:7.3@MTO-7b3>]0<X,gK&AN@9]VQbKGLb=(+Z6NMfbGW(DKO9
X+.>D][20[29139e5.JR3C3?b@=_&0^bIDKF;bII/g[YfXV8-Z&C\1+EZA/-G^8V
B34]=NRaL7Oc#-<=X30Gd3#OfE=)SB?B7JG0e7W8XQ0_K/a=LD7d<4X8,4AO9JWO
d3P(a0^>)GE(N5Jc[E6QZ4##c,d/VP<\=7[H#3RJW45X1dc02Ted1Y=R[d(.L(YL
VQU2JdH&Z\IW.WO((DC&XEI/?2dKY&VTP^T7#5(OI:-g1LI4)Y^L>9#D2,_b<^KO
gXYH8?1><DDTV?3E_N>UK5QVQ@=ag]8VX&PL<>>W^e;d\IWX-Y53/785)2:d+WKA
Gc42/+8O<&<Ta=I?aW@4QFZY>CB2Y)d#7QgA6(,[B:P+0=N;acVNMTW[fb\X;69=
;&T)P0bF3a3#;d9(PaB5GD8f&#:?YZ-B:#@18dJ3W[9_0;[W-A8d7O3;<RCG,8WQ
@<FMIR)0Z=5YbJV?M@)R25g-0b5P^HNP\KR?PV?WFeU+\8>YGSFB</IF=(++(O+M
1dQ5W/:HYV61a.J_0;eYBQcUI_(KLgX0H2WadMD6WL3f[gGD,X])=GMdYOGT?5&:
a1/(.b[->YQd42TR:-Jg#bB=):K64&cbe[gHa>6@1RgJcaG6JC4,]PeSe)FVUM)K
?4Z7bDN([DSR-Maa(TKOd?2HV);>1DHL:QF/3EMA1C_T(2-GA#3KbYJ:MAQ[2XFG
If7NT_+L0^#]5CM.8H)>VC,@85eT[>6FBJV7O,8\EeXA#+VEWDCSRUO-F.XMG\Lc
K7]dDgR&f0?CK:gIH/D@\)J&B#O5.GGfGK+_L[<(9e[/[Z4;@M3Cd,TDA<-POCd\
5NO-P5I/TgBFN9==V55LKE7@b?RD4_V94E@G,F+FXAV@<&3XIDG;J#P#dU_-fee:
fVNeX3?K:D26-F(CVc,)ZeY90Y6FZE&K:Z1f04ZKNM#c8&bVZ&W9CG9d=0RUV)?4
A.JF4;@(?YXM4Y,bB//&W<HfVT]CZ6)\/0e34fLb+RI).JPAHZA81gJ58[cAI8FH
X>FgYQdYM7Xg;UB,VY^c)6I;__98:XS,P<+7LfIS;Sg;_XC6I>T^5B1R:b;d#gB,
^Cgc/1HH:-CZ3bW(LX[K\I;5?WW>WA9OLMS[eVXd6]dCL9OH#G#Gb;3dEU#W97FT
^BA;=9QEP2#]-KQJIATbP7MU^8?MD[&+<dMQKPVZ29SE]>gRXK[dWggF@d1DBb/\
_1NNXcC2P.bKEe#<J=VXQAg,(NKgPM<+N[2NP^g&]eB56[O8ZBRBNeCRXg=0Sa@_
:)N.&3WLcaeO)Y@\/XY#VB._/2J\NfTMBNL>8e05<WC,>QXRFNgJXd&C#J1XT_74
(c8RVL\c3dW7<d.RMPE4^M(JED,REg\-+gO30&JA)X_/Q?,Tf9]DVcb32(<S.-;L
)/^J.[>&Pf72)R&/,\0+H,MQ;9<FQ;B0&NYJc=\A5F8)6_DQQW=V2MB_PACK?OVc
e0/O>#M2?.M8IW.(c1bd&d_1UB_G=)[S]g@]@+.Z0=@f<:QXL#9#E74ZB+,(A4K^
2DM0\VY]HX_gfWS#e?P^ERT@A2ICMNI^cHefN.YbZAHOG)>9@\gLK7J:(f9J)703
#>7QIC(bDF[RC2S^0>Q6gI4L=>L=Y]34a/XDaNI[A=<[fK.EC:1=;]1DYVRJ,S6W
Q=CRTE5d5a;<a78RAJ4WW;0WU^8@L#Df=A0@]aS)#->0YSd:R;T8Y3KN?L4U6G_e
RPPD.DTFG<G4Da:Xg.8Oc6PYUH+c7=\b:KCI1d@,@252c+V^bJa7TaJ^CI/fHJW#
dB1,@^_H\<FdO4^>E21X;@d6.GU2WI@aO#J<BVdT8C)DM.PCWQ6Af+0TY,7\5V=>
4NEPC?,)OZ6.E7.7(<YW\e+_CATBF63=,1\:N/BW2>?/eY)LF\aR+\^L/]/VMB&E
FD)I8)UE_0=HZ/>XHY<RR2A6:3P7<6Y9P1L3[=S&PAZ[Y2.bE9AQ_7CE)R5bTI5;
\M(\_Keg<1<]P&^)F8)NfZ5RB^?b2&T<;?[0XDSdPU1B):QY_BX8EL&+KSD)^O#W
2+XCT&+XI)KW(ZI6cYg;gK=FAJ7M54\[DNHb)4U@gKU#5]GgQGW=[=aP;WMU;;#S
V-.f;B4I>LA?@/Z7916_GD]/;bJ93V9>)>(.#KDcFL\,^W&LFS[VMY5X?fcA7ORM
-gIc-V:X&W9Ma34:cK37)IXZILPa:NY=CP:]Z_gXb9I?2<S@63..\UX>U.X8FRDa
dX8b1UBPN&JaZ.E(D8_^e^XP@cAE@>8[^8PGcggP1e<Y7Pb7;B2AV1G<:LVX+I/=
OeZZ@1a=UfS_KcLOFYYRYc@GEgX&SUP6X;N-4\Ve]2FK4AJRLLZ37OE11BLJ_TDb
BM]^/T.B4.1J6S,6bX_?-87cE3EL5<b\6g(@1F?Sc_PA<V([ge5UPN/P8;I_]5A5
/_5;.12fI3HG4R6=)(21[IVeMcgZ>8=T,WZbf&._eB;\G_0cJ^AC-f?1_JL[T?;S
5\=DeA)+BeT.4aV1/-,-9gX7\.fHUe3]OcbNL[Z]Z?S+@FXHN69JF.A3+IMQ.CC0
eQ9>?[ba38aPA</B_JNH9E?2d&OGR9=BYLPZaaf/&.fXU.I,VT2_B>_M6,1VcaA-
<KR1;G:<#5,VfB)B1_Y=4b[P#K]VfK<>X1(6]2=I&4_70W6^);<_[H=N(?Z<]P/^
FL^7aQ00BfET)gT?<<D0N&TBZ:A1&e,S]_M<IAE23KPT>S.6T:0)FR:LP5HA:I9@
b-aR4@:ge6A8?7B75Nd3:d=^<#aM+7d.7E8[XA5a(/2X3V;3^H.?O95d2O((NG+L
+:e?R#N=N#-04OY2S31F406MTMS_.GE+/6\SAG-G1SeGfRA^P&c7IWa0U20EE)-8
#:cab22N&N&]DU0S1ee.a)gHI4=E<SWS_C>eV.aa1DO=&SR@-#K2Q?Y3;-T7A+cQ
]T/FIUGS)O10M\FA7_\P>>##50;6NdaC2PX+PaCNcI2[DSLf/:;-THBEC,f?7CPH
D@Y)8<EXZa#4@N/<&2MdfJ)gK\-Z2&cAf(@P#d;9PZXgU>S4ZR^D))EdTR4=a9ga
;&Bd/?XAU&Q3,JC.2:;J:ZVQC_1>[EORM-),SAC=A6O&TIVXKac:[2gYZ88b(/fY
3d(>EPMWg)9.KY+dJCXZTgBHP<X\H.T?GLdOc,;g/:A;0f]A-7Ic\U+44Be\5g+1
>L#[KK0:LRMb:1Db36(49^C^H^^Wba4]UcbDdR^:SA,e_^eDR+E,<89L1[)X_3=c
e6\4_,>,;04HbKR+gEc7@>=;T=QbY[b0,;d?aW@+]3Ab85HY5OZT&+/>ZS##QE[g
fd.aG7QO<FfaOOV=+O2LZ6>SDK@UDbPBd1;ZW:2#0.8^PWQ2ZM4Ce/f7c(7I;CW^
X8[=F(##YNEN4-8GffJDB)\eRSF50/#e8UH+A42Ka>]>10CfeO#3)9@c0^L-+?L#
SBDED\B4OT&G0ac8D(g7cMdT;(H/^:TM0#-&a4Ga[1RbZXRR[^V5F1V8EVHNc=eV
/&WUZBB_./;=<]BCMVF_cE:?W(?@S.]T[,A12WbJ51KJ]eBFZEI7DRZ[S^Ed#(>1
g@g34WN/2-LN,+7YVMC&V]I?I&7+A<TK+;DL23J-2S4b1KWgVU\JCe)U/J-3(Nda
:P&[C_XNT[ML)@BH]61D4<Y2CF3NY9]a0W@ZIP;b?a3BH(bbP+d?<6Y;UV9/c7MH
JJbKXXLG-HHNc_F]5_]cc+L,;]aY,@&CNR)3b(O]LIOZN]=_8>\dN#B6#(EGX277
W7A,\=WI,O-E<]4CYRO<>DZ=c^<;4D2&Rb3OAAE,F[:4VCGHZ8V&X\fRNe8[>.Da
^YHe\TZ80g,0b<&-[+A7.CY##7RZT;-a25KD1.YP@Y[fF9Yd@>_U,UFK0&:0X3&4
BdXDQXHKM=A\4M4DC:L-bIFJ=)4B;B<J>8?XRC-4ZXa:?7X\0+N7#&<@Ig@7KCYD
W<,/#eeLP6:T6g3/)/1_GCN4J50AP;UV+bZTXbaCNUgZBZ:+5X:^;J&S:1aI8SY)
D1Y[,K<-NCG[76BJd0J[g:Ea7,J,U22_3f_[C),eKU=_O<][6-#d68L:A<HS[6E=
9?Q-Y45&gQ+]/c0#KPSKLT[RdZSPK[8:AFIQX<_N^5ZR8B\-_>.>P><;D8J>c-QF
&_,&<:A57SMYWJ<1/(P@AME\cW]D__^S^JT_&HFUBL+Z46[R4Yd\XfIKZ,F,d]9P
:Z4(>.JBQ93#6N@F51B^>-]GV[\1a_N&+Q1.MS+>B>O]S2b0gc;\Lf]L88&Qe)Ld
GJ06(BH)A(YV=K&=F\;^?gC@f>KE[=e605>&TO-Mg>4PX+>XSE/IL1P-8fYH4C,H
:L5-_1G/#Rb5N3a#[7>I?F,7b;9JQSQ]OGCMT#D5TOcCgSJH^XaIGa_aK8e9/KM1
cV)b<=eSS\\O_d,cb0R]LS52[ECF0L#5_<_XeLS?Y7=ZegKT-=P@7>Z8.Zb3SPJ;
=_f50F@=]dL)8BM0f].A[g7-8<./1?T7=.8cHQdGKgg:)b,1ZST7Y8_5aS+/2:QB
/g6X0+:e&XJUZDM+V8f/(1\NZS@S0c_;1<FF&(J2?a]M5&80-aV0Q-R5OY(5:[;J
b\BZcfPROV=gLWUC1\3=e5#NeO#]8NN:YXDYLHc39H,S.Me[UZSNBV1FF-5,</)G
;E0):51X:&0f3AOCZCIUf70CE&bDTJ9aY[[?\L/Da9.R7R3cXIG:BYZ\,]bN;83>
;Y)T&5)LGD7#0ISUF0P96Cb?C,7S(W@:DE44LaA>Ra?Y;PFcV]A]5,_R\3<UX^8Q
)(Da1OggI?8\,Zc1LLKVO1VI.\?JW;]\QEcUJ5T_Z&7LY.#9NLHB]B0Y9<J0-S@E
;^G,6Q;P(Q]J:C]GeV1P6BWBR=bEAZ0Ce)?>J)X#@KLF\6Ag_2Y:AV8gI()29_+W
R-R=R/.b5^FRb.H^9K(>Ra9-WD:@22<,_+7RYS7R-cI_8YaPEc@5;TO:U;0(LgNF
ZL=\M#RS,T&[PT\T/,TMO7BOF.6FH2d)RIZ_]3_-X.&_PR/20_=GA(<Gf.OO[FOP
We&B[]e0+M9;I.<,g_9+3RO9Vfa79M0,.E0[F6K_Q>)9JUFdMFUK4C9?CVJ#^\>P
&7>8X(R>KH)>D5#Cg:>?<QH1+ae@>Y6XS4UT^0FPEH.&MT1:SM&\+5.f.^,AcaI(
de)G/GJ\N/YY_R5)<RY#L1X6\BAHF?--L\#\ZF9OL\Ng_.Z&69WG4FcDdE^7e@_K
E0Q&&H>d2.7>fWf4)3:8Re=],>^&57F<_6LcW15\.BAb7^26QU1KD=9?A0A,c4\9
)fg(fcPGRWB]H:D008cNW,]d8dQ(b;OBQ@dc87D6.^[VEL#&)=5@Sd\9MKIL=@-#
W#E?&4YBOc;76U;@e70>f)2g?J0Z>H_B75VVdQ-[1AHM=V_?aG>LHBL[^Dd93IE:
7HT\<Rb=I:Y8cee,6QU<X:4QI4FF02M7EO>03g[-EVaJXNNY-P6:29I;Sf6I^O\R
U\/,a2A\6.1?8QJ>bd)6G^Q_ZcF5+_1TCf5CU:P@\/?.A;L:7Q;.ZUaegS.W^+.;
eY?,]<8V[<2+<H^>Z]P3+Of(c@=0BX;;HE<[8+<G4MWW2\9^dL&X-8_V-e=;UfQa
6P\\YC3\=KT<I,HMBFIP]Nb(Zd^0RfVYO0b.:=)\Bc>AB[:1)_SgdZCdZ.(IB12[
-ZZLL>]\L.NZ\QRH+7X+]A+g(/P39GeJ[XKbO=#O0d94JJcS:6A,KF].B0N>=@La
+SE\JKI6\cUK4GV42P)R&UV@4B:Qa[20[D0MWXI3E9Q@&QZ::_:E-+4-E811?CCW
Rd[PZO9=+V#68;G,U/BHeB2Le\/;AcLKc;Dc<FW<)M4@H7H5M:9T/PJ5-)b7@50)
dU7-JP\P9R3SABF\)C0NUEMC_#;cI^7^)b#9cXaOAEEgP;_,c4EDV?XJVC+#YQI0
KE,gW-FW/Ic49KX.9IP^1J^H>6\Ga4gW86M0LZ?O.S2SKR5J[S?eZ@51NHfJ7fE9
eL(FG:NY)DX-Ic6,WAY[QNdS(Y-0>&C:0D01=d-<Y6_3gd?SW)QbPcb#MKYQ,<,&
[SbJNW40^A_NS@1TE60J0P8#IC5:(Pfd)41QU+f9QDMa5R+,+YU/J?U+1E_(<@Ed
A,Y+<f,dW?P[7UARW)da;/SE6DBVJ;2T+NAC7f=)DH@fJ)->X:7=RJX:\QL+9&]S
A]W>fR5&DK6.Q]RVI.g6@-_,_>fX0b)1?4dQ#eD&RC&+\\K)[NNSQ\:5.<@?F)Mf
IZQL[=JLLWWcNRATY-#;+4)A>,0GAFQBZN[D-B[HbG6TE\2e[WB]G+]R<5S^5C,e
QKHfbE?NNMf0K(=Hg:K;)Cb-NNO>N<CCJNa5B6g2>0<D/Va2#Id#bGX;@a(027/1
-=CTONgAgb]C0MU+_N;ZBP?&N\ZU_PIO+WHZX\28]DM614d8Ud,4Q8^=f@<^3.+-
]SC5-6SY9P)+aCUa5J6.9I;D==;PDE]=(XT+E6CCL39+3QfZWY<HQ:T_6;0\BD+Z
;7-/[cU;efF\/]f7>OYA9XabKScH0d:ZKH@]#6adb]W0YLafK#Eg@1>fI>aH5FDL
TJ.Cf#PDfG.IVU&5KeVFd_6=TE_e&O<SS[F;H/]YKcZ;=d5V^.0d#3CL/_B&>b6D
P/-;P?20eK+U=,Cg+8,:J&:A1:[V4dN+cR2X[[=;7YO\H==,1P;f3W6Rb7L-HU-e
43_+36FY8_2#]K_/@HK&Q62GM9bA9/VW5c8T)f?+3LS0HTWMTU/AXVAK+4+d;/X5
YZRb<fBZ/KI4-QN<BebSM1d+&7bZSYDWSG1&M)J:V9bFCd[+(@-]WV][8W[;>]EI
FUbJg(@5\]FFbF+=2K:^@Z_0&NLaAAU+P,_8WP&CNfdZUM<5DV?9+>E+157LX\&_
IV3>MJd[Z1>S_)IV)XeEG2gB[4612KPI?P&GNGWWIY)654)[3>bM>NBDa0cdH^cH
6DYN72R[cN5g]V>.]Z@N&H.+g9R;4f^0d./Xd]&f]?:65=R-AN<7EC0-TJ00X=:<
f0a4F,19eAf#Zc6eDd9HZDYN?e0#(Z^])eQVT8>8(?egNC==8<GGK_7cI6<PUg57
-eD.JXc?Z>IX+gG[4dEK/&N3]1a843cE05EEYCJ+e&5J:=)CB?b7<#g[#]0gC1QC
O;?0cOR,CK73b.]<,JYSW_36Y=[BEbOUP[O\dHeM-Z+#O;R=8\[#GD?T_QgR5+(<
aVQ8D\#]?gc-,E.6fQc,5+U6C8WSN1-,RcDP&R<QF<UL^QQI9NPfcX#).(JT16Wc
QCdSC>UQK5,R@H;12S]eX&Z/^1\RLbN+\B1bU/:GJFg8=)^G5C.99.\1D&92,7:f
P@cfN2_ab@EJbg9;O<WQ1.b(R3>:51JBQ3>^KJS:eU[N[;1.YD9;]A;PeTRZ2<HT
BCIZV,b1DJKdWB>K].Ba9ENJcA]O>2BGM6d]eGH9;VR6&VLM\H<WH8@2LP2Z@:U+
H;K\c,eIP2G7.V#e7V9a\IM(_QLOF:AX99MAA2dM2MY;\a]@/G(>#I9ZNALD??cc
-feO2^T4Z+_6I\Y:4^b5g.#<Yf7TIaeQ4FR]4Ic:#QHS>e)^?M(F?[]\+JSVK/+b
@>WDXcJ:))<#@;R79a1HeW3(4,9M5-<G.B]43NRFG?9JZ-)>I8a>-C[-1#&/P0ag
@GIOTd/@cVf@Q<RdQg5egD]>)(3\7f=VIBP6PD,_L.K8Y^;a>O(,,DS)aG;G1<MS
-=1)9CJ7(.eV>SJ0I<6G>0<4ZSJ+6<+?GSdR?1eL11>=f@/M:S.#IdY&S,VBDC58
249c=S].7YS)&IMd,3gS]A\&_D7RE8DA\/(E5f(=:5#L16XO]KJ@3N5g,96+7eY9
#PMMOd(#Xe5U7,<#[3]f79B7O6=8/QJ#3Xc:LfLbTcILFJcL:K^:OeW0E:@2V+VI
H3E4^0eXLF0>:OeSL?_A\RLPSa]S4[TQg.:/\?5(0g)NNORMbEd2<:49JV3\g<-I
V>;[&a6/f+S52_.gR3:E[^JScQdUDHI_b+>>E.R(XX<eWb[)H.VFP;K(X1J^_#O^
2WJ,,e?QJM^8ZLB:e/R6Y#SQ^<Y9P<R;U4d]bHQbCId,ZYLH:>UQ]-L=S3e=4FFZ
)AL3]Pa#c8\4ZU2Z/009:@,B#agf:ZdO];.]fK[M:#?.1eE56J&VQ1+OLF5<F,&)
[(cQ61_b3@?Ag9HKZ/aTBCIAQbIcJ>5+JO_LE+PK-2R^Z9FNZ3E#g4S#9/I7K50/
5^Y\#UMa(=#5dC8EX;9DP4G4H&D(HRJ>\CN&GTO5GVE,NH]AWgecGWS#L$
`endprotected


///////////
// NOTE: After encountering encryption problems with this on some simulator versions, leaving this unencrypted
///////////

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
//------------------------------------------------------------------------------
function void svt_svc_message_manager::msglog(int client_verbosity, string message, int message_id = -1);
`ifdef VIP_INTERNAL_BUILD
`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVC_MESSAGING_EXCLUSIVELY
    // If not relying on SVC messaging, should never have to reroute messages to $msglog
`ifdef VCS
    $stack;
`endif
    `svt_warning("msglog", $sformatf("Message manager '%0s' rerouting message '%0s' to $msglog.", this.get_name(), message));
`endif
`endif
  if (message_id == -1) begin
`ifndef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
    $msglog(client_verbosity, message);
`endif
  end else begin
    // Need to type the message_id based on the simulator we are working in.
    // Styled after the original SVC message IDs, which are module parameters.
`ifdef VCS
    bit [31:0] sim_message_id = message_id;
`elsif QUESTA
    reg [31:0] sim_message_id = message_id;
`elsif INCA
    logic [31:0] sim_message_id = message_id;
`endif
`ifndef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
    $msglog(client_verbosity, sim_message_id, message);
`endif
  end
endfunction
`endif

`endif // GUARD_SVT_SVC_MESSAGE_MANAGER_SV
