$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()

Write-Host ""
Write-Host "  Servidor corriendo. Abre en tu navegador:"
Write-Host "  http://localhost:8080/cam.html"
Write-Host ""
Write-Host "  Presiona Ctrl+C para detener."
Write-Host ""

$root = "C:\Users\Marco\Documents\eos"

while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $file = Join-Path $root ($ctx.Request.Url.LocalPath.TrimStart('/'))
    if (Test-Path $file -PathType Leaf) {
        $bytes = [IO.File]::ReadAllBytes($file)
        $ctx.Response.ContentType = switch ([IO.Path]::GetExtension($file)) {
            ".html" { "text/html" }
            ".css"  { "text/css" }
            ".js"   { "application/javascript" }
            ".png"  { "image/png" }
            ".jpg"  { "image/jpeg" }
            default { "application/octet-stream" }
        }
        $ctx.Response.ContentLength64 = $bytes.Length
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $msg = [Text.Encoding]::UTF8.GetBytes("404 Not Found")
        $ctx.Response.StatusCode = 404
        $ctx.Response.OutputStream.Write($msg, 0, $msg.Length)
    }
    $ctx.Response.Close()
}
