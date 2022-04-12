defmodule FirebaseAdminExTest do
  use ExUnit.Case

  alias FirebaseAdminEx.{Messaging, Messaging.Message}

  test "it uses tesla correctly" do
    {:error, message} = Messaging.send("project_id", "nanan", %Message{})

    assert String.contains?(message, "OAuth")
  end
end
