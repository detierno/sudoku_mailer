module ApplicationCable
  class Connection < ActionCable::Connection::Base
    #identified_by :conn_id

    #def connect
      #self.conn_id = find_connection_id
    #end

    #private

      #def find_connection_id
        #cookies.encrypted[:conn_id]
      #end

  end
end
