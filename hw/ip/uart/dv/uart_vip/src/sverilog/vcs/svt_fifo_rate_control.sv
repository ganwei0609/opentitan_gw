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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL
`define GUARD_SVT_FIFO_RATE_CONTROL
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_fifo_rate_control extends `SVT_DATA_TYPE;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_ADD_TO_ACTIVE = `SVT_FIFO_ADD_TO_ACTIVE,
    FIFO_REMOVE_FROM_ACTIVE = `SVT_FIFO_REMOVE_FROM_ACTIVE
  } fifo_mode_enum;


  // ****************************************************************************
  // Local Data
  // ****************************************************************************
   /** Semaphore used to access the FIFO */
   protected semaphore fifo_sema;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object -- only used in the call to the super constructor. */
  local static vmm_log shared_log = new ( "svt_fifo_rate_control", "class" );
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  protected `SVT_XVM(report_object) reporter;
`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** FIFO rate control configuration corresponding to this class */
  svt_fifo_rate_control_configuration fifo_cfg;

  /** The current fill level of the FIFO */
  int fifo_curr_fill_level = 0;

  /** The total expected fill level */
  int total_expected_fill_level = 0;


  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control)
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
  extern function new(string name = "svt_fifo_rate_control", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control)
  `svt_field_object(fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY) 
  `svt_data_member_end(svt_fifo_rate_control)
`endif

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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

 `else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif
 //----------------------------------------------------------------------------

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
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Decrements FIFO levels by num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param num_bytes Number of bytes to be decremented from the current FIFO level.
   */
  extern virtual task update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);

  // ---------------------------------------------------------------------------
  /**
   * Updates FIFO levels every clock. Must be implemented in an extended class
   */
  extern function void update_fifo_levels_every_clock();

  // ---------------------------------------------------------------------------
  /**
   * Updates #total_expected_fill_level based on num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param mode Indicates the mode in which this task is called. If the value passed
   *             is 'add_to_active', num_bytes are added to the #total_expected_fill_level.
   *             If the value passed is 'remove_from_active', num_bytes are decremented from
   *             #total_expected_fill_level.
   * @param num_bytes Number of bytes to be incremented or decremented from the #total_expected_fill_level. 
   */
  extern virtual task update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);

  // ---------------------------------------------------------------------------
  extern virtual function bit check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact, 
                                                    int num_bytes
                                                    );

  // ---------------------------------------------------------------------------
  /**
   * Waits for the FIFO to be full after taking num_bytes into account
   * @param num_bytes The number of bytes to be added to the current fifo level 
            before checking whether FIFO is full or not.
   */
  extern virtual task wait_for_fifo_full(int num_bytes);

  // ---------------------------------------------------------------------------
  /** Resets the current fill level */
  extern function void reset_curr_fill_level();

  // ---------------------------------------------------------------------------
  /** Resets the semaphore */
  extern function void reset_sema();

  // ---------------------------------------------------------------------------
  /** Resets current and expected fill level and semaphore*/
  extern function void reset_all();

  // ---------------------------------------------------------------------------
endclass
// =============================================================================

`protected
@/K.#(AGSPI(aHfF2D+D@TeFAC/eNGXK<@?UJ9f40U]a\)\f8P0<2)a5.U<8e0(5
1\;O>F>OS/0)CC^SC;I#L.2<SZeF?M]Wb&9DR:35A0?d)X<DQ4O[=&g6(/L7847+
B2]J+H3Q/L=(MPS-Z78ETSE9@02VEaZK]/cQNY#LPIU#=K,)+\L)&17U9.Je)-e1
\5IF[YE-5bS0<>=1LOQS3ce@0W?b\:cDAST.7:Mg.7JOAG_cV)(K9?/+>1:PK4>&
9E6U0SeJCSZTKOe@7Y&4FW;Qbd<AVI=_AP.PfQLd#D/b@e\)IDP978d+/gA>)DIF
b+#+YPgKN]1PY44DS:62M>EMU0Re<.M[A:\gGaM[K^]4\R6-L#Q11VSHb^b;Oa-1
XEW?F#2^2K+_:U/E<S3#+VVgC-H+36Fa)IL;I?b]J.;8d/&7fREKSQ&^)&19X^I:
)ZV;V/(W0f4fV2g.76Ka38MS;)C:#Be4D;;WW2V;E.HCL]_f4=_TBX(=5D[F?/aZ
a,]fSXgZ-23_Vgc3GIFPB02NbeaL>:?98TDcW?e:6M-Xe3<N3fD3SXg&/2e6F0#b
:(TTfHL;)6OYX@Y2]9XAB[>BG9=XKZ@N^T0X)/8\;PGY^@14/TSfRg2V6[3a(G];
($
`endprotected


 //svt_vcs_lic_vip_protect
