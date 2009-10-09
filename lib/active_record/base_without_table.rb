module ActiveRecord
  class BaseWithoutTable < Base
    self.abstract_class = true
    
    def create_or_update_without_callbacks
      self.new_record? ? create : update
    end
    def create_without_callbacks
      @new_record = false if answer = errors.empty?
      answer
    end
    def update_without_callbacks
      @new_record = false if answer = errors.empty?
      answer
    end
    def destroy_without_callbacks
      errors.empty?
    end
    
    class << self
      def columns()
        @columns ||= []
      end
      
      def column(name, sql_type = nil, default = nil, null = true)
        columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
        reset_column_information
      end
      
      # Reset everything, except the column information
      def reset_column_information
        columns = @columns
        super
        @columns = columns
      end
    end
  end
end
