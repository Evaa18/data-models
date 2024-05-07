{% docs user_id %}
Unique user ID of the account owner.
{% enddocs %}

{% docs intercom_user_id %}
Unique user ID from Intercom.
{% enddocs %}

{% docs france_travail_id %}
Unique user ID from France Travail Connect.
{% enddocs %}

{% docs desired_meeting_address_id %}
ID of the preferred place to meet ambassadors.
{% enddocs %}

{% docs widget_source_id %}
ID of the widget where the user comes from.
{% enddocs %}

{% docs user_created_at %}
Timestamp of the account creation.
{% enddocs %}

{% docs user_updated_at %}
Timestamp of the last update of the account.
{% enddocs %}

{% docs user_soft_deleted_at %}
Timestamp of the user's soft deletion
{% enddocs %}

{% docs user_anonymized_at %}
Timestamp of the user's anonymisation
{% enddocs %}

{% docs user_cache_last_active_at %}
Timestamp of the last computed activity.
{% enddocs %}

{% docs user_reset_password_sent_at %}
Timestamp of the last password reset email sent.
{% enddocs %}

{% docs user_confirmed_at %}
Timestamp of the user's confirmation. Only if necessary.
{% enddocs %}

{% docs user_confirmation_sent_at %}
Timestamp of the last the confirmation email sent.
{% enddocs %}

{% docs user_widget_source_added_at %}
Timestamp of the widget release date.
{% enddocs %}

{% docs user_is_ambivalent %}
Boolean taking the value true if the user is ambivalent (i.e. is simultaneously a member and an ambassador), false otherwise.
{% enddocs %}

{% docs user_first_name %}
First name of the user.
{% enddocs %}

{% docs user_last_name %}
Last name of the user.
{% enddocs %}

{% docs user_email %}
Email of the user.
{% enddocs %}

{% docs user_unconfirmed_email %}
New email requested by the user waiting for confirmation.
{% enddocs %}

{% docs user_normalized_phone %}
Phone number with international prefix.
{% enddocs %}

{% docs user_avatar %}
User avatar path.
{% enddocs %}

{% docs user_languages %}
A list of manguages the user can use.
{% enddocs %}

{% docs user_meeting_preferences %}
As an ambassador, which types of memebers to you accept to meet (e.g. high school student).
{% enddocs %}

{% docs user_meeting_place %}
Autocompleted address value.
{% enddocs %}

{% docs user_situation %}
Education or ambassador related situation.
{% enddocs %}

{% docs user_is_situation_confirmed_after_ambivalence %}
Bolean taking the value true when the user's situation is confirmed, false otherwise.
{% enddocs %}

{% docs user_email_locale %}
Preferred communication language.
{% enddocs %}

{% docs user_referrer_code %}
User's referrer code.
{% enddocs %}

{% docs user_is_high_school_teacher %}
Boelean taking the value true when the user has been identified as a school teacher via special sign up flow, false otherwise.
{% enddocs %}

{% docs user_is_oriane_ambassador %}
Boelean taking the value true when the user has been identified as having signed up through Oriane widget flow, false otherwise.
{% enddocs %}

{% docs user_has_france_travail_connect %}
Boelean taking the value true when the user has signed up or connected their France Travail account, false otherwise.
{% enddocs %}

{% docs user_is_subscribed_to_red_carpets %}
Boelean taking the value true when the user has suscribed to newsletters, false otherwise. Warning: no sync with other tookls. Intercom subscription status is more reliable.
{% enddocs %}

{% docs user_has_videoconference_enabled %}
Boelean taking the value true when the user activated the videoconference feature, false otherwise.
{% enddocs %}

{% docs user_is_user_soft_deleted %}
Boelean taking the value true when the user is soft deleted, false otherwise.
{% enddocs %}

{% docs user_soft_deleted_reason %}
Reason of the deletion.
{% enddocs %}

{% docs user_is_anonymized %}
Boelean taking the value true when the user is anonymized, false otherwise.
{% enddocs %}

{% docs user_sign_up_utm %}
UTM saved at the account creation.
{% enddocs %}

{% docs address_id %}
Unique address ID.
{% enddocs %}

{% docs google_place_id %}
Unique Google Place ID.
{% enddocs %}

{% docs address_created_at %}
Timestamp of the creation of the row.
{% enddocs %}