`protected
/:/G3M+@N4.BSYI?4f6JFCSON.b(<=1a<I^5CXe4He_\EJ#P+EZV3(a:D-^HDO83
bBOaH/;5F#a,?aaF(7/7/@I\b5-ILVbN;.M[[0(#ZL0_&b,RG5/]YE&6CU8>;1JJ
K[9K5CG5K\GZ0D?#BBR_fVNGZCbN7f>K[Q]X9MM/dJ]H0OHN>cW&.fED[NFRQ0Rc
cD);&]IE--TTAO1Xb](]a.)Z4>(+EGG#5c0C2bJM@P>Ea+-#.;Gb8TE)cDg8DFWd
NKQ&OH0cbB2I8EK+7U3AK#@3V9^8]12PMR8YS-VWSf?BV0H&>T8DC)^C>F#Z@A-8
OB?(VL?J(I^P+6:^94@E];A.<WfNe=K<-:8da>6>CWJ6ZM#TdK&[1WT[6ZWCS[/b
;B1\\^a&[&.(#/G19=cgEAV3H+=R4_2L2?>N-fbRC8/S9b?6=YO&^[UeWE0Q2E5@
^L,&f0dNBVI7]?J>,0<[^2M=Y]FB4,WCPXG]U0Nc+TK:0ZNe9=_,@M@J<Y@?TE@1
@PI.dW[fa]UZGP1ec?V7^EL5c<\8J5H)4B]7[WP(&BIYfP)[6Vg[\c.&54VfV3f8
2b,OGJ.-<4[J0J3>R4FOOG1FGYbAT_@&AKQ5>V:YA<)c/A)?[C-a>D,?DO_cB2dS
URZ9.UJJ^R2gP791#&N0FLVLcaWDS:e3b;S^G?XRe2X,dC\b^/]B,7;CEMG7GWb-
8@A4ZZGLEVM?/A+(_c66W=BX9Fc:8\bBcELSZ0aMOS)^8\32KH>R=DH0fce69UaO
+=;4X2B2:Fa,T@G[cTTPV+R^^H)X11M:QZbH/9SU;PNYKQSXK10NCJ,]-FNH@D9\
JP1,ga^C#:>eD9<0KAD6Y1X=5d=]&T#Xe\RO_)038FKB4FQ._<8f90)SF]^=C)05
>FX#9J/4HH^GB:>=SAeRZ9E0UOA7.Y,7TU_5#46NcRE;.]DF#F-TAMG-I^07XJb\
M-8<<1(R(DDeMP0,YaNLMNM5A<7#T]=L^UNS_D&MK:9QRd#L6=JeLEE87N/H?@L>
f8R<.=fdESBY6aVHD.Wg\;DE_XdV^/4ZVFe@[DT>K>^]R9O8eSbg_#L6XJaVJ>@U
4eP.cWV@CY\WY[HJQ=7:UA(95IXe/=]I\13:N#.QB82Q@1B+K6FGX?386_(gG,.H
915XSO&cIGWL&[OXZHWU\MXNbP\;)e6Ec4K93;D?LaE/8<[fcB6YAERXe54a46?.
<B?W&Gd4KcLG\GB@QVc?QNOC5.aF;<dW-&S2eRB7b8L4RgCMga=^(-NEPdCd&MJf
Ra=]ILaIdB0:S.2#FeBD@EB:2bg?)ObB.FIK/#Z.TgcW(R1a&HIVYMX5Z6O-<96Z
&0g:<eaK)K\8eDd-3DK4D?G=C?8bb2@OOSRf>+,C9LJ+;55[:QG/QH3dSU^Q#/GF
WG_#F:MU_>SDJJU:Oe4<:3=13&)W1RfHM7Ec>:?;CP.C=:9fB3S\aDHY_BbV6d=7
LLK@fMf)03\g1M,cV)/EPG@[/3F-V5?^&?WH;C.aC48R6EHcMXJ4N^<gWI[8fZeQ
-#^91\)E2QXQ2679[-[bLCBVNeJ?)&dS0B655S\P+]IcH=<_G.]Vg9O0WD7VI,f+
W7+-AXV#d^<XUH73D6cODK3&Lf9;)CJO<MR_5?G0Pf;5_NB;MJ<bQ03YMb735:GY
0MH2B,[2WCV+[e<c:-Z&C5(Q4F-Se+3J]B7J:+ZDVIAFUF6<.1I/.e8Re<cg^L-;
UDH#YMD1LG2T]6LFC;W>=1BM9>KBM[[Z6U768558LULc9WV-9MG9LG?YIPCR:]BR
WbUgM+584ZAH=XCV1+H3]DYfMM6VJ3/eaEVY#.M0136[6D5Ac,,DFEIID)HCUYfI
LQDBdF<LFT;=X=B?R5U]6(#<:6>7(\/A(9R0NH0T8d=KG9\#6?(4/F\+I8/1g(#6
U-Zg3G\ZEMgY#^EUH1^HJG/:ZNV?R<3_F@0RS>\eD0Wg]@OeB45,5U+a7ZKDH52.
G&;H&aWQ\,@)O\U#TL/2;;V#Y#@<,Gg7a)_A.:1^@T+)KTPZOc.RTG-7>.(9[AA2
S6W^WTU+I__MRY3M6c<X7T:F->+Nf,IZ8S.e3@?\Q[<c#fP;FGQ>R40ba[5YCZ>\
V2b?^8-+L+<1FRc9TdA6-6N=V6>fFXRY)(BRIR,gbFE@YWBMT9aF&D/NX5Oe?]SB
\4f(G+ZM#_@Mc6Tc#(GG)d<NQ@Bg#N\gDa0NFA;V?2_4&eW&KaI]0aNg@=M>Q.K;
P]@#TB&,[@Ma4DcUC:9BUZg_Bg8Y?eK]\a\B,M<55M6-JU2fL@,T[/M)+-YSA8.A
T4X+aZO>)NaC/)PUVaP_F[b8I9UKVMG?384:E.TJ\I?WbeSgO0^McMF61VEU9XO.
g=)/3-:76RS)(ab=-Cg#83MH/SZ/P4?EBI101A04.R7#c\/#I]1,[CY>=X+:V3De
P[WE6fSe/XBT]]./L&EDZ/5(6bA.-@TK05<]S#R^T(+G>4Rf++7c@)V6g,8EK;Q7
@6,WQ<GD+[X)fC@M,]GbHX2I7c^@1,W-Y42>G0O;NU+e#HO7dE6,_,EKZbE&OTN-
(DBIU>S?^g?KB04G4.^KI1eU<91gR7UC]e1+d-I2S[\E2T_)3cQHLI.&=\gK345e
5\J2G9GY9MP,MZE7O>Z06#C^McGX;e)VG4._Y#D-,D;N^bg;4]XVa,V,[HAMdV8T
ENE(8M..)9aB@LEXcIaJ#SaH?fT=X7K7##\F==W8XeZC;b_G19?5P^3VTYX.Q49]
)(]EAZT:bJL[>TIL2@L8D3gTD5Y8Iab^g#5(Q2c87M]e0DNY0DM@NgFF<5>R^#9M
a>2>#U>\1YF_WF3dTP.:;fO_b)UZU9Z_@#M6V8S<>EXUag]?P>#?LgD0GCTMKF2<
Wg+?b@bcUYFeNI<]6^<(H6DISQFBIU57B+f_+Q,O+Z7-4),HE4IGU#]C>Z^dL,0T
K6-=f?+KVUU1-CDafZHe<cSH]aIIdBP8\27AYAC&\U_PYeY[YZdfgOfe#dIeV0<@
18F<B?;=D:)\[PG?ZKHGfd&+TVW5^D]1geg8aHA]DDM^J;CgcKCY-\BI6&9DOdHH
[-J^dg]-3X+9H^>[\E\4F5fDN^Q#)A4C2?XYR9dSf\_&+;Af;aNJ;=:bV<.519LI
Yf8=J(0>)3VE2(BZ-O)AG3=J(@=UfL>2<cX\EQAA:3g@14/3E(V:#dAdV;L_b/K#
<V,^#TXCfH6+8YMcdb>./dN5)9R9ZPOA,NH]G,G2Q-@\U5fA):PYg>B\+Xa@c/:K
Xg)JP03V-NLAD(NH@FLY^0B7VTPg+T32^(P^]G:]4H5-XEFML/A@K?)Lb]V[<O;\
Sfa5Y@?JWDK9G&:&-S=4(UH2ZeH9K>\GeVFGI(K=^J2JFN=RT7J,Gd9+]3cPMZ36
dgR[<&X4<?08;_VPb=Pb2#C[C<Kb<]G#T8=LBF.E8[fS7S40#WQEQH8<SQ+Q+9-:
2Jd^^.JaK3YHdVWR_gfDXR[9,bNff3YgL6UOFc=;aB.6/NKPgA:e&4[&?fZ2&JH&
\-cIeMOb^a,?+:(NMCgV7F@c=&9H9L4c:_[,0O.8:[82=X8AOe5&,?M\g_f]0[NL
)1ZD\-Z^L,B:4D1>a/9\_D:D(DcX7ETADN/X/@GX\7Z2]dWZ1,#V_=?#IVT?bCR;
288WZYT(=V.ABU:P@TJ<BHYeN72YC]T##6=-Z8>RB:M:Z,YB4a-W(RQN1L,R&ge:
OX#,=(,=)RW&AM5deD:]gO)+-)+NeGKWVg2g\&<,b96905#ME<&A?0;L52c(W&4-
X)N;d1Od)2D6E10E_F\#a9#g/RX@<QG00Q98VE+U(,d4UU3TYR#VB@<Y-cT[B;Z8
9Ue0MaW?<[cCOW&^cb@E9eS@SW\\99G6b/K8OaNNT1M\8G3b.5.O-SJ7WK#OG@>H
cE,cU\]XcGgI(K0.\(JOD;+UOaB@+8Bf&;.QcdO38^B.NQ:6?WBH</Ib-&g8MY0(
7NE]LCCa#>9+Y8c@-J&,c]?ede8ML?D?_@&dR]aK9F9H8BUKa3D_R_12a7\Ub@->
?<OPUAgKdEDNe=4O[9cS1SSIO>b\IO.0HH2<J286V;\2Yd[?+L;9YeX<1EPZ@)P6
;I=TXK/U>U5-U^8_D;65=3Z+9E?a\f(ZSH?I_4b::IV_GaC];\0G#U(^1[3Q3Y&W
BN47d,8f=67<)2(2/-<9SV4G?J<AU)dC)DUK2-(\A-PggE5LYg\Dc2d\F+?E]^G^
2Y]AT2ga6U6>Za7;LMa:Pg&I(SXgR<3e^IWC?DeKb^D(OOBb_AccJPG9Ub0S(>(6
@VP^.\NaFLDJ+:Z;SQIKHKbRbXR6DD/@^bdT,20f1BeS;/Y#D,M,LDA?<b\>DgcY
aJC8ZYMC&]>&//GLBB))7RgW#;#7fg@Y@e2C-]M/WSK?O2=[:84>]f8ET(LgZUXF
KA>(_A9?-X[^TX7E6Zde6[-)<#3c2+_M,&X97(;?IC4TP?gP=@deM00E&VJACB.;
JfcY,,0SNY;.?H:]G>LF/P.OROMfKO8.afP]b1D=A\66;E-9ZBe&R5gV0JOf1_-B
L0Qe^8EfYQ3=M[_c^.E=SO#0)D=_e@OBg:.2+J?K+;7FK4,9^,A5egU=_N+#RBR+
++KP)Q6#A37.(7#e2=7&?+#XXe\NQKWSLWSeR/2V/bXU/G-E83)aU&W9M4,&RP8X
03?[HX^?WEMI,0T^DCAAd>C=7e1:DA@;F^C7f_=P\Nfb[FS:I7KT6@V;R?(J_Z=9
a9b9:<RJ-_b@)^=@_Z-OLAXKXF_)TWB(NHSb;X,(Dafa7_JYG4I^>EQ[<;:7.:/-
O.8/^7^K^BVEX2DJ#CPdO1A+9<KF97G<@YZ1TTV19_(53CL^UE1-b]KQ_F9YU0g[
;EV<Z:U,gYHJg1W]<]3@/4TO3/.N:1MNf;D5):U=b61L9HNG0R5IP/c_gGAE,2^4
F?A<,[+48QQ33d:Y#(84R&#S_S&[SILL81gGa6.IVJO8^=M6D?(\Q41=GL<Sb9RF
OIX]=(J+_YT+K1AXM);/Rf[f-1eYb5@4&:#F/P<4.3Xc=C&-T+/]#=.AGeF@[?RN
CBQ>eT?+Bc6cE?(])CF\B7_@(5WKb7g7gJ;WNMfO+:GG]UXb/_9bb)D.CDeRG58,
DVP./U(^U-CJ?;LTAPF>]20P8;ZJ>N00S/M;b.2((L5C#IAM]]#+>:d0gC#TBg^B
U1I7Q]ZY0#]J:1.eOA?-0FX\CJHH4a+Z88OSG0,0;N(#+AfA4Y,FUY/=<\C>6(Ld
GNA08WV,51-,W4?>ZYBU5a3S=R66bIR<=]FJbgM8X;e=F;K\ANKT7W0:+=fZRGQ,
A;=-]?bUQgJJIQBD)T+M(@/U2HA-F,a&0H+Uc-MS=8@ffVg>V7gRB.3T.?H[WfNG
?6^fg[X#U3:B3QM0_G]C[C[/R1GYE0&LOJTgCg(W^HIbXa.2I[[HQf#SLNfOGY[7
KcX#L:VUaK)&c&#5b<HH&:UgV?@g\WR/[^I.ZK6I]98KO[aSg#]IgR_(M83TegJ+
I,/f1:(#N4Oe<>LV\<JH+P[JLb&VB:63ZM1IeJI29FZ(2_^c.0<:5fLH</F59;f6
cb/75^^XG4aCU7R)Z]e[[__5Y]?)1WDG=82\6@K#IO@F[#Y#6g1)F[AB,0X<:e#P
-S)W+@@P=]AZ-G<;?NZ&9=/PMUeWP_)UR6E,+IKY<;=La]3:K35&:3CH_K.da2Q^
>,Pb@YBM)cb>&RCQYRM9d]Q_WcS<aUNAZaQ7ZKaNZJCfRU</AN_K:X6b#Z>5-[>-
RHaeA;?Nd<+TVcOPY7WOdf:,?#1a(>,]bACU,C83Y[51FaK[2aA&[>Y\AU@.SK+I
EU\SYb=D@MVf46P^e(/6G6ZfcGYJL[:6F]JRFCV#YP3[g:]PA(8LU][HS,KER<&J
f_adb,B\g#66)V4TAW6Y28?FEZ\P;4&O.JTVT>UeC>[(V@>L_<=<0cK54?_B=bJ3
e1.A[Uc7cAP=a];AE0@K,gD0Kc<:ZLaRQgL9cDH3D3]&#]cC=2)J0KTd_f=&6I#=
M([g#T(4D3f310Qa@MW2\GE9W-0aD#?F&aOD.GQf5c:8ETYg1IP:7Y>GJ19,Zad7
b>J+E4.D+Eg-^)1NQX674[DW><L=?Kg][GXRT)?b_0?3#E_S3R)Y/gggaL/PZ]RA
H_V;F:OHNFX(g72dQ/7Y30DB\NC=W-?2ePDX0Y/ANVa2SfHT@b:R&)NH83+Y9RDP
bJE,#7CYR9&5M5C1QZF(\&JGU<DP;B?Q9DU3[^J+aYX1A]18gKKLP.M<McVUIMg7
J1b#\5@gfe.46<(2#U=/TZ,S,(#.BaMZ68=L5KSRYcBfcLAb^5IV+1Q:fg+TE:f=
f9[0bg</eO099UKOdgRTL&UK1:/#2/3R#U2\1gJ+fOKKT-7N3^JO505^-JX@/5MP
?:12:J[ZZ8Y_#GG1#=XKP7.Z@Q>d4]c-F@]BL#46^=FeJ\?+UD0>LZ4f\?MW/d90
R-a;QPHCSWJO\(I;g6BXR\B=+.M<R,]U@d27RRO&=P[S4KSNC)]@B5#KR<8fW>3,
[RN?]QG#OE4H&/^ZD5V4bC3Z^JZAHDJIU9EZYdIOe<cB#U\MT/I,Z2>QY4a8d4,J
6eSKDa[g1OY;@g<F1T:+JM7Ve-PO)N/\6bBSGGWX.b5[bV?Z_ZUc>:->Z0]T#VT>
&AJD&\X9e(G;H>M9]:HW<-2SK>;G&<1C++=D<A;&ZdUfc2IGIKQ_1ee.4PV\g3X^
_CZYDK0M7QXR][V[-SX5Wc#.WI&RJ1Yb<2egc]XXR#W,eZF9305Q]#ZB:F]=.:<S
0EJOf#RT<DW?5.[2,P5.)NRCYd()cIYVI)JAMQ/TOHV^KfP#C,8-W6;.E\cE[KPc
Sc9+[J&OHgb0TBC+@,Q:afPPUN5bULLU?_&&gA3>TfGZW]<AH)Wf\V(AH-J;f,?R
f[03<]_ZS&CgKeU@be=?aSFDYegfNaQM);C4[B7R]1;8O[LT72@?+.aQ:&]=Y7-e
I-@J+?@RGI^;[+6U)S426+X96I[L@P6T9O2;c\HgA;XdCF]ZIZ?YT5@N:>eg^;SL
Z88afd(&(0-f,;40P4AR+YEC@MaY585C7Fa#(MWOC;Z[#QLEJ&PWe/V@6Z=,Q(\-
XM.^Cd=-(PU#g:aCa313-5X4Rge8N,MJ)D8)GOA^L9&]-I2=[(1M.=3ZB7\3^Q(9
5H8^6WQ^+J1gQNFR05-WNdDd&W\LLYfGCfFedKN@,#.3a59@4V]ORM>&.90LGITI
BZYI;LHf8,U1M[;]e/cGIVLEXK:b/WdJ+K4:EbSCJQ_W#XTKOfT@7TWadf1TBS5+
?Q=JY,\0N]D:=(?3C:+-[=C)G.S427He4)EI4+.,/2CGfH_,7DXF7>UX:Ic::6(+
(@7GS.WQ[W];BUSO[Q)fdU9gR_L=Q\U(:BY:&YU5.@dH?KF_PI(28WdcC+/(9#5C
1<Jc9@C89b]_JE->&?W^?A>-e<a-2R[5PZ#R(3eH1^CF+]2P,6EHNZ2M;HUWWT?+
AA?SK1)T^72S<6a=Sd]6Cd2;BD8H0dBI&05&6B&F60-(Q9a+9RF/MOX:9.2^,&eL
3M)\]9K/cXL_;c4H3eS5JcE+#5[GXEbZTH?TK6MOcM<.MSYS>-gfOd.BPCRS@QKG
._J58OJZ3YEX3Yae?-JYZc5T+b,@#C=ZAf;/5_:Xf4-;WE5::V>4Nd)0:)(7NEZ1
=W_]D/OIH\Ra;V\I<PQ)SU0?Jec:b0IL_<+K_bTV6\3U>XT#\?(IQ\GQ_(LgGaA=
\14\UL)/KZD<[MU3@B^K+BDDB6&TR3e9O><A91fW9@DVZ6^81[@;3W@/&NKN6H#&
TI=-XGR+V(XVBF@;S>&PMPB,33U6+VYaS=1c5\^.;-)-></(-O8T&P4aDC=KVZUB
SX,IV7cY#\gCC&^WR,+g0#.O:_(agJQ7g)Q0e@<,XY538@dN9K+0HO6X(TDN_/5g
@ebCYX.@fNOa.+)URTe?3QafP4<Q#NMBK#,U;C^8)fG8->)HM_\G)a6MAU]TVSH-
K9b_.YB1]VB[0=PY+MS_4<KZ\X^^ZfOW51;WbWPaR^Z/T?X6],F68RA,T332O.P&
0H4eJ=^Dc]V.1<DH4S.DUQ/M1;SP7.@6@[aX@-;F@VH,eW(UQ)#WE4E19B.7D.Hc
RagY\+N8BBOB\.Y.De(gbA24c>S@.E._(_[M_bH9;MM/C@aADS&SXIWb;<H2GcLd
2-D&#>C_UCBA2IT+c]S/Y6K()\;R3].9bQ.fgG+7FI<42-b_bALW7-[42bV[H+)]
>g,/(^;]b#:dB_Q::Z6Ya>\^S2gC4HH#6U&E8d74E4Q=T=K.0WF1+;>25]<D3/1a
_(#bebJS)&_X)/+5W^:],L-6Rc3.SR/K6?/#MOQgbW,1A#XgVAY(cd3].7RC,-);
1TR30R.B#67DZQ83cN^2\@>8:5YZ.K?NCeHWZ=9e)^+8c<_Y=+K12^P&&d2f]M1X
[EeJFE,N^[,H#+B><dS+DJ;a//CKO7[ZW?RO6P09/]N4YJK.0@JgBB]dN<=X?b:X
UgbGPLFO6IZ)-P.TK_(RV>@/[G6,3Z9gdA;JQW(0RD(0R976=EY&4dc7gTA\c)RI
7)e]V+Ic@FB>cLR;E8fD_?]C>TZZV=Ma-^1c04c]Id&G\+585+8eCB3><\5E]1X-
>V^Y>efI-1#<7<LM:J+\(E1=7-F28a#QfNZ7?_f\2Q/;Y_9:9Wa\C?)H?NB1C1H@
HS61WEe27^GBN^^,.Q^E\WGEWVJW8=bRN<;PK1P(d3gaI]U(K:=Y5@Q-?1?>:E53
&/)TMH#^Ic453aCPRe/(F4XAPgBDSX?V/9e75+DB63>2B]SA_WU>Vg6W]I9b8(eG
dG5<Le@g)7,H(?S;>M;(8BddQaB-035d=E5@C&79UE1UM;O;fQgc<3&S)6WE)b[Q
SYX16XPD:C.4T>\HFRNg93#4523NcBBWW>IHZ#)_G5Yf6X/7G-)CC71\[DG<^MIW
HPJ_^LICBD<\e\BE^HAGY5XcK_ZPB023AKEFGHM:IfTQb_(99^91:B?KK4VRCV]K
K<]WWWHIV.fS=b?6VK]T#>6&=XeO4#V\M.a/O&/@^1LE,WZN?:;f@0F_S\P,R1>]
e5)67+NYR1IBE,H:3S?b[8YQ7BT^>E[V?.aV@eVPdL9(GaL2OJ+W+<^&T&JFWE7R
X#FFYR01V5.9D=gLH=O+=08:)0L-OPOX[b:[>EN]CF4Q7MP4c^B&V;fZ_LUAc7@R
=+\0:^FW2VYT5-P24.6_EFXbHLbZV>SZ8V;6^UNFEG((YK?Q+-HU=,GU]WU[_3\E
f&8;#d:ILgfa323:^P^,49R?Qf;GP7TKdF?D39/;g>HJH-IQJK87+.7e_(9(8G4X
/f+VE)+&1?f611U?J;Je/Fbd0,gOKNINFOF7&NLEgP<ZS@Q_&M4)/3J8W?8H=9Nb
DU80K=I864SIc/_YSdg95Hd_4VL.8NI<.+U7#@A5?cA),2K-APB[PcSLQ9)VN^E\
f6]54Pfb(2G^_9^8d[M\7V6EF0Qfe.V_\ZZ]a,+H3O>P.LE\<<NEK?4P_A2G2bI:
5+/,g++><-YaZ/g5#<3U=b5S8<ObV+/(E]1XOQHB@&L),XW\,\V@,QIK@=2US.GW
eXYR83Ae-12,]^\&NE5?d]6]1Ad-J@1YL&aRddY6-LAbNEB8V;RfdLYN.0WG9e4\
(08?-9(4-Z]ZLe\965K_d5-?YHBGIFfR1I,#U@=02OOT^3@MGH0YEg/O_TN3I22E
&WQb;&AV)33>#][b[88ZSEc2R/;8,KF?X+\U654)1:eMQHAg/@I=<S5d9G+FCL60
AZ98ASQT/U&3ZeGR8H9fZ^4I@IZ)L-Ha<dNWTOFJFQ4G=:D@E#:-#M]B92X^K^[6
GQ/;VPHMgfEL)H(d@B3MSb^JL@?R;ZOR=^d#(05-AOTG9X@=EO1a4WC\b-))Y#>=
Z\/&V+:3T?.?W75;]f4N0(00/-G+)L]U^MJc\9FcRWe1\W&Lde3/L6\6@d[6R2&U
RAT8?R#LR6A/BSLSOJ-F2Xd4ZVHJ</(Of^-X-PCG3d7KJGGG-8TdC?M@64SL/e2Y
bEc=Waf[>>]1(G.2Hb@/8.[[940e_]G<L0YY1,H/-AZK^GX;)I#]5]&4OE969^AT
#+Pd/G0AGB&?:USGTD]]a>2>dA<8:5&:d[&J+MYJe?3FRbQWB,gV@]?/_be:5PMY
?O^9S;cC<d[16aUW.\9R&B)UBHfQ1]/_37-664#K\+(_1S#IF1(9_URFK1a/LQ9X
,J@,3Q<BV/c_CD(#IDFM?W:+CDca@/Ze4->C]&)#-^0e/P4.F0V0Y?GK+J#_SA)\
V3fU>T8cTH@Tcf?3e;62B;RV&NF+QK7,LP568;/;&;WDe5<gYHN1B/G5JHQ)K]EI
SR1V+X-T>\W91&R3F_fB^?#aQ1;3SdI_dP7]&7]ZVdMW_QNcOGKNdSE;dJEFJ@gI
:DCQ;/T=I55JP,5^6QHHTS8FGUG/Y/J.?(W4S[[8E,dfTMZDK/UOHT]:8(D&/\&?
\?MB7:aW)(4P[X\N_(f=](U5?5+\)U2(\4O-;fFgV)LJ&d2Q#eI^<AV?4dP]>GP^
4X>[>AMcQ_K^/KZd52NeJ:@G#d7:5Q[\3a[LJOe\?3M8g>7e57+2Fbc;;b6?/3)b
>S_&+CH+9.:?J]I\D?_A?Q]04gcW7Q]]I9CJH-8B^VL^A=NLUV5:8CP2?\H6@87K
+E-O)&OL77<(H7CccKL8O^PD20/b;<3]<f>-RX:@a)fVBC2>P,A>]1#/LeB6ZQFL
4-OTS^XKBS\;BE@g7RPGMF>cdF?84@LQd[\KbA>X)g&PdF7D<MeR&PT^c@Y8-b,0
1bJ8R)A6dW9VeAIMV2R2ge-edI76c^f?\+<[0cASIE1VG)UPB+=I+K9,Q<P&4/gV
LH7eFc7T;#&Z1-Z#(F\I[#]3g,P#g_N2<B2L9H=a2NX-YC@PA4RM0Pc^/+I]([&]
Ra=c=-)Pe:D/E_AWK;/NDD;P1f0>aBE8K_LbU+/PfMGM[7-KBW(=N#fUg>Y#Y94W
HGBQb.P9YcML=SfE_<^TL8^gQ23?T.:a/JWdW3W>GI1\#L6/.)N+,.WCH3T;Q<X5
4OM@I[W^Jc2=d;^(a6EQcgN/TcJYCB//N5>DEdZ\BQ,SM8[4Hc-QQPG4a():N5W5
:=Ld/0)eUcTXe6^#.MQ1a+>I0;=(G)D.5^eE--.CH;(>1ID8H?>2Ja?L;=K/@<bK
57Ed@b8.;(Y:(;KH9<HHU[=,U1XH;\=H&/#L?JJ9TEN>5eG^;2D2NCAS,]L7E)9a
>U@KdW^7P?_X,5-8d.2(4FIN0A2F-SX.Xb65P)8f14Y-L:AI7H44C)_2f]])0aG=
SYA#UIBA82G@aE4BUS^QJRD3d_[f80Vc=#@+PH57T4SSBGSK+->A@g[K]G7S;(WH
JAKc]FZ]<XbV,;SU<=b#af0Oc:=Lf?afA/N3daLf(T<SeA,G9d1BAT59=f0_K4WO
e&-,RR?a3J-8Gf2JNVQLR_EGb=]?GZ-WRMC[CL[:@LTW:.CT9ce>Q1JL9E:@O+;S
H@^Z4=BUE]U7UX,/V5A>JW?V;C#<DVEb[K#d2UET^<c-9W;Y,3T8g<H6:9\UP<5E
14?9=<0bA+Eg2gO,8_M=cIE^FYRAN2cWDb[?2P@g-4+B=2ID?SA/>d0&N=H(1U41
#]-TgbY.(NZQ&<4cM;7@7Q):VCI/dN<8[4A;#^25_7U&gEg[/]M6:8FL2Q^N#RY/
I5IYQZbYK,P;aH)-Y6BAB+U4\.C8:B.2L?YXC@44[3>BAWMZBCO/;TN0B4D0-CXA
_[/#-2_>c>7#aeBICM6.[WLCF5B<KQcN1;8B+0B5]^/<QH)YdY/?e)_dgA0^WI-:
5.b@-^H]LI3P\9C75d0,H6S#RP\>Y[GNJGeQI[JP#M:KX_?G(4DU+)-7fRA.1[T,
XEX;TFK;e_MFS1WJe>2DFg?ZPVU/8@gD6[@C^RgY#0G_1F3PM)SI+EKYQQd_CO^b
X,;)^[Wff\,).8G]@C5(@Y4b[APR3.cB54D7H5>E?TLCEeaCfK/3#U>0eW?8g+@8
/-@.6G?V)H)ZRTaK4H9-@U&O62d3S;F_ELH=:6Ig1IWGS[5H8]ff.BP/S-5GH80/
+H,H-TN?ZI[B?N-TA8:^ITM48/+W6U-5W9TK7&<RcDKS;Z125OW0K9NX\4PcOGH8
]6gS:8ZdA[F@5T4SEb(,L@]P.Mb]4g1-UF4e+=@+ASP+<K^d@H?:/?aN5YKO4^XY
af-B_BYN7_2_?J2BI]B?aAXU@DE6O3D_)K_Y)LA.6IA2De26A7:Y-G8W^NR?O<WU
-[R(A6\2WeZ3RW@O@IM#R#_-/]>A03K;9gB;U[HKa;0FARX7J2aWE20ETZ9E7O>3
d&S&Qdc,1<A&fBQTc:3KgQD-3:I88QF):5Q=PW-3L>9F+URMRT0:Da]f@&Ee@+6a
1U,4NRAY/)WUL_cSQbDXSUg>ZJV5DJH)73L_\MAB=4>,<U>ICA,L@:HX.9FX.dLT
aIE(MNdHGW2fGfAVB+E729CO/+88(IY(3+=/=1PN;M5??EOL>(:_@e9MT[c:DFg>
gV6HY[:V9-384GPR^&5aK[AQ[HV/_/?=(aL8g@C@MdOfE1XLf0E@1KYbNFNE:SND
UUIgU^\/5SOVMdBQ3g+#]fU/=J@/d\9VNdI3V8b<gRAIT1+W3B9]M]]VC8,KW].1
#?>)OF+M_?;=+KD-7J]e(HP;M?DBH/c-/@fUXW2]>CbR9,<S+P7\FD]<0SafBX;6
(EB-1AH9\5;AR7/SXI;4>0T>OU98E/3RCEKd(L-9fP)156T1/a0e^aAJ@7&e]ZFK
TGF^&f&G2JB7MASW29D5AOZ#S2cOcN_XPFP;=09>?OD#=J#P\N-#:J^V5[HN+T@C
V;;U:5RH/6<JG;C.TaZ&Qd^(]51gaf<5EP>&;dS/\<&;Q(.EIZB,1YYHHZ6A1O)[
S0a8bF/H#F:BFI@\gg6K[QIMS:]T)XMHY;E(0^0g;8Je1#]GUVEMM01)T(#4>.AB
M\M+&g]14KRK0IGRW54=Q/80#?1T;F&:LL7<a^g3;.#EG0WJRZETS#,5MgUCV2Z3
^BQMA10CgPC96\[Z17LOfQ-C4L9f96D4d/B(OZeGE.&GWFGVVQVfT??6&/04F1[1
9gAS;V:ZM/&>EAH(a7997^Ugc7aT3WIg\AU6IUZJ1g^9Fc0^-T-#C##>F(JOO[W0
B\R&F==U@9fUT>dSa,PU2[QQNU&Fe\G7:7NS+P&IQJXCG8a4_D/VC^=K--]Y[2Eg
PKf&2Z;90aBbJ7)Z&U;SQ0<JM,AM__LOZS)a^Ub3/ZK.(E7RY^S6#@U+>dOW-53H
KF9,))(G70L-eNN35.NdT^<5+6;eMAR>c&7QJ)<3)#]J5&41_/d&<&3J[Xd5)e?Z
8.-C^W/(RA8OH=MREUA.a9A]1>?Ld#Hc-GY57,&&Q#SOMA/YR)46>^/F?JP\P7,S
AWS=[AIIN]PFJZgc?SV7^DEJ,^#fT+@2I;S<,T?3eL9aAMD]7,U97=?H?L<5R9F>
b3bR#?(YD^#.DVI[.WY/I_d(\Id&d#>)XJ?TU^?EUPf)OMXK;)3T]\&[\J@).96[
YHOg-A34Wa]WD?/75HaWR2WXQ3I,0eW9&A3UNI:IPQO:QC_8PBe>eN=?^;FaIg_8
Pb6dBHHAGL5b?0NRN^>0R:7^V4)gVE0B]V4P@#7bPWI#B\\/MJJ@Z-Z4GfOVQU+g
D:,>gZc.:E\=E94173\f]Heg?cW9+aW=3C5WHS<^0AHH853;;g:,)R2CV8<[]TN<
<g@>BH6?D+YFMY&H_AFABd2=<@^>DFaacGQ-ab-1@>6TG\d-d70.0_<[KV3YP0>9
8<9e>]>dP5YRWfO@We8e\aDSH2O]XK4HK106gF+4JI1D6U\DL&XT)DaaPb7d1]IB
.RPJ4;eHWG^K.WD>ZVNA1Y93WCZ[O/6N+:R9BZa6S2/4C;9\a,KfE&\X4TFNT01,
aIT6YF7]D?(:CdD4g+#LNI?9Dc3@_X<#88CaJ@H2TXE):[W^F),?(FX9[P(d)>4^
8IJ,?IQJa_ZaCJB?-46bfOPa?7KM[,=6)T9C7C^#O9.9R6JfgcLASA_C&;X(c[LE
TL:A<<CFHK1HG.O)-4a>QHb^cN)]XPU+#TV_#-G\C;1BY7P>>JUX<+3>M,Q6CGH\
<_VAW/=#.@&ON6d@MY=>1X1.1\?VZRX?R@IAK,@[T6NCM8a6bIE._Pec-#LWbe(O
4BTRI9P8FR7N4;c-CGce=IQ,-KJ3=XI+/E,_C<TbW4fHeD<6#VJ]=cIR&CHX#LJ9
&,5PWBW.130G7_g<[](P.S>D?+E5?<@<WO)6Yf0I<7<d=\LbTBHTg45f7AVFLc)K
gG4K8XO\Q2[Z]+ELC]G[Je?ADP8V<#3K+^YIDJH?[YK3,?dLR+6?&_B_L<O\56E9
?9<8X01cTMKAOe1L,K,gJa3+_QVK(==>XF#Wc0d2Le63?V#;ZTIQJ_a0;&\J45VS
O2NN\/ZQ?TfKcTH+LT(MQ.KJ3)0_:A3Q;(DQ2KR24f)B1ZTD8fdI142],/91:Ha7
4]9AeNPSH=C\6Z.IeI0@)X99+6B(PF2G]YS(6>)f6<O6U4b?7fNf839RfH-F_LU,
NJ38<AJ=@/-&4CRU&gS;Kg4[HZ^)J+M;W[/T(GQN[L(YIB?O&&?<?YgUG2E;c^:V
_c17Y:&]/\@-P/4++F)ObF<ENZAWeCHGdHBK]_:WA=]FdbV7>[a?Cg@?4+gEEW.H
6AdaZ1KF7O.PR1V/XHF?CSOFDT#\.g/E;=XUQd8g]]A0JIXOPRaEX@,d3@fE]:YH
YdF7=>2fG0=_P]A>PGQ&>CLCcOPYY:g.9MgLE>3MUR=VC1a;+YWbUadK2H-^[&gN
eUK4(GPe&)K]5+KT-49>@Lfd4c3eB=A#^a>EX16FK/GfbBKU;9EM7_GI<[.&A.W^
Ed7c]0D:3.F(Me2T]-6gb+JM[TZ2)?c:7S9d)FW,1EeaV[Q;c=YHD@X3^S?._\9c
K&)6_JZ0D2M646aEGI7JMQY7B8Z-+.<T8],,-#.X1QJTCf93]O[3ZfN#]6c@XCV=
O)711]VYJE#]K5H/6;P=)U8cOC0^RVI4W7cgPFH:,,0GZW;9GX#_+T7QPGLLb:Gb
GHI1.eVW1,LVS(dgB3bO(/FS0(_=5[P26-4S\)1)QcF6M^^Sg>@YSWf^\#MTCH3F
;#,MDU^KS>_.YYH[\d2c+)@_\83IgHUM1=Kgg),bW>8LUN36<ES&[[P_5?D+?0(_
;NRb/)[JbdJ;F4YHQ^J-PG_P.U,M8R@M1J_Y1+G7@(8;RXS]3],>K+A5d0[TEGN+
AWJUFONM];Y\?-cWHf<6I6S7/LZ13G7GP^0HW/OB&T9&X04DZb[#[^]NJ_N_c,IX
+fFGM6M_Q=2QNSH9g;B==3ea-C:EM\1V:SQS3d48U+4.fB8?(Fd1g)]&H+db0+<P
JX_;N3PG)#7(?G.J2H20WY(ZH.<@#ZggU.FGYX5c60..ON:7:U@Md;.d\WN.EFQ)
)^06H]dOSg-N5HW/GEgM+/1#_A>-1/aC(-UQcdb@@(:U6Y\8C=IXSJ;O;.&9:ETW
W7J(^cXBG25@g0aTdQ<76FcVg)4YLQ3H@_1?XfV+/L^95&^_EOS4Taf(G/bSQagL
30SI<(C\AeAGfU5<b#^2J)7FGDf(V>9:.AR(;+1OKH0D,1HVDa^3bOg/SeZ<-+K8
N/,&<6@YX+.,A2;de7=d[?b.U]L=LLGdSU,GMU+7.VSEe@F\M_\\/H2[U(-aCcQa
+T,\BS=:7GJVeVU;YCUcT\NQ]OLJ-EF\e2[T8MQROHOJIO#+A0[FA&?N#:?7RXMA
]-LZfS4:D6]OL_Se+E-PRVJS-,QJ0ac<GA)IM[LfJ^\^P;=09MUcPdC@8H+IbQV^
-7HRcG/&<:3W6^S](LNC<RWHNdUCNH(5Z<41=F,aFJ<b89b<,^;4fAe45GK&1eR]
.QG]#N5?AEIXJ<L-K\W-ACJENRR-f7FbcFY3]TK(ffb--XDNf0cb;,f2B5A[c.DE
Z4RTDXO_FT-ZTJG?WA,Ic4AFX(9#;\3EMVeN<57?aK[2=VY2/Z#\>WG[I5;@T/98
dW5)<);d.RQ&\1_B8OLKA[XQ@gHLc]HGBb1f@Q<LaLEWaWD]\B7g0+D+M-4e?^>3
aJFE=Ka6.K9EVNY6caE/O#b-d4@C9T#;F3/D16:G;b3Ua-.PXZH0/C,H=5MbYYRM
4P8(=.+(cG^@a1L^dOEZ=_5JKB=aZaFDFAd;4J<5WC2b>DM65[K5YS0,-)cVeI5:
T44(+#?=1RNfSd2d4K2>G(JXNJ^2[Wf3QP(@gBffdZ2[)K6a]<]]g:.cZ;Y#ca;R
8SA^M#\ZO:4021JRN2187?d#ee_C:WCMOU-e[,(775a;1,dE=7YOLZ&DLTF0,XKN
3C]]a+82ZRO+E:DCV\ddYE1>c[T9eff&e]9-#D8FP6BZSIeDcEQ<6C30N?R3(B(_
Q.&;OPA/Y_C@HJe[Y[L8SaKGHVM=DfX1(PIG)FD:2-1V],D^cNPd&;=XYWHJ\6&T
=5I?SbL[>\[U-:9c@WRe.[@^@(2WY<34a9RSaIaE@QC2Rg6f6C+7(CZR8AD6YaGd
cV),^C_-gf1;P9?&JdV1GFN&G)=Hc/>WOE0\O;_I-9VdOSc@&YNg1NRa(K9F.XPW
FXI7TeT+N?DO>AYX^IX\#BYL<1GTZ[3WU-X5INP9QCFTb#SH#ITCMO?_R:EQ7[d+
BEJ.U33c/K\cZ:0cM,5]A0Z5VD/\H1-H4:H>?,+J[A1Q;]0AbQ-SX3CbbE]M[.QU
S=]R?-/@I]cf]EB044QbJ#A=d/Q,:N)K>DL,RcHc_:T7]9536]D31YMJDS6(:]QR
@a/Dd>:ePeeC9#B2.][aYI]O&#>EH,#/>$
`endprotected


`endif //GUARD_SVT_FIFO_RATE_CONTROL
