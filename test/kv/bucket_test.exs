defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  alias KV.Bucket

  setup do
    bucket = start_supervised!(Bucket)

    {:ok, bucket: bucket}
  end

  # @tag :pending
  test ".get gets values by key", %{bucket: bucket} do
    refute Bucket.get(bucket, "milk")

    Bucket.put(bucket, "milk", 3)
    assert Bucket.get(bucket, "milk") == 3
  end

  test ".delete returns the current value by key and deletes it", %{bucket: bucket} do
    amount = Bucket.delete(bucket, "milk")
    refute amount

    Bucket.put(bucket, "milk", 3)
    amount = Bucket.delete(bucket, "milk")
    assert amount == 3
  end
end
