%w(bigdecimal coinbase/wallet faraday binance-ruby monetize terminal-table csv json).each do |library|
  require "#{library}"
end

%w(version).each do |file|
  require "ruby_crypto_etf/#{file}"
end

%w(coin exchange portfolio).each do |file|
  require "ruby_crypto_etf/models/#{file}"
end

%w(binance coinbase).each do |file|
  require "ruby_crypto_etf/integrations/#{file}"
end

%w(base csv terminal web).each do |file|
  require "ruby_crypto_etf/displays/#{file}"
end

%w(coin_market_cap).each do |file|
  require "ruby_crypto_etf/markets/#{file}"
end
