---
title: music
permalink: /music/
---

# [hälsorisk][1]

**hälsorisk** (swedish for '*health hazard*') is small web-label focused on dark
underground music.
here's a list of projects in which i took part:

{% assign haelsorisk_projects = site.music_projects | where: "other", nil %}

<div class="haelsorisk-projects-list">
{% include music-projects-list.html projects=haelsorisk_projects%}
</div>

[1]:/haelsorisk

# other projects

{% assign other_projects = site.music_projects | where: "other", true %}

<div class="other-projects-list">
{% include music-projects-list.html projects=other_projects %}
</div>
