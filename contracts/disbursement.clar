;; Disbursement Contract

(define-map disbursements
  { campaign-id: uint, milestone-id: uint }
  { amount: uint, status: (string-ascii 20) }
)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_INVALID_STATUS (err u400))

(define-read-only (get-disbursement (campaign-id uint) (milestone-id uint))
  (map-get? disbursements { campaign-id: campaign-id, milestone-id: milestone-id })
)

(define-public (request-disbursement (campaign-id uint) (milestone-id uint) (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (ok (map-set disbursements
      { campaign-id: campaign-id, milestone-id: milestone-id }
      { amount: amount, status: "pending" }
    ))
  )
)

(define-public (approve-disbursement (campaign-id uint) (milestone-id uint))
  (let
    ((disbursement (unwrap! (map-get? disbursements { campaign-id: campaign-id, milestone-id: milestone-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (ok (map-set disbursements
      { campaign-id: campaign-id, milestone-id: milestone-id }
      (merge disbursement { status: "approved" })
    ))
  )
)

