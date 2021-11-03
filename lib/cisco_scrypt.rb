# frozen_string_literal: true

require "openssl"
require_relative "cisco_scrypt/version"

# Generate Cisco type 9 password hashes
module CiscoScrypt
  class Error < StandardError; end
  class << self
    # Based on the John The Ripper
    # https://github.com/openwall/john/blob/186c9ae1e421618962a7446fa22f9d678cd6b0a9/run/pass_gen.pl#L994
    # https://github.com/videgro/cisco-password-hashes
    def crypt_to64_wpa(value, number_of_iterations)
      itoa64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
      result = +""
      number_of_iterations.times do
        position = (value & 0xFC0000) >> 18
        result << itoa64[position]
        value = value << 6
      end
      result
    end

    # Cisco uses non-standard base64 encoding, which happens to be the same
    # implementation as used for WPA passwords.
    # rubocop: disable Metrics/MethodLength
    def base64_wpa(byte_string)
      len = byte_string.size
      mod = len % 3
      cnt = (len - mod) / 3
      out = +""

      # iterate over "full" bytes, 3 bytes at a time
      # encode every 3 sextets as 4 sextets
      cnt.times do |idx|
        out << full_bytes(byte_string, idx)
      end

      case mod
      when 2 then out << two_bytes(byte_string, len)
      when 1 then out << single_byte(byte_string, len)
      end
      out
    end
    # rubocop: enable Metrics/MethodLength

    def full_bytes(byte_string, idx)
      offset = idx * 3
      c = byte_string[offset].ord
      b = byte_string[offset + 1].ord
      a = byte_string[offset + 2].ord
      l = ((c << 16) | (b << 8) | a)
      crypt_to64_wpa(l, 4)
    end

    def single_byte(byte_string, len)
      c = byte_string[len - 1].ord
      l = c << 16
      crypt_to64_wpa(l, 2)
    end

    def two_bytes(byte_string, len)
      c = byte_string[len - 2].ord
      b = byte_string[len - 1].ord
      l = ((c << 16) | (b << 8))
      crypt_to64_wpa(l, 3)
    end

    def generate(password, salt)
      bytes = OpenSSL::KDF.scrypt(password, N: 2**14, r: 1, p: 1, salt: salt, length: 32)
      password_hash = base64_wpa(bytes)

      "$9$#{salt}$#{password_hash}"
    end
  end
end
