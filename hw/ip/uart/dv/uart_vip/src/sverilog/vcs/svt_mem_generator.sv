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

`ifndef GUARD_SVT_MEM_GENERATOR_SV
`define GUARD_SVT_MEM_GENERATOR_SV

typedef class svt_mem_generator;
typedef class svt_mem_backdoor;

/**
 * Callback methods for the generic memory generator.
 * Cannot be used directly. Use the protocol-specific extension.
 */
virtual class svt_mem_generator_callback extends svt_xactor_callback;

  extern function new(string suite_name, string name);

  /**
   * Called before the memory request is fulfilled using the default behavior.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that needs to be fulfilled.
   * 
   * @param rsp If not null, response that fulfills the request. If this reference
   * is not null once all of the registred callbacks have been called,
   * it is used as the actual response instead of the response that would have been
   * produced should it has remained null.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void post_request_get(svt_mem_generator       xactor,
                                         svt_mem_transaction     req,
                                         ref svt_mem_transaction rsp);
  endfunction

  /**
   * Called before forwarding the response to the driver transactor.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that was fulfilled.
   * 
   * @param rsp Response that fulfills the request. If the response is modified,
   * the modified response will be sent to the driver.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void pre_response_put(svt_mem_generator xactor,
                                         svt_mem_transaction req,
                                         ref svt_mem_transaction rsp);
  endfunction
endclass


/**
 * Generic reactive memory generator.
 * By default, behaves like a RAM
 */
class svt_mem_generator extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  //Memory core
  local svt_mem_core mem_core;

  //Default Memory backdoor 
  local svt_mem_backdoor backdoor;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  //Generator Configuration 
  svt_mem_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new generator instance
   * 
   * @param name The name of the class.
   * 
   * @param inst The name of this instance.  Used to construct the hierarchy.
   * 
   * @param cfg A reference to the configuration descriptor for this instance
   */
  extern function new(string name,
                      string inst,
                      svt_mem_configuration cfg,
                      vmm_object parent,
                      string suite_name);

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this generator.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

  //----------------------------------------------------------------------------
  /**
   * Return a reference point to svt_mem_core.
   */
  extern virtual function svt_mem_core m_get_core();


  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the generator's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * perform svt_mem_core configuration.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Fulfill the memory transaction request by executing it on the memory core.
   * The response is annotated in the original request descriptor and the
   * request descriptor is returned as the response descriptor.
   */
   extern virtual local task fulfill_request(input  svt_mem_transaction req,
                                             output svt_mem_transaction rsp);
/** @endcond */

  // ---------------------------------------------------------------------------
  /**
   * Cleanup Phase
   * Close out the XML file if it is enabled
   */
   extern task cleanup_ph();

endclass

