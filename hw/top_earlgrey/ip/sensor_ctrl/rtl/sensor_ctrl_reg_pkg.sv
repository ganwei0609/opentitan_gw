// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package sensor_ctrl_reg_pkg;

  // Param list
  parameter int NumAlerts = 7;
  parameter int NumIoRails = 2;
  parameter int AsSel = 0;
  parameter int CgSel = 1;
  parameter int GdSel = 2;
  parameter int TsHiSel = 3;
  parameter int TsLoSel = 4;
  parameter int LsSel = 5;
  parameter int OtSel = 6;

  // Address width within the block
  parameter int BlockAw = 5;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////
  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } as;
    struct packed {
      logic        q;
      logic        qe;
    } cg;
    struct packed {
      logic        q;
      logic        qe;
    } gd;
    struct packed {
      logic        q;
      logic        qe;
    } ts_hi;
    struct packed {
      logic        q;
      logic        qe;
    } ts_lo;
    struct packed {
      logic        q;
      logic        qe;
    } ls;
    struct packed {
      logic        q;
      logic        qe;
    } ot;
  } sensor_ctrl_reg2hw_alert_test_reg_t;

  typedef struct packed {
    logic        q;
  } sensor_ctrl_reg2hw_ack_mode_mreg_t;

  typedef struct packed {
    logic        q;
  } sensor_ctrl_reg2hw_alert_trig_mreg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } sensor_ctrl_reg2hw_alert_state_mreg_t;


  typedef struct packed {
    logic        d;
    logic        de;
  } sensor_ctrl_hw2reg_alert_state_mreg_t;

  typedef struct packed {
    logic [1:0]  d;
    logic        de;
  } sensor_ctrl_hw2reg_status_reg_t;


  ///////////////////////////////////////
  // Register to internal design logic //
  ///////////////////////////////////////
  typedef struct packed {
    sensor_ctrl_reg2hw_alert_test_reg_t alert_test; // [41:28]
    sensor_ctrl_reg2hw_ack_mode_mreg_t [6:0] ack_mode; // [27:21]
    sensor_ctrl_reg2hw_alert_trig_mreg_t [6:0] alert_trig; // [20:14]
    sensor_ctrl_reg2hw_alert_state_mreg_t [6:0] alert_state; // [13:0]
  } sensor_ctrl_reg2hw_t;

  ///////////////////////////////////////
  // Internal design logic to register //
  ///////////////////////////////////////
  typedef struct packed {
    sensor_ctrl_hw2reg_alert_state_mreg_t [6:0] alert_state; // [16:3]
    sensor_ctrl_hw2reg_status_reg_t status; // [2:0]
  } sensor_ctrl_hw2reg_t;

  // Register Address
  parameter logic [BlockAw-1:0] SENSOR_CTRL_ALERT_TEST_OFFSET = 5'h 0;
  parameter logic [BlockAw-1:0] SENSOR_CTRL_CFG_REGWEN_OFFSET = 5'h 4;
  parameter logic [BlockAw-1:0] SENSOR_CTRL_ACK_MODE_OFFSET = 5'h 8;
  parameter logic [BlockAw-1:0] SENSOR_CTRL_ALERT_TRIG_OFFSET = 5'h c;
  parameter logic [BlockAw-1:0] SENSOR_CTRL_ALERT_STATE_OFFSET = 5'h 10;
  parameter logic [BlockAw-1:0] SENSOR_CTRL_STATUS_OFFSET = 5'h 14;


  // Register Index
  typedef enum int {
    SENSOR_CTRL_ALERT_TEST,
    SENSOR_CTRL_CFG_REGWEN,
    SENSOR_CTRL_ACK_MODE,
    SENSOR_CTRL_ALERT_TRIG,
    SENSOR_CTRL_ALERT_STATE,
    SENSOR_CTRL_STATUS
  } sensor_ctrl_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] SENSOR_CTRL_PERMIT [6] = '{
    4'b 0001, // index[0] SENSOR_CTRL_ALERT_TEST
    4'b 0001, // index[1] SENSOR_CTRL_CFG_REGWEN
    4'b 0001, // index[2] SENSOR_CTRL_ACK_MODE
    4'b 0001, // index[3] SENSOR_CTRL_ALERT_TRIG
    4'b 0001, // index[4] SENSOR_CTRL_ALERT_STATE
    4'b 0001  // index[5] SENSOR_CTRL_STATUS
  };
endpackage

