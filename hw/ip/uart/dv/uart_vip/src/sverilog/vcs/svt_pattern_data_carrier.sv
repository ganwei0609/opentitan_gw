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

`ifndef GUARD_SVT_PATTERN_DATA_CARRIER_SV
`define GUARD_SVT_PATTERN_DATA_CARRIER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_pattern_data carrier is used to gather up properties so that they can
 * be acted upon as a group. 
 */
class svt_pattern_data_carrier extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The properties which have been stored in the carrier. */
  svt_pattern_data contents[$];

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(vmm_log log = null, svt_pattern_data::create_struct field_desc[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param name Instance name for this object
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(string name = "svt_pattern_data_carrier_inst", svt_pattern_data::create_struct field_desc[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_pattern_data_carrier)
  `svt_data_member_end(svt_pattern_data_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method allows clients to assign an object to a single named property included
   * in the carrier's contents.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_obj The object to assign to the property, expressed as `SVT_DATA_TYPE instance.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_object(string prop_name, `SVT_DATA_TYPE prop_obj, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Since for do_allocate_pattern this class simply returns its own contents
   * field the expectation is that this will be processing a pattern made up of the
   * original carrier contents. Implying that it already has the values.
   *
   * If a simple check validates this to be the case, this method basically just
   * returns as the values are already contained in contents.
   *
   * If the check indicates there are differences with contents then this
   * implementation simply calls the super to let it load up the values.
   *
   * @param pttrn Pattern to be loaded from the data object.
   *
   * @return Success (1) or failure (0) of the get operation.
   */
  extern virtual function bit get_prop_val_via_pattern(ref svt_pattern pttrn);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple new name/value pairs to the current set of name/value pairs
   * included in the pattern.
   *
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern virtual function void add_multiple_props(svt_pattern_data::create_struct field_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string prop_name, string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data on an individual property.
   *
   * @param prop_name Name of the property to be accessed.
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string prop_name, string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string prop_name, string name, string value);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
9+aL.dIf)RA4U-UOQ9?aT,8VQZ]IG(PGf.XB4f@aa2Y>-B+2Y[@>+(BgZaS?[YVN
/ND#R-,K-SWG-M.H:K&FOQRPU5F+X)WUe57(D<ea/.ba/4EA1+E+<?]PXOB,&eX-
DKD6DZ.IS8N01eDOO6,>;HU_H-LG+W<1d^PV@eF)Z8E>D>X3?L\F;]93AS@)8-\=
CWHS\]RAZ/;aa.\9G/Gd.f@IS?EN7THTXAB.]T6<#L0[6)-X;<N_?HV>g1V/.R84
;/+(0-<T6A,@-f_[2>J3TgYa?S&/AYF9db9W_)H@M1Od#3R:SW+,V-(P2gNON^XY
XZ-/06KTd+NF>F6@F3?IQ+QgL_4QRGV(NU_HGQ0+aeJN[6/E;d#G5(]\(6H.<,Z^
8TFd-T)I(3]7#>WBSH3JUfX<3/Jd3)5EP6\&#1:3>.:8E-QBT;6I?bXVc57^/9^3
:LA55XNI=GUd^G2L9\_/7^K,b.=VHM[5eSBB(/2)]O/)<R2?_I=XEWbFHV?RX,_U
.eU>11/#@OV\9^2STS#8Q.V/HE.:/b01d^,ZJ7GBK2T_?47W707[)Z.T#0(#-\8-
dMA-IB@DEUcTMYJ3BLSB98VO7P@U7[1;)_:RZ8T.d[PG4C;Pg.J)D_;X0T78.P),
H>.(=_3<7Q5=J=YW6<5Hd6S#L;0d;0(Af<\d]1\(;,UgdLWY6=Ze,:WE_g[6O-KL
f.+I[COTYDV_V?ed4bMF>,:>8+K--CMe#PO7dWNfKV329#\Fae,IE?RGJ8f_3CAc
WdgR8T_g6_X-O17<.d&VYZ/[4,S>@:384VNf<O7UX&7H#7AM?7M2XK^E>Ugd35;A
X.\C9Q+;2gb\;)B-MM]0;/EELVc/+1LeS7Y@3gC9_X9=)).W8L0de<d:D[Ca&L/A
G23<WB-M8:CdBG8/,I/E_\0d4<Y@LOU2.bBXSeM&Z;F8;@D4K2)[N;e+H2SNOd;:
,)\:#GIVgQW+:J><K7IGCC(]JUV:_>^a\;S1RNAEbg16/:S<TdI-e1(E8Vf(+GM\
I@44Z]0/7XW_TeFH+2SA.=VPfYVX+ZJ2QRF5-U?E>_J0_@K.cNI,gU5(UGAI)V;S
=]VO]+Y6/e16IfRN:S,#FZZ0<8T>.Pf[NDK.G+C.-dgD#dY5?eQ+Q#_dA7]aRcKV
>NJ.VJA7)Pa[Y^2ed=Vdb1#;(&/?-<4TG78X#+.R#^D+L6V1QbDW&R3365W/VXCT
cJd)7PF2GS_(J8gANL7.4U<4FRRLHDZcIP1ND]P.PNT_f&NeYT0=.e\4C]=aFS<T
[;3RePRDUJKd#>@gITA:dd)5bV\9>=;Q[P(fd-Ha\T<OY]OFE;@LNF15&5F?VS2T
4VORM@7N/2A#?PVR:2^@@@/Y+ba)CI(P)gUe3./Ze_H_YGA);@?/-H8;Z]?>+[;C
LT7F7ScMW0_(Qb2&6QPI/9D+8e70X5.d)#R[egIMPbN4J2.X-dL\,0a[E,=\5>C7
+bRIO]NeC7?4-Ha)dHg&9,M.eTF6@YZfH5^-(DC6;AOD6^C&5.Q#>I5aURQW-VU#
1EUZf&(?b?NTI1>fQN-\EM^Y8GW03Eff.V3TER7-ETAB)53YO2M6aM)eT-f(3@&6
DT9^.K.N0CY4C95?<;5J6\+MI6NO34T6[-MSRT:^dY=7aeW:>YF&(JAL+C3NKO?;
D#.]D<8dRR<W749b)Of)E48IZ^e9T,fOd+-BB5VXF8C^dT[O#1ZA:NZP&>e9Oc[W
bB31(N-HU7:egd@45[fV0M:SB@a4MPSUb9V3QT@8fT^.K5H\(//WTEZJ>bHOV[7Y
=5,Z^7aeV7M:R;S54#C_BH2?08/.Z@M1V,O,e.&;AAQ&V]3EZ>]\FNTY62X5e)d^
WA:;=;4+4(cR=95R<J2PT5+LE76_Qfe?;EDR8(Re36a+?&aEF6>Y575B;PbCY0,Q
c@:C>NAHW1ee8OV<[e?G,NdI7I5BHWA;/8cSV#]LX,[3>dMC+VCSLQ6g0gc,JP^/
Je#-,\Ee=-H8X@2-:]JEZT_6+Q3VVSV(.[MaR@T5;?Y1MTSbZ)EadO1,g46ee]YO
#P8J=Xe;35^X_O(Pg3G)(YXBPbf<c+U^Ld8,8<(;Z326&d^QZ,T8EG5d;;5?N[UA
PGcNb&GZ(N@VCJee^XC@8QF7ZF&E_9,a,0IN@RGHH)_c>;eWaRGNU.UI0eZU]S84
4]UQ^1N#.G#Qa;?01.2AN.+&\S[H0MS-+KAN3#/b4(bM1RPCQ]U,WG#,XF)G7>S4
/_N_[/3[)b4(NS>/P4fTXRU?Y6&0?XC:d7L_7YOW59@.E?Oe20dEUa-154/98859
-BS3aPU9B=aPOL_EX[MR(0NMCN<faYSQB]1<Z:b1-IGE\M:5,g/2_\...#JHHW@\
;IcB8eX51eBHeUVe.PC@=Me?7GY:e3&1-+7f&LLYID268aDS0SHY=6V694ELGYF?
b\.]^BE+C8ZQa1^BV9H5[Z]J@EJgU+Y<45;A;)IA.SC=7\9aVQWdTX<J6#dZY-1(
-\C/W6#1:R^K3TREAJ<e^K6=U?bZJOE4\CI-A([0RUA+Z)6GW^_@[EVF3UPBAN)<
Y<60-Pf,HcO,Q;YZgVRb>;>/(WCWbHKS=Bcc;5CdJC&Y1+d7G(20W<-<+N.EB.QL
/e+MM#f6&+]e=7&6(4B>L])R+eD&LffLL,Zc:D6.NXDEKHF>#8abcW[f\dI2(WcL
I?HIM@b5YAHR5?]IfAN>eeO\,+ZOc9[-^]gbFaXPKG-I72BR<[K&cgQB<Kd]UX[B
W[94RN:eIK@;C>^P]AZ45QYd?H3R(a7_II)^>KD8>,Q-:bGdO7(?W?fKcLF>=Fb+
;H&DWAD@FML(ONWSXc)Md>\LLfNBNQW_g4R0X9aD(KfC?@A/1f?#/WMA<8A/MMFM
?<[K.dTV1Nb6XIf:)#4KG/9X#f7aYegQ1f(fAB/CReP.@U:)fM@EQdd)-b<(aQ&H
,7d0.CWg4[0^Z@A+gPB2;]eeg.Bf@1YZe85E4Z.@W;4=W_&bC1M9)=d,85>CeO5=
e[\8PUGWC(K)KNO2.eOV/aaWL=VEfFWO7I02H=M[.3>C@dUX23/MVI;V&b])(TX-
Od(UcGeU4aYV0W5H2;Vcg:be?&P>&KT/7^FF=aC.SH:+,)2L]0\e4)8eECCB^gUD
TXKK0d]#\P?d#(bI+D#LdEb#F(]Ag]Z@RFRc6SUF]fG]^>C27>Z>@e^@X>ea?Edf
JO?JA+?L[/=/,\:BQCWHEON49_JO/(d&Lb\@1=0HRDPV?N-@Q]+@_TLeQ0N,S>]b
CKI#OI/gEJ3JW23W0^8Ca;,Y4_Bg^QcGTX([)b.68\bB)?,MW?H:^c2;W<+Ycd)A
>)a7PG^5N^A1Y8U=?1&L/:b\5eZTS9S3F&c1f+>#&&_KL))EX5(:f=+<^ROc):[g
^L10PMG:A4f^a@0F+.X5HDeJM8b42+96EJ_7JQ,dD&M<[Ebe&e-(GL@^I2=)DF;U
FLN=bEK59P5DW)G&8_2&)YBW7aM)Pf(-=8)L[?Pc6IZSW422,/-W_(H\07PaLD&@
]WU7f(d&BZC]/_VMK1#HH&52,:Af7Ic=RE^VY_0YW#;If[Ze_@MHcFWfT&dSc55F
J>eI3)^5=3OKdMB(@/7e7g<F<S.?N6_d.?2F34KSP[2O-J)(/6&eFVb8g8;_gU9,
C^:\P]61US5NAU7e&Ig0I5\(M5-@/QE)g1^9:/b>W(T\&#^IQ>cNBJ/c?B@g#^P_
Ra_<YD1MJN6aZ,&)IYT2E(4U;7,-BWJ3I?XJ4/f<>)+Qe6]3W\T#V0A.e8H9SUP6
7&JDdG+WAI[X1Nc3)adU5c;[Z#A6eD@XRO2B_OcK(RDRP_HbTPR.-,Z/))&P-J[b
>U[dG#UU&1YYZg3^M+b)TE+YW.@HN-ZEZ+\(Cc/Y^b0[><9XRbCP-M07bDcI]T--
a9]^R-Wa+L76V]JfU9A2@fbZ+cGA(DaJ-;?#FZ9@0ZQ-M2_<X6G3-.KU[&=Y)SbM
(1&@aR;f0d6U0\_>f-+;3L;?XOfL^@EaC.J&B+GE&UU[UTOO6d8?X195+?=.=8;F
78P5F>a?g=9Re45Z62T#^FK=FW[,1YLVFFU?<aL:U>DDTF?TU0#g>eE:f34<,<BL
>Xg\fITXMTbP\@^XfV&D1IdA&2:M?)eTA#^?b0g4/L36.[V51U5H:;MG?GY/G09>
U4gO<,L==\4W/B4fW7JJ=&)BP6&@J\I4;.g9OXLB-@IYe<:#/OIC[;[)Le9-(H7:
]^H\a[USM:Qc-6^d_S.F.Lb,6V-F^0KgL9TP(3JO8YTN.cK:,E^gb.XGGMC8[+SA
H;8LV)A9HUN=MdaKc8VCZUaD1GbF8,-,^g@>5g0Vc=4@10OB\^<NU_)__.BD8_#A
:]Re473&dD\,,8M=1+14N^PB9ZDEdLJK]+QD_UgY[Me<W[8ZaWVC\CbTMZ\T[,[8
/(M6)aX4KXO3,FLVK<I\D_85>b#DK0KMQH[T/dZ#)A(MAEL)dW1XF:)&+O+ULgfB
+;Y5?>JVQ.);dMU6[&U99/:HcM(D>NF/U]#g#IQ)Nb@5OJPSYK@BRU[I(/Vc=Lc-
[LMfa)TgafY7=9,51;KS<1O7T01^TVWB9+S]f9L)FRT#UcD?ISg4eFE=(#>BVYPf
@WRKF#XYX=E8#gc)1H@[WYI0?71c#:LR]T,1N)c1([O&:5A#3(,9M_g4Q67Q7dKb
cL^[@Ee2/8JbT18]e8ZWN?C_e=g+,(+.>48HIXY&0_YQ53<)),]&Ab.DA43bMP@#
g&</:1[]@g<N(BeEOM8,QP?7:OY/ZM,WWHAH3\J^T28LH28(<U5eZT&LZDI1^+F[
gS8-+TYKI5EJ5eE&+?>K5Z)PS7YT8-EeT^P.JRG\5(e.M=@.YM&(LHD>=#aA^EZ[
56_FI?L4VB(TfgP.]#\]QA8W[b(f9VA_fZ6=]IDfGT]Jf:_S89V;eVPM.Q1J0NE^
@c5-\S7.;N>bR0fH-:71F_>g^)@f)Q5[Y)RS\H.[;L(W&9G3I=,_J>HdL)_Tb\58
0D6E0IM&[bI-E40W8bRVB_[_-WfeR^J-Ag\F1\2P]aAAB>UQgbb#Na[27fdMfG=W
MY>[BD<Y@#ZDN^9]J;gfPTb.DD.f+dV<BcGMS44g;[LJ1<ICK?[-.;,_IY#)N+ga
Y,GQ)Y6P/CdF8_EEJ/;0dLXTPDeE7X7ABIg1MF.KF,;G&;CNF@UfcQf)3RbX^<Q#
146AF0Y\BaVO6;<P_dAfg?U^N&9,NA,K?MaG\.bJa_JcS<DU>>-7efG(=O)f.;+]
//ef2cAVQdRAc+H?WD7FEW:AAW,/+;8MeOTVVa(+\XCZc.aSDaH@B/aQ;>J&Yf>e
Y0cX(D5N&@&WOAFP2G:P0:+-4/a)4a@-BZ,@TF;\RDaGG:e2ed]^WR#bb[[L9T4c
55D-/8WRLdQf?/0(S(6&c7=<Ec:Y=-R9D-B<<0SNfb0dLJ\B_Y><;e^KU_+/ab]D
?Y>-6ZGFU,[,^UW_g_)HN@A+=VJO(^See\PRRdH#c5XAB15-&GBV]3:-3TNeQgeD
JGM^bJQKDPBOOLB\Y]8=3A423R&BSS;(AKX2Og\fIfIF>g4cdcXH37GDN_]WSTS^
[^=+Y/4XNEcbMbTSb9<f2N+>\;KAWeTR<He[1I]^=19fe)Y\PFPB<d0gD^a3UG^f
1;:NS/GI[[])IQH9S(3_ZD#[@=@CgH:c>KOF)d6eG<@d6?4aSCT@#?AJU:@B[R=8
#MX5S9eT6Lb/ZKQ6gX^+6]_Q:>/<:_>XT.@SE6@_/-X?#]Q+=+f8JKdR5O4/2T,7
gLX#5W=X[MQLg[78.G)GZf(M=BJSSSA]L99CF[7N?LO8De@d;7BP/>;2>E\cVSJH
1fF1g;99IMQ?b9E:QbJ=bG5Ef[bAT-b7(08RGR0H31\VCaA)S#>aa#bT+IJGYJ46
3AQE01c2J9[9gH,a^.PH@8RFKJ;0cbQ30TSV6dZGg?B(b+^@,W,^Le:4Cg]eDA=>
c1A85(KL^09^C3PV8RaB7(cL:Se=#VU1T=A4(a-aKEMVTAA&]e\.G_0Hb>F<COad
)9#(RA&=<-S?+?Ub78S<([Ua\N&SdONZ.IC.VU2LK1Z@@HTP;D<]+U&KR@EOI2&]
/QT0(BXX[RCb?La#6cGQJOO>P#K#)IA<2FVV2(K[&69RY@(NP_<G7PA^,I[JJ]_5
@II7Z0GL3fBLfNY&YYIHM5O703d<@<)&ZBYQNa3cNVGYa#3++eOTDUSU=RF)LWfd
^:IPI8JV+-M2;M_/5746Fd>7W.Tc/>S,2c1)66N=4&&(2>M5[>+LH?eZ\S=H/QfP
EDJT8^7U/Q(D(MH3UM,PIF49QC9WUB56)2Oc0GeSc48#OK\HZF[3C.U,UgbHNFPL
O2#/P2b#7,gV@2AJN-b9#8d+GgC61@SE/^P?IEXB8>D_#8=Q[VK2EOII^gfB49b>
+/-O6-+N&Z\#R3TGB7P:GdL_(K@fc/6<7)SC(&V[Z<,d;]F56M]+d/.0)TF^SZ-Z
NK@69961b;Se8W5DT\]N,GV,+]C,P<I9c)?Y00[ag3]4\PR^V9ZST[8dP/&(4JIV
Z,V_(,J,4XQ7S]FQK+2M+A#:H7H#Y2FLT_6<fL@5G(NU&2RM.eD-29Y@2,XeC+N;
&eAL\-W3D9g7NPE9ZLf(,<[e+<VReQ1=dPe5)I0dNZU-2_X:U;YJ<6DO18X[;?K;
G9ON[0Z<FKdac6K6?&2VF^G?<==B9E;J6dFA(@SdF)?fB5>KT1H?_?DN4_4N+VUF
Ma/A+@?5V(d]0,_KK@C-6KGXB2CO-#+T]?4+V^^:g)C-WNDOZGH8PH;H],A7[E][
a/]I]>Jb0H0GG:4d_g(U:E^T7TC8EeHN/N8[:E49c(#OTZ[\7XKW9;a6f>8gdU(e
8b[H\XY^&A?4==A@&FCBe?.M6PNZ;;Q[9VZ_0V&\O:?H[VH4\2-.U[H@W:[O7^)Z
(_#HHMTW]/C;5/@(A7H4#?H?)J3289GXS#;/7.<0fDA2GG2ZY27RA2+1U<3fKH+?
^.a#IL]LB]WZ:;C&A6+aK#51/3=;5T(^5^3I.Y7_Jc6J4b1B6,TPX;0]IT7T1O<F
4aLP;A/eaPUD>T#(CC(F6aWf^?J[ag9GQc4\@Yd6PLgJ-E:UX/H+B5dH[QHf-cOT
F;A<LD4VKWTb5MO:M)Ja<W-97@4RL=&BLV@Y5Bf@WFYAQY3fW=_Sa#OffVfC71HW
Xf/RXf6)<Cd,O2#6KTZG.O.Y-bFG/E<=>O:Iec2e&2#dS16J4fGI_+6UG75Ga)K;
.5FP5><K<R)Q=@//UBQ,Ya_1^J3JCNC-R)>?:RPd.97;2B7]BR1?U+W=>/]Z?<_5
\N&[GX9TKSbNN)EKe=)1[0Ke8G.(ZcPTeZO1)#]6N[R00&d>OQe:;^</@Egc=_cM
-P+,V;6E<W8d=T?YA@^2/OZda2=H(XW+9<<G,Q9:#?3<=0,8AW#<fHdNH_^-?8;V
]b]@XSf(cHJH&L,K;aO^B8b\U2@J=P_=Z,dFcCA;L;Pc7QKfE;;281#-,4>V8<:D
UfF0J@3CO+cS4N]M3eW3dF(4_WKO)+5KB^T&Ue+-ZBHMW5XJc3/>I#=7(RUE+e3:
D2UdMSU(W=3Y)N+#?76WAXAWEY>P?N8DTH8KG:EQEgW4=_9L&F,U@:;7XC/e[G&_
,K(RB3^(XbXg:HKAc<YQ:3N]Y;9CM1TG@>_b=3@bW-G+b6gO26/&Q&6\H&IWCf?6
ES-&CRg\&Dc-#4^;5F[P-1\6]V@dO75)5H8V6GYG1-04P];>Sg>Tg@17HfdI]ZQ+
VY/VM:6[FPa2BEfDJ?NP7P@C;:U7QGHO00aOB_TC1;B,5+\1O.ROgGBDAF]MJf&e
.B?]9NKLgJ7_=/T,7A#KQC2_]6OMT.1:.D[]9R)>.)C<aaV?85<C+L]AdBU0I0D0
Eb\A\A@-3c>XGcaP9U@;3T-Fa6)?O=:=EA^dAZd+HPXL=e7?G)@TCCON=+]7b:(+
#5;V)0=7fVH_d90IYF2PJO:#T;R/33af,Y3@8GP<2F/C.d_K<@\Y0#ET&TI,T113
3I9-&R(aX6BRX>O<EGEV(KUTQ1^)<<JYH]MW&eI\11ZJ/bT6M_4)D1cW=U/X#=]c
_VB3T5,M39:)D3R1c9(GRcBaZ8G:;bP,&(@.DPJX-H&W5gBL#VUCIX8D5YVO^@^?
\fgBaI:B<d)<^,7G?\(Tf;2?,AS]4N#facQ-J^gc/B[bY[81#S[>M.JbZNI1G=K6
=F@761?JMfV<2B7fDJ(c6I6e^KG/<EH4WV/&U3(5gG,F2(O+ffHfab\b4QS3_AS(
BdQIg>R&g+06caFMC/Ug<WY0H/W&/.CQ=@BSa[#V8TW9dGg:WJ\_L<;e=Y[X6CD)
2dB^?Ig+U(.CSSQV7\J1K78I/b0O5PW);LOD7R]7NG66E1E\Z0?G962ID=8/<?GB
S=G>&79d?TKRAe(W>)=VE)DFNKa#2ReQd;Eg=a:/>#TNZ_NE&V_2I5cb1DS]#VL9
\JL790453-YV;?^N#fbYTeWORI(>90^CbId+(fZ.#SWU[g;KIUO(bPAYGdW2?E?0
PEE/2g:M^QB/K;WJUS1.FFH[Z-AAOVFL\86K=3>OZ7.Sb]D@;GY,f2\VYcE@_D]E
\)FfC308T,N;FLA0::X<@U-9;e#HQ,<[5W\f@[CQc6&V)P^CTL/<<]+P)/UOA)X8
56;Nd(3B3b4I?>HE[a)=_,ZY=,>NQMN(#>P:LAJ3Lg:XNaGXA6EVAb)XJ[a],E?3
cR]]G]a,:.)#QE#-b4>Q3M0=Rc6&_WfSC;Ra7/_2/?9EMcSPNQ4Q:aX,&:;N\,\d
aa1J5Db+\:]dMTK2.W\[PH71LW4c?T]KHb@6=0d;8@9Z0gZc(b3:6F+e2>#QbW<N
)[6_&+^5J_(d7GY<+a#WL17^YF6&2X(:c1359&:,1Za.P(fbG<I7dVI,D[3GW:Uc
\/R[Td?b7]6TgU3<E5L+R?U<I3b;PIceP:6>TQHLdAf9,XL^EDRXB[?5bQLf:5,Y
=OT4+].?a][[d_3.78TTf><9^0OcdX&cgG-355=-1EA\([>dO9+H<BgKRW1\_&1_
:dd[;dca72_SJ/+Hbe:RXKO)/Fa380)Q3M:MYWWE5feR<ZZA]_53EB\A^@9J-26&
3(O>.R6b&6B(U2=Z:TU.cER0Pg)_9K_(AP.4O6EW,#?=2:D:=dg5,9P94@O7Ta#f
/=U]_/2bb#SWVLe4OJF,YDa5B[IS>UOEEOa--<@MGg6@_dTeB9[g+BM66<0Y>5Fc
HW30/P2V&U)V=PXB=[9I3bQ::T1JM?-)DA>DA+J(N;IGdWZ0)ab\aN//AWLd&CP:
X7Na^9>fQcJE?VM#a?:WN:1TUgCceYW9gWA:Gb.DTGSRR-?5HPCLNXNe2/3<GSF^
67_[7_/G.OZH0G2QC+D)P6D].1OM4?^,[TFI)S7U_S>&G68DGMO]g98a;_,#,FA^
(GDT/(UXEgT.e=4@5,M_23];8Td@8D(;b6W_aRF[.OH=98@5IC0_+[B_XB,#5(X/
E30THY6[TR_GAL7N\d\NU?21WABI)5/VBPaTd3L,]g&V]N=9Q-?1Wa&6gKfQO0JI
g7bLNLa?\]A#egE7BG9L.53?IbH+3@-;N7<bZcLBJBJA@QUWN/[LX[(^1IZJ.G7;
>O:@4DPW\]Y?E2OP2+c-\ZI+>E^(d,ZGI;]_)D7R3e7.>8Q:H8X_4X+e0)[&ITC9
Ug9BX=ag<<9E<SY8G(Q2;4I#U5:MH2dc(TG(?(fY?)&d?gGDE-&gNI_CSd,MF;5U
S.Fa&#FLKUMJf)]P<)V-ef)OB#=XFNMYOPL69X+IJ;D6TN-VG8g3?>1DcK#U7SO]
f_-dSgC/)M_1X^H.,=?=DF=I#:Z@R<2BZG_Cd0/9GfMMdY9\+1Bb#8>NW:=?f>#a
+YWX(]@EFC8-+H7?QKZ>TW@bC)1K_S5W3S-ZcLaMA2,&H91Wa]@@WPFNAU>da2/?
RK^cLUP?Td120db/@&G0D>,)D,4&9=R;.^2UOa34KEHF+^R^Ue[Y9)1fO9T?+#UW
H5AG^b.TGBZ[4_CYJWXPMJE=;cZfXP2T50.@-/UKZ##>^)M/eG:++(&;9UV(Q,,f
bFQ4Yc^PdaD057CDCQX\a]B__IVM3WbR>6^GR>ZIP.[3E6P==CL_DGMV,.,6@)5Z
UZg&1WNH[<0WKCL(0BM72OIRIDbIa?6&[S@2LRN9Va0?Ofc,)=0O;#)5.RgQOg1D
IH/>U&NR,1a)O_)M10/UE:[g15?-P3N>8+fO/fDTM[BDVO1]I@H5dcD/PWe\[1H^
UO[:HBb:SUR=(]M\@>3VdfMEb\Q=@:eTYC8Gg:60Ad5IM25&&1;>706_@-YIeX(Z
FP7NDVC4TZdTB;V[9#CdXV5&WY\UW]KM=S&3[O^KQZ5JcE]BN?HI>?75YId9MQaN
^(R15&G4Bc/e)eRMA6)OZ;K\P8@SVV.AUE-/a7]@<bZL(5c5/3-c\;Sb99-DZ?Wd
>Rd8cOO<KY^eQJ420UYgD:0.#gO;aC.+g3f]F[11N,YHFc=g,J_d#77N7B/W&^W7
3:)e#D,+@V=0,ddd@A5XLTB657XAAB/G\Z>[+9.?>#8NSd\.QUHXZ6fE^MKH/_D@
e@f#8]84,&&8,.Y^APR;a;0XGN&,)-)4_<Y.6b+P3JOX8RZ0X&=Q9_G=Df)Q3AFE
CW7FeFQ<E;c4,K:NWV;R-V20.[,\dVB=G[Yg\4Td_=@&ZPZ;L(<2UMgHQgZKV.g)
-@2RfF+BP,3;[=S4O?f5#a.1X(NIRc?0Z;T;SV6G@FHA_][@1Rc?W_21W=1V?_T8
R(9C]5ZQZ7/:WT@0)b_(Q?aN=33UHD>NEOW=1NOTJ+\78<,0R6b[PQN@+^:>gB5,
e]JUZ\Q:^4Ff<<6S+]L&-MFIf3dUaa_>(ZfZULBJ.=CYRKdMd6XAe72T-PTcKa8Y
eK9+agLQVNbfQ/_M5ff?@OL\:/W=48XJSG;S;7BZFB45.6U?Sd03=OV3a=ON(32B
MJQIA+P4P<KV<#gK=[.M[Ae)[M2^S_0PJ<1+Zg=2cB0]QaK]b#d9^\(dI^8U@F^7
](4aEgWP?5?V4BX@XR/R_&2P89+ef&4_HEFRDIE2dDFB<:7<#P5HAY;=>gU10K5Q
PJF+@O(PK#OJ49,f1AXTI6@362XM@&4(8V9<<PAWTQg5B8XLZc0([TPa>CZ_f):C
B]TJN+XV:.eXLJENI90b#dBV(-.aO3VV<X@?A:a).PU\WQe_Ca3U[K:T0.32POPZ
&OSCT8PN&8)?G7+9VE<FSS7<@^fI,/E?M?@f;N[T_F]9=_0_AOC[16,ZU+GG46dJ
AF=1a=eGA,ffOg]fOQTQ=6J:XL[+[P.?7:/+;gZD[I5]S-EPY<P\.e64&ePcHaF.
/UJPGAb(NF?LIg(.O1\+JZ]\13ULO1?g]aCN3:72cB;8=)M,TLcGN3PZM[&D8GYE
79bEWGE8M6-WgHO9e##\D^)?85Bb8PJIg]g_TK)+:1:aUM0.P>D/9d#V-B6V4-CE
KaEQ7MY]aY,>IBT\FJXCP+RT?>8>1:,9X(cD<<>>50_L(K@]@T3ST+G5dcRD/T@c
E.]P-WDR:7;e=JMLgC>OZ8/=VcT/a.K9H7DaM_a:;:0<H)#b4,W,B7S/MdLM#&<V
ND5L,Y>9&]ggDCEJMbd5]be7b;CQGb346[A]3-&_FJ@LDO#:a/QK.2FA::0dQ6=b
^8?.<LdA&8ENa2Z<]P94@=DHN,T6K5Y/^:ZB/+_HRV;D^J^/3^T2)dNJQHJSFAZd
]J/g:0,AM5D1_T1N[dAQbL\]\JH7M^?P)W7K38Ae]C1J+5]5,2[4CM\X<GU)3I/Q
)(<WL^gB4;-R+O2fG,RQ<CTX(HH1K(^CcRgQFJAHLZ(Q-UZVK+?8\W?\^N.^#CeB
bXI\]B^@GQL@.O2gSadLSQXEeP6B&(NMJe)-/)MdfG]ee#4GH>YaQb;WKf.X)Bc_
f8Eb^Fc+_Uge(AMe0cI<PG(_&e(MNAXK\^LF-7R]AcI,VV+Aa>4&a4UAKV/>J](a
G__MB>[&G89C6:>Egc,6fXWJ-[D6WQB\RV2V6#I[61a==QK5OM\ea=Xc[:QNe=JO
?cV=HNWB1@TJU3;_Y9@V0J;2\92J#9[/2fT_.f+YX_R-PIIaB[5G:Q^K.#:M?YSK
=eA1F2K[2+YF<(NKCQO?))?c-K-()3)_87R_eX]/IV<XAbE1/XR&R0YU4UF.d,82
Z;MILKa9f+ADbCc#gVYaAOD@bdS7==;R+E4X0gB/D9IGTc.HYca4g5CWcNcCGPaG
\<CgGfOBeVEY>T<D/5H:A&2^UOc/.^Zc=IK^DWCXL2NQ/b.,Q[e,Ua0cTYP_b(-V
d3CCe<G-e4<94ZT\,H<B4=,.V/D9J0JaT?Z=T:(BC2-gN23^Pg;UKD_2UfNQKF-G
[L.Zf3:P<Q;WRPd^P(.e/aVFE]g2N_J99LMIBSFST,L3P1]:92P6>0fX/g2E,\P4
-aGK:f9UZ4]O?I(abD,^5-CME;=G]X-N+6@8A[/3H73+UQI#<AQL?\#MP@/7VF\;
3[aCN;6?M.TG6KFLENIdNf6@TI6(a8_G,>G[V0(MEV/0G+#E2HLgZ=a#^M(DL@V/
WKa7@>ae6PARU;^G>@Lb6I.1<TGWQ(X^/E#:VJd;5\;eHLEY&cf@=c#]^GR[+YQ:
.4GYf=\+3@NeS=RRDMeA=e59=5g)+#Cf6//406O/T0M3A<9NJWZ+g_U,SP,Z&HYB
<V]:T]MFK?LeR=\IB9a7I]BW3X@.?3YTT]U.-dZ&K^/TN2H626B<+&J/=e^N,bQZ
R)1#T\ZfL_b,I22^Wce[&NNKH=PG6ZNeCNC]&,N^5UV?BM[7&>dSBJ4<W-SE6)&f
?=(=7bB7eQ;86QE9(R6ILYWAU48]KD#6G,6Y71WT]Q4SfT2^KP3TK0_:Z9EWZ3A.
:8P-AI;,=P^SNB+B]LMdGJKKH3?Q^3fJaQ0J4WQ\6.8F(f-ZWO8TYV_&G+R:QUXB
H85800@=(,A_>/<7c5AR.>,&UY,,SFLC\CG.U&;PaI)XOKUcAV9.>3X+@=d7JgQ#
-NUe;+,@6:^/HYd8>_/1@Hf(U.\)(0J&I]B:=T-Y;/eIcR-:.ISg>T?Sb]G#G9__
IG]27PH^YY6;6a+EFO0E2;@G)(F?)cLG@U-=]NH2/S+3b<EFNI?\dcWHdR69A8.K
K@JNSS38_d6FDLET07L+Nf79)VASNT6<+Ua]gPGLDUM8_2d,LM8HXI0bbVF8aB?=
4:;),>9g&#N64(JK)Y/@Nd6aS5@&BIP.)gD[EZ3LPA)-/2eg0QNPQ_>GYfFF\)Ha
04SZ9^M6,B+.R6TFCEL_NF&5TC[S/F)CQRUG&[(<\1O],NYB:7L1X<0W)>Pa&A+H
[d2Sg[#27;Y0NZKEJYF[@0]]G7c&[(PWW&:IN3?/##P46,VN2FJKAO7WEW-I^G1_
6=Ba]N1\LA[;@7)LZ&_8JBMH1>]U=UQ[]182ALI+MEJV#?.ZS.BB(920cGY:ZeOG
a(FEdUU8a_YRDZQC^TAQX]<deITQLBPcd/(?E5K4@Z&-8Ee9a^d9).?73_:R3^Y9
2\A-Z+DLg].G5:,N@U?WC/BaAIFMK3>;&7Z&\[H^2eQ@V_0d9.GfU<ZQZ=a9::6C
=beUW6=C6RF:2C40=A[_0=a+66[J_E+9Y_f@5g2>#g4<)Dbc&8E/JX:f9K7?JVMI
\b#W2JM5+09#I#E\T-23PT;]Ug\^71M8@Mb=.5RRI+gF9A_>/NGd;=QD;#@>?-[1
_8PH).0)#fV<&LC4Q0;cb=G=I=fXJPgU>H1\2Ic0PEP-5a]H_;We;Y:_9[VXLW9F
()-:Ea2;99d()gJCX8AF\;6:X)1N6dG)d5P)2B?Mg=@?aUf@[YT6Y]@JOUA/+JId
GZVEUf#]c5DP0^JIg#,>+;\SEWa)_7ZZ@038VJ@2/GO>\Xc&?7]a8OT_>8D1D?TV
[aNR/7C>[XY,F&S0,^f\\G5K=WVF23/L^(F2N&X9MO9b/L_?HUUL.a5(FX::Hf=Y
PGTc;A/\Y5cc&#YdKLQB:X#aggZ<&7SVESJTbLIRBgLSOP-.RX9SF(\c-45996=R
H\\7.,JUGU>.:5P[SW[8Q<B,c<^R3/O\9@g4Y\-dAXN22;U/DKF.Q7NS<S3XHRC=
bCXZ(6/NB.I(L9D^BELZJA<J+3<QB@aZ-;Kc:FgS-)<.=&YH?Q)]-(W#:LUc[Z_R
f&[Y:-@,DTXgVO(]Paea:f\R16^RBg.4YS)Z3b;XQBUL?dJ5^d8&GYOg2E<:9211
_/<^&BLOcZ+_1S>&:f1\7F_R,[X.bU@(A1f1agaE/Deg:G(A&HDeFE7]HFAQM^Oe
N8V;c.HM-33&N[g74(+DL,b#1TK_+C,52I^@9d)C^-EDRgH;b;5I))572._T8_CS
#G(1[?Pb.OWC3aHM;+HRM)7+4IB_?_gddX#;B=XPW4J7_96T<#_1X+=N=)VX5WXO
QV8bHe@PYA0^UMZgg96?b4Z0U=NP:L3A#PRX9b79NE;E^P;KcVG;ND2O>]W3Df-E
5((__DBUHG(@<g#39+HgA@d/;7(Ud[@EdC8Z:)<TD4:e#JWP:I9KJ:&U;;[dfGM)
DR]\CbDSQ7PAW#[888I0W]BRCVYJWCbVWA8C@MP1P8#/4aId8=X3KHaQBaaSP3FO
R4Af8KDg\#>V2/V_[89>2U?DeJ-5;RV@IU5]WF&ZQ[)BWb3-;49;M5;/J86##<;&
_B.#NaVd35Q4PE>Y/@&@bdF>_R^30M=Q#;RURKFI+]fGG/gCRH[P^fc(Y2]RWWY?
MfM#e6]R9MD7cORGT1B,?\BWQe1/]Z[W/H3CZUQ)D>31YD-[I4\cDKf,W5bA]LR2
YKINeKcEY8=[+WC3>BVLO8M3?@K&9PAB_&F-JNfT\-BJeHT+1Q.W2H[F(99^OVAA
a\H)2I3g<(YU_Q-X;QWECM]L)Od659=ZTD>1?9-c,,?[EB;e/(YY_D,XIY\XL(#T
7eC^<g>?(51^V49SEY/&WD70XF@TLZJ>6:AG=#B[O(>b)WP\+_Y5cS&INF(4dGI1
[W^:C=AOJ5dX?d/D75C=V2c0(\>U>4.H6EYA]VX=g/K7;C3_6R&@Fe#\M5faP4^U
4LPGNCedPLH/;ga+J51G^)V@P5T0AW\/_P1F18<8a93H<D51+8=)f?Y7<@YLLL2O
L^a&4KA6717-&?Z0:ZAQ&U[R,3e^Tb7K^^VSH+#1Jb?@BCMg?SP_[YF4fK,e(\gU
DZQWGG6H60U@NN;.>]Y@NQG4UDGM#:D8K-_G6?LPJc3fcECGH]DIDM4b77:afgNf
BfCD/SH<;>/6HK3OM[GWZYJL87T5#e^]/I4UM\MN(41eR,G:eI)5(1aD_+@(Y<R5
g>_dSfI89YX+2=9N>A&HaCKR,+Q?\Q)6a(2S[U5@PG;DRY)5\COg?018:7GD3a4J
MVZ[8H_S&?&Y619T.,CZ]dEV8Xa(OcBB-(6OZ:^954#5GDB1>#-E-<S+M&N,VWK#
:@b>NERJ_4,N&(96VW/&)4b_?V]Bed6J.ada_USR.JE:Ra_XQ;6Z[BOeGQ9/He_V
8RU+#\+\N[P:<MZ,:?W))Mb_7$
`endprotected


`endif // GUARD_SVT_PATTERN_DATA_CARRIER_SV
