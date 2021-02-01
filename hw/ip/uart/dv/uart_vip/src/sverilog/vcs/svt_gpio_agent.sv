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

`ifndef GUARD_SVT_GPIO_AGENT_SV
`define GUARD_SVT_GPIO_AGENT_SV

// =============================================================================
/** The svt_gpio_agent operates in active mode *ONLY*.
 * The svt_gpio_agent is configured using the
 * #svt_gpio_configuration.  The configuration should be provided to the
 * agent in the build phase of the test using the configuration database, under
 * the name "cfg". 
 * After transactions are completed, the completed
 * sequence item is provided to the #item_observed_port of the agent.
 */
class svt_gpio_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Proto Driver */
  svt_gpio_driver driver;

  /** Sequencer */
  svt_gpio_sequencer sequencer;

  /** Analysis ports for executed transactions and interrupt requests */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_observed_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_gpio_configuration cfg_snapshot;
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this agent */
  local svt_gpio_configuration cfg;

//svt_vcs_lic_vip_protect
`protected
NT)b#)^9,;TE?MdAJcLCZS8g.7XY_^8V<@,:-_37[74TMY,2OdPb3(C.?4>REN(a
XF)>)67OE[Y#R/=0K6N;P4D(<2<G(.T>EF.f[&Odb193F]eUf>YgL,eG&RV>+f#3
(2I5(D0Y^^,3UfO/B/LAF:&.^?-ddBSPeBO=W87>g6@UBV[<T)&:E+(18X+>^T9U
UJX+DHB])dJIAST-S1CLD?L2N_CfZXY@0[>TO\eFDTfL96ebL6g)Ua(1M$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_gpio_agent)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_gpio_agent", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
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

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Convenience API */
  // ---------------------------------------------------------------------------

  /** Execute a WRITE transaction on this agent */
  extern virtual task write(svt_gpio_data_t data);

  /** Execute a READ transaction on this agent */
  extern virtual task read(output svt_gpio_data_t rdat);

/** @cond PRIVATE */
  extern function void configure_interface();
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
/** @endcond */

endclass

//svt_vcs_lic_vip_protect
`protected
f_&(=faMC\@cE?:/JNIW&WLf7@a\\JT8SP_L2:EMI3b&N5G<4MMC&(]O=WB03G1S
GQ^(42P;W1>RA=<HgN/AL=PXPReO3.U=:bgQfb.&T_Q^DG\\=8FS@92]e8FJV^Gd
_WY[SAHZADUM085-01CJ@@U9:&f:]1eU?K+5cE@#eFMJ3CS96>?HJdQFO6Q(S;J?
;]Me1^5QW=4:/=O?.GaK?KV8&ALD2/\?b1a+KTFASNK73M:(\]TMBa8(4(7]@5\e
TFOTX6PfaNU=UYf]O9bgGS08@[6_a9UQ>_/=YO<Mce.;d+fa_)ZcR&V>G4I1N#LU
?BE84bRZe:fIP\0L9LYc.\53WV^I^67P/1^?R9LN/V3>G>5d\[@VPg,O3ZdK?;;M
ES=F5KJGdb@&eT(W[WZ]4[AOG&T-)fCgg/B[2K5=dL/eW4aG@8.9K#Y<3&9(;R>P
L[].KV-?-3UNA>8SaT610\#SJ)Pf_>@.S=BA]:g,_8EZ^0g>:V[RW4(YUKGK\IZ5
7?)C<UV55QN6Ba)eUV&WU=+R?dXH#>/\UEV#KcWV9+.>FXccJ6a=T.15]^7T^Z9U
@Z>QJDHKg\)JSY,/.cDDe\If_b@f9e;J+5@36\,U6(5/gB,P;:(K#1C8<0Q[KdFC
).,JGW7.0K6FW(CVKa[TVeIRfcYVMg?2JCbTCd&>DOG<?=D/I]LA_M8f1&BCSOK/
CS7eE/Y)]<M&F.-\9VL+I@b>gLY\EMV^FPbRe@N=P4.]S8#I:SbZfR]gR-]0GHQ;
1KT:@:UgD)N.MJ)8a;0#f=c;3><;AP[HRXH=/BMOSWKN,]<+<K5ZIF9]bQ6X6;7[
S?A&B6ca5OdNSEGfGg11WUXWAA.^PP@9#69bT4.@[6&3??RQXYbGD(/+ee8.&cb#
KF[?8U&)aAT@^g;5R6L_FEN00JL(.9UOV?g.K9N;0X_#&]0FUUc+27<D7QI[2O=/
+6:AR#-@>SLG_\bLJ8[OaK1,FW75PZ_C.-77g<f)NF9]X:;WX4E#Yf-QG9AMCf6=
UL0D?1Q@B?+>#Y[^:@:EeeQ^XNXeeYc+E>Vf@b_K6#ga1/]7(Db,L89c>^A;A;gG
,;><=e/I6_dWI.P6/Me:c+J-,?/#4[dWVM:@ag>LQ=9;&@.S9<0_QS6>&LJAdL9f
Ef2?agPMBBe=;_\D;fWS#,<E&)]b-.#H,QKD?Vd^@@&E^+e@J5#1G6P@H:#>@C3;
&4TJ@XCR91>PPc?=O<SHGO1.O(^.R1/H9X7I2->,X]I\=#_>[S_O<+eTK<^RcKOa
HC=;@/>OKCA6[C/\6IEFa_8?bXZHKBJF<3)9GOb68QEMT(M#d]1NICD-_^^9e.&@
>NDXfI=QD04=A1SEI9b[;-,G:P3-gDCPa?aL@fbRYCT7B(P4CMKB6HT(74?-F((Z
A\/[S[89Y:8_1GZQ^7OBMfZ1:ITZ,JU+.QGb:M)+(.U:(GEM#P3\dJM?#1;?f4(3
.16)^Z?W-F?)5\K#WW@KZ(4LRY07b?g7@>4UZYK.^XF+Tg=CH7F(HXJB\9Z+be\C
,2&P:a/N9T[.D.GLV/E:JV57H+DH:0X.ZIf9(GUH_(TaObf1VQf?Y;E.1e>g0];G
;OD\7b1U.8Z4MfA<WV3YG(J]0>fOLI.Y&Y:#4]F5OMMd[=;VAQ;c\O;>>9)IHaY#
-S1eW04;\bH-<=ad#fFK,@B.U.fL(JQ3^E-d=H00e6FNS^Z>bG3+E;&?-V)cfbcG
(dGbJ6)e]J9H7SH;fSNQ9dV4DUeg17Lf62<g/RH.Lag\]=3..5W.WHN<K6CJb#)B
J3XLVQ>TBb.8Q4VI4+Pagb)U>C7_/5ER;4]R,E0bRd)8/d(R@+#7P:7(d_?VF_G@
B.W4FN:9[T60K.Vg9Z.Z8Nc9_]C&4+:O1>EH;D/PRJ;KUK_CEN6//\FKK;-=B\a,
6gc-+;O6D:5+&.Wd\[UEVB=^7[gR0V+9]g\JX3MM2HF:OMYGf\FJ>--H0HaN;^Rg
Ab;bZT-_\&)df/e.A+LEf/faN;Q>6]&72YTBR-7>8Z9O8CI<<GJBH7HGTOX>;WV>
eY<Q[HdC)Ng9,e<016/^,^/f]VP&2)<35c,QZ?]ZYb2;:XDgIY._P;+]#ZL&A(WK
Mb]g2-3[-V:.0WIUH+],aY:bd9d8&fe].X58.?F80QaO[A,3Cc-0EEf0TX[?>#O;
)?1JI-;:7cNQaDW5&+OY>SH37fW51dLQABPU\/(?JbA;dIg&1b0d_>#ZC6+5YP75
K<GW0AN>V&_D\;<>-V#9N>G/LUCZ6_Z<0<dWb^I+dF-X,EO=GXH:Y>AdHEeef<DV
/ERY?1eC:]Eg]201H6O:8aD+A;40_T_,J1[Hg?E&1K^PdD#GIL2MLKTdM7Y?L-=?
[>VQ@QM;&5#35H+&4-<F1#]9YMQ^M;<:>/V(?B8Me8LUJ&;6S4&:2/gX\G8X+0<F
]4=eAVg@-c,+(OX.CaY9_2[4f0Dc\S&QLad^AdU\-[]XL^Qc??>Y-2J0Yd@9L12e
3H<=^[g//F#BNU245C#M.fBKCE+Uc&AG-V-Vf)BEJ+VU>\W;fa<7T]A==19^,]#L
@?WDfe:78MBE[g<+_/EN)ON9590=&8IGNA>c37f^I5T07FH=;gaGU#dc9IG^NZfb
4KC#52d,NL_[-f)SDF3.:,CR(??-EQ9Se;@L>e-e)2dbZ^f#<CXH+LU#(;MZ>^W>
18AdWIT8G(MYIYHQS+833ZaUJDWcF&O043Ib^;=<L29ZQJLR.4:,Q[LJ]<(bOR;(
(Z?M(BYAR4RPL+5c=7A\T(RX<_=OYb3HZXZ8]^.0b2?@65dT12>@a(\a:c,21+ce
XBDRCe@XWD+;+,[5W;>;+)D?=>XL,C4K^-\LF62-ZXV:=fZ.(UB:-[<=DCNGJRZ=
_&3;JHS51Ef^,4PT+4E,aU6CPbL7^1U1G.?,0e2<9GcS8[._dF^RQPTD56afW&OU
=[RRg-YR6VX7VJg99G3eG7d/Z8W:?Nc=(f030faRC_/<[U/5PXC&c7=VYH>,M1PW
N/7@?1=?@H@SfD=@@CaL9CR;U-Af-a4SN2XG3RHa_F0#\Kg=2[<7Hg4gSgY0(2#B
CXgK6#=CQW#,869X=]H?Vd1)_9c<F4QNS,e5[;I55[[K],8&_TC4\?ZUMLQc#dDe
F9FaG/4#Y59/Q]/ZXdB@.K9-#]L:SgI/d-4#-0KX;Z,dI./b2FMVc>BHQTUc?P&\
O2ZTa,P<KG?33034LX-<T9_,2PW(c#S&VEX3A@/Y0T)G)Cd1&:<,&>e)V->L2;)7
51F>ICXHKQ9(Y,Q&25SOaVKJI4.=dS2N&#M_+>YMS3B5^NE?BQI?O27Z4KLRYX9/
bZSe8Td/cPbbKRdY:3;@B,+GRf/fBaK\2PEU]A_>L+\0Y20TcH\B<JJ[,81A.<B8
[(\ca3e1(GW^a\X;63US:3V(g\2Kbe^AUYD2F@Ka+4V&AV@:E#ae<A>\RDO_/d](
REO?/A^K(\RY(GOD@UMe3QZ^I>-J8I,:5EC/,#H[8R[d[A,YWQ6;2B<GAF?2-@QR
N&e^/cZCY#:NaYM4)K:\;]cX=-TMM1#.2;@15]Q5@&FV=FQS,g(/1_TC<U,Na1WT
)(aP5IUcI]UgCD+P.F=DW+))TS&04LR[D)2aTB)I+#aV(L-4,_U&CH6A0+Q^Kg=d
0SX1e+&ES24A@,[N-VOFbUf32LV:d:[GVW;977G;4,74NEW6(+9EKWE).X7&>?7L
bTN[L_485=)D:BS=(N7U4&:E9-U+^B718Ka<3>fWIH,e-]P+@e0+0e(JCG=#2<=W
WKWDEQH>0Keg\O5GJPMaOT6J,:J,K)NbUaSZ^c#Eb@6+^[J?&K2QUSJ0;FHa&&Jd
7[[E@#5\a)dVCfDFM,JY\XT)E[g2aLce)JBI^=3X4<;C+gN^E@H2:O/Q[V#=f:_E
gbL&I.c]cM<6g/=/S+:=14GGbJFY=PKW(R/C/(@Lb6eBVfHFd]NfXYRB+=]X(3@+
7a:U=:0aQXOB1HASC540-#CESXTNJ>g\;fg4adTBA2cC+_93OLTVD[&4NQ0KC#d\
TF&1b0\dgO&282;ORR:#1e5cH0^&X_T8Q[UGRBf/3D@OE3Gf1e\K5RSL=LP&&SI?
2M(P1RVc7J;2QA;Rg8EbU\bDQEX\9&S9F-BSEaU(/f@<<1OUG?a2S_&\)RL^X_((
FJFgTZJF3F66+cZ+>1(DeB5FdTNfT-3CY4)2^H^+b0.3,bYKNA@E02S@cNM5(420
gMVdVCLg.I?AEEa&<a@-PV]_dIG^[f4Y&\/+UdDE,\fZMXIUf#+fa=cJXgb;UK(W
C)g..ZB;fRJF:aeU67;)EX=Y];/B&E:+6GDMD>cAgfH(N:b498:g-Gab4.PX94cf
-^Ac\2A=M#CSffI6/&DA33b&ZcR18./+25;3gA?B37X5^7U)NgK[JR?D:)gO;AaK
3W0(gC]c6GX4G=Y+QE.LD-WeI1Sd=)TC=.;[PI;4^38:ce4AN(1(M2;MDBZgA([:
NART87-=ZGSPAR^ZeU,\,]?19EMX\M48M+/HAK\7,R.a,YWL2V\0L;3d7d=FG/De
A/J&)[OfL;AVbP)BU)XabdS4_LN)04FHJdGL@G0dY9X5VVF=Y1<6LURJTMP>BT,W
#@UBV/EA18I7JfR=F@4O;f7]W7,6(d[90Gge(@dSIfIM2@RbZND]W1e,#:9NJa2+
SJ>61EDe;2BgQS:<Y#Z?UaT/4FPKHZE1-1P>gRW6Z6[3;_0T2aMSG4/358B^K[2S
CSECGSI6Q89K1;C<]3:G]@1]V>SJ?3e^6/RMFQMFZ3H]c)DgMTF)I,GJ,X36-eE9
RN1S3CUO;@f<g7?f@PTA:BA1XO+fJXU&-^:S,3_Zc)[V&&7I)d9&:fP58A/+#WN#
QINaBb[X:(,fFg3W3?/8e?cEJKfD?#AGS:e=7bMB45K+8YZA9K@SLU8NH13.ACI5
BF6>;R-9120G[aB?-bP[,/aeP4D9@8RX0^_R+&(cHCZD=L8C+UMY&PPC&2K-&=WT
][<IP+)a&FW8#/O+5AESC?PYbaV6LYUE#\PVJS(=VdA9.DQPM>AcCJM<,AcVEZ3T
I57\);SA6E1^1L8J8.-=eP-,EPI9:\^J?VUNUYT7NH/66.7OPTObMO6RRV_@ISER
-+:IFgD3Z[Ea=d+fW@Sae#EeCLcH/f3aWZ(\8F](^\C6B@SI&4b].;gT#\CH:=B<
fF[BcZ4_XLU<2?Oc]+SWB]2O;ea.F..ZVX\7&cKg8QC)O^@UZEFP8C&H3L?9-_I8
8GaCZ^R,LUQ(:;G(F5ON3F^EH:5]S1dcWU-.P2W2V:)6VHKYHQ^M4Zf/]<f87Q[R
BO7PQW//K&EF/^\8A;&L[K&:-EJ7=M=QW^,YC_1Q^g9FO,=@2[XIM1-+MLVY_PbT
,bSVX:M(]<RWZ)HM]I87O&gL:Z[555+S#)c:8&&T>,2K,\5BEc9OYK8[gO.S4>1T
LR67I9XTcf;17Q&)/08.G>cgAJ<<GA=6UMcEb,A6F2Dc_+8@8.[.=&[a-Z&>7@[\
2B/(D6f4]QO=SBAQ5E1E>,7=^,<GTV^(#\?]V(4_K=?/S8a=,fIZaA0[03(V#U;2
/0aF0e+>e25H^]_NZ7bYR>e3EBB&?95G3KSC8T0gdYS-8TGaC^Re__<PWcXW9IgG
FP:c?8-EB@[BN>f5@cVXR1W5<M@I-Dc:.;-A-Y?0W_V\Z0_:<AO\a+(V8._aZKLF
CL_+6<@49g@DLdX2DdYOZR2JaI:XF2(,;fI+FB2#O#^S&D.C2<O?VF+(,_#?8BE>
QO&U48)b&@5GRF#/HSXVF_ZYc>2c.Of)GMI++#[>L6:fD)<NQBN4+8IG4L8T@#c9
caX[b@NS1:cPZ905GIPN:RVJCa8)9423gMd19#f@=8.D:-JB+d)R5N0f0G,_I9N\
OXZN(3U:^VG)HK2>1HONZ;->RbO[40+DGTLD0_Ub,.62M7BL>:6HfK73ZYKES]G/
)L0_XNJeYBI<.T5S9H&MB]-f;+GFGM)LW5TQ&&<1BfXB4NdHQYA;)TY+-@Q>C#Pf
NRM0#NG^CebJB6fH#7TD66>E9IQ,/DK3D-SI4f\&C3,)+W\?,-C7WC11NVAJ7?;X
W0SEM@]-;T6:8,8gGg95Y@a@4MX?^IcV0W,)JeVT+?7J@HdX(IaB5PG413#DeK(g
?/]99fS;a1X^T-)#N#[?H:IP^Z0[:K-BN.)IV9F>P_/L,8-FVTCYMbK3a=LUM)D=
-92KZ)H#Dd[L>cPATFPO\3LgE)XKQ,,)=LFZ2DdCaf.X\6]3@YIS6<<=CD>C8.1U
QB0L6>I:>gZg(_[9RR1caAB&TU4G=?BMG5\)0P,G9,#e&47AXO1,(GdL@YF+[cea
OA07C,VDBON2.ReJ&A\f9gEe=>WRQ1I7QaDaJFg/K#6&3M(\_3X@X,>7AHN@)J0g
g:NL/<AdG?3]&2NRJ6_UL7QC(.M.]O^OE_/V::+8?YYL9U1N]?S&cM<3(-1WZ:O7
Fgc;/)&c3DGF+Q:H;68MHd#@/H_OMXgM)^A/5\/[3YO?2V\;[S315X9+^2K>.b,>
EL^bd//e.Z&+#W/,(W7\TdA#ZOY29N=AbE<D)B5<J,CB=eD5;<88BN(ZQ+T>PDWM
17\[a@VPX_Fgc)7P6(@@eZ.d1a_T?:cMM5R\BOV+5L<;e:@EgI[a.)g#>47OgRJP
@-JP390g5U[>+L.?OK0aIKb4RS+/K/?:,7>]E4cCSCN0d16//f;)10-A4fO;G;VT
8K[/P@Q<>ZO@G=B=N,c?X5DZbK49DVK)K6A[J?aDB]60=Pe8#I#GYS6YOP#PNNIX
IKdELW<2bINZ0Q:c,Ha,76\X<gbT074TK=9QK>.M,5K0;_LcUGN9CT.;<F[)WPb2
\[7eBA)/WT\)bV2E(E;A3+gA0OTNZMK[N[9_SQXHP9^K9e2./--+)Z)78&;)Y9e^
TL>K528N4,IW0/)<<-I=b&[d=f_QX<a)<L+)Ga@0@BOSY:Yb:c#9\.[+-eUWP5^F
d9.NWGW(_KKS1A<:+Wb?gC+CX,P?[QX-_I(^eUWTa/)f\_Z/T[Y+H25_]XKW1RBZ
4cW5eQ4,-T.<N)ES[HGV\ZEcW6Y<a81<1#WFEX&FL84fPJX>)?6A;L:T@d3WMBJM
aAPe2<R>GV_4VJ&J>ERe\SAYINKSGR;X1C8XY(?;6Q/^@E]BWYX&LLTDg0@g2&Q:
X6MK;X1:K-&B\PE;0VRNO)ZS20R)8>1TC#(@b07E-I2,ZZOLDc2C/+?3@K=QD2]a
dL?4(bTPMXIFR(5_e-.U3B&3(,g^YN@_V>9-e4PG^>,g:)AV<A\ZRDa[7dG-5FN0
QSe-32fH#LQ-A-;6S+a7S1#^O0aA8,N?,fHU09.HH3X</)^FVJ7-e.ZH)8L(0GL0
&,;+a2P])LIXI\<[)&BT9S>]cc[?4^,H6fCC7-GCK/I5++##_e[(Cd#>8W(bQ(;C
B.UBZ67,-TIWMFY89#Z;;PgM4A-E(C&K2ac_c75P_\WPbL3V+8J5B/a0M-BK@1GT
,bB.-2b+86I>=<5]4E.G^])^FdH_XS#\8-&BD=(&:L>9KS_VP8QY+7a=7KIGeeI<
E=HF@4U_DLFWA1H#8\4M])8]^:E+PA50>dO2NJXUXcB7=,>8.3TVE]CPLbF3Y15_
OUY/LLR/NT:fF/W,1T74PT?g1+LRCL5V&VP0/D_L@fdY.CGH98e(fYObd952Q]<T
Q,1FMEZ[>ZZ_#@6A16GIH(D:g-3P[X_[Q7eg7J)W;SfIc,.A-VP,:]O^C)d)_FA2
4<G01B=8]/HdC?d]GgD,3EcM=WZ&].9)FA,-&H??cNc<6H.gBC<PT[8=YQ1gU2-U
efEG^UEdA88SE#/4)RN,f+ZWFW^4E>)X7;VN_MbG?JXeB0eSVMX#1[f[YU,\L1.]
0_IHTeZZ7_f<f:FReK:HF#6:_Ff__QL?WMR/2I9?F6J8e,9]]2EaOJLT4+#V(_K=
8/C>L<BdXVL0V8(fNVO,,7Y;7F^f8aV?SLg0[ICc9/1a;fU-+KS3T?@A2U[0C#_7
Qc_6=R>f\c2c(bPV\2c)I<66RTY,WRf^6?(&YZAPgI9/aP=,<:US,PIMCGaUIA#]
VZVMUHb8-4_#YSU,NXTCR9;HG^D&SfX64PW)BLdNX[IP9gY?_V-]c/D,LOZR:VdF
[15PVI\)NKU:<GQ-@&d]IO?@f,]T+/,6gAR/W_M(_\=J>1=FaGbOZ)UQPL/I^RT4
IFcR7Q>[:=X_YD>[-aHZ\62R0R^bLDA-HL?A;4X?bcPQ+2:Lee(W1)HBaKIB=2+G
N,K+&<U/^8E\WQ1\_AT&DB=Ybe:b;LKC:)[+f\S7T]KDG5=_?gc]MEET_3LJ/#-J
>JWN8EXZ?><W=WaOPBN.5KAQC/a=YV]6_Z3&;K(>S/DggNDZ@8N06=9^L9;\RN9,
9B\+>fcb13cYGM0UbDN?BMgKJHATL8GD]a7IX^C9;7Yc7Ab3<e7W:0,7f:eNS44,
RU@cHA[81cTCNFN[M;M[\KVW2+7EPP^gC&DI#@\GJVG;L4YI<Y<ZIOO+(eF=AWV4
4#&@2-?::#Ee=W35T)\d,M;LC4G^>[:T.b43A6ObAQSdGQ4b&KRX5ECc.[CPQ30(
_1HQ3TFGVLVZII,GJ+6+/8F1ISZg[e;UT=(3S@[IG[^26L]SCWU9_gMg+6KPcTKO
;^;A09W#4\eHR589-8,-@SV<:<&/M+V/F+^0gE.=bOIPM_F2,\+.(&5M-I79ALO@
/Y=]9dX(\E(.M.f7K),QgP:[=/JW7[^&QIOF_2(_,ed#Z5H+573@7ULL3HD&ScP3
([1Q>c1#26F?S7c1Q<F_:,^FXe5KaR,Cg]MQcZDA@;KbIg95aUP?I,0<#]G:4T;;
<7^[L?gcSDQ18EE5^36^CVA1eE&#<ZX,=;EN=L#f4^H?cFB5b+O06\FVG]5(Wd0d
g<P@IFY^PdZ,ZHP7VZ_;#5USQ,PE[]Uad4Q\A0OPC^B[aY4JgQ5FC[=aHgG<,++_
+/#92eB([9K&,8X1?[Ac5UVFL0O>b4(=D:94eXbcV<G7Jg8W)>WK5b7Nc2XG?&I8
B=SL1Z,FE2?V.7-MLVMSCKC274GRM&X_E,^R4<=5SVKI[\^eS?10<BOF-2WE3J,#
aMb(9gQfRcOFe\B84YE1MR.L>H#;+gYBa_9(Ge63\SLBEJ0^VX=)U0d^\gTgLC&]
^dYT=<c@Wg4<fXRXGBfT;>a>Y6U#MO:/8()B>\N<Z3:D12.Y.YJFBPLa@SDYe+cO
XZf:[5<,0HWE4F1_a-YPSOY:U;)fY;7&aEUEbedZ\E6M?IOJ4\>C\gUBZeIS:H@Y
0^OOTNd-\V=U_6:<9H:EVI#3>0;f8_/\&,LG8A^:C^H9/d[3#+K<+O3]_Y81_=bJ
Ba:I+0Bf[<1HE4:,X+OH9/A_+#KT7aT;c^B5GM&/d8/M<B>SJH]E=7^Y6?O2V29f
-,XIUIcgXA)C4AO-M@+MFZ-c:HUcERd4I>g)\3X24Y0?_0[WI7YT^##U&8I-[(A<
cVI?\2YW)<SN.D0e>]H@cN.:EZdLZ4L;O8ZD;C91M]TRW\gNb;bc0fbB,?@DdQTX
O&E(eV;Eb4^#KMcYbU@6g+J8QH&\4cQXH1B)Sa_4Q4Y]fPeD6IR[&S.GM+BQ>g_9
G6>d6#N1K0IBJOKDc+C\M(PUBJK)[a,7]#X9-YJ&_D2N(T/fKM.XAC,MNT?/?VAK
<WY2(gY,XEaQ:S=fRIR7RK3b,_-JfSET^McQ=;)[YeYeRACe=HWRYMR)42+6-5#?
X9PeH[@]WTC:O)H(V^.(2>_B\Me^G(H)WJG3?Z58&[C@REbODC;^]GP4Y:W;W_Y9
67_C<R2c\[G?b#<O]E;eZ?C3bU)(,Q-BQ#?4/^\N3F/U4MaYFV2MgbcS5gZVM?E)
f9@AJY0Y0;.A^#=N4_ZSLJCR5Ze09OG^[XX8g/Z6]_+9N7Ta-TSMZUa;4;7WgN=?
LE]OO?E0NVZE];^A\fKX6;9=]Z,QGMUeDCIO80XD-36;a33Y_,#/P:YSU/OefJ=,
RPQ(c?I9Da3.N:QP0BD&319Hg,F&.;c@]E2(62]<LSUF_[Q0#2.feg\\&+g>.)[&
_JZ\^G^4K++PFEE]Y]K#\^Z24M>.Q078a2LV(+.g#^MWa:)(GcgTGLQ\7U4UN)\E
()L/[(9D2fV#[PA(_b2Wa9Z[-W[A61Sd1.UD8CO5)a6bJ6MOg@6M6FB45PS8LV-W
gFcJ32_VQK=^RaXef9[_VB9:FGWbP(K+>F,8](1^:8+3.#//EBB4fTcFca]IGG_B
0eYGI/2KNX;4KIN2:OH6PE+#Z6RgGVB7D>?P2MbP@O<>ZA-VM3:-=@Ic6654+W,(
?>LP:U<1IN^0g&S1b@<,&WdFQIg&>>0eC.R5ZPE(3_:;XJKBX4,W=VG\7I?(J4Zg
Q8F3DY)067<ZV2b<CQM&\e;J+,IIJO2+\SD0H##IJEBHXISd3.[D<R:3OY4gP4S_
D1M7V;d)Y=&R#[JQEJ4Y2b@SDg3N4FPaE1@YC8S;[=1T-PO94H.<:LY<4J=)JAS?
@3=Tf)ce#=;))L;>Y]&&1dO2>,)0U4R<ec2OVG+K#</P=/EEYGWf:K.RGCZ>([4Z
f]E\BAcQ;8>YOZV;Q7C@<9-6N05Q[WL6.IJ>_b\VcH^V.V,SB7-1N[DaR)\_(AY1
c9SUA=<IKT5F=B&bSZ?BQJ85f2(b8.f9#cX-86VUWcdMFZ3C?9GBa.VQ?293RV-7
7/<(YBUVHdKE>P/HG38RFVLHT1&4_^^L>^PJ6W1[^M(8+EKL:SW?JI45PF0.0?-Q
3<U1<Y,+(UB#c^Y9b[Qc4-C2EP>gD/7ccNeN(Jc-T^0c]?,?)7[)=;@e.Fa&><[(
M\e-6=V\<7,2EN6Pa?U&,RP^]8.d;eG<GRG<R@]5UV+;\J:gN/,T/cf:.VJAe/E[
d@)RV1X;]\:Jg?XF.cUQ4&</5cf;9=-OUA)SHAE:Ff[^bX1b6\5IPY[6.+>VK/HP
JD(+^?\2K^0Q&I.-0XKgg^eO9:T-c5[M.BL=<_K9[O#9#3a9XH/U:3c6/^dXZ_\H
M62C<:DDMVgDPgY92PCVeQY:)ER?RBHHbdcBP_D8W?6EIW12H.<TQ[SaU,T[UPER
G/D)[g^;^LVXJc+W[1(Y<88T^C9T>8b>]1X>M9J[41^OB#PE0BX,Q=CAD6DHW)V-
+f6K01Oe\-e-YNY?YXG[,EQ7_7UJ:ZWI=P5:Sf1.cL+]Q6TeCCATg/O1QGY:)(6T
d>R01XY2C#T&^_.?\QD2cYJcRe+Rg(U7PR5Wf6dC,,6gS>dWEfQ]<e9/:-Z95@2N
NA:^b@>aMR[S)H[E)E^K]Jdf8-F)7ZLHX&;XY7=dF<Ie-6bY>7?3)5VJ06ZKLG>C
PQ1E0-cfQGcY#7J:gF/,O.0R2B_d9#UW@3F&3FSVR+:I8eHROa)D(a?Z93g8WMM6
1(J@<[6a;K:ON6[0>U1fcG+WC[f@S1[]3D=8eH(KO7Ie(M@a([<UP@-SF6(^MHT_
Fe\0<[?5WG#Yg-@NgH#0<^OXF52fIYQRQUHdZ(2,\5FJ,f_/YFT+bIUgB&RZbdeB
N[>e81N:?+4ZZG?330+6EJU]#D_72dXa\<&8NP5U\G_L)G?]a/[#)J5&\?34.U2M
?XJUT?6@bTKL=g5GKb[7GWFWXGQUYL&8W3R0^H6,LGeX&-(LE=,.?aFZUFY5)aa(
E44=(eFfGgSQFLO^PLZ2[4(Z<Fd9PUbP:O-D?Q7cH4179BX);O5B4W6S0P1][ZR0
1EF;C)YHN3V@=QP)da6R58g/19cF8/MA),2NQ7U2MH8[B3Z^^/#1H]M2(dJ4\BOA
K1\VP_\8fP-&GA)=B\MS.>ZdTUUFL_8HF>C2X-M;Wd8:9.3;)dR+J<N.+U9P+gaT
g8J-UVY28?fNe\SET->6#4ICbdL\-bQ8&HO49Yd>B8ZXD?R6QV+&cY>fL,\0U9_A
f.[L>^E+W2AdJL&@Uc&f+9U@IZBPdbV[3O3URU?&Zfa\>V)(W9LEfC+_0/P:#LT&
IYS?H@4&?S3E5d883CIb)LbQD()6Y4-Y;_e+<5L-Jc(WER&Bf<7UaIaH<g3T;A9K
_W5aSde\6ILP^+,YVcBMK^L9\@<EG]X]UNEDR+2eKd6+TKLMAJ8aFAFQVTcN62-M
:_G+-GRUZTG(Of8Y_f3a9WGIf(/R88UYN0YXOWV1D&8-f:<+5cRGZC_2ZE4a:ZaF
NH0#W&I>f=2[@OO]QK\GI3c6HcK4]-S81c3LY[)7_]d[9KX,+IBHgPVKS+&aOTC\
8@dgB9>W0AA)OLYccQ@g[(MDgaR?aWR:+0UNOXA6KX?:N6F\cddI&]6L5=NQF<eH
=DLf=ZO0:,MMa5A=SJF@43?B2?D0>:NZH:)34-O<-.YL_T.L6^aGG0@3ZG@fYO11
W?];?\L\Md(0cK16L]K=:>C)]E<KI7.0?9HS(1#354@V[4LDNE.:S?Yd;+/3<ca@
9-5(\3)TZF3dB9T1W9cS=X?-1ZYRMd6ZSTS/IaEL^L&<;.VgUNe0Q&.WSg[54_V,
OYQ:EXB)CPM8^3cEN))Ub&W.W#E-+^JW71,W^a1_JdFF&-7#@a]-&FHBV&83O,CK
GPA8&7ZT,-0IPH/,NK[U;9gK2TM@(QPI54BI2#0BN3[4W9YD-/L/BCK8QX2I<DCI
9?XYWVFUJ)G8C9@3H,FA/I1#MLF/7+8NYYRMUTY(]c9=&;ScYIN;;I5=_/WRQX-T
,HOFV9MJ.Ig\V]&8WR5VCX2TbV&28\RgbaPLP#Q70@>fW@#QfS2eF?\2-Z/A]f5X
bY@>g_9N=63DK-KZ.b)9UHbVggb,+c@Hb-bM)^9NI;gFFCR^eKBX.]0<c+MaLAQ^
;\]R\UQO)a&<MGe5P7Y77WXfg2T(.MY+>]N9&f-#E;/?QEBD>&a+-H_OE#Ge7,8^
fC>NBZJM765:bV((3R.5FD?QfdLQ^CaLa\;J&AJMLI@&g61]K8_T,_BDF,\8faQ@
88//N/AS[&4QS&90.&a?+:0[:=AZ3fLPF6SGfPBgQ8=JOI[dY>ZR13d(+eP>X@ZJ
R\RKV-Y4WBDTD\)O3]-VAQ][[LO^\KX1IN56ODVPAOcDA\V>)D-?=Bafc/N9\FFD
PQ_#JXR-73Y_J]?TH]Nf91H)UE<,^1-IDJAe?;;T@YJ-FU]ceLUZD,>2&F9=Y_4Z
\S8e)9ER>d5Ra#KP.@Va<?F5[2H+6([?\9PUgPLS&Y)P9((88[T?12(@gH9.Cd2>
Q)Q2g&OgFVb2caLdYT91d,IWPbRZ]K^TRg@ICPbO_g2XY##6<@HgYfHd[+MG+1#V
;3dMbURR]6JG62>dI@89^I5F.ePK\W\BfZ[+,=1Y_;]3QWH;5c[@OcJVCQOEdO^A
^J=9I9W,#9D11eN0Q1H8/(06Q9OS&C5I+_c&/^2FA7C?bbZ2HK(ZdDSgJ3AY.:\<
)^[SD5^F)8fBE2N?_e)@XW,)&[0C/cf0\#X_VS]Gec.O_cS]3FWKa9f-TZ?@6>CB
H5,5^I1.4FQ+ZL,a3MF]a,SD<UBA@NWE;;D;g)()=@S;MIaE)FB,WA-c#E@F1DQX
eU?/5^Ya/3_83^;-R46M=E\>:KEAF\=5AdV:->]BeH&^dL960FOBIGOYVaA_C@N5
JfQ/Lf(IHWVHD?)BLHe447H:+7.a2@R&27Oa+-NNg#23(CQ?H1EQ/XM=)Z);65[2
UfY#Za,FaD>S,<Oa;#C)ON.:]E6C:aJW;$
`endprotected


`endif // GUARD_SVT_GPIO_AGENT_SV

