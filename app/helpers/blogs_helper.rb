module BlogsHelper
  def statusIcon(status)
    statusIcons = {"Ahead" => "fa fa-calendar-plus-o", "On Track" => "fa fa-calendar-check-o", "Late" => "fa fa-calendar-times-o"}
    statusIcons[status.to_s]
  end
end
