module Book.Json exposing (..)

import Json.Decode as Decode exposing ((:=), Decoder)
import Json.Encode as Encode
import Book.Types exposing (..)


bookDecoder : Decoder Book
bookDecoder =
    Decode.object8 Book
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("isbn" := Decode.string)
        ("author" := Decode.list Decode.string)
        ("publisher" := Decode.string)
        ("thumbnail" := Decode.string)
        ("description" := Decode.string)
        ("link" := Decode.string)


booksResponseDecoder : Decoder (List Book)
booksResponseDecoder =
    Decode.object1 identity ("books" := (Decode.list bookDecoder))


parseBooksResponse : Encode.Value -> List Book
parseBooksResponse value =
    value
        |> Decode.decodeValue booksResponseDecoder
        |> Result.toMaybe
        |> Maybe.withDefault []


parseBookResponse : Encode.Value -> Maybe Book
parseBookResponse value =
    value
        |> Decode.decodeValue bookDecoder
        |> Result.toMaybe
