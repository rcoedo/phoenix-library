module App exposing (..)

import Navigation
import State exposing (..)
import View exposing (..)
import Routing exposing (..)


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
