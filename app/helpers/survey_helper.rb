module SurveyHelper
  # Helper to embed an SVG file directly into the HTML
  def inline_svg_tag(filename, options = {})
    path = Rails.root.join('app', 'assets', 'images', filename)
    return unless File.exist?(path)

    File.read(path).html_safe
  end
end
