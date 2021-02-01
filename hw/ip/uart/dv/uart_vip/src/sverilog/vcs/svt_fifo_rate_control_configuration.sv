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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_defines)
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_fifo_rate_control_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_EMPTY_ON_START = `SVT_FIFO_EMPTY_ON_START,
    FIFO_FULL_ON_START = `SVT_FIFO_FULL_ON_START 
  } fifo_start_up_level_enum;

  typedef enum bit {
    WRITE_TYPE_FIFO = `SVT_FIFO_WRITE,
    READ_TYPE_FIFO = `SVT_FIFO_READ
  } fifo_type_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The sequence number of the group in the traffic profile corresponding to this configuration
   */
  int group_seq_number;

  /**
   * The name of the group in the traffic profile corresponding to this configuration
   */
  string group_name;

  /**
   * The full name of the sequencer to which this configuration applies 
   */
  string seqr_full_name;

  /**
   * Indicates if this is a FIFO for read type transactions or a FIFO
   * for WRITE type transactions
   */
  rand fifo_type_enum fifo_type = WRITE_TYPE_FIFO;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The rate in bytes/cycle of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   */
  rand int rate = `SVT_FIFO_MAX_RATE;

  /** 
   * The full level in bytes of the READ FIFO into which data from READ transactions
   * is dumped or the WRITE FIFO from which data for WRITE transactions is taken.
   */
  rand int full_level = `SVT_FIFO_MAX_FULL_LEVEL;

  /**
   * Indicates if the start up level of the FIFO is empty or full
   */
  rand fifo_start_up_level_enum start_up_level = FIFO_EMPTY_ON_START;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint valid_ranges {
    rate > 0; 
    full_level > 0;
  }

  constraint reasonable_rate { 
    rate <= `SVT_FIFO_MAX_RATE;  
  }

  constraint reasonable_full_level { 
    full_level <= `SVT_FIFO_MAX_FULL_LEVEL;
  }
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control_configuration)
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
  extern function new(string name = "svt_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control_configuration)
  `svt_data_member_end(svt_fifo_rate_control_configuration)
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
  extern virtual function int reasonable_constraint_mode (bit on_off);

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

  // ---------------------------------------------------------------------------
endclass:svt_fifo_rate_control_configuration


`protected
4Gb-C@2\f)9,-HN?5d05T4YA9(b^5d37_R&?PJ;=1b5^^YI4gdBZ4)?a2O;)Y[HZ
F7\A+L\aC=ffc60-MfMbe>N26O=_c_</R2f#DO463aL(PWWY)0T#9PbMgY>4eDE=
T9<)_W=f^,&?/XOEPRYVO>V#-C][)33?W80fJ]-.=fC/=H=[92bcQRI/[P]20TdU
g=Q.b+.Kg[UcXYf_J=9]H<77H3\41g.&:T6,=92L&V/Y)MH-B(&96FYS/f_NCLMI
TZ[^_39DGF[=_GU)Tf8,1@6PbQAZCBX/#^a+\Ng[/gXY/HV,G.BafbM.8/,CGQ/-
E.>M]#,d^7>D/R^S-aC^RT24aH@OdT:IfQ8_0HOD:A/FHYAL+R/_(FFU@NTPSZZa
a36@1fKN)<;:KBegHgT/=DX/aVS0eXHYe7ST#,P>9XF]L/;VVfZDN^P^c>/P.OG]
_C:11X7JgEZf7)D\ZDQ?8CJI<dd6:=\DfU^7KSFG>[:GIc--VU7&K6fdM0NP?C)8
;N4^afMg:dM8ce3+RC1+/\P[8K\Z#_/5S8SM<(34V@4=,EU:[V=TVd;HfJ9+DCRY
]e\9)?T/P[#2KQ92(XA.,\80e;@6aGf;2(-_E#aRA7XfZI?=[9_g>ZMa7aF[&IXE
O/Y#R8#^VZ<R]9e7XfXG,R806$
`endprotected


//svt_vcs_lic_vip_protect
`protected
JDAK->GDTP7aQON4UdGJIeC?FNN73a^N]XEa<Z9AEK/]<;D?WQ,g6(=cP29CfS5]
2Hb._4?CL<X/IKT=J^PJ6IVd27:.-bVZ/-Egf?6-#P6MD(J@@Ib)-FV/CB(,0^3@
&083B@NS.Yc<LPd8XU+58?gDG7ZT],)VeGI,8RU7BL[7Pf_N]E2]2I)4DC2T0)I^
8;0:[\J6[gfb&2FHN43c(c1e0eVSV[>3[3Tdg1T,14A(AN<JeDO/I4ZZS(O_-6T/
fLFG5+d9P-DH\Eb8N@\&Wedd-<-]L0_Q1X@/WL#@Kgc2O(FTZg047.<b>LD0_]QM
bg0]MMb,4GS.DI6NL,Q3)VW#T@Q3?a,XU9VO/[U9\)6(S]MN\@eFR7^>DdPeK#JV
:]f6T(F,gfGFF;_4Fa4bE-8:R?4E.A#[X3PQ3WG^5CAHZBM?(\Y35PGZI_/F_GH=
<G3We\3aRC;<)gNL/+QU>D^3NEONVI9\TfdXG<abWU8MB^-b.B[#;fLPJ2;K4aQ5
QgOb1O5N)I.I;[X+QA^7_+BNe[a>ZA1Me],_QO.E+UD3=Z.TAd97O.Q5[,+H\U=Y
_J1:.d;KUWdQI/I,9B,G8PN:fO=]L+3;F97[4I@H>.:WLE]fVZd,QcT0aJF-[aaC
R.(QKHZN@FD\R7E+]c5_3<XMaHXBbM58U6);K=DU>+gR;Lfd\@@Ze/b,39-8Y-R=
6Cg\B4\,]2HI9L^MGPO3:&NAdJCG/3//8gBH)&DK6QPg;;LbT?C5L<M>#JYTEMOZ
_#c9gaMdNd)_f4eG1T_3DYIV^A.DC,#6U\CUV3B6+>3eW^;b1J(XTPGe[I],=gO0
G&a4+52QI<&,A=.LSG(RCHF/PAUeXRX1LW9-1NP#;;O^S(#7O+JOeAN]?TSKX\Wg
GJ_N#M8OB8M?Y)K\@/P^P;.[GGP]#<9?aSg-]7g2I9@AC3K>HJ/VR=FYTEbAc7N^
^P2GWb^?#.+fI,)eTO91/+<POPE;Q9,ZKF_\&0dH0:3-FFC1]-=.,IT&RMG.2J8W
HcLZ_JMc,f&b-;Zag_,UVN+?_B0/I84O)QN_[Y@B6SZH]&+F+O+S.c9]5P-,\eEE
2;fT8,cR2Ja=\G:]#[G,IRWC.aeA)O[^5DOI#L)TIUS4TA&]>L,2f&aT9e6A\M4c
/T4dYP1L;E-PDI(f42a^NS?Nd\aSKRgTMe;_0(91d2c=P:#_,TX,;2(X^(a^1fA&
AW(<7fOT^>PO.&#=4YaWNb8W2]PUP?T>JKHZL=N(<54MaMW26=b3O<&,M+<;(5gP
C_4VY?\cJ;>H_RS@fZ)O;\)GP+0bA5?U,HWQAN(&7FPKYD1H6(/8gS+R(#)_d4=-
NIFR)Y[+PZb\TP5ec#L0Zf898YWF\NU,DX&,[EUGL<f#a>4TV#B&VPX]#P+BJJbF
=6^X#_-87KcMV4ZYM8W2)<\F]]]0-;fgH)beAYc7)O/2BI:_D22Z_0f,I[2/Q+I#
XAGC#OV_=YEHUQZ3>N251@?1U<.N/E.T<c771WX<aGY43\bJ#0Q.K#W#U^N+Wea<
fDXgc3I5PgK_aJ#R<PG84KQ-_V[cBK/<fXX)=TRgMXX\/_-S+CN-I2]eV:b3,(3M
(3;=,8P[-/(\G\a#]8MEg),.9?&2C[L61IFTO45?>YN\4X>V8\0NZ5d&W9cW_Y[g
FYIW:fY_4E.A]@^1[1]G_W7Y8MITgIV1E]c0XgYFT3e\2SZ^gCYYE0C?,>@ER[-4
8EH&X&(]L]H4b1c>TS)Qa/U)?RbF&GC?UM[d+T\1eFV>Y4\-IdKPNRQ<ccBJ?/,I
N?2M[F(,aFWT9.S+-:78dLD5^X<e.0+9;-V1aaV<;Z@G_8_BC^V9aBYZdR.RD)<C
b__G_GdT,H)E)6//4cBSPdc2^;O,YX#H:R\WJ?5>a)S-H#/D0<.?U<X2I5E_M8L6
65?M,ZW1XGAg1g7e2^f+B.OV2;;&CA^\UZNUTH(5R^R<)BQ(FbT=,?FGU0LU+616
JP>)FPc+L=[W,c^AQS\H2F[R)C,?^M(dCe<H,EL<P8Wc0P2\/4#:93(JDI8^(4+:
DXGEQ6509+B,6AeBE0^,\^3EUOKE4N;/#=6J7DY-F5=a\?FV&Q.[bBP.0MC(P,=R
Q,A\O0fKDE9+1-e^Ea^^AP0T3CK-ZV]#?;/cS1c]2S3DNI4VGce@^TH2B\Y703g9
ZAE@1&M+0@Z+Ua_3\>SZKQ[(YPG>ZZDKN>2QV?<Y72J&g(b\A26P76.\AUUX=MJ=
;_D[P>XSGJc?17K2E@J<DK[FLIf9O+8-K];MS;4J/OR2a#Q)H/T<D[N-YP8L@SIG
+9\=b+LdbASRQ7fFB0Bc;;N]d8^L1<E-T3JORXNEcf/:fcET>V/F@^1c\2=,:NY5
eGBY+V)W.cT4IU92K[@+b[W]YSADAUd#L&a7K[)7(9-.P@YE/HT9?->_,aK3>IEF
Jd;9]3Uf.?:3II0YBf4b@40fNG-2,WZMA.;],40Ra]FQ0KRHc0)KWK.S7YTW/[LH
WBa0e4^(R0+aO&e_B0WUN\XQ-_,ZZQ-\#QQ>Sb6Cf)JB)KN&&c>7?fDe2(R+QA92
WX)]]Da5E_L\->678.>G5/_X-?>H[0Y@=ce3H)S#W.C6JY,T(\d5D&DLO5gAL8C5
Ve2_]IOO+>KL^DEECKeWL:gTc:LX&I\NLf@g;KUb18:9[W@A<-)+He2@Z43M[fTc
OVedTFG>GT7RBPRBI(TD^+[JGER9PEc=L(_G6OHP7.Y#fIMW#XWG(F6JAGVXODeG
5Sc#.0VZ=B73.<2&=?KMD1KLFR3>_HVg[&?^<-#B@BN++,F:CMM#^\R]PI<(@a-)
84(S2_eE#d&@M[I6]b:PMSLNa;RXcBHgY2&L_5^8Y9?d[3R2U8/cgFa6.D.2K.0>
I9>>TdU=_MTNe/Pa9,2E]0eH:R+8/NZ;Jc_eN\(\:EB-[LHZ+QBY)f?4JMEB9W>Z
G<&WHT>^K56-EFSCICUTY<IIOP>8IB^)<6V(0VRbb,H=QbYUIGFeIX;Ee;_UV\55
[FR<S#\5HUHBN2gMH+P>\d==DN?J]ILB.70fFQ;LQV8c/UU(@9F3CL]eI7U_OC;M
X#+@);G5GWAY>DI&e,\XX-4PQ&PG\>77@QbaWdRdLW;#\HV40C.]T?+?L1aaQ?FB
30M:28PX&GNKb3?,,MfTZ=M82c[]^gJGg?aWL1X3.R>&-1,L)P76:Pf[YGTS1-Z9
+1?3E@W(D];NL8-4I)\X#A_SN0FQOHNG#2Yc70_Mg@-ad+^<g0406350486e710<
W,cAcXZc+S>?4>d+;6C=JGOZ3[KKBBB-E2MCK+;9L)Ng>2>7\QV1YC#F2;eF4e9\
H?S&V,,4Xb;daVWDAR(Z5^:I..4;WQWP(#BW[AfTJ@()U)&G7H8#b/BW3&:@GSQ.
S=KBHMgV_A&GNN_,PA#0#(Ya/b2Qb##(eS]+O]^K20&G;QKX@XVH^W[FB2YRD+QD
6A>98<Bg=ZT3BWb@C8G;cZAa8^IVZXO?1/\5XBU&Wb-PK#7A-,eIQ+L.,1Q32?;M
^_34L^&&S#^4cU>^=2=GX#GCd4D#-4eREfa(@ga1aDN,\f=[1A:7\^YbP?1L9#Tf
8Y#NZR2XWNV;c9ULL+[d]M>I<=P9MT:(?PA7^.WR29N^>HY@H6J#7W4KKUA^+^L;
GR3L64_3^;=Z9f.Z(d.(85-[]-e_E=11_g[W30\U+5]7Cd[B^:A@4AQGf\JDL8+.
PD[+fUCU0>9;-G_JKPA)LFQI2NF/gZ=QP6eQAH+ZXR:)GNOe6UWIaCe+YC9Z6S^,
.B_-8667_XKH9XWO[g8G/e1BHPd=8N0Y=ZH5aC3:#BB8c-dE&@@CC:ES&GcP:OHO
<L\bg093_\=Q6D]\affgO#Z#K9YcEP@HZ\aOIfgMTA0PIYK92_U9N?P5XIaaH)#C
B#8)/:>/b\47-aaLQE<D(_#F(=ZKNfK99+ffQ+S5Kb>M&CPdGG)g-eFGH.Y4.3@V
2<J):(GUT8WS#J6>-@WM#_\#(].9e9)HF(bA2VB.5@P:IU,WO>3FM;-cZ#VBXLC&
EBB/2F=R>8VR7+\]Ac=)I0FVIa8AU)IY=B/?#8F29H=(C7/)7ZP:NV)016FDO5DL
DgS=@FOS\Z^WZJeWdDN1]2ZgBL8+5OQ,_2T2_a3eGaP<(QcNHdg7N5dPH+fO5448
]:^E&T[WC,9H>[HP+=Ic(V;:+LPc.C8E7_YAO\UC4C\c+K+49\PV+8ZA,UJ9IZ2Z
PTc/PDUJ@c<XBS=C\H&EVA#Bg8R@3b==UbJ,TW?4ZGF?<@ggdYe9<]+C2<I;I#1+
>[DSU8OM<O#U0MaME<?CN;P>b.PRQ0^cCO-)VD&<3V:JcB(?#WDXJ+V=JcfLa<B,
fQ0Mf=B9[7<BN=._cG9=\#+K+R;O_=]V]E2=Pe3IP-SaH>e5I&MOf/[QGUQMD?6;
\].YHK2A:QN-YOg^4XVb;-.e<[H]7#8I^S49+dE(1OZMf3g6f.gbEYC4K1>cD<e^
;ZW@O#Oc#d,3C:fR1SBefV-^OcZP_9LXHW4eG62XM1B?D(>4K^&[.W.W]EFU,a>>
22D5/V#dBJ<LQYbV?-;EA#/>RZX.SRe6J94>[^D0>21+H/2+L.(AS#B-XJ9/GGVP
4+K<(,N2CdT=-:,,c3AaIDC[&=J/P/C.7,gOd.)@]eN#?V&&7?J4<dYdUN,,c<V3
#E<Z8>6_M[@e7YWg4f&2acK(I_^/:FOOcDQ--ZCB1f2<-_S8IQ^eK=5L9W]/T_gU
HS<UBHM[HKRSKM/>JcZ?_Y1EMe1aB]<(+5QL?YJP33dZU[W[ONO]c@eSJAJZF)6U
2DaS0)dVKd#[#)G3A7,QBUP4cZXAPVdK;:cB(<X+I1N:0Q=&Y]0:WgB9W?WSRcAL
(ICM8]3Q3b&TDEGZEbFD4TLY>6MT/UT9:HY3I>MfM6>I>07YNT;cVF]+L.8FWE0Z
LJ,6BV_7&]eg1:1Ad>aMDR=05.NF^+CC^D[/D#?G47-\Y19LfTAAS]d<:Fa2@FQ=
VeP]AKA)eML/L1;WAf,Q-N5+&G\I2OTU_M^&8N-VV1;HB^:^W;N]3#JF(G<d^F58
2JESHe963V\Q.Gb9ML/@4A:@Za;/,e8FG?>S4O+f^cS^3Cfa,=-GPaUYf9(dMf?4
(a0A54-VaMU&CcTFXC->e[ILA]U)\JT&/0(+1@Fc+-AdgQLN.GfE0/-UG?3HQNL1
9<KY/FGO=c^d3Fc(d>2824[D/L6T)2NGE-(aKGd>E[<:<d#876_5,/[A+R\WU/d_
.(cQ.LcTe6O3<EZ?^YIaZGGOM9^XEdV<2F9ARF[4fD.3F8()8;??/7:=1#)N1E[Y
2Mc.g+CbXQE-Ee\2ZEQbV.:MDUUQ[(SG#2WYTSb01DEG#L_GO5^[P3a?aMYST,>8
2:LTLKQb,YB.aR)=agbP>;0Jb8Dg>W78U7(@6;ZY5SGGc\@1=QI_W^)GR#(c:IRc
GB1c<7313NNO/TA1BD]JWHOTMa44PQIZ-;9:d_;F+Z=OY;^:J:,H6>153ZcM5,dE
XD)\0[XL3PYXc#6@=>1R\2cHC4G@N=\AcJeOGO@&6b=bFKG^b-WPYQQ>J9D\V5d6
>dTXT1>/feN-SUZb8PRWgZ#\A(?UDD+KXS;2L28)X;9ES=5WJ;C.Rc\JQbdIE>JK
/0PY7aGVZ;26#\JU=c0aY^ee[[?T1=L7A.KeeS3RZGZ.g^X_4\.a-E\<3J8]N(+)
3S([HE)^&Zg@PEJGRFIV(KUNAMgQABG6:\_6(UcH\Q4_(c(WF,K_6PG?IG9P[YB[
?4E9\]]]P^Y9T>+VWVRTSe3H4OD-T28;eF_dbaD2=36?b6,N5C#XFB>cRRSAI4ZJ
UPdcFS7=+;-b@@_Wf7[>SUQ]4.)+R16(?/Y18gbXgO2Xe]\R&D46]Q4J2_eCbaYQ
XEVR&40#T^C_H/UBEZ#2IR=fH=PAaefLD#>>G=9:LVAFVRWfQN9K:\9-U<71]>X+
P,5Nag,8FS#)=PO@4J/GX-R8@gY+>3_4Q\R/[ISPSb)c,=gV^cO]M17Q_g_68<H[
>]b&c;5W[3F)OA0\>@U/89NG,b^Q,Q0):O)D:CSJ\8A;RaY4P4ZQY7>g0/L/(<)-
JY3&]YIP>KC5H;:V7>&cCd][e8YR+O8&=#GcK8#LX@B208@27Z<1LLcS;c.7C7^R
-Y[ZCW9>/B0,NQII(:K4g;Be1:@]D0X^JI\3c<6#WIb8\,#)V@\68G/dFe3IJ<^R
_3Da@M^\D@-28==S,Mg:I6&=CcYT[0P]0<22=7fgHF0[WG)>OVbDL2RJY;&@HDPM
G):VVNS.4_d<#cSZ7gSLY9c^#D4D>&+71<T5YKP2DLY]TN@+ZYd7RBUfF^I=J-SR
R8LN2W/bD96PF4-&^PQC=?A>cZ]2@G<MH_CgG._H9[0b7T]Y)MRE>5/--+_\KT86
d4TfNEJc)A3YQW^L7^76ge:/)_0SCUN5OJD#ZR:f(0F55\@KQKWe6\R^1&+-U&X.
g5IK:@Me.O#cT.@C)GS[/O(L@ZXbBc15f,eU;Heg5E))[b83gEFa=@C;D?>2GI.F
g=6fK=D?/eCd@CNB?[EL#<cC\2-;ZY\,91Ff+>;A]3d0]dY>_?RF8P:TL\9BA?M\
YSK0>Te6c;_H[;AC?[gW_NY(X2JYI+]a[8)#.6Y/^TMaecIF2Z69A0K;^8MB8\V0
d_:VLP(B8\XUc[Y,Y?.S2)b)#3:78L<J5E0UR,6]EPbJRQX_<VC\5(+_8AQ&<ZDX
0TE2,^^2a8?L_P+/O9\;GNf]QU[1A)RS9ad],@4/ML:BE,(NNFg6)=98aO[3R]\Y
VQUOR@W0]-;&Q^^dM;1bIZJ=D&Qg>[;30FcQa67E^A2>?QD?6UB>OaE@SQ.gD@H9
fDYI4MRDN:PU\MJ8Z(8B-L3A[-P/V6J39d=Z-/db13Cf9S5YLF4cbV6.\FSAV(9N
M9AN[(>6LDBUO6Q0YGTc?;/[+MFKGOS@a/d)3J).Q6T^IIM/;1A=R<A)T,(4GHHZ
g2;9E9TfR<6RP5:EPO+L7g42EdB#WL:]/BfLbH3.C[GHZdM>[<J3J/,F._:B^BNG
J2BaTFY:&=6BDg2-=DB<TY+XC0B/(F=Y#[K.gNT@=8<O6Y6.[^/A#TTBNI:Z5cA:
RZ/6LScBEWCaN^PWH4V\M;M1:65[S95#D,DC^@+1=@D9aYKIFRMRM-_KAS[(I2-_
,IXV[gR0&FMZd/P8E,XUKfdP1dV&ZYZ0ROR-:a5SfM,^,]5B68?LG8=HFP@H([B3
B8O>^;P495>-4d]X6REUPLR.d3E_da+LXXXD5aLY]B13RGX&0/10W]O^YS<;KXCM
@1Q/I,Z9?(3<8[7cXK=bR@P1?=5_N1#F40@#g7cR)=)-P6GS\.\6DP]ebgWL\;\.
HP_bL?<E1RYX5^+:0U=>2QG6;.VHCYf(UF-CH(=QfbP[/f2?EI;#3D#]5SB]P^J\
:ROL.G<0?Yad)f50I/]Z_L[BG6Oa)g^C4G&WN^F;.0H[+a6,-Q;J+JD59f]bf,QO
TVb=P&/F>2F2M\+6\.;b^BX=YKdIC_E1F7c1FRb>Z:6_cb.f-P7Z=gGHWDS=1(B6
Y:93.f&cQ5C<fP(_:P>1E\.RJ=[RKWgDNOMUL6>+2\W_S(UYN:+C(ZARKITC#3A\
__13g?2e56@C-\9YJO5S&Z/f.>+e8V&P[2[cHC&#4C)e2a-;DT/A@1@3<e&<7.)#
JW\;<S#/_ZNc.D>>?]@dJ8CZBGW;Rg>Ie/VE&/Y2@fD7&ZF^TUb6&SFN_^WgJN,F
UPXaPBe67GS(4-b,Y[Z^K8GP]L^)8U/>=P.U;4:#M[/Md4=F1.+@?L:#bPYJV&:S
d2dX041D@-75]?beU3Z#6=(2b16Q8+C)?VMZT&SA^X6:e,_QV=60TZcPQFH2+aHG
F-6V6780&4)7^065-YJ0dHTP&;X,\#]/NR+);A5FH5#R(:8G&=SG79Ke[?<\_=Z8
Yb(SA-(D5,RRO,ES8/3]PC#;A]DT2L&,a4fR\X<7bFb_3.XTF,.NB<UL,PCME8RH
F/O6+4+ZQ>:1WXAD8:[RY>0a1;/_g^Y6:R/1P4f7/aL;U,T);;4LS:21)19d[cYK
F^2?>#.(B-f0(K7AX]DDTJaa\YJGBVCV=G@=.8KPGM_19C:Q7:/=Oe=]S<K.2V)d
72>#S-&6/^HGV1#).[F)W/27;J&Aa6AO\>CA##DdfC6cb?b:g0#:;49U(eZ]DL>b
-(_=FKF3c_^?KUbGd+,7);^2=+/3)^>Xb<:Id2b4H.FV[1ALMM(LH^B/M))NQB2(
1EN+Y4M.@2@\#aR>872?9g7D2<5SbBZb3<bVUCO.[/@6>eQ4-W)f>+)7<(,G\]Z#
ZX?bbQXK0_\2/YT:OJ93LB8fZ)K94b78&J8RGQ(GdKOD8/8)N-@0:D,K6X\DG505
Q5E,+Z4SUZ3\PPQ>THZQ1RPI260c^\8--PcLK@];IWV2N<1OYL/DU/&)8[KcOLEa
\U9]M><?Z.Q?_1?31,g&>(e4QYL&O3FP=?&K)P?e1B;4e8;_NY.<Wc9X]@8,A4Y:
F,N4FNOTV<(,=2LZ44(KHA9aI5?F1OJ(Rg/OYe]ZO((I[cXN/A^_8LY<A@48&Z[E
&O;W8BN)ZK.=SeEL)g;4,BK+>;FMF1#IMYF-FVTN+#IPKYCgXC9LbeF98R\RG);2
(XL(ad0:DI<C1IE?,1QcCT7M^3M7bFZQY@a_a?HFZLJRbQ1)[.[8VBBVSSBc.F0b
\^)Gd[V=J1bK9O\f1.1c,1ZD/c(R.fT@GAH;;Wf&(5GRXeTAc0Q8J,bLcM/<@AP]
S.9I#VPd#4_]1(X?W4759+8C_5SLC(5;BY_AO)HY[Ce,N-71:De72HDRQN?92/.W
+eD,C_e0&W1MK];I4X1PXK-L9;cB91g=LH(FD&aHa^IG7Q,:@.Te2e<ZU_BA=0&8
#IZ.12E&g?5RD86Q);Q@KA\[S1DVF52G]ZU39D+W&&^WaQ:_IgH[F&/EO4\;GEgN
6S7D;:UN4>L6C.NP4MWCaVgI1;5c6Xb-K6QcM]JG)VS:]DL:X-Z9<(+&T4Dd)2CS
H[(&B81&P_gYGUT;Q+?E\&JN4e6FYVERIW<eT;[0#0[+<D&I]b:)^3@@d[UHPTe=
Z,7bgO[W9Rg_g)6VgBdO)L=.fA;8S>Ie88:J?-YN=S3=GM3Z0MD.Z7;WYL8B>]Zc
C&>-PCVI9XD\S^3=UCRNL57BeaWb:@_[@@/BDKCLHYRVAR7]T[2c+>LNN>N.2#+V
,N\.M_#@K9b]TfQ<O@SNgWLX]+59[c)\IJK?91]2WC,(TfY_KaV0g.BOV@3V?L_C
;aI@)\6ZPX+T)9Y1-1b;)EQS_?Le<9O/@CF#BYEOX;[(85,d7#93I94?OId3EJG]
V&]^Ia#c6K_Z6&VK&9P#aH]71;6:#@@G,W9G+ZKKWP[4@\/g.PM>:?aN#_JQHEGO
I#]<UHFU/a>UIW6L((F9CJ-)GcX.7??E<R8_^J3A(,gWg[M(:G+6;P,)^UC&A8SO
@Ac,e2O0@FMP32Z/=B]CGNgK\TQIYP040e0V5\P[baF#L,LW_&+4,(NI@6).;=IO
5GMF5BZB^K(RXK&C_dNB<cfVfG_K?c<6Gf.)aBIU3.>MWMOb1bJ]PSLF-01IUO3\
0:=>V4NQZ3a&QIR)=5YKR;MJDM#L93P]@U>ZOf&c.B8S5]9VU]N#HgW)YTMfJT[R
ML3I@e95J,A0@S9S45<E2=0ERHgCCI:I5//Fe2;EKXb_@(+BIF@GW/L5SH;.0E(g
QCY.#2BYKD@F&;8@Dc)D=?>\PFM0CT66+H6F;Z/G8QQCM&;<fcOOR:e9.77;V>?,
>CfI=8S0(+K8)7&YMM6)7<>EV77LY4R[I44H]e4+2RG8U/.\@M2K2H>BIFNCH9@4
MGZW9WK8>Q.8YB5e[@A;K@5HSc-/=XBLQW\MF]g=3,]+[P.B,JNAN]UVBaZO@5d7
M3?fY82T4D7\aFIOGP9=.TFASFL))W]0L0-[77f.:;OKGXR6MZW?VF2=Qe2)/)V]
<#1HO2G_VX,9(4K.c8)GCQ]T^F80H>]:6OHd0c.NdN5)<BZ^ZLCS>CDMOY^fCbU:
PR:]JEW1#QIDT]2.e6TJ8VC=++4)2YA5b;A]+:W&D<;T\_ebT;6\;1#e[+,I3gGN
Q&aQ^_.T-cXBc/K#93_[AFJ3C43]B:[RL2L_.+W1)U02]fDZERg60]:2)MM)>7;#
14.<H6^L?-GU42GPMWL5RFSWOSA+.NZI;(3<P4+PVHCAgXd_HS)R\P,,UFS0[E&:
D.-IbYY:>SLE-BZGO0LB:65d-7b&64eb[=NPd.Id?18=W76DN7\CZ6XQ[aND,742
c@0g7DM-60=I/,HL4BLb:1;G&,44a_9B250):J1=M5Z.B16X\@2H&Y?b;49^/d+B
Xc9DW?7eQ5Q:@#Qfd3(WUV7ARIa8dDJ+NQ0Cf.FSQW;fe=BeF_LeQALa;Y6@]f(>
&7^VX->Z4WXIZBKQYbfJc2E_E+JN(+HUV5[&8/eJd/_WJ\D5@a8RN3fcW(L;U>)&
[G.Z&b]K=7#EI<:#@KB5>c>8.-J.JN&H7\A,#JgJR:SA&R76ZB\PQPT5S?D=EL;8
Y3DM3b2_2d@6cSG=\<UX<[LgcG;c0=FefSW\8d[=fHFQR6e_-U<XWEW:;Z_<WMcE
MV@=5D=]PE?L^55b&daeN[2SL]Y/@6()g.YC]5D?aF:O;0e-#/VH<[/O9Sed^LH/
:aCId&;[G5>dS@J,/\QP-L0<&TLBNYX6_Ud<K=.e_GAK#[1<9ME-EcSA\c#bVR#Y
&LGT,f84/Tf@\Zf1d1A;JeC,\M\H3?68&+;3QF64BBEL91BZ[@(R2#c#)I9W+=/4
Sa(2:+a5AWJ#X)[a9(HA87e0;TOC&^=H\GGXM:B]LC5&48AWWKZP^3]\fAS0/7bW
XE[N3Z&2H/92M,^=S#P/A)7OKV:&WE70V,H,9:4b\0D7IBcbXZDNLP,.>T4K<+/2
c2a>bZ,@[.]D2H3]C@7af-.H)Q\b7\P#ZR&\dD@A^#?VVM.XgN=W@PB;6:W<E4ZK
=dUB0[;fOF#GQG69eXMV]>,K&^Adg\T0RdUJ.T-J=d9FdSgN-d>JS@1d;Z_JY@;g
:/0=g1^PHaE+CPUJAU>E]SOFeQ5cc/e<VeBLReRUeSS8VfK#+-@Q)\1,@B(^ABX.
fCX\T+,8c]9IZXfL?^@4=4a\a:dO_QZ^M@((R6dN;81VFcgC4XTSUeUXK/G7G.K#
gY1SJf:/c/D5>WCN.cSa>]Q/MMY7FI6[dTf.9]3VG1FQ.9Ie)PDT\#:Jg&)0Zb<P
FF#3/5:VPW8(f?f6^Rc_\QGTOJKA:965gE@+8M>/<f8/\E6>.a@IO66KS55cN?gK
.W/-7-G.J=:2ZP_]^.b?g+ES><>+3OIB@O+:MJCfW2XB&W@X<Q9dAF7E?G<NL([8
@FAVF-JW\RgVaRJKBKK=aW;.&B;4N4c@Ca(YJXS<C&8S0Z3N,^_(3/\>,OaW&a:X
8:gMY+>O#/6-S@ICI8#T8P]]@)#\TcaVAERRHESZ_FL9Af\Xb@\LHE\N0@JZb7b=
0H;(?58RKfOMIE6HM.XBI#+VD5?2K0_dHMZaR)M&Lg&R<SN03_PV[fYB4/]1JNQH
.^AVb9#(G:I#C(63<G)T@2@KWMXdQ)30^?1SD@\WG56NBQ.).R]_XX[5;KF7X=;#
&cB;#:=C6:gK-O/FT=aJA:&g355?P.NAJf&-?)1LaCL5\OZTWGZOR7e+Ma\-eZWd
Bb9d64SMCO<e@agWN]C];CgI_NfFa[R_?G&,(U<9>CTdFIT?f,5X;eUU2>_.YJDY
2UTW2NN:UX;U47Ub?N)O3?CJ_d?5>_J<b@gS0>F/(P](LO_e>OB@L5)Ka@DW2eP6
2^bX2FScZCRAJb2.T7[Fb43B;R1VD1F4.,\1JZb//E&;<MI.0e>(6VB\edfCXI&\
5UDI?b-U,_G8XdUH>c&DAKdLB[U>,IbQ1#Q.X+2=+^X\81D;Z^.Fe#4CL7+3Va;,
:f#?7;Q^O0WbIZFSECD_L3&f^eX#D9/M:_J6)03;LGA2Q9KbVP,;A\U]C<22I](\
]Ke[e1;OLOX\HSNcG:b&Hc+:cd7/QZB7.R/5W8U34eNe<;X-CLK@(gN)\^(QBd61
W21LZ/&M/X2faF^Fb>a1c98U:TOJ;PD;P\L^4M62addc,:Y.N^M=XR#PUT,5MK?-
D8)#,3Q3fCfP&V(-C(H>9L(CNC1D>>H#&PT7DHd,Z/c-P+Q(BO<D(611V_##;Z&4
9V4422KX-(]]@[9++)WF.XdP;8.^@1>V\HOeZ@]DHJ+>5bE]X26?O-;W??0^NC=\
IK0f:8;BaONZ6EeG)e0#aWY/3/12d=DV1c+IO5Z698D,NB_SeB5aS=8b-W29V:V+
fGWZD]L\MR121/,4\b9eRd1d-\)01W->b0e_P71[;X=\=e#6=855&Z7;T<4YHE^(
5W4ZI;_9aFZ>MKY8A2^:D]=QSQNHPDf11=#9<DLI8>(PZ1<=?C4EVLe\=A+/:33=
/+BWU;FQW&>:dbSN9?d73W)TZ:HVZCO+M:2f[OI+Eg;8)MbTP3SNU;ZDSZS#?Gbe
6Y:XS_,9FB<7e+TIL:OgNTTPZLdBQ[#0SMa8a^3QHV6OXcgK4;@aZ.I[+W][TLW6
FDcK.6TX7,GbIU<O0_ac=8dSbTW\^M@FC&Mb;]C_^RQGNe/L2COF?C#\<CTEEDO\
618HaV?-g6Qb3?#?If5YF.SJ4UF84;>CXSQ8[VO#L)CcJ@cf,G>X)LCaP(NH5YD6
A),8gD>[>-]DdRa^WC]PUWC4S7[[a_B]M[DCf#4S0G1R?_Z8?)_=6WGUV91ZY+7I
6+QPP\E6&3D59a,]6O9O9E@c>;]QOEWE5BBNP[Lg8)_@P2&=(a=7XK4a,RS&3<VV
d(V/b-,OO.@@?M,b,FV/O2@5Y_,7U<((?QS)3JMFB9:F6L]b>:6^6Q[e9;M<bR4?
YM/VTVUSX;U&DZa<VE+3X.ROHUADR[ND.SR;@[?[W3]2XV^^121B6]9b0PZ.4^Wd
19GT2Ee1QIP8Zc8/FF0DVC=d\cC[Ee)&VSP_IVM5^?\d^[2dL>U6Re@f)LMc:6F]
VLfN#\UZ<)&dd7(4>,/^PeTDeR,M/,23#MOMIc7JXfE29UEZ@Qf@,^F&9d4=GP:=
@^TJbc\)5R4B<DHK+?YUCc=^CRCg7T5/af?\KC5K/A\-VU=ZCWE:C]278=W.=-We
S7B;I46,KK5GU?fPa0G5cUHVKSQ>4)_DE#>BD:U\C(Sb_O,1&WXO<SL;IcY-3CKZ
WAJ[&W2E_D[/DYb042e_<Q6aCd>FK04V7WW,)2CdHJH)I6K#5-a3#GfS2ZP6<(4e
\[:Z>D[&?>Ha4,U@,g,8?>Y:KWVB8)5])C)Q:;_cZeMW5fQAC_UHYII=a;HBdcA1
-;>^B5cA&0DBZ&;WOXf5.Q@X(X],WZKI9b:F9FX7TSg7fD;W6]286?)<VK6G)LYF
fOL0,&?KX7N.ae7>PQ;9D-fcKK]\d.7\DM2DM=Xf,C;.6fMYfB0.JJIc4Ka4RD\[
AYS>KCa1=R57,>IZRKI<b-#]65ZB0a/\&+QB084fK(c[#d+KUb9<R&gK_.WS7M6a
V-.:H5AJ_+Z>eK-\&..D>Ud&\;gaCHF+fMWJR@\H\72<Jc/B=LdSc]+BU4O+OeIb
?UW//F#-/f[X]6CeW<\R[9^X24cOF@gAa1KR/.Cg<b1#]beT,H5,Z:P/UDOO3;4/
SS(=5e4e/+_SXgS4NSU3EZ)?b6GXc+_0;:<:4_I7OMSY.5/=_Z2<0FGJ]U-OFH\R
@__G=I.#]YKE1;cL2(=Da).))3B_R0_3/@g4-#EZe;]<TA9;].2HZHgYFNGf1@DJ
a:eYI87A[NS)0d5C&.Ee=]L=XGNLdASXT?f3+6_-G\=Z9RbMVPeL(^H_-/TS[HEB
D_95NWGWQT.\]XeQ_7INAWJ+,(O@G5g+Z(ZJA&4eGP@L5SLdP6fJ;.F#3@AJK)J9
NICL-::5UK,;?d+TS^Xgf=?H54Fc>Y?<fJ;IAQ-V\@(d;:#g8]XP=[4S#GC]C]Rd
bCU]SE5XeP?447Oa0gY7NSOXL^;UX6UPO0Ac?.,OfK(WHaEb\SWAbU,XK11+\^U>
(-;27JT#0.LMd3dD:Ie]>UeRDD[NL&UR#d@9Va4I)L\K1M98/e>HHSPA@ANM/9KF
\3bR)Kb@+,>gX9dN#cSaEO?6.SdV,YbDUXaL?<AfGM?2?/79WD?P]03X6.OJYbfH
MUXa2)BMCQ(.>5L)7NBKZ:OUY+#(/O0gP6Y.8Va4:;R:C#>:@_W=+,Cf>@aY.O(,
]GKRSOQM2c+K#/^g9b)T?X+@6Sc-&eV@14IL&)3edOTgXS#d;I+(=a@B^Z>bQbaT
\Dcgd<UHO-B=d\c5Yf8eR^=]UI\1FEPHB;Y<TfdCBaV<I;e)dN[B@KNC^]b_Bd7<
6\,=NS@@Q\)6Y09GV4\Q8cH4<B/+Q#S21<^PPgCaOU&?0BdG36KfKM7gGNaVFWOD
XM^=:fDM:\a.C-]dL0#B92NPL./T-7PF8>@PA1Q2G-Y.-T5II&^>e^C;PC+XPM^F
QIY]&X-e:N9c9U-cG93@X0NVM7[Xe\9^.EeF9[g4Z<#UA_25gL&X,XSbR-GL,-Q0
\>;N/f)E#X\7Q+YZ3YUBe<>DWg1d8c22N4;fgDO_g[G1O#C8=f&Y3OT[-]P-?KTR
gTEN]#,_BDLHd.)EbgS_8CYR:APNAd:cWc]U32-IA)B@GDegZf18+FgKVLX+;2N>
f/X(f9H9:f<0DPB;TLP\V,\(.0B820Y;eT@=U?<[&BBc:GZ_d(R1XN9aU(B1),g-
.P<2FHTIVFGS-O:5N@f4Zf9EO/[2P\6&UX<W,1BO:>_#<.82))2^<b/R@:<JQ6O9
.GbEKS#98+Q3@BH&(AaR([FE_)VNB:]TFdP)[AMVAC&Ie#WRQ8Mgb^>ND)^^?K)0
RJZ)BQR(@2Ic[dLN9-&3GI0.WY;.C.G+&C^+[NOg_g5YdaNaWOR3.aG-1@]ZW:/9
Z4_-#G;WB:DT&E&I&)MKTJ/?G]RD_LHc>-7^H;#d5@:):UUW@3#ND_Od,0S:8bc^
Qa]9T#A&28&I<+QL1W25,=5HCTDSGW3.Y+D)JWK&EBG9E.NgI)CLGQ9<^^G?fB<S
.4B2c\QdB6+a18&4eDYR?[H^4UFJO,,K>VP#GWYOLP?K\QR((G\QJ288F0Ba84(I
@N#dEg<L4,-E[5CX<1]cfRD94VOSVXKD;(]fBE,[<S76#TdIeIfc;\W]&0E\EKA8
,ZQ]^-7\&3?N\._\2PZ/XYS\^/N6;Tc7-.@9Q:\D^0]1gaH52D[;.I3E7SNAa1g<
@K.]MK^&@U2aFMb.GC^3a#9XX8g7gN66/-7>49]5DG8.)BN;(gTDPb^,eA)/RLD1
YKFa9ONS]Ic_?fU^GE]<f]5];)U<fOXJR]JaQ1))6]HYH:&Y#RJ4ZKX)Q]HV3.5W
2A2IeK;&)D41A?Fg4#24DZXPASNC72JG@fG^KK4TTg9(e/d[YN3Jg2-M/F[ZLRI#
.#[?K5;_]ACDa72O9USXTS-:8TDSba>III=G45T\_LX3&:TAgM7VGN)]JK6CKS:]
4]#=)7.H&[JS([&3JY@8G?VId?T2TX=+1gOC5X-NC5Z,>1f?H+Y,38<DZ9Qa]_NX
)EDM\-c0AGfYZBWAd/L#5B;39bZ<+^Rff1F,465bE9PRAGO17=-160EMAb.-XT9+
<>LfI2-e8=(A,H-M+aQQ3]aYb^b+=Fc,0Oe(c?D^KaBEH]2X,&3<Q?X2EENLf-<3
TG],@WRfbUd+V.(;ZG[VYf>[&6URRf][G4RZ:S0A?9^-#.;5d87?M>NbX9ZaB2WC
>+&96_gW(#UNOBV:#G#BR11H8Sb5FcM0HQPQE?6bA/df:&@PE&^]W/DNZR<Xf#RD
^U=-)F<fV]P\a#IUSTQ4\9gA)N-bE/Z3W#29=bF;YBM,ED9A(Dae1VK[XeTVb7S9
)Y?Ne(?=,afU<Vg;:aV9GQ8M@gcEE?WXRf;P=,(;aK.8Ob=L5M&2/f[NQTODZT(W
F2g\4EJ5:b=;g2J9&JSFMHXe4<;Z+Z3BW>CK:ZR_]([-FW_:2Aa6)1[ed]:KS0P5
#aEKJ[g0:](PG7=^.96VZA1AbQIY?1ZCBGPQ-EV-DF)PJI+g<JLWIPF)4(DSH;7E
YLS_WXPE:B/5/?-50BBLc--99Z/VI=4@HW(NZ#/-3e^<2MC,6[43#B4\a)68C?:F
23d1(@R1Re+Ef4GK10e7;JA+0<KGF\8Qa)-0(@b5WdGB=Y/9IW3^1&fe&JX;Se#H
FGP&.BA(5G_aP5X;;-C9Icc98-F7+OHa_.6GS/)6FQ=X/K&0-@X[CJE]GM63,?dV
6P)c:)_3c;,a]4@a\VgFWP9]:0(I()faI8T+^dMJ+)>/S\:SO5WV>&K4[Ce?-0L;
5;:[XU0C9)R&-=AYc?&I)E-&aPVY,7E+Z00<_6YF\Ef6XI;46:M0#YXVNW.5]aCK
;b9L>;0YP/C/c_?I84L8gH?J;)Q\D+#_XDGd?4NBC(G<1)JD5/_D_<QR#SA-)QdB
__EY@ABQKI]FNI<cW^\bGEAE>V#M=5_/T\0>bb@T-UHYOU84+9<\bE4[L5,0>a8H
g?<H98?[,4&gUB;G_,MA((?aEQPGRF.#0?(d[5VO(S3,YMILHaf+:c>CEMYW4eTg
05@ZVAWOd64I,;7XT6KXcT\Ke7D[Y857X3^MB]\:)#.,BXQZ=Wa0P.bX(PPKFf65
W^_J;B/I:):RGMW9,_SX#N&Qc)L?eGH14Sg[LPX8)JL^\/CUP#A@eET#BS>,UY/g
>)(/2<XK3G=+c7&F;g59J))a#EE6=XM@BfG-#MY35+?Y0e.R?UG;H6@J.IK0YYCZ
K>]IcLATJ9ODbGJKZ&^I9H>Lc+dHA;,a2=-,3;<Q+JAY>R#2THb;,CFI.UcOd(T]
4ZFbJS[>7f=89e(+:56.4GaDgLJU;-NFXe3(UC@aMd#6IIUHC^a&:a4N__LNW9gd
8Ob50Pa1SUMKBSX\>#U7g]a^MA]RK[,^YLX0</HaJd]W/<HYPZfW?Ug5^1-M43HH
LDa@8/\;-SU<B<UIa0)C1UN/JJ0JKY8Y3,:)Bf4(.UbO\>ZS7-<Qd]X-)\L&=9K4
M^1CR:\=\M?9X3eV@:5\4O8^3BXa&RW@T=Q2V(#U:2eW\F^N]MY3H)+;SAQ4cc:-
R1K;cDO\bZcd;;W[</Y79.#4UFaH>_-=UW)B3BO=/gB@23)Q]5CV)^+_b.+220BR
A1\D&<E:UYWR(@:.ZcP;9&NcUb2/#+bCFb?C1D9G2(8<JbN,S9I_<9I<(bJ_d:L=
g:^bEg[FT=QZBM<;S,#_)CVD#+;-KJ_P61&3>T[Af74+\g)7adJ+,VY5:)[R#U-^
Z\\#gNYWIO=-QeFNO8,0+MLXbJ^Jd@Q-;5+ZgfU5f(Jc0,_PTC+^ZS=R^0\E6MFX
_K<c@:/IEU132HT_d796Ob^.L22H85N#;^B9]71\+([.SH^RLM-(F5N@W_CR+Y:L
FP<:8V;N#@G=>KFAf3;)WB&FbTSFRH(VQ#ZOJgIBFBTD:PJ:4bfY0?gH1[cgdQ-3
-c/J6NJ9/>Tc:W^b2P(T-af_XgRU8RX-_WNd/a(\(^V@V[A-f(3]cEKCN?)^JFL1
TLeeZ+c5)HcX4-F>IcAH8K_>B5)A8Vf6;R1IT(#GQf+aY5WYTeT+N<Q3UNL5SC2&
_7ac9#<3S0[[-g#[HeXSJ\&A1VI_:3U6^)L5f;ZJ7S0(N9/65,)AYM6Z.gf5J3HP
(Q3\/X0_=1S-H72H<8JO8g<^;95<6T0<IFV(W)f)D0#2]ID@;L7X<cX1KFR&XRbB
f>70ZK>)aUUW/LbeYH_,^R?@g]dQFU1WW(J\WUX7d\2^H<J3\J0DJaW)22N&Y,54
5N#Pg>)SS?^e[FXf<d.Sd@K[,.bFgP(IK6/M9_R.(35#d)=BGH1-8B/@G<Oc^A/:
+>PQW;WO&HHc5X3W,RQ#4JVc+WN47BGMJJ^?JYST]NYOb5g?XTR]b#3VQFR4Tg?W
.DMZY^DP?)80?,WbM?gCCCM.>V6;PMB9a.A-/J;-cTN;PB#UCZWAYYPN4_ZM.Ac/
c]VN[GM6:<^C:L?D1,ABdN4T:^NK_gV[\U>Sd)[QKAcc/PYcJ7=I__&10;CBCd&#
HQ+JdJZV/-4T-Cf]/f42b>L;]1KdD@>29:_KfP:AQSaZ2[W6Y80fCcNSZ](Q;dP2
N;e.d>dGc3f+P&@91OP1>65_(FF?<;GQU7aY]Ye:[Ca^T5g;#=/<[>XR#I59?Z<-
5G8Se].?cR6.KK^/D3eH.RGC;5ME^4U^Y46\+K]>b8b2M7YS.EXb4\)gJ]:\+-9N
Gd6923\EB^7B&8:UKC3ORE2c6IG>0JE4932d[e#])_@9L3acg][0-66YYLe8e_S\
C^NdFP(I]db;)E&e5+SL<:UOK^dI[VP/)gfBU@A[HA=b0Q=7bVK]Kd@dI8]R)g99
/LA61ZS^GK<[@O4XP2#DKO^^81/Me#D&H7X/QP)S+L]eVTe:JHFXa1Rg]X92R<W>
VWW<WC;&Y(5A<^^.\0.>b:6AgCg9-P-2fXa^,CbVC0SR03YB-e]T5=\Gg,bH?[\]
Gg_B^6>WId57\D3=W]b9L1c^HLcX/EF0)0e8FK9Vb5c@CRYA3KMI>FN=aPY+GaL;
DB;O2W2MbcZ_2NE(N1O;d5O\^2:QX5Z_>B>[K-IIRCZ3YE:]@OFgCL1>ND:T:CG\
+d9?TDV2F8J,b4D+b7A;F0d+SSCBMd=SKN#9@eNFD-^3d&g?Fe@_<\L2Q;^a-:K6
&@D(^_;1ZWCCXSC#;80TQ3dD[3+-3XFOUT=QVRI#-ITZ8OG:,#P\(b2c7F,\B;L&
QF1N1+<8a7K,>.V5aD@Eac)7=6>59+_<>=[K._e^823J\/<<?RK..gcTIY_IM5a9
Q5XTNCO00aBTZ=VM0TY+/8C.CR49(?AQ6>ANNPD[Pg?@BA/15&J,E8IIB10WX.YF
GIa@OaK7/c^XF&b#=N)a@&]HagCceY57ZY]-,:;VLS]c6]3486_LDN,/R0cFCU(2
)\6=#H4MKJPY4d#1N_fD:9PCf?V<?.PWRQ@^&#[DXO50OU4FRea>NBR6N].Z(6<>
X2&bI[JH^YIS@(<T=0<C>0X.g8/@@d2AQ<OG2K?G)&2EUQ6O0@H>+)Pad5PN)]N3
D^7HFN-&;M/ed<5>aL1[AMI+,Z#^I6AXNaZ73a(8OaK6b.[aIg_PA,F,+dX7\/@@
c#N@<cSgd6.dOO)W9(:V?=)JU5)d;2@egR;_N5[FNI=:P@(N2:TZ,TfZCgfU2D\P
?X]Y+H#+P&H.\e399Q]GTf83,SSO,??&-Z1B;\eD9J8]&R)UPTB8PYSE#AQc+L,S
-LZI5=dg/<d.7M+JbJHfb>?&08I66:g3;X7(CCL,HUU7Y.H#2XWcMO#[O+QPX5RR
AO)=+N(GS84:U@:9<HTc;Z=RP,+T,b/+V9T)];\edOT58U2e.QZdVaa9M?HYB2)+
5,_X2PU1d.#A5YV#5/2GfEa7A],,/PD0XVPPWVZGVK-V8:;U69e1C9=UKJ<WIUQ,
]e+KO>VX<N65PG[gd-?NXFZT.-Z49W[=^IdD&-6X&2E_WZMHPB^LVY3eO.\CR(T,
T^c/YcdO-Hc)D@:2GPXb#U&&c-WK)6cG0O<Y&c:(d<H1,JBISA4MRC?^+XOG:S@8
;Y(HA?5A<8UJ4(3-:.Z9I]6g<#T&I1HL[?5_L\59J<+F<TQ?O?7PJ@2K5MO>X:#^
9CZ9FeU::7a;+S,a9O#ZC2fFa^WgI.7B(4_3d2gPF:-HV,U0#gQ-FJKY5K3/5F9<
L\<9Me;NU-4bM?X25-W\_6F9>M+.^ZGA79<MI;GL=RGb<cONBF>1cF@9XGCZf.g;
LbL;]PQO?,K6=23+D>P:K7I+b/FL]CB]WRegFR\9.Rc]/8QeH(C#A8-3#J.dRZAD
W(\26FJ95@53K4@7QKPfBA&K=/HG-I=#/0B>g+_]((>1T5QMMK=LY]>Z)5\PNC21
R/&Da+78=,LSJW0Gga>6@2I3K=^2-AFA=eb>\,GXCOE(M2?KJ=B^\Af9=Ge:?eGT
E.0R)9AgE=U6O=S:B+d3-bAO;=\LGER[&)_-[PYOM;&1_76SfMBa\K=Ae6U#cNI:
\Fb4?,3\O\8FB)OZQ4N^fefW0JLQ1NUM)J&5D?4@,-[#FELX_5cV^,\JOA68:0aO
BJP1QSI82+g/E3E_7UK>8Z4[6&ED[Gc=J>3W(<<6\P>49&f1F)58X^BF9JK.9L8L
G]]2VC[4IS0HR-:DK<NZA?A<N7.(OF#e?MZ4?3;f>YeOacWY62FF>_f_KU_,BA#R
M8JS;?<+]65)a8VO]e:EF;+LPU4IdAdbE&W=F#C4V<AX)^A-UEH?U0B@=6\4,X0]
Ma&0RHY_OR1C5PN5RJ@QJcgBQQZZ][cNO\@WK/:6_-ZLPHc6@H9<SUEV;Pgc3X;U
/1e9AZ?\EO;P.9?;W@;g+W.HLW>)V_dWIAW^<UK(0DYIaf8\?0Z\NL&2&Q^]MX0)
U2>RRV5Z1Gc6IS6;(.b=a5R3?=#,eO/@>>]YXJPaI,:Yf[::EgL:+MLG:6:\M]bX
T7^e0dP92g3/fdPLWgH#eH<[,V0CSZA.;GBg5gM+@2FC+BIBTFIcMY97)Y\Z_@YW
IR<1V\7Xa<8JMO[FE5R[S)1M(QaM7E3Y[55^#a:/V4g:^;J3]4S6I._+\MI_N.)/
ZeLbgMC:L)Va=CEW)TAcg52SdSKBMeP)dXXL2[^+3UA[1HM<e&J<J1A#]WPGQ)Q2
JK_0JFB\36]dLR?_Y2FSXJV1S8[,BPF#.8RW5F9a?7M[C$
`endprotected

   
`endif //  `ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
