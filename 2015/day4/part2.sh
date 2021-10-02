#!/bin/bash

# --- Part Two ---
#
# Now find one that starts with six zeroes.

export key=$(cat input.txt)                  # read key into ENV
perl -MDigest::MD5 -e '                      # load MD5 module in perl                     
my $key = $ENV{"key"};                       # pull key from ENV into perl var
for (my $i=1; $i<1000000000; $i++) {         # process numbers 1 to 1 billion (hope thats enough!)
    my $md5 = Digest::MD5::md5_hex($key.$i); # hash key with current input number  
    if ($md5 =~ /^000000/) {                 # check if hash starts with 000000
      printf("%d\n", $i);                    # print input number if match
      exit                                   # quit since we only care about first hit
    }
}'