# frozen_string_literal: true

module Arel # :nodoc: all
  module Nodes
    class RowNumber < Arel::Nodes::Node
      attr_accessor :orders, :partitions

      def initialize
        @orders = []
        @partitions = []
      end

      def order(expr)
        @orders.concat expr unless expr.blank?
        self
      end

      def partition(column)
        @partitions.push(column)
        self
      end

      def initialize_copy(other)
        super
        @orders = @orders.map { |x| x.clone }
        @partitions = @partitions.map { |x| x.clone }
      end

      def hash
        [@orders, @partitions].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.orders == other.orders &&
          self.partitions == other.partitions
      end
      alias :== :eql?
    end
  end
end
