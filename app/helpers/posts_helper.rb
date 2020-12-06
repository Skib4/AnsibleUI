module PostsHelper
  def format_date(date)
    date.strftime("%d.%m.%Y")
  end

  def post_footer(post)
      "<cite>#{post.author}, #{format_date(post.created_at)}</cite>".html_safe
    end
end
