//=======================================================================
// COPYRIGHT (C) 2014-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_VIP_WRITER_SV
`define GUARD_SVT_VIP_WRITER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

// ****************************************************************************
// Defines
// ****************************************************************************

/** @cond PRIVATE */

// =============================================================================
/**
 * The svt_vip_writer_object class is a utility class whose primary purpose is to 
 * provide assistance for storing information about VIP "objects".  Each instance
 * of the class stores data for an object that is being captured by the VIP for
 * later display within Protocol Analyzer or Verdi.
 *
 * IMPORTANT: This class is intended for internal use.  VIP clients should never
 *            invoke any of the methods in the class nor modify the class data
 *            members in any manner.
 */
class svt_vip_writer_object;

  // ****************************************************************************
  // Data Members
  // ****************************************************************************

  /** 
   * The begin time for the object.
   */
  realtime begin_time = -1;

  /** 
   * The end time for the object.
   */
  realtime end_time = -1;

  /** 
   * The name of the object type.
   */
  string object_type = "";

  /** 
   * The uid of the object.
   */
  string object_uid = "";

  /** 
   * The uid of the parent object.  An empty string indicates that the object 
   * has no parent.
   */
  string parent_object_uid = "";

  /** 
   * The uid of the predecessor object.  An empty string indicates that the object 
   * has no predecessor.
   */
  string predecessor_object_uid = "";

  /**
   * Writer object which is required to retrive "svt_vip_writer_object" of predecessor.
   */
  svt_vip_writer predecessor_writer = null;

  /**
   * Writer object which is required to retrive "svt_vip_writer_object" of successor.
   */
  svt_vip_writer successor_writer = null;

  /** 
   * The name of the channel with which the object is associated. An empty string
   * indicates that the object is not associated with any specific channel, which 
   * is the default condition for an object.
   */
  string channel = "";

  /** 
   * The status of the object during the transaction. An empty string
   * indicates that the object is not having any status.
   */
  string status = "";

  /** 
   * The uids of the child objects.  An empty queue indicates that the object 
   * has no child objects.
   */
  string child_object_uids[ $ ];

  /** 
   * The uids of the successor objects.  An empty queue indicates that the object 
   * has no successor objects.
   */
  string successor_object_uids[ $ ];

  /**
   * An associative array used to store the specified field values for the object.
   * The values are stored in as strings that have been formatted appropriately
   * for PA, based on the specified type.
   */
  string field_values[ string ];

  /**
   * An associative array used to store the expected specified field values for
   * the object.  The values are stored in as strings that have been formatted
   * appropriately for PA, based on the specified type.
   */
  string field_expected_values[ string ];
  
  /** 
   * String holds the PA header XML structure to be written out to XML.
   * This is added to support backward compatibility.
   */
   string object_block_desc;   
  
  /** 
   * Bit indicates the object beging block already written to XML.
   * This is added to support backward compatibility.
   */
   bit begin_block_save;   
     
`ifdef SVT_FSDB_ENABLE
  /**
   * Transaction ID for FSDB dumping.
   */
  longint unsigned transaction_id;

`endif

endclass
// =============================================================================

/**
 * The svt_vip_pa_relation_object class is a utility class whose primary purpose is to 
 * store the relationship between the objects. This class is required because in verdi 
 * will not allow forward processing. This class will capture the relationship and helps 
 * in updating the relationship the relationship data will be displayed within
 * Protocol Analyzer or Verdi.
 *
 * IMPORTANT: This class is intended for internal use.  VIP clients should never
 *            invoke any of the methods in the class nor modify the class data
 *            members in any manner.
 */

class svt_vip_pa_relation_object;

 // ****************************************************************************
 // Data Members
 // ****************************************************************************

 /**
  * Queue to hold the all the related objects.
  */
  string relation_object_uids [ $ ];

endclass

/** @endcond */

// =============================================================================
/**
 * Utility class used to provide assistance writing information about objects
 * to be displayed with the Protocol Analyzer.
 */
class svt_vip_writer;

`ifdef SVT_VMM_TECHNOLOGY
  /** Built-in shared log instance that will be used by the XML writer instance. */
  vmm_log log;
