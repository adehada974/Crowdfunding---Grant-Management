;; Contribution NFT Contract

(define-non-fungible-token contribution-nft uint)

(define-map contribution-nft-data
  { token-id: uint }
  {
    campaign-id: uint,
    donor: principal,
    amount: uint,
    timestamp: uint
  }
)

(define-data-var token-id-nonce uint u0)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))
(define-constant ERR_NOT_FOUND (err u404))

(define-read-only (get-last-token-id)
  (ok (var-get token-id-nonce))
)

(define-read-only (get-token-uri (token-id uint))
  (ok none)
)

(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? contribution-nft token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR_UNAUTHORIZED)
    (nft-transfer? contribution-nft token-id sender recipient)
  )
)

(define-public (mint-contribution-nft (campaign-id uint) (donor principal) (amount uint))
  (let
    ((new-token-id (+ (var-get token-id-nonce) u1)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (try! (nft-mint? contribution-nft new-token-id donor))
    (map-set contribution-nft-data
      { token-id: new-token-id }
      {
        campaign-id: campaign-id,
        donor: donor,
        amount: amount,
        timestamp: block-height
      }
    )
    (var-set token-id-nonce new-token-id)
    (ok new-token-id)
  )
)

(define-read-only (get-contribution-nft-data (token-id uint))
  (map-get? contribution-nft-data { token-id: token-id })
)

