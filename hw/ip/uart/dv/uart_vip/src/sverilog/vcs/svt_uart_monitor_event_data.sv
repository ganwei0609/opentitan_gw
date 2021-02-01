
`ifndef GUARD_SVT_UART_MONITOR_EVENT_DATA_SV
`define GUARD_SVT_UART_MONITOR_EVENT_DATA_SV

/** @cond PRIVATE */
class svt_uart_monitor_event_data extends `SVT_DATA_TYPE;

  
   //----------------------------------------------------------------------------
   /**
    * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
    * values to the parent class.
    *
    * @param name Instance name of the transaction
    */
   extern function new (string name = "svt_uart_monitor_event_data");
   

  `svt_data_member_begin(svt_uart_monitor_event_data)
  `svt_data_member_end(svt_uart_monitor_event_data)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

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
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

    
endclass
/** @endcond */

  // =============================================================================

`protected
R=_^W22+5AN\@T9;VYSC[Q3+DS8?)MY9S+K(J6E#F/VMIP[2MG4e3)PG_YA355)=
S<gd.Q_427e+[aMDb:8[W[2JZMG<QJbXcO]VUL]4]0W/dfLa5QOTc&U,WPNaAcAe
9P:)66Ef-)\ZUbA_-/(.<d1I)CC)H;11O]O3>.LJ\bebf))<9JH4\JZ_MaKDVUAJ
1^]NG_[#Y&55dUcCNUQ.6GC)=&AD/;T.LS@7(=:_AVOa:PBCM;B_T9e-5FIYLEa3
9(OT:6-.(\R](Y^/NDMV=I1ZQ5X9MJe:_)IB_J.Q).?e/^];G:d94/.M58bD@cD_
,2@MIWJ2MLf2QBJf2(Xe@M(CaccU@IP/_<0d92.Q/4>G8aEa8C&Wee+DV._(5fEX
H/?+4(^^9I.9:V:8_fI.H^;0c@Kg\)7&UR<NKceIE]+#Nb73O/)KN@GgRL+Lb;)9
cdc&ef\?&UA+d1:N@NFOQZ_.D2N3c]W[+468/FCZ9e1e\2Tf\bfJ/:\(-Ta@_?I&
J_V_af;7D^4f)XY##Y\-cFg3BM].SR(>9DT[QXeU2THKN)B3E3)GI[bK;-VXL=&&
WM08&HU0W/+F5WS,I&H3O+&]b>U+N>-5OS/?Lff>Z;\?HdR=0<=J^+?]bCRU-H/_
R^+adF1LQ?6:S@2Nb1I>b=[3Dg^J)=O?ZZI^CGM60?CC,=C]OS@f[COTHc:X;\&M
4eC(Je+&N3-8:SX;S,gZQ[O=&RN><:&36=X^I5G+1T0>NVDbdI7^[WC3JB>Q]E2H
5:YG4_,@L#.<OM7dZ&<GI/6X_USJ2IWA53Y0]#;^/c:#_H4&].)BATf/FY/W,_Q)
&)>3a\(_4FS\B;1<L,MKH>>TF@YDW5?7cS0KdIZ3E?NT)<[]b>9PXZ3[e)fD5B+>
QA&WZY_1EJ4T1BXbL/-+5^5-Q^30[3N^e[7d+>cf7[DO;^0,/5,]]QPT->>7]+C>
]\f0J11cK2RDf=G[EgL7,0^QCK<+<//T\N?\(_0LD/;\;/8gFZ@g->35@RXcNG\0
WU/=EbV5[QRK\7LHT(eU.2a@Xa@VIB&:/^M>?KJXFc&d0YW,0+9a<g<gg1PR08RH
Y^#f5^:0H/)G8+MC)M8GH[A/3@Sf]d<Y69,VA37F>[IBPGU0S^A0AeDLA8Y:Me<F
1;5D4(+X[_6GC?f.f\Y[@5NC@MCbFX(C)S3f#gJc]:_&Ogb6cUb;)U4N5>FT&GCZ
?d5E8G)5+U1,d,Y+-=K83IF6JQSXXE#9Q++d9+1\dJKg52GTaNaTHN@<BB3dRPD4
/N.A[X?(;,?NZ+NbXO68]I[/U?/TF)UVT+:LN6S,-E2a>+9c3?(.KK<?E1^XJbL(
2XFN/ZF_]T]4VE7]UU//)<S>6M>>_^LT@[6IXS>WIBQ,#U-.FKBd.:-f]#K]MNYb
>Y,IP:B(1>Rb,Q8,<G:C1+JcF#K6QW91F56O]\T=Q1c3cF(/df>=BATa#e[?/H1#
,A6KT@93+b;V^JAZ9Y+,UZ@(^A?UE=;g46\b^\@]I0ZBE.eK1g.8&+I0?K^XXF41
d^QAQXKIU\DU]C_4J2DZ6RdVP0aIaYFd+TSMC3&Z/@]<c8.[3N9Q._C&^R,;A:4&
=96C]-dT4MZIUDNJKJ,DI_J,6)2]gFDW@Q<EgKO&=Y6U[XGDAH)aaZ_)DMD9e^<_
];(4FE#dRHB7PcbYHZUEcJ6-NQSE3WO\./K>M<\04,>YIQW&D:D#L^b0=AWJ0.@,
f?@+&b@&I-V#XH_;ZQUG:)81L)4Q>DGgDZg#.H2>g.BSd>DcAAE:ZHJe<WW@&ff@
gS<4T3VS=:cX0GZF7g.O+46OLdeG>9#AgGe=ZcT)JR#e73+Y(0aRd+DOQ]EBE/X=
;Ua)<59_D_EBdJc4)L>YD#HfAZK<4Q15UH#Z0&EES3FG\1,ZYT&49]#7Jf.UXDW#
=NNWK8JNe;Xb6YO1#IG-)FgT_=dN-_eQTa5TVa&\:DD8[GNP/-#QP6LY;JNfbUN5
ce^>PLgVW?_EP/-4^4CL]T.[ODPBA;89C8S6D278MJ\B6?YRE(MPY)^f@ON#H?V&
FL\(Jd[^XQUfA3<L5G58.V@-68Q.ULF>;KF4^MQQb>/Z2RAH(PZJ2+@./,HUYYE7
AB@NgK6\LaS&39?bVe3c];2<Q&0?6W3K.XP@V.EB<XF;Yb8bHBHAGQ/O;+36BKfL
cRHHNAcd+]#1#0^,<FDefVOH-5?K==)I1WSDNX/NL1]BB_>HVR>OHGS+P>SL=9dQ
7B4>P;fRIL;X:7;fK:W>78L+\ff.KOZ6OO8>(JJ5QKK;9G;?/IfR/\ADE7+KQ&K,
Eg@6/VIHQT(WbD[1)3<Y^#L0J5&T1<b,@X/<Y+D4DFRKTQX+c+0E<2I.?gZ.6(,d
-/)9_#0E3.WYV7\(NfD6gJS,?ff]8c@+=.G4H)513=^f[4Oee&T2-A(eS99E41T9
<RAG@RCYSOF<.4-QBQ;PCJRU8G(5[MXcSf\XZ6Q,[]Hf1U=\;;TH7C4Y_^K>+S_4
@1)E?OVbeYPC#O)F\Ad1B_d,&+5dc0O/<=(f5dI1;&E,\,?_)4VNC?#DP[NAJaGe
MIG89PP^:O073[_&a_VJZ94aS8/8/Fbf3SPJO_FFg+1V.20F[C_PVa6[E6Z0#4/S
:&ZJ45-0?AN4OY2\g.\IIcIF689]XKUDR>>5J=>G@c6db;(dU;_N+[;E+CMY>FUC
JAZ#\RLIRCfM0X4N39(YCb:cA[4Gd@TIUGJR<P>;gITN2@ZWBP&6+eTMZ]]E?HZ]
0P4XNCM&0&S_-_8+OT-;7M=V)6]g^Tc^gcN^<RA]QK/,]Y>PAXeJ4EG2@995S7])
)KU?;8/gR#:>:C00>-T.)]Y@>/K7;<ab&ZE#,Z[,>gFAaC>aCB#I;X.3fZaCH?J<
1@dFADOc.FD^\,?L)2AS(a=[G3egL2?85/95@bNFJY[KNM,U0M-Nf+.27R^FQC<^
I^2P\0c1f&;^H=9N#Dc-TZ4F-;3X?.N:I@WHf#TL(YUBda.,gP^cB^IHg#558/Q(
EUcY2],;WNG-e5TR.,YD:2X:1]T[T5N;KSNGKV[fdUKT#KAc@dK?6Z:;P@R^K\\(
Oe;dG2M98ReAPN@V1dEDDa^fb2\\.+^c+CO=cdOR?Wf=<9_]eTOD:ZX40_PX6MDd
59\>YRcWVT@2(NgPIYd56M7@.UfKFGSgJ?W[_I]UbT[/JND<R^#?S3JP)ZdC.>L<
d(bQLT0+\fZa<NS#Q#[3g?XXYC88>d8gbd1@>g/Yf5E,C2WI>,Ie6QI5LOP19<0A
Y6K6gf:85B0P.INcT/SJCW-Y]O&JYc2[BP@1a4,7C<1IRN#)ZP5:X#6V(8I<fS;<
VDg0cdRY>4DA:D250^W/LWA[/[T&F(ZR9<@NM5)DUTf6^d08T<K]F7CBK]_8-;..
7\d1.0GR4EF@/83NdW1(2G;6cPMU(cJ+O3N4O(-c299_+&&fA#D+eQf&@,R9A=IA
Q]WeQDg(</^]RQ;,6J/8afD]_\)(P]8;?058R.?@aEEd(\aP.eSd2EDbVb&Jd68V
Y[JK484C;?UPD&J&OXSg9cB\IZMMA,AMW^)L#:.&;1KKO036JH4(CaZJ83,5D2^@
Zf^c(4JKGD83<8SU._97>RW;@agL+9G_&^8\Ag+C?aVKdNB>eeN#gR4;Ag2(5R/1
3:1a^dODY)A][TOR6Q9U<9.D4248[HMRUKW.#D_]NNd-2@_/#XX/C:XfEK>eQO3+
1e9VY=fQ3K@c-JA4G<^ETW+e1V7>A+=5?(d6&b4PO)_<@\8(P+FTc#\HQTO,(;V<
P(T@gPLK<=(G)6#&LDLZL;\X+W@V0V31E5QY2,K20>YG[JW:E/d_X&95RLF_O/IY
e;7<.FJYc+2aWC91W98N51@QBV0Y1_+0+A(7GMKcc0W9E/.#H?P4(&\U<>d25fdO
6&H9N7fV<VO[NFYT14Q+>)#W1dU<N31:ZHHbOBeDC72c7:8808Cg7RQ3);\XcLcG
b70LR_N?\8_RX&YP)AZeFNT@:0E-/f(+1:TU8H)J\VPgOKWV4DIHLQ3?[,62XZT_
0LP+bQgH_TGd[P9TA.S9fIHeXL+BZ+Y35O_#5D)2OUe<&-F,1+;a?8L?PXP(;ZF6
800Kc?9.@Xb#fF2L:8dA,E_YV@3]VHQFA6;VTD2Vb?\:Be]#R3_]N;FRIB?f9YCX
9Id\->=A.;[^:]L9D^X5T--Zc)B^;9R(3)f6D>:Z:QW])(0B[bJFONQ>8TV:=Xa/
HUSd&]-MYf8G:W.K,@;74e69^@bW4)GGZ8d]c411R3;@I.c;H[0K?7Q>L$
`endprotected


`endif //  `ifndef GUARD_SVT_UART_MONITOR_EVENT_DATA_SV
   
   
