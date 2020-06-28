# frozen_string_literal: true

require "pulldown-cmark/ffi"
require "pulldown-cmark/version"

module PulldownCmark
  # See https://github.com/raphlinus/pulldown-cmark/blob/v0.7.1/src/parse.rs#L184.
  ENABLE_TABLES = 1<<1
  ENABLE_FOOTNOTES = 1<<2
  ENABLE_STRIKETHROUGH = 1<<3
  ENABLE_TASKLISTS = 1<<4

  def self.render_html(str, opts = 0)
    opts = opts.reduce(:|) if opts.is_a?(Array)

    FFI.render_html(str, opts)
  end
end