{% docs address_completed_with_google_places_at %}
Timestamp of the completion with Google Places.
{% enddocs %}

{% docs address_formatted_fr %}
Address formatted in French.
{% enddocs %}

{% docs address_continent %}
Name of the continent.
{% enddocs %}

{% docs address_country %}
Name of the country.
{% enddocs %}

{% docs address_administrative_area_level_1_region_fr %}
Name of the administrative area level 1 in French (it is often the name of the region for French addresses).
{% enddocs %}

{% docs address_administrative_area_level_2_department_fr %}
Name of the administrative area level 2 in French (it is often the name of the department for French addresses).
{% enddocs %}

{% docs address_administrative_area_level_3_fr %}
Name of the administrative area level 3 in French.
{% enddocs %}

{% docs address_city_fr %}
Name of the city in French.
{% enddocs %}

{% docs address_sublocality_level_2_fr %}
Name of the sublocality level 2 in French.
{% enddocs %}

{% docs address_colloquial_area_fr %}
Name of the colloquial area in French.
{% enddocs %}

{% docs address_postal_town_fr %}
Name of the post town in French.
{% enddocs %}

{% docs address_postal_code %}
Postal code.
{% enddocs %}

{% docs address_political_fr %}
Political name of the city in French.
{% enddocs %}

{% docs ambassador_id %}
Unique ambassador ID.
{% enddocs %}

{% docs company_id %}
Unique company ID
{% enddocs %}

{% docs company_sector_id %}
Unique company sector ID
{% enddocs %}

{% docs ambassador_legacy_ambassador_entity_id %}
Legacy entity ID, only for Ambassadors.
{% enddocs %}

{% docs ambassador_inactive_user_id %}
When an ambassador is converted back to a mentor, its previous ambassador profile is archived and the user_id is nulled. Only for Ambassadors
{% enddocs %}

{% docs ambassador_denormalized_last_moderator_user_id %}
User ID of the last moderator that moderated the profile. Only for Mentors.
{% enddocs %}

{% docs contact_request_id %}
ID of the contact request. Only for Mentors
Null for Ambassadors archived & mentor account created, Mentors that registered before 17 Jun 2019 19:05,  Manual mentor account created
{% enddocs %}

{% docs style_ids %}
List of styles that were applied on the ambassador.
{% enddocs %}

{% docs ambassador_created_at %}
Timestamp at which a profile was invited or created account
For mentors, this is almost the time at which their user account was created
For ambassadors, this is either the time at which an admin invited them on the platform or (if they were converted from mentor account) the creation time of their mentor account
For VIPs, this is the time at which the profile was created in the DB
{% enddocs %}

{% docs ambassador_updated_at %}
Timestamp of the last changes in the profile. (not always upadated)
{% enddocs %}

{% docs ambassador_converted_from_mentor_at %}
Timestamp of when the ambassador was converted from a mentor. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_first_approved_at %}
Timestamp when the HR approved the ambassador profile for the first time. Available from 2020-08-27 with company RH dashboard on vocation. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_career_started_at %}
Timestamp at which the ambassador entered their ambassador life. Note that users are required to input their years_of_experience, and the server converts this as this career_started_as timestamp. So its value is inaccurate. Available likely from 2020-01-27 with ambassador gamification overhaul of profile pages.
{% enddocs %}

{% docs ambassador_first_published_at %}
Timestamp of the first time the ambassador was published.
{% enddocs %}

{% docs ambassador_last_published_at %}
Timestamp of the last time the ambassador was published. Not null if the ambassador is unpublished.
{% enddocs %}

{% docs ambassador_first_publication_requested_at %}
Timestamp of the first time that the profile was completed and the ambassador requested its publication.
{% enddocs %}

{% docs ambassador_last_publication_requested_at %}
Timestamp of the last time that the profile was completed and the ambassador requested its publication.
{% enddocs %}

{% docs ambassador_first_publication_request_completion_at %}
Timestamp of the first time at which the ambassador completed their profile at 100%. Available since 2022-11-17 ~15:30.
{% enddocs %}

{% docs ambassador_last_restricted_at %}
Timestamp of the last restriction.
{% enddocs %}

{% docs ambassador_last_unrestricted_at %}
Timestamp of the last unrestriction.
{% enddocs %}

