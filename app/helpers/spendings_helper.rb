# frozen_string_literal: true

module SpendingsHelper
  def display_amount(amount)
    "Total: #{amount / 100.0}"
  end

  def filter(filter)
    if filter == 'amount'
      'sorted '
    elsif filter == 'category'
      "#{params[:category].singularize} "
    else
      ''
    end
  end

  def build_params(uuid, params_hash)
    result = {uuid: uuid}

    if params_hash[:filter]
      result[:filter] = params_hash[:filter]
    end
    if params_hash[:category]
      result[:category] = params_hash[:category]
    end

    result
  end
end
