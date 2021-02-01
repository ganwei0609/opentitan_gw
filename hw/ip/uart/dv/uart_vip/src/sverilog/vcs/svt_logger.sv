//=======================================================================
// COPYRIGHT (C) 2010-2012 SYNOPSYS INC.
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

`ifndef GUARD_SVT_LOGGER_SV
`define GUARD_SVT_LOGGER_SV

`ifndef SVT_MCD_FORMAT_VERSION
`define SVT_MCD_FORMAT_VERSION 3
`endif

/**
 * Used in the command model class body for each callback to make it 
 * available at the command layer.  Implements the inherited OO callback method.
 * The base transactor should have defined a virtual method with the basic
 * prototype "callback_method_name( callback_datatype data )".
 * callback_name is of the form EVENT_CB_...
 */
`define SVTI_CHECKXZ(portObj, portStrValue) \
if `SVT_DATA_UTIL_X_OR_Z(portObj) begin \
  $swrite(portStrValue, "%0b", portObj ); \
end \
else begin \
  $swrite(portStrValue, "%0h", portObj ); \
end

/**
 * Logging support:
 * Used to log input port changes
 */
`define SVT_DEFINE_NSAMPLE 0
`define SVT_DEFINE_PSAMPLE 1
`define SVT_DEFINE_NDRIVE 0
`define SVT_DEFINE_PDRIVE 1

`define SVT_DEFINE_LOG_IN_PORT(port_number,name,width,in_signal_type,in_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d I %0d name %0d %0d %0d %s %s\n", \
          port_number, width, in_signal_type, in_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_OUT_PORT(port_number,name,width,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  $fwrite(mcd_log_file, "# P %0d O %0d name %0d %0d %0d %s %s\n",  \
          port_number, width, out_signal_type, out_skew, sig_depth, ifName, clkName); \
end

