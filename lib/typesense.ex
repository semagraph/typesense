defmodule Typesense do
  @moduledoc "README.md"
  |> File.read!()
  |> String.split("<!-- MDOC !-->")
  |> Enum.fetch!(1)

  use Tesla

  require Logger

  @api_url Application.get_env(:typesense, :api_url, "http://localhost:8108")
  @api_key Application.get_env(:typesense, :api_key, "")

  plug Tesla.Middleware.BaseUrl, @api_url
  plug Tesla.Middleware.Headers, [{"X-TYPESENSE-API-KEY", @api_key}]
  plug Tesla.Middleware.JSON

  @doc """
  Make a call to the Typesense API.
  """
  def get(path), do: Tesla.get(path)
  def get(path, args), do: Tesla.get(path, args)
  def post(path, args, opts \\ []), do: Tesla.post(path, args, opts)
  def delete(path, args), do: Tesla.delete(path, args)
  def update(path, args), do: Tesla.put(path, args)

  @doc """
  Returns Typesense instance health status
  """
  def health do
    case Tesla.get("/health") do
      {:ok, env} ->
        {:ok, env.body}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
