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

`ifndef GUARD_SVT_GPIO_DRIVER_SV
`define GUARD_SVT_GPIO_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_event_util)

// =============================================================================
/** Driver for a master component */
class svt_gpio_driver extends svt_driver#(svt_gpio_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Event triggers when driver consumes the transaction object. 
   * At this point, transaction object is not necessarily processed or transmitted on the bus.
   */
  `SVT_XVM(event) EVENT_XACT_CONSUMED;
  
  /**
   * Event triggers when the driver has started a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_STARTED;

  /**
   * Event triggers when the driver has completed a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_ENDED;

/** @cond PRIVATE */
  /** Analysis port to report completed tranasction in the absence of a monitor */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_executed_port;
/** @endcond */
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
P5:,N[M<>.ZX[DOL/0Y_2>7d2c)>df_8WR0G^V\S]#C/D&ZE_#F\4(I-UPP].Gf,
a9LEN\B&WF^95-/.,79J_ZgUbXD8LA;MJeXA6#b>>W-B7a+40QK<><59&U&DdTUM
UMQE:U@/IET)HSdAB#a)^19aGF-XIB\C3<RTV2,&>O<8V66aP+4?V8-4g-dY>a,C
[34FD6[YIH\\05f>0-JI==-A2H9)3CC082KML=:?>IM[.6Ng^&XE;PF\M,Q<G(>G
NK(D><&NIY+T[^4UOW+<(WSY,\9?8V;SQ.//4PO.+;,MMG8,ID-:8cd[J=]NMI::
K6G,IaY6[&WS,[&bcNO]E&Eb)[4N4X,ZXP\)CH9T^[fW\F-eHAJ1J?S<_RG1:A/-
A/&X]I3P1W98Obd)aI8L))/@,9@J11)&OSX?OG#7+==:d\[8f+AF1YI-WD,M0P,U
F^7VR5K(+g_/)./1;?QN33>J(2+(>[NK;$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_gpio_driver)


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
faH4F/#eKeD+<G7#V2/a_.^_I\2eM:6GW>].34<,&7Ca9P7S[^]W3(fIL11P8+8F
Ja2;4A&;VYF0/Ed([D_,M>T2b4\64D@?YTM[BeQ=(9HV>HN+?.M=PL+:K)\B?^/B
EU<E@ed0F5fXQDf[>?>d]Db-5OQ&N^gF44U6F;)0b=2E,NgKKT5P>J9BaTCWZ4:)
/fb],SL)169B3C>46.f@67UFCNd>?C3WU-fV7HeK[KGJ3BgR_HWeH.;TP@,O92XJ
//+AG#IEQ)&B,$
`endprotected

  //----------------------------------------------------------------------------

  /** Method which manages seq_item_port */
  extern protected task consume_from_seq_item_port();

