//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EXCEPTION_SV
`define GUARD_SVT_EXCEPTION_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(O-2018.09,svt_data_util)

// =============================================================================
/**
 * Base class for all SVT model exception objects. As functionality commonly needed
 * for exceptions for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
class svt_exception extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the STARTED notification (an ON/OFF notification) is indicated (i.e. turned ON).
   */
`else
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the "begin" event is triggered.
   */
`endif
  real start_time                               = -1;

  /**
   * Indicates if the exception is an exception to be injected, or an exception
   * which has been recognized by the VIP. This is used for deciding if protocol
   * errors should be flagged for this exception. recognized == 0 indicates
   * the exception is to be injected, recognized = 1 indicates the exception
   * has been recognized.
   *
   * The default for this should be setup in the exception constructor. The
   * setting should be based on whether or not the exception CAN be recognized.
   * If it can, then recognized should default to 1 in order to make it
   * less likely that protocol errors could be disabled accidentally. If the
   * exception cannot be recognized, then recognized should default to 0.
   *
   * Since not all suites support exception recognition, the base class assumes
   * that exception recognition is NOT supported and leaves this value initialized
   * to 0.
   */
  bit recognized = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_data</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new( vmm_log log = null, string suite_name = "");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new(string name = "svt_exception_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_exception)
  `svt_data_member_end(svt_exception)

  // ****************************************************************************
  // Base Class Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted.
   * Supports both RELEVANT and COMPLETE compares.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[],
                                                    input int unsigned offset = 0,
                                                    input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[],
                                                      input int unsigned    offset = 0,
                                                      input int             len    = -1,
                                                      input int             kind   = -1 );

