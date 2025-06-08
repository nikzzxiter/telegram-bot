#!/system/bin/sh

echo "Mereset pengaturan performa..."

# Mengembalikan mode daya ke default
cmd power set-mode 0
settings put global low_power 0

# Mengembalikan pengaturan animasi
settings put global window_animation_scale 1
settings put global transition_animation_scale 1
settings put global animator_duration_scale 1

# Mengembalikan pengaturan GPU
settings put global gpu_renderer "default"
settings put global force_hw_ui 0

# Mengembalikan pengaturan sensitivitas layar
settings put global touch_sensitivity_mode 0

# Mengembalikan mode CPU
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

# Mengembalikan semua aplikasi yang dinonaktifkan
for pkg in $(pm list packages -d); do
    pm enable ${pkg#package:}
done

echo "Reset performa selesai!"
