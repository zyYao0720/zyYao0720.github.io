---
title: "Publications"
layout: gridlay
sitemap: false
permalink: /publications/
---

## Publications

<p class="pub-note"><strong>Bold</strong> indicates my name; <sup class="corresponding-author-marker">*</sup> indicates corresponding author; <span class="pub-badge pub-badge-esi">ESI Highly Cited Paper</span> marks ESI highly cited papers.</p>

<input type="text" class="pub-search" id="pubSearch" placeholder="Filter by title, author, or year...">

<div class="section-card" id="pubList">
<h3>Preprints</h3>

{% bibliography --query @unpublished %}

<h3>Refereed Journal Articles</h3>

{% bibliography --query @article %}

<h3>Refereed Conference Proceedings</h3>

{% bibliography --query @inproceedings %}
</div>
