%%==============================================================================
%% This example shows how to use strings, binaries and atoms (and booleans)
%%==============================================================================

-module(string_types_ex).

-niffy(#{functions => [count_bytes/1, count_letters/1, equivalent/2],
         options   => [% string | binary | atom: Specifies what will be the type
                       % niffy will use for parameters AND returns if nothing is
                       % specified on the function. The default is binary
                       {default_string_type, binary},
                       % Strings passed to functions will be truncated, use this
                       % to set the maximum size the strings can have
                       {max_string_size, 1023},
                       % This sets the encoding for all strings (and atoms), but
                       % IT CAN ONLY BE "ERL_NIF_LATIN1" (which is obviously the
                       % default), you should not change it until more encodings
                       % are supported
                       {string_encoding, "ERL_NIF_LATIN1"},
                       {includes, ["<stdbool.h>"]}]}
         ).

-export([count_bytes/1, count_letters/1, equivalent/2]).

%%==============================================================================
% Returns the amount of bytes in a binary. It will use a binary since that's the
% 'default_string_type'
count_bytes(_) ->
  "int count_bytes(const char* phrase)
   {
     int c = 0;
     while(phrase[c++] != 0);
     return c - 1;
   }".

% Using "string" as a suffix will tell niffy that we expect a string, otherwise,
% niffy will use the default string value for the module. This also works if you
% end the parameter name with "binary" or "atom". Also, the case will be ignored
% and you can use the available shorter suffixes for strings and binaries ("str"
% and "bin" respectively)
count_letters(_) ->
  "int count_letters(const char* phraseString)
   {
     int c = 0;
     while(phraseString[c++] != 0);
     return c - 1;
   }".

% Here, we receive both a binary and a string on the same function. Also, we can
% return a boolean by specifying either bool or _Bool as the return type
equivalent(_, _) ->
  "bool equivalent(const char* aStr, const char* bStr)
   {
     int i = 0;
     while(aStr[i] != 0 && bStr[i] != 0)
     {
       if (aStr[i] != bStr[i])
       {
         return false;
       }
       else
       {
         i++;
       }
     }
     return aStr[i] == bStr[i];
   }".