{% docs ambassador_becomes_available_or_iced_up_at %}
Denormalized timestamp that should indicate when the ambassador will either becomes available or iced up following interaction failures
{% enddocs %}

{% docs ambassador_last_iced_up_at %}
A copy of the timestamp of last iced up event.
{% enddocs %}

{% docs ambassador_warmup_started_at %}
A copy of the timestamp of the last time the ambassador entered a warmup stage.
{% enddocs %}

{% docs ambassador_warmup_ended_at %}
A copy of the timestamp of the last time the ambassador exited a warmup stage.
{% enddocs %}

{% docs ambassador_last_melted_at %}
The timestamp of the last time the pro melted (= no longer iced up).
{% enddocs %}

{% docs ambassador_invitation_email %}
Email used whe inviting the ambassador. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_invitation_first_name %}
First name used whe inviting the ambassador. Onlt for Ambassadors.
{% enddocs %}

{% docs ambassador_invitation_last_name %}
Last name used whe inviting the ambassador. Onlt for Ambassadors.
{% enddocs %}

{% docs ambassador_type_raw %}
Raw value of the type of ambassador.
{% enddocs %}

{% docs ambassador_type %}
Ambassador type between: Ambassador, Mentor, and VIP.
{% enddocs %}

{% docs ambassador_company_name %}
For mentors and VIPs, their company name. For ambassadors, a copy of the company name.
{% enddocs %}

{% docs ambassador_company_size %}
For mentors and VIPs, their company size. For ambassadors, a copy of the company size.
{% enddocs %}

{% docs ambassador_company_attributes %}
List of company custom attributes and their value for the ambassador. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_denormalized_company_logo_url %}
A copy of the company logo URL. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_legacy_ambassador_entity_name %}
Legacy name of the entity of the ambassador. Only for Ambassadors.
{% enddocs %}

{% docs ambassador_is_converted_from_ambassador %}
Boolean taking the value true when a Mentor was converted from an Ambassador, false otherwise.
{% enddocs %}

{% docs ambassador_is_independent_company %}
Boolean taking the value true when a Mentor is working independently, false otherwise.
{% enddocs %}

{% docs ambassador_is_company_logo_unavailable %}
Boolean taking the value true when the logo is not available, false otherwise. Only for Mentors.
{% enddocs %}

{% docs ambassador_denormalized_last_moderated_at %}
Timestamp of last moderation. Only for Mentors.
{% enddocs %}

{% docs ambassador_fun_sentence %}
A fun sentence for the about_us page.
{% enddocs %}

{% docs ambassador_is_vip_account %}
Boolean taking the value true when the account is flagged as belonging to an important stakeholder, false otherwise.
{% enddocs %}

{% docs ambassador_is_hidden_from_search %}
Boolean taking the value true when the account is a test account and should not be visible, false otherwise.
{% enddocs %}

{% docs ambassador_search_boost %}
Custom search boost used to promote specific ambassadors.
{% enddocs %}

{% docs ambassador_is_last_name_public %}
Boolean taking the value true when the display of the last name is enabled, false otherwise.
{% enddocs %}

{% docs ambassador_job_title %}
Job title that appears on the public ambassador page.
{% enddocs %}

{% docs ambassador_description %}
Profile description that appears on the public ambassador page.
{% enddocs %}

{% docs ambassador_is_how_it_works_banner_hidden %}
Boolean taking the value true when the user has closed the how it works banner and does not want to show it again, false otherwise.
{% enddocs %}

{% docs ambassador_languages_for_exchanging_with_seekers %}
List of languages the ambassador can use.
{% enddocs %}

{% docs ambassador_is_published %}
Boolean taking the value true when the ambassador is currently published, false otherwise.
{% enddocs %}

{% docs ambassador_last_publication_request_utm %}
UTM recorded the last time the ambassador requested publication. Always a map of utm parameters, even if all values are null. Available from [unknown date], legacy data were filled with a map of null values
{% enddocs %}

{% docs conversation_seeker_situation_at_initiation %}
Situation of the seeker when the conversation was initiated.
{% enddocs %}

{% docs conversation_ambassador_situation_at_initiation %}
Situation of the ambassador when the conversation was initiated.
{% enddocs %}

{% docs ambassador_promotions %}
List of multimedia content showcased on the ambassador profile.
{% enddocs %}

