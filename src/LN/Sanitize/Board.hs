{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.Board (
  sanitizeBoardRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.Board.Request   (BoardRequest (..))



sanitizeBoardRequest :: BoardRequest -> BoardRequest
sanitizeBoardRequest (BoardRequest display_name m_desc is_anonymous can_create_sub_boards can_create_threads suggested_tags icon tags guard) =
  BoardRequest
    (sanitizeLine display_name)
    (sanitizeLine <$> m_desc)
    is_anonymous
    can_create_sub_boards
    can_create_threads
    (map sanitizeLine suggested_tags)
    icon
    (map sanitizeLine tags)
    icon
    visibility
    guard
