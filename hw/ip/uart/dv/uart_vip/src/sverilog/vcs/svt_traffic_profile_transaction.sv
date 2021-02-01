//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
`define GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)

/**
  * Generic class that models a traffic profile. Only parameters which are
  * generic across all protocols are encapsulated here. Protocol specific
  * parameters must be specified in an extended class. 
  */
class svt_traffic_profile_transaction extends `SVT_TRANSACTION_TYPE;

  typedef enum bit[1:0] {
    FIXED = `SVT_TRAFFIC_PROFILE_FIXED,
    RANDOM = `SVT_TRAFFIC_PROFILE_RANDOM,
    CYCLE = `SVT_TRAFFIC_PROFILE_CYCLE,
    UNIQUE = `SVT_TRAFFIC_PROFILE_UNIQUE
  } attr_val_type_enum; 

  typedef enum bit[1:0] {
    SEQUENTIAL = `SVT_TRAFFIC_PROFILE_SEQUENTIAL,
    TWODIM = `SVT_TRAFFIC_PROFILE_TWODIM,
    RANDOM_ADDR = `SVT_TRAFFIC_PROFILE_RANDOM_ADDR 
  } addr_val_type_enum;

  typedef enum bit[1:0] {
    END_OF_PROFILE = `SVT_TRAFFIC_PROFILE_END_OF_PROFILE,
    FRAME_TIME = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_TIME,    
    FRAME_SIZE = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_SIZE   
  } output_event_type_enum;

  typedef enum int {
    XACT_SIZE_8BIT = 8,
    XACT_SIZE_16BIT = 16,
    XACT_SIZE_32BIT = 32,
    XACT_SIZE_64BIT = 64,
    XACT_SIZE_128BIT = 128,
    XACT_SIZE_256BIT = 256,
    XACT_SIZE_512BIT = 512,
    XACT_SIZE_1024BIT = 1024
  } xact_size_enum;

  /** Configuration for rate control in WRITE FIFO. */ 
  svt_fifo_rate_control_configuration write_fifo_cfg;

  /** Configuration for rate control in READ FIFO. */
  svt_fifo_rate_control_configuration read_fifo_cfg;

  /** Utility class for performing FIFO based rate control for WRITE transactions */
  svt_fifo_rate_control write_fifo_rate_control;

  /** Utility class for performing FIFO based rate control for READ transactions */
  svt_fifo_rate_control read_fifo_rate_control;

  /**
    * The sequence number of the group in the traffic profile corresponding to this configuration
    */
  int group_seq_number;

  /**
    * The name of the group in the traffic profile corresponding to this configuration
    */
  string group_name;

  /**
   * Full Name of the sequencer instance on which this profile is to run
   * This name must match the full hierarchical name of the sequencer
   */
  string seqr_full_name;

  /**
   * Name of the sequencer on which this profile is to run
   * This can be a proxy name and need not match the actual name of the sequencer
   */
  string seqr_name;

  /**
   * Name of the profile 
   */
  string profile_name;

 /** Number of Transactions in a sequence. */
  rand int unsigned total_num_bytes = `SVT_TRAFFIC_MAX_TOTAL_NUM_BYTES;

  /** The total number of bytes transferred in each transaction 
   * Applicable only for non-cache line size transactions. For
   * cache-line size transactions, it is defined by the protocol 
   * and corresponding VIP constraints 
   */
  rand xact_size_enum xact_size = XACT_SIZE_64BIT;

  /** Indicates the type of address generation 
   * If set to sequential, a sequential range of address value starting from
   * base_addr will be used.  
   * If set to twomin, a two dimensional address
   * pattern is used. Check description of properties below for details.  
   * If set to random, random values between base_addr and
   * base_addr+addr_xrange-1 is used. Values will be chosen such that all
   * the valid paths to slaves from this master are covered.
   */
  rand addr_val_type_enum addr_gen_type = SEQUENTIAL;
  
  /** The base address to be used for address generation */
  rand bit[63:0] base_addr = 0;

  /** Address range to be used for various address patterns. If addr is
   * sequential, sequential addressing is used from base_addr until it
   * reaches base_addr + addr_xrange - 1, upon which the next transaction
   * will use base_addr as the address. If addr is twodim, after a
   * transaction uses address specified by (base_addr + addr_xrange - 1),
   * the next transaction uses address specified by (base_addr +
   * addr_twodim_stride). This pattern continues until addr_twodim_yrange is
   * reached. If addr is random, base_addr + addr_xrange  1 indicates the
   * maximum address that can be generated 
   */
  rand bit[63:0] addr_xrange = (1 << 64) - 1;

  /** Valid if addr is twodim. This determines the offset of each new row */
  rand bit[63:0] addr_twodim_stride;

  /** Valid if addr is twodim. After a transaction uses address specified by
   * (base_addr + addr_twodim_yrange  - addr_twodim_stride +
   * addr_twodim_xrange  1), the next transaction uses address specified by
   * base_addr. 
   */
  rand bit[63:0] addr_twodim_yrange;


  /** Indicates whether fixed, cycle or random data is to be used for
   * transactions. If set to fixed, a fixed data value as indicated in
   * data_min is used.  If set to cycle, a range of data values is cycled
   * through from data_min to data_max. If set to random, a random
   * data value is used between data_min and data_max.
   */
  rand attr_val_type_enum data_gen_type = RANDOM;

  /**
   * The lower bound of data value to be used.
   * Valid if data is set to cycle
   */
  rand bit[1023:0] data_min;

  /**
   * The upper bound of data value to be used.
   * Valid if data is set to cycle
   */
  rand bit[1023:0] data_max;

  /** 
   * Name of input events based on which this traffic profile will 
   * will start. The traffic profile will start if any of the input events are triggered.
   * The names given in this variable should be associated with the output event of some
   * other profile, so that this traffic profile
   * will start based on when the output event is triggered. 
   */
  string input_events[];

  /** 
   * Name of output events triggered from this traffic profile at pre-defined
   * points which are specified in output_event_type. The names given in this
   * variable should be associated with the input event of some other profile,
   * which will will start based on when the output event is triggered. 
   */
  string output_events[];

  /**
   * Indicates the pre-defined points at which the output events given in output_event
   * must be triggered
   * If set to END_OF_PROFILE, the output event is triggered when the last transaction from the profile is complete
   * If set to END_OF_FRAME_TIME, the output event is triggered every frame_time number of cycles
   * If set to END_OF_FRAME_SIZE, the output event is triggered after every frame_size number of bytes are transmitted
   */
  output_event_type_enum output_event_type[];

`ifndef SVT_VMM_TECHNOLOGY
  /** Event pool for input events */
  svt_event_pool input_event_pool;

  /** Event pool for output events */
  svt_event_pool output_event_pool;
`endif

  /**
   * Applicable if any of the output_event_type is END_OF_FRAME_TIME.
   * Indicates the number of cycles after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_time number
   * of cycles
   */
  rand int frame_time = `SVT_TRAFFIC_MAX_FRAME_TIME;

  /**
   * Applicable if any of the output_event_type is END_OF_FRAME_SIZE.
   * Indicates the number of bytes after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_size number
   * of bytes are transmitted. 
   */
  rand int frame_size = `SVT_TRAFFIC_MAX_FRAME_SIZE;

  constraint valid_ranges {
    frame_time > 0;
    frame_time < `SVT_TRAFFIC_MAX_FRAME_TIME;
    frame_size >= xact_size; // Transaction size for one transaction
    frame_size <= `SVT_TRAFFIC_MAX_FRAME_SIZE;
    total_num_bytes > 0;
    total_num_bytes <= `SVT_TRAFFIC_MAX_TOTAL_NUM_BYTES;
  }

  constraint reasonable_data_val {
    data_max >= data_min;
  }


  
