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

`ifndef GUARD_SVT_MEM_TRANSACTION_SV
`define GUARD_SVT_MEM_TRANSACTION_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(O-2018.09,svt_mem_sa_defs)

// =============================================================================
/**
 * This memory access transaction class is used as the request and response type
 * between a memory driver and a memory sequencer.
 */
class svt_mem_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /**
   * Indicates if the memory transaction is a READ or WRITE operation.
   * When set, indicates a READ operation.
   */
  rand bit is_read;

  /**
   * The base address of the memory burst operation,
   * using byte-level granularity.
   * How that base address is interpreted for the remainder of the data burst
   * depends on the component or transactor fulfilling the transaction.
   */
  rand svt_mem_addr_t addr;
 
  /**
   * Burst of data to be written or that has been read.
   * The length of the array specifies the length of the burst.
   * The bits that are valid in each array element is indicated
   * by the corresponding element in the 'valid' array
   */
  rand svt_mem_data_t data[];

  /**
   * Indicates which bits in corresponding 'data' array element are valid.
   * The size of this array must be either 0 or equal to the size of the 'data' array.
   * A size of 0 implies all data bits are valid. Defaults to size == 0.
   */
  rand svt_mem_data_t valid[];

  /**
   * Values representing the base physical address for the transaction.  These values
   * must be assigned in order to enable recording of the physical address.
   *
   * Actual production of physical addresses for communication with the memory
   * are done through the get_phys_addr() method.
   */
  int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
   
  constraint mem_transaction_valid_ranges {
    data.size() == valid.size();
  }
   
  constraint reasonable_data_size {
    data.size() <= `SVT_MEM_MAX_DATA_SIZE;
    data.size() > 0;
  }
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_mem_transaction", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_mem_transaction)
  `svt_data_member_end(svt_mem_transaction)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_mem_transaction.
   */
  extern virtual function vmm_data do_allocate();

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. If protocol
   * defines physical representation for transaction then -1 does RELEVANT
   * compare. If not, -1 does COMPLETE (i.e., all fields checked) compare.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.

   * The basic comparison function is implemented as follows:
   * For a given bit position, 
   *     If both sides have the corresponding valid bit set, the corresponding data bits are compared
   *     If both sides exist and only one side has valid bit set, it is considered a mismatch
   *     If both sides exist and no side has the valid bit set, it is considered a match
   *     If only one side exists, and if the valid bit is set, it is considered a mismatch
   *     If only one side exists, and if the valid bit is not set, it is considered a match
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * If protocol defines physical representation for transaction then -1 does RELEVANT
   * is_valid. If not, -1 does COMPLETE (i.e., all fields checked) is_valid.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE is_valid.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_pack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_pack.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_unpack. If not, -1 kind results in an error. `SVT_DATA_TYPE::COMPLETE
   * always results in COMPLETE byte_unpack.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Method used to obtain the physical address for a specific beat within a burst.
   *
   * @param burst_ix Desired beat within the burst.
   *
   * @return The physical address for the indicated burst_ix.
   */
  extern virtual function void get_phys_addr(int burst_ix, ref int unsigned phys_addr [`SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX]);

  // ---------------------------------------------------------------------------
endclass:svt_mem_transaction


`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_mem_transaction)
`vmm_atomic_gen(svt_mem_transaction, "VMM (Atomic) Generator for svt_mem_transaction data objects")
`vmm_scenario_gen(svt_mem_transaction, "VMM (Scenario) Generator for svt_mem_transaction data objects")
`endif

//svt_vcs_lic_vip_protect
`protected
ff(@@&XK+e(W9e1A[,FR)dI821KE.V;E+\J&HMI^]./Ib7(:_QR#7(QXB?V6^)QV
#[9+6;7<<XEM>B,ED,VQcVVa09Q/JR^:&[XV?(f3>X#(&YP_U12P>J26VSb,1PdT
72;V+L;Q)J:_beSaH,_MDAae-(f@QX5>_>+D3C1,.#)O0eNYW8(ORb\^cg<7)d_;
3E_9D:A3,74>AI]O43dA@,Y&EB>@#=3-bdGd#@MDc7dZ2KDc]D_M,K3=0F6A?d(f
9e5<1gKeK(;/YM3?dF;W]TK[:=b);YNObIF?RO:=CV_,UFW1GZRG8b,c4@g&ZOS5
bO^A4>XT3?Y8E>O;<gZ:cUHg,DLU2IDabH3=F=9E;-#2A_>P_9Yb9f>@CRHZ9I>W
3>8[,.Y8A<KfeU>QK8bc<@(32/(TAM&;9HJBdGM,CDJHV421b36<89I.:^>9d=1B
c:0,J<8?/(H9_+4aE2GJHE6bTdL)LVba1O]+Qc6X4+<-#@[R4=O,9gG^&+0_H1C:
.Y7f_.gY)<L_<+V4AMeAMX@-c:F(KN7bKf27]f9.:Fg7Mb=4\QS3]F0^SaRX\B#^
T30b:#]KP8+ILeG/HIgOLWgU#C&>FGGgOL(,GBa)^#.=W([+RIN@I3(^=a(E#SNV
LW[CBNWR[OK3\X3cU(bc6>F5(?aPH;YY9R8dZ0JB1<1;/Y^#K^)3GLDD-J]T[6=\
aN=QZ6H]]N+dIWcd2fJX5Q/]8QB98^JR9<ISV#Y/7LV+P-f;A&?B.T1\3V\]c7RL
.\_bA1&C;f.,#U)fK44bPR+Z0e-7[R^aSXU3]U]7Wa.H7:>F^4K);\Y=0eVVcDK\
M#Z89=eJR=7AG7:W/>2<3S_51M.0H5cTF<C[WWXe0MfA@L1DOf-d2d-E&SU9RP([
bS;N5cT5G9[,UNFXV3IRNU&CJ#H0M#6DN9-Q[MA./8U&<2fJY6<[D+V9YB]:,b9C
aK_?dc51C8X[LZTR?A;G6M()R\dIfOY^9$
`endprotected