`else
  /** Built-in shared reporter instance that will be used by the XML writer instance. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Local Data Members
  // ****************************************************************************

  /** 
   * The name of the instance with which the data being written is associated. 
   */
  local string instance_name = "";
  
  /** 
   * The name of the protocol with which the data being written is associated.
   */
  local string protocol_name = "";
  
  /** 
   * The version of the protocol with which the data being written is associated.
   */
  local string protocol_version = "";
  
  /** 
   * The name of the suite with which the data being written is associated. 
   * Note that this attribute is only specified for suites that support PA-style
   * extension definitions with multiple sub-protocols. */
  local string suite_name = "";
                                
  /** 
   * The name of the file that is being written to.  Note that the name of the file
   * is constructed from the arguments specified when the writer is constructed.
   */
  local string file_name;

  /** 
   * The handle to the file that is being written to.  A value of 0 indicates that
   * the file has not yet been opened.  A value of -1 indicates that the file has
   * been previously opened and susequently closed.
   */
  local int file_handle = 0;

  /**
   * An associative array used to create unique object identifiers (uids) on a
   * "type-by-type" basis.  For example, the first object of type "x" will have
   * a uid of "x_1"; the second object of type "x" will have a uid of "x_2"; the
   * first object of type "y" will have a uid of "y_1", and so on.
   */
  local int current_object_type_uid[ string ];
 
  /**
   * An associative array used to keep track of unended objects.  Objects are 
   * added to this array when they are created and are removed when the objects 
   * are ended.  This enables the writer to be aware of which objects have not
   * been ended at the time the writer is closed and can write out those objects 
   * with an appropriate end times (-1) and an appropriate status value (NOT_ENDED).
   *
   * This array also acts as a "lookup table" to get a handle to a svt_vip_writer_object
   * based on a specified object uid.
   */
  local svt_vip_writer_object unended_objects[ string ];

  /** 
   * The uids of the child objects.  An empty queue indicates that the object 
   * has no child objects. This is added to support backward compatibility.
   */
  string pa_object_refs[ $ ];

`ifdef SVT_FSDB_ENABLE
  // ****************************************************************************
  // Local Data Members for FSDB dump
  // ****************************************************************************

  /**
   * An associative array used to keep track of ended objects.  Objects are 
   * added to this array when they are ended and are removed from unended_objects.
   * This enables the writer to find objects when build up relations after objects 
   * are ended.  
   *
   * This array also acts as a "lookup table" to get a handle to a svt_vip_writer_object
   * based on a specified object uid.
   */
  local svt_vip_writer_object ended_objects[ string ];

  /**
   * Relationship object instance, holds all the UIDs which posses the same relationship
   */
  local svt_vip_pa_relation_object pa_relation_object = null; 

  /** 
   * The type of the file to be dumped. 
   * fsdb and fsdb_perf_analysis mean dumping FSDB file only. xml means dumping XML file
   * only. 
   * both means dumping both XML and FSDB files.
   */
  local enum {
    fsdb = `SVT_WRITER_FORMAT_FSDB,
    fsdb_perf_analysis = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS,
    xml = `SVT_WRITER_FORMAT_XML,
    both = `SVT_WRITER_FORMAT_XML_N_FSDB
  } file_format;

  /**
   * The name of FSDB file that is being written to. This is specified by user.
   */
  local string fsdb_file = "";

  /**
   * Array to store the all the relationship object with uid
   */
  local svt_vip_pa_relation_object relation_uids [ string ]; 

  /**
   * The path of parent of streams. It is constructed by protocol_name, 
   * instance_name, protocol_version, and it is used to construct stream name.
   */
  local string fsdb_stream_parent = "";

  /**
   * The path of scope It is constructed using suite name and protocol name.
   */
  local string scope_full_path = "";

  /**
   * An associative array used to keep track of stream ids based on object type.
   * Objects with the same object type will be added as transactions into one 
   * stream in FSDB.
   */
  static longint unsigned stream_id_array[ string ];
 
  /**
   * An associative array to store the full protocol name.
   */
  int protocol_name_array[ string ];

  /**
   * Queue to hold the attribute names which need to be added for
   * the current written out stream.
   */
  string stream_attribute_names[$];
  
  /**
   * Queue to hold the attribute values which need to be added for
   * the current written out stream.
   */
  string stream_attribute_values[$];

`endif

  /** Saved top level scope for this VIP instance */
  local string top_level_scope;

  // ****************************************************************************
  // Constructor
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Constructs a new instance of the svt_vip_writer class.
   *
   * @param instance_name 
   *          The name of the instance with which the writer is associated.
   * @param protocol_name 
   *          The name of the protocol with which the objects being written
   *          are associated.
   * @param protocol_version 
   *          The version of the protocol.
   * @param suite_name 
   *          The name of the suite with which the protocol is associated.
   *          This is only required for suites that support PA-style extension
   *          definitions with multiple sub-protocols.
   * @param file_name 
   *          The name of the xml file, if the name is empty then the name will be
              constructed using 'instance_name' and 'protocol_name'.
   * @param format_type 
   *          The file format type in which the data to be written out. 
   */
  extern function new( string instance_name, 
                       string protocol_name, 
                       string protocol_version, 
                       string suite_name = "", 
                       string file_name = "",
                       int format_type = `SVT_WRITER_FORMAT_FSDB );

  // -------------------------------------------------------------------------------
  /**
   * Utility method to set up the VIP writer class to be used with the debug
   * opts infrastructure.  This is used to modify the top-level scope that transactions
   * are recorded in.
   * 
   * @param vip_path Hierarchical path to the VIP instance
   */
  extern function void enable_debug_opts(string vip_path);

  // -------------------------------------------------------------------------------
  /**
   * This method set the file format type enum to the format the data needs to be dumpped.
   * The format types: `SVT_WRITER_FORMAT_FSDB FSDB, `SVT_WRITER_FORMAT_XML XML, and
   * `SVT_WRITER_FORMAT_XML_N_FSDB for both FSDB and XML. 
   * @param format_type file format type in which the data to be written out.
   */
  extern function bit set_file_dump_format(int format_type); 

  // -------------------------------------------------------------------------------
  /**
   * Method to get the format type which has been established. 
   * The format types: `SVT_WRITER_FORMAT_FSDB FSDB, `SVT_WRITER_FORMAT_XML XML, and
   * `SVT_WRITER_FORMAT_XML_N_FSDB for both FSDB and XML.
   *
   * @return The format type associated with the writer.
   */
  extern function int get_format_type(); 

  // ****************************************************************************
  // Open / Close Writer Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Opens the file handle for a file in write mode.  This method must be called prior 
   * to creating any objects that are associated with the writer.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit open_writer();

  // ----------------------------------------------------------------------------
  /**
   * Closes the file handle for the currently opened file.  Once the writer is closed,
   * no additional objects can be associated with the writer.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit close_writer();

  // ----------------------------------------------------------------------------
  /**
   * Gets the opened / closed status of the writer.
   *
   * @return The current open / closed status.
   */
  extern function bit is_writer_open();

  // ****************************************************************************
  // Create, Begin and End Object Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Creates a new object and returns the uid for the newly-created object.  The 
   * start time for the object is set to the current simulation time.
   *
   * @param object_type 
   *          The type of object to be created.
   * @param object_uid 
   *          The uid for the object to be created.  If not specified, a uid is
   *          automatically created, based on the specified object type.
   * @param parent_object_uid
   *          The uid of the parent object, if applicable and known at the time
   *          the object is being created.  This value can be set up until the
   *          point at which the object is ended.
   * @param object_channel 
   *          The channel with which the object is associated, if applicable and
   *          known at the time the object is being created.  This value can be
   *          set up until the point at which the object is ended.
   * @param begin_time
   *          The start time of the object. If the start time is not passed, 
   *          the current time is set as start time. The start time will be used
   *          for XML to support backward compatibility and also in cases where the 
   *          start time of the object can't be determined during the start of the 
   *          object. If the object time is know during the start of the object don't
   *          pass strat time, leave it to the writer to add the current time.
   * @param end_time The end time of the object. The will be used only for XML to support
   *          backward compatibility. FSDB will not accept end time and expect the object
   *          end si called exactly when the object ends.  
   * @param status The status of the object.
   * @param time_unit Time unit used during the simulation.
   * @param label If specified, sets the label of the object; otherwise the name
   *          of the object type is used.
   * @param attr_name Queue of stream attribute names to add
   * @param attr_val Queue of stream attribute values to add
   *
   * @return The uid of the new object.  If the object uid was specified, the
   *         same string is returned.  An empty string indicates that an error
   *         occurred while attempting to create the new object.
   */
  extern virtual function string object_create( string object_type, 
                                                string object_uid = "", 
                                                string parent_object_uid = "", 
                                                string object_channel = "",
                                                realtime begin_time = -1,
                                                realtime end_time = -1,
                                                string status = "", 
                                                string time_unit = "",
                                                string label = "",
                                                string attr_name[$] = '{},
                                                string attr_val[$] = '{});

  // ----------------------------------------------------------------------------
  /**
   * Creates a new object XML data and save it to temp data structure.
   * This method is added for backward compatibility.
   * This method receives the complete begin block to be written.
   *
   * @param object_uid 
   *          The uid for the object to be created.  If not specified, a uid is
   *          automatically created, based on the specified object type.
   * @param object_block_desc 
   *          The object_desc which contains the XML block for PA object header.
   */
  extern virtual function bit save_object_begin_block( string object_uid , 
                                                       string object_block_desc = ""); 

  // ----------------------------------------------------------------------------
  /**
   * Begins an object.  When this method is called, the begin time of the object
   * is set to the current simulation time, if not already set.  If the begin time
   * of the object has already been set, the object has already been started and
   * this method will have no effect on the object; however, an error will be
   * reported and the method will return a failure status.
   *
   * @param object_uid
   *          The uid of the object to be ended.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit object_begin( string object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Ends an object.  When this method is called, the end time of the object is
   * set to the current simulation time.  At this point, all information about
   * the object is considered to have been specified; thus, no further changes
   * can be made to the attributes associated with the object.
   *
   * It is important that all objects be ended at the appropriate time during
   * the simulation.  Objects that have not been ended at the conclusion of the 
   * simulation will have a status of NOT_ENDED, which is considered to be an
   * error condition.
   *
   * @param object_uid
   *          The uid of the object to be ended.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit object_end( string object_uid );

  // ****************************************************************************
  // General Object Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
  /**
   * Specifies the channel with which the object with the specified uid is 
   * associated.  This method can be called up until the point at which the 
   * object is ended.
   *
   * @param channel
   *          The name of the channel with which the object is to be associated.
   *          If an empty string is specified, the object is not associated with
   *          any channel (which is the default condition for an object).
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_channel( string object_uid,
                                                  string channel );

  // ----------------------------------------------------------------------------
  /**
   * Specifies the uid of the parent object for the object with the specified uid.
   * This method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the parent object.  This allows a parent object to
   * be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the parent object has been 
   * created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * parent object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object whose parent object is to be specified.
   * @param parent_object_uid
   *          The uid of the parent object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_parent( string object_uid,
                                                 string parent_object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Adds a child object to the object with the specified uid.  An object can have
   * multiple child objects, as appropriate for the protocol.  This method can be 
   * called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the child object.  This allows a child object to
   * be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the child object has been 
   * created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * child object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a child object is to be added.
   * @param child_object_uid
   *          The uid of the child object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_child( string object_uid,
                                                string child_object_uid );

  // ----------------------------------------------------------------------------
  /**
   * Adds an array of child objects to the object with the specified uid.  This
   * method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uids that are specified for the child objects.  This allows any or all of
   * the child objects to be specified as (a) objects that have not yet been
   * created (assuming that object uids are being managed / constructed by the
   * VIP and are not being automatically generated by the VIP writer); or (b) the
   * child objects have been created (so that the uids of the objects have been
   * constructed), but that the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for any
   * of the child objects has been created, PA will report this situation when the
   * data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a child objects are to be added.
   * @param child_object_uids
   *          The uids of the child objects.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_children( string object_uid,
                                                   string child_object_uids[] );
  // ----------------------------------------------------------------------------
  /**
   * Adds an array of interface path into the FSDB scope with a predefined attribute name. 
   * The interface path is added to predefined attribute name "verdi_link_interface"
   * by which we can take advantage of verdi APIs to read the data from FSDB.
   * If the interface paths are multiple the attribute name will be incremented with numeric 
   * Eg:"verdi_link_interface_1","verdi_link_interface_2" etc.
   *
   * @param if_paths
   *          The interface paths for all the interfaces.
   */
  extern virtual function void add_if_paths( string if_paths[] );

  // ----------------------------------------------------------------------------
  /**
   * Adds an single object ref to XML file.  This method is added to support
   * backward compatibility.
   *
   * @param ref_object_uid
   *          The string formatted in XML contains the child object uid for the object.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_pa_reference( string ref_object_uid);
  
  // ----------------------------------------------------------------------------
  /**
   * Specifies the uid of the predecessor object for the object with the specified
   * uid.  This method can be called up until the point at which the object is 
   * ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the predecessor object.  This allows a predecessor
   * object to be specified as (a) an object that has not yet been created (assuming
   * that object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the predecessor object has 
   * been created (so that the uid of the object has been constructed), but that
   * the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * predecessor object has been created, PA will report this situation when the
   * data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object whose predecessor object is to be specified.
   * @param predecessor_object_uid
   *          The uid of the predecessor object.
   * @param predecessor_writer
   *          The "svt_vip_writer" instance with which the predecessor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_predecessor( string object_uid,
                                                      string predecessor_object_uid, 
                                                      svt_vip_writer predecessor_writer = null);

  // ----------------------------------------------------------------------------
  /**
   * Adds a successor object to the object with the specified uid.  An object can
   * have multiple successor objects, as appropriate for the protocol.  This method
   * can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uid that is specified for the successor object.  This allows a successor object
   * to be specified as (a) an object that has not yet been created (assuming that
   * object uids are being managed / constructed by the VIP and are not being 
   * automatically generated by the VIP writer); or (b) the successor object has 
   * been created (so that the uid of the object has been constructed), but that the
   * object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for the
   * successor object has been created, PA will report this situation when the data
   * created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a successor object is to be added.
   * @param successor_object_uid
   *          The uid of the successor object.
   * @param successor_writer
   *          The "svt_vip_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successor( string object_uid,
                                                    string successor_object_uid, 
                                                    svt_vip_writer successor_writer = null );

  // ----------------------------------------------------------------------------
  /**
   * Adds an array of successor objects to the object with the specified uid.
   * This method can be called up until the point at which the object is ended.
   *
   * At the time this method is called, no checks are performed to validate the 
   * uids that are specified for the successor objects.  This allows any or all
   * of the successor objects to be specified as (a) objects that have not yet
   * been created (assuming that object uids are being managed / constructed by
   * the VIP and are not being automatically generated by the VIP writer); or 
   * (b) the successor objects have been created (so that the uids of the objects
   * have been constructed), but that the object has not yet begun.
   *
   * If at the time the simulation ends, no object with the uid specified for any
   * of the successor objects has been created, PA will report this situation when
   * the data created by the VIP is being read into a protocol view in a project.
   *
   * @param object_uid
   *          The uid of the object to which a successor objects are to be added.
   * @param successor_object_uids
   *          The uids of the successor objects.
   * @param successor_writer
   *          The "svt_vip_writer" writer with which the successor object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_successors( string object_uid,
                                                     string successor_object_uids[],
                                                     svt_vip_writer successor_writer = null);

  /** Get a handle to the file that is being written to. */
  extern function int get_file_handle();

  /**
   * Records various aspects of the VIP in the FSDB as scope attributes
   * 
   * NOTE: This method has been deprecated and should no longer be used.
   * 
   * @param vip_name Hierarchical name to the VIP instance
   * @param if_path Path to the interface instance
   */
  extern function void record_vip_info(string vip_name, string if_path);

  // ****************************************************************************
  // Object Field Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  // Bit Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a bit field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_bit( string object_uid,
                                                          string field_name,
                                                          bit    field_value,
                                                          bit    expected_field_value = 0,
                                                          bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Bit-vector Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a bit-vector field for an object.  This method can 
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_bit_vector( string       object_uid,
                                                                 string       field_name,
                                                                 bit [1023:0] field_value,
                                                                 int          numbits = 4096,
                                                                 bit [1023:0] expected_field_value = 0,
                                                                 bit          has_expected = 0 );

  //----------------------------------------------------------------------------
  // Logic-vector Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a logic-vector field for an object.  This method can 
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_logic_vector( string         object_uid,
                                                                   string         field_name,
                                                                   logic [1023:0] field_value,
                                                                   int            numbits = 4096,
                                                                   logic [1023:0] expected_field_value = 0,
                                                                   bit            has_expected = 0 );

  //----------------------------------------------------------------------------
  // Integer Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a integer field for an object.  This method  can
   * be called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param numbits
   *          The bits size of the value required for FSDB.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_int( string  object_uid,
                                                          string  field_name,
                                                          longint field_value,
                                                          int     numbits = 32,
                                                          longint expected_field_value = 0,
                                                          bit     has_expected = 0 );

  //----------------------------------------------------------------------------
  // Real Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a real field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   *
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_real( string object_uid,
                                                           string field_name,
                                                           real   field_value,
                                                           real   expected_field_value = 0,
                                                           bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Time Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a time field for an object.  This method can be 
   * called up until the point at which the object is ended; however, only
   * the last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_time( string object_uid,
                                                           string field_name,
                                                           realtime   field_value,
                                                           realtime   expected_field_value = 0,
                                                           bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // String Field Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Specifies the value of a string field for an object.  This method can be
   * called up until the point at which the object is ended; however, only the
   * last value specified is associated with the field.
   *
   * @param object_uid 
   *          The uid of the object to be modified.
   * @param field_name 
   *          The name to be field whose value is being specified.
   * @param field_value 
   *          The field value.
   * @param expected_field_value 
   *          The expected field value.  If this value differs from the field_value,
   *          the object will be marked as having an error condition.
   * @param has_expected
   *          The flag to indicate if expected_field_value differs from the
   *          field_value.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_object_field_value_string( string object_uid,
                                                             string field_name,
                                                             string field_value,
                                                             string expected_field_value = "",
                                                             bit    has_expected = 0 );

  //----------------------------------------------------------------------------
  // Tag Methods
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Adds a tag to an object.  This method can be called up until the point at
   * which the object is ended; however, only the last value specified is
   * associated with the object.
   *
   * @param object_uid 
   *          The uid of the object to be tagged.
   * @param tag_name 
   *          The name of the tag to be added.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit add_object_tag( string object_uid,
                                              string tag_name );

  // ****************************************************************************
  // Local Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Retrieves the instance of the svt_vip_writer_object class that is associated
   * with the specified object uid.  If no object can be located within the array 
   * of unended objects, the method will report and error and return null.
   *
   * @param object_uid 
   *          The uid of the object to be found.
   * @param check_begin_time 
   *          Indicates whether or not the object begin time should be checked.
   *          If this attribute is set to 1, and the object begin time is -1, 
   *          the method will report and error and return null.  Note that by
   *          default, the object begin time is checked.
   * @param find_all
   *          Indicates whether or not to only look for unended objects.  If this
   *          attribute is set to 1, the method will only look for unended objects.
   *          If this attribute is set to 0, the method will look for both ended
   *          and unended objects.
   * @return The instance of the svt_vip_writer_object class that is associated
   *         with the specified object uid, or null, if no such object was found.
   */
  extern function svt_vip_writer_object get_object_from_uid( string object_uid, 
                                                             bit    check_begin_time = 1,
                                                             bit    find_all = 0 );

  // ---------------------------------------------------------------------------
  /**
   * Creates a string that can be specified as an attribute value in an XML file
   * by replacing any characters that would otherwise lead to processing errors.
   *
   * @param original_string 
   *          The string to be processed.
   * @return The "XML-friendly" string (which may be the same as the original string).
   */
  extern local function string create_xml_attribute_string( string original_string );

  // ----------------------------------------------------------------------------
  /**
   * Ends an object.  When this method is called, the end time of the object is
   * set to the current simulation time or left unchanged (meaning the end time
   * is -1 and this method is being called to write out unended objects).  At this
   * point (under either scenario), all information about the object is considered
   * to have been specified; thus, no further changes can be made to the attributes
   * associated with the object.
   *
   * @param pa_object
   *          The object to be ended, if available; otherwise, this value should 
   *          be set to null and the value of object_uid will be utilized to find
   *          the object of interest.
   * @param object_uid
   *          The uid of the object to be ended.  This value is ignored if a
   *          non-null handle to a svt_vip_writer_object is provided.
   * @param set_end_time
   *          Indicates whether or not the end time of the object should be set
   *          to the current simulation time or left unchanged.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern local function bit local_object_end( svt_vip_writer_object pa_object,
                                                      string object_uid,
                                                      bit    set_end_time = 1 );

  // ----------------------------------------------------------------------------
  /**
   * Writes the data associated with an object.
   *
   * @param pa_object 
   *          The object to be written.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern local function bit write_object( svt_vip_writer_object pa_object );

`ifdef SVT_FSDB_ENABLE

  /**
   * Transform a string into legal name for FSDB dumping. FSDB treats "." as
   * delimiter for hierarchy.
   * 
   * @param name, the string to be transformed.
   * @return The transformed string, which is a legal name for FSDB.
   */
  extern local function string get_legal_fsdb_name( string name );

  /**
   * Find stream id with given object type.
   * 
   * @param object_type, the object type to look for
   * @param object_channel, channel for which object belongs
   * @param attr_name Queue of stream attribute names to add
   * @param attr_val Queue of stream attribute values to add
   * @return the stream id if found, 0 if not found.
   */
  extern local function longint unsigned get_stream_id_by_type( string object_type, string object_channel, string attr_name[$] = '{}, string attr_val[$] = '{});


`endif

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a scope attribute, incorporating 'fsdb_file' if present.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @param scope_name The name of the scope for which the attribute needs to be added.
   *                    If the scope name is empty then the scope attribute will be added to the 
   *                    'parent' scope. The default scope name will be empty.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_scope_attribute(string attr_name, string attr_value, string scope_name = "");

  // ----------------------------------------------------------------------------
  /**
   * Utility function used to add a stream attribute.
   * 
   * @param attr_name The name of the attribute to be added.
   * @param attr_value The value associated with the attribute
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern function bit add_stream_attribute( string attr_name, string attr_value );
  
  // ----------------------------------------------------------------------------
  /**
   * This function sets the identical transaction relation for the 'target_object_uid' to the  
   * 'source_object_uid' inside FSDB.
   *
   * @param source_object_uid
   *          The uid of the object whose identical object is to be specified.
   * @param target_object_uid
   *          The uid of the identical object.
   * @param target_writer
   *          The "svt_vip_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_identical_relation( string source_object_uid,
                                                      string target_object_uid, 
                                                      svt_vip_writer target_writer = null );

 // ----------------------------------------------------------------------------
  /**
   * This function sets the identical transaction relation for all 'target_object_uids' to 
   * the 'source_object_uid' inside FSDB.
   *
   * This method calls the 'svt_vip_writer' method to write out the identical relation 
   * into indicated XML/FSDB. 
   *
   * @param source_object_uid
   *          The uid of the object whose identical object is to be specified.
   * @param target_object_uids
   *          Set of uids of the identical objects.
   * @param target_writer
   *          The "svt_vip_writer" instance with which the identical object is
   *          associated or null for the current writer.
   * @return The status of the operation; 1 = success, 0 = failure.
   */
  extern virtual function bit set_identical_relations( string source_object_uid,
                                                       string target_object_uids[], 
                                                       svt_vip_writer target_writer = null );

endclass

// =============================================================================

  // ****************************************************************************
  // Constructor
  // ****************************************************************************

// ----------------------------------------------------------------------------
function svt_vip_writer::new( string instance_name, 
                              string protocol_name, 
                              string protocol_version, 
                              string suite_name = "", 
                              string file_name = "", 
                              int format_type = 0 );
  begin
    // Save the specified arguments if needed for future reference.
    this.instance_name    = instance_name;
    this.protocol_name    = protocol_name;
    this.protocol_version = protocol_version;
    this.suite_name       = suite_name;
    this.file_name        = file_name;
    void'(set_file_dump_format(format_type));
   
`ifndef SVT_VMM_TECHNOLOGY
    reporter = svt_non_abstract_report_object::create_non_abstract_report_object(file_name);
`else
    log = new(file_name, "CLASS");
`endif
      
`ifdef SVT_FSDB_ENABLE
    // VERDI: create stream parent name: { suite_name (if has), "."(if has suite_name), protocol_name, ".", instance_name" }
    // VERDI TODO: need to put version info to scope attribute instead of inside the scope name
    if (this.file_format != xml) begin
      svt_debug_opts debug_opts = svt_debug_opts::get();
      if (debug_opts.is_debug_enabled("", ""))
        fsdb_file = `SVT_DEBUG_OPTS_FSDB_FILE_NAME;

      this.fsdb_stream_parent = {"VIP",".",instance_name};
      this.scope_full_path = protocol_name;
      if (suite_name != "") begin
        this.scope_full_path = { suite_name, " ", protocol_name };
      end
    end
`endif
  end
endfunction

// ----------------------------------------------------------------------------
function void svt_vip_writer::enable_debug_opts(string vip_path);
`ifdef SVT_FSDB_ENABLE
  this.fsdb_stream_parent = { "SNPS_DEBUG_OPTS", ".", this.instance_name};
  void'(add_scope_attribute(vip_path, "snps_vip_path"));
`endif
endfunction

  // ****************************************************************************
  // Open / Close Writer Methods
  // ****************************************************************************

// ----------------------------------------------------------------------------
function bit svt_vip_writer::open_writer();
  begin
`ifdef SVT_FSDB_ENABLE
    if (this.file_format inside { fsdb, fsdb_perf_analysis })
      return 1;
`endif

    // Construct the file name.
    if ( file_name == "")
      file_name = { this.instance_name, ".", this.protocol_name, ".xml" };
    else 
      file_name = { file_name, ".xml" };
    `svt_debug( "new", $sformatf( "Writer file is '%0s'", file_name ) );
       
    // Check if the file is already open.  If so, report a warning and return
    // 1, indicating success.  If the file has been closed, report an error and
    // return 0, indicating failure.
    if (file_handle > 0 ) begin
      `svt_warning( "open_writer", $sformatf( "The file '%0s' is already open", file_name ) );
      return 1;
    end else if (file_handle == -1 ) begin
      `svt_error( "open_writer", $sformatf( "The file '%0s' has been closed", file_name ) );
      return 0;
    end
        
    // Attempt to open the file.
    file_handle = $fopen( file_name, "w" );

    // If the file was not opened, generate an error and return 0, indicating failure.
    if ( file_handle == 0 ) begin
      `svt_error( "open_writer", $sformatf( "Failed attempting to open file '%0s'", file_name ) );
      return 0;
    end
      
    // Write the XML starting information to the file.  If a suite name was 
    // specified, include that name in the protocol attribute.
    $fwrite( file_handle, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" );
    $fwrite( file_handle, $sformatf( "<objects instance=\"%0s\" protocol=", instance_name ) );
    if ( suite_name == "" )
      $fwrite( file_handle, $sformatf( "\"%0s\"", protocol_name ) );
    else
      $fwrite( file_handle, $sformatf( "\"%0s %0s\"", suite_name, protocol_name ) );

    $fwrite( file_handle, $sformatf( " version=\"%0s\">\n", protocol_version ) );
      
    // Return 1, indicating success.
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::close_writer();
  begin
`ifdef SVT_FSDB_ENABLE
    if (this.file_format inside {xml, both}) begin
`endif

      // Check if the file has already been closed.  If so, report a warning and 
      // return 1, indicating success.  If the file has not yet been opened, 
      // report a warning and return 1, indicating success.
      if ( file_handle == -1 ) begin
        `svt_warning( "close_writer", $sformatf( "The file '%0s' has already been closed", file_name ) );
        return 1;
      end else if ( file_handle == 0 ) begin
        `svt_error( "close_writer", $sformatf( "The file '%0s' was not previously opened", file_name ) );
        return 0;
      end

`ifdef SVT_FSDB_ENABLE
    end
`endif
       
    // Write out any unended objects.
    if ( unended_objects.num() > 0 ) begin
      `svt_debug( "close_writer", $sformatf( "Writing %0d objects that were not ended", unended_objects.num() ) );
      foreach ( unended_objects[ i ] ) begin
        string object_uid = i;
        svt_vip_writer_object unended_pa_object = unended_objects[ object_uid ];
        void'(local_object_end( unended_pa_object, "-1", 0 ));
      end
    end      
      
`ifdef SVT_FSDB_ENABLE
    if (this.file_format inside {xml, both}) begin
`endif

      // Write the XML ending information to the file.
      $fwrite( file_handle, "</objects>\n" );
        
      // Close the file.
      `svt_debug( "close_writer", $sformatf( "Closing file '%0s'", file_name ) );
      $fclose( file_handle );
      
      // Set the value of the file handle to -1, to indicate that the file was
      // previously opened and is now closed.
      file_handle = -1;
      
`ifdef SVT_FSDB_ENABLE
    end
`endif
    // Return 1, indicating success.
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::is_writer_open();
  begin
    // If the value of the file handle is greater than 0, the file is open.
    if ( file_handle > 0 )
      return 1;
    else
      return 0;
  end
endfunction

  // ****************************************************************************
  // General Object Methods
  // ****************************************************************************

// ----------------------------------------------------------------------------
function string svt_vip_writer::object_create( string object_type,
                                               string object_uid = "",
                                               string parent_object_uid = "",
                                               string object_channel = "",
                                               realtime begin_time = -1,
                                               realtime end_time = -1,
                                               string status = "",
                                               string time_unit = "",
                                               string label = "",
                                               string attr_name[$] = '{},
                                               string attr_val[$] = '{});
  begin
    svt_vip_writer_object pa_object = null;
    int object_type_count = -1;
    if ( object_uid == "" ) begin
      if ( current_object_type_uid.exists( object_type ) ) begin
        current_object_type_uid[ object_type ] += 1;
        object_type_count = current_object_type_uid[ object_type ];
      end else begin
        current_object_type_uid[ object_type ] = 1;
        object_type_count = 1;
      end

      object_uid = $sformatf( "%0s_%0d", object_type, object_type_count );
    end
      
    // Create a new object.
    pa_object = new();

    // Save the specified or calculated arguments with the new svt_vip_writer_object instance.
    pa_object.object_uid        = object_uid;
    pa_object.object_type       = object_type;
    // Begin time will be passed as zero for certain transaction, check for '<=0'
    if ( begin_time <= 0 ) begin
      pa_object.begin_time      = $realtime;
    end else begin
      pa_object.begin_time      = begin_time;
    end
    pa_object.parent_object_uid = parent_object_uid;
    pa_object.channel           = object_channel;
    pa_object.status            = status; 
    pa_object.end_time          = end_time;    
    
    // Add the newly-created object to the array of unended objects.
    unended_objects[ object_uid ] = pa_object;
      
`ifdef SVT_FSDB_ENABLE
    pa_object.transaction_id = 0;
    if (this.file_format != xml) begin
          
      // VERDI: get stream id first
      static longint unsigned  stream_id = 0;
      static longint unsigned  st_transaction_id = 0;
      stream_id = get_stream_id_by_type(object_type, object_channel, attr_name, attr_val);
      // Update Parent child correctly for FSDB writing
      if (pa_object.parent_object_uid != "") begin
        if (relation_uids.exists(pa_object.parent_object_uid))begin
          pa_relation_object = relation_uids[pa_object.parent_object_uid];
          pa_relation_object.relation_object_uids.push_back( pa_object.object_uid);
        end else begin
          pa_relation_object = new;
          pa_relation_object.relation_object_uids.push_back(pa_object.object_uid);
          relation_uids[pa_object.parent_object_uid] = pa_relation_object;
        end  
      end
      
      if (relation_uids.exists(pa_object.object_uid)) begin
        string child_object_id;
        svt_vip_pa_relation_object pa_relation_object = relation_uids[pa_object.object_uid];
        int child_count = pa_relation_object.relation_object_uids.size();  
        for ( int i=0; i<child_count; i++) begin
          child_object_id = pa_relation_object.relation_object_uids[i];
          pa_object.child_object_uids.push_back(child_object_id);
        end
        relation_uids.delete(pa_object.object_uid);
      end
      
      if (stream_id != 0) begin
        static string st_object_type = "";
        st_object_type = object_type; 
        // VERDI: call $fsdbTrans_begin() here, and save transaction id.
        // Leave it for FSDB to set the begin time if begin_time is -1 or 0.
        // Note that certian clients(Eg: USB packet transaction) passing begin time as zero, check for '<=0' instead of just -1.
        // Note that certain clients(Eg: PCIE DLLP, TLP transactions) pass begin time same as current simulation time, this was 
        // causing round off issues inside PLI, check 'begin_time' == current time and if equal leave the Verdi API to set time.
        // Floating point equality comparator might cause issue in certain case if there is issue with start time for 
        // XML/FSDB please check the comparator.
        if ( begin_time <= 0 || begin_time == $realtime) begin
          pa_object.transaction_id = $fsdbTrans_begin(stream_id, "+type+transaction");
        end else begin
          static realtime st_begin_time = 0;
          static string st_time_unit = "";
          st_begin_time =  begin_time; 
          st_time_unit = time_unit;
          pa_object.transaction_id = $fsdbTrans_begin(stream_id, "+type+transaction", "+time", st_begin_time, "+time_unit", st_time_unit);
        end
        st_transaction_id = pa_object.transaction_id;
        
        if ( label == "" )
          $fsdbTrans_set_label(st_transaction_id, st_object_type);
        else
          $fsdbTrans_set_label(st_transaction_id, label);

        if (object_channel != "") begin
          static string channel;
          channel = object_channel;
          $fsdbTrans_add_attribute(st_transaction_id, channel);
        end
      end
    end
`endif
    // Return the uid of the newly-created object.
    return object_uid;
  end
endfunction

//-----------------------------------------------------------------------------
function bit svt_vip_writer::save_object_begin_block(string object_uid, string object_block_desc = "");
  begin
    svt_vip_writer_object pa_object = new();
    pa_object.object_uid = object_uid;
    pa_object.object_block_desc = object_block_desc;
    pa_object.begin_block_save = 1;
    // Add the newly-created object to the array of unended objects.
    unended_objects[ object_uid ] = pa_object;
    return pa_object.begin_block_save;
  end
endfunction 

// ----------------------------------------------------------------------------
function bit svt_vip_writer::object_begin( string object_uid );
  begin
    svt_vip_writer_object pa_object = null;
    `svt_debug( "object_begin", $sformatf( "Beginning object '%0s'", object_uid ) );
      
    // Find the svt_vip_writer_object instance associated with the specified 
    // object uid, but don't check the begin time, as it is expected to have a
    // value of -1.  If no such object is found, return 0, indicating failure.
    pa_object = get_object_from_uid( object_uid, 0 );
    if ( pa_object == null ) 
      return 0;
        
    // Check if the begin time has already been set (i.e. the object has been
    // previously started).  If so, report and error and return 0. indicating
    // failure.
    if ( pa_object.begin_time < 0 ) begin
      `svt_error( "object_begin", 
                                 $sformatf( "Object '%0s' was already begun at time '%0.4f'", 
                                            object_uid, pa_object.begin_time ) );
      return 0;
    end
      
    // Update the begin time to the current simulation time.
    pa_object.begin_time = $realtime;
    
    // Return 1, indicating success.
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::object_end( string object_uid );
  begin
    // Call the "local" version of object end, which deals with both objects
    // that are really ending "now" as well an unended objects, whose end times
    // need to remain at -1.
    object_end = local_object_end( null, object_uid, 1 );
  end
endfunction

  // ****************************************************************************
  // General Object Methods
  // ****************************************************************************

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_channel( string object_uid,
                                                 string channel );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
      
    // Update the channel for the object and return 1, indicating success.
    pa_object.channel = channel;
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_parent( string object_uid,
                                                string parent_object_uid );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
      
    // Update the parent object uid for the object and return 1, indicating success.
    pa_object.parent_object_uid = parent_object_uid;
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_object_child( string object_uid,
                                               string child_object_uid );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null ) begin
      `svt_error( "add_object_child", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                           object_uid ) );
      return 0;
    end
      
    `svt_debug( "add_object_child", $sformatf( "Adding object '%0s' as a child of object '%0s'",
                                                          child_object_uid, object_uid ) );
      
    // Add the uid of the child object to the list of child object uids and 
    // return 1, indicating success.
    pa_object.child_object_uids.push_back( child_object_uid );
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_pa_reference( string ref_object_uid);
  begin
    pa_object_refs.push_back( ref_object_uid );
    return 1;
  end
endfunction

//-----------------------------------------------------------------------------
function void svt_vip_writer::add_if_paths(string if_paths[]);
`ifdef SVT_FSDB_ENABLE
  begin
    string if_path = "";
    string if_path_arg = "";
    string attribute_name_str = "";
    for ( int i = 0; i < if_paths.size(); i++ ) begin
      if_path = if_paths[ i ];
      `svt_verbose( "add_if_paths", $sformatf( "Adding interface path '%0s' to instance %0s",if_path,this.fsdb_stream_parent));
      if(i == 0)
        if_path_arg = "verdi_link_interface";
      else begin
        attribute_name_str = $sformatf("verdi_link_interface_%0d", i);
        if_path_arg = attribute_name_str;
      end
      void'(add_scope_attribute(if_path, if_path_arg));
    end
  end
`endif
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_object_children( string object_uid,
                                                  string child_object_uids[] );
  begin
    int count = 0;
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null ) begin
      `svt_error( "add_object_children", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                          object_uid ) );
      return 0;
    end
      
    // Add the uid of each child object to the list of child object uids.
    count = child_object_uids.size();
    for ( int i = 0; i < count; i++ ) begin
      string child_object_uid = child_object_uids[ i ];
      `svt_debug( "add_object_children", $sformatf( "Adding object '%0s' as a child of object '%0s'",
                                                                   child_object_uid, object_uid ) );
      pa_object.child_object_uids.push_back( child_object_uid );
    end
        
    // Return 1, indicating success.
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_predecessor( string object_uid,
                                                     string predecessor_object_uid,
                                                     svt_vip_writer predecessor_writer = null );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid, 0, 1 );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    begin
      svt_vip_writer_object successor_pa_object = get_object_from_uid( object_uid, 0, 1 );
      svt_vip_writer_object predecessor_pa_object = null;

      if ( predecessor_writer == null )
        predecessor_pa_object = get_object_from_uid( predecessor_object_uid, 0, 1 );
      else
        predecessor_pa_object = predecessor_writer.get_object_from_uid( predecessor_object_uid, 0, 1 );

      if ( predecessor_pa_object == null )
        begin
          `svt_error( "set_object_predecessor", 
                       $sformatf( "Unable to find an object with uid '%0s'", predecessor_object_uid ) );
           return 0;
         end
      else
        begin
          // Verdi supports only 'succ_pred' key, the order of the transaction id always as to be successor to predecessor.          
          $fsdbTrans_add_relation( "succ_pred", successor_pa_object.transaction_id, predecessor_pa_object.transaction_id );
        end
    end
`else
    // Update the predecessor object uid for the object.
    pa_object.predecessor_object_uid = predecessor_object_uid;
    if ( predecessor_writer != null )
      pa_object.predecessor_writer = predecessor_writer;
`endif
    `svt_debug( "set_object_predecessor", $sformatf( "Adding object '%0s' as a predecessor of object '%0s'",
                                                                predecessor_object_uid, object_uid ) ); 
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_object_successor( string object_uid,
                                                   string successor_object_uid, 
                                                   svt_vip_writer successor_writer = null );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid, 0, 1 );
    if ( pa_object == null ) begin
      `svt_error( "add_object_successor", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                          object_uid ) );
      return 0;
    end
 
`ifdef SVT_FSDB_ENABLE
    begin
      svt_vip_writer_object predecessor_pa_object = get_object_from_uid( object_uid, 0, 1 );
      svt_vip_writer_object successor_pa_object = null;

      if ( successor_writer == null )
        successor_pa_object = get_object_from_uid( successor_object_uid, 0, 1 );
      else
        successor_pa_object = successor_writer.get_object_from_uid( successor_object_uid, 0, 1 );

      if ( successor_pa_object == null )
        begin
          `svt_error( "add_object_successor", 
                       $sformatf( "Unable to find an object with uid '%0s'", successor_object_uid ) );
           return 0;
         end
      else
        begin
          $fsdbTrans_add_relation( "succ_pred", successor_pa_object.transaction_id, predecessor_pa_object.transaction_id );
        end
    end
`else
      // Add the instance name and uid of the successor object to the list of 
      // uids and return 1, indicating success.
      pa_object.successor_object_uids.push_back( successor_object_uid );
      if ( successor_writer != null )
        pa_object.successor_writer = successor_writer;
`endif
    `svt_debug( "add_object_successor", $sformatf( "Adding object '%0s' as a successor of object '%0s'",
                                                                successor_object_uid, object_uid ) );
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_object_successors( string object_uid,
                                                    string successor_object_uids[],
                                                    svt_vip_writer successor_writer = null );
  begin
    int count = 0;
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid, 0, 1 );
    if ( pa_object == null ) begin
      `svt_error( "add_object_successors", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                          object_uid ) );
      return 0;
    end
      
    // Add the instance name and uid of each successor object to the list of uids
    count = successor_object_uids.size();
    if ( successor_writer != null )
      pa_object.successor_writer = successor_writer;

    for ( int i = 0; i < count; i++ ) begin
      string successor_object_uid = successor_object_uids[ i ];

`ifdef SVT_FSDB_ENABLE
      begin
        svt_vip_writer_object predecessor_pa_object = get_object_from_uid( object_uid, 0, 1 );
        svt_vip_writer_object successor_pa_object = null;

        if ( successor_writer == null )
          successor_pa_object = get_object_from_uid( successor_object_uid, 0, 1 );
        else
          successor_pa_object = successor_writer.get_object_from_uid( successor_object_uid, 0, 1 );

        if ( successor_pa_object == null )
          begin
            `svt_error( "add_object_successor", 
                       $sformatf( "Unable to find an object with uid '%0s'", successor_object_uid ) );
            return 0;
          end
        else
          begin
            $fsdbTrans_add_relation( "succ_pred", successor_pa_object.transaction_id, predecessor_pa_object.transaction_id );
          end
      end
`else
      // Add the instance name and uid of the successor object to the list of 
      // uids and return 1, indicating success.
      pa_object.successor_object_uids.push_back( successor_object_uid );
      if ( successor_writer != null )
        pa_object.successor_writer = successor_writer;
