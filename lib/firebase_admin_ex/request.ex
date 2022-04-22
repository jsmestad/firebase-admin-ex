defmodule FirebaseAdminEx.Request do
  # use Tesla

  # plug(Tesla.Middleware.JSON)
  # plug(Tesla.Middleware.Headers, [{"content-type", "application/json"}])

  @spec request!(Tesla.Client.t(), Tesla.Env.method(), Tesla.Env.url(), Tesla.Env.body()) ::
          Tesla.Env.t() | no_return()
  def request!(%Tesla.Client{} = client, method, url, body) do
    Tesla.request!(client, method: method, url: url, body: body)
  end

  @spec request(Tesla.Client.t(), Tesla.Env.method(), Tesla.Env.url(), Tesla.Env.body()) ::
          Tesla.Env.result()
  def request(%Tesla.Client{} = client, method, url, body) do
    Tesla.request(client, method: method, url: url, body: body)
  end

  # build dynamic client based on runtime arguments
  @spec client(String.t()) :: Tesla.Client.t()
  def client(token) do
    middleware = [
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", "Bearer " <> token}]}
    ]

    Tesla.client(middleware)
  end
end