{% docs ambassador_educations %}
List of educations.
{% enddocs %}

{% docs ambassador_recommended_qualifications %}
Multi-Enum of recommended qualifications.
{% enddocs %}

{% docs ambassador_mandatory_skills %}
List of strings representing useful skills related to the ambassador's job. Available from 2019-08-07
{% enddocs %}

{% docs ambassador_is_restricted %}
Boolean taking the value true when the ambassador is currently restricted, false otherwise. Restricted = likeliness of being a fake profile or something similar.
{% enddocs %}

{% docs ambassador_last_restricted_reason %}
Reason of last restriction.
{% enddocs %}

{% docs ambassador_last_unrestricted_reason %}
Reason of last unrestriction.
{% enddocs %}

{% docs ambassador_is_iced_up %}
Boolean taking the value true when the ambassador is currently iced up, false otherwise.
{% enddocs %}

{% docs ambassador_last_iced_up_reason %}
Reason of last ice up.
{% enddocs %}

{% docs ambassador_max_appointments_per_month %}
How many appointments per month a user wishes to make at most.
{% enddocs %}

{% docs ambassador_publication_request_completion_percentage %}
Current percentage completion of the profile.
{% enddocs %}

{% docs company_sector_created_at %}
Timestamps of the creation of the row.
{% enddocs %}

{% docs company_sector_updated_at %}
Timestamps of the last update of the row.

{% enddocs %}

{% docs company_sector_name %}
International name of the company_sector.
{% enddocs %}

{% docs company_sector_normalized_name %}
Normalized name of the sector.
{% enddocs %}

{% docs company_sector_linkedin_code %}
Reference of the original LinkedIn Sector Code.
{% enddocs %}

{% docs company_sector_hidden_from_search %}
Boolean taking the value true when the sector is hidden from seach filters, false otherwise.
{% enddocs %}

{% docs conversation_id %}
ID of the conversation.
{% enddocs %}

{% docs seeker_id %}
ID of the seeker.
{% enddocs %}

{% docs denormalized_wish_before_start_id %}
ID of the wish. A wish is when a seeker bookmarked an ambassador's profile before initiating a conversation.
{% enddocs %}

{% docs denormalized_red_carpet_roll_id %}
ID of the roll carpet roll. I happens when the conversation is initiated after an ambassador had rolled a red carper to the seeker.
{% enddocs %}

{% docs email_thread_reference_id %}
ID of the email thread for the reply by email feature.
{% enddocs %}

{% docs seeker_email_id %}
ID that identifies if the seeker is replying by email in the context of this conversation. When the seeker replies to the ambassador, this should be the identifier before the @ for the reply-by-email feature.
{% enddocs %}

{% docs ambassador_email_id %}
ID that identifies if the ambassador is replying by email in the context of this conversation. When the ambassador replies to the seeker, this should be the identifier before the @ for the reply-by-email feature.
{% enddocs %}

{% docs conversation_seeker_situation_company_id %}
Company ID of the seeker when the conversation was initiated.
{% enddocs %}

{% docs conversation_ambassador_situation_company_id %}
Company ID of the ambassador when the conversation was initiated.
{% enddocs %}

{% docs conversation_denormalized_last_sender_id %}
User ID of the last message sender.
{% enddocs %}

{% docs conversation_initiated_at %}
Timestamp of when the conversation was initiated by the seeker.
{% enddocs %}

{% docs conversation_updated_at %}
Timestamp of when the conversation was last updated by the system.
{% enddocs %}

{% docs conversation_denormalized_last_message_sent_at %}
A copy of the timestamp of when the last message was sent and processed by the system.
{% enddocs %}

{% docs conversation_denormalized_ambassador_first_response_at %}
A copy of the timestamp when the first ambassador message was sent in this conversation.
{% enddocs %}

{% docs conversation_denormalized_seeker_first_response_at %}
A copy of the timestamp when the first seeker message was sent following the first ambassador message in this conversation.
{% enddocs %}

{% docs conversation_denormalized_acknowledged_at %}
A copy of the timestamp of when we know for sure the last message was acknowledged by the recipient. It is not reset to null after another message is sent.
{% enddocs %}

{% docs conversation_denormalized_need_acknowledgement_at %}
A copy of the timestamp of when the first message of the last sender message streak was sent.
{% enddocs %}

