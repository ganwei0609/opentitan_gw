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
P?dZ(-f@..O-O?ffg-bZ1\]W3,8-e.dYW>c^&IB,P^bPg#gL0VJ44(GO&)MI=[A>
e:IA:<BE8[N9QJCH?6&)-&M=MU6WP&3I6P[\[LY8>.\X)4K:_Ccf:WE:S2,=+0F4
bJE]J=+7I,U3T=(<+fHaERTT\8\^.()I:5RO^U2bNa_NHLb)b1S^aVU=0Z=,c/FO
@:+?__aNKP43aTUX4b7XLd#,d6cObBB+-W1UAeFA5gL9G;HgYT#:>:[GDMLX-_Q:
L85WcB6eOI6N9<8@(@W=Q2-NfO8?V(_:@OCSTKd-QQ-)[=+C+SST=F6<WV:e2BHe
M:T,/@/WIAd)U;]/d2Q-<[f7b,;/1bQ4-NXO3gZ@6E&I7\W@-cQ=0TcXaD0Mg=K1
Y&B>Q2edB]dgRPg;^+2>SX<?2<A1(_1<8=UZa)V@@_UD\>FIS5PR>aLX^V>_EX=)
<g7.\OWc+1a;c\6dTC\QROJ&X?7X6P5WJV=B>)9g.]eW&1>P:92,NHBPU.1A>f]P
D:_<FbS&HbKU_eL.[BZA^2/gf--QC[2@a_>>S[Yg9RKI1GTSO[44[D:2MURYdM->
V@cAJE#YR^?g1MQ+6XW;TXU]]>^_N<1L<)[FVbbVXF&/-.<<Y_#SZb2IQA>N38TZ
D@<d&41D)+Uc/9E>(77DZ+@YF]d=\g-b=Z#Q&Q;?L35MQ/XA;Lc87WUc>DX-RQ6R
=/9TGeH<@70E8gEK@6E9Y:KL#beQfUY\[d[<+A<--fTHL==ZN1c138\1A&f;LP^g
aQX/L8Ta;,@:FR@<U;Tg(75gM1FgdY^UX/,fW.PT2@1c<GCV,<__V[NL/]ALVVB2
T>aM,AS86P_)IT07+>N@7&54dA/(Tb_?>+)G&<[B=[=_fQCCNaeM<P_Q/9c.O(]J
g3M(b07eRSa<XQb1>KRdHT#Z+Ab&QdY]?9RU/e5+XDM)LJ,L6&22P7U,L,Q0K+I[
268B(9;^^eJ?XfM\0NN^BC]eHd2]>Q)ERS4f+,aN.;,.R.L2e6TX7-BGA]OE,3UI
=ag03Rd.M7T^DR66NQPU,WBSVN+\VL1@4QNCKUHb]Sd/-U9\(CI9D^D@#K;0>F0e
33;eF[eD-C2AFb@;G-QQ=0)68=6N#2f?X&OW(QJdHR8Y#R?M>^KcJdc^OWdJNUJS
JG.Ba2WB&gG2OH?+RR1Y&g3.d[g22#3E1C7LD^8)SF2f.O9XHg0ETR9EbS&FecTX
Rg0.?fR8:U[E3/1A6P+K-@>EgB#g/8d7+>P8I)+X^Lf6GILX?I:f&/Wc&,.R_T&T
0N8f^F+UMc<@ZIUH1JcOW?Td5J9QL8DN+6ZZdTLS.>R;R]3:TSHRV9&DKXOT7>9G
E0I8,>U5BSFHN;Y\Sa,YCaSSC38ELE:#)#L)]+[/+c(Cb,;CXD0B5JcZ4Z21A>5T
2C1_f-8dbcL>/a.._(9eE<&M6>KWe.K@Q3a[3Y-41-W-]&Fdgd\;I&SdbVB(&5XG
Y>MY4VY?P9Q-YV(11QK@GK09dV)/^bNG1H/C4/\AD4VfcJJ2Y.HEO59GXd]4RN#L
3+-?(8N:^N<1cDH[@SO<,#L/eD\>6SH4C/)&O:_5:6Ae=R@DYc=2fbf)E#/;+&4>
\>U;U(<5cK+f^fUULcHG>FW&[MIc6BI/cT^0fJZO@;I_Sd_bO,:ZLV3X..UEFXA;
O;eFZ;b6S1G,@c=-[(WD^H.][6\V9F?-J@PO530:.;^)Q+&0fBFc?EZ0-KB;_0GH
Ca3Rd,Z<-F#MI^7FL[&cOV649#;6E3ZNeR_//NW&AE[A.fgS8H:Q[54_P<L@NH86
@8ZU_NS^Q3=-?JO-\cPT1TD/?6VGcU.LQ]T<38704T0^K0GH8D&9e^,030.d0Mg#
f.8?U\7,&8>2;fH2gE=^Z@caTOE+,RROCdC+_V[78KOe:9_CC=-:Z-6>3/\A,7Y>
:26;<\cNbC\7A>[/:Q;0cBDgeXb7XPINg)d3Zd-VEVX5:P/JZ=_,3C/KZ;-.\TPE
U#\JF)?Z?B)TeJ\CFP2H_<,<Ld4cHM&:6Ef10O9E#2,0#+V.d:[CcH#C6E9X(#T.
:JT02R/HdU+L=1fGM9;8AN8H4P2[S[;W?[V</X=?_eM].>O+2)2,+4-XD_YYJR+>
1L7H2^ZY.[@3G#HHd&=aX0_QdS?YegBY-O2KdH53gN4;_1b?AS,2UN^_Y@/:NDX<
gNB5BJCffE[eYPAP+gG#e@;&YX_XeZf>ec>#PD(BX\^SI8EEQbZ(71\0RC1_Jd8S
H.c0XBX<?I^G^R_4X)9BYIAC>[c&<SN)M<77f2BSaAF[2bKNF;>@?eZ:c6A:Eb.A
@&\K=FZ:V_NLY10\Y-Qd@].U@@]M-_Y624JYUM/EDeL+T>Z&FG\/9Sd0A3JO//\Y
._2^f683T=1(gZ<LSg2K)L28AJ8RPD15M:\G-VD7d32EG>RJNK=;4&)ES1Q2D_W,
(6J7\fW&a5b;4SX:Xc3_5O9UC^U\Fd-,2Lf)GJHX?OL1HaU=g)2WT.VL>gE:_6?#
IF,00?GcNW>#PFe:V@2Ia?@VWU/beRfc]XWK4cH0]VMdLPVV4G6.]PAR+Z:c6BT6
#/-#Y1fT/[WS/KA366P0.,?H6L:(,SV7I8aU?fEdM(fD2LL=b:Y=J@+@5#3[\@WV
Y-&EK7D^,<QEbW:M>V+?=P(gWd&]WXED1<5J8Zf1/X47U:.gRO<1-_2#/56+B76D
9P-S+(XB=/1b_JV.:V_F1c?PJ^AV3,,50.96gS6V8@/a/SORa[;M<gBX>00P72b&
#N5(g9LI;F<g5OIgCgW=FBJ2TD:/U>g4_N<R.+P0G.0\8AR&,NFbFg2LP/[_^N-&
dM)_.\JAAJT,fO;;I-T9Q)>EBLMV#M@-KD+(^;F+6CN+@=b]-4:PAW2YbfHDC(;+
90<4,&1Y2_cG.L;=PO(gGT?ec=.;_<g[<a46g2LIC_[eX^WCY9V172?8(4M3A0O^
a\9g^=UU0\76.26\&HO0S-#&P3.RV>.^&_6NgGT-G8[:+Y&4dARAS+D;HBA9@^J3
CFcOST.=B,S32a72U62VJ&CC.5P_+gJ/2>@C)Q4P,N@L@XaPd8HW/+e9#+eHYE??
;e.CH7@95?bK<C63A2gBI5G5HdffWG##P,7S3<1TXWUZ:H)S)UD_/_=d+_MSDLMK
@OTA]&B1BQ\L:XaT4,MJaP0\Cgc-ZM)?.<&YbZ#R)\X>K.7[.Ff-NGQHSEcF;.9M
/NQ(4M,YZAIPPVNGN>D64PLGg3EcBKOG>:2</g-<L\aAdSQWHPB+Y1P;gX-BXb>b
_dT]Cb59]#BSYB)4;8a3RUZY21;bG55ZJa^-O)HWMC]cGH>1,8MJg)C:J-Y,K@g;
[JGb5V\B6/#aNGMSA5XaF<FPVa=(3-9\N>8/NI1=.>.W8L#ITQJ@Kd_:</SWTLda
a;:c+6Ng#3e9Ve>:Aa,+M>#1Yb+bII8UT7U8U&+[Ke+M,3eM12&3>c&MA@BAOBTC
WT2K-LI)8@W2]0VP9=H9F3+A[;QW^@ML=c>Fb>QDT9UJB673Vd6bK\]^UTV()5aY
Rf7I@NY,-J1]PTAMU#JS<H^;R4N5&H8]EJgO/X(e5KAF<2R7FEU-N9A74+9IW3?H
4HI1AY;[-S70d8aF+L]7M0<>E(;3T^Y#0HQb#Jg^D64cG__c0)&b,(#J4I;WfK<3
G9@,]=?CGDcc=)FD,-2-]_RB#XNf7O#.D,dQTf02U\H?efJg[/XV_[#g94_JD5A1
fT=:WU0E4U&^L=^9DN+L181PB)DY?50C;:6CHHfZ2)+1<;+^98#P.3ZV7>LKL,\=
3O@0LK(8,>7+,XONVd-e/V2RT@4SJZ&QM]a8XE@@[g@\g[bWJ1\J?FfB/&47=bPY
U-JCP;Q@CIgRQ?GeecSQIOJ<LY0X6<0P)GK^=ANC6UU&&]H0QY,U-H@]3,LJ]J8Q
7/L-80\-#a+S=?0AI7O)FKQVH.-C?ZR&,^\5RL8>R)FG@d6NLWIH2Z4\>J@?U#AB
3CXXT3=//PB9(6KfSJg/TISQG4DdaB]I=@MbX7U+O]C-9AaW>f5H(Yc5Fbd/:&FE
U[8\+L)C(.=9Sd\Id\@6?KU,M22XQME#6Tf=dd_7^LE6.1>=5</\A[7dfOL9JOUb
)TD5<f1,=#fcAY.Gd2;NLGe1O@A,ZRB?IC&ND:OK4Y,#3:d8Jd8\>+56L7;&TPa<
/GQ(U]6TZLP)_R+@Zgb&22dMPKaFe(6:SK?^\6a3bZC^a_EL3#c&\(;0]#3)_#]V
c8/d=:G:@e(W,f>UF+Y18dZZV<?@^\CX+8;LR#Z<e3d>H9UX.:Y@+[40?YX.bVE(
B5A62BNXV:/b\3Q+FB)F/I,5<()>ZdQ/]5S2c,1Ie8(H-e:RA2B9V(;7G[b27;5G
V8.M7;TV_J=JEJba^.9Ig7bD+AYTF,(-K>+2_]H7eK8/@-UHfb+dK0>MEN@)e@56
(Bc6O,NR,FH\@/;BID6W[W?X#6(e8=B@?I;gf[ZOf++MHcH-#e/<)&150QFedG3]
P;a?J/H,BKXdeN;IHSZaW4@.G.aL4D4<Wg&7>Z^J<Z_P#]c0IVFMG8IP8>)gVE;0
3BW7OR2D)E+3NAdP]CFe@5^B@AH.A^&c19FUbU:V@]0cSF]c4#>WB6H5#:3MR>\b
ED0ddZR^Q;KQ;E82B&O>1QM>R/(A#V5@ZO3D628IO.YF^dK=8>57EK9E23b=UHe-
3M<;:(>g_L:IMcL6B?D0<eXf3I4.5&=U,-2M:>4B,,D#e[:A>ZfW#&L429-[?S6>
P9X/GUf;A#/:>1]@SRMd9QR)=5B94bPaM@eERH^c3N7LS4:g/\&S@(64cI268dGN
I>.B,D6G-Mb41>KN>=4OcPKLDRdOeT>eM0LX_23\709dP3A8UM7f3<X4/Y(JL9&\
YZL/Q,5IT]8ZHW;#@M>;9UNREe)0C]I6YEBK;eODd(f/g:LH10-0e0#>?bM:9f+N
:f9D5):T2dVS.-_0JEb.L_6Pa>g6#U90UbI6(G(;KQbf&VB^e1?U3BPdge6WMY?K
UXJMcHeFgS):1RR)OgU_284=K37cT#;Z/@KBRQUL//b^MfV&A_X;MC@5..>CV7VC
V.CJ,=:DcEc0Y/eN(IIQSE\cR6]d/-:1be#:BPEA<9R5MeRD.WW^KD_V/W5cMg)S
12+SXF2_MKe#S[JP/+J+W;c-<_F=VI[)bdW4RgKLd3SXB9/>8?L7(E-J\A/fN\Y,
>/D68Wg3)a=W@LdQ?O)2_3;F95Z(GPL-A5GAbCNS#/4Y^M&\].@A/H5YBY3TcWCY
P2eR#J<<L;AcDV7_]C@YHPNEd2J5GQa4U8A1<\X=ZYA;TdZHd-#aQPd#+FSAX-9_
IEH)T&33I)+KJUTLN\IaGC57_QAL>3R+DL28(A6A(,<^cfDB4UTXI:+?\a?P.BE(
Qf&;QL@a3GY?37Je+JZQQVZT>Df=F(8_QZ?)B#c=U6I4_K,>2DRc:\Fe#RAG1G@S
O<f)TN7[1<_&OXL/N8-7VNQN7GW_3YNPcfc#.0b)PH@eJ2;M08520;Jg)d6I<&,2
dO2MIAL?@2M+6;573/Q5W;M>bV:)MTGR8Jd^>5;:5fVCQVMYM&-\?;Y>5ScJM-Qc
Jg-K2:W3_L9^cJS?MLOB#bO\@Af[V[ZTTQ@c/N,JMF??55\4?=0J>GRG)J?g\)IW
<[V2+[&g^PJ4aRF6=QUCV0a7\R^F^eb3EFN^UbCV#ZU&F4S1_>=LGTDFZ.NfgH+]
<N8b@GQEK1cg@G,9TJTB<99c42.?YR2ceNf3-4-+?Q+&B@0T[A?Q-aD4e9e#4R3U
,@f.GG(#::/GUK]TQ46PNTFQ86fLX,HI7f;g&[<R32?#T9C#&?V,P5e7NT_cJLQd
Mc)7@S@-XG];#gQJ]fHUEN:V14E0C>d2]A58PQ4&Q.)[S)CUXUcgH]gX:Y=\?L(d
&MRZABe<cLe^]CBTZYY),DWc>(:SLHe(F&BaT@&c)9LGY.>eCT#/[^S47)1a392#
;NObJE\e6C=AF#KgAARcCDLO>cN)_CcP;^f/MAPcSM3/]gg?gEeIOI9#?3K3)Zg/
-77AgL>M<;LU@64/(8_K:]&<0]?#cOR<_L2GL[#U?N-cG2]b_(8;EM&1^G[JXX#5
#3C?4[5A]#X_\+5TE+G+CCZF8[M/J>VRb+Q1(9d>+^OdSbQ)2&]Mf,a_T-^TI_5>
geU?L,R1G8]fOEGa5)5Bd^2)5])&C510f_TW4P.OE[JY=_g5cB8=H_WX#7fJV9Zc
-_PN0R?(]DV1.<6E&?/;TU?H;R:@@EXOc6AB/_f.\47B>4T,Z6.NQH+?X:\E,RP+
T-NA8H(KgQ7+]L9;U5Keb8,QB3AS4R<a[S7Q5MU>1DNU#[IQM/,d+Ke,=;f]bK5f
e+VS+HD34OO?RE/W[A>KKR^7CfOb@PcG2<NAE[5_P?R,KQg;J-W0eA?BVWH)JfZS
9][8bS_5S)MR@-ZP@aL-^FJY&[X8T:cOb5_O,Zb/+\)39)U3FRFfa2.4c>c/[ZJ>
a5IaP1-.U)EFP-18baO^>93LdPYXA\;b.KW5P@eM+5_=BH@#,A,ae:B_@3NHE5.T
:><g_EYK=U2TdX@0PcAf\&1EF?,U9+-CSI\2>2.@cgY7=NT^&Oa?Q/Q)8),A;1O<
MSa;>?+>@69e5b+V\;A-(B,OY[1E4)cN#;S9NLVcVQ.O_#DRZULXW1(gX@B(a;AU
(?LI;DE1N/0[DJ4e[N10d;HIVZ,gYZY.ccI>f:=>]WZ[;R&X5#(J25VaQ(;6A4^.
L9CGgR\gcMg9R;Z=PZ[K(fNH\fGZc4;7>9,1gTO,4LDc(g/N:8FO+c2WVSF#aba:
AHfXH.:])(Y(dCMU-C#cCe=4LF<R=:LHEYIcRH1f1A](cg/KceH-DNI=#>0JFCO>
QZg)eU#J9DQ]gQ..DG=2S:69<N36_fe0,=2,7@4AKN-g-XCNfVKU2;_GDJVaX.]I
6U]CaT6_R=DNB]QT>-\.Nf\6UUH/<I2?<>+\gK86IV>N/_/Le_ON^[dWX&?4>3,M
&+6]_F)@4eg@gePT4KLRL3H;>2Jcc8cK4]BB@ADL5VIM_,FNd,#CBe#gGH@+aHVL
f^?fI;AQJECU,L_J--5&3+5Q&_N9U@LMK8cbZV<]<^&1EY@PGD^Jb4&^&O88,T:A
EE>Ba<H]JI1ee^LfQUd#J]4FQRE>CcTLA0d>G]g:3C&f<AC9KN8)KZWX;)AC5RTZ
LX2Z8];67:+f:3:)>IL>OQ/Z-]SF/8\O(18@<;7[1+N;)ZVZ2N0cK7;5N0Ea[VgT
4Zg5a:=8I:@Je7769UD5AUe5d7(fOGc8)]L0@R.57[aGUVHHH?0(TUK#dI=>H,f9
_EK_P1C6#1.PS-d>8LB;16GB8:5_D&6-UM;-6H]a@c2-,_JV@B0@<;6f<XK(e4[:
S\>f[A_\D.c84()?6>2HH)aQK>N#FRaJW,@18;WVSdI<#;IHG,,G]Ig?]@P5+(VX
,8/Fe0RH@V6Z0V5S.\/8I7^#Ve1H@6OZ&SF^agA<9F3=L\E>3=I(BWT(>_T+Oa3\
Sc4<ARPDS,0^YE?8E29G=N,AEQ<08,d:6gXbdJ]UL[Y;A)[UT3Y-aP&JBeKR:JGd
VPB5e0OdO.&\>JK&H3_53H/9[YdSPJ,cP[Y-+#\G6Z(GI5HE76HOFK;#[^Z_ZE8b
.fc?4F>cC4GNZA6T/]M,Adfe-:JE<c@A68969.4UDa1_(/fYR,RFgDRVO^;eD0B1
b2CW.HFec\>A+_YVfW6:S4^bO.a29Re:Oa=-@O/>fV97.18FGcdSfPO1FH6G5)88
5?gJV0VI-NY+7Z,Lc[+:I.TPD;REZO));f1Q-/NQ@:4eT_MUbYgIQPI&QKZ7O.Ea
MV+#:WeC+N1^8aWOUOV[+3[g\51d=L(6D4.XK-a2:02Vd7PK:)1-=FS+KE;>-PcJ
+)ZdBN43J\R\4BN]23/+Ve3]8PHCOcRXV=/Y\)MWKE31cR;_PcSJ.&T_LBa7(MQJ
\Eb6NX<Fb4-<V.J..S)&K>g]R-3IBP[/2eeS6X3=G2TE+MS<EZ(51Ve?YK20,L#<
R[\5@LR19+_4NS,-A4GI2T=._;/3aLS9;Fa.LH#FdZ:9,N#c^+^(&T>GP,B0\/B)
&Q_\e8=KM0P_-KPXM:d=8:WV75NW]a>=_L@M7=DO+B:Y_L>cPA/-gA,CN\YMW/1L
E2BO6NN]M,@/>?Kc?7\+U)5S22R+<C5:M4T7;cHc]<I8.0g/?]g#YG@L&91R1B9M
O]F1V.B;EI^\.eT_XG)(L(;L3<E_0_6?.2JbP9I;@1e7ONVYBA.U8C>=B<IcQB<J
KC&_+KNY@J(WC5WUL-ROW07a,S1;dT<==PYPXe24#P<eN?M^K+O1MFJ08aI]0&N2
H[c(]egcAJc]RW8T2b<7D2H8eA(f=&S3b87]/(MfEX?Q.RBF/DCLeBF6<B<@:#La
S.(N0U?2)/7+KH]>Y6TS3V^76Ab^[;>2X#K(A)J5RW0<5=/&KAbR2X-4R_R3<cI-
CB8CWMbR2O\UcKdH#ZTdVO@E]C[dT1N<b4J?,M)M(CR&GDVXWQ>(>4aA)5HD.232
eFGCR:V\JE]JQLRG3[ML8NN+OZGbe#O(38G2^K2<>OKEa&;aDG^Z@&/7UL0CHe50
V][c^0U/Dg@L2DQ(4@=#.NIGE\X0/60FRZ+#W]G@aZ@A_Q=VHM<>QAbUJU_>-(Fa
/BBF2=b\A?3D_L-;Ef>1?ZFXW.aHF+1VV;BN08V][787>cSU^BR(X9eV7;5>A03X
1(0CD4Z[9=,;e@DdXJ-EPO#.C5G&Q:L]TK=WL7d8A5-OG9Q4/IB:@/1.>[#D9DKM
b5g;JI#T(1aa[f7;]?NW<JU,/@/B2V^=ab1US88V_9A4II&3[H>38TWLdcWM3;.a
_<IW>-K/S7Tb6=8B#GY1E:?&]JA3SMLXOHE32[2W,8Y>Xc922WTZ]B;FLQMb8b0c
<F3/^CY(CSUKXg4M6#8e4R#+(g.TE67G@B@Q\N31X=]gaC/2Zd=Q9febQ+Sa>XdH
FE:N,:3[E7[cF@<:?55N(99Wa&Ef^O4)7G[;9@ZL<_QQN?4bUe;LA9/NG)PIF)/:
a@TW8D?>0VJa859^WN/5):/[:b(gP655G&Bd;[eEdcX6b2OQA^D.G9HGR/bM#&RF
.#e+/X:K(CLPG,;HPCZZFLJ=N))AYOGa_:DI69/3Bg.C#LZeA<8=e9[OY+FMdQA)
cdV:(J,N/[&O7X8fUgL;]JVBF;B6E7M^bVgFRQ74RWNXc&I)eN3D/=dBI6DD<BWS
gZH:CCB8eU@NdF24gR31<XcT@:P4eOMdO-Nbcg0^]^H,]BCCH\fX1I8VP79:+5;G
))>ISX=3HHPW5NEP71JHA>SK4(aaXZU;U5(>J>\<Q1H-;HF+U3DDQQKICG.0Y)L&
BTdXU.U[;+edCG3/5.#MFf&/J+XMPe8+=^?LGdZSNW=Q9E+I,MebbgTdW)@/<HPX
(0^ND;cG^@Bdg34.:QI1090e=<^a,IaEdN)43IMLIIf3g(&^f7)W9FT07=;_]g].
Y;2@ULZe^Ma3[bH;>P:,e3MSgORe3WMO1-8\NL<DTS0f>2#DL<TZf-G3;d0N_<cI
fU+3+b]N\_9>5F,MR\)TD_Q[X@3O1]TdW9\Z?]M]S]NNFZ&@H^Y;E^QEXPKJMI3A
&HUJQ)YV93[9IJVE8P;5T?(^8X<M?&+M?]BBQ^HbRMX,1=ebD6PN<+<?K6J?X4bO
Y0R:)XIbU<SEeONa;Lee9aHRZ#e\B233fa.<<<+c.aA<UXaIW#E)RDEeW&X\3AA@
G&V#BfGf)3BA8<^g@[_e/b3UF=[f@[^I^8Y5OTBNF[><,)S68a62_([);D;7OO#]
7#;0Q@#S3eRR+1fO>E:[Ggc@f8=X&<@&(_bbG+g7#b\T2N->CO;FfdDF/^C2V1,g
CVeJ@D[OT-+>(J&80]T:=I-d3;B)+d91F)I0W)9=Vf#D87M#R+V@g&??8aY3)a&?
Lfg<gF>P5J3PZ59bQ2?:d4G;RPg2N8;I#>RTC=]SZ;;b:Q<.U2\)0<;Me.RDS_&+
U2e.b159M?YM&O,SQ)cZ@6S[b7>#1X293fZLZ)0\4e<.CZG;N+GO_S7F6EX/N=5B
G(e,W0+d>/POI^0b^KeIRN(be->W^)B+]TcDI5</S/b0T#2d[^A1^:/(W/<^KI)D
0f<^AHS@O):&+K1_G&Z\-A?ZceHQ,9\Q1Oe22N</^gO/R(3_VZ^FaCX&^DQ\Rb64
OW<Cf&9bQIO=T/?,dWfHZ@UM3PW_?:2Nc1Bf:FB6._E?^V.]HQCX4eRJbHYLQBg]
5QWSO<<=cHL-1,c=DRHHYRC9RRcH3&4K0dVAP9UHB&(Yg6XU6K4ccW:ZFP3CM7RL
4OQU,ZFRMC5M6<R>#QJTY]HVUbVabZ@C.bb,,N/G7C]UJ8FgeR8T@VK?;^RBe<H3
W@eI@3TXD^.7a:X#=;PAOM@EXcL?=B^g5X+A69B40a@@/&#LSKg=ES?31U.P8I&)
5aCU=He;U-9Q-.Y<f/-0gYYZ^#AR[(9BM>Y@9QPD]</CVcF9VF6c8P;\(-[OAW:\
3.JQa-X&S>.;+E<4#KL:I5[IFca;+18]=;g5VB?<eK3b-#d.=69(aH\6G&PCQTO7
(YJQKQd:6,0Hg)WaTL=L[&A&?)HeET0@[NUg91+.fHRa6gF9eEV^fB>FPe+\f]5b
\Lb+A:.#<9T^e,<[cW_GG#g20&9R#>T;b<5.NS4]cRRa8TbdBE^#@?90_0QD(1I^
DMCP3>+1f7b[XfA]0]^Dc.,c5]LDI^V;TU\\D[Pf;VWT(R;UXA,e]&@U#/6NG7bN
;c+H^gNCK>XK=>ER0GE7VQaVC<X-2LRQ2R4OcX>9KOHe22X0U>DbT,NT#KCN.;A@
8\R-+]g=Md7GE.\L.^]bZ0g@^H;Y)PPH5.e0,dOad69J+AIZWfGdVS36IVOdIAGG
CZURSGOL9QZM-AG4]9B@:2Q.?7WA+\;;SdVDI#6,@F:WYca1fQ,PCL\B@FM7:XUS
(c9.OXBTW8HVEUdLEJ=&eCY^(-)88=)JX02WR5:K\XY>f6UI7I^E[e6:+2J[FR/#
g2(^T0Z9H/EMb\T;4QA:L+8P.4D,C6I5SB@1_0I,Sfg6+:GI9NH9G;^e,?A2XA4J
,#1,:X)dSEYC<[4Z_Z+AKAN6OBITeeCV2[>)#Bbd<,G=dGK9[ggJgT;&9C@CNKFc
>ZI]G0b;Wa=Tb9cb9]QY&#H89)HV5&/>CV@-70cHE1:,Mg1N4B6:aa67MH0UYB+5
S2QfTI0N/,9\HH=XDX3Fc.1AQY?-J;4W3;(S3F_J[N/\&d_[^UQ03)(#0a;N/V,G
[KS.Y12Vg]a4db,2U2/R-Y?fXK)R7YWKIB[A2gafI.PgF:F)];g<)g^-C9OL0/8Y
@4AB+,#d\L0PVUSL=?53#LYHN1V_D8?T=e)P:JbA,SYMI7>S6<]VS;V,>6DONS9S
aT]dWP=OSBBL>2HY_E-C>7c3<R=_XH1_^\B)VJ)<N5UHJ_<DQ:;SK1.M&2B)S;.1
DbX(SeSRaK6J7B+9R,]?6SaY[=GBHFF33<5YB.Df9\,H\+^1\WU5?RSe53.J83;Q
BIEf-N(1=,G:HJ/B2OS;4#SH4B>N5J3Q?<Hb2W\G+\,&SWH-1;V_FHUWcH]IE:PZ
EgJgFL>5@cFU(VI2Q1_#BYge,bO?aF/:UdFWW)(3QUKc?#0AgI;9(NUN^@>.>AF^
[cP=87\7@25F>BbAZU-eG(E/^\Ed&H\=51@)W^>2e3>Xb\aW^L&^L>.2E8IbLcDe
6(W9PZAB.)(Q8/N,[_b^HKbD]Eg8+8&O)NNG)@O_f\gC2(,RWT6JUa:Y]A(=+/S\
ESVU1?&\3J&1&fOGVTTU8/QKZ.L:KBVV2f,ORaJfD59:J[?4@T&d3</];b@d^@5)
/[-bM,bbTg9gY-_3<e(7<R>fab.ZE<^aFNg)MGS?&Pd\P1L<?>;LHA:U[V9MMCTR
f?L&dPQb2J?D95XXX(5a2#@KH=K;[3,KG0BL_Y-YY[9\XH]e/:HNPW4-B.0>c=#6
\3HJJ5+HJNPN-.22f&C(I:c^SV0@1=aG[E\Z1bKL@6UAUfbFTB+TaSI]dJYKVD_O
-La2f[#Q:;?KP54>K>SH#0b2EVa#N\aL>2B@c<M<U)gE7U[XL9WU[\2Ng:OJ:aP:
fFVcA79K=+Qg_LD;^:?C;VSW;.,f+Q-Y[=]79.9NDKH0>6UE/Q#LWI<da;50(cd-
,>?_82E\OHT>HRKBF>#,dIBB.;f8b7>L?O6fC/EQ0M4CXE\,?Y&:PB1XK,;g^6G8
3L:eLc)XS+.+R>P?1(T:.SI&D+d5P(=?3<N#G9d>7<[]A<I;2&UPIEdIB9<:-Cg[
R1b.;(/N?MK3a2[6=OfbXfF]L0/O[L[/a;KP.E2K(gG<A2\\EWcH5[/],1I]dHYZ
BT,15F1A21#<FU#8BCKB8I3^.CL1R<_TP;5VBMg.?3:BaFU5O5(cBV5.M--^N52E
g\P0?SfHKU@0:YOWU:0::+WX_H6b:Ngg)dc]WH;X7Ag<e.)?38M)LAcL.:E?A&Y<
\JU?+6CBDR+cF[WNb[+a2ba^eV#M.A7R-I/UYcK-034<PA0^eA53G_+7RUQ-+6?J
0D@-2@-#=AJ<b_#<@29dfWD8fHF#7:E&dL?2<O=?J#6)8<&GR/5\fGQ+Q73CV7e>
bC[HCI-DXb:@ZEB.Z?ILA]\4N2/EDc&)O8fcP/_YdP4eW/UZXM3G4_<a0L,g//4C
E;?a=UfE_6SF__>;-G?<OFeYQfcVMQHTTLPfIef]CKR05f?aB^dAV)BTaCEGbF]E
RVNa\U=:<GQ:/-;:f2:cgLFTP]>X]@-EI;G&NH1#O4ee4A[XOJ630C.>W7B7IRRD
1_e+=9AMZWAfE/MH:H^KI/@De\>O1I1YZ>K>5O\8\0RZPbY#+E1b0D.eOOV.<>fG
_;Tc,607e2K)f#>:=Qe>cJR:+EVJY324R?@MB/TbBU]AW-IQV>^(66>WeVK:-5XW
)&^4I+76(7)R?_==.J_)c01SM8U7=9aOMZ3;_&+X>0EE#g-5f.e&.[@Q3D=<P)0K
RNMF=R<FO[d>c^I4S<,B[ZWMVI8M&EGC9+@f1\B5[1Y/)>6K599dK@DCU30[(AY>
c74f=;f=e-@F@S)QKQ]Kd+3L,,^@CCH5O,Rf]_,aB2G9+[gQJf#)><cgSP/I3]P=
K.V.^E,F+FKM_D.M.<)]1+1JZN\LXM72]LFM1ID\YD2W&(C^[J0+MaGXSJRIU);,
(DU9V6=W@[bJ8gVg78f#&cH,a98PS;ZX\6SH[YM27b6/C;e8[G,>5TFc74MWfQO8
;V]eGX0+e864L\9XLGUUI2c_cfMc<7IcGX9#_7=]?_KcEDM^D+0<5Z5UH-AG8g3&
+[:gSF\2A-WTdd2+H:8N4AEUNQCE?daMBXf[[eaB=Gg_<T\L9HJf7;QbH)J&Q,9d
J#0f_>I8GE4WEW5:\^F+3Qa-#-WW5A:=D&WS^@-^W61#-?6X0XVZCA?+T6PN[PM_
c&b+G2#_F=((&0ZS0(gKZ5,;KY+QZS@HI:]LB.4-V4\I;9OTT,T(:gE[=9RD8ZQ3
0Z?__.=[].+\#,f2XMG4.#016WDY.4dUe-UTA\N7S12R]@=0B>]YWG8TYb13]c,d
MI_ES31RLT9_Mg9fYgQ0^_Y^2S<7@6]_#A,>N&TK3CC+<UKOGA&2/U85T4MY?d&d
@L^RFSVKHHgW7fOMW:-584XbZM72ed#AN=DY@aYHVb9>^e.E([OXSdL3<(,MbPXd
F:F5^.]HNE-(dEB(=KR>F&e5&4S-\6LGF&\^#02^[2?g0aTA1#1TVbR??D&Y,R9D
gBdY:NAI4;JY@96LZ2HO<&?P97<\CcS<2/F2M@9c/F>A?W/[#6_dS_g1;JV\fIZ[
\b[:LZRZfDbSG<TT&eccF/X6ZCd\@NdZ2J)_[J@7ARB#/G/@@@V9>#,-[.BQQC1-
9X6e09#JUK5QKP@\?D/)UObcbWO93;:c2Q&>-D,0LbcN(-e@)c^>QG87.BI+&g]_
#Ng@9H5KR=gX/OA&(d]M-@GE9)dY?D++aODP#bPaH=PL_Yf>HNPbQA76Mf&.)bL4
KTTRRF3.QV&\LRW<CGY[H&_1K3MS<Z)eLZG(\81C#/?1F:;Q;<]#68AH/FW].-WF
)Q:S<=Z&X+VZ\ODFT^dR&:=\f34/)T&DRAb.3KIV+db>/gI=\N:I&:e^4#Q-<K]X
JRUg/-,.dN\7(T6e1TJU:X4AI[6a^C:3b&3HbP0XFBP__WI[[S8@:ESS7:_G3&X9
IJ)[J:9I_D^PD0CL.+EN6T431a/X5J4>CG50N/H8&M^)M#b,<0W_)K\8V9B2(b-X
K&)14f3.;I?)&2[gEU_CVe<SaE:5dJBJBLf]:YAWA4:T,6d7G&&>R]H:,?[RCQ,&
UaHR7bHQJ8WA)JfV^^DBZLZe>/VTSMfEQ7W.+&[@A&=DdJK&b.PG?7-LVT69HL47
J:AW7-1ITCLW_Y\7fF61-+04V8a=G6IRZc(cV[.,_3JJ2S+3YDQ5)e.M/gDAL:aP
;>]NTDOfZLS\fV8GIU7,PDJETH)C(YV<BdT,BeKSe9XTB7aCfSggb95_NK<Vb,gf
4[K+:A5a(IR7g-/f2G4I#PVF?FNAg0EMJ4//]ZX@dAc<3]Q=&#e&G?gRbBL)4\fS
LFEeC5,=.09ZM/5XaJYI=2^ZK1e2ZC4:c6[XdIE;=C4..ZdH>:]c,dTIUR_gGSZg
(8@OM)cZ6<>(D-VWR?4gE,JMO]9?Gba]A_bc=8dV,X\bTXI1gcHZEVbL4A0-.Wd.
-&Sc^cM]eXWN_G98\N1&)I19\I,H^NUYH+QI4CJS6OGf>&e#-LY=E&2>3\1ER2;d
b<LE)4B@/8K&/)Y[:2b&b3HP.O;0[ZX7g4OWaAXaUQ5O^+PO=,26@H7)3M^^O)7Q
NT7=&bY.0,gUM(bZ?Y9a3Ha9,.\dQf]M7\AZQPZ<JGMPIBZcL))b?T,5QS/^9.(b
afaQ<#f[.aUM91V#@\5W+/a,>?^B61>T0XI=c[F3.(MdH,ZW#MK&^\&UYc@QA5@9
EO<,H2.K:U(e&gdAR.BNXD-c;6e5+VVAa66DMZd.A+H(BH118N[<Q(N+;.>gB4&\
UbALTeaQ7BE3\f+/^BGN2IW85A<OG8)T9\3.>R2M=eMVC#HM.NI(D7T.g=3#WZSH
dS6e,C.9#_Q]?>&?X0<U&F_B./4(=/&H0dJaTA84V42M7Q[R67a4?1OVc@;R?B^T
\f]-47,K;0KD>ef^G4b/L^+SY+OTR<21J/Jg.3gJ7(JH4\F>&9]cQAAY@Pa6\<8<
Pg79T?1<[W,d/Q^2-K>/.VH@5VHM+46+3Y?C3XBCBAOQLCYF^S@+[C2V:/]9@THG
g[Q]PH&,Z59VWNfYBZ)LP>9MN+A;?;]?OHa&[Of7[6&ScXP]:3WWK^YFdaQYI46S
U-F_EBXR_e7M6O;+[cGVOZd9&Ff[c5&J[)CWO/U??]OB/R1A&a+fS6+Ib(ZO65JD
TS\0Nagc9;aHT;c1Z@AW5R]6RP(6PbaTJ/1-P#+B+G31H#A0R-LASJ@A2>_&dX+Q
:_]SKP?Sd03^==XF-IXM8_-2T0_D2M,EE;>.TRCAgdd)8X3U.4?D\eDcPMUNggCM
d()OVV]Q,_=8\9MP)+2]5O;+/VK.+#aQ-9ZfV8<T#5Yg4.<ZN^TJE:f=VJ:^C)1-
1eYZA9d^O3C&W>_P_D[JG3+5dJ(KINa6+C#R\d,_\&e:HND.-XHfJ/4.38Cg7C#?
TTbVN9I-O@FXdJb:1&<UfD^e\/aE8CV?0US4&+?L:&C#.C\#F12E(g(9:-EGLP.M
#89b&cgGGbFH_OIEBID&=JU_DPY_^@PQ0d/?0SS)>DE1OO^XCSPaF+09e,&4@)3A
EQ7d@FeTW^F8@fI9_TZ8KPS/.)Z7I\N=H[Q3M/HBE]CP<J?NegMRdJE?FVeF#G=C
Vd+1YFC<X^VH.&3:P]/@2@K_.IFX^GL#H:KOD(P<++:#4/AXGc+J.T)D>XEb-CQ<
[Gb1,CC>-D;N?E,[gQD:9LYgN#)JQ3C)[)d&_BDHHL(gCNAL#b)Q=ML8&-BG3ZY3
L(8+L)XO?0Z]1E<.XLd>87.B+2;+IZ8@#:B8>+M(fDXB?,de.HRZE1/;6W[EXM/Q
6Q=^W(V?2K4Y=;EO30\EF>OM4fZ..WI8\>N14Y2G4H-U@6C17bHT8H-[Y/U_Q1;Y
f)QXXAL/)SU/V\4P0,<f+I8MPQfSSJRNBJ?BG9TCc5LYJ+8a-cB(T22)<Q5B.1R&
GEF#A[ADT;L8Y]gYf@3LT4ZI\GCV56\X\)e=U;0?W>VUc9TIT,+#W44=+I=4(+DC
@W_d;750H,4)P&-D,,LKBdNKg1gR4KX#3^IgLT2+MO?,5:AHU)cB\aE].1K-;4ST
ZM)gedb<TJOB;W(_.77]JT7=Q:V+04DL>?0>TO/)TB4D_^9N7Q,/X<U72f-aD63U
WC_W#H]]BZJ5ZLI:8A5EWT=BX\c3f?9c(RW8ZW,dD[7(X_O.[B1>_4QH9bZcKcTV
L]8eCX2GBQ7^0-Q5(cY\aQ<3S_e:JR-g3JF6?Y)Ee\aZ7+eSb)6JP-;O@P\YA-^+
V+CBO732T[H5O+F5O<.9FCP_/>O9V6Y3cGO&\;;aaWJZg\HMZ\(G#ZfFZ>8Ocf+L
]ZPW5f7L&:4cX3#I50,@\gGdA+gNFgRQAf8\c8(?Z:R[;HK;,[-H1f9_[Cd/V87R
W>f1)3NA)@g^/U(8\M)N>R+C^UdCKV&fcT>G0b)WRT)75D_UOV_adESRXcX=,P2g
ZZ:BF?d)QF@aUW?X[1^f)f^9&_6\\<HcK)X+cVFdG:,\N#\Kc8/_D7@Cf8V3,c9R
90b(-](3P6D#ZFNXB<cO:Q]),cWfID5^FSA1#f0.I&KEXU4^[N3MA7JbWNOK\?UC
C+3JE#MUMGD()GS6ZOJ#3)\e3eN#.ab&\DfS63RRATZU:fSP(#^H;.HbX?=WQLUN
4KSc4<=.J:&M9E>?(9/C^YAbQ]e_:eg)cF21F6H(/eBVTL._,f,7d)4g_3agBC]J
0+aB3,(T.Sa+@d7GG)GKAYMD8Y8S4EEQI?.ZV>-OTPD>M-E[OSP2#B(UE[Y.]H9I
-H(]cPTW_]U]#HaABf?.PKR+5T?5fID4:BUHO_B0O@A8)EJ<NCK<JG[O4?JR@#R.
UQ?1N#20N8]YFY/C&J0XGN@G)/\cK<#9ZC9M\TPV[8;CQL-fgN=HR14CgF>W#W?(
K=H/[8;?T^J2BRNY#\>AL^HZY+,#L;<R7Z9B=-Y-BA4>Qe7d7N<Q&57#4A,RN@G/
EH^WF659?Z^ccPR]PODD2Y3[^7f?\aOZ7.1964+SNaMRDdH8N@N5&8:<TH;[G091
QCA:P(WGL#gfN_LDdIX\@--UK@RAZ#d<8M=5;ba1/@fB(6R6a6?Q@UD-33_=0H^>
N3IR6J\X[K)UHW]Ba&D[>f/c7Od;f(D^<G9F.ZN<a(;>c:Z46,6-d@T(4Zb0b?a[
<KIf_US#U-C^KQ9Fb-g;<?Ka2JGU7F/53RJ-B2Uf8ffF8d.A2H3VE+#S8_XA-2Z=
RB0:#Td,Le4.=6FNCZ[Ja>VYAL_&bJHf11@70&Ob6W@K6c66<Q&6Va;F-C\J,eJS
\53\8DGCZXYT3X:VfPd#97ALf&bDUC9[V#K87c:2V?X3gX,JYM0L26@cE[fcg?/(
AH+L#d]MS4eJ<)L-6S=Y,L1bT#>^OF92&39d#2(8?Y:>8.\abU5(W?fYRKa#=]7<
>5IDVJ25)R[&N:/\/ENZNN@PTBc+/12SLbG^+=L8+LI@M0g#CB2NV@P?,MJ>;;dF
,/]95&^_5#E14(T)(e=(6;(S;B@\4Q:XZgU++PCWS[ELLZ-9ION\+b^>-=25C,#D
K31Q.\BEWc&Z[@&=M<F#[CA0W+#Mb2PHY&-RK(;RGKZdM8><L8H2)_+0B1E<RWGU
J#@/gY0OT#UD:J]D<WGS77&-E=<0ALB)6:]DJHee=429=,b9.Y&<\#8CV5:3.6UZ
DGJ-\M<)V#&K.JXNgPE]YJ1fZ>)CF1ac7?T(PZ_e6W5V9^3][S#gSRP&S5CSTdH\
PPH5GFEH/.F+/fO4Z?cd_L5(aQU0SYO<<.^f=?KEG)W>^eY?+d@8=b&/R;MTbU[/
2:L+O5T=-0@)DcMJ-&Z9[1f1F\JJCDdO4&>@[6e<2-\WE5-ZIa;eHf3f/.I7CA16
9CDS7]1UdSY+d3Ta<7I[:J1,T]=aRQ-E>LTC30[3f_38?NR1M[.?VaIJ;0K=Ra<,
,E=bC\TQ^Kf8186b_CVfe(eEOWH1VVZUJOK9NddS1B(A_;>6<L,LQ:GFGD6F;gR=
G3-;[XG\X9)BW#cdO)S<f+BX=0bd6Z\fIKCBIT]&2@2G9^@,(91.>=cBJGNcZTYH
UC9+B\??@E<J10eYaK3Q0CPB7=:IQ4.cgc7\5>[cH65F[cA<3.XZQ@fDZ0f@TE@D
3IaB)JS=BFA)gHQ8(>I][C&9CY?=FKeM>UF?Ne@-.^KPO6>\]2.Wc1@.L/9@6C:E
+K#XSQ,IdSM\L:X#/.]5]I\C&E3LUK=>A;QM:]PR1aIEYe)^#RQ?6;09[<J,MR5D
U\V#C<\NR_fB>7H<DaL4L(aY>H+.Q<M7d7PBX[99WG\)=KOZH-0_9aB-B[SbWJ_7
?-,CK[Y6F9Y\Wce-G)DVefCQ3bV/\CZd8V[A.W=JBG[8-C^BLcV]5e;c(]?.5U;H
0->/AJgMO+&JQaBec?.PSU0X2Ogb4>W746]@bJCdLB3FUQ-00JA:EE460;B1ZO:S
=06>GQ.=PYeEQgd\\W:gG3_Hae&UG/a;\2(/QeO>=K-6ED8.L]#[;c59+-7;9Md^
_2(B<2-2]PC,EA8O:g4=a&J[T]BSW2IY:>K+MW(>C/-5>.DU+08KF7cG:MaM,ZVO
)C6]P8>&\M-Ng6N8aE7e/<5O8a[dAaOdTRCSc@;17g=H\0VS1H&O9+8-,c-:6TX@
#RZ-f(PEZE:#LD\HY17JB)[+6P&dcH@/74URJX:&^dMDE#bXA5(;N[EdN7b_&=MS
42F/:A6\#&2JG:4c6<SY:TYOOK1cRUJOVF#8_8b-#2R&gPN\PXWAI3AgLG;ZaVFO
)W[_\QgC,+gL0\_+c+.Pg9FN5bcI#:B_c4M;NYb7ID>-gA8Z@=+2>0CS-H:&GAQ]
ICL8647.X.a1^,(/EZTG+TNIVT>ORRV_FS#Ra_BYC-7>X;9<d9&+UTXTT342UZ0,
Y(;P5a12L,/S\=J^QA<[GC9OZ&?17&WB0XJ_CFH>)(C+EPIfGAVM)9\e)L;STS]9
/4fV6Pa,:CMD7Z)D^1N=#Xg=#dC26Cf)eWEe8&BN^Jbe>=7f\U#&=^>+H9B-ba,7
34NU[_gV=^)^<3\MA1LLd&JPFM+6VG^FU_F4^0E)>5IP6c7S+W9.P_Z5c#ZPF#5V
I&N:IdL.E(N=W#\N3]EP76L#AR9cM)B+eU(68KdECDV7T>cI5/PBgZ=K0RQ[T]EJ
DMXB2b4IIILa:Q(5#D]8AaK(b_gLcAS5KI+((b-7_9_7cM6N,^W4Y[A+DdT<)))>
JdOV)5^GI.7=83c=f-)LWSW-ZZYK&\@I(HS+-fYU6G3VF,-?&PZXL7UB0=)&bSTH
E)/B_BM8+<:Qbab-DQ&[#UMF4.GYK#^K47A9Z^[.VW5VH$
`endprotected


`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
