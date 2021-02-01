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

`ifndef GUARD_SVT_MEM_CONFIGURATION_SV
`define GUARD_SVT_MEM_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Indicates whether XML generation is included for memcore operations. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * memcore activity. Set the value to 1 to enable the memcore XML generation.
   * Set the value to 0 to disable the memcore XML generation.
   * 
   * @verification_attr
   */
  bit enable_memcore_xml_gen = 0;

  /**
   * Determines in which format the file should write the transaction data.
   * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
   * 
   * @verification_attr
   */
  svt_xml_writer::format_type_enum pa_format_type;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Defines the number of data bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_DATA_WIDTH.
   */
  rand int data_width = 32;

  /** Defines the number of address bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ADDR_WIDTH.
   */
  rand int addr_width = 32;

  /** Defines the number of user-defined attribute bits.
   *
   * Must be less than or equal to `SVT_MAX_MEM_ATTR_WIDTH.
   */
  rand int attr_width = 8;

  /** Memory is read-only if TRUE(1). */
  rand bit is_ro = 0;

  /**
   * Memory is 4state if TRUE(1).
   * 
   * @verification_attr
   */
  rand bit is_4state = 0;

  /** Name of the file used to initialize the memory content.
   *
   * If the value is "", then no file initialization will happen.
   * 
   * @verification_attr
   */
  string fname = "";
 
  /**
   * Name of the mem_core used in C sparse array.
   * 
   * @verification_attr
   */
  string core_name = "MEMSERVER";

/** @cond PRIVATE */
  /** Physical characteristic descriptor
   *
   * Defines the number of dimensions that the physical address is composed of.
   * This value is used when constructing the memcore instance.
   */
  int unsigned core_phys_num_dimension = 0;

  /** Physical characteristic descriptor
   *
   * This value is passed in to the first argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * transaction attribute field name for the dimension (Ex: rank_addr).
   */
  string core_phys_attribute_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the second argument to the 
   * define_physical_dimension method in svt_mem_core. This represents the
   * user-friendly name for the dimension as it appears in PA (Ex: RANK).
   */
  string core_phys_dimension_name[$];

  /** Physical characteristic descriptor
   *
   * This value is passed in to the third argument to the 
   * define_physical_dimension method in svt_mem_core.  This represents the
   * dimension size (Ex: 8 rows, will have a dimension size of 8).
   */
  int unsigned core_phys_dimension_size[$];

  /** This flag is used to enable or disable log base 2 data width aligned address, default is disabled */
  bit enable_aligned_address = 0;

/** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------


  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  /** Keeps the randomized width from being zero */
  constraint mem_configuration_valid_ranges {
    // Should be at least one bit of data width and should never exceed the SVT MAX.
    data_width inside { [1:`SVT_MEM_MAX_DATA_WIDTH] };

    // Should be at least four bits of address width (memserver restriction) and should never exceed the SVT MAX.
    addr_width inside { [4:`SVT_MEM_MAX_ADDR_WIDTH] };

    // May be zero in case there are no attributes used but should never exceed the SVT MAX.
    attr_width inside { [0:`SVT_MEM_MAX_ATTR_WIDTH] };
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
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
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_mem_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_mem_configuration)
  `svt_data_member_end(svt_mem_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Update the physical dimensions based on the configured memory size.  These
   * values are used when configuring the memory core.
   */
  extern virtual function void update_physical_dimensions();

  /**
   * Clears the physical dimensions dynamic queue. This method must be called before #update_physical_dimensions.
   */
  extern virtual function void clear_physical_dimensions();

  /**
   * Verify the physical dimensions queue size matches with the number of physical dimension
   * report an error if there is a mismatch. This method must be called after #update_physical_dimensions.
   */
  extern virtual function void check_physical_dimensions();
/** @endcond */

  //---------------------------------------------------------------------------
  /**
   * Walk through the part catalog to select the proper part number and returns the
   * path to the configuration file.
   * 
   * @param catalog The vendor part catalog that is to be used to find the part.
   *
   * @param mem_package Determines which package category to select the part number from.
   * 
   * @param mem_vendor Determines which vendor category to selct the part number from.
   * 
   * @param part_name Specifies the part name to load.
   *
   * @return Indicates whether the load was a success.
   */
  extern function bit load_cfg_from_catalog(svt_mem_vendor_catalog_base catalog, string mem_package, string mem_vendor, string part_name);

  // ---------------------------------------------------------------------------
endclass:svt_mem_configuration


//svt_vcs_lic_vip_protect
`protected
,eZ4I_.&)QD1D\^&<(N5#-gY+_.TM.CQO)9P+,XF=VQ[@e7;-/(B3(GH_JG-ZVM-
D_&b<Pd74cP)TIH:,3U9_4Z0JABCAHG5?(TM2C9F+b0d#N=EN+X+]0bFT9UCZ(ZO
BG)=\gJZeE,9.;a-:^b_F>g/VC[RaZC(7/:MeM0I?a1MV\/@20]BL/ZgY^1^X>Qg
Ff?KXDL-TH?E#-3BeAE+7^dIS384]5=<29<Q\.X?9?be3@fZT)5VB5#0W:T,F0N?
^\+QB^f4(a3b4O(f?3GR4Q^4R)W[6_AD[.R(D=5)I\UQB5ADZ)^[EZ-2J8+V.XPR
9aLT;,)==CG6F;bOBP?Z9-0-,Vc)<C#).I6d-K=Rcg2cFTOL/FT-R/RHUG5CC<]A
4dJBW8;E1cR,/WOfQf8XL4&cONP86gEQ8e5F)a<4;<:GX8RS&P,L3#W:_TfU2c3]
GB3:=@fLDYR@0W(J&QPG#_bfI-JgB+==Z.=>IB>Xg#:,C>f&F\IA(K8#4FHI_@MB
@D\^BJ?:L,K(]Ha6O^6@GGb/=:c;/AO/)8?L&#/cDSE)5d\?]8V03<RBG^T>eB:S
8+_.4QP66^9IC.EYFAHQJ-;.9OL7YZNaL4VV\aP?d@b&4&]1@.d]:T=MW.@fIE&0
:680HB9LC.S<5URf?24[FFc)(#9L0\+GFcEfJb)ZDbIOg<6g(U/61B-=BNcU7^?#
(6J9+1.M-KIc^c#dMBR_[12U89c(Cg-[+IPV0Ud9Pa.6:a+Sb,[ICC-[@?JJ^0O#
[]K/^3E8IW(OPf;:52:.8;NVUV795PLM-b,E\_U,]Y:.YE]cZK,L.TW]aaX_G4]E
F@[>:cRN](fRfa(6630&(gNV7$
`endprotected


//vcs_vip_protect
`protected
QWKIY\D,b\F^_CLMOb:2&=g]_]>IZH^(9)@GP.-+53;ee+QNY(RI4(c&)=];dG19
UdH;IUTe/3_b6La+QB.TC;K9c+O]7a64[8K(HPc#9TgG8MD5)T:a(/=D8FP/G&\U
XCQa-4F>\]88DO@HDVaDdb2Y+Me=Rd>dI^M?f^3(QEaY)U8?O@#]&XB,5Sd&O[2<
Jge0X&?EY]JM#9BHC(f\E_(Q6Bb)NPJY-FK05cE+c-P[DCg<g_)]c@2A,fAe#EfN
0..];>I&@:W[+E]4DW9:fW6X2^_LR^N0SUP2V/:7KXcQ>6BVg2F9&L77UZ@M);OU
faOWS?g7T)e=-JQ>F_JX^=d.O]UAOU#+adS67#7XV,NbX7)EU6)&.]-^7)L;a)a#
&<^[CfcU)Y_,1(LGDU\3c9AKKP=T]BPcL,8+Y(I^?JeAg>5AJPVZ6W90U=PM)WFB
PcIe22d[;,4/X&L_R3^d_@YgfgJUW-/1ZCMB[BYJSG[FTMS@gK&NV<&(EgX.191O
:H/R/2S&b,8CUMX2fF?OYO2BfcIVF,,\Yea[\<+367->;SG+&\eA3aXG#P3I;LA;
Qc=-I=+X(V])=U#9D3L7QFBe=@438I]+X/\7M8O@d)4?+;\TY[egAe:[cRX7d5L@
/R+3(JG)S)FCE,I,H(VA;=K1[eY#&BJ448A?fV@MTf::V[N-4)]dP7#OHD3-O\U6
E+R\P[C\3MX]RDKUg1dKfWIcI[ZVUV#fG,BG#EafBJ-K1:#1#K9B)V=^9(+SVT0L
X=P^ZM>1=9\dG4\;,Z7PG-&0BR9?;3S]cb;PK&S,KJ)Sf<aePO9a#G)KgH.2F\-f
TS-SNI\HUH;eB?]9I\FVIX3YRH7ILFaMN-)FKTPa1=bH&6Y+>X24,#PJB-]-_gBM
+GSXd^d2TON8bOM;MW&_b:SA[[,W3I<)T;N,XI9PKSQZA0TTSM9;<JHSfCIdP)NL
3D,7c5F;->#5M0^)80-YaB(N>Ef-JAd0?:d5.^)#5/.c=?=d6XNSQ[C4/EXBK2cR
a\^9Pc9957&2JV0?N44=:(&Z^;89[FUcC8b@LbfASaU/TRTTW.)4CNT6V]O#4>aH
/TC.eOJ\Y[9/Y3?RVH;.8\:5F2GYD]>#WCf5+3YHO;O8)R>]R\DRe.RU88Ecc\X5
b9,;;C,<SO[B0=2=2]<=6A\BX?S^,_HZfQVd3R+M\de9M(;#XfU9K8XC8R([L4XM
N,2OY6I_E__Q0BA,Q;I,E]/F3;QS00H13?B/R40F.4A>]dcZ4gd?GNR=B4XO>0DZ
L&AW4-)g9VFHBT],XfXPRa;S(_;_\.5Zg?HV/L6(^L;(>&BA&S\AU/5K:Q?;/@38
]O/:I?eT?5eP.UPEbD.NV.1Ge=F5T\QS?@R5Q1/_8AO]4Bf)Yd1<@61L[;0@Y]@2
#+QKF:AKETAV]2I\T=R6=9++GYg]UBcVFU^U=T-2F?6/f7:X1=:7HdF^+S<c#a4O
Q@d66SJNF<]d,E61K)&=O;+gH(EA-dQ=;.P?318BYDX+eL03d@8P1SZ.&5.d)O/J
9Vf<#GZgF/.EQQOJf\bOg0e4\(H?/5\9DU7aR9HU-JPY1Z?d16:FC)06Ag#0&7W^
\V+YR<B-G]9<ZDVAO5PTNEH2JB<OBCCeT78Z-K@MFA@G6e6=9g6-(@<H&IF<ceW]
M1IZaW=5BB9_RR+O;fQee2?IFa3,G3#W+QG?B0E]c/8a>UVU@Ica1WLE2MVdG]MF
&A\]>Z8YD0AXWI;DUc.B:;=1)X/<g4Ub8B?a#>(d0/@-a&L.L+G\+LH,_85\eP\=
9/CHK2O</bcTAY3/8YK-Z:.7bfeab[F\OA2LIPVfd2:4GgfR]>Ff1e3fE^]CcF-#
fIdM_71L3<_Xa-)C=B7?X.=<Zd_7;[6L1RXM24_S+Cf7Z3&=a0ZfFf8_<9e18Ne.
4PD]JLcNK.T,RNB5Ua^UIFcfHL\J3[Q^:TQNWZJ3S#ZfKX^+NQM]d3-IfLX9]V.F
SF/KLNcb6SO\I9+d.Z/8b.5Z=9KKZg&UH&@NEI(FJ^,^)+JVU>F3AG9eW\)Z;1)@
P4ag;.(U#@H;VLEf3#\(.9W<0LN<TIF9N;WTY;=F0&b\<,gcJG#[Y5LB\:+:5.=M
JYfPa_/AG/L2NXY7&H697c;E1?N[#J,6I:)H6)+\#?UN+&3?O88H\g^ZSfXW1KAJ
fA-V]MUDPGG,_DLIKBFfa1(\A8];EeQKc:+ON;;1Y>.N9?@UA8>X48X,7\3@-Z0M
4[0=S1>&1L\dCRF]4B[Dg0Q)XESW@6:_AZJ)>=^DcEH2]XG_ON_NC(D>-(2c2]&J
>EJ>122fHWX-8#9P(Te<)&U7LK9c)QH#F@04/N#:8.XF\?1]JFT(^G4,XE8J<@_Z
&9[,2LVVEM?H,ZCLN\G\WMOE_cdL/;2aQ.;@[K@a9IPeF[fJ02H2MI>]1?3QF>R:
89S0H2[R3aD&YE;QNF&<26aP,HP23K^8A?R2-TV:I/XbSZ=J1GYI?5,W)6)D+:=W
0:aRWVALfOC1:LM8dV&IOdEK1ZBeA;<[fU52I#FMQ.;;(R)Uf>KQM(R.\V6E=J2d
.EJO>Ja^@>Q>L4TJH@Ie@==RNKaP4AD0Mg9@LQ5]7^M#LQV8LJ]L=\F?<3eIJ:B^
Ze5]e_\C>_UPCL&/D2-K3.dK79:MeX&+]BYSMG-OF;)27T#0d=.Z<E#35B=.M;bV
eK>@dXRN@6L08M?FT\ON=3N+^FbOPTg[cGJFV8N6)PP:>#UNc1MA(8Q;./b3-9BP
fD-4ag1.S=:/2P[0E_Rb0PV[5[eL,&1bSKcB)K.X3F+.,(<cBOG:I29C2R1+P[>5
^UgTdcT074E?2XZ7_FJES[E^(F]=Ae]:S9XK#7FVfXG2R1;AH@IOFC2-&CD#a0A<
4A20WVNLWKT8@Ma41_Zf7@Y7N_G4@f(Y0\,dUa1/Kdf;MYS>(3R-5D6Y]9HNIKO]
+P]41Q1:&(K-\Q=^X8&V5VD@]L3K1C&KeU339P6YLYS\PNHT:2E(OD)K^6;=FaN^
?ddR(<I6c-@O1HYeI/GU6,/14?e6.+E+R@\4MIX@ZWcaV1afZZ59.IS=H7eA//&X
&bVNIZ@]]B]LgZ<\:??G:\M(>,3A7_b^HCf]CXCFLL+Q5H7(_5/2FHQf&N4_EB.O
OV]HIBRD0L9/,>P9>3E)21.#O(B#W<@O2;9Z>e)3VW5^E;.G[17,,=97c)UDc[eU
331T_11Sd?,eNc:g(M;<Qg8.L9MSJQV8,5C82U1ZgG-GEQ/IMB-XBA#</cW0eG:P
V<f:9#[gD_Z(-.7:8T]^ZYJ:-)E&[AQ2&Q\E;)5I(^TVTg#UW73N_L8BC.[U^\.U
H,I9gfWD#GM>3]dNN>:Q=#R3Wc&c7:+KANfD6K?D7RLL/26FT4NRRRX3g4LR(?bT
Z59JJ&ZdSS?f4.S>KC:9SCO_M&@1YD)L]/)V7/Qd^9U[_7BR80T[G&6I<3Raege8
@(OWcISe<078.0U[D;G\GT6,L2N_MBHAIZHg,cHLIV-42/Z>#>NCfXP\^VKZS&+Q
SdbML^G#(#<ZC->>[>46YX1g>eXH=F(X[==6+V0Q8XH&R2Ng932=aLMHP;1JB_b@
;UX+K2XC)J8Ga9R6^^)P//ZR9BgHEc7;05eQ\gJU9^JB62#W^BGSON8-:/->=#O;
=QB.+/F)YAN5=0I;R[QC#aGb^+E?G+5],].D[dY6e&8P+1CJ?(8V2K;]9=6:CY>@
7L(F/cRGE)g6>KP&0S@]OEAU_\.0(I5bEE6X5MWC4MB38(YTE95dSEQCO5&^DPPF
_(#6GOEf-Q_0[=Ac=58QUQ61Z^(9<:=>cT9f/LF#)/#[@G]CeAE.Y6<a+XJ#.2fa
46<cBD@9TJd@P7fYP&0d>E268:W9/NfEW._8AK+7TQHfgfdPC4Z)fLE_5Pe@&a2F
3YL^\c:S4Db<DI(^cGPge)dBW)?#RFQfZa2G=fWPR[LC@a+R+Y8H>=4eFcL9d::F
7R/=cUL/^K)cTB5IKP?C7XI4;916AK=)B3f#NX).d.6LBb&A/JM=YC[M@+cK_\a<
C02;UG:;IRYF]<H+fgW#V3=0IG\.Be9YQ1U4SdaZCXC:_TY)X-6K1Zb1/?e/a:\<
GQ20M.+KGTNV>2)9DWYK9UP__?B[<Z+9IR@6BSEF5@BPL>.L\d5C;>OI_OC<,AB^
TdLeCDU_MZ):#(U2#TI?=CJ+GaAWgfebgVIFP?X,_\ZC^YG\]K<QL&ac/S7W2UKa
D-16XcM14a2F/>X01C_G^a[ee&.X=;e&;/4#Z^KKd9ga;8eJN9)S>IK-[a^\ZaMV
X3S5^6#Y]_&D+fZ-?e2GL_@;9g9V6g@>ZEeXCJa7;7+Og,<Sf4G>PFSN6g(&MJNg
dQNH8?[CO4,72^PF/)Y7.YE&U.&3G@9;U&dOccAT_\W?6D<8<.[cX7Wa>J&NXZEC
[aD<P2/@;4+[.PZ8E+Ud(68a_A--G9BKB_<fcZd^-V<AS+I=(+eFA&fRD/?E(MCV
g+TOK<OQECTK#g14B;<AdBa[LKIX+[V,.H&:]U]2V.LX?X<(W<NcK,aYYGTRW532
QGQaXfXMC6)?HLLET^1-bDZD@;2^2J<d<ZRD9a2?+cQOQKca>X:dX36:0]GgCPa4
WO.@f8Tf)VVI#I[M72?][dR-4Vcc[_8D7VTZ(K/)9R;.PX.)CVeI>7(0H-4&NGC,
\P.ACQI3d9:(GbNH^K3-&M[G(X4a]J6/??H^2@b>>LELeHLJ]W#3OYK#8X=fU5We
E5LAb=<?L.J1g(IO(ANJSUZ,FfLB@^c93@UO5@adC67b^aBVf;X9_>+]<O[^Q))e
PMT;HcfGTUUK[Od>?+MKP7>A74f_YVLFW81;_5;Ce+AW<GfdD8L5DE\A:#RRd7dX
cLX@;ZM#\SRR1d0]E,E]T;>XKW(2(Y@2dJ=c66#I@c>#7BIN>CUN#7F?,?e3aU40
FNAT(aK[67/.f5&ggeZRbC_L=WaLH?,0I,=@dI&dG5_/-_T7-6a[LWNA-#&V+YU(
RA5c@a_428,bP3-\27HJ41>@[S#>41<(BW.c)cB3C/;Y5#X5d22)G-0-W>D&/OZb
YLg7A0\5^eSB\OL91>)<_?0>]Z\Rc>E7(1)^5eMR&>KcR=WD=PD3C9^^R47\]/)R
d.8Gb<?)TAbgB7)Z3bd#Y?9NS^.acYg&RcE7LH>4.c/._6,4G?J;>Id5F)d\Wdd8
[+>Y35VG(\^4dR1DJ-RY6?8-B0C4=W3RJ]bX_U=E@GF7Y,eV[H=eF9=de4b(F@4@
7&@@ee\F]6d8@0X//XS#L7B,H:PdT,[=VC)bHQ?5cV-M:0D3DbT16?G(<)bW(_Cc
-,Y_>Q2Xd.)5A-B#AeYMe4XA;G\ZLd8G&DUf(-J\\(Od[GD)162)-H<3B#]>#RL5
.+MgH)R8<eYTSXb@^3[GZ:H5&29<a8A\-CF@H=2G2b5[1;S-a#604+gd7dSC@#DR
FA<X;Ae@6fLO4_-aU0:[O04WWa4Y#<7;;?e:X5.?-P(;UV#Db+([B?)O,0NZ]<T>
R-E+F>eb:d#G#3.;T;&J6bH#T<581+,?P(:g6V97S93L_#6O?T5A6XNbMGa:;,X\
ET.E&G43_V0K+XTcRN2RRC#dXAK^UFRP<e=C/15-YK87b,BO0IGHE\L6c4SG]gdM
<N.PW.:gLG[C<SScS1@GfHfAA?MVeL,6AWgg<+8W^H:CK7??J5T-RCE&.RMX@:NT
#VS).:[)\+0a<46.,YS06.+WIU=Q1CWSQ:19AZL(9P[5BT0&cfMSJ_=;7b^W#\WU
QH>O4SJ)&OLQ4?(H)T4cg_G8O:N:H0:Gb/a+BKU070-#3.-f<&GO#LQ^VK:A.1fH
Y21FY@K=gbD=bb9e]a2EcA(=KC0JQ&Fdc3dJB3dT0ae29\_OFL00E1dFHX4B11-g
2D7@5K9?)D7dQCTH:+b4B</P\Pg:Xdd/>BgF>1<U3V27[<\?ca5R@;Qa^#BaQT?1
[bN#&<T&9gQ(HHDGf2BeT^D(-5?a]Bf))J)3?[2B.DeKQ8P0BGO5^X>U4\)/QTPC
)[QF@6<GA4[>B5FLH&YLd&([T:?2)f:E5C];K_VfC:WZ]We<>Xgg5DK\Ma.F+V?N
@Nf[A@A\F]#OUI2f/+bGQ<#FH16YWM7Q-a.1DbY-U(70I-CG?\W:6PN2&4FCIdI6
Pbc2147>2\<0(3>Z(Q;-7/JOW?GOZB?R@L?:63QR;1CE^J7Jc8D1FPLa537T7G,K
J)Qa;4R2VSgZ;aZ6&R-T_O8X?b\a)bZYD.IDd3]F@F-#OG^2.JV3Q>+eZX>7N0g6
HcGBO+2M_</_,9&XgL>g^G@<Ned3Q&?eGQ3Y7>SC,SZ6J/7CNGKc>]@350(8T:f#
)LBE4DZ@TD[3[OEB;CN5306;0Z]E[N+KG,dXB[05dIB&BVb#MCA/E[b7ICAU\_QU
PHI?Y2?\=FYG9Be#f/4J?:.])PZLa@6D;R6RfU#ACCB)^1B0[,A1cN[0^D)^;8IB
@B@=\C6aC.+^@&]DI4D_7\O8B^4J;K,(Fg[##+=)(cNHg(LD5X4,82CLH7fa)L)=
8bI+1J;E;5TNeaT4B<[G)JW0Y5#EaW(\[;NX4(_MB2Y+GXTUaQK6-MZTKb+\4C5N
JT_,?EW(/R&QBFZ)TR&K/\1,FOf72FgDc_>TfL583A6AX8^OQUCX@<AHfD?5-9@4
:e]2gP60aV>2aNOG_[M(bC/BFaGPD;5-3dfM9a62T;<#e_^KB7)Y-33++)YZ+74C
XC5)AD:<<(gcL@[-;G4G=VWF1#:5SZH>K6AGNOf2TL\^:95eCYBfU#WY_CTAgB=H
b7fe9.6G3X:JF5VTYWdGfED@MU0EgGaAf/3QC[KfHAbS:<;aOSL;5]4T-8O?(=R^
E:,WREKY3cGg(9M]#809-W1TD=]3;-ZW+fdXF>5JM33aGdQ&eAZ3(SX=05CU8b+_
PWM&.:Q[.T2-8;DA7P9bX2a>e9)[L(F\J0.3/=BK=N<5QW<_C>(4Gg\06?f;88ZH
&73_F+]AW31+/+S.=QIcA,W[]USMX@HG1X6I3^&=7QKM+L301JTY&<C7RaAR;O77
@)Wg3<D>afAWN)L6F\2e:_L^Z2U<[1TU#O5^&[A:JHLaRCNHcb(?0XZNIG9:eOTe
A[3+JJA?c(L:@M(E2<-Oe?_;XL-_UI)N5^:4N@CMH0K],N(CZMTO5AgbRBa5fc/0
J)c1)QCEBIM1-MZC[Q,1KOT8,@+C;P3bYfIBO:&7FOQ/R<\f;XLTHW1S-/C3b1F<
]>5@BKN[/b@2B)D);NPN28A(Te9&VfA([HGg&afbZd5X#HIeO9_-#YT?Y?Ge0_87
C;HZOQeT2>XT2KRFDgd0D,+EX375)DWed#V4-e@Xb->?07,\68HJW6+-+53/[JAR
0dW;NXDMd0J#(5.(AKcK\>Hg#IB(WDALP4QYI]32PVMRHNVXV,MLSB;\)-eQ1XQ=
<D/:.10QLTTY.g\/F?(;T3;PD/9[C+.#&O7ZAK9SgXQ?Od5EEU@&H@fYPcI6afI&
K71BV=EH7N/bHJZ/aTC:IT<5VZ^UFA10BY<==>\(c^._f87E-7SYJZ##:S:;?f]1
J&;KP2-fUBP_8@]1[YNN]V&NbHPB<a<Le@T[&M7=G]_KJYR#K6X4H)@a=11A/V&7
R2I8B:0=JfMbR7GX@0c&55NOa-T:Z3gIc9/U@IO0#D0bMW^2^TG4[-4F7-7..UVG
[<X_B-aGd6^<0;)KS48bCf)>4<8_1QZ<^]K2-K</cd^<(Q0gHR2S@bLD3LU::A?=
,VLdX.]&C)LA=Z<MaJUg(R1R?R\9C>.5VQV+KZS\^gB.e0[I=-_;A70]M8M\Ge86
@<L);QaI:b1KM7Z_(/;15Z^;FLJ3QdY1g.&5F_HT:7FL7BZ8&Ob(b=)K<5&GB]RF
A:D[HMga?J#A9:3AQeX.F]:#ORG\I.UQc7]N@]GK,12_W;]3,?265U+M0]W0eD]K
SH<1>Z@?PW0K#Pc)RX1]NYI3DE&_TZ^8<;&H4dY\Q&GG.RR@UJ<RN[AU#\VL5BX]
;O444.<B_.NTd6(-a=2=fQ3VALFOJ3<5bUTC;O?M428d9@a7A,Y?J@6bTK[@[L.7
^LIV5W4<FWc3f.gfK9NXH>BLPZL);<<V7WG#NR2Z(&KW??)WT2WdfM=#f\0?6\KE
fa;?7F849SKG9X[,#?T>0#J_f^I5V@aSLF)=;BO]3:T->Nd^57:)]B0K:D238]>9
^LMWcQL#K\FY.QZB?GQ46.J(NQS3[6FO&6J\R5K]>:)HCgfW5NLQT55P3+>3A?eC
PZ\\67Z:Y4+,JX9\:6b7:a[3X2_b3NHPS.]2Ab3Ug]=S-?:M;B:cM^HRBOU3AUCU
\R[=5&\5IaI^PXfG3PK46:e6S;LcX.9&@-FgZcK#B(e=@dA2)Y#RC)W^<,7YXKQg
G[B?@CS4_-+@:EA4S6deg(<+.<52V#@<,^G32Y@NN?+9V^OV&)J@g7#F>()(X9c(
C]Ya9cg\8Y13<Ub3B,1e+<BZK=]6](<ZVI+C:@+?;18:6(2M4NKaAdGN5S2)&HOg
1bW.4=^/>VLJ]DWe6a5YYa#N\H93#S[JSOaP)X&5eY^bV#TCKFY.a3TMAZ.4Q>d_
c;GK;6AE9A>e66<-dXT;#I[/5]65X.FZcCNZCe.)#6FS;CLMYBb#+g?af;d;]9(R
cCd)g0-fV5UDAcf7gYNS5X.I<_I</EGYQ0I)bQ>K6+9(fO],B<^C9W6>TXdS_B_@
ebAa/b92-#B#73(?3O\GBR1MY,>\c9>--HPD_@>@17Td#3g;PK.:@e(1a9K^WJ1M
/X7D)d=):GL?WaXFQK#NR-XUS(]dO\bJ<43V3FEbB_b6MQ3J\(a[N3J^g&X]@QD.
L@13D#>9<Vd)dR_1ddB4OLU;^M;g(bD#@O:V;_(2ELKJC-Ic?f=_]W(K30GQ7TZ4
1O)@8TNZPfB2;ID,(&=73.a^,A\[-443XX,_Y9DDT[fJE5S13_IaZGd7V_>DI\S1
\A1JND+WHb6)^Y-e+PY>.CRb#7(a_-T(6F5;6\V&?AeaKEP.GGMda-UfB<YVZOYF
G5Ng]0BXQ5@gI#HcS8eXN9C=6NKN_gO;F-8:-KQE)0F.OX_PM^O8&@?8F29YaQc<
BAYdOL]+=0^=K1JDFB6AG_g/dQ,4<;M3V@KdK.VX0^]#:WYAO^:7&HUZSdE06Vc>
KI(a3a_<]A0N&;TI)ZGfb22TSYC56=6f)cP;2OXINJ(H81Ac[F4ESG04FVD9HQQ\
JOXUXW?Od\=g#K+S2;H4R_R,@Z1K:QL)&XZ_8#/,2@gY_I3B[)EgZgD,9aT>Ma/H
T>[LR&T/d;EO[NZ4ECeBOX6EXVK@#ME9F41P(:IYA)V#GJ=8bYY)<]FQ1MM>K)2#
b538caSca/]/^UI\e9-LQ-L0OCV-(@A+K3WXFK_N>8+IT<AUZ+0V5:-058Fcd81d
B1(04,9e+Yg)]<g1P2)M7Xe_V&CDX,#Q&YUV<V^#+,)5E?bBDb\:+==3dCWgVF9>
IgU[8K-fE51YUI+b6=OXK#9JS;A9,<d)M2OWLLW3>b&65,/:MRd5Y0)J]0]Y:Nb2
G4+[1@^d:cY3cPQ#g?WZD+C4K1\QTILSV@dRBZ[CA^T,GS1?I>(J.-B?6f_(3SFE
(WaJ57AUbUJLe?:>2#A,>3-gc[^0#/.R6G.O5b/X\#F@Q04gU5gU[50L7O\4DRXG
(LgSB_^TI6I]>T#;D+>G(=Z#1<<+TX@U2^UN?6:+.H+6DHNR[c<0,\b_?.3>G4Y1
=]TN3V;d0+PPTV-R+.AbaYPO@8X9aUO#.E2D@;\H]2)KeF.N7DdJVeG9-^[9N]PU
J#0ETNJR-N8[)366)[^QP73E1^[6^3K5<-+[>Pc=3;>8:TRH72ZZ^UCZF&KZFQ8Z
(Hgc\dd/6fW9(.S^6YJ^^2g)bY&TDRPL=KbC9<;FU;EVVE1/BGNBg2O:],<P8<Oa
46H[75OOCVaS>M?MM<c16A3QMY9G?W<_G9=M)AV7,)P3H.\UIH:F46KRCeG@d+F.
LQZ@,LKXAU/c/c&Kd+=)@Y=;?U(L:V8QWYgFBEB5VYR[;K9:Qg<b)>Kc6H]4[dc&
e,6aK.O5-4&cI>E//NB6.NJCYK>/K#16ZZbDRCPJGe)31,/(U^SX[:PT]-G4;M?2
:8NI:HTE]KcC(5BQLA;H]?/.J\8<fae,M-&2#_;6FZd^DgU.beIH.b[.W/3M35#2
--MQ&]4bcGF\:4)2=P2P\PWRP[^#a=_&LU>R<,ZD\[a<+_gKMQ+5^,gUCD./M4_g
gJY4=I@SL0J3&MAT-14PUg/__SH\55=eH#/YD&N7M4Sc]9_A3HPUT^e#R:^Mf(0-
d\+2WLL;(Z&X31UfQSLVGKYG,PF;Y_Db@@VZ34Hc#1=6_dIJ5+EY<:1R,>GU8dE1
O&=Z+ga2^EY&7gF+(cRSD-1@XB/D#0\C1[9=320[S;(Z[HTD47gTBAT72aXRBcPc
4JHaGUK0:8X\&L9&7b&5L9AI=CR1TDa2-4Fgg(N,4V8;eZ2GB?A/2XY/KcV.f7Bd
UZB#UW97VEbC\[.<1@+7c:1U1@Ie^M##S(YCND+W_Ig8NG(KGXZC_41-I\ZbgSb?
D(JJY\,RDO?F+5+Nf1&-4U@05bMY53Kg7J&/>I-NJbB6g=NA4K=<PJ35-X]_157S
>1+V9^E8<AfRb.]@Ie/1U?<;49WJO,3B[.6S\N+W+WPdS])QF4PF4FT3;Ca-IfS5
/VI8]DBRCaUD_@VXT>3<S;/-YN?Rdgd?ER#C>/,3PVT/M[C=XXH;LTV@/eYJHcYd
Y)6XWV87>Q3PUc.c1@J/^6<#Z@N:4=3eS)(G_cC)f-@WKc,W_X)RI&;T1(B]J@/&
EBF^,RgK+IYB8/^dIbc_bZS88UD)<Vg6HJ53.YQXYcf[+R;J\H](^cMH[=SU;3O3
S3LYCID3a;/]./e\,&GR\YY]?U]#afdS3Fe.-[([A9a:[HI/K>.Z6c7L(A&#W#gI
Y5UXV/WEIIA,S3YJVDU(0/Q3\RYSdR1[Q376dF.Y)e;6)>2XaPdEHQ3]#g_=)7XN
Y2BA:<>UZ[Be/<D9H579)[A:I.5#O_^#O.L,eT4C)ZE\49;V]LFB,Ec[I7+IA3J-
?FcH[0D0Y/A8XHN=ggHYAc+bc(Ca_G]>(KD#CX#VJ/ZdU</HMET@8]PN2U=?MD32
UJEgZ<49^c:A#KRVE0D;5a4#5Lba5.@T.AJCC;3Z2JZ)3PE\,&C_8)4,MbfNFQV:
8/0M=P.,ecK],4&C2\M1IA=]WYP-fFU[AL(SA&4L]cQ)H]WLM9@c5,Zc/9;XYK8;
Uf)+3dfW1]<,c(YGS2fV9,14QgE78O=3P,N7B6GP1;JY[_=P1K<bb193,IU0Xf_d
_A[Aa7K[da\)Y]JD:.cg2?C/f^U^]+_ZX<_F0FJ)C86g636K8Z4eAS](d?fg7Jae
X#XMVHG84XO6V1JdGOa)7?aNT@b7HIYW?;&BMbWJ\QS9.3dID\F9C#=bP[N)<)44
0(;c3=f3-6X?Fed;.fYJ,R&0JSY<0-\=WFI#6F>738bFC(]0&gA>D2FK<4U_8c5O
N2E1((fFZR;L3ABILY-/L-Y/:2C?2U[_-O^1F(\]e2B(VNTI@SQ\e\H^(VV&0SI=
MVOCA)+&CQ[>d4=8b7b3;e-6f(\=7B=E=LXXET9+2T?_3SXG0WQVbVHX[Pg-B-6>
F3?bRAO75&3RI\GP,FLF5/[f/GU/.K0)JQ=PN8V[RN+3.8##5H=PcNO]BCNW#L._
@QC@/(VOG[?O>^Sd.?fdNM&RcWd\4G1a0S/=C?YX\TJRI#X[K6S+f;Z9a,fZ[Ge=
JW(T7aV0_H1eF--6(M(?Qe2SLF5U37TX]G.PFG227VPf1\09bLAORbDEdBL6OXd_
(&]E\+F45PbK^bE=JA[PB@f&6J(RR;#F@5?A9YXD\.J9KTS-fg2PIYc+[[6<6#DF
7+)VG-85a\a]FH^D4DbaJ7))C[cb@fKd[5X7[_-/Xe9GaXW+bB\Q:+YT;7:a[(7^
NZWf@H_e-3177SC)_Y,g&B]@C3[AdYR-).S&=B(N;=g=)_,3?H@J;58:W\^P,#:[
Ag7<>GGFP[?),?a1.2McB+EQ6\PM6,QFCPSCI79YXLZ_e5Mb-UQag->X?VMN:4Sg
>DSB^+H@;8R2aa6BS4;1e1]B-V]_#WO4(e>C=2&71g#\J[#/@TX45.A@>B<[@[+b
GaLRgH)(<^ZSD=PF5b,:UcfY[@7Z9bOcMJ)9-@Q=0\IBZHDfYX<LJ&HKQ]NB8eVZ
19N<NdQ\UF#X^HV4Me77V?38#,_Y5K.)6+D[(8X^&5fHA>R5C#^#03A0)A[,01E6
.XcDMX_6a,R8?>H4<-.=FX6[)ef,S@:6gL:e30cCIH5)74aJ9@+0#a8C4H,f5_#e
2UZgQB5)?UD979@F0=MbcEDX,-)c6#7Y]6U4(b+@;cc;gG@EYZ.=#WCJM);gB\L)
8^,dJ4_3UO/TH-JL-10S)(,bH][eC\HD6cRK#eY0]H,^&?/egNCeYM-4cca<WM]/
^M9CRL4\#6cFV=[^H?YJ?]GYSQ5^R,=>9.&D,\J<3ZJ#c8WI8ReSR<f_1[N/0PME
=_a?,:\:@2-DG?1-K8;S+V<#H+44(5bOfX[3[e[,SZPg5#X@DDOZX()P@M@,KZJ2
D+eXV]J\>PKZIO78RKHF:7f\M(Y,@Jc,V^e8-B2:e\c^E(7C@0\G?2;#bJ6UCY-G
E-Y<&6)7;b;D?4YGWaO6=2fH;P?(C/TH>a<_7]T693)A&C:/F0RZJe4/]JYK=HB^
Wdd#8ag?MHUV4eOE_4RH<0RBc&YB332+6HCeO44aSgJ>f\.>;3+Z8?;-cZgZSS-_
UYDcR8VS5KcL]3LY>>WO)dXM\Q7.#dJ^e/CXQUUF.FR6BQ.HQ85&;VPMT;N:BT;S
WTFTcbE883BZHZQR&+Q>F,Q_-Z#_JOZ-VOX_f3SR2?UaSZXf3S[Z6Q(5C0-Wf):)
RY(<WF3E+AU=VLd,FNZ3:a9F@-f1R;@]LMP9+-(ED;]UGaG>fYPD)VO0Ja4G2/H;
X&XdRKg?A-#,Nd)QeMZT6O_.V?J>_W1,[:0fG.(WP&^+Z)+P3A.X)KHPe:4Z/NZ9
KO[T@BS_-VVaDXN=3)[@F:7PQ7DW,K1UY1ZT;>HRA136Q-)F_AV0/5K5#MKII^Z@
^d8K4&F1EFJ4Y0=[C).F5aP92VE^[8YFR\U(97]c@NX<:3b[P.-F;D)GV:P3R=)Z
GMW80#U-.KD_(Fcd0_Fa7&8&>P+aA0H,?Y57>UTRNGPPUO4e/V\F0H)A85_IPHgV
XG)5R1BA?F#g.#[99^R;FPbY#_(b/OXED/]A5aU?R/)FJ_Q_c<PB?^5O[QfP+8Sg
FQ53^U4KQ2WJ+9ge3f^Y0;e?6AaDH,[CLBZ)NT[TB58A@60GEQAf7)2>@1Y/OK&1
)d96MB-/7gcLU[]OE7b<fbd+>C-7H8cHH]>U+eXZ#BPP7HBG0\((M&#+YcP3LE-a
dD>9.C4Z;EGS4HTBIX]FU<,7>DDeW@T8RHa&]/?<;^>cLeR1S20fHdZUD(J.D2VN
B^AI&@;_144e&WBDO#P/c+F3ZMR?SB_UW&GN,Ff@<3fTK14R15>D1UO:DO)&D(O9
7.f(OXMf11C>CI7XY(TZcS\([5ZXH1\K.7HF^.c6LBYDKe<6QCNF+c=a2X]J\3MW
#WI@Z3+S/)#]=0TTNU@6O^N(cXF3Y,0a]5eUQ-^-#(&?U(NSg0BfeOW?([,dfReX
fB]?QB<MZ#YAEOF/NYR@fG)MT_f?71XN#^)@bg;1-Cd+M1d1R86KG[]P0aVVb^SR
23H]]P^?N>3=LO4d_PG&fQN7efEVFN4\H0(AW;3VZ:+J@Z?dc+T+I75L9DgYV.)F
R8_g9+(YPbeP2d/DeF3aD(fegAg,CF\(dTdQ3GDN2>KMKE=R_-0_8S5)Q2TdW6b_
f=e=0Q_6^UIYcRHdN>^=WN16];,De\-#bZS03&G@P][5NPfF9:2OOF<7EF8&X,4O
MF>AdE^#XJg65IbABe2#AT@De8^G=]6F,Pc5>Y&9P@gS3S.300LE2DYSZMEeA8eV
aLEf.JdCA^_Sf<)e]&_.WF4<T&@TG,_Wbc&2ag^1#AL61:\@/EE1-I&(e0G^ID:N
dQ9M6)(bT7+9>NXS_^602K]#[4g/4B[b1bK&1Se3efG.fG30.?SRAHR06e8d46&O
TLMN99#g=SW9ABI\S0e,>;a2ZW>2,^<gef->9c7dZg_K4NL-\?Xb6(Z+-Ec)&ETU
d)KK\7,^g-.cC]_FW3Y:;9PU=_QQW5-+WPXO^TAWYH=gQO(Y\ZB:)D2fK+a.-9N5
;UUFO2C^RY.1?GEd[+N)GQYbg6#[MXRDY@d.7b68I?C86UR,2QC5#@(WV]fSZY@a
Z6):Q4A9_VDF;]2PQM82::@\P+AJ7WJCJ8AC[M,W<X2(cRWW@9BN])IH^c9Y49Z/
<T#M](SKd+@;PVO31[S71cX5cWE:c^Q]aeUXQ_f8/;A4GdB-V2YT5D#fVK]eK,W+
>C?>;7IV_O_P.MeP02).X3A0&QALZEZFg1\bbL2CCT(dQ@-,87C/WN/b5N=O[Z0N
?eI/GH#5>>0M.H&[4MaA1]K4.4dSB6U<2ERY0UDQC-4-DDR[b_10<#4W?#LLBM87
1g93T+&4dE=&cGL:_Yb,#H?4d1H2eS.\]Yc8b+>KaL5J;(Z(f0<.@2<eBVMYAP0[
Sg7f9[E?-8,3CI<F8P=4R[:JR?:Z@HH,Re?;GdIGUDe29\;(FD-IG6GY91+2=,J-
/2ZE)ZKKG#4\)/0DA(4c/e@.^E0\\D/\KGSc]:TT[,0TOdC/(W@d0/d?Bf_KDaA4
a4OY@a1\a_-CHZgPN2V_D\QgaAHUCaGeQW)PYNQLQ&N-2<OP?cX?fZe_R+./CSO=
WB.;eG,5A?:I1g?WO[9.^(gK6)G?f@dZ.SFB([Z;9(IV3(3;X8\Rb0<G1PD7G-f\
;=[C68c09S1B4@A:?a4-(>^\eC7>K3JEP@&(De9K+EaNPX->a3J8eKPJ6EabX&U)
ccTNC6VRG^WDaA0^#VK;UM,G.->0#))FXU^MYP??IJEBdgLQJX4>BHCM#2EKN/OZ
BK@<86;:=>@d_/a5GOGWYUaU(d3PV>_DUK;G9S=I6,H\8S4SYY9#=,6W3e;BJ&\C
_QV__Z3FfgXNWIda2M@\_CgcTf<T1O=5Q922&>0ab\]g_C0G&BDWaPX9DH\NB=ZJ
-;^8SJ\/Gf#2g3L<8Z]6:a&\]RQ.>N_G45-&FHM3&fg60)K7@>^;KNV[7DffdIF8
dTD<R#>faFMW2dM)NGBf=Y/O0\=GaAaP^/_6a#UK/9KO^>X<DCfL_C[JB6DU99F_
I-Ad<;TG\163Eg?EYF,K/]Fc5CZVUf<T4;XM4CX9XZH9-+I9X=3+BA1I1TB;F?Y5
V[NQ1?Ze6X@aH0(4fA3E^LYcH.-_U0GE9:R9f-4@O,Y35:264(U=I7c&>/YgOKO9
E<Y@AP9TQ[B\^d0eV^eD4T2\+bD1dEZ+(d-1afK4_+<fO;RI,dZW=Q62OIW??<d:
(=,(K-2T95E3[LWdQ7;:<7HXgL;c@2>QQMR#LS=.5WJ/G(_Ee8Z)5(>GWJRf3BF>
HW&g9b(LXLH<6&DcS&/aGM@IPXQX,>#Qb;TW)T+^Y3N77Q,E5[_8UgJK1Q7FW6g:
,H+/SNfdN&+9M;WfSbge;g>8UR-]9-4d@O)+].;RZ5@L&e>F=bE]P0e6=WNa<?BG
O-d\\\XX>Ba_MG=aZG34MSD]+Tc^@ZK+e([DUd&)g2AYTOP[e\<X3G[47K/[I7B?
d/S89(dQgIQLRDONb,O/#>fXc58@FSLX(KCMH#HTI3YZ(?f0Y_6:0\VReZY3KFT:
L\>gBL]A,f99N?AOb9-P;0Se1f]QT[JMf]^+>D]&ZBYa_>4-:<,HM@d3NK4^55[)
:8L1ca[V9aKLeL93d@67c3R@JTV::W8eOJK40#e[IOP]c;+/ZSM(@a-Q9(S7^Y>F
>d/-7g]aNNK8[)BM]0U(.g<\?WHCBI30UL@GSPGDHVGDPEg@F0f&&0fa/];J5aWd
U3.<IQWR?RfK3Gbe<0AE;Z4/O,F5AR:1;#3GOOH>[:<(Z7+bF0c2_Z=JATDJ#LU;
XU-B5][5YD#.&N#U,50<9[HeQ(B5RI@Q>aQNF65C189O+:+2QA.XUC^RE<a,]5F3
LB\7W+E,62cS3O4-Z=U=>D0[>cPT3YQP#0?I@^HeXG+743E^\.>FXZSNAC<GJ+XC
#Q/4aN2.X]#619B:P[8\[2]DJXe?_[e-OKFC+T)O9bG9Nd5-OV&A+EXW0c@B=I8[
b)M.\>MTZ;RJOKePKQFB?0R+R07>Oe?P&O\c/cZ?a>MN_I/a6NS-#dPXgCR;B@?6
\BaN:Y_/Y:K3NI#O#6;R,N2/0[&^F=_GNeH(5?36GY23#6.T-1_@.TANLUZPW@2R
?I#UVdXFF,PbC=KR1+_75Zc5V@@aAGY^>SXLB3M]_NI.MegOGB?1CT&L5YP.3gOQ
aJ9SE<Y<f)Gg3b^<(7cC2aTI:(\WP#BN[a)Y)X9@-]2.QC6+Oab@9D&#CN>HeOSU
C,gW][A/.&M5fS+TVK#_+,WV#]DNdLI;NV#Q(OJ3.02PBG#)c&_c\7.),:/8Wa@e
8aU/[J>gf\5K<K3RV/_.a:X,-N;M,,#;&?/bB[],d;J6B\;TgF#:>#S&b55P,J^B
,>3L#K\2c19ea92-=TTP>WHY</3(3YX#dH)\=HX]8SCGEUU@-6J\WDI>4K#:be+9
B5+S08FY7>C9-;V?N(F^(2XYV>K\T(N3WDZ34FM1/266\98[3<K&.^bc+/TZOgL+
.B6S<(g5.=ZMEEgR#\X_YE1XXR(4:;Q?ECRc.#e:WgOL@XB^^Odb_43U.gOOOZ8+
R@bcXSODNVU271JY2R&VDAg[-TGbTgPE\:VN(/5/@cD(g.C(#[Q<d9?NY]b(XKL#
4^8+f@PJ\H)=LHA(-6TC3H,8fe5Ue2XMdWXZ<),/Lc;Pd,SdW@IE;9YR_)3bZ.4=
MIZ4\W,1JYNbNdba>?Q27D&B:V3#1IP^[LI9O3S#95)&7(ZG)OW,E0A\8f/&acFC
@[<3CY]c3HdG6HA(R-SEH9&43DfTF.EG\WR&:YAI=b)UQ0L3)b<\:d&U7JJO(ES5
GSV:XC;2R/J(O)M;7,C&8W#Vff_&@O3PJU?d3I]fOFZ[NTOA6f#F1aD5([O+AfIT
(9?:4Z(7M[>-44\b_[]8G/HUW(3J4=e3^BeNfJ;,9:gE\RAOT(^^WJb2Y[_WQY.?
5PL/?VF)SN&#aA:W6Z/A6X=PW),TfV.I<O>GN.92cb1NDNFK:2MQ]U9Sg1#L,&)F
<HSD99HKSQY1P640URb@QTRd)CE6IBa3@J-fA^RBDa:,fP&IR#TdF/T,<>5_a+L3
&P0OXLf#JD=e,d>Ue15276\ca>K.fYB+[(EGNN@(dODg/K/XVb4P.eI1--K/eA7M
D_O5OI)(HfG/&M:#<fbcA,;H((Je4c3_BN+a.YHJF+&32MdA2P1P0\1<@f5+gWf0
O:<UXXE\beE^]P/aAZU(:035/N,4FQ?A&199Bef^e(PNe?O?]9S[e\T-]Fda@)c]
46CJR+WR4DfITaLeI#(Z^J-WEaN4+&#3A,=bZAd#fY0/<))Q^d2dS3PF/,9:FA,S
5LSN8D3ca[d5=0EM^8[)824@e.:I?XBeC\A[ZWT3ACFA);YLf]d,DIg[=b+WMEDH
c)f?P9;d8EC99&:##[2L_55EBL&&P-ba_)a0=bY5D=8cL@D+e1U:F[80I/]&b2bZ
VC2:bWe6-M5^B)]d@B7;0PLLT/d]/E_Q7JKC0WC/:UO=gbQaFEPb6ZKV>>OH;.MC
=YA+<5MTF@9#JV4:c;4+Q1gb]d::eQ>-7\5b(N/HgN]CT(;fS5Y:(B(OO8aDT#C:
fVLaI?Md6K>Ma#cP^,<<-:WC@SQMQ([LRAEC8Zg/Te?&c21?M>S:_N62.L0M#Dd;
Rbf2VPc.-]gPEfX247D7(]Z<008-SO\b-NLfZW\8ZD<7dG=W?fNd2ENTRA/dSXD)
5EJcUc@Vg#:]@Z?1\>C=#gUgb--]Qb53?J;:EV?a6O@D6,37WESK40@S,8M7eBR6
6]UO@,EXT/^Ne?).+>F^QY/,6#Lgg?Gf3WNO>13g_.,U\60LMb1[DR@3_@PU.:H\
-70^_=_a@#&bE35L[WX8]D-7&6JV?C[4F0[cX)@)9&&gAbI)+A5G@:NB;]Y2ABXS
L;^J:\[-YNMIX)AXefJ15<CfDe<X2:FAQ/01,)9TUOD/SadX/eb[;7HL&bf]2?D7
1&OY\BV&;4RWag(C.345/>f74S-/f/MY>KP>PM1V4?7_@#(J_PBZ6<?8C;W3,)7Z
BX4G(@&d.8^5=>X81,A;dIS)#;KAJf^R>J:)8Q)#C4F@JcQeN6937I.M11:Zb,;M
dd#,OcJGN0;IMcWKV2ZObPPN84QW+&VM6<#1[N=bbdHg>@:0F7Z:7/8<70c#12fC
G?6=T^K:SW..Y<WfUbM>#Df3_EJ3=5#6:d<gO7QJ73_VegG(Z+QXC?,C?>eW_Q.0
)44.?RDgRXYe(T:HLB5+B^9PW=Q@VO)PA71A\(#9./]/_bOa#/AP7E1e\1(Ca[e;
?=;F3NcPE_.;bXQ^<Pg\,I)GZ,XVMg7(@H]\9-\HE?,<;NMFbZ?&(CZLYH5A;/+[
6Y58<6RMb.,CY\c7FEeX3EJR2YbBOBWeCU@>_[eH/S3G&4#.:0WT:1[,:XL;4XCE
TU&GH]@EZ]HgZHdfH-_/bYI.B<Q=fBW@G0dY2Le9&UK=<.NKW&+XX(C\]4D/dYD?
24dgN)fBMKH;70DcZUT)YG0#NHdCV36)RD<-D_3,=5+M]cQ:0]F3.+^9-E5+)(YR
BH=7)G57Z^9K3Y;4Q-^&/0U10OO\]Q.9Z@U4R?#52g0ZADLTCB>CN0F7-/0W=/F?
=IKeAHJWeZLYdM__OIM3_N/,,WHPA@U__?TK+71&MH=OGND9Va-:+X8U.IVB-dQ&
0I?H0;85@edc.,HGfY^N.-a@B(QEbP5O=;+GW>;(UIDHaD4C#72cSDUL8/M0B\:b
FQDGe#UD6V>>QF5S9c:a>dUJL6fFT6Zf-S?P@dF]9-Yb4=TYcX1?[V<QNDUa=2>-
D\0@LJ@C1Mad>(d)HZ^@)PP#K([M0KHSd,VNG#2<eZ3,gSY14B@4bcNP69L[K](E
\3BXK-@4R3XU5/QDKM\G?)Z,[BL-f0.ac\=<HMD3ZdbI.fZdMN>@-\cPL74-\V</
?^@U@Y>H>TWH4-]9UY\,#[[-&E&1C(WOD8&81g+T?QZ9,DMC@)eQ(17,-0OD7&&W
8B\JZfKV4,@<?\U_MYFUUKVE/eI<.+08(AIbU-H>;-F(M[0LZW)[VeA/Q\(E>e@\
X>Y&F(LMJ-D=E;P+=D0IOHe@EKbKA9_29;87S#H^Y:KY0dXG5ZIKY4</CJSKN(,_
_=/1__N9Q]#IY2/ZD>#PaZKIEdHQTGR3+S(N:TFc[B#6C7I5Q_Wfe1,#?-6Q(c=;
+c4Fe[_9e@JW_XSJ:Ifb31^L9464YHd\N@M1B&d7;DI<PQ?.\bEgC:=ER6=;(cZJ
LC9U(]7U)8D(;G7YWbcc^R_NU=#8178bV1feRPM,aJGeQe(bW5)D#eCI#,_7WcQM
F9\FN)#:U&B@IYIF\a>8;1)R;M^a;3EP\RD9?2TB(I9X,c^8;R)OA5G-@@LT#QM)
&/P^8_8&(AGa/?00O8>bf70;3Z4&/RC81N<>RYNZ6Da5+gPA#8P3==#d[;(F:?,C
FU]IgY8A_fNEBSFZ\b1V8O;:T32:3()=9GaWPX0V5,+EGe-aO;@]Q;GS-Wcg\^Q7
GY/ZQ;E/OI+dX<S@gK/HD6aH-=:S)(JO[J?=f7@WG:OO6^_fgZ-ZaY_DSCP6<Y5D
_IX6c9T<NQG7db9<;OLZ?DLBfGb=NLSY_.9IfOP>;A8e3<8#eL>5:#Z[.bT(TLbV
5<\.#9=(<2&^\^D4e8X#MU7f5WB.,da:\8[Z(E<=PI@fY7,@U<\IMJ#)_GTY.M,H
4-ADP:W&^]Z&LC^I.OWDfQ>2EX?dZ/A<@3GF\[CJ,QW1IGRL]\R1KN^/3+#>c-_4
dNf-Y8V(/)FB]\K>.X<-/&C,03&WM6;@]P0FNC7F^+UfV7eFJZ53:D2DMXEMGARB
Z7\)VG:Y\)HgUZU-;cf+&;8=bL.6G@JYHF9T0?O6aW(c4aI3:QT2fbcOWEAX8LeH
fZRG=J2\I<4S-Y3_?+Mff_0?DCf9aD[(A,:0JTKG2FeZ\16.?d7ML9[;b=B=.0Z>
MHd_VF+YLMF;MEMQF-7W^&N6L8;MH3O6S-+[.4cKP(,,L^T@44NDE_21S[#a7E&7
;N=,\0aYL>:@O^6MUM?N^-CB64gHXY=BT,^WMR6G12TKZ675eWgC8^Pf:ERGQV7O
26?D@Qd&>]A4&E0,6NG(4PCF4_QTHE+C4M28>NW+=[O44C@6eZB&a4\W/A)@2@g;
X>-XZ0/DBKQ<.=S<e+c=JGbC6>SOQJ9Pbdfg(J0R,bd[8ALIX,UGLdXKIK^@eXAL
<KQIL\TC^Y@WS1=/OIO8_.R@LQe>H5HPgFMG/TdL(G[R@E;RQ+X4>^85OAW+T39,
f3LE9dg7#aF_:6)MX<LJ.L-E,#]GB5b[?8.[64B_OF6-.EdbMGe).3_A(U@F6?Q2
S[2+4fY@/gLFB7bg;ZcB7FZ;g:^JV3SYZC;?bf^ZbU/)&AR?O8^7gS(R@C1;HNHe
e:+0dT-deCVWMUd[CUIA_gQVV\:K\RBWB?0OQ,\aZ?^#N+Mc8[?+38-#\F1XB@G5
N]KR?&0\-Rc.cB#.SW=RFd9<=DK1G\#,TO2<_f]?8PTW&L\I>[.N.:f#3be<AeKD
(E3+>UgGeQ@4bDXc;<X,A2GS7f_3HHZN+,&P8g-e]#0@TV>1\Y20CG4I4Q[\FH,A
W#^-TF60[XS\f=Ng5ab8),XH2T9f,E/;a/;VeSadJ#Ne>OI&TL2X4YeO7,L[5SUO
+8FZ5(5-bRA[J1G::TeG91/DPf2O-\6S8-V9cDcHS0?9G&+W/)<I)&c9fMDELdH2
00KD@GVLV;##V/6Ja(d7G:1.>8N\)/-SWH@);K?W=27Ee]REfDGe664X6]9Q#+RF
5<7@dY5O-;;TU+fRA1c,IS1W<J<M8MS)ZUFM15&C(Q_SO?\@_d@SXRg0c5LW,8O\
3OW5[,CK[8BUC@L^<8-)HOP0M,\P;B_-DO@>QDb;[T0g&+6>C5TdZLbEASH7]6(d
++;A-Gf6#Ibcf-G\_7^X2BDO8:faY/D/cZM(>1XDQ6C4;.;?=70F0__O)-+I>JWX
OWB(YF)L;LQScJb#2(ODFS79L[<1PBHFAZf(f1Mc9Q3A>CLcB4UXQ/(7cQH7,<Z.
\OBT+0E1/JY6I#c0^VA,7+J)7L00_ZWRG<3;D;.F4@CMdXKBL+X-#U7Q3TYGEA:2
-=(:FcPMO9<3CT.0VadZRH@T47<^D4ZQAFLW&78;C2_\2KE_Ne/U.M5GV^TLBU&F
LD8@@>&/A>CG&Y,J\^SN<0:fP#d::5_[eVg>LL,^^.:?G&W#aUc9U>(ID8D6GK)?
>O.N<KU@(7),aFN3ADU,J7P.^A<b>;T_+2cV0/TD9=E87P>7?cUIH[DG2CR9HX+2
=_+e>EH0+@F-845@.ZTbdT0)MJ-2EMfgO-IG?YNLHD/&L7=DA;Y???dA0I#+PP^^
>GD7LD4cMf6OP<fL_7LN-R+eRW#&O3^4NT#-+e1;)4<U.80T<O3+FN,84d<f]CHM
;^D@DFRXN16NF:[6X-27eI4,5SF7&d-6.a14S>+):F+>V\14MZ5FGV@NG)CbR3-2
fH/M@UbJTDT_LcO@F8.H;0[]g[<cN#A<=^(d1IG#>_+YDX^U<XS4ge8?1J<:WY2^
0Q)?R@EfW<TJK4GOdYC,JKJ:?5+U3P,E^E<?]VBR1edSZE58=5)JHK=CWA,+9/UG
N1#F_EBNdB:]Y^IcDQNYQ5J24T&UUgYWO<,_g)+8LD.H=G[FVS<(^T&J6b[DMT#&
Pc?b=?ZM6@6)X)SS#CbZ&^&GCD(Bg[X8G.ZL<A1CdSe2O[M)D/5Y1S-OZ[(KXII_
PW)JeJGZGNNB94,03Q5O:(^Ud,:(IMg)XB,O&L&a5aEUD_U&=&2PFOb:\6+Y,/2A
Bf#WaUgXfXP^0B5YO&0PUG_Z-C3.L0FV=6?GE71@bT.)?S0/WJ,LSP:D3NLA_8GQ
a=(4[C,K?e3C=R>_^88\fUBC,g+A5MWJO>A/7Qc8-g@<M&gROgH8]0@bP:W6QWNG
U4_7PYGRQ]\__VZ>QWXbJQ=Q;,H6M1IU7R5Ib).VLT=>0?I555/KO.6<UfTd/&>7
SB>0+NW>4eEEB/XG)IUCAObZ5a7(?ML:TNA2R9f,ASQ3AeR9MSf\OU^g0DB_SSR0
>G?-Q8_Z6MBJ@@J[KF?9EHHQ5J6AYP?5/NU@G@1)EPS/\@WA^/16/DI)99]GFP<6
&COI.F?_2:W]:>J(fZW(&b]g6gQP3bHF250_]5^2Y7b-ZZUcAJbE]R?EbHTE7W<6
)?3E5YGC:_I>#H,/QF-#d(8+=5_.TJ92&9a&RV[5Z;@#VIQKKF,B#T^@J9384-F<
\VRc\CS\HG)NYREbRB2=^37G7^Ib(A3.X27c6J#(5UdbQEFZY>XC6WN9MVO@6_GY
#5B[g(84,&=gd-6B:@&O^#X.=:-NbMd/S8D0]5SeKEVC1a((U7P@0fE2A#1g4>Z/
9Y</E]/&6,PGWd/Cf3ZRWO1;:(L5&63P(aI^#O,DdX&C+R-8G(RY?WY#Wc>D=&))
[Mc/+U7fFW@VaP+\=db5)AG\IS50>4LF@>TWAHTd1NLdN/E^_eV.JX#LZX6McV;H
/4=Z+;MI41Q;P1?g8FA\a=GJ(]JSgHVfE9+gZN(];?;Z/Q6J:QI+3V=WEQ@?3?\S
C5]0^cDQ^gTX&N#+]6b&(]BYB\>DC#/3,[JSGMDU5C]5+2Y4.RaC:F01.X)Z4]X,
26?2=.<bfCTc8_+;8gO)0#e3L#[LT7g][Sf,e:FYY]BA]7cI@ZVEE-#I:WW8SOTH
)7Dc0Z^f\(;Q.DEMd7Le[RXCT0K\&Sb(\Q#2a[2RR2>)V0Oa[dXS9\#]PfN+Q<5S
#N4b@>294O[MMS&c9be?KT@YM7e99Q5dX6G4V>CUV6NQ=dd?3eS?ag+L</,9/Y1^
8B_YIMc3NNK=:<MVOH>C?E,;#C-;[.cSI8@W6c-+K]R&\K(6CO9L+?_aE_0V(Wa2
RTXg<E<L^bHP+MC>AED:D]]fG#C03gA(Y]\UJ\&>UZ5N1+,#&ZNfB^e?@>b5Ea7<
>5Za:F>+/EX2N2e>C77?58?27WPg.f[3#2@H[)20X2K=7#0\Cc9\W(S7c]3IA]MD
g,Bae)YR1RE<HScca<YT[MK7GP\O(JJV5YGd[L]O;N@YgG[H<YYYB,cC3H/PU6:A
R:)Q&\R50KL4VeU&+^F\089=Xb>F0+UQ6C;4YJ12L9P+ROHSCDX;O<.d:QX.U,.M
>gLL>=g,;X<KI<V<fCUZEg>8BMXOZe.+0C,\[2>2b3&HW_\0fEW1TAe.?APaFMKZ
_33XW4,@Qf=TeM6ZHgW9Ge(JeZa<=+L:XJ.7;Mc\EYJM1aTXL#SQJ8CMK0A;J9c]
7>;DZTX,-M&?@aU1b,&Lb6I@S&N_A[8+2+#eB[MI;?daP^K+YMFBF;Pd1([H8UH;
cb<E#1;7&g,=2M)<HUgR[\C#8R#.c3:_.8K^BA0]\4<&?L(E5:GVf?I2D#:X]//7
0&Mc1#S4gOA^A-D+4)D90FP\@[I^2?FI&#U-dRa8G&-OK+XJ2-SAA9]7#C\_bQ)+
OXQ=&2N-+gS:0D9N93;=#?K&:aDP<AO0338CWH,C+BZ-aWE0ETO=L95L1c\@Gd<a
f8S0=\\ELOc586B7/IZ]2+M_BLI,O=.FU6:A96G4Sc,A[^T:9.J+B;&N9NF^ZR+:
+e6,-X8^.#e/9KK;(S#LZ&9dRB4cb\c4MJG9G@d19NTEK=75<K4\8&dfWHN=9HI/
>[2g-Z)3Y;_Y?dBfb=>RL2]&2&#.)UWZ\J#Y@f2gbZ;:c,R8<.R]]RaHdN7Z>YKH
&HOOS,\+YHJR8B)?0=6/4^1-fB]ZTR)K9gE\6LIAPXf<=6^))S;cN6>G-WZ@&NP,
I_C@S?U=1f?W>2H/<Y_D&<8TL6eX2Q]&^+,gAIgX00OB/3LZe0bSI/Q4M.OHXE2U
#(G-.XZ;AN;8C(S@0_P)_#/gZHg2BfW&Da126TfU,&?Bb)[TTLddRS1cV^&J@/&2
A]H4-1M^2Y>dFH^B_BWZ6Bge>7\bO658&Q44[<3_H0=(Ea5d?(aFH,A,5W)XGVUX
Bb-Q7G_?a;Y>M&=,X>\:S]M83BMaA?KB(9VJLJU6g1JE]G-(05SD2MAV7R2,&3@T
RUI&8;H/8[2L7cT.,E:NGc8I[+,7OF-V=C@CFC[N@3<>?4KS3gFKQ19#:YF^[W=R
b<#\VVCYgeMR=eIM>ba3>J\QI>4&@Z_aSDI:@RL6e.a?#c^S^6_(IR4T#;J?,[4M
+G>+@48J63M/XH0_@]62.fDW_Y[b:_KDR.0F<[7X,CcCX/Q]F]3TSHJ([J)D4?Hb
[J@\CVIO-&F,BV6f3=Y#H61G;TV,6d.KK3ecV.:G]>&/OIb?:Me4d^],#b9d6MWU
^a>&YD?gb=RgAB864_-a?(^Q.3TDD>0.(-2A,;CO\>dHDW>(P5PTA5dK8_D3+\X/
g1^1LOcDQc]SZ_8FYT/3HF/;BL>/PZZ_OTRD5_9e_:0J6eROO5=&(RQKU=G.N\>/
LKCUF:KZYA88eQ_:Q=Sd1c0Gd\VN+_GNA_C?-YgeXg#Ha(7RXdS;H22(12c?Ffd?
V?T)_\<M6QK/>ESg1^6MeaA\U.X2^cWeN8U+cf5b,4\5#;NUN#30V([FUOZ:/RUN
JCa2]8[WV?ff-02f7GX1+1-C82#GC4VP@R/K[AF^+Bg4J8Y=>C@&EV]g:eV]IM+A
GE(3;=>.M##+^e06)<+<YQ=K\5\P]41AO-DaI>4d&A4]W;]2)\PDBa1KFS4.Q)YX
d<R.Vc8,=e[1#?c/U=\Y#W&]3Ka\#CP@\+d&TJ..Le;?-TE4e.ZeA1b5PK\J+OTA
/67+ME\^/-V(0YZ>;^8SeBNO:c-gTH_=(I_:=VIFc^E_JS?C3d?B]CbV\V4TU587
Z6<50&cgHg9X#+a@CNYP/[NV=VIVSEY>8dM0P7/MQ.5(A\=D>6UD,B5G(@>;;MS,
Z482ggD8P8XMGPY)H1_.1<.EUI9HV3O_FD/SP0]D#aH.-aTPY\3(Xg(3fROQ@+V5
W4EcIWRA_Te=K[WW7N?Z/C:f=1eBGR>?O(TX8Xb>c-1WI=,Q3+<H,g-&9F/Y_S.e
G63D8#b#CY(Va>V\Hff7^#@KG^fd5Z/7CIMd-;:HIO7-@2_Vb4::_R?YaRcO-?/[
_.0@.XI9TX;MC-#RJ9dHXV]FX(,04A<g#FZB]Q>+Q:e4QEgG6gMAP&0b5/+?g^2V
M<N]/e1B)Sf]H8HFAe)M6@@X6Xf,)BAG8A.dP]T,_b(?+WNT]],Q=>Eg.EK7;Z^]
b\La/Tcaf.I)[-EW7]BM#YW,WTS7-M9EPVV^Z+XWZI_WgRS+JUXJ_JaaB@eIGC.Z
Xb[Q<)VDD[-D6Q.IZ#ZAg6W(M39e>5;QbSSSOFCXDMHDX++]?V-RYG&2EY8Ge<cd
6+FR8-=?[5a3U49#]3Fb,FDX_B:\e+/LIJT25?[,>KB3LQ_eI>-?Z&8?bH6:1;XP
BPb2=gD+L7?F.XYbR<UB^[)+G]):dHC#X@::g0bZIPa=LPL>cW#(OZ:(@A#8=(bY
D@G7T>g80dAF,$
`endprotected

   
`endif //  `ifndef GUARD_SVT_MEM_CONFIGURATION_SV
   