`endif

    end
    `svt_debug( "add_object_successors", $sformatf( "Adding %0d successor objects to object '%0s'",
                                                                 count, object_uid ) );
    // Return 1, indicating success.
    return 1;
  end
endfunction

  // ****************************************************************************
  // Object Field Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  // Bit Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_bit( string object_uid,
                                                         string field_name,
                                                         bit    field_value,
                                                         bit    expected_field_value = 0,
                                                         bit    has_expected = 0 );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
    // Find the svt_vip_writer_object instance associated with the specified
    // object uid.  If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin 
`endif 
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = ( field_value == 0 ) ? "0" : "1";
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_bit", 
                           $sformatf( "Setting value of bit field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      //Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = ( expected_field_value == 0 ) ? "0" : "1";
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_bit", 
                              $sformatf( "Setting expected value of bit field '%0s' for object '%0s' to '%0s'",
                                         field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
    if ( this.file_format != xml ) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static bit st_field_value = 0; 
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        st_field_value = field_value;
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value ) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+expect", expected_field_value);
        end else
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name);
      end
    end
`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction

  //----------------------------------------------------------------------------
  // Bit-vector Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_bit_vector( string       object_uid,
                                                                string       field_name,
                                                                bit [1023:0] field_value,
                                                                int          numbits = 4096,
                                                                bit [1023:0] expected_field_value = 0,
                                                                bit          has_expected = 0 );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin 
