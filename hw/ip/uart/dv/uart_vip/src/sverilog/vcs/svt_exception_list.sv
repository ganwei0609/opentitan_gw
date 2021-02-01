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

`ifndef GUARD_SVT_EXCEPTION_LIST_SV
`define GUARD_SVT_EXCEPTION_LIST_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_data_util)

/** 
 Does the appropriate logical compares to determine if 2 exception lists are
 NOT allowed to be merged/combined.  Expected 'general' usage is shown below.
 
 - excep_list1 is <obj>.exception_list
 - excep_list2 is the randomized_*_exception_list factory
 .
<br> if (excep2_list == null)
<br>   `svt_verbose("randomize_*_exception_list", "is null, no exceptions will be generated.");
<br> else if `SVT_EXCEPTION_LIST_COMBINE_NOT_OK(excep_list1,except_list2) begin
<br>   `svt_verbose("randomize_*_exception_list", "cannot be combined with <obj>.exception_list.");
<br> end else begin
<br>  // Logic to do the randomization of the exceptions to be added 
<br>  // and then combine the two lists.
<br>  // 
<br>  // If one list has (enable_combine == 1) then the final exception_list
<br>  // is to have (enable_combine == 1) also.
<br> end
 */
`define SVT_EXCEPTION_LIST_COMBINE_NOT_OK(excep_list1,except_list2) \
  ((excep_list1 != null) && \
   (excep_list1.num_exceptions != 0) && \
   (!excep_list1.enable_combine) && \
   (except_list2 != null) && \
   (!except_list2.enable_combine))
  
/**
 * The EA and 1.0 version of UVM include an array 'copy' issue that we need
 * to workaround. Set a flag to indicate whether this workaround is needed
 */
`ifdef SVT_UVM_TECHNOLOGY
`ifdef UVM_MAJOR_VERSION_1_0
`ifndef SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`define SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`endif
`endif
`elsif SVT_OVM_TECHNOLOGY
`ifndef SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`define SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`endif
`endif

                   
// =============================================================================
/**
 * Base class for all SVT model exception list objects. As functionality commonly
 * needed for exception lists for SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_exception_list#(type T = svt_exception) extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Used to create (i.e., via allocate) new exceptions during exception list randomization. */
  T randomized_exception = null;

  /** Variable to control the maximum number of exceptions which can be generated for a single transaction. */
  int max_num_exceptions = 1;

  /** Flag indicating whether the exceptions have been injected into the transaction */
  bit data_injected = 0;

  /**
   * Flag which indicates whether these exceptions should be used "as is", or if
   * the component is allowed to combine them with other exceptions that are being
   * introduced from another source. For example this flag can be used to indicate
   * that exceptions coming in with a transaction via the input channel can be
   * combined with randomly generated exceptions produced by an exception factory
   * residing with the component.
   *
   * Components supporting the use of this field should recognize the ability to
   * combine whether the flag is set on the exception coming in with the transaction
   * or with the exception factory. The combining of exceptions should only be
   * disallowed if BOTH flags are set to 0.
   *
   * These flags should be reflected in the resulting exception list based on
   * the outcome of AND'ing the values from the combining transactions. As such
   * enable_combine should be set to 1 in the combined exception list if and only
   * if it is set to 1 in both of the exception lists being combined.
   *
   * When the exception list at one level of the component stack is used to
   * produce exceptions at a lower level of the component stack, this value
   * should be passed down to the lower level exceptions. 
   */
  bit enable_combine = 0;

  /**
   * Flag which is used by num_exceptions_first_randomize() to control whether the
   * exceptions are being randomized in the current phase.
   */
  protected bit enable_exception_randomize = 1;

  // ****************************************************************************
  // Random Data
  // ****************************************************************************

  /** Random variable defining actual number of exceptions. */
  rand int num_exceptions = 0;

  /** Dynamic array of exceptions. */
  rand T exceptions[];

  // ****************************************************************************
  // Weights used by the constraints
  // ****************************************************************************

  /** Relative (distribution) weight for generating <i>empty</i> exception list. */
  int EXCEPTION_LIST_EMPTY_wt  = 10;
  /** Relative (distribution) weight for generating <i>singleton</i> exception list. */
  int EXCEPTION_LIST_SINGLE_wt = 1;
  /** Relative (distribution) weight for generating <i>short</i> (i.e., less than or equal to num_exceptions/2) exception list. */
  int EXCEPTION_LIST_SHORT_wt  = 0;
  /** Relative (distribution) weight for generating <i>long</i> (i.e. greater than num_exceptions/2) exception list. */
  int EXCEPTION_LIST_LONG_wt   = 0;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Keeps the randomized number of exceptions from exceeding the limit defined by max_num_exceptions. */
  constraint valid_ranges
  {
    num_exceptions inside { [0:max_num_exceptions] };

    if (enable_exception_randomize) {
      // Keep the size at the max -- post_randomize will insure consistency with num_exceptions
      exceptions.size() == max_num_exceptions;
    } else {
`ifdef SVT_MULTI_SIM_ARRAY_OR_QUEUE_EMPTY_CONSTRAINT
      exceptions.size() == 1;
`else
      exceptions.size() == 0;
`endif
    }
  }

  /** Defines a distribution for randomly generated exception list lengths. */
  constraint reasonable_num_exceptions
  {
    if (max_num_exceptions > 3) {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt,                                      
        [2:(max_num_exceptions/2)] := EXCEPTION_LIST_SHORT_wt,                                      
        [((max_num_exceptions/2)+1):max_num_exceptions] := EXCEPTION_LIST_LONG_wt                                      
      };
    } else if (max_num_exceptions > 1) {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt,                                      
        [2:max_num_exceptions] := EXCEPTION_LIST_SHORT_wt+EXCEPTION_LIST_LONG_wt                                      
      };
    } else {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt                                      
      };
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate
   * argument values to the <b>svt_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * 
   * @param suite_name Identifies the product suite to which the data object
   * belongs.
   * 
   * @param randomized_exception Sets the exception factory used to generate
   * exceptions during randomization.
   * 
   * @param max_num_exceptions Sets the maximum number of exceptions generated
   * during randomization.
   */
  extern function new(vmm_log log = null, string suite_name = "", T randomized_exception = null, int max_num_exceptions = 1);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate
   * argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name Identifies the product suite to which the data object
   * belongs.
   * 
   * @param randomized_exception Sets the exception factory used to generate
   * exceptions during randomization.
   * 
   * @param max_num_exceptions Sets the maximum number of exceptions generated
   * during randomization.
   */
  extern function new(string name = "svt_exception_list_inst", string suite_name = "", T randomized_exception = null, int max_num_exceptions = 1);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_param_member_begin(svt_exception_list#(T))
    `svt_field_object       (randomized_exception, `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_DEEP, `SVT_HOW_DEEP)
    `svt_field_array_object (exceptions,           `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_DEEP, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_exception_list#(T))

  //----------------------------------------------------------------------------
  /**
   * Method which randomizes num_exceptions first, before randomizing exceptions.
   * This is done by doing the randomization once to isolate num_exceptions,
   * then again to isolate exceptions.
   *
   * @return Indicates success of the individual randomization phases.
   */
  extern virtual function bit num_exceptions_first_randomize();
  //----------------------------------------------------------------------------
  /**
   * Populate the exceptions array to allow for the randomization.
   */
  extern function void pre_randomize();
  //----------------------------------------------------------------------------
  /**
   * Cleanup #exceptions by getting rid of no-op exceptions and sizing to match num_exceptions.
   */
  extern function void post_randomize();
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /**
   * Method to change the exception weights as a block.
   */
  extern virtual function void set_constraint_weights ( int new_weight );
  //----------------------------------------------------------------------------
  /**
   * Method used to remove any empty exception slots from the exception list.
   */
  extern virtual function void remove_empty_exceptions();
  //----------------------------------------------------------------------------
  /**
   * Method to remove any collisions (i.e., exception vs. exception) present in
   * the list.
   */
  extern virtual function void remove_collisions();
  //----------------------------------------------------------------------------
  /**
   * Method to inject the exceptions into the transaction. Note that if
   * 'data_injected == 1' then the exceptions are NOT injected.
   */
  extern virtual function void inject_exceptions();
  //----------------------------------------------------------------------------
  /**
   * Method to get the specified exception from our exception list.
   * returns 'null' if the specified index is out of range.
   * @param idx The index of the exception to get
   */
  function T get_exception(int unsigned idx);
    if (idx >= exceptions.size()) return null;
    return exceptions[idx];
  endfunction
  //----------------------------------------------------------------------------
  /**
   * Get the transaction exception factory object.
   */
  function T get_randomized_exception();
    return randomized_exception;
  endfunction
  //----------------------------------------------------------------------------
  /**
   * Method to add a single exception into our exception list. Insures that
   * 'num_exceptions' is updated properly.
   * @param exception The exception to be added.
   */
  extern virtual function void add_exception(T exception);
  //----------------------------------------------------------------------------
  /**
   * Method to add the exceptions in the provided exception list into our exception
   * list.
   * 
   * @param list_to_add Uses list_to_add.num_exceptions to see how many exceptions
   * are to be added and uses list_to_add.exceptions to get the actual exceptions.
   */
  extern virtual function void add_exceptions(svt_exception_list#(T) list_to_add);

  // ****************************************************************************
  // Base Class Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception_list base class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception_list base class fields.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in <i>diff</i>.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted.
   * Supports both RELEVANT and COMPLETE compares.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default `SVT_XVM(packer)
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default `SVT_XVM(packer)
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation
   * based on the non-static fields. All other kind values result in a return value
   * of 0.
   * 
   * @return Indicates how many bytes are required to pack this object.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the
   * operation.
   * 
   * @param offset Offset into bytes where the packing is to begin.
   * 
   * @param kind This int indicates the type of byte_pack being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the
   * number of packed bytes. All other kind values result in no change to the
   * buffer contents, and a return value of 0.
   * 
   * @return Indicates how many bytes were actually packed.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[],
                                                    input int unsigned offset = 0,
                                                    input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * 
   * @param offset Offset into bytes where the unpacking is to begin.
   * 
   * @param len Number of bytes to be unpacked.
   * 
   * @param kind This int indicates the type of byte_unpack being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the
   * number of unpacked bytes. All other kind values result in no change to the
   * exception contents, and a return value of 0.
   * 
   * @return Indicates how many bytes were actually unpacked.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[],
                                                      input int unsigned    offset = 0,
                                                      input int             len    = -1,
                                                      input int             kind   = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning
   * messages.
   * 
   * @param kind This int indicates the type of is_avalid check to attempt. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in verification that
   * the data members are all valid. All other kind values result in a return value
   * of 1.
   * 
   * @return Indicates function success (1) or failure (0).
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);


  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived
   * from this class. If the <b>prop_name</b> argument does not match a property of
   * the class, or if the <b>array_ix</b> argument is not zero and does not point
   * to a valid array element, this function returns '0'. Otherwise it returns '1',
   * with the value of the <b>prop_val</b> argument assigned to the value of the
   * specified property. However, If the property is a sub-object, a reference to
   * it is assigned to the <b>data_obj</b> (ref) argument. In that case, the
   * <b>prop_val</b> argument is meaningless. The component will then store the
   * data object reference in its temporary data object array, and return a handle
   * to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of its component. The command testbench code must then use <i>that</i> handle
   * to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val A <i>ref</i> argument used to return the current value of the
   * property, expressed as a 1024 bit quantity. When returning a string value each
   * character requires 8 bits so returned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @param data_obj If the property is not a sub-object, this argument is assigned
   * to <i>null</i>. If the property is a sub-object, a reference to it is assigned
   * to this (ref) argument. In that case, the <b>prop_val</b> argument is
   * meaningless. The component will then store the data object reference in its
   * temporary data object array, and return a handle to its location as the
   * <b>prop_val</b> argument of the <b>get_data_prop</b> task of its component.
   * The command testbench code must then use <i>that</i> handle to access the
   * properties of the sub-object.
   * 
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command code to
   * set the value of a single named property of a data class derived from this class.
   * This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the
   * <b>prop_name</b> argument does not match a property of the class, or it matches
   * a sub-object of the class, or if the <b>array_ix</b> argument is not zero and
   * does not point to a valid array element, this function returns '0'. Otherwise it
   * returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val The value to assign to the property, expressed as a 1024 bit
   * quantity. When assigning a string value each character requires 8 bits so
   * assigned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

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
   * This method is used to safely get the current number of exceptions. It basically
   * chooses the smaller of 'num_exceptions' and 'exceptions.size'. Note that this does
   * NOT check that the elements in the exceptions array are non-null.
   *
   * @return Number of exceptions
   */
  extern virtual function int safe_num_exceptions();

  //----------------------------------------------------------------------------
  /**
   * Populate the exceptions array to insure it is ready for randomization.
   */
  extern function void populate_exceptions();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
g+-e;_N42^a+O0YVfR#4c@9.4+g>UH9B62)^d4=53+A0M7L1)@OH0(L\:87S<DOd
W\b<4/6T=3:4QAHdRW^)RCHBdfcTfAP//<][+OQ-YgJ_?0AT,^T<SFPD;CgNTf5X
:RfU=1VU_Ad?cb1bBPe0FQZ_g<76g[<;MHKZI#ge>6J-[_[LRY\RB\COLWR)3a-5
(ZZ._Vf&9[N4DMgNN186G[,)JbX4/gQ6HR1DU>a;aK(YUb^CK3Z+b&:7X^1W4c=^
gFDX^7KW+Bc[-P>TDP1_e-UggRG;0;\1/5&<_U?D_KRN>BPc<MYZI\QAK>,P_E?X
&+2);A0cH<@YCcKS#SYXdg+=bLEgRMdK?I1/6(3(5@PWdFdLYfAa]F1eQ3:8;Y)S
VBa\<?B3T)2>)=@P.@WR=+K4#4^;]NQ&8\JT,/-<S5ZZA/;d3W=9f[F[;IEK5I4@
5WC@QTM[.S+1:ZdIGN\ZOZSRgFGbc;BJ_7Sa_&_G^EHaU6B.b/M?]\<SL@\KJ@Z;
R:WKg120?WYbdJ<Jb2<C,J\5b1NSJ;OBeQa(b9IPcZdVK_E6)(aH0.MZ;;VJVa,K
RKH^2Cc^;H?M\DN2R2f@,5a?5<IVOfG35d6O-)^U\@/&;/V-P_CP;>80aS62_-)A
RcM4+7c?2<-UdcGX-GANCFIUTdC3K(6AB-BY+KKZVL6;ZJG]aX<\L_33@O&4-/L;
V;8XWE^\d./C<g=Yg-L[BZK^Y6;G+eD+c:6NQ^_1(B,NPc+bg40cJNgOQFa/&7]X
K&2KS2P5Q_>O>PLe<X<6cMA\+_,S:>aV]R3b+90KAC^;Z0aTgE4D9G\J,NM;g1QP
f?Fe<OWWa69Sg0AOW/)I4^/]b<@@E8[CK<DO[^4R]L\/bQHb(c91P4?CWL_>3gC(
IeZWG(R_gC>eV)J-fcLR/H4J-aW0P-V6#M+4_[dT7+N_50/bLXI:D.@T6f=F2.1C
^I]0db2c#1g#Z9BI:YAcaY#XPD)VD<HQT?\bTcQ_g9-_>,9POFU>JGc+cV>V-?A^
^__V)>Sg@=Kg,a[X,Z1\gUE.42ace)>/:[cFRdba^O11>Q^Ie5]6-G>UR0N/RL<M
2A(5QFSXHF/Saa/SDAE++2Z>#PBX_+/FDTFC/ODP3Q=Ab3RND@,LW3+W^c6:NLIU
6(I4XU7IR\V,A@\7,Of]SfSY6;K[RdceYSUXU5(XD\4J@NG.VJ=[)+\DO>=#,-<Q
Cb+1DUWWSeRE]ZD<K1.?XLC0E1,NH:,0+,2+05:-7L&IfP(g@.>=>>B#@cIH>6I(
:Q<AgA^+bgd@\A)-@19T)PJ5;4\/=/WD-TV+HLJ9XMH\:52Tbb]^V[7;0T.PC:(B
4a-.?F&,HG>H)O;QM6W#E>Nb>2ZYaRMQTE64?JM\2R1^\g?BP@cb3C=28Ad59^Xg
8TFT_&YW#N8C1O0W_V+PCgHeee]BfCfgLa+Sd+OZBP\cVadIeHfN([[R>._g,JV+
PC0R]RdAF+<D<&>3Z66T.\I&E.cMGBX_(\DC;.^D(->W3].S-[eB/NdR0C4U9K<]
cd)[U4H[7(<f/(])_._/ENA;ADbS@H?eVK0]9@bb7U(.0R@N8@A]BA=S_G+<+^,4
=92)&gC50VY00;W-F<cB#C)PUSVEVgHM\5GD;f5HC)?99.QKQF[>@BQ-?>.H4=M.
7D..XfRI3S;28D+S8==+dDSGV>XYVKY/:9Z_Y#)P-HA@2[7UAOTIN-DeC0/a-:F0
V+PKRC<f.D<.O#e&C2-/YU@FK6U^\a1YI[->WC]OfbK&,:8g+YXW=0A&<JV(1<(O
\d]7Z?B?/-G9FOfB/=\IPCbcN4DJd.WRP3fGJdZ#A>NcP7:292SdPUV<1:Gf?N.W
VZ>)1AYAVS0<>Q?66<(f43^Ce^9E+bXM/2UH4+(f^a(&,7PL1(>96L0J,,1fRM_G
6<;\Qa[;#eE=)H.:@O7VC&VIR/11L8MWLS+-#DDO5O8FN>^]]TM=^cV5gG+c4JdC
V&R#T@UC+N08R30CJ;9##C<[<WRAA=eCL-d4,Uag3N,U7/Y@OT][7^1]77FIbP::
JO8d>aLV4:\Se]@ZfLDB2,YTCa+U@;3Z-b+ggaQ=YSR@=X1=:>#OE6P3NSK?94PZ
I-Uf5D>2dH&]e0g/ISI>6:KXDg8>.[)5G:GM4K5,>],+88#=QI0PV/JK#5]3^0U)
8)B)WMTWD9=AIMHT(Ua7<UR(<V_<5/gf\0WJMMS2._]gE;<Nb2Z[QdHZ(AMFL9?8
d^0SXc+[AX?MB:X2<N5C8_KPO2d(@Z@Ub_eF.W=ABL:F6KO4.;4-Aa)DW&Udc&Ne
V>_/aFERe<:Q3^A>[)UK0D+R5RFEKT.=g_[[f1S^_:ZH&Jfe>5:E]/5g(U5S.55e
FA@D21ARVd_,KN]\/YSdQRQ/c/#S#/#0;A\]g2DIg1>O+1d,S@:JP,N-CLEETZAN
-0G578ORAa4HDK6V1ZW,8^93SW<c0Pde<-)WJCES&OOf4RV\&X6(H7M98g9JR=7+
4)[0PH(3Y6K_O^Q2WI?/@\e;@15A-Z3dIZ#F?gF)8YL>I9AYAOE+K1gPcDM(XTI@
LJQ1M7IfPcCDJ-U6.eN,)g73)?:6&6(^IS&;8@3[7>J9X=Y4GQ/UIHSae9F/+d46
20^1[We+9VD?3=]^QE-4deJ.\Sc9CZg7M&OR/gNdP+bJTB_]9SgE3;KM1#=_KA)0
DLD4b4XMZ9f9A^RcX2VNX1HZS0N?<@C[:)eI63;/23DHA]]1TP\BF0H#fH+X24,2
3N]YEc>>KG0GRYWA=@MT\QLWIfS[eW7TG[7>:D,f,)F5=\R4-SXM+SYTb9G.-^-/
70EYYZL[EVg7L^CGF@[BWX:>TZfTX_SHKF6(I,:5:M>?eF.>d=BdW3BI;E\cS+f9
&DGWS/]E<,,INT&0,?-2@,5FKaH@(8&(0Za?>A\<c;1M-9.YZ4NLYE0GA5[V<aC/
<;TF2+JHQS5E(L0)M#6<M0d]A#2^1?2/LC/G\N0I)^]VVfQgZ1W<;BUObf)g9=2)
5@#(=?6R9FP?4fX61MAOYJH@2V#[E-&C>G([ZT0,CA;d7E)MBA(4B4<;YVdF9&ZM
[KNRJB&gBAR;JKH_PPY8,8cI@>\S[5IR-bcCTJ)+7BLM?4P7<0,TH7MR0PLdFfR^
a[YH+,=O(@^YCdFMO1fbXW0(3=B?U)J6eGH[9T@7#J/D.Kf@37W60<_8JPc4d,[:
H5fD/Dc:e1F1b;_B;gX[eN[/,S>[D>a)^Z5]6)Z,)PIR:D.a4.^^\a.>fIMY8--3
H=S3[D[B^E8eB.X.J^T+D70ageeRWNT+c9/KCd,L=S-^ZVb=3GK.M3bH8+DMZ)S&
g.B-RRVAf]B&a>:Bf1223#g3WG,Q-Y^>OI@dKR@/Z^J,93)#2HU]UMK15QX4H?>L
^[T0;bJeL?,#g&c/A2+-V,M2W:1(FGgLg[@\Z:W^O^b=_NW+T=E+<ff9>eNcB#^&
9[J3dHO:BCK-_f+^+NLJ7Y6,/E06OA,1@LbJ@NfS]6:G.U[+ge^QF)I:\c]5RA3A
.A)dZ_a]>2dO\eHLS2ZfS+6,Pb?/f&8#966.S1eLE,dVYV_1C<3VcQ=AKa6+EH48
XVbK?aJ0HMLD9[A=E,I:9+3=]?@7.=^/5)IbLaY)0a9?>0O7-(OEA8f>cB16cD:.
_M1SH-&WOFG@JOUDILX]0IB\KWf]1ad^S\6P)17C?<>(Ub];LTVI-]?(D[(E8dT,
3U)b3(P@3CG^C#V;E&7G]+U=@53gF@Ae1CNfc^\JCf<bY\C]3b=9NBa)B?cdK>e(
?EP&cGT.91aL7>dc\=_g7B,g1AU0F639L@0\HAC&gYI>9]RdG)+Sa/O1Z7X#:#:_
^[b&I<=b#HM_WZB3GRT_0=H107A?635eK-;Y44Lga&K:^;g<@@LdA[;W2)COJF)[
1]3:bEf?<1U2S6Z_N28O84J.QD,@eES7U/+DECD)XM^)93abK2abg9]\9.7eIZ32
OH,+;b#EXG;OJ32X(4e.g]E63f2fT8QXYY5+WQ13b59;ZfZ3P,R.7(P)EEN75-,R
D?/4R(EO^dJZE]fTKB=4K3bT/S4=0Q#O@DH5):MJ8SEbP:H;@YB[FV[=?f6:49bd
QM--09O9\HXUC/D4INaZ:(29_,Z>=?bC=\M#I\/d2@[]fWLCXK^]]YSPCL#SEf;-
J>N(cZ-0D(E5C<3f@W?\\98>J2CZ/JeXW4S_.^De/J@a0<<AN-(\3+@Sd74AL/N9
QF.T+XA\#0DHVgEW@3&AbEJ7]4R.,WcW>(OMHV,b801O=KU.K:;30\aTDDFKeNL[
PT^\>R.364G;H(>aRH/WV1OI?+12+1[eQ1.9K/Y&dHB^YK(cQaf39?^/CQg_?_.U
0HZP0XNSV6]WPJLE#-,9cK#]ZW03N2ZPKg3:;8EMa7NXS7GI=1f\JX#B>?dKedT,
>QLB21QPfb0A_W-@D5Q]:>,IbDfH<DDYgT^FA8LI)Y_N(&#/7#-^TdX@26OV(-=G
_=[LT6C)SKC:\HZTLXV2?P3=VA#bUUL^PK5a+J<M04;6+=H:]2FOQIGGI=.T8+VS
#\^aTaU)UE4=4;ReNDKC+I1,=4]W+=JZAf;0(/WKXK@E<g:Sa5<@89B<JN;ZKEVK
bE8\FL@)__];E8CaaOYA<<R;S:8=C35O[G:>F:BL1A+)]:a/b=\;RK<&@:(g=B2A
5\>F&@OFS)S+7Iag.WeY\Z6+]],3AK\=f-OgA2MQ7g^&JZW,9>RM=)#Gb;L=SSCd
O)R?+_);8OFQX/2.LW,A+e3H7&f4ZAL/^fWDe(J+::QdHJ5EGN5O+9cCKH7E6K)[
^?2aUIDY2/^01OV#g+_]JZ.6LW>YF=GFET[0b@3H0,1dHfe42Z(>OG8g_I+D,Da_
DZG;T5<IN);\(aIMbMJA_d=EP.2L:ae=e\Z?SJU9</e1=8f^JC1A\bL]MgB?X-PT
?4M^(QY->)HZYfb+L2,YgPGScgTB_e>dX:VZ4/@C0,/S]g@X;T+M,.fc();7C=4Y
.+#P)_X^&O+[A=HHW.>W]#5QDd#4X&RcHT9U&)XJQA4Ta1I>7,fHb_E<(><MY<:?
_>g(Ld3?gH?cbE^P+.H3\;<C22&?-K-.I?BKgP2^[aBCg;3Tf:/5G[1P#:9T)eTB
4/De3AeN7.G]2d4RK7TE5E9D;Qc,B1H(H(W:A,Z.+;fP;+B2ZI5+>gZ&N<L:<>A:
g#HNbOYQP/-g4\I7LJ,K[&:ZH7JQ6[CCDJ1@3#\WSZ1H:aM8JDQe8^#.@C21fg1E
D<a8]JYSFLHeS:C\40AT]Ba\>WTeLP@@6[S;G?5Z+[<#@SIJJSW0?06a_72#M:IA
A,P@D3ecEc>US3Rd3,9M>6O6M8==E^L<#2:gQ;G:63ANX=-)]&#)S>\@LNLD7<N:
D9d522Bd2/UH?)IFEH9YE3/^OQ1M@G#@GfK<I2:FEBMG[\+eHc\9K,=UPTba^O^\
_GMR38f-845O@I\CAR7Ad/<AJSb(B3D:S#9_57cSUg>AK6HJaHHN-U3V?(JC<YLf
/+?N7?C/6)OC=RgN9ZW(G2B+&c]N\()E-;d<FaR:BeY2N_XMd-+;g2L#WgeP>SYS
g]g6+9dRS/VH/LFH.ec,6]I_;XeC5Igg:EODQJZV7OMd=b0VFIaX6SF->XHc:6#=
eVeG?&JXYLE1LF6UAc_8HE>DcHfATe=.H4)QN4c_(dW#;H-0U@#LPg:B-ac>e7(Z
AOaZ,=;Zf;gbDT[]MB0[3[O>C><#@eZ8P]TH[9gP-B7a+4a6TJ#g,Na,=T-d4[9Z
.#\83FOc77\II@5dVeb]72B#Xd-:B@>.CQ<_d&1A8XbU.CWfL\;(JW)2-bf;BM:0
Q>D+Q:,0&)N@>U13Y<gPbPacFF=^=U=M]._X.[92M1fGM@&K3bgG^3.?GECIPP](
Y>#2_3&Q=>;CIAX9=/#/>:DM@9C.(=;>Z_KX;I/&,VR0(G;gC(0=OY#T@TF\-<KV
>K@6?@0XWY;X6;Xa6B<?Y=,4]4P/:JH=NGE(2WUH2TJ2;)#Y_PdN)Q6ZEG9H^\C8
gdH/?Z>TTI)d^(?#M.;QQ;O9g?cVX?D,S&V8Df#GM2-4_4C.c-B#DfZ/7/dB,O1D
A;#=dOF)ccP<<4cPSYK)Y(.Y<9a?9;bf3SEJ/PH+aGg[:@\1AX1Q4#=-:4gS/P?S
;a#7LE5Z,TIZ(bf4e=T]U,/D^f?d5)WVE\AIH-,-fGJgQX)A+([_?E8B>#I#RP17
9I;Ea,[=LEO+_9cYe[VXJ>4KI-McBFZ@dJgd(7QONeI4I?\]@#X5<B:#Z@eI.TIM
ZK7[X[[V0Nf1@<N8ELQ-IZ<<bN-@[V_7-g@#Z13c-e@&=9>R96KWfc>7^L6+QJ4f
Uc2+>E_0_PId&LOX.]FG;<)8Ld>g1Xg9TT=b+dO205VfC77E<O0CHOK7W9K9Hb[a
f:/VCfWGGMI\V^Z<G8#_C5\Y9VU[cI>)8GI>GUWOPRPB@FA[:@Q,PT;2c]aW@c<H
3_-G6:/UZKJX37420(174-@eNPZ?Zf=<QId=I0,cC]85\fV:<RAG>HF_d\STb:HM
#<d;RN1)^K6@QCTC1^EM#b(UXY/592Z14L/&6T#CA0FH3<=3+48(9DHOX#,2>,a7
8KBSCD3a]_3A\F?1LFf08A1QWa/f+6Cd_^JT,W6)3Jf?8X5I/3^X/V;K=BG41Rc)
-?B/[&LJ/8OD^E3Pf:<)HcM^[Ja)RO.Da;TG+?WI;Q5eXN<D7E9S#@fa2,=R(<9_
\:cSXHc@bcI[0@/BP;5gE&&cEL\&QggX]/+@98]#JR_:9b#1[ZWK3K#NK5Q&=6(4
^866N6-P;OWQ)-PCe?/M,4^10g(#,Xb<RFTN(]@[d<^?=BSgL=(a&WE4;=Z2X?37
^)I1]7\W<RBR.F(QIWE_cD(fM_8B2D-UfZ@I)a?D-SRC^MK>9J4JEa>T.WZfdC7)
B@cc4-=[:]=Qf5?V2?g1G\QNd_E9<5Ed1F0+++#SGg<+9[PL=##?T0YXfTD?JH9[
eR(0XKSHfY<_2V>,:/MEB1Z:#2&[F,6.J3^/a<N)_,0[f(UE2M>[NZ2KE@PJ_\6D
Y\-_6M@8_#[dcIEJ_b_)O+LHG5G_1&&^J;S<L8daGXSfV,,KQ?NC/T:=Xa>Xg1UA
KFZPYQGB/=;1K1F:#N&BP\YWA;5@?HV<UE[NFg9(bP-?V@-_>\6M6:OJIg-FES>6
XCI27/X]KO#(ReWgC23FCVc0NQgWc5=VP2KRL1g\4)J/]@S0)GS922,]-\J<cQ<A
KM(4BJd^LP?]:>Z_0Z9L6I1dFXH&<6\UP9T-UcE=L\g&5761_C<V7Z&2+E,fK?fc
I0[)8>IPCUHG9J6dTLPGXT;E=R],&deXNBK5MTZ+N)OUA5NS_5#X4.4GMI2+5W[S
a,a:.FY/X?a7C63C+SW1YC,[Q,gW96#_E.?\C)BUKe?#-NNE:B]]RRF]\]F6)8Q8
=9fW([98--WgG&3S1?3&A(=TEROBG-AJFYC_,1YLa7ZG^]RdDVc_](NM?81[@UG5
J0:KB@-V2RYEcgO/H3>F59NfAI+&-WA08ZH>]5==2]4E+B^3@I1R&8>F]SA+2YGM
?)@FJfYMA.D0[7>G@,2:&O:R?Rf-fPGAf_1RQHLF.)):NW;9E>>@2=XGJU.8SYJC
)gf+U]_Ed.eFUJ5/gG=1aXFeXKB],>3AQ:K-\+<@24)<-U(X;E=B)13[c8N7AFAU
SP]S_bMDOe6,f_1>^f.3?/PDF<ZR6,4K_+/]a<PLHFRDbdNN;_)CSI&\QZgG#IQ:
)bQ>U_eOSGX=8gN(Qf73H_&-&eVQ?92,[^c25)BYF^MY0>X02=43>RL7KU\D2G^7
KMC=R6faeQX5f?:Q[ZL=L;E[>.T2D4NHN2fMNM45M_)VU21)eNHEB+S8,M(,]M0N
\(3V/.7K5N9E7S_W=/>.D]O^/E\=OEWgH/R&NNYJ@B/5DA0[GFWSZ4G<)@LVa3)H
M^=+XVB@);=^13?(KASc]:1E?#C,_g_DGY3<0YWL5(U,#KKW=[.&+AGSYB47.X2L
:#BR33//[=E.0Q##&0SUM:E0YGPR@-[4,\,&R:UX:X&.@@3W76OY7+W5Q:,K_b@O
ZbGQD5)9ZQ7gPW[3[WDBP)[73=2)B17<;O??dg4]C?e5JIPF47)?OOA_45aA[^bR
&M#HU^&6K6UO\GLfJ[e[^OD30C=:1Z&<O);^HBAIZ5]/DVaN&H<E#E>H<B@-C/GG
b(.F)H+[)9Yb)NJZD1(9==IZ.?;^X[@L(.KbJc<UYZa?>[#GJ=H-,/(aQ-XY<fIW
&E#[\0:T7gZ#BfeE.C-ILDePDK2#BI@gVQIg.(.GS:LS:B3\/)6F&1MUUA+:L&d0
+D,-Ab8J5E/BCdCeOA0)S1[3L7^@A_B/6:6,HZ\0g)Jd?-SGWeTE[>MAK@]R7M1#
I=\89<0P3b<:E_)_@-K7(;W]0AWWIA--H\UeK4ZXg,bV4\0]<8B]4YUHAYR)CeAG
\6=J;7,#99/704YNCg/ZPO@UP>^J/NSQ:FC3aF<IT;/7:A7QG2d\R8JK>\Q^P7S(
<5X,-3eFg]b@Je,1U=NP85AQOGdJ:RdEM7=Bd1?A<Ee1Q[/E:5,8.eNXS.#ERR1:
&,2KVcQM5]:8OU>dJe?B<PD0D)U[b1/1+DQLB3e+Hd,a@B-5/gEVC6_6Yg)e#X_;
Jage:GfMW]C5&6:KT2J0<7Ve5;R.0Q>^cd&;<)JZOK5AF/NZ^-7)a=PST_])cGTN
FL^&Q]KCN((F.RJOPDebfY>=dV\PEDACW:P2Eg&VD4IZ1cXX=NTbJ@1SB0a.eY4P
QI:+&DO0=.,OQF\U3+C(H@1)N,eQbb3RBBE/)gP7];:5N:T+5gA-7KAaWHGF1Y@g
KQ6aBVa&^N^V+UbL3#d6;b9.GI3TfXZ7J.g<dJ36QWN.H[DHe-W^UMBZL+[R<N.V
@>+bCddF_IAR(296^D9WG4<5-4<RH,=&=0SFUG)TDSQ_eVX]WCMIga4[W/T;C5e2
E<JP_DAR11_1>C>AAZ&/X[4TD\g,.dO],c)bgMaO5623gS<TOF@9Z@^X4J()/22-
M;YB2.](Ic,G^OMOAbReO>#UEfK7P/#<@bF.,7ZS-/B@M6S)LHgX4V^88b#A0T+8
4HCM<7ca,G.?Q&PMC?RK@?/X?V/Q\QB45^NNHW<GMT.Z@4@I&\&/AOdJZGW_c2:g
:SG_U,<SDP43S6d7C<AJ2,I?SK7J@Q]@g_O@]ZXEM_cQEcLCP/aD>M7E)Df0Ee0g
?SUQ:.:X[Z92I?5SNG4X0fGY)&O&e5+=YM:(&3=>LEQA-DO^HQ@AZS[^fVU,9^66
.]NKIN43Q=QBE6C1:,Sg3COU:9KK^9<L1S[1>P)Re_F6,?S29D.P6,]_06VY2NZd
^g7g873^B\\41H>N^.7=^gB/2H@K3[DcV17C<;b?(57)B:dfd9>dBYWHZ_V4BRUJ
?5&P@.81cTDI..,E3d&X^H1A#MJ^;R-HT.#AB</(ebd-W/U+0,STR7Og4Z1VYbW:
L(-e>C__<X3TL7HO&2-aHgFc4OXedXLSW[LF:;X[eVM>AGbOL.Obb<&?e83FZeG?
SZ=4Z^:-41M#:G/52a;5M2GU0?[_-_?;_(ce69RZN,_2B;@3Ydcg2Yfe@E6gG=@:
XT4U2.OVI-.+#Y3][-;cN8a-0N;#=OHSE^2@gNZ_MYX]#PSR[Q>.@?cD\<1U27C6
XeRVVVSO\(:P2.OT4++fcgcfCPaL5OGDMTV6O&gAY>>1AP]T]TLQPIZ9(dbLaI^A
7e9E_A96NC6,G_S\Ng)#ccb(bQ;O3V9HPAG?1/AS:\\EcC):PCTFc-PG)>Zb2fE6
K.@2-F3QV4EKe5]d00Q30)EY/2#?7O)-I<;RUKLZ:fFV[?=^Ge2QG+XcSfD=9)D:
UaOCQ\,Y^IM3=(&e0DDUBRQA]DRDa1Gg&SDO7HcE\2YH&LOcD0#WMH5F;D5E@=X(
-f]MFJBS8DBd@;;=Q+O[N5P_6]CH4>^):^N7VM]A;1-XDE9Kg;c[cCXBDTbS,)e)
\YV:S]EN_O9B;W6L:N#A]+g<WQ3Q<Z[-F5K_6(Ib//P);H4&Y(Ga16N.,[VW5_:=
/L=H]gZ7@/[VW5KQ6X/e\8e\Y.S&e<@03CA5_[\cE0<P-\Sc\A2<RcN/bFKA1;++
f.[=>A<d<(4]>1fJZgY(_FMWQG2SKARbVZ.OYRDJ-T\HKZHRB9fMM6KKJFaOY+,G
L=HJ6#S&ZT/P7B/_3/Y40E)PfDM5dR-HSG6\ZZ=+,G/8dI5BM6CSf+7^@?g:-GQ9
Bg85JY#Ve7^</XgD;/5FCDV08&-VZGR-8gHf16=f3)VSd#F[S3_bX>\7cHEDMLSI
0cUV[(-XITA#4)Q/Q,+?b-b/+d,IS[I&@^R5Z@5@DYc_D6E^O(:JXbD1&Qb1YAg8
W(>E&(?3^KW:.@_GB1-W1_3,f;^,5Z6a2RML8?/&US:)=L]b^V+M#Jdc7]eD&\NR
8E;cQ#TJ>\1CXLag3Se<D+)a(GL#fX_Q&g]1]V@]\S<C/Re,Hd,7?>e::5GG7?<5
&OZ##M)=He1=+5Ac,R3J_L=b8]DG?J;-L&g)7WQ;b<J/FX?f+e2?YCA&L^\\/O6:
8SII>>C2Ngf:LPec-6:LY-(2[1?X8?)C?8L9U+8A;/fJFZ?]UJ95Y8J.6=8FLH.@
GJ@0(XMFLP-WM:E@6N4/Vc]:5,?QV-4W:<K+9;ECB)C5-1WV?,H4TeF1[[S/.):6
UP?BLO:U=V],((YQc&8<JX\SB:=>.^IPQA?&0ReG0@eEKNE5bgM0^1McA/?LNd81
F1;3dfgcMbSa(+A@dHF8KNFKdaeab(D=M84UK2K<DcIWT98M>(@J5DR6+M(.E-9T
]^Z2>@_cUf0LLY21>gOeCFL+&Cb]T8>\H)JeHI<)UaN^G;+39g?+,4HVUG/;D\+K
5\+J#K3QSA3;+<#G)I12X@LL2Z:7P;;fND=S=9O5La;4dRDAa&ZZEME@W;I/JL3c
eeTcQ8fNJQI-K.\d):OP=)VE&N;5M_gGRG43S,)4,<PAOUH\YCRFS<AV&)AM7:US
3B.(+9D[GT074ZM[I980BSb]1BK8X?9,,fYf<HK;MZI@N;AYJPHYb),ROO:MV_QP
-#3.V_/0D1;5ec(H<5D&&>d#-[(:55a>C7#<,7INOOX=9ZS/W]?JGQNSf3[MN/J^
-I?V,d.VC.9FaLS5F^3eIR;&L5Q2cf&=>6?#?H[OW^N_9X1601B.U/I/[W<Y]We:
cdVK[D]16)YFU1f>&2LdB2.(WU5NU(BQ(aO0+[YIgHWEKP6dDbcTWXLQc[^UCQ#6
EWORMC.ag611WT[b4)MG&V&5F;=Y1RM6;;Y3IaP.P1T,Hd6QKDKCKc?9I_]@<)>&
UICV8C0S?I)F1P.1I9MdgEdQ6?35MT)XYQ?J6LYX<+>@MRH?VINYTgFK](7=T.N7
fSKd[Q77)KZBS/CHS@,SHX^C^2_\3E0MC4g&I8b.=<7FE>K>:MIV>04>&L3G:<]S
)3PB>A;WHD#+KcWW+[IXYde(NbY;B#5M([_9Gd<g9d0:fW820CbK[T70WX=LagWM
QER]W?=<d2a.RYMR0:N?4\1=/XU,H[[VCW]bR6WX:OZ1&+G29I-DM/a7-JVT\YcG
8RHZC_ZWTUaH^[\g0/Ua]X_4A78CbFW4:L,U-<7GE6cWQ[-PB\O4)>8K+TB^+XF@
aL1e.g,9L2FIEBEQ8];NVS0#PDVXFOX3>QD_9-<dDIUO))@E<PH>K11UAKL(:ZP-
\W-T=47L9f;8.0##=C\bPJ.K.<WER.B9NVR@=;LcP7^W.5R&Y62N]C+8.XcJ)<ZN
?EW:7@>\g8A/QgHO1DUg2gMS06)S.c;U-^@2R4Tf@X5;03C[AB^QGJ=3G[AQ:_bc
((5e1H:>Gd,(7//f?g^L(&b8OH]@D^&?Fd6c6Z+2=MG<Tbd7EOO=P:e7&+5bMBeO
Vd<d3V4f_>&,P@SVU>NG=44:5E]+JG_^#I2\CA\N4;W.RNN#gAZXT:,97f^BVJ-;
ZOVJ.Ha--A/FM#Q/:7QRLR_]CA)-4RO4[TgG-#4^DLR]-B4Y2=&2DA5P=Cg24)]+
_,9.^\TS]@#Fd8L4A]OSR7?Z&+65)(bgM)(-)VL-0,+?>424T5@JW[1L.aIbR:=+
QU:@=SQaCe03PHA_J0BO^+09B6:_RXIPPWY7aL51BVW\NOMag-#E9aCTOeO>2[6G
F4VCYGbg@d73eZ5JSaTGaBKOYFW5a6NdaE)3H^QN:])7U(:gC8EDJ-<Q\:ZW^Paa
Gg]X0JA/F95NCK0=;dB,bDXQ)HB.LI4-b[PEI2]I>#[>7T5-Ha:,5@#A((5=:^6W
9XOgL&DC0?2<S9ee0NCTJG@OEO9[6,P0>GV6F+e\^cYM;UDSPS3HME.bL[@LGNB@
g\KM22.LKN2+-P9OB08+-5^)CfL;7VQBOGLYCb&Pc@?(bIf(4NBC.DSbG/5Q#90-
--VW5aWL_G1>-VX+=,T#Cc1]ZVLEC6[6BcYP[+PE7R_bcJ7?^6@84?HL7+/.<dIc
NM7[WHT^4S5]?a^@<ESJE-=[,SWYRMa\>VX@0XQYP0NXC@&\7f-M^6RX=+GB_:fY
af#7\3g2ge[#e<7K/f)Y(QP@]^IBP_PM>ABEY2AE/J;A-<A?c@HbY/A>M24AK+VL
c),^]:f&&\@F#V@=L][T.<?6<Z(Q&+?.>7d++=W;(ED5dGG\Zc>E6_BV7V;_4Y;A
5R.@28/1LI@34A-LC8<(1Q=VX/S:G7]4\eE?caM=\D2<RfPHD;S9O-4LUBEB/eIG
c-@[BZ2#]aUPWSL_gE[\Q]e#.K)_UGZW&,O[)Yb:gTY)g)(>K8eTLS^;RO1\c<:Q
FH@[QL/Z-6N\O\dO,VL-,aHKYDQLET)W1G5a36e.H6W<F295b5b59X^\6WT5S+b>
O4FD=a[1(9/g]68<L8Y-d&.)-S&&EdF5@aVT8-+Rc>>[J]PC5<+_JW_;e<ad>9CR
_B4I.eV,eZHLIQ>cY.4@4O+O?A@UN52\3fFU;AB1.Y&cOFAI);,fI4@Q2]>1W1db
[E,U5YB=+\fU.@Ee4,2\X[-&d&cS=g2K?6/81FYGMXeH9^XZWEbD&F#[(VQ.8,EN
AN^M#R?KZ3VX&3g\DK-(]/8Q?-,4:8c3aD,(OZa.\>Rb/g&H169S:@#Qc#SA6AXQ
Q26Ve;70d.J-O[\E<bP>:61;\A18.e;Y6f7WRU_3T6Y(gRDD>C8?F&fSHY02GZ>T
L#IE3AWQ:];5NeG1^YU<gAE_44LdC][;N<c0JANeK5C2aT1O\g3=:=8#R[G-JFaP
/?4^Vc@Mg]F)7GWR5]<#VV#c<=eDB,X6ZS1U--^dWYQWQB>MTI::&#6J\2SfP1c3
&45DXN^UXSe4N:&-R=IVB[67b+Rbd<NgD(CCb;1.cA7a):Y>6JPGXX^aZ.2E\A#Z
#^O^\f^^f<T<]f]E?Pd1<;Xf;eVcZWZVBLRG/N#W9,MBHCQ,GL/N;g^.0N1c]=Sc
:_7V1]B1M?T]KXT96TI,@I7gUg7<.P9RZF8-YFC^a-9W(fMR5\#c>G6=K]N6^F/R
c4/E,-0W0GePL/H=IO5KZRZV81/]b\HcE_&PR^g/[<5W-;.KL-)6A4GL><ZR8[GS
XcB5<T>Ia<CcT1fb24>PU..c8C94a)e?C^.-\C]c::ALZ2gFdM/<8^Y_eH;<]][b
G5:Kc-:7F:HT1<=-@[_g?d+&K@;gg35N7dLLC,cYeATQ?B6(c00V-F&[)Re)(.[V
)T&(J45YHUL26IS8AP23O080E,#B=0YM86aU/L+](A?KK/F]>=1Y4?I?MD?3FKC#
\C>Ke/I?W#TgTIMW#7?,#3eB8P_K/11:P7D_I.IcKc<<^^=AFF&8.2dUPGbV8C,^
75<&S60F^bbaZNQPD;c,VZ4NL)c-f@__+=Z<X1eK6FY@2XE2W4L7G<+b6N=4P?Z,
McRNMZ77Tdd-I8RWgC[]8RC/:C6?C2?MM4VKWM00ZF.b2ZTT1dbDSCO+HK;gfS12
3V=A<5Tg.5R+BDb?[78Q,VJAZb]I.fQQXR8=63VNe9[^12YEgQSdBX^@Q0HgKRIb
@>HKKeU<8d_]I7@6NdMFO&^bO&,J>C^WeH8::AR)g<VT[&DH,A;7YWNK;2FX&<JK
A5/#2IdSF91a_W0F+I8N7&6YK^KJ&8OYcUF5JQ<EHT_7NN#HP>/5ScD&W>6?LGS2
A;]L)g)F6]O7H-5GcX):cY(EFXgF:]YAdVW69/<A]MaeON?#D+.E+U3C3_aRYPWE
2/_=1E5-=S^4=-[2\2K6OA1bXfaHO5MgGT(/=OAXCZ8@UdK0NY&@>g@=)]:ReJ>W
0_<>b,)L@0^Ic2#JJQbND9>I-gZH;Q/>Y[X[3_P+(IUX]]Oc=3MJFTE(/1.B#WAP
H6<&-QFfOTP9IZe0dLceB0Y,Y+&1HG3&(_fR@Mb7Zcb;]@8,LH<.R#4_U9X(NMeA
@/=bC\=RfY<O.=VbER2H;DLXV;9aSR-LLa>&XTaUN\^=\4bF7X2d16:S8<K:?:MT
eOJ1&THS;:3K9?QJ&[TFd<:&/<R@72R<H_U^WYW5bPAa&(:<STJ;M:d5fLa&5;^g
=]P.KE]R+;.fVB#eN##APZ^dLZ9TC]4CZL?(A)&Oc0BbS0eN-Xb?D,T&IggQMGT:
X]QIH/3-8^GFe)28SHUBBWUVf>THQK2FQDZ<WBQCCWF2F1UI^:HN<.9/;2\1f&:M
ZS?CQV5aLKgX.=YA58MeL\,[XMOa_gRVFWSGQ^)YOT=X=JF@W,@OFIc-,<F]bQ-^
F;A3]T^,eO?dFc?+<IgPEL@/?8,Q:B3:C:N4eS/d;d-U>#Aa_M_8H6I3=4M/4]SF
<eIIc=]aMU09/_^[>?Ng<a^22e5Z,QT<R.IcJ5D#C[XbI(7#dMIV&@ffgeB&ZC6b
BLOZ^;,7B]&\82965^&2HR/#&[&FUBM_8V^+[TRY[RB8O6CHe86CI37>aO)I=2:S
LYZCW&Yf5T8c53&RPfG@F?&CaWXJ,)2aR?V6I76-]SWg9d[f4[0[+6(F7-QBeQcV
SIXZX+BR(@>>3IfKI@0c/\d))KG,OLc4OYcCL_d>/;CT9,0b+?[+7?=^:b]RW2@<
B(.=NLJP</_->d)\.ZT7OZZ#H93CQ(-4\O+b[/[D/X@O(K(#_GMc(e#(D4g[Z]3&
g)@39CKD+[3T]K89B;bO:6G7^NKNW5,;3SIf&-(bbUYXU&_d(1L?,XP_cDO3KYdU
0F.-@+ZbUT.7]/&<gY>4V6:J@5Qc_\4?I(GX/B]LDeEXI&B/EDAEGBgLT/<O:NJG
Re5Og]6KL=A4aGbNH4&OW+eA>eG\PF1=B#=8(+];_L=S1P(/1<b.0V/7/H;a1SbG
2aQPS0M[E/?Wc6)94Ja]7VC6#()>\S-/SW&0;C)2JcF^K7f?I,+C#N(:Jb-P3WDe
Wg)g4HPSKHJBN;Yg,)/=8bMFc#856g7\c[[A?OdCI#]Y>O.,+3G9.[LMP6@5@1)>
#E(QK9??=.C,-R2H]bE](H,M(^LKRSHc-8b@(U]/2N6Ye1\-_E&f]cPdT1/&>066
7EH<0J#M;PPV8DV;\W#XEH?UPCLSZXb_@I[.Q0R;8>e[/Ub2-P3=484UGX9YN7E6
N#bdcS+\6#96XJ<;YaCT3e9D8?5gPM,U/@6^F>GbcF<W,+c2d81F(TW+##fa@eeA
d4CP1b)dCYCKO6JC>LY:TA8Ac2:[E^JY4;f=G=e-\54.4[AA,W4<+7C0:C?9.3N=
4+<bKL2O0MW=Y,0]WVg4-&a4)M:L#?A=S\_6(+e.&0S/;_@RCG.3fXI60AdPGBL;
\10-D/BJF[Se#]7,6^]FYQ@Q=b,P7Ea&Y;Q+b.@3AWKF2X,_Fg#AHD)P,5U+YWJ7
R>IS3,;b1_,D]I;fMe2T[+AS_R5XQJg2XV8F;9I5?_9/:8#RD]+XUQ86ZV5ZR7:Z
(PO\+A;.8K:Q+5MS&#KGOaTQZPB^\[\E@,FX+/.<Z0:V\G_K^e6I1]L-7)Y\beK2
LcTd^L,=](J7AU4K+?IGA]-ZaC8?Y/\>2B3e-:Q8>WR)bW_XPHFaR)]K&W4]&-J[
]^,b8>F3bOQI?1G&FTP11Jb<7D@(<\2>Z\,^EYV+.eY46U4?KB1Q<Y@L6@dXNP;_
0faS<.26gTIW^PJH)dMVUP31gg@c\\K<EWEagU1]=-fNGd__QT)3::09Q&KH)F+^
O7HG(+9A)2-I80NVSY<G>-;\<<R5V>.2\2#PT\DaYb8d)WJXTBDeU@26F;f-9IZ?
LSL++#^b]ONL\<(DKVF6.VA,7>PPGQY5[>B+]AQF<879E5Se(70Sa@JS-@d9=)1f
@_=?TccU.F#-b7C[]@[-(/)3#=1[)+@Ub?\IgeOBT^13?N4Q9[SCEP&=&YRFHMM>
@SN3@IA1g1TOR1>ZPK.BDA\DPO]28<+DGe+E4B)<#+F\\L-83cD?SE(GAJ3;0C(M
[V?(fBQa6;8fSLX4CTe1EbdgIXC0c;F);YB[:D/=@;XS>>C:WeH?_BfH9QU8/VTV
DM@:4U+0aO,eH>SJJ9+T0#@XAVL,CFKY-0V0G<3YU0N1Y<W;W/H8b_\?,cH_=_2P
38)eT<e+1OLKI<NL2WaPECT:bRSVR=g40HR(<VD\76?1@,e@(UDg-AZf^:\40d71
X/5>-P^)2(Y4T500F0@=:X/ZME4U/?Kf=d3@GZgZPX:Sb]cV]dXF1dZ.D;W24cfW
PK_<Z)-J66gYP8>._<fP)dP#(b8C4IJS.Oc1cV/U(N/bGEDL<:SRKbT#3Y8Bdc),
-1OY>OT]cV6IE?\gU-R8D>NfJ)V,BgbS4>egHE,1U6>^CgB?;?7IBQPU=>,^W2A7
1LNb=_UcJZ0[I8+g2[RNP7<f<A3<5^E4R;dZ5PAI8Sg?gF)N67G<3aUVN>Jd?]IJ
b::?e[EZ5BG6EH(JDZ[#Bc1U-/a8_5dSKMFFD=WbL#ZI&EeJc/PPEV&Se7E=J;F8
--A?J5O,;YIA;-#I8N5f3NF=.WCY8R,DS+K#H8_M/7Q=?E6HI]?A\FET/RPM^fe#
3F+1aV7AA\gTWB7^5OKgca?RD+AF>(OIAVT15dJ\5D^aH=C<M)2M&U(G7F6c/?fF
Z1/_WdH5(=M6.(OAc\7ea@^TEU]Ae)DO(dR/K)_:gP0TG,JN.X1.aK2<M46P9W_3
^C8@3gFYd>UFM.QNAAfLAV=a#2>W&/>IMO2J4I9?NdaV.>_ZEde+._W#(,W>#Z)E
cFYc\I3#P5d1&I))?^_;_g013SP231gcf_&WD:5HY<2,b6T7N[2,8bJI37BRKK2X
f&,Qd0A5Q6ND?=@GfAYG>QV<JCNNg_gG(F:@;#T6cH-Re9643&WMF?##gXZ50A2)
G^PSE4XYe#9D2,R)&A0I53gC_R>PCU20ZP6BZ<VP/H_JdVNgf99/f1WT[.I63B8C
&B]?&c<K7&ba<GV4^5E4;BHSUDD>GZc;fdSI^+I5^KU>W7<[+E1Db9Cc0(Y4H5BL
[[SXEP_a62S\J0.^ZfC9G08Z#^+<cd<_bHQW1eN[O?dN7?(+5R(UL@PW-BSP-B4L
EPX6XM<a8Sg#R;AYAH>;):.@U+.fX(^Z_PS[TS3V<_I:Q@@d&P@A_K_ZeN#7(AG9
RC]HMSOT@]DBQgW&1URGWQN,H,3W:@IaTA]23J=Y@(MV_ebUW6DT6(?G]@6XL<Y9
RJ>6/+4=:4XYEcDMJUW+=BA2831#NUQ<<XMLEI<3>R]EM4O+X][G#:@f3O6.L+6d
X_WFCE.STL25e].,:U:W7Q>KMST=IC(_6E1K\;+<[UQ3.][F[(YK.HT-eRDTcUeX
ee9GLT^2Fb\84QG/_QM,6Z9I]ATF;6UY0:_-[-I)gWgTIE>UQ+<S;<#9V2-LLVJ#
c@Ea\5KO8&Xb4IP7b6dbab_5?>JfadMgLT0a:eVcH_FfV04)1::YU63HPcVIYTJG
MW74+&8XS>BHa2DO1LAGH.J1X]Z)Y@7=#a/e>(a]+@&0fe-],ESf=JM1>2f)#dUa
KJXaR(3LJ4gD6M/.PYNg)8#=,=\TWb[3X;BWR8LeM>=7QBaA:-e.H@>ANUY>RPWd
277+7f@OfSW&ZK/<3?;?>I>9WX)X:X:#Ic776V2SQQFRbc>gRM&bgFeC-@,CE#>P
)<&\Q0]c>a;<JA-d1->W&KWS=:K<-5X0_ONL/+KD)BI]Y;41R9bZR),)BPfP@(@W
1-56,U0+bW20NcH=ONG=e#MRQHD,&Nb.POLX5eSG5AUMR:X;Hf7DT/UNQ\SQ,AH<
]4X\JX5KU8QJ0:T7[?+eX5c-1?eDLXU+2g_5I_]ML[L.3gfV&3[:PF8+=7AW^BP+
J5<L,SC^3aegCO-7Ga?#50/=gKU]L(9Z5CQD?R:cQ,63d-HZL2TDV&KQ?41B;d,U
a=cFFC^g]?eV:KD+GH-CR66<GeXQC@.J.O#K9R8J_B-fK-B^7g4+AAZ/d&/6&<+O
:(cMI;;Sd]@\d_-F,CdWdO4YWZHdJH4.-]RF>#.3U&Y&KG@R###?>9HeP:;4>]R.
&,8S@W,fLOQaKV6_dZb^>OCVbdRYWJJ[;#SYU@0K03,5e/AEbTUAc-<fE^fQEJd/
a7WdFgU89MS#]6+JD_M9HGQ3#W=bMOg5gDPYdR]=^K7\g5;+]4NT44W^Z9P5@PRb
C\N(.[g;cM(>?AM25&]V;(H<?KUa_#N?c/SVWXEL:YIP.-;<d.>A#YN&+c1:W1#B
EAf_aC:GV7/LH:@Md;K_P;fRa4C.(YT/92UfgdMB&FSeZf)gD3AEc[KQc.NdPH0I
>LRR<SA#.Me_[+:bCS;=YY<.HF.6-f^^KVG0B&?fN>A#cAI4:K]J6@OdYZ36\RUZ
<6V34KHJ)f4OY@>Q]eG=8T>WM96?V:[HAA#3-0AVc/JXc#Y74A+?#FMBL4>8DL7P
9eP1:-CWMV,.Ud#a:9GUdJgB/3;=06F0FN#cBab]\2G5@-7/SH:/[[G<[_S.)#](
E@]MX.a5/f=_3]eI>-N81VCQc+Z#IbMBQ[E);FM71#DfcH8P9/W2FM1#Y&T2G.TV
@2c:6^K]K5]W_RLfG@YW8VTb+3E9;)@/a>5V.1?2<8T<Aa3@dW=P(2UaLKXX6&89
d)ecgf?X(Gdea?8I,I_GZBOb)VD=>4IHK_TDAVXI+1A_.OD5&DYGd@cKT,V9WIZW
_]6HT:,VL7,3/@]Y9SMa&,/H5UPUE6X7Q0+(b;E+a5,ad,S#6OJ0BE+/[If+EIf5
\>H8K\9,CB[.=&<5C9MfCg_EF2D:.AgDM&/J1.bAZC7ZQ@&;+d>cAT#5N)=D7:0O
/JIg=<S4dQ-T-MdF#6XH00KU/g(6E1?F3DPgZW0MS?0G2Zg_9<.2c;e2GFVXJ7Bf
5=19T,&.C[0-]EIPfO&V356/++(4J+cBQ@CDdMC58-KN:>LA2H84a2I)R.S-@.R#
DYT7LW;fPVS;+[d6=W>YSE5M==-FG@(AC95?/fBLcK[@T@;OJ02J0dWZfXFg&E\U
Q-g<7O@@^FVLf1&1TJHKIF-K5O^;T@dU7N)H:Y7XSZaSWgMg&5EVR\PCf3Y:Be5I
=e#KF)&B;)3UeD494P,S7<+Hc&HbKP9WW=&]B:>^N;f1LTY(MIg_YW55acVf,2I^
VG,\M6/@NX66P_6#.AQ8C?1RPL;^;0AE/W/(:PWQ,SEE-EMg@KKMSb)+3#daf/EU
+6NcG^H7aS-()6\\f&D0?/U6ZH9IF(JP7BIE:/6,fBeEI1W:S,KHN-;Q?]ADNQaf
Z.cYS^ZT6C1[G4Q+A5Hc&+-e.AL?I6K&,DP/L&^8JeLO1HI85XJa^3><0>84J.&R
JV:SQgS4\G))1W-aL&S<?9]0?\2TTK#MNN5Ia5=H<bAREIG<I[?9COS)YF=(IO5g
=ON]de&;R46##>b>+F</V:1QW53K#6;g02R7eCJ5@g5;[2L@7cJaE//a5J[f)7,#
;0C^[HW3MJLEJ/_5U[f.U#cWU)R@&e=P7_GT0=,Q8[GLLRgD:Y4U1dD)-T;KYMMG
=[SD94,f6,ea5AS,0D0<S&B-3Qcgg=PP7&[H<6=0P[8WV>8;C??QP;9&J>JO>_;I
ANSQG?BF-a\W>UC0@)a\P)-7dd<8POX^D.c,@^=)1K1[ce;7e?XC9;XP6g>[:KK)
ABX?FL634]Y/#Q6UX:]9UXDV9KfR_\M[QIOEcP9@\>/3eXgOgLf[5+Y:bU\P750J
\BdO<]_LefacC.-f\37Xc^ZgEU?=814@dAEOPY+[;1:U9IHM&CZ?b)5Q0GcDUGDe
:@)Ng,+UaSK80<IPUM,I)Gd/,eY^ERTUK=>FWA,g#GL9Ke^VDVKL[S&8RdU@AK)U
4J[FeTDaafRX\gJ3.<NTTaP1#W3\&+C340(UVJG]TRP#E><9^)/370?EAOZ(1UMP
Y;8+16E+6G2T@Y9+]^8?O,:T:4a^3FTD+OdfY3,;5Z9<+N8+HLL6FQ-+5\5OZeJ(
ZTN4E,5e.+e^WK>,0,17E[SJ;]T^Ua3I>KIWK?=+7-7OaZXJba0(R&=gXM3L<AQ.
4)89:;UPbLDIJ=;:J+W9QDS1BJ:1&NE-X5g+@^:N7c@GdJ.5e?d_g\1#]:>MY?;J
:#-XDQ]H]J52Q#_8-^a,GBIS;<IeYOf[+dV6W:6TU]OZ#9)057g&>O)(f<F/-9#<
S+8R=O1[6\]EL7J6e(b^:7RECX:DBN^OJg8Zd49c4E1)@9;8bM^Y)a-c=,D,E4Jd
:&65,g7G#(W:(/?&^D6?N,M_=W7PO-fZVSf1Cc-&L,\6RJ.PT92ac^_d+FE<(QaR
aZdD\MT;)HK-44?MNFeTJ6cJg_-Lc&15;VI^@@PGa)X2c1:4A>/>)B)UeX,T:MUb
0W>;90FCg.:9D4--?9c_GISM0_XPZ]5OgMc5S:gVA93KWFd2?/eE6:EdYHJ^Y0E:
,4;<E>?A<HHH[6g=(NaF)4Z901;e>4\;b4W&H-(TgH^)USd&8SJX1b(E>@DDbQOU
K2,dEH\&P3?JZGbBT_WEd,(^,B1.N.V>IE29@AA1V2/(aVLS9WMG]1.JZ\Caec=U
1\_cDHDBg1]/eLe]7C]HB,\(X^R7fT/g<N+\=e[@Ae>E-2?^7=B,.56TGV+;-aV=
)W_S^]#E-N0IbPSRC5VQ^[XN\_ES67?8\,gC39I2Aba&>eQXC7.C?66eV-//fQ80
(cbHU+QPdUN#;14C>:0#bVQ9MV7H8-,A+bHOZ1]\PSE@]ENAGEYBP3:#6&GD,P[E
cAC_7X[/Y4H/SAB7TFLG(,ZX&IB7e??8X=?<?b[F3O2Gc]1_LSC.NN;,e80T?PKQ
&fNB(dG^QN7Q)4:]]>86_^C_=M3:FYB3Q.9M\1FfU:2UPa1^)=4g_M)S1GRd8;L[
Dg9\^aa4HaIR6U?cXDBC:c<Y9e6D^@Q^)a261ZUeO[5N<f.K9P=X8@E3dcc2RF/@
YO]W#Le+B;;KP2.0^a>..:G1XJ<<[/HSXdQABAZ(?H^&159=0.:f:5YUHA8-C[Wb
[A#=-^:D3JQ33e__&Ge@4,NIWg.>fM]NH+C;<XS+FM-KAT2JF)<U/#e]#SHK[??_
_:-R5&C[EW&);FaLW7I&4b=bA_QG5OH]#d_V#D_DEcId+5dDU^b&PGEI8d>1@3RG
(G=L5MBH^c)S.\[06Q(,M.>b09A:X,@,=BZdQ:N@geM&JLR)NYI?3bG8>fQQ5d8G
]\XC/#91:AKS4@[E^C/,DXd_;/?dX0OXI9&@5dbJO>W\WA[>[bgcdAcD6R&)(TSW
Bg_@JI@MdI4MEQF]FXH/D5CEP>6CK6PS6J#SV#.Q//P5V0C36/00(119g:]G;4G?
+?aP\774HGWREU)&J)d3V]?^Sb?dAQ](UeRd.SLG,F-E(E2DXMQL:9eMCOVg>OeS
e:2?a2AM(C#2]Y/Q.FDg;G^TN=BE=R_Q[cc\RfKD-OJRBJ_gT_AZeP-g7=d;7PWB
U;B;aM]-Q^,O\JKO-cgdT)_:;)[U(L;<K50\Xf=C-CS116?/g48UYTHPXN=JQ:\d
>Ha;]MTL[OUcPTcaU^@\>Nd[WUQR_BdQFE1Z0eV)dJ93]@LZ1.X>Lg3fW;UM@P#?
ddL/^Fd5V@4fM+:6=6@#,<#FFN?V0;GPcX_,aW0-X);HW]?+X4YbgJSM4_]B<>6@
)KWV^^/aER/M9KXS]IUDY+LW8Fa<cfMOQ1?3(_8V]/B,+4/H4f,?SC=1fVbb7\R0
X]]EY5,BYC]]W5_VT@&Y?9SD_>R-(5(KFLCQf&M\f\,\#UV]-QR1>F<3:+/1WAB0
:.@\J_8^I.JD:OVUC[&a7RXM(YLFaP,.]P+<ACA?2dg-[eUO.]#CEW]+M&^8,TDA
[a.BWHK)AC59DF5eBD<4)L(a>W9BeIO6JR1M&B2UH)^G\C1d:#9L#K2cI++P8#L/
a:1\GK8LLAGF+/R4#W/OB>P_Jd,V?C]XJ?^X]\_X.2a3X+-:bK:W_5E1[3OHaaEe
9G).97&ST8T_-bGE_/Cc@MT>/)/9Tc#SgBQ8]BCZHZN\5a;b)>D^/K4<D=Zc:Qd3
1+X..&DQK^2g7<LZ=?.;d0-VJUG9KSK&b,>#b[-@MPQ,\T81YDfK;)f&?EJC>QSQ
N0g)f<.-<(FBB))BJ6@\QDYG/YRM9LS7@.ddT[P,[5DC;JLVG0F3^TSD3.6M37+E
G&XQcc@GOJM>MJDLB.?\D,K^<?>2U]ED)2Q)W=F_5-CbIe#7^Y^N(9:D+:DGfTN>
ef2C8MHEE&gNdOH341F-7KA;d<Y9>RdRe)/U@/G@XH)77,Wa_[b<SHCYf\:bAJMA
^:]&D?K_Q5a=McEU/&.d6H,3+..TAC[<_)TK?D\U-DH9(7;)7RB_78CW&]XK/#NU
0,gL9aP;W#;0^J#ZQbH7be(FD^eV8P2548Y(<A:[L^J)a7;J;Z?YJ^E;EP(]@GNG
DfQ[NJ50U+EB>@2b4N=@JV8M5O8++V,RIcF<^?SVVI?HS<QYG&Nc\&LIZLJML49@
RUA.3+4RC#e4U>OOQc;aR(/0aQ[gFHGe6&.=E;OANCVGZcUHD1RO&T.HM?HL>Eb>
8I1S?R+NH1W5.;23<N@fQ-<+-ROK-aA\RQK7b&M#R83P0?gWd,f@JR]b]WDOUc/9
-F^OL/fac,0#B5<(3[Uc2UL#@<K/CUI(GU8ZB8L)]W]R1:fT.+L4TYZU2[;Y7;-a
+@OQL-IdaL&aeM]D#3D(82[?),XB5ggdY&W>UY-#_/-FV,F(2;:WWf&aU0NF,@YH
1E@F:?(5;&H#6GJ1J,5G=85_,[SZF:^7S7eUX[1->OA5/6]N<=L>O55#O@+]@W,A
8V>.<:A5.O;eZ1L/8WKAQ+LKOJ(>BBU^KT+[AO459:-CKdWUd#6^=70F85HdZKA\
=(R79<1K^T00E4<CU;LXge[==D=95V8ac.]6aLIDg-\2H8Rf1>;<K<XFbI_ER\,8
XX=:RU5O@:fTKdb,A8->3YN-)FFTT4F&+K@Z0GcWf?,]BH6TU1XcV]QE3]aK+Naa
E)50H0</R)I3&=<ecbdFVNdEd&KaPE)HY)^--XU&B?0IX_+JeY;P/V:FCc&1X,.?
4Df)?E[GM;LD@5XO/BP(UN#dd.L?<7YY5F;0X,.T&NN9b+FfRL(IX8=T0@I>c^X=
;N],ge&4,4@EQb5S3(S:V<6O6cDV2?CX]dGSJNE(3C-#0:cV<)b_887./ZM(Y8LY
BBOF-\P-JRg&PJH/&X24-e6QLgYS5CASdfgIa)1:;a=0]fb7>13,W]_^TY7g[f&_
Pf+fPL[^Nd:]QM8DVN-b7e70W^\KVa-7R=:HKYd[W40/?KHA8+gX#BeSfQfXS.W\
-I-#e1Y1OXf6DA:VYe);B5e:a&ALg>7Jb,Dc>0J]_L-K.,Xce7&cYHd4dO_Ca&Z1
NZ\:aMXE:L?8+&Wb4Y+CBFRM#+C9J/YODQVH=#Q(eDFAAO.c,79BEKaQ0EfQPF0T
+TJ(]5Z3c[Ac@aR3/^e[Vg2DC#38TPU0JE5TNOa8>_/A_J5&[fKB=R@,<+<.I,a2
0:964;\P(T0QYc_-dc1,5[,F6e5LF(MR.M)VY[I/05#EfUFO;IS/[Ba[Q@b6eMa2
)B2);I&TCSELaSgf^>]O=L#50RTZ<;WdUCJZN?,aY,9EA>Lb55/JXV+]?ZUBcYbc
<WS70N&)g)g]\68Qg]HO/@Eb/_#8/Y;JXb]FaI8VUPZ[ML8B3\A0ZUD7T.EXAWe3
C-<J529A+DBTSf/b:#0\.-_P,V<6[\#[KB-N7b?^Uc5#G9\;aC^b2MVcF^7J_(&9
GPJ]<]OV(GC0O>L:,aKU^3B1WY?<:,D-;:,<+SRX@-\?B,,X&9L+W^<K>C]KS+VX
)[2:1\J8^M):DdS.U[:XD+J0FZ]\fgN1NTT,,=d3;g.3^Y5/ZfSRD>_98QFSI?gg
272SQ#4a#JC8;/OR2J:2:.RNMY@f9WX:cZ<3C<B(3g-&@ST;?]SY8g=:ZD]/ZNMN
af&Y)[E>+S_ZH+.BF)#.B&-9T=OLC1:7HX3DW=bX0@Faf\&879OgO_,GL[CQ@_)g
E]g=4-#V;7.Fb(>@AC>-[5@6L9:GENWd#9B@H3GRUK;5gb)=0;XIZ)TUP2HDdAS0
FTG<F],QF0JW\63;Q?HYARDc1T;S@cIEXKA#C+M81HYJ9RaL>f(^FKFN^fZ8A@RA
0d1I0R>5@_3X\>0GYT=K75\ccU>H]I1[Y\DR;;OFaUDF=XGf.6#3&1KDB7(5C7,@
5S@17bSa&N7I=L^<bEaH#O0RK9>H6^R4#NHND:VD9>.:\9<R4R-QS^HIQ\L2S+T6
(?593QbHPX5Z:BOEd90f=X905UWN0OQ&=2D>Yb9<S0a<6/@YCUO@ag_O>e;>:?^Z
:_K+2.3JHKK7U<a9G8K1>B+Z2PdY+[O#.U-McWKJP-YTg&UOQG?Od\D16.PS?H[P
fa,5S/A=22TVab&1;01a2Rb3(HL6\.+QfMeX2,]F-YRVbP1[35PK\70/faQZOKAG
G>^_RCFH>.IgMb)(f-KfVQ+^ID[b)dbL6U:bf0J^g(e7b[^-PG7#c4W\Lg^E]gdW
F#eVRL:9TSVeW,g&6Aa/?O2]UKVY=Y0QE8BQUYe(\g)gWF+0&NA&Y-C9dB8KSA)2
-fOJ&T6cPN2K.=H+T>@>M0gBS8IcEVQ),G;AMQH2AU:(4_Xe@g?77?)INN+CUXe1
5TNP:01LeH2?_eeJ&9YK=\QJCC_P6112db>LA_5]AO6f:D^,5F,aPXXd2/4c0Qbc
PAU;Fec=+b-dWV=#8c#NfdT9>LaFEeP<A14dOL;FWD_+7+AZE)J0ZG?@@YWQb&6<
:^UJFXJET_VaEW,N]@S[[+#AKd?PCWNXePP+NcE1PP\B5PK<X/=+[X_2#DC[a@^+
07RW@@F\8Ob(6IQR@R+SAB^:HV9A:;/a0R=ea\^ade]ZdOQW-Y/<_8I4gY/ODFFb
.cgX@g>V>8O@SZVaAdQ\cF-ee]X]&KHCg2(;>Mb3][T3(eb)5C2<^f9gWVD)A-69
^JR@:Yb[ZDM>ZM.b?YD)GSa684BVESb-HDd.>WP)]CF63ab[?MTTMgI>8g;;E[gO
)B3]NXJ8(STg<=H_\-+1Jb)(V7T=D?C<L?_8R?[J0/g710LV)DBOYa[TBc^HdUXc
?X;bO<+Ha^a;&Y=0XI@I:5M8=+@e8WdTXZ>C:):PKWP^NEV;Z2A]d^K_/a\.ZCRS
V:f;,C2I#_f?.]/97(:A04E6MQ3OX0Cfba#GW?_fAeN4GNQeM\7,@?15VIVC\_@9
.P;.+(Z6S-DF5BO=<E)3ZP[.8WON;-:KX6#EL6OLU;V;ESBgGMPKD28NfZ9RSA1J
:KaHcG51/G8B@d/QTH+bM=9e.ZXPT^>bAT-MD=WAYCB2(T4204AGB_)cYT)K#[8Y
,VY[RNO@@d2P8(e(_U<dJ,+2W14S?7GE5+N/XUM_>/6-Q+<^GYD_9[b0S/I[CC&7
_X2\[1Q?7^c@Og[g4&0>2[JBbE#6Z2X=(VNIL.AN>d<9PEGSQ8?O0OU_URFDV^-<
LEc(T0_NV\(G-HY^L79+C^I_([[Q,[C8_L(fZJ-+BJe&PYJV[^E+5Kf,>0+T][c-
YH,3?16/:3D)0H>QD2#Y0#[N.Hf,/d(<L6A-EF+V6?U;M]MPK[OZeeFaFNM/MUT=
3M85ACXFL<_W9bR@6+bQ5NR@PEa8WFOP3gcXLD5g9PgCII/X8A3c@24LSQZ5QJ&2
6Y;[]8]X?A4U/-KC;^-(eG7^H=f?11[\IC+]E&8;U)QS0dBUZA>_)dNZ@W]S2K2+
=LYfTGN8N/2BCLK[I<GI9P=@>9S<3YBGUf(7RBK.[BQ]_>G^@#cJ]3K^4Md8ePfX
A-/ERVA^e._4S#T?&4X(+#_g82@g]eb0K21+F0J,<^?ZFI22[YO<;-CZ9@DCWELG
BQaNJ7;N56YSMNcF2Te8EVXNJ9BU6R)7>4)M3NF+O,8:4W9M+b-9-SQ1=0YRX2OE
1F0DFee<0<U-?A@D<=7;_Kg/:E7BdgB^Y:</_KB9BME.EPF0QH_2W@60gR7]0TN_
3P-SFE6X#&H;;MI<26QU4URUND6NEX.FLA)N9D2g?E4Q_L.EdXW+LJ3_e&2@]J^@
9DWbVXH2GD.\F:<gW.RR@eT-?)[b7FL^W>B+6UYAL1XPW>XL[<,C8GHO9LE(R<>e
YBP(&)P>7^\3cJVNG-e;4L<f#_FQR:)d(ZZ[@1I7MB&Z\.:M&H?/]_Cd)QRJ]3TW
0^.Y=33K<M;I4I+e6&W(_[<5;K[A\ge\-];R<NW;(ECOCKL5LbPHS5DX:+7\_]JJ
b?C.fT-E8K7K)]V+/?INOB,CeW,O@EJZ=A]:D>,F=ZT;_Dc-5aJAag70gT[COUUb
Y(#.-]#F@fJ<@a4;@AWBA.QO8;1W(b8bB32D2ISaT)2bEOW=#E]OGbBgV(+=[UIT
N:S,0(f8UTK90?Z3]gV^1DP9_Mc)[>BF+We67=-@LEDZ.MTW\+\QCSA(c[I3(Rcf
,M2<Xac]c\R>B_9N7-@Jf?1VeAMQ_3fDBXDW;C=,a&TYCS_05e(23H)U3A=7>)GU
[60Q>VY_35[6ZI#-5?#ECJfT^fJJ-e3KLfN0ZZ)G]G(gGKeb3+MZIETW)]>HM<;1
f[AY:-XX:Pcc&(.;F/b.MA2g0cAbU[e1@2O:Q)EB37UD33WK.10Z?A2X4T\<ScE[
PQW)URVf)<DLKE5GOXYKZb;OSf?b0C]>X+C99)T[SXH]WTRAZ1<YcdLR8:K+<>;f
J[^3afg7P@V\bN)bM)8Q[V85fQ&^5UL9fPVc3N=6#UVVa:VfV/2F\VB60:;fJT(>
B;I25B&^/XDCfee)-Ua0D.WOM(;XA6_/9SNZ)WTL3K89I1+==:^\g70O_B&SO[GZ
:H]))UK<FG7]JVd1g+6TDb:VHaZFfK/T23-_?^3C)e2YS(ZeE/MGf)bD@;FW=\NX
]YPXa/IT\UW3;STV3Md]@:442PP2&)0FRd.+D--@g7CgG+H5DX-c<R>bOWVSTbdc
cU^LEDbN;g;41XZ&b2Q1)GME]-/dVDZe.W>1BCW-g#(V0/F5>I(A1(G2D62W(5VA
e2_\UCg>/1A?];:Hb5899MCXSKNN-9F2(D-@:C9]dgeH?FQfHSb9OgdNK;P?2Q<K
XMLARP)I/AU9+KeCG)\TQ==#G?WU0b-6.1W5#07^,MbXY;,L//\61MeFFHFX0(?4
<<?E#[ADF[c/[T>H?\#>DPcR_[C1g\@HIQMKTTT:@0,8NJ025>C+4g>_eNPDA^gS
2CG+eMVCI5fW,F5>C>fIU9aBAQ:&OE&M@T&3fXM8Z6BdW2Q=;d#^[>F8WXO=L028
R@WP(Ba1SQ2g\:+T+:[6G-df&;+&2YLa?B?^4)9FWAE)#]ZI\?D0Bg?D8e;8XY8:
R<36Bf=KG;7XaH6P71^dg-XD06/>\(X<bea>P_R<H1=,Z.+52IC;P5e24BXP<WVO
Cd+AJ8+M8BZRUHFHb4H0&PZNOD&;F(Gf<QHN?Z8G5e4)-ZW)d>_^A/Pe?UH)N+L4
?VQ160Z8GbaY66HU5_Pgf&Cb/(-1F.H&e/5Q\E0]7W?Jg?XV9;LDMS8M5MDS7ede
eO]<NJ@PNEU3-1C]K9ZJ-aY/B5A);OI0;.ALM.b8VaH50W36R=B.VeCbb?:U\(@f
bd7eLDJCHB#ROEU)a_N,ZW\_WD#?<0@f?KOFeY-V[</EWJOdZ_CW]9=@T3NGIR.[
]K\BQN9^VdL<UJ^BU(Xa>UBc]d5dIf;:B7]JUCd;SB413W16(7<a-+ICRAE:c27X
>AUU=&W]6MbdeRG\8YZ6VCZU?>#C:KS2f6S>0&c>.EIb[&Y3-/HafQ#^+/I\)K=M
_?>Mb^M9S:cfH>5#g9?\c)\a#B1I8Hc/(E#7O+]K+\7XJ7J-deH85-_NY8HHK3VH
#[YTE;>6K)G<ceA3>0I@,dbCgWHAJ5.d-Eb^>OFIeD_F4N,/79IFEM]PY0.41-@N
Te;E7f5cO?QYXEZ_L;34-WJ9G]=(NS/6bGGCTM4/8X5;=WeX.EGO<I1+cNaPNTGR
gLIIga56:\D[NdDcTf:(Ie7@)M.B)/bA]?A<J=MfENTc\XMW0#c&O0eU2T\?2@W.
:QKPcOB0e_B6g((\WT?=VE\(;?aKb,RCWG4+W?_-+?56J,8Igg;&ZRLfRU,H+G@=
8KO,V#X#&f1AU#JX>-8952W_Rg;E?RK.0O9M@/HVOL:)\9dPOSK++B:F\K9@IaeF
ef>?ANOS[1M#A#FD9CTR7X01,9+@=]DLRP9ELNK.1?8^2:Ua@&0/D]T6gQMVMN)e
N#P(#.\L,QgS]LSUgKK/7>M5^Pd/3AVP0JGUM&S/UP.17_c#1ZF:?#?3WF7RSMB4
Sgc42O.9&[NQbfM;-Y]T7>GA?Q,[3e.(+[=ZKHJY,@I&5;:9H2CDE;I@87g,Hc]3
XYa=a#09eYcX@VZYB-#feS@:/MdMWJ=6JH7.6^&>TM#gN]I-[O\Y,&3NG&:_)&fW
Ed(AJQG5_;7TT,bFIB<e[Z4UYEL-F8GcXO0=Z8W1NQc[&]E2I\=7-TX6OQSW0<^g
=XY^K=O?ETTbVK/6KC6OO]aK+g8CI@6DWT2HY_ec3J<_Y2Z.IJBXRFbQD\34f1:A
B;N?#>0#:=[H:PV;O8a>/W/(A@bQK9XGD??I\421_KX<J_SSd,UeHL.+_<eC-IKF
3(0V_b2TCMD3SMf#YB9:LBD+b?>LQJJ(+S+MJIWEA&YTbLX)fZ-E=FM(M?U;5+Ce
0Y[/99.gRg1N?T;-L4F]SBL-A\Q]NO-.WS9S_V[8P)B9CIP)8.Y?fXb26K6WTPLO
)QHGVbCF3GO_QaOWU-E(]K[;NJfKPe?I6,FSOF>;1\#8I2O9)AT_2\dc=C-\4E80
#&7AUD&V)H-ZZ3SRecGA<b&R=W:g1@LeGRGFYDZ)-^SR/f;HX[c8:eVNc2Ze7<PI
K[KW>E9P5_/61RJB_Ma9V13ePZ_6Q]1];Q8<#&B?\\4W(LVf.5bFK,+9_3gLF0f<
9^I_L_<PL3;RQ,<&5YGXFg1>0NC4L5;N=@-7gSI2)6HaI?0Rf-523R3MWW=,92A2
N+^=g.G9>XWF2<K6+,bVV.P:e#/\W/M?KM<OWMM(Ke@P,E;[]JGd6JF2WaS6_;BX
BEceI/Y#DGZO,0ZB]^K;XV@@(;ML^31LKR.C&e/\/ECEM?EIg1IdWK?UcCVFKKQ(
YR/+1@6dK#fH&X(J;3B-?c:FH(cAd)N33@FPU,TV39BdB>KgKg&FV.4G#W:^cHAd
eK2J7N2[V.R61=C4OC&1eENT9dTOCLKNZbc6gMS(H:c;8a5#/4>Z\S1R8Qfa.Z@<
+J<=c_^MQc0U_5UXYVF#ZSX6GCbW=UB;^QBRTC8aWD5e&M#^S24:IdKHDN531KCD
V3NP1)f#CC0VQ\3d,TWHU^NKQ7C<J5;4;2=.YYY]+gR)]K#EL_YV+A]A,K(I6X>\
+QBXI?6IMPAZ<Z)16VN#5=O:7Wa?H8(RKJc+LNC5_\A2_<3LQbN.9QES\KGG@],2
8)9V]M[3+QfJG..TZ.&Jbg(P.Vd\EJ97K.OPUB&+Z>/c(R78\MR=9baWERQY,T-d
0J]YTCW;;^\bYA4UM&ZBTcY7T6g./NY>GD,Z\A#/b<_gX5ONUPBWCBTS8BL1LRX,
+-DN6]bgT]@H\=EIHQbR8.59aLAUAHE)aH5_98HE(#=))]1)&,g=F=_6IP#K-a<0
3C)BL,fP7@88S/G49F<E5N;-,e+(17]JQGC4Y@(\4dC^^S/cePYHfEB4#425./+J
1,=^g=4P;0<c#AZ:L]93R<7IdVZ51=J._G?0[@QRPQfVEH/U(E^^gNFS<BZLPcA&
L>97>-XTE0@PH2K^PD._OVW(1-E7M#\QLQJ>8^4-(>UEBde81/M?.M>7YL?#eY34
eN+NTTdUR\J36O;Ab[/QF:>(H:O\5][SSX3<</X:VV&bIg+<55WgL);deTFS;)8d
:)5KNPg:\2CY#TII\<#Q-eJ5T@YJ(:?NdDO/F]ZHE]:@c45>H;D?E&g0;/Oc+fTZ
]]a)NK.8g+?A\V?EcAb/gSOC__:(bT5REJA]+QO44ORfFd/b0=T=[^VK_0)Gb8B&
DJ5.:TS=0.ESOX3NI<Y6N:8ODbEK;=7GOH]3Z,e3Z5.WDY127:9BHSI?>5#BM[J@
JeDc-HfNVIX276F^;AZ48UJ.XV<RC(-7eK<FD+)JWc6]NTWYOPRe)1cg/^?81>\A
VQ))d\Z;a&W5P+LS@4?P7R2cLO:TGX1H;K2YK[8UW9?)Kg<\V8:eY#FO7gL1Ed\A
N4A/4&RL#:Z<f],@6&4=XJ7]PCR1FH<V2#ESUgbNJ#LVZ]@_&AW&>L<=>/V>(2_0
3?=cbc#A[N\1V/(\A^+@TG]I(38:K1Z]DEeH2,cEB+D>U6K],16KJLEP^N#Hd-5F
^/5NET0V=RK9UeX2T2R6?^O[M<242H<P2M1cCI>f87VE[bMF._^S80_(TadUL0U<
B7NPE#80#><4IPR[a,U&)bTN8#3f;[,CP=NJR9]=N=<F,&W6-bX8Y:J1K0C-,U/I
cCOc2Md\\@>D5<^.RR_M;)9#(cFLG]D#,].Qd(@Vg62Q+1>FV\&Yda-O:,7:Q?KL
/(FU2)P.XbU2=H#?gE#BD\+P-;.NR9O<(+K=c[,TbXXHJ3.3T@4<1RC5Kfb^.Pd[
YeWJZ8<R)c#^7SWV49B-=8a1=HN6X2dAV<YUYd(73[+K(0>9C:^0,;01<KX@2JTR
=UTF9RbB>ePOgbFc3EQZ_+OQN>\(6_OU]84LKK9Q1I]0c.fUSF[4(Yg0a9_U5D3V
UDAgAJ@dX(f.UR@Y^,c]I7_24^OSYCWE(=c3;.g9-[Q^]?F@=915C]8^;)d?LTg&
<-G/CDQH+<5S^=8&K&O;CP>+L;6(.6ZD5)0:5]2\(#g/f0PgNF9^)YO=]G8aD4&^
=f\@S,Af5eLTEK4(5-?)B]PB0b^S7<KJY1TAV]@)\MP((#7A7?:G@DE7/Q7_><TF
L1<2FA6:9<8NC1>>HB@);aD4HA\9B2^-Jca49UQJA;c>68#RQLdV>3TZQdU+^WU\
;4<.&P:OGV@6Tb\KPV#ed::ZA>?U+d8B3.5RQSHO\]\aI7QEM#+W0MTUDR;V<O4b
ZVQJ/R]R,c2?=7Y6:<_5.ZFg[fT8gbC.B_;gC<2/L@fY]N7Y\=gfQf3VRdPaX20@
N\14>(2eM:E@+D<IF=(>60]<6[G?gCTg]6c?]12?]_9629<b(^SQOH)c]9?3&Qa3
3G<)HKAaO;[53WF<<Xbb9g#RI46GGT]/FZCV^XP687H^d9;DP<U[\DHC?#4d.RP4
-D#3bVd;^5B8Z-@_JRL/NaI=bH]?IAfce?2XKUYWF.GQ8;FKSNRNeT[B5N#)H=&3
;/66:-9^(.RIR:96(@/Y([Y7,8[-#EY=D4\WGJ]D/3aC\WV6)>^&QN@V79=8TeLP
OV9\QZ6:)2J^9O]^3BW1XWT)=[@ICUJV:ODRa#\+9IN,b2Z.HO\VB+;7fM\<efMV
KZ+dUbEY5U^_/5\A;fG)^PHA+GNUXU=?.a1,+f4XR/W5Ba.G8MZXZcN28c-D8P:d
\UaVQg8d;I(5YL@\C8G\?..&Ge/4ND_.6174&_c]DAb8.f@.8BPOBgE7==PeEYf+
H;Q<L>USLdFF#-+^g9]:1[:Gbb-?YO8cS[TNLX(&M>a(E=0./42]I)D<PVRBO=De
e88ASZ,dgVJ9Q16)0W?Q8(T-HSQ-S_^EH_,&=PT==D<_B/OGN2VYW.TBX04IR0+1
WE@CK4^5;<aegMaUQ&UT8#d_Sdg76Od:2aGb(:BYJd2(fC3BH2]P;cK\Pf)L:T=F
(:(4A)[3=c>0DHE3KFU0:61VYB=H3e]RS^@_AWQ5gGTF4JW7PS[DO=]Z#<_MZK^M
7XA@gM[J[USHT1Ob&PESN^f_.P741&?5P;MKE/<b7KUcd7:CeUEOgQb)V]W:#[>,
9g<JY6,41dMH8XN/6N##Q)?>Pcc&TA:fC6b05DBb9C)_>VPP#BNTf<EI?dB]OPFH
T\eM1BW+d<,IMf)U3HJR:;f#74?/JcP?;B?#@SF(0PT3>BW/PLR\ND-\V8++/L[e
)3ZEKW^Id)N+H&BLB1D-/DY\Jc,1@9+JG7e-2ETBY1WaM5^1f>0Zdb#)8K97TBO>
>L5GNVESR=#4HMQaQ<_(#520.4TaSfTC1c:A,,KRP>J(NJ/HeQ[=\Gg>f#dSD=49
6R?&Sg>W\EX:9]?e(DSZY>__)8X_U>;.dF;7XOQ2[b.:(3C;L^cDHICATG6eUU/_
CS0fc,Fe^\V3[(b9If.fYC?HY+H>.LOVc=:5W-c4b1>-D2@Uf5QEe0[G0cWf>5R3
0?fYUZR=EG_eMJ,eCC\[L:+K>dJOWJXWYZ-M4IM:/PY&E/gHL^2NLH=JHQfb7I@E
Q@#CNgC-<Q#->D#&>6S]M@da2FBgYVW#c9UGR(R1,K>)/R5P8N:NZ@@gB508KW23
QSJHN)G?6M;KJ[29[Kd[D6.&J/,)-QF\T\Sf<;YTNUSfM,..BB>TAT:?H8[&>=7c
.Dc((H77^#<c4K(LU@/cEb9OD4G^]FVdD_;M<1dUYT?ZZ(<JXXBa+aU5>7]fMLcS
=EfbU^JA04bO:(LPfJIWQ]7@b,ZHM4I6MIbcH4D=GW8Q.V)K<@MecVZf;b/\-6DS
CG53@IaSB+;d_g8G?dRLAA-_2P?AU^Qe&9@.?d#OMB+_b5]Y&(ZW-^^d[7@9/Y::
)W#6aNE/UBCO0-9W4\KYc5bN7H#]C[#]cDM7BLeeWDKI+O_OF^AfKT5=[Cbg+S+:
V1bKR6KY/Y(<O3_BH1MNH[<4H8\0]Yg&GQHY1BZOJR-BfC6#DV0dVKQ6Mc:)_&F(
[@;PCA40]bAU5+8a?Y^:4>ZY[JRfO)BM24?:03>IC;FD12>Bf.ge)4X?5#gOHHIE
cSN48PRdcEK@0T>d0U,?+/RTPG4A@0bSG=-@BeY\=#GR?P853(9US01DbG;cZ)@f
&>P23=Z^FQLHf^g(WeL39ad]Rad,BZW78e]3;E_ET28+;Ae_T&:A)FO48aYOJ?bF
NV7fP<G2SG+&1CV]_@MD_7Yb7P)_1;]cHLE0d@RE:05BMR4<G8)->#3]>0BMIZ(>
4[9R/b(gJ/dBa:0f@M/4]@B<=N-SIbF\HEU[R]P)>#H(#R+NC6(<B^IcJMZ->31f
<N<1O=]])]TDG+MfSceUA^4Z^Q]P0gNfC_S5[>Kg3S;?AFG.afOKR6HYM;bLJa-_
4Z8\a(gL@[[3BgI?YLX6)<D+9(T,UB9S85H15IW(Xfe.,JdAeF(e9XA)WV1fY3ZG
-5eRZYF3C)NK(^0gg25f\K6A4DQEDaKXeXa#e[PWXI,<GPbDG^<&UbggG8#5^aef
01?CFZAWX.>_QK\862<Z3SVTKa11]I3F)>Vf7Z>[9BZ[:C(5B&GQA.(,<ZFe/_,+
JP,Td:TA:B=7IE(?T7\_FB>SaUE@ZX:PcBeR,gB7JES/40)ae7O5bAI(c_1FgO5f
U0ZI5JTg.)]MMG-^T1de5,Z/=JLF\M=2X,SgBg-8;RegH^&H6:_5.QKI;NK-=-CG
7SO##;?F=?d/^C><g]4?NDPBJ8B:(1;MEWb-92La0GS>43P@#e.574WCCA0@,_)U
\#S]5#/>WZf3=4?VS[EKe-;R(U;e+@\G3FH\X=5TLgY:F7)M\JH^Y(\3fg8AK/?c
P(cXSND#][8A?<8Kc88)a#b]Ma=;GN893AQ.AWMTV#[a\a_7D?b;bR\-6RFT.VZY
SbAT@RaOU+Le@I#N6W)F6L9;(S(ERSJPKa<\34:M=KE1F#eIUc^@GLI<O#]/<bc4
g:?3JOTCcEcC;gO66eZ6bc)++e=O86YbBLB-ae37N[:G@B#E=FIK;C3X3()CQ@C]
b<D_LS#OI:e^g#TRa@C]NV51,+HM8/1:OO>.f;XRWW-QBN7E;B&T+aOU2\Z<83g[
bG6dJ6VJ]UE+>&.8aQNCS<],&-O]L:QS5RYC1aD]7X-J+PMVR3BOAR+aT@OCN.Q&
f2EM\LM_g4a495H^XZ?fE[Y7T8BR5/ARJ/^TC(K,M6E5f))SQH1&bQ@(AR01XI>9
RMg<N-^LB[@/JCXQ<>W@DXUCg^L_E+_1W^HcMNQ&](7F>6QWAS^]d<8bWV&>R^_.
X[f=,aQ]@W;?M8Ga,5He(1](+;F5XDMABf6BJPb6>SN?L61R)SK^(_d#DO?Ue_a;
+e[7-JHP?Q-RR9>D)eNCU9(6KSR55V9:#:T]L]AY=0:/UQHZ?-LNB:Xd#-[QJPcC
7[4,bUG.<X.RU\HZG-[a3F+R\YK/GYV1L/CVb7\af>#1X@5^O>3.?D4VX.4E[&FE
c+fN\IQJ^+H_(FD4(FZgEebX;5?NSc2JCF:L^eOVW_7J,94b4Y.M@cX)e@N9.?-S
,VN_XB+IL.^BXW]IDHVCIM#3gI?90B##X(]BH5=Ng=7[H-=U_NHa]S:(YEIg&C8T
(2d[DAK(c&W8LZKFGE>/]_aXOd19\6f1GVP@C+cRYI4I)De0OaK0?S#D_CQ8HR&I
(<Lc\L(?<35d+gQ.,[&Qd]gELa3S>CEgA0@8?R,^NH>\)HY<TDBU4F1FP-,fYI.?
0^WQbG6bVRK<^.B?dScCQ&:#U\U94+ALW1XY3Y)@^SN[4IZeR;S_>RMR2Z?Tfc/:
Y:[]NQ8J]])VXW9<)1HL,[JB4SL]23RS]Pd+K1ZZ/LX@bdE=/#U^b\CRZFBDI@5F
@Q04X+Z8LPD[PQ9dAU=_G7DOW(@V-+8#fM]^L8]NI>4/eGe.+MT4-f2M2F/8,\(#
+GQY9CbaXdEZC]-LGFbYJ,:[VDX[,@8fX560ZLc[<-e6fTfJS=<V16X&LE^N;+SI
&E6,?E]K?K6Y@eD(c\-&:M&RDRQQd1C=B4W1^5IGF3V\EITC?21G[=J1-U;)_21W
[5?Ld12GPR[[)>D#f=N+S:C+XH&9V-7O(JC-2S)]gZ(AQ&UEU[A@?)U]E(:60R9Y
,EWY.2_,SRTSL[dGKaENd7>UK,D;\14I>JJ\1^9CA3=C811N-[W3gM=1Cb>CF<T/
#@49/^R^/8C[^,^+69J&B4C>e,V(-OKG@A;E_&dRb0dIgF;XZQIaO^YgJ7;:<:YV
Y-dKLcbBE---]=>gPZM/+;VGeUB?DE8V0FBF_1A&BFM>UCEe[GNf&1>\35C(#RNP
5FQ&K_1Y[d0.8J0fQ6SCe(Y=ZYE1G:_<#NSLYCdNA?U5M62?WI3R_#61:ODKOgU>
X+]8DJMRZEd^YZDS?_/T[S,JOgc_<d?;BI8FS,V&.4^=(@7\^U>[G_8X^V7)N9]N
LdIDKC1(C;fPHQ39S([?ANGFE[G/?X=3FVN/[?AENafg1^RRg+8+(>O0gN#2,cdH
;A+^e1.TPH<FeVKH?&?8WgLOQ)X2PbC#TgP/FaJa=2d6:COc\I\)U6)X],M=^3:#
@S_=Ebc60A1V40>LG9:7X8>JEI-;?2B1&b9_Q=FVf5KQ_69E/gSXERH<-05&3#G9
-4@b<>LJ1;MVd5)(/99QLKR+GRG\/MXNbWgR6e0+5+N&+^>=_E1S,F,?&H&;Q_R[
VeFfE#dba]<^:-I5bK#WW.0841d:f_0^]Za?ZaN8Y,=UET]\&aS0E]T&&cY=HfQG
XL#CU(/XJL1,E4RUScI71WW)bX2Nb9=:3=FZIT-GO0KKYCS<V89/UJgCGE5c=.<a
WDNN)=e31\W/C[NYPUNZMGH.G]Gaa]+AI72O7LW[_VSI314@/O\R,dB@+Q]84P+-
0aB^+f+e)8?FA21(d[O@M&(/HWe>09UQ.Q0&@JK/#O0E\KBdTTgS?UR=9IN;FNF7
#f0)dQEB+VQ1UPZ/HdaQ8f4)LK0FaYP5.^dE;[CD;SCJ:8fIT.Lc\MB<+E3L:Z(d
]WMc&M/IL1:c=H#D:e9P4W:&^]5M:3A,?0+:#HF?4_(1OGfE@O]-&]JNM82<6;Zc
K\V?WK;U#+FDZ,D#D\^O0Y[6&B@677\:.9J2YC41Efb<UeS:6gPJ:.[\b5.^&2R-
_:>82[T-Sd7&?YX48U7;CL\<23DN<ef/8&fQ6c<:<1^JEZ5^9Z]@N1HG4c[HY30+
J@1WC[TWUI^M9[;LDR/;CLfE_&;6(?e\2R+bQBVYLDS<B1FYdD^6-0#=-<K6+AP1
,^P83-RPM[-GPF)4gUXR<A2P[^K,<.Rbc+J.R+I#BEZ>.I<UA)=]=I:(ND9DV123
#9Y]\gb)ZDeU_f.H:4^.a?.CK(FL@&B@b=,N\F?Ae^Cad]QR_RJ8Qd>T[FESWCAS
^;=&0?-Y=83?9H?Q/f1ASJ=YA8;cEdNI[Jd;fZOg,<[dMYL\ga73Jd1/D__8WA2\
&9&+R#,7O>XGK9Y_X<(9ICaM5SVGQe\WE3JUQ+[YRWa;3V]70I:>:;>T(f.b:VT2
L,U2eaG0MVBW#4&:YIbK-b4.\<G[BfH\+aPDXfH_+A)<f\,;Y0)Mg:S#>Y#SIU3^
)^NdL/^7F>=\]F6cUD6>g4UG],J64a_;39,QD\9,/N6EN/5X\3cd_\06c]SN6?(]
8[d][CC&H?[&483AfFFS/8<9JZ@UO:U/SMXNGOdHI96RROg>6_N10P<3Lf?;B.(Q
2bA7N;=IG4MYJG1YD>1Cg9^BKD/7&DRQ(7.--[8K^(CcT0>LQ##G9WG@4@aL?4^L
4(g/1cdIc9b-6#F]OOEbZea(Y^3>\FO=DCc)UT#g-BKGGUIG]E[+5FYPU)K&GGFP
T[#g7)H4KF@69;+Y@S/R[E:ObJ)H-:\(?C37;=I^Eg;[G,FYJcJf.T6_\Q2A4GbY
=N^JI>4H&HKQ1e\BG[M#@[YX0Idb:N5=U[1/F)J.OSC=F11NGOQ[8d-.B^c.+-;^
UcOdT.Ea5UPW1-UI9Y39XKO]90_1QgMZZb+fPN?RC=HeRE0BbAQKYMB.M=VZ4[RL
<;BZ9NB__V)Acb<+KHUBV@,JH(C^\e@2aPLb)?0US)&XQ^N+JFJ3HYUJ/9?-g.W)
4eACGfd[#(8A4PTJL_2<N3f_-1(BWbURO+F>c)_GTCbg[SI0CT>A^P3AVP,92F/S
Hd-.Q,;:HM^1b-KHP#W9<C\FY]XAd/\Y(^#MDg1HU;9^U]a1OXb&&E07#fLdUI>g
gPOL(XEJF-K52&6T32EOHV@N\4?2_J+eVSQQ-OZ5A#gYc57DVGOUC9c>+d66HSRM
YIfT=I(]cYN&7f7;eK&FB#]YV+B?;W?&)NI2^@+?b[=^ZM\Q>@A+(6ZbdX9-VBG>
LU,\Y&QcEB&LHZZ.CN1S76\U0cD:GeAUB:gAKLK[+#Ud\@ZY1/#+eSXP/3@6=3(J
3LCaUT=P:3L?G9BK^P5GP<XfHMEcWET79dfRZ6K8[9#&4BET#P3)[+(CZ5Z56g_4
<N.Z8.?XRKPd86X08bEQaeR([dZNaV[P/OV0aYKW<4:?^[b^H-&>MR&:1X=>/S@_
,/)XK+UW@G\5<D/T^DJfGCGUK__T9H1W.O(KLRL_cBKPE(HbO8T7D4a/\dK])(UD
]@0T3WUO:GJ/dZ0/)0?KP[PCAU890;73.deE2#>E3Z7:2gM5dWb]2AV]0XZB)9eV
ZLRTBS_9DLgbX;YCQ.F?IWV+_YE&W,J2:?[Ba3#UW=]4R/@H&I<BNL,OZLK)MB=O
dF]GQe.4@E4a=R/)D7B92P8FO1ZCU/S2/_8/(OBUeSb<1PU(_d8-^U7J=F14.>.Q
AU>DMbQT^gY>KB5dP@8QJG9)<d[V/HWKAZf;Yb37g:\,SUOaI6SZ^.@R80HW&D^9
2-4\#Z+ObTZa<ZZP/SdX;a3#+W:cCTJ6ULa:MRO-3?9T0b5Gb1UO0>N=+WPADVKg
_[W(69NOR\aTX7Oc3cQ)3?_ZAf4\9C)0]@#C0X@c(/ZgHM&5)&fP.][5K.2FPII@
U7U>UM;,^5d_<=.C0>8_&[Z=PfMXfJ6M?@:&;g4YfDCH7GTbT(/;eQf=GeY1H3Z0
b<MTD;5K+Ffd^OL.O+)BR0LD)0&+7MO-^L#H)C3IL,XAbP]B#6=<OL28^N5VXL5?
F+HZ?=3Q4F5bSJH0@0KPVBRU.#VY=G>9:X<)]AdYNNY=?.@Y;4FZ_(SPL(]+]c8_
>K7>eM&/+_^F?LEFR],AbAEKMU^g1<\2(Sb&X\B(N5^e?A238R(-6-B=5B0b.]#+
[c&N)&O4+E4ReEI#VDJ@K)Z_D?g=;=2R&b>b@a6JIAA1RG<VW(>:_X7C2K5b1;LG
8b6)^C&J31Fe<d6\EM+-TCYCYZcVcfT=>$
`endprotected


`endif // GUARD_SVT_EXCEPTION_LIST_SV
