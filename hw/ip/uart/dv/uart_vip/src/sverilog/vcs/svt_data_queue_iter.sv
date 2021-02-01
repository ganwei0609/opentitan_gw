//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_QUEUE_ITER_SV
`define GUARD_SVT_DATA_QUEUE_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_QUEUE_TYPE svt_data_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_data_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_notify
 `define SVT_DATA_QUEUE_ITER_NOTIFY notify
`else
 `define SVT_DATA_QUEUE_TYPE svt_sequence_item_base_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_sequence_item_base_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_event_pool
 `define SVT_DATA_QUEUE_ITER_NOTIFY event_pool
`endif

// =============================================================================
/**
 * Container class used to enable queue sharing between iterators.
 */
class `SVT_DATA_QUEUE_TYPE;

  `SVT_DATA_TYPE data[$];

  function int size(); size = data.size(); endfunction
  function void push_back(`SVT_DATA_TYPE new_data); data.push_back(new_data); endfunction

endclass

// =============================================================================
/**
 * Iterators that can be used to iterate over a queue of `SVT_DATA_TYPE instances. This
 * iterator actually includes the queue of objects to be iterated on in addition
 * to the iterator.
 */
class `SVT_DATA_QUEUE_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration indicates the type of queue change that has occurred and
   * that must be accounted for.
   */
  typedef enum {
    FRONT_ADD,      /**< Indicates data instances were added to the front */
    FRONT_DELETE,   /**< Indicates data instances were deleted from the front */
    BACK_ADD,       /**< Indicates data instances were added to the back */
    BACK_DELETE     /**< Indicates data instances were deleted from the back */
  } change_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The queue the iterator is scanning. */
  `SVT_DATA_QUEUE_TYPE                  iter_q;

  /** Event triggered when the Queue is changed. */
`ifdef SVT_VMM_TECHNOLOGY
  int EVENT_Q_CHANGED;
`else
  `SVT_XVM(event) EVENT_Q_CHANGED;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance that can be shared between iterators. */
  protected `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE            `SVT_DATA_QUEUE_ITER_NOTIFY;

  /** Current iterator position. */
  protected int                   curr_ix = -1;

  /** Current data instance, used to re-align if there is a change to the queue. */
  protected `SVT_DATA_TYPE              curr_data = null;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_QUEUE_ITER_TYPE class.
   *
   * @param iter_q The queue to be scanned.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY instance used to indicate events such as EVENT_Q_CHANGED.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, vmm_log log = null);