/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS provided by this driver. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Called before a transaction begins.
   * 
   * @param xact A reference to the descriptor for the transaction that is about to start.
   *             Modifying the transaction descriptor will modify the transaction that will be executed.
   * 
   * @param drop If set, the transaction will not be executed.
   */
  virtual task post_input_in_get(svt_gpio_transaction xact,
                                 ref bit drop);
  endtask

  /** 
   * Callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void pre_observed_out_put(svt_gpio_transaction xact);
  endfunction

  /** 
   * Coverage callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void observed_out_cov(svt_gpio_transaction xact);
  endfunction

endclass

//svt_vcs_lic_vip_protect
`protected
+?)=I?dG9S#Q_C]eQG,T+C?3@5MSGG^QPg([gO&)J,;W+NSXJ^;Z((Ja,.(dGZA:
NCUPX8fMFE2>XOZc(2&7G/R3MOdO3HZ=(GQNB3TK;=,Be8^VIEE303SZQ>GAKIAM
4Ke,89dA^_8E0RBBN3Y7)MSW\UOJT815W+VJcgFL-5TN4FH:TcWdMQ>>G5>)H<1/
KaXFAYca;X1,?TKO<KD(-]7;/IV+=)MVa8VNC05:3--bGc53CO?Na445_(6^PNQY
/5GeYI^;WO[bXF)EV8KF+@[4J.He_(FcaRfgAeY6(@/E8K9ZdeP&_5]R)G=.(U#_
D?,ODdcD7^QR6ZITH1\>1G+^]eYE]D,9Rb</+&c=@a,ZReK1]aZ?_^GANLXJSNbH
#S<_4EX?P5+1ACN-1\a=P#[,&)3df_W_RNDFO-=Z?e?KAI;TCR)EJ(/V.9F>\a9H
Nf<N^4gF4><^e+Cg:EV\(V<e\7IKDGg@@>13WV66=Q>N;UW+6\HX5\J9JcL3&(61
M^fbR,cTDACTSL[Z1V?#)SdD2&GS3-0YE=@04O&eM);:3VC&G:DJ.[Pg?-D,d/bY
YME3TSN@R6GZ.+FE,8f9_dW]J.B;P(<S@?B8+d@,a]W8:YS6MCID+NgeS)Z>),D^
=ccPMA@WSGL=MO8<8eNHAWS__@,M4\Q?2<VH^-,8H7YX<7-OTF\)Q]KEDD;6PH2,
_I-#+,5U/FXD[KQ+=M>#6e?2IHN>H0aVbYCQ7MBG+PTHUXf72.FMR=#LYUG=gHF+
J0Sc8P-L=:3XM]fZfGVMHM/XV4;_3EXO<XK_YWe-@P]3X_8&V7;gOe<M3F]Ob]?5
:-/=@d+/[QB]+_9Q>/&W96(T_]3BM3AE;Yg##)GTEeGW[X&fDbWRd\D7G7UH+@b\
P_c7eI&gPR,PI1\L^\^+0@bS./^ZTBfBDX]8);\6/BX^.C__MeRHVX/=CZ(H?RbO
>O9M2&GJg#,Be[6;[@]RYfOg(D(OTF3aCK,0c@&gC0BRURWE)eMUTA,cW[TfaaCW
<##^@4=8J2>=XDbYYEMHMaCMX-gC@U-W3WK_.3P>:S7f?FH>TZgg(Jf5JM]2UaEQ
K\RG@_F5J_Nb;ZSN[M@)Q/,:b>]aOF)\eU28bKQ7U+2g(_0SU+++]IRUH:1L?ZS#
CT03MZ,/PTZY>)&O;gJ(/6.\^.]Y]b8J4:I<HZ593Y.WM:@?578ROERN9R69.fF:
&^7CPQDX.4A\8ZaKgYA]a:HP@XDG#cOK.Va_JLA[B;b[S3-(O.#NP]L+@A9acDE<
139DLN4M3,-.4;&H1^,@d^:0d0/Jg]^CBQcg]+D]7(-&>F3#;B/b^Va(\c^NQg+;
33.S?)XNSUcJd:?g@bCR7GUTRX_7?YTAPSW?I38eTNNg9V64+CNRPY#ge:>PGMM6
c88G>@V)VZJWS0QM.NK.6OGfBJ/.57R\.GFJC-<W8S(N,S_BA3,a>>VWK?ZT-R^X
R.TJ7CPCEG9SJC+J\23WPe^\b4=OAJ\M6DI;?@05WT<b5Y\P/b[+\31bWdYX7G4M
7<d(9E^VRac,;C<&)8/UeC80M]f]Q>@c:;/9TDcOAXc+gX\@b_e8YDB+S3c;7c(O
1>\;@ZE/cBRAd]+Rcd.N3V#<XGP>OR?0T:fC@30FR^E5BWASGY<UBWO->c&53]N[
FGPedW9?Td3J=7US8/T-;_D&MQ;V5W</g<^EKC]VCfK,89\+gJKD)4CI]eFQIN^e
M\/DR09J\DbO&]UU6a72>\FH9_+0R@X=X]&=-f_&[4<KKVMBP9W64eFL1_EKI:.E
6/\19OcS2R\BU]/a]+g+e7UT@SI@@C>Y.=+GX7554H#-N+CJF<U-)J3NP4W(@Ig8
[WOId^#D]]b]Q<[>&V?b<FVJb3KH&>99X(Oa9;^2FUdA/_0P^@gZ=TYI<DX^?g,G
fC(g<,4L)Ya>25Rd@;,V8EB\_7@\0)6(LO+b)WB1(UFU@KZ;,/]FGJ0BQN6+2CF8
ee]E.-+SYeaJ5\>L2/6d_-8Y-dR==]H)I/GVQ6-@7GVK5H,JACQI<+IfJL@N20H7
.SV?<ID+WKSDc@@H/e<+OJQM.,WIU6L?LR;E#4]cf.Q:3\HK-[/H.X1V@.SaA.)a
5E[+\/gA_BcIJ,NVNNL;U[W89:O;9<E#YE4Ca=RW[IX9Kc7H@>YQ+CDTaF85UeP:
\#747f55OK7Q8>5Q2K,T:&,O@W,2DJ2d)fQ7-c4cK@-VUQY2S:b?g,#eY]#I5K3d
FDC8UP\]KY/JBOD:^D2JUBMGecWO>L1L<4[PF_J2Zg9.:XDPbU)?ZSD<V#Kge4=b
7gG)V^M0gI^9\@_5(BNb4_R^=62^_N5WCVSU+[W6\_H@a196Z-^MG1MJ?(_HH/?I
[@c=HU8fF-P^-9<S,>g89&,(-QbD0(Rb\EL/2LQA>L.F.QT7-2F)\7\<FVG+L,<L
dW>IN:eJN(TCg?:_.(VO0C),dbZTd].NLXMZ]Gf@^3?G,FQVfZEK<)JJ@DDTYOdQ
LY^J>@=;bD[VT0FVSJP#bO[>_T?25Gc4&/S2X4ddEFWJ6PW10=D6Q9/^6Z+d)J,T
a6MWX1-)?I/F5?H)LTKg^?T&3fG..SVc7J,Q@G8g#GCXX3X@fNFL&/(&BWP7Y1CR
cBc,4K1^b=@e=18V,W(?O&gCE^Z&VGAM<H:b.&R+(])<K@FL&]72^<0D6E]2OU?=
.5fR#(]aI_59(8IG]8CO#1dNEHb7DS17)1VX>PW?8KgF=QR0Ka\BT;:NBWKFV1:8
_Cb#MBH,8OCc@3=f)R^(<=Kc907VU?U1OeRfTQ/+6.R>>0OX1cY8VdA<S,KT6VV-
AYCOB3KBEHGT_e]1R.g\31QO4f<?BD<HOd6>,U7+?Vb)D#II2Y&5dcW1C/g.fAf0
f\6.ZP7\T^3G3C=?ZRfB[GdeDNTDdO[9ADY9BeN;dGW\(WAa[egLS)?TSSAQb0T2
.PM?(RgA86_2&DA_7V;QM-FKe_>#Ha8]OO7:.Me>:IPG;&e9S@TGE<Y2>,MT4_Q@
VLeb7]SGTg>R[@1F2-<HSIR\HJDKY96SSY#/c6cGI;1,A.Hd)4)9;<-/-M)C>_;^
Q@0Q^A4ZfN2JUEFg/-,REB^0U0G7d#CG^G:aOO(fD&f/.,PO@=Hf6M\5eHYSDF?Q
M<)/,6d6A(<176CXSY?Hf/B]<&0DPWId:[2^&^5\WI7HaSOS2HD=VD#U/QIIfXB6
.1<ZWPB;02)49X^RB/Nd\D(E4#BQ1X_HS=G,b/ZQ)HQ-38)/(@)=<4W;7Bb-J.KY
=bTASF2Z].Z1bR6\S[:C-Of,E9QRe.L/MZ8GCY)(E4Cc55fC;6C0EM5ZODWbU=2<
=4>CM:ZSI?YOe^:.c=KgX5?)/WA21MN5:$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_SV