//svt_vcs_lic_vip_protect
`protected
:&2ILRT>g_QaFBceKRO<Q=HF69.NG-0>6>4,);-O5bb\@3BFI/WM1(X]63BD^GWc
8Oc^M[:bRac>-VMK]^I?Y7[5/c7g2?B>H>W#cYa:X(FAAAPB>7H^XWG.AJbAC@bU
,]^&4L.2E);]+PW)9Q)?R.M0P.V(G+YDA)e==aOJf=3MfT\U272M8=,@b#?KY4)^
g=dCO9UabN5RGJY8\.Qg\>_SO6\G-,[?+OUA5<)aZA/?FbG\+BPe7[5MRX^-#eb;
X3204NU@c9=7MfV;:ZB6AG\#0&@17WE[VWNPWa)GH5f_SRUNLG_^47<Q&<,,?=#<
[HcP-:TL(bKRVEBQ8d8gV+,E94ZJFB3\L#8[0APFW#>Wb=BO/bc=__@^@ONf#U?X
ZC/QD.\gX[GR&_Z0+B:3DRAYBF(BX:CSYRVd,(E.;eg)[W&Z:&M&a(5TDXI7R,^1
0YR1A(RRC/G:W&I#O&_V/V=:@MXF7aI,M<<;D_J))JKSZ/_B0N(BDHOW)6[/>Cd9
-=-3Qa8Fc9?LG_7^6M-.E-L>8cZMC;B1MFdO_,@>4dQ?@^HObGSN:OD.8,YSLF\X
P,]H,/AT[eb6W\XIXcML@+Tba:YH7L8#LJ0K+8XDa/1KSQ><4=^)S8RRc+)UK]U>
bUF^CaMbE)5/cKB/O;QS/g+O.S;W0(EWb4]cR=A.3\2;-8GB04=--UU2&d\Z(Y78
.)DO;&]a?/GQ_7f^S,&O;K;WP:TTAUQYE>1KeET;9T,P7Tg;OF[eIQ0KN/a8<b>4
(;<>/PP6ZMX<GM(6AdKYN^LM.+N93.P^\WBIC5;2/g),Y\>H;bZN0H9RW<7Z&(65
b/LR=HKK5M.\QDa:F\NaE?[?_#;=f3Q@APC9I(>;X@Q+U,[&.fYQB]D@SVQc5VHD
_L^,.C90J12,dDE(c&2RO0?UUb@\AZL53[NWa8TCQERUDQW.fVAW<(f\Rcf,beZc
;I1gLLLcFAG4(\F\6+fAf[@)dG-+UI8J.T[X9S,5GdTP[N^P2YH2+.bYS<QIWWOI
A5)bQ+Cf7+)Q>[--1PgS3I#LGFfB\bR/Fe/89McU^FgMELagV_;_J6UH<8QYFA6F
=Hf7]T?BEbA-=;Ca8EMXX&<D)-/[<15MKR\2779Hg]PW?SQb-SefC&74J2bT_CcU
dLVIEE0OHA<<>F&0&)XH(JfV(>2.0)N3FPgB-WC7J44F+A5)@>73cJ&JS<3<2UM]
E#bZDHg_YECST:gcEFB9/J\1DGbC,LZ:<XJ<V:SScC&UKUf=(DQ[e(-83DJdSBU1
UJKK9&_(7-FRZJG1dE6R78L2H;:YI]:HY:Uc24&TBI&[YQH9R4(bD1BH6^[0/OaJ
:MLaNH3S@__SWg5G<Z.UUN7RXJ19Z^g[E?VKR\<b,e9Xf]_ZOQ_5_cSc/V.b/N)J
W?A;gE?)E,F;89)\(c)PH\3=B0K02>HNKU[^\K71+9(T+,HC8Tc?).fcW[X[RYBO
),#IX5:.[+E&R0U;MI2>\g]\L6OKMLP=f/J+HMd,fC75+182DKN;^S+?NIE51V,>
HHUCLOd2:MLRfZN78]/A96-ZZ<6108I3\A1>0L2V-GZR6N<.0?-Z7>J5(b.+@VPP
d&b3-?439I6_5EQEVBZ_a>^NKgSXZc1ML.M:#Z8D/U^]?F^K2V7^Zc>ZH?RgD,+c
CM_W[2^G(C4)f;FA^1.QC3JHC?D\O6#TD>[Z65HAJDJ12SH<QUNA.a[-HD+=M0KI
?J-3A0FD&B?YPb9aaJLS[e,LHPf&#I^&ST=d3aDS4O(JIZ_e?&b=d+J1Va,9Q&_L
JY>JTF.>/,^_GEOK9_X_8&+^I&.N9@,34&2,J/.W:W9ED)gU6<?64Pg:O\KP30LA
&6T5:Mf/+_^,]N#8VU6f\eB8ZMe=eXFDe6&MQ?gJ2G(^,..3\FHU&J]\a1QD7UdK
59]b\;F?_5,N^Q.5-HW&SZ2)cAcW/dBTa;<=K?KfAT7#6[S#(67](I1[528AGF2W
12(93:5=Q;/2P19T3=5:5]\?G==^J[0MX8OJIK5-4f?=)G\[S:=WPL;g9@BFZ5^F
H^J3HAfWMB@\J?_RQ9ZR:eI]bJC^b>B^H\NL2JFQLV:9BCIGT;S)Z&6QL91<(K.f
V82QAMR)SJ>5^7c+P+1-Dfc&J2L@IS9-fd2aO)XWfN7MBX_Fg7Q=JH:P]O2[F+7Z
I0AgSLb9)cf[KE1QE?4_0b&>M76?=-Zb2=,[V)a?L.+f;T>0NCc9+J+eV8RH1C+)
_V\]7YJBdE)cU\TP9W)Q)(?J)JaG-/]\EV^)6)5OT/5/QE-]R<5D3#cOeZO#O3@B
^.=@F_WH5]QP2Y\QI2,(<^I90MU>I:K<FF?CRW2>AHBg)HaO@0.X@@>@_LJZbeYa
3(ee<81J=0NVd(IW#O#=Q/c&WYU_L>IT>dG^6?(@#VeN9SKC+,ELYU;bFL#<O^T3
IcA]2;ZNAE>A6HNNY1S&OD^W=b:ZNM=85c5_=3HcCP>DX)SKDPEe3F_3Ne+43[S6
1[6V46,YO1^J?-Y75H4)bP-5)--.CK1Q0LB@)\UE@E5Yg;P^a,Wf?,:EeE^LD]_7
N,Qc,1OX=X-K?gP&U1aEP8Y;;>^CNZY<Lf?2AV2C5fCaeL+.0Ya(gQ0=a(-8870@
X.4=1=>YP?6M)JE1,:bYE=#.MLH30;(?,UJP;=5RQ3G2U(.&4G=><\24B#K/D\Z>
;?[>9O1Y5f2-=/UG7.+708(T\3gUG2<cR83D;JED0SE#TL::c5LWL_.3.#7^V?CC
LG(FWA1Z&/08WK\<GWHbgK_B8<-[PAQIZ<:N6gLGM#9?YZ)XZU6dR=Mb)Tg;bRZO
IJ)LeP45T?+FV58\(_+N8A-,Nb4T/Z9(&I^<bP.TZMO9<9,cWcW^eUME.X+=,-^S
6-\@.Lb[U3FdNWfO?37FcM.=DX72a0+KMQLa(aJ.aAF9SL/2_T1C-?gSMPAS<L9^
af^TI4R2;OP^JN6L^aARANO?,]X5d.V1R?TR?;LZ\[J3>/H1IA_AT9Da<fV&WUKU
EfN_I0WO?Te[JWWe53:@b2FXZW[RF23-;HWM+5K/PV@)-/O.b5O5&c[<4_PFR[/V
;#eE)&[fF,_FIJcQHGEN.AK::HVW:OB4W=JYDWKe4K0\L_HfZ?F[[:)XS/M-CbS3
9CCG.^)XX#J]FWNKc:43C7LC@QaDP^G2H61GQZ8LRHQP3-:P5]^#/&=&7d1dSFC[
J/MJ0B7&g.dPB^G<b,F<]4K-Af3@2^A_O]5)Q41U,;16>1ZP68H\.Q10BDH]eEKU
8]DZZ8>8D:+Pc?)>6VWW/VPD1d;e2cC6A&UE<.)DQH]\C6VVCE<cGBV>&]GU3-.[
+[8#:)PV2JAR>>B^Jd5_S5\_23Afg,3/F(1XD0G+VQT4F\@<3OMbEg0S^L>b:6fZ
?OgT(O]_\-O:,F,E29f4=(]caO>b8VfWG_VAU52<;d5BHZD=1d6ag6[YRV1fCZ8,
K1C6d&aZD(DTJBaB/PL+9-cKc+(Q683WIRETY>)A;(.6dQagH7Y,9+K_&GYUJ6/(
DDBf-QR77XW^X=^X@IgQ?4\\fY:U\JS;eL-0EHQ],N^-aJKXGTGB)QbP#PCQY3OA
-gd?Fc.dIWBPI+IN^7S0UH+;b(EbcdIPd+U@=;LQ(MI[&<(YL+d#1MME/OLf<WMI
/WF[]EV[LDL=1)IO0ML(G.#F[Qf^/H2?S=E@EJ9F^W=#gf^_3/DDP-5PYVcFZ<X#
B+a^DRa_Fa2X<WO]^;-^Ug+Q,3N)aYYe5caOgNRIbcU@,][ZL_<24.(7DaZ^UHg^
_4CaJQX2JMS&17G9\??;FN#7-Q6#W3#G=ZT.#K87=>3JcG+5eNGWbEC3=9_5Se\[
M)Pg@eNWKdY(S1+7+YcP=RcPeLPc&G2RU8D]3&_9/-N^>=Q;VUL,CebC4/#EMf_#
DHf(<((aRF/;),9-</aM;]@,JNd[(G5):Q9?<KAb0UCSXQ;J4YdHcdaHP:O&?[Hb
J:YO6Z0\W&5C8Qd?Y_4)g??/4,5/H_VgaV_/V=X&9Xe?3bLMQ]#Y-3(]ZfHN8D0&
(QMDV^#5[Z+:0NBIL<aOc6\>??WY:/2:#<=4[:^(YP6#Xe?:^#B1GbM=V5#\+aB1
=HLUc;I6&)fR\S^)1]/VKWM.aI;F-Z.PS<?L.Q>^gL-<X.M]C6FG#JS5?GcY9HS5
I&ZF0Q8NLK+,YTY7FY<d-fg06HN>3Y@#E^7e(K(:48DS.aKdL)QRP]S5M$
`endprotected


`endif // GUARD_SVT_MEM_GENERATOR_SV