{% docs conversation_last_invalidated_at %}
Timestamp of when the conversation was last invalidated.
{% enddocs %}

{% docs conversation_utm_at_initiation %}
UTM parameters recorded when the conversation was initiated.
{% enddocs %}

{% docs conversation_denormalized_ambassador_first_response_time %}
A cached computation of the timestamp when the first professional message was sent in this conversation minus the timestamp when this conversation was initiated.
{% enddocs %}

{% docs conversation_denormalized_seeker_first_response_time %}
A cached computation of the first student message was sent following the first professional message in this conversation minus the timestamp when this conversation was initiated.
{% enddocs %}

{% docs conversation_denormalized_is_acknowledged %}
Boolean taking the value true when
{% enddocs %}

{% docs conversation_is_disabled %}
Boolean taking the value true when the conversation is disabled because of the following reasons: the professional was flagged as a fake mentor account (see is_invalidated), the student deleted his account, the professional deleted his account, or other reason (manual flagging by MJG admins), false otherwise.
{% enddocs %}

{% docs conversation_is_invalidated %}
Boolean taking the value true when the conversation was invalidated following a professional restriction, false otherwise.
{% enddocs %}

{% docs conversation_last_invalidated_reason %}
Reason of last invalidation of the conversation.
{% enddocs %}

{% docs ambassador_crisis_id %}
ID of the crisis.
{% enddocs %}

{% docs ambassador_crisis_created_at %}
Timestamp of the creation of the row.
{% enddocs %}

{% docs ambassador_crisis_started_at %}
Timestamp of the beggining of the crisis.
{% enddocs %}

{% docs ambassador_crisis_average_response_time_at_start_of_crisis %}
Average response time of the ambassador at the beggining of the crisis.
{% enddocs %}

{% docs ambassador_crisis_level_cd %}
Intensity of the crisis (orange or red).
{% enddocs %}

{% docs appointment_claim_id %}
ID of the appointment claim.
{% enddocs %}

{% docs appointment_claim_created_on_platform_at %}
Timestamp of the creation of the appointment claim by the seeker.
{% enddocs %}

{% docs appointment_claim_updated_at %}
Timestamp of the update of the appointment claim by the seeker.
{% enddocs %}

{% docs appointment_claim_resolved_at %}
Timestamp of the resolution of the appointment claim by the seeker.
{% enddocs %}

{% docs appointment_start_at %}
Timestamp at which the appointment is alledged to have taken place started.
{% enddocs %}

{% docs appointment_end_at %}
Timestamp by default one hour after appointment_start_at.
{% enddocs %}

{% docs appointment_type %}
Type of appointment (video, phone, face_to_face).
{% enddocs %}

{% docs appointment_claim_status %}
Status of the appointment (accepted, pending, refused).
{% enddocs %}

{% docs appointment_address %}
ID of the address where the appointment takes place.
{% enddocs %}

{% docs appointment_meeting_place %}
Autocompleted address value in case of face-to-face appointments.
{% enddocs %}

{% docs appointment_coordinates %}
Autocompleted coordinates in case of face-to-face appointments.
{% enddocs %}

{% docs appointment_time_zone %}
Timezone selected by the user.
{% enddocs %}

{% docs appointment_created_on_platform_at %}
Timestamp at which the ambassador has eitherregistered the appointment on the platform, or accepted an appointment claim from a seeker.
{% enddocs %}

{% docs appointment_updated_at %}
Timestamp at which appointment information was last updated.
{% enddocs %}

{% docs appointment_unbooked_at %}
Timestamp at which one of the parties cancelled the appointment. Only when the appointment was cancelled before its expected appointment_start_at.
{% enddocs %}

{% docs appointment_last_invalidated_at %}
Timestamp of the last invalidation.
{% enddocs %}

{% docs appointment_last_feedback_follow_up_sent_at %}
Timestamp at which the last follow_up email was sent (asking for a feedback).
{% enddocs %}

{% docs appointment_general_status %}
Summary of the status of the appointment gathered from the feedbacks of both the ambassador and the seeker.
{% enddocs %}

{% docs appointment_seeker_feedback_type %}
Type of feedback given by the seeker.
{% enddocs %}

