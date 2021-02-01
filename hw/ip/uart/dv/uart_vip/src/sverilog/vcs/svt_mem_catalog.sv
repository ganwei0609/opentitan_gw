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

`ifndef GUARD_SVT_MEM_CATALOG_SV
`define GUARD_SVT_MEM_CATALOG_SV

/**
 * Default values for specifying memory part depths
 */
typedef enum {
              SVT_MEM_2Kb    = `SVT_MEM_DEPTH_2KB,
              SVT_MEM_4Kb    = `SVT_MEM_DEPTH_4KB,
              SVT_MEM_8Kb    = `SVT_MEM_DEPTH_8KB,
              SVT_MEM_16Kb   = `SVT_MEM_DEPTH_16KB,
              SVT_MEM_32Kb   = `SVT_MEM_DEPTH_32KB,
              SVT_MEM_64Kb   = `SVT_MEM_DEPTH_64KB,
              SVT_MEM_128Kb  = `SVT_MEM_DEPTH_128KB,
              SVT_MEM_256Kb  = `SVT_MEM_DEPTH_256KB,
              SVT_MEM_512Kb  = `SVT_MEM_DEPTH_512KB,
              SVT_MEM_1Mb    = `SVT_MEM_DEPTH_1MB,
              SVT_MEM_2Mb    = `SVT_MEM_DEPTH_2MB,
              SVT_MEM_4Mb    = `SVT_MEM_DEPTH_4MB,
              SVT_MEM_8Mb    = `SVT_MEM_DEPTH_8MB,
              SVT_MEM_16Mb   = `SVT_MEM_DEPTH_16MB,
              SVT_MEM_24Mb   = `SVT_MEM_DEPTH_24MB,
              SVT_MEM_32Mb   = `SVT_MEM_DEPTH_32MB,
              SVT_MEM_48Mb   = `SVT_MEM_DEPTH_48MB,
              SVT_MEM_64Mb   = `SVT_MEM_DEPTH_64MB,
              SVT_MEM_128Mb  = `SVT_MEM_DEPTH_128MB,
              SVT_MEM_192Mb  = `SVT_MEM_DEPTH_192MB,
              SVT_MEM_256Mb  = `SVT_MEM_DEPTH_256MB,
              SVT_MEM_384Mb  = `SVT_MEM_DEPTH_384MB,
              SVT_MEM_512Mb  = `SVT_MEM_DEPTH_512MB,
              SVT_MEM_768Mb  = `SVT_MEM_DEPTH_768MB,
              SVT_MEM_1536Mb = `SVT_MEM_DEPTH_1536MB,
              SVT_MEM_1Gb    = `SVT_MEM_DEPTH_1GB,
              SVT_MEM_2Gb    = `SVT_MEM_DEPTH_2GB,
              SVT_MEM_3Gb    = `SVT_MEM_DEPTH_3GB,
              SVT_MEM_4Gb    = `SVT_MEM_DEPTH_4GB,
              SVT_MEM_6Gb    = `SVT_MEM_DEPTH_6GB,
              SVT_MEM_8Gb    = `SVT_MEM_DEPTH_8GB,
              SVT_MEM_9Gb    = `SVT_MEM_DEPTH_9GB,
              SVT_MEM_12Gb   = `SVT_MEM_DEPTH_12GB,
              SVT_MEM_16Gb   = `SVT_MEM_DEPTH_16GB,
              SVT_MEM_24Gb   = `SVT_MEM_DEPTH_24GB,
              SVT_MEM_32Gb   = `SVT_MEM_DEPTH_32GB,
              SVT_MEM_48Gb   = `SVT_MEM_DEPTH_48GB,
              SVT_MEM_64Gb   = `SVT_MEM_DEPTH_64GB,
              SVT_MEM_96Gb   = `SVT_MEM_DEPTH_96GB,
              SVT_MEM_128Gb  = `SVT_MEM_DEPTH_128GB,
              SVT_MEM_192Gb  = `SVT_MEM_DEPTH_192GB,
              SVT_MEM_256Gb  = `SVT_MEM_DEPTH_256GB } svt_mem_depth_t;

/**
 * Default values for specifying memory part widths
 */
typedef enum {SVT_MEM_x1   = 1,
              SVT_MEM_x2   = 2,
              SVT_MEM_x4   = 4,
              SVT_MEM_x8   = 8,
              SVT_MEM_x16  = 16,
              SVT_MEM_x32  = 32,
              SVT_MEM_x64  = 64,
              SVT_MEM_x128 = 128,
              SVT_MEM_x256 = 256,
              SVT_MEM_x512 = 512,
              SVT_MEM_x1k  = 1024} svt_mem_width_t;

/**
 * Default values for specying a part clock rate
 */
