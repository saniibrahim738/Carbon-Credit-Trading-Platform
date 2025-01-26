;; Carbon Credit Contract

(define-fungible-token carbon-credit)

(define-constant contract-owner tx-sender)

(define-map credit-balances principal uint)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u403))
    (ft-mint? carbon-credit amount recipient)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u403))
    (ft-transfer? carbon-credit amount sender recipient)
  )
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance carbon-credit account))
)

(define-public (burn (amount uint) (owner principal))
  (begin
    (asserts! (is-eq tx-sender owner) (err u403))
    (ft-burn? carbon-credit amount owner)
  )
)

