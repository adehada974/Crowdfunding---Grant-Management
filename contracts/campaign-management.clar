;; Campaign Management Contract

(define-map campaigns
  { campaign-id: uint }
  {
    creator: principal,
    title: (string-ascii 100),
    description: (string-utf8 1000),
    funding-goal: uint,
    deadline: uint,
    status: (string-ascii 20)
  }
)

(define-data-var campaign-id-nonce uint u0)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_ALREADY_EXISTS (err u409))
(define-constant ERR_INVALID_CAMPAIGN (err u400))

(define-read-only (get-campaign (campaign-id uint))
  (map-get? campaigns { campaign-id: campaign-id })
)

(define-public (create-campaign (title (string-ascii 100)) (description (string-utf8 1000)) (funding-goal uint) (duration uint))
  (let
    ((new-campaign-id (+ (var-get campaign-id-nonce) u1)))
    (map-set campaigns
      { campaign-id: new-campaign-id }
      {
        creator: tx-sender,
        title: title,
        description: description,
        funding-goal: funding-goal,
        deadline: (+ block-height duration),
        status: "active"
      }
    )
    (var-set campaign-id-nonce new-campaign-id)
    (ok new-campaign-id)
  )
)

(define-public (update-campaign-status (campaign-id uint) (new-status (string-ascii 20)))
  (let
    ((campaign (unwrap! (map-get? campaigns { campaign-id: campaign-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get creator campaign)) ERR_UNAUTHORIZED)
    (ok (map-set campaigns
      { campaign-id: campaign-id }
      (merge campaign { status: new-status })
    ))
  )
)

(define-read-only (get-all-campaigns)
  (ok (var-get campaign-id-nonce))
)

