`ifndef GUARD_SVT_UART_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_UART_TRANSACTION_EXCEPTION_SV

typedef class svt_uart_transaction;

// =============================================================================
// Moved to public svdoc as per star#9000696091
/**
 * This class is the foundation <i>exception</i> descriptor for the UART 
 * transaction class.  The exceptions are errors that may be introduced into
 * transaction, for the purpose of testing how the DUT responds.<p>
 */
class svt_uart_transaction_exception extends svt_exception;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  /**
   * A transaction exception identifies the kind of error to be injected
   */
  typedef enum
  {
    PARITY_ERROR  = `SVT_UART_PARITY_ERROR, /**< This error corrupts the parity bit in the packet*/
    FRAMING_ERROR = `SVT_UART_FRAMING_ERROR,/**< This error insert framing error in the packet*/
    NO_OP_ERROR   = `SVT_UART_NO_OP_ERROR   /**< This error kind selects no error*/
  } error_kind_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Handle to configuration, available for use by constraints. */
  svt_uart_configuration cfg;

  /** Handle to the transaction object to which this exception applies.
   *  This is made available for use by constraints.
   */
  svt_uart_transaction xact;

  //----------------------------------------------------------------------------
  /** Weight variables used to control randomization. */
  // ---------------------------------------------------------------------------
   
  /** Distribution weight controlling the frequency of random <b>PARITY_ERROR<b> error */
  int PARITY_ERROR_wt = 10000;

  /** Distribution weight controlling the frequency of random <b>FRAMING_ERROR</b> errors. */
  int FRAMING_ERROR_wt = 10000;

  /** 
   * Weight controlling frequency of NO_OP_ERROR.
   *
   * This attribute is required to be greater than 0, but will normally be much less than the
   * other _wt values.  If this value less than 1 then pre_randomize() will set NO_OP_ERROR_wt
   * to 1 and issue a warning message.
   */
  protected int NO_OP_ERROR_wt = 1;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables. */
  // ---------------------------------------------------------------------------

  /** Selects the type of error that will be injected. */
  rand error_kind_enum error_kind = NO_OP_ERROR;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Maintains the error distribution based on the assigned weights. */
  constraint distribution_error_kind
  {
    error_kind dist 
    {
      PARITY_ERROR  := PARITY_ERROR_wt,
      FRAMING_ERROR := FRAMING_ERROR_wt,
      NO_OP_ERROR   := NO_OP_ERROR_wt
    };
  }

  constraint valid_ranges
  {
    if(cfg.parity_type == svt_uart_configuration::NO_PARITY)
      error_kind != PARITY_ERROR;
  }	       
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_uart_transaction_exception");

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_uart_transaction_exception)
    `svt_field_object(cfg             , `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(xact            , `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_int   (PARITY_ERROR_wt , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (FRAMING_ERROR_wt, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (NO_OP_ERROR_wt  , `SVT_ALL_ON|`SVT_DEC)
    `svt_field_enum  (error_kind_enum , error_kind ,`SVT_ALL_ON)
  `svt_data_member_end(svt_uart_transaction_exception)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

  // ---------------------------------------------------------------------------
  /** Does basic validation of the object contents. */
  extern virtual function bit do_is_valid( bit silent = 1, int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision( svt_exception test_exception );

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val( string prop_name, 
                                            ref bit [1023:0] prop_val, 
                                            input int array_ix, 
                                            ref `SVT_DATA_TYPE data_obj );

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val( string prop_name,  
                                            bit [1023:0] prop_val, 
                                            int array_ix );

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
   * @return Status indicating the success/failure of the encode.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
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
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
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
  extern virtual function svt_pattern allocate_pattern();
     
  // ---------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
  /** 
   * Sets the randomize weights for all *_wt attributes except NO_OP_ERROR_wt to new_weight. 
   *
   * @param new_weight Value to set all *_wt attributes to (NO_OP_ERROR_wt is not updated).
   */
  extern virtual function void set_constraint_weights(int new_weight);
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
^<[Q/b9XeGCfZRQ7A=6_eDY/UbICF.A??\>;G.&@E6SfL;=#5c>T&)efQB:4,9Vf
4YB6@\UKf<ND<4@K3Nc55^U9S][IX<<>7QLaAD1;e?LFYN8=g)@g=ULZ^HW@G0X\
;1^F,\00(#cHL6ED._6;+/K?e3FaYGU<L?(Q&=Zc@<GaBN?<LK_[49SYNee#6\CZ
J8dLQ;1FN(^SLW<ZX=NH2/US]A+&+Te:14<7N0]R.U[/5-5ET5.GXYP[Ce==;=M&
HCVJc4<;F#NS*$
`endprotected


// -----------------------------------------------------------------------------
//vcs_vip_protect 
`protected
1)RWP@^?_4d6HCO8D\\BR/gR=15ffE@bWCY4@O)b(LD-?+)^.U-U/(W=O?J2,XP1
A;;C4He&6P@N-\O9XQd8/O].WX5d8ALRJQRW,WbI^\\Q^BZ,fW7]]eb<]W,>NLc5
baf_[:],Yd#K1,5CS1OZg1Z4JK4K_S6COd\N/c2c_0e]d&]<(MP0Z&gf8:DBbEGI
@VZfPL[:a\eLY<HHKIfSAELH6\N40IFeO/b7@+M52e]3Q[KS^f?\?L[3H)&<baG(
d9GH4.P\O9:]SNZH.NYNTW17#S2:.238BIcT@V:P>9,54M1.RA+#]c<B<FH1d+99
EaW4V\<Z)a7,KSb9Z8,W2/f4;NLK2+VVOLGB/-\-:2^3Y7B?Ia^+ZV@QAYM]MY.H
:GJN@KBf4(X(3HBD7P)Q4B-A\T5V^HG1[g,#),YdU/e5Ue6Y^@1dcIA).6.JSX6K
f5JZe9Sef0bZ6[U\?T8NRdA-?;?UVaRR/3\>KRKC:I\g+b,PPPK^0Z?6+)W\JK+S
B<Qcb(F+(_DN0cUg@&74Wec]0BB\?O7:IXU?c+.#FV5D65G((4XgZ9DUXA_U<9;<
0fOFQd#_KVNNLccS2+[a^/#-^0:Y:F(K>0+DEQM9D]XW?O/D:aYVN+CU#A_52bL^
@>dTe?X)Zf\Y.BZ7&1@3B?-1GR>VIK_LSC<)YB791\+UGRS\0;22#SB]-[S1bHB0
QSX_=\B=2e:4<c45)LF?IeF?:e@>:7dY#\&XWfVgX0;U8]_Kd3afCC>T(SRMQ^[R
L/>4@6VCJac/K>@ABQI:4,1WQA/.?GBE,M^d<f55Q.:4GP#eI^:_D6EQBR-PQ=OY
Sf-SF.>e6X;CN=6])MSJY>0:?ID?5E[fO[&IP-8-0eeL?,.ACV@BKLTE6,5@b<HX
R//,@JFc:@9SO[P.BDN0RWaN=4ZRLH3D+bcg^bM#^;#+[WJ4Pdb5&I&6gOT3=3\S
]VRgL])b:.9I_ZPc0Ta0S)@<D(/F8O(=N:SBDY8KC6a2PMDR+F:^/(YV#J82.;&<
ffRM=^?#1A/HY8VINPA-Zb3cMPXg@/GgS/JR(MBDZ3fCfT=cf@XAA5[-_dC2fQId
RTbW1ML#-fLZ68W?HMc+0+P7<6C\^[Xa8PWM6M2K0+7II3[BgS7Ced.,_M>[A/^8
BW.Mc@#F[&]\[H9aA8>3[JUYa00Z-ZO1K(O#M+8EX+^YTILTKCe[5WZ3MOAUM3e4
>@2\^R:NI^3F+,X:W]<P19L,3#RT1C#0b.:I2<[N.GEH3Y./FHZZ;]5C_87VB_A#
KB2FW>DQKS=KC/[6W.a2&.7_.F#JCVJWEaQ?GZ)HOB+P_/@KUcRBAWdd]^]3bB&e
H#f<74M\/WYHFc@\ZZ=K9F.//[NcfGg.YQ]K9P2>R2.0@+V6FH4EM7BTPeZLE(53
M\?_UMM2ST4a>:T/7Q@8]]e&HR7/a.T9eGH29&9J=#<<U+=NbYFQ1BgeM&A?bHIe
8?4Ob[8EfX.&G7b4](dg&#^9RH&f=3dJ&?#M28cbB1K4SQ]LFI<.FFGe,W8E-E[C
IR7?9)2YHd^0(da<[0&gTGQ(DcF2PafUZ5a(54OG?@Z3Z__1aI#T\[cO#+>8Eg&R
T1(KGLg]O#84-#/RE)Sc]C+=?B#:_PZgI^X4?81Zc9A4PY62_3J_96C.9+)R<TAX
=NDKKa9Z;8K+P1X,f;CR2LR3+<8Ag645XEW;KgKTIR3:)#:f<C[=II?Sag2)B_+2
^LYBePCP&U&44]UKfT_YKW\,SKEYAIO.:0KXM[G_^9RcL&VFVG.7VGEK6fa9L:41
4[\#:83]L3&fID<b&]_JP>VF+XJB>8H2K.8N8/g(F@S\b>d1U@_g8\[8?&/P9^71
&8g6OaX6g-,7F^Ke)LN0>#@PO>M;C1PH&<Jd(1>>_5CZI?M,XLNEa9Ba-ZGM-Y1(
:SZe\F.YgS_<=N>OR+]AD;RERP0H]4F5Z=_YTXXN7&c2bSfg]X/#AA0FK6D_=Pd<
BfE&BMbf?9A@5=,>;=1N-+NDdTWL7\,0R^gXDbSMLDZ<;T\G\#/T71XO3&)<a>,b
(R)XH1@2@5<.I;B-4TV3@05^XPI#d<+<cX8O(IY&-cJeCQ47&S](P)D&<CUe&]##
@5[.g1W[EW9@f-Z2PMKAU\gB^#;9Eb0D#3.a;25Jdc+a[RPYeS.1QYF?=#2]E#AT
.\7W@P(/R?/L2Sd#5Z(>?QL48<50T12(<H-P\O[0CEdF=(e=Gc:ZfA6NT]XW_G8O
,21>^]OU<9d7&26eEYY:GGPH,Y1BC-5E=L11R=fQ?H2^+)g1eZ#V5OYD3O>3Y=f-
ALB^FC+GNbVV)XbVVL6:3N/YZFBf\<d\HB,C(,AF&9:20M+D&2B;8IB8?-PMfd7Y
4CKROWIH?:CB6\ACN#^H0b;_]bZBa.-4NYbS:g2=4NTGHG6F?>62UOHSSbA:\^D<
eKLRJK;e@^-2D-a[VHMRaT;g8f>D@\+c8:Z.T/0g37?b]K&-<WD([FZ4(RL78AM5
c\Z\?c4eCKbX^L\VdRa40f9=TWM-&5Lc<OV-DGCFP/;.YdGZ;-/7UbQBR#=5Q>EN
Hd9Ha0K0X_QR4\[W?:H+@,UC8KIaJbHM^.T?CS#fGH)_0>1<1EcPT#QBL@X[cb^S
Y:52I0@ORe]=B=3dFWC/[;?b(d>]D7D;Q3\dTEgK5AY3D.EB9US2-LQ[cRd>.NF\
]L_+=U7LR80WNObR=URf5)1Sf)QRPb[eT>J+cH3]^3B82_fN^OSV\[Zcb:(E@FW+
8_6C(dKE<gV8AM/CN#1F,JL1E]:Q3/JG,[W[&D+<I>&dZd-O#[YI.eM:a?<YU>(d
A_f+?@8HFI^C;N3G?I=KM(f&)<16)]H#GQaSVOKQ@b#Ad-LcC20feNL9&,cO:fXL
@g-b3HD7^5TbdR7(7#)NJW:D_=9U=].EX-G0Q:Z\K/4_4bJ/LHH7M;Cgb<#WFbM1
&/d5\<gHN9g0Mad9DT/Jg3<A5LLJI0N/39,,fZZ1/(e6W];,AV-5OJF68;Eb?W&H
:U)N=CEZcHdd:SMV/K-)W:<6>-36:cZQb68FfPc,-DJ[(;&J>2()8;+S]>XI3fW#
6;[N)=F+]Z079QN>A_XLZ/K:@)bQXRO?3&[8,ESaW7#?WR58)S&SXRcO+M#YbHBQ
d5EH=1=bgeWOSN[8fHU@8\c)d[ZKH=4A,):OdV)f_&]D,Z/]NdbW(&5WW=[DgRG[
g2BT3-]EX7GP]CfEK51fZL)e2\3=503DIFVeXdCTO@eVDO5SeSUE)MML7D8JV2Q5
&@S_5#bE;4WKO10_b4@;PSJ;Jd[;MN6EY[50-34(6,Q,J2XG=##a8BM7#N_A)A)&
<-3&3-U41@-@UD[4_aNdI],T1ID2Kc5fW,>[[=SUT::LT95@3R@)N:80254ZA>AO
NW1]D^+P3W+(ONQ\L_9Z9#]6dQK6+G),X90]b9+^4Wd)JF>ePI>dU1HXI#C\R/4+
T?74_gT9TIN4FS:VZ3U5&T,c7e@[6f_DN:G4#]geb2T(aD@KLX?2,4PCZ,H>gYU^
2ZGRVXN.3c62A3A9O5IG?(Q.,#SBR8_b6bBDC^^WP@Bb&;.M1(?db)1HB.8cSYKf
@[;L3gdEE=BZ1^3]Q.8KV,#-1_2O)QVSXF&SU#,)-&g)<gV)<Vb1;Q5GDVR#-gZ5
#GW6I0L;3?cE;f=9-WeJbG?#R=D7dU/EdeVZ5.gVHJAgYF9VWWMW+_4<=T/(W?@e
KAcI-cV6e.X706<N]5GBVg\L5WUSF,:HEBI(+JZ99-C(^2>a+\LE;M+2cJADIb94
g]IbLA0/JTR>T/F6L_J6g^,#dSeI7D/+/+W/9b1g]BIYZ1DQ3eFZ>Da<U=K\MgLH
Xga=a56TNce<.I\SC&/?\gDPI\=W29c2@N,CQ.Q#F,SU&#HY6P\e1^O5L?cDE=#J
&:6L]5YEH4>_cZT/.AFZS??9/Ef)DDQUU1EFMDZ(MeO]a7DYEZMVe@4Va8U7[\1.
+F<d//bf6U2N3-E[-QQ(8-Od]M^]R4gV3]0eb[1XY.PfH_\FbX;c[(X7HafZ>3&)
^WRZSEOA7SV?9()+^ebJec0a+5-Ac\Y)LC+ULL?PG,1=8#TU?OB<8GQ8S7)[&4>3
F.BAW?QDEd0EHf+[K[WQQg_2(,Y6.OKI)X#M3XSL655J8(LXeCgO@.Y>F_+ITD-[
)2c&S:87OH)>\bUd^1Ib/79+aSQ55VBB76]9I^7@V,De7\#=eYC<TT\C??/,KK)Q
R8\KEWBaVUg7^\R93b>c^RVE_gP3E44YXcGK)X-2O@44OQ3eLR7D>Q#(gJ.4)>K@
ZZVTP=KB[Z3R5_#K@/Y@K[<M3L^-^JKT,F#^BNbbV9P^f1:9U^KS[]IDGgGPRI5,
Gg6L#TP/65g24J\:BaL>>NI3Y-+UO._[K91W\90gM62.McfZ,2MSZg^G9OCPKJ??
S-g:@C&Vc3-cP24]563+,gKYag>?D.GbV[U(f=1QKg5?)fLF>f?CP7>[9-\I/FGD
^Q&;F]Q9SRL)E/JN&1&W[&N&[Z;eE(b6NT;7;>\>\HD3G)F?^VS+-ZBT&SWLCXA9
N<I4H5#O2&=fL,.FAOggO,Vb(c<@XOgL1^fKOa<X-=GJEFS<0,EJ8aC[)#9:7S#3
V_RfZ#D_7aWJ)^fEG1&UHeK(e7S/7TY&42ecD5bf75g@:DKL:6Fb39(IJHM/=c8,
74SF&]<53SfEY]N68&P#<40?8Z1bNS_8<3,g;Sa=66E0PNGXHcD(2M&41M+J5e]#
NF1H:;ETfL)_T6(Z#5If?N^BK=XMXK7?K_S->AXL-M7<dAYD2:RG[Y4LRT(O1JBU
e[T1#HfD2:K[,52bF#R;8[R,#&M++8@)f@Y;gVTMJ]eP,:P7?ObR-E&M<][F6TU;
.9X0@gICSCAN]@)#dR,_FB&C1RH)2<:Ka8Bd(&5]<R2c8>Fg)<\[/f^^^=,U_ge&
6dDCA=NN.XPaf90^J-YP/gM2bYPVH]<OCbV\Nd4[.4V]eZ.YBR?WW2.148d-c[PC
+H/(EC][54L;.O(7^e]Y.G/-#(fW\geL7OV/,S0B)Xb0EJWABKE0e9H&.gOZ/R3N
HZS[:PeVC+Fb(_RObCVFR<Z9:UI.F&Mg[Sd0@++;S&HREg,S[bMD3dIV<gIf3-QX
ceT4L9WPA2?2<0DN9[YgG&4379/K2W0H_,2(I&G8e<4_/>P^AI;R8b0DAQG9FSIL
:?K)+.0>CYe&_XK?E(d:UI1d?^)e1<e8C<gRH8B_T(3[+E^I=69@CPfV3J+?dEHN
DHU3M;6;N@\999gW;>=b7Z:OM:9MXT:ITaIW[[(8.Q5:Q<+-)G&GF,(9BRIa:ObY
gSET915Qe4G65WREE]AbMIgJU<E?GKYCbdWJPCKT/+KD0a,e3dOKCK\Q-e?e)OY6
cQ7=AKf@S<(+RD64Y4.5NG^<7T2#UL^Ad&V2PL:(N[J<LIO:R0BY#_89<b0>Q:aB
.>;^W1AJ3W7eBaZJLBE[^L[#P6_8H;-aZ-=Ab,=QU8cSL:bW8fJ<QJEA(;I\T\[c
aN@:fE/_1M^_;,UWZcZUDXG^T1YE;FI8=HK,L8Be[C^IY,TZVMfA/)[JJXeO0KIA
PDUPBcW0[72UX7gE9XWTFY08TVfHS.HB.eabd@4J3Z>aZMF:R6^c&7J-f9<FdX^G
TI)If>Vf-H#RWAcINP_A]eV3YD>,#M0dTZWbC;4)+,_BVe)R55FS61<FcEMeA_#5
79_:+P]]D6+32ORb,d+97?c_0fdU-AT8,QMPKfTFa/:^V-d/-UQ7KZ_)[V@48-OK
>_,R6P],]J>Oe8CMPU3aECZQ=W4RKNc35<R3(1>e+<J?G0QA=)#GON>NJ_VJFg;V
W@>d_UfM7FYI5;#;e0OJBU.<5#;V^,7/cM)A;<P2=UU2)DLTa\SM#dBQ;9[V:^:=
?,fEL[6C0[3e^;D.DOFC;e)MS[FV@KH)8VCC4bGE?#0AF,(+gdEf0?DA59f+bJDa
@,861GNMM:EF4-H&>TV)7;e^WHI\ZF^ITS;c-bM]TI7QN1^NOHIf)dbM<f?L@1Y>
?^Tc^UA<B3;E#WHeeJ5E9@-^4][e.E<G?#Xc/)<P23O#Sd1#HJ@X(Qd[-Ia3I\<4
/e6#UOX>Cf(I^)6:)>..d0H;E@.Mb&+1f4^UF2,=D(_0eCE/7ZVZC/71BT:WU.R0
HJb5dO]UNfL-cQ+364:#(a;TS/4#M.b6]d1b#LMZ,;-S_M),-]ZI2Q/,1VJXd(f,
_.K,>[VBFJWR?^4aAI_0NaD_C37CBL2a=BP#Y#8];Z]g:Ia[C;YVf?&]O/.W_c6S
HcW]K_dD&C&7g,7)3P#c2KA^1,bNKCb7Xf9JOd-OK)V2g(ggW#gONa(5e^g)NI&\
fDXA[OUF>[^-/38.HgF&BU.Ac#TC?B]-..FH(eQG@&7Jb@F1WFGO<F-V/WfX4;R_
:cZ@/LU#4]69CKKH@1JT[BKLe1gZ0A1<@a.T)CdKf[QOc+A6c@3#O;D;&,X#:PP#
-GX1QgFG5a574JJVJK.d8@AM<:+;]d;K(Bc.,+LPc:@T8M]eOLa/>NB#gJ)Ng^^V
-=1c\W,b?eA1W6KRP8#G;?/E#\Oc&39O@R8:cV;JJF,&,V:4UEEdaJece8dTQ2^M
N,P>3[aSFS:>]I[\dYLc:36(QaNT<SNSGI5Z<8&a,/DYfDg]#4V#9.ZV084Sd.XB
[JAdcD>aLPdPK<C@?9dZ(\5:A.<=0>2XQZ#La\].D5=QFH6bI-SL4Da>U>GKBNV8
eIE?Z1UYQUCE=QNDP_K/EF\eSdAJ5L=LB(/Ufd/K/Q9[]fU-gDY^HB0AJ^MF[.1]
5T:e(JIFH+6X>;I+c3;d[F+F6/HVD;I7#,=^(S9@Ec=6D9Gce_6OU&1]-U>_J,@Z
^eQ+7)(K9]QSX3=WZf0I(G84C3;c;8d1RcaDZggCQBEB4Tb6?Ud+-=S3+fV#KL[K
I:/M2Db68L;1+\19[+SgUB@fbP4OYKU;CG1J__TJ[\<b1e?8?E;QER/Y>BgSe]E+
YLb\K]+2cW8>fZ1>K&L)P(;/<C/1G:&G5A?6K?5VJ1ESDN1)e?Q,LV3?)d]#D(7N
]0/TH36F=A7I/B3Rb40;D/M7F63-;;Y6S:C42JI7M5.U@fZ<GIJD/H&[?6..MgG/
S=UVU1-9d>.15g/35MM,_.4I>5P+Xc8O=_A<C-<4RZe=gD>eTd1[SK=eNg)E=)5,
,R+Q.J,73;&@g&UBV]0>N]B[c#6P5:EZEfTW:]QefAMdEYEb(QEIVO)WOb2D2]Lf
EX:gWS&]M^L&SX[U34U<eW8BU/NX>#:_W(FKg.G>c+U?F)GEF5E?2KVN@K_N_W9>
=Ne.EI[d;7N#2(:)=.P2?33\#3D7cP[QFL4I<,[aAO^NX1fNTa?+F,R+(09a[QX4
^&5#0[U5ONZS:c?WT2Lb=c/-3&J1CN@(09NB4TDE<0eFd5KTe_HeE,C;W+TWHd.J
d[3PS_SVbMP^CaQ6Y(Yf(ZgcB)[W2F(&CGVS=;X5@f-XbVNf).4>T<^AJ3bN:EHN
(&6Q+,Kd:dZQ.MXATDV0@DF]^6JXHG00),.0L6E<W1_0gE\,gf7BX8_.2cc2P7.C
Q=H?d)(/([6R?#28P#]dW<A8Ff.eAgT4,\ODY&C]BX,U\]OM\aT82EOCXC/>fBZY
cXVfUC&(X^g2USA+a(B)MPR<=B,<\PF/cW/T&\-XT=B.P,OP&N)9Ncd.IDHeT2)I
?9/aGU1.&Da(HA;]LR<A5?dIGdAM7W?4)(=RHT>N_7;gF5M/CH##\M2eP1Vd2C\6
[0b_3;H01=M=NAIA8C>Y:_f95f^VbIY/Wd8PR8QK4]PNT?7DIO@@G(0@94-H:g0?
NS9b4OZU9/B6<E<HAe+4;[Ub]CTXMV;8b9gTZ&FPdTFAMF&EdIOJ-DG5<aZRNcF^
;U^,)Y9#??@LJB#fR\SZ0MA3)7#J&DVc;=CO.DS_+/+.NV.CGY>dWRHAec^EW.3V
F\0DNQIef^:<)g0_//_EW,]H-?^#2+;(^W4f9#+AF=1Y:_UKYF9/U5KXbLW:T8MD
E=#&L#(C0#,=#C<ME/4C4UO0fA#G+<-2T+4aSXfSg^TX.LE6+.R>U684+-Z&.c]=
QX_@NBGT3g3=&NGFIV:QggJBgc5b6[Bb<XD1[#=V1\S@bPd=LM7b.DBc/VAU,CFD
c5_>YKVUMW=/-L;?W8cdN1>IO)[CL(<+d@]UF8Dg<R2BW3TW:1eAM;I?INKDAT&H
\X9+D&Z2Y+S^..PeFR<^WOSOg_EB5>L5-Y;VYP](KID6LXB]TXJK>2:g#]Z<@aOM
=_BT,FPX#7,2Q1P<C3]Y+1G/)<8&3PGC+(4bV9PA@_Na1[fd.<2+f);0VQ2dL29F
=JgT;=Z=H?JJTf)=a.G3PSYKV/.c&53K(4:R:O<PZ;Ib-><f7/8;:=+)gUZ51b_Y
I>b\+Q7a5R]4e)_1X:8ZM4eVV4?.&=R-?Pb3N5/5)#Y^BK9&gKMC=g90K2E,A-eK
XS#EMSgdO[BG.1OUBKK3ILGTL27OT-=21/8#BU?Od-CaR[/GSMGE<\;P(/#e,Wd6
e7=Na]N_c44UI8B0/U5)_Z,SM^_0F=0JTL0JO//e1bd)1IS6UQB,Z&W9ZX.(aK+c
I,OJ2MB5XR@D0KBPb/c;5?SHP;4=_;Y4d=7L>@Ub\P7YMZ\AaB1e)b,0K^YbCXXP
TB-e(Kf^FDVXD)c3I;UUfbSaa4gZZLY5.#X^5&NEUG#a55_FHHB?P^TUDW?CL[GT
aTT-MXXTREGcZ]RReGQITA3R0.&[CDKa;L<#>KGW4[eWf(IG@;2c@+J39KHg^1AF
(PAVVG&#PY2adG3[Z?8VOE:4N1@07URK>S]5<0#=KM8L=/D.H@N@PCU&>OHCY=K_
7EX<1^0PMMWNQC&-+\D,-?#d0^M1gH@bc[HXgWEUSL.H4[2HVN:[A>U,;A?5FD[Z
^JZH2W3:27_?O.Od]?X.=HRL---=LcN=74])RXR[4S<c4_;2C<[EVSNNN6KO1E_\
X+K.ZI#<X);5:8AK[E<#GZd1T>Ye@A?<8d,6RbBT3cF;ER\bW)8Q&RI-T(McW/W,
aB\N:.@=/R=UN?Ca=A0ILYRR2XcWfb81dU<D7N4S\e0DA>AZ9?-ME-[[P\L>X[(G
())B<5@A=[W;_86>M7Wc1;C3WOO[ZZ>1gJS.b>a1]61T_A(aKQBGeJ^^Mb&<J<>g
[GY7[.PL<ec1eL;=EeW50/NBXK.I[N>F,;b6[Z>W,)^R6XeL<NQ-]7X;D:SM5a,M
gO8?M^=YL+^8d2#1]5Z]^B.]HUSPV-U@->0?D,+7dY?^Q77[6eJ\)abW4;0]gfC.
;3Pe@W#A;5;VT43@d2gOa12)3K1PW)[(N(C(WGF/2LcW0;Y]WbE_:b\;gDZWN985
/VZY;:b715P->aJ?YAa]@<1Rb2Ed6e+(UR?V(\V&104-,1[NR4RV;VdXf\Q7O[W8
)ABY@9AV\-Z&\FfFW2[(=JTWSPYY\IS(/d;\Y01Y,=aXdPU@R4YYe3WI1=V8&WZ>
eM/>+T4<0)6a9_Vd<[GKd9_9.5C-XBJe^\U\,R(IQ+WIN9>^2V:OIUL;K4K-cI)R
VU@#6+X61gKS5c7Q<=F[J#JY&6LN6<BCLM?XAVQ)2PfDOT;4U#Jf@cFV1TA/S=Tc
fFb4FY5#9C2RUbMB1]Pa-<1-B2TD#aC)7&F,[>^.^g)SNQ)DbT1bHQ\agf]8/4?W
5VUT8fV6X+YU9:C+:7WGPL?POF)W_?@Q+#-Hb?U(\^J5UH?^Q(&DAWZBKVfHfP(b
8^0QT6TRfCOLaeH1RN30ZMG<+^5<GHc76CcaDGZ2_]M@KK8>d1)a\,/>MW#N83a/
TZ8>^Q6^^e.cOUg>gWZM1/JJ<_Od/daf5Y)e54Fbdd:FK/fd7=J9H:Ic5:HCIPB]
CI4/4Y:+7,]B4a7?1c+505TW9??(P(>Y6a@\CTBV)/QAgPa8]Wd[9,aWEXHBaPUW
/&8]a@>VH<^MVgI1]Ld.AZLTI&X6A1IYQK?d^)7+(P@E,bMAQB[baZeea@&cGO5:
-><0?.ON<RB72Bd7P6,bX:fO20CGd2Q,.K]+72^R/d&]=6BU[X<FE_)QGD9YM<+f
e6XP\[4Y;3ZVXL03ba]W4b.Sd4R;/0UTIAI@2AAcWVONG(L>7Y<.OH:b^)Kb3aGN
[U&G]]S,Y77a2]IU,O^A>U-B+ZABT@US##a#<:/,#H&9eKWWP?3KB4TFfgd94-=W
EIg3G6f:GgED/.gK.),1Q@37[16fIUcI/(eB)\03Z?f\[&IJJ_Cf0A,7afgYKDWg
NRTKca3(MJUFd?1f\)38^<3,,aGQAEg87R(&9K9S]e)K^FV?HaUT4BDORTT,6T\N
?P/>Dd<O[;;DDR&d;EZZ;J=1<2dZL52V^]6F^fX6N_<-)J4F42?;RSIb)@#GODO3
1N78M_cUO;=_\C&O5\WUD@U55D59g:LAWL:WV<3R025g#.[0FI)X/6]B(]g/e7SI
QeCMR-DZ>c]@^8V](Sg#BH-BO:]<Lf4V<G[>MRb[V\S[+F]3--P;[5\-#98:K5[1
F,OYJ8TKC@_DJD723FC?=YVgYAD?]0W5Y&_]WO+[F9(9PB;0ZI;cTaKe]d8fZ=+E
W;N4-,8Vb+<R)H(YMeA^X90?JRc5;)UUKNba0^3I7K8_c@8;EYOEGH6T8[[b)]b.
B)(C9)GdFEH@7>=#D9.1IVUS[[D4HdIDE/E]:(#4W+/a^XDH9/Z)Te,5E](<VN)X
>KQ5X0+gZHbaB;ZSN3172K),D97gMP0_O)CI(GOK,2/\;@N#><V^2E],X+d\9U_>
)AWFX0OJKGVcUX7I^H]B8dXa;F5OP/EFf1\8T<XJQ9e+6HT76IEI?UCc16dW>&P;
&0>)Za,4@)GB=NgN?XTJL[]EN=0T0-B08d55?Zag/.CEKSb4(].YP=:>/NK.UQP6
b7fbJ=9O^FXU9[_Mf<a_dMbW^165>MD=&A>)Bbg[\;NacWQc.7/(5XC4[<#&.5IU
QBQ#[)K+?5_5Sd7bEfY/Y@7\F\[^)F,+)T#-;,]U/a_Z3W.@/E325>:g\/:F(DWG
&_]^9GAOZOCFRQ7T(Q4JY1IGe_W8T6:Q]\2QI0UReaT[\0IMVU(A9eDGV,^UNIH5
O/7QT(5M02^BZS4OE3O2[S+7H,f(-,O5QDE;Y3We-D(U/?<33-^E3KFOPL^M?eS:
C8?EY>.d8GEVM//#D3XT-^4QgEF?bg8aU0477fa+9f@+@79G/eWG@/UN9[V3W;T1
eX8M=Ea-&[f6Q7OM_R8NSF&.<_g?dbgMX>D^7?S.dN=D7>NB71]QMVR<3^[0^B+E
]c9&34NYcbEeK5Te^dg?&KCb.W@V50-<g&9QG45B?\S^&UF]S-V9PNIQBWOff)SH
5>KgKP:7L.Rdg2U_1fM2WX[F#Eag/-adEZLG+2+U58[<K>\VX2AYAI_1GKVG/.1E
H)0=gdYV&O[>H&S\#T:@R&UW-c]/-a3gK(T??+U&#S9CD98B&6(LK)B3?6C]W?>4
RUF5X)&<9VTL9BJV)QA=ZI9Ja[K]R0K+QN:-Vd#095]R.O/][10715U=Mg+26/#G
KOJ\8@FPD45&C:H.0Z?VFL4[HA[NK&6d5493\]#K+U]O+=HAG]I]6CIVFe.e,-CR
cV\BV_USCXIE8A<Wa&+QYeA^+2/3XC9b(;=,MSR^<7UV9/ORFN4/13EbS1-UL;JN
MeKEe.QZ>.Q2ZO@(ZfG2NE@T>@bQf:H=2VcS&T1e>;fSe1G.=8;KXbKcVGM<D74I
_38Qdg.,bK9(,6@7U_?XTc0D?8H+F=_O66(B^SG3K#7N+2<SBRKH]:V_gd\LY?b^
R,N3H6cX53H4&c#B>S,([NR\a+gEZAA#dEbV>#G2#b:#-:NJff,\:V.9GP7V0<e]
ANQUUPMT64Ed<0g,7>Yd?#25IYM;aI9F=:YAHa2\W<(+)1G1fYd)e?/.2J:aP1,3
\I:F-I;<<d[a@FT5J5@.PC4:[NG>U[6?P>F\XPN2=I:bL#F#BP,FJ:65H:-P,482
5]Ic>EA;=\P6S#_d-AOf@b27>KB?U;Y[8;NF,<(C=;3B)C^Y]YgdaHK@BXOHK\R,
cM4;IaTNV5<b0[CDgHU3FJTeL7Y9OHKU(c3)QVER3XO&MQ7,cJ@L8MMe_QdZ=aN8
N8;+X<Z7)9#aSc)4Id_Z>H&?>FK2U93)[>_E5514Y5UXS2DXBAQ,V0/gaWdLfC&2
7OJ397ea9TD[[.5Aa+66J:Xd21JXTaLVMI.TOW52J060bGJYaF)KO>&RVLJeIULO
L6-@_@9O-,/20FQ>\?9F4[IR<Wa>b7Y1[2,C@f-,U_B,Z^5WRa_,E=-)Tcg(Y0bJ
691L3]#M<9E&N.AA3KTc&&XI(Oc@BYd^D=,529<#@DI>=[FQF[I+\W71@OZ7L)EE
C?fK?:DOZ);K:D+(&ZDQ@fO3cD9b#<#[,0-Gf;FbJ12\gU0B+T.WOOV@bU:=7BMJ
6DCXa(JfcU8Q;<)1)+]S15AF<B]J&3SZ>ad3V#WfBOPc<]8?^QR?-32SN=<=\BU#
a@HENNB6L^9D9Ef@@2[>5bLGFA@O];>KV\2Z)YFA1ZH/=OH.U8cUdcZLfE,7)L0N
>6K53_Z5V\2FO3:>X_(3Sa<5f0;d)4a<M,H--\Adg_@FB\?\O/,CM>DM#K6[ZH:2
MOcYg^\0K<2A_N4^^dK##4:Xa@72Gd;.0d<EV+Yee+XV<Ud<J9)(\6WV+TDcAe,K
AL8_9?S;/^R_fXU8.eKSB4T@dL&2c6TJ440e0W]f.\=J-#&1O@MXcF?]9V,5cVH(
\?3#2I\\WX-&_eONCVE^LNGI3H/&IW_D/[OZ+H_\>=\2G32ZYFDZ>Z?<cO8MgHZe
XDQGMC+QBO(OMd)2C+(@>Y,=Z:gdIH(P:$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_TRANSACTION_EXCEPTION_SV
   

