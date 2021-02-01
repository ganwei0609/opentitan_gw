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

`ifndef GUARD_SVT_MEM_BACKDOOR_BASE_SV
`define GUARD_SVT_MEM_BACKDOOR_BASE_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

/** @cond SV_ONLY */
// =============================================================================
/**
 * This base class defines the common backdoor method signatures.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_mem_backdoor_base;
`else
class svt_mem_backdoor_base extends `SVT_DATA_BASE_TYPE;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Pattern type to define the default value for uninitialized memory locations. */
  typedef enum {
    INIT_CONST = `SVT_MEM_INITIALIZE_CONST, /**< Initialize to a constant value */
    INIT_INCR = `SVT_MEM_INITIALIZE_INCR, /**< Initialize to an incrementing pattern */
    INIT_DECR = `SVT_MEM_INITIALIZE_DECR, /**< Initialize to a decrementing pattern */
    INIT_WALK_LEFT = `SVT_MEM_INITIALIZE_WALK_LEFT, /**< Initialize to a walking left pattern */
    INIT_WALK_RIGHT = `SVT_MEM_INITIALIZE_WALK_RIGHT, /**< Initialize to a walking right pattern */
    INIT_RAND = `SVT_MEM_INITIALIZE_RAND /**< Initialize to a random pattern */
  } init_pattern_type_enum;

  /** Compare type which controls how compare operations are performed */
  typedef enum {
    SUBSET=`SVT_MEM_COMPARE_SUBSET, /** The content of the file is present in the memory core and any additional values in the memory are ignored */
    STRICT = `SVT_MEM_COMPARE_STRICT, /** The content of the file is strictly equal to the content of the memory core */
    SUPERSET = `SVT_MEM_COMPARE_SUPERSET, /** The content of the memory core is present in the file and additional values in the file are ignored */
    INTERSECT = `SVT_MEM_COMPARE_INTERSECT /** The same addresses present in the memory core and in the file contain the same data and addresses present only in the file or the memory core are ignored */
  } compare_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log instance used to report messages. */
  vmm_log log;
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Name given to the backdoor. Used to identify the backdoor in any reported messages. */
  protected string name = "";
`endif

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_backdoor_base class.
   *
   * @param name (optional) Used to identify the backdoor in any reported messages.
   * @param log||reporter (optional but recommended) Used to report messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", vmm_log log = null);
`else
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef SVT_VMM_TECHNOLOGY
  `svt_data_member_begin(svt_mem_backdoor_base)
  `svt_data_member_end(svt_mem_backdoor_base)
