module Pages.BookSearch.State exposing (..)

import Regex
import Dict exposing (..)
import Pages.BookSearch.Types exposing (..)
import Book.Types exposing (..)
import Navigation


init : Model
init =
    { inputModel = ""
    }


filterRegex : String -> String -> Bool
filterRegex query =
    query
        |> Regex.regex
        >> Regex.caseInsensitive
        >> Regex.contains


filterElement : List (a -> String) -> String -> a -> Bool
filterElement getters query element =
    getters
        |> List.map (\getter -> getter element)
        |> List.map (filterRegex query)
        |> List.foldl (||) False


getResults : Dict Int Book -> String -> List Book
getResults books query =
    books
        |> Dict.values
        |> List.filter (filterElement [ authorString, .title, .isbn, .publisher ] query)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Input value ->
            ( { model | inputModel = value }, Cmd.none )

        BookClick book ->
            ( model, Navigation.newUrl ("#book/" ++ (book.id |> toString)) )
