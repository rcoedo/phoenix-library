module Book.Types exposing (..)

import String
import Util exposing (shorten)


authorString : Book -> String
authorString book =
    (String.join ", " << .author) book


shortAuthor : Int -> Book -> String
shortAuthor n book =
    book |> authorString |> shorten n


shortTitle : Int -> Book -> String
shortTitle n book =
    book |> .title |> shorten n


type alias BookDetails =
    { description : String
    , epub : String
    , mobi : String
    , pdf : String
    }


type alias Book =
    { id : Int
    , title : String
    , isbn : String
    , author : List String
    , publisher : String
    , thumbnail : String
    , details : Maybe BookDetails
    }
