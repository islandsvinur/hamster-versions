require 'hamster/hash'

module Hamster
  module Versions
    class Ref
      attr_reader :older, :newer, :deref

      def initialize(ref=Hamster::Hash.empty, older=nil)
        @deref = ref
        @older = older
      end

      def dosync(changed_value)
        @newer = Ref.new(@deref.merge(changed_value), self)
      end

      def newest
        newest = self
        newest = newest.newer until newest.newer.nil?
        newest
      end

      def oldest
        oldest = self
        oldest = oldest.older until oldest.older.nil?
        oldest
      end
    end
  end
end
