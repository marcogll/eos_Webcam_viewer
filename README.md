# EOS 6D — Live Feed

Transmisión en vivo de una Canon EOS 6D (o cualquier cámara compatible) directo al navegador, con capacidad de proyectar a dispositivos Chromecast / DLNA y grabar con OBS u otras herramientas.

---

## Requisitos

### Hardware

- Cámara Canon EOS 6D (u otra cámara compatible con EOS Webcam Utility)
- Cable USB para conectar la cámara a la PC

### Software

| Herramienta | Propósito |
|---|---|
| **EOS Webcam Utility Pro** | Driver que convierte la cámara Canon en webcam |
| **Navegador** | Chrome, Edge u Opera (recomendados) |
| **Python 3** o **Node.js** | Servidor local (alternativa al .bat) |
| **[OBS Studio]** | Grabación / streaming avanzado |
| Node.js `npx serve` | Alternativa rápida al servidor local |

[OBS Studio]: https://obsproject.com/

---

## 1. Instalación de Drivers

### EOS Webcam Utility Pro

1. Descarga desde: https://www.canon.com.mx/eos-webcam-utility/
2. Ejecuta el instalador y sigue los pasos.
3. Conecta la cámara por USB.
4. Enciende la cámara en modo **Video** (la perilla en el ícono de videocámara).
5. En Windows aparecerá como dispositivo de video "EOS Webcam Utility".

> **Nota para macOS/Linux**: Este proyecto está pensado para Windows.  
> En macOS puedes usar [Camo](https://reincubate.com/camo/) o [OBS Virtual Camera](https://obsproject.com/).  
> En Linux, usa `v4l2loopback` + `gphoto2`.

### Verificar instalación

1. Abre Discord, Zoom, o Teams.
2. En configuración de video, busca "EOS Webcam Utility".
3. Si aparece, el driver está instalado correctamente.

---

## 2. Servidor Local

El sitio necesita un servidor HTTP local (no funciona abriendo `feed.html` directo por `file://`).

### Opción A — Script incluido (Windows)

Haz doble clic en **`server.bat`** o ejecuta en terminal:

```powershell
.\server.ps1
```

Abre: http://localhost:8080/feed.html

### Opción B — Python (cualquier SO)

```bash
cd ruta/al/proyecto
python -m http.server 8080
```

Abre: http://localhost:8080/feed.html

### Opción C — Node.js

```bash
cd ruta/al/proyecto
npx serve .
```

Abre la URL que aparezca en terminal.

---

## 3. Uso del Sitio

1. Abre http://localhost:8080/feed.html
2. El navegador pedirá permiso para usar la cámara → **Permitir**.
3. Selecciona **"EOS Webcam Utility"** del menú desplegable.
4. Haz clic en **▶ Iniciar feed**.
5. Aparecerá el feed en vivo. Controles disponibles:

| Control | Función |
|---|---|
| ▶ Iniciar feed | Activa la transmisión de la cámara |
| ⏹ Detener | Detiene el feed |
| 📸 Captura | Descarga una foto (PNG) del frame actual |
| ⛶ Pantalla completa | Expande el video al monitor completo |
| 🔄 Refrescar | Re-detecta dispositivos |

---

## 4. Transmitir a Chromecast / Smart TV (Cast)

Existen dos formas de proyectar el feed en vivo a un televisor o Chromecast.

### Opción A — Cast desde el navegador (recomendado)

1. Abre el feed en **Chrome** o **Edge**.
2. Haz clic en el menú ⋮ → **Transmitir** (Cast).
3. Selecciona tu dispositivo Chromecast o Smart TV.
4. Elige **"Transmitir pestaña"** (la calidad dependerá de tu red).

### Opción B — Usando OBS + Virtual Camera (más estable)

1. Abre OBS Studio.
2. Agrega fuente **"Dispositivo de captura de video"** → elige **"EOS Webcam Utility"**.
3. Inicia **Virtual Camera** (Tools → Virtual Camera → Start).
4. Abre Chrome, agrega la fuente de captura "OBS Virtual Camera" en una pestaña.
5. Transmite esa pestaña a tu Chromecast.

### Opción C — DLNA / UPnP

Con el feed en vivo en el navegador:
- **Chrome** no soporta DLNA nativo. Usa Cast (Opción A).
- Alternativa: usa [Unified Remote](https://www.unifiedremote.com/) o un servidor DLNA como [Universal Media Server](https://www.universalmediaserver.com/) que pueda capturar la ventana.

> **Consejo**: Para mínima latencia, conecta el TV por HDMI en vez de usar Cast.

---

## 5. Grabación con OBS Studio

### Configuración

1. Abre **OBS Studio**.
2. En **Fuentes** → **+** → **Dispositivo de captura de video**.
3. Selecciona **"EOS Webcam Utility"**.
4. Ajusta resolución (1920×1080 recomendado).

### Ajustes recomendados

| Parámetro | Valor |
|---|---|
| Resolución base | 1920×1080 |
| FPS | 30 o 60 |
| Codificador | Hardware (NVENC / AMD / Intel) |
| Formato de grabación | MP4 (o MKV si hay cortes) |
| Ruta de salida | Elige una carpeta de destino |

### Iniciar grabación

- Haz clic en **"Iniciar grabación"** en OBS.
- Para detener, haz clic en **"Detener grabación"**.
- El archivo se guarda en la ruta configurada (Archivo → Configuración → Salida).

### Grabación directa del feed (sin OBS)

Si prefieres no usar OBS, abre el feed en el navegador, posiciónalo en la pantalla y graba con herramientas como:

- [Windows Game Bar](https://support.microsoft.com/windows/win-keyboard-shortcuts-in-game-bar) (Win+G)
- [ShareX](https://getsharex.com/)
- [FFmpeg](https://ffmpeg.org/) desde terminal

#### Ejemplo con FFmpeg (captura de escritorio):

```bash
ffmpeg -f gdigrab -framerate 30 -i title="EOS 6D — Live Feed" -c:v libx264 output.mp4
```

---

## 6. Solución de Problemas

### "No se detectó ninguna cámara"

1. Verifica que **EOS Webcam Utility Pro** esté instalado.
2. Asegúrate de que la cámara esté encendida **en modo Video**.
3. Prueba en Discord o Zoom para confirmar que funcione.
4. Reinicia el navegador y da clic en **"Permitir"** cuando pida la cámara.
5. Si usas `file://`, **no funciona**. Debes usar el servidor local.

### Error de permisos en el navegador

- Haz clic en el icono de candado 🔒 en la barra de direcciones.
- Busca "Cámara" y cambia a **Permitir**.
- Recarga la página.

### Latencia alta en Cast

- Conecta el TV por cable HDMI si es posible.
- Reduce la resolución del feed (modifica `width: { ideal: 1280 }` en `feed.html:322`).
- Usa OBS con Virtual Camera en vez de transmitir la pestaña.

### El feed se ve congelado o entrecortado

- Baja los FPS en `feed.html:324` (cambia `60` por `30`).
- Cierra otros programas que usen la cámara.
- Usa un cable USB 3.0 si está disponible.

---

## Estructura del Proyecto

```
eos/
├── cam.html          # Visor simple de cámara (sin controles)
├── feed.html         # Visor completo con selección de cámara y capturas
├── server.ps1        # Servidor HTTP en PowerShell
├── server.bat        # Acceso directo al servidor
└── README.md         # Este archivo
```

---

## Licencia

MIT
