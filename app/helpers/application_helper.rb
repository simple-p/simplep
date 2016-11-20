module ApplicationHelper
	def li_link_to (name, url, options = {})
		options[:class] ||= ""
		options[:class] << " nav-link"
		content_tag(:li, class: 'nav-item') do
			link_to(name, url, options)
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
end
