module RegistrationsHelper

  def custom_field_tag(custom_field, value)
    value = nil if value.blank?
    if CustomField.types.include?(custom_field.type)
      send("custom_#{custom_field.type}_tag", custom_field, value)
    end
  end

  def custom_text_field_tag(custom_field, value)
    content_tag :div, class: "form-group" do
      label_tag(custom_field.name_attr, custom_field.label) +
        text_field_tag(custom_field.name_attr, (value || custom_field.value),
          class: "form-control")
    end
  end

  def custom_select_tag(custom_field, value)
    label_tag(custom_field.name_attr, custom_field.label) +
    select_tag(custom_field.name_attr, 
      options_for_select(custom_field.options_list, 
        (value || custom_field.value)
      ),
      class: "form-control")
  end

  def custom_radio_button_tag(custom_field, value)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        radio_button_tag(custom_field.name_attr, option, 
          (value || custom_field.value.split(',')).include?(option)) + 
        option
      end
    end.join("").html_safe
  end

  def custom_check_box_tag(custom_field, value)
    label_tag(nil, custom_field.label) +
    custom_field.options_list.map do |option|
      label_tag nil do
        check_box_tag(custom_field.name_attr, option,
          (value || custom_field.value.split(',')).include?(option)) + option
      end
    end.join("").html_safe
  end

end
