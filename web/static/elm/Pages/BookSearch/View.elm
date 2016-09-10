module Pages.BookSearch.View exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Book.Types exposing (..)
import Pages.BookSearch.Types exposing (..)
import Pages.BookSearch.State exposing (..)


bookCardView : Book -> Html Msg
bookCardView book =
    div [ class "book-card" ]
        [ img [ class "book-card__image", src <| .thumbnail <| book ]
            []
        , div [ class "book-card__information" ]
            [ div [ class "book-card__title" ] [ text <| shortTitle 18 <| book ]
            , p [ class "book-card__author" ] [ text <| shortAuthor 25 <| book ]
            ]
        ]


bookListElView : Book -> Html Msg
bookListElView book =
    li [ class "book-list__item", onClick (BookClick book) ] [ bookCardView book ]


bookListView : List Book -> Html Msg
bookListView books =
    ul [ class "book-list" ]
        (books |> List.map bookListElView)


inputView : Model -> Html Msg
inputView model =
    input
        [ class "book-search__input"
        , placeholder "Search an isbn, title, publisher or author..."
        , onInput Input
        , type' "text"
        ]
        [ text model.inputModel ]


view : Dict Int Book -> Model -> Html Msg
view books model =
    div []
        [ div [ class "book-search" ] [ inputView model ]
        , model.inputModel |> getResults books |> bookListView
        ]
