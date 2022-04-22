defmodule FirebaseAdminEx.Messaging do
  alias FirebaseAdminEx.{Request, Response}
  alias FirebaseAdminEx.Messaging.Message

  @fcm_endpoint "https://fcm.googleapis.com/v1"

  @type result :: {:ok, term()} | {:error, Tesla.Env.result() | binary()}
  @type result! :: term() | no_return()

  @doc """
  send/1 the same as send/2 with default account.
  """
  @spec send(%Message{}) :: result()
  def send(message) do
    {:ok, project_id} = Goth.Config.get(:project_id)
    {:ok, token} = Goth.fetch(FirebaseAdminEx.Goth)

    send(project_id, token.token, message)
  end

  @spec send!(%Message{}) :: result!()
  def send!(message) do
    {:ok, project_id} = Goth.Config.get(:project_id)
    {:ok, token} = Goth.fetch(FirebaseAdminEx.Goth)

    send!(project_id, token.token, message)
  end

  @doc """
  The send/2 function retrieves auth token using service account and then makes an API call to the
  firebase messaging `send` endpoint with the
  and message attributes.
  """
  @spec send(String.t(), %Message{}) :: result()
  def send(account, message) do
    {:ok, project_id} = Goth.Config.get(account, :project_id)
    {:ok, token} = Goth.fetch(FirebaseAdminEx.Goth)

    send(project_id, token.token, message)
  end

  @spec send!(String.t(), %Message{}) :: result!()
  def send!(account, message) do
    {:ok, project_id} = Goth.Config.get(account, :project_id)
    {:ok, token} = Goth.fetch(FirebaseAdminEx.Goth)

    send!(project_id, token.token, message)
  end

  @doc """
  send/3 Is the same as send/2 except the user can supply their own auth token
  """
  @spec send(String.t(), String.t(), %Message{}) :: result()
  def send(project_id, oauth_token, message) do
    with {:ok, _} <- Message.validate(message),
         {:ok, response} <- request(project_id, message, oauth_token) do
      Response.parse(response)
    end
  end

  @spec send!(String.t(), String.t(), %Message{}) :: result!()
  def send!(project_id, oauth_token, message) do
    _message = Message.validate!(message)
    response = request!(project_id, message, oauth_token)
    Response.parse!(response)
  end

  defp request(project_id, message, oauth_token) do
    oauth_token
    |> Request.client()
    |> Request.request(:post, send_url(project_id), %{message: message})
  end

  defp request!(project_id, message, oauth_token) do
    oauth_token
    |> Request.client()
    |> Request.request!(:post, send_url(project_id), %{message: message})
  end

  defp send_url(project_id) do
    "#{@fcm_endpoint}/projects/#{project_id}/messages:send"
  end
end
