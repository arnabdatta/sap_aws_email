*&---------------------------------------------------------------------*
*& Report ZAWS_BATCH_EMAIL
*&---------------------------------------------------------------------*
*& Send email with chosen laguage after batch job status changes
*&---------------------------------------------------------------------*
REPORT zaws_batch_email.

INCLUDE zaws_batch_email_top.

INCLUDE zaws_batch_email_sel.

INCLUDE zaws_batch_email_f01.

DATA lo_aws TYPE REF TO lcl_aws.

* Get the list of batch jobs

START-OF-SELECTION.

  IF p_job IS NOT INITIAL.
    SELECT * FROM tbtco INTO TABLE @DATA(lt_jobs) WHERE jobname EQ @p_job.
  ELSEIF p_date IS NOT INITIAL.
    SELECT * FROM tbtco INTO TABLE @lt_jobs WHERE strtdate EQ @p_date.
  ELSE.
    MESSAGE 'Enter either date or Job name' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
* Check the status of the job

  IF lt_jobs IS INITIAL.
    MESSAGE 'No Job found' TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  lo_aws = NEW #( ).

  lo_aws->connect_aws( ).

* Send the message
  lo_aws->send_sns_email( ).

* end
