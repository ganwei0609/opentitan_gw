//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_SEQUENCER_SV
`define GUARD_SVT_MEM_SEQUENCER_SV

typedef class svt_mem_sequence;
typedef class svt_mem_ram_sequence;

typedef class svt_mem_backdoor;

// ============================================================================================
/**
 * This base class will drive the memory sequences in to driver.
 *
 * This object contains handles to memory backdoor and memory configuration, sequences can access
 * backdoor handle to do read/write operations and can access memory configuration from 'cfg' handle.
 */
class svt_mem_sequencer extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Memory backdoor 
  */
  svt_mem_backdoor backdoor;

  /**
   * Memory configuration
  */  
  svt_mem_configuration cfg = null;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
d7,[Bc1a^)/R83SBYI+VS)bCG-_L4U3SL\6H^\+O;b?GO3_?L>=1-(AKQ&aNZXcG
c(6/ab9IW\+08Z8gD(7T.fJJP#8Ua:5(4S:Xc\;>Xb>.dZ;_APUR?,YH_T_bN,b?
b:3g9@\E8MZScEe0);>@\BDN-+X_EK,UZPB6[EU<[dMf_GSZ>@):.Ec0-&3;WT8F
T(C&BQW4+DSVb03L3aK6/.<GF7@(LZQ^@e4IgR5]c<4fF$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_mem_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_mem_sequencer",
                      `SVT_XVM(component) parent = null,
                      string suite_name = "");

  //----------------------------------------------------------------------------
  /** Build Phase to build and configure sub-components */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Extract Phase to close out the XML file if it is open */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void extract();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this sequencer.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Return a reference to svt_mem_core.
   * 
   * IMPORTANT: This class is intended for internal use and should not be used
   *            by VIP users.
   */
  extern virtual function svt_mem_core m_get_core();
/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Reconfigure sequencer's memory instance with the new memory configuration object.
   * @param cfg - configuration object
   */
  extern virtual function void reconfigure(svt_configuration cfg);

endclass

