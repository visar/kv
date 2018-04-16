defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])

    {:ok, bucket: bucket}
  end

  # @tag :pending
  test ".get gets values by key", %{bucket: bucket} do
    refute KV.Bucket.get(bucket, "milk")

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end
