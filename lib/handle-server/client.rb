require 'base64'
require 'httparty'

module HandleServer
  class HandleNotFound < Exception ; end
  class URLNotFound < Exception ; end
  class MalformedURI < Exception ; end
  class Unauthorized < Excpetion ; end
  class BadGateway < Exception ; end
  class UnexpectedRepsonse < Exception ; end

  class Client < Object
    attr_accessor :user_name, :password, :host, :port

    def initialize(attr = {})
      self.password = attr[:password] || ''
      self.user_name = attr[:user_name]
      self.host = attr[:host]
      self.port = attr[:port] || 80
    end

    def retrieve_url(handle)
      response = HTTParty.get(full_url(handle))
      case response.code
      when 404
        raise HandleNotFound
      when 200
        if url = extract_url(response)
          return url
        else
          raise URLNotFound
        end
      else
        raise UnexpectedResponse
      end
    end

    def create(handle, url)
      response = HTTParty.post(full_url(handle), :query => query(url),
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

    def update(handle, url)
      response = HTTParty.put(full_url(handle), :query => query(url),
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

    def extract_url(response)
      values = response.parsed_response['response']['handle_value']
      values = [values] unless values.is_a? Array
      url_hash = values.detect do |hv|
        hv['type'] == 'URL'
      end
      return nil unless url_hash
      return url_hash['data']
    rescue
      return nil
    end

    def query(url)
      {:url => url}
    end

    def auth_hash
      {:username => user_name, :password => password}
    end
    
  end
end

