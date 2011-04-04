require 'ffi'

module GMP
  module Struct
    class MpZ < FFI::Struct
      layout :_mp_alloc, :int,
             :_mp_size , :int,
             :_mp_d    , :pointer # mp_limb_t*
    end

    class MpQ < FFI::Struct
      layout :_mp_num, MpZ,
             :_mp_den, MpZ
    end

    # class MpFR < FFI::Struct
    #   layout
    # end

    # typedef struct {
    #   mpz_t _mp_seed;	  /* _mp_d member points to state of the generator. */
    #   gmp_randalg_t _mp_alg;  /* Currently unused. */
    #   union {
    #     void *_mp_lc;         /* Pointer to function pointers structure.  */
    #   } _mp_algdata;
    # } __gmp_randstate_struct;
    class RandState < FFI::Struct
      layout :_mp_seed, MpZ,
             :_mp_alg, :uint8, # unused enum
             :_mp_lc, :pointer, # union
    end
  end
end
