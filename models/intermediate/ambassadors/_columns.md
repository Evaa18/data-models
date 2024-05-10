
{% docs nuida_appointments %}
Appointments that are not unbooked, nor invalidated, nor denied by anyone.
{% enddocs %}

{% docs ambassador_is_in_warm_up %}
Boolean taking the value true when the ambassador is in a warmup period, false otherwise.
{% enddocs %}

{% docs ambassador_is_invalidated %}
Boolean taking the value true when the ambassador is invalidated, false otherwise.
{% enddocs %}

{% docs ambassador_is_unpublished %}
Boolean taking the value true when the ambassador is not yet published, false otherwise.
{% enddocs %}

{% docs ambassador_is_in_red_crisis %}
Boolean taking the value true when the ambassador is in a red crisis stage, false otherwise.
{% enddocs %}

{% docs ambassador_is_disengaged %}
Boolean taking the value true when the ambassador is in a disengaged stage (either iced up, soft deleted, restricted, or invalidated), false otherwise.
{% enddocs %}

{% docs ambassadors_replying %}
Count distinct of all ambassadors that replied to at least one conversation.
{% enddocs %}

{% docs conversations_replied %}
Count distinct of all conversations that were replied to.
{% enddocs %}

{% docs ambassadors_contacted %}
Count distinct of all ambassadors that received at least one conversation.
{% enddocs %}

{% docs conversations_received %}
Count distinct of all conversations that were received.
{% enddocs %}

{% docs new_ambassadors_is_unpublished %}
Count distinct of all ambassadors newly published.
{% enddocs %}

{% docs new_ambassadors_is_iced_up %}
Count distinct of all ambassadors newly iced up.
{% enddocs %}

{% docs new_ambassadors_is_soft_deleted %}
Count distinct of all ambassadors newly soft deleted.
{% enddocs %}

{% docs new_ambassadors_is_restricted %}
Count distinct of all ambassadors newly restricted.
{% enddocs %}

{% docs new_ambassadors_is_invalidated %}
Count distinct of all ambassadors newly invalidated.
{% enddocs %}

{% docs new_ambassadors_is_disengaged %}
Count distinct of all ambassadors newly disengaged (either iced up, soft deleted, restricted, or invalidated).
{% enddocs %}

{% docs new_ambassadors_first_disengaged_reason %}
Reason of the first disengagement.
{% enddocs %}

{% docs new_ambassadors_published %}
Count distinct of all ambassadors newly published.
{% enddocs %}