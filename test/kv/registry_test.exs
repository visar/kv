defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  alias KV.{Bucket, Registry}

  setup do
    registry = start_supervised!(Registry)

    {:ok, registry: registry}
  end

  test "spawn buckets", %{registry: registry} do
    Registry.lookup(registry, "shopping")

    Registry.create(registry, "shopping")
    assert {:ok, bucket} = Registry.lookup(registry, "shopping")

    Bucket.put(bucket, "milk", 1)
    assert Bucket.get(bucket, "milk") == 1
  end

  test "remove buckets on exit", %{registry: registry} do
    Registry.create(registry, "shopping")
    {:ok, bucket} = Registry.lookup(registry, "shopping")
    Agent.stop(bucket)

    assert Registry.lookup(registry, "shopping") == :error
  end
end