//svt_vcs_lic_vip_protect
`protected
O<(H3+cV>67W_a;ZOI5OfD3JBR3WLK]0O._)ESNd62LAaI+F)<Ra)(]?4K=KK2ZV
gA9Rg9NRLL;7;?:5e@/8d:@UC,52dW4dJ3fQ-Z,+<f8DTM_Y:\T#cX4<[SC;U4Cb
dfGN0Jde02GH/RI\4BNBB6J9E,d#19Rd0,@W8aTg>D4K3?LG3gAAHdKfF9A^?e/9
>Me(X8(SgdB9d0_PFaU6-&M4;+&HO7^7&_D=9UQ1O[gII7>)[f=gA\F;8FW7FXfg
JVd5fVQKUOgdA76:[=A:DDY?14[VPd5T)+I:QI#=79BbfO?Y<L9aJ_e/NHBA0b:G
A>5>?>15gZVa>J/KK=gGJS6:KP4d6c=fNL(TFB<E<:5UA5R(_J3&3geCf]:_]R8N
<;BDA]]O+1>WTQ(=2YbRfX^M]XOFMY>(e##U#J\;-MF2aMfg[O,_d3X[[5YI\>QQ
</<8L+C:F>E-;2N>KFI:FNO;X#Q;J:G(.A3e(7b,_:Z,\VYWYAH=P_O)2>Pf?4N\
VEG3G@)IPA34)g4#S<-(VPRQL;bDDR]7FZCQ=\f7PE]WQ>QNI:],J0:^fS)-/A2E
VUCUX8Q_@Md/DR2e5[49fQ/aE,V6^8GB8SG?^c\T?+FI>RPfVY?c:A+OCOLK.ALS
#)@WVQ.7L/cdZM,Nd]F9[EN7H5A.>.g:D>_g#ZaWKGa53c#ON#N2&O?J5U+40=OR
^0ZM//7WHC.BT_-;<[AeFa79cGM0OS(\;:7W4)>f.L@fG:5E.R+B/9<4^JR#DgN2
;D,?7KS:BE0/H/4bETEA[@WGLP0?e);BZQ11aE5ZZ,MS(ID<>ZN0(P/Wa.c70gK^
:##<BK#aZXM\[)#XaT@@ZKTJZH0-X6R=/,A7.,PJEf2W,QLg2L:JdQ<5fIL>(LN4
6.\?<>-@FQTIPLPL-TC6Q;YXM^)fLHeM]CDAf0W/@0_HF=<;/2(<<>(BMWH?f3MP
K7=ed&G::3d<S2Y3JK&X/2W=@R?#>f<T<_b@d[b(A#C,)aUW(?E=RaU:L<;#MV7G
b]:(ME-NM]Td(VKg1R(_(MfP.ge9@1SIc/9#S+;RG.Z9IU6SV,(M_)C]af\45X_>
0]R,=ZE1-@&)-6Ma]39:-,&TMTKBgTD;0SN^P6ZeH=ZWZ+W-QFcE/K<T1aJC4;+J
d(N19H7JCM#b19&[3L?f_UOZ764\eI1+?dC&Q7:;8):8.+II7MJ806cA^X?.+=+Y
;L@4bAY/Z#LA#.>e]W&8<8=,cggT84/KQ)5ZN-]E0G]LZ1Q6f_^SQdKLNgB[fLL>
^bXGLUDSBK6b5@;HM3E:[;@IL^UG,Q?SgeY(BD=a0ZPRE-Y5>WBWAPd>SWeKG#89
1PZ)18J#9g#4RHO@,6-I?2G516WB;B=gg1@C1KNR[Bc4D]FL?Z/F-+;beDaZ@XQL
^5IQEc.Jd&503QLD&#&+Ac>df]dXbSa6JBB03TQ:f/80@E>S8PKRL5X6A0Y8gFSL
>HcIc^S:Q6gG-?/8@+J?+&T8D2X8;(<\Q,JIL@B@&BC4TQ_(V;+TI=.H9D9RL+5C
dBB-9EdTZSS^2JLCD#,-9CAU=@c\20AFGP3YC:XYAI:X<6gT+?E^4ND:XVce\Kg^
J590TCG7V0^IUcL^&M<@2USW:O]<<<d_[1Jd09:\1@J@gO_W_OC.F+e[a80=,_E0
bd?2)\=AOY35F10X;-X,MC21g](6)S1a1QCY_T;L5OH:\Ed<AUJc/[2GEa(PDN-=
Q?D.R[?@C\5^;A:51L]bIY^Wa+.J5MT6K#Efe9(>MTZRU[._-ESbb4aSLL,]8K]K
8F5+W]N&P(SfVW)EE^=gA,K1=3:\(L<aeZcEb6XdY+2.3[@fZEPabf?N:=[)cIA/
\NAZ<1WXN3&-#5@81UcJVW<7FG7X@O<I,76^YX=H#W_EGK[b:7e:a?+AV4:f,W1B
<?E>f1OZS6\#BT8A6RM+MC><1bOE.K)&S5#-Q(GVK13d@TcWCKI-B[ba+=+fWaBQ
..e&f@-;PX:OG8SGfN6,Sd4.U>2X]?CDAGPCLIPL&=RH,E^9T0HIA><ZWLFVM_YG
Z;a7^Y&Y8e;XaN6\-H8,dMSeVUO]JfI1V6d_7X46#:S:T4H[a3/Tc[3^UPc6-/bY
+6OXC:\2;IF<O?_C#;?6-K>A#F4d[X\U1.<#Hg7fYB>(I&MQ<ZAU-bEI0LOUJY/W
8WU3/;EW7X76UXJ4,SU<.HEdgJPC+;=4=-6d[F?4\(P5]RT@)TREOPfDH.;QZ(b-
:/(F]9U8Af1;=Z.f=bRa6@EQ+5_,<L\.e^g^#F5-P5+VJLI;):P^:UYV-DHH)&.&
88-LGfe]PI>)_/gB(S\#:Z19IG-aBa@Q,99a9fZ2HEUFfKCT[:EK,@#G0O2]A[7G
.3A<_NTEY5:B&_Y78&=MUV25MYDf-RIB121;8S5OI,R3LD._f)bAe0+QXF?=)NP0
K,LA[,:#WJ:&_^_WbG7\2eZdQ0&)(d?X&#LWVE.(+^AVN4)&V\_FGM]I0):(4Z^7
f))-)eMGPJ[-dF.WKE8=;.YNQcGHVUL2Q5S-I<JAK2?@aG-NV-b=73g&KFYe\0U=
+7OYJ(QUL)I<O@0?&Ha;Kg5OMTC:f]1G?6_dI6PJPe^-V87NTbN,bWWP)4cL/6&\
H/,+WZf\.ZLb4=6,X2b+dEF,QK4549Z][&&1>T3?S?>F722CeF#-(KVbDV_(V7@Z
?3Jb611?B833GF9g;dDU,OBC8>09C9)=:J8/a-62c[bP?]PCNdVfbH7:I4A:N^+<
ITT]2dES.NX>?d-H(D7-dAD+1#;TDNNDG?J;dOdZL[6KEB&0&/>4#Xb<4EE.OF=^
g5[ObO7RR^C\ZNH@1>?dCPg7RZMV^PY1d+&M6PNL]H=)?A5>]>DYJC]1?J#,F9@>
QYXIQ^F>g:A4G>5FeW4C;e1K;[#ceb8MeJ&T1dXX/^X6)IHE7\ZDg1))LfP/UH:I
H)e(+fT5;fR\(bUHB1E9(Tde(GLW9]:R8^:M(_T+80,EcAf,09a>TC(TRT6SUT(5
K#F,ZK;Q5XD:1AgZA&Z/)/:Ig?HZ:72GcCe>WT:0XB2;^(ZdC)1.Jfda4UT[@7U0
]3XFK7@=NF;)He&B+B].4F7)NOf@?0Q/GV/XB56N9Ne6Pc-GB9:D._I9TWB407fT
3-<EWYE,-cXc=b2_6L08?W_aM/JZ/(-GQ/bS?^0;.bLd:F7g-@)_b>MJN^(\b1P#
0K8<&d/99HN:CdX?)ME&21A99/d):3S6483(:.LQ]8U=#:BPWI?4YDB35^=b\R[A
W?K@S(?<KG?#XJE^I_aO.-T.C,HA#_&.[G-HHgcGa7Y_I:3[:-acJ^,g[H-V><S&
_((D4\MC-M=<@\4H.2U9=82c9Q[;V2c9H\dVZ-:VN.[4KF[U7T>IS?g93gF37>R7
>@UWK+G,VIO\J1[:&7?>Q2;3ETdQZBZbX?Z:3;Bd._(LCJC[>UT2:E3\VTZcCggX
H?Z;<1b+LT(@7->UBAGNNG-[YL#gT]X1]cg;5G]dGV-5>S9,I?/-KJ)S7(1]V,[/
VdDcZf\&gCM3I.N_+1;SLBJ,I\(6WXH(J1)[0KXK-MU=@]\;-7P6O9E=)>\MBAd+
#cTW[,>af]9YDcI<=09<P)P,@@&e)PK.+#cba)FCX@X__=\)Wa&VJ_4PIT.c=f44
#fgJ]6K;B4YFN0YHXg^H.-98#7P7RcS2:PY15.P1QE:\?LD2I._/O1[6(Z3=VE(,
4:cH&5MJd4L=7LLAc;E4d0Md_336#38fCDb6&]3[[5<P76#dR<7F.5aYQNJE)D@d
Z9TDEBc-L^BHUS&)QOGODJ_(bI:(<V:BaY>@bMcCN?Z2BLWQW[,WKRIXI<I@HeL@
e@>DH=,JdaBF;9K9e_Z8^@2JfRDR/K_>,Ta?6A;=?&XN0X>R_&QBa)A=JMcTFeP1
2+gD&/I;5[06DIRAD(#0F,<WV+FAB9AJg91^7\U1WM^7Q&HJL-&GX?ed8]KJ?6GN
;+XG-77c708T>b:1\Q+HZ(&([WYG6F9+CT<OUKdAZ)&X^XT&D/@#IbXP[#QV+dZ9
H=P/\W@Q?6@/?D]#Zb9_12HTW=FVC&MgF\ZY0fO9Z=M)5(Y=/#0X8-VRK9:9E;8U
T^7=;,U^,7.b#Z#A=G+L,7:#&11dc^?Lf/I.1GGL&d@_fdY)H?/@\?2X:ReJ,0dY
bd4WIU/@)Qg/HS354JMW<VJ_>_-?,<^aER&RX\@X6FTL+RaB^12DTLa##>106fJL
.B8?1A-W>YT22dLTe/-)=@Z/D05f+KLC<G+.CDJQCL?36;g+Xd.3bUbVI)Z1]8FJ
f(R(Ed28W-]\_Ae9S;e5+)5Vd9_H.3BR1D39T0gBG>T056X=Zc-Y1_,IB2&6;86a
LYd8WI>f6?]18@85PJ9FGECaN.b:PLOKTIT)19fPbH4+_+M,NQJbd3c-/8U/.:eG
dEHW&=7[Ya](/fLS4]\ALPP4_:GK-f+&SB@-DP>;g/NAa@LQK+fQJOQ_-9,##PW=
(;FZO4R]T7D59dHM)1(8.XcGE/,Y#N5#cNS]PCZ,^Oa2.9-0@/[D5@R)HQY=0^DJ
(P64]eKLNR^=Be[HgLH^YR9>gC6A=)Y-NdGP&;OCbG)5NaF22_BS55@DJaF-R[,E
_)=R/F@QBLV2XAP(+TAcON5[:SXOdd0LF(M6H]?AgJ2&F3<ae-K=FKN7G2>bLU<E
:3ZH5Hd#40O>PeL-UY:THEE(Uc2DHA;aP\+1BUgWHO_?V/J/HbTF\LHa-J^U#_f_
g0Xd0T?L\I,#UgXAGe0eZgE;SLe3-P^f28IT2ZXWW8(/..(7Ba4VUHK[.?g;>5)(
2AaDe]TZ/?\I5#PC8]DAN^5_>&M-3=Nc6X:&VgL@fOL>OI=DQL].HT:=>D\TXU;T
X;GdQe/V4&N?=EZOS@0]4YN/UJ6@-P?&,#dA\M^EN5JM_]O9K6EcG1)>Z5PX+0E^
#3MIKR&;>QVEF38I;X+O(c++[P=2\C^fa7BGD/PVJeLA.&T3.A7Ic:[B\:6_J))>
>1e[KZ]J^g;E4K:M1@R2E0_M+0GIO,?:SB>PHYC+ALY9D/+[0B<)\15H>0A^6-9T
C.+&D)U2:4?Z>e&G9:gPbI_,-:T_,dU84dU)^e3&#_&-WB.NeTBN?JMSGd=L\J;5
eQ0b-I<@[WOC3O&745f@??S)NY8Z#-.PP&;AO[PN\]@);ER,a^0KL@dT(BNJFTJQ
2LTb@9g]V0CGaN09GGc3\S5E\CZ&&/)@>^M:=IB:U-/J^>0@adTMN@.B&HK7]^5Q
3,6b(7eC^(EB)I]73Z@IG@bC.N:&;DWG+&BDQ@:N10&0VHLRJ;OVOHB8?(e8;.\Q
7ca]2f_cb6gK-a_I>4]95ZM^#d#M.dS7&_.7D(KMT0bYU3O/FF(@UD,X(_8b+,\HT$
`endprotected


`endif // GUARD_SVT_MEM_SEQUENCER_SV

