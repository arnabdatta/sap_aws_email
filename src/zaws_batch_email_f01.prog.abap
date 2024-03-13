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

          DATA(oo_result) = lo_sns->listtopics( ).            " oo_result is returned for testing purposes. "
          DATA(lt_topics) = oo_result->get_topics( ).

          lo_sns->subscribe(                      "oo_result is returned for testing purposes."
                   iv_topicarn = lt_topics[ 1 ]->get_topicarn( )
                   iv_protocol = 'email'
                   iv_endpoint = 'kicidij389@irnini.com'
                   iv_returnsubscriptionarn = abap_true
                 ).

*       send email
          lo_sns->publish(
          EXPORTING
            iv_topicarn               = lt_topics[ 1 ]->get_topicarn( )
*            iv_targetarn              =
*            iv_phonenumber            =
            iv_message                = 'Email from SAP: Batch job failed'
*            iv_subject                =
*            iv_messagestructure       =
*            it_messageattributes      =
*            iv_messagededuplicationid =
*            iv_messagegroupid         =
*          RECEIVING
*            oo_output                 =
          ).

        CATCH /aws1/cx_snsnotfoundexception.
          MESSAGE 'Topic does not exist.' TYPE 'E'.
        CATCH /aws1/cx_snssubscriptionlmte00.
          MESSAGE 'Unable to create subscriptions. You have reached the maximum number of subscriptions allowed.' TYPE 'E'.

        CATCH /aws1/cx_rt_generic INTO DATA(lo_exc).

      ENDTRY.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
