//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCE_LIBRARY_SV
`define GUARD_SVT_SEQUENCE_LIBRARY_SV

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_DECL(ITEM) \
class ITEM``_sequence_library extends svt_sequence_library#(ITEM); \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_object_utils(ITEM``_sequence_library) \
  `uvm_sequence_library_utils(ITEM``_sequence_library) \
`else \
  `ovm_object_utils(ITEM``_sequence_library) \
`endif \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
endclass

/**
 * THIS MACRO IS BEING DEPRECATED !!!
 *
 * Clients should instead create sequence libraries manually, using the
 * SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE macro to populate the library.
 */
`define SVT_SEQUENCE_LIBRARY_IMP(ITEM, SUITE) \
function ITEM``_sequence_library::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequence_library)); \
  super.new(name, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE)); \
`ifdef SVT_UVM_TECHNOLOGY \
  init_sequence_library(); \
`endif \
endfunction

/**
 * Macro which can be used to add a sequence to a sequence library, after
 * checking to make sure the sequence is valid relative to the sequence
 * library cfg. When a sequence is added successfully the count variable
 * provided by the caller is incremented to indicate the successful
 * addition.
 */
`define SVT_SEQUENCE_LIBRARY_SAFE_ADD_SEQUENCE(seqtype,count) \
begin \
  seqtype seq = new(); \
  if (seq.is_applicable(cfg)) begin \
    this.add_sequence(seqtype::get_type()); \
    count++; \
  end \
end

`ifdef SVT_UVM_TECHNOLOGY

 `define svt_sequence_library_utils(TYPE) \
    `uvm_sequence_library_utils(TYPE)
        
 `define svt_add_to_seq_lib(TYPE,LIBTYPE) \
    `uvm_add_to_seq_lib(TYPE,LIBTYPE)

`elsif SVT_OVM_TECHNOLOGY

`define svt_sequence_library_utils(TYPE) \
\
   static protected ovm_object_wrapper m_typewide_sequences[$]; \
   \
   function void init_sequence_library(); \
     foreach (TYPE::m_typewide_sequences[i]) \
       sequences.push_back(TYPE::m_typewide_sequences[i]); \
   endfunction \
   \
   static function void add_typewide_sequence(ovm_object_wrapper seq_type); \
     if (m_static_check(seq_type)) \
       TYPE::m_typewide_sequences.push_back(seq_type); \
   endfunction \
   \
   static function bit m_add_typewide_sequence(ovm_object_wrapper seq_type); \
     TYPE::add_typewide_sequence(seq_type); \
     return 1; \
   endfunction

`define svt_add_to_seq_lib(TYPE,LIBTYPE) \
   static bit add_``TYPE``_to_seq_lib_``LIBTYPE =\
      LIBTYPE::m_add_typewide_sequence(TYPE::get_type());

`endif


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
`ifdef SVT_UVM_TECHNOLOGY
class svt_sequence_library#(type REQ=uvm_sequence_item,
                            type RSP=REQ) extends uvm_sequence_library#(REQ,RSP);
`elsif SVT_OVM_TECHNOLOGY
class svt_sequence_library#(type REQ=ovm_sequence_item,
                            type RSP=REQ) extends svt_ovm_sequence_library#(REQ,RSP);
