import Html exposing (..)
import Html.Attributes exposing (..)
import Platform.Cmd exposing (..)
import Html.Events exposing (..)
import String

type alias DefaultValues =
  {
  }

main =
  Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { sidebar_visible: Bool
  , page: Page
  }


init : DefaultValues -> (Model, Cmd Msg)
init defaults =
  { sidebar_visible = False
  , page = Page1
  } ! []



  -- UPDATE
type Page = Page1 | Page2
type Msg =  MenuOpen | MenuClose | MenuItemClick Page

update msg model = case msg of
  (MenuItemClick pg) ->  ({model | page = pg, sidebar_visible = False},  Cmd.none)
  (MenuOpen) ->  ({model | sidebar_visible = True},  Cmd.none)
  (MenuClose) ->  ({model | sidebar_visible = False},  Cmd.none)


  -- VIEW
view : Model -> Html Msg
view model = div [] [
          ul [class "sidenav", style [("width", sidebar_width model.sidebar_visible)]] [
            li [onClick (MenuItemClick Page1)] [text "1"]
            , li [onClick (MenuItemClick Page2)] [text "2"]
          ]
          , div [class "page", style [("marginLeft", sidebar_width model.sidebar_visible), ("backgroundColor", if model.sidebar_visible then "rgba(0,0,0,0.4)" else "white")]]
                ((page_header model.page model.sidebar_visible) ++ (page_content model.page))
          ]

sidebar_width: Bool -> String
sidebar_width visible = if visible then "250px" else "0px"

page_header: Page -> Bool -> List(Html Msg)
page_header page sidebar_visible= let
  closebtn = span [class ("glyphicon glyphicon-menu-left"), onClick MenuClose] []
  openbtn = span [class ("glyphicon glyphicon-menu-right"), onClick MenuOpen] []
  btn = if sidebar_visible then closebtn else openbtn
  header s = [div [class "header"] [btn,text s]]
     in
    case page of
    (Page1) -> header "1"
    (Page2) -> header "2"

page_content: Page -> List(Html Msg)
page_content pg = case pg of
  (Page1) -> [a [onClick MenuOpen] [text "Open "], h1 [] [text "1"]]
  (Page2) -> [a [onClick MenuOpen] [text "Open "], h1 [] [text "2"]]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
