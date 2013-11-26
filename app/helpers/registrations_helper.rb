module RegistrationsHelper

  def custom_field_tag(custom_field)
    case custom_field.type
      when "text_field" then custom_text_field_tag(custom_field)
      when "select" then custom_select_tag(custom_field)
    end

  end

  def custom_text_field_tag(custom_field)
    label_tag(custom_field.name_attr, custom_field.label) +
    text_field_tag(custom_field.name_attr, custom_field.value)
  end

  def custom_select_tag(custom_field)
    label_tag(custom_field.name_attr, custom_field.label) +
    select_tag(custom_field.name_attr, 
      options_for_select(custom_field.select_options))
  end

end
