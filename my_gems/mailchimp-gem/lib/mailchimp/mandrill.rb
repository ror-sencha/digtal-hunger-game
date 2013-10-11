if defined?(ActionMailer)
  require File.join(File.dirname(__FILE__), 'handlers', 'mandrill_delivery_handler')
end

module Mailchimp
  class Mandrill < Base
    parser MailchimpPsuedoJSONParser

    def initialize(api_key = nil, default_parameters = {})
      super(api_key, {
        :key => api_key,
        :options => {
          :track_opens => true,
          :track_clicks => true
        }
      }.merge(default_parameters))
    end

    def valid_api_key?(*args)
      '"PONG!"' == self.users_ping
    end

    def call(method, params = {})
      puts "===in call method....#{method}--"
      super("#{base_api_url}#{method}",@default_params.merge(params))
    end

    def method_missing(method, *args)
      match = method.to_s.match(/([a-z]*)_([a-z]*)_?([a-z]*)/)
      method = "#{match[1]}/#{match[2]}#{match[3] == '' ? "" : "-"+match[3]}"
      call(method, *args)
    end

    #def messages_send_template(data)
    #   puts "===in messages send template...#{data}"
    #end

    class << self
      attr_accessor :api_key

      def method_missing(sym, *args, &block)
        new(self.api_key).send(sym, *args, &block)
      end
    end

    private

      def base_api_url
        "http://mandrillapp.com/api/1.0/"
      end
  end
end
