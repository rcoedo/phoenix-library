module Common.Input exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


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


view : List (Attribute Msg) -> Model -> Html Msg
view attr model =
    input
        (List.append attr
            [ onInput Input
            , type' "text"
            ]
        )
        [ text model ]
