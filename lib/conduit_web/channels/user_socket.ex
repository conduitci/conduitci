defmodule ConduitWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  # channel "room:*", ConduitWeb.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  @doc false
  def connect(_params, socket) do
    {:ok, socket}
  end

  @doc false
  def id(_socket), do: nil
end
