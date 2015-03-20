module Chargeover

  class Resource

    attr_accessor :config

    class << self
      attr_accessor :prefix

      def base_url
        Chargeover.base_url + self.prefix
      end

      def find_by_external_key(external_key)
        response = get(base_url + "?where=external_key:EQUALS:#{external_key}")
        new(response.first)
      end

      def find(id)
        response = get(base_url + "/#{id}")
        new(response)
      end

      def all
        response = get(base_url)
        objs = []
        response.each do |obj|
          objs << new(obj)
        end
        objs
      end

      def create(attributes)
        response = post(base_url, attributes)
        self.find(response['id'])
      end

      def get(url)
        conn = Faraday.new(url)
        conn.basic_auth(Chargeover.public_key, Chargeover.private_key)
        response = conn.get

        # handle server down errors without parsing the response body
        raise_error(response.status) if response.status == 500

        attributes = JSON.parse(response.body)

        if successful_response?(response)
          attributes['response']
        else
          raise_error(response.status, attributes['message'])
        end
      end

      def post(url, payload)
        conn = Faraday.new(url)
        conn.basic_auth(Chargeover.public_key, Chargeover.private_key)
        response = conn.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = payload.to_json
        end

        # handle server down errors without parsing the response body
        raise_error(response.status) if response.status == 500

        attributes = JSON.parse(response.body)
        attributes['response']

        if successful_response?(response)
          attributes['response']
        else
          raise_error(response.status, attributes['message'])
        end
      end

      def put(url, payload)
        conn = Faraday.new(url)
        conn.basic_auth(Chargeover.public_key, Chargeover.private_key)
        response = conn.put do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = payload.to_json
        end

        # handle server down errors without parsing the response body
        raise_error(response.status) if response.status == 500

        attributes = JSON.parse(response.body)
        attributes['response']

        if successful_response?(response)
          attributes['response']
        else
          raise_error(response.status, attributes['message'])
        end
      end

      def delete(url)
        conn = Faraday.new(url)
        conn.basic_auth(Chargeover.public_key, Chargeover.private_key)
        response = conn.delete

        # handle server down errors without parsing the response body
        raise_error(response.status) if response.status == 500

        attributes = JSON.parse(response.body)
        attributes['response']

        if successful_response?(response)
          attributes['response']
        else
          raise_error(response.status, attributes['message'])
        end
      end

      def successful_response?(response)
        (response.status == 200 ||
            response.status == 201 ||
            response.status == 202)
      end

      def raise_error(status, message = nil)
        raise ChargeoverException.new(status, message)
      end
    end

    def initialize(attributes)
      attributes.each_key do |attribute|
        if attribute.end_with?('datetime')
          if attributes[attribute] != nil
            send("#{attribute}=", DateTime.parse(attributes[attribute]))
          end
        else
          send("#{attribute}=", attributes[attribute])
        end
      end
    end

    def base_url
      self.class.base_url
    end

    def put(url, payload)
      Chargeover::Resource.put(url, payload)
    end

  end

end