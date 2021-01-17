module RunsHelper
    def run_footer(run)
      "<b>Utworzono:</b><cite>#{run.created_at.strftime("%d/%m/%Y %H:%M")}</cite>".html_safe
    end
end
