//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_REACTIVE_SEQUENCE_SV
 `define GUARD_SVT_REACTIVE_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_reactive_sequence;

/** Determine which prototype the UVM start_item task has *
 * UVM 1.0ea was the first to use the new prototype */

`ifdef UVM_MAJOR_VERSION_1_0
 `ifndef UVM_FIX_REV_EA
  `define START_ITEM_SEQ item_or_seq
 `else
  `define START_ITEM_SEQ item
 `endif
`else
  `define START_ITEM_SEQ item
`endif

   
// =============================================================================
/**
 * Base class for all SVT reactive sequences. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_reactive_sequence #(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequence#(RSP,RSLT);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

   /** Calls sequencer.wait_for_req() */
   extern task wait_for_req(output REQ req);

   /** Calls sequencer.send_rsp() */
   extern task send_rsp(input RSP rsp);

   /** Called by wait_for_req() just before returning. Includes a reference to the request instance. */
   extern virtual function void post_req(REQ req);

   /** Called by send_rsp() just before sending the response to the driver. Includes a reference to the response instance. */
   extern virtual function void pre_rsp(RSP rsp);

   /** Generate an error message if called. */
`ifdef SVT_UVM_TECHNOLOGY
   extern task start_item (uvm_sequence_item `START_ITEM_SEQ,
                           int set_priority = -1,
                           uvm_sequencer_base sequencer=null);
   
`endif
`ifdef SVT_OVM_TECHNOLOGY
   extern task start_item (ovm_sequence_item item,
                           int set_priority = -1);