`endif  
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = $sformatf( "0x%0h", field_value );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_bit_vector", 
                           $sformatf( "Setting value of bit-vector field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = $sformatf( "0x%0h", expected_field_value );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_bit_vector", 
                             $sformatf( "Setting expected value of bit-vector field '%0s' for object '%0s' to '%0s'",
                                        field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static string numbits_name = "";
        static bit [1023:0] st_field_value = 0;
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        $sformat(numbits_name,"+numbit+%0d",numbits);
        st_field_value = field_value;
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+expect", expected_field_value, numbits_name, "+radix+hex");
        end else
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, numbits_name, "+radix+hex");
      end
    end
`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction

  //----------------------------------------------------------------------------
  // Logic-vector Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_logic_vector( string         object_uid,
                                                                  string         field_name,
                                                                  logic [1023:0] field_value,
                                                                  int            numbits = 4096,
                                                                  logic [1023:0] expected_field_value = 0,
                                                                  bit            has_expected = 0 );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin   
`endif
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = $sformatf( "0x%0h", field_value );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_logic_vector", 
                           $sformatf( "Setting value of logic-vector field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = $sformatf( "0x%0h", expected_field_value );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_logic_vector", 
                             $sformatf( "Setting expected value of logic-vector field '%0s' for object '%0s' to '%0s'",
                                        field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static string numbits_name = "";
        static logic [1023:0] st_field_value = 0;
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        $sformat(numbits_name,"+numbit+%0d",numbits);
        st_field_value = field_value;
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+expect", expected_field_value, numbits_name, "+radix+hex");
        end else
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, numbits_name, "+radix+hex");
      end
    end
`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction

  //----------------------------------------------------------------------------
  // Integer Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_int( string  object_uid,
                                                         string  field_name,
                                                         longint field_value,
                                                         int     numbits = 32,
                                                         longint expected_field_value = 0,
                                                         bit     has_expected = 0 );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null ) 
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin
`endif   
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = $sformatf( "%0d", field_value );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_int", 
                           $sformatf( "Setting value of int field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = $sformatf( "%0d", expected_field_value );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_int", 
                               $sformatf( "Setting expected value of int field '%0s' for object '%0s' to '%0s'",
                                          field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        if (numbits == 16) begin // shortint 
          static shortint field_value_shortint = 0; 
          field_value_shortint = shortint'(field_value);
          // Only write out the expected value if it is present and it is different from the actual value.
          if ( has_expected && field_value != expected_field_value ) begin
            static shortint st_shortint_expected_field_value = 0; 
            st_shortint_expected_field_value = shortint'(expected_field_value);
            $fsdbTrans_add_attribute(st_transaction_id, field_value_shortint, attr_name, "+radix+dec", "+expect", st_shortint_expected_field_value);
          end else 
            $fsdbTrans_add_attribute(st_transaction_id, field_value_shortint, attr_name, "+radix+dec");
        end else if (numbits == 32) begin // integer
          static integer field_value_int = 0;
          field_value_int = int'(field_value);
          // Only write out the expected value if it is present and it is different from the actual value.   
          if ( has_expected && field_value != expected_field_value ) begin
            static integer st_int_expected_field_value = 0; 
            st_int_expected_field_value = int'(expected_field_value);
            $fsdbTrans_add_attribute(st_transaction_id, field_value_int, attr_name, "+radix+dec", "+expect", st_int_expected_field_value);
          end else
            $fsdbTrans_add_attribute(st_transaction_id, field_value_int, attr_name, "+radix+dec");
        end else begin
          static longint field_value_longint = 0; 
          field_value_longint = field_value;
          // Only write out the expected value if it is present and it is different from the actual value.  
          if ( has_expected && field_value != expected_field_value ) begin
            static longint st_longint_expected_field_value = 0; 
            st_longint_expected_field_value = expected_field_value;
            $fsdbTrans_add_attribute(st_transaction_id, field_value_longint, attr_name, "+radix+dec", "+expect", st_longint_expected_field_value);
          end else
            $fsdbTrans_add_attribute(st_transaction_id, field_value_longint, attr_name, "+radix+dec");
        end
      end 
    end 
`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction
                                                  
  //----------------------------------------------------------------------------
  // Real Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_real( string object_uid,
                                                          string field_name,
                                                          real   field_value,
                                                          real   expected_field_value = 0,
                                                          bit    has_expected = 0 );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin
