require 'ffi'

module GMP
  module Struct
    class Z < FFI::Struct
      layout :_mp_alloc, :int,
             :_mp_size , :int,
             :_mp_d    , :pointer # mp_limb_t*
    end

    class Q < FFI::Struct
      layout :_mp_num, Z,
             :_mp_den, Z
    end

    # typedef struct {
    #   mpfr_prec_t  _mpfr_prec;
    #   mpfr_sign_t  _mpfr_sign;
    #   mpfr_exp_t   _mpfr_exp;
    #   mp_limb_t   *_mpfr_d;
    # } __mpfr_struct;
    class F < FFI::Struct
      layout :_mpfr_prec, :long,
             :_mpfr_sign, :int,
             :_mpfr_exp , :long,
             :_mpfr_d   , :pointer
    end

    # typedef struct {
    #   mpz_t _mp_seed;	  /* _mp_d member points to state of the generator. */
    #   gmp_randalg_t _mp_alg;  /* Currently unused. */
    #   union {
    #     void *_mp_lc;         /* Pointer to function pointers structure.  */
    #   } _mp_algdata;
    # } __gmp_randstate_struct;
    class RandState < FFI::Struct
      layout :_mp_seed, Z,
             :_mp_alg, :uint8, # unused enum
             :_mp_lc, :pointer # union
    end
  end
end
