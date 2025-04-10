$TTL 3600
@   IN  SOA  ns1.gercar.com. hostmaster.gercar.com. (
        2025040301  ; Serial
        3600        ; Refresh
        300         ; Retry
        3600000     ; Expire
        3600        ; Minimum
)

; Servidor de nombres
@               IN  NS      ns1.gercar.com.

; Dirección IP del servidor de nombres
ns1             IN  A       10.2.77.250

; Dirección IP del dominio principal (gercar.com)
@               IN  A       10.2.77.250

; Subdominio www.gercar.com
www             IN  A       10.2.77.250
