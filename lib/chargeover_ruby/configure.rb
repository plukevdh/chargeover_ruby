module Chargeover
  class << self
    attr_accessor :subdomain, :public_key, :private_key, :base_url, :domain

    def configure
      yield self
      self.domain       = domain      || "chargeover.com"
      self.subdomain    = subdomain   || "test"
      self.base_url     = base_url    || "https://#{subdomain}.#{domain}/api/v3"
    end

  end
end