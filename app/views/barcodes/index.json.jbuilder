json.array!(@barcodes) do |barcode|
  json.extract! barcode, :code, :user_id
  json.url barcode_url(barcode, format: :json)
end