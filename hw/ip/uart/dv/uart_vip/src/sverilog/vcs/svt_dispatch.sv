//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_DISPATCH_SV
`define GUARD_SVT_DISPATCH_SV 

// =============================================================================
/**
 * This class defines a methodology independent dispatch technology for sending
 * transactions to downstream components.
 */
class svt_dispatch#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;

  /** Channel used to dispatch the transaction to the downstream component. */ 
  vmm_channel chan;
`else
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;

  /** (Optional) Sequencer used to dispatch the transaction to the downstream component. */ 
  svt_sequencer#(T) seqr;

  /** (Optional) Analysis Port used to dispatch the transaction to the downstream component. */ 
  `SVT_XVM(analysis_port)#(T) analysis_port;

`endif

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

`ifndef SVT_VMM_TECHNOLOGY
  /** Sequence used to dispatch the transaction to the downstream component via a downstream sequencer. */ 
  protected svt_dispatch_sequence#(T) dispatch_seq;
`endif

  /** Semaphore to make sure only one transaction displatch occurs at a time */
  protected semaphore dispatch_semaphore = new(1);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param log vmm_log instance used for messaging.
   */
  extern function new(vmm_log log);
`else
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param reporter `SVT_XVM(report_object) instance used for messaging.
   */
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  //----------------------------------------------------------------------------
  /**
   * Dispatch the transaction downstream.
   *
   * @param xact Transaction to be sent.
   */
  extern virtual task send_xact(T xact);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
Vg9-^QOV8_VFIWAZ0>A>ZEF9K(TH-e@,3fA,.0:N)F(71X.JXA\70(O9@[dRI0A0
@.CRb67?\ZdPc=bQ(1A&JI?RHT<Ia]A4Kf1d]#(VL)4__beKY5FI3=4BRdO^5#X5
U;eW>FX52<fTZ&OOQ(Y#C5(D<#U?eMca.1/;e.^(VO+7+,@/Fa+O3M--[+1<Wd69
9V:?K<7-G+F(?;bVB]\c&5E31ME>cT\<>@a>+SF.f(OMG&1V@E+?[RTd:CA4(B6J
WQ)8Vd]8DE=2<.HdT-ac;@73+ANGE8BIMEN\3ZT[T1,,=/6)L\>\P.FF[W^.(_7A
YO/^-d)f2c[+[N>2f;bH40#HXHdRaB(:,cU+:&G;+TA9f@K,1]5V^=;Z6E[.:)-Y
TfaW=T[Y+LX+Y=KTYI&6]g43LN1RXB/5[?Yb/d^PIe40YT;3GO39Rg/Ua2YOK(V<
<@4>daD0XIP(Q_,00VN-+e3?,MSKY2ZEL_UM-g5=^/IWP@J4,H?LGfS\@dZQ>W@;
CB8IQ4,CfQ&-)RY01;CBYfE(c#G@NA5[=?7^Bc]g;[<2+4X7O>30/^8e3T/(d7<#
>BNXaU,Qf]^V8:<_PgI7E#Jd.P;XfS2]/X.<.9K(9)[I;,//fS/7DBN#Hg].&(04
aZU-/B:6/0T9KX.ANXS;N^M@c4_H\G&/&)(_LXQB_f[39(-\>/S<R?8L_&QHHW1X
W30c<?bBO9]1:QCc()Og1EL>Y.20)gS:N.-1IYLP&/8VT+H^WP@TKRSeSRfI@SEJ
N[QgX^;MY++G41=ZFI/[WDT3L6g=)Sa6[1XC)58ZFUe_IMO9-/9J^RQVE]M#OdO?
#S_38=Bc6->Wb,<F4f;]R(BbJ?8XSaJR6Ub&7eI0E.[AVY.FA8.UQg^e@[KG_Y>F
@456RCMWN.cDWC;4=&f&MXXGJ4/VB92SO/(G5/,9NDEM\+7-,1TE0Q4CRICT1WEW
FP<:N;e/TKL<8b:>?bVOcW8D:O?U.]:CQ]fWc:;UN9T+\=de^@/?RQS-KPX.RZ/I
Za_B0Q#H(TY3=_D925LN55ZdB_baMe&U/W&>>2HKT6@PX=8P5H8J3#K([4.(?)1[
L#GSUI)]AJBaRQd)>9742SaO)9,gD]&HO+S#3#VINfN-C=L5IcP-fa3/5ST:K4[M
e:VK8#AI7804RR)J1&Wg29(<CaL8VfZ8G8)2:>cW1H)@;fM>@YCL#-E=B1214]Fg
Sfd5aAM^e,T_ESgNP2NWP0e^aF3cB,NPRUYJ/WcVd]3c4O(P.3Q5-]FNVD8F-?25
F&LM:WfLH@<[AO&K&40_FZ.ed910e2)SF35bL;K7gN<LBXMC?B01gRN/XBRKV@79
:QE9R>@BL^XGH/0K^@42>:KLB_Z54JVaG1Q>,E_CQgS<>_bFCa&KF4NAHF90?;;.
Y?6TGA_79P[b4QTQF(=_,94a[Pa1/U6T/bXgC_G;-YeY3CS4X7E60Z;VH)J7eH?,
K3(1.7MX75W.HRV&4I76PT/#LX[Y\,X=[TYb1;Qg3,>TGJRJVP^SS80LWL\YGST5
;>-[>NAY9+=50+e]/G5c_FSC8#>eS:](@de/+P#:FWP3+>Nb(62EN:MM&IT8R<23
N,J&>S-(<Tf?JZA)[bb^WJ_#&ZH\9/DaYgCbYJ8.?FC/bFY+D],VZ?Q7RZE2;+8Z
7A(\WA[g08J\bQ;@XCFMY^.MK_,<g8&]Y+CA;>gI+;WM3L)]>f4JXRe8]AU(7RPI
M0d,JO;1Me#81ZMWN2FGV^YS,XcO@HPF_GO3VO_5#9U]\3Y7GWIDNQXGCM<N9NG(
P8=OQIW:2QPcN9>Jb+g)QVYVK=.X1QZH<>X&GF>JKdRZLa8,LZ7DIJX^R2GR1gE5
)d7Md(5[D&[9e5C3E-2B]Q[ZIgM;_VFBIYB/EaPQ[41aQX1#.BREKWfV6Z=-T/7+
?R=1N0H<bZVQe,56F;[;:7,O)-IIGN39QKUE/8R?e^.OX/UEBV@5.fPPLT(fP@bW
D8^6FTSBbaDc(IT;,<4,#gE([+]<WE2\_R^BV2(PRLU_,3U/@DG)63Zf4O0H+3gg
cXAF_^3>e2GRYMTG(TS]&7_V)(0U^6D.E?AS8\3.g,bAS/6QDe_/T.BaFYfOSXVD
XBa-NV)D9f8PUY;:6f5BIfb(E9Aa0&DVV=-Y8M1NeYV46WefWaYFQZF)\AO_I:S]
E4aKA:^WH8A8/-@Lce+Z-EC\XU;a/O1.)NEadY.Of6U1_KQYH8CIS^0eWEfP0Z>]
^51UT9/GB@aBR=dAM+G>9C\FVf?(G?VX/#d4EWMOAffJe.01UV=W1K85^O;-P107
4BA9O\]\&J3--SN5K91gaTaNB8_U2B4b&+;2^fcM+gfNV,5\Q_:AYCR2U8BZV6fT
5(H#R&@/eF-)/b)61+>8SR29X3eYWY6Z9$
`endprotected


`endif // GUARD_SVT_DISPATCH_SV
