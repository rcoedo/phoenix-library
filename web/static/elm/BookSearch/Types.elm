module BookSearch.Types exposing (..)


type Msg
    = Input String


type alias Model =
    { inputModel : String
    }
