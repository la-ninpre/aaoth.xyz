---
title: music
layout: default
---

## [hälsorisk][1]

**hälsorisk** (swedish for *health hazard*) is small web-label focused on dark
underground music. here's a list of projects in which i took part:

{%- assign haelsorisk_projects = site.music_projects | where: "other", nil -%}

{% for h_project in haelsorisk_projects %}
* [{{ h_project.title }}]({{ h_project.url }})
-- {{ h_project.description }} ({{ h_project.roles | split: " " | join: ", " }})
{% endfor %}

[1]:/haelsorisk

## other projects

{%- assign other_projects = site.music_projects | where: "other", true -%}

{% for project in other_projects %}
* [{{ project.title }}]({{ project.url }}) -- {{ project.description }}
{% endfor %}
