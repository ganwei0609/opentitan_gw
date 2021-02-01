//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRANSACTION_ITER_SV
`define GUARD_SVT_TRANSACTION_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_ITER_TYPE svt_transaction_iter
`else
 `define SVT_TRANSACTION_ITER_TYPE svt_sequence_item_iter
`endif

/** Macro used to pull the data object from the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_XACT \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace[top_level_ix] : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace[top_level_ix] : \
  (iter_type == TRACE) ? this.iter_xact.implementation[top_level_ix] : \
  null \
)

/** Macro used to access the queue size for the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace.size() : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace.size() : \
  (iter_type == TRACE) ? this.iter_xact.implementation.size() : \
  0 \
)

/** Macro used to figure out the first available index */
`define SVT_TRANSACTION_ITER_FIRST_IX \
( (start_ix == -1) ? 0 : start_ix )

/** Macro used to figure out the last available index */
`define SVT_TRANSACTION_ITER_LAST_IX \
( (end_ix == -1) ? `SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE-1 : end_ix )

// =============================================================================
/**
 * Iterators that can be used to iterate over the implementation and trace
 * collections stored with a transaction.
 */
class `SVT_TRANSACTION_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration is used to signify which data collection the client wishes
   * to iterate on. The supported choices correspond to the collections supported
   * by this class.
   */
  typedef enum {
    IMPLEMENTATION,     /**< Indicates iteration should be over the implementation data */
    TRACE               /**< Indicates iteration should be over the trace data */
  } iter_type_enum;

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** The base transaction the iterator is going to be scanning. */
  protected `SVT_TRANSACTION_TYPE       iter_xact;

  /** Indicates which collection should be iterated over. */
  protected iter_type_enum iter_type = TRACE;

  /**
   * Used to do a name match (using `SVT_DATA_TYPE::get_class_name()) of the scanned
   * objects in order to recognize the object the client is actually interested
   * in.
   */
  protected `SVT_DATA_TYPE              name_match = null;

  /**
   * Used to control whether the scan ends at the name_match (0) or if it
   * includes the 'trace' of the name_match object.
   */
  bit                             scan_name_match_trace = 0;

  /** Index that the iteration starts at. -1 indicates iteration starts on first queue element.  */
  protected int                   start_ix = -1;

  /** Index that the iteration ends at. -1 indicates iteration ends on last queue element. */
  protected int                   end_ix = -1;

  /** Index at the current level, based on single level traversal. */
  protected int                   top_level_ix = -1;

  /**
    * When doing a multi-level traversal, this will be a handle to the
    * iterator which iterates across the objects at the lower levels.
    */
  protected `SVT_TRANSACTION_ITER_TYPE  level_n_iter = null;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    vmm_log log = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param reporter A report object object reference used to replace the default internal
   * reporter.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This creates a duplicate iterator on the
   * same object, in the 'reset' position.
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
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /** Access the svt_data object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param top_level_ix This positions the top level iterator at this position.
   *
   * @param level_n_iter This sets this up as the internal iterator which is
   * working on the internal object in support of the top level iterator.
   */
  extern function void initialize(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 0,
    int start_ix = -1, int end_ix = -1,
    int top_level_ix = -1, `SVT_TRANSACTION_ITER_TYPE level_n_iter = null);

  // ---------------------------------------------------------------------------
  /** Checks to see if the iterator is properly positioned on a data object. */
  extern virtual function bit check_iter_level();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
^K#G@P]#dFAYYNA[]]I)0,EgQ.>_\(YT(f/<Y(\?IS=?/BK,]J+^2(YUZ5N6H6QS
FEKB_(GH.SEZ(a0+6(bZLN&S2AS1CO=I#_B_d(L;T2[9012N;aTT3GK^SNaVF\2>
f>Z],]234,7++eGa?D/2XS+6(&F5R.:\0HNg013_(+-JM1IWUZA:EZP/-V>QCDg>
K_2<TGTc@224_6;[a5J@D(NF[\Xf[E[X@PP:@)e(H4FSN2ZV7(@2f)/1G]S\3QG:
^d//dEeEDH2<7a+E9Q6YM(ga.]+<C0H#9c<TBA7^?Sf-N#>\RE@E2U6.Yd_KXBb[
65]OK6Cg7EJeN5J0VS0gCD9[DEX28DN=Z;>CJ@&Pde.e3bK3)W]?GfKZ\0TE23Jb
+bI[=AT;I2>K<(OZ[g8:X(;I0,XZ(++fL[3&=cgA?+.E8C>-)].B/b@Cd,X(AV.g
a88bB-])f-;S2O<5cN/)LT]IYK4POH>#8aSAL5V1B<]C;I#E^Ka.T=GP8WZ5(Sa7
LHZbN=>1@N50&_(#g9#A[OX]N#(a_NF3WRWE,gWXQ)?4D-.bI0XFM?HDL62_f@81
&ZO7/e_P_-A@+7PDgP4A14VE#[=OafWUBX./#A:KBDNZT?e4fg(SVZM7G&T+J?Z/
ZQ\\PdV,/e1M5LY1aOD.6@\O,6&&@5@I,CZ9e21&NBN\F4>(gB4M[QaY8.JeIL-.
L./Pg9:29F(#2JU?-R6QN84YgNG8c0+^5BWAf+5\4<)Ta_Ke41bCG42e0LY>EMH]
(aWD=H_(dUaa3=<f=Y18d49^J<CV;HPcMFM,4>4)NT8+0;f+>@A-,7?9@XQ>Rd?6
R)g>346-#-2BL0g2KFNX2Va#:3<DOIEabE@4AfUHZ_Df9\K9H.b6ZIY@G]c(2a[0
.@SDW^^93TfHcC9)1Z&_Q3CE8,_RdeAae0HH7O@8@e.THR6;19c_RWFL3I7?3682
:;HR7P?4(F\;F9KW(.^_&DWPFKUBD2Q\.U<+-HdE??\,MB?^7=RU62/Hd9#Z,b,5
A>&]=[Cd?#bc+[De.N]Of:G6H(GT8-[2WGYeTYf81@c;+2;;M,/CNY?A(c4(N^KV
?E#@4XT8U?-4L0LF)>_BKX_B,TT:]_0V-+I5R;6+_c_]=dba-IHZb>>I^f>UF#,a
3@>Z7FG7RPWK0D@:+M,&e&5)#A4O<-<6#0g<^]@+U:]VR\J>SI@EdeQ_JW/A\WR+
C58X[SMHUKA:^I0N:Eff/f46;82F:REd^NA[=O<PZBNJ5:[9eA=>1L&M\]f<PYK^
@<7K1>R+a8SABUT8F9OGe#YP?RG^TX_7MYf;2D1BN\&FQ3UCQ5G[#2<1-@OA6a=D
7B9_.IN-(6L4.LJ1_Y=F7A2Hd+66S;B\M/U^?6RH,UeD54?VFDc?PJ0U?0526X]5
.DM9.e\VB>JW#GSC0IL,]<^D8B5@NET_EK[:0#Q@U3]P+5CVa;]eGPfaW&V#+[V7
VC;7g;727S5Be9\N\_eE^]6-HC:Kg9)5WD-/fTF\#aN9#MVB,=_f;#.A@UCA\^aM
-]ZOO5AEN4O7QV,E/W[T9+NU57SA;HVCD501>F0H1B:CQ8F;4JAc_O=8HA^ZK8VM
.<^K/(@6L=b45fCI7A]L1Q.ZJ@))Dd;X2?G5[UMJ+F:T]aNIgPdaH[dQ-4VMSfZc
+&>Te;8PgGd_9P?B&aQS?PVg@9TEBJBbPD6/^:;1Y5UK(TeZ[HE](NLS0X@Pe3[1
SIb2Icf-^KAgP<E;bO+.V>1IYgIBd1V;-WD6)H)S0:,aMNGNO+:.ENNLA4/26#SN
FAeX:,-N_U?7M7b,,#a67701/fB,BSLg(1H+(_Z+e@B=2+>VNXc)NM0NHW.dg>\^
T<[De02K:U12P0Nb85/S-VX8,Fd[A0TO>gfS.bbad#[N^(?[MdaK#<FJ4,a;EZ,7
MJXHO[@&g8YF&BG;PP=QZ<0dP@)=#+2RfYCPL]Y4g7<c=e,[_4[36D3;S+(f@Y:D
((B[,EXM?g5#P#SINEH:I[T+SgE@[,_0Jc-28M<,]e\QM/8234gI2gE4^XV<Y\cO
+Qd6eEDJM>;^8IagR[6^-]5^g#LA7ARUdWT<BO6N-V?<Y[2Xg[1J#W_c_3FQ@[UR
KU<06Ad,UPIc_9E^R@G1:Y=)+./E\TW66ACLg);.dMI56eB1M\ScBL3[/LN1LeG8
EGB)aQPCVA--B8>FE7FOJ&(FEM8aAUFe@WDI(#0WeMTG@ZR^>#[PLS5ZOA5=)_K6
K2<S:)[-WgNRJ&I-X?Wb-X?aWFK0DM4+CFT9(RY16c2FGL7?@/E51AZ\(AH,8<GD
KPJR@&TQ^,H7cEBI>_4^\ZREK^^1QEHJb]IQ_@EBV6;NE5LKLZU&]@_?FRM8ZDS\
)K/3_H>L&2&Fa8;c;4Hf?:X[;YR>.O#Ya(<aQ7ZLA>IXL;)_VRT>1,Ne;;2:P_O?
VXF?_+cMJ,?K^H;4Je@ERWe7,e?)E?<GZ-LE3-RMgW4.+[+B?_4b&9b</NM9=0WG
FUSMU2UdL#]_(Sdeg\>IdV-?9E3gMK:=4^,JHT)LZ/N[)#PB+S?9&]Kc2@(A:cd4
;52QT-QG;a7Y\-;9EN>_H3M17-;K3MFgM)M7VGL)+<BN\X-UU#XVfDf82G8:eB+U
L>?-\b&XS#>f&#>/5VYd)E-GBP1:24IIM4(+KR[X0)Ja5K9+-e6&Q#Z>\L],+4#X
>D:D)1L)&K#0LFWLg?O\^d)IHa>?LHBXCR<;)Q@\c.G0<aNI3a7fE@\+a-Tb.(g8
7bJB9W;/)BS>&6]D@[;CU<U5Og<Mc\G0#;-9fM>>)<fUceE7Lcd9Y<H6A(S7-&JV
3gEb,O4RTB1&KJC^/IECDcY7egb7Mg18MJL7[DJOb;35@?4G.fAWEC,.D,3b^e0N
L;:--Y,VcW+dMcC1d6Y.8-&OX2Y\/QXYD)=d2&KF/)B\;MD:#G6d:KH4PEc:N8J-
NWT.UBeI>0YeT_?M^4&7P0\(=CS5QBI\?8I^5(>4NUJM-GQcP0>+?D[[4[c5K9+I
J[E/7(OJ7&9dVB9a<V#\c?ZII,4:=cU+_aKc),O3Y9Q/+F2e1,Z)4Le?P\fSYZ)B
QFU]K61NNO-N3&VX6F0b<@:4@P(5M.8:,GH2@8e8_Re^6b((b8EU.Y>_8/X^&3YR
X_1#I.U2D-52gHO3-@4N?&+J<JHU_M4(IPS\(<U)<T<V93+afH1:VR.3W/.e5\LX
^La;G7T90eU/+OSEdRE46,f]Qc)/V\?D^B\VF;?3YH[.,4)AY>VT4U@U5WDP9+^M
6gJ,<H9-+FQ3>,Vbf>d\Fa<V,Q\O1f&?4+TQ47g__:EWB2.?JKL)=6V[0aX#XK-D
/2_Z@DWcFe,2cLV;::W+G18I]O=WV0?OP3;TJZRG6b2Z>cAF[M)8?AZ1[<eM#Ccf
WFZN,Kd,e;9]85Sc;9#F2)BKT_N;:&eC]HQI&@R-ISBW8IEQ67M@SQ\JBFP9/V9H
2UUZBBgI[J4R<^T/gS=ANZG<YV58Q+^BU63)EKTg7dY[TM3#c0W:ES;[<cE&#c(L
W=RFTU3.A4950?fRgJ)^_Ha<C2gB\MT_H;5=3(FSW(P#PT=;SN63N>>.414:+M)a
]KU8D2e5dW1H:<c\Y&=M)\M)WFD<H/[YM&&fFLDNZ];B=_C6]>R3<PcQLfJMe5:9
c(?H\])aU.MC@LWK?@>;#eIXCIA8^(INOH<W@>TK=<eD>E_N)N6Z&=?[O_.BGS2f
fH#[UAb/H\()^1f>8B.F7VPUb.=C/;FZ2V8O0&fU]R6gHG2#^QWcN1-M<EJMU+P>
8b/Zaf+L7([&XMRI5,;(8MADH;AP7^MO8UYf_GT9__]E_Ya>8?X#16b-XQZBU2<+
Xd;MBB)TKe,LCN--Q?#>C2,,bUS+Z)&JRJ9#COc\GTV<\BUe5T/V2P8:/+^Z8[PL
C=D=GKYb<=cH=IKS=9P9)B:[S1.3<0.J6N)KF3C/SC?5FZ._@&(Wg?UL6]9>fg_[
G5IU0?:DA>JA8g4.2(fBEMCLN@/[eZTLLSZ,Iae\M:S3>+<fdO\-e(a9b@2;DdfW
5R7IPa9S)^G_T?P4A10;+0RSg(C.K(QW[JdZa#f;FE6JKcde]d?Z,E8aRRLdbf3[
X4B_YNB0fVg+5I2C.R8C>&[3)X)GJCK6LT[3BgP+];LF5ML28XPKC59fUU(6?A+g
:E,[ZN(6^KM]Ef9fE3-f#6MBG\T(#Ig0/WX<?\7I3E-41.9Q=dKf,JV1Z(29B(.9
\PTA<aU(LZ08#\T]85fJQb)X/X@9Q^#O[\KY[>DZIW:DI22+Y@Q0\;5(.JdKY2B/
ZTE+UJK2(0.5K(Z#c[Sf>]US6]+>Lf9+5B=IAS@RC\bTMS(@OGc@6467:_?e-CH<
3-b:^S^>/e[_e3,d@,=,62a23TBAM2E&,gPQ?BNO:;DUWFN(O+[Y:gR3\-S:\HQ9
O04F1/RM]_K(I/FO?8C#JL_D6aIUP\4]75&H1NNY0&/\KZM6XZ=,DZ+?X_?bEI]G
U&e^6cD8_&#<IaS/AS^)>?/AAC_L+X6LQX?APWU)@3f[D0F66NR\B[(dC\Q<1ODE
3SJ-(R]5#Kg)JgQIJfPf>+Ifc<3^8Rd=fJ:YZT3?GGUIA(+?J^GXIGIH<<VZC.-L
-E\BgPNG/bV[(OM>bE<LJIEZ\N>+(^1WF492-N,I4YDRbfH274Zc2bg?Y9Z0+\?+
O2BFF8f40G04PQ+<SN1KFHeV:;^37&D#8&[?d-fZ7b[dU>^L7LL\LE666eD^&bTF
2P[[Da;ZAW2WPCBN]4;9_ZQ;DZN]eF?eT;ZEPY\(^.2^H4V,92+SHKQ7J#;IJFAW
95V+bMJ3@E3:YB#UIGK1&#[E#KT8#ZGO_4;(9A+GPK\7]7=d,+S_PI\K@U=J:_7_
._/W>VL(^;fI8HUOCW<bTI/b#EONH9DYPaCJRZ3d#,->6-U.0E]R_]5gb?/D8C3Y
<aL+SDH3D5_DS50F/R:OgCb]8SYSXRc.8>)#S?d0J,NFNZ9R7<&eIX[[XMWS^1^e
+eebNA1U=).F<+;2RIN2B=eK(;]L;)W<>Ngf8W=bf?bKJ/XA)BJR8VHPE.SOd#KS
2J+.?KWCa^<PEO?T4M#S)Lb+&g961).BA6;RKA)K.E+-?)^3+)ZbWY;WGf,(DAQX
(I5AEJBf9<D;L@)eC.S/Y,=P13Be_33U@LVf7U]MCCLC].Y5/G5LS7I;#>3>/D[X
#g,GB5/YW4B6IPO18gf<M5=HE3N2&4_/)5.J\SF[ABME;b-HJV)#FUbB_-gAN9WK
LQ[QK#LG)cg>M&G_gE@0QdNO_&CYDe+L>=S\Y6gKKRCFZ-HTN\b\@:;FI7:=T5XQ
XW[f7\48M#/SH:;cNJ0.DLDDDZc]<c5.&0a=.ZY7+=9S8X]7S8:E)[DK-<0eNf>#
)a:42IC?gG)07+aS]/>N0SIZ5QQWTK)./_5K^dVXbRJdZDKO#O(b?Wb=G.MD-c]8
N?&_3W^Wd7[,@3KV#GU]dMK]72[F^9HNAZ2FW5NKQT-Og#d6RGV=D\L:MB^bJ/0O
Q\fgO@SNY>]ME]O>,N(X2QJ8]NOd\G0#deO28]W7#^SLE)_-?31Y,SQ,:#3\>EH_
3\A?_FfK]_R2?MI;9SJ2#DA_1(#RT17+I@3QLfWK^/AcI<XcQAPL&f6HEA>cRFI8
_0BJ>:?GROL,7;Te.cR(fO1L^RcK[E9@LOSKJI/gZY&2&cg6]ANSQ8=M_e_Y&UEg
22HB5_dRP?&&@(BMf7c1bD2[CLSNU_:8[F\bPgN>B>e=1P<F5dXH(NH[,d,WK(4Z
7(a0DB\MTR4\eO&8KA^L(6G=R7F6]Ef(15.Q-&BU^0gJNNeTd)(S31I?R-E4PQL0
1bCGQ+H?&#B41Ue3G59a+gXJ]EYb^C#V.Gd<eX8D<@H7a,8<4-PA@FRUE0ZIa<:O
L+c>LeV0G@B,]FX56;d^<-3J/ON)WTY[U#:Md?51PKF^If\fOTa>gNL]@WO,F+e]
,9\3.6[/R/J@,FYB+a;SM#D4cX?b]8a#O_A=H[8,9-C/5Y[aKUBQe=.YEWE8bK;>
<Y1a64&G)J7S;X>/D)/9,B]e-ML2b6A3JOb]eX\;PKR<+@E=e)WgSN+1Z_/-F4HN
<KVL/=64+FU7NF1b>^+LU8KIfa;)/?Z:LDHM#,V8@X,.Q;C0RdW3bdEd\D:?aeU/
NHW<.)=##5<.9dHW]+YLg6QQVd;UPBQ5)5E04eO+)@?W.?2DXFPZ+f_P5gSN,T#N
eV=a+eWQQ=1KDgF-L<;RFYR\Cd9G21(V(aB3dCEe29.a+PB06K]@IJ6@_+EO&TGa
GO,]0A<((@fbK>JO\Xg&3+#0&TI;bVWMJYbgF3+Z;_g+<RY8a\+KFTI]fG<3fd[,
8AH6ZD]d/KMR3EVBgLIWN[_eM<]dH:ga,=J3OOPf:d2-D&9-685/TU3\bC[1N^0B
bK0=2<ZU,^eR0eL.R:BJd0MeDF&^&If2gSY]]YaLM3;=&IW2f6RbSQ0MBfe//GS?
SIfR#C)eN-36+HP\W)d=B;X)Fa&8Q@Q?F^=:M+>Q4H4>Sbd.[<NLK11UL)M5]O?.
.8<]f^<=6Jae;Dgd5/NN&FTd#P+L3fg>UZRHE-6FDGIb9^CS5E1a<\42.9bfDDE,
?f\9:A1G]QWJV^_IRAbP5A4JT^EH4d\(\6EdbN+FNc8]VK;Y;#N4]/6:>7,XIFX7
2I4QRR>E-gHM3EgJcK\=<X1_<O?I=.5J8BBN>;LP/ZIeFT;KOO(FWBD8NM(N?3eK
M@ZHP8C?5\>AgYIOWD9_(E:ZQ(Oa-eEVfCCcZ-:?I2AgJ>Q#]IOR>CRQgF88S9A.
HE@d#H.-;9C2f.EX9P>fEO>C=^WE4WS^1>9\3P_44[#FPMbgV6V5,9e?/WV(UA#c
NJWB_+S_]-,U8WegC1c[gNTgSF?DGLYQY7_Y@2V:1N,XS9L0=<E).1D4_+4HG]6,
BaN(K>4D0RO8K4N9gZ);K6Xa+cb9HE?,4@]:OQJ&&@-dac7]c(FLfLJ#JT\UL&/Q
W?#V2]7XDQHLZLW?O(f/K],8@J\.&7=^3Q6F[&O7:)IcK)3gTE70WB?S2B=IQVPE
N(9Ad(B21;I[226(84gRFCV6[7c-=^^PPHLg]_PUN:Qg;?eHRLNSeJ/2[Qc0XB<?
B\Y?ad5C(FHW4B4TYGAO#9QMV.b?=dF&>)gV0Z5)8cE0.TX-0H<[PEb<GALKLE&9
0JGc+B-C4]/_bS\3NC_f1f;a30#U[/bRLP0bH<IEO/)SA6,T<C^1cAeDCQ+DJ-)T
SH.J&S-(K+b:/@JT[K:[(edT.@)O;E;J>Q=-X@])]5(;af>L;N28:H;-=9Z7;bMU
He9e^6T876+2=Q40,9,VC(_8_&fTL2V&f1=)1WV;85N\H&d1d^O3T],?S_fP?cS(
Q<(400NE8^E=8cPATc^DTYHYd/b&<^NOY[+HBbF?LDRY].gQK#W@@9&K#8(e[EDH
c3b&Ud/g-cIXT@NX3Dg-<B<CgP&@#/LE#8K-5&MB9#BgF.AQE2Tf;FbYb#AY8.Q_
FK2@,-3e;.b46G?IgG26V)F.+fN<5eRI+)e4NHX&c+d(aH+7I^NPI&gM)g1\(DLB
BVD;U]D=\[HT]:g:7/eN=2>U.a0;)/=+TPg<@;<,cR7JT]^45OdZS<](^acC\)UW
381bL?D-dXTJ/99=#MD/Z2;Q>R&K8?4,.gIJPEG_<)U[#?e=R(JXUHdP0FV9)W4,
1;3=_:;-FFJeU>VI,PT7A>N5E>N+9a8>8[6UZ82)-#R/E51[MOPd@M5JXGP79@_O
O<X&1VR:fT;BE4E,X]OOK,6.S#)AQg3QOI1LAQA;KQLN&F/^JGdL\MP7]YDQ_\YK
gX_#UMa[_6^QS-b6HCB_TW#S5S0aYW<XOTZ9C?DT_eO2NYQY1L;#BZ7^=:)1Wf<X
a)<[EHB,MY6OK]=cJ\O7GR@?U3R)\FTE3P=EJ/N;6IX/\\-6EeP8U6fbSX.GUN/[
G(c&e)]6HRW5;2L>MWfOOba_/0V9)?(3(dW)dc,7ERA4J1OG;=eVBcWgD_Z]_Ib/
&daaRMWF-R=+/O<:AD=O\LR-A\.bE6-)1T283XTVK)eWd:g\\#.&Cf-e)/M^b.7B
d_OWc.2QF:3H0H+^G5BJ(Z(DgHd7:a)KOBK@+_C+N.V#5bCK?:cU[1D852F4=NFc
RW#5fT>(D(P1?Y^98-[6&BWNSLP>8792F4Ab_(<XZZaG97[.Fb-eUCJGSLFb?X^4
PeH1[c[)QS>VLLD-8@Y7=P#H[6cP;N^P9WSHQ-L9#A0?_PgEKJ7aB3CQ2Gg)O/H2
@-@V?U6T-SOTeU=@N]U&B_C2<<ZD&cY]X0MM2J6&HAWIAUMeaIRcOfH9@]e=,KOF
_=L,&73KB>+[K34\QASW/F29[?EZ9+eO[9<0>(3I<VWR9V^-O;&.<7JQV,a9NB<3
.J#I15(+M/1N;.U)aWGZD\2c);V7AOJ9UE&=>X8)NNfE.+@P,:9U(dJ:daaW=aJL
-VN,gZTDY.[V=IOFJ(;^W,_NU^CZZCE>eOE^WVCNe9cg6\>T)1TPWU@=-W0Q&ed?
\dN8J=-_AXP,Y5Bf6P:V&^1H-?5<2(8[MU?<c1#fCbSBZI8F5P1Z0HNAbLLKZ\.:
2PMK8&5f4FHZTB@1#A7_O=@_ONS&\dOQ.-53CD3;d.RHE_>2YJ6U?ac<7S[/<<Wc
;ZdN>&aeB0NKPWEI=,1U&U6HeXIA4V)87SN]&:#XU&YdBOAD>Qa33KSBYT?<d4c>
Z>SPST,EV9NYE:A3abP3DB2^7GfcNWNVe8Y+Z;8-f62)J>_Va5:ObZ89D_9g>);;
;NLdXLSVfH=O0N05&&Y7<Y1PWJTVWQL(GUXY.C)BK896-?<HcW[ePEF>DER)5TgM
6W5.\PR7F/CF5;a+VJE[.<DcF;_fE>DG.3NRJ.?0AX@A44@=[&7ABWaJ86XUP.\>
N,C&b#Sd/^2XP,25g6K5;Fg4(#\(3bb,f:bbdf8@0^RbbH]cC@53QgF9/N[R^B_?
SAOC;3RT6VA,CV+_Ag@72G+J=+;30.g7TcV+M@?SZYDEf4fU00A:.>g7AA.7OZR8
A7C:U(e[7WYbXUFCf5-0F@?J8B8b[]>P)+1TTVgZ]UP6.7414f;^G:H7L]HSQ7.8
/SC+Ld#F,V#Z-G^85.:P^d_S2F_)<JBfRMM+^1B_8<:dEH<2)T?AA?5WES5)[6NJ
cBeK&F8+RMPXAL&4>2GGVQ])b>S?.?G3I=U+g?5Lfa]L&K2RQ0H^^KK4#QS(:]eQ
^9_W5<Y6+fBfK-aCE=^5;GRdD#E=@J<_AN+PB3^aID^>V)2>5P3KdW>WPTMZ4FW0
RMY.K<.I:9Y+<S^Z#+M.4C4CE1LdcCFQ111O,aJaTFN2Fb?)_171ZaM@d30KSe#U
Q_CfO;FM6R9Pa2V],feEUSU.3OLXS8H?6P+WS3:&OS598\J\^1W()?\A3(.\SC[f
])&IZ,\:5WUDISOF0:X2Va#U=P7\Ta1S/3PTM:N@JJWgC->R-KZ3F39AeFO=G(D3
A]4G+:&72K3F+.ZaEc<C.bMOH[868Y58UCV)NRg?D<C(3g.AIAY:;+:S^6(]A.g2
_JMK^&I9DB<9Vfe(?gWa#.13>17Sb_B,Aa6#fc(9ddHZ8EB10&dWKW<7R+,KW6e+
?4=9EC(N#2WaOJ_?4J8D2V7((I2JS[^//Q,?fY.Z\;T4D\.DVZ::1,.73&=^4dN9
_bRT6K3D]2.1GR5XY+.K+^Z\>^8EW5J4/9SI)A#D-DLEX9-VN\_^5U#6?:<VD,PJ
MPX9f4A^A^5\4_3B&8P8d[7@U\\/0ULJ(;.RX0Ve5-95KAK]#[_X=Qg6f#DBB@E,
&KBCb_Wa0/P+dE?)6?-D_QZQ3Q0G/\G)50@S<CPG]WMU4K]C@\::=;;Z@N(F+MR^
Y(g(WVH:5,D4^C)g\g[<1X@5?(GOaeHd(AO^fN=T6_=d2gR<<-d2DPYA4=.-.TT6
^:UV&:_5L<X)7+3#7g0(LN:.Gc_ba@Z)Na&0?0&d?ZfEaC0T\e9NU,R8U-L8Za)<
T,dGD]gXY5/;Q1aVgM8M27)4OGbaMQTQ?8Y=9.F^2_Q3cD^:?1BHXLe>\V>:/d)4
3C3TCW15V<4>EV]]+]7XA\V\?@TN2f@Y>C?&,S(+a,d993Me-M9#UeZ0eNWR,0CR
GIe:YT@+RH,\KI=/Q+UV#)V.STG.cNQ&(48)-SM(a0R1C^.f.c)X/P^d)HGfC)U7
0g/#DG&#_14^^(+&O-,R1?K)ZCQ?+9R8WgN<AJ:P:)-(1^23G5.dHV#[dR.HB:I)
J7OW/_I0+1OG[-:MLGd3R=SI[2_HMNK59Yg7&-?PN/aO<Y6AH;BHL7CE+:E]\01(
2I#SHHG++[?2Ba<+HNb=Ze,E0(CKC>GdY8\ODQ9O,SGgG^GgZfd=f8M^G,VebQO1
=e)5HC#\&&@W23OB3##W15ML^W/#daTAYd;Q:H)>LUC_WUFce^(b(9O>OW/XNBA)
I0X3/fZZfCAUeRd/?UZ]Lc&<Ic<c6,J)P-2K05<PT]f/;OO.TBc#TTT0&DNSK9e;
BO</[D4Q^T]?6ZPYJ#C_2##I.a)L<YbeB>TUI+WIDJ]D9>F2A1gF6H]0/b_Q_V<_
TPUX/8aaD=F_>;Z^9A@TV,\[@P)\7=C-g[@U&Oe0?V<W6[\N52W+(X9^5#2Q3\(?
2T7dJYRM6?E^Lc1d#+2[b:]?4WFD.]gdGG/,&\1KZ4P[EE-B>N2gK;>D+9I4-gF2
+F(:d?:f(T[0GZX\7eKER)-X:fCU]HM(7#\036,S5Y]3AT^WG8H,c()7:.2<CK.-
<\H\@/-8L8+\O7\-=T#SXXLPV+dR>3];)#G=:OT.MHGLa_VJ-#JaNAO9C#fR/J3K
QN4\e;eF71GWI2.X@CPR42GSTL;]#QNHDB#,e,;^+Ge&#gO,&W:@4;5^O4UV-SgB
[NPEN;9PL3=5V3<JEP&2T<[Z,ZB+=#J#5@AV1^&(3L;NVJJ_KV5[8eBFb]Bf4;/&
WTIW5e5/4dVODd#L,R>C>[gT#Q>;87JT]_-AYC)O7P[cIZ9,,Nc6UEC2XE.:>\31
HeGAZ-bIXG\_[d9IZRT-Vg^W4LW3If//(C4_dM4NA+G_;5?LaS1M1+R:OLT:ZCFX
/+fa.V,S7\g0KWWYXS4eL;A8-\W71C2#geJPT;R,#KWa<:e,DK-Pd/LBJO5f+V3F
G6)I3O_=b;=7S8YJ^=]^g?/\R1=B[aH5QV0f(;f:J8<JH(VB>1#T3H<DO=;C97&Z
I8OILBCMG.NHBC-Kf)f]&c#0KPTKTXOb94-?-B0.cR;FM\_>TWO4f6^;861HA_S:
LMK3=VYR5P=eQY/_6:E/O4bQEP4/fAX6>&#-#]QC+&?I<6XTBX<Se;&>SJ.STV6.
?2)V&WZ:9\B-U=[(9bZ<f;4^YTV1[[;FcU[ZHV?e&2-38[;\).^Pb[MDKP>VaUK6
N5P::S/:RNf)+G5e+F4.\3,Q6F@W@)BW[K-f.T.-Z+H&?MT)HK/(<;.=Y?V3LC@2
L?+Q8L=#6&\V8dG<8cNR>\D=K1MCJedAa426?=d.]=a\LP-^eQ)P8.:f[SQZJN\5
X>I_7b8B4/;@9b2#M<@JD:E6B.b<MV^,V6;\CTY/C/T=CR&QgVH8C[XMS15NKC/I
\^[_>QO^U)X1^Z6J:a]9A/bBNL-<XTBTN?,KG&#^)EXd8XgC>G=AQF;3FUPZ-P<7
0:<I?gMLM1UaH4NT_+A8,WXWDQ3L^eI/8,](D@[_:X-N.O)JF&(bN#a,3\,5FM0R
<>?P-f]HSZL<E_PSJ][(O_c[?\XLP1-H+ZH</=&c2Ig3,..92U:A9)THe\X?I^+J
B;3P8(f]Ja-RAL8DgLPC;_Zb.Zb4.>M6CB1@KS[,??\W=MDUIJ.X:XNTGcK+(^1e
D.,OQOG?g\3#J9>2_+,5X?_fJ9(YPJ_>L,=SP@^5B..<].0,E23fVQC/,OZf9cA]
g)58.(8b.\-a6fY]O:^5C3+V355:+SHM_4;T<QD\@?Db7;33c\:^Re+1?X-^9NT1
)]#0EUGgL14,#&JN:5J+RD&PL3Sd6.[R.^/gV-UQSG;4KG#N6Xa3QC279B.O3<2+
=LUaD==4[KC-9\Z77\51(BI]T2B4#^L<^27XGWe6X#a;N-)@A6?DNY?R/A17aOHI
&HeJ@RKe.Le,F9^^.eEgZ7?H8U4R8X=P1+V]^fGVc#5O^=f73ABefUQR@Z&F#T4R
@9)S^V\GLZSE:&+dc(3_F]/9D5)U=K5/VQ3(XYI^6=(#,NWd:KG63@\1\2M]Cg)8
77aF<-aCfRB]7Q#^b=Z]ea=P0?0;.<5Kc_&++3K,cTT-1O1B)2G(\@FfYg(\L.;Y
M\Sef7ZYa1VRLL:=3#GEV^H#S5;G&+=XB+<;5Hd>Y+X]H1D[[G0\L0?e_YD1_#LA
4aTP8^,(.e7)4;&F)J#1CP8DO[4D3.7I6&C=[YX]2aEYRXW)NOE)Hc.f2HL]2F)E
_=H&aL27=E+O>8Re::.,4O-:_]BG8Ye<0]FbDe;EYDfLLQHdEb_IMc8J6OZZJa.S
ACFbOO-G1/Tb^,<ZYWO7M0Ka-OTIOVMW5Z&O7:<W,S41?1-M+Z+.3/Ua;gPNKT<D
.J@<eOS0UW6/G&>\ZITaeQa24c]MW]W4=4&IO8YU#,-B[DI=gRa>e6CM&U=f.e2R
EX]F&QY[D;B\#@^FeL?(>O;[,3bdTg^PCZE[Taf:g)O3/:_E_EHeD,]N+1AC+@>D
IbW/C+AGS#PAL(Q6P@#UC_W\^d[aUE,QKIA?:&8D1+X3W4K9)2CcH&[)dPQY/4(Q
\NC/N0=@]9L15/G>SE^HG7CPGgUELdNMF>6;/dUY-W[Ice8I_+8D)FWLSE:IYN3@
1E)f56A1<Z5HUWBH@+f_[]^JU,_G=?>8c&=)M-+^Z1P-E;Od;<D;Vf(<L.aGX\?g
Ya1Te,WfHM.QI[4S_#H]G;0b_f]2]-[O-.ZHM.KWV0c33QW0g_D)dWNQ:BEZXee:
H32(7<Hb)e73R;)J)UZB1f5931EO1_3VYMD3gKR-eF7.S6^5<#a5=B991IH1\>Qd
V&JKR5E\K6bDIS:_.+WFK]bJ<M_/#(PGC:e<[D5R.?4/\)7(D9&X/Vc\SEdJ1P16
I9H0ZR0g;Q77LUI6^[C^9<2Lc9f5S6<XH;40V1Q+VVK99+>MHM3Z1<,CH>GMD&+(
U<::M8Y5Q0Y8.7940?#>6:]<:[M@;A8>O#bc7+2OXFF^SgU79[T3e#^Ygg6AVN7-
N+X@<AD#OO;-a/VbQVHf@Tfd,IOf2XGKH&4(>]ZgY?\D17#GZMT-I@_EQA[F1Z5<
L?N8bRJ^21V\gAWWHW>c;3[A^>TH:3+JeM</KefLM5E_2:H^?\C?,.06DV_c[I8C
458HT?)..HcL[gO/+S66?7;#T>;]E2ZQ=fE@Q5RM#gENF2U-aW[Kc/F3,8/ST5E1
,V??+V5SSS-d6aX.gCbe<?-ZG7&g:17\#J,gKeG6?OWB5UaMY>^0eY25/<@dP?A(
KGY9[M56G#BTT//B4CGCd<LIX&.-[^SUd]A^G7e=A06A2NW8Z9./0;.;QCLbE+NF
Rd._JC?,I#R]gLJ4Sb)b.L2NZHGE2ZT3YdaI:ab,e26^VWD2)Fe6U-K[:+_MAYgT
a6G(F3&)<9.cdDg#b1QVHbd[U_/fb^&)-N9X-(_aRE;7L?f6H,7/6@EZD:g6Y)R1
@9Y\=Tf[R.23=]_#[)S9Y_(WUfc9&e^bBP)).>]Ud(OFcLg?J>_9WcK3^?;5#MWe
9LL+;aK4VEIB>O8C:Z,6=^.Q96aR+CTJ\Q=WM\2R]DP/O4-KL630,P<;TeVR6DNB
BAG;C2.T^]@UP=PTD]cPOIS)J1OMK#OKIeZCT,c??/PWY5_3CHfY^QQU5;KZNcCd
B6#We2c9(Id()8;XWRfb[]8TQ?\DSg0GQH_+A<0#=DAa[?O26&&d7)O@C4=:CK0)
SVMa,LYcED,I&.07fN#BZGLTZ/MOUKKXZ)fLaKWf_OLLQEHTQM&:-(_E5-]C)/#K
GV)\OH8g:DLQ)_WGPS]:<)A.f\7Z)Mf[WPARB70_&8ONI+>A2DXKKg&CdR[eU@@H
_/D9<dQ58+48]8(()U<7BTdV@CQAgLVDVL8PM<T83G8Gd0f<dD^Q#=@KUe5_RQaP
),Je<D57S0=b9IK0f17WEH[c83T4AJ?,3ga?5WUS6)ddP[&g];TD7V4&?ZQIbMT]
X>M1gX53_T)M2=>\11&[S+L8_)Mc57Cf(GCY3V,H4/),A1O#Q\.=8>7BcPM.<fT-
FX=IJ0I6HXKS<P/Td<>AWXCM^_GLgg8V.0](?(ac8WX,G$
`endprotected


`endif // GUARD_SVT_TRANSACTION_ITER_SV
