# Nfe

NFe gem validates XML NFe used the site https://www.sefaz.rs.gov.br and generates Danfe used the site http://freenfe.com.br/danfe

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nfe-xml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nfe-xml

## Usage

On terminal you can use nfe like this:
```ruby
  require 'nfe'

  xml = Nfe::Xml.new('~/nfe.xml')
  xml = Nfe::Xml.new <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <NFe>
      .
      .
      .
    </NFe>
  XML

  xml.valid? # Returns boolean
  xml.result.messages # Returns Hash
  
  danfe = Nfe::Danfe.new('~/nfe.xml')
  danfe = Nfe::Danfe.new <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <NFe>
      .
      .
      .
    </NFe>
  XML
  File.open('~/nfe.pdf','w') do |f|
    f.write(danfe.pdf)
  end
```

You can use from terminal either
```bash
    $ validate ~/nfe.xml ~/nfe2.xml
    $ generate ~/nfe.xml ~/nfe2.xml
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tofoli/nfe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

