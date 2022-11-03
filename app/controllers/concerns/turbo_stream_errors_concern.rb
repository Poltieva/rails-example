require "active_support/concern"

module TurboStreamErrorsConcern
  extend ActiveSupport::Concern

  def stream_errors(error_message)
    [
      turbo_stream.replace(
        "messagesContainer",
        partial: "layouts/flash",
        locals: { flash: {error: error_message } }
      )
    ]
  end
end