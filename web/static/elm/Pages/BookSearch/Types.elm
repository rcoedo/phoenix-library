module Pages.BookSearch.Types exposing (..)

import Book.Types exposing (Book)


type Msg
    = Input String
    | BookClick Book


type alias Model =
    { inputModel : String
    }
