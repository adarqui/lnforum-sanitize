{-# LANGUAGE RecordWildCards #-}

module LN.Sanitize.Organization (
  sanitizeOrganizationRequest
) where



import           LN.Sanitize.Internal (sanitizeLine)
import           LN.T.Organization    (OrganizationRequest (..))



sanitizeOrganizationRequest :: OrganizationRequest -> OrganizationRequest
sanitizeOrganizationRequest (OrganizationRequest display_name m_desc comp loc email membership tags icon visibility guard _) =
  OrganizationRequest
    (sanitizeLine display_name)
    (sanitizeLine <$> m_desc)
    (sanitizeLine comp)
    (sanitizeLine loc)
    (sanitizeLine email)
    membership
    (map sanitizeLine tags)
    icon
    visibility
    guard
    -- state
    Nothing