`endif   
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = $sformatf( "%0.4f", field_value );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_real", 
                           $sformatf( "Setting value of real field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = $sformatf( "%0.4f", expected_field_value );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_real", 
                            $sformatf( "Setting expected value of real field '%0s' for object '%0s' to '%0s'",
                                       field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static real st_field_value = 0; 
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        st_field_value = field_value;
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+expect", expected_field_value);
        end else begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name);
        end
      end
    end
`endif
      
    // Return 1, indicating success.
    return 1;
  end
endfunction
                                                  
  //----------------------------------------------------------------------------
  // Time Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_time( string object_uid,
                                                          string field_name,
                                                          realtime   field_value,
                                                          realtime   expected_field_value = 0,
                                                          bit    has_expected = 0  );
  begin
    string field_value_str = "";
    string expected_field_value_str = "";
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin 
`endif  
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      field_value_str = $sformatf( "%0.4f", field_value );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_time", 
                            $sformatf( "Setting value of time field '%0s' for object '%0s' to '%0s'",
                                       field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        expected_field_value_str = $sformatf( "%0.4f", expected_field_value );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_time", 
                              $sformatf( "Setting expected value of bit-vector field '%0s' for object '%0s' to '%0s'",
                                         field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static realtime st_field_value = 0; 
        st_transaction_id = pa_object.transaction_id;
        st_field_value = field_value;
        $sformat(attr_name, "+name+%s", field_name);
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value ) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value,  attr_name, "+radix+dec", "+expect", expected_field_value);
        end else begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+radix+dec");
        end
      end
    end
`endif
      
    // Return 1, indicating success.
    return 1;
  end
