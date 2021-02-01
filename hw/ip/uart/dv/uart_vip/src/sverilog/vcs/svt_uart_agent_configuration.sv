
`ifndef GUARD_SVT_UART_AGENT_CONFIGURATION_SV
`define GUARD_SVT_UART_AGENT_CONFIGURATION_SV        

`include "svt_uart_defines.svi"

/**
 * This class defines the configuration data and methods used to configure UART VIP Agents. <br/>
 * In general, the user shall provide specific configuration in order to connect the DUT to VIP.<br/> 
 * Depending on this configuration class fields, the corresponding drivers/monitors shall be configured.
 */
class svt_uart_agent_configuration extends svt_uart_configuration;

  /**
   * @grouphdr protocol_analyzer Protocol Analyzer usage configuration parameters
   * This group contains attributes which are used to enable and disable XML file generation for Protocol Analyzer
   */

  /** 
   * Controls functional coverage collection
   * 
   * <b>Default Value</b> : 0 <br/>
   * 
   * <b>type: </b><i> Static </i><br/>
   */ 
  bit coverage_enable = 0;
  
  /** 
   * Controls toggle coverage collection.
   * 
   * <b>Default Value</b> : 0 <br/>
   * 
   * <b>type: </b><i> Static </i><br/>
   */ 
  bit toggle_coverage_enable = 0;
  
   /** 
    * Enables protocol checks functional coverage.
    * Possible values are as follows :
    *
    * - 1 : Enable
    * - 0 : Disable
    * .
    * <b>Default Value</b>: 0 <br/>
    *
    * <b>Configuration Type:</b> Static
		*
		* If bit checks_coverage_enable is set to 1, then it is mandate to set #svt_uart_agent_configuration::check_enable as 1
    */ 
   bit checks_coverage_enable = 1'b0;
   
  /**
   * Determines if traffic logging is enabled/disabled.
   * 
   * <b>Default Value</b> : 1 <br/>
   * 
   * <b>type: </b><i> Static </i><br/>
   */
   bit enable_traffic_log = 1;
  
  /** 
   * Specifies if the agent is an active or passive component. Allowed values are:<BR>
   * 
   * - 1 : Configures component in active mode. Enables driver, monitor and
   *       sequencer in the the agent <BR>
   * - 0 : Configures component in passive mode. Enables only the monitor
   *       in the agent <BR>
   * .
   * <b>Default Value</b> : 0 <br/>
   * 
   * <b>type: </b><i> Static </i><br/>
   */
  bit is_active = 0;

  /** 
   * This parameter enable/disable all UART protocol checks.
   * 
   * An error is flashed whenever there is protocol violation observed
   * setting this parameter to 0 will disable all protocol checks and
   * no error will be flashed for any protocol violations.
   * 
   * - 1 : Enable all protocol checks <BR>
   *       
   * - 0 : Disable all protocol checks <BR>
   * .
   * <b>Default Value</b> : 1 <br/>
   * 
   * <b>type: </b><i> Static </i><br/>
   */
  bit check_enable = 1;

  /** 
   * @groupname protocol_analyzer
   * Determines if XML generation for Protocol analyzer is enabled/disabled.
   * <b>type:</b> Static
   */
  bit enable_xml_gen = 0;

   /**
    * Determines format in which the file should write the transaction data.
    * Value 1 indicates FSDB .
    */
     svt_xml_writer::format_type_enum pa_format_type = svt_xml_writer::format_type_enum'(1);

  //-------------------------------------------------------------------------------------------------
  // new()
  //-------------------------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  extern function new (vmm_log log = null);
  `svt_vmm_data_new(svt_uart_agent_configuration)
