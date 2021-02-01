//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_BACKDOOR_SV
 `define GUARD_SVT_MEM_BACKDOOR_SV


`ifndef SVT_MEM_DPI_EXCLUDE
  // Needed to select 2state or 4 state server instances
  `define SVT_MEM_BD_SVR_DO_E(R)  mem_core.get_is_4state()?mem_core.svr_4state.R:mem_core.svr_2state.R
  `define SVT_MEM_BD_SVR_DO_S(R)  if (mem_core.get_is_4state()) mem_core.svr_4state.R; else mem_core.svr_2state.R
  `define SVT_MEM_BD_SVR_DO_LR(L,R) if (mem_core.get_is_4state()) L=mem_core.svr_4state.R; else L=mem_core.svr_2state.R
 `endif


// =============================================================================
/**
 * This class provides a backdoor and iterator interface to a memory core. Multiple
 * instances of this interface may exist on the same memory core.
 */
class svt_mem_backdoor extends svt_mem_backdoor_base;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // Store name of this class
  string name;

  /**
   * Pre-defined attribute indicating an address has been written or initialized.
   * Provided for backwards compatibility, but clients should actually use the
   * SVT specified attribute constants.
   *
   * Note that this uses the SVT_MEM_ATTRIBUTE_INIT constant, although the backdoor
   * code actually assumes that it represents all occupied locations, whether they
   * have been initialized or written to.
   */
  static const svt_mem_attr_t WRITTEN = `SVT_MEM_ATTRIBUTE_INIT;

  /**
   * Predefined attribute indicating an address was last accessed by a READ operation.
   */
  static const svt_mem_attr_t LAST_RD = `SVT_MEM_ATTRIBUTE_LAST_RD;

  /**
   * Predefined attribute indicating an address was last accessed by a WRITE operation.
   * Provided for backwards compatibility, but clients should actually use the
   * SVT specified attribute constants.
   */
  static const svt_mem_attr_t LAST_WR = `SVT_MEM_ATTRIBUTE_LAST_WR;   

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */

  //----------------------------------------------------------------------------  
  /** Memory core reference to svt_mem_core instance */
  protected svt_mem_core mem_core;
   
  //----------------------------------------------------------------------------  
  /** A memory address */
  protected svt_mem_addr_t iterator;

`ifdef SVT_MEM_DPI_EXCLUDE
  //----------------------------------------------------------------------------  
  /** Current attribute that the iterator is associated with */
  protected svt_mem_attr_t attr;
