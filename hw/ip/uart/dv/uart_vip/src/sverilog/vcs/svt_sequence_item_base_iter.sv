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
?(Ae?;#Rg0B>]BDQcII3EGD.7;NBe#L=beLG3I48H74gS81U)CNP)(f&;2HJT<ef
.^;\)K_[c_@7>?C#aPQGS#ZH<3L)&IbY_aD7-RRcC]gPLY)#[Uf&/_;)ELg:M\(g
LX<>Jaa-\]M;b#&V_+H?7)7PB&9LH+c6HFGXP:N(Y8DCaJ0g>IfX]O1V3XC>Q5GC
HN8S/UB8>1Q9ZBb\[e2;=U-^XTI]e;1S.cId:c/2/GW#?Wab]1\B^d51=Lc\+dU[
6[LT_J73ULMa\AZ-H,=a_g_N=B1e^A,B:U8:]^08&F,\N>-c)V&Bb1#K^K5HI+.W
#PcagI1SQK@GNK^6N)>@SHXYVK6WT-KK>SfX>8G4EgF3>g,Be>+S+a(NNcW;XL/,
L6\\Ge[=:f2187,eV38T#YI;U1NR<+ZfP<=Y[Zg1DWLKY:.)KRefV]@=B\A#^,9E
&0I0f()-A=ZPMZH)GZ(@SF?U.80PQIW]<W/QTB,8S8J+>M.1<?YGU@.-#A1A&ca(
DS3ORca=6Sd,SY3K(Z]:9?W4Ed6YVCWN]6)TS85GgC+)2=(+G-UL>03&/f?^2E<7
9<BZa#XP^5X7a)bb?aRP1KGHOWQKPKV]?>]Q)X-&6WTgR=_1V<TB^U^3WDU[7W?N
8f4&<@Y,7^D&I9H@3G(L.\[-e<bQeWOE)Z8NTW[-YdD>AO3=D18B>fXRO[#LF_^d
=V,gQT7Dg+:[4>Z9#gL17LJRYKWQ]g)^<;<7/fA:E=>UO,d5EW^e2@)QBH#Ta-,L
=/f55:9G)&\BL)f69(-^WNT^XfIFD-65_d663bW>DT3Y)Y)RZ+9dZ)3f:03aaP)[
UPZY2BYOV825c]3J)P.dKU?MS7eN@>I3aD1T/<2F3.Dg[<2\#V(N78aV^Z:B^8OC
(#(PKAe3gN=BB/cV@XSRY/4Haf[AacRF#[41-,KW4KP6_3AM7=VZ6X^#/1._]aI(
C.cgJ=A=S;KN1=XbQGN9:<)A^UBOS\HFNZ6?B=A?C86=E3XB^=HES:@>@J531K_7
E,dGN\,[:Ca)db\8&F(Y)ZgdQ+I.8gZ]LPS7CJdXWR]FIX,aI))ZCZEBWa<2+5D/
7^>bNH@A8LG0MAFH@+U?TD<CKP5).cWf_C+_R^Y5]KOF6O\);Y)T)J0(^^=KgeHV
8dNE3:\+=4Ib?#TTQK[=+.;S4fW\H.\Hf.WHHKUg3&=>Ka6>@FZ]/UcF/VLH_4Fb
NX,@dOgD?#Z7a7@f&&e3+e<(;T1-4(9V#ZCFCXgO9;=8E6c:4UP\?#VbT8P_Fc\T
4LT#<g8E4,#a6f)(FgOAOKR\:+=B&AI?O(D&e<U>:.Qf/&U[8a5<,PPcPg#-#LYR
6.a&6VHVe,FEcAXN55XdI-V+U38F];<DG/c[5J7g^0BB40(V(O[^^TcC?GXBG),J
eD,BGe:c160X\S>GY/MCDP;TCeT#GX-ePVD@afD]\:MC5N.+aZaO+QcYZ;:4.[c)
6WT;+O/LZM/AG[[I=?,LTL3:QK5;0a[X1,L;N4g;gS(5)D.@?BH,GFB?3XaEd1&.
8N4(NcK3X=d^.B^T,#DAAg)9F1f>R.7V0>T4#ID1S(#DQ#<.BL(^H=+^:5X]^^CP
4>bgU6CZ<BLCdWg:+K=SD7aWAE&V_1/SLE+;T)-:RSP):S+]]/T&Dg5@HSZ?2P&6
QTe#.UWd_;f-,H/Z1HdU\<XW@-O&3YVW.3TY6:4XNNHg9H\:J5<C.ZQ5D,g&#3+=
;U]\_O+X0#cR6S[-UG8>\[9WbD2=9b4NTZ8c6,9IVG#cB_E]8\E5IJF5O3@H5[c/
QO/:?e-gNTEN1F;9F:[,)55G,Z^V##C6H5RE91S(:T&P>Zg/9<^-XN0^V_eSM&fc
5PF6^,QU9G-JZY_B8S(7X:_F#2E,KX=8)/ER?g3W;U4Tf<2_LXIV9@<?1:;]?;a7
6ML7@)1_SaUZG.(bTf[(PR82@IR[)<QG+6BJ3P.M@^eZF7>>Z?(R:6P.)TP)B(X#
f8D2g5NH2N&>70ILS@Z[d0\43g9bC4bAMCB2A\F0Ab0L,K,OV2TTB#IZ+\9S]JX]
)1I0;GB?5#N1TJI)Q8bR[9VdECZg.KNcIR6FUO/#Qb,GOcKF_9.cG=_^aSUGXb\-
@4^fd_CB8=O^PfQQUJIgC&R0,DLLNGE@T-A;O/J7C6Vc2WaH@c#(b=5LSV/#e3)G
ac=^e)ZS-[R--4K7]XPA]90A0]Y_NXBFZ>E92.-+Y=a(^9X).@ZPdUC2<90<0:SA
+LW1)>\5_T;V)^K7F#gILb<Q,3I+4DeOFG#:GF7GLSWJ+S\d9-fWa5A?_>O?7OFT
/d?NJ[Bc3Ye\@GN621EVPSL]?YXXa]&F<4Q0V^TYL=>73DPB/RIc#S24(J#.]JGH
K6(;EQ[8K6/IKI;P=77T0(@/,?@;2U<[A]QE_c+X]^/BeRX-c)P9L<+2?C<eP053
G9T]_2IU._e]\@cWV8WEa[7](9ObSQE+3fI1ON:.JN[AMTLJ)WBceY:&FdgNSOWf
b[T?F5_>[B,>N8GeT]-(G?P:4Id?(15fEO>UKMG^&),)R(0c)389[J.C:\KTQ=gP
ZFGIdDV866(,eaVX4H49D=_CJ-^:0_bWU]HF<[XG;@eFWde/1Z5X:ceMFMF8F>8[
Yd1\\b-8_>C[A3\;/FAcLgLM=V;7NGI;J6eZ3JK:N?VO_Xf=gU6&18RM&&K;[d\T
KX[GS;U7C.QRMb/RW6QP=;HKSQ)BgUgHZ5AC7&M6>?[MJ9&g81-F7(be^IB4LCDH
IB2-=aY\#B;2#bMWR_E7G(-a;Xg])^=g>(g;=e,XJ7R8MYQ:g/[cLV,_aaIb_86Y
W,-3O^G:D0.AcC5(MJ[&?YZ5M7V_@(HNEK=L#5YOR8EbR3(6aLNA\OJGGIOL,+[5
d08eJ_+:K359F(]#OLA:4JH2f<,dM+-EC)V(bL2:/QYX?52;@.RHQdL9A>0e/KDC
YdD+Mb:01IbfV.B1FGHPZY6RP9UJ/0P;M\DDf\E4I:9F0.KS55B#Kf6Y=P66Qa,Y
Ue9gGCND/16J\6(eW>6C>\QSc)b+<c:[3>YMfQ;X8]PA[(N<QM?TWeUSHU:Hg(M^
d7?.U4K9dJF1Z&2YMUUAPB@55J0LP?V+GIS><MFZ:#?(]8XL#:FTQ/)F]F@0UM2;
O&1T=E?]Sg>XW1]FSOJ4K;;Bc9(a9W#E[Me6J:(VDPE(^Gc#X\Be<([X72&Z6K]<
ZL_E150XXSVK4B>=W&K-Z+4b=OQ+HKJXJM@X>f-YLN>^[P9SV_CLKH5C<PGb:57?
[<L(52<Wa?;\VSJ-O]@R&F8HE&^DH;BJ_:[//,\#U9@bO,@DXJK/2A+6PDb=d,.(
H6ZF]QWdJRMI_NN&T3)=^_K<EQ.XTQ5:1_S5A#A:?]c#XD868-U(dDNY&Y&XL;D/
PM9PHI#DG[108R7G]--LH?+UeT<-H=XO5E4cf5W?X8+T,NZ/HC80D5-b_fY^+=G#
d@UOEQL/4U>(ZBPZagC)Z;RH9I+XLOB2ZQAT16-CFO]@#0cNDJQ=5A._MNe/)4(g
c#Y#6,](<1G6ebK.WC6F8+AT[WCG;-?[CK#:B(cLf,7-RdH=(.[;#d2I)3Q5V/fa
TJS@Z/:Q?\Yag2?_dCEGMb5-SV;IQL\OLPf/M2geg1CY9@Ta+0R5#U<^)]RF0S]O
=Eb^#[OfPOSfX8JQWVKT+d1aC[=T^CCN-FD/#Z?aPJK_]Pf9)?I#+K@26;6;bV9S
(;:JdZ5SGf8/(aX2-cO,J7/d9,&bdY>7V77AIRc4M,?@F,HZ4;EI]f;WBVYN48GE
6@K[a,?8]57GZB^O9K](;3f-A(A\Z\RR4ZgJ@XIYP<-V=;]:B;BNGbD?\)RW\/J4
KMSJ?#A]V3A8EWRQ\DM@ZfN3-@>cFRS3/IH=^CCMI;S=TSP3.O01RPN=dZ]2&\aI
=KDZ>>[[V3G.F>V@d=K/#e^W60(cF#-2J0eO>?8+/TZX+cIbS8:[U8aTE=dER?>:
(4AA(.+Q6PbBO/\LH]=D#7RRY8OB.Vd4K(L7;&G:^&]CFdR[,bf6IYE]-QPO+Df#
U^P0?5NMCcVfUA\LCNFBU&/f<]=Q+@7f/4TcN(,[Cc(&?JC.NfOed+036K.fH/77
3K6eF\JKK;S<N<QX4F<P.@8,O+H9W::B(;FMKFNCRDLL#@GOd_3H6(\\LM&#CZVL
S<a\#MX;BWODXC2:56f1@@C^7#<;))N90?]K@&&CdU6F5PXg?_R5DJ.;\;Q)FSG.
aI1DF.,IbIUEU,UJ(B:W0J4=\(Lc2VEaKQQJ.D/7>>MSMLZOK+H-UH8DdMGd\35E
[bHU_eE754WJVBLcFZ?:;+Q^ZWR&0CL#S:\:HB<6O7<2&d8VM2#^dTKLQ0Wf(5C[
ab]:4dX[V]U^6=X5+c]E5[=IH942G-IC=[MYOWg&7g;KIK9FfXTGLOX/H^9\/d8H
QB],N)2?RCRC=X9#H^O/G-B\M@>6(NMAT_KdCN=:?g&C\T9(Dd)\@O64g_M]Q,;4
J5OWTEMUdZ=;[O/.8Z?WdP1g03K8FW,+Yb_eGMMe=\Z9.gT&Q@4dBfV6)&eg_TB6
#bYF;3>JS<C\SV:&3Y6Zdg/ggR\aJ9CJb-[S\5dF=SQE\]SECG(;06EW6f;GF3]>
,5e\I(e:J^5U+d:_Y@ce9^:I?Q?BRC.,EV4<]@Y<9e_B;E:K1(\UO#:I3Z)IP?\Q
dDOU9J+9./e2Bg0C=NC6KeaY5\@a5E>CA>.D_+PbQ\\T_EOM#M5,eND9M[V#=bbX
>0Z,T5VS2\ENf,@4gf.+ed8LI<)0^ROa-L6OAD-g07QF)O4&D7FWf4576aSXV0I[
cJ(E[_KRP0b<R0F<^M4dTX,A7,dV(:)?cd.\GUUN^JAcZ=+6./A6F(XVQ/,c6LFX
f:945EAWfKf-?LG&59:V;JK/MJD9^)P4QWLg4d3(]#Q8>b6P@5CS6#XVK$
`endprotected


`endif // GUARD_SVT_DATA_ITER_SV
