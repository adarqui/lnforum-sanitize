{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module LN.Sanitize.Board (
  sanitizeBoardRequest
) where



import           Prelude

import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.Board           (BoardRequest (..))



sanitizeBoardRequest :: BoardRequest -> BoardRequest
sanitizeBoardRequest (BoardRequest display_name m_desc board_type is_active is_anonymous can_create_boards can_create_threads visibility icon tags guard) =
  BoardRequest
    (sanitizeLine display_name)          -- boardRequestDisplayName
    (sanitizeLine <$> m_desc)            -- boardRequestDescription
    board_type                           -- boardRequestBoardType
    is_active                            -- boardRequestActive
    is_anonymous                         -- boardRequestIsAnonymous
    can_create_boards                    -- boardRequestCanCreateBoards
    can_create_threads                   -- boardRequestCanCreateThreads
    visibility                           -- boardRequestVisibility
    icon                                 -- boardRequestIcon
    (map sanitizeLine tags)              -- boardRequestTags
    guard                                -- boardRequestGuard
