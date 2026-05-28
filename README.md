# Unraid Beyond Compare 5 (KasmVNC)

This repository provides an automated build chain to create a modern, Unraid-compatible Docker container for **Beyond Compare 5**. 

It wraps the official Beyond Compare Linux `.deb` package inside LinuxServer's highly optimized `baseimage-kasmvnc` (Ubuntu Noble), providing a fast, sharp, and feature-rich web GUI accessible directly from your browser.

## Why build it this way?
1. The repository hosts **no proprietary code**.
2. GitHub Actions automatically downloads the stock evaluation `.deb` directly from Scooter Software's official servers during the build process.
3. The automated pipeline builds the container and pushes it to your personal Docker Hub account.
4. You apply your own valid license key through the WebUI, which is saved safely to your local Unraid array.

---

## ⚙️ Setting Up the Automated Build Chain

To compile this image and push it to your own Docker Hub account, follow these steps:

### 1. Prepare Docker Hub
1. Create a free account on [Docker Hub](https://hub.docker.com/).
2. Create a new **Public Repository** named `beyondcompare`.
3. Go to **Account Settings > Personal Access Tokens** and generate a new token with "Read & Write" permissions. **Copy this token.**

### 2. Configure GitHub Secrets
1. Fork or clone this repository to your own GitHub account.
2. In your GitHub repository, go to **Settings > Secrets and variables > Actions**.
3. Create the following two **New repository secrets**:
   * `DOCKERHUB_USERNAME`: Your exact Docker Hub username.
   * `DOCKERHUB_TOKEN`: The Access Token you copied from Docker Hub.

### 3. Trigger the Build
1. Go to the **Actions** tab in your GitHub repository.
2. Select the **Build and Push to Docker Hub** workflow on the left.
3. Click **Run workflow**. 

GitHub will now spin up a virtual environment, pull the latest KasmVNC base image, download Beyond Compare 5, compile the Docker container, and push the finished `latest` tag to your Docker Hub account. This will happen automatically anytime you update the `Dockerfile`.

---

## 🚀 Installing on Unraid

To make this container behave like a native Unraid application (with an icon, predefined ports, and variable descriptions), you need to use the provided XML template.

1. Download the `beyond-compare.xml` file from this repository.
2. Place the XML file on your Unraid flash drive in the following directory:
   `/boot/config/plugins/dockerMan/templates-user/`
3. In the Unraid WebGUI, go to the **Docker** tab and click **Add Container**.
4. Select `BeyondCompare` from the **Template** dropdown at the top.
5. **Important:** Change the **Repository** field to point to your newly built image: 
   `your-dockerhub-username/beyondcompare:latest`
6. Click **Apply**.

### Volume Mappings
* `/config`: Maps to your `appdata` share. This stores your Beyond Compare license key and session settings permanently.
* `/storage`: Maps to your Unraid array (e.g., `/mnt/user/`). This grants the container access to the files you want to compare.

---

## 🔑 Licensing

Once the container is running:
1. Open the WebUI via the Unraid Docker tab (default port `3000`).
2. Inside Beyond Compare, click **Help > Enter Key...**
3. Paste your valid Beyond Compare 5 license key. 

Because `/config` is mapped to your Unraid array, your registration will persist across container reboots and image updates.

---

## ⚖️ Legal & Disclaimer

**Code & Templates (MIT License):** The `Dockerfile`, GitHub Actions workflow, and Unraid `XML` template provided in this repository are open-source and released under the [MIT License](LICENSE). You are free to use, modify, and distribute them.

**Beyond Compare (Proprietary):** Beyond Compare is proprietary software owned by [Scooter Software](https://www.scootersoftware.com/). This repository is not affiliated with, endorsed by, or sponsored by Scooter Software. Users are solely responsible for ensuring their use of Beyond Compare complies with Scooter Software's End User License Agreement (EULA).
