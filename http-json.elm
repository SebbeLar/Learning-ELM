module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task


main : Program Never
main =
    App.program
        { init = init "Hello"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { response : String
    }


init : String -> ( Model, Cmd Msg )
init resp =
    ( Model resp
    , Cmd.none
    )



-- UPDATE


type Msg
    = Fetch


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text (toString model.response) ]
        , button [ onClick Fetch ] [ text "Press Me" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