`endif

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found at the specified address
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  extern virtual function bit peek(svt_mem_addr_t addr, output svt_mem_data_t data);  

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address.
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke(svt_mem_addr_t addr, svt_mem_data_t data);

  //---------------------------------------------------------------------------
  /**
   * Return the attribute settings for the indicated address range. Does an 'AND'
   * or an 'OR' of the attributes within the range, based on the 'modes' setting.
   * The default setting results in an 'AND' of the attributes.
   * 
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  virtual function svt_mem_attr_t peek_attributes(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
    peek_attributes = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Set the attributes for the addresses in the indicated address range. Does an
   * 'AND' or an 'OR' of the attributes within the range, based on the 'modes'
   * setting. The default setting results in an 'AND' of the attributes.
   * 
   * @param attr attribute to be set
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  virtual function void poke_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Loads memory locations with the contents of the specified file. This is the method
   * that the user should use when doing 'load' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls the internal
   * method, load_base, which is the method that classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * The 'write_protected' field enables write protect checking for all of the loaded
   * memory locations.
   *
   * @param filename Name of the file to load. The file extension determines
   *        which format to expect.
   * @param write_protected If supported by the backdoor, marks the addresses
   *        initialized by the file as write protected.
   */
  extern virtual function void load(string filename, bit write_protected = 0);

  //---------------------------------------------------------------------------
  /**
   * Saves memory contents within the indicated 'addr_lo' to 'addr_hi' address range
   * into the specified 'file' using the format identified by 'filetype', where the
   * only supported values are "MIF" and "MEMH". The 'append' bit indicates whether
   * the content should be appended to the file if it already exists. This is the
   * method that the user should use when doing 'dump' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls the internal
   * method, dump_base, which is the method that classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * @param filename Name of the file to write to.
   * @param filetype The string name of  the format to be used when writing a
   *        memory dump file, either "MIF" or "MEMH".
   * @param append Start a new file, or add onto an existing file.
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional dump modes, represented by individual constants. Supported values:
   *   - SVT_MEM_DUMP_ALL - Specify in order to include 'all' addresses in the output. 
   *   - SVT_MEM_DUMP_NO_HEADER - To exclude the header at the front of the file.
   *   - SVT_MEM_DUMP_NO_BEGIN - To exclude the BEGIN at the start of the data block (MIF).
   *   - SVT_MEM_DUMP_NO_END - To exclude the END at the end of the data block (MIF).
   *   .
   */
  extern virtual function void dump(string filename, string filetype, bit append, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Free the data associated with the specified address range, as if it had never
   * been written. If addr_lo == 0 and addr_hi == -1 then this frees all of the
   * data in the memory.
   *
   * @param addr_lo Low address
   * @param addr_hi High address
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  extern virtual function bit free(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  //---------------------------------------------------------------------------
  /**
   * Initialize the specified address range in the memory with the specified pattern.
   *
   * Supported patterns are:
   *   - constant value
   *   - incrementing values,
   *   - decrementing values
   *   - walk left
   *   - walk right
   *   - rand
   *   .
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   */
  extern virtual function void initialize(
    init_pattern_type_enum pattern = INIT_CONST,
    svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr = 0, svt_mem_addr_t end_addr = -1);

  //---------------------------------------------------------------------------
  /**
   * Compare the content of the memory in the specifed address range
   * (entire memory by default) with the data found in the specifed file,
   * using the relevant policy based on the filename. This is the
   * method that the user should use when doing 'compare' operations.
   *
   * The svt_mem_backdoor_base class provided implementation simply calls
   * the internal method, compare_base, which is the method that classes
   * extended from svt_mem_backdoor_base must implement.
   *
   * The following comparison mode are available:
   *
   * - Subset: The content of the file is present in the memory core. The
   *   memory core may contain additional values that are ignored.
   * - Strict: The content of the file is strictly equal to the content of the
   *   memory core.
   * - Superset: The content of the memory core is present in the file. The
   *   file may contain additional values that are ignored.
   * - Intersect: The same addresses present in the memory core and in the
   *   file contain the same data. Addresses present only in the file or the
   *   memory core are ignored.
   * .
   *
   * @param filename Name of the file to compare to.  The file extension
   *        determines which format the file is created in.
   * @param compare_type Determines which kind of compare is executed
   * @param max_errors Data comparison terminates after reaching max_errors. If
   *        max_errors is 0 assume a maximum error count of 10.
   * @param addr_lo Starting address
   * @param addr_hi Ending address
   *
   * @return The number of miscompares.
   */
  extern virtual function int compare(string filename, compare_type_enum compare_type, int max_errors, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi); 

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the backdoor instance.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are supported.
   *
   * The backdoor class may represent multiple backdoor instances in which case
   * the method should indicate which operations are supported by at least one
   * contained backdoor. Clients wishing to know which operations are supported
   * by all contained backdoors should refer to the 'get_fully_supported_features()'
   * method.
   *
   * Each operation included in the svt_mem_system_backdoor definition will have its
   * own bit value. A value of '1' in the bit position associated with a specific
   * operation indicates the operation is supported, a value of '0' indicates the
   * operation is not supported. Note that this insures that as new operations are
   * by default not supported.
   *
   * The following masks have been defined for the currently defined operations and
   * can be used to indicate or check specific operation support.
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  virtual function int get_supported_features();
    get_supported_features = 0; 
  endfunction
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which operations are fully
   * supported.
   *
   * The backdoor class may represent multiple backdoor instances in which case
   * this method indicates which operations are supported by all contained backdoors.
   * Clients wishing to know which operations are supported by at least one contained
   * backdoor should refer to the 'get_supported_features()' method.
   *
   * The default implementation, which should be sufficient for simple backdoor
   * classes, simply calls 'get_supported_features()' to determine which operations
   * are supported.
   *
   * Each operation included in the svt_mem_system_backdoor definition will have its
   * own bit value. A value of '1' in the bit position associated with a specific
   * operation indicates the operation is supported, a value of '0' indicates the
   * operation is not supported. Note that this insures that as new operations are
   * by default not supported.
   *
   * The following masks have been defined for the currently defined operations and
   * can be used to indicate or check specific operation support.
   *   - SVT_MEM_PEEK_OP_MASK
   *   - SVT_MEM_POKE_OP_MASK
   *   - SVT_MEM_LOAD_OP_MASK
   *   - SVT_MEM_DUMP_OP_MASK
   *   - SVT_MEM_FREE_OP_MASK
   *   - SVT_MEM_INITIALIZE_OP_MASK
   *   - SVT_MEM_COMPARE_OP_MASK
   *   - SVT_MEM_ATTRIBUTE_OP_MASK
   *   .
   *
   * @return Bit vector indicating which features are supported by this backdoor.
   */
  extern virtual function int get_fully_supported_features();
  
  //---------------------------------------------------------------------------
  /** 
   * Internal method for reading individual address locations from the memory. This
   * is the peek method which classes extended from svt_mem_backdoor_base must implement.
   * 
   * The modes argument is optional and is not used by the base class implementation.
   * 
   * @param addr Address of data to be read.
   * @param data Data read from the specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if a value was found, otherwise '0'.
   */
  virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);  
    peek_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for writing individual address locations to the memory. This
   * is the poke method which classes extended from svt_mem_backdoor_base must implement.
   * 
   * The modes argument is optional and is not used by the base class implementation.
   * 
   * @param addr Address of data to be written.
   * @param data Data to be written at the specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);
    poke_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for loading memory locations with the contents of the specified
   * file. This is the file load method which classes extended from svt_mem_backdoor_base
   * must implement.
   *
   * The 'mapper' can be used to convert between the source address domain used in the
   * file and the destination address domain used by the backdoor. If the 'mapper' is
   * not provided it implies the source and destination address domains are the same.
   *
   * @param filename Name of the file to load. The file extension determines
   *        which format to expect.
   * @param mapper Used to convert between address domains.
   * @param modes Optional load modes, represented by individual constants. Supported values:
   *   - SVT_MEM_LOAD_WRITE_PROTECT - Marks the addresses initialized by the file as write protected
   *   .
   */
  virtual function void load_base(string filename, svt_mem_address_mapper mapper = null, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for saving memory contents within the indicated 'addr_lo' to
   * 'addr_hi' address range into the specified 'file' using the format identified
   * by 'filetype', where the only supported values are "MIF" and "MEMH". This is
   * the file dump method which classes extended from svt_mem_backdoor_base must
   * implement.
   *
   * The 'mapper' can be used to convert between the source address domain used in
   * the file and the destination address domain used by the backdoor. If the 'mapper'
   * is not provided it implies the source and destination address domains are the
   * same.
   *
   * The 'modes' field is a loophole for conveying basic well defined instructions
   * to the backdoor implementations.
   *
   * @param filename Name of the file to write to.  The file extension
   *        determines which format the file is created in.
   * @param filetype The string name of  the format to be used when writing a
   *        memory dump file, either "MIF" or "MEMH".
   * @param addr_lo Starting address
   * @param addr_hi Ending address
   * @param mapper Used to convert between address domains.
   * @param modes Optional dump modes, represented by individual constants. Supported values:
   *   - SVT_MEM_DUMP_ALL - Specify in order to include 'all' addresses in the output. 
   *   - SVT_MEM_DUMP_NO_HEADER - To exclude the header at the front of the file.
   *   - SVT_MEM_DUMP_NO_BEGIN - To exclude the BEGIN at the start of the data block (MIF).
   *   - SVT_MEM_DUMP_NO_END - To exclude the END at the end of the data block (MIF).
   *   - SVT_MEM_DUMP_APPEND - Append the contents to the existing file if found.
   *   .
   */
  virtual function void dump_base(
                    string filename, string filetype, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method to free the data associated with the specified address range,
   * as if it had never been written. If addr_lo == 0 and addr_hi == -1 then this
   * frees all of the data in the memory.
   *
   * @param addr_lo Low address
   * @param addr_hi High address
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  virtual function bit free_base(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);
    free_base = 0;
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method to initialize the specified address range in the memory with
   * the specified pattern.
   *
   * Supported patterns are:
   *   - constant value
   *   - incrementing values,
   *   - decrementing values
   *   - walk left
   *   - walk right
   *   - rand
   *   .
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   */
  virtual function void initialize_base(
    init_pattern_type_enum pattern = INIT_CONST,
    svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr = 0, svt_mem_addr_t end_addr = -1, int modes = 0);
  endfunction

  //---------------------------------------------------------------------------
  /**
   * Internal method for comparing the content of the memory in the specifed
   * address range (entire memory by default) with the data found in the specifed
   * file, using the relevant policy based on the filename. This is the file compare
   * method which classes extended from svt_mem_backdoor_base must implement.
   *
   * The 'mapper' can be used to convert between the source address domain used in
   * the file and the destination address domain used by the backdoor. If the 'mapper'
   * is not provided it implies the source and destination address domains are the
   * same.
   *
   * The following comparison mode are available:
   *
   * - Subset: The content of the file is present in the memory core. The
   *   memory core may contain additional values that are ignored.
   * - Strict: The content of the file is strictly equal to the content of the
   *   memory core.
   * - Superset: The content of the memory core is present in the file. The
   *   file may contain additional values that are ignored.
   * - Intersect: The same addresses present in the memory core and in the
   *   file contain the same data. Addresses present only in the file or the
   *   memory core are ignored.
   * .
   *
   * @param filename Name of the file to compare to.  The file extension
   *        determines which format the file is created in.
   * @param compare_type Determines which kind of compare is executed
   * @param max_errors Data comparison terminates after reaching max_errors. If
   *        max_errors is 0 assume a maximum error count of 10.
   * @param addr_lo Starting address
   * @param addr_hi Ending address
   *
   * @return The number of miscompares.
   */
  virtual function int compare_base(
                    string filename, compare_type_enum compare_type, int max_errors, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null);
    compare_base = 0;
  endfunction

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Used to get the backdoor name.
   *
   * @return Name assigned to this backdoor.
   */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the backdoor name.
   *
   * @param name New name to be assigned to this backdoor.
   */
  extern virtual function void set_name(string name);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used to get the backdoor name in a form that can easily be added to a message.
   *
   * @return Name assigned to this backdoor formatted for inclusion in a message.
   */
  extern virtual function string get_formatted_name();
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
J:a#S27B1)5J=d(;eGfS(5DB0dg^dNf#9fa(M3>dSM#H[e<&Y?>6/(/-YON,a9ZG
9:_(3V]1(4P#ZA,\@S#0..&>9#YKC0__QT59S8dR^\]I.G1OcHeH.b)7;dON3@Ie
bPg>FJ9]ME8[.NTUVYQ)Q:e8TPKV]7><Ud^^D,=3,ZfWB?L8PFIc;6VE?H]GeY=:
gDSD>/^351-=K-@T:874KHR6Z3&&G\[M)TH/D->1R\W[+Z@_IQe<gB)WN(N8@Ig9
01=U>8^GSHc=/.S0+A5FaQMWYR,YF0J^50&]7LB0(bF,CEZf_1LK1b>7d-e)ZI_T
7[eXS:VB7;5-PMZM43,^R0DB1f3]WDXF(37V;4SKEN(Z=@Q3e9IRBEK#FXR8c-M5
&=1/(8-LE6@XU>0DUD\#ZWg393e8K>BOd,Z52>VS6_g@VgRN=0#+V5:M-,AJ_IaL
_Y:K[2A3PTF^<9&Sf7#1MYW+HB?TbAU5/][,,NeJ:e[LZ5/LT,g&M3)4B=Ye>-];
)KK7Z1M:WOL88-deXCH+4?eB]7Y4E,acHUBR-N,<],8G_#>5B&8BZ1]aa3&9O(XA
1]cJ[[B54,1GQ/<Z?T1.:.Ag=<+[IQ(__B=;>&3#c9<\<7]2HXEbLS,1d^+M/@JG
7)S>^e_e8f6W75A3I<QDbK+EK1)Y,d/\9.QEO^E^2N@5^<.P+:^<95A_cQ\dUBd6
VIKFG)/LRRAKA?RaK;]U,I6LL&:2D&A&OA+:,O-1[=A+f4K&>C=bT,d?#L=SY5(@
U1Lc<9^9KI;f>=?XP2=AX;f6ZEc9#+IV292EK7GZ+](;7/b&B?3SNIQeTa0>MVFd
:DDQ5.P8(M2I9/?cfYTMAN_<+F.bHe<H[D)D<I__M6Q?[e]CTBgF+&\HC7&04&G_
J>Jd+eIfW[eOTFK)_Y/3L,DJdHB,:>gPD7C][<,B1fMNOUC/aRFH-HS-a0FTaPS\
47?258g8B9H+35daSHgfGf;I<=XK[<S-E\83Eg3/FgQQdF[G)D.,I6ae4c/&(VDb
,Xgf.<?5&8\1;<=9Z<AZTf^1HZ_?+W_c1H>^-;VYUO<L2Ka+CHHG/0Ne7#;eL43T
P.SYKR;:R4d7+:ccZHF[JH8LF4AG=Hb=ERJ1HeT03J#,cI]0ba)U=?)@:SH7&ec9
9C(XK0W.aHDB8MZ^(:Y,1YC+7(^bJU@gY>Sc097W,dVB:@+J]eR9E<3-?/Ff^+D&
;J:]a5e7HDD?eJ\Qbgc2f_A]\Y7]caMJaCOC.X:gd:Y_&<L1]AgA+O(2ZYS]&P#c
2BU8X/0KC<:Y,@@5&J(>B]?:C0\Fb.;4X[/.d0FCf:F8f6Hee926LN/1aR_>I[>H
>OHTJ(/8LYTY:54>)-<DP\W3X2Z_,_U6_63K\V-WCa@a\X-Y:,A[+7W4dE8&WKbE
d+S>[M=/>Z>Kbc?]RfS+:EIXX6RL_+CFfeDI:Hf6JK2ffAO2dHf\<.IA[b_+JGG+
<4H6O6BASfZY>2.X<Z#+2-YSPW]2f\4C@RC7^?ABa?0f#VBQQa#?0F=[1X0?T/V#
R](T1GcL741KM[^;M_.KM:WL38+6W2FC/OPU[;;H)ZKaF.\@LfIDBJZ0=GKMdF0c
&/-FM1TXNXMQ-/H#=WbXT:ADT?3\W9WX>E\)LNfL.]&PQ.(^)88]Ie:Z[NGb,NWN
6SU>Ie:20V/Wb.ZIDPFG4SKS3KI4)FbX:ELd8S9B^ENF8H<(QL[gRT4H@+,cL;g/
:@:W4\EAYCQ-XG4,(Q6JbKZ,gTOB)_4NV?Rf0OP@&AQR3#D_8EK=0YDQQ_?:/BW4
+KaP>IV\_=.LYR9M:H?M/KH:NIMKM&,&7g.)5]Tg\QfGHBOaQORbD[2d.5:X<HAX
U&F]W=g?.J60JH)B\SE0Vc6G180Y],0U-C3fbJ>#LZeCN4/LEP[e^/5C+>=,aF8K
7Y2HWWbKSFFA+QS/.b/G0bWH?aH>d4Of-EDK6L,dCEN]c]gdBLY_CSZ<>--(a)=0
6CI@H)c<M7\Q)6I3G9BGa.XSMWZd\)?DO(0-<.FA7>@52XQAHf-D?E7:K?b^5RbW
/0M-O8K58P<@&8W:<P]W2_)J]+RdP+[?I,4+Q<S=/L9C_@g,T&<3:,&R3WH886+P
2_RNVd3?MW8bTDY:.AJ<g5+7bC\MFC;W.=,+?FFg@<):U+=:[d;&MHg<Y/Y6BTee
gI-U#1?ZII>/<D^_VD7@#1#dFMBG@2@-.HG6,M7.^1?GS@Y+;YIAX0MGV@Ld/Cg]
2f7JK_&_?9^_6OXeBMUgD^J1SdQ8<@ZJ]bHE[bLM3,=D+bLdU5P]C/5@/XIJb(BA
S+;BTXORU@d6[,E5/(ND,37dUK#VZ[#VN-J@N7EGK=P>8P9\E@?)M0Gb^ECSKUV=
]>28TTPU65Y8P\fdU,>/L=dZ>L+bQ,_f^K7C36\aFGO_8_XNEKbJ(VAD4)UY/eQJ
O^@#L7Q:Y6?bagf((@UG4RG=@[9IV6D6f\2_,d39I9ZIb.Q54aP6H__2S>fIZ3=:
3K7_V&\5.[3:IZ/bYdN[VB8G=O_-C2-c7_cU9Q,gP0;^Rf>PN+X@;33+?BZWDf/?
_C8+5ZI><M)6&#<,eV4=Y9BQ=0KXRI<XXIXOg])N=W)P:1=K\:;?(A+><b)X#1QL
]0UPA:T\ZK3,N&Gf+/7)9MJDBNZ(0SH.PM6Lf4<(()7/+R:F2L/.@gS&YbHR3?f,
3F7AOFI.cC98,>1c5?VeK=[c,dW_,<)?&IB^NW95,;9:QS1OJ=B;0ISUG_062]3U
QT2_gNO7=\L@^Z7Bg7RgWS.fL::d4=-M4#1<^)b_EcEaeG]O)\<cPRaBHQ;f/;e)
gBL118TRU4gT>K,O7c7RS\g^L)#Db\\(SW5LRF>K[+@AJ>PaM2b&Wd0MLP^d+,1H
Bf^[:.GRY0<JTTA&e0+7bgC7G;JYAUOIbb\@gf;,,,&E29RE\5YOD?@,)_ZGU^4P
V45)e]GB(=b>=LdeX3VB]I]U:^Pgg>GB0,bGWF[GJ\;S=+Vc(GR+>=]&A_]C,AeS
+:K,0Mce@58gM?L<RcSG@Tf]:fO;/,?M^8X/2a^?GFPCf,\U:F8V8UCQ\.8F3N79
a7]bLSKIXHW@KQ/dN,MHA\-:_RN^W=+7[XR9R(J(3@8@.C5]I8bG0QP3]])dL^>,
#R:a;2aJBM<d=T<7X2HT>+M;GT9/Hg4WLGa?&_OE+N)dZM3[<R7AB9+76;F52d67
KIP7RR-IYfQ#7NQ#]VVBHDEFP+9>;,M)+=S;VZ)PC[cefd.5B<[U2YT,3^U1a;6Z
0e9QAHY\LRON46FV30,_;2>O,T<GWSM8^cfUV?P(NW+e8WAaIEZdF<E_/9,O=S9Y
K_<1CYUQNJS8(<]O7MLUI.VV>WJg,)EeKR2W6TSM>g3,;J2/C:Z:6KP7bPZVVdg<
XW;9e.D<>-&+C:ea3\Y[J#@G^<-\O[CG#;(=,RdB@GQbf\fH+T-P&.FB24941..C
;Q<R1Z/_5JBVNKd[KHJ&CNKKY\11W)S(FT7F5WNN/#2]7Q8Q4bP6[V[P7,1aHJbV
NH)7^^g,,OfK3^J?U@1:H]J3RU+cYc<E#g3c316^]\]IMTY&g#K=-?XHVRR;?19@
gdeKd88_[(+-3@Y2[XZfWJY<8V9?IA7KQf_BRLGMU@gYN1@a8S(aMA7Z#;<LSXb:
W_\0g@Ze)DX[U0^:(5/C/?\FIb@SE9H#GDH]_A5UTI_b)\FNfg:+1;YF[2_@+QOP
Yf-//+9CY(GA&@TCAH)/JBaQd&9V8J2@)fZGM\(ON7.3IQe9.DD=CFaA<:be)08G
=M?a+N^9UWR.3+X4A8M<4I3X],e[=.JZ,_EecA46[4>e^#450V_(9IbdDMdN6(]c
P_Kc:W10>Lc&H#P=J-e]S804\8))))0D_(-@KRQ60\RNRBTDCR<XZ:.cLf/F3cV[
QgMfB#)&a+3_/F6+:f1_5?Z\)d:,IU=H1(8Ze]QVI53QEV8;ZIDP_F@2ORK?gE_-
H-<41cbXcYH-d#BP)Dc:9<[aCTO@M[O,D@]E4.GP]bWXafO7IUIe>5eU_Aag4TK.
[[bDA2-L5XBB:1TCY7WK@QJ79TWN?ONN.AG\W]22XS^\bO/4IBYb<+VJ[cI.Ne#-
J7,(>V(8\.WY<0C,3UWL2O=B1S\XH+,+4J49bK2S(G&,UV(b\XZ13GKXZ1,b>T8f
K/)K,G=/Y\&>?9;.PKC4<8D4N8fU]PUYVN>E+S.d\UA\ECY8_N[fb?2-=V36A;.d
b&QGF<Y3;-9E7)4)<[#f_.T6_fUA74#-LCS2)Ye&90KdX1GaEOLL_R\A/RUW(XMW
FVFXQ.egE6^a>I@M1&Rg_GT?I7^0\L/+3LAMF,MB61bTKE^ZLK_]6J]dJdH1>WWf
OSF5E=IcAFH&&<\dZ<>6X:W+Y#BK#5Q1^)>GDB/?Z?e\8M/OBOcPH-Ze1/I)5NBC
R?)[fMI3a7gO[1K##He0M=g->ce)XPPMR4[U,\Z?I#QIG3bTX5cX8HQBI7HbJgQ]
L@1-<Re.T:KTd<aO8TAA9\8\?4N]:9Bc7fWU)US)-)EF1W\K>)d&d@536fZKRO?(
eW\X:_?.+^EdQLR1MOP/cA?LLgVM[=7DFM2)V=FI-a6G+GD\Od[LETZGDDRVdELe
=WXfcA/VHDc5&YBMd@61LC6KPZP]MK1IF;_Gb1/HF>:+4#GL_Z<.,H69c#6D3O\M
3VAH39b(B6S;bE@@=0/9O?RdT8DP,g=YE][e.IS]R<@VP@I)f(Q9<RSW\cPZ8AZO
-.Gg/,7,eTP2dHWc\<]+IZe7g2=4DK_4\cNg(EST<]^95G@(?fAZC,ZDB)>8e:GS
B_TTee_>PC8&SJ303_fM\f3B\CLV)EUc[dL;dMM/ePcYc<G:JZ1G_ZCc]A<7;KLC
])f/MAZ.&,7@:F=.g#[F=a7dM[R9#6E.S)[>L.HC3O7[+_?4A3PG@??6/LYD4MX@
DO8;:^5d9JdZdaL,=#:e-YCgR9K,b#F@b>F.UegQDW-Id_2H@H\<])N;QRH-;?L(
TRES@U=cPM107/<SNf@c>HNF4bMHDIK]8?CMEc<3]]a;U=1SUU3KVQK#25HR0.c9
.CaH<-Qc]/a0Q,WKN5[[.9-=^^GaQVDU.4E6d:F8]dHHVaS;X[D\dd9eGA-NWa<<
a]BB71]>LBaO=JLF4Hg=1-9YeJ^DL53D33Q3@HX&aN[.IIfeBJ?\VgfV.>Y](\Kg
F9EfQX1;91\(O2R?K^>e,91<@d)A3+?/,DQ3-<IJ&EF1WBZ=1_ENXPId&=)<G[\2
U(_Ke4D&:8M-_0PdbU/>;e1Ha:AA2Y4_M4bPXAcG:^WcF9QUece6[.3\EadXd]I1
V<fE)J9@g;GTK@C5.G+gC;+1Q=\AUSJD1fXIT[<&5c5c&3V&<XKEHT^KVP01_5K.
\AR@6MY8IY.Da7OYYL4R_IOJCW:1Rg#a7G9J4.QG.[?gCOL7FC;XJ3@8IN=(a2a(
4UMfM79@A0GK?gE-L::fOb<:S,>A/0&8EL\/+<W3dO-7:)(a?^+?;a&CBK65+d&B
=[ZR-M(>1GU>0XUO[.R3DZ1G3+E9)>OXD12OgB3&QQ8[e..U8C:PUBQG\IQCR2RG
QOV-PbLg+X,-))Q7g(?)aZ]g2Y.1;&?RA0]TDKXL;B(=Q)FMXe,+PEe5.O.ZBM:P
:GG-.eT(PFF)]TQ#40SJ3\7W7;PRR9LgbP&HBNOeI;0G?K^\Y:a\;;<<]bR&I?MW
OAM,-BV\LJ=aQ\/WLG+6=CC#Mg//5bM/QOT-1/<;=aNV?d9E<K=E5OK<FQ_TQL>K
.N@+@3a:S?N)@2/+?9)?fT7>B^,a)ZcEe-J3+2>,ES12e[OgQXILX0)6B<DO.FYQ
[aZK^TGKHYd>,6J][:8@_P<&(Q.Z4Uf>Q#=-LCNcJC5T\UTVF745NQ5<dDZ;5g+(
Ma)=-6bcGHI8S=V^;NKU(>#Vcg&=f62>P+4^9I]X(]OVW+224aZIdB-LHb<&G4.R
S8d9-,aEeD.WB)MQYO=BV3Q2g)@RG8NDB+=3\SMU:_+(gE>^Y)^a.&=1YY7KFP@a
3Af<S8Z)NE(]+X+\c5(gG[I5-PR6LKPJI&Q]K#N9?@D=[Sd1B=6R>\7]&DO2GN>^
,SRCVaad4C\??>O(Ua=.<V@PH&MMc;FcX:>)4N)9\]:XU;[,O]7<,T5J]XH_2@a+
3-]ff.,J0?C-cFg^U],Wc=X4(T)8+D:JR9PIQV]]WbHagB4(ZF>X]IB]A@NNNYJ3
:U/#[VVX@:9<NWX(ED5P5GA\4W@OBJII91bP.ffC@EM7@Y=:)M].,c#THDOQ6JUF
-4e,9bHUgffVcX8>^A=.X0K>3&IO3Da:5c<TKb+,;#e6_QcdbJQ;8_<ZIFPYM0Gb
(H94)W:3RLF=&dQ099Dc-)M]QO@R6WO&^NWT448e/+NJ[V>.)DH(J<Ye9NJ]@/X;
(Sd]H]P_=&)Q5c(NAKGaWYV#LO5=6:gZRbBI.Q];C3cOCa@1MR=U;E98d&F_Ga5H
dOeg&de.:]99I-WJ.4(QYNG]GNG(@,bS0R2f&g&/^\D]a6f&QGcP-GBYD@;J5#\#
XE#^,I^3@K/@>H\88PS;N48^U\3gQEbML.5-\G=33\:7L5cS7=g\L]\;(>WR9T.e
/71Z^,\G4S?g-+<C_+VYd>(cWN32Ne8J1#>1=;:O<Y5-P>4J4LAQS6JI;W4\>BR<
PWJJ,g2]A+)ACT1M7=c<:WC,95eQ43O81=>&Y4#8e;39H4ANHF=CMCb0P&[3[N9)
dZ[PS0./N2<D<Q(EYcBP1A0ZH4+&^C?5SQVgH5OLL.g08I\\6)?Y=[?TGc+DNROV
a)N?[&ZKA&,Zfe;J9Z]F-_g,G_AbF/(aP<K)c@SOgM=g?^eV-S8OHNPX\TeV@24M
-\L0Ma^(2A]QB:e,I<@XXX1;OK<:RA+ZC^FB3@cI,ge3:N;5TOY^(5],VR<fR10F
?+(\@&Z-QCN./B\Da.XH9YD2-&TNSJ[C0<E.3Oaf@IY6EQEg?#ZS;4EER(W=28PL
BR9V)^4,4_2N:P4QM1RQS90@)f^aT)?fJKa\7R>),J52[YU=IE12]SUYgU--8:^@
31DE2\Hc.Ofe7F@H]<ef,c7JM0b[\YGVX<a\G(\CIMR3DL1d>CL@IUb[]KZ\bAKP
[H#V@=IJ?YXb[eSP9EE]8&HG8QX]50Ng-_M58__L\+We@#L96D>cMNC96KJVCX\]
?6K-L<gX?9EC,Y]fO&cP.3-Cg(64c;GL&GCGUK0,(f_a^KfbXF>A[X/gZVK0Dc^7
Sa^RAScO?Cba4ed6SNI]ec,7\9>SO?)EX[N/?MI5g?aCPdK6GA\fb&@U(db@Y_AL
XbY4@YTJNOU3.@Yf]UP8I-K1HJb>?HHgZEW.(LFCS.W4Z)+QME0K><Jc.cHP7H&\
]6<]gA<,A_6&4?K8(79D:;+)7e?1FH&)A1eP9<bO#KR>(4X@Y#g[c@@\\;[ILVN[
./,)SS,(ZHe0P^^BEJ>2N&B++WKOB2JSN66UJ@FS/g&Q>534OKJ#/\WQ<>a&1GUD
+94>2LV1RL.Df;HR-)Je\cDYVXJ3R_O\N=HY8bKAHTJV9CgV_T))+6dFQ\B,8757
Kc0<f?OO5JGV1K=L52bLaSd&,41]=;+7DO_QaUM55SB<,T^)#a#3fY79DDMA[0G-
4<UH3H/A9(Q,F-N+H+VMSW\A@C0?T1]^0Z889JKJb\=^7(b:\IC]M(10/V[X95-\
b:,H=SX;f[H+34(+3Fd5E,&H+Ud#@d>Q01=D#Z&BTWf;C(8V4YEMA&_Eb3G.;;>8
2=4f(Ufc&aCG,/dVLCTP-\USQO]3EM_I+\1G.YGY)R9#\U9;)CbdAV8RVII9#;fE
;?Ydd@=;QD#_;;YN]/A0CMTU\=bN^&)[D(-6HB;@g,K8aH+Fa(9;aRBR6GJA:.45
8W)FT#4JGGMg1FAPTgA3Y9S41H=W2L_WT035,T@^JC-IC+^6.R&IJ5II158:A6g-
G^=RCNA7e.HHM#IZf.[QH;W&NEe.I_a)2YFO/XP+Z^+LO_V#5I:/\_\VG^]W5J,I
=N/?WW4<>/(@Y/,X)(@8C/,;3(^#6/U=M@aX]9?\-fUXI8K&SYRVIOc<fe)-BZ)@
(BGA@6KU=dR,:?R81BZL8)g.4WOX\&=2W9B<-FUP/1IL06AS6KYZ016M=9D@HfB8
50706@T)SX52IBA>W_H^eN;F,I[[77gO<cV[2?^8=V6P&M35^Nd\Q0N7e)^(DWD5
<K&)92FcM=?/V>.cg98Y6#/P?@ZGE&IRF-&:V>.c&YR)3ZbK4BH[WJZO_c&GR+RQ
NcBCU5Z&CQ?]<H5M[.OBYP8,8R8VYT[-AU><4@#7B],4^1ZAZ,7_/,=@LDETG&d^
4ME6RV-2a,VDCHbMTgW>_VSa<J)16U=Z=3>#:3;RW/3OUF0GF1?9cTB-=^Z]C&OX
0##0VI^@.J8C\<&dP;DY&7G/R3V)FELH-.5W1I2)3_VE,^CV>KY49+6a.WE)RcU,
BaW2I^EUb-Q[M6<<BKKH2\HOU,]T=gHBT@0XF\>64^N:KG&5EZN>]fE52K\@BVf_
FD&6beD]X.[F&&9BF_RV>W7+:]J-,9=eH(I):IM-f@4^B\L#&\bF6^7)(73CeD3[
Z7VG=fD>6XQ>N;@4;8=9RV2-RLN&2UVKK&^,S07(.P_^D$
`endprotected


`endif // GUARD_SVT_MEM_BACKDOOR_BASE_SV
