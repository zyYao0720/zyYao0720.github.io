# Upgrading from the Previous Template

If you're already using the old version of this template, follow these steps to migrate.

## 1. Update _config.yml

The new config uses a simplified format. Move these fields:

**Old format (remove):**
```yaml
title: Richard Feynman
affiliation: >
  Richard Feynman<br/>
  Professor of Physics<br/>
  California Institute of Technology
location: >
  ...
contact: >
  ...
```

**New format (add):**
```yaml
name: "Richard Feynman"
title: "Professor of Physics"
institution: "California Institute of Technology"
email: richard@university.edu
photo: headshot.jpg
links:
  google_scholar: "..."
  github: "..."
accent_color: "#2563eb"
dark_mode: true
analytics:
  google_id: ""
```

## 2. Update _data/pi.yml

Basic PI info (name, photo, email, links) now lives in `_config.yml`. The `pi.yml` file only needs education data:

```yaml
- education:
    - "(1942) Ph.D. Physics, Princeton University"
  educationshort:
    - "(1942) Ph.D. Physics, Princeton"
```

## 3. Organize Images (Optional)

New subdirectories are available:
- `images/team/` — team member photos
- `images/research/` — research thumbnails
- `images/banner/` — banner images

Your existing flat `images/` structure still works.

## 4. Data Files

Field names in `team_members.yml`, `alumni.yml`, `news.yml`, etc. are unchanged. Your existing data files should work as-is.

## 5. Publications

`assets/ref.bib` format is unchanged. Jekyll Scholar config stays in `_config.yml`. Update the `scholar.last_name` and `scholar.first_name` fields.

## 6. Custom CSS

If you added custom CSS to `SHB_css.scss`, move it to a new file in `_sass/` and import it in `assets/main.scss`.

## 7. Install & Test

```bash
bundle install
npm install        # only if you want to modify JS
bundle exec jekyll serve
```