typedef enum {
              SVT_MEM_20MHz   = 20,
              SVT_MEM_25MHz   = 25,
              SVT_MEM_30MHz   = 30,
              SVT_MEM_33MHz   = 33,
              SVT_MEM_40MHz   = 40,
              SVT_MEM_50MHz   = 50,
              SVT_MEM_66MHz   = 66,
              SVT_MEM_67MHz   = 67,
              SVT_MEM_75MHz   = 75,
              SVT_MEM_80MHz   = 80,
              SVT_MEM_84MHz   = 84,
              SVT_MEM_85MHz   = 85,
              SVT_MEM_86MHz   = 86,
              SVT_MEM_100MHz  = 100,
              SVT_MEM_104MHz  = 104,
              SVT_MEM_108MHz  = 108,
              SVT_MEM_133MHz  = 133,
              SVT_MEM_150MHz  = 150,
              SVT_MEM_166MHz  = 166,
              SVT_MEM_200MHz  = 200,
              SVT_MEM_266MHz  = 266,
              SVT_MEM_267MHz  = 267,
              SVT_MEM_300MHz  = 300,
              SVT_MEM_350MHz  = 350,
              SVT_MEM_333MHz  = 333,
              SVT_MEM_344MHz  = 344,
              SVT_MEM_400MHz  = 400,
              SVT_MEM_466MHz  = 466,
              SVT_MEM_467MHz  = 467,
              SVT_MEM_500MHz  = 500,
              SVT_MEM_533MHz  = 533,
              SVT_MEM_600MHz  = 600,
              SVT_MEM_667MHz  = 667,
              SVT_MEM_688MHz  = 688,
              SVT_MEM_700MHz  = 700,
              SVT_MEM_733MHz  = 733,
              SVT_MEM_750MHz  = 750,
              SVT_MEM_800MHz  = 800,
              SVT_MEM_900MHz  = 900,
              SVT_MEM_933MHz  = 933,
              SVT_MEM_1000MHz = 1000,
              SVT_MEM_1066MHz = 1066,
              SVT_MEM_1100MHz = 1100,
              SVT_MEM_1200MHz = 1200,
              SVT_MEM_1250MHz = 1250,
              SVT_MEM_1333MHz = 1333,
              SVT_MEM_1375MHz = 1375,
              SVT_MEM_1466MHz = 1466,
              SVT_MEM_1500MHz = 1500,
              SVT_MEM_1600MHz = 1600,
              SVT_MEM_1750MHz = 1750,
              SVT_MEM_1800MHz = 1800,
              SVT_MEM_1866MHz = 1866,
              SVT_MEM_2000MHz = 2000,
              SVT_MEM_2133MHz = 2133,
              SVT_MEM_2200MHz = 2200,
              SVT_MEM_2400MHz = 2400,
              SVT_MEM_2500MHz = 2500,
              SVT_MEM_2600MHz = 2600,
              SVT_MEM_2667MHz = 2667,
              SVT_MEM_2800MHz = 2800,
              SVT_MEM_2900MHz = 2900,
              SVT_MEM_3000MHz = 3000,
              SVT_MEM_3200MHz = 3200 } svt_mem_clkrate_t;

typedef class svt_mem_vendor_catalog_base;

           
/**
 * Base class for the default part catalog entry.
 */
virtual class svt_mem_vendor_part_base;

  local string            m_number;
  local string            m_descr;
  local svt_mem_depth_t   m_depth;
  local svt_mem_width_t   m_width;
  local svt_mem_clkrate_t m_clkrate;
  local string            m_cfgfile;

  local svt_mem_vendor_catalog_base m_catalog;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log is provided to class constructor. */
  protected static vmm_log log = new("svt_mem_vendor_part_base", "class");
