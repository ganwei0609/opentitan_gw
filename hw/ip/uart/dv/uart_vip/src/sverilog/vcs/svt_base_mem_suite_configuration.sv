//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the base configuration 
 * information required by memory VIPs. This class includes the common 
 * attributes required by top level configuration class of all memory VIPs 
 * (both DRAM & FLASH). </br>
 * 
 * For DRAM based memory VIPs class #svt_mem_suite_configuration is available 
 * which is extended from this class and can be used as base class by VIP suite
 * configuration class. </br>
 * 
 * For FLASH based memory VIPs this class can be used as base class by VIP suite 
 * configuration class. </br>
 * 
 * The current version of this class includes : </br>
 * - configurations required to add catalog support
 * - configurations required for xml generation 
 * .
 */
class svt_base_mem_suite_configuration extends svt_mem_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * This property reflects the memory class which is a property of the catalog
   * infrastructure.
   */
  string catalog_class = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory package which is a property of the catalog
   * infrastructure.
   */
  string catalog_package = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory vendor which is a property of the catalog
   * infrastructure.
   */
  string catalog_vendor = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * This property reflects the memory part number which is a property of the catalog
   * infrastructure.
   */
  string catalog_part_number = `SVT_DATA_UTIL_UNSPECIFIED;

  /**
   * Indicates whether XML generation is included for memory transactions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * transactions on the bus. Set the value to 1 to enable the transaction XML generation.
   * Set the value to 0 to disable the transaction XML generation.
   * 
   * @verification_attr
   */
  bit enable_xact_xml_gen = 0;

  /**
   * Indicates whether XML generation is included for state transitions. The resulting
   * file can be loaded in Protocol Analyzer to obtain a graphical presenation of the
   * component FSM activity. Set the value to 1 to enable the FSM XML generation.
   * Set the value to 0 to disable the FSM XML generation.
   * 
   * @verification_attr
   */
  bit enable_fsm_xml_gen = 0;

  /**
   * Indicates whether the configuration information is included in the generated XML.
   * The resulting file can be loaded in Protocol Analyzer to view the configuration
   * contents along with any other recorded information. Set the value to 1 to enable
   * the configuration XML generation. Set the value to 0 to disable the configuration
   * XML generation.
   * 
   * @verification_attr
   */
  bit enable_cfg_xml_gen = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_base_mem_suite_configuration)
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
  extern function new(string name = "svt_base_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_base_mem_suite_configuration)
  `svt_data_member_end(svt_base_mem_suite_configuration)
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
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

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
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /** Constructs the sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
endclass:svt_base_mem_suite_configuration


//svt_vcs_lic_vip_protect
`protected
AW;FTHT8ag>X2e=R<@TgfEag\g)UFT3(7;2)&g2aTM\H@@?OA[#a6(;cJDTN8B2G
REPYEOWI)6BZBKK<(O.KY#RV3fDD6/Mf?6=T(aK^0V/@Z\f\4Y9MEZ<0aaN[IP@S
M0ULHL;NYRN(6^X6AA0<1:VZ?(CPH/)&FD-e^7KTG)eOF2-ScZL(fAaN49FWU>+>
+PCB1R5#KMg&?RY]1Y5RMCd7IF@SQ+a5b3bP.+9aa&=JaOS-/DL.c5WD@a4QdIZT
V[WcY;@HBgP(XO0=F(Td?,SNXUHEQ1NT8J4_S=FZ5U-gNA>^GO8E0Z[#9H8TLA]c
aZCgI&6X<>S9E#ZC:_bc2A-Q40>2\FcgIcN3P^-e]c(C6(IfD>6N=a=6YS^SF;P,
417La9A.A.a\Y^=RJU6;[&<2;XAVJf?VcLG;J2:df\R9E2]\K[V/Gc)-AEKFaAKC
.ENFQSeb2?5EJA)4gD_3Q0<A[;9-9fKb5QHNcJIC2?4:2HA&MR3Ef8D+M&g::R,Q
HB2KV6V](XX1983d;JX:KMJ@#._1NV.dDIN,=?&I[)>TNNfgU]S;SeIcPM(YEDS4
bOd\0Q\CAFI[aE@Y15-f;ATLe&6LC/88NDdS]R@BgU^R#\[f/O(#:70]<]V17bH.
Ja7@M61B[+7^@?H(IH4LG0D287=-)^TagD<.T34d/+B;2S50W;5_K3CXB(]V1;Yd
+GR^(S/?,c?+J+/?0_&EbZb@<4Sb5Y(S#>)AQMeY6a0AD)#V04EFM9QE;WDFa>YS
RZO;_CJY1ec4[PSO/E+cHX_SSRgU9S1A6/&;]dK).=OfQ1+ZE]VTD[E2WT,UNK)G
)eDEgSAONW?#dN<F(J<aHCJ2,]@d,],C7J3QZXNL1e6aT6(b@DD6Q8,5[KXRVS#[
#J53M6G^.W-2?-.WKe8B3e+4LESH::XU.#IQ:-@=<f.c90=7H/V_NQ4,ZT3#I#?9
KcWP[(KDL&J(@:IFUdRP\8RWd>7B+UMaSKO4c&3HbLEb>WV:-#R(C^&cS+ZT,)d^
8LH<P>,4KcZgZ\X,1<-7.eT^-cDWNNS?-=^fH:ZAUX]?[b+R/_D:d#C?#9P[Q4dR
<eF7I1)X<N3A0d:Q:T0a>:JB3ZF2U9:+SJ99IIPLLA,(F]O6K(RIQDMe@RWOK1Y&
d:JAX[@M93B2V6(ba#;CR22Wc-Q/CN@R9GQV&\MI.b(dXF:a8JOQb2G<WF5^GD?@
f(a2bMRJaJO5U(P[_^T.b4[&LB,K98f+aL_b4OdRBG/Z?<M<W9U-1eHIK9.4X?PW
+^UWPgA8X;<3f8+84(>?W:UM?S2g;97AS\=(Q4U=YaIFH8(LfK^?6P.B.I1997E8
f&,bCQf[f)WQ^MFd)\_Ifd(GW2\U(8P[F_G4B7N]HXS5,>/LE.Ed2#O(OeE9R8/R
RJM>@Wa,AWFDa(P,ME)eL+cHT+GggBf^82+IG5)/fVJ3^..YLQGD;GcK=3B.DV&T
_9K;2R#ESYK\XNe3M#SdZGc=+eB@+[/I&1K@_JcI0+1BZ,#WDT_M;6G.fJT17Fg9
+>E3=0<9[TK;O.W6:.M5S;/=@VP[gOCN1_<08C7&V;_FcDgNc)&Db<&-3RIOC@63
(K7.;E:+\.3\B8bURN69gdb]P-P&=8dR@3\6AHRV8S.eDN[5J(bbY\Q^O58?McTQ
aGAES-03>&C76Ab&?FW^0O<BA,6##0H#a\^2bL&(BeOIBB[>=.cV6HWAG;DMSDdD
B7>VOfFdY4AX>Ucd\@@b,2HZXHH5HK/cIL:>[9ZTNK59MI0>YIE]ef;T9\<42ZUc
[^Q.++Q[5;_?B]NDD9+ZN5XJfLDYe]-B5eQ7(16^L4R1fK.SLc79JCI(V3ALTZCV
UO/=IM50egLLTE>cM(>3S3=d691=NeE#QR_T+e@;bWSe_;//WV)LXU]XM6LP84T,
82:&2O19T#SdgK>_P+ZS9Dd?HW-N:Yd\O2U5gVaFS@-:</Fg/[>cf31]2-aTJefV
H-938_I,+NJ7J5A3^=X>(YN_8gEY/S.0D2]KgQKc:9[AaBZFD7O7[SE[Rd:F_aGA
d)F4(B&-QVJEXb=QFCXNA[OLQ7V)d>_JOJ^cZ]M[D4LQ>_,\[GeG6_FZ\Jfb8G5.
G3@a#=I:1N\gSAK>4WRf[I?=S;bPeFYV-=EZ,>dbG^J\&S6\X)XU3gAD;T/O^JK<
<>Re)cUBCWR,VMH(OL8g6PD+0Q<6A5<I5L5_-/Y8+9(2T(MX^LPHD0CfN_\b+FRY
-NL)W5+)aE<#gdb5gT=,Ud78HDHf[cE(VJb=<?<=f@eZD47[[Z58,IV/&+Jg#ZE[
C7Z=PL3GY<4/NJ<SC,FN0S]+^=+eT:TUK_-6:,aBa&?X?4L?KQ#6f7N#7W5;;g#f
f\VM?e1T2Y;A&L.(&Pb&)2?2\GH:LMH[FZ)G9J#&EC40(SILSQH3E;H-;N3ZF,Hb
F9X[[4KMCWN/<23/@;fYJ_c@XXPfOE-HfZ8=7LGaJSb.J<gWI_V^88^g9U;W3X4W
dFRFK_P?X7(D<>f,5&L(Q+Cg=P2TgMVH<RW&NF48-6Z#2a(:cPd7e4SY#2U@>1ff
O3SK+KWHaUXaa0B\0Q5Yc[1D,U;H\gC4;&T#[bGUSfJ)S_OQSA\U)_69?&?Q8bW:
6>5J]X>?1dCL5FZU?#JQP.+/cCB4+H->B8SER:Af+FB/0OHN8&)2Mc-Mc-^<P-I0
1a,OdbB3:6Wb2fP(JRWII&Y/[VeL)-I<>A&X8=UDSdPM&NLJ0.HX5,&N]F]JNd9R
@)RL4dGVIYCf0/K&,2#@DK[I;_&+6g6C:;Z.=e^V(4ZF4fG&+Q#A<bDU5EO4KZ@?
3Yb+<\8PaJOHBbKfNgD27.4X]20\MA]EW>Lc#42MZV;<HA6JT0XbePc,fT;@cfLf
a/;G^C<F+60&[\6e7_gW92bO>ZR3Qa>9[eUedd;6,34?BAfgP3X7HeS/(0?#A4(1
]?I9_RJd-76f,E63@2XT7]NQDN_&A0QA[.A\UZF-WP<;RaC4RB73DeaA:Q^BR-TO
G^6U1+EG([3@K@<<=2:/]PV]IPeJ9\OF^f=D[:bKV.4N5TE=JWK5G(ALbg@E[V3<
g^1)\Zc<WVC)EFeU#/S?LPNQcNQY6Ne[;4MbX3)[4[Z?HN&=YIV2?f?e=WKV7G<8
;;NV06Y2I.e@M5JbF3ZNQcCL_JI3eI]dBTSNOGG(-5c(fN]1f#,ac(d#14L-.8:e
a/985e3e=Q7EfZ;[5BX@2P7LZ]JDgeO04H?=?MIVX;NNXK4D].X2<Kb-Sa?gS?H^
_J@HEO#Sae\f1Z5d:-)EZY&[[+<^HVYM/fbLCUHBc]H&[+TGeXSN-+JS>G#62eLN
7QR=U8Xe0,6@b?N]>4_&CfKL9^J.^:HRZ_gV77B(7C=c@d1&9,gIeAYF;L5N2YgK
.I=6=g(>POK7NfgH1[574/P[@Z-[1CX6)Db9\07c.K^5[ER^,-F(gOD0-ID4cWA8
[QJSDbPSL19BH\fb(&I[MVGY,)44\R;d^U4)7[_^A0SYS=efX(RX/:4I4G.Q=8^B
I_?BBY(VadS=QbB.>cC;Sag)\D;1D\+4fF;95Q-dX62[&SW0XKMR2#WW@SX^DC._
Sc?;4DLB^1Z-;Z:IRb0bIT4)+A>cBBW(3+3e/.1NV?O;6)EIgd^\RN1TU-g_2WS>
[TDDX)CQ+,BU5GcXSMR+KV-CNBDQ:3G6-:g0FU5OBP.0(Ieb>b73,_<_(4N&EQF_
WQ1e+W?)@P<=Zb:&FSUJ5/F^74fPEbWX/a3D(TL)FT;L:6U/64eL=MA/2cFf]4Sd
(Fg1,b2/dZEKdDJ>MOU<G?gSab.(ffU:d+V5Wg0Qb;^aE_Y.gZ5C(6N01L[bZKX.
3KXG)\=5g4M,RY7_ABKQZ37393\Cfd=&Hg25CM=g(cc6c?N#.:HK4ET9UQLE6T[3
#&,W_Ha=\[&[1I.J;C.RYCa7ag2DC^TcSPPIaDV#(8Oa65]L\11/L>UABV32<6+B
bD,K=)_^;FC4][O]gSV5SAAYe7ZFgQ.4S<Wa8(B\YKK/E_;g7CW)=IJ8P+\[J^a)
fKd1:KS^fY.2_SU=KC\)-LQ0QP3U0NE5=]#a&W7HS^&Z5a]+cOeH3fVZPHMG&F^0
7ccJd^M,]+E<H:QH@PL/5)dFe?,54=Y<#E6-Y2/+,71M+Y,82PE59+E6D2L?9K/f
aB(Y:.?HZ9WcA23)b;BD1?WAM+?R<@9D6B.Lf]d6J?KgaHbcPdSa.Z4EC:ZX(&HC
=N-92gZbJ</YHdRT9KI5#K0/_N6ISL+\P5[?9AUg.2Z1UAP0c4J<-0:C;Kc.MIMH
\Pb^Q4YE>c_Yc39SL15@3XfJ4WF<HW45bZOQ6ddX+\:dId0SR7IF;VB8B]8)53^_
M2>9:80,B-BDD,>aM@ZHg3U-C=T1e,[Y6Y(JYQZ_<3?#30@7M336USZL62G_UX)6
JAYF->LBI)Z]VS]>]3PFH<W]5g#8)YROfaLQe-R0N,E:P\;fgc9&If1\2X]UM#1]
<33CFe8X7=?9384d#LeU?KUR?77<-60bFO?,[KaA.Af@b@U-T3GJ3=ZX2@S_b(>#
bZ&J(PT8GEI>SUEKb<&?,Ga5,5&c>W<7]TBICK#ZDd1E_RWQCBJQMST=7I8c@1B[
OCQ:TF[U7aDg8_38])[JJU#R\\U=8,R&66RccN>)Y1+)R(KKO\1FZGDW&<.7f]gf
3EVbcDZ\8<b<JPP.3.)G(.gb-\]c?5YKgGW59J]MOP4>UA(M4OcSQMY=Ae@G=>cB
9GYgBL3PMAY23YE8Y#.T@)0BK3_DTJE@(KY2?9K&Kb,(R-Z;PI]fS-<I\8BVI;\3
aLEC2Z#CMW<=_E</Pde/90JL5MGXF,U:93??c<,S9S@CL<.EWgG-TeZ.1^@_0YUD
B:J8^&1f30X.E2SNHGJ,0e,#HUE_4+,G<U.?.1b_G<KZM)PI60@42DZ1LY_\DBY.
1^DFN=P]HJc59gG^CE\T_W/8K5CJ\?cT:BR>M1SN;2[#O/gS4;+XX68A8_4C+Q9b
2c;PZ+gI2.e6Z6E-8B@W+P;PcY.g5f71/UVTQFP)aZ?;2VL^QWM/:8+)>]W4X+D+
bUCM[);22R,(RV(CYSKL8&A<FDQCTKYdgJb\3a7>SVAX<;fY>ObL],.QBgYB/U<D
A_=&C:8]Y5Q.[Y+WAcCL84aR9MDZTILY+1;O]C3_TM75K2b-Vc>:e]VcEY_\9fAa
-OF5M0<O.bEL5SB=OYM+)@7M:4UeL>/gM=ZHC.Ad2YP945Pd^]f3]R/-W#O.-&P?
F:N6I,[@1HL+M_>f/gF+A/,c(?:7L3Z@;6TTcGEZT67SHX5X1TZJ_[WaAYa@/SOI
T1c6@/W7(F6(_G.WId@(ZRBB\BL\[1Q44Y?ge5aPM>4P24>Q1?Q7?)-N\-=4I4V\
Q1?1S8c<#DY>3CKHb6c27JJGYGf;P&G>PIGMCCe3#K+A9,[GA:Sa^Q2c#gG+Va8?
O>eQgA@0/6+c?#\R34#ULGEe(]5RI2C/MCCG7\P3SP:;DP,V1.,dFCC4VH+0J0^_
;SKUgWGKZ4D@.S4T_:&IQ\]6,<A#DIR8#F<73N0D2?cC(Va(79;JVBU,X8<Zeg\A
5M/fY7T)=4PRM/4@H0Vf8GG)IM-KQ)WTNR(<?R<YOFeMVC0>gT+JC+9B<Jg7aK.J
/;a4=Uc/+V-Y.aT9SfT/f.<B1T;@4RXMN(-9CdQc/HDAe9SDCSF5;cP5L27PEN8Z
_,&5RV_.D?C\VE(]8/0VE>[6X1FSXI4#5.R4M(&P)_@:]IQf/5e/EBaa<,<096<^
JO^82<F5)7#+Vdb@SH3&IPX3DNgAQC:L]-ae&WNG6AXDXOPc9UN?N/OZ9HVJE3cQ
=GS>Ce5U>>^eR);;;N?e/IbCJN,S@D<_Vb#c:(^0eQG)M[)8a^Ze+6BVTD:N&IeK
[Va_-6gfaA<>If#D<80GT?I3?1#@f;RF<]W-,4L5-R4UOb4_WY@?Hb0L-0L07AN@
H,ELaE7O;EQM.WL4>:3C,>-[\a/4:1cA,X+YJ\>7O-b4JT-@KO2/P_f:P8#.@I/8
CXYJ_Q]e\a:FUK-R8\HU]3Xbd;RaCMN1X44]5M78aQ0fWH18EeZU,9,.0fH2YWK<
3C0Q&_1^1S[GSM(e3()&[X4ZOYDe.Jg,d,O5T^fKgX,KQ&NEB/9(SR^T0@VV4SDI
,[C-U,5DOWV-E@3XIBU9NAT3,^E7-A(?@T2R[[T>9O8G:JKfC+#XRfaYA[.dfU4_
(5MYYaEgSV=45;A<33Ff>R<3A[+XeAPc#<9CDZ=e)RfG?=9@-;NOI,6M>/U,Z2QC
9de4[H;ZZ(ZIA(KB<=;\&&WdeNJ9/:-c7Z0[P5@f&(7GB6@3[FX?>TD6A7e<<,Z7
>a\[]C1)GXO8N=B4:dBDI0b<aNWg1ScOJ^UH6\aWT1b#;X<Q/9^ZIEb5+?<KE]Fe
Vb(@5:e\DQe\;&<,RY?E&LQ8Q3+)&VDbNdMAM(B]_bPTb5FFRDN0g^=T?@S/fU-V
bQY,#QP0G&:HBg2W(6[OSP)FX5F5&?8)ACYBYRUVGa_?JcLLSJ4.#[O6JZXD6-2g
fL(Vc2[XEE3]eEa8UH48>@4NJE4/bF_-9UaRHOgf^gd(9S1Y[Ra<@=L9C8&20_(;
,9E+5Pc#ED4_.?E]c+D+RXJ)>J,2LAVJO,Z2\8Q8f8/KLBVfQX)_KL=?)Af;<ODf
<^0<(FP6]QO7TVY=538PdA#bD\:^af^KE9W9P/dP>TW#[\0E7FdKXI]bS#?<5H>.
@-2I#cH>cTL[9@<6&+b66X&57DQY3g.JM@W57cR;5M8)0VeZ6KY,GW>fT.7[]_=4
PB/RGXcGVL,9H0d&R[C9;c=U^Je69O2P>]-66c6_3R5UW_[dARB>g@NYe@A,PB=M
_9\G5:4W,;_DLc7]-W:<(X\E+0[a?2)M5HVG?&b5_&-Zb@93SS28K>OQH^5bA5D=
@fMFO]/0,_??d8N5^<S.eQ)4><V4(7N,ISb5EQ1I)?,Y&\A:\S\JaC)QK.DH-G;O
ML.8O&X2,Wb..d.EbX\U_]M8^\a:,7(])N7M-:?8c9T0IHO_<O)NE>[RWgbXTNCC
=1O7Kbf8&49b])C;UXc)2\;>2NH=^CXU8G3CWAYN_BM]ZFC.B?@:R-IQ+DbfR1:d
6PU&IC]V<Z:^36V]2e5+[+-X9F&]DQ=]1Gg7I+M]YZCD338\=AS,dA:3c(\N\?N#
^Z;UOKg9<D>WgF\J=,,))-APYS-PS#5#+PQ@#a:Bg,T1e^V0WIGIaRG3;4P+MUD&
()<C>1IU2aI_@d@G0aH5BJ>7LWPP>D,OL1YK=SV5>6(I5T]8b]]LD+^YA?UT,]D<
(6+OW47L\H/D]8&/ZMRF<1>T/;3#+\(bP4<Ga&DSeIWOH]5/31gYgc]#HJ5L&dHG
B1@9()TZWV6bZ;B][\E+faP\BIT@^B6^1@Bb5eX4^e3J0d&]QGN,GEcDYW.C(5Nd
0=R8)_O20-U&9cVOK]>+DO:O:T?dG_K.5R:a@>+([)OeaT6VMP5GLNT8K\O/HcaF
+@WfME-HbX,IHf&/0CUJdA[>MKc,&^:JaT9:J/1Pd#IgK3,MeL4P24_g:8HDU?36
/W08^a1=aK?MV_EC5UZ[T]>.?0NXZSXc6H-DNd8=.W2-gd##[W+HcEV+(.@Q,1/[
KFMV.gB1]:LE>Vg+ZL-2We7)K+L-.@N@NNcZ=(W>cF?,7)1N65O?9Hf9aa)[&X^E
7H.:[g>-_P]R65@.MN?Eb2\c34NV55If?\>B>^K,O4dF)d=&A;C\F@e0H/3G;A.,
95YV=:D>0:M.H6EG9RXRZRTWd8e38W&)R<1Y.S[fJ;A&J,e:dB(aP2IB,-NL3TH2
A-?aOZ^^Q1TN2c:&GTODHLV_=NcMEa8=&eEO\8YQAX9NdUDSU/[=SHV1GD1^6]CS
Cg>.U=?#a(59Kd+0?Z:5aTaKN-C-W(U,Q<V#e)#(GA0QZ/7E_(HSf^>YDAL371&_
W,:R==0XRT0U?b5N>3>ADYG<J^>0P<_1bf1Ic7:T8XDY;(b^0P0@#Dda40P891+\
=8bK(VP^YZH/B(.R6];ID^YAI;d8J;-N2+L1d:DV/?_YX)\=10POKbf;cQ\T]AWU
OX6GO09;#W<Q^5eb-fDSL;_:bR_^&VD30W]A7@RC@&?aDK#&U;VBVSVd-;.42aJ+
[9g+9I][ac1Y7]?LZ?SE;Ed6^\d1TgG)<UIc>Nd940D0NB5C^M]E:GWdaK)9;<=G
7\FDPX,?_P=fZG1/VEP0ACS_P,.@EL6TI.BQKa>.WC/]L;TCN3P(d^QXHV4V?A,7
Z[/a/1.cIE5CXcTVOC8ZE6);T-YWd/:^;<UV0B^(QcTV]J0B<9/RCW0dXR^B6I/+
VL[.ZN(dGRSgR/eB,2gI]?42XWCSBB8KWGd^Yd26d+9W7C^\,GOBGA>)GUOOL-<-
,ZZ7L247T)HOYU=^B#?\^1+P=b:bD3a@b0SBJ\F5R:C]R2\UQY/9R@2#fN?,\&7=
#XaeNd6_9@LcGEIV_(P#.Pf@B=8[T-L8=C#NdW6ff)JS4]&@XN8HBWa-fBB/\I#c
20\3WZ^E6P6.5F?FcbPKULJ?(D-eP5g42PVI#6_7_.DGLMUYEESSMKL(0R06dVRB
N=5d;3B9FL-=+_G86-9,R([8dZO@95bTW\1@5^F0J(#EMV/)S/+M:,KIV,JdR.;W
H8.+BR..25QfKT;[>a^XT3NZ<8]^bXfDTW0.QE8?Mf\4?-DH3BUUaVb:D.b>UJ.B
<U&.HJLBbXIN;Y0KC-9ZZQXPLLE\\]WM-Hf72AeXA2U\FQ6I:NL8U.H)eHUHD&-c
bD0^N/P(;YL=-/N>08\da4=/D_1>-HfaH5<g0C^D.9c7JUL[I3](8#UV8(OA,I&<
fRXYHQLF=E/HMT,E:UM.7fRK+f0[Z+c@XH/@E#b4..?XODP,LK?A#C1P76-/FX2G
MKfL2[4J,,]@N[>a6DYN1(<-ZObKS@U]G9HQ2HN1_)FTI]N9I_U64+97OV6#359=
gZP9_5BB#5[6X:::WgFfQ-Aa_+7UGIV@gIBTZTdbG\=6+c/(ZRIFY46\0a0N_bMP
_3(ce_b8=,+,ZgGQgP6\R#e6&8U91JV:ZR0DG>2\2EKeZYe-S#>5,\5&e>cS9_Eg
8Uad6e&J+PKZ+/IIS]@<N6d6c#N4PX[6Md79E8Yed@U._fUdN4=?ECG85YKHKdKY
SBXFZ?;fMXCD-e&73D4D&Z6P--_Y4NO8-Q5#(:TD.?47TH_=^O8?V]?NfU[SV-1-
a&b1^;05OH_@/ZULN.f)/J_JIRU14d]:2\ZM&KOH)7<A5,,P,&;NDFP[\:W<E\EE
Gf@.:.P,bXN#0V71[4(/7^aP5Vb1>3X<HcC7AcWBN9ObJ#_VM3&EUPUER\?[Q3g/
H[,,/+FX0:]DSCYbgSU0O]2L9B4D//dJ>824OL,g:,SQO5V313e4:OV0+[.LS=Z-
^08-LA.cEAaHNH>@;N/2<JVg6<CS1OK_+>M\X_N,F>0:Y\6OT8c>=-[4N2^7@PI2
0N)9(g5STeWQ>H>>A8+U?+IbaF2)gE5S?79^X/;:]MM5=-d]24=K<B1Rec.XU?PW
dCS.aG#Y<D[4&MNI&-R,E020;ba[,FTJP@>:L[AF0GF_0UYUV;=\;=aR4a&O<F@9
YZ]5g1gGT.@^cGXA6UMe//,DSH0/c,4[51f[TVCG+C)70;^MGQT+QbX6@=&BI;+O
F-4&5FMP?3Q:a@#&KZ6J)eKB1JKGZ_>/K)=;PcN[[R-d#K9JAXY,SSIc+?L4=+TJ
2Yf@L&X3a@CBXaP-)#8a0DI.4RJ8aDf7BN,R6cQBQ7M8A.-ZX&_/JG1XLeIe?Sf<
bc&<41_124-J&GX(^cYS(B3G2,RTWOW\aZQP1J-96.6&41OBHWPeGggaNTSc(4N&
G)R_R?V\gb\:S04(/c1]-NaSU_eK/)A]##cI06_g(McQUW?]d;]^F_:6E7=E]cDU
K]&@_4@HIOO0V#BUL,d1b;<PBUe=C?6,,DAQaBGbX?0a[TUNT=9AW>\<XbNRPe1J
edU\N>^(f7CT(R4PA>cCf#4Ef<<?a@&b;3.Fb1PNXf<.8NPCM:@/X+cQ\3CaBH^D
eBO7&]&Zg9Za3N-DEe>=Q.:./24@)4&b?HG3(>YbQ4Hg<U+OeC2(D2PX9dL:6QdK
T)PT3Z4@--E>1U]T9fNU()Ug<1N^RO;ZHfG)0XR(M9_9/dFY.F4-U:(5@N5[KaT=
5U7+Q5&=252#&Y,6:cg(#X5F6?:5:>=Gc023UJ,R,eg0.W9g3I6(Q\bf,.MaPd.P
.>RE)FT[0]5FYgU5.>B+71g9AZMeaNK8<dP&dK8@9;=:Z]gZNFFZS_^Gd5VMU5D?
5XfS5+2)g7R8T80RdWaS\U#E.K5AC)3F_4#>9H^fEbIPYHTg^+egUD>gX,bGRERV
d,P,:<\(OU02O.H=5331?JD@:^QdKT@0bFG+5:91\E^>PB[T]f\,g=E;J(SH?BU\
5eFV4cF5>][[9_WD>.,^c^d/_&+SF]Q&FRJ2NNOTbJ#FYCZ2<NL:M1P7ATWga\1B
6S=F+f.K_fF0OO_H.-c;g@@d@WA5=:X?5+b.A]ScLb\ZJbb;CS<KER#gg<bX=WCQ
D7RMK3,+-4=LBHcgE[.;9<<1gRQ>L(8V:@-D+PEER\&d-B4Fe&NXO3DY-(VgGf:[
=]7:J&UbMY0>CF^G7:^Y&D+1d&8O<)[D@Eccc.I?\c3DI[3DXTNBTgD[SeK9NS?,
/XAU.]5RP&0-1Y)GF&ED5<>KU;T:VgN0L.<IYDY+-f3c/M,I(Oa=)\/[Ua5V?J\T
DBT-T,(I0UJ_DL6IMCV2RI1NQLVfF:J<)Y(NO5CcX5Y5cVWgHV<GO;2\#VCM/+Z^
@K=eO#;&;?OVf>;3\-RY,Oe<:@@9[L=.O7_S>gTK0C:_Y0bAbW7EO>Gf&DV;bYPe
;M<d@X@+T7DeDZO,,\+ZaP2I7M[SO_;H>08QPX^:ZTdAY)a<BL^@/)WG-C\fK=9(
PJg)+f-FMd#5c45)C><]26dTcFcX/MSM#OVLMZ;NcWH]Kf_EC^V=b\E,^Pc>>c9)
;D#N\R,#)Bd?9@.AL9L5bfe0S9HR)ZEE_C]\F&:L\5.WPRUe8J1)6A/_X//?UeAA
.Wd4fSKLdSLfHfFJ[P/B#aJG8?Y;:>)a+&dF_.-I;=3SA)CQ@SLP?^N3Z8TM22e\
N8gc;CfB=J>&X0COCY]\WdF+[BW#,JY5H7I8_FgPBg+?KS@(Q;#UNF(RfFXH[RUc
<22]#^F&K&PdcTX[>:2D[>S9JAbc=/XA.3^G5gKW1e;ePUdF8/()RZc\D5ea#4:6
]7(VdC_-#+LS@2I1.gU/X4G7;6//.</Xf,V19YGA=.GV][3OM@/30AS:-DAZYC@G
@b/BLNG2CfDbY5eZ<OD22bAg^V2OH[3PT\5@HH19UeAJJ]R_M?XdBBL]&dOV/_-g
b:#b7D/::a5(O+/=J>&>H31J[,HW&fTCE2C@#<#4^+)JNO:\GK=NZ_R@@aOT]7SX
1)5&-:d+@FdFdF#A--B9bf;Q>#28K^6g[:M9-6JF=CfZS@;Se:ceFH332[cZIf_U
W@L5#-8><7#L9SCE;#(6CbcbdET;&^[cX]CS9W42G,dP9_27EaAYgSG[TL:I:JX<
6@2]f\[>^F)2OYOOO>C@,[GL&KT[/M]KA?091-Q5[B>4XV=4F_f^dQ(1;D3^\IEJ
aUg9]ZX<G5X,PRX@ENCf@GI?9=a19YOLG+(U<ROCLRG)ROSc9#<f^^af=Ea/;1B4
^EaU-;C#.;63,2+c8bPL:9f.D/HN-8I1T0ZW+\fJA3LRB^HI3NV.T6IG\O9M?f3&
a):S6GWb#<7U>6J^-T]Y>X,5C]&d]be2<K<XTHUBBTX0@4fM/F\QB/RK=7?bAXCZ
-1JD2JO(,E278RJ5Z)BHZF?e<)<7CabKM/QFI6cNQ82cY6[c]USCXEWBGFQ<+R.G
P+<Ka,S0NEUSSZ2d+Gd1,;Y\Cf^<IZUO<?d,^#47;gRA_1A,^e[EH_/J2#eN1=B9
IKb4)^0IBZHfIdA8F9?9PE_CH_U&A^aAL(W9R_0?2b7UPZ0HH,L9[Qf]0KaTBaJY
4e.bFQFe8g+?EEFI=/)58VT\@[?)2(Ud9:a#f;MG:Mg7#.PW@B0.9V+YKM6JJB:H
P\49Mc<K.H=;e<VK@AKEIc6d<a&142Y(&Q=6(K5W5W4cIV[&/<@/@.\/L1Ue&ZGW
f;<VJ:RcW](@E0NRd&a[+P0f:?[UFX9f?+a+F+^9GTS<[dTU=[VT#^DB6gOFcd5P
G(6QY6)^b./d)PYN_574K#gY(8VdJ[DKPWNHP&Q3J[B&Y.=Q?\5ZY2<(.N<_9W)/
N9&O:)\9YET#_Y.<=W@)=XLRJR34ca0[&L#@Ic?6aU?7dI[6@Y:2Y7NVdQAeeSNQ
a<(@TNaF>7,G,K8[>?g]eV8+9)Z60VP.AX5IBS3dVGZA=B[;I,@-L=9#3FJF7XYR
EEeO8;5fT=J<_JBC0WT8(G-a@A_9^;9#1f;_2-72d\@YcJMNTLX_S0_bbfP7N&b_
E02,cR@+C897\W=#EV-<&PY&E1Q>@K3VU6->B:M@A[eg;f3KRO=M(QGfO#+5<:Z[
QFY:(U?gKd_9YMCF4CYOWJ=C9Y7.=5[BA=O=-Z,=N/U[d7ZO\d8@\<@_d\\&1;Z?
;P+CMUT9(98H4N@Gd[U7.]6DQJ5dOUc(/WNSLc<;1KS-K+(OWKNT2MLHK8/..(DR
8<)YeU@)b\ARI5OY&c\9[12XUO]@<Y_\LGMUG[#@,4-;f.eO\SOTY/3FV()(^++G
+4HIQb8ZS:,:ZHY0(MC>eL\^)a_OWX>,fd=8VJ4\(bgGP;6-Q[0(f\H+NNPaLF_Z
@>>DJR_5Q<7TAHbS5g./PFV>AF4NM#OL[]0&b_\F(FYYMB(f<eI3<c97&ae82WC-
JFd8HCRJV(O1e7PU7OLF+<5W5g(T6Y;#HKfaK:Ka\EBIWLc4QOMUg^)5CVN>QC+,
EI:[4XJ#AdL6a2/-->8BR2(D58dQ^.RI9TW+8_2c\BbXcZK?dE(S]P)C8G@H,+O5
IH=g,-ATW\IBT>H)L4b#,2-d1^?<@30(I;ZFX#U<dFed0VdZ,HE8E/6KI8S^bTTG
L7;/K7&W4Ee-ZHI/;6[K&?3YUPBDIC^B2=C2-?SU[a]>Z6NDH7O^DIRF)XfO&4>;
O8^_Z<9I0W06G,PRR_N3UT#(&R7cWMI[0;FK)#_,SF:1/00#?aZ92/QV,7ZQHOXF
J0[9UggQd];c^37]Y9WE(\.,Ve:4:56E8URC59Ogaa@8fQ(UJO<9fGHEf06\U:H;
@,Q86EU7O3E)EUWdW<IV_2dSFgWG_AY@ZTZ0T]4I0_]5Be=G.[-9a2IB7AQNLCKF
6Wf6H[^+2>@3F/:__=HO>]N;-[92#J=ZE_#W(cKS(19(,TB.\U6Q7I?aDG,V4IH3
J?Y(^C^fZ^b?0KN4YMTOLMO3J>FF)/D6.3JNV\Df(g?CLK.e_VVEf&V@N;O+4UEN
N(^P.0]1DJg6[0;ZeYPcH9HfPT:YA/X2M?<:W@G-aUQg[>3S?Z84F0V=,_34Z0dC
5)g&_g&Q+(#fA\1NES]S&9I)4.MM1E):G]B4IR90P33QDWg\4B.Na>>8+7D45D?M
R1=.eY809Y)[YMa3H6T<Te2;>NG+G)&O.-cL;U4<LTe<HaT1SA[c>[cZNS6V>H)K
F_+<X[1X(^Z<f(6cOF/gGN8RaZd0L@]6UX@Kb0bgT\JXG-?dZ4)ACHFT<-^4RCKF
^KIMURaQ?6&]cY&>ZcOH2>[?(43,#WTfdBARG,cDCXa+=gIG7.K_U:f:W=Q0-a13
O8F0&:.[5.GEKDS/(.Q,-GF00Nd\L8DMBQ_bW>L+#@TS9E5CI;2_[G<1N+bSQC?a
6^1:7#LTaCYCP^31V+.;7ge-\04QT3(b6>EPg#?-gEdR?GYQ4Yb9OM8>X2T;W-&?
C3\8K=)<K-ZAI<K[f=_aG/b83Q&4C_U7RB9^@?cQ3&&Jc4FVT7P/Z1H0,\R?E_>-
<ecMVF3A8-fXY8fTY,N2W-O2-Y,JJAcJ&a>([-&6EG\(2(UFgIFebIO9>TMP7T4d
+;0b5@Ad\32);3@9.0RcZd#,K/D45M@+]N2^7d967@2\e\[QZa1\C53=,aeY624:
6S^++GYD2fV6=]-&G,]CER&=Z4B_P;CRg/\Ud?/=^\P7A&:HQc^:a2(411O>E:O&
IUOa<FgN5XSG?5OBGI1@24U56W>[4W40C8R<X3JSf&84<99_9F2>O(EKQ7FNUB26
H:[f.Ya+#;/:FL;4A_fMLC[fM)9C2IQH-,=-&dCZ?O6OPVWDOD?BF,/J1/JJWF[W
aJ4RCbN0FcaO+<SUPY3N;^.J>gdPR)\cNK0\U&9=AG73DR)=WM6NIebT^P=fTbA8
RPf&1(.QIY<>H@)WNRC</+8\WV>J^)CH4b1?b6\K9#[V-/g<c8g5ccQaDYVNX6>;
;DaP-fH-R5f.0ZIb]CY>:))X?#5;^^I:Xc(Df<[[N,BL1a2I1J8b4e38Ug)\=2@/
NCLbKbOQ82EHD@F#-KPdfaWOU<YC:eI1H3)T].,BaOfJW3H2>J16(CJ@4,4FSV[0
=/?[R8F;3gX=bK,)Z(),)X4:5gPZ6F.9gMaROXXce50O0]+U)I97Nc@f1WH,D6:^
U<IT3M2>.R4:W3J;+]B<O809&1RUG(TVFg+LQLMEC.eDfNgM5ZS#\@dHA5U3+\g.
B-H4C4f>^<2#+722+@/+PV7Je/&7-[g9FREDA75?5-@I?KV)WTQSe764(AP[LfX4
R6S?X+\FZB+4_5_5<ZaE56(bc,@K+;.KD-9(24;;TL4Jd-Vb?J-_,d32V&86>g#W
OS:Z.QM0J6dM>9QeIT1&7e2)[,SC6VD2-NDNZ>aNcV:cdC1_dfZC/TfH^UKJO^E,
>=KBT+0I-LV+#?f@<[-:BQBgOg^AXCZ][BeVUO,^8[]V#R@Ne1?TDJgLLD?&YP4V
,Y,3dX[#8H+ZdH(NU120RM)K.e0BfQgCHC?AB[M#^B<6DQC1g^#AG/N[adDLeWe#
UaM+C1R,>]W)^@:5(cOgP\YH:#F7dHJ4R;<9_NX_a^U>3?a?S&@,#891I3PL5J>G
c29<L9d3fX+?LZc[9&RJZGSJT(bOcY3MBWV@aaT[8^\&]HR&O6@c#e?29H<.G+YP
08^6AXS\JG6M:J<F201a)A^(J8GOE\R=:YFc?Ve>IbE#^e#H;<G^8KgEI;PK4?R6
[TbT/P@7J;6=+X7P5Y?95W;V-F9-R1ZUdbP?2_2E8YNJ\5<aIYKL\Rg=5Ze&?148
(0REC^;?BY/S[^UeEE:V^7(a8G5X&F)(0X-929eMa6IU^5?]6SU>7P4eTR8Ac+gT
);;3TE,FBReS/$
`endprotected

   

`endif //  `ifndef GUARD_SVT_BASE_MEM_SUITE_CONFIGURATION_SV
