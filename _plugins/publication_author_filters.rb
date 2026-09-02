module PublicationAuthorFilters
  def mark_publication_authors(reference, entry)
    site = @context.registers[:site]
    html = reference.to_s.dup

    corresponding = entry_value(entry, "corresponding")
    html = replace_author_names(html, corresponding) do |matched|
      %(#{matched}<sup class="corresponding-author-marker" title="Corresponding author">*</sup>)
    end

    bold_names = site.config.dig("scholar", "bold_names")
    bold_names ||= inferred_bold_names(site.config.dig("scholar", "first_name"), site.config.dig("scholar", "last_name"))
    replace_author_names(html, bold_names) do |matched|
      %(<strong class="publication-self-author">#{matched}</strong>)
    end
  end

  private

  def entry_value(entry, key)
    return nil unless entry

    value = entry[key] if entry.respond_to?(:[])
    value ||= entry[key.to_sym] if entry.respond_to?(:[])
    value ||= entry.public_send(key) if entry.respond_to?(key)
    value
  rescue StandardError
    nil
  end

  def inferred_bold_names(first_names, last_name)
    Array(first_names).map { |first_name| "#{last_name}, #{first_name}" }
  end

  def replace_author_names(html, names)
    variants = author_variants(names)
    return html if variants.empty?

    variants.each do |variant|
      pattern = variant.split(/\s+/).map { |part| Regexp.escape(part) }.join("(?:\\s|&nbsp;)+")
      html = html.gsub(/(?<prefix>^|[^A-Za-z])(?<name>#{pattern})(?![A-Za-z])/) do
        prefix = Regexp.last_match(:prefix)
        matched = Regexp.last_match(:name)
        replacement = block_given? ? yield(matched) : matched
        "#{prefix}#{replacement}"
      end
    end

    html
  end

  def author_variants(names)
    Array(names).flat_map { |name| split_names(name) }.flat_map { |name| variants_for_name(name) }.compact.uniq.sort_by { |name| -name.length }
  end

  def split_names(names)
    names.to_s.split(/\s+and\s+|;/).map(&:strip).reject(&:empty?)
  end

  def variants_for_name(name)
    cleaned = name.gsub(/[{}]/, "").strip
    return [cleaned] if cleaned.empty?

    first_names, last_name = if cleaned.include?(",")
      parts = cleaned.split(",", 2).map(&:strip)
      [parts[1], parts[0]]
    else
      parts = cleaned.split(/\s+/)
      [parts[0...-1].join(" "), parts[-1]]
    end

    initials = first_names.to_s.split(/\s+/).reject(&:empty?).map { |part| "#{part[0].upcase}." }
    initial_name = initials.join(" ")

    [
      cleaned,
      [last_name, first_names].compact.reject(&:empty?).join(", "),
      [last_name, initial_name].compact.reject(&:empty?).join(", "),
      [initial_name, last_name].compact.reject(&:empty?).join(" "),
      [first_names, last_name].compact.reject(&:empty?).join(" ")
    ].reject(&:empty?)
  end
end

Liquid::Template.register_filter(PublicationAuthorFilters)
