module PlaybooksHelper
  def playbook_footer(playbook)
    "<b>Utworzono:</b><cite>#{playbook.created_at.strftime("%d/%m/%Y %H:%M")}</cite><br><b>Edytowano:</b><cite>#{playbook.updated_at.strftime("%d/%m/%Y %H:%M")}</cite>".html_safe
  end
end
