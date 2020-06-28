# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :build_rust do
  require "ffi"

  `cargo build --release`
  FileUtils.install(
    "target/release/libpulldown_cmark_rb.#{::FFI::Platform::LIBSUFFIX}",
    "lib/pulldown-cmark/libpulldown_cmark_rb.#{::FFI::Platform::LIBSUFFIX}",
    verbose: true
  )
end

task :build => :build_rust
task :default => :build

task :benchmark do
  require "benchmark/ips"
  require "commonmarker"
  require "pulldown-cmark"

  # Clone commonmark/cmark and use its markdown samples.
  inputs = Dir.glob("../cmark/bench/samples/*.md").map { |sample|
    File.open(sample, "rb").read
  }

  puts "Input size: #{inputs.map(&:size).sum} bytes"

  Benchmark.ips do |b|
    b.report("commonmarker") do
      inputs.each { |i| CommonMarker.render_html(i) }
    end

    b.report("commonmarker + extensions") do
      inputs.each { |i|
        CommonMarker.render_html(i, :DEFAULT, [:table, :tasklist, :strikethrough])
      }
    end

    b.report("pulldown-cmark") do
      inputs.each { |i| PulldownCmark.render_html(i).to_s }
    end

    b.report("pulldown-cmark + extensions") do
      inputs.each { |i|
        PulldownCmark.render_html(
          i,
          PulldownCmark::ENABLE_TABLES |
            PulldownCmark::ENABLE_STRIKETHROUGH |
            PulldownCmark::ENABLE_TASKLISTS
        ).to_s
      }
    end

    b.compare!
  end
end
