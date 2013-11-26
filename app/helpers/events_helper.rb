module EventsHelper

  def custom_field_section(custom_field)
    case custom_field.type
      when "text_field" then custom_text_field_tag(custom_field)
    end

  end

  def custom_text_field_tag(custom_field)
    label_tag("event[custom_fields][#{custom_field.name}]", custom_field.label) +
    text_field_tag(custom_field.name, custom_field.value)
  end

end
