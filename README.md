Project Euler
=============

My solutions for the project Euler problems.  Solutions are encrypted using
symmetric, password based encryption, with the password being the numeric
answer to the given problem.

![](http://projecteuler.net/profile/covertcj.png)

Decrypting/Encrypting Solutions
-------------------------------

Use `rake enc[:problem,:answer]` to encrypt and `rake dec[:problem,:answer]`
to descrypt.  For example:

    rake enc[001,5555]
    rake dec[001,5555]
    
It's somewhat likely the above commands will fail due to your shell's attempt to
preprocess them, so may need to use quotes:

    rake "enc[001,5555]"
    rake "dec[001,5555]"

Running Haskell Problems
------------------------

Use `rake runhs[:problem]` to perform an out of source build of a problem in
'build' directory and run it afterwords.

    rake runhs[001]
