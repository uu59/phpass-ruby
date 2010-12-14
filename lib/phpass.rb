# -- coding: utf-8

require "digest/md5"
require "openssl"
require "#{File.dirname(__FILE__)}/phpass/md5.rb"

class Phpass
  def initialize(iter=8)
    iter = 8 unless (8..30).include?(iter)
    @iter = iter
  end

  def hash(pw, alg=:md5)
    hasher = Md5.new(@iter)
    return hasher.hash(pw)
    rnd = ''
    rnd = random_bytes(6)
    crypt_private(pw, gensalt_private(rnd))
  end

  def check(pw, hash)
    hasher = Md5.new(@iter)
    hasher.check(pw, hash)
  end

  def self.random_bytes(length)
    out = ''
    if File.readable?('/dev/urandom')
      out = File.read('/dev/urandom', length)
    end

    if(out.length < length)
      random_state = '%s%s' % [Time.now.to_f, $$]
      out = ''
      while out.length < length
        rnd = Digest::MD5.hexdigest(Time.now.to_f.to_s + random_state)
        out << Digest::MD5.digest(rnd)
      end
      out = out[0..length]
    end
    out
  end
end
