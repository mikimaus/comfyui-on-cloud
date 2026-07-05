#!/bin/bash
set -e

# Run from ComfyUI root folder
cd "$(dirname "$0")"

echo "== Creating model folders =="
mkdir -p ./custom_nodes
mkdir -p ./models/diffusion_models
mkdir -p ./models/text_encoders
mkdir -p ./models/vae
mkdir -p ./models/controlnet
mkdir -p ./models/upscale_models
mkdir -p ./models/facerestore_models
mkdir -p ./workflows

clone_or_update() {
  REPO_URL="$1"
  TARGET_DIR="$2"

  if [ -d "$TARGET_DIR/.git" ]; then
    echo "== Updating $TARGET_DIR =="
    git -C "$TARGET_DIR" pull
  else
    echo "== Cloning $REPO_URL =="
    git clone --depth 1 "$REPO_URL" "$TARGET_DIR"
  fi
}

install_requirements_if_exists() {
  TARGET_DIR="$1"

  if [ -f "$TARGET_DIR/requirements.txt" ]; then
    echo "== Installing requirements for $TARGET_DIR =="
    python -m pip install -r "$TARGET_DIR/requirements.txt"
  fi
}

echo "== Updating ComfyUI =="
git pull || true
python -m pip install -r requirements.txt

# ---------------------------------------------------------
# COMFYUI MANAGER
# ---------------------------------------------------------
clone_or_update "https://github.com/ltdrdata/ComfyUI-Manager.git" \
  "custom_nodes/ComfyUI-Manager"
install_requirements_if_exists "custom_nodes/ComfyUI-Manager"

# ---------------------------------------------------------
# ANIMA BASE v1.0 OFFICIAL MODEL FILES
# ---------------------------------------------------------
echo "== Downloading Anima Base v1.0 files =="

wget -c -O ./models/diffusion_models/anima-base-v1.0.safetensors \
"https://huggingface.co/circlestone-labs/Anima/resolve/main/anima-base-v1.0.safetensors?download=true"

wget -c -O ./models/text_encoders/qwen_3_06b_base.safetensors \
"https://huggingface.co/circlestone-labs/Anima/resolve/main/qwen_3_06b_base.safetensors?download=true"

wget -c -O ./models/vae/qwen_image_vae.safetensors \
"https://huggingface.co/circlestone-labs/Anima/resolve/main/qwen_image_vae.safetensors?download=true"

# Official Anima workflows
wget -c -O ./workflows/image_anima_base_v1.json \
"https://raw.githubusercontent.com/Comfy-Org/workflow_templates/main/templates/image_anima_base_v1.json"

wget -c -O ./workflows/image_anima_preview.json \
"https://raw.githubusercontent.com/Comfy-Org/workflow_templates/main/templates/image_anima_preview.json"

# ---------------------------------------------------------
# ANIMA CONTROL / LLLITE
# Use this instead of SD1.5 ControlNet for Anima.
# ---------------------------------------------------------
clone_or_update "https://github.com/kohya-ss/ComfyUI-Anima-LLLite.git" \
  "custom_nodes/ComfyUI-Anima-LLLite"
install_requirements_if_exists "custom_nodes/ComfyUI-Anima-LLLite"

wget -c -O ./models/controlnet/anima-lllite-inpainting-v2.safetensors \
"https://huggingface.co/kohya-ss/Anima-LLLite/resolve/main/anima-lllite-inpainting-v2.safetensors?download=true"

wget -c -O ./models/controlnet/anima-lllite-any-test-like-v2.safetensors \
"https://huggingface.co/kohya-ss/Anima-LLLite/resolve/main/anima-lllite-any-test-like-v2.safetensors?download=true"

# ---------------------------------------------------------
# CONTROLNET AUX PREPROCESSORS
# Useful for lineart, depth, pose, scribble preprocessors.
# The preprocessors are useful; old sd15 ControlNet weights are not for Anima.
# ---------------------------------------------------------
clone_or_update "https://github.com/Fannovel16/comfyui_controlnet_aux.git" \
  "custom_nodes/comfyui_controlnet_aux"
install_requirements_if_exists "custom_nodes/comfyui_controlnet_aux"

# ---------------------------------------------------------
# IMPACT PACK
# Useful for detection, masks, SEGS, detailer workflows.
# ---------------------------------------------------------
clone_or_update "https://github.com/ltdrdata/ComfyUI-Impact-Pack.git" \
  "custom_nodes/ComfyUI-Impact-Pack"

