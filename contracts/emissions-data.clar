;; Emissions Data Contract

(define-map emissions-data
  { device-id: (string-ascii 50), timestamp: uint }
  {
    project-id: uint,
    emissions-value: uint,
    data-source: (string-ascii 20)
  }
)

(define-public (record-emissions-data (device-id (string-ascii 50)) (project-id uint) (emissions-value uint) (data-source (string-ascii 20)))
  (begin
    (asserts! (or (is-eq data-source "satellite") (is-eq data-source "iot")) (err u403))
    (map-set emissions-data
      { device-id: device-id, timestamp: block-height }
      {
        project-id: project-id,
        emissions-value: emissions-value,
        data-source: data-source
      }
    )
    (ok true)
  )
)

(define-read-only (get-latest-emissions-data (device-id (string-ascii 50)))
  (map-get? emissions-data { device-id: device-id, timestamp: block-height })
)

