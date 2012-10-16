require 'handle-server/client'

module HandleServer

  class URLClient < Client

    def retrieve_url(handle)
      response = self.retrieve(handle)
      if url = extract_url(response)
        return url
      else
        raise URLNotFound
      end
    end

    def create_from_url(handle, url)
      self.create(handle, {:url => url})
    end

    def update_url(handle, url)
      self.update(handle, {:url => url})
    end

    protected

    def extract_url(response)
      values = response['response']['handle_value']
      values = [values] unless values.is_a? Array
      url_hash = values.detect do |hv|
        hv['type'] == 'URL'
      end
      return nil unless url_hash
      return url_hash['data']
    rescue
      return nil
    end

  end
end

