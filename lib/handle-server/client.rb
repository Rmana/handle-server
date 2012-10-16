require 'httparty'
require 'handle-server/exceptions'

module HandleServer

  class Client < Object
    attr_accessor :user_name, :password, :host, :port

    def initialize(attr = {})
      self.password = attr[:password] || ''
      self.user_name = attr[:user_name]
      self.host = attr[:host]
      self.port = attr[:port] || 80
    end

    def exists?(handle)
      retrieve_raw(handle)
      return true
    rescue HandleNotFound
      return false
    end

    def retrieve_raw(handle)
      response = HTTParty.get(full_url(handle))
      case response.code
        when 404
          raise HandleNotFound
        when 200
          return response
        else
          raise UnexpectedResponse
      end
    end

    def retrieve(handle)
      return retrieve_raw(handle).parsed_response
    end

    def create(handle, query_params)
      response = HTTParty.post(full_url(handle), :query => query_params,
                               :basic_auth => auth_hash)
      case response.code
        when 201
          return response.headers['location']
        when 400
          raise MalformedURI
        when 401
          raise Unauthorized
        when 502
          raise BadGateway
        else
          raise UnexpectedResponse
      end
    end

    def update(handle, query_params)
      response = HTTParty.put(full_url(handle), :query => query_params,
                              :basic_auth => auth_hash)
      case response.code
        when 201
          return response.headers['location']
        when 400
          raise MalformedURI
        when 401
          raise Unauthorized
        when 502
          raise BadGateway
        else
          raise UnexpectedResponse
      end
    end

    def delete(handle)
      response = HTTParty.delete(full_url(handle), :basic_auth => auth_hash)
      case response.code
        when 204
          return true
        when 401
          raise Unauthorized
        when 502
          raise BadGateway
        else
          raise UnexpectedResponse
      end
    end

    protected

    def base_url
      "http://#{host}:#{port}"
    end

    def base_path
      "/handle-admin/handle"
    end

    def path(handle)
      "#{base_path}/#{handle}"
    end

    def full_url(handle)
      "#{base_url}#{base_path}/#{handle}"
    end

    def auth_hash
      {:username => user_name, :password => password}
    end

  end
end
