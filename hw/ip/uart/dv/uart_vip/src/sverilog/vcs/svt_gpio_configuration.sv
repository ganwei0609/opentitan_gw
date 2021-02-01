//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_CONFIGURATION_SV
`define GUARD_SVT_GPIO_CONFIGURATION_SV

// =============================================================================
/**
 * Configuration descriptor for the DUT reset and General-Purpose I/O VIP.
 */
class svt_gpio_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Minimum duration of the reset assertion, in number of iClk cycles 
   * The default value is 10 clock cycles.
   */
  rand int unsigned min_iclk_dut_reset = 10;

  /**
   * Minimum number of iClk cycles before the DUT reset can be re-asserted.
   * The default value is 1 clock cycle.
   */
  rand int unsigned min_iclk_reset_to_reset = 1;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal rises
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_rise = 0;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal falls.
   * Can be combined with enable_GPi_interrupt_on_rise to report an interrupt on change.
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_fall = 0;

//svt_vcs_lic_vip_protect
`protected
/_+S)81H1:<e.^;BC&I,0bV,@3&?/_Z>J46.[]M34KgY-=4J83XK((A]_=C=0A<,
<S.[f]=a8QDBHc6Z,>7fCE/(,(Y7+/g>GQ?Y@3S3f3K8_@YHU:.0dgI)T5>^Z<03
/UVeE>2,)f,BfF_6;Acf7b:2EFR\3McJTG&+b#I&D24T^U/aE]0OJC)5e+H=ecI(
(gb-fR.]Q([-H)S_Q9XZ2->)KM0fG8N:\gK)KAU</PX5>0#P,-d:SbW#J3RHEc)8
gC6S:)[+..=fdND#fa#DB0OeX):HfOQ=ePIGM<a3_4336GaJL+Y,3JW#M$
`endprotected


`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /**
   * Virtual interface to use for a VIP.
   * Valid only if 'hw_xtor_cfg' is null.
   */
  svt_gpio_vif vif;
`endif

//APDEBUG - need some constraints here

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_gpio_configuration");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_configuration)
//svt_vcs_lic_vip_protect
`protected
_+D@7fR_<2&,&6<OXA_G+<,CFc&g=De@69:ZgMR-9PXb2K2<80d(-(6QR6NH0UaL
2G+X+FKVE&Y@2Nf(:1OPZML(,@9>8^+_#;V:EIaR3>Ze(TQP3LZ>cT,MK(eY(R((
c9Z]gJbNC/bF31/c=MX@JA[?+:0TXP;+2L2fb5+4B8b[-MLJ<9R3Ba^EHJLJ&15)
./ffXSZ)ZOcX&TUSWB&Nd1_SGW-:?MH6RDWb9,UcMP;,NP5JAY9O(6U5HY<K]aA:
23A3>SX:+=c@L>Ld4M7SD#_S8$
`endprotected

  `svt_data_member_end(svt_gpio_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

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
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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

endclass

//svt_vcs_lic_vip_protect
`protected
Q@K&0He@d;:\Z8.F,>VMOaCD:WfDc,LR&V[9?5H2>XJgSL=^SBY<&(E[&/[H/TSb
[1>4@DBENcSCCF7Z415FbQCR,e+ZZ]1?CZ7JSILDd-S3WM@(fTDX3H)2I2B4Y8IK
:,217_2U(Tfa,D5/@[QK+L70RMXOQ://_NCC-8=(@SO;@MNB9)8aJWORQ5NcH;L2
6+Q-=X6XL2YQTAg]&#;a\D&_Q?G^I#Cg<0M9QfC6/6Y/bfN)/35GaTHe1@C6^#+W
-Ubd#8MN242?X\[d[f2XNZH2?.Wb+>&H0KBd;2KW7P9TRdaD,c>;SOWGD2B7+Ob_
9VL;=:=RY&;I-U)1a)A.ZG(JW([A>8?EeYAXI[7b?=5e.-X8E&)2FBWW,4M_EI80
P(]^_O+e-3Z+d:Z;dLa=G/eR@,gac]U&E<QJ>A)=T\?BBb6.7UOWeI8TNN&LfL&J
1#8>)b?AEe<-)dg4,M8e;R2PE@,B>#&Q193bD^c_X4BB#cT#:RNRLf&K?2K[;(K&
HZKT2/5fFKc9(PefGaE4:gdI&Hg3W^_\SHA\aVB=Pg>.I)@)-L8XLfgHa8G56LId
U.<S@@TG2R&;V_]&<HDCLM>ZX=RQ<QbK[dELbS/JNVFb5:\=9=f+XV_+7O>21ZF@
D:@T1M-YR&>,9)_[b)c(aPAd<?94L(EOaXN\VU>+fXd3>R8TMQ_F7eNb[dWe]a1A
e^TLaN?+DG?5T^02?4N5Yg&O500YdIPdJJ-0@[(Z#KSJO7E+>)U(K31637E@W5Gg
T7VIf_Cc?42&W7^<51IRZB;:IJC+f:&5+AI(9CZ@M(2Af:(c5dbR2?R0O=RGD<;>
9^f58J-6-S2Y/#=OKJb<W(-2C5f\\USAK1-<e-8-@0c?.?OUKVBP.IEU:<DgNN2]
&dUbT:BGb(1_>K3>U;Hb;a8=fB\e>(fUHQ_V+5EKY<T7TBbPHD1HQW(BO6J4DTKA
b;?=TE8[]6-XfAK?b+O;0V7_#0;a@LY#,,e(]36^@3=b3DC(,F@Y2V5#0^1H-\b5
9Cg9+e0AQU#^^]K+<91PQaIG:>IJFWVP@e@D]Ac\OUZ=edZXHQ]7I#B]E5ZXW3@V
8G5Ba2\bCT<_YX[KMKS([E.&-YH7MQSE@4C,4GTTg[CX0(3GEZaBa[afT0e[N694
cL,+L225:&PaC2_LN/5H-(A.E1Q(aZMdgebZfD71^9CQ-717G\P0<FJ.<U?ZRfbf
Pf@8T5HHFOIY#eb@#S8=//PQ^;WecD0cdE3V1WUI9?\bH2;Iee8/E878b9T-FF<M
ZU2VN;O0EO6>G[D)6XA67[ZG=#DUY.09-ZZ[V9G?J(U2f?LQ7,gYHH:]NFcB[X8S
Zd86.8_SUMf6X?,GRI@]J#cXC006M/HXL#F6X)T#:SfY/V0]TdI-F<C+XZ#&A/<\
bI&ga^[Ff+D045Dg@7UMc7XeSRF_?dLd-8X-?VY8aQ@_.&/B8P0e5d<^,3VgIIB/
7(=>:@gDG^>L+;]+U(b.\ZAA;ebg#F/_fTZGD7]\N[QVO9(D7+F],dUd@:@Y.\0A
e4S=,#]1?\3dHC[BZHXReIeT3()GB^7BR2C1_:9@BaSD_L=F,99^PQAVJU7KMKXG
[I9GJOeC@J^)=DB[0BZSRaEd2V.+@]B5<NPH>X<#:^.Q)Ab5\63a,aFO9VA#aaB[
OZS@QG(7#&N0Ab]^Fef^;(SJRVfL>-/((=OV)O?<@Z77H\,\Zg+TAMN8Oa(Kf8\,
)]_^:@?5W<W1U-&g7?<d/9M<)a2+7cBU)gO-KRf>XVQA\JecP81/ZU=,+:5JGT<f
>\@E?3<OGFC?ETR(UNI_d(MWFQFOZ1V?Y.H)_OaY_FfaIcD-7ef80:/Nf:[?Q;=B
V5JMV)[GT,/P5SQHC(B?GN0S:(-1UX=(.LT4+;K@bV&AVa=CSGUN3Gg@YBTJ-PKT
0&=M\G.,cO,@USH9N#Z_<^9RZc0)2f&aTP:_&GR93bK4ZVG0G.4JJgF9FP7O_2]d
D&bL=(6RKQGVe\W[4Z)P>a5TcOX4[AO&R&VLeUN8K741N;Q)E&LO?T?fUD/HcfeY
3QZgQC;dcF=#H(T:YH4:P?@SeOFN1INP,B.K?D]/5gI&Pebc.[2EOYR\L/B-cMbL
M=\daLK=8A+OgA6T]=G6SPH&;]VW(dT,0f[@&L\[Bg3_agP7)^Uf]H+Q7FGV:#B?
7U3SRMA-@?bQSGb^V_7?()(UT/c,eVJ:?L9FBHYWH=DGfJ&bCE=.\_PCgNA=URM<
fJI00VT/MKHCK_\6,[eP+I/TCc1EDRK0^3\0S31<ZaW_BRL(CW#/c:QFd72?6NQ^
HN9YKW(#3b\@29[[Z;^6FVB&8Xbg:UBZ^&^4f3H3(\fX?c4EaAYP14G5aU@C99?g
NUUXC2N\PEZL5+E@2-f9#H>N+eYPVU[Qb]MO47ERU_[ZVJf<IUKg=C9-.KX=AbEf
F7Za[;UD@UCadSJc56^8RR(UYL.Te9_>U+4;83N[]9E,Cf5a(JM25:B^]0UW0I?P
@(&](P?6^aPKb5L(NIWAaQR\bUV:&S4._)^S(W^S8Q<X:cg]7aW4I&R\d2&P-=YJ
7Je-/12[LILIWI@\UO3J>2QYTZX#Y:S:<b/<UO>g3[=4g3WKP\EP1d]f9D19N33d
XZ,\fZ&,gSMeT=DFKY,IHKQa7M6>XC3SBUMae/&KVZ0FL2,eV:8IIS6RMJM]\Q0/
.2-H<OU\f]K)K<=:(T_1D6B:QTRE=/gS;N.[aCdA?PU2@>HVOZ6G7:-2f2Z1[8P.
D9(K;^^)4MW3gTG<D\;O&FK@UW6+#Z2BHB[LRV2+d]B-Md9NPHc7Ng[C5MZ.@5bd
9?bDg^XE0<bHR&\cfSP_RL5&:7ca=]POQD@5C?#=RX[&VR.6]L61)3[PMW[E-0c2
S9+-@#7S>^;_VF@QWa659cN<Y))RJ+0M#O2;FPH-0+]CQB4-&A>_YA&VQN>5-1IW
G.d,9>A]4=Nd@\Bbb<gU(?_P+Y8S.>:BZSKW5:RTE46W381B6/H(aNSY]W;BFN5<
3X^+<+<39SZ+:DGeO7]e67R:5ca5cdD(KT4@J.=gdf+S4Ab5JPC8YH@^4>;B1+?3
OVPWB^H-86</GUcP+T(a9CNLUVW/>A)MUZ&RWK<c?VgK^:3YSaR)BJEBI^<E#QS)
O=L&^=M,O0B9QRJYE-]+NJQ-49I_12)E[c.-cO?CeXDcd(R14CAI\]_2NN9J=2E]
Ye_Fb9gF)(ECU?Sgc+.FZ#]^cZUVOKbJT_fd>F51dVITVRY^^9,WRJ7b2S@VaL\d
1F.AB4&R#6EZ?7JXR0MC@=WX,#11,+RBW.6231@)[UFH^fbJ9Z7+=2:aXJ.A,>#g
8.56[d8]0M0dG0\D\KSGL97,V9Q>J/2MSGQPc(HINF6-=&3e[dK+O?>IZ&@:X^3&
MLa+KY<::JQDIP>,DFg-EPI7dQ;QJ/VG9;NS^02:-LVG7MX(]c-RB[B/YDQ?a=^0
G]eC5D1T9>&P60W0QBE2[:KaK.^b#d<P1,TLYZO?A/1FH_5dC>f\8fVJM/^XdC>F
O-4Z2UXeY<E1-dd^#/;1(FM>2WbGW3)X20<UZ^PFgaec4EJEP,@DFCF2=f]6<YPd
-]T1^_HC^_B1:DDb?;HcgM>GUD4-ffUL[CSe5@d/OX]dD?-[;ZO6S4\XAVdKec^F
Z?T6UP>:W(H7[P(c]9.+=YES;B+M,WD(_TbXSBCYUQ.1++M9_9W(IKBC:7A/Ye\M
S)c6(AUK=HLc8?L>Of;&2E2I)?J7;e(H&fUHF-a/4JGcUH--^LY0>@^/Zg3F7?Id
+dIBEL?<?EA5;[#QeZQ5+0J.e-Y=H59P^/+\M0AY6=)d8D<=+OYW=;dTUK6K@RU,
._R9..d\@f+@C-UC]bC(:Y\>&R^0;LFY>f+1)HKDK\Z2T+);3RXb4c>a&Ye3a]GI
,<B^T6@/(.N7XLQB_@O:0Yc?[cY><)KG<FF]+-AQd^aH8)W+?dJ]-9#2SDA#PU+H
,SgG(]E130<eR@3B\8a=+S<?b4Z_OdL80HKOg(b16AD4SM.,&&JND3cRJI+9VNfA
7S\J-)DPVU5(2#+0^Z;K99>-4J4F9A;dH<)=KGd[R__]:.CAS++B3A[aYSfa4O^<
aeAL:K,-bIG@H:#Q5TBK>\V.?X[?UXDEF.+R>RAM)F1PK3E6OR<c6YeH-.03G1_R
:#+X\+QGQ7Ug0^?\ID)4LR\O:3_12g,4OLSXVV1#SbI;SB=UN,^6D[R>#PKD)VeB
JC>M&U^[F<STM#/QA[K:Iad/c?Ae>GfIGf(9Z4A_Ie\C7,VV5279QH54)+Cc0OV?
&8:a-+8D[=Ge/@NLSad+dcN2fg&:AZ:<_Qe(V,Jc<)SQbL+#FDO&Z).P.,]JQ4;T
Y5-P.Q319LV^M^6O=8b44dHQW3J#VP#6)ePgX,/0OUY:<R[P.B.gD_>U@/]cHW4:
63?b_@F3d,(HYOI0=H>10UR)@f.U)5,Ub=2>QF\.ce4WAeASK3Z,9&+E8&5c#T_1
&@HV#3,5X<d+\YgT16.JQ3A\OX\IBM^)Rc#M)3KcXZ=d1K2JcX6-/FU=:MK,YLVI
XXK5];[CG-RH#M&N4:P_edV<LW)[<\RUP^84NW=O(6BJaS@fUM8>)GU=.a/bV^)1
aS#e6,/RMD/TO\;IPb9D)eB:\-G::eAWY81\[<X:J@C=V?([a4W-BLM=QT:[J(OU
bM3/-]Q[eFN[e>/1-S?/L1,cc<^&aSM+IU@)XS7&1BJ+2-d)d:4F&6+4a+[940L6
=@C3LL:b?.0Ye>KbN)fV/_O?DY@I<aUIbY^S/NKg922S32>-9,ZU^#;[O#&F=]W3
3MGB6b+;5+_=Q+YJeTRZ^V)9<_8b/QV[C=8QcPG?/aLf?5:RcWPE0.DZA?g[DEIe
HV=[TYY1+CC[bbDb\@XYVAI@L,67QZ&Z1_d19LS\POV,C(UDYC>1bg0S@W18N(SD
H\=^+FE[f[LV9=ec:^M&RPDCUB3RP]\MPX<U](EOT3(/R0]g<.DFf=O@GF0a,;]X
)>R7bYI6GU722SF/1Y+&b;@RIR4J4d5DOYG#[VD-X^e#79E9#5=-CFGg;K8P>/2]
5dPaYWJ\f^a^,_SON1dHb/VZaPO>]N^@e@0,:DR5-SX2&E6<^ZaY1c[MX2fS>DFH
/X,5efd72M#f1H7_Fa4ZW]OJ^+A-I<fP\,6KUX_eOCIaPH3XLacEPd6>AYW,_dgP
7S]b8W7U?H-KGTM,aD-gIFW]Wa,KKKDX9LVVKG?1:U0_NSE\NJZ-daT.=gWd)F]T
V8\1&]G#deG&Jg8/30LUHKG[)MY>HJ?/@@d+9P=If-AX3#b14]&VD>387<?>eU3b
YDK,g--e/X+H8BC7F;)LB\cEYe@>8&8<8/6?E.V&N@,Y/M9.//#G:(0WQ\JM<.8[
OU[EbX>d8Z?Z+VSC4H<6Q,6.a:fAc>[N,C-K+[.HV/@VEbV@Uf(IDZ6DF/9bR7b1
EXZY+87fM@?S?FeKH1I)?XUUO(@^E1AabZc(BW-TG4O4(ac/+3I_A\(EJ+3#F\L[
?^4(+>X18,3+-[+3,FTA_]WG1<)O9/\:_gW?1H?&f(UH,fMd-G(g_J(eafLfCc<<
d+9LH9F-^RfV6\3W)[OEFK1CKYJBc.PJR^G&ADW#+6VPcR;L/7NdK.,V\Re<>W2:
++^O1CUU(##a>E.;Db^/0U)H\:b+6ZbgU_C[]_OPdgcgONG42-+>D0>e;-:M4N9Y
BPI[<cO[I3afG0d1-P1;2,[H.c;@6/0Neb/752-EXFB1c1DS7BIJ^0TFaG\R]2]b
_3,;+2NT+P-P]a3.1.F+7O9(g^e[cbJeJO\9X0_3-bZ)F&IWRLE;6.O^^6+Ne/T&
>d<LFcW2G@+,ECA5G4KZdVb4#K+&U,>YL[E7Q,A&OX19c.OKbZ6F0^,2/)J42RcF
c)6T8<I8SggL\5DFNT]WZf>SQ^7W\?1f7<@Me)&M.9D[b>f[^9N#@YL3)4bSVYJG
SIJIUVAJ^aCP&-5D/B[W8<SL6&Z_.N\X>E4_.F<1JITHG92R=TF[f:#Kbb]&49)1
;^O4LC?&HT@3gA=K_b<W4WCNZQ,KKT_G+Sf\]Fg-_CGX#+./-/VfR0dW\7EW)AO)
P9?aSRWc(>X?X+Y#RcFCg7V&#aRGG1dACY2M4B0bQCN1]93Q+KS6ZfP4/#+A5RYH
0;3JcV_0)\I?]L.@@J+S^RO#.,R_UI;Ab6#MU&9ecTSJC5[]e^b?f)N#>3Jd>fKN
U27X]3.N\5]5eXQJ54LF#HHWB.3JWK7.;WGPFP5.CT0QacJR6:P5O)aJ[&R;0.J4
)aY^ES>[\gb_ZE@],E(KadfP->C;Y#d9U?VfUdQaXMbe+JE96S4?JOVFa.9ULf,O
SN(O7fW[C^YHEJO:&<+_N-8Y9a0R]2XPDWVcI(9NII0I@VbagD^7O2T+29=&;f]\
L+O<5DLI+\>I^EZFC(&@<eRTX?<[7)g3#H_@HK<L[^Se2<ILgAD-_WGO(DVVfFKB
;2.A\NfEP5V)_,I,<6;<2cEf51=TTa[[]\[0?;H+[K&,[2Y-_J.X0F3?6O^@eb9#
2Q??4M9[P8XODVe-LIRS>)S)5=GFP>LA\_;f<YM3C>9;G[ZdS(5Y>0H8I,ZA(Q:?
9U9L<_3#g;#RZf+(XORa\KdA<>O]^?DX##+)C<WWUQO#b;73H/&)Yc#=8b^W7,2Z
PC\0CV>KB+0<d1<;NNGK1)68[FJ-d5LB:2B(8J7/)AYZF5X@YId^?SOO<N;ef<g@
<;-UIV/#)QN.3(:RZ#bbaRTeYY2K:86_We\/YG>YLKPU8@9/b5>.F&cgAUU;?e;6
+2D=d:bK=G;eb6&DM@V_5d+.g@^U/:2TBJ<c=c5S^=_EO(/bFE6b_=eKY<7>Yg#J
,=.E3SPaQP=DZOXUKG]aX_J8TP_KLPT_=(MNb#N>f7ba/1KZAHG^Y7#K3fK_?g]B
8D5?dI8GOfF2g0D:M>MTdXN>Be@UO9DF)Ad#N+7H-Rg4TcF@WTZ2bNX5G/:RFe^]
Wc_;Y.V-dAJU))?BJJdOfMPK=;N&gZ1@58a(^Y/bA^;IP3Z)8eSaYcF[SY]3A(cR
[d8ea1>(>H+6Se+._I?B@.,B6;T+d3JZ2UH\:VA@ANc,FIb7-ZBg.>XT[M,g48:(
CL(OSJZfY]ZFWcDg]3fT(H23\C+(+MQ7;MM_LeYUUM,,G=Y-E;:D2X-=9Wg.b2N<
Q=92ZZR&+HJ:gQ7.\EV^O^]E^;#<]VM0GFbX^;QTHW2SXcCGQHfI#;.CM19^T]fH
J)>C8M#fOb\WL?>OT7GR@N)8L;G.ab(,;.f<gBZHY]@cH<gC_)?V]Ng;RB&7ZHPL
/dU_9R6f:Id@Vg^]@C:L=<@eKM,B3,2OKcbW]Z\DI^3D1VIXcR\Ld9a:BA@3:5M4
Z4Z/JJM<4+VLM.M^YW/XBP]Xe4:_0A)-\Cb7^J7W3T<[E^L#O9()UNSL#=N[Gf<[
AX+Z,W-]?6;W:bKa:83S&MWC/L+U@,;K.M44+@.,G)97]=e/)9N2+[Ig::Kd^(\-
WR4KEP)QZ>UZ=D&<BJC+FQ-9GF?Ug;/f^TFecR8.>-B&-KBK-&T:RCCV(-G2&b2\
c#3U2cbg,MA?AH/4DE;@&81KX+FUQ7#Za34&3AVaJA=8V6;g0a>B3]e;-^GW&WK&
&-,S#AULe+a&L,-DL<FZ0f]a(,RTNH4eSI>=:V0VRS=gJU=VH8?bfT]OOc0G<E4.
T:g2=E/,a]g<1]:2FJc0J;8.?3GP@.U0WZ:1]-BdHQd(/[ZPQM7g.>94@..</C\d
4A)S5b3^B.M\\<CBXH)9-Z<4c5;B:,@a-3:B[M/+@2K)=<fM)4\.I)Z>Z19gTZRE
UEDY(Vd3M+O\d78g6<Y8WXbO3QfQ16;9e40Q3Y,#:O10<&>7YDM4(^\1Z-NMSJ:8
.fS5>5a]/9aZbF0TBWdYK-&#NG/H4e>F>cd(,_3&?a>\EdW99I.N^?:;DNO7b].B
&<SSIO1#-#)W&5P[6Ig@=>RP=ZSD0[(f_NWf/bI:a(?25aJ4/-):SA#;[5MH+@dQ
Z&E.TcgcWaIW1;QA6P\[C\7PI#/NA7,S(/>6&_dKH/XOYKPJ4PdQ@]YP9+-HH-5L
7+NQ]Q>(=9e\;_U#e1K0gJ0C6[7.<AN_gS.F.VYJC;_-=+A@1\;X.E3:2UJM1PR8
[C&^\_:,93I:9OXVB.HI8UGN8He;e24\Q]e7WC]L1MJa>>^Xa\b4&R:OIQM_)dXT
Y)Zb,?.e_^(QF:ZL^>UU#4S9SG80=96#&P(=c2(4[HGZ61079V1C@+Z[EAG&/1/-
\e<>-gVdN^Af8AYUC+SO9+1Z]DWL:NEEd8\GDQ7-KZ)K?,2a8IC;F-L=IXU^R?Yg
W5?NQ?40&0e>3de_NTX,0V^._\3b3Yd6cY-M,RO<HFC9/0[02Y4Ng-YfdQA:Z46]
NGMg&KA=_a&PaV9)L,78S]JdU:P[-ca^_XEA3e//&O9[?+AZbAN=?WbeQG24<\L,
Z,/?NF;-S#J(_OH[LF#?C?Qb0&W4c;8f+P>a;RA+c?1]gScW;=CJYU@1Z:7e?/4@
3@E]g+YW9<^BL6bW@7@BH6beH;LIY:PV8C=/-06\(\Q@E7F9.?UL^b&KWWDQ(#A6
/M)/XcAONeWNY(=&A/d6W28cCC?fbQX6][W5?.Z7Z<]fT5SbS>KU:XfJV31J@DK2
9#)RNU=gHC.5eRM1;K_f,UH.-d+<3JS4>_@b(>QFG;CI(J?SP\4:aE=5]E@F\:Je
(BcRdH/\?()YL6A[TK[UA-PY=IL(T:LC4I=&S7:</W8XMe+FGZI_A:U2T@)&[APC
3g_]ebZ.#T<84W9HH:V1@XgH&;G;eRV86S#:VfK0@:^J?\;+0)O(D<QS/]+NNN1Z
&P2(V^[5::13WcC#F(+eN5VQO\&).VBaXP1.F_8O,D+-)bC6:SbR[g5Q@V(@_V&V
?TZ8).]TQU8Zg_I)-f-J8CbT8eYf<#d[_/aeM<cDDODBKO6HI96\/ZP@f=A71)(B
-g-LFRQ>;P>,B?#NCEbN@_4Q</Eb,::?3X:ZbK&?.FJN@Y+ASO92G&MSgAS2]:LP
((aNa-cCZ>WMIIM@2BU5ZCN,_6>I8d2HR5K-^T(I9G;K991OW(F3BG65(VAKgcLg
>c3[W>&PY@H01-:cdU8a4W0/+0+?2&?I9&fH7]b,:I]b9?O;cF?<O@Y_XL>.A@)&
#g+MF__QN)28J28XC:-59Rb6aE#g=cJLCCO_U?]4Ee-?[_WYERMBIY?H7C_F0^c[
(,Sd&Z=&NLC8A,bL[eXgMQ>>V7/G5C4RFed(G1)4<(L[HF=5Ybc.\;[+27.1?c\:
Q>:^I+NcB#TH&?X,G33fg+9Fe5DUYKe=_e=:@.DJ02A1+NF,V[8RO8TTG/b&/5]6
P[VY[D88\RG[;R/,7Y<6_04b@XRJ:X4[#KJR->a\04QYS+g4>-9?-;gHc2NKH0C.
)FC3fI7U<#a3SE9NZS#:(E)I0KEde6;d&B+[9Ka<M0fX.eJ:M(^TOg&3&,?gN,W^
+5V1)PQeX55eeVVGR>-@I\\:&A)7\a(MI=J8S7:dH?4Y]-7#N.:dND5,Ae#F3@2L
9Y^WN>L@KGK_ERc+7KPZfGE2D\D/#68/>D[:dY+F@ZVJ>+P8eOXAUMO+TU[7(DK0
Fd/JX>T+Rd9TgR\SZ-;e.[M.c=QXFB[.4^N0CdQ\2U/B2&:4#46ZKf;&PDF&e7Zf
JS+U0;Ec]\U^?C(f:Zc=&PVS#<I_PaGfZ__BCBF.Y@b]?Q;LL7,^0?40OW=&M^\5
O6S@+CAA^U8HZAW5(C6_QX0bRW)\>+0[]=G)PGW:]8RXY]4[=CK3bDb,WLRC23H9
QGTJFR=HHA-EGE3EPWCZ>K^g<ND.AadgN(3@cQ_(gD>T-<1,5NV(L3(Ud/e(KQd3
7>Q9cJL9;/C>UYP1c2;&gZE,b<K<[F02NdXP4=3O=+aa0K=bOUJLdPX/#QGVHMR9
+IK8[AVF):=-c?AV3JC.2GU_b;Q22K05^PIR=YM8JP_:P0fKVPSUB/JEA=\:#5LL
@a9V=Xd<DBXOTY9[F>Q(A[MP48.,O]=d]&RcT\6[P=L]_;aX>fT62/.9FP4]Ag\b
L<V(PcP(KV(7SId_L6AO/7KbdM2UbA]UD5CVQef+FdC8JZ&eK_.[17A2bB&&H<[Z
9^)BIPX&/K+<SYE)0,]LGZU<^]+EGEQT;F=U.c72^/.P^NH7@:CO/3(K#AOVCJJ4
>W81ZL(QJ2H(XLgA\V8,-_I&1\7E)DB57Ib,(85K9@O5(Xd_,#:d2<+1/\<-.,#6
-<)LdQ.HZJR7.@1TQV0<9g5-_\Ug_)Yea88+5_,-cd#X[9QE,<F><5C;Q_1)VDY:
1[AZ8V:<g?O?]3Y>7LN#1I>PP6-W4_1<[@QV]\F7Y)b_K68QGf1Q&3HO#NQ([H4T
S0bdPI-H:IbMX+0)Ec?Z.U4g:W5X[b[S>BfX@W^SB1=B5LMc,90N@G^BZ^X4c;K@
GRDSW2@9_DF<b;Z-,<bF47Qb4?EJO2:J4L/T0HHa6(LV>VYV^LK(N#^88U=S,&>T
1W]GHg,SQN^+cNW[JBGcIfSBU/VHd]&6HYfY]2dUJ2-V(YfEMTJ\^N[5TbRQ;B@L
:IgZ8XA7XJHW)^CP[]4)^I)L9L],C6L0:4BDS-><)7fPM=[cfWa;\>#@f:28:O2>
e^T;QW6K;AEVPNGXRI<.:?]/3^dK5e&fAWO895#ALEXC:Oe]ZeYd@MXS]a8TLID5
-,MBL]Q)@GUD@B)E+\^:/:?gGVPCg22]ZK2O,c.XL#Q5A?S9..<6S7Z7I_ZIK5e0
_)X-/0R_QU260T0_cF@C#49,.^agZLGWLD]-E?HMLIO789>P70<2-4ZG1g,dE5]A
-;Z]1]-IK.R<;;LLMS2Y:WUWD:YgOY-e:#W0.A:X3#V9X@YH8J0Z5D1P<Z:Y?#9[
8BTf18AP3A+0X=c7UCF:C=6\?>G5IG<63\C_=Q04PU-C^A?=R7-BNfD?:YL,,-(D
OCQ#e4#H-&UbE15@[&4VJ4fW^@N-)F(eLG6A6F?C[f12AS.HU4\0QF[]A=7/8U;d
eM@V\/.B-bZOe3XPU5,O1&MQ9C-)?g^S06N^G6/F(d>gJJUJ\0]9T&IO<GP>ZN)2
H8b_6J>fB._JdALS<EG4_F46),=T,;NHRECMJc.TUAMHF2)c_9_>Q&#ETH\M)gEV
]I4-EB.#RL>;Ued.G9[<@4HP44NeNQ#,\g2G[Q@c8\R82[7<YacVLgIe8[dM_aIW
U4;V16:X5g<6IEC=E-.I+DT+)M@(Y9VV7(1Z,,L](V@dYLH)c#Q.-#[Z.FaJE7YR
<]C7dCa6,ZdS_9gOHW0.AE/6D6Sag;3;aRG\3K&^0:=8W;;=)95C5&+2XHWCaO5K
ZLHJ3?e6L_NgNO2<D[&94e(KD1I(OGY:6L0E:HN68HX(M+G6>Sf]9/_GEa8cbCJ/
=@B,FQHV22[?b>I&V?ZY7GK=b5LA[\Q:S[BN]-\S/E_V+#)RM.=:.F(J=Ef4BD1F
/cdLDY,M0fK>a],KWb@\[_e8F7U&OF?XFgVFB_8DT98YXO3I3^K8\PX+JWJ3.3)C
D1_@[?/=4)_-/DFE6f;LFU2K0Ue&^K>C]b5P_T\YdeLIAeLM\SCeYLM[)6)VS&42
fSYPb79>DV;G9.X/D.5JDZ1KQ#gSTHee8@-V(IB+P_[+Lg\+GCKHYTdSX;7>-Z-4
b.0I8SN<cEUET4f9&[Ra2F&>WB6X8CJB.56RVX^6gA2//NM6=B)^XcEWH\e#e09#
-#D+8E@S0BeFUCCXfDf]9K3^VBINT5AIK9MLJ5YQ:.^1_;-gDO[+A#96E^Nd>Pb<
^ZD?CO/X;75(Y9J)&-\)2UW)\fgE^gC3+=YR]cX+4Ze_(BFdf.3GV&MW,S1#]-B9
?K71W5H.0Mf.P07J79A,>HE(T.UE59[L&2C3DAQ)G0W)SeJe[O9V]5W=+:\J;9c9
]FF;&ECJ\?ca/U0)0RP.1=80@@Z]<b3f=15SM+=1cBBBFX6@HS.(=&V;@GaY],85
G#7W&:DDL\/2F/<)@.(LDS\OaI8-TH2K)=QTY<L(\BbY^;X;M:5<\W^@T2ddGYCD
>-7KHCDSa;a]?@b,[7__7)SCfY_8]9=5.Hg[57GX5cS9.Z_#X\B@#Q#T)&RaHQ_S
T;a_\/-S^/\?>H1FDNY-6fN9G5ARQ@MCBd>=GP^:[Id2UNY/>31:,cJ?Y4\)<CK;
-Bc#[5-gHK_5A\c]E.F@Pd&FK;aOd<f++UcFR],^<,XH3MZ:X.<2?D8Ra/gCXSdF
V\BU]2?fG5:7c^1PPF2ICf2,V54<R3f4XT_3NgW>HBcQY7e.6?=G^.W91gU:bN1.
D;3OaK3SYBPQZ:XHBEQV6XA02SZ@b>g^TBAD@e_I[2LGYgKNB=(I7a^@[ZdM7a0[
bI6BK+dKF:W:_MeDeJ^@eWW:dZJg7-:e;+G)2TGCNa@@/S6U@aaBBJe76cQJfgE5
O./=J]UL6(0)Xe.,0P.IU/:7F0\VYIYOfD@df[b;\4bV)b3ICSOUM^bgHA+MX?GT
V8RI?Z]AScX4LJ5784He9/_Y\AZ+(3]0KWQ,=WZQ?73(V/1=7GCDPWJ&[AMa+SP7
dYE\1Q7D^4F&e^ObV-7Qf:G^IO(=be5#92ZQgDI<?M5^=LISV[>SQg;b1WFMO.47
AfEN<@4\/,_P5,V@44g;2(B6VF8Rg>Ba?&]g_9Ac6<aU\cAT4M3LUe5;,\(@2f16
@d0T3US8FFC62[1^P0JMM<c((f=)ZM3B)B;:4]@@72?>:R]e&S?;;1]3)FV9d6CQ
aRE=^Dg>5+DIb\d<3.Z>6Iead/RL=.Ag&3Q&ZBFg299UL4&I5K2<TRX)b2U5Te43
<,B/BQ;B7b?/:K/.MC=R0.-/M-O+f.QG3-YQ,TSNN8JaS8)OK#eV:Q8?VE+N\/67
V7PD[OL&N]V<C[beJHWB3d1_b]B?EH3W:5JG3[00R\-_:F/,^N+:@^AbAe3W8]P]
_L8]XHQ(97,L7.80E]+,.0.<a[g,M.WM_aXWKOR-_(M2bb/HL2=\]79)(64e+(7,
N>-<H)VK53#LGQRBQW0PLcaII1^SLY+U.6Y]B@-Le3FX2NIeV#]^.I5eS6X,Q(E;
#>RLF6Q]&VPI)@.0c73eFf/cTT?MPPH+/2W+,7;ZJA#KGe4)/9O6G@dT^dDZ#0()
NSY)4Y.G\B.@.1D]6I0/F0_:D-cP47XSB1_G?@5]@PcbCI11.,QFOR.@]cF5]=)/
]E\V1W]W^ZaJR8Uada\)/e>K6E#aELfYQVOIV-IK70(Dag[M)cP9^&670Na\S,5Q
IWB:?c[\C?]b(7(Y-H^U7U9LCNBK+c^R8M#a\,[XP5@Q0&AW4D>SS5EeE^c//@+W
UPL?B>\IV##[fVSf;;?G,X&.+].8eb1?EEUgAFTgTJ,c0PQ.:=3/:dg?H)8KDY]<
2?+:IZ6Q/dTG[8/T[dJ&11V))I-B+[Q5;/XdZS.)K)OD[dA3/J5>J98_VU]_D>JN
GEeWW=I(_+aU(,Rf_<Y4@IC(</?;=GB]U.=#WYY?P[.W=2PPIJ1D]/#.abFME>=@
\DNf.D87gC@,+//X(76_?GJANMgZQa,A7>BHMTC_ea-1g_]OJT.Y0PG(7&G/:#0^
>]WU_1(H+M@.a?OJUO_LOI]aWUBT)]K=]PcgW_G\T:@Z5):AVY;:d7@?XId__^O5
<Q3&2+_J?12PH&D\T7,3SPf70P:32-]fg0]>FJDJb@?:\OA2OO.PKVZ.f_;C^V)M
WULPD28AJ>Y)R3Z4M\[/V01?2SIcX7VD.L50))Z3<X)WOG?5g[\aW/JV.)I#),F<
07SUD;S3K#Sf8BHPAa7VI.T4[;:+NW,DL<<a292Ee9N=W+NH;6SXIF8<.Y-JDcf;
]KKI5FD#?.gX2+^+b-a=AEYg@GQ7_SIWUGa64,=@FbFG(O7@8)(UCI4;d-H&WD6b
>.^BB-cV@LS]SSVV/4::I4g^fR^>RK_b0V/886H3>d+N@&I/f70E\J:50@9#C8S#
OefNX./fJO&^>1J>NOIL]1:JVQS/+;,;ccV.RKP./7=4GC4+2cY7YXMHW;c99cBO
UDSHJPW0^<DWW1>K2gN^;(<Oc5>f;5[-2gW,0;-_W;WY7gf-1.JGH;VTX@I=fP:C
MgZR:c]&.Q2G]4+H7/C,VB6aT/RdK/aaTg1GAK_\V6;4Ed8?f=5S4(;_=cZRbBKN
N,Y8g\f&<?0>LXP,Tg[=fB3;IHSf_4+<<\,18M]Bb^C@e[HZ5/+LBEC+4B]VO1(W
EXO&412#7c?fQJDR1F37/W.]3?_bY?L?>QH6C^>+NY9C2:730(c)@HIO6E0A.>ab
GH(D)4EN;Q#;T^Pafc7:YEL_cD)=-B5)d-1?;HQCZPNARQdKL;DM=@A]V(7N=-LP
a5@JA56L]<Z0^,6>dSC\L?)BV=>412Z7ffbE8+F7(P:-Wc6,+2UF-JAf\f)6M3NW
_aXZ_bIP9(5PFfeLPK1:+G2TeDMP</T]dOe8BVJCL\Z48)09IVA&L[Y5LcCc1O=a
&M@Hb?,)FgO><RB>7AcX-46MbY2=8AC&<M;a^#?.-VRTUE+?=,8GOB0ZA?TX^83,
R:<CPMc#^0K2GO61&-cI[)TO)cH<M._@7CM:4d];OTO.-N@GHT[\59>LCNN^fF@A
LG7bCa1-eIBgP/(A=dB[IKKOGBfU@a[]V5J)cIe9O_P)(XTB/0D(85>=[E9QeXZ<
1(2g<UA;eRFUHI]e\]IT&?UFJ8Sb,Md[==2Ld)NL3(M.2YBH9YKV_8bIVGL#9M(/
@6E2_49K3;eA,+)@(=GP&[A2OI1+TMHT(DZAb1/ZSE0;6^RDZ94e.8PX7T.[^:dR
2RPYV7S/C92.MR3Y.AYfBNaE8N;AS=/#W?>@/C]@1SVMZ/D4PK\0/c(=9AK+^#52
?c-)bc6OO:R9BbH.:93@2:\HM[E.RY5<-M_,G)(NVb]gd,L/7GW#R=B(-@B1AROX
,FM4f7PN93_?G3M\+<geB;Y#fZUbMg].WW-;H3I3QeIOWUMK;e<_ZS4),81&>=g6
YUS)F3J6cCC@/CO/ENZ=ba.^,PW,,J#)J5McUZb=JS]J9:8]6W;e63(?A2]L&JT3
V&\DAgO4-VZ[0P8K:QZQ[P&1(D.\FRAVS5XQ\>P\FD,EQ@\;d4FdW=Z-8@]QS?JI
Y#C&1c@ZK/EUHU9[G+4T@-9F/;?0^LF/:\@YU1bV)gO9e]BK9I7gHNK;11\+IRJD
&?eT]Z0)J<96UUK7Ye.XSMBD\HaX4+c?TN]#0=I+0]=4B;B:.][L)CPR.&,)NgM]
/B_)O,McE;VBK;J(8\P8=Q8?2Eb8ACDEc<9/Y5W0CUI74[)062H-d8=&&N)W5#5T
H^UNgNZf?C1;g[7)]:/XLJggcQ3&?R^CQ;;\?69[HDaGVdCM#Yc7Ua9EE_5K:=ZX
XIGNR#X^YSBIdAA(44QFLL:?^W/:)V>bEN.a6XX#(I-1P\XP\5f)GUK1T7SdKCZ:
ZK,(-Q+Wae\;0?EJJd@@#D9X,[47PaebX.D1Y2.NFK,P8ffTZKcJ(c3a@GCQ<9DX
J@@G)CZ\:@M2F-8(?6K5c#9E)&QQ\B>7?#.KbcPPgc/b(FYb)Z4(Nd;fgWI-)DVM
-2g/&YIWA]3GGL,\WLWX<S85a8]g]f;G4S9;d6HPT306X#QY,ZdCR,9/S4R5ac;9
V#IJ<Se#aV^JCF)Rg/7=ABd\]-9(Ng)OG:V:>f<R](0?Xd]42V&PdL5eM]82T,O5
_,Mb[IULeLeEQ,V3R_83g4R;gOC946/NQSKONMS&U10a4^4U@MVITV>2Vd/a?3aW
_ILG1S;6)B(9[MMa-+H&UF2e<9fS4W:RIg4e6D6KO3d[AZR.XLC#D,.DYO9H7\<I
e,59;=G(U#c1-#B1CE(?>DB0ac7RO=5WI0M[;_C1X:TH3gLVSe9dcDA_f7H/OW)8
@3SI.\0TI59f,dIgP<?4UO/927c)II<N/15g:WCO,NJ\SSXPE<fG>DN#3MJdN#:K
&:dU>5SB^(&)R64.9CFOTYG8-+a35Tf?0ML]VUH0bZd]cQI>;e9/.FbC4_Y@D2=E
0Y;1J->8VRg+WLKd_JeFF-1Z?UZZa3CS8\g8D8TFF5I,bcg9R.Y:g+M8Q8?)dFK/
BN+4c8,EdD.EG7>VXU]Q@R-MJKE&-0P4QM.).0RNJHY.&W#XDH[GgaQd4-BV8O\J
<9?5MYE4RZ;fCQQA0&+6JDINI)73_05P^)e_LHRLWg?^F-2279N.Aae:[g,,dR;W
0,ITF)<=WW,&E5506L2.1;aGeI?5SdeMI_f9)CFNLSSPP8g48^,[WF#[9P[=/)^f
<1I]1?64EI8+Ud1#R55+ZEA_70dXI]TVR60aSM@KeJ]IZSCRAH.2T-ecTKC8UY]M
BBT:4RSVLCc.;./<Cg?=e;=Q_)/_(GK0O7YOEZJD#g(U3&d<D65?GX6E[+@HaE\H
T9LLAKAE@>Y:TUMf302(;?_Qd(R.>2<7QEJ#KAO63T3+D@KQa9&2?8,X:JGB/Bb8
fg^N:V/^2-]9,O-_0W5P;?7E.C)/-e.3@B8^FZKJ1:Ld>ZY&I)<JR9W[&M<))CC.
AF;TD6XW#H:C,b8WYe+&45^.@RA@W;1U=;8:K)C:F)[gX8D82?S98Z=PAG2?;F/=
0ZaX3-U:=ba]<#CKeJa#EeQeIH.c5FN:cE37M\_?S_C8.LQF-C5DQUX:/8&/Z:Z+
;L+7GX[7J@TV^Pb_TWQH,gSO+&>GFG2:C5C>3H(gXDPO>A8ROA8K.e7Y(B8MMOQP
2de&dg40+DBI^-E]^<9V?2OZ##;:,@(a_OKH8U00+eG0Y\7;6AGRJ@1]L@]WQaZb
VDKT8S<02)V[0da]f7dc:EV@DfI+MBG=1^-ZD?U9;LI(Wf<-\2U^A1K?Y;c;;0;,
7D#g&-9UINZLAM_S3c37C(bJOU8YGBW(G4<gC.FfBdQf-A.[?>-W4#DPMWb_]aUd
V]+GEK6Z.I8MQ^>:M0ZTc=[-\Wf=P0VDQN]2gJgTGQ>S4.R#JY/^9<B)@)+2DM]S
BANdV5P23W6?YR,VE/+IWbHKFV3O_@GA\21MS-gDa=a>3MJY:.S>ZM\]a14VM(4R
,Y9UWHGRbA]SJb-@<TH7-1IVQf8U?+.H(2\,Nf_[8M8JX_:US.Tdda]QK\gWPXAP
P2F<;MD&9W]?cXecQdeU;C5ge6&I2&,Ha9UegfW.=J@80FCKJ4EE#aJ-RH_I&6/:
ZfV8I6.:QGIEabFLW-5:FH^2dD+.RIXf;D7#M&0[=V/GQ>D+eT)3S&Z6[.#PV0^a
.^N9fNXR5BY2YY.GW&2UdbP;H7PQRQ).L58XNg1IT(WSY_1^:IU0X&X^ZY=X6?3E
UIc@(/P?@#QNbC5P_c]+C/F6gN0BU0)KM\F:)VJ4[_,3Bb>=E/9e).gf:.XA2I+T
FMB-,WTL#J]FA]aS-dQ4?G_.T:MQU7@SPLTOF0Q4C]TMC,->)SATJ4TRBYG?XI@U
R9Z]GQYE>(GR-+N:Z#D)e.J.XFMbdPW8(RP5JS(83G=:WBA_O?4@.V/E0I;1KgA[
f&VZ>cEY6JIg/9:XfN\CY9eVTIN5NLRcQYf7;@#=A2XH+^Ndb]afJ?+:<\_7G@9S
,W.Uc&R-)#-N5+U8VHJ3C=72XVTOO_7G70f<K.VOC/FbE05PP[:HJX84gQ<_+CEI
XEgJFf&_6OT9]bK?eePL+@1_>Ec&N8:)\L[+QS^O2I:]VJZ_[])d9P6afZ=)IA?4
BF,7+;H6,baL4Q[>Q56_HKDcT>JM+c.BJ7C&4OY)Y.(Q;1PTTUc(]SAaI,5T&2Nd
16Qc?B+Zc6LW]_/HLPB<g@.eY-OXPdQA^PS#:X^6ZOY]8Kcg]3_QO>.H-eEFUb+a
CHHc&\L8Z^[PPb(5be@]#gW8K<b,E59B)AA##]NU&/T4F)ZFJRg6&#4=62<Z#6<\
6WUC=M&R_C(4HJ]/>eOc[e2-\TNR&AVeRBPOb&K6@E2H+2M1ZgA&c@@GfP-#>OCX
NcV#f=gORC7/\;[.QL[A,BF+7X:]NSR<<1XAPI_K[fg)7U1#c[PgOSeYY94+gCZ7
3bNU#dFCU>f]@ANDI4ZW)GdKO]EBQX,RdQX]K0S8,e#P>RG0^?QddJ&DgRWCR)?\
4I5WJYRQY<=L^#_gVDWQX,RG5+U=PgCW0?#a0<JT]7N+UfgK_/FOSKP4.GB\NE;\
T_X@^K;a#0:N&]b=fMaZ:.a0\eKSY,JO]C]e2B;Y/cQW0S4XQX7S_M09<5QHN5Q,
/a6903fUYKO.H&5SY5fGK]O(Bb:Lg>]?F43&)M9g#F-J80MCbRMUeP3XV:@]U>8)
6:)-2VQ9\6ZN2&1M,(6EY#(+\[DPF]UE/HOfNIEcLH.JD^.;G63L;D)[Wd6FgX+I
M,da/X3VR6OEZW/IB&1:Y1CEIb^X\T]K/^0]1H<355VGeZ3bOENbdg._?YJ:BEK_
c.Y+[F;Fc7;9_@<S=>GE5LKL,XZV2cTeR+&Y(DV9GFbTZ?EOY5e<I-P^)O?>-_6/
4eH=]T]E_@-8MQ(e(6+T/1c[M#Z?YJ][;+G300=;17F3)>0IO<140:?56&cX5KBS
8E-_O9c7&CD0C04W,)0GQRO_7^CQO_>8bD9DGWLX4_?&f6[(+F@(/Aa<1P>G15DL
MBGc&=2,T6b9[YQ83MP;NN12DJSJO9?f[1b\c<R--CIUJ6H).5\9Y#0G&/9&JCBN
?BOHZ3^7S<8SDIfg=;_1JB1&0G],Ac<S1-]/Zf^7TNe//IR+eW0^RLS[@<,1QSfO
2gR+,TbDLb:O8)I)IPgWQ[XYF)ebc?B=Y88:521K88Y/E$
`endprotected


`endif // GUARD_SVT_GPIO_CONFIGURATION_SV