{% docs appointment_ambassador_feedback_type %}
Type of feedback given by the ambassador.
{% enddocs %}

{% docs appointment_seeker_custom_cancellation_reason %}
The explicit explanation of the cancellation when the seeker indicated "other" as the cancellation reason.
{% enddocs %}

{% docs appointment_ambassador_custom_cancellation_reason %}
The explicit explanation of the cancellation when the ambassador indicated "other" as the cancellation reason.
{% enddocs %}

{% docs appointment_feedback_from_ambassador %}
Feedback from the ambassador that can contain a review, an indication that the appointment did not take place, or be null when this information was not asked.
{% enddocs %}

{% docs appointment_feedback_from_seeker %}
Feedback from the seeker that can contain a review, an indication that the appointment did not take place, or be null when this information was not asked.
{% enddocs %}

{% docs appointment_is_invalidated %}
Boolean taking the value true when the appointment is invalidated, false otherwise.
{% enddocs %}

{% docs appointment_last_invalidated_reason %}
Reason of the last invalidation.
{% enddocs %}

{% docs appointment_feedback_follow_ups %}
List of all appointment follow up emails sent.
{% enddocs %}

{% docs seeker_profile_created_at %}
Timestamp of the creation of the seeker profile.
{% enddocs %}

{% docs seeker_updated_at %}
Timestamp of the last update of the document.
{% enddocs %}

{% docs seeker_profile_first_completed_at %}
Timestmap of when the profile was first completed.
{% enddocs %}

{% docs seeker_profile_last_edited_at %}
Timestmap of when the profile was last edited.
{% enddocs %}

{% docs seeker_last_soft_deleted_at %}
Timestamp of last soft deletion. Nulled after undeletion.
{% enddocs %}

{% docs seeker_anonymized_at %}
Timestamp of anonymization.
{% enddocs %}

{% docs seeker_type %}
Type of seeker.
{% enddocs %}

{% docs seeker_educations %}
List of the seeker's educations.
{% enddocs %}

{% docs seeker_meeting_place_address %}
Autocompleted address value.
{% enddocs %}

{% docs seeker_meeting_place_coordinates %}
Autocompleted coordinates value.
{% enddocs %}

{% docs seeker_meeting_place_address_dataset %}
The complete address dataset of the seeker.
{% enddocs %}

{% docs seeker_normalized_phone %}
Phone number with international prefix.
{% enddocs %}

{% docs seeker_denormalized_appointment_reviews %}
A copy of appointment reviews validated by the ambassador.
{% enddocs %}

{% docs seeker_description %}
Presentation of the seeker.
{% enddocs %}

{% docs seeker_graduation_year %}
Graduation year.
{% enddocs %}

{% docs seeker_is_profile_completed %}
Boolean taking the value true when the profile is completed, false otherwise.
{% enddocs %}

{% docs seeker_is_subscribed_to_gatling %}
Boolean taking the value true when the seeker agreed to receive gatling emails, false otherwise.
{% enddocs %}

{% docs seeker_denormalized_average_rating_of_first_question %}
The current rating (or average if multiple questions) of the seeker aggregated from all reviewed appointments first question answer.
{% enddocs %}

{% docs seeker_replied_conversations_count_cache %}
A copy of the number of replied conversations.
{% enddocs %}

{% docs seeker_denormalized_is_involved_in_a_fdr %}
Boolean taking the value true is the seeker is or has been affiliated to at least one FDR, false otherwise.
{% enddocs %}

{% docs seeker_denormalized_confirmed_appointment_with_ambassador_review_count %}
A copy of the number of the appointments where the ambassador indicated the appointment took place and left a semi-public review.
{% enddocs %}

{% docs seeker_denormalized_confirmed_appointment_count %}
A copy of the number of the appointments where the professional indicated the appointment took place.
{% enddocs %}

{% docs seeker_denormalized_appointments_per_month %}
A copy of a list of appointments per month.
{% enddocs %}

{% docs seeker_denormalized_referrals_initiated_count %}
A copy of the number of referred users (any type) that registered following an invitation from this user.
{% enddocs %}

{% docs seeker_denormalized_unique_profile_views_count %}
A denormalized version of the unique ambassador profile view.
{% enddocs %}

{% docs seeker_last_mission_accomplished %}
ID of the last mission accomplished on the platform.
{% enddocs %}
