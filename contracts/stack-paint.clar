;; Pixel Canvas Contract for Stacks Blockchain
;; 32x32 on-chain canvas, pay STX to paint pixels

(define-constant grid-width u32)
(define-constant grid-height u32)
(define-constant paint-cost u100000) ;; 0.0001 STX per pixel

(define-data-var total-painted uint u0)
(define-data-var update-counter uint u0)

;; Each pixel is stored as a map from (x,y) => (color, owner, last-update-count)
(define-map pixels 
  {x: uint, y: uint}
  {color: int, owner: principal, last-update-count: uint})

;; Check that x and y are within the grid
(define-private (valid-coords? (x uint) (y uint))
  (and
    (< x grid-width)
    (< y grid-height)
  )
)

;; Public function to paint a pixel
(define-public (painta-pixel (x uint) (y uint) (color int))
  (begin
    ;; Check bounds
    (asserts! (valid-coords? x y) (err u100)) ;; Invalid coordinates

    ;; Burn STX to paint
    (try! (stx-burn? paint-cost tx-sender))

    ;; Get and increment the update counter
    (let ((current-count (unwrap-panic (ok (var-get update-counter)))))
      (var-set update-counter (+ current-count u1))

      ;; Update pixel map
      (map-set pixels 
        {x: x, y: y} 
        {color: color, owner: tx-sender, last-update-count: current-count})

      ;; Increment total painted
      (var-set total-painted (+ (var-get total-painted) u1))

      (ok true))
  )
)

;; Read-only function to get pixel data
(define-read-only (get-pixel (x uint) (y uint))
  (map-get? pixels {x: x, y: y})
)

;; Read-only function to get total painted pixels
(define-read-only (get-total-painted)
  (ok (var-get total-painted))
)
