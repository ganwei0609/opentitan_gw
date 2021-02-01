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

`ifndef GUARD_SVT_GROUP_SV
`define GUARD_SVT_GROUP_SV

// Only compile the svt_group if VMM 1.2 features are enabled
`ifndef SVT_PRE_VMM_12

//svt_vcs_lic_vip_protect
`protected
XMg0[_&_QV41[#-c5@-S>&?=7;dP<Y//H41c3GM0[_?dGE)&0HDB((dUe+;Z1W=1
,7F#VU,g2;6UI+R>g.GA+c]ZE5VcBb_XLB@Q0=FUfS(C]:BIMMGRc=:\B+QKWU=Q
S-8HIM19>N.>@UFL=<(IVR_HUQY1d\[)1=T5[21>SJ^89H-BP^(0?0d[]M=+Q\T^
fLTF_A5Ra<Sf<P/[27e7),.Wg50^(cAYN0+27ADZ(>M\Zc]c3C:?I.QPeN(3]#>A
@+T3_fT7^9WdL/;ecW[F)F.W8$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT groups which
 * are based on vmm_group.
 */
virtual class svt_group extends vmm_group;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Shared log instance used for internally generated data objects.
   */
  vmm_log data_log;

  /**
   * DUT Error Check infrastructure object <b>shared</b> by the group transactors.
   */
  svt_err_check err_check = null;

  /**
   * Determines if a transaction summary should be generated in the report_ph() task.
   */
  int intermediate_report = 1;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
(,4J@IBE^@X<>T&#0]ac7fH3\BI7+,R2TWTF&IDZ;Q>QZG=f?(BO)(P>L,E8+gBX
X5#P.]F+\JPW40KG7H4YU\\26TW,Dd#MW1;V>CNbeL1INVRPb-B_)P8_)FXK4O_M
+S0Y)W,9LP]P&#ITJ<2e\1c[_C_8<+Z>G.eJe?]&&Q^G1#9@[>,RR;&,?L3@XeRb
;D7ZcAR=TS_Vd_dcVT(#96/C7<LD=aGGUQQAF/7=[)1BPYOGVcgdCNP>9IH9^,B,
c@<>N-K:3<7B4RD=a0AXDa4,,\&9V6bD:g3PD\LBQ]VTKTY,KVOQ5]\<RYRWd+/P
,32HA9S&)-JNQC;LOaQdc8O6=S&0YI/YeJNF8I-6fBeUPWPIZFSb2=6B,JBgfZ^I
O:G+FYR3,4NI4IOAXNf6Jf>E_N]6V);1MVT4?gD@WU0D/bb3af-\eY65R0XZ1UWA
cSE)4PDcLX60<]ac.58gEfaNUPR6Ng;Vdg9Cb3Y8[4Q;7N:dH<SPL#1?F]GU7]a>
]SSM3MHX]XfL-^?>]P_/=_K>OWcS>LX4:P79dYN6PWQ#,Y9&1^14PHUP__BYbG?9
)ZU#dV]dAV==0ScTRVG;cLf[(SF@U28UM0=90)[Z>#a36aIMM+5S<2X/^JE59\3K
fYI&5,CRaU#U^B.(.IA)KJ87D]_Oe:J_a1-INTKaff2/a=EQbO?JK];S@9b&P_+,
-GVEFFUTHdUYd+_4<365K:a&P4?e+V(].5MZU1S/Z(3?cFY/U^T\RG?E8L2I_JdK
/fZ)40D<W#C+PFLKJ4?N0?7GTWY^#N5NT(90f/S/F0:N.dU]G5b[(3GeLN&?@[&J
)?^[g(X/:\XH:7=g>3NE8-N(;1a7L[VB)Bb4):CQ@:J&J5:IHW:[<\[<00N@5Dd2
8XgbM_V_<UVD,9U97//1Y^dS],G[0S-=;4#=3Q#bUVB0YFbINYLGNKJB]H7C,6d]
V?[bOSZP?PL^dAN:VJ(+2e_&E#UPF6;[SW3Cd4DU:Y6BT+CX0=6_J3?C]U+WU&##
U3>N0/:35C/f-4:-[bK[>eYZ.=SR:_TXRV.5R?g^c23gIbEBR55UITF.S_EBE_9S
04YI[NL#/8Q51fJ;Je]J<NCfS:b.gO(.(IEbL7FP@#Ec]X&VDO]&Ma\c9g:KYFO6
35R:TYA6dB9<CO44QBAON40CKaFVLMPcL\3FJ[,K/Td3@VcE-&T<[)?I6?Z,3d?J
_XNg7O?b86+KK?_2/(2BaK+SS-VZ)&YaS./](&JbMCXdZ]6P?PDY^CS[\ZH,J-Wc
H^)eFZG1KRUVFHeNN-2=QN)YNYX<Vf2dN--[eIML>/2a2;9[b][(UQCN[&BA>:&X
T\#W)@/Y4)OegXDN_W2YNH6XO9RX9&8JgW1XKbKU2c.R84BK[:]-YbW8(]MWUa1T
FL\M,L5BIA?8LD-5E]4QAA)(3[f2ZF\CY1FBKZgXAbD-Y_VX_IZYMMXI=0F?GV=c
_/VSJ1fb4^A;QG,f+U^2aK)(4$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new group instance, passing the appropriate argument
   * values to the vmm_group parent class.
   *
   * @param suite_name Identifies the product suite to which the group object belongs.
   *
   * @param name Name assigned to this group.
   *
   * @param inst Name assigned to this group instance.
   *
   * @param parent Parent class of this group.
   */
  extern function new(string suite_name,
                      string name = "", 
                      string inst = "",
                      vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Returns the name associated with this group. */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /** Returns the instance name associated with this group. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /**
   * Sets the instance name associated with this group.
   *
   * @param inst The new instance name to be associated with this group.
   */
  extern virtual function void set_instance(string inst);

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  // ---------------------------------------------------------------------------
  /**
   * Sets the parent object for this group.
   *
   * @param parent The new parent for the group.
   */
  extern virtual function void set_parent_object(vmm_object parent);
`endif
`endif

//svt_vcs_lic_vip_protect
`protected
6gNOGgNK+8cNFg.)KYXGM3ERXd>NW9J5fOMQ;_M+AOGHU,Z+4@8K&(PBM?A2F_KO
R=6(>M[,<RST6:S&G6;A=gAN;;:Ya5U/Ncd3:;#IO_@?][=4:b-71:^9Z1SG&T\D
d#[YT(Xb<R#16/LJV[6P3(,69+H&=f.F\.UK_@3AWb]9T;HKZL[20>:V0V(\JN@5
8&V([]BLY7\?]>X-[DV/cg.=UR)^[H]J2LN.fHK7];@eZc#[<Z]fT1c?\H?@3.9H
AS_4S+@:4P[;&ScZDeg\WKY7:@Z23XV>.Eg95W5V_Yc,F5&J#G&c,&G6BQ?X[b44
_,WNZE:(dQe8><AeC=W45ZI0ALe#Ie2L6J.US1+6Y2H,G,<J0SE\>46cAR=6cP53
0M[a.cI1.bE]fQ]H#(204Vf\e^a3KEbZF5cc5L2SffA\9Y]JZ/(NZJ4)5L,,?CRZ
/:_-3OJe:OUY[\C7a=gS+#RQBC(ZTQ?+FW+^\eeBIGgT9;E&4e0_&D4)I$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
6,LDLRWR@(#,\d6QIg]?F_REIMB-;aXS5<.-BEeOO,2@N_ST_UG4.)YD12X9XHOc
,I[)MaN@7;#=JL6U>F#b7_V>c6)W_/:;P.QbQ[#5U?HUHC@^7f2NX)+8a=YcMg)5
S#79D12;3+O=/$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the group configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for the transactors.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the group's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_group_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the group into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_group_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the group into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_group_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the group. Extended classes implementing specific groups
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Used to identify whether the group has been started. Based on whether the
   * transactors in the group have been started.
   *
   * @return 1 indicates that the group has been started, 0 indicates it has not.
   */
  virtual function bit get_is_started();
    get_is_started = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * support a reset in the run-flow so the group can support test loops.  It resets
   * the objects contained in the group. It also clears out transaction
   * summaries and drives signals to hi-Z. If this is a HARD reset this method
   * can also result in the destruction of all of the transactors and channels
   * managed by the group. This is basically used to destroy the group and
   * start fresh in subsequent test loops.
   */
  extern virtual task reset(vmm_env::restart_e kind = vmm_env::FIRM);

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * destroy the GROUP contents so that it can operate in a test loop.  The main
   * action is to kill the contained component and scenario generator transactors.
   */
  extern virtual function void kill();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void gen_config_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Enable automated debug
   */
  extern virtual function void build_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Route transcripts to file and print the header for automated debug
   */
  extern virtual function void configure_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void connect_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void configure_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_sim_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task disabled_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task reset_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task training_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task config_dut_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task start_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task run_ph();

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task shutdown_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task cleanup_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: If final report (i.e., #intermediate_report = 0) this method calls
   * report_ph() on the #check object.
   */
  extern virtual function void report_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void final_ph();

`protected
O&6=QgNS+1X2bY\0JA#MUG_0V>=dZL^T-)(D@9H+N4&G]X4FR;fQ6)dEQ^==[B\3
CK9:5fF1Xc=S#-4NG;Ed,AC7]7\?#Z.GM4\KXU3F)aY,RcKR9H22LF:8-@A/,@GA
8/77GSOOfbV);4UQ:0Rcd.M;1KX(ZO_18gY8AH;VdS7_RYf6IIQ#<\:8O$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * If this component is enabled for debug then this method will record the 
   * supplied timeunit and enable the configuration properties that correspond
   * to debug features.
   * 
   * @param pkg_prefix String prepended to the methodology extension
   * @param timeunit_str String identifying the timeunit for the supplied package
   * @param cfg Configuration object to enable debug features on
   * @param save_cfg Configuration that is to be saved. If 'null', then 'cfg' is saved.
   */
  extern protected function void enable_debug_opts(string pkg_prefix, string timeunit_str, svt_configuration cfg, svt_configuration save_cfg = null);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

  //----------------------------------------------------------------------------
  /**
   * Function to get the configuration that should be stored for this component
   * when debug_opts have been enabled.
   *
   * @param cfg The configuration that has been supplied to reconfigure.
   * @return The configuration that is to be stored.
   */
  extern virtual function svt_configuration get_debug_opts_cfg(svt_configuration cfg);

endclass

`protected
HJ?W=/7[<_A>FMg]9P3:N]SWd.7cLXe_a4[3SI6f>Tf=XMH^8b1D.)bLVTJWBe?A
I-.aSW45bY/d/OU8]-X&49BA\Le2Q,1(O4CZg^)\.:@&),.<f#g#0_X8;^bM</1f
SPASe.1?f5X-T>Me56,96(.[#^<-SOJHW;P]G:+>6XdOb26G6&eNB:N52;3-)9a=
WO=V/N6f/9(S\1H35L/Y<gQ<JF;K(:G@CY2/H(85BX9DWU/U/V7-15(G3I5f09PV
GUe#=2>JX7-,LB94Oc?KLM7B8E]Af3JS,6./53W-&Q78[#a.:S-N-HS11KS-g/P3
de6286?+2CS@L/L>ION^1G,Y6P+F<E0G>GQI.@,#\+9:BDe,D0IKNGE^4e3gN[.=
<_X)XP2<eT30H=6/J:CS.>C-T,HE)@f7a]/(1KQ,_7eZ5CRb75b(HQ8DV;;D7A^Q
MP^SA[\GL)M>#d>1H#UZ(f+_Se76](3X_#82W\GY<Z0aC>\H\d2OV1J&5R)fQZHW
g2(.?TT>JA;Q?CgY#a5>FPTS]2:&f[I;E86Z_0,/?IXe8MO/UQgHB=AX6#^0A<T8
IaR;[^4S4:=bf^d.I-UB1F\ECd41V\>fL06W:XZ_U>W-V3V+DN&QD^^:a_[@]47(
eFOA;?OE?]Ig797.^WS<:K98&LS1YKg^DLbGE>J-6<LDA:J1K]FV2cH;cZ_Uc9N_
KbT7&H9XI[5F]TA_^V@JOTYZb/YC,X(3g@OI]YVf]3HT3&_R;WGOg-XRPeG<Y1/&
LREcd1N77CP(6+cc&fd?Kg4b4.D?,UL81BR04@1;(1A371R,R&O@)Q&DM6#f8.@3
]b.@,>f/,<K[4eeOd,E9Mc9@1B;\0S3=6Q4JKW43EINHIc<2/OMI(>K_)D=F)OU8
1AO)YDD&:=gNc;bZ8&FU:(W9GC-g0KU\<CW.1N?C[]f2]LK@d_eAX[/3F6Y?-@PM
8[H(<.X>7TYI:R9@@;TVdZUDA\>C;:MKRY>(/X-++4eg)VaZ-L3AHB:5[)WPQ7&V
7-;98<T8\&E;EB:+EUL?fbE7GM6WFa?_IW-#b@^USf08MZ[N[,6]bB)4JN;-0AL2
S^Ue_(ML\SRR;KP,YR_>Q^M]J(aWH#aaL@GWKLI\T_[D-1GVLKJ6:(7;O:0TUY+\
Q3gCYDVTMS-EMDOf(\=2]aXNa6OS6g-6M;)De60I?V,Z)gU80IQ/;Ef;[6BG:>(1
MK;/7K9[Z;(HgJ5E[<B?fS7U5,@dGc.8Nf6)=f)TB2.U=/Q9JJWR<5Zg\_S?X&1:
0FWZ2L90I:1b2G-KJM#.K4&B+2dE\a_2IcV\FcE]2&91R>AbgDgOF[C-E<JZ8WWS
DD-O?ST/4I2fJ^(BM=3eCNWI;&1KZF]&(HKg.#X\0E94?T=VUPdU]Q.3M2&A<]9P
_>/aKcaWQ?MN.aK3.=0bc_WI4$
`endprotected


//------------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
7b6.Z64GJ-Z?^PbL]ON;MWZHWM;\=21WEV]9MDZOL\3--g4N)BMS((4L.cZ2+6Ic
e0,A2?N8N7,d([Z#>3-.EJ4\A/XP^\+c8<GLg/QF[(A^I3TZ9DGIU59NfRL41=IF
_X]2(d>DUJ\:C16D:E)C4;e+/BS3;&3>Z_.25b&F4KV0<K&[F,2>A&E,UFI89MSP
FSS)QS--KVL<2R>RO)7W-2F_H.FAD@-Mf+,7#<G:Ig;4MF,<0XdWVB2>K5>g[QNa
fbJ>FZ7Yg^1/2JIS#<&K-((T?U7V0CD/X3eHK6/&R[.MH\QIYCa2<<-I.dXE9O=H
R\a\X6DGDFN]96B9He:VHE.ZcA>b,K:VbdUX\1b?<1eCbXW7HCPa&JV>^eSegGc\
/E:P6,-;LH5SIDPMBeIV=LVgTDF5P[[KB,g3GWWK.>N]\T_@\[=Z./g=UB2B[F9Q
UK_c)X&eA9WOFQ1-//6_fU4CaM01eJ+?Q-6)FS^9Q>c)efT-9YXYf4G^_,G3Q?KG
DR<25C=/cAY&d[]TS@ReW-Y.)7aPW4J1/g(UbL\=M^4[cQbTX\KQ1I-<5[]T?P,g
-\8aGgUDg:^3UQ-;cb-1:RTb:J-@8N[@.L>M5RP8)Q:f=ALH,XOTXJ<X1eGgIY8N
QZ_W//PWB[VDFXNa79RT?=SYTXJVg0CJ(a&]U57,[/_\F:UcS?]7M<=M=HA<SM<P
;,.?_CO8HB2Rf8@dTD+e+[D#3115-+5Ue9)Y:#JA#F4M+UQ\=<(^K9^R2RNdFcf[
<fZZ_K_;G\D7W;;Z^6CFW^c[6#Zd95;IJ]be]BEM\OU2RR6bB(8,/P71Oaa0aJU8
Jgc/?U-e]#HAb;Mb]B]E1D44VaI<S[1&\-YCO<_)V,>N<P=8#,DBZ6R^BeA:e@WV
J9N^-9-f&@DaR#+[W3PSC.:MPN<g=.=E^,fbQOW)a.0D>W6J];f6C@CQH?>eO>1C
bS99>#H;1;af-=Z3ae;2E>_e]YJg@dg4TKGZ^17?S5O-4LOG:5e,B7TdX&<DHf6A
QL,1YO<U<20TMbOfY+O^Q6,,)Z5#LQf6I\6>#XX&QeTL;Jf#003ca((U2\SY===^
@Ef]K6Q=<D[e&KKB\bHMbXb?RFD2I&D]c\@V0OH)Bc\-IAP?\@0f.H?(N/?Vc9Vb
\eZLN:cYJ?cO-15#92#<6&JT8[FQV0.#T:NJIdZNJ_6P\JI8dVL?UG1[SO(aKG#/
0>WaQ:WINV<[.QDTW@FU_D.B:7TTM1=R]\Y+7=I/(ZN06X#O7;df8&QfQF^[KL4?
[GM:XY]=J7HaH>4^)HH_\@&@TMWOTfN>L-;#QJCf3fQQPH8F&B@aE1NKe7(.]Td0
:.00W#cG,NbC-F\\NUHZ9bDF@Z\9KZT2)D@_ABW)4?HE<+(<C<_cfFV?M1Ka?YfE
KGfVEC]VN&HN_TEL\c.E1,daaVWU0#?](MTSL;DJXK>9R[X+CU0N+@+^0XU10K66
N]MBY][cB>f9]/HRL3gX1Y_A8GSgY&0e.AK[2ZDaT:(c2&\#RUVJdbdOFEDB75/Z
<CIXO,HYU;I<dFVF8CBT[f]0>NY3)9379eC?<U_\.;eDR0fQDWO^ETH[T61;D=+f
IX59Fb]=:W2PHb6(G)#HC0J/=5gG^9e&//(4L85L4,.W5;301ObAff[-;TBD=.[[
)7E(/3>be5<X.T=WeC4f0XFLDIM?M4gDHdCY5G3O&g2WPZ^LIQ=?Y>=7N2+]@844
f#/FA619--L(E3,#1/R5W@F3QU/Naf<17-Ve3gROL=S-94?:7>;NFV8-I9QET#SE
BHT.E1]QBKN)X6/.;SSg1_QPWM0=<.M_E9=Hcf+CM0R[CPI1@S7-@efAFG7^/feI
gM=TC9+[L^+;CRRKI)3Z_>H]b0+UN<[_(77_<OPG3-44PKI+7MPUd6R-a)9=B;4<
(FS7Z\^,]]M6Nc^CFaEF?G>9])ZDa^BGb>3c^E-VQe\G>^YZ(XJIMX6/d>=J+d@E
RTb)Z6b1e6:PU&)K\+PU(5a-Q.e)\O.@D=<J7\IGJ2]faKGV[g]IH_T.KG3&_@N^
C\RS^YY6DR@]fS+XCJTAQ5I+X]V77NA-Wg.8?1V#W/\V3[V9C[J=ZJ08bJbDf\G]
,_fI1:-S9D.>OYea;9H0SZ[K=O]#\^c1IJW4365)Z8;VGMR#NN&;]F&V7)0)TM8B
?eX[16(@SMG4cP<eb5Gf>^8G=./b85,fGQ+I1DRGc389[8PQEJBH))7O;.ed]CX2
2<]gGNP6cgSfLb88?69R=ZWL><]X4K8:;77WZB4<F[<^74L3N;&1G/PfYWecE)QO
G7b^C1KD_\O&(<&fPWbK9-eKQ+MB2C[XHe&6FL)T>]eAS3M(=BgK1JJA]2WCAfLJ
f8b9;e^8(LeI1;/YF?#4O5(=?QVF:U215CPRb7U]f1OF+M#?K\@]S\=S596F?L1K
)CZET9##2)29;SK@)d1[IFS;&fWY44(208cT3OYEVX]=ZbLYe(FgV._=<S2Nb[8I
FV3Tf\_H\0ZZf^5B4?bW3+:<)E0#>><K=)?WJcQFD)JWS5Me60=5&O?2.H>CSFT+
5_/RP<R<6+O@\>G1L6bQ>3WRX0(;CHZ4):A(/ACGHdMA<#X\<^;I+1,<NJ:P.+:F
Ha-XL6>H+=>D&/_@D61EP.^Ba2OSY.&^JD,9@T)6U]?gDMge5J.bC-=V85gJ]^MX
<?K17bFEA)@T>-T1bU2WVI:OO:[<Ce(87S_^XEIbd0G<dd_,bWCSD2A]<M6BOFa-
aEV/@J0#4cJ;B^0@BcOB)_1M;KfdG>\0/FMWR<V+&9:R]IG)XN@e1-^:KN?.BU9R
R-He2YJ4_d(3Y_U78P?9eC:4/V#eHYDS[VIRKU3_UYZ)-V0LHQ-),_PdWe4NF\2B
(<C@OX0,7_.b4IAAX]27Ia:K]H8#?5N8e_TO/ZRRZ&e[6Ob5XWa<?-^OE1OC#bV?
_]M.d23U]>@e:\6H2D4\]2R-a2aI]C;>;]e,J:b[MM?5:c<PI3IN<f0>6A#];b(a
[5aA03]8dZZH0G[(ODI8,K[L^Xa<\HNeLJXB-?&AT78:T.+]e&_c2bb0aGYG4_GN
&,9#<W0O7_P>DU\4?T)#8YQTI2JU?>(W6N6.]-<>JO[Ub6??D2=0)I82-0R3=?M.
B<YC8,dJDEe=.Sf;#FDc=NH;cS8Fa>H@^V5[HOWSg:Z_=IQ[Q&0K(S8BE>^;Y\6Y
\3\+Y)6(&WU,f:&M-[=SX3T8&_=d>>=UDD6;f]96_4e/30Y5:(L+e8Pa:;(XgGP&
KeK]b9OUOLLT#423+[CA;V;fZCHG6Q]A09fF4cLgE7#<&\N5EX0L8)4eP_Fc(RTI
7@Q<L2/?DN&1P&1[e1Y,G8K0Zag_&7FKBMYJDd#)^P(I=3+O2M1VD:N2[V,?AB>P
LeJ;5&c9IGXY/;_aZWW,_DX_(LV(VZ.43_L244Z.[7Lf-fUMba,SD@P@68E:G\>K
0\9OP,\\Q7ON/8f.^+f]g;:7VMQ;@Z@3Vb+[\2VE3R;9751S9AJZc@H8BJPO(1\R
Q;N&_9VIT9L.Y-aY@e]_7ZbY>YMC;2]H6cYHbP+7>g?f3C6=+a[0ed:F)3fd#TD/
#=Z869^#e7IYGURI/+J>aCBgU4PT>AYP^RMM^cOfK?0,1IfZZ4>DB9-=67TdGfeE
9=>2_dYed4IR^7LNW\USJFM,>g9ZU-de>(LND1:OE@S#SW^,.3bOC-Pc=EHG6IN;
=@Q)\?84e@J1,DLIdcUQX\PDe-,8[(,E5B>NNH^[Q>c@b,\L:4SK#A&)DDD\0GN?
^)<S?#de_W,=;6g]0K;(ZV=R\ZfUJ:L1Jc=_+V:MZ-b=>6TI(;B]_8F6c?S/FL55
3F9</=2+8V(87cBDR&[M/,1ORE&.GU9]=:DC[C]RZ#45JWR,V/Ib.:JD[9@40[8=
K3529D0WU<9:Z_0/c:Oec>ZX0]#7CeZM0\/OJS&GUH5CJ[_aE:Ob3MR_+&X>/bU2
)16V@+H\ZfcX-)]65)aVdDS5Y?I-<>-?NfSP==f^&37KXH-g,J6GM=WAWWH>LHeE
KFY65YTFU/QLCNZ[#QC:O#>c8QFI2SAG-d8,9H&BfNW007R[\/9fU75ABBG/(;eB
U#PF0d3K8ca>+4Td[ES/?&)^VRI7P8F/KWO&>7)==bD)BK36.9ZZ8:OS?39S7G?#
IL\P_)0JO?/3GBUHL(ECc?V4?DN8R=;;e]_4BBHDDUT,&WJDG\5)d\b8]c9HM#XR
;UC<8/FUaQP8O5<68_GBM9UGe0)LRBd?<J=9A#V=/;aJ,9Jd()V<6#>&+:g67V8,
;(JDff;#<[)4V<G>Qg_ES?69K>&F)c_E>gTZ,.JXUag7140G48?CVD>9#89T:8-5
eP=A^]W9+\Q>(a)8[M0<HZbCd4Pb\92)[[:Q\ZVB3#dN>/2:]eXAeTIT2a,MOQ,C
Ff)J1=GB2]5()4__Q],LQW-#4S;4-)f@D0#E:@V#VY8IV4Q_5R@\2M=@J@AdISRY
I\-aCL+Y?^/bP>6LX+N/[Ab>I3fXBJ=BG<DUQDYRa;)6>\U<9=3VF0GHVaf&K=@4
ADT@][1gea7Q;;Ybg2dVTH4>KdC^IKEf[6JVHSZdDG)R/H;,PaYPRW[cM^L=T@?G
GW4F03/Z:a3+M.DbNYgG8Z;=P+4GFe=SQASYY3V@?HE.gN0TB6B5>ZID4MH:^2J+
6Q_/3G33-@UYPC+U-.@-+T1WVf[SFdIVN1g71S1+a?M,R84CfYJ<X/5>&b[R(@dP
6NNY9HZ+F4\25HcMKKa)Oe#OgdV-62\6<GPA6GWB())3ZY(G]RYH@,@JV5B,b)a5
R]T?@JL5^>-6:\:YJVH@LCMN\;_-2D?4+_<0=\B(NC0L\;ZOBa67/5JX-T]4,P)K
UEWBWT#Ne6,&6+6SbU@(5\X0302SG1SW2B3M0dGHD51X&DXNRZg>WLLUQG+U@a;6
B:QeeX]\:CZU8UOT(,gROPZ3Q8KWB.H>S;\@)#PE2-Q)^&.MZQS]<(aJaW6\>M2S
DL\I4g\QTdeZWH(U97?,2-\M3GYBB-SOPHI(>[1LK)V)f.Lac1_DM+52\TW1G-UB
3f\SNWdM,J-G]BM-(.#),TLR:gG+-VZKEQ@Y+?(b/G6SU>(]J@]P?Z<eF?-7Gedc
V34?I52FF\@e5;_GI>^9?c&NV;#H:1.;8,82<1=TEdcP&<4B:H?1bI3I26M&0QIF
8SQGD8KQF:WH9fV])Y6]:S)28;LSBQ[dRf2&E4M4/23=-+5KC-<RLU?_cP^VGKdF
N+PG_LM2B]?dgZ,CNHD0O?+,+GZg1deGZFG@Y96O8GI/UZR&&X9XVM4XI__@Df3@
2eF-MZ2cQaQ)MX\+0Z<82F,/<4F6M^6_FB25.Zc_I9DWM21Fe-_@K-J:[#DW.)9>
&X:YSFa4W(F4f0e,2X-\7<a5&/@6;9LJGNOAR\G,G0)[#]UC>XT7>8S;#6X0#cGH
^V5/YC]RFT5IcUc\<[#gQZ[IN.e/L][GQ/3NbUVf,]@ZGW)bSg_A<WQd@Z])61aJ
dPT<@VUW(/EA1)(VL_^G,E/AI32[[D2T.6SELR?Nfc9RYB^EKGaP>[b9SDgA0(47
(aOe(,Zdg9[OPAIA9b:9eV/5WV+3,:7\#.&AVCcEe_]?K/9C??9GE9d4_G>>J77M
K5g(CQ]U6CQU6e?ODE#@9;aBH3TAB1\WLAR/2D>,;[=8R][WHTR&<d8(a89@>fRg
bH)#-8#V07JF=8_=DFZ?c.+LC/NSe(c(>B&,:D,BU7?3cUOb.Q1dS>]CUR2OOY5O
E&,9[^[5[KGJ(N9OGC7[J5-Q9]M2Cf5S<8EPd4V-E8C?U53-.S1A15?G2A=[F916
F-eg2/^ZZ@Ue0[Q6bIWI?<F^KHU>?CaR@>P]4+2(16:OUXQHZ);E3aRFH>.MeJb]
BNJKb+TJW7F(PJVW)b10).O#T[Xgd:d<3>cTE4@PM>eMG/GdB&KFL4OPHH3eFcc=
\9>QY_\b?QC>GCYB.UT>73e<]D9<OKUF\#]5SJUV&d8@L4J1@9D#+?6[VF4A5YTP
VKSGU]AXfV&H]Z:TT^;N3SgYb\T/(EG#K2fgT/.EQ:>XIR9S1+?+1PCBUILQR9^X
C98JMfV@VB]V_FSMIL&a?d#d]\fPY_Lda\M#PcM;@?(2T#D.0.?36R[0^YFT;_Ka
e2gGa#B2dDdXQGE>L@G&3)2#)]gf[g#I-Kg&G.bWM>IS8b4f7E3BT<e00-9Z2gP9
5R0[,E)KNe&];g#60@1AA4>=D-C_BK8I<:Z+aN<G&S2FEU>.I_CS8aL\dKT1HJYc
EW#6[E=>6BA,&>-cN?(2ON.UV[XN3I]&f.LS;.DNTIG#S:&f1M5.<GXLfPcY?O?e
aQ6dH,SUc_4Aa\#-W3D_RX1QDKb6d_1/I:(-(IZf<fP0X0ITbeN9B3dTTc87IK?)
+]Q5\H2<],(,6XP<JLGgF<4++S?3Z,+112e+X>RQ-:?9<42PE/CZHGC6Ae047I<(
X+L[L?NeCO<9)_E\2d1WS-Z6f_G3_)BA3<BP/=cIeRCYWf3GB)YJ[J7WYb_#aA+5
b;EVU^4CBVP>c?cXJfW\c55X+)c;S30<L8483>]\U6PGd/Pd)c7[/&:&(_0WADgX
)NIJ^a#C.X)gQB,IXJEZQTbVaWRZ/4&+<>Q-@??bDbIQ\\92e868B^/I[VD36XL7
5[6CB2#O5b#f)O#78ZDY;E<->W7B?BD5b9^A/,cN/.gHa-C0CCOUePfLH=Y10c&@
_\MSTZ?@Ab#SDFCNfc-DP#/65&D\cK<H;gEb/1KIKBO1aK<]Bc+_Z(KLL0>,;\X[
\ZDH=F?PT-P2R2VC+eT]SGAYB<;Y#J#E8@b++-:D7?E,1\4\>5,4W+6^Y<]/2_Fc
4#(L,>2TT\be<0KBaSVB^)7GL)&POg3B-D>aN&F_)IP>6RNQ9Fg/3<.:]O?bO8EE
5OJ?eLgF2PKT<(aeY&N-T9VFL,=UGg-2XIJ+]C?@7e95WdG77X3/QKPV-=(#4H_4
7-&.8VDH#c8D;-EY#RCM6fOfB.+&#6DXJ91>SIP<GC5J9C/SHAF=8?VAEP39D\NL
d.feYG:<05^d+X@#+9/D,66E.8A,T=KD7P?/cALYNZcg>4SS.-e;Y@9#Z:ALPHdJ
^,QTZCGY4<)bO]Y5A4G9dPYO5^aAC+6cTI6K5TLFg)@g(8CU6N=<&HTde<A=.9K_
T:IBgSdH7Y=PaP61]RA5#..B4K3(K1e))Vdg]&4<?_,6AC5/1Oe<K[B?#AOeX<N,
-,/KP^2S\LN(^a0/WRB7X+C]ERVTT.?_=H4+=,LS]/2P)2DR/d\fP/=_YY>^@b<3
g-aH2M?I0W:7B#9#>>Qe?LaJ32fRRDN\d_89:VSAd0O]O1D/]HKF-9Z9WU^D;;/+
(J]IZ4(Ka^AOcM[=A9cEH]bP/dBa7<A@GG0\[.BcA3YG1^27Z^L#E=U815^AL_^Z
<QYF_A_P]DDDA(dDbP=2QROfbd\F4;_V1Q(PTGQ)Y#W.D&IRM;I\VOD_f45e5aM.
#:KND1/BHSOgabVa?7NVDO+P7C1A8g-c-@_8FLb&PFM)1Y\PA@W::)A4GFBW85[L
7FeB3.6,F\>O?J)d.U/TOV(2Pf_9?\d::VPGGN;#J3Hg;d61FHW+GT#CDE/4;e+L
+-R_a=Sf;W7_[1\RHK:c?DMD_9R/ZeY:\H:CKfV8=:K6R,.4eeWUGCA6,ZG9HUVU
#HE>[gDZ,9935??+@:>A\[F3TE6_LTO&ED]=aa5-RX\d@/->X^A?FR-.dD?[Y.OD
7BA3@L_81#.YUUM)F:0211@gaG>\R9,[.d8U=_;310_-<1HF\4QYfG6ab1b\]6,R
KGS&Ea.RC@HSVK?3CQ#2E9Z:2E(4UYMB]DDVQ^.6CLN@7:e.VSI#a^&3STT;21gc
W=8U5>0IZ=.M7/ZW<<S_1:)JC3;1fTI?>::#T3@e2KJ&3.#gO8YI@PL\O8==@07e
b^cGaf#E\8#4_UD0DS?YT6#;ZWOa3=D+7\UH)2AO5YD6BV;FT=J,8H59VOS6g(9Y
gb0+BB\HcR#+,(1-A3X+&\a3#b>9^D.2CAQFS3&[4L-E/af?A=GODRL0#Q8OYU;\
Y=;2#^cdLBG?N1PN8.b<?;FH5CdcfUR)SQ[Jg_@N9S(=[\+4+)&_eQ0D<KM>6:&H
7B)XZ=(Hg#3Q@gQ@C.>g52fAFgD=VUC9&)dX:RG6&e9-]W#gXY1Z;J)5?BVQ5(D;
&X#=KB2UV&<0N>-D&63>3N-2T_6@XfIa&bPLD>HK?A3GOR=dFW?#E:=W(O:LAgb3
]C^J&0F4g8TQ<+39@2b>#FL@e\A\GE7FTJBX:NP<7\1P1BX:1P;+X^:GbARc_ZSR
X_/K6&<NSBgUZZ0FP7d3BZ2,g3Q^)@)<ITC;_He[cGb5F4B?dT92(:F0HdTTf3Ea
5)4)_8XTJ<L8I,JG@_dE/gT?O,S(95MM[6[5ceI(Z[07d<,e)/_aSNZLQE^36._O
A[[-@^EH]Y/(W[W6PbeH=<b4Z?>2C(]#F(eT2KZd9)HMKQa<9dHQFSeEOA/XYVH[
]S;L0EUBT/d,:YZ+()[+,?(F4[NFB[UL-;9+(\5PH96#\-EX&KgLeff8OF7SC<L=
L1FQIGGL-#f=RS/gFG:BTVB,XfLY^1V)(==L]4(#WdUMU4L4S&LCc1A/a2G,5>Kf
64DS+7()\>MC-?I95c45^9#B_7RJQ>:UGF0B[G]aD1(a\WO;9D&e3^IQaA\WNS1K
d;?>ZM#]:G\Y8W>R=#65#.>]f7eAV&6>0#JT+GB#QSEYf#N837JL;\4:7BQ][cHL
)/Pe#N5a.g>+=c_(^IgD#M3;V)EBC+N=MbTT[1C_ER4?FgYLPRJS>Q\)]edBd8C@
eBE]N)ABO&\BWf4@dE.&ZY6(NE5:Wf,.Y(Sb?78Y1)XH_B5ef8.]Qae?_fJ2/gaf
<YV9fgTI>\cNU_Y+/dYZ9XUB]^F>ZQQ3V1SFO)&.3,[g<EeMCK??B53X[\M&eg+2
5FV5A=f8I#L9([)^K1STR)?bK&Y3C?eJTH\>&^GP@[3LSKGQGA4&EgJ;(-KGIZf/
_ZLgZ0(.\_W6\A]6;Dd]<FLe6b@fIKK(TX;QZGQIBO?KJZ/@B5H)DKNeA+-Vb/ON
QEJ:H(TN\C?[Kg/H44_/AOS8NS<_)?<[]W@SSYb0b6ND<@?0N<6UC?O_;<TEcLM&
J1g33?1<7P#K9\/?0/JK4RWcPSI\DYGXBc>@e-P#VUE^#:&/e48EP>#9FNb5RB\;
g5Ed&fcDUH=/DM^gRg3Ne<eG>X57gI/]WU]f=+R/c/47(:/OB1MD\dQ,S:Y9KK.-
[=502.GF_7VJ:^BI[Gab@JPZT^T,VegHD8+?@HWJ7;JZ@@\g^6[c:5?9Pc63aJIF
Q88FHAT<Cc=,+A72;-)1=P)G0,[@QMP8>;\7/^Z:P4;P?:^T[4]<S+)D7fD7c=.E
C>We6Q-7:IMSe)R=20Z.(>M)JEI:d0(-ccY>IOW@f1;ge+24-9+3&4f83]KNWQ\X
&8\,eZ[01T<(3\<.;:TX<B0E?S?/-3#MdE-64Ee&5//LN8?8[>=5Y_S(GD(1<.WW
DYIDX@^]+Y]VHf8&X\,U=2f[e5M=IQL+.3e:ZHfU^g_dE3_\5_eY#=bF)_F&[FPT
HP57L?_GXdIJ/A?0fD9)c3dIBV#0VPYJT;bLd7/05\<@4I3RJg:\f,VQJZ1Z]:N:
;&IaO-D,EV6M2B>9caFFYNP?&da=U6>-SX<UUDQYG?d66dU^JGWK:?TB(f<I(FGH
UA)X[ZTI(X?D+T8_EJDBaR0G4+]:Z\Uaf)&aI6fU_CAH]d(?5^VG5D=VeA8R-c(L
_f8(:TOB)[Db:RgU>@a]?UK@ddYMU5YQW:7SIWg1e,B5Q]^]WT/A[Q<-8A+YW_g[
ZE^BCY7d)54Ib_&[;RSF.?V]X5O,5<0@dF5BU/8,NHOg)bTfH5)XALWD:JdCd+F5
+D;aPQf4XaB^T30Tf0L4[9UCc>0(D8fLRL)2^NIea5B.R7_./TXg:E1FR5EM:9TL
g&EZ:<E<cSTF[+TK,e_H;.R0-.1?\(>eL44,_EC56>49AQeZ4.?Yac0#]dAG9CIO
.=+^M7NO,C8dT#/_T>H8@PH3eYB@LZeYO_-Zc91A6E>XY,6X8^FEQI(^>VFVeM,T
;L-21;(:?_O-7[&P[69,_=<IdZfP6ZEd9Wg(01YL<3)>>:TT?-JGfV0MeRg.0M7E
(5ODIR7Z7\VDKNQ+Xc)?BPGR)g9G.5]YK7@:\a<:BTFdE,1eXRP.<2/<CB:5O0&O
2_3.83H[E:CPbBIe:.799<C,:[+bCT@Rf^J:(9BHg@]&(7UC^G1OUT8Z(ZPFfaCL
Q(G(G=:b?Y.ZY\,F-Jc7Ad\51;<HMggIW&\^E/VQ(NW8P5I0FAgAFO.]4/(&6Q=/
YNBDS,R::]f_156#V-G\I3.X_[J<V/3MFZPa/XH:J<:dg\<J9GF/bY\?&c.\I6T9
YePBf:R-3Ub<TNFV5Y,.J0.P<7(>QLZgCgIgP>,F7<b02&/1CUP3_WAB(&TV/g]B
f1BO5=I)2Rd]<Zae?CW;gL(JF&@4_YRSN&gD\:IHNRLIMFI196AaOZ+3SE5fIg/S
1[X1>U&8S+Ze8@EJ0Cb#/a/8=0X[^f;Z,DIA2?=L9HXPIUGPeEdY@)?</(I2:?,Y
6GZ&Tf+f/RXc03LN^0L>HAb((NKMI(_9e;N=#gadLAbSJ9/^G2Q/=O+AL2KBL(8F
Z7Q+^?fKUfD?PW4L[bU#U90gVMH0\]@_/]AQ@6]B<:^E,1@8gQ5#PX[J7If1)263
[#fQB^]W8-A@fPETMI.H)-4e1FW9Ua/e=(eYL46#]NL^[)#]-=&=E,ME47<W30JI
O07]9LVI=\9H=KCScIdMS=P2AfP_+_bC^OD(VGR]J,DF\]08<EQF@Y.W8C@(^WO7
YLF[RLZ(cb.CVBH#&50:VX\4&aDN4]LFB3I#3^DV4D?C<IQS/)1a/-9D3@FFAC)/
0\YRZg5GDfH&.TLN]?TFD=?fDX3f=SO=@^[=;b_]KRR?D39dA[J,8P;L)?B]3fe6
dbF^L6D[gc:IdLUeT6#aV7Hcb2X[LSg.3<)YKb4fGKT6AdPNBC9JNY;M-5WcD-QX
UI^3[7FMCQaVg6Rfd[.1Tb7Kg&?]\VY)7(?T>V&K)K9W007M+,7[?cV#PA).-5Sd
ZI2De\@c7R/TLTH?PJEBNL05Rc+)MG:UVg]1[8R.0G\f;N^SAN(fdVb,E52aX>YP
=C^E/EI>Y_&8)#?2(0MPQ?e+a>:_TdaXBH)4TLRH)0#(.E#\CMUX)L3BT,?Y;#[<
D#EB[6b;8b\b=Vf(P47YZe,f0SUbS)a\fRgJ]J1@e.^a@P8#=0P=F)<c@O:Q]RHD
c@BVfIH=TFE][RZ>B1_:/_M/SEg.OS49D)Q3c^Z8]QE3)U-ZJFW8@EZOC\U<>Se-
XF.cWE#^:>1/<TO0(FbYdJ(O;c?;@;)#?NdB_]_=9HTF>2TFH<JDED-Z^VV&g?3T
f@VKgJEFUO<E8H;OU_.&U,,07^VS.c,:@+/E8\V(0J(4M]@9d[8N6H)f,F2>(^]B
T^+VDQb1)bP96fA+AV+IW]CQ.6a&bVcX66F?a=Ic28&>.HHdK8C;FE[DA9GW\b+(
/<MDfUU_&IX9YV].>)9b^X;EcPYS=>O1M[5FXA55WcJ:&bdRZaH?YYN_U4YeMF81
a0<4TeUC(_O8HJR\+&b82Y(;NWf_>;I7C=<3G06+095fD414PF-(/)GH&][UCB.R
dHMW+d\XF6AeT3;46JRBCX5)P6WHEO(6BFD>7O<Y1\I843?NMRG]=2FKg#G00:F2
EI;H0e>AdE01O?O=WRgI6=[Z7/S2AH2c]#ZCd0Y2&8;?gM;:FW_JfAOXUGK0c#/9
[>TB.g=AWW<?@IHMZ#&4fQZU9J+/EZ]F\3Se-2fC8ONcSb(+D&D7QYZ-5..G/fUb
[^&0RR4MB^+/e997aYB=2_fL3W);<C?9Ya+09XKBP/1BK8GV:P.2BKcX32]#D@RC
24V@D&[\BgL>KMJY9ZO/Z2A@PP+Q=c0_0S@3R@>ZGgPLIMDNfG#N<56G8Z=;7d_N
BHbMKBTd645V+ZKXcM=(GS-&<&=Zc][aW/2N9:LNgMIZYgT.JdE=KI:-<EKJ55e&
;9KGJO6FSBDe><+5HaAFISaA7G)AbPgKNTQ_)e/@.cSd+,>UEUOL<NI)0FGZSLRb
?(JG);_baHDK2(UZ^D=8P&LJ:@FId:X,I+6=M7)/GM1e]5^5Z&L??A0<Ag+9McNY
WT\LJ\aK:9<B\:T9WM)_2]]HEAAVOCS)?aK)FXT-FAB9TQYW:[FH-_>9C0R(-_(Q
A]J9I].9M/dOXX4[dEQba<^dgJOS&0H,eHPb71eW6.G4NP,PB4J#[5]8XOc\b#W#
.W3d[&gIQ#L?K,:8FD/W(fV<OE6H0)?#/G>?]Y2EPK9[dH/W<:E0]O3J]UP-gNHE
[^T?4H<\P)4@GJ]/#E0CgJ6WcY5^\cU8TL9aaD=(L(JKD._M:()C<Xc0]N[f,=7;
N)d=GQ.IS[?J2DBN<Y=5F^HW,0_>V]e6Ff)dS=IBS+RG#I0bT#AaP9[;6TE[:JB=
9;,\J/bHXR?&W5J/)^(+4^?.b5N[G:T^2T0gWL5(AeEgWNc-e7HAZf8+WKAFR2gE
^5)S8Z1<G14\=KU&=0-EN[EgLT8U6[+O&Z;[;BGG1/_D.]TF/+[H_J807,&YT)QR
+\JaN>3[ERaM9)7IBE1>W/QT+)J6;3(@b(^RVW35-WC-fRS3\I,<4_@FNK46C5b&
YM<#YWB07eFHK)g4X+aHOH/P[7D<>5WJ>gK\LS#M<Q08(IcDKKgS;XO+3<;RXVSI
[4W9V(4gOTFVNEA\M44c,D.O+6_..LM>1\[LALZ0[GbYYA)2VOU1_(9[/f#eBW:R
Pa0?EZ;F:>EDD[&cF19YOBV:=#9;A4,)\2#9C6YXPX0OLC_-AUM3]]32_EQZ7&?b
I;<6(9<A5/JL-+RAg^f0+:;VF?G-G)5XQH)e^DdFX_/FV])L<b<Y/4O/IYc^8)XY
<C7NT,bN&KdGORYd04d?42>M>YF4X_KFBCQ4@ST#C:YI3Zf5CeF]c3P+bf4bO?LI
e+_?H2X4#Z(>?69XUN.Uf-7P7<CKZ\MSFRR<KG:8:L-1E@)Z4JB<MOg[&a2fDR]3
#PQ.WH?(aKSP<?O73ORJ9fFVB>Y\VGN5U_HPN>N<:3T5+Y^[OXEaYD;]-FJ+fSTX
C5;26O\=d20bMP@B[\J0,&7]@:>R]CX33/AW=\ER;/fAV/X_EegaX@69>O>HB[+-
Ygf#D:bZ5&R2=HZ-8DB09gHL?5);)5C;A73<1B0FdbHb8:;.>D^6a=Ha&7YZE1XN
^\A\)eBCP3,D;69YLVG^4<EFLMHd=cFB+X2348.RRSDB^eCbG,&gUN<If/X\f4I7
>H_K]E1J3ICZVE]\]bTLCdQM8P/Cd.N:g:QBML@fS6[O,bO#4deRSO4A\+76@++,
eDdS<fLFOd/FP(1^6[2\>S^/47=,TV^A4[/KFcd):b0FgX\3V>2dT\1,+T@H^O0b
(_V)=YS\c?;^NL,/;Jf(;=@:NgI53NXV7?e?W^g5DI^P-Q;947+:+0I8>>@>5U-C
fW15V^>I_;#dXZOA_Cb3D?KDTFbEG+OR>HcSJIM)4O20c/RT/aRd3+/7DOA4d7WG
#ZUI)Tf0P9]3YE)CcYb5+c1EYEZ&LQg]BGLcDS.^><g=8[R?A8\#eXa<IB^<YUc,
W8&DFTOY@)@,DG6;P\[BJM-I@XE?+SXU_#[I@cPT_@#G,V0AKD_^W#J5De[12T7+
5TZG>?:B@=S53Y0ME@I2:,:ND(\8+(C]^M4ca:UA[6L#fCX5SQe_JX;KSXJTQ@dG
6daaWc6WZMZ>SeIH@5I#^Jg(C,T+a]R\8_E\cK#KS-gUR6AFD6_>U]6AA93,cT6&
^4HZH(bf<Xc0)IX=18a_N]LZ^[22/<4Z+cYPEgX=DbV0K7-7U#gDX?/\P+IFKaI_
2FbQ-U8>78fLXV]YJ=UMB3XQT[EF;9OS>;HDGb]cAY?X:0LZAa]+_<E[.L=5bCB0
7Qd-[;]:Z/U8-?_\Ab\39^@RRZ3fd=fK)/Q51gVC]O+3OC6d>]BHG8B\?\2F\T@5
FJTbS)VI<<H=W1:H0^H;G4Q<V1c91PA8.+dAFFI^M1bOD-OM=[Vc:?(&S(1B-[VS
&,=geJQC=a8O[X;DMfCd0LYI-aJPIVI03#00I(B3,44(O_M9?@BB=_9;7<fE\382
aCYQBP;+@X\D1@/]Q:b/4V>/LB)\-A=UH2BTB,(Ue@TQNCbCJ9cFHR20#VJNe7b:
G8FFZ72W3\WIO>Y\C^_6YMA;63[/)VAD#]Bc>aB8cU]P22C4[WaI/FFG4fX;@+>Z
\?c16?[:UIK(WfgKSRDL=.CcIOO.e)2(dg9>A>1C6RG:,772a721Z)_eK:L3+TZ-
P7)WY4CN:+Le:772F1L20Fd:e_[EgO9H:K4E6GDEY8aU+^A@#F[Z^JZOH:G?2^[O
0?Dea@SMJ8?V]&4f(UL08W\.gG7:cG:bUK7+3D5,9:A[Z3\Db_=-^]Y^e)aSJc1(
]2(.]PIJ\]1/:3PLV-0B3#^ZWQ[A5MWAbEU0G;gMSPC@EN9FUb3\F49W9LPSLZH8
W&KAF/g@JFH\c7>@:F@&9IAEG@M,96)CZUL<8>FVd>;K5GWEW:R6C5LYC73;#-FZ
^0B8WfE/=.O)[W=?9&UD@W991.3YDKSERWOgZ2B6@VI^Qa;dF1?f545faa+H<<.X
-.0CHG[ea:VWW[0DQ.2;C9OGdfL<==?TQ1.AeS_OX<c,NNT.F<V8I;8-_9WO5Md>
5GfOP9A>a]7dR21G]7WUQA273H\e&V3VgZK0?6UPdQ6)>K)C?\EAaP.aO=\[K0WB
,#7\-fU<.^4c=@-8e-J91bS3:O00&KX_VCHgW^3Q/:RLa5CN-0R@3()Lbc,,A;N0
I];(\6\0,\^1S5:-6abDP^\_<H6GO>gNP\QYCe<N5ZXWY[I9-H:O1f;e^f((RE53
6<ccB6F4VP,@Ab9;5O#LZgQP6=GB2/#4#SF5RJEFC-9g/UU-3U)I==<dM0(Z4Ba(
^Z3_GCO0X);P_25JT[I3+_IM5D2f6YMVf6NO0=5]I8.L7eCU^FSc<(37@>VD&\BC
P,/e3J:6?]O18)/?)1ASJU#9V;52a5I0EHHYD83XgGC9\2TW^C8OU2K<^_TR-b\@
G)C;WaCg,,V-0^:\d1B/B)>&[7d.[SfTVP^G/GPbIFS9SS[R)(I;48+53fa>Eb3?
G8ZHZ]+=,.+\55d-AOQa?_][X?R3NN&84JW607KW8ML[JV&3992bK:)I8aPQO0d5
XA=?4RV-E=A.<DL7CW,9/dHTX=cC]T25X/D/fJ<,LY+9\a@U?B#;#7=VFGD)&MFT
4_U3SST=f@]-I=<N7feQQ??Sb\E)15eTJXQM1G&(E6^^L^U3Z<?D=Ig/^,&2@GfU
?:.Y9/A8D?R2N#U/C0Y(CdT/W3=P@&[RA1K<LNR?FM+D36Y>c0JgP\2PVOA&US:9
e@8[W-+5dQ>9@&a8;AZC\F;7^REM.4,<g8L_78@bQ:O-dHYP#1e+>0YT.[3;IJ<R
fMNU]/D<B>df/c3(7L3;QTY=V>)9)_7X?YdDK8R7Z0^S_7LWc5\N.6A;S8KA6+-,
7=M@c_UO?0\V@2;KCgG-S(>:L&ZaV8,<YUESE8@Kc)L+Q,ZFf7aYcFT7eg_[.MdX
@ZVZ7&/EV:<<<g9Lc33HVQ1#Z.\9a#KVJF3T>77bf?0.Z@3Id4JdJ^O(7<@Y&^O=
84VK<N4;>U[GLV<U2/b6M/AZ=O[RTK,IU4W/.<,MXOFeQ-UC-Q@)3-QE#Ca[c#\L
BF]C3d]ZH>_aXYaOBT0#<D(EHJg\/:e-A?<-)]FX(W0\c4@Kd<_TFXOEU6_5YIYF
)BV;60d+HWf@L,K.\HAe4W26;De;U4daFBVL:MQCHX-+<GdcHTC_X.P1,a&(Ob&0
fTZJP\M2]]=7-]_-ff/J+aB>1+WJ:d4L#,V4G:9GdMHZ-8QO()Q>-[/27V+Z2g=/
^/A/9Q7>f9J^FbeK8G5G@2?6NE5G8_F=(=DSbH)+6BFc\+K1,_D7#gYNIQ(KDc&Y
ZY=d1GFGR2M.F3JE2g^:?(V.Sbf;LM/.QIG_,5[abgG9KINgU1R5c;&R2=a.7:CL
0K)a0ODA)T2\>[/Vf^WD@&4d8:1F+<3;SY5Q(X4AHdT\b7cI08bLHa&FARO#WAH@
0T4JaQX#=e;]aD8D:^IEfO9DV8?=6(XJ+82N/5RQdR-8@6+XN;6P<&KF8)]:IV]Z
d&C[@(Xb](+P]2a3:&2/QG4Q7QWHSM2Ce[TVYf?df0XaE)9[3-@Ef1?V1R;3ZAc-
0#:VCNGK3V.<0P+L&9YJ=;_FUg@@C1#MHb#IP6J5T-KTRL8]#:.5ZSM0QGd64b+e
4A#3eA<;bI73HH@-?XRVXNg=QIQ3VKX-=Tfc07<PV^?L^V)\L)G+@T5]d1P27_W^
JCF&_-I+XVVTR.(gZ-;0K11bIKOE\])QH3R8F/d7G-e@eIGA2CT[ga6WN#OdSaeJ
TbZ;-3EL@g+b7=RUP3D#da]T(c<5JIYPVM&;P;eIda#-c5(YYAb4dc_T;6X;B[=c
Z4=>RBTME,-VIC;.JKg=3[1]+Lf_Y??:;#4#c&<M?5I]\Z>K76]0gV2?)W-BY78\
7SK/]E)O8XG,Y8>:D@V<1_3>G:bdI@<5;^(eIW2dTLf2W9H5W;,-@US3d_;8bL)8
a>_M6P7R825JCU26#Ga611;)@_WZVeE&geggD7:8TP?c5RBg,(8U3ea+gJ3La;>L
N?Z0g9gHM[=\<f([E=<R@6PRb(H7?O1[D@eQJVO0dUQ0-8<)LY?1BA@<NfYfH,c0
@3A(6f5D@?R<=Y#HDd-YW+7#R,Y/^4>NSEI8F9XU3(?I6aVY.SLW)E[;UU82cQ=Y
d--#CAD661\Pca\F4,Jaf[;DRP]c>MO;<K_5c3[<fgW\W.CA/O,c\+P#4-^(,NVQ
WE<\c,g-K<V39d#^_b6]P0=b8ALW@+O&TIHOBIEJ#<f,3T?J\MRP-60G36f2:Ua1
TO].9FC:V.,U:_V:3P[f1KXZg3R^:48TT4LO20D7-@SXW/Vc.._8?dB3IVZIY++D
#A8-W?1O1[LGG_[5VDd[.9A5+LBJ]Q5fS,d?9G2.8(fJ;Wa3<03MYUCeUM\U<LGD
2_V(bF6GG[?c9GWXFdG.c):2P.VL,CEIZ2-@4QM@H90a@2;4G#,G(:T>eaBPgZe]
d7;\)HL;W]Y<f4=SQ&c05S\eDXME=dDL]d=950M]N9/9&ZUe1aWQC,gVCc#W(B8e
[LfPUE))d^J-+/Y6Xd=[&T:A<V:D6gB4U?7P;4,>ONdXNdRJZdJ?RB)\E=S23R\c
T-GeQDWb>Ic?Y/YMbJ[=a;J?[Ef@OFZ,]=DEL:gP?bbMLMI?.@2cY,6P,59Z,,I=
2KeDLVLEGg@-Kg_W(c<7C>4N3M5P4/R9ZALZ7VQ<:9cB\7LC&/MAKJGQYU-&^D[W
N\TXXEDYcPR--$
`endprotected


`protected
R1YJ=P-74(]4QI?fN/4D>4NIOEM,=/c7CS](=\&I^V?0]O9bNLf>-)g/XD/:?a;_
?DF:DgN[&&<-E>H[Z+F,3ag9d[U9K&1\E&K]JUT(WeV@FK=B/H&O4L-WH@7.Gd1\
KVegZ3I)\SLX@fL;Kaab#R]O11HWA#DFP#aS4G/U)/PaW#(OYWV^,ZHU-7FSDeA^
4I;EM#-Be?3NT^Q4I<Fe>+B3.M1N]XU)3H8LK1LZ,#e6LL01LEgA&-TX5O5<:()E
WfS<F_M-0b:>R_<_89\;AYfX-?S5&SCF0Jga22)1=2EaXZ,?IIM+\eM1PK\]<.QR
9Q_)M36=W9M9RKd@7a,1YB3C^-+V-T&:IM<JJ[3a3,ePgNDOff1ee6&[?6cZ/TN,
T0\]#=DMEE6Y6^Jf9[UX05M](>X)YH5Z1(I.5B&+89[TOZd7<?8\72]c55>=Uc:S
<4bAg/]CTAf;fI#d=SaTSGN_cf5C.dLL^DKG98QAP>.9ZaV]\L#4cA8[@d_?]S6?
14?SOGfb:5B+S^F#Rcg\IaSP&)YJ<7=PG.Z\<Q/(M?aeXfL-(;3-7L9H;-<Qe?:P
b[[S(OW:DTX41]P\Y7R(SS+B6YNX@\GEJZ>ad_KOOFQLaE71Z=FF@2V.D]9V,Q\-
@JBR\&LH_/:aSW-L+#R8+[SRMSf]HVUbgS)2bBEK;5\5gBCRfK5E_61e3OMEA:EK
J-7)b?.H(c&)O^@M?J]2A^QXRebEOd<9JX9-I9@DZV_C59,T/L]Cf=gH;<1Se-Q-
5X32T,,KS\)X?Eb/<Tb+YGKde.9-&+KE7N=M_a.178=fG43)&=2f97g#-_NY@dAW
1VXb3,RG;G1^?G<Ja1_R&?#1gUT/EOIF(H@I(SQ=E+V/(/#6-]6_;B&Xa+:JB7]O
ZKYTM5?#@,,A<)&&/YLgRS6?<H&;TB6](7^;?DO39cV/C$
`endprotected


//svt_vcs_lic_vip_protect
`protected
aBX\dUHgbWG5;U<6c5&eXZg5IO:TG?XS/F4ZWV-,PNf9.6P]0H>M6(>B(^KE)\>C
WT\B.aPbW5/H+/#@,LTL4;.-&(=4MZ_2ZZ1Z,X#0GLMSdD4[^_@C5eI;QMB#]^I]
<?&&J0G\P>MBI<^^#H/;5MNS82BfR4b1D8>+Xe72f0ZF].<_AQPb9^X+YCISLGG2
#SYXQ+-39@X10B\AC/?.@-I:NN,J2g;Pgg+D;QB2b^E0F>D4JZ1Cf?PIMS(Y4#[O
&2]/QcX;S^XJX1=Lc&C=,Lb[JaUMC57.)b#Ib54[e&+Z=KG.H]FVI7JU4462.C<5
?dVE-+/JD:5O?>1[O;fDWTeOL0O\(>_bF69AEB)d)0B=-^.L?Z6ELY>P#4IfMVP+
+S#R.^JaLG[G+_PWUXUMLK4;>+eTFgARK]TaXbP5;4(+c-^P5c/+K1ZK2Y[bfcW1
VR::KF>Mb[PQ>)H3)[C44O8_=A-2_BRbVHg5ZS\G;585M;dg,bRO5WD]/UZK:=Ja
]4FR&4>F=K/N^M;bgO[<HfLNZB^\9>TFg>B2Y#dE^^H@.-cK<\P/C<25e_N6+RRQ
T80SWVT4(c?5W7],&6G?6JMRe^<c5IO3C]]/.gR;E>VeXP323@eY?S1EYG?,USEZ
+UOHcMPA6;@g_B&Sb:HNLD4.&7bN2c0/JAS##D=db/=Y37:4#bA2A0DAUYbc13K@
)O@:UPgROEDbECW6:Gc15f@VL[_1PU:1C?d9_/XPfHQ/;DOXLO8Ie(?>aY/GJX,/
9b#DgN;#::XN#MKN3VA=6;K1cFgBUYFZdS6>&IN<.S1=Df;6Ga<6c[;[4A5Ye+CO
U=;LFfOZb<992V_7d..68[+5aIa6=Re=\?HUA3cW>F+=H_EL4b7@((_,2P?ZI-;L
PH@LFee&UZaKa0CGKcF;aP5_D#T)I:X+<b_+H1LQce40T6R;[#M1Ed0SNC&,UR@#
?DQFRMd<1TAT>OR147gZQb\d?UZ/JS@JKBIL(Ab9Y05IE&M\-,6;DFgR(?B&-IHM
V/?P<.H0C-92:7b+[+;PW/(;GBC-bL64eg6A1Sd)R^FZ9L0AC^-d&IB&bO5_DfEZ
APa[Y+P5)\d96/.BU/([Z2W\ZO?3+ef]0?LQDbR=[5DH8I.Ea?Ne,JEGFaPSPLL@
,\MA+5+#SQEO,H+JUT/L;6^S#^ZJ?NZV>4/#QC.,3X/KH>&-9\O]#K-5Ga7J7FKL
BXBSfKTJL+QXg4@YQRZ6]Q>RfXT)HF:,(d&6_Y^#[27K[Zaaaa8H^[6#:<;P14PZ
V,R:WU#g:(XCT18?<@aQO2VC3+C=/?IX9Qb35PedcC;XT6=NPB3@Y#)C91Sf#N=A
8e?TK&C,[JY=8Fc>M<TRA;TX?Zc4FFJ8S</:[G;^&Q5#_g&C;R:P[)88egN4fbGB
6(J\IUX8LWA#E1OeFZK&<CXbNdd7f?1C(ecfBHPCS;3D/(=ae4I(Sg?U#Rb>WQZH
A@g;2@6WH?MX#IY5bJ0H#=Kg7eQ<W8?3J3Y>8S560,e&C+5J9QVa.IWR7Q,SZ1dI
Ue.=6WHZe8<4]E\Z4c+CL^I9NcXC2K@F+J5\LU<5ce[IL[AIGW-;W8OS(NJA<I\^
H;+e,F1:_IQ(a8Z(D_V[87AC].)2c8_,dLG_1&_&;4&I>F0IA25JAg;/<OedbWOL
I[_<e)TBcHL1]MY;G6-SL^\=2QCg=9:B)V<8,L+QKW\X_W6;2=9(YgX5aE#ZP)Ba
\:98=B[R#WZSbLV,f?e+JG:.7:U1I-=E6b0(c>^A\0a-X1TPC<>)JOdJ;4Ga3b:1
PbJX4SQ]9VXSQIG84FYC>@X)@\[J9_V.-E_OdVU<UTW\6a/V.K;3-J<\Y]UQ<[-4
VZ@:V9g(\J<VY]#g^cE>8XX9YSHR3,;-RJaCTE_d9;^\B$
`endprotected


`protected
5+^/43+Z^@5PO2ETA6+3().0EQHXGX/-U2ePSNYdJ)<)WA)X79b8))f;[D4>IO5D
4H;6K0NZ3_dS;&a643)Ib&L7#Yb:8_QG^eWGYIQWaU;KfE1bdIUG4+\EH\CP>MU9
JNY:f5[472_??U53ZY-PJ<R3747YaP&Ca9;@?)X(_A(4fV>V\>G]Hf@)R:RG[_#A
O.J7:+E[f7QN?8:JX(E1fb.#O17?2#7SfO884##dR)OJ,@._GQ+T13P.P#ZFA+CX
K.gNO]#Q/@1]).B68IbT?Q+Yg2W\2/7P_MV+>^M1@ge[N/ZC]U<dI[Y:PeA<JNY:
-UM/-R3\@M_1?A4T(X:)I\O<,P_c6(04(0..3\.X5IFCF^B]QY9#Md1W-II/.]E9
OBX.8QR3Z(]Y083@B1Y#29TRD,)MgOQAa^R_gdcUSP&(dHeg8?;S,,>.5/B]=_JY
^RU\,J#PO]g\(Cb372\b8@VVEJ+Z/,aDe=8=U=_1(BgCZa5B3O=R_fB6LY@XYD>_
?Ta4PcFTDQZRA5;5T2W0Q95fBB5/EZ7Qb4?WO]C#PD0Cd]ZG2MJgeE7La]>bfH2@
(H>d=M_ebB:_Y6FVPJR^V:P/PUJNb2-GQOaA+S.3L)<,06;,OB;UIVO(1^P=USG\
47&FK>ZCgP\56H6,&J/,AUVUCgc;Vd&d>8B#4,Y5HEG0YJL]e,._<?10=_N3U)@T
2b=2Ia^BDMf]c3X?=e44^<,VcYY4X1/Ye8:+GZ=CH](V_E:0cE;JfgGY6eAQ,+^:
GYTI::(O<&BeAa8JbF^[NL,V4$
`endprotected


//svt_vcs_lic_vip_protect
`protected
fJ38_I)BPWM)B3<Z8/=KZf)gE/0\0e#YH8<ecMb0>&;ZP[&g6>R<&(]J4[c_>=a^
H/;0De9#7DYJEW\_a?.69JdLGU+0.f&9:Q&1ef?3-^+)6c+)Ib:L-=^5<+//1@g>
RGf4I1\_YMgMOA)/Q7T9,e4SYD+5?YEOH,gN&8LLJXbUfV:[dTBZXHC.[e/&3O?)
g[6TYEU.2/]4>F(RNR[.Bg:Z0=RI0=1D^>X,@P?F-6=;gQc]H2^[[]?4\7OYUZN,
EM@=9-,:8OE/FBc(cC<_SK@g4/)6-VFJ+V\LC]KH@]1P^20\=ZC10&)KZ9_SFJ&L
Y\KY=#-];?3-QTQ]Ug?K,4bS0UGT&eRXSEY\QDFHb=.4e_PM5c9:7<2+@.^XIO7.
_CT(.4B;L@0L>/FGZQb9J&W7+\9)AH=0GCE+5>XTZKNL>EYc6>gPRK2>@[4ZDBgb
g)0g:(&L+AZ0XIZ+BH([Q^1/;BN/[IR(HFeOa/P<GaX2YFDGD&]WZ6eG\Y^IT2+K
_BgAWW9S._/FTY>_&-GLCab5^c/Ve1>VUB7#YYEB<3X3T_a[O.@GD/f@\]H1CR)b
DCA]gGg:5Q[^.]>L.3FL]0&;;+XS4+5c1H@I2WSQ)W)/HASaJd3I5>-(DabI8[WL
I_dKV4C5,KBD>.e8R2/-#C4c2fBDW,R#8U&NJX37gJ:f>2LT[VEYV@6.=NT<D+_T
=7045S/Z&F81&.]fcY@-/L_E:cbbZ67<]6^:CI<E/K_0bGTPX-E4H7]N.8^0G]b6
^>V&H_8dA0,C<:K)d(.aETY^1Beg:YIS\_c6PcPEd#&L6X,a\<JdS>4.>,KN@L^B
8#.>N&LRQ1WVA(7_\PM2/Y3YH\##X(ZFdW7_HQARaN0gH>3[KbE&]5a/Y?.&4,Xd
9N&8_-Q-.3,KDaNcG?4Iaf1>.Y<O<]Da^T_KcUg><NMdZH,N@4/NfG6>cHYc35);
D(MYEX4?E?=+\WDb&:Q2[@JX^<dVQS>UL)YL\>4KafDb9Z^g?8c9#6&03J0(]2(C
BLe8=L]eL-AG5P3]1D]]VAA-_g:EK.265PN+eOT/<e>cF.cCbU@)RZI[bbLOO0KZ
JbUZYYa\I.D]MQ?]aZ800cPO#LIW++2bLMY5DePY>P--TW0<I9Cd5ICW3&</>,.J
U(?c5A]A/c27H>ETQ()4])#b)&+ARX7JXLM+a/fS_TVdT#4eAB&3;7]?,e=U:GH#
F:J-DXI#N<b9#:>EATUQ=aK>4WH93OBfFO+gV_7gaWQ=Pa+LB9V-NCG_:bT>4((1
gX(dGW7I_f=Z26IdB\d7:6EF1&dbH2-N3L#__^J5g^H7\3&N=U.fN01.05cZ]bbH
K,ZeHM6I9(WV79FEaU2VLdS1V8dOIUc)^T.5Y)WY4ESA#IKe#YQc,L-e-[]]J.\H
QHH>8X^BT0]6WD:TGO.d6])be6.J0G9H8QQYG2?=;dO:d(7VW2K(.81?X^Z=8/V\
J@RSc\=9XUAOV1a52?+RO:NQ^QeVa-,N(WP0QLC1?HQTTW9SIgM,AOfL-6-44Y6P
Q@U\Z\O+VXg2L[;91[G+=O07c_1LdD:.)K^&\?AeB>TDO+^d9L(<-e,E+-b_I@g<
&M8DfFR3-V>ffY83^OE8NU,\c9Q=KU-R;eFb9G9b7Z^5CLRKdPON[GfVBSJ_0SP5
c,:Re=&G?f)UOM&ZQ7]<58g\06/0IZEdYg,O5G?cS24((AHTe-3IAVDUOO\QFDc(
U^:C<4TLK-ABN&]7QYZ29AEZ82KL)egBWN[LKcT9Y^DGbCX]O4I\^8#OA.[55?D+
E)U^M7S@MbXeG>SMU@8ZLX?X+TL>dP5>,-@NVI)Af=-<TMIKQ9ZKS=8LFWc^\Z59
(8;JO#9BDZ9/VH0QNZ_MVcfCaR16PV>=bAH#c3NDbLE2E_8NQ77DH,0P4IRZIHV]
<C606/X=F4??W:TcUGIg+^2bLc,d2U:T/FK?77^@)1N+3W=_CS:Q:739D(J8egK0
&b(JBC:5&#7A]A5B&[J,R.fJ=/)=((K,NC@/.;;7^Z6_ga,HYQZ24V?R(\)UWQXN
N:&;@S?LCLUX_KKSS6J,,:N2U(Ra,U^-M#AV]B^O[DDF:Bcdc=:J;OJVEcfEK98L
::\+XOF7,b76AeWU/LL+#CG1[F1VW]&Nc_2[31GAS+]3dD.\fVaKabPdT(D&3V_T
,R0^T^WDAYE\>Y./[?B/)=8T5,)IQ9MK&8[@(JB&H&^MT6R#I^P?_XQ:/5J)WeY@
Ja_@Z,Y?5DE[ZJ..SW8N6d6MEK.[WK3L7)PEAL>,JDfR)c38)FFRI&BBRe1UG\Lf
IQ/g=-,QZ/V5_ARAV5#@S6D,_X02cD-\3<6LX,IMBQF8R^J;KGc,T,bcQc6g)aNQ
RBY@N6[>Q>6QLD>1&I&E7T1a4:2QSIc#/H<B1GBBMZJ:C.N8-BJIEdAL4J@fM75N
e]d[1&Oe)(E:^Z<c.6214R#^eO;;@MRbG3\?4b0g8KOd0T+@&J9C/90LBZBR<9VC
&F(Z6P?I_RQV(((0RbH?5#eLL)-?Z5g>IX3GK=2<L:#>WSFcI?1@<>)XTBYDb5CA
-UC4889;#9JWK;Be=V&feAEY9>G]+g@TT-OC[?WRX<@NP@Y97O#15]A)0f8LGIe/
MR=f4M-;MGZK0B-AbF?+F[-I[R=K\S.<K@L\RTX+B5bD<V7eT;X:#45Ie^IW]2ES
3#XR.^R^B4?f82.f2ZId=Gg]F,eg+PJMT6]@8KIc^0LY55QHPa=6?CP6WNWU4DEM
3<fYO6_S@S<@2/S1;ND:c7>ec6.T<4H?8CH_>R2+^)aTDX=2>B-+K.:Cc@MR+;gV
)>^SbEcYObR,-_5B9SIe1;Q,RDYI,9XU.BMX5TIIV9>e4-W=;PDKZA2/:,:;?a7;
,+M]3&-2\(M9Cd@KPI6;.)b1I\KP7KZ\OPQX2YZ78J)0[\bW>801NT[fHa/59Q1g
@#Y_&[73Y9R;8/c@]gC7g3LW2_28cL7/5U21]L#VF.^B9IP1\f65+GI@dD.1dbP1
M\HOQ<VPPeFLQ/YVegBMPCS(bH]>YH\XMQ3a>JVXDH\5D^JO_F\ZBAWJ;.FX=QcI
ZOG##T+N>d>cV62S2IB?S1a[;F7WOXO3N;>_AP#=WJR4&W<)I+KR3Ued2W3F4RA_
)UC+/B(OWKOD]QBg=OWA/faODM()8A+Q^,VAV1gV?(-4D$
`endprotected


`endif // SVT_PRE_VMM_12

`endif // GUARD_SVT_GROUP_SV