`else
  /** Shared reporter used if no reporter is provided to class constructor. */
  protected static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_vendor_part_base:class");
`endif

  function new(svt_mem_vendor_catalog_base catalog,
               string                      number,
               string                      descr,
               svt_mem_depth_t             depth,
               svt_mem_width_t             width,
               svt_mem_clkrate_t           clkrate,
               string                      cfgfile);
    m_number  = number;
    m_descr   = descr;
    m_depth   = depth;
    m_width   = width;
    m_clkrate = clkrate;
    m_cfgfile = cfgfile;
  endfunction

  
  pure virtual function string get_dwhome();

  virtual function void write();
    $write("%s %s (%s) : %sx%0d, %0dMHz (%s)", get_vendor_name(), m_number,
           m_descr, get_depth_desc(), m_width, m_clkrate, m_cfgfile);
  endfunction

  /** Set the vendor catalog this part is in */
  function void set_catalog(svt_mem_vendor_catalog_base catalog);
    if (m_catalog != null) m_catalog.remove_part(this);
    m_catalog = catalog;
    if (catalog != null) void'(catalog.add_part(this));
  endfunction

  /** Return the vendor catalog this part is in */
  function svt_mem_vendor_catalog_base get_catalog();
    return m_catalog;
  endfunction

  /** Return the name of the vendor for the part */
  virtual function string get_vendor_name();
    if (m_catalog == null) return "<Unknown>";
    return m_catalog.get_vendor_name();
  endfunction


  /** Return the name/number for the part */
  function string get_part_number();
    return m_number;
  endfunction

  /** Return the description of the part */
  function string get_descr();
    return m_descr;
  endfunction

  /** Return the depth of the part */
  function svt_mem_depth_t get_depth();
    return m_depth;
  endfunction

  /** Return the depth in string format */
  function string get_depth_desc();
    string depth;
    depth = m_depth.name;
    get_depth_desc = depth.substr(8, depth.len()-1);
  endfunction

  /** Return the width of the part */
  function svt_mem_width_t get_width();
    return m_width;
  endfunction

  /** Return the clock rate of the part */
  function svt_mem_clkrate_t get_clkrate();
    return m_clkrate;
  endfunction

  /** Return the cfgfile value provided for this part at construction */
  function string get_cfgfile_path();
    return m_cfgfile;
  endfunction

  /** Return '1' if substring found in cfgfile_path, else 0 */
  function bit match_cfgfile_path(string regex);
     
`ifdef SVT_UVM_TECHNOLOGY
    match_cfgfile_path = !uvm_re_match(regex, m_cfgfile);
`elsif SVT_OVM_TECHNOLOGY
    match_cfgfile_path = ovm_is_match(regex, m_cfgfile);
`else
    match_cfgfile_path = `vmm_str_match(m_cfgfile, regex);
`endif

  endfunction

  /** Find the CFG file for this part
   *  First look into VIP installation directory
   *  then in the colon-separated search path list specified
   *  using the +SVT_MEM_USER_CFG_PATH= command-line argument.
   */
  function string get_cfgfile();
    string paths;
    string cfgfile_full_name = "";

    `svt_debug("get_cfgfile", $sformatf("Entered, m_cfgfile = '%0s'.", m_cfgfile));

    if (m_catalog == null) return "";
    
    // Look in the VIP installation first
    paths = {get_dwhome(), "/catalog"};
    begin
      string arg;
      if ($value$plusargs("SVT_MEM_USER_CFG_PATH=%s", arg)) begin
        // The user catalog should take precedence
        paths = {arg, ":", paths};
      end
    end

    `svt_debug("get_cfgfile", $sformatf("Searching for cfgfile using m_cfgfile = '%0s', paths = '%0s'.", m_cfgfile, paths));
    cfgfile_full_name = svt_mem_find_file(m_cfgfile, paths);

    if (cfgfile_full_name.len() == 0) begin
      `svt_fatal("get_cfgfile", $sformatf("Failed attempting to find 'cfgfile_full_name' in catalog based on m_cfgfile = '%0s', paths = '%s'.", m_cfgfile, paths));
    end

    return cfgfile_full_name;
  endfunction
endclass


/**
 * Default part catalog entry.
 * If additional or different part selection criteria are required
 * for a specific suite, they should be added in a derived class.
 * It must be specialized with a policy class the contains
 * a static "\#get()" method returning the
 * full path to the installation directory of the suite.
 */
