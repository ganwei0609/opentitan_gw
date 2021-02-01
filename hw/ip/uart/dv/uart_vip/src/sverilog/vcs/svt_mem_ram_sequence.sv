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

`ifndef GUARD_SVT_MEM_RAM_SEQUENCE_SV
`define GUARD_SVT_MEM_RAM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_ram_sequence;

// =============================================================================
/**
 * Base class for all SVT mem ram sequences. 
 * It is extended from svt_mem_sequence which is a reactive sequence.
 */
class svt_mem_ram_sequence extends svt_mem_sequence;
  `svt_xvm_object_utils(svt_mem_ram_sequence)
  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(svt_mem_sequencer)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_mem_ram_sequence", string suite_spec = "");

  // =============================================================================
  /** body()
   *  Response to request from mem driver by performing read/write to memory core.
   */
  extern virtual task body ();

endclass

//svt_vcs_lic_vip_protect
`protected
bQa(0B^cU7,[QEaM0@65;D>##4N0-aeW/;553B\b6?M(OE+[_WH?,(O;fOeI\\B^
8<\b?A#.ZGTeLC_<<1E-OC6#XZcU8V)7JJ)9Rb,Nb^>8XQgbEdQGQ66@T=@+&bVd
B^H.TY=.d/2&EW[S92&HI&X.4?a=>_2=M:>9-1<XcEZAG3^(dNM&/2B1NULgWT5(
D^26I;]5c\eAM6M>Fb-U-^?-#/H9[O]L?.4X?HCZHe)1=(=85_(.Ubb66e2Cf&d/
a(@Z>GC9&@GUWD.YX5Cf(O4=AWJ._/dKQU^A4T1G/A#d[>4@.C=-#(#c4gMXO)5M
ZX-4ad8d6ZWKa>DC7=-;>.<+2O,=KE+U@_<LaO176X5+2;A2S+GU\.<;_N\G:42W
J<)bf^RE<)()<8?^;W@SJVBMILH,/X6geG6.TF#:4I^&)R1&AI:+)>].YN.ZEU7Z
\#X]F_4@;Q:+H)V3X/D(=KbU_(YUU6ScGag;S^UG[_CV=0)8b(>\f:E&?S42=7QS
&YS+4L[Y8\D4XgY^g=D0<@GBOG;6g;9Q?KN[R9J[JK)O6Dg9=U=V&\Ka?f38IF+J
&+@5c^Fc&g[d.TZ.V:P>5b65IO7a4>&,?ZA;73G8KdX(gY>8DI(e-E8f^)c&_U+@
,a2V<7;M+A.&GFL0#+O9=U,:S3OXc\4;@@YKC;-/\Y=aI&&]^K,/=a2\5SO3#3d9
=EQeUYc;eKDD7U5J:Ud5P>6WE?,3[O0&>Df>=X=E#4+X#/ee+QeF>\7:_^R7LW>d
A1C),EO]LV[gY261GW,\//C+EXJAW>RPX_5.MW#?L1A,cSc041Q_e,[XAc50KS,U
KaX\7E#1\]E4W1-]GJ6PE8H<S4M1<XD(R)(^MKfgFG4PRV>DO\Q8Ffc.VO;.L[X&
Qe<C,Y1(16IE4F^S^S&J-CT;]_Oa-#Y[dLOUHD?c3<f?/0+ae)?N>RDZ:B&bLC6d
MDGCE35+SZ4?8>3][KA5^2e:Fe@1,U(=\U@,daEd^2.B32^H47S9C>/&0LPDD#2c
c.3+#Q2=+>TLD)SaDIZYLAa2024+U?8cX<HR>08NUY0BG3@NYII]Q&1<HeZc8a\3
9d^]A:63b;Ld_;O=>BeR9?2MR5f/Nd=K=_gJMD88Pg.7A30g+I:a,f5c[RE-388D
/ZTdFZ6((F15,@R@I^99#AI\>@5M8gGge0A-Of>G4N.RBc8D0OKUc.)CW<JF[<6C
?TO6@FO55O1KUgB@d03We7.If1;W&<;?>1<@Zd9XT(CW8YF]+daH8U1:9HGE;QPA
M3bEG\FdCbZ)_89??a[K8c]R\RfOL^(UW80&CEe#F#a@Je-8AH;)F/57D(FZ0bRK
<,>SbZ5QV]gbRC>AgS\@>dKVB+&_fC13f.866GL7.[<0OITX5S#cSXbd20cBWB@(
:EXJfGQ;X>F?#@C[H.SUNbKV5$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY
//    
`endif // GUARD_SVT_MEM_RAM_SEQUENCE_SV
