# ai-dash-hub-lite

A minimal local AI stack with workflow automation, local LLMs, and a simple dashboard portal.

---

## 🚀 Quick Start

1. **Copy the environment file:**
   
   ```sh
   cp .env.example .env
   # Or copy manually on Windows
   ```
   Edit `.env` if you want to change image versions or passwords.

2. **Start the stack:**
   
   ```sh
   docker compose -f docker-compose.basic.yml up -d
   ```


3. **Access the portal:**

   - Dashboard Portal: [http://localhost:53000](http://localhost:53000)
   - n8n: [http://localhost:53001](http://localhost:53001)
   - Open WebUI: [http://localhost:53002](http://localhost:53002)
   - Ollama API: [http://localhost:53003](http://localhost:53003)

   > **After opening n8n and Open WebUI for the first time, you will be prompted to create a new user account for each.**

---

## 🛠️ Services

- **n8n** — Workflow automation and AI agent orchestration
- **Ollama** — Local LLM runner (GPU optional)
- **Open WebUI** — Chat UI for Ollama
- **Cloudflared** — (Optional) Expose your stack securely via Cloudflare Tunnel
- **ai-dash-hub-lite** — Simple dashboard portal

---


## ⚡ GPU Support

To enable GPU support for Ollama (NVIDIA only):


1. Make the script executable (if needed):

   ```sh
   chmod +x enable-gpu.sh
   ./enable-gpu.sh
   ```

   This will detect your environment (Ubuntu, Debian, or WSL), install the NVIDIA Container Toolkit, and set `AI_GHOST_HUB_LITE_GPU=true` in your `.env` file.

2. If you installed new drivers, reboot your system before starting the stack.

3. Start the stack as usual:

   ```sh
   docker compose up -d
   ```

> For WSL: Make sure you have the latest NVIDIA drivers installed on Windows, then restart WSL (`wsl --shutdown`).

---

## 🌐 Cloudflare Tunnel (Optional)

- Set your Cloudflare Tunnel token in `.env` to expose your stack securely to the internet.

---

## 🧹 Stopping & Cleanup

```sh
docker compose -f docker-compose.basic.yml down
```

---

## 📁 Folder Structure

- `docker-compose.basic.yml` — Main compose file
- `.env.example` — Example environment file
- `ai-dash-hub-lite/` — Portal dashboard static files

---

Enjoy your local AI stack!