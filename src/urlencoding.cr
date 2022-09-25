module URLEncoding
  extend self

  VERSION = "1.0.0"

  @[Link("urlencoding")]
  private lib C
    fun url_encoding_encode(data: Pointer(LibC::Char)): Pointer(LibC::Char)
    fun url_encoding_encode_binary(data: Pointer(LibC::Char), length: LibC::SizeT): Pointer(LibC::Char)

    fun url_encoding_decode(data: Pointer(LibC::Char)): Pointer(LibC::Char)
    fun url_encoding_decode_binary(data: Pointer(LibC::Char), length: LibC::SizeT): Pointer(LibC::Char)

    fun url_encoding_free(data: Pointer(LibC::Char)): Void
  end

  # Percent-encodes every byte except alphanumerics and -, _, ., ~. Assumes UTF-8 encoding.
  # 
  # Example:
  # * *
  # res = URLEncoding.encode("This string will be URL encoded.")
  # puts res
  # * *
  # 
  # @param data
  # @return encoded string
  def encode(data)
    res = C.url_encoding_encode(data.to_unsafe())
    if res == nil
      return ""
    end
    str = String.new(res)
    C.url_encoding_free(res)
    return str
  end

  # Percent-encodes every byte except alphanumerics and -, _, ., ~.
  # 
  # Example:
  # * *
  # res = URLEncoding.encodeBinary("This string will be URL encoded.")
  # puts res
  # * *
  # 
  # @param data
  # @return encoded string
  def encode_binary(data)
    res = C.url_encoding_encode_binary(data.to_unsafe(), data.size)
    if res == nil
      return ""
    end
    str = String.new(res)
    C.url_encoding_free(res)
    return str
  end

  # Decode percent-encoded string assuming UTF-8 encoding.
  # 
  # Example:
  # * *
  # res = URLEncoding.decode("%F0%9F%91%BE%20Exterminate%21")
  # puts res
  # * *
  # 
  # @param data
  # @return decoded string
  def decode(data)
    res = C.url_encoding_decode(data.to_unsafe())
    if res == nil
      return ""
    end
    str = String.new(res)
    C.url_encoding_free(res)
    return str
  end

  # Decode percent-encoded string as binary data, in any encoding.
  # 
  # Example:
  # * *
  # res = URLEncoding.decodeBinary("%F1%F2%F3%C0%C1%C2")
  # puts res
  # * *
  # 
  # @param data
  # @return decoded string
  def decode_binary(data)
    res = C.url_encoding_decode_binary(data.to_unsafe(), data.size)
    if res == nil
      return ""
    end
    str = String.new(res)
    C.url_encoding_free(res)
    return str
  end
end