`define SVT_DEFINE_LOG_INOUT_PORT(port_number,name,width,in_signal_type,in_skew,out_signal_type,out_skew,ifName,clkName) \
begin \
  integer sig_depth = 0; \
  integer xTime   = 0; \
  $fwrite(mcd_log_file, "# P %0d X %0d name %0d %0d %0d %0d %0d %0d %s %s\n",  \
          port_number, width, in_signal_type, out_signal_type, in_skew, out_skew, xTime, sig_depth, ifName, clkName); \
end

// =============================================================================
/**
 * Utility class used to provide logging assistance independent of UVM/VMM
 * testbench technology.
 */
class svt_logger;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  protected string in_port_numbers = "";
  protected string in_port_values = "";
  protected string out_port_numbers = "";
  protected string out_port_values = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  local bit  logging_on = 1'b0;
  local int  log_file;

  local bit[63:0] last_time64 = -1;     // Saved 64 bit time.
  
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_logger class.
   */
  extern function new();

  // ****************************************************************************
  // Logging Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void open_log(string inst);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void start_logging(string inst, string name, string suite, bit is_called_from_hdl);

  // ---------------------------------------------------------------------------
  /**
   */
  extern function void log_time();

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an input port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_in_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   * Buffer the changes to an output port, this task will only be called if logging 
   * is on, so there is no need to check if logging is on.
   *
   * @param port_number Port Number
   * @param port_value  What is the new value of the port
   */
  extern function void buffer_out_change ( string port_number, string port_value );

  // ---------------------------------------------------------------------------
  /**
   */
  extern function bit get_logging_on();

  // ---------------------------------------------------------------------------
  /**
   */
  extern function int get_log_file();

  // ---------------------------------------------------------------------------
  /**
   * Replace "/" with . if exists
   * Replace ":" with . if exists
   * @return new string, string which is passed in is not modified.
   */
  extern local function string clean_string( string in_str );

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
OT:b;NDVN1g_\Aa#DQ<TbcLX=&8AV5ZgA?:>e467O<U--H\T3IK0))K8&34L1^/0
]G76(NY[AJY5NK\[<0[Z-F;c3R@<VZ+Y^ON/)b0:N2\-;[LKSS.B0]ZaU9KT7Y2D
XS:8,O1C;#G2D3=8E?WJ#M4M)F9TOLO>TKg_?@JOK(,#HZ3R/_OC6:e3OYOW@[O^
QdQeK#bQ&(3HZOEBXbcaVS&Y/b46L9+0DB&_1AS_]H-?E7?^.E5Q@Z,8&?f5SQ0U
Q7^W<^3NMSYQcUc][IU((R6f.(X)4_I1N=QD:Z>aQW@CWX[I)[We)1ZccXLEH;)I
O>B+MPZB<XfDTfPNE3?#a2aWM7?=2b(0IQa>a#c0I4cCGMegZ)e)HORI[Q9HKGGX
;A(cfMLT?EAf6#O\1BHFSf6UKZ3_ELNR?TWMI]?f4285GFgdR+W7RJ439g.<Y^C<
P3_FO\<#3K>)&E6@e9QCcVE+CC1:KBfUV7@V<S(DKeR,;8?DL?Z-NS--H9ZEFM?5
NO5fcBMBK^3[U>));#SPVSE_4JU\g[&IUeX9(9S]BY,/9D4:ZW?QZKPcL::JQQaW
M^P@U@&f_9.\YFbIJ++XE]74OES7@bR>f^AO?P/J^K:NOT/3(P7B;UNW5SHbGVJL
-U@<ZQ8,ER<1a^V[9@[E^+5+]4+4C8R+/X6E=LO_#F61^CBb#cZ<;)._O1A6U\Y;
B2^1=#R9O4cgM19QQ+-&)]F8K[+(P3[5IU&g^TH=JGCF78WQ>:KHS225#\JaAVgE
_3I7,8=[BFH:B=\;UaH,/X[T/&/S9<1Gf3W\5_P?AGUR]\5H_1+91BAeeL0O+69K
N+BNWV3dU2&D0fIPSFVMIH)7<(Q;e9-[_/ggJ5d2d@9:KY^?)>#A7+P0L.^RX/^0
/F\+8JSC9X2]QY@Y9@0XW8QQ<6f:8TYVD=3P=(8?>6P_^K:6<(.B/,?@>M0(X4F#
)R>=/f/d#a?Za88-AZVg7-@PR[YCN(N(ZE9YK4f13.=,OY,,a+68(S79[LSO0/.;
LD@gV#F+aA3]Z2<(OK(@QV>\fO9I8g+Q30]g9]D4?BMT<>TB4J+Of4LfB1V,IbX@
-P(Z[3._MbYRH(U/1ZBd8_T+XQcO]E#:_1Ucc^dDE6#aEUFN+M7VNK1W/,[W68#:
6?I[.YUT;D9JT\_W05Gg6R3(Ff@R&7_);gOQPWT_D<fB73e0fg/N\>Q+e@W:V-?_
d0?NLAW3]S1\PL;U_^2/+.F)K/6YXR_\ML@=XFHb)a1FcfWLHHOZWFT_<W3I^&Z(
I:>X5FSS3Pg;.4@cVFc:PL,N7@9E5IO8Cc60S4V@N+(8C(&&Y+[OOY7@R]+5b:[1
VC:2Be_fJfJ(Taf0>^R6RT)C^8).O_6LdU4L=+Z:\CI)FY>f0;_,?+)43<I7-U.B
<;1WeLHEG4KefPSeW4X,O5NOY>&.cgM^:D:@+QKSf:4c2^E^H^CP-]CS3?2JPN(g
1QQ=YQ\UV[bESLX]Sf75PNMTcVeO_9/?Vggg#]STQC-[[<QUT9b\ZP32D3dN-K1X
e^0.AP0@^R]@;a[Q]-A^R)Ce9\QGA3V@V5aQbFT<ZE0_7<G-86<f]ETa?1TURI2P
c_MeJ0IC&M3A0bf-G(1L-cVZEf0FDb&<I3/?RQ7I6:ETbFN?.B6Z.[BBKIGa\>CV
RaHH^Y#39&@:9E,8]N[f;X,.\6>ee3&VQc[997V.&5,?XNMTDTB9+FZBReTE(M>0
18-G4e:?Ie=O-)@EJ\LZ-U)+QGaO32V/S2>+F/#?PFW.caFgZEVbECUEPG@WX/BC
&.V?M8E=K552H\O]e<28,Ib-+YQ.aRM1C3R@a2_?3d.Q55=0:g)ee]II;^S_e<IX
CMPKKI-E:;WRL5:7:3@>UP(,#MG).2QP-d8LQ@:,QNUP41?@gSC.@8[)4:-]C6?N
WF+&.?8WPD:FW(R=\,#DA0RFKJd04D,_d91^1\>f)4(N0KcT4RPN#fR7e=)UNLDQ
O(\1KUb5b(T(S,ZGEP\RG0dLR)_0[:e+^,+0?.+:R@#Ba_#Ff,ccF7^#GY_b;c^C
=YdMD.a81ZC5BE0U\O:HFQWX[[OJUWW.I33MJ0+R7<NNLgQ-fV+-Y4N^_H?JW^F.
[-6CC9O8I]Mbg_4K<&UVD-_aP<C-K49SEP&BP[1/W)).Z[;#36-\D7W@C+;OF2V3
L:Kc9)C)G^,I;K.8&d^=4.3UVT)c(F+eRE0HaOCQ\cX&J,<R.Q<2J_+K9P?^9)0f
0Cc^;F:X9FS>DU)19aOEGKc[DN#O8UXPbMCM/>4Ib_cH[IG=F9)_NPS\_5:V5;dJ
Se=JgU&f)^2fV>21ZHaSFF;YN^?=VHEee4fQNPKB555:J2P]ID#F[@/OA6fM7bRB
[@1LG4>GGB)OB:==-7a5]a@a.JdLYcP.AI=#K?g2#TO)VCQ@dbgLE,/R6RVbZe[^
SgMYU_C8^9AG1NGFZ4;LbB&/5e;,HE^FKDP/C+d5M,e>XU7-dXJ9^FP5OaK/(IW6
TeT8IF&;CH]?b:[Z-,/GC302aV+bE<M.:\1JTC13e?c(Z<3;=BH>N/\d/(ANSA(a
Z<-EOc)7e^,]Ta70VP7+XWD.fD@ZF=Pa6&c#0OeZHIdDO6VL@&X/1M+1==1UdZF.
b[)C:9CAb8IKI82]-<D/2MG]31]WP06PYW_DGa5<\TT8>cWV[e)fU_5C]<[Y1WGY
fL0U.)=>g8?Xb(0T1V68J=;=1:B;@B=XX+4WNf3VG]]4/;X1>S0,2g^a,f<_b1fB
U=Ug[:5XA?VAZT\<WD1cc_K_+K6T?4IX7/UG+e)4P^UR#MK@/<@N3_]BO#GfdB<P
0-JPG&P3d=c03/NJSXPDTKD\B\QI]?4cAW>HBcP?O8E2W851d70C;RJK_T--TNM1
8\Y(aB,^N1.YZ(^<D366e=V3fDf_^9L?@KL2M?]\V)H4QFP3A(Hg<R6&d:DMH]dR
GL2(R=DEO0\MTKFD.H,,f(g>(9VBA&E:0L9AaE4@C=\KW(-;&@afL@3PM[AT+g^I
=B81c\eL51RT^VQ_M]+bF;4.P5ggSYU.-J=]9;NUMST8V\Uc8eDb<O:?U^TbEOZd
DXF?HZF79Tb@A:J(aVY[UVE=ICBY15@<,fea>2<\EAA)\G&)],KTbP=,e)5W:\:4
?&1-S#QQU?eN+GF:@YLA\U4N+EEXES73QH,ge/gHN4+;;96fMQT2,:cZUZTEBAP5
e>HT=PQUQU_b==[8L24T4K.eb\Z)(+c@JX_2&dVAB+d6[R)7Z:^2=V<#/(QAYML2
M0#XcPP_D;Z<P9#Y4/^NYb=g]+=3<ECQO&ED/>2Wa-Y9C3O\f8+ca&fW?dQ>Se<8
Y6EEZ+/+=:?.d.[L\6f0L1fYdP^OPYHc7Oc(;W@EFZ2g+Jee)1V&HP<2[b6]7+SX
I+,BU_3I6GCce4/[MO]MY.9eS-K6.\S#+?PB<TDUd5OR->=2PF1__>We1BbPaWVI
cTaY-]_dHCYZ7Te@bJ\[4+9/^.R[C\&g1Rf/@XE<8PM:cFfJTLV)X0^[:8U/OVfO
F+@M8LgZY#JEC#YPVS=a>+^<>(F\I077.\2d66d5\<8Od&,CI(A[MY&9+B=YO<<O
b#)H:/0B-G]6(^+GI,P<Y_DRYR]2b5?PMHP-JK:J/^d7]M=QD1\;bG7FI>-WNPP=
O<>e1dJFXH.e\g2<OEXHC?Z01@MMPA9[bFJTV40N=:02KW-[f+K@CHa,b#(ASg/2
(0MYEg#FJG,6U[)]W@eXHV\A+U4g:WaN.B7E(Ce.V<>X@W>#98cMEJ#[^D^JXDgD
f,-f3Z<5[;+LGc7[U0\UbBWEc2+0P15<P9)C\DDccP+M<[E9D6@:CTdT.?Bg.3VU
_?2=Z0509]M@9=.YI6Rd.UKN(\4R&(Wfc-DI[[4,SGQTZbREVOLUE5[Ke+?a-d9>
E1)?B,FE\R1L(dSYS+&0cBb.,OZUX@TOV(BHgZ57_&ZQGJDD)7O[FYTc2G1e94^&
+^HA#fZ^H\>/T&1.#f,D0#?gD5c\\MFLQJ8SN2)RD+UV351FZ:+-DYTa/4S+F,V4
,C,EW7^9CJP7Sb5NZ3U3(GTV#U8(D0YY_[<WJ(^4c8Y:a,<#E<.KSN<5fHH2WGOg
aff<+Q[H5>SR-\<8OVfa0[4>(WAc^>E7e;bOaDb9P(3[-9,E<Q[)-J(.=PfF3,Y/
gDMW2CW((MD&@>T_Cg&S3.Z)f69O+NF@Z21(097KKTNH5<OdfaDRe/KQ^:@bRL.4
+U&VZ#KQQaDL-(\_;O:d(P5P<E\ZbB4WC[[g+1Q(AI^QM;R7M-1a_7MfU_?\1T2Y
Q]@XU,^-2Fb,/6JA_fI<&4>c>OS,K[-ce/JXT8a0&C+??_[&DPU+(6?f)NO7Lf]4
VQK:-&S-+=gD,/5Y>@@J2B/X0W=Q-UNTeS8<\TFP(I[:dIV9=+^MSQQ8PY.PS8_#
W-EA7MJ,97U=A>&GN3K;/6\1Kd7J]a-0GS+fKG]UF2@ca\;D(dg,JAeHC<G+^<>W
7Y]56+LAdJ92]^Y;BLFg?MN=]M+/0]X&;Tbbd2J8KRU#<dBLcBETZ&>-O1cX4cN0
6(\[X:V8)9@NO6C7YLA5&2E;11@2SbAO3F#JbZ&)DQA\YGBGbZ_86TfIG)M3-W9D
1fJATE=:F;51^Z^POKR:Pf;H)A0XO#MRPDe:WGJ3T>QK=8fYf6KG#GB]XU@D&WWc
:(W,E#BBg,0LK+EUSg+6F._^XVaW4GD4#5c7-Z9cP&23AQ)X(_NZU^FG&Be3fGc;
#6_AC1cLdPA0c4:A(L/O^-@P+&d<OfISSLe(1W<]KMVITUA&6=MKMf/?P0E)SHbD
0;,&_4#4KJY;1<_RD,D,#KbHO74[d:/KQ)X.Z==6B/g0..-N/e4@4Rd6H+dG+/A]
A.c;>_1aUX2>B;;DTbgG2@32e-T<gK6XH7HD9f_5DMEVRg&_&,@eY,THQB9=F/T1
M5#@D=fB(a9[P4#@)#LMQ)=4+MT:b-X7KR>G5@0a4+C0DM3gf8+5SGR)Md8\9<4H
JW<(?XY5/4e5/U\Q#4Y+Z]RRHb6ZaZ/8.OW>4cdDb?J.YN_a^#LG#1:.Cc-M]\Jf
)Bdf,SR9DA8\=.\A8QDHcF]Rf2,COYIB/R+WVfCc?^X9QTVQ7/2M#.fY?\4=W2\I
K<_HF1VNdC](5D^<92A,gU_U-&RE([GG6M1H7BeW]P[ZTRE,Ke+Y-3Hg;9/@QN2S
M8F^S+faeKY-7AJAQ3SCc(56V7E<U1TW#XQ@;&7g\<H/g9QcTMTfP(gI3\3&[bJ?
\GA]1/_+5TZG?e+6.B-;5VEJY&4ef2\NYCbE[9T\M+T>Z)R^b)0MGL1CVC-,<D2b
-;E,:W#.=]H@QXdXbK>3]dH/,]Bdb_&/J=[]b:,JY)e_be.M(@BfIgN@385P?CH\
GS.QK+:E/_#^fO=^WDVY^LB.6;F5BE&LF:P7(G4E?_2bYGQed7QdGXZKUGNW5eYV
2dTB=9^10OX=Z[;eBHUUQdKV4U?bTHWgD;U/H?;=:ED^O\IF@=^+-SC,7KP/)HYY
-M?P51@RPGK0+-4aF+W-<58GWY-Ma=.ZVSM<UffCL8PN)BY/a#;RU>;4LM,Q0]b8
3d,JSHJ(#7YD_MJ9#GEZfAO^<ZYX-4431V2CL2G8?STDO?EY#EA:9??b0<cYRR5J
Y9NUH<9:/U/\e/W3R.CRSbDV3O&A[JW2?::6.)gR7ZD_c:)/\-e.D]Xe4F+WH?I<
=PVM>30]/cYHBfe=_U8b(d8bD-TUV25]H1Y4:Z.G6GPYW4E,RM2QR2]JH6^^Cg7]
Rf]@1+:^(L^@_F+UVLP#B?SG7D9C@2VKA,G\JOe;STI203)4^97.c=]cSJC?GcI9
>OZ4T4M<,K]5I8B,T>_:Q+)MS,:K@H?L0HQ_U&RaLKF&4?@[OK23EcgSJ<HR<.4P
7\.Q\8QKQ16b_#^92EU.JDM,427](WDYFZB,4=J]:TWY0)&=-7dBc1&&\+?C6W?_
Ha,bOCK00ZE.#6cR8Bf+bT;CIX],bI#;\HQMN3H<bQ[)AB^Q.@G.@?D[)QW=M4#P
Zd#AC?LZ(,)^F6L?U9g^S9I,283d?<b,UE8C)BBFYR<Z,2+_7(+#JbYKC#<GSM(3
bLcOW[2QfAI1A:?_Y,-dXWEDg21=CK])+>BI7WJ[#5E]GcO?QUU,1dTWgLBdaS42
c_)C[4Of<&O:7&LA^Lg_Kc#.N:ZL284@RD_=ICIC^JP=eJ]_(VSM?;^9Z<bJ_(N9
bCbV>20gB,JY,I,6]96Q=1Be1.NEQ@Y2GJfS:^(+=N<=dQ,T[1dV4WWYZfO2EX^P
a\)DF5_S):7fc7.[=Yd>>V.S;8Z3M8@9/S+SIJS0L-QUP2P+E&<,<37C05YKg#LF
[CW6MX_a+g2J/g[RRIAZ&-6?5NUSI]\\Y=7QUS?2GIP0c5;PT>DgR)6L51@f&VfQ
+c@,/e@,;Y3MadMXJMfL/Xa9RefD+M#W)^;,<>98[8:./FNNU#]>bA#-[_bLYV,X
/,IOHFK.^]EL:I7K^P0F=X\Q^7M4JR5XZeTJ1dU<-+^+?LZO]?[,8K8RN+a(&@XC
G=eXabRTBUQQR5J33(2867?[<FULbdEMI?,FJXGDTg7WL<I2W+)(3XG7dOE?QN-=
&QIQ+S23UFL:V?27)ILUR2=ecUL#U2Lc83C5V8O2\51MU)V06NKgc-@aPg,UB+-Q
L3[8(TR_W=?9bfOY5Je7H<;\/I^DMfY^f5W871IP]K.FGA@.fIRZ)P=aOWEe1aP7
T#4+C4RV#?d6=;/.H9E=4-Q:R72I5/dg0,;S/Q^-:bc+fMPe0&3fd7Z&FaOSa3P7
HA[T;#65SM/94/67;[=>-WZ7;-8]LC9@T78>\DKee(HE+c0,>F5EOJ]@,<L(2g-Z
U1RDf^+#)L?IdYM]6NU)2WL)HUBU&YE_;1A.1JPFYD0GR;GVG&BEOFc3,=>a)2.+
2#WAK.R0gR]ME/9fZC74C?Le5)@4PH_R+X?K4)U4E6V=Z9@&OB+V5TaE_[[?-(G(
&/F-4AcAOXa8>AC(J)CgOY&d;@Sg0Z?d?dM0FPX8_((/Ub>G(9V=eO_7NRT(7C^:
^YHOX.G<KfTeV@\1IK:7e]&>?SV;8I7fNX\3GK(OC6\+X_#@W7DE-TTGU>NSdfN]
C=TNWbJDZdZ8&Y/XWG5S:S8MC)P)_:RKf4\PQ/QNS[]e1U+;K3cVN8)XF]HK:E+[
e8MQL4Z-g)fM<dF_Ug214J-P1X_eE7RV5ZVg^],@TX#f76NB#JGOJQSK,^@JSc\;
S)2,AV],IXBJ\?TP_f?W(&c<H,_KVU9a]L)R>bI+^[LZQ0>G-8THb9D?RNgf2:6/
,(G?8?Y4b:)[f/+CY>U@Z/:ZJA>C]##VY70KU(2c#?-a,g,Z^5F)U2ZDc3HO<3JN
SH7?&IW43A7b8/)#e9_AZKPIT?JEF:33<J5/6K?Jdd>;23[aTMgS1&16c#[DMPXQ
XB:#?V-f@Vb#&DTE\-82#31?NX_XDVe0&BYcf4>2&^,17XXFPU1,-McbK33P>4cY
G6E:K=^[:7KTeX^Fc)1,HENHL_FEfBILa+]6R31#Ee>De8&5IZTR,9+W4e>_-^XI
Q.H91ag[C21]^KMVAfTd2A.K7eS,LNN=BJ1^@Z6@)4M([Y#(HDe8.;/.O1&UdPTS
</@XQUgA,J];T2<66Y)U1-4#]D33,fK=cadf3M172T5RJQ^7_?4Qf=eN5<N;)U(A
L&JF(PERCc@H&c@8E,)NG2:0J>JSL&]NGUY0A,7@I8QT(<\>6D1C>2Jf7#&3b4Z/
6NDX[Eg7\(FFe-6^H._a:g0;:2-OODDPe^\:aJd3gXO;J7[X[gd8dH[049[@>G40
5LJJM8<)g>71ZD>.c8GD&0EV#R>U>Q2NdB+PUdZ.f-]5X-HO?8&&[U?5_Af7G6OJ
&AUSBbZPFG5J;U+]Bcb1L@6,+A2#P>@eQ7bcVVY:f2DQca=C8Q^eCA3NDLA+J?>J
E5<P:78d[F#1]2YB^b/<W]6-G4Ed?;T)cL/PEVD+Rf62W(F#X6d=&N#&(/8Ue3P-
N/VfG^.P3GUSHbCDNLI2.I3+EBQ;_&1^W3(T?T6I11#@>.7A>Z;S#3-V+Q?\#eA-
.CH6EJ1e;67Z:3UDC;]OG>7eFb._=:C_gC94<C)C/b>B:a+_(P3GDS6LPYXQE6WG
)a_K+3U7U>8fMa<;BK.E@@O-P?M@^&e?G^Q<A[LZO#V:Td+O7+f9.K,G23C@Qe-\
9R>e-8EV^P0U,DLA(QeUGgYODd+JN_T_9,H(;W#=7&3Y=E(HU<6??8&aJ=Y&NS7+
V=OSGA9:9&JP.W;9<.92K+46ED.IOQOAee6#_aTLBS)?WXBB0dR_Z;2OT[bfdOF)
&DY<5#_8D)J\K8Q\CgC]S.;b[0\?XPZ<6>6]dNZ</O<ae@f7\8Pf+M[b29LdL0R_
Z?ReBT6IdKZRXeKCJ-/5bYTJ\=IY.c6(.TJ6EF+R18^X.F#dE0VR(Uada5=cc0I3
^ce<S8X)dLGILAegI-caIb6O]U5ad9B1Ua_5R9Z@Gc2+V>[gH17__R#&D(]:7]93
.B0V>3?dX1M99c/g9_ED:<@PPef[fQgO:3+-UDfVRJ+>?;<g\d/cV\3JFDG+D2I^
PK&26JQ)W@Y,N]SF_g)RW^Fe-Z139((25TO:>><d4((<-:J6R>)a_]K/CQ_Z4BeS
\2C86a7C2=GGM+2(4>[O9S,X.;--9LeWS4)(/cGE+5A4Pg/;V<R1MQ/.QI5NX<d=
;@a\(5f0>_,gG43f;OB_51-:^ZU[[U1YY73:43Na5+Tb0IV#I9A=6S+<-J^JCGLZ
>JVUVIQ\F6DO4[-;ffE&g8ReRTCYB7ZW#BFO4I7.E?S^-]8^?6<JIf8HdU[#]B>\
A(JXRKNe,IER?_;EZ.+RQ]OeaMTe9@&#;]XY3-;]7eNe2&M_+M]Z/Y3>]7>6Pd@6
,?U]F2TBK5@&U(2e\8SU-F-U6+;:?D;CS(W5&<..;.&YN=44-Ae.I0,QC285EZX1
LKc)C[,RX#L;>WSg.gf\](6_Dd:-(g([M=Z.4M0Z,.6:O-:6<fMB9CFV)W=KQ_2(
efBAZ,WF9TZ,T=FZ9BeH1f>&.b;R;bT>_/Ef6YOVYYH&Bg-BS-WO^C4]IaL@]b@(
:?QQf=NagAG#T)=UKZ8_-3E?]gg6L[1?,ELOD@FYJM)bAa.>RDK2V/HP4#J]eKSR
U8O<;8d6>;AFT)D<b=O+KJ79@M^c<(/,e<)G/c+Re+ZZHEKNc_D7/7QG5EMO)H8S
^d1DB\ggD07K+a/63dJUO1K2@NZ1FT2?f,9_KAb=]BWN^gcCQE78.6E)BCDY.ES-
dAD<(+>cSI5bQc\=L/d6cGf;A)9_ae^YXPKM.BHM(OKNX>#EZ>E17==&d=YKE]XZ
9PJ;M8-TYW/,HE(+/G6AgG_X(:NUCOWU5.4#X[.RM@NPeBIQf9SEBfW2T8[G/O03
S#SQTK(5@AJZQP=V)&V;<&0,NOAO6eW2eN]1?1\(D@c8U.X6DE>T1fBBM5gR&c_R
f]F7BDK^9aWEfYUR8ZK:EgB+SZ-IOEV@D0#4I-[?g;5A>P/MCEgAQ=bgD7.OAZ&<
1ETSY]BZR-AA;g@KJ29/g:=C]JTT^=NgP;2d@]4?-M;?L@S[T6X??/8Fa?&;X4d<
,+BaZBLSY2\0/U,=N\Q2=:.);cfF),.CEAKMc,<>:HL_(NGMG4ES,EDY#0bZGDLU
&B&/,W77717.Q9^f3BfeNIX_-_Kc+NCN2b8=_<RT68+3>dE3M;,4LH0L@_L36,R6
ACQge#Wa=)UF/.;F7gNW-/YPMDD>=QQSS_-<T\Q9F.f<[X9P2_bNB-;[K]-[15H5
Ve)K[?#cN32>=KJR>5(GB^>>O(4Te##B#PcC>:M^aF]G_4f@FL-DGAZI50R[>/,S
;>.K#SO25M[,6f+>?cN52:E6<6#gV(Z+W#94C97KR;@dJJ_CcT[WPADcI5KA^b0<
@-8Od::eX)-Qa=V[:69]/NZEKe2K?:A^0_MKPDH+8[J_TKGX[:0R>Y8Z^_3&2+8,
Oce,&570?fUP8Je[d(W6^d;2U5TP7U@-NQRSc:_U]86^1G(f;fRQ8W52bRZI1C^5
DFfd(g[G#Z:c)8)\5[81<9EZ_De^K0IN9I@I?d)?<U8IfQ8H0[\1EZ,W+^;__[?M
c,\B?-/V:0@BSKaaV2bDVK#eHW^gWK?I:$
`endprotected


`endif // GUARD_SVT_LOGGER_SV
