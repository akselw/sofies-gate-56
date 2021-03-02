module Data.Styremedlem exposing (Styremedlem, all, decoder, view)

import Element exposing (Element)
import Html.Attributes as Attr
import Json.Decode as Decode exposing (Decoder)
import List.Extra
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)


type Styreverv
    = Styreleder
    | Medlem
    | Vara


type alias Styremedlem =
    { navn : String
    , verv : Styreverv
    , telefonnummer : Maybe String
    , epost : Maybe String
    }


all : List Styremedlem
all =
    [ { navn = "Øystein Gylvik"
      , verv = Styreleder
      , telefonnummer = Nothing
      , epost = Nothing
      }
    , { navn = "Ragnhild Skåle Hetland"
      , verv = Medlem
      , telefonnummer = Nothing
      , epost = Nothing
      }
    , { navn = "Thale Storberget Dyrnes"
      , verv = Medlem
      , telefonnummer = Nothing
      , epost = Nothing
      }
    , { navn = "Joakim"
      , verv = Vara
      , telefonnummer = Nothing
      , epost = Nothing
      }
    , { navn = "Arild Berg"
      , verv = Vara
      , telefonnummer = Nothing
      , epost = Nothing
      }
    ]


decoder : Decoder Styremedlem
decoder =
    Decode.string
        |> Decode.andThen
            (\lookupName ->
                case List.Extra.find (\styremedlem -> styremedlem.navn == lookupName) all of
                    Just author ->
                        Decode.succeed author

                    Nothing ->
                        Decode.fail ("Couldn't find author with name " ++ lookupName ++ ". Options are " ++ String.join ", " (List.map .navn all))
            )


view : List (Element.Attribute msg) -> Styremedlem -> Element msg
view attributes styremedlem =
    Element.paragraph
        []
        [ Element.text styremedlem.navn ]
