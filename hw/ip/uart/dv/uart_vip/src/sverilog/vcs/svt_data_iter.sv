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

`ifndef GUARD_SVT_DATA_ITER_SV
`define GUARD_SVT_DATA_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_ITER_TYPE svt_data_iter
`else
 `define SVT_DATA_ITER_TYPE svt_sequence_item_base_iter
`endif

typedef class `SVT_DATA_TYPE;
typedef class `SVT_DATA_ITER_TYPE;

// =============================================================================
/**
 * Virtual base class which defines the iterator interface for iterating over
 * data collectoins.
 */
virtual class `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log used by this class. */
  vmm_log log;
`else
  /** Reporter used by this class. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_ITER_TYPE class.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log);
`else
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  virtual function void reset();
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This should be used to create a duplicate
   * iterator on the same object, in the 'reset' position. The copy() method
   * should be used to get a duplicate iterator setup at the exact same iterator
   * position.
   */
  virtual function `SVT_DATA_ITER_TYPE allocate();
    allocate = null;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position. The
   * default implementation uses the 'get_data()' method on the original
   * iterator along with the 'find()' method on the new iterator to align
   * the two iterators. As such it could be a costly operation. This may,
   * however, be the only reasonable option for some iterators.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  virtual function bit first();
    first = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  virtual function bit is_ok();
    is_ok = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  virtual function bit next();
    next = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list. The default implementation generates a fatal error as some
   * iterators may not implement this method.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  virtual function bit last();
    last = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  virtual function bit prev();
    prev = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list. The default implementation generates a fatal error as
   * some iterators may not implement this method.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements. The default implementation does a full scan
   * in order to get the overall length. As such it could be a costly operation.
   * This may, however, be the only reasonable option for some iterators.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length. The default implementation
   * scans from the start to the current position in order to calculate the
   * position. As such it could be a costly operation. This may, however, be the
   * only reasonable option for some iterators.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /**
   * Move the iterator forward (using 'next') or backward (using 'prev') to find
   * the indicated data object. If it moves to the end without finding the
   * data object then the iterator is left in the invalid state.
   *
   * @param data The data to move to.
   *
   * @param find_forward If set to 0 uses prev to find the data object. If set
   * to 1 uses next to find the data object.
   *
   * @return Indicates success (1) or failure (0) of the find.
   */
  extern virtual function bit find(`SVT_DATA_TYPE data, bit find_forward = 1);

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  virtual function `SVT_DATA_TYPE get_data();
    get_data = null;
  endfunction

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
2<5WTTdP2eQX):Vbfd@[XH\0YCR?W7dC#@49JEf,2Y.e2)dB(0f11(Re9JN=(>/0
^1gg-J=HO6Z272+8Q@de7AGN>_R1HaOCM[_-=D(C3OI&?3GdX^]@]6ab3g&C-19U
FRU-+g)Z/N7U\0>gC,<I=^OX./#a(T,Qd#\Uf:DQ.6JZ(27;-I)?)BT8Z@<;\eQ[
((8439?8(>3@fAG&PAQIH_V<Z0(#UM+L;C.<C4+V,ZM)Cg#M#L:L4WGACDK_B\<U
3QB/E=NG0EL8-K0abLJ-=?XKB@@=83bUBC5LJ>GIKcf3IMC;[ZaK[Y1._?5+GG+,
0Bgc\>2_cLTE-M^:<C\RN/c970IWFf-X,b/O?(:S/Kbf>FZ<\08,W3\be)7G&@fa
4\?][F],fb6LRPX@P6d3.\CQ71^H)GHbE(S8AAPPbC&[3XJCZO29+aS8&YHD0@4(
5V5U)JVW0P[5R^:1WT>6]cT,BLa9<J_4b3-P.XV1TZKd.^^XAfH3Hd)O2dEeZH?4
&TXa_WZ:B.O,TICUbIYIZ\-YT:,W#1JVZP<:Y/GC)E(V+I6ED?&GbSDc6G=54@V8
R/c-T:#U.T0_,@_;5&db[6<QJ;N8/?e/1O]]1LQ1;#(6FZY\+VOVRAE2=/BJ_INL
Y[<K:U:g,\/7@f-aKWKP7DD5>?BQ4<Fg;5A6IWOJ5Z@F,F)X=Y/XAPgOFC[)\/S9
Z=\/(J?Y-A(DQ5Y+:8DX>b]ZJS),5PFeH6KUeeBfSO\Y3G.)Laf_f9E-B8;5cG8N
dDgXMJ3]Q7E(.0&(??NE3<O=c&KS8LDU-_fTHW3g3F4<)1?>&-9A=?HL8f[293?I
AfgGDB70S,9/JIBgDO><.;fT<0>:6JJ]g,F_bLcK4;9FJ)c0Zf2QL0+2bH(Df9WI
](8[gJ#K06#H7Ka]M4^ARUBWA^A9cEV=2)XP-^&Dcb?cC/^ZPFVcMIBEFT:DN&&\
&A]ON7U;GK(CC5If(ENdE3RKG>La6C\F8K3ReR,O&3U:<aIFf(HOgTQSV>730cP(
YRWVbFPF0Q>^26M2+VC(S&GEW&XcME<M/:=L5WN)\c_.&M@IPWTE^/8-IBNY1&JP
SbSg3RZ>Ke^;N0.@;eaT<@0)2/b#/<aTb]63g^&W/J[6O7=KTA2S.#\c-?5.,L)7
_cGfT>DK]^H^ZJ6a+L-aL3,fA5/Da(99gCdaN^LF[6H6g,]\.AgDPOR9abY:eVS3
T)9=e>SBb.CV/[_5b/?SH,U;cW(6[LHS&Gf0T]5-39ZYd09K)IQ](+WWF4b_cNS[
=CU^/e>ObHIP9ddfYPUGZLM@BM4cQHG^9bJ44RK@QeJ@HQYV4QBZ2?ae#W[YG?UV
QMNO/5;U1)<7A4KRW(OQZU]I9AODY:>G.>)A=Q[ZBOJL<K>>(BC#97#3P(5M0YFU
HOJ,,aDO<f/3LH:BMYT>XYAZ;:W;C>^@efg\9XU[[Yb6=^TWY,Z8>aM0;g_1W8,8
;K\JD[a=LJeN(\e+U1P@7V5G9BN,Z=#?\caBV=0c)Q1\;]TU5ZZ>@0SMR).[,\c<
gPN.6D#R#;I_BC32C(PC^4Y&^I/]E.XMe,LAGQg5AWb(8@1JLTR[PPTAH7,X=R0&
)72Yf0/=)\fBS/[?dg(8L7dI[bcC&f[gKSG3_eKG,=1fONEF.W-7WF<;c,RUVG9V
6\3C6J4V_WEZ\/V?=CA>H(Q=YE/=E:-/44B7>6bU7H72QRI=>,=LVN;YUcUV\O<<
K2_N-DUd;B_SD=c8.0/W;NSD>:=gA@J]fLR=^?A2)2),6<Dg9QOK.K6<c9@TC;.Z
d4R9ET5QJ9g?#eD@Ea(b-db,CWZJKd6Rc.RH\9@K.YNEU9;1C1>?>UdXe:UP;TK7
SZ8WR[ZKU@(>V8,?B?5g7EV90TfT4H&.Je^LNY)dK/]+aJJKF5Z5Bd\IM1JIbfOM
I\9D4Z:[baS]@&THLWBG(Y3;DRV#V=(UM0Y\=e\Xa:)P_79McPeg5ZKJP0GTF+2+
TYBd?-#X/[7<@DfJbYA5I>6\N4/d&0(6_P0#e9^Z^9O&L-)KT2]WF]g,GIQ=;?6[
8g^EJIA-+]/8ALfT)?F;COL1F9@L7R-)A2U-[EILB:7,f&VGP6]bX>:2)OYY()P1
\SNYd=Q?e7dCP)NAD8c)BW5=78+[bW:>>?XaZB9<8Cbe,/\&638&[DHUe[G,@\@A
+54SF8FeD29K,<JfMF[U;N-2CD3F(IeeK.a=4Pd9OMcMPbW@WacIcGN/;BKYMZ.?
#ELP8@7\;NLJYAF4;_;Z&gJ7.:-R@9+PXM+:J;)FLV)P@SP#-U:&c5\+Y+T;-613
OTFD=N4+AGC4HZZ_a9F1[UEYOWTI\+UK1TR7aOg&Cbc5NVcb9d;#=)1A9A,8YLG.
_N:0(1b:fAD9Td\R.@[E0fAFDFDUNAP6-S9RQC<AgX?NJEY.W3O<[/ULVWW0T<)B
4ZV3?>)8U7B?Y3fK,1OC+PbP)X?@BeE/N+G9G_e^CbC>P/Pb)J<F=T--DPDe7MNg
5(1g1FaG;@#/b8c3-)aZd^c-cfRP_=5<>fM8](K6/d7Pf\[)H92.TFe4&Ga;)3R2
Q57]4USaHE5OcAWW(><JH#cCfFS+<0GXRMU)?B+Ne7.E5;+A/fX:KUTZ;)@.CZB/
,F,DUW;]0#XP&Q)<bJH)4J2>549]P[D?.6Uf@4/8CfV7.X9PacD;7Pc.=^3@OYgg
L5:O9HH:[A8K\L)71Fg)#KO9\A@:g99(a6XC1K@ZBe;+ITU=L[V\BQP-Y6&PP2)H
e2OLDWZG?^CG,3\)]<B@Iaa42EY5ATg]RgVVH?-d<JbIJ?SNU3B97A@##&YSML<S
V)FYe2H3d+2NdKN&,YZTcGTE+(W>BgM-5\O^e4TGA@eC[H_VfG^Z@KLL7=,MeCRa
&99M0>@W-bA1EI&+]@0(/&C:\0+P/+M6>d3QI>.((]N9.:dd&/([c\)M9c8/Z._\
4Q3EdI<c+WaL/?_08>D-E^f3I8MKBM^9dRKHMNRG?+WPI]FUJeE>_M-^D/7G^f#R
Wd6,:H1+\-R.<H[b5><>E0UE(44:NZ2?_.066D2X#\H/K&::6Y>0Z,/fHNff.@cY
.=?(58Mf.LZ(3a8(E]MCMFaL.V5O52=TZVEA>ZU\F+WP?/A>X5:/5-:)@W=5AN8O
;g.-XH9]/Y3Ze?TV1_HK;LaK78F2,)W+C=<G9V]D_BPFCM-FgR?FZ;-/63e:g/IJ
,WE3HcNFdQ>I:[]2H.\Y,8dY/;X()^a<UAXH]2f6M?>aG)SJG)9YRU^&4Y#eGSKY
4H++OHeU8YB_YQ^0&0-N732T=UIf-I3dg+R4[GbXE=b166Mf-<@F=YZWZJ&b_G/Q
McOf-eQ:bEgJXSg0]G)8A,K7#U&e/0[WZ?=19_,DY0?AK4X[9A-Q5E[AY1R2Ua4A
>O,bab8D2JZ4_-,/_Y9=I(MeT/dU/e#S,(_JL6Ga_4UbF(JAeVB5ABM:S-f[A+DC
D:/W^EFVI<4GVI5SCB63VV7VF^:YN9?]X48+Od#QJKe,BZ\2E:eHYF7]b89E=-\U
R)3Wd,-Z&4T.Z;XXY75_SKO\&J4EN+2D)7CW>aX6b,_B#K\<->#A^,8?fJOLZPE]
5L46g2&BSg]^UJ@Y@6_3/6F#B=d9USVP?H;NZJY=EP/&fXC,V>OI3+<cRW&9P,Qd
>Tg1[5V9eF3-7X&_dTFD=P6Q+I1RE.B.&9.<AJM+.+E4c=HBVUA)c<SMALa9\MfZ
_EKIAH1fQHNIW^g@=YQUNN)F-NEXH-9SaBOZd7PDTE>-L_U?Ee]]]+S\G@DHN5G8
L86-EA:Zc]RCN@,46L..QO_4VS&R]dU.XSbU+(UPN^WBKUfQQQ3E)03Tg+f?cFIX
g^c57b-RL&=7fWX/(>B_:F.]Q&DO([7[Q=.=99NaFZ/R#=37UTEHWVC/,SEE.[bY
aC-OPfSbQHB?258W#T6FZ+aTX]FGfDFEA3#c0bSBdPB#FE4+LffO^>aF_AKF?/#,
1V-c;+a/aP2[(7TGMK4GZVVQg[9d9<)ce3/fUMMYU5A?ZHfE68ReFE6.,@DX=(RY
JE)44\aHKNO):HJ;Z:5A3DA[37?\U\TF9I_bLB(&X:0=&C?P6B_E7GYceA](J#Bf
AE8IbYX:GbN^cDMb8W[P6D_LS#.C7CP:Q2&)dMSW0DSLKM#Pfg6U]+dTbWdWM8;b
F49>QM#&gR1G\aAVYP-MVEg4cZK,R>FFBa6Vag/F\L\958b]a(AZ>g##f7DFLS#f
2+^,851L4=G5.5OE_b/NX>dggC,>S6;3=(EbW7.BCVD\D=)dQdI+S4aE\Cd315eN
(/=O_ZKB8N_G>F9de^)SS@X>[dN[GJCMcK9F[M7U1_Hb=>TA)/CA=#:&I3:J/=I\
P7ES>:SA31D6+U<d2>N&CA)_0d4NM.Y10M)c4aLg5Ta(\;UQ&+W6W>MAY7[@IfV:
5#J-1\H&F396_Td\C.4<?R)V&(fCDQ&<CQCe.7XADZ,AHP_U90<T5?]d&?HJAVF&
+8U3:Rd/8ZcG8_IY^ccH7:M?5YQ3b]>[G[KCS\_]LYDf45d]d0&4#5H9Z_f?a6<9
(+X)3:?+T)=SJK563=#V9=@MYc-43L_?,PVT6VU[UPa;K5fe.T3PJ7RH_6/:HLY@
9>00DT/K:RVS7X0H#9;E2ceSG:QV/4a/R<bb7f4V_^5_B</b?X@3<P5.d>&bY5,.
^ff9e/:A<T=&g+AQL9V#UG-TN7dLPNa7CU>OM7G<\FLA]\?LJB=;((#1KJ1a6cZS
FY)&AQdQ&[C@.7R5K_(-H34:;,@d_+^X=HC3c2bK#UI-dSB[E/a&+@?VLcYL:5d-
WU_W8XJO)1)>[e;Qa7O:#He81&D0GDNdVJ5dgJbX5WF4>XTRN(J61R](^?9H0IV-
X5b?#DaF84R0)K;]?;F-V5SO6[eDB5U)[KP2a7#+(0SOL1_VC(OHae](K$
`endprotected


`endif // GUARD_SVT_DATA_ITER_SV