endfunction
                                                  
  //----------------------------------------------------------------------------
  // String Field Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_object_field_value_string( string object_uid,
                                                            string field_name,
                                                            string field_value,
                                                            string expected_field_value = "",
                                                            bit    has_expected = 0 );
  begin
    string xml_field_value_str = "";
    string field_value_str = "";
    string expected_field_value_str = "";
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object pa_object = get_object_from_uid( object_uid );
      
    if ( pa_object == null )
      return 0;
`ifdef SVT_FSDB_ENABLE
    if ( this.file_format inside {xml, both} ) begin
`endif   
      // Format the field value as a string and set the value in the appropriate 
      // associative field array for the object.
      xml_field_value_str = create_xml_attribute_string( field_value );
      field_value_str = $sformatf( "%0s", xml_field_value_str );
      pa_object.field_values[ field_name ] = field_value_str;
      `svt_debug( "set_object_field_value_string", 
                           $sformatf( "Setting value of string field '%0s' for object '%0s' to '%0s'",
                                      field_name, object_uid, field_value_str ) );
      // Only write out the expected value if it is present and it is different from the actual value.
      if ( has_expected && field_value != expected_field_value ) begin
        // Format the field value as a string and set the value in the appropriate
        // associative field array for the object.
        xml_field_value_str = create_xml_attribute_string( expected_field_value );
        expected_field_value_str = $sformatf( "%0s", xml_field_value_str );
        pa_object.field_expected_values[ field_name ] = expected_field_value_str;
        `svt_debug( "set_object_field_value_string", 
                             $sformatf( "Setting expected value of string field '%0s' for object '%0s' to '%0s'",
                                        field_name, object_uid, expected_field_value_str ) );
      end // if (has_expected)
`ifdef SVT_FSDB_ENABLE
    end  // if (this.file_format)
       
    if (this.file_format != xml) begin
      if (pa_object.transaction_id != 0) begin
        static longint unsigned  st_transaction_id = 0;
        static string attr_name = "";
        static string st_field_value = ""; 
        st_transaction_id = pa_object.transaction_id;
        $sformat(attr_name, "+name+%s", field_name);
        st_field_value = field_value;
        // Only write out the expected value if it is present and it is different from the actual value.
        if ( has_expected && field_value != expected_field_value ) begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name, "+expect", expected_field_value);
        end else begin
          $fsdbTrans_add_attribute(st_transaction_id, st_field_value, attr_name);
        end
      end
    end
`endif
      
    // Return 1, indicating success.
    return 1;
  end
endfunction

  //----------------------------------------------------------------------------
  // Tag Methods
  //----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
function bit svt_vip_writer::add_object_tag( string object_uid,
                                             string tag_name );
  begin
    // This method does nothing for XML output.
    
`ifdef SVT_FSDB_ENABLE
    if (this.file_format != xml)
      begin
        // Find the svt_vip_writer_object instance associated with the specified
        // object uid.  If no such object is found, return 0, indicating failure.
        svt_vip_writer_object pa_object = get_object_from_uid( object_uid );

        if ( pa_object == null )
          return 0;

        if ( pa_object.transaction_id == 0 )
          return 0;
        else
          begin
            static longint unsigned  st_transaction_id = 0;
            static string st_tag_name = ""; 
            st_transaction_id = pa_object.transaction_id;
            st_tag_name = tag_name;

            $fsdbTrans_add_tag( st_transaction_id, st_tag_name );
          end
      end
`endif
      
    // Return 1, indicating success.
    return 1;
  end
endfunction

  // ****************************************************************************
  // Local Methods
  // ****************************************************************************

// ----------------------------------------------------------------------------
function svt_vip_writer_object svt_vip_writer::get_object_from_uid( string object_uid, 
                                                                    bit    check_begin_time = 1,
                                                                    bit    find_all = 0 );
  begin
    svt_vip_writer_object pa_object = null;
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // no such object is found, report an error.
    if ( unended_objects.exists( object_uid ) )
      pa_object = unended_objects[ object_uid ];
      
`ifdef SVT_FSDB_ENABLE
    if ( pa_object == null && find_all && ended_objects.exists(object_uid) )
      pa_object = ended_objects[ object_uid ];
    // This should be a relation call for FSDB, where forward referncing for relation will not work. 
    if ( pa_object == null && relation_uids.exists(object_uid) )
      return null;
`endif

    if ( pa_object == null ) begin
      `svt_error("get_object_from_uid", $sformatf("Unable to find an unended object with uid '%s'", object_uid));
      return null; 
    end  
       
    // Check the value of the begin time of the object, if requested.
    if ( check_begin_time == 1 ) begin
      // If the begin time is -1, report an error and set the value of the
      // object handle to null.
      if ( pa_object.begin_time < 0 && !pa_object.begin_block_save ) begin
        `svt_error( "get_object_from_uid", 
                                   $sformatf( "The object with uid '%0s' has not yet begun", object_uid ) );
        pa_object = null;
      end
    end
      
    // Return the instance of svt_vip_writer_object (which may be null).
    return pa_object;
  end
endfunction

// ----------------------------------------------------------------------------
function string svt_vip_writer::create_xml_attribute_string( string original_string );
  begin
    int len = original_string.len();
    string xml_attribute_string = "";
    for (int i = 0; i < len; i++) begin
      string c = original_string.substr( i, i );

      // Translate the required characters.  Technically, ">" shouldn't need
      // to be translated, but from past experience, it can confuse some of
      // the "standard" parsers.
      // 
      // quote        (") -> &quot;
      // ampersand    (&) -> &amp;
      // less than    (<) -> &lt;
      // greater than (>) -> &gt;

      if ( c == "\"" )
        xml_attribute_string = { xml_attribute_string, "&quot;" };
      else if ( c == "&" )
        xml_attribute_string = { xml_attribute_string, "&amp;" };
      else if ( c == "<" )
        xml_attribute_string = { xml_attribute_string, "&lt;" };
      else if ( c == ">" )
        xml_attribute_string = { xml_attribute_string, "&gt;" };
      else
        xml_attribute_string = { xml_attribute_string, c };
    end
      
    return xml_attribute_string;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::local_object_end( svt_vip_writer_object pa_object,
                                               string object_uid,
                                               bit    set_end_time = 1 );
  begin
    int status = 0;
      
    // If an instance of svt_vip_writer_object was provided, use it.  Otherwise, find
    // the svt_vip_writer_object instance associated with the specified object uid.  If 
    // no such object is found, return 0, indicating failure.
    if ( pa_object == null ) begin
      pa_object = get_object_from_uid( object_uid );
      if ( pa_object == null )
        return 0;
      end else   
        object_uid = pa_object.object_uid;
      `svt_debug( "local_object_end", $sformatf( "Ending object '%0s'", object_uid ) );
      // If requested, update the end time to the current simulation time.
      if ( set_end_time == 1 && pa_object.end_time == -1) begin
        pa_object.end_time = $realtime;
        `svt_debug( "local_object_end", 
                               $sformatf( "Updating end time for object '%0s' to '%0.4f'", 
                                          object_uid, pa_object.end_time ) );
      end
      
    // Write the data associated with the object.  If the operation fails,
    // return 0, indicating failure.
    status = write_object( pa_object );

    if ( status == 0 )
      return 0;

    // Remove the object from the list of unended objects.
    if ( unended_objects.exists( object_uid ) == 0 ) begin
      `svt_warning( "local_object_end", 
                                $sformatf( "Unable to find object '%0s' in unended objects queue", object_uid ) );
    end else begin 
      `svt_debug( "local_object_end", 
                              $sformatf( "Removing object '%0s' from unended objects queue", object_uid ) );
      unended_objects.delete( object_uid );
          
`ifdef SVT_FSDB_ENABLE
      ended_objects[object_uid] = pa_object;
`endif
      end
      
    // Return 1, indicating success.
    return 1;
  end
endfunction

//------------------------------------------------------------------------------
function int svt_vip_writer::get_file_handle(); 
  begin

`ifdef SVT_FSDB_ENABLE
    if (this.file_format inside { fsdb, fsdb_perf_analysis })
      return 1;
`endif
    get_file_handle = file_handle;
  end
