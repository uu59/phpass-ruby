# -- coding: utf-8

require "rubygems"

class Phpass
  class Blowfish
    def initialize(stretch=8)
      @itoa64 = './0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
      stretch = 8 unless (8..30).include?(stretch)
      @stretch = stretch
    end

    def hash(pw)
    end

    def check(pw, hash)
    end

    private
    def gensalt(input)
      itoa64 = './ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    end

  end
end
