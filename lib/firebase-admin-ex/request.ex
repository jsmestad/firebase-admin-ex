defmodule FirebaseAdminEx.Request do
  use HTTPoison.Base

  @default_headers %{"Content-Type" => "application/json"}
  @default_options Application.get_env(:firebase_admin_ex, :default_options, [])

  def process_request_headers(headers) when is_map(headers) do
    @default_headers
    |> Map.merge(headers)
    |> Enum.into([])
  end

  def process_request_headers(_), do: @default_headers

  def process_request_body(body) when is_map(body) do
    Jason.encode!(body)
  end

  def process_request_body(body), do: body

  def process_request_options(_), do: @default_options
end
