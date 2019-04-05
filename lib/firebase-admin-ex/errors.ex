defmodule FirebaseAdminEx.Errors.ApiError do
  defexception [:reason]

  def exception(reason), do: %__MODULE__{reason: reason}

  def message(%__MODULE__{reason: reason}), do: "FirebaseAdminEx::ApiError - #{reason}"
end

defmodule FirebaseAdminEx.Errors.ApiLimitExceeded do
  defexception [:reason]

  def exception(reason), do: %__MODULE__{reason: reason}

  def message(%__MODULE__{reason: reason}), do: "FirebaseAdminEx::ApiLimitExceeded - #{reason}"
end

defmodule FirebaseAdminEx.Errors.ValidationError do
  defexception [:reason]

  def exception(reason), do: %__MODULE__{reason: reason}

  def message(%__MODULE__{reason: reason}), do: "FirebaseAdminEx::ValidationError - #{reason}"
end

defmodule FirebaseAdminEx.Errors.ParseError do
  defexception [:status_code, :message]

  def exception(status_code, message), do: %__MODULE__{status_code: status_code, message: message}

  def message(%__MODULE__{status_code: status_code, message: message}),
    do: "FirebaseAdminEx::ParseError - Status: #{status_code}, Message: #{message}"
end
