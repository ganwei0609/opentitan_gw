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

`ifndef GUARD_SVT_GPIO_TRANSACTION_SV
`define GUARD_SVT_GPIO_TRANSACTION_SV

/** Class defining a GPIO transaction */
class svt_gpio_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Transaction command values.
   *
   * - READ       Read the current GPIO inputs
   * - WRITE      Set the GPIO outputs
   * - INTERRUPT  An interrupt condition was detected
   * - PULSE      Toggle the GPIO outputs for 1 cycle
   * .
   */
  typedef enum {
    READ      = `SVT_GPIO_CMD_READ,
    WRITE     = `SVT_GPIO_CMD_WRITE,
    PULSE     = `SVT_GPIO_CMD_PULSE,
    INTERRUPT = `SVT_GPIO_CMD_INTERRUPT
  } cmd_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** Transaction command */
  rand cmd_enum cmd = READ;

  /** Data portion of transaction.
   *
   *  For READ and INTERRUPT transactions, it contains the current GPIO inputs value.
   */
  rand svt_gpio_data_t data  = '0;

  /** Data bit enable
   *
   * GPIO output is affected by WRITE or PULSE operations only if the corresponding bit
   * is 1. For INTERRUPT transactions, indicates which GPIO input(s) triggered the
   * interrupt.  Ignored for all other transactions.
   */
  rand svt_gpio_data_t enable  = '0;

  /** Number of clock cycles to wait after the command has been executed
   *
   *  Default is 0.
   *  For a pure-delay, use a WRITE command with no enabled bits.
   *  For INTERRUPT , the property specifies the number of clock cycles since the
   * previous reported interrupt. The first interrupt is reported with a delay of
   * 'hFFFFFFFF.
   */
  rand int unsigned delay;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Do not generate INTERRUPT commands as they are used solely to report interrupts */
  constraint valid_cmd {
    cmd != INTERRUPT;
  }

  /** Limit the post-command delay to 16 cycles */
  constraint reasonable_delay {
    delay <= 16;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_transaction)
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
  extern function new(string name = "svt_gpio_transaction");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_transaction)
  `svt_data_member_end(svt_gpio_transaction)

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
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

`ifndef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else

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

  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

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

`endif // !`ifndef SVT_VMM_TECHNOLOGY

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

endclass

