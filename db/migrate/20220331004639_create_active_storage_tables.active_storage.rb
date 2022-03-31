# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[7.0]
  def change
    create_table :active_storage_blobs, id: :uuid do |t|
      t.string(:key, null: false)
      t.string(:filename, null: false)
      t.string(:content_type)
      t.text(:metadata)
      t.bigint(:byte_size, null: false)
      t.string(:checksum, null: false)
      t.datetime(:created_at, null: false)

      t.index([:key], unique: true)
    end

    create_table :active_storage_attachments, id: :uuid do |t|
      t.string(:name, null: false)
      t.references(:record, null: false, polymorphic: true, index: false, type: :uuid)
      t.references(:blob, null: false, type: :uuid)

      t.datetime(:created_at, null: false)

      t.index(%i[record_type record_id name blob_id], name: :index_active_storage_attachments_uniqueness, unique: true)
      t.foreign_key(:active_storage_blobs, column: :blob_id, name: :active_storage_attachments_active_storage_blobs_id)
    end
  end
end