`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_traffic_profile_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new traffic profile instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new traffic profile instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_traffic_profile_transaction", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_traffic_profile_transaction)
  `svt_field_object(write_fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(read_fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(write_fifo_rate_control, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(read_fifo_rate_control, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_data_member_end(svt_traffic_profile_transaction)


  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  //----------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the fields to get only the fields to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();
 // ----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
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

 // ----------------------------------------------------------------------------
   /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);
 // ----------------------------------------------------------------------------

  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   //extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

//-----------------------------------------------------------------------------------
/**
  * This method is used to set object_type for bus_activity when
  * bus_activity is getting started on the bus .
  * This method is used by pa writer class in generating XML/FSDB 
  */
   // TBD: Add when PA is supported
  //extern function void  set_pa_data(string typ = "" ,string channel  ="");
 
//-----------------------------------------------------------------------------------
  /**
  * This method is used to  delate  object_type for bus_activity when bus _activity 
  * ends on the bus .
  * This methid is used by pa writer class  in generating XML/FSDB 
  */
   // TBD: Add when PA is supported
  //extern function void clear_pa_data();
  
//------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
   // TBD: Add when PA is supported
  //extern virtual function string get_uid();

endclass

`protected
<P#eK_QR0/6T;&E:.e^Fg9\N6Y0E219@;\M8G)4:R+BS/dN)a+WC,)W4PKT)G&d\
1D]MeEIY)VaFA5N\<D;SU[gb/Z3/SVXIFCHgg6W[>Gc9,.R+Y6f<:B/2U8Gb>HSe
T/\.M[8Y+KN]QcH0b4QTIK?9CJ1:57#ZO40a5=J&GF8K&2,>:19J<102NgYM)0:A
cX52-9)ED:A)J>/3J[+Q4YEG[<-CN7=)b.PT.G?YA(&HbW).C[,#SSL:@\aB+L=?
>?#I16)01<V^RY82#UgHf^L[;dO\aC(?aRNQJ00?Nb=(<8g<?;b:,/e4_/:O=24S
\>V>RA,b3AcCL.e_&5g/Y49):N:f++AVf1Q:,CffB<H+)T#Q+R_MD]^/Ug9;&/Z8
-,?[15B]ge()@6K<X;FADe=3g8gaUWP>;OeY<feC:IR1OD1<@Z^W2R=6NaW?/5.)
VOWEB_b4[M)2f;Q>Q8_RNH6#-a\@HS2W>?f]<N#g9M^M0[8^Hd\8gR0f10J]-QHD
8V16@,c]fdD.@).]K>438:)?]b3@V+9:)UG.M?#SHd@f[B@RY5<;_\=#3E&:3H,K
(Z&gI>_&V^7EBaIYcc&LT,d)a9LbO-D\KR-#gH_<=PbZQZERV(:HR9ANJ0IW[I@@
HS_cUN@_\<@]=NaX:?cd^GG4K&/bM:^2\SHMX2G@Tb7b^8Z2-NYNM9(7U5RHCZ@M
bMX-f03VYdF)=LKggf67b1=Ie4Dd4(9f3O4R=>D5N,S95_7>NbYMJIAU,DT=ZSY.
802bR;U<D^MBBfU/-5@FF[Rc_UEb2@/+7]4Ca,],27EZ6T6/9;^P/_I6[)SZ>5Ic
gJRUQE)W<eF^2DY8&c@P4UV9&E<Z_P1d;\1;W\b_LR)8&\=W/@IHZMQM2XVJ2N?,
bI>9=SXRN<WgbV@R&F7MJ5&CLE>OC)K+DZeFO;X,0=dTCQZQRdO0@58^;IBRQ#aY
3Kd.,@K6dbGZ7_DSS)817=TV5O1QR+\/#,4:5KfJ\,bX_IJ&<I8.KHD5CVWFAE[Q
CM>b>SVES>AM_1C1-8aT-)[Jb[G?B2OCM3&E0MY+Tg\eg]fH:;M2#_P167BR7L:d
eHC3F]O;?QbW[>5-4,cV(FMO:^DD-]PUcF43&2T6FUe;3WIeABBRWY<:B5K?6]CG
A9+H#9U1<[WM2d^\f3cMCRGfR9M,6:B>XB/;T]PW#6)OH=Q].7A<dV1A[KYcJe3g
N/fAd;QPbceg&SP-M;#G0,;B3d?))H=K,>ZA;+Z<>c-PVWB0&N8YgTfM#+V.IFf]
Y;cGE2\B0QEP;SHa@fb2EX:7=Y@WW.SdI^#2(fELb@(NZ<DBE@aB)(/b//]a+S8g
NZ);#Fd_VUC>TK^:0Z=_dfIE97ARe10Bf4:C:6fE3:B30W#e2dF=-IdV4SIMU+\F
?ePf6BCM^#M)b.T8.E\fdKZJSFL>J[^/Q);+:3,O9/)4b<FROD&FR>O/N>bC-JG^
AV9PKD/E&#A7=.aU]gf#F9\ZZe\f:?14/ee.5(GY1(]HZCL4.?#Q<)Dd;M5eC<>2
)LVg0VA(R860_fB_.f;g><^I>KA@/0\gXB#d#+];V9;Na2#]#@U?F[#J_/Yf(+.@
23OFX4691@_K<\RQ.M(32R&P-VSaa)NfNNeGW##)?1W)<.PTY+<2+V,GSTIECG>H
T81Ug8]7^ZOY8+<;,K[B.C4H?/XVCfU1Nd6)HS#3S/?,cHS.7B2\WR4=;0e<c_^6
#d::DG<#eF(RD1:71=;\J>6HM=NJ^I4[beLXgJ5QUDLSFD#:W?<06B_Ca38GJIAN
3f3E&G#=9>gRVO#;[(R)^ITf@QZ9@))30.ZJEJ0=_07?XNA4T=I9/R^PR;A1K]=:
^-d:3-L<CO-H#K[H_57F2Mf]>c#-&FH<PS^F#[OI7[[61X./Eb&IFM?.Y-,1O14(
RPSN=\K9H=S2#[;205[F9eS)1T]<^G?;AR-U3IO^T4)59?D2,\;L9-BCT[#;.[85
-T>.NU&O^PN1ST93]\\>3]W+^&#I7]A.09/<Q),ZB91A_YN\@IKMGF@13FCN<NF)
50BRBVebYHRQ^A:I3V#17:R1X4?DZS9A>+R=]MS,[(3<R?Vfae(0A@P<<1T/S8CY
I(6];;A&3W5Y-)3<JG8W@cUc4CJ.1Z^+2b:]E:P.+\&MT)<2@RECYX7-B/O-)7(F
Ub>d)fW\/K);6H#2e[0E,\6A>C4;\_<Sb/A)Ke7Ga\YGMI<@TcIDKD3L\<:5Z1@?
,++U].L=43L?LHOO)][450d4(aW(+AUE&RQ6T2J\.GCge07Y3UCPF8<4.KcFW5-;
=YB<ePK)^STP5VV4M4B,6a.GFMLLTJG.QHJaWGPabdXRX,=L725H=bH&[9Nb8D:)
YUG4PcT/<Z)X_F(;R0K/71<J6=TZUPc)&)&^+97,[2<BOPVQaW54-)#I,L1a5g)6
I6Uf#^9][X4G8ab@NR.dLX1@<2WX3ff]>R2767UX7H;S<D<gS>M6:Z(C)F&V:H?A
3IDV]7ME&G^4IGJD]Y^,HbfY57H39#AGB^cNF&8G+]U2?3c_Cd=LGIT<G?&QYTT0
PMP&?9dD7fU5g-,Dc/3H@c<@+23DU:(L/O=OD4K10A3;g.c(#P\DI9>O3NJ[a5X&
IFTGKN)EgZ0,@Y9X/5R@D4DTKg?&IC>?6D\Uc7a4fd1e82YZ0R,fLMQHVQePA\Nf
H6R&5(?C\TfDK-\cQV62@Va_J]W8;ZL?Fg1<+X-]6,bIK?Wd:[4-,eH09[]ZeM_3
eS1)cb31QT2P99;&3c_G?dFc[ED,2-(db4\aZ]5F72GI-=#gQ[PJdHQ37O_?eF6H
N=gB/6^#I)g@(S>IU@RQFXIb\+FPK9=<#0Ec>M:UQ\2Zf>B?cDDX1JDe:eg-=Qb>
XF(8Q0@\f3=0K^M@7D8EVOP5Z5-<2b;5[83K1Y=P\&:4V2-6K7Q4=+JdfI#;+=V5
1a?g6VEA^[:X4N:6aGC((08TQ>Kf:&)Z[F+EE2_?V)\;<7H:JRQ](0ONY0cCH/Ob
&?aTJ^/K>JK.-eX],bD/UE;G0C3:(D)(1&g&X3FYTRS3L(Uf+W4J:e4-6eQ@B#D=
SH33b)FI19NXMdNX?NaFJI4D.]c.Z<cb]4:P53]>\>eG?8G3RWZ4;J[-S\6f=2fZ
SYEPOEP@[Ff-UG8E4#/[O8:&Ha:]76bRB#f7-@,WY&C1<M4J6:#IOXOf_QF:B@W;
,L2I=3b[1R<QM5O&[54M5FM&;TZ@LDIUR:>J-D\7F12KWBCLaNJ.J>dWS8W>_;Y^
/e1BQaZL=.D;QZ^CAV)4VYb=#d3H\]M2,d4Me)NKD,g0[^XO\aW&7eX>;,OEF)bD
<e2T))e>W_gc[B=PJ1aF4;</0cOZWd)_g>[cV+X6T;LV<ceVN_C#,Kb/7Q^4.#F]
2+_;+W+7]]Q>5W@WgNQ.^)#32A^LC?+C/bDP)=G<SPefPOI<#QCELW]Ze.gKANa<
>)N-7V:9[TN0FJ22ZeB9BNB#H[94TCO56\&GL:RM71]^A@I.5a(#D5C25L3X@ddB
K>W9+E>I.Q8f,bA6CRJHGc()1R>^#)H9]Z.#_3)BeG(ML5I=Laa?Y(Z7-P.f+f<,
>3/3IY?&F4F53dMG6#^8)P1c:)_@6fGf>2JfI-^gF/.QXa=I6H(+H<C#^2Ya8&W_
(YF<<2b^Lc=(8c],(#..81WK_W<(Ic+9MO9EZ_0:DPH2^U,P/;[dge^Bd1WfVSg_
Y4IcTeZ@_V,:47^_FYZ\e9ZDP5>8Yg02GFH<J\1=:R=8)&SRcW+69dQHIH4U+\0K
d8@Mf4V15<WV5IV+3?V<)U9E4WX/=SW(YN)O;_(eb?.5M8),O)YR#ZeUS3<W.LdS
9S#<TF4+B/N]^]J6B>-[+)KS=IH,RX<W&2@NM@bXWXF=;+Ac)3UddWI.[8J@MX=a
&S:R,3IYXZCUM5Qg73Wa&)AO]@eee+GZ=+Hc.M4P_HgWXX2O(ZN#d.dS/KQ,SERd
D#VJ6-L&dS)&-6T:;GT@ZWLSe&@R9;IOB#ZXH,?bUF[c_G0FYX^;593ADS&CS7?a
H@P6W7I\CIMN9J\OQGXKKL;Q1OVGeRdE5JG.K)6^F_W_.,HRf,([d&[H\EDf\/CC
@V51CR/Y<2P4J5JRaH8-OI-8NT_6gFTa4L1J0FU1HWbAK>:7]CF2gW9<14WVP+8W
LC<U6>#60&MgRK-PX]H.M9fN;A>70?S[S+Zc86,g&PATPD\acXg?DH]3^B<c0,]D
Q+BV<_VKf]6SQZVJc1Sc3Xg;O]Q-L52[+eH@C^(#\4P]DG]<&:ZAWfS;[UddM\N4
X(UCXGYY/?AQ(7cG3RHg+D8Mc,eFgEb_5D3\JAK<YU7^fEHe4F5cR9]S17+6Ce#B
gf7-8&DX9R&]+<:ZSHb=VK+D(Xg8>/g9e;(C@840e,]CR0.D@6.4A<FgLf<B4?^A
.LILK>/A/,4SCP;1@3[7.2JNC+]2G#=;]c)dWU(ZYL/f=GI,G?E<&.XMP&dfbF-J
9Q,)[bMP=NXU@;U/RCDEI(XgEC4<De)aHI01X#[B__Y71J.J0LVdX+36WKY#\aOd
PB#L&bf4SU2JSAJF3;43.Z3ga[edbET6MH?1(UKDM?-&;QdDc8E5d5=Uc/IC2Y],
9))(e8f3(0].[AR(IE&]Z(eU.#UIa)+5bOT(+Ef@+a/\9D8O+S(gIZR_G,/7MA.5
fcZPF@S0ZbUE8R1-VZGT[5VbJ_;2+0B>YLJ#B6eV6UOR]?CM8P+Q?CE.gf0c0\]Z
O&1c<^]U^&]\OOS[3CG)PU=<+SdC(:8ZJ7Z3eUBP3L<(&SFe;MI]UH@0(2J>UcEX
bdE6S\TBf1KN_6(.F^HN9;e2L9d8J-7df]b2TB1<N]a^D.@6#(>e2-CW:KJd35L5
1D.#b^e9BR#-+4.KfD=)C3?RC73.db&F4;/YA#WK4Pb)G2:g-88^D&G.571AE(68
;ge&-GG0PF>0=SUA6aI@(8R3T)P0DULX0UWcc3-1+HL=DPXCXfR+c(WA=69a8(8f
-5MFQ\]QAF2efFb8EU41DdD0cF.cL4gfLI3eQS:T:]OU1WL;+56d^)BO32-a1A3[
Oc)[CQ\Jg2e:He-)@))PbT9e[KXBfJ7]BJa=1+fW\<a3J9)9X]M:;^K.Zc?1b[R.
T:>?_(6F9&M2bA0Gb;FHYM=>8dX01XW@f&K#[)M4<;I@c\C8[FG-Y2Y3A;VPb:T>
PBfd^+((9#-YF[3:\;4W7R9^?]JXCD5OZDg2PbY44_)L[;Z7.76OM=KV2N8A:(WG
:[GF;C)TZQ^F?<f51ZEceV-G)MHK0@Tb@+>cU-H>bB8O1@5RW#/FgCdN-@#aX=35
fb1#&W:W>?JI[5a)P(Y4:N3@d9WCXDG+FJFF^E(>5[,X88G-ZBH]\[&0FJ]>-5g,
LfbRXQ8;C4L;ca^fJT98?9ZK&M;/f^a#Z65YQX7RR:f<d.>YQ_NZ>&-#gKf)O&V3
=<]ZX-^B#)?GW>^(-A(9XOd?/d.?H#G<LT:5.D2^IDQfcXgI&[a>WNJ+0@2R<QAR
bcE39b#.U\&71X?_0=&J_)M71:2:C[8F(.5P:ce.;#eC8_4^U0NZ(Y9UJFJ_0UU:
:=)BCGcC;DF28@=)PC<JPB-UCCCTQ8=B-F4:dZC/7F+WbV0OEfFUR,Wd7S_W?Z>4
>b+(]U@1FLNL84c9LO9LHU,,<<gPSB@?O/K=@G1aT=F#3&;]]BT5&(dUE-MG4H>P
9Je/4#gWg6e(VRF#>#T9,]U[6Z;1ELca5:#>#.0dgE;_6&;@VeZ&eHRX@+SA=;91
bGFg0NI)@HIA=cH5a6W_+d:6,TVV+gJ;;I]+IMP,.d2g#EO0,;,M,.LL1(MVA7)#
8[PCX2EH4L&M\g#g]5YFO((;5Y)^FGCfdVIT,c@O4XK6YOH4+DXKG1d1e13X:MRa
d^?)K&gf\F5AIe(<1EB5ODEa=+1-C8,KB4/B]XCEO1:]Ce1T4Eg_gbaG@DAgI+\=
G2RM;T4V<b.a5#+Mf-@4#3[db;A:XCW6_<_-D=Y6NC?N7CCHcg-J#:;W[If@E#3a
PL58Ue&29YP&DCUMDD4d_6/?/_.2QN-H(GHd0c,(3#+D/9f6GN8.L>)FK4[>;?C]
c@7T+cD)TL:Q2)]ZMG7A^?YfP^M8@_--;9H#07D^:#5FT=RO53b]TQL=\:+-e41&
F>G[/gUX-SgYOc:?eVBe>WFH]9^CDES+a(]<XU1PE,3BXW#TU#Fc#fB_P--/e?X+
Qa3>G=@5P2TGP4AJ:6F)UN12Q.N.IL(:d,A^IOUXG]\]\,:D#c4I:=/N]6FLBeJW
=g;6WA7\;CJ#_+a-\>BFD33)KA==e(Q)/EP)D23-Tf\[M)B[1G5Ta@dE;e<(beO9
).>R+b3_FAeS0T:DW&G>)+YQ14V[/2354N<CEYV7][5BN(ZbgMa9&;a1f(VJFZU>
6R_-Y&d?451JOB6M2F)OacJV+R(HQ-9?J(=LMJ@Y_2R\5/I462+J\c<?MA-,#4<Y
0;CU+?T2WC,aR[-aa_+8Q94AB]aV04W5,6If/3=3.9XcX;YgZ6WX;]7]NbYLE7-^
3U[Q1)B6ZF9A,>B)0R#X+eaN(L1J]<VDC]#,-9:fH6X.<Q8=(5RCH7M?=L/=-Ve7
;#EbOd/eEV0We+QQ]Z(>Kd1M6[N^-<B8Ef9H\TM.5JY<,8ILW(bX00LB()>S2X65
4]-T2Q)1QU>,ATa:ca=??@_VaaYT^R(;;7;_KSY7<&_G0S[IbAOB;C.D#D;R(eLV
@HW_:F#68R)E8Z6cM?#5;12c1JEBQc7]#;1@;DOFHYbRfB]e-\2M0=+,6a=E:0F]
-6_:bJK1-J30D0f5SF<>4Aa:)NC6?GGG70;KD,WBe-;<,)^H8@gcP4G,PM#SQ)I&
OOAG&4C.?/d4X2Ig4=9AE];W=TVbXUM4,7Se1_^Md(&B?/THRI/M9HRbA/g8&0_U
30Qb<B,,c)DSMAW>36,J:c:TQ_\N@E6\.6(>L+1QE2>R+dE0TA^,d-_eJ3gU5_5P
Y=[b]0CO2,Q;B&NI-ZdgI?H-MB_?dH#6^@f1#4H-/6Mc>8+(]ULMYK<L,_TW8C[Z
@cXaVQW@QIU+E)f#PCeTMc)7[N.&0RRI/.QT1O).-C#I^K@MG0F.BP/-K4ZKJ2)T
;MQR^+QS+ZHOb5,KCL0ANU+UAR.FPF=96O=/2T30AgX^74>fG8Rc#+e[RR42-<XB
7Kc+.(U3XP)L<?\0<(IJQ:>/_9;>QeC9EVK<YA)_Ub=\LUK/<B+JU[.B2N./D4AZ
U,WI#1dQFJ?JYS?6\2;Ma[[[5)/UTCQJ#0D#;EL=9.FGC7HYbF-RD8&bQNKDe)b4
S:e^]JWY.82;C@_IS9>9QYAI7dS5&@^98+QHaR&c+\OG2<P)0=WebCQ-K;J=eQOQ
FAbdAB^&F5C^B3gBg]CBCYYKg5db75K8I3<+[E.L9,QNEe[V0aNTgD.=fY5L(1/5
S4ZM]6@#+B9TJ>f>NM);YD:caR,P_F#?^1eT_JZg5YJXRRG)8GZ(M27L)D2N]C>5
4e>#cd_AV\XgDH:R(&BFbD97>:OF,I+Fc;9bSJ6G:[5G6)](/[;RKCKBH+:K)KB6
75Ce)9^A.>9e?4Y_.:Bdb?UHf9H7C(/Y;aEGH^XQ+cMFO^FR33[AN(gF&,2a^&(7
+9/XZT/fH0)Db&:/_KWY\Qg^YfBd^BJ@43P17.OA>_Ka3-Z8G<666]9?_(70M@&8
6C5)c;5RD?.-<#d9RFTN17X^2V:\b<J=^9;.)H.AFaUS=>;beE@;YfR.4QL8N+eA
WJJN[5f)b+a3WaI&X^.RReHE7U76[L=W2V_L#Ve6VKDK9ZccDLQB-E1UTc=Z)c]+
MTPVM19@);F&OA1^S>/&MB[.0H6=22Q880@cS,JSCON;?HS/]0&M7Sa(A0:_0\K<
<T=?7WG;A(_C5\I._V:I)_RZO^S(b9P[72=cW1GaZ1gTTY)2)<?4DMHO;2d863NV
S9BW9CcK#9YI\1QG@((=4.B[]fP2^c]^@@CUQ86Q+9(^13)?(U_[TE>A5J\?S.C&
9fS2<H)0BdIGGgE,^L3BFS2/e7?6?/7NL-2:QcX=CZ3+D[KQ.&WKR>O^dR<N8b/C
E0>3W#GeMg(Q>ge\N)HLeHS20CI>JK,Q^H_>,N[=N,?DNcLGb]]VAKN^A>f=^]\C
ZXJJ.,]M+8K5DY@2#P+_M@MWcGZ=6f,2gH9W]eb-7B]AZf5_MM]F=gVef@f/N?_8
3SDF7N>#+2:5WP\]<7M[6P4.D4:K1A^gNdNa.;c4fN7HeW,8HL\-6M@[7?R-dbN_
f6VMYCPRC46d7SRSR9._D_T6B)R&9K7W-O:.McZ0Zf>[+6F.\>((ADOZ&f,_I/0<
I71^TO&V>V/^3X3ZU94].Y3LJbZ>F;1b6a7O)2ZQFQ;<J.a_Kd#RYc\EgPbb1P=_
TZ?@RC6=.a9MaHQbMdFXK\H,CLG7#@](Va_G(UF=gG<a]VV17[^E>Y-7>^cJW92)
=;^&937?\VK5^@0>FM_>A,ecUd#?5C^GO53YIgJbfVX)R[W_K,SB[Db>WO]3Z-1N
[&gJ2FD:SA9CYA?dIWcf+Q=7(BB)>;[&dg,XWOEGY9-^G-:=[e5I3K0Lb6700#@\
JQR;6<-.;Kd@<TM#=9:>8ISQ0dDV^U<?E9)WV9dcFS9C92_86SG(;UP<P=LeB_&G
fG.[\MA3_#(D?<WRU@<+1A?S(;C):CgG-KZ/M^YS3R=gd&J-;FdL-,TMX[)^:W,.
cZ?f3W_Q<W[@HWP?E=;2#Z3#cJFL+N^.KK1,YHZa/cb)>_SF=D+[,?9?T0dG?A-e
V8\^0MU)[0bce+XH(Z)OOT-W0gKBT6SU8X(A3J5d5R(Y8c;bZ@SL(6^;-eWf;MU-
YE[JESF:.PfKHfI(BUU6/[JW_gQOFO(H[Vf)dbODR9eB)IFI6+@;2@X?O5LZ?,0X
:G??U84N2/A_bFgTbKJ3H:6dQc[=7DAM/Y+A@55:1IKP0YI#F_OLQK]HCNc\&6K+
:588a\K40<WH7X6aK+^NLO+#;JAE]gQ,D_6KgT6LQ?//QKZ1b8D>RA,.\8H8c@b@
fCS-1&>1;DYYaIaPT_6D1=0#\fE:1E^EE:UN7SHa\WL(8[D5&5aL[4HLQa<g2MUC
+9U==U-)YOP.dLf6Rb\d+FZC8@ER_:7]U]MV-Z#V6gNfAI5GXSZ0c@\U/6)_)\00
D#9REOCWZ8D9F<:()Ce@N^HFOd+OJ;8H<Jf>>DcGLd7SfH[e0[GTS3FCI4\WR@A.
a4MMK\8N=1/R@cE-I=Q/1gNGe#7)-9EQ_Q,+g(]JgFa.GSA)9-BO31Ba.(EJ44[M
>:-PJC7\-+(4MbSDR=<E/?&QMV;3+FaDD+JO5^=M+PBG.E]ATX010<_#G^Ce3_UC
]65CAW3WJJc5X#aGdZ4:5@f\/AZ#WC+SeJX+[)SFAg@XSVWM755fPY85IB\&QY+c
c[5\cb7UJ+T\@:&YdP2QM[3[&20/7_09?EE]5I#3Df)W&T#BfGZfFKQd+\Q?b><>
f1+.#O/Ag43eW>X>d849PDQCb8P#8KT^=<I04F^bN6EY=5@NQHX-W4b3dTB>&Y>5
V1]K421C06O6ID7JC[M&dN>@/<g#7L/eVMQd3.0&^[d[<>a.?d7SV:0cC[S\c&_-
2TbX4VBS)[,<S;8R<M4fBY>+?WcTZ+QJ/6LOBPf0GX@&5&(/CMCJ@\,43IHVTafD
0P=HGS6?9>EIQgH/X80Y?baH]WY1c@FV4IF+gPM\be?,EJ(LBH0K-)E/:f,^g-03
cNgM1EfBU]0g]X(.><?dEN@,3+<KObH;=]NUQH\8?FNSWb#UN4@-)<bJWZOVQNK[
7H6.<I_,^(ede.IF/-7.AI+)IT):G>MJ,E3)34<>+#.P6C-+C4YB\1XJ=0&W;A<&
;=SSGT.=9)0eWOA:8daGM6/^S5f.;[9;Y.FD=f=_1_D=>Y8e^-fNU@.:T5HM@1&,
[21+ZEC-5MF^=?@AH[EECDRJQe#gY7g7#4;Pf5@SYUXVa^KDWfWR-W=L:0\N9(5Y
3I0f()).KM86c4IbKTP/?[>\5O2_>]VIF=>Y8\ffZF_&Q<UIH:,_?TcXL3cPY:PW
E?ebc&R:5TLVY8LeF7+XDSf#.AE+=ZP<5GBdb@RA+F7c=9V)5)1XM_g_GDf5<aO0
A=0g?U;#^&7^ZY1GdA#bQ\QKUD3TLOM#WZ72T7AJCM+LMZKb.2MYEM0FH(@3U-X,
QJCdF/>=1LWUBB[][2WBdNN6W3/^26811HM4(B5U,Z9RH6;9-U:W].>0?d]I)JeY
;9QW:<1D[-:7;eT-a:#=_g7b)Z>^XOI:85#5F9D.W.)^f+XEBe^,.?,dQaf@]O]P
60@.5;>d:EKe;?#cGfHE+21DO^,=&U0-dfaf=#:\4P2LYG<DT1>^6A0_Y^ZFe7#6
,:WQOX3,5&9X8[68,C/,0[&^IS7JaaD>^M->04M/.68R;d/DRT5A+A-7;a9R:LU^
5);79f#DL/1:T2-;15[KRd+dRF8+GU1?_EFF>L\/S_.#b2(Z6QKJYOA3:)e\H#(T
L?_8Uf^X.XO..+&HYOS9RHdFMBgQX5/QF&6:E&[=Q12],a:OTE/=[4V)[DBV.,>W
:0LOBVL77]Xe1=6GHY2K@.O+A(]]3aA?JZB];57N@5[<N=OJT<]649FR&X-1B3eO
&3N[[4f,WX[MCfU#/PO_a]ATXX+]_I1_]=-4O2G9bXLFa7W3ZRBDZIHfHQ&c-Y1S
fO,,ZK/\Ng<)6YN8XKC4EM]f>M;g.O=WC[14IJ5GMb,@JgA/Z0a<f[^=6?#].-W^
MaS7#:57gB@);0F+C\?a1Cf8[)(UY0c&G16c81+-cFK\UP#W+Y6[=5V2;3#NX3L:
OF\g?>#\Mf\#BZTMY4^c0A#9fX<]U^:gYbS(9Pe&gO6VA2@QC&>L2@RFg8PF9DcO
(gP=YJF&Kc-J\fI#,/ZQYEMQ3;A_-:-6E@=Q.cFFd^D4dIbd:V:6JU<6/5b1Z@aZ
1L;O;QEG.VGPQY5aKaOd[eF+GeeM<(=+d#J,d_:G+JVC6(DQ=e)O7e4dZEGD.+_]
5L)Ga@<=WE@&^UGAPbR1T+[S5Z#HS>M91IQ?J,PLAJP=ZVL8e>Cf-HKN.bLO-ZXA
6cJ&+S3He=I,Ea_N?H;W_(73Ge#(fAC86Wc5Y\,FE)9fF\6DE./&P^dBeBL;DcR1
X[VVSDZO\\>R^MG9?APA(?T8c)?<ZAR80Q:TL-YM&66fHML&e5Q+PESVL+GCc0U2
^4#PgG-,R=/c/YT):F<a[aSd?fJeg@P2^3((b]2;07LVAbSTG[[BQ8BS\c\_8+D&
&dfEd8#RGcKVFF#-(H>#8:>+JN6][RU.W(NUIF;:Rc[e12&XZN9)_),D6YPN0Q;V
12,MHSB#-\;88dVbZLXe]KR.J8UXUT#GM&7)?JMZe:<C)V^[<.ROL#Ob3+\E+.1X
P][9/=^fT=>/bZV)VLHe<fA.[Za?/bWBPY)7<agIL[&g2...6C/?<V.:FF6R7VQ=
abPJMZ2RdHZPG^YO70>=5bP#d]_D;5MH42R3M_7,Z&S</9ga9_\[HJC17_<]?LM8
U[d/+._C#]M5&[Y_9([&.XTe_E0e,ZOP-+EE5V^&5;>:NKH.g6MICRdIPNf>C7T0
XL<fa[2Gf3AW(dPg[+Z^cHHgeLde;NT-CSGNDNP(#&GD4If<-70OC,-9ab#-/e6P
]TY24]^1c_;NS@cZC\\D,/8Y3M@@>fdKYadS7+JI7H6L&^N]]&RgKDF+CHTa0Z;1
<:M_.T[<R(&AGb+NHL)Q#7c=2OKLQeMg_?[<AcLRgAd=7VB5GV(1F1ZQXV]&(1=-
]fg2:bD+,<]&=3]4FT[2[)LA4<S;;D6;<>[4e8N(EA\MF=K7ELg4Qe=G]:=6dO8G
Q2.bb&FKVf[?68VVECgQ2gdELNG.<#Cg;cVa_YH-RSWQK[;R2.?;<S5;_,-&Y22e
A1&0)-@cgcM1Z3bFV(5TY+9Hb-AJ.Ga/273]2;PB+_54],=dD4CGb3N^45M>#1G>
LI,)LT?3370KdEC>bVgP=/=IbH;C,A#8LNYeF77H@PDO8Y@PgP7Ka1-Df?e304bD
B:ZC;VLgX<6RQH9:decP_/VO]E0N>^1NN:&C)EQ_=K8>8U8SA080YX995+LXV,JW
7L]edccFXL(gRO;+81_?TYQ^?RYN@2DW+1S=TcI^7)@NbdJT9d9KMg50d?0LB;\G
d9(McV>gb<.LJUN.(AE:JDLeaYXU33:J2XHP<,g/S/P9>8:d.Y4>?:;[PRg).H[3
KP0BJU,LMd:US7=J#I;:]AGOg@.PHc@7__RN&?X2.QB^9FTI&98eVH2BDR>B5>IE
F6JR>If5.gAd>>[edW^dK-<ZCHP&I=+JR@ONb-RM#4_?Q&@H3M^g7P<&UCe@LW8E
1fdF[C^TND6XLVQ.;;6\1Bd?^@U/7OC8T@74fW_R1c.QI+YTE8AF;97fgb\S1g:a
Z0S?:cN?UMPZV^[>1Jf]L&>+E[AM))gK3QK6PU0R8Q^&;3^bP)ZPfNe;7JL/^IT-
A/OS>^N,?RI@Z5-?CPZ[)XWHV9_KU7MQANW_S6(^Q3S@BREd\+4@dQEFFO=+VJ38
KJ+:35W5S:VbdfE]DZ@EZ40.L)QH^M4D<ZO3=3?JC_/5&12K=IXIDd(U9eNG8<X.
(ER02d;JD;H<39:42AL2#56]#?.IZ4_fG)[QMeW;c[fP1/<dZ_]^^Hf3RdSD#QUO
gTG^OEbX_W-QXDD4LDL>P4Z&D6;(>;aKH+[3GFPUZ(6\\1Z.B)g>3W&VD5\CF&+&
UN/=U9Q,d(7gPYLJZ\2+6:,)g:)#?Y9(L=e]eEC7R)+]^VVZH4R8,\8?\MRVc2XE
2HJCQQ:9->/70ZYSa[;9J9fePSK]R(O+&Q/.Q\3F),KSZ)3fMS]L6H2557/@=45_
S(E<^W)e<6==^&CY6)L2D3XU/RHRL[eZ\1c9_WeeWf>+YX+0]5Z-V@(W)3L_K1CU
BS5e&X8NV2bZ>VAcegXCE2[c@^?>[ZO6<DHcE:X_W6Ja<,28dF9>U\7]MCGcEI^4
-ZE6deMW?+eTAK&R;D0:X,.W+>KYZ2^O#E_BK+Y(bT)KLfHR6(SO#-3-1E.0MVPE
/CPaFM&P65dH->g4)XK8+E[9[g8Bg_ZNU4L9-8#YeO<JIDLEc<NAI)#,/VSMI:RT
dTD36;^GJ]/[5(Ga&[541YB#NTR95^Ce9IJZ0Z\d#=V<A+2F)a(7L?O&K^(16XgJ
)5MdQ+HD0W1#4f#(ONV^ZWS#/AK2J/.<=#TcgAVI<F/g?-9R1<G8L3:PACdZZZCY
;L]VM(HO7M/@@8e+PXS_d&.XVW]/N,a^Y#)g/YNR+I3P723[cI9RBS<TFedZR.Kg
1aE=d4gdfALD1/ZL]&T>TKXQN.7D2e6ebY1I[U?QA-U3QN]X6U;>Z#53&[PLZB3U
cR=aZ+YAA2X8HZ?<;O626Kc9.8IYDa(a70HGXeFf+a---A-3f:Z0OGE,fR491TW=
.AW_CHGJ3#ABdMF8GbV@3DQT4/3^Z&&MJ:(#CCN0A@P(#T),_EU_AM9<H1H1H+D4
Ua,fg\I06dedG-\>D>MUDNA.70?c40KU7_CQR2QZ/UXFQ\ZXE<D)Bc;UCJ[BQ>KO
7g):CX=KAbLBH5RKD-e/+G(=1)]6a1X_RB.:S4dgET@^X7WS]6(b&,6G\:TG3FMJ
2bZJZQfR//C;[9)\VG+/H8T4P&TLW#H/#D@a^4IGX;-TDB2&g#O<2NfRJOZDOW[/
ZCR-DU+E5CSc>:A5M.QDgc+E&;5DgbJ0E&THR?F7:E/)&8=#&?WAM9ecY:0R&,Y1
d_B&E[(M1O9W\;7P]JY&15-EUC(0OXDQAK1FF/BY>B>@;WQGU>5e+W8<?#OD_8Q&
.D.,bI:X2@WY+2N-SX:[9G+MH,WX0FFc.D>>8YMgD&8cT?4CX<YYS=-_KU\SQB,)
.\QXdR8)]EQJW-)^N@-NKG;I]_P]1FP\]3<1c^,_eIX6#\T67;^QK[AKJg@gJG#1
c:<60Xe[2<dDM(R;6=YeY7F8-_.?678:.S-G:SSRGP8ATC0c[Q4JFbCQaT66]5BW
#<VA8>9Xb8C.I.0SffcG=#=OU)TQ=F.)cE+?aA+I/LbMRNK&bg\V..cPPXc,<9/)
EL^eB+E&)b=-Z;f#eR4PGXaTS+a\c7PC(:1\3V9#ZR.8@;U@KUd>#JJ0P&M+dT9?
1:3^@<:W_#[;C#DEGW0d7D3;6a?U#+=SHHc<N#1\,5f^AaTHVVO)CT]/&6K1/F<U
,O:M,+ScHO:gY3\(&I,=TK)9,_RV(G)T1^e53F0OPIGQ)J?MN-4XU2ZIT1Db8NC)
VFUMLD5R2H2:#>SI#WDb2XWI1RON>J6:_Ja;;8<M^1W5J/#PU^78J#5[GA?LN?BW
\ZRS;&G>SOYE7QTGR2#_PSF;1;\NV)-YUH7+N>0C]+HHH5MdUI+HN)9Yf;DPbPZI
[3fHBX^)<5d\8^f4&.1:Fe=RKOR0YC714D5Z0Sc63<2#I)52/0+7a]d(fB-:L(gd
cO=E1bB^He4;efGJ:GE=[XCNJ9J:69DLM300RVHB\[]8B0>G4f3_^KJ+2K7I(OaS
G<0=^7>JIfEbO+59E5J1)6&4Ha.\gE\5a)-.4VK5&:<d9HICeVKdF#;bU>-+OJ=I
>V5#^Ha;5@PR7R_-e.Da\L4L:_e/BQI<T#TGUO63F(?_=(eV:7YHf:8.A?e3Q2B-
TG.NO.KFB9I+P#J&G,CRMVa(:VAZP[\Q&.@/7O(?.B/P:#T\S^9R.:SVe9@Z,\eL
D[;S01C2T73>c<TLV0.9#7V-2O(>P_F#aG\_aQ<K0@UbQ_e>I46(b@S.f[.;:7a.
8)7</?[cUbF&7agPP6C=<#0N=_44#:S/I4-A5?W++L2dAafF>RYCK:&#B;R\W-<b
H;&>f;308VN/?@I2U6R\aL<5F>TS2XfJJ/^E1G,Y^8AXNCb#,]+B4+A#IR;##C^d
4e#(]60#<KXD/ISAK@UB.c:4d>P?WJJ68/6SHSSeNTeI1c@U]_[8X8^&@ScX_#;F
B&BR24(Oc;GET)4dI(>#&FUe=GE<F4:V&.GT5Dd^YH=N1;&?6MM.#)I_@Y,K?c1Z
6N/K=@F+U-M^)2A;[60f4OO/MUQ3Gd>9I=+EDMV5LIIa^S,BC6I?GE>(baD03N-K
;Uc04YT<D,f(6fL-].FJ[VVM5NT0SB0#.;QXNJ#X=2S@7J-R-PXDGF+e2[B>\#\<
U6UVC]K:Se]A=]K=),^DeSb_9a._)CRcY\Fg9EX3M@&&^_e@U,.IZRO>8:W/])fL
98g-g#=Sb9+3gg)^E7TEWSdE,e80PG0P0R.eR)EgUO2/b[&)Df4Yb0eB?e5aBE;#
<c]K.[@524=C^/HMC5,N-.ME/Q(VO1(#feME\W^-AV[cMI_SF#.(c4&Z:U\c75H,
QRFT[FNJSMAa0T:GebWJc:RR<Yb(S<0c._FP(-GAb#c?_Q[dR=6Rg(dP=4QP<8Fg
08B8d5-.TK<cR5U[D1=(23FEZ0N]&X6G3QF+FeT]Fdd+[A8_]_>cZ-<^a?YOAPX.
42.@ATY,:9R#(BeE3WQg0;KbUdZ?d\;JcfX3V(>cGW\DcHVdSE4<@P[=BX8bUT-0
W19d<,6_9.H\=1IYJBOEb5b;@Q);c.>1XK/-J]EO(_?&\RQeU@.#F1/N>IBX@VJ\
R@O_F3FTHB:0=_.6LT+#OTD(.#?\3Y&#@A#O[DR#<J<#^+EecCB:T+#cW,]\]L7+
d0bCW:HFEZ@W50f2?(b#4]8\O1EY,7//A168@dG/-@?cGQaY(J?PQg?FSX9NY&C6
</=gENbeA5@P,9),]TQ;A&b.V:C6JDR2L4ZFZQEM)VS4#9=-+7)NPE3P6<:[bgH=
3K[7;9CODXf&Y=TbQ?CSG[E6[2KT\fXH5N?SFXXe#53C1/\><;2<+(#d-.T=dcNP
&DHK?M4:D@a)SRb-W)66e5@MNc.2IJDJeJ8;4+6fVAbU7UKER7E6Fa4eGYY/7fOg
/IJU?MAIa#H@U+AG+cd.;-E2KB=.L1+dW-1+/7R?3bIc;/(O46J_8fNUZ.HJ:b;]
O4Q)1F=[0>g#Q1H8?(7W;A3=c(<Z)I4:LgdRW,6TFaK83KeHM,VRb)27gN]U>673
G6U\1&e+?2Ee2gfZK59X/^DXV2R@&\471a&-1@8?bC8NR<8R4U8\HfMd+>]>g>?_
d=WC2O.WMGNYZ5L,^bLG0Cg?a8g1PJaNE\e:JbC9]Hb2O)LICHVY24],04QgVLNO
V^14dMCVd;AS(3gbU4U.KVD\^WV2(Xg>+<U+[:O@E&3c:CI#A6=CGE7IHPf1ffTR
D9_65^)<WP8WF:_?DL)U8LSND(_G0R\f<CTOW4#&M&8Z6B+U092aJ7DZce^JLQRZ
=/8.G^(gAa/5g]M/[YT#JP&;A?dR0^S]Gg^_3JSQT9HgEQ5^P]I\#LLP0-(OEJ#=
eI@d04AQHSR4d@Q1DT<3d1R\eFD2\g=)J8f/==L38),[\fdAY0X2f5XO(a4H6<LC
<7&E<VJ<=2bRecRV?>)V.+;+7T5DfL&T0_+67dSMe2:(T5[N:c_a9a.R.1)V3ZE[
<]OeV9U7<3MLIKY5;Og1a-8gT(J1?06]_aMT-M(I]QNT5Y+O==C)8=-NQD@?0#[O
#bY?BPBC5,N#H/:QD7dA:45WR,^/P#^Q#9_((JWOADfLc^XO4&:gLb6L]YR2<4+2
Zde.>ROIHXc(3-;DU5Q2C_J-6UCbc7L[5;IS@NPPb-S;3MPLKGg5A#&2^,>Y1\H=
S)Z@N-FeG0^FTK_7Z[B#8gH0Q]DV#6UQCY2:g+R5:ZLKXK@)M\ZVgD)6P7IbIK9Z
>#0/UCH<UG;Y<B-E5M@2Y@P;7PQ)/I_B[N54:T,Q2NOGRa>B@9DZ\F[RNPUA.)]7
2c.Y]NDUf:egLQ;2bALLZJ7</6MBPWgEg4gdgJ)KDR]&>a@NKVH<2eMd=-29#SEI
5dA)8EULL?QFD)ME)bB2O(=I])4Y2dFd4\C9B#2TAXbWLR3LMda^HbIGUI?O0H4g
-MU?,OPYY5^W)AH(Eb=O<KH[+8E<=/8daE3+HIAH;Z[HU#I@-WeE^c718QKA\+N>
R>P+QQNKIO@0\,+;fP<&^LGH83DG226\;eAJ1(I5=G#6<K=8NT4BL6a7/c@77@F-
7T3,?>BLETC:J+2(AdV+NNGC&f)0?^-51/I&::D1Y(G,_]SZY9?<+XPOGL)^D>05
AM.0O83fSK6Ma3[YQWNdF8YX?eL^VIS32A;R8JD]W?F3G_(4)a0bLU;9F5>_,dEJ
G#3P9g.[EG+50B+<_(_8-2^WZ#N/BE2CN89dBTM@6a;0,?WfRabS6dD#AVG#BL2[
M+#Ca,-Gg>0e2/2&+C1LY9?CW]P?EHA\&A/2]I>,<11#b<JO;0]Gc(Z+YN/TZNB9
J#:a_NH)20US@>HeB3/W;@<[XgWd-dME&-:\LX(<ZK-C&cOT0g1+?d)2DRU^M4F:
G61=HMgg8\2IJ;Ea6]X-HQL0Kg0?4.ZEFGL_@S68EW\[[V6S0^8R1N4UUUKEG>[e
#?f0G34e3>-W0=1S9:4-9Ig;FeD\]Ta39^ME#>dgQI@cNb\W59)gFNMAYf0#NLH=
V_JO2ZRaHNg1R&U/P8Sa>7EVC?a.7>YN9UgPTAQ5K7<Fg11)=VYE@98VRG00P#&&
LWb:NPU5Y5N;H--8ZN7^4RAf;6IGN&BJ7&K<I(O.,GcbPC/<J-bV.cL0Eef^T<Zc
#8FY@L8C:E1a629X)2F[]@PWCDN9T81/#&Jb#1HYdVO/UaVSd0P.7g3AT:TO1fI+
L<a]cW6A9+Z0I[32Rf^A@5/S/L/FdU,.]^2:SI0eRFJf&+FQL)J.RV@U.Sa.=+0:
0(Y]K,.AD6R;[6G\=YI4M:&=W8F7VUbY=d.WLH),_X9:bc3LAMFNc3B,^/b:c)e,
QfUDCHT:Gb&9-R0D?(_f+0M<QY^C;GK5B?/BIYR/,Zc=@>->>WTC3QUe57+ZfZUM
VfLD\V_Z.7/_NPW,ZZB<+gT:@01)X,A.gKN[e8=&<+#cT7LA<R7C<\#[6D<gZ+?R
415Y^8/LE8A)fg1,]8&Ib:KNfFSZHMa9\_W6RHV8gI,.c>J?2bC2Of2aT;TRW1WT
1b,AXe@a3=]+S,AK&=)77Z_<7,#;NF0/P\#N]d/1dCd(Pd[FgQ-50eRMe@^Z:cB[
9Z;ET37O0<TW[1,H,Bf\=3<0f-4FG.^)@OQ_/95aMMDCR6bd+YFHG,)BP+Sgg_Z8
YM:5BgagH2UgL_:O(,B=g8:F6egdD^@LU;2]/P+7-Ne@9/dU3.KX#Sg,@<HQF(5f
gYN\6=eJZ+gdAYY6=E?I@eF#K^9;;SOOcTeH.:;M/O</BdP7[UWU,5=^JcQ-HIGV
S]5c:YLEAJ]>)g@JSa+b5W(00N5,C+69@bE&W9aWF0XfW]AYSG?f4R>,Cg@QN2/5
;S,;GJf]@,:;SaW0^f7QFBLNJ0+=:XJ_..N^G@?^Id_6JJ,@bV.P?MBR4FW-_gWX
HCP.,Z3BC]1Z06G.IdPGZ8PVde?^HYC]<9/4c7U;cXc9TYQCUV78PPCBY>+Z#gaH
fK&GL[]SF3K9QJcU72SOT4Be=T,S5&;_#-<W-ZQLU@_SG,O,^=E@=R1eDf2<136T
/AG/1;[gb3LDTa_GeXX&VX&UYa5cVb7W_6P:Z<WL]8H&g-#FVU4V<47Tc6f=O@,S
K]/FFZ61bZYXC76S#BYHYE[G5P^=,X)QSC<5TVX-KV(1Ua/)4X>]KEK/&_d@g;?>
Xe_.H2N59RM4\&KQJ\(GfWLVC)-<Db]NA(9Td^[6G]G8628Zf^J.U^?d2?EGFaM^
FGVGNg6U,J,.WSB&9-U9C?J540.MOa+:1IaWU)efN?VL&7MB^g6&A?8D8c;.M6Ac
2QB\GR<7^D:9>RGQPP:HPW1U5.I<=-HH8I+TK5LaDBEO)[2EY:g(@H,7+]U.5R/M
P1C#18Y8^D&,V\]RDMK#NC5J^g83^51gQ?c2(0SQK9P@10KD#EUg)Y@QBGOeDDA]
J[dL=L-/]LC+/bPJD<1\dVC\&6:ESg(^QZM,;UCYJ5TRaZDg8D>O[?(-e/(?F;3F
U:VaYZD_FS\2fO1(Ra]D41,YI&SaXQ^@(2>PPFR#,E.Mc5MQ^H(0]Ege,PX^SVY7
EKVCI:PO6Y4;UFg?d:19EE^Z#e^&,e)+B)8&S/;R]J;X9PG(-<dV#Ea79b\L]/Qa
I_F+/MaNY5E<e.&#eSJ<WS>X.bcL_XJ;TJg(S/&T.XCMEFJ\J0^5>WN^,1Y;S)GO
YXXKE-8&OL(M=bK_0U-4A0:Gf+/1Vee,B13(VaJ.gg:[1FgB^^BR5?EB\=+&d]7R
7]DcA2SRaKWJAKOc)/>:?TG+D4TeDAbea_V-e0SZKF>NZ8&X@7IE-g>]1Ac@:JJM
[+_da>R7;+E[.gd?^XPYMLAT-/L+a\YgS@b\T;C7CF/N:=6I)\C/>)O^4AUCGSfB
MbGF;.,A7fB61b^8M\#8@#f-[(7,AabFM.L#J6Lg6\\P,F\@d[(+OF91ME80_)e?
8-[J#FR#KKQN,0:@;[7I0A5(HDYPe]dR18U]fB4F[O7BWYY86GR13HcLCfCaV7@T
X8)4U,(<8MO&]W9JV+.-Sf[<WA]8H=c)d6Og.<9@^;\Z6O@6[5X5)>8cI3NB)K_/
Tf=dH^EOdRO0KSI5U>^F^X&=3MC(T9\5:A^?cC85OgM65M6Y=+=#I#&^cB@\a^=.
HL5#PV>4B-BKBHZYaYY\d.Z;IbTL>]1NP-&+X6\LY+^-LIYDbg);8c+92eL_WL\M
(c,\dP9a=8S?d6@Z5G3U2S5b4A_D6[?(e=S>O/HYLMf0L2P(fPXE7I<@&;HD:9E+
S=V(1O?W=.9:?9.TLCYXLEZEPX[(Y50gJJd3.=Z-H1d,SDS7GJD@XLNc<)1KQME\
W9__:9EbA@/2\<?WO4?IR,R#\]e>0[>@QFUT2?IUe-E]WW&OJEIBD5P>gadaaI7O
LP;Cd]W6b1]\^NQg&HEbd7NL8SG)Z(RASD/#C[eOQaD2g@R[O+0&NWb4LI-e^63#
<L>0?9_5-0&^F1J_5UWM;Z5R[4(0Dbd2+_f<gN@+:OAN-/IS/F4?[bb;V-6]<FWU
EV=FN-?HL9H)4)PFe6[J+266IS91bG+4=E0<C?8GHOX<N9YK84B0^?HaM[TS=c4@
3d?@bW4)?#;L1A>(KBF_L2QS:aX,<Y&-GE&+_@>:N:PXM1MX4BM103^Iac>#d^WT
GQ#3c7<E)IITAHZ20IQR8GQUCZ.]R^c#8N7WWa9KLUUe]LU(B#0QYC()/-b;I,c9
.O^:CN11I7IR1YU@RH5A>L(IIH;.>PL,,QJXae(Y+88.bZXR/-D<24ACV#UMJ22D
2-&\2)(28>SB,.#.U?_Mg8eJTE9^Z7.d>=/aDUK>-a<0//;U==,X&ZTb4PNDT40=
9UY&YGe#1\VEeKA,D9S]T>cX?IHB(QEg:)I=,QJ8:__Fb5c<1b?8cIb,=2gDgKWX
^UUI4ObV?^INgM8097daO=HSW;CE+:6C+gd.XA8)B1U=G6?0XB4.WO?I2Yg<9E.5
6_6a>-WMAUILB0g;E@Q[L5&N8>7R[cP.M(0aTTC-G#3\)_X+(ZV/]>QC>AT_,M[5
O(O3N\TH(TYf#,_;@@3]c;cJ\aZ+(N4W8-^+/E43:,c9R@7J=2S@-B8^b2KM]efU
?OS@b2].bE&Kg=-7A7d-(AWZ_IU+;cQSP8&KE[=fTVL)E+\@(9(BCGb>G?;T)a\Y
0WZ6a&HY5TbY7/\N<Z7g4Y<=1TIB6_Rd08<F8F-dNOK_:U>V_MdH4cX1@?6ZSP#:
HLBN9N&1G]EW]V-;F0X&R#D6Q^Y0Q7)-Y8PP#Ce-S0\/2JDc_M5]1UgI=fT\[5W6
e2YH(D[c42Q7HNM1+WW=B,+WV3HLaabE0K/[_1.2&JCI,=Ga)51AIFg8N_NJOGSN
J.3X-FedX]&6Oecb9N_CHaS3X/[A7?R3P]dU(NS,ggI5b5,WY-I^^2e,9E9Lg@YV
X4+>3YV9db>]6KM@GF]OPN+ZfIMIA2&1Ic=2GJeG#45G2U4SLZa#]?0:SNFXRD]/
X28&U61(TM\W#WM@]INTf5<^E;?=B&I_G??#RKB2MDdP<4F_8VV?@aAE;]<TICKT
HLJHQSf.#^PDEYMHM?)OMAN8OS>@1M=W.&8,J[\HFE26g/3GN;4,W;L;Q[);@e/A
bU^K<W0Ea]MF[VB2]FX(5S(^dR,HW3\bdLT,/a9R:-0LNE-A<VI3E;AK&Q4<FM,L
YP+I#dORT4@(;_IQ@M?0B.1+>MagY7_:_C\HRKc/a#:WU5QF8.ZJZLg@;9Wa6(XG
IIUVY<R5Ag]-74D2(C@2?T53]f0RD=UgB<0^71I>2e>C+T9E([_Z_0McLU^Xde1_
H2WO;_A/W;,>cf+8]98\J&1EZI&9Y\#HDY6.T6@PMd,ZU/SP6C6+))#R@3c&9(2V
;_J<_d4BI@3<0HGG;];X7c2DT9.,SYCa45IX[9NE;HS4ZKU_XFQ.=J:V>9Y>EX5_
;P7<;WUKG)^P-EUUd):TQTQ_^71NXg]+WX@/L((e:a8V:]#=..T#(HAI&gPb.HYO
Zg5Led?((-f_ZS),T2V<^3bEQCTaHg:+?](<Z38-)2&:Xe)ND2/0T.7dWY.?,+WR
ZQA+<gT<M(A^HEQA;RY.aWE-S^F9[1[GXPQdQMcN(HM>4?LQF7>?8U_]b(?cBHG?
_[6?-8L&_#WG_,\5\;b)S-_IfEFggZQ]_e2W0ASb=ODc8Gd9L091Je7HG+gbfY-@
/e+eL[3B)6\YC<IO/MbLM[#aJ+0Q,UR773R=aUZb<@VS4APLg8BO(UF:LS3-5cfB
VH;H,\K4@\K;+Q?L@]QFf0,E=e>\VL4)T97f+F\@92)g(G37?C(DaaGHZC1A89?W
CJ^cM?gRF+A07L6b<(4MW69&HL>3g[H<bN/\A<.WEK^3([aSMZJV/7aVTN3.4^f=
MZ^fCC>W#97=Lc^QW(N-]]?ac9+GB&JdXJ&9D@]f^CPWPK+)V&KV88O&cX87U.M#
MgFHI+?<6AY.9),PJ\E?269>8X+4UgO?D8H1(0Yge^+.6aU[FQ@.?/U7IO#F>-XY
B+.KgXg:GbOA5,(TNMeBGdgTfHDgD.H-]KJ5>7V+/5Ba3Xf.)[:E6M0KY[@8T0ZD
RBFY#F70+<HM@>WI/C_&Rc6OSNTa3N.#^?9:]OIBHGgSE7Z@)GcG<QEFD)V#OZ(E
eP^<M6g-9/K1A3>eg(eU&4,FMgL8f#D+PPO0e45/3bL6JaPD6S>TM#@/O5CJ1-43
Z@FSFI.KgBf5E0_JL7)?[#1J-,a,=87GE.(;(EIPVE30cMZT+a/B^+HWRB(S].[2
AB.+A>K),?X41MUY>);>JbbG>Sb6W]<=50-R]N3MS>&RDbCKe7=H@][/NB.8AVZ:
f8SDa&d-]c5\/fY+;4K_D0X1C;3&X[4YU19:]=a,+U\6b22&Dd_&G=+2F:bV7PFN
6;cBTCKW[aLE54Cc5Ug\UR#?QU[Hd93<Hb.<R#A-8WPeD=M],Q1,>;<bO58W2[eS
K\Db]6?gGLRE.>d13V89cQK#dd]^eO2B3#T.99JU#42:VUL?TJ78&0<fJ0N;/DW6
5-&60/_0Y_S9Z5eF3Z<\d;IO4LT(<@:cKOV/8ZT7L&g,O27H3(;7cMR1E=2IbR#H
JT3U^aTdeET?)QQ839G.aXC3BSOCB>RaYTIP]+QC]S^_2CfHHd2GEc[1_^ADI]NV
L,+SH?H,H.T-+eF,#KaE:03O]Q0[UG5SY1CH6aDeUI)CXVR_W@J0=9g>O(/T299g
AAJSGcW7/dN#G6]ZU>1:_O;,I8MXZ/^g_:50#PJM6V5gC9V]&&Q6ZI2/)C6a<:gD
7W89Q]-)Ob/Vf#T+]XWM;g4aQ^XL_D=c\ZD7a+cYS1@@,L0?8faZGV)W;^SB&UM9
:6(S62ESA(-IHNNP:W^UeNSa,/V=#18^UPHWB\3bS7P2>1>><f<^a0DeW-c+cHd=
Q89bGSeQ5^NGcTP[03S@)LJF&cWUD?Tf)MRTY_,b6909^;S+-e623/COPJO+ZC7A
)K(N_/3d)dMWQ^(HSSLTHR[DbNaHJ/J<.fWI+_E3/AT3[&-3beQN?GI[(9[#<@K.
ES>,DbXX#BFEe:f-_.PTE&7^K_L#9c4=6aVTU2[[1=+I61T<F9(N&8Kb&X/\d^[:
a,DfT9+0=f>U[I<,\(I6I(.7_GOM_V]_g;FH971(UJ&V6Z^QO&17Hf>PV3Q^><KL
)>BFMaZRf(M3D/eKV<1Wa3EaOa=@EeTK#0^6CI-5EFN2PE^^8?#L5<3RK(5=-LJe
M,OP_5459]d9<DJ\:aRQf+c@XWU9FBJ4/OaDQGXO.]:(4HGb7OKRJ]QSgQ/KS,,C
fCA:2[UZ8fRA=dR/SOb=D8<WJ\:>.1F;DPZZCK/M16=3^@6^N(\-N(g-R\>CQ>-+
O223egJYIK[/+@=gR(@64;ZVX1_,J(HFO(8666Q-AJ6WFH=bR#Ya+NPbBBg53D.-
af-0bAQ^O68W8F0aD)^ADe9Y#6eHe.4_+A/=Vg-V6??RE5]0[B.(9CM0Y968FX)2
BP,H#RA;O.?A+\T+c.g#gP9KVV^(P?3A8<Jc1Yg&JOAdZ4\+@I0:&0N)L,aPQ@3_
;1E+2<V2;X\\J3[<dAc?b&-\[.9)>NL<8JR7G+\\Zc>75<]L2_ZZ+d9@U3fDcEJ_
_R=T^H019Ga>EgRb)US;5I^1T]-0>0Xb0,+WEI.N&,L0;P<DYceGE7&\_JSPL2&I
3c]WKU_#T;&3JTU.D&d9E/6THWHMfS(7PDUO(c>F<@&],-P]]]7H+P?I5d^L<>L6
7OJ[VL.V@:b=@[bRC9@U>/PF1c06VGE2g(V@;gYSUW8eBYE1K=Q2NY+6RA]S>U#E
a5([I,]@--H2gN/dY;]?-c7&JEZ&7dP0_@4g.S)AP)BTQ6VbCbWJE]?5<XKOfU\T
ZH;[FgV39ef<5[5f2;QSZVOU2SV0d5TFHO[3aM4J;@D;=QG1AJHAdG4PWbccKA;@
,,BCAVf,Y=+Ic)KIfU\g9]:[.]/0JO@_W;:Sd72M3WUS7:R_gW.2eNJ\B]ZF&L];
Qd:gWaDI_:GOK045#SX^fa.0T5Y^.Z6PHWYg#77<0EZIS=g-a:O;KVA6(HHO6RXE
A@gVg5G@F,Z;E#;ef-:C3/\NN?f58/B_J88P#9T6H<T&R(1+c>2RLCeHTgK6;L=g
Hc1gE\+.:^A,X@CK(eS.LJR7RJQYJZ+fR.WHXG/O,QeJV>1D1UfaVLOAggR_&-3(
+H759(7(NXe>JX(W0BL/QG?B?/Q][OP0g/A=5#N#D^,^(;4UB&QbN<S(-S>Yc/a+
9:4.4:4+b9G>BeH7G>&,(WMD(_K;8A(D./E04g:e>.D3CC6E\)6d7@3=1/@.(S5O
@+Lb;76W:BT=K5RN-5VIZ4[c7d5(WcZ#(aVJJD1U@6aF_);BHWFR\f3gcD97]Y2.
dL]N?aEAePe,XYd,@8)[RBRdL92eSZN(4P<XII9=G7gN]^=d?IYV]4P)@T=MC252
6Kd1HSMB[P/Mc/6^2=6OUIS]e&3S]-L-K+MXI\-a84G#0G0(:VHJT?1D_?aNb0H4
RD@G7D.baY0_DLX3/#]?+2RgMdWR/X=_=1GGfF;T#Jcd8.ZB)=P^],M4VZ/8]7BF
AB-(2T,Q8-KAOVIag110PNJFAP\a^UBJKDI]EKd.-T<bCUR.\82J7(:c(a?c6V(@
UZ_E]>GU4,H=UDfI<LMH[DCfH-TS5EMS(A]gG:Y?fQV+2Jd1TF[DgSFga^fOWB\V
@cKALL+0MB-8.9aTP-BM?A0c2^E7UT@B-OU5J,H)-L&&#S[_;>5ed3@I<1[H_f_0
;fc]dc7Y-VA47-3KV-;ZO3MT;ID.<3C_O;.GfRAgLHH0&IB((8DH(/EHB?:IIC]N
89BFT9FTf6geA\=1#S?UNC]:#1:)&/338a\?]JU#N4VHaBU(_:;^;J(;EFII(K;]
edQG&W0FbALV?2\/a,&(1fOC,I4D0efZXE1[[J;-.WTY]b6\-JBB2N^9MQUO-]:7
Y7c)L0PD?Z)Q1Ib52,:/(QEMKHYC@FR,0E80RV<>O=1O7If?-DQ(VP/W2P-G9^1&
J3JI+QA6-PE?<12A\(Mf7J1a:P#)SY2R=[9=b@MGC>JDQ>Nc,OS^@QRg:^<Rc<L9
#N9C#0<cL9aa_+Fc?<HY1:]YL>N1ENV:L)a[@]a0S;T#\[V\_=1<^+F5;5f05U)G
UKHXT=bQM+3@F\B=6CG,MB-@P@.d0bTUGW6,P+GB0C<e580C=-P0PS[6dcW]>ff-
[gLH9B_cPWZOBXK5-N-1N0PcLJc]W\V6[e)-P>HgDO_E<MF>_If_/b^6SK&R6/Z,
TC/JeYH#dc=U9eXgZ1:W]BG@9-Y]3,=V[W[AUe#G7.Zg;c:MSGf\)L4W;(SWfBT6
JT9TALFRNb8E3aC[(+3CI.TI?J8\=[[/O\-YWFF/&LcMY,[)1+a)(>=eM_PgS_L(
2(+@G[bHG>0HFWA5KPb/6R@R/;b\QA/2;&gaO/H&[@G>;P0<Rd+>4AVAGN(@#.UD
^7^V]4&3C=@I/aMDYZD6U/c:-);Aa&VG;HMP-gJ[^cKd8<\7SO(P9IG,3-^T92&\
1;a0SQa]B36-/U29#8e?2JHd(@eB-:(SE<J0P;:T9E9ZB_R)e<H^LKH8;M>7\)2N
V8f@#-a?bCVb)DY??Y.cU1^4c?[T:3#@=?&0V-+Wf@].bEYH\T6+:bAg2I+]H3VZ
+XRJ3EW;G7YE&@^T:6R<\:QKTI0Z&#C__,1^:=G]@A0ebQ6EB(1P9]aW^N]6Q>YE
IL-W>J==[3N7+2:.<DH&.L#]Rea16>N=U\?L4;(++HD.BLPc\I(+\VB9)ac#>U0/
XR6S;?a^gDc@4Za[/NI80AMY2IXBZ-+?Y#R_+TVFG4_cRKL#C_Ad6(5KT1J?)43?
VMY=JaL?#c]Cg#3P8[b+dYf(\-6T4XbD26eFYBSW#/T3/ZXWF^fe-\I_EA<LD5:Q
Y\N]&5>?]S?Z1YO5R8W5&@:ac>M&DDZW,J9><8GIY)=V]>?Aa\72U=><40#3ZMX[
7KXHUW>D\X-0@3\,BV&W[ZLH0K?OY@>.<S?2_DE?PB/0d#J[g)PATHVO2]TL/_.N
TdJI5Y/1XY:S[N,:>)d;?Ca?dWRY5L\L(QE?(0J\-1T64:.MgW(Hf^2&1Yb7Y8+&
U5&#\(_VESBf.K=2IEcB0-P@2TbPUc4?[#+.VgKW7QZ.Ze-/.f7+GJ#I6ZM5eOPE
7>P(bY&NXEG\a0LOJ[DXcL,RRHF^@dI<g25-5/AebW;^BWR8@V)&B6PYS5f@BfKe
O_b26Q](2D[]W0caGK>5@@SV]=22A#A^f=99O1MCS04OR-&Q1CPbJ:6\Bbd=ge0@
cSE7YT]^AL+H,2Kb^;:Y-/I<&M20BgDLVANKWL2S+QVVK,M,8aeO0\NOR/c^#EE9
M1=@H,K9B,PH?6d[F.DOKMR/e.U@D?J]1@SQZB)4[e.I4#G88?(+9J=/^]M48?J1
[OJ_WCX;49@6/^&/5ESRGH?0LC7:CNQZ7VTU.]T7?D7CXBJC37dd/0<S3J10cJ4E
=[ge_dPPVWgBXFLRGb>1-YeWf2BRLc:,]?A;V.AX2cfSCH].H<U/g6E:IR#6+1@=
F2/^DA/.W/07_XY_#_BGK/]HSfQHRTM/ZKF&G#W5PHb8(CegU3]WY&-1;9gFH&WX
.#UBTEQL^6/.D8K5,72eMEL9HF4:X?L[O64HGB5SP.BJObEA<&0H#>3Ba?;J5P1c
SK,>a3CJ9DK<>D>F8=8BC.:4T:f@NND_/297-P+],]bU=^C=SW@O#:,gV_H7BJEC
:T&TPF-b-S[XS\QEa)NB[AZIYP\PZ)A0M8WS82M_=E)DJ0FdFQeYZG2WLUN6f,fA
9/85Z=JLSeA>XJUJ-FT26-H,TNL(]T,gEMY5[,X/0@NJVSXT))=M3@3GJ2f7MV=]
dE+Nd61;PT-)0[@3d0(VYD=-BS&S0UQ@V-#VRW1Y]T:XVS<EZ_Xd,VX94e]>;<?0
M4K.[W-RNF==gXL?,82BD.+H#D7M\X_P^(C(D5B,/Z4><465(AXC,0JV(C2T@FVO
UFZXg.G#PZ-+4BEBMQR3>=)6K=#f48A=JJQXJ+U6VOQ#GC?Pc_N[K3S[^&FDbZM7
C\_6MK\SDJ#gB0)N^?C=C?S=JD9dU758ZSAQ2]@D1T,NPE_AEH#]4b(Y=D96>UPg
9TIQ=]<1A4)UA8(H)U_D>Z+d#b=-[dV4MN:/\DB3?I.PLC6Z+RH2+Y:CQXAEaM(2
FCN+B_e>d\.g@IYKSDOUAYT\F/\S&^V?-=]B6Z:O>FK@[9B1P7PC#PK#+VN7VT1;
NWb=:0L<V8I3UHdK9:Og.,IKIT]f4OJgF#[R,(g=42WK(?#;=d]Eb/1gCG4aSHFH
Hf3[&_46IbQ#YYB0-da.Y@^VA20N9OQVJZCKVNLH3GK-2c:Zee.U=\>YdVYUe;A8
T9(MQ/D?@>-Y?..#ZT0KLW7M.-);SP_G/@4([5/>A]2AfIUW6&W82;7QT=aU6J,[
9ZXH4M7b@>B]^UHa;>OQDL_E@F]&Y\X;)FQ^f1BO2>B2cdL#IW-_]7Xf[CXI(Yd7
R1f(cPH<^;(/K6PMQ:UJWH)I1;^Z:N=]TDbA&PT@[YR+0#=Z9SY6P)g=T2S?PPWT
0](fc9g/Na_Z9(^F1OURATV+]?FYQd9W9$
`endprotected

`endif //GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
