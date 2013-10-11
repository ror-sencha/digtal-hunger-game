module ApplicationHelper
	def error_messages_for obj
    html = ''
    if obj.errors.any? 
      html << %Q{<div id="error_explanation">}
      html << %Q(<ul>)
      obj.errors.each { |attr,msg|
        name = attr.to_s
        html << %Q(<li class="error"> #{name.humanize} #{msg}</li>)
      }
      html << %Q{</ul>}
      html << %Q{</div>}
      html << %Q(<br/>) 
    end
    raw html
  end
  
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def show_inline_errors(errors_arr,column_field_arr)
    error_string = ""
    column_field_arr.each do |column_name|
      error_string += errors_arr[column_name].first if errors_arr[column_name].present?
    end
    error_string
  end



end
