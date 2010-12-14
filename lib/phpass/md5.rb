# -- coding: utf-8

require "rubygems"

class Phpass
  class Md5
    def initialize(stretch=8)
      @itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
      stretch = 8 unless (8..128).include?(stretch)
      @stretch = stretch
      @random_state = '%s%s' % [Time.now.to_f, $$]
    end

    def hash(pw)
      rnd = ''
      rnd = Phpass.random_bytes(6)
      crypt(pw, gensalt(rnd))
    end

    def check(pw, hash)
      crypt(pw, hash) == hash
    end

    private

    def gensalt(input)
      out = '$P$'
      out << @itoa64[[@stretch + 5, 30].min]
      out << encode64(input, 6)
      out
    end

    def crypt(pw, setting)
      out = '*0'
      out = '*1' if setting.start_with?(out)
      iter = @itoa64.index(setting[3])
      return out unless (8..30).include?(iter)
      count = 1 << iter
      salt = setting[4...12]
      return out if salt.length != 8
      hash = Digest::MD5.digest(salt + pw)
      while count > 0
        hash = Digest::MD5.digest(hash + pw)
        count -= 1
      end
      setting[0,12] + encode64(hash, 16)
    end

    def encode64(input, count)
      out = ''
      cur = 0
      while cur < count
        value = input[cur].ord
        cur += 1
        out << @itoa64[value & 0x3f]
        if cur < count
          value |= input[cur].ord << 8
        end
        out << @itoa64[(value >> 6) & 0x3f]
        break if cur >= count
        cur += 1

        if cur < count
          value |= input[cur].ord << 16
        end
        out << @itoa64[(value >> 12) & 0x3f]
        break if cur >= count
        cur += 1
        out << @itoa64[(value >> 18) & 0x3f]
      end
      out
    end
  end
end
