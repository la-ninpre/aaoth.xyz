---
title: other
permalink: /other/
---

# other

here will be some misc stuff

<div class="posts">
{% for post in site.posts %}
    <div class="post">
        {{ post.content }}
        <a href="{{ post.url }}">{{ post.date | date_to_string }}</a>
    </div>
{% endfor %}
</div>
