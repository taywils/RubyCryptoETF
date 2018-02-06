# RubyCryptoETF

RubyCryptoETF is a Ruby implementation of a Crypto ETF inspired by the original
Javascript version developed by [benmarten/CryptoETF].

## Status
Version 0.1.0

### Purpose

1. To provide a modular Ruby gem that will eventually be used for a either an online account based ETF or crypto asset brokerage.
2. A command-line tool to enable rapid trading and purchasing across multiple crypto asset exchanges via their public APIs

## Integrations

Below is the current status for supported crypto asset exchange integrations

[x] Coinbase via [coinbase/coinbase-ruby]

[x] Binance via [Jakenberg/binance-ruby]

[x] CoinMarketCap

[ ] Gemini

[ ] MyEtherScan

[ ] Poloniex

[ ] GDAX

[ ] Bittrex

## Roadmap

[ ] Capture and display current investment portfolio

[ ] Interactive CLI mode

[ ] Export formats for web and csv

[ ] Ability to place buy/sell orders

[ ] Websocket integration for exchanges which support websockets

[ ] Some kind of crypto news crawler integration with Mechanize or Nokogiri

[ ] Rails compatibility

## License
Apache License, see LICENSE.md

[benmarten/CryptoETF]: https://github.com/benmarten/CryptoETF
[coinbase/coinbase-ruby]: https://github.com/coinbase/coinbase-ruby
[Jakenberg/binance-ruby]: https://github.com/Jakenberg/binance-ruby