class svt_mem_vendor_part#(type DWHOME=int) extends svt_mem_vendor_part_base;

  typedef svt_mem_vendor_part#(DWHOME) this_type;
  
  function new(svt_mem_vendor_catalog_base catalog,
               string                      number,
               string                      descr,
               svt_mem_depth_t             depth,
               svt_mem_width_t             width,
               svt_mem_clkrate_t           clkrate,
               string                      cfgfile);
    super.new(catalog, number, descr, depth, width, clkrate, cfgfile);
    set_catalog(catalog);
  endfunction

  virtual function string get_dwhome();
    return DWHOME::get();
  endfunction

  /**
   * Parse a line to see if it is a metadata line
   *  and, if so, return the contained tag and value.
   */
  static local function bit is_metadata_line(input  string line,
                                             output string tag,
                                             output string value);
    int i, j, k;

    // Skip leading blanks
    i = 0;
    while (i < line.len() && (line[i] == " " || line[i] == "\t")) i++;
    if (i >= line.len()) return 0;
    
    // Must be a "//" or "#" comment line
    if (line[i] == "/" && line[i+1] == "/") i = i + 2;
    else if (line[i] == "#" ) i = i + 1;
    else return 0;

    // Skip blanks again
    while (i < line.len() && (line[i] == " " || line[i] == "\t")) i++;
    if (i >= line.len()) return 0;

    // Tag ends with a ':'
    j = i+1;
    while (j < line.len() && line[j] != ":") j++;
    if (j >= line.len()) return 0;
    k = j+1;

    // Strip trailing blanks from tag
    j--;
    while (j >= i && (line[j] == " " || line[j] == "\t")) j--;
    if (j < i) return 0;

    tag = line.substr(i, j);
    
    // Skip blanks again
    while (k < line.len() && (line[k] == " " || line[k] == "\t")) k++;
    if (k >= line.len()) return 0;

    // Strip trailing blanks from value
    j = line.len() - 1;
    while (j >= k && (line[j] == " " || line[j] == "\t" || line[j] == "\n")) j--;
    if (j < k) return 0;

    value = line.substr(k, j);

    return 1;
  endfunction

  /** Parse the specified file and add the part it describes in the
   *  specified catalog.
   *  Returns TRUE if the operation was succesful.
   *  Returns FALSE if the format was invalid or incomplete.
   */
  static function this_type create_from_file(string                      fname,
                                             string                      partnum,
                                             svt_mem_vendor_catalog_base catalog);
    this_type part;
    int fp;
    string line, tag, value, descr;
    svt_mem_depth_t depth;
    svt_mem_width_t width;
    svt_mem_clkrate_t speed;
    bit has_descr, has_density, has_speed;

    fp = $fopen(fname, "r");
    if (fp == 0) begin
      void'($ferror(fp, line));
      `svt_error("create_from_file", $sformatf("Cannot open \"%s\" for reading: %s\n", fname, line));
      return null;
    end

    while ($fgets(line, fp)) begin
      if (!is_metadata_line(line, tag, value)) continue;

      case (tag)
       "Description":
         begin
           if (has_descr) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Description\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_descr = 1;

           descr = value;
         end

       "Speed":
         begin
           // Speed is encoded as nnnMHz
           int i;
           
           if (has_speed) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Speed\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_speed = 1;

           i = value.len()-1;
           if (i < 3 || value.substr(i-2, i) != "MHz") begin
             `svt_error("create_from_file", $sformatf("Invalid speed metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           value = value.substr(0, i-3);
           if (!$cast(speed, value.atoi())) begin
             `svt_error("create_from_file", $sformatf("Invalid speed metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
         end

       "Density": // Density is encoded as nnnMbxWWW or nnnGbxWWW
         begin
           int i, x = 0;
           string w;
           
           if (has_density) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Density\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_density = 1;

           while (x < value.len() && value[x] != "x") x++;
           if (value[x] != "x") begin
             `svt_error("create_from_file", $sformatf("Invalid density metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end

           w = value.substr(x+1, value.len()-1);
           i = w.atoi();
           if (w.substr(w.len()-1, w.len()-1) == "k") i = i*1024;
           if (!$cast(width, i)) begin
             `svt_error("create_from_file", $sformatf("Invalid width (%0d) in density metadata value \"%s\" in \"%s\".",
                                                      i, value, fname));
             return null;
           end

           w = value.substr(0, x-1);
           w = {"SVT_MEM_", w};
           depth = set_depth_via_string(w);
         end
      endcase
    end

    if (!has_density) begin
      `svt_error("create_from_file", $sformatf("No \"Density\" metadata value in \"%s\".", fname));
      return null;
    end
    if (!has_speed) begin
      `svt_error("create_from_file", $sformatf("No \"Speed\" metadata value in \"%s\".", fname));
      return null;
    end
    if (!has_descr) begin
      `svt_error("create_from_file", $sformatf("No \"Description\" metadata value in \"%s\".", fname));
      return null;
    end
    
    part = new(catalog, partnum, descr, depth, width, speed, fname);

    $fclose(fp);
    
    return part;
  endfunction
  
  static function svt_mem_depth_t set_depth_via_string( string depth_str );
//svt_vcs_lic_vip_protect
`protected
f7D.P<Ce]]HGN=[Fde<.OZX\QZd52;1T:([<2.Q&UA6.eg7_LHC=.(SC_5PVa:BG
M/F<;D=BN/Q?DN?\HR^N2(A29=;0X1?QNRM+2#=g&?T-#(AWYU0;:F)+ADg?M.J-
O5daR0@.(U67A.3WgHg5&=J?DeK33b#X3bF_:T8D+de<X@e^T-:A1g29=G]aca63
3:?28OOFJO3[+@1X;:YYZ-_P#[8?)0&:#2H=MS<T4F7,H1Y^8R7I#D_I8T6BU7=5
&&;::V1O]Gf^JbeH3E6f_R;Y;gaTA:KTcf)-gT&aX]IRF@:?XM\PDV<4&Kc[+5Oc
@:(Z3Q]L,YLAJ4=H/34GcMgL.J,SfKUJb2XO4Y-\95MgScbMb(U&_-I:f0d-gGPb
>5._d4IfE:I)IY[C/QB>QSc,,VH?:CL(>$
`endprotected

  endfunction

endclass

/**
 * Part-independent base class for the vendor part catalog.
 */
virtual class svt_mem_vendor_catalog_base;

/** @cond PRIVATE */
  local string m_name;
/** @endcond */

  function new(string name);
    m_name = name;
  endfunction

  /** Return the name of the vendor for this catalog */
  virtual function string get_vendor_name();
    return m_name;
  endfunction

/** @cond PRIVATE */

  /** Add a vendor part to this catalog.
   *  If a part with the same number already exists in the catalog,
   *  it is repaced with the new one.
   *  Returns TRUE if the part is compatible with the catalog.
   */
  virtual function bit add_part(svt_mem_vendor_part_base part);
    return 0;
  endfunction

  /** Remove the specified part from the catalog */
  virtual function void remove_part(svt_mem_vendor_part_base part);
  endfunction

  /** Get the base class for the ith vendor catalog in the suite-specific shelf
   *  and increment i. The first catalog is at index 0.
   *  returns NULL if there is not such catalog.
   */
  virtual function svt_mem_vendor_catalog_base get_ith_base_vendor(inout int unsigned i);
    return null;
  endfunction

  /** Return the base class for the ith part in this catalog and increment i.
   *  The first part is at index 0.
   *  Returns NULL if there is no such part.
   * */
  virtual function svt_mem_vendor_part_base get_ith_base_part(inout int unsigned i);
    return null;
  endfunction

/** @endcond */

endclass

/**
 * Base class for the vendor part catalog.
 * Must first be specialized with the suite-specific vendor part catalog entry type
 * (itself extended/specialized from svt_mem_vendor_part class).
 */
class svt_mem_vendor_catalog#(type PART=int) extends svt_mem_vendor_catalog_base;

/** @cond PRIVATE */

  typedef svt_mem_vendor_catalog#(PART) this_type;
  
  local static this_type m_vendors[string];
  local static string    m_names[$];
  local        PART      m_parts[string];
  local        string    m_numbers[$];

`ifndef SVT_VMM_TECHNOLOGY
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_vendor_catalog:class");
`else
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log log = new("svt_mem_vendor_catalog", "class");
`endif

/** @endcond */

  function new(string name);
    super.new(name);
  endfunction

  /** Write all vendor catalogs for the corresponding suite */
  static function void write_shelf();
    foreach (m_vendors[i]) begin
      m_vendors[i].write();
    end
  endfunction

  /** Write the content of the vendor catalog */
  function void write();
    $write("%s Catalog:\n", get_vendor_name());
    foreach (m_parts[i]) begin
      $write("   ");
      m_parts[i].write();
      $write("\n");
    end
  endfunction

  /** Get a catalog from the shelf for the corresponding suite for the named vendor.
   *  If it does not exists, it is created.
   */
  static function this_type get_vendor(string name);
    if (!m_vendors.exists(name)) begin
      m_vendors[name] = new(name);
      m_names.push_back(name);
    end
    return m_vendors[name];
  endfunction

/** @cond PRIVATE */
//svt_vcs_lic_vip_protect
`protected
5b^fCW76]Ca?B;L(@<dY&NKOEPZfK8IQOSV9OB)R?a]#MaVI<6Z:1(R>67f9:(L[
J[C=:ec9bI.>)cBQ<.YZK-<@V(L09G\KXIQNPBY?GbU6D>8X2^)=@d/Pb(NeCZ&I
=5IEUS&G;L415M&XY1fR^.^8=B-5KgY.=/.6:>FHIFB1W1TL^0\I,ME@?Vc]NEZ-
bQ0.F+G:=Q53:B9S)RR.WRMKW,=ED[\MgFUbGeE@49]b,4d,^KVLB912FF4K,6J5
.<0?Y:=HX]g@>HfDf9R36Gdd[W&T#DVXO/NHg5f4?fTR>KK<a;U&H,bG9O5A(D-R
180?/[Ycd>4ID_fEPL)XG>DS7fa/[CXA&c_#gMC+V=_+_/\TRf2;1BAg>dd96FZV
M[Ug;@))S>B(d)W6@D56B.1?e&P:QH]T_20V\831?J4,:f:_ED-&QR+/C=gP7+4(
[<U-N7+e#f[Q9//dJQ6Ed<gY^[b\Z&bc>.U3<Z3c(TO#/1[>\A]D/O7/Q-@>N?&<
=YcQ9cM/A8_RbD:F]0_c0UDL:\^0.Q\UPgHK6V\<@cM@[NgO:IX\H?PEE.C7NRJ_
VSXD-T03WX:&G[<bUJ?W<MNLIG&_<@57UIZM:.75<&7M2E;Y>\4(P0RE5SY<;-[0
2#-+bPT9A9]4TWV87NY923<6WL?3S,Q)?_1WV1O0W7_/5eFA@+2eXLJbI7)T[C86
9MM#BYC2BO;f:/:_)=b&@F=-^CB8ReJ:F9^ELd4IHZ)<6&ST4+BUMBAS8.dcg\OM
b/=-XE0Y-YUO0S5CZc_M5PQXQHSD[fg)ENCHY3-??BdZX.]J@L5)/NC2X7;HKEKb
7<3Q(NX(dSGSA^-Zb0M;0:FeB(.gV9=a0U.1PE[3UCOeH4,3\DLAA?<(Z?0;?_JM
8?/L9?^OS)@Tg2f\#f@34;f7]3>dB29Q+>3-dNa,T#Sde/D=^J:NPG78:_.#[R3R
4EUI-g,U<DVO?f0SY+bV7<eP?9E_Z+9PPc165@Tf+1^W0V3W2f:>.38)g\6gX3g0
<6[69G_cO,G9S47SAXW:I?8QGCTa_@bSB>W8X=J&/;POS:=0A1VF56N[/O2XQ-;U
MPCg-9&bd\UH7.eU[GI]=)\c8e9UX)9Jg@XBJD5?^:=V/O25;VGJRRE1aPDAFDA+
B3LcL/92L+CR>c:;?cESJ:XS\T(B7P+Bc>263g;7Q<]0ZA6V=[g2J;NEHNOEG6S=
1Ff@^4QbJUB\=:VLPUO=?7<U:3J_(VW0WgGYXD;e>W+1SK0?W+^Of^@O&5Ye5&AB
B?K#/\bK3gAR^4F-3@/A[\N.G&E/FGBF,R^17]#W.^2LHSMR;NfNRMf3=;dHU_[Z
#Q<b/[LOc2.(S,H7S(C49a9g;/RY2(;UA4\M7.f:f@7?E2>-)M=,4c4#-G8:7(KU
@0C=-(5d&^b4[B&6=eO[H253aXeYW,;2gF[PcB9DbX4?8K<Ha:EO[U5,f?86cIE@
K<.V7KEM8(C5@YR,;FGL^3#K(I)BPPA\]FV0R?aR(?3NCDcMQ=_W/0c&>ea:&M8a
RTCUH:IHe])^-G#S?)P8+I>[GU+S[RYfMCI8^JA^-1f]dS/8ffX]TPOSR5^cYA4Y
_2]O@0@>@[NGKC(A=UP9#N^\b^HVM?K<3BcQ?U8^7/TRMN:FTd.3SG(79Q-FH@bK
Vb5R4B5(0eKAOda:A)DdRBTY+Z:EAa_WHLG0.4VA+:+F:F23.#DWJA?EB2cK3U;_
La:W?@UHU,0Xc9K8VTN@D-LF)fQ?TG^Kg>B.3AR#/L]HeW^)]_TNX3aJP#a1=_<F
;c\KdLZF_206>cS+6RM58TK5@d@98fHR:TcIbNG(aVDQ2N1@EO(W>,UEOHd#P[c(
(C)EHgg(EM@@b--+_<42P&_eP@,8SK]EC<B-74[C,9\F6Y#fYT>I,HT)J:COH67C
PR<IN\-D;:<=BM#36f=B#:.-S:W1KT],9N,.>91Y3<S^=+GKRE7bV9+8.cSK]a_V
:CKS_3>8d:NY;7;FSZOV]-(7/afQd1&3C:KT.BEa_\NH&a#[:dLYK)d46ga_75Wd
+g5a(D36T0aFZ70VWHR.S-ZVXOdCYdfJE-Kf94#DQ<fH]NSQ#g]]<77J07Z#RRNG
K6^0HYXGP6?ZXcP6QeCf=ZGO0=dSVA=D@ISC+SS@86gD_&\\#U-2XG,XB)_aTK:>
?;g[Nd/XKB/OSE82Y\D\61/[<2>FL(dV,AD;eV6(RdW^c,#=Q(4Z;1UK4fV@FIL.
gHP7ZAWGJYKY\Xe0A\TVEW:>fegG\4URLV2@dWg>?Ub1H\;8fBPG06C2:G+8T/^X
P\Bd6Y<gF)dFeCf<L,MMA0&+HQQb/Yb5(BT8[1.IT;/6<=N)7b(:)f93XNFFW_/#
J#a]ReW2.--E0F&ZRTLOB8F^BM4cEMfJgHLb,FHGNH)\@0d/JV4ZR#8fU#N-V^ZS
N:]d;9IUHfI3E^AH#P[TI>MgHC\ccXFadIGP?ZA_E^-U]/V7AD&7.PJ4LD6>6?Wb
PAFA0P)]1^@M[[7.GTT4P)M5P\HA2?SR/,[2]B#[K@3D&bI-JU(@\P/;FU@,H)7P
b\UPNNILMg<CQV_68dYd<F3Y22WW-[g=A?/43:5L]5O?g>V:6.]RUg-=+;a[J@<&
:HR-PC5Y6_Xd1DT>H,7U7]044^NXgc+GGZfUI#G(&)&7^ZRJXZ#)P@SLBSQ&9^<>
J.NO0,E7XgeM4OC@L(+(cJ8NK9U&30WC):Qb29O\TO2MbQX5b2M<S[/BM7N4VM,G
SJF6VP/?D#a57OSE+0?4ES4bKQ+F2dE/K19^?UE0D02_0gJEJ4HNWbO-d^:-SD/a
+SW[4c?/3<0/I>gREHZ>:B4?OK_0E1<9#<Q#P\07N(YN[eV=fY]P.d=g4Y-9Q]39
/S?&4b=X_=4M6V6>gQQcF7U^[eLIf4OD\dRcf-^#I?)2UZZ?Zf\LU\W]?O->DTa/
/,4@&^fN\YZ@AH<gZ@Z/7Yf-L@H4D7_3LHDUN0]/)89_D:f60=8a<;^)T?57CN-Y
QXa71:faCLUAVS1B@.DU^Vd^>AH5\d=FL;1eDc6R=,Ne)C?CC49+MNKQTIC9_#cJ
<?UHIg.->A^bPR]2WCH2CTO[Q^]_fH;;G,dF4fc5@c]L,LYgL.:2:9DC#Q7^SMNV
PBW?01bc@(gX_e:Q>0b8TB;,g/3c459KD1Y>JRbaE^,aB^;H4^C@g\M5-cO0J_AR
RLV4cKJ)C#JAadabX>2_9-N9g+FXNII6G0cBBH&XT-W\;.<F1@g#U(,AL;?E8IB0
[a[,:/8)9cfb;+P8^C</[HLId>a/fcS:SHN(W8R]^XJSB,/FUI##V3E]^1faf&7?
YQYdWJ7^C).+Yf\W1_V,E+XgV80^9.:&4O11e-0g84g-.?6QOI=R?0gR]H-#R:ZN
YT5^2JS;?>_+<QX4[ROVG?:#-O]e3Rc+]O>aZU4RKJ#Mc+M<(1BCf;KA3e4I0DJ5
-,JPJa;WIb?)VP;b^BW+8A42cNRQC.ZG><>J=#,VZB7XI\I_RbY_P6Q:1Q9+]+^@
B]&+/[UE;&Y(5;L>+.IOWE-(VIb6JV.@62#.LC9bQ[[]G#MM+^V,gJS3IKX=VI:=
=MI9gM4ZdYZIK]E=&:-.:NA<-O.365++O7fY5_=T#aXJO>,<K,C^EY>D:H-VNNGV
IM&-U>]&4S_)FgZKdfP3CEe#:FeNN,]CHAaDGL6)_@?\U_A0EJE7<YAfbZ;50B_e
3/142K2fS@e[NS#EC^XPP&,Y\c,XdT0YALT)GgA4NQOCSc&4?SAGV<KOEe88-(GM
Y7UOU/fNEge[2]VX3_U?^cM&(>\E[H/[[D]^C@FdR)3^Y=f-(eBGU&4DIY7\5+MO
P[NWaXZIPbcY]5?NB;Z_Y\]&[@M8G=\;=A^70(bXG31d[e5;2:+V7()HCV-UObU/
QLCHd@T99B263<@R7@]+IXD[;JVD.-(WD6P.=f/:=5ATYA#gE<=H^[::PcO?>YaH
2Y[02;F?Ra(T76X6/#@XbPdVJA2(L,e>Hfa44IYSCL],89),DP#.8-E]T<2F)#d;
(TZ6bHC&7Q7fHE-^SY6Z,?W<5.efT&eUPHH=[(aI/9VRN?&Q-+8F_5S.H\^/).e9
X#aCd,21VV-667c\@:agTMZ@G5AI:\8aDV3aW@KZQ;73?#RS1CfII.E:P.-[4]9P
/#-2FRKP_Mf\A8(D_d<(7VQK(R/)5YS:]S?\/=O2:Y(b.dE_MQ@J\:7dTR7d\\R7
:E<\(8A]E(KR_5_Q3>0])G<@Tc_03Ub[1Y:F/&)9^g?35B:<6OT)?[W/26a:HR6&
[0)ZZ6&(1^4ZHcaKQTH>/BEHYI1-BC;7\KGR_\L?3OOd[ITN-?(Z_OdN)<Kf?+^3
.^_bVZJK(><#\&)]_-2K(Q8S-)>^:0d1EEge>Tg@[S6DNb.>TcZX2;/?<0GK+J+Q
4^O#S(HG[WQ;9\5-Gd]A]5S/BIW/E5I0LDE&Y5Pd&JKQO3;X-[YgRHEc7aQAc2\P
SEI@b-9E+6G68XKdRAdMSUY/1E/fP@BXe^>-]R&V.)Pa/W9A#+;feJ<1DdE<DaZ^
dC6@J39HCJH054-3_<4^(?R((5J?H-5Y:?f[S=65DNcc61062[=c?C:RY.DgcD6UR$
`endprotected

/** @endcond */

endclass

/**
 * Default policy class to select all parts in all catalogs on a shelf
 * with an equal distribution value of 1.
 */
class svt_mem_all_parts#(type PART=int);
  /** Simply returns 1 */
  static function int weight(PART part);
    return 1;
  endfunction
endclass


/**
 * Class to pick a suitable vendor part at random amongst all
 * vendor parts in all catalogs on a shelf.
 * 
 * The PART parameter defines the suite-specific shelf.
 * 
 * Suitability is determined by the static POLICY:: weight(PART) function.
 * This method is called by this class
 * for each part in each catalg on the shelf.
 * If it returns a zero or negative value, the specified part is not suitable.
 * If it returns a positive value, the part is suitable and the value
 * is the random-distribution weight assigned to that part.
 * 
 * By default, all parts are suitable and have an equal distribution weight value of 1.
 * 
 * User may specify different part selection policies by implementing
 * different static weight(PART) functions. For example:
 * <pre>
 * class only_x16_parts#(type PART=int);
 *   static function int weight(PART part);
 *     if (part.\#get_width() != SVT_MEM_x16) return 0;
 *     return 1;
 *   endfunction
 * endclass
 * </pre>
 */
class svt_mem_part_mgr#(type PART=int, type POLICY=svt_mem_all_parts#(PART));

`ifndef SVT_VMM_TECHNOLOGY
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_part_mgr:class");
`else
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log log = new("svt_mem_part_mgr", "class");
`endif

  /** Pick and return a suitable part from the catalogs on a shelf */
  static function PART pick();
//svt_vcs_lic_vip_protect
`protected
P:F4CLb]P0^]OFI\W0AbVfT;A;LS(-[=>B):DSg^/G^6\BI)H7LI2(]-IZfF7Uc2
aV>>N)+c;#gY-a(Vd#)AIZ8.4LN7R<ZKG\3d9ff-,2BQT;Dc&G?BHGR@BAG&bVK<
UFD_:XL=f7</^cS[IWD6d)#AXNK)GMI@g5A,F8/<-Z7_M&ebV:5^Y[(N_F\CKW#2
aCNBX(/;DDEO&\6KN5B>:bZTdH4AY&:0\HASG4^&gJ-UFMO#?=8C8JDIc];G_VYC
.EC\ZUN-Y8Z8=RG&RLKfT-^3[;JC5FXJO[O/9F/\6T-)@\f_<^+-KURMHPK1A+.@
O>(e#)L@@9JRS5Z1:L2V#X6M8UW4Y\HU,\5W#K]Y9.099F/e[DQNTPHN(W;Y-5bG
DL4[A/?<N#fVNS_7;DYcd,<??5UAK=KfN#KA;OWS_N.^].N?=O\HgC-f:bWM@/=O
;P:E0B^6e-9@,U[Ba:a@U-9-=K^aMEIK.<TNVF)(_QK^N?V:E_,?KUP6VD]L>BX&
PS+[]@c&L)W(M.6cQP:\YQ+dGf@BZ,=)dc-TC0ADa5N<9eN#:+KHNM-3cL(cB2]L
ZTDV=W>MgVSQM&J;[]A[?3G(PGM4C?#5+1bVNEABDfUO-<E_e2;93WP7#(?;W1YV
C10RJNJ>;HQL5G^VK5g.P2M>-.(5439C/)DL70V1F<(>WA0IDOHEU0:1U[KUF\B_
FKR6)SZTG/e\(5X8YRJ6?QQRE=-.Y4M@:9Sb2#Qf-+URA-e)Q7>ag7>,Q/N0(PgR
a7a[AFW-KEXVBCf09<JN/a,DN7L-@5eJP/<]?-JN(8K08>HOT82AQSMW#f2_#/.3
U8/f.HWQ=\:aFON(7SZ;[F)1.8G4K<f0VY)]G(-:.E<TR6P\K^SBBJ(436[>_dE?
]gX2:&<J);_T&:H.Y#QIRLLG6FdG.NOGP^M\9:E5:\B<0/XZLE2;f-XBX8OS<Wdg
feH9aC#.P82X^,H<?4:ReE(TX+OS2RbdbN=,CPd4@XV.ObFVbB3E42FJ22E/#cPX
DIIH6]3I<(aScT2]d2=6:\VW3VP[1ddT8Je(F5K.0QD)]&cD>&=CT]FJI$
`endprotected

  endfunction

endclass

`endif
