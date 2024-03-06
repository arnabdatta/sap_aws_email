*&---------------------------------------------------------------------*
*& Include          ZAWS_BATCH_EMAIL_F01
*&---------------------------------------------------------------------*

CLASS lcl_aws IMPLEMENTATION.
  METHOD connect_aws.
    TRY.
        me->go_session =  /aws1/cl_rt_session_aws=>create( me->gc_pfl ).

      CATCH /aws1/cx_rt_generic INTO DATA(lo_exc).

    ENDTRY.

  ENDMETHOD.

  METHOD send_sns_email.
    IF me->go_session IS BOUND.
      TRY.
          DATA(lo_sns) = /aws1/cl_sns_factory=>create( me->go_session ).

*     send email

        CATCH /aws1/cx_rt_generic INTO DATA(lo_exc).

      ENDTRY.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
