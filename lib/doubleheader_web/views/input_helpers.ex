defmodule DoubleheaderWeb.InputHelpers do
  use Phoenix.HTML

  def input_large(form, field, icon \\ [], opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)
    field_opts = [class: "field"]
    wrapper_opts = [class: "control is-large is-clearfix has-icons-left has-icons-right"]
    label_opts = [class: "label"]
    state_class = state_class(form, field)
    input_opts = Keyword.merge([class: "input #{state_class}"], opts)

    content_tag :div, field_opts do
      [label(form, field, humanize(field), label_opts),
      content_tag :div, wrapper_opts do
        input_tag = input(type, form, field, icon, input_opts)
        icon_tag = content_tag(:span, [class: "icon is-small is-left"]) do
          tag(:icon, icon)
        end
        icon_error = content_tag(:span, [class: "icon is-small is-right"]) do
          tag(:icon, [class: "#{icon_class(state_class)}"])
        end
        error_tag = DoubleheaderWeb.ErrorHelpers.error_tag(form, field)
        [input_tag, icon_tag, icon_error, error_tag || ""]
      end]
    end
  end

  defp icon_class(state) do
    case state do
      # The form was not yet submitted
      "is-success" -> "fas fa-check"
      # The field is blank
      "is-danger" -> "fas fa-exclamation-triangle"
      # The field was filled successfully
      _ -> ""
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      is_nil(form.source.action) -> ""
      # The field is blank
      input_value(form, field) in ["", nil] -> ""
      # The field has error
      form.errors[field] -> "is-danger"
      # The field was filled successfully
      true -> "is-success"
    end
  end

  defp input(type, form, field, icon, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
