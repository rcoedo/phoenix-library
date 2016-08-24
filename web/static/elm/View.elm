module View exposing (..)

import Html exposing (..)
import Html.App as App
import Types exposing (..)
import BookSearch.View


bookSearchView : Model -> Html Msg
bookSearchView model =
    BookSearch.View.view model.books model.searchPageModel
        |> App.map BookSearchMsg


view : Model -> Html Msg
view model =
    case model.route of
        BookSearchRoute ->
            BookSearch.View.view model.books model.searchPageModel
                |> App.map BookSearchMsg

        NotFoundRoute ->
            div []
                [ text "not found" ]
