//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_ADDRESS_MAPPER_SV
`define GUARD_SVT_MEM_ADDRESS_MAPPER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * This is a container class used by the System Memory Manager for storing source and
 * destination address range information and providing access to methods converting
 * between the two address ranges.
 */
class svt_mem_address_mapper;

  // ****************************************************************************
  // Type Definitions
  // ****************************************************************************

  /**
   * Size type definition which is large enough to facilitate calculations involving
   * maximum sized memory ranges.
   */
  typedef bit [`SVT_MEM_MAX_ADDR_WIDTH:0] size_t;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log instance Used to report messages. */
  vmm_log log;
`else
  /** Reporter instance Used to report messages. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** Name given to the mapper. Used to identify the mapper in any reported messages. */
  protected string name = "";

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Low address in the source address range. */
  local svt_mem_addr_t src_addr_lo = 0;

  /** High address in the source address range. */
  local svt_mem_addr_t src_addr_hi = 0;

  /** Low address in the destination address range. */
  local svt_mem_addr_t dest_addr_lo = 0;

  /** High address in the destination address range. */
  local svt_mem_addr_t dest_addr_hi = 0;

  /** The size of the ranges defined in terms of addressable locations within the range. */
  local size_t size = 0;

  /** Delta between the source and destination address ranges, used to convert between the two. */
  local svt_mem_addr_t src_dest_delta = 0;

  /**
   * Bit indicating whether the address range defined for this mapper can overlap the address
   * range defined for other mappers. Defaults to '0' to indicate no overlaps allowed.
   */
  local bit allow_addr_range_overlap = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_mem_address_mapper class. Uses 'src_addr_lo',
   * 'dest_addr_lo', and  'size' (i.e., number of addressable locations) to calculate the
   * src_addr_hi (=src_addr_lo + size - 1) and dest_addr_hi (=dest_addr_lo + size - 1) values.
   *
   * @param src_addr_lo Low address in the source address range.
   *
   * @param dest_addr_lo Low address in the destination address range.
   *
   * @param size The size of the ranges defined in terms of addressable locations within the range.
   * Used in combination with the src_addr_lo and dest_addr_lo arguments to identify the src_addr_hi
   * and dest_addr_hi values.  The mimimum value accepted is 1, and the maximum value accepted must
   * not result in src_addr_hi or dest_addr_hi to be larger than the maximum addressable location.
   *
   * @param log||reporter Used to report messages.
   *
   * @param name (optional) Used to identify the mapper in any reported messages.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, vmm_log log, string name = "");
`else
  extern function new(
    svt_mem_addr_t src_addr_lo, svt_mem_addr_t dest_addr_lo,
    size_t size, `SVT_XVM(report_object) reporter, string name = "");
`endif

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Generates short description of the address mapping represented by this object.
   *
   * @return The generated description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a source address into a destination address.
   *
   * @param src_addr The original source address to be converted.
   *
   * @return The destination address based on conversion of the source address.
   */
  extern virtual function svt_mem_addr_t get_dest_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to convert a destination address into a source address.
   *
   * @param dest_addr The original destination address to be converted.
   *
   * @return The source address based on conversion of the destination address.
   */
  extern virtual function svt_mem_addr_t get_src_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'src_addr' is included in the source address range
   * covered by this address map.
   *
   * @param src_addr The source address for inclusion in the source address range.
   *
   * @return Indicates if the src_addr is within the source address range (1) or not (0).
   */
  extern virtual function bit contains_src_addr(svt_mem_addr_t src_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check whether 'dest_addr' is included in the destination address range
   * covered by this address map.
   *
   * @param dest_addr The destination address for inclusion in the destination address range.
   *
   * @return Indicates if the dest_addr is within the destination address range (1) or not (0).
   */
  extern virtual function bit contains_dest_addr(svt_mem_addr_t dest_addr);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided source address range and
   * the source address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param src_addr_lo The low end of the address range to be checked for a source range overlap.
   * @param src_addr_hi The high end of the address range to be checked for a source range overlap.
   * @param src_addr_overlap_lo The low end of the address overlap if one exists.
   * @param src_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_src_overlap(
                       svt_mem_addr_t src_addr_lo, svt_mem_addr_t src_addr_hi,
                       output svt_mem_addr_t src_addr_overlap_lo, output svt_mem_addr_t src_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Used to check to see if there is an overlap between the provided destination address range and
   * the destination address range defined for the svt_mem_address_mapper instance. Returns an
   * indication of the overlap while also providing the range of the overlap.
   *
   * @param dest_addr_lo The low end of the address range to be checked for a destination range overlap.
   * @param dest_addr_hi The high end of the address range to be checked for a destination range overlap.
   * @param dest_addr_overlap_lo The low end of the address overlap if one exists.
   * @param dest_addr_overlap_hi The high end of the address overlap if one exists.
   *
   * @return Indicates if there is an overlap (1) or not (0).
   */
  extern virtual function bit get_dest_overlap(
                       svt_mem_addr_t dest_addr_lo, svt_mem_addr_t dest_addr_hi,
                       output svt_mem_addr_t dest_addr_overlap_lo, output svt_mem_addr_t dest_addr_overlap_hi);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the source address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the source address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_src_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the low address in the destination address range.
   *
   * @return Low address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_lo();

  // ---------------------------------------------------------------------------
  /**
   * Utility function for getting the high address in the destination address range.
   *
   * @return High address value.
   */
  extern virtual function svt_mem_addr_t get_dest_addr_hi();

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name.
   *
   * @return Name assigned to this mapper.
   */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the mapper name.
   *
   * @param name New name to be assigned to this mapper
   */
  extern virtual function void set_name(string name);

  // ---------------------------------------------------------------------------
  /**
   * Used to get the mapper name in a form that can easily be added to a message.
   *
   * @return Name assigned to this mapper formatted for inclusion in a message.
   */
  extern virtual function string get_formatted_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Used to get the allow_addr_range_overlap value.
   *
   * @return Current setting of the allow_addr_range_overlap field.
   */
  extern virtual function bit get_allow_addr_range_overlap();

  // ---------------------------------------------------------------------------
  /**
   * Used to set the allow_addr_range_overlap value.
   *
   * @param allow_addr_range_overlap New setting for the allow_addr_range_overlap field.
   */
  extern virtual function void set_allow_addr_range_overlap(bit allow_addr_range_overlap);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
JL?4,2H9f]6J/MTaW(]>_<ZN>#@4(]gc.Lg44M10J;-:Z+JG)LA<1(R[11QPgFdA
d+SF+Z;7:V.&FJ36M,(>8gaBeNL4U\ISB50&)WgEW^gF75A+<<c,X#DH[cI(DH8=
>?JW45cYT_>Db]+7L^)/cSA[]dJ#YZK3D4,Ea;TN>JLWVIgAY<5;UUS=&:b4,#GC
cF6L9R/OEY8Z:AXPH^[cP(DBMK)50LQ:GKH>BE75cCTOgTWAaKdeS@+>.(S:.P9d
M5;TR2dXZPIICeIa2Da#JbJRFUA6()2PI(S3^8D7XN(+c7-_=CNeE(UTKdZI+(eR
ELRHM.Q\/Y5d@IR5Eb5AZ=\>a:Y4S&#b(-AG\Q#77I(X;CNUT.#I/JY;VM^M\NBW
,37?39fR&3E:@U49[@8Q[F:S9978U#6WH7DX()6D,f,Y3KU5^76W.HIbQ0c[9^X9
eO1X^M,:KGDAS>A)Y=P+,_S^W@7:1U-P?PQbXMSR)@GgUHI+aQ3K&TZ2>7:((QL.
O2HV&da^<1G]U\82\e#09X:^dcQS=GY6UK0#<KHX9^G03F4G4\KPEX5a?T47N]+=
@U+).c&\Y.M);^2X\&(51a3)SF/f,(:)/OEGB[2[4XP(f1bBe\Q8O?a^6X?=:R22
<7J3J@^4DD;:Hc(^;T/f]UB;Cd=(MQV+S[:\L-eR0GK;\\7BWS(:#@Z1/,;8&)GV
I391ILFf_&-J&aRfKSfI3P2ZKZCDSUZcdP]55V(L0Ve/>Vg47Vb2a?T_BGYP;GI=
76LTLg4+7FD:4b-LN-^.KIRHe8Uae#R03ATA6]d?G7GIH:+D_B-cg@P3^Ef_@cL]
Y],Y;KGdKe+P0.?_4MP:KdK)?g\?EJGT.g241F(Y=)aM3#=L)]U5U79U8TW,6/EC
PA_BM56.A.eLZB2N#+gE/NI4f^:8#/97:^Z+>HBJA_0c.0KVBZ8&#baP40)&c:X6
&<.F6P:;1GB;8e#?N-Bc3fSJ=WW:IOYCE^9.-LTEHEIJ79+LK[HDZV00EZ/AX-<U
?g<6H=:X3gce605L.,L@/[RZ&QW+P;9H?[?O.HKM(R90,#=CP\VQ=:fJ8H.4=eL[
FE(gGZNKE)db>dT]4ZeT@<d^a8WTca@04Nd^:Q=AfR#[FH>KgY#Af_^#;I[:U?1/
EJYeRUg==:EDFBW0U:R,HSCU+\Bg&W+f>I<<]B;I2[T+](AMHR-9/O#-_.A#VR#V
a3.@aATNeGFc2FDO\NOc3g=Od47cTQeaEOAV)#>fO<g)#LTQ9^]Gf83-_SS)JcOG
c05BV^+N\W1dNg[<-MHDAgPP6JX(C49-<ZSO#-+ORb#T,\L^?ZfHDb#\)g0>ff#C
B9,-I_1ZQ]Eb;J4G>e?D-ZFF_5NJ<\=fTHB-\\:H?,)6EOYV^d>:BUHD:49RY>(G
)RI(;fTD,E>.XWUL(S\37U[ZBC_6;1_efXOe?^Q2+=.57WJ25+e.4WXBG1cRGV1g
A>BLPK/&PPHeZLU9]UO3YT>C3)8N;]ZS_7<Bf\cUKWPV/T(04Y)HLcL#TT>Y@^D>
:Q-]6_]C-GNgagG1PX\[aH>S#Q/gB>eG)RW8eF@Q_A,G9(MR5H8FaFC=BHaOc?,>
SLV-WX;R37TB7I@WfdA8X,Z[I4XgN07dG\1.?f92=K/+<[d0<2c/(fZ5OBGN<:&5
0Zf&&E<.>GYBCOIeFZ/NNc-4ESAA\ZIXc#0;7Q32)]^(IXIK<ENBQ?N]H3P\DdgL
-U:Oc_-\;/N,,?QeY+f5Td@IH7G>ISB9,CPVN,^aPc?JJYKW2;:acDTST>aaeSR:
_;H8dD4NU7D17)C]/5;[WHJ9@GaVH;H#g-)].S2[RWTa4PZE(A.g;a?8fMLM-/-U
=)XS\4X;&)Y6J&LNWQ?^LCLbS24(>/0Y#O=B\EL7b=K@).FF0&]dDOL_G+RfS5#P
#F_]b4+^D>J#a2RUReN:fb::J.0,NE3dKL[SQO6\f>63#(3Mab[?d:QV?79,U13c
g+-&&4O/PDF8H\@EP:8E>B@T9:0]7+Ec,,5,J&?]MBJaH:[2C.CbDD/1EVGG&f4G
HLK3O+&b\[Df]GDaJ@,5&_,V^;OY7__52F0aQ_ZbLHU8;Fa0TDE,881</A_P<B46
7/F)baRUf8f-[O-)7M>I<(1fR-&[7<bQNC:dHWeb_dZHcfR+J)JY)(9E8CEC207(
1b^_YBcN->0b3]]2-d9<c\1/#8#HEQM?T/Y0-#O,D0O=@VX.:QYKQ#P?-Z/JF.@[
HV7D1/44;fETLUGHWaZ4eQD;#@PZVP.U5-?N7&G?HFbQ/B.\7+2PR1<LNHKdL3d)
RZYT?1Q#I]db+NbM3Ad\VQT\aGY&JT5=\7LSE<S[&=:K-2MM@&6Y+T+P3_QGdD-A
I(XN7M>a0^3dc@dZOJV.=<#KK7Q8aUA6@1XXD7ML/;d&/.X;];4#C^#U:EgYDO?4
>P7X#3ZgCBB43c/2JGV5#.CZRBJefLAbcNW]><H+MD&^aPQHYId0\48R#,(D_52G
+=YS=W0e?3=W:MV\G76\&31J9E<3Q3Z4##;6B6-5Ka02]N<CfU5U#EcOH0]5T0dC
5(gLWQH4GB+Jg\Y:(,PeJQ=:g79dNNNC-4.b[e>TcNJ<eRf9Hb4N6LZH=Q::b_2V
+OaJdf)4EEAT#e=;Eg3]1IR_,#WRS.)#[Z=F/f1(2&(#,8Y.R-=6/Ic-&EQ?b4@S
U92_15b\-I6;aLcQ2Y#]X3O^_6]\X\R3T3T(7S[E0#[dW4R,BeUPd<aW<Ya;J[^d
89N6O?^&?@XTLgOL==Ka81PfCcFDgdC9aJMcR>^-b]_[A\@8A8;)?EQA/7TW&867
CHddTFaGbC+7]fBb7I?G#-G0ECW:C9#8Aa-GUI.fZ3a,8gbDYNB0g[39^;P?e8CV
+XD2Hc@+VLAb8U[:HYdS&_EH?ZG?>0)J9eMc_6DPT1R?[7f\?]FC[PO,U:?O6Z3@
Wd+FF0_Z1AJ_1[C_ZJDfL,^ZP8\/Z8N=UeADc7<IVO5FGaE/L?12O@BSN4I[c51/
_cg_/eLDK6R)C>+/#8X73AN=+YH@&S+3;SPb;H-fa-d?9ZXN2<cUSN;1@368Ce_?
[Q3N=,->:G)4Xe#fRY>_8H+^fgbS.S_)f:(A&(JW;e)L2Q7&])/5=MeSD_4OfZS-
H9XV=]\1d,,.9:KNCO=0U42J:KXH-PNFEMP,L^gcZFLW1fR?fXJKaS1W[UH-_PMU
gOKFc87?<F>/],g9=:e+=1;F&X@J=[_<(6H=QN<D-KK=ORJFZa()9^gS8[.NHdD5
a>_Vd.(F+f1YHQ<N#.ELVX2/PJ:#>QgLfZB_.2Zd:RH.(2[If.7B8X8MHA95VaIQ
_E3c@\?K=VVCfMeSU/c.^YUdH)Qg2JE+N@0K[&_+:3PD)<:ZZ,Kg-VOM[c,]>3Ua
eF84\cg@;gL\>YAWN4H?NW#PAP=0L_ge;^&K6KPZ0;c&8NK0PTKdUFE^BENW_353
Jacb9Q0,3W7_-RWe<;V99C1(g.8F(]45NLQc_8N180UKNXA#R<#J[+(\HP)aX)Re
b2?)K0)g.a]-BGFOZQNU1>++/5R5QVJ@.PAH:8eV>D,RfA<IdD-M81[;XG\K-:/b
Edg=C7I,07ES<bd;LSZf_(\U:[(OHfbM&B<3#E/5>[YCI7>B,PUHHPLDfP+4O58O
CHSY;\20LMCQ+cDfOQRSTL>2C8GgVXZ#d_@<[:^@[6cWc=&a&DVCQ#4SHP20AQRe
G)fbgYUP9@NYW?V7MY@_Y9Vgc3F95^J2VUHP@eX_;L#ZE>,aZ<+&P\CQTT[[B[?@
c@=b]\9[<.N/:?LQC-X:CHA-Y>QN&Rf2+Z\H/_T?91#MY0:UD)-b[>IL2H7)Fb(3
CMQ>cFM?8:T>3J-D0JV:CCF&D@=2O6B33b=CLS?45+c<ZJ=HRSRPTAYH:W;-:#IJ
d2C^JS:&E(_P_LAEc^Qa?IPH/P&I1K8e2^\+E:SKMRd8S;T6@5&KTcbHNcQ(Ff:g
E^XfYXfHTIc0S=c)U:I9Qe]=YB.Dg>c<_X(=._44E&F+f^,J9W1PbG<KIVRW912^
:.HaI\?U4K?XJ&@;MRMf<@THB>YETHR@>d+<.8N<BRBc2H@OZ5a\Q<6XI)I1e5b2
f@)Y;@ID2]QDTAPX<g\\RS/.UOg9XJX&+0WGV#)V]2O)RD9XR(B#I+>BZZO-dg<6
&>fU<8VA=N8@FcH5,AZ,a@g5KK-DV\20J@0SPSDA)M9)9N._c&@\d@LeE-f/Ef#Y
A<&a[NTIQRQ66C1bM-fC;eWDRF\H6(<eM#\<UST@E>W=IMRAbe@[b@^K8Ge,cYJI
H7P3S4:9(DeA9V4d(LDP?\LPD5A9_4TX+WcR:KC0NF=d3Jg&>1VHVS)39&N(>.9:
f;W@)22BW7_(89956XQOAFd3b:RG606e(;I5C7IXHcgVFN[:cR]L6&H.&\7G#&U(
M)Lg;:I>F.A=RJ1/-<-OY,SGI-,;47\A&PI-f/+1KP1DPH[&]Ld2F]V3OB?MJA;S
Z(KGW)HD_FFUUC6O]A<I.C4]SO3KOIM3Q\CeR@[OFf-J2aIH3?IIH,)NaaY.V::L
T._5R;,dH3V\#dQ4IPQ.#^&/.M(;Vc97Y_TE-K8857,G^D.FY::9+&gF:=HR/0ZI
4ZXg_T8)LV/;+PM/]S1M8aVGa8&DCIFTBRd(U\(5cG/5S12YK&eLW@>-a&c46L69
D)RNL2B/7:E0/fK2dD7F5,aYe,e06&^=AY>bD:0YDD8c[eMS-^#R#He:cQ3U=_.8
:bT[3>[1K5.?I2SF]>&GM5O>#gYL>GeHR;>9YMN^-.HZ)fa=)\e#]_I+W\Y7>3e@
L6GgA]eN47CcQHHbPM9CCXXaMJ;a1I3\F.<[8egeb7G)-7FZQGbI(J0#5[4dAPRY
CP]Ve:;)TBB@X<)E#Afa4]\MXF<]0Me^56^IVe2c2b(HU(Z>#NDbHIf<X4g9.G@B
acZMgL,QHP+E3H:/)4f?D#D9GFMAO#Q;c_a:=?;dZKbAgQ6XBc[E<]I<D_[9PbLL
R5TF6eC=>=cW#?a\\;B.&TD#N5YB3C/9V)2QVDa&UKU#I;a&9)UO41KG?Ff4;ed.
Z:>Ja;BGcCK72E(c9QS+^FHO8ZdcI1#R=J@Q)FUS)g\-QX6<0d+,A3G51AXYMaX4
YcJJI->-X:SO)(_8:7g[T;3:g[Taf_&Xb>Q8SXJ1(Mcbe;5gSWTD\80f2@Ld;Z?>
&^a35.cRX+<Pa5]Pe>M51I36?/;<.+M4FKQ?FHF+(DPSY0[7H+f<aWSac:?a7^?b
g&CAcLVdf?f#(81E12]b&H=O<(MXA6Oe_^&_6aCgX@MP<QS6/O?HBG+@GXW=PIaB
2T5<.H\;TgHLV9KD3DR1C@SF3K^Y>c@EK^RdDPY=EE.TI^U7[T=^1E7KSL2beUeP
<E_?e=50DJ3aKI.VU+ga&<VI->J;(_,M5]D:#L,<C1T@6(2C;,Y6[4:DU+?WNMKI
AYCbSWM+.>gBNL./ZVHO_DYg,#\VZJ71&/VJZ&gHDYBd:O-OJ1KD9/?Vfe8D2CA/
8])V<S/0XWU3]XX#eKILVI-Yee66G&&=_A?;g_G4Y.?eMB:cVc:&>A\STM3cP<>@
3LXN[?1_@,Ea/MJdfG8(DRHHUM/Y3C#BQEd(PG@.Q^P\I3/H<1JA)_TGA:cDKII#
g=EJ^YA0NDNg#83MAUL@\J\4(YO6XD,9YBb&A62WC0]gN7PIT9:HB[3=X@78Y,23
UbLafO--:=>6bc.]=DbJgS6(BSG,7?@X/?P9&K2\WXQB6J;.VNFF+<C.>[X]SCSY
3e3)f\U6d3RKZFJTJMOO4-EeHe92bE6:7g5KeK],&g+7d\fG]I#Y6_IQ#LK=>7PU
-4&O71Tbbc@e7WaC<=Q>;f8GU?DA:^PR\6Y[b,_KKE1[;#_>F,;NeScaQ)R:EAea
288_Aa>\_=47Q<(AGT=7_.(9fTW9(I1>Y&LIBYQ7.P/BXg;a:H7b=FSLA9]Ic3d&
ARMaB98e\C+>190-0G3X2ARAg[0=5<gULe-8?afF,ZJ^&PDJA=E7EU\TNa]gc5#\
bW0VD53+V],T5L/db2F75TI];1HHaH3)()N@4TIS>I(dKTDY^2N/[AH/A,bK+1^B
Z_fA5=A37.4d)c>;cZBegY;UU64>V/8]<ccX2E_-5Q?Z.d^E)1(eGSE<9W</4QRB
@g.IHU6P):]+8;bTE+3e^=bf7>:fdKDS=SZ643N((3fQ\RG0O60FK(bCU0Wc-<8Y
gBOf5;c>/-V-J.^5#_g)VW8T<dVOX(T(2c06I^.EGY]E;NZ/0R\0HVL5;]>-=F=+
SKCIe&:><1K:JMZN,7e<9F9g&9>XU:WS<H^>Q019EPJ/9d:_:SP3cgY+C(GM0+C@
N<Yg,N[/BB=C_M0&S73G3G2]B<2HMX_,A.4W[-:/VN6+X>4@V,9LgOC30D,J8I(E
8^^G^gCKG..NQ)3DX^Z24TZG9W8SZaB:#E+^Y.-g=bCFeTc97K9ITN)@WaNaABS;
1UHc8g_5OG[L8^GIVM61;PcK]CaX[[)I7;H]>U.@VLB1VA1BM,>Z88Eg0HVDgS@(
)P,#)IMGHG,7UBCONdMDaT6EP81-eV\a^RWHgPMCC02b,L>A]:8S896I#6CU:NUG
d_I+_N31?NJE2-Da[ZA[dTMcf&BGKgA=7N/0]2V^bYC(KQ)gabNI+UB<V;=2-#L_
VBK;R)d/<c:&]M95ZT+6A(0K:MW3ORXJE(K\D#8^a#:&1K(N@),DAB\8^HXD4I.B
VI;+e8;P.Z\</ZQ\4H6C6V2\g6X;4,SZ8H<MF5e?SJ?Od<Z5>_8K#LbMHFRJY\7S
8X2XCCLQg4F1LX+4#+3Mb+4b-29M]-+II2SV-[QYG3aH2))(Z/a^acT?O60X4:6T
g;0@O<-,@U-1(,eR/O(DEB.5A5N/0H0L708efC__fQc#:DX\ZObbZ3@C,]_DTOVG
a]E>OD?_O&)fZ[LY_^=8f0:844c+KJKQ4ES20;\X+/:PKE,GY):T(:L768.ebEEg
,FSU]a\5N_X=Ra+S]G:Y]La^;ENQ<5BW#9?9Fd/YEaA#Ie2A:&1S0/Oc7Hb65.4B
B7^e4T#MZ)6<SIeH-[Re:C:FYT^&dU\^WO\Z0=9\dYI<bEF9^f.0YdWE_3B>D=C0
fM30bd9:Fa45cReQR2H_K_,8>A0]6?M?GCIT5MKDJ#aPGU+8&HZ8YaZJKT,W;LW5
JEI8OE?9[aN6Q.M>W.XOG9+I=#\S[L4eJGC[12]0@+P[LF4AC?cbCJ^@bR=QSHa)
f)K;<dC+V8685#@I;IJf#/eQJ4f.c3Q1_BA8gd,aS<d=-B;eQ;6-/>ZfaMaSXCH[
XW6P8)(N5UB@7.+fbY+1b08bJ&+2Yb6dK1XTI]X1HCe<JUeLE156^/DGS^+Hg+_]
aMILRe@#dBFB_,6O8<=TIO&A-b#58LgF(aZffLWd^<=4eK;K..9FBY,,,(1Q9],:
7;@+7g\PVb;f57ZV/C@9\DFg66+>7G:db7^5TRa)B0C]CT.YL&gK(..]LEc;,(aA
g\S.aU+:B(6U=@R9VTY+=DbX,9g-E;15QJ^BHV5a5.LS=5SHY.)IZ_QDPO.L\d:7
;L\O/0Q+(Hd;KDO;9Y-28TD@BB_-JUAe5/OJ7MWQ4W#&P7>N=YAY+YC=7#H@WI4A
[+?5M+70c16;V4K9KZPK(?#9<dc^Hd)6aT/[&SEGQ><c1<KVJG5#QM4eP\@+>GE@
,8L;,c^+8J7<W0)#U]N2SDG.&BZUQ&2AUCIHH)LU5R5?c7LDU62P)A?SKPNKSLUE
?4<TcP)Q@-T_g#5O<-/1YfdRNK;C1,NdRdWCBH2N2_b._3F,LXX]S+;CX>1_Q0FS
]\cEH[5QeTNP>T-AJ0T?Bd7<4Y@>cZCMCYK21E8M/AXA_b?-GS<7AcDV3?BTAQ]Q
d7YSXVgR:SR^[c0b0S./0;<fB=VfNE)JRd61AEL758d^;b1V@6@8@0;(YN[J^f6b
)HMZS18,0[5[6cC00EERP(bbEe3OQ+?e?KRX=]C_)4ZPDbf8IdJPScK?\]N/ObeG
8HMW#Ec9dE[C-g+SXfCM\]#M9&L+4(?>_0Md370_LV@IA>=)fM4F2>3f+&_aE?OG
_O02CBM3e(2;:@@CA]5g;ZVa]Sd9.4<2f<bJJ+VA?A_eF_].c(b/_[Uc](Vd7OWf
KbRHbUZ++;bM5.LB^BBWb.G1SGUZIODg64)8XZ2R;>=B16_]>XL3>>bMg]ORc+.3
_;V3OLUP(g(R>,UJU;^eCOKf)GEa.C;Q0f1K2\1RBG164E1P#Y#e2/ZX@V::)^8e
&Oe-_(#O]-&QG>:7WCbHR:_RV7]RdC-d,bLIHb5P#HQ5?0^#RN\JbWdI5d)-L.@2
bSI#dHU<Z7>gKPV,cED@VVC5]a)A<180EVW1<+FS+[D(gN5fNaYJOUfFR;2.UgI2
^3TX-:U]]_a=beHD,GR9(=c)#22^^2bD181d,TQE1&WD=,(d)LRB6b8I\59GY@.Y
c,)UNO?Y)1YN+/a-TYOD&8L<BX)6>PXS6g2CcK0MG_eV+U^b54.>5&@LX=FMT+[W
GIIL+8P[a[dW(BIL1.f,/eJ-&E^5-(:<V?T@@AO:N8)3P5^4AU]PJVT1X@>3^)^K
XCJN-;)I_Y#00F_ML4Z6>B(QV_NB3+^.;]U/^VJX5I=QDHZ03d=c#?HXO&@4eWM,
LOG:A+]OW)4b9U+9cSGRQ,OCH02.&.Qef3M[_5<K&(=HWN.<bVW]6L5AXC0a3S?)
1g]-dKd3/aNK,\7//\2JFZ[^ac7?PY[BZeNQbMT2+9gQ3.ZRDTd9b7gHU][c@.K9
>gZ?]<\1dd9]IecfLB;I8^[U-OYO2NQVI&Q_I7EdTLB@5Z.9G?>#+9TaR-/[_WB?
[5WeL8=-;73UG<dIX23[[.3ER:4IB\#fNWVIFI<->DJ&b#UZQ[?3Z3,/Aa2\JQ-b
F@5-1?<8Sc=GOSbQ?G4/R/YOILLB60S;(YRJ[3O&bb#.Q]OCKBZbP7(S0^+)_XL@
#4(I?FKAP6cKd([XdW84])1LZ,g<;:;TFW41d/HA=R^;;UY\#eCac8O(/5;d:)fV
PFI?CQSEUT2K@W/]LG<fH2R35W__12<fC4G#eNTc#29F?2;R7=3Xa3cL(HCP7)-f
5X4[a8QSHa^WI#988/U8FEG@cU@d<HZ-?J./2(,e2c=RO3Y29&+Kb;]bRSS;M7\,
,Q5/ae7UaR9aYaXF8Z(\bM1LRKC,e=2VY_BY<UeXSV4:1N1KQ1];b,@7_JN:7::E
8(HEX5fV&6]KVO/0\d\X8HE9fa6>2M<9Ed-@1&R[VY.Y]]VGBg\XQQL:b9<+Z_DC
,1N#?]dL4;(1V?)9L\W22;XdIJY4YY8^+L9PLaEgg\F6CI0LaY5/P-XOdU3E8_,F
afB:GC<ge>;B[Yd>I63&]7K]<7F&0fQ=4L,]].WE_S5(9f[gKHUJXX)81@-O4@K6
CUR,S(-=dESJg]c7J)U;@0B6WAF5V.?ADC6gT+N->0?]0<Yg_0#>JT3LNN4ESJc-
;D2Z[<CDP2@]1IeT.FK0,5ag-;0MUeWR\XKVB^IK9_YJcUNXKMIVEJ:e<eHAV_:S
<&2)5MI(I=0DEF<&c+C4IFaVV<;W,a0=9RD7RN^O_aSF[K-<&T5S?MGTBRJLg0JO
eMf2Of?b8Q9(<O(8P5C]1(OFA8,=-HbVBHU3/IC=?IP>=HI>HUIC=N3Med^8?035
W]VEa+-QDST,gN<-6V6eCHYZge7;=Bc9?7A4g3&J&f(F6(XLQCdb26&GUR>,b/^4
6D>Tc1.2\1K3<0KN;^d/(96;<Ude##]]gH4T^Ob;Z-P;DQFaW2+AIfb+;[.#-aN&
a.-P]Wg_M@)BeaVCH>#408#<4E>c8D,LF(+^RdO]&:2=0RFI0TSO7>AH9=F6Y9&+
_,5:&OJKe3.@U-D;#+3D+a&U)2#4QXHZI\@_G,RX4A>^(/TEJ1,W?)e)d]ce<KJR
f5IQ@>7(:26Ie>?b+4beZ=DH9)gT\eV9374bXgY5CP[H\&WYZUK>>PKU^9ML1gbZ
@PBQF9;2Fe5LWTcM6U/D4M>8+DD6[4^UZ)EfWU79Cd_+VL5D10/5<<97T\F=0\4Z
U4G<[A<RH1YKMgRGBI#IRBcYbCMN=)aK>N6/#WcV@B]E(F#XO;J(bY[R-ZKU-Scd
;d)]C/1\#I8JJV\f_^_bETCB#.Z++^WM^#\Z8]<g3IYcZ.G<XR(]_-T0_7,KSZUQ
S=I?,K,OdD5K^=;TfTf,cTd&6#LAYA=F^c=3N+5G;,UA?82>>6]JJ<;CW.2POKD:
AV)\IW6/VFc0P]M[773:[bV.Z;_HO/3_ecf5T9&P.OAY=N[eHT=W7+[G:4[XT],)
?dWJ_+WIHP.3=#U:];KYc5aR.NY5Q\1[T(gaLJ,T(If86ff<;/IIT/1HKg<Z^JM;
.GB[6_M]XYND8,30fW>F3A&]M,a/AF(da&4ENLK#AJ?9GYQ2S9/(YNSf(?I3g.Q1
#NJ9B+2Cda[D/$
`endprotected


`endif // GUARD_SVT_MEM_ADDRESS_MAPPER_SV
