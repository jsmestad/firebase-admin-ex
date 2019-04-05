defmodule FirebaseAdminEx.Response do
  alias FirebaseAdminEx.Errors.ParseError

  @spec parse!(%HTTPoison.Response{}) :: term() | no_return()
  def parse!(%HTTPoison.Response{} = response) do
    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        Jason.decode!(body)

      %HTTPoison.Response{status_code: status_code, body: body} ->
        error_message = get_message(Jason.decode!(body))
        raise ParseError, [status_code: status_code, message: error_message]
    end
  end

  @spec parse(%HTTPoison.Response{}) :: {:ok, term()} | {:error, binary() | Jason.DecodeError.t}
  def parse(%HTTPoison.Response{} = response) do
    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        Jason.decode(body)

      %HTTPoison.Response{status_code: status_code, body: body} ->
        with {:ok, decoded} <- Jason.decode(body) do
          error_message = get_message(decoded)
          {:error, "#{status_code} - #{error_message}"}
        end
    end
  end

  defp get_message(body) do
    body
    |> Map.get("error", %{})
    |> Map.get("message")
  end
end
