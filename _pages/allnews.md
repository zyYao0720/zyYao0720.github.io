---
title: "News"
layout: gridlay
sitemap: false
permalink: /allnews.html
---

## News

<div class="section-card" markdown="0">
<div class="news-timeline">
{% for article in site.data.news %}
<div class="news-item">
<span class="news-date">{{ article.date }}</span>
<span class="news-headline">
{% if article.url %}
<a href="{{ article.url }}" target="_blank" rel="noopener">{{ article.headline }}</a>
{% else %}
{{ article.headline }}
{% endif %}
</span>
</div>
{% endfor %}
</div>
</div>
