---
title: other
permalink: /other/
---

# miscellaneous posts

about different things

filter by tag: {% for tag in site.tags %}[{{ tag[0] }}](/tags/{{ tag[0] }})
{% endfor %}

<div class="posts">
{% for post in site.posts %}
    {% include post-preview.html %}
{% endfor %}
</div>
