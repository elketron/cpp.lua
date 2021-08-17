# elk-funcs

## description
this is a plugin of a collection of helper functions to make my live easier

## functions 

1. mkfun
    * cpp function for getting a function prototype and placing it in another file
    * takes no parameters
    * call with vim function Mkfun of via lua require"funcs".mkfun()
2. comment
    * general function for commenting a line or multiple lines
    * takes an int parameter for amount of lines to comment
    * call with lua require"funcs".com(int)
3. uncomment
    * general function for uncommenting a line or multiple lines
    * takes an int parameter for amount of lines to uncomment
    * call with lua require"funcs".unc(int)
