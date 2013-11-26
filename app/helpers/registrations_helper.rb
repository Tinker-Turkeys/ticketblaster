module RegistrationsHelper

  def custom_field_tag(custom_field)
    allowed = [:text_field, :select, :radio_button, :check_box]

    if allowed.include?(custom_field.type.to_sym)
      send("custom_#{custom_field.type}_tag", custom_field)
    end
  end

  def custom_text_field_tag(custom_field)
    label_tag(custom_field.name_attr, custom_field.label) +
    text_field_tag(custom_field.name_attr, custom_field.value)
  end

  def custom_select_tag(custom_field)
    label_tag(custom_field.name_attr, custom_field.label) +
    select_tag(custom_field.name_attr, 
      options_for_select(custom_field.options_list))
  end

  def custom_radio_button_tag(custom_field)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        radio_button_tag(custom_field.name_attr, option) + 
          option
      end
    end.join("").html_safe
  end

  def custom_check_box_tag(custom_field)
    if custom_field.options_list.any?
      custom_multi_item_checkbox(custom_field)
    else
      custom_single_item_checkbox(custom_field)
    end
  end

  def custom_single_item_checkbox(custom_field)
    label_tag(nil, custom_field.label) +
    label_tag(custom_field.name_attr) do
      check_box_tag(custom_field.name_attr, custom_field.value) + 
        custom_field.value
    end
  end

  def custom_multi_item_checkbox(custom_field)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        check_box_tag(custom_field.name_attr, option) + 
          option
      end
    end.join("").html_safe
  end

end
