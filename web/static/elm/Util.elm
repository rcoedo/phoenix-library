module Util exposing (..)

import String
import Json.Decode as Decode


nullOr : Decode.Decoder a -> Decode.Decoder (Maybe a)
nullOr decoder =
    Decode.oneOf
        [ Decode.null Nothing
        , Decode.map Just decoder
        ]


shorten : Int -> String -> String
shorten n str =
    if String.length str > n then
        str |> String.slice 0 n >> (\s -> String.append s "...")
    else
        str
