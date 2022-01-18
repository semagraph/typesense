defmodule Typesense.CollectionsTest do
  use ExUnit.Case

  @collection "[tests] companies"

  @schema %{
    name: @collection,
    fields: [
      %{name: "company_name", type: "string"},
      %{name: "num_employees", type: "int32"},
      %{name: "country", type: "string", facet: true}
    ],
    default_sorting_field: "num_employees"
    }

  setup_all do
    Typesense.Collections.create(@schema)

    on_exit(fn ->
      Typesense.Collections.delete(@collection)
    end)
  end

  describe "create/1" do
    setup do
      Typesense.Collections.delete(@collection)

      on_exit(fn ->
        Typesense.Collections.create(@collection)
      end)
    end

    test "success: creates a new collection" do
      expected = %{"name" => @collection}
      actual = Typesense.Collections.create(@schema)

      assert {:ok, expected} = actual
    end

    test "fail: create a new collection with existing name" do
      pre = Typesense.Collections.create(@schema)
      actual = Typesense.Collections.create(@schema)

      assert {:error, reason} = actual
    end
  end

  describe "retrieve/1" do
    test "success: retrieves a collection" do
      expected = %{"name" => @collection}
      actual = Typesense.Collections.retrieve(@collection)

      assert {:ok, expected} = actual
    end

    test "fail: retrieve a non-existing collection" do
      expected = %{"name" => "[non-existing-collection]"}
      actual = Typesense.Collections.retrieve("[non-existing-collection]")

      assert {:error, _reason} = actual
    end
  end

  describe "list/0" do
    test "success: retrieves all collections" do
      expected = [ %{"name" => @collection} ]
      actual = Typesense.Collections.list()

      assert {:ok, expected} = actual
    end
  end

  describe "delete/1" do
    setup do
      on_exit(fn ->
        Typesense.Collections.create(@schema)
      end)
    end

    test "success: drop a collection" do
      expected = %{"name" => @collection}
      actual = Typesense.Collections.delete(@collection)

      assert {:ok, expected} = actual
    end

    test "fail: drop a non-existing collection" do
      actual = Typesense.Collections.delete(@collection <> "[non-existing]")

      assert {:error, _reason} = actual
    end
  end
end
