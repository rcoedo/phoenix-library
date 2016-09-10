module Routing exposing (..)

import Navigation
import UrlParser exposing (Parser, (</>), format, int, oneOf, s, string)
import String
import Types exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format BookSearchRoute (oneOf [ s "", s "home" ])
        , format BookRoute (s "book" </> int)
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> UrlParser.parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