`endif

   /** These functions exist so that we don't call super.* to avoid raising/dropping objections. */
   extern virtual task pre_start();
   extern virtual task pre_body();
   extern virtual task post_body();
   extern virtual task post_start();

   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_reactive_sequence", string suite_spec = "");

  // =============================================================================

endclass
   
//svt_vcs_lic_vip_protect
`protected
A\5H:H3(8J6Q?S(0+8&8K_^8KZc3Y>;6(0ENB-O5+JQbV8EB&I5-6(]4P:-6aJc+
aRQ1b\/??B.9-;80SPg<1O20WQ@;:=IUU@NC-MNHeHB6W3eW:[9KB@^5fDD,;g;I
He+/[J3Ec[=RG_<(gVIZ(W4@TE5AKI]FJNd3>XO/N&((>NO:L[O7SDYXR0d1M+e.
gKc\gGJbb:;7#\L54b#MaAZ;S79/=+J>U(SDaSTD7fPNPca@_4)^4AOPAMSKg-V(
6AJA<T.,aTRB8TAP36b@4_QT[2Z]9d.51;)R7e]ZR,.0P]+T)RX7<SRA)4F8Tc7]
)_5NV(.<,:d<U\W2_/0/7/:aPa11Aa7ES5?KY53.1YDf[R\4&_0L\&0(M09Y[FdS
A/389W>I^F,?(^A>#P?=C#^GQP73C4Qe,23,4M#+72@(.N,cg3NR.8/66a59:Y1&
6BbZ224#KBS_.+-@W#_P2N,\Y::.^dYX5_\/?:YBD;6IPS[B.GcK6Ie7)ZLA(f<=
_db.[O6Wd3B.GY]P2?XCV<4e/P:d?[#4J8#8/(;_0KQ4+TH8,_CK^ZUD3V,g9J?]
0MEUJ\2]N8,fQ<eZ#7_3U+Y\aR@1.I9^I=BN)\J+GD<O5R0,gLN2c_@^[GCYVee#
Y6>FBO?FcP,Z+BX^Le<+(a-U5I#:2&e,Xfc2Z7/704NRUg.9g;Uf.9IeTJ&@fgLb
)S-&0<(65^LUPLfDU]B27H5MJeNE:^fRQ=:C-3_BL\g#-\8e>EJ,8-4[g-@3^+b<
IffFV8CJ6EGB1Vee5B2C(C&[[@Q&PcUBB@Y>],f4W3Mg58,Q0bA@W^W-;MFP(S^S
A4:DNTLNS2Mbaa_,&T[BC)J-:bFA3N[G[H@45B\,c&::42Kg00HI;1c1F1R>4#<7
>744^2SYPAOFM.D.cXM4a3b2aH4I>E20fQN3J?-,Vf2]282\fVaDAW]4)7a7-,E2
EbU4Z)H8faP^DMR5JNVZ-F;;eeW+8KA:E1C3TL7:Sa6-PTBROYQ3T,/-;.A>cHUY
K&E&0TZFZ9JgXY#I/YR.dYB<?JQY[cGE85^\#,F?R3/\N<>0Kf<CT7SIK1TYJ]1M
[WV=VK>c9[9=AP>gdC2LL9E/2YF?d7;RbWP_/gYQgWG.S7,/VfH5@\+??^0[fHaa
(G6O#EeE2K--+,DT[VYWME5JD+fNCQV/27fC9Ad<(_LQa)cWY&U6f8K<<NgU>\Gg
08?>2NRL.aa#0&>dQV2GT&6E]c@P>eaA69GOHdXM04fT4HY^5)a@Z)-/GP1V7b6C
T#/:C_ZZ6<KP<TR>P&33/C/&6eI+]WU[MHG\gGGPWa>P1HCc66e/FRKFVaf/HUM\
(TP8:^S]EG3+U<b]T<3BT]Y[(LN^2_6&WH>B2UZd9O&H,_+:D>^>5>>[E4VU+.36
E[?eER<ZbSD@-+X,Teb&Y]4I7d>aGIZf5eb&4H.?.PBW4_T?0_@NL=I0=]T3cAgd
5bLgJ9JD#5H601T3b\U=P=VMf2e2@]BUc,4X7M(@?WGV8)ALLOc.Q_NHJLDX+K4c
N5^YA<EXa8X_)b\FG\a>#_7]0H1RGO[@^>H@/T0E\@fVC+b.[f@Q_(MDD/\Y^M<b
9d0Lb1OP/WLc^=Tdd3f+eT\EEXK/>RU&fV=LF+f]]0?Y@AOLY4SCJD0H^cfH^OT1
Bg<a]4_/2c+ZMV)(KYZJE8:-IS5B]3E9OSEQ:?d7aD#)_SHCV/(>3LJ,Z6SG6Y)1
H4,=H=<I6<7:Y.DY>MM-)I0._S=L=5D7;]DL@UHJ@],X0;7UH<d&D]^(A&+2a<dW
8+>dE.>8cX2<?TQc.FBDB[9UAXAcOdYXF3E\F?.6:I6UHF(538CBB76=Z5_D7KEc
3+QfY1;9BBO42].E-BbX.F0bed#(D[;#+ETX?IA)#3KeZNEQ&c\2^P99P42a1[VV
)(WgCD.aA<TPI^g]eGd4OBJLV^[+BU]N(1=)Q9R^G+=IWQ4OKcC6b_2V1Y(S,L>=
04gI[5C3)2@aL_ZK(5IYbT#=^#87[0@#Hg>Vc,JO6\B.UT:KFa0F7[gbRP0_bB1^
30Y-,1VMZUD+7P(Ze;K#6<a[FZ(W9BSGB92^Kb19.L1P5,26\abQQAFF\J(/aR9a
MP.KBF6V@Z9)\OA@9&OgcEW+YU[:@1=U\]5T56<(I=VYIT3X&e5.N>:_CeF&;\e:
;9+LM3EO(I7ee_4C@WbFVV,KHGO1O:d3gM4(B(^07M&(ZeB[a.&Id<:N+-PZZaE:
OU2]BAQ(0X3XY0a5,81N/#+EC6gP<C(.;gUJ6<OCDT\O8.W#O5fT\21S8D28T(E+
EY7>R=,f-Cg.eXLUT:#R\LNRcTL(K[D)7=9P,e;,81>d,(f#?7Md#Y&PV\8]JgI)
?S2cQ-3EA)/7RK/QE);GT.M^S+EWd#KO#/ASMO=4K,.d+BKI.<M/;cL&,WN0AW7-
6Y8X],W[89R,IJ;UH-DcF<dF@O1fOCK#M(R6R>NZON<-]c/\8b8)aE?M>NXGR?H6
e<T:aU3cAS:b<]6F>M.MFfXOA;6U<>\(T3b.4Xc(,dGU+)AX._@4MC2EF]R+Qg(J
Y?5Pb\RNQJ2.?BB:THRg0e4BHY9-0@8X,gYL#@?OF?JeQ74aYBL/b<e@5PS>&8F[
H\Zd&??1)W)Q?Vg\^E]0A.-GU:W[<G^Q)\C\b>gPIBBXJ_Ab..X#RfPH2J&^>/=_
]DH6dRF;<7Z&GX?&X,;5<)]#135>9>E?E4/fV47_)6\+>[8QReX4UPL,^^/Q5bgN
B(TS\^c@/(LQSDAW-9#NG)+SIR;V\H1eUS7_T32FAJO,bSLCVR;2;PKXWV60D)X,
72G(g\269C6LB/EHTB==#JTNB28FW20K<fI>__M\W]D?aD#RZTg^(&UP@SQca+BR
4C(+#CcJ9A:_RdHY.CSPAb2F30D^R]L5fVNf/G&0aXHG^L2/V27::UH)X:K0/?_a
X8C(@^S(W8KH3,<8IR^g\1ReA1KPR:E[S&eg0OB6<d5V13,;f9B<d,+eEL:P4)V1
2A[>TbI-8Fd?TAA/:PEW:-e_:1]fZPP;65)\)F;+5W/M0[Yc5]I@[bJG(D_1#5M1
\)?5VFdGOM.GHQZ/Rf+7890RMgN_M1#7><=N8Jd70cC-d4gR8F]I=NXHbR<]?D)d
7_Ccd=c)U3f236-/dPI[2[HH3:5S,@7M=W<8K@?XL9R,/@=C))^R7956YM]M)B:I
M0Z))7H6W>^YRT5OT;M06_V:[XW8&#=gXdJ)(d#^Ag:THQ_G/YW5IY8[D,(@@>IO
)JXVLULbf,>[g4[5e55DQ2/f,4L/H0g&dA\@=6I_O=9&2P_=^GTZ^Z]<X3D??/LK
DLOC1/_c1Ug8?(3gK&ceUG5U=a#?VPV_;c[KD+S:G71W@9<><FR?IAXY(c00=BU@
TK[-1b?M?1QaP4ea6>)TBFXJRc#)R5UJ.68PH861b^F9,.e)G+f?^Mf^gU=[YNS,
B&12MZ]G65N).;KU-_fI4,:9SKdJ#cgD2]99\>cdBL1<,5ZEZKQd,1Z23YTQ-8=-
Vb3_KY#YSgA(3NY>(?V>01R:PZJ1DLd.2<_QHNf52H@&a)0?f232L-&g+.:TBdON
bg@2N=TV),c+,ae\0J\fM0.9;fc[+[J6Z#[:ZY\?:\VXRJ[4.[WgZOC?9]B[,BCC
P?OVBMKKL+(W0E,Q:X)M&EORD))IbKR5M=V[NVM7LTb=e]D6&&(?R^;IBHM[X<:(
8H=#B86:4\GYN^+YPWO)DQD=@e@dIP+9:H:ZL]HZ&.EKTADI53#F;ARLdb9A8Y,&
^W-M?6]Y_[5(#PQLS5[\TGOV</IP2Y;K0@D1XYgNO&F;(eGRW?G-+/Q50FJTD=-@
L<eCagIH9b^1CV<&=HG0g>IOE8><L\QLA4?##5g&RDG7b=f3>,UN2dJ\8X=VSMO.
PITge1N8&(<G#1eBaZ_7d5UH^C<ET>SdP5M^KN\-OeSUZ-@>[eBCGc#(4SNAK3R;
M+K\I)dU7^.:)P>1TQYa^VcQHDI\E,;R/[S+2-Q?f6>UVE#bP0.G^3dZQF+>dZ(L
+<M-E@W^G28S)&d((V@-87<<&DLA--G[/d1/\VP7KfN:YREPc\.H;<M_fX\ITTVF
->#dcQIXM&)+/1LEfY=WVDB7-N>>Vdf[;M?I9cI#MVC=W6DFE=8<_/BF.B\ZYK&F
?8>D?]:6.)EC/dJ^1a91&175^.aI]UPK4MSaU_M<Yc1;b;^-=cdcRVZ4-@\ac2ZK
g?MY[-7O?/FYd]V1&)@(&?754$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY
  
`endif // GUARD_SVT_REACTIVE_SEQUENCE_SV
