module MarkdownHelper
  def render_markdown(content)
    return "" if content.blank?

    markdown = Commonmarker.to_html(
      content,
      options: {
        parse: {
          smart: true
        }
      }
    )

    markdown.html_safe
  end
end