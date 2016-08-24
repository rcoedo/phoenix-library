module Book.Json exposing (..)

import Json.Decode as Decode exposing ((:=), Decoder)
import Json.Encode as Encode
import Book.Types exposing (..)


bookDetailsDecoder : Decoder BookDetails
bookDetailsDecoder =
    Decode.object4 BookDetails
        ("description" := Decode.string)
        ("epub" := Decode.string)
        ("mobi" := Decode.string)
        ("pdf" := Decode.string)


bookDecoder : Decoder Book
bookDecoder =
    Decode.object7 Book
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("isbn" := Decode.string)
        ("author" := Decode.list Decode.string)
        ("publisher" := Decode.string)
        ("thumbnail" := Decode.string)
        (Decode.maybe ("details" := bookDetailsDecoder))


bookListDecoder : Decoder (List Book)
bookListDecoder =
    Decode.object1 identity ("books" := (Decode.list bookDecoder))


parseBooks : Encode.Value -> List Book
parseBooks value =
    value
        |> Decode.decodeValue bookListDecoder
        |> Result.toMaybe
        |> Maybe.withDefault []
