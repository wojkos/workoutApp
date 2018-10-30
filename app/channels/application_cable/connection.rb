module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identyfied_by :current_user
    def connect
      set.current_user = find_current_user
    end


    def find_current_user
      if current_user = User.find_by(id: cookies.signal['user_id'])
        current_user
      else
        reject_unauthorizeed_connection
      end
    end
  end
end
