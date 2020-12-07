---
title: other
---

miscellaneous posts about different things.

filter by tag: {% for tag in site.tags %}[{{ tag[0] }}](/tags/{{ tag[0] }})
{% endfor %}

<div class="posts">
{% for post in site.posts %}
    <div class="post">
        <h2 id="{{ post.title | slugify }}">
            <a href="{{ post.url}}">{{ post.title }}</a>
        </h2>
        {{ post.content }}
        <small><p>{{ post.date | date_to_string }}</p></small>
    </div>
{% endfor %}
</div>
