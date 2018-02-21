module FormHelper
  class FormWithErrorMessageBuilder < ActionView::Helpers::FormBuilder
    def text_field(attribute, options={})
      input_field_with_error(attribute, options) do
        super 
      end
    end

    def email_field(attribute, options={})
      input_field_with_error(attribute, options) do
        super
      end
    end

    def password_field(attribute, options={})
      input_field_with_error(attribute, options) do
        super
      end
    end

    def select(class_name, attribute, select_items, default, options={})
      input_field_with_error(class_name, options) do
        super(attribute, select_items, default, options)
      end
    end

    def input_field_with_error(attribute, options={}, &block)
      error_messages = @object.errors.full_messages_for(attribute)
      if error_messages.any?
        options[:class] << " is-invalid"
        error_contents = create_error_div(attribute, error_messages)
      end

      block.call + error_contents || ""
    end

    def create_error_div(attribute, messages)
      @template.content_tag(:div, class: "input-form-error text-danger") do
        messages.each do |message|
          @template.concat(@template.content_tag(:div, message))
        end
      end
    end
  end
end
