---
title: other
permalink: /other/
---

# other

here will be some misc stuff

<div class="posts">
{% for post in site.posts %}
    <div class="post">
        <h2><a href="{{ post.url}}">{{ post.title }}</a></h2>
        <small>
            <p>{{ post.date | date_to_string }}</p>
            {% if post.tags.size > 0 %}
            <p>| tags: </p>
            {% for tag in post.tags %}
            <a href="/tags/{{ tag }}">{{ tag }}</a>
            {% endfor %}
            {% endif %}
        </small>
        {{ post.content }}
    </div>
{% endfor %}
</div>
