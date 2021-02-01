//=======================================================================
// COPYRIGHT (C) 2009-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_DATA_SV
`define GUARD_SVT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair.
 */
class svt_pattern_data;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Property type lables used when building the pattern data structure. */
  typedef enum {
    UNDEF,      /**< Unknown or undefined data type */
    BIT,        /**< Data corresponds to a bit value */
    BITVEC,     /**< Data corresponds to a bit vector value */
    INT,        /**< Data corresponds to an int value */
    REAL,       /**< Data corresponds to a real value */
    STRING,     /**< Data corresponds to a string value */
    ENUM,       /**< Data corresponds to an enum value */
    OBJECT,     /**< Data corresponds to an object */
    GRAPHIC     /**< Data corresponds to an graphic element, used for display */
  } type_enum;

  /**
   * Display control used by the automated SVT shorthand display routines
   * to recognize whether an individual field should be displayed as part
   * of the current request.
   */
  typedef enum {
    REL_DISP,  /**< Indicates field display for RELEVANT and COMPLETE display requests */
    COMP_DISP  /**< Indicates field display solely for COMPLETE display requests */
  } display_control_enum;

  /** Depth used for the SVT shorthand routines */
  typedef enum {
    NONE,  /**< Never work with the object reference (e.g., Never display it) */
    REF,   /**< Only work with the object reference (e.g., Only display whether the object is null or not) */
    DEEP   /**< Work with the entire object (e.g., Perform a deep display) or the evaluated (e.g., based on accessing the calculated 'get_<field>_val' value) value */
  } how_enum;

  /** Types of alignment during display */
  typedef enum {
    LEFT,    /**< Left aligned */
    RIGHT,   /**< Right aligned */
    CENTER   /**< Center aligned */
  } align_enum;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  /**
   * Simple struct that can be used to convey the basic 'create' elements of
   * a pattern_data instance.
   */
  typedef struct {
    string name;
    type_enum typ;
  } create_struct;

  /**
   * Simple struct that can be used to convey the basic 'set' or 'get' elements
   * of a svt_pattern_data instance.
   */
  typedef struct {
    string name;
    bit [1023:0] value;
  } get_set_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The pattern data name. */
  string name;

  /** The pattern data value. */
  bit [1023:0] value;

  /** The pattern array_ix. */
  int array_ix;

  /** Property type */
  type_enum typ;

  /** Class name where the property is defined */
  string owner;

  /** Display control */
  display_control_enum display_control;

  /** Display depth */
  how_enum display_how;

  /** Object access depth */
  how_enum ownership_how;

  /** Title used in short display. */
  string title;

  /** Alignment used in short display. */
  align_enum alignment;

  /** Width used in short display. */
  int width;

  /** Field bit width used by common data class operations. 0 indicates "not set". */
  int unsigned field_width = 0;

  /** Type string which can be used in enumerated operrations. Empty string indicates "not set". */
  string enum_type = "";

  /**
   * Flag indicating which common data class operations are to be supported
   * automatically for this field. 0 indicates "not set".
   */
  int unsigned supported_methods_flag = 0;

  /**
   * Indicates whether the name/value pairs should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /** Additional situational keywords */
  string keywords[$];

  /** Supplemental data about this pattern_data instance, potentially situational. */
  svt_pattern_data supp_data[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
   *
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   * 
   * @param typ Type portion of the new name/value pair.
   * 
   * @param owner Class name where the property is defined
   * 
   * @param display_control Controls whether the property should be displayed
   * in all RELEVANT display situations, or if it should only be displayed
   * in COMPLETE display situations.
   * 
   * @param display_how Controls whether this pattern is displayed, and if so
   * whether it should be displayed via reference or deep display.
   * 
   * @param ownership_how Indicates what type of relationship exists between this
   * object and the containing object, and therefore how the various operations
   * should function relative to this contained object.
   */
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, type_enum typ = UNDEF, string owner = "", display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Copies this pattern data instance.
   *
   * @param to Optional copy destination.
   *
   * @return The copy.
   */
  extern virtual function svt_pattern_data copy(svt_pattern_data to = null);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to do the value match, taking into account positive_match.
   *
   * @param match_value The value that should be matched against.
   *
   * @param is_found_value Indicates whether the match_value is real, representing
   * a found value, or if the field could not be found. If is_found_value == 0, then
   * the success of the match relies entirely on whether we are doing a positive
   * or negative match. In this situation a positive match will always return
   * 0, a negative match will always return 1. If is_found_value == 1, then
   * the success of the match relies entirely on whether the match_value compares
   * with this.value.
   *
   * @return Indication of whether the value match passed (1) or failed (0).
   */
  extern virtual function bit match(bit [1023:0] match_value, bit is_found_value);

  // ---------------------------------------------------------------------------
  /**
   * Method to look for a specific keyword in the keyword list.
   *
   * @param keyword The keyword to look for.
   *
   * @return Indication of whether the keyword was found (1) or not (0).
   */
  extern virtual function bit has_keyword(string keyword);

  // ---------------------------------------------------------------------------
  /**
   * Returns a simple string description of the pattern.
   *
   * @return The simple string description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @return The real value.
   */
  extern virtual function real get_real_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param value The real value.
   */
  extern virtual function void set_real_val(real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param value The string value.
   */
  extern virtual function void set_string_val(string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data as a string. Only valid if the supplemental data is of type STRING.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved string value.
   * @return Indicates whether named supplemental data of type string was found (1) or not (0).
   */
  extern virtual function bit get_supp_string(string name, ref string value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`protected
