module ApplicationHelper
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown_to_html = Redcarpet::Markdown.new(renderer, extensions)

    markdown_to_html.render(text).html_safe
  end
  def li_link_to (name, url, options = {})
    options[:class] ||= ""
    options[:class] << " nav-link"
    content_tag(:li, class: 'nav-item') do
      link_to(name, url, options)
    end
  end

  def new_feeds_icon(count)
    if count > 0
    content_tag(:span, nil, class: 'nav_link__badge fa fa-circle')
    else
    content_tag(:span, nil, class: 'nav_link__badge fa fa-circle', style: 'display:none')
    end
  end
  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-error', notice: 'warning' }[flash_type.to_sym]
  end

  def flash_messages (options = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        content_tag(:button, "<i class='fa fa-times' aria-hidden='true'></i>".html_safe,
                    class: 'close', data: { dismiss: 'alert' }) + message
      end
    end.join.html_safe
  end

  def flash_toastr
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}')</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def task_completed_icon(task)
    if task.isCompleted?
      content_tag(:div, "<i class='fa fa-lg fa-check-circle' style='color:#00AA00' aria-hidden='true'></i>".html_safe)
    else
      content_tag(:div, "<i class='fa fa-lg fa-circle-o' aria-hidden='true'></i>".html_safe)
    end
  end
  
  def custom_format(date)
    if date == Date.today
      "Today"
    elsif date == Date.tomorrow
      "Tomorrow"
    elsif date == Date.yesterday
      "Yesterday"
    elsif (date > Date.today - 7) && (date < Date.yesterday)
      date.strftime("%A")
    else
      date.strftime("%B %-d")
    end
  end

  def deadline_warning(task)
    if task.due_date
      if !task.isCompleted?
        if task.due_date < Time.zone.now
          date_color = 'red'
        else
          date_color = 'green'
        end
      else
        date_color = 'black'
      end
      content_tag(:div, "<font color=#{date_color}>#{custom_format(task.due_date.to_date)}</font>".html_safe);
    end
  end
  # Helper for Devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # End helper for devise
end
