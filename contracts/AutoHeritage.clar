;; AutoHeritage: Classic Automobile Authentication and Registry Platform
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-VEHICLE-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-REGISTERED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-MODEL-YEAR (err u5))
(define-constant ERR-INVALID-MANUFACTURER (err u6))
(define-constant ERR-INVALID-RESTORATION (err u7))
(define-constant ERR-INVALID-MODEL-NAME (err u8))
(define-constant ERR-INVALID-HISTORY (err u9))
(define-constant MIN-MODEL-YEAR u1885)
(define-data-var next-vehicle-id uint u1)
(define-map classic-automobiles
    uint
    {
        enthusiast: principal,
        model-name: (string-utf8 50),
        vehicle-history: (string-utf8 200),
        manufacturer: (string-utf8 15),
        restoration: (string-utf8 15),
        garage-status: (string-utf8 10),
        model-year: uint
    }
)
(define-private (validate-manufacturer (manufacturer (string-utf8 15)))
    (or 
        (is-eq manufacturer u"Ford")
        (is-eq manufacturer u"Chevrolet")
        (is-eq manufacturer u"Ferrari")
        (is-eq manufacturer u"Porsche")
        (is-eq manufacturer u"Mercedes")
        (is-eq manufacturer u"Jaguar")
    )
)
(define-private (validate-restoration (restoration (string-utf8 15)))
    (or 
        (is-eq restoration u"Concours")
        (is-eq restoration u"Restored")
        (is-eq restoration u"Original")
        (is-eq restoration u"Driver")
        (is-eq restoration u"Project")
    )
)
(define-private (validate-text-input (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (register-automobile 
    (model-name (string-utf8 50))
    (vehicle-history (string-utf8 200))
    (manufacturer (string-utf8 15))
    (restoration (string-utf8 15))
    (model-year uint)
)
    (let
        (
            (vehicle-id (var-get next-vehicle-id))
        )
        (asserts! (validate-text-input model-name u3 u50) ERR-INVALID-MODEL-NAME)
        (asserts! (validate-text-input vehicle-history u10 u200) ERR-INVALID-HISTORY)
        (asserts! (>= model-year MIN-MODEL-YEAR) ERR-INVALID-MODEL-YEAR)
        (asserts! (validate-manufacturer manufacturer) ERR-INVALID-MANUFACTURER)
        (asserts! (validate-restoration restoration) ERR-INVALID-RESTORATION)
        
        (map-set classic-automobiles vehicle-id {
            enthusiast: tx-sender,
            model-name: model-name,
            vehicle-history: vehicle-history,
            manufacturer: manufacturer,
            restoration: restoration,
            garage-status: u"garaged",
            model-year: model-year
        })
        (var-set next-vehicle-id (+ vehicle-id u1))
        (ok vehicle-id)
    )
)
(define-public (retire-automobile (vehicle-id uint))
    (let
        (
            (vehicle (unwrap! (map-get? classic-automobiles vehicle-id) ERR-VEHICLE-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get enthusiast vehicle)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get garage-status vehicle) u"garaged") ERR-INVALID-STATUS)
        (ok (map-set classic-automobiles vehicle-id (merge vehicle { garage-status: u"retired" })))
    )
)
(define-read-only (get-automobile (vehicle-id uint))
    (ok (map-get? classic-automobiles vehicle-id))
)
(define-read-only (get-enthusiast (vehicle-id uint))
    (ok (get enthusiast (unwrap! (map-get? classic-automobiles vehicle-id) ERR-VEHICLE-NOT-FOUND)))
)