`else
  // ---------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //----------------------------------------------------------------------------
  /**
   * Pack the fields in the exception base class.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);
  //----------------------------------------------------------------------------
  /**
   * Unpack the fields in the exception base class.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in verification that the data
   * members are all valid. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to change the exception weights as a block.
   */
  extern virtual function void set_constraint_weights(int new_weight);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether an exception is a no-op. In situations where
   * its may be impossible to satisfy the exception constraints (e.g., if the weights
   * for the exception types conflict with the current transaction) the extended
   * exception class should provide a no-op exception type and implement this method
   * to return 1 if and only if the type of the chosen exception corresponds to the
   * no-op exception.
   *
   * @return Indicates whether the exception is a valid (0) or no-op (1) exception.
   */
  virtual function bit no_op();
    no_op = 0;
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Injects the error into the transaction associated with the exception.
   * This method is <b>not implemented</b>.
   */
  virtual function void inject_error_into_xact();
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   * This method must be implemented by extended classes.
   *
   * @param test_exception Exception to be checked as a possible collision.
   */
  virtual function int collision(svt_exception test_exception);
    collision = 0;
  endfunction

  //----------------------------------------------------------------------------
  /** Returns a the start_time for the exception. */
  extern virtual function real get_start_time();

  //----------------------------------------------------------------------------
  /**
   * Sets the start_time for the exception.
   *
   * @param start_time Time to be registered as the start_time for the exception.
   */
  extern virtual function void set_start_time(real start_time);

  // ---------------------------------------------------------------------------
  /**
   * Updates the start time to indicate the exception has been driven and generates
   * the STARTED notification.
   */
  extern virtual function void error_driven();

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  virtual function string get_description();
    get_description = "";
  endfunction

  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived
   * from this class. If the <b>prop_name</b> argument does not match a property of
   * the class, or if the <b>array_ix</b> argument is not zero and does not point to
   * a valid array element, this function returns '0'. Otherwise it returns '1', with
   * the value of the <b>prop_val</b> argument assigned to the value of the specified
   * property. However, If the property is a sub-object, a reference to it is
   * assigned to the <b>data_obj</b> (ref) argument. In that case, the <b>prop_val</b>
   * argument is meaningless. The component will then store the data object reference
   * in its temporary data object array, and return a handle to its location as the
   * <b>prop_val</b> argument of the <b>get_data_prop</b> task of its component.
   * The command testbench code must then use <i>that</i> handle to access the
   * properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val A <i>ref</i> argument used to return the current value of the
   * property, expressed as a 1024 bit quantity. When returning a string value each
   * character requires 8 bits so returned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data
   * object array, and return a handle to its location as the <b>prop_val</b> argument
   * of the <b>get_data_prop</b> task of its component. The command testbench code
   * must then use <i>that</i> handle to access the properties of the sub-object.
   * 
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command code
   * to set the value of a single named property of a data class derived from this
   * class. This method cannot be used to set the value of a sub-object, since
   * sub-object consruction is taken care of automatically by the command interface.
   * If the <b>prop_name</b> argument does not match a property of the class, or it
   * matches a sub-object of the class, or if the <b>array_ix</b> argument is not
   * zero and does not point to a valid array element, this function returns '0'.
   * Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val The value to assign to the property, expressed as a 1024 bit
   * quantity. When assigning a string value each character requires 8 bits so
   * assigned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
8FI-=)g2U8Yd,;3#GaYYM6BEVf7@=)fBE0UYU7d^/Q6.MZ+dYFJ+3(d68I^g<;+A
TL?T1X6Y&Q^-B05VDd7T:(GAN__+\=X]13-SWFR(X@Xe+OIOM85VQZG(+SA5VaE9
LO@,BNKAAQd&B8P\.T0?NeMJTBF?#TB@MPV1<eDV;,I7D6_3)6YA&ag@+R&R7(fE
-2]-5<0)IFP;9QQQV-+:egO+1e1YT=b^)df97AW)R42;2P#0=8&;c.O:.9eU\/SO
bUOF&(@K)3GH>=aX-?fSCJ1eYBS:8abM:/N&7HL#/#&<06(J-SVW,?>RK(:OBP_;
RL13C&aF=O,b\N^eMHH=7@691AZUeSOL]Pd=Ya?XE;0:W+b#Yce7M+J:@_5TPfP,
bHeI1K&=>#)=6R.-S?_Y)OfXQbcH-]ZI8dNbR]I0/FC;DN1\ND#;57K/JG:b0]fF
\K&9,#da&AMKbf#>U>4e@XN3L?];^,1BL,M&SYK,.CObK)^P9,.P^H;Ef,X5RIQM
L[;e3b:+JA<0;B<6S3USL4,A;U8GG1a<^ART>3b\Q:A?f_Rc@/\8]d]S[)fS4TNP
]X-QTN>S4\4(4HGK^:.[TK.1cUIT&^8FNJ?=&[b@TZ=Q8X,[+74b6\5UOK_.D8:2
8WCDAAb:Q\84)\^a>+#2\13@FY4LQ5]]-CA?7M;1:5._T=3+[5(KJJJUMS-828BC
aBIU?[VadXgO7c@PV0c@+1NX5I/]C;]eV^WLHX>=R5>HMb35K,dO/UT1A\C0g?G8
:U1^([-AQF9H7gO;RTFe4A&QT3SEd6dFc](66fMWV&YbY(S2A@5-d>]E]RZLZOCD
F#6eQZ[O6.a+VQ<Te5S2,dOaZ=,0Q+C-P]aH8)cG\2\Y@,XW_KJB+d]1[\Nc,8Q-
ZI9#,+W]JcGO&a@_??QP@OAUNXSI72NR8A]71XMag?KJFZ0-\302bO;1P\f;ea63
]4X]0AV6IHKVV1D6MSf>BU4R-SC\S-0)Y6[_(CYDN&E/WAf<-Z30#>[AbeFGQ@PU
)/)9BVN=a#_,KH^?QZ<E<KCHS@BTXK<1TZ0@e/8C4_X<^+M.eE-#gN\Z+gI9MQZB
c=,FcXZ>>UTB7\A5Oa/D_[>&dYAS5Y2X6=E54]E;5+5)2gH8@V>XUI\>.@EeJY2b
I5C>;0&7@b3;Y^1cQ5;UOV(>JA?SYaQ)9A[VB-^>O9AIAVEP7f&H)S@Qg1&N02,S
=a_8ILMRC82gZJQRH4HK>^Q)<Id^V,&K,[@.d^IL2U.67d5,g?]gHCeH<97G89Rd
92]H6;VK(U2J?76YSD()5A/GV)\)NY1Ia+7a3)@R88Y5?[5@OGN.AFH/SCX57_?0
K>]DR-V\8A-2d4<_+6aGWO^fDY(BUbF4:Daab]_R(P60@-M[^\BD<.,HGV^X+W/]
&aXc0.Vd<C70M1M))TPf6/ZCJ8NgcL1YQ=+.21SEW0a1-<->KB?1CIN0:T<Z:TQD
Se+TW3S=QH=GS2dEYC><[K13Oc<EAG^g8.N]/bdV1DDL6?[a&Y?c)TTUJC^dE]ZX
5R\<,H(\G@:9V24eQ2EZ0(MEcA,5/SA/<4eY4=)Bd3K.)W[O)\Z&819BZSc[<[5G
7bKD70T>:\##,+bAAAe70)IK+R+c808DLaVC#ILacVR5S081c6A(gW;_E[,UYd\,
.X5^0G@#;;>1]K0MRc(HPbd>SgB-f.,CaW=+7DcdKKO15B2+G0DH^WTPEHfB741a
?cVV?PQ/9D6]OP,bc2DF1/#eZMS9^2RPeYb\WdQ4LbG8^RYSFY5-.]N_,7TbWM(\
@J1MgYb>fI]eG?F6O:,YMF,32b;)E8M38QDLL;PZA]#E)-1Y+PTJR-d^/:38?M_,
Y#X9H(;YP?U3L:KG]:GOfB3./B:VJaSRP8228a(eI+:ZT.34cY@C1:FHJRb8KBK;
46P4c<>(>B/+b=?C6Z1g^Ya(2-98J?T+EP<PZY3D9Z]RB:HP\+W[F+XN7[JCd8_9
USF&../e/VVdJA(HcIe4a.C6H:#84MeD((UCbf>ba3&P/APJ1K8X(H0XQGW(YME;
NbX#.dT@75f/Sb,BWf?V)dHFR8_.<P:7cPPg;WD)I/A_JXNS]^.ZVX_CD63EP1R#
N,@F6X6J_X.eHb.G=J1:K?<8&0T.=Y(0^8+\AOJWXSb-4LfgJ2J)#Hb^6Rd/Y(cM
eWY4C0J:C4W5D3WQ8g1+]WYN/4;6_D81?Q/&8d,HXYXR5.2V9L4+F?ZK>40^:A6&
cbf@KHRJ>FgV34A8[QdYC:I9d,<=dL^aA4^a^3eKH&,5BTW_I1MBCR>d9)geU;Q.
Y9cLc5)-T#GWG[>fdE(LZK-cWJ.fL#9X\.^[\XNb]5ee1W&XT#S0MUI(@bA=>5U9
2+C..67,=cg:@\,d1+54P#JY=&I]21?@S;[UfZW0QXa3W),a:]7P-B=]5J):6Q:(
^N-[GcWR1M1:(N&U_ZV4b+7P03,LZ-#,3I3WGP#/efB?-Q,CT.[H1aE1Z^g/0PC.
V95A;M2B9SNTAg+-+-3CMHL37XQJ6#^;ab(1@a#9WO1R0IZ+f<#c<-Kc&f8X,P,U
.e^dYLP\&gXg,3E1;@4?(g8#-RU/SA7[[]W<Q;3MZ=2=V?>Z1a6;]]3d@D/?FbgJ
[(fQEL]R;NFCYD+@4c=>d@PA1_@]b#UH(AO//8MBRR,DC@>U82VELfLdM4f8Z#b2
ME_e+RFIX(7T?VL@FO2/B9KQNB7XQSaX3B[XbHVZDGIJ,IWJ3=:Z6?Yd2:#5HC<3
2BA)eRQcK:<<&R[&cT-5=AJ2D?Q[U96D=^97]Aa7+X\UTHY7:9WG+g<<=&5:-QZG
XDMPLdV0MQ:<VIWCNfHKC#W2NI&D3g3=C5FX?Q5E2?>F/1P;IW06(6UW\NW)#IH8
_3Cf+-A9(5Hff\a9WfWVU\3DPSc;\Y3KFPG->KB]8Ff_H8Y<TcZ1QY\UfZ#?6(aQ
LP=_0CP5ge/<Hg00QJJS4,^)OMV?U5&@3,@SH/cBIbcZE@]MJ>[f4e8:6Q&1AJ=N
J5Zg:OC+V;;\@(TS@]?W^0GXPeI7Na9PgSP;RRZ1IMa/9eQ+W7aGJ_f;eEUFJR8[
Y.Leg7=CKA>P#W_b)BbBGQ[#EE;C17d\9))))#d>8BfNMZ>)I,7>b)9221A5.U;A
W^eG;79WF2QR=2\^Y7DGB:7cQ[T&:NH@:I:FH_08aI/Z8RT)0Q?\=6J8:6)A5PUY
;\(V,0NQC^&;NAJ3^[M)R]DdA&)5C\]OcL<5<bg4;2QSea=6N6D/:T\G[.^W5-Z)
44+L7P;6_dI3A9WLgBIRGUT_2=ZPWLKK)9Gafbda_QM[^4KBZ5N_R0eW8LV.V2eU
O#1A:5EHe2Z[+T2SORIY@aY00&->?E);TQO(L4ZAaSd2?bbY1JWe7Z-5.GL,N18U
_acE4@/[C\X7A=U1<_RA<R,<KeJ95+5<dCdS#R>eXN?W,-eB.V)L2a-[,beOD1Q[
NE,g&>SXGT\WTMTM]30:-#9.=]5dPcaRD5dNRb/7L;;D7fa2(:-;/WHN>0_/Nf;;
QI89Pf:PZV;OOZH1SWAe#1=ADW-S2-TM_MW7:J.WQ68UM-7P;YE\>O0Mg1H(:5Ug
I^L166@M-7f^,_<MbgGF]38MI=2GJ@)D=6PT&D:GHb1I_2#L_g:R?GP[N[09MENT
B3?VSSBIMH@Id(Vb?#F5W,I7EUVKLJcfc[>.IL1X#T<]8@QBb6Cb1Bc6g:4G:B[#
.7.:@&5\H^c\A,X?4-.JbTIF9FK#?0eP9@N=A17T#6YY@1Bg_e?M2b3e<PdKGA>\
ELQQTCSJC-^H&RWLP]I.:M/>04]Hc11C?HWX8WC]9Ma))f&EO8GV;B)Va1UTPG@<
AaC)cNe8:O,1XG&ZO<SEFb]/.XV&G/\,WGUHI.A(fM]e<bYA5,)F5/cPDVf_b110
+BeRERM88H@.Fd:QO4D:Y/bf+#+4Gdg?]P5@Qe9<.UXKd6+8]cL43]\-KH[9G4FW
:ZV=@;50/e&=<ZdW/cV#:4^JaDNg/:WPK#R)455Y(6OX<aa,WZ+=&&Kc58@CeMf]
,?G.]Z]5gbAHGW3f6B>/RZf,6@A1K[>PFJ_aJ#0Ae(BB6GFS?=#S\_Xe4#Lc,;Ta
;9C[NVPB2LYAYg]#W?X^LLL,(ERaIM\E=?DGHY&>M->.[2B1_/:XJR9/M@&Ca9\)
T1XQG[L5,H?YQO=><M.<_.1(g_[@LDZ=a=<J^f.C31<b91Mb]KY?D2R)E4d<E3[e
7H/ZK^ER/PUZO;.=0IgP/@HF#gR00Rb(MJ3)+G-V1QBgb\@=O_B4N[)T8ZU7&J<R
8:6,BEDP^:e0^^LW-TOeA?c&Y<ZW<CWdG>WP^#fVMg<C)PIMCAL]]d:MLdQ@<NP:
\XaC1cKC4,I;,N+VOY2Y,..3K-aU8J/G5MK.^I68,N5H-E#)FL[C]\T#2OHMR:RH
L0GcQ:#3U_G:Q)WR7gXd/DWO-(\M;-)Nb];R(A3CPK<.@Oe=K)Eb[6GYLZD88VI4
K4G>Yg\A265VBZ;_07#.OJ<2ES2/>eNQO=f?.FZ[b<+7:>[>Z;,)HM5QWV71];YY
PbQ]7==cV&Z:_]34R=G6G>C.0fI+1:<)g4RT3P@@-Z]ce+gbMg)H39;#&?+6E.9C
LPH?3?:\6O23L>,P+(Z-^B\eNP6T7,E9MHK=).74O[&#TV=GDBRRIXLP2MV<BBaR
=Z.1JZ@LF.G+ae#UQROY3Ze<(QRO&:Ae#Le9.>4\QYVDISf_LM:[]U;8a1QYYU:g
VE[=V,WPV4CEM_S.c8<9O8XBC3c#8)U\6=9PfF=H?\7C8S9-FK/,Zc]eec7d_d\+
5M()DK=d(]a+^F^9HNO22a-dF9Kg#8c#>OWVP9(c=;8>4>12/4L>7SaGC&aL1H)a
4\O=NPI1B56\@K_,)N=(cf_DY;[PE;Z)H1Q#c?GbcGZ=?/R#TWH\CJbINgZKP=Y4
ZCCWIHf3N]1(=C3@:>+.2H)A1:EB;YJAG(VIIT;NC&I:8Z+795:I)M]@40CEHac/
&fC+1DXRJU^gR0eP(g,WgPa.e3;FfGC<[U0>>@O[/J)NCQ?IJLO2E+[UAI=AWc?1
=13NZU6e_(e@GA#@=Rc2J?F>LJP<I+UcbMK;CH-?0W/KDTS#.GJD<7,GM\,\/0DX
RWO+-WA#C)C7a@5<\G@LH5]AX9&/SO+?7_J\@/.\FW)H7)Y]VB8EgT:FI-eXJgRW
HW2V56d2^K.d.Kb)cCGAD8KK)XFSLO->8?NAeZU?(=J72BUXO9;N3)Z9[U]cZ0.,
^E<3E1:-C85PRM]Z\(cFWZ0L@I:JM@>Z7F5/E+Q)eG<;YHdfJ8>b)6.@L)-_;?b\
PJ9HKFID519T?LGDQJ7d5G4,GEAP(VGH6I-EA;W^P2[Dac#J]?/:1^&54;@=WPeA
M,_/A<\b_f2A0GH]D8#+<=Rcb[D37ScMZ,0&SEWCJ4??3-5=7:C0>;D=\gU5LYc>
DX\R.c];3):cV5FLFOcNaU<4>7:.0Mb>8Wb+(?447YNS7N)[BBGAD0e7F#gZK@Q6
O\@5MBZLHE^7N0_3X^6R+&9E?/,7^J>IQcQ7LI,Q@OM\+[(+[+/7UH+cU,?1[Ra<
FK1R:C^JKUOA[216XZA@47?Ag,FR98N:<,Z=,QU8+NHXJ)+5c#-WOAa(/T6:Ya35
FADaeRNWfR&3L(1^1QAS>G3Q6\3g-RTMOGZ[Te_CHgQL+U-Ha<(8g,PcD6EHVQHL
e;N[F4ALfO-bQdWRB4O)gLI01H3MAfCMR.B>D@e:a]^O(1IbPMTO6^,0#3>.MK)e
?D6W_U&Ya@0>7K7,MW2)#H_dUJDMMfKXea1V9@fP1-^,[LYO[R67.3;(-7@Z8PA;
PK>@H1X,aa5:OFTU-fH>e)<[Y&[bLbPZH3V]8bM1YB9QE.:S^-URK&M]]Z?NE>9?
&<8YHX<KM2?ID5[QYC)Z1d2Be=:A?VGP^^T<fg;YUF[D1>JSZT[/BCESBA9Ya,B7
V?#++(7):=;f7@Q7L_X2LIg.O,E(5-9P9LB8?dO035Y.H5FZV3e0Q?aD)9-D&-9f
OE@Q3cK>gJcC[f9[Vca9Dbe-D>6JaY;F5GDH]<e)#gCBQ59bCb]?04JN^aHBOZ5X
5T1gTOHZXQ:gP>SMKVGbCDX1D2H>^IMd^4OQ[SSGHBLM\fYfeV3<Z7d7Y<79Ca&#
>R/^IV^]KbL#[FB@8:Xc+e#;^J_FXK[b];#?cfD/E8Of:](-?db=E-e_,FP(MgBD
A4[1QBJYQVLc6KKU/@HCA9+6CGT16O,TCdEgNSD3@<JE]D7Y+LG5<3ff/VMVXEBU
CF[_)U0bHU/WCZRZ)4KLQ&JWJVMdS@#NK;ZIgc9[W8g=4eT52XPIPG8Q62E,MR1H
]MR^9Q?F=0G0e/EU8K#4&H2AQ]JUgE4Me&]W1@Cg#PC68C1@^44c4@(:D5=@GRD)
&aYD,&DZad)6V87M_D_LW(3.YEMSJ--JJ@[PN.7MW1aLddPEO91/>/[e_VG[OK8-
_I\0g?e?WL4OW>4c^]bR.#3[f/FA6EO9YL?I&<J6Vda<C^)&XZZfbc^CSN<102+b
0QJZgRCR-J&HLd&e.\L-1DR5T?XI6:F^Y(.->N9K6&WXCI>N86E5VGceB_M,S]gZ
<9[;SVBa3(M9SdJ8FUM5&6]I)EF^?^L4U)XWf<XBE\1N]a:1JIB]gW=;MQ\RH2/=
>OX,NVb.[\8/5A?[8MaO>R=L8Z&D@F.DZL+O;\?RIa6g3LA>9N#V5HH:AI<9<I4W
&fU2T16&TUASF1P/KMI\Y@f8+760YC7PEHC7a(H>&+Q]6Nb(3J_.JICHedXRd?+2
HYbR=V(?^1L[G0P-C1RKAg;A[=La8Mb(LRcONbUE\Nf??1L(.OF#V1IEYeP/>W])
YZU22\QU8cbY-OS017J4/M+f+#]QYP_UMD38)B0_1ONPde-C4Y23+IcU4<C#g)->
HRP+SJJb7@<dbIG3aaX:X4&a(:Dd)_]J&L@[+1H?BBcOHc.bO_8BDD<G#N[JYE<(
VYCCZ73)@1(VPCb4QbZ).H3&O^SHL\<<Q>RTS-fK,U1S1#dH??&VX_A:bagc:c<5
J@]GMV9Rd/DWBN#P_T=T9<1-G045H(.K>QPA51J:0A\d]AJZNU^fUQRNWTdY2/<=
@+9X-d3U=Q>/E7&4gY957FT;DCRJV]PJ:gg#V]+KO.J.88B3LK(5J^[^TbVUf[@6
fL@Q1H/WUQBN[+HLg,<76=CX5-.1:HE]DCe&a7&BB0R&GP/bV<WH3((-EKfW3E)S
(6b&Z[NS+H)RTa1-gRgeIWRWfU_(T51J\CM+WAJ5?cHJKP,B[?cceHL\-UaX,N#M
EY(c&NGPHdcT/W_)?5/CV<Ad-XX&GEH>@8PeRR\<NYI&Z2VQd(O+((KCA\(]@^WB
+BPN8TWM[PAO]YPB]:_gV7PffG4._CbJ?1[1cJb-H2]VgU6;4e=a8PDcaG+,U/FV
PTa(AMZ^G.8YHTC/F?P^&?dE.W[R6+]Ua0LV[V#91](=3>)3S_#J[+HVH](f<-b:
XAWWZ&(.IXcZ4W#c9bWTU1BTGW4<Y#D>eIf)b?CVFg3)9[_E.?S#f147I),AI5QC
9G<.#B9GB3)M:T6g3MO+5,HWGfU=&[97L_8<XN7)AQ;-\-:TL([W=f9Z\(ZWBegL
)444b#]NIC,eQIRIdYI>Od61#AX\0CA^DCL<ES)T?B8B^^NcPJ;RdHK1fD)I:c/7
G5IZ@U6YJOa91IDQT3/Y;YZJg+c/]b)g7D>T,eF/WPKZB6(6/^GGJXI@1EeY34&]
)57X7X_+K4AVIX;DM9TJ;_<]6aIKJ6W7:7CR]1><YC,--?B(@bT\R(=S)PeR5+g;
R\:BCJJ0#?#S/W_dEIXceM+1e[TP40+C9>CWfc^4TE+3RZ]RV6d&B1eZYCK((O)V
8D&64G,RgB_T1:<RH5S+_X+,WgMUgg+fb@<Q@R)8-2;X@/YQB<S+dC/&a8Xcd0fg
Cee>Dc1#CRTbNFU\SgOKFH<_BPV1U6#Fb2c^Z_+AMIf;(Z)N)&_G=_(.<NV)ECSE
)@U7Hc.bYR.S;G65X>-8dTXf,8L5e_c\;N<)fC1>QI_A>&=C5[A85>V,FAQ>bLPc
6,\.<L-2[FR>Z7P;dS]#.^8=#c@e?4D4>da3U,Z^d1d@R9KT9Z)=&5&2OL?(E&aG
b,##:+<T/:G8BCBJGGPFJ[aTScL3GG6Z520-)R(22GK_82[a?)Z.LDbJ3?4/=TGB
@UbTEfegMcC&/.<ea;TAd=7dV+We?;TN6#3CP?E-c<>fQLDY;,cQ1e+E#;08UI(O
\AD^:U]CI2Y-BU:A9,)K2Sf)F9,TYEgGCPObC/c.6U?4T4]Z9AEH.\?IMVQ^>KHE
eCQ=b)BRTP:IPV2.(3@5.)F6;:VS&/X47IQVN5AJ4=\8/T^-/#WC27+U[@#;VNa@
)QQU?2aM.JVCdg@S78G#_aWHg3ec,cY#EX/6T#<Y#D&.#_\<D>Z@?bPKZdT.>AUH
X)a:#/3ePM<edL=U&765C&>-[5K#C;d[2Jd(O\T=JGV6:Kfb<4=;HLIa8eSCH;NV
]1>e_8(M\D;I92_a<52()N7^^_g+^[_7GN&8#&a=34#gbQB#;=FN[_?@48QT6A?F
OQJV6BY8G4Lg/Va=XdOPeXVKb5gS,C)^P,Z0c7-&E\2AV:&8GB5JDb1OF)B@X.cP
1W7N[8CE9\EZcd=(F81CPW.N4_4Y[,3>>J&cC-Je3>H\(PFWd9>EUD(_S0:97PMS
6Z7f\XM7]0-87+e1KL=Ud@HX2O-:V5Q_PW8LW8/a43SEY(5+C4d=1[?0g05_+#6_
^_a?E1YJ?(5./O[@a[4WQUd;=]2fO,=g-gAKRFR26V(X0L2.X3OI]D/ND4.9c[Q2
(DAVe0W@>(U55BO;g/TcU4(6gG#B9>ZQCLVOe]XYZ.S_Vf?YO8H0,9^Z>I-WBUF[
QM@/H8Pe9@):#I/88_I_NdcH6T#c]dGa[P8cV7K:f)9d\cbV?SI.^33OD-E5c_<Q
&SJ47G<4S54KLcKE^PAe.:/>WZX2CA).Q)&F#&\_=+;b2TYIN\95SS)+YS-fXe4/
6+Xf<GE<>;KCZQbc4W#+/c6XIaY,?^MICJg6UQ1(9Y1>Y;\,UBO4eROMBRa4P@dB
N.<NC_B]5CRPfAU2IB[2,KW8\RYORT-\^(4Q627+RMF/PQ?g(YAIEA(d81&;N\L=
JEbIf5[=M.aZ36-DG-R:C7dB7R&f,\c+,V[X^T1<X.f0=9W]GM>29#2YgY@F17Sg
K06HG[-f;@X[-Ab3g&F:E;Ab7g=^+.]Q+3YN+;]:<-;:=GF=Ca?DQX[JJU;?bFVD
3Td;We\<?1c&/K?dWR<E\g,>Og#_EXCO,16>;.e2cdIHA[:H46?0<,>2>dGbgINV
d_VN-Hbc0d&X@](Q+.53eDSZWL\K&?08:C(OF(3CLT:^83g&]8>+/U7BGMdfKB5:
F:[VR_?gA=ff#]I2Z1O(:14]-/;=?#cSYO+()Oe22S)[WPH#7[QdF?S\W2U8.J7;
M^-+N3da:1dJR1YTg0X+QV2NUYIHFULL6E0)M>b]1:PIYW_HMVRAU#+T./L@/2X_
.>HMUK0fLHeJ2aMK:2-/Ub:e_JEJ(8Gb5L]X<5B6.PY/>Sa^[@QF2/Qc_d977;=;
b?F/V(+<+V(=XXa3P<#.cYJM5O#S@c>??bgA#6F-#WEOTNa6f^MfAYXLIb\N+K_(
CQ^M&WA3=eFMMQ9;-GXa:8?2]Y-YWVI8F&/KPB4YCE/5X)VT+9Yf&@BMGXZ@5:RC
4U(FgMD1ZXK,0:JA^SVgg>G&)-X4;AP0#3@LUM1@2BW;FB.[]b044)3K379PcR&g
GQF:I=3G?DOPHFIHcd]>358/IJfa\,&&>;@0-=K]I9R-H,3b08SHAE==O6X15\2g
=Q><-Q70M>ZM&JG,19[M)+gUa]JI1N)0X&[5JPX;):GM/NWLVCC8DH8A<\@1M(da
gff-@Z[R?fdPW\c<.+=].(FU2f3d#eQ-]L:IE:3GEX)+?\IXaE:f&.=R7-)LH.)=
C:)dF:9\e7H&<UW:TN90B^8QcW#Vb&;?7)90P_(G+6\(0)a+]A1-b?@gD&2P6U=F
4QS#&UKK>/8cPS:<+T]7RH;b<=6-AHDH5/b^4XZ-Y[9</9BFdRZ+#S,LP&0X],MC
@OX:M:-^0@L)Z5>O2cV/I+9DFHZ9TW-bCJ&NM<QQ9M+QT=&-DBfLI,fZb^EEgX)Z
_5K7((gf[>(cK3=LM(Z8BV.aR>@F.Ffafd=#AJG7f2L#904E74XTUD,.I>8VS?(a
^DWa30?CV>F;02Hd^?W1d+Eg.VHdTBPYAg5d1ECb0+(R:-K=6D27F-fRL(1TAN+#
26;ARAL@eZbC2.f92V.5OXTaDE(LX?D];L.OS0P;72H<H1TAR(.:SDP:M#]<2^B(
A:&QJMb>fT5GJUa#C?P/XM^AO:9-TY=Z[22=@C4bW2U/_@5D;fUT2G=N.M0G&F_:
N6Pd#3PS.Z_>9P\-YGOM5WET9Q(B5U_A&0XL^AL3J](8Ff@1Ue;bSOdWCd/O-8DT
INVZgH=.OF@aO#<=WMLC2+;3-Q>Z,d9.Ua11V.SN(BD1e5B6][Y>J<M[OcUK#/&7
SYbcefPAC^D:e@0Z.X2B8-/@?6;,&B0A<EMHWHOQE[MS=fT=\V^=:bN<b4]\I=a5
bf(3Y;\1C+ADVWCWQbWEE@10IfXQaXf_D\N5SGa1C]@])16S&8C+:15e)7T66LSW
bMcgAWeN#>^3Dd78D5f/F+83M/7JT3(MM27@@G650bB@<bX9M([d&aPc.a).J-EI
[5O@NadI>5U2#S#Q)7P_3[,\0=.,VN2DB8&YJ,=<:4];W3cEcME<@.fD;.MAV.D4
7#D?WC&)<S7O20.,^ae0FA-31D)9QL_//gAdOZ]4O1H7>Jg=(@cZLMIb3>AB[LP-
-NZQ3KH9+&KVTYeBd0eYGEE#(dW?W89S@I0)-,7&Qc-JCPaCUGBT(cbWWK_@FAMd
3/ZZR<H78E<KUcFNa;+AV(C\V+1]8=M_a16bET(EL?2c9WdV+?H9N,^M<K2S7--6
[K-&SP1P,?WM<.A60RXc^[DE#G9BQ[7ef.HFB;N5gQ;,I7GMacP/MEf3@YA[\7]g
gU+XMDAa1dS0(8;L4?U&=_gECcY:GU4GK]VJ/96BZ>TW-.[Ld;4BLE=M>G_>UG=2
.K7?BY0cQZ\LGKYd]T1,1297Qf_(_HF[_QYgQ<dJZ[/NAIA./EaHFBfM7_SGg8CB
&G0TM1:F#LEAfdV.X0Na?>Pb;5H_W#A;&]?^a/Z@NR6a3@,6<F:d?e6CUL9D<HBK
+gK3cd@486E/cVJ[_2WAM=IGe/9>SBNV>6=6G2<VJM^ARO8WR0f[X\JT;7;P^d,K
b1IK9L2<aBMb8>8>(^_E<^:Ea&SfA2EdN_;MQ[TWM9:c?P7V1P[23^98AS,4,d7f
cQ[+F,PL<YFf<LX)3YCK(^[2WCFOed9fbc1\gV0.\9VU8.)T>Ug4)=W,E]NUWM78
_(Ob2V@8^-D1I(@^P/6Y2Ie@ZCBHFVPXR(BA]]a13B6OA##]g/-JTe<=B)E&T8.-
DQJLDJ/3N-#-(eG=PaDNSM@.^aZ677QP]+WZ/U:1G&7S5AA^D@K:<cP2(++X0Uff
.K+eHM=B=INc(2)WR-]8K3L3+5S<K.:P&:DM4<:3Q(T^82#)@YDea89LG1I#<D)L
+.#XVMFdSYK<N5^5\A<XIKV)=SH]^.S:39?e7M]+--,gNY00_4fP4G/NM+1Z9ZOF
>;P04X6e0b4g1cCEPc].#E5\9e2RK)CfBa5S<K3RE,3M>gUcTW4bM67NGI2+,TXY
-F0?g_J3(\KQVYW2K4L/:>#BAIRDfS_L/:.1g^6QS<)b&Vf+:Z^D+Y(;]WOUBPBa
\#ca?C=@8SEfCI3;N=/HUaYBIc/+RBZJ;-NX-?>:<)WYE>I=RN43KCZ45c6B[]:8
Kf7[((8Z6QBK:.6;-@eF2b[dUe9cR2-U<Cfa5KX@:;=44<\(L,:O0LP,S[\0<T@@
f4UM(;06IaG:4?F]7gE+PS4@ON<2e@B?7#+Jc&-^+]?-NX0WKe-_Z:/-UTO4IX.P
PD#BCG;[U(S=b7G[)0a\<daRaT/^DXH+3c=0#O?f#D1RgWLC1DECAIe8OV.>,DH0
GcS3Kg3\)J]9EJGc9\HdcCJW9R9-MIa2F92WN:B6PMH33(30#3VbYQD1EEN7M9I/
7>53H<O)_C+BeZ_59+Ic8&.f_e[X>ff_[@7]VB6#(?WTB).4e0:Z\R5,JAa?(5#Z
fAdL_YJXTJ(S5?aKdQQ04ON#@-T4,1Md<OR-3NB/,F?F::5ZK,@)RfEQ=UVW2D)P
O.\-f\[e0M@Q0HLWI]Y/.0XZ[:V-2OYNZe0#-f6e_6^cGLRP/Y(]3,Y/YW/.AW6J
-d)WYO/V/]Acb^Z8=IU+g[>+QS59GH070QT-DCSQ2;9(XC6e6ECe_C>F:1g4,<:,
Y240\=3W:#]?::B@\X-S41AJR3B(3JMfN2cML=O68a7cfFBA-+\.YAe?(=CRD91.
O+S^aG5COT#dc)?+#7M6XX+K3)=gf&:S\c)F>f:3+a0X^F+75=#S@11\,K3cSfE]
b6a3/C-?O7NUE]#8V^[3THGCdXFa(3C/EUc1a8gF_WULP_\)9e>D33TgZ2(K21KV
)9KWXW&A9:ONNc-9RE/UF=<L@_S\SDC-AU):H4\M=85K1Z(B?,7N>)CFVb_3XQS(
]g0\QQRFaMA:b@X\)aV\(LHa[R]+[aJ(TWWe&W@;(TZ=;0D]-TZ_\>D/VD+f7AVW
PVF?-:_?2b@g-(K&@78S]3&9D@7P.;+678TQ@OXKYR4M30Vd8>.+;I3]QKLIaeNR
N1(=.Ud/<N@,51[5+)FGF8@:Z8B>+2K3F[VE;7>SG]3>_W3J7Z25?;60Rb<-ML6#
VHQOUP8;[<+@&N:+A/L\eL5W<(,HF)&+a69CPa90Q-&^WW3Y&;SSKH>Z/6g22)Y=
(AD97L[:\[<?R#M0O><>OI#>&>F,e>I0UM-?d4YWE5&O8DD9X4;GW9:RYXP)@b.6
H3\CJVS#54b#-.E3a/92^O-fQc6OSY7]598&YLbTGVICP(WMZ04<U5dB\\[_ZXG]
YFg5BOGOc]LJ#4Xc1+,OXQecE4(7c1OZ6Id;DB:fE0J#0E(N<AT\He:,e92S8#8S
>Xa:K/QFA#;<C_/VFTKO5g?U7)V-,\&ebC=c9@W[M5RCB<F?0PLIOQ9Q2fL:<)Bb
V>:T1c7-H2X2cQF<g9VS10ETc\<FUfNeN_OKVAK^dD>CL?BYegML>K7&KBS7XY;X
[Z?Z17>>G>VH6bOGG_5eBO0)&3(eL.&IFeB0fC/acYUNN9D^7/=O3T4ae]Mb(1c2
g507<9G0P<G?LX47^aXTL9M^A5F3C<QdL,gCd>EAf11[-H&:H6&CBS7[8,1I<=[F
GISfZZ=QETU+@KdHY[+F]2+Q]g+TA^\VSD07PJQa2&AG/<J,EDc<4g=R8U_:?S-D
2\&5;Kc1?QS9d[V^f7._HZK/BYH:aWag-bA[Z]&g1M-8b55^.4._fBSf/6P0:5T>
PCPdMF(7QN43f)P1\G;[S4J?BLL+8HH,01JW-53&PZBGFO(7851(Pa;^Q#O1(cRX
G7M<W;e0KYUIRGUIB6TTU.@Ye^7-b01#_T:[GgR/O_OHXL0HA2.2_:;(TPcXYO<c
5,F-@[0XQ)OP>+R>R3B6(YNA+g&Z(-Z=VRFO3(/,3_>0Z:XTD^SCB,:C7N?;KN/B
>W:Zd<6ZK2;d9DT-d(b#13<fBf;^26-]4=BV]V@H&PC7ACD1^LX#)?aO15c+UOMO
da-2aROQF5E+YN+=Y-]O.YFU._5]CR&C/X/6T^T/ZOHY0PB]E6I\I?J4Y88eIS^W
N?&4bIIXR9Lc+>J)4VDH)a:P1f>E(gKcCWgD:-6SM[F;3,.)6C+J#<=[S]Q:3N&5
@.C9#f:,YKI_WdEHVZ[4]&21b_77R77e@#W8FLVKKEWP_Y(R^fJ/;9F&S^T)=:3[
CP)F7MMf4ea.2A1=(b6V?507&Rb;E;eLff\Ef3XBeD5NC</7-AUWH:,;1POBfPWY
e>^])GA8^(&\+_=3LPRg_RXWGdd88^L/G/?CLQ@Y66XT1;)D@JdZ]&YT_^5,H\VX
JNRfaKS[[T7NcFR/fNBcR<1gGCN0K>P-PgUB6W0J<_+_WE6OJ>CRU:(4Mb@63>U3
22d3H64/9&)_P<[W<cLGG97VM==SSP#:)-UYCb3CEO0WcTS_5g4bA/0/UO3a)<3R
X.Q_E/-[NBZZ<AE&D3Zf\41AAN^H/<.^B8I6<@+J<KZe308Tg2]SHOG/#Q5;467P
-b+Y4W95=W<cF40Y,SPFXUM34<PfR6G=>$
`endprotected


`endif // GUARD_SVT_EXCEPTION_SV
