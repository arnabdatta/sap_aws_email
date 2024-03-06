*&---------------------------------------------------------------------*
*& Include          ZAWS_BATCH_EMAIL_TOP
*&---------------------------------------------------------------------*



CLASS lcl_aws DEFINITION.

  PUBLIC SECTION.

    CONSTANTS: gc_pfl TYPE /aws1/rt_profile_id VALUE 'ZAWS'.

    DATA: go_result  TYPE REF TO /aws1/cl_snslisttopicsresponse,
          go_session TYPE REF TO /aws1/cl_rt_session_base.

    METHODS connect_aws.

    METHODS send_sns_email.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.
