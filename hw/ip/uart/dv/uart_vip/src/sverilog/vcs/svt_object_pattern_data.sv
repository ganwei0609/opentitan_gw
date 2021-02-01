//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_OBJECT_PATTERN_DATA_SV
`define GUARD_SVT_OBJECT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair, where the value is
 * an `SVT_DATA_TYPE instance.
 */
class svt_object_pattern_data extends svt_compound_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** The object stored with this pattern data instance. */
  `SVT_DATA_TYPE obj;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_object_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param obj The pattern data object.
   *
   * @param array_ix Index associated with the object when the object is in an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   * 
   * @param owner Class name where the property is defined
   * 
   * @param display_control Controls whether the property should be displayed
   * in all RELEVANT display situations, or if it should only be displayed
   * in COMPLETE display situations.
   * 
   * @param display_how Controls whether this pattern is displayed, and if so
   * whether it should be displayed via reference or deep display.
   * 
   * @param ownership_how Indicates what type of relationship exists between this
   * object and the containing object, and therefore how the various operations
   * should function relative to this contained object.
   */
  extern function new(string name, `SVT_DATA_TYPE obj, int array_ix = 0, int positive_match = 1, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Extensible method for getting the compound contents.
   */
  extern virtual function void get_compound_contents(ref svt_pattern_data compound_contents[$]);

  // ---------------------------------------------------------------------------
  /**
   * Copies this pattern data instance.
   *
   * @param to Optional copy destination.
   *
   * @return The copy.
   */
  extern virtual function svt_pattern_data copy(svt_pattern_data to = null);
  
  // ---------------------------------------------------------------------------
  /**
   * Returns a simple string description of the pattern.
   *
   * @return The simple string description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
endclass
/** @endcond */

// =============================================================================

