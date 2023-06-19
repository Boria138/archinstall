nvidia_check_arch(){
    if  [[ $(lspci | grep "VGA\|3D" | sed -rn 's/.*(NVIDIA).*/\1/p') ]]; then
        [[ $(lspci | grep VGA | sed -rn 's/.*(G[0-9]*).*/\1/p') == G[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(GT[0-9]*).*/\1/p') == GT[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(MCP[0-9]*).*/\1/p') == MCP[0-9]* ]] && nv_arch=Tesla
        [[ $(lspci | grep VGA | sed -rn 's/.*(GF[0-9]*).*/\1/p') == GF[0-9]* ]] && nv_arch=Fermi
        [[ $(lspci | grep VGA | sed -rn 's/.*(GK[0-9]*).*/\1/p') == GK[0-9]* ]] && nv_arch=Kepler
        [[ $(lspci | grep VGA | sed -rn 's/.*(GM[0-9]*).*/\1/p') == GM[0-9]* ]] && nv_arch=Maxwell
        [[ $(lspci | grep VGA | sed -rn 's/.*(GP[0-9]*).*/\1/p') == GP[0-9]* ]] && nv_arch=Pascal
        [[ $(lspci | grep VGA | sed -rn 's/.*(GV[0-9]*).*/\1/p') == GV[0-9]* ]] && nv_arch=Volta
        [[ $(lspci | grep VGA | sed -rn 's/.*(TU[0-9]*).*/\1/p') == TU[0-9]* ]] && nv_arch=Turing
        [[ $(lspci | grep VGA | sed -rn 's/.*(GA[0-9]*).*/\1/p') == GA[0-9]* ]] && nv_arch=Ampere
        [[ $(lspci | grep VGA | sed -rn 's/.*(AD[0-9]*).*/\1/p') == AD[0-9]* ]] && nv_arch=Ada_Lovelace
    fi
}

nvidia_check_arch

if [[ -n "$nv_arch" ]]; then
    # Proprietary nvidia drivers
    if [[ $nv_arch == Maxwell || $nv_arch == Pascal || $nv_arch == Volta || $nv_arch == Turing || $nv_arch == Ampere || $nv_arch == Ada_Lovelace || $nv_arch == Fermi ]]; then
          # Windows games tweaks
          export __GL_MaxFramesAllowed=3
          export __GL_YIELD="USLEEP"
          export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
          # Hardware video acceleration 
          export VDPAU_DRIVER=nvidia
          export LIBVA_DRIVER_NAME=nvidia
          export NVD_BACKEND=direct
          export MOZ_DISABLE_RDD_SANDBOX=1
          # Preventing kernel panic 
          sysctl -w vm.panic_on_oom=0
    elif [[ $nv_arch == Kepler ]]; then
            # The Kepler architecture requires __EGL_VENDOR_LIBRARY_FILENAMES for video hardware acceleration to work  
            export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json
            export __GL_MaxFramesAllowed=3
            export __GL_YIELD="USLEEP"
            export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
            export VDPAU_DRIVER=nvidia
            export LIBVA_DRIVER_NAME=nvidia
            export NVD_BACKEND=direct
            export MOZ_DISABLE_RDD_SANDBOX=1
            sysctl -w vm.panic_on_oom=0
    else
        # Nouveau
        export VDPAU_DRIVER=nouveau
        export LIBVA_DRIVER_NAME=nouveau
    fi
fi


