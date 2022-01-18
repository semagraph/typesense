# Typesense

<!-- MDOC !-->

A lightweight [Typesense](https://typesense.org) client for Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `typesense` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:typesense, "~> 0.2.0"}
  ]
end
```

## Configuration

```elixir
# config/config.exs
config :typesense,
  api_url: "https://search.example.com",
  api_key: "secret"
```

## Usage

To create a [Typesense Collection](https://typesense.org/docs/latest/api/collections.html):

```elixir
schema = %{
  name: "companies",
  fields: [
    %{name: "company_name", type: "string"},
    %{name: "num_employees", type: "int32"},
    %{name: "country", type: "string", facet: true},
  ],
  default_sorting_field: "num_employees"
}

Typesense.Collections.create(schema)
```

To index a [Typesense Document](https://typesense.org/docs/latest/api/documents.html):

```elixir
document = %{
  id: "124",
  company_name: "Stark Industries",
  num_employees: 5215,
  country: "USA"
}

Typesense.Documents.create(collection, document)
```