`endif
   
/** @endcond */

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************
   
`ifndef SVT_MEM_BACKDOOR_DISABLE_FACTORY

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param name (optional) Used to identify the backdoor in any reported messages.
   * @param mem_core (required) The specific mem_core that this backdoor points to.
   * @param log||reporter (optional but recommended) Used to report messages.
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function new(string name = "", svt_mem_core mem_core = null, `SVT_XVM(report_object) reporter = null);
`else
  extern function new(string name = "", svt_mem_core mem_core = null, vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef SVT_VMM_TECHNOLOGY
  `svt_data_member_begin(svt_mem_backdoor)
  `svt_data_member_end(svt_mem_backdoor)
`endif

`else

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param mem_core The specific mem_core that this backdoor points to.
   * 
   * @param reporter Message reporter instance
   */
  extern function new(svt_mem_core mem_core, `SVT_XVM(report_object) reporter);
`else
  /**
   * CONSTRUCTOR: Create a new svt_mem_backdoor instance
   * 
   * @param mem_core The specific mem_core that this backdoor points to.
   * 
   * @param log Message reporter instance
   */
  extern function new(svt_mem_core mem_core, vmm_log log);
`endif

`endif
  //---------------------------------------------------------------------------
  /** Returns the configured data width of the memcore */ 
  extern virtual function int get_data_width();

  //---------------------------------------------------------------------------
  /** Returns the configured address width of the memcore */
  extern virtual function int get_addr_width();

  //---------------------------------------------------------------------------
  /**
   * Creates a new user-defined attribute that can be attanched to any address.
   * Different user-defined attributes can be bitwise-OR's to operate on
   * multiple attributes at the same time.
   * 
   * The return value is the attribute mask for the new attribute.
   **/
  extern function svt_mem_attr_t new_attribute();

  //---------------------------------------------------------------------------
  /**
   * Release a presviously-created user-defined attribute. The released
   * attibute may be reused by a new subsequently created user-defined
   * attibute.
   * 
   * @param free_attr_mask attributes to be freed.
   */
  extern function bit free_attribute(svt_mem_attr_t free_attr_mask);

  // ---------------------------------------------------------------------------
  /** Create a write protect to a memory range
   * 
   *  @param addr_lo low addr address
   *  @param addr_hi high addr address
   */
  extern function void protect(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  // ---------------------------------------------------------------------------
  /** Release write protect to a memory range
   * 
   *  @param addr_lo low addr address
   *  @param addr_hi high addr address
   */
  extern function void unprotect(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi);

  //---------------------------------------------------------------------------
  /** 
   * Set the output argument to the value found a the specified address
   * Returns TRUE if a value was found. Returns FALSE otherwise. By default. the
   * attributes are not modified but if specified, attributes may be set or cleared.
   * 
   * @param addr address on which data to be read
   * @param data ouput data on specified address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit peek_base(svt_mem_addr_t addr, output svt_mem_data_t data, input int modes = 0);  

  //---------------------------------------------------------------------------
  /**
   * Write the specified value at the specified address. By default, the
   * attributes are not modified but if specified, attributes may be set or 
   * cleared.
   * 
   * @param addr address on which data to be written
   * @param data data to be written to the specific address.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return '1' if the value was written, otherwise '0'.
   */
  extern virtual function bit poke_base(svt_mem_addr_t addr, svt_mem_data_t data, int modes = 0);  

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
  extern virtual function svt_mem_attr_t peek_attributes(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Set the attributes for the addresses in the indicated address range. Does an
   * 'AND' or an 'OR' of the attributes within the range, based on the 'modes'
   * setting. The default setting results in an 'AND' of the attributes.
   *
   * Special care must be taken when setting the 'access' attributes for a
   * memory location as these attributes govern how the memory package interacts
   * with the location.
   * An access value of SVT_MEM_ATTRIBUTE_UNINIT, for example, indicates the location
   * is not occupied. This will result in the failure of subsequent peek,
   * peek_attribute, and poke_attribute operations of that location.
   *
   * Changing the access value between the different 'occupied' settings will not
   * not result in failures with subsequent peek or poke operations. But it could
   * impact the outcome of subsequent access checks which rely on these settings
   * to discern the current state of the memory locations. The 'occupied' settings
   * are defined by:
   *   - SVT_MEM_ATTRIBUTE_LAST_WR - Last access was a 'write' operation.
   *   - SVT_MEM_ATTRIBUTE_INIT - Last access was a 'poke' or 'initialize' operation.
   *   - SVT_MEM_ATTRIBUTE_LAST_RD - Last access was a 'read' operation.
   *   .
   *
   * @param attr attribute to be set
   * @param addr_lo Starting address.
   * @param addr_hi Ending address.
   * @param modes Optional attribute modes, represented by individual constants. Supported values:
   *   - SVT_MEM_ATTRIBUTE_OR - Specify to do an 'OR' of the attributes within the range. 
   *   .
   */
  extern virtual function void poke_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Set the specified attributes for the specified address
   * 
   * @param attr attribute to be set
   * @param addr address at which the attribute is updated
   */
  extern virtual function void set_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Return TRUE if the specified address exists and all of the specified
   * attributes are set for the specified address.
   * 
   * @param attr attribute to test for
   * @param addr address to test at
   */
  extern virtual function bit are_set(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Clear the specified attributes for the specified address
   *
   *  @param attr attribute mask which determines which attributes to clear
   *  @param addr address to modify the attribute for
   */
  extern virtual function bit clear_attributes(svt_mem_attr_t attr, svt_mem_addr_t addr);

  //---------------------------------------------------------------------------
  /**
   * Free the data associated with the specified address range, as if it had never
   * been written. If addr_lo == 0 and addr_hi == -1 then this frees all of the
   * data in the memory.
   * 
   * @param addr_lo Low address
   * @param addr_hi High address
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   *
   * @return Bit indicating the success (1) or failure (0) of the free operation.
   */
  extern virtual function bit free_base(svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, int modes = 0);

  //---------------------------------------------------------------------------
  /** Free all data in the memory. */
  extern virtual function void free_all();   
   
  //---------------------------------------------------------------------------
  /**
   * Reset the iterator to the first address with all the specified(bitwise-OR'd)
   * attributes set. Default is SVT_MEM_ATTRIBUTE_INIT, which is interpreted to
   * represent all occupied locations, whether they have been initialized or
   * written to.
   */
  extern virtual function bit reset(svt_mem_attr_t attr = `SVT_MEM_ATTRIBUTE_INIT);

  //---------------------------------------------------------------------------
  /** Make a copy of this class, including the state of the iterator */
`ifdef SVT_VMM_TECHNOLOGY
  extern virtual function svt_mem_backdoor clone();
`else
  extern virtual function `SVT_DATA_BASE_OBJECT_TYPE clone();
`endif

  //---------------------------------------------------------------------------
  /**
   * Copy the state of the specified iterator to this iterator. The specified
   * iterator must refer to the same memory core.
   * 
   * @param rhs svt_mem_backdoor object to be copied.
   */
  extern virtual function void copy(svt_mem_backdoor rhs);  

  //---------------------------------------------------------------------------
  /**
   * Return the value in the memory location corresponding to the current
   * location of the iterator.
   */
  extern virtual function svt_mem_data_t get_data();  

  //---------------------------------------------------------------------------
  /**
   * Return the address of the memory location corresponding to the current
   * location of the iterator.
   */
  extern virtual function svt_mem_addr_t get_addr();  

  //---------------------------------------------------------------------------
  /**
   * Return the bitwise-OR of all attributes set for the memory location
   * corresponding to the current location of the iterator
   */
  extern virtual function svt_mem_attr_t get_attributes();  

  //---------------------------------------------------------------------------
  /**
   * Move the iterator to the next memory location. The order in which
   * memory location are visited is not specified.
   */
  extern virtual function bit next();  

`ifndef SVT_MEM_DPI_EXCLUDE
  //---------------------------------------------------------------------------
  /** Retrieve the attribute mask for the lock attribute */
  extern virtual function int get_access_lock_attr();

  //---------------------------------------------------------------------------
  /** Retrieve the attribute mask for the write protect attribute */
  extern virtual function int get_write_protect_attr();
`endif

  //---------------------------------------------------------------------------
  /**
   * Sets the error checking enables which determine whether particular types of
   * errors or warnings will be checked by the C-based memserver application. The
   * check_enables mask uses the same bits as the status values.
   * 
   * The following macros can be supplied as a bitwise-OR:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_RD_RD_NO_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_LOSS</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_SAME</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_RD_B4_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_PROT</li>
   *  <li>`SVT_MEM_SA_CHECK_ADR_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_DATA_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_LOCKED</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_ERROR</li>
   *  <li>`SVT_MEM_SA_CHECK_PARTIAL_RD</li>
   * </ul>
   * 
   * Note however that not all status values represent error checks that can be
   * disabled. Two pre-defined check enable defines exist:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_STD</li>
   *  <ul>
   *   <li>includes RD_B4_WR, PARTIAL_RD, ADR_ERR, DATA_ERR</li>
   *  </ul>
   *  <li>`SVT_MEM_SA_CHECK_ALL</li>
   *  <ul>
   *   <li>includes all checks listed above</li>
   *  </ul>
   * </ul>
   *
   * @param enables Error check enable mask
   */
  extern virtual function void set_checks(int unsigned enables);

  //---------------------------------------------------------------------------
  /** Retrieves the check mask which determines which checks the memserver performs 
   *
   * Retrieves the check mask which determines which checks the C-based memserver
   * application performs.  The return value is a bitwise-OR that determines which
   * checks are enabled.
   * 
   * The following macros can be used to test whether specific checks are enabled:
   * <ul>
   *  <li>`SVT_MEM_SA_CHECK_RD_RD_NO_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_LOSS</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_SAME</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_RD_B4_WR</li>
   *  <li>`SVT_MEM_SA_CHECK_WR_PROT</li>
   *  <li>`SVT_MEM_SA_CHECK_ADR_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_DATA_ERR</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_LOCKED</li>
   *  <li>`SVT_MEM_SA_CHECK_ACCESS_ERROR</li>
   *  <li>`SVT_MEM_SA_CHECK_PARTIAL_RD</li>
   * </ul>
   */
  extern virtual function int unsigned get_checks();

  //---------------------------------------------------------------------------
  /**
  * Initialize the specified address range in the memory with the specified
   * pattern. Supported patterns are: constant value, incrementing values,
   * decrementing values, walk left, walk right. For user-defined patterns, the
   * backdoor should be used.
   *
   * @param pattern initialization pattern.
   * @param base_data Starting data value used with each pattern
   * @param start_addr start address of the region to be initialized.
   * @param end_addr end address of the region to be initilized.
   * @param modes Optional access modes, represented by individual constants.  No
   *   predefined values supported.
   */
  extern virtual function void initialize_base(init_pattern_type_enum pattern=INIT_CONST, svt_mem_data_t base_data = 0, svt_mem_addr_t start_addr=0, svt_mem_addr_t end_addr=-1, int modes = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to provide a bit vector identifying which of the common memory
   * operations (i.e., currently peek, poke, load, and dump) are supported.
   *
   * This class supports all of the common memory operations, so this method
   * returns a value which is an 'OR' of the following:
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
  extern virtual function int get_supported_features();
  
  //---------------------------------------------------------------------------
  /**
   * Internal method for loading memory locations with the contents of the specified
   * file.
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
  extern virtual function void load_base(string filename, svt_mem_address_mapper mapper = null, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Internal method for saving memory contents within the indicated 'addr_lo' to
   * 'addr_hi' address range into the specified 'file' using the format identified
   * by 'filetype', where the only supported values are "MIF" and "MEMH".
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
  extern virtual function void dump_base(
                    string filename, string filetype, svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi,
                    svt_mem_address_mapper mapper = null, int modes = 0);

  //---------------------------------------------------------------------------
  /**
   * Internal method for comparing the content of the memory in the specifed
   * address range (entire memory by default) with the data found in the specifed file,
   * using the relevant policy based on the filename.
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
  extern virtual function int compare_base(
                    string filename, compare_type_enum compare_type, int max_errors,
                    svt_mem_addr_t addr_lo, svt_mem_addr_t addr_hi, svt_mem_address_mapper mapper = null); 

endclass: svt_mem_backdoor

//svt_vcs_lic_vip_protect
`protected
a>.+]IaM3VPfPgfEVIZ12^;>3gTHR;e)CNWFXg_bNQ;L.2]fW\AC7(<NO.^@)8SS
a9)&6DGV^E8I\@XUNf(@CJY5W(F\>:X:1W<07.\/,K3cT.3e6F7d]H)Z]Y?Y6+HE
.-MCFEeTBL1[ZUI9KBA(7KWc^]#.(M??^Jd2/b)A5O9Zc(;.S84AF#XG0QA1I5<]
##7^,a5>N=3MgYHNPV@b\dU741W+[C@U9Cc;AaJM@,;d?WUeT+Q4:S(&875F&F=.
NYd,DCS>6;.3g\/B/+&#T]IMcPSZ)_FQ&MMgT>PUMAWCAbSb,ZB+.IEc=UV8A)FH
P<IecK34(<3A(SQSEDX[B,@_#KYUCIUIBCM(Z]_c1=-F3+V]b09_<CPMVU-e3]fb
^<O4F6@>R4@1O-L.=47#Q#>Q9LKdW62c,EAgW6^R4U@VCdE6>#T6H@[?TR)(Q_VV
gAJ_4FVX4#BM>NUI<5[;S2G\EOf+B\B<b/d^F_W+YTQ&e.,P09^&I]7;HXK[YBV7
N]1Lf5GdTSL[Q?bGc8;^F8_5AY<7X#ORYUKbK6=7EHYR,@6[caQHG6N;/OMPM-5a
;Lg9G[\3eA^]3+>GFQX1H+JHd5UXT&C40J4<M0LG_bad?YJ0MOa/c/<]-0953N.d
eV,[a4@QF@c=-0+OI/G9NVQ#SdeFIgX>6C5G6AX&DB[eA+T9>+Q0d5O\UVE.[F55
O<,_00?[QUCQ^C;&+;&AXO=QOB=bfJAFaCDC1;26Y;_6^.)(CDNJ5_&Bb1dG95YI
cNJ?:XN++8#DL7,>b^a&>HQVZ<b31&O9ZLE@L[9aB>GPJ=#.\S8272+2#Z^;]]8B
1)=D/>fecMa0>/)_f&K/:JC8-:;Yd=H(eZP@MUIL.UJcXXQ3JL(<9)R\?(g+HR?g
4\KGE1a]Y/Y6YM&_GAdEg]cHB>INg#&Ze)HC.OYNU\+1CA&93:+?RKO&6f7Y#SaX
:gY3JZG@ed,BZRHP=1L1VHD5EfC[WCQCA7fIeHDZQ(bVZ9ac-//@0Ef];TcPBA._
Y-eN.QbA46^S>Zg8E428@H#[gLFAA:^?K_Z:N8/Z-B,KXW./:MF([:S7V.^(D,:R
R3=MM0[2ESC@1?cbaLS-L/:8C<16;DTM#eL/6(>9e9IV6F^SAcb/:XGSa.ZM=X1\
WI18?;[<LH1]4Nb^L1?T?5<;WFS4AQOM6]2[ITCOJB5XT^9baYS:Oa+D?5NH+S=,
e0LYEP2#4YVECe1,&,KKJ\85;a0.?ZeW+<^CHc].PC_f/BVF\\/L_EM.\(LPM8gZ
QS1RVeZgTZ:@EQ53?T\OFLK(Kcf[(2.)2XPc\gN0WX[?Q,fCWMR\0;P3>GODF9^^
Q0VBH4IJ8PIH-#H9[49F[F,41UD-=8d&1,Zc_BI78V6A]cBUB35(4O]&&B5&#P5.
IG(.YW791>DK.M(^J5d^N7F5C>c5@a\:CbGe\JKQ)a:LAU:F#_TH[FS(XJ-^X;)/
L?ZVg<2<[ZW_6=8?MfID:Ad(-@LPUI#(4E-&4WPNV=fKK&]=A@854L9(_LKB6I&\
L?)bLD)5\bFgf[YYRV28^L&[<(_Lf&[+(fT\[+fQ<D;CD+c_Id6<;9fXY/CJX).Z
aOQ&=A7330g/?/b=D#a?>@K9_I+O4IfP?f+U9.N[8#..^CG3;H,_LI>>fb.QDGCA
#GcX>49Xd9KgNB/0VE/./N5:I-.UD^G>]]>?W+H#/E2C\OR.Wf.^@]Q&CDO5Hb_>
^8Q</JY@V\ace\MX;]6dX8F<GB][>S(9@=,A:R2SJ2Q4\^#4E6(4C\f0R0[,L]c7
7C93LbL-PLZJ4d^5\g6?c6H1Ng:^ALO7.bEb&V[J))a9>8]>UaE1;:F;[c9@U&_P
O7g[5<\CAAB\6c?L7UMXX^Y\79Pa)B/I2J6_\E8G]a3^Y-?_4>>FNS:\\S7a4+A6
HZ0E/]?BEQG)0gC<-^=EWfgH31Afe2@8KPB-H.8Z8Q-<?@6ZPA6=L4W7#S\cb@(G
5B/c]Rd<C#J&O#Q-d[:-8);Z]#5XGDGH7Y&=W-=Y/eb9&,fL8D7c]RNYgGAf3=L>
bUOg=WB0QLe/Kf\<V=?X<Z?Z75aIGPV@/5F^RMU/07B0EDc@5Q,YI:FC98+e=(9:
.K9C-[)CBA02(#aKF,D/>O-=<<:U7FV8+d&a[X.aY.6BL[cQ8/JO9D:M[BM@7)FK
JTQY.UU^/&V(]1a#_TA?4>@Re_HWe.D:=.6;MELW^=92E;?FTYK>(2GB7_S^g3VC
^NAZ)eGcgaI7GDbE>GQFa2g\Y(E-01Rb,MMSKB(GRP7=KHYI->-bUT2b^;]GL?56
RaRAH)=96W^)HF9a=;N,f+M[<V?>=D[e\Zd5O)b74_c^QUQCJ3G>Z]K:+]]Wa43g
^L]c_f)SKGMX8+BTV/[P[<.dT=F[R,+,Za-J+J93:R3_P\aCD(L::+-3CIbLHaS#
06[6EHU5W]9U@S:4(f-HK-/I-[.E6;^;M=1C5\^+\?NfNe+SJ;[+^b8W<gbCe))^
VKRgJV,JFHK4MD6EO]^c7N;093aPUW.N@SK8.aX2DFe^gFI,5ceJHf>JdJFWB@De
@]0cZ>@#B;&+OG2>^ePI4,g=LP:8+c[E7+5dFA\H;VS2U5_(WeQf06\Wc^-9\R+<
+R_65//=./46/Lc4ZH+AFSCBX\=E8YX3K2WQ8\ZK]@#-(.N,7Mb7Dc&IgFaR)eDb
(&/G\Fa4Z(POFK[bU>Be.<V84NEGKY4#EVSB27fY^fUACZ.C&SQ)-<?&>c&9Ea)P
6OK)aK5F<8/;J^1EINUEO1>NUD+XbH^(gR]_3&^e\<1Z()]C+18R-LGF2M^fgG<^
[cKFPBTQ&L-I3]:&D<X)a(YScX>..-GKY(U0a6f\5]QPH#M]4+Y9>Tcaa5O4T[W,
:Jg#7ab]gV881cR/+;b:2B_#;?eXBdR<Zf@Rd573ce<@>SOc1T)G85S1B<1#6e3K
1RDY&HB8:eY)SO?KG/;Bc[UF<6?^CY0eJa/<]C@3>OdL?Ed,ELM@VHMFa#FRGHF^
:?3N4O36AZEE/d;>PTE;5Hb0T0R0_LIN/,Q?PY+2FYA/YUV0;,_Q?Ff6_KB.&<QZ
SF(PX\RPFJVF^:c.+E)XH<PSYSg/WBe6;5UU9Yb<<X)(L)#/59.O1(&=Bb,8[(71
-=9:1>c5CSeYI\?1F<Y&=OW+Y5<c-Yd;6QLbD]K8]3CP5&+d,)8O=?aS=.e6cOA-
V_LeN,H&@A;OUX]@0EMAS/&cc/60),C=6^YO&1<NE8f-<.a;Z7-/9)GMA=]L2>KA
1UP=2)(Ne_Gd(0^LR)E[cIPEC[Z810ecEL+2Yb<8B15>^KRSX/bLfO>gJK5(6TTC
F?M#YO7MYBCK428KC[@]P/.>T]8d>_.&UaT-<EdSb&?=>T0(c26F1BeWEBYE&0HI
J>P[dLCA2?-[BF[RKQJ4CVbW[:N6@fMd]7IBBDQ^+QH5BfN=XI#]Q,M:-cD/S+A+
>5b@3^=?0BA3g2A:Q5b2ZfI;d@,MZUZ+O(XIBO]^8AG-GFO3bA]d/OM[Fd3?^NP4
dBA,84E:3@<<J6=WVU/9]Z8]F,\=C>I)Y6?H98e/E=bLg^\1_[>/-\gI4&:-/YE,
1-:\FGG):X_#;Na,Z93,dS&^@3@:5<;bJPNIK;,4<G;.RJ^T@,BK39c<c<Q)cGG,
8cR_;&KM/0HS-49d&L9I8ZEN]7+ge+\,RSf/c&DT>GB6-589G4N-[cd[_F,X5N>I
ZNR-,]U?[H7HE2_RL51T>_:_8dc4f9^9_V\;a@DMXGHHWf_]8RPC9I=cd:O0O=8@
Y?:#aB<4;d[Y-:5ZJ\:+IX=ce:5^FOA/.b)J\H.<g9H0I^T&^.d2P>S[A=7Pg95H
9NWc;4DL6cW;gUT3;Ybf&HBP.J@cCRB5TUR0O(K@BC0_>D1\8.>9;11E34X?.(8I
a1#GE@YJ1c4@1WFf+6&O7C&7@30e1F]UHHTDJ<YT@Q#\5O(D7UZ/]IL[Q[PbdeR&
U?RQ6F_PYV)9BCfOTZN;/#IdFeeTHH:X?0@c0Oe,\A,CYIWbH5(_M;\6HAaV]HZ_
13==0DP>0M48O[Tb\1S]V;;TFI1Ub9.WT,baeaL,IC7bBHQSY5R#gf)W]@g[beKH
S>4_]6(=C=;4aXfBJ2^7d/g(VXcBMU[IG(TS-:&8K7aT(KYgU@fGdBBQ\?#IWH+]
c9D@I0/)7aD[9EIYPW@Z9N,#\Y@1K:&/79YRN9#H8)JWYO;OD294J/fLKII5Q=VE
7>3Y_CF\)],\9Z-gD;GEE[9^ZDN>W@Y:?5aYA9[>X>[Ia]W<1#EEWJ15c<8Tc+M7
GY#B<N;5bNFO@a#3>TA2/:K/&ddMARD,4b;?(1^SB@M9O[[M5OYg-3>[f?8Db#E-
;&+R.F<C<BP)]#4]CIe8aNT10a>@MR5A\T13K,P_S6#\[=R)??_,8&HJW:-5@AWW
VTP@>bY716C/?AaI6de3Q[QU80S^>4UW/F/<B;A2=Z5@g<-LTQ2I>gdN@<_/\6O6
2eJfA=DfVBE@F0+E,bTGTedCaN6JYXEENZa/=_KRJbF:I0K1HK3(]&OB4CDaFE6V
M8Nd/OH154Kc1-2:2D&:YIQ-OfM0..\S>0A]g/60IReaTDd5](L;1[e@[;PXZ#dI
Cbf()E9FW3>V[,9JS8[<67Z0=J]gW/g0c2f0JOK\TLA9,C;a\Xe6(0gI6HFfS]]K
ON6_HEBMA?.a:HSRCW+Z@=E<Pf-,fe19(S9:e1fL.>U<S=HC<cT:WM9[Z3.deadF
V.G;VD)JK52-Y)T,>821E^XS:_1NJ[FMS4MKLEVg8Oc^b:71@P)D?ZGK+Z7ca;OG
7cK8b]<#\\00W(:4bTDC>W;a.0#703,DIVS7L-@H0<-DP0dZ.FNXX999D]O:=.#9
#+PR0TcLIL[LV/NPTe=JcE9Kc/Z5.6OA3]QQL6g]WR>7(K6-#CS:IIK0ZQ8\ZW=4
?51[ILD38eGSdBH_IfUAUfJHT1;M\<#Wf+#aM=AJ0eS\.ZD:X/(@/A@C4DU4_XH_
&&FbUc#eLMI2<a=_1:>M&,[4MS)2aKZE:WWQB0IUE8LFFLAgdg1@Xa#A@\(HL,U5
ZHFT>^SQ:&1&/:fTG;]8c@Q:G7):a5T[BO;DCTK4==Z6aVf,=PNUgU;(J;<QWT4?
9?Fc3ZMOJ9L:1IX1<-8\#E2FP^G@:\D)0VNd<G)TaHR[&fA4C+X,J888,^aEeFMP
0Z;[Jg:g#&7M^/d@gIK+f.RDS-&BA7^B&-7,08,/HG5g;W0S_.O.>ae&UEVK,[O9
FG(XE?#M<4XT?@N]I-HY6<3,?QfS&0VH3CDfGKK@,A^P(P-9>/f/O#??HCCg7a:M
GY.P&GGV1_]G@7UMCNGg,7PV8\gT]8)g9D]K:./J8OCb?f4V4RUPLO6;:U<fNI))
_RfdB2WAE\RN5GCAV>+0]-T0]?gMU<L)AIeYQD9CBeS^@2V^PBb1(B9+SH4@MOd(
7C2-:&7]O3VCZcT2ZOSG/#IW?-64-#;PH83KV][1NO1NI^K,1ZbR,MR^Y5VbTLGT
eR=C9WK^_FDXFS9;d1cYU]5SFR]\L7eS^4R+T]5<>BA\6dI:@X;ZYRPWLcRa4OW3
LTAJ4Tf3[CDE[B4fOUfFY-0Y@(BGX6F?BRXaXLAY35#\XXd<)<51J+-X&DN42)\8
4D7S3)#PggM>GOHMS;R4<TGd4\cPPUDNc-Q8@EUeX&NgF1H]+Rd7)efHF@[CE1N5
11)7d-?&+-6.-c<ECg>PL?+dROSUfC;[P,?OWCd@D0Q\5]P_=d7(C6B<#c3&Zc@<
]^>CRKc;BIC0]S9Be\@I)?\CBaFB09Z(PWQ@fQKN1ONC_DEc^;Q=J[NCM>(BM_KI
eHG2:Q11PC8Z4=L(UO#R)-]FWYM:AgbMdY\V6cUQb,g-R3X7A-8a2,5@,dQCKBNZ
]_?LV(NaT+B[TO+)J8_ZM17)ZgOS^#<OY29Q:IQ_J99-g&@L>WI[&:WX>M+CbV(.
--_M9N)OR(N(W1J:E]Z9K:-f]d?_U5QJ632N#5PCD1SUa6Y;ZR20U[EH3^7#87+R
XMF8)#P]U8N>FCVg.P7?E4Uc1aGNHXQP)XKAf=eW_4-c2V4+GbZDNBP/+Y4XFd8_
5>>gR:>dLf909@Ua#gH\ZPMW[N8A26Sd6-21^Sc/+7USO\H+dfWY+ca;CKSa5O5a
8PYE+-.OE_B85Yd1_#b65:0&,WJP#:@>0GSB49.^MN^?9R64^<]3[#EN724QJ0cc
QUK]\4cTE3Sad<,?DKb95#7M_9R=1UO.B+#+LQ5F>5378I7^:\_J/9QDF9g5TCHG
O<D7>Qe_TI@J>OUAgX45B.gG9-5:9FZ/1@Ra99Z<51.gd.57Re25W/U>,bLJfJ&7
8C;BK#R3RC63/36PO-;,RMGaE)E:&ffFOSUF1,3:D-:&I^AcW2F[Q7a&YbFBD<2C
G\ZGb-=0T(;(XM)C6fLH?#F&:Y#7:_Z&N\(F0U&O8)B,U#Cg\OF-B7235b0XNQG_
K#XF^)86T,0L>O:(Pd\c,fS94^OLU:e&(YBT(.6/5Ya0faNg4B^fAc6_]ZU94RL1
Z7XJJgEF^_aEW3Q((FN5GDBC[ZP1d]<c(;>)_A_g?#64S2]/PI#7J[GIF?C4-YMB
BRfg-Ub;E4R>R-GTXg<]eV;>@L1Vg2=@YR7,;-0?69JF4cg-#25BSO#L5N+0D.5I
^<?2f97Cd?S&:cF^L/,bY@98:DFAL=78@.T23g>#G13D0^Q]8fcH]4:LBAc]5,gN
Ib_SG3M;/NX7I82T-EaS[7+6AHd+(CaOX/K?)<Ae85FWc=K9RH\IdGZT.,BZV)bB
<O.T=6ULR.S0@.WVUAc#:6:Z4B7C@F2YSL^5?)EJ:\2.A#d+P8>5;9(V3a-.DN9+
,G]C7L0;ILQ)]TW>+&U].JbN_R@M)C^M:V^DW,/V=:a?c:YdU5\C54/UC6EO66R\
W#U:bDLfa)?RE3XKHCIOcQ5,U69JO.+[4++E71d93CRc1)M+GUfY]-<M1_RH:eX<
g;Y5_=HAfIT&01#3I@:Mf.ODIGaC&_L82KcHa.TY=FCe.HX-VI>KG-:._-M4X82[
-G=:HLbO8CaGNX:B?U)H[)QQN:>?XZKDgaEU<_ZadZQLJ(0GJWdIK@=&8>T1(GMN
OJeJFO]VWPW-Na@>\40SV&^Z6HLe?3XN5]N.UOW3-c)C^ag.3P?]Vc>DFPffg<+2
&g>5b0,B\Q(H.Z+YaT6(,H^#=Z?EFK;^1KUg6.Mg6D[+_Vg9+>&8W4E=c54bR7;&
ZYT76/_01&I0BR?#<C#<?ZINWYR/Q/eJHGX9V8SORA8ZY+KLYe/9=F]L0R/de6fC
dAQQfN8#UE@S,f[5[1>KbeaS4Le?,YOC7?LLZS=d?3VaPT3^(.fEgdS3L66&e:X\
<De5P@.Y#OGXJ5^LY&SS-f3>UE=NOI1O+cCD2H1,=>HN4GT,LDf2B&1?U=g5&f:Y
GL67E0G)f>FN0G+f4M_]F/FZG.]CTWUB[PA+[1[P^c+6@Z^=UFGUV6^-AL9Aee;?
>TU(b(f)IE\0H#ELd?C7f:BbVJP\)W/a0S4g6<:55;.P+ZO^EeM.XX8A,3M1d5Cg
7UIaP3AAe_UPM=_FNR?^XCYGV4.=/bJ=LB:gcXMF=\Md_c?T&&H6&Z@P]eI3,R@D
QFH8KFV?:(4T7WO<7.5KQb_H1S1F8OZ--c_eU[8YP>J?R9=Pc4PT@>82+8-/1<BU
PV328^7_fLNeN0FKeX14X8:-A?T..9F<8+5PB;^VA/CHJ<U]N?EeEf:)N&@fP2gH
96Z[SO[;)M]g8=BB-E=#b7.A?\YZg^POHF3G#>/TH[A;THO6TRV6I7(TYP8NX#5R
(DB)ZZTJ5Qf1<Y7]F90IUM8P7TBV(@NSPM[O#3bfF@]0SNNCdDHVLYBOC@ZV[ca>
G5&@H(^b;#69b\,[P7=P-O@XgJI9NL:HfG2_6T],bae#3I40<8?QK+e3PS#Q^O63
cK^&XH&\R:X)H,T[4G?2R0]Y]1]Lea[=W@ffKZEBRS:9?U052\9ZTKL=K41)K2NE
5([YFRf(N_ZRIbS:\1,S]0a6,SREP\IQJL]F9>OQd6Od2FVa6]\A@I0QKAd)=C;d
^M+c1Q8:=;CId=0?[e_BDQT671bJ7@]&MXf_XV6S#TT,)gH&O#GcRP:JM;825H-_
1g48_55.:53J:Aa8FNCG=[.BBb]:2UfdE@\,A([,+e2fa=,cO/e\>7WM:f(X/A;e
f_aY)XOa,.[+;X;I.J[RRJ(6C>@^+\DU,A:#T:+0RZ25Ia]98O]d_2H7.:M[f6,3
eA3S]d.(fS^)BB\A_#:>;MFL@S2HLH5H9&2,^]GO4U-8)M_^,dE)<]ZEdc<HZ3fN
UeGM=P_M_MMMUd_<@S4c>X/AbPU>VIV+@C/.\(^V5]?gQ[(JS/2:&IZ:1XWQ9>QJ
5d,gdWRcG[^I_Q?1Z9?TY,a:.gCGb=\G?\TVFJ/;2ECJCH(5PC:TE&8H>0@./_<F
5R)R6+e?Ed76K2#1+3G)CTHS;5-YBLJ5Qa6EYI2J0AeUY.aV6,f:ICESaX\7eQWS
XIR<c+,)98X\.,#;ZXLJ=g.F@[6]7<W+:VRcQ4+:AXK+,:aE51=H_IW&AQ@B2d#W
@-]b/HbK-G&Hg5/H?T6Q@[GNQeS&GFN,;6F2ZQJG_]0R>gJQ1K/S)#c#B:F7_:#a
:2+C/;O#2=.ZOC\WTRLIV&NeHNAc\D;-12D3KV9aBWg82PbIYAY9(G-ODRcE,E7T
e7]ddO[_WV@&#GV+SKT]+LK/P0gg?0;7UUa-E6K,&Dd3dgNb>3d@=OOfPcQ?C7O2
>I<_#NH#I3E3NC^[1><HM@bIK3>9S.5J3&7gf:26-BJEb5^gJ@Qb6EcgE:8ODb7#
U#K]D;R7C^/KOSDK4^U^WJZNCB\E0^DABbQK11H_6FJcGeH#Z[]5DJOY:W_U8g7\
2;e(09^;=RP^Ng\2#NCTDaeC]7N/AEfU(XY>(Y\:eSNXXZCI6?QJVQ6,;b&?8cP@
2-fQ@b83L5WOS?63TdR-=P()^=(HYP/[Z0C.QIN)ZMW?Ygd=U>=UG/Kg5SDG,gGY
D4@1:>a-V<0DTM0f>O]d[S29R?Q365+WSCaIN.eZ1OI^)b6V),O@:KE7?)FJ5VAf
fG8H,a;8\dRD]bHFPMd56Qa+B7(\3:?&K2K9WQgg3.AII<c?QML0Y(D,RPfKUM0B
g+8<^L5,H-_0IT.6b;0+/..WPd[HO;=CA&S6TGG43#>ME(^4R4BZ9O@C/40F#CLI
TRe5VO6C5.3+EST19cV^J9>3OLI@-C(E/5c^Ma<K6?ggd?_HCJF9ETJ-IW14H_e5
FN6HVM20C#+4@J)A,)._4&4(?##dg\;e/..N337#VKfWK[F6^(f1bE3.&B4]W;38
@5PU_U.59d+cVWRUYJ4:KL\.g&H)>W+=H>Q&&SDJFQS4Y;Y=CRb\^WaM0Afd]WK#
.G4^^;,BEEL\dV=g_&3M1&<=4bfJd9Ka9aHQfZ@L_?eSNc:ead6cF@NT74-Jg;PP
b6_N+5ZVU).48-Fg(CE7QOJSg_Y8[-DNA+JX#g=/YWGO\U+TV[QP/+F>:_7cN8V\
>II]9A2[XO08ODGKW:Fb)I[_?a&O;25YUPDgV/O;&#]V+/45-.=<dU45P;MV>,U;
AHLC+8GFbP=F>B;;AC@LNXD+H7&5CMW2AVI/LMdGEB.R^[[XR1<=VK?6Uf1>dF/&
6g>U4Uf[0@4WfS(NDaP50,#J=)XQ8c(fW0UeRP;94SONB1=16B4O;L9Z;@-56X@[
IC9a5Ve9#BU^N?O4bW:&]b2&G/1W6RJ(Idc-+c+R(N]1[1B>1,U37G?ZL\W>A&6\
WF0+&,K[_)4N#(5,c9H6BBQ;;7M>NO,S#EFWbdOT,\d[KQPHNMU_#.@WS.gCJRfR
CU0EORE.]I\.6gF(dN:8PG](;(E?OG\8FZ3NW=E4d-2<@CJaSbVB8FX>g_6>+E=e
#63HDLBJaJ-BA#gGDTIfe.dR+MH@e:L+XS,Q;8QP0c8\7f1>Q,.MXd(/ZCI4[ATK
1]U]..VGH/b=\O-ZJG^0KWQM/MRUN<B<T(\Y8U3[_eN]g(6_48@4@18]3+57UV0=
T[,NE_f7B\a)H[>R:);5;ZL/Fd<2S/0^^#\CD3VWNHd[9<.Q.ESMIbH95TE[gcBI
DED^eA&K_e[VE4@E+3FQP>2>>1eMUEW=:>-ZA]-W[Ef/Xa2_fM(F@.3?IcZKg[^#
7V(;L?b0&T.2XaQUcRZGcW1;a5a@UR8?LVfJ.-gdS.T.T5+W(_NF]O&/?b>\cXBF
aCf@-fRP(1bT9WR_ddcbIab[&&JLN>VfLNfAHaU&4dG@-Ga]?WB2cI[B9C>-beA6
B\\G[_MTV3VKP>Nc4.PDZZ(EG:fR3-ZOT?(>05f&cV+\D>^=Wd_AbQcU@SXBWb:L
94G&]<V9\7JgDV7X2Wg@)OR04gIb)BPZ;84<;@?<5YNA,cgM,f8eE6U/G2cT2(>[
?7;A>L=F];?3XYZ5DC)O]ATSLNgeU#-6M-Lf/TF=+M+C(F-+BLS4gDT:,MZ,afQV
&Nb.BVObSZ_;/^(5cK[T2XU)=<]I.KW29/F(Ld--Pd2\@[7cd,/)YN_C92a_^ZSQ
GS7gJX)=;RR8ae35JK+1[4f1gIJ<=6<7f>-@.Q@5JV_d4U?QQ>98_=Y]R&PF(@S8
b.fXR36SQ)X[O#3JK?a6fXU;cILO8S^O=.T-9-LDSBOgfUXQ,81W0/0X#;5-HfXT
VP(?2[H\WB?3-6EEPV4b&e1RXDWHgVRK:f8Y.F+8L/DV.?.;[TK8Ed3M+g>L^Y5A
,9(g?_a@NKfY-D#@G(G,>B4U_L2_8[N?aY\RMPKYN6SF#_299AC;A3DF8>IcET2(
3^=:d^<H^>/N-7W6/XP2()aPPA]G#6J+eD87)a,f:)ME\5B@dFWSB6N)9_E0\^b=
N>U0O9:R,b8^0VSb+O/F#[08dVT>WGWMQIMWDNT#H.ZH8UHT_Z)W>HVe4:J-(]@G
08E;\0Ne6O2:(L,:G9?:7G]YS?-J=aZZ<=054FD2eJKQ\?=bEE&89,+S&RAAE6@a
1XR>Z+[/&GZ:-7A+8=?-d+M+B-,e6O0SbM5HLSFY4./0a@&IdJG:A-W@>[:G^_V<
<JR)KARY&0@JFdZGI_3&3PK4<S[^JRg(K6]Hg<?DF#E1EdB\B;PSfXa-W:A3H=+H
A6,<d]E9FeZUg3=JE1B(C^(8@5e2BZH3@>\B;D8R0V]Q_?(8BEE3E&:^DBNQJ[F@
6NB1HILF-JN\Q4fKb^/d3F]OPLMPg^RT6J,eOPd?,1Z26a=a<PP[6@\b]I:GRNbD
8d-U^LIgHfb[)J<cQc646C+)4e)M[OH]T>NOcOE44FgbP48X/:YcC<MO&]c[&+]6
)W-6,MY4#6M-?U:C<G8@:MP8O<X[c=&T@\H#(R,#6D-.4E30G<-DVeU(E7?cWU>1
Q)M]#L)X5[A#3KFdMG=f#MMS=J]C4OH&>ZV8T+<g]M6FWLf]G\_&e^6FBFK7S-EI
1YUCFE?:)/\7[#PM@=aG9.\#g8UG:@]Qc6<[3_\^ad3e5[08/].K.&UEK4Zd[R#;
1G\U@DLVGAG\&NK\\<LR,F^eOZIG\B:B)621.@&92f@b@M->5&32VgNg5AC5>Ia0
/</?,-a2g03f>fN&Ne&>[Le\b&.<.B2<3M-?SS=4.Wf=;GQOf.ZZ2J7]?>QB?@UY
3C36PH5BK#,>-]7QfTW7+C^OTG+X=KOEV7:7[d?EcE>36--GC.J5,b<X\\bC3d8]
.cY/bcL>[0P6,[K)8L>Vb>W7=Sc=W\PgLW<T].fd(R]SK09cTAg9)Z8WGL?0X+:,
&.+,DH?H1[Q&(ad>NF<(#9T1]dU[aWJc_Lc&4#6=K4IJX@;].PQd>c^(3M/.I:;8
.2\WM[XKRQWO<99JV=W@Z^<&VZS<^+fY1;6a=d__5bJ[EIb-RX<gaB)PP/ZNVe^;
PL9D.Q.=<4?GMM[@,4-J1;,FWb]=YIa4VbD31I6_/KIH1[PIe3G7cG_K\QN+>f82
(=(/UZ:V@:04e1#68CM4APL9^F<0U2\<ddcU-H),K5=dW0EQ+8A<NH_GN)#-P5G>
X7HJ2+.ZZQW<8@.S:;L9K8],f,ZITZ4+eaNdcaK\Yf-bIW2+PWKY(0HXKC@5@HYW
&?YK[b2Z@1fQW1/#K-=bT]W8[^0F6.QI[0aD0V.F.K6eKScd)WC5GcNT_N:6?1>_
eG802V3:_4>CSDSI-@WYSMJ/2WWB#6892(1O](B?74YScQKRXb0D/;@IB/_RMa]\
@_,N_e:9L1B34V9)G),)#D\KQYddb:K>=EWL7bS>a<U^L.#1W5:<F;D9=N1^Y5\G
2]KEQJR8NFI7e?=U_G.@SQ6;gN?_NM.YEEWN5(4^2F9[eE-?IF?>VYQKOG,)QMKV
5/2W[PFb,ACPS6/AdHN^7g[e3D]dKBfc5g-[HIMV>dZ(.TASe+YY)=^-NQ[d\A;6
U#ZO_6GS2O7\/3+IKX=QQ(C9GTFg+Y#AEF9V<<D:f])9]<9G^FTZ1?@LMA>T2XD&
2Ed=4H6U[F?d&+N==c5WG;5&P#3Jc3@?2>FV.R21;18BF2bfeV.eD=_O5VPa5+#)
CXJKaK_2X]]?:53/G:S<LG8(T[D7CQLH&P<7/g^c\:4FW_ESaN<g9#WQMS4,.014
0T8;1FLK(]_DZ(ADP2217?W/P3c/&_83B->Q=?1Ha[4g5:]\,?<UB-ce@f+4]ASe
Q]>U&+b<Rf[YN8RBK07LJ1QK2D3H0WY7]>R2>)NY^597DLBM-f8cNRVXe_-b\^P^
?[@X6eF^ec,a_(:4:L<7+M]D8DR&ODHf0fUdRAN7^CBS3^R6QWfHZ[Vf1QWCe&4J
_D0#FeY,3,<YQF52H^34=9E/+G=_T>cSO]NL3fb6>#/AQ68,P,,2,5@ST^a?4Q=Y
^&6\_ffFWd)0AX:@dM02C(J;U+HYOS+]28BA05QTG9RSf,4M1?Z(:\,+_XZ8Y7Db
9^]]UK]8cd<\)BO]SY_8A\Fc)IG&A,b-=Heb:RJYYN@BD>Lf3CI)BCMKc.OQNbWE
FZBT[VJG4(]2V)2KK(?HQbN?F.4Rg4a1/fCfFQ_(:4>9<-@Pe.8<f4^F3?UBWC\6
2<^g?DEM.bSZX,S56c5\L97T@FZ?BfWKZTb=1UEKE_3<VQ4&N^NNf9G[?DN@B?F0
6^\M[UT6e:HB;3[53O+W2CH9&Df9QCDfKHP1PS0\-]?f0Ib04]I/+)KgCRg\D\\V
]Q?WfM4a]]ZTKFI=81<XY7GFX,N#W+V?#IW#/0f0-]X^L,0b/YB_J/5U#3[7B+CO
TMT_Z1KXU3Q+Y=HVJY[>S]CO\F+8I+b(5b;(0T2&S&;HP\A=ca(]^c[eQ8UBFOJ-
&a>./XgHW6bd5E0f[:GC2:e)O;O;&RGS0J-a@#8GfWPV\3EVe47QI1NLFA1KGK,0
N#SQY#HVQ-9NEb(\a5gQ_WDX>EQ&J]P13:,9-E/ODI-I\g3X5b4X[BGHFdOdG-4C
-Z_<bC>AQO&UJIVe&2d_=\YV\aVefN3UL):E;C27f23W;Kb9bXQ004-R/b<5>H^6
]/=)aO;V/E(VI(Z;^X3,7f@U+M+UPO48@.5LAG0@eLD<U180Vb=f2--Pbb.Rb4CF
eAg>9b;^]BDG0L50/OWPRJ;^,>9eEQ)#D@5)7JSLaa:Na5?Uc6eeEecNJ^<f?)K7
/^YD?N:94:fadQ&IX152^N0V5JB03,W:YR<b?c^50ZIQ6I>eBE4O&.NI8U1B/:-L
XE_\P5WF6J_/BNd7.@S]JV6S-J-?2c0E#.dE@U]R+64BTcfL+=cVd16c3[?./VWa
(4Dd-ZM(D=,WUP<Jg4^K7DKMUd\&8]2]K23QX&?UO\Y(32Z+DJM)NQ=cE2_PE^3J
T6]6)JR)6FO0b4DC7[?A_[<K@@+]M(W@;aTcY_@+JGCf.VI,XUaAZHZH_7O;O/Q0
WJ\B-^9F8]-G6-:,1)+(69[7gg80]?UHE>FfP/9RJUA6De,f=/4#?KTK8++M]?ON
RZG38;4Ue\SQC+TdWV02\ZMe)]>K&F\0I86;,L89+6f43f37Z(1[I<@fU7UZ<+ab
W3NCTDF=1,CH<U^R_Gf3UgQSA=gH5TB/U#6?)46G3WRGV0F&#1YP6<M;:SC)G6]W
)d2[d;NfHZ966[2-f.:G^O30PR54)cHMg@W6Q0;M[.LP(2VFb9QWAL;aJ29SA(B\
6F.bE]&c-9@6Y8^032g=O.OU,1[J-0c1]N#2GIVaXQO&6LP>__<H8[>9R(?1:XOH
=VP]5J4+I\IB-AOP7H4Z\LTg#D5E?VR>c^&Gb2D\L7E72;^4d+)M=E#DF(PB.W<I
C[&0SACHDWM;EX@NJ]RP6,-cMb4.-O3PP0+B+D#W__(>RGMQZ)QBKF>JeVG)P,::
53<&OYU@#2C6[M\Vd1TcfM9?fN7SOXS#.We8VY;a>gDPb.\Q+JB#@+:bM=HAHYNQ
-JCbc0\Q&HP4IQFb;ZOdf4)@3GZ2\42GEeWg9bS=T5_Q7K&9@5ACN#[HP=U>bKJ[
S(bS:4O34d:ZES9=(T[RP<PYT)G)R9>FgNg9X@/U4>U=M6_fa?TM@PcE323^-K6Y
@?5VOYg@Ge+d;@FeU-Z(bW<e)6B^BPQKE;@>Z_2YA--[f7Od#KD9U>1R9)Q7VD(H
K.OM.,&>L2YVMSIPN9ZcT^:Z2JQVDFfTW1W8:KJ_+6AF3(4AOXUL]dbG;S<;>/bd
e=3+_T;KMEIb=KECIOTQAAcgQH(OU)U)@f>PHbVQ.E(+X/)CT.V80VNfeLg?E@eb
Zff3eWbfAKdCa/7.@1_VbZHV]FZH05e]f?d8[I-OB2c(AAc)RMX(L1ZSIYfBBK]g
70SKN09<D_\3I?D&-9EadU0OUH(aZaK,^cYL@\F.UMdS5K-CKH-dX8\f0A/.HVJS
KObMI/FMb(#66T_SI8AMIHD[#fYSFGI^K;RF44S]WJJ>43450>^a[_Z\,N97RT@V
fUTf-V[UX(E=LS^e;=5U:CRVRVfMcAFH5GeCcdZ^;<I^P/FCI)^U9CNQ6YF:)-Xa
_P(d?\deC7F3.^J(=]YgObF7:-Fa[d+/&I_+K9G/H.#V<(Tb]e>TUYd:Gf+MCc_;
IMDP>JaU_P9fJ/;=]2^6(?OIcG8gT2[Z;TgBEZ+cG).:?&VCA,=X.HD[U6<a-U,1
6VK=^ML\O2geZN)@(WXFe;4=U?M3c5IW3+/dV(@&]A7b8ZMJADE#Y]IR=:(cKdf_
ZJNI:CF13=OaB:aRZI@A\;QT.Id(.GPE2ddCY[5=<LS+E?N7S)/4Z3b&)TYIV8]8
DNdN[<OgOG3VG2+fLb89d(Xf4)&=VAAcfSY@7c;c-f)I_eHdPaP7c3^2bC1MAcc5
P4\3([WXE[WcXQ8Y+BEB>dIF0,F6&?M,A;eBA-O2NIZN1JCg#F.56BHM#CY5=6#O
e9_XNS_@@;6+DV>DU9g#5UDF5LL\L@<HC-eA^C2d.Y]B=44f+cMQ0@,54)]W#<Bd
5R@HGI39[P9_#>UMePVPCW9GL?;?G&V4X74)Mc.8:(J?=>Z9D-K>5-A?PN5EINT&
NR-].bTZ;JLNbFI9A4cTO[bFe:Ba-[9,=gD#0T/0O7UO74d7@9ELf,>TA]GJ@P+<
R_PUZ:YJ2ALA>-GD^G_99M34b7fDgADaCCTZWSYDE]aGdQYc241##2VKUKNb.QRb
e&RJR<4_f(EJ)+d?IZ@9ZM+NOXd9NWS\]RP;4>_MKNP28PXN,;cZLC0/LDcb.+90
L0?J<Df=3M&#-(@[<DfagT)\[;D;I+BZW][Wb16Y;fRILPS2SG,@456FZ&?c3D,:
ae\>e;aL,WYECCL8M=3^_9\51]()L5O(g6E=P/=8.-TK[:U7#RPe3R@YH-8cVAc#
>(d8AJce]d0@V:&FMZ2J58,C.J0.]PVdOWMZO>RSY=K;3X]]DaNQ9N3=014e/]5:
/TCf:[LLHQ.TD3^_6H^HABQZ;@)A+c=,\Se&S;3(RF/K7TKT_LYY6D(gC=:0RODH
2P3389W+[+FT\XV,<7VN/P&_E.ZJ1f7GH/CK.E&:N1NPNE]=U[,V-L:1:QgGIA<Q
C]M\/N#UZ89.^XXEFFT<A=AYRM\RNJFV9/0@c5Pe<^P8BS(&[,c:B]EcH<cOYI#(
4La0LR^gD+KF-T,^D+4F#?QQ#LFJQR,HLF[BKEF,R7>_aN,1#>OD&OZC+1fcADPJ
S-@2dWSD_V6B2F\(=TXLBJAX9?eFOU,JBB1)HedO=;Z[IG&e;-OP@<7&INIZ2GaM
7AEc])K76+3XS^3_\^g/\19(c5)ggTAU2E,P(>G=UQCf^/Mb4#H:@CQb=A9V/@^P
K]Hg7U;-gDRf^A7Y?7[789#LYb&U2];2N)dP0KbMNY#@I?_5P0CM#/T2#Rf-L^YA
T[#]I0M:S[J6N2d,=FS2;AZN--RVI]6T+-^I]&7&bJP19PbTCa4[59g6[A+KMSXQ
dE8\8B6d(=KQ:VC:e+P-e:24(bN&PHObOD#&fg&VS5U1OXYEaN\^7B;W<0<H,?BD
KFNI=0/IK1G),)^7(g]6YLU:]E;a;b:eB^#OPJ]6J9=(87SCTeF,&F..@GfGB&aO
XZ:]XUF5b/C0)+]48e[XTN1XbQ4B7F]UW=EUC-)5E//GTBE6(>6d&)1D5+=7)FaD
P3J87UO_.BW\,6UgA6/c?;AgDM<PKC\fSEP_;<b#S=<A5D[Y6eAY@G:8fI(?(^C1
0PAL9[WK[1WW+E<F\&:2f8Y(&VSXV_5eeY^3e+a0Z)6BbGZ9\H11(>^c)#);a&;B
)U#5BMEA-LAdTSOE.I#[;#/(L33]15H??VS3=>8R+:GB0)2PJ5H8QU2&3Jb@3dda
]XFBQ1HbCegBdR-JJGNaVfUE8PK4faUXJ_b&(SARHB9AdC0U\QI[]]74,M]5EbAE
47>8()G4f0b[VVK(+,)>=U5ag@>#NIH.IGJHfcCcQXZ7b4J6EXR@TKXZ\+O5?OET
A)=U-^\AXK-J<267;Z/VZLH.])YC6(1bg/J=[[<6H-I[/WC-3gF/Ge_6#2=X[&7b
6ZU-?H.4@M7-d[R_=O\81>2L\WDMU=YcGH\ceU,RLMWbCLN^C;B.XPN6>J9JM0EN
e;T.&VQ=[5/RL/:]gZJ(;AMH-W0/AHF=:^<AA&I=K&BDRG6DZ[ZZ+\<O^JTQC<@)
FHQ#><2ffeNaPLcMJ6O3NMHc:IN&#,;1Od05U\9-V]GT9248?^PCb0cA<RW6(cP>
9+O?g?R>bGRN-(_&1RWE]bHG^&8D>H,90H1FO4^35T/fDJO#VUc?d?8Y7O[4:gM@
KYAdc>U(N::7&FTI?A[.GCg8H;M1@0/+U4BQ[&:A]6)cN++O=9[X+^5MSeQ(D;,^
&JCSVb8f#;HbV]eLGFO0S-SWNOT)\B-/^QH1+@:d&X\YeBGa(^HA7aEHIQ(;K,@N
[/Ae3FB/-Q;0:_1TDN/bA:aDU@FSeZZcKON,&d\fW7<g^CQg[[VW@PWa[]cMa9O&
ZGV1W77D)JFP3PS0Me1;c)9]40gWYc7VDFRN7#(E;3YD/WV?/:60,Zdf,P/<;L9c
7,1_YASaLYRM/TWa^.a64>4LM&,]2?EGV1O8Z,b^g)G7)^:#YM;5]J5@:5dB7)+W
gY/0b1OgWEU9gXbQ(954D](/,9QY,gSIE^&YUPWf7V93R^+[<d.R/TV:NL9/=\a(
/O^_)=g(?fZB>>^OHFaQ.8&T>J<UcFcMHc74agI?0g+J7WJOIYeZS4baf;D.cHEO
/SFS7C;>YRQ<11[>aDXP1]^]3>U9IBLJX9ea,IPM4g]-1J<RG.C.b:IcQL-K\@@,
CN#A-f?G3>LTR/K2_eZJQ3JgG.[F73]R#eD&0,@NNHZIPI+&X@Y9B+^W.II9)MaL
bW_6ec_=)7E.X=[<Y7VNC=\eLD-,<YN-=F8Z5C-&5e6O8Rg-Ze,Lb0(I.<KD>)W0
46:>?1,[V_\a,EF_DN9Z_>,@_8^EK5@3687_GL0g))9^AN&M&X.C?a-BU5(H,;Og
YVUVO;\2KfaFYQV9P?aQU5ICK887K@e8B)a].#/BCcRd_L811AB=]CeWHX;d.Ee^
AQ#GD)b@RcaZE2Bg)[_I\JWVdeU]SD^gIIM^:A6W^L:@<C@387egBFFZ/[[K7/(A
?.@1C=3SEZ9E9IO+fDYPYAXeMbX3@@@_VYY<W(AeU_ENY_^#Mf102afXdNJ2dX81
R#>_D55Ta75>K9[9Kc2L].LK9H,M=/SDU8T9=7JBPPbQLQ?<QZWLM33P/<O>P,,X
CV-e#LL:5BdILW#bb5?TI)/WdNMd7#)CecMef4J6/2U<F10O[5IB\51V-+X(YR>7
73<8XF>8O9;JKP8C9bY1/=We_XPeGHO0XZG5E0IT;36=]?@Z\54.3YGg,;]d+f;M
5V]EBOJ=6S/-YB.dG+@(KdZC220a=TDO1gQ)SU+KIF.W\O+FF4CHg@AaaD[e[;@.
a.BP&,FG?dUQ6CHb]WP5-<g:VP(O@NMNgG[gP-LU#5KIHg^\JXZeB,?O<b?Hb^5N
.G7-BN#TK#HE95\eYQdWU:LN-A0^A2RX4;<a1P4cVU0DSVgRT;aaP:P&;gGI3.9W
[)<f0fW<.I5^eNH?6(C&D(&I7Y8BaFZdKMD6E@(&MHa3@XJXPBFbLaQ)(++bLGO&
YSNBS1Y_ZG]#f&EOAF\a:B,&O:c^KS&TGc4Y.H;\(TOQ_RX-/\G0J2b-ZY=C4LL\
=]2ABT-,f@e^7&\39[;[T=C)Z18AC8(6fcZAH,7WMcaQ6NLKJ&9J>bI8e2W]#LgD
E:bE;Z95_M/#2\ZUQ#IK;F7QH&@Q_D:fR72?O+0IN/C\;,OJ-baGNK.0YY3\=a:K
b50[VV8a826f/U_1=OgVVMN\>6:=/SbJ&L:N=M?E-4K7FGb1532U0H(cdJ>6]UOX
fWe[Ya833,IS?#>TV4Y46&J7=FOB:R4CR@T1AM<CX9;OHHQ_R=YD3If3(KTI8A4T
]5/6H;V;\N;3#?3JS45:CdN\B?NKeR2C8(f-Pb.:T=>I^E(NPeZNbX\Z.58UG)3Z
5^fH]PC3ANCT_\@SQ?C)(I.-P@BR,c)QV?7BXb,IO3B/_03Bg&UGC?\BAS2[gQ7^
17cSV[72KC5QF=RYdca,\1K\)J(Pb7MM]3:9:^(#L>gF?9,FR729+_U^R@[X:dg5
^d])=?;\/0#ZMHT6+1\J)dCWXTb5gF[^8X952N,N^/Lg^EBGOIPLdPNW47e+R]RU
</8L>aJ<I8Da5(C,3@D=5G[(;84V-MI9HBJac:=#Qc&R2&E<-DEQ_c,?MD&7PO:g
6,(T[2d:L,ZCS>IaH:a2?Q=])PX.E[E9JeTG-SXf0d]S[2^f+\8UCYe6@S[f/^WA
JU\NTYFcgIG^@(2X2[0H8]ddG5:+WX>(0VcZ@98b)06#<ZK@2IUU<SZCS(BD)\O@
MU>\V:bE;QdBbHC)SP<1/B>+E.]5-P<L?ceEHA)&JX)0UeE^0NQS2+C\_4JC)==Q
D.2/+2fbI3/+:AbJF8S,4eZ.:X=YP&/1VRcHUY(Q72TR7PKgF>@>K+JDef9gVG,\
.2/a5V5<11gDA5=Kb@O]LZS;W6K;=P^8,+^2<ZYSF<IfNE./&8+6#[Z]<DNC1Vcc
4P42Ke5Pa+YX06^e[_@O85[?D^GCB0D>=-dJS8HUfg.P7T;<U3(P(#?T\86:Z2Xd
GgHRfEJ5QP5:F5@):0WHLVVL:Nc,\^6WK;4M6)BWVC293RKQN.g;^>T/7B4?f+U9
J0ZWU8DAJE]Q7&Z3Hf3,]>>Tg/[[L,?F<FBA]+USW48TE/SX,4[0\5DDHLOH1?c?
3OI7/#HAY8(DVZZTX73Z&N3@\O8TbXS8)224)7[\EN9,c=&F&QddM\VNLLWYS;X0
4<=_\<;AL9;RGE?cKfJHVU-@GY>)L^]c^]DJS+=b<a_(bg)Y]20C[[/^UU&XJ90^
XL+/CZD590O#7_/<I9W]@_ReY+6F6(9-YcV;\=QJ991HON]5VcTAY^@WOUTM5F6P
;35@XO[@0Qg5d8I68W3#07)0LSMH=G(WN?F)b^</g6)+TR3We+2[8C@U15)W@1bc
@9)3K?=W7bD;L#MF.),WMGT-E;;7Fa(4FfL-YJG+2_OJMe>Yd8_5]\L1BZ?GaATM
PSO=7ZKIBQQ]MQI?(=P8_0f=]8UU7cI+g8RB=6[N:O@(B&0EdL#/Tc/E+E34IJYF
&d\4:-P0\#/D0[UZ781+&021@5_WWX#[:M#=(c79W&N.E9HO<&fKBYc<D-M-5[g.
1ZW[>(C,;X_MUYTR>-gI=KG_d@>W7KDdbe2Q6[beKSOFT5aAO_P6^C[Z)?X5@=LN
L+#JR)BcJJMLQDc4_Jd@GbQa;?,\AQU,I+Da1^L>8JF\7e4/BI^P_89L@g/>XO3Q
_Y/<f>df=3@+ES/G(adL>1K;d86I8a?5@a:4=d\=IS_<984;/PVDM+;/)FVEZF+Y
Cf)e94D<>9]TJ?K,]O9])aZcb[5-7H>Tc,XV44OEMLS9H&fVeKCRDWWYD,9_)50c
\:;OTI.V(.JE9YZA<K&@^,)9d3;e_aPH(51.22&UTI5C\IC&=&]DA]gcPD2+.>_P
UMM9;YY@^DRPC&KbT4&&:P(&SY=:ZY<Y@;F[@c)@H3:85P6/^;7ST<FT[5c2:X.V
dQM@dT5_[RN0.fb+R;Y20a^WJJDLDRFbC7@PC[+)(g02Z,=OMdF+beG9V4ABe8\Z
RI46/c?[EGWJbBO@H9>K)P.<\4(EF/Z1C.a_/8b<cF.GgH;Zcb?)G046AZ9;08P.
(_F28HF9))bPYZ_))/e[ccCWI@>8CAMQ?(\@?,WD4]Q_c.VT_I-[;Ya8a#CGP9H]
6X@O_=1##ER&^&>0M.aX3Id5V8U.>Z_^/e=3,HCd5dF],32-g&gXN^7CbELW]:B+
;eI];cDE-XV.02@@4[)[a3T4Ba/SMTBfJN4LTFEa+4WHKB:Qb6G]K(VKV&J\Tf<<
]IRfH80#TPC&CR6-0U4:TfOG18DFTY#ObXD1J;,b97;aDHZ_=QMfRDcX^QY:,,1Z
B7a(<98bWAD?4e+Y59KeMgT\)6_dc,Z8FN&]bPU8W,_FVK,?EUCC.04LU?068<#K
Od>/e249F>aY&#B)Z(3IK?2Nga,,+EI0_5b;N#/G,Z4ING0(+)fINZg@-HaL(WAV
gO3g2KDC3N=A06Z=OOb7,N-EA,V6BT\M#]4\LET+VT,E@g.]eKZMO]4d(W]1/1CK
0JXN6\40a)SWJ#)W2Mc6fQ(fO@fXd]LPXI/]Q81LX05U(Md4a&F@@SDe<\F]BUN/
e8@:^B)TQ7PGeH)P60Oe&T9+[.:986JHOS1/@+3dUT:WRbK9T7&b(-LfGDe99VYO
=OZJDINUSD1#M4:dYd&g6Nb&=AM\P_>@3<1CODSHUb;gP_TcM6LVKDg(NHc38XYX
QUeQ]/U\_3a7P(/4ae\+=I0_DYP]\[9g4#I7KUbW#>e=5V/)&6b>QWK;K.GT]GK&
gIg>_RNSZI6C)U6__ZLY8PUS1,=>/Ib/cOS\G&EU@Z((@DHa=I/L=4W7B#<^))AX
&TUTY8N@#-M(c\7IUQ>KeUR;+_47222O^S)TKVKK_@>,4GP7AD5bO?1XM5@V.9d\
19JAWCHbZ5eU+D#-6?N.80d4PY@_Cb],EKK-#DXGM<.(dU]1B,4M9[I0BgD@TE?M
NBJga7RD#X60@,280@c;&KO;eF7GI&27OQN?#A>0SE?ACPTY=;(N96,1G]&2T^BE
Scd6/:FAA;SF#3gS-+BQLB>5..E62?>@9U8:J0V#(54(G=#4e96;bfd2NU<?/LH4
5H#+Xf5:U(XbMBF(WA3gK>?H)&I/YRW&0:eWg1Q\)2e))LE<0-Y+6+<7,\^0ccW@
?a/M(@U2;)>E)0KCD-S[BZ\b)SGT(Z4^PM7M2)??Y5b5=L\YbOf5:GHDH_Xf=I^Q
EY([93-?4@2#,<I636+,HeQ#O[aOH9@PZb_-R5b3CL8BG3ZS\5FNJ1_,0IaV:FRE
:0)]_G/B^;76B)0,>0XC>08Z4ECY>X6FVX6U0+H(fSF&#/JKBQ?&+5cTBUHD9c9G
2-JU28(_(^b..<Dc[\N<5>@Fe\K/>;T&g028I+:.g780,_dW:J;d<,/>/Ia#0=2e
P6.V)If/<Y,T@S@5\aQHdC>=RIg4>I)18N?V2<=Q+8SWc(DX<./Z=5QbE?S?><We
7\HaZCBCBG>LYB.T,0RTP=@\[<6GZT@D\^^)DOF/J_0S&GJ,CX4<]609b\0@F-48
T8f7&DW#?I_A9L_MLHcFSLKI:S3=^aHT,;26.Kc?b9U?dG7@/22B_JH.6KC0JGOT
YV,7FG(PP1IUW0W0aZG+(LfV2c3PX(NE@f:1JHK?9/#1Y:I#DOJ9CQMVa17<,S?L
9[F(UVP0T^M@0_P6/8cY+9ALQ7CU43Y5R/ade-eU;DH,T:Lg_W-5gMa#WU693bM[
#gP721K=E4aV5f)5=M?I?()R9e?CO=J8B.5dbbBc[/Qg[QDTAZUebY(9+V6AgV]E
84?Nb4TU-GY12bL+8Y\gO],(@,O6JP:/OEC0A;#><;55T/V1eT]_[VI7?-d_L\WI
I(K#f0GVD#DG483V7e<ZA6,,U>][4<@[8<1+\_]RL(SY:7W0dQ.2UYN8\8R66965
YAC54-&@dP?aaI=dDJ?7VN&b0S8Z-;7cKfb\a?1DAS;X?6.[]JZ)V\,4]5S;S:2,
1+#VB>/dE6K@@FJdV\EE[1@]]\g^1ZASS]^bTP<:aLC0>49,7H?dV+_dN42Y&0VF
?@O/S@ZG]4?F6EIQW=U7BTc(L,8&Z)a?BFWEPg52+W+TIWU0#1fgWcO)2I+TcC4e
F97TZ]0Zg1fEAN&P82XK4[)P1EU=R3Ng_0@\KQSP0E@N5Fc=e:):d-\BRXIdODZg
e#6-HCTG9Za&L:O3OVB,dE^B#X5=A:H=&,8e:>D3D/VQ_SI6110;R1.X;Fa(^^IW
3+_[[P3C6^6?6KUQb1fgV,74QA(AGG;NAEGA;3a:P2.<O+:P0BCCUL]?D7]Vc1W@
;ef^7dUFK()T^f2V7HgOLC[=7H6)fDH-4\OSAUg)#5YL>J30/GZ]_B[9C0C;eVZE
L8.N.U9#BS[TbN=b,K&GMfDD(FYdEaH9F/@E5-KX790D#a31(6L>_Q[]MZ#:U=@>
58VX1c4cDYR9AKa+/\7--Ea3Gb-K?MQ@X5SCO.P3E&D]c-[D-UP[M;48PC+b=fed
g_14:(,(0?I3-TeRP[La=?bPRXP<&V_P)eZJLF.314fbeWY8)T2UX4aIGY:L=eDK
QTb_7L+<U4;3..;I+)/G7.YG20/QY105^g?Mf7&eY1JFb/T/5H/T.1?C59HV,\]^
Oe(;U6/>bW9adLfEHO,:>Q]7Aaf7A4-D_<3UPFY^V,ZF8_?TX2&@XZY?2-/L;A@J
TW]ZJJ-f92+.IW<:&48Q=\c\0=M@Yg@:T9T&8W1RIAFR-/X_Q_U91=-PU><<P]Q+
cR92Fd?3]+d<c>/,c<H>B;=fAD;[CI8Tg4#2Af2PbT83Z[=<O_1e.bGD37,B9+S/
U_GI,X/\:+K_T70@]89e0S-H+\)P1_],)RMdJ@D@SB]+X6AN2?g?;H(/bg^(F_-0
#f::WW)B&Pf/5NV,e8\9I0Z)Y9Y\5Z#MC0XR)NE)J<Gd0;LT3,\X)M3AXB]=_;cB
P85^PG7A<LJAfGS?9QNMYTR:CgPHU1J[,+c&&?KLUF[UH9W)2cW\D9C4f38LaD\4
\f0+c>937R(.]dQ-OV2C)@<,]2?dWAH-N3[5F0dB_O(KZ39VN&FdHBXPFO6Q_O3b
F>JEd??:I,<g\\I+E4AEC>A6]&Y9.3J0Sc(^4.VMXU2^VRc1aH]e+>^452GgLJW<
;N-69R;SDEJQTSN^BP^EJJ3O@g;#;-@[eL0?K[=V?3J:DRONJPE114Z)5T-a;RgG
G7I&;7C;J0#-#Uf(cMO^2MK-5H#^cF/g-.5cK7Wc(;U?&F#0WQ<8D.Y&346dXVR[
^F;2\^5P97cX?Ce?9=.Ld,f&e>5bdb-7[4K^]O,fdS6d:56cQ42+,DQWMcNPXJ:G
?HJHVGf6(X88C70I)ZB9ag<TdV<EAEXeTX&E=]WKJd>B,ZHT52(J>VH9Hc5=DRHd
7Mc=]MZP+UK&Z<G[8WF\J9LeDPY^H6GCE,c966JX])0S_P#PP937=&5C?MN2>81S
fCF3H;LXM1D8Kg;50c4GU^BcRA+LRH)<0MIT,Qd0XM()#<8MI,3;d+9S\PX5+857
=3ZX2#cc,L6f//aWC(bD@ID@O5B)1FTGY.>(<RFJcNNFTO0:WFcVEZIE&QN.g:Od
b&ZENVfc7CPNHE^Lg:8+8&@;M,ZSFS+MdO3B_Jc],e8\G^4CI03J@1DPYUK=KMd_
]_9PbddB0f6B,a+RC&;EC=6JFOR-b:KC/a=W@WAG_>E_#;>N(,d6:M-TdE,-WV6Y
4.TaB/PY4>]X1V7g@?aX0;,LX07e;b7\YdA.,Kc5@D@,RcM()He&@UPTRJ_fTU/(
P[L_D8--a=+2G6#7aC-QgaHdU\7>T:.[B8^IG=+DYX[NER9a<<U=^0NANa@R9.Bc
?\?)1J-bI#B=O2&:RVbPW-HH6TdJPC)M7;(Wb<B9VgM3\J0d6WA#8-1MOc?OJ@-\
L+#C6<D(:ffFCMcR-ZHE6TAE=<7BJ&(]K)]8]@LR4a:Q]RO6CcE6f.>41-abY\]N
UY.f,G:FQJ@TXdJ@HMf8Sb?G3bcZ:dX8#<E(PJ/WPcHO9E@.=7XSS1Za\(RH5;g3
7(@XDdS7V=M5^E3?(L5g7#R)aeI?2g>WFJNS/1:/.GI9/E(?INgcN-P^:&@#\c1S
BCF,T9?A&Q45)$
`endprotected


`endif // GUARD_SVT_MEM_BACKDOOR_SV

