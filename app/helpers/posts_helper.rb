module PostsHelper
  def post_footer(post)
    "<b>Utworzono:</b><cite>#{post.created_at.strftime("%d/%m/%Y %H:%M")}</cite><br><b>Edytowano:</b><cite>#{post.updated_at.strftime("%d/%m/%Y %H:%M")}</cite>".html_safe
  end
end
