module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App


-- MODEL


type alias Model =
    { todos : List Todo
    , newTodo : String
    }


type alias Todo =
    { id : Int
    , text : String
    , done : Bool
    }


model : Model
model =
    { todos = []
    , newTodo = ""
    }


type Msg
    = Add
    | NewTodo String



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            add model

        NewTodo string ->
            { model | newTodo = string }


add : Model -> Model
add model =
    let
        newTodo =
            Todo (List.length model.todos) model.newTodo False

        newTodos =
            newTodo :: model.todos
    in
        { model | todos = newTodos, newTodo = "" }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ todoHeader
        , todoInput model
        , div [] [ text (toString model) ]
        ]


todoInput : Model -> Html Msg
todoInput model =
    div []
        [ input
            [ type' "text"
            , placeholder "Add new ToDo"
            , onInput NewTodo
            , value model.newTodo
            ]
            []
        , input [ type' "button", onClick Add ] [ text "Add ToDo" ]
        ]


todoHeader : Html Msg
todoHeader =
    h1 [] [ text "Elm ToDo App" ]


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
