defmodule Typesense.Http do
  @moduledoc false
  @type env :: Tesla.Env.t()

  @status_codes [
    %{status: 400, message: "Bad Request - The request could not be understood due to malformed syntax."},
    %{status: 401, message: "Unauthorized - Your API is incorrect."},
    %{status: 403, message: "Forbidden - Your request is forbidden."},
    %{status: 404, message: "Not Found - The requested resource could not be found."},
    %{status: 409, message: "Conflict - A resource with this id already exists."},
    %{status: 422, message: "Unprocessable Entity - Request is well-formed, but cannot be processed."},
    %{status: 500, message: "Internal Service Error - An unexpected error occurred while processing your request."},
    %{status: 503, message: "Service Unavailable - Unable to connect to the service."}
  ]

  def handle_response(env) do
    case Enum.find(@status_codes, &(&1.status == env.status)) do
      nil -> {:ok, env.body}
      code -> {:error, code.message}
    end
  end

end
