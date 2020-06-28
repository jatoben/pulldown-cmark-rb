use pulldown_cmark::{html, Options, Parser};
use std::ffi::{CString, CStr};
use std::io::Cursor;
use std::os::raw::c_char;

#[no_mangle]
pub unsafe extern fn render_html(input: *const c_char, options: u32) -> *mut c_char {
    assert!(!input.is_null());
    let istr = CStr::from_ptr(input).to_string_lossy();

    let opts = Options::from_bits_truncate(options);
    let mut out = Vec::new();
    let parser = Parser::new_ext(&istr, opts);

    html::write_html(Cursor::new(&mut out), parser).expect("render failed!");
    let ret = CString::new(out).expect("CString::new failed!");

    ret.into_raw()
}

#[no_mangle]
pub unsafe extern fn rendered_string_free(i: *mut c_char) {
    if i.is_null() { return; }
    CString::from_raw(i);
}
