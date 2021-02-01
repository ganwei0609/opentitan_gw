//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_WORD_SV
`define GUARD_SVT_MEM_WORD_SV

// ======================================================================
/**
 * This class is used to represent a single word of data stored in memory.
 * It is intended to be used to create a sparse array of stored memory data,
 * with each element of the array representing a full data word in memory.
 * The object is initilized with, and stores the information about
 * the location (address space, and byte address) of the location
 * represented. It supports read and write (with byte enables)
 * operations, as well as lock/unlock operations.
 */
class svt_mem_word;

  /** Identifies the address space in which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace;

  /** Identifies the byte-level address at which this data word resides. */
  local bit [`SVT_MEM_MAX_ADDR_WIDTH - 1:0] addr;

  /** The data word stored in this memory location. */
  local bit [`SVT_MEM_MAX_DATA_WIDTH - 1:0] data;

  /** When '1', indicates that this word is not writeable. */
  local bit locked = 0;

  // --------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of this class. This does not initialize
   * any data within this class. It simply constructs the data word object,
   * thereby preparing it for read/write operations.
   * 
   * @param addrspace Identifies the address space within which this data word
   * resides.
   * 
   * @param addr Identifies the byte address (within the address space) at which
   * this data word resides.
   * 
   * @param init_data (Optional) Sets the stored data to a default initial value.
   */
  extern function new(bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] addrspace,
                      bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] addr,
                      bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] init_data = 'bx);

  // --------------------------------------------------------------------
  /**
   * Returns the value of the data word stored by this object.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int),
   * locks this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked
   * state of this memory location is not changed.
   */
  extern virtual function bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] read(int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Stores a data word into this object, with optional byte-enables.
   * 
   * @param data The data word to be stored. If the memory location is currently
   * locked, the attempted write will not change the stored data, and the
   * function will return 0.
   * 
   * @param byteen (Optional) The byte-enables to be applied to this write. A 1
   * in a given bit position enables the byte in the data word corresponding to
   * that bit position.
   * 
   * @param set_lock (Optional) If supplied as 1 (or any positive int), locks
   * this memory location (preventing writes).
   * If supplied as 0, unlocks this memory location (to allow writes).
   * If not supplied (or supplied as any negative int) the locked/unlocked state
   * of this memory location is not changed.
   * 
   * @return 1 if the write was successful, or 0 if it was not successful (because
   * the memory location was locked).
   */
  extern virtual function bit write(bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
                                    bit [`SVT_MEM_MAX_DATA_WIDTH/8-1:0] byteen = ~0,
                                    int set_lock = -1);

  // --------------------------------------------------------------------
  /**
   * Returns the locked/unlocked state of this memory location.
   * 
   * @return 1 if this memorly location is currently locked, or 0 if it is not.
   */
  extern virtual function bit is_locked();

  // --------------------------------------------------------------------
  /**
   * Returns the byte-level address of this memory location.
   * 
   * @return The byte-level address of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] get_addr();

  // --------------------------------------------------------------------
  /**
   * Returns the address space of this memory location.
   * 
   * @return The address space of this data word.
   */
  extern virtual function bit [`SVT_MEM_MAX_ADDR_REGION_WIDTH-1:0] get_addrspace();

  // --------------------------------------------------------------------
  /**
   * Dumps the contents of this memory word object to a string which reports the
   * Address Space, Address, Locked/Unlocked Status, and Data.
   * 
   * @param prefix A user-defined string that precedes the object content string
   * 
   * @return A string representing the content of this memory word object.
   */
  extern virtual function string get_word_content_str(string prefix = "");

  // --------------------------------------------------------------------
  /**
   * Returns the value of this memory location without the key prefixed (used
   * by the UVM print routine).
   */
  extern function string get_word_value_str(string prefix = "");

// =============================================================================
endclass

//svt_vcs_lic_vip_protect
`protected
6_a(f6QV.V(.5.T\dZg1O3X8->76_#F;D)X<(eREJ_5Z;d@F^UcA+(KbC6<a9>GR
(\3VX+^Z@DP5=(aLA),8<(]G_,\b3cOW)II-9,bLSZ,b;A59MWdIJW(d>fG+EMZ,
D,=;6_H#-]G0&7FYB+VW0BK514f+/]fE()0S)^05.6R[1TA;Y@SRE9\@Ce=R34@,
aP05/V.3EEZXPdSa1cV-bdD9I>(Kbd?REA29cc&(EU^(7VdcE??9;--[>70.KOF^
@@+A>X[(3Ub<e-5AEGG-39/cN&O/@C,PHLHb[.e,\f=+W=JZ4S;]7cS7/f#Y\3Yf
RW,,?\8UQR,F(e)b@>,945RD+YFf>bDYEV+,Y6Y@J;@:)3+FeY&O^3+?Q@&Xe\.(
^?P4-P=b.[Ga;0)[N3SD[/@Jf6&FD\H+NC))EN8?EW[UE3^]YcI:gdTdU0EB)@4&
[cV.GPB8XJ[7b[I<TJDV,<YJW[K>W:M>b7BZJT3;fJBW:gg##P@S2/^>Y?V#d#]f
(YOgbU>6VR;eYH,5)KgI:&S\SYX,=#Y9TN,]0(2#6&SY9/XJ,^fXT2,-#+Nb4J[\
WW;P,G>c@9KZ5VUE02bJ?CWa2YI1OUMKA8)1);T<47SLc#gZ;Ca\)N65N0HDK:X#
=c3F?=f6@JGQ/8K849>GF7,^<&O3_QF,8P,&cbX59:>114,?3SEM902E6-/>LO?O
7U@N(_W^;98MF5NTcgFAb;OR_V17=],W7:3J2_T5H7I7:+1D<&OKQL@:OP]F\1Lc
+ZHGBg?1[N5;Q>2Z9XK0b[:@,>[^S[SU@59F[#6b#SDHHJH\@<A1IKXfIeERVUOS
Z](M18:1-^TFd_FaMVgD?]WKG:5-/,:^PfDOPF:3E#HNHgT=Rd^b<=#+SKWe&.:@
fZ5Kf1<5BI),#\Z=M1LF9#YK=\a@TfD6@=:5AU^Q#Q0E/E?P+.VcbTU8MLMG=[.&
<6O+UM;aK521@@ab[P,/G/82e.gcG?@QN?Q.fC/AGF6@D]QR>Y+)LfaJTLcG^385
,>-.M](<FY/(_Ng1d)fUDb4)OLVQbP.#0B:gRb]4CP^?JL@(B+B\>D0fe0KHea5\
#?T(JYBMZCPe3:LIePgBU>f_76EOa9;Ob@JA2R4^4Q0b;&+YJ(#F(;V)K_DU(F@C
g6(HYPC>KG,@>>+,WG\Eg_;?31-&Z2B2\.D54GQA5Y#P3()VP-OfRc](Y8IC&@H/
(XLgRUaaD@P7/7dfLaC[g,ZZ0J#da8#3&@L6?Y=9[4C_^b:6Y]5+.Z;1Q/\?]5JB
4Y=B_0T<T[F)c/)8;>(NVBL#8[,3?T5,7+>7U.Q+M5c.&1@PcUM?NN;-CS.e/2TC
ff-T0HZ.-8KA7A2?_:WKJCJ._QR7Wf3?07Sc-02P:A6#F6[#02OBE4@PI@<D)4/+
-8I.0J]0gc-G&9?_6T-2C>N-.0=Q;6Lg61/X^<PR-FVM\:U4AAgKWJ78?50H[Ue@
,/b\P.^Kg2?KK/FI_SG..YC;U9>.59f(_]PQS=R)]<_gTQNETE(=\>EZF=:KY5T]
4E]J-^HcZQf\>+_Og)T<eP6gcc<gQ1&-Z:cZBOO)1SP)b?(#Z.LE(_IR+DZ4#:UV
:J,DH#+591I:M-_<<-VY6bce8^\O+]/\21X9):eCG:[V(3YX@6ZUHUEg^#PC?L^[
>Y+W8.]?9>:>R4#Q8Efa/,MKG[(KN3QaBP+K]eQP8B;#P&Z;@C5/#0&fc4ZVA9f;
TJ#04.+R9MdNb2:+4DI]gE2\64Y[>]\^3F&XJ3=@f\:F+Z9]L^I?CN9U^d/:-AQB
C;Nb=66#cN7&L(9P,eQ7.ac3RG]15K<5Z7Ue_e0]<bE5E.V/8MDQ@#1C-geF9YCE
02X:J+>T/0&T43@[2[PAWKgeZ\_HM_M\;IgS^[MI(2\9)7O/+\Ba><_<(R5SUUEM
\=AdAU53O)G77=(Fg<E@DP?ZS<c5P@LFT6+G;WA#:#QOeL@>3ASXP\TB(C=(HPL]
F3MRNHM;<&X?Z?8Z1RXBW0@]@LgZ#?5-Rc[\_2,X7SA>LYRB,#22SHJaD[>Q@HPA
76\1+-gB_/bd)&@+-0G?BZA>dVL7M@\1YGaHQgKF,CB/F0/)TJfABBcSSG&HFZgJ
2H&.Y2A6cM79;\UPI0c/2:VC\;-^UKT_VO9F3V^bN-@LLZWL/:5N-GeM#&0;LcQC
+Q(12Z)CZ1DLLFK0.B-0AY_J<gGAR)9]Z8-6fb?@VWNNPIQ@CP;,0OHT2Qa._W22
=AX#ZeAZI6B;-2?PUVA0-\_d^3Z;U@-ZcW-d;PI,9I5]G@GPFd:TXGLef@50J>QX
+,Mb@)&9KTVWX^ELe<G6c/WI)Q^6JHQ==NbKA(6bI_CU\)ZB>HX]9=FAKbCc=OIW
XO4/\RM@KcRU47(VYMI>dM/g>5;_DV2b^NXVTN6^H#0Tdg&T,a[DFAR#Y3Qc.dM.
Y#G&YAf3&?JT_QGJM[XNQBVSB\D#/B#ZU2RK5>3,KMON-Xd;UFed+8H\?aG/\#KL
U)L[3=+O<6fQS/#-&FT)cMI6YfD\ad;V4&)O\3^\Y=V3^,gSDCI;@+Te395XBDC:
cG5d3PgebNGbYHQbR_RRA9IEMH#@W#207TAIATYfI&2eJI[eDf0AMDL+D7T-1I&3
Ma3H>^9c6-EYJY.W1WeVQC_?-NH<=+NW_AY\gNbRX^^bC&OK1NEAd6HVcLZZOJ]=
;PQVH\KIZMF6=g775;VT6Ee#8Rf#;GU7(V5RCTa+c]B+3(3Q175B(08aF?B+1U6b
=aCGP1_V>-eZ9C08KD5-.N@F\?O(BTJH9NSUF28H_ATBQ=bO:B+GG-NdXdR<W8\@
D-[(3_[@T7(=gc\\?YE/6\<HVZ-&IM(BGWf15MK)Hbb]DKd?U\(T5GR](&<OgF.G
XD<K[06d987&#b;>Cfa22X53RV2;Y.1GQ0ESD_;?bLe?DZf98F71[edIdgM003bQ
D)HO1YK6A02[:;U;=[Tc,A+Y4A];db<&,9=[?U45RL>@c:9c_VBZ#<@=K52GOE9X
S6=KOYTE,/-M:NI&3@IPQa2YAJ.^KcR/U/ZX>]SN/?XAeGHL>g0g4Z1TGU],[G/V
1ddM;._YGg7[FIU]O-1Q,+\3S0gF=bS.U6<;e:^OI5?WB7Vbgg8A6-S/DZBLE]Mg
H>gbO&/(][?+6-A)KG6^T/Ic<EZ]fLZYTYK94\M-;2+QVK0;G+45E1;TO8UF-eMY
\V(6K+X9ZSGWJgT(9/GCdP]BL/]E+.A]Y]7D34;&DTN0Y]H\TPA##3TU)3M^Y:/M
CN8Ub:(<bW#5Z5:Hd6cZZ<,FEINE,QPXR]gRI,+ZS(adAFA6E-@OT7-65Q</._AS
9EeZ+-Jc\J=8KJRBRI=Ecd>0HSJ=L5#?c[\K08YL0GWe,g=K>&,X3DH@O14QL=g<
)DS<3F/&+aADT;d^,@c4bJ^LZ<cHb#)@:MD5S;1>JFCc8eM1\UF73AaWU4TdTKK]
#@F@N-V?_cWG5HOWbAecVe0GP9&;VW)B+ME93+^b3T?76Q\K.1HDE8<d_9A-E8MM
3&KH;e/Kb^ZQ;fZZ3>dP5faWG7>(_L).7=Z?VPG[BFe-=2[9AgEG7IAC/K+^dJ&.
3N,/)\AAJL9Q)$
`endprotected


`endif // GUARD_SVT_MEM_WORD_SV
