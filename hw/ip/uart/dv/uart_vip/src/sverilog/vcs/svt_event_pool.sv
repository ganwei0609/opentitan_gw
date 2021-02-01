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

`ifndef GUARD_SVT_EVENT_POOL_SV
`define GUARD_SVT_EVENT_POOL_SV

// =============================================================================
/**
 * Base class for a shared event pool resource.  This is used in the design
 * of the Verilog CMD interface.  This may also be used in layered protocols
 * where timing information between the protocol layers needs to be communicated.
 */
class svt_event_pool extends `SVT_XVM(event_pool);
   
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  local int event_associated_skip_file[string];
  local int event_skip_next[string];
  local bit event_is_on_off[string];

  local bit add_ev_flag;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
Ge.&gd=QYWG(9fOKI7#3/R0?00SS5.VGR4)#D3fRDYXH=/KR9WQ7&(IU3&WM^4AT
DGHg;a=42QMgb;8074?OH3B&K>MB:/2Uf_9TC6/f>)6OPMSe.-+>G+L+RFK#1&OS
7EN6Q,NU9cdTJ1)7[-7,MgJ0\bIO+N.<)SH=]c6DbeFPPF:OWHe]O]Cd)1N:)^,N
=-K9a[e.eN9WW)VS4ZEP_VE218/B)AgL/E44DA=U[)RNb=_WK:MAC81;De,#OE59
.)R^W&]U-,@)0P=VHO&CaF8QHBFNHbYSX?b.]X4:U.2.Gc)gHe+12&7e=Dc+Qd_0
e#d3H-;A;fSGP&)>H+^C[AVC#,5]TOR3JRLZPCY72O)^GE61O0\?HO?=L4S>K:Eg
=[cXKR<18M^A(DIK:P4F94.b2[gO0/cQH\@XdG2&]+bORMP4EY3+eJNcg0DQ9^2N
;bF=GR@J,X+HQ.N^;gTF/,;]/^0_QdHYT+Z[[J>>?<S?HP)=;-T<T+5&]<\aL_eP
6b_<a8I6F.#M-E9>J&LC.KL8,7YTZ_22(+]^b5I;#P:;;=d(CdS8dT.=fGaZPNH5
1?LL_^T9CKJ@^P,CeL^I).#MUV&@IY,cdA\6XM=A011NJbXC4-JBC4/T5O65QOE<
YJUB^1T@WFd;1.71g1\[K.^#&Ab<PVSV(1MLe.NN=),Bd7TGgU0E686IMJ@-RD2S
-=,)]?&E0<A:K)W?;O>MMfNDJ];=?>bJVD03QYW_^ES8a]Acg;<VL=SJL+P=,gMZ
/c,O1e&bN13GDXM]8B7ZKeb.C.3B(?2IWeb:8fT)Je\8(RWTUd82[Z9.@4d-]RfF
HdV(9U-8a#HA+ZG#13]08K.F;a84&RfS)RZCCf@G[P:ZZ,::]((EEU_8?QFPF126
K8c8Y.a?35R2)>-/Y/])7Xd7b8,8Jb&KR[@KUR;eE==C(d?9C45Lgc_SF(L>;d?J
H[H0M=LM@>:IF>1F?KVgSfH5W38;B6Kb85)ZA+T/&3=3M(+A[Ea,JM[:1RdagKW>
6\YH]\eA+?H[@<UZ0\Vb(70<]LJ(e^#FK\@3Q):PZ._HY6@2B0O,GBc5Y-gd,8_@
T3Ya(9gYT6GX.ZTOVN.U&4&G=@<.7,_(N+;V)(G:Y?9RbH_E?]EI)FCf7d@=3UH/
SZ5]a]=JFg,V:d+KDD2dX@ZZ&A@..R0GHO/K<7EOMCOfR&>PVLXfPTf?9,DU0d=d
+L4_;fbF6ReF+EA\E36V?Z.9)_O1VdW<5U(RLRA<5fM;QNHIGA()e?R?Z6[&AcfK
.JNB+a=U&C1P6:_NMFc(fW3NZX[<Of#B(+=B//;P54QN+26CV_6]^TI8#&6c^;NM
ZQf;U@Gd0fSQOE6;YUT5SWDJg=/8I/K37W_.g^TUW,0fDO=_Z[G:371fM\0&2_\0
Z=HQ9U@2F\g2AP+5O[HYK9)cB8Va]+DgLg31^f5&A<f(aUKD)GLG_SL&g^Hf]#Ze
d-4H:\\RG2P:E9Rc<C6dXO5+Qb&244&8[Rb)<AV/8cE&584dd9M48<HL.S+-[fEH
g4(0+Sg7[#7&E069D5N16-KJ2Z\>@6R@+^/N]8Pc#O_)XP3O(MV&;4O7)AE,SW:=
1Oa7RHDd6<7+<587YMeZ=Cd748[85-8@3RYfS25<eQaBfO-57,TAQ20>EV#a[V+\
F?@<:>OCUDCQ2YCDDD.RdUC>1.22TSH7#Mce3<)9BAXVSPRa2Y5&3<EDdf<-^XIS
.9M\48^<5K]-;B=(BJ:S9<J2QVQ&1RbZJ#e6_3@dHQY9^Pb>1NMWD\S_8QgA-Bg4
:\TMH<]&XIgTdSYYZA)BQ(eUJ)->G2?6\=d>=]DS[X5DV7>T@PX?RO18^^&I=-CF
XaS=FG:@,,5aDTEE<,7d1BagYUP24>059C<9V0Y@G;-AF<>H&+PcE53_d2_35P>/
AU<3EbbQfg#[+FW<3<OG?UE\U>]ZEUC]TeOd77_D+Ea5\OO2&V@OID5B[-b._3[;
f53#C6M6ScAA-_GLVK=R48>>&VLXE82)D-KWQKUUQ\F0,#K0_G9bGEf)V?V2CbJ>
.2LSfdaH+C6WC3=^b9MRg.M=HgHF1512b&:Rc7.bYC\=W&\YNFdB)gX/N^faTIAA
V]@]_UM8V&aA__.I<)/;VRaP_2XFHWCO=?@5FBYF?fg_6,R]G6,F3Ga[O[+N[U)J
N<DK\XfN<>[<Q[;Q5B:OUcdX13N:f8<,2b+cbQM.e&>&YN=;S;b]+>KPU;@PZS</
BA0V09aT,)gA:XaLcK59,)ZIe,fgda,V0D1)LL.DdMN6/S<4Y4BDHZE?6X7-NTDJ
.[CJP0-Z)D?T&EG3O>fIdCEf7Q;ML;)TG5;bd35].DXX),^#dOA]K5e,[C7bT<PM
?<.[CKAY6X.4R5SYaKCL\H[@/X0FbXO1<36U+?X.4<QNB0b\AcX>Z7;B_,\QW:[O
:.bdPHS@8)ZOB>4PDP4G;X)LQ7>(_OT^Sa;GJ4#RD5..EBdRVL[DQJ#DPc@R7D@V
Z3<gY^(31]MJ7#_D6DUZd,XZcU_#:YOgeE.XS,^&+_,SUPYMaL9]B::I(QX.:?,Y
:3gB[O#8\;d+a<0P:cWCF\2,1gIEFM2J](H)V<c&5G#F)dLDM2/cQ8P>T3;gHD[N
&3c0:S_ZRgX3WT9U<D\K^Q;>O^#a.ZHg]TBg9^4>HBN>[g,fCHDGPeX]Y:1-<cac
;UJ_^edKOB-/CP-&0CTU>A+bX>BQ,XcJQDV5P6PCbg;9<U59.FS5MN@T5_P&Tfd)
F8S7F_fT2-6>:G/4\8^>B;C7,V6R>IM(2cAG.2B[Y,E=LLM/1O;OQYdK>;-B#A>5
DfJQ48S2L_U7g4@PVTLW8OBZ)Ng_^N/g,XL>7)FY?1c@W7NZC)S#<R8BR>.?V)]@
8\E8<[d#KFGMTXETC]Y.;<5\H98#M8)^(?9X,7?<NC9379GG0@6e-OSJ3,D@(.J8
Z0U=8/FYVU;J6VG:QL#IAgMWf#R0\W#05HR1gI]N)<FL4PY37=9b:KAH/D[2BSF^
+JM/@S=(=b3F^]R.-WFa66+.Y:YS&0L\fQdE50MJ#FQd,7@62WIBLCGbcNe\H:P2
,F=P.?_7)S6?ZHMJ9[9If9X6b>Z>#1LfMe7DdV[MCHTLJBVcHe=0OO56OX5YAP<V
<;@8b2.be0NU/P^>9,a?:LMO56VdBI-/#J-U9G>0KXEbg9O8PaYE<2&gF#),:5T<
H-W2P]BD&@Zc>:?@8_3a3_42RaL[B319e7[W#cW]U)08BZF#+d+)R-3]?TQNNU:\
\8:W?<aEPQRQ2#cVBW(Jd.LTRO.LdMb]BPH;M8IE4O19@6<9R6eB-2(&fWa)X&8T
F1>8\8<X[#ZM3Ea+]?39ID8(VDCQ:eW#)M-/AD@e)7(S+MF)7[DYT.S7):YG/Ge&
B40P:+Xe8?QQL.(G[e6^\,X(38KL78a#(;QT)AUeY2M66\1A@bT\\@CB?-Bg[^;:
g<+;LQEJM_RU\9a0U2F)(b[+(BaJfSeId9B.\/\DSfWB/T.C^Rg<.\NP&f68S3df
RLJS,RHHS4<B#TPXRWXN@Qe)==e0a,F_,QSK]=G\64a49C\K^VR7e<]\XSdZ1L(^
D9N(N3#WMARDNTd8KH=Qe8,#NGSZQ[[PXCA3YeVUP:=_b8O)94VH+T@g_A8Q-X7X
S&^(:<0Q+&>&24TU[^5]-LB#K].LNFV1P?Y/88HJ08ZLH4=4_WFLJ&\FO4;F,Jac
g;9O7W:0;283c(9=_a\TU5&C8,=OH(a=[EcM;\4X7)aLK_c_a1NWX4IP5KD(X;[I
[0d-Q_KcT.]Da+^WX&dV;Z,C.PY^^(O#a-&^eMaMf#@^=K=WaO(cQ^FRb9<TRJO3
I?2E++RQU\EKO\eA]ICY6V<(=TD]NBVXe;_gbL03H/aXU?He06</PIaQ#]7QNcD=
Y1AN[8I;>=\M=7de8(8?.WL;TUB2^?Z>e1WEWFW=D0O-IOR-M4#)8cU<HE^V2&#H
<2HRHff3^.?IJM>CeZ01-9)Ya>\(Wd4@Qd_]ZGL?17W)aDg4O(2VAa@d96=Gd<DS
\gL+6K<8?ICLM,OF=_L\+<+N+VWNa,&)Y\YFC/^5I\g5ZcQZLZN;cf?KIP-MS-T&
6K9(#N-,b@K>T-E_<2-BB#GX4[bR>cC@W\DRX7/XfARSFd<8F,I\7ae@20]ZQ95]
3;DaO9e,UPTX.+ETE2e.gg]RVfCBbS=P:.Ta@(0>Q]Ca2dIUU(YS.IeF:P+):U:1
4OF7780;QAW-B-O)Zf+,C-g<34cU6/11DA<.@_@^5DITV7&\;OE#@EU7afPX_FC;
^0H^/eLP)ZOWab3Ja4&S.A#SG]aP-K\(VTb2[R-RT&5cbaLX@gD^C>,WWTNK3@QT
^g=^K,7]5+H]&,VXK.+TM2bb<8(EgF:EWS4]RRIXgMM7<LF_C6Qd,3aa2;.4dJce
]E/^e\6,R1f&[8;COb)E9P?7QYCQGd7aFIY4+9APLG#2Gf_\TOW\7#_@g,ZA9^T1
9Xfb+#3Q[X+W;3R-U=d-M6D;:561]3,7#6&YYJ<-MQSN_#E-S8@;8:\eX6#V/[>#
44,I-VdJSZT-Q[fF1/(@^4-NTc[MS5(_YgJfa(+)ON@^(I_?)1/bY=T_X.N>[3Ub
ReTQFcc@H>)+IBfB6YgMM5=S1HUD.e<6K^[?RO#U)8S92^a,Kd<[TL3\UE/<8e3#
gJ;YaWa#gcH#2,,@(DH-e[@]L8NR74ac6&7b=QW5WFT9b=[IA:e@4RBdKPU8QD/W
MLX\d,N,0]NE[_aD?-X/GWS=)21#<RgK&P4;9cXXXU_EWOHa7.<9FUd^,@ac&AJK
E#XDAc<^a8e>Mf_H@>]5Q6[):O/_MXO?85[dC.0LIg]cbE3QAgFcCZ-.UQ;M^F/1
A7VPRcPX/_gN<?-;\?N0U^^5=0X;RF-e_2Z77P)dO=H@dWS3V64\HAL_(A@Z0V11
K-77aE>X<9Z)e:aN=+6dA]2WV=KD6OAcU00e7XIY2#,W;U&d=WT?D&(KLP(1UL>K
6W]:>46H@7-P6?W<T(?_eEPRJ;<VDCN59_LP7WT0e^BXJcGB5)bb+KC.V\IZ4NaX
46eE)Q7,QN)_N:?RNQ9EeT>(70bNASa[aMfQQ8D#KBW/dN^c+EEeb=U2=5##UK6;
P<[]A9<Sf&2@&24:G+b&RDZ+Uf509#,K(1S?;IS<dP/FWEeA3W<OM.9)OT;G-8&Q
+e(\>J?/2fTAWG)K#,#T:I&fef.M=BBT;/?\eTeY(=aNAJ4-LXLM;S5Z^,fgR41M
C(D1QB;WBI.R@Ra@.c,PHC70YN.L=](LWB=b&6FfQPaPO7L.W,d[fagI0AcMfa/,
=;YN3(_V(5-#5Wc=E8?fY:3CAB\ES>YKL(BMLTTMg_VDP;Ff_^1&B:H,RB/FF\6g
-Yf6IM=:(SA#.$
`endprotected


