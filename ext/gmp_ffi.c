#include <ruby.h>
#include <gmp.h>

#define P(obj) printf("%s\n", RSTRING_PTR(rb_funcall(obj, rb_intern("inspect"), 0)))

ID id_address, id_new;
VALUE cZ;

MP_INT* rbZ2mpz(VALUE z) {
	return (MP_INT*) NUM2LL(rb_funcall(rb_iv_get(z, "@ptr"), id_address, 0));
}

VALUE mpz2num(mpz_t z) {
	if(mpz_fits_slong_p(z)) {
		return LONG2NUM(mpz_get_si(z));
	} else {
		long size = (mpz_sizeinbase(z, 2) + 8*SIZEOF_BDIGITS-1) / (8*SIZEOF_BDIGITS);
		VALUE big = rb_big_new(size, mpz_sgn(z) >= 0);
		BDIGIT *digits = RBIGNUM_DIGITS(big);
		mpz_export(digits, NULL, -1, SIZEOF_BDIGITS, 0, 0, z);
		return big;
	}
}

VALUE mpz_fast_to_i(VALUE self) {
	return mpz2num(rbZ2mpz(self));
}

VALUE mpz_fast_from_i(VALUE self, VALUE i) {
	mpz_t *z; // We need a pointer, else it will go out of scope and be GC'd
	z = malloc(sizeof(mpz_t));
	if(FIXNUM_P(i)) {
		mpz_init_set_si(*z, FIX2LONG(i));
	} else {
		mpz_init(*z);
		mpz_import(*z, RBIGNUM_LEN(i), -1, SIZEOF_BDIGITS, 0, 0, RBIGNUM_DIGITS(i));
		if(RBIGNUM_NEGATIVE_P(i))
			mpz_neg(*z, *z);
	}

	rb_iv_set(self, "@ptr", rb_funcall(rb_path2class("FFI::Pointer"), id_new, 1, LL2NUM((uintptr_t)*z)));
	return self;
}

VALUE rb_mpz_even_p(VALUE mod, VALUE self) {
	MP_INT *z = rbZ2mpz(self);
	return mpz_even_p(z) ? Qtrue : Qfalse;
}

void Init_gmp_ffi() {
	id_address = rb_intern("address");
	id_new = rb_intern("new");

	VALUE mGMP = rb_define_module("GMP");
	cZ = rb_define_class_under(mGMP, "Z", rb_cObject);
	rb_define_private_method(cZ, "fast_to_i", mpz_fast_to_i, 0);
	rb_define_private_method(cZ, "fast_from_i", mpz_fast_from_i, 1);

	VALUE mExt = rb_define_module_under(mGMP, "Ext");
	rb_define_singleton_method(mExt, "even?", rb_mpz_even_p, 1);
}
