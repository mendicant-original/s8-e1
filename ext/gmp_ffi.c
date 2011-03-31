#include <ruby.h>
#include <gmp.h>

ID id_address;

VALUE mpz2num(MP_INT* z) {
  if(mpz_fits_slong_p(z)) {
    return INT2FIX(mpz_get_si(z));
  } else {
    long size = (mpz_sizeinbase(z, 2) + 8*SIZEOF_BDIGITS-1) / (8*SIZEOF_BDIGITS);
    VALUE big = rb_big_new(size, 1);
    BDIGIT *digits = RBIGNUM_DIGITS(big);
    mpz_export(digits, NULL, -1, SIZEOF_BDIGITS, 0, 0, z);
    return big;
  }
}

MP_INT* ffi_pointer2mpz(VALUE ptr) {
	return (MP_INT*) NUM2LONG(rb_funcall(ptr, id_address, 0));
}

VALUE mpz_fast_to_i(VALUE self) {
	return mpz2num(ffi_pointer2mpz(rb_iv_get(self, "@ptr")));
}

void Init_gmp_ffi() {
	id_address = rb_intern("address");

	VALUE mGMP = rb_define_module("GMP");
	VALUE cZ = rb_define_class_under(mGMP, "Z", rb_cObject);
	rb_define_method(cZ, "fast_to_i", mpz_fast_to_i, 0);
}
