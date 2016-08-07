module App exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.App as App
import Search.Input exposing (..)


-- Model


type alias Model =
    { searchInputModel : Search.Input.Model
    , books : Dict String Book
    }


type alias Book =
    { id : Int
    , title : String
    , isbn : String
    , author : List String
    }


initModel : Model
initModel =
    { searchInputModel = Search.Input.initModel
    , books = Dict.fromList []
    }



-- Update


type Msg
    = SearchInputMsg Search.Input.Msg


update : Msg -> Model -> Model
update message model =
    case message of
        SearchInputMsg msg ->
            { model | searchInputModel = Search.Input.update msg (.searchInputModel model) }



-- View


view : Model -> Html Msg
view model =
    div []
        [ App.map SearchInputMsg <| Search.Input.view <| .searchInputModel model ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
