# Check amdgpu module
if [[ -d /sys/module/amdgpu ]]; then 
	export RADV_PERFTEST=gpl
	# Checking RDNA-series chips
	if [[ $(lspci -k | grep -EA3 "3D | VGA" | grep -o "\].*\[" | cut -c 3- | sed -r 's/(.+).{1}/\1/') = $(grep -Pio 'Navi 10|Navi 12|Navi 14|Navi 21|Navi 22|Navi 23|Navi 24|Navi 31|Navi 33') ]]; then
		# Enabling wave32 short instructions, wave64 for rt, experimental video decoding support, NGG Streamout, Graphics Pipeline Library
		export RADV_PERFTEST+=,cswave32,gewave32,video_decode,ngg_streamout,rt
	fi
fi

# Check Intel i915 module
if [[ -d /sys/module/i915 ]]; then
    # Enable Graphics Pipeline Library support on Intel ANV Vulkan driver
    export ANV_GPL=true
    # See https://wiki.archlinux.org/title/Intel_graphics#Font_and_screen_corruption_in_GTK_applications_(missing_glyphs_after_suspend/resume)
    export COGL_ATLAS_DEFAULT_BLIT_MODE=framebuffer
    # Fixes performance issues
    sysctl -w dev.i915.perf_stream_paranoid=0
fi
