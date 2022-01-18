defmodule Typesense do
  @moduledoc "README.md"
  |> File.read!()
  |> String.split("<!-- MDOC !-->")
  |> Enum.fetch!(1)

  use Tesla, only: [:get, :post, :delete, :patch], docs: false

  @api_url Application.fetch_env!(:typesense, :api_url)
  @api_key Application.fetch_env!(:typesense, :api_key)

  plug Tesla.Middleware.BaseUrl, @api_url
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.FormUrlencoded
  plug Tesla.Middleware.Headers, [{"X-TYPESENSE-API-KEY", @api_key}]

  def get(path), do: Tesla.get(path)
  def get(path, args), do: Tesla.get(path, args)
  def post(path, args, opts \\ []), do: Tesla.post(path, args, opts)
  def delete(path), do: Tesla.delete(path)
  def delete(path, args), do: Tesla.delete(path, args)
  def patch(path, args, opts \\ []), do: Tesla.patch(path, args, opts)

  @doc """
  Returns Typesense instance health status.
  """
  def health do
    case Tesla.get("/health") do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end
end
