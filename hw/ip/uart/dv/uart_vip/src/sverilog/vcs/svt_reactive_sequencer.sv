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

`ifndef GUARD_SVT_REACTIVE_SEQUENCER_SV
`define GUARD_SVT_REACTIVE_SEQUENCER_SV

/** Determine if set_item_context is implemented in ths version of OVM/UVM */
// // 1.1b
// `define UVM_MAJOR_VERSION_1_1
// `define UVM_FIX_VERSION_1_1_b
// `define UVM_MAJOR_REV_1
// `define UVM_MINOR_REV_1
// `define UVM_FIX_REV_b

/* We are using OVM so we must use the workaround. */
`ifdef SVT_OVM_TECHNOLOGY
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 0 */
`ifdef UVM_MAJOR_REV_0
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 1. */
`ifdef UVM_MAJOR_REV_1
/* version 1.0 */
 `ifdef UVM_MINOR_REV_0
  `define USE_SET_ITEM_CONTEXT_WORKAROUND
/* version 1.1 */
 `elsif UVM_MINOR_REV_1
/* version 1.1, no fix, so it's the very first release */
  `ifndef UVM_FIX_REV
   `define USE_SET_ITEM_CONTEXT_WORKAROUND
  `endif
/* Version 1.1a does not have a specific define called UVM_FIX_REV_a, so there is no way to distinguish it. *
 Therefore we need to just look for the subsequent UVM_FIX_REV_b/c/d/.... */
  `ifndef UVM_FIX_REV_b
   `ifndef UVM_FIX_REV_c
    `ifndef UVM_FIX_REV_d
     `ifndef UVM_FIX_REV_e
      `ifndef UVM_FIX_REV_f
       `define USE_SET_ITEM_CONTEXT_WORKAROUND
      `endif
     `endif
    `endif
   `endif
  `endif
 `endif
`endif


// =============================================================================
/**
 * Base class for all SVT reactive sequencers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_sequencer#(type REQ=svt_data,
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_sequencer#(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequencer#(RSP, RSLT);
`endif
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else

  /** Blocking get port, transporting REQ-type instances. It is named with the _export suffix to match the seq_item_export inherited from the base class. */
  `SVT_XVM(blocking_get_port) #(REQ) req_item_export;
   
  /** Analysis port that published RSP instances. */
  svt_debug_opts_analysis_port#(RSP) rsp_ap;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  bit wait_for_req_called = 0;

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   * 
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name,
                      string inst,
                      svt_configuration cfg,
                      vmm_object parent,
                      string suite_name);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);
`endif

`ifndef SVT_VMM_TECHNOLOGY

   /** Generate an error if called. */
   extern task execute_item(`SVT_XVM(sequence_item) item);
   
   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req, input `SVT_XVM(sequence_base) seq);
   
   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp, input `SVT_XVM(sequence_base) seq);
`else

   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req);

   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp);

   /** Continusously wait for requests, calls fulfill_request()
    * then forward the response back to the reactive driver */
   extern virtual task main();

   /** Fulfill a request and returns an appropriate response.
    * This method MUST be implemented in derived classes
    * and must not be called via super.fulfill_request(). */
   extern virtual local task fulfill_request(input REQ req,
                                             output RSP rsp);
   
`endif
   
   
`ifdef USE_SET_ITEM_CONTEXT_WORKAROUND
  extern function void reactive_sequencer_set_item_context(`SVT_XVM(sequence_item) seq,
                                                           `SVT_XVM(sequence_base) parent_seq,
                                                           `SVT_XVM(sequencer_base) sequencer = null);
