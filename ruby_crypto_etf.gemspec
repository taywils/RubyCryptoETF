lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ruby_crypto_etf/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby_crypto_etf'
  spec.version = '0.1.0'
  spec.authors = ["Demetrious Wilson"]
  spec.email = ["demetriouswilson@gmail.com"]

  spec.summary = "A Ruby implementation of CryptoETF"
  spec.homepage = "https:/github.com/taywils/ruby_crypto_etf"
  spec.license = "Apache-2.0"

  spec.require_paths = ["lib"]
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '> 1.9.3'

  spec.version = RubyCryptoETF::VERSION

  spec.add_development_dependency "bundler", "~> 1.16", '>= 1.16.1'
  spec.add_development_dependency "rspec", "~> 3.7", '>= 3.7.0'
  spec.add_development_dependency "pry-byebug", "~> 3.5", '>= 3.5.1'

  spec.add_runtime_dependency "bigdecimal", "~> 1.3", ">= 1.3.4"
  spec.add_runtime_dependency "faraday", "~> 0.14", ">= 0.14.0"
  spec.add_runtime_dependency "binance-ruby", "~> 0.1", ">= 0.1.8"
  spec.add_runtime_dependency "coinbase", "~> 4.1", ">= 4.1.0"
  spec.add_runtime_dependency "monetize", "~> 1.7", ">= 1.7.0"
  spec.add_runtime_dependency "terminal-table", "~> 1.8", ">= 1.8.0"
end

