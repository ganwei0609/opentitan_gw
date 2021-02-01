//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_VOTER_SV
`define GUARD_SVT_VOTER_SV

`ifdef SVT_VMM_TECHNOLOGY

// Use vmm_voter for the basic voter definition
`define SVT_VOTER_BASE_TYPE vmm_voter

`else // SVT_O/UVM_TECHNOLOGY

// If not using VMM technology then create equivalent voter functionality, relying on uvm_objection
`define SVT_VOTER_BASE_TYPE svt_voter

//svt_vcs_lic_vip_protect
`protected
-A8<gc>aF@M@e_&Y1E^5eY]EQ;,D?4A^_C&.T0:G:HT-1-&LIA7Y((JX1QfM;^WB
Q0@^13QDK?V96.Z@bP]SLAK4?L]9,QX/I.RfF<6+,]S,V<D7&edW9=c<#9,cN#\d
PG8W)X9\7IV^N5N=QPB;,Jf&R72RA#<AL.fFg-AI:C#EHKc+#4KGKbcH@],JGYP#
?g4PKB;JM0+a=<F&E0^:</f&4$
`endprotected


//---------------------------------------------------------------------
// svt_voter
//

class svt_voter;

//svt_vcs_lic_vip_protect
`protected
e-?5e(N/G&2#?QW3406-EO#/aO@ZF=8;/,a8GQVgD+bg1.[B61W-.(#K3C(YOGOR
X#,&,_K)C2HQNUJ7848A=f<7#dAG8GF3Q6NS&&bDDBZLY,LP,H3R(V@:B6>X0H]+
0>JXL1-1)JX/eXDPUb>:^F\K=5S_#MU\Tg=(b1f-a,)GUg=KRS1c.N9[0UWC-\7^
BD&GQ7J7c&fCQOJ-bW)H4)A=GD>=IE.9Xeb&89bU[[_[0A,7FFNLcY9Y+fYYJa56
b6^WUFg<^>9UIJT^cc,CdP;M-H4++:056b7NAeU5YQEY:QZdCZHge<8F=HY-9A#b
c?0C6a_R-LGd.gbdJKcWMU=0b=37J3>Be=/eX>eRJGMHQ#aBV8>3a<bL@1/QWfgC
8;7YD1;@B\2RO:Xd<4NT+Ba15XELC\&g=5>4S@)ELIFM=&5aMFg=2-V+bg_(51[^
G/^)BBc\,]UH8Z^7@Be7H/^LB;SA?gP8PPMaKd]519d0cc)bX8\=:a)D;>#2RDc5
7C^STDY7=W+Gb(9/<<J3+>=e[[f6]RXcGT7f:0d_#(>.^dJb,@BYgM)@H_JM=^eS
T;b:^HWH.Nd]>BVZL];\bf[-K8aZ8cR0?U=[E5.7[1:YV4:F9Y,P&KC^YCd)P_6<
L]DIIMA#7Q_INKQU9J-X_G(:E@5A-VQG)=RE=V,,YR2#56bGB=^&QTKN/;SdPU,>
G-=2X/9/f9U>L.DB5#DK>V#6\OZ<BZC+ZW,c8RJf/R50?11PBS#>T8&B2b\?FZPg
<_[=XZO?a&1EdT-TcEP.M8SX9H\?[I1/ICA6MGJ]f89@Q?ef9IRZ6520Y^^WU+T(
d_SV2fdf4c>EVg8H@1AAY8^+3CR@<gd[;MO[1.@,FV>&g=fX26aT3D90)B^MXBAA
f#aFGR;A#&5TfYO:C@,aBT,c_4;9ZG\1\e-GJ]a/V8\KOF7cRB1H2>b8fL,U,[Z&
P>PPc[ZeM>1)3I;3Hb3W4G[U(U@5HGJ2)Q6L\:-+V-B??S[N,/0<)DGAGc=;Y_Mf
M\d6<41H[C-I??8@V42I?HYH?W/W;;H;T@)@c_>Ldf4f=?/)X,I]5=a_B^V-?e]I
0#OL2bO#7U57F/&0-Y7[48gEd2W;28985X62)O4)^5fBdY<bV1-PMQS\85C\08U,S$
`endprotected


endclass

//svt_vcs_lic_vip_protect
`protected
1fEV1QWcG4G2(c6a/b8#=bXL]/0\Cc?S3FYSM79:##85&G;O6f643(YZe6S+D.L[
=;(QdY-.NPQ?Rf:E?96O_G=9/5,d<L1:\FCEIXDOAW]6fM+V^RMg@EFVa6>OaDMT
(Y1Gf/KZ9ISM;(#e/#1[\3Zd&AAJ_=-6<\7NKK-JdF=:BCQ;PL#3g&_0AVZ-cc=T
1]GZ9Pa]XJ31B)=YXbQ(0H\d,?d3FT:DId0ega&YYKR&3K:,eC1>A#S;)YVc)D/H
FG,KW=3A^)NUL5.;9cYR_gV_bbUe@2N:YWFCfSRcYZQ\M>SIXKA58agHAMSBR[8T
SHad<J2bM>B0dW/BO[\37/L,6UbIN6EXgAGGL0X@-_=A7_@9(=Z<d9)E.>)MB@DX
)[P.@/#H3.<KReJK#8+EbJ,1/A&)YdUf=SB9=2a4FJ9^?DcH#Jc=K1Y\]OHCQY^Z
(QDWeH0OR&1=GfV-:-IFD?#(VaLNT)d1E&^]@]ET#e.WCGWL1X1=I8?;&;Z<[]Ie
XdD#6HgGL:QWGgBF>Y\5GVHbA#?f;LSaMNU0XCb23Q=I()\(U]MSaZE]X]<6549-
]8-0<b0e1Zd8S[9\=AQeZdV?]LC4951_eMg&L.K)O[<HXL>S33Q58Z8;@+dXI_CX
]33\gP)WIMbFK:MPG72C>XP,43IA6TXSaY^NZZ_.0C-R9W04gYYadKM\LF?O+1M1
(?g@4>RMPa^_g?1T;D+;9(<\V/5_<6HJ=.PZK08eZ;CM#Y&b(+QO6BVeV/b)0#1&
Jb2e98LUA@Ve9RU09_)2H^<U#A2(@9KE=::-^S3+T/Z)28LH,I5<GOTG?a2F]W/[
=-bdH^B#CS[XF8&.L]Y</&@(^9Mg3[]?G&4#()(eNSO]>^7^]1=;R5/;V>8^PK:1
SJJVA9Q\aWCR((F?.dd&-eRPOGR.27,,J<F[06+4CN7Vg<PJR1A6DcH-UL)-3I7G
Uc2EKcGP/\KKPY=)#T7Z&AA5J[?PEUPKEUNTR7aaG2.X)H3c?OH=NGR&dcaTY.fB
=LMQRW&B)7FNOM0++I0I7+36GJMJ:=&)YZ0\9Ob##&>-fYAG5R^DH<>IZeGdO9ZW
ID0.&)T9^9]CDVV@6ZP:Ad?@2&<4E4Z<a?S;&E?gUNY@BZgP6)2Ed=DRc+.UZL8a
SNOIOHH=5.e:baR_I5SbG.e<M;?g:RK[H+(B.HD=U<G=ggYB5VKV0aIH^95)Y3AS
5DHD6AA1@LI#5I]X3L,Z12E+X2[4V#1&3@/6P733#g.CdRc->90aIcODbX06X#]X
TeMfVJ_>55KOB);;Pbg+dLHOI4GPOW30P>3g[a72SIXXg:W\YfIX^<]Z79I&Y0)e
e\J,#4^3RDJ4R:d>ZgY;Sa4E_g@SW2DI95L,C[VVNJaL0+C9M:N.NPYaYT7f1/G9
TH-;Q59J+[3J_HH3N-LLJYN/(CII@X^G:[R^9a_<1<+4Nda=a4H5Vg1+Z&Y9&I,>
(:R#3JWJ_VgABT4\V[8+Ag(>CQ+)\Qf,9<b@>f>S_g_-[T=<MCV:AN;>BcSN;[cR
\@7-ZeN6#fCB,6K8)PR7Y^>[FBU3We7gH&Jd41GWV9/+?3TR-F-eT#S^=25fW3OH
KJRM>SUCKH=2U:/,6E?DMg5ZXFIPAaAB>]=C;,Q/g8X5&0^HQ7OF)&HGA)+20AT0
FS>c-+5]TH<KA^HEUaI:N(_d8RCbBL[=JUVX;TY+-4Z3RU^8YBVf\aOU4V2ZN8(V
JP:[);e^:N#A(02)(F=8IU#B@7+FfFBN-1SYO56OIWV[OfZX+1CS:/AJa&ON7_ZR
AP.e1UX-N231X,+/@ZYJ3HceL92+ab;(6\GV/QI=_];X^(RAZ4H6ZPKO2W:.AE3G
S59TOFc>2[bL8:V-)dLOWZbfK+MdNYJ>ELNL\b@fKLG;W:dZ^1afQ]>&?05-?<,d
;YCJgJ=.7W6(I>WdPbKba4LVFP:\,e4;/=HE\=Q9,d/G#[5E:WJ2I-gOC;;d[S:>
X?5]C=Pa7[/F7+0d^NI<LgVB(M?X?0\f-PT.@&fHbDD.\G]&:BFS&C4LcZ@H>;ZQ
O7,E1/S84B(\D:J]A,CXAYPWK=>#e#ZfWUI-T-+-_8H@:d)Ye66G4/I[fNG]@.,4
>/(bV1YcaO+3FR:S5<[HKbX[^4\6PYOG>bNTWbS]6aZP&ELA+a&#dCSScOFA1K#:
/L/6FUZX>(@_3VSc+(@QK&+H[W[-@\,6^\TIYd<U\J=,2>UU[>2>A6S9U]:+gB:+
FS(OPPQMGN[QVIdSW8RUYP4c/UX5Y+>0N)_+)P3<Ufda>HC-K;DB0&A#L:\./K#+
_,B&1G8MN[(]DgB^V3_@Q^VQKBaf6=K.CI^?MNUU:AAS_+CL(B+(3_.:1^BK&a).
5L1dL,SUb<I3>GaX4HOJ?7:SMV]&1L0A+.@gffP/EZI1=c7FGG9_R9BY;[4eg,QM
(2f^>fXFHHT6Z_..c^O;]<.Q^;J+-4;fPMWb\<dQ\ga9T9WG)KQa5G&QT8908H(D
Ae,6C<<_D1@dPgSBSgNXMJKfF^;-/SW-fS]Y2VMBP:.Q<0fbR\P8a/6D#fe^cB.,
ED70S4>a88UE-1]SDXabK:SYT775U\fSZ1b=fB_97,>d0(B0b/;E:aSXKLMY>Q=L
D0\D.eC77GW./I#Z_^0GY2&OVa6P/b[0<Y.GG#S-93].f;-TCFe4Q,NN;dg+_.<A
<Q<CYX1Ff]A8NGgc2,0+&]?^dd#V(3=AI+ZN4^8J8\<J:W>K&\2fd4M+R@cc+5O;
=.M)J#7I.V(0bK(+BZ5B>/H>U/U6)X_B;O(UK+:aG7J7XA#<BM(bER-(dMHR6D,L
]G1/H3G?\FN;X5)Z2MaA0Qe=:QWU6-XQ>B[a&6.P9SLJ.P/3&:\aO#CfD#\Rb<b[
#IgRO45_P/UYaf6da?g)?:fK:4Y9^.0&+e/e,-B]\9TFF55eMRSY<DfZX-URB])b
7TE(,fQ5W1VBYfUb6O>GJVgVa+LMfTf7QADIEKOcX<HVX)MY&]Q#2VW]Z_&Y@U]-
B&)8_2AN?>GB0$
`endprotected


`endif // SVT_O/UVM_TECHNOLOGY

`endif // GUARD_SVT_VOTER_SV
