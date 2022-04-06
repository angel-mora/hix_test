# frozen_string_literal: true

class EnableExtensionUuidOssp < ActiveRecord::Migration[6.1]
  def change
    enable_extension('uuid-ossp')
  end
end