`endif
   
  /**
   Counter used internally to the select_sequence() method.
   */
  int unsigned select_sequence_counter = 0;
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Identifies the product suite with which a derivative class is associated. Can be
   * accessed through 'get_suite_name()', but cannot be altered after object creation.
   */
/** @cond SV_ONLY */
  protected string  suite_name = "";
/** @endcond */

`protected
b;1^-D=ZN>e]PA-DNegc[AVUR-=[bHaZFTL6/fS__#XI]T?>2.:g6)9cHS7b_MOO
05Y4TNcG[5XfKKbE82=d7QM8OO^BfaKE3GO7D&[MQ]D(54a1AAD?6\9cM$
`endprotected


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence library object */
  extern function new (string name = "svt_sequence_library", string suite_name="");

//svt_vcs_lic_vip_protect
`protected
L]7YPZXO^/[Bd-].VdVB74-N0\GFASVWUMAeaGgLG/.2HM@8/EKQ1(;2NB8_5\Bd
-1#gdd+MG1W@J6Bg+1([X/4E>[OV11WAM@89N;4)=0g<]B<ZY4/IBAS(4G=O,F7V
Y#52;Y(EI+@e@DGH&-?deBNf0fWFH+?24U3W,Z[6CF);&NgLc].gY@I0V#S34>D+
5L(/+<^bNU7^;@Zb4U3Y2=cTePSWbP/^MC(c\:&CE[P61)c&M5</b+]GCJB^Q/R5
1.O-4:I^T:G+X=&EbYZ]P7A2e\;??0aBd89>[XN_]B[.7V_Z8QQ:BX..1Ff2U\&I
1?U3CREe6f6:1JCAfP&9e-5?0UC-OWSBU]JL65H4)BE\6I[aB-bO+I/7;CNR>U)V
HH,QI5:UBN<.4.KK<IAGP[GV1;-_W[;##+6-PI8Qd<SX<OXg^#6,RBHdF<Nca2D#
^Z>g0a]g#?/P0JUUa>WR14W)H0..C?S37T\_A+ITg@\0P&?96N9G;d\5^>D>R[F:
S&AFHR(3K(&ARADZJ#L:-[H3=?aXC)A&PQF)7H+\VC#WY[GGc>3IH,8V:VPU=b^+
c-W8,6\^e8Ha)gP+/R=@^+U(=dO(TfC_<,I1:e-@e&Te9RSQ?OPcU=DO]QD+N^d+
7:dfHC6@HH0]LI9.-E.3]Va6g\FTCCM3[##Fe39RJ_^5YZ-@1ANgE6DOI$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
77P3?<0dT>NLUKdJ//,\#=/3CY)AY->TH6Wc>.K==&9)a5HHg8:[.)c]IS&#7G>f
_^&OKQHVM>AM:56;@^?44>J.[a>2HOX\=,/XFA;RRQ0Q<L2F9L5EXef]E28OJ<+<
^2G,_WHV9S#M/$
`endprotected


  // ---------------------------------------------------------------------------
  /**
   * Populates the library with all of the desired sequences. This method registers
   * all applicable sequences to an instance of this class.  Expectation is to call
   * this method after creating an instance of this library.
   *
   * Base class currently implemented to generate an error and return '0'. The
   * implication of this is that extended classes must implement the method and
   * must not call the base class.
   *
   * @param cfg The configuration to validate against.
   * @return Returns the number of sequences added to the library.
   */
  extern function int unsigned populate_library(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Generates an index used to select the next sequence to execute.  Overrides must return a value between 0 and max,
   * inclusive.  Used only for UVM_SEQ_LIB_USER selection mode. The default implementation returns 0, incrementing on
   * successive calls, wrapping back to 0 when reaching max.
   *
   * @param max The maximum index value to select, typically the number of sequences registered with the library 1.
   * @return The selected index value.
   */
   extern function int unsigned select_sequence(int unsigned max);


  // =============================================================================
endclass


`protected
S)3B9O4XAa:,,RHNRfIJGIe<:dLU4]TQbQ@QBI^([G/c_-Y=dPFU7)a5;C_Vad@T
S)AT&b]=76YE86\.ULWK66MC+da69I1&JQf9)JYf1;/1UIA8f03Z<WC_Q=Xa+eH6
OceF3R95<f[(E@SH&K0d8(c5RGVZe9ASR=?#XZB9QKJ8Q2RaJg(8<@@B,L4PHE^(
&]e83]+G_dNGSV@9?TB^8>0XXLRXOA34VVO[YT2G3cYC\CJECgEA05DNSdW97PR8
BDV@HfW]LB<R5OVeI.MTcc7X7b<b:K[-g2Z(T6.5d5QMQRJ^RQJ-dAT=3+<5-0QC
6,PS>WLUWCWeG?)LTeKBdB;,2YabPY.>(Y_8&b[d(a_TV.AA(&IN2e&/XKA@@+c/
@R.N^@6b74?JeH=#cc0IVO2a](0:YW&P#ZV&4IV^Y9e#Y_3:\]HDVQD4,g10>HV?
6,+@Z<P7VfA8eN;N(:8#5Q.g\JT:7bM#NGdMb?/@d@X=[<YB.B=YK[,ZM7aJ_X/_
Q>gdAcS2ZJQP^_>-5Y>cF@e-[e2NRcdW5E&^[K)=:b-].;>ffJ12;:6d=PFeD2J?
RRMGB-T17SU#D.0c,#[DIb;LH9WH]GCU:e&W?_M??HBAd-QC7K>=bN2+b;d+=Pe^
)fKBe==YQQ.E+V8c4^a?Y:W-@U.8>bTY[1gDP[.;]gHI#(Z.9R[0\???a@?(;eHX
DI60_9\[:1a4U7L?SUGW6,NFHVL9R_OgTA=g23)KK7BD/XBV[;V[B>6^8E8[KWZ-
8@,)b\>^MM2W>#6-.[AU],-3A9NANdH6DJO7aB9&:P7L.QG.9G;bJfM@Q=-ag5B=
I1a7@<MPG;(IZ/HAbRRGM7-32$
`endprotected


//svt_vcs_lic_vip_protect
`protected
2WBK#c#6(U4;;791^6XP6>529QgBG>\:LK71T:3HAe),MA6[BO<g0(6c^JDRW2X_
^8_AMFG0\/fVV9.6FK<)RCVOSUW8B#.]+;/78GE>UD[[9>_M>#^2;311eYAITPOY
4^=V(KG.FK1HS#Xg6T#&:VT;]LgeXH2VS(L?B83_J&+f3W2bX9GFPf0(R)f_[GJZ
Vd6JI4(Y<QQZN6,,O&,b6d&]8K3Y?3OW):d/eNRGHR>[d(VJfV;UU_C?(Z>P@P.I
]3See-cMWTb1b9EC8HC;bRc&<Ugd<@.0I9)B[;.;&^P+TP)J]Z+[A.+25Ze3XB]>
fa.@g]N0F31fUV8YbWMO2dG^4BWISA\IJT+_L8,B?60@]_?_AO_X-_>275IceV5&
7_MR8Q3:.V?]<bX5Rc<:;d^QM/7&4cee/0\:K8B64eH/V(1QI[2&5)Yff)Z1ZUTg
\YA.-FPCKS6#e_BWRHEbgaJ,E/J<a,cAIAY:+MIH+Dce.:G_2=?UeIe;_DC77M12
16BcG/80>GQffDV4\4H(3bD;>N9<@gGH#5VL2P3=@II[gBOPaJ?HIPA-AA:?KX,J
U&9)JT_UI.d+7C0ILAB08G7JdM,;)9[1>TgX7Z47gfKY36Kg02))Z#6ADMI9^9+W
H+9McY@[-1\:,V3.2MZBN^cZ7AONBC-95a4EZ>H0C+5.;A[FO\YM:Pad&]XS_BEF
BFUD38V@1Z^;6(c,;AONgG5g20K9GBR0Z\,Wd8&[,3-U.eD\JP]@_M>72GXCE8=C
W)FLeVG8M;M+EQ[\63V7+SXd<+FFc0/3c8NK<)RMgJVd#6B+S[eA]8\5aeaDWMS=
IfLW_.dL<fC1EM[+MR/LC;9e@KP3Za6\4?8d]5^(NQ[f)_LcU&0CLKA-OH5fRBBc
\MK#EY5B<7TJ4cGJ4&f/c_fX-9_WdgLeAW1aE1VO)ZV+-A&R;(@<IC=Cd7^(Cg2>
ZB7e.8FNG1Q>c[@B.geI>c3E-O?W2P<W@6@XbDLLVF+7;<:UM@,8;B.\B&c?7cL.
V@,N>&1XWPLN(FM8/55W<W:gT.M=FK2e2e,Q8NG\W,<P+b>?SgX:-7HdEEc1.HU\
2R.=2GdJFRBDI;8+]]b=\C,/e66[gYV)S4&?Mgd65f\D>>.32R17O<(UJ1g&c\)M
YSC/BZ<+K^26J(@A-X(GL??1?=K6<c-<NZ0,@QJI-4b<IJTV4O=SdaT=#\:cNEIW
D1D63R>9Z:OZO>b^+>gRM\EFD=A&21J9W7#0>AeA2TWYJTb.-TP,NJ77XRF)8N=J
B9\cd6.HU/D+K<I31<><S-M<f9,+G#W@P6,(E]-=/)I\#<>bZ#3;B/2&(EfH;)>_
7;3:g^J,PFBNRM+2,ea/=0>V(OT?8]B5Y[^W5]6ecdJ.MZ>cX[Nb09K0C-O6?ITK
?Y7)DP27bG-T7_KaY/SYSBA[P2K+PV(]U@+(a@^1-)=f?e2AT<V0P7b@^=U7S=)1
V(.,L.I[c?QK+HeZ,V1=A[HX?6^G4])@aBKPg?+&0=?+IFFHOW>3WPZ0?PgV5NT^U$
`endprotected


`endif // GUARD_SVT_SEQUENCE_LIBRARY_SV
