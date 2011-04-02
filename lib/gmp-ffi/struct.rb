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
  end
end
