module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App


-- MODEL


type alias Model =
    { todos : List Todo
    , newTodo : String
    , showTodos : Visability
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
    , showTodos = All
    }


type Visability
    = All
    | Active
    | Completed


type Msg
    = Add
    | NewTodo String
    | Done Int
    | ToggleVisability Visability



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            add model

        NewTodo string ->
            { model | newTodo = string }

        Done id ->
            done model id

        ToggleVisability visability ->
            { model | showTodos = visability }


done : Model -> Int -> Model
done model id =
    let
        newTodos =
            List.map
                (\todo ->
                    if todo.id == id then
                        { todo | done = not todo.done }
                    else
                        todo
                )
                model.todos
    in
        { model | todos = newTodos }


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
        , toggleVisability
        , todoList model
        , div [] [ text (toString model) ]
        ]


toggleVisability : Html Msg
toggleVisability =
    div []
        [ span [ onClick (ToggleVisability All) ] [ text "All" ]
        , span [ onClick (ToggleVisability Active) ] [ text "Active" ]
        , span [ onClick (ToggleVisability Completed) ] [ text "Completed" ]
        ]


todoSection : Model -> Html Msg
todoSection model =
    model.todos
        |> List.map todoItem
        |> ul []


todoList : Model -> Html Msg
todoList model =
    let
        newTodos =
            showTodo model.showTodos model.todos
    in
        newTodos
            |> List.map todoItem
            |> ul []


showTodo : Visability -> List Todo -> List Todo
showTodo visability todo =
    case visability of
        All ->
            todo

        Active ->
            List.filter (\t -> not t.done) todo

        Completed ->
            List.filter (\t -> t.done) todo


todoItem : Todo -> Html Msg
todoItem todo =
    li []
        [ input [ type' "checkbox", onClick (Done todo.id) ] []
        , span [] [ text todo.text ]
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