endfunction

//------------------------------------------------------------------------------
function void svt_vip_writer::record_vip_info(string vip_name, string if_path);
`ifdef SVT_FSDB_ENABLE
  void'(add_scope_attribute(if_path, "snps_if_path"));
`endif
endfunction

//-------------------------------------------------------------------------------
function bit svt_vip_writer::set_file_dump_format(int format_type);
  begin
    // By default the file_format will be FSDB.

`ifdef SVT_FSDB_ENABLE
    if (format_type == `SVT_WRITER_FORMAT_FSDB)
      this.file_format = fsdb;
    else if (format_type == `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS)
      this.file_format = fsdb_perf_analysis;
    else if (format_type == `SVT_WRITER_FORMAT_XML_N_FSDB)
      this.file_format = both;
    else if (format_type == `SVT_WRITER_FORMAT_XML)
      this.file_format = xml;
    else
      return 0;
`endif
    return 1; // Retrun success after setting the file format
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::write_object( svt_vip_writer_object pa_object );
  begin
    string object_uid                       = pa_object.object_uid;
    string object_type                      = pa_object.object_type;
    realtime   object_begin_time            = pa_object.begin_time;
    realtime   object_end_time              = pa_object.end_time;
    string parent_object_uid                = pa_object.parent_object_uid;
    string predecessor_object_uid           = pa_object.predecessor_object_uid;
    string object_channel                   = pa_object.channel;
    string object_status                    = pa_object.status;
    string object_block_desc                = pa_object.object_block_desc;     
    int    child_object_count               = pa_object.child_object_uids.size();
    int    successor_object_count           = pa_object.successor_object_uids.size();
    int    field_value_count                = pa_object.field_values.num();
    int    field_expected_value_count       = pa_object.field_expected_values.num();
    int    pa_object_ref_count              = pa_object_refs.size();
    svt_vip_writer successor_writer         = pa_object.successor_writer;
    svt_vip_writer predecessor_writer       = pa_object.predecessor_writer;

`ifdef SVT_FSDB_ENABLE
    if (this.file_format inside {xml, both}) begin
`endif 
    // If the begin block already written to XML don't write out.
    // This condition only valid for backward compatibility.
    if (pa_object.begin_block_save) begin
      $fwrite( file_handle, $sformatf( "  <object %0s", object_block_desc) );
    end else begin
      `svt_debug( "write_object", $sformatf( "Writing object '%0s'", object_uid ) );
      // Write out the start of the object tag.
      $fwrite( file_handle, $sformatf( "  <object type=\"%0s\" uid=\"%0s\"", object_type, object_uid ) );
      $fwrite( file_handle, $sformatf( " start_time=\"%0t\"", object_begin_time ) );

      if ( object_end_time < 0 )
        $fwrite( file_handle, $sformatf( " end_time=\"%0t\"", $realtime ) );
      else
        $fwrite( file_handle, $sformatf( " end_time=\"%0t\"", object_end_time ) );

      // Write out the parent object uid, if specified.
      if ( parent_object_uid != "" )
        $fwrite( file_handle, $sformatf( " parent_uid=\"%0s\"", parent_object_uid ) );

      // Write out the channel, if specified.
      if ( object_channel != "" )
        $fwrite( file_handle, $sformatf( " channel=\"%0s\"", object_channel ) );

      // Write out the object status if exists
      if (object_status != "" )
        $fwrite(file_handle, $sformatf(" status=\"%s\"", object_status ) );   
    end
    
    // Finish writing out the start of the object tag.
    if ( ( child_object_count == 0 ) && ( field_value_count == 0 ) &&
        ( predecessor_object_uid == "" ) && ( successor_object_count == 0 ) ) begin
      $fwrite( file_handle, " />\n" );
    end else begin 
      $fwrite( file_handle, ">\n" );
      // Write out the predecessor object, if specified.
      if ( predecessor_object_uid.len() !=0 ) begin
        `svt_debug( "write_object", "Writing predecessor object instance/uid" );

        $fwrite( file_handle, "    <precedent_object>\n" );
        $fwrite( file_handle, "      <object_ref uid=\"%0s\" />\n", 
         predecessor_object_uid );
        $fwrite( file_handle, "    </precedent_object>\n" );
      end

      // Write out the successor objects.
      if ( successor_object_count > 0 ) begin
        `svt_debug( "write_object", $sformatf( "Writing %0d successor object uids", 
                                                           successor_object_count ) );

        $fwrite( file_handle, "    <consequent_objects>\n" );
      
        for ( int i = 0; i < successor_object_count; i++ ) begin
          // If both XML and FSDB is enabled for validation then the instance name may be empty
          string successor_object_uid = pa_object.successor_object_uids[ i ];

          $fwrite( file_handle, "      <object_ref uid=\"%0s\" />\n", 
                      successor_object_uid );
        end

        $fwrite( file_handle, "    </consequent_objects>\n" );
      end

      // Write out the field values.
      if ( field_value_count > 0 ) begin
        string field_name;
        string field_value;
        string field_expected_value;
        `svt_debug( "write_object", $sformatf( "Writing %0d field values", field_value_count ) );
            
        // Check if there are field values for all fields with specified expected values.
      
        $fwrite( file_handle, "    <field_values>\n" );
              
        // Iterate through the field values.
        void'(pa_object.field_values.first( field_name ));
        do begin
          // Get the field value.
          field_value = pa_object.field_values[ field_name ];
                  
          // Check if there is an expected field value.
          if ( pa_object.field_expected_values.exists( field_name ) ) begin
            field_expected_value = pa_object.field_expected_values[ field_name ];
            $fwrite( file_handle, "      <field name=\"%0s\" value=\"%0s\" expected=\"%0s\" />\n", 
                            field_name, field_value, field_expected_value );
          end else begin
            $fwrite( file_handle, "      <field name=\"%0s\" value=\"%0s\" />\n", field_name, field_value );
          end
        end while ( pa_object.field_values.next( field_name ) );

          $fwrite( file_handle, "    </field_values>\n" );
        end
        // Write out the child objects.
        if ( child_object_count > 0 ) begin
          `svt_debug( "write_object", $sformatf( "Writing %0d child object uids", child_object_count ) );

          $fwrite( file_handle, "    <child_objects>\n" );
      
          for ( int i = 0; i < child_object_count; i++ ) begin
            string child_object_uid = pa_object.child_object_uids[ i ];
            $fwrite( file_handle, $sformatf( "      <object_ref uid=\"%0s\"/>\n", child_object_uid ) );
          end
          for ( int i = 0; i < pa_object_ref_count; i++) begin
            string child_object_uid = pa_object_refs.pop_front();
            $fwrite( file_handle, $sformatf( "      <object_ref uid=\"%0s\"/>\n", child_object_uid ) );
          end 
          $fwrite( file_handle, "    </child_objects>\n" );
        end

        // Write out the end of the object tag.
        $fwrite( file_handle, "  </object>\n" );
      end

`ifdef SVT_FSDB_ENABLE
    end // if (this.file_format)

    if (this.file_format != xml && pa_object.transaction_id != 0) begin
      static longint unsigned  st_transaction_id = 0;
      // VERDI: add relations and end transaction
      // Write out the predecessor-sucessor relations, if specified.
      if ( predecessor_object_uid.len() > 0 ) begin
        svt_vip_writer_object predecessor_pa_object = null;
        if ( predecessor_writer != null )
          predecessor_pa_object = predecessor_writer.get_object_from_uid( predecessor_object_uid, 0, 1 );
        else
          predecessor_pa_object = get_object_from_uid( predecessor_object_uid, 0, 1 );
        if (predecessor_pa_object != null && predecessor_pa_object.transaction_id != 0)
          $fsdbTrans_add_relation("succ_pred", predecessor_pa_object.transaction_id, pa_object.transaction_id);
      end
        
      if ( successor_object_count > 0 ) begin
        for( int i = 0; i < successor_object_count; i++ ) begin
          string successor_object_uid = pa_object.successor_object_uids[ i ];
          // VERDI : call $fsdbTrans_add_relation("succ_pred",...)
          svt_vip_writer_object successor_pa_object = null;
          if ( successor_writer != null )
            successor_pa_object = successor_writer.get_object_from_uid(successor_object_uid, 0, 1);
          else
            successor_pa_object = get_object_from_uid(successor_object_uid, 0, 1);
          if (successor_pa_object != null && successor_pa_object.transaction_id != 0)
            $fsdbTrans_add_relation("succ_pred", pa_object.transaction_id, successor_pa_object.transaction_id);
        end
      end // if ( successor_object_count > 0 )

      // Write out the parent-child relations, if specified.
      if ( parent_object_uid != "" ) begin
        svt_vip_writer_object parent_pa_object = null;
        parent_pa_object = get_object_from_uid( parent_object_uid, 0, 1 );
        if (parent_pa_object != null && parent_pa_object.transaction_id != 0)
          $fsdbTrans_add_relation("parent_child", parent_pa_object.transaction_id, pa_object.transaction_id);
      end

      if ( child_object_count > 0 ) begin
        for( int i = 0; i < child_object_count; i++ ) begin
          string child_object_uid = pa_object.child_object_uids[ i ];
          // VERDI : call $fsdbTrans_add_relation("parent_child",...)
          svt_vip_writer_object child_pa_object = null;
          child_pa_object = get_object_from_uid(child_object_uid, 0, 1 );
          if (child_pa_object != null && child_pa_object.transaction_id != 0)
            $fsdbTrans_add_relation("parent_child", pa_object.transaction_id, child_pa_object.transaction_id);
        end
      end // if ( child_object_count > 0 )

      // End transaction
      st_transaction_id = pa_object.transaction_id;
      $fsdbTrans_end(st_transaction_id);
    end // if (this.file_format != xml && pa_object.transaction_id != 0)

`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction

`ifdef SVT_FSDB_ENABLE

  // ****************************************************************************
  // Local Methods for FSDB dump
  // ****************************************************************************

// ----------------------------------------------------------------------------
function string svt_vip_writer::get_legal_fsdb_name(string name);
  begin
    string res_name = name;
    int len = res_name.len();
    for (int i = 0; i < len; i++) begin
      if (res_name[i] == "." || res_name[i] == "/" || res_name[i] == " ") begin
        if (res_name[i] == " ")
          `svt_warning( "get_legal_fsdb_name", "Naming issue, the name contains space" );
        res_name[i] = "_";
      end
    end
    return res_name;
  end
endfunction

//-----------------------------------------------------------------------------------
function longint unsigned svt_vip_writer::get_stream_id_by_type(string object_type, string object_channel, string attr_name[$] = '{}, string attr_val[$] = '{});
  begin
    longint unsigned stream_id = 0;
    string stream_full_name = object_type;
    static string st_stream_full_name = "";
    //For later use with scope attribute 
    string combined_protocol_name = "";

    if (this.fsdb_stream_parent == "")
      return stream_id;

    //To be used later for creating stream based on both object_type and channel 
    if (object_channel != "")
      stream_full_name = {this.fsdb_stream_parent, ".", object_type, ".", object_channel};
    else
      stream_full_name = {this.fsdb_stream_parent, ".", object_type};

    if (stream_id_array.exists(stream_full_name)) begin
      stream_id = stream_id_array[stream_full_name];
      return stream_id;
    end
     
    //create new stream
    st_stream_full_name = stream_full_name;

    if (this.fsdb_file == "")
      stream_id = $fsdbTrans_create_stream_begin(st_stream_full_name);
    else begin
      static string stream_file_name = "";
      $sformat(stream_file_name, "+fsdbfile+%s", this.fsdb_file);
      stream_id = $fsdbTrans_create_stream_begin(st_stream_full_name, stream_file_name);
    end
      
    if (object_channel != "") begin
      static string st_stream_attr_value = "";
      st_stream_attr_value = {"%", object_channel, "%"};
      $fsdbTrans_add_stream_attribute(stream_id, st_stream_attr_value, "+name+channel"); 
    end
    // Check any stream attributes are stored, if yes write out into the current stream
    foreach(stream_attribute_names[i]) begin
`ifdef INCA
      // On Incisive accessing the string queue directly results in an 'argument is invalid' message.
      // So we put 'attr_val[i]' into a local 'attr_val_i' variable to avoid the error.
      string attr_val_i = stream_attribute_values[i];
      $fsdbTrans_add_stream_attribute(stream_id, attr_val_i, {"+name+", stream_attribute_names[i]});
`else
`ifdef QUESTA
      // On questa accessing the concatenated string directly results in an 'argument is invalid' message.
      // Fixing this the access to the string queue directly results in an 'invalid attribute value' message.
      // So we put '{"+name+", attr_name[i]}' into a local 'name_plus_attr_name_i' variable to avoid one error,
      // and we put 'attr_val[i]' into a local 'attr_val_i' variable to avoid the other error.
      string name_plus_attr_name_i = {"+name+", stream_attribute_names[i]};
      string attr_val_i = stream_attribute_values[i];
      $fsdbTrans_add_stream_attribute(stream_id, attr_val_i, name_plus_attr_name_i);
`else
      $fsdbTrans_add_stream_attribute(stream_id, stream_attribute_values[i], {"+name+", stream_attribute_names[i]});
`endif
`endif
    end
    // Delete the queue after written out
    stream_attribute_names.delete();
    stream_attribute_values.delete();
    
    foreach(attr_name[i]) begin
`ifdef INCA
      // On Incisive accessing the string queue directly results in an 'argument is invalid' message.
      // So we put 'attr_val[i]' into a local 'attr_val_i' variable to avoid the error.
      string attr_val_i = attr_val[i];
      $fsdbTrans_add_stream_attribute(stream_id, attr_val_i, {"+name+", attr_name[i]});
`else
`ifdef QUESTA
      // On questa accessing the concatenated string directly results in an 'argument is invalid' message.
      // Fixing this the access to the string queue directly results in an 'invalid attribute value' message.
      // So we put '{"+name+", attr_name[i]}' into a local 'name_plus_attr_name_i' variable to avoid one error,
      // and we put 'attr_val[i]' into a local 'attr_val_i' variable to avoid the other error.
      string name_plus_attr_name_i = {"+name+", attr_name[i]};
      string attr_val_i = attr_val[i];
      $fsdbTrans_add_stream_attribute(stream_id, attr_val_i, name_plus_attr_name_i);
`else
      $fsdbTrans_add_stream_attribute(stream_id, attr_val[i], {"+name+", attr_name[i]});
`endif
`endif
    end

    combined_protocol_name = this.scope_full_path;
          
    if (combined_protocol_name != "" && !protocol_name_array.exists(combined_protocol_name)) begin
      top_level_scope = this.fsdb_stream_parent;
      void'(add_scope_attribute(this.protocol_version, "snps_vip_version"));
      void'(add_scope_attribute(combined_protocol_name, "snps_protocol_name"));
      protocol_name_array[combined_protocol_name] = 1;
    end
         
    stream_id_array[stream_full_name] = stream_id;
    if ( stream_id != 0 ) begin
      $fsdbTrans_create_stream_end(stream_id);
    end

    return stream_id;
  end
endfunction

`endif

//-----------------------------------------------------------------------------------
function bit svt_vip_writer::add_scope_attribute(string attr_name, string attr_value, string scope_name = "");
  // Use static variables for improved performance with the Verdi calls
  static string _scope_name;
  static string _attr_name;
  static string _attr_value;
  // Assume success
  add_scope_attribute = 1;

`ifdef SVT_FSDB_ENABLE
  if ( scope_name == "" )
    _scope_name = this.fsdb_stream_parent;
  else begin
    _scope_name = { this.fsdb_stream_parent, ".", scope_name };
  end 
`endif

  _attr_name = attr_name;
  _attr_value = {"+name+",attr_value};
  if (_scope_name == "") begin
`ifdef VIP_INTERNAL_BUILD
`ifdef VCS
    $stack;
`endif
    `svt_error("add_scope_attribute", $sformatf("fsdb_stream_parent not set so unable to write '%0s' value of '%0s' to fsdb.", _attr_name, _attr_value));
`else
    `svt_debug("add_scope_attribute", $sformatf("fsdb_stream_parent not set so unable to write '%0s' value of '%0s' to fsdb.", _attr_name, _attr_value));
`endif
    add_scope_attribute = 0;

`ifdef SVT_FSDB_ENABLE
  end else if (this.fsdb_file == "") begin
    $fsdbTrans_add_scope_attribute(_scope_name, _attr_name, _attr_value);
    add_scope_attribute = 1;
  end else begin
    static string stream_file_name = "";
    $sformat(stream_file_name, "+fsdbfile+%s", this.fsdb_file);
    $fsdbTrans_add_scope_attribute(_scope_name, _attr_name, _attr_value, stream_file_name);
    add_scope_attribute = 1;
`endif

  end
endfunction

//-----------------------------------------------------------------------------------
function bit svt_vip_writer::add_stream_attribute(string attr_name, string attr_value);
  add_stream_attribute = 1;

`ifdef SVT_FSDB_ENABLE
  stream_attribute_names.push_back(attr_name);
  stream_attribute_values.push_back(attr_value);
`endif

endfunction


//-----------------------------------------------------------------------------------
function int svt_vip_writer::get_format_type();
`ifdef SVT_FSDB_ENABLE
  case (this.file_format)
    fsdb : get_format_type = `SVT_WRITER_FORMAT_FSDB;
    fsdb_perf_analysis : get_format_type = `SVT_WRITER_FORMAT_FSDB_PERF_ANALYSIS;
    xml : get_format_type = `SVT_WRITER_FORMAT_XML;
    both : get_format_type = `SVT_WRITER_FORMAT_XML_N_FSDB;
    default : get_format_type = `SVT_WRITER_FORMAT_FSDB;
  endcase
`else
  get_format_type = `SVT_WRITER_FORMAT_XML;
`endif
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_identical_relation( string source_object_uid,
                                                      string target_object_uid, 
                                                      svt_vip_writer target_writer = null );
  begin
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object source_pa_object = get_object_from_uid( source_object_uid, 0, 1 );
    if ( source_pa_object == null ) begin
      `svt_error( "set_identical_relation", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                          source_object_uid ) );
      return 0;
    end
 
`ifdef SVT_FSDB_ENABLE
    begin
      svt_vip_writer_object target_pa_object = null;

      if ( target_writer == null )
        target_pa_object = get_object_from_uid( target_object_uid, 0, 1 );
      else
        target_pa_object = target_writer.get_object_from_uid( target_object_uid, 0, 1 );

      if ( target_pa_object == null )
        begin
          `svt_error( "set_identical_relation", 
                       $sformatf( "Unable to find an object with uid '%0s'", target_object_uid ) );
          return 0;
        end
      else
        begin
          $fsdbTrans_add_relation( "identical", source_pa_object.transaction_id, target_pa_object.transaction_id );
        end
    end
     `svt_debug( "set_identical_relation", $sformatf( "Setting object '%0s' as an identical of object '%0s'",
                                                                target_object_uid, source_object_uid ) );
`endif
    return 1;
  end
endfunction

// ----------------------------------------------------------------------------
function bit svt_vip_writer::set_identical_relations( string source_object_uid,
                                                      string target_object_uids[],
                                                      svt_vip_writer target_writer = null );
  begin
    int count = 0;
      
    // Find the svt_vip_writer_object instance associated with the specified object uid.
    // If no such object is found, return 0, indicating failure.
    svt_vip_writer_object source_pa_object = get_object_from_uid( source_object_uid, 0, 1 );
    if ( source_pa_object == null ) begin
      `svt_error( "set_identical_relations", 
                               $sformatf( "Unable to find an object with uid '%0s'", 
                                          source_object_uid ) );
      return 0;
    end
   
`ifdef SVT_FSDB_ENABLE
    begin
      svt_vip_writer_object target_pa_object = null;
      count = target_object_uids.size();
      for ( int i = 0; i < count; i++ ) begin
        string target_object_uid = target_object_uids[ i ];
        if ( target_writer == null )
          target_pa_object = get_object_from_uid( target_object_uid, 0, 1 );
        else
          target_pa_object = target_writer.get_object_from_uid( target_object_uid, 0, 1 );

        if ( target_pa_object == null )
          begin
            `svt_error( "set_identical_relations", 
                       $sformatf( "Unable to find an object with uid '%0s'", target_object_uid ) );
            return 0;
          end
        else
          begin
            $fsdbTrans_add_relation( "identical", source_pa_object.transaction_id, target_pa_object.transaction_id );
          end
      end
    end
      `svt_debug( "set_identical_relations", $sformatf( "Setting %0d identical relation to object '%0s'",
                                                                 count, source_object_uid ) );
`endif

    // Return 1, indicating success.
    return 1;
  end
endfunction

// =============================================================================

`endif // GUARD_SVT_VIP_WRITER_SV


