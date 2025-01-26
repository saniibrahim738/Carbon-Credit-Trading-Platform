;; Offset Project Contract

(define-map projects
  { project-id: uint }
  {
    owner: principal,
    name: (string-ascii 100),
    description: (string-utf8 1000),
    location: (string-ascii 100),
    status: (string-ascii 20),
    verified-emissions-reduction: uint,
    start-date: uint,
    end-date: uint
  }
)

(define-data-var project-nonce uint u0)

(define-public (register-project
  (name (string-ascii 100))
  (description (string-utf8 1000))
  (location (string-ascii 100))
  (start-date uint)
  (end-date uint))
  (let
    ((new-id (+ (var-get project-nonce) u1)))
    (map-set projects
      { project-id: new-id }
      {
        owner: tx-sender,
        name: name,
        description: description,
        location: location,
        status: "pending",
        verified-emissions-reduction: u0,
        start-date: start-date,
        end-date: end-date
      }
    )
    (var-set project-nonce new-id)
    (ok new-id)
  )
)

(define-public (verify-project (project-id uint) (emissions-reduction uint))
  (let
    ((project (unwrap! (map-get? projects { project-id: project-id }) (err u404))))
    (asserts! (is-eq tx-sender (get owner project)) (err u403))
    (map-set projects
      { project-id: project-id }
      (merge project {
        status: "verified",
        verified-emissions-reduction: emissions-reduction
      })
    )
    (ok true)
  )
)

(define-read-only (get-project (project-id uint))
  (map-get? projects { project-id: project-id })
)