`else
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_uart_agent_configuration");
`endif
     
  //************************************************************************************************
  //   SVT shorthand macros 
  //************************************************************************************************
  `svt_data_member_begin(svt_uart_agent_configuration)
    `svt_field_int ( coverage_enable        ,`SVT_ALL_ON|`SVT_BIN|`SVT_NOPRINT)
    `svt_field_int ( toggle_coverage_enable ,`SVT_ALL_ON|`SVT_BIN|`SVT_NOPRINT)
    `svt_field_int ( checks_coverage_enable ,`SVT_ALL_ON|`SVT_BIN|`SVT_NOPRINT)
    `svt_field_int ( is_active              ,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int ( check_enable           ,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int ( enable_xml_gen         ,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int ( enable_traffic_log     ,`SVT_ALL_ON|`SVT_BIN|`SVT_NOPRINT)
    `svt_field_enum(svt_xml_writer::format_type_enum, pa_format_type, `SVT_ALL_ON)
  `svt_data_member_end(svt_uart_agent_configuration)

  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif 

`ifdef SVT_VMM_TECHNOLOGY
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

  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref bit [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref bit [7:0] bytes[], input int unsigned offset = 0, 
                                                       input int len = -1, input int kind = -1);
`endif

  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
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
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
    
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
    
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();
  
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

  /**
   * Method to turn static config param randomization on/off as a block.
   * This method is <b>not implemented</b> in this virtual class.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_uart_agent_configuration)
  `vmm_class_factory(svt_uart_agent_configuration)
`endif
    
endclass : svt_uart_agent_configuration

`protected
)D[#_/OHU#)>9#6MH?-c2+#XXEVNI(/c=eHOWO1W98]3@,RAKg)9&)+1Z0A6+,C.
W,M.,f2P<(5DYaKH@_[:[CC]-e9DE,OL^E?+0XR_C]_3^<#8=8H]Gd5T=L^3);[7
DR)->8Le4F?@;P[H]RI2(91e.OQ\,-#/VeCLK9(D&_>G(:]2/VPVYX&LPd?@+.N5
\NZ)b\K;-2f#I)U(7<#.LT<[OH&]4:0RNW+]K?g_T@S1OR@G3/MV<_UT1fCd6GF>
Ae30g1F4/P]Of;+CaY+ITGJL_DCJ<@N9^P)4,CQING@D=@#HI#JK3<0.+b2eb^/#
WTY-NfO?<3,8_C(@>M([^;-PZd([S5bAE+&^OcJ272UQKbDd(8E(YXgK@MIfR^CC
99T/,WE_Dg/3A5@c#=ATMJRSFMFPTc-EdV:fXGe+@N=(;]0RKH02Y6aY9-..<XX3
JGT^eI9LSU<,d_OVN(W0^MaC:T6;I^&:BNZ]X-a]L37Z+RK3-bEgU62]>DXZfHV>
eM[6Z)L]A\bXVIJ6/UZAX\9<(;bC9)fSYT+(SSGQ0EZ5PI\gD05MCZ>a1JYWCG<I
X,+)=#f8R4S=8SS;>Y+Ya//2)_Y2XaH<@O8d;bFgB2?3e]Y?QUKf(,Z:)>@?V4B^
BY^@EC)#ba\(GL)_g;:O-eVZWT;U60+b=[T,>B6#6Q83F$
`endprotected

  
//vcs_vip_protect 
`protected
QLT-a[6AadAA(cDJMQT=>?WN4=dXV8HY3BP21OSMXT3P??1-(7\I/(,Lg:U8,P-g
\4:HUX@accQdKKL#X:5L]FH./R0b<[8Z):^G22H3@?8,AXKA_bS6Jg>RFB8ETBD<
[)LEH[fT[g@-5N>Y4GfX^V>f,&e5B\0AHEZ7c<(Ggf6E>;-#e^(,b4CUb0KPJ_?5
XDWVFU1N8#<JY82V0DgALX+G]6<FJM(N&H9Qg]-;MZQFR((U/MFTWcg33K9X[+ZR
#cOX_6AE5Cg1]Vgd&Tc<L7U_F=a3CSTK01-6FEI761aL[eD@g/P[(AR2P=gZ.C3c
7ID&=ZVKMI;N06X7?FT+)7cU>dZFWR#A(FXfM&e+(<UY,/+E_)[.HgB+(:<b_?Ne
DdcTX15.,D&6XGL9]T]fb&KcJdI/DJCU_Z=[H#:S,3R-4QXPA2gd]\V=[\4E+R-6
J66KS&6]EVSIe^;8YQU\-=?M,.Jf,_Ne2K:EMM;JaM08+ZV#7]eFbdM-1FGMGcYc
f/AAQGHK,L>Y@Vd?@NOJ:NI_^(0:E#B:<?[+J(=GaVYN&>_[a+6)MbYPbb?.1<bT
\Ra:6SW)&9]X0T4>NG#YUEK+P:fKP>>W1T.YN;;dJdZ4T1FYLcGbO3.XY[NA)@RR
6SRX7HMfR^;Jb-:9VF_@9:P&:a94.9L+O#D1(.L;N(0ULC@g(6R-\O.b+E?4FRCV
9D&BP3,9]RM3\)JB>e\WI3V/+Y^fHUFM#P68LRd(Q\dC+:=R\[O[WJF.WWeT.PTN
J/+dN(H?P1g]D3Kec/;B:-E<>K[0Y[eGNG#[0UdUJ\MPCIJ3;6.8_FQ-X&SK>U^a
:SQ-\&I]FXPD;CXe#12ARUXFN5>YT.a(URd4XW]@GEdCL(d_LXDA1YgU)_WX^FOK
F3K@S&AWgA:9a>XU;]//I&<gF4<GCU,)<6E2<GV6]?-@XKQEK4WZJHAR9;P23Kd/
6N^.XPb9HW6<RF^0>W<2H.cADR/6AK\g^aRA#f8B(3AQ,/0@ASCHc[L^,-<,FY?G
A<[@f-BDcPU(_Zc&;([DHJd7,DMK7Na1>\S5d2:HGYZ5g/04<X@bU:.-&)SADJ7?
BXRTR3FY:4&^VUAH#<DL1:>YUb)N0#=YE&I,;27c=K/6E4SV3P8BV^,Y6GXL=ZSW
Q/R1bf8d3QL8-1FG<BTU&DZH0RIg-Q5#,-KH78,VdOeQYH(-L7/f-+E5K()OM)9E
XMbI8KSIee;g_fO\_.?+=Q#W8D?9)21#FgUBY/-Dd;CIX#bM1LO/acU9M2>MNJc?
VL8#;JDI73YLLcb+b@V1f0_7(M6L4^@?U-9A6Y^CVVb4K_cG2c6c8DM=O=Mb/3PL
Q6U[&#IP4F4[&GT2d8_XJW6R]K>[<0_NL[;?^DR/g\Y#Tc.\bLfUUT.YDWONX)R[
/ECc_C,_0YZ,@#d=7YcTeE2a0X4VMN5T#3\V)[@QX:(c+A2.LBbEO&4K_DbfB4Lf
-K&F[e-c[KM&a94E7Z1KDFB5:BgP-VYMDb4_M4#H)7G&fF1a3X_31SKD,36I(OT;
85<+Q10&;gAff,AJEX0M8AX]F@b=65;/1aUdc)5(eIQZ+E=T770Sg<[VS<9YQ97/
Y;?AU<41<U&\ONK/4g6<\8^\fd43=]Md\a.&H:Ib5L>a:E.K[F1e#ZfA>9C2(:^b
LJUU0Ua9D+\WLP>2&/BM,Ng(==a6Le(]?PKW?f[.EebE(8L.,72N)#JJd\b\7AC]
gM7FaKBZ6eYW,I.-S=gZLV;\\1X88_56D2cM(9b5A_RB9ZNB)?P#M=APbF0=<M6=
,.9e1.DgVfJb=1-#f(DY\@0aIc>8^,SLT&<0@&afLVA]D8SL8Q0AXHA5E;)M1S<J
DbR.2407BDUJ\DE67DP=KPNcZDMBH4>QI>Md/3A&76L5L--#81<J65A.eMV7e7=+
c_T&>\/&_/#GP[\)N(SOMdCf_8=8X=XIIZHc>d#=PLEC62MPNRc4g_#ZPMN#KGd+
S:eCZXAZ?)16^\0[_2A4e.gELP&/L]1)aE5H>ZK^MQGFL?/^G90:;KgYAIXbT_5c
.W#dMDUfT_WDdg=X@FT6A=@EL0(J?a<C7EO\E<9,7Sg2FbdQRDT&BM#RXLV?+\KZ
[H94X1P#6AIAd=&F4dQ>A-f+]4_J6QX;JOYLPK(g?]7b9_KG>Nb-,9738\9ERV.f
C\a6L#[<2fU=&1W494gH0AV=BVT=];Od.9:/;#LG16Lc)c/@HFR)+=_EN[E#(Y=M
gPN:-#N3P9Z0<>gTBgC,77RN?Y^6>G:ITda3YJ_d\#J<6Z0S<)[PMg&.YG/YZEYU
,H(C;aF,I#6T#U5F<+D+#I;&A1L4b?b/#)dQG3ZY8+.V]T-6RJ0d;8bS,[P8Y)YM
;<2?#__Q^aYgKAWfK4;>[:S,/@5b:fPC:bY-K8@GA^-+59^NFZ;(:YeYK#7<Zf=X
BeP\:]H;S8;PS77<+U#2?_7+aGC6Z\&FC_O.):W4=A]JZ<Y&53d=74E&@)_&&M4b
Mg4,8&-YV[],CS]2&Q(EaRb9FO:Va;V-;\Ed^VHdDU7KO;L:TPWJVcQfRK)BOX6b
e^>+Q3UNU:,[_H-=AfTH+OfTdNW@@^f(^MP3(:[INX\_NC/aZa=FE_dCVE,FdPN1
<dX/YTa+@.UFg3A;K6<@987bSfaI^+(fS/b&N8AKcd)P06KU.)UWcEaJJ-FO&d;7
02B5417=H:@)7SCEPUJM8=\GT=;\(T?GB(AX]MNUbB/cQ\0-I2CXb:NZ+ME7N2LE
/Y=7P+&_:NZZ-X:>J3N/c)G[:FGH_J#/]_3\9VQ?IQ[?d;FDc&a)RAf^TPM<(O)0
BX9f,8>X&7IE(7UJg1ZRQ4[@VJYR<He<=G+.L-]-Bcc]e9UY(BYTX[A#GYA6AG)I
,U:U.YfbX\dgY7&QE9L2IOKW9&#@?UcXBaaN202GC>EA:.W,))?0Y>0TSW2\SWST
5b5?SaB<F(EW>>/fN7[+M2DId>g)6WPAIf/\KYDZSQ3SWB>21&Q6^..d-/gON0@B
[.16L,26_K_(JIVe:e/S//VMQ@#1F=MP=FYQYZ9+VY:92\9;/)<^1#0[@F8E=DN4
I#8?Ec,5A2R[f128:T@#?NDBe,aG/AK=28I6G^Q4B\bQC]eZ&+311f9;7=(bMd7;
J\IKC[3L8DZS^_Z7F[fQ+Q4RF)Y8MZ4dS0Q#2[7X&:?363-6eZ[bAgSN>)2AF>/1
IFE7T7U_8]Z/+)7>VY3PL#[T2e&=I^N/@_&e382G7=C1Z9L2(M=F\c8.FM2f@>N;
O]\46=L+?C9X2<48JQH.S;5Z_eIgX7G6Z3X6#C>:Z;0:]BOM\+UEE/+GQ#T@=Y\3
]8]GW1AP]6>5_Z(:\U@(bHHfS_ECGS])_,#>CY++T>G=34@VCJ/L#R.N4cXTG)X7
IOYQ9-JV5W@TWe3UDV0@+a>PL-LTV.T^@/4?D.B^f/OC7,E\S?O^J[0^a3-1LbWC
>0C#,f\88-/LAX\C,Ug4/Da.4W)/5?SJVO8XCTOCe)@_]+#@_;-;&J?4f.,&\;g3
fA6U/XTO/(,H_O3cb^E>/HPE8J@N,_A.C,(0cGB7-IBV&4?M;Kd<BK^IBX0X??Dc
JUIH2W&0ZANV#0K&&WCIL_OWZA&XUWKY-.^Jb@DFS^c-TDSOI3P=FWGW7<e;\@R&
M4Q29-TEH-:cC+272OO<g5]g_&eaKN<-Y^IQ<IK7N3ZOQ2MN6SeCU,8X)VVS0f=E
JGY>8KU,Q+@I+D;gUKfQEL3@eDF60RS-,<GVC=NTSYYMK3UH+?4QCa,c6_)3UU&O
RFXE-,EPQ;MI,+BO#Ac3TH,bcE01&A#[ZJAJ_FCOF=R]9@.].e&:a(MW_D&9GL3C
I6B[Af5+eEC_;S;9E+@2]C1-4(T2(Aa7)J33O1c-FG(^>GX47HN\&X#=FeCU]08A
T\-ZS-]?;MSb(6U/6=OWdFXdb+c,CJZCW:eMR+?Ya([Hfd@cPCEN1@43TW2@9;ZS
DW;<gO-d>?dGURf?.S0d@F\^f+VW0<B;<]b_K@:3)NVPc:338=e]V5cPA;AaV2\]
;WVG7XAT2e?T-#2EN&<65^(0e_C)LQ4O:4M[HW:a:W>0B.1S8I(e7aM.9IX[Gd&Y
SHOQ#7P.H8Q=2gCdDN&THM=V,&?56Z=@D-<W;c6#0=8)^_BSXJ9,KJ?ZH>Z5?LRH
Q\?9BQafWUXfS,Xb-V]]0b7XYP1[E5Sb,,Q5]5@g+gD(W5&>QKVH=F5G+0(7\#C<
g]6ZVdFC;cP@P2V8J5FfLX^Q/@[XU3JJ;9&4cdb;I8Y/B?EFF3BB:Q-K5)29?a6:
?S+QXTH+)-21UML]F^7;Y-6WK4FT4dCXfT?fX9HZ](b5aH6=_L;H_(=d?9(g-BJ&
<9N<TdR?V=)&ZTfI&0<UOSAdO^]_SJ^Z)Zf@7NV]ccR_7+16(<fE3;NIC>X.2\U,
]a7_,@]ZB2I.Vb2<C=@VRDPZ>]0<gZRWIP?7JONW)]W?8d:I\P/HaK)R28L&<bSK
0S/P9B?)MM/:6U#Ye_caJSfWfbf9?.SX(2FF3XCEH9KMDP^:/7=AT1LI@gW_2S:;
RcKb9(?O=KdB-2Wg<PfTFY\#)14VFY5G6Ob]W90e6+XS#M?U7.<>ZPNZcH(ZM1IO
6]/U9B3N.APXG#BfDF5/;YEPbP>6AV)^@V@@JL6R_d9@fSS>AACT^ZXWSb:^FIcQ
<<g&@Q8b@7F7?cV\-_Eg-;NYb7CYVE+^FRb,R6KaZ5OE\M]K\OV)ZA76Ld51YLGU
1=BMdeX2PD_bc[F?T;2@+@Y_D?B&)&d57.BYA\eQZ#0>:OK6X:?:bJ9)DL0bYR,;
O^GQUA7PT(NLR)SK0XW@Q2gVA;U8Y&A-LGJWcRS@HbO#]X?7bZdJ4?d-c]8OH6b,
DX6&NO?V/-/g^[K&IMe>#L;AT)N>R_A3;E)AOa=8R/:3_f#@C[?D/Z;JP]fKXN)J
/1RPOA2dbH^V?f]U719;??W)75N)>f=B^CBW4H(1F^5CB0EQO?CNEc&(/bfL1\;3
e-(@9J/^18f,C0LF_(#EWeE@TKg+f<NT2Y>;)<N-B?]5&]Qb:XVS6G+=#a3HS)6_
1aD-EX[&/ZbV(0LU^BGFTU2VG8<=aCC]:_<P\#NZ74/g=SEC67K88(Oa_e?4R[V#
e(cN?1_7AE:ID806eL2MadfEV/-eH.WXbDJ@/AgLB?]Y(<#M6UM6eGefL@<O;73f
67QKN_L@=FFSeU/LG3a36?7^>+:E[)gT]Y.eT;Y94:-PQG7X.cL+P64=&LYVg,eN
&I7ILdJV+7EG:+14K@QR&.0&>+U902QAEb_5e_5-P6]Tb<N)dcQ=9E^Z)220(5JH
76C>&?<[D6.0L7?7Ef)H-ZR1[\MDf6fQ&b_SS>_V8=QcE7Z3@a2>(Z??1.KT[FH\
U9gMZ-0_B@18#Q)0aIOgHT:>UZW+UTR4Of1gKG+?YF/MXMJ4/]D+(&T?W4=ZSPcQ
<0g?V6JN8[D;Y]AeM>]?K4TF4R7F8EQIQC&Z790/YNZ4?RYbYIB++,8DIJdFUY&9
,(4Y1G)P#O?G,c9N,X[@OVD?1A2SE<F1Zf_332b7R>eggE&#b?T@UZTF:fafTBbB
)Sf#WJ2F15a/;R#;&8EKbSOYN/RgeTU\Q8Tg\Qd7J#FP2IP2\]X67NK/A8)aOTL&
WNg8V4Y8/4Qf>Va3+C8?XFfDW_Jc<JY)OH>FT/d+KTP:a@57><.#8fge]&bL8BBd
L:HCVUNM+SORgZd>-+P9E)DV<0:GXL^9aa7@HB5Z8g0a7XaF;#+09HQQC7>b.Mf_
=\UF_g-eA&]?G.7_3^[8+X[#:NJZ@Ce&17U[DWZ#TYS]2M9Nca9]I;/?_A2A./P2
BK3L6]YBP58,#K^<E]OAF47INFH#BcI64O\R0\W67S1>7eKC<@A@(]E&X;]54]ad
NJI-)DYZ2X4:/=94=WQ[GUgD8f<@^?:a:5\T8CMdIX+2BT.ZOY->gHKOV]YeB:S\
DI3XZ._V:^]QH54UGUQ,,OL9OO6g.\Z3C/Hf@B^BC3V=G>0A2SgeDa]T]VbBQJRB
C34_OW+B:KI[[&<K>;eTWPF,\@g8KJ(Gb<:?YO41X^&)N-H6G[WX-EYdFbX9faE>
X=YJ@E^\BV1>#b7fE9.?&b[3UL8,OA8d?/T?cY5JQ\b/[M-#f.NXc_NCG55;NPCD
<cK(_Z=@TXDTUNS;BPM^7DAB(4=EVWb/4)W-(@0<,5c?f=cREYKQfad6HCF9;0Q]
G6HU_((E\W8]+d+[0b6bAdJ/8eI5ZS)/CZa#V/#R__;)&ZM#\bZRKbfTK.2fPa/U
HX3ge.5bZE99Xf@#ZJN:e1?I#LO37=2N^<S9;<?]_01J@cU3NdLY,6FWYK0=,KY5
f(V4be8+.;JANU5Fbd@=-JA^JG[fd#bdd#YQ@WA48_9eR]K,D_1&QEG^PYVG\A\V
A]>(+:+J^KHC<c^?@g1G[W5)d]AMcSA5-TFeVFgbfDK::,cAO?D0DgDW_B=692bF
_HV@S4TaY78F3c6.NY=E+fF]\W#V0^bL_@MVM[aTS7a]d+HKZHTV_<f[\^QK709G
PN]GVMaCSQK;g,NXXbY;E0=UG-KacZE+2P<;BVceR/^fRcPXPF3]TL1VIQ6^VcC)
GT?D@_Q_K,L,60A9.6_#\M0]0Z9^eX^Y02)_,QQTdO([3.YQ6-BSJ^HbDN+K?MOd
:/ZA\QTN&GXbDL;BRc_E#0ceSSBA57b^ZWJa?1fP9D/Pda(a+IVG.DfPHW&H]cT_
M#.34]2F\N-#84Ba2&K<1Z4eUPL9DB4RQAUILJ2K&e+(QS,-gB8).#\@.BLV/7SI
/O,V][L:MdAR:F,J;X=#?gc^aNWf0-2B_f21MB^K@XRY(Pd_--TY).61XMOe?#SM
c0I][c,<,Be?Bb__4>(;/22gY>&,&(<79XE8f1>3fba@_8^,7LIM_e+Q^?I()1XC
U?[#Z(U6T)9WFU1:<fMRA#6XeW?g\P2NK59_e65MDS#1(1ScS+U+]9e=#)>NO(SM
AdRF]RY(^T;b(>N.^_QPg?bW:FAY^VV2M5>+N^0P9;LKUJCcMPBD9cL9\D1?4PbR
1:c8BGe&TYZ;eCR<W(eDgKYB0;=1<>?.Ha?]/&OeZLOMQTS@(CI;B<]J>A3?N:]Q
HQQ^6#.Q/aDAH/:0Z^FdX+]8+V6^O3C>W(H6Y,WQD4MU[b3cU1CRPg#NeCU@\LC]
R4J.CNYO:0;#R>?-c07BWLDFX2WW3L6;@G30M_PX1UMV.V9)@L1Se,=9?6JBD_g?
F3SWK(.g@EMD9gJX9e)AG7)=U<S8cI+?W)ALB)B>N1<@dDE]JB[A?K8ER><6/Y(X
Y@g(K9A1@V^Df7]8bA@2_A,GC<9.A8@(A10)fZ.TJV</H[^ef<d#M5RF1;W66C@I
&0(I2N7P6RO@Q[#_)-0S)8(K+:;._>KBA:H-)9BYLL&C7<2:,F:\ZN6eRB\(@-7g
N(DIX8WWYA8Y)+]IU3^e;@:WS-5?;VI4gDB0ZU=0:XL_44PgP@AdMU?>F,<:d7MT
a9#&L^T^_e^3RS#62,:HcD=TeB&d5C=8C-[>/a3FORb3FHB8?P49)>RPX7AZ2-59
HW]UVZ5C-?0.-7VE99:gf_b?MQ^C)cMb3dPQQ8PJ\L&>,d(#G<_&6\P3.:P]49T?
Y0BYQW^N=@EI29LOUS.OHG@@(G+=:a8TNWTFD/eKWLTBVXgGVV+.1Bd6?BW08A&E
\:bRBa)]bN)1U^AQTbJRT-)RZ-WYV(D>B2A^aG0@A/:dBXc1LB:=N&cMH2:8)g+c
)6_GIT#KFS/CeC&UV50ZcJTK;d><gd5F0.4]&&d[2]WJC>;Ze<&__dGfEJ^d=3V9
6&O[KGN4g@,TX-):f7PRK[#HFS.=&7URAb<T:)+(T-WJL-,\3H(]+M9>Z,;433W#
&[3+b>,=FK0ON,?#R9_-N;F(N_7+5Q>3B>&=.+>Q.;aM?6R_32J((_E:-.;#LNf^
F,2Gc&Q?>SDD:e^c,Tg&O(S]c5dbW8145fcR4f.NGY&62O&VC]1f_Z@/BI;@)SZY
N:OaU\#]^LeAa#7..@egOS9[MWL@REM0ETAJI1-D,45Q=ZGB+F.?9CDNZ:.bIEP>
<21TQ8;AfB6DZ_.d;((Z?fW.,KG1(eV^.IV@+L?SEX1e9e\Q.MV01+<GSSc+)BN.
SQL(bJc:?3F]+L;6NcQT+3+6JNIYUBTc14U3b[.?DVNf419cg#+Be9fQ27-GYOJ]
Zf5c=.<f#^C\M]:NR)fW,S,5U#OVM0WKR5NEM1Na]IQGCbVG\UT4?KE#[_b61:N(
#ZdUU,aa+\Sd@@;7XRK8708Nc#M@9Ua/Tf4e8D_c=ND;VDfdg0MQ.Rg>#Y?MCX.L
2a##=4098BDG^D;13@(\W7>FY4>RD<6<fW369-437@<L56FA>Y\)QW-HBA<e8>3P
+AV]/^/?1-1?MTd/\T<d<IHed:_W59SX@+g4,(7>bX6SBNF2O.JKLdd_QVMd6<Ub
YI=ROJU2N/R@df#6T09_6Y7cg[&f7Bg@@]4B_;fS5D7L1A+cH]X:]MWPAKb-f&R9
Ff8LKJXAa)LW74;Me8Z^-b3CRcUMg7,e\]&T-<=.5[:LLY)V^Hc8GbP&/ceB#:N[
HX=-Vd&WDV&OIGfd^;U7VBUf#D3M8<>TbTa3SW79ZH3&<Q,a+EC<5WFC-11[H:;O
f/=0G,=63_MVMU]^B\gE[)f+X<9abKH_4fF+.Df-YEf:@,Sd#6HB)TfQYZf]5(T?
)MIQ/X04M:g4Ze@d^R:)F99AS?:g_LK\eXg5?[4M6Sb-:291-:I0(O0>O,1DA:7F
W25&<1ZBMJ:<K5K7cZeJKA6@-CTILZP0cGX.7Q^M56AdBg/4BAJ35M;HWLSHfYbZ
8;C7JL=9(XJg,MWTLRB9ZDG]Q>Z[Z?aHR>W8+5d>;_TOQ^FDU)[\2P>UZ),I:cKR
7?==+0JS)G#JJ#]S:=,.f=\XLGM+/&?ZA6VU0_+7KJb2YDXa-77Rf@E)-5=8GdDB
LL#=+IJB(VII1CQPdA_OAJV:cA<T_DbLAY3gPK?4b:&=V[<aL<WC,Q?40#V?R#Y]
A0?I9T,?Y)WAa+TVB;XE[,]7-a_b<2?BS?_7_ZHMa,NLV?/3AeOC(FCOE.1YTSSO
EG1681MW5SYY#Q(IF]]Sc76TX3[<<0R]=<7DB2<JLD\.7F=\g3a[W[SXJ#VH-/Yg
UQ.P\ga,QJE52;:V^/<+&-d-</gf0dWHOCa(7,3)Y/-aP1B,\4I:Gc-YHaCR_+/X
ZJ15>FB],[c?Z#DB@SEbK+7)[@4/+>F1W@:C85gg[.+SOd<FbQ)N,0OUa7ANfNJ.
6-(IF)<@-RE_78C,^\]LEK1OH,41^\FN3RSL09MdZM#R\[P(L]-:2f9cd0@?HG8Y
WSWbE^VQM]b?B^H3E7.:+FL9JI&,DY\J]00CeGeYSX+<^_Id)g.CPaND43gB:JfT
KF@U+Jg6).0@89facUCfKEDCD@Cgf5/>8KG+f0f6>e4G)OA=-Y4]:LE<V(QN=Ke&
\:JgWLS)4(<a];.>24B8XM9M?0NU]M>1N@e\BI;=.N\OfTLKZfB=VGZCJ?,;Z0Kg
>27#.b]9.TcV?;A.UXgGX\gVWNBNPFANIC@X^HS6K/ggCN?3KGM1X,S+fe[3cLB,
R79GS6f&\#>D\M]gSVOZ=R&T3g1]M(Z:SbYV#+#gC[_1UZULZ&<JST)8f,\H]4dU
T\Sgb)&f?6N=D<0RQ<^_DSL8C\98<H;K@#@;Pc&[b@&P5\>Y-J4F(=W#,^0gd(a<
P#H26-eJgQTX\#50EQ5#gdS>UZ;OV62KC+A4D3Le.II[>:/+U(]6gbFc4=cEF@T4
VS#<PF6?d4,]#[<&@\gH=,<_10GaO>;0Pec\XKc=aIV@E1D\OUQ,bAZCW4/WVQH(
KCV41J@5M]4e2LfQc:29GLCP>BA.\Fa2O87IG\0(^+7Ef^H6BUGVgb#<]ee>?:#@
J=F2Zc9Ng;.J(8=Vc?3<]/(89Yf\44O&2Z-b4K>-EEeF&ggY155N2Q3EE/?)G&\Y
aLL[JNG3N#W4b<V7-GB.UIeG+\CEP4[RGJPBUgCYI\#c;_>SVgeW[JE<]_K0)ZeP
_&UV3F946EA[]bULNJ:-DEP9eOL=@f(a)ICC53&d>HG2+\:PAM,=44b.1+0\PT51
RN)[1L+g=@7TO6(\[5M?I,P[+f?+P<<>XFf+-?BHA9L&/]]1Fa^BcYd4DR.^C=TI
R>DFdMGW[,WNPG)NY@8b[0S=N:<2.dbEEcE-H(Re/?,_H+;JTBLBM-eAY9>UV9_b
35/?#=D[6QL=PcS84E3\I/(d2#M)b8+dM@KZCPGSG4RQ/JY)E;OZS\HUM:.>OTSS
b/K]-0-_4)YD45YIF6HIbO-K(OBLL-&d1P&9P15&/AJE?>\5&bNCT@9X>OICV26.
:;O@J3STB9<HSKA.g5Fa_FKe3NK[D<MH4<X[&8_=9CQaR3SB#+2T/PVBaQEXZ51_
,B?(g+B8K485/FbPf4AKOX7IL<FO#V&ALT0I0#HHT,g0?4Z5e>K(GKEI3Le(a5XT
[B>Q\.05(UIfA1SK@HRXS34-D.=Ta<\6^?I@T)cSR7=WFdW686:(dJW8aB^4]8-c
@/UL@I/_R)2V-4S:JV&0?P]Za+Q6A;VZ)d&^2B8Z?;\:aRSG2SffF&N84BD22SBT
6\]4W7)01APEH7B@,IPQeL[(S5\YeK]RPZK3S6&4gV-0)R;UNe=];SQTSV+cEK_&
R<.6Q\8COH9Q8@L5NXf=UTgX?]NCFB&GJ+/O^^+Q5[e257[IDJ-Md]R2)c]3&#4&
I)+]Bg\OC@ZB?N#E?OcCD^59MG:UbH_2Zc,H2KO7#F0)4a>)Z^ILS8NL00#Ua\65
3Z,4X1W<(,>a4=eUB_KF&JX5OY--0BI5)4.#EcI3-De7#TT/D\MHNQN#(eE6.0Z>
EfK\?:a9,bX/C7=97bX/HWbB=)=J;JD)4:00TDMXHQfbeJW\2E9/C-D09T]7d4a^
@>eECeK.,O/MC9Se(V8Y7KY87ZE_cdDA/g_32G)B=A;C5abdE]J/W2J_IWM2b24G
K&I[g9Dc9/)24YE)W+L?GW+ce-645QF&Id<7e4]SBRH=QQSC+b;f\Y@6BaDSSV7c
VdCEK8J.<cbVD92)\6I/9b0bdM3<7>KG2ZcA-53\CQ(e4S_H_;R-DF6^(\SX)S_Y
Q(Z+Db[Z@_#]YDRb7DTUYQ[@LI.d1Id<@fb6+(N(3Q.T>1bXCD#]G0[ZV:\B6=M/
=#0>YB>#U[+0/E?Q0+Z2HH?=e0CZ<0ddSL(3XZQe-EV[.Q==<VdS,]e(4fGA)):d
;Wc+8;CdD03VcS2aVO3AT;PbL^&^ABZV7d)/c=O+DA5geeQaSI;6>VJLCM.H&9H-
U4]Y9H(68N0:gKOAH>)2NT-O85R2P@M9QID;YVH)BB2/G#1S02HOIOC68A@E02aI
5(.87S[XaI57a9IP:&8UE-Ca0\5Lc9Cg@/MS.aHM7LIP+YdIPM]P(d@=>KBCJ^;O
Fg)Ib.8XZ^UfE7BOLa7R;C5K8CDFX5#G2+8#@,CRH=0Z1J8#2F<P0GRDEIXIL8g;
8gMQL37-/;e#-dX#B/N]R94G.VTVX8Bd>9?Hf\^<e^4a/]:)3C/4E7:d,5dY_d8=
M82)f=F-QC97K@68D;/O5/@(<S75;+Oc^+.+J[dP?Zg=#FX[L9c>S:@UE+e<+g+d
O>-c?#CIbX(KH5We@14;M9Q5-Z,+-U:1SPU_O\_EW3eAO.D-.aa[>J;0/P&FDAeg
/DfJg7C=S+K-HB]fWLeN+cOe5N.gBF5X2&0Oc&M-WUE;>ee>7;XGMCC;WSd[c+]c
XF1?UR5^6cS;dT63E^<aU@>0C\]9/ZMMU-,MNVd?eEPCEMfKfb+>CeB&L@6<K8S+
C7U56LcI^#C0@<@e@C2\;d3KH-4=.<F86JN9E[4GUd\,3-e<5Z5RW9]EVRfU:DLC
SE@4UMFN4P;)dd6GG,W8O.Ofc@.5Z8beX3]Y:M6G>(Y4B#;VDPIUN-X9H)5g>#W4
V43<9INQg@^>b5KXEE)\20V[;4=JDC,N@]BRP4fJ]^@GPM:6+Fd8@1A08X^AQ10#
Z?+DAPTgZQEV&Be/[O58?Ebd.^@()BP6V-YL(;(EBFE?U[GB_2_NZ>=^e8gADe-b
-(?-#6333(cSSEKFY>N,cLNN5U[49b?OdV1PYTOTXYfGeW(0d&Eg384\NPY^6#Z7
U>9NO+M50YUORDHa)L\_Jf)BPH;Y>N4>K)A#?A<T80@VaB#C,X09#1bCIHP?LG<]
R:UQP\5S1X7(dO9(g6bDTJH+8P.b=N?R4.G?ZbIK&NP7A,H:R:cX)Ed)<CbFUKa0
L-U_KB#S<fH+3JR+Q.R\^4//EH:XeH)YK@g&I-Mb)+ObHA(NY\<KaV,K^2JK[@6E
&?#C.K8dc)L>EZ2IPFg7I@@@1[?:(RGRaBC5)H4^YE9<e,?=:.^0NeaLZe72U:EF
.M..Td_bY7ZEW8BU,QbDKS1L_;d\AN-VD]ZJJ9&eVR0,\J++d?bSMKZ06OgSA<=U
J7B99B2S_IL2&?D.ffRTRQ:5GXTADa?29GaQJ^b&]P0bfP[FSP?V8-A57<&>2P\M
8JS_agY0@#9-K:A)C6B?#)I4AQd,.^6GX3b&2K2a?[I)8+FPBSeR+W?4dPM]<^@P
M^K_]J]SBJ3+_2_B.C9@1&-1dd;HUAR=-P.9H&eMA,:_K_Tg4M.(PO/8PbR6>O-Z
?dUZ/#SM7_3OY)XTS^aGeF7C8KYdHgb@HX3-N;#,3Id\0KXcFBf/-b2&^RGN-add
a66FfTfa=a7&aF6M7a6f,WAJDAH]IF051(GY#<b0ATBA[TG6I<g#\Z,@HAeP[64^
-T-E/NF<eF6&T>M10A3:8NR^-0\a5I(PRa2->bXK;XVE@9NUGFQCS;DZ]BZ^P^/\
QF^[f76XM\;e9Q0EL<DO:ac=Ibd@Ae[49(#d(/FI;Z3RTV)HCd89#&a35ef3_-NQ
C;8NYFDJ38D.b^K<_2eBVX7Q#fE5BFR]J0,X:aSHP&>C[R\<f4W=HSEPCdR/:V@;
(g>)9>.C^9NLd3E=H6N]^V@WgT0)1S40\DGS8;2[BeZ_J1(X<#8C9;dL-#+^.5#E
U^3faP[C.92[PIIg^G24&aS6C3B=V]0(Z<<W^DR1bCEQM8CJ72AfPI.\T<e]+Q.X
X&Z[L]?1]PX_;A1c\ZW3_/H><D&)\#P;MM;:FJ2>fN05+\V)&RF,\a<H;QV9D&>R
:H15gY]eS>@Wa6/?&g2UKf[V_2+4=9/ISXWIV-9JZ?S>2<P/IDSZU1?5G<&4d_F#
#Z2JM0OB.HX5;Dg@;_b?;]adBd8-&?\b[gQO[AZO+,IXC?Y_6J2_XF.XgF7H97)C
LLF_;25A&.@)I<WC+dff^3(+K0aB,?I#9N?C;^N@M^#7--Z^UY^0/dATEGcRbZgU
GcZbgLE5LWG4I,A[WBJVL^#A6]XF8]P=Tbb)9+O8?0OV/ZfX_U78S[XB>S[aV8V8
5G@:3&H22=79XX1ZH6[_LV;L1EO.#@7(73Qe7O_,G&aGOO&3/@2_BV@OPIOTG>^H
@(^a&^K5DKB39NHS98)(f0^DEeK1;@01Ng.ENL-6/#4<Od./\7E:1.=S)1E-BJ-=
BLM/9gfYJ/;N7H@@7a7S_5ZFfd13gPR6HSTF]E=DDEZQB.FIa96Fd\d2;Rf<;f?]
1.F57S:FHT_X^;Xf@+5_B:];>WQP;--.YH?&F@#e)]?@^@_fH^ADVP#[IJeZGW\5
T\gAZ8&)Qd)0e0CTQTcWd)J+H#96^3aDZLVX5_G(JAHV[9W.;>O.S-.M57RDgWTf
#S]TT.@A=7EYBFAEH-EWeLK.ZKK_OgbX8b>ZPaD(9V5RaIMP9RgI8=C)T31eRXTK
VLa#<Ba/Z04:BdM69If<IcGJdU[7B\;>;M+4;U(bH@E7VGf^^,^=3_V(3N:BN>)/
O=F249&Y8SN>Y^L5Af.4D^U[(64_MUa_F2C.C9NC[L_-E5D6<-7@V;.MU9:3:AXf
K31b\N<U\3O>MMdHI&a^(RBZf[6Y/KNe9IDOL0HTE:YJeOWA&fHZ.fID;@F3&\;#
.];;f_T;3^ZM#LEaRO\0>/d.0RN]B?KV/A0L^2,G\Q/J+H/AD+Q^ZBTYLO5We62L
NT6Kc9/+]58=@cPaC57EJ?<Y#ga-SQB:<2._&G5fB;2XS6(OeJ,[[+F(-.Gb+A==
H@U5H9:5aG(9+G:YRE4.gFSANQS#B-Qe-]_N[E&LY?LH+c.6+:<,;AQ)=^50N+6G
(^QFdG(aQ)PdcG=::b;9Va<TJ<0;JT0/=GbScaaWYI+T3T1X,D-c36GBaAP6ULB/
G2[g=M7:1/[fSa@)c+@[Xb(@VQZGE\JBdPBQgIXL3d_B(IJ\(B^[#NNYMd(KC/(E
83T8g])\)#A/_E:)b<eR?eFbNHE./#f=cCdY].A#K7cDXe/Y>1.7#,0<ZP&L@0>6
A76S:ffR#9)[&FZ_^+I-CW(.B\F9R)dQY)f,@0IaD8Q9#O0(NG;,S<V?0eW:44IQ
:5G3LI,/g,(QH^5<#-K-Uf+N5bDI-^5S=V:4:?[SFSER-6U>A&4=JaK=?Y089dM)
B5J^@4ISYGDC#I+2QB(d8R7?MXPX;@bf<4CEH=:3-HXX<3E01c?]W/]fDJB\e+<G
L<]A4S[C7:5Pg=aHR88A,25,RA2:_1=C:9RW;1//M(3CGH4]\X&cSfRdGP8dK.G?
>@Mc;PNNYTfJ+\MJL&#FL-+YRM\e,]&7BZ[4a>9._MNU0JG6R9Gf[ALGK@19&_91
f<AV[f4EAcK/NH496HDDT:#;\6)CfXeLMRaV..Rf-E^WV6#)=CQC>(dSI\,(Og^=
fb2O[YG[f/f/TYYa&e?OYGG;VZ-4C\S6ZGV_dQYP5OI?X._YI&<)I;dBb?8e0)Yd
YKGRJd;O6G.cY42<[ZA(\P,+M-;gZ6@aKCdUUO+XK7_BOPG8/IcJ)WJ4]D?M4gCf
J@)N0KUD@NE.gY+BL,-TRaa)f=\_dOKd^QOIa.9dP0338XNDK5185L&+PWK8&PH/
MOBMZ(^NaU^c^.FAf.<O(R3?I6Ne<ccDc0bFc7<H+OQXTaEG1dN9G]1G/KZ<O3?U
B\;g2P^P6B6M8D5P9<=BD)+N+#/ZgXSaF@Pc\M0b8@.E_[C,gT=V?]M\&KQ/@X=-
6aS=HEOHS;-#-VUE:_MKa89M3/Jg3aQ#FFUP&E6BVP2#5KANVJ\<b+.V&/VAM5VT
SN\,#C9?KXV6ASR8)aIf;@&f0<A=)6QQ0LS4fZ=eNf\-f1Rea(Y3-P.0cfgHCA,b
]1X4^E5NQKQFCE6HW--f7V382M</-;&G40eY&U)#5CU@W^T&dIBg)AVN/Q:DcZf(
[)cWR.DA&CEeEZ:LCd1+1\SZ#ED7RK[34R:^(5eCQfSF213JG)/bIHdI8&e@VcD7
94fa0Oe.+D5,P@GVb9-J1KR@:C6OY.YHXc?(,E8/4e2C^de/T\GC,-WUFDV>4ULY
LbUbeIOCKOKYd2B4P)[+&(3^0L\.K=@+H;4[#g\2N6d(S,)d7^)O_J)eacQBVXE,
-&6\G^0M4B#69D_KN^<:?18T;@IK4V];Ld/fH@R:G)eT420GfNfABW/KH@YP<P]A
Oa60U>6<CW+3O\_R8b--aTEA(QFY#f&M0NZ=S:M^gV,cJ1fb(L#?9#e<O&Mg?PW6
62EBC3519OPD_RP_Xc-[;X:Q.YeQ)V>G\a]]B03-J89RD12OM@A,U;aF7_4.]g[B
V47836>;NYC8NN0a;LHgVAI(/.T>315PP85D\N6;=,G-Y<1V,HD?^D1TZ5/c.1G=
6?VB7^;?O:<E>f3g6++I/7_Q<H8<ZP&WZS6N;J9HSc885S1QZ6;K^]?R5U@>3^M#
5Ed;fCAS;\7=a3G=R^Z_L38eZ8f/gPbA6bG?I&.VERaPQf/K7QSW83e9>KA--1UF
R?.#70g&8DK]B8NK\Y297OU(4(EA0(^NgQ704HeXc#YYB_@R:7bd3K\6-ZGTV<@4
D1?)&=/3,6.U.G>/#O^P(7N6041f7.L]>Q:0M@cgJ69Qd\MS(WB9J@_P/@#??AZ-
7-[OX_OI9dWHP)[,_-5R)5cFE(ZJLI<feK#Daf:O.OWUg5^&c[WKG[E_FW9K\Ke-
DFX(2H7V?[K2S&&Z5a=)R7V7S3M8N.gTdS(M@2\/g+:4cMJAbDggcPNS48b_g/ce
;]G.H^H9gPX1Q)@^EUfV&/#WJ=#1b3CY2T.V4M3eT@D2e1JF2V8O5dZ@#B_BR#C3
K^c518_RIXO);IL7]a<41Y98IVFeF8]NWOB200AHXOM7JTe0dLcRL?T#U.BH5ION
=b59CIMS&Db9Y#BX4V/YV;]TV.eA>0X-]CGPQegM^16\&6ZBXe3_O2<-C90D)VZ8
PW\SYb1J=d7OfR0,&d-.,9]\[c</TB-VMS)[dHg-+U_2@^_E2d,8RD2Z9U-0:eKC
DKX:K>&Ba4+TO+-XGB4dGSf\.c1TP;0Gb]_XHbQT#((a-Oc(cMFOF>-d1VSAaOcJ
:<ZD)1K#_HMYUV5><gR461(?_9,Y7=2S0c(BVC&&Sfff^1QHQ,YLd;V+TU;eM^FN
5&dY./IW6\&K<@d.[/HFP:<VK-,?2W1TBFP@LIS7Db</1g_]W7>B3[CB6WE^K+N@
MFdDd>+eB,DdI>-b<7ORMU/ZdC6g[,L+?VBD\W>.40.fGf+YT/A#SbLAPXQ/Scd9
M#b.@FFC_cd\Ja/J.?W<68O.N0fN-+-WH#H::M^g)5OYZL#I&-MdcWRQgV+a,fRF
UUF_Af-?Lg610L\4SGfS^-=(]?+9O_LQ>A/\;+ELR&@<HaVJ>@^0Nc9CZZ=8S+?<
,O6e5;K@#QHB8Zf&_6[L,J+JY??Q(>7?M]>7RKXBHV/0^0VP\9HLUa-.<e-a&TLL
<-L>#AEMdJeNHH2F5&:P=NHOC-MOTfD&#6W8UY+]&&b=[_EC-&D1;F0LV4]&F(#?
6V_N?FP73Db;M9UFCKK&#SSU4,^]F7d,e:NcNNA3G>a48d_A0F\4abHX-9\K6X(2
6\?#GIV>W&f0?\IJ@H-0\@@_Uf5\FV#5/[0Y(FKJ-d?59^.ccGVe,I@MF/b,X1[e
H9FC:BF7VCf(c[M0G/5bH<4\D/:Q)4YZ.?,9F^/4T9.Dda9@8UDe@Rg80f>\,O9EU$
`endprotected

  
`endif //  `ifndef GUARD_SVT_UART_AGENT_CONFIGURATION_SV
    
