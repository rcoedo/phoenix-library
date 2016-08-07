module Search.Input exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Model


type alias Model =
    String


initModel : String
initModel =
    ""



-- Update


type Msg
    = Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input value ->
            value



-- View


view : Model -> Html Msg
view model =
    input
        [ onInput Input
        , type' "text"
        ]
        [ text model ]
