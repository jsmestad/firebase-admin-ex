defmodule FirebaseAdminEx do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      goth_spec()
    ]

    opts = [strategy: :one_for_one, name: FirebaseAdminEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp goth_spec do
    name = FirebaseAdminEx.Goth

    case Application.fetch_env(:firebase_admin_ex, :credentials) do
      {:ok, credentials} ->
        source =
          {:service_account, Jason.decode!(credentials),
           [scopes: ["https://www.googleapis.com/auth/firebase.messaging"]]}

        {Goth, name: name, source: source}

      :error ->
        %{id: name, start: {Function, :identity, [:ignore]}}
    end
  end
end
