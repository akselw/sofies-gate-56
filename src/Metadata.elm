module Metadata exposing (Metadata(..), PageMetadata, decoder)

import Data.Styremedlem as Styremedlem exposing (Styremedlem)
import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import List.Extra
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)


type Metadata
    = Page PageMetadata
    | Styreoversikt StyreoversiktMeta


type alias PageMetadata =
    { title : String }


type alias StyreoversiktMeta =
    { styremedlemmer : List Styremedlem }


decoder : Decoder Metadata
decoder =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\pageType ->
                case pageType of
                    "page" ->
                        Decode.field "title" Decode.string
                            |> Decode.map (\title -> Page { title = title })

                    "styreoversikt" ->
                        Decode.field "styremedlemmer" (Decode.list Styremedlem.decoder)
                            |> Decode.map (\title -> Styreoversikt { styremedlemmer = title })

                    _ ->
                        Decode.fail ("Unexpected page type " ++ pageType)
            )
