# The growl_sql is a rails plugin that output sql log to growl.
begin
  require 'ruby-growl'
  module ActiveRecord::ConnectionAdapters
    class AbstractAdapter
      GROWL = Growl.new "localhost", "growl_sql", ["growl_sql"]
      protected
      def log_info_with_feature(sql, name, runtime)
        if /(insert|update|delete)/i =~ sql
          GROWL.notify "growl_sql", "growl_sql", sql
        end
        log_info_without_feature(sql, name, runtime)
      end
      alias_method_chain :log_info, :feature
    end
  end
rescue LoadError => e
end
