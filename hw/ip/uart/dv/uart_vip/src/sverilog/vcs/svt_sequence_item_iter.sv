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
KgGRD5J<S:A8]#dPK1<K4#c+DG?E>KQ>KOaa\]/&32eGe/]Lc\5S((1?#T9R^71M
S,,N>F_R?PGU]@>8I0-.H,2+\bLM[X3;dO]dK/>(@PV=_O)]Q\@B/@.Z_:)]V(TQ
Z.2EB34CAO6\FS+\/)W+S,:cBX\3NbaN005FfOD89WG=7AR1e_g-L2VWUMN(c\]S
YDC.A^53RFagUXR\=DN[#XVM-e(GX:TTHQa9A+XB(-fQ[f:8XEA_@d#ceR<;[CZb
fO[I1d&]a&HLB:+FSKC&REW@#O2a^N.Ag3^SeK@_&C_LQ5Sf8gA[BFJ;8(^_HP92
5&&3SA[d@69\>E^;(g4JD6S_B;.cf5PI/\XY8S[@PVIBHHU]-..L]VAL^BZ44TPV
)/^U7RbFDDeB&<N09SgL9D[C^=;=B#U=2.6Kc0@^=\6G5+aBZ+CQ,4J:1<5:a5V(
gH=dEX[?2=UFd7#CB&YU6ZV?<b06-bUF<,F1PUN&Rcd6(D+=IV8PX_C]&ZdBKAff
)+3ARd5f?<Lgd2c0U2M:P7DME4GN98-d;,QLMdM)OX6>G3\#KD,f];R/^)c)0/?c
bI5NC&._(OLHL2[WL;5&9+E\X_b]MR/L2ZKF6bEMHD+9MC8//\Pg_1NeO)<K;PCN
?D@Z)@\@-+dIATD@@9B+SYKKMgf?2@UD<;c=)I1U)Z+,.(fe1/,>2#fMJ79(/<@a
Pc2/3<K.<096fU:+LAb=X#\=KR.Q\MK.3D_=,5V=5#IAM>=:B.>4gZg#T@&\aOJ1
E3]&1I]>FK43c;d_LReE)J6TK0J,83=UYcS5S5/BPX]>38_?:_T-G>A9cN:Z52NC
JG6S^0HR+FH)Y[FMNVA^8RM<0VUYdAb1-BA;)&M-eLg_L5IS3PU,K.(6fI;WXDWY
IRG<Kb,3MOR;f)QEE/38>\YI:/]e07L4@8d0G>B8B^:BeGUJ21fXg)DP6#\;MbQ6
/8AX3?4N..0_)8)NGWI0.R\M5CT_<TeK448SLKWag7O5\1\(e,FYdOIGMX?d\?)G
@,1L;6V:RERb;S;MF;21D+O^<&eZB5J&FDF_:BE,f+[eB___c:977Wg9I?AS.H:4
1>9Q@Q?6OISOU54&-IL@WSU0T[@:1J:=b-^6eO9H=D?38>6a@D\51A6Y^G>MJ-XI
H-9QU/c^,<;59ZZY5&P.e[,e3^.\72XP.4(eHb\Z]3XW,29^1bgEM)Dg/:g9+MB:
.UF[P\5];YOg5A/@\3dY;G,;25J(R/5,I,7^SDI[[2P7NLfgAcUeDbFXO+JLQ.f\
J?f][]CQAN31>V_S6aJ?6L0ZaJ^/eJFD50?22G334>R4](8LSB\dg32FBH]17/)J
BLcabGeK3UL[S1[4G]4N0R6>-@aQAM,4/K+IW[TTY=00aHU/I2EP.)_.IV44;(BO
7[)77IZ9fDAaQ^]6cb:,Y[^L8aZE.A0\:_(eQQ1PO_dKd8XXfH>:3(2B^&C>NGeZ
+?84gdMAN\d/aMc9bfAc<gJZFcL+>MQJZaNN,2H4X7)A?HLK(T88[9;6.F>4W/M>
0gG43U#\TaDgc;[BD/fONf^0B7,7McF5_)4.a;KNK1#M.fNbNX(gfREH]3fR_@de
:JT8\CBX:d>ULYABH^:A?/EKX^H#GA(L4de=1#]E>MG\(ZGebRaIRSc9F5:N4:e2
;Kcfd=NJS-H?4#P=0HcUa)&D/A[[<]4O+ZH4-LdI#EHBM,dMZC-d5,)2&84.1B1.
:V6\2B^@3]g1A2^VQ=05#5eb^U&d&-Ud@YIY#LD>(_F&=(HOFJ54?IM74R9Z0OQ)
ZY_BD+KaDK<?,L2F&QK=RQ-8W#3UAP>VI3]e?-AU[LJ5Mc\Gc(J>CZ6RNaU6CO=>
g=R^5VZQLC52QO6\DXe7aYK3Da=M-aHLWEZ(1AD.F_^\TJK7E@gH_J4C^IY&/BdN
BbVWf]g1EL_L=af)5L\#_-Qa>FR+GKf<WCQ(F>V8OZ(_.DB\-[R/Hf6?VQd,<I@U
C7K.=gHN_>\>Eb.GHSB5=2Xg@+EJ=^E,08KEK;0U&V\aGB#O&1<B,Ef.0V-P,bER
0IXYO,AO6MGN0FS>BWO@ARN6RabB0gCO\C8KJ84-<93G=b2d))6_.+Aa84N&Ng#O
PV]9A^3VBTW0?dObK,XB=bE/gOdaaJH(X(Y<gGN&4V.(O:R,[8@SB?eQE#[\TPI1
F(+e2:d4TVR1)6PR:_1#\XY59;D34_0JSfa3O/X]V:AN19RIKT)^<0&::,O:ZC1D
KV]W.<gcg&b^G^.7_,P(BZMHf#-S<AQ)\F4^^N96\0]F#d(J)UQ:Lef&2]O,+.J5
73]NU3^0>Gc0[b>3&9VEE?;;e.[<I^Z9_5BY5,6W?,@/)MP2aUF/;3G4)agY3(-A
HWJOA-K:HBPW2A@CF:9+K69c;S[YE/EUMb+9WHPJLYB\1TYb<Y<a+A2GE5+/#.+,
=[/3Bb+U[8_R-g3Mb[ZZ(APP0LMK<DG>O\O\Bd68_g#3(9_#56c1-R2R:>_f</e/
GX7NfE3<(KA<K>Z[S>OD&)_B7;UQ_ec149]TT[X.JTW37A#Y@e?7.I(S[3?3R\/-
S#T^,U=ZEgd)dY+Qe^EA<&bM<(HA9X\>5M.\.K:@(aQ\7C9GB.[gP7Z?9f4;#6_Q
)/@4fGQV>(B8Q)Ra--5eS/d5ON8;45+gAXdH&.9B,gOYDDc2<32]MXd.ORAA_:5O
+H[9:#1bR#Ff3+#R,GH/J44SN\aM6&6H@:MB(UI&J@4GVIe/Y9FaE^,;_25(FZG8
a?IOd7I6[>fC#f+M((N#8O[WYLLBKc1D&M]f#eICB&f\O_E,ZeU?IA#dPCZbd?A9
X0-CSe9)9+Ag0QBUB^7Ec#cUa&L&X07M13DB<BX6:\ga9)8BDJ/23R0a?e._Y<BE
T+/XB]?D[FTQ81+LR>UX]I4M+IPUU8J2+#)aaJ^1XB=47/baIfAJ;aNY_Y()K+F0
K@[Vd?ZN)4g4Ng1&bSWA\5WeDXQ[JBVG-Z[&J<g47(\aO=[F&V\a]<Va)1?I7V#:
\SR)C1I:Z_WI0[P:96J8:LLY\QFcOJ\QR?NUW_/NM3\_c5-GO1HSOIT;EI&P5c]C
+:R-?0=.eZ)VH6.A=UAJBCRbcV3A(DI#>CD@M99R&8I._WT_@-[(05HB07C2f9[e
7(&X+Ed441X>Ze;V7?E_.ITUFV\3dgY-4^A0Dg+,,\_:(,\\=[C.X8GFBL)aH7K)
BX7@5?W(KNd>];Z_EP3bO__N.4GSaDJ_.FHGCA4MU@)OTO:Y:Q88K/AAd^.e:/e-
7Z96\4fPE-?B<12.,61=:I48PP:]T7fZ-Of?/eU-1.DC&003\).6g-H[Qe9GDQfL
X@I.MfE9<C.-f(R+K-7c-UdU&YRC]CeM0a-J)T3<TSLFG..Y2>=BDM7.?4=FM?9U
-S/WGP5dI3LCa1,aBU#0<E3#T3.M#C&Y&Yg,QQ\NAS?<E0=1\MG8MWC1-J-J-La<
OJD9FbL=+\9:G:-=-.[g7IB^1fUgRJ0,.@7Ke5):XH.MV;c(GTc.eZc(.=>7W)>M
HY0f&?/&@a^W8=8X?)KKZDP=81?U]eG>UaD,J)]Z<3\c:>R::-W.C8^a34<Z:GbH
KMYZ[6gcH)/HOTb(O@(3^OKTBP>dc[22&Sg-@6ST(3EdOafTSX4+&dK2SQ;_IIf-
\>YD\&BI1#K_c39=BR#./@9XcUaIYYRT,G3a77\GV&ED&^FPA\&F>#W6)(P5QC=G
9_e-MHWUS9B\EV>=;=7LbcCcM_3Q/^KI72#2T22)aCULZ_<UbV2E9a64_@G\,.8X
a)L2H[WQ@XgS.0<BUJH2;II\&O8TPV6?d0Ma[R]\^c6RV/UT8WKbeR5c(QUNA8RT
KA7+FFeRHbTO7RFg/c[+Ea?3Y=];]L?DD;8@JVP]WB(P78.9d:8BKQYZMe,8>PXe
ac^Xff-Y&e(e4:J3fA+H;444(#_[P11S?gHaZ&-e</=Y4?(GBDCc3]M1KJ3:MAB;
bf0d=3f9/JI6G9F20]_^d&I0\fU,[_.[#a=dYcd<5?cEa4STSZA=<UVFIdfG3UTa
]2B(a=e/W0EO.7K3Vc3b9(3S:,T-8](Md@JBgfe[6/X-:G._9J-0g[;DZSPL/H\]
8,5fdA@P26HJ]XT@P60+#J(<+^<ZR^XOe6A=2f5LbX\_>+YeKK@.9e@c?FO(_bgV
LbA,_9)g)7S]_AQOGETHR]@8Y^O-(#(/.Yf+67;?MZg]UUJ;e6<8JGXL@]Gb<=(_
0BVJIUMF(Y3A<<(e?D.E/cfM4F;8c@<2dE:&TK20X#)XT;DGfATcT>/^@f[(+K>f
IF93Z+<(b<f_.)^119R,gbSPI).8R7G52=UPXXf+K:]Ff5R\aOOd\DL3-f-N?=-=
>K85I38>,1-NS]b.U[Xb<T5HCcF9#,2JRT2d2bE=XXOUMOT8Q>6N;(7576]T=ZdI
@;G/@[S7ReefD\&Nb.&UUNRM</MRRaeUR+]]C-D76:;7gADK^b[J^Q7_3PF6:=W9
EH:3/d^a]4IDI?fM[^Tg,Hc@Yc3TDHIAfE>)+>NDXe/@J=R^<-N[(a-+c@gNbSfP
V/Nd<b9CU=<Mf40fSFFPHZ(0]2>0G0SL1+Y;HZ[8Ed/_1C(g/C4V&6M=F9.)FFa2
[9XM=YAaK/Aa00&H0WfX;#U+gFPJ6M/T?<#8=<F.Z:-;6ReBDCCXJSZ,1207TC96
)_.\H0F.D/@ePC,F-f-1?45T/>5@KE52,:4=@(G;^5S^;Q1ZJ,?],@18<CMWG0H?
[;(f-ONFW8.LbNba1\E=(4:N4[^^1dHU^]E>fLGbO(STLbKR,06B:8+,_g8PfDR?
M4/#P0\.F8G3V.G2Vd1e8<<QQ/F6fMI,TYbX\cO7V.Uc1[Hfac43d&U?2=JSMR>#
FL=SD>+E/#>20D_O_#c@EZgdPVA,bF6U2<H(Z>eNZ/B588QGgU1#7L//]4HW#c2-
D^^fcU3D?A^6V/HZN>8@?@4X+MVS^_\:)NP8V@BaQ9W,:JN:KcSV]LZUN4T4;DP=
7LZM+;\T/Y@bJXW3fK26=#C)eKdVfKQC157B92,(6R<UF=f8QF\GIHLc5/RVOS5-
/.>[Y)1]#^2ITS<//c5\?U;,Y0.U.9&b/XRE<Y?NdT2SY_[7ZBeeOecM7#6.0F0,
/T87T(NV[YK?cHRHCAX/AO85[I04U=EfD42NRC9F>ODf/:24gZVJ-G,6Ke)Jc]Q&
&M6-O_g-fG#OTa0=PPG0^4/:)NDI#><::XO6dL?=-\>.>B(PZBeOYDTce+9?V4ag
b1HY64N]g@CgLOVCHBNPLQ-f_/-(c,_F8J<-:Q:GMNZL<H@NOf3)a?Hgf6_2FU-\
W8U33bZYU.05.UN0bF8QQ;M-HH]I^8SPMJIE7gETT9+4<3/_F]R,Eg[gM>T)AX3Y
>8;UHd/C_QV-_48]SK;Jbg#5:=[?#(9JC_X5]f_PcKWBQ+B5JgD#<\18R;<U33AM
KCZ3G&9GB=eN0\gMdK6:I56JG3PdH6.b@8&W.KX1.cf/JgKMC12a)L^XbZT@Tb/3
Q>a(e,0EAEFYEcN@V1WJdK(6,GLd6M1Q_AEOF8^#C?T]&X-)a._Y[B#/S3Y1RcH(
)K=cGfQT7-KN9]PKdOZ;9b+9FBR9T-3T:GG[U9\JX_O^#&[E^).BJ;J8&Z1:C;b0
-P,3U_4Cc6U1=>@DJR]+>B[T1+#gITLI;@;?5JDCSWO&/\03NNJ2ebc6I4a6H)+<
(-M<E>IREJ25RdOIZ@-38g7OZ/.?@U,+J#.W+cIJ@XBcf#a2HDd,11T9V(WU8\DO
eM=DP_TA(&BfTcCB/8;J8?(.IL[A9caX7&]2:BKN92[LQ6P0PR_3<YcU@U,,K=.+
[&5M.O[W4O)Gd<2.XX2E?_:g<@MD3V,&@YDRa/SW)F/ZLKN./cF0gS7Q\^SZ;?8@
41TS6@;BRc\N7c@<?8c0A[/T^C]W&8f+P7e:P_b.:aTJS)CF+&F]]F.LIKXS_/Af
.Q2-?&Q=U?eNH(5?cE._G-e]0N<)OZXMQOI)15WGe4D0/BBR:K^?X0d,QFS-X:/M
-@7PB9>^fF#>KIFKLJ^Z=TcXWS+KXf>G0HM<U=4-V2cI:P0>ED)2KEO47Q#EUZK;
#Z:\GA3N]WPAU^@(/?bM7DSUT<_Q^BgJ7F+c;1/eA8@#9@)J+([8]WbE5J;Z4B+5
F;7I4O]S2([/8Pf]G;GI6[G)(;W,,288?ZJL=M\B>(2N(/R4Z-4&(DY9fN:2IOOZ
I-gDT,S(O65;KW,=fDQ529G(aeaM5CJ0cKDPgC4TW-+L<Ea[R=P?Zf]#RNbZ5J.<
8>Ogb\g>WI9I+-_0A.IbR^UG]Og<T:&#J5;N=QNEUgGP4F2.c]L\<M_?CeE+>>74
<]VX8fRVV(\gc#<D-.HK88O2QJc>b:8VGg[RP21e#VOe#_WE5A82/RQRLSD?YfQ\
@:.9L/]UA]/7G)T@CZd46Z)5>U[24Cdfg:?/E=-@OW)_VP6dMFC3S;Y6SD@_H40=
4/(XV,(e3&B<0J\VO?D(8c7G&a:W]Z9Rb_X=CVS?;A?D0PbKd+G>.aTKR\[bYVXH
aYdDX3OZ0fGZI^NQWaceQN=e:,7dEB<.DRM1:X2H5TNHa6I98@Wf#@?&J5LaD^cS
+SW1\;L,a>=<U2298J8&\]XS(^+R3/Y\-R]HOGPO4(\-e^<?.4Z7G]VOeZX&2<?Q
E].68;DWPH?[-.TGLT/ONGJ](eZ@\EEcIM5,eL2N5d1a09]WMcHS-0.)d\2DN[eC
LW+=E<O:YC8T=T^,>d<-J=CUQ6UA[BZ1Y,E^ANLaa^-+2<JG5<;e;/?=]E9]YRWW
/7_Jb<Oe2KSS2+AId];6?)-2=455CZNfER8]gD)@?HSIN1I7_8A\Ma.BVcELcFZe
66fT1;VOO6AFEUZd0:a8N?.SfKG,#^&_+O/C7+@eQUb,a3cdXg37-IKSdDeG5JIL
[LK+,3[Q8CDKJL=g&+RK_32V.LG(O-[PIMbFL=9?=\Ma;9WI:ET\L;NRSdC@^T=I
7(8K)CAV7-5O9c3S;#]QT@>4_Q5HS1G[B34Q45IP:O&Hf&\717).OJ@b?5);Mec/
L-Bg7V:[:;GbF_^+4=/IX7a/3^NO6,GK+;Ze[4a#X@YM,?Yd71dXZ-1&K77AG][c
Q?1PUYTCO:?;&D9dV@;0Q0QO8]+:eVI&Pb+FEWOf2H[034<Pd3ESL[SbZca7[R.e
S_4M3HC2QA,9eb@?A3+AWZ\&40J\5K?cPAJHeU4N,_#OP9U(YfJ7UNIL4_@,JY3D
-\;RfdfbSgT\Z5S1dG[aK;>U,EX@XEL2/V\E.FY18Bb;-g5F-cTK<RaWKbW3)M1M
[RK0I<L,5_TR.5.;0BO5W:R5ZFB5Q>B#MJ,H_/H#DfO7WCeCPbH7FY#)O9NN1>)@
5(S:^B=,>@_1B]..?T()AV&]RcAgX&eHdf>2?]Df&),+g^)BM\E(X:6V-Df>S)a5
F9+M8@/RD_L?0D;T(0f:<=Of@4]Zd8B5SKIYXWM?08:7f62@@_U>_FDMLG6>=.4T
WH:H2S0^Xc\@,K4V\cRg;4J-J3VX5\ZW,-)/dWQP_+&/S>GL<Cac&_=)e6?4YWN(
d_6+46W/V,DP3GDeNbTF0HKf[V?.e7(5<5bg4I+1AP0CHL@3\d>6\FWZM<9ZOb.E
<7;9F97X^&D1dQMG.0S87MFG73eU_gTH^LM//<AdRD=-EX&Ue0G\]7,N0f49Oe=I
TF.M0&/W<7&MUMQY2S+&B@6O)K#1S^F9JFBc47EBRT//0&ef=.(#g:9B^O@7O9(g
3-H1^D[:\cbD7(^HYX)^(cAN6Ff=F@=HYT-SVe9LX[E)Ff=O.89TQ@-GW(bJ&:6_
9V]TfQbYITKP,/L]K[1a,c<;3:J1V.T9D-T&c?=C[U6aKJKDZaL_Vg;+^0g;F53B
I:3(BKNMMSaDaYMd51>\QA):5_=c4e-@Wd#A=A.R&HW+]#;ZM#T^eZ2UK?)2g_g6
a?UE4M[_JKM.f775>b=LDGM,(-Y&be+0FKG#8FeTVZXQCa4UG&E;6E6P-U@dY&LA
KbC@5)d-,<UBg+NJ1PV;>.]K/b<GM^CI)JdJK2^cQ=-dPXK45P)VG[TDd,f#(REI
V@0)NHZ5.>W:7X9VL34MB&_?^YWZ)dgb33WCC-Xe.LPHR[Q.)OM81@-J);26^V1G
Z/G(Ed2&K1MUfMKQAI37H\G+]NgZX3aK3&SOb.gc2Eg+@KMcBQ0QaUDP1)=3GXFX
&_#MMKPR9^g[KUPGYM.Z^,+>d,)Y&Q<)8cVZc8OU__&UVQ?EW=<A>=9U_S>=gDGV
Rf:/N\B5P\KZ?TGL<1H^G?7dSLXW.<7@<OV/M7J.-VU\-IIfO?_cG9\0^3d0PS^e
c0f3^e79_V=O5428[<6;YXVX^g7Y@]WgSRSVEfCBUV5454^<#-HRcI+[_9WQd::N
1<:D=-I2?L8(AU9EH,gNBB2_E#OgeP/S0U__;&IDaBU>U>O[gCE;2N,418Z(aKXY
N9>_Y4Z5ETf(DV^RHA7A21Q4d?aeDeAe?FZ^T]9]GO/)G;-G]^P\P#&&PUMPfC;_
&cFK9@4+58Y,CFB-8].H&^g]TLUG8,N2c^<C&?GGYES.5H736GeM>DUN2W/,TEa/
C9AUaY<N_ZNa:b4G)&KRDRIOc&A(NIeaJQ=BOe.#K+aX\MKA_>9YUf>#7R@2MB.X
8XaVA&gXc.9#?2+7?;828T)EPEI2JE,62?fNH]3LIS2=g4gI(C<::F2cAgAgb9C-
(I.B@AP&KJ]IDQ0\,MM<&TMceNTL;=dN)dS[b[DPWa#M1E2)Qg0A>_VH37J-dR<2
9KW4Wa1RE1cCEWW6WZE^:cC3,g.=a&d_=c_b,I#YM,_Ob00CfJO6G,#>-1Uf;C6B
)>_V68]RZ;+F^G2K3fI@a1^AMA^846.EgKCa4ff^--VTI;.;AK[N??G/]g[gT9@N
Uf,f?M.-IVG,IF>OW:E<Kf.^N&aW5A^d_5?Z&>J\[OeRePB/TI9,0G<a@Y>VTCKb
C2Lf,0,+fgW(.Sg#P^(,UC#0abE<:,4LH>e,0^5[>L@V3[[3B[_]@;.M1YDUM/X?
I4_e_5GL?M5+^2#b_]<@UfWIY:Q46XD_>U)fJ7L2FN^NcFM#9BI97NFSHIdB.BSG
f?O?BbH;,C:?WBY-(Rf6E>8A5gUGQ)[^5LW(LAb<56+b0e]SQPP:\I8VLE+NE)eD
0][aV,&,TJ0@^f(=7E7QNgGc41.2^9V_]+;D@34K>&THZZ4(V,;fFW:.=g^ERfed
Lb+]/RW14d@QH)PLQ3aBYGd>BDM)VTU4I4?ZW^]@&HMbUW.RCVXP-BT4@5=0;GKY
QTFS-:WHY,Of9eDJg_E;^)OGf<4eeC2Tb2Z/D-86DY:OM/2LVAOBSAcU6,(OgdLU
1T:00]eE0cQ2ffUB:6fA+Q(ga4UT@O?BO.X&;Ke1O;g=8bZf;X5L2KKGGUXF/<]7
[@79X(2:.CfPTM#gSLFd?\+3efPR6cc6)dY3]c:_<L46/NeM14R7.gG2I9A;/9L[
7Bd..a+cGXFMG@aB77dM_b_LNE/I4#^-MCc-06VJ[N.N;26UA/KG[J:7G:T7KAA5
c;gE<ObWMS4]6>NXFOM_fE,gO?(423a6Sf7V.PC6&?LVM(T?O[+P/bYYK:V<Ge.a
41N&+b2_AY;U3gYGAXONG>]E,_PKHI:_,Q8T0@EVZHY18O1T<.@64??8U0QEM[6?
2V_NLQScH&G.T+[IVY@<Z+RBX@ge+d]^URb30B]NWF=eEHAGXcB<3YPD2:1QfZH[
6Pe(ZYV(,+?8#Z+c25#fVOIW;cb:dKNJ,6\,U2&9KIZK;4+\<AJ82QJ03P-;77N8
C2\+RM0eO59B<6.QGW=N#-U9?Y:7g9N1C3A-X+;)b2P5,Cge1(98(^D-@B<^7BI-
](6]:D5CB1D3[4fR9/#gPG;N=38c95T=-c^-6[(eb=-^E@K(C&0U:_CL#]JgT0-X
2VU;I9W]E\7aXM):Y+OJWE0>OK=09=XRPeV<4Bb@b;-7FRQ(_ZX],UFVOgZW:=]@
<AQg9fWbX1/P1YIH.e<N[8.B-Qe.;&^I,+e3b@,6S707UB+Gb#+^O>JeDf;\LO_#
7(?3&,^XN;&&&WI6=>SI-cTFS41<I(/[)6JcZO@626J19<8?cBZ11BY23+OgMQKT
85W/+4\\-c7E:c+J(I1e)_X1KYPMAN:Sg)QJU(GVWB]?Te.,>V,_gBHYaQZ_Ga/a
AY\1H)EX^Qb5<#Z3C/;G5+6XBeKB,cCcd]N_XO2P#40C7+P+Xg=f?=^&#&\=6M/D
_X0DgV_#//H9S#=fN?2)Q5=Bf@C1\E5&9+&.=Y>LT0afb?H,O_fS0Z9c+MWBf>_[
7F-fW7;=23)=D2eWaYgPTcJ.4SD>b?WGTZ]9=O&a8&g6abB.JGG#G9CaEHD#9V4?
-M^TE,0)ddI=a.<N08FFdWB,96\(1Q((RAVbd3Sd#_#GIOY\?&2-A-RFRV1aC@8.
[:W<9?V1QX0L@:g_^fe@([/4VHHV/gT/^S>CE@[N\ZV_Ib)\=5VMHWC=T^9ddQMT
D_.MO0?bK.T@UX\@:=QK]FX_C<:<Z;L7L(YSSESHW[VP0^DOJZ9BeL49./H)bfE-
:OdOIBL:Td]?4VGR@LJUa>8?U<UPY^(3ZK<OM_X#EaP?_f<:fTM99CAC7#KcB[gd
]A6N6-1/I.eTAgM+@:RG>[@7F^IV5A&=?=Z2[=PBU+>E(cCb7:C>C>G37A&]3WV[
V,704VAV&cGSGY^=GbL0b(dVDN/6;7Ea>-97R>X9VXD?;eSdO7+bH9U^@=N;XN@B
D)U-]^LIDJ\L>eBA[PB18aO[S,P/C15T4O)B&W^&b-2-6JE0cc-3Z\)^2?+:Sg(@
=dE=?:ME6@c_\cCBQ;4D[c9L,C&T56-OHC2(&#;KYK6deLJ-YBC#8Y#)F6F0[f?K
_<9A8-C>T#Y7YV]>(cWNfN2ZBYXWT;?UQaURG:^,J1(F43)#,<X]VfMIf?(e7D\_
V&aRIM<D?P(]_SfML)&W<NU]QK[W3RcO5N78af_X)20K<ZP7P8O9Dg#J8E?:.CN2
dGL(gc8K01Kc6ZTCI-5OXbF-K@/Te:+Z9;deBSM3?VK<Z+#S?_A(Z6[fbPYd2@f1
A[CTXFIJ#=1EPUf&7]S;g)4YT]fQHRQfLT/#WWc>-=[d)59PCH(2<6W9Y\C[09RZ
3>^=//-d4cRV(f1+S5?Y3D<883Ec[:1YH_Y<7^-,ZgdS?O@S-?LDUX&VA;XXNc[X
Z@.UB;/D>9F+PfA\6a8>H<I4_(g):E>-Ne6:.)WT\>babd-XfZG)RebA</TCE05+
NS6[CX8<^&BI)b;cUTc0/-+g#7;-6aW0_7L&>9J2O#DEafGC&_3&LOA)9CYZ9,LU
BfK4US?CAYDI&8_C)#M0@KE4.2NBU.UKRLYWcWKdKL/OUV1T#;VBRH#PJASWU3=R
T_X&PWZ?&;20];;@Y8FB;1TfL\c,KJI=VLcb)XB&A:W_?:/g;M6be-4[Pad.DZa\
)F?98\d4R&NWX=JLZ7]UQ\M)0c/C=2I+HAA;@;<dg&Bb(PS@8e]J6]E:4Za)D[Ae
OBagPAc@1U2O5S)OF7SDWH?P9XA-^:610,DUL+H==&8[Z[eP5e9a3,2G\#WD]eNf
2]E]&284Z>\O5CFE@O+.Sg\6T[D_-eP^Le.Ab;cfD^,W]W7X\)QAbbZ3B2dHa&CQ
/8T.+0_\bGQ^&E9BSU1M.._c,HCE,DQAgAbag[:YH-GC1YSW;,g71/_?fA\aQbVX
+OJPf7(fH(8#X]]UW8)&B&@=2@W3=-M;5:C/fPWB7f,M(GbQ\_);@Wf7cba^XTHb
121;J2ag5HJRZ@LDbaFc0[=X;D=J#NOJU06cVH^(Za\SU78<+;CQ?ITM78e0bU#H
\<CXcE=E&UI4fc:7Sa_=3DDTF#VE_adSZ2&<5\RGaXgK@J2C+P67@DLV&-0G=D@D
3E2?#XVJTG?[?XL@PH<8EH&)1cadfC<PYYN0.BK:cVI?g1-309ZF@#^YA^CL6&bD
3D(?K(0c)&(W4T4B3=NCA>EJ8,11/+Ib[-<GEZd1LBGZ)9#g44gRWH]Yg.M4gI,L
8WgILg<L;K.eHFW>#XH>=Na]X\8?3&4:+.:@-T==5.90_/W;]^Ne&bK\e)1\Y(U<
/7<8aBD8;6^H((TP3_Z)LL0HK_OI>LbM<\6[EBO6P(H_aS?I]b\=Q;24S0bW3<+-
7]I_Sf48cg8B^GVR9@SRI2V+DbJfEMU5cEcT<]=b_+#)TM/MUL>8OU:U-9IT@G_5
MK4;]TPN5]&f:KQK+0ec\2_N@[FfaJ?04g)[>b-b3_Ze(.2CO;WHF7O2);2.H/1H
07Y=@>OcONZ1[H=.aL(HDO?\;N/_KUK.f\7AT6563C@cD5TR?58>O#L-cFe,YaJ=
FZ=.=PLQ_GQWI/9&Oa(_[DLEVR9TFdbQbc\c9:IC#T?VBc<NXYV90W]dgR<OLLC_
=:#Q#c8B:_VIUc\,B(0GFgM0J?Q>^7&M<Mf^&e+\5KRDTWBM)TZTJaIEU2:1IZRM
U+&</c;E.a0W0)&gc,bf\K/[6IU.@SP0=X\90ATGa2ab.a:a&KKQ=]0f:,4?\))9
f_bMR9HfNC4N;Q+BfIW8]PUI[1WW&9dVBUg+7N(<1=@QLCXA9NO5f)QACaTWX6F=
W))0f4>G=YGD,ANeNS<)NTJWcRMV4BgHAZR<N:fb;L_Q6O2Z6KX:R0[D3F#3^7/.
2\bd^85X>.X4V?3^AI8HdAU?#@.a?Q65KHA5/)@K3[V=2WeBJ?DH_3;gM(e3I)HE
UB_A(PL1KG,2_9_#\VIXDW+[=^[+gJ#K5UF,,36DY7?,O=8fQYFJ6,]Kc(.de.8\
cd#7HG;Z9(2;^_ZI53J0+7&=RcO9BM[VF:GBJV/4RAS]K^K;YfR8;:L)CE:)?J;(
ZW]/UbT\>.=e,L&;gRLVV;/:5C(U6Rg=eP/4.5&DP72+J<8WS7D:cDIbcU_3.9,I
_^MVV?8@6eTMNgAd589ZE:gCH]S.gI:I2/N)=^?9P,9>L?C2)PH013Q.SRDaLV,\
EK=RcPUT7/5I/aBI/57,]W(b8@-\=3J7:XPPE^^:H)E(J>1/&NL12,&N0BI/XH4V
E\(#d7_Y7BHgTHT^,/FI>aS?f?MN9WLSa=Y^-X1UK2e(I89CW39^4d<JeLT4cFg4
Tg;^^IC6;M)H@7QU#/J[1XQ(Q7V]6c++TJ.1(OH\3TSeJ-cgV#J@GBA?IJ7f<DED
J&<bB(#5WTW.1W<UA#;B9RGd</&1d53<:_b?^&OeY^JSYEYBeB<K3-ZTT8(c/PLY
PFFVQE+NH7KA?KGA158GI@-6>e,SFF#Ce#PP&G+Ug([/aS4Fe#9MGL=Q6??8R6:(
0d)GJ=R2(20:cR,S7LS_5(VS(W.:MSG6SWL)NTdgg8-:/bS/R^S;X[BT[6Ze/=9Y
Jb1b<:,GH=D:bLTAS[b3&(KIe?^3KUH>:VgH=<CTEfIM.P8fPYT\a-gVLBeI?/I)
US>A5JF4O;2#@TDd:bfZ6=3<R[a;c]YaCD4&9-Uf[/3Af0aMV;RGJ5QG^^=8P\gO
]P8>OYABP@N+_:H1M4)d5c09KX<FC[+AYJ(.@/07588F][K8PA^]6#c=8+ec@KTb
FB<6[N@1dF9=0[T4QQ>WTXY)f]QEIJR>,Y82AXNGH+1W;.TT7H7ZK_)g-bbAO2R&
9gALBK[b),bE\HCHV/>_>bf=)[VR29DBgWdMRPUW;DNL?30gLJ>2^CY=g39)74&-
Z540AQ9&L^VeN:]Y_HK9aW;Ce8bY9C>+ZG^#=4X#^SaQ0.QEJ408ZSNf_\#DfQ\P
_QM;AN_,Cc.F&UVYe;K3HIDA/HXUD)9^2\E<KBH;W^@DUTbIXFT;IPa#R+1d_\[4
#GgeF_]^OTD8RZ(2_9-UIIZc(.Z98R6)E:N:@E<S--N>TI2?,F2(VRK9S3])ZH+Z
.C<5J\U7W=MFPUeKMSe7:_NS)6c][98@d2:2)I#T8Q1-^.1U_.C^GMf93]8d<B56
=YL(_JADS1]H?B]Re3K(Tf\(3FB+AF3d9WcVO.U/G+)1=4S]VKUQ,-7//bW5@K.;
0GR+FA]+@85KeY9.CdH.<=5D+?^NgfWA@bf)N0(H+1P1c+(+NH9+9GgAE?9LXd(?
eH#Zc+2Kc>&<^(HZDP<7QAIQ8>\JY@?@TVT.RNd_f12]B\I2dHT5#B1P4,O8TKLO
0fUc[7DPIaJ5-4+.J-[;E=)?3Sff@GDI,ST0e5fMDZeAR?TbS\](Q[:+WceCYNI6
PHW?WeP(:G>[d&MOf+\=fE3\2ZPZC8C;5>44LKWLX)1AG$
`endprotected


`endif // GUARD_SVT_TRANSACTION_ITER_SV
