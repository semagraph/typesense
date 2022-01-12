defmodule TypesenseTest do
  use ExUnit.Case
  #doctest Typesense

  alias Typesense

  #use ExUnit.Case, async: false
  ExUnit.configure(seed: 0)

  setup_all do
    client = Typesense.client("secret")

    {:ok, client: client}
  end

  test "creates a 'companies' collection", state do
    client = state[:client]

    %{"name" => name} = Typesense.Collections.create(client, %{
      name: "companies",
      fields: [
        %{name: "company_name", type: "string", facet: false},
        %{name: "num_employees", type: "int32", facet: false},
        %{name: "country", type: "string", facet: true}
      ],
      default_sorting_field: "num_employees"
    })

    expected = %{
      "created_at" => 1641546402,
      "default_sorting_field" => "num_employees",
      "fields" => [
        %{
          "facet" => false,
          "index" => true,
          "name" => "company_name",
          "optional" => false,
          "type" => "string"
        },
        %{
          "facet" => false,
          "index" => true,
          "name" => "num_employees",
          "optional" => false,
          "type" => "int32"
        },
        %{
          "facet" => true,
          "index" => true,
          "name" => "country",
          "optional" => false,
          "type" => "string"
        }
      ],
      "name" => "companies",
      "num_documents" => 0,
      "symbols_to_index" => [],
      "token_separators" => []
    }

    assert name == "companies"
  end

  test "deletes the 'companies' collection", state do
    client = state[:client]

    %{"name" => name} = Typesense.Collections.drop(client, "companies")

    %{
      "created_at" => 1641546402,
      "default_sorting_field" => "num_employees",
      "fields" => [
        %{
          "facet" => false,
          "index" => true,
          "name" => "company_name",
          "optional" => false,
          "type" => "string"
        },
        %{
          "facet" => false,
          "index" => true,
          "name" => "num_employees",
          "optional" => false,
          "type" => "int32"
        },
        %{
          "facet" => true,
          "index" => true,
          "name" => "country",
          "optional" => false,
          "type" => "string"
        }
      ],
      "name" => "companies",
      "num_documents" => 1,
      "symbols_to_index" => [],
      "token_separators" => []
    }

    assert name == "companies"
  end
end
