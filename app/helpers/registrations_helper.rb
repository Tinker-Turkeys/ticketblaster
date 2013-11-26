module RegistrationsHelper

  def custom_field_tag(custom_field, value)
    allowed = [:text_field, :select, :radio_button, :check_box]

    if allowed.include?(custom_field.type.to_sym)
      send("custom_#{custom_field.type}_tag", custom_field, value)
    end
  end

  def custom_text_field_tag(custom_field, value)
    label_tag(custom_field.name_attr, custom_field.label) +
    text_field_tag(custom_field.name_attr, value)
  end

  def custom_select_tag(custom_field, value)
    label_tag(custom_field.name_attr, custom_field.label) +
    select_tag(custom_field.name_attr, 
      options_for_select(custom_field.options_list, value))
  end

  def custom_radio_button_tag(custom_field, value)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        radio_button_tag(custom_field.name_attr, option, 
          option == value) + 
        option
      end
    end.join("").html_safe
  end

  def custom_check_box_tag(custom_field, value)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        check_box_tag(custom_field.name_attr, option, value.include?(option)) + 
          option
      end
    end.join("").html_safe
  end

end