`protected
-A/2a0DcFS49WD^JUIXf-ID4?QDcLCc=+X+P2C#BN6V]7<OP=dET.)G-;8)]a5H:
;4:C7FdW[U[80#M>2g:TCY7VVY&WOKXH>Ac8PAg2-(IV.,KE5=OD/K.B6MZ@_@G+
=F;D:KNW#8F&/7:Z.g?^K&c,<c[+L1HVQdaBe-P5gR7e3F_UQ&3L@Wb>]Y[6_<gN
ORU]L)_O,:a>W;-NW@9,X.3/AM_g+eGS,aJTNB4R&]dT5FQbO1/U.7c;A(0O;7UL
#,I\V:9[C62OL+-f(Rb;KI0S_[]C=5R0)?W[([aI76/e[TMRU2+_J9PN^R?P^_6<
)g72YFA1,_UHXYObVNMBYbE(RB9\Eg>2^?+N9Vc4@A_/1HgLg:Cc1^2bV>R^_^D3
N1d,K71Y+\X?,:<Z>RQM[c?\d>BV59a._3B4FeQH.\fS6-=R88f3CIXD9E/^GCB>
Yc#Q/-\LBI^4Fd][<Z=RZR_;8G?3)VZ2&][c18>JW/:WcQcG.62((B0(C@6XN[);
;=[7)0L04L#a&aY9;8LaU_4XbHROM_TQ831]2Tc^W_2T1,_WPA2Y_JK8:1P&>GXW
1d/,^\U4:XY_621WT7:gbDCdGMQUEDaKg\29/KWfbO4)LEBEb12dAGEN5,3@\;N>
NCC8UgM&Z>9>[WG^UaHBJBAGPX&2W=<47cT-d;f-^66GC:FI2(<G\GJE-g/PKPfE
T.fB.Pb6Y)c.2IE/A#;Y@@,6L\3^&-7P:F?)U+dGW_F,:&d]+M>4NUY.#CZ@bB1K
Q?R/I=c@=M^HeO7<HD1F(?9SCW;WG58KK7HK?BLQCWZUI8N>J0IgYVR+RR5gH@B\
_AZ;a.,]L-3=?;/?5C3P23TN8.U9?T)8eH/60^D]_bW\I#.ASOMc2XI7:?@2AG8N
(L]RWB9X:??cdgVacL:J=Fb9e.&1LC8#_H.V25>?8[Wfg:.J,IU;/051:6NB#KaS
OV7G(L3<gMGWe=&7]2,YE25a6&P(+d+JF:O0W;5fMSb??5-3YM(RY6Z@A9EL#=8:
I;eKOCW5D.VT6+OQJ,#,d[N^3Y=(2c1+RSa@>91,^b6OZ9-(Q16S84]X(fXB1IQ=
D0JJX5-2,<SVL6@LeE?,;]Wa-,S/V\R-&VV2[AH>b2,<LQ-eH^S9?Ye1BLeQ:)OX
T3[I6beCB>(3PQ\S<dI55XX09CZ5-^=8&[UEH,eT<bcNC5;KU.?g>(2c.^.3BT^@
gYPZET+>KD)S(FY=J.#8?2&_4(5R(UU/,b@T,#EJ=eKU88M_ed>L@_(He]:V00B:
f]\GA?2-M9H2#4.;RODG=VEY1_f7/ISdf<3T/_#Z^?2TVJdC/7P64F5GH2ZK#F__
6TQ]L&[Pg)1JQ<2O:28&^HcK)T-2/AcZO+PPU<D9J;,IL?2Had]61RN</V.09gfW
>Q<gJ(bP]7H+eUUO[HbCK0MU+AQ_UM7PaYOG6[J=:=-V>U;bN\US[dQ@Z5X26)6c
,NLVOOTAFP-1MU<aTIJf]TYJGb52B23A#UAcbCT6&/JFK4[+(:M&f5I:&E[9CeBC
(&FOBg-H-Sf-HNDW#&)_?6YH/a#2^9[DS:D#WWB-3D8ZXAP^18fW>/N4c?IX3>\2
1&N+J&:<:3gCO@GP?IGY=JgZ?DgT6ASPe_2=,]KXFQ\^4I^^#Q\:/7[A:LJ7.:LQ
R^P9We&PULcDPL\a2cB4=+1^8@cKH\PKO5@;2L2Ha^NTEXeGJ,VAC=--a76(VBE2
OAb+HN?ZV]#/_M0KDCXAa;W&4V9+:;&XF[Vd,2UVJ5Q:0E\G+\MG]W)[7:-Qe+I/
BUHVed955V8N?7555DF^g:F>^MJ[H706]NBT+(=<eYY:g>SL7VTWC:YB&1-WIg4W
1XOU[Y<e35?@N[?V1EQ5JLT;db[1#5N]U1=@>,3)J\<-]&ML-P&6]>bD&Q^ZScJ2
?BYZV/T?L56@3TZf.+8<)\UH[VIKc0<.#?R+27V._-N6NKB,fFcL;,ID5BD_0Fe2
RS.5AQ3I:L)2PLX^9]9,P>Tac+[=;aV0[A)NN[b7?e/(\;6D]F_3eS^R8\F</(/F
89@&DAG1g5=g,UPC<1.HC[^6aR[<;0)//+)fLK^P^3XLb.JYY2A#\2NFD)1S9DbN
D)BeQ]XCTJG^Ne18UdeWO&+BBJLNHP8MLWRM?]NUP_Mg25M3XZ1DOG-)#OF_a+K?
D0>#5/T:UVEO-D3SGNLM@+ZXEJ,\O\W)J#SN@7bP+41P=#@>@DDEI1MKJb1f;&3d
(B2H&_0>.NB+=c>FOP@];0./;R,RddE2FbXA;f)>YdFTTM08(LIKG2e1?T^MK2T>
gNEd5OcTAHXNA&B7VIXF..8Z__V.YSTNC+dMB>QaB_,.2;1]V-X\WQe1K$
`endprotected


`endif // GUARD_SVT_OBJECT_PATTERN_DATA_SV
