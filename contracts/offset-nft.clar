;; Offset NFT Contract

(define-non-fungible-token offset-nft uint)

(define-map offset-nft-data
  { token-id: uint }
  {
    project-id: uint,
    emissions-reduction: uint,
    verification-date: uint
  }
)

(define-data-var nft-id-nonce uint u0)

(define-public (mint-offset-nft (project-id uint) (emissions-reduction uint))
  (let
    ((new-id (+ (var-get nft-id-nonce) u1)))
    (try! (nft-mint? offset-nft new-id tx-sender))
    (map-set offset-nft-data
      { token-id: new-id }
      {
        project-id: project-id,
        emissions-reduction: emissions-reduction,
        verification-date: block-height
      }
    )
    (var-set nft-id-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-offset-nft-data (token-id uint))
  (map-get? offset-nft-data { token-id: token-id })
)