5=a;CZJUV:+NX8S,?N=4/&;D21#G?)^^H&A+4Ogf<11)UQHDY;:@2)O#RD54AQ6F
DBNXHA,T=4)>;bP99#.==B3:#g]ad.YNU^CRA5eg?@)M+Qfa?H?0gA<eW>A9[\E/
#+7YM3KZ1G^d6SREO@1H]RbA:N#C7A#T8I<Ca2^MWAX9TN&3Kdd<@\0AMVWB0CJ<
#^ffV9Y((&gf+].FCNPJV0#QW\cY@DEG#68[ZK1GLHK;e:1U6aZLSU<T&XQ@6>;8
WCe#e4Vc6GF)_;J=B36]2NeW><E[WH;+WTVK]7>=-0)@-712Cd@KRZe5>fS>f-@#
DH@Y)ef,:fUHY@R(G5RUBPU?H/d[800CKE;J/<]Q2??b+UU=^6Z(Gdb>KbM(aGDS
G&5/OfLR[BM#VM^T4,cY;\F;&AA..cA:,(R_WBU-&6^-3,bGJPR>bD7W^WLY0fT<
L-GVB+@<3eSf(GW8#eA8B=.8K--a,#aF[daP&T:YIMU6T[R1,Hc5,8C0\\e;BbDA
0RbID,#42J.dJSD\XPM8&BNL>^T:&#G71\+f+.AA_:[T?&/Za3XHM\YS/a:96Fa5
O#CX2fGS4#L38?_596>=HNJ.ASGbE+LR<3[G+IBTS_OWRNaM)aR^#AU;77CH5Ufa
>0Yb1.][Fb?OK,L,1Z^Cg,.)/^QP\eTf:^fRM^CW)8ea50f)W,YRIZTR#ffHYH4^
2B?L,W^A_/T:;B^::4XdGgc+J-dDI[QR(@Pg@8J&-01<gUWfbBUHdf^,118LJ#4&
#S\_&MK)QOM[#3b(.^JO&\ENHS?;]^9?-f<.B11G/caRPgg,_(3-=?Y.We?cV?XX
d3DP-d9R(.SV=)0:.M<)O-\P\NK-UDLI.F4N_T0F);b#B6F^EcJYe5M9X=;G,UU:
fc:H+F5HMPCU64g:g\0HM.7QK[bM[;+P,T+,I4C;EbBgfYDaH:G^<J;gN/fKS2MT
ZR#9>I2Pcc?H&]M@?J<d.dUH2E:A5gNCDX+K1II>R@V8EVV]#PJXESW\&KF,DZTf
Rf>BDXA_DFD2M09:AW;D9O8:0g2@Y3TH&3#AcG_0(N[2:I>IMV5X<8U).VLD/Sbd
.;]-+DLH,EB8VW(c>7K_H,gg9).b7IgP[T+f@:C51-T[P?&L#1QN67XIMVRc84:c
,E;;cD#N566_?EL[FA#0;3,f_VGC]-7R+S-P0fQgC\H];dP(&F<A(48X.=cF]MSE
5YFe(S)R25c]4?7/LOBMNdV=ga,4@L<Q)R):^eBD0XJ>#D8T,Y@A54\e6BZU]d51
6PXgf_1M?ZSX[&<E(VD_6;EC<#@d#<)C@_fGZ(?/?AFIF_,Ad0]5?4LJ#CSP][OF
FR3WF28a#XM>#;Y17E=G6SL(Z&6&HUX.L#N[.5Q19YcEZVXNG48-^Ba(d@DBJ=ZM
\@1NbJ&>cABD_e<VXEE54da?RfD>^a22JXgUJ20FT.>_8AY^TJA5L+]N>AKfJf5T
]F@>68-D.EfT[<?:#aZHHS;\VBF6\?BRZD(WACBQb/.U_.+<R,W./d6-dCQ@Zge)
8E2ROP+cFIHK1UTf3YSXX<Z]NQS>RV\I8aZCU2e1\g8a0_d0c90KbT.\UT(CN@B9
XX[I28E2&@T1H;_1NR+=OF;cE>H8M;6e<Z-8W,6Regc9dE[3+W0<H<WdB@G)-J7a
0I+\&GPc^ZF^4WGT\+HZSF:\@2g^\XSE8,OEG[N[]Y3^(>^d_SD--X1_CKM8\:;N
\G[]3fR57?\_59AAG7Lg++G^Zge(N^V,(N/H0bD,VV(@DDB:NO.//f4BM9L\IeLX
4_MC/@b7R]:T&K.=QNGTAeBK8+(e[^f\TICDSdB/]HF6UKQTLaegBN.32<[PR7L)
McZKFBVS9fe_1Y2[I;cLGY&LEZ6GMQGV)YY\+YdM3()[O,T@?RL-#c:O]R^f^/JF
.J:J5_G2SX1[/]Q+]/Y++]-NUX\8cU?EgaE,P;K5a1\S<Z7=+[EX16bE/U[)55ME
NZ9<;_BB-QJ.K]0A-(91b1>GF\d(fNf>;Q0.7Qa(E(-U98;28I8+)dTJ\c&<A8F&
3V\IEa>--+(EXVAZRO;#ZWf35,+QRD3&R[2]W@<7YS?4H.]@+I,;9@OG@2I]FESU
^/?EAL=XAO4ZGLK(_RNIC<d52e\C#CC3(0V=4/#>841Oc)43d<[=b&8^.VQV)WJ1
>PTGM9V[8/2L[_MX>0@H(K>^+a-3.)FT9dBad0@56W(S:<.4#dFfP#=dEE176RHE
d.L4.bT-YN:IOEI3b0IU)<9SC\5a@<+T2=ZTB#6]N=PgLB-:L_?KEQ4d0A^6Q5?Z
9WZR2N+<8WX(aYL-7,&J/=\[-V,TS>CH\T=#N-6[6f2dYY/b<FDS=&)B.RaCF>II
TMD,^N]TBdbXa5)OIDE?306-57EX6:@bCHX[.T<6&/7,XU.8Y.WdCE3\OTb,gKC,
YCH)KaI+Hd81D7:\I>NT,,X:]K5>;FWWfPUG1\&MJ4.A<fWC7gD<T.8+88LE5K?b
:7>7[]AH\XGXF[V>f4fDG&LM&214]D,:efG6b:+K,M#^8>SN#QHFRTc:)S@eN8D4
FI<5.Q3QK\258/56>]c5FZCGFa>7FADY8(96B?6&(=[1(Q(=&OC>/S5+JQQ#&gY#
:c3(O4AJ8)^dg[db:Q_f7UZEg@V&7=_:dBH]=N<VB:?,GJ<[c2_T9P#,7&QWCcTT
_D,bbH40\I.J,fKJ.F=KX4T]Rc=ZY\>9P[7HPIaGR;?PGWS9GJ4U1;PA\M+F9WR>
J<HaROD^TO6@8&4Y\8H:+67?0&U@E60>JB4_abY6e6=X\e0QA_W-<dS_&6RE;?WE
7[/#(N+5O7Xg\a(3.c(Y[\:8UG,.QR&Z=O6EZJIaGJ<L8DWcQ>WX/<Nbb[+fTVTL
HS)f]caT^N0(EE<36XFJ[4ZQO0:IZ7\]bS/YUgY[M_d\;X7HW6K0fbT87BA2UK3J
X?=c3,S6-H[,0aP@BE>S32[PTX7_3O_W4_D3Q4_+N3Nd5QCDZI^T5f#K&7b3+/W>
Ta<V]T(@\O\AeW6[dZD?aEA,B,&>>S^,T@5Kg?O,aLePC(>NQVQU+OT[VR2T(ZKU
8.SgPTIJ/G.X-4>HRGgaP\CDSUbGB.LcRW/Ig+B?;B([2>a:O=CDLC1H<YcKW:SW
e&B0W&a,(K-;)K\J]f(fYHN[I,9cE5@B=\@,@RYZ.L8gX#ReDEJ?QU+O)@5F>,DH
#TDZDYFI)^561]@BM+M_V7gg:(1518@g:Fb7Zd)K0EYeef91MA<\cHe+T1#)Z,3.
_Y\9FQJ-f;c:,^f4LG3aZMN?LJD>+GfK@g0UI^C1aT^-cZ>R];=L^@HA1Af+53#e
W,gOZD:,#-XG>]\:@5QO^.dI?;X)APUZS0:2fPb6Sb92DA^T_L-e)QCI?0WE:C#B
,D:?&Q&SS\5DR\U_]<g(A)R+BgFSfU9B8UEb^CgMWHGFH;d)(cK+#cK@7#CK[XPQ
2f-[B+OQESZbY;EL4Q:^&(M\>#374.BNG0QROWWGRXdMRcTSQgR2-0?Cc?DP&?^]
(CG(]#P8:Q^FIOBCBdg^)]&5:G4-00[^41+Q_VZ;CJX+\N=9U8055<HT,I>gC3FW
4W/JY7.fGd/X.7#I@aJAEVEVM2Y;g9+^f>Q444X#\Fag4KRARM.2RUK5]e=F0R<;
^OO\,:VEMd@a8[B9DGC,N)c\_U7V>ZcaRfTL;f#UD2#g-fGeBPLOTW[AQ\DTJ>D9
KS?PCOG8K=Kcd/).c\06R13BN>@8;;3b\D9+V/e(eeN@)):_=7T9)?Z+U7VMI1A>
)-GJdDMDSC_X=OZ4-)>2,I:Q,b0N0S.;GaSU)+UC)&?ELS+L<G7KgOB<AWc9Y?,H
+Z&e\U/:1^;@ZG;YSGRZQJ)75>Me#V&f>3ZQ1dIZdS/<9KQFG&Nb)4/AKNMZAKOE
aG^9Xgb=BZX(^:E64.B:ggKEe2D4#SUQ8(;GPF)MD:WM,V@B2M(OULOX./g=EXDN
Rac7V@e:_/G5Q_EIA9-_bHNL/,Ma0=f#]@T:B&D77<@:WRffQ]]E@B]^F:3<>-5E
=U7>fID&aO(1ZETK3Y+#S,,5)91Vd1J_:)NO4C];@U]CT?JY^eg@/(;JT;]\KfVR
5<B\a[\M8QbB\:ZMB2f+-//Y4eE#eeY=^74<B2/cb\F/N>J]NS.&@J[]eC+N<9L2
ZBOGLH]Z2+;C2MQMe[^37)EZHUCM7,b#N/:]7UP8.<Y;aZKPT]QK;LMIYDHV0&;V
4=\<Z<ED0TGAPE9_^);0&)?1c&S<[b-bM4#\WbQ7adC0R,3I3MNU7c<ABOX?8T#D
Wg2+M3L5+@Q7fDXLY5eeA(BR-@CVVOQbO87M>L+&F=2WGe9+;<5JOE1;XT5J3],D
HRNNZRA>[LCfR_@(VP3e1&\IP=9ODF,YD;c5#NNE\L]3O4=T9BgTRMQPIAI_ZDM7
Rc83:Gd0#JcEe/U4FY>c6GK?DKJ>aAPDBcQOHEDF^H,IZ&92-,)O&IP[\_K5:2Y<
V=A1VfY@9]FS)VYZ6c0>HK@.F)J8(Z,[H,,ZfOX-&RY#<NI=X2^RJ/)AS/IHTc84
E^-9S,:PH-e7+SC64c&37ZO&I=+\XIc4L2eI:E2.@L@MF=NLcGGR3S:W)[UAD:Wd
L-P&:Ecd6@S8=7+aQPPJ/3;9/@A7Ufe@/IQ^=#A0>6>W9(R/(F,J-(;ed_P1=4=2
)eYA;J.GI#I5O,><#NYW9\3:U^AE3Z-@c?,7,e^4X+6Sg82Z@HeUgA3FgZVZ^>Cg
VA=K9aA]2UeZ+H?aN)\<5b&f>&<B@#<SWW[c:.^WeI@FC);b\(c=5B6=O.eEA1KI
XBX4^R1&N,BYM+LF>aF5D=HAg7?fTOIS#8S^8X,64>+2f#(4)BGCIVM?c7Z+HT-<
6,&:0JJ6#\bBCc8>C0VN_E9?WJ^^d3&CAGI;Q5;)dbM#<.a.d)=]848(@T1\\X(f
S3&Re6#>.U@YYcBV6L3<;)J,B2.XD?FZQ#a,?BC.@(eG=MLU(Qb:TWL0JDd_<R0D
#b/_C6W.dE6JbKMZ^Y]Hf2BN:b@<,6?8EM)P,L8&E<3Nf<EA\^\S]>CW(E+HM<=.
#S0(AJ6KLW\EQ@cg6E/QJcd&bP6gQMQ>)a>W@e>&?59TSRbGHTT/4b^YPBKMa#A=
.YFM6OLE2DAEM;OcU]]DNNXMc46H<:YJd<_HJ_A1:DKK21)1U.:NIgHN\c1-:Fc_
1DeCP)=U^KDVIGS#d1/,^/_+,7J/(Y)^;ZNd-f098;.MY.2<AESXg>IR#;Lc5[N8
E#Y029]I.ZAfJc7[5/>46=Y?+7MC4]4E/Bc:Q&@(c46@1c]4M3:X@5O5QCL;MBXa
dJB8;H60[6.^:ROeJIMQD?;.73Y[4e7aSU#\X8WF4AfZEZF\[M@0e@1Ha(LW-69,
]9;CFIWJSF1g69NFSHYbA=Y63QZc#8B7E7QaTWC,JH4?=H^Ag9./)Y[OTRaa);Wb
JJcS_D]9I/dNfB9^aZJ5\(.U_=C\a&VQ/c6@@V[@)-J\#X6=.3IZdI>>;1\D&(Hg
(GRE2Ud>I57T1:U=)#<cF?<<]=+:5E;-Z1dF3g+_-8b@7b#BNGNT/N>:7?Te-XbS
#AM?3KB9YaR\J-C>]bQ=M29,\->YFd/Ad><>QW1M>L^WfI\.,A\=cBV/UD8+<<ML
/(]XbJ+.]MLe_YNWP+Q#a,JbbG_N[4777eQKH]U.K\/D4##HaQRNf>I;E(:g3J8.
3fe-N5c.^5?a/ES?C8@RPORN<X,UGcTRD157FZLKFV/OM87IB-Qb#.7RZ1R7EaBU
-?D]7:YM+^fX+@G&MIeO^3+X9)#OeBfAG-bX;GX^IT(;3RX@[X2;FbN]BI(BG@.7
/U0\/#<(_Ic=+0Z.V3PT-fI_.E,W\/:/0<<TE@/XXLL;c?>6G1[0Ic_XIKWbRGPP
L#^TOY^/e0\X.TI;d->F6#APcc_D2f:gMfadF3Pg]N.X;gYd4J_Sc@[5WFUdO^2G
[@,X/aJdJ)+YVLP^gc6;<@Z.W_b7=MZQ]D;;&80.XNV39M,PLL+:OW4@a0_MWLRK
2DK[e)+MO^^OC;-(g\0;bS#UF2OMA;IP>QQ6ZK2M8[B=18>&TUR:Yg]LP6CO4#V;
S=<X2@;F___Tc2H)S^/+C?B?abL/GaO-EdK#S)#L:bFdEHJ\A+#IW:S02gI;]16:
Z.bON+;9(DDR50\b#KPOMNF#S9_GU_8GVQ:PO+VfSM\9,SMbd9;caU.N,eR2QWQR
C,5E\;:K)N,-5#X:O-=KC6J?<f#@E^\UK-2M=Z&WGTgO:T;?1;K^I_Q]WdCCe3XM
31b]2Ee=DefW8eAZN0(NTJR80NcOR5B4-P549J6#P:C4bN_]XVe0&g4\&93bFG@a
OPHF7W@YXWcd<Q;0d(DKG#X6<=BEF5RH83]TFT+@.0c-<ca]TE@AeT\BbBX,RJOD
QN42@B@_E<_PWc1WA#\5LbXdS&^E>#BO^Jc8-7S206Sc+]G9<8CJc.AU2U,[2HIf
Na9#0#24<PC(WXWF&f[]c-f?TI0MR1&WdUHNER,OKEQ-SEWF@UAbY4&2M5.9KSA,
&-Qc3U4>+&<A.(4\;;PfOXQZ#BReYC0EHLaMJ(L4;NcVLP3PK[WVFQ^?RR<PR+c9
P-^E@>OHJAaD5(60=J/.OO8C511<6Rg#M=,H:beXe]XfUQg;f)a?6-#ZSfB5PaQ^
g[MaTccNQ\(<E+56&IE/GLF=:?8)fP82Oa.+H^<]DU^F9K>83_UZH?]LVGI@5U-?
ODeeEg([VaQBbO>/5.3:.8X:=GGDNYNLH@LRXR2W0B]4Z?H2d:42.,S=79YNA)7U
MW07FK4M-7Wa::U5<f/5F7b(<:/S@bVR6/Z5,:LdL@==P-<=fJT^X[B,aK63eYF[
W[8?25?I-^B3S&I<7]PF6Xb(4$
`endprotected


`endif // GUARD_SVT_PATTERN_DATA_SV
