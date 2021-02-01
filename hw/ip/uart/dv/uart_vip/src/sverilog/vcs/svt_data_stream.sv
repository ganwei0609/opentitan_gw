//--------------------------------------------------------------------------
// COPYRIGHT (C) 2012-2014 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_STREAM_SV
`define GUARD_SVT_DATA_STREAM_SV 

/** @cond PRIVATE */

// =============================================================================
/**
  * This class defines a generic Data Stream representation, for easily managing
  * the access to the transactions flowing through this data stream. The class
  * provides for basic 'passive' and 'active' dataflow, with basic accessor
  * methods for both of these flows.
  */
class svt_data_stream#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Next active transaction recognized in the data stream. */ 
  protected T active_xact = null;

  /** Next passive transaction recognized in the data stream. */ 
  protected T passive_xact = null;

  //----------------------------------------------------------------------------
  // local Data Properties
  //----------------------------------------------------------------------------
   
  /** Semaphore to control simultaneous set_active_xact calls.  */ 
  local semaphore active_xact_semaphore;

  /** Semaphore to control simultaneous set_passive_xact calls.  */ 
  local semaphore passive_xact_semaphore;

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new data stream instance.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' active
   * transaction.
   *
   * @param xact Active transaction delivered upon arrival.
   */
  extern task get_active_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the active transaction.
   *
   * @param xact New active transaction to be associated with the stream.
   */
  extern task set_active_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the active sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_active_xact();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' passive
   * transaction.
   *
   * @param xact Passive transaction delivered upon arrival.
   */
  extern task get_passive_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the passive transaction.
   *
   * @param xact New passive transaction to be associated with the stream.
   */
  extern task set_passive_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the passive sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_passive_xact();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
7=2):fRcT,ZU6>5(bS>XJI,T0Hg^5X7N@D)7Y_CJea(^XFWbeQ<;1(W,KdBAYTcD
\BXMg6(E&\dS44^CfHCGc6I]L>/3KBb4U)LOZS\gFM@;1=dec#&EHU)+E/J:M&).
#_cZSM2;5#:=^QSM6C>CeJAV;<fDA/Kb@HQJ8W0b8a&-]+S&W[CJI\U1X1PCAPDZ
]eD)4RZ978g;g#ER]&F8O>J<(=>H@^4WE:f95#\.?Y]U\J=-cLc3+-X,J^,aXJ/[
XT#^Xc:.b.MU=8)cVfe.8RR(VUF5B1<8?E+G&H)N(c0S+2R^FM+Ya.a]7.\7@UXQ
c4TB)T/&?MJ0\8K^9M-0]2f[P7JEd2Rcc2R)+NE=:>L(R6DAP8#HPd5J7D]^.@+>
>)D)HaGb9?6D=,--(PR1)EYIeSP;-CVQ5^1KNI:<QH7,VRM:INKY3XE&QbCKb;:6
;:KTNW\B8H(&\8=41/#&4G9VK^7b3Ag.6)5]FI;B]CeH+(_^L4DU?;?E4-@0S]?M
cXG9>@T9O2A.Jff04KaO-MJJ([Nd^/Q?Y+A24^/(+Z3ND#G-)c1-)?:;MSAU32/S
BQ@9D]Qbb@?bb27Y#(a:C\/+/O?UOT)JQ173#c9eM;b\;X#CcU8[M]X-GQbNR([?
=U-BO:DbS+XJD=H)5CZ.:4;SG^9:IcADe,L\>7H+7M-O4G:eCX93dL0ZQ;GI(086
7?e7OJ>DPW\L,V-PY[:ZJV<+Y4]ge:VKc1a9QE>;/G^bN0;g=<_I.\\]WSP0.3^@
#fEZ1#S6IeY.WUXIZfP7SJ;3N1&N-G,3I.,]H52>E\ZATB?W>2fE&b3d]B.PMCL?
>XJ29,Z0S/F5;^c#^>(cHAWdfcF5ZR.G^,Q>f)8Ja6S(Q4T\W\D)(b8<0#_E304+
6Z9-EXO\a.[Lde\&[]&BL;1^O0I^M(J5FXc0Y9@D/Ve6FXLJ)J6BeSAdX/KfEN_4
H<BK\C>Le\c&>&HZV\MO8&f-SN=daX&f(0B>cTE[b5YG/a2#.LJS5A;(G1M3bM.Z
G(.cKF[X,V1I>Z]2JZgG?010SDF5;Xf[,B&80(0=beb+^8\5,&W;A-&ZfaBQW+ML
\7NZR^+Q88P5b9VS[f4daT7Y@[KHGDcVD809F.7=Tee?4Q5KWB^VWdf_9.KQFd1)
b.KgHdb(FT4.XE+O/YI76S&@I5LNJY4A\2882B>NK-I+eYH=,FIQS1&cHVfF-/SO
bYa3.3BY>@XOQ<d&7QW0,_CRLMLea33@DKaF2U:LH)f7(+TM(P6A3X;[E>]]D^=B
^(NXfNbI#Z<)=>T?-WZVK:N#:AK0.WJ^7C-O>/cdPf0c)6HWc53d4<&])@)2MN#A
f5/),_-9;g?RS?>a9?cVb5W\F\X>O]Pa0e:dCPO^4AO1\ALE.5VfGIgZ#Ba2VgK7
]3R>9b]b(Z;6U:Z]20B<(8-\FC,:CBJ,]3J>AgHX)X<IV_GYXLD^<:PRD&f07/fa
0F.RBHC08f(U[VBQc8[YIWJA4U>>BNY<4@H&2PcYWXB&N_U6XAGY28g5SN(I:[-O
5_.NS[HO=L[RW7<L=@)WSH=JL].?W3_<F1SI_2T:C@0[V412W2aV>dQJ4&8[aF)O
A(TO#4W:2A_C;gff0+eVL0f+BK6[WO:/Y15JZSB,_]IX3Vf[BE]QK.>ORW832@5E
\-LFCF.A_@S;WWCP_@G[JV;>+aFJaD65KN+0E14GF+Nd/4N37;;:UX:Fe/Za3Z<@
3g7<cgNW_6P@/KJ]f/a+:+JJ8B9&5-\<3I:+d8#\&KTB21GRCaL)WSd[93e]cYMC
f5-\[E=aQNSG.ZZ5N\0V1C-.DELdCE6fYfCK9+#0R+E??O2cW8ZZTFAE^b71NA]7
_A)aJB7^WXLB-KSA/5Z#[ff9-[:cH/F-T=O#DID0B.56^B0\T:GF?41MgP+]=W=?
,aQ4_O@FFcPCBL&gL;];2H^,SE=>(G]E;a14JMXA.1#]VU^4DVBR?+@,<e^AKbFA
?MS(e.9X^HM;8RROK&cCQZUB\P-TAAc#fJ(g1)1HV^>cS6SMdYAS>XEdL#RHB-VX
]QNZT6B#3QB(YCJ\eC@12><a]OIUDT62gR=0UA)9&U3QH=UeCT?Z3K_#LKQ\KAId
7BT+026UK:cDA<H1\Z/[I6RJ;:^;)fTc\<W31T5:07NY)(/-BOULVX0Ia-F0&,W>
?K:/]ceMN/.Ve8D]AQZSB?g2LQ1LA56+f4/IWGX0GAG4(a&d82KgN-N(U_egZdV>
Q>6CE1Bd</F97I[/T848H:?9-X-EGG4X>/RYC0RUQcVf?f\W+Tb-:NfMFHLbS:5,
.GY@Y[/cM)?7=5cTGZS=68H[ECd4)5CW_>E#.KQ[8?,=1U4)U1?]27TFg)=RH6ZV
Je<L,0R/QE;9M24WT@9_V^H[7$
`endprotected


// =============================================================================
/** @endcond */

`endif // GUARD_SVT_DATA_STREAM_SV