`endif
   
endclass

// =============================================================================

`protected
gW_K1dD^J);D.eS^VP,DH\FK@,CV;\YCR4^;]\;D7X),F^)DY?g50)P;/d9>C@,[
Fc.S0HE+L1TA9gQ@O((0#LcbT:)=,X4)\;fG2+U.aV&1&2+I1=6]?[F,+U=a<b//
QLFM-[.)T;=+GQ;\/95A,P</cU51b#S=f^:Z?5YC)+HR3QDa^D_d:QISFC]_FZY)
A>QVAA7#8R[J-B[(0ZeHO8UYaDD/#Q^^=N[dT[(VECD8a+0fD&f8,-B<AeS^4EW\
+;KU#BM\KCU]BJ9G-;6>d^<KW8^c1^+GCLf1@3bX__gQKS3G\^G+D/8XQ?c7^LLE
-EPc1SOAcIZ>)9LB^B7A=K6^.C?QZ1aUa\W+X>d4-B0M1W<&c\8:d[T>d2X57)RB
B;aSPf0E08L^TSE1UV6XC^4\<#Y^E]7_bLgLTHDc9dJOD7\-P]</NEeb.O(P79<B
CTZ<17P5GMdI1a.?6HYJ>)A_.MdR\;^CY879YB7V.)a_F.W-V(YI&F5Xf,(AT3Z1
ZXH<Cd<]R>NL\,_c+QP:]+eX5C3gU8Z&;E]9APJ3)Odd70H<a&_5#C/4UG.+6+:A
gd@A7.]8dF1U9XB63Q1/6+#LH672(A#+JT]6F&<H;>2,26QFYgAF]9c5&>R(8?7K
<;3_AeHf<Y=Rc:[U3QI5<CSN1>;I,?53==Y5XVZP4Z;F-8>-3fI&#VYU^AT+G@BE
D21R>4J(>HZf9_&gE-(^Z3\(?OEV;Cb;W2@R.NK,F\5&a]VA8O9]AHP<RPP^@Q;X
S+\CC:I?:M#44EIMVWcB=Vf?e>_6b>6NEB)R/NLR45\?=:K+AD=A>4P>Kg?cI+Gf
L\MN&c&M,?=SWef>Y@XS.Q(.95U+Af#K?P^^\R<(G@N,dD/=Z#/4IGQWgcd1ESWb
CS<=f:+^9:eHfILPVe_Z(T8T]\ZRQ&U35O3W<M=C;G)QfO@.=(^W/f-g>]=X\EF5
H^CeFR8S,MICQO<(5_.UYX]9fJB;=G?,MA,1;b=e/4UZI/D,g4@B.O8OJ85O7f8c
deW3+8T2)OUcd_N=0XeMQ_W/=-b?d_BU@H,2Rg[[\gK+&,D5(f&XHdT<?f5IS-B]
a_b?B9DBCbSL4@0&DaeQ24ga2N+a,H[R98YE6Ia#)>PJH\U\&gT<da=6JZBUSWC)
CBZS8)@C]Gd7A5eJSURGLHX7HA@FN;GC52DJfQI#K[L3Q=Ae+=g\9:1Z8SL12#H8
[?9@5L:79T=a+aaBcc?M?ODV.cU[B+PB>N5CHDE-)VM0.&.QGaZecE_]MX[G60<f
Y?Ne5>L)P5KMY<7dFHPXV?0&\-0929LK5CE/ce4ZWM^Y_;B1EdY#MNXH:K.gdI/P
OJD@UG9VAZO\C;V::2>1^=Zg:(W&#@:JLUP.S<B.cX(5T,A9B=X]VLIJ2A6Q;7Bd
9A5RZROE_:::6cHa7;CIK/Nd>&D+LO&MFVU/2cZ;JJV24e9=I^2QbegU^Q0Uc1<5
94>N02-5RQ-C[8Y9)3CKQ?M=d3I+FcGCLQB&0R_29T&PB8FB[VMY9,UfHA2)W-:>
47f;=N+<=H00+Q?a:=/VK)+Uc51e:>1CQfc\?\0Jd>f4V]8RGZ2>H:(b@0IM^5/?
+4BANM=YS28J@J3VMF8G:1<97UUM9<8Qb+Kc4<X0L(>-(EHc\Z5NKEJ7F5Oc>H^)
DbH_E\(ZJ[g4;FN[N_+/Oa0c[.^a(GcWR]?PfS\/@,JfZf2,8Qb--YUI,B6;RDD&
e3E[<faTMGR1Ug;1OW4++KI.-ME60=LW4C^UfBEc[b-_2?,<.JZd4S?X)3\8,R7[
T5e&g9CPQ2#<+]RZTL:KK\I.2$
`endprotected


//svt_vcs_lic_vip_protect
`protected
ES(??.YA_PT\S>d/dZS3++H-8-2ZCU7B>g3RX<JV:0RE35DV1@@B4(C]<76HfA7g
8(GdVPZSX4UR5@Y8:DA<\@)0BZM:I<K/)MGbM(RNM8G^19UMIHeAKT(O?g4ZcX;.
@38Q9Z).^]V#7LUY\YfSRG#06cF(bUdcc8I-e98#H@A#WQTIdJc<fMc^?f&//G9H
+/3TQS?C&Me.:F]7=4OA\NW7CF(5XWaIXP<\_egQ_)0X1_:Yg=J^fZT);EHM34a,
cg3OG3SWOJFN8ZR\CI)&_g[7@bF+=@N>_N#I8@V&M2/H\#&JAB62?eX?@8-1cWLE
.<HJHCOSPUO^KM5(8?;4[,d8]K#2WF)Q.gVCa]b6AC+.eGd5N&@ZZgSC8GF320-I
=(1)MV8LPc>GBa6^XK>^[J2)[93H166JLeCRI<F7L01d9=BZU;9GT<<L=VCe,]OD
P6.::U4Y26YE#[GJOeWe;F=JHZ[+S[A>a9M3-(a)[X9&MVS\YX>NXKa(6=K:VY1#
SRWOf<a_+YLFdC^S)9X(+6X[?EM>2YE]A@_O+La-&e)S0\VJ[C_-Z+>=VbIC.7Df
gNZgGeCTO0&+c+C;VNPQLUO[[1B1L9P^b;TVI)TT\\=4R_NETF3@GA/H+]bL#A+[
f[f#7W5/#G,#KMdV<&afeJR_U^G07E:;d&^E.J6H>@5B89-DCN\+@O=+)=)N]X[E
_](G_O);[6X0.ZLOU8=^KOdLW1WI=9O1^M-I2PB@TJU8b95A[35T7K#UI6GL@-c[
K?AW.HEa#F,HO9P2,21E^(>Z2c;&:40ANPDAQBM6S:QWCO,bKZ@@]+AE9RZaGY#K
O_R(9QW)1ICUZ\-SRIWN-TFEP7Lg\)E<_H;W^AE>e9:X]agK9?MWZ0?aWc<:73U9
>CWN11S<e(ZbT1&+WEKbdCZ/NeC\cggVf5GM&P14#0WCc,;<g0TR-cJNBZaLf:4\
dcV8MD5MCAIT#<Y)89J_W&70/RV\FY>?ag6g^VOfL4E;XX.PR2HRF.AE]D[NN>II
AfWb]?A9b_.NDZMg<f(@eVB4KEa^//:9AV46,E+]GIdfUbZFHO5Q7T0HRdR[@T0Y
-P>C:[-REH&LTC/ECE.FeC\SVXBcX98a#7ge5BC07E,2F9EfQCfQDaRY5,YK1Ra&
-R(MM=]OJDR0+-V]2SX6Q)eUP,;(EQ+VOAQ:]g4-MAHGeJDgBJQ;3e4V)X1^=Pda
VLd@^:LY9;1=a;I-.N&?RO[A2)Qd[P2F]4BN-B<g,O5FE3I&1O)EQd2+N12X+[P5
[C5F5DVb7=-LE]OPX#5G]YFIeP4U6(Qe5RJ40ec>B3Wd7C]7@58YQ33HDA>S<4UO
f?J:dVQdEGK]6][Oe9+KICJL<f[NHMK\_;A01^?,[(\N^B]-Pf2(.;633FbQO(EI
-P8#]>[IHSL9.bQQ5BY6H9;c04?.T:c84&OYePc3[DEP:NW?]O[CC4NeG&)>aE=&
[N:M_2?OdH6REJg9R@TXK,]cQD)\XCBR[P04:VG2]AXAc8fI]VQgI)Pd#gZ^@BL\
HM,_BNgHVOD^_-6P4&X/)+fJ<M+P]5S(:/Q+.@]\Z7Z:Z.c]A@>Y]Je9AV3-NL\_
f2HW-b,d^VY4Xgd^F<(8FfabQ[>O7gfQFQGME4KWG#V@(4:cbXQRf&cCFfg3CY0I
UJ4-HVeIX++gS+WL?&c,-);:e4M175&JF/QT,(_7<a35Mg@/QJ(\&bP?M;^26LUf
LSR#fH5U\0<4TP9[I1O\X0Z/c+@-MY+A:NKOX1QS#7:Jf6SgRN[HB&H2^Ie(:E)3
H(EdS@=baN3O]aR?K_a(3aBMF&(2E)2KN1Vg;MT&,,9,N.Ba_[]=DZ1,3YHKUJ8-
=?JCER2QaT24G;/NBF&?2\?#H-ZdW/bY\fMB,Oe:OEf<P\2-.6RMP;0]YB0:0OB1
77:,0SG^dX8V;QF3ME3cIT_BFHY+LCBUCFE?EEdCeVH8ga+[TM+^e8dJ>_I5EQ?\
-EM7M:D/LT7#E;,,^dW:S20eG+PRZ129[OJ)6[Y5<6D6/C-<DJO@A.VD^MeQMA?@
Hg6>QM68)FeM<dA@?OQS)eD:KM?JE[0,#FQU(f[^^;:30Gba7]^5>]DC_WH\>^Dc
>VGY7C6D\gWI7^e690DfULW\R4Da]eIfW-aSYTD?Fa5=FAS=2=E0XHIUa]_.M70-
9BB+V_7Y0CDO:#<+/dS#]W8CLY6=a,M0JT.;NEcZWSJDZ:_VZC-/+29XB_/Z=1;<
#E@2EKO);W6>f0CHJgeVB^?Q2.>+4e4EDA^c4^247ILEZ7C/+\Q^6R@gd2K1D032
L5Ta:G(K82VMHbY]0<(_9MgKR9A95gI?_M\-O6EE)=MAH6D6X47d+YV0#+X7EP?e
/4[)gNQgEWU^U20?+\0:]B7L@cI8_MTVE8+KdH[4e0c/(Z&Q1GAd38ZKT1cb?L44
6Q3G?)cD6X):Q>)/(/;2Ua=);2Z-e:;.QCEeH]Af:b^Af@20=YaH-=7dA3I(c<BB
CRI9M;D=1-eSQ\eH5)ETI[0T,O+C55,>AO+2Q)Q5+Z?5;=JV<5OU?5X8B5V2-Tb3
6Sb+7FZ-b3#5Z[4Q;VfON^\DASMUGd&)+2FKZ<R#=?1PB(=>KDB+#8;?^I.SP;ON
W?e&bHN13gHTK=I99dJ4\)HLU3,.Rd)b-gaG9e4@G^>9CV\;L[fBZ[.P0+8TPTGW
04(-D(^V@E\+ONDb=(+EHC(.EfYC>5^79f3UK\3#CV?1fO>(0c&>H11+N9Y@;&P(
2.IcU2a)5Qg(\^b8gSc0#.a[4Y/[.DC;_@>&94L27>aSR]?QEgC4_aG&3Z&<[>5Z
C5EC6&E3eaE0dZYVP-T@?JB)DB&_1a4[/U26X,F/EYQ-B@[fJcId(M-XVYDEf-#B
BeEc=?Q.FMT\Jd/(&gY,-T8H#S?J?eH]+\IMIU;e^7H=/e.2VD(E(;G>QMXg.YB)
\3;(/#.GPbM2:,&^HUQV1,EW2G,@@We=8WP:[PZ(eEBLdQ;dT8)B]UZFGTN)bS_b
2_6DZOb#XQY3NW(+A=d3,[eUXb,GY0+R4U\CL/\X<@&GE<2JZH+XVRJfW?+/XWVa
T/9d1@P:+&:8AM738e1(Ff>fe,cb_.[aAZ0Yg5eFK;@+GK.3=^D+ANN3^,c,\<A4
@Bb]M[0a;,B3V+(-7a+8V:FN6e)WK/\#77\>G]:6&FF=6^K17FV0cS^R@((?+N(E
JObP>&,.fNH]8TXHZ\QA,JZ,(.cEHH#1<8aV=^PD2K(DdaK.C?XLS?a4+Y?b9JS_
]f[@)RFQa1_WHW[IDcP@_J(<V&Yg(I8)/-/M6#2JY;KA/0?BAeW^\GGVPF7&=^E2
6OfX_#))FMX-4=^Pe_T+M@/8Q04^fY>K;.bD4XHS5O6>2<-HVg\6H[<a(WRXgDNa
0X3I.(&>9O?^:BFg?.BGg=XL13/X3dEFZ28-T_^SSKa_Rd0JVSM&;cE_PE[E^RS4
YF_(eeAD@AVS>R=(WeQeE,bBAJ_+g[Pb;dW+ZKN;_+::\8,9TQ/1#X4A?\.92U<Y
a;Q3f1b0:\B6c3SG9N_[fH3AMX4D\7A7[<<Y5^SNMCP;fS<]S7]6/]Jdg#3\KGXN
H]\1.[aAS4;3\7OF)V^Q5FOb49eF42WT]C42?8<GdK,Fb&5Sd9EgVED+1&W8DXX2
EO2OT1G3CGF\N0&#[(IU_N;9J+0DE##Se:8I/0)(eK_8e]Eg?30/a^D:2HKET5K^
V).<^bc,HQL[Ce#@]M)5J+2(\GO@@7c3?2-GK[#E.UK9DK;cBNbA05H2HHL;X?\F
]SR+73C,:;3WMEe4XLg0<NWLR0B^YfR9^N&ZB&R4R]1ZB#72+C#<da=>Rf(A4#a<
#C_7MLZL?M5fD]N/;G]1\L#+V2H_J66V@L#=:G]5\6ISC9HXQMSXKB\LV+bR2:dT
@B8aP)L>_E,IEaT]dM0C\E->B\(]BP@e[W-B8Q(NIE35HGXFJ0A3SWWP-Db9JbI\
+[JYME5d1^@5CK7O2_KbP/dR56ML?-V<A[-cF8&XKae,9TLBNagLAT>2W:VSIS5O
Y7458fY^f&?D;(1]..2/;:9J@A=PXNXV0Rfg[9e=f29aRN]WUUcIKRHG;1<F_L9D
5Q:bd;?)?B;3XdC+-[\O/b?W4KFLbGcH[B5df1R?.,8Z1c1Yg[7_;SHGJ$
`endprotected


`endif // GUARD_SVT_REACTIVE_SEQUENCER_SV
