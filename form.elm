import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , verify : Bool
  }


model : Model
model =
  Model "" "" "" False


-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Verify


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Verify ->
      { model | verify = True }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "button", value "Submit",  onSubmit Verify ] []
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if (model.verify)
        else if model.password == model.passwordAgain && String.length model.password > 7 then
            ("green", "OK")
        else
            ("red", "Passwords do not match!")
      else
        ("white", "")
  in
    div [ style [("color", color)] ] [ text message ]