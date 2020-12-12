defmodule Typesense do
  @moduledoc """
  Documentation for `Typesense`.
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://localhost:8108"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}, {"X-TYPESENSE-API-KEY", "some-api-key"}]
  plug Tesla.Middleware.JSON

  @doc """
  Returns instance health status.

  ## Examples
  iex> Typesense.health()
  :ok
  """
  def health do
    get("/health")
  end

end
