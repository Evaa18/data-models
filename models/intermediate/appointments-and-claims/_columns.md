
{% docs appointment_or_claim_id %}
Either the unique ID of the appointment, or the pending claim.
{% enddocs %}

{% docs appointment_or_claim_created_on_platform_at %}
Timestamp of the creation of either the appointment of the pending claim on the platform.
{% enddocs %}

{% docs appointment_or_claim_updated_at %}
Timestamp of the update of either information about the appointment of the pending claim on the platform.
{% enddocs %}

{% docs appointment_or_claim %}
Indicates if the row is about an appointment or a pending claim.
{% enddocs %}

{% docs appointment_or_claim_general_status %}
Summary of the status of the appointment gathered from the feedbacks of both the ambassador and the seeker. If it is a pending claim, it takes the value upcoming_or_pending_review.
{% enddocs %}

{% docs appointment_or_claim_seeker_feedback_type %}
Type of feedback given by the seeker. If it is a pending claim, it takes the value upcoming_or_pending_review.
{% enddocs %}

{% docs appointment_or_claim_ambassador_feedback_type %}
Type of feedback given by the ambassador. If it is a pending claim, it takes the value upcoming_or_pending_review.
{% enddocs %}

{% docs appointment_or_claim_is_nuida %}
Boolean taking the value true if the appointment or claim qualifies as NUIDA (not unbooked, invalidated, or denined by anyone), false otherwise.
{% enddocs %}