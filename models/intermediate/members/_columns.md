{% docs measured_at %}
Date of measure.
{% enddocs %}

{% docs member_activated_at %}
Timestamp of the first activation of a member. For seekers it is their first CI and for ambassadors it is when they have been published for the first time (for ambassador members, it is the earliest of those two dates).
{% enddocs %}

{% docs conversation_replied_at %}
Timestamp of when the conversation received a reply.
{% enddocs %}

{% docs member_is_created %}
Boolean taking the value true if the member is i created, false otherwise.
{% enddocs %}

{% docs member_is_activated %}
Boolean taking the value true if the member is in a timeframe where they are activated, false if they are outside this timeframe.
{% enddocs %}

{% docs member_activation %}
Indicates, if the member is not activated, why between only not activated if the profile got deactivated, soft deleted or incomplete profile.
{% enddocs %}

{% docs member_affiliation %}
Indicates whether the member belongs or has ever belonged to an affiliated program.
{% enddocs %}

{% docs seekers_replied_to %}
Number of unique seekers that have received a reply.
{% enddocs %}

{% docs seekers_contacting %}
Number of unique seekers that have initiated a conversation.
{% enddocs %}

{% docs conversations_sent %}
Number of unique conversations that have been sent.
{% enddocs %}