//svt_vcs_lic_vip_protect
`protected
GHH_CYgHZQ^]ZQ/,V_eQKNXI,D4::g05&>#MI#N/TIgS&>IQSJR75(4>YA+;H+Q+
\_?bdd7+S,+P_KE3L-aMR8a@\a2CS?^Pe+22/6-6\LbIS6MWY?]Z+SJDcF=Tb:&]
\Z2eb,(T17(6,=JCe[1D.#5O<<Z\/[8:]VS>K[S.5O=Z:GRS5=5D]4B?FKS/I+ZH
F7HWE3Q,O=]8?Wa>.R2]Ue@+MY[?6H/4PPR,\4ZIbEVQIZD]@ACL:SA;ZL1=^.bN
[=gZcY0/CVLZD4cKG?[O9)68ag\ZJJRH#_UTGA<[LYQ/]^aP3RY]ZGP^+8,4ZL01
L;(((SV0-LV\PSCV/)&Hf5)N\7H>G.Z.V2D-L_]X-?,S3(Ua>8D9G2FIIRW&fUA>
L0g+/7K86@eZ@TZ[(5_[^;<P;CK[M?Ea?P]:<,8@6.a-MC+Mg=f3Y(PgXX:Z+_52
feKR927FfQ]c@(0Qg)V0M&)J3W/2+C^_]SX8)C.9XNH4Y+Rf@0c=@)_2b>ZA2HYI
XX;3Dg,LG6UfCO5DB>=]J_ZR0&fXSHaY>0Y#S=LH&f(HN+?18THEeS1M2>IJHHR9
L0LR^45G^(K>TTH1:Q.IMW1Y@ITb)eOZ^@&1X=[Ff5_Q>?AZ0=@ASI]L?UM09_@X
,Y[>EJ6MdDG-C4)&TaL.,C,1SY\?c&27[bPOEW:+K.Y2bbU(cUcAdO+fBd>A<0U^
=LAGf]YPN-@K@dK8IFO1>&1;TcN.b:VV&T:T5I#gFM.O8//^e=Hf&C;C?Z5W^F2f
0RcP.-dTE0d_f]7CKF?7+EX]fBP0L.IP3I=/+cK^[YdISbd.(&QaPU9(EaL8L=1e
eO<H(C>c[c/4/9V8@5Xge(TI(@CNJR2B&a=C7#BJ2g,QG,#ZPMN3?R,&-2S<G/\H
Rc]<L8C+?Y.gQR@(-JJ-USOE3OSe?bG>1CC@(XK^N-_N^:>8](X;9ZL\#<Lg1(RW
Rd:bTeAKV.UC&J&?g1D68W9a;M)f2X_-Y8J\Z.a^+SVLOQ=[BDTf20K:OG<@<V&R
;Wa-]MM+:5RXG?Qb8GT++W6+P@M0[49MCc5eYCG=T+b-?Xc_R:6K<=?aV-Kf#Xc+
f&.&(d1.J\IaSNB2#J]B5OY?3A<TC<@;8LPIg;aD6(:F/J(\M<?\E6,W&??2L7Y#
PF6XgEL^HLC:\@V(&PPY#DH._H.:;Q1fI?4Q,(H)1bCPIQHXWfSTW+b@PCZ&Z#F0
Ace50&F#3I+JFPg&3WY-ZW<9eP3f_aVV48EVQK;R]49TSe5(52fXM:\>RSQQNXN<
N):5=#b@&.@^=_Ufd[dRB-cC6ZG,=Ca^@M9X)G,((aE-+66IA1DfVKB^XT4-Y(/8
.@fI\D:POO00V64]A].<J9UGU03Hd<RKG76)?V<S]1/U6A<>,d;aTWgHcMG#[V1V
6Y6NdBIbB1:eS.A[0\Ka3cY#7B[Z;XLF6W_PSCPOA01aG.4@)gag#BI:GI:8+NQN
X[IG2PR=d8F<-P34\0>5&5HX+2>BK7WZK(WCGE.>e-HA/E)&dX49NKGT+)<>@/OK
:13X<b+=J.9P9ESO7H]aM<>e/V?/KDR<CcT9&>bXH;KQ2C,X.;RG??05JZIFO;H+
,VTdTaRPF]3K:Da2aGaJb(e3>L4Qe>fA?2BP61J5b^CZ<H(a_.AbQ\T@W>/F?&7K
C+8&E1XTRO;96(B03I87fb:R5U5R9e35c16bOAZ>gL,QH3(9LK0+Y4OD/ce=(<7+
Y3:R[.8-F26Na-NW\O6b7D0faH3bNGVc6W<M=/U9_?,Q9D]RB?(^>J#&Y@WCM@S0
.-3#>4KM,^U1]K(?M)&cFf0#-/B=>e_]:;Re:H)c]9&T]71L_D[=4ZBSSDU[e-,D
I#>_Q<C/9H<2MI+???.]0310&^g@RLg5X+>&b@.\JXgJLCXN5^[\B??+L9\g_Z?=
^(S91J2MG8/U-7K5+a-W&S9.M08.3\ZI:RXVPRRM1)g2NUL]K4HZTRFWB78P;-IP
,&dK[e:&-A\;AVF#/3O@AJ(\ZZF@Lg>S+=AP/CC9gb9ZO^fQ>^f5^aT5.KSUAC/3
MXX&IF-BDL4+aEaS>&EJP2e\T4DNE]8?L#^ab9=;.Q;/86^K6AS;IF:WP:FBDgS<
&4YL.KE5SHI9a7N<9ab&VaFJa20EfL\.dGPb_OEabCEE00eZ&970CFbP[Q,K+EMO
:^TXC5H:<N&bCV3ZG]Bg731\>D8\dGI\Ea>FC3CMQ+[\UAT9R&=C8O;]gVAW50/]
McIceK7c@+&@)CT&TP8R;7.C<>dfY@^e\/.f/_^\2_X60<<QccGJ-#3+[_NC22TO
<W>:ZYKA9#WLN,W.8?-1DBP.)^TaPe-@?e3@IQc93MUCCM.#YC-[P=9A#e@_?gEH
Y^3(EB@/#gI87\2,?XOfFZU1T5KRgFE#^-+).+,R(-&FLaK5cHPU=](@JWJZ3BF?
LTca?\?D&)R5Bf/Z=g^B7TUJEEace>.ZK6.PBIQG5HZ&:7UUF6c+CW-D=UA<VEM7
X]\TDFJf\P,U7LRB[>#:f8g:&_]+@fV/ZdSIf)?I7b4F()Z#]JVZgcYcIQdDOG+X
8e>^\/WXU0^4ZX:;RG3e<UB/:.Z0J)7&/^L;fBZ2;K&+9#A5e,[)0dNW6gL=1[.G
ggWHM9c]eI9N^RC,HM@PD1@Y:3d34]9gNE08&_LD6Ga-WSRO^ES6A.OC[2D1N+I8
c7G40ca)>cUW^LS)OI8SS+?NO+^Y(B6-:(_-]43V&/OXA7dDO#EMMV#/2g79T3c-
3-+57_=0#,O(3X-J.bO<][_X.)NBQ]J5_;Tf/(ggGc_[CJC/O=W50PL<,&]Z@2XA
/BSBQeGJD8G=^K9dG?#g<0V<QL+H:M>-9&?)EFK[=[eM@WW9^?>Q^7->K9dV<f\=
#3O.(>@g<<R?+6F=5[eP1O.O_(V\M&M49TJ,C]W#?eC[H=J?M,T=M(f75JV2Q9^+
>EP0M\PRXLS7V)RC4GNbRO[F[3_0Ba@JQZ:,C24Ug=UfZBBg(,GS>Z7=JH(CdIA2
.J>AB7c)G/#^&<g9O7;B2P8]c@&264a.QQ6:N=XQ-B/Xcae]2W8?QAg8fbcH@JI0
Q=QT3I8D5<#P/?T(\^/_#,8AGYVb;.#EZa65.HTE:Oe9Z?/2\6UEF?Uc(]fBcNKV
)1K[(RBY)bAT;F9/aK^I\T/>f_gQ89=.NE8Vg#Zd>9^/-/3.Bf>N^A/-]H_-P=b,
]FOdQQEJKM^3.26[^OATg1F,)X&KT]_:_ZQDReeddaIR=N8g]BPWI>+5aA(C6gCI
F#UR#JF&[TAd7HF[IIV9[2X5^OQfTQQ)^5PD-=),2B=e]3/0G86+&)5f)O/@VQ4G
NU>8XR1</bMD^1Cf[P.MO+F9Yag^Y1A;FYa8e0MYM]XfT2>8.H9eM2;RfCAA[Q8(
KEP&:eYD]KL+PA\c:Fb=VJG9Q[36?#/W0\]\AKfURg[fd8U7PH7LD#6)=Ieb@>JV
be:9QK,_0H-dX]G8A5Y873W5HbS\3[F^>>3-<a+F2a07e-(.659?EG+VP,^gc+a#
@PBTdYQ[,FAQeP2BMfQOH=//EWZ-XSB#9TJFe[E\H2=N2.X.7(P2RFGI2REH>,c-
>dR?KeY5N.I<feG8]]R+aUIWC(>PGYHTV3.cLO=9Y9JU>;EN_:9X>G&[;9b4Ka]2
LWcb0M/C8W[GERK\UdaG1dY3B4E_?g;f?Z05K5dA[EV#c1WBKWd5YJ6)+VLKT=.5
ZebgWX8eIbB&&,G-[4:OBe4D/COT-CGdeX;+HX/CCe,F]^V2-O,=2.=BfOTag>:e
,cEc.Ba&Mf+aQ2d4#LKg^^>CNKJ^K@BeHO>V9-L(86F]81MRZ26>A7<#JBIR7H\O
]^L3BZX7BFGZ4TM,:ZM1-eTE9bXR,\E53I_\,1#6GMd9/>S]fYXHbW/b^g9Y>-3]
TES\-^0A7RENFO6X+_I&XYE_cH\P(BXdS7_K?/M0:NW_K[[#GHRLY-7)C.f(J5PQ
<]dOF)\fKJXSbG/8b;9QROM8]X835P,.ZgGLV4JP8L]+9=TKQ7<XMQ?#d)]NK?/3
IZPWR;R=TC1X33]>HIOc\R)dR7VcF@1&R+.>+KBQ1fN+0+9f)[:cSKT)KYfG(bg;
PD/f@a@A20:QPBV4.GP[..=#TEg\9EJL_B0PP&dO&Ic]eUA^fH@.Tdb<@ZLa--W_
4V-FO9>IU[U?V/@5TJ[3O\#/)MI3YZO0GH=g:LMN6J,N;?2cR6U/]FB^P(Z8D,>L
Fa\VL<=BB/R50X-)LVYaDd2\F4Fg/NJQfF0V^8;PBN4(a;GYW&d2BY\A83Pgg,,g
Eg.JRXa_BZ6J3dROM#-3Wf?e:Ef5F9/a@Y=fdVK=1I&47KC5DfF6gJA+bK/5(AP+
Q@QFJ61L>DJ)cf>1;.V[B/L@Q_a+R-HE8Z+LdA[XfVDdM_L3d5M6=FQCV:b2&8[M
VC]8(4HRHU>-8,0WI(U39a6ZK>e,EaGI.2ZZ7f.G\AGG>7-UG89)\Z&8,9M=BG>4
2<.(G_gD95W_W3Pb5Z>[MJGc@<<HF\GBdLb^b\5A#+YGa]S+]W=(&9L<)8X3Ra+5
)IQR[1^8&-P(?)G&&bA<WdWC8R(X.=]&&GL.[>gILVV30.(8YfIdELDU<d#=)Bc/
R016E&8^9)7JE)\1XaJ4/Z^I4eYF\VPE0Z>TK->AbU3IYY5+#d1J22fA]6?Tag8&
C\D\K&?TD7<c7Y]EH5G&4;C\QM]68BY2?@(\gSQMX5:U-5aQW@EWNaS2-fDWE60W
?Fag.D:0]H//QeJ^][Zf_BH@6F;AHG\IPBJW\_ECO\20egZXON(6UEQ021FMDT@L
I1<HUJ4ZKLBA:Jf2JGaK\S\-XHR4Oge28Oc/c<#1JE/cW:4A.PJP;gP0?<#KdKI)
?@KV8)EYGQ5<7I4NBe7a#F9#L0ZK^K\LDWVa3DT._)[bNgDYe6-=7KN8G>=^bEV.
N,e_.L36f6C9\NJC967Z;Df&-UWZLY:L\^0ORA@5Wc&4G2CR)6Tg_f<6@XS]?MNY
.?EN3,2JFU+3?g-caO_/2BfL]aO=;Y3Wb/&6W/<X63@R(Y9YBR0-5Sd\)J9[<<1\
>;fZg7NW_V#8e4)J8g+ENC7;\_gb2c?R[NFGD#Q>-<c,[#&X]C6KGS7W<F7<#JM9
9?e_+Q@&YgF@D^BHXc\XZGAP.WLROeTL/.-PNGGdAVcTf7_aZ@;E^T[dF_WRE7@d
41QQ98Z?.>]8XC=A?(R2]F8K+BV:<Bb&H@gMg2bg;U28gHW^--&&T[33>@aU,^IS
B[>(e:15c\d:F6QX;41G9O_8FHTWeV/+1;NK+bB&-Zac?^:A1:a8,XE4?EF14e\X
-<>\NYHY8cW^Qdb>/S^)O9@5U29Lc]Z6SN8CA#dMfU+(Za&3V.]?b5L@NG)(?FLC
]gQg;0N--<B7.9[+_/7d6N?NFF=>P@\3S3#DWH;C0_X)V?Y+d(&.bN?[HUR><aD1
H+&N84(3F/8R)f^?=)<B]XPN[,K6#6U:]]daS&=Z:RZ/P/;>5WVH/EEX//7/<K8S
I,NQ\9Lg-]9g&Q^S[/=D3=\\eL,,3NLQML1?^+g&Oa@<Qb?C<ZNVfg4CYgd4@P08
R9OXSfbfgcd\FKHGYMb6HD,F=T,Y3bE+gWT@M=NC:>XD@2T<)(dR+=aNWfURHDI4
@7WN7&bBc3=:d\(=ZTf_\KAIS=dSFg)N9_f2dE,#&[O3#J;+SO.7WR1Ue9ZZSQS?
Qb<+dLD7-.C:?@GD6,D9PJ.gWNF5TF)3cO3]@6+Qf4G2V9)U9JNbD-:CCWG4PB^&
bg^8KeIP1/Ag+Oe&^Z[UH&5P9)A5-Q9gY7?Z;0F1EM-.RE2Y=<83LL;N^9Xf]YI@
S8(KO<(TT1S6I:QcU\RB:2?\K7H;V\6<>L28cCWY/OEX@KD7/6QNd8f<:DL^^KR:
NTSc8JE[Ba#2eAVF&U5H3-Q-MHT1eHdYZ)T2;A:&52d0V.N=3@BGU/,?YG@BN&g;
LgO6a^-^JI_FO=d@[I&2d,Z].IUB8gIT;2:_##aP]gPGBS7ZYSNOLZZANVJ0bMVD
Z]HD&YT+(3OM1.DN_P-7ef+]^)IJOg(L(QA/F33>?-7d6ILJG0^[->9Y?T7E8+Z2
e.)f@VRZcMQ)0(1eT=>&bK/?8J+,5OdGRVXH=/.DF\d[.GBPb::de.5_2C_.UK2Z
XXf[PEg7<bUC:RZBe[,W)#B53?W,1\D@E>9\2-cP=;7EP@I-P19:I+G4=B9_57_1
gU51J+VG_<BK8_@T2[:,^fH..6G?E^1@#;J1&FWEJ?4W\Q#ML=NL?WY?NFKgP8d2
=CfdKZfdX0f=?\c^/FWWRNWK0#fII]4G7P;11)>9g34,^I?6YNfGS\MQf9M&)S^e
e]:>;7(LfBF8fITBF_:5/[ePAf0OZ\I[/VHTV-Y@54gKHN8(gLPAPM+Z1>(OH&#a
aAN_B6F;C@#/>XYV6)1?K&g:Y0Sc3V/RBV7_]=F4gC1)]6)]\]:-gOf/>,JPXJ82
&fLE1J9R?^Vg;I7WFg0cH_E9&/GI5d;-M<9ICHGWYB6e>T^N]O3T#OOFK&+#Z+Pc
,=53AaL+e>D:;?HD8X)OOJ20V<7fZZ,e8997bVfTS8Zf21G7e<K&>@75V7-@dM2R
CTM:#9\QUd_)fF45[/32;N)@7e[CW39fNU5/-2C_HfX?-_=(9-ZIEEKFbYVUO(K-
1IW.?9QMIPQ-E_Q50=5CeS)V(V5fP2L4786L,(aeNHBD]BELXJS,UXM=)9;(#LK:
Db[FSERd:9b=0<UC/=g&EW5eQcFa(\EZU:aOLCBS5>;A&.Yb(9<e,MWdSDEZ[EDK
+c[gI,S9Rd9108,T)JNc5KW\+X;O+&fYdeP;@(NXBKEU=a=GPWbUW:a;5:1aV7IP
eZ<YF,6^2g0JW035[GKYa=M^gW4cTZ,^,[0M8@f27Z?K>U6Z[XeJ?X3<&bQb9423
.]CD0=.+DH/R8CN^f:C7@Zb;#A>N+#=fO:egS1e>P#GBbeY:E^IIdGC@9CENA_-a
0:@gY_^I)MXPP;LG1)9V<gR3AXNASWQOfc9IWM_fDcJ.L0@e0W\P04eHLT@A;bZA
4F+(fK4E?_G]&?07I/Rc6(3\]T7.2\LcZ3[FQ)E<?L3HB.TP80X=f;Z6#fd@<3]2
aYW1LSU86f-/=1aY[f4VW\X+U#f+2X<;)\Y@B.+.F6]9fA&_dUKc(AdPOf3F9QfL
L+UC(12UO[9?.Jc8#QECFe0a#+?MQF1E;FGUZKOQ3.<Y^;gTfDD_f:=77d423X3J
QM/?(3)B8KAT>LB#__1@]?5-@.LNM/[7BQ]E7Vb3Wc-IOT,SVd6d5RCQN8KAC_@>
>2EfS0WZd,=X>XTM/b_W@M70e&O0P:c]B>NRA&WfY+Y(X<3I7,>M:PD,<<.]Ff=d
:fKP[H3JFW+-aBZVQfO0T1N)7[P]SYN]DUdJ5AU;6dQ]I9WFfCYLUX7_MRF/Nf+4
Y.G4cGVJ^\K,EYbD7GOQW)IfZW0IE^W/WT[J/KV>MV2?^-(6_faG=JDKbc/C0TVD
46BdL_B+a[C>=3,-X.VYZGB;<V(ff,P\72bZ@\0>X)e8-L=Hd/0,dZ).E8>#.32I
_C^8SE48dBTGJL5[7NT6@]06QP8EbE83LR<4-[MMJAE?O:F=88@gK.dL=D6Ud958
5d<<U0V^)F@bEQS7Q42UcO\f@&aUb,95)#Z,K7]&6/[K2U;]MRZ5KMH9KEI^0O_#
-3X27Q3ACR9fdR4(XfHS]g.1\54P4C.(+CS/H4(R/5bW#IT\\J(:gWH-02,,L]/B
S8LBWg;,P:3_(aEg+9:N-K?\NI>RW@SU0.-0#L<_a;+gKM5\8/3AZcO2=MHN=QYN
R9<d9f+D2==9O]GX@T<5>L+4gH:Vc-\cc62E(B2.BK8eg^d4?09/2LI9<93Z33E;
(FR\R(&T&;^BS^/T1.-7dUL3V_CX\:3&[/K91KO>@07b@;DDf9[G-9BYGc#_AQZ)
IT:eHdc#IDR7O(<3>>BaN^dg4=ZT74fZP06RJ;4Q4e#;2^1/fAFFU0R93;&WEQ\7
Z;M@7dVE4FJ82):A=90e;^g])(a+LdU&(2A#BJKcI]AWW0RaH98Z;/WT1NK7f9;1
]a1e#Bd^L07WCARR:?bYC@@I0^_?].5:E:]\821?Ga81#,b0O3KLe^VN)3d=V8QG
I^I^[KU9R1;KG(bb<\:b_X]>CU->8DO^0a.]FBJ7.WY2E5,dXIDI:MY[=1?W?XO#
V@7SHTBKdJN&)\A4S+FbebXEdQG+=P(Xd+<b\W=NfgbAGb)D5X:=G18cEBd?)@[=
)P:6^6g]7^)Md6b\;JP[0C^ZC+cEXFA\=c)QB3JFM>bY<IO8AJT#I\WgbP4eC1L)
RCYY[18)ABN70Pf3NfYAXI4:Ag+dW=f5cATbMM//4)ABB,M(X\;JF=H[^^c#1]];
J8]fbZ/MgJCE;d-Yb.dF,d@7f9W2g&:&d:80/dgKHBc=g:<?,;Fa+IbcT@95UB43
S#Y9_b6/2#@VD\7OJIH3cf2Q>0]#-(d5XM:AEC0OMWJ.&VG.@ZRRg;&c@^4PV5:>
9L7D>gB08C6:g1:9M)S=HQN9Qg]T>K9B/13KS>f0HL(34A8+d:UbNHIV,W;))@XI
4gD?99/-AE/>3XH\<E(f9&C@&NKeM_WdV8H@9I_cWLe,I=I1MHSTXSbD)N+a;(_8
P]:aQ@gSL;+7)?PLU9)_2EA^/O1OPS2H49C#fD&LE.>0S;Jd+1CDAZM8XcHS^b/E
+HVT]K]ReGI_;MK=[9KC+-3;3&POCb(J\ET;2^)E[:\Z<JP+2WGCUc?9\M\gUe?2
bVbBIfBA(d>JXHUA^c]+#&CGY3]b?:U9Y9R#I<Y&G7Y[+?TWNKJbd5[T](/OB2W9
3?EURELSMcM7Q6c3Q_M9ef^1K4/<&EBL-(64AgSUZLMf]T+#c0dC7A.ZO8NP[fHa
N+W0;PgLT<e-DLfMYM.JC\DAX6<^-?GC7.JD&eT323_U)b^)Yg-6eYI9ZYLBd1-J
_KD_1KZ?2DAd0:Z5>7Be[/dUV-[8(W/###/FbZ@UDQOf@ACJJGVf4V46cV97K8N4
IL@V.AO0^6Y((He8?^<EI]D3M^I,?7I1[aIVNZ@)d<Y?0\T-Pb3;L\6@_83B5bAQ
VgP1D,<A0SZ@U(HceB(V8+d33R-CN=:.0\1WXfHfJQ4?H#D(+c3^S0#S21g?d:R>
J:GLPE7SC/aZLOdT>G)7#P:aXd&C];[3S[U)-^<c7FMBO,]b@.94JKQ?5.2aFda4
49P?AF/-1UIC9RVI_=MTR[J;Db^?=U,0P<#Z-0\\b2NH[7>_]GY=T3S5O<0&P,UA
[EIY_[ZZEVEb\\<@09O^<FQV<7;CV7[fcQG[N?O8Aad4L2[@)U#g#U?6P5JKXJ>9
5LRZ9WWcIG#L2Z:DMZTe8c9TK7^R@Yf?BJY1+>13Y2;)S]Z9Jg0JTEPZ40@#D_J,
:XL06BTY_0?;.6S)L^/dOb-=\CQ77d&0H;DYR&JWZK]H^:fJM.1S\bcPELB^0F02
,5>GHX.LE.\b6,(17g),5R<K]U#IMSbcbPB(01.;,.PPKBKSOfWD_^+1(gc)GBQ_
K<g?Y]Q7/7M5S5Ze-VWaJN4VYKO0_<6)A@(MX9Q72A5(L-COM\V<BTe4ZX)N^G-,
?,C_F]>&afX,/g<^+LBMU_gS2Y/4a5IcT;.5IY#Z2/LMA.T/MY/UEIDR9We/3^(+
FW@W_3I])YK55(1&^^KcAINM-3;4F0FUQE@G(gUS@e8(H])[X\.6,LSMDN^A?<fg
_GcU40&XNSSM7\]E2a)Td#V044K-H_\.>GaDH^6:]E9H/^.UD<#6E5K6@dB5\9EO
9Radba_[JOAK&4GEH/,;?5bI\@.)J^a.feR4&)P@#[=0:W5=>3>8edgOGO5OW.8[
L;06M0D+[F<9=66GYU@-I\I5_b7<OcKgV8@NM2gE5/EK_a+PNMC]fF#0.YP-F@UD
KQIZa2W22:Na.6Vc3(OQe21TLd5a49gT]A(c^DK><cJ>ELfBZ\6FXaNIb/@WSWa6
<TeH,IeD0FJGTB,(5&dD@)SGZZg7f[QU2a5-_cMJJGe1g6d:L)P]TQ1;-We<Z8.L
4VfGJ/D&LDM,;.EI;GC]g#S?1bd.ICS1&gWfAL-SI-MG8YY-cG.4-SXI]>GCO7Mb
0M<+>AXEfRF80bccZ;+D-#]VccD=E&c?9ATBa7M[/X[XPEU4gMLI;gKZJ>.,<XJ3
@684R\8K0U5C32&TZV@V/]1S?)Q6_bb]:\6e((c7M]K5U;/b8/HNG.BN0)PK+>7>
0#9._+E=+SF+cf]SD8B-^g+D.56_,\=:79^?9Gb_>-+a5_)RKY:a-R@V1CcO&MAF
L2X?HMRP>-Z-f[;C>)CR[=VBU#U_g+-AAWN2^<f?eYTQZ/cO[2edF1<:?ZWQ5):K
,9J?N\QJW(1#[\N]8^MB0H[I#NZ>_T8-/[eSU&O#R;EgN8WW+ea,BXAV-OZ7g10A
.SQY1<P(EZ:13<2#L>_\=_9cIY=2<Q;3I<&CAR4?N_OU#8J+RA5COdKI#^4Z\c9Q
Gd2B1B?=G/NcUNgDebIffBMCf(]eXa>W)/I3^BN&Z-+=E>H(VA#KD_-(JZa(aMC=
WGH^.W9bf[>YFDZPDUE878g-SBVR>Ve9VY7@XMA,abX[01LF;3d>P&X0gM\GA8U0
B1[_M>N2G1>3LDA.8Nc6=e4^>(2gV;RJ7I5dBL((Af4S?FY:]e6@<c0f-28D&>VF
NL&[1C(d1W=@4[SFC@7,aV_PKPFfagK6Wc?2;9EL:eWW_:\&@)L.O9B0KAN0,Cf:
HWL?8(><5=X-B6:7/fOT?,ca1BR(d^dPO4cM^d.25)Kg@)TKU[OPfSY0>R&+N[XC
[@C.)Y/8&4,/58E5)KTbU,\<Q#9EN^2HVY:D^4=(XW@9ZFWZ3JO]<N1@D:?F^[^_
YcA_cc4^,2>C6=+GPB74A,0Jb0-):HZ_ZZ5:]_)IE<5E<PPT)9[N?^XC,NQ;T[B@
c4BIE0=TT5GVb,d;,E@GfOZ>4-5@Y40747D<9Ma7f;;f2(L/?M8FXACF021Y/U<S
eIF=/AGJc0&-,BgS;f&I=]28fW)WG@B[_3]Z9G-g&^321O;&)M9P)[.885R6)WHT
,B.;Rdb)O4RMIOMSM?)G/?/DfXQ0Z.^TfIM)W_E(NEYM@Zb&U5Gg(-(-0.<P#SeK
gfMI8XWNZE+?BI[OQ?4#0CI8EA7cg1_HYL\8S#<3B:YZ+c05+3@Z4<2C,H8H+9;A
^dNZ+a]E6N@U^OK#<9VCKMQSIZBXHFBF&>RT2KZP3@_Y#UJ4CR+5]Y3/-:4f@g(G
)\UTF<bEI6JbN\VY__cOAQ3.eGFXe>be)G4W1K.>=18NgP1328[X.?LNUJ3Yg>^Q
U6@[N?D@&2#W<<^_?H2Y=>4;/?]&JS[G34>5=L#a7/Lb?\6C:a7INS?_1Ig-MMIB
1=MP.-MGe^UREdW3aeFWR?;5)UQb(]L[T:O2?+bIN,AJB34f/gKCGN^A.P.@QS6>
=2RPe6NFH2^(K06#c(L5P5YJ42]/@IP(9W]\IGRR0R]#D/V7UKKbYJ\:8]T^cHS,
/M&1++e2.M1#T=)feCX.X&ZY6K^1Z#C;-NVA:7/)5+dYY+aP9;g4@4T)^P,\MO+f
K<I_-^&fS<3P/e:QF_=dQ#7>;]7Yf0@^Y_834UZW9dUG/aXG1D(JUCHY&C+[]6&7
RMB_U\3>O4]\TfC.D(\GA;^NC,)4#MNDK#JE5d5fDUC\N<&427[<TCT6,7I^B5f&
ZADIRLTO,>.GMRH\@>aB7_AI\FcXb@Z3QX92C0^3Ic0Q[)Z@YSCC+I#K)0R.2Xc5
EQW9>YCS86#PY4)Z3.00F6<-LOb)?L[<<+@PX&5;TIMG5&EFJg?(g=^OLCLV2(ZW
>:RH<D2fAdOI[^-Q#X_,7;).@0P-eZMH>U)24S;&,,.2<=<4gg)3a0RM#(ZT1VF1
CN,\+48P&DTWV23PcCZ,)4CN?U5TYC5BM/I:8XXYQOSeI4/-,&C168d5QMD=3.N+
>Edf@IY:c9:Q_QA>62Yg=6^>47W=>:<eM\1U+R\+C6^KLV_F-B4<8<?Y/9G).<&)
6,.T0H20OQY1@dP+8TTa1EUdfLLWg)2BK]Q-4b=QGL6R:\7[POMd^:S7YE8Bf<V(
TX?4cD)dT.0g+Y\O;EeBNM72Be/L5WTR4Y\3;0<P\@5^?3>^>f7EYP]1;d>aa@,d
MZYLR9U@]853Q##+_P-2XX_VY+Q5.DSH429\XZGRM&e/d:da4P69R)[;a#]L-VE+
:CN(S4+PIJQD4aS+MX+C^7A^1,2d])GW@GL;/S/<3](]&]MbDJ#0RD/=SF#,[/bY
G^(U1R5a35BUWFBOYVCf-?F33Fb3G=^TCH3/DgJ&I.-BP,>CO@ZgF2DU1R[LE#+b
[F5D7XXS0UH3H-fU&MVQ^K81)NTE^FN:<JCc?5E7c]&,DQOHa:YFG&KFZ0dUJT+@
W_)a0]Jb@?UQ@/K,R5=K0HBWKXL@UI&^>8BeKdS\<bXg=eQ;3gHW?BPXA8FU:O.g
=95e8:#.:@<P48&[LDHSK6YC=6cYG8@L>34>&[8bDW#7]I63gR<N)]P[UDO,8N;/
T#@;T>BYRJ_-Ue,-Q4O8,ga?T>L.-4aB\V3PbWK)a^:\Df11JT#[@8BZPCYcOgVF
Ve)A&2\T49BEgS2MM#QEbW]E,_XCdVSLZ^2S04CWg(Z(VU761D&I\S\GR>dD-9GZ
2C0]U94eB-\C/TLe12?J@4-02MQS&cVJ8_a7LeJg,CT@;49;\HT&CNVV>c\PIW#^
&M+38<^37>fITC-+6AKE,E.+=NM7TAf#&B3:S4()#VU_=2INX>=O-(-<H0Z#b_JW
FTRL=Vg[_Dc>0Q19)M3g^Z5H9)=NDA#=KeJ^)OW&UYA((>1P7:D&-Z-S^RfgGE.d
aY-/B,=KV,eS:T+RP<9-7Ida01N(?,]E64PEO8ALT9)HXeKNHDaO&^(?&A&7101X
2M_V6?EW<K/-g1a?,0@P/d/VTg]@UEMd5[UP;,DHU+b+4Y5U1;\EGUH76OdP,VAK
@0@5P;^#N4A)KPcDSRecUU,GZTCgW8/GRXSJ8]L/gM;6X#L#2:eGL;TZ[\Sc/;Qa
L\:-g5BP;;J:J<]>\TM;7X?Be.M>a#]]&_>bK?7#YL7;;N(V&(4[LgW8DQXWfP.+
cNW3?YG6MGaQU#O402UN+]f1++X_;238MfA/0-^WD_RQI;[&1,[US<&)CVR6,[(K
AA-[a=K:;N9b_I7Lb&V1_M7[8(-3&EK_(-\ce^NIR_X5=;d400fWCeHNg0/-M@[T
2W<dNaSL.^^@(O=UA^4+22PEZV+8X;e)Dbg,<[Z,JJ2Id9CKOG9#[7GNaPdc,](g
@Q+81U7FH,b)CT+.58_EAX4LY)bJ^40gAZZ+FGf6@KMYgC?Q8=eS;AA&AM7FEW#L
&)8IO+J+fF6EDP5O5N@^a^L[O7UH<NG9Jf1G)=AWV@D(aO<>D5b_SIEF982dH(c4
Z\/aK\W@R0XbKc61.T);,KO/YC0I=b)O7L6\e_Ng5?[<;:RPV4I[g_J62^\+7RZM
PeM0M:NP[<;Ff[>c3D186cVMQ;ZLe9-e[QP0;VA(Wf_HR?>6T;0Zac]@K;bF/DZ1
[K_b)DU@^>feN;;:c-?6YKQbOc3aI6K\[)5VRJ8,YMFd+KO89_&9M^1ON_X7Ha>(
J62Oa2ag+afMT2B6aVdFJbC5W:<0H6JGT4P1eXcJ[7WCP#3OFb:^c<fMZC2Ff:aI
0c8YY\HK6]9=[#a^^1^IUgaA]YTJLHJH:7K<B</5^..P=((@LR^Z9?PEE;7:SNMZ
LeC(9b3DMC9aHJ&FT0a&D:@Q<(?(/MK58+)VR;EG6/bUT;Pba7N<e0QdJS&Fa,ag
+;,Q-PZJTAHWN/</[VV)a2^4D])cBR/;</XK-aY;WfVEEJ(LEJ,2\7W4LW7E6:V;
)55BO?bYfE54T3#K]GdDP_/Pe@VLI<@M;fBaW0>C+X/4J:8.Gg&DS=HEVX+=PU-^
[d-[JI^T:[,eaG,YH)T&X-;f?]\=)86[Ra3g0R#EH\?g>PA)O.^D0<IINgHVf.5;
0+/.XFVW3Fa:FeXUB0b(P_gKUS4^8_YO(,20_N]92E&XTF&E#^>265+2=#BBd2&<
)#;KKZ2.59O]/c,\PCc<(GH(DGQKL/]^I+I4O[LW4.\GX1gME=2X..g,VT]8O\[>
:a<WXB<^FdV\HbC5&L[bJ7OYMJ86LDJ\R(Sf=0FT8Gb[0b>/)F<Df].dQ&&)7EJ>
efUT,bH2&1^GT&6(9FHPA:(,e#E0<&_O@[R1gBCOBV.<46be4H<&S6&ULP)Lg8HJ
&NX-.;-SbG+#)GXDXIZgeM>.F17I(&X[(>G:<;fPS2a.>JJb<:9?2Qg/J_WfIQM#
]=g6g5?3C>AK)?c4M^cgTRL=C3B&:(L43<^BfWXCW87P.]KI+8\P+BVd8aH_bQ/1
>/Mb^5ZgC^XH2fJHfc9VDRT64UHb#I<[/B_3<=V@]@AQTg2Ja_C<&H,BZ4X3+I/]
EX1D(RFb)&[\G9A]9<GK)@GBI,0:J&-M@&DI[I#;0F<.\F5MeD6-KJ821XRBVg-U
R^<B^SV3EH2A1YR,]JSG+#c3M.ZG#P5:=VH4J;B=,HGZM#RB]EU?a(U[d.:0bF#[
7W6VPUW9X#=YVLE]GO1Zc9GR)aMYDR5?<JcQ9c?D[&LG/38b[M>\eeW:TJ0D)A8N
\A:4d3/&Z9C4RK0?;O16]:a;@eZ8dfaS;^HYTZWI,/ESSHPa2NQ3XRI=QSIXCG4\
JG3)VYbaBID[e<5I-[P66UJ(5/J<+cEfD[aYM:Z?9_BPMEa?7<_;6c0:(d[P1CPQ
-[_9Q9-\R;ge[.4Kf[7,5YT)IIYgD7K):^g(efUU)7DGRP?>4K>=>bf,=9.O,D>7
.dE@0>#NAWZXbSX\VC[#&@?d^<VCBa:YO-6I<S6<6=g:M+6F<JT]MMX@\(.RRPE0
f+C3\bL412YVZcE<Q6VK3bedXdJaW\C69O@D3O_GFW?RGYY/4_LBM)#C86O>FS]c
gJ33T4^D?5EW1OF(dQZ_(+D>#1IAQN>^BS(+EeKV)4/NeSNG1@Bg+(_IKNS\YOfO
7TIJ&4JB>N3J]EW#@fK=a)7^10eQP[?+1,2.IXJFa3]S5N,=[+\3cVVeZ]OVS,>D
.BABDI;P97-)^IAH@9AMc6g<(H?)^PdXJI:K:)K.c8e)D7W90VUKXE&90O;LUgW^
)RfKU;3?D@6.JffgF;:;L6fg,S)0FN9NY7#Y@;C#L]G<V7(]DL&H.:++X1N/:PWT
2T6T9S\_gSUB+U?1F0fKTB[L6[e:R.5/1.9\<>b;a[0NFP6d-K1ECSa)8=J_(VdP
</)301>/dB^XZ\/BJA4],=0dfCO[Eg?=H8F^0;bP-3TgNL=)1O7Nc?DdN[#0aE;D
H(K@7/)G>gcJ/A/ED7Y6Pg>^?-6.FM4<ZAYGR.>e0^U6\QbPP;@MEBb95SPDV\=)
.QQ#:D:1^Ig7FUTRg]98UZd)G9#MdLXN#@cE(OL8QC]HYB/9ZFg1H\dXN=YAQ9I7
:eJ2L;+3WLd2,5A;7\.P^ZKC.1/fII;aB/5-#c+H0a^LgPdO,OW9&OG>/1>[;P[C
8)1+Y9c2He),N,2KeWV&PDbOLJ5;Yd+02@(2DP\HA5,K9gQU3KXYfBS5Ob=M)6Qb
)K+MH<#+#O?L4KJ(1+BK^4(LV/?[#df1])CB]TZU.P;<7]99M26Qb36_@0;GA?)[
S)5cdT?_/D.#_P?>234XAMJS&OI7?ZRC_C^:fL.6A^;@e=Vd:)Y#B)2X-O.&3&8X
L6T&APST?)W>F9@aQX.fE?8=QQ\Z?_]V_+SW1@Z[@=--R?];&U_X)?aR#AVd:+g@
HNHbaRgQD&X4F,a3B--L)3Gc+VgBIe[e=EMN)LcB<L]5)2[BfL_[]-bW.fR2Kg>O
FeVWGU_Z/WS_UVD[W=EZE&BDSVDAaV<HW6XF.-6IbR4Vf-f)CEX58eZU^YX99a?N
\2<&dN5>@#KgcXR6YYHYF&L1,JZgH6^)&b6?:Gg3(KYD]\FZNOC4_a(BS^He7<0K
R&PY61PNGK(\[A[A&K)1V<L18$
`endprotected


`endif // GUARD_SVT_GPIO_TRANSACTION_SV
