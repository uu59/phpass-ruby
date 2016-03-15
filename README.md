This is a porting of [phpass](http://www.openwall.com/phpass/)

All files within this package are in public domain.

# Install

    $ gem install phpass-ruby

# Usage

    require "rubygems"
    require "phpass"

    # 12 is password strength / calculation time. This is trade-off. 
    # 8 <= strength <= 30 (default: 8)
    phpass = Phpass.new(12) 

    # Get hashed string. These are different result each time.
    p phpass.hash('foo')
    p phpass.hash('foo')
    p phpass.hash('foo')

    # Compare input and stored hash
    known = '$P$9IQRaTwmfeRo7ud9Fh4E2PdI0S3r.L0'
    p phpass.check('test12345', known) # => true
    p phpass.check('test12346', known) # => false

# Caution

phpass-ruby is supporting portable(MD5) hashing only.

However, nonportable phpass hashes can be validated using bcrypt:

    require 'bcrypt'
    BCrypt::Engine.cost = 8
    p BCrypt::Password.new(stored_hash) == password + stored_salt
