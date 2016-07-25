require "frest/memory_store/version"
require 'frest/core'
require_relative 'tap_h'

module Frest
  module MemoryStore
    include TapH

    extend self

    @@store = Hash.new(Frest::Core::NotFound)

    tap_h def set(
        id:,
        content:,
        c_:,
        **_)

      hash = final_hash(**c_)

      hash[id] = content
    end

    tap_h def delete(
        id:,
        c_:,
        **_)

      hash = final_hash(**c_)

      hash.delete(id)
    end


    tap_h def get(
        id:,
        c_:,
        **_)

      hash = final_hash(**c_)

      hash[id]
    end


    private

    def uuid
      SecureRandom.uuid
    end

    def final_hash(
      store_id: 'default',
      branch_id: 'default',
      **_
    )

      @@store[branch_id] = Hash.new{Frest::Core::NotFound} if @@store[branch_id] == Frest::Core::NotFound
      @@store[branch_id][store_id] = Hash.new{Frest::Core::NotFound} if @@store[branch_id][store_id] == Frest::Core::NotFound
      @@store[branch_id][store_id]
    end
  end
end
