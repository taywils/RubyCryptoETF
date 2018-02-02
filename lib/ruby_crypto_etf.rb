%w(bigdecimal coinbase/wallet).each do |library|
  require "#{library}"
end

%w(version).each do |file|
  require "ruby_crypto_etf/#{file}"
end

%w(coin exchange).each do |file|
  require "ruby_crypto_etf/models/#{file}"
end
