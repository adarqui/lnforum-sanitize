{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.HTML (
  sanitizeHtml
) where



import           Data.Text              (Text)
import qualified Data.Text              as Text
import qualified Data.Text.Lazy         as Lazy
import qualified Data.Text.Lazy.Builder as Lazy
import           HTMLEntities.Decoder   (htmlEncodedText)



sanitizeHtml :: Text -> Text
sanitizeHtml = Text.replace "<br />" "\n" . Lazy.toStrict . Lazy.toLazyText . htmlEncodedText
