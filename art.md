---
title: art
permalink: /art/
---

{% assign image_files = site.static_files | where: "art", true %}

here are some photos and pictures.

feel free to use them if and as you wish (don't forget to attribute).

<div class="art">
{% for img in image_files %}
    <div class="art-img">
        <img src="{{ img.path }}" alt="{{ img.name }}">
    </div>
{% endfor %}
</div>
