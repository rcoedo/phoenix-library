module Pages.BookDetails.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Pages.BookDetails.Types exposing (..)
import Book.Types exposing (Book)


view : Book -> Model -> Html Msg
view book model =
    div [ onClick Awesome ] [ text ("bookId: " ++ toString book.id) ]
