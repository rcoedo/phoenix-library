module View exposing (..)

import Html exposing (..)
import Html.App as App
import Dict
import Types exposing (..)
import Pages.BookSearch.Types as BookSearchTypes
import Pages.BookDetails.Types as BookDetailsTypes
import Pages.BookSearch.View as BookSearchView
import Pages.BookDetails.View as BookDetailsView


bookDetailsMsgToMsg : BookDetailsTypes.Msg -> Msg
bookDetailsMsgToMsg msg =
    case msg of
        BookDetailsTypes.CoolStuff ->
            UpdateBook
                { id = 1
                , title = "frus"
                , isbn = "frus"
                , author = [ "frus" ]
                , publisher = "frus"
                , thumbnail = "frus"
                , description = "frus"
                , link = "frus"
                }

        _ ->
            BookDetailsMsg msg


bookSearchMsgToMsg : BookSearchTypes.Msg -> Msg
bookSearchMsgToMsg msg =
    case msg of
        _ ->
            BookSearchMsg msg


bookSearchView : Model -> Html Msg
bookSearchView model =
    BookSearchView.view model.books model.searchPageModel
        |> App.map BookSearchMsg


view : Model -> Html Msg
view model =
    case model.route of
        BookSearchRoute ->
            BookSearchView.view model.books model.searchPageModel
                |> App.map bookSearchMsgToMsg

        BookRoute bookId ->
            let
                maybeBook =
                    Dict.get bookId model.books
            in
                case maybeBook of
                    Just book ->
                        BookDetailsView.view book model.detailsPageModel
                            |> App.map bookDetailsMsgToMsg

                    Nothing ->
                        view ({ model | route = NotFoundRoute })

        NotFoundRoute ->
            div []
                [ text "not found" ]
