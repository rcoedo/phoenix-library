module Util exposing (..)

import String


shorten : Int -> String -> String
shorten n str =
    if String.length str > n then
        str |> String.slice 0 n >> (\s -> String.append s "...")
    else
        str
