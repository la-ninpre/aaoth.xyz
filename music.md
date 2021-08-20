---
title: music
permalink: /music/
---

# [hälsorisk][1]

**hälsorisk** (swedish for '*health hazard*') is small web-label focused on dark
underground music.
here's a list of projects in which i took part:

{% comment %}
    haelsorisk projects
{% endcomment %}
{% assign projects = site.music_projects | where: "other", nil %}

<div class="haelsorisk-projects-list">
{% include music-projects-list.html %}
</div>

[1]:/haelsorisk

# other projects

{% comment %}
    other projects
{% endcomment %}
{% assign projects = site.music_projects | where: "other", true %}

<div class="other-projects-list">
{% include music-projects-list.html %}
</div>
