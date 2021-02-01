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

`ifndef GUARD_SVT_DATA_FSDB_WRITER_SV
`define GUARD_SVT_DATA_FSDB_WRITER_SV

/** @cond PRIVATE */

/**
 * Utility class to write data values out to FSDB.  This base class writes
 * values to an FSDB file.  All values are stored as strings to simplify
 * the read back operation.
 */
class svt_data_fsdb_writer extends svt_data_writer;

  /** VIP writer instance to use to record the data */
  svt_vip_writer writer;

  /** Unique object identifier to associate the data with */
  string uid;

  /** Singleton handle */
  static local svt_data_fsdb_writer m_inst = new();

  // ---------------------------------------------------------------------------
  /** Constructor */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_data_fsdb_writer singleton instance
   */
  extern static function svt_data_fsdb_writer get();

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val Bit value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_bit(string prefix, string prop_name, bit prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val INT value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_int(string prefix, string prop_name, int prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val String value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_string(string prefix, string prop_name, string prop_val);

endclass: svt_data_fsdb_writer

/** @endcond */

`protected
Jd7G4>eIG&N]d0KfH89GT3C-3OZRYA:\S-->&O20F/?(=KPM7YK34)(PT97#,WC<
0@=:#55P4U4LIDK.cSPP_eN8>#7,HJ\YR29D0a)XUJ[T1eO4WFEY,M^GR_.79]VY
(4<fDTDG0PP1/#ZHD1]SRWYE.M\&>1=6;ZaGc[gIG\)VRV]V:248\F)\NE)HX=TG
)>;>fe]JEK?IJa7GLfIf&()SN?\:^4Q,M7W]R--\:IND6)9G3+:I16c8S[NLEg\4
;<[.-dN:6U7&e>UY9SJRYNAXfD5V)WcZ1LbXVK7;.#NTdNfgZ9c)V@2.8bfQ;TH,
2ZgaWZH,Q^bAdYd-F<=;,MG,9R69aOGCQCBNLNI90O<X,ZP6?#\=.SVI9LeeKaC@
I3-#&bM+WfZD+ER]\?-b=OdS7SfM#8141<PfT]E2eOW>Y>5J6GB&e3OQf=0cTH3c
BK&@Y,/)YV\C800\DI;860U/H,)2O0DA&]\]X79P8MfU<H3[VYR-H(U_H]TBKKE=
51T7EXK<A79:1C?#PVLZMF=#613)@VAJg(9)g,LX_U/WPf&+_13LAbH:R-S8fVY@
LOYNIY_70fT,W0_dUH#7Je?Bg2W0.;eXRLG:<;5Rb\0YU]0^6>Cf.;BB=A:d=.(1
a?#8)<V9JK_X4NP+IRa;O/3[]=P5HKN58ODEM[Z]&#_WUF>BD@17dea@F?RE?M<:
BDf<ZdX6gd:=GX)d@#(<>#/0?&L?V^f#+C;M)3[c,Y0W0NS&YQW^O1)b^A3?=D0H
+-,@0J<X0Lf12+3)aPbEDLXS,OAfDZ-c-W.L.V^/H1=D/=\M/7C)LZg13\OSTWY-
]JJN3bA4C&C(+AeL-B-532de(_b8T/XS>TGL6H9L-EAa,eHFHfVJgB\gN@0SZ2WR
PLUQ7Dg;3M]dQFAXAfGH.>>U+Q;MB&U-<cHP=]1G1M+(cE0N[^E@fZ.>eQg03D.7
PQdRLGV#cT[4a^a=<@8HH2RdGJV+RbLOMK6acZcdIEIIK/Z]fcNC[J5#UMeaWDU[
VRAb\,c4.=)H3DTcH(P3761)PL\U48ae=ELWJ/;]dbb(35&UQdN^-7F<eM9eVG&?
dA,B#a8Hg^ga1L#)>L.aLFa)5:._c=/=eH5d6?-a0HBfHSDIV3OeB/O;aW0dBcb6
Y0R>1FZ,aR-VAWB[Mg4dUM8]/;^^9bJE[WFHL]9FOS@1e?gC&]A4P.e7-1C)T?W#
SdS+_(Y?Z5B^OZ,->d[PfH+J8DHW,E(>B5H0>43ZgE>4=/DQ[@+-8B,f=;P>7a6?
TH_+\#PUObW<20&SP3?A3#^CdUBPSSd8//]939)@aLagOf<83#Z>YQ)W9=DISZ?I
(QZ3JMd6X:.22eRIQGX.IN.964d7-G2UWd(?=KY8)T-[PMNXG;Ce=4-Ocff5^>cZ
AHeL7,Dg/@;R<V\(f1V&,FLH:K>LZ,A^LU?WI,CM;I@#1e0^CARX8@90XW)_UL>0
JcSPY-IBa11X\AWU-cc]>Le/4O68E)XWcW&X:,>1g:8)AKKU<V2B>LfEafP@HX^.
UJf_&Sf1?S87d7]JD9G5W37J<Z.\7(.;L81]-#\\\A)P4]M/[\[&7.OXP(PBNVVA
DX(ECSDS0;6bGXWgfYEO+SP;Oa/H+WGC=$
`endprotected


`endif // GUARD_SVT_DATA_FSDB_WRITER_SV