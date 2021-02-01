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

`ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
`define GUARD_SVT_MEM_SUITE_CONFIGURATION_SV

// =============================================================================
/**
 * This memory configuration class encapsulates the configuration information for
 * a single memory core instance.
 */
class svt_mem_suite_configuration#(type TC=svt_configuration,
                                   type MRC=svt_configuration) extends svt_base_mem_suite_configuration;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------

  /** Timing configuration class */
  rand TC timing_cfg;

  /** Mode Register configuration class */
  rand MRC mode_register_cfg;

  /** Width of the bank select portion of the logical address */
  rand int unsigned bank_addr_width;

  /** Width of the row select portion of the logical address */
  rand int unsigned row_addr_width;

  /** Width of the column select portion of the logical address */
  rand int unsigned column_addr_width;

  /** Width of the chip select portion of the logical address */
  rand int unsigned chip_select_addr_width;

  /** Width of the data mask */
  rand int unsigned data_mask_width;

  /** Width of the data strobe */
  rand int unsigned data_strobe_width;

  /** Width of the command address */
  rand int unsigned cmd_addr_width;

  /** Prefetch length */
  rand int unsigned prefetch_length;

  /** Number of data bursts supported */
  rand int unsigned num_data_bursts;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Valid ranges constraints keep the values with usable values. */
  constraint mem_suite_configuration_valid_ranges {
    bank_addr_width        <= `SVT_MEM_MAX_ADDR_WIDTH;
    row_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;
    column_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    chip_select_addr_width <= `SVT_MEM_MAX_ADDR_WIDTH;

    bank_addr_width + row_addr_width + column_addr_width + chip_select_addr_width <= addr_width;

    data_mask_width <= `SVT_MEM_MAX_DATA_WIDTH;
    data_strobe_width <= `SVT_MEM_MAX_DATA_WIDTH;
  }

  /** Makes sure that the data_mask_width is greater than 0. */
  constraint reasonable_data_mask_width {
    data_mask_width > 0;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_mem_suite_configuration#(TC, MRC))
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_mem_suite_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_param_member_begin(svt_mem_suite_configuration#(TC, MRC))
    `svt_field_object(timing_cfg,          `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
    `svt_field_object(mode_register_cfg,   `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)

  `svt_data_member_end(svt_mem_suite_configuration#(TC, MRC))
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

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
   * Utility method used to populate sub cfgs and status.
   * 
   * @param to Destination class to be populated based on this operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_sub_obj_copy_create(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   *
   * @param rhs Source object to use as the basis for populating the master and slave cfgs.
   */
  extern virtual function void do_sub_obj_copy_create(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
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

`endif //  `ifdef SVT_VMM_TECHNOLOGY

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

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

  /** Constructs the timing_cfg and mode_register_cfg sub-configuration classes. */
  extern virtual function void create_sub_configurations();

  // ---------------------------------------------------------------------------
  /** Constructs the timing and mode register sub-configuration classes */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
endclass:svt_mem_suite_configuration


//svt_vcs_lic_vip_protect
`protected
df8b4MRHK,CJ9T:Q\DJU#C:aR8MH6C6P-dReKKT,5Z,LCP=D\IBY((3,=QOM5>)_
54.g)<#AbHd,]^:@AIRGV?^]@L5#c8YP;]:Hd81W@cbF.)+16ARZeQ.AA37[@b7e
<X\8RXaAc\\S.SX^>7QEYR(X<N&W&@CKBGP2d(fWRH>15Id:KJI,+\,5RQY/P#H=
[V8:F]E=Z5[?G6,@OI0Zb^(X_Jb(;6A=P.)gW?fK3)Zf;5M/8(\b>bIZ/a(41Ge&
860L46e1fg3b^cN]2=P_)@Y^6cd+8BK/(DA94-?E(WG1CQI<Y(J<g2]^O=gb?1O;
fXRRa^XB3BD47U4[F(XR;E5XGH<-?)P[W\H\V,^<&[XDXN3C1467?_@OS_Y;ZU/O
1.NA8(44D?V).&c5[G7DOQ>=g#OOVXGZdZF[EBSbX+UQa7]c1Z;MFE/+1HF_+(7;
5AAP7-3BVF8V,OHO0<>/<@S6/HI(6VRUN79O>VZDJa@N>g=>&HWG5gX-I?GUfLDA
cGLV75F_SW30VNO#de]0P\-]G#U=?B6eCXL.B<=EXM2\Z\)\@NP<D-15_C]f+\F_
a>g<&[2)eCEE;&JbIJZ-IJRSI@T\-QHf\HR1&dQLB7J3R+bQ_S^PNA0=R@^Y@2Ag
(+WV(U[O^VUD#f08=..DHQ0>RE&4XfAE+I(U\IH#-e56;F=d,\;G4+FZHbfb5&DA
E(a<c))fK<8U>#aV,E4@]VAU>+D-+(X4Ye(4<d^2,44H0K-ONg5H\Zd_1eA:XCQ5
5VRYMY#-QR)ZebfdQBeJ<HVI3IeWSA7.;7..G4Z70ecB^C?>GJ;Ia0P-cEPMB7Xc
YLK^R>B7I.c-Za1O7Vd?VK7P9\]M<LY]GR+LHd0TBJDfY6+R=@_@=DUeB[X-&Z^7
MLb0a2d6d#FE&49@YTf>=AZg:GQcWEZ.GbTX/cc\\FSfFCG][?O#KP&\T@(I@HdH
M#K&9:,A<1T+RFC\f]/JMT=&44LZaI)ATfQ+B^N>80_GYY=B(.C1O]B;AP=52&,0
AYV?4cTLE@;\=K+TD6N9U,eYg788ZX7?R43^8)ZN_YfKS,&^N69C:QY-86E2b.\W
QQcDN>\L:&XG;decQ>dOCYPLS87LHJODBQTTEMC&\07[7670FF.,H(LK:F/b(M)E
8gdNJWE-(;LE3?G@e6e;PG.J^&.>5?[3&WFV@IaZA\C2^:R8<1DYcDR6+R4e<>CP
bN]76b5)#)\6L5QcD7&[OU76<-Le0K7K/\3]A&]#G]34<Q?LP/4g=4PGIIaa&8ab
A6CGb;=+H+F5M)^_,]GOX4Ad[G@HeRY6SbW>&KGR6H]/15K[([;>Z(9fM8?eEgHU
0R/1Wc(;JRF61#03V[23^M(K;\ZS/cE3(:V++;;M7d8bX;J<0a;ceK^6(6,809SU
EY&3,SF4d,H6GEIW5QOM8R.Y0;PE@bD#,NY3O9Vc(GFYOa1g5/Rf0U&(84B8B<-b
56IN1S>,H<O:a>ZUaBcNN0C26D\_8c]eYYLe?Qa)/.1>WgNKgIfFMAW9b3gTMXHS
_GD]#fFK53L2(TVe+KNFRX24aS)d.CD6_.#K.=OB)fW<IRIR+4a/GWH?YQ1OF)M6
3L:FBK<f?#ATJ>HL4_+Gc8PcbT>M\f-S\_E6/45VABc5H#Z,=U)J>^JDDQe<A7Gg
a/0EY^>.3?MC[SbcYdB,\RG^?6VNBVQd8B9=dF=f+@@?&.#I9DITF],DQ2()0[c&
f9\XT@5E,/aXL73,,P@<5UM.Ya<F_Ac6[9XQ<7Q/]P3EI)c9VG]>>;CRAYAc2M7Y
<0(OSG]/9[6f.<cd(NUR;g8Q()E7T6IgKd_0VT/^A4dL(TC/a]&H;)fB2.<.cIW&
6[027U6/A]f[P^d\P]()PY;OBK\^?e2]3S;(8#P+<&+#GYJ=XQ=Ja,F3&C)Z>H>\
;FRDCHQAJ3WbUJU9<>(8ESV+<?YXYKa/^.0db[<f9/e(+ZEcWaXgBdTB#cB3b>g?
54+O-PeW]+09QU^0KD]+\/?g@3a1=RRT63b,.IR<4Q;2)),2>;V;YH&\1g3Sa]L@
2T(1K/Fb::]K.^LN1VEX>Qc36Y]fVP4Gg+GQDSY^f1XM?a^O+Gg/\5UScW4C#KPY
PEN6C5@Sd3M;J1a@0Dc^JYREC48KH0GA(bNgU_OTE5U/>E]T>[;RbDZ+IR9Y(fAf
6MS^^W2GF@b17TeM4B@a<AQ+T.X;W@#A5>Q]V+4/.cWYE4X)I#-XOa:,FCg_W3KS
5Y,&F@2e5UW+L+742B66V:+IX),_[ZNVTPA5/Aa-f113KLeQP2dDBJ[+Hg(/W79@
0\PHYC^=e\bA:)HVVAX/-:)5EF/JMSJ4^1R4fOdgV#V^#F>]IHYLRB^-Xe4Z.U=E
S,=]VcC3,6O5)<2>-bLbCOFA)f3N@+Z>@0/9#TPHfA5ZFL2V5\f?-B2#&_^8UUIN
^/,:@Q]4X@R<,>+.KHgA((J\;T,/ZC3bee_\P:\BLB>PK5R1T+<48HNR+R./fIa=
\He0XC]5>F7)G>L6P,<Ze1B#Y3)a\cO(7a_?#GB1T6eD53H,BCVH.V6K.W)R=1ET
S/N#?<@30TI@]HT9PJCJXD6,L)fG-?>]e<C[=c.[E3^bGPC^:PbM?fXfCY-2ag]5
RJKYWbA.J_Z77N_EEf-R:fAB6R>/COJS1S3Gfa^8IL^SUE6&4_:/5G@e-eTU+2=L
c/C1#A;)VF_;:M6YO&@W@e-A]fD46BHT+/M521[cM:[JZDWf4@cEfSOO_Ng?FdWS
RF_&3I3ZHZKT0KLXL/<Sc0<\@M?>Bg>R(0WXTAE\b3:)e/?)+=UXb-_/^-M^8T(G
U<dD@O@8eJCY,#9TEcM,13WRbX+Gb=Y&P:gUK@dURe:c\ASP1EBRc7dg)Wg^KbT)
4V8^,?3dHJBII6E?A;O/_bP<&H<,2b_0ON\ABa?Z?=W?d(18Vfc41BOW0X4+=@Cg
:H6;65CKF,/b&G7dQLcH]XHQD64YACEYJ?.69N2:4?,=/U_Z)+(VTfEg;#9;F:6N
2;@2D^be>X<I?.QWUX;8]4DW6ZgffDEDDWLZJ^#c+>O:[d>UA[gQZ8T6?^[:dA\3
Aa,50CPaZV)KF3@2[8L0eTgg7CB#Q)_aOea@AEDJ<^27J.+,DVPc;:G\S?0I:JX#
@,_Fb98d,bR_=W225440#(\bd9JI=0:Z9OMA,#G0Y\AB6Pd?JXQ=5_QC=gHK-TC?
<Y0XT?V2S629.0/MJ=G2)PQGS^,/S4TEZIcK0:ISLUM<fC&fE:PPa?+)=0]3[NR_
<J;&cXXQ_5ADXI[Id3YJ25=OPB^S\)#)V?gP>EHNZ2#4U#P&.01?e[b[Y#9(^&,d
f2/BB(F?4F.,gKZAKY(;Ya8OS,2Me3Yg1IZ8IZM\TNcW@#KNHI5D]c3+M0A,f2Y,
+#WOMTX=86&g@0\,,?;T(OR3QJ\bGKL6gK#R[^WT)9McEFUJZH/G5Md);c25[SX:
=6;E;Hb-;&f0@TGA7Z=<A<>+AFOH#[;A(F;gE@f33V<Z.1H-,?\QcO]caKW^EQI2
bFd6F/^c=FX0[3e3gZPV0eINOA9@O3C?TY):)[..H9OMGQG<6Rc?T]+)fO55Z-E+
98gDVI5AHK.I]5/7;62/]X6M,8KgY&DJBA)@g9Z[G2^N)5Z7:+EffL<g=Q[JeS3Q
OW=5eZ3fQ-8FWNJR89RJ?QL]a-VP<=<D9=?B-P+76U4G#B&S(PZ3(23XEJL0K,K7
T(fQI67>WY10]@,4gHJ+E?3SK8Xg+<gSa@KX<T6cKMA21B91=,Y&:R?Mb7)DRSV<
W#UV>::<LPcaD9MOU]H(:GVEJ>-6?U=GD^F5Z:(\;>VW[&+3B/RP?&@ZgQD^(^>d
\@SfU607(2+c5DV3LX?,Dfg2+CTQA#Q1BgPHdd-Vab(3IEEOW#/EZ-<#7I@?1J?A
]c..ULCSDY+K1+^BXCBf:]#BMbdL@59(HO^KaO<a_K(3cbe9ES_5Ca_3Na1b\M:?
D)L)40K59FZ/<gR+8W\CO31G[2Y^&N.ZUI&T_dM.5#C9C^e+@V6aLX]=]+0](3a@
-Z8+1QJYW?:ZEe?I20TIELM.UcH5E.e@0J4T,K-ecL404R]LTWZY:Q&fQ:aQ<)0Y
K1FZgfP](A?g[bQERG/MGS\\DB5C5\HScE;@+6eQJeZM7gM^/IR;1UYcTPY5d^UG
:,f_(7/=\>_ZPKI_WOIW0(c=EP:E)fJ_2+PEK]N9aS1ABN\54(RD7)9I3L#^GZcB
;\BOW8UQ1@g1_4bI#BF=):=A,g:V5SOW(0Pa3U+SB(51I)VF((c@/,61O-1LXL@)
XH;&>@f(1H-<M^\[2+gHK&(#MECOBe>=G<EL_=#H:]JW=C,MYQ7Yfg1G.?4TZXK[
=;^Xg5Z:#G4EAPc\I6R4D<YMTB&3TZGf_.GQQfF,N91(I5@K2.21(W-2?/Q/D9>@
RH4La6JGKCgCK<U;-Kg_a<Y6EJE0URf5Wc.YK<WLA6/H@e/L-FK43)aL\;;I[c1H
MH3(9=J]1O_;0J:W4T;_8B0XLId5((U<B/RMb3GR/G6G]EW7]&U,?QdIeT>T8TU^
3>T<70b:/^g:_YV1V>fc,cR?&d0Q<SaGcMO,GQc>=EF<Oa/3VO+2W.#Q>OAb&4RD
-/4QfS:#BdaJO]:U7TJ4YH[>FMF8@K2(U..++70?MMU:A&Q-^9KeJ-SZ6J<a9M)J
I]eAFEI7f6?TF_&H;QU6G.7+M[+eT(+JG(<^Xd2]3O1DOV],FD/):2Sg2O5^#Q2c
9R/..=N7<;PKd;:K1VT#PO[VURXC3_+?2TCG:8Ug2V4[+<;\8V#Bc<cDdE[7A1Rd
^9Df\O]JA8XGAgZ:9V_cYdRQ]J,80\#bYNP>VL<?L)O20F,^/)QNac_b3V+KOAH\
351-^]aUSU]0:>]P#@aSL<TN_</]_(e7#4Z<XD3Aff<5c3.[)U>UU=]3P7O4/6He
<RcUE0<@?.1I<g,/2@ZTEE_HHGfbB#1aaMe-\SA3ea85@J6SJd3QHCLS6GCMg2Ef
A[.bS]B6<6a.#cK;7eG>+W(077Tga=V84^9]MC]Qe3.IeOV6A,/5WaL)SJ#d=Iff
1@@d;1a/<,][^[M[7^M(.#Z5^WW8B6Rf\;BC;PH]38C=<de@_/P^5bJQ/B5.E;HI
gH]:-+L>dCEFX2SOR5JG1H4>YNJ:F54MEJ5MXNJE.:6e@+Mc^9.754E:XB8M8P/-
:)CO9N,3gf6.\^J6GHbeeX#L-7,_<J3SW7L>:C).=:EB-:]=-V-H^Ccc8:G7+e_(
YL]>29)OH_bQWE4IQ#EPZY@=7S]8F_[;V[HUZ\Y<K/DY\12d0Yc:.13B55H+?_Of
1.T7?-\3_ET9a#T?<9#P5C4)8P#@[:_7BW<\2T+G5V=FN+[,;+:VW^(M88&AWS6;
C9Y]Q1UJ44HF6;8c.JVS<)GEd,_=JOe>_TeINY+Yb[@(A\eFJL)A<+;d23,>JV.O
9ZSWb82EH+g7Z=@EfY7.0c<,Oee)Y<1Y0@ZXXgKb],F5D3^fN?8^CZa/.,2XLc^(
?dI?EB0=E_6N#DHVZO>2G-4N.AK>&IL0?7HGdEN3,cR60Y^=]1LCJT25CW,&&TMM
,NYET5\+bT;cZbVADWfV;6aA]?+MU26]]+_ZC\98MIN_RY63-0CF+Y?\He\e3b?d
9d@YYTgOLCF1?&fJDe9AY&-bWO005\X;TPGScIB>IXP<gNe?9VZW6V<PJg2g2<1.
M[;gefQ8SMQ4+(8JNc81Db2_41&D)g2d0,d;a[KBQCZ38d,T=?G3[&(V+3;,N=ZL
.9f[YYJ0E?ff]4I=,L<_L&&..OHQZQ,)4;A>\e(OUPQ:g1CUYeF[&:/59dV#\//1
A[4T.EOC9(b@eJPB97P\Q2Ig6NJFc++JZ1XX:N:A^A@4+O@B):RN-(#+&+e:\b[_
FfT=AO&f^L-EDPOC#cdW6]3=2daVGDNFb#@&>P/cE>D?C.E^aG[&c((:7c-L?AX^
2d_V,VYTDXM9GN+-EJIO@cYAKH(#?1<^@ZBd3,W1H;OGS/5P&QT04NVO\U^]VZE2
8^&;6G&g=eO8CJP(Q#2S(4g;3[JV9B_bK8P]5Ibb@6J[WJ-bB-5X7M3Ja.fZP8Zc
487L\A-+b+dN1@+Od4@<MWW,P9U4@e-fLG&7;CG/BE[ffBc,_9_8182=5R@aCVU=
U,<@[T>A,=]^O(GJ\REN;M(Hc]TGKa7.@JFR6/eF^e)]bL-]82?N9G:))\,&WYED
O/g]TMd=cEHg]a4?VPFL/2c)(SO@0+&H]>O#<@aWQ^Z.1e?XVE1I8JUbDgKFC-=g
\:b^)MD-J->S,I8@FgP1,W2348:Xa8=&]aHNg_LW^2&G89O8MH7:e>:0Y7O/;_Bd
a:.B8597daY]B3-<5e6;W7B<KKdd)O4J4UN2A0bb/3[?WBK1UA4-)IH(P2V9>M-g
7TZ]dd:HeSP?-6E:ON<.MJKdT^bNA<eE;A]IY4QIGZ3OFC<79KMV&@=ZK^O\EJH.
=^9;c6QH::WPD@551d)Nb202&F&U_FQ5;FGXMONcBP5Q.b[-?gSg5DV[OMQ>D3,@
c0>a]4g27Wb9g.#1RXU^W#RL-TXcXCF9A)E)KCJ=I3.J:#1KbVV2.f=R=>7daQZY
cLGY<DWD70-DH=AK<CQ<D2;3PT72fW?&bO);N:fDffc3AE=J.1EZQ\HRVc+T#-H\
S1[HWOg3[bccfH(G:+Pg@?MOT@6=O<JWMG/,\PJfId(VE#K=R4C7ZSd_30PN;?UC
S2E^5^=W+Y4D^+O(YfY:MDJN++P:Be=eOEf1]1SbWKU_a;c9]^7RabHG6J@C9L[?
([KJ.SK,6F>+UF;/_+f_YN.-fCHKEA>L,HW^e?[(&D5Y,aNX^Ya/?,OGddU+@PdM
?YBQA>&C@4^[>/Z+9]^/<Y6/AP><>C0U\VfWcEV_P.d-dRSK8<E/ES@NZ5@3S[UQ
Y=d.Q8eMQ&?fEOU&f/>g:bK134f&H55O2MO/SW_D9f--#(Xb#,-5(Qg.1;4KX1e0
g-:@\9SU;DRC7FAR+gD#dU6=-SOaUJPeKVC,P(V)W37W)2]<dgd3JO72#<MPTF5.
fH8=.(:8G)D;^IH2@4,b_1@Q@;03c1+F]<[/+W3+7LD@7+edJ^[>gY?e6.,c@DDe
?^<[5(Z<@6YF\P^,JF&&LAGK+/EBTJLW[V\W7g+&4+VNS:(DZW)S?/3?F@W:GbSf
A7&J9.\S:E)Z\D_1PPdbJaL9&OZgc(YH-;Z<^RM;]4WK)&3ZV1@@2\0W@Na/<BBZ
1C<7[?WZ<\9@6<UK>6a&,U;FJ+Z70:DA_)O2+(8X+0G4;3&FH=Sg?Z+^)\^E@EHd
NDT:-GAZA[aSEYLT73PF(]UFN@HG?:NZXD/LM41-?+KO1c-;=M.GMcU_<,fBU<4G
MXX5B@U-9]C=6&RC8YfF?+;a:1@OKGBK4ABYP?UXT(56+V>WLe:Z04.FGW7W9=8#
/+Y6ZN_QaF0@\:;9b_.\.=L/I]VJ[X6V4K4A-2PaED&60BC4WMe)OV:43;e2^d2K
)(H9[R3OYCWC]dYf+B\bJMLR-HX-G?>LNfHTe:G@CR8(V/O\XFZF6(XT&X:8VW8,
30=\PKP)GKf5:J?9;3g]B3f[c[?G5W_f#RWfG.8VdNSWL.Ig>;EN#_bE:)-XHMSf
bF@R)XRU9FXgfX-d@MQ,^;1.]dT1D@Va<A5YC(=0NUH^dRXA,)RF(RKVK7P(OHZ7
GBF+C,a8a>g,X?\X^7bL;@^U)_/[Y[MLF8NY/cVGDB>L:#>-&-T]?K]gD/WfAKF8
[0fSZQc]RB#[L+Z5\>TW4K]@AG<JY4V[?7>>H6\QaaS(1SR^;.P(0;<CV#6>H^0g
H0d]2^QC]#)7WTf5TTCRX<.G>6(MM>)AI4P<4g3VK7<Y4RX?Ab7)b2RDP=6g?(J4
S#OF8E94(bY]NSg&g/+fO2R1&)N.7J)J[f?aaA4bT-8D8O1I[<LT^Y@MbTXS[Z@F
Hc=3OEB=aXLa\IMcOL&Q+M)ED]:5BNM0JX/:fM7U7VG9W5f32F5KU(5]@Dc/(ISS
APXY27[;SJ=Z9b1HcEgb.(#T2M6GN04M?L]A4Z1X#\Y#Bd6)A[L1=D^FE>6^_)\]
b0KNL:f5SH[gD7I4[c0R,SD]EYe?@10#)3@-<_.D6)cPc\Hd[7EVdRW18CR[V^6X
^@UdITeX@G0/DAO^SC>:0+1Q:b_GWL\MA./1bZRF&9YES-P:^CMHR7fV6:8]K@HX
TU1O;F+2fF3Jd]3J?]7-H)J@3?\,8OZTL=4:c5Z/\=V=#1B2O([1^KFJM2X56UCe
NcOeX?g:--@:\QK1C_bD7M8@b12FB+9[:Q@RXcGGcPG_b#&OW@,N<JD:,2U?B9-T
73;0-++f1[2V34W#F-d8CNX84N3b)63^,T>S9[<N#JIee>aS#L;[-F7G.TH#]\RM
cX;:-]:D6.<),?OO6+S:UcFPgVWaPV1J;#b?46JV+QB0c=&=#I#ESMQ+UDYAG&<K
065X;]I2/>BXTc7<W>#FV5ITMX29]Y]3Q9N<AQZ8cb5b\?-MWH3Bg>XZJK-/XRD.
(]I.f>=J/WX7R=7/Q9H114[,<>2;@A/DH[]HXf^@=E@MN#XdDbc.838IE7ZXH8S2
R.W>#5&WWGg5L<-8._1(c=d?4P@6HI=UQSD.363IVf=JN@4;S0?_-FC#ADPa9\80
W^>&fH+&d_.[T^8B(Z\bQ4]Id7;fAW9FA=Sa4fUXS<Re5996#:&@ObQWCU2,3Z?P
7D^[M)M\6FEC<c+E(_)b(F@_/#I_QdY\:bAQ5SJ[2c4_<gTMM)bRgS(UP-D5XV][
L^,Tgb&.,aJP^WU[acY/&D>e977C\UUZS[-=;_3>1,9/A-.718S_2_\)X(dd5fa(
K?<+P_O..RL7]KMW#>,O^>[-V>a59NeZ9B#cH8J?;(=?E[fEH&6f;1cf2@H:HEL4
^:-#I[QefQ18OCa\)Xa_>@^SS))YPC,K;3[g;dA7aH?XQQg[/79.;5af@R=+9OQ1
6/A>TL6=8NgSZU-PD)F-.8g@C5EKY/#^2N=c=5Y.72FL9SL[T?;F)S78?X<W.B5-
Q1ZP[US>,ZIbD6)6a2#)X=EVgf/^f>Z20Z_)1B.:]G3\0,J>Fe&P8(BNZV[:8GEH
CW4^D_9<J&>2_7IPA51:N6[B7((?Ld504PBJ;R<gE\ID7X@H.2+E)Y)T4bNA]A(6
Uf3GS<6EIGBL<BP>\J1eGBK^U6ZUOZA\QS.VPRe(Xg1HJV@49<_H0feY:Je1QM)V
666TULLU)G)F>6a0(C8b51P#+?DWXJVF:Q^2Vb.IfC?c@PCeQ_GWW[+4#J?D,>[?
?GaNN#WU,?+Y\H,+=Y&\4FA3LJ#_EC8fg@CHCU2f?]+G04JKZZZ^++;aH2S[=SgG
0D]DNU4E)4^0-=(?1QL6d,QS,(^VEHIC2gCePIJA3[c<.E,Vc&MP?W\&eKW0g9A&
57.A]agCX\7WS8^e\(a&,NBKWa]^GP[(\DMW\-L4e0NeYO?O]&00HR998FgB&gSg
JPK5/YH=QVFHRS:;S+);,B^VfgXL/[.2IG1eO,bH_N;^fRILVP_;QTgKUJ;\fdM;
<8fT3S:,LFG?Y[S#G7>5@RIVTRBZW89_H9<U1O-?J]U@(0(LBagea_7<K(dI.OP[
:S&Y/HFa.1#^@X<I?O6SOI/HL@YZHWV;(fXcQ-HUC^^4YU=2H_Tf7XTZ+8gIM/#P
M7OOWZT\2:/RVY6B4W2Lb8I(1VDPaX[[d?2WbW:U<Z,aSc5V3#_L@,d/69/U.Qg/
[34.@-IUGV6bLT8&gA?&?YMAG75BV.M9@S^M>=8^Z6C5_R#1>gUS(SUZ@WHWc9_V
_;<8K5JUWe@B)(\(MJ5AO(REC#4SRPQD_&.LS,KE#Y^,ILZFgg_cIS5]BK\Mf^Qe
Sb\@E(4DB^dDVUf5H&_GF(RfAUEfXQ&g8(F-5cW#ge-OZR?.VV0)=e+OX@ZE>P]9
B@c825)V/1W&,B58,;29b;KM#N(//gbP(Yf,9)GeEBA0fg.&6f(XN@\6gK+:M3?W
KN#3Y+PG[P;.?D9e/aD]\S/Y)_cNe>X6f;0O)NA6@T.\)]:c;@0<ddV^K9D3VR\X
b4E[DY6Icd:)5X1cWN9B+Mb]:@ZT\U#O_AT.Q)DD;9VX?(f9Zd&;+]BddcI6dTBR
GVAc5MI9X<dTQP;-@VPB.X:QDKd)<)FK\V6Z3#C>U/YcSV24D/-)c5994E+EGGO5
W@X/F.c2^0B^^>J\e3>=9?Ecd:.fU;UU)g9E_^F4(C#a73AJCG-HQ==KM>:C)&:7
B@7.Yc^dI1SB50f7]KH7Jc=M_:WDMfaG63f;.E,_ARO5^7I_B#eLdbVC<\2GFU(4
)<DPQ4Z9<)Ud2Y2cB.FE8QCOOS2#?L4PZ(.::S>.Q>:6GGdM<8#PECf#^AXW6c>d
EeAVPb&#FQ4Ef\b05F,CMa&2gZgPfO\IBN6[bH>_,W.[XXJ]@5/OL^MdfMTO4QEK
;P38?02R,<(Xg0TFZ\.59ZUB7c.\#d[&_Z7BUX6OE&8b6e7I]&Ccf+>U?JSdd=G&
+YP5NL4GL/&WSPH>#=0WfWXM/QL6)(++WRdJ>K_QO<HLJ<8XA/.&UdMMYYXO^g9<
T_g,6YSRQgSJEN3-6Y4ZVL(_=33e[5L-LXKBg4Z\ECZ)3/&P2/O^=1=E#8&\S3Vc
K5/1#1KU>VIPTOBb\4O7.BIP@PL8BHbSX0<,71DJKVL#b>:N<=YZ,H_a2>-+4T6g
.?FOD[.R<5c33Xg:36fVK78aA.MV)?&]\QLPE:d9:5&Og(K^e8,C?=d7c=faXPDX
/gAS#U;dH0_=YK3D)0U+&@6UL?O;P-<d.f1\0&.c:6CAZDTYg6XAbB,P;@9+<gDB
QWcB.aWB._WQ<B?.P@/A5Q6gMZ&@.)\JD:E471M&3NU-TBg^Sc.L@eLVGI?.NX58
A2<AMRe(5W.F?@0(&_O?7B+eKL/F^bX8(Y(,1FcS02&f]g8Y?TW)eCgK9-Pd8?8c
E0OA-0WSXgS&E@>QD6d;9A[X-NcXLgGb+B5JOQ:O5K9,?^&DO6)f\>.eAgPUO&9B
\\S&H230cEeN9VLSH<&&6?.Q3B?[Ib@9BMZ]Og+ESJFV9VVfU3,MYUT&OJW#3dI=
#V(9T13IEI[84SN=d&G)],WDXFbNf4a4HUJ)g:b-)WQ7f:]7;?8^?ER4O?#WJ(/Z
,2I+0BffHZX_<YGKJf4C[K\8<JIG]U\M#L81>,.LD<^&@)f_bEB4=4bR9HV#<A7:
HY_V1b9BJ<f)#T^E&.+HVV/GBYNa3O:WUM4>17#CbY:L(MD7SO_1[C_+e@dY4>2?
GLc5cQWU?J3gfc0?I2D?U,]8^9GU00J)K[(g&dQ^NbA&\[Sa/EONDVc.Jb:8BgDO
<F#G\ES2#4G7[^PFdYeU0([W&BR?QSSG2/+^K-7#.a3K#;fU^;O^b;16_dDH[,2J
O#@QGP=Z6HcLPKV2WF;9=)gW)S5?S+&TG:&e\ORY?Y6RPC/EZ#d#>V/@+.B1A2\#
CA-FQN^U]e/XUeAJ[E&K&ca#6<(3;+K//d7(.Q?8ST(?NY(;[2^J^^Z[E=OC02(3
-+9IS4[B)E5M4?L0(AL.@P=UUF.eZ>E:VN:c,7U]4e0K@>bMXeMS,&M5UG^Q9eY2
/R>I_5L.-YR4,R)RD.H9>f,),+]=>C\I1@;5^=TC]RB^/aJHN.J4\,[0,6@]/eZI
1#OO=QUC<G:c3W?.S2&CEF5dRdbSZ^e2c=FR=3Sd]WAa(8XX-?_7;R\/N#906#6=
.0I]Z4)4[A7XT+-P@e^KED04_GK#^]Z6::06DSLeZ5L.10S^E3Vc49S(7W8dXX79
a:=Rd?32.I/;J7H(3Y&W@CFS:PG<;Q.b33a&+<-F_;a940W]0ZGIL(2#8;+gWJI?
:1;H>HB1c0aV57eVF)BH2O43+(K/CO/J&[Oc(D?bQF,KZ1.LALK79T(.-YMBLY0Q
H&M<-HQ(P/?;RG)-:B>^<H#HW<(3Wa1EZd4W3C6:Z/N,E8c3=1A_cC>3e<[EOHbf
2^=?9<<BD]^=7SV/B22d?>Qg.YY151Z5I9d=9L/,4d7MG5D^9SW?<G&J7c1ff@+g
)dPRAEPI>VT>T11FEE0c[a9DL4f-G_.9/[N1K:?FV/VcN;BVBP&UWVLcIGLCY+,S
F7H?3_<_.WM+;+UG/.XLN/;a3+H:T4IK,P20CJ+1g#KaLBN=g52<8=AF)gJVYKf5
Wa4(FL&/7e[=#0>FOL+Gc).PLaOSJA6NM<SZW\OHCG)TC7D<1.C^&81Td336RNXA
W9ZEJ#K;57\XMe@_1;^]J56P<SB709+Tge4T8cRD[IfI6;bJUD-N:BJdUfV]eA(]
#M;Z8Q1W(68T,&/=MU82EZ)cF2?.bIL0WPG^#:2GTXP1QI=?.9c\X\M9e+(4<fC2
5[O1#7R7fM;gVQUSOVLd(B(fK?\E\bF60VJIJ9]S[Xb1Ib4,6V5F0N5>;SMG<CQ[
^IK9B4EQV;))F\<>XYWSPd7cfMA7TC)B83^PeY[[76Y;HU<Q<;<H#[SfT@4C#2K]
Q3eTL=5?cYg>+3R55cdR=T,<5(NS&8[D-B<V,(IUN1de^gH[A9\M-SKcg3>c4(W+
b:4L>:(CAJe&54(OBEP@12<&U?WK-FUaG8W=M<?9C1(Q--Z.e&.8XYP.IAA0cP?6
3\3AEVg\?Gb]^&(=1E2R3Q>_K^U#G]1T;TL0(<e)#gCF#O+ZdcNgO:Mce&SIb>JR
1?g43S)fA5N)U/RbVe(,&.VQd.6bRN+6ASHVfW(6L\\E9M;<e?86e8aO4,^W=@OQ
?6Z\YQUR2-3(JH]&<E[F;U+ZGYW8S^(gS[d^;0T(=<bc-J)F2,9Bb]\G]f@H2fYF
F;@^3IdY4QY4C\,V#WI\C7@Ab8K&17E1Q?P+\KT1MZ+OI3WK@)JRFc;Ea/44=+>_
Q4V&2H2>MAYG3]6^@eRc.^P[f2?4HU.9O0cY+fT+<gTWCB.9G:g+bBa_3X3<EPL8
IS\1W&HfSZA;\YO(9BB40?Q5_7fD-D#@MW<bOXBGOS5JfY-bK.((-,+G2cgL(609
_81E.?&NY2453,+4(Z]FdK&3bE9PGA?HU1E.bGL2[)Ta)c])/-V];@3\K[TU;P,#
#9ca62EACA09/1;e]NVX?^.U#d&1<?eb_<gYWP+T4XWSOSP@J61K);+1MSQ78O(\
+(+)-WBQB3Q=QN9X]]#4DbBPH,:K=S>JPNMeUX1R48IfFW?7c&C#]eN+^F^fW&FM
X/Db&8IC[+U71BLN2?PV:E(XSf58D;S0?9C1gNb]B[PX^I\5(feC.g9RWEf<FgGa
d&RMNfIZ&Fg;4V._9X1Ibc6:eaWaC5(T^H]3(P(H)1_e[(agC^/d>T6eMZB-[QE[
g#\;N/U72VG#IM6aW)gL8^8.c@=(@@[^3HcV6MI6>0/\bRa-1^6TSY_6RW>EW-KG
.NcSgF=_G#dRdFAf8F]ca/O^M^]O:(dUN.:-_cb:ZMcc#\VK^1?gE>B,B><&G-E3
R(MK([.S9cB783a1Z>I=?c6OS//#(##0YMV;0O#dQ>(85?I_X;^I(R<]bS6>R;8O
\9WN4d\;OPQ,/U.M/UVe-U3Mb3HUDfeA-P,,V7;.UOe_T[XASQ)4NcVaf&_1.Y-J
R9_++ZF_M(C<V2UbV)RGcHXD(P&#H9cD-ZZ7a?:ZZMW1AFf;^D31R3#IaQV4ZA2f
114C/4<[I]2O7><;Z\:e_3H0gc#HH+@ONcX)]\U=Qac8-P>^N33IV#6C)IH]g#F<
?XeVd:=^Qa16:_?EJbL::RE6A?EYUJ)ZX07Q;P_5NY,+g3&>[c_9X<9#\KdYE/[-
9C&F+N5)7fd8/a_]OZ^UY:7_DScIg71/^=:OgKKeT(^21GSH<(JNH.V:@=cH@WCU
@31E6/2\W=^Q/=Be8]OTMcBR)>a(Q4b:Y9PW&f[_?LQ_ea&-:W??A?_?12;^,MGP
(3cGcX.DPbEEN;-NI/MQUO6bMa&6W_14KK7:Lg0491Y5?=?T)5O?dI>N[dSVW#02
QggA6bN<9<-7+062ATbGeB.0AF91^]:FEA\b)7g.8\OCYO4HES;5N.H0ILCcL:Hf
0B7FR9\TAA&AKWEeN@AgG;(=AV4eV;_96>?G)Q_BD10cW;U_DN3R5[dP7<&=MO?M
M<C]0Y4,eWJK=H)ZO5BZ[d^UEPLaGZ>CD]<[e_DYU[4M.#cTbBLONHVAT__-]PDC
1F5A8WTV75bD##O)[b.IX;9IaHf47O>@fU,H=L<KJ)e#?6;BYa\EUHB3VWGC7+3>
&M<DPW4b8I0G]7E;f;Db3@FbXRg/c.J-,A#fGc[V38RU6[D0]<7dJggTL:N(JR+a
4-2/&7.K>_G):d)7S+3LeU(7L6KL6J,=\NW+fE@e+YLB^^O2WD3RAVJK;]>3DgcS
8f3971B@6JP-c,MIEQZ^aMO\gEQ7X(IHALVQQU(4KH@48gJ;JcOf2HJY&f1c/ZB(
F,>B3K8PF_D4e8aEbef,:(?8+EE,H6d[NAL@aER>g@I1IdN6M0GfLTJ,9E)6(OQ)
X,<NeB5HdCZG-P6&(3(HSXM7;R,D\Ee;)QZR(S=I]ee.\c);R(X)1;#Q/<^R/=Q8
Z.F4.ECY-(ae/)\bX#=4FG@Q9(OG;E..FCU.Q?B>+a>^EHcTEOOBWH,E2eYOH1(;
/E?6f2TdW47cJc_]2E<eA75:c/6X;#4VPP]A2?&Y-NbZY]6NWTg0S=I3&]+6Y)20
^<V,bbU1)8_)HX\YZNGeI-K]UX:W;M;/;--3J3fSVdZ-1J#??KNV:P#HXPLL++;@
>f.g2\8O(_Sed^.H^CB.?L2a7_].].]3Pb#4+FUQ91Q/_aGV.M5^D[N7.3^OUY+c
0Pa7O9MX6FPEAgZ>#]Q#]V22Ka9g2UUO<_X/;S21^U6e?NU]X1f3(QVK+1A;Y1Q3
1358_RJP\PL5.&eYJf1S(.(,@61/5^KL.M?SJLT32R7VDJ4S?>]&.UWBEH,FC=JU
GM&89#<T0_)N#Z6H^W8a/GFX[PM:I34FL?:R;>@HO/2.H/#U)f6^RDM.)O95gG-a
]QeO(eb4;_0#G?SG&M/RY;YaZgM_L\:Rb=ZgE=6FVI;)G]0^F,BU;GXMN3IY\B<0
B80>^U63J66Z8]H^#E/9)XEI+_[QgAFD636?>#Zd+H:0A4gV&9W6:=(C)c7J+,8b
CW6]B8T5OS#g(39C2L_GM^G@I:eT3_];#T8a:/K4GXLI^YQX<EZIK:S;U<F9g))5
g\U2KPg+->C-@L::.G&#YccJ[VPHY;DXRDHC7[.>aBQXI#O5>0AOBZFcS7=ed.QP
XQ<A9WZ0EP@ZPbTXFPFXFYI9]>aD(1=([EPK-6:5O[4TZPL5-Tg,1\:W;O^bUG(S
eX)Y;/+;4><V1a07TRE?;[E:aMVK><CX_a>:Og+6Ba/D581dF71-e(#]RX)T2R04
D0-Jb/2+L2_>);DL&]Q[e/Kf672cE_DTe4KB/]UgJ-#?dEPO[()BB4#13/2+GadV
B>Se@SE]:EFa-bUY]@3[-)H#[bc]=T]N&4R,D4ZD:(=Ja#B1<G-b?9P-EX&@R98/
HT7XGMe4M(TB@fOgYU4VAV#(^c[Ab,;U]:5NT@]YV@=&W7.?^g@NFHIe,I4(Jbf.
9Wg=K;]-fUVX5P@?HdO7f\P5YB[?JJ;TgZ8=+J?4I[4f58R2_SSBDHB,T)_)U:MZ
b@;a.JC&99VUM^2Ma3O3a4NQJ#6MO#3FIRB:6U26dN,:GD-U6_/8Y6gG4>gVTH>c
VGIQ0K9ZQ&[D0:#?V;0f^X8fVGRAO+a<;^d44^0VL304;b#?FHG:OW-9_-R.;0,d
^[TCc<O5<+Ef#)\@Z-Q1)#d^D:b?c<;DAcXUQ5.)X;UVW.d9D-0E.OMHZa^I]e-O
e7-.5<d9.;AZWNZ7/KHM+[)^H8VAW(/Z;B&:dQTe=_IEL6O;&=fHE[:27Gf:KR^S
W&XBPF_2^\0D?@F_0_?^,]YbC+2Vd]BcOL8Q>7OCY6CYSK6_FWY3U=9<,>XDbRdD
UTMBT&64cg+AB#LJfHGES8F0A^fKd=dPPG\B(bX3&N4PA7;79KU4<+PT^]fL&=8X
#:-^:0#^9gL\I;3B(U]/&MIS]JIM8aa4]\RU?YT&Q8]LbGAJ;1\\HTH2cHPZIB\)
Y@4R4/\./O7,V\-?;QK3/N3?B,7_R224[=Q5+T9+5YZ07XgQ#J^5gE?^M@N6eOVX
XRfLONR9(bTQJ9VLH6<NZ;?KM?29_2(]Z,^FbSbGfg-a6Hd8XL;=6aQG;;^;Vf&F
fYP+W920/--Q)6ZV<CgSgV42b3dWVX-UR6=4cFZ#8K.=-8:3;&SD<Q5.N_^>AFcZ
fKXV\VdP]aSD5FWY<aMQ_/5c+#A@9\D\TXIV=f=UIBG+>d=?>&0DQF@1C\>97P15
;1gFe&L0/TZ&5]NG2BPR9f5[#:3L.76ZP+CeBY-2[?aLU7gM4dMN_@Q,/GXV9AD]
=&KPZ:J4+6UD@O(fT<^>G/I.1JfFV;>PC#e&X(HFIYVJ07V1S(bZ3]H@C5PA.#?^
SP:I#6K@R#WfX(7Kc.H-[AV[6T.?[^WY2Sg=-^M<?JRcR6Y>W6TcQ-#Y,c;T[9H3
,SY.[70[@\QE)RGdFGR0G^L.KG6aHP0/5eAR,@<#f_@JT?6:@a309+\7-4:<<cH.
.FgDDKT.a#.<ee?GfV45F4YN9VK&42Ca@+KNb>]b<5eKF)d@G#bKI_c#LbIKJPAB
#,A9@_a1=-UNI.3C3@dJ4^GaYW,/[>)UXW:DWV(H-0d@f]PZ6QIY:WD,eaHSNdS6
U3HE@I):;-8#cbNQ8,HZ_)#.Z_,P[cGKRcL;&H8Ba/_M;R2\Ya]@KC<Ff,27\7RG
#dB(0@ea;PZGbY0bWFgdB6C[1E=#Ve6E3b81gR^S2TD=_Y+MXWb__:EA<HC90&Q7
,3?.\&6ITcg@\Y3CT:aA&,aC.6da/CTLB?3a_3-TV2;/?WNg<8@73JBLcFI1(Y;9
/bb79f\&+cIE)b-[bIA^fE\U1H:A;(3=#>B6c:H]A6/=[MdN>3L7_IQI=TE>Y[(a
-\_)_4SgQBeXBeKX\)5\]=G9A;T3(&CQYKQQM_VPF,_Q>IAA?a_FM6&O9g/YYaS>
Ncc1@Q>652\AAN^R.R<ffH5a3ZPLb]Yef\-/IX0OPFPOfIM@:GRc=X7AC[HJ):dN
33KLdQegO^,+:a+gW^CEN=+(1W?82^@J1JF)TQ,,X.5<+6f@F2#BEK1X=d5O(1FV
54VC9V-\2@gKPC1\g==<<LC6c]fF.)d#M<-3H,@e,GI:&T&&Ybb&VJ_ASE/b@FTE
aWQ&8BaDa>b^Rff7[6576C+GXc1PZRGUe=R2JAQ==@e-&PKU6WMeE:F2B]1#6ITT
eD^E>X0B><a4;R?\8g98A=gS[,>Ed+^S1Q&9O-C2d(JJ#ZaZM]Xd8f/aGPVaV.&X
&+#E;P)JVcfd5MgUH8WA3Z\>>HN[dOH8_e[#<508K:0)3NELDY4,U\gMY986_OO)
.7YQL+PGHN+O4115-bI>#QS_aUbG9LDT#5+#[TPIFY[2Wf0:f^0)C#=EY=3#RFc\
DYLW<?bZ<.+N#LR.eGJbMSS:L]8.QgHW/(Q0:^/>[E.@KQAeT4MX1)8Je4K56\(@
HYcZ+2(0YE>JZXF4V5N[Ga+b&:3W,)d3>#57U_&,<J7@K;-29S=EVdJ85Ed:DAP)
TS]4J^/15fN&BeGI.4g&&QUU.(),92adWg,D.T[)PJB]a\>]/;#E3^9H04U)/>57
gV6=+[K=9+47UCNQ4aE4BS#<WC@#@3c@R06CZ0(.8_8^>;NDOIFUH;=D@T+KNEg5
_;QZ/PfX&=AFRB&?2)-#M36NN(fM.Y@OJ:T@6)TOIdgHSR:=Y#<)B(NYHYXH^ME4
WYS?)PaQRU9gI\MI6GIW-T,Fg/0]-BFH\#Gca47>XWXfL6cC&3<_cd_JcNVV59X@
6g@?<JKSO(B0M:;<LDdX-f,-)_(U:IGfJ,g-OD-IS]WIAceYTG0Y)GDZBaB=1fec
7I3cA)5O>aU(2GBDEF1TIPE?((2.FLY>^#,.ec]RA76Z7I:42EIYK#:NO_.c=fB1
IJc_\261Z_2389?GZ>H,6G><O&/A87:;KZ)S1fU:-,Q[U4HS,\\6O&5CMeM3G4VJ
C[bG]G4>+QXbZ9R))^56[KBIP?T),,.<W,)#NgIgM\O@W:a)L9)[]RX^JGe;RA@?
>WA3OV^gPJ_\FV#-=&WQSf[-/7MgZ_Y9(K^3)T,VTS-/S;=V3fcJ\+<bIQ\LU>4S
#NfD#BT7U^^HB-W&>OZZ<25SQ;g3:UUCD00NeFN#>@PQ4X#,4.E0=E9ZQ7;8Q]5[
1Na@IV[])5UAeg>gFX0YVa[6e4MXO>JfMeFc[4_RbB6W>3OLVMO1+6HSD?1)A+d)
g[g]2(0K5,&g5?([ZAUH\5&.QU83LP=bO];3d&V7dPTF37dAEBL6(\0)T:W[==Y^
eOB83QX&(_6a>31;(,<<WM#HU4,fPMIIU<TU5FC=f#dDZ0-d]GeeC+P1^:KZ@\DK
1]9I;;NR):8-TB7H0^^&3b0\J,R3Z1-@3>N&EOcJ8C..XBDH&245E/Ga<)+CNKKT
;MQ_7\Q954bK8[<1\WL#bI[?5S,fd2.@)_7bI>b6FA:2A2F_.I6gd[TTUH0V#K(7
c^WaD5O3+/>;^:7N+P,;L-O3)Q<g77=I@RY.&bK15F4B_EI&KfIN7X1UgKC@>0f?
GV5D3fGXM5X?YQc(R_X5,79gCDAJWI5M0JKb^LX=V9A3WeL(L<BPD:MOX7,aVbNP
K=(-+@MKA\>_VeUL\5RPW#H3c(ggF<0GS+0>6&YLK7&J=@YZAE\E9UN7Ja.N6OFb
//W#(.D&HMC\G[3a9a&PC:3,;_4ZN\IUTCNVFN6/6)VODS_F>DXKX5FQ=D=<fJU]
eP0G[AbB:\E\4NG\.WF;(=DRQ-e_^,Hf5Z6FS8L63)++H^c2Z<N5PbH>CAW2D^/(
?PV(.-EEL,1\U&BKXK9P?X6E,Ocee^BC=YZTF.#=[OK3K3FR7_AGI;\?bM(ROM>^
daaHaL;-/fB-6;>V6?/TEYM-^M#>[9LN(f/805ZdEG8(M^8G2M?3TI=LN:g>O7>D
/XTd0JI)b)H0LgS;[+gNN[2.)Z0,[(:5W5g[ES(8I@X(dd185V160U/Z_QfY:a-B
#7Q7@#c]3Ng6cYGFd_aS74#ICD(KAd#[>8E@?_PW?\]._GeY]+@Nc5\OdYQ:F,_T
/?F^0R-?BGBPN[[1\:/-&d7B6[03MZZbcJE0+#Q?8H3=/XYe-H3V>GRU[VeDW=5R
(-fI5XL/KD+<VQdaDca?+g:8Y&E_]0O4aEI\=]fJ+WS+3>fYBH,XYHE-gZ,J#fQL
2CF^C@G_[OL];)+be@NAYD<?e/;e2]b(d3G.YE[Q:3N1MP)#?dXSD@A85Qa_CJ?^
E2FJ<UYW/,SO#1[fN5)^/:PXW6Rd&?0O_3WV.cUJ68@O_16FYG&TQRO3KBdZGDKV
)?R;A=,YFU/OM&-61B70X((LBa@P<121^GA^#J]0)ID/.[(aO,&E#EQXJ139FT^,
X..ceV+,10XYZd_/SY9MfIU[2Dg0UM><YR@SE9YQZQ3cc=B<EU8EZSP(LK.PBO-,
8+H@-=V32^;L+>D)7TaGMd1(NP@ADQ#<YI9CES]OM0DJ.2J+8B[MBZ0I?._DB5>E
S(c_0H7K57(6/]-H?5A,V8AY#gMCZ_6aCa\?QG4]P=d0@L#@<U]82=d4gF2J()9f
H+17@M;>@KE^BS2_Y7AU&e.QZ4g&Kb0Y;e;0L]QeXJAHF4#dg++g:Sce/DKQ.?fS
0Z<&9AC(U6LZ8^CfQ@HAAT[)c5^#LCZ3O;K8)02HB;K]E)d\W9N#))8M&Z^<0@D&
c@MA1XOA/+=AOAF,L0R9=2BVT-4,gcB1U52A@U/&RA67#.P&VeQ6-:\NH1<=JQAF
-=WIE9D]+F?gcPe:;PVEF22SS+@_ZSMF=D#UL,[;gf)^c1AX_SA8>]0A61_?]@Lf
gO?3\4CCT&KS_HE[FFX6RE>]c[MD#M[;?BJ\Rbc&:gTUcEd[dZNJF=;&0OF)C8&@
[^<2X#5c=GUZ/RJX9]GCGJ.N1ZG7Q7=GQ(1WDNXM+STSD5(REZKN^#Qa867QJK;c
2[TF894K9EB5\?;1db.5G:JH7,3NgFb?0S:gBe8]?/<HIPUI4+JA.T=@QV_S[Bf[
V;XPRcU?/I;TU0?[P,fZA(O:3=918[,D?T3Hge9,,)Y5f,J&PMX1@T[Y\^V<BLaf
/SLDPgG(cb^LE94]QR54W)THH1.5SYP\YC)D/+@f2/+BIPgbO0Q7CXgG8JN,e&?:
0##=>]];-G/S>W01TQ^4KE-3<B-F,\M67+AVc.4QV[23@b3X+)X94=;>a+P<L=G)
9+a3+;.P?JW=0[EI;>>&EfdaBe-8#8S#eXT3g#(@]SHQLJQaJ>E:Z7a4(db8=dT?
_WQb=V+30E=E79G4/F..Rg7[C7Cg8Af-RZ.-6PcB<#?QL9<<(MLX.b&,<:7b9Q.-
D7-g4a+a_LH0:,?A+C.NQZ;MXV?;O9+aZS4)11/(VCO5V^bYg0KVf#(KQ3dRRW0<
5B+0;UOW.0b3Q/G:-[f-ILUFfc]1.feb&N8@EfI+#Q)ZT40d+TDe?2WDbMWf+\<?
^3A(RTA_OW/g&77^feAd)6\.L:)GRN_;=d/U9/^YUN9DCOD+Z<8]+M[(gZg8@O;I
P:f4YWdSX^X^34dbF:>c70+R3fWS?PaS5.(6MGWY7f_,XBga]T2+J<O2Ob:=RTK1
^aYUC[eXA\NfWLCf0T41?a.V?(cgLU918+YIa/U9G2Hd3\=37#U&XZJ7B0bDJL;)
)T&2\[/836&ZE8<#<]#+S7&eHW,(9M/D)L@Y9=5QR_-]dbg9@N84A9.MgY_7:QWe
MfESADd5G,MS_U^L@MY(R/FNU,L51=Q,N&-^O<#DW]0SNATXbZ2N49A,7E#Z6\@F
E/LAf@(c76YA+,,I5c9T3I9Z?aZ2-KU\OI6NIA8V\?;VO8F3VZ88RN7JMM&7U.-?
B:[U4:Q])[D8O=g5\XVZ(FZVRKBLP1-5?X6_V#=FWTdP/IKd&E>D[Uc?a:++(11/
)^Je)WU#8BCEM8N3b),6Gcbc+<5V5,BUfVE3(-.d3-&IS##gVA<Ig:b+RTb(\8e&
DX3G:9VN6+DcC@eO>K1\T4BEVYE#?NG&Kf]e5]YM\O9P+>#,cVZ2LTg[.<0EdE^a
AO#9Z?E+Cg7ND5SQAQH=2aC2J4?.R-MEXXK:7]XHA9-db5U0b?9eKATb[V.N=4R6
ZJ6P;JeJ.,QgW;OP^e]&OKLJ,HBLZg&-WGH>XY-g:\#3bZS(P?-L[c)#H)-<cGEK
W\A(Z22FIR+_3U58:cN3_/+)]:+?551fNM;X^E.Ye8c#JGML8,BgR/_EHZ#706-Z
9UZH9ZOd6<.R5<CQ[)ZF7?0;@]/A7N4IHT_F/PYD9Hg)KC\77EMIXFMK9<-/K0.<
X:QcfbKI_#[@UEHHR]aTJ]OA6XJ(#/TJcYC^EWTO^KUeNJgMK+YecK<9ReS@Vd49
(ZV=g5V?#DdffF.G+/;e@/#UPA:90B@OaU#RO_a6DaUKOKW1QdM\eA;5.MGRW2F4
Ac9R@#]7E@I8QY)I.O(LGgGD];bZcM/W<V_RdBg5<+8^=S&[Bg/_X#_QZCS+eL:I
GM-JJ.c_+W54:<4K;,-F3(eAM>RACXd[#Q&L#c2aREUf1Rd^JA1);Q7-71(aU<)L
\U(3_8Y@5.\-@IN[/BT-U[C60\O>/CG:[K.2J\]EeYB5?5bDFdVJ/X5=M;]b\CC/
Kag0gWV>Jd#<8/Q)NR.406GE[;McZ[6ggC(,O#L50eG0Nb@Y4Q.1C>H#/O_(N@,)
BgG#_;\=;WD@=NUKR]BI7agSLfU&G.7&FO.Wb=UfQKQ:#=91d5&ZEbSOU+g8,=a+
4J2[9/A[YWXfPTTTUXE<&W0J<OMHO-N)-gF1?+>9YB5I^.;dE/#Y&USJ[OCJ_Gcg
K7=D9bK0G)a];eFW<-W==:X\S6K33XH27>(L-:2S3b@Wc])1JZ1Ic2dN\<=A,G#]
0b@aVW7E8--BY(Kg,56JRF];(+8-.Y7G]+0FC0L77?Kd-dbL:cY6TZFT6^.9(_/)
+-@1:0RXST226#MQ^X_ST_7V5MS+:G8?B=.9#FAEH<[>aeYgM(UfTT^PCL04V]AB
AfOA1_B0<@7X=5>+d?WaW1<HX8@Z_b_/DKecJAGFS,IU/5VS-B2<+9@8]ee^LV,]
IMJHJPfJQe-BQ7)4V\]S>Of4XXL5]9AMYJ:TTM@aRDf_5>LL=QCF_1T8.OXc5D,,
WVIT4fe,(1aB:AH(Y?/@e>BWZP_/=_43]F1?\Y\d4A-HQPGHJ)1=Yd\]]4=CG<TM
LXUC/T0(0J+?ZS3&:P:Q(W:J+/:cNT7XXC5eb8F1:g5([_>egA9X_:TeWfb53LF,
^S-;50dN[Yf;@<fX23f^_N-feZWFW^U:[FQX]2&=N+g/H,B\Lg165U\VJa/7PQ.@
Ge0d3caI)FeNSMTgU&gKU8T]I;[3_&_8e@\g2>VB>.EHE.B&dT_,ZB@-@TRd@L=c
:5/RT(eSV:>6>&I\AP5H+aeaZ.FAe?<dFgKc<,QYF?^F?-MAGbX_(]0CT.A<OM6I
-fT3]eV-A/#b1G<+]JR78Z>IRA#)NDLGGM3WKVG?F>gCYKMMT5R;adYOO&172O3>
(MJ8N8AOfXMVQ;;EDYE7)?2PfA.gM9Q&,,Y)D7JGIBIbR.8Q,BH.-MNF;AaP?^N/
HM>DG]T[;E8_MO5A.YOAH;,RDB/T);?JI>,)f_FVVUG32FY_O+9L-BKRe1:T+G5,
(dE?75g=5P.Q9,aYgN;5a9QaU9+=ee]+T_TZDS]?\a4:b:.g6Y-f@?A.\T)H-/IJ
_AI)#V6-S@8W6OU1&Y@43C?CXTB+\RHD)P+1WB#2H;2MaRA.12CT^:a]1-:OX+P?
/6FYABTf:._]_Q#dGYQ[5V)N3:C[]gT/fXPDL3]/=UfOLNIg,0I:US<g,D>#@ZbN
0S+&55DX0EE1fgW0RJ)aL13E2eaE-##<A?eVD5]FL\Bc==;>4[ZZV72ceFS-YBE4
0,Ad\Md6>[C6]V,1:GX4)N)ef0WWTE8=eNR1@L0]Y_@?b,e:QeVBBf13ZHN7<&7#
\)\H/O1)7;g)#U2Kfb\RY6;_QYIf-I]aV/YGb<L<DL?\;NK,&+Y<X6eSX4?I461-
^0)]3IgB[N]P8/,[BAfWOa-c#?HNV=-dFO^EI]7>&,Yb4QE#<V<>X2QMJ)f,U6XB
0?)XX=7-1b-@2@+\IXac\+U680:cU^U.^&-)9M(BH5-:3:<-IX+;b7K5BObH7>NY
cR\->9<Y2,&8I>TC+D2C;<[IKGM[TT@5+-/>&>?d=Xa4[C+-VV(UR&=[6MJ8I\C\
Le&9\gdU<38J.)bE9Ub?\5:N(8>E^#.>1b,3+AcP=IIAO;U6@AgZBaPVa&WU,#QN
,9?DfgJ1H0CJ)BK\5#XT++8J2O44[3.H+OT693D;DYC@TV[8[QKY3?P:^O]8M&(#
ZMZSC=23M(+CBNc;_H)ES=Qa16<bAYL<8baB-+H:XUcY1_,?._bPVZ-Z=.cFW<4R
bJO=H@T=-/K8\7K?cJ;U6a,R\D:b;AXI<@3I2f=)5^(Y:O7CCJKMDAOQFR8ZE?2f
dP<7\P<&>WCa44#_Yf[0W3D&[CTFU5JfCK-M^Y)KK#X)Q&bWU:fa0@_<(2:W[VGD
;3eLQ\8.cD+^6?Y]gJM)#d&ENJggKeZLgX[:)M-WBYDSLB.?f/YHfJ4FV6CePOFc
+F]]JUN^-@g<]bWBNX7R<dd&)HeU0-HTKXgQBK(,\P8B:1QE+8J)N.O\[5ZM4H?0
/6LGGEK-1P5QXFF?GP63C=#,OaZ#<^BfF&P4--aaST[DdXBcINYV98T4M7BT,?+3
9HL&#_:U7<MU)a/c>+18E#HQ]d70ga,<R>f=GbM9,L@4NA<)<_N6@GQTWU^)=;IG
PAfC6_ZR:>RE^T=:LO@:+4gCaJg&?CZ)SAc.2/?5H[B7OH@()Tb;QDAN&^dTgJIG
S4(aJR+&cQEW3UgHWR/7,-TTFADHegT<7/26P,I1P]L[LR8D>X9#&5K#BMe6PO:L
9XOR3b.Xc96b[58.SPff)8Y((F-IC)dG_([C^D?V3cH-6KDfIfd^TQ,dNSQYF/OU
^PFCF8eA_cQ;5D7>0?7O(7EbT4+G9]53dENX00Xa6J7]#@f>(fW;8WENZ@GHXN]Z
,^,6#D:;8P1B[?KE+a#;&B3&<+dg?9_6]/Sa>d;VL7K.DBUW#\50f?.TY8e>J=+J
cBJ2RdWIfHF8=890(KWR/,Ge7R^#GPJ]eIG@=TKVFGbRb1CVP;B,J#cQ)RK^YG0g
P0+e+a(DJ@b77+cEAMbU\D/J@(N/.\#;+J\O.\J?1W=g>^7@R/FY_2#LVV-:)]W5
>0DeQ0aBGPET?@aXd0F#2^?]aZ/Jb9=RQ-<4X#__D6[G/a=f/.E3cNHZWT^O;1@b
g.I1e,ecB]_]a1A\:B]UEILa8fW0/WMUHc]G<\Jg:PaBZC3?0\VHe-dEU?)S7A)f
W;T\/V65W_8JZ1Y2c/d_T0HXcX&Z,..f8G;U5R6:+>361^Cb/(;IQaD0AESbDdR^
4XcOF:WW^aDKV3)5+d).]--^]\YTgEH28VE[CPB]^NcWWL/0GgV3eYW9F0+A@a,^
HMKcW2>5J8c&A\91DC1<1+(eaC1B@#1WT7e=8b0O.ECA9LgCICD,)IeAH(;2.=K<
DcZc+V[I@g)+^XJbGJd(aEHc.>5R1+YL1K:@6[-2[4bZ0<=B5DN<D8I)2)YeKbL;
-VQD>S2[d]5M;DRQTe6]AV3>RP35+P/CJX\.)4gf6d:&_CQ216aH^MRZOYQDODYF
7=AVFN0UG3[#:fL:cJ4?;;QK;5@g5)GDg3HW>^Q[P]YC<MO+:;+=\&dcW;-eL>8G
H=R7GSd<E7^Q9[8ER4[0?K1#I<O/4U5#Z\W:/46C-N(ZLJfOBg/=GeR\eEgL-R@L
[b]?H?VCKeED8aIF8c1(.T0S4YdBO1c_dJ+-Nf.MQ71f-,9Q]E<3)RQWA\NFg/TZ
f7O6MVT(a\NY8\b5]?[+=[FV[HdZ0.KEP:?MD\.LD095.8SV-4XaS53U:R8@bYZe
XGU=J<3=\KGK)e^)d-UZ17]ZBaKL)c-[JZ@c&,cZ,?YTBRN3LU+VP&4AZ+fK@?>#
JIec&6dKBY@\R58W^B0EgOHO):^Ng;WALA6V[#MDQXDH9)&N=EZABHC7NRGeWb[d
NH(>cW)&1:W_J]e6OK)+f[FT]+O_DOALHP8f],eKa5DY67K.GbfA0#(<M:^Y&#GY
^YAWT[c(J=d-C/5YJU&-@MN98@SUg9MW9]C]SY.K[Z9?)Lbf;eN.[\MUd[gMDcH?
d-;1@g9DXGgbX-^PX1,O7Y]X89bQ[#1EF.FQ=d^1P\BZ40\dcTI\Yc,N2SD8cF5V
($
`endprotected

   

`endif //  `ifndef GUARD_SVT_MEM_SUITE_CONFIGURATION_SV
