# Bundler::Norelease

Disable `rake relese` task for `bundle gem GEM`

## Installation

Add this line to your application's Gemfile:

    gem 'bundler-norelease'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bundler-norelease

## Usage

`bundler-norelease gem GEM`

or you use bundler installed by master

`bundle norelease gem GEM`

So, generate gem related files.

```
% bundler-norelease gem hoge
      create  hoge/Gemfile
      create  hoge/.gitignore
      create  hoge/lib/hoge.rb
      create  hoge/lib/hoge/version.rb
      create  hoge/LICENSE.txt
      create  hoge/hoge.gemspec
      create  hoge/.consolerc
      create  hoge/Rakefile
      create  hoge/README.md
       force  hoge/Rakefile
```

In Rakefile, added `Rake::Task[:release].clear`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bundler-norelease/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Reference

* http://spring-mt.hatenablog.com/entry/2014/09/24/233321

(For Japanese)