//vcs_vip_protect
`protected
dgP?YDW/Y&W./4#M9&fRR>]G41+5eX&]@HAK<UB4WCW0M77.1b5A/(UN(bVLMK,@
)=a;Jf/2W:WZ+6gTgRY+7RWUB.:O9e64#-;&gJ2gCC>2Cg838g03f.-N01.1UMV#
WP:Q2XSB7_OBFNHWU#B30De/]fXDeLc&1&TG,TRE1c([g5U)1&K_43=LW647<0&I
WS=a\8LAEAP#4@A[_=T-3:1-7,O+Q[&ZWHFTR>HI0G99)ZX[704]A4&-LOFC@LOU
8N2ONGHS;2(/IULD@9+19^P+(Eed?-GO?8b]HHNFII]OJ^W0N+>,W]FOa>b0<_ab
BW3;IJ[II)I7(E3P=YR(_3WPc^E#f&MQ8GKBXTMf>_N[ZRLQ0O(EN]GRSV#RdO:H
>AHD=;E9KMb[=Xa-M?;,a_3KYWP7K:VEBL=0e(U;5XL4C2P<ZMWHBQ9F6);;A@1&
U(>7T&:JUQC8.P0_B26>]+@A&c^@&V.SdSYRXDWY#<L9\-5.1b&)\]PKE@O+JRHV
H<Xc,PUG#Z9^cYW;9GY(H]UY):B&&&SI]K9==<5<-Z?JA-2FT/4Y?<ddUc4HJ-(U
[;BAQ<0,]97]PURQ:&_^8)c-Id4_7T0W5e:,&AN0/a3()9NSEaQV]X44B-R?/d9V
J/55WC61>N<A>9H<YDYN;8Zb1:><J0<Q(PS@T-7bg\1:5Z9d/\4Q>5\?e[gd[6.1
LVE_<f1\EE_U^Ng[1RK=P_)=H^dEY_+bg:-##>TL02Pc_NU->g?,VP=d9HG1]F_E
g7/\.Me0-)a#ddf_K[f?<6aATY0[g@6/DGKRHU+4Od?=NeE&F#2K9/S>=7MSNEe[
]J_]eN3PWGJ>2G(/PB7R&cQ^6FCFIN5CS#N0QC=a9g>5W(Z>4_f-M?[VPHU=VeU0
]1UP-@e:7CE=OT\@D@?NTSCVN#;/e13[H2VEfR/3a<@I.HXG3E5f,K^aJ.DGeJXU
Ze=SV58H/[5Xa;GZUWEL&bVcWB,Bc8XP:3WA;f=BJTQVC&+60X#?G:.R[/;C<<.K
ENg4SFD.9:P-/dUFEB)(11]V+^QXS=\52+Z7LbPV:S]<3f#eN<C[b-g[8.<ff+-)
9T;;.[1HQSHGIa)b5d7WU_JCLV6+KK6T1D1FUO-)@#>2O>K0VCOPKd<>.?L^CFL4
(5_U(_3F[gD8\Qe@R_2b3?,URD7<eXB>4W&E6LD#5;ZF(5H?DQO)0/f5UPW#/3N,
=Z[U;4QF_(beBU:d:M_JR9OZb#dJ+_2]5F?M08b#G:P&L:O.RVA112-M\b(V?cCW
IM.W,aF&10DQ-,&H4LOS^N3AJ[fU(1S:]AE37dI6VLdL_QFfcCebLc;cAN&_>g<L
PMOHF=OX6a+,_>C.@Lb4F7Q32(8:V].-1>AE0^,&PP-Z7VRHNEB_bW8L/>bEGHeR
dK2#f./3,#IS@GTd5aQ@)5<^ZcHVgM/BZM8LU71A:OF+<NUX6ELg)06J@bgD\5#?
99PZK,a0F/=U&=ZB](2LK:2+3I,_0+&0:YYU7N?)SM29N20gT8=Z0@NLO:)@D40I
P_Q,>)1I9QW83A=@CLEE4fDGb,+1)3(]S=)ZS#eD1QO&5CZeYXRI+D@7GM89+KYf
fO+<YD(WYYCd0RRNL\+5D>_^eE2H0R,^OI@CCg<PIY7KPf2:7&</^L@2LLP:JBT;
8T]C7&A3N&<_ObHF0L?ZKC5M<CeAfU5<7MO66ce<XD=TFbWgRJ,Tg]F7KI;cb/M0
PYPIZ:d@]f/&1XSg6(RAK+CZC0^V7bC^ARM7NP87NNZ+^_7HB,M.0gKMbQ/1?KQL
a0(0fD><P?21UJTCMI9OF:bTUgYd4GAFD>RS-eOQBYeA>X(=ZPgUNe)d8EK9#Le\
YVdQ@12PB,-4Tb9Sg4I)#f49W+C,4Z:.).+:RV>@M\[bc5d.3W:P@X_9R@12a7#P
HTXQ_3;0OZc6_ee&-#F1:Z12LP,dSGaM@]TZ,XN6g6JIXGH2D(]cOD)^N6?A+6_.
0N:>cP#VL3]cSc21V+]J@WaFYB01&:gb&3KCEagSC;R=;3^?T(Z<54/<Fe-U?,A4
<0@dCJV[H/TcNTPIVbVd#HY(#?#+S.VJFf9b7gMd+(GL)4S\69CPaTGREU:d@065
&4A\Ma#gA:.aICD7?c&EB08aPP,dP/[FEfQ/=TELKY#ACN@?=N4?DK3BW,S?[TI?
&2T,&-+6JC3N>YXd:I(fHF)<b+.I=FU[X[,7E3<;QE64Q[<U>QO4QJebT_Y8],</
)5X&-DfPP3bSI9D/G+F1?GP?S6P@L@^,K7E3N;GU))a>\I()9=G<4Fg8gME^\9dU
2L/Sbe<cYN_H7Z]&=T-3N?d/Va8QRF)6Pa:Q-#9242UT76>,C.e(M.gFE.f9LNKK
U/#9FJMY[6&Z4&0\/0N,4#aUNCU4Y99^HYL>gGB6Bf[;:C-06<_/T&OCEFA97PdD
VeB):d]&MBZ1XL7OE>/e&J?bM(TD6FK/2RCATDgICMYPK@-D01Sa\PEI&2AB]g53
B<GS0]+/CBB.4MU>>_M9+/f1>I/W;@NgA,=V79:f[B6H<LD??4&d-#<8)HNR,)O7
MT@ILAg7RV?b&8E_1#AM,@X+@aG4W[&bEC/;JIK:O([I.?KIZ=gBG0(,)>YgN;;T
a:9b+ORQ75/+)<LBO1\UN:<AJBe@G/0=]<.8.[5T:c7^IVc@6a:B@=G=8[cG0QU5
.#FYD+A4LU</dHIR-gG@1+I(GM#Z84#1I+I>;728^b19:J&6Q]_B-2(]ffU.^<Ac
U[0C:D>e8#6#S65XR/(b.-K>4WWY45ZfR[9V/C9[SDS@@:[?I-GS_BCGPeAKNJXZ
P)?_P)KT.IT.0a>aI5Z>:HO.>DFB^PF^SS7OAP<UQ9N[DHDbGET\L3?gR6,>SY6K
?G(^<daV3QE58BB<YQSH.[CKcPZ-gQe1I1[\7@&=Ua\I^-Q+RdA7-HH(X^<Ked+:
Da&H7_H#P.B1U=+H2WRLT>V3(0JBBcD142HL+fBb:I&CMRJ<KVN?5DL.gdVTOc\L
C5FK^?T@):Q[3UVg0PNScWb(6(a8<J=R>7Ib<N3X=>E2(I]F?KPGJgZ9b+X8VUQC
3Y^-NHS.6-Wf\0W5];V^5E15.@#_Q=FIX9@#,HC3,^C#=;T?7@W/.2JY[CO;TH)>
.=9J;/>ec\92[cV#KbD-H_.#\/A/0N)_K?EDJ0@9]=\dUKagRC\/)Q\HP&SC;CE+
O0e.11KSg[7QDa/FF+=ee:R&M+31;/WQOe^(Lb0:8?H#0B2137c8<?08FYXMUW#)
:EIXKWTdYbeAgE(++VLK]8Ea)HNMaWEb.,WR=D.e;dQSa(cW<_#=TNIfZCEF.;QJ
S#@OK)YLE.4,M)=/H/#5T#d^WN(.M(N6ZW1^dC:bTG@/bcTg4<1de.c@7AMU.<RE
[^7&,[C,?7#Ud_28S-1fM=OT]O/U7?e]B:g1VT6P-[NEG6(fM7P9AP44F1OZ]KJ\
8=??-[+#7DcSd(VRMVQMR;N+OOL\8XOY#T>3KL].?G&]&;6,)),D.,,<bNE&90bP
/1Q,)72:M7)Y.[,CL@4+DC3ePMSKXX7ZFO3N,RSTGW=RacYA>NOV51I(N8aS8GTb
W9Ug5<2V?7WR\7PM5;8KHL4Y_<aF;FT]M+4TTME:fgM11AXc/@MZ1KbR^3]]OYD/
40K9I:<GW<F3J11LOPa1DR2>_-R72EV<>J3(X+D[?S12eBIKE),_DM\YR3Q#RFfJ
=R4H+d)NT8S;(ZW.<Be\Ob[4ffcHGR:U=PbfEBR+c9faTDc@e^@d;W,Fg(+BIXd1
aHLX6-K=DG:(90+_AQ6:_AA&O&J2\L9]M:Z212\.bcC52?S;?Ib<cO5,12/EQFUU
:c.J?5-VMf;TGVeI&ZIbTIOgHDUCdb19dZUSLO/W/I?U@4f6=?30&Me-(/.W3]HV
UV35VDSC(OP6YBTUHXPdPCJ^G3@O-0c.G:\@/[]3..M98fEGfa_A7\CEaB:87<IT
ddgPESQ04M9U@GVE.92/=PJ:T3FR;DBYYfIH(;3?d,=1],4-KO\^[DWZP.DD]1P_
VDdBM7@U&b2fO&,[8_Zd=DCJ<20EK/,gVVP+;;:9Zd^AbACD0O(;RMd,a\\DS_Gd
/a.T+(J3T0X2e9>-a]BfHAAWF:Ra^#eKV=&X[HB8e]e-2CDF)>FRc>[E._C&:GYK
RB5WHX9.SN>0G,+P)1<Qc6+CT2e=b:Id3)dAMNDD?M]ceZTG@0T5<6^8cFWR#,<1
OL(E<OX5-aWfK_V=,_gbFP93M\.VLZQ./_-[JaH((37bIc:Oe^20Z;f:=AF9=-Vb
TK3>b]PR88)^U204=HWEY6GRX<A<1H.5C^=JH>Fb5;;PJO]..[3Ce>(PTKbY3[ST
LX0P:P2C9KL8?RF:WS[@^FZ0]&fcRJa1BS\c6MM2U?3ge0Z-I]LcN5SI+.2/;I3#
<H?&-<g2@7-P(a;+I+L&+NG.MPf)Z75GY:c671>J97c:<BS6D<HKQdH:@8U2f#+X
YF7aY5I1Y[Tb/f-PR01N)g_6D56W<-]U;;=@#4GQD#2QX]1aHbBOISX]7SM8\#8e
-bQM3)O^MbO65J&7EXVMWK(#_R]:-WdPJa=4O]CeWN<U;b[Sa(W?ISLf4b?cG8G2
c^0adZGKMN;;\?U/#+P3J(]^2BaV1HI^C8KCKSCIVM8>VBFCaFB])_Ve#)Cb1M?N
01<a8-a04,,V<)B<2QcSa,<d\EP1c#8WP=)YVPM8Xe.+JT6-^XfRXQOSVCeON3Ye
V3WPU[(GFb6fZ6P@gXE+0d2+-#IRAH15LI4C,2XY>)\cbT3E:AKMDVK]7@LIWU;>
#8<d06P7:C8.F,8:D6W^QU&_SM)d3P8c2>0AAW\G]:0GU)@5aV^+Aa.C9&:;TK)^
TMdEQLCEVYbB(U3H12]IQ7X)K]f\gA7@S#fSO0@2&\W(U4&e\+JK=0d^?6=&7W..
/J,,,AW+KTf:G#d.452^337WSg+A;M-W0c8HEa3T#GHR,eHI6;GRY+YINU2_U#C<
20:fY+<AacC.;aMJN2KWH[JRT@D+D0RAe_2;HDDebGQ1LcHP6/_^OMZYTW0[@I59
PIDA4GgL#4UG8_CX\-HaVJ]T^Q<;TL&:(5L0F>N5C)YO7S@:g=<_g/.^:Y;#AO<)
[?Y0GM.?3\\ZDKGbZ_78.AI-6<UD7)PWV(NT=SE5CD7CI(CY0LJ3/eO4(5\^/<&)
&5KT32)/3b@2Z4Y&^dCg#Ab&6]>G53_cG_M#A-#6V1_R9c6bPef:BG8+#28S#HJd
.:=U8XME-(<Ue6&d8V/Zg9fNMa[dYc4#T.:&YZQCLU+@?Hc@]TBb#d.CQ:F]92f,
7RFb-b6G,]M#7/g??C;VY=WfH9&b6,R;E)D5,CeB.N(\5U4-?_eX(?0T<UY;aGK[
C870E7IN#X4#48HLQNJ,9geF@8=0>TDY?V@^3XI\B&/QZF1YNX7/9O9=:&fEbD7Z
7T@3>:QT#fC@-@<UDfDS,e+[H(9D]W)MaXTXS;8P@aQMPL=WeOQ.PQE:YBA@^cSN
8K;#&B?WZ0\:NTa#6UCTRD^fa6O<DQ78U=;d:Z]/OKPQ>XP4Z\eJ&H)b4LgKAb]_
3D]f;gBJ/9=ZE2>^IBL3&gb;@^I^^R[V3&OAN@Vg<U:9+X\S,A8,Ebdc2UX0L50d
,bI8M-+)(FD]VP.^S78SROc.X:Y8FSW6=DA,-QbTGFIE-?,e3IXNB#C)D<_dY)5W
QR<K+B1JC/N-+ZZVJ32/@FRfD2#Wf2/BU3I(7N2#3+(>[(?GOf<f4PCGF@/3&:a;
ff.XeL2J\0RC/+EMJ;M2LW.B3F_?1BX^cRWR]d<f/c?\8X+Mc<:c;Z_ZM<e>98Og
.-H?A(_,EbE.K05XJ2OPI99M,58@Z;V+;=:NDLAHNeKJT->d_0#eR?COHW?89+6P
T7IFO#53E7K8KORE[A&>f\IcX)<24\;E?bV-?a+O.++^@+O],E,KK]RfdDNJ\_F>
9Bg,&P-,Z9aJ+;CH/TNE2K6gGdY<8=WM+\_6cZ)?)(8;f-1@FD/+d-DG-C3S>P23
>6Y)4(D9eDEeALRU+IPNBfO;MEBUIH?I+IS[E8QFKLSA4]@29O/VYQXX#A\bHEC.
YQ<e@ZSVG-C[>:ORD44EPUNN)=WNe)7\/PT+-#0V^R7/F(U\D[2;B0&_B2>FMG].
bU#A0)(aMIXUIF[,^GfcA:)-Nc\YPD2HGPY=.B,VCRU[d]N7@79(#BLC?&XZK2H[
+LeR89&_H=.bGA8HCCQ8C?V6Bg=@74(F?GFaA<eH@S(^>@LGMOf)XAQ,66]C?.9_
(V3f(bO?KaE:U[BYW(I,g[F>E342ZG,LE)LU(CbWAHQG.aH0D9(39a35W3bNbI6:
aN7QB^HX>I6;e^5P[EHI9.Z#HXf(gC\GI@#dfB0C>]&<D;[#5d3TD3/S(HAOCf0M
c=VH^SD&aGVN>K85^D<95V42.+I0>)-9@DR?&;(8?I;>48;LU.,gE8&KEUK)YKIX
H6ITG^>SG,<DO[M_P5;9TX1R\]JJe46,TJC1G?_=Mb/GF<68&Dd950CV<P(R3&79
OZVH9J[Cc6VY,]VQ@JO&^9e\E/Kb9]&_/6F0+edH(8IO=/L[+KL#M/bC>1<Y<g9>
=@1/H\SgYfF3FH2W^Q#\KO<C:8dN_5)WRRa-?J>MW>Q&VXA:NY&Aa^>aG^GB_J+9
b;,56[Mf<+dQ29Jb_G3XS3KB-?9I/\UfOfV1dDG;?+F]<D;O>e43[JV?dKZg0D>;
H3UTa=/?M8XcVaGLG^cS2K9.G\JSAfAO#aCY.]WK6^<P@,&EV@<c&1^IYQ7XdH^N
XOdYH>fTf2Bb/HOG&C1b\8N=<+#=f/YSSJO9ZTA]8H,I^=cMeXU)70ZAQc#XS)P9
G[@013?P3SbgI),4?&2V3\4Cd\C<FQ^=L..HfI.BU[CU^:f-2\bCMREW.ZOM?d4S
=0<;X1W877-+)E)9C/UOBG?#JH5-ADW:;d=L3.PO/P>GBBZHL6(8Z\A.c:A&KD)-
Y/E.H@cFCDX<bMD,7]GBK^)?-5LOGZWWY4>fbKLZ13fZ9PMQW<S2R6PK]40DdWU<
dKYZBF)8U9Q^Saec8[e/-Z#,/Y_YU1e1Q,#EF##JK+[#K0MS9X70LgBFV)R[U_RW
H40CYV)7H+2LZ#B6aY_9@JaDaCe_/bS\810&g,[;PeM(&U^>1[682:V=W;7d9(aZ
8T,@EcHDUDeEVQ#@eLUeY2b/[a@Y5L^DD/-?PJ[G)9EC/bB?8]W_+Me_/W]5S]E?
NNfY@+/aX>&,dA_5RBdSN[+6&,4VC8.T>K89V(T[B174?/,3GXI@?FF/Kg>U9&PO
^6^aG@U+<O4D0L=+B\Z&f?c:]>e\,K?T61d1?<7,,BKZ6&0:c]V,>,?[1Y\>S44F
<?QBI]eEFXYG9C_=f4]H(36[)A21.H]XX4NfYD:A=O?H;@da\)XDM4dN_a:<;bBQ
K+@X:RcKNV5a[\?4I_0O,K^Z&0JE2g^1g^CTBa,T44QME.;76JeTF?TG&-+_;5Rd
G:RDX>P7.gO-e?ZEETL9JX/ML?)I<VFSfJf+CT4Q\O&3b9g[EbN]5\0[]0I1]XO3
K07^IDWOEB)7=<N-.T5P33;=--LJHQ<H6e-G(99@,&W/7UfY7dVJ5Ig&49R^MZHB
?aJRB]QK3TL4&0XI,Q_X@fHWNNVVL[/QQ8-@61cVE&#bZ)A\&Q/M;KU6JfTH4(a4
9<0eS(54fFN-IIUg?24[/b.N-OJ;ON,/,Z:C5bdfALPY&d(4TVPB]TXEDKc+Z]94
=UF&4>\2cY9gEAaLD?^XS6Y68g^[f[&2YY9C.^c,4_ca2gPD#F\B:6--2XOXA&CU
?-R;-8MVA,LYF#cN.e(&cV-_KgfF;1W6UWDc(GX5>=O6U=\dT<\94c8VQQQ/aVSN
?HH8_[FK9UEd/54^c0X6VN5WCAT;O?^>+(3)6WLgGXE+M+JH:ISHN/F=GeH7&@U6
J3>Jc6H430BXJ]dFge:eQbf:P7P,TB35[02Y(UK227U1<\M=KR&:_TUU,eT?aBSI
ePVV_H>WF1]+5;4Le(M/6A@WHeE0DGYYD-V,d=b_N?GT85YDB1#L,ARW&cF\#I<J
+LY[)9I1.]6JE,?=B40WJV_)(B8RMdOcC[TbUS+7;dMC2^,DH=[Z+TT@N.CKNaR7
If)XOb#[b[C<C>7R8UIEXPBNK6\2F]MZ(Qa;CeD7aUZDSQ1,?6K3K413NTaB+.F=
3>JKYL-T38E+2NR<[0]_(f8@H@If/+IG+Q;&R@RSIWK+,Rc&aQX&9U[fP@=ZC_B)
8-?Vb^I^ZC:<QYC1bWCFG+Yg.-IF0W;Wd2ILF@8<Ng??IPDZ)74Sg0=K=K@G;C-;
-ORBJ@8ZE.RRa3<K.D,J&VMAZ:e>EMPGXOLbP^5+H@2E?_X#EX.B1f5HVH1Q5=?N
VZ@=<E^,7DI85N06P/e:Jg#M^]UE?NW#8DM^g@\X=/E<B?M92Y>Xf2Q&3e]V.5d7
CK^g\fVT#&COONM@MNdG,_BGeYWMA#3:&A7U0Ac0+;^L?[G\&1+G=-8;/#YB;:2=
8SZ#Ie;3-8(@Q@L9[?Z]Wa,8gZ;C&<K]Q]D/gU5>-;d=3IA(YLON;7Re5_-cKF?M
Z3OBTbSXgZ)-dcEHL7T?_71ff5T_ZDWG_O#>=Ie33AGWf6<-6=OD6_L7/@>RT+07
ST3^<QR<^EM55&-O/S?W1G)cW1cFL5acZ4UIUHM^<KM<138LBba?a6+349:05ff1
fG6XOG>eHDKL//#Z\bMA&,SHCWY,ZRJWRdL&d8N&5-H]R>Bf(RdFYE<1?SKeHS4/
2NYfX;gUeE5ETGCHf61eBe7WNCNMZc+,eR\4-SL2;XTQ8e?2JfE]0<001DBVXb.M
FRWC3-CJf,KM9=2N5JJbFLE)e,XT]=[?_+RSQ]aT1.244>(Z.0Te/KP3#Y[NZ9DO
47eW9[Pd6BDHT;2;>Be?UAeD:@G\IAeg\-g4<H5QZAVd46FQK0-QLb;e(bD3;JCV
J]7F7GR/H9gEN?4gYUK9BeSKbBDFVE,=,WT:NBB<24;If<>,+0^b?ZX1.^cYRCb,
SEMG\O?(2#f/JVDTA:_N^+CP)CH>L#4bTS;A2BcB(QIXQYU4+8b^O#fJEY(#a[dQ
0B4R[4=B;S\.SN/F<T&aNa?S)?Dd0-/Y]UC](Td2_9K(]&KGKbU,eaG7<GV\4\#Q
+C.(H0Y\7c]ZX&[7KMd#V&+U3@PCc=(&I,0?LV>:#UeF5=L?cSgE6T=bS)_<MRD)
D?RE@+#44SeY->Va?5LT07<TZHQbO(a4V>Ce#Y_=8:E9^bFQ:5A6g=TA1g[QI8TQ
LP4Yb0B^VDRCe+OUU8Gg9aQe78T9,QWgYJNRc3c[Lc0)]Ig]Kad_4gB8L40KCT=]
UR(8\1b@NU(A,X>X9;OL,>UIeGER&NZ96)+Ne0,da0H/RUPN817M3JafHe[4Wb3.
XAUMP.g86JH>P13-aGCI6Z1<7N?4+ePDQD8@CRC(\JFU^PJb3TDLE-X3QLb.GQ>#
0[bC>8#a;]ETAfAAW<[&8b:Y2::&D+MS/JVCW&O7CeP+>L+/C]=ZP0;3e,5c9X/P
HV_3<X-RZF^(2HPg?HH3SJc/D\=eMB^\L,S.@#R=4S/P)3H1)AV6dTW2^QaX]46#
Q7PVX:MLI5\00R?2?1&53WfWS+M_EVDd8DJUG-HdLAO?12=+K<\B=JaY=B?\E)(]
Z:7R;:7XdSND-4WgKL8Q#f;XC+)<),;3GJA)KP8YFgT_]QWC&1+=U9-PO@0S9/Y-
P>[I0-_KR9E:IeT&4C0AObN<6;R65ZX&,(D:-0#?Y.^OB<IU:E5Tb^1C&MQ9g,UK
U:+C7_95Fa^Jc<<a.9fS?I/_O_J)1&/PHA-(a8.HR)1c7V>WC4g+##RGgH<#&W4W
H<?XE3.92O7;EIKG&5</gP#MEZRG@aBX3_?<O>N\\@JX8[Y(O1?d,9L@BW[,NYX:
7Ug4b:\2RY952\g(\Q^@PR=a+E5#4MZ0;L/4C\JMN58.ERK^Wd>d_4d;^,3=OE)b
,?[;EbfR^R)(R^L#)/fQ(WU:NS.,N5e+3J=U--;8K<?Z;>LPY=1A6-)XefD-.N1Y
-TWTCVM:T;>)Ab)-]ZYL;a5UN5(c1g.S8I)S=M9O\VTMg[0D,4DFaC-RW&K9T;?U
,LW9TILKaE<:==IbcZS:dXP>eWLUY2YRIO:\Xg9,0F-bCEM7:;f3:W7,>\&<I[6&
eD[0_A\@V3=782Lc<#KXc8_FT1)V.OF2@MFA0,7IOT@[)>2(JD(DON\+c:eZ7174
4JASGfLd7]f0R(Z/2-M=E_#Wb#=5]f^98W.+--a>^S4?>N3I5<STWC4Q<#]?#3U0
,RZ84QT-F(acH_W253X_?=;\(1VBaOD.KWB7K(,05GI?(O=FTWM[c:&98b1TF7,N
5#TP2M^[=0<T3g0gVS\f?FNAT0fTf/DU)@SAR^>?L,MCQ1f?WST1bE]>:OXOR/(E
MK4^4E^CBVc4D#+FYR/XNJ0da4?#QMe\IfO_AQ>)Ta/H?K2,R8>UAV@aZedR(NSc
)8V>b8Wa<BP7(,09.MU&>RBD=4R<b.b.?\-g8B>9FMf#54KFFB1/WRKYYR8V:9H)
]M;(@GB2F>O-/d[^-A&54&f:ge\:1R1&](cDXSY3Y2JB?g&KbA?eYG5Ed\4TQ]N_
P<>PYLY&DZ8DK^E5M=>D,B5cfK-^,>;6KNRA;;)/EQgH?N[LIE]G/14O^VZcZ+Jb
:T4cP>E^GbcN+K]UB>HZ.VM]R)L4?1,g(O<.(;a_WME;]9dLI9J(dAF6O25^H/HK
43V#4&-4@^<)+E2W])[5Vf].8:^4J8Z0b-DTeV=_H]YB=b(,5B_9=9H_C@5B>H.8
1>#Z..8?_7F4Q1<NS;4<]L/TL&_>RZXc5YF;FA5)62OD\1\a65?K#/U+-T.dbHe6
/JZD5?Kc<+Z,L-J4;&P1?G3=f6USIBZ4&_87NUG20(N25dX/J,6VJeWHJ#e,\I>(
:;8W::/Mf@:ag.[C81f-MCYRU3/1]dG(=a+OYEXO8R6:.N>M82Y.Z4/ReHF:?G&5
O#3=V\+5]EIMLJ17>ff0)_gUWOG#e3RR9+b=3?B4MRK13\7:J_)<L?fD/<#3^CEE
-fUC3&()f=A<X[+6,aBO[eT__PQG#f&cae]Xac3&Hc8NU)V4D+(-Ff#5?IXaH6fU
eY^1H^d=NC6?/T8JLC:#5:GRDd[:DfMOW;SdB?NbZC8>a-[,_:Z)K3QQbZY,gM=&
II-:P?HTZAI<1RCdO33g?Z/8R:J2PKV4&SRGR_e2.d&^0LMRPFN;FRUb=E6I1<=O
#\.:WI0gf.=<D2[:&fG)\-B6X^Bd##UFbg.Tf<FcD8b9/&8[eYc&,WR6A;a?\>P)
>PHbX_OSY6K#\9/C_ZZ02PAgB22dNR2R:D22BI[F;T2dT/7DK\<V?X;^GIA#bQa+
55gU_8]8RBebM>_:^AFEdbI(3YI34T(=cUBVO>65,ELVQ=+??SF\f+/XP8g30Od=
?LM19H>V4]_\RH#B_AfW(JT).+&^QB)PeP_MA)&-B:2-dd.5aY,J2;+gZ\C,<]AB
C3+V92#,Z<1ba5KW:KeB/E_6CV]5W@0\>JV=Xg:IW8d[&A)+HW+C?82d_6?C=315
dcdL(>QYQ&QEO^e[0JU^_491/b+7F+cV.BLI]7D=\a/18(YZ)LS+WcgSS.3A6[YA
G+.B,2CgAF@9a#ZF]RA)0?,E[g[f>N.QHENb1ZI,N>eZ:+JVGI9?7]3N6?34UKC?
2V:aKWJZ7]&M7_]+3++^X-&BP-U0B:.M@N1.\SG\)g4?5/VB7b3G-Tdb<BL6-P]c
NAKa>SA:>XbO;ge]GcZ3+\[?:W]bI\0J<?>#B6aQ7#Z^FOXH;M@I[?=B+KH#XOW?
>6bN9[K1aJS[1VG..T&ZR4cKbfZHT+8>X[P.Y3:C=J1)((]5#+,fHcX=CCDA.5(B
ZPB+FK&9T8efO5E5UO]g)Mb.-b;fd=@/NQ10Jg_,^T.]f4\0L]Ab.Y+Lc0J(e80Q
4I=/NO,3UUY5J@CeX?\OT[7eTMQb2?KR9]7,RC)KHWR>#fVW,O+g7a71DEP3H:=X
M(9CV9[X97aG[Cf_;;97E4Ab^^OM67#93>,-A538EVT++A@2EXKP.P:^^>P7_GCb
I8J[GGb5=8D:M&TZH6Fba,6Rf+<Ma.?b-+F=9#MLbBacN&.80Kc&AMc1<I9[g+I=
]-/V,,H#3D(S+?R^)504Q-K=^E#@5D,_P#:^LVNb7e?Ig(XCR=UMVV9K)8J];([W
;abD(]a5dSfHR5W3XU_gO(91U8?TH&Za-PZROSJa&-PQc+eJ;AB3TIKLNT3+>RYU
6e@KCN+B[;T--ITE7YM<,eQ=+H88W=7?:?L93]^9G/?NVF85?@P93fVA0Od3CR(7
Ob>HCZ2&+W6L_9D4=DS)b0e2aG2bX^>^([H&HIK+eU3/Cf[_TLe:bX\9&bBS@U6#
6\]]2\.8+4Gbb+0D;=ZKK?5c_QZKL1O,Gaa-ZA#,<@J?-8gIR_?b+Oc\H[.[P1PZ
[?/TGH2,T0GN@O=MY7@:-aG4_4U2c\+HHM<a6^12U:AL>MT&MNV:<#6>LIZ5f?6E
IE.L(3)c&^IY]6c4:);L<-PAe7(-JNX+^POVJ2JW+d#VPPOKV[Y^U<daNW0g(&?B
<J,&SbML56P&FIZ)TK4R5S/\)I_,W-+(_)C9WZM5HI[VFGQPVER.GRU6A\GdY9bW
bMSEP(e\fTWV#0f+:;&_R6f3>?VH3:\7:O]5Ha2_[b<+JW-+3;^gW_G]QJN@3G_a
IJFQZO5G1W9Oe:b)g8DGFU^PCP+KH7O@GMW[778T4K^KMYF<>F[W>R;^eD[Q>^\/
<K?gfZ]79B-bTCd,L;3/-d9DObdE2>M0g+:b[\?^/ZN;Bd=YbZU)X,Y\aS0aeTMd
>Yc8gW/H8N[QGID.cAEV2W&,QKe[9bCe5\V,WR>&A\98(dcID#US3LQBV8=1:#Jb
CJ^-T@]TZS+PAC5L2Y=HcNPB3V,YY.eI^OQTC2S,/SbZe8^_2cYL)dRZ&&6M=SR_
<XeC2(@feTaA#O,.U/dK7INT?4H.^Y:TCE=[Rg,b@\DUd:gWbE:J-E9fG\LY\7YV
ee-(WDV8ddb]=b?7bL7;+R?YR8I^6g+Gf._8=_CU41]Q&,\+8[;R=g:NeD;K+O=+
5bY[U//a^^.\:A1C=U]/D_PDbM1_BV?=YP@(PVM4&aH++8&8fQL#d5KMd,+Ce4RV
RW(:1_R^aTJ[_Z_.HaBL+96W-A)_FfE<UP</e75CF2^@96Sff9Y2>W\\bLAOcZ+R
TaX-,]WCa[OSBD=?PY<R4GHE15BAJFQK#<.WIMSN>BWb/2O?N/G,@BG^0_Z=N&,Q
=SXb2LfdGfFJ[19(7.3(AeLQQJ1FbIJ1bQ^f@-/YTF18XE.=QPb@C<caN_&.XdAa
<7\]>[>g];YU0\^VU?eBeZY.6F3^I+;])FD3>\/b:41:P6fZ<6LbN;SVfJ=5^>R-
Q3]0]&#1ELNIPKK,]:ba7@LBbV(X/NHAEFV6)+#XN>3I,MY<Vb99ICA_H#LTG4XZ
?7><d8UM#g>_FBOFN6PZ_(05&5B&T;YAM4EfRT_;=1V_1&P)#0[cH<P88dRKJ/E7
eZb9Df8ZV15KU]0f6([gM.#G)KQd5SX6SHb<FC3BL01Bf(6dWL[E2SAV8M(/>d&Y
8N_B)0:7FI:-PTeb5O>AUOK+XFR\R6Dc8AXLS;bV#d)&.T1BLef5.B4&^d1#cK\Q
#&-3IOJLLG]8>)6SP\.-\=5G/OeD;R>H/R/bB],M4a73#ZQP<8[=Y&,K90&29-^G
0C90&))a3JPNM7OQ8PX]K#FCP)ZUNMJTXVQ0?(G>8FRM)c,WM(_1a:V-GC\/b1[3
#P.YPgU@eT(0X1KcV=KdYAST-A7@(+HM0bOWE@9<KIZ&.H8E;EO=1AAO&LBF?5,9
9=a?\W7bVJ+_1L)01S[5FGRV@)=RW]DBfZg/]Bb:+L-,_Rb)/)?<;a395)bZE(4V
EK[NF[IA#\&OSHD-WWUM=-\T]DBbUAf\TV:XK8@/_L/C1e,^0V[/6bZWECR+e==U
P-_.3_I35N86BP\/-+-=PCaYDZbdT#<:[GbPKT.,@K,cFL@c;WO54a,ORL9HREgU
:^e:>3g^C@VdX52LY6L=F3aWaESX+VeZOP:.?ZC\C_S-&ODT62)gfRLFK1W_?#@V
QHY67/APF9_XM?M3@NTaFA@ZbJ>7=+4#<92[SBJGT2>X)d@KEd^8Y]]Afacf8@-2
aH^@f5B.)#RZQ6)AT61+XVcRfg6B[<gV,B1J\Z#6R__&14,/@3P1MGE>d:1cF2Y.
X8dMKB>\H1HO:^X(?aeJ2WXVR,>[BMV_Vb]AMW,>PK^M)2eXQLIfcFX7g=HVA@3X
ZYXG9K3C;_[A^(<aS;NSPC2b2Y\#WH?Bg>3^VM0PR)191&N&WTXW>=Y6F>\g3K:R
?FL)Ud,J&c/7-QX&YHJ,=2(NcaN.C>.B[&4>C1<7C;YI/?GC&9>8@]bG)bLf1^Z0
F6#O@IHa&96H5dB:>F)=JHY,D7+6XV(NSWXGKdFVNHGRXaD.6I6J<6MM.9VQ@^#b
EN(>F;d6;WDV&+bZeWH,V4P2&&&Q=T-I[-.@)CKPHK.\)A1A<J1,PCK.:gVOEST7
6I>VX1AZ_)UWD>BO4DF])2&XR>7)e,VFZcZ&BV^>64AdS#ad/gc+)<6;g-5<_48Z
O^WaIP?cX]_?46d8)X;(/aQ,]#9gJf>Z)\[-R6aGJDeWSf)4A76AHb=K3-EFb](P
-X=1Q[GYcB104Z4SI?;eI(:]\C;^T:(X8cJZ?:3^@=EV][YP6WU.I,G@&M:1a(c)
<=1g5^6JI.H(ZT9H2&].C)?PWVff/aY33J#9/2G;Z)N]G32gSX:gXdBU;e[M@I#c
93g_LW:NE+602PN^T@QN;[0gE.P>(PfGI7OOG/\b2]0f96P2ZD:3Aba+(6QR@(4<
=SJa>Jb3g0@-MgFS;AOKKdR)I:3e<U\UaPDS@W@[,&T:D<)Hg/GCI:11_5cgX;II
I;RM(1R_PC_OPKYG^5QMW9I8(1Gb1CWJ\C1U&_?:1]V@T,<N(SY#6]49acS4A<K:
K<>ZTA\WfXOPCQAKUUZTe-_MI=^f=bYD<L@FE#bXSQG[g8ZeF,#1Q74<4MPZZ(,E
NDF+DVfO6A&fF\7=&8^2UN[2AD)Z2V2?<g>VVO]V(Kc_1<cI.3<GcMUB7Y#MVc0#
D<&4EYN\G26M>&.:]eT^da)dB,^0e0.U3c5Z<C:^3]Z,PREg,aS(EDDM<4V:S9S5
2[DOJPb7cfIe<&[/\?QT-[OGKfDO0-L-3d@4<HTb233BCNXFQXEaN&_&??49N92P
d^Wd=TG2,^&FD>GCc>673<](;DK4Na0^D^3@Scde.NCQ-RR_OJe06+YC6-J(IV6=
K&(dLS=-QJE:&HU5#DPO<XFX+:\\@<PXL]:=)a8#f1;+Q:Ef.B_>aA7&66+([-GK
8L[R>8E6dHa(;>&0^3/WRI-aNEd&X@CPa)f)\(;ZULcf:SQA=,U&_H[5#IcZ@fS5
f)K5+GXT#7^,J.bU<9X&Q.011]&;0A8\9Pf>PK7L>FP[&+5b=I3K76gQX-&@+425
W#6M5d^NYFV<@WVYNg,BTWA2U;O79RO8?SRV4#N=daBZ+MAUTEPHJYQ8I\=4da(d
+#)caY_@S9P?,68N]D&37>VQ\8OUEMOee9;F-NS+7B&U8GCV],^HG,J?7@_Y[[PQ
O@S:/XJNC>M9-H/Oc=;MT6#KFPf:?fTE,+<gc;4))aU2159&::_78X.;g4W4\I[I
DH,<9=cV;_=CXPb8OJ+^?cSXYDPHC0RIS5APDH:5Q3,Q,fB7@,^dADSHA6\7/I^S
7VC,=3g80L22cUF//a>A\FbAf0NTX;fc>NbW:3T#GcF<C9Ka-#Z8@H9PJGOf6>^.
QA@,PG8-SJWWJ]_AfU>_U#QSR0BQJ;:<R=0bWB2:Ue=N:PXT5O\?#P6Ef;(TfT2g
-7MONQ[XUO<GW+f]7;>./)G;E:T)G6@\//7:DVSDfA0_579e6/BK\;8/b.:=L4D]
GIe\GJbS9ZIDMV;/5A3=LeF.(JQR[0/e_M;/L+3LJ(fedaE#G=&T8f1BFdQLY0U8
1LO:f>RZH&8f-6eGSa2B65Q.,&b#QXH,T110WDA?gd:60+>5C7cA<=TC=XWSJ)aK
S^\=M//49IDQ>/e/g1R[S87&/b,/K[)[];5)G9<=JIOdD_L\QP9&d-Y/0.QCSX?(
;J[V1-6Z7&38M,3<PCCO\<Nee/SW5P0Qc3PfOH[9>1QF//e6(4>I&YGg)I9VD/M\
?(R@M?ZYVKBW2;1R(Q#=Wd61K,W1&(f,3LBd/_63ZaGU-bHeXHGd,edgg(X(BTfQ
=84PH;bAX[(VEO:^JV=&&+Fa3fDIRZYOW&b(7HWA)EFa^>6@&S9/Y=d-Q+O_YUFQ
QF#ZLD=_D>&28DCDgKW?:IeYB6W>ZRd>bX95QY^2Ia\=cMK4O2?F;=G3E.#X^/P=
>Nd,R,OM]S2:WU)Fc4J#6INOPHa\f>f@\[a4@AV3)/65&LS2Nf/X447eBQeW_TO+
IRO/,_dY4N<,/#d:?YFfIA/D3?4.H4SZ@.5)K3_Nd5L7(GDQ73f9EBW;>O^:?)6b
:bC#AHI.(R;,)PdK+T@MSSM+<\8+0-^;e6<)Zc(>V=;P6a]a._-A[1f97#?c])XK
VCeAM?P02Yf;A1S=C4&<[,>fbPS(7fR.AUX1Y\B+a6.:g\V/==3]Z9#G<L=;&_gN
aJ^/CHg=9b>7;.57g.MCBa8W94W)fJ/_@T:E\[cg9Z>bSNT[=cBd9UM]JbJ0&@H/
?;61]<0A&@9ZFaOD&LQ]OY)FRL>ZSKZMUI11HS9[X<CFR2+8:d9Tgf5&R&4R6MW_
-N=ER>QSZ7#(H+97@V.4CSL7ZBXQ[@+WN:_JX]]U6Jc+:N&3YXbKT4=5Zg5CI&?A
F(\\?YLXB]56I:FSV-]M6SB<O(P(f1?VGL\8cPdbI&LV#]<@]V=#)Z(fdJ5gSYIM
Q,cL_.C;d6XP?@Q8=8K+6.662KS[+X5YWOWX&DJ5<VH<G9Fb5IZPX=@@.,#eZd-F
/AXY_&@+[)8&(^^&)+ESa&R^C)L07g1\.;W?#S@L2EZKFgX6(T&Fgeg4>W6SYA/O
d0E>gO7eL.)Y)6ZdaZ69b]5PP>C(11O,TWIOe->,QZWY(UB>-T_3@E8@7ZQD=VS/
;\(I+JTg42_a8/,&MG:,Q?K:>414KK4+>2]+O9ab?bON8dT1S35).9U,4&?J>B1d
UMD<4W[_/L,D4.HfE?8]E476>ICV,DcPJZH#<B3\;LJ6Q7>W@(2=789J7JRPIe/(
<7=D>QBOc<YX^58T)92Q6eC#0:/EY@AN,8;DT>dP#RR&M4V^Y_f8<f7P[\F-FTH0
B]#9g;;XRTfX7>\dLF3\eX.>=N35^Q:-#V<ZF_WY:)L3[#F?S\9O\^Hc+LW7>;7[
DD1.,\9_/@S2<RXC?=31<F2edf[]S(^3cQO4BD6-KJTY_g/@P\EJ5<XGBKT8GaUY
G5\19;D2.SHZ4,WTaAdTa&7SZRWcGDM)R<B[&c_\@;<)2,[KZM;,&/\DH&,B[&(e
Z<G[2:cLH<5LK)<fAZ6.E+6=d]O[F4.A/^#P&b0.CAQa@B^R2IML,EC-1[X#9c^&
\.L.\F7;;ILWZ8gf>5@5;f@UEGJ=YHc80LPO[5SYW_=>?EJ>5Dc6ZgdNK69-&UQ#
E46R#FQ?K45L<SUXe?f>0-ZPPSgZ^7;Sa^EJ^BV[UT+JE-?P[+\9<(Tg0-?Dg<PR
@QdWYGBGW[:d2R,P^fQM63.9E1GJ\G7WU-;J@#:JGgDI.^A20AJ.S-59E>E?SLZK
7\gbdM+eK;\g3bI=Q/+M7Q@dOQ:K^JSMH^]U^FIbKK+&#1^UKe2V/PR;D=M_3[_[
cC7R^d)\8Y5H3C7fd8VMYEP^KB)c/-+@d9C0H-Q@/M.W5,bL,TJBZO=T,Ic[&ZeM
6e;48MVdf+0Q:.AgKETEOd=P#N6LfERBZ=aH?Df)F6FS<Wb+G.Y,Q7AM<&V6,73E
03.-ca6C?aZQP2ITbK=4e^MbNU\fTZF9LL5903MPKD..+CaeIO&EbE,)GFbIcg94
GAS8/F[W;<4QE.&;T\[4gC_14KR@X_aea+O,T>\3?M\04RVR_S(egA1d;S-O3J[[
1#;IB\aF[?EgBCObUR^T)GQIXO.a2d/=X3Cg&]EbX;QS+[G4PG\bRO.A.GVdIgJD
IFYQ=dg9de5QP6ATg-TQQ]dUWJQA8eWdeNU]1\))Zb8)J07GC<VV7D(UDc:.HcIR
DNg7-0:U0HG8A9C<O7dIHBV=^7T7Q\@DD^P.+@O.5VXX04X;YJ[Q2&dIF]U>.c-&
-T^U8]T_<+UTd1&XOPAFQS0f:##Nb5\a[D=+L3c#VM1:+0Ldf+]\&IfY@5aJ:fK:
d-LSZ_:d@XZFE>@9H?)862c0[&HRC/<S_Sa[_g>R5F9QXagKV7Dg7+T?AEY>:68-
>Qd95gaC0]Xe#SP3_30/K[\:+;M]6]dD&?4V3Q6c1QXaP_IQdS(QcM3>0_FJ<Aca
^UU#XL#E<?=)4?/e7GEa0fLSKVDRSM)LL+:N<^;@)#?X&7HA<7e:W\W7OB5OQ>TN
U@(1ILI:(aM==B#E/3X728P?KC.gT0D<G7]U(&Sc&B=0TJ6FaS4_Hc679GY<9V^A
8V?T44&O\^PFE6R@+gX[Q,>_2Nd>BDO,W7gWC<#)Bc=LL?8dNT4,g,\6T7=0a3\:
C:_HC(SRP#e:GQT2R9#J.2/#K0CEZI(:_.bX=;b,@faY;8-gefU4,N&N8(fG[D7L
Y]SS^a;eE@2E,E:E4FWKfHB3#:DVc9IKO#E_SN;@VW[^J7(KAJ\5f0&3VHS1CW7/
>IQ<D_IT)Z/fFFX,f]OB+65Qc.X1,^;7]1#&c<>H5YeG7WX>]0)SAIQ(<&8KXWHM
fNc.[GGeREb)T7,R9GR9P;[I<:\A-KC,^ECDY0SN=.]+d?ASa)@gDgAR)7ca2_ZX
f@:R]5.gZ#@RTOO/7#=106e4EF>Odfe@Kb6@DLZX;=6Lg^1R\Y?#&SJMU^NF:V6@
RegA@b(GI(0I&8JCBcMA;7e/CBOM<J#EWGU_6EHCKO#4b<-G[V3Q:adOPJe\cGY5
]1=0>QRHN^BI>X7,,97:3FaY7FRTZbUDS7gEfb<N,IeD[9-O&f[>D5e6U7IA5MIe
FJH_gX9<\BcH^SN8:XR?<BI/dgaGDMAZHEgcX,VC64eHRTS+K:K)T.,P<7IO#:b@
]#MDD,.cTSg3AL67-FV^PJ@D[VI^9#b?a3/>O])e#2PZS:,^.g:e7<_6^OJ&:SEG
N>4_1@<Q5GL:[W2P;,[P(\0,?SCeHG#7D+(BfS_;Z35DQ]D]II_B.Z0M7<_4c5_.
9JAD>>.eYMUd1P+e[0@(?:HEJc)B>=(607QNC&GYL_)()^U0?H)QDL<&DLB/4^HH
AJ<Nb:M5gZ/<YE-.K,6c.H5)QPbbI_DZB,cZSPU\aJ>T?#c?=D]S]cZ.7e[a<^/Y
AO6&VH7Zb#O50;ID0=K)2b6Fd#@PE\d46RdX&e@DCMN5GOYMK8/=Zd7/gI>7;GgT
&?GD>C0JJO&b7<J&^0<dU\AM\;S\04[,LQI#/Q[g2NaH-LM8&NbHUEY-)UKY&RVD
-)17:1FCeQ-=&U)6WDP)7?;>Ccd@50N\3I3Z_980]#K=#<IB-=.G\=TK_cDS5G5,
-O[4U4gD(3LOK=?4Ba=;&aVFWaGd>#OS^8.U55)[9=a66XF#].dS6bU8\c8HWfF]
:<D2NaF9\ZI\FX&CFK93de[9Y/0Ndd<2>EQ;MFYH],L:,+<@;/TE-6IN><BM8/NW
)e\d;//Z=@9^b[/;^9?7d8Y7:Q=I_K?^N928,S>UVOFUH#\U0./F2Z;MX4(J4R13
A<bT1_05P8#/FR<9<bKG37F1fE9_D,eX6.1gc?,1N2^MJ?fEaCW-dPTL<OM6WRF\
=0:J5OVDg#XV6;beZ0<Z/Z0Ad956@B6L+E:U)&cJTe@P-Y#:M27.MW3^a(Nb1ePa
_XB(DT7ZIP[L5V\f&Y_(Y;Ye-_G734LZ@,=a04Z>U[OYEAg4T-@N/5(35:2Z1I@\
X\R#N-W8YG&YX9bD#V1JaF7I=R7T-F&(?;,Y=9ag8#54Nf4(T9>6&C^3?f@7\?9&
V.X:I;-Fda\)KY-<M/=,GNNI2C.bf7>5b00ELL_IC:HUgVGNG5[\R)fQ?0c<S+XS
2OdZYXZZ+_P234ZJZ2@e_L02^4R,)RBaE>1NUc,]_U[<UfM(adYd[e0\3ET42U/b
eA?T&6BI\(OZ4IdaA:Z_9dFG,-,78^X4)4X+GR=;NL,AcZ@GbCg9WRXEKA5EWR(#
d:?Kb,KIbQ63WP;19/4I>bZ_B)=[1DCcYL,fNBIEO_42/KF9&Bgg=da?C>c,g(\M
3g/Y65K)21L[gC8^VR))\RE6->^UF<,923M&+-B4DM.1@@DFS>B9[FgT^g_QD3/6
X#cd<f?D=Y9FHZ>P5OB]V90T@BQNOFfXX-^V910P5-\OX9J>R_^NO2cfPU:aVNCU
6GV]_5,@J4(WWIc#Pa\O9_g)LCX4?0:JC(ZZ+5D&MG+\P\HKAV3Y+Qf51&TaRQ;B
)[?[<[3fQ.Q^S>87EfQ(:VR0&.4Ce-(Tf(aVR3QBBf^KdT&BPe-c<[=V3O\f1DG_
NGb=79gL5#OLL#]3dL74eSN0[N>3dDV3^g8KCPI#,aWVYU<,<^+/U;/ZXJg5&IH8
c48<=/[AKB^>^F6U>1_c;RJ1PWAG)6I+2J-F]J:Y/RSL0/<+e>N+1a;PM/O[ZGVL
(@WB3D+GV-GU#B[?CMbg9G[XcJbKP<VMaV#I3F<57A=AI=2cP\XgU(0]Y?g#9?Md
\Zd.3__F9D+9&Ce:U=#&5Xd#BT?9WKfJM_aB\@6eL;VJM9SFb/J43MNC&e[gg8HZ
/11HB/f)L5:9@E5]9OISAIO(UTCIB?7f)egJgR6ZZaDD[@2TP?OBg;2/+Q?SFPV[
6]@<[A@2-NfFFDLHY>RP\c[>N(SZ4^83Aeb+BF_?@H/cWK<BaUN2?\G#ZG_UTVV;
\g-e9&5>f3@U?_;:=g+?REe\EY#Eg-[29ObL4B68J?5bfRI^VF=8T9F\TP\Y-#[-
?@.OZEf;U2(606,0T&-G<e/,B#8E3;SK.,#&U9+eP1-b>C01AID8K5KP2[E1=aW9
g0NP/?6MVN5E.cQ8-5gEe<)f,>NY#Z<M0bXg)/3Yc4R>WHL3U?RZePRQb3[@E47I
HQ4-.33S951H<35M9MCPPXL1KS,R(0M8;De5P4BBGD+e5g,^V>U.UT^;([F+6RFN
b+AG7G>TR1\,DOF@(Da/cV0]e1GJU_78<A,DN2YVb1UFB#N-CK]?5V^;I$
`endprotected


`endif //  `ifndef GUARD_SVT_MEM_TRANSACTION_SV
   
   