endclass: svt_event_pool

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
-.O\QJGOKAa.;Lc,P6S5d7:-#4XO?;7/-)8_CMC7N8Td8?Q5NGV.+(D(I^QTF+_f
e&N@+XZ98]DD<N_F=eQ/0,1E4=>R=0TL?,GMa-RDEN/ZQA[2D?@=4T;SNL<37cXB
A+Da)5M@A_4XR:2GD3#(G8_@A)2:LZ.W3aCEROb;_DZ#6)5+^g.H_f,G<J)#RHAJ
8T714A&CT+@=VIEN6,Q_^BH)6g\FM50+H2Bg&5>a9B,8c;P.9</gR,7^&C49SL9)
ZPg;7T(b()IQ@cWQE_C:HE>UbPHJF\(YH<T[\#S\4FZUP&FJ(GY13UTP2NgZYO3?
;8c5.Q+9g&C0D5N.U#;+0G:5)?SFKAaP]d&H,^CFafC8g.B[^/P^J+H_O&33E5ST
E,Kf-K;VVM+=XJTg-NI^3B&IUX-/V;_.1;2=KKVWHS>//QGdPBLW4N<GNJfe\_7@
31G85_T16.)@UP^,SR37VKRBF,e#?O,N?)\S?5Ke2[bdDGg2I3Z9e[cEVe40D+4F
Y_OI0^b4+#9gJR#Ze\ZNeKC)LgMK/^AEQ&H[PN^(<EXG6Be(OHD&6-.N9[CSKb/&
H(U0E,Bc(U:EX<fb#Q0a6]F?:^10?@_HS\f1^1<Ja9^P6JAbZ&G^>;#)]=.+EBc5
FgbeaaacM@Ce?Rgd.Td,.+.N&[U?1,E6#L0f.]gc=XIK_(WBfUGRa&ab&aUXW5U0
f<1XJ5bADg<d)BT72PcIK7N707&5]N;DG&.B#O;<#B8E=cP+8N3X\cdBCSeQ2Rg:
/eN6F#RG>U.BWW=#W2-gMJX1S(JZ6#9@3(CKTQH+O&LS:7a>PeFa[8XVc5V76d\c
VAP3F+]gQ,T&7[M;4OC/SHR5:)V3IMTK7J?QZd+YJ9=,73/@6\IZ<HVW[<N.;5_J
V/\H_eV@RB&[^JH.<<QW9FA&B_6b_M7Xec6\bS4A]9/.\g?BJ&H#G(-NEbAf-FAV
8>R]aLfMO0A?M#YQF;PTgU\J6AedT7\ON&ZNTKc.OE,Pc\<bE2b+]MI4HeM)8YLd
],2H^OFA9/KO2.:I.c_D>/5>M27Wc?X:N;[:CLDO7V9a#CPS-U5:^Q?N[;bGXf&-
SW^[AGA?_W@M?]<RIQS>2M([1C_P]:XJXR#D#Z9CJ[eE.++T>J;197BE?gfMOU0#
9_1Z+0XEP1_2\X=OP=V^[FIG+PA6.H6ARTA4ZbfcU\)I(1)/D>HVM2#GV&L33,08
J3^\8?<YJGR;XV+RI&J/ZA^0Gd^ITL4U-2/TTgC59F_KfSPe>KCf,=1C+cB5YEg(
=PY&51Hce_Y7(3/M&EGVE6Ifb[5@GY/2QZTX,Lg.a&OU5(0g9UR7b-2ADag,3(6V
2Q^;YE_V:<Z@+BDGX(3L?O;>B7D(M_aYGCZGJGDVE01#=2Y^03REJWT7Lf34-CC#
.@W]@G(Vdd4NWCM7H?^f&11O&Z[RA(1)X8:I-KG?#B7eEHX;SF\@:U?;VLA#H(^N
\U)YDF5-Q9K9EOP<MKd?16bF<1YN27Q8=N@3LW15Q-K#HKZ<#c-W34Y#_WP5TG.2
#,e5cT.H_N<=AGdPRcT(1IJM(D.HB(/2G&.0bL;cY1;\_;Y?SD?_+LH@[aP8)J:C
O4[L0Q#9[MPFCI?J[,]ALf3(3U,1T<(0bbY)9gbLCY-EGN+L6H:=>8-CY2=WO?Cc
9BQ@.4QDG>25Pf(16R_C>X89Y0(A4]<4&-,>&M<f\Fe.^BWP4;B/6OB/H^U9=^?#
=,AX=gOV<OE]PBL\P,S8#8SOD33KUc&YH4N;^^EB5eH-#PVN?&,Mab/C:)AP)f0Y
>,GD9]2[^[-E5_A_>P\Ma/LB12>2\3f<JS1YY=(3(8>d8FD=/B0ZbOg>/Q&TV=M2
fFE0:TdS1Q7bI<Q6\P2Ac7e>8MfU77^WRF?7OOE>K_3H^@VB(?56-VYI\/DVEg^A
dC>TbH3M[f5ee447AR1L-#b,WJ6P\=F@M;DZC?<WJ\8bHG>N?WI79>>&Ee4d,VH4
83)6f=0NbQJN_#AR>>Sg\4^e#bU2.Y5-Q;P?EaVVQ5<7O<bWO?N3dF=&K.-7<5]3
;[LdWP)F5:-FS+]Z4eU[9&eI13TK->:?aeE+OE0)AU)S7H2QYc-/2E,)/Z[ed9)3
5H>dAaZWeMEV]8L,KU</6N^][&O@3A4Z-3]0V2BL6cYZ)+cT^(_1WGe9V9VgfK7.
Q--A3K5G>I[@,>+[FW)_@ZMd?P2T@^a4c#O_F1eSAR?B?MX1?&)N?e#6U2R^5#P>
aW#XB/Wf1PPUUT4I[1D;O7N4G5PQTD5RNY(9OM8-BQLB(^H7GAHcRR<c,TJ/2<G_
EBX]Ydcb=7YXeEEC33O,/U@(L\/;K-<gEI+;9<<.1#cBOHF,d<?>#)6^cRV1AHXe
J6S@e02OaEKbQ/L0dACb2Va9M<7LT<.DfOeb5a98KNV#?J,MD&&9))4>0><921M)
EHO[F)IF#8>XH,8WF=2dM]N]XJE=Sb(HZ>V[1\+BRTIM&fNOb&@:d\XLOJ?KE6OH
<4BWF:SM&6f5QQYH/EV.NfIMM&57:44M?b9dWVR&&E_8.Mb0HNOg(X?/G(b5#U1-
FA;>L(e^EaMW<W2W(+1R#4B93S.N9.&\5a@KC;CY]+:_7M^]WB7O9LbRVL>7Y[WM
FG1[f,\G][58@O=/?]MSPR&7+WaO637ZcIBg_7;0<F+-=3[aSUBB;#aU,Y=4fO.\
,U3R</D)CXZ#H(TR5ND1\1\d^1;TSMcM(Q-1-E&cAa:ed_,c558HWF_T8/aNaN.a
&CWcZGe;VF>dbg&TdLM@ZZ/_NeQeTUA;f/6]TWdg1@5R9@NYM>#f:9\9BRbHC[J5
&S>5MLI=ML,\?JPeIK4?GJEEHR1L[(_0#@G7,D9c4.GXgd9gF&D69SJ5-A^]Z-Mb
B:.HIPCKZ-dT++GI_Ve@@)7<POE(_PZ/-<9>Q]B30cZc1E;Y#>BNJ0F.<ZKS+Sed
Md?fA1[^FaW:/W,S;aNC]a]N>HGOA-Z@_&LF5LE1dC]P-G9N3=W,g\a<Z^GER/Pg
1IWXWZ+?<Jd-UN6MQ&OdD+<&0RZTC,D,^.f1+f@R:WXKMA,b[f=XMD](Q2WBS)AN
GOI.FHAJ:b4eE.PJggW,G&SDWHAKV(/HSFS?A715=;)SS[4IJNe</IMNH@BMF,Ua
D(BId4)U2]4J7@Q\I\d1?Z_#c(@a^H_Q1PSNfe6L/SU#YN,[&3?<ZOBM7ceIa,^G
&];[>+.+Sg1,\E(M)E7KFA)Z92]<[4L5^AMb?E9b@ec[:ZCO_d9aR-7N_.bXQ/]W
D&IaFH^A#)8I_O)7gg[R3=b(GCHR+].JR],X]JaIN3.H[J4R(7f>I@4\+.>&8J;0
W8E6&DGDWQ??<FEP+@.XV#d]NXY7OXF&d>G]:;FU[I-5NNG[DdGRKMd:_&X1HDN@
;SCg5VS,#DC3AeQ^eJFH(8b04=3b.5cZ^J4g>UQRgJcVeP.d_.+HgLJ,-@Z.-UBE
g;e=8_)AH&NX-M=0<Wg/+;WF;ORCWDBI/-RF(IYS@@77Ug=M>3dEL\A)^<80LF;8
[NYX+<GdAE7BbPS^F2_0#MV0?00=Y(_X-U=6L4fEM(_D#1(>cbD3(1>5S@2=/eWE
b9X/>+;A.5?;(J6<Z^O.J,#^</61QF1]&B2(a#KP<gXbML]H;S;5J]&4+NU?KL@B
/XZDH(;?@@-8;3^K8,I9XFbYDKJ6#\+ILM=:\Q>)>EY9X:N,-?=Z=eECVQOS?81Q
+a&Z?[c4_WLZA>)L)5aU=fIOS^/VfTSNb6PA^AI&<PIM-5C;).\g\(H4^gM6Z6/(
[^A^?X?H;DV#3CBNUUWQFGeS&1BH#4A/LBK3]-@:[/c5d\I8[f_5JMg1f2PN&F^=
(<e.3EKFf)7C:?6MC/\DK@D1WXA9Z+]\ZOV&7bO6[[30+BLe?;Q_)JB)L@LIC:2#
..F-L?3AHM/^:1/L#Q>24e/P72P)#>;[B&eHZ2B[UL_>Z#1KeXNIA1Y1V[\VRB.,
_BZJ)>,5UDNXTK-BY4Z))DD3>G^9/Q^WR[c7f0NAKCf.#9f5^Wf47H9;D,7^Q>AA
(EU@R).,VE0d5\)@WOXgQWO-I2,f.F:I+I\\Y\AcCR9dX&=T)>5=(PXZ&e-P&^ML
S1g,Xe>UR-2H7&F7N,62-\Y]Dfe)PNZHDc&9@]ZUQaK)Fe1D.^N#]QI4&_cFg(&&
H6=I2O&6SM.gKGWdRXO-HB5?9K(2&JbI7]D+:_8cA^;\a.Z=HZ6@MGEGOMg@ROdM
BUOcCU6BS.(VM>C1S&#HKVYG)UIO]1W#bG^<S)P?=2ZJ5M>&[-baIY8<>+eF;2C<
cD/XD#/<DAV\3Q<W<=#BN</;8AG[0E;@1E8QFf6[=6T[1e2SZ6]+;<QXFX.E;NP^
96@ZV5g1fFTfRA[1I-2.[/:>PB_O#FJf^ATECS;?@T&FeS)?V3C.MI8TK-/CK@=P
PdEC&Ib1T8T-_#+TCR;3KgQ=ES-4>3de;\##?3ULNOGVVF3#Lf.88\+=&W1=\f>]
_9&T_-0=G:U.N5AEQ(<NPX9[FQ_<gU[KaDN3SK/&#8XRIGIEU6;4/cEWZ]A5\^1g
g\>H?V_9a8#0A5=g1+a-WJ8T/aQS6M_3#C8e]#gS@K:3ObCC0I2cd&)(^XID7/0?
:d?WVZ,:OBA0<DbFUY5/]]DP>V+O+>,ga6(4\f#KKDMLZ&7:7aDaOgaT433;[#VN
>&H->G#]K(6.SATH2X3N7]R(IXDO4V__-?eMAT/TWX[TTR#C5,L;/b](-@<^Q@JD
JXgNO&YB))?3AdXcQ<gBR?T)?Zc?282gJ39.<#V]#6YUFUD^#bB/LDU]49O0fV23
(^]B;VM7P)FFH40-8f?^Z]67,L0VEWEFYaP@Q=6^1IcFBaEc-Vc9CaO.4>KE[O]f
a,Z:DWH^F[Ac79AJRcM38Xg+)<78G\9V\P[IKUU)A1-C?\U]We3PE.,#Gg,f&I-6
IH[+9,AMdJ.)^8AQ0TV=9)V0>RT>a]eS,9KJ&U_Y^Vg39.#:F.CO9]&58-&WQ:Q4
\g;[:[Sc.&T\8QG4?1+&fV,AKE/P#a.#;&^7<PT+95CDQOW3D@XD&C<f/RaW]&6;
>K&bX@B76H(_/@B-\T_IOZ8e-)Y_;X/#Y[NT_D0H-5ZI016g9DV)]b;;aI(H<<;Z
=YNWa>&:=#f/BYH8N4:O-3\)N^+3:f6@_ES]7P)M&=1W>?N;D8MB5)-fdF:C+GH4
K/,cDX]E>K?+4EN)\Z(]PSR#2HT(GF<T<FSEM(F3)B;HQ@T4KWK+U(aK^4\-a[PR
2JQF^OWMBWC&C3N(cSM;&?[bfVT#=J/EDCaG>Q&.8Z^d;1HNHT,DQD2ScP7.,R8X
P]28#/?DAKGLN(Y&cG<0_.7Ve:.^O>KUf\OH:NQ@A&eb@H7;L?#0]-X)5bZOcFCa
/ZAOT=@HUSMSQ5@XT-G7;+WS<5<KJS<_X9&J9SG2eG/G<1H#L018\F9L6R=BCH&+
.g&B69_TYJH<_C@5)8G<HfKOXD\&0\\A591LM[Z5JA;=8bN[+0AGL(/W)1f@0>9B
4?OSCR-\A^4NBK^d:J9[8f&8NOWI_7MECH[<NC1CPW0CObK#X(A60AGEg8BQN6TL
><B9SSOT7[JO8QT+,8;GTXG>/PNH<f-@ML4[5GK@9[,K/4F6d:)2R(ZOgAUO:LTc
M<K)b,6P&c^A](8KId-(FF(A1\I(JbNL1EA[<]>P3P3g3,P/5X^HX88K=/XgQSRQ
A7gV1bFd-^>YQE(U^5f^bW0+:;bG:VV^(6;]fNWZ1M:6XX8I#0QL1(QWK-B\c<?c
T#WOR@Z<?/+<WFGEM5Zbe#Rf[>\C&47_Q+O2U:.\=L;H6P/[f=R[d?01,WdBF8N>
9I[+)@P;.2]fK5NU(,bP@C+cU+I7\0<F2H7QO3;a)]_,?3/1R[6:B)11_BXL:+WM
?A-^Xaf+]:9?O>TJD63E<_U2Y0Z/1.bJ=4f_N40Z4e=FL7:eSUMWbM+)B1GUD=_1
g+<T4AU:./->>T<L;XP5cGEU?8LZe+[;g=C8NXTf6c-,?3A^&<?bH+1P1E#HRJ7c
;(W6EBbLNS3YeGA7)?1Q\#:If<GK6a:TM?KGIf8Ga=EEQ#@6TZd#BCQ7I@1SDdTI
L5DKOC)8:c@e^g5Lb:9Xd\V1/^7M+9F.@3U;0)db/64Z9\FN,4\1E&-/D7F818EE
(,/Q]CVW\bV2^\7C:f=L3NX[O83_BWJ3Z3F8R7>[+QK^.g(0ZXO=/gYbVN,U-.#F
F[6a_;A:,>g#G?56MH/?U.?ZaYA&>RCL61N2YdOB\MI\+H06TO:[EYQaf.FB\,-9
BUT5baM=.51_;5CZbcVJ8Sg1&]Z]-D_SY5fa2,dN39(5gIcPNYX-b2R)-VXVPEaa
UdGIKXLJgX(T]aD93=^HeOU9:RKS7PB+89BHd>g@.3.^8RR353H_5^\N].8]Z0IH
,1Wc/^0[P+d@NS_/W,<fNf93P9>U,\Zg/Ug>WWPA_HLf4IF;+1=Yb1d&c_V,O5Y1
#.<Te+Wb9?_BNA@&Z:52N]NCJ[S;,TL/)Z=LRVLGN&K.6R)?>]HL/]I7&ZDd&Ve]
3b3a(d/C\]TVMA7.&K@2?<ADN7I]\?4C7-cTZ6eE/6JO/NE;?A;-T<Q_:H?9#EW(
&#(?.DC(Qb00>KO)ZA-\.D,4#N8Z>KCcBT8aLB))F@+2_dJ1<,FK@f7C.I?.bT1A
J-\]f9Hb-gd&N4b(FE7EVeA-B86e[7K/638W+JE+)Q[E2T<,D/[(YO_C;AUVO]5>
X/dHW&,T[UA[2^YT(T9bX=JY(Z5=Ba8H.P^YIG2@)Q2T-5L>PJF)MYSZ>Sa1<W-J
_:7T^bC#R1Tg?_P4BDZTcP+U2X1eNPXNMHba9IVU.&KEGJf_=4W3^7,C#GgP\R.2
ILcE)^F>[G^L+egB<&CM7_9<D)OX@CDgPa@Q<PWV?=9<R@JJIQb[PW=?a^<H]<.C
-/L3.5GYZN7EGUe)==::>T3QVX-V@cR;0#W8D?;KJN4cZf_I.TdQbYWHI[0Z3];,
4N,EZe2#<03V1>7@.HXCOCM)TID(&2ecNaK6.)g/6OT^(QN&[4Wd\Ma.<=YaDQ]H
HA;HXBAf4AQ+L9IcG2fHY#6)F-S-Va]F;HdF^VD=D6M)>^#Gf^E5H=3ELbg1LJ:\
d.e>^6f\faNMLLdbd0Yg=Y7_eP.Q/CSK5H7,#+<)NY@FQMZ>E>TXPL5Na7#Zg\3e
bgPMc[@[9J\>):[H>/2cHH-][W)1M;4DFV&>?+5c7G0^E?PK0NY5E5LA5[B^OLQ6
6->@#6cWF7N&1KBa@gOaXbRY#3G_VEY@OMU8XNJ^FF[KM1V#M]8/>7a\MfRBQ:4O
f/,=V/+AN/J71(9Eb#JU80UP?=b]5R?8G?N[PIZ,KGQ5.L?dVQffaZE:@D:>D7^0
dN=;M8;dW0(IO-4=]#3:DNdZ(.X+JOL@gXK59PQ6GN;9U<.RW(+a9KR9)Q[4^bdg
LM-I50/]O88A2NaS?_[EW[5252[XW#[2/eINcZA[G)b<)U=C?_cb<L:UNYEU_7P5
S3Q;U2Q+PL38PN4?.b0ca]XV9S[c[TPK2H.KT+VdE?BgQ/O^Y+HPOe5eMQLH3<?O
VG@XJLI[/9GDfG+XSaEW>/SH(XE2Y2C9F-_(^@fE/d/@GbSKb.ab^,0IVN6E[D:;
FROb+719Lg50+VU8=BZR,[(+WUCb.=Oc,U<)H,O,:>Xc>Rb/6Q8,+8QKdcQb=bD3
?WUJAX+YDMeGL9ZS.W<A&gCZ,S?F>G\6Q#8#\f6&TNeGa[][]+3V0NU,a3^e#T[R
8T,8A<;+ZYQ10;-F6K#A2#/g@UQLWMYL7?;7<d:+S7DO=.;&c(X3(G8c+D6L:7aG
V/5<-+=@/dV#FBYSSa/CV_I@]JO0.P)-8I+gQDVXAW1;1<OO4839gVB/c_>\R:3L
9PLC^>N;W-5DUMgA)cMd5Ig:)RU+/.a/><HD#5G@e?LG:9Q?B/<-+9GV86J)2C2,
62]Nf50?dC;60D81U5J<a+3PZVgLdTW3fbf_JHa5e/:]?<FE1;SEK6GVJ$
`endprotected


`endif // GUARD_SVT_EVENT_POOL_SV
