//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_AGENT_BFM_SV
`define GUARD_SVT_AGENT_BFM_SV

virtual class svt_agent_bfm extends `SVT_XVM(agent);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

`ifdef SVT_OVM_TECHNOLOGY
   ovm_active_passive_enum is_active = OVM_ACTIVE;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;


`protected
J:D=g+,O-B1bPfB6a8UJ5+#[Z>O[\[Z<eV^W14HDX<>(<+#W522O-))gB08S2Q;L
b,-&Ge\S5b8>_7[9A+KN<c._#5^g-@C>I,\TEB].VNWL/)Y5D@&?&SKNIRHNAFCa
U12[d;]?DNKT[5.VVRHH_@Kf+]F;+OGdf#U778Q.7#IQH=NHfI\@=SF(B/4(#AON
G&1Z&B&._2CJ#B<8;BJeO\?:7WM9..>HV49[J_<+<I-BZJ02e(),=+F(J$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new agent instance, passing the appropriate argument
   * values to the agent parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

`protected
L+,aCcDKdL_Z]9?93VRRQ2DI/<DKB_>K<]F\)I/.?-Ve6E_GVaO3&)MTG59>M^DZ
S2E-+S<X4/b3X=8]f..O+S2)]QCbYK0e(ZN2aU/C<8d6U5+_CMdLN)T\F2;GJY1>
)J?35V8_-=5+S4gRDU-F?<44bGIS5<eM^9^LS<Q]0HU6D$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
ZK<V8#QFM.Z&?8c/W>(Q_-6B@8@VSM;9\9GK1O=fKAK\#1LEG0S<2)8Mc:NMLcS\
Aa(ZTg\eSI6RYDUQA-;5R<+ATP+I[ZU&J)3-Tb9WY167LW[WB0+S#,JMNV:==8&_
g-5c#_0<W<.R/$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the agent's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the agent
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual task set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the agent's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual task get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the agent. Extended classes implementing specific agents
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the agent has
   * been entered the run() phase.
   *
   * @return 1 indicates that the agent has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_agent_bfm extends svt_agent_bfm;
  `uvm_component_utils(svt_uvm_agent_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

`protected
R]_g8Vc<&I;eW]>9UZVdLE=IaUGI1@RY4dc?0J^&Y<ge7Z)/SCN0.)<GR2-5S.JJ
\ZBT\VCbBgeFeJL&6]KZf5Q35U-E.X(Vd\-RLN&e.#^X0;FE9g9H28Xe-G0N1)4d
M9>7>a5HS;]\#8K6Ka,KV.5@3[.U-(__KZTX.ENL5P2;CSQ6-@#dU@#=;AXca,<f
#6MGZ?_Vc=_e&G#9+G,LFYcd@20:9).E2e&=eEeJZ^;A,8)(Y&OQ_6VI;KZ(UbYT
/C5H]B_I&RND@G1CQE\HHD<#1IJ;SK3GOQF#]HLL;g,@;.PE4PPbD<[UNSLE-4@=
#,b&S+?(e+:f?)\5#8aMKMd8.4]<L_OF;ZX-N]OBQMG:YAJ<-G6I8<(L-ASV)55)
8DH,D)dITcgb)d6NC;TgK<ND^K3aM@<4GR4Z=(YS(R_]-0D)[bM0DN1N/C6H,U(I
.TNF5ad.\(HP<+b]OS,LG/g8Z?O/g9VH8C8_\?PLV-#fe\82.9Z7>e^Qb\?-8fb.
K7<4RZ@QZF<6c)[#\1Q[/(H[]Mb-,C)W/@-]8S[@&c9]f&6FdY,MeGJ^6]f8\S;;
=\1#.HCAgN,?CcV0#^-YHc=>NFe9LE9L:A;d>GY3178,-@ScH\[S_X9VR=V3#8H.
T:@T35_72<gA(^LBX5cc;=g&>gf#M;CTOGZ_+)X7Z[0Gb?g759,A\FaUWKg<\Waf
,4U4cW;eR1.fUH/6WI#QYW.CF;Of>P<JC,3?^)KdCGdR-f;(:(LaNGJ\H4f6&O+W
E&RFIW1KYa)E][6==IT5b<ZOg,(Z<a.a-.NLU;Ig^f<#08.PTD9ZG^/SD@gEO4YL
=Q,DC>4^04?g?C9QcGB?1IX<P&6(#5TUD@E53I(0\SbU;(P5JaE<E63=dJ+1V[??
1=,>IN>=&G2,4(e:]UUGLd)[gUJJCDIeI6eCPH(>300_a+U#75^.ITBD2Q+[\Q&J
?2Yd01&)a7f,+:(-0E3)]PL;82Xf;d>(VU/>/LA0Q,UQa6<Q6(.TC7RJ7S?NZS87
\_g\(gCEC_1\J\c_CR:477<BY.8aOBL@eD,??XcDR40?a,O0./?(.BM7fD&=7P-W
RTB+/A[-6#Q8F<9[X=Rea4\>f[3DZR=V5A1>b+e#56C8#KfA^SD[);]<D@MXT;<U
R=C79gKH?;<+\;7>^^P[^g5;Z),2]U-Sb\SfF02fF,1>&=aV&XPTFU=7C+XXZ;ES
)]I24P,/HLgW#;PAc6cXIB_=8gERAPb_S\TV1>93IcE6b^f17N3GMb:94O,CWA;H
_Cf,P8\+OLGM<++)-6B>G4De5#<@GG:84N.I#.11Y=P_^,b[ZI6E0GFBFbJ.L^fE
ZF-M=(/@5TI#L0V8f2CG^B=\b2&RXH/N:U?Y+cgIV\M27;df><DP>I[6cTLga4>0
a/M]@gKBM^SeKgJ[;E6gJ8KP+#@dG3JM#@9?;]:^VX=TJ-Z0T;G7S:]6,0/Gae]H
fP::81[^Q=E]>Kb@cIWd<S9UBA7aJfXO#^Z>G@@b8N7:11K[,fWD>[WT9d.=#&7c
H#5M:fUG/YI.XBF;[5,WEZ/@38EFV?CWOdW5YZ?PeO#&,GX,aJXScRfa@=1@-_2E
3^.C6Xb&V-41O(d#.JRBXO4-VDHO.S:/baED>Q4C)==D.+A=@GVWW(gI^&8&P#15
.WJYKf]O6Mg^\W<6KLL,<^g-XHV8:Z^:X11b^9ZPF(ZC)1PU:bR_V40)K2O8NV=9
PVX_\P07^fZg/8&Mbeb8.T#GI[3E@VQ+GZ8N<aL?QPdP_A^G0_+H;SfaF6F[F7ON
.F7JL+.:Z,DDaWZV@>S&(f6^-SH9RS0M1T\I=PVY[-<MDPgdd3fM?BYR17L_^/UU
H3IbXc5If:e(g3fTEeFU\(aaNICCEHc/C)D.C3;CKP>DVC(;eTe_I<-2N=P\/Efa
/KH0+(3<7U]PeVe@R,]HEYa6M54TT0WAIc]5Y7F20VaAJJFZCZTKW&=??_0/eZ<_
]X=@A@b&;RCg[])+Q,3_fY&SWb>IFQY+H+gTZ9HVU[77URT0/5><MI:Z.GLO1E+&
&NOaRZN)2K.(WNK+62Mb<E;>K4+M7Z=#+WgORa2a_J@V+d?>#;ZBMe-CHB594c+W
GE=W8)M.:H3=Q&:-1&7D#FC2;WNJWHg\>HVS0g/b6cFQXg03F+//3aCd-1?3#d->
7.P?=MEd4@f6]\;RZ5.^4T5>-?6P1X::0V:5FRO.C:\5:+^JaT]F>TJdc>fgP\GB
7K[@OaaaEa:M=gC-7A?.;Nf]O[HZYJ^4OF63=J25X6gA^)aU<(@^RB3A@MB3X@AX
2)7\O1+(2V:V(8e/7_:]+AGR[d]Rf#:T+@.g74<C9Kb2_6_eI^6W8YPFRL@<c#E3
Rc.XUH2MJ)==#0+_K,\b5=X;(<eI:WWE3<FE3WC8#gSI8gNKN<S\/IQXE1G>_b_7
W-B1_\[O.Q>F8D?R8Y=X>=U0DEf#+a>CPg1.G.K[UUW&N@,9R]2YI82S<46N9H3K
?Z\)B(FOKON71K3+U&B(E9)gGOgEP3#)/_()XV.B^g9=gN>gYL&GE#U(\Xg_fD5#
;_#A=?+(^8LYAG[ZZcG=_--3eTEf=ce5N;Y==7<b;X/)&/X]>J,a7LJBH(?3.MJN
X(4;XD_c.#e];67>HC]@f9>7>Z)JX=VCTBT2?RI[SB]fbMH,-5Z=;\=QfM5KXA0C
;[a4]B^gDC5HbaG\-F_BW7HV_Ac-?BES>c[JZ^<SZ>b;M>^??Y2IE\0+84\AS6+Q
8=(&:&EfdCE,3N^?)28?9\/.L/V)243F;0Mge&^)CU+FbI50;#^bI#>>O\28@7[W
\KIbPW3I:,CG5+V2W3-ZN6f]fBFX?d+e=,@-C71Af-XC0V:1aQA<1)I/^?]JQVB[
<APd#TG?#<bK4e,>ODd,f;>A?L_3I2GYW(ZKLJ7HH-,eCYUN)7:Y+5BR&M2A:CJO
+@RdG>EKEbd,U>DYWTc]M4=:6/cO]G0#4G0)-/E./eKU(:FFfeD:bgS62#UYA47g
fJV5_U])=Z+LB#Ud\2FR@_Ye55D\96I=@N]PMMYD=)@aZB=#g4??KEPL.)9O)g#.
>5Y+Q[7B]5NC0+?)1JZ-1/2UfEB\R)553P+eXYX:+_3]W>N)-RMSa;/8[_.JZ20B
f71G@WFBA-V>\]),Ed2Of3f\WOgX9Mb.gLBLR_?I^];\1?91S;GbD&T>Ka2M&<&,
Z?(TLX17OT(_3NKP=J44#UK>9NT7\/LH1FQd>DC80A,.[5E(Z4fZd0Q0-=P=-g++
>+-ZY>dWHGYafG1c/A[Xc+J1=4X+&e93a8QDW025S:FAR3#MH>e^=bR<R04=WP(+
-RM?4VIWIV68FOOQ+gT;L8OHX6.QT3J+fVQ6,21UZbBIT1K?J_e;[WN4;,K-/^,;
\e,PW./PL9IP5@\E7#YTFFOYGYgIH1I[=/T1Cc#;:Zg&II&a-3BJP7,]]QfR&:\2
M0aW+#<Z-IA&W9OF:_=&6K0UPC=f(JSfc&LJb/9T#g&HMZX6OG#I&M(8=DAWLc3I
.Z^<>P#g>?KJD>I8V^58E7CS?a^#EVI#X/26R)g+31a6W2g1QXabPBBD5+;>)&C\
HSg2g[\V]fbagJ&EE;T<>)+8^7/>L5BgLNgOeZ70R:--9DLZK._X6TDDNY?VVe^7
([NHOJ4#.Q2aMK=?=e_,eZg(\ZE5aDaSW/M<0b.FW)Y9LW&E(;N<VL1dc&?;JJ>E
2O52cT_]55YA8Q6bNeVN-)K\KY;e?cV8MKKb?ZdK8_8d)+M#[38EeIg,ZaQYg(8P
G,L-<VY()1PBWA[a,Gg<U0;EI7&A0dO_Pb-7UG-VS2J^GSPc0-=>L1,b0:^=Z=\R
3g3+07aB7M_78]gPe+d2=ZbZZ#E[)gSK8KQCY=g45(H)g3fA.fVc@+&&Fg?.8b4]
O1->dcP,4NeUMeT(fD&bAY3@I1ABdb^4G?EGQ-HFSHcFBBNQ,cb.N^&cL8KTe)[X
aAYHT&#XCU<>gDZHZD2+9V(#U-&[&cKP;PPeJI5bO01KaOC6Zb5BR2Q+O0=a)>18
Q<ZR?&:3f<UE?)IZ9f/V+).2HPRJN).16LA)FSZ./DAU8IV50<1^>^\aU0DUG)3V
L/f5CAC,KW-=QX0M&KSGb(1UWBUOJ@AG63?)N66;#5YZfVYF[^G/^./d7,aHP??O
D8f,H[84ScX;4ZDaS9^KGGD_Mca)=c9f3X94^M_1B,#X9f3>dNK[F5E\^,96?+K]
cD(E3#33KYegac0YG5:S2DeDObAWJI)WaO?LR55+<;(4Ma[BVf5@-D=DK9I4=EQN
>/0Y0G<8F)39f;C.S)Y55G^5F/J&D(bTG=[D4?2E//MIQNgZb7R?UBEY6K)PLA_N
;f@8Z=-Od;gbY2RgWP1JS_?[d\AA#W8]A@b@gP)abH?L?ZD^)K0RZbPWKP[bK)5@
/53P^feWWNb8a,dT#TCM;Y\8I.MdP1)ZA[Q_BZ/UM6D<.]8dd56<0PD#3\8H@91_
2J?GEVI=\X_QF-G0);LZB89\3e\(4/Ab6Lf,(XR>V_KL59e4>6AUQ,cL30U<,;=M
JE/=-)PJV8_M#DMZO)a9H\UN/Q;&?_=GGLec5AWXF[C4Ng:#IGC0.f,Sd22Y(M_9
Ic9JEcda<E5-#HZKgdJQQ95S;U8G6UVUJK2V:_9TO5PR155ScB#Geed7@HgOW4(#
X<fgO0@eH=-@B[#_#9&AF39D=A^Wf(&c7GIR\RNZg&_@Ce29V6,g^B=K8\KI2\Rf
-<=F+WA;8L5I;03b@^G_7I,11@65&,&A+<bO6dFN7?fWL#&>L5eR/X88I)B0):B3
N&P7AKcb5X\.1LED8Qa5V5D&N9HNaEQbE7\N)J]aNBE4W)=g38P?YQ7fHM[3++D<
_V3,dM)50-aHUB6P.I[)5cROE-NQ[1P,a54R,caU8@e_4KeXN?J3NA2GSZ-XT\]G
2/.B[^BR7/d6V:LC+QALXT\WOC_:fL@e1b5a3<gIG,;R5H:&@LCPA@FJ=e[aafFC
CR(I9[6<<(+F<;_E)\-NP2S-GKIUCe_>/&O(dK--5-I.QMLeM[Bb.2K)XIbKJd=5
A_>W7N(&8[0A+DXNN<d)4N+OH4\aUQDHGP3Qdg\7FGEZJ]?CD>-.X2S-[SK\IJSf
)e-?P=VYCKI1fa<3H^.(UDC_7&N.SbO+?H_^AYPa16+TSb:F?VBgQI5;W0DW#EgC
cNPbF:CHeMN-A9ac5^UZ,G(S:I7M\Y#T4OYeWNga>fC82L@D]32WZJ.Z+M;S_?/#
A0aWQ>d52#D;P6,_,N(<@04S/KWO:=0KRQ@QY-ZG/Ac(./[d.]<T&gXTSc:[d12g
bYST6L4/G5[ETF;Rg)fYe:<B2cfZ]\5?f@YH12=W=Q4#_[M+GAH?4T2QFH\VQK[,
/B>#CaPg+Q)A7,8#]LL?ZFg<.3VZf9#VGHZ(VDK0DTce&/2T?NJ@D:>YBgA,878=
DLG8=\+KP[7/2Y@8P5LH&;BVaXRXf)S1VH^VfKUO9R.R_Vd+#R#P:>DDg_1[f5Z<
Y>_D+G-8K-3^GGEU-]H@PU=5#3]ZEPB2?\K7)B#R5;dMaeR>MbcT4P+PB=&OH8RE
7B4<>.f83b/26#HKGgG?=N[TQ6Xa>-UN.F3X<CAI7<L@c?:Z,AVHB+TgS4GF9fEf
@#,?T]Qc9c;b-BV)LLbZJ:0;fDNHD1JFH<6M)1<gTgSA[Y&-F6X;O]ZV?&ZER7.L
6-UVYQ2MRbBUO3_ZIP?=ZHKQCH\TZMEA]d=K5?R#Jb_J(#Ef2:RZI&?G@S=,eGRM
<KWGE#.cPGC6B>H88BJc\?#_)K4P#PW;+Y)3d#C^(^c[eOKJCVSAJ1;\UZ;)5ABE
73FJ>dQc[-F[?[++8DA>]-<_A45#aH;2;>VP)>#2D1g+3df^Ua;:8b5&[7&/]K+U
PN+Z?(\H]KV50\7+B=Y7=(<_8$
`endprotected


`endif // GUARD_SVT_AGENT_BFM_SV
