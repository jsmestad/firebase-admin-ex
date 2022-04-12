defmodule FirebaseAdminEx.Request do
  use Tesla

  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Headers, [{"content-type", "application/json"}])

  def request!(method, url, body, headers) do
    request!(method: method, url: url, body: body, headers: Map.to_list(headers))
  end

  def request(method, url, body, headers) do
    request(method: method, url: url, body: body, headers: Map.to_list(headers))
  end
end