`else
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator. The client must use copy to create
   * a duplicate iterator working on the same information initialized to the
   * same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE allocate();

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  extern virtual function bit first();

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  extern virtual function bit is_ok();

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  extern virtual function bit next();

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_q Queue containing the `SVT_DATA_TYPE instances to be
   * iterated upon.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   *
   * @param curr_ix This positions the top level iterator at this index.
   */
  extern virtual function void initialize(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, int curr_ix = -1);

  // ---------------------------------------------------------------------------
  /**
   * Initializes the `SVT_DATA_QUEUE_ITER_NOTIFY using the provided instance, or creates a new one
   * if possible.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   */
  extern virtual function void initialize_notify(`SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null);

  // ---------------------------------------------------------------------------
  /**
   * Called when the queue changes so the iterator can re-align itself
   * and see if any waits can now proceed.
   *
   * @param change_type The type of queue change which occurred.
   */
  extern virtual function void queue_changed(change_type_enum change_type = BACK_ADD);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
g)OLLH5KJf8Z/cE4N5I2+d@D]HRZF_YAcKS:+?@^XPNXecb;49V&((5F1OBg,Y=>
0NeTX^E4Y1>\S?21adG&dMQOVC]4d:)gX/+RJ0bf;6_;@(0W50[@7<X,V7/IO<OT
B?6(W/=#]Dg(Ub>R+;T@O[U-;HDI;Y+DdT\_O6A9JEK,M_,:BRa)H,2Y0FFWWT]6
1+3Q=W(+84TT(_4:D)-]/XeQOP+0#@g^#>0aCfITFgC#QI,5Z>4gQLd8AR9g&f\Z
FW7/_DMPe/6Tb<<+6e9WRUE8=(.e57B&Md()GLZ3SVZAGNNe7(.;]W+@//1Ca0TG
Gd7f0(^R=7-H_^da<=&/L1aWP?-f7f?O@)XSV<7IKg/F/a,#;VDM[504RZ@)+ZY:
=A\5V-:-SgbKf@Q/4,W27cBSJ3UT@ReDbO25Y71WL5&MXgc\Z1>A_XS583E.e]SA
S;=ZeQMZSN^X43gNUL^9Rf>fVW1M:ZL3#]d7aK2\B0G2Jd8^X6@a4BfQV/KF9bHX
>d4HQCcb)-/)SN(-MdD]9NPM0E[2KPD@1DKZ;e7a]7;\B,0f61DNO6XR:[<dEg.,
BYYgY(CNH8S)U7XE9.BX]WY6d5]8^Ga7#GNOOe_.K\,ZH#]):,:4]<Ie-b?HV/cG
?)0X9EM8&R<8+@8a-50@Q9D(C]<&^,+-JP+/cDZ(OVF8/&H1C[_G3U0MQ#2d2./K
,B_L=MXKP1B9I:[2P@][\H(#-N:VLGNX8+bZ6bLXD)WYF77RZ3fHdVZb1HN1fdI8
-E&_U_?c69)+,N46=_NQYNbK?9aCg)>>Da_?JY-;De\3:fTdO4,-DX2g1)SFFU?Z
:.]D06[:ZdX/GKa?2&HV4T1KY0,7(WC60@)XgA)L]4d&12F6C7MH:>^Mb?W1[QWO
OR;F_\QF_90Ugc4O\N@O0<9g>/[a2^GBE\;L7_:F:?]-SDaN[Ka&&2E90CHO6)&-
ZRQ_4FgG\?5JEO8<^cW:+bQQRa:D43bcbVZC\?[7V[4[T#Bb9RB/2ZLHc?-]8IP1
@\R8((84&>EILHc5_&:PA@U[#5_bDJ@[\]Z32O7;M&0a4)1GLDP\8:XL)g[d4)a)
>F7>+;9WEcJX_da#Cc.#O(W5UB:KDg>_A_TLTS(2Q#Da^#.(PJZ>6]1O+VK\?)PQ
\X7-Z)U=4OQ=.U./EOI=5.LAXTT9L0<@;A,FQUbgOQRMOUO)bT0WQW]#(([1V1Bc
G7MP-5,Nb>-;:5XN(+.OXGC4)3ZGC\G8APRIc0XAQKGRKQUR81T+B8>T.;-Y1HQH
cL#T^f8,VQS]+87AX[UeL8=JRSPQ3T]L+;df\)&=J7CZe8UUYXX[;D46:@-[-EV5
HL@XG9>BGZg_.<ZNF.EB<6VH;f^BCF_ac=HTT^;H>-dS\Cb;?f&?d0ZU3HG<8==G
+KZE<KKN,]-5ZM0Ncd08E-7aOA\+,NI@>E1>H&@)faU:VG3VL26#F3BBAF+09eWM
eX0g0M.Y33c1_@P:Y?&bOD)c2Y5PXV6bWME+^LH^#(Sa\J2/8efWPL7+EfA),6&-
Z_b8Z:G=O)@RCMB)4H-N^bOS5:L46O@fK>BG3JO[/f;?P@V\MfZR]TD<T7-FY&85
[Z0<@b9)A^P27TLJ1B8U<bXc_W@F980g.^^26GYaAUgVN[E[&.a_eS];SV&gWG&W
_141c6@:S&[bVL^^YD7)S0K&,P2\/-a1GJ?#Jd/Ta(FI=M\SU,LR5U[-@?&2-F@c
-DaC?(^@g5M(0bHaY\O&ZCDa5OG]-a42FV1/_=K>VR._2VRXWVF#8TN=,4f/3YSZ
7\UBO:YF4//ANBN=7Kb)A8CeIe-(E[VTUg.9(XN@QfK6^8KT4#Q6MI2b\VVTZc@,
Cg,559XATFU1e(86773.KY_dgd:RLc2>Z5=cH#QM#D12F)fCGAdL0GTbfJ=P.MgD
g#+J29QF;Q(L>9P>_fLX/MF@&IVe(VcPI@:B)cfR<98/T0>F#NJ7)gBd#]33#GbI
;9SSTS:3<1Fg>G-^/QS-D=Gb.4:]0AW<d=-?9.080-\TGFIB?0<R7H6A&X^.ee]g
9U\3+05>NQN,^&ab/3XDI(5Z<0)#VY:^e8@1NbHT@Qb<2)8M(/6MY\<BDRcT=MNE
SE4XR&>e6V8<Of[TR&],9Q]=&/1Z380?+&L_6_IZE5?-7ZPYPK#VZ<#Q5Q66TD@C
MWO+YGXM.)VH2&I7EU=/H&((K[>0e7#4_M-T4\DZQTB1GH#Y&:.gSaBVXZQ.#H9N
A@e/ZBO9F+d+;S1\0X48:Wg2KNg^4La=>5BQK1/@e4P8.&I>CRE;[[<f@;75;K.#
:J\]\JK8f\;73P1^_V4J/4@H8bV@cM=eR0L0)D@eY.3-47dg,MUN:^f0PLA7ZO<I
MV@9d5dJ2LB/Oa3+dHX;ZUdWCDSY2b>TEa-WS)KCZRX;R-g>gVW2eT)=4P-9YU-2
4HHBU9N-eJ)fCU<GRc_[?Dc-(^06dV#Fa0X>EY34V=^^K59RNH)[NY^H]SMYR>CR
WBJ:#-IA>D8^G@,//d(Z)O@Gd+Xb83LUc/:4c._cE3PXeYO3CeA+Y>^RM5OJ4<dT
fRg)2])@:0U[31=<f@)MaE_bXU-ZER\TI=I&\CD98Q\1g]eSgFZefT6.??Q\9_c8
]+M&L]3I089RNQO8FY4XfX:A0S#;&R/dQW2-R\:f33P;FV#WFI6KdD@]U_G=D/Mf
1_KfL-@bY-&C&&EB0X^efM:BQ>:=T:_<B5dH+^J9HdD)23P=(^P>2T57GM8+5XbH
3N2<+T)FX,4]YNc,dbc6M.;Y.[@[C^7#@0(:@d+./A/9NPFe#1OH#_a,8X43T4;.
T\9=8E=eLd0Q.U21ODQP:FaWOE?f)?6M?-]/e@OeODL:Cc=7=;[ZVaU_POV)O>WM
Wa&dC[BXF6@@L#K<9>G12>,WIAKXH)bJMG#<&Q?Xc/.K.-)NDWVP2R0ebYMLF_>a
g(;P7@0&RH>=YV]@4C9VXeGg?0L>_\dRg;c-a)#+UEb[D#XcP+EKRM+/UB2>5+)]
DH5d_5PYFB[,S>Lf<WJd6M#R@ZZSXS-HOM;6+XP];-E8f?aB8,^3.TYEF5JIAN<]
2eJR.RW2^2:Z#Hc^TYYM@[O#IS8gL@-eeCUN98F2NQDA+)e]5BIY>J1&Z>-JC?(J
,I?)_-,ITfCUP0Dg8ee59UU=6<GC9ZDQ86e#_8?eT/+\XLX^UGK(?dBbX@^I<?\=
Fa&A&@&?-b&TDI9+J>A6eX;(P>\017T4)+XZBK^@FC\BaZWJ7GV/NZ@A>2\=-\g>
<(GXB<N(\GQPeWTL-dV]Uee<[^[SS^[K,N=?b;:NO=2S>WYCbD)[[>]WS^597M^2
@8H^S+=J+M\)9WQ\[_96>fD@^B)JC00P5,[#KY,N#A/TR9.:f/9J-J7PDR6W/ge9
Z@3F:eGW-+,;=<LN^^I,aCIJ-7OH7G2N7W]0]OE3Y):=<g48^-U/:FI\?]/2<ZE#
efAR;<G?(a[#.dTC^CD?FK#dMV\[];MPCU488Kf9d+.bQ4aUHVRb2K2HX&3,;^gZ
W&50+,&e0_3B:8G)V>eS9TFEONc\:OU_2=aJ+:741D1aLGUJ:7Yd;4D:UAUTSSMc
,;[-;M@5IUPeRFOZ;-U;@VP8DSVU+7<4\[27RV_A5CNeYL-LAg/We26M#;?3L&8U
b8)A&(eNF:4N]]3L1=ZbDDc>]Z.KY:(7\&]W(PBI-YX-GHXI:J.HY^B[_0>#f^B]
4M/]A;5TR,(?DcJdC[NH3R>8,<]dU>[0c9W)PQc?U9USVbAS;[ba<5/Icd[S7McD
P,B9+4,e?+CAA2OUf3E))^#Pc_<Q;G-F0(F153(6&aAP?:Q@e>/8/aP[eO\adegM
dNXPS\eB(NS#G7c>==@^[O6ABZ9,QeR&cC9=_MH=].)X6#IVJKZ,I#H]:HEYDWS6
d[YfD?R5;e(M+L+MTDLUG^2\&I-Z9TKg7G3/Re,C]/\g_5(&c(V[QQ;PD10]R.^-
P1(X-]LOgaO=G;a#&;T.g?bCg<SU8#Nf3?:Jf8P&&L=c#c##6#Yb>A^)I48(3@\d
_==-2?5K__3F]M=9f[eB/JZfbNF[g5=e(fJYED&_U+<,80aAH\Hd1A.YPM64=Q-I
Tg\=JEY8U^L[[Y?E2K3&9-;4dV<7B&8W\EL8Z1[cD4GONX9.A-NY_N@D6f:U2O6,
/0+J:RGbC0Da0^gAK?WK@F(J::LIZYFPK:T09&>1?SB:+@NddP(:9+;-WS.HEH:1
d74NXeN=KL7&gNV)R_WNf=/5I<>a&AQI<c.Z?AC20+1W<==G[QbO<4YUFWX;eG/C
P\FfZLHLJ);-I-M91G92A0N:^W)L&SP1ASG:9]bSAFZ?0Ef(4&]QVU)f)S:]B9:3
cPHaGQ97TNILIRb,)eSgILg0JGXGe->8D.YC<>>_9#>a_7,?P+Ae[QQ=K;[<O_7N
I40de#DTS+7KdCW]=d#H4=K)[caG5P.1AeUQK?XX\aHYRbd+W<D@89+D+Z&8=,VX
,2Xa8f=Q7bU+Q,^7f#74Y0]LWYS#J,CGG4NMQNP&[8162,YK;,4#Pe4K__Mb.EEd
d?>3P6&]e:V[.RVDXAUg\;O[.=W:U44R)Z(Oa,4:.^UcK,A,d+:6R1_0KEB.9dV4
:g2W=<2Pb:2\B7,OB(2==A:X-:<AK(V/#H(CBE?X<J]CV3V5??S@cc48CJ_CF0da
YO-^cQ=W)KXc(1e@_,fT]H4_#9.W&;[^S&;GRY4;I0LU+C.,A1,+MPT:?.LXZ[_F
7;^X_ZJNOS(7\^1Z.S3,QPKCPNg\/:&afe7)H?DW[T9K[cDf3QAC\.71]bf71QC6
V0Bf+G(W1Y:M6Y)D\LYNbI1]POW)PdGd0d\+geYAdbN2gW\3+/S)3;1UF:07&4T4
dS[?[3Of2\YJO=[TCed/ddC:BJaA/9&_0YGYU?YGU7^GBT/79/&8IY(6V0K7Z<XO
Q3Pe37R<g5R3ZK#=\1\G&Rg^?SN+EDH9&N\c/WFV>TNAAPUGZ4;GX2>N.(ZA]4R,
-GBKM2#g2+WB9LT[f8<UI^^?YNS(62:Gd-.L:Z&Q;9\&J7_FSELgV4d6N>Z3:E)e
6-K9?61D_>S<VcY_V3Mfb]3NBWJU7[#AYEMRX:(E+&@7Q3^,KEG+),:KEMA?b>3_
8b7&(MOFPC7.MKf#4@P],;=7]aG0:PIgbSI?6=IUXYEX/EaVV\]W6E,)0]8Ve5@D
M8_^N=48M8.92<EC<V:3f_M[+NUT0&]dOJGY;XFHC<X;Z]FF:-1<LY^a:GB:c(RQ
Na4>_R@@;bWY.<82=cf-X#.0SJM+7(-K0ZdL@WATYc<#,Q>?\J3QO&H9Z/5PDEP8
_+5WYN;.DO2LD6^=+M::Z91I_cL5N8V]4^fb&CS?28P?DT>aR2F(Y[Y/68D^8&0f
Q_]@(N?+)]A[-4U?CS<dYPE;O-##999e/\T5F<E;[&+5)A@ZD3WX:6_)6dLDRD,O
3a\g7MBCd4Yd.+16aZ8eGANXVA/U#E&[^aVU28]9e18LP:N<Q0(-T^#;)-.W6H0O
d<>AcHd\fFNNCLC;]KI[/O(_^0GHab.I+@:WVg?^M6SXdJM^,_DOH_)g=RDM3R[4
P#0O^FH[4<OZ#<99Z+&X^6I^6-G\XC1,c>ZRZ01=C<GA.]?3G<:/WN],1SaE3,@R
HH0D(^RF@O_N)Qbae8a?F,>RI3Se1LT0a_J]bbUXA=^AaF_=Z,(0N0NV,M747R9+
)OIgB-1JR(N^[IGA4L&)^BX.N+8J;(3.VLPeE1H7A4^D^;,J0<b\^97&,5b-V0Z?
NfBRD:UXFVUbSCB(efJ:1J<F;aO7N6J<@H31I89ULMA/Hf:5d;.d,#@)C,65(2eM
/_:FV97-RX,85?<Q\<d>7HUaO/9Dc.aLS>3\P(:)Ud48>PMLE=RMT04:f3#8/.#S
)JJRbPbI3XYf--T-ee/[&c^Z,ZaO@2QTdW#KgY&YAVN?33FE3&CX)S)34>T1Vd?+
=H8JFU_RGd<5O4MD6T)UOc<2+9BfVHZI;;A4=3(?]GL2]e8#Aae3&^BNc;&c<UTP
e+M&]<7M/<eJ#()9SE=2AMYM2[:0D(MO27>GS<CKTdO\K?DOf628Ha,>W>:O56Hb
RE->IF:0PZ3SLQW4La[TX-VPf7R&]@BM[9PRUGe\fVD//4,d0@3)C(O65XVI>K#F
O#dPMEV#?(?R::d?A_C9Y/T9U9?8CU>@NHfZ377NOKR7[fTP9)?/D.C..7L7CeRX
MWcdfIeP,RaJZ:+[^W\4)I=[f<b<+9]MRD4.EN6QgJD8A-@99c2.750S-?S&[&=0
L@;#2Bc7;96HKX>>IVaTDeg1TK-I?RcT([K==[PRHVb3T.0K4)(6UcP6Z::S[:_.
cM^Z)fO6XYSRcfd;0>fR[OeC-V:T()J>GRSW\.HQX7D<X?#T&16WQ?KRR3+\E?9W
P+3Rc4U1f[BJG0GWO2fHMJ[S#.?JB8Z09gcKe]5a2=.5KC-3([VUaB+VHZMXf\G/
F^2\^eYT@QbP1?[A,=:aXTb[6WZOPTT/\9P?N?Q.88G-Mc3bZVBI/XcX&/EXM,H-
SSHG;\@63aJ?1L_8F_.>_\)R5f,7ZS&/+N?F]Oc][(K>A0VVJaYdMfJ8=>_-5.IC
2^>+DgFLKT>5M:)9:YO@XDgL#8</>S<LX8-?f?40WX=.cD6gB;Z7ZY_Z]^H59Va,
Jb8_[?B#)Jd@H3f15BQBOL)(?\:.YKIH(cg7NUS.?T09K(UH&VY7+HeYU3BL&RP7
a_HVIF\KIMY:OgX\)LYVZ\]8-5:JZ#NUYG]5C+f4(Gfab^DSA)Y&M,\VEUe9+EJN
+KC=846/=Bg2a9B\9,-d==cX932WcC5AZ8dIPJ#Le:7O&FL+f^Q^&R=AHWK;+(AU
B_:NgBd.VCIC-O85,CBa,46T^2C3]-]+E^Ga;Y?b?eL2gGLfA2AQM#JKNL9@(;,A
I?@A8SRB./+05-.>2^LEDAHMG9aH]9OWcB4)@=<21853#AAZc]+^1;WO4.)c5>/V
M[_\7>_];Ag248HG]?e6\>bGS?;#S)ERASFWTS8;HfDGALR41+2?O/@&_T0d4+Vf
76fbH.f7?XOK0ITR,a,T-#R2J[273R12_^HOM9,LHIGC;(gH3^WF)59X&MO=@MK(
eO]9DQ]NOWIWDD01>EG>H7GL)H0&.6519/],5VYFb(4_>T8a99_8gf#ab\4[RT:O
G-ID/[#K8Q/Bc#IA6E#UM&RfW9T2D2/7>2+5(]8JW5Wc0SD>WQ<_6=/MY>3HQOR0
:#2_X8_?#3#L9E0H=?)Tb^>c04JHOFaM.2;=V9-27(d:g:V.+D&fbZINgcQ,d:2D
OB\A)26&^;8Q,fUTGVaL;@9KDa)e.CeTGHIT,/dSUg1Xg;1\0062Eb<92-7[(7fZ
[d(5QgSH8;\,-[OVN;bRI.P9aedKAP)WcDYL&RA/?f]6VLe52:e83>d=e>AMS6dg
-Pc3afG;FPT(W2=ZCaP\H^3dCbWGEV0RY9Z-[-J\0fBHSWV9CGcQNfY1e?)4MRf/
,]4<?dQIO55\96BD<-\,dC+WOGNgT55+0A/6KCRIS+3LMN)I#dK)H3HSf0_A(<I/
T0.<DM,)9/cUcG/VdF7Qa.)N<917KU6KQZIS?S[=Qd1)9=DTf-ZB5G>QMZWM#SXI
Q;)e-MOWK(;aCJHCY/Z<KOBH.fUM3N)g5#QUaV9cY0E15c;H1VJQ-<+R.NA^PAdY
1S,/)4<+3#[RF9D)Mdf/9APXK];eD47,=A9/>#^E_F;f,\ECSK[@NUR^0Q\OcF;0
TWX2ce:VC5&H:=([\f[+d-Q(U6T0@gb5+d[]#1Nd][BaQW)P2T\-O3RGgb@g3a/^
H2YII;TUZ@2;\agg3X_Tg9)SC8(#aA/Af9[E7ISF</4&^SRUJg8E_&U)O#P5^Q)5
WdVZB)ZL,BFea8T.C)V3/7?Vd-2S\b?CB?3ZR-VT1H&Z+].2.BL#PKY@cW<JP,,,
7;5(=;THR&&eRA++LJR/Z\>,,XTe)d4dX/=PQJSgL,L[(78f3aN6g4KR[X4\I7:6
E4+_E=W(WgM5<dCb+-TLgb&ca/B3D>-C[ZT,)UB;_>L?Fe3W:B7FG7B1>MGYAe-E
b]bD^Rb96HL=,2XHAW34Z-=IHWJ:a>&6B6DZVgL45^,JdaO@1H7N.V?//B+:7(8b
LJd(UZURP(_fPS1UDcUAV4C-PY6,CN<I)UCBa:,/D48\:46LM(bVM-5Y@eI]]daY
K<C:>L,:8aH3c,5V?Y6B/5JRFO^7+B;)X,)/WFbOLH@M@Mg/TIbW](.70-&O][,b
Ae>6ILTd:2fQd?g+e3\1^>W:16a:_VAR^B]Vb9N3b<L+Bfc?7W_0M.U]F[cgg>O3
V:fa]eM2_gMVKQfB3J5TCVcVbd3P5OD?]C=YZ<#XBD7C5\U5N:K7ZDSUL@_d3>?C
QNJ>F^RIJCEQQ]<I+N_PKUf1=DDcW?_T4?Z=.KWH=;W]8/5=R_T?&S/3/W+de5VV
&dU_=-S/:]-I1Rea0C[e?dM<L?L^\_:8+G))0Y=.:\Oe^?[V1MT9P,c=@MA3R.B[
/=XQfX?cXU;:HPb).M\+@W^:U9WQY][ACL[<B36#T;75WNSa.P+OQAU_5VZTV/H;
a#8b;aA8<G1S:0<Ue8FX:9WEW6H;);&[9Q/#KgMR1+>;5Z5UUVDX_&C;;[79JBAa
C@3A[1B99ONS4c[a.&+cfO]d6H\[Bg#/L1K;1,dRe0cIK16\a.R2X#cT5,cH5EJV
DQM_g6Y<6[:\4Y;#I^0UHY;-(\S@BPH:GA+[.Yd\VV[X@EB688cGF+#SKWW/VOW9
<OC8([W,?;QL93B8SEB<YJ_\L;C><JV90[KZ0OTgaRI8RfX#A/PRX8d2CHV/,]N?
ReCW=2fH@<D=[-=9WOA/FL\=3bC>Fe#[_Y+L+Y@G[.7XS.fU.&SBH]fRZW,ZN3L.
He/aZ#<JY,9UMLE6g;UKG,3I+Sgc6KdaZ9K:/195/5bAZA;+-[J6J7K7[=dc+#O^
V)]PXbF(6-XM[/T>,LHd)MTT?bNKcP#7CNKKfHJe>N7fP-.#EPQ]bSXd0@dW#3ZE
JN5UY+7b:,00@_0KTKa3;BB2/>E?4-H[[^:.d^L=9<8EL&IKOH[^ZRcRCO#a:?[,
ca+^K]:#QgP8.PdI[M+L3O:)M#4DC)V=b_dX0H6Sg>4G;d+M1^ZHH^S;\WT;/8X1
QE)9XFH?ZL1O_&C;4?JYPGd(>-FN]^Y[5bIfeG^F^Pa5N<XZLLK[B5<8GG0U+NEg
2>RHaEK1=IF1./G60PCFPY/6-d)R@9:LI5AAI=Cd0KVI42772(FB/:^B:F/-9HB9
bG<7NKEP@HHbSGUFFZXYegY#K0_<bMSA=1K?I[V)#_;.X47(5IQ<B<D;J\4(;G)I
@>1cE;d+#1<<3-WF?E)+416D[b&D9#8Nb&/TW:-[?E-G+,5ZHe9Q7bN(&1YIL+3L
\RR4LAU/\#Ic:#PU&@]Jada(<>\e]>fb_N],L)^E)CO@4>;Ud]MNF&9R#;Y)+e.H
[(-E5I\?ZRa?0?#\PYE[>=Z>cR,QFP-X)Wc3Q.@37g-N0(XcC@7_,U)5XQGS+30C
eX[P:RW8fEa,X8#L2f2NW-DLc@FK>?2NFb.#J0FM7J[QAb&LRBFQS9/&MAC\@.@D
Bfe^f:g:9SD2<>A<BQ]C/Q5VP79,8H6Y[P<9IQD>d5MaAY6/I>4YH?O:Z^QX4<cN
=O<H7:eB__gSI0^RSc3MLe/d(_;/I05<[POMH+^[+/PZXK-ERgZUYK4Bc\AJ34HG
8/CQaVD=U@=>CO:UA7[)O)6K^[-3<_-U&4HZBKNgZbRP^KBa6.YYDFQ^N^g#I-ad
21+b3_8E=NP8ZQN13C,8__#(MAe+QJ@P.cfJ(=,]K=KB_-1J@R1PY-GZ5C=\L?E@
(_MV8T46+>K8G0M(cdb8&[]Q7=>@;Y6J-PI.fEO72KACBP#MHT[>?D&[P\7\+6AU
C+XMLC.)0^[Q#OHT&)dLa1]a1c?LLd0.HK9?0VPD7,=91K0T^H1R5\-FGY4A35e5
O2K38Y_:-fYGTO2ZQO]=,:JFIURBK1eBFYdg>HeX84D;F2#3<Rc;OSH>O2MI2>4g
N#13(;B<QQCN87EH\SZaF3BDCO8HVNJV7[RRb].T81]MQ\g7LU7U(2=P[\LE6TKR
He&<K^[K(DD-TXS_d@R3#ISSCW]KDRUMeCQ6,@03TU.Z=[4I-P_58?5.a5E,J]Qe
<8[>^X+@=3<4b\W^AV_Z-?4fAKP\/)?BC/KK=K54G@2/\>T:08PWb9@_@7_X?(I5
9;]S7);^R5FbI;#[>JA6.?0bMQH[8[)\K:9^2<VOV2SNP_H/c)McU+/O\?f:@L\C
V@9ACLc,Q3CAQgCW;Qdc<)U?R;f(bO+ML:@WSNHDJ16,&4^f-I1O_=28+DJ/O:S@
/a/1&(4c-H,?#P)8DW.0S_D8(Zg.^#c9H8--OVRc,JQP\[S:(FO[0P4)O01@b0?K
L9a0c?7GJOVYZB5T54GR2?YN=D9.gIQER,[O3e2PJ/aH@LeT-VGQbX;=(dcA\6+N
g@C-T2)HY@O.Hb]M>QSACB3PL(GNS_JQcaS)AD4-L7YSC4/PUa[0-A,=@JX8<IT4
dS6M4-DR(4>;)GYF(3fe_<PcEfPD1Q4N:?GLF;-Q2?J#8:1CXI2WfMb-519W-eT]
+]d^)G41#0]WFICSeX&X.E)SHaD-__,T(/f-4KSZ5(^_-&H-T2.7,Ta?>8f@WW[_
PDbdg1WB8EWR7KE9Y#fG/b-DGUb->a:=)RQX7b^3<HMbB^944]D4e7.#)[@R\^7,
AAQ@@),Hd+NNUg9IILc8#DG?0>\7BcDJ75\+EW>d;ES,6(aY+D32D&Je1?ON^f9H
@HG8=T(P+K:bIWde=fLAS@)Jd.^:9c7=DW/+MRMWHZ(M]S/4]<[9M(KY.bgP4?<T
?K&-U[,30e7C]S-c2IYOG&9LSfd/da:@I9U&]b1KGZ2X/.V7)YH1LfKPAG74JW2R
&9>BW[Hc6J[UbYagc_7&^bXTb;>)W3a:,W;>U-3Fg?0&M5TV@;@cc=d7@ACN<+)#
;9?;90YcR2(&Xb[58c=B@]0B1VQ.bEc.3C2Wf(73aB6M:a=6TV+TCKgeCFZ&DKIg
O][^J?=2,Nf0e<ZGA=Z;Pa?,.7DJDPV_=BRJJ44F7d\=^277LC2^:_+\O2?J>?Xf
_9)D)<ba,SAb49#L)E-^[S#Y)IJE/a.XTLC97M3<KP1DCe+_1G98c:J1VZ-)D.a6
;0D5GQVBCbO=-[CWeD9ZIf#>QCK>DD>#8N@^NK#f2+0cJX1>>)e]g(Q-F/]aRDU0
>Q4UIVQB59f&38SG_<[7V4-&Eg[>5>8+eR#=-CXTEBdVKE-U?U/X=T?BZ_3T1/IF
J\6_10&1^TO_Y4Q0beNW5GR8Y2DbYFRXFP#40_CgJXaG.O^>>XGH/#[ff2/e(-([
e]<=BTaJ)e44-W@.X5=P.O\1@[0[TGOOD@VVFJ>;2HVa/ZS4N8b3B:5cZ17NNKU&
Y-3a4+1Q45]4#]\:GMIMIL9YAg,Y3#cML+;6M?=]OdA:\Xb^<L]D/1/6L6&eG);B
ggfVC\)>?2<XKJWTWGS<:+130BcQQHP(7)L?DIV,2;>JBK^G,JGOe)]eJ[01agH-
@YF>=L#LY#GWWP0?Mbf\^^P[LD[g]^JW@6c](_2+RWCKAeaF?7OcUA#3G5L@DU#F
@E-R])Y)NK3EHaP@fZ?OC.7W0EEb#Z\Q9J+8WHY56gE#B:Z+d[PNaF(B;MFE8.RC
PVEIV-]gV1ZZG.8]TbHE+:^,F>d326/2aK@WDX_OQIb(ACN3ZYSZ-HGPM.4EQ.M+
=@C8URf<aNFB@J?HSZYSJG&QV(_);LTQ<Y:^P017&>6SdXVUZ2(+aQG@e/WGM9f@
TVBcXPU1cBI[F+K^+G&9+..6P.,N;FdF63[.+ff,TL;9ga3>][;Ye8;L^C/&#(e5
^a/BSAQ92W@3.D];Zg<:G1f12MfV3H3<:bOOHY/f7H[Of>\.M^57?RV]aDVa-a0M
N;JGOH]OT8W5R]&EM9e7^W&6SYc\=aLWeW+N4K+K=,.PN6MV;:E&X5DUI+Q4M^1A
+^\>(@ONM&7IH+PRTMRZORP:1X3cQT-4K/C8<+IODL+-e:O&/W\-+]Bb?1ZK-=E9
L2(db]W1]K:G(]0MBNVJ\R,5/04Y+F-T75\RY?#C1Q3@MM9TG416W>N[a8FTHSfg
+>(aZ]EH#.J-5bFF_462N2P9ZBQ9IV<D8<gSNgL.B?9?@J]TdTKH=UeW^VZBCD&b
D-:XI(Ka()HPTb&#A#3Z_cE#+X:b\8ggK3XS)>(NGY)<&P41e=^5^;792T9D_L]_
K&U^)S&N9TLcP0V-a8-4[f.bC02PZR^aJXH@KU)DD[D]?/D@2b[>E]-I>1\gDN4D
@6UD:E:2MNP.#dcK_L25SDWdf1PBe6QJKJHF-/PYJ_:f/Q8cV?+L[R^eUU;Qc?g(
)N#DG.e[;ES,dQ.bDP[Q0/XDPZ#?PX(@^^?>J(^TgX&U;D&d0dP-agBg,BWT?PVL
/-,[@Y4#+9@C:.\AG[g8,;M;XL3M7f0XHS^W<E94D](N=#T[YG<X5E^]^Aa#TE),
Q1UCfB(gKIWCN_GdCJA(H5L]A_4\I:[f?/UA/g[e51P8I52c2/R]\D59-_S-M7aP
]XZ;M^<P=0H&bK0>f+g0O=0UP.W>Y[A:[XJ-a>C6fN&#UL6=XJ(09>4RBWKe;[&c
9ad(1&<LF(D\YP-KRcb5>-gKWR&-1W+R[7_R_662R,[fGAPg2IBPC[)TB(+UFV2.
PWNcR3[I_Q:>4[?=OMKW>:a6WX:Bb#&WfEC2V4OK(e1B,HC?E;4#&/]9T&,2agKe
^,N#O<<8.aYd>-FU<bVNZ(HD59X@+,S>BF9=>9bfU3cA]ZZ7&L=RC[&<HB<=Z#E8
])XSY#YAM8g?Me&+We-.Z:<(H:<ADGEQ-:UaUJN0gR9F_1g2:31:M1_R(Q&EdYX.
IT@^1fA3/#_)e5H9<K&03UC6PY27aW4:\Z:(JGgc32.[X:4^\=ZBJK2K+c=EZWB/
f_=Ba>]O]cU+]bd<,@TEH/N7?:d4c[e]U3];Q&HKePMO]##TI5V]X4eX)eFV,3L_
L9<PcK)e^)XH<AP==RO1Je+SUgfbT96f#IXB\D>gR^HARbIdP@VR8\aAX8(&RI7^
Qe;>b@988<>g)O^3<c\gIK0_>8&713LX^M+89b1EgR.daRS0<_WUTNC=2SLUE]Q^
Y85JAB9499E]+@511JU_H22bc]^J#)8A]O1?2E_HWaS=Ub;SE91OLJR-HD)0LITX
<IfMD>H1/=fT4f@8FM9U;FU<PYIeS2VD<G))-.XT6QAbVLACEM39UQ_AUM[E8];\
c5RZ4g[B9AO94fU&RbEUB=+R=bF#E/ABF&3.9I51QIf7LdS9.3U-(1A2_3VAMQ_7
1VG9<5A7Q<eJ?=,ac+&=9_BJ[-QVV5#KC(_2OcLSO<Q^T(P_9^/NXTX]X>>F.<&&
^K?W.7)S[,QDbC:OFL7>6F>9dXg]ZAgTK1@Q(E;TAGKb_JQNDe]I0L).2<Y6QO\[
J7EHP,2[9SX1T[RaK_CPG1S1D^b>.(8b;6MD6^OHTE9_fO._^MD0BJg/O>T>def+
@@I@:RO,PW&bJD91Y:0FdIROf56;>\e<@@VJ+1#(dE4\cIQVD;g6)ORT@ZP#g:XS
=VXd:&:6_e,e4[H2>/1^N>[K9fQ.@][f3\b@V9PG2#cZf76=[,AFU38A]bN0gT8P
a7\NfaJ#f[KUY2[AE93RbT7I0EMHF9eI@d1+>7a)a==V#OW<[6GK<IY.XCW:O2\-
M==fX=eF2dMA^A.5/ET(OGc4/VZ8Z2CbR+WM(C&SJHHPB8KJ6T.J2NPWR)R<Kc\8
Hac/b/&Id#P+C_^Y+OgOLZKY@DK(MS@S<[3WIU1;XTF&6.6OV0(gER0@YKaB>@,I
]1ZDTA63XD(U1>\eP_\715#]CG(WZc?YJS;9/ce6MGC72BcWZ&4P^,=)9_fGeI\#
Z#gA1AXWDJFf)Vg=B.B.IZM-W3.UCG_GG6MgGW>3#X4CX4<\K.,\a@PN-f+W-@NF
7W7/@2Z;6SRPM.,QWR93DdgTX=aR&0YYAd39_G(0T74+.+^^&OcBV1gbbHLcb.F\
XX[.&X827H,^=#Q.fB(QO&9ZY/=?0NBGA^?VcggM^>X;[3+BE2)QB0IT+J4YDDZF
2]_],VdZM3.Ff]D5I[8F@ZS_T:PE1L8Y<:?]^.,):TM<fX+T8Dg6B7eLLV<5S3U5
&@RU9[NH;1_Lc7Y)/7O^eO]3fZD&KU&ee)IX5+/E5TE5f<Rf<D5bR9^3C.dB&42a
^HaY=60);M(g7&K,f9TBA>I,d]6XVV4PUR:CQ<Z:WgfV[<2M-_QX6Z@B1F\V;d3,
F)GC>:@GC5^c0:>\NcR+CEURg\PA]((R+/)0X2>R<b1G],)DZAO:H?Bb9cIV.eNJ
,EFC;1T)(F\-+[d><LRM7(2X:=eXgJ1B3YX+F^K#(\XV+S8=#[8Dd3XZF89O[EEF
R?N10a#Oc01J.RV^f+LO&YBgCe9]/]ZZX=0c3C41F,W-BVa7aY;7VVMN^G4=YKI7
E1;Ig_<^1CRXU&C)SNH=bfcKI]=a=WgD19T6YMYeaT>KI\J22SaM7T1QRCG,-&Oc
#Q3]K5WL7)PR&-C5(Q>J^DC/,&eg6U3Q2/3/cJ<U(\#1Q>fgL8,cdOQT7XYWP&Jg
1H09/Uaga0BU,PUTgBGU9(4Tc8C</,6>f==F51_1C&gGZLGI0D=Hd+82_<#Y(>MA
_4?@1PMX4B6^G;X=d4)>g5_]]Ze0fEfEB@DP]/Kg,4E=d?<IVZS8UU^UHIW:(-b5
G&S6Y8N[P>Icba9-P1LO^_NcW=Y^2E&IZ,]+UE:9LM9I+&Q1^c:2DA(0e.+3T0cP
7Ab5LCF+BX(@9?=GU,N-96Q3-Ne2^QXS\XcWW2Q^VWT3&EcEd?,/:FE+SKf9\HOO
(,Dg)DXU77]7a2\RTT\V?[WZ^(bL7^Q^fBB02F_1EZDW5\[+[H;M6URD/0g=;(&9
ffa5LFPUR:fFd.VF/3G_JUDTQ<HV81SXA32W0VO]K3)A(ZM]/I-HNK5D8bSIc?eG
:6d=f:[f.Q(-^J3f(7c;CL2+_c?4fZ;2YJ=;G>?N^g;J3292R.5RU/22fZE04UXQ
V\fOcO8fV=2B],C6aI&MY>ed(M:)Bfc.V@OR1W#EHB2JOF@H6Z6CJXW9_7G1UcHW
5ML;P4?QgYW9+>_0;B?8\U&U0](+,UDg6a-._AIEB8][3)@LA=.aF=.8^,/^]#?/
cOGT@27K#FH\;XD:ZJ)HU0&]TM2gTS;HEfYB.AJe.g(VA#=d5<ZK+>0IB-MG57cW
QQI5a6H9QcT206?9M_EQR?,KOKJ;U,GQW=0&++,E[E\c_YXO#]O9NE5bFTR^8,Z5
KF3,=g_,;=Ldd7RE@Cd\(^@\@J(0PZU7)[S<>7#Ud4Se40c#EX3PW_5820?&g;Gd
9[1^gCaL6b&U0a-QCKV,TgV:-\GIM7#MPgH.&@R^A8-+R\9-[(2,41CYEO_6MVg=
],:=8fVI?XJf3MR.RPJRUOT7f<OaR]b1XB80O<,M3GG)9^TF\b81/BcD,(GbKE0G
93U.^3@1aF?=egK3AV>F1a:PO6RCFC.DEZ<aI(O,(J1JccG1>[VAVSFBeEX-7#)[
V+2A7YXc:_]Y46\^JaKR<O8[:IWS=QMKF(;EKH?DWHC1/WbfC./V-06#E0(PXIF3
)gW-]O(SfAbKfZ]0W&^N/1(J?J4QIeBa+H680_G+D:C;4X(S1T\9<NI@7)R=86)d
;G(>IQe_^bfK^(3>_H?X1WN4212DQ?5+,N,1IQ==6C<,@W2gKPdGEcZEZaR7d6OC
<fGA\2>H>d;I-W0EA3M0YB,:C9IQ;2bC-)3\.:7aa)Q\QS;S1W9S<]Y&(-R4fOY-
C+0XZ8IIfA=ffe[6]Bgb39C:_Z5CT+X1Q?.A.UGE#GWJ;O8CP\4\?3C1g^CACaRQ
[8T:Q^I2Y3&Fa,g_,BIFP@Q-I:e(f2CQL?gK=H002Z(14>,-]U0YZA5L&X57@.JE
@OZ>(6R.2ZAGYZIf;([SQQ9C5W_c)KJ?f:8#RK7+<dT[WAL&9X8&YLC)Q,WV4T/S
2fK?Md@XR?J]EFEM7I;NZ6PPTe[@BZ59WMD50AXOFJVg4dOY[O;(1gb;7X9]Z<N<
WH_8a9SD2&JV?1ZW&MRQgNc-=+eIZ:Dde:/Q2IH<9)\dZ1+[V&ZddA-ZdVRHM6L)
U?926FbOX;Z7K2EEB)>(Q<d9&WI<+d:3I/C(IP;227e.AJUER+32:KQD\#H.7Jdc
R2ZI/L762GF8B?Q^3Y5Z12R8L7bcR7=8.YALF]WaYbUYdI-FBX(3e&RJB8O]NH;1
.;N80#7:_A/2)=bN=g+c3>fdgBI<bP_(2=K5)?&?R+>F=I-P411,g#V,B\Nb/gPJ
#N&L?\E@;2I#VQU_Z[;b95gX(H(+[\5+R32[c67a(OZ9,,AM+^K_K+B5&;/Q>)+1
QeE/LgeXd[&4=;^J,-_b^GN4N5a#[H7^]\<NeUGHH:aP&Y]PHU#O)C0Hg.5N#+be
1H;+(#?D2I\<R2(Z(ce[)d57?ZUYd[D[[J^OF1U^22bFVWM-BI>]GN6g_PRggDY\
Gg4KKE5@-]04^1Y6<0T5-aU]2X)#I6EY5IZK/FHX.>Df-XA/f(aA_=bSW4Pc=;Yc
B+.gK05L;e[G[)G;Q4T1VCOgX:XX9M(-0(Z&a;_(43B_2R>0>&E:QcP>/SJCS[N?
U,IDJ)6b4Gd)8Hf^^@YE10O&@PL1gY1NL8+NE2:RW;W?Sd:(])@S:X]-9caB,,I\
DEH:H+G,_fOKeO;JFGE,-R#DY>e\9E3L6FZN,_TERO-d9L&W\4.?=EeJU\PA.(&U
&P9E5_;6GWCNC0VOPGS6_O<9PV?4WR)(-CAFa9QR]Wd=/4F461+90(be1(G&e_6.
e:[aV,CO+H4RFSG,:,F;/<L39Uf,#P7W753HQQ9K2aIPZ/-7O02]MWVT]=a__BOZ
&N@P;cN61\>JgAd+?9UPWcR_f8d.AQb/3Q@9(ZSBQ8a\59O7,8BV.(4Rb;dFe9_e
I14bR;eJJ_EDGL/4.-IW358-&<_b@VNW0+ORYDX,M7\ebL,R2V4+dRD4;^;d(>4-
_]/OMUTVG#+0Ac_ca7cTJE/D)IV8)9b,DD<[RG/9GH3a+G#9WBPbU>CV2g0c98MB
c\88CMICCJ6@0_AeXN6MeY<:[@4B(BB>1\O^-^Ic,D_@<V9dfWOA.?0WaRPTP]^@
GU?)4Q0LD9d>dDB-Q#/-XK#Na&5SKV[F\/a8beT:/5+^;QLd3#A8G^H7-gPcP6O@
]#1d.W0Z?DGX=BX7LQe8bOWee\2=V4.:=^\1,,,QE0[<#-bC=3.aeg\<N=C]dNDE
:GGS;]68KRDGGHIaG?^a03QE]0dH(cbM_)G\\;M5]:D,V33c^P.XgI#6cdWdC#7P
/@CETgCY1>^15XUX,0\VgJ]Y[a;@JO4N?Z>KT:BSG^g^a(C<#@(3bZ90g72\9FL\
,WR5[G;2]f7B#fH(^TaDQ&?<5TPb^,L1DOYd4V.aMDN78Y0&-5g-C?JSNJH;5Q1g
&aKcb?Z(@ZQD372P4D(^YH>,U6B1WA56G4=MfSDCG1CUUSZa)eZP+.[TADVbM4(L
AM&fc./45KCM,EY1RD/eCD_O=1[&4V.+DALD7\:(Z;6;)9-<6.Za#J],-KXVJ1gb
TKOcU)gZ=KBEUVEbB,2:=GL=Z)aG-LL&([KdMF_+gLf(eS#EMe^gF9:L(gRX,QD@
[46-S<M[+cI\_#]ELAe<8;I5]#6FUV32J1^EIHa>=&4L7EgC:L5W,b)J/)+V2bNR
T1F>a-_NZ5T03HAM66F5X6^RbF+4;KZ_LX]L2NLM:-D1\FC@OO6EX6gM[<d0CXJ7
;E(::[;g7]UadRagF+c1\STX;XJ)Q2)1A93]1AADJb5KQV.OCYM5XRQ-S]U>ZOUP
&AeMfbDM?fO7L>UUNfBL=Z2/@fA6V]aRFZ\4MUQ#,=,?NQV?7FU311g?^9H-b.5#
S^N-_)QM&.I^f[KLM<B^6f;A:>=-8O&aP3,g2Sg=&7GJbGb0L[.3:O\G=b11,GdN
U>:FQE?UVD^WQND_gd248:WQO=fQWg=U963X\PDfeVfRX@4)U#Ge9;9])N7A/;af
26KK_0-5NI\6MA]Y[;)P^.aKX-BA0++,#8Wa?27?N&X[L?UdPTI^+ROVZGJgM]#J
OSX9f.AGfNe@9VQX;9dQU[1S\/[<TU?F+;)BdW8PWM&If.2d?C.Ud..:a#V^]D;g
eEY&<BYZ0J&WDfZQa1QDVRTa&A:=a@6c6);?L##&aXK[[_-\J.BWeT8(GPVFFI<P
DJ^L)(5=P/#W4Z]fUO\:X(#GN:d7T\5c]MZ@SYJ(?1e#\HfH0WZ,=Aff=S6b?2GD
&fUOX(3G4CTG1bO_;0(K53bFCMCS@BS_<)Y[@+^7RSO-[6H[H>+HT_TIS[5Q1K4Z
ZWE.4SNQ@MYd01L8,MK24F9#MH]^YEYV9J?41=4TT0QfQ@_Rb#VLR1_79D+).Ia:
,T/OBGGc+bDZZD&;[[4NH=?He(GRQ(<:X.88_,YcDe=8=X>9abBB]/^9\cc7P6?N
E/HRDVQ.E?=:,.6-CLbXLES4g_O-UcKb1YLW2EJZHJ[[<SKS_/bL@AbD5cJ?B=Ua
aF-/;R@IccD.W9&=+,2<)NCd(cQB^dM-:\FG;B].c5F0#4I>0(.g2_.:R.d<fEOg
ERR(F>FG:WM_+9ce]_XT<]GdB&4P>2-]I0(E33-f3PPALQNI(79UUB_CFY2[HN2H
_G<DFOe@/>=5(dSC39LaFbW)BN+CIE4TXbg3?7HTdSM?8L,P7^>A>4P3#>PK[bYM
=,S<G2)a#RM30]YRf5H8D9fP_S]W57))BYE6YOTgDeX>PX?(MBF__JP_F<G#;/&\
B,V\,4#Y?Q;?G@,7GT-.<aZ&DRQKS&_U>K;K:54CZPaTO4IPc=UU.1SH<^dN2^1S
=&0.T\)SE\:B4cG:9_8@PC)#YXBM:\:ZT/II?.,_3d:gBdGE?+F,OWbYVaaXEcT.
JQOd>MCN0YF,,3\MGCLaPDZ>0QP/.PQ>MbA=aF?2\0)VJT]6)7#\,^X&4[/2W22Y
@Ta];5H&fb,LGJYKbPAWD.6XQB&2Y2BRTFF4?VTWL3^ITRQcKFO5c[L4]/^Y:Q8S
d?d;4DBDeE85(885M3)X)d896G\aCMa)TUG26f-16_Ld.H,a4SZG@-@F+E?G6_a@
>H)/#JbB[[9K@O)1+FXc46Fc4,?<HfKg<5T.(\8HO-WW<:(a\U<FTV+#.9&DER4Z
eaN=#K=DbYg(]+](--e#0=2QHAKA@aA3H/U2G>gP6&Gc:OJ+)(>GgRJW?O-PfC0Y
3J=3@#K1N=MZMJVK?;UY/]dEZ<fI8Y6(Y-H^]^PH,HbcSa4eTagR_\=?S]G+/<)J
3?a(I?U<AQKN\XC&d4K2@9II<F]dV@cf2NK=<HO7A[+=Vc67F3/+gbWZVPP[T8RJ
XN0Kg;Z<AEdQJH<KG,gCd@=DU)NKI&-@eL@ODQdRIAD;Tg8[E;QF76BY7@+5gHDE
190,EG/3[+9+C:S1H^C.Qgdg[BHBMY2&06MaZ6&B)-7;H$
`endprotected


`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
