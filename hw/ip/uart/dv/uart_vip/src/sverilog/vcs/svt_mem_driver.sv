//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_DRIVER_SV
`define GUARD_SVT_MEM_DRIVER_SV

typedef class svt_mem_driver_callback;

// =============================================================================
/**
 * This class is a memory driver class.  It extends the svt_reactive_driver base
 * class and adds the seq_item_port necessary to connect with an #svt_mem_sequencer.
 */
class svt_mem_driver extends svt_reactive_driver#(svt_mem_transaction);

`ifndef SVT_VMM_TECHNOLOGY
  `svt_xvm_register_cb(svt_mem_driver, svt_mem_driver_callback)
  `svt_xvm_component_utils(svt_mem_driver)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this class.
   * 
   * @param cfg The configuration descriptor for this instance
   * 
   * @param suite_name The name of the VIP suite
   */
  extern function new (string name, svt_configuration cfg, string suite_name="");

`else

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent, string suite_name="");

`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS available in this class. */
  //----------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  /** 
   * Called before sending a request to memory reactive sequencer.
   * Modifying the request descriptor will modify the request itself.
   * 
   * @param req A reference to the memory request descriptor
   * 
   */
  extern virtual protected function void pre_request_put(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a response from the memory reactive sequencer,
   * but before the post_responsed_get_cov callbacks are executed.
   * Modifying the response descriptor will modify the response itself.
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /** 
   * Called after the post_response_get callbacks have been executed,
   * but before the response is physically executed by the driver.
   * The request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   * 
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   * 
   */
  extern virtual protected function void post_response_get_cov(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called when the driver starts executing the memory transaction response.
   * The memory request and response descriptors should not be modified.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rsp A reference to the memory response descriptor
   */
   extern virtual protected function void transaction_started(svt_mem_transaction req, svt_mem_transaction rsp);

  //----------------------------------------------------------------------------
  /**
   * Called after the memory transaction has been completely executed.
   * The memory request and response descriptors must not be modified.
   * In most cases, both the request and response descriptors are the same objects.
   *
   * @param req A reference to the memory request descriptor
   * 
   * @param rslt A reference to the completed memory transaction descriptor.
   */
  extern virtual protected function void transaction_ended(svt_mem_transaction req, svt_mem_transaction rslt);


/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration();
  // ---------------------------------------------------------------------------
  extern virtual protected function svt_mem_configuration  get_mem_configuration_snapshot();

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Invoke the pre_request_put() method followed by all registered
   * svt_mem_driver_callback::pre_request_put() methods.
   * This method must be called immediately before calling svt_mem_driver::item_req().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * Note that, unlike the other *#_cb_exec() method, this one is a function.
   * This is because it is typically called from FSM callback functions.
   */
  extern virtual function void pre_request_put_cb_exec(svt_mem_transaction req);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the post_response_get() method followed by all registered
   * svt_mem_driver_callback::post_response_get() methods.
   * This method must be called immediately after seq_item_port.#get_next_item() (UVM/OVM)
   * or rsp.#peek() (VMM) return.
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cb_exec(svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the post_response_get_cov() method followed by all registered
   * svt_mem_driver_callback::post_response_get_cov() methods.
   * This method must be called immediately after calling post_response_get_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task post_response_get_cov_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Then invoke the transaction_started() method followed by all registered
   * svt_mem_driver_callback::transaction_started() methods.
   * This method must be called immediately after calling post_response_get_cov_cb_exec().
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   * 
   * @param rsp A reference to the memory response descriptor.
   */
  extern virtual task transaction_started_cb_exec(svt_mem_transaction req, svt_mem_transaction rsp);

  // ---------------------------------------------------------------------------
  /**
   * Invoke the transaction_ended() method followed by all registered
   * svt_mem_driver_callback::transaction_ended() methods.
   * This method must be called immediately before calling seq_item_port.#finish_item() (UVM/OVM)
   * or rsp.#get() (VMM).
   * 
   * When overriding this method in an extended classes, care must be taken to ensure
   * that the callbacks get executed correctly.
   *
   * @param req A reference to the memory request descriptor.
   *
   * @param rslt A reference to the memory response descriptor.
   */
  extern virtual task transaction_ended_cb_exec(svt_mem_transaction req, svt_mem_transaction rslt);

/** @endcond */

endclass

`protected
&V+Kag19R+SXD_#;XM/c3c6.(VC\M9(;:<^C,gIS]J2-H-3=Qg>R3)0Y=CU_(=P.
14(HF0\E9BbS-U)0DY2<H[Y4<X^K/KC6:+>]T61T]e1MB1]f5WB#d?fOA1WWD[G=
?[bP;NM<e7f&D<.\K#O@LK2[cOf>_1U4gW)UH^V9[2X(1eeV1TMATJC\O_e1Dff,
GQ\1ZUbARY2RCTcQg\9+)EHML-Ic,Ca.EAL,\AGbc/?D8I\?(9W:NF#\NQ)_R^)?
FJO.M5BFKX91]1BPRKcQ0@f_5\S+Y-0XM0Vc/H..[UdDT39H5O2[^ffa,)^@T+3f
IdFL3EEX4d\KQ\f^eUK&=_:.2Db6[L1U^/c;.C]ET>-4d0Q4WdNV>U4&05cgf=BY
CNXF<?;G##H<=C-4R9#S6bNV4;C.C@1B9g7L;,5;LDeYHQ[;7FI<d[7P&=8J?Q6d
HeQN64H^DeA,Y_C[T31KD&#T[QL)EQ(3e;+XG]_0?J,bOg_</@^]Cg[OQ-8RV=?T
FOEA,RKa[eIL\9NL36]]+J@.L:F&OXU;^QeeK/CG_<2bE$
`endprotected


// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
=_KT9)V6Dc_>_b#]LLCXR<-,PNF=VGOD68&1V/?X25&QF&KX94-K&(BEQ>f_].;d
/CPA@U&;+ZeVL>6ZNY-IMTP4aAJMQb=+YF\C2GgPY.WgFZZ]2g^^YLZ&TX4OWX)K
NB/,H8/bM97L?2XV1PdR<=(-PG@C,c-&(O_bHG>.?XQQ2HPX,_L93+5bKCRK,J9^
4]:\EKV>-M(AFT0BE7c/LVUg(b)D&e:(;g/Gc_c\b<?B:C?@,X.[]HL7UM+OIFC-
F,9.&J+0D#6fZedZA@JE889:98Ng^D=AN3-^:e>BIP)g@YZ1^cP:3f_/BaY/BA:Z
<-B.KFFf5/V=G>BCB4.:NZ7/F9H4X6B_Q(X8+B.M;B)/8(_AK841M+4_fa17<cAR
>I/WQfGHASY(^M+&N,;2N@[^)V_U^8UH,A99Sb@/b_UN5<4-4Q&V]#T5V\G-^>H.
(Eg_#gB1+gA-=;?2VWX5;<=I3[=9eU33g-=Te@&RUQf5fHE-H8N(A6MXcH\(3(4H
G<F0dPdW[X<:IC=YQL]QWOVLdd\[/HKXQ0G#3-6^[.V?dLAGFRBH1M<M.SB;JG;.
/cL?LBF?Y>IWG@KCX?bDAN=+RZCUUVdUDZ?TBdR_<R7DUb;@_>L\01)f&/J:=B,2
^/b1DJ80B0WVNE&SgG&^O;IRL#3[K@=d/,3^-ScTe=HAPdTLGb_3X18Fd4fZdQ[>
5[0Kd?;L2GZ-Y5YOe+&+D/J.BP&UDMIKS^O3af9dFL#]&UF@2UREOT+H_OH;^Y7B
8)aP7MO;F\F_fEa,A:IE480K:6-P&-?PVQ\)1(W#I52]SL@]35L[:D+CWP:NWLc0
.b47EA,(P?DN5>QLD\KN<VfDeY;d0RDZHT2V&+#LdKNF[/MH<8#7K^C&P(AcORDU
=P?W#)QYED4#Y,\e_g[.DU#\.BeQK<6dKJgVVe4OI=+B=DK.VY2]H[_1aQfE.]ac
:>ITeJG5f=DP7(dfb,79&c@5=SW@1=7WcNgBIJe]Z+3K0feANd?5RC5^Q411ORaR
Fb]_M>H4WX33P6OG5F-44X@(;5HVK-Z#[^W-&F<g6VT,=UQ3DNg:2>>>:/Y&Vf_X
4(&=(GUGE/XKbDNU,L87D4#XR86:6P&CJ=?V74:42XPCU-.)TFQ+=U7W<2f<,VW(
VCQDF^8=P.S61aP^fQfFA2Og)^R5\#9V).IS4<5:+dG?&?(CHP[N138<1QV(F@^3
)HU[gW6XPJ2E5eL&,?[Q\K),A&fKWU=LQcB:+;H\C)=1&NVf@<]bF\P-\-GI1:-(
;4V=&@M5H;G)Qd(^SN5Lc]=)0c=@(&),cH>,,)6+b+RU8@&G=-RE]9e;I/<FaV9M
:TSGZ8K4JE926];T8^V3)>G@9Y;#CF-fOUg]W]RN+;9^/NYO0#7<AL[;:V7gW^[N
9&0e<G+85?&@Y>?5C067BUZC-7S15HJNLKc-VPb12,dUB_9_RdPS\_0_Q)7\a+f2
eC#W3EQW#db-bc3a-agWd>8Z<Vf2B9F.B\?B5g0cA),X-Q\DeEY###P.STZd:H_/
R+,cM76f<G#9866:0\PH67W+CZ:#(@+Q]TE.FAeD4WD9ZLKdJH)&T5S2\J:NHI_W
4W)SY8>b/N-2<S#^2&>]UAFa2eTf9.#._Wb?^THQ_=Z@93-ZGHLg:a(QL7GL6Y#&
I;?#&f1=&6Da5.HDaU,+YI/X3K1K.eNUDAY-Bfa3U^SUJZGJJT0#Q,dF#B?LRTD^
=OD2YaT2O]QO#2M/a6FTJU;Y6a+\7VeZcPJ@M1&A_;AG-=[c2Xg:&_3a&&_Y8:.f
?5#/2B=[A_C-8[@0OA^.DK;?VUC@BZc_7FG>WDaGJXOTT^P(AJ,4bXHd;(R^H)2^
:G8F5X8+Ia8GHaV0:_;3gNGgPW4>aMS8)K_N@W+(.+5:Pg[J]MT=AR(f1e]R-gV3
53F?5FES6WZ_;)Y@[f+>7P)OfL8]Ea?FY.+H^NDb4JUa7,]-JK@)Z-RR0\<RbXFd
EGfPMZcggbEY^O)9c374J1E5dc]TbTZQR-2gM,SB:(XT/][31?U-2@K^&FJ[/C\P
X_S54Xg0eH]ZU5/g61R6Q,]R9T:EG=[)F2YB2;W6NO-\R\J8W(3S0WTVJ/+.@T7[
717T;B9g=I^,R?MPEb8(Ff_W8MJN:_Z19^(BST]V1b_Fc0,MH-FW=6,TJ3O<EgQa
3>@3D>Z9bOZG.N3/c8C5:_f72:?XY;G^LEM\]9f3.DB.+N_91-d<NBRAMA9-cYg8
A.Pa<5M6IA^XNA[dJZ)gX+<JE<bKIP\Pe6LH)(4EDEJVUfGM,Q2FWTV52B[6O[@T
:#?g.-f7<3@V]#D?&_QYT(X83Q<bS5^;\GY00KLRPE?3:8+W=H)#^2A.>,f<2E)e
RcR=)=.a^6#7R8.]]M,?Y7EXL-eS;X0\-X=>TIF5a]T>5_,I50CCGGX(cfB.dFB7
2<#PeKIXN.QIGR]c9I.MN_UIEZ(+I3X\<O08G,cFO)@GQB/DN>@YG)N3KgY+HWZ^
+^g7QKdM;;ST#5V]ANWdNI@L,HRd]J@O0PfM_&K@I05&eGRTYH,MML@L](;09QgC
E+D&1Y82>;U[\/6HgVYXH,HcaSI;Q@<De.WAZcLb1)>N5K@NY/N<9:X7[Q7Q51^U
<AOcK2\(H4/)I&eR[CBCG2-,aad^3,A>.AEb1[VVH+PWW/;4aCXNgA,?=6=J(2<:
]R#C3/B^0V2+<Ce]\Ae@f\F_M<98W&UK\(2AT^PHMf(8LOdJ\STF=D:L1>c25^X[
6dHTR4^d8?TI].\cN+,2gKD?XJRH=B8F&\SKU?2[<]gEY=241GJP-J:(JY8OfTdP
T@KG7RPOL1:0[NCfc[dL(RDc&N_:&<QeKc4fX(H=<-BI[HLR..dBfdd3_YNQ,C.R
?44\BJTCS30dLI5NO1O6QN_L])]g@19N9C9=U<CXKG0c2>(_>.5O7GBbUUO.fCI?
Q.?FV)Y0VHg,Q\2e/@19V9+:JQ(,&4QT\Y_1:U.:;6HQFVe,PZAdH1A_9\@WWN_+
MH^#+@NGZAYJ7>,+))]ZH&9H8A>^+;+-aFd]IB?<\0TR6U>D.A<J:PfQ-RC;gQ=\
VBa(13ZPI(U<SgL8eX?@:=0dT/8+Q(3<F)DBg82Xg+T2V>MJ4\TL+=00E8LF-^[(
-SOAQAFD(SAc[ZaN3&J]RQ,OaMK5CcDbOY4SOSWM9N6=0g9W=NV1V.E>;4g_5_g&
H4JJKB9HfK6b[b(:37?Ve0ZbW2C8@(U[1O>:c(YE<)NT6@\75(,J8aIOIL-[M\[=
A(-<)KKdN1a@-B856e-_LEM#7,2TXZ_eEP2-^WNgXMK\\cI0[DIJ^WY;4d:<W035
GJ_cfbQ4ed;8_&22>+bKKSIAR(Z;(9AO18g7d(07S[<g,.,NIIe&>P:G0,)/VZcY
9D@3CFXKd@\8C7G[a>DF.NLda?]F)9\6=4IIQDf3V;OD7/>g:?Z)Xdd>ROZC6.8^
MN.0WMNJ_0Q)]KVU^VO=DXD^+c;TKT/9;gO\eJWVeAMf2@;8(3KCX9Y^TWV^-JcI
5F?d>dO/#Q.MQ64,:?516(_4X6e<#)C)TFDJM/K>#-F2aR=9gb&8@#[;7@J^>d9M
NC#fR36:?[(:g(VAA^b=PN+AK].?dbQ\5VRD1=?&.V1&:QFCU1a=gYUW1,@4S?[g
_,\BLO[Z9fN<G\b;^9/49(^JXU[W[3g-[V[Y;S5Gc]SQPgR]RFg)HL;3GJ<<\4+:
Z9#>.&Y45P[,SJM.Q4^^?V:;28C9W_cXL\MXHD4H_JYY?+b^,.Y]8D&L26^E^4\3
7fGcf^4AbTd/L>JEa:1bbAJ7e2Y(SE<ZXd?>58O&c#-0>A634J;fGKU1<KbUONQ)
D(bF;9YR6QTCQ0^R]_S>4W]^MS_7TP[RY@7=3I5XQ&7MG6KG^g/YQ^dI+8)U)gV<
BP]V>?E;52)EW8c\g)?O=C\a)(?gTC(].ccgb@F@:L[+5b-+=6#D/eWE=Q94=+YW
R,Q8LH>a&<U0e\PfGTET)LMNS\:\W.,KWHY8LgJdFVTKZ(bQ7W5?H@f;>G2=9>b1
<H;9T0N>37NUY?;F.28O/(78FG[E.45\TB8SP],O@/9X\PWRH#1912S@gc]MX2Wa
SSTgTdcffX;0b,d;4cOA[B23bW2gbOWC[0F3RKf0DHT83K0d.UdAd<_JHY^WF[D0
\UD),^UV-9eT;F6K9+(^OGD.OB#+A0/QH85F)&9#Jd;A+(GHTO7RKf;K@:KX.X7P
<^H_9e7A-g+<&:X9PIX3Kd3KG[YGH3bLQ6JYM\GegOI)GGV&53+C,Q24>+HD?Z5]
?f<fMd0[[F)LGPRLN3\]+@8O@:ET?BZ]f92[g.FT/@KD\LP@MNa)K2HNg41(da@K
+.3U;5TO2BIL=cL53X/F8I+(4e,_WXF8FW_cP/f;:0K8DW_(<Ug^TJ&0OWF-]PLY
Eb6Z591)2V0,X<O/(T_.;a5dNg8[_P8;ENR,14Y)QE),.75e+F3?KSDXZ[VM_8U9
5AYB<2P9&YJ=H:@TTPZ-fQ94b42\5B7,1PGX(Y5;:Hf;#:\K<Zf3@[6?;U>42FP:
+g,<NT6VB0_O>U;@7bOWYfSF.#DZ,5^M7e@.\F][O??D(W[E3&O6=Hg?W&b7R/D:
V#BKAS=76=.&^84aP.9f7>150Xe&A[^+bgWS6d.IZPL0\Td,6(ZYOBW0eE5S)<R>
4(2R(]WK0DJ4c:<U,YIb,>f56a[GR@,N8Rd-,Hc-G>a#::-63GZB3#:]J+dBT+2g
LcaWGOQ]4_N64O>aB[;AD;=AN-eI;MD6d7M^W1UQ8X8QRe+P@=<V&P5Fc_b+.?Y-
Ge?&P?4L=51Rd8Od>MH.G6>1D-FdDZd<Na1_cV/W11_S+PAB/(>]?#-P2\WOCRCP
T5VN;^9\0e)WFIcfScQ?X-fPdC4_->gZIIc01?95>J@0Tg9^e:[_N]EaUYLdIdF9
c7&(8(We@9NT]0R2/LCPN?B[H#+W:dA(R><6F_0A,Y).gIZL;Bg7Cag5eE9MA]f5
07+Wf3W>JQ[#df5PO8QBXVY+\S)cM.Q;FaC=3FO0,3)6OL-X8F)gS=_/c)P>QT]H
KJ7McS@WcM;P_^6ZVHV0M&1:#:CgR:Bd5.2V6/QTB#[gbaE?9US8B?:S@)QB^KA?
E2F<ce6<D.a)N]=cPDUHD3B7^#0L=0JQ(>52NQ^RDDgY>Q7:(#<ec@>Ya5OeXY/>
G?20JD>\Db8FHWGZ8?Yd9[0XRA8)1KD>cI+b/&OfGN-BHU3_,C_AK@V\-K5APL7A
03<V@/R2TBE@6O_2W5>/a_Zd\J>OdF9QQI7M+)=aF:3XG08]X932^T69U^aVg9JP
d6VR)-3THUdM.=gN==H3fY\#\.A1\8:eJN92GU6IRb7G[^B]<&JXS&eE_N8C-/;7
[O#ZB.K/N88X(bW])gJa0UfSS,9S+E7Q<OHd57VJd_>d<bYSM>WOe#<CdDMLKaX2
\:GZPSF&(<Lc;@>ZX&ge+(IN>-6>K28-QY;;]Ef)1Lg;1V^X]cdeOgGQPdcJI=M.
D2>XQS#K1/2EIWe[>@-DP=T<(?3Z2Z#7VA(ZE3gS8T6KC7(8Z_(YC,a<[R;;g&N(
-V=d-UeL7A_B@eJ4GDC441L#(NJ=7])0+)S+gbWcMe(RBgWBJ,2:A9PWG)H3SZCT
IP8D\CYR2QZ_6QYIVIBNHcg[_ZXZ=Z#NbJ6X.A:TQ1PT+-AWZ.eQMd:DTDIA(T3^
M5>7fD]B)??e[[a<M7FV^M+/2P^T+@,?1H9gbIQM=)NIgg,T7J@GEQc^#bFS.^(0
Afb@a,beNe6/0d9<@3b[B-UIGbYCJ,,DS-:XR^YTZe4,J8N&f_@RHZ[4<E:cK3d0
=77>Q.J;+Ng.GFADH9)dU9[N3g1_DL7Mf85VE_6QA.:WQ3X>N@/fY@1bYcfK#LQ=
DBN2Y\(+DL:,IU,\H+HY2&GfDBPY0;^NcE[JfZ+6IGHUHHK4IS.G>^[,g:>Za7#M
W(N;W@J6f\dN]RY[Ab3NGG<b#60:]5-^0<EKgc.^13+QYe\M&Y&WU<@L1g1eU+6,
@7MeA<,OW)98GH6Q&bKC+D._RAe)DR^@c:-gY?04,<ORRHc:d7H2XV)9P?GYfFb-
-J5@P]:4RG?)[YUX:T.eD@UKeV)&D@QO7@D^g/8g6+@/5JagOR1U=7gdUae\3gFX
T_eB5)=5F#:],SJT.64YE\FQA0XVTS6N(TB?QT0O0=g)H,L/S+]5S+QMg);D_ISA
UJ8MQS0LC56B+d4?:LH>Q?TQ>>d4@0&RFSE6+Q.>(IE1L903,AO.C_RQ<R,-ZHID
,4;\:<Zc(D_KU(aDagYH[):FI<>)6GXeZBg(K\9F]7=BbAf6)VTK61/])K?eKRdR
-^CKCYcd:-&7@/Z:4:DIS,dQ==A((=\(=</[_WJTAH1/+4B:Z@CU,J>>=TQ5N;1Z
G(eT_QPVV:T#;,I>BST1;&M@OV_8gJ2/S]-g?QFSbPc?OJTFCU@.[d74SCN^7P@T
9L+,@YMR7G1D#20NNPJc8#Y1=\T.V#L[f\73E,0I?PQL;&Z>9&,aV#bZ6>F6Q<>f
OFLN>?MO.O.1eQAa:d_VZ8WG1>GE;34]aN&7J2f_6ZCMYDSM?46]4IN72W3WU#c3
#Lb.XG/R,99,bDFWD721(.=B[;(8#TG7-6)+-LTB]U0_VEI)K,f:5ebH.EX<a(1&
9bCYB?X61F00H#PM+^X,3cg>cB2f,2=XH7C-C4P8[];AF#B9]94NELbHN$
`endprotected


`endif // GUARD_SVT_MEM_DRIVER_SV
