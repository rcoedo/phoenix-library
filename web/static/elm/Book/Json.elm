module Book.Json exposing (..)

import Json.Decode as Decode exposing ((:=), Decoder)
import Json.Encode as Encode
import Book.Types exposing (..)


bookDecoder : Decoder Book
bookDecoder =
    Decode.object5 Book
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("isbn" := Decode.string)
        ("thumbnail" := Decode.string)
        ("author" := Decode.list Decode.string)


bookListDecoder : Decoder (List Book)
bookListDecoder =
    Decode.object1 identity ("books" := (Decode.list bookDecoder))


parseBooks : Encode.Value -> List Book
parseBooks value =
    value
        |> Decode.decodeValue bookListDecoder
        |> Result.toMaybe
        |> Maybe.withDefault []
