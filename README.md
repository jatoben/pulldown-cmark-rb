# PulldownCmark

Ruby bindings for the [pulldown-cmark Rust crate](https://crates.io/crates/pulldown-cmark). See also [raphlinus/pulldown-cmark](https://github.com/raphlinus/pulldown-cmark).

## Building

You'll need a [recent version of Rust installed](https://www.rust-lang.org/tools/install).

```shell
$ bundle exec rake build_rust
$ bundle exec rake test
```

## Usage

```ruby
require "pulldown-cmark"

PulldownCmark.render_html("_Hello_, **world**!").to_s
=> "<p><em>Hello</em>, <strong>world</strong>!</p>\n"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jatoben/pulldown-cmark-rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
