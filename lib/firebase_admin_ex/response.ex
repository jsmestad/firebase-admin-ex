defmodule FirebaseAdminEx.Response do
  alias FirebaseAdminEx.Errors.ParseError

  def parse(%Tesla.Env{} = response) do
    case response do
      %Tesla.Env{status: 200, body: body} ->
        body

      %Tesla.Env{status: status, body: %{"error" => %{"message" => error_message}}} ->
        {:error, "#{status} - #{error_message}"}
    end
  end

  def parse!(%Tesla.Env{} = response) do
    case response do
      %Tesla.Env{status: 200, body: body} ->
        body

      %Tesla.Env{status: status, body: %{"error" => %{"message" => error_message}}} ->
        raise ParseError, status_code: status, message: error_message
    end
  end
end