if [ -f "custom_nodes/ComfyUI-Impact-Pack/install.py" ]; then
  python custom_nodes/ComfyUI-Impact-Pack/install.py
fi

# ---------------------------------------------------------
# GENERIC UTILITY NODES
# ---------------------------------------------------------
clone_or_update "https://github.com/WASasquatch/was-node-suite-comfyui.git" \
  "custom_nodes/was-node-suite-comfyui"
install_requirements_if_exists "custom_nodes/was-node-suite-comfyui"

clone_or_update "https://github.com/WASasquatch/WAS_Extras.git" \
  "custom_nodes/WAS_Extras"

if [ -f "custom_nodes/WAS_Extras/install.py" ]; then
  python custom_nodes/WAS_Extras/install.py
fi

clone_or_update "https://github.com/palant/image-resize-comfyui.git" \
  "custom_nodes/image-resize-comfyui"
install_requirements_if_exists "custom_nodes/image-resize-comfyui"

clone_or_update "https://github.com/comfyorg/comfyui-essentials.git" \
  "custom_nodes/comfyui-essentials"
install_requirements_if_exists "custom_nodes/comfyui-essentials"

# ---------------------------------------------------------
# RES4LYF
# Optional but useful because Anima model card mentions beta57 scheduler
# for more painterly/realistic texture experiments.
# ---------------------------------------------------------
clone_or_update "https://github.com/ClownsharkBatwing/RES4LYF.git" \
  "custom_nodes/RES4LYF"
install_requirements_if_exists "custom_nodes/RES4LYF"

# ---------------------------------------------------------
# IPADAPTER
# Not Anima-native. Keep only if you also use SD1.5/SDXL/other workflows.
# ---------------------------------------------------------
clone_or_update "https://github.com/comfyorg/comfyui-ipadapter.git" \
  "custom_nodes/comfyui-ipadapter"
install_requirements_if_exists "custom_nodes/comfyui-ipadapter"

# ---------------------------------------------------------
# FACE RESTORE / FACE SWAP
# Works as image post-processing, not Anima-native conditioning.
# ---------------------------------------------------------
clone_or_update "https://github.com/Gourieff/comfyui-reactor-node.git" \
  "custom_nodes/comfyui-reactor-node"

if [ -f "custom_nodes/comfyui-reactor-node/install.py" ]; then
  python custom_nodes/comfyui-reactor-node/install.py
fi

wget -c -O ./models/facerestore_models/codeformer.pth \
"https://github.com/sczhou/CodeFormer/releases/download/v0.1.0/codeformer.pth"

wget -c -O ./models/facerestore_models/GFPGANv1.4.pth \
"https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth"

# Optional standalone face restore node
clone_or_update "https://github.com/mav-rik/facerestore_cf.git" \
  "custom_nodes/facerestore_cf"
install_requirements_if_exists "custom_nodes/facerestore_cf"

# ---------------------------------------------------------
# UPSCALERS FOR ANIME / ILLUSTRATION
# These are image upscalers, so compatible after VAE Decode.
# ---------------------------------------------------------
wget -c -O ./models/upscale_models/RealESRGAN_x4plus_anime_6B.pth \
"https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth"

wget -c -O ./models/upscale_models/4x-AnimeSharp.pth \
"https://huggingface.co/utnah/esrgan/resolve/main/4x-AnimeSharp.pth?download=true"

wget -c -O ./models/upscale_models/4x_IllustrationJaNai_V1_ESRGAN_135k.pth \
"https://huggingface.co/easygoing0114/AI_upscalers/resolve/main/4x_IllustrationJaNai_V1_ESRGAN_135k.pth?download=true"

wget -c -O ./models/upscale_models/4x-UltraSharp.pth \
"https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth?download=true"

wget -c -O ./models/upscale_models/4x_NMKD-Siax_200k.pth \
"https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth?download=true"

# ---------------------------------------------------------
# SDXL PROMPT STYLER
# Not recommended for Anima by default.
# Anima uses Danbooru-style tags + natural language; SDXL styler can make prompts less optimal.
# Uncomment only if you still use SDXL workflows.
# ---------------------------------------------------------
# clone_or_update "https://github.com/twri/sdxl_prompt_styler.git" \
#   "custom_nodes/sdxl_prompt_styler"
# install_requirements_if_exists "custom_nodes/sdxl_prompt_styler"

echo "== Done =="
echo "Restart ComfyUI after installation."
