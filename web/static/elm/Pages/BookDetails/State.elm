module Pages.BookDetails.State exposing (..)

import Pages.BookDetails.Types exposing (..)


init : Model
init =
    { id = 2
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    ( model, Cmd.none )
