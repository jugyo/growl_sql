require 'ruby-growl'

module ActiveRecord::ConnectionAdapters
  class AbstractAdapter
    GROWL = Growl.new "localhost", "growl_sql", ["growl_sql"]

    def log_info_with_feature(sql, name, runtime)
      if /^\s*(insert|update|delete)/i =~ sql
        Thread.start($1, sql, 0, false) { |title, message, priority, sticky|
          GROWL.notify "growl_sql", title, message, priority, sticky
        }
      end
      log_info_without_feature(sql, name, runtime)
    end

    alias_method_chain :log_info, :feature

  end
end
