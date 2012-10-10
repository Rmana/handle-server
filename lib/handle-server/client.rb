require 'handle-server/handle'
require 'base64'

module HandleServer
  class Client < Object
    attr_accessor :user_name, :base_64_password

    def initialize(attr = {})
      
    end

    def password=(password)
      self.base_64_password = Base64.urlsafe_encode64(password)
    end

    def get_handle(handle)
      Handle.new(:handle => handle)
    end
    
  end
end
