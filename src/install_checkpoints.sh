#!/bin/bash

mkdir -p ./models/clip/
mkdir -p ./models/clip_vision/
mkdir -p ./models/ipadapter/
mkdir -p ./models/upscale_models/
mkdir -p ./models/text_encoders/
mkdir -p ./models/loras/


#anima-base-1.0
wget -c https://civitai.red/api/download/models/2967640?fileId=2847103 -P .models/checkpoints/
wget -c https://civitai.red/api/download/models/2967640?fileId=2847092 -P .models/text_encoders/
wget -c https://civitai.red/api/download/models/3049284?fileId=2934431 -P .models/checkpoints/

# Loras

wget -c https://civitai.red/api/download/models/3052892?fileId=2931603 -P .models/loras/
wget -c https://civitai.red/api/download/models/2945421?fileId=2824598 -P .models/loras/
wget -c https://civitai.red/api/download/models/3083706?fileId=2963073 -P .models/loras/
wget -c https://civitai.red/api/download/models/3036905?fileId=2915794 -P .models/loras/
wget -c https://civitai.red/api/download/models/3087329?fileId=2966811 -P .models/loras/
wget -c https://civitai.red/api/download/models/3089149?fileId=2968664 -P .models/loras/
wget -c https://civitai.red/api/download/models/3017358?fileId=2896293 -P .models/loras/
wget -c https://civitai.red/api/download/models/3068784?fileId=2947506 -P .models/loras/
wget -c https://civitai.red/api/download/models/2962831?fileId=2842131 -P .models/loras/
wget -c https://civitai.red/api/download/models/3057337?fileId=2936001 -P .models/loras/
wget -c https://civitai.red/api/download/models/3088048?fileId=2967536 -P .models/loras/
wget -c https://civitai.red/api/download/models/3099910?fileId=2979620 -P .models/loras/
wget -c https://civitai.red/api/download/models/3038905?fileId=2917772 -P .models/loras/
wget -c https://civitai.red/api/download/models/3045824?fileId=2924551 -P .models/loras/
wget -c https://civitai.red/api/download/models/3101268?fileId=2981035 -P .models/loras/


## ControlNet SDXL
#wget https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors -P ./models/controlnet/
#wget https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors -P ./models/controlnet/
#wget https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-recolor-rank256.safetensors -P ./models/controlnet/
#wget https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-sketch-rank256.safetensors -P ./models/controlnet/
#wget -O ./models/controlnet/depth-sdxl-1.0-diffusion_pytorch_model.bin https://huggingface.co/diffusers/controlnet-depth-sdxl-1.0-mid/resolve/main/diffusion_pytorch_model.bin

#vae
wget https://civitai.red/api/download/models/2967640?fileId=2847091 -P ./models/vae/
#wget -O ./models/controlnet/vae_sdxl-1.0-inpainting-0.1.safetensors https://huggingface.co/diffusers/stable-diffusion-xl-1.0-inpainting-0.1/resolve/main/vae/diffusion_pytorch_model.safetensors

# clip vision
## SDXL
#wget -O  ./models/clip_vision/SDXL_CLIP-ViT-bigG-14-laion2B-39B-b160k.safetensors   https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/image_encoder/model.safetensors
## SD1.5
wget -O  ./models/clip_vision/SD15_CLIP-ViT-bigG-14-laion2B-39B-b160k.safetensors   https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors


# upscaler
wget https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NickelbackFS_72000_G.pth -P  ./models/upscale_models
wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth -P ./models/upscale_models/

# 1. RealESRGAN anime 6B - default bagus untuk anime
wget -O ./models/upscale_models/RealESRGAN_x4plus_anime_6B.pth \
"https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth"

# 2. 4x-AnimeSharp
wget -O ./models/upscale_models/4x-AnimeSharp.pth \
"https://huggingface.co/utnah/esrgan/resolve/main/4x-AnimeSharp.pth?download=true"

# 3. 4x IllustrationJaNai V1 ESRGAN
wget -O ./models/upscale_models/4x_IllustrationJaNai_V1_ESRGAN_135k.pth \
"https://huggingface.co/easygoing0114/AI_upscalers/resolve/main/4x_IllustrationJaNai_V1_ESRGAN_135k.pth?download=true"

# 4. 4x-UltraSharp
wget -O ./models/upscale_models/4x-UltraSharp.pth \
"https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth?download=true"

# 5. 4x_NMKD-Siax_200k
wget -O ./models/upscale_models/4x_NMKD-Siax_200k.pth \
"https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth?download=true"

# segment anything
## GroundingDINO_SwinT_OGC
#wget https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/GroundingDINO_SwinT_OGC.cfg.py -P ./models/grounding-dino/
#wget https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/groundingdino_swint_ogc.pth  -P ./models/grounding-dino/
##GroundingDINO_SwinB
#wget https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/GroundingDINO_SwinB.cfg.py -P ./models/grounding-dino/
#wget https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/groundingdino_swinb_cogcoor.pth -P ./models/grounding-dino/
#
###sam_vit_h
#wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth -P ./models/sams/
####sam_vit_l
#wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_l_0b3195.pth -P ./models/sams/
####  sam_vit_b
#wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth -P ./models/sams/
#### sam_hq_vit_h
#wget https://huggingface.co/lkeab/hq-sam/resolve/main/sam_hq_vit_h.pth -P ./models/sams/
#### sam_hq_vit_l
#wget https://huggingface.co/lkeab/hq-sam/resolve/main/sam_hq_vit_l.pth -P ./models/sams/
####sam_hq_vit_b
#wget https://huggingface.co/lkeab/hq-sam/resolve/main/sam_hq_vit_b.pth -P ./models/sams/
####mobile_sam
#wget https://github.com/ChaoningZhang/MobileSAM/blob/master/weights/mobile_sam.pt -P ./models/sams/
