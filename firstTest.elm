import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (isEmpty)



main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model = 
  { firstName : String
  , lastName : String
  , age : String
  , ready : Bool 
  }

model : Model
model =
  Model "" "" "" False

-- UPDATE

type Msg 
    = FirstName String 
    | LastName String
    | Age String
    | Ready

update : Msg -> Model -> Model
update msg model =
  case msg of
    FirstName firstName ->
      { model | firstName = firstName, ready = False }

    LastName lastName ->
      { model | lastName = lastName, ready = False }

    Age age ->
      { model | age = age, ready = False }

    Ready ->
      { model | ready = True }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "First Name", onInput FirstName ] []
    , input [ type' "text", placeholder "Last Name", onInput LastName ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , button [ onClick Ready ] [ text "Submit" ]
    , awesomeText model
    ]

awesomeText : Model -> Html msg
awesomeText model =
  let
    (color, message) =
      if model.ready then
        if isEmpty model.firstName == False then
          ("black", "Hello " ++ model.firstName ++ " " ++ model.lastName ++ ", I see that you are " ++ model.age ++ " years old!")
        else
          ("red", "Submit your name.")
      else
        ("green", "Submit your info")
  in
    div [ style [("color", color)] ] [ text message ]
