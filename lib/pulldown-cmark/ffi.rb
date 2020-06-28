# frozen_string_literal: true

require "ffi"

module PulldownCmark
  class RenderedString < FFI::AutoPointer
    def self.release(p)
      FFI.rendered_string_free(p)
    end

    def to_s
      @str ||= self.read_string.force_encoding("UTF-8")
    end
  end

  class FFI
    extend ::FFI::Library

    libname = "libpulldown_cmark_rb.#{::FFI::Platform::LIBSUFFIX}"
    ffi_lib(File.expand_path(libname, __dir__))

    attach_function :render_html, [:string, :uint32], RenderedString
    attach_function :rendered_string_free, [RenderedString], :void
  end
end
