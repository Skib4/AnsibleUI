module HostsHelper
  def host_footer(host)
    "<b>Utworzono:</b><cite>#{host.created_at.strftime("%d/%m/%Y %H:%M")}</cite><br><b>Edytowano:</b><cite>#{host.updated_at.strftime("%d/%m/%Y %H:%M")}</cite>".html_safe
  